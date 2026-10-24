Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.185
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792877689;
	b=u9y/bSXEPzbdDP2XsGS9Ol4PKWIM5/UhNGngsfQJJ+9vyP7WtXPLQ0G9jAgQJy+LCamK
	 UVZmhW8yznWmSBQp5jxJurUhN1jm96IPf+bo8c3VMdY5+iyPNV0QkrGpilsPIms/fq04b
	 otrANKARzJpi0nDTBipF+vbPFkNf8ePLTGoojSdQNUzzs2Rc+GXkOpEvgPNePDjtWsS7I
	 Uz30LebAu96o9G1yIjkzZ1AcUADWzWRvnk65+iXryAJ8ag2aFZYH13PbBAAepZzKn4ill
	 3Fys1+36QA76lKF59MyKxOjlN5XisZrysPvvnQNXcLYdWmM7DNOlp6BMeQX1zhnlaMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792877689;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KRY0uTbCLwN6ZmpLvYkero4AcJ3smrSWkXfj0HJRZvY=;
	b=hXeUe3oTimIabxH3bQi/q9OxBOJtpgoaDHAUrSt8TfwKFyh6Qnkzc6GjLpCmHvgEQLmk
	 jazWMzQO+d4ub0bR94dnXcJP/zfocBD73dZQ68y1xVquWP3fFSfWDWlYoir9icFl9VYQO
	 0WBEzmB7X3x6sNIqp2IkTSlaha8cKaWNBIhsgLwQWbk8p4Dbp3RskUHATFz1xthpxcki3
	 SgExzZs3oFNfap4K6CTS44BhxrRCNZ3+yvgNYA6yMpTVkZiRZKyv0O6aY3Zg6c08piifw
	 Xroi+LR+8F3NCycI+YGxp6syv/Hy9cCkaxVaV1d8Vhkzl90mQju2pQHa36JkN1lAh0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=xs4all.nl;
	spf=pass smtp.mailfrom=xs4all.nl;
	dkim=pass header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=hXEHP5dt;
	arc=none smtp.remote-ip=195.121.94.185
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6C8606A31A
	for <linux-fsdevel@vger.kernel.org>; Sat, 24 Oct 2026 21:34:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF6C8606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=hXEHP5dt
X-KPN-MessageId: ba3bd38f-cff2-11f1-9136-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.5])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ba3bd38f-cff2-11f1-9136-005056999439;
	Sat, 24 Oct 2026 23:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=KRY0uTbCLwN6ZmpLvYkero4AcJ3smrSWkXfj0HJRZvY=;
	b=hXEHP5dtaaAl1tja+/FVBpIQAwQt+JxIqmWJD+5saxKNdUqamc3PZKg0UIdg+TVkUpu/JYP2RNxbX
	 hxb2Kb72dmHamBisnzRVg4qWuZjyGSrJwBaWRvKyhdeCdrA7E9Isvms+IyT5q+fQ6I1PD51JDFH4zt
	 i5CGcqRvlyP9ng2DYLC5NdO4IOMVaafPVDd+NOe1CTzlud1ROuEZHao8xPsjHHMt7WZ/1aTNqRFvV5
	 vNMWKcpf7htkWa5+c5ETwDAEvlMO/f4NubKTeLC/ESohUTCNGAv2yNhA3mgWZ1jCkT6O9JuTDTXVCZ
	 T2dYxaqXrdQDJYjgLPR+dJgETe7+5+g==
X-KPN-MID: 33|dbMNlMdeUwzKslKNe+Xo4INsW52E0tft3Vc3p977skxNOz6soWIB5CYbxYcT5C3
 /51Fsnv6B8AzOMZwgZS6Hy3Ee3XvVY048uKFHxVwQqjg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|aXpdNyt0+ZmkWqF2lV2sp+8zm15PFkhPHUPw0K+MEABlCD5GQScKipifHXbdDq5
 yETDCjFv1sbkBN6CTClBMhg==
Received: from daedalus.home (unknown [178.227.247.81])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id b9edf39b-cff2-11f1-8686-00505699b758;
	Sat, 24 Oct 2026 23:34:43 +0200 (CEST)
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
Subject: [PATCH v8 09/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Date: Sat, 24 Oct 2026 23:35:36 +0200
Message-ID: <20261024213539.1307600-10-jkoolstra@xs4all.nl>
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

Currently there is no way to race-freely create and open a directory.
For regular files we have open(O_CREAT) for creating a new file inode,
and returning a pinning fd to it. The lack of such functionality for
directories means that when populating a directory tree there's always
a race involved: the inodes first need to be created, and then opened
to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
but in the time window between the creation and the opening they might
be replaced by something else.

Addressing this race without a proper API is only partially possible:
the caller can immediately fstat() what was opened to verify that it
has the expected inode type, owner and mode. But besides being easy to
get wrong, this cannot establish who created the directory: a directory
created by another process with identical credentials is
indistinguishable from one the caller created itself, so the caller
cannot tell whether the directory is its own to manage.

Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
a regular file exists at the open path; EISDIR if a directory exists at
the path; and to create a regular file if no file exists at the path.
This behaviour changed accidentally with
commit 973d4b73fbaf ("do_last(): rejoin the common path even earlier in
FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last case
while still creating the file. As this change was not detected for a
long time, Brauner proposed to adopt the more consistent NetBSD
behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combination.
This change was applied in commit 43b450632676 ("open: return EINVAL for
O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has been
in the kernel for about 3 years now, no rollback is expected as a result
of userspace reliance on old behaviour, leaving us free to reassign the
O_CREAT|O_DIRECTORY semantics.

O_CREAT|O_DIRECTORY must be combined with O_EXCL; otherwise open fails
with EINVAL. As with O_CREAT|O_EXCL, a trailing symlink is not followed,
and any existing entry at the path results in EEXIST.

Filesystems that do not support O_CREAT|O_DIRECTORY set
SB_I_NO_ATOMIC_MKDIR, and lookup_open() refuses the open with EOPNOTSUPP
for them before doing any lookup. These are all ->atomic_open()
filesystems, which cannot create directories without protocol
extensions, and tracefs, whose ->mkdir() drops the parent's i_rwsem so
that the directory at the name may not be the one created by the call
(or at least it has to be verified that this plays well with the
atomicity guarantee that O_CREAT|O_DIRECTORY attempts to provide.) For
ecryptfs and apparmorfs there are similar concerns and hence they are
also blocked for now.

kernfs ->mkdir() did not instantiate the dentry; this is fixed by
returning the new kernfs_node from the kernfs_syscall_ops ->mkdir()
callbacks and splicing its inode.

This feature idea (and some of its description) is taken from the
UAPI group:
https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 fs/9p/vfs_super.c               |   1 +
 fs/ceph/super.c                 |   1 +
 fs/ecryptfs/main.c              |   1 +
 fs/fuse/inode.c                 |   1 +
 fs/gfs2/ops_fstype.c            |   1 +
 fs/kernfs/dir.c                 |  36 +++++++++--
 fs/kernfs/inode.c               |  57 ++++++++++++++++++
 fs/kernfs/kernfs-internal.h     |   4 ++
 fs/namei.c                      | 103 +++++++++++++++++++++++++-------
 fs/nfs/super.c                  |   1 +
 fs/open.c                       |  33 ++++++----
 fs/resctrl/rdtgroup.c           |  35 ++++++-----
 fs/smb/client/cifsfs.c          |   1 +
 fs/tracefs/inode.c              |   1 +
 fs/vboxsf/super.c               |   1 +
 include/linux/fcntl.h           |   6 ++
 include/linux/fs/super_types.h  |   1 +
 include/linux/kernfs.h          |   7 ++-
 kernel/cgroup/cgroup-internal.h |   3 +-
 kernel/cgroup/cgroup.c          |  16 +++--
 security/apparmor/apparmorfs.c  |   1 +
 21 files changed, 249 insertions(+), 62 deletions(-)

diff --git a/fs/9p/vfs_super.c b/fs/9p/vfs_super.c
index 79526044685c..d0c594bee991 100644
--- a/fs/9p/vfs_super.c
+++ b/fs/9p/vfs_super.c
@@ -40,6 +40,7 @@ static int v9fs_fill_super(struct super_block *sb)
 	sb->s_blocksize_bits = fls(v9ses->maxdata - 1);
 	sb->s_blocksize = 1 << sb->s_blocksize_bits;
 	sb->s_magic = V9FS_MAGIC;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	if (v9fs_proto_dotl(v9ses)) {
 		sb->s_op = &v9fs_super_ops_dotl;
 		if (!(v9ses->flags & V9FS_NO_XATTR))
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 72935f665f11..fa1cf1f4f57d 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1226,6 +1226,7 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	fsc->max_file_size = 1ULL << 40; /* temp value until we get mdsmap */
 
 	s->s_op = &ceph_super_ops;
+	s->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	set_default_d_op(s, &ceph_dentry_ops);
 	s->s_export_op = &ceph_export_ops;
 
diff --git a/fs/ecryptfs/main.c b/fs/ecryptfs/main.c
index 5f37cddb956f..8ed6076d50af 100644
--- a/fs/ecryptfs/main.c
+++ b/fs/ecryptfs/main.c
@@ -477,6 +477,7 @@ static int ecryptfs_get_tree(struct fs_context *fc)
 	/* ->kill_sb() will take care of sbi after that point */
 	sbi = NULL;
 	s->s_op = &ecryptfs_sops;
+	s->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	s->s_xattr = ecryptfs_xattr_handlers;
 	set_default_d_op(s, &ecryptfs_dops);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e9552be3637b..cf766c6feea4 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1608,6 +1608,7 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
 	sb->s_iflags |= SB_I_NOIDMAP;
 	sb->s_iflags |= SB_I_NO_DATA_INTEGRITY;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	if (sb->s_user_ns != &init_user_ns)
 		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 6ec47376aecf..31bb09367d6b 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1137,6 +1137,7 @@ static int gfs2_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_flags |= SB_NOSEC;
 	sb->s_magic = GFS2_MAGIC;
 	sb->s_op = &gfs2_super_ops;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 
 	set_default_d_op(sb, &gfs2_dops);
 	sb->s_export_op = &gfs2_export_ops;
diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 324d61a00545..b98114454112 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -37,7 +37,7 @@ static bool __kernfs_active(struct kernfs_node *kn)
 	return atomic_read(&kn->active) >= 0;
 }
 
-static bool kernfs_active(struct kernfs_node *kn)
+bool kernfs_active(struct kernfs_node *kn)
 {
 	lockdep_assert_held(&kernfs_root(kn)->kernfs_rwsem);
 	return __kernfs_active(kn);
@@ -1293,18 +1293,44 @@ static struct dentry *kernfs_iop_mkdir(const struct mnt_idmap *idmap,
 {
 	struct kernfs_node *parent = dir->i_private;
 	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
-	int ret;
+	struct kernfs_node *kn;
+	struct inode *inode;
 
 	if (!scops || !scops->mkdir)
 		return ERR_PTR(-EPERM);
 
-	if (!kernfs_get_active(parent))
+	inode = new_inode(dir->i_sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	if (!kernfs_get_active(parent)) {
+		iput(inode);
 		return ERR_PTR(-ENODEV);
+	}
 
-	ret = scops->mkdir(parent, dentry->d_name.name, mode);
+	kn = scops->mkdir(parent, dentry->d_name.name, mode);
 
 	kernfs_put_active(parent);
-	return ERR_PTR(ret);
+	if (IS_ERR(kn)) {
+		iput(inode);
+		return ERR_CAST(kn);
+	}
+
+	scoped_guard(rwsem_read, &kernfs_root(kn)->kernfs_rwsem)
+		inode = kernfs_get_inode_locked(inode, kn, false);
+	kernfs_put(kn);
+
+	if (!inode)
+		return ERR_PTR(-ESTALE);
+
+	/*
+	 * We may race with kernfs_fh_to_dentry() which calls d_obtain_alias(),
+	 * so the inode may already have a disconnected alias. Use
+	 * d_splice_alias() to move it into place, which does not accept
+	 * hashed dentries, so drop the negative dentry first.
+	 */
+	d_drop(dentry);
+	return d_splice_alias(inode, dentry);
 }
 
 static int kernfs_iop_rmdir(struct inode *dir, struct dentry *dentry)
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 3854ed5725e1..0da4e46ec75b 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -255,6 +255,63 @@ struct inode *kernfs_get_inode(struct super_block *sb, struct kernfs_node *kn)
 	return inode;
 }
 
+static int kernfs_inode_test(struct inode *inode, void *data)
+{
+	return inode->i_ino == *(u64 *)data;
+}
+
+static int kernfs_inode_set(struct inode *inode, void *data)
+{
+	inode->i_ino = *(u64 *)data;
+	return 0;
+}
+
+/**
+ * kernfs_get_inode_locked - get the inode of @kn under kernfs_rwsem
+ * @inode: inode allocated with new_inode() on the target superblock
+ * @kn: kernfs_node to get the inode for
+ * @lookup: should we do a ilookup before attempting to insert the inode
+ *
+ * Attaches @inode to @kn. Caller should pass an @inode allocated with
+ * new_inode(), and hold the kernfs_rwsem semaphore for reading on the @kn
+ * root. Because the kernfs_rwsem is held and it is checked that @kn is still
+ * active, __kernfs_remove() always finds @inode to clear its i_nlink. If
+ * lookup is true, a quick ilookup is attempted first.
+ *
+ * Returns the inode that was found or inserted for @kn, or NULL if @kn is
+ * inactive. @inode is consumed.
+ */
+struct inode *kernfs_get_inode_locked(struct inode *inode, struct kernfs_node *kn,
+				      bool lookup)
+{
+	u64 ino = kernfs_ino(kn);
+	struct inode *old = NULL, *new = inode;
+
+	lockdep_assert_held_read(&kernfs_root(kn)->kernfs_rwsem);
+
+	if (lookup) {
+		old = ilookup(inode->i_sb, ino);
+		if (old)
+			goto out_iput;
+	}
+
+	if (!kernfs_active(kn))
+		goto out_iput;
+
+	inode = inode_insert5(new, ino, kernfs_inode_test, kernfs_inode_set,
+			      &ino);
+	if (inode != new) {
+		old = inode;
+		goto out_iput;
+	}
+
+	kernfs_init_inode(kn, inode);
+	return inode;
+out_iput:
+	iput(new);
+	return old;
+}
+
 /*
  * The kernfs_node serves as both an inode and a directory entry for
  * kernfs.  To prevent the kernfs inode numbers from being freed
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index f1e93b09e27d..ec6e1f75513b 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -176,6 +176,9 @@ extern struct kmem_cache *kernfs_node_cache, *kernfs_iattrs_cache;
  * inode.c
  */
 extern const struct xattr_handler * const kernfs_xattr_handlers[];
+struct inode *kernfs_get_inode_locked(struct inode *inode,
+				      struct kernfs_node *kn,
+				      bool lookup);
 void kernfs_evict_inode(struct inode *inode);
 int kernfs_iop_permission(const struct mnt_idmap *idmap,
 			  struct inode *inode, int mask);
@@ -194,6 +197,7 @@ extern const struct dentry_operations kernfs_dops;
 extern const struct file_operations kernfs_dir_fops;
 extern const struct inode_operations kernfs_dir_iops;
 
+bool kernfs_active(struct kernfs_node *kn);
 struct kernfs_node *kernfs_get_active(struct kernfs_node *kn);
 void kernfs_put_active(struct kernfs_node *kn);
 int kernfs_add_one(struct kernfs_node *kn);
diff --git a/fs/namei.c b/fs/namei.c
index efd0e2e5fbf8..6463eb8717ff 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -4334,21 +4334,43 @@ static inline int open_to_namei_flags(int flag)
 
 static int may_o_create(const struct mnt_idmap *idmap,
 			const struct path *dir, struct dentry *dentry,
-			umode_t mode)
+			int open_flag, umode_t mode)
 {
-	int error = security_path_mknod(dir, dentry, mode, 0);
+	struct inode *dir_inode = dir->dentry->d_inode;
+	bool create_dir = O_IS_MKDIR(open_flag);
+	int error;
+
+	WARN_ON_ONCE(create_dir && !S_ISDIR(mode));
+
+	if (create_dir)
+		error = security_path_mkdir(dir, dentry, mode);
+	else
+		error = security_path_mknod(dir, dentry, mode, 0);
 	if (error)
 		return error;
 
 	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
 		return -EOVERFLOW;
 
-	error = inode_permission(idmap, dir->dentry->d_inode,
-				 MAY_WRITE | MAY_EXEC);
+	error = inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
 	if (error)
 		return error;
 
-	return security_inode_create(idmap, dir->dentry->d_inode, dentry, mode);
+	if (create_dir)
+		error = security_inode_mkdir(idmap, dir_inode, dentry, mode);
+	else
+		error = security_inode_create(idmap, dir_inode, dentry, mode);
+
+	return error;
+}
+
+static inline umode_t o_create_mode(const struct mnt_idmap *idmap, const struct inode *dir,
+				    int open_flag, umode_t mode)
+{
+	if (O_IS_MKDIR(open_flag))
+		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
+	else
+		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
 }
 
 /**
@@ -4384,8 +4406,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 
 	file->__f_path.dentry = DENTRY_NOT_SET;
 	file->__f_path.mnt = path->mnt;
+
 	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
-				       open_to_namei_flags(open_flag), mode);
+					     open_to_namei_flags(open_flag), mode);
+
 	d_lookup_done(dentry);
 
 	if (!error) {
@@ -4429,18 +4453,24 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
 			error = create_error;
 		}
 		dput(dentry);
-		dentry = ERR_PTR(error);
-	} else {
-		if (file->f_mode & FMODE_CREATED)
-			fsnotify_create(dir_inode, dentry);
-		if (file->f_mode & FMODE_OPENED)
-			fsnotify_open(file);
+		return ERR_PTR(error);
 	}
 
+	if (file->f_mode & FMODE_CREATED) {
+		if (d_is_dir(dentry))
+			fsnotify_mkdir(dir_inode, dentry);
+		else
+			fsnotify_create(dir_inode, dentry);
+	}
+	if (file->f_mode & FMODE_OPENED)
+		fsnotify_open(file);
 
 	return dentry;
 }
 
+static inline
+struct dentry *vfs_mkdir_no_perm(const struct mnt_idmap *, struct inode *, struct dentry *,
+				 umode_t, struct delegated_inode *);
 /*
  * Look up and maybe create and open the last component.
  *
@@ -4462,6 +4492,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	const struct mnt_idmap *idmap;
 	struct dentry *dir = nd->path.dentry;
 	struct inode *dir_inode = dir->d_inode;
+	bool create_dir = O_IS_MKDIR(op->open_flag);
 	int open_flag;
 	struct dentry *dentry;
 	int error, create_error;
@@ -4476,6 +4507,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	create_error = 0;
 	shared_flag = (open_flag & O_CREAT) ? 0 : LOOKUP_SHARED;
 
+	if (create_dir && (dir_inode->i_sb->s_iflags & SB_I_NO_ATOMIC_MKDIR))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
 		got_write = !mnt_want_write(nd->path.mnt);
 		/*
@@ -4537,10 +4571,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
+		mode = o_create_mode(idmap, dir_inode, open_flag, mode);
 		if (likely(got_write))
 			create_error = may_o_create(idmap, &nd->path,
-						    dentry, mode);
+						    dentry, open_flag, mode);
 		else
 			create_error = -EROFS;
 	}
@@ -4585,12 +4619,32 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 		goto out_dput;
 	}
 
-	if (!dir_inode->i_op->create) {
+	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
+	if (create_dir && !dir_inode->i_op->mkdir) {
+		error = -EPERM;
+		goto out_dput;
+	}
+	if (!create_dir && !dir_inode->i_op->create) {
 		error = -EACCES;
 		goto out_dput;
 	}
 
-	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
+	if (create_dir) {
+		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry, mode,
+						       &delegated_inode);
+		error = PTR_ERR_OR_ZERO(res);
+		if (!error) {
+			dentry = res;
+			/*
+			 * Filesystems whose ->mkdir() may leave the dentry
+			 * negative must set SB_I_NO_ATOMIC_MKDIR.
+			 */
+			if (WARN_ON_ONCE(d_is_negative(dentry)))
+				error = -EIO;
+		}
+	} else {
+		error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
+	}
 	if (error)
 		goto out_dput;
 
@@ -4722,7 +4776,7 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
 	struct dentry *dentry;
 
 	if (open_flag & O_CREAT) {
-		if (trailing_slashes(&nd->last))
+		if (trailing_slashes(&nd->last) && !(open_flag & O_DIRECTORY))
 			return ERR_PTR(-EISDIR);
 
 		/* Don't bother on an O_EXCL create */
@@ -4759,6 +4813,13 @@ static const char *open_last_lookups(struct nameidata *nd,
 	if (nd->last_type != LAST_NORM) {
 		if (nd->depth)
 			put_link(nd);
+		/*
+		 * Return -EOPNOTSUPP consistently, not -EEXIST, for paths
+		 * ending in . or .., as lookup_open() does for other names.
+		 */
+		if (O_IS_MKDIR(open_flag) &&
+		    (nd->path.dentry->d_sb->s_iflags & SB_I_NO_ATOMIC_MKDIR))
+			return ERR_PTR(-EOPNOTSUPP);
 		return handle_dots(nd, nd->last_type);
 	}
 
@@ -4823,7 +4884,7 @@ static int do_open(struct nameidata *nd,
 	if (open_flag & O_CREAT) {
 		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
 			return -EEXIST;
-		if (d_is_dir(nd->path.dentry))
+		if (!(open_flag & O_DIRECTORY) && d_is_dir(nd->path.dentry))
 			return -EISDIR;
 		error = may_create_in_sticky(idmap, nd,
 					     d_backing_inode(nd->path.dentry));
@@ -5170,7 +5231,7 @@ inline struct dentry *start_creating_user_path(
 EXPORT_SYMBOL(start_creating_user_path);
 
 /**
- * dentry_create - Create and open a file
+ * dentry_create - Create and open a regular file
  * @path: path to create
  * @flags: O\_ flags
  * @mode: mode bits for new file
@@ -5207,7 +5268,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
 		path->dentry = dir;
 		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
 
-		create_error = may_o_create(idmap, path, dentry, mode);
+		create_error = may_o_create(idmap, path, dentry, flags, mode);
 		if (create_error)
 			flags &= ~O_CREAT;
 
@@ -5375,7 +5436,7 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
 }
 
 static inline
-struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *idmap, struct inode *dir,
+struct dentry *vfs_mkdir_no_perm(const struct mnt_idmap *idmap, struct inode *dir,
 				 struct dentry *dentry, umode_t mode,
 				 struct delegated_inode *di)
 {
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cb19f1540d98..f4452b630f52 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1077,6 +1077,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 	sb->s_blocksize = 0;
 	sb->s_xattr = server->nfs_client->cl_nfs_mod->xattr;
 	sb->s_op = server->nfs_client->cl_nfs_mod->sops;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	if (server->bsize)
 		sb->s_blocksize =
 			nfs_block_size(server->bsize, &sb->s_blocksize_bits);
diff --git a/fs/open.c b/fs/open.c
index 4334f30bb7ff..8217106a6f4b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1264,29 +1264,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 	if (WILL_CREATE(flags)) {
 		if (how->mode & ~S_IALLUGO)
 			return -EINVAL;
-		op->mode = how->mode | S_IFREG;
+		if (O_IS_MKDIR(flags))
+			op->mode = how->mode | S_IFDIR;
+		else
+			op->mode = how->mode | S_IFREG;
 	} else {
 		if (how->mode != 0)
 			return -EINVAL;
 		op->mode = 0;
 	}
 
-	/*
-	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
-	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
-	 * O_TMPFILE below which requires O_DIRECTORY being raised.
-	 */
-	if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
-		return -EINVAL;
-
 	/* Now handle the creative implementation of O_TMPFILE. */
 	if (flags & __O_TMPFILE) {
 		/*
 		 * In order to ensure programs get explicit errors when trying
 		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
-		 * is raised alongside __O_TMPFILE.
+		 * is raised alongside __O_TMPFILE, but without O_CREAT. The
+		 * reason for disallowing O_CREAT|O_TMPFILE is that
+		 * O_DIRECTORY|O_CREAT used to work and created a regular file
+		 * if nothing existed at the open path. Hence, allowing the
+		 * combination would have caused O_CREAT|O_TMPFILE to create a
+		 * regular (non-temporary) file on old kernels, while the caller
+		 * would believe they created an actual O_TMPFILE.
 		 */
-		if (!(flags & O_DIRECTORY))
+		if (!(flags & O_DIRECTORY) || (flags & O_CREAT))
 			return -EINVAL;
 		if (!(acc_mode & MAY_WRITE))
 			return -EINVAL;
@@ -1353,11 +1354,19 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 		return -ENOTDIR;
 
 	if (flags & O_CREAT) {
-		op->intent |= LOOKUP_CREATE;
+		if (flags & O_DIRECTORY) {
+			/*
+			 * O_CREAT|O_DIRECTORY is provided to prevent TOCTOUs, so
+			 * it makes little sense to allow it without O_EXCL.
+			 */
+			if (!(flags & O_EXCL))
+				return -EINVAL;
+		}
 		if (flags & O_EXCL) {
 			op->intent |= LOOKUP_EXCL;
 			flags |= O_NOFOLLOW;
 		}
+		op->intent |= LOOKUP_CREATE;
 	}
 
 	if (flags & O_DIRECTORY)
diff --git a/fs/resctrl/rdtgroup.c b/fs/resctrl/rdtgroup.c
index 57ab090072c2..be151cc8fd29 100644
--- a/fs/resctrl/rdtgroup.c
+++ b/fs/resctrl/rdtgroup.c
@@ -4040,15 +4040,16 @@ static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
  * and monitor group(ctrl_mon). This is a resource group
  * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
  */
-static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
-			      const char *name, umode_t mode)
+static struct kernfs_node *rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
+					      const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp, *prgrp;
+	struct kernfs_node *kn;
 	int ret;
 
 	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	prgrp = rdtgrp->mon.parent;
 	rdtgrp->closid = prgrp->closid;
@@ -4067,17 +4068,22 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
 	 */
 	list_add_tail(&rdtgrp->mon.crdtgrp_list, &prgrp->mon.crdtgrp_list);
 
+	kn = rdtgrp->kn;
+	kernfs_get(kn);
+	rdtgroup_kn_unlock(parent_kn);
+	return kn;
+
 out_unlock:
 	rdtgroup_kn_unlock(parent_kn);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
  * These are rdtgroups created under the root directory. Can be used
  * to allocate and monitor resources.
  */
-static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
-				   const char *name, umode_t mode)
+static struct kernfs_node *rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
+						   const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp;
 	struct kernfs_node *kn;
@@ -4086,7 +4092,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 
 	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
 	if (ret)
-		return ret;
+		return ERR_PTR(ret);
 
 	kn = rdtgrp->kn;
 	ret = closid_alloc();
@@ -4125,7 +4131,9 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 			rdtgrp->mba_mbps_event = mba_mbps_default_event;
 	}
 
-	goto out_unlock;
+	kernfs_get(kn);
+	rdtgroup_kn_unlock(parent_kn);
+	return kn;
 
 out_del_list:
 	list_del(&rdtgrp->rdtgroup_list);
@@ -4135,17 +4143,16 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	closid_free(closid);
 out_common_fail:
 	mkdir_rdt_prepare_clean(rdtgrp);
-out_unlock:
 	rdtgroup_kn_unlock(parent_kn);
-	return ret;
+	return ERR_PTR(ret);
 }
 
-static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
-			  umode_t mode)
+static struct kernfs_node *rdtgroup_mkdir(struct kernfs_node *parent_kn,
+					  const char *name, umode_t mode)
 {
 	/* Do not accept '\n' to avoid unparsable situation. */
 	if (strchr(name, '\n'))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/*
 	 * If the parent directory is the root directory and RDT
@@ -4159,7 +4166,7 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	if (resctrl_arch_mon_capable())
 		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
-	return -EPERM;
+	return ERR_PTR(-EPERM);
 }
 
 static int rdtgroup_rmdir_mon(struct rdtgroup *rdtgrp, cpumask_var_t tmpmask)
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 576155caf888..f00dd2530b75 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -246,6 +246,7 @@ cifs_read_super(struct super_block *sb)
 
 	sb->s_magic = CIFS_SUPER_MAGIC;
 	sb->s_op = &cifs_super_ops;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	sb->s_xattr = cifs_xattr_handlers;
 	rc = super_setup_bdi(sb);
 	if (rc)
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5020365ca704..b679adf68c8f 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -471,6 +471,7 @@ static int tracefs_fill_super(struct super_block *sb, struct fs_context *fc)
 		return err;
 
 	sb->s_op = &tracefs_super_operations;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	tracefs_apply_options(sb, false);
 	set_default_d_op(sb, &tracefs_dentry_operations);
 
diff --git a/fs/vboxsf/super.c b/fs/vboxsf/super.c
index a61fbab51d37..190b76f04d4f 100644
--- a/fs/vboxsf/super.c
+++ b/fs/vboxsf/super.c
@@ -196,6 +196,7 @@ static int vboxsf_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_blocksize = 1024;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_op = &vboxsf_super_ops;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 	set_default_d_op(sb, &vboxsf_dentry_ops);
 
 	iroot = iget_locked(sb, 0);
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index 6ad6b9e7a226..204e16bbe263 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -30,6 +30,12 @@
  */
 #define __O_REGULAR		(1 << 30)
 
+#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
+static inline bool O_IS_MKDIR(unsigned int flags)
+{
+	return (flags & O_MKDIR_MASK) == O_MKDIR_MASK;
+}
+
 /* List of all valid flags for the how->resolve argument: */
 #define VALID_RESOLVE_FLAGS \
 	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
diff --git a/include/linux/fs/super_types.h b/include/linux/fs/super_types.h
index ecd96aeb1cee..521b00c47d0a 100644
--- a/include/linux/fs/super_types.h
+++ b/include/linux/fs/super_types.h
@@ -352,5 +352,6 @@ struct super_block {
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
 #define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 #define SB_I_NO_DATA_INTEGRITY	0x00008000 /* fs cannot guarantee data persistence on sync */
+#define SB_I_NO_ATOMIC_MKDIR	0x00010000 /* no O_CREAT|O_DIRECTORY on this fs */
 
 #endif /* _LINUX_FS_SUPER_TYPES_H */
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 73786b567ccd..2a7baa6a56bc 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -241,13 +241,14 @@ struct kernfs_node {
  * syscalls.  These optional callbacks are invoked on the matching syscalls
  * and can perform any kernfs operations which don't necessarily have to be
  * the exact operation requested.  An active reference is held for each
- * kernfs_node parameter.
+ * kernfs_node parameter.  @mkdir returns the kernfs_node of the new
+ * directory with a reference held, or an ERR_PTR() on failure.
  */
 struct kernfs_syscall_ops {
 	int (*show_options)(struct seq_file *sf, struct kernfs_root *root);
 
-	int (*mkdir)(struct kernfs_node *parent, const char *name,
-		     umode_t mode);
+	struct kernfs_node *(*mkdir)(struct kernfs_node *parent,
+				     const char *name, umode_t mode);
 	int (*rmdir)(struct kernfs_node *kn);
 	int (*rename)(struct kernfs_node *kn, struct kernfs_node *new_parent,
 		      const char *new_name);
diff --git a/kernel/cgroup/cgroup-internal.h b/kernel/cgroup/cgroup-internal.h
index 233fb8b45d2c..5d05fd75d0c0 100644
--- a/kernel/cgroup/cgroup-internal.h
+++ b/kernel/cgroup/cgroup-internal.h
@@ -256,7 +256,8 @@ void cgroup_procs_write_finish(struct task_struct *task,
 
 int cgroup_lock_and_drain_offline(struct cgroup *cgrp);
 
-int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode);
+struct kernfs_node *cgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
+				 umode_t mode);
 int cgroup_rmdir(struct kernfs_node *kn);
 int cgroup_show_path(struct seq_file *sf, struct kernfs_node *kf_node,
 		     struct kernfs_root *kf_root);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 14634246a666..a52d75447832 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6149,18 +6149,20 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 	return ret;
 }
 
-int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
+struct kernfs_node *cgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
+				 umode_t mode)
 {
 	struct cgroup *parent, *cgrp;
+	struct kernfs_node *kn;
 	int ret;
 
 	/* do not accept '\n' to prevent making /proc/<pid>/cgroup unparsable */
 	if (strchr(name, '\n'))
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	parent = cgroup_kn_lock_live(parent_kn, false);
 	if (IS_ERR(parent))
-		return PTR_ERR(parent);
+		return ERR_CAST(parent);
 
 	if (!cgroup_check_hierarchy_limits(parent)) {
 		ret = -EAGAIN;
@@ -6192,14 +6194,16 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	/* let's create and online css's */
 	kernfs_activate(cgrp->kn);
 
-	ret = 0;
-	goto out_unlock;
+	kn = cgrp->kn;
+	kernfs_get(kn);
+	cgroup_kn_unlock(parent_kn);
+	return kn;
 
 out_destroy:
 	cgroup_destroy_locked(cgrp);
 out_unlock:
 	cgroup_kn_unlock(parent_kn);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 /*
diff --git a/security/apparmor/apparmorfs.c b/security/apparmor/apparmorfs.c
index d1386722537d..36c9bb7ebf3d 100644
--- a/security/apparmor/apparmorfs.c
+++ b/security/apparmor/apparmorfs.c
@@ -248,6 +248,7 @@ static int apparmorfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (error)
 		return error;
 	sb->s_op = &aafs_super_ops;
+	sb->s_iflags |= SB_I_NO_ATOMIC_MKDIR;
 
 	return 0;
 }
-- 
2.56.0

