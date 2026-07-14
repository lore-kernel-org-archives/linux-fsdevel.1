Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261A843FD13
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 09:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021275; cv=none; b=BNOfib0ozMqab/8O+GlMr3SCNh0vj47K2WnMhX40wPR78iSVD4UAgcExbqLBLRBgAYye/5Oj3+bI+MlfQan7GOfjl4G0Nz8lu81c+l9XsRa730XASx5HM9iFL9S0gfTMYZwylyIhzW/4fhlaMs6TWT+lTJfmAQI+P2dzP6oLbVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021275; c=relaxed/simple;
	bh=gM+LMbsXNxoFatR9xtTCX3IOzOl+ARpL2qPAr+sxBZA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f6FWVs9yU+yriMGqrGXZv7d5/4nBvDKrYpQNWD38Z3nvskDLnEGEybo41bPNTP79zVBIa36QorfZa+RFzic4yXQjWFU5iEl32rKVyhrcd2L7XZbR6U+QQAuW+Mi+UEg/8ssYlzpKEaFYEGHPiWGMNhcSwknbLJU8XAzEsafsN0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmKTgVQa; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmKTgVQa"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2cab973140bso46224735ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 02:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784021258; x=1784626058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Rn93eU6b2qhqsXg43+dcgl5tQCYBCauMnNxDhXkhac=;
        b=VmKTgVQaZCQB7sjlxfvHo9RpdATrNNYSYPEiQW+RVBWfhxeDTmaB7SxmH3luUFv7F1
         km2LQqre2QbjBGyg7KeOS6lZ49cRi70ylOGBct/GmyJO3E2BujXpjertnT/H9YAjQB4Z
         ouCg1kCPH8sU8KaCTGgqBTVERHMV5t50Xsj643W5JdfM1VDdcj5dSh/3kbBSUpyoF2Do
         tU1GOflOZpdmm144q+ptgjgHlxv77cz9MmcHNfQsoVrhn6Sl03XcVvU3rOXR3daMVI8F
         UHfvPUH2n4gRk4Dw0VBxSAvjbxzueqpQ2khG0XAsRdrt6RKECod86bk7tL3ta4YXke7f
         KoPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784021258; x=1784626058;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Rn93eU6b2qhqsXg43+dcgl5tQCYBCauMnNxDhXkhac=;
        b=APrZJgRY/QZMjvMDPXq7Rdqa6ZHm0v5sqcK4xFc1L9hB7idieUVvtqpjjg++DYEHLM
         7J9UEJwmBGccyNSdHonlBU+2iEhsbRjGNv+U6l897Ix28XzjdfaoIt+Q4FTcNtzapGN2
         V3Qa3yklPdMKG+BaXpTaUAas4xwk6AAzVx3PP5Rb+lNCEhEbT4qA4ioD9OpPBCgojyjJ
         XNyMjgJthQlL6zkdKkHXl7BL0raIgDQKWP7z7E+B/j+RYf508mwZWpRQJwufOi6n4bZa
         F4Jw/Yy0qxa4XobG+RoQH5gQ1KqWrXNgMRtZpxd4jP8z8qJkeU+mXE1f6CG839e79Kx5
         GeNQ==
X-Forwarded-Encrypted: i=1; AHgh+RrO1g5nUIEYrivbRNLMeA1/BWE7DlGgVnQM9ZX3+hIwxWJDePpGiEJ06HAisLcUmV4sqRQgQTK8xG9QH4Yi@vger.kernel.org
X-Gm-Message-State: AOJu0YwIuhghIyja+bM9hwU6pVH30M7VIDc0kFwij6qdyjeuJ42sdo7n
	p/uFOaoZEb5Af9X01gQg8PDx16eLplDcbHdTZ0Byl+k2Ita1L2k8SMRA
X-Gm-Gg: AfdE7cmR+lXYZQ7nHISgo6Wp8COfhQxR2c0Gek5/j5A2DT2DqVQL7KIJMvSYrp+W64h
	+EwAjTHlv4R1mR5VjgG6Hf9d22xeH9hLs8y5AqbSp7BrOToJUu8mdIwBApR//mdlLetyQKQm05x
	ZGY4Ov7OJLKSXuSUCQX3D4ZpdYEV6VE6WQMs8ys7Bf6b65IHY2gy5aWcpFMhL66AmZ3vybAUyBq
	n2GCL9qaT5A4MAJDLXfDDUksRZc8dDrTUIpgGit+2utdB33g+sI5T/U0Yg/hFNbuiNxe/rMCPCw
	CjyhcSws6GtCzINGr0b8aLJbpKYpJyVHxIchmSHBIaYpNQkbR7gDWlybSd719NmcO7awNS41xgR
	6cTg46fbqLFm2UXl6Y3Nk/qw20Epmy3wUqkiq0IOsLGlL7li5r0a5oDNr/5twaTNlqUPJeRpXxV
	+D4rM9SyPoPWYekTk6DRJbGhxOkU1yqzcDBBi4H+TmGl8ovAFKdPDarNvAvZxJAyaizv0RpWE7z
	Ezh5NzgrEEc1v4OxOz+JK4qyuo0U3NyFOSzUIU11RagCDopp02PuXyS2KFrZtzWxMe8ZTuZnJUC
	DH2baEIcqi0Y0kreWTs+VZPM2d4OKjNy8c4V
X-Received: by 2002:a17:903:3503:b0:2ca:e0ff:e696 with SMTP id d9443c01a7336-2ce9e7a51b1mr131305665ad.9.1784021258208;
        Tue, 14 Jul 2026 02:27:38 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (48.144.186.35.bc.googleusercontent.com. [35.186.144.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ce95e001b1sm57043645ad.66.2026.07.14.02.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 02:27:37 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v4] hfs: port HFS+ b-tree bitmap corruption check
Date: Tue, 14 Jul 2026 09:27:15 +0000
Message-ID: <20260714092715.2758-1-aditya.ansh182@gmail.com>
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
2. Implement static hfs_bmap_get_map_page() in fs/hfs/btree.c, and port
   the necessary offset and length validation helpers to fs/hfs/btree.h
   as static inline functions with robust null pointer checks.
3. Implement static hfs_bmap_test_bit() in fs/hfs/btree.c to inspect
   the B-tree bitmap using the new get_map_page helper.
4. In hfs_btree_open(), retrieve the header node via hfs_bnode_find(),
   test its allocation bit with hfs_bmap_test_bit(), and release it
   using hfs_bnode_put().

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
 fs/hfs/bnode.c             | 42 -------------------
 fs/hfs/btree.c             | 86 ++++++++++++++++++++++++++++++++++++++
 fs/hfs/btree.h             | 40 ++++++++++++++++++
 include/linux/hfs_common.h |  5 +++
 4 files changed, 131 insertions(+), 42 deletions(-)

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
index 2eb37a2f64e8..2c841221c45c 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -15,6 +15,8 @@
 
 #include "btree.h"
 
+static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx);
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
@@ -23,6 +25,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct address_space *mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
+	struct hfs_bnode *node;
 	unsigned int size;
 	u16 dblock;
 	sector_t start_block;
@@ -155,6 +158,20 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
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
@@ -356,6 +373,75 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	}
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
 void hfs_bmap_free(struct hfs_bnode *node)
 {
 	struct hfs_btree *tree;
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 99be858b2446..f8afa33f709a 100644
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
+		pr_err("invalid offset: id %u, type %x, h %u, sz %u, off %u\n",
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
+		pr_err("corrected len: id %u, type %x, h %u, sz %u, off %u, len %u->%u\n",
+		       node->this, node->type, node->height,
+		       node_size, off, len, new_len);
+
+		return new_len;
+	}
+
+	return len;
+}
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 45fb4c9ff9f5..8dc10e0bfa7e 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -510,6 +510,11 @@ struct hfs_btree_header_rec {
 						   b-tree but not in extents
 						   b-tree (hfsplus). */
 
+/* HFS BTree misc info */
+#define HFS_TREE_HEAD				0
+#define HFS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
+#define HFS_BTREE_MAP_NODE_REC_INDEX		0	/* Map record in Map Node */
+
 /* HFS+ BTree misc info */
 #define HFSPLUS_TREE_HEAD			0
 #define HFSPLUS_NODE_MXSZ			32768
-- 
2.47.3

