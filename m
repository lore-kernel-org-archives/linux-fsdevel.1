Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2293909A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Aug 2026 16:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501245; cv=none; b=gD5s3wPTOwLEni2CTnGm+fvz7qfygYuWwee2oTcfL2hsmoP2vb0Tm6RirIsXdRejvN6i9Yf4E1xpTmvUayCff704m6jvztKbTkF0Wyah+1kaARec7FEQyFrr6vQBkKQdhVVIET4EjdBd4SpYK9/DbcfqAw0L9rztE0CfKqyeU7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501245; c=relaxed/simple;
	bh=H7msf3yI9M5aLnwC5iCcjy/+WO3IohCoTEuXODtmBYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bscwXtAOPqt48nH7nHTksXnTZ46MDhX3fJlpntfiNUenxB7fBGNNaWTATxhjo4OTsdzwL6H3Tt/xjUtSgqEHbg8vo5jk7p8ZvO2hZmZVznlfDWCvJJq59sg2uuHB7uWCjDqhf7YIwIqRsyUvuu2iP20AdjaN4LizY+ZXPTY8ndo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MVu6fOYD; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MVu6fOYD"
X-KPN-MessageId: 8e59cae4-9f0c-11f1-bfbb-00505699b430
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 8e59cae4-9f0c-11f1-bfbb-00505699b430;
	Sun, 23 Aug 2026 18:06:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=B7V1s5RVlb4qOUedRDgd/SrIwd/qrGBdycJP6EIHoVI=;
	b=MVu6fOYDGM0CV/3FOneDr0bEvMg6AsKrSAru8wJKhRk8alAB0Xn7a2XvBZwpmEvkQ4SxLP/hSx0P2
	 okAnbqEITRJZKUlWx3gRUifulFhKwy/EF3ipLBPWxxzfO51YlNuspmjdh6PcR1AUjr9jGRh+ILrSb1
	 WAK8NshVL3Y0T5vtG4HMmYdGfp7ExIR02hwDnqKsN3eZlzi+rTuXbiKGyHiAwOIOTXg2gPkJ9CpwLu
	 pXcNufZAuR628HpHOw4qDGAFY/Jir27IkuLopJS7ZOpiL5QfnwEe1VH++vzPUy0oYYVSQMtw/HoVq1
	 uIfgAfNSgIMMCf1uBQ7oygZXVt/smrQ==
X-KPN-MID: 33|W47J78vGMlThf/uxFte2zdsdRzlJD7EOzXNnVdCacztNQsrRDq7gnlKC+UFDBPP
 UirTumin8X+wJJ2DqycCk4FdT/71w4QhayXMd2aOWA28=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|zLM95cXXSynrj5xN3ehyXHnOAmGIma0CqbydqGo5If8KWX+BlK+D0ghji/2uQM3
 9zjgz4ytoKan2CmiTpDXHZA==
Received: from daedalus.home (unknown [178.231.250.211])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 8e20498c-9f0c-11f1-8ddb-00505699d6e5;
	Sun, 23 Aug 2026 18:06:10 +0200 (CEST)
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
Subject: [PATCH v5 07/10] vfs: move O_IS_MKDIR check from lookup_open() into individual filesystems
Date: Sun, 23 Aug 2026 18:07:03 +0200
Message-ID: <20260823160706.358293-8-jkoolstra@xs4all.nl>
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
index 3829554ca369..b1e0823c87b5 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -776,6 +776,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *dentry,
 	struct inode *inode;
 	int p9_omode;
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index 116b29e95f21..64e0aba08da1 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -238,6 +238,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct dentry *dentry,
 	struct v9fs_session_info *v9ses;
 	struct posix_acl *pacl = NULL, *dacl = NULL;
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *res = v9fs_vfs_lookup(dir, dentry, 0);
 		if (res || d_really_is_positive(dentry))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a4a2a4b6a027..62163b7eca5f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -812,6 +812,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 	      dir, ceph_vinop(dir), dentry, dentry,
 	      d_unhashed(dentry) ? "unhashed" : "hashed", flags, mode);
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (dentry->d_name.len > NAME_MAX)
 		return -ENAMETOOLONG;
 
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d4e0029810c0..55d5844e2655 100644
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
index f361876c5583..3ee1360f1bc2 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -1386,6 +1386,9 @@ static int gfs2_atomic_open(struct inode *dir, struct dentry *dentry,
 {
 	bool excl = !!(flags & O_EXCL);
 
+	if (O_IS_MKDIR(flags))
+		flags &= ~O_CREAT;
+
 	if (d_in_lookup(dentry)) {
 		struct dentry *d = __gfs2_lookup(dir, dentry, file);
 		if (file->f_mode & FMODE_OPENED) {
diff --git a/fs/namei.c b/fs/namei.c
index 6f18a480665b..9da91f081c11 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4531,9 +4531,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out;
 	}
 
-	if (create_dir && dir_inode->i_op->atomic_open)
-		open_flag &= ~O_CREAT;
-
 	file->f_mode &= ~FMODE_CREATED;
 	dentry = d_lookup(dir, &nd->last);
 	for (;;) {
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 36f2e8588922..b4db703c9e8c 100644
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
index 7803bd5bd01f..d1af90c981cd 100644
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
index 0b9eab157432..6e306ddd722b 100644
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

