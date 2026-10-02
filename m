Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E632749AA34
	for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2026 14:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790950478; cv=none; b=f9xQ1tcLn9qCkAubAODY/YhvaGazYtQ3Ceu8I4kQc/U7fBQgxV2vFg7/tNp8GEHfnr9Ell3Nh8XNzDHnytd4RC8fr9DuBmML9yToxc/oSrjsJKd9fIgmFlwIdTWMo+6z1GflYuLUjErpbjw6dfcbje6XbOGp3zu8/nnuc7I5P08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790950478; c=relaxed/simple;
	bh=qmv51oUheGo6zzXzuMNVQvhv3GKASV3Tk7XXMhGO4bs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dmOx9Ukga7x6mkQHAGHgH9KxZXZsczbt2ne22aJNkHBqkVf2t+wGgVFovxDSLyEG/HGYVBJu8hNRB0PPgO+dnZPEhB8THZL4Mjeu2kA3P2vO6kZsiIeT+hWi/BMNsMCazt3B3AqSYd4+o6WgLR6amthDV4hxgafVgBUFJgkeH3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUfOhwAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUfOhwAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFF81F00893;
	Fri,  2 Oct 2026 14:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790950476;
	bh=DI5nyXXjttptFVUfbJ7w9e8pYdHcwTjegkM9ILztjz4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mUfOhwAR9Yt77DGE1IrukVYkOGnaqEPb50daOqufuohz5/+8iL9yzIyyvoiIrvCII
	 in7vUn346Yg7PrpK1neCDfBvahEA+mdfhqS8TVL07SH4widl9imHioSDpFXzcrE+ld
	 vTWIuGEzvX9UZ2SOiZQW8Jt07QfH1kyLOvV/sgPltJjPzy7jHsR7UeXNIxonJCimol
	 TntNVRDjDL0/13Q5MCh6lGU9M44/PS//ZjwgWNhgBYh8exSbIcEBGSA4UsYw381HMK
	 EVcul6fVDbok0qU4iLY/vThvOKKUM6NwZ8N0ERA36INb+k12x/t0jKD/1FBtvBJZRY
	 6JzxBNLm9hLpQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 16:14:27 +0200
Subject: [PATCH 1/3] nullfs: add an empty immutable regular file
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-cover-v1-1-232a8f52b43c@kernel.org>
References: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
In-Reply-To: <20261002-work-mount-cover-v1-0-232a8f52b43c@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>, 
 Amir Goldstein <amir73il@gmail.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4704; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qmv51oUheGo6zzXzuMNVQvhv3GKASV3Tk7XXMhGO4bs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3+O2PoJFSPsnp8POD4cnnT5cFiatsufsDunCtxL/p
 vbvvHcytaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAiDRcZGS7IavzaGnfMScXu
 t0XQE6X4SqZ1N8zeC/JNvZfa0DFhZRDD/7BK7/hpORppUsxnNP7NnHQqPiXKTDX1vmuR4xqVg7o
 1fAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add nullfs_new_file() to allocate an empty immutable regular file on a
nullfs instance as a dentry of its own. It is never hashed under the
root and so can't be found by lookup. Reads return nothing, changes are
refused, file locks, leases and delegations are refused as.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/mount.h     |  1 +
 fs/namespace.c | 25 +++++++++++++++++++++++++
 fs/nullfs.c    | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/fs/mount.h b/fs/mount.h
index 4e68e5cbc254..2e29cdbaeb74 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -6,6 +6,7 @@
 #include <linux/fs_pin.h>
 
 extern struct file_system_type nullfs_fs_type;
+extern struct dentry *nullfs_new_file(struct super_block *sb);
 extern struct vfsmount *knullfs;
 extern struct list_head notify_list;
 
diff --git a/fs/namespace.c b/fs/namespace.c
index e1b0ade95b0d..ff21e0440fae 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -81,6 +81,7 @@ static struct hlist_head *mount_hashtable __ro_after_init;
 static struct hlist_head *mountpoint_hashtable __ro_after_init;
 static struct kmem_cache *mnt_cache __ro_after_init;
 struct vfsmount *knullfs __ro_after_init;	/* private nullfs instance */
+static struct vfsmount *knullfs_file __ro_after_init;	/* its regular file */
 static DECLARE_RWSEM(namespace_sem);
 static HLIST_HEAD(unmounted);	/* protected by namespace_sem */
 static LIST_HEAD(ex_mountpoints); /* protected by namespace_sem */
@@ -6330,6 +6331,25 @@ static void __init mount_rootfs_on_nullfs(struct vfsmount *mnt,
 		attach_mnt(real_mount(mnt), mp.parent, mp.mp);
 }
 
+static struct vfsmount *__init knullfs_file_mount(void)
+{
+	struct dentry *file;
+	struct mount *mnt;
+
+	file = nullfs_new_file(knullfs->mnt_sb);
+	if (IS_ERR(file))
+		return ERR_CAST(file);
+	mnt = clone_mnt(real_mount(knullfs), file, CL_PRIVATE);
+	dput(file);
+	if (IS_ERR(mnt))
+		return ERR_CAST(mnt);
+	mnt->mnt_ns = MNT_NS_INTERNAL;
+	mnt->mnt.mnt_flags |= MNT_INTERNAL | MNT_READONLY;
+	/* nothing is ever mounted on it either */
+	dont_mount(mnt->mnt.mnt_root);
+	return &mnt->mnt;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt, *nullfs_mnt;
@@ -6342,6 +6362,8 @@ static void __init init_mount_tree(void)
 	 * (1) nullfs with mount id 1
 	 * (2) mutable rootfs with mount id 2
 	 * (3) private nullfs for kthreads (SB_KERNMOUNT), kept in knullfs
+	 * (4) a second mount of (3) rooted on a regular file, kept in
+	 *     knullfs_file
 	 *
 	 * with (2) mounted on top of (1). The init_task's root and pwd
 	 * are pointed at (3) so all kthreads start isolated in nullfs.
@@ -6383,6 +6405,9 @@ static void __init init_mount_tree(void)
 	dont_mount(knullfs->mnt_root);
 	/* and nothing is ever written through it */
 	knullfs->mnt_flags |= MNT_READONLY;
+	knullfs_file = knullfs_file_mount();
+	if (IS_ERR(knullfs_file))
+		panic("VFS: Failed to create the nullfs file stand-in");
 	root.mnt	= knullfs;
 	root.dentry	= knullfs->mnt_root;
 
diff --git a/fs/nullfs.c b/fs/nullfs.c
index bfc04bca3940..b1469e49b2d1 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -47,6 +47,52 @@ static const struct file_operations nullfs_dir_operations = {
 	.fop_flags	= FOP_IMMUTABLE,
 };
 
+/* a file of nullfs is permanently empty */
+static ssize_t nullfs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
+{
+	return 0;
+}
+
+/* an empty regular file, with the same refusals as the directory */
+static const struct file_operations nullfs_file_operations = {
+	.llseek		= generic_file_llseek,
+	.read_iter	= nullfs_file_read_iter,
+	.fsync		= noop_fsync,
+	.lock		= nullfs_nolock,
+	.flock		= nullfs_nolock,
+	.setlease	= nullfs_nolease,
+};
+
+/*
+ * An empty immutable regular file on @sb as a dentry of its own. It is
+ * never hashed under the root so no lookup finds it.
+ */
+struct dentry *nullfs_new_file(struct super_block *sb)
+{
+	struct dentry *dentry;
+	struct inode *inode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return ERR_PTR(-ENOMEM);
+
+	/* the root directory is 1 */
+	inode->i_ino = 2;
+	inode->i_mode = S_IFREG | 0444;
+	inode->i_fop = &nullfs_file_operations;
+	simple_inode_init_ts(inode);
+	/* ... and immutable, reading it leaves no trace either */
+	inode->i_flags |= S_IMMUTABLE | S_NOATIME;
+
+	dentry = d_alloc_anon(sb);
+	if (!dentry) {
+		iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
+	d_instantiate(dentry, inode);
+	return dentry;
+}
+
 static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
 {
 	struct inode *inode;

-- 
2.53.0

