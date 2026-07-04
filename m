Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CD9372B58
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183281; cv=none; b=TK6bGoJD9pPHjZEb4NoTob0DGJHRMF6G7OnMHFQPwYOb7DskSZiRqKqcyvaw3Mqu0zVKu8rbeEA3qbLT/t+XAv9zgQKP7W+3R5tvg3afiMMGBVVPcG+0aKmi+nXGkaCjTj0ay2Olefp7LFYFPIOYp30wpvhuprIFtxhEKAmJdRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183281; c=relaxed/simple;
	bh=bvYgTIQc9D2R4oaXpBX/K77LWIiYru+DdhNkOgbTsCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=keGu2t0LSPhfjIGmbbdyD8KIAXA8Wv67Nad+M3g8h7Jl/rcxBmjjEMGX752C5YtCIVX1P0CBz7O3xrjHogLRezdvzUOr66TCmDrIyxwUGWyV6qAy8zNxBwPGKZJKzV2YjE1lUkjLSrIBG34P+xSQAAgvAFQvhHTksD/OJTYK9S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=LDXEQjva; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="LDXEQjva"
X-KPN-MessageId: 2bd9fed4-77c7-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2bd9fed4-77c7-11f1-83b1-005056ab378f;
	Sat, 04 Jul 2026 18:41:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GtkjJ/4R2rxo8JEAlzIZ55lWA6ArrnaDppuG/xB4dRo=;
	b=LDXEQjva+BWMPgnvHIELRh2k3zUPbXt4NbTcSMwSPer3s/j26GLyLhYPLAM9Dw8CT0mH5YMdxtS1K
	 v9D3Hi56o+sZVSBKdHb+Wzb587QBHGuE26EiF0/xScsBVAin4k85r5FPRw0IfxOkl6gLVoH672Q4v9
	 VjkzuBagWkNGoaahhCVSEE1kElRt9RessgDlKkpCkV9G6a3bXIbTL/5CzzrQCGEBtmyAbcYibb7hW1
	 u10IzqNnPPSkqUOkN+52PAu8FxnNyoc+0XOhdATRzRy/nEseG4neUSqtf208VON4sewnR6IHB1tqK5
	 TFGt9OHeqXzUrOoSTTlknYwRDBcFn5A==
X-KPN-MID: 33|+nIcN2KopJPMxkIsR+EcW1HeifioMhtZZ/wdl0aosLsLh6ax6fAlne1JASji73i
 OOfUcOveTiURp3RbygR5Ql5NOnjviZzSvJvdV3vdTPjU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|iWEXKhD4H2F1HTAwT0mS+zz5KdSbSwCEnBZq0csl4/zJDmxySjdLUyj7Jb2uaoN
 Or776/MM8ECG9SAq4WIyEUQ==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2b90ca9b-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:14 +0200 (CEST)
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
Subject: [PATCH v3 04/14] vfs: call audit_inode_child() in lookup_open() on failure too
Date: Sat,  4 Jul 2026 18:41:38 +0200
Message-ID: <20260704164149.3480051-5-jkoolstra@xs4all.nl>
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
 fs/namei.c | 75 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ee47d3f5159f..956adcd14c4a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4369,10 +4369,11 @@ static int may_o_create(struct mnt_idmap *idmap,
  */
 static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
 				  struct file *file,
-				  int open_flag, umode_t mode)
+				  int open_flag, umode_t mode, bool create_error)
 {
 	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
 	struct inode *dir =  path->dentry->d_inode;
+	bool failed_create = false;
 	int error;
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
@@ -4382,23 +4383,33 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
-			if (unlikely(dentry != file->f_path.dentry)) {
+			// finish_open() called
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
+			// finish_no_open() called
+			struct dentry *replaced = file->f_path.dentry;
+			if (replaced) {
 				dput(dentry);
-				dentry = file->f_path.dentry;
+				dentry = replaced;
 			}
 			if (unlikely(d_is_negative(dentry)))
 				error = -ENOENT;
+			if (error && create_error) // should have created, but errored before
+				failed_create = true;
+		} else {
+			const char *fsname = dentry->d_sb->s_type->name;
+			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n", fsname);
+			error = -EIO;
 		}
 	}
 
 	if (error) {
+		if (failed_create)
+			audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
 		dput(dentry);
 		dentry = ERR_PTR(error);
 	} else {
@@ -4462,7 +4473,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		dentry = NULL;
 	}
 	if (dentry->d_inode) {
-		/* Cached positive dentry: will open in f_op->open */
+		/* Cached positive dentry: will open in do_open(). */
 		return dentry;
 	}
 
@@ -4496,7 +4507,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (dir_inode->i_op->atomic_open) {
 		if (nd->flags & LOOKUP_DIRECTORY)
 			open_flag |= O_DIRECTORY;
-		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
+		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode, create_error);
 		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
 			dentry = ERR_PTR(create_error);
 		return dentry;
@@ -4515,33 +4526,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
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
+	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	if (unlikely(create_error) && !dentry->d_inode) {
+	if (unlikely(create_error)) {
+		/* Should have done a create, but we already errored */
 		error = create_error;
 		goto out_dput;
 	}
 
-	/* Negative dentry, just create the file */
-	if (!dentry->d_inode && (open_flag & O_CREAT)) {
-		/* but break the directory lease first! */
-		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
-		if (error)
-			goto out_dput;
+	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
+	if (error)
+		goto out_dput;
 
-		file->f_mode |= FMODE_CREATED;
-		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
-		if (!dir_inode->i_op->create) {
-			error = -EACCES;
-			goto out_dput;
-		}
+	file->f_mode |= FMODE_CREATED;
+	if (!dir_inode->i_op->create) {
+		error = -EACCES;
+		goto out_dput;
+	}
 
-		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
-		if (error)
-			goto out_dput;
+	error = dir_inode->i_op->create(idmap, dir_inode, dentry,
+					mode, open_flag & O_EXCL);
+	if (error)
+		goto out_dput;
 
-		fsnotify_create(dir_inode, dentry);
-	}
+	fsnotify_create(dir_inode, dentry);
 
 	return dentry;
 
@@ -5071,7 +5086,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 
 		/* atomic_open will dput(dentry) on error */
 		dget(orig_dentry);
-		dentry = atomic_open(path, dentry, file, flags, mode);
+		dentry = atomic_open(path, dentry, file, flags, mode, create_error);
 		error = PTR_ERR_OR_ZERO(dentry);
 
 		if (IS_ERR(dentry))
-- 
2.55.0

