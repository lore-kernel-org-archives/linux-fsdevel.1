Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CFA3947AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 20:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779740928; cv=none; b=BcN0tyEbBAd+jzAZ/yECHCB5H9WrfqrpY1meNFt0zYxnEHQtqVlp6Sp7ioZ/I0Ud9pTI7PrVu5GyDwGf/FD6O/RxBKIQmz9Pq7IOrOKQMh4Zpcm7nS2xplSBd2p3icb4vafkZ+69yLUM4FnXOEhTlmd5u8HYs2Yt7S55O6MOVKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779740928; c=relaxed/simple;
	bh=qBwEOxYQP5+0FmAVZasgTtx9ZIul3tGmCm2QTUh/WjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UXLKGS6wpkEih35dAWhCnZVeaMFmSbOzUjt8i1oxL8aRZLtpd2t2RQ0LOFd/cpOJ08nnVDVGjyl70+45iwUM//XfwB/84ncVc7pEkIYQW75uss85/I2tFIOTT5C4XFejXqjiU4vGYa2MVMTKeJeZWgg22C/t0z/wQDSYOduJljo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bWiba5Dv; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bWiba5Dv"
X-KPN-MessageId: 52cdf964-5878-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 52cdf964-5878-11f1-bea8-005056992ed3;
	Mon, 25 May 2026 22:28:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=TKO2yC+d174gPCthiUhIGu7WURhyyJrbwbz/mMHi/xw=;
	b=bWiba5DvVgyhU9e8en49CarDHEy0xo6RF0xtPIZc4gqGDpoqat6J1+tqy0iH0/LHxdXCQsh9K0SHJ
	 aW0bJ5iR5iDE3pb5l79IxNleyKacA+Qt3UmDiHoVmJNg+FRLSs1Ir7p5ASj2AC+AQu726bYW8R2YeO
	 tOhsdpi2qIR0r5TuuGZMIbR0AEpz2WrOfRUNwSKmmACbgF+Xsa8nBo+gjBV6nMqonluvdtVG7hkXs6
	 P9dU1DSZNgDEDG41edYV1R+VBeeN27riazHBuFOj2NU3hKLjN9fLJXuaYT54eCJnya843kBImrzp+a
	 Rlc6Z9L7mn/IoVrJzTZvhsZLpz3yN9Q==
X-KPN-MID: 33|BCyuGGIlO1aA8N47PzS+52bGIxgsKS03d81SREa+xKKSdkmE6J4tl1vMpsO9C/j
 0hrzO8MutUNr7dGooGVNevr/D7m2XnvGMz/SPLnusHyM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bg/YtowxmJek1PLP6AZA5YiIVybaQHnUtf8zkya67XbitApGdwJj+6SeAuZxrOP
 qapaFHDR/yUXvRNcxcm1H+g==
Received: from daedalus.home (unknown [178.227.141.192])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 528d29ad-5878-11f1-bffc-00505699772e;
	Mon, 25 May 2026 22:28:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Mon, 25 May 2026 22:29:36 +0200
Message-ID: <20260525202937.466497-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202937.466497-1-jkoolstra@xs4all.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
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

This commit also changes the error returned when a filesystem operation
is unsupported (i_op->mkdir/creat) to EOPNOTSUPP. Current error values
are inconsistent (both EPERM and EACCES are used) and confusing.

This feature idea (and some of its description) is taken from the
UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_inode.c      |   3 +
 fs/9p/vfs_inode_dotl.c |   3 +
 fs/ceph/file.c         |   3 +
 fs/fuse/dir.c          |   3 +
 fs/gfs2/inode.c        |   3 +
 fs/namei.c             | 177 +++++++++++++++++++++++++++--------------
 fs/nfs/dir.c           |   3 +
 fs/nfs/file.c          |   3 +
 fs/open.c              |  25 +++---
 fs/smb/client/dir.c    |   3 +
 fs/vboxsf/dir.c        |   3 +
 include/linux/fcntl.h  |   2 +
 12 files changed, 161 insertions(+), 70 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index f468acb8ee7d..d1925333d327 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -771,6 +771,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 141fb54db65d..9f4b865d07d7 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..9707d9ed17b6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -813,6 +813,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	err = ceph_wait_on_conflict_unlink(dentry);
 	if (err)
 		return err;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72f..4c59992b9867 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -940,6 +940,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (d_in_lookup(entry)) {
 		struct dentry *res = fuse_lookup(dir, entry, 0);
 		if (res || d_really_is_positive(entry))
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index e9bf4879c07f..21c6544fbee5 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1384,6 +1384,9 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..9d9529ef30c4 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 	return s;
 }
 
+static inline bool trailing_slashes(struct nameidata *nd)
+{
+	return (bool)nd->last.name[nd->last.len];
+}
+
 static inline const char *lookup_last(struct nameidata *nd)
 {
-	if (nd->last_type == LAST_NORM && nd->last.name[nd->last.len])
+	if (nd->last_type == LAST_NORM && trailing_slashes(nd))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
 
 	return walk_component(nd, WALK_TRAILING);
@@ -4166,6 +4171,16 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static int __vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
+			struct delegated_inode *di, bool excl)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	int error = try_break_deleg(dir, di);
+	if (error)
+		return error;
+	return dir->i_op->create(idmap, dir, dentry, mode, excl);
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -4192,16 +4207,14 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 		return error;
 
 	if (!dir->i_op->create)
-		return -EACCES;	/* shouldn't it be ENOSYS? */
+		return -EOPNOTSUPP;
 
 	mode = vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, di);
-	if (error)
-		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, true);
+
+	error = __vfs_create(idmap, dentry, mode, di, true);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4321,21 +4334,32 @@ static inline int open_to_namei_flags(int flag)
 
 static int may_o_create(struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
-			umode_t mode)
+			umode_t mode, bool create_dir)
 {
-	int error = security_path_mknod(dir, dentry, mode, 0);
+	struct inode *dir_inode = dir->dentry->d_inode;
+	int error;
+
+	error = create_dir ? security_path_mkdir(dir, dentry, mode)
+			   : security_path_mknod(dir, dentry, mode, 0);
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
+	return create_dir ? security_inode_mkdir(dir_inode, dentry, mode)
+			  : security_inode_create(dir_inode, dentry, mode);
+}
+
+static inline umode_t o_create_mode(struct mnt_idmap *idmap,
+		const struct inode *dir, umode_t mode, bool create_dir)
+{
+	return create_dir ? vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0)
+			  : vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 }
 
 /*
@@ -4388,6 +4412,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	return dentry;
 }
 
+static struct dentry *__vfs_mkdir(struct mnt_idmap *, struct inode *,
+			 struct dentry *, umode_t,
+			 struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4412,8 +4439,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
+	int error = 0, create_error = 0;
 	umode_t mode = op->mode;
+	bool create_dir = (open_flag & O_MKDIR_MASK) == O_MKDIR_MASK;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
@@ -4462,10 +4490,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
@@ -4494,29 +4522,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		}
 	}
 
+	if (unlikely(create_error) && !dentry->d_inode) {
+		error = create_error;
+		goto out_dput;
+	}
+
 	/* Negative dentry, just create the file */
 	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, delegated_inode);
-		if (error)
-			goto out_dput;
 
 		file->f_mode |= FMODE_CREATED;
 		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
+		if ((create_dir && !dir_inode->i_op->mkdir)
+		    || (!create_dir && !dir_inode->i_op->create)) {
+			error = -EOPNOTSUPP;
 			goto out_dput;
 		}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+		if (create_dir) {
+			struct dentry *res = __vfs_mkdir(idmap, dir_inode, dentry, mode,
+							 delegated_inode);
+			if (IS_ERR(res))
+				error = PTR_ERR(res);
+			else
+				dentry = res;
+		} else {
+			error = __vfs_create(idmap, dentry, mode, delegated_inode,
+					     open_flag & O_EXCL);
+		}
 		if (error)
 			goto out_dput;
 	}
-	if (unlikely(create_error) && !dentry->d_inode) {
-		error = create_error;
-		goto out_dput;
-	}
+
 	return dentry;
 
 out_dput:
@@ -4524,17 +4560,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	return ERR_PTR(error);
 }
 
-static inline bool trailing_slashes(struct nameidata *nd)
-{
-	return (bool)nd->last.name[nd->last.len];
-}
-
 static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 {
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd))
+		if (trailing_slashes(nd) && !(open_flag & O_DIRECTORY))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4605,13 +4636,17 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 */
 	}
 	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
+		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
 	else
 		inode_lock_shared(dir->d_inode);
 	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
 	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
+		if (file->f_mode & FMODE_CREATED) {
+			if (open_flag & O_DIRECTORY)
+				fsnotify_mkdir(dir->d_inode, dentry);
+			else
+				fsnotify_create(dir->d_inode, dentry);
+		}
 		if (file->f_mode & FMODE_OPENED)
 			fsnotify_open(file);
 	}
@@ -4672,12 +4707,16 @@ static int do_open(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
-		if (d_is_dir(nd->path.dentry))
-			return -EISDIR;
-		error = may_create_in_sticky(idmap, nd,
-					     d_backing_inode(nd->path.dentry));
-		if (unlikely(error))
-			return error;
+		// there are no special rules for creating dirs in a sticky bit dir
+		if (!(open_flag & O_DIRECTORY)) {
+			if (d_is_dir(nd->path.dentry))
+				return -EISDIR;
+
+			error = may_create_in_sticky(idmap, nd,
+						     d_backing_inode(nd->path.dentry));
+			if (unlikely(error))
+				return error;
+		}
 	}
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
@@ -5039,7 +5078,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, mode, false);
 		if (create_error)
 			flags &= ~O_CREAT;
 
@@ -5207,6 +5246,37 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return filename_mknodat(AT_FDCWD, name, mode, dev);
 }
 
+static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
+			 struct dentry *dentry, umode_t mode,
+			 struct delegated_inode *di)
+{
+	int error;
+	unsigned max_links = dir->i_sb->s_max_links;
+	struct dentry *de;
+
+	error = -EMLINK;
+	if (max_links && dir->i_nlink >= max_links)
+		goto err;
+
+	error = try_break_deleg(dir, di);
+	if (error)
+		goto err;
+
+	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	if (IS_ERR(de)) {
+		error = PTR_ERR(de);
+		goto err;
+	}
+	if (de) {
+		dput(dentry);
+		dentry = de;
+	}
+	return dentry;
+
+err:
+	return ERR_PTR(error);
+}
+
 /**
  * vfs_mkdir - create directory returning correct dentry if possible
  * @idmap:		idmap of the mount the inode was found from
@@ -5231,17 +5301,16 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode,
-			 struct delegated_inode *delegated_inode)
+			 struct delegated_inode *di)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
 	if (error)
 		goto err;
 
-	error = -EPERM;
+	error = -EOPNOTSUPP;
 	if (!dir->i_op->mkdir)
 		goto err;
 
@@ -5250,22 +5319,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EMLINK;
-	if (max_links && dir->i_nlink >= max_links)
-		goto err;
-
-	error = try_break_deleg(dir, delegated_inode);
-	if (error)
-		goto err;
-
-	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
-	error = PTR_ERR(de);
-	if (IS_ERR(de))
+	de = __vfs_mkdir(idmap, dir, dentry, mode, di);
+	if (IS_ERR(de)) {
+		error = PTR_ERR(de);
 		goto err;
-	if (de) {
-		dput(dentry);
-		dentry = de;
 	}
+	dentry = de;
 	fsnotify_mkdir(dir, dentry);
 	return dentry;
 
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..e44c7598b68e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2314,6 +2314,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
+	if ((open_flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (open_flags & O_CREAT) {
 		error = nfs_do_create(dir, dentry, mode, open_flags);
 		if (!error) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 25048a3c2364..467f6bc707da 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
 		return -EINVAL;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_check_flags);
diff --git a/fs/open.c b/fs/open.c
index 681d405bc61e..865ea6f70e8c 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	if (WILL_CREATE(flags)) {
 		if (how->mode & ~S_IALLUGO)
 			return -EINVAL;
-		op->mode = how->mode | S_IFREG;
+		if ((flags & (O_MKDIR_MASK)) == O_MKDIR_MASK)
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
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index e4295a5b55b3..ec8c54c91261 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
+	if ((oflags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
 	 * opens (rather than creates), because we do not know if it is a file
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..aef5ca6730be 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 	u64 handle;
 	int err;
 
+	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index a332e79b3207..e31f3a57f07c 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -12,6 +12,8 @@
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
 	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
 
+#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-- 
2.54.0

