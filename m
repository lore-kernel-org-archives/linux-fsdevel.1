Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBB73F9F28
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325424; cv=none; b=GBaNa/LJWKSdGv0pL+BJZsVvgcBkmSz0Y4jmH0HFoTr35TPZZ+3lxjMp3xIBrWwhY95m40g1i6FekvdQcmroCZNGsQJUM6LBazCk8YJ+OrRDUui5hqgdDRnZYQk2pfqJHiCtNyZsq9ci+bn8VfSMMBGH3pDWFS20oe6dfy9gJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325424; c=relaxed/simple;
	bh=nucgdV4mNEmYrMJHxpmwiU0YhgkIr0SBgSG4/hH2Ous=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pGFrt/2w47Yevd3Zf0w2dX/ufRfJpDsUK46v8NncidVWZ/RuR4V5bSCmcqCIt6KBadjodVouhKxBvzP6DlZplPlcNoomXtezhssOkKi+tIWA8quZ04QhdAdH1K35ljaNZbzskbZNWguD2YUG1Pv01pkiHDM1yCGxmMdC0UEktI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Cb2RDh2B; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Cb2RDh2B"
X-KPN-MessageId: cdfd343c-afa3-11f1-a059-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cdfd343c-afa3-11f1-a059-005056abad63;
	Sun, 13 Sep 2026 20:49:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=FlXU4SBy6RoYNqXkd7secHUCvokLAIMbonJXzD2/4Z0=;
	b=Cb2RDh2BI19mG7uKJOjuhqDyGWjJlPJeP2yC5qhw1y452rWGhX+oVZgjLEAm7mSLPDokLw5OBpeBq
	 hmVtAQqIFZOM6rAebqdX9eHr8+YNne+PD6RgMV2KptwJM6uxBbqy/Ub2xYJBmth3Uj4yIUZXeFiBNH
	 KIbxnGrTPN3y9480dCKLRaxzHGCgjFlXxK9kLCCp3ilcKfxKdGRRiip0u106JYO0kPZAKPdlcIyfwH
	 8bgiwRLy8u28YxpBj8ic5Y4BuS7n3pLdjpjtQc7qSrrC3XDjJajEWaHswu4sg2Stq1KkpeDq0ALMfz
	 B59eXAdlJrWRgRSPUZZPFsvAAEvNqaA==
X-KPN-MID: 33|mxX592kQSy43fxwnxheixYb0Hz52W4Cowqrk8kDcGU1zJwMR0WeF3a+tacE/QEE
 2xemoH40wIxfIW/WN33FegAISF1PGy0Au8lcXnNMohI4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|xRTrjB7Hakujodgfn7IfDSiRqTup9HkdPKV2CaGrclBtfD94fOjOuw+puvfgMdI
 eV14bClkMk/CMyd/hdiUrNQ==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cdc6c7e3-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:09 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Aleksa Sarai <aleksa@amutable.com>,
	NeilBrown <neil@brown.name>,
	Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v6 02/12] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sun, 13 Sep 2026 20:50:06 +0200
Message-ID: <20260913185016.523376-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260913185016.523376-1-jkoolstra@xs4all.nl>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
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

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 77 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ab1302b38f46..d8401aa3100d 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4166,6 +4166,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
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
+	error = dir->i_op->create(idmap, dir, dentry, mode);
+	if (!error)
+		fsnotify_create(dir, dentry);
+
+	return error;
+}
+
 /**
  * vfs_create - create new file
  * @idmap:	idmap of the mount the inode was found from
@@ -4198,13 +4216,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
-	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
-	if (error)
-		return error;
-	error = dir->i_op->create(idmap, dir, dentry, mode);
-	if (!error)
-		fsnotify_create(dir, dentry);
-	return error;
+
+	return vfs_create_no_perm(idmap, dentry, mode, di);
 }
 EXPORT_SYMBOL(vfs_create);
 
@@ -4418,6 +4431,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 		dput(dentry);
 		dentry = ERR_PTR(error);
 	}
+
 	return dentry;
 }
 
@@ -4544,6 +4558,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+
 	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
 		/*
 		 * No need to create a file.  If lookup returned a positive
@@ -5358,6 +5373,33 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return filename_mknodat(AT_FDCWD, name, mode, dev);
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *idmap, struct inode *dir,
+				 struct dentry *dentry, umode_t mode,
+				 struct delegated_inode *di)
+{
+	unsigned max_links = dir->i_sb->s_max_links;
+	struct dentry *de;
+	int error;
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
@@ -5385,7 +5427,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5401,24 +5442,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (error)
 		goto err;
 
-	error = -EMLINK;
-	if (max_links && dir->i_nlink >= max_links)
-		goto err;
-
-	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, delegated_inode);
-	if (error)
+	de = vfs_mkdir_no_perm(idmap, dir, dentry, mode, delegated_inode);
+	if (IS_ERR(de)) {
+		error = PTR_ERR(de);
 		goto err;
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
2.55.0

