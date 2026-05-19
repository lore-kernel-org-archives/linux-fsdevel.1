Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E3A2609FD;
	Tue, 19 May 2026 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779229655; cv=none; b=KQFNt6SAou3e6ysRAw+K7rciii7QhA4f+baHZwZiRwwXsMdUjyWv68tNBwD3sa+iU7+7GYSA2S5hU3W2I0lpArPneE7Z9KsIwmwptQPoilt7KysfT27n3el2J+oG4Os46G+mctpdnA0EjZHnnbkcYQ8C3vdaiWEKj73Rlyz0HpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779229655; c=relaxed/simple;
	bh=Ym/vSZZrCSh6AcQczSqBlSJXGbeLXOwNo6cdkKNYNG4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zx0prTJ5CIOYaMHslHNf1BaIPs+N2+1ExMJpJuFHiY+sfTSP6+YjrLJsECNVjmh1Asn5mnH9TsqoY+jSNJOlDDZOkfqIAS5e4ih4U0MznypBWJCitN2zFvZHM312K9P+D/jR/0eq9LwfW+xUUzFoWJhniS08Sp8sgiCGaDiN6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJFZl58u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJFZl58u"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2DCCC1F00893;
	Tue, 19 May 2026 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779229654;
	bh=HpzUP6TyUzT3wb2Xa7DhhTzSuYW7vx3p+XvPZd0ciO0=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=fJFZl58ufYQuVej3DEAh/XUR2l2BQKqcVOgIzhwOfzSOrUm9WDjM1HuklCXrtT+zX
	 Bb4oHyQh8rSN8TVvK8M+yEASwt5Mahg3YVdQ5cSdA7ZkEskrYWIdvgh4IekihPWFFX
	 ktxpIx6sTd53X8to4usbVMehyaMmEtFQNX/l9UwAgVo2IoOIuprN6znuvXBGo0qgRg
	 gPnVzm1V93DzK6jgMLpBiXslHGsGJ3VY44lHjtScDBxeWKcNKNUU/GHAUZiTCuI5fc
	 4eiKeZ/xgHucV7TdyIC9kEPUdF7t53w0FQ849bwaWfAtY13pNiEECajJmdH56xvVdu
	 kQ8Ng7yTflYJQ==
Date: Tue, 19 May 2026 15:27:33 -0700
Subject: [PATCH 04/11] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add
 new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, neal@gompa.dev, bernd@bsbernd.com,
 joannelkoong@gmail.com, fuse-devel@lists.linux.dev
Message-ID: <177922945327.2436837.2738315299316875094.stgit@frogsfrogsfrogs>
In-Reply-To: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
References: <177922945175.2436837.10366841596277424226.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable the use of the backing file open/close ioctls so that fuse
servers can register block devices for use with iomap.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_i.h          |    7 ++
 fs/fuse/fuse_iomap.h      |    2 +
 include/uapi/linux/fuse.h |    3 +
 fs/fuse/Kconfig           |    1 
 fs/fuse/backing.c         |   52 ++++++++++++++
 fs/fuse/fuse_iomap.c      |  165 +++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/trace.c           |    2 +
 7 files changed, 216 insertions(+), 16 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 82603e8969a9db..969d546ecbaaec 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -111,6 +111,7 @@ struct fuse_backing_ops {
 	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
 	int (*may_open)(struct fuse_conn *fc, struct file *file);
 	int (*may_close)(struct fuse_conn *fc, const struct fuse_backing *fb);
+	int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
 	unsigned int type;
 	int id_start;
 	int id_end;
@@ -120,6 +121,7 @@ struct fuse_backing_ops {
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	struct block_device *bdev;
 	const struct fuse_backing_ops *ops;
 
 	int id;
@@ -1616,6 +1618,11 @@ void fuse_backing_put(struct fuse_backing *fb);
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 					 const struct fuse_backing_ops *ops,
 					 int backing_id);
+typedef bool (*fuse_match_backing_fn)(const struct fuse_backing *fb,
+				      const void *data);
+int fuse_backing_lookup_id(struct fuse_conn *fc,
+			   const struct fuse_backing_ops *ops,
+			   fuse_match_backing_fn match_fn, const void *data);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 6c71318365ca82..43562ef23fb325 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -18,6 +18,8 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 {
 	return get_fuse_conn(inode)->iomap;
 }
+
+extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 #else
 # define fuse_iomap_enabled(...)		(false)
 # define fuse_has_iomap(...)			(false)
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index 093b4ba6a602ac..6ce5de5b74f256 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -1137,7 +1137,8 @@ struct fuse_notify_prune_out {
 
 #define FUSE_BACKING_TYPE_MASK		(0xFF)
 #define FUSE_BACKING_TYPE_PASSTHROUGH	(0)
-#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_PASSTHROUGH)
+#define FUSE_BACKING_TYPE_IOMAP		(1)
+#define FUSE_BACKING_MAX_TYPE		(FUSE_BACKING_TYPE_IOMAP)
 
 #define FUSE_BACKING_FLAGS_ALL		(FUSE_BACKING_TYPE_MASK)
 
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 1b8990f1c2a8f9..3e35611c3aac07 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -75,6 +75,7 @@ config FUSE_IOMAP
 	depends on FUSE_FS
 	depends on BLOCK
 	select FS_IOMAP
+	select FUSE_BACKING
 	help
 	  Enable fuse servers to operate the regular file I/O path through
 	  the fs-iomap library in the kernel.  This enables higher performance
diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index 8bfc85a45642c0..304ce8724cfba2 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 #include "fuse_trace.h"
 
 #include <linux/file.h>
@@ -109,6 +110,10 @@ fuse_backing_ops_from_map(const struct fuse_backing_map *map)
 #ifdef CONFIG_FUSE_PASSTHROUGH
 	case FUSE_BACKING_TYPE_PASSTHROUGH:
 		return &fuse_passthrough_backing_ops;
+#endif
+#ifdef CONFIG_FUSE_IOMAP
+	case FUSE_BACKING_TYPE_IOMAP:
+		return &fuse_iomap_backing_ops;
 #endif
 	default:
 		break;
@@ -149,7 +154,7 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (res)
 		goto out_fput;
 
-	fb = kmalloc_obj(struct fuse_backing);
+	fb = kzalloc_obj(struct fuse_backing);
 	res = -ENOMEM;
 	if (!fb)
 		goto out_fput;
@@ -160,6 +165,13 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	fb->id = -1;
 	refcount_set(&fb->count, 1);
 
+	res = ops->post_open ? ops->post_open(fc, fb) : 0;
+	if (res) {
+		fuse_backing_free(fb);
+		fb = NULL;
+		goto out;
+	}
+
 	res = fuse_backing_id_alloc(fc, fb);
 	if (res < 0) {
 		fuse_backing_free(fb);
@@ -249,3 +261,41 @@ struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 
 	return fb;
 }
+
+struct fuse_backing_match {
+	fuse_match_backing_fn match_fn;
+	const struct fuse_backing_ops *ops;
+	const void *data;
+};
+
+static int fuse_backing_matches(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+	struct fuse_backing_match *fbm = data;
+
+	if (!fb)
+		return 0;
+	if (fbm->ops && fb->ops != fbm->ops)
+		return 0;
+
+	/* backing ids are always greater than zero */
+	return fbm->match_fn(fb, fbm->data) ? id : 0;
+}
+
+int fuse_backing_lookup_id(struct fuse_conn *fc,
+			   const struct fuse_backing_ops *ops,
+			   fuse_match_backing_fn match_fn, const void *data)
+{
+	struct fuse_backing_match fbm = {
+		.ops = ops,
+		.match_fn = match_fn,
+		.data = data,
+	};
+	int ret;
+
+	rcu_read_lock();
+	ret = idr_for_each(&fc->backing_files_map, fuse_backing_matches, &fbm);
+	rcu_read_unlock();
+
+	return ret;
+}
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 24a5a7bbf5ca24..ea11a47e773b6c 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -297,10 +297,6 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		return false;
 	}
 
-	/* XXX: we don't support devices yet */
-	if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
-		return false;
-
 	/* No overflows in the device range, if supplied */
 	if (map->addr != FUSE_IOMAP_NULL_ADDR &&
 	    BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
@@ -311,6 +307,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 
 /* Convert a mapping from the server into something the kernel can use */
 static inline void fuse_iomap_from_server(struct iomap *iomap,
+					  const struct fuse_backing *fb,
 					  const struct fuse_iomap_io *fmap)
 {
 	iomap->addr = fmap->addr;
@@ -318,11 +315,34 @@ static inline void fuse_iomap_from_server(struct iomap *iomap,
 	iomap->length = fmap->length;
 	iomap->type = fuse_iomap_type_from_server(fmap->type);
 	iomap->flags = fuse_iomap_flags_from_server(fmap->flags);
-	iomap->bdev = NULL; /* XXX */
+	iomap->bdev = fb ? fb->bdev : NULL;
+	iomap->dax_dev = NULL;
+}
+
+static bool fuse_iomap_matches_bdev(const struct fuse_backing *fb,
+				    const void *data)
+{
+	return fb->bdev == data;
+}
+
+static inline uint32_t
+fuse_iomap_find_backing_id(struct fuse_conn *fc,
+			   const struct block_device *bdev)
+{
+	int ret;
+
+	if (!bdev)
+		return FUSE_IOMAP_DEV_NULL;
+	ret = fuse_backing_lookup_id(fc, &fuse_iomap_backing_ops,
+				     fuse_iomap_matches_bdev, bdev);
+	if (ret <= 0)
+		return FUSE_IOMAP_DEV_NULL;
+	return ret;
 }
 
 /* Convert a mapping from the kernel into something the server can use */
-static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
+static inline void fuse_iomap_to_server(struct fuse_conn *fc,
+					struct fuse_iomap_io *fmap,
 					const struct iomap *iomap)
 {
 	fmap->addr = iomap->addr;
@@ -330,7 +350,12 @@ static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
 	fmap->length = iomap->length;
 	fmap->type = fuse_iomap_type_to_server(iomap->type);
 	fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
-	fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
+
+	/*
+	 * Best effort, may be the wrong backing id if bdev is registered
+	 * multiple times.
+	 */
+	fmap->dev = fuse_iomap_find_backing_id(fc, iomap->bdev);
 }
 
 /* Check the incoming _begin mappings to make sure they're not nonsense. */
@@ -364,6 +389,37 @@ fuse_iomap_begin_validate(const struct inode *inode,
 	return 0;
 }
 
+static inline struct fuse_backing *
+fuse_iomap_find_bdev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
+{
+	struct fuse_backing *ret = NULL;
+
+	if (map->dev != FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
+		ret = fuse_backing_lookup(fc, &fuse_iomap_backing_ops,
+					  map->dev);
+
+	switch (map->type) {
+	case FUSE_IOMAP_TYPE_MAPPED:
+	case FUSE_IOMAP_TYPE_UNWRITTEN:
+		/* Mappings backed by space must have a device/addr */
+		if (BAD_DATA(ret == NULL))
+			return ERR_PTR(-EFSCORRUPTED);
+		break;
+	}
+
+	return ret;
+}
+
+static inline int
+fuse_iomap_validate_bdev_access(const struct fuse_backing *fb,
+				enum fuse_iomap_iodir dir)
+{
+	const fmode_t fmode =
+		dir == WRITE_MAPPING ? FMODE_WRITE | FMODE_READ : FMODE_READ;
+
+	return (!fb || (fb->file->f_mode & fmode) == fmode) ? 0 : -EACCES;
+}
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -377,6 +433,9 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *read_dev = NULL;
+	struct fuse_backing *write_dev = NULL;
+	const bool is_write = fuse_is_iomap_file_write(opflags);
 	FUSE_ARGS(args);
 	int err;
 
@@ -407,24 +466,57 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
-	if (fuse_is_iomap_file_write(opflags) &&
-	    outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+	read_dev = fuse_iomap_find_bdev(fm->fc, &outarg.read);
+	if (IS_ERR(read_dev))
+		return PTR_ERR(read_dev);
+
+	if (is_write && outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		/* open the write device */
+		write_dev = fuse_iomap_find_bdev(fm->fc, &outarg.write);
+		if (IS_ERR(write_dev)) {
+			err = PTR_ERR(write_dev);
+			goto out_read_dev;
+		}
+
+		err = fuse_iomap_validate_bdev_access(read_dev, READ_MAPPING);
+		if (err)
+			goto out_write_dev;
+
+		err = fuse_iomap_validate_bdev_access(write_dev, WRITE_MAPPING);
+		if (err)
+			goto out_write_dev;
+
 		/*
 		 * For an out of place write, we must supply the write mapping
 		 * via @iomap, and the read mapping via @srcmap.
 		 */
-		fuse_iomap_from_server(iomap, &outarg.write);
-		fuse_iomap_from_server(srcmap, &outarg.read);
+		fuse_iomap_from_server(iomap, write_dev, &outarg.write);
+		fuse_iomap_from_server(srcmap, read_dev, &outarg.read);
 	} else {
+		err = fuse_iomap_validate_bdev_access(read_dev,
+				is_write ? WRITE_MAPPING : READ_MAPPING);
+		if (err)
+			goto out_read_dev;
+
 		/*
 		 * For everything else (reads, reporting, and pure overwrites),
 		 * we can return the sole mapping through @iomap and leave
 		 * @srcmap unchanged from its default (HOLE).
 		 */
-		fuse_iomap_from_server(iomap, &outarg.read);
+		fuse_iomap_from_server(iomap, read_dev, &outarg.read);
 	}
 
-	return 0;
+	/*
+	 * XXX: if we ever want to support closing devices, we need a way to
+	 * track the fuse_backing refcount all the way through bio endios.
+	 * For now we put the refcount here because you can't remove an iomap
+	 * device until unmount time.
+	 */
+out_write_dev:
+	fuse_backing_put(write_dev);
+out_read_dev:
+	fuse_backing_put(read_dev);
+	return err;
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
@@ -466,7 +558,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 		};
 		FUSE_ARGS(args);
 
-		fuse_iomap_to_server(&inarg.map, iomap);
+		fuse_iomap_to_server(fm->fc, &inarg.map, iomap);
 
 		trace_fuse_iomap_end(inode, &inarg);
 
@@ -496,3 +588,48 @@ const struct iomap_ops fuse_iomap_ops = {
 	.iomap_begin		= fuse_iomap_begin,
 	.iomap_end		= fuse_iomap_end,
 };
+
+static int fuse_iomap_may_admin(struct fuse_conn *fc, unsigned int flags)
+{
+	if (!fc->iomap)
+		return -EPERM;
+
+	if (flags)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int fuse_iomap_may_open(struct fuse_conn *fc, struct file *file)
+{
+	if (file->f_mode & FMODE_PATH)
+		return -EBADF;
+
+	if (!S_ISBLK(file_inode(file)->i_mode))
+		return -ENODEV;
+
+	return 0;
+}
+
+static int fuse_iomap_post_open(struct fuse_conn *fc, struct fuse_backing *fb)
+{
+	fb->bdev = I_BDEV(fb->file->f_mapping->host);
+	return 0;
+}
+
+static int fuse_iomap_may_close(struct fuse_conn *fc,
+				const struct fuse_backing *fb)
+{
+	/* We only support closing iomap block devices at unmount */
+	return -EBUSY;
+}
+
+const struct fuse_backing_ops fuse_iomap_backing_ops = {
+	.type = FUSE_BACKING_TYPE_IOMAP,
+	.id_start = 1,
+	.id_end = 1025,		/* maximum 1024 block devices */
+	.may_admin = fuse_iomap_may_admin,
+	.may_open = fuse_iomap_may_open,
+	.may_close = fuse_iomap_may_close,
+	.post_open = fuse_iomap_post_open,
+};
diff --git a/fs/fuse/trace.c b/fs/fuse/trace.c
index 93bd72efc98cd0..65badac814b591 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -9,5 +9,7 @@
 
 #include <linux/pagemap.h>
 
+#include "fuse_iomap_i.h"
+
 #define CREATE_TRACE_POINTS
 #include "fuse_trace.h"

