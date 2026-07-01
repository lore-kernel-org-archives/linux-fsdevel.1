Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C07392822
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782885032; cv=none; b=DMdzZh1v2y3C1S99JnyX3CZMrFVlQ8Wt4hyXORkDqBzhHACBxAH5m1AwrUD8NqUtQJU/bcW46G/q36AhfD+KLQh0cPm1hjX/Wgw8PCaWgMdngfddJ5JMz20MugoKz3MzV8Cm7k+Tvw7h7vnRzUNJ7atsZ2ENG01tGmn+rR/Asak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782885032; c=relaxed/simple;
	bh=IZliUkXiBExgdug3BDDrwmryDpIMfYmqI7Icd2i9Z3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6DtrFviOCSU+rxtsJSyKROvkiIaUvtszUu8whnG/O0NUvM1wyiLl3qMA/59n16pPt9DLoa9r3AI8d3wgpJ+wscKdc3jTDAXmvegeUlO29LxbTZne100L/5kk+H+ycYUZ21sdzo8TwPfVaXF5zxeRTpvWqzJr/IOgbosuX4U614=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/mBUBzp; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/mBUBzp"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-845f2909cd4so125534b3a.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Jun 2026 22:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782885030; x=1783489830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8fxNaewk/OBFH32QFXdwx3B+xFO1JJNL6eeCMiecrE=;
        b=Q/mBUBzpfN74rAX+HQtGafbOq4w0cpb7wGYRAPAvAdlkQyYEQtndtB4QWg315JY33j
         WIVcrrwOwjKDldGPhitZik4fSj86XZo8snCWgv96VbFraphtCtRw/+sr6noU5dqvfLRq
         7Aw4zDvBBRdhIuuDe17CHLRNFbIj1od7eNlUFlaiFyZxKJRw2SW47bEADKLErMswpze8
         wPR+9IWEhUzKvWxr11YC43+XR+UMjO/+GRoKGt9sqJV7fSZt5lR+ZwbU2EKFvOv2FNiY
         LR1VpFGDzinbW8veVJ/Lxi0yiqZ7rgRvDnw4eAxmu6icapgRgAI0JVzFpi/c3R/n9iAy
         7Kxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782885030; x=1783489830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8fxNaewk/OBFH32QFXdwx3B+xFO1JJNL6eeCMiecrE=;
        b=hYRbt71SzELICUylBnPu7uXmOPLX4/fMIEDSMI97GW++dAhiv1wLWb8cx1wtKXdSht
         EVxVc5HzCD+/FzqJdJEdaYEOryJ5oxR9/3TlcbfbOIEX0M3RRTuL3AUMGhMRANlSW2Ns
         leMlCVKrYoSJTCRaopVz0JU9VSclLpEdIXMhT4/a0WMOHic+DX5gizLBZv0ljcjJTbcE
         Sq7SG+A9QSRwr5pKllnsJKvMOkfPjgwQJtuuTp2Zv5MBPxG4Wd3cR0acmVue2gKDG77T
         j5HLhdSq1P7WjGl12c28QGEWB+nA8bLgKSmPLoS57CTmLgJZFaRPyOdsMjDdlTXUkI4M
         2JGA==
X-Forwarded-Encrypted: i=1; AHgh+RoY77LRtGhsTwKDuJBNOuNYkhTNrRtf9BeVwc//fPrTk25D3qJtSCQFcdkjvOiwfxKwdh377k3B9xGtQlWm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx17WAdTXms8zlMJGvK//lwrlApFzW4INopfR4p/gR0NmOEL6ry
	H3YcWYdW36yCheqWorZ8+lSTdLgR/lgZbeZD+W9sk+r1z6IZ661b5YHN
X-Gm-Gg: AfdE7cmDESu5OV9j5I2WTrN4C5NW0JjPHj/B/qB+u86TT2ELXWS6EWDDy5tY9dJy3VH
	wAzlNPzlIdHJe+cncE5QLrP9FnWUZnEii0dqnI+LCjkgednKVGujJG6+IY+t9cDqH8brUxJgPeg
	nZSkLFODP00Ca045kijmuS8iT2PY8x2hJ5WyrUs8HUTnCNA/KN7InfftrKG1vCZNVbtaPDsFBXS
	g2vgW53B7aV/Ru0zXI1ikwtZvlm4YjIRhXmdyTW5ry9xROrCrm7rRxSlOMehKlL0dU2iItFTLsS
	QeUILketZpJy1SNj0ZSfo2ov1tdx1QCcp+Rv8eQkDTNwDX+Wn219WnhAuyaYOvNq9P3mCgtctTF
	narjpKXfBxh79nME5Y8+aoQfhD60npiw/mIykZ5e3kQvmtv+tJe9TaNfkqBqnuE7qK9L0wcKSKP
	fOsPmkJuqCzLej/wXjJ5FHN1fD
X-Received: by 2002:a05:6a00:4387:b0:847:8d54:f4f9 with SMTP id d2e1a72fcca58-847c094916amr148963b3a.51.1782885029874;
        Tue, 30 Jun 2026 22:50:29 -0700 (PDT)
Received: from ustb520lab-MS-7E07.. ([123.124.147.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479fffdfe1sm3442637b3a.18.2026.06.30.22.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 22:50:29 -0700 (PDT)
From: Jiaming Zhang <r772577952@gmail.com>
To: slava@dubeyko.com
Cc: frank.li@vivo.com,
	glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	r772577952@gmail.com,
	syzkaller@googlegroups.com
Subject: [PATCH] hfsplus: validate B-tree record offset table
Date: Wed,  1 Jul 2026 13:50:20 +0800
Message-ID: <20260701055020.385680-1-r772577952@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <4ef15f553f01e959209273f5a170288af6ecdc91.camel@dubeyko.com>
References: <4ef15f553f01e959209273f5a170288af6ecdc91.camel@dubeyko.com>
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

Reject corrupted B-tree metadata earlier: validate num_recs against the node
size before walking the record offset table, reject record offsets that are
unordered, unaligned, outside the node, or overlapping the offset table, stop
B-tree record walkers on invalid records, and avoid decrementing an already-zero
leaf_count.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Closes: https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J25Vuju10Q@mail.gmail.com/
Assisted-by: Codex:gpt-5.5-xhigh
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
---
 fs/hfsplus/bfind.c      | 12 +++++++++---
 fs/hfsplus/bnode.c      | 15 +++++++++++++--
 fs/hfsplus/brec.c       | 35 ++++++++++++++++++++++++++++++-----
 fs/hfsplus/hfsplus_fs.h | 18 ++++++++++++++++++
 4 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index 9a55fa6d5294..ace9ba027a9d 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -112,11 +112,13 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	b = 0;
 	e = bnode->num_recs - 1;
 	res = -ENOENT;
+	if (!bnode->num_recs)
+		return res;
 	do {
 		rec = (e + b) / 2;
 		len = hfs_brec_lenoff(bnode, rec, &off);
 		keylen = hfs_brec_keylen(bnode, rec);
-		if (keylen == 0) {
+		if (!keylen || keylen >= len) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -130,7 +132,7 @@ int __hfs_brec_find(struct hfs_bnode *bnode, struct hfs_find_data *fd,
 	if (rec != e && e >= 0) {
 		len = hfs_brec_lenoff(bnode, e, &off);
 		keylen = hfs_brec_keylen(bnode, e);
-		if (keylen == 0) {
+		if (!keylen || keylen >= len) {
 			res = -EINVAL;
 			goto fail;
 		}
@@ -232,6 +234,10 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	bnode = fd->bnode;
 	tree = bnode->tree;
+	if (!bnode->num_recs) {
+		res = -ENOENT;
+		goto out;
+	}
 
 	if (cnt < 0) {
 		cnt = -cnt;
@@ -274,7 +280,7 @@ int hfs_brec_goto(struct hfs_find_data *fd, int cnt)
 
 	len = hfs_brec_lenoff(bnode, fd->record, &off);
 	keylen = hfs_brec_keylen(bnode, fd->record);
-	if (keylen == 0) {
+	if (!keylen || keylen >= len) {
 		res = -EINVAL;
 		goto out;
 	}
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index d088fb7eb0df..df406f75a5b3 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -352,15 +352,22 @@ void hfs_bnode_dump(struct hfs_bnode *node)
 	struct hfs_bnode_desc desc;
 	__be32 cnid;
 	int i, off, key_off;
+	u16 num_recs;
 
 	hfs_dbg("node %d\n", node->this);
 	hfs_bnode_read(node, &desc, 0, sizeof(desc));
+	num_recs = be16_to_cpu(desc.num_recs);
 	hfs_dbg("next %d, prev %d, type %d, height %d, num_recs %d\n",
 		be32_to_cpu(desc.next), be32_to_cpu(desc.prev),
-		desc.type, desc.height, be16_to_cpu(desc.num_recs));
+		desc.type, desc.height, num_recs);
+
+	if (!hfs_bnode_num_recs_valid(node, num_recs)) {
+		hfs_dbg("invalid num_recs %u\n", num_recs);
+		return;
+	}
 
 	off = node->tree->node_size - 2;
-	for (i = be16_to_cpu(desc.num_recs); i >= 0; off -= 2, i--) {
+	for (i = num_recs; i >= 0; off -= 2, i--) {
 		key_off = hfs_bnode_read_u16(node, off);
 		hfs_dbg(" key_off %d", key_off);
 		if (i && node->type == HFS_NODE_INDEX) {
@@ -579,6 +586,9 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 		goto node_error;
 	}
 
+	if (!hfs_bnode_num_recs_valid(node, node->num_recs))
+		goto node_error;
+
 	rec_off = tree->node_size - 2;
 	off = hfs_bnode_read_u16(node, rec_off);
 	if (off != sizeof(struct hfs_bnode_desc))
@@ -588,6 +598,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 		next_off = hfs_bnode_read_u16(node, rec_off);
 		if (next_off <= off ||
 		    next_off > tree->node_size ||
+		    next_off > rec_off ||
 		    next_off & 1)
 			goto node_error;
 		entry_size = next_off - off;
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index e3df89284079..dce397be9151 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -20,12 +20,27 @@ static int hfs_btree_inc_height(struct hfs_btree *);
 u16 hfs_brec_lenoff(struct hfs_bnode *node, u16 rec, u16 *off)
 {
 	__be16 retval[2];
-	u16 dataoff;
+	u16 data_off;
+	u16 next_off;
 
-	dataoff = node->tree->node_size - (rec + 2) * 2;
-	hfs_bnode_read(node, retval, dataoff, 4);
+	if (rec >= node->num_recs ||
+		!hfs_bnode_num_recs_valid(node, node->num_recs)) {
+		*off = 0;
+		return 0;
+	}
+
+	data_off = node->tree->node_size - (rec + 2) * 2;
+	hfs_bnode_read(node, retval, data_off, 4);
 	*off = be16_to_cpu(retval[1]);
-	return be16_to_cpu(retval[0]) - *off;
+	next_off = be16_to_cpu(retval[0]);
+	if (*off < sizeof(struct hfs_bnode_desc) ||
+		*off & 1 ||
+		next_off <= *off ||
+		next_off > node->tree->node_size ||
+		next_off > data_off ||
+		next_off & 1)
+		return 0;
+	return next_off - *off;
 }
 
 /* Get the length of the key from a keyed record */
@@ -35,6 +50,9 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 
 	if (node->type != HFS_NODE_INDEX && node->type != HFS_NODE_LEAF)
 		return 0;
+	if (rec >= node->num_recs ||
+		!hfs_bnode_num_recs_valid(node, node->num_recs))
+		return 0;
 
 	if ((node->type == HFS_NODE_INDEX) &&
 	   !(node->tree->attributes & HFS_TREE_VARIDXKEYS) &&
@@ -43,7 +61,7 @@ u16 hfs_brec_keylen(struct hfs_bnode *node, u16 rec)
 	} else {
 		recoff = hfs_bnode_read_u16(node,
 			node->tree->node_size - (rec + 1) * 2);
-		if (!recoff)
+		if (recoff < sizeof(struct hfs_bnode_desc) || recoff & 1)
 			return 0;
 		if (recoff > node->tree->node_size - 2) {
 			pr_err("recoff %d too large\n", recoff);
@@ -185,10 +203,17 @@ int hfs_brec_remove(struct hfs_find_data *fd)
 	tree = fd->tree;
 	node = fd->bnode;
 again:
+	if (fd->record < 0 ||
+		fd->record >= node->num_recs ||
+		!hfs_bnode_num_recs_valid(node, node->num_recs))
+		return -EIO;
+
 	rec_off = tree->node_size - (fd->record + 2) * 2;
 	end_off = tree->node_size - (node->num_recs + 1) * 2;
 
 	if (node->type == HFS_NODE_LEAF) {
+		if (!tree->leaf_count)
+			return -EIO;
 		tree->leaf_count--;
 		mark_inode_dirty(tree->inode);
 	}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index ec04b82ad927..8b2f2041b8b9 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -587,6 +587,24 @@ bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
 	return is_valid;
 }
 
+static inline
+bool hfs_bnode_num_recs_valid(struct hfs_bnode *node, u16 num_recs)
+{
+	u32 node_size;
+	u32 offs_size;
+
+	if (!node || !node->tree)
+		return false;
+
+	node_size = node->tree->node_size;
+	if (node_size < sizeof(struct hfs_bnode_desc) + sizeof(__be16))
+		return false;
+
+	offs_size = ((u32)num_recs + 1) * sizeof(__be16);
+
+	return offs_size <= node_size - sizeof(struct hfs_bnode_desc);
+}
+
 static inline
 u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, u32 len)
 {
-- 
2.43.0

