Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378D631E106
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 14:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311007; cv=none; b=sQUCu4YXw/H0u5xjyE7HzNMNkFJvXesRmpX2h7g/hpJ/Ucmguefmdr+EJSY8fAwEtAIXGVnCmhQokUE/gt5L2y+zK25AFbJySEKC3cmCF15KniIqhCalaLOLNuFworuf62aGzI4zk8Hi8QVSWAamsoS10ZWyQ0Z5ThdAjbIfGqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311007; c=relaxed/simple;
	bh=IBG2yfLzXGLsx3b/Ek1Ca8rr1SVh+H8bpvha5uJJBLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0dH6Xf9imMCND41QinJ8USpab6NW+Mp0W7pT5F4KNXDsb2KJrQKxxgy8ZIMDIeMPd6eOVwUW4S5E+GHLaXbvNX7ma7Bepd7Q9qH6u/KoSuh1x/4ywq2Q2YKMNqiR1NiCQmCSE9hGvFZxCht7z59IdA0nnbb3VWDyydULPCI58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT7zzk4f; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT7zzk4f"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49b965570d7so32513455e9.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 07:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789311000; x=1789915800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZ6sPJRJ6750EeDP6ag0yW3GyGNXKx/hcY4+42nnWbk=;
        b=VT7zzk4fCrTre5mOZr/Jf7lTVpKm4lEU8TN/yxdHue6v8JiiLQKOQV1ps5eLZ3PJRw
         F2zUYv4O1BWVvSk7wJIA21yYxLbHHJG4MwLaY2iOu/TdDE9y34fqwi3gcxjW+p/HYhUV
         Hv+QaQFt3DGvr8sUzf2mbqHaGfIBgnQQ6nB6V46Ft/wefPR5ey+XxEuLhicYbDZkVUVb
         E46CISXTls87i+nWACe09tNuEamKKVvPvVOLXXSrEPjO5EY9PInEkIfo7TFssEeLIXfM
         Z8kS7su/yzF1nBNQkZ60I1nRmgDCcbFIkPKg9ksPGaH3KhzDwTrH1eto/A2oBn5XLgKT
         zVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789311000; x=1789915800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZ6sPJRJ6750EeDP6ag0yW3GyGNXKx/hcY4+42nnWbk=;
        b=cbHLC/dxAybh6LDdcCDLTu9aLHFmPI6sluIqPXi/EpUSLrMz+UJ5Ys4psTqJUmVZa3
         DWtGYfa90SKXcyKRPdz2q+zpdWGQbRok5quAoljvKoxGPX0VatjFb6WMpmCAc/Dc4vxd
         RVpQYBrQhqMcbrBbgLpxnOTVEfSQR3ftlASrpISJmnd9mZbsbNeJ+tPYhRLOhxZSV7Ar
         3YeEC4BHHofBTFZtis+HLw8ZhEsY3pj1m8jsCkPUIe7P9L6i63unA9JIDQ8/ALBP2jA1
         ircx60qBH8f+qaLqFjon9pX5NOQEGYKDP7rp+f/aq98Dsyx64zZ3pCFPd34WglSynXDH
         J6jw==
X-Forwarded-Encrypted: i=1; AKwUvBy1v2xcqWEmJguzByUKS+mSeTFPxQBKk8dNPwQnZ9YbkRgjA3ffT8qLfK1DeeOQz7AGSJkgmt4M7NPqzAAF@vger.kernel.org
X-Gm-Message-State: AFuF++m197/gBsaMPOtILF6+Hja6k1lqT8leHxhpgYc267qmDyJ9gI1y
	MubYYt/UKlOl+RTUpo/Q1wt85E4ds/zS5iOw5Ooh9dB6eupm63lSP0EM8xF7dw==
X-Gm-Gg: AYBFou0omLXRv8dehcoik6rYOrRmEub++KQ5rQT75O23R/2uaDSgs3JZTfuwoUBK3Fv
	Ezbd8LONh+CPY/ISIWOaOoEh55I8MlrAl3FzzT39MbjeiOq85vHzosR59FjJm4e1n5SdNWGpIma
	TrX3WtqR5KJl5O7Ioe/r5oahw/EuDHc6Byv1CNDKdG9sBhh5uOI0VGMbweo9v5UUyFkAeqzzkuj
	WP2TP/Sg4FIxfD21S6PivlHvB1NUGON4BNyzo3qJIqF/Ave3RBY5xfr5JVxaIVbCWEugxEHywhL
	qiiXj+Z6VphY43ySz5TMgTlxcKKTAUlj+2doJSLniJgmmwKtGPzMW2mxNZnusBU9oBsle+Y0VlA
	5tvg/ZTRx535NE7r6GRe0XDSS3NmBgkznToGXQUGXLkwe9HU7Ewn4JqlyxVj8ToS1u5hpB/Xjue
	iAIU9wf8nBgqJK6Eb1biHY7UM67CCJDI1Jku9xcf85HUXC0voR5RkJ3nG3c5XrYt1P+i8n7alTG
	efolt5S5KuGHn99woV1ZDWgD12sV2TmI4F3EbwFgGg=
X-Received: by 2002:a05:600c:3b8c:b0:49e:73d3:78ab with SMTP id 5b1f17b1804b1-49e73d379e4mr63651815e9.0.1789310999832;
        Sun, 13 Sep 2026 07:49:59 -0700 (PDT)
Received: from f.. (cst-prg-84-1.cust.vodafone.cz. [46.135.84.1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e6420de77sm109534235e9.3.2026.09.13.07.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 07:49:59 -0700 (PDT)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH 06/10] Coccinelle-based conversion of path_* consumers to use the new primitives
Date: Sun, 13 Sep 2026 16:49:13 +0200
Message-ID: <20260913144918.1606123-7-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913144918.1606123-1-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional changes.

The script:
@@
expression src, dst;
@@

- *dst = *src;
- path_get(dst);
+ path_clone(src, dst);

@@
expression src, dst;
@@

- *dst = src;
- path_get(dst);
+ path_clone(&src, dst);

@@
expression src, dst;
@@

- dst = src;
- path_get(&dst);
+ path_clone(&src, &dst);

@@
expression src, dst;
@@

- *dst = src;
- path_get(src);
+ path_clone(src, dst);

@@
expression src, dst;
@@

- path_get(&src);
- *dst = src;
+ path_clone(&src, dst);

Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 drivers/block/loop.c               | 3 +--
 fs/autofs/dev-ioctl.c              | 3 +--
 fs/devpts/inode.c                  | 6 ++----
 fs/failfs.c                        | 3 +--
 fs/fhandle.c                       | 3 +--
 fs/file_attr.c                     | 6 ++----
 fs/fs_struct.c                     | 6 ++----
 fs/namei.c                         | 3 +--
 fs/namespace.c                     | 3 +--
 fs/notify/fanotify/fanotify_user.c | 3 +--
 fs/nsfs.c                          | 3 +--
 fs/open.c                          | 3 +--
 fs/overlayfs/params.c              | 3 +--
 fs/pidfs.c                         | 3 +--
 fs/proc/base.c                     | 3 +--
 fs/smb/server/vfs.c                | 3 +--
 fs/xfs/xfs_handle.c                | 3 +--
 kernel/trace/bpf_trace.c           | 3 +--
 security/apparmor/task.c           | 3 +--
 security/keys/big_key.c            | 3 +--
 security/landlock/fs.c             | 3 +--
 security/landlock/syscalls.c       | 3 +--
 22 files changed, 25 insertions(+), 50 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 758c20678bf6..cc5c11c57989 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1321,8 +1321,7 @@ loop_get_status(struct loop_device *lo, struct loop_info64 *info)
 	memcpy(info->lo_file_name, lo->lo_file_name, LO_NAME_SIZE);
 
 	/* Drop lo_mutex while we call into the filesystem. */
-	path = lo->lo_backing_file->f_path;
-	path_get(&path);
+	path_clone(&lo->lo_backing_file->f_path, &path);
 	mutex_unlock(&lo->lo_mutex);
 	ret = vfs_getattr(&path, &stat, STATX_INO, AT_STATX_SYNC_AS_STAT);
 	if (!ret) {
diff --git a/fs/autofs/dev-ioctl.c b/fs/autofs/dev-ioctl.c
index 6743b3b64217..a2ec9659297f 100644
--- a/fs/autofs/dev-ioctl.c
+++ b/fs/autofs/dev-ioctl.c
@@ -200,8 +200,7 @@ static int find_autofs_mount(const char *pathname,
 	while (path.dentry == path.mnt->mnt_root) {
 		if (path.dentry->d_sb->s_magic == AUTOFS_SUPER_MAGIC) {
 			if (test(&path, data)) {
-				path_get(&path);
-				*res = path;
+				path_clone(&path, res);
 				err = 0;
 				break;
 			}
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 9844dcf354ee..2b5d273edaa7 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -152,8 +152,7 @@ struct vfsmount *devpts_mntget(struct file *filp, struct pts_fs_info *fsi)
 	struct path path;
 	int err = 0;
 
-	path = filp->f_path;
-	path_get(&path);
+	path_clone(&filp->f_path, &path);
 
 	/* Walk upward while the start point is a bind mount of
 	 * a single file.
@@ -184,8 +183,7 @@ struct pts_fs_info *devpts_acquire(struct file *filp)
 	struct path path;
 	struct super_block *sb;
 
-	path = filp->f_path;
-	path_get(&path);
+	path_clone(&filp->f_path, &path);
 
 	/* Has the devpts filesystem already been found? */
 	if (path.mnt->mnt_sb->s_magic != DEVPTS_SUPER_MAGIC) {
diff --git a/fs/failfs.c b/fs/failfs.c
index 66a36da3d236..6459163de5b8 100644
--- a/fs/failfs.c
+++ b/fs/failfs.c
@@ -13,8 +13,7 @@ static struct path failfs_root_path = {};
 
 void failfs_get_root(struct path *path)
 {
-	*path = failfs_root_path;
-	path_get(path);
+	path_clone(&failfs_root_path, path);
 }
 
 bool failfs_mnt(const struct vfsmount *mnt)
diff --git a/fs/fhandle.c b/fs/fhandle.c
index f8829231e3d7..5c29a0a36c57 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -173,8 +173,7 @@ static int get_path_anchor(int fd, struct path *root)
 		CLASS(fd, f)(fd);
 		if (fd_empty(f))
 			return -EBADF;
-		*root = fd_file(f)->f_path;
-		path_get(root);
+		path_clone(&fd_file(f)->f_path, root);
 		return 0;
 	}
 
diff --git a/fs/file_attr.c b/fs/file_attr.c
index bfb00d256dd5..0a46fe39dfc7 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -402,8 +402,7 @@ SYSCALL_DEFINE5(file_getattr, int, dfd, const char __user *, filename,
 		if (fd_empty(f))
 			return -EBADF;
 
-		filepath = fd_file(f)->f_path;
-		path_get(&filepath);
+		path_clone(&fd_file(f)->f_path, &filepath);
 	} else {
 		error = filename_lookup(dfd, name, lookup_flags, &filepath,
 					NULL);
@@ -464,8 +463,7 @@ SYSCALL_DEFINE5(file_setattr, int, dfd, const char __user *, filename,
 		if (fd_empty(f))
 			return -EBADF;
 
-		filepath = fd_file(f)->f_path;
-		path_get(&filepath);
+		path_clone(&fd_file(f)->f_path, &filepath);
 	} else {
 		error = filename_lookup(dfd, name, lookup_flags, &filepath,
 					NULL);
diff --git a/fs/fs_struct.c b/fs/fs_struct.c
index 34699f3b6f88..330a15516787 100644
--- a/fs/fs_struct.c
+++ b/fs/fs_struct.c
@@ -120,10 +120,8 @@ struct fs_struct *copy_fs_struct(struct fs_struct *old)
 		fs->umask = old->umask;
 
 		read_seqlock_excl(&old->seq);
-		fs->root = old->root;
-		path_get(&fs->root);
-		fs->pwd = old->pwd;
-		path_get(&fs->pwd);
+		path_clone(&old->root, &fs->root);
+		path_clone(&old->pwd, &fs->pwd);
 		read_sequnlock_excl(&old->seq);
 	}
 	return fs;
diff --git a/fs/namei.c b/fs/namei.c
index 11937cfa8c7f..44fd82ee45c2 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1182,8 +1182,7 @@ static int nd_jump_root(struct nameidata *nd)
 			return -ECHILD;
 	} else {
 		path_put(&nd->path);
-		nd->path = nd->root;
-		path_get(&nd->path);
+		path_clone(&nd->root, &nd->path);
 		nd->inode = nd->path.dentry->d_inode;
 	}
 	nd->state |= ND_JUMPED;
diff --git a/fs/namespace.c b/fs/namespace.c
index a36ea2cc733d..79f785fabfdc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4614,8 +4614,7 @@ SYSCALL_DEFINE5(move_mount,
 		if (fd_empty(f_to))
 			return -EBADF;
 
-		to_path = fd_file(f_to)->f_path;
-		path_get(&to_path);
+		path_clone(&fd_file(f_to)->f_path, &to_path);
 	} else {
 		lflags = 0;
 		if (flags & MOVE_MOUNT_T_SYMLINKS)
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 63c9759fc3b0..3c49329543d9 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1202,8 +1202,7 @@ static int fanotify_find_path(int dfd, const char __user *filename,
 		    !(S_ISDIR(file_inode(fd_file(f))->i_mode)))
 			return -ENOTDIR;
 
-		*path = fd_file(f)->f_path;
-		path_get(path);
+		path_clone(&fd_file(f)->f_path, path);
 		ret = 0;
 	} else {
 		unsigned int lookup_flags = 0;
diff --git a/fs/nsfs.c b/fs/nsfs.c
index c3b6ae76594a..577c9edcea32 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -29,8 +29,7 @@ static struct path nsfs_root_path = {};
 
 void nsfs_get_root(struct path *path)
 {
-	*path = nsfs_root_path;
-	path_get(path);
+	path_clone(&nsfs_root_path, path);
 }
 
 static long ns_ioctl(struct file *filp, unsigned int ioctl,
diff --git a/fs/open.c b/fs/open.c
index e11d1342ff74..fc602c44b3bc 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -653,8 +653,7 @@ SYSCALL_DEFINE2(fchroot, int, fd, unsigned int, flags)
 		if (!ns_capable(current_user_ns(), CAP_SYS_CHROOT))
 			return -EPERM;
 
-		path = fd_file(f)->f_path;
-		path_get(&path);
+		path_clone(&fd_file(f)->f_path, &path);
 	}
 
 	error = security_path_chroot(&path);
diff --git a/fs/overlayfs/params.c b/fs/overlayfs/params.c
index c93fcaa45d4a..0c72e18dd625 100644
--- a/fs/overlayfs/params.c
+++ b/fs/overlayfs/params.c
@@ -474,8 +474,7 @@ static int ovl_parse_layer(struct fs_context *fc, struct fs_parameter *param,
 		if (!buf)
 			return -ENOMEM;
 
-		layer_path = param->file->f_path;
-		path_get(&layer_path);
+		path_clone(&param->file->f_path, &layer_path);
 
 		layer_name = d_path(&layer_path, buf, PATH_MAX);
 		if (IS_ERR(layer_name))
diff --git a/fs/pidfs.c b/fs/pidfs.c
index a6a643f15d08..c70a997376bd 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -42,8 +42,7 @@ static struct simple_xattr_cache pidfs_xa_cache;
 
 void pidfs_get_root(struct path *path)
 {
-	*path = pidfs_root_path;
-	path_get(path);
+	path_clone(&pidfs_root_path, path);
 }
 
 enum pidfs_attr_mask_bits {
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 0f9efd25bb05..01d8bfe1c410 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2253,8 +2253,7 @@ static int map_files_get_link(struct dentry *dentry, struct path *path,
 	rc = -ENOENT;
 	vma = find_exact_vma(mm, vm_start, vm_end);
 	if (vma && vma->vm_file) {
-		*path = *file_user_path(vma->vm_file);
-		path_get(path);
+		path_clone(file_user_path(vma->vm_file), path);
 		rc = 0;
 	}
 	mmap_read_unlock(mm);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 3a6f3139c6f5..c81b97a7356a 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -1349,8 +1349,7 @@ int __ksmbd_vfs_kern_path(struct ksmbd_work *work, char *filepath,
 	path_len = strlen(filepath);
 	remain_len = path_len;
 
-	parent_path = share_conf->vfs_path;
-	path_get(&parent_path);
+	path_clone(&share_conf->vfs_path, &parent_path);
 
 	while (d_can_lookup(parent_path.dentry)) {
 		char *filename = filepath + path_len - remain_len;
diff --git a/fs/xfs/xfs_handle.c b/fs/xfs/xfs_handle.c
index 0689cade8f74..7e3ddf2967c6 100644
--- a/fs/xfs/xfs_handle.c
+++ b/fs/xfs/xfs_handle.c
@@ -94,8 +94,7 @@ xfs_find_handle(
 
 		if (fd_empty(f))
 			return -EBADF;
-		path = fd_file(f)->f_path;
-		path_get(&path);
+		path_clone(&fd_file(f)->f_path, &path);
 	} else {
 		error = user_path_at(AT_FDCWD, hreq->path, 0, &path);
 		if (error)
diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 29260951aa87..ebe957432213 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3233,8 +3233,7 @@ static int bpf_uprobe_multi_get_path(const union bpf_attr *attr, struct path *pa
 		CLASS(fd, f)(path_fd);
 		if (fd_empty(f))
 			return -EBADF;
-		*path = fd_file(f)->f_path;
-		path_get(path);
+		path_clone(&fd_file(f)->f_path, path);
 		return 0;
 	}
 
diff --git a/security/apparmor/task.c b/security/apparmor/task.c
index e16ff4130bc2..36ca424760e2 100644
--- a/security/apparmor/task.c
+++ b/security/apparmor/task.c
@@ -337,8 +337,7 @@ static const char *get_current_exe_path(char *buffer, int buffer_size)
 	exe_file = get_task_exe_file(current);
 	if (!exe_file)
 		return ERR_PTR(-ENOENT);
-	p = exe_file->f_path;
-	path_get(&p);
+	path_clone(&exe_file->f_path, &p);
 
 	if (aa_path_name(&p, FLAG_VIEW_SUBNS, buffer, &path_str, NULL, NULL))
 		path_str = ERR_PTR(-ENOMEM);
diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380..e20de015c626 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -121,8 +121,7 @@ int big_key_preparse(struct key_preparsed_payload *prep)
 		 * later
 		 */
 		payload->data = enckey;
-		payload->path = file->f_path;
-		path_get(&payload->path);
+		path_clone(&file->f_path, &payload->path);
 		fput(file);
 		kvfree_sensitive(buf, enclen);
 	} else {
diff --git a/security/landlock/fs.c b/security/landlock/fs.c
index 330a1871bf94..3c614c56e3f8 100644
--- a/security/landlock/fs.c
+++ b/security/landlock/fs.c
@@ -892,8 +892,7 @@ is_access_to_paths_allowed(const struct landlock_domain *const domain,
 		child2_is_directory = d_is_dir(dentry_child2);
 	}
 
-	walker_path = *path;
-	path_get(&walker_path);
+	path_clone(&*path, &walker_path);
 	/*
 	 * We need to walk through all the hierarchy to not miss any relevant
 	 * restriction.
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 1d02d57f4c48..003f4aa12e4b 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -349,8 +349,7 @@ static int get_path_from_fd(const s32 fd, struct path *const path)
 	    IS_PRIVATE(d_backing_inode(fd_file(f)->f_path.dentry)))
 		return -EBADFD;
 
-	*path = fd_file(f)->f_path;
-	path_get(path);
+	path_clone(&fd_file(f)->f_path, path);
 	return 0;
 }
 
-- 
2.53.0

