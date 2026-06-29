Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC1340801E
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 15:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747355; cv=none; b=lytARyvAjNSd/NRUAJCHn5OCXkuCPodeWORQOxmXgMH1d7syiBQ/9x/Dy3Uj5yUAgykVO5FktILhPAkBGxoHTcG+cfGbnBXOGZIH8BwseK355FGAOCmzmHwdC4MeE5wt+1QQQqwFmgjSPP1TY0JcnjauZwGwVhicv7YXv22ZSMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747355; c=relaxed/simple;
	bh=fSfc+LvdScSVVWtofrORrfU9DFrIQF64woTA7s4dryE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmGs0/a7UeF6MEnX/9T5sS1rncQNzDP5tHuLj4gBN+BVa35dQNsRpgcyXRj26nLrbbaoeWoClwXp93COg7c8+2iz5q3CUpvU1/hUenIaeLziZ+kA4m5x3T996PrUof4snWtly3QezwXQt4GgRcMxRV/8Wcj9R3j0es3MCMp7fb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=Cu445I6r; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="Cu445I6r"
X-KPN-MessageId: 34ad3bf1-73d0-11f1-a59f-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 34ad3bf1-73d0-11f1-a59f-005056994fde;
	Mon, 29 Jun 2026 17:35:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=Y7ap5S+f9pBloJc8i35cfEp5UKIqar85mO8DFm2qX3w=;
	b=Cu445I6rNHibHPrzT0d0ddUw4YDK45MwMrkGytshTKrcv/CKEclT9Fres5Yaf3ScCB8PiC8um3HAt
	 kjIoBwlgj6YzNrE8dkzstRjOHAeVacYjtg6R0ycu7sHw8nhqXgPjZfcfQEyswkxOTHXfExpE9Mdjcd
	 FcCHGSi+vSDaGxgGjZ3exy9Z5LgY1EJBHkwzYR4yyT4ln0zhP2UffLYbhzvvd9Jo8kIJbQeP6DU00G
	 4ya3JYSVEEe26v/ryMA1aUlLPoVXEOkNHew7bMSMQzDMe1g91h0H1MVD+jAGKyYH9EWFgXsRiCeO8v
	 Z2mnNzVw2dcGDtA/xAh9JuxY8ZNeTWA==
X-KPN-MID: 33|WapLcbf6bxFjODx4YbHqUHGSGJVZJzBCzqmWjzAd3WxrEBzHyNiRWbnGDFcEW6y
 wkNf3aBtqN8d6nSOxO1tP7uZVUIQPrvDMQUrYtSJr9iw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|/9dmUd4v0z1/NgzioHO1xItxvnQ4kW1Zsp39lOBXqP7lWzrfUOh5d7FbNYahBr0
 Flvt2sdm9T7hIS7c08tjl1A==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 347979ad-73d0-11f1-8076-005056998788;
	Mon, 29 Jun 2026 17:35:49 +0200 (CEST)
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
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH v2 10/14] vfs: move O_IS_MKDIR check out atomic_open() to individual filesystems
Date: Mon, 29 Jun 2026 17:36:26 +0200
Message-ID: <20260629153630.2158649-11-jkoolstra@xs4all.nl>
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
index f61648025a72..c4b242205707 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4486,9 +4486,6 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (unlikely(IS_DEADDIR(dir_inode)))
 		return ERR_PTR(-ENOENT);
 
-	if (O_IS_MKDIR(open_flag) && dir_inode->i_op->atomic_open)
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
2.54.0

