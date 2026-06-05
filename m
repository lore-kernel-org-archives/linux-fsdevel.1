Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B9B2F7EF2
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636158; cv=none; b=rYZk8sP4xdon1nmo97GjpXtO9uCeCebwVHJ6H0jGAZi4SvkszObvcJ1Bv2x/QjOPYArvrJeYMZo68jcBdQYp1UJR91l4QsCJNphQJuGTFLFiJ1fc6qd0UaaOHUtXSO7SEXyW2Io1oz3BRpyTFz3A9hW9dK8NAwKteA9hmuMllwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636158; c=relaxed/simple;
	bh=FPgcvhLAZ4/jXrBHNJ/JvNmIYdfqaslhGzAKe2H0RlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMJXQyqSfqr8Zi0WG437SKPe9eHOYokhpvB37tkoRqxqXoDCbbS0OVUKsd33EH/rEWX9BzxDwwQLJRqYBukHzJCLSJMbaZgWgM+nt6DWVVl8smJ5ZLYiN87QFq64EtyAmAZOB1LbWT10JzMsYmnD9ZyUMBil1GeGjfDn8Jk+D2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=D8dClNko; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="D8dClNko"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oQjN/9ftluiPWxODEwhNCXzKZg2n/YGtj/wP0U0iO1Y=; b=D8dClNkoSDVP6lL6TYhD2xrz43
	DSVzHxXd3Iju13t4ZwvxfiwMKxHd5m83uOTmua9KUGoeK4L73p6yDD+ArN7OmhZtCxXY6NFAdJONJ
	hZ3EJXzi13e0DIqSisnzHA087Hdo5sTugDoPKkM2XlcLxltfn3I8FlM4WtEWSB5+8IXpA0xZaKr2X
	3b5IJXBKXDZTMCB6CP7IvNxF+qd2RkPbDGRwZnc3yEPpkMgzXiA+hkgGYS+vMpwBjarfoe/D+KYIU
	dGKzTRwB7/jWpFgf8ZVw8ozZDaquZrRgjUc7xLfUkxohgUmkZIgcH7hBL8nP8HhtVOfduqH81vUwA
	iAt/ejZg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnx-00000005Ttj-08oc;
	Fri, 05 Jun 2026 05:09:13 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 12/22] simplify safety for lock_for_kill() slowpath
Date: Fri,  5 Jun 2026 06:09:00 +0100
Message-ID: <20260605050910.1306432-13-viro@zeniv.linux.org.uk>
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

rcu_read_lock() scopes in dentry eviction machinery are too wide
and badly structured; we end up with too many of those, quite
a few essentially identical.  Worse, quite a few of the function
involved are not neutral wrt that, making them harder to reason about.

rcu_read_lock() scope is not the only thing establishing an
RCU read-side critical area - spin_lock scope does the same and
they can be mixed - the sequence
	rcu_read_lock()
	...
	spin_lock()
	...
	rcu_read_unlock()
	...
	rcu_read_lock()
	...
	spun_unlock()
	...
	rcu_read_unlock()
is an unbroken RCU read-side critical area.

Use of that observation allows to simplify things.  First of all,
lock_for_kill() relies upon being in an unbroken RCU read-side
critical area.  It's always called with ->d_lock held, and normally
returns without having ever dropped that spinlock.  We would not
need rcu_read_lock() at all, if not for the slow path - if trylock
of inode->i_lock fails, we need to drop and retake ->d_lock.

Having all calls of lock_for_kill() inside an rcu_read_lock() scope
takes care of that, but to show that lock_for_kill() slow path is safe,
we need to demonstrate such rcu_read_lock() scope for any call chain
leading to lock_for_kill().  Which is not fun, seeing that there are
10 such scopes, with 5 distinct beginnings between them.

Case 1: opens in dput() proceeds through fast_dput() grabbing ->d_lock,
returning false into dput() and there a call of finish_dput() which calls
dentry_kill(), which calls lock_for_kill(); ends in dentry_kill(), either
right after lock_for_kill() success or right after dropping ->d_lock
on lock_for_kill() failure.  ->d_lock is held continuously all the way
into lock_for_kill().

Case 2: opens in dentry_kill(), where we proceed to the same call of
dentry_kill() as in case 1.  ->d_lock is held since before the
beginning of the scope and all the way into lock_for_kill().

Case 3: opens in select_collect2(), proceeds through the return to
d_walk() and to shrink_dcache_tree() where we grab ->d_lock and
proceed to call shrink_kill(), which calls dentry_kill(), then as
in the previous scopes.

Case 4: opens in shrink_dentry_list(), followed by call of shrink_kill(),
then same as in case 3.  ->d_lock is held since before the beginning
of the scope and all the way into lock_for_kill().

Case 5: opens in shrink_kill(), where it's immediately followed by
call of dentry_kill(), then same as in the previous scopes.  ->d_lock
is held since before the beginning of the scope all the way into
lock_for_kill().

Note that in cases 2, 4 and 5 the slow path of lock_for_kill() is the
only part of rcu_read_lock() scope that is not covered by spinlock
scopes.  In case 1 we have the area in fast_dput() as well and in
case 3 - the return path from select_collect2() and chunk in shrink_dcache_tree()
up to grabbing ->d_lock.

Seeing that the reasons we need rcu_read_lock() in these additional
areas are completely unrelated to lock_for_kill() slow path, the things
get much more straightforward with
	* explicit rcu_read_lock() scope surrounding the area in slow path
of lock_for_kill() where ->d_lock is not held
	* shrink_dentry_list() dropping rcu_read_lock() as soon as it has
grabbed ->d_lock.
	* dput() dropping rcu_read_lock() just before calling finish_dput().
	* rcu_read_lock() calls in finish_dput(), shrink_kill() and
shrink_dentry_list() are removed, along with rcu_read_unlock() calls in
dentry_kill().

RCU read-side critical areas are unchanged by that, safety of lock_for_kill()
slow path is trivial to verify and a bunch of rcu_read_lock() scopes either
gone or become easier to describe.

Update the comments on locking conventions and memory safety considerations,
including the NORCU case.

Incidentally, all calls of fast_dput() are immediately preceded by rcu_read_lock()
and followed by rcu_read_unlock() now, which will allow to simplify those on
the next step...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c | 49 +++++++++++++++++++++++++++++++++----------------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1dfe37e57447..9851d387349d 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -743,14 +743,29 @@ static struct dentry *__dentry_kill(struct dentry *dentry)
 }
 
 /*
- * Lock a dentry for feeding it to __dentry_kill().
- * Called under rcu_read_lock() and dentry->d_lock; the former
- * guarantees that nothing we access will be freed under us.
- * Note that dentry is *not* protected from concurrent dentry_kill(),
- * d_delete(), etc.
- *
- * Return false if dentry is busy.  Otherwise, return true and have
- * that dentry's inode locked.
+ * Prepare locking environment for killing a dentry.
+ * Called under dentry->d_lock.  To proceed with eviction of a positive dentry
+ * we need to get ->i_lock of the inode of that dentry as well.
+ * However, ->i_lock nests outside of ->d_lock, so if trylock fails we might
+ * have to drop and regain the latter.  Dentry state can change while its
+ * ->d_lock is not held - it might end up getting killed, becoming busy,
+ * negative, etc., so we need to be careful.
+ *
+ * For NORCU dentries memory safety relies upon having only one call of
+ * lock_for_kill() in the entire lifetime of dentry and dentry_free() being
+ * called only by the caller of lock_for_kill().  That this is NORCU-specific;
+ * the crucial part is that refcounts of NORCU dentries never grow once having
+ * dropped to zero.
+ *
+ * For normal dentries we can not assume that there won't be concurrent calls
+ * of dentry_free() - dentry might end up being evicted by another thread
+ * while we are dropping/retaking locks on the slow path.  Memory safety is
+ * provided by keeping the RCU read-side critical area contiguous with
+ * an explicit rcu_read_lock() scope bridging over the break in spinlock scopes.
+ *
+ * Return false if dentry is busy (or busy dying, or already dead).  Otherwise,
+ * return true and have that dentry's inode (if any) locked in addition to
+ * dentry itself.
  */
 
 static bool lock_for_kill(struct dentry *dentry)
@@ -763,15 +778,22 @@ static bool lock_for_kill(struct dentry *dentry)
 	if (!inode || likely(spin_trylock(&inode->i_lock)))
 		return true;
 
+	// Too bad - we need to drop ->d_lock and take locks in correct order.
+	// To avoid breaking RCU read-side critical area when we drop ->d_lock,
+	// take an explicit rcu_read_lock() while we are switching locks.
+	rcu_read_lock();
 	do {
 		spin_unlock(&dentry->d_lock);
 		spin_lock(&inode->i_lock);
 		spin_lock(&dentry->d_lock);
+		// make sure we'd locked the right inode - ->d_inode might've
+		// changed while we were not holding ->d_lock
 		if (likely(inode == dentry->d_inode))
 			break;
 		spin_unlock(&inode->i_lock);
 		inode = dentry->d_inode;
 	} while (inode);
+	rcu_read_unlock();
 	if (likely(!dentry->d_lockref.count))
 		return true;
 	if (inode)
@@ -783,10 +805,8 @@ static struct dentry *dentry_kill(struct dentry *dentry)
 {
 	if (unlikely(!lock_for_kill(dentry))) {
 		spin_unlock(&dentry->d_lock);
-		rcu_read_unlock();
 		return NULL;
 	}
-	rcu_read_unlock();
 	return __dentry_kill(dentry);
 }
 
@@ -931,14 +951,12 @@ static inline bool fast_dput(struct dentry *dentry)
 
 static void finish_dput(struct dentry *dentry)
 	__releases(dentry->d_lock)
-	__releases(RCU)
 {
 	while ((dentry = dentry_kill(dentry)) != NULL) {
 		if (retain_dentry(dentry, true)) {
 			spin_unlock(&dentry->d_lock);
 			return;
 		}
-		rcu_read_lock();
 	}
 }
 
@@ -978,6 +996,7 @@ void dput(struct dentry *dentry)
 		rcu_read_unlock();
 		return;
 	}
+	rcu_read_unlock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(dput);
@@ -988,7 +1007,6 @@ void d_make_discardable(struct dentry *dentry)
 	WARN_ON(!(dentry->d_flags & DCACHE_PERSISTENT));
 	dentry->d_flags &= ~DCACHE_PERSISTENT;
 	dentry->d_lockref.count--;
-	rcu_read_lock();
 	finish_dput(dentry);
 }
 EXPORT_SYMBOL(d_make_discardable);
@@ -1217,7 +1235,7 @@ EXPORT_SYMBOL(d_prune_aliases);
 static inline void shrink_kill(struct dentry *victim)
 {
 	while ((victim = dentry_kill(victim)) != NULL)
-		rcu_read_lock();
+		;
 }
 
 void shrink_dentry_list(struct list_head *list)
@@ -1233,7 +1251,6 @@ void shrink_dentry_list(struct list_head *list)
 			dentry_free(dentry);
 			continue;
 		}
-		rcu_read_lock();
 		shrink_kill(dentry);
 	}
 }
@@ -1669,6 +1686,7 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 			struct dentry *v = data.victim;
 
 			spin_lock(&v->d_lock);
+			rcu_read_unlock();
 			if (v->d_lockref.count < 0 &&
 			    !(v->d_flags & DCACHE_DENTRY_KILLED)) {
 				struct completion_list wait;
@@ -1676,7 +1694,6 @@ static void shrink_dcache_tree(struct dentry *parent, bool for_umount)
 				// it becomes invisible to d_walk().
 				d_add_waiter(v, &wait);
 				spin_unlock(&v->d_lock);
-				rcu_read_unlock();
 				if (!list_empty(&data.dispose))
 					shrink_dentry_list(&data.dispose);
 				wait_for_completion(&wait.completion);
-- 
2.47.3

