Received: from sender4-of-o54.zoho.com (sender4-of-o54.zoho.com [136.143.188.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D536BCD5;
	Wed, 18 Mar 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819573; cv=pass; b=O4KPA5nnM3RTXqBCjL4JOHgXALHgH4cpszU35oN0j6A2J/24hRVnFa+3MxWGvJ6KrTroHS6GQQp28SHWugmKWZ8XHtp76bFco3OKZLPXF4mnHVs7uCWmQrAFO8rm/NZpYEVspxNneLz7RXnNueI3scLi0WFmhk8gce56GM97Ii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819573; c=relaxed/simple;
	bh=h72dNGgqhk1G0IghvxUcYfOZ685gXKT8AD/e09cMrI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OYxHB2NSBMJG23dsGYY0dzCKzd9buTn908yuUUlAldCc7eHIPMM7bw2hvIOrhtX8dIPej+eUz2RMiDFTlSIJ/VtXF2olWbesl4RidwHIt1MYPgKZ2z4NQsseGZMy3Jn0Z4dIl7qjoAXdVi0Yy4gnfDnMGMJx/+NqwtsN7SaFZGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=W8b95eXt; arc=pass smtp.client-ip=136.143.188.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="W8b95eXt"
ARC-Seal: i=1; a=rsa-sha256; t=1773819523; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WB2EqjCOmEF810jaboTY0i+/NAzKYa+Q7Oo81+apc2R7mgoZJ0M+2VjYt4eAkgQ8ouSryhQ9nEnTOwKvYGlTiKyipLkQEpx4AVc+ZiYJBTwxmvLs1WJciPpc8xGea27tnqPesoMHKrtUwKWqoVBJsHaWKGU7OChqKIA22sR64Uk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773819523; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LCnT2uWy60WrFcN45C+ke4n0VxQX6V+FIJZ20t59Xz4=; 
	b=kiPrO5T8Q9dKlO5cR24rWMbG41Z2MRs5cfxcDS35ZI/6VQxHQ78RG9UTYZYDYoip8ZFYygZmWGBE7TBFhQV/EU1/RCrM5aeruSCw6W/WK9digThfPmFGd7N1qaJxU83Npmf+xxXWLQ1hXQbSaJ4mSEiguHvpxqlWp7htz7MzgVA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773819523;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=LCnT2uWy60WrFcN45C+ke4n0VxQX6V+FIJZ20t59Xz4=;
	b=W8b95eXtYyxidS8chEU35LABgeRctwlHgAGNweJA1i2EKTCUelUHTq9fvCD+CiMS
	KlMTn6y/3yUjO9LP1ko0Q94lBtnGwKVU/hyvVyPahJwb0l6UujM/ROks5HhqgaR/yje
	XflwUgSV93F2iGNRLd13++jC5nPFm8hCKIBi7Dkc=
Received: by mx.zohomail.com with SMTPS id 1773819521713519.8621537982034;
	Wed, 18 Mar 2026 00:38:41 -0700 (PDT)
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
Subject: [PATCH v7 2/2] hfsplus: validate b-tree node 0 bitmap at mount time
Date: Wed, 18 Mar 2026 13:08:23 +0530
Message-Id: <20260318073823.3933718-3-shardul.b@mpiricsoftware.com>
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
The helper returns a boolean, allowing the caller to safely catch both
structural IO errors and illegally cleared bits in a single check.

If corruption is detected, print a warning identifying the specific
corrupted tree and force the filesystem to mount read-only (SB_RDONLY).
This prevents kernel panics from corrupted images while enabling data
recovery.

As a minor cleanup to support the warning logs, replace the verbose CNID
logic with cleaner macro definitions (using official structural names like
"Extents Overflow File") and a dedicated string lookup helper.

Reported-by: syzbot+1c8ff72d0cd8a50dfeaa@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=1c8ff72d0cd8a50dfeaa
Link: https://lore.kernel.org/all/20260315172005.2066677-1-shardul.b@mpiricsoftware.com/
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
 fs/hfsplus/btree.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 64d168347b4b..04304f952f6b 100644
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
+
 /**
  * hfs_bmap_clear_bit - clear a bit in the b-tree map
  * @node: the b-tree node containing the map record
@@ -218,12 +244,32 @@ static int hfs_bmap_clear_bit(struct hfs_bnode *node, u32 node_bit_idx)
 	return 0;
 }
 
+#define HFS_EXTENT_TREE_NAME  "Extents Overflow File"
+#define HFS_CATALOG_TREE_NAME "Catalog File"
+#define HFS_ATTR_TREE_NAME    "Attributes File"
+#define HFS_UNKNOWN_TREE_NAME "Unknown B-tree"
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
@@ -331,6 +377,20 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	kunmap_local(head);
 	put_page(page);
+
+	node = hfs_bnode_find(tree, HFSPLUS_TREE_HEAD);
+	if (IS_ERR(node))
+		goto free_inode;
+
+	if (!hfs_bmap_test_bit(node, 0)) {
+		pr_warn("(%s): %s (cnid 0x%x) map record invalid or bitmap corruption detected, forcing read-only.\n",
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

