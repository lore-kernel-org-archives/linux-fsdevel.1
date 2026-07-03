Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D31990C7
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 05:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055814; cv=none; b=KAjiDiUI5Z8nscnaGLTCyEjM5hSnorVgYShrGVcnBkVlcFnduRmnW17NTFfA1zPpfF1JOS93whoXV9BIGUEFsyShaWzzPaNDnTI5I+CtTmF+5g16fQGTCX7tY7E+CzO0HhOm2dh1LI9TAceXVh1TrqNmto13rp1fBLAevOgZBNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055814; c=relaxed/simple;
	bh=YfHUT/51C/G8HybR7+5gnb3uFvfE+SYPBQ+X0BnNrqE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yoqmbgz8X9GKxoaXMGFL6A7X2bwjtpYXtQQhqLFTsuXbah4mH6tYwMExDBbqEb8Fjrpk2rlGHwX7ctwxjIfaMOgo+kqvHxtunPwYZhoJSMdxbzl4JhCDqTjkIIlLs61SE0aozk1dYURU/YT29xI3v4dGNhz/bHMdb8Tn4PmoHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXiCbL6N; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXiCbL6N"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so169280a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 22:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783055802; x=1783660602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/g5oqTclMT+T1wVMz3AxcVhkZS5DAHk35im4ms5RkQY=;
        b=QXiCbL6Ntu7Fo1rw7bY0WUTfnJ+/xuSy75jOMdMTS4gGup6LQSBrLhu8nDNeGqQ3r/
         L0nJMXEf8RYfUzJOSSn9CBCntXRmOorzJGykEkyVsDPLqluXPruWY30e92Q9dHalpnE0
         ncc7XjnqVGLggNscvRK/83ZQwZyWA7TGRS8Ppg5v2IbouidKu+E8q7nzS0x+RJFWEy+t
         Si25FV2ftBFuAet9Om7Io+XjAcLUoWBUWMIQ6ktY0mFw/Li/9k3Vwi8taWnAn7PddRd1
         xpEQdisBIUiiUSHt4tslWn7QjkruK3OEXWcL0HbcQvjpj7AumrTjs9pjmw8/RjxBwm/P
         Hu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783055802; x=1783660602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/g5oqTclMT+T1wVMz3AxcVhkZS5DAHk35im4ms5RkQY=;
        b=GY6hCLGjrfGhjCQe/tjPZutUNWeHoRFWIwSnVsyrLbgz1zW3AirjXdFJH6Ifo0C+fD
         tX93GcKYIa3UJI3a2bXiuYoLaUREqR0iG8V8dqBmZpSFBBtaPX43eoruNCfmkPWal+5i
         DjFxemuC5WsePPo1i3UTxEjZSXqoNBIkHACxDKGzQRk/fsTROq7BcIBTU1xFfgtQ79uD
         uRfZYgLWdESoe2VoJjiKUyGTWkGKN+VHj8ngPEGkjeUznaWWQva2Z06CbhZIBAuzd7lE
         z3kxIPfGD4mNn+OvS8WKe2S78Hz6C86fFBu3l+R7tuRPlsZ06PQwVj3ZY6ZhucohkDaC
         tA5A==
X-Forwarded-Encrypted: i=1; AHgh+RpO5BR4uS43UgDa/B6aLgOdMijnSmbeb+E3nTjmM0zZ/1VDnwFoJR8HNm5fdE07uS29uXQLyzf32xl0Gk5M@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlf3R729SxczFJST1uIkw/aFiaVnokW8bqRZ5hJdKmLXzhhaCg
	kP00mixHxMvM742GesEu+GS41nauhRF+vRRWLvbrtJynBiJXLIuZkN4x
X-Gm-Gg: AfdE7cmpVzDcUOZnF8O/2tpNCyChILj+w4Kl9kLjfhQSYSa/aA411Kbcv0AYHBS5mYT
	3GyPNGxN0QP0fGCSGk5VWIbsTw5cDXeoNeAavmnz8PQdn1/cBCcY2JOCm2ncJilx3u0xFG5amwO
	oDKxsOwz/+tJDJKTfc8qfKduGip3FOjaZNrcmq+u/vu+mjU29EiUGY97tbyHGNXHF9E+mBmfWH6
	RlGliMTxqQfDmi98apBoXv1fYw9Byqf5h7sZzJxSX1hNe9lQE8fiVgmLnQyQnI9Uysx5T1E4lt2
	NdT/hROybpCiBjuCHft9R+D6AmOg43cNRmBaR4szWbBczeQxgmMfy8cEJqOVVky6LUUObOEXD1n
	vJSvpiXl76rWI206Td5hXPknFxTnbkoKQ3/cckhXyGMZi2SBgHLui/igh77r4ggRhKX0PVZcyCK
	w8p8qF7lMrr9nlmXCopoUEqFe9cexNfm9BYkmnk5gmHKMpxD3+VYMcqHcFwJVOpMBpDbbf6/WCw
	xnQpdNWhLMOXT/U1EMdz4qnJ1YJ7ip6x/6xG2mAvcRFaG1LLYcr4lfhQmlrVdQHwN6csq7PY3kB
	IiV7g+fUzHW2Tv1Rtutzr5hSEhH9cpEndg==
X-Received: by 2002:a17:90b:3cce:b0:380:9ef6:e8cc with SMTP id 98e67ed59e1d1-380aa07e1f3mr9139156a91.5.1783055802297;
        Thu, 02 Jul 2026 22:16:42 -0700 (PDT)
Received: from cs-1047136853211-default.asia-southeast1-a.c.d33bddc1d573818c7-tp.internal (213.28.87.34.bc.googleusercontent.com. [34.87.28.213])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127cf2ba7sm412485a91.16.2026.07.02.22.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 22:16:41 -0700 (PDT)
From: Aditya Srivastava <aditya.ansh182@gmail.com>
To: slava@dubeyko.com
Cc: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Subject: [PATCH v2] hfs: port HFS+ b-tree bitmap corruption check
Date: Fri,  3 Jul 2026 05:16:17 +0000
Message-ID: <20260703051617.1832-1-aditya.ansh182@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>

In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
verifies that the allocation map bit for the tree header (node 0) is
set. If not, it indicates a corrupted map record/bitmap and mounts
the volume as read-only (SB_RDONLY) to prevent further damage.

HFS filesystems share the same b-tree structure but currently lack
this corruption detection check.

Port this check to HFS, aligning its implementation with HFS+ to
maintain consistent b-tree logic across both filesystems:
1. Define struct hfs_bmap_ctx and the relevant map record indices.
2. Port hfs_bmap_get_map_page() and the necessary offset and length
   validation helpers.
3. Implement hfs_bmap_test_bit() to inspect the B-tree bitmap using the
   new get_map_page helper.
4. In hfs_btree_open(), retrieve the header node via hfs_bnode_find(),
   test its allocation bit with hfs_bmap_test_bit(), and release it
   using hfs_bnode_put().

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Link: https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com/T/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
---
Changes in v2:
- Port struct hfs_bmap_ctx and hfs_bmap_get_map_page() helpers to
  fs/hfs/btree.c, keeping HFS and HFS+ logic unified and easy to
  library-ize.
- Re-implement hfs_bmap_test_bit() to take struct hfs_bnode and
  node_bit_idx, matching HFS+ perfectly.
- In hfs_btree_open(), use hfs_bnode_find() to retrieve the header
  node and put it safely after the bitwise verification check.

 fs/hfs/btree.c | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfs/btree.h |  2 ++
 2 files changed, 98 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e8..36dc8735d01a 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -23,6 +23,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	struct address_space *mapping;
 	struct folio *folio;
 	struct buffer_head *bh;
+	struct hfs_bnode *node;
 	unsigned int size;
 	u16 dblock;
 	sector_t start_block;
@@ -155,6 +156,20 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 	kunmap_local(head);
 	folio_unlock(folio);
 	folio_put(folio);
+
+	node = hfs_bnode_find(tree, 0);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	if (!hfs_bmap_test_bit(node, 0)) {
+		pr_warn("(%s): %s (cnid 0x%x) map record invalid or bitmap corruption detected, forcing read-only.\n",
+			sb->s_id, id == HFS_EXT_CNID ? "extents" : "catalog", id);
+		pr_warn("Run fsck.hfs to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
+	hfs_bnode_put(node);
+
 	return tree;
 
 fail_folio:
@@ -356,6 +371,87 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree)
 	}
 }
 
+struct hfs_bmap_ctx {
+	unsigned int page_idx;
+	unsigned int off;
+	u16 len;
+};
+
+#define HFS_BTREE_HDR_MAP_REC_INDEX	2
+#define HFS_BTREE_MAP_NODE_REC_INDEX	0
+
+static inline bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
+{
+	return off < node->tree->node_size;
+}
+
+static inline u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
+{
+	if (off >= node->tree->node_size)
+		return 0;
+	if ((u64)off + len > node->tree->node_size)
+		return node->tree->node_size - off;
+	return len;
+}
+
+static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
+					  struct hfs_bmap_ctx *ctx,
+					  u32 byte_offset)
+{
+	u16 rec_idx, off16;
+	unsigned int page_off;
+
+	if (node->this == 0) {
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
+bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
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
index 99be858b2446..86036e18095f 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -93,6 +93,8 @@ extern void hfs_btree_write(struct hfs_btree *tree);
 extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes);
 extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
 extern void hfs_bmap_free(struct hfs_bnode *node);
+struct hfs_bmap_ctx;
+extern bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx);
 
 /* bnode.c */
 extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
-- 
2.47.3

