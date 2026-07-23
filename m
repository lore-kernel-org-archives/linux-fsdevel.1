Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CEA3CAA55
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 06:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784788762; cv=none; b=mT2x6bkWsxSNrFAsQs0zt0fYMiOxU+Oux6IgQ7eJSXVleR0+dUDioq//QqGXcFINdZ+uyKF1ATelBezgGTqfHdKpdmLzzRrQHbk6nS76N56jHVbZSG9usQt/J8oogxVrI9/j6ingQ+t6HXfWKdzLsTSI9ucPHqb4fQEU/IGvSSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784788762; c=relaxed/simple;
	bh=/0HwtvNp/9LvmQragxj3efo4Ptadjv76oHlqVj9EYjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GbWwVzYcG13Xz1vs88fyxrRvDknUzecJTKbAyPYCcc2LgYKmq/op/hyG6rTFWaHlwPHL9iZ+O8rOLzO0ehMvsdSzw6VTR9Z+cw090BeWU8LnblCsffMuJPFj5SGHfPrIp5tFkNQCxqgz6r96ygEx/5hIt0S7/+RdXULRdf2FoVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n454Wbvd; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n454Wbvd"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-84830c774a0so286046b3a.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 23:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784788760; x=1785393560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uDhsKqXuqVQPpqbwNUDTPQFZ//zpU3w2f5MZYDjLQvg=;
        b=n454Wbvde9YsQK6ZW5NzRWWiLPW87okr/kwuMbIhZBitBH8UqOBkLoFm+mrMaOw4nZ
         DMdZxSzFYA/d0+KCl2qJK9lcyOe/BHp+ccNPoFLZBe86yC3PVF7QSbv2CjGjyHYWmiZ6
         dN77FIUF3vjU+6EllMxhT1H04NthN3h9Erfvjm8/3Gks/OJp2TT/Vek2tDbnuBo8x0DY
         cOhek0v4LDF0KpFXejVPtXdfgflgvFJFc3rxOMY6oQQ+td6CrCEzv+MVFGZBordv619r
         lMSY/Sv+/LHS184WOuTM0jTVaBzBOjuVxhfT8aZeMSV6kvELiDAFeZdefh+DcjLkliVd
         hNKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784788760; x=1785393560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uDhsKqXuqVQPpqbwNUDTPQFZ//zpU3w2f5MZYDjLQvg=;
        b=O2lZOzfa5+avOlMcVMZOdRyD0SLewKn8pz9ZteEg3By9MNkzHmeMnLWDColl1ia2ss
         sJZ8RoiAseuBsZFyVlZK0E/RK2k6fr3INexyL2h7Zy8o2UNOWPF5NO/WTRw894fJ3xjK
         aVmu1PESDlRX/CYxlSDe7jxOlUy35RszL4XoFrXImwW3Ji8KkAVAUONQCjONfPMLOovM
         X+beNJyRKghEgffc7arCamzRVMszQx3Ff61+hC3iXSgAEIriE8ognuDkYLqq3fjFwqE5
         wseXmv/v3LGWo7p1ZLPcwsJtKeBqO06x3LvJedxmlY35ScoO9gyaLof5NR73zkH1+Ldb
         aBOg==
X-Forwarded-Encrypted: i=1; AHgh+RqeiTaflHPY9HOljBL7nbdNg46+h1xNGXB1BfRQ34SBTH7tqzSRMMkkWcGVW+9quFFfnwfOk54HYmQwWHTX@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFbAFgPJ8bpSlq7xLkyC4xsLLYeYd76ozoJwfqBkzjQCGY97p
	xpZjoKPwZseVJCewbxrXefWKJqJxyY+PjIF/bdAinfDG3Bus84QZAWXq
X-Gm-Gg: AR+sD138p6wWj2/3yrLfzUtgFNhqNDbNPmCzNpNfRLOnIx+OL9whOXWBoIm6M1dLhFi
	7ZzQmBTUzODXMUd5bAWPaDsR5hdjgZRKIqkqzRtHac2hmXKO0kNzYUaZwMiJBMYHDvj+rkxpv/J
	xGdJcmDg5qOmHP3fPGfUvmVkgn3O4rrUrDv9NbB1YNEC6MLyg7vW3D8tDgI06xoF7DN+OEigWwp
	gvADNHwsexNUGFjiFhXwQTnxrgEAYy797Q0BHbSzgud9aVrhjDZWV0eZZdyDFoAXOzgdWXJXS6M
	f/U3LDXq38YQCJdRrA6aewoXPS7z7NZojuVfEvfPmHo4Xs4YtV2Cvd+PsXw2lwC/63yVAUR/j94
	iCLUougBQoOfDTbgetXsqKAOQD2dNow3s1931qIHxI5sZhvp3HbL+yVPiF1x/6DXPOUGTbZ2U8J
	oszzRpXPIBxRgbgj6xeThiUHI=
X-Received: by 2002:a05:6a00:a229:b0:847:94bb:30db with SMTP id d2e1a72fcca58-84e2bb37412mr2405755b3a.49.1784788759316;
        Wed, 22 Jul 2026 23:39:19 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17574784sm2507076b3a.35.2026.07.22.23.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 23:39:18 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH v4] hfsplus: validate B-tree record offset table
Date: Thu, 23 Jul 2026 14:39:10 +0800
Message-ID: <20260723063910.765543-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3d0cb82335583659fa6d044bcf4b8083907712bc.camel@dubeyko.com>
References: <3d0cb82335583659fa6d044bcf4b8083907712bc.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A crafted HFS+ image can contain a corrupted B-tree node. The node descriptor
may contain a record count that does not fit in the node, and record offsets may
be unordered, unaligned, outside the node, or point into the offset table
itself.

Several B-tree helpers consume these on-disk fields before validating them:
hfs_bnode_dump() can walk past the offset table when num_recs is corrupted,
hfs_brec_lenoff() can produce an underflowed length or a record range that
overlaps the offset table. This can make the unlink/writeback path repeatedly
call hfs_bnode_read_u16() with invalid offsets while holding the HFS+ B-tree
lock, producing a flood of "requested invalid offset" messages. Other writeback
workers then block on tree->tree_lock and the system reports tasks hung in
hfsplus_write_inode().

Validate num_recs against the node size before walking the record offset table.
Reject record ranges that are unordered, unaligned, outside the node, or
overlapping the offset table. Reject invalid record indexes before reading their
offset entries, and avoid decrementing an already-zero leaf_count.
---
Changes in v4:
- Rename hfs_find_reset() to hfs_find_result_init().
- Reset find result fields in __hfs_brec_find().
- Move num_recs validation next to descriptor field initialization.
- Rename hfs_brec_range_valid() to hfs_brec_offpair_valid().
- Use U16_MAX for invalid offset/len/keylen sentinels and update callers.
- Add hfs_brec_len_valid() to check validity of len/keylen.
- Handle invalid B-tree map record lengths in hfs_bmap_get_map_page()
  and hfs_bmap_free().
- Return -EINVAL instead of -EIO for invalid remove cursor/leaf_count state.

Changes in v3:
- Drop the keylen == len check.
- Drop the explicit zero-record check in __hfs_brec_find().
- Move find cursor reset into hfs_find_reset() and call it from hfs_find_init() and hfs_brec_find().
- Rename helper-local variables as suggested.

 fs/hfsplus/bfind.c      | 21 +++++------
 fs/hfsplus/bnode.c      | 16 ++++++---
 fs/hfsplus/brec.c       | 43 ++++++++++++++--------
 fs/hfsplus/btree.c      | 11 ++++++
 fs/hfsplus/hfsplus_fs.h | 79 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 142 insertions(+), 28 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..301e653f029d 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -9,6 +9,7 @@
  * Search routines for btrees
  */
 
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include "hfsplus_fs.h"
 
@@ -18,6 +19,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
+	hfs_find_result_init(fd);
 	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
@@ -106,17 +108,20 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	u16 off, len, keylen;
 	int rec;
 	int b, e;
-	int res;
+	int res = -ENOENT;
 
 	BUG_ON(!rec_found);
+	hfs_find_result_init(fd);
+	if (!hfs_bnode_num_recs_valid(bnode))
+		goto fail;
+
 	b = 0;
 	e = bnode->num_recs - 1;
-	res = -ENOENT;
 	do {
 		rec = (e + b) / 2;
 		len = hfs_brec_lenoff(bnode, rec, &off);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		if (!hfs_brec_len_valid(len) || !hfs_brec_len_valid(keylen)) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -130,7 +135,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	if (rec != e && e >= 0) {
 		len = hfs_brec_lenoff(bnode, e, &off);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (!hfs_brec_len_valid(keylen) || !hfs_brec_len_valid(len)) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -158,11 +163,7 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
-	fd->record = -1;
-	fd->keyoffset = -1;
-	fd->keylength = -1;
-	fd->entryoffset = -1;
-	fd->entrylength = -1;
+	hfs_find_result_init(fd);
 
 	tree = fd->tree;
 	if (fd->bnode)
@@ -274,7 +275,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	len = hfs_brec_lenoff(bnode, fd->record, &off);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (!hfs_brec_len_valid(len) || !hfs_brec_len_valid(keylen)) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index d088fb7eb0df..e5babf3a03b7 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -352,15 +352,22 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 	struct hfs_bnode_desc desc;
 	__be32 cnid;
 	int i, off, key_off;
+	u16 num_recs;
 
 	hfs_dbg("node %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
+	num_recs = node->num_recs;
 	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs %d\n",
 		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
 		desc.type, desc.height, be16_to_cpu(desc.num_recs));
 
+	if (!hfs_bnode_num_recs_valid(node)) {
+		hfs_dbg("invalid num_recs %u\n", num_recs);
+		return;
+	}
+
 	off = node->tree->node_size - 2;
-	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
+	for (i = num_recs; i >= 0; off -= 2, i--) {
 		key_off = hfs_bnode_read_u16(node, off);
 		hfs_dbg(" key_off %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
@@ -561,6 +568,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 	node->height = desc->height;
 	kunmap_local(desc);
 
+	if (!hfs_bnode_num_recs_valid(node))
+		goto node_error;
+
 	switch (node->type) {
 	case HFS_NODE_HEADER:
 	case HFS_NODE_MAP:
@@ -586,9 +596,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 	for (i = 1; i <= node->num_recs; off = next_off, i++) {
 		rec_off -= 2;
 		next_off = hfs_bnode_read_u16(node, rec_off);
-		if (next_off <= off ||
-		    next_off > tree->node_size ||
-		    next_off & 1)
+		if (!hfs_brec_offpair_valid(node, off, next_off, rec_off))
 			goto node_error;
 		entry_size = next_off - off;
 		if (node->type != HFS_NODE_INDEX &&
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..42cc09aca80e 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -9,6 +9,8 @@
  * Handle individual btree records
  */
 
+#include <linux/limits.h>
+
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
 
@@ -20,41 +22,49 @@ static int hfs_btree_inc_height(struct hfs_btree *);
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
 {
 	__be16 retval[2];
-	u16 dataoff;
+	u16 data_off;
+	u16 next_off;
+
+	if (!hfs_brec_record_valid(node, rec)) {
+		*off = U16_MAX;
+		return U16_MAX;
+	}
 
-	dataoff = node->tree->node_size - (rec + 2) * 2;
-	hfs_bnode_read(node, retval, dataoff, 4);
+	data_off = node->tree->node_size - (rec + 2) * 2;
+	hfs_bnode_read(node, retval, data_off, 4);
 	*off = be16_to_cpu(retval[1]);
-	return be16_to_cpu(retval[0]) - *off;
+	next_off = be16_to_cpu(retval[0]);
+	if (!hfs_brec_offpair_valid(node, *off, next_off, data_off)) {
+		*off = U16_MAX;
+		return U16_MAX;
+	}
+	return next_off - *off;
 }
 
 /* Get the length of the key from a keyed record */
 u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 {
-	u16 retval, recoff;
+	u16 retval, recoff, len;
 
 	if (node->type != HFS_NODE_INDEX && node->type != HFS_NODE_LEAF)
 		return 0;
+	if (!hfs_brec_record_valid(node, rec))
+		return U16_MAX;
 
 	if ((node->type == HFS_NODE_INDEX) &&
 	   !(node->tree->attributes & HFS_TREE_VARIDXKEYS) &&
 	   (node->tree->cnid != HFSPLUS_ATTR_CNID)) {
 		retval = node->tree->max_key_len + 2;
 	} else {
-		recoff = hfs_bnode_read_u16(node,
-			node->tree->node_size - (rec + 1) * 2);
-		if (!recoff)
-			return 0;
-		if (recoff > node->tree->node_size - 2) {
-			pr_err("recoff %d too large\n", recoff);
-			return 0;
-		}
+		len = hfs_brec_lenoff(node, rec, &recoff);
+		if (!hfs_brec_len_valid(len))
+			return len;
 
 		retval = hfs_bnode_read_u16(node, recoff) + 2;
 		if (retval > node->tree->max_key_len + 2) {
 			pr_err("keylen %d too large\n",
 				retval);
-			retval = 0;
+			retval = U16_MAX;
 		}
 	}
 	return retval;
@@ -185,10 +195,15 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	tree = fd->tree;
 	node = fd->bnode;
 again:
+	if (!hfs_brec_record_valid(node, fd->record))
+		return -EINVAL;
+
 	rec_off = tree->node_size - (fd->record + 2) * 2;
 	end_off = tree->node_size - (node->num_recs + 1) * 2;
 
 	if (node->type == HFS_NODE_LEAF) {
+		if (tree->leaf_count == 0)
+			return -EINVAL;
 		tree->leaf_count--;
 		mark_inode_dirty(tree->inode);
 	}
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 394542a47e60..85ba6cf1a803 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -12,6 +12,7 @@
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/log2.h>
+#include <linux/limits.h>
 
 #include "hfsplus_fs.h"
 #include "hfsplus_raw.h"
@@ -168,6 +169,8 @@ static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
 	}
 
 	ctx->len = hfs_brec_lenoff(node, rec_idx, &off16);
+	if (ctx->len == U16_MAX)
+		return ERR_PTR(-EINVAL);
 	if (!ctx->len)
 		return ERR_PTR(-ENOENT);
 
@@ -622,6 +625,10 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	if (IS_ERR(node))
 		return;
 	len = hfs_brec_lenoff(node, 2, &off);
+	if (!hfs_brec_len_valid(len)) {
+		hfs_bnode_put(node);
+		return;
+	}
 	while (nidx >= len * 8) {
 		u32 i;
 
@@ -648,6 +655,10 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			return;
 		}
 		len = hfs_brec_lenoff(node, 0, &off);
+		if (!hfs_brec_len_valid(len)) {
+			hfs_bnode_put(node);
+			return;
+		}
 	}
 
 	res = hfs_bmap_clear_bit(node, nidx);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..41d1e24309d4 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -16,6 +16,7 @@
 #include <linux/buffer_head.h>
 #include <linux/blkdev.h>
 #include <linux/fs_context.h>
+#include <linux/limits.h>
 #include "hfsplus_raw.h"
 
 /* Runtime config options */
@@ -587,6 +588,84 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 	return is_valid;
 }
 
+static inline
+bool hfs_bnode_num_recs_valid(struct hfs_bnode *node)
+{
+	u32 node_size;
+	u32 table_size;
+	u32 area_size;
+	u32 rec_size = sizeof(__be16);
+	u32 desc_size = sizeof(struct hfs_bnode_desc);
+
+	if (!node || !node->tree)
+		return false;
+
+	node_size = node->tree->node_size;
+	if (node_size < desc_size)
+		return false;
+
+	area_size = node_size - desc_size;
+	table_size = ((u32)node->num_recs + 1) * rec_size;
+
+	return table_size <= area_size;
+}
+
+static inline
+bool hfs_brec_record_valid(struct hfs_bnode *node, int record)
+{
+	if (!hfs_bnode_num_recs_valid(node))
+		return false;
+	if (record < 0)
+		return false;
+
+	return record < node->num_recs;
+}
+
+static inline
+bool hfs_brec_offpair_valid(struct hfs_bnode *node, u16 off, u16 next_off,
+							u16 rec_off)
+{
+	u32 table_size;
+	u32 table_start;
+	u32 rec_size = sizeof(__be16);
+	u32 desc_size = sizeof(struct hfs_bnode_desc);
+
+	if (!node || !node->tree)
+		return false;
+
+	if (off < desc_size || (off & 1))
+		return false;
+
+	if (next_off <= off ||
+	    next_off > node->tree->node_size ||
+	    next_off > rec_off ||
+	    (next_off & 1))
+		return false;
+
+	table_size = ((u32)node->num_recs + 1) * rec_size;
+	table_start = node->tree->node_size - table_size;
+	if (next_off > table_start)
+		return false;
+
+	return true;
+}
+
+static inline
+bool hfs_brec_len_valid(u16 len)
+{
+	return len != U16_MAX && len != 0;
+}
+
+static inline
+void hfs_find_result_init(struct hfs_find_data *fd)
+{
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+}
+
 static inline
 u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 {
-- 
2.43.0
