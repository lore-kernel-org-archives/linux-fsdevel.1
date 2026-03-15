Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A443750BD;
	Sun, 15 Mar 2026 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773595277; cv=pass; b=bL3pDPBvrKarxVhL6OkVAHx1cip3GdAOtRYFH57v4jZs1dURL1hKwgyu5zaDAVwcIcVnl+Sv7g0hSZD3yjl2kmCfURv4x3uqlHrMrzWWia5UxD3XiFcyJhs6CwqMgh3aN7UGZSYHFrjyZMll6dOB4UKEGuVHWfxclWFeh2ZTeyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773595277; c=relaxed/simple;
	bh=lT7fXzTutYb0UPeQImizyby4kS9kkDBcn3pi9PHwKxc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rYBN9ljUQsVMZl5Cocw5kmz9RS1fkCaATPl3dWaeB0T0m65yomEo+LCdmpNtuvXasP4ec2ZZhFhKbsPz89tbQLp5rDrRiChv7CI+QsY28ySI7tJJlr3Ajb1s0CdTqdfVEqW3SJ6/dc9v4Efts3Onb5Fbpw4Lq7Uapa7MicqbVLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=m2bWRhPw; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="m2bWRhPw"
ARC-Seal: i=1; a=rsa-sha256; t=1773595249; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=I5c/tgzCfDOm1eVrnqewxZEOQ12IzBEIuQBtogAYazPK9Z5AOo247ISSO1gZbkMp1fJjBCtMHRL13R9CA0IjDLgHblRaDDnh9QPGq8Mv2ZB01F0FDYqy9lNS+CkVqrS8gVqzdW9PHtH4qHIbecDnNeFGnDTjPuMumeFl3tjHheg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773595249; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6sFzETCS6hUM9s0yi8pOyJ30HDRj5FAXxqfq7AJRpAM=; 
	b=Sq0kRR9jEIRPW60RCmARE9o009sI7wwFBaqC9r8/qf17QBo/W2c1VW6Liuq/MLHIoIFEaqBI1414RCAnL9kGApAVF/MKq7a35e96tFMfP0Zw1LevpeeYUbdSmEu0apOdxafQdcUYlEPztLGKCjm2mJQz8pWMEAI/ELsM9LLgBbc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773595249;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=6sFzETCS6hUM9s0yi8pOyJ30HDRj5FAXxqfq7AJRpAM=;
	b=m2bWRhPwEJxdHrJC7XHV+YHZuOrfVxUusXs4LjqU1x9JIsBhiK3daXBEYd22Sd3X
	jqoGCsJoCXvVc11VMaUnrZTeXc+fK7zrxukWe5g58RZbjwT6Rc91HjmP/NeezJVLhq2
	JTbNK1Nm8sapjUPYGw6A3AgJMWmougSJC+D4Z8IU=
Received: by mx.zohomail.com with SMTPS id 1773595247002578.980240420513;
	Sun, 15 Mar 2026 10:20:47 -0700 (PDT)
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: janak@mpiricsoftware.com,
	janak@mpiric.us,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Subject: [PATCH v6 2/2] hfsplus: validate b-tree node 0 bitmap at mount time
Date: Sun, 15 Mar 2026 22:50:05 +0530
Message-Id: <20260315172005.2066677-3-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
References: <20260315172005.2066677-1-shardul.b@mpiricsoftware.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Syzkaller reported an issue with corrupted HFS+ images where the b-tree
allocation bitmap indicates that the header node (Node 0) is free. Node 0
must always be allocated as it contains the b-tree header record and the
allocation bitmap itself. Violating this invariant leads to allocator
corruption, which cascades into kernel panics or undefined behavior when
the filesystem attempts to allocate blocks.

Prevent trusting a corrupted allocator state by adding a validation check
during hfs_btree_open(). Introduce the hfs_bmap_test_bit() helper
(utilizing the newly added map-access API) to safely verify that the MSB
of the first bitmap byte (representing Node 0) is marked as allocated.

If corruption is detected (either structurally invalid map records or an
illegally cleared bit), print a warning identifying the specific
corrupted tree and force the filesystem to mount read-only (SB_RDONLY).
This prevents kernel panics from corrupted images while enabling data
recovery.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/20260228122305.1406308-1-shardul.b@mpiricsoftware.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 1c6a27e397fb..7c98b5858f99 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -185,6 +185,32 @@ static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node, struct hfs_bma
 	return node->page[ctx->page_idx];
 }
 
+/**
+ * hfs_bmap_test_bit - test a bit in the b-tree map
+ * @node: the b-tree node containing the map record
+ * @node_bit_idx: the relative bit index within the node's map record
+ *
+ * Returns 1 if set, 0 if clear, or a negative error code on failure.
+ */
+static int hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
+{
+	struct hfs_bmap_ctx ctx;
+	struct page *page;
+	u8 *bmap, byte, mask;
+
+	page = hfs_bmap_get_map_page(node, &ctx, node_bit_idx / BITS_PER_BYTE);
+	if (IS_ERR(page))
+		return PTR_ERR(page);
+
+	bmap = kmap_local_page(page);
+	byte = bmap[ctx.off];
+	kunmap_local(bmap);
+
+	mask = 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
+	return (byte & mask) ? 1 : 0;
+}
+
+
 /**
  * hfs_bmap_clear_bit - clear a bit in the b-tree map
  * @node: the b-tree node containing the map record
@@ -218,15 +244,36 @@ static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 node_bit_idx)
 	return 0;
 }
 
+#define HFS_EXTENT_TREE_NAME  "Extents"
+#define HFS_CATALOG_TREE_NAME "Catalog"
+#define HFS_ATTR_TREE_NAME    "Attributes"
+#define HFS_UNKNOWN_TREE_NAME "Unknown"
+
+static const char *hfs_btree_name(u32 cnid)
+{
+	switch (cnid) {
+	case HFSPLUS_EXT_CNID:
+		return HFS_EXTENT_TREE_NAME;
+	case HFSPLUS_CAT_CNID:
+		return HFS_CATALOG_TREE_NAME;
+	case HFSPLUS_ATTR_CNID:
+		return HFS_ATTR_TREE_NAME;
+	default:
+		return HFS_UNKNOWN_TREE_NAME;
+	}
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 {
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
+	struct hfs_bnode *node;
 	struct inode *inode;
 	struct page *page;
 	unsigned int size;
+	int res;
 
 	tree = kzalloc_obj(*tree);
 	if (!tree)
@@ -331,6 +378,26 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	kunmap_local(head);
 	put_page(page);
+
+	node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	res = hfs_bmap_test_bit(node, 0);
+	if (res < 0) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) map record invalid/corrupted, forcing read-only.\n",
+				sb->s_id, hfs_btree_name(id), id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	} else if (res == 0) {
+		pr_warn("(%s): %s Btree (cnid 0x%x) bitmap corruption detected, forcing read-only.\n",
+				sb->s_id, hfs_btree_name(id), id);
+		pr_warn("Run fsck.hfsplus to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
+	hfs_bnode_put(node);
+
 	return tree;
 
  fail_page:
-- 
2.34.1

