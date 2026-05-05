Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842D3BE64C
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 05:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777960442; cv=none; b=lHDA4A8v2Uke2kWRgirJBlkaoEjm3bPk5WRE3Q6B/7x4ODVd4su8zYEVgB3PjeZwyu1QyBtQIeieqCpK2T9p9616o6Ih1BG3V2jqlyEYIMQaydQ4rPu0oWdI2esOe2gSGCUn0P1FHH7LBHXuCjX/Xe+k5bVof4R9yq0c8blepdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777960442; c=relaxed/simple;
	bh=rvpcFDQ9rDzZvWUeWqiSB4ZgyCJhSGPMxXOARDiLhPU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rn0Y8qgP0eoxLLGn/Jv7pqxo4bHKP508ItOtly/9cF/U/07Fsj+lSTVLVZwN0fzf0kAuAMNi+rF0Tc4owY7Z5QFyLa6j5FyGZs6dlAUHUzdTWKBrYL/B435h13HbDYK0EedNBfkBoq/eAhuNXub0kFuiJ2M4S4n7UrWHaJ0q7cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CYULT3OA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CYULT3OA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bixCXMxMq7wq4PVFVZfhGxi1NEboJmB7Zs3cWJreNHg=; b=CYULT3OAOhTEqm4sKVXzZ0NR1o
	FzuL4iw2GcY7IzumwecvzaxcQdZCdPVAyTX1NR3SPqlwaUa4ierIGVrjasHekqxcEYGTBHid/8DtM
	5cpLX3lJvrJ86BfI4ec1zTwB/IqZY1cEQD06NdUIN/y/If+kTjkvB8Xy93tld2oYwAcHQ9lCabSBU
	7nR7JsTf8ojqyZvYQsCWAXzEs8+wWZ2o/aLMjtAnP8Bi7T0Jpx2FUf/WbBp12f2AVsa1ZvKh1BvPq
	CyVpBvZgogyfEmfM9CVCVrRWz7sitJsrpgrvNQigDQsM1eL88GK7pfcK2SLiwoVD8k1IThiKkUX7o
	cl8AISfw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wK8jY-00000005I5u-0k9u;
	Tue, 05 May 2026 05:54:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [RFC PATCH 09/25] shrink_dentry_list(): start with removing from shrink list
Date: Tue,  5 May 2026 06:53:56 +0100
Message-ID: <20260505055412.1261144-10-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
References: <20260505055412.1261144-1-viro@zeniv.linux.org.uk>
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
	* if DCACHE_DENTRY_KILLED is already set, drop ->d_lock and move on.
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
index 34d57ed9d791..ee11171a75e6 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1228,19 +1228,19 @@ void shrink_dentry_list(struct list_head *list)
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
+		d_shrink_del(dentry);
+		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
+			dentry_free(dentry);
+			spin_unlock(&dentry->d_lock);
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

