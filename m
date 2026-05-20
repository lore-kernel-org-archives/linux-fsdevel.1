Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD835957;
	Wed, 20 May 2026 06:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779257769; cv=none; b=HTU7Kcm9DhBOCuM58MjMsSrstYrc1kUCmQec8lhS9OqrLbfQDEW19bo8nkSb5XoSafaveZZXhNwJNkqaKGcqGHyho2ANy7S193Jd4FJCc096DbkxzhCBs89E+qrqKoq68G9Zznp6GEZGK4f77FJO/MAU5U+UcTqSMN8KUEGcpPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779257769; c=relaxed/simple;
	bh=NKDa2TCq5DVDr7Kt9keChv+UACTei6yqtwz2XEAwUXw=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1PsfUELxViX4NTeS315D6Wd3kPGTD12jkz+D3eH5+ljyDQTGb04V/NhHTsR+VKLuCa3v/OTWM9df3vonmRCH4ZF+a2qr2dDvshnLLLhJS7b0JSNO9SJCLs5etrFPmmTxoVSuOnCDygTLwRJw2UXKLx/Z+GiMDpiMvaWpkUVoFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBLGjYpj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBLGjYpj"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5E0D21F000E9;
	Wed, 20 May 2026 06:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779257767;
	bh=o+yvDL0dRt2Fp2Utr5ZMsM1T3CWjNYPBENFrHLAsAzc=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References;
	b=UBLGjYpje866pyJBbWlTnDIQyMPADQ8tiIzzFN5Om3swGTm+4NsN2a3uI9XSHXonU
	 +JbDS4sorVfAGxK0TuYSGdLLTM6RrmmmbtVV2ODPrZ/b6RYuXd4v1i5yALUKL2xCOh
	 MySqosuIGoTix5dKd1mbELVnSbot2kitPn6J3wL0NYMIWqbfgv3YqgqqssgLLQxzS7
	 3M36Gb3h/aCtfJk+xPcJP5s5muRf71WryS69fWYKH+4prMUoQ1fcksbYQ4LeyecPGh
	 6hr0RPvSmilVIjkOt6ZkdysN+QdQuR+0WVgNNCEeVPgK+5sT0rvcSGixT3AgExWKu6
	 umC4RLbSw7rdg==
Date: Tue, 19 May 2026 23:16:07 -0700
Subject: [PATCH 3/4] fuse: implement striping for iomap
From: "Darrick J. Wong" <djwong@kernel.org>
To: miklos@szeredi.hu, djwong@kernel.org
Cc: fuse-devel@lists.linux.dev, bernd@bsbernd.com, neal@gompa.dev,
 linux-fsdevel@vger.kernel.org, hch@infradead.org, joannelkoong@gmail.com,
 john@groves.net
Message-ID: <177925767748.2711065.11542714263207154277.stgit@frogsfrogsfrogs>
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

Implement the iomap code to handle the new stripe type by grabbing the
virtual backing file and adjusting the mapping to point to a real
device.  Assuming iomap itself doesn't beat us to this.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/fuse/fuse_iomap.h       |    1 
 include/uapi/linux/fuse.h  |    5 +
 fs/fuse/fuse_iomap.c       |  200 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_iomap_cache.c |    8 ++
 4 files changed, 210 insertions(+), 4 deletions(-)


diff --git a/fs/fuse/fuse_iomap.h b/fs/fuse/fuse_iomap.h
index 267bc55fb3368c..faad28219b2793 100644
--- a/fs/fuse/fuse_iomap.h
+++ b/fs/fuse/fuse_iomap.h
@@ -19,6 +19,7 @@ static inline bool fuse_has_iomap(const struct inode *inode)
 	return get_fuse_conn(inode)->iomap;
 }
 
+extern const struct fuse_backing_ops fuse_iomap_stripe_backing_ops;
 extern const struct fuse_backing_ops fuse_iomap_backing_ops;
 extern const struct fuse_backing_ops fuse_iomap_stripe_backing_ops;
 
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e0332de8383ac5..74e4c31664af0c 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -253,6 +253,8 @@
  *    attributes
  *  - add FUSE_NOTIFY_IOMAP_{UPSERT,INVAL}_MAPPINGS so fuse servers can cache
  *    file range mappings in the kernel for iomap
+ *  - add FUSE_IOMAP_TYPE_STRIPE and FUSE_IOC_DEV_IOMAP_BACKING_STRIPE_CONFIG
+ *    so that fuse servers can tell teh kernel about filesystem striping
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1422,6 +1424,9 @@ struct fuse_uring_cmd_req {
 #define FUSE_IOMAP_TYPE_RETRY_CACHE	(65534)
 /* do not upsert this mapping */
 #define FUSE_IOMAP_TYPE_NOCACHE		(65533)
+/* fuse-specific mapping type meaning stripe */
+#define FUSE_IOMAP_TYPE_MAPPED_STRIPE	(65532)
+#define FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE (65531)
 
 #define FUSE_IOMAP_DEV_NULL		(0U)	/* null device cookie */
 
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index 92fa9cd0d8044a..14e411afefaed0 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -137,6 +137,19 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
 	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 	case FUSE_IOMAP_TYPE_NOCACHE:
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
+		return true;
+	}
+
+	return false;
+}
+
+static inline bool fuse_iomap_is_striped(const struct fuse_iomap_io *fmap)
+{
+	switch (fmap->type) {
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 		return true;
 	}
 
@@ -284,6 +297,8 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	switch (map->type) {
 	case FUSE_IOMAP_TYPE_MAPPED:
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 		/* Mappings backed by space must have a device/addr */
 		if (BAD_DATA(map->dev == FUSE_IOMAP_DEV_NULL))
 			return false;
@@ -349,6 +364,130 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	return true;
 }
 
+/* Compute the block device geometry for a stripe */
+static inline int fuse_iomap_adjust_stripe(struct inode *inode,
+					   loff_t pos,
+					   struct fuse_iomap_io *fmap,
+					   struct fuse_backing **fbp)
+{
+	struct fuse_backing *stripe_fb = *fbp;
+	const struct fuse_backing_stripe *bstripe = stripe_fb->data;
+	const struct fuse_backing_strip *bstrip;
+	const unsigned int blocksize = i_blocksize(inode);
+	const loff_t start = round_down(pos, blocksize);
+	uint64_t strip_num;
+	uint64_t strides;
+	uint64_t strip_addr;
+	uint64_t addr_in_strip;
+	uint32_t strip_idx;
+
+	/* Caller should never give us a block device */
+	if (BAD_DATA(stripe_fb->bdev != NULL))
+		return -EFSCORRUPTED;
+
+	/* Strip width must be aligned to fsblock size */
+	if (BAD_DATA(!IS_ALIGNED(bstripe->strip_width, blocksize)))
+		return -EFSCORRUPTED;
+
+	/*
+	 * Maps to stripes are either written or not; they can't be holes,
+	 * reservations, or anything that doesn't have a device range.
+	 */
+	if (BAD_DATA(fmap->type != FUSE_IOMAP_TYPE_MAPPED_STRIPE &&
+	             fmap->type != FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE))
+		return -EFSCORRUPTED;
+	if (BAD_DATA(fmap->addr == FUSE_IOMAP_NULL_ADDR))
+		return -EFSCORRUPTED;
+
+	/* No appending or atomic writes to the device itself */
+	if (BAD_DATA(fmap->flags & (FUSE_IOMAP_F_ANON_WRITE |
+				    FUSE_IOMAP_F_ATOMIC_BIO)))
+		return -EFSCORRUPTED;
+
+	/*
+	 * A striped backing device effectively creates a virtual device with
+	 * its own LBA range, just like any software raid0.  The filesystem
+	 * mapping points to a range within the virtual device.  Our goal is to
+	 * adjust the fmap so that it points to a range on the underlying block
+	 * device.
+	 *
+	 * Adjust the start of the fmap upward to the fsblock containing pos,
+	 * so that the fmap addr tells us where within the backing device we
+	 * want to perform IO.
+	 */
+	if (fmap->offset < start) {
+		loff_t delta = start - fmap->offset;
+
+		if (BAD_DATA(fmap->length <= delta))
+			return -EFSCORRUPTED;
+
+		fmap->length -= delta;
+		fmap->addr += delta;
+		fmap->offset += delta;
+	}
+
+	/*
+	 * Use the fmap addr to compute the strip number within the virtual
+	 * striped device's address range.  The adjustment will set fmap to the
+	 * full strip because iomap can handle mappings that start before and
+	 * end after the requested range.
+	 */
+	strip_num = div64_u64_rem(fmap->addr, bstripe->strip_width,
+				  &addr_in_strip);
+
+	/*
+	 * Use the strip number to compute the number of times that we've gone
+	 * around the strip array (the number of strides), and the strip index
+	 * within a particular stride.
+	 */
+	strides = div_u64_rem(strip_num, bstripe->nr_strips, &strip_idx);
+	bstrip = &bstripe->strips[strip_idx];
+
+	/* Strip must be a real bdev, aligned to the fsblock size */
+	if (BAD_DATA(bstrip->fb == NULL) ||
+	    BAD_DATA(bstrip->fb->bdev == NULL) ||
+	    BAD_DATA(!IS_ALIGNED(bstrip->addr, blocksize)))
+		return -EFSCORRUPTED;
+
+	/*
+	 * Set the fmap to the entire strip that backs pos.
+	 *
+	 * The final disk address is the sum of:
+	 * (a) the disk address of the start of the stripe
+	 * (b) the number of strides we've walked across on just this disk
+	 * (c) the byte address within the strip
+	 *
+	 * The fmap length is shortened to the end of the strip, if necessary.
+	 */
+	fmap->addr = bstrip->addr;
+	if (BAD_DATA(check_mul_overflow(strides, bstripe->strip_width,
+					&strip_addr)) ||
+	    BAD_DATA(check_add_overflow(fmap->addr, strip_addr,
+					&fmap->addr)) ||
+	    BAD_DATA(check_add_overflow(fmap->addr, addr_in_strip,
+					&fmap->addr)))
+		return -EFSCORRUPTED;
+
+	fmap->dev = bstrip->dev;
+	switch (fmap->type) {
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+		fmap->type = FUSE_IOMAP_TYPE_MAPPED;
+		break;
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
+		fmap->type = FUSE_IOMAP_TYPE_UNWRITTEN;
+		break;
+	default:
+		/* should have been caught earlier */
+		ASSERT(0);
+		return -EFSCORRUPTED;
+	}
+	fmap->length = min(fmap->length, bstripe->strip_width - addr_in_strip);
+
+	*fbp = fuse_backing_get(bstrip->fb);
+	fuse_backing_put(stripe_fb);
+	return 0;
+}
+
 /* Convert a mapping from the server into something the kernel can use */
 static inline void fuse_iomap_from_server(struct iomap *iomap,
 					  const struct fuse_backing *fb,
@@ -472,6 +611,19 @@ fuse_iomap_find_bdev(struct fuse_conn *fc, const struct fuse_iomap_io *map)
 {
 	struct fuse_backing *ret = NULL;
 
+	if (fuse_iomap_is_striped(map)) {
+		if (BAD_DATA(map->dev == FUSE_IOMAP_DEV_NULL))
+			return ERR_PTR(-EFSCORRUPTED);
+
+		ret = fuse_backing_lookup(fc, &fuse_iomap_stripe_backing_ops,
+					  map->dev);
+		/* Stripes must have a device/addr */
+		if (BAD_DATA(ret == NULL))
+			return ERR_PTR(-EFSCORRUPTED);
+
+		return ret;
+	}
+
 	if (map->dev != FUSE_IOMAP_DEV_NULL && map->dev < INT_MAX)
 		ret = fuse_backing_lookup(fc, &fuse_iomap_backing_ops,
 					  map->dev);
@@ -678,9 +830,10 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 }
 
 /* Convert a mapping from the cache into something the kernel can use */
-static int fuse_iomap_from_cache(struct inode *inode, struct iomap *iomap,
+static int fuse_iomap_from_cache(struct inode *inode, loff_t pos,
+				 struct iomap *iomap,
 				 enum fuse_iomap_iodir dir,
-				 const struct fuse_iomap_lookup *lmap)
+				 struct fuse_iomap_lookup *lmap)
 {
 	struct fuse_mount *fm = get_fuse_mount(inode);
 	struct fuse_backing *fb;
@@ -690,6 +843,12 @@ static int fuse_iomap_from_cache(struct inode *inode, struct iomap *iomap,
 	if (IS_ERR(fb))
 		return PTR_ERR(fb);
 
+	if (fuse_iomap_is_striped(&lmap->map)) {
+		err = fuse_iomap_adjust_stripe(inode, pos, &lmap->map, &fb);
+		if (err)
+			goto out_backing;
+	}
+
 	err = fuse_iomap_validate_bdev_access(fb, dir);
 	if (err)
 		goto out_backing;
@@ -767,7 +926,7 @@ static int fuse_iomap_try_cache(struct inode *inode, loff_t pos, loff_t count,
 				goto out_unlock;
 
 			if (lmap.map.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
-				ret = fuse_iomap_from_cache(inode, dest,
+				ret = fuse_iomap_from_cache(inode, pos, dest,
 							    WRITE_MAPPING,
 							    &lmap);
 				if (ret)
@@ -817,7 +976,7 @@ static int fuse_iomap_try_cache(struct inode *inode, loff_t pos, loff_t count,
 	if (ret)
 		goto out_unlock;
 
-	ret = fuse_iomap_from_cache(inode, dest, backing_dir, &lmap);
+	ret = fuse_iomap_from_cache(inode, pos, dest, backing_dir, &lmap);
 	if (ret)
 		goto out_unlock;
 
@@ -948,6 +1107,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			goto out_read_dev;
 		}
 
+		if (fuse_iomap_is_striped(&outarg.write)) {
+			err = fuse_iomap_adjust_stripe(inode, pos, &outarg.write,
+						       &write_dev);
+			if (err)
+				goto out_write_dev;
+		}
+
+		if (fuse_iomap_is_striped(&outarg.read)) {
+			err = fuse_iomap_adjust_stripe(inode, pos, &outarg.read,
+						       &read_dev);
+			if (err)
+				goto out_write_dev;
+		}
+
 		err = fuse_iomap_validate_bdev_access(read_dev, READ_MAPPING);
 		if (err)
 			goto out_write_dev;
@@ -963,6 +1136,13 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		fuse_iomap_from_server(iomap, write_dev, &outarg.write);
 		fuse_iomap_from_server(srcmap, read_dev, &outarg.read);
 	} else {
+		if (fuse_iomap_is_striped(&outarg.read)) {
+			err = fuse_iomap_adjust_stripe(inode, pos, &outarg.read,
+						       &read_dev);
+			if (err)
+				goto out_read_dev;
+		}
+
 		err = fuse_iomap_validate_bdev_access(read_dev,
 				is_write ? WRITE_MAPPING : READ_MAPPING);
 		if (err)
@@ -2981,6 +3161,18 @@ fuse_iomap_upsert_validate_dev(
 	uint64_t			map_end;
 	uint64_t			device_bytes;
 
+	if (fuse_iomap_is_striped(map)) {
+		if (BAD_DATA(!fb))
+			return -EFSCORRUPTED;
+		if (BAD_DATA(map->addr == FUSE_IOMAP_NULL_ADDR))
+			return -EFSCORRUPTED;
+		if (BAD_DATA(check_add_overflow(map->addr, map->length,
+						&map_end)))
+			return -EFSCORRUPTED;
+
+		return 0;
+	}
+
 	if (!fb) {
 		if (BAD_DATA(map->addr != FUSE_IOMAP_NULL_ADDR))
 			return -EFSCORRUPTED;
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 056782ba5248e3..bd74d09150e0ec 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -1155,6 +1155,8 @@ static inline bool fuse_iomap_addrs_adjacent(const struct fuse_iomap_io *left,
 	switch (left->type) {
 	case FUSE_IOMAP_TYPE_MAPPED:
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 		return left->addr + left->length == right->addr;
 	default:
 		return left->addr  == FUSE_IOMAP_NULL_ADDR &&
@@ -1255,6 +1257,8 @@ fuse_iext_del_mapping(
 	switch (del->type) {
 	case FUSE_IOMAP_TYPE_MAPPED:
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 		del_endaddr = del->addr + del->length;
 		break;
 	default:
@@ -1400,6 +1404,8 @@ fuse_iomap_cache_remove(
 			break;
 		case FUSE_IOMAP_TYPE_MAPPED:
 		case FUSE_IOMAP_TYPE_UNWRITTEN:
+		case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+		case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 			wasreal = true;
 			break;
 		default:
@@ -1727,6 +1733,8 @@ fuse_iomap_trim(
 	switch (got->type) {
 	case FUSE_IOMAP_TYPE_MAPPED:
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
+	case FUSE_IOMAP_TYPE_MAPPED_STRIPE:
+	case FUSE_IOMAP_TYPE_UNWRITTEN_STRIPE:
 		mval->map.addr = got->addr;
 		break;
 	default:

