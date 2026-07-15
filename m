Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CE3B19CF
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 03:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784086741; cv=none; b=KrooEAPMU/TesMjpIqjYn50k2uvRXGIPe8jnIEOJHqNusZzJjoWOKbFszH86fx092ieeKP3hU/39Lgpvm5K2nTWef9PJs8V9t1JyZKX8hqddK6R6PsadQh25MVquk1d90Wif39+gvsPey8gjvVWWPIoroKqQhxafTJiw/7DTg7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784086741; c=relaxed/simple;
	bh=+JIsQOKzAuAkK7oLjYQ/sEsagKZGJZU1aXqIudAQK3I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVqaFFtCvgZhxlS2LsWjNVp09FUwsTNQC/5KBPCu4eFNT+NrT0Vchy/g9KHOz8EWZVbjyFDWkjZbkzGihlLN6WRuQzWD0U6HVJUJk35nMeRa/MEwo0/Kf+4oqB/++ds76dz/1zBxX04kMJyOLhcwTostoSsIWGc/yr8KgWcWuGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bh4vpA0H; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bh4vpA0H"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cab973140bso57567395ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784086727; x=1784691527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hgB7udYPegIdRWHisml43eWNdBSQC17fV/wX65PBu7c=;
        b=Bh4vpA0HMUH58d7yhIWQlWpGZYfykOU4juHDyLvCfa0b9JIfi3PHuxg0XtyCHaa+mG
         wkZ3LA/1Ulrrwr2DMXErBoQJwSHNceN4tdfnAO0MzA3hJfa+Wjn50jShSsO0mBwXfyCj
         fULtRA5/2lS44HyfxYts64upOgNYK6bCzLqji5AHuEpYLmXrfwvhu5wcwY33JO6E67Is
         fWNFO86xDFiHM45KjCLFjr3vWxne3i3a40atgZsn6Kno1w02z+ZME7MlBz3F91ghdpXe
         6em1H5/wxtZZLf2fr+nsBVzv7SslQW7cXEmSRMtLRWSr1Bd172b3n4Eth/u1AvS9ZiQ3
         hbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784086727; x=1784691527;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hgB7udYPegIdRWHisml43eWNdBSQC17fV/wX65PBu7c=;
        b=raptLDcn72O2AeeJRozXmmOi0I2LoLCnPJBunFwIoyv73X/R+HbbLpkmM1pKSMp3XU
         i4mhmyTNJ7v1R1Hjfr6bdbmSYzhssTfSQyUX/6qQ5SgPstO9K+bpBrGPfQz29hHT/LUa
         sD0Xe87vcfoflqrumnMLapwzSAJCmNWglMtzgSG1Qp2yuGSZ60Pte88IvSVYm5Qq7dNd
         MwKDitDUBqvx64aSMg4VmhxyShvoqhxgsBaNcdtbAgs4RoAAe6HKWqLiEbDWAyV1rzyp
         b4bpHPISwdmKXXMhAeyF2v9bZTI1OO19jYgxm82QNN2k4EOte1xGRpEZ8ThNxyj5ZwXw
         CbUw==
X-Forwarded-Encrypted: i=1; AHgh+RoQFdWumDko5GpQZFRg0OjrihEWKvWJX3RW3N7Q/REEES0eMWM7NVSDroZNITv9Gi99OzOs0fM2/n9D7Knd@vger.kernel.org
X-Gm-Message-State: AOJu0YzGwq8xires7pBxnuXzU8Vr44he/I9M5wuUh+SctC74wRVzPF/3
	wXaX1yRWunS0tLJVbCvvXoLuS61bWc6W6EH6rZInXtv1BE/Uu1yPOETV
X-Gm-Gg: AfdE7cm5Y1ssUx+Ml80CgYPtv2XoM2biXiwm8crFFlLZAFthZnipTePwRLV+ipQ+kjp
	zkPhxqmeLGvXHegQk8ZsSnZQ8RxAcQk125LTIcBAWhIFoE/8d1t+31quQgXBw5gIv6A8/iM+cbN
	QOPH5qQKufZh34YmMEuXD70H90fqfM2DDTy5B6vUc2GLA0K1ilwq9kPmhR+7wvzleXGN7EkoyIO
	Bgod5s7n4XhYlW0/9RiT4RBbB8UBYEzMRXfr43aU2c3oBDK0ssLfddLLBUVIZIDeabqUbdmF9DT
	/qWOp11qwE3s4D8rYjlBWiDMufODrg5hHOBNd45x+tE7fO/sUE3JfP8yDV1/Bj+NJtlmhPjVmGe
	/SVtxJgBjJTJwyUcgPdJxT9roYW9FRi5Xqp5ExT9tdgaqHxCiSy93islMj0NmNm5fwLfQEMRiI6
	bMafkeMKG4Xi90kjz/5aYMtSAJhwVQLn875BsFo0mOyrQ2fakd1E1mBMEz7ApIPU0KUBgkMd2kq
	y1wGnvnTBkcjDTaYst8rDlfDdhfAVCyUEOhS29CoFv4SRAMAuYyEIRKYQWxkApjO2sH6yC6GBCl
	IbKz6OPZfp3kXvekJIPcuDhD585jCzDToH0Y
X-Received: by 2002:a17:90b:3d81:b0:387:df8f:1406 with SMTP id 98e67ed59e1d1-38e2a0eacc3mr1072127a91.39.1784086726650;
        Tue, 14 Jul 2026 20:38:46 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.z168d0f9edf9bc766-tp.internal (19.141.142.34.bc.googleusercontent.com. [34.142.141.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31198cb2b99sm59100977eec.26.2026.07.14.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 20:38:46 -0700 (PDT)
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v5] hfs: port HFS+ b-tree bitmap corruption check
Date: Wed, 15 Jul 2026 03:38:29 +0000
Message-ID: <20260715033829.1698-1-aditya.ansh182@gmail.com>
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
 fs/hfs/btree.c             | 84 ++++++++++++++++++++++++++++++++++++++
 fs/hfs/btree.h             | 40 ++++++++++++++++++
 include/linux/hfs_common.h | 13 ++++--
 4 files changed, 134 insertions(+), 45 deletions(-)

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
index 2eb37a2f64e8..88810b1c90c3 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -15,6 +15,75 @@
 
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
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
@@ -23,6 +92,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct address_space *mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
+	struct hfs_bnode *node;
 	unsigned int size;
 	u16 dblock;
 	sector_t start_block;
@@ -155,6 +225,20 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
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

