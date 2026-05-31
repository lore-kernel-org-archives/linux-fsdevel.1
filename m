Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB0A30E0FD
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251592; cv=none; b=kh0bDzkCswGTqcFKWIPCdc9uDDLKLxUKNNBM2CzP5kB1plhnuSSgULuQdVNQn5dKVtZqkhPwc9BZrPrsiyb+9h/+vfGgJz4FegTNBD0vHgfRdgJq0fAyv86wi2zj4qJF1ClyABHZSSoaEknsVjLGFMvTtrz3APMAvW065SPh044=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251592; c=relaxed/simple;
	bh=O3RfnIu+MAK/92YGT+49j2Q1Ah5PouvdP6nZzhBMXyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UjKdc2Dg5Mh7p9Qxi9adoKb1YVtvveVKUFltuHgtuFks/kGLJcyf9y0TlsqPC2QY9C2iVhdrM/qXWOLSOwmsRkRA0B4dEIu5uapE1thVoFTaGx1I1DDfuZAPqGGrH1P33dO8cZDmPIBP+gjeqJSLuulTw9iZJ/IjIScVbOtJByc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Vm9+Jbma; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Vm9+Jbma"
X-KPN-MessageId: 4ea49758-5d1d-11f1-b189-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 4ea49758-5d1d-11f1-b189-005056abad63;
	Sun, 31 May 2026 20:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=QZTROv6wENpAHg79+FWzAw49rtJn58bwTufg2QrAj9o=;
	b=Vm9+JbmaB9032opZQ8fxc89auVA33LQXjN/w83P30m27yIAJQRPYDWPMmQjA7x+1JyNumKilFqoWY
	 K4EQ7YXJAWMXVo7dV+Ykb2nx2TIjFHViUENHDIdru2/rONzZIMu5BBg7gX/eeGcz6fK07I5YBonTeC
	 ea6ggJ8yWv3Z9vGJ60/FwgRcDfnakKuB7rQJ857EucMvKxHAdzsO5LFo+dl0eOYjJF+78DOnHCIUv/
	 XLrWOUYiPKSqOlClm0maRnGmd4m4R62oL4RqemTBtdb7XozGj6XPF6G/JlYSLBGHIvmIm1OOUKBCn4
	 PhNMrVocBDc/8xTbYoyQ8D2vOEc7vug==
X-KPN-MID: 33|IpB8AipPg22g/Ae43XIiwdTtuvghkeSzE03S9wl9MVswdMMsziGdUzKDTKr3wCZ
 abjE7BRWy1pCYO2FGMP9GEZNU3i3W/yN2l/FvFutw/w0=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zJYwD7DKxca0ADcKxYjnR6ltSgP7vdEmZCrVAl+TqKSm6TsYJhYZTiTWNeuFMDf
 O4ICRlXsmpk/N7ILpZ8IQew==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 4e5b0a4f-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:47 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Christian Brauner <brauner@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Charles Mirabile <cmirabil@redhat.com>
Subject: [RFC PATCH v6 3/9] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sun, 31 May 2026 20:20:39 +0200
Message-ID: <20260531182045.171711-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531182045.171711-1-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
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
index 4cd132fe3981..2a35dd72ee96 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4171,6 +4171,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
 	return mode;
 }
 
+static inline
+int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
+		       umode_t mode, struct delegated_inode *di, bool excl)
+{
+	struct inode *dir = d_inode(dentry->d_parent);
+	int error;
+
+	error = try_break_deleg(dir, di);
+	if (error)
+		return error;
+
+	error = dir->i_op->create(idmap, dir, dentry, mode, excl);
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
+	return vfs_create_no_perm(idmap, dentry, mode, di, /*excl=*/ true);
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
@@ -5051,13 +5069,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
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
@@ -5209,6 +5220,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
@@ -5236,7 +5280,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5252,24 +5295,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EMLINK;
-	if (max_links && dir->i_nlink >= max_links)
+	de = vfs_mkdir_no_perm(idmap, dir, dentry, mode, delegated_inode);
+	if (IS_ERR(de)) {
+		error = PTR_ERR(de);
 		goto err;
-
-	error = try_break_deleg(dir, delegated_inode);
-	if (error)
-		goto err;
-
-	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
-	error = PTR_ERR(de);
-	if (IS_ERR(de))
-		goto err;
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

