Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE36340D90
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878898; cv=none; b=gHSRK42q2ZV+FQEx2gGY3A2Q4yn4QthZplX1KeiRADoOvW7bTi3dMFEBxEEkI200r+TADMkBifPmdj7JkOkDQGpZ2otVMQI8wqLF/zgzVLtdwWcpRTX5DWJnHN+F/VRdtPcp/qo5Yi6pxEDnOOOK5l00El8cqnmc2RM1za+VeDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878898; c=relaxed/simple;
	bh=ywlBunsgX+iq4/GlUwnveotgrhWkekFoPW3HR5bN0ns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TatblecBOwprY9r1xRDWV5L2AugBUD9zcLo5rx4bgKUCDgRprkisjCbE3jzrETJUHA4+e+3sm2skXzLK4fH/kz9OqHNKXJ0t593PixauE6OJkh/cP46fJHHRZY/3Z5h4kUzsgmz1w/3PbKBaRKlVmXXstEttWv7mJAPmmDAwE2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=B+ZBaa1t; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="B+ZBaa1t"
X-KPN-MessageId: c9b86f7b-7e1a-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id c9b86f7b-7e1a-11f1-bfba-00505699b430;
	Sun, 12 Jul 2026 19:54:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=HmMELR7y+8WfVNUp4IjaZbzIhY4UvARZ+epXBazBtCc=;
	b=B+ZBaa1tIUHX+QFKrPKxjdDdJIRWwKWWuS5XiKy4CEb6mSmF8P0VNCn1XtYenMVxkADVVpactCPoZ
	 c1mZLV0C6/9BhP2xSMkBp6eKszxQ2ReMqwQbybRLH7WO79YdOJ7ZNgvHSlvxQLT0j/JOl2OhzIFW87
	 pDPRHbcUaTNGvcS3VXr1laCNR9T9I1oy0dJLFd1Rhxft0i33ml54/tW6xRoK93S9ZAP1vqTJU9YMV5
	 s64jTtBvO7FHNVvFg74In8K2MfvKo5XC/q/Z62PtnZWRq90OVfXb6RY0RL/s+A6AZnsfbtQ54lB3yg
	 Gm0cThY3mt+ZJKw4quk0jr92PkQTKwQ==
X-KPN-MID: 33|8hJ7XCrr6mxQG8CaZJ6OOH/MScrlejVEqdgZ8R4Vk6pNvFfcJ45UWJrXqOLKDQ2
 +YFUhizO3V4Ozcro2sxOZaV4PAvTxQMffl6SSsqdT1Wc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Tu/15hcSAs80jMqYjnmRNPI++gDKX4Yr3I20qrQSvZJa9ZjiRaAju86tHIz/RNt
 Cyj+qf6hUyIhuSG1WiCRqAA==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id c9875da0-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:54 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 02/10] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sun, 12 Jul 2026 19:55:31 +0200
Message-ID: <20260712175539.1565444-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
References: <20260712175539.1565444-1-jkoolstra@xs4all.nl>
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
 fs/namei.c | 99 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 93e7d3e9bcb4..48ceac6e8848 100644
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
@@ -4203,13 +4221,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
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
 
@@ -4516,6 +4536,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 						mode, open_flag & O_EXCL);
 		if (error)
 			goto out_dput;
+
+		fsnotify_create(dir_inode, dentry);
 	}
 	if (unlikely(create_error) && !dentry->d_inode) {
 		error = create_error;
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
@@ -5224,6 +5235,33 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
+	if (max_links && dir->i_nlink >= max_links)
+		return ERR_PTR(-EMLINK);
+
+	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
+	if (error)
+		return ERR_PTR(error);
+
+	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
+	if (IS_ERR(de))
+		return de;
+	if (de) {
+		dput(dentry);
+		dentry = de;
+	}
+	fsnotify_mkdir(dir, dentry);
+	return dentry;
+}
+
 /**
  * vfs_mkdir - create directory returning correct dentry if possible
  * @idmap:		idmap of the mount the inode was found from
@@ -5251,7 +5289,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5267,24 +5304,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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

