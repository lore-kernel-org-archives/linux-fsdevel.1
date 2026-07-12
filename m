Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B13399346
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 17:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783878908; cv=none; b=IejwVMiazBGf1tL4wSbmGO8F1T1fkbA5sS5cqndeK4waEHyu+lfd0fPqsbSaTU2riwU+lSR2NYKV4ToNAzY6OQ5TsuZRxl4iQjS+D41Kz3xgpQ87ansXHs1VQ/so1gY6LUmU7AS0LeA/XJ/Rz4IFCe0/I4ZAmp2QK8okUjcBKqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783878908; c=relaxed/simple;
	bh=E4Pb6p53miVEFMWyKU+KSkiVVIR56GuI60a8mVAEwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srGYi5YlHD1bEkUITfJA7yPFXKpvGryAQp1WgUHuTEqebob3Vh9fl12XH1L0xobqbPNC1xjOU+rLEXVNidYrHw4CLimj8aLEfMrHkaBuRgAaq8sOoRstxpwtVzrzLlBeBIlHtGU/i8zUae+PT+NRsWEU8PuxVJaCkVWnCeBF7D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=cQ28XVFv; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="cQ28XVFv"
X-KPN-MessageId: ccfaf910-7e1a-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ccfaf910-7e1a-11f1-a59f-005056994fde;
	Sun, 12 Jul 2026 19:54:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=hN03yIEJ2j1fBq9AKp5W2RNSMHZOTRTubd4pHVxaK1E=;
	b=cQ28XVFvptX9KTlMwqeS9diS6lFKFMuuJd8A4Cwe86XThklUSkGfpvSGaGMPtEHTtuvO8Vw80QazD
	 EKBv1CNEjIT1EDel/Sp6s6zQCandnyvWCfnNmCdsyJTcIGhYSOsWEUk/h8muh6NmuxJyUP7gxmE6c8
	 xPPXXtLd8uZzKFweAbVU8S793J2koB+qWbz+JwEPbkL/r1RLf2rxwn7WSIWXb4+hvx2VqKk/HjDfs3
	 T0YEHfEuc34eCWj0mWWAzgm2QJ1AP1N3859PXNJ3LXqqS4ALKSKNn2CB5nvQzBV1wNiWUwTpVslaDT
	 s/O5ZBw035Z5x6qsTJurVnQyt2Hmhwg==
X-KPN-MID: 33|BbU/Iet9AWXEmYEYS5qmNIX8vYwc0lVtvWqeWuZwRwnnFgM+sKidN0FM4sek7Xs
 Iytqt8FKSCg8FqwHLkzngQ1aruFxt19rGXY+fSqJ07cE=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|PK6+2z7+UE388LuI1NxigM2Em/c+H6BXWHto72qif/CvJSFxYT4At26Lm9WMSPn
 yK6KUhFYfoGEPIIngecxzvw==
Received: from daedalus.home (unknown [178.230.226.124])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id cccb8e77-7e1a-11f1-87f7-00505699b758;
	Sun, 12 Jul 2026 19:54:59 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	NeilBrown <neil@brown.name>
Cc: Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH 07/10] vfs: move O_IS_MKDIR check from lookup_open() into individual filesystems
Date: Sun, 12 Jul 2026 19:55:36 +0200
Message-ID: <20260712175539.1565444-8-jkoolstra@xs4all.nl>
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

Individual filesystems that implement ->atomic_open() need to get the
chance to implement O_CREAT|O_DIRECTORY or not, rather than decide
this at the VFS level in lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_inode.c      | 3 +++
 fs/9p/vfs_inode_dotl.c | 3 +++
 fs/ceph/file.c         | 3 +++
 fs/fuse/dir.c          | 3 +++
 fs/gfs2/inode.c        | 3 +++
 fs/namei.c             | 3 ---
 fs/nfs/dir.c           | 6 ++++++
 fs/smb/client/dir.c    | 3 +++
 fs/vboxsf/dir.c        | 3 +++
 9 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5783d0336f96..bb555e5ba261 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -777,6 +777,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f7396d20cb6c..ff3facb420c2 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 71161f2b2151..e79abdbd9f61 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -811,6 +811,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	      dir, ceph_vinop(dir), dentry, dentry,
 	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e2a1039fa43..e01869565d5e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -935,6 +935,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (fuse_is_bad(dir))
 		return -EIO;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a77794bbd4a..9859ae0341a9 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1387,6 +1387,9 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index b37d2b0826b3..ffc63a6960f9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4483,9 +4483,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
 
-	if (create_dir && dir_inode->i_op->atomic_open)
-		open_flag &= ~O_CREAT;
-
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c7b723c18620..c815d9aa9b69 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2121,6 +2121,9 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	dfprintk(VFS, "NFS: atomic_open(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
+	if (O_IS_MKDIR(open_flags))
+		open_flags &= ~O_CREAT;
+
 	err = nfs_check_flags(open_flags);
 	if (err)
 		return err;
@@ -2313,6 +2316,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	 */
 	int error = 0;
 
+	if (O_IS_MKDIR(open_flags))
+		open_flags &= ~O_CREAT;
+
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 88a4a1787ff0..75bf86cc0612 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -538,6 +538,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
+	if (O_IS_MKDIR(oflags))
+		oflags &= ~O_CREAT;
+
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
 	 * opens (rather than creates), because we do not know if it is a file
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index c5bd3271aa96..77ae2f696fd4 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 	u64 handle;
 	int err;
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
 		if (res || d_really_is_positive(dentry))
-- 
2.55.0

