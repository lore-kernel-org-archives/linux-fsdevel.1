Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BD394EB0
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780251595; cv=none; b=Rx0CBIbFWB6EiEPbQFSSJ2nujXbFgJdV4ORR7Mvh2jipQ2a7JuDl93YTbcIwFDaFBCBs/xzlFk6CMyUt0JjOtZ9WYsiAmmwZ2CDhH2iOXfdXwYiEDZdeFHzxCiU/+QHiRXFxJnEwEn4Jtc49BJ6/daLAZzdAPLh+J1ov/ZxNoWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780251595; c=relaxed/simple;
	bh=C/2LWVWDngvB9ucVHgKIjqvDr719sDGqQ92tKG9eZNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrRVY7iKZ5I+zjEJO06exYkyq4Feq5s5IckK5e6wNdLqJ+uESJyHkHw27cYVxvjGjX+N34yvP64u2dpMj6wa7exJe+q/RZHbpwtq/UFERI/a4czO+DSTwqdrxwL4Va/WYAqR6EDCWFUDBEfWGb+WD3JVkXpD7AtfL2xWNnzvNJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=iBQ/NaXv; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="iBQ/NaXv"
X-KPN-MessageId: 51922b33-5d1d-11f1-92b3-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 51922b33-5d1d-11f1-92b3-005056aba152;
	Sun, 31 May 2026 20:19:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=q8nMU3gs3aSiVabh8ieTDz3owJmShMgi82h5KVQxaAQ=;
	b=iBQ/NaXvNzYjDpYS3wpgrkYczEJakbtTN4S7yKVswXLGurypOHS5ZoQQLABrAC9YV/dZGWJxjKejR
	 4Ra6csYsWNdrBCbVeFfq7D0QOh9+j5vwcgRj5c7KC1WyI60Pt75hQlWA2NNP39s3vgrsFjd3ndv80P
	 JwfUo1ukshgpfmkCeHBmYq596QEz35OLe5fwAXSc8Ro+9FOPpcod4gGuYtmfuRaGyWmQzBLxa0qbKX
	 1CJ7b0jQTImvMG8bfTaDKu2VivzpCGNwZRJ8jTWvERDcMT1M5iVJZdVAgcY83euws1Ic5QuVeQdM9Q
	 +yzLRcFhFsjo2LiudlDpMwnKk2Zpu7Q==
X-KPN-MID: 33|QXzer0TfTPNfASE3eGVtH3EScMNbQdhVNt0F+jfVlzIk4OmvA24AS5PNODewAyG
 tpG3IKBi8v7s1FGG3D9xwZw==
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|kvmDwG1kiFptKUtH8LNqUurFdyfTd6tSUMlMpon3U08ikYlcwaV976dVAnKL2f/
 tzEmpxBEWzdgrdflLXDCOKw==
Received: from daedalus.home (unknown [178.227.141.146])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 515c609c-5d1d-11f1-8011-005056ab7447;
	Sun, 31 May 2026 20:19:52 +0200 (CEST)
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
Subject: [RFC PATCH v6 8/9] vfs: move O_IS_MKDIR check out atomic_open() to individual filesystems
Date: Sun, 31 May 2026 20:20:44 +0200
Message-ID: <20260531182045.171711-9-jkoolstra@xs4all.nl>
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

Individual filesystems need to get the chance to implement
O_CREAT|O_DIRECTORY or not, rather than decide this at the VFS level in
atomic_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_inode.c      | 3 +++
 fs/9p/vfs_inode_dotl.c | 3 +++
 fs/ceph/file.c         | 3 +++
 fs/fuse/dir.c          | 3 +++
 fs/gfs2/inode.c        | 3 +++
 fs/namei.c             | 8 ++------
 fs/nfs/dir.c           | 3 +++
 fs/nfs/file.c          | 3 +++
 fs/smb/client/dir.c    | 3 +++
 fs/vboxsf/dir.c        | 3 +++
 10 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index f468acb8ee7d..8eff9320aa8a 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -771,6 +771,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 141fb54db65d..9a63ae0f3b58 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d54d71669176..a82a711a86e6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -813,6 +813,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	err = ceph_wait_on_conflict_unlink(dentry);
 	if (err)
 		return err;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index b658b6baf72f..58f3310f828f 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -940,6 +940,9 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (fuse_is_bad(dir))
 		return -EIO;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	if (d_in_lookup(entry)) {
 		struct dentry *res = fuse_lookup(dir, entry, 0);
 		if (res || d_really_is_positive(entry))
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index e9bf4879c07f..df66ac2d0c15 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1384,6 +1384,9 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index 724b9de6831a..6cc3d42dc1a5 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4409,12 +4409,8 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
-
-	if (O_IS_MKDIR(open_flag))
-		error = EINVAL;
-	else
-		error = dir->i_op->atomic_open(dir, dentry, file,
-					       open_to_namei_flags(open_flag), mode);
+	error = dir->i_op->atomic_open(dir, dentry, file,
+				       open_to_namei_flags(open_flag), mode);
 	d_lookup_done(dentry);
 	if (!error) {
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index e9ce1883288c..cbbc61788d0e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2314,6 +2314,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
+	if (O_IS_MKDIR(open_flags))
+		return -EINVAL;
+
 	if (open_flags & O_CREAT) {
 		error = nfs_do_create(dir, dentry, mode, open_flags);
 		if (!error) {
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 25048a3c2364..b885d8facaf5 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
 	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
 		return -EINVAL;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nfs_check_flags);
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index e4295a5b55b3..b282753713d6 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
+	if (O_IS_MKDIR(oflags))
+		return -EINVAL;
+
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
 	 * opens (rather than creates), because we do not know if it is a file
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 42bedc4ec7af..cc999c1ab7cf 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 	u64 handle;
 	int err;
 
+	if (O_IS_MKDIR(flags))
+		return -EINVAL;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
 		if (res || d_really_is_positive(dentry))
-- 
2.54.0

