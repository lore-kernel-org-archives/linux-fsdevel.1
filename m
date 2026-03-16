Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86F130C372
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627578; cv=none; b=lpavKTjQ82Hc6htVoQAyEjdHQC45mQ1NoIb3rYdSJtHBRqOJEWfrrpNu0Qt2/rsYPyWSRzLuD9kTK5GinnzkqySqvU+gP7tH6GvVLzIfmlBg0wZLSiQAYkNoT1h9nBiaaipIeobTCeiTOS9PUoqMMVTk6IBi/wbKnkvd0K+MzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627578; c=relaxed/simple;
	bh=WZ1CtB4R4ogEqo946iz8bELqKsBvkzQMXfy1ivsSDpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zr1c8D2rf9aDwPAIxRP26SSqbGDyJgS11hdNiWLInRWTXgF6enW2jIKitt8uICNKYYFCUCy3zGWEpk7OfxOZ2egtCTWyvvYIJEs0vG/aNRZ3RzGtQqNfxgo5Q6bwDNg21HtCCcAKFSUkUX+MJsR0iSmzSnej31oI2HDn8NH2HvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=AEQkVn1v; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="AEQkVn1v"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79860421382so35548517b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627574; x=1774232374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R6XQGNiWusK0RJseJVT/F65FpZkGNVljC47qJ6LY3Ps=;
        b=AEQkVn1v+Gi4bt8iLX/CPG83LofbeVhcIgufpOmJfPRZugnAq/kSs15unriLT+w9sC
         UJLPHMhmbHof4SBlHARY6TSzZ2xLXsRnPpRrx3BC3ACEK7y/wgThVQvy51vQPyaEM36/
         Vuoc6kKRji/kzRqxqFy00i347RPfkfd4WsvBQ/c4TC56thLTtzeR6bjBqvplmuEG+Awm
         +QLAQRYUGFClx3iIpYNLcBK+4WTl3aCri5DYsCGAN3uk7RnM7faCyPsRBApa7Bfax7Pb
         z7rqbyfnD94nEMiMjHdr2hhHmNy8naFeRaufdRaZIJtpGqF0Vs4ug0d6G7hyWM+B3WAH
         T27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627574; x=1774232374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R6XQGNiWusK0RJseJVT/F65FpZkGNVljC47qJ6LY3Ps=;
        b=m1vU8l0BjONvSDJoyuuppFqAcw0wwPAomevOdHu1a/ziCeSNlBWqyd8VxwwyeUgSAG
         ZjJVs+lePJv4anZUymdpQ9XWWfh2uMppTMGpiBIbMfTbTzWvcOCP6Bf9oaWfCCy2XT64
         w8R6QivoKN19EP2giZj2bFo2S9tVKlBZfykaDVTf6JQVo82qIQuc/j/iUy0YU/rDU/hs
         1U+5GXkR/qVeNWVaboXyMFYuxtLHdqLbE52ASEeGtV0byEA9zQa/0YufkO+Nhg5TlLC8
         AGkxb+hkveNqnG5kDAxhV+wEQn+tPpJ7RVTE96Rr1LwaO3UkwG4X5apqSKX+W1Teb1wX
         r59Q==
X-Gm-Message-State: AOJu0YxjgNjG9nG4zKVccAkrgkZNXc+S4vSvbFEBcwErRyzV5lT5GHWp
	5MhVo20MP7+81kM+N7JPflgrrhqkAh7ra3wiHInZkNvo0+4rCQTi1vuGN2ZwzkJzD74hhbKQhbU
	UNqB4
X-Gm-Gg: ATEYQzyOPoCQIZFt6PcdUZYSDFKr5UurbmG3CwEquv9sqmGNDlrT27mT/AErN/gwAC+
	ZlPXpg1dzT5UhqWEXx8vt1ZflBf+R8HqN3bCNvfMBN0f5hZ+RXv+fDmvvYuGtaNIZ94rsTRn80H
	s4mSUZuLoQaFsHxbK8wGljnnnFTwZiq5Nf3o+PMglZD/dX06dscxn/WVuEpyEMsoyzuRgWqnTnK
	Wy5q9N+J3rvbLjsBA6kA1d2XKrNlbEoX1XmDtY7W44PXHdN0yF+udlWvaTjoKUFZETpCUutdpf9
	KQ5o4w9rvvvVQEEcNX2tEwKZeXmr0YFdkvGlfgOiqxUHOw5BxYsMRP8r8Eh9emt4tYau4AIjaf2
	w6NGRKtgnTzWV7sOBg6whJ+ZFeld2BsIxlvC1FgPvqadJafIubdmsTl1w+wngXTLfAOwiANxo0T
	UiC1wjR/PaZUdL/MvOZ+o7x0I3hvNmPwjqBY24BZSXeJQG9gsfVtPHs2vKlaiHKYEfSMXaOuir9
	3LNL3WoGVI6pUk3Mvi3QjUj
X-Received: by 2002:a05:690c:6d84:b0:79a:4482:10f6 with SMTP id 00721157ae682-79a44823cbemr30151567b3.7.1773627574242;
        Sun, 15 Mar 2026 19:19:34 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:33 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 17/79] ssdfs: implement support of migration scheme in PEB bitmap
Date: Sun, 15 Mar 2026 19:17:36 -0700
Message-ID: <20260316021800.1694650-10-slava@dubeyko.com>
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

SSDFS implements a migration scheme. Migration scheme is
a fundamental technique of GC overhead management. The key
responsibility of the migration scheme is to guarantee
the presence of data in the same segment for any update
operations. Generally speaking, the migration scheme’s model
is implemented on the basis of association an exhausted
"Physical" Erase Block (PEB) with a clean one. The goal such
association of two PEBs is to implement the gradual migration
of data by means of the update operations in the initial
(exhausted) PEB. As a result, the old, exhausted PEB becomes
invalidated after complete data migration and it will be
possible to apply the erase operation to convert it in the
clean state. Moreover, the destination PEB in the association
changes the initial PEB for some index in the segment and, finally,
it becomes the only PEB for this position. Namely such technique
implements the concept of logical extent with the goal to decrease
the write amplification issue and to manage the GC overhead.
Because the logical extent concept excludes the necessity
to update metadata is tracking the position of user data on
the file system’s volume. Generally speaking, the migration scheme
is capable to decrease the GC activity significantly by means of
excluding the necessity to update metadata and by means of
self-migration of data between of PEBs is triggered by regular
update operations.

To implement the migration scheme concept, SSDFS introduces
PEB container that includes source and destination erase blocks.
As a result, PEB block bitmap object represents the same aggregation
for source PEB's block bitmap and destination PEB's block bitmap.
PEB block bitmap implements API:
(1) create - create PEB block bitmap
(2) destroy - destroy PEB block bitmap
(3) init - initialize PEB block bitmap by metadata from a log
(4) get_free_pages - get free pages in aggregation of block bitmaps
(5) get_used_pages - get used pages in aggregation of block bitmaps
(6) get_invalid_pages - get invalid pages in aggregation of block bitmaps
(7) pre_allocate - pre_allocate page/range in aggregation of block bitmaps
(8) allocate - allocate page/range in aggregation of block bitmaps
(9) invalidate - invalidate page/range in aggregation of block bitmaps
(10) update_range - change the state of range in aggregation of block bitmaps
(11) collect_garbage - find contiguous range for requested state
(12) start_migration - prepare PEB's environment for migration
(13) migrate - move range from source block bitmap into destination one
(14) finish_migration - clean source block bitmap and swap block bitmaps

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/peb_block_bitmap.h | 179 ++++++++++++++++++++++++++++++++++++
 1 file changed, 179 insertions(+)
 create mode 100644 fs/ssdfs/peb_block_bitmap.h

diff --git a/fs/ssdfs/peb_block_bitmap.h b/fs/ssdfs/peb_block_bitmap.h
new file mode 100644
index 000000000000..4d38cfb1aefb
--- /dev/null
+++ b/fs/ssdfs/peb_block_bitmap.h
@@ -0,0 +1,179 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_block_bitmap.h - PEB's block bitmap declarations.
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
+#ifndef _SSDFS_PEB_BLOCK_BITMAP_H
+#define _SSDFS_PEB_BLOCK_BITMAP_H
+
+#include "block_bitmap.h"
+
+/* PEB's block bitmap indexes */
+enum {
+	SSDFS_PEB_BLK_BMAP1,
+	SSDFS_PEB_BLK_BMAP2,
+	SSDFS_PEB_BLK_BMAP_ITEMS_MAX
+};
+
+/*
+ * struct ssdfs_peb_blk_bmap - PEB container's block bitmap object
+ * @state: PEB container's block bitmap's state
+ * @peb_index: PEB index in array
+ * @pages_per_peb: pages per physical erase block
+ * @modification_lock: lock for modification operations
+ * @peb_valid_blks: PEB container's valid logical blocks count
+ * @peb_invalid_blks: PEB container's invalid logical blocks count
+ * @peb_free_blks: PEB container's free logical blocks count
+ * @peb_blks_capacity: PEB container's logical blocks capacity
+ * @buffers_state: buffers state
+ * @lock: buffers lock
+ * @init_cno: initialization checkpoint
+ * @src: source PEB's block bitmap object's pointer
+ * @dst: destination PEB's block bitmap object's pointer
+ * @buffers: block bitmap buffers
+ * @init_end: wait of init ending
+ * @parent: pointer on parent segment block bitmap
+ */
+struct ssdfs_peb_blk_bmap {
+	atomic_t state;
+
+	u16 peb_index;
+	u32 pages_per_peb;
+
+	struct rw_semaphore modification_lock;
+	atomic_t peb_valid_blks;
+	atomic_t peb_invalid_blks;
+	atomic_t peb_free_blks;
+	atomic_t peb_blks_capacity;
+
+	atomic_t buffers_state;
+	struct rw_semaphore lock;
+	u64 init_cno;
+	struct ssdfs_block_bmap *src;
+	struct ssdfs_block_bmap *dst;
+	struct ssdfs_block_bmap buffer[SSDFS_PEB_BLK_BMAP_ITEMS_MAX];
+	struct completion init_end;
+
+	struct ssdfs_segment_blk_bmap *parent;
+};
+
+/* PEB container's block bitmap's possible states */
+enum {
+	SSDFS_PEB_BLK_BMAP_STATE_UNKNOWN,
+	SSDFS_PEB_BLK_BMAP_CREATED,
+	SSDFS_PEB_BLK_BMAP_HAS_CLEAN_DST,
+	SSDFS_PEB_BLK_BMAP_INITIALIZED,
+	SSDFS_PEB_BLK_BMAP_STATE_MAX,
+};
+
+/* PEB's buffer array possible states */
+enum {
+	SSDFS_PEB_BMAP_BUFFERS_EMPTY,
+	SSDFS_PEB_BMAP1_SRC,
+	SSDFS_PEB_BMAP1_SRC_PEB_BMAP2_DST,
+	SSDFS_PEB_BMAP2_SRC,
+	SSDFS_PEB_BMAP2_SRC_PEB_BMAP1_DST,
+	SSDFS_PEB_BMAP_BUFFERS_STATE_MAX
+};
+
+/* PEB's block bitmap operation destination */
+enum {
+	SSDFS_PEB_BLK_BMAP_SOURCE,
+	SSDFS_PEB_BLK_BMAP_DESTINATION,
+	SSDFS_PEB_BLK_BMAP_INDEX_MAX
+};
+
+/*
+ * PEB block bitmap API
+ */
+int ssdfs_peb_blk_bmap_create(struct ssdfs_segment_blk_bmap *parent,
+			      u16 peb_index, u32 items_count,
+			      int init_flag, int init_state);
+int ssdfs_peb_blk_bmap_destroy(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_init(struct ssdfs_peb_blk_bmap *bmap,
+			    struct ssdfs_folio_vector *source,
+			    struct ssdfs_block_bitmap_fragment *hdr,
+			    u32 peb_free_pages,
+			    u64 cno);
+int ssdfs_peb_blk_bmap_clean_init(struct ssdfs_peb_blk_bmap *bmap);
+void ssdfs_peb_blk_bmap_init_failed(struct ssdfs_peb_blk_bmap *bmap);
+
+bool has_ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_wait_init_end(struct ssdfs_peb_blk_bmap *bmap);
+
+bool ssdfs_peb_blk_bmap_initialized(struct ssdfs_peb_blk_bmap *ptr);
+bool is_ssdfs_peb_blk_bmap_dirty(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_inflate(struct ssdfs_peb_blk_bmap *ptr,
+				u32 free_items);
+
+int ssdfs_peb_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_metadata_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_peb_blk_bmap_get_pages_capacity(struct ssdfs_peb_blk_bmap *ptr);
+
+int ssdfs_peb_define_reserved_pages_per_log(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_reserve_metapages(struct ssdfs_peb_blk_bmap *bmap,
+					 int bmap_index,
+					 u32 count);
+int ssdfs_peb_blk_bmap_free_metapages(struct ssdfs_peb_blk_bmap *bmap,
+				      int bmap_index,
+				      u32 count);
+int ssdfs_peb_blk_bmap_get_block_state(struct ssdfs_peb_blk_bmap *bmap,
+					int bmap_index,
+					u32 blk);
+int ssdfs_peb_blk_bmap_pre_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_allocate(struct ssdfs_peb_blk_bmap *bmap,
+				int bmap_index,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_invalidate(struct ssdfs_peb_blk_bmap *bmap,
+				  int bmap_index,
+				  struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_update_range(struct ssdfs_peb_blk_bmap *bmap,
+				    int bmap_index,
+				    int new_range_state,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_collect_garbage(struct ssdfs_peb_blk_bmap *bmap,
+					u32 start, u32 max_len,
+					int blk_state,
+					struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_start_migration(struct ssdfs_peb_blk_bmap *bmap);
+int ssdfs_peb_blk_bmap_migrate(struct ssdfs_peb_blk_bmap *bmap,
+				int new_range_state,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_peb_blk_bmap_finish_migration(struct ssdfs_peb_blk_bmap *bmap);
+
+/*
+ * PEB block bitmap internal API
+ */
+int ssdfs_src_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_metadata_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_src_blk_bmap_get_pages_capacity(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_free_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_used_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_invalid_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_metadata_pages(struct ssdfs_peb_blk_bmap *ptr);
+int ssdfs_dst_blk_bmap_get_pages_capacity(struct ssdfs_peb_blk_bmap *ptr);
+
+#endif /* _SSDFS_PEB_BLOCK_BITMAP_H */
-- 
2.34.1

