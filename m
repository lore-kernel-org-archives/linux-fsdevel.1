Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC988339372
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501233; cv=none; b=e6jct1Tt29LQMZOSlwn/PSf9lj9VVRN+DoKZp6DQHU8YhQ8pvErBkaGZLtifz3xwN2JmGv+ZZ5D4esU0vLre2V8m48vwWCEifGs+7ikjhn97LUCWbMo0bgZg+F8JJDsIpHMh7LkE3EwICpfRgO0CTX/suwMWazwqepRly3+YMtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501233; c=relaxed/simple;
	bh=ze3mtFyHXBfW/BgZf5/VZHXDXjbkyJ+My7CiAwzNgsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oUVgerwvl4sjSzzT4cuGMMpK4skNZIUoflFGiPjUJVKeX1vO058Fip4Fvd3hwSlCvgEe6IB2C4wtLqRhfhteu6OIeKwOAnccISWxDQ+fehfKOfo5q+1G3aCJYr6mAP9tJNGch3LTzoQcOa35YWJXLYXN1nYgNPiHussYiKgUgVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Hm3nqk9K; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Hm3nqk9K"
X-KPN-MessageId: 880f8cfc-9f0c-11f1-a5a2-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 880f8cfc-9f0c-11f1-a5a2-005056994fde;
	Sun, 23 Aug 2026 18:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=iOkGSXunanUbl+67XJPMYRsFwQtLcl/hNXplO8NPaxQ=;
	b=Hm3nqk9KRx++BjvuQBJTQjr22AwNPONbx7wwMX+Pw0YO20MmeWEppQ2Bjsxf+6u6X2F4r1/2ht/i7
	 hzXOS5fwGB2ZBWbmLSm1TBDUqCQfPmYEpUSDw/gzcwP5CSCxylfAmBOee1Y2iAh9C+MfeVhWLRrLyj
	 iTTyZcQ7yyey6+3H4BjRgITZKplWO5rfi3WCUqyxet6YbFjkDNtYBOMYzpv8BYX5/Bl+lunfT1qb+s
	 N1GX49dET+upH/bwDf8GnMWUEIeiaS/XENTHP1l9+gC6i4wGKvTillHKT6Gt1hz0LtkbWGMNbQyA4e
	 RF2SuSwMSxGDDkMpnIUmtfmr4DUxs3A==
X-KPN-MID: 33|IulYgCOnjHLGuZf09mt2qLZlN8HVSH2gt08nWb8bWvxuaOxeN/RQlnDMcvLMVgl
 ScIS92Zdq9RA25HvLJL+UigU4uL+RHlmdOG6KhKEznLI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Fc16PkErUP0RgWxxNWgOgKYEPxtg+oi7u3YZCgY4srlAdBgiQy28oM8YlYsvw2K
 LcCUOS4akeHbmnBevrbSlRw==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 87d63060-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:05:59 +0200 (CEST)
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
Subject: [PATCH v5 02/10] vfs: prepare vfs_creat|mkdir_no_perm for reuse in lookup_open()
Date: Sun, 23 Aug 2026 18:06:58 +0200
Message-ID: <20260823160706.358293-3-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823160706.358293-1-jkoolstra@xs4all.nl>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
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

Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/namei.c | 78 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 54 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index ab1302b38f46..229a5f7329f0 100644
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
@@ -5358,6 +5373,34 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 	return filename_mknodat(AT_FDCWD, name, mode, dev);
 }
 
+/* Returns the dentry to use (not NULL) or -E on error */
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
@@ -5385,7 +5428,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			 struct delegated_inode *delegated_inode)
 {
 	int error;
-	unsigned max_links = dir->i_sb->s_max_links;
 	struct dentry *de;
 
 	error = may_create_dentry(idmap, dir, dentry);
@@ -5401,24 +5443,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
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

