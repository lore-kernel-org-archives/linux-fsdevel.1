Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1A378813;
	Wed, 29 Apr 2026 14:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473373; cv=none; b=qMKYaRZzy1WGT5vuGcOLEA+xfb8UCzXAwKWCxCzO+y5XkPjqrqusbHLonboMJh/C5fGhw5dylpgCTtDHFnot94huio9iQ1zRGRSnJG6tZJjigZFSW3c+MTNIX7T8EPIDjYcftqn5JueCgJJMZXBmyBT4hNVN3Q68TXkgDSXI2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473373; c=relaxed/simple;
	bh=wGx3bC2TqLtXOaYhgyJvROkvVtH0S3Zdk89Sxog3+/I=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTaaFJsdd5CxbIOgVjzktEd3iooMjr/RQbW5eUZUBsUB7NmtJepLI+d0LuhBGA1R0grsAyHJRB/TDiJbmBrecV38oM03tAXX0TMtc0mMTPJX4OQ3uR7ekpXCEQdYLQpzNB2vjOjN9r2qJkASHzK9aO/+nqqgrhJNduU9ZuQNbUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RITQoFN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RITQoFN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF19C2BCB8;
	Wed, 29 Apr 2026 14:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777473373;
	bh=wGx3bC2TqLtXOaYhgyJvROkvVtH0S3Zdk89Sxog3+/I=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=RITQoFN6WT8BrqIllltLQsySgxbr8t8BvKnUc43crXibnXnNlBSmURtvMCT+Pf2O3
	 zNgL4RhGGZ842PkbhPZsvDXRH2PWELAHoohNxJvmKPJ9Ff4AvzF3rp7/2IdKl49OfK
	 iUtC4eQDC7k3gd4XGyNF2PGVx+M1Xqpv3a96Hsh4wM5hIZC+N45Hu69MVic1/4+ux+
	 DYtiUGUrxHD/Q/QWzqSPVEF05lRRdLF6qWoE7xGK6SDTGK1oAbPTthIe2ZIfZyXFnL
	 4Pwl0Do2rrbm68SWRtRR4RRuvdBsA1nN/bEgVRB5OS4o1PP73a5AZ83ormPJTtpyyp
	 W/thxGgh7tJzA==
Date: Wed, 29 Apr 2026 07:36:12 -0700
Subject: [PATCH 03/12] fuse: use the iomap cache for iomap_begin
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, miklos@szeredi.hu
Cc: joannelkoong@gmail.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, fuse-devel@lists.linux.dev
Message-ID: <177747207064.4103699.12261865047428291333.stgit@frogsfrogsfrogs>
In-Reply-To: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
References: <177747206929.4103699.18256961856283014867.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Look inside the iomap cache to try to satisfy iomap_begin.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/fuse_iomap_cache.h |    5 +
 fs/fuse/fuse_iomap.c       |  221 +++++++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_iomap_cache.c |    7 +
 3 files changed, 228 insertions(+), 5 deletions(-)


diff --git a/fs/fuse/fuse_iomap_cache.h b/fs/fuse/fuse_iomap_cache.h
index 922ca182357aa7..dcd52c183f22ab 100644
--- a/fs/fuse/fuse_iomap_cache.h
+++ b/fs/fuse/fuse_iomap_cache.h
@@ -53,6 +53,11 @@ bool fuse_iext_get_extent(const struct fuse_iext_root *ir,
 			  const struct fuse_iext_cursor *cur,
 			  struct fuse_iomap_io *gotp);
 
+/* iomaps that come direct from the fuse server are presumed to be valid */
+#define FUSE_IOMAP_ALWAYS_VALID	((uint64_t)0)
+/* set initial iomap cookie value to avoid ALWAYS_VALID */
+#define FUSE_IOMAP_INIT_COOKIE	((uint64_t)1)
+
 static inline uint64_t fuse_iext_read_seq(struct fuse_iomap_cache *ic)
 {
 	return (uint64_t)READ_ONCE(ic->ic_seq);
diff --git a/fs/fuse/fuse_iomap.c b/fs/fuse/fuse_iomap.c
index bb47b4c7f7eabc..8b37c2f5cbdb2b 100644
--- a/fs/fuse/fuse_iomap.c
+++ b/fs/fuse/fuse_iomap.c
@@ -131,6 +131,7 @@ static inline bool fuse_iomap_check_type(uint16_t fuse_type)
 	case FUSE_IOMAP_TYPE_UNWRITTEN:
 	case FUSE_IOMAP_TYPE_INLINE:
 	case FUSE_IOMAP_TYPE_PURE_OVERWRITE:
+	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 		return true;
 	}
 
@@ -239,9 +240,21 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 	const unsigned int blocksize = i_blocksize(inode);
 	uint64_t end;
 
-	/* Type and flags must be known */
+	/*
+	 * Type and flags must be known.  Mapping type "retry cache" doesn't
+	 * use any of the other fields.
+	 */
 	if (BAD_DATA(!fuse_iomap_check_type(map->type)))
 		return false;
+	if (map->type == FUSE_IOMAP_TYPE_RETRY_CACHE) {
+		/*
+		 * We only accept cache retries if we have a cache to query.
+		 * There must not be a device addr.
+		 */
+		if (BAD_DATA(!fuse_inode_caches_iomaps(inode)))
+			return false;
+		return true;
+	}
 	if (BAD_DATA(!fuse_iomap_check_flags(map->flags)))
 		return false;
 
@@ -286,6 +299,7 @@ static inline bool fuse_iomap_check_mapping(const struct inode *inode,
 		if (BAD_DATA(iodir != WRITE_MAPPING))
 			return false;
 		break;
+	case FUSE_IOMAP_TYPE_RETRY_CACHE:
 	default:
 		/* should have been caught already */
 		ASSERT(0);
@@ -561,6 +575,157 @@ static int fuse_iomap_set_inline(struct inode *inode, unsigned opflags,
 	return 0;
 }
 
+/* Convert a mapping from the cache into something the kernel can use */
+static int fuse_iomap_from_cache(struct inode *inode, struct iomap *iomap,
+				 const struct fuse_iomap_lookup *lmap)
+{
+	struct fuse_mount *fm = get_fuse_mount(inode);
+	struct fuse_backing *fb;
+
+	fb = fuse_iomap_find_dev(fm->fc, &lmap->map);
+	if (IS_ERR(fb))
+		return PTR_ERR(fb);
+
+	fuse_iomap_from_server(iomap, fb, &lmap->map);
+	iomap->validity_cookie = lmap->validity_cookie;
+
+	fuse_backing_put(fb);
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_FUSE_IOMAP_DEBUG)
+static inline int
+fuse_iomap_cached_validate(const struct inode *inode,
+			   enum fuse_iomap_iodir dir,
+			   const struct fuse_iomap_lookup *lmap)
+{
+	if (!static_branch_unlikely(&fuse_iomap_debug))
+		return 0;
+
+	/* Make sure the mappings aren't garbage */
+	if (!fuse_iomap_check_mapping(inode, &lmap->map, dir))
+		return -EFSCORRUPTED;
+
+	/* The cache should not be storing "retry cache" mappings */
+	if (BAD_DATA(lmap->map.type == FUSE_IOMAP_TYPE_RETRY_CACHE))
+		return -EFSCORRUPTED;
+
+	return 0;
+}
+#else
+# define fuse_iomap_cached_validate(...)	(0)
+#endif
+
+/*
+ * Look up iomappings from the cache.  Returns 1 if iomap and srcmap were
+ * satisfied from cache; 0 if not; or a negative errno.
+ */
+static int fuse_iomap_try_cache(struct inode *inode, loff_t pos, loff_t count,
+				unsigned opflags, struct iomap *iomap,
+				struct iomap *srcmap)
+{
+	struct fuse_iomap_lookup lmap;
+	struct iomap *dest = iomap;
+	enum fuse_iomap_lookup_result res;
+	int ret;
+
+	if (!fuse_inode_caches_iomaps(inode))
+		return 0;
+
+	fuse_iomap_cache_lock_shared(inode);
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		res = fuse_iomap_cache_lookup(inode, WRITE_MAPPING, pos, count,
+					      &lmap);
+		switch (res) {
+		case LOOKUP_HIT:
+			ret = fuse_iomap_cached_validate(inode, WRITE_MAPPING,
+					&lmap);
+			if (ret)
+				goto out_unlock;
+
+			if (lmap.map.type != FUSE_IOMAP_TYPE_PURE_OVERWRITE) {
+				ret = fuse_iomap_from_cache(inode, dest, &lmap);
+				if (ret)
+					goto out_unlock;
+
+				dest = srcmap;
+			}
+			fallthrough;
+		case LOOKUP_NOFORK:
+			/* move on to the read fork */
+			break;
+		case LOOKUP_MISS:
+			ret = 0;
+			goto out_unlock;
+		}
+	}
+
+	res = fuse_iomap_cache_lookup(inode, READ_MAPPING, pos, count, &lmap);
+	switch (res) {
+	case LOOKUP_HIT:
+		break;
+	case LOOKUP_NOFORK:
+		ASSERT(res != LOOKUP_NOFORK);
+		ret = -EFSCORRUPTED;
+		goto out_unlock;
+	case LOOKUP_MISS:
+		ret = 0;
+		goto out_unlock;
+	}
+
+	ret = fuse_iomap_cached_validate(inode, READ_MAPPING, &lmap);
+	if (ret)
+		goto out_unlock;
+
+	ret = fuse_iomap_from_cache(inode, dest, &lmap);
+	if (ret)
+		goto out_unlock;
+
+	if (fuse_is_iomap_file_write(opflags)) {
+		switch (iomap->type) {
+		case IOMAP_HOLE:
+			if (opflags & (IOMAP_ZERO | IOMAP_UNSHARE))
+				ret = 1;
+			else
+				ret = 0;
+			break;
+		case IOMAP_DELALLOC:
+			if (opflags & (IOMAP_DIRECT | FUSE_IOMAP_OP_WRITEBACK))
+				ret = 0;
+			else
+				ret = 1;
+			break;
+		default:
+			ret = 1;
+			break;
+		}
+	} else {
+		ret = 1;
+	}
+
+out_unlock:
+	fuse_iomap_cache_unlock_shared(inode);
+	if (ret < 1)
+		return ret;
+
+	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
+		ret = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
+					    srcmap);
+		if (ret)
+			return ret;
+	}
+	return 1;
+}
+
+/*
+ * For atomic writes we must always query the server because that might require
+ * assistance from the fuse server.  For swapfiles we always query the server
+ * because we have no idea if the server actually wants to support that.
+ */
+#define FUSE_IOMAP_OP_NOCACHE	(FUSE_IOMAP_OP_ATOMIC | \
+				 FUSE_IOMAP_OP_SWAPFILE)
+
 static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 			    unsigned opflags, struct iomap *iomap,
 			    struct iomap *srcmap)
@@ -581,6 +746,20 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 
 	trace_fuse_iomap_begin(inode, pos, count, opflags);
 
+	/*
+	 * Try to read mappings from the cache; if we find something then use
+	 * it; otherwise we upcall the fuse server.
+	 */
+	if (!(opflags & FUSE_IOMAP_OP_NOCACHE)) {
+		err = fuse_iomap_try_cache(inode, pos, count, opflags, iomap,
+					   srcmap);
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 0;
+	}
+
+retry:
 	args.opcode = FUSE_IOMAP_BEGIN;
 	args.nodeid = get_node_id(inode);
 	args.in_numargs = 1;
@@ -602,6 +781,24 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 	if (err)
 		return err;
 
+	/*
+	 * If the fuse server tells us it populated the cache, we'll try the
+	 * cache lookup again.  Note that we dropped the cache lock, so it's
+	 * entirely possible that another thread could have invalidated the
+	 * cache -- if the cache misses, we'll call the server again.
+	 */
+	if (outarg.read.type == FUSE_IOMAP_TYPE_RETRY_CACHE) {
+		err = fuse_iomap_try_cache(inode, pos, count, opflags, iomap,
+					   srcmap);
+		if (err < 0)
+			return err;
+		if (err == 1)
+			return 0;
+		if (signal_pending(current))
+			return -EINTR;
+		goto retry;
+	}
+
 	read_dev = fuse_iomap_find_dev(fm->fc, &outarg.read);
 	if (IS_ERR(read_dev))
 		return PTR_ERR(read_dev);
@@ -629,6 +826,8 @@ static int fuse_iomap_begin(struct inode *inode, loff_t pos, loff_t count,
 		 */
 		fuse_iomap_from_server(iomap, read_dev, &outarg.read);
 	}
+	iomap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
+	srcmap->validity_cookie = FUSE_IOMAP_ALWAYS_VALID;
 
 	if (iomap->type == IOMAP_INLINE || srcmap->type == IOMAP_INLINE) {
 		err = fuse_iomap_set_inline(inode, opflags, pos, count, iomap,
@@ -1372,7 +1571,21 @@ static const struct iomap_dio_ops fuse_iomap_dio_write_ops = {
 	.end_io		= fuse_iomap_dio_write_end_io,
 };
 
+static bool fuse_iomap_revalidate(struct inode *inode,
+				  const struct iomap *iomap)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+	uint64_t validity_cookie;
+
+	if (iomap->validity_cookie == FUSE_IOMAP_ALWAYS_VALID)
+		return true;
+
+	validity_cookie = fuse_iext_read_seq(fi->cache);
+	return iomap->validity_cookie == validity_cookie;
+}
+
 static const struct iomap_write_ops fuse_iomap_write_ops = {
+	.iomap_valid		= fuse_iomap_revalidate,
 };
 
 static int
@@ -1658,14 +1871,14 @@ static void fuse_iomap_end_bio(struct bio *bio)
  * mapping is valid, false otherwise.
  */
 static bool fuse_iomap_revalidate_writeback(struct iomap_writepage_ctx *wpc,
+					    struct inode *inode,
 					    loff_t offset)
 {
 	if (offset < wpc->iomap.offset ||
 	    offset >= wpc->iomap.offset + wpc->iomap.length)
 		return false;
 
-	/* XXX actually use revalidation cookie */
-	return true;
+	return fuse_iomap_revalidate(inode, &wpc->iomap);
 }
 
 /*
@@ -1719,7 +1932,7 @@ static ssize_t fuse_iomap_writeback_range(struct iomap_writepage_ctx *wpc,
 
 	trace_fuse_iomap_writeback_range(inode, offset, len, end_pos);
 
-	if (!fuse_iomap_revalidate_writeback(wpc, offset)) {
+	if (!fuse_iomap_revalidate_writeback(wpc, inode, offset)) {
 		struct iomap_iter fake_iter = { };
 		struct iomap *write_iomap = &fake_iter.iomap;
 
diff --git a/fs/fuse/fuse_iomap_cache.c b/fs/fuse/fuse_iomap_cache.c
index 1608e96984bb38..ea63a12a01c1fe 100644
--- a/fs/fuse/fuse_iomap_cache.c
+++ b/fs/fuse/fuse_iomap_cache.c
@@ -706,7 +706,11 @@ fuse_iext_realloc_root(
  */
 static inline void fuse_iext_inc_seq(struct fuse_iomap_cache *ic)
 {
-	WRITE_ONCE(ic->ic_seq, READ_ONCE(ic->ic_seq) + 1);
+	uint64_t new_val = READ_ONCE(ic->ic_seq) + 1;
+
+	if (new_val == FUSE_IOMAP_ALWAYS_VALID)
+		new_val++;
+	WRITE_ONCE(ic->ic_seq, new_val);
 }
 
 static void
@@ -1584,6 +1588,7 @@ int fuse_iomap_cache_alloc(struct inode *inode)
 
 	/* Only the write mapping cache can return NOFORK */
 	ic->ic_write.ir_bytes = -1;
+	ic->ic_seq = FUSE_IOMAP_INIT_COOKIE;
 	ic->ic_inode = inode;
 	init_rwsem(&ic->ic_lock);
 

