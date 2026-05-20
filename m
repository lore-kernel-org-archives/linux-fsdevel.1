Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9BD3290D5;
	Wed, 20 May 2026 06:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257738; cv=none; b=itGunu/MiSjhbPdog5xRDhwirUZYrgfQQSYEAd9t6ega9iuinGCytSTJx4fgf38YW2gCOZbMgkDXv95/WGjZqDg0ObBntZsBskxYBp21LN0JjE3u8EaXVA0ssj3nU8epHkbjcJzSSzrhvh6frtEdwh4uEcbXcxczI7a+J3sXL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257738; c=relaxed/simple;
	bh=jeyPke6r2AE83OJRC/hi/BJeiGkFzWmuOAL6NW6+EVk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLuZe1sm6R1TWKeYSqFWczFkY5PYzbcnGrqzapcZqSyyNEWbWtqs93wvmOMbeT2b0vrfDN4GmiJfz1wBSKi+mr6qdLxudKA07V4BNIUAvvCa6jaG5i0qgHcduMoADO2kbkBYAng62OFo6SET9VAzR0O3wQBeXH5N9Tx6D2Us6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iQyihLf8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iQyihLf8"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 540811F000E9;
	Wed, 20 May 2026 06:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779257736;
	bh=KJ0WViYPIF+Rd0cv8BqAn/IaEBQn/zMAG18dbXIWvxY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=iQyihLf8+25iRwgVJ55AlLGhGfCwr83jPCqPg45izdzg+aXZr4+9Tc0xZZj4h7Rrb
	 gkOa2yZmlwLXamkbNF/sY4IEAUeq31GN9/EOg9JokEYWiuy1MrIrw2P2ahVg4zSFNH
	 E7xhBIAyYQpm/oTwdI9R06Gwlrcw6JLDPjFNrWooLIgAC8h/FHt9sjs0GA+xU6pxsA
	 5bLVZ36M10+BNL/1feBXXTUAr2hn85nt6biq40Mw5SEU3ekfZahYRv6+4j6a1iIy64
	 2b3v/6Ol8lnWCttX6T8YuCCqgtabMUKzuIneUTxu4VpeQRuzK4K51yhqGWg7r08fk8
	 jyjg6wy/UlZxw==
Date: Tue, 19 May 2026 23:15:36 -0700
Subject: [PATCH 1/4] fuse: allow fuse servers to upload stripe maps
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, hch@infradead.org, joannelkoong@gmail.com,
 john@groves.net
Message-ID: <177925767705.2711065.7984122014773593135.stgit@frogsfrogsfrogs>
In-Reply-To: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
References: <177925767662.2711065.15846161331592459171.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable userspace to create a virtual backing fd that really just
contains a stripe map of other iomap backing fds.  This enables us to
implement in-filesystem striping.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |   30 +++++++++++
 fs/fuse/fuse_iomap.h      |    7 +++
 fs/fuse/fuse_trace.h      |    6 +-
 include/uapi/linux/fuse.h |   19 +++++++
 fs/fuse/backing.c         |   84 ++++++++++++++++++++++++++++++++
 fs/fuse/dev.c             |    2 +
 fs/fuse/fuse_iomap.c      |  118 +++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/inode.c           |    1 
 8 files changed, 263 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index bdf18550c34708..bd45c4dfaccd0d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -106,22 +106,45 @@ struct fuse_submount_lookup {
 struct fuse_conn;
 struct fuse_backing;
 
+/* internal backing device type, larger than userspace can pass in */
+#define FUSE_BACKING_TYPE_IOMAP_STRIPE		(FUSE_BACKING_TYPE_MASK + 1)
+
 /** Operations for subsystems that want to use a backing file */
 struct fuse_backing_ops {
 	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
 	int (*may_open)(struct fuse_conn *fc, struct file *file);
 	int (*may_close)(struct fuse_conn *fc, const struct fuse_backing *fb);
 	int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
+	void (*free_data)(const void *fbdata);
 	unsigned int type;
 	int id_start;
 	int id_end;
 };
 
+struct fuse_backing_strip {
+	struct fuse_backing *fb;
+	uint64_t addr;		/* disk offset of strip, bytes */
+	uint32_t dev;		/* backing id */
+};
+
+struct fuse_backing_stripe {
+	unsigned int nr_strips;
+	uint64_t strip_width;	/* strip width, bytes */
+
+	struct fuse_backing_strip strips[] __counted_by(nr_strips);
+};
+
+static inline size_t sizeof_fuse_backing_stripe(unsigned int nr)
+{
+	return flex_array_size((struct fuse_backing_stripe *)NULL, strips, nr);
+}
+
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
 	struct block_device *bdev;
+	void *data;
 	const struct fuse_backing_ops *ops;
 
 	int id;
@@ -1707,6 +1730,11 @@ typedef bool (*fuse_match_backing_fn)(const struct fuse_backing *fb,
 int fuse_backing_lookup_id(struct fuse_conn *fc,
 			   const struct fuse_backing_ops *ops,
 			   fuse_match_backing_fn match_fn, const void *data);
+
+typedef int (*fuse_backing_iter_fn)(struct fuse_backing *fb, void *data);
+int fuse_backing_foreach(struct fuse_conn *fc,
+			 const struct fuse_backing_ops *ops,
+			 fuse_backing_iter_fn iter_fn, void *data);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1727,6 +1755,8 @@ static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
+int fuse_backing_create(struct fuse_conn *fc,
+			const struct fuse_backing_ops *ops, void *data);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
 /* passthrough.c */
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 7e5e073df5c92d..267bc55fb3368c 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -20,6 +20,7 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 }
 
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
+extern const struct fuse_backing_ops fuse_iomap_stripe_backing_ops;
 
 int fuse_iomap_mount_sync(struct fuse_mount *fm);
 void fuse_iomap_mount_async(struct fuse_mount *fm);
@@ -81,11 +82,15 @@ int fuse_iomap_backing_inval(struct fuse_conn *fc,
 			     const struct fuse_iomap_backing_inval_out *arg);
 int fuse_iomap_backing_set_blocksize(struct file *file,
 				     struct fuse_iomap_backing_info __user *argp);
+int fuse_iomap_backing_stripe_config(struct file *file,
+				     struct fuse_iomap_backing_stripe __user *argp);
 
 int fuse_iomap_upsert_mappings(struct fuse_conn *fc,
 			       const struct fuse_iomap_upsert_mappings_out *outarg);
 int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 			      const struct fuse_iomap_inval_mappings_out *outarg);
+
+void fuse_iomap_conn_free(struct fuse_conn *fc);
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
@@ -117,8 +122,10 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 # define fuse_dev_ioctl_iomap_set_nofs(...)	(-EOPNOTSUPP)
 # define fuse_iomap_backing_inval(...)		(-ENOSYS)
 # define fuse_iomap_backing_set_blocksize(...)	(-EOPNOTSUPP)
+# define fuse_iomap_backing_stripe_config(...)	(-EOPNOTSUPP)
 # define fuse_iomap_upsert_mappings(...)	(-ENOSYS)
 # define fuse_iomap_inval_mappings(...)		(-ENOSYS)
+# define fuse_iomap_conn_free(...)		((void)0)
 #endif /* CONFIG_FUSE_IOMAP */
 
 #endif /* _FS_FUSE_IOMAP_H */
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index 4a0b1900c85f6b..c36bd62bc450fd 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -291,14 +291,14 @@ DECLARE_EVENT_CLASS(fuse_backing_class,
 	),
 
 	TP_fast_assign(
-		struct inode *inode = file_inode(fb->file);
+		struct inode *inode = fb->file ? file_inode(fb->file) : NULL;
 
 		__entry->connection	=	fc->dev;
 		__entry->id		=	fb->id;
-		__entry->ino		=	inode->i_ino;
+		__entry->ino		=	inode ? inode->i_ino : 0;
 		__entry->type		=	fb->ops->type;
 		if (fb->ops->type == FUSE_BACKING_TYPE_IOMAP)
-			__entry->rdev	=	inode->i_rdev;
+			__entry->rdev	=	inode ? inode->i_rdev : 0;
 		else
 			__entry->rdev	=	0;
 	),
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index b47c48c0d73ee1..e0332de8383ac5 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1229,6 +1229,9 @@ struct fuse_iomap_backing_info {
 #define FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE \
 					_IOW(FUSE_DEV_IOC_MAGIC, 102, \
 					     struct fuse_iomap_backing_info)
+#define FUSE_DEV_IOC_IOMAP_BACKING_STRIPE_CONFIG \
+					_IOW(FUSE_DEV_IOC_MAGIC, 103, \
+					     struct fuse_iomap_backing_stripe)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
@@ -1631,4 +1634,20 @@ struct fuse_iomap_upsert_mappings_out {
 	struct fuse_iomap_io	write;
 };
 
+struct fuse_iomap_backing_strip {
+	uint32_t dev;		/* device cookie */
+	uint32_t reserved;	/* zero */
+	uint64_t addr;		/* disk offset of strip, bytes */
+};
+
+#define FUSE_IOMAP_BACKING_MAX_STRIPS	(256)
+
+struct fuse_iomap_backing_stripe {
+	uint16_t nr_strips;	/* strip count */
+	uint8_t reserved[6];	/* zero */
+	uint64_t strip_width;	/* stripe width, bytes */
+
+	struct fuse_iomap_backing_strip strips[] __counted_by(nr_strips);
+};
+
 #endif /* _LINUX_FUSE_H */
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 304ce8724cfba2..815b797b8f52f5 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -22,7 +22,9 @@ static void fuse_backing_free(struct fuse_backing *fb)
 {
 	pr_debug("%s: fb=0x%p\n", __func__, fb);
 
-	if (fb->file)
+	if (fb->ops->free_data && fb->data)
+		fb->ops->free_data(fb->data);
+	else if (fb->file)
 		fput(fb->file);
 	put_cred(fb->cred);
 	kfree_rcu(fb, rcu);
@@ -114,6 +116,8 @@ fuse_backing_ops_from_map(const struct fuse_backing_map *map)
 #ifdef CONFIG_FUSE_IOMAP
 	case FUSE_BACKING_TYPE_IOMAP:
 		return &fuse_iomap_backing_ops;
+	case FUSE_BACKING_TYPE_IOMAP_STRIPE:
+		return &fuse_iomap_stripe_backing_ops;
 #endif
 	default:
 		break;
@@ -190,6 +194,47 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	goto out;
 }
 
+int fuse_backing_create(struct fuse_conn *fc,
+			const struct fuse_backing_ops *ops, void *data)
+{
+	struct fuse_backing *fb = NULL;
+	int res;
+
+	pr_debug("%s: data=%p\n", __func__, data);
+
+	res = ops->may_admin ? ops->may_admin(fc, 0) : 0;
+	if (res)
+		goto out;
+
+	fb = kzalloc_obj(struct fuse_backing);
+	res = -ENOMEM;
+	if (!fb)
+		goto out;
+
+	fb->data = data;
+	fb->cred = prepare_creds();
+	fb->ops = ops;
+	refcount_set(&fb->count, 1);
+
+	res = ops->post_open ? ops->post_open(fc, fb) : 0;
+	if (res)
+		goto bad;
+
+	res = fuse_backing_id_alloc(fc, fb);
+	if (res < 0)
+		goto bad;
+
+	goto out;
+bad:
+	fb->data = NULL;
+	fuse_backing_free(fb);
+	fb = NULL;
+
+out:
+	pr_debug("%s: fb=0x%p, ret=%i\n", __func__, fb, res);
+	return res;
+}
+
 static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc,
 						  int backing_id)
 {
@@ -299,3 +344,40 @@ int fuse_backing_lookup_id(struct fuse_conn *fc,
 
 	return ret;
 }
+
+struct fuse_backing_iter {
+	fuse_backing_iter_fn iter_fn;
+	const struct fuse_backing_ops *ops;
+	void *data;
+};
+
+static int fuse_backing_iter(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+	struct fuse_backing_iter *fbi = data;
+
+	if (!fb)
+		return 0;
+	if (fbi->ops && fb->ops != fbi->ops)
+		return 0;
+
+	return fbi->iter_fn(fb, fbi->data);
+}
+
+int fuse_backing_foreach(struct fuse_conn *fc,
+			 const struct fuse_backing_ops *ops,
+			 fuse_backing_iter_fn iter_fn, void *data)
+{
+	struct fuse_backing_iter fbi = {
+		.ops = ops,
+		.iter_fn = iter_fn,
+		.data = data,
+	};
+	int ret;
+
+	rcu_read_lock();
+	ret = idr_for_each(&fc->backing_files_map, fuse_backing_iter, &fbi);
+	rcu_read_unlock();
+
+	return ret;
+}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index db361788d7ee37..010fe4041c4da8 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2794,6 +2794,8 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 		return fuse_dev_ioctl_add_iomap(file);
 	case FUSE_DEV_IOC_IOMAP_BACKING_SET_BLOCKSIZE:
 		return fuse_iomap_backing_set_blocksize(file, argp);
+	case FUSE_DEV_IOC_IOMAP_BACKING_STRIPE_CONFIG:
+		return fuse_iomap_backing_stripe_config(file, argp);
 
 	default:
 		return -ENOTTY;
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 1fef26adf650d4..870822d24c0ca8 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -1300,6 +1300,26 @@ const struct fuse_backing_ops fuse_iomap_backing_ops = {
 	.post_open = fuse_iomap_post_open,
 };
 
+static void fuse_iomap_backing_stripe_free_data(const void *fbdata)
+{
+	const struct fuse_backing_stripe *bstripe = fbdata;
+	const struct fuse_backing_strip *bstrip = &bstripe->strips[0];
+	unsigned int i;
+
+	for (i = 0; i < bstripe->nr_strips; i++, bstrip++)
+		fuse_backing_put(bstrip->fb);
+
+	kfree(fbdata);
+}
+
+const struct fuse_backing_ops fuse_iomap_stripe_backing_ops = {
+	.type = FUSE_BACKING_TYPE_IOMAP_STRIPE,
+	.id_start = 2048,
+	.id_end = 3073,		/* maximum 1024 stripe devices */
+	.may_close = fuse_iomap_may_close,
+	.free_data = fuse_iomap_backing_stripe_free_data,
+};
+
 struct fuse_iomap_config_args {
 	struct fuse_args args;
 	struct fuse_iomap_config_in inarg;
@@ -3218,3 +3238,101 @@ int fuse_iomap_inval_mappings(struct fuse_conn *fc,
 	up_read(&fc->killsb);
 	return ret;
 }
+
+static void fuse_iomap_put_stripe_devs(struct fuse_backing_stripe *bstripe)
+{
+	struct fuse_backing_strip *bstrip = &bstripe->strips[0];
+	unsigned int i;
+
+	for (i = 0; i < bstripe->nr_strips; i++, bstrip++) {
+		fuse_backing_put(bstrip->fb);
+		bstrip->fb = NULL;
+	}
+}
+
+int fuse_iomap_backing_stripe_config(struct file *file,
+				     struct fuse_iomap_backing_stripe __user *argp)
+{
+	struct fuse_iomap_backing_stripe stripe;
+	struct fuse_backing_stripe *bstripe;
+	struct fuse_backing_strip *bstrip;
+	struct fuse_dev *fud = fuse_get_dev(file);
+	unsigned int i;
+	int ret;
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!IS_ENABLED(CONFIG_FUSE_BACKING))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&stripe, argp, sizeof(stripe)))
+		return -EFAULT;
+
+	if (memchr_inv(&stripe.reserved, 0, sizeof(stripe.reserved)))
+		return -EINVAL;
+
+	if (stripe.nr_strips == 0 || stripe.strip_width == 0)
+		return -EINVAL;
+
+	if (stripe.nr_strips > FUSE_IOMAP_BACKING_MAX_STRIPS)
+		return -ENOMEM;
+
+	bstripe = kzalloc_flex(*bstripe, strips, stripe.nr_strips);
+	if (!bstripe)
+		return -ENOMEM;
+
+	bstripe->nr_strips = stripe.nr_strips;
+	bstripe->strip_width = stripe.strip_width;
+
+	bstrip = &bstripe->strips[0];
+	for (i = 0; i < stripe.nr_strips; i++, bstrip++) {
+		struct fuse_iomap_backing_strip strip;
+
+		if (copy_from_user(&strip, &argp->strips[i], sizeof(strip))) {
+			ret = -EFAULT;
+			goto out_strips;
+		}
+
+		if (strip.reserved) {
+			ret = -EINVAL;
+			goto out_strips;
+		}
+
+		bstrip->fb = fuse_backing_lookup(fud->fc,
+						 &fuse_iomap_backing_ops,
+						 strip.dev);
+		if (!bstrip->fb) {
+			ret = -ENODEV;
+			goto out_strips;
+		}
+
+		bstrip->dev = strip.dev;
+		bstrip->addr = strip.addr;
+	}
+
+	ret = fuse_backing_create(fud->fc, &fuse_iomap_stripe_backing_ops,
+				  bstripe);
+	if (ret < 0)
+		goto out_strips;
+
+	return ret;
+
+out_strips:
+	fuse_iomap_put_stripe_devs(bstripe);
+	kfree(bstripe);
+	return ret;
+}
+
+static int fuse_iomap_free_backing_stripe(struct fuse_backing *fb, void *data)
+{
+	fuse_iomap_put_stripe_devs(fb->data);
+	return 0;
+}
+
+void fuse_iomap_conn_free(struct fuse_conn *fc)
+{
+	/* release the lower layer backing devices before we free the data */
+	fuse_backing_foreach(fc, &fuse_iomap_stripe_backing_ops,
+			     fuse_iomap_free_backing_stripe, NULL);
+}
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 365501b228ed11..17d35acd03b612 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1135,6 +1135,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 		WARN_ON(atomic_read(&bucket->count) != 1);
 		kfree(bucket);
 	}
+	fuse_iomap_conn_free(fc);
 	if (IS_ENABLED(CONFIG_FUSE_BACKING))
 		fuse_backing_files_free(fc);
 	call_rcu(&fc->rcu, delayed_release);

