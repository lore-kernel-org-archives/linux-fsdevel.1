Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDD3B5F50
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 11:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782906724; cv=none; b=DwEcUagJ5nP7ftWBQ3zWJU3qYypC9wCaxXJUsnpM4Gers10ceJLy+wHD5EYfB8nYhnWGJzjRAeJYCp8/vFXEJpEWD2rYwvX6fbcYw2aYyahPqf2d+qC3IIZCHFi3WaJT4TysxstEYB0ziRK/zWovfo2JWdG69YpCqSNeVga8o2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782906724; c=relaxed/simple;
	bh=kVmqmZ7XQpcMQkbKtU04w4RKmZNr3D68kPCC6jtSY+U=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:Date:Message-id; b=ie4ZRY2u6KR2rGjRgU0+wP6PXmpNMyksIXJAP5vnwb7nFWdGZuWvfOdUvWpUdjdmaPSZhwQZyERQHSUkLBg3Mc1EJhy1DokzRryKKbruOEDyCg7aWGlnnOm5KjodsiqnaDRKYFy5PAWUSLjCmp9xLL045g+39IzAbisZXEDE8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=X8DnrVEd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QjV/Dchz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="X8DnrVEd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QjV/Dchz"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id F0DDCEC01B0;
	Wed,  1 Jul 2026 07:52:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 01 Jul 2026 07:52:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:reply-to:subject:subject:to:to; s=fm1; t=1782906720; x=
	1782993120; bh=K9AAaGlLaodkiqwIF608q2yZSKJIeknNufH7fTi+L5Q=; b=X
	8DnrVEd1Llj1kJE4WRzDbM5MR5l+WJpuR7+UCs0DQ9nH6Pb2tKFDdodP6N5ocg3D
	gyzaAz1zmy8JztjPhzNG38UaKfLHOG3WPs7hR1RWWsGdqwUijZAw7RLQp8OXpjtd
	vTRkMKmXI/vWX2hd510xSMu/+Md3rNOKFJD0He3zFncI1Fh45Wm0EypFGFjPmlN4
	z/mTAtUm4nnamvCpQaY1np3vc9rx0kmpvJYwggmjW3OpadhMuVNH2MiuvJCEDAUo
	05jJHvTUMIVZKE79SqK53CRtOJHMx2y7laNV9r+/NkF0LxkB+mBnw6VQPCQdOlz+
	dypVnK5KAOPI7AxcYPXJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:reply-to
	:subject:subject:to:to:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1782906720; x=1782993120; bh=K9AAaGlLaodki
	qwIF608q2yZSKJIeknNufH7fTi+L5Q=; b=QjV/DchzU5rKMie36s/Cv0JluDs5a
	TF/Z0iw6QDCqDPuFQBZmlSqrky5+/z6/Ics40eXh/l30Kv7/2tIjTrOi6FSpFlbK
	zhVYhTLQjne3YZZgzNZCYiyzBgNg6wiSy8TL5VUOtV73noFHRhPkH8RQxsIT4eqj
	AeMMNpO1rF005/J/KNiagGjNVJ0289y4dx8c34S/AKGxLrP0iT3k08nRLI3UsEC1
	K0KBN87FG73kJdYDP/SWLrr4Km6zNpz0eqrWL0trQGJ7BpnJw452spbkZixRTiJU
	z9QDCSK+bZi+jpeROcllru3JZNXMiuK/ImX/ZADVarUo+EIoiF6b2f1ag==
X-ME-Sender: <xms:YP9EamG-f_v53q04Y-tpG3ZKq0LDTkNF-TEjOxccnXorF6OuGbkV6Q>
    <xme:YP9EagSP130bil0LPE7PXsPsQaNPYSA0ayuqcG_BRpzYm2F08UPTNCzfBm5pIvMEF
    BbkhK61q45NHQgixaBF6LA5YecnK2btC_3oEbqS_uc9l_s6Dw>
X-ME-Received: <xmr:YP9EarvELuVreFuUtCDMKpsLprs4DjHEHByX9WPuV4jEy70WMOH_opnTTyjGl50iSr3jNE5sA45oRblWqKE2DWpYeV943f0>
X-ME-Proxy-Cause: dmFkZTGaPvQxpoZu0I6hYcw4FRO06OCx2ZFFdO5i91rLYHyqDKpcx6WSbssSxyI/LUMiFe
    NHC7CrQpBEODxMKmlOOsWXYwD2UO+fsLVZIedwZ9nbTwEwimYXc6i1w1+OiVDIxyyANWGE
    j/VTo3EBYZT7g7f3hHWTGZQlxsf6D9iV5ZVDz0hIakSGC6SPnnKOYg0v6qkcOsSna8OYIq
    bQ9kTFH/RUsna9V63my6/WxbUIRtQgfcZRr5QhXxDct7pSZQJiJEdDYbCuwn7PEkZmuywE
    0rt4hbzVMn26nNkh1lQnq6tPGwj/bn/ft/mFfID9aVnP8Bu4pkVFWP3zVKdKqt3ux1liq1
    qe4vO6OX1VGPba6da2s8UiNb2+/hVcHZxWR9H8dWycLIoUWpCnrx4XeOaL/LKzWcPEXFtm
    6pfrzlG/y1i9ymQL1eidZGbTHtaxudYgmPOj9SXr/pHstsS6k0MjoA9B6fOoSvZ8eMZttz
    vJvjktJZo441Dhiomk6sP862vmkjeUe3EZepTewYhqniWwMUwFYu/EbToMDvN214wiZuxB
    kl3nzax912a4v0ZEpXxiu8RwiamWKXgyEHsMuL2st9E5RZY0gAudTK9J0UNEZEp4mUBFDN
    pv8oSdxlB/tIWEIUwG5uJqmUvEPrJk9xyvxPGE3IKb+uK7+PD5Bs8xG4Vbjw
X-ME-Proxy: <xmx:YP9EagIHfxc6xjXP6aObt5iVIDzCzhCdWcA5IcsPuTUr1Xcg2nzP_A>
    <xmx:YP9Eaoki_ZuIINyuvSMV7fp1AVWS-oLxecyP0k2MS3jd58sXhrq5Yg>
    <xmx:YP9EahI6CGDaxzf-rgkpmnyqAUQ7_umEUYs1537zBCpzg2r3Q0YsnQ>
    <xmx:YP9Eat60utJ2efoMxv3sVBot7jdz5KYZgqxSIWwjZDhgc6AMZAFXPQ>
    <xmx:YP9EalSwUhf2Bg6rk9W1AFz8pTRLFsuBuEs0JPega75BzwxgrMRHP5Up>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 07:51:58 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, linux-fsdevel@vger.kernel.org
Subject: [PATCH] Remove excl arg to ->create inode_operation
Date: Wed, 01 Jul 2026 21:51:55 +1000
Message-id: <178290671516.27465.15984496764174914338@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>


From: NeilBrown <neil@brown.name>

The only time that 'false' is passed as the 'excl' arg to the ->create
inode_operation is in lookup_open() when ->atomic_open is not provided
by the parent directory.
*all* directory inode_operations which do not have ->atomic_open
completely ignore the 'excl' arg.

Therefore we don't need the 'excl' arg.  Those few ->create operations
which pay attention to the arg are only ever called with a value of
'true'.

We remove that arg and change all ->create operations to behave as those
thhe arg were 'true'.

Signed-off-by: NeilBrown <neil@brown.name>
---
 Documentation/filesystems/porting.rst | 8 ++++++++
 fs/9p/vfs_inode.c                     | 3 +--
 fs/9p/vfs_inode_dotl.c                | 3 +--
 fs/affs/affs.h                        | 2 +-
 fs/affs/namei.c                       | 2 +-
 fs/afs/dir.c                          | 4 ++--
 fs/bad_inode.c                        | 2 +-
 fs/bfs/dir.c                          | 2 +-
 fs/btrfs/inode.c                      | 2 +-
 fs/ceph/dir.c                         | 2 +-
 fs/coda/dir.c                         | 2 +-
 fs/ecryptfs/inode.c                   | 2 +-
 fs/efivarfs/inode.c                   | 2 +-
 fs/exfat/namei.c                      | 2 +-
 fs/ext2/namei.c                       | 2 +-
 fs/ext4/namei.c                       | 2 +-
 fs/f2fs/namei.c                       | 2 +-
 fs/fat/namei_msdos.c                  | 2 +-
 fs/fat/namei_vfat.c                   | 2 +-
 fs/fuse/dir.c                         | 2 +-
 fs/gfs2/inode.c                       | 4 ++--
 fs/hfs/dir.c                          | 2 +-
 fs/hfsplus/dir.c                      | 2 +-
 fs/hostfs/hostfs_kern.c               | 2 +-
 fs/hpfs/namei.c                       | 2 +-
 fs/hugetlbfs/inode.c                  | 2 +-
 fs/jffs2/dir.c                        | 4 ++--
 fs/jfs/namei.c                        | 2 +-
 fs/minix/namei.c                      | 2 +-
 fs/namei.c                            | 5 ++---
 fs/nfs/dir.c                          | 4 ++--
 fs/nfs/internal.h                     | 2 +-
 fs/nilfs2/namei.c                     | 2 +-
 fs/ntfs/namei.c                       | 2 +-
 fs/ntfs3/namei.c                      | 2 +-
 fs/ocfs2/dlmfs/dlmfs.c                | 3 +--
 fs/ocfs2/namei.c                      | 3 +--
 fs/omfs/dir.c                         | 2 +-
 fs/orangefs/namei.c                   | 3 +--
 fs/overlayfs/dir.c                    | 2 +-
 fs/ramfs/inode.c                      | 2 +-
 fs/smb/client/cifsfs.h                | 2 +-
 fs/smb/client/dir.c                   | 2 +-
 fs/ubifs/dir.c                        | 2 +-
 fs/udf/namei.c                        | 2 +-
 fs/ufs/namei.c                        | 3 +--
 fs/vboxsf/dir.c                       | 4 ++--
 fs/xfs/xfs_iops.c                     | 5 ++---
 include/linux/fs.h                    | 2 +-
 ipc/mqueue.c                          | 2 +-
 mm/shmem.c                            | 2 +-
 51 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/Documentation/filesystems/porting.rst b/Documentation/filesystem=
s/porting.rst
index d13f0a23c882..02522fbfd968 100644
--- a/Documentation/filesystems/porting.rst
+++ b/Documentation/filesystems/porting.rst
@@ -1401,3 +1401,11 @@ as with d_dispose_if_unused() these are not trivial; w=
ith this variant
 of API it's more explicit, since grabbing ->d_lock is caller-side, but
 d_dispose_if_unused() had all the same issues.  It's a low-level primitive;
 use only if you have no alternative.
+
+---
+
+**mandatory**
+
+The .create inode_operation no longer receives the 'excl' arg.  It must
+always assume the file does not already exist.  If the filesystem needs
+to be involved in non-exclusive create, it should provide atomic_open.
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index 5783d0336f96..e47b90e70837 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -645,7 +645,6 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode=
 *dir,
  * @dir: The parent directory
  * @dentry: The name of file to be created
  * @mode: The UNIX file mode to set
- * @excl: True if the file must not yet exist
  *
  * open(.., O_CREAT) is handled in v9fs_vfs_atomic_open().  This is only cal=
led
  * for mknod(2).
@@ -654,7 +653,7 @@ v9fs_create(struct v9fs_session_info *v9ses, struct inode=
 *dir,
=20
 static int
 v9fs_vfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, umode_t mode, bool excl)
+		struct dentry *dentry, umode_t mode)
 {
 	struct v9fs_session_info *v9ses =3D v9fs_inode2v9ses(dir);
 	u32 perm =3D unixmode2p9mode(v9ses, mode);
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index f7396d20cb6c..d17c3b6eebb2 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -213,12 +213,11 @@ int v9fs_open_to_dotl_flags(int flags)
  * @dir: directory inode that is being created
  * @dentry:  dentry that is being deleted
  * @omode: create permissions
- * @excl: True if the file must not yet exist
  *
  */
 static int
 v9fs_vfs_create_dotl(struct mnt_idmap *idmap, struct inode *dir,
-		     struct dentry *dentry, umode_t omode, bool excl)
+		     struct dentry *dentry, umode_t omode)
 {
 	return v9fs_vfs_mknod_dotl(idmap, dir, dentry, omode, 0);
 }
diff --git a/fs/affs/affs.h b/fs/affs/affs.h
index 44a3f69d275f..d6b3393633f2 100644
--- a/fs/affs/affs.h
+++ b/fs/affs/affs.h
@@ -169,7 +169,7 @@ extern int	affs_hash_name(struct super_block *sb, const u=
8 *name, unsigned int l
 extern struct dentry *affs_lookup(struct inode *dir, struct dentry *dentry, =
unsigned int);
 extern int	affs_unlink(struct inode *dir, struct dentry *dentry);
 extern int	affs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool);
+			struct dentry *dentry, umode_t mode);
 extern struct dentry *affs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, umode_t mode);
 extern int	affs_rmdir(struct inode *dir, struct dentry *dentry);
diff --git a/fs/affs/namei.c b/fs/affs/namei.c
index c3c6532da4b0..b0001084727a 100644
--- a/fs/affs/namei.c
+++ b/fs/affs/namei.c
@@ -243,7 +243,7 @@ affs_unlink(struct inode *dir, struct dentry *dentry)
=20
 int
 affs_create(struct mnt_idmap *idmap, struct inode *dir,
-	    struct dentry *dentry, umode_t mode, bool excl)
+	    struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb =3D dir->i_sb;
 	struct inode	*inode;
diff --git a/fs/afs/dir.c b/fs/afs/dir.c
index 498b99ccdf0e..66cc3332ef31 100644
--- a/fs/afs/dir.c
+++ b/fs/afs/dir.c
@@ -32,7 +32,7 @@ static bool afs_lookup_one_filldir(struct dir_context *ctx,=
 const char *name, in
 static bool afs_lookup_filldir(struct dir_context *ctx, const char *name, in=
t nlen,
 			      loff_t fpos, u64 ino, unsigned dtype);
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl);
+		      struct dentry *dentry, umode_t mode);
 static struct dentry *afs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 				struct dentry *dentry, umode_t mode);
 static int afs_rmdir(struct inode *dir, struct dentry *dentry);
@@ -1623,7 +1623,7 @@ static const struct afs_operation_ops afs_create_operat=
ion =3D {
  * create a regular file on an AFS filesystem
  */
 static int afs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct afs_operation *op;
 	struct afs_vnode *dvnode =3D AFS_FS_I(dir);
diff --git a/fs/bad_inode.c b/fs/bad_inode.c
index acf8613f5e36..486c40f73e51 100644
--- a/fs/bad_inode.c
+++ b/fs/bad_inode.c
@@ -29,7 +29,7 @@ static const struct file_operations bad_file_ops =3D
=20
 static int bad_inode_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode, bool excl)
+			    umode_t mode)
 {
 	return -EIO;
 }
diff --git a/fs/bfs/dir.c b/fs/bfs/dir.c
index 5b40ab09a796..4c3b4db08cde 100644
--- a/fs/bfs/dir.c
+++ b/fs/bfs/dir.c
@@ -83,7 +83,7 @@ const struct file_operations bfs_dir_operations =3D {
 };
=20
 static int bfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	int err;
 	struct inode *inode;
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 272598f6ae77..22c0a0e241e5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -6832,7 +6832,7 @@ static int btrfs_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
 }
=20
 static int btrfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
=20
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 27ce9e55e947..dee4524c2336 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -978,7 +978,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct ino=
de *dir,
 }
=20
 static int ceph_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return ceph_mknod(idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/coda/dir.c b/fs/coda/dir.c
index 835eb7fdfdad..ea710a5dbbb7 100644
--- a/fs/coda/dir.c
+++ b/fs/coda/dir.c
@@ -134,7 +134,7 @@ static inline void coda_dir_drop_nlink(struct inode *dir)
=20
 /* creation routines: create, mknod, mkdir, link, symlink */
 static int coda_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *de, umode_t mode, bool excl)
+		       struct dentry *de, umode_t mode)
 {
 	int error;
 	const char *name=3Dde->d_name.name;
diff --git a/fs/ecryptfs/inode.c b/fs/ecryptfs/inode.c
index 7aaf1913f9c6..525297c7ebd8 100644
--- a/fs/ecryptfs/inode.c
+++ b/fs/ecryptfs/inode.c
@@ -268,7 +268,7 @@ int ecryptfs_initialize_file(struct dentry *ecryptfs_dent=
ry,
 static int
 ecryptfs_create(struct mnt_idmap *idmap,
 		struct inode *directory_inode, struct dentry *ecryptfs_dentry,
-		umode_t mode, bool excl)
+		umode_t mode)
 {
 	struct inode *ecryptfs_inode;
 	int rc;
diff --git a/fs/efivarfs/inode.c b/fs/efivarfs/inode.c
index 95dcad83da11..f0d009555fc6 100644
--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -75,7 +75,7 @@ static bool efivarfs_valid_name(const char *str, int len)
 }
=20
 static int efivarfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			   struct dentry *dentry, umode_t mode, bool excl)
+			   struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode =3D NULL;
 	struct efivar_entry *var;
diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
index b7d5e44ad38e..cd9c9eca58f8 100644
--- a/fs/exfat/namei.c
+++ b/fs/exfat/namei.c
@@ -538,7 +538,7 @@ static int exfat_add_entry(struct inode *inode, const cha=
r *path,
 }
=20
 static int exfat_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb =3D dir->i_sb;
 	struct inode *inode;
diff --git a/fs/ext2/namei.c b/fs/ext2/namei.c
index 0d09d22fe708..742a78e165d4 100644
--- a/fs/ext2/namei.c
+++ b/fs/ext2/namei.c
@@ -99,7 +99,7 @@ struct dentry *ext2_get_parent(struct dentry *child)
  */
 static int ext2_create (struct mnt_idmap * idmap,
 			struct inode * dir, struct dentry * dentry,
-			umode_t mode, bool excl)
+			umode_t mode)
 {
 	struct inode *inode;
 	int err;
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index cc49ae04a6f6..c3de64d2a2df 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2811,7 +2811,7 @@ static int ext4_add_nondir(handle_t *handle,
  * with d_instantiate().
  */
 static int ext4_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	handle_t *handle;
 	struct inode *inode;
diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index cac03b8e91a1..648681c5ba50 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -366,7 +366,7 @@ static struct inode *f2fs_new_inode(struct mnt_idmap *idm=
ap,
 }
=20
 static int f2fs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	struct f2fs_sb_info *sbi =3D F2FS_I_SB(dir);
 	struct f2fs_lock_context lc;
diff --git a/fs/fat/namei_msdos.c b/fs/fat/namei_msdos.c
index 0fd2971ad4b1..9f2a2e9a9ce8 100644
--- a/fs/fat/namei_msdos.c
+++ b/fs/fat/namei_msdos.c
@@ -262,7 +262,7 @@ static int msdos_add_entry(struct inode *dir, const unsig=
ned char *name,
=20
 /***** Create a file */
 static int msdos_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb =3D dir->i_sb;
 	struct inode *inode =3D NULL;
diff --git a/fs/fat/namei_vfat.c b/fs/fat/namei_vfat.c
index e909447873e3..139d3ef4bfae 100644
--- a/fs/fat/namei_vfat.c
+++ b/fs/fat/namei_vfat.c
@@ -755,7 +755,7 @@ static struct dentry *vfat_lookup(struct inode *dir, stru=
ct dentry *dentry,
 }
=20
 static int vfat_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	struct super_block *sb =3D dir->i_sb;
 	struct inode *inode;
diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 0e2a1039fa43..0efb3141f7f7 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1084,7 +1084,7 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct i=
node *dir,
 }
=20
 static int fuse_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *entry, umode_t mode, bool excl)
+		       struct dentry *entry, umode_t mode)
 {
 	return fuse_mknod(idmap, dir, entry, mode, 0);
 }
diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
index 8a77794bbd4a..9e23c8d55962 100644
--- a/fs/gfs2/inode.c
+++ b/fs/gfs2/inode.c
@@ -969,9 +969,9 @@ static int gfs2_create_inode(struct inode *dir, struct de=
ntry *dentry,
  */
=20
 static int gfs2_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
-	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, exc=
l);
+	return gfs2_create_inode(dir, dentry, NULL, S_IFREG | mode, 0, NULL, 0, 1);
 }
=20
 /**
diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
index e13450bb933e..93edc5a80c81 100644
--- a/fs/hfs/dir.c
+++ b/fs/hfs/dir.c
@@ -184,7 +184,7 @@ static int hfs_dir_release(struct inode *inode, struct fi=
le *file)
  * the directory and the name (and its length) of the new file.
  */
 static int hfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	int res;
diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
index 8bf6c7cdd9a8..f0aae2cd6fcf 100644
--- a/fs/hfsplus/dir.c
+++ b/fs/hfsplus/dir.c
@@ -562,7 +562,7 @@ static int hfsplus_mknod(struct mnt_idmap *idmap, struct =
inode *dir,
 }
=20
 static int hfsplus_create(struct mnt_idmap *idmap, struct inode *dir,
-			  struct dentry *dentry, umode_t mode, bool excl)
+			  struct dentry *dentry, umode_t mode)
 {
 	return hfsplus_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index abe86d72d9ef..7add056d47d8 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -593,7 +593,7 @@ static struct inode *hostfs_iget(struct super_block *sb, =
char *name)
 }
=20
 static int hostfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode, bool excl)
+			 struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	char *name;
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 353e13a615f5..809113d8248d 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -129,7 +129,7 @@ static struct dentry *hpfs_mkdir(struct mnt_idmap *idmap,=
 struct inode *dir,
 }
=20
 static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	const unsigned char *name =3D dentry->d_name.name;
 	unsigned len =3D dentry->d_name.len;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 216e1a0dd0b2..16d8437aed51 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -979,7 +979,7 @@ static struct dentry *hugetlbfs_mkdir(struct mnt_idmap *i=
dmap, struct inode *dir
=20
 static int hugetlbfs_create(struct mnt_idmap *idmap,
 			    struct inode *dir, struct dentry *dentry,
-			    umode_t mode, bool excl)
+			    umode_t mode)
 {
 	return hugetlbfs_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }
diff --git a/fs/jffs2/dir.c b/fs/jffs2/dir.c
index c4088c3b4ac0..3d4695b838ed 100644
--- a/fs/jffs2/dir.c
+++ b/fs/jffs2/dir.c
@@ -26,7 +26,7 @@
 static int jffs2_readdir (struct file *, struct dir_context *);
=20
 static int jffs2_create (struct mnt_idmap *, struct inode *,
-		         struct dentry *, umode_t, bool);
+		         struct dentry *, umode_t);
 static struct dentry *jffs2_lookup (struct inode *,struct dentry *,
 				    unsigned int);
 static int jffs2_link (struct dentry *,struct inode *,struct dentry *);
@@ -163,7 +163,7 @@ static int jffs2_readdir(struct file *file, struct dir_co=
ntext *ctx)
=20
=20
 static int jffs2_create(struct mnt_idmap *idmap, struct inode *dir_i,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct jffs2_raw_inode *ri;
 	struct jffs2_inode_info *f, *dir_f;
diff --git a/fs/jfs/namei.c b/fs/jfs/namei.c
index 442d62679262..2cf4e280ee18 100644
--- a/fs/jfs/namei.c
+++ b/fs/jfs/namei.c
@@ -61,7 +61,7 @@ static inline void free_ea_wmap(struct inode *inode)
  *
  */
 static int jfs_create(struct mnt_idmap *idmap, struct inode *dip,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	int rc =3D 0;
 	tid_t tid;		/* transaction id */
diff --git a/fs/minix/namei.c b/fs/minix/namei.c
index 263e4ba8b1c8..79e591bdfdc1 100644
--- a/fs/minix/namei.c
+++ b/fs/minix/namei.c
@@ -64,7 +64,7 @@ static int minix_tmpfile(struct mnt_idmap *idmap, struct in=
ode *dir,
 }
=20
 static int minix_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return minix_mknod(&nop_mnt_idmap, dir, dentry, mode, 0);
 }
diff --git a/fs/namei.c b/fs/namei.c
index 5cc9f0f466b8..8d81fc301e98 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4199,7 +4199,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *=
dentry, umode_t mode,
 	error =3D try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
 	if (error)
 		return error;
-	error =3D dir->i_op->create(idmap, dir, dentry, mode, true);
+	error =3D dir->i_op->create(idmap, dir, dentry, mode);
 	if (!error)
 		fsnotify_create(dir, dentry);
 	return error;
@@ -4505,8 +4505,7 @@ static struct dentry *lookup_open(struct nameidata *nd,=
 struct file *file,
 			goto out_dput;
 		}
=20
-		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
-						mode, open_flag & O_EXCL);
+		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
 		if (error)
 			goto out_dput;
 	}
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index c7b723c18620..2830ddc416cf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -2427,9 +2427,9 @@ static int nfs_do_create(struct inode *dir, struct dent=
ry *dentry,
 }
=20
 int nfs_create(struct mnt_idmap *idmap, struct inode *dir,
-	       struct dentry *dentry, umode_t mode, bool excl)
+	       struct dentry *dentry, umode_t mode)
 {
-	return nfs_do_create(dir, dentry, mode, excl ? O_EXCL : 0);
+	return nfs_do_create(dir, dentry, mode, O_EXCL);
 }
 EXPORT_SYMBOL_GPL(nfs_create);
=20
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index acaeff7ddfdf..dd77d5e80d7b 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -395,7 +395,7 @@ extern unsigned long nfs_access_cache_scan(struct shrinke=
r *shrink,
 struct dentry *nfs_lookup(struct inode *, struct dentry *, unsigned int);
 void nfs_d_prune_case_insensitive_aliases(struct inode *inode);
 int nfs_create(struct mnt_idmap *, struct inode *, struct dentry *,
-	       umode_t, bool);
+	       umode_t);
 struct dentry *nfs_mkdir(struct mnt_idmap *, struct inode *, struct dentry *,
 			 umode_t);
 int nfs_rmdir(struct inode *, struct dentry *);
diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index e2fe95de3d71..0e0a9850ff76 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -86,7 +86,7 @@ nilfs_lookup(struct inode *dir, struct dentry *dentry, unsi=
gned int flags)
  * with d_instantiate().
  */
 static int nilfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct nilfs_transaction_info ti;
diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
index a19626a135bd..b4dc6da22659 100644
--- a/fs/ntfs/namei.c
+++ b/fs/ntfs/namei.c
@@ -736,7 +736,7 @@ static struct ntfs_inode *__ntfs_create(struct mnt_idmap =
*idmap, struct inode *d
 }
=20
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *dentry, umode_t mode, bool excl)
+		struct dentry *dentry, umode_t mode)
 {
 	struct ntfs_volume *vol =3D NTFS_SB(dir->i_sb);
 	struct ntfs_inode *ni;
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index c59de5f2fa97..6d032b22c97d 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -105,7 +105,7 @@ static struct dentry *ntfs_lookup(struct inode *dir, stru=
ct dentry *dentry,
  * ntfs_create - inode_operations::create
  */
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
 				 NULL, 0, NULL);
diff --git a/fs/ocfs2/dlmfs/dlmfs.c b/fs/ocfs2/dlmfs/dlmfs.c
index 5821e33df78f..f0124f81df29 100644
--- a/fs/ocfs2/dlmfs/dlmfs.c
+++ b/fs/ocfs2/dlmfs/dlmfs.c
@@ -453,8 +453,7 @@ static struct dentry *dlmfs_mkdir(struct mnt_idmap * idma=
p,
 static int dlmfs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool excl)
+			umode_t mode)
 {
 	int status =3D 0;
 	struct inode *inode;
diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
index 1277666c77cd..12a1fef3ee74 100644
--- a/fs/ocfs2/namei.c
+++ b/fs/ocfs2/namei.c
@@ -667,8 +667,7 @@ static struct dentry *ocfs2_mkdir(struct mnt_idmap *idmap,
 static int ocfs2_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool excl)
+			umode_t mode)
 {
 	int ret;
=20
diff --git a/fs/omfs/dir.c b/fs/omfs/dir.c
index 2ed541fccf33..a09a98f7e30b 100644
--- a/fs/omfs/dir.c
+++ b/fs/omfs/dir.c
@@ -286,7 +286,7 @@ static struct dentry *omfs_mkdir(struct mnt_idmap *idmap,=
 struct inode *dir,
 }
=20
 static int omfs_create(struct mnt_idmap *idmap, struct inode *dir,
-		       struct dentry *dentry, umode_t mode, bool excl)
+		       struct dentry *dentry, umode_t mode)
 {
 	return omfs_add_node(dir, dentry, mode | S_IFREG);
 }
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 75e65e72c2d6..91f97db18971 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -18,8 +18,7 @@
 static int orangefs_create(struct mnt_idmap *idmap,
 			struct inode *dir,
 			struct dentry *dentry,
-			umode_t mode,
-			bool exclusive)
+			umode_t mode)
 {
 	struct orangefs_inode_s *parent =3D ORANGEFS_I(dir);
 	struct orangefs_kernel_op_s *new_op;
diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a033743dbf51..88bcf98d287d 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -732,7 +732,7 @@ static int ovl_create_object(struct dentry *dentry, int m=
ode, dev_t rdev,
 }
=20
 static int ovl_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	return ovl_create_object(dentry, (mode & 07777) | S_IFREG, 0, NULL);
 }
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index 3987639ed132..0f52ba22aac0 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -128,7 +128,7 @@ static struct dentry *ramfs_mkdir(struct mnt_idmap *idmap=
, struct inode *dir,
 }
=20
 static int ramfs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return ramfs_mknod(&nop_mnt_idmap, dir, dentry, mode | S_IFREG, 0);
 }
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 901e1340c986..bcf2ff87da2d 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -54,7 +54,7 @@ void cifs_sb_deactive(struct super_block *sb);
 extern const struct inode_operations cifs_dir_inode_ops;
 struct inode *cifs_root_iget(struct super_block *sb);
 int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *direntry, umode_t mode, bool excl);
+		struct dentry *direntry, umode_t mode);
 int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
 		     struct file *file, unsigned int oflags, umode_t mode);
 int cifs_tmpfile(struct mnt_idmap *idmap, struct inode *dir,
diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
index 88a4a1787ff0..7803bd5bd01f 100644
--- a/fs/smb/client/dir.c
+++ b/fs/smb/client/dir.c
@@ -645,7 +645,7 @@ int cifs_atomic_open(struct inode *dir, struct dentry *di=
rentry,
  * hashed-positive by calling d_instantiate().
  */
 int cifs_create(struct mnt_idmap *idmap, struct inode *dir,
-		struct dentry *direntry, umode_t mode, bool excl)
+		struct dentry *direntry, umode_t mode)
 {
 	struct cifs_sb_info *cifs_sb =3D CIFS_SB(dir);
 	int rc;
diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 86d41e077e4d..fd8df10547bf 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -303,7 +303,7 @@ static int ubifs_prepare_create(struct inode *dir, struct=
 dentry *dentry,
 }
=20
 static int ubifs_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode;
 	struct ubifs_info *c =3D dir->i_sb->s_fs_info;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 9a3b7cef3606..fd9b6f16f614 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -371,7 +371,7 @@ static int udf_add_nondir(struct dentry *dentry, struct i=
node *inode)
 }
=20
 static int udf_create(struct mnt_idmap *idmap, struct inode *dir,
-		      struct dentry *dentry, umode_t mode, bool excl)
+		      struct dentry *dentry, umode_t mode)
 {
 	struct inode *inode =3D udf_new_inode(dir, mode);
=20
diff --git a/fs/ufs/namei.c b/fs/ufs/namei.c
index 5b3c85c93242..5012e056200a 100644
--- a/fs/ufs/namei.c
+++ b/fs/ufs/namei.c
@@ -70,8 +70,7 @@ static struct dentry *ufs_lookup(struct inode * dir, struct=
 dentry *dentry, unsi
  * with d_instantiate().=20
  */
 static int ufs_create (struct mnt_idmap * idmap,
-		struct inode * dir, struct dentry * dentry, umode_t mode,
-		bool excl)
+		struct inode * dir, struct dentry * dentry, umode_t mode)
 {
 	struct inode *inode;
=20
diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
index c5bd3271aa96..0b9eab157432 100644
--- a/fs/vboxsf/dir.c
+++ b/fs/vboxsf/dir.c
@@ -298,9 +298,9 @@ static int vboxsf_dir_create(struct inode *parent, struct=
 dentry *dentry,
=20
 static int vboxsf_dir_mkfile(struct mnt_idmap *idmap,
 			     struct inode *parent, struct dentry *dentry,
-			     umode_t mode, bool excl)
+			     umode_t mode)
 {
-	return vboxsf_dir_create(parent, dentry, mode, false, excl, NULL);
+	return vboxsf_dir_create(parent, dentry, mode, false, true, NULL);
 }
=20
 static struct dentry *vboxsf_dir_mkdir(struct mnt_idmap *idmap,
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 6339f4956ecb..e48f9e5a1b8a 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -293,8 +293,7 @@ xfs_vn_create(
 	struct mnt_idmap	*idmap,
 	struct inode		*dir,
 	struct dentry		*dentry,
-	umode_t			mode,
-	bool			flags)
+	umode_t			mode)
 {
 	return xfs_generic_create(idmap, dir, dentry, mode, 0, NULL);
 }
@@ -338,7 +337,7 @@ STATIC struct dentry *
 xfs_vn_ci_lookup(
 	struct inode	*dir,
 	struct dentry	*dentry,
-	unsigned int flags)
+	unsigned int	flags)
 {
 	struct xfs_inode *ip;
 	struct xfs_name	xname;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..1b7c40b2fa6d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2002,7 +2002,7 @@ struct inode_operations {
 	int (*readlink) (struct dentry *, char __user *,int);
=20
 	int (*create) (struct mnt_idmap *, struct inode *,struct dentry *,
-		       umode_t, bool);
+		       umode_t);
 	int (*link) (struct dentry *,struct inode *,struct dentry *);
 	int (*unlink) (struct inode *,struct dentry *);
 	int (*symlink) (struct mnt_idmap *, struct inode *,struct dentry *,
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 4798b375972b..2dddb97f2f8a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -608,7 +608,7 @@ static int mqueue_create_attr(struct dentry *dentry, umod=
e_t mode, void *arg)
 }
=20
 static int mqueue_create(struct mnt_idmap *idmap, struct inode *dir,
-			 struct dentry *dentry, umode_t mode, bool excl)
+			 struct dentry *dentry, umode_t mode)
 {
 	return mqueue_create_attr(dentry, mode, NULL);
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index b51f83c970bb..5789a0f5a346 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3864,7 +3864,7 @@ static struct dentry *shmem_mkdir(struct mnt_idmap *idm=
ap, struct inode *dir,
 }
=20
 static int shmem_create(struct mnt_idmap *idmap, struct inode *dir,
-			struct dentry *dentry, umode_t mode, bool excl)
+			struct dentry *dentry, umode_t mode)
 {
 	return shmem_mknod(idmap, dir, dentry, mode | S_IFREG, 0);
 }
--=20
2.50.0.107.gf914562f5916.dirty

