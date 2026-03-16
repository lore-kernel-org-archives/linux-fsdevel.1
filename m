Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1833315D35
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627591; cv=none; b=Ogc8bqan4jiB0FVIojrtsD/p++HXW8CYBW5iobb1DGO6b5kXoy38I1aInyueDofvNkK+2kQEiZvCaKT3rx8dnIBfFkDtDcW4eS3ZhOfOCRMKEtgZyJ9G9+Bu3Z9Ax5mBx+3DI2aFCuF4D9o5nzYzUXKLtu1VpM658SRFzz9IAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627591; c=relaxed/simple;
	bh=BGV60lgFL1RzNvQLu83fhuDNh+rrXQeA3KZeDE4ryP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+vBBaVliieDNaiNkoIglvudwGKq4TDRapPW/vsDnNJVIOei1C/9UDZbwF9sRevpHi01BKaIyrM2d5Hb2EWTugSHsrC9ugzdAgp9yEcHStN39v3IFoLHww6xaMSY4zudWOVao7iEEP6j7ZDug6laWJz/PCjejuwDHRw3iVuIsyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=d0L7O83W; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="d0L7O83W"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64c9707fc11so2799969d50.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627586; x=1774232386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BEclucdJhdNk+4oMJViIk62vkWzqI1POcWPdgVX7/wQ=;
        b=d0L7O83Wb0aQ3UkdrBYWEeq2KU7t4OlpE4K2yZjSEfwT8JHSOimY5N6lWjpkNa1ez3
         x9e3lWwIgMgrwMAXhZdvKpDAhzysSK4qWDNvCfQzv18L/xk6CC8gZk2lmbR8QlpKWUP0
         IoQlvg0mUmgy7cSw9To9kYggHIsHbIaI+bCWvx58p9jSyXRqwmN1JnpUTjJzAPQAoFOq
         zkvrfuaVq5+GJBQHtC95VQHYzJdg1GgbPe64NDxBTk51H1PFPhzanVe2RSH+wfJg+OAw
         wpK7oMjb3VTQtYvV0orEmRoqUE5zuRGq7b77tTNu9NPN5UCFFlg4Gz6w8AabKw7wyOpT
         cm+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627586; x=1774232386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BEclucdJhdNk+4oMJViIk62vkWzqI1POcWPdgVX7/wQ=;
        b=OfrCyCUPPz+A0BPpYT3dqUoWyOyEpo3/l2jsrdjLQAAwUGtmup3C7Zm3gR5FL9UKMk
         p/pd7blARGax7B9RTiyk/5byNbLZVoQ3uZyA2Jw94ByU8lgj7+aBu+R3IA6kiSvY18wB
         m4BNlY8XTK5pUJMkyBxSZpBwrCcfXH+gwk4cY9vHbh0Mgw8uFPOq8lFr7iBbQTfATc4f
         KtCLgaOzk7ypuGkiOsug6kjsrfUEddrQMEQuRx0os9ATEWDchsGHuzRqI4AVgMmSdCFQ
         4U3c5pifH0vTHLNbxVcHuFE7nyrP4DOrw3c7IoRjbtaofQC0U+XmqfS+q51Ysb3bjZ24
         k+Og==
X-Gm-Message-State: AOJu0Yys0uqHCwsPdbU9I4Z9JBspR3ZOAh+GPsTb10mO8FzBn4WZlm4K
	PwVd3bwM2JN0Pa9pzi8fBxbJ5wgDkbh92VzfWkOqUhXMWH500QcT4/W/TI48H0QnHoSg1I0HN2U
	ycvwZ
X-Gm-Gg: ATEYQzxuYfsqLzYmFGUOiVCnDsxHyOakOuD7Rq7CxEZ0DEwMq76Nsq6w4rYihOKhrZZ
	NneLvI8E6LEdyI6z2oiYEXzV7EZ90bUMkSm+t4MrIuIcVi3XDc8aBDq1JfiZ2G1izh6hdD+qN5C
	nn2+62dohmwUI342WW2T2HZf7f6bhhMenTfRS00Hd2zq6roJkWHvdMCqiFuWQyuxLfYf5fZQZLv
	6kZFqfVN1UaYu01IOnyevd/jN4qLxrnBFos4B98WUaBlQFZafTp6nj7iogGi8/nrMFwmI8r4iwO
	8tBfvzr0iECOIH8v9rZY8LjC5tEikDBbtbtOs38x4ajEKSdYoPFgSsBPyAZn6y8SFOIie+8D85e
	i8vukCX0i1np5qP4MFoZbe4FF5gll7IwWbFkj37ehBtH14Fios7PKumNdok6ES2JCtlYnq+qd6H
	eWSi47SOoGScLU3vzIO3Dr6SLcHbAIPthSqzW/L98qzCvIwR1M4zggqIZ9c58VA/Pt4tphhkmE/
	y5ciyEEtfIc/6ol2ebHt6s6
X-Received: by 2002:a05:690c:4481:b0:79a:55f5:a3f0 with SMTP id 00721157ae682-79a55f5eea0mr3065577b3.14.1773627586353;
        Sun, 15 Mar 2026 19:19:46 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:45 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 42/79] ssdfs: introduce segment bitmap
Date: Sun, 15 Mar 2026 19:17:44 -0700
Message-ID: <20260316021800.1694650-18-slava@dubeyko.com>
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

Segment bitmap is the critical metadata structure of SSDFS file
system that implements several goals: (1) searching for a candidate
for a current segment capable of storing new data, (2) searching
by GC subsystem for a most optimal segment (dirty state,
for example) with the goal of preparing the segment in background
for storing new data (converting in clean state). Segment bitmap is
able to represent a set of states: (1) clean state means that
a segment contains the free logical blocks only, (2) using state means
that a segment could contain valid, invalid, and free logical blocks,
(3) used state means that a segment contains the valid logical
blocks only, (4) pre-dirty state means that a segment contains valid
and invalid logical blocks, (5) dirty state means that a segment
contains only invalid blocks, (6) reserved state is used for
reservation the segment numbers for some metadata structures
(for example, for the case of superblock segment).

PEB migration scheme implies that segments are able to migrate from
one state into another one without the explicit using of GC subsystem.
For example, if some segment receives enough truncate operations (data
invalidation) then the segment could change the used state in pre-dirty
state. Additionally, the segment is able to migrate from pre-dirty into
using state by means of PEBs migration in the case of receiving enough
data update requests. As a result, the segment in using state could be
selected like the current segment without any GC-related activity. However,
a segment is able to stick in pre-dirty state in the case of absence
the update requests. Finally, such situation can be resolved by GC
subsystem by means of valid blocks migration in the background and pre-dirty
segment can be transformed into the using state.

Segment bitmap is implemented like the bitmap metadata structure
that is split on several fragments. Every fragment is stored into a log of
specialized PEB. As a result, the full size of segment bitmap and
PEB’s capacity define the number of fragments. The mkfs utility reserves
the necessary number of segments for storing the segment bitmap’s fragments
during a SSDFS file system’s volume creation. Finally, the numbers of
reserved segments are stored into the superblock metadata structure.
The segment bitmap ”lives” in the same set of reserved segments during
the whole lifetime of the volume. However, the update operations of segment
bitmap could trigger the PEBs migration in the case of exhaustion of any
PEB used for keeping the segment bitmap’s content.

Segment bitmap implements API:
(1) create - create empty segment bitmap object
(2) destroy - destroy segment bitmap object
(3) fragment_init - init fragment of segment bitmap
(4) flush - flush dirty segment bitmap
(5) check_state - check that segment has particular state
(6) get_state - get current state of particular segment
(7) change_state - change state of segment
(8) find - find segment for requested state or state mask
(9) find_and_set - find segment for requested state and change state

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/segment_bitmap.h | 482 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 482 insertions(+)
 create mode 100644 fs/ssdfs/segment_bitmap.h

diff --git a/fs/ssdfs/segment_bitmap.h b/fs/ssdfs/segment_bitmap.h
new file mode 100644
index 000000000000..286e4d8fedf5
--- /dev/null
+++ b/fs/ssdfs/segment_bitmap.h
@@ -0,0 +1,482 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/segment_bitmap.h - segment bitmap declarations.
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
+ *                  Zvonimir Badic
+ */
+
+#ifndef _SSDFS_SEGMENT_BITMAP_H
+#define _SSDFS_SEGMENT_BITMAP_H
+
+#include "common_bitmap.h"
+#include "request_queue.h"
+#include "folio_array.h"
+
+/* Segment states */
+enum {
+	SSDFS_SEG_CLEAN				= 0x0,
+	SSDFS_SEG_DATA_USING			= 0x1,
+	SSDFS_SEG_LEAF_NODE_USING		= 0x2,
+	SSDFS_SEG_HYBRID_NODE_USING		= 0x5,
+	SSDFS_SEG_INDEX_NODE_USING		= 0x3,
+	SSDFS_SEG_USED				= 0x7,
+	SSDFS_SEG_PRE_DIRTY			= 0x6,
+	SSDFS_SEG_DIRTY				= 0x4,
+	SSDFS_SEG_BAD				= 0x8,
+	SSDFS_SEG_RESERVED			= 0x9,
+	SSDFS_SEG_DATA_USING_INVALIDATED	= 0xA,
+	SSDFS_SEG_STATE_MAX			= 0xB
+};
+
+/* Segment state flags */
+#define SSDFS_SEG_CLEAN_STATE_FLAG			(1 << 0)
+#define SSDFS_SEG_DATA_USING_STATE_FLAG			(1 << 1)
+#define SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG		(1 << 2)
+#define SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG		(1 << 3)
+#define SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG		(1 << 4)
+#define SSDFS_SEG_USED_STATE_FLAG			(1 << 5)
+#define SSDFS_SEG_PRE_DIRTY_STATE_FLAG			(1 << 6)
+#define SSDFS_SEG_DIRTY_STATE_FLAG			(1 << 7)
+#define SSDFS_SEG_BAD_STATE_FLAG			(1 << 8)
+#define SSDFS_SEG_RESERVED_STATE_FLAG			(1 << 9)
+#define SSDFS_SEG_DATA_USING_INVALIDATED_STATE_FLAG	(1 << 10)
+
+/* Segment state masks */
+#define SSDFS_SEG_CLEAN_USING_MASK \
+	(SSDFS_SEG_CLEAN_STATE_FLAG | \
+	 SSDFS_SEG_DATA_USING_STATE_FLAG | \
+	 SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG | \
+	 SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG | \
+	 SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG | \
+	 SSDFS_SEG_DATA_USING_INVALIDATED_STATE_FLAG)
+#define SSDFS_SEG_USED_DIRTY_MASK \
+	(SSDFS_SEG_USED_STATE_FLAG | \
+	 SSDFS_SEG_PRE_DIRTY_STATE_FLAG | \
+	 SSDFS_SEG_DIRTY_STATE_FLAG)
+#define SSDFS_SEG_BAD_STATE_MASK \
+	(SSDFS_SEG_BAD_STATE_FLAG)
+
+#define SSDFS_SEG_STATE_BITS	4
+#define SSDFS_SEG_STATE_MASK	0xF
+
+struct ssdfs_segment_bmap;
+
+/*
+ * struct ssdfs_segbmap_fragment_desc - fragment descriptor
+ * @state: fragment's state
+ * @fragment_id: fragment's ID in the whole sequence
+ * @total_segs: total count of segments in fragment
+ * @clean_or_using_segs: count of clean or using segments in fragment
+ * @used_or_dirty_segs: count of used, pre-dirty, dirty or reserved segments
+ * @bad_segs: count of bad segments in fragment
+ * @init_end: wait of init ending
+ * @flush_pairs: array of flush requests
+ * @segbmap: pointer on segment bitmap object
+ * @frag_kobj: fragment kobject for sysfs
+ * @frag_kobj_unregister: completion for fragment kobject cleanup
+ */
+struct ssdfs_segbmap_fragment_desc {
+	int state;
+	u16 fragment_id;
+	u16 total_segs;
+	u16 clean_or_using_segs;
+	u16 used_or_dirty_segs;
+	u16 bad_segs;
+	struct completion init_end;
+
+#define SSDFS_SEGBMAP_FLUSH_REQS_MAX		(2)
+	struct {
+		struct ssdfs_segment_info *si;
+		struct ssdfs_segment_request req;
+	} flush_pairs[SSDFS_SEGBMAP_FLUSH_REQS_MAX];
+
+	struct ssdfs_segment_bmap *segbmap;
+
+	/* /sys/fs/<ssdfs>/<device>/segbmap/fragments/fragment<N> */
+	struct kobject frag_kobj;
+	struct completion frag_kobj_unregister;
+};
+
+/* Fragment's state */
+enum {
+	SSDFS_SEGBMAP_FRAG_CREATED	= 0,
+	SSDFS_SEGBMAP_FRAG_INIT_FAILED	= 1,
+	SSDFS_SEGBMAP_FRAG_INITIALIZED	= 2,
+	SSDFS_SEGBMAP_FRAG_DIRTY	= 3,
+	SSDFS_SEGBMAP_FRAG_TOWRITE	= 4,
+	SSDFS_SEGBMAP_FRAG_STATE_MAX	= 5,
+};
+
+/* Fragments bitmap types */
+enum {
+	SSDFS_SEGBMAP_CLEAN_USING_FBMAP,
+	SSDFS_SEGBMAP_USED_DIRTY_FBMAP,
+	SSDFS_SEGBMAP_BAD_FBMAP,
+	SSDFS_SEGBMAP_MODIFICATION_FBMAP,
+	SSDFS_SEGBMAP_FBMAP_TYPE_MAX,
+};
+
+/*
+ * struct ssdfs_segment_bmap - segments bitmap
+ * @resize_lock: lock for possible resize operation
+ * @flags: bitmap flags
+ * @bytes_count: count of bytes in the whole segment bitmap
+ * @items_count: count of volume's segments
+ * @fragments_count: count of fragments in the whole segment bitmap
+ * @fragments_per_seg: segbmap's fragments per segment
+ * @fragments_per_peb: segbmap's fragments per PEB
+ * @fragment_size: size of fragment in bytes
+ * @seg_numbers: array of segment bitmap's segment numbers
+ * @segs_count: count of segment objects are used for segment bitmap
+ * @segs: array of pointers on segment objects
+ * @search_lock: lock for search and change state operations
+ * @fbmap: array of fragment bitmaps
+ * @desc_array: array of fragments' descriptors
+ * @folios: memory folios of the whole segment bitmap
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_segment_bmap {
+	struct rw_semaphore resize_lock;
+	u16 flags;
+	u32 bytes_count;
+	u64 items_count;
+	u16 fragments_count;
+	u16 fragments_per_seg;
+	u16 fragments_per_peb;
+	u16 fragment_size;
+#define SEGS_LIMIT1	SSDFS_SEGBMAP_SEGS
+#define SEGS_LIMIT2	SSDFS_SEGBMAP_SEG_COPY_MAX
+	u64 seg_numbers[SEGS_LIMIT1][SEGS_LIMIT2];
+	u16 segs_count;
+	struct ssdfs_segment_info *segs[SEGS_LIMIT1][SEGS_LIMIT2];
+
+	struct rw_semaphore search_lock;
+	unsigned long *fbmap[SSDFS_SEGBMAP_FBMAP_TYPE_MAX];
+	struct ssdfs_segbmap_fragment_desc *desc_array;
+	struct ssdfs_folio_array folios;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/*
+ * Inline functions
+ */
+static inline
+u32 SEG_BMAP_BYTES(u64 items_count)
+{
+	u64 bytes;
+
+	bytes = items_count + SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS) - 1;
+	bytes /= SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+
+	BUG_ON(bytes >= U32_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %llu, bytes %llu\n",
+		  items_count, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u32)bytes;
+}
+
+static inline
+u16 SEG_BMAP_FRAGMENTS(u64 items_count)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 bytes = SEG_BMAP_BYTES(items_count);
+	u32 pages, fragments;
+
+	pages = (bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	bytes += pages * hdr_size;
+
+	fragments = (bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	BUG_ON(fragments >= U16_MAX);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %llu, pages %u, "
+		  "bytes %u, fragments %u\n",
+		  items_count, pages,
+		  bytes, fragments);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return (u16)fragments;
+}
+
+static inline
+u16 ssdfs_segbmap_seg_2_fragment_index(u64 seg)
+{
+	u16 fragments_count = SEG_BMAP_FRAGMENTS(seg + 1);
+
+	BUG_ON(fragments_count == 0);
+	return fragments_count - 1;
+}
+
+static inline
+u32 ssdfs_segbmap_items_per_fragment(size_t fragment_size)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 payload_bytes;
+	u64 items;
+
+	BUG_ON(hdr_size >= fragment_size);
+
+	payload_bytes = fragment_size - hdr_size;
+	items = payload_bytes * SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+
+	BUG_ON(items >= U32_MAX);
+
+	return (u32)items;
+}
+
+static inline
+u64 ssdfs_segbmap_define_first_fragment_item(pgoff_t fragment_index,
+					     size_t fragment_size)
+{
+	return fragment_index * ssdfs_segbmap_items_per_fragment(fragment_size);
+}
+
+static inline
+u32 ssdfs_segbmap_get_item_byte_offset(u32 fragment_item)
+{
+	u32 hdr_size = sizeof(struct ssdfs_segbmap_fragment_header);
+	u32 items_per_byte = SSDFS_ITEMS_PER_BYTE(SSDFS_SEG_STATE_BITS);
+	return hdr_size + (fragment_item / items_per_byte);
+}
+
+static inline
+int ssdfs_segbmap_seg_id_2_seg_index(struct ssdfs_segment_bmap *segbmap,
+				     u64 seg_id)
+{
+	int i;
+
+	if (seg_id == U64_MAX)
+		return -ENODATA;
+
+	for (i = 0; i < segbmap->segs_count; i++) {
+		if (seg_id == segbmap->seg_numbers[i][SSDFS_MAIN_SEGBMAP_SEG])
+			return i;
+		if (seg_id == segbmap->seg_numbers[i][SSDFS_COPY_SEGBMAP_SEG])
+			return i;
+	}
+
+	return -ENODATA;
+}
+
+static inline
+bool ssdfs_segbmap_fragment_has_content(struct folio *folio)
+{
+	bool has_content = false;
+	void *kaddr;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!folio);
+
+	SSDFS_DBG("folio %p\n", folio);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	kaddr = kmap_local_folio(folio, 0);
+	if (memchr_inv(kaddr, 0xff, PAGE_SIZE) != NULL)
+		has_content = true;
+	kunmap_local(kaddr);
+
+	return has_content;
+}
+
+static inline
+bool IS_STATE_GOOD_FOR_MASK(int mask, int state)
+{
+	bool is_good = false;
+
+	switch (state) {
+	case SSDFS_SEG_CLEAN:
+		is_good = mask & SSDFS_SEG_CLEAN_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_DATA_USING:
+		is_good = mask & SSDFS_SEG_DATA_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_DATA_USING_INVALIDATED:
+		is_good = mask & SSDFS_SEG_DATA_USING_INVALIDATED_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_LEAF_NODE_USING:
+		is_good = mask & SSDFS_SEG_LEAF_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_HYBRID_NODE_USING:
+		is_good = mask & SSDFS_SEG_HYBRID_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_INDEX_NODE_USING:
+		is_good = mask & SSDFS_SEG_INDEX_NODE_USING_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_USED:
+		is_good = mask & SSDFS_SEG_USED_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_PRE_DIRTY:
+		is_good = mask & SSDFS_SEG_PRE_DIRTY_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_DIRTY:
+		is_good = mask & SSDFS_SEG_DIRTY_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_BAD:
+		is_good = mask & SSDFS_SEG_BAD_STATE_FLAG;
+		break;
+
+	case SSDFS_SEG_RESERVED:
+		is_good = mask & SSDFS_SEG_RESERVED_STATE_FLAG;
+		break;
+
+	default:
+		BUG();
+	}
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("mask %#x, state %#x, is_good %#x\n",
+		  mask, state, is_good);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return is_good;
+}
+
+static inline
+void ssdfs_debug_segbmap_object(struct ssdfs_segment_bmap *bmap)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i, j;
+	size_t bytes;
+
+	BUG_ON(!bmap);
+
+	SSDFS_DBG("flags %#x, bytes_count %u, items_count %llu, "
+		  "fragments_count %u, fragments_per_seg %u, "
+		  "fragments_per_peb %u, fragment_size %u\n",
+		  bmap->flags, bmap->bytes_count, bmap->items_count,
+		  bmap->fragments_count, bmap->fragments_per_seg,
+		  bmap->fragments_per_peb, bmap->fragment_size);
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			SSDFS_DBG("seg_numbers[%d][%d] = %llu\n",
+				  i, j, bmap->seg_numbers[i][j]);
+		}
+	}
+
+	SSDFS_DBG("segs_count %u\n", bmap->segs_count);
+
+	for (i = 0; i < SSDFS_SEGBMAP_SEGS; i++) {
+		for (j = 0; j < SSDFS_SEGBMAP_SEG_COPY_MAX; j++) {
+			SSDFS_DBG("segs[%d][%d] = %p\n",
+				  i, j, bmap->segs[i][j]);
+		}
+	}
+
+	bytes = bmap->fragments_count + BITS_PER_LONG - 1;
+	bytes /= BITS_PER_BYTE;
+
+	for (i = 0; i < SSDFS_SEGBMAP_FBMAP_TYPE_MAX; i++) {
+		SSDFS_DBG("fbmap[%d]\n", i);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					bmap->fbmap[i], bytes);
+	}
+
+	for (i = 0; i < bmap->fragments_count; i++) {
+		struct ssdfs_segbmap_fragment_desc *desc;
+
+		desc = &bmap->desc_array[i];
+
+		SSDFS_DBG("state %#x, total_segs %u, "
+			  "clean_or_using_segs %u, used_or_dirty_segs %u, "
+			  "bad_segs %u\n",
+			  desc->state, desc->total_segs,
+			  desc->clean_or_using_segs,
+			  desc->used_or_dirty_segs,
+			  desc->bad_segs);
+	}
+
+	for (i = 0; i < bmap->fragments_count; i++) {
+		struct folio *folio;
+		void *kaddr;
+
+		folio = ssdfs_folio_array_get_folio_locked(&bmap->folios, i);
+
+		SSDFS_DBG("folio[%d] %p\n", i, folio);
+		if (!folio)
+			continue;
+
+		SSDFS_DBG("folio_index %llu, flags %#lx\n",
+			  (u64)folio->index, folio->flags.f);
+
+		kaddr = kmap_local_folio(folio, 0);
+		print_hex_dump_bytes("", DUMP_PREFIX_OFFSET,
+					kaddr, PAGE_SIZE);
+		kunmap_local(kaddr);
+
+		ssdfs_folio_unlock(folio);
+		ssdfs_folio_put(folio);
+
+		SSDFS_DBG("folio %p, count %d\n",
+			  folio, folio_ref_count(folio));
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * Segment bitmap's API
+ */
+int ssdfs_segbmap_create(struct ssdfs_fs_info *fsi);
+void ssdfs_segbmap_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_segbmap_check_fragment_header(struct ssdfs_peb_container *pebc,
+					u16 seg_index,
+					u16 sequence_id,
+					struct folio *folio);
+int ssdfs_segbmap_fragment_init(struct ssdfs_peb_container *pebc,
+				u16 sequence_id,
+				struct folio *folio,
+				int state);
+int ssdfs_segbmap_flush(struct ssdfs_segment_bmap *segbmap);
+int ssdfs_segbmap_resize(struct ssdfs_segment_bmap *segbmap,
+			 u64 new_items_count);
+
+int ssdfs_segbmap_check_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int state,
+				struct completion **end);
+int ssdfs_segbmap_get_state(struct ssdfs_segment_bmap *segbmap,
+			    u64 seg, struct completion **end);
+int ssdfs_segbmap_change_state(struct ssdfs_segment_bmap *segbmap,
+				u64 seg, int new_state,
+				struct completion **end);
+int ssdfs_segbmap_find(struct ssdfs_segment_bmap *segbmap,
+			u64 start, u64 max,
+			int state, int mask,
+			u64 *seg, struct completion **end);
+int ssdfs_segbmap_find_and_set(struct ssdfs_segment_bmap *segbmap,
+				u64 start, u64 max,
+				int state, int mask,
+				int new_state,
+				u64 *seg, struct completion **end);
+int ssdfs_segbmap_reserve_clean_segment(struct ssdfs_segment_bmap *segbmap,
+					u64 start, u64 max,
+					u64 *seg, struct completion **end);
+
+#endif /* _SSDFS_SEGMENT_BITMAP_H */
-- 
2.34.1

