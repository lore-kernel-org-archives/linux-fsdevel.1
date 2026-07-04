Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E14934A796
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183293; cv=none; b=IRUEEOaC5NzniORcPIpCX97Kho6LiOrUYmndZOmpZBWwBfysqs0uSRIJQBoJxG4+pv/PQUzrc2xo55coWwmhZaAgnhjih987fUGrEnYD4NmzT+lcovpl1AjJMCiymhIPkctNSw/2wn4DgaafjgPVB0Qhn+7tpnThqoVR7yjfXrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183293; c=relaxed/simple;
	bh=lPDteEwxsHU1piwmnsarATyysuiO06z09mKpVCsoINM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TDrpZjc1d4yH9gGv1CCnzE4p9lKGloecF6J2yc7YZoxjpuA8DpI5v30w1dHdS2dwTl/dltLbzoZoMDdutFvKBRyUieLnt/G3Ze1DZlN6UkQkVUznxWChU4lJDMUEPSB6tDXk48BXj9XqdPPRztF569ULQxPt4N5ns96IetTx+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=k9vpeLJo; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="k9vpeLJo"
X-KPN-MessageId: 2f9e3aef-77c7-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2f9e3aef-77c7-11f1-861c-005056aba152;
	Sat, 04 Jul 2026 18:41:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=EnAOc5GtW6hyNP+cqSXX7D/7rTzrI6y7XfKAeboZT+A=;
	b=k9vpeLJoYzEjF6di3GW/hzPADVmAzh/iqc49rZseYWW3/CQxkuft5rWxkMR0BJ+oZfperF2lh9Gwq
	 SRs5/qdQ1fOL9TJQFdtAuNxl/kxL4wZQm/OT00DB13g7wc5uzqylP3/yTKshpvR+iVWCKDOFZbl3hR
	 gHL5AjgFZQcKrfUnVZ05K3v0kDnFCvH5l0qs/3tPyxPzgrwSSi2n5tddBX2aD/PjUanruwwrFjI2hT
	 42gYSN9d4rArhOiFXvvbxE+HIalNdeRoao9a5Qtvsb7+lGHObahGsl7TZUGywOOhfcuOMwFWwGnQjo
	 NuHfU/9/JSS/IFSr8vfQQzLUlNzrusw==
X-KPN-MID: 33|uRB8tm71e13LDuaDUp+cUr6pVgN2HqjovTrkG2Ih+o9nEIIqek1GdAgDucejDLS
 +sPp3mKMGL9ShR5PBzALcJw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|m1/SObismygvFofnceBD6o/JLHo+606zf3Kq2ijRHTO70uF3VNlroYRUFTzri+D
 7MXywR0njDtR5vkZYVqiduA==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2f5aa38c-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeff Layton <jlayton@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sat,  4 Jul 2026 18:41:43 +0200
Message-ID: <20260704164149.3480051-10-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
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

O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
filesystems. This is implemented by stripping the O_CREAT bit. The other
option of simply returning -EINVAL leads to inconsistent behaviour:
before ->atomic_open() is called in lookup_open(), the dcache is
queried. So returning -EINVAL there would make open(O_CREAT|O_DIRECTORY)
dependent on the cache state of the dentry. By stripping the O_CREAT
bit, lookup is consistently performed on ->atomic_open() filesystems.

There is no separate sysctl for directory creation implemented currently.
Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
not enough to allow creating a directory in a sticky folder, because that
may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
newer kernels.

This feature idea (and some of its description) is taken from the
UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c            | 86 +++++++++++++++++++++++++++++++++++--------
 fs/open.c             | 25 +++++++------
 include/linux/fcntl.h |  6 +++
 3 files changed, 90 insertions(+), 27 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index eaa0ade4a1b0..5113ac986f50 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1382,13 +1382,12 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 
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
@@ -1416,6 +1415,14 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 	if (likely(!(dir_mode & S_ISVTX)))
 		return 0;
 
+	/*
+	 * There is no separate sysctl for directory creation in sticky
+	 * folders. Therefore, for the S_ISDIR case, disabling
+	 * sysctl_protected_regular is not enough to allow creating a
+	 * directory in a sticky folder, because that may surprise users
+	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
+	 * kernels.
+	 */
 	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
 		return 0;
 
@@ -1447,6 +1454,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
 					      "sticky_create_regular");
 			return -EACCES;
 		}
+
+		if (S_ISDIR(inode->i_mode)) {
+			audit_log_path_denied(AUDIT_ANOM_CREAT,
+					      "sticky_create_dir");
+			return -EACCES;
+		}
 	}
 
 	return 0;
@@ -4337,21 +4350,40 @@ static inline int open_to_namei_flags(int flag)
 
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
@@ -4385,6 +4417,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
+
 	error = dir->i_op->atomic_open(dir, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
@@ -4429,6 +4462,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	return dentry;
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
+				 struct dentry *, umode_t,
+				 struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4455,10 +4492,14 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct dentry *dentry;
 	int error, create_error = 0;
 	umode_t mode = op->mode;
+	bool create_dir = O_IS_MKDIR(open_flag);
 
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
 
+	if (O_IS_MKDIR(open_flag) && dir_inode->i_op->atomic_open)
+		open_flag &= ~O_CREAT;
+
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
@@ -4502,10 +4543,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
@@ -4548,12 +4589,24 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	if (!dir_inode->i_op->create) {
+	if ((create_dir && !dir_inode->i_op->mkdir)
+	    || (!create_dir && !dir_inode->i_op->create)) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
-	error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
+	if (create_dir) {
+		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
+						       mode, delegated_inode);
+		if (IS_ERR(res)) {
+			error = PTR_ERR(res);
+		} else {
+			error = 0;
+			dentry = res;
+		}
+	} else {
+		error = vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
+	}
 	if (error)
 		goto out_dput;
 
@@ -4571,7 +4624,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(nd->last))
+		if (trailing_slashes(nd->last) && !(open_flag & O_DIRECTORY))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4642,7 +4695,7 @@ static const char *open_last_lookups(struct nameidata *nd,
 		 */
 	}
 	if (open_flag & O_CREAT)
-		inode_lock(dir->d_inode);
+		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
 	else
 		inode_lock_shared(dir->d_inode);
 
@@ -4705,8 +4758,9 @@ static int do_open(struct nameidata *nd,
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
@@ -5081,7 +5135,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, mode, /*create_dir=*/ false);
 		if (create_error)
 			flags &= ~O_CREAT;
 
diff --git a/fs/open.c b/fs/open.c
index 408925d7bd0b..9121aece78bc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1190,29 +1190,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
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
@@ -1270,6 +1271,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
 	if (flags & O_CREAT) {
+		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
+			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 6ad6b9e7a226..6b75277be559 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -30,6 +30,12 @@
  */
 #define __O_REGULAR		(1 << 30)
 
+#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
+static inline bool O_IS_MKDIR(unsigned flags)
+{
+	return (flags & O_MKDIR_MASK) == O_MKDIR_MASK;
+}
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-- 
2.55.0

