Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE236A01D
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784187731; cv=none; b=j+U4laNpA+cPF3hFLYzIRNqxcrrY3830KomnphCdmO+hGpwjs/2GKmRzwtL4TnJ+bGO9A6VMDxtnNOapOJUDg6zyugRNe4xD24CNW6zVYD5oZ8IIti2NmFLwk8LK+XLV+j9LU3WRx61zVCuFePXNViov1/DEmPMrjAmRY8H45hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784187731; c=relaxed/simple;
	bh=3738nA6QmXTz1Pk1PrHuRLenW2/isWSknaJ1DgUgg3s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d7B/rrBUIyVgorYNgLGP7e4JiD4kKqch9IxLBIc5mQS4kDW7bnFxrJQ2rQPWqfBzOYC345pVp7vVM1hM1bTlXFeOE2zA1arRvcpbRBRrS4kzaWs4BMOBfC49AtoQ2pO6isP5kp+yggc+hr0hl4pDHs4c2L0Fi8v5lbKqtqgoOcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbGJNN6x; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbGJNN6x"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so1876655a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 00:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784187729; x=1784792529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V9uYwin0WFx1EUW35rOQEQ0AJj52CtdHfuFlypkxxks=;
        b=YbGJNN6xwkZuInEXUicwNKyr4YJAodv8vBFFSCqh8bU74cWASVAwoZDPglE6orJuAx
         KjzCwfvuAmG0Q0G+T/3Gv+zNF4O0a457i8W4uO8WjM7Zh/euaBGKaCFZHYQwwb1RplLY
         zwh5xnMV7xf6O7mIZKzP9F2cMW+Us2UF9EyaBvwmEyPcvGOSmEx9f9hJeSACdMOigWFy
         lyxCZ9Wglk3uAERQCBvJfP39kxBlIo9jHjPZtcMR0zF9/ShS7VAzyQDYrGxehnxWmr69
         JN6bb7JtleHyufUfMSIqBIlvo92ahvx9KalNbfN21YxHoMyP8h3L/Rcx2GIirnNmhx5t
         iS9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784187729; x=1784792529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V9uYwin0WFx1EUW35rOQEQ0AJj52CtdHfuFlypkxxks=;
        b=LidTfVCl+BsIzHpdmcyGJYqUH8gszh0ejh8yOjLl/Z/MNys/yzyOCB6mKj0Ycpl9Uu
         r0tNXAVmoCKlVynvaBeuuOVZqgh6iefJ5+zYPrkrrmXemRj67ibEgbhPTnZ8Jbl/w9WI
         9+AE3carMZ9WF7qapB8/jLn8x0AI1pkea3AmwmfrKgRa/Oyusfn4qwp239pB8a92nzLl
         3FhU1DQZEcdVocK5nYDby+ZOIkgaOtXQ1QN0U/OwZ7bsMuoiY3eqJq0JRhvR22WGOBlj
         W2dRZVhkH6JoPBsjnlNHXnrKGAv1Yj+Hmh4UNcrZgDr7Sl+uO2IIq1zuLDF+/bLGhc9x
         J9Rw==
X-Forwarded-Encrypted: i=1; AHgh+Rpck9Ja50PutfLB+16W0GMTJqgTljkhiLL2B3eh42E4oNFliGm4jbjzv4U2t30LJsH7pu1M+ZqYRrhTB2ed@vger.kernel.org
X-Gm-Message-State: AOJu0Yy50zZy7qYDpBfnl6yIaJus5XBnszaHF+VQf4oMAo/K8lcrROUi
	PWCgKHNKClmlEGOmTrX+Jk1HAGvTLEBhl3fACkrB9vTa1f7RwVEFDfT1
X-Gm-Gg: AfdE7cn6s8odlbND76fkMZLqj70qQh+EQOYMgFXMfqKXRktOg9IckKJInqDxlECuM1U
	CejtgfX09uNZ6nCW/8VasX3ME5zBBiXH/4tv5e2cgQtMG4eDmqXxQo8fG5F7xocC+hb2oNAMWUL
	Lwhqk10cc9GDA5i9U/0m+9BsRAx4doK7gJ1oquvHFrvxVIQ1EuwiFEN37HA8ORHpKusEMvEmcSe
	WBeayyEBzpAW0wNdruzfAC87ZUvFb+De30r+Kzc8dDhq7TTEb1kTsuSfDfI3hq5sDODpkMr4X2Y
	iyjzitFnXvxTDoaDGT6cTPrumd0QRqzvygBp2grWDV+7KE6S7mL/aw3bg5/0Ub6FszPmHJ/l1YC
	a4771atEKfYW1vBy5mX+TFI5SDbnLJ69QuFgyJhegtecT+x/vQnLb0hLwQJsiilXfOmnKUW4Fw2
	TuBLZenBtmXF4yzzacvhWqv+7Phnjnz3XVb0S6aifWnaSSCSgSY5fbvhTn5jK5fsT/ApFOo83nH
	lDiK+wzYPBt8LPiETJA++vZttIu0h8ZcTrB0HsVBIMCrfPqYAqdwvstU8GlcDcPvAjqQAHqbXpx
	LV7CH+/Bze3k/d2YUEqOSJTlc36J
X-Received: by 2002:a05:6a20:4e92:b0:3bf:6c07:b2f0 with SMTP id adf61e73a8af0-3c110ad2d7fmr22287993637.51.1784187728556;
        Thu, 16 Jul 2026 00:42:08 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (143.164.142.34.bc.googleusercontent.com. [34.142.164.143])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e6c0702sm8697547eec.22.2026.07.16.00.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 00:42:08 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v6] hfs: port HFS+ b-tree bitmap corruption check
Date: Thu, 16 Jul 2026 07:41:50 +0000
Message-ID: <20260716074150.1660-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
verifies that the allocation map bit for the tree header (node 0) is
set. If not, it indicates a corrupted map record/bitmap and mounts
the volume as read-only (SB_RDONLY) to prevent further damage.

HFS filesystems share the same b-tree structure but currently lack
this corruption detection check.

Port this check to HFS, aligning its implementation with HFS+ to
maintain consistent b-tree logic across both filesystems:
1. Define struct hfs_bmap_ctx, and define HFS_TREE_HEAD and the relevant
   map record indices in include/linux/hfs_common.h.
2. Port the necessary offset and length validation helpers to
   fs/hfs/btree.h as static inline functions with robust null pointer
   checks.
3. Implement static hfs_bmap_get_map_page() in fs/hfs/btree.c.
4. Implement static hfs_bmap_test_bit() in fs/hfs/btree.c to inspect
   the B-tree bitmap using the get_map_page helper.
5. Implement static hfs_bmap_clear_bit() in fs/hfs/btree.c.
6. Rewrite hfs_bmap_alloc() in fs/hfs/btree.c to use the unified
   hfs_bmap_get_map_page() helper, eliminating redundant page and offset
   calculation code.
7. Refactor hfs_bmap_free() in fs/hfs/btree.c to use the new
   hfs_bmap_clear_bit() helper.
8. In hfs_btree_open(), retrieve the header node via hfs_bnode_find(),
   test its allocation bit with hfs_bmap_test_bit(), and release it
   using hfs_bnode_put().

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/hfs/bnode.c             |  42 --------
 fs/hfs/btree.c             | 210 +++++++++++++++++++++++++++++--------
 fs/hfs/btree.h             |  40 +++++++
 include/linux/hfs_common.h |  13 ++-
 4 files changed, 218 insertions(+), 87 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index da8e5342c91c..1b331108d9c0 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -15,48 +15,6 @@
 
 #include "btree.h"
 
-static inline
-bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
-{
-	bool is_valid = off < node->tree->node_size;
-
-	if (!is_valid) {
-		pr_err("requested invalid offset: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %u\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off);
-	}
-
-	return is_valid;
-}
-
-static inline
-u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
-{
-	unsigned int node_size;
-
-	if (!is_bnode_offset_valid(node, off))
-		return 0;
-
-	node_size = node->tree->node_size;
-
-	if ((u64)off + len > node_size) {
-		u32 new_len = node_size - off;
-
-		pr_err("requested length has been corrected: "
-		       "NODE: id %u, type %#x, height %u, "
-		       "node_size %u, offset %u, "
-		       "requested_len %u, corrected_len %u\n",
-		       node->this, node->type, node->height,
-		       node->tree->node_size, off, len, new_len);
-
-		return new_len;
-	}
-
-	return len;
-}
-
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
 {
 	struct page *page;
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e8..41b4e8fc9463 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -15,6 +15,121 @@
 
 #include "btree.h"
 
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
+static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
+					  struct hfs_bmap_ctx *ctx,
+					  u32 byte_offset)
+{
+	u16 rec_idx, off16;
+	unsigned int page_off;
+
+	if (node->this == HFS_TREE_HEAD) {
+		if (node->type != HFS_NODE_HEADER) {
+			pr_err("hfs: invalid btree header node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFS_BTREE_HDR_MAP_REC_INDEX;
+	} else {
+		if (node->type != HFS_NODE_MAP) {
+			pr_err("hfs: invalid btree map node\n");
+			return ERR_PTR(-EIO);
+		}
+		rec_idx = HFS_BTREE_MAP_NODE_REC_INDEX;
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
+ * hfs_bmap_test_bit - test a bit in the b-tree map
+ * @node: the b-tree node containing the map record
+ * @node_bit_idx: the relative bit index within the node's map record
+ *
+ * Returns true if set, false if clear or on failure.
+ */
+static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
+{
+	struct hfs_bmap_ctx ctx;
+	struct page *page;
+	u8 *bmap, byte, mask;
+
+	page = hfs_bmap_get_map_page(node, &ctx, node_bit_idx / BITS_PER_BYTE);
+	if (IS_ERR(page))
+		return false;
+
+	bmap = kmap_local_page(page);
+	byte = bmap[ctx.off];
+	kunmap_local(bmap);
+
+	mask = 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
+	return (byte & mask) != 0;
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
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
@@ -23,6 +138,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct address_space *mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
+	struct hfs_bnode *node;
 	unsigned int size;
 	u16 dblock;
 	sector_t start_block;
@@ -155,6 +271,20 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	kunmap_local(head);
 	folio_unlock(folio);
 	folio_put(folio);
+
+	node = hfs_bnode_find(tree, HFS_TREE_HEAD);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	if (!hfs_bmap_test_bit(node, HFS_TREE_HEAD)) {
+		pr_warn("(%s): %s (cnid 0x%x) bitmap corrupted, forcing rdonly\n",
+			sb->s_id, id == HFS_EXT_CNID ? "extents" : "catalog", id);
+		pr_warn("Run fsck.hfs to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
+	hfs_bnode_put(node);
+
 	return tree;
 
 fail_folio:
@@ -285,11 +415,9 @@ int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes)
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
 
@@ -301,24 +429,26 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	node = hfs_bnode_find(tree, nidx);
 	if (IS_ERR(node))
 		return node;
-	len = hfs_brec_lenoff(node, 2, &off16);
-	off = off16;
 
-	off += node->page_offset;
-	pagep = node->page + (off >> PAGE_SHIFT);
-	data = kmap_local_page(*pagep);
-	off &= ~PAGE_MASK;
+	page = hfs_bmap_get_map_page(node, &ctx, 0);
+	if (IS_ERR(page)) {
+		res = PTR_ERR(page);
+		hfs_bnode_put(node);
+		return ERR_PTR(res);
+	}
+
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
@@ -327,13 +457,14 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
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
@@ -347,22 +478,22 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
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
 	tree = node->tree;
@@ -396,23 +527,18 @@ void hfs_bmap_free(struct hfs_bnode *node)
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
+
+	res = hfs_bmap_clear_bit(node, nidx);
+	if (res == -EINVAL) {
 		pr_crit("trying to free free bnode %u(%d)\n",
-			node->this, node->type);
-		kunmap_local(data);
-		hfs_bnode_put(node);
-		return;
+			nidx, node->type);
+	} else if (res) {
+		pr_crit("fail to free bnode %u(%d)\n",
+			nidx, node->type);
+	} else {
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
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 99be858b2446..b4c3f2a31471 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -129,3 +129,43 @@ extern int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd);
 extern int hfs_brec_find(struct hfs_find_data *fd);
 extern int hfs_brec_read(struct hfs_find_data *fd, void *rec, u32 rec_len);
 extern int hfs_brec_goto(struct hfs_find_data *fd, int cnt);
+
+static inline bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
+{
+	bool is_valid;
+
+	if (!node || !node->tree)
+		return false;
+
+	is_valid = off < node->tree->node_size;
+
+	if (!is_valid) {
+		pr_err("invalid offset: id %u, type %#x, h %u, sz %u, off %u\n",
+		       node->this, node->type, node->height,
+		       node->tree->node_size, off);
+	}
+
+	return is_valid;
+}
+
+static inline u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
+{
+	unsigned int node_size;
+
+	if (!is_bnode_offset_valid(node, off))
+		return 0;
+
+	node_size = node->tree->node_size;
+
+	if ((u64)off + len > node_size) {
+		u32 new_len = node_size - off;
+
+		pr_err("corrected len: id %u, type %#x, h %u, sz %u, off %u, len %u->%u\n",
+		       node->this, node->type, node->height,
+		       node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 45fb4c9ff9f5..d6a615e74b26 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,14 +510,21 @@ struct hfs_btree_header_rec {
 						   b-tree but not in extents
 						   b-tree (hfsplus). */
 
+/* HFS BTree misc info */
+#define HFS_TREE_HEAD				0
+#define HFS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
+#define HFS_BTREE_MAP_NODE_REC_INDEX		0	/* Map record in Map Node */
+
 /* HFS+ BTree misc info */
-#define HFSPLUS_TREE_HEAD			0
+#define HFSPLUS_TREE_HEAD			HFS_TREE_HEAD
 #define HFSPLUS_NODE_MXSZ			32768
 #define HFSPLUS_NODE_MINSZ			512
 #define HFSPLUS_ATTR_TREE_NODE_SIZE		8192
 #define HFSPLUS_BTREE_HDR_NODE_RECS_COUNT	3
-#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
-#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map record in Map Node */
+/* Map (bitmap) record in Header node */
+#define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		HFS_BTREE_HDR_MAP_REC_INDEX
+/* Map record in Map Node */
+#define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	HFS_BTREE_MAP_NODE_REC_INDEX
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
 #define HFSPLUS_BTREE_MAP_NODE_RECS_COUNT	2
 #define HFSPLUS_BTREE_MAP_NODE_RESERVED_BYTES	2
-- 
2.47.3

