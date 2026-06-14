Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2593A6405
	for <linux-fsdevel@vger.kernel.org>; Sun, 14 Jun 2026 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781455432; cv=none; b=qiI/wJLTDgUOjMxr/UZ8fpntSYd1LtmF3itbuuviExHJSqLDs0qiiXoyWU5NHNBQkOpQcEcvWYpqubYaexeLq10cSAk1UJ8HNeuKhstmHHWj0NA9eFm4ovRh0P2xnvGB8fAeoG/VIlqbX+qv5bWBfnRiBgzI5VBzhjRyG+aykYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781455432; c=relaxed/simple;
	bh=km1W7U+y9Ng4jOCxpIW/K1afgAibTW4HQPMrC+bkFN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtmR+zesr2+Zi5qpdINUSFV8rHHLKGdsNc3NeW7JMsi5zJHbJvGdrcKfLWi8XwROR/Jhh5BHSOYjlnkSrHedYGaD3NWJf6aq+64jN4B43EgsDphqP+ilX1Vh/hK/2XZUuk24LUmM/XzPafoun9QsTouUBSTvvZmRkWp/cWp201k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=b96Lwntx; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="b96Lwntx"
X-KPN-MessageId: 351f984e-6810-11f1-96a9-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 351f984e-6810-11f1-96a9-005056abbe64;
	Sun, 14 Jun 2026 18:43:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GDfdmk4HRdD7z3HTVym00t4g0fElZV8nmJg8DrpS4o8=;
	b=b96LwntxIPr4P3B0BQstWdTPie5/nPrrbHh2AgWd58QMRXsiCOZkcuYue/39yj/kSve1qlD9Ym5VV
	 muVjI1BCNObNvXVI2Cz/RWtP02NY3FaUsSeLrfCTQfWKlg4R7tNyrsx/uhWoy2rgBrOr0CPZvEhFsu
	 NzQZ1ZH9rKq6VjNtcMeKIpYXmSpMqF/NwFlMeK/IjynvcrzuJiy36JweKeomNy/DBWULUyYGt/RkgM
	 k3bP0NUNvK0Xu9twFVXetWkAFv8I6qMG9nD8UyoiJ3Wg8M5E+EXC1qFh8H9dxyNeSeRjIqer2ZhA8K
	 3VL1kdZn41P0xGfHiebZ2dLZz52ciIg==
X-KPN-MID: 33|uq+/h00MHg1beF6Pw3GC19tsRVDu0CAZK6z3j5A6hrIHYagnIrNgoxqDqfou2Dt
 UD+lTKvArLSTty/hOSyrtEZ4WK8VqDw7fOnvum1igg+Q=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|l+tLzA+s2hKxX77MviKdWEkkMEOXTwJ7Iz7B9/ykezqikGzNtmXLg8H+JIWCeuh
 DXGMHLZSG91U0SvgJKyMRwA==
Received: from daedalus.home (unknown [178.230.193.94])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 34e5cddf-6810-11f1-8011-005056ab7447;
	Sun, 14 Jun 2026 18:43:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neil@brown.name>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 03/12] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sun, 14 Jun 2026 18:44:29 +0200
Message-ID: <20260614164438.2980769-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
References: <20260614164438.2980769-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To implement O_CREAT|O_DIRECTORY we will have to repeat some of the
logic that is now in vfs_mkdir() (e.g. do error checks in the same
order). Separate this out in vfs_mkdir_no_perm(), which does all the
non-permission related work of vfs_mkdir(). Permission checking for the
lookup_open() path is timed differently because we may just be doing an
open and no create. Similar considerations give rise to
vfs_create_no_perm().

Moving the fsnotify_* calls also allows us to deal with this in one
place for each type of operation. This does mean that we also need
to move the fsnotify_* calls into atomic_open() for the atomic open
case, but this actually reduces duplicate code in open_last_lookups()
and dentry_create().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 105 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index f169d1123b17..6bf1ded26377 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4171,6 +4171,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static inline
+int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
+		       umode_t mode, struct delegated_inode *di)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	int error;
+
+	error = try_break_deleg(dir, di);
+	if (error)
+		return error;
+
+	error = dir->i_op->create(idmap, dir, dentry, mode, true);
+	if (!error)
+		fsnotify_create(dir, dentry);
+
+	return error;
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -4203,13 +4221,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, di);
-	if (error)
-		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode, true);
-	if (!error)
-		fsnotify_create(dir, dentry);
-	return error;
+
+	return vfs_create_no_perm(idmap, dentry, mode, di);
 }
 EXPORT_SYMBOL(vfs_create);
 
@@ -4386,10 +4399,17 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 				error = -ENOENT;
 		}
 	}
+
 	if (error) {
 		dput(dentry);
 		dentry = ERR_PTR(error);
+	} else {
+		if (file->f_mode & FMODE_CREATED)
+			fsnotify_create(dir, dentry);
+		if (file->f_mode & FMODE_OPENED)
+			fsnotify_open(file);
 	}
+
 	return dentry;
 }
 
@@ -4522,6 +4542,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						mode, open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
+
+		fsnotify_create(dir_inode, dentry);
 	}
 
 	return dentry;
@@ -4610,13 +4632,9 @@ static const char *open_last_lookups(struct nameidata *nd,
 		inode_lock(dir->d_inode);
 	else
 		inode_lock_shared(dir->d_inode);
+
 	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
-	if (!IS_ERR(dentry)) {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir->d_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
-	}
+
 	if (open_flag & O_CREAT)
 		inode_unlock(dir->d_inode);
 	else
@@ -5061,13 +5079,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		if (unlikely(create_error) && error == -ENOENT)
 			error = create_error;
 
-		if (!error) {
-			if (file->f_mode & FMODE_CREATED)
-				fsnotify_create(dir->d_inode, dentry);
-			if (file->f_mode & FMODE_OPENED)
-				fsnotify_open(file);
-		}
-
 		path->dentry = dentry;
 
 	} else {
@@ -5219,6 +5230,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return filename_mknodat(AT_FDCWD, name, mode, dev);
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode,
+				 struct delegated_inode *di)
+{
+	int error;
+	struct dentry *de;
+	unsigned max_links = dir->i_sb->s_max_links;
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
+	fsnotify_mkdir(dir, dentry);
+	return dentry;
+
+err:
+	return ERR_PTR(error);
+}
+
 /**
  * vfs_mkdir - create directory returning correct dentry if possible
  * @idmap:		idmap of the mount the inode was found from
@@ -5246,7 +5290,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5262,24 +5305,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
+	de = vfs_mkdir_no_perm(idmap, dir, dentry, mode, delegated_inode);
+	if (IS_ERR(de)) {
+		error = PTR_ERR(de);
 		goto err;
-	if (de) {
-		dput(dentry);
-		dentry = de;
 	}
-	fsnotify_mkdir(dir, dentry);
-	return dentry;
+	return de;
 
 err:
 	end_creating(dentry);
-- 
2.54.0

