Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45FA393DDD
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251595; cv=none; b=OgIiQv4eQvcPr3DHvm0ASBXzHkzSOfx6lBSmRR1/sR1gp3dpLH8hiYb0x6MYY54m5HqJVQth1VIk0S+upc7H8KiVibfUyG+nHOH3cj7IaMHBtIX/VGMQUKcyrlUohxFgb8/bM58lt9+npc6YNvt9GuR+vdypgywg0efvNme1WKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251595; c=relaxed/simple;
	bh=prDA/ZkaoWHimPaEgbVbLBCP/9Hr7JDKeCC5c4dQrQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=om7X5rXGwO6/NwW1UbpeqctDMfJ0klHT+GKmxujZq3DLa9Jn4oAfvqdsdhtDAOy9vPSlmWGUHTePyTNJLqrIvBpg2+8/fVgOMQlkiAg93xf4iHE/q/qzIN9cX5Uis35BxhaOec8kpG9PZxUskafs/L9CJlEr/nIJanoHGvvpmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=V+2aFr0C; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="V+2aFr0C"
X-KPN-MessageId: 510ab670-5d1d-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 510ab670-5d1d-11f1-96a9-005056abbe64;
	Sun, 31 May 2026 20:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=r1sFqTXedlMyWqPjwiEDsNgQki9tQsfI/pvCFGzINbw=;
	b=V+2aFr0CHhCwpgdYAn6ml00wzBnkNaTUdtsExHQTzBrXS7KCHW5z5E0o9T9dh4iBX7nE01gXdvrhq
	 +sVdHLWOa1EjyF2SpNcSYiYqa328UJhikdcX1GB034BNkbMZHF72zyDDkkTu6V6pGGYd34gfLThE7E
	 /l9ItgWxCOcfOEIBvJJnlw5XsVbzMa1aH/qntdrueX9WX6uCgwvP3dLMpmdehfrGQb5gX0ERUg1kjO
	 xdVJTx07NZ9viJxobkLGRThQINnD5JvgZn4is9aan+TYJFVxL6CBXRrjExJL0eSvP5G6cA8GfWPvuU
	 GacmpDMqvWW1GiXbkTUIHzCzLGFZ9Aw==
X-KPN-MID: 33|55OZhV/AWwqg4unodZAngDYuFy8rFnoiiLqzTjbBQoDxYRkNoL5wSdhTnvg7FtP
 AkGWuGHuQPrqYK5FSSlC2utoGR5pfDvXVxmbb62bkcEc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|VEzpcJK2vGJHUS8yPxs5TGYT5eqYm20yfC/OJ+FEc8NisZd57EzlYaO6u4fMZUM
 PNjKREEVYpHXZ3bSGmSP34w==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 50bfd774-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:51 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 7/9] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 31 May 2026 20:20:43 +0200
Message-ID: <20260531182045.171711-8-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently there is no way to race-freely create and open a directory.
For regular files we have open(O_CREAT) for creating a new file inode,
and returning a pinning fd to it. The lack of such functionality for
directories means that when populating a directory tree there's always
a race involved: the inodes first need to be created, and then opened
to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
but in the time window between the creation and the opening they might
be replaced by something else.

Addressing this race without proper APIs is possible (by immediately
fstat()ing what was opened, to verify that it has the right inode type),
but difficult to get right. Hence, adding support for a new flag combo
O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
exist already) and returns an O_DIRECTORY fd is very useful.

Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
a regular file exists at the open path; EISDIR if a directory exists at
the path; and to create a regular file if no file exists at the path.
This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
the common path even earlier in FMODE_{OPENED,CREATED} case") causing
ENOTDIR to return in the last case while still creating the file. As
this change was not detected for a long time, Brauner proposed to adopt
the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
the EINVAL behaviour has been in the kernel for about 3 year now, no
rollback is expected as a result of userspace reliance on old
behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.

O_CREAT|O_DIRECTORY is blocked in atomic_open() until individual
filesytems that support i_op->atomic_open() are given tailored support.

This feature idea (and some of its description) is taken from the
UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c            | 94 +++++++++++++++++++++++++++++++++----------
 fs/open.c             | 25 +++++++-----
 include/linux/fcntl.h |  7 ++++
 3 files changed, 94 insertions(+), 32 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index a8c247e0bb65..724b9de6831a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1377,13 +1377,12 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 
 /**
  * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
- *			  should be allowed, or not, on files that already
- *			  exist.
+ *			  should be allowed, or not
  * @idmap: idmap of the mount the inode was found from
  * @nd: nameidata pathwalk data
  * @inode: the inode of the file to open
  *
- * Block an O_CREAT open of a FIFO (or a regular file) when:
+ * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
  *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
  *   - the file already exists
  *   - we are in a sticky directory
@@ -1411,6 +1410,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 	if (likely(!(dir_mode & S_ISVTX)))
 		return 0;
 
+	// There is no separate sysctl for directory creation in sticky
+	// folders. Therefore, for the S_ISDIR case, disabling
+	// sysctl_protected_regular is not enough to allow creating a
+	// directory in a sticky folder, because that may suprise users
+	// not expecting that O_CREAT|O_DIRECTORY is possible on newer
+	// kernels.
 	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
 		return 0;
 
@@ -1442,6 +1447,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 					      "sticky_create_regular");
 			return -EACCES;
 		}
+
+		if (sysctl_protected_regular >= 2 && S_ISDIR(inode->i_mode)) {
+			audit_log_path_denied(AUDIT_ANOM_CREAT,
+					      "sticky_create_dir");
+			return -EACCES;
+		}
 	}
 
 	return 0;
@@ -4215,7 +4226,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 		return error;
 
 	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
+		return -EACCES; /* shouldn't it be ENOSYS? */
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
@@ -4339,21 +4350,40 @@ static inline int open_to_namei_flags(int flag)
 
 static int may_o_create(struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
-			umode_t mode)
+			umode_t mode, bool create_dir)
 {
-	int error = security_path_mknod(dir, dentry, mode, 0);
+	struct inode *dir_inode = dir->dentry->d_inode;
+	int error;
+
+	if (create_dir)
+		error = security_path_mkdir(dir, dentry, mode);
+	else
+		error = security_path_mknod(dir, dentry, mode, 0);
 	if (error)
 		return error;
 
 	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
 		return -EOVERFLOW;
 
-	error = inode_permission(idmap, dir->dentry->d_inode,
-				 MAY_WRITE | MAY_EXEC);
+	error = inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
-	return security_inode_create(dir->dentry->d_inode, dentry, mode);
+	if (create_dir)
+		error = security_inode_mkdir(dir_inode, dentry, mode);
+	else
+		error = security_inode_create(dir_inode, dentry, mode);
+
+	return error;
+}
+
+static inline umode_t o_create_mode(struct mnt_idmap *idmap,
+		const struct inode *dir, umode_t mode, bool create_dir)
+{
+	if (create_dir)
+		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
+	else
+		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 }
 
 /*
@@ -4379,8 +4409,12 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
-	error = dir->i_op->atomic_open(dir, dentry, file,
-				       open_to_namei_flags(open_flag), mode);
+
+	if (O_IS_MKDIR(open_flag))
+		error = EINVAL;
+	else
+		error = dir->i_op->atomic_open(dir, dentry, file,
+					       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
@@ -4413,6 +4447,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	return dentry;
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
+				 struct dentry *, umode_t,
+				 struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4439,6 +4477,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool create_dir = O_IS_MKDIR(open_flag);
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
@@ -4487,10 +4526,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
+		mode = o_create_mode(idmap, dir_inode, mode, create_dir);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
-						    dentry, mode);
+						    dentry, mode, create_dir);
 		else
 			create_error = -EROFS;
 	}
@@ -4527,14 +4566,26 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-
-		if (!dir_inode->i_op->create) {
+		if ((create_dir && !dir_inode->i_op->mkdir)
+		    || (!create_dir && !dir_inode->i_op->create)) {
 			error = -EACCES;
 			goto out_dput;
 		}
 
-		error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode,
-					   open_flag & O_EXCL);
+		if (create_dir) {
+			struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
+							       mode, delegated_inode);
+			if (IS_ERR(res)) {
+				error = PTR_ERR(res);
+			} else {
+				error = 0;
+				dentry = res;
+			}
+		} else {
+			error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode,
+						   open_flag & O_EXCL);
+
+		}
 		if (error)
 			goto out_dput;
 
@@ -4553,7 +4604,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd))
+		if (trailing_slashes(nd) && !(open_flag & O_DIRECTORY))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4624,7 +4675,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 */
 	}
 	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
+		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
 	else
 		inode_lock_shared(dir->d_inode);
 
@@ -4687,8 +4738,9 @@ static int do_open(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
-		if (d_is_dir(nd->path.dentry))
+		if (!(open_flag & O_DIRECTORY) && d_is_dir(nd->path.dentry))
 			return -EISDIR;
+
 		error = may_create_in_sticky(idmap, nd,
 					     d_backing_inode(nd->path.dentry));
 		if (unlikely(error))
@@ -5054,7 +5106,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, mode, /*create_dir=*/ false);
 		if (create_error)
 			flags &= ~O_CREAT;
 
diff --git a/fs/open.c b/fs/open.c
index 681d405bc61e..5cf8ada58483 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	if (WILL_CREATE(flags)) {
 		if (how->mode & ~S_IALLUGO)
 			return -EINVAL;
-		op->mode = how->mode | S_IFREG;
+		if (O_IS_MKDIR(flags))
+			op->mode = how->mode | S_IFDIR;
+		else
+			op->mode = how->mode | S_IFREG;
 	} else {
 		if (how->mode != 0)
 			return -EINVAL;
 		op->mode = 0;
 	}
 
-	/*
-	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
-	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
-	 * O_TMPFILE below which requires O_DIRECTORY being raised.
-	 */
-	if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
-		return -EINVAL;
-
 	/* Now handle the creative implementation of O_TMPFILE. */
 	if (flags & __O_TMPFILE) {
 		/*
 		 * In order to ensure programs get explicit errors when trying
 		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
-		 * is raised alongside __O_TMPFILE.
+		 * is raised alongside __O_TMPFILE, but without O_CREAT. The
+		 * reason for disallowing O_CREAT|O_TMPFILE is that
+		 * O_DIRECTORY|O_CREAT used to work and created a regular file
+		 * if nothing existed at the open path. Hence, allowing the
+		 * combination would have caused O_CREAT|O_TMPFILE to create a
+		 * regular (non-temporary) file on old kernels, while the caller
+		 * would believe they created an actual O_TMPFILE.
 		 */
-		if (!(flags & O_DIRECTORY))
+		if (!(flags & O_DIRECTORY) || (flags & O_CREAT))
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
@@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
 	if (flags & O_CREAT) {
+		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
+			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..79843e8add6e 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,13 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+
+#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
+static inline bool O_IS_MKDIR(unsigned flags)
+{
+    return (flags & O_MKDIR_MASK) == O_MKDIR_MASK;
+}
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-- 
2.54.0

