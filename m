Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067DE3A451C
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Apr 2026 08:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775289859; cv=none; b=JB21DbBna9xY4twCeBrmOLFFOGgIcIGGrgqTpP6HUIohmhuavgqsrX1YemCrPywBYlCwfUYJ8HS9uwvq/Zb3i6i7jlKh8TRjLEdXxd6Njid0VW3IVJjQBAMTBBWVPYOaWkK6KfFY4I9OXwW+FdA0n8rQpFeOy1aaYvgBC7sDjEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775289859; c=relaxed/simple;
	bh=reWI42kapTZVbWxZO+kD9/iaMGIukLq5/Hgyuqr1irQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AcRevv5Qerzgc/850ll6gfUxXQi1umWaAvo9kRXr92trd8ECUDicfgq6H5L3iwY0sMARqCU+yI0pkkt5rycyg2Vvw2FkeOil7PSfeZqa/uOLO23mhfYqPeHTLCNQ9CoRuyinDei4OdCaPVv5A0IReuDTSDTwEVSuR7GjdhYh93M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=K3m2SmUW; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="K3m2SmUW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=d6FP3wdvD3UYSPhTmATseelQ5dy6KfqvBFWyUif865w=; b=K3m2SmUWGo0B7BcDAlsgwA50LZ
	GZq81PwS4DA45rEKVzFNQtI274PeouIzvvJXzVfGLWT+Y4sB+kfvzvGxLlkLQlTu1Aq6DzrSJFjdb
	3+ZByZcGqRS60y+5SChruhPKwL+OmwWdTWdnMSG/dOJBdA7cceeJ8CeiPRt60uBiqUJPIXOdCuiTI
	Zs7KibiCOQZC0JxlFSpPVa2mfhtEAFRgTaKzhDynkIA9de6mU6pEFSU9vVpXPdt+lWFPq3bLbeTf6
	F+XVManacw4Hr7lGi2U6xUcuBKik8N5LDIqnZU1XSN+cDdXIvwV2luRp8VO3IlW5Tszc4W0yjNvUy
	aBneCSIw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1w8w2p-0000000AbO7-3cBK;
	Sat, 04 Apr 2026 08:07:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Eric Sandeen <sandeen@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>
Subject: [RFC PATCH v3 1/4] for_each_alias(): helper macro for iterating through dentries of given inode
Date: Sat,  4 Apr 2026 09:07:48 +0100
Message-ID: <20260404080751.2526990-2-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
References: <20260122202025.GG3183987@ZenIV>
 <20260404080751.2526990-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Most of the places using d_alias are loops iterating through all aliases for
given inode; introduce a helper macro (for_each_alias(dentry, inode))
and convert open-coded instances of such loop to it.

They are easier to read that way and it reduces the noise on the next steps.

You _must_ hold inode->i_lock over that thing.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 Documentation/filesystems/porting.rst | 10 ++++++++++
 fs/affs/amigaffs.c                    |  2 +-
 fs/ceph/mds_client.c                  |  2 +-
 fs/dcache.c                           |  6 +++---
 fs/exportfs/expfs.c                   |  2 +-
 fs/nfs/dir.c                          |  2 +-
 fs/notify/fsnotify.c                  |  2 +-
 fs/ocfs2/dcache.c                     |  2 +-
 fs/overlayfs/dir.c                    |  2 +-
 fs/smb/client/inode.c                 |  2 +-
 include/linux/dcache.h                |  4 ++++
 11 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystems/porting.rst
index 52ff1d19405b..9a9babd9ec48 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1361,3 +1361,13 @@ to match what strlen() would return if it was ran on the string.
 
 However, if the string is freely accessible for the duration of inode's
 lifetime, consider using inode_set_cached_link() instead.
+
+---
+
+**recommended**
+
+If you really need to iterate through dentries for given inode, use
+for_each_alias(dentry, inode) instead of hlist_for_each_entry; better
+yet, see if any of the exported primitives could be used instead of
+the entire loop.  You still need to hold ->i_lock of the inode over
+either form of manual loop.
diff --git a/fs/affs/amigaffs.c b/fs/affs/amigaffs.c
index fd669daa4e7b..91966b1f41f6 100644
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -126,7 +126,7 @@ affs_fix_dcache(struct inode *inode, u32 entry_ino)
 {
 	struct dentry *dentry;
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(dentry, inode) {
 		if (entry_ino == (u32)(long)dentry->d_fsdata) {
 			dentry->d_fsdata = (void *)inode->i_ino;
 			break;
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index b1746273f186..f839109fb66f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4614,7 +4614,7 @@ static struct dentry* d_find_primary(struct inode *inode)
 		goto out_unlock;
 	}
 
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(alias, inode) {
 		spin_lock(&alias->d_lock);
 		if (!d_unhashed(alias) &&
 		    (ceph_dentry(alias)->flags & CEPH_DENTRY_PRIMARY_LINK)) {
diff --git a/fs/dcache.c b/fs/dcache.c
index 7ba1801d8132..e069b6ec4ec0 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -790,7 +790,7 @@ void d_mark_dontcache(struct inode *inode)
 	struct dentry *de;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(de, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(de, inode) {
 		spin_lock(&de->d_lock);
 		de->d_flags |= DCACHE_DONTCACHE;
 		spin_unlock(&de->d_lock);
@@ -1040,7 +1040,7 @@ static struct dentry *__d_find_alias(struct inode *inode)
 	if (S_ISDIR(inode->i_mode))
 		return __d_find_any_alias(inode);
 
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(alias, inode) {
 		spin_lock(&alias->d_lock);
  		if (!d_unhashed(alias)) {
 			dget_dlock(alias);
@@ -1133,7 +1133,7 @@ void d_prune_aliases(struct inode *inode)
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias)
+	for_each_alias(dentry, inode)
 		d_dispose_if_unused(dentry, &dispose);
 	spin_unlock(&inode->i_lock);
 	shrink_dentry_list(&dispose);
diff --git a/fs/exportfs/expfs.c b/fs/exportfs/expfs.c
index 6c9be60a3e48..f67b3ce672fc 100644
--- a/fs/exportfs/expfs.c
+++ b/fs/exportfs/expfs.c
@@ -52,7 +52,7 @@ find_acceptable_alias(struct dentry *result,
 
 	inode = result->d_inode;
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(dentry, inode) {
 		dget(dentry);
 		spin_unlock(&inode->i_lock);
 		if (toput)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 2402f57c8e7d..5a0bd8113e3a 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -1471,7 +1471,7 @@ static void nfs_clear_verifier_file(struct inode *inode)
 	struct dentry *alias;
 	struct inode *dir;
 
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(alias, inode) {
 		spin_lock(&alias->d_lock);
 		dir = d_inode_rcu(alias->d_parent);
 		if (!dir ||
diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 9995de1710e5..b7198c4744e3 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -76,7 +76,7 @@ void fsnotify_set_children_dentry_flags(struct inode *inode)
 	spin_lock(&inode->i_lock);
 	/* run all of the dentries associated with this inode.  Since this is a
 	 * directory, there damn well better only be one item on this list */
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(alias, inode) {
 		struct dentry *child;
 
 		/* run all of the children of the original inode and fix their
diff --git a/fs/ocfs2/dcache.c b/fs/ocfs2/dcache.c
index c4ba968e778b..e06774fd89d8 100644
--- a/fs/ocfs2/dcache.c
+++ b/fs/ocfs2/dcache.c
@@ -145,7 +145,7 @@ struct dentry *ocfs2_find_local_alias(struct inode *inode,
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(dentry, inode) {
 		spin_lock(&dentry->d_lock);
 		if (ocfs2_match_dentry(dentry, parent_blkno, skip_unhashed)) {
 			trace_ocfs2_find_local_alias(dentry->d_name.len,
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index ff3dbd1ca61f..f8dfa534b566 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -904,7 +904,7 @@ static void ovl_drop_nlink(struct dentry *dentry)
 
 	/* Try to find another, hashed alias */
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(alias, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(alias, inode) {
 		if (alias != dentry && !d_unhashed(alias))
 			break;
 	}
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 888f9e35f14b..e2b4ad9bd0bd 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -1595,7 +1595,7 @@ inode_has_hashed_dentries(struct inode *inode)
 	struct dentry *dentry;
 
 	spin_lock(&inode->i_lock);
-	hlist_for_each_entry(dentry, &inode->i_dentry, d_u.d_alias) {
+	for_each_alias(dentry, inode) {
 		if (!d_unhashed(dentry) || IS_ROOT(dentry)) {
 			spin_unlock(&inode->i_lock);
 			return true;
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index 898c60d21c92..7f1dbc7121d7 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -615,4 +615,8 @@ void set_default_d_op(struct super_block *, const struct dentry_operations *);
 struct dentry *d_make_persistent(struct dentry *, struct inode *);
 void d_make_discardable(struct dentry *dentry);
 
+/* inode->i_lock must be held over that */
+#define for_each_alias(dentry, inode) \
+	hlist_for_each_entry(dentry, &(inode)->i_dentry, d_u.d_alias)
+
 #endif	/* __LINUX_DCACHE_H */
-- 
2.47.3

