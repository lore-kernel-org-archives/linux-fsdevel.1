Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27A13F8EBE
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 18:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789325381; cv=none; b=rf7twZmYM8Ax3qz2ZRqji6O2DZgDIh/4WDj/1IXM5RMDc+Ac3uiVzI3B4mKslXSmPix6nXBgBUllmhP9v8vSywcmqOI6dSKGdt1huJ2KZwXYrJCqVtw9OQ7+clVTmQ7911f+zsdZLxLNPkvTIHA5euwL3czeFYpHlQ9CHynTtxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789325381; c=relaxed/simple;
	bh=juPNHvpWR92dCr36HgIiioaSqiCioGjAOnDebjSe7Mk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SJ4ypd98oOGz+bQNLLMBd7JvjETZ6O9PjzQZkTisrsv4JEJbhPW25yi8WjEWtFG8+YGbNd4e3HQY8oprDNQSaYu6tTgSac6/Ua6zuOLuz9BKdsVLcAsxlKqnWYPzy3ukEPClBRG4YXjkVjf5Ud7oKSDXiA9fdBH10jck4J72fS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fjxZWtBm; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fjxZWtBm"
X-KPN-MessageId: dd536b56-afa3-11f1-a059-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id dd536b56-afa3-11f1-a059-005056abad63;
	Sun, 13 Sep 2026 20:49:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=/y+qiZvJ5no0j7LSJlCXAfcdzUGAl8ZOlwquBX6X96E=;
	b=fjxZWtBmIAiIuCUJm9JVIfJM2xJ4QfZkIkKRAHElHHWRooGpw1z3scJ7fq1N22s4O3aXx5TBe62EC
	 C6epsT5R0rseHMh7U3HV6BSVmDhb2XlKsOgPU7ExrE2okSxiLcq+RvnZUI9Yk+WPEH7I6h8ikha1EL
	 2ip9GoR+aQRQLJ35jGbQczdfA9ka4gJk05SRe23WuZ27F7GAgEgOJSvQgZRbKGsInl9cEpe2MG8gVe
	 KYZ02wcrbfp6i/VvxY14UuacSSPvD3BSdJsXULkvD/0du743k5O3v5iDwzu9CogZu0dWD/38k+JtaK
	 lPLQ422izqGxgnS5P/trebmRCsDiFIA==
X-KPN-MID: 33|WN5pIgXInmzLTLvj6H3i2BvrAdDZK4C99Gp7o8mPo3KWYG/bQC8GqCLbSMV0Pj0
 xCEzOu5bzPayRpIR8MRSPl5ytugCuyxch/e3R6Op93u4=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|DAqJoBDPbmQGg2vwGqVACLJ4pUCSZoEKTZCJriJsftrneTUqU60iBzDso7lHjvN
 dnFMb+pBXxEmaI51GV220kw==
Received: from daedalus.home (unknown [178.231.250.207])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id dd19800c-afa3-11f1-bd2b-005056abf0db;
	Sun, 13 Sep 2026 20:49:35 +0200 (CEST)
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
Subject: [PATCH v6 09/12] vfs: move O_IS_MKDIR check from lookup_open() into individual filesystems
Date: Sun, 13 Sep 2026 20:50:13 +0200
Message-ID: <20260913185016.523376-10-jkoolstra@xs4all.nl>
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

Individual filesystems that implement ->atomic_open() need to get the
chance to implement O_CREAT|O_DIRECTORY or not, rather than decide
this at the VFS level in lookup_open().

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_inode.c      |  5 +++++
 fs/9p/vfs_inode_dotl.c |  5 +++++
 fs/ceph/file.c         |  5 +++++
 fs/fuse/dir.c          |  5 +++++
 fs/gfs2/inode.c        |  5 +++++
 fs/namei.c             |  3 ---
 fs/nfs/dir.c           | 10 ++++++++++
 fs/smb/client/dir.c    |  5 +++++
 fs/vboxsf/dir.c        |  5 +++++
 9 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 3829554ca369..dd810904ff6c 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -776,6 +776,11 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 116b29e95f21..9308184aee61 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -238,6 +238,11 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		omode = 0;
+	}
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index bd3e3f5c269e..9235143edd9a 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -812,6 +812,11 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	      dir, ceph_vinop(dir), dentry, dentry,
 	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index e49b4e874b15..a3e7daba61dc 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -944,6 +944,11 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct fuse_conn *fc = get_fuse_conn(dir);
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (fuse_is_bad(dir))
 		return -EIO;
 
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index f361876c5583..69e100a68e2c 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1386,6 +1386,11 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index f31046f8b3ba..a990c9c8bddf 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4535,9 +4535,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	mode = op->mode;
 	create_error = 0;
 
-	if (create_dir && dir_inode->i_op->atomic_open)
-		open_flag &= ~O_CREAT;
-
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 49394123bd09..4b1404d6859e 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2121,6 +2121,11 @@ int nfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	dfprintk(VFS, "NFS: atomic_open(%s/%llu), %pd\n",
 			dir->i_sb->s_id, dir->i_ino, dentry);
 
+	if (O_IS_MKDIR(open_flags)) {
+		open_flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	err = nfs_check_flags(open_flags);
 	if (err)
 		return err;
@@ -2317,6 +2322,11 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
 	 */
 	int error = 0;
 
+	if (O_IS_MKDIR(open_flags)) {
+		open_flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
 		return -ENAMETOOLONG;
 
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 6fa6d48fdfd3..f75095a48fdb 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -534,6 +534,11 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 	if (unlikely(cifs_forced_shutdown(cifs_sb)))
 		return smb_EIO(smb_eio_trace_forced_shutdown);
 
+	if (O_IS_MKDIR(oflags)) {
+		oflags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	/*
 	 * Posix open is only called (at lookup time) for file create now. For
 	 * opens (rather than creates), because we do not know if it is a file
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index 0b9eab157432..f20b61f6d8da 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -318,6 +318,11 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
 	u64 handle;
 	int err;
 
+	if (O_IS_MKDIR(flags)) {
+		flags &= ~O_CREAT;
+		mode = 0;
+	}
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
 		if (res || d_really_is_positive(dentry))
-- 
2.55.0

