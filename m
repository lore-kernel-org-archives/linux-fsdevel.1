Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F330E0D5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627580; cv=none; b=JL32Xg9x/bGrJCvi+piOF8vM/Y7nBMf4gZtbOikJesau1JRSG4o5P7xUfO2nmSWUkrJDfC35nh9Ul+23y329SgivxKUfbzKNkt5H+GyvR3j6cR+nge8NXnJZ+iOjwoJuVjmU3re6AP2cGUF16gJDzZ/5RW3UZTFjUXGocvuqX1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627580; c=relaxed/simple;
	bh=AVZtF2IOjfo5YLQ8/nNBCuc+s/VCMW33o+RAcDidZQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYstWUs9A1Fv5IyXK/bV3Dalie31CZ4ggt6X7bhdaLP/TFAZ3bTAGHmgs+3Dn2Sk7ab3log13NsVvjmY8ooVzqyUiYDuAGF23xOD2J4g3zea2Ao9cRB4NEkUB0IkpnGu+pJFNG+GzDRN4RMxD7FNaNMiRXgDWa3lYX+B6pbJXzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=VOAhnQxl; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="VOAhnQxl"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ad9238d8fso4474578d50.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627576; x=1774232376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=us+PJzEK3k84jbqagG5PaG9y23jml3UHwET1TrBnZGU=;
        b=VOAhnQxlVEfHsA+/NYZhudEXvXXZWxIMod2f1z6N3zEnR8ajtNvaVNIOkh6kXJGXVn
         Ehd4kEKxlpjfOBmYJjmgt2nvAMJz/02+NeKjiEedYRgzOvup8Z6V0q3mmyfcVJ9MCm5x
         7B9Iy5uhGFyQP3SRCneMiijoPUtf5IXfoEWwoPG6fj9cbTXDSzH/dMM43F3dc8wd3L7m
         /md9oygklJWT3PMo2Dy1GQWn3pKT7Dx5kdczbJN8b6oEIgQDFjIRmJgBhndK9bLgKpUH
         MvQZ5ZH9kexhy/KFRF3x/zFZR2VvWCqHVLVQ3nNvutDDXhpK39hwuWILvYq2NyW9ypHC
         VPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627576; x=1774232376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=us+PJzEK3k84jbqagG5PaG9y23jml3UHwET1TrBnZGU=;
        b=EVh/qz4IAAS9u2itid+Pk5acLjsbLzJIlj3Sj4Ww5Fpfc0odyThhPyI4HlErzXsqdF
         RGdvg7Dy3c+3zUqFoGmmGh5yj+NTQvdLkQfl+6jG5mJauhj5fLIGQdrEnSPDVKVZv7Gy
         tuGUMJsI4j4neORIwatI5bhR9M/4EUNVDYQ0MWYMAmjPjs3U40097ShPWJS52W9Vnsec
         lC8W6JqmAehoHy8O5h/zrmW16aQun1A9/zsrzMXr0GmYblGpNmbFWVJUtbE9Uu8Ksoi0
         8ZHNxWIIta0M/ZK5lyDh8Ic4j2calthFPcDzreoOQTQckkwbo0VelwT333MYLYJmuu0f
         Flrg==
X-Gm-Message-State: AOJu0YwdrCxs31lMBnkuD954nvnZ1nsI+JpLf9q9f7EgUBdHO5ejJBKQ
	G5G54eOx9hQvA3PJ0Ng6z3lzJWLcEY8wTRG1nqNaaqiM+UWDqoQ7QEo26AAbqcMYBZCvpfg2LKh
	iQ4/9
X-Gm-Gg: ATEYQzw1+2vgV7ghU5PqyZXaC7KpoPoOOYBDQtDhRL7QLUO4KUnPCbRS0qKxrWntj78
	EylfictKkDedlQtNipUdQ115eOunpJEW9l7CTCDqXBCNtBdiAX+pjlD1b6biechMlxZTY09AA2A
	aVBcBYEjPqkPxi7rk7kedBpNdIP5ajmJw1F2ipYj/zEBPIr6c5MsCDCD4SL/sEq/FJbxI22jHll
	ypSqg2Zk9eNYhxk23436Z5/CT6ygrtks3SA7K5aookic3YpzeNF+IQVDrP34K8t6qsHz6SSoL1/
	tafsjM25paNKe+LrI3zltIxaLtvm19fAe2/jiQh5zVxbEqM+JyRAAWaxLBP/8ivHF93/ZnMnq1H
	1gj89xHkz5HET2wSuly3fRAVmz4rzpBb6FW/pJmbONs/04vT1jFQul86oXJd8OBdG1P7y8oeYEX
	zfy1XppZpeGdxK3WeOlF4yCQ67ifWX6JCbsC/b0YYeHZZIlZfDKI9+Lfl1Uyf3Fek25LeYY2VZ0
	jklD9aVoCO1cHSq4SncyngH
X-Received: by 2002:a05:690c:6612:b0:79a:56bc:246d with SMTP id 00721157ae682-79a56bc273fmr1953337b3.14.1773627575906;
        Sun, 15 Mar 2026 19:19:35 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:35 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 19/79] ssdfs: introduce segment block bitmap
Date: Sun, 15 Mar 2026 19:17:37 -0700
Message-ID: <20260316021800.1694650-11-slava@dubeyko.com>
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
Block (PEB). PEB block bitmap object represents the aggregation
of source PEB's block bitmap and destination PEB's block bitmap.
Finally, segment block bitmap implements an array of PEB block
bitmaps. Segment block bitmap has API:
(1) create - create segment block bitmap
(2) destroy - destroy segment block bitmap
(3) partial_init - initialize by state of one PEB block bitmap
(4) get_free_pages - get free pages in segment block bitmap
(5) get_used_pages - get used pages in segment block bitmap
(6) get_invalid_pages - get invalid pages in segment block bitmap
(7) reserve_block - reserve a free block
(8) reserved_extent - reserve some number of free blocks
(9) pre_allocate - pre_allocate page/range in segment block bitmap
(10) allocate - allocate page/range in segment block bitmap
(11) update_range - change the state of range in segment block bitmap

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/segment_block_bitmap.h | 240 ++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)
 create mode 100644 fs/ssdfs/segment_block_bitmap.h

diff --git a/fs/ssdfs/segment_block_bitmap.h b/fs/ssdfs/segment_block_bitmap.h
new file mode 100644
index 000000000000..7ee7e39972ef
--- /dev/null
+++ b/fs/ssdfs/segment_block_bitmap.h
@@ -0,0 +1,240 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_block_bitmap.h - segment's block bitmap declarations.
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
+#ifndef _SSDFS_SEGMENT_BLOCK_BITMAP_H
+#define _SSDFS_SEGMENT_BLOCK_BITMAP_H
+
+#include "peb_block_bitmap.h"
+
+/*
+ * struct ssdfs_segment_blk_bmap - segment block bitmap object
+ * @state: segment block bitmap's state
+ * @pages_per_peb: pages per physical erase block
+ * @pages_per_seg: pages per segment
+ * @modification_lock: lock for modification operations
+ * @seg_valid_blks: segment's valid logical blocks count
+ * @seg_invalid_blks: segment's invalid logical blocks count
+ * @seg_free_blks: segment's free logical blocks count
+ * @seg_reserved_metapages: number of reserved metapages
+ * @peb: array of PEB block bitmap objects
+ * @pebs_count: PEBs count in segment
+ * @parent_si: pointer on parent segment object
+ */
+struct ssdfs_segment_blk_bmap {
+	atomic_t state;
+
+	u32 pages_per_peb;
+	u32 pages_per_seg;
+
+	struct rw_semaphore modification_lock;
+	atomic_t seg_valid_blks;
+	atomic_t seg_invalid_blks;
+	atomic_t seg_free_blks;
+	atomic_t seg_reserved_metapages;
+
+	struct ssdfs_peb_blk_bmap *peb;
+	u16 pebs_count;
+
+	struct ssdfs_segment_info *parent_si;
+};
+
+/* Segment block bitmap's possible states */
+enum {
+	SSDFS_SEG_BLK_BMAP_STATE_UNKNOWN,
+	SSDFS_SEG_BLK_BMAP_CREATED,
+	SSDFS_SEG_BLK_BMAP_STATE_MAX,
+};
+
+/*
+ * Segment block bitmap API
+ */
+int ssdfs_segment_blk_bmap_create(struct ssdfs_segment_info *si,
+				  int init_flag, int init_state);
+void ssdfs_segment_blk_bmap_destroy(struct ssdfs_segment_blk_bmap *ptr);
+int ssdfs_segment_blk_bmap_partial_init(struct ssdfs_segment_blk_bmap *bmap,
+				    u16 peb_index,
+				    struct ssdfs_folio_vector *source,
+				    struct ssdfs_block_bitmap_fragment *hdr,
+				    u32 peb_free_pages, u64 cno);
+int ssdfs_segment_blk_bmap_partial_inflate(struct ssdfs_segment_blk_bmap *bmap,
+					   u16 peb_index, u32 free_items);
+int
+ssdfs_segment_blk_bmap_partial_clean_init(struct ssdfs_segment_blk_bmap *bmap,
+					  u16 peb_index);
+void ssdfs_segment_blk_bmap_init_failed(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index);
+
+bool is_ssdfs_segment_blk_bmap_dirty(struct ssdfs_segment_blk_bmap *bmap,
+					u16 peb_index);
+
+bool has_ssdfs_segment_blk_bmap_initialized(struct ssdfs_segment_blk_bmap *ptr,
+					    struct ssdfs_peb_container *pebc);
+int ssdfs_segment_blk_bmap_wait_init_end(struct ssdfs_segment_blk_bmap *ptr,
+					 struct ssdfs_peb_container *pebc);
+
+int ssdfs_segment_blk_bmap_get_block_state(struct ssdfs_segment_blk_bmap *ptr,
+					   struct ssdfs_peb_info *pebi,
+					   u32 blk);
+int ssdfs_segment_blk_bmap_reserve_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					     struct ssdfs_peb_info *pebi,
+					     u32 count);
+int ssdfs_segment_blk_bmap_free_metapages(struct ssdfs_segment_blk_bmap *ptr,
+					  struct ssdfs_peb_info *pebi,
+					  u32 count);
+int ssdfs_segment_blk_bmap_reserve_block(struct ssdfs_segment_blk_bmap *ptr);
+int ssdfs_segment_blk_bmap_reserve_extent(struct ssdfs_segment_blk_bmap *ptr,
+					  u32 count, u32 *reserved_blks);
+int ssdfs_segment_blk_bmap_release_extent(struct ssdfs_segment_blk_bmap *ptr,
+					  u32 count);
+int ssdfs_segment_blk_bmap_pre_allocate(struct ssdfs_segment_blk_bmap *ptr,
+					struct ssdfs_peb_info *pebi,
+					struct ssdfs_block_bmap_range *range);
+int ssdfs_segment_blk_bmap_allocate(struct ssdfs_segment_blk_bmap *ptr,
+				    struct ssdfs_peb_info *pebi,
+				    struct ssdfs_block_bmap_range *range);
+int ssdfs_segment_blk_bmap_update_range(struct ssdfs_segment_blk_bmap *ptr,
+				    struct ssdfs_peb_info *pebi,
+				    u8 peb_migration_id,
+				    int range_state,
+				    struct ssdfs_block_bmap_range *range);
+
+/* Inline methods */
+
+static inline
+int __ssdfs_segment_blk_bmap_get_capacity(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int capacity = 0;
+	int i;
+
+	for (i = 0; i < ptr->pebs_count; i++) {
+		capacity += atomic_read(&ptr->peb[i].peb_blks_capacity);
+	}
+
+	return capacity;
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_capacity(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int capacity;
+
+	down_read(&ptr->modification_lock);
+	capacity = __ssdfs_segment_blk_bmap_get_capacity(ptr);
+	up_read(&ptr->modification_lock);
+
+	return capacity;
+}
+
+static inline
+bool is_pages_balance_correct(struct ssdfs_segment_blk_bmap *ptr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int free_blks;
+	int valid_blks;
+	int invalid_blks;
+	int capacity;
+	int calculated;
+
+	BUG_ON(!ptr);
+
+	down_read(&ptr->modification_lock);
+	free_blks = atomic_read(&ptr->seg_free_blks);
+	valid_blks = atomic_read(&ptr->seg_valid_blks);
+	invalid_blks = atomic_read(&ptr->seg_invalid_blks);
+	calculated = free_blks + valid_blks + invalid_blks;
+	capacity = __ssdfs_segment_blk_bmap_get_capacity(ptr);
+	up_read(&ptr->modification_lock);
+
+	BUG_ON(free_blks < 0);
+	BUG_ON(valid_blks < 0);
+	BUG_ON(invalid_blks < 0);
+	BUG_ON(capacity < 0);
+
+	SSDFS_DBG("free_logical_blks %d, valid_logical_blks %d, "
+		  "invalid_logical_blks %d, capacity %d\n",
+		  free_blks, valid_blks, invalid_blks,
+		  capacity);
+
+	if (calculated > capacity) {
+		SSDFS_ERR("free_logical_blks %d, valid_logical_blks %d, "
+			  "invalid_logical_blks %d, calculated %d, "
+			  "capacity %d\n",
+			  free_blks, valid_blks, invalid_blks,
+			  calculated, capacity);
+		return false;
+	}
+
+	return true;
+#else
+	return true;
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_free_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int free_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(!is_pages_balance_correct(ptr));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&ptr->modification_lock);
+	free_blks = atomic_read(&ptr->seg_free_blks);
+	up_read(&ptr->modification_lock);
+
+	return free_blks;
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_used_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int valid_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(!is_pages_balance_correct(ptr));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&ptr->modification_lock);
+	valid_blks = atomic_read(&ptr->seg_valid_blks);
+	up_read(&ptr->modification_lock);
+
+	return valid_blks;
+}
+
+static inline
+int ssdfs_segment_blk_bmap_get_invalid_pages(struct ssdfs_segment_blk_bmap *ptr)
+{
+	int invalid_blks;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	WARN_ON(!is_pages_balance_correct(ptr));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&ptr->modification_lock);
+	invalid_blks = atomic_read(&ptr->seg_invalid_blks);
+	up_read(&ptr->modification_lock);
+
+	return invalid_blks;
+}
+
+#endif /* _SSDFS_SEGMENT_BLOCK_BITMAP_H */
-- 
2.34.1

