Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838D4428820
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782980550; cv=none; b=mrORs3sOIIDtcF1n5EuvKNFHwr10DC9CNOJOrXy5rC9RYgRqBvIMpnwpGkZFOZyR18XiW+RBb1kwJriDmEPw2Tyi3rhS3fz0zv/hVPnlwmSPe80llJl9qj0+cQ5kAVgRl/wFxrUZ2t5yNJ86uc5H1/QKssMdrzQewpI1uIHKNmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782980550; c=relaxed/simple;
	bh=yUMgmxIZ7jTaRt6tVUEbXn3eoZEDQFAoWhxZrKgP4lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RB5ZSPRpyrBkUdkuKkuoL6JTkRHnlreOcbmtZM5qb37H/RAdGZq1C1NhtOqOSqYyXo4gh/aOCEkByJmJwcdDxXJdvay+CirVZuf6ZKrO4Bpdd6HmFmVdyMVX+6dOy27Q5dwgfGKYKzLAKHJLDuys0g34NukShH/pcqytTPd3gTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hC3oJ7MY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hC3oJ7MY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c82538b6b0so11806825ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782980548; x=1783585348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=drmozm5lgYtfX73OYLUjoPKci6PqoyJ46+Zgbmt3V8o=;
        b=hC3oJ7MY5PUk480ymlFULFl0h5umkLCu44EEVHkALtBNYBcEgHQ5qcGT9gTKp62w/X
         lKWQljFioYoUz+2kvcybErK27TuBod59QNQdWA8f+FhK+fA1mR9gkjtIxNIBF2EM40px
         KTXCdmeTauK+uEdZLcyTb/SbokbDWlnEdaTtWI5199Vk3irE2kL/oTC5sEfJe18IiNgx
         zloE6j3D7+fRgN+X3kmWjOsHc5zNERPtS5dhW4GLKLW3JWZ360zjiZ+6iCS0sgtmHlxr
         0ok0J8R5lggB6DOEoHdrF7shGJkHmcBe07awjkL30XsI9jmBzUCAgH0hlPgQDqTg/qX6
         Fu6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782980548; x=1783585348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=drmozm5lgYtfX73OYLUjoPKci6PqoyJ46+Zgbmt3V8o=;
        b=gEIcr3Ni1f34FHn6nbZZC552lumOy9JoxZST0lPQSw728r0Aoxgzpj7JrbR9P396Ue
         2GUo3z1mttM38kiRdiN0LIatuBXnXa8xEytPajCqAtOUpwSaoyo7TWX5D+J/1aFDBz0f
         yQ0hV6EW7w83bpgbWbATUNVtEE+M4f2d9DbaNDOA6gapjqktD6jO/LIRJNLvDI4ix4ul
         6NlR4mP5BZgVjZwoJEXRUBccZ3BbGIKNXz0bTS8rMUnPbdx2QNefQ3Fg/0HdCBA/AzpK
         6lpR3LIUGQTb+/TeajVFenLFb1s4NOgavc7PBFI5HKCuYz83gLywy/4KEFpMfIBD80+6
         NJpQ==
X-Forwarded-Encrypted: i=1; AHgh+RrFd3LJhp+ywcVdzWXDZPGfC7yX4eSj6ftpvV1HxskCHDRmD/xqJnDTTJ+u706Izjw2INk96wQFxr/ggn3M@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Ki9yL8n5QwU5MEs+KDA8maqPSEjlV6MWRnEma1qBmc+s0rs2
	gv//8syGtoAW/AGG2eg7jVWwdNVC9XUC6E6zJ+mQSBa/JVLirPkGi9Xr
X-Gm-Gg: AfdE7ckTYcyOQj+lF9mljqinL9xCrTJCUAl8p5L6bi1Plom1StjP0z4eRMgroT1jPf2
	k72iSNs2C94fcFWftcQHjxnZLVYkZsXhLbC1aFssx7xgJr3btyD1M4U0xBuOHsCEl8YfJ9EF99F
	c2TW0apc/MrV45kcyoM3OCWy8tFwgQ4aPBzAtw7Q0Mdtr9WhfjK/gaJN1YOVBhkOC0zn7E2Wj9i
	mktbc4bNxJXv5StinWzPO1uaQjQSwu/UbRvOltkdTwBAZySidjWHfP3rLLOj3vPcK8kPqDSMVm4
	f0h98o7QEDUSDY3xOQT+u3QQDEU+nq6FEFLih/BdXbRsLiTpzNQja75WP0SVpavo+Jg/yaJXA1P
	EGPkaC4DztKeel4kDaSdyh08gL6Tde58feNhvYvlQIDUjokRxwGF/n8EapPq/tVfPhAY93jBCzJ
	gSQo0OK8URDCiCeTzmpFzOkEM=
X-Received: by 2002:a17:902:cf12:b0:2ca:6d87:e684 with SMTP id d9443c01a7336-2ca7e8f2c16mr52366705ad.32.1782980547340;
        Thu, 02 Jul 2026 01:22:27 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a8da8aasm9875805ad.8.2026.07.02.01.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 01:22:26 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH v2 1/1] hfsplus: validate B-tree record offset table
Date: Thu,  2 Jul 2026 16:22:01 +0800
Message-ID: <20260702082201.286288-2-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702082201.286288-1-r772577952@gmail.com>
References: <6074d91cefcc32cb54f48a1ee214530836e6c948.camel@dubeyko.com>
 <20260702082201.286288-1-r772577952@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A crafted HFS+ image can contain a corrupted B-tree node. The node descriptor may
contain a record count that does not fit in the node, and record offsets may be
unordered, unaligned, outside the node, or point into the offset table itself.

Several B-tree helpers consume these on-disk fields before validating them:
hfs_bnode_dump() can walk past the offset table when num_recs is corrupted,
hfs_brec_lenoff() can produce an underflowed length or a record range that overlaps
the offset table. This can make the unlink/writeback path repeatedly call
hfs_bnode_read_u16() with invalid offsets while holding the HFS+ B-tree lock,
producing a flood of "requested invalid offset" messages. Other writeback workers
then block on tree->tree_lock and the system reports tasks hung in
hfsplus_write_inode().

Reject corrupted B-tree metadata earlier: validate num_recs against the node size
before walking the record offset table, reject record offsets that are unordered,
unaligned, outside the node, or overlapping the offset table, stop B-tree record
walkers on invalid records, and avoid decrementing an already-zero leaf_count.

Closes: https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v...@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/hfsplus/bfind.c      | 27 ++++++++++++++++--
 fs/hfsplus/bnode.c      | 16 ++++++++---
 fs/hfsplus/brec.c       | 37 +++++++++++++++---------
 fs/hfsplus/hfsplus_fs.h | 62 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 20 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..363faf214a1c 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -108,15 +108,28 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	int b, e;
 	int res;
 
+	fd->record = -1;
+	fd->keyoffset = -1;
+	fd->keylength = -1;
+	fd->entryoffset = -1;
+	fd->entrylength = -1;
+
 	BUG_ON(!rec_found);
+	if (!hfs_bnode_num_recs_valid(bnode)) {
+		res = -EIO;
+		goto fail;
+	}
+
 	b = 0;
 	e = bnode->num_recs - 1;
 	res = -ENOENT;
+	if (bnode->num_recs == 0)
+		goto fail;
 	do {
 		rec = (e + b) / 2;
 		len = hfs_brec_lenoff(bnode, rec, &off);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		if (keylen == 0 || keylen >= len) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -130,7 +143,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	if (rec != e && e >= 0) {
 		len = hfs_brec_lenoff(bnode, e, &off);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (keylen == 0 || keylen >= len) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -232,6 +245,14 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	bnode = fd->bnode;
 	tree = bnode->tree;
+	if (!hfs_bnode_num_recs_valid(bnode)) {
+		res = -EIO;
+		goto out;
+	}
+	if (bnode->num_recs == 0) {
+		res = -ENOENT;
+		goto out;
+	}
 
 	if (cnt < 0) {
 		cnt = -cnt;
@@ -274,7 +295,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	len = hfs_brec_lenoff(bnode, fd->record, &off);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (keylen == 0 || keylen >= len) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index d088fb7eb0df..f185c012d090 100644
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
@@ -579,6 +586,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 		goto node_error;
 	}
 
+	if (!hfs_bnode_num_recs_valid(node))
+		goto node_error;
+
 	rec_off = tree->node_size - 2;
 	off = hfs_bnode_read_u16(node, rec_off);
 	if (off != sizeof(struct hfs_bnode_desc))
@@ -586,9 +596,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 	for (i = 1; i <= node->num_recs; off = next_off, i++) {
 		rec_off -= 2;
 		next_off = hfs_bnode_read_u16(node, rec_off);
-		if (next_off <= off ||
-		    next_off > tree->node_size ||
-		    next_off & 1)
+		if (!hfs_brec_range_valid(node, off, next_off, rec_off))
 			goto node_error;
 		entry_size = next_off - off;
 		if (node->type != HFS_NODE_INDEX &&
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..fe2e0636798c 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -20,38 +20,44 @@ static int hfs_btree_inc_height(struct hfs_btree *);
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
 {
 	__be16 retval[2];
-	u16 dataoff;
+	u16 data_off;
+	u16 next_off;
 
-	dataoff = node->tree->node_size - (rec + 2) * 2;
-	hfs_bnode_read(node, retval, dataoff, 4);
+	if (!hfs_brec_record_valid(node, rec)) {
+		*off = 0;
+		return 0;
+	}
+
+	data_off = node->tree->node_size - (rec + 2) * 2;
+	hfs_bnode_read(node, retval, data_off, 4);
 	*off = be16_to_cpu(retval[1]);
-	return be16_to_cpu(retval[0]) - *off;
+	next_off = be16_to_cpu(retval[0]);
+	if (!hfs_brec_range_valid(node, *off, next_off, data_off))
+		return 0;
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
+		return 0;
 
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
+		len = hfs_brec_lenoff(node, rec, &recoff);
+		if (len == 0)
 			return 0;
-		}
 
 		retval = hfs_bnode_read_u16(node, recoff) + 2;
-		if (retval > node->tree->max_key_len + 2) {
+		if (retval >= len || retval > node->tree->max_key_len + 2) {
 			pr_err("keylen %d too large\n",
 				retval);
 			retval = 0;
@@ -185,10 +191,15 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	tree = fd->tree;
 	node = fd->bnode;
 again:
+	if (!hfs_brec_record_valid(node, fd->record))
+		return -EIO;
+
 	rec_off = tree->node_size - (fd->record + 2) * 2;
 	end_off = tree->node_size - (node->num_recs + 1) * 2;
 
 	if (node->type == HFS_NODE_LEAF) {
+		if (tree->leaf_count == 0)
+			return -EIO;
 		tree->leaf_count--;
 		mark_inode_dirty(tree->inode);
 	}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..7a345c4d1c06 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -587,6 +587,68 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 	return is_valid;
 }
 
+static inline
+bool hfs_bnode_num_recs_valid(struct hfs_bnode *node)
+{
+	u32 node_size;
+	u32 rec_off_size;
+	u32 rec_off_tab_size;
+	u32 rec_area_size;
+
+	if (!node || !node->tree)
+		return false;
+
+	node_size = node->tree->node_size;
+	rec_off_size = sizeof(__be16);
+	if (node_size < sizeof(struct hfs_bnode_desc) + rec_off_size)
+		return false;
+
+	rec_area_size = node_size - sizeof(struct hfs_bnode_desc);
+	rec_off_tab_size = ((u32)node->num_recs + 1) * rec_off_size;
+
+	return rec_off_tab_size <= rec_area_size;
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
+bool hfs_brec_range_valid(struct hfs_bnode *node, u16 off, u16 next_off,
+			  u16 rec_off)
+{
+	u32 rec_off_size;
+	u32 rec_off_tab_size;
+	u32 rec_off_tab_start;
+
+	if (!node || !node->tree)
+		return false;
+
+	if (off < sizeof(struct hfs_bnode_desc) || (off & 1))
+		return false;
+
+	if (next_off <= off ||
+		next_off > node->tree->node_size ||
+		next_off > rec_off ||
+		(next_off & 1))
+		return false;
+
+	rec_off_size = sizeof(__be16);
+	rec_off_tab_size = ((u32)node->num_recs + 1) * rec_off_size;
+	rec_off_tab_start = node->tree->node_size - rec_off_tab_size;
+	if (next_off > rec_off_tab_start)
+		return false;
+
+	return true;
+}
+
 static inline
 u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 {
-- 
2.43.0

