Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D18376025;
	Mon,  6 Apr 2026 05:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775453509; cv=pass; b=pdHcai57wQNmJKEYE94a3lXBCP7KjT0HjfXibEgP4ODOeh19ODxQqta78I8wlt6Qq3ZCCKSd+J4AXUGsa22/6r3Rybnah52diTujQO2nVuCiYUWGhfBllL2rzDMmGeB8QliwBnD6MdZ/Wo2ZxhGnGugWbmZelERYPRhv9nCTwIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775453509; c=relaxed/simple;
	bh=1PsHgTCo551xEa6NMnP03ufK6iFb6MT7Q7cEoUw6sXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dmjPwpWqOiPfo7PZr2giKlYIbmyMx7jGWTVkwJTjF7NIqj4NvI7aizALaiQMFvFqDRm57suafrijUvn2vZly3X4Vfsh0Jtz6AHNYuW/34G9R1kxcTtacJ79wMNheWb4qLqFIlfgIGruqBj5qS1Cb2YsMDa1ctNwsTk6d947SS/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b=g8jqBrT4; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=kalpan.jani@mpiricsoftware.com header.b="g8jqBrT4"
ARC-Seal: i=1; a=rsa-sha256; t=1775453491; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l1uzJtCZTcMiODmZWCiA0s3RKbQJkl2DuC6Mf9M4ztOp5K+SO20KtF9QAJ+Pl5ss445hc+gvfD7YvwmrcYRHw1uYvR5gkwGxYtzT3HQsyZV2de6lSj4ZbsTc+M4Gi7cJZtw/53UYqfPU32q58KzH9mUNQx50E4RH/iZw1sfiB0w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1775453491; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Gbt0IEXo77RDDHiB0l87dukw3LklcE+OHe0erq+BeFA=; 
	b=Mr5/IklTnYRanYtuuHuk+Unw6FEYx6Z/BU59m/uu9bYwlprnbZtZc/gxyrwcya7bVBh/l4BJ6yGGVMFyPZhZIzL+0E0XRZN67YOpaY//K36PMcMye5s1HSrrDYgWZKdFOMdFgLm79OkHLdf+msXGfWIWBTDs/mkPK043NZXpgi4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=kalpan.jani@mpiricsoftware.com;
	dmarc=pass header.from=<kalpan.jani@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775453491;
	s=mpiric; d=mpiricsoftware.com; i=kalpan.jani@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Gbt0IEXo77RDDHiB0l87dukw3LklcE+OHe0erq+BeFA=;
	b=g8jqBrT4lsgZezuxMQ3x3in01l6K4441FtDbDTTEJI6WKk2XPq6kURt9mJB3LpTd
	DXXyV6MRxb3I3IHDUp8a1WbAJsY24HC4THZ1Oc41rKpPjRMds9TfQOeRVIiplIX+Nq7
	7Lm1bjr5YHsmSQjHEUHRq6MeToPMnyBG//KqWzsg=
Received: by mx.zohomail.com with SMTPS id 1775453488925203.3750972897118;
	Sun, 5 Apr 2026 22:31:28 -0700 (PDT)
From: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: shardul.b@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Subject: [PATCH 1/1] hfsplus: switch hfs_bmap_alloc() to next-fit allocation using alloc_hint
Date: Mon,  6 Apr 2026 11:00:27 +0530
Message-ID: <20260406053027.1672425-2-kalpan.jani@mpiricsoftware.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
References: <20260406053027.1672425-1-kalpan.jani@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

hfs_bmap_alloc() currently performs a linear scan starting from bit 0 of
the allocation bitmap on every call. This rescans already-used regions
at the front of the bitmap, causing unnecessary overhead that grows with
filesystem size and fragmentation.

Introduce a next-fit allocation strategy by caching the last successful
allocation position in a new alloc_hint field in struct hfs_btree.
Allocation begins from alloc_hint instead of zero and wraps around when
the end of the map chain is reached, so the full bitmap is still
searched before returning -ENOSPC.

The map chain extension path (hfs_bmap_new_bmap) is preserved: when the
scan reaches the end of the chain with idx < node_count, a new map node
is created before any wrap-around, ensuring that nodes reserved by
hfs_bmap_reserve() are always reachable. Bounds checking against
tree->node_count prevents allocation beyond valid filesystem boundaries.

The seek phase that advances to the map node containing alloc_hint uses
the existing hfs_bmap_get_map_page() API for node-type validation and
offset checking, rather than open-coding hfs_brec_lenoff() calls. As a
minor API refinement, hfs_bmap_get_map_page() now sets ctx->len to the
remaining bytes from the requested byte_offset rather than the total
record length, eliminating the need for callers to adjust it externally.

hfs_bmap_free() pulls alloc_hint back when a node is freed below the
current hint, so the freed slot is found immediately on the next
allocation without requiring a full wrap-around scan.

No on-disk format changes.

Link: https://lore.kernel.org/all/7194aa49efdb85c7cfc9578f1460aaa9a1c67095.camel@mpiricsoftware.com/
Co-developed-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
Signed-off-by: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
---
 fs/hfsplus/btree.c      | 114 +++++++++++++++++++++++++++++++++++-----
 fs/hfsplus/hfsplus_fs.h |   1 +
 2 files changed, 101 insertions(+), 14 deletions(-)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 04304f952f6b..6f2448e332f3 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -132,7 +132,7 @@ u32 hfsplus_calc_btree_clump_size(u32 block_size, u32 node_size,
 /* Context for iterating b-tree map pages
  * @page_idx: The index of the page within the b-node's page array
  * @off: The byte offset within the mapped page
- * @len: The remaining length of the map record
+ * @len: The remaining bytes of the map record from the requested offset
  */
 struct hfs_bmap_ctx {
 	unsigned int page_idx;
@@ -178,6 +178,8 @@ static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node, struct hfs_bma
 	if (byte_offset >= ctx->len)
 		return ERR_PTR(-EINVAL);
 
+	ctx->len -= byte_offset;
+
 	page_off = (u32)off16 + node->page_offset + byte_offset;
 	ctx->page_idx = page_off >> PAGE_SHIFT;
 	ctx->off = page_off & ~PAGE_MASK;
@@ -525,19 +527,29 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	struct hfs_bnode *node, *next_node;
 	struct hfs_bmap_ctx ctx;
 	struct page *page;
-	u32 nidx, idx;
+	u32 start, target, nidx, idx;
+	u32 bit_offset, found;
 	u8 *data, byte, m;
 	int i, res;
+	bool wrapped = false;
 
 	res = hfs_bmap_reserve(tree, 1);
 	if (res)
 		return ERR_PTR(res);
 
+	if (tree->alloc_hint >= tree->node_count)
+		tree->alloc_hint = 0;
+
+	start = tree->alloc_hint;
+
 	nidx = 0;
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
 
+	target = start;
+
+	/* Seek to the map node containing the target bit */
 	page = hfs_bmap_get_map_page(node, &ctx, 0);
 	if (IS_ERR(page)) {
 		res = PTR_ERR(page);
@@ -545,27 +557,82 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		return ERR_PTR(res);
 	}
 
+	while (target >= (u32)ctx.len * BITS_PER_BYTE) {
+		target -= (u32)ctx.len * BITS_PER_BYTE;
+		nidx = node->next;
+		if (!nidx) {
+			/* target is out of bounds, reset to start of map */
+			target = 0;
+			start = 0;
+			hfs_bnode_put(node);
+			node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+			if (IS_ERR(node))
+				return node;
+			break;
+		}
+
+		hfs_bnode_put(node);
+		node = hfs_bnode_find(tree, nidx);
+		if (IS_ERR(node))
+			return node;
+
+		page = hfs_bmap_get_map_page(node, &ctx, 0);
+		if (IS_ERR(page)) {
+			res = PTR_ERR(page);
+			hfs_bnode_put(node);
+			return ERR_PTR(res);
+		}
+	}
+
+	/* Position within the target node at the exact byte */
+	page = hfs_bmap_get_map_page(node, &ctx, target / BITS_PER_BYTE);
+	if (IS_ERR(page)) {
+		res = PTR_ERR(page);
+		hfs_bnode_put(node);
+		return ERR_PTR(res);
+	}
+
 	data = kmap_local_page(page);
-	idx = 0;
+	idx = (start / 8) * 8;
+	bit_offset = target % 8;
 
 	for (;;) {
-		while (ctx.len) {
+		while (ctx.len && idx < tree->node_count) {
 			byte = data[ctx.off];
 			if (byte != 0xff) {
-				for (m = 0x80, i = 0; i < 8; m >>= 1, i++) {
+				/* After wrapping, only check bits before the start position */
+				int end_bit = (wrapped && idx == (start / 8) * 8) ? (start % 8) : 8;
+
+				for (i = bit_offset, m = 0x80 >> bit_offset;
+				     i < end_bit; i++, m >>= 1) {
 					if (!(byte & m)) {
-						idx += i;
+						found = idx + i;
+
+						/* past valid node range */
+						if (found >= tree->node_count)
+							break;
+
 						data[ctx.off] |= m;
 						set_page_dirty(page);
 						kunmap_local(data);
 						tree->free_nodes--;
 						mark_inode_dirty(tree->inode);
 						hfs_bnode_put(node);
-						return hfs_bnode_create(tree,
-							idx);
+
+						tree->alloc_hint = (found + 1) % tree->node_count;
+						return hfs_bnode_create(tree, found);
 					}
 				}
 			}
+
+			/* Terminate precisely if we've checked the start byte after wrapping */
+			if (wrapped && idx == (start / 8) * 8) {
+				kunmap_local(data);
+				hfs_bnode_put(node);
+				return ERR_PTR(-ENOSPC);
+			}
+
+			bit_offset = 0;
 			if (++ctx.off >= PAGE_SIZE) {
 				kunmap_local(data);
 				page = node->page[++ctx.page_idx];
@@ -577,16 +644,32 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 		}
 		kunmap_local(data);
 		nidx = node->next;
+
 		if (!nidx) {
-			hfs_dbg("create new bmap node\n");
-			next_node = hfs_bmap_new_bmap(node, idx);
-		} else
+			if (idx < tree->node_count) {
+				/* Extend the map chain to cover newly reserved nodes */
+				hfs_dbg("create new bmap node\n");
+				next_node = hfs_bmap_new_bmap(node, idx);
+			} else if (!wrapped) {
+				/* Chain exhausted, wrap to scan [0, start) */
+				wrapped = true;
+				idx = 0;
+				bit_offset = 0;
+				next_node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+			} else {
+				hfs_bnode_put(node);
+				return ERR_PTR(-ENOSPC);
+			}
+		} else {
 			next_node = hfs_bnode_find(tree, nidx);
+		}
+
 		hfs_bnode_put(node);
+
 		if (IS_ERR(next_node))
 			return next_node;
-		node = next_node;
 
+		node = next_node;
 		page = hfs_bmap_get_map_page(node, &ctx, 0);
 		if (IS_ERR(page)) {
 			res = PTR_ERR(page);
@@ -601,13 +684,14 @@ void hfs_bmap_free(struct hfs_bnode *node)
 {
 	struct hfs_btree *tree;
 	u16 off, len;
-	u32 nidx;
+	u32 nidx, node_id;
 	int res;
 
 	hfs_dbg("node %u\n", node->this);
 	BUG_ON(!node->this);
 	tree = node->tree;
-	nidx = node->this;
+	node_id = node->this;
+	nidx = node_id;
 	node = hfs_bnode_find(tree, 0);
 	if (IS_ERR(node))
 		return;
@@ -647,6 +731,8 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	} else if (!res) {
 		tree->free_nodes++;
 		mark_inode_dirty(tree->inode);
+		if (node_id < tree->alloc_hint)
+			tree->alloc_hint = node_id;
 	}
 
 	hfs_bnode_put(node);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 5f891b73a646..170ef2644204 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -49,6 +49,7 @@ struct hfs_btree {
 	u32 leaf_tail;
 	u32 node_count;
 	u32 free_nodes;
+	u32 alloc_hint;
 	u32 attributes;
 
 	unsigned int node_size;
-- 
2.34.1

