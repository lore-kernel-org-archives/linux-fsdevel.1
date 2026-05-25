Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD4C346FC3
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704087; cv=none; b=VjmMmkZ5BcZ0PnzPuOEYIecwIcJFDhr1pbDZKPiqJKQy/siH2UjkTTEC84TPQIqktKU0gks/Ljkv2f+uFXVJlAZz8DvpSJ4Y83Z+8xB5bNBrJcv4dTuqXSWLoVwNo3a7gbu8obDP03hJEY/csK+mEaC9if+Vqw/S9b48vcVxrl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704087; c=relaxed/simple;
	bh=njMyQmgcgWv8wirnAr2ZMXp5gU2hzCehFIRv/NmmHTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QIkEbWIJNPZEa4Oo6yyIkHhC/0nskGXtyImHBFv4jNFZ+fQzuDkrZ7jQUp4IfNVieKNsmcRLldjNPKIkAB6jvP2c5Y2ceP8oIYcc39/aa7ltx/sghZZfj4tGg+WgRIwKpnWQHh6fC4woxEnSxduyKsr8UCSITDINrKQ1Z04l5uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=UAprXr4P; arc=none smtp.client-ip=195.121.94.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="UAprXr4P"
X-KPN-MessageId: 87c8694c-5822-11f1-bea8-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 87c8694c-5822-11f1-bea8-005056992ed3;
	Mon, 25 May 2026 12:14:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=6erTSGNk+o0IjdcqM90a09N994D+Y748G3wwetXHMBo=;
	b=UAprXr4PxtRPdTSD9NSQuwxNXRfNt2IYzfmKv3EufPE3tmoZbcuZn6GPox9o3+KTaylpRN/cr+L28
	 1cWY4cvYLkisaHcnEuHIAIaNQUsQZqHWBpGeD16wEEmpBil7FuD/du8ugcfaYa3VrqdO2z2RAZEngT
	 V1rPfp6sJHykqfAQzy3tMSr84RnJkQfSnh4sL4TNAN8GXet5/mFNTH18yCN3vv/ZqMYOxN2nzkNG0d
	 DboGIECbhC6T94lbk5wyxzeR5aJ4CVAR/TKhk54herNqKHlDz/RMrrDH2D3+r+qjI058RHNi43XWlw
	 Ll5HFqYC3xQNpuPcRZVX2jQ/b549HWg==
X-KPN-MID: 33|9vG8fQopisqHwsXHDpWO5kgRHUmwJMKa3W0akDOAdSqTDtoWKxz35iK52XFP/s/
 YALl8MlKEjKP1d93mQjTxa2+LfgDbz7xjE0dR6q3ngbM=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|wl5Ho9h/Ip48hZhVNA4v9q6ZSxn+iqTouTeA4md/GKGyZQjddT27bcJe3QcxlIe
 YRk5aYBDH+RJPKTb8eHuyoA==
Received: from daedalus.home (unknown [178.227.141.192])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 84fc9fb9-5822-11f1-86da-005056998788;
	Mon, 25 May 2026 12:14:35 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH] vfs: nfsd4: fix held lock on atomic_open() failure
Date: Mon, 25 May 2026 12:15:44 +0200
Message-ID: <20260525101544.195832-1-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While working on O_CREAT|O_DIRECTORY I came across a possble unreleased
lock in nfsd4_create_file(). This functions passes the child dentry via
nfsd4_vfs_create() to dentry_create(). If the atomic_open() call in
dentry_create() fails, path->dentry is set to an ERR_PTR value and this
is passed back to nfsd4_create_file(), which ultimately calls
end_creating(child). But since end_creating() is a noop when passed an
error pointer, inode_unlock(de->d_parent->d_inode) is never called on
the parent.

There are several options to remedy this; in this patch I changed
dentry_create() so that path->dentry does not get an error pointer
assigned. This does mean that atomic_open() needs to be changed so that
it doesn't dput() on error. This does not seem to be the responsibility
of atomic_open() but should rather be left to the caller anyway, just
like with the vfs_* functions.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 74 +++++++++++++++++++++++++++++++-----------------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index c7fac83c9a85..b58d8be99838 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4342,14 +4342,14 @@ static int may_o_create(struct mnt_idmap *idmap,
  * Attempt to atomically look up, create and open a file from a negative
  * dentry.
  *
- * Returns 0 if successful.  The file will have been created and attached to
- * @file by the filesystem calling finish_open().
- *
- * If the file was looked up only or didn't need creating, FMODE_OPENED won't
- * be set.  The caller will need to perform the open themselves.  @path will
- * have been updated to point to the new dentry.  This may be negative.
- *
- * Returns an error code otherwise.
+ * If FMODE_OPENED is set, the file will have been created and attached to
+ * @file by the filesystem calling finish_open(). If the file was looked up
+ * only (no O_CREAT flag), FMODE_OPENED won't be set. The caller will need
+ * to perform the open themselves. @path will have been updated to point to
+ * the new dentry. This may be negative. atomic_open() does not consume
+ * @dentry on error, but will dput() it if the filesystem replaces it.
+ *
+ * Returns the opened/looked-up dentry on success or ERR_PTR(-E) on failure.
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
@@ -4365,24 +4365,30 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 	if (!error) {
-		if (file->f_mode & FMODE_OPENED) {
-			if (unlikely(dentry != file->f_path.dentry)) {
-				dput(dentry);
-				dentry = dget(file->f_path.dentry);
-			}
-		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
+		struct dentry *new = file->f_path.dentry;
+
+		if (WARN_ON(new == DENTRY_NOT_SET)) {
 			error = -EIO;
-		} else {
-			if (file->f_path.dentry) {
+		} else if (file->f_mode & FMODE_OPENED) {
+			// finish_open() called
+			if (unlikely(dentry != new)) {
 				dput(dentry);
-				dentry = file->f_path.dentry;
+				dentry = dget(new);
 			}
-			if (unlikely(d_is_negative(dentry)))
+		} else if (new) {
+			// finish_no_open() called with dentry replaced
+			if (unlikely(d_is_negative(new))) {
+				dput(new);
 				error = -ENOENT;
+			} else {
+				dput(dentry);
+				dentry = new;
+			}
+		} else if (unlikely(d_is_negative(dentry))) {
+			error = -ENOENT;
 		}
 	}
 	if (error) {
-		dput(dentry);
 		dentry = ERR_PTR(error);
 	}
 	return dentry;
@@ -4412,7 +4418,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	struct inode *dir_inode = dir->d_inode;
 	int open_flag = op->open_flag;
 	struct dentry *dentry;
-	int error, create_error = 0;
+	int error = 0, create_error = 0;
 	umode_t mode = op->mode;
 	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
 
@@ -4474,10 +4480,13 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (dir_inode->i_op->atomic_open) {
 		if (nd->flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
-		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
-		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
-			dentry = ERR_PTR(create_error);
-		return dentry;
+		struct dentry *res = atomic_open(&nd->path, dentry, file, open_flag, mode);
+		error = PTR_ERR_OR_ZERO(res);
+		if (unlikely(create_error) && error == -ENOENT)
+			error = create_error;
+		if (error)
+			goto out_dput;
+		return res;
 	}
 
 	if (d_in_lookup(dentry)) {
@@ -5036,28 +5045,29 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 	idmap = mnt_idmap(path->mnt);
 
 	if (dir_inode->i_op->atomic_open) {
-		path->dentry = dir;
+		const struct path dir_path = { .mnt = path->mnt, .dentry = dir };
+		struct dentry *res;
+
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, &dir_path, dentry, mode);
 		if (create_error)
 			flags &= ~O_CREAT;
 
-		dentry = atomic_open(path, dentry, file, flags, mode);
-		error = PTR_ERR_OR_ZERO(dentry);
+		res = atomic_open(&dir_path, dentry, file, flags, mode);
+		error = PTR_ERR_OR_ZERO(res);
 
 		if (unlikely(create_error) && error == -ENOENT)
 			error = create_error;
 
 		if (!error) {
 			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir->d_inode, dentry);
+				fsnotify_create(dir->d_inode, res);
 			if (file->f_mode & FMODE_OPENED)
 				fsnotify_open(file);
-		}
-
-		path->dentry = dentry;
 
+			path->dentry = res;
+		}
 	} else {
 		error = vfs_create(mnt_idmap(path->mnt), path->dentry, mode, NULL);
 		if (!error)
-- 
2.54.0

