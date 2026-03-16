Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B1230DD16
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627578; cv=none; b=XD9MsO7x/jBr3qwgt+ZMn2sGQPGa2xaBHqTCKze1RaTVL81V3PH16aXtL3/ADHFE2yq9lM8Ek8Xo61YaK5TlrXdgot0Z+JerRo2+QJtKb5Q8Ywdf1Iq2FtYVjzqW8ZYG7FjoOmGcYuyetzHR+jt4SjNIAnI3+S0A4ZCivPihaSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627578; c=relaxed/simple;
	bh=VTt7Bj4p4n7WPJ9C4LLAQ6DLB54wsAqrhKK+MMQJ/yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwG+zwHzcVS/iKWyx/9YtukU/KOpqyjfdED5WJv4FfkG0K7qOckqNFKMMVlToXjlMIlT/XtEg4QK8tlbF9lauWQ8akY/K/3wlT/LjSBkJoclW0JUZNKaZ7ylPJFN5zzoCeLeBCiVlPHt5y0mO5bskbFlgS67BpJ+xLdwtiO0/28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=vzU/uRA2; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="vzU/uRA2"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7986c7b8076so40653667b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627573; x=1774232373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xqiNdg6ZcYFyxFmERQJAmCycE3VEVQsRMiFKHRyWWcI=;
        b=vzU/uRA21tHVBu3lWSGo5CTg7LPGjCqFrWdNj8LoKyh0/fDHpcle/LTrM538O/6A55
         xS4rLoh1FFgo03M08Q2QkDQaTKF6M6bmN+m3bFxiIvDJmZuMazX4C+7uwBKA21EcBdN2
         1tn83D4GnVZHl+7zZjqvIhNkPP8dmYCaTYGbrjOJ6wzYJ9xBTqCOz7YTCkvm9ABMPGnK
         BaqVI89Q+eJm5eRAQqoVcQ++8kJWNe9knaqd+gT/P+FOsrEe/a3q7ykgR0Rl43GRJ124
         /K7fii3XyNZaRqvsZ3/NMZtgqRfTwTCbyy0HMbGG9vgHGiiZIdFIKL9V27VdcTnYYD2M
         pPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627573; x=1774232373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xqiNdg6ZcYFyxFmERQJAmCycE3VEVQsRMiFKHRyWWcI=;
        b=fykwmsAv9RLMB8buvdFDnP7/wjYK8gDT9ouyoJ/qkIJiJJ535ZY2tvBLLxEnO8WjiG
         HMA5HRo/qLW+0iynC+OmGc2dsfvZ6C9ZnM756a5w5z+xZiJwDy3qN/xmGemCYzEWAfBU
         MBFswHJaAr5z9KSLUrE+i00i7UCpFgSlLjDl8/QFVxxltJmJbOZJ2CHRTVbkuMkaBQaN
         NU0h8DI/zD4855NNJXtrBSbcPDA6dDb1r1jqjSPtJc6IVfcBMYoYUL8FGkPAOow8qzKz
         Thqr6gIvIG3iGdim6Jw08opXyt6iOlkq9lg3Q1TSitYw+ArDk31a3hVdo9DWFe5e26zz
         tvqA==
X-Gm-Message-State: AOJu0YxOXarDZu7qfOF8HofaAzatlTQXCY0a4gIeerAHyOcdtTdbkP8v
	W+QLjT/yvNkco6I9HzudasTAD1KesBJw3hAFTSYmacpPO80dZCJxcwO4EG0/I0QxE3RexqOjPB4
	CIwfm
X-Gm-Gg: ATEYQzzgSNItg6obHQ7nW8lxgz8S/CnAbBv7WdooWcRONIFWz52rA6jikqIqO902BIL
	HQyqLgBQPAoU7io+XIGO/lOoNmi+rGY1wPUO8MRNTXwp9X2nn+0ZBbWAwh+6at2zDMAG7sJJ9A6
	QJP6rjGcLN2iCc6ig41GX5F00xh+TUVL2H7OwqCDc7Hr4sApIwpClZFRXY+qJbv2zfW4+T0pjtf
	lnyLezD8V2gsjC1mfyuvuz4Ahu88CWDAQLlAJcWqlw7tu6UnkDnSxChwUxXwUJxSnu2bGHP078h
	ubO8UW672EzlOeoKnFus9q3PSCmks1gXdrKV1jw3WVOSAbiNmS516pykZn5f2mFU4KdhLe9/lsp
	P0ibB+EVj8dn5wkscCbd7NWPQlyS2RfLa5jHqOXG+DXYbyfuYi6JgQLeyj31//cEjcZpNiw1/3P
	0hlg+E/NY8B3REMVwwV3/JL9sqUj9ptAb+1DiQyV+S/Fn/VZisEfmXGy5Xtddif0m9Fyv3dDiA3
	GTbVNZ0TQBYvyBRHxL9MCLi
X-Received: by 2002:a05:690c:3482:b0:79a:4767:238b with SMTP id 00721157ae682-79a4767418amr28790987b3.18.1773627572832;
        Sun, 15 Mar 2026 19:19:32 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:32 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 15/79] ssdfs: introduce PEB's block bitmap
Date: Sun, 15 Mar 2026 19:17:35 -0700
Message-ID: <20260316021800.1694650-9-slava@dubeyko.com>
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

SSDFS splits a partition/volume on sequence of fixed-sized
segments. Every segment can include one or several Logical
Erase Blocks (LEB). LEB can be mapped into "Physical" Erase
Block (PEB). Generally speaking, PEB is fixed-sized container
that include some number of logical blocks (or NAND flash
pages). PEB has block bitmap with the goal to track the state
(free, pre-allocated, allocated, invalid) of logical blocks
and to account the physical space is used for storing log's
metadata (segment header, partial log header, footer).

Block bitmap implements API:
(1) create - create empty block bitmap
(2) destroy - destroy block bitmap object
(3) init - intialize block bitmap by metadata from PEB's log
(4) snapshot - take block bitmap snapshot for flush operation
(5) forget_snapshot - free block bitmap's snapshot resources
(6) lock/unlock - lock/unlock block bitmap
(7) test_block/test_range - check state of block or range of blocks
(8) get_free_pages - get number of free pages
(9) get_used_pages - get number of used pages
(10) get_invalid_pages - get number of invalid pages
(11) pre_allocate - pre_allocate logical block or range of blocks
(12) allocate - allocate logical block or range of blocks
(13) invalidate - invalidate logical block or range of blocks
(14) collect_garbage - get contigous range of blocks in state
(15) clean - convert the whole block bitmap into clean state

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/block_bitmap.h        | 393 +++++++++++++++++++++++++++++++++
 fs/ssdfs/block_bitmap_tables.c | 311 ++++++++++++++++++++++++++
 fs/ssdfs/common_bitmap.h       | 230 +++++++++++++++++++
 3 files changed, 934 insertions(+)
 create mode 100644 fs/ssdfs/block_bitmap.h
 create mode 100644 fs/ssdfs/block_bitmap_tables.c
 create mode 100644 fs/ssdfs/common_bitmap.h

diff --git a/fs/ssdfs/block_bitmap.h b/fs/ssdfs/block_bitmap.h
new file mode 100644
index 000000000000..a5aec5b1ec20
--- /dev/null
+++ b/fs/ssdfs/block_bitmap.h
@@ -0,0 +1,393 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/block_bitmap.h - PEB's block bitmap declarations.
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
+#ifndef _SSDFS_BLOCK_BITMAP_H
+#define _SSDFS_BLOCK_BITMAP_H
+
+#include "common_bitmap.h"
+
+#define SSDFS_BLK_STATE_BITS	2
+#define SSDFS_BLK_STATE_MASK	0x3
+
+enum {
+	SSDFS_BLK_FREE		= 0x0,
+	SSDFS_BLK_PRE_ALLOCATED	= 0x1,
+	SSDFS_BLK_VALID		= 0x3,
+	SSDFS_BLK_INVALID	= 0x2,
+	SSDFS_BLK_STATE_MAX	= SSDFS_BLK_VALID + 1,
+};
+
+#define SSDFS_BLK_BMAP_CAPACITY_MAX	U16_MAX
+
+#define SSDFS_FREE_STATES_BYTE		0x00
+#define SSDFS_PRE_ALLOC_STATES_BYTE	0x55
+#define SSDFS_VALID_STATES_BYTE		0xFF
+#define SSDFS_INVALID_STATES_BYTE	0xAA
+
+#define SSDFS_BLK_BMAP_BYTE(blk_state)({ \
+	u8 value; \
+	switch (blk_state) { \
+	case SSDFS_BLK_FREE: \
+		value = SSDFS_FREE_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_PRE_ALLOCATED: \
+		value = SSDFS_PRE_ALLOC_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_VALID: \
+		value = SSDFS_VALID_STATES_BYTE; \
+		break; \
+	case SSDFS_BLK_INVALID: \
+		value = SSDFS_INVALID_STATES_BYTE; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	value; \
+})
+
+#define BLK_BMAP_BYTES(items_count) \
+	(((items_count + SSDFS_ITEMS_PER_LONG(SSDFS_BLK_STATE_BITS) - 1)  / \
+	 SSDFS_ITEMS_PER_LONG(SSDFS_BLK_STATE_BITS)) * sizeof(unsigned long))
+
+static inline
+int SSDFS_BLK2FOLIO(u32 blk, u8 item_bits, u16 *offset)
+{
+	u32 blks_per_byte = SSDFS_ITEMS_PER_BYTE(item_bits);
+	u32 blks_per_long = SSDFS_ITEMS_PER_LONG(item_bits);
+	u32 blks_per_folio = PAGE_SIZE * blks_per_byte;
+	u32 off;
+
+	if (offset) {
+		off = (blk % blks_per_folio) / blks_per_long;
+		off *= sizeof(unsigned long);
+		BUG_ON(off >= U16_MAX);
+		*offset = off;
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("blk %u, item_bits %u, blks_per_byte %u, "
+		  "blks_per_long %u, blks_per_folio %u, "
+		  "folio_index %u\n",
+		  blk, item_bits, blks_per_byte,
+		  blks_per_long, blks_per_folio,
+		  blk / blks_per_folio);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return blk / blks_per_folio;
+}
+
+/*
+ * struct ssdfs_last_bmap_search - last search in bitmap
+ * @folio_index: index of folio in folio vector
+ * @offset: offset of cache from page's begining
+ * @cache: cached bmap's part
+ */
+struct ssdfs_last_bmap_search {
+	int folio_index;
+	u16 offset;
+	unsigned long cache;
+};
+
+static inline
+u32 SSDFS_FIRST_CACHED_BLOCK(struct ssdfs_last_bmap_search *search)
+{
+	u32 blks_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_BLK_STATE_BITS);
+	u32 blks_per_folio = PAGE_SIZE * blks_per_byte;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("folio_index %d, offset %u, "
+		  "blks_per_byte %u, blks_per_folio %u\n",
+		  search->folio_index,
+		  search->offset,
+		  blks_per_byte, blks_per_folio);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (search->folio_index * blks_per_folio) +
+		(search->offset * blks_per_byte);
+}
+
+enum {
+	SSDFS_FREE_BLK_SEARCH,
+	SSDFS_VALID_BLK_SEARCH,
+	SSDFS_OTHER_BLK_SEARCH,
+	SSDFS_SEARCH_TYPE_MAX,
+};
+
+static inline
+int SSDFS_GET_CACHE_TYPE(int blk_state)
+{
+	switch (blk_state) {
+	case SSDFS_BLK_FREE:
+		return SSDFS_FREE_BLK_SEARCH;
+
+	case SSDFS_BLK_VALID:
+		return SSDFS_VALID_BLK_SEARCH;
+
+	case SSDFS_BLK_PRE_ALLOCATED:
+	case SSDFS_BLK_INVALID:
+		return SSDFS_OTHER_BLK_SEARCH;
+	};
+
+	return SSDFS_SEARCH_TYPE_MAX;
+}
+
+#define SSDFS_BLK_BMAP_INITIALIZED	(1 << 0)
+#define SSDFS_BLK_BMAP_DIRTY		(1 << 1)
+
+/*
+ * struct ssdfs_block_bmap_storage - block bitmap's storage
+ * @state: storage state
+ * @array: vector of folios
+ * @buf: pointer on memory buffer
+ */
+struct ssdfs_block_bmap_storage {
+	int state;
+	struct ssdfs_folio_vector array;
+	void *buf;
+};
+
+/* Block bitmap's storage's states */
+enum {
+	SSDFS_BLOCK_BMAP_STORAGE_ABSENT,
+	SSDFS_BLOCK_BMAP_STORAGE_FOLIO_VEC,
+	SSDFS_BLOCK_BMAP_STORAGE_BUFFER,
+	SSDFS_BLOCK_BMAP_STORAGE_STATE_MAX
+};
+
+/*
+ * struct ssdfs_block_bmap - in-core segment's block bitmap
+ * @lock: block bitmap lock
+ * @flags: block bitmap state flags
+ * @storage: block bitmap's storage
+ * @bytes_count: block bitmap size in bytes
+ * @items_capacity: total available items in bitmap
+ * @allocation_pool: number of items available for allocation
+ * @metadata_items: count of metadata items
+ * @used_blks: count of valid blocks
+ * @invalid_blks: count of invalid blocks
+ * @last_search: last search/access cache array
+ */
+struct ssdfs_block_bmap {
+	struct mutex lock;
+	atomic_t flags;
+	struct ssdfs_block_bmap_storage storage;
+	size_t bytes_count;
+	size_t items_capacity;
+	size_t allocation_pool;
+	u32 metadata_items;
+	u32 used_blks;
+	u32 invalid_blks;
+	struct ssdfs_last_bmap_search last_search[SSDFS_SEARCH_TYPE_MAX];
+};
+
+/*
+ * compare_block_bmap_ranges() - compare two ranges
+ * @range1: left range
+ * @range2: right range
+ *
+ * RETURN:
+ *  0: range1 == range2
+ * -1: range1 < range2
+ *  1: range1 > range2
+ */
+static inline
+int compare_block_bmap_ranges(struct ssdfs_block_bmap_range *range1,
+				struct ssdfs_block_bmap_range *range2)
+{
+	u32 range1_end, range2_end;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range1 || !range2);
+
+	SSDFS_DBG("range1 (start %u, len %u), range2 (start %u, len %u)\n",
+		  range1->start, range1->len, range2->start, range2->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (range1->start == range2->start) {
+		if (range1->len == range2->len)
+			return 0;
+		else if (range1->len < range2->len)
+			return -1;
+		else
+			return 1;
+	} else if (range1->start < range2->start) {
+		range1_end = range1->start + range1->len;
+		range2_end = range2->start + range2->len;
+
+		if (range2_end <= range1_end)
+			return 1;
+		else
+			return -1;
+	}
+
+	/* range1->start > range2->start */
+	return -1;
+}
+
+/*
+ * ranges_have_intersection() - have ranges intersection?
+ * @range1: left range
+ * @range2: right range
+ *
+ * RETURN:
+ * [true]  - ranges have intersection
+ * [false] - ranges doesn't intersect
+ */
+static inline
+bool ranges_have_intersection(struct ssdfs_block_bmap_range *range1,
+				struct ssdfs_block_bmap_range *range2)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!range1 || !range2);
+
+	SSDFS_DBG("range1 (start %u, len %u), range2 (start %u, len %u)\n",
+		  range1->start, range1->len, range2->start, range2->len);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if ((range2->start + range2->len) <= range1->start)
+		return false;
+	else if ((range1->start + range1->len) <= range2->start)
+		return false;
+
+	return true;
+}
+
+enum {
+	SSDFS_BLK_BMAP_CREATE,
+	SSDFS_BLK_BMAP_INIT,
+};
+
+/* Function prototypes */
+int ssdfs_block_bmap_create(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_block_bmap *bmap,
+			    u32 items_capacity,
+			    u32 allocation_pool,
+			    int flag, int init_state);
+int ssdfs_block_bmap_destroy(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_init(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_folio_vector *source,
+			  u8 flags,
+			  u32 last_free_blk,
+			  u32 metadata_blks,
+			  u32 invalid_blks,
+			  u32 bmap_bytes);
+int ssdfs_block_bmap_inflate(struct ssdfs_block_bmap *blk_bmap,
+			     u32 free_items);
+int ssdfs_block_bmap_correct_capacity(struct ssdfs_block_bmap *blk_bmap,
+					struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_snapshot(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_folio_vector *snapshot,
+				u32 *last_free_page,
+				u32 *metadata_blks,
+				u32 *invalid_blks,
+				size_t *items_capacity,
+				size_t *bytes_count);
+void ssdfs_block_bmap_forget_snapshot(struct ssdfs_folio_vector *snapshot);
+
+int ssdfs_block_bmap_lock(struct ssdfs_block_bmap *blk_bmap);
+bool ssdfs_block_bmap_is_locked(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_block_bmap_unlock(struct ssdfs_block_bmap *blk_bmap);
+
+bool ssdfs_block_bmap_dirtied(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_block_bmap_set_dirty_state(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_block_bmap_clear_dirty_state(struct ssdfs_block_bmap *blk_bmap);
+bool ssdfs_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap);
+void ssdfs_set_block_bmap_initialized(struct ssdfs_block_bmap *blk_bmap);
+
+bool ssdfs_block_bmap_test_block(struct ssdfs_block_bmap *blk_bmap,
+				 u32 blk, int blk_state);
+bool ssdfs_block_bmap_test_range(struct ssdfs_block_bmap *blk_bmap,
+				 struct ssdfs_block_bmap_range *range,
+				 int blk_state);
+int ssdfs_get_block_state(struct ssdfs_block_bmap *blk_bmap, u32 blk);
+int ssdfs_get_range_state(struct ssdfs_block_bmap *blk_bmap,
+			  struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_reserve_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					    u32 count);
+int ssdfs_block_bmap_free_metadata_pages(struct ssdfs_block_bmap *blk_bmap,
+					 u32 count, u32 *freed_items);
+int ssdfs_block_bmap_get_free_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_used_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_invalid_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_pages_capacity(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_allocation_pool(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_get_metadata_pages(struct ssdfs_block_bmap *blk_bmap);
+int ssdfs_block_bmap_pre_allocate(struct ssdfs_block_bmap *blk_bmap,
+				  u32 start, u32 *len,
+				  struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_allocate(struct ssdfs_block_bmap *blk_bmap,
+				u32 start, u32 *len,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_invalidate(struct ssdfs_block_bmap *blk_bmap,
+				struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_collect_garbage(struct ssdfs_block_bmap *blk_bmap,
+				     u32 start, u32 max_len,
+				     int blk_state,
+				     struct ssdfs_block_bmap_range *range);
+int ssdfs_block_bmap_clean(struct ssdfs_block_bmap *blk_bmap,
+			   size_t items_capacity);
+int ssdfs_block_bmap_invalid2clean(struct ssdfs_block_bmap *blk_bmap);
+
+#if IS_ENABLED(CONFIG_KUNIT)
+bool BLK_BMAP_BYTE_CONTAINS_STATE(u8 *value, int blk_state);
+#endif
+
+#define SSDFS_BLK_BMAP_FNS(state, name)					\
+static inline								\
+bool is_block_##name(struct ssdfs_block_bmap *blk_bmap, u32 blk)	\
+{									\
+	return ssdfs_block_bmap_test_block(blk_bmap, blk,		\
+					    SSDFS_BLK_##state);		\
+}									\
+static inline								\
+bool is_range_##name(struct ssdfs_block_bmap *blk_bmap,			\
+			struct ssdfs_block_bmap_range *range)		\
+{									\
+	return ssdfs_block_bmap_test_range(blk_bmap, range,		\
+					    SSDFS_BLK_##state);		\
+}									\
+
+/*
+ * is_block_free()
+ * is_range_free()
+ */
+SSDFS_BLK_BMAP_FNS(FREE, free)
+
+/*
+ * is_block_pre_allocated()
+ * is_range_pre_allocated()
+ */
+SSDFS_BLK_BMAP_FNS(PRE_ALLOCATED, pre_allocated)
+
+/*
+ * is_block_valid()
+ * is_range_valid()
+ */
+SSDFS_BLK_BMAP_FNS(VALID, valid)
+
+/*
+ * is_block_invalid()
+ * is_range_invalid()
+ */
+SSDFS_BLK_BMAP_FNS(INVALID, invalid)
+
+#endif /* _SSDFS_BLOCK_BITMAP_H */
diff --git a/fs/ssdfs/block_bitmap_tables.c b/fs/ssdfs/block_bitmap_tables.c
new file mode 100644
index 000000000000..7e6b7da5daaa
--- /dev/null
+++ b/fs/ssdfs/block_bitmap_tables.c
@@ -0,0 +1,311 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/block_bitmap_tables.c - declaration of block bitmap's search tables.
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
+#include <linux/kernel.h>
+
+/*
+ * Table for determination presence of free block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_free_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	true, true, true, true,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, false, false, false,
+/* 22 - 0x58 */	true, false, false, false,
+/* 23 - 0x5C */	true, false, false, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, false, false, false,
+/* 26 - 0x68 */	true, false, false, false,
+/* 27 - 0x6C */	true, false, false, false,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, false, false, false,
+/* 30 - 0x78 */	true, false, false, false,
+/* 31 - 0x7C */	true, false, false, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	true, true, true, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, false, false, false,
+/* 38 - 0x98 */	true, false, false, false,
+/* 39 - 0x9C */	true, false, false, false,
+/* 40 - 0xA0 */	true, true, true, true,
+/* 41 - 0xA4 */	true, false, false, false,
+/* 42 - 0xA8 */	true, false, false, false,
+/* 43 - 0xAC */	true, false, false, false,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, false, false, false,
+/* 46 - 0xB8 */	true, false, false, false,
+/* 47 - 0xBC */	true, false, false, false,
+/* 48 - 0xC0 */	true, true, true, true,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	true, true, true, true,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, false, false, false,
+/* 54 - 0xD8 */	true, false, false, false,
+/* 55 - 0xDC */	true, false, false, false,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, false, false, false,
+/* 58 - 0xE8 */	true, false, false, false,
+/* 59 - 0xEC */	true, false, false, false,
+/* 60 - 0xF0 */	true, true, true, true,
+/* 61 - 0xF4 */	true, false, false, false,
+/* 62 - 0xF8 */	true, false, false, false,
+/* 63 - 0xFC */	true, false, false, false
+};
+
+/*
+ * Table for determination presence of pre-allocated
+ * block state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_pre_allocated_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, true, false, false,
+/* 01 - 0x04 */	true, true, true, true,
+/* 02 - 0x08 */	false, true, false, false,
+/* 03 - 0x0C */	false, true, false, false,
+/* 04 - 0x10 */	true, true, true, true,
+/* 05 - 0x14 */	true, true, true, true,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	false, true, false, false,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	false, true, false, false,
+/* 11 - 0x2C */	false, true, false, false,
+/* 12 - 0x30 */	false, true, false, false,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	false, true, false, false,
+/* 15 - 0x3C */	false, true, false, false,
+/* 16 - 0x40 */	true, true, true, true,
+/* 17 - 0x44 */	true, true, true, true,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	true, true, true, true,
+/* 21 - 0x54 */	true, true, true, true,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, true, false, false,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	false, true, false, false,
+/* 35 - 0x8C */	false, true, false, false,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, true, true, true,
+/* 38 - 0x98 */	true, true, true, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	false, true, false, false,
+/* 41 - 0xA4 */	true, true, true, true,
+/* 42 - 0xA8 */	false, true, false, false,
+/* 43 - 0xAC */	false, true, false, false,
+/* 44 - 0xB0 */	false, true, false, false,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	false, true, false, false,
+/* 47 - 0xBC */	false, true, false, false,
+/* 48 - 0xC0 */	false, true, false, false,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	false, true, false, false,
+/* 51 - 0xCC */	false, true, false, false,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, true, true, true,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	true, true, true, true,
+/* 56 - 0xE0 */	false, true, false, false,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	false, true, false, false,
+/* 59 - 0xEC */	false, true, false, false,
+/* 60 - 0xF0 */	false, true, false, false,
+/* 61 - 0xF4 */	true, true, true, true,
+/* 62 - 0xF8 */	false, true, false, false,
+/* 63 - 0xFC */	false, true, false, false
+};
+
+/*
+ * Table for determination presence of valid block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_valid_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, false, true,
+/* 01 - 0x04 */	false, false, false, true,
+/* 02 - 0x08 */	false, false, false, true,
+/* 03 - 0x0C */	true, true, true, true,
+/* 04 - 0x10 */	false, false, false, true,
+/* 05 - 0x14 */	false, false, false, true,
+/* 06 - 0x18 */	false, false, false, true,
+/* 07 - 0x1C */	true, true, true, true,
+/* 08 - 0x20 */	false, false, false, true,
+/* 09 - 0x24 */	false, false, false, true,
+/* 10 - 0x28 */	false, false, false, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	true, true, true, true,
+/* 13 - 0x34 */	true, true, true, true,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	true, true, true, true,
+/* 16 - 0x40 */	false, false, false, true,
+/* 17 - 0x44 */	false, false, false, true,
+/* 18 - 0x48 */	false, false, false, true,
+/* 19 - 0x4C */	true, true, true, true,
+/* 20 - 0x50 */	false, false, false, true,
+/* 21 - 0x54 */	false, false, false, true,
+/* 22 - 0x58 */	false, false, false, true,
+/* 23 - 0x5C */	true, true, true, true,
+/* 24 - 0x60 */	false, false, false, true,
+/* 25 - 0x64 */	false, false, false, true,
+/* 26 - 0x68 */	false, false, false, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	true, true, true, true,
+/* 29 - 0x74 */	true, true, true, true,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	true, true, true, true,
+/* 32 - 0x80 */	false, false, false, true,
+/* 33 - 0x84 */	false, false, false, true,
+/* 34 - 0x88 */	false, false, false, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	false, false, false, true,
+/* 37 - 0x94 */	false, false, false, true,
+/* 38 - 0x98 */	false, false, false, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	false, false, false, true,
+/* 41 - 0xA4 */	false, false, false, true,
+/* 42 - 0xA8 */	false, false, false, true,
+/* 43 - 0xAC */	true, true, true, true,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	true, true, true, true,
+/* 47 - 0xBC */	true, true, true, true,
+/* 48 - 0xC0 */	true, true, true, true,
+/* 49 - 0xC4 */	true, true, true, true,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	true, true, true, true,
+/* 52 - 0xD0 */	true, true, true, true,
+/* 53 - 0xD4 */	true, true, true, true,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	true, true, true, true,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	true, true, true, true,
+/* 59 - 0xEC */	true, true, true, true,
+/* 60 - 0xF0 */	true, true, true, true,
+/* 61 - 0xF4 */	true, true, true, true,
+/* 62 - 0xF8 */	true, true, true, true,
+/* 63 - 0xFC */	true, true, true, true
+};
+
+/*
+ * Table for determination presence of invalid block
+ * state in provided byte. Checking byte is used
+ * as index in array.
+ */
+const bool detect_invalid_blk[U8_MAX + 1] = {
+/* 00 - 0x00 */	false, false, true, false,
+/* 01 - 0x04 */	false, false, true, false,
+/* 02 - 0x08 */	true, true, true, true,
+/* 03 - 0x0C */	false, false, true, false,
+/* 04 - 0x10 */	false, false, true, false,
+/* 05 - 0x14 */	false, false, true, false,
+/* 06 - 0x18 */	true, true, true, true,
+/* 07 - 0x1C */	false, false, true, false,
+/* 08 - 0x20 */	true, true, true, true,
+/* 09 - 0x24 */	true, true, true, true,
+/* 10 - 0x28 */	true, true, true, true,
+/* 11 - 0x2C */	true, true, true, true,
+/* 12 - 0x30 */	false, false, true, false,
+/* 13 - 0x34 */	false, false, true, false,
+/* 14 - 0x38 */	true, true, true, true,
+/* 15 - 0x3C */	false, false, true, false,
+/* 16 - 0x40 */	false, false, true, false,
+/* 17 - 0x44 */	false, false, true, false,
+/* 18 - 0x48 */	true, true, true, true,
+/* 19 - 0x4C */	false, false, true, false,
+/* 20 - 0x50 */	false, false, true, false,
+/* 21 - 0x54 */	false, false, true, false,
+/* 22 - 0x58 */	true, true, true, true,
+/* 23 - 0x5C */	false, false, true, false,
+/* 24 - 0x60 */	true, true, true, true,
+/* 25 - 0x64 */	true, true, true, true,
+/* 26 - 0x68 */	true, true, true, true,
+/* 27 - 0x6C */	true, true, true, true,
+/* 28 - 0x70 */	false, false, true, false,
+/* 29 - 0x74 */	false, false, true, false,
+/* 30 - 0x78 */	true, true, true, true,
+/* 31 - 0x7C */	false, false, true, false,
+/* 32 - 0x80 */	true, true, true, true,
+/* 33 - 0x84 */	true, true, true, true,
+/* 34 - 0x88 */	true, true, true, true,
+/* 35 - 0x8C */	true, true, true, true,
+/* 36 - 0x90 */	true, true, true, true,
+/* 37 - 0x94 */	true, true, true, true,
+/* 38 - 0x98 */	true, true, true, true,
+/* 39 - 0x9C */	true, true, true, true,
+/* 40 - 0xA0 */	true, true, true, true,
+/* 41 - 0xA4 */	true, true, true, true,
+/* 42 - 0xA8 */	true, true, true, true,
+/* 43 - 0xAC */	true, true, true, true,
+/* 44 - 0xB0 */	true, true, true, true,
+/* 45 - 0xB4 */	true, true, true, true,
+/* 46 - 0xB8 */	true, true, true, true,
+/* 47 - 0xBC */	true, true, true, true,
+/* 48 - 0xC0 */	false, false, true, false,
+/* 49 - 0xC4 */	false, false, true, false,
+/* 50 - 0xC8 */	true, true, true, true,
+/* 51 - 0xCC */	false, false, true, false,
+/* 52 - 0xD0 */	false, false, true, false,
+/* 53 - 0xD4 */	false, false, true, false,
+/* 54 - 0xD8 */	true, true, true, true,
+/* 55 - 0xDC */	false, false, true, false,
+/* 56 - 0xE0 */	true, true, true, true,
+/* 57 - 0xE4 */	true, true, true, true,
+/* 58 - 0xE8 */	true, true, true, true,
+/* 59 - 0xEC */	true, true, true, true,
+/* 60 - 0xF0 */	false, false, true, false,
+/* 61 - 0xF4 */	false, false, true, false,
+/* 62 - 0xF8 */	true, true, true, true,
+/* 63 - 0xFC */	false, false, true, false
+};
diff --git a/fs/ssdfs/common_bitmap.h b/fs/ssdfs/common_bitmap.h
new file mode 100644
index 000000000000..3aa978d0541b
--- /dev/null
+++ b/fs/ssdfs/common_bitmap.h
@@ -0,0 +1,230 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/common_bitmap.h - shared declarations for all bitmaps.
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
+#ifndef _SSDFS_COMMON_BITMAP_H
+#define _SSDFS_COMMON_BITMAP_H
+
+#define SSDFS_ITEMS_PER_BYTE(item_bits) ({ \
+	BUG_ON(item_bits > BITS_PER_BYTE); \
+	BITS_PER_BYTE / item_bits; \
+})
+
+#define SSDFS_ITEMS_PER_LONG(item_bits) ({ \
+	BUG_ON(item_bits > BITS_PER_BYTE); \
+	BITS_PER_LONG / item_bits; \
+})
+
+#define ALIGNED_START_ITEM(item, state_bits) ({ \
+	u64 aligned_start; \
+	aligned_start = div_u64(item, SSDFS_ITEMS_PER_BYTE(state_bits)); \
+	aligned_start *= SSDFS_ITEMS_PER_BYTE(state_bits); \
+	aligned_start; \
+})
+
+#define ALIGNED_END_ITEM(item, state_bits) ({ \
+	u64 aligned_end; \
+	aligned_end = item + SSDFS_ITEMS_PER_BYTE(state_bits) - 1; \
+	aligned_end = div_u64(aligned_end, SSDFS_ITEMS_PER_BYTE(state_bits)); \
+	aligned_end *= SSDFS_ITEMS_PER_BYTE(state_bits); \
+	aligned_end; \
+})
+
+typedef bool (*byte_check_func)(u8 *value, int state);
+typedef u8 (*byte_op_func)(u8 *value, int state, u8 start_off, u8 state_bits,
+			   int state_mask);
+
+/*
+ * FIRST_STATE_IN_BYTE() - determine first item's offset for requested state
+ * @value: pointer on analysed byte
+ * @state: requested state
+ * @start_off: starting item's offset for analysis beginning
+ * @state_bits: bits per state
+ * @state_mask: mask of a bitmap's state
+ *
+ * This function tries to determine an item with @state in
+ * @value starting from @start_off.
+ *
+ * RETURN:
+ * [success] - found item's offset.
+ * [failure] - BITS_PER_BYTE.
+ */
+static inline
+u8 FIRST_STATE_IN_BYTE(u8 *value, int state,
+			u8 start_offset, u8 state_bits,
+			int state_mask)
+{
+	u8 i;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!value);
+	BUG_ON(state_bits == 0);
+	BUG_ON(state_bits > BITS_PER_BYTE);
+	BUG_ON(state_bits > 1 && (state_bits % 2) != 0);
+	BUG_ON(start_offset > SSDFS_ITEMS_PER_BYTE(state_bits));
+
+	SSDFS_DBG("value %#x, state %#x, "
+		  "start_offset %u, state_bits %u\n",
+		  *value, state, start_offset, state_bits);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	i = start_offset * state_bits;
+	for (; i < BITS_PER_BYTE; i += state_bits) {
+		if (((*value >> i) & state_mask) == state) {
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("found bit %u, found item %u\n",
+				  i, i / state_bits);
+#endif /* CONFIG_SSDFS_DEBUG */
+			return i / state_bits;
+		}
+	}
+
+	return SSDFS_ITEMS_PER_BYTE(state_bits);
+}
+
+/*
+ * FIND_FIRST_ITEM_IN_BYTE() - find item in byte value
+ * @value: pointer on analysed byte
+ * @state: requested state or mask
+ * @state_bits: bits per state
+ * @state_mask: mask of a bitmap's state
+ * @start_offset: starting item's offset for search
+ * @check: pointer on check function
+ * @op: pointer on concrete operation function
+ * @found_offset: pointer on found item's offset into byte for state [out]
+ *
+ * This function tries to find in byte items with @state starting from
+ * @start_offset.
+ *
+ * RETURN:
+ * [success] - @found_offset contains found items' offset into byte.
+ * [failure] - error code:
+ *
+ * %-ENODATA    - analyzed @value doesn't contain any item for @state.
+ */
+static inline
+int FIND_FIRST_ITEM_IN_BYTE(u8 *value, int state, u8 state_bits,
+			    int state_mask,
+			    u8 start_offset, byte_check_func check,
+			    byte_op_func op, u8 *found_offset)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!value || !found_offset || !check || !op);
+	BUG_ON(state_bits == 0);
+	BUG_ON(state_bits > BITS_PER_BYTE);
+	BUG_ON(state_bits > 1 && (state_bits % 2) != 0);
+	BUG_ON(start_offset > SSDFS_ITEMS_PER_BYTE(state_bits));
+
+	SSDFS_DBG("value %#x, state %#x, state_bits %u, "
+		  "start_offset %u, found_offset %p\n",
+		  *value, state, state_bits,
+		  start_offset, found_offset);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	*found_offset = U8_MAX;
+
+	if (check(value, state)) {
+		u8 offset = op(value, state, start_offset, state_bits,
+				state_mask);
+
+		if (offset < SSDFS_ITEMS_PER_BYTE(state_bits)) {
+			*found_offset = offset;
+
+#ifdef CONFIG_SSDFS_DEBUG
+			SSDFS_DBG("item's offset %u for state %#x\n",
+				  *found_offset, state);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+			return 0;
+		}
+	}
+
+	return -ENODATA;
+}
+
+/*
+ * ssdfs_find_first_dirty_fragment() - find first dirty fragment
+ * @addr: start address
+ * @max_fragment: upper bound for search
+ * @found_addr: found address with dirty fragments [out]
+ *
+ * This method tries to find address of first found bitmap's
+ * part that contains dirty fragments.
+ *
+ * RETURN:
+ * [success]
+ * [failure] - error code:
+ *
+ * %-ENODATA     - nothing found.
+ */
+static inline
+int ssdfs_find_first_dirty_fragment(unsigned long *addr,
+				    unsigned long max_fragment,
+				    unsigned long **found_addr)
+{
+	unsigned long found;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("addr %p, max_fragment %lu, found_addr %p\n",
+		  addr, max_fragment, found_addr);
+
+	BUG_ON(!addr || !found_addr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	found = find_first_bit(addr, max_fragment);
+
+	if (found >= max_fragment) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("unable to find fragment: "
+			  "found %lu, max_fragment %lu\n",
+			  found, max_fragment);
+#endif /* CONFIG_SSDFS_DEBUG */
+		return -ENODATA;
+	}
+
+	*found_addr = (unsigned long *)(addr + (found / BITS_PER_LONG));
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("found %lu, addr %p, found_addr %p\n",
+		  found, addr, *found_addr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return 0;
+}
+
+/*
+ * ssdfs_clear_dirty_state() - clear all dirty states for address
+ * @addr: pointer on unsigned long value
+ */
+static inline
+int ssdfs_clear_dirty_state(unsigned long *addr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!addr);
+
+	SSDFS_DBG("addr %p\n", addr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	memset(addr, 0, sizeof(unsigned long));
+	return 0;
+}
+
+#endif /* _SSDFS_COMMON_BITMAP_H */
-- 
2.34.1

