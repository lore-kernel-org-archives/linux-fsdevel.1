Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72349285CBA
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501177; cv=none; b=VCoWWrJCzyuD4mxRgheJhGSLef+8O6nJFhSjn09x6sZn3IQPvVPC//NpbnI5tfi5hTxdw8EZi0pbrfe+rHFGo/RJPR6TMYDXUUBskENFm0m90AxCb0dOkAa2iZZOREQ8JrUw6ci82K5O+LKWgS1W8pNeAO+tZZIuWLQLegpvdO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501177; c=relaxed/simple;
	bh=wJic2UAIxBPyZgLC96Z+WSUYmUOLk7qIkYfZE16zJyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dv41whVaVZi4VQ8bs5OAp038sbPQsC20HpD53gxADWA/1ZOIle+b9NrJvZ3FDaqgGwpvwWVf2hUJ6mC6NCNF3kCQnO/5qdm7EvKHQVGW4TZ3t1hOXw4bQxfj/COHLylemLvBWH4Qhd3/iW2oOGhUMPJ31294Uvh2m701HYb5EBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=N2J6OIxS; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="N2J6OIxS"
X-KPN-MessageId: 8d228739-9f0c-11f1-a5a2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8d228739-9f0c-11f1-a5a2-005056994fde;
	Sun, 23 Aug 2026 18:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=PBexnP9AD6x5gbEnZv5Lm5xsfraWCFmP//CI9dMmy2Y=;
	b=N2J6OIxSX4jTkOB3o7/kflyO26xam2DC/T0+KC7sRpbacu+G6j4qEy6upG3p1ppD2Vswr3GNzptU2
	 bsQbne7bgdnpPTPdTrUr7JQ9RSGi2bLPdikIQw5kosyOb3/hJGSWdRg6dD+PYymILS4nHIXhNzOG2F
	 TcgXAhUqReYzgAEXDIbJqyDBlRVIV+fcVuBAOEKpIcRq0Symwe0DtFNyw8ApKCNQizwbeJ5AZgpGu6
	 vYnyhlP4VqhK1NvizM3250BM/87cFve1MOofnYblrt/GEK51Vj9EtxUAv/VEbw9QHpw9TesD7UZPvX
	 am9gtBNPNvHOGrhOMOWI3/UhZOh2s8w==
X-KPN-MID: 33|fH13FB7Kaef42rY0JazBDs5iV1vYXVqrNTzLpJItR7GfMsHPtLkJA9HOsbrcu+J
 rbUx5gA/G5EtQlnPnHbTMJg==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|fiDKeULooFB3vxQX0+LDNWw24GRuHOJkAg/JGSEkdXDSsD6vfAXBlV9N+tdTT7R
 nKLD6A66A8ZVONE99x2d89w==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8ce72b63-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:08 +0200 (CEST)
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
Subject: [PATCH v5 06/10] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sun, 23 Aug 2026 18:07:02 +0200
Message-ID: <20260823160706.358293-7-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
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

Addressing this race without a proper API is only partially possible:
the caller can immediately fstat() what was opened to verify that it
has the expected inode type, owner and mode. But besides being easy to
get wrong, this cannot establish who created the directory: a directory
created by another process with identical credentials is
indistinguishable from one the caller created itself, so the caller
cannot tell whether the directory is its own to manage.

Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
a regular file exists at the open path; EISDIR if a directory exists at
the path; and to create a regular file if no file exists at the path.
This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
the common path even earlier in FMODE_{OPENED,CREATED} case") causing
ENOTDIR to return in the last case while still creating the file. As
this change was not detected for a long time, Brauner proposed to adopt
the more consistent NetBSD behaviour, i.e. to return EINVAL on the
O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
the EINVAL behaviour has been in the kernel for about 3 years now, no
rollback is expected as a result of userspace reliance on old
behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.

O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
filesystems. These filesystems currenly cannot handle
O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
into a fallback mode by stripping the O_CREAT bit. This causes existing
directories to be succesfully opened, while for targets that should have
been created, -ENOENT is returned. The other option of simply returning
-EINVAL leads to inconsistent behaviour: before ->atomic_open() is
called in lookup_open(), the dcache is queried. So returning -EINVAL
there would make O_CREAT|O_DIRECTORY dependent on the cache state of the
dentry.

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
 fs/namei.c            | 89 ++++++++++++++++++++++++++++++++++---------
 fs/open.c             | 25 ++++++------
 include/linux/fcntl.h |  6 +++
 3 files changed, 92 insertions(+), 28 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 3afae6e87825..6f18a480665b 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
 
 /**
  * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
- *			  should be allowed, or not, on files that already
- *			  exist.
+ *			  should be allowed, or not, on files/directories that
+ *			  already exist.
  * @idmap: idmap of the mount the inode was found from
  * @nd: nameidata pathwalk data
  * @inode: the inode of the file to open
  *
- * Block an O_CREAT open of a FIFO (or a regular file) when:
+ * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
  *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
  *   - the file already exists
  *   - we are in a sticky directory
@@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
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
 
@@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
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
@@ -4334,21 +4348,41 @@ static inline int open_to_namei_flags(int flag)
 
 static int may_o_create(struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
-			umode_t mode)
+			int open_flag, umode_t mode)
 {
-	int error = security_path_mknod(dir, dentry, mode, 0);
+	struct inode *dir_inode = dir->dentry->d_inode;
+	bool create_dir = O_IS_MKDIR(open_flag);
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
+		const struct inode *dir, int open_flag, umode_t mode)
+{
+	if (O_IS_MKDIR(open_flag))
+		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
+	else
+		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 }
 
 /**
@@ -4384,8 +4418,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
+
 	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
-				       open_to_namei_flags(open_flag), mode);
+					     open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 
 	if (!error) {
@@ -4441,6 +4476,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	return dentry;
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
+				 struct dentry *, umode_t,
+				 struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4462,6 +4501,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
+	bool create_dir = O_IS_MKDIR(op->mode);
 	int open_flag;
 	struct dentry *dentry;
 	int error, create_error;
@@ -4482,7 +4522,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		 */
 	}
 	if (open_flag & O_CREAT)
-		inode_lock(dir_inode);
+		inode_lock_nested(dir_inode, I_MUTEX_PARENT);
 	else
 		inode_lock_shared(dir_inode);
 
@@ -4491,6 +4531,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out;
 	}
 
+	if (create_dir && dir_inode->i_op->atomic_open)
+		open_flag &= ~O_CREAT;
+
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
@@ -4534,10 +4577,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
+		mode = o_create_mode(idmap, dir_inode, open_flag, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
-						    dentry, mode);
+						    dentry, open_flag, mode);
 		else
 			create_error = -EROFS;
 	}
@@ -4582,12 +4625,23 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	if (!dir_inode->i_op->create) {
+	if ((create_dir && !dir_inode->i_op->mkdir)
+		|| (!create_dir && !dir_inode->i_op->create)) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
-	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
+	if (create_dir) {
+		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry,
+						       mode, &delegated_inode);
+			error = PTR_ERR_OR_ZERO(res);
+			if (!error)
+				dentry = res;
+	} else {
+		error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
+	}
+	if (error)
+		goto out_dput;
 
 	file->f_mode |= FMODE_CREATED;
 out:
@@ -4717,7 +4771,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(&nd->last))
+		if (trailing_slashes(&nd->last) && !(open_flag & O_DIRECTORY))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4818,8 +4872,9 @@ static int do_open(struct nameidata *nd,
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
@@ -5194,7 +5249,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, flags, mode);
 		if (create_error)
 			flags &= ~O_CREAT;
 
diff --git a/fs/open.c b/fs/open.c
index 6b1c14e684a9..189af02a2425 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1239,29 +1239,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
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
@@ -1319,6 +1320,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
 
 	if (flags & O_CREAT) {
+		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
+			return -EISDIR;
 		op->intent |= LOOKUP_CREATE;
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 6ad6b9e7a226..204e16bbe263 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -30,6 +30,12 @@
  */
 #define __O_REGULAR		(1 << 30)
 
+#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
+static inline bool O_IS_MKDIR(unsigned int flags)
+{
+	return (flags & O_MKDIR_MASK) == O_MKDIR_MASK;
+}
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
-- 
2.55.0

