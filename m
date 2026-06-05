Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C5B3A9DB9
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 05:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780636156; cv=none; b=akEVFuuYTaxAm5ORH3F/W2EK0SabnKazY92CmrolY2k4jfPeuhyuruCmEO4uHFAlUnaDU7kflxYbJ/S0hBMxXfMNVp+8uQlqizn9G0jzca2zSdULXRlCu8680j/KbFucMS2zV2Tl6lidheB9pF8bh4amXvQQklwEZEw+qYp8NUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780636156; c=relaxed/simple;
	bh=bGW5zbrMz+Lu1lZ+oGyE84HPzgt36idQhSLXfczvpfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PJ+KLNOFzcrX1VsAHpwEKs7oQPslHzsknd/1I0b3o/71FbTPM2Bqn1PVRxnSOrTLzGHOpraj9O7qTb3u0EEECITgxTyAK3/WhF03XZThXur5tw7vsDI2RFbgyEm6jT1VTDQbZ4x+kFf7mVdVSlt1PHY8+R6YeYG/nLa0eOmOf1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=IhkDcC8H; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="IhkDcC8H"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QCjK8yrMJE0NCg8a2+cChE42xy3FJ9YkOhlYLygA1uc=; b=IhkDcC8HeetNaFF6GQnu9ih1ck
	l2jxl7Hj0allIWI3rPX9HmdCr5Zvcw8jOeSghMB87WnCVw7oSmWzfKZvubUa51i4bhpdD6C52W5IV
	eKqzoMtqT36L+l7ZIlGdcthN2ds35CWypoYEdiex0mBdKDpha6DEI2VPhAdoc8touUscnTVXbOBrJ
	Grtq+olKIr18Tb1WeuO8yvMxMuwpXyGeuVDYmQ+DUL/PuphVnbdOq6Qdq88Aejfk2uA2uRtDjQQnZ
	NyzNd3HrYpZppL6FIi0lS3++Q3BDlBk72pdDDUQDA7g0RKiCkIpQsZ51lw0TjXXU9DZZkiNdsFxoj
	smvObfhQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wVMnw-00000005Tsf-1Cr3;
	Fri, 05 Jun 2026 05:09:12 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 07/22] kill d_dispose_if_unused()
Date: Fri,  5 Jun 2026 06:08:55 +0100
Message-ID: <20260605050910.1306432-8-viro@zeniv.linux.org.uk>
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

Rename to_shrink_list() into __move_to_shrink_list(), document and
export it.  Switch d_dispose_if_unused() users to that and kill
d_dispose_if_unused() itself.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 11 ++++++
 fs/dcache.c                           | 51 ++++++++++++++-------------
 fs/fuse/dir.c                         |  2 +-
 include/linux/dcache.h                |  2 +-
 4 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 36fecc7a3d97..003ab084ad48 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1391,3 +1391,14 @@ either form of manual loop.
 **mandatory**
 
 d_alloc_parallel() no longer requires a waitqueue_head.
+
+---
+
+**mandatory**
+
+d_dispose_if_unused() is gone; use __move_to_shrink_list() if you really
+need that functionality, but watch out for memory safety issues - just
+as with d_dispose_if_unused() these are not trivial; with this variant
+of API it's more explicit, since grabbing ->d_lock is caller-side, but
+d_dispose_if_unused() had all the same issues.  It's a low-level primitive;
+use only if you have no alternative.
diff --git a/fs/dcache.c b/fs/dcache.c
index 7a0c8349b5a1..ea26bd2dd2b2 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -988,7 +988,24 @@ void d_make_discardable(struct dentry *dentry)
 }
 EXPORT_SYMBOL(d_make_discardable);
 
-static bool to_shrink_list(struct dentry *dentry, struct list_head *list)
+/**
+ * __move_to_shrink_list - try to place a dentry into a shrink list
+ * @dentry:	dentry to try putting into shrink list
+ * @list:	the list to put @dentry into.
+ * Returns:	true @dentry had been placed into @list, false otherwise
+ *
+ * If @dentry is idle and not already include into a shrink list, move
+ * it into @list and return %true; otherwise do nothing and return %false.
+ *
+ * Caller must be holding @dentry->d_lock.  There must have been no calls of
+ * dentry_free(@dentry) prior to the beginning of the RCU read-side critical
+ * area in which __move_to_shrink_list(@dentry, @list) is called.
+ *
+ * @list should be thread-private and eventually emptied by passing it to
+ * shrink_dentry_list().
+ */
+
+bool __move_to_shrink_list(struct dentry *dentry, struct list_head *list)
 __must_hold(&dentry->d_lock)
 {
 	if (likely(!dentry->d_lockref.count &&
@@ -1000,6 +1017,7 @@ __must_hold(&dentry->d_lock)
 	}
 	return false;
 }
+EXPORT_SYMBOL(__move_to_shrink_list);
 
 void dput_to_list(struct dentry *dentry, struct list_head *list)
 {
@@ -1009,7 +1027,7 @@ void dput_to_list(struct dentry *dentry, struct list_head *list)
 		return;
 	}
 	rcu_read_unlock();
-	to_shrink_list(dentry, list);
+	__move_to_shrink_list(dentry, list);
 	spin_unlock(&dentry->d_lock);
 }
 
@@ -1170,24 +1188,6 @@ struct dentry *d_find_alias_rcu(struct inode *inode)
 	return de;
 }
 
-/**
- * d_dispose_if_unused - move unreferenced dentries to shrink list
- * @dentry: dentry in question
- * @dispose: head of shrink list
- *
- * If dentry has no external references, move it to shrink list.
- *
- * NOTE!!! The caller is responsible for preventing eviction of the dentry by
- * holding dentry->d_inode->i_lock or equivalent.
- */
-void d_dispose_if_unused(struct dentry *dentry, struct list_head *dispose)
-{
-	spin_lock(&dentry->d_lock);
-	to_shrink_list(dentry, dispose);
-	spin_unlock(&dentry->d_lock);
-}
-EXPORT_SYMBOL(d_dispose_if_unused);
-
 /*
  *	Try to kill dentries associated with this inode.
  * WARNING: you must own a reference to inode.
@@ -1198,8 +1198,11 @@ void d_prune_aliases(struct inode *inode)
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	for_each_alias(dentry, inode)
-		d_dispose_if_unused(dentry, &dispose);
+	for_each_alias(dentry, inode) {
+		spin_lock(&dentry->d_lock);
+		__move_to_shrink_list(dentry, &dispose);
+		spin_unlock(&dentry->d_lock);
+	}
 	spin_unlock(&inode->i_lock);
 	shrink_dentry_list(&dispose);
 }
@@ -1592,7 +1595,7 @@ static enum d_walk_ret select_collect(void *_data, struct dentry *dentry)
 		goto out;
 
 	if (dentry->d_lockref.count <= 0) {
-		to_shrink_list(dentry, &data->dispose);
+		__move_to_shrink_list(dentry, &data->dispose);
 		data->found++;
 	}
 	/*
@@ -1624,7 +1627,7 @@ static enum d_walk_ret select_collect2(void *_data, struct dentry *dentry)
 		goto out;
 
 	if (dentry->d_lockref.count <= 0) {
-		if (!to_shrink_list(dentry, &data->dispose)) {
+		if (!__move_to_shrink_list(dentry, &data->dispose)) {
 			rcu_read_lock();
 			data->victim = dentry;
 			return D_WALK_QUIT;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72f..d8e8ea7280bc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -177,8 +177,8 @@ static void fuse_dentry_tree_work(struct work_struct *work)
 			spin_lock(&fd->dentry->d_lock);
 			/* If dentry is still referenced, let next dput release it */
 			fd->dentry->d_flags |= DCACHE_OP_DELETE;
+			__move_to_shrink_list(fd->dentry, &dispose);
 			spin_unlock(&fd->dentry->d_lock);
-			d_dispose_if_unused(fd->dentry, &dispose);
 			if (need_resched()) {
 				spin_unlock(&dentry_hash[i].lock);
 				cond_resched();
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a3409de3f490..4b1ff99608e0 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -280,7 +280,7 @@ extern void d_tmpfile(struct file *, struct inode *);
 
 extern struct dentry *d_find_alias(struct inode *);
 extern void d_prune_aliases(struct inode *);
-extern void d_dispose_if_unused(struct dentry *, struct list_head *);
+extern bool __move_to_shrink_list(struct dentry *, struct list_head *);
 extern void shrink_dentry_list(struct list_head *);
 
 extern struct dentry *d_find_alias_rcu(struct inode *);
-- 
2.47.3

