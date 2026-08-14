Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398BC3D3D16;
	Fri, 14 Aug 2026 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786674717; cv=none; b=WHXp1dozcksEWIeDgNoPJVd7+SYr/N8/0hCziht03oy8fpUwvgaQkfOojG+doIA2kBDox2ZbH0rG2Qks3xvaJir5oZXfIaaUwxNR7crF0xBl16oUF+L81kpwIACXIHE6UryR//squPBZfR5hhurfjhxow43tepsHEA83+FEk9d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786674717; c=relaxed/simple;
	bh=HVNN53PvjMc6+P3LJmQhY+c/XRI9+JOUtheL/kQoy3I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bFePg4YPse4lkMw4PcY7QaBh/rdyxxHSZ060ACCNmbO5iWOXRjsi7F9DGK9OavwI1aqHX63QmwVbp9SO0971ktHhMIklvH5K/Pd8DLXcRsXtzl22qukzmDO8YmIX5y+BU83a3ato7aHZpkqKndm36LG/jeIWeALBru0PB/pAZB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K7j7+EE6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K7j7+EE6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786674715; x=1818210715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HVNN53PvjMc6+P3LJmQhY+c/XRI9+JOUtheL/kQoy3I=;
  b=K7j7+EE6rAdLmjq9ZZ9808HDSzKc3WwfOZMaIqd1B8ljc5DNW9kXtJfz
   LnJMsGGjGNqqw+TOhzpZyTPRFPL6JOJ8nuhUosYGVdPKh2OPMmQSEkHC6
   6fvY+hSJU2qEo7jWh8MJkmJGEdT3/ler0e6ebYGQ+89+4GDy7D/BYY2sl
   P8p9PWTBRz1OT1HvFWYg0/i7ytGic+kHqVRcALJT0QcamoNt4jen+wRsl
   QwhBaWwV/OT8CRIs1i/A5B+axsDgYVAjvrqxOcmnCdrsEVsj5gQ66kUFq
   OOqPqw3AT6c4sSeSF8IPrzqvwL+T3E9QsPlsSEMcx4ljVWN4U63DIAEp3
   A==;
X-CSE-ConnectionGUID: avJRTz4bSIS5EUdjBf7sRw==
X-CSE-MsgGUID: 15nC+3+aToeCz8fZzT/V8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="87181988"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="87181988"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2026 19:31:55 -0700
X-CSE-ConnectionGUID: fi4IclvAS+mLSJaJzTuXLQ==
X-CSE-MsgGUID: qN0HOCWCSX6iDAEq/Sa0Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="302339622"
Received: from tester.sh.intel.com ([10.112.106.126])
  by orviesa001.jf.intel.com with ESMTP; 13 Aug 2026 19:31:54 -0700
From: Tao Yu <tao1.yu@intel.com>
To: linux-fsdevel@vger.kernel.org
Cc: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-kernel@vger.kernel.org,
	syzbot+2bf21610eea63cb2ce93@syzkaller.appspotmail.com,
	Tao Yu <tao1.yu@intel.com>
Subject: [PATCH 1/2] hfs: detect node 0 btree map corruption at mount time
Date: Fri, 14 Aug 2026 10:31:49 +0800
Message-Id: <20260814023150.3482810-2-tao1.yu@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260814023150.3482810-1-tao1.yu@intel.com>
References: <20260814023150.3482810-1-tao1.yu@intel.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HFS+ already validates that the btree map keeps node 0 marked as in-use
when the tree is opened. HFS lacks the same check, so a corrupted volume
can proceed past mount with a broken node bitmap and only fail later in
write paths.

Port the node 0 bitmap validation to HFS. If the header node is not
marked as allocated in the on-disk map, warn that the btree bitmap is
corrupted and force the filesystem read-only so users can repair it with
fsck.hfs.

This keeps the HFS mount-time behavior aligned with HFS+ and catches the
corruption closer to where it becomes observable.

Signed-off-by: Tao Yu <tao1.yu@intel.com>
---
 fs/hfs/btree.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 2eb37a2f64e86..14114318ec724 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -15,12 +15,59 @@
 
 #include "btree.h"
 
+static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
+{
+	u16 rec_idx, off, len;
+	u32 byte_offset;
+	u8 byte, mask;
+
+	if (node->this == 0) {
+		if (node->type != HFS_NODE_HEADER) {
+			pr_err("hfs: invalid btree header node\n");
+			return false;
+		}
+		rec_idx = 2;
+	} else {
+		if (node->type != HFS_NODE_MAP) {
+			pr_err("hfs: invalid btree map node\n");
+			return false;
+		}
+		rec_idx = 0;
+	}
+
+	len = hfs_brec_lenoff(node, rec_idx, &off);
+	if (!len)
+		return false;
+
+	byte_offset = node_bit_idx / BITS_PER_BYTE;
+	if (byte_offset >= len)
+		return false;
+
+	byte = hfs_bnode_read_u8(node, off + byte_offset);
+	mask = 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
+
+	return byte & mask;
+}
+
+static const char *hfs_btree_name(u32 cnid)
+{
+	switch (cnid) {
+	case HFS_EXT_CNID:
+		return "Extents Overflow File";
+	case HFS_CAT_CNID:
+		return "Catalog File";
+	default:
+		return "Unknown B-tree";
+	}
+}
+
 /* Get a reference to a B*Tree and do some initial checks */
 struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp keycmp)
 {
 	struct hfs_btree *tree;
 	struct hfs_btree_header_rec *head;
 	struct address_space *mapping;
+	struct hfs_bnode *node;
 	struct folio *folio;
 	struct buffer_head *bh;
 	unsigned int size;
@@ -155,6 +202,19 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
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
+			sb->s_id, hfs_btree_name(id), id);
+		pr_warn("Run fsck.hfs to repair.\n");
+		sb->s_flags |= SB_RDONLY;
+	}
+
+	hfs_bnode_put(node);
 	return tree;
 
 fail_folio:
-- 
2.34.1

