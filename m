Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2CC285C8B
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Apr 2026 23:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775257584; cv=none; b=TnUL07hCJMXK09M7TQ480M2Qp2VBnSFyDWQikqclbSWtEqz7vUc0OmyaZ63IC2TldJ+biVymA3H530jGuGNjJZrxIYJaxb18rXj0yd9vU3feR0vwqPdTQ1b4DOUFFyEmbLPOgQZ6i5f8r5WJzR/fD5PKiLu69K9a/spOU19//b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775257584; c=relaxed/simple;
	bh=gT6zffJfAmm6oMkyvmNAyeAClRgSSqWpUSI2XGZ0aPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NlM/8nll4mfIoT5OXRZwLHexebF/XRqFpArZBj92M8zPsgNCZaCdWxhl33wmzLiaqEfuWVaRT3kRqhT1gFZdw9ql6PjaTnDjmAF/bZRY4KuSPwXIMNnFlRUYdk4vcjXxX+dZtGiddMN00Mne1yGfQfFAwj7iIUM0QVXyD6+u8d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=aEuf8Hpi; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="aEuf8Hpi"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7d7eb85fb81so2354893a34.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Apr 2026 16:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1775257581; x=1775862381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqCwiuD4CFjZlLKj2xUGoYjSaS5hdmQwkWJOZDtlbRQ=;
        b=aEuf8Hpi7AYZwrJgvDEQWvAYNEvBnWu2hXUun9pIxP9QAr4Zj8JONRmhUjk0B1unIN
         sH10PE1rNxMYA6f9O9dd3H1WEmpFFoCor0G7TlwZgLTSQ9xRbVqJhQhQXBpet16m+i/c
         MzfRpnmScnPU/Z1SfHcXNYCd9+VMqptmaVCoTlYgjHNI3M6wN1K41n+p1BTHbZsm/Y0w
         8vlv0M0/9JunaaEPr7sMtTEgGBhPip6+kyVLzPIXDue2ADlyv3LoGZ8nXj/dUmxJyOyx
         crIThP7jOiN1g7JZXYPpaksuhu/kIeiqEmYF/qsygYmqQxMHosg5mbtGeId1YOhzqcNL
         N+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775257581; x=1775862381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EqCwiuD4CFjZlLKj2xUGoYjSaS5hdmQwkWJOZDtlbRQ=;
        b=TijAVvkMdp/E6ssXFv5+tjIQJ3qSCulhaXwIJVxT5QIk4AfTy6E2DipPstnb8m1rY2
         8TmUYrrW7iSiIOseanlIyX7BoT7nYORRJAqJ3abutNCmuYnqToATDsGMaj6Ho7QA6++5
         +BEvN8rAgKzadcN//UQFO96zJe8A3ONV0/6gKmG0GMHT78EeoW1fB4FcKsUXrKN9+X98
         Jl3EYdzV+8KLwpQi88ATV/CnbkY8PrxoOsnV0Ahj8rpoEQTCn8hGfI+rm53PojiicBbr
         eFNwK0gKiqTnMhlNexSfknmzHKWrngi7nLJ8mCGtwJI3BuqsfThztJ2DvMO1m3Flq/fb
         sLpQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcuoDVD4w+qTadiheiaqUudk6flhHnOmU/b8CHjX+KvcvpW6MBh+RoMIApvXIp2YEpFOgAmUjgdptIunw9@vger.kernel.org
X-Gm-Message-State: AOJu0YwFYFkfzf9hnnHT2stSCZRw362lNnJDADzgEJ3R5tL5g3eJCWM+
	/Jxq7Pyde0LS9hs90/mZVMFlnH69j1SQGqWgWqyNHlZJ4BO9RDkV3X5Mi4vfgiV19glG9pUisq3
	/aIz+4w0=
X-Gm-Gg: ATEYQzw/c278Jf1vFZHx43T/K5C4un9eVE45Bxp0JFX+MOJ1EJJSmOSdZ7GBNTA/a6v
	Z42dFG1ISgJcylS+50BF+3D7XspV1KH1mQ0GaHynIw2GxQrzthBcbcq4nL0tukpudXnpBgsN/LJ
	WFUeluA7xJdJoMLH0YlqULdpRZgmq/txj7J15UeH4Yh4LaDNQSSsZbI8GmhBl/5PUqn3xiFZzTr
	gteB6++gNzhhmuYLmZf+wWaM/ABqx2VEoWgsi3mPcypKCu+43QzWQnIkTXgOM5ka+gHhAgw9KaK
	RD9lOoAYyRMa7E9UUiDhFV1QfuyDP28IPxakcu35GSVv5YjkzGOI7sOaQrMMX7mdPxPub8FkxeX
	TEpWBXfQaLNK/SAhFLfRU0XZTpipsjEm5zx205LQDQq+kd6EzqDVvOQQfLUusfILQzTQpvI+Tw2
	iKnwvLWpzF51bmgayDtglp579P3e1T6DRC6kFqofgEaTWsXC3UgIHX+L4H801dfXqTBhkPhsGCN
	5CA6NeLnrRmCmv9vJubvMRh
X-Received: by 2002:a05:6830:3698:b0:7d9:f50f:96a7 with SMTP id 46e09a7af769-7dbb7576376mr2993069a34.26.1775257581363;
        Fri, 03 Apr 2026 16:06:21 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:92cd:838f:83ea:d7f2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dba7183dfesm5523210a34.9.2026.04.03.16.06.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 16:06:20 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	linux-fsdevel@vger.kernel.org,
	frank.li@vivo.com
Cc: Slava.Dubeyko@ibm.com,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 4/5] hfsplus: rework logic of map nodes creation in xattr b-tree
Date: Fri,  3 Apr 2026 16:05:55 -0700
Message-ID: <20260403230556.614171-5-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260403230556.614171-1-slava@dubeyko.com>
References: <20260403230556.614171-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hfsplus_init_header_node() when node_count > 63488
(header bitmap capacity), the code calculates map_nodes,
subtracts them from free_nodes, and marks their positions
used in the bitmap. However, it doesn't write the actual
map node structure (type, record offsets, bitmap) for
those physical positions, only node 0 is written.

This patch reworks hfsplus_create_attributes_file()
logic by introducing a specialized method of
hfsplus_init_map_node() and writing the allocated
map b-tree's nodes by means of
hfsplus_write_attributes_file_node() method.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
---
 fs/hfsplus/xattr.c         | 127 ++++++++++++++++++++++++++++++-------
 include/linux/hfs_common.h |   2 +
 2 files changed, 106 insertions(+), 23 deletions(-)

diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 89e2e7e46e96..75cb74466738 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -50,7 +50,7 @@ static bool is_known_namespace(const char *name)
 	return true;
 }
 
-static void hfsplus_init_header_node(struct inode *attr_file,
+static u32 hfsplus_init_header_node(struct inode *attr_file,
 					u32 clump_size,
 					char *buf, u16 node_size)
 {
@@ -59,6 +59,7 @@ static void hfsplus_init_header_node(struct inode *attr_file,
 	u16 offset;
 	__be16 *rec_offsets;
 	u32 hdr_node_map_rec_bits;
+	u32 map_nodes = 0;
 	char *bmp;
 	u32 used_nodes;
 	u32 used_bmp_bytes;
@@ -93,7 +94,6 @@ static void hfsplus_init_header_node(struct inode *attr_file,
 	hdr_node_map_rec_bits = 8 * (node_size - offset - (4 * sizeof(u16)));
 	if (be32_to_cpu(head->node_count) > hdr_node_map_rec_bits) {
 		u32 map_node_bits;
-		u32 map_nodes;
 
 		desc->next = cpu_to_be32(be32_to_cpu(head->leaf_tail) + 1);
 		map_node_bits = 8 * (node_size - sizeof(struct hfs_bnode_desc) -
@@ -116,21 +116,100 @@ static void hfsplus_init_header_node(struct inode *attr_file,
 	*bmp = ~(0xFF >> used_nodes);
 	offset += hdr_node_map_rec_bits / 8;
 	*--rec_offsets = cpu_to_be16(offset);
+
+	return map_nodes;
+}
+
+/*
+ * Initialize a map node buffer. Map nodes have a single bitmap record.
+ */
+static void hfsplus_init_map_node(u8 *buf, u16 node_size, u32 next_node)
+{
+	struct hfs_bnode_desc *desc;
+	__be16 *rec_offsets;
+	size_t rec_size = sizeof(__be16);
+	u16 offset;
+
+	memset(buf, 0, node_size);
+
+	desc = (struct hfs_bnode_desc *)buf;
+	desc->type = HFS_NODE_MAP;
+	desc->num_recs = cpu_to_be16(1);
+	desc->next = cpu_to_be32(next_node);
+
+	/*
+	 * A map node consists of the node descriptor and a single
+	 * map record. The map record is a continuation of the map
+	 * record contained in the header node. The size of the map
+	 * record is the size of the node, minus the size of
+	 * the node descriptor (14 bytes), minus the size of two offsets
+	 * (4 bytes), minus two bytes of free space. That is, the size of
+	 * the map record is the size of the node minus 20 bytes;
+	 * this keeps the length of the map record an even multiple of 4 bytes.
+	 * The start of the map record is not aligned to a 4-byte boundary:
+	 * it starts immediately after the node descriptor
+	 * (at an offset of 14 bytes).
+	 *
+	 * Two record offsets stored at the end of the node:
+	 *   record[1] = start of record 0 -> sizeof(hfs_bnode_desc)
+	 *   record[2] = start of free space
+	 */
+	rec_offsets = (__be16 *)(buf + node_size);
+
+	/* record #1 */
+	offset = sizeof(struct hfs_bnode_desc);
+	*--rec_offsets = cpu_to_be16(offset);
+
+	/* record #2 */
+	offset = node_size;
+	offset -= (u16)HFSPLUS_BTREE_MAP_NODE_RECS_COUNT * rec_size;
+	offset -= HFSPLUS_BTREE_MAP_NODE_RESERVED_BYTES;
+	*--rec_offsets = cpu_to_be16(offset);
+}
+
+static inline
+int hfsplus_write_attributes_file_node(struct inode *attr_file, char *buf,
+					u16 node_size, int *index)
+{
+	struct address_space *mapping;
+	struct page *page;
+	void *kaddr;
+	u32 written = 0;
+
+	mapping = attr_file->i_mapping;
+
+	for (; written < node_size; (*index)++, written += PAGE_SIZE) {
+		page = read_mapping_page(mapping, *index, NULL);
+		if (IS_ERR(page))
+			return PTR_ERR(page);
+
+		kaddr = kmap_local_page(page);
+		memcpy(kaddr, buf + written,
+			min_t(size_t, PAGE_SIZE, node_size - written));
+		kunmap_local(kaddr);
+
+		set_page_dirty(page);
+		put_page(page);
+	}
+
+	return 0;
 }
 
 static int hfsplus_create_attributes_file(struct super_block *sb)
 {
-	int err = 0;
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
 	struct inode *attr_file;
 	struct hfsplus_inode_info *hip;
+	struct hfs_bnode_desc *desc;
 	u32 clump_size;
 	u16 node_size = HFSPLUS_ATTR_TREE_NODE_SIZE;
+	u32 next_node;
+	u32 map_node_idx;
+	u32 map_nodes;
 	char *buf;
-	int index, written;
-	struct address_space *mapping;
-	struct page *page;
+	int index;
 	int old_state = HFSPLUS_EMPTY_ATTR_TREE;
+	int err = 0;
 
 	hfs_dbg("ino %d\n", HFSPLUS_ATTR_CNID);
 
@@ -195,7 +274,7 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 	}
 
 	while (hip->alloc_blocks < hip->clump_blocks) {
-		err = hfsplus_file_extend(attr_file, false);
+		err = hfsplus_file_extend(attr_file, true);
 		if (unlikely(err)) {
 			pr_err("failed to extend attributes file\n");
 			goto end_attr_file_creation;
@@ -212,28 +291,30 @@ static int hfsplus_create_attributes_file(struct super_block *sb)
 		goto end_attr_file_creation;
 	}
 
-	hfsplus_init_header_node(attr_file, clump_size, buf, node_size);
+	map_nodes = hfsplus_init_header_node(attr_file, clump_size, buf, node_size);
 
-	mapping = attr_file->i_mapping;
+	desc = (struct hfs_bnode_desc *)buf;
+	next_node = be32_to_cpu(desc->next);
 
 	index = 0;
-	written = 0;
-	for (; written < node_size; index++, written += PAGE_SIZE) {
-		void *kaddr;
 
-		page = read_mapping_page(mapping, index, NULL);
-		if (IS_ERR(page)) {
-			err = PTR_ERR(page);
-			goto failed_header_node_init;
-		}
+	err = hfsplus_write_attributes_file_node(attr_file, buf,
+						 node_size, &index);
+	if (unlikely(err))
+		goto failed_header_node_init;
 
-		kaddr = kmap_atomic(page);
-		memcpy(kaddr, buf + written,
-			min_t(size_t, PAGE_SIZE, node_size - written));
-		kunmap_atomic(kaddr);
+	for (map_node_idx = 0; map_node_idx < map_nodes; map_node_idx++) {
+		if (next_node >= map_nodes)
+			next_node = 0;
 
-		set_page_dirty(page);
-		put_page(page);
+		hfsplus_init_map_node(buf, node_size, next_node);
+
+		err = hfsplus_write_attributes_file_node(attr_file, buf,
+							 node_size, &index);
+		if (unlikely(err))
+			goto failed_header_node_init;
+
+		next_node++;
 	}
 
 	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY);
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 9e71b9a03b60..07dfc39630ab 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -518,6 +518,8 @@ struct hfs_btree_header_rec {
 #define HFSPLUS_BTREE_HDR_MAP_REC_INDEX		2	/* Map (bitmap) record in Header node */
 #define HFSPLUS_BTREE_MAP_NODE_REC_INDEX	0	/* Map record in Map Node */
 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
+#define HFSPLUS_BTREE_MAP_NODE_RECS_COUNT	2
+#define HFSPLUS_BTREE_MAP_NODE_RESERVED_BYTES	2
 
 /* btree key type */
 #define HFSPLUS_KEY_CASEFOLDING		0xCF	/* case-insensitive */
-- 
2.43.0

