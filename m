Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78B3365A0B;
	Tue, 19 May 2026 22:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229547; cv=none; b=dPflS5ZbwM2Ym8rRAXvATOe+0FT9ye9FTOIke0zhlCSvB2RiCDIr6rAOracFUteTqitPrP0EDtXXbo4D8i+2mU5OxJAL89oySpwQizGYf0UbKPltFJZU6K+HMkXZ4MUNs9ONOgI4ZSzcIRiU7aVf1ffR3hZt0KAXHEKaxCNv1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229547; c=relaxed/simple;
	bh=29OT1+fLMZSvjiTQ1/hRR3jf95o6DgJEHkb6vJswq2Q=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXpBrnrkvfVGh7tgcgJwcDS9dnnv7TYqEs+u3dJZ0l7vjctWK67l4OxARpvAXBhUfkOw5ZME9n1W3E31k4C6vopdhOjRHd7v/oHGHOQca8jJ2815xbC/fPxxxN/mNfpInXNBhWv1DjOj1WxSO4/3yiikKbL4LgQ+iVYZiJtWlCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5A8p2w5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5A8p2w5"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 585601F00894;
	Tue, 19 May 2026 22:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229545;
	bh=q/HSvVm7FuwDnZIghjmebFfESEODhGLMBKOVq99b4Lo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=Y5A8p2w5Yj0oiv1O/6IK+Djg+r7bUxR0Uz6SQgR+z0MgEtBWGANobWhNfbhP84SKU
	 xDVKe7VvElDE8Pc5w45D1fYmyMk4BdJjoaGozmRmv+vSLWEK87+Fl8R2gv9KtRlrOc
	 uJgCrhKMZ+f4cR5cwDnbbMDowyv6/IYMgj0h+qv271kw7xMLiz0RFTHVNmQgB4fRUJ
	 L+lQyLR2k39qXiXW+97sEOUMcGwb7ujGdvCoNv8snNUK1SuWuB0PszeTj0ux510s8/
	 NDoWwYwUpbWcg0pmRI82robWWS0UPl2NcX8ruLkJwV/SXNTyESFM81uNZ9MLnLb1uY
	 OnxbT15xCfTmg==
Date: Tue, 19 May 2026 15:25:45 -0700
Subject: [PATCH 1/4] fuse: move the passthrough-specific code back to
 passthrough.c
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922944844.2436629.11205124993260163523.stgit@frogsfrogsfrogs>
In-Reply-To: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
References: <177922944800.2436629.7011047808676668088.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

In preparation for iomap, move the passthrough-specific validation code
back to passthrough.c and create a new Kconfig item for conditional
compilation of backing.c.  In the next patch, iomap will share the
backing structures.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   26 +++++++++-
 include/uapi/linux/fuse.h |    8 +++
 fs/fuse/Kconfig           |    4 ++
 fs/fuse/Makefile          |    3 +
 fs/fuse/backing.c         |  113 ++++++++++++++++++++++++++++++++++-----------
 fs/fuse/dev.c             |    4 +-
 fs/fuse/inode.c           |    4 +-
 fs/fuse/passthrough.c     |   38 +++++++++++++++
 8 files changed, 162 insertions(+), 38 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 0b9c617ee3e5be..7f9939df81e3f9 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -103,10 +103,24 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+struct fuse_conn;
+struct fuse_backing;
+
+/** Operations for subsystems that want to use a backing file */
+struct fuse_backing_ops {
+	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
+	int (*may_open)(struct fuse_conn *fc, struct file *file);
+	int (*may_close)(struct fuse_conn *fc, const struct fuse_backing *fb);
+	unsigned int type;
+	int id_start;
+	int id_end;
+};
+
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	const struct fuse_backing_ops *ops;
 
 	/** refcount */
 	refcount_t count;
@@ -980,7 +994,7 @@ struct fuse_conn {
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
 
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
@@ -1591,10 +1605,12 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 		       unsigned int open_flags, fl_owner_t id, bool isdir);
 
 /* backing.c */
-#ifdef CONFIG_FUSE_PASSTHROUGH
+#ifdef CONFIG_FUSE_BACKING
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
-struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
+					 const struct fuse_backing_ops *ops,
+					 int backing_id);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1649,6 +1665,10 @@ static inline struct file *fuse_file_passthrough(struct fuse_file *ff)
 #endif
 }
 
+#ifdef CONFIG_FUSE_PASSTHROUGH
+extern const struct fuse_backing_ops fuse_passthrough_backing_ops;
+#endif
+
 ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_iter *iter);
 ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12bd..18713cfaf09171 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1126,9 +1126,15 @@ struct fuse_notify_prune_out {
 	uint64_t	spare;
 };
 
+#define FUSE_BACKING_TYPE_MASK		(0xFF)
+#define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_PASSTHROUGH)
+
+#define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
+
 struct fuse_backing_map {
 	int32_t		fd;
-	uint32_t	flags;
+	uint32_t	flags; /* FUSE_BACKING_* */
 	uint64_t	padding;
 };
 
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 3a4ae632c94aa8..290d1c09e0b924 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
 	default y
 	depends on FUSE_FS
 	select FS_STACK
+	select FUSE_BACKING
 	help
 	  This allows bypassing FUSE server by mapping specific FUSE operations
 	  to be performed directly on a backing file.
 
 	  If you want to allow passthrough operations, answer Y.
 
+config FUSE_BACKING
+	bool
+
 config FUSE_IO_URING
 	bool "FUSE communication over io-uring"
 	default y
diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 22ad9538dfc4b8..46041228e5be2c 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -14,7 +14,8 @@ fuse-y := trace.o	# put trace.o first so we see ftrace errors sooner
 fuse-y += dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
 fuse-y += iomode.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
-fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o backing.o
+fuse-$(CONFIG_FUSE_PASSTHROUGH) += passthrough.o
+fuse-$(CONFIG_FUSE_BACKING) += backing.o
 fuse-$(CONFIG_SYSCTL) += sysctl.o
 fuse-$(CONFIG_FUSE_IO_URING) += dev_uring.o
 
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index d95dfa48483f0a..4f86f3ca13fd40 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_trace.h"
 
 #include <linux/file.h>
 
@@ -41,10 +42,13 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 {
 	int id;
 
+	WARN_ON_ONCE(fb->ops->id_start < 1);
+
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATOMIC);
+	id = idr_alloc_cyclic(&fc->backing_files_map, fb, fb->ops->id_start,
+			      fb->ops->id_end, GFP_ATOMIC);
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -52,16 +56,25 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing *fb)
 	return id;
 }
 
-static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
-						   int id)
+static int fuse_backing_id_remove(struct fuse_conn *fc, int id,
+				  struct fuse_backing *old_fb)
 {
 	struct fuse_backing *fb;
+	int ret = 0;
 
 	spin_lock(&fc->lock);
+	fb = idr_find(&fc->backing_files_map, id);
+	if (fb != old_fb) {
+		ret = -EBADF;
+		goto out_unlock;
+	}
+
 	fb = idr_remove(&fc->backing_files_map, id);
-	spin_unlock(&fc->lock);
+	WARN_ON(fb != old_fb);
 
-	return fb;
+out_unlock:
+	spin_unlock(&fc->lock);
+	return ret;
 }
 
 static int fuse_backing_id_free(int id, void *p, void *data)
@@ -75,26 +88,46 @@ static int fuse_backing_id_free(int id, void *p, void *data)
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
 	idr_destroy(&fc->backing_files_map);
 }
 
+static inline const struct fuse_backing_ops *
+fuse_backing_ops_from_map(const struct fuse_backing_map *map)
+{
+	switch (map->flags & FUSE_BACKING_TYPE_MASK) {
+#ifdef CONFIG_FUSE_PASSTHROUGH
+	case FUSE_BACKING_TYPE_PASSTHROUGH:
+		return &fuse_passthrough_backing_ops;
+#endif
+	default:
+		break;
+	}
+
+	return NULL;
+}
+
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 {
 	struct file *file;
-	struct super_block *backing_sb;
 	struct fuse_backing *fb = NULL;
+	const struct fuse_backing_ops *ops = fuse_backing_ops_from_map(map);
+	uint32_t op_flags = map->flags & ~FUSE_BACKING_TYPE_MASK;
 	int res;
 
 	pr_debug("%s: fd=%d flags=0x%x\n", __func__, map->fd, map->flags);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	res = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+	res = -EOPNOTSUPP;
+	if (!ops)
+		goto out;
+	WARN_ON(ops->type != (map->flags & FUSE_BACKING_TYPE_MASK));
+
+	res = ops->may_admin ? ops->may_admin(fc, op_flags) : 0;
+	if (res)
 		goto out;
 
 	res = -EINVAL;
-	if (map->flags || map->padding)
+	if (map->padding)
 		goto out;
 
 	file = fget_raw(map->fd);
@@ -102,14 +135,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!file)
 		goto out;
 
-	/* read/write/splice/mmap passthrough only relevant for regular files */
-	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
-	if (!d_is_reg(file->f_path.dentry))
-		goto out_fput;
-
-	backing_sb = file_inode(file)->i_sb;
-	res = -ELOOP;
-	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+	res = ops->may_open ? ops->may_open(fc, file) : 0;
+	if (res)
 		goto out_fput;
 
 	fb = kmalloc_obj(struct fuse_backing);
@@ -119,14 +146,15 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 
 	fb->file = file;
 	fb->cred = prepare_creds();
+	fb->ops = ops;
 	refcount_set(&fb->count, 1);
 
 	res = fuse_backing_id_alloc(fc, fb);
 	if (res < 0) {
 		fuse_backing_free(fb);
 		fb = NULL;
+		goto out;
 	}
-
 out:
 	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
 
@@ -137,41 +165,70 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	goto out;
 }
 
+static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc,
+						  int backing_id)
+{
+	struct fuse_backing *fb;
+
+	rcu_read_lock();
+	fb = idr_find(&fc->backing_files_map, backing_id);
+	fb = fuse_backing_get(fb);
+	rcu_read_unlock();
+
+	return fb;
+}
+
 int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 {
 	struct fuse_backing *fb = NULL;
+	const struct fuse_backing_ops *ops;
 	int err;
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	err = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
-		goto out;
-
 	err = -EINVAL;
 	if (backing_id <= 0)
 		goto out;
 
 	err = -ENOENT;
-	fb = fuse_backing_id_remove(fc, backing_id);
+	fb = __fuse_backing_lookup(fc, backing_id);
 	if (!fb)
 		goto out;
+	ops = fb->ops;
 
+	err = ops->may_admin ? ops->may_admin(fc, 0) : 0;
+	if (err)
+		goto out_fb;
+
+	err = ops->may_close ? ops->may_close(fc, fb) : 0;
+	if (err)
+		goto out_fb;
+
+	err = fuse_backing_id_remove(fc, backing_id, fb);
+	if (err)
+		goto out_fb;
+
+	/* drop the backing id cache's refcount */
+	fuse_backing_put(fb);
+out_fb:
+	/* drop the refcount we got earlier */
 	fuse_backing_put(fb);
-	err = 0;
 out:
 	pr_debug("%s: fb=0x%p, err=%i\n", __func__, fb, err);
 
 	return err;
 }
 
-struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
+struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
+					 const struct fuse_backing_ops *ops,
+					 int backing_id)
 {
 	struct fuse_backing *fb;
 
 	rcu_read_lock();
 	fb = idr_find(&fc->backing_files_map, backing_id);
+	if (fb && fb->ops != ops)
+		fb = NULL;
 	fb = fuse_backing_get(fb);
 	rcu_read_unlock();
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2ff09d9f101d00..2708e17bc46949 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2644,7 +2644,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (copy_from_user(&map, argp, sizeof(map)))
@@ -2661,7 +2661,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (IS_ERR(fud))
 		return PTR_ERR(fud);
 
-	if (!IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
 		return -EOPNOTSUPP;
 
 	if (get_user(backing_id, argp))
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b43e4bf4a1c117..c04d9ae42bb008 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1034,7 +1034,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->name_max = FUSE_NAME_LOW_MAX;
 	fc->timeout.req_timeout = 0;
 
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_init(fc);
 
 	INIT_LIST_HEAD(&fc->mounts);
@@ -1074,7 +1074,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		WARN_ON(atomic_read(&bucket->count) != 1);
 		kfree(bucket);
 	}
-	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
+	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_free(fc);
 	call_rcu(&fc->rcu, delayed_release);
 }
diff --git a/fs/fuse/passthrough.c b/fs/fuse/passthrough.c
index f2d08ac2459b7e..a3ea9b9eb903d5 100644
--- a/fs/fuse/passthrough.c
+++ b/fs/fuse/passthrough.c
@@ -162,7 +162,7 @@ struct fuse_backing *fuse_passthrough_open(struct file *file, int backing_id)
 		goto out;
 
 	err = -ENOENT;
-	fb = fuse_backing_lookup(fc, backing_id);
+	fb = fuse_backing_lookup(fc, &fuse_passthrough_backing_ops, backing_id);
 	if (!fb)
 		goto out;
 
@@ -195,3 +195,39 @@ void fuse_passthrough_release(struct fuse_file *ff, struct fuse_backing *fb)
 	put_cred(ff->cred);
 	ff->cred = NULL;
 }
+
+static int fuse_passthrough_may_admin(struct fuse_conn *fc, unsigned int flags)
+{
+	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int fuse_passthrough_may_open(struct fuse_conn *fc, struct file *file)
+{
+	struct super_block *backing_sb;
+	int res;
+
+	/* read/write/splice/mmap passthrough only relevant for regular files */
+	res = d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
+	if (!d_is_reg(file->f_path.dentry))
+		return res;
+
+	backing_sb = file_inode(file)->i_sb;
+	if (backing_sb->s_stack_depth >= fc->max_stack_depth)
+		return -ELOOP;
+
+	return 0;
+}
+
+const struct fuse_backing_ops fuse_passthrough_backing_ops = {
+	.type = FUSE_BACKING_TYPE_PASSTHROUGH,
+	.id_start = 1,
+	.may_admin = fuse_passthrough_may_admin,
+	.may_open = fuse_passthrough_may_open,
+};

