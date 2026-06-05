Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047743FF8A7
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636159; cv=none; b=RZG1186W//zkNNMn8vE3xPD5SYj0tnXDCflSZ7WkUA6tySAeRiWPtCZJECbMRiu0DPwYnUMTZrCE3VODC2Klsr4Q0BxE5iY+2PDXcENpm5yQ7pYPb3RE/WpxGbd8Q+AdmoLq6bJHvcdwo3ONN9AP4B/6+og9pjMF6Ctg6aNbyVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636159; c=relaxed/simple;
	bh=ZfTi25U8JU+99exuQ68e4AzzZrJsfpr5SUSuIdlyuFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E1zShshGhd3Rfqx6m/xNdThLrrgOQjVzC6BLTPwzY9yzZdo06nh4YVetowF4MKuQ+Jf7nLhiAI8vFyPP7vnyFT2jIVFglEDcZmRkK9qw989wwyAefBDLmqI9BXeTp2McR+qr/kWfnyNjOOc82Quw75nelQygXmzs3Y3yoZn8I6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=LJMCsVQd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="LJMCsVQd"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hpGkkNiPonMpCCPYlaeS8ZHKwxnxm9iGLrd7MvQCiPU=; b=LJMCsVQd211oehpTYHBKQWkgAr
	jDUkT6gi1mu5kHpN39m4gelejljAa4ta1L+qu9M5CU88kHKavWXPOxunIFYmPpYeWmlh3W66eA1fY
	qIpBVNhFyw7bYwwfBLDog4nQ/nnXXdLRr3/dTuSzB0HEitzNLx8ydHlVUjjmJxIcJFxOLgG6FsK+L
	rpyDTrJ6JTUdwphy3cDWVj6vrpsvIZ5jbBriCDLy5IYbr9FgqpmwdvO3z9sPUalx6lJdTtFhwjnWb
	4ZprE7xgIjnNROVbqtgcvG66jTGwceGOah1Z+Q+XXl1sho5YMJnNPzqVt9cqOw7V+EVTgigKNlrFm
	1wKaeF7g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMo0-00000005Tvc-2Udc;
	Fri, 05 Jun 2026 05:09:16 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 20/22] wind ->s_roots via ->d_sib instead of ->d_hash
Date: Fri,  5 Jun 2026 06:09:08 +0100
Message-ID: <20260605050910.1306432-21-viro@zeniv.linux.org.uk>
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

shrink_dcache_for_umount() is supposed to handle the possibility of
some of the dentries to be evicted being in other threads shrink
lists; it either kills them, leaving an empty husk to be freed by
the owner of shrink list whenever it gets around to that, or it
waits for the eviction in progress to get completed.

That relies upon dentry remaining attached to the tree until the
eviction reaches dentry_unlist() and its ->d_sib gets removed
from the list.  Unfortunately, the secondary roots are linked
via ->d_hash, rather than ->d_sib and they become removed from
that list before their inode references are dropped.

If shrink_dentry_list() from another thread ends up evicting
one of the secondary roots and gets to that point in dentry_kill()
when shrink_dcache_for_umount() is looking for secondary roots,
the latter will *not* notice anything, possibly leading to
warnings about busy inodes at umount time and all kinds of breakage
after that.

Moreover, shrink_dcache_for_umount() walks the list of secondary
roots with no protection whatsoever, so it might end up calling
dget() on a dentry that already passed through
	lockref_mark_dead(&dentry->d_lockref);
ending up with corrupted refcount and possible UAF.

AFAICS, the most straightforward way to deal with that would be
to have secondary roots linked via ->d_sib rather than ->d_hash;
then they would remain on the list until killed, and we could
use d_add_waiter() machinery to wait for eviction in progress.

Changes:
	* secondary roots look the same as ->s_root from d_unhashed()
and d_unlinked() POV now.
	* secondary roots are represented as "no parent, but on ->d_sib"
instead of "no parent, but on ->d_hash".
	* since ->d_sib is a plain hlist, we protect it with per-superblock
spinlock (sb->s_roots_lock) instead of the LSB of the head pointer (for
non-root dentries it would be protected by ->d_lock of parent).
	* __d_obtain_alias() uses ->d_sib for linkage when allocating
a secondary root.
	* d_splice_alias_ops() detects splicing of a secondary root and
removes it from the list before calling __d_move().
	* dentry_unlist() detects eviction of a secondary root and
removes it from the list; no need to play the games for d_walk() sake,
since the latter is not going to look for the next sibling of those
anyway.
	* ___d_drop() doesn't care about ->s_roots anymore.
	* shrink_dcache_for_umount() uses proper locking for access to
the list of secondary roots and if it runs into one that is in the middle
of eviction waits for that to finish.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/dcache.c                    | 65 ++++++++++++++++++++++++----------
 fs/super.c                     |  1 +
 include/linux/fs/super_types.h |  3 +-
 3 files changed, 50 insertions(+), 19 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 1f4435b7f9ce..257eefc46f5e 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -43,8 +43,8 @@
  *   - i_dentry, d_alias, d_inode of aliases
  * dcache_hash_bucket lock protects:
  *   - the dcache hash table
- * s_roots bl list spinlock protects:
- *   - the s_roots list (see __d_drop)
+ * s_roots_lock protects:
+ *   - the s_roots list (see __d_move()/dentry_unlist()/d_obtain_root())
  * dentry->d_sb->s_dentry_lru_lock protects:
  *   - the dcache lru lists and counters
  * d_lock protects:
@@ -562,16 +562,7 @@ static void d_lru_shrink_move(struct list_lru_one *lru, struct dentry *dentry,
 
 static void ___d_drop(struct dentry *dentry)
 {
-	struct hlist_bl_head *b;
-	/*
-	 * Hashed dentries are normally on the dentry hashtable,
-	 * with the exception of those newly allocated by
-	 * d_obtain_root, which are always IS_ROOT:
-	 */
-	if (unlikely(IS_ROOT(dentry)))
-		b = &dentry->d_sb->s_roots;
-	else
-		b = d_hash(dentry->d_name.hash);
+	struct hlist_bl_head *b = d_hash(dentry->d_name.hash);
 
 	hlist_bl_lock(b);
 	__hlist_bl_del(&dentry->d_hash);
@@ -654,6 +645,13 @@ static inline void d_complete_waiters(struct dentry *dentry)
 	}
 }
 
+static void unlink_secondary_root(struct dentry *dentry)
+{
+	spin_lock(&dentry->d_sb->s_roots_lock);
+	hlist_del_init(&dentry->d_sib);
+	spin_unlock(&dentry->d_sb->s_roots_lock);
+}
+
 static inline void dentry_unlist(struct dentry *dentry)
 {
 	struct dentry *next;
@@ -665,6 +663,10 @@ static inline void dentry_unlist(struct dentry *dentry)
 	d_complete_waiters(dentry);
 	if (unlikely(hlist_unhashed(&dentry->d_sib)))
 		return;
+	if (unlikely(IS_ROOT(dentry))) {
+		unlink_secondary_root(dentry); // secondary root goes away
+		return;
+	}
 	__hlist_del(&dentry->d_sib);
 	/*
 	 * Cursors can move around the list of children.  While we'd been
@@ -1805,9 +1807,30 @@ void shrink_dcache_for_umount(struct super_block *sb)
 	sb->s_root = NULL;
 	do_one_tree(dentry);
 
-	while (!hlist_bl_empty(&sb->s_roots)) {
-		dentry = dget(hlist_bl_entry(hlist_bl_first(&sb->s_roots), struct dentry, d_hash));
-		do_one_tree(dentry);
+	for (;;) {
+		spin_lock(&sb->s_roots_lock);
+		dentry = hlist_entry_safe(sb->s_roots.first,
+					  struct dentry, d_sib);
+		if (!dentry) {
+			spin_unlock(&sb->s_roots_lock);
+			break;
+		}
+		rcu_read_lock();
+		spin_unlock(&sb->s_roots_lock);
+		spin_lock(&dentry->d_lock);
+		rcu_read_unlock();
+		if (unlikely(dentry->d_lockref.count < 0)) {
+			struct completion_list wait;
+			bool need_wait = d_add_waiter(dentry, &wait);
+
+			spin_unlock(&dentry->d_lock);
+			if (need_wait)
+				wait_for_completion(&wait.completion);
+		} else {
+			dget_dlock(dentry);
+			spin_unlock(&dentry->d_lock);
+			do_one_tree(dentry);
+		}
 	}
 }
 
@@ -2224,9 +2247,9 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 		__d_set_inode_and_type(new, inode, add_flags);
 		hlist_add_head(&new->d_alias, &inode->i_dentry);
 		if (!disconnected) {
-			hlist_bl_lock(&sb->s_roots);
-			hlist_bl_add_head(&new->d_hash, &sb->s_roots);
-			hlist_bl_unlock(&sb->s_roots);
+			spin_lock(&sb->s_roots_lock);
+			hlist_add_head(&new->d_sib, &sb->s_roots);
+			spin_unlock(&sb->s_roots_lock);
 		}
 		spin_unlock(&new->d_lock);
 		spin_unlock(&inode->i_lock);
@@ -3238,6 +3261,12 @@ struct dentry *d_splice_alias_ops(struct inode *inode, struct dentry *dentry,
 				}
 				dput(old_parent);
 			} else {
+				if (unlikely(!hlist_unhashed(&new->d_sib))) {
+					// secondary root getting spliced
+					spin_lock(&new->d_lock);
+					unlink_secondary_root(new);
+					spin_unlock(&new->d_lock);
+				}
 				__d_move(new, dentry, false);
 				write_sequnlock(&rename_lock);
 			}
diff --git a/fs/super.c b/fs/super.c
index 378e81efe643..fb44ebadda82 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -359,6 +359,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 		s->s_iflags |= SB_I_NODEV;
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
+	spin_lock_init(&s->s_roots_lock);
 	mutex_init(&s->s_sync_lock);
 	INIT_LIST_HEAD(&s->s_inodes);
 	spin_lock_init(&s->s_inode_list_lock);
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index 383050e7fdf5..23d1c2612d0c 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -162,7 +162,8 @@ struct super_block {
 	struct unicode_map			*s_encoding;
 	__u16					s_encoding_flags;
 #endif
-	struct hlist_bl_head			s_roots;	/* alternate root dentries for NFS */
+	struct hlist_head			s_roots;	/* alternate root dentries for NFS */
+	spinlock_t				s_roots_lock;
 	struct mount				*s_mounts;	/* list of mounts; _not_ for fs use */
 	struct block_device			*s_bdev;	/* can go away once we use an accessor for @s_bdev_file */
 	struct file				*s_bdev_file;
-- 
2.47.3

