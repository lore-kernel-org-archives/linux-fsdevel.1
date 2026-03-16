Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E703242DF
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627601; cv=none; b=vCjJ0UjGE8au5zDZ49F4ySw1nH+84Z2LOueUQIwJndS1pLsxZSslbg/dLYXv4G+3DXeD7SqbVaEfKsR4awZbW0jLZRAATxiU+ZZ1n83JhzFm4fySYhoAL+0nk08KTcT1spVKVXfGFsZFeQYHR8zOqr8xwt/ekqoMQ9c3dqRjCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627601; c=relaxed/simple;
	bh=mhf5og4JuFkKOOoDx838MNoLpp5bYMb2FbvQqeno+AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AlAsfIP0oEO9QOHhrOwO73u1fTcjkUQCDoeh1V0t3oXyFrV7tXCmlJUYERfmt7uLgOt/J3RzDA85vSOrNogSVHlzkhl2lExDOxfzcbaIoxa2V8hnvJrg84rmPVc7Ntt1jHW7U0lb2Klt5CCtoTtlodK/mZ0KFuPAbRmSpEi6Ndw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=1L5Miqf2; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="1L5Miqf2"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-794719afcd4so34400297b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627596; x=1774232396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FT01qd3dalPfHvuS8ffnlqvFvy1qjWMtUXMgrBMCh0Q=;
        b=1L5Miqf29ZqW1yrXt+1ihI/SnHw/+f8ZoKr6JFBIniMpR3ehNtbeKZkCvFo2xlHE5E
         v02IynADqUe53d0hx0LH9V7xfWfaVRzquw1b4JHiZfhSTLtQCszCpck1wbGqQYVXYqI+
         6qmTPEoUckuWHYTdP9Im9i60nzeQvdB0W447C50CEWXH68ucaVhUYQDNzTTGk5135l38
         de8lLsYgG8duOl3AK9MI5OXzCoCVdNMQjBPMt3+88ar4qGkG9vzZImTBGoWeORnaV87C
         Uj8F0a2yFp7wrm5oY87Sk0ErqVNmDgMFGAW0OOp7OYSQ1L4T/w06B1DPPvr1Ub4gVoQ6
         ARrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627596; x=1774232396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FT01qd3dalPfHvuS8ffnlqvFvy1qjWMtUXMgrBMCh0Q=;
        b=e36LA6ZxhGEOxBrZHWn9TV/lYhZJzwoF4y1FnEn4SuExaA9da+2CSMZ8Dj/oejyG9v
         z4vANvHkhgQV98QTDl32asLix2GJGr79n8K8+HGO/9b9MzVTBEdUHsXcxu5r1+GF9FWn
         V+nkUVsz8ahf0ExVUqgjlem1GgtB0P3uxMQBiKgzlsc2xLs2z2Ijy1qrmXVYILPBKkbD
         MvaOoHVJ/+okwrYOb3xWXJE1Jb1pTEWp+qszF4KAGxsLjjyRKso+R/uiBTLZ3JRtNQLE
         lVf3Ey5V6Eks3xVO5C5TrIywZQQspGkB38zHpwQgbZiY5BZ7BIgF80s+IE/yQY2uNAF3
         7giA==
X-Gm-Message-State: AOJu0Yyghs+mUWh1uhD8LZr+214Hpv10uaqfGnebDljRi0UMl4nvKDa0
	Eg8wKJmqeYUgZNlKLbO2rvGTcjzyl/x6zsQ7sxVqo5cOXhnSteDQ5Jl1pvDmIJVrzadZcgiQncT
	acEdg
X-Gm-Gg: ATEYQzz238j49GN/HHaFW4MV9t1wFhOsynyVKp2crDxddYB80IF7yq/308Zyn2uMsji
	Exi0SwdDlD9vf0oV7OQvbWTYqXbOqdGke38c87biaSrF0BW8mFcvfi5oFVc46Al4UDC4MLc02kc
	M73c7lwzxRhO9Pjqfp199BDpuV/6usBSdxu36NZuuE5pBMArFhIw2kvCRi1kFEaXOLa792Zkx+X
	8ARqM4b4w1q5fvo8gIhIY8XHuC67XZypiybdmm5rz3sZg5MU+GWtt/hQIEYHyrdzvVE6XsbsJAk
	sozBomBB2+6U4819nmOGNjo4MjszwSIejkE26bEb7O3LePIfikEuhWfVE3GSDYUCTMg45iTXqBy
	mOhYUtQFzhY3/SSYvB7Y71zaXsTwSsSMH2G1mlVgkUv1zvVD8Dhb0WYr/sVzP2qC3qkkcATcRGk
	FRHS/vSb2oHA95gWCZNtUrN4MmeuCDTMX0cXRRBEXEYHCOii2ghfJ22ITfURHz9R9EjbJp0JvVC
	tTJg2eeRETbnGrSRHz9WhPi
X-Received: by 2002:a05:690c:6089:b0:798:71ee:2a00 with SMTP id 00721157ae682-79a1c188895mr99326017b3.38.1773627596191;
        Sun, 15 Mar 2026 19:19:56 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:55 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 59/79] ssdfs: introduce shared extents b-tree
Date: Sun, 15 Mar 2026 19:17:52 -0700
Message-ID: <20260316021800.1694650-26-slava@dubeyko.com>
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

SSDFS file system has been designed to support
deduplication technique. There are two mechanisms
are supported by SSDFS: (1) erase block based
deduplication, (2) file based deduplication.
Shared extents b-tree implements file based
deduplication. It means that file system logic
can calculate the fingerprints of files' portions
and stores these fingerprints in the shared extents
b-tree. If the same fingerprint is already stored
into the shared extents b-tree, then deduplication
can happen on the file basis.

Also, shared extents b-tree has a dedicated thread
that executes the delayed extents invalidation. It means
that any file's extent, b-tree's extent, or the whole
b-tree can be added into the queue of this thread for
delayed invalidation instead of doing the immediate
extent invalidation. Generally speaking, it implies
that huge file can be deleted really fast, but the
real invalidation will happen in the background.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/shared_extents_tree.h | 146 +++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 fs/ssdfs/shared_extents_tree.h

diff --git a/fs/ssdfs/shared_extents_tree.h b/fs/ssdfs/shared_extents_tree.h
new file mode 100644
index 000000000000..6b9a200462d6
--- /dev/null
+++ b/fs/ssdfs/shared_extents_tree.h
@@ -0,0 +1,146 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/shared_extents_tree.h - shared extents tree declarations.
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
+#ifndef _SSDFS_SHARED_EXTENTS_TREE_H
+#define _SSDFS_SHARED_EXTENTS_TREE_H
+
+#include "fingerprint.h"
+
+/*
+ * struct ssdfs_invalidation_queue - invalidation queue object
+ * @queue: extents/index queue object
+ * @content: btree node's content buffer
+ * @thread: descriptor of queue's thread
+ */
+struct ssdfs_invalidation_queue {
+	struct ssdfs_extents_queue queue;
+	struct ssdfs_btree_node_content content;
+	struct ssdfs_thread_info thread;
+};
+
+/* Invalidation queue ID */
+enum {
+	SSDFS_EXTENT_INVALIDATION_QUEUE,
+	SSDFS_INDEX_INVALIDATION_QUEUE,
+	SSDFS_INVALIDATION_QUEUE_NUMBER
+};
+
+/*
+ * struct ssdfs_shared_extents_tree - shared extents tree object
+ * @state: shared extents btree state
+ * @lock: shared extents btree lock
+ * @generic_tree: generic btree description
+ * @shared_extents: count of the shared extents in the whole tree
+ * @array: invalidation queues array
+ * @wait_queue: wait queue of shared extents tree's thread
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_shared_extents_tree {
+	atomic_t state;
+	struct rw_semaphore lock;
+	struct ssdfs_btree generic_tree;
+
+	atomic64_t shared_extents;
+
+	struct ssdfs_invalidation_queue array[SSDFS_INVALIDATION_QUEUE_NUMBER];
+	wait_queue_head_t wait_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Shared extents tree states */
+enum {
+	SSDFS_SHEXTREE_UNKNOWN_STATE,
+	SSDFS_SHEXTREE_CREATED,
+	SSDFS_SHEXTREE_INITIALIZED,
+	SSDFS_SHEXTREE_DIRTY,
+	SSDFS_SHEXTREE_CORRUPTED,
+	SSDFS_SHEXTREE_STATE_MAX
+};
+
+#define SSDFS_SHARED_EXT(ptr) \
+	((struct ssdfs_shared_extent *)(ptr))
+
+/*
+ * Shared extents tree API
+ */
+int ssdfs_shextree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_shextree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_shextree_flush(struct ssdfs_fs_info *fsi);
+
+int ssdfs_shextree_find(struct ssdfs_shared_extents_tree *tree,
+			struct ssdfs_fingerprint *fingerprint,
+			struct ssdfs_btree_search *search);
+int ssdfs_shextree_find_range(struct ssdfs_shared_extents_tree *tree,
+			      struct ssdfs_fingerprint_range *range,
+			      struct ssdfs_btree_search *search);
+int ssdfs_shextree_find_leaf_node(struct ssdfs_shared_extents_tree *tree,
+				  struct ssdfs_fingerprint *fingerprint,
+				  struct ssdfs_btree_search *search);
+int ssdfs_shextree_add(struct ssdfs_shared_extents_tree *tree,
+			struct ssdfs_fingerprint *fingerprint,
+			struct ssdfs_shared_extent *extent,
+			struct ssdfs_btree_search *search);
+int ssdfs_shextree_change(struct ssdfs_shared_extents_tree *tree,
+			  struct ssdfs_fingerprint *fingerprint,
+			  struct ssdfs_shared_extent *extent,
+			  struct ssdfs_btree_search *search);
+int ssdfs_shextree_ref_count_inc(struct ssdfs_shared_extents_tree *tree,
+				 struct ssdfs_fingerprint *fingerprint,
+				 struct ssdfs_btree_search *search);
+int ssdfs_shextree_ref_count_dec(struct ssdfs_shared_extents_tree *tree,
+				 struct ssdfs_fingerprint *fingerprint,
+				 struct ssdfs_btree_search *search);
+int ssdfs_shextree_delete(struct ssdfs_shared_extents_tree *tree,
+			  struct ssdfs_fingerprint *fingerprint,
+			  struct ssdfs_btree_search *search);
+int ssdfs_shextree_delete_all(struct ssdfs_shared_extents_tree *tree);
+
+int ssdfs_shextree_add_pre_invalid_extent(struct ssdfs_shared_extents_tree *tree,
+					  u64 owner_ino,
+					  struct ssdfs_raw_extent *extent);
+int ssdfs_shextree_add_pre_invalid_fork(struct ssdfs_shared_extents_tree *tree,
+					u64 owner_ino,
+					struct ssdfs_raw_fork *fork);
+int ssdfs_shextree_add_pre_invalid_index(struct ssdfs_shared_extents_tree *tree,
+					 u64 owner_ino,
+					 int index_type,
+					 struct ssdfs_btree_index_key *index);
+
+/*
+ * Shared extents tree's internal API
+ */
+int ssdfs_shextree_start_thread(struct ssdfs_shared_extents_tree *tree,
+				int index);
+int ssdfs_shextree_stop_thread(struct ssdfs_shared_extents_tree *tree,
+				int index);
+
+void ssdfs_debug_shextree_object(struct ssdfs_shared_extents_tree *tree);
+
+/*
+ * Shared extents btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations ssdfs_shextree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_shextree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_shextree_node_ops;
+
+#endif /* _SSDFS_SHARED_EXTENTS_TREE_H */
-- 
2.34.1

