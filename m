Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795D8353A98
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783183279; cv=none; b=GLJ5hZu/zz7rn7yRF/VbRqfIF2+iW8q9qVsS2Z/m1NOPBr80a529IrmwH3nCH+8SGfMaiCMSkwn4fY1SdyUXeYU3qjkIfjxasC3PyHXLKFYYUbq67GrpATR8Me8qV/Q+dS2imKgIsVQ55RohRH8fyTrlzdcgLobqc94cscRHwu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783183279; c=relaxed/simple;
	bh=4ENuc5ifJwZ3uXGviyr3ejReeZOnrI14Py2Unje2nMQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8CxxWmWmhz0wSGZV48YLUtqwksszrZmvhQxaUKpYD/8VnXL4Zi77EPLKIkiMOMk27BdkciZT69B/jmijLWleLdlbksu3q93A7IcxK67B3T1726fm4wIveEe6cxdf2UXV4pyDLt2NCeFhg88Oegx0bHraMeZZjvzD0MwLSIQlFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=DxsOCZzK; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="DxsOCZzK"
X-KPN-MessageId: 2b3dd835-77c7-11f1-83b1-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 2b3dd835-77c7-11f1-83b1-005056ab378f;
	Sat, 04 Jul 2026 18:41:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=GyXwzuUcpWx25LNe0OdWIXFmTCQDpeEwwQq8tv7hbZU=;
	b=DxsOCZzKbFdI5SAMXLX8ErpmdBK2PrxJjyMWYvUupsJ1H8rIcJOqUm2rg3B6vhXpUpL9Ll91ZkKAI
	 5zfNfAUe53GrpTdttxAAcyB8UmV5pQwZpxR3xUCrtsbjFu+2691Xh6a09B5ZRq8yeo9rqLl8chZ4je
	 gL0un9584iw777kCDTSFw6NmJU0SMSSUTnc5p+8cjx/ex7ZPiCF39C9wBhYSmLOi5R9a015mKLUDB1
	 Y4KhIRKE8Dfmd2G9+PW0+7lFQSDkMEqmXuqb1F4bbyhxiBMzpT0+eaj5UaoQPmEDAjxsiw7MNlkVtu
	 XzxWufuI/TXSu6aPxmotGbPWElIMKCg==
X-KPN-MID: 33|U3l7v7NxhdQuDV+KYl3xO58Te1m9mP2e8qofn0GUVyojRuCR3O1xKscO9AcAj1+
 5cSVZSMvm5WMqIsBLfcyW+lpteu/+cRtPmtiZpBdlYKU=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|lt6leT9yC9yowTa9o8InIf/LhCczEDA/unq/MYdpAyvTsQtgcWBRa3ZzIXZO6mB
 eHdTeAzsmuv7GhFtlJUUMrg==
Received: from daedalus.home (unknown [178.230.195.42])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 2af5c5f6-77c7-11f1-a998-005056abf0db;
	Sat, 04 Jul 2026 18:41:13 +0200 (CEST)
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
Subject: [PATCH v3 03/14] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sat,  4 Jul 2026 18:41:37 +0200
Message-ID: <20260704164149.3480051-4-jkoolstra@xs4all.nl>
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

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 105 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 40f83a942e12..ee47d3f5159f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4169,6 +4169,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static inline
+int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
+		       umode_t mode, struct delegated_inode *di)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	int error;
+
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
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
@@ -4201,13 +4219,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
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
 
@@ -4384,10 +4397,17 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
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
 
@@ -4519,6 +4539,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						mode, open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
+
+		fsnotify_create(dir_inode, dentry);
 	}
 
 	return dentry;
@@ -4607,13 +4629,9 @@ static const char *open_last_lookups(struct nameidata *nd,
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
@@ -5066,13 +5084,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
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
@@ -5224,6 +5235,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
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
@@ -5251,7 +5295,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5267,24 +5310,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EMLINK;
-	if (max_links && dir->i_nlink >= max_links)
-		goto err;
-
-	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
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
2.55.0

