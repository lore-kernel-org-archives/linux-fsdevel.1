Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F9D31D730
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627597; cv=none; b=kG/jqH4kVMPpLGeqIe/Hy1MCH8mzigHsMmcy74+k49YjIUiIhWSpcGSG+PxNQnwPg9soLCrgeE9dZyFhr3pg+mWIOTg2FxHnwzcjjDbtzbQ/hOmFBPkZ/cyq4Sm9QptNmfckHpDYtLs1IT7vKYfn0HYfHCCSaYU4AN9lcOHDBvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627597; c=relaxed/simple;
	bh=+iBzrQtmyFrdxv92AceAWva4/vE+QsQPOsIikE2tHGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iBQoW6GbFzsEYuqN7MIrciGoouQM1aZ481L/x6G+gIc/L5tnWmYyWHAP0SsuphNmT2wflJ4qSAPRd5XThzcv2LmhfR6NdNF4rQ3f8lV8wdpZbWRRfdpOEpyc+YvAbu7m6V+DY5so1LGJOCfMeG1LfbhNYdQmmtLV5rGEJKEnkNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=yyn56ReY; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="yyn56ReY"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7927261a3acso31978977b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627591; x=1774232391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JUmX2LPYUzROZqwqZLGkwTAhsQPLb5sLpvceEQ6Jt10=;
        b=yyn56ReYylzx/LioGRUF2VfFg54ccHjjSezXxzr3Jk7q7jF+xnjdxwiZo2yNIsSoIf
         iQmLNwZO47F9GPMWQGYLjvJx5MGgzOrBz3Z6B9JBGsxndsIpC/b5lGzL0joRN4UQRdx7
         esD9J5aaN5AnP3/AgNV/3+jW3QvbDBMW5PQg+w/3T20rBgkq3u0kShQOkJi9Z/739+ee
         a2yp+G7eli/yzSgmddR8QhWV/hU7uWGPFKJNoKANh4udKcU+CJ/0kmUBLdSvxx9ZIL0+
         A7NUziUfuFBpqhxCiuMvLIHOwxMTMgXMcla3oXaiYdHk+qDkalmPjUfs12kY05ILzlvc
         3cpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627591; x=1774232391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JUmX2LPYUzROZqwqZLGkwTAhsQPLb5sLpvceEQ6Jt10=;
        b=Z54w8PW1N+VW7vE02M05rPchGVddUXAZqiqzGByZlUxqalT/VrfLfNNO9vRsLXo5Pi
         XBDWD8JeuAG0n/2aCaK9BIzLWgqKVVCIq1D0tkEcHYvCIyPmNX+3a2Rh9kwyUoqkwdO7
         9zaeFpN4gOxFY6tDn/n1X9RVE0DcD8Jdn0jKvWzO9dnzVc9d17AZeJIFXpNqTtB/MESh
         J0WtTvj6VnkagzwrwzxJkWHsqz+KKETwk+F7aB8nnA9AjCAWXQteVgFHfBHxmuut2+W0
         G05BSnCX2GyJ18PAfKAKe2nooyZ6QhbNIRf8VZtvdnXt5cFlyu/rp2d7VoWvWpQMLMhO
         tQMw==
X-Gm-Message-State: AOJu0Yz2cEeK4FT5TYTqvn0b/yzmGeHTqhWzLKMZXYAgzMw8VojsrQK7
	Maw1JEy+3twKgNhiLzeFEQfQrZDxmo+wrSZO4kxu6jYxX99AZGP9o5h7xXT/pRMvhP16bTUGZf2
	9RVT3
X-Gm-Gg: ATEYQzznr25tDOfK+giHvWgXK4cEHhVFJVWMHYEjxGBfL+QmPEAHiran8rSOXNVtl1m
	M1A1Gb8nBAaTCXb34cZM5AzIUW/BhAgUS8Bw44o56D37z6vp7q/pFRqQ19diP6zYde2tx1MYmBm
	kOc99Pz91fUZmhf2F0VuydSvtNBoCppU7BQbFWfzX+zw0ND7gnu7X2ObcEfRRGyMuMNeZueVIi7
	bKwLnoWbrFMPiYlFMRYDc9WpF8EA/J3pDDftNoMZ+nDYmjiaQ2lsksrIal1D1+b/NM3onrV8KWk
	q5tVnNFf6XrISVkpS9v2v0wZCdpvE54u2bEDu0dRh5sdKdB+ZCDSc/tHoi4v/OIh9jXxuchGo5A
	zrEKcYsH5P4/M3+kbZ/73AjbThUDRlFNQdvuQem9GxEP3x+WKrbV2A4F3/TQLZQY3//NI1XXZWq
	YD4PCya4JPSZucFqE9qfhgW1WBAmix3rq7DZQV3WkcPMc2+Lr2o40F0ngRHpK8mFPzL021CcsCW
	6Ig9YiTu6J/kDX+I60U2+A/
X-Received: by 2002:a05:690c:90:b0:798:1b2d:4bb7 with SMTP id 00721157ae682-79a1c0ff3fcmr114123507b3.25.1773627591506;
        Sun, 15 Mar 2026 19:19:51 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:50 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 50/79] ssdfs: introduce inodes b-tree
Date: Sun, 15 Mar 2026 19:17:48 -0700
Message-ID: <20260316021800.1694650-22-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316021800.1694650-1-slava@dubeyko.com>
References: <20260316021800.1694650-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Complete patchset is available here:
https://github.com/dubeyko/ssdfs-driver/tree/master/patchset/linux-kernel-6.18.0

SSDFS raw inode is the metadata structure of fixed size that
can vary from 256 bytes to several KBs. The size of inode is defined
during the file system’s volume creation. The most special part of
the SSDFS raw inode is the private area that is used for storing:
(1) small file inline, (2) root node of extents, dentries, and/or
xattr b-tree.

SSDFS inodes b-tree is the hybrid b-tree that includes the hybrid
nodes with the goal to use the node’s space in more efficient way
by means of combination the index and data records inside of the node.
Root node of inodes b-tree is stored into the log footer or partial
log header of every log. Generally speaking, it means that SSDFS file
system is using the massive replication of the root node of inodes
b-tree. Actually, inodes b-tree node’s space includes header,
index area (in the case of hybrid node), and array of inodes are ordered
by ID values. If node has 8 KB in size and inode structure is 256 bytes
in size then the maximum capacity of one inodes b-tree’s node is 32 inodes.

Generally speaking, inodes table can be imagined like an imaginary array
that is extended by means of adding the new inodes into the tail of
the array. However, inode can be allocated or deleted by virtue of
create file or delete file operations, for example. As a result, every
b-tree node has an allocation bitmap that is tracking the state (used
or free) of every inode in the b-tree node. The allocation bitmap provides
the mechanism of fast lookup a free inode with the goal to reuse
the inodes of deleted files.

Additionally, every b-tree node has a dirty bitmap that has goal to track
modification of inodes. Generally speaking, the dirty bitmap provides
the opportunity to flush not the whole node but the modified inodes only.
As a result, such bitmap could play the cornerstone role in
the delta-encoding or in the Diff-On-Write approach. Moreover, b-tree
node has a lock bitmap that has responsibility to implement the mechanism of
exclusive lock a particular inode without the necessity to lock
exclusively the whole node. Generally speaking, the lock bitmap was
introduced with the goal to improve the granularity of lock operation.
As a result, it provides the way to modify the different inodes in
the same b-tree node without the using of exclusive lock the whole b-tree
node. However, the exclusive lock of the whole tree has to be used for
the case of addition or deletion a b-tree node.

Inodes b-tree supports operations:
(1) find_item - find item in the b-tree
(2) find_range - find range of items in the b-tree
(3) extract_range - extract range of items from the node of b-tree
(4) allocate_item - allocate item in b-tree
(5) allocate_range - allocate range of items in b-tree
(6) insert_item - insert item into node of the b-tree
(7) insert_range - insert range of items into node of the b-tree
(8) change_item - change item in the b-tree
(9) delete_item - delete item from the b-tree
(10) delete_range - delete range of items from a node of b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/inodes_tree.h | 181 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 181 insertions(+)
 create mode 100644 fs/ssdfs/inodes_tree.h

diff --git a/fs/ssdfs/inodes_tree.h b/fs/ssdfs/inodes_tree.h
new file mode 100644
index 000000000000..95267c631dd5
--- /dev/null
+++ b/fs/ssdfs/inodes_tree.h
@@ -0,0 +1,181 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/inodes_tree.h - inodes btree declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ */
+
+#ifndef _SSDFS_INODES_TREE_H
+#define _SSDFS_INODES_TREE_H
+
+/*
+ * struct ssdfs_inodes_range - items range
+ * @start_hash: starting hash
+ * @start_index: staring index in the node
+ * @count: count of items in the range
+ */
+struct ssdfs_inodes_range {
+#define SSDFS_INODES_RANGE_INVALID_START	(U64_MAX)
+	u64 start_hash;
+#define SSDFS_INODES_RANGE_INVALID_INDEX	(U16_MAX)
+	u16 start_index;
+	u16 count;
+};
+
+/*
+ * struct ssdfs_inodes_btree_range - node's items range descriptor
+ * @list: free inode ranges queue
+ * @node_id: node identification number
+ * @area: items range
+ */
+struct ssdfs_inodes_btree_range {
+	struct list_head list;
+	u32 node_id;
+	struct ssdfs_inodes_range area;
+};
+
+/*
+ * struct ssdfs_free_inode_range_queue - free inode ranges queue
+ * @lock: queue's lock
+ * @list: queue's list
+ */
+struct ssdfs_free_inode_range_queue {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * struct ssdfs_inodes_btree_info - inodes btree info
+ * @generic_tree: generic btree description
+ * @lock: inodes btree lock
+ * @root_folder: copy of root folder's inode
+ * @upper_allocated_ino: maximal allocated inode ID number
+ * @last_free_ino: latest free inode ID number
+ * @allocated_inodes: allocated inodes count in the whole tree
+ * @free_inodes: free inodes count in the whole tree
+ * @inodes_capacity: inodes capacity in the whole tree
+ * @leaf_nodes: count of leaf nodes in the whole tree
+ * @nodes_count: count of all nodes in the whole tree
+ * @raw_inode_size: size in bytes of raw inode
+ * @free_inodes_queue: queue of free inode descriptors
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_inodes_btree_info {
+	struct ssdfs_btree generic_tree;
+
+	spinlock_t lock;
+	struct ssdfs_inode root_folder;
+	u64 upper_allocated_ino;
+	u64 last_free_ino;
+	u64 allocated_inodes;
+	u64 free_inodes;
+	u64 inodes_capacity;
+	u32 leaf_nodes;
+	u32 nodes_count;
+	u16 raw_inode_size;
+
+	/*
+	 * Inodes btree should have special allocation queue.
+	 * If a btree nodes has free (not allocated) inodes
+	 * items then the information about such btree node
+	 * should be added into queue. Moreover, queue should
+	 * contain as so many node's descriptors as free items
+	 * in the node.
+	 *
+	 * If some btree node has deleted inodes (free items)
+	 * then all node's descriptors should be added into
+	 * the head of allocation queue. Descriptors of the last
+	 * btree's node should be added into tail of the queue.
+	 * Information about node's descriptors should be added
+	 * into the allocation queue during btree node creation
+	 * or reading from the volume. Otherwise, allocation of
+	 * new items should be done from last leaf btree's node.
+	 */
+	struct ssdfs_free_inode_range_queue free_inodes_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/*
+ * Inline methods
+ */
+static inline
+bool is_free_inodes_range_invalid(struct ssdfs_inodes_btree_range *range)
+{
+	bool is_invalid;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_invalid = range->node_id == SSDFS_BTREE_NODE_INVALID_ID ||
+		range->area.start_hash == SSDFS_INODES_RANGE_INVALID_START ||
+		range->area.start_index == SSDFS_INODES_RANGE_INVALID_INDEX ||
+		range->area.count == 0;
+
+	if (is_invalid) {
+		SSDFS_ERR("node_id %u, start_hash %llx, "
+			  "start_index %u, count %u\n",
+			  range->node_id,
+			  range->area.start_hash,
+			  range->area.start_index,
+			  range->area.count);
+	}
+
+	return is_invalid;
+}
+
+/*
+ * Free inodes range API
+ */
+struct ssdfs_inodes_btree_range *ssdfs_free_inodes_range_alloc(void);
+void ssdfs_free_inodes_range_free(struct ssdfs_inodes_btree_range *range);
+void ssdfs_free_inodes_range_init(struct ssdfs_inodes_btree_range *range);
+
+/*
+ * Inodes btree API
+ */
+int ssdfs_inodes_btree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_inodes_btree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_inodes_btree_flush(struct ssdfs_inodes_btree_info *tree);
+
+int ssdfs_inodes_btree_allocate(struct ssdfs_inodes_btree_info *tree,
+				ino_t *ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_find(struct ssdfs_inodes_btree_info *tree,
+			    ino_t ino,
+			    struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_change(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_inodes_btree_delete(struct ssdfs_inodes_btree_info *tree,
+				ino_t ino);
+int ssdfs_inodes_btree_delete_range(struct ssdfs_inodes_btree_info *tree,
+				    ino_t ino, u16 count);
+
+void ssdfs_debug_inodes_btree_object(struct ssdfs_inodes_btree_info *tree);
+
+/*
+ * Inodes btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_inodes_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_inodes_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_inodes_btree_node_ops;
+
+#endif /* _SSDFS_INODES_TREE_H */
-- 
2.34.1

