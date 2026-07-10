Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E07043C041
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701724; cv=none; b=dm0Izo71DEYIUiE3HTZ0YKvSpD2rMNogGCxIjuLd7ArXpWsQVwDlYfIZ1JR2pkkzxHA6j0+wM9MxTa5DxX2eXrAEfRuhimApmE/B2fwqVpcDcL6L1p2ABo3tECUf6APrOlBaCXTxBipA/F79upDxxudOPRXUYf9zkRzPl7aDBQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701724; c=relaxed/simple;
	bh=c5NLeuCRyg/D85do36wYFZn68+i6CPLHdutUNIiftio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEkOGlIPQxXOWrUA9lbbkFYacG7pdL1YtgGdUCdJZaNiDnTi0G9Jlq70UGnJBM860dMuYb0v3Y6m6u1W7F0Scpl351JL/npjv9hghAq8N2VXv8u8len9Z3q9RSBJ1HC0VHllRuNRvSDXjIA+HsYiLJu24/c/ODhQ9JSbM3tdlD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=diLzhWBx; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="diLzhWBx"
X-KPN-MessageId: 40cbbcd5-7c7e-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 40cbbcd5-7c7e-11f1-861c-005056aba152;
	Fri, 10 Jul 2026 18:41:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=gjoisDfXKw9DGzuiEZ2rIVlOa9uh2ZG9Ti1GuL5VNBM=;
	b=diLzhWBxBBwGAQoXeuwe0iKglKxYETO8w2NME0/cHqcyXZROe2WCzEO547jI2kmEEzhbIPn6YVdyh
	 NOAqp5+XlKaprXhl08HWgRsNkALNQ3TvMXx3r3zHr9Pe8Pxx1lDImGtuixBn4UawQO6zZ/XeaxIBms
	 S+z8JT9sDMDa+Y9KM+cKQjjDgOLw8Q05b9C+JNJFxBu1stmIB6Si68Mu+0PRlSDHVf9aVR5+qybW/C
	 Us9tJkU8Jx5PLT0Q9zIWeUXWvWA+NEUgCY3tXWcfx/O74qI1CeBJcbofzi1aPhllGJo4NNsgCtkvCn
	 MjUoLHQLDlvgWNUSEVIJwRQns/K5D2w==
X-KPN-MID: 33|eA0585xDsxFLyZmSRP6UeYcEV2baMa8B5ZnMCc7wIkzDNri0eKTvW5kauzBZ2pH
 igbfvCZ9DcDwvR52ZYUe83HUU9z+tJpO0SR8y4WlyxYI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|FA4rqP2NGyrRx/4X9J5wdJdmQIa2Veduhw1wKUOTKbiAgblkrqFfuUG1FitEo1K
 ksXe46eLqbsqcfv64OhujBw==
Received: from daedalus.home (unknown [178.229.235.145])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 408d6eb2-7c7e-11f1-91ec-005056ab1411;
	Fri, 10 Jul 2026 18:41:51 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: Jan Kara <jack@suse.cz>,
	NeilBrown <neil@brown.name>,
	linux-fsdevel@vger.kernel.org,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 2/3] vfs: call audit_inode_child() in lookup_open() on failure
Date: Fri, 10 Jul 2026 18:42:32 +0200
Message-ID: <20260710164233.827744-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260710164233.827744-1-jkoolstra@xs4all.nl>
References: <20260710164233.827744-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

audit_inode_child() is called in may_create_dentry() so that failed
filesystem operations still register an audit entry. On success, the
entry is overwritten when, for instance, fsnotify_create() is called.
This is the calling convention in vfs_create() and vfs_mkdir().
In lookup_open(), however, when atomic_open() should have created a
file but didn't, no call to audit_inode_child() is made. The same is
true for the regular ->create() path.

Fix the calling of audit_inode_child() in lookup_open() to match the
vfs_create() path. For the ->atomic_open() filesystems this logic has
been pushed into atomic_open(). This function is also reordered a bit
to make the case distinction of the possible returns from
->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).

When retrying delegation breaking, audit_inode_child() could be called
more than once, but this is OK because those entries are reused.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 92 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 55 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 447eda7cbe34..fe5d59c6f925 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4351,35 +4351,55 @@ static int may_o_create(struct mnt_idmap *idmap,
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
-				  int open_flag, umode_t mode)
+				  int open_flag, umode_t mode, int create_error)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
-	struct inode *dir =  path->dentry->d_inode;
+	struct inode *dir_inode = path->dentry->d_inode;
 	int error;
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
-	error = dir->i_op->atomic_open(dir, dentry, file,
+	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
+
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
-			if (unlikely(dentry != file->f_path.dentry)) {
+			/* finish_open() called */
+			struct dentry *opened = file->f_path.dentry;
+			if (unlikely(opened != dentry)) {
 				dput(dentry);
-				dentry = dget(file->f_path.dentry);
+				dentry = dget(opened);
 			}
-		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
-			error = -EIO;
-		} else {
-			if (file->f_path.dentry) {
+		} else if (likely(file->f_path.dentry != DENTRY_NOT_SET)) {
+			/* finish_no_open() called */
+			struct dentry *replaced = file->f_path.dentry;
+			if (replaced) {
 				dput(dentry);
-				dentry = file->f_path.dentry;
+				dentry = replaced;
 			}
 			if (unlikely(d_is_negative(dentry)))
 				error = -ENOENT;
+		} else {
+			const char *fsname = dentry->d_sb->s_type->name;
+			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n",
+			        fsname);
+			error = -EIO;
 		}
 	}
+
 	if (error) {
+		if (unlikely(create_error) && error == -ENOENT) {
+			/*
+			 * Should have done a create, but errored before.
+			 * Some filesystems return -ENOENT directly instead of
+			 * calling finish_no_open() with a negative dentry;
+			 * either way it should only mean the child doesn't exist,
+			 * so a refused create is safe to record here.
+			 */
+			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
+			error = create_error;
+		}
 		dput(dentry);
 		dentry = ERR_PTR(error);
 	}
@@ -4437,7 +4457,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = NULL;
 	}
 	if (dentry->d_inode) {
-		/* Cached positive dentry: will open in f_op->open */
+		/* Cached positive dentry: will open in do_open(). */
 		return dentry;
 	}
 
@@ -4471,10 +4491,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (dir_inode->i_op->atomic_open) {
 		if (nd->flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
-		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
-		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
-			dentry = ERR_PTR(create_error);
-		return dentry;
+		return atomic_open(&nd->path, dentry, file, open_flag, mode, create_error);
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -4490,32 +4507,36 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
+		/* No need to create a file. If lookup returned a positive
+		 * dentry, the file will be opened in do_open(). */
+		return dentry;
+	}
+
+	/* Negative dentry with O_CREAT flag set */
+	audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	if (unlikely(create_error) && !dentry->d_inode) {
+	if (unlikely(create_error)) {
+		/* should have done a create, but we already errored */
 		error = create_error;
 		goto out_dput;
 	}
 
-	/* Negative dentry, just create the file */
-	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-		if (error)
-			goto out_dput;
-
-		file->f_mode |= FMODE_CREATED;
-		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	if (error)
+		goto out_dput;
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
-		if (error)
-			goto out_dput;
+	file->f_mode |= FMODE_CREATED;
+	if (!dir_inode->i_op->create) {
+		error = -EACCES;
+		goto out_dput;
 	}
 
+	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
+					mode, open_flag & O_EXCL);
+	if (error)
+		goto out_dput;
+
 	return dentry;
 
 out_dput:
@@ -5053,7 +5074,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 
 		/* atomic_open will dput(dentry) on error */
 		dget(orig_dentry);
-		dentry = atomic_open(path, dentry, file, flags, mode);
+		dentry = atomic_open(path, dentry, file, flags, mode, create_error);
 		error = PTR_ERR_OR_ZERO(dentry);
 
 		if (IS_ERR(dentry))
@@ -5063,9 +5084,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 			/* Drop the extra reference */
 			dput(orig_dentry);
 
-		if (unlikely(create_error) && error == -ENOENT)
-			error = create_error;
-
 		if (!error) {
 			if (file->f_mode & FMODE_CREATED)
 				fsnotify_create(dir->d_inode, dentry);
-- 
2.55.0

