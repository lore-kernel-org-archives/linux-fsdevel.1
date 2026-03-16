Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEBE31A549
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627595; cv=none; b=CaTv/N1ieusFrHfnyewW+LnA6eMXD8Pv2l6BWrDlmX5sgzLDGpXpJnUH8OkevRo1wZpRwGWyKO5WMx6G4tf/zbwZ7K/6PBY30EfnJ0zWA9TgL46WbfjAcvWm70ihYTFwS3aMry7XZGtCzu2QwN4W21rktApvCA3LhLsXfdavHnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627595; c=relaxed/simple;
	bh=yu+S8R+pK+33lsnE7FYOq6qmxNWcbPDCQlsvlNgDMM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhKwVjMnsNCaG4ElJR5pGOToR35YMOSWVPYwtiPGCS3V/yp7c4awMvwpZ36uTEUEZ3lU1UQzxZfIX8EOWZSKjnbIlh7QNCbBiMvikWxF2XOz+gJltlwKAyeowm5yCG+/klqXNnBhMrEYxtA1VhA1+OmeD4euf9Vn93RQeVm5mDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=OduNgL8z; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="OduNgL8z"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e0553bdso31939877b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627590; x=1774232390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/1bLFupBaqa51OS+5bVlTfjhcTNIlB25/FsSiOAz7M=;
        b=OduNgL8z8nWJf3Ttdf3JtzK3a9W3H3MuQ+y5Gj5UWjRGeqvfkuJfTGKEdgQBT3EXMR
         1Z64sEkEKxwktTu+YCUSVnfrmZTuzh46ngBvag41lm230aer34dk33xfPKhGi2GCXK0o
         l7MuT/ScvXMDHAL5Lca/4pFfpN0i2z0E2QN9Z/gLywhDuFwtcKLPYVx8pvo8mdbQqhdv
         DfWNjH/ejfhoaWbawzSXcwIbRWm2xFDCE2jgtaGLidbbraBxR+mUCrMjNaCzySOu7N7i
         O5lxiIaBmOOOqxsK2TbICSfAj6UPg3J7hB+eWVblStVX8z7sqbwxynQ5wQBzCs1nyRRQ
         H0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627590; x=1774232390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x/1bLFupBaqa51OS+5bVlTfjhcTNIlB25/FsSiOAz7M=;
        b=IjQLtsfxW9La5rnnhyVbNEbHX0wH5X0ziSFCg0U1i5SWkMg043YtroPInSqmN0mQPF
         pHeYBA3XF9/IzB43vhgD2EjCiLgOSppomsooT+l0I1RToirUuMKAiH0Yrn8kY+QhAxAz
         VfLhQT1UA/zEyFfVgIQTamwdIBTqw1eXSbWgWFcHkiIZOLlU7szfOHe/aYgx/dBxK7NI
         BSkXT/XlLCN9pu7VMvYN/O1az2k0+4XBm+2e0Z2tcjIpoazKjEIv9Xqt8VtLUWqgBioE
         JUIHw/vvjGYm2RYWSIW+vo46GXJK4RnLGGGTZIWLxpWvEEmzyeVGz55HG4/DqIC7FTuE
         90vQ==
X-Gm-Message-State: AOJu0Yz9Q3nnSp0sS9eCgmUH/v+iIsaoNXVCdKrUDVbGkzaniF3VNK0g
	0P9FNZJtm4YetpQobgi5bNkFzzFPRN5BqYUJXcvxEO1XshmIfMBZETKNebWIXkxdzc2j7LKt32b
	aniPg
X-Gm-Gg: ATEYQzwHj9VyZXOPDyTfYVaguPmh6t1YTYDAgJsVA+Jk/xrCYV+fBXB/QkbwTG4jt2n
	FSusJEFFXllv4K+Mq9Un8jbdWbSY3ygs4zXBVOMkrRvMKIrKD80L7x7yH7fNx6CnLMVHkWUciAm
	52PiDOGNP9TKXPy0HIt9+4MSh4P5nTBi+QLJ6AOfm2JPG6/vmNnlJ1S/i6TxDKgVOanUsInk93m
	UWdvmxTtUwbKFFl6lmLL/PqrvRnkehxk6Mu3l9VVDbn90c/uRXSDCgKGuibLXPa+I+DAVnvheww
	7HsjwnU8uTGyKHviVnXFUgsAw1HFtIe7/5AZAmVBH1a2bx+IFoOzkjZnij4FjIsut4cgqWkCNMr
	Ey0+wJWUN24JJeckv57gyZdGTuiAPELEKles0YIA5wMuXbK6nq1g0CMhUgb9GujAOqnSeTOM7NH
	WCGv+YZvIxUH3XNpJ7yMNCB0INBbNYm8NHF4lE7sNwP1yIwMIxqdMeWtJTb/Eu604MFdrFN+4ba
	CcB4hibwgaaNZq7DDj/amCo
X-Received: by 2002:a05:690c:c24f:b0:794:ecaf:c501 with SMTP id 00721157ae682-79a1c1b129emr109975717b3.46.1773627590266;
        Sun, 15 Mar 2026 19:19:50 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:49 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 48/79] ssdfs: introduce b-tree hierarchy object
Date: Sun, 15 Mar 2026 19:17:47 -0700
Message-ID: <20260316021800.1694650-21-slava@dubeyko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316021800.1694650-1-slava@dubeyko.com>
References: <20260316021800.1694650-1-slava@dubeyko.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Complete patchset is available here:
https://github.com/dubeyko/ssdfs-driver/tree/master/patchset/linux-kernel-6.18.0

B-tree needs to serve the operations of adding items, inserting
items, and deleting items. These operations could require
modification of b-tree structure (adding and deleting nodes).
Also, indexes need to be updated in parent nodes. SSDFS file
system uses the special b-tree hierarchy object to manage
the b-tree structure. For every b-tree modification request,
file system logic creates the hierarchy object and executes
the b-tree hierarchy check. The checking logic defines the actions
that should be done for every level of b-tree to execute b-tree
node's add or delete operation. Finally, b-tree hierarchy object
represents the actions plan that modification logic has to execute.

The main goal of checking b-tree hierarchy for add operation is
to define how many new nodes and which type(s) should be added.
Any b-tree starts with creation of root node. The root node can
store only two index keys. Initially, SSDFS logic adds leaf
nodes into empty b-tree. If root node already contains two index
keys on leaf nodes, then hybrid node needs to be added into
the b-tree. Hybrid node contains as index as item areas. New items
will be added into items area of hybrid node until this area
becomes completely full. B-tree logic allocates new leaf node,
all existing items in hybrid node are moved into newly created leaf
node, and index key is added into hybrid node's index area.
Such operation repeat multiple times until index area of hybrid
node becomes completely full. Now index area is resized by
increasing twice in size after moving existing items into newly
created node. Finally, hybrid node will be converted into index node.
If root node contains two index keys on hybrid nodes, then
index node will be added in the b-tree. Generaly speaking, the leaf
nodes are always allocated for the lowest level. Next level contains
hybrid nodes. And the rest of b-tree levels contain index nodes.

Every b-tree node has associated hash value that represents
starting hash value of records sequence in the node. This hash
value is stored in index key that keeps parent node. Finally,
hash values are used for search items in the b-tree.
If modification operation changes starting hash value in
the node, then index key in parent node has to be updated.
The checking logic identifies all parent nodes that requires
index keys update. As a result, modification logic executes
index keys update in all parent nodes that were selected for
update by checking logic. Delete operation requires to identify
which nodes are empty and should be deleted/invalidated.
This invalidation plan is executed by modification logic,
finally.

For every b-tree modification request, file system logic creates
the hierarchy object and executes the b-tree hierarchy check.
The checking logic defines the actions that should be done for
every level of b-tree to execute b-tree node's add or delete
operation. Finally, b-tree hierarchy object represents the actions
plan that modification logic has to execute. The execution logic
simply starts from the bottom of the hierarchy and executes planned
action for every level of b-tree. The planned actions could include
adding a new empty node, moving items from hybrid parent node into
leaf one, rebalancing b-tree, updating indexes. Finally, b-tree
should be able to receive new items/indexes and be consistent.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/btree_hierarchy.h | 336 +++++++++++++++++++++++++++++++++++++
 1 file changed, 336 insertions(+)
 create mode 100644 fs/ssdfs/btree_hierarchy.h

diff --git a/fs/ssdfs/btree_hierarchy.h b/fs/ssdfs/btree_hierarchy.h
new file mode 100644
index 000000000000..ebc9ab18d6ff
--- /dev/null
+++ b/fs/ssdfs/btree_hierarchy.h
@@ -0,0 +1,336 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/btree_hierarchy.h - btree hierarchy declarations.
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
+#ifndef _SSDFS_BTREE_HIERARCHY_H
+#define _SSDFS_BTREE_HIERARCHY_H
+
+/*
+ * struct ssdfs_hash_range - hash range
+ * @start: start hash
+ * @end: end hash
+ */
+struct ssdfs_hash_range {
+	u64 start;
+	u64 end;
+};
+
+/*
+ * struct ssdfs_btree_node_position - node's position range
+ * @state: intersection state
+ * @start: starting node's position
+ * @count: number of positions in the range
+ */
+struct ssdfs_btree_node_position {
+	int state;
+	u16 start;
+	u16 count;
+};
+
+/* Intersection states */
+enum {
+	SSDFS_HASH_RANGE_INTERSECTION_UNDEFINED,
+	SSDFS_HASH_RANGE_LEFT_ADJACENT,
+	SSDFS_HASH_RANGE_INTERSECTION,
+	SSDFS_HASH_RANGE_RIGHT_ADJACENT,
+	SSDFS_HASH_RANGE_OUT_OF_NODE,
+	SSDFS_HASH_RANGE_INTERSECTION_STATE_MAX
+};
+
+/*
+ * struct ssdfs_btree_node_insert - insert position
+ * @op_state: operation state
+ * @hash: hash range of insertion
+ * @pos: position descriptor
+ */
+struct ssdfs_btree_node_insert {
+	int op_state;
+	struct ssdfs_hash_range hash;
+	struct ssdfs_btree_node_position pos;
+};
+
+/*
+ * struct ssdfs_btree_node_move - moving range descriptor
+ * @op_state: operation state
+ * @direction: moving direction
+ * @pos: position descriptor
+ */
+struct ssdfs_btree_node_move {
+	int op_state;
+	int direction;
+	struct ssdfs_btree_node_position pos;
+};
+
+/*
+ * struct ssdfs_btree_node_delete - deleting node's index descriptor
+ * @op_state: operation state
+ * @node_index: node index for deletion
+ */
+struct ssdfs_btree_node_delete {
+	int op_state;
+	struct ssdfs_btree_index_key node_index;
+};
+
+/* Possible operation states */
+enum {
+	SSDFS_BTREE_AREA_OP_UNKNOWN,
+	SSDFS_BTREE_AREA_OP_REQUESTED,
+	SSDFS_BTREE_AREA_OP_DONE,
+	SSDFS_BTREE_AREA_OP_FAILED,
+	SSDFS_BTREE_AREA_OP_STATE_MAX
+};
+
+/* Possible moving directions */
+enum {
+	SSDFS_BTREE_MOVE_NOWHERE,
+	SSDFS_BTREE_MOVE_TO_PARENT,
+	SSDFS_BTREE_MOVE_TO_CHILD,
+	SSDFS_BTREE_MOVE_TO_LEFT,
+	SSDFS_BTREE_MOVE_TO_RIGHT,
+	SSDFS_BTREE_MOVE_DIRECTION_MAX
+};
+
+/* Btree level's flags */
+#define SSDFS_BTREE_LEVEL_ADD_NODE		(1 << 0)
+#define SSDFS_BTREE_LEVEL_ADD_INDEX		(1 << 1)
+#define SSDFS_BTREE_LEVEL_UPDATE_INDEX		(1 << 2)
+#define SSDFS_BTREE_LEVEL_ADD_ITEM		(1 << 3)
+#define SSDFS_BTREE_INDEX_AREA_NEED_MOVE	(1 << 4)
+#define SSDFS_BTREE_ITEMS_AREA_NEED_MOVE	(1 << 5)
+#define SSDFS_BTREE_TRY_RESIZE_INDEX_AREA	(1 << 6)
+#define SSDFS_BTREE_LEVEL_DELETE_NODE		(1 << 7)
+#define SSDFS_BTREE_LEVEL_DELETE_INDEX		(1 << 8)
+#define SSDFS_BTREE_LEVEL_FLAGS_MASK		0x1FF
+
+#define SSDFS_BTREE_ADD_NODE_MASK \
+	(SSDFS_BTREE_LEVEL_ADD_NODE | SSDFS_BTREE_LEVEL_ADD_INDEX | \
+	 SSDFS_BTREE_LEVEL_UPDATE_INDEX | SSDFS_BTREE_LEVEL_ADD_ITEM | \
+	 SSDFS_BTREE_INDEX_AREA_NEED_MOVE | \
+	 SSDFS_BTREE_ITEMS_AREA_NEED_MOVE | \
+	 SSDFS_BTREE_TRY_RESIZE_INDEX_AREA)
+
+#define SSDFS_BTREE_DELETE_NODE_MASK \
+	(SSDFS_BTREE_LEVEL_UPDATE_INDEX | SSDFS_BTREE_LEVEL_DELETE_NODE | \
+	 SSDFS_BTREE_LEVEL_DELETE_INDEX | SSDFS_BTREE_ITEMS_AREA_NEED_MOVE)
+
+/*
+ * struct ssdfs_btree_level_node - node descriptor
+ * @type: node's type
+ * @index_hash: old index area's hash pair
+ * @items_hash: old items area's hash pair
+ * @ptr: pointer on node's object
+ */
+struct ssdfs_btree_level_node {
+	int type;
+	struct ssdfs_hash_range index_hash;
+	struct ssdfs_hash_range items_hash;
+	struct ssdfs_btree_node *ptr;
+};
+
+/*
+ * struct ssdfs_btree_node_details - b-tree node details
+ * @ptr: node pointer
+ * @index_area.index_count: count of indexes in index area
+ * @index_area.index_capacity: capacity of indexes in index area
+ * @items_area.area_size: items area's size in bytes
+ * @items_area.free_space: items area's free space in bytes
+ * @items_area.item_size: size of item in bytes
+ * @items_area.min_item_size: minimal size of item in bytes
+ * @items_area.max_item_size: maximum size of item in bytes
+ * @items_area.items_count: count of items in items area
+ * @items_area.items_capacity: capacity of items in items area
+ */
+struct ssdfs_btree_node_details {
+	struct ssdfs_btree_node *ptr;
+
+	struct {
+		u16 index_count;
+		u16 index_capacity;
+	} index_area;
+
+	struct {
+		u32 area_size;
+		u32 free_space;
+		u16 item_size;
+		u8 min_item_size;
+		u16 max_item_size;
+		u16 items_count;
+		u16 items_capacity;
+	} items_area;
+};
+
+/*
+ * struct ssdfs_btree_level_node_desc - descriptor of level's nodes
+ * @left_node: left node from the old node of the level
+ * @old_node: old node of the level
+ * @right_node: right node from the old node of the level
+ * @new_node: created empty node
+ */
+struct ssdfs_btree_level_node_desc {
+	struct ssdfs_btree_level_node left_node;
+	struct ssdfs_btree_level_node old_node;
+	struct ssdfs_btree_level_node right_node;
+	struct ssdfs_btree_level_node new_node;
+};
+
+/*
+ * struct ssdfs_btree_level - btree level descriptor
+ * @flags: level's flags
+ * @index_area.area_size: size of the index area
+ * @index_area.free_space: free space in index area
+ * @index_area.hash: hash range of index area
+ * @items_area.add: adding index descriptor
+ * @index_area.insert: insert position descriptor
+ * @index_area.move: move range descriptor
+ * @index_area.delete: delete index descriptor
+ * @items_area.area_size: size of the items area
+ * @items_area.free_space: free space in items area
+ * @items_area.hash: hash range of items area
+ * @items_area.add: adding item descriptor
+ * @items_area.insert: insert position descriptor
+ * @items_area.child2parent: child to/from parent move range descriptor
+ * @items_area.old2sibling: sibling to/from sibling move range descriptor
+ * @nodes: descriptor of level's nodes
+ */
+struct ssdfs_btree_level {
+	u32 flags;
+
+	struct {
+		u32 area_size;
+		u32 free_space;
+		struct ssdfs_hash_range hash;
+		struct ssdfs_btree_node_insert add;
+		struct ssdfs_btree_node_insert insert;
+		struct ssdfs_btree_node_move move;
+		struct ssdfs_btree_node_delete delete;
+	} index_area;
+
+	struct {
+		u32 area_size;
+		u32 free_space;
+		struct ssdfs_hash_range hash;
+		struct ssdfs_btree_node_insert add;
+		struct ssdfs_btree_node_insert insert;
+		struct ssdfs_btree_node_move child2parent;
+		struct ssdfs_btree_node_move old2sibling;
+	} items_area;
+
+	struct ssdfs_btree_level_node_desc nodes;
+};
+
+/*
+ * struct ssdfs_btree_state_descriptor - btree's state descriptor
+ * @height: btree height
+ * @increment_height: request to increment tree's height
+ * @node_size: size of the node in bytes
+ * @index_size: size of the index record in bytes
+ * @min_item_size: minimum item size in bytes
+ * @max_item_size: maximum item size in bytes
+ * @index_area_min_size: minimum size of index area in bytes
+ */
+struct ssdfs_btree_state_descriptor {
+	int height;
+	bool increment_height;
+	u32 node_size;
+	u16 index_size;
+	u16 min_item_size;
+	u16 max_item_size;
+	u16 index_area_min_size;
+};
+
+/*
+ * struct ssdfs_btree_hierarchy - btree's hierarchy descriptor
+ * @desc: btree state's descriptor
+ * @array_ptr: btree level's array
+ */
+struct ssdfs_btree_hierarchy {
+	struct ssdfs_btree_state_descriptor desc;
+	struct ssdfs_btree_level **array_ptr;
+};
+
+/* Btree hierarchy inline methods */
+static inline
+bool need_add_node(struct ssdfs_btree_level *level)
+{
+	return level->flags & SSDFS_BTREE_LEVEL_ADD_NODE;
+}
+
+static inline
+bool need_delete_node(struct ssdfs_btree_level *level)
+{
+	return level->flags & SSDFS_BTREE_LEVEL_DELETE_NODE;
+}
+
+/* Btree hierarchy API */
+struct ssdfs_btree_hierarchy *
+ssdfs_btree_hierarchy_allocate(struct ssdfs_btree *tree);
+void ssdfs_btree_hierarchy_init(struct ssdfs_btree *tree,
+				struct ssdfs_btree_hierarchy *hierarchy);
+void ssdfs_btree_hierarchy_free(struct ssdfs_btree_hierarchy *hierarchy);
+
+bool need_update_parent_index_area(u64 start_hash,
+				   struct ssdfs_btree_node *child);
+int ssdfs_btree_check_hierarchy_for_add(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_add(struct ssdfs_btree_hierarchy *ptr,
+					int cur_height,
+					struct ssdfs_btree_search *search);
+int ssdfs_btree_check_hierarchy_for_delete(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_delete(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search);
+int ssdfs_btree_check_hierarchy_for_update(struct ssdfs_btree *tree,
+					   struct ssdfs_btree_search *search,
+					   struct ssdfs_btree_hierarchy *ptr);
+int ssdfs_btree_process_level_for_update(struct ssdfs_btree_hierarchy *ptr,
+					 int cur_height,
+					 struct ssdfs_btree_search *search);
+bool __need_migrate_items_to_parent_node(struct ssdfs_btree_node *parent,
+					 struct ssdfs_btree_node *child);
+int ssdfs_btree_check_hierarchy_for_parent_child_merge(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy);
+int ssdfs_btree_process_level_for_node_merge(struct ssdfs_btree_hierarchy *ptr,
+					     int cur_height,
+					     struct ssdfs_btree_search *search);
+bool __need_merge_sibling_nodes(struct ssdfs_btree_node *parent,
+				struct ssdfs_btree_node *child);
+int ssdfs_btree_check_hierarchy_for_siblings_merge(struct ssdfs_btree *tree,
+					struct ssdfs_btree_search *search,
+					struct ssdfs_btree_hierarchy *hierarchy);
+
+/* Btree hierarchy internal API*/
+void ssdfs_btree_prepare_add_node(struct ssdfs_btree *tree,
+				  int node_type,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_level *level,
+				  struct ssdfs_btree_node *node);
+int ssdfs_btree_prepare_add_index(struct ssdfs_btree_level *level,
+				  u64 start_hash, u64 end_hash,
+				  struct ssdfs_btree_node *node);
+
+void ssdfs_show_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr);
+void ssdfs_debug_btree_hierarchy_object(struct ssdfs_btree_hierarchy *ptr);
+
+#endif /* _SSDFS_BTREE_HIERARCHY_H */
-- 
2.34.1

