Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07303171CD
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Apr 2026 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775943066; cv=none; b=aB0ZPG1Gg0tBb0pvoM+ytrXFUX+ST2cQU3TGvaF9vjasrp80472Nwvwz4RTHOMCz2je6XKq6NrI6B7eJHTPmdziW7JmfnYPojUuxJhSrE2mBv1jC5y3eybwbSTKxSCFV3GDmBGv4yhDy0U8qMlpgZyA8rAircbfxxLeacFHThLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775943066; c=relaxed/simple;
	bh=3ZgJyDSc6pt3nRBSROV8yupF9XyeCk9g0O+vCXVt928=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6IbHrBU7GdzTWllJUJ7oFo6LYFTgdAPZPOWcrtfeljME44UXS08bSMAHrhTBPD6iBr+ARBc30PVH5Zv4VqTOEqYA1p2lzg1zGLKNOH6BCgZq6jNeN8gUFf0MjthQbUWOlCp9v09/R2PS4gfTZKvNT1h3s+PFceN2/9A9NLcGNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SMOv4q98; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SMOv4q98"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0CyM3htPt9P9McAHHSzvssQ7o1JQCdNYPybcy4Kk5ls=; b=SMOv4q98AKOnPYh2aOXLia32ho
	L1HIJtZd4h2NVlQfO4e0JekT6Uq/jjAIyGaNtChxGv8u0mCTyUStyNX974ApFStXKyX0ZFC5it342
	BTWXou8JbrQ5DZq847VVdOhJbOXZUsWmJyDEh8vFgaxSNzFIuInmbi8qXTWkCD/xYLcLBkwfYughR
	hXV6nip4xVUSBYuR/gGLgvyBSleXhntLwIN38qPllSY73qdKenQgnBE7jWbjqFLJA2esoILcY4wDF
	3zWlG4sqBC3bMAUhki5Q188h6DWOsFkHDAmMQntmlf6Z/slUwWeJDRDgpNILcm3Kz6YyacCjCIPdw
	TSi5rloQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wBfyg-0000000A98G-3XZ3;
	Sat, 11 Apr 2026 21:34:55 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH 01/11] shrink_dentry_list(): start with removing from shrink list
Date: Sat, 11 Apr 2026 22:34:44 +0100
Message-ID: <20260411213454.2418381-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260411213348.GB3836593@ZenIV>
References: <20260411213348.GB3836593@ZenIV>
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
 fs/dcache.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 0c8faeee02e2..6492120ea060 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1207,19 +1207,18 @@ void shrink_dentry_list(struct list_head *list)
 
 		dentry = list_entry(list->prev, struct dentry, d_lru);
 		spin_lock(&dentry->d_lock);
+		d_shrink_del(dentry);
+		if (unlikely(dentry->d_flags & DCACHE_DENTRY_KILLED)) {
+			dentry_free(dentry);
+			spin_unlock(&dentry->d_lock);
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

