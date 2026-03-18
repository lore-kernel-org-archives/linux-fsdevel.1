Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787DD219A7A;
	Wed, 18 Mar 2026 07:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819551; cv=pass; b=KjJ1g2GWufqrtGEc3JfmObwdy6XYHxytwSyixRCSfecH5hYcD/1+4WxlK/NeYY4ZNnujlLot3SterWWvOm3bspdY6VuodP2CzyhPUX5Mnj1b7JHC2N97uMCpjKnsddeQ8e4zlKwsO45giRVdFyPTVGFCyat70QMNKxPc5KFlG+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819551; c=relaxed/simple;
	bh=APC7dhPS14RLMryDqNJVIeos7Did10qefUPSaTlKXn0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J8tK4DXY3sKpoesANKTbmOqou9hEssD3Zx8hbfPuEFSFPO5bnnKZmAPKXvHmWbL6hJ8OrQWXG1Zbmk5/QDZeDYShFpac0heM4IdTNG/R+hd52X3BVci0KWzv9A4rJz+k7+hQNTSauUalthn3iA6cHOIUuD6mVRiEhP49LGM2u0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=XpiDJ2u5; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="XpiDJ2u5"
ARC-Seal: i=1; a=rsa-sha256; t=1773819517; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=U0/BphT8MMAS640SILB//S7NzjRhDDtTqwQqNPtsQXhZeCHcJLpkkzSl5mPTifdT4c/aJjmYYPHY2iqzhBdxhy+d3O8oQxRmBaOeBfqNkU4szq2E79UYGZcZJ+qQjZYUp5juNr0xKwamcIUMulZbZEpNpIDqKgsK4ABZSehdY30=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773819517; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IZPtfNB2CTsZYPIJtir5IBqrmLbkftBTCzKm1cR0ilc=; 
	b=Bs8svvkZizSa7Wpx5TDAXotSvHN4/DRtjDUNGahInQyIIQdQ07Zubag2IfcbyUlmQsxjPtbHH2A7AuT9m+RQmEXhFrlBW7FqpTbMcwIMd0QD2K3nQIUg/ORRoESCR1ZGiGFHOJGiz7xFlLR+911PXUr9NoXBN1GaN9zVQAeCIio=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773819517;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=IZPtfNB2CTsZYPIJtir5IBqrmLbkftBTCzKm1cR0ilc=;
	b=XpiDJ2u55UvS8FhEV6Dw95wCC0nKWLgFKSfZ5w3cIqVLN4O9ks8hMLiiuxG2KkSA
	qj4zzncTeFXJpC0RNR+9clIED9vdg2GDxsqjV4Hzv2eGRbIXco+8J49iW07DVLJOf/Z
	HYl5o/yQU2V3LTGFH4GlZp1drKztnLvog+bhRSqk=
Received: by mx.zohomail.com with SMTPS id 1773819516723728.7404562950832;
	Wed, 18 Mar 2026 00:38:36 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>
Subject: [PATCH v7 1/2] hfsplus: refactor b-tree map page access and add node-type validation
Date: Wed, 18 Mar 2026 13:08:22 +0530
Message-Id: <20260318073823.3933718-2-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
References: <20260318073823.3933718-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

In HFS+ b-trees, the node allocation bitmap is stored across multiple
records. The first chunk resides in the b-tree Header Node at record
index 2, while all subsequent chunks are stored in dedicated Map Nodes
at record index 0.

This structural quirk forces callers like hfs_bmap_alloc() and
hfs_bmap_free() to duplicate boilerplate code to validate offsets, correct
lengths, and map the underlying pages via kmap_local_page(). There is
also currently no strict node-type validation before reading these
records, leaving the allocator vulnerable if a corrupted image points a
map linkage to an Index or Leaf node.

Introduce a unified bit-level API to encapsulate the map record access:
1. A new `struct hfs_bmap_ctx` to cleanly pass state and safely handle
   page math across all architectures.
2. `hfs_bmap_get_map_page()`: Automatically validates node types
   (HFS_NODE_HEADER vs HFS_NODE_MAP), infers the correct record index,
   handles page-boundary math, and returns the unmapped `struct page *`
   directly to the caller to avoid asymmetric mappings.
3. `hfs_bmap_clear_bit()`: A clean wrapper that internally handles page
   mapping/unmapping for single-bit operations.

Refactor hfs_bmap_alloc() and hfs_bmap_free() to utilize this new API.
This deduplicates the allocator logic, hardens the map traversal against
fuzzed images, and provides the exact abstractions needed for upcoming
mount-time validation checks.

Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c         | 169 ++++++++++++++++++++++++++-----------
 include/linux/hfs_common.h |   2 +
 2 files changed, 124 insertions(+), 47 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 1220a2f22737..64d168347b4b 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -129,6 +129,95 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size,
 	return clump_size;
 }
 
+/* Context for iterating b-tree map pages
+ * @page_idx: The index of the page within the b-node's page array
+ * @off: The byte offset within the mapped page
+ * @len: The remaining length of the map record
+ */
+struct hfs_bmap_ctx {
+	unsigned int page_idx;
+	unsigned int off;
+	u16 len;
+};
+
+/*
+ * Finds the specific page containing the requested byte offset within the map
+ * record. Automatically handles the difference between header and map nodes.
+ * Returns the struct page pointer, or an ERR_PTR on failure.
+ * Note: The caller is responsible for mapping/unmapping the returned page.
+ */
+static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node, struct hfs_bmap_ctx *ctx,
+				u32 byte_offset)
+{
+	u16 rec_idx, off16;
+	unsigned int page_off;
+
+	if (node->this == HFSPLUS_TREE_HEAD) {
+		if (node->type != HFS_NODE_HEADER) {
+			pr_err("hfsplus: invalid btree header node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_HDR_MAP_REC_INDEX;
+	} else {
+		if (node->type != HFS_NODE_MAP) {
+			pr_err("hfsplus: invalid btree map node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFSPLUS_BTREE_MAP_NODE_REC_INDEX;
+	}
+
+	ctx->len = hfs_brec_lenoff(node, rec_idx, &off16);
+	if (!ctx->len)
+		return ERR_PTR(-ENOENT);
+
+	if (!is_bnode_offset_valid(node, off16))
+		return ERR_PTR(-EIO);
+
+	ctx->len = check_and_correct_requested_length(node, off16, ctx->len);
+
+	if (byte_offset >= ctx->len)
+		return ERR_PTR(-EINVAL);
+
+	page_off = (u32)off16 + node->page_offset + byte_offset;
+	ctx->page_idx = page_off >> PAGE_SHIFT;
+	ctx->off = page_off & ~PAGE_MASK;
+
+	return node->page[ctx->page_idx];
+}
+
+/**
+ * hfs_bmap_clear_bit - clear a bit in the b-tree map
+ * @node: the b-tree node containing the map record
+ * @node_bit_idx: the relative bit index within the node's map record
+ *
+ * Returns 0 on success, -EINVAL if already clear, or negative error code.
+ */
+static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 node_bit_idx)
+{
+	struct hfs_bmap_ctx ctx;
+	struct page *page;
+	u8 *bmap, mask;
+
+	page = hfs_bmap_get_map_page(node, &ctx, node_bit_idx / BITS_PER_BYTE);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	bmap = kmap_local_page(page);
+
+	mask = 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
+
+	if (!(bmap[ctx.off] & mask)) {
+		kunmap_local(bmap);
+		return -EINVAL;
+	}
+
+	bmap[ctx.off] &= ~mask;
+	set_page_dirty(page);
+	kunmap_local(bmap);
+
+	return 0;
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
@@ -374,11 +463,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
 struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 {
 	struct hfs_bnode *node, *next_node;
-	struct page **pagep;
+	struct hfs_bmap_ctx ctx;
+	struct page *page;
 	u32 nidx, idx;
-	unsigned off;
-	u16 off16;
-	u16 len;
 	u8 *data, byte, m;
 	int i, res;
 
@@ -390,30 +477,26 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
-	off = off16;
 
-	if (!is_bnode_offset_valid(node, off)) {
+	page = hfs_bmap_get_map_page(node, &ctx, 0);
+	if (IS_ERR(page)) {
+		res = PTR_ERR(page);
 		hfs_bnode_put(node);
-		return ERR_PTR(-EIO);
+		return ERR_PTR(res);
 	}
-	len = check_and_correct_requested_length(node, off, len);
 
-	off += node->page_offset;
-	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap_local_page(*pagep);
-	off &= ~PAGE_MASK;
+	data = kmap_local_page(page);
 	idx = 0;
 
 	for (;;) {
-		while (len) {
-			byte = data[off];
+		while (ctx.len) {
+			byte = data[ctx.off];
 			if (byte != 0xff) {
 				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
 					if (!(byte & m)) {
 						idx += i;
-						data[off] |= m;
-						set_page_dirty(*pagep);
+						data[ctx.off] |= m;
+						set_page_dirty(page);
 						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
@@ -423,13 +506,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 					}
 				}
 			}
-			if (++off >= PAGE_SIZE) {
+			if (++ctx.off >= PAGE_SIZE) {
 				kunmap_local(data);
-				data = kmap_local_page(*++pagep);
-				off = 0;
+				page = node->page[++ctx.page_idx];
+				data = kmap_local_page(page);
+				ctx.off = 0;
 			}
 			idx += 8;
-			len--;
+			ctx.len--;
 		}
 		kunmap_local(data);
 		nidx = node->next;
@@ -443,22 +527,22 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 			return next_node;
 		node = next_node;
 
-		len = hfs_brec_lenoff(node, 0, &off16);
-		off = off16;
-		off += node->page_offset;
-		pagep = node->page + (off >> PAGE_SHIFT);
-		data = kmap_local_page(*pagep);
-		off &= ~PAGE_MASK;
+		page = hfs_bmap_get_map_page(node, &ctx, 0);
+		if (IS_ERR(page)) {
+			res = PTR_ERR(page);
+			hfs_bnode_put(node);
+			return ERR_PTR(res);
+		}
+		data = kmap_local_page(page);
 	}
 }
 
 void hfs_bmap_free(struct hfs_bnode *node)
 {
 	struct hfs_btree *tree;
-	struct page *page;
 	u16 off, len;
 	u32 nidx;
-	u8 *data, byte, m;
+	int res;
 
 	hfs_dbg("node %u\n", node->this);
 	BUG_ON(!node->this);
@@ -495,24 +579,15 @@ void hfs_bmap_free(struct hfs_bnode *node)
 		}
 		len = hfs_brec_lenoff(node, 0, &off);
 	}
-	off += node->page_offset + nidx / 8;
-	page = node->page[off >> PAGE_SHIFT];
-	data = kmap_local_page(page);
-	off &= ~PAGE_MASK;
-	m = 1 << (~nidx & 7);
-	byte = data[off];
-	if (!(byte & m)) {
-		pr_crit("trying to free free bnode "
-				"%u(%d)\n",
-			node->this, node->type);
-		kunmap_local(data);
-		hfs_bnode_put(node);
-		return;
+
+	res = hfs_bmap_clear_bit(node, nidx);
+	if (res == -EINVAL) {
+		pr_crit("trying to free free bnode %u(%d)\n",
+				node->this, node->type);
+	} else if (!res) {
+		tree->free_nodes++;
+		mark_inode_dirty(tree->inode);
 	}
-	data[off] = byte & ~m;
-	set_page_dirty(page);
-	kunmap_local(data);
+
 	hfs_bnode_put(node);
-	tree->free_nodes++;
-	mark_inode_dirty(tree->inode);
 }
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index dadb5e0aa8a3..be24c687858e 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,6 +510,8 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_NODE_MXSZ			32768
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
+#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
+#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map record in Map Node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
 
 /* btree key type */
-- 
2.34.1

