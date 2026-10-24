Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.186
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877667;
	b=SRm18bV3bcHXIjxcLBgvWesTKdeSTZt0lQ57o8cOc0nF4XvBhlGjrjlhNL3AOBAm2qlX
	 wFLfi/Tsa05cSWg9mm6ZEsvTBxVI+4z+UroqYIBCg2VOijCl4cjAeaHojMF4uBChAuPrO
	 PhyMJckTZmG2WCZosfh0rPLvP3zodi7gvgobbjH35fOGbhlN/eYZCXN6xmrwCxRBL3Xg/
	 6YB6CKKh7XQqt0ANwrniDhzoUoWwbwP6d5JKzSSsokpxD0WO8wNsCB3XpDK1Kbs+mK5jF
	 Pxy3uLcYMo2KSQZVrfV4eLayUiye4gBerSrfuexdgTi1iRl+HxwF9oTj47FVZDaMgvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877667;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qu19ttKoFm8YEIfP2PLvpChIRrU1lR+re7nUflZOGdM=;
	b=QhpfuPpIRlJfoXK4rTbdhfWE2zQQj1tLMInizZtCBQCZwpYC9fI9qG9VydJYW7obtVT2
	 VGzYgq4O1zFldt2gFfS1fGQ5ZWvU0JR6uy3m5VfHjDOY3L4eITgijP0IaZnP2XPWEimPP
	 9zblFT4/DFl9dLUbHAVCvftXYt5/xrd0XTNXmCE1XIM+mlwUloTy22NsyyCXOC7HsgNfp
	 XXA8IyiUPMaUcbIDFog6K+Lkp6J6yE1MmpObQflNq6nQLjkGCgYt5zBUFChIhrv0SSym1
	 lIxzRr0RE3oUxmi1SDKhHTzTPAqQHIAnvMHv4MWXP/0JZWBg1Ee6xG8xn+TeE+0tS2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=vZhT1EIA;
	arc=none smtp.remote-ip=195.121.94.186
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C03606A31E
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52C03606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=vZhT1EIA
X-KPN-MessageId: acb905b2-cff2-11f1-87e5-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id acb905b2-cff2-11f1-87e5-00505699b430;
	Sat, 24 Oct 2026 23:34:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=qu19ttKoFm8YEIfP2PLvpChIRrU1lR+re7nUflZOGdM=;
	b=vZhT1EIAndUYNmiLUmL9gpD36g7nMthZ3Nhk2fTE6CnHgIiw6TSzNP6HARWCfKOCmCtgs0KxYXWyJ
	 Wmbw5qpkbdzRx4EzPOXcbs/oEzIxrIGKBG9eUfqMIBd28RHOXLnKA0aY+6BUgAoA7JtW8R+R14lJmB
	 U21js6gnZrnjwRzJdr197uCjXq87sCRQg7x1qakaU5nLSA89TMPHrFd5eHeWDsMUcdVwkMj7kvChew
	 GpBumLzQ78s0vZgiHr1SMhxxLXoNvIIrFpvkKBx+lVAK+5A6PxAztTGGy6Yde3PQ1SNHgmcA+xa7bW
	 5w4NO0wuhS7uOtsuZvJZTtXPK3vKdbw==
X-KPN-MID: 33|GB8kk1C5gM3lD3CSPXcxj+vt9flM+urEatqRXcdhNE7xIixQrNj+QzlZ2mIYTDV
 4Mze87XXlhrhmH1DsCP2nsw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|hhZ4ehZ1bU02j2B9yyTSqXe1xj951aE5Ci8ZpqhrMm09yi2d/TmtWF7z1/sC0mR
 Mx7a6nLZxAa9Vpq1IEzSRfA==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id ac5a0424-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:21 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org
Cc: jack@suse.cz,
	neil@brown.name,
	cyphar@cyphar.com,
	jlayton@kernel.org,
	amir73il@gmail.com,
	shakeel.butt@linux.dev,
	gregkh@linuxfoundation.org,
	tj@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v8 02/12] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sat, 24 Oct 2026 23:35:29 +0200
Message-ID: <20261024213539.1307600-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
References: <20261024213539.1307600-1-jkoolstra@xs4all.nl>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
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
index b90263a07e4e..9fa94e8079db 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4166,6 +4166,24 @@ static inline umode_t vfs_prepare_mode(const struct mnt_idmap *idmap,
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
@@ -4198,13 +4216,8 @@ int vfs_create(const struct mnt_idmap *idmap, struct dentry *dentry, umode_t mod
 	error = security_inode_create(idmap, dir, dentry, mode);
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
 
@@ -4546,6 +4560,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 			dentry = res;
 		}
 	}
+
 	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
 		/*
 		 * No need to create a file.  If lookup returned a positive
@@ -5368,6 +5383,33 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
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
@@ -5395,7 +5437,6 @@ struct dentry *vfs_mkdir(const struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5411,24 +5452,12 @@ struct dentry *vfs_mkdir(const struct mnt_idmap *idmap, struct inode *dir,
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
2.56.0

