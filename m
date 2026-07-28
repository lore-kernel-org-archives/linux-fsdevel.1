Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E2F41E6BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233589; cv=none; b=Nq8MZ8A0MehbQ67a8gy0l++sGahrytub4D7T2KloivsxvssFMNdvBovD2nyJxUkOFa5POOiTecNbR+96djf+1MgcJIPSyjVIrPamSYVNByZKzMWyZGAFyx8VdovhQhqAYdUG+/zq1KOLBEwrM4AFd6fY8QK+3E8HGJyAPMJDwGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233589; c=relaxed/simple;
	bh=Sby7tDwFKim70vt+r4pqB26OQ0iuEGVY39cbKs9v64E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=krByYTACnLv+BlznVoKzubNbnILlHabggCjAMwZIOAiJ7oabrBf3odFDfgCtL1JeFNl1jBSVy4GKIdnqfmUNXpAIyRQ8qShnSAMJe5GiK5zikB3FpvjnqqC8lRYNjTOX6vHli2prjti2tjrwsuLaTrGVihyNFhfNowGJZxa8Das=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L1HnlumT; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L1HnlumT"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-381b831d535so4550462a91.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jul 2026 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785233587; x=1785838387; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqToUanNcoxgdPGnP6L2ES3skdGNC55WuoyxAPPxbpo=;
        b=L1HnlumTgCigECJtkZXdN49vMcjRozYMzpCQGxCl1c4kb5C9nCMlgjYamxmYuhBZNv
         vAiRUtmy2u1JzcU+Ijx5dnHJnzxhf6sn4nD5uLnQBvcGJZ2B8IGjhmRYnYqRV+Ya4BDT
         VM4CRaXUb9oSy1tAMJi1PKUbK46gY3WeBOMq/PLgbu5AJtK1XmoWfUOUsKfw/bqhG9Tn
         BPitUbdbITWw7PPs8Ko+ZoIxhGDTxFk3eXB1r20UGk7qGoQ6tuGISCsVYC29MYRYIsU7
         HFAc1dT8JR3ua0PitDoxpninly9IWtKCGRF/aYcaDVF4MCLaxoxl8eTciIUUca24etTX
         a4/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785233587; x=1785838387;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hqToUanNcoxgdPGnP6L2ES3skdGNC55WuoyxAPPxbpo=;
        b=SgYXccW2BcyfoFewRv01dQ4z9AkdDOZtYXOcZWeOEMMvrXXmzM1HBmS/+f+uQphN2C
         Z6o6p8BLFOedpXo+7g4sUzUUzbrQtF3JtWkeADWr8yoBmO21Y60m6poqjtCkXeoKBfZR
         /FywdS1MYgM2sGyUxwVF6QTcu37Vga9Ezcu9OeRLCy2/fwXp6547z/PIxKahMI5aOmUC
         sd+O7G6delQ7CLadZ/Wnp0T5DVNy2ZPkoS+dkmXY+5KpcOooJlbkiKVOA2RbQrtmAckn
         1e+plh2NmktEn33HMPzt8qFJSHP3GsN8IDLso3NpWy7g0nSu81+8TkUjvhgm9B01td1R
         eufg==
X-Forwarded-Encrypted: i=1; AHgh+RowfG0lW4IfGNrNpQ/cKPOqG2zPywGmg6fw9wQDkDuRgqgBipn1U02n63vYlj9S+VktOh171GrFcOdewgqG@vger.kernel.org
X-Gm-Message-State: AOJu0YyUcEhGNpNuCK+U7ARZuCZ5aXP/cK0AGtBXwmb3fTxUcOB79EFq
	pLnKTgQIUVSPEexF2+8//oOfb7BfnWUBwg7AdBo/Od5jGEGmKFezJ1RZxmT0Mw==
X-Gm-Gg: AR+sD11S0STa65dZrQvNNnPbpe0qHdEb+bFzdHDeP9ykgvADTy7LxbJQ1YxFfBctAqY
	bPDiexOyUh3GsyCzgWAPQZDOSef3/XCeC4xSyIYC9FoWf2PX3qWlkUCswcvA21PVxuklbU8jiu4
	pP9DB2RbdXrxD+B4MKN14JCP2CbueFtIHa952vwNEWwHGWa2qLObMHXG+NVUTYmgH0JsT5+KRTc
	PejxrUJqBV1WmHA+AE/NplC9FpDJl1Kigw2xikJSlezoW2ZdD2M/9zh8JH9XllO7k9KltgmMKZC
	0BAEdn4PQplkCeV6AxDnSBigVmTGqzLudBR0nPqqjmgO4dPmuUnKxN74/ftA2G0tSrwjSu1Udao
	dCYnlUyINE/CBqbZLuczYYw8rFQYy6Tq4uw9NQZTmksa/wwT6dJrrNM4YkHQdgvzrNfMp2rD2Pr
	yNHgjxCZ7QfFP2
X-Received: by 2002:a17:90b:3c43:b0:38e:488f:7068 with SMTP id 98e67ed59e1d1-38f6a3d6abamr2129092a91.2.1785233586465;
        Tue, 28 Jul 2026 03:13:06 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f090b0c9dsm3577979a91.4.2026.07.28.03.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 03:13:05 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH v5] hfsplus: validate B-tree record offset table
Date: Tue, 28 Jul 2026 18:12:57 +0800
Message-ID: <20260728101257.1031425-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <49e053c065c675b10daa6f7a4890ffb7625d6dcd.camel@dubeyko.com>
References: <49e053c065c675b10daa6f7a4890ffb7625d6dcd.camel@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A crafted HFS+ image can contain a corrupted B-tree node. The node
descriptor may contain a record count that does not fit in the node, and
record offsets may be unordered, unaligned, outside the node, or point into
the offset table itself.

Several B-tree helpers consume these on-disk fields before validating them:
hfs_bnode_dump() can walk past the offset table when num_recs is corrupted,
hfs_brec_lenoff() can produce an underflowed length or a record range that
overlaps the offset table. This can make the unlink/writeback path
repeatedly call hfs_bnode_read_u16() with invalid offsets while holding the
HFS+ B-tree lock, producing a flood of "requested invalid offset" messages.
Other writeback workers then block on tree->tree_lock and the system
reports tasks hung in hfsplus_write_inode().

Validate num_recs against the node size before walking the record offset
table. Reject record ranges that are unordered, unaligned, outside the
node, or overlapping the offset table. Reject invalid record indexes before
reading their offset entries, and avoid decrementing an already-zero
leaf_count.

Closes: https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v5:
- Switch helpers to invalid checker and invert callers.
- hfs_brec_offsets_invalid(): Drop the redundant offset-table argument
  since it is already covered by the offset-table overlap check and take
  just the two neighboring record offsets (off and next_off).
- hfs_brec_len_invalid(): reject a length against node_size.
- Use hfs_brec_len_invalid() for both length checks in hfs_bmap_get_map_page().
- Validate the record offset in hfs_bmap_free().
- Check the __hfs_brec_find() return code in [2] and [3]. [1] and [4] call
  it to find the insertion slot for a new index key after a split, -ENOENT is
  one of expected, even -EINVAL the following hfs_brec_insert() just inserts
  at slot 0 of a node already validated by hfs_bnode_find(), so it stays
  in-bounds and cannot trigger the invalid-offset flood. Hence no check was
  added.

[1] https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L160
[2] https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L208
[3] https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L382
[4] https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L449

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

 fs/hfsplus/bfind.c      | 23 ++++++------
 fs/hfsplus/bnode.c      | 16 ++++++---
 fs/hfsplus/brec.c       | 53 ++++++++++++++++++---------
 fs/hfsplus/btree.c      | 14 ++++++--
 fs/hfsplus/hfsplus_fs.h | 79 +++++++++++++++++++++++++++++++++++++++++
 5 files changed, 153 insertions(+), 32 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..ca9813f58a6d 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,6 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
+	hfs_find_result_init(fd);
 	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
@@ -106,17 +107,21 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	u16 off, len, keylen;
 	int rec;
 	int b, e;
-	int res;
+	int res = -ENOENT;
 
 	BUG_ON(!rec_found);
+	hfs_find_result_init(fd);
+	if (hfs_bnode_num_recs_invalid(bnode))
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
+		if (hfs_brec_len_invalid(bnode, len) ||
+		    hfs_brec_len_invalid(bnode, keylen)) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -130,7 +135,8 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	if (rec != e && e >= 0) {
 		len = hfs_brec_lenoff(bnode, e, &off);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (hfs_brec_len_invalid(bnode, keylen) ||
+		    hfs_brec_len_invalid(bnode, len)) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -158,11 +164,7 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
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
@@ -274,7 +276,8 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	len = hfs_brec_lenoff(bnode, fd->record, &off);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (hfs_brec_len_invalid(bnode, len) ||
+	    hfs_brec_len_invalid(bnode, keylen)) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index d088fb7eb0df..3a1a1fa6f2e2 100644
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
 
+	if (hfs_bnode_num_recs_invalid(node)) {
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
 
+	if (hfs_bnode_num_recs_invalid(node))
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
+		if (hfs_brec_offsets_invalid(node, off, next_off))
 			goto node_error;
 		entry_size = next_off - off;
 		if (node->type != HFS_NODE_INDEX &&
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..f416e562d439 100644
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
+	if (hfs_brec_record_invalid(node, rec)) {
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
+	if (hfs_brec_offsets_invalid(node, *off, next_off)) {
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
+	if (hfs_brec_record_invalid(node, rec))
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
+		if (hfs_brec_len_invalid(node, len))
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
@@ -181,14 +191,20 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	struct hfs_btree *tree;
 	struct hfs_bnode *node, *parent;
 	int end_off, rec_off, data_off, size;
+	int res;
 
 	tree = fd->tree;
 	node = fd->bnode;
 again:
+	if (hfs_brec_record_invalid(node, fd->record))
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
@@ -205,7 +221,9 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 		hfs_bnode_put(node);
 		node = fd->bnode = parent;
 
-		__hfs_brec_find(node, fd, hfs_find_rec_by_key);
+		res = __hfs_brec_find(node, fd, hfs_find_rec_by_key);
+		if (res && res != -ENOENT)
+			return res;
 		goto again;
 	}
 	hfs_bnode_write_u16(node,
@@ -368,6 +386,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	int newkeylen, diff;
 	int rec, rec_off, end_rec_off;
 	int start_off, end_off;
+	int res;
 
 	tree = fd->tree;
 	node = fd->bnode;
@@ -379,7 +398,9 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	parent = hfs_bnode_find(tree, node->parent);
 	if (IS_ERR(parent))
 		return PTR_ERR(parent);
-	__hfs_brec_find(parent, fd, hfs_find_rec_by_key);
+	res = __hfs_brec_find(parent, fd, hfs_find_rec_by_key);
+	if (res && res != -ENOENT)
+		return res;
 	if (fd->record < 0)
 		return -ENOENT;
 	hfs_bnode_dump(parent);
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 394542a47e60..b3d6ee78773e 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -168,8 +168,8 @@ static struct page *hfs_bmap_get_map_page(struct hfs_bnode *node,
 	}
 
 	ctx->len = hfs_brec_lenoff(node, rec_idx, &off16);
-	if (!ctx->len)
-		return ERR_PTR(-ENOENT);
+	if (hfs_brec_len_invalid(node, ctx->len))
+		return ERR_PTR(-EINVAL);
 
 	if (!is_bnode_offset_valid(node, off16))
 		return ERR_PTR(-EIO);
@@ -622,6 +622,11 @@ void hfs_bmap_free(struct hfs_bnode *node)
 	if (IS_ERR(node))
 		return;
 	len = hfs_brec_lenoff(node, 2, &off);
+	if (hfs_brec_len_invalid(node, len) ||
+	    !is_bnode_offset_valid(node, off)) {
+		hfs_bnode_put(node);
+		return;
+	}
 	while (nidx >= len * 8) {
 		u32 i;
 
@@ -648,6 +653,11 @@ void hfs_bmap_free(struct hfs_bnode *node)
 			return;
 		}
 		len = hfs_brec_lenoff(node, 0, &off);
+		if (hfs_brec_len_invalid(node, len) ||
+		    !is_bnode_offset_valid(node, off)) {
+			hfs_bnode_put(node);
+			return;
+		}
 	}
 
 	res = hfs_bmap_clear_bit(node, nidx);
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..90fcf1eac913 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -587,6 +587,85 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 	return is_valid;
 }
 
+static inline
+bool hfs_bnode_num_recs_invalid(struct hfs_bnode *node)
+{
+	u32 node_size;
+	u32 table_size;
+	u32 area_size;
+	u32 rec_size = sizeof(__be16);
+	u32 desc_size = sizeof(struct hfs_bnode_desc);
+
+	if (!node || !node->tree)
+		return true;
+
+	node_size = node->tree->node_size;
+	if (node_size < desc_size)
+		return true;
+
+	area_size = node_size - desc_size;
+	table_size = ((u32)node->num_recs + 1) * rec_size;
+
+	return table_size > area_size;
+}
+
+static inline
+bool hfs_brec_record_invalid(struct hfs_bnode *node, int record)
+{
+	if (hfs_bnode_num_recs_invalid(node))
+		return true;
+	if (record < 0)
+		return true;
+
+	return record >= node->num_recs;
+}
+
+static inline
+bool hfs_brec_offsets_invalid(struct hfs_bnode *node, u16 off, u16 next_off)
+{
+	u32 table_size;
+	u32 table_start;
+	u32 rec_size = sizeof(__be16);
+	u32 desc_size = sizeof(struct hfs_bnode_desc);
+
+	if (!node || !node->tree)
+		return true;
+
+	if (off < desc_size || (off & 1))
+		return true;
+
+	if (next_off <= off ||
+	    next_off > node->tree->node_size ||
+	    (next_off & 1))
+		return true;
+
+	table_size = ((u32)node->num_recs + 1) * rec_size;
+	table_start = node->tree->node_size - table_size;
+	if (next_off > table_start)
+		return true;
+
+	return false;
+}
+
+static inline
+bool hfs_brec_len_invalid(struct hfs_bnode *node, u16 len)
+{
+	if (!node || !node->tree)
+		return true;
+
+	return len == 0 || len > node->tree->node_size;
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

