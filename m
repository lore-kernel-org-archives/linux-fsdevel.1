Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914201922F5;
	Wed, 29 Apr 2026 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472684; cv=none; b=Vqi7S3ULjeegsC6MgmFi/Q6P61UI75Cz84pcyX69e+HA8UNzwaMdWQnz4RpUxC3r342xRad+ek9vmmX7Sw52PUQWcPpnqnBg5mJwcvl42CgMDxGGTV6UUF0iWZZxdy4d5tYo3+zecHuwKLQQo/h1gpJ4CAbAmJXdH7+KLqpjzzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472684; c=relaxed/simple;
	bh=q3GjZyH4LOEH93OK2XJE++AFnkzWULbFaPzBEA74hqo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agZ9PPQMZMH1svUPAp1NUMnlfT2Y2WGhSk3Hq2KOEnLTWbign/2k9kfI0R+ZonWFTmsHrm+cH5sngzFQCalffg0JISuPGc+KtixwID0Q6FX7g0UX9dTaXYyUU9K5Q1HMyp1Z/7A0JdR+kDh5LJqoxFteA377tEvVCZa3OhhrVoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qgWI3jSe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qgWI3jSe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69993C19425;
	Wed, 29 Apr 2026 14:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472684;
	bh=q3GjZyH4LOEH93OK2XJE++AFnkzWULbFaPzBEA74hqo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=qgWI3jSeAq6ewCeXHKYD9buQ7MkAhDdkU4rmHFTBKOgzrJhT937+osxbX/y+tirNG
	 3sQxPt2pFaWF/tyuf2MXdX7ITli7YvwGDGlKG/taHQfI/HXuO705QammBv4a/Hi3c+
	 zQ5yrlzRyMyARPb6vIMOS0iBftAnO/thh3jrua7nwksF9ojWIQDzGArg5fyDei5rIf
	 DPkeaO1+0g9x6+Q9XBsFcMjIWDQcpP19qCNZ2bIegPlbgcaYq39MxRsylxwN6KhvqJ
	 tGOsT236Mv/uCK6ObAYC+dOj9ZsQPmdnWIDRNyiNN+GjsOVHo9015riqbbAcHFW8k/
	 XkGeIcjnC4flg==
Date: Wed, 29 Apr 2026 07:24:44 -0700
Subject: [PATCH 04/33] fuse: adapt FUSE_DEV_IOC_BACKING_{OPEN,CLOSE} to add
 new iomap devices
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747205235.4101881.774662317945073683.stgit@frogsfrogsfrogs>
In-Reply-To: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
References: <177747204948.4101881.16044986246405634629.stgit@frogsfrogsfrogs>
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
 fs/fuse/fuse_i.h          |    7 +++
 fs/fuse/fuse_iomap.h      |    2 +
 include/uapi/linux/fuse.h |    3 +
 fs/fuse/Kconfig           |    1 
 fs/fuse/backing.c         |   47 +++++++++++++++++
 fs/fuse/fuse_iomap.c      |  126 +++++++++++++++++++++++++++++++++++++++++----
 fs/fuse/trace.c           |    1 
 7 files changed, 174 insertions(+), 13 deletions(-)


diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7accde465d03a7..a02af3403e6849 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -104,12 +104,14 @@ struct fuse_submount_lookup {
 };
 
 struct fuse_conn;
+struct fuse_backing;
 
 /** Operations for subsystems that want to use a backing file */
 struct fuse_backing_ops {
 	int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
 	int (*may_open)(struct fuse_conn *fc, struct file *file);
 	int (*may_close)(struct fuse_conn *fc, struct file *file);
+	int (*post_open)(struct fuse_conn *fc, struct fuse_backing *fb);
 	unsigned int type;
 	int id_start;
 	int id_end;
@@ -119,6 +121,7 @@ struct fuse_backing_ops {
 struct fuse_backing {
 	struct file *file;
 	struct cred *cred;
+	struct block_device *bdev;
 	const struct fuse_backing_ops *ops;
 
 	/** refcount */
@@ -1613,6 +1616,10 @@ void fuse_backing_put(struct fuse_backing *fb);
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 					 const struct fuse_backing_ops *ops,
 					 int backing_id);
+typedef bool (*fuse_match_backing_fn)(const struct fuse_backing *fb,
+				      const void *data);
+int fuse_backing_lookup_id(struct fuse_conn *fc, fuse_match_backing_fn match_fn,
+			   const void *data);
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
index 5a58011f66f501..5ae6b05de623d7 100644
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
index d7e074c30f46cc..050657a6ef1c98 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -6,6 +6,7 @@
  */
 
 #include "fuse_i.h"
+#include "fuse_iomap.h"
 #include "fuse_trace.h"
 
 #include <linux/file.h>
@@ -90,6 +91,10 @@ fuse_backing_ops_from_map(const struct fuse_backing_map *map)
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
@@ -138,8 +143,16 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	fb->file = file;
 	fb->cred = prepare_creds();
 	fb->ops = ops;
+	fb->bdev = NULL;
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
@@ -230,3 +243,37 @@ struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 
 	return fb;
 }
+
+struct fuse_backing_match {
+	fuse_match_backing_fn match_fn;
+	const void *data;
+};
+
+static int fuse_backing_matches(int id, void *p, void *data)
+{
+	struct fuse_backing *fb = p;
+	struct fuse_backing_match *fbm = data;
+
+	if (fb && fbm->match_fn(fb, fbm->data)) {
+		/* backing ids are always greater than zero */
+		return id;
+	}
+
+	return 0;
+}
+
+int fuse_backing_lookup_id(struct fuse_conn *fc, fuse_match_backing_fn match_fn,
+			   const void *data)
+{
+	struct fuse_backing_match fbm = {
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
index f7a7eba8317c18..0ac783dd312dc3 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -282,10 +282,6 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		return false;
 	}
 
-	/* XXX: we don't support devices yet */
-	if (BAD_DATA(map->dev != FUSE_IOMAP_DEV_NULL))
-		return false;
-
 	/* No overflows in the device range, if supplied */
 	if (map->addr != FUSE_IOMAP_NULL_ADDR &&
 	    BAD_DATA(check_add_overflow(map->addr, map->length, &end)))
@@ -296,6 +292,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 
 /* Convert a mapping from the server into something the kernel can use */
 static inline void fuse_iomap_from_server(struct iomap *iomap,
+					  const struct fuse_backing *fb,
 					  const struct fuse_iomap_io *fmap)
 {
 	iomap->addr = fmap->addr;
@@ -303,11 +300,32 @@ static inline void fuse_iomap_from_server(struct iomap *iomap,
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
+	int ret = -ENODEV;
+
+	if (bdev)
+		ret = fuse_backing_lookup_id(fc, fuse_iomap_matches_bdev, bdev);
+	if (ret < 0)
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
@@ -315,7 +333,7 @@ static inline void fuse_iomap_to_server(struct fuse_iomap_io *fmap,
 	fmap->length = iomap->length;
 	fmap->type = fuse_iomap_type_to_server(iomap->type);
 	fmap->flags = fuse_iomap_flags_to_server(iomap->flags);
-	fmap->dev = FUSE_IOMAP_DEV_NULL; /* XXX */
+	fmap->dev = fuse_iomap_find_backing_id(fc, iomap->bdev);
 }
 
 /* Check the incoming _begin mappings to make sure they're not nonsense. */
@@ -354,6 +372,27 @@ static inline bool fuse_is_iomap_file_write(unsigned int opflags)
 	return opflags & (IOMAP_WRITE | IOMAP_ZERO | IOMAP_UNSHARE);
 }
 
+static inline struct fuse_backing *
+fuse_iomap_find_dev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
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
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -367,6 +406,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	};
 	struct fuse_iomap_begin_out outarg = { };
 	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *read_dev = NULL;
+	struct fuse_backing *write_dev = NULL;
 	FUSE_ARGS(args);
 	int err;
 
@@ -393,24 +434,44 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	read_dev = fuse_iomap_find_dev(fm->fc, &outarg.read);
+	if (IS_ERR(read_dev))
+		return PTR_ERR(read_dev);
+
 	if (fuse_is_iomap_file_write(opflags) &&
 	    outarg.write.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+		/* open the write device */
+		write_dev = fuse_iomap_find_dev(fm->fc, &outarg.write);
+		if (IS_ERR(write_dev)) {
+			err = PTR_ERR(write_dev);
+			goto out_read_dev;
+		}
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
+	fuse_backing_put(write_dev);
+out_read_dev:
+	fuse_backing_put(read_dev);
+	return err;
 }
 
 /* Decide if we send FUSE_IOMAP_END to the fuse server */
@@ -452,7 +513,7 @@ static int fuse_iomap_end(struct inode *inode, loff_t pos, loff_t count,
 		};
 		FUSE_ARGS(args);
 
-		fuse_iomap_to_server(&inarg.map, iomap);
+		fuse_iomap_to_server(fm->fc, &inarg.map, iomap);
 
 		trace_fuse_iomap_end(inode, &inarg);
 
@@ -482,3 +543,44 @@ const struct iomap_ops fuse_iomap_ops = {
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
+static int fuse_iomap_may_close(struct fuse_conn *fc, struct file *file)
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
index 93bd72efc98cd0..c830c1c38a833c 100644
--- a/fs/fuse/trace.c
+++ b/fs/fuse/trace.c
@@ -6,6 +6,7 @@
 #include "dev_uring_i.h"
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "fuse_iomap_i.h"
 
 #include <linux/pagemap.h>
 

