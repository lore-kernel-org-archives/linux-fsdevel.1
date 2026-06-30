Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5628401A3C
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782816935; cv=none; b=jtR+wtXAITcUX0NkE0PSVJJc4Oq/uHk0J6U3ZJ4X+nM0ltiLueUHuk2U6Dv3ifo94B+2452enwxdMQaz43rva6YCu9iqNhTLTNmq4O+4iE0hhVMqDgMpum2Nr7POhhFgf++oxW+P8n2hfkYLUJVuXY9P6ktx6eM4Yc4UPPxKEd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782816935; c=relaxed/simple;
	bh=iEm7MNm+mvIGu51a+Lp2bUnPgMp6AMYwf4DhAAd4XyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFmMP0nwoNeCbMczdyyhFxxaEN6SxlguUphGWUWDAgQ2pbZ1sAWChcOZPC/n9qjrEWis3tDx7Rqnkjn7KbMCAqT8u8EY1h7y/uOpp6WDi4YWd76ujCrAOfsIdXS11Vw1CMlPfixs0vqn1UZhp0f6xBAucNhrQxhKzvRksyeN/5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=p+nY7g+N; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="p+nY7g+N"
X-KPN-MessageId: 0c1cf9cd-7472-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0c1cf9cd-7472-11f1-a055-005056abad63;
	Tue, 30 Jun 2026 12:54:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=JonRgd8u+HUOBquhCGr5RMV7SOU35isiwYmU1lIMTRs=;
	b=p+nY7g+N/t0kzRvmY9J2fAQMfMFBWZU0D/sfgcaPT2BKDOBtNLwKRUv5W/jLjP/KYqim+TWzFxCEH
	 yOzsu9j2ieA0kRERDj0uh8PCARBedyVfKNWiPkuwv11aSkSudNvpHqGqOHChfXFbwHEq5Ga/P5ojm/
	 QEmbJ2hm+jKFPAbmL13zmfoXW9U17nRa6wNuzPTR1BKP/svGvu23ZApVREzYfIPs1aQVBCBpRxVz39
	 SqwkT68h2rcwzsFQ28tyOM7V9HRV0C+8XhgxBZSSkwW2Devz4XIt25IY05UmxcnO7TVUaJ37Rmk3xa
	 BaCe08Fu7fdCilSv+nssrf3LUmpXSHw==
X-KPN-MID: 33|Rpb2ndmwaKCVsbTeqwvj+vEIq1vtk7b73NFKctQ9CHHuvOFh5xAlcN0fdnrkAyL
 EFDOK1u8gDiYTQIgalv7XlQSTXWx1XloDLShhgLq4hUY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|pIDkH+HWQ7tmxpeT3MCnopVEcsbFwFVxChb+rWmwdek+7+8w8z3kOLNGL73f9kS
 1e6FtGsr14vhZgFMUX+C7OA==
Received: from lt-jori.home (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 0c01fe21-7472-11f1-91b9-005056ab1411;
	Tue, 30 Jun 2026 12:54:20 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	NeilBrown <neil@brown.name>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 01/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
Date: Tue, 30 Jun 2026 12:53:30 +0200
Message-ID: <20260630105400.68459-2-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630105400.68459-1-jkoolstra@xs4all.nl>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a comment in vfs_prepare_mode() that says:

  Note that it's currently valid for @type to be 0 if a directory is
  created. Filesystems raise that flag individually and we need to check
  whether each filesystem can deal with receiving S_IFDIR from the vfs
  before we enforce a non-zero type.

It is safe to do this clean-up except that three filesystems (fuse,
cifs, and coda) forward the mkdir @mode unchanged to something outside
the kernel. Mask S_IFDIR back out in coda_mkdir(), fuse_mkdir() and
cifs_mkdir() so that what is sent outside the kernel is unchanged.
Their maintainers can drop the mask once they have confirmed it is safe.

Assisted-by: Claude Opus 4.8 (1M context)
Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/coda/dir.c         | 7 ++++++-
 fs/fuse/dir.c         | 8 ++++++++
 fs/namei.c            | 7 +------
 fs/smb/client/inode.c | 7 +++++++
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 835eb7fdfdad..9ad4d217c8b6 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -179,7 +179,12 @@ static struct dentry *coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (is_root_inode(dir) && coda_iscontrol(name, len))
 		return ERR_PTR(-EPERM);
 
-	attrs.va_mode = mode;
+	/*
+	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
+	 * verbatim to userspace, which has only ever been given the permission
+	 * bits. Strip the type bit until venus is known to cope with it.
+	 */
+	attrs.va_mode = mode & ~S_IFDIR;
 	error = venus_mkdir(dir->i_sb, coda_i2f(dir),
 			       name, len, &newfid, &attrs);
 	if (error)
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e2a1039fa43..7decbe4ea48a 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1117,6 +1117,14 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fm->fc->dont_mask)
 		mode &= ~current_umask();
 
+	/*
+	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
+	 * verbatim to the userspace server which has only ever been given the
+	 * permission bits. Strip the type bit until the protocol is known to
+	 * cope with it.
+	 */
+	mode &= ~S_IFDIR;
+
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
 	inarg.umask = current_umask();
diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..6554803d6903 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4140,11 +4140,6 @@ EXPORT_SYMBOL(end_renaming);
  * after setgid stripping allows the same ordering for both non-POSIX ACL and
  * POSIX ACL supporting filesystems.
  *
- * Note that it's currently valid for @type to be 0 if a directory is created.
- * Filesystems raise that flag individually and we need to check whether each
- * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
- * non-zero type.
- *
  * Returns: mode to be passed to the filesystem
  */
 static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
@@ -5256,7 +5251,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	if (!dir->i_op->mkdir)
 		goto err;
 
-	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
+	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
 		goto err;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 1dbcfd163ff0..369dfd56c1e6 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2282,6 +2282,13 @@ struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
 	const char *full_path;
 	void *page;
 
+	/*
+	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
+	 * verbatim to the server and in the past only contained permission
+	 * bits. Strip the type bit until SMB is verified to deal with it.
+	 */
+	mode &= ~S_IFDIR;
+
 	cifs_dbg(FYI, "In cifs_mkdir, mode = %04ho inode = 0x%p\n",
 		 mode, inode);
 
-- 
2.54.0

