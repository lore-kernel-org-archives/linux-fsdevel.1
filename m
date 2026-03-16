Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7689E31F99F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627601; cv=none; b=K6JKNbmQhGyW4CRApeCg6pEgQz0o4lzVSLaQdhKJsdcjtxS0Yv5KHNIXbuo9Ya2PKbBEV25tp8/U/MeDao+VFgsLd2vj7c530T1V5uRXXSS15MZTMoPrlcCPjMw3dxHb4f5c1J+UZo5nfO1v0vtbbGlN9/kI7pf1G3z06ukKmLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627601; c=relaxed/simple;
	bh=MS9aFJlg4OcGwkNXg9lQscAgVqi8kRhxwr1FdLmpNJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FRsI0CnggEpoOZisIM47yLqL4LoBsHzhO2x+GV1UhwcidJlvniEgtxb/JZGQruDBgRxOLLgYEdNdW9Q3ge0J+RuKHs2W5t1dHlxQL9c31c3vuq1QjBcTUMLEkbuuCgHj1zX7PFCwyJBqcH8K6I38wFBymH5ry8MnfLT+V+/0cck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=D7y1qDYj; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="D7y1qDYj"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7991db3dc98so36952187b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627594; x=1774232394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+d5yAWOdGBXSGDx9gwa/8tUPTpaWBMYNKv5P3r85TLo=;
        b=D7y1qDYjWRMfJtaH1LHXa0dnqMIbmOgIUvodncO5OaCV8Va0cFP5s3sSL8e0NRzDUM
         5Mdp7HuIpjkbE1s/h5JSNyeAKhcB8r105vSo12od/jVFG8noStaSS4xQOuMeqbq0nz2i
         skO5Cb8EDIGnsXYj3rnO+dNxGZOXyxm2PvobVmMttW5gIO0aiXoZk9ItsFjQzGrIn1Mm
         gfRBLyM55y5KPFz4anNLpnnRyml6X1pkHXAfYBCYeiu5Cl7suFJgF6JejaHWD+4ntC/B
         bFL2RbiKFUfeL+4TSc/D6gwDlF+LACQGz4CAYnQJyxN6OGzGrlZdpmKtg7ioJXRblZ8n
         aHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627594; x=1774232394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+d5yAWOdGBXSGDx9gwa/8tUPTpaWBMYNKv5P3r85TLo=;
        b=gE1ifHzuIg4p/S2/0AsBCidz4MHYSwXY6f1ACrASdIpoARMHncBdnq8FiGz6JSs1l4
         xnxs8pARRXnTObHwcN1OXY8bhFZknsscUjYCk7QT2OguGFyIF2Pwli4lKDENtChbiZlV
         UW53K7jKo+6Ux3DWWr56/jjstq0HAJjttGwYtqn31h3qWkDVI7A1uy3yRLf6wY0orWce
         0EzKd3TLiCgWZiwt6mT54j8svuc3J0orXrGaPV38NYe5h960o6dMadEg4WrbRdHaexgm
         86JU1S4ZLdukp4fRx9CUyxVJiNC+2fB9E9N+LP0ELtkEMxmWg6Gd+rnpFwaj3q9Mibab
         6mug==
X-Gm-Message-State: AOJu0YzWyQfW6HnvLvRmcAwfS4XgLNJkV2dEUKv3aEu1qYuuSZhPinkG
	28lupwpN72zIe1rlarhEU9qqxI9KyEN/p5sL5R3qnZMmoHzLBw5AGUTBcjksnDZyV7r+EiGDMq0
	uuzY/
X-Gm-Gg: ATEYQzyY5/y5ABQlsFLjvsco1SEFgxZmcixkxS30PGaYh4n+2z1UVBxhZlBHI5yig+v
	IOBw7Kc3ayWDDxIB0eku5CFSB40Uqg2ohXjRFqJCX02yuUwYTAXGfR15jbXnA8o63d1DJcdFrqU
	oR7ZG9Q0hmooH5o8ox48uRR9qIu3BzuGkM6Q3soNEg0qypJDmU4n+8ODRwCQyapHSX7um84Ntr/
	79sntyGyhWOEhlFZ9eRmE4+e34i9+nxsy2gnfCzfgr4ZHnsZzeGLr+UgC8sO5lG1qnF3Z3Vroi0
	FJzXHQ1cCtxpfESYZiam5XHe/TrpqXKmMMLtv7m5n5kOH4CT1BDFS3OgDGJejtAlxuXJmAK+ZgM
	WqydYx/DsbN7/XHOMs7GLqxxWDwoCCqvp/Zxis6ElacqESU9+zrVyfQJ0s6Fb6ptMicGDEUSg/v
	9YLPIV6tMCWgO7f2AI0/qsKao4oiz/5E9VNTgUhUsTKKaYNwhj1WBiHdk5degG95OuiI2VoAavJ
	82x+zt7FGZWlqb7L/5Jj5xy
X-Received: by 2002:a05:690c:6603:b0:794:ef94:1222 with SMTP id 00721157ae682-79a1c1d9441mr108958897b3.55.1773627593870;
        Sun, 15 Mar 2026 19:19:53 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:53 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 55/79] ssdfs: introduce extents b-tree
Date: Sun, 15 Mar 2026 19:17:50 -0700
Message-ID: <20260316021800.1694650-24-slava@dubeyko.com>
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

SSDFS raw extent describes a contiguous sequence of logical blocks
by means of segment ID, logical block number of starting position,
and length. By default, SSDFS inode has the private area of
128 bytes in size and SSDFS extent has 16 bytes in size. As a result,
the inode’s private area is capable to store not more than 8 raw
extents. Generally speaking, hybrid b-tree was opted with the goal
to store efficiently larger number of raw extents. First of all,
it was taken into account that file sizes can vary a lot on the same
file system’s volume. Moreover, the size of the same file could vary
significantly during its lifetime. Finally, b-tree is the really good
mechanism for storing the extents compactly with very flexible way of
increasing or shrinking the reserved space. Also b-tree provides very
efficient technique of extents lookup. Additionally, SSDFS file system
uses compression that guarantee the really compact storage of semi-empty
b-tree nodes. Moreover, hybrid b-tree provides the way to mix as index as
data records in the hybrid nodes with the goal to achieve much more
compact representation of b-tree’s content. It needs to point out that
extents b-tree’s nodes group the extent records into forks.
Generally speaking, the raw extent describes a position on the volume of
some contiguous sequence of logical blocks without any details about
the offset of this extent from a file’s beginning. As a result, the fork
describes an offset of some portion of file’s content from the file’s
beginning and number of logical blocks in this portion. Also fork contains
the space for three raw extents that are able to define the position of
three contiguous sequences of logical blocks on the file system’s volume.
Finally, one fork has 64 bytes in size. If anybody considers a b-tree
node of 4 KB in size then such node is capable to store about 64 forks with
192 extents in total. Generally speaking, even a small b-tree is able
to store a significant number of extents and to determine the position of
fragments of generally big file. If anybody imagines a b-tree with the two
4 KB nodes in total, every extent defines a position of 8 MB file’s
portion then such b-tree is able to describe a file of 3 GB in total.

Extents b-tree implements API:
(1) create - create extents b-tree
(2) destroy - destroy extents b-tree
(3) flush - flush dirty extents b-tree
(4) prepare_volume_extent - convert requested offset into extent
(5) recommend_migration_extent - find extent recommended for migration
(6) add_extent - add extent into the extents b-tree
(7) move_extent - move extent from one segment into another one
(8) truncate - truncate extent b-tree

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/extents_tree.h | 188 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 188 insertions(+)
 create mode 100644 fs/ssdfs/extents_tree.h

diff --git a/fs/ssdfs/extents_tree.h b/fs/ssdfs/extents_tree.h
new file mode 100644
index 000000000000..ac9c7b82cae1
--- /dev/null
+++ b/fs/ssdfs/extents_tree.h
@@ -0,0 +1,188 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/extents_tree.h - extents tree declarations.
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
+#ifndef _SSDFS_EXTENTS_TREE_H
+#define _SSDFS_EXTENTS_TREE_H
+
+#define SSDFS_COMMIT_QUEUE_DEFAULT_CAPACITY	(16)
+#define SSDFS_COMMIT_QUEUE_THRESHOLD		(32)
+
+/*
+ * struct ssdfs_commit_queue - array of segment IDs
+ * @ids: array of segment IDs
+ * @count: number of items in the queue
+ * @capacity: maximum number of available positions in the queue
+ */
+struct ssdfs_commit_queue {
+	u64 *ids;
+	u32 count;
+	u32 capacity;
+};
+
+/*
+ * struct ssdfs_extents_btree_info - extents btree info
+ * @type: extents btree type
+ * @state: extents btree state
+ * @forks_count: count of the forks in the whole extents tree
+ * @lock: extents btree lock
+ * @generic_tree: pointer on generic btree object
+ * @inline_forks: pointer on inline forks array
+ * @buffer.tree: piece of memory for generic btree object
+ * @buffer.forks: piece of memory for the inline forks
+ * @root: pointer on root node
+ * @root_buffer: buffer for root node
+ * @updated_segs: updated segments queue
+ * @desc: b-tree descriptor
+ * @owner: pointer on owner inode object
+ * @fsi: pointer on shared file system object
+ *
+ * A newly created inode tries to store extents into inline
+ * forks. Every fork contains three extents. The raw on-disk
+ * inode has internal private area that is able to contain the
+ * two inline forks or root node of extents btree and extended
+ * attributes btree. If inode hasn't extended attributes and
+ * the amount of extents are lesser than six then everithing
+ * can be stored inside of inline forks. Otherwise, the real
+ * extents btree should be created.
+ */
+struct ssdfs_extents_btree_info {
+	atomic_t type;
+	atomic_t state;
+	atomic64_t forks_count;
+
+	struct rw_semaphore lock;
+	struct ssdfs_btree *generic_tree;
+	struct ssdfs_raw_fork *inline_forks;
+	union {
+		struct ssdfs_btree tree;
+		struct ssdfs_raw_fork forks[SSDFS_INLINE_FORKS_COUNT];
+	} buffer;
+	struct ssdfs_btree_inline_root_node *root;
+	struct ssdfs_btree_inline_root_node root_buffer;
+	struct ssdfs_commit_queue updated_segs;
+
+	struct ssdfs_extents_btree_descriptor desc;
+	struct ssdfs_inode_info *owner;
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Extents tree types */
+enum {
+	SSDFS_EXTENTS_BTREE_UNKNOWN_TYPE,
+	SSDFS_INLINE_FORKS_ARRAY,
+	SSDFS_PRIVATE_EXTENTS_BTREE,
+	SSDFS_EXTENTS_BTREE_TYPE_MAX
+};
+
+/* Extents tree states */
+enum {
+	SSDFS_EXTENTS_BTREE_UNKNOWN_STATE,
+	SSDFS_EXTENTS_BTREE_CREATED,
+	SSDFS_EXTENTS_BTREE_INITIALIZED,
+	SSDFS_EXTENTS_BTREE_DIRTY,
+	SSDFS_EXTENTS_BTREE_CORRUPTED,
+	SSDFS_EXTENTS_BTREE_STATE_MAX
+};
+
+/*
+ * struct ssdfs_file_fragment - file's fragment
+ * @start_blk: offset inside of file in logical blocks
+ * @len: fragment's length in logical blocks
+ * @extent: raw extent in segment
+ */
+struct ssdfs_file_fragment {
+	u64 start_blk;
+	u32 len;
+	struct ssdfs_raw_extent extent;
+};
+
+/*
+ * Extents tree API
+ */
+int ssdfs_extents_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_init(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_inode_info *ii);
+void ssdfs_extents_tree_destroy(struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_flush(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii);
+int ssdfs_extents_tree_add_updated_seg_id(struct ssdfs_extents_btree_info *tree,
+					  u64 seg_id);
+
+int __ssdfs_prepare_volume_extent(struct ssdfs_fs_info *fsi,
+				  struct inode *inode,
+				  struct ssdfs_logical_extent *requested,
+				  struct ssdfs_volume_extent *place);
+int ssdfs_prepare_volume_extent(struct ssdfs_fs_info *fsi,
+				struct ssdfs_segment_request *req);
+int ssdfs_recommend_migration_extent(struct ssdfs_fs_info *fsi,
+				     struct ssdfs_segment_request *req,
+				     struct ssdfs_zone_fragment *fragment);
+bool ssdfs_extents_tree_has_logical_block(u64 blk_offset, struct inode *inode);
+int ssdfs_extents_tree_add_extent(struct inode *inode,
+				  struct ssdfs_segment_request *req);
+int ssdfs_extents_tree_move_extent(struct ssdfs_extents_btree_info *tree,
+				   u64 blk, u32 len,
+				   struct ssdfs_raw_extent *new_extent,
+				   struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_truncate(struct inode *inode);
+
+/*
+ * Extents tree internal API
+ */
+int ssdfs_extents_tree_find_fork(struct ssdfs_extents_btree_info *tree,
+				 u64 blk,
+				 struct ssdfs_btree_search *search);
+int __ssdfs_extents_tree_add_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_change_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_raw_extent *extent,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_truncate_extent(struct ssdfs_extents_btree_info *tree,
+					u64 blk, u32 new_len,
+					struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_delete_extent(struct ssdfs_extents_btree_info *tree,
+				     u64 blk,
+				     struct ssdfs_btree_search *search);
+int ssdfs_extents_tree_delete_all(struct ssdfs_extents_btree_info *tree);
+int __ssdfs_extents_btree_node_get_fork(struct ssdfs_fs_info *fsi,
+					struct ssdfs_btree_node_content *content,
+					u32 area_offset,
+					u32 area_size,
+					u32 node_size,
+					u16 item_index,
+					struct ssdfs_raw_fork *fork);
+
+void ssdfs_debug_extents_btree_object(struct ssdfs_extents_btree_info *tree);
+
+/*
+ * Extents btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_extents_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_extents_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_extents_btree_node_ops;
+
+#endif /* _SSDFS_EXTENTS_TREE_H */
-- 
2.34.1

