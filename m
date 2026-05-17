Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6323280037
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 17:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779037375; cv=none; b=NUV0XvnW9c/6GMgu9IBAWON7grKPHIW1N+ifZ9a8anXIYrZq4+8lXmQEIUdmQU+J0y80QP7araoWMzHbDBJQXs4uq5dtzoLh0QjnX+JYs7ElPFnKS7ZSAb6qWq/nlu/8e2sKoKG2mdrA3q9RKIJweR/Y8fyg26wh5AIOL7616UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779037375; c=relaxed/simple;
	bh=xnFUoklBjQQOYeEbzhYQBisf8DlNj2ndF/UPgpdiaEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VHGU+NQaoxL5vmBPmQeZcMvUKU7Ae70NnYhwkslL3dgMq+GjM19wG2pj+xSCDPvEtuDOkYIw2Ko5EH5cGN56SeQLf3gnqq69Vf7cs9QBE90vOkosDJdRH2SxskOqSXyGGYq/1By8zRBwnY+QfI8ld9qkMTKbs1r7gniLp71eMpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=XHG2sMy1; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="XHG2sMy1"
X-KPN-MessageId: 15138924-5212-11f1-afe2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 15138924-5212-11f1-afe2-005056994fde;
	Sun, 17 May 2026 19:01:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=A/GAIsJncJcMXw7Jso9MzQmaseDTfL7bYiKFuPuaIVY=;
	b=XHG2sMy15VC7Q99N3xxSGQRRPD7vcnxcHO5j2tUIBVtH16EPcSK698O39c0HEGGlkvqcsG4dWXFZp
	 QyGmrDeib0d0Hz2spsD/Iv8TodBNoX6oj8AKl1BLo8G9XZKPIHICUCLmcn2mGe1CK5mqrpIUu1e/gY
	 NasT+abhAvU6BbutCCYF1AVoTrH6dThMQ4q66IAmu2WUo3OXy0F0VbVfitKH0ZI2g0ZKZYwEzWeXzI
	 xrp76juuLuyqn39TlQbr3CGtt2Hgpi3TEd9XFPUjBs6GSJI8RrkkLdi7NQJdminAK30pIyCHU4irwJ
	 wQerVNLEanbWGeM4pY9xbRSSQDyvFzw==
X-KPN-MID: 33|jOA5+CI4G233IqFHbB/iHOTX0unvI7Q343uYabxB5+XZRuoLXcfp29nsgfKgIhz
 EOU4Oyt91Pkwkd3mkfoh1Wm5tKcZlM0XlryEc/9tOcp8=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/ZA3CX0zQdQQqbWYFjWy2AMIR25qVbcfddGthJX4t65JPMS8eqjwgXoPRxqvUQg
 GMN8ICC0FaAx1hQJZ2TC7Lg==
Received: from daedalus.home (unknown [178.227.141.161])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 14d974d3-5212-11f1-abb2-00505699b758;
	Sun, 17 May 2026 19:01:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	cmirabil@redhat.com
Subject: [RFC PATCH v3 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 17 May 2026 19:02:43 +0200
Message-ID: <20260517170244.1832119-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517170244.1832119-1-jkoolstra@xs4all.nl>
References: <20260517170244.1832119-1-jkoolstra@xs4all.nl>
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

This feature idea (and some of its description) is taken from the
UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c                       | 186 ++++++++++++++++++++-----------
 fs/open.c                        |  23 ++--
 include/uapi/asm-generic/fcntl.h |   2 +
 3 files changed, 132 insertions(+), 79 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..5e852dbac171 100644
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
+		        struct delegated_inode *di)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	int error = try_break_deleg(dir, di);
+	if (error)
+		return error;
+	return dir->i_op->create(idmap, dir, dentry, mode, true);
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
+	error = __vfs_create(idmap, dentry, mode, di);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4320,24 +4333,36 @@ static inline int open_to_namei_flags(int flag)
 }
 
 static int may_o_create(struct mnt_idmap *idmap,
-			const struct path *dir, struct dentry *dentry,
-			umode_t mode)
+                        const struct path *dir, struct dentry *dentry,
+                        umode_t mode, bool create_dir)
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
 
+
 /*
  * Attempt to atomically look up, create and open a file from a negative
  * dentry.
@@ -4359,6 +4384,11 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	struct inode *dir =  path->dentry->d_inode;
 	int error;
 
+	if ((open_flag & O_MKDIR) == O_MKDIR) {
+		error = -ENOTSUPP;
+		goto out;
+	}
+
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
 	error = dir->i_op->atomic_open(dir, dentry, file,
@@ -4381,6 +4411,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 				error = -ENOENT;
 		}
 	}
+out:
 	if (error) {
 		dput(dentry);
 		dentry = ERR_PTR(error);
@@ -4388,6 +4419,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	return dentry;
 }
 
+static struct dentry *__vfs_mkdir(struct mnt_idmap *, struct inode *,
+			 struct dentry *, umode_t,
+			 struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4412,8 +4446,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
+	int error = 0, create_error = 0;
 	umode_t mode = op->mode;
+	bool create_dir = (open_flag & O_MKDIR) == O_MKDIR;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
@@ -4462,10 +4497,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
@@ -4494,29 +4529,32 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
+		if ((create_dir && !dir_inode->i_op->mkdir) || !dir_inode->i_op->create) {
+			error = -EOPNOTSUPP;
 			goto out_dput;
 		}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+		if (create_dir) {
+			dentry = __vfs_mkdir(idmap, dir_inode, dentry, mode, delegated_inode);
+			if (IS_ERR(dentry))
+				error = PTR_ERR(dentry);
+		} else {
+			error = __vfs_create(idmap, dentry, mode, delegated_inode);
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
@@ -4524,23 +4562,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
 
-	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd))
-			return ERR_PTR(-EISDIR);
-
-		/* Don't bother on an O_EXCL create */
-		if (open_flag & O_EXCL)
-			return NULL;
-	}
+	/* Don't bother on an O_EXCL create */
+	if ((open_flag & (O_CREAT|O_EXCL)) == (O_CREAT|O_EXCL))
+		return NULL;
 
 	if (trailing_slashes(nd))
 		nd->flags |= LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
@@ -4610,8 +4638,12 @@ static const char *open_last_lookups(struct nameidata *nd,
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
@@ -4672,12 +4704,14 @@ static int do_open(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
-		if (d_is_dir(nd->path.dentry))
-			return -EISDIR;
-		error = may_create_in_sticky(idmap, nd,
-					     d_backing_inode(nd->path.dentry));
-		if (unlikely(error))
-			return error;
+		/* There are no special rules about creating directories
+		 * in sticky folders */
+		if (!(open_flag & O_DIRECTORY)) {
+			error = may_create_in_sticky(idmap, nd,
+						     d_backing_inode(nd->path.dentry));
+			if (unlikely(error))
+				return error;
+		}
 	}
 	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
 		return -ENOTDIR;
@@ -5039,7 +5073,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, mode, false);
 		if (create_error)
 			flags &= ~O_CREAT;
 
@@ -5207,6 +5241,36 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
+	error = PTR_ERR(de);
+	if (IS_ERR(de))
+		goto err;
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
@@ -5231,17 +5295,14 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
  */
 struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct dentry *dentry, umode_t mode,
-			 struct delegated_inode *delegated_inode)
+			 struct delegated_inode *di)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
-	struct dentry *de;
-
 	error = may_create_dentry(idmap, dir, dentry);
 	if (error)
 		goto err;
 
-	error = -EPERM;
+	error = -EOPNOTSUPP;
 	if (!dir->i_op->mkdir)
 		goto err;
 
@@ -5250,21 +5311,10 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
+	dentry = __vfs_mkdir(idmap, dir, dentry, mode, di);
+	if (IS_ERR(dentry)) {
+		error = PTR_ERR(dentry);
 		goto err;
-	if (de) {
-		dput(dentry);
-		dentry = de;
 	}
 	fsnotify_mkdir(dir, dentry);
 	return dentry;
diff --git a/fs/open.c b/fs/open.c
index 681d405bc61e..9155a3083163 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	if (WILL_CREATE(flags)) {
 		if (how->mode & ~S_IALLUGO)
 			return -EINVAL;
-		op->mode = how->mode | S_IFREG;
+		if (flags & O_DIRECTORY)
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
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 613475285643..6cef32cc0270 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -95,6 +95,8 @@
 #define O_NDELAY	O_NONBLOCK
 #endif
 
+#define O_MKDIR		(O_CREAT | O_DIRECTORY)
+
 #define F_DUPFD		0	/* dup */
 #define F_GETFD		1	/* get close_on_exec */
 #define F_SETFD		2	/* set/clear close_on_exec */
-- 
2.54.0

