Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BFB26A0A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=BHdeOvn53WUfIcCEwuFYhMoeqfG7a1Gb/wP/e8cS6ZVkttPbxxc0wTRXMxSzeseuTAB/o/gHl0X3kGYCNo9ieDfps/dTlhKyv4snpLjGWbprKn4MCpPdIn47jLuDIcytELsrjNgNZ3JQVNnjRmBE66GpfgflFtKg79Pax/7OcXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=SgBceMkQVJi9P+O0taxvzpIL9T10VB7Et8RbH267PNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dnCYh2F5G+CBWClrc2f5CgYH/A3VQlp0KHNIOnmaW6oZqmImnEpz3DQpkmpg9BnVUmojNfs6ozLFxClRvLUlv2TzIuUcLq7BzgZkURQxTAUjq2i4GTWkz62FVEOb0BcszOJ4YbpJX4JKPj5X2HGsDqsIW0FhWOpUL9MqU0vkcrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=qn+0FBI1; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="qn+0FBI1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Mu/OGoWxJlzGVit5rsNo3hC3bA2p1iyd2I8vIfjCznE=; b=qn+0FBI1kwTlEtbMAD7Ek/nJYR
	gxVoMRVdLMo/0i9fpnt9KBiUHhC7qwAOHcdqQ7sMAUmiUQCxGDfDhUeqWxz4o1gKky9u7MTcWKnvW
	/A1rNK891x4KKeo5YBiZ0/JavhOXURwhJiFCfamTgyd5QGgNmYLSkU4Qx0C5v0U5GaI2T2LZXWiMK
	v8/B7mRbJFVIdgjVMNcLmfjGA4gRzBGYnMEFtF+4s2bRwVgbRYKlrbIZqmdsTXVW7QZ+BjQmxsKKt
	+4/Hm0MDZ2fF2s1mOJW3YTAkpKwjPHl4kHOSxFwJAVpFdLf/wwomMUVOhfJnAmhA5ayBu8zQ8tNzS
	7pKs7N0w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005Tss-2A7C;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 09/22] shrink_dentry_list(): start with removing from shrink list
Date: Fri,  5 Jun 2026 06:08:57 +0100
Message-ID: <20260605050910.1306432-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
 <20260605050910.1306432-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Currently we leave dentry on the list until we are done with
lock_for_kill().  That guarantees that it won't have been
even scheduled for removal until we remove it from the list
and drop ->d_lock.  We grab ->d_lock and rcu_read_lock()
and call lock_for_kill().  There are four possible cases:
	1) lock_for_kill() has succeeded; dentry and its inode
(if any) are locked, dentry refcount is zero and we can
remove it from shrink list and feed it to shrink_kill().
	2) lock_for_kill() fails since dentry has become busy.
Nothing to do, rcu_read_unlock(), remove from shrink list,
drop ->d_lock and move on.
	3) lock_for_kill() fails since dentry is currently
being killed - already entered __dentry_kill(), but hasn't
reached dentry_unlist() yet.  Nothing to do, we should just
do rcu_read_unlock(), remove from shrink list so that
whoever's executing __dentry_kill() would free it once they
are done, drop ->d_lock and move on - same actions as in
case (2).
	4) lock_for_kill() fails since dentry has been killed
(reached dentry_unlist(), DCACHE_DENTRY_KILLED set in ->d_flags).
In that case whoever had been killing it had already seen it
on our shrink list and skipped freeing it.  At that point it's
just a passive chunk of memory; rcu_read_unlock(), remove from
the list, drop ->d_lock and use dentry_free() to schedule
freeing.

While that works, there's a simpler way to do it:
	* grab ->d_lock
	* remove dentry from our shrink list
	* if DCACHE_DENTRY_KILLED is already set, drop ->d_lock,
call dentry_free() and move on.
	* otherwise grab rcu_read_lock() and call lock_for_free()
	* if lock_for_kill() succeeds, feed dentry
to shrink_kill(), otherwise drop the locks and move on.

The end result is equivalent to the old variant.  The only difference
arises if at the time we grab ->d_lock dentry had refcount 0 and
lock_for_kill() had failed spin_trylock() and had to drop and regain
->d_lock.  Otherwise nobody can observe at which point within the
unbroken ->d_lock scope dentry had been removed from the shrink list -
all accesses to ->d_lru are under ->d_lock.

If ->d_lock had been dropped and regained, it is possible for another
thread to feed that dentry to __dentry_kill(); if it doesn't get to
dentry_unlist() before we regain ->d_lock, behaviour is still identical -
it's case (3) and by the time __dentry_kill() would've gotten around
to checking if the victim is on shrink list, it would've been already
removed from ours.

If __dentry_kill() from another thread *does* get to dentry_unlist(),
in the old variant we would have __dentry_kill() leave calling
dentry_free() to us and in the new one __dentry_kill() would've called
dentry_free() itself.  Since we are under rcu_read_lock(), we are
guaranteed that actual freeing won't happen until we get around to
rcu_read_unlock().  IOW, the new variant is still safe wrt UAF, if
not for the same reason as the old one, and overall result is the same;
the only difference is which threads ends up scheduling the actual
freeing of dentry.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index b5604b84bafb..ffaaf48533e6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1228,19 +1228,19 @@ void shrink_dentry_list(struct list_head *list)
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
+		d_shrink_del(dentry);
+		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
+			spin_unlock(&dentry->d_lock);
+			dentry_free(dentry);
+			continue;
+		}
 		rcu_read_lock();
 		if (!lock_for_kill(dentry)) {
-			bool can_free;
-			rcu_read_unlock();
-			d_shrink_del(dentry);
-			can_free = dentry->d_flags & DCACHE_DENTRY_KILLED;
 			spin_unlock(&dentry->d_lock);
-			if (can_free)
-				dentry_free(dentry);
-			continue;
+			rcu_read_unlock();
+		} else {
+			shrink_kill(dentry);
 		}
-		d_shrink_del(dentry);
-		shrink_kill(dentry);
 	}
 }
 EXPORT_SYMBOL(shrink_dentry_list);
-- 
2.47.3

