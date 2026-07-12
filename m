Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F4827B35B
	for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jul 2026 06:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783836581; cv=none; b=KCIEHIlfeGRhSbZUXO7nb2b0bhB/LwmvkV0oCf4woj0AEMyZ/MpRyveEXK8HN4hn3l9SRFQhOmnr03OodNnTSSu0gygIBORMNZ0Hv7yqUByLvS16K+BMZceZ91/H69hBW0VTR8Z6qvWUf335m3Ar4ojEcLqLho2YILhc2xhhb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783836581; c=relaxed/simple;
	bh=psgcux/BufkYGLq3HRwWFkJFQw510Jfw1T4w6WdjkqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bLoZNGq1dufEKGYxIS6ScYjlkpB4WVZLzMKFh2m92PUq7FUfHzOANOv5cA7BWcaDfE29xejO80s5ebLhjsAjbHOBeMKffe4NRP4mqVajtr+L/67WvzMvPXff6BZSl/6ormSwi7UUwEo+QLfEObrt8ZXbSfHAHjNXCFW6pDtHgMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sb47h+a5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sb47h+a5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2caf228a910so15919025ad.2
        for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 23:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783836578; x=1784441378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZfbNwDGGQLxQKHl2jHyE48UXXgoid1glH3pjyve2Y9g=;
        b=sb47h+a5ZxGVGXiNyfEdiOH4HuxoY5/NL4rQ8/vWY8E1GxQ6kfu7gON01tPwIiDJ6Z
         R5aJwVuIpkWNOXV9rAi/X3CwmQc61TGq9F0tmkPFX3uBO89d692nF8mL0XJfWQH+KEjb
         FEufpwPPGlkhNNd5qYGvBvYeUh4QaO6gxBvWnM4rVlE4CWYNaWtD+ZPCMKdvIzZhhSHK
         AjrhvBtZ1vladuwWTlQd+VWmMmI7sDo0oclk8C9LmDuisy3fjdE6z8X84wCGp2y54NyN
         jcnHSNqtFecuq4dFrEy4Yu8QBcySBjq9TZrFAJIrG3d0ASFTuOCZYVNqtlmmcziKWOkL
         M1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783836578; x=1784441378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZfbNwDGGQLxQKHl2jHyE48UXXgoid1glH3pjyve2Y9g=;
        b=J465lK0tGMvjONWGRa3E38K/AkEaWSjqg7tUjEEDd7N1wclthZ+J0zPknV5IypVthI
         +ES54oPo1YqbJ/0YsMP/YHjyFH/4pPPc4s0vqpjto1gzz/AtZYD8OlAOFc8WoTiQWiCF
         yH0QMyNIWKD8OYJ2DveY64PDZ9almkWm4IZ5VRSvqy1dkgStjC889s5ti3wqa2Ba1J+g
         FHOkquAatpDvDUaENSu+2QI3aT5CmKacOh9cxkf0vqrPQjoxYnz5lioAQsIH9DYTPFfr
         bvSw35XuN3zDgO5sQVj9N6JVaHRkRUzFKKUyXK09xvaWWCcbXRZGNKBuB/iuJDVi0WRa
         uulQ==
X-Forwarded-Encrypted: i=1; AHgh+RonXLmdfrVTen+DnU0UIVAG+06m9Z+OppovH8N8Jj+RqNuyYIH2dkXRen3UhoqM8yVQHMGK11ykStHkLK1r@vger.kernel.org
X-Gm-Message-State: AOJu0YyJr0i7q3PP3bg47jCv1Gxj2gQco+y2Hl3ZU3dqDV6fqJsXlXc2
	KdmhQhRsIG/kmb6ZmgqQNw6yF7Nz3vgDCUdFFNgrhQRzUqF8JsMNfynSUn8ag3gL
X-Gm-Gg: AfdE7cm4gVOPg+S8QA4g8rpTQtLUfhLTD4QxS2nBJQjQABqqafw6zifo3jzrd2fb64m
	pB0ReqJmk8RjDZAy55vflSgLwe/4LeJejRLl2rWBV23fMlj+IpiqlmIDpWAmQxtSjuVE8Z5M3O+
	xstoxwgsN/QkjYs74i+k275R8u8MJol8tKdzILQGVX6zg8cJyCgNgZdebXDQujMX399DH84aZ1v
	RdjUo1hqxxSqs0oNqLoNiIGcJIEtrPyduMFShv63QJXc5uiX9Lqf6JCoVYgY+TiPmG2vPT0JBQO
	P2fHCf1/KGt0DtNQxDBrsqnZwJjuNSx3o7ot7ogp4ETkBz7B5Hp0A6+qfEEGHh+dmc0FRT4mcUp
	QuBBbJvHrfoplwAV78TzlaZ10QdXQJp0pL7sg1mwQ+yMEmOPJ1Mx7voe4SctosJArwkECmVtKlm
	IyKXXvbgzrcD56f6xbcORCEKc=
X-Received: by 2002:a17:903:4b2b:b0:2cc:76fd:6537 with SMTP id d9443c01a7336-2ce9e7a53edmr46812605ad.2.1783836577645;
        Sat, 11 Jul 2026 23:09:37 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([115.25.44.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d59e33sm80030335ad.74.2026.07.11.23.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 23:09:37 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH v3] hfsplus: validate B-tree record offset table
Date: Sun, 12 Jul 2026 14:09:28 +0800
Message-ID: <20260712060928.26430-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <96beade6e2a14b66e80053df0209598e11eb7986.camel@dubeyko.com>
References: <96beade6e2a14b66e80053df0209598e11eb7986.camel@dubeyko.com>
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

Closes: https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
Changes in v3:
- Drop the keylen == len check.
- Drop the explicit zero-record check in __hfs_brec_find().
- Move find cursor reset into hfs_find_reset() and call it from hfs_find_init() and hfs_brec_find().
- Rename helper-local variables as suggested.

 fs/hfsplus/bfind.c      | 13 ++++----
 fs/hfsplus/bnode.c      | 16 ++++++---
 fs/hfsplus/brec.c       | 35 +++++++++++++-------
 fs/hfsplus/hfsplus_fs.h | 72 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 113 insertions(+), 23 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..a5391ff07c70 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -18,6 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
+	hfs_find_reset(fd);
 	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
@@ -106,12 +107,14 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	u16 off, len, keylen;
 	int rec;
 	int b, e;
-	int res;
+	int res = -ENOENT;
 
 	BUG_ON(!rec_found);
+	if (!hfs_bnode_num_recs_valid(bnode))
+		goto fail;
+
 	b = 0;
 	e = bnode->num_recs - 1;
-	res = -ENOENT;
 	do {
 		rec = (e + b) / 2;
 		len = hfs_brec_lenoff(bnode, rec, &off);
@@ -158,11 +161,7 @@ int hfs_brec_find(struct hfs_find_data *fd, search_strategy_t do_key_compare)
 	__be32 data;
 	int height, res;
 
-	fd->record = -1;
-	fd->keyoffset = -1;
-	fd->keylength = -1;
-	fd->entryoffset = -1;
-	fd->entrylength = -1;
+	hfs_find_reset(fd);
 
 	tree = fd->tree;
 	if (fd->bnode)
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
index e3df89284079..3112c3bcf9cf 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -20,35 +20,41 @@ static int hfs_btree_inc_height(struct hfs_btree *);
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
 		if (retval > node->tree->max_key_len + 2) {
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
index ec04b82ad927..d87d55a35d25 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -587,6 +587,78 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
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
+bool hfs_brec_range_valid(struct hfs_bnode *node, u16 off, u16 next_off,
+			  u16 rec_off)
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
+		next_off > node->tree->node_size ||
+		next_off > rec_off ||
+		(next_off & 1))
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
+void hfs_find_reset(struct hfs_find_data *fd)
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

