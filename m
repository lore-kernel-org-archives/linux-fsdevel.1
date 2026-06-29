Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637684279FD
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747414; cv=none; b=qGZCRgiVrmtxLLA5gCZk+Xk1k5EBNqs8K+mr4P0WALZSKqkhw/U160oUP+DRpWrtoLoJBBW5cXJsanilVZaCmI2WvhnsPXCAzZ0u4xH4p0b7oqfFYxD4ysaQwzGbxxlUYgt+2bon4jlbGkkdUlM+Bcc9Uo5wkxONtJDV/hPGlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747414; c=relaxed/simple;
	bh=4ENLg9oB9xGFT0tEe1WSIPn0YSoszQVTFC05Aoc9O60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFjsTsWA7DyE/EsF7Oi06iPmuZrcxkCFUJ14Tqazpx04X84oELRu+NAiQtGrK0+sEMFj4irIqggdAWBQv/STck1Kv82VkrGiCFHXwSEfHYx0fcWC5+h/QTuC86hraFN9heLRpxVMGHObzbfkavwvxVgJniRDdf3sITPT7agrTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=s0ucGc0Q; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="s0ucGc0Q"
X-KPN-MessageId: 3183649a-73d0-11f1-bfba-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 3183649a-73d0-11f1-bfba-00505699b430;
	Mon, 29 Jun 2026 17:35:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=jxkBw048GRayTWdl+Bi9OJVH8DJi24jm1KyZ4hLz990=;
	b=s0ucGc0QOE/P7tAgtDkaUMgVcUcoDH2ZVIZ7YdN9OQ1IJBqIfU2ox7Tadks9xEH81t3hdaRLIyq4D
	 QAPAPF6WO1LxeGGsJ/X67O8nwJHwIl1alQt5DGS9IGwsjvTmQi2Ug5qw7xNN0tHKFCdequ6j4SDcpT
	 17TijiLR4Dw2ZADYld4iigWfqzplF9NYtJ7AiNRIC2Db0lRLfZd5zZXpDMvcrEeUf0q55TfHgRjbkS
	 XCFGcXalc67mgKJ4ObxSzY9OMNqf2hYpAilTD15l1RH4DkyrtJol2YbdNIhR8JglA9SxiG1dIldwRd
	 y+QE2VlY/88CcG7+bPPlkej0fhsfSvw==
X-KPN-MID: 33|VoKUil2/kttekjJts9PAFt+g+yYLRjEMaO8T0mneQft5QUGyLykQ4BteiapAYo4
 koCvAw6hwRLFacRFOj+q2bcZNE1zeL6qjg0H5ilLeBOQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|oUwT0GrbvMHdCKXDYvSK8D9WZDt0tHmwngqNo50DAbFv1GbAz1OJIpwwhl1z2rO
 tTlhV5LaLO2GsYE8di59kMA==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 31434b93-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:44 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Al Viro <viro@zeniv.linux.org.uk>,
	NeilBrown <neilb@suse.de>
Cc: Aleksa Sarai <cyphar@cyphar.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	NeilBrown <neil@brown.name>
Subject: [PATCH v2 03/14] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Mon, 29 Jun 2026 17:36:19 +0200
Message-ID: <20260629153630.2158649-4-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
References: <20260629153630.2158649-1-jkoolstra@xs4all.nl>
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
index ed0e41f4e76a..9cdc9191dcda 100644
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
@@ -5062,13 +5080,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
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
@@ -5220,6 +5231,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
@@ -5247,7 +5291,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5263,24 +5306,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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
2.54.0

