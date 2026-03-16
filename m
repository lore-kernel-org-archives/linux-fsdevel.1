Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C8230EF6F
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627583; cv=none; b=fc91BLrYSqrTkQlyekvmHZrKfBgvXW+vUjuhVOqw3bNXY3/cn1I2GCX4H9dsWekQ9TNPUxdpp6M3c5B4TMU3l6St+iXc9x/rLDuI9GNnMeNbthzUH7lO4tbP6vmhN/8yNEnYfABhaCNHdnN3IvIhQicVHjcPThCeMjJ2UmluRw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627583; c=relaxed/simple;
	bh=5WuxtIuGkP+JtK9kmJsKyzYNRBp+j+acTR4DfNYg5BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqw052o+05fDj0xxdD1oS+WkuqAsr1fiKXgeGXxEw+3O9yYY+/e7vhdBE0jMSZn8EwyAbHYD2Y8CgJrD17A037y9fgBHbnshMZ62SHRLT511d0W5MZm2HD2WKbUG+84pees+trhTZDjM1cfzTkKi4AZ0qSsW8o+addBcy8gG+Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=H6ZohBqk; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="H6ZohBqk"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46ebe2beso4612467b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627578; x=1774232378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yYMLNXjhx8ltbUcJk+/C0SxnxcTNsKpzvsK/qzUOiI=;
        b=H6ZohBqkabzbeLo/I5TVDSa5syqHkqiimj6dGrjnJYB7VTlSw77dB0j0445KM/hRAX
         y7mXgvQVWwS3H8b3qi8MwnCnGbqpTlY87Of0izQBg4W/u1p4twJzEFxopZto04vIWUT7
         fuducz5KcAI4WhfmHvT8SMBkaAptCXDVDIJ1KCrlxZsfZcni5/XUSoA2W5HPF8YC9jd0
         eo+GAGHqGvd1J5YGJoF+OH4hnUy0rJ/J0lhmfM48KwYi2etHtWencU84kFRSR7DZ2o+V
         8/TAJ+UVu68U85fVfqaPjqEPdOpzdjOgnhUHUBJXmvEtsTDV24iid3dGDLMsAbsk92/C
         48OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627578; x=1774232378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yYMLNXjhx8ltbUcJk+/C0SxnxcTNsKpzvsK/qzUOiI=;
        b=LZhPg5c2w8B8vjG/oMKDBuXZxndi/0SpdFLrL1QK8satZLz0Xuw2SlbssMj56/B29t
         jjEAR5/8we0+J3UFjRuYQP+dZlTBX1BAijkuAZByiF8MpdiUCAM+oYuNf8OiSxGuPxL1
         O7xV7VvCoj60CAMUk2Q5dhP9zUJeZI05BL/+N+f+I4ewoxix3Z3grsgVrjlmYX47noHB
         2a1nOfbdKYDXL+hK19i95zgd1bHTpVPOdBuzpk4bM/PNMwvMzd3Ao+T/paGe3TUHn6eJ
         n0w8B5tyct3RBEbgLIXvUY2PjsKGlBMMk7FuPegx8rQuX++g1u5k7wLE/pUIQHXRWTtz
         iVtg==
X-Gm-Message-State: AOJu0YwHQsO7DEGLucv+eOy2Vunswh/VyUkoZUyD5uGA9SmwGIka0wG2
	ji3cGYsShEJV+0HmPgt/6ZQO8qwaNx3pDcQEkuLgM+WfVHN2dXitmxZAffrTC7Mfq0Ju933xQu2
	e+V37
X-Gm-Gg: ATEYQzwhRBl5fTP+rYrubeyFHsAoavok7VnYstLklxXi2ERj002uCgO78t/dFR/B8Vl
	16rEwXPzCgcVGP/NzV2xzjAwWH+KAfxFQ+zphigRidvCgzD6BE3wcrV/AEgJ2Orz+SXlVXdPksq
	bS69jC6nMhA2EHL3k5nPa/Xb7OO3TygN8gf0TDtgkOgIdx3afRk5Y4Ab434aKZJTV63hTY9pk7E
	Sf9NzPoM+U7zWGihw6z7I8MhzX90uFnupQXx8sMA+LBABWJrESaRkMkJVQeq+jTUnwPBzCoOUF+
	6axPlAP6y/BRg0LiBSE7ya59hhPh1eRwOL3pmhfWQjEQY3Rdza1NbEsqZMIOhVj6pn/gkVOmQ/q
	hU6J8uSEnvug22fX35OqNWIfjSrBh5Bwx0IG27CKc1YFJtxaYYHRTFV9nQEgeXnFqmHv4hf3cJr
	AElZl+rmxmdkA1yMsTEOd2s4ISpt4+fIiNqvj2P7t9hFQSwBCGW5YCIR2UiqZ+O4M8ztSfqXakB
	JHMdvfNnCnfvhTiTGmFKO2g
X-Received: by 2002:a05:690c:e3e9:b0:78e:6176:2c8b with SMTP id 00721157ae682-79a1c1dce1dmr120496637b3.49.1773627577555;
        Sun, 15 Mar 2026 19:19:37 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:36 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 22/79] ssdfs: introduce offset translation table
Date: Sun, 15 Mar 2026 19:17:38 -0700
Message-ID: <20260316021800.1694650-12-slava@dubeyko.com>
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

One of the key goal of SSDFS is to decrease the write
amplification factor. Logical extent concept is the
fundamental technique to achieve the goal. Logical extent
describes any volume extent on the basis of segment ID,
logical block ID, and length. Migration scheme guarantee
that segment ID will be always the same for any logical
extent. Offset translation table provides the way to convert
logical block ID into offset inside of a log of particular
"Physical" Erase Block (PEB). As a result, extents b-tree
never needs to be updated because logical extent will never
change until intentional movement from one segment into
another one.

Offset translation table is a metadata structure that
is stored as metadata in every log. The responsibility of
offset translation table keeps the knowledge which particular
logical blocks are stored into log's payload and which offset
in the payload should be used to access and retrieve the
content of logical block.

Offset translation table can be imagined like a sequence of
fragments. Every fragment contains array of physical
offset descriptors that provides the way to convert logical
block ID into the physical offset in the log. Flush logic
identifies dirty fragments and stores these fragments as
part of log's metadata during log commit operation.

The responsibility of offset translation table is to implement
the mechanism of converting logical block ID into the physical
offset in the log. As a result, offset translation table
implements API:
(1) create - create empty offset translation table
(2) destroy - destroy offset translation table
(3) partial_init - initialize offset translation table by one fragment
(4) store_offsets_table - flush dirty fragments
(5) convert - convert logical block ID into offset descriptor
(6) allocate_block - allocate logical block
(7) allocate_extent - allocate logical extent
(8) change_offset - initialize offset of allocated logical block
(9) free_block - free logical block
(10) free_extent - free logical extent

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/offset_translation_table.h | 459 ++++++++++++++++++++++++++++
 1 file changed, 459 insertions(+)
 create mode 100644 fs/ssdfs/offset_translation_table.h

diff --git a/fs/ssdfs/offset_translation_table.h b/fs/ssdfs/offset_translation_table.h
new file mode 100644
index 000000000000..7bc5a4764679
--- /dev/null
+++ b/fs/ssdfs/offset_translation_table.h
@@ -0,0 +1,459 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/offset_translation_table.h - offset table declarations.
+ *
+ * Copyright (c) 2014-2019 HGST, a Western Digital Company.
+ *              http://www.hgst.com/
+ * Copyright (c) 2014-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ *
+ * (C) Copyright 2014-2019, HGST, Inc., All rights reserved.
+ *
+ * Created by HGST, San Jose Research Center, Storage Architecture Group
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cyril Guyot
+ *                  Zvonimir Bandic
+ *                  Cong Wang
+ */
+
+#ifndef _SSDFS_OFFSET_TRANSLATION_TABLE_H
+#define _SSDFS_OFFSET_TRANSLATION_TABLE_H
+
+#include <linux/pagevec.h>
+
+#include "request_queue.h"
+#include "sequence_array.h"
+#include "dynamic_array.h"
+
+/*
+ * struct ssdfs_phys_offset_table_fragment - fragment of phys offsets table
+ * @lock: table fragment lock
+ * @start_id: starting physical offset id number in fragment
+ * @sequence_id: fragment's sequence_id in PEB
+ * @id_count: count of id numbers in sequence
+ * @state: fragment state
+ * @peb_id: PEB ID containing the fragment
+ * @migrating_blocks: number of logical blocks under migration
+ * @actual_records: number of actual records in fragment
+ * @hdr: pointer on fragment's header
+ * @phys_offs: array of physical offsets in fragment
+ * @buf: buffer of fragment
+ * @buf_size: size of buffer in bytes
+ *
+ * One fragment can be used for one PEB's log. But one log can contain
+ * several fragments too. In memory exists the same count of fragments
+ * as on volume.
+ */
+struct ssdfs_phys_offset_table_fragment {
+	struct rw_semaphore lock;
+	u16 start_id;
+	u16 sequence_id;
+	atomic_t id_count;
+	atomic_t state;
+	u64 peb_id;
+	atomic_t migrating_blocks;
+	atomic_t actual_records;
+
+	struct ssdfs_phys_offset_table_header *hdr;
+	struct ssdfs_phys_offset_descriptor *phys_offs;
+	unsigned char *buf;
+	size_t buf_size;
+};
+
+enum {
+	SSDFS_BLK2OFF_FRAG_UNDEFINED,
+	SSDFS_BLK2OFF_FRAG_CREATED,
+	SSDFS_BLK2OFF_FRAG_INITIALIZED,
+	SSDFS_BLK2OFF_FRAG_DIRTY,
+	SSDFS_BLK2OFF_FRAG_UNDER_COMMIT,
+	SSDFS_BLK2OFF_FRAG_COMMITED,
+	SSDFS_BLK2OFF_PLEASE_DELETE_FRAGMENT,
+	SSDFS_BLK2OFF_FRAG_STATE_MAX,
+};
+
+#define SSDFS_INVALID_FRAG_ID				U16_MAX
+#define SSDFS_BLK2OFF_TBL_REVERT_THRESHOLD		(U16_MAX - 1)
+#define SSDFS_BLK2OFF_TBL_REVERT_PIVOT			(U16_MAX / 2)
+#define SSDFS_BLK2OFF_TBL_LBLK2OFF_CAPACITY_MAX		U16_MAX
+
+/*
+ * struct ssdfs_phys_offset_table_array - array of log's fragments in PEB
+ * @state: PEB's translation table state
+ * @fragment_count: fragments count
+ * @array: array of fragments
+ */
+struct ssdfs_phys_offset_table_array {
+	atomic_t state;
+	atomic_t fragment_count;
+	struct ssdfs_sequence_array *sequence;
+};
+
+enum {
+	SSDFS_BLK2OFF_TABLE_UNDEFINED,
+	SSDFS_BLK2OFF_TABLE_CREATED,
+	SSDFS_BLK2OFF_TABLE_PARTIAL_INIT,
+	SSDFS_BLK2OFF_TABLE_DIRTY_PARTIAL_INIT,
+	SSDFS_BLK2OFF_TABLE_COMPLETE_INIT,
+	SSDFS_BLK2OFF_TABLE_DIRTY,
+	SSDFS_BLK2OFF_TABLE_STATE_MAX,
+};
+
+#define SSDFS_BLK2OFF_TABLE_INVALID_ID		U16_MAX
+
+/*
+ * struct ssdfs_block_descriptor_state - block descriptor state
+ * @status: state of block descriptor buffer
+ * @buf: block descriptor buffer
+ */
+struct ssdfs_block_descriptor_state {
+	u32 status;
+	struct ssdfs_block_descriptor buf;
+};
+
+/*
+ * Block descriptor buffer state
+ */
+enum {
+	SSDFS_BLK_DESC_BUF_UNKNOWN_STATE,
+	SSDFS_BLK_DESC_BUF_INITIALIZED,
+	SSDFS_BLK_DESC_BUF_STATE_MAX,
+	SSDFS_BLK_DESC_BUF_ALLOCATED = U32_MAX,
+};
+
+/*
+ * struct ssdfs_offset_position - defines offset id and position
+ * @cno: checkpoint of change
+ * @id: physical offset ID
+ * @peb_index: PEB's index
+ * @sequence_id: sequence ID of physical offset table's fragment
+ * @offset_index: offset index inside of fragment
+ * @blk_desc: logical block descriptor
+ */
+struct ssdfs_offset_position {
+	u64 cno;
+	u16 id;
+	u16 peb_index;
+	u16 sequence_id;
+	u16 offset_index;
+
+	struct ssdfs_block_descriptor_state blk_desc;
+};
+
+/*
+ * struct ssdfs_migrating_block - migrating block state
+ * @state: logical block's state
+ * @peb_index: PEB's index
+ * @sequence_id: fragment's sequence_id in PEB
+ * @batch: copy of logical block's content (under migration only)
+ */
+struct ssdfs_migrating_block {
+	int state;
+	u16 peb_index;
+	u16 sequence_id;
+	struct folio_batch batch;
+};
+
+/*
+ * Migrating block's states
+ */
+enum {
+	SSDFS_LBLOCK_UNKNOWN_STATE,
+	SSDFS_LBLOCK_UNDER_MIGRATION,
+	SSDFS_LBLOCK_UNDER_COMMIT,
+	SSDFS_LBLOCK_STATE_MAX
+};
+
+enum {
+	SSDFS_LBMAP_INIT_INDEX,
+	SSDFS_LBMAP_STATE_INDEX,
+	SSDFS_LBMAP_MODIFICATION_INDEX,
+	SSDFS_LBMAP_ARRAY_MAX,
+};
+
+
+/*
+ * struct ssdfs_bitmap_array - bitmap array
+ * @bits_count: number of available bits in every bitmap
+ * @bytes_count: number of allocated bytes in every bitmap
+ * @array: array of bitmaps
+ */
+struct ssdfs_bitmap_array {
+	u32 bits_count;
+	u32 bytes_count;
+	unsigned long *array[SSDFS_LBMAP_ARRAY_MAX];
+};
+
+/*
+ * struct ssdfs_blk2off_table - in-core translation table
+ * @flags: flags of translation table
+ * @state: translation table object state
+ * @pages_per_peb: pages per physical erase block
+ * @pages_per_seg: pages per segment
+ * @type: translation table type
+ * @translation_lock: lock of translation operation
+ * @init_cno: last actual checkpoint
+ * @used_logical_blks: count of used logical blocks
+ * @free_logical_blks: count of free logical blocks
+ * @last_allocated_blk: last allocated block (hint for allocation)
+ * @lbmap: array of block bitmaps
+ * @lblk2off: array of correspondence between logical numbers and phys off ids
+ * @migrating_blks: array of migrating blocks
+ * @lblk2off_capacity: capacity of correspondence array
+ * @peb: sequence of physical offset arrays
+ * @pebs_count: count of PEBs in segment
+ * @partial_init_end: wait of partial init ending
+ * @full_init_end: wait of full init ending
+ * @wait_queue: wait queue of blk2off table
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_blk2off_table {
+	atomic_t flags;
+	atomic_t state;
+
+	u32 pages_per_peb;
+	u32 pages_per_seg;
+	u8 type;
+
+	struct rw_semaphore translation_lock;
+	u64 init_cno;
+	u16 used_logical_blks;
+	u16 free_logical_blks;
+	u16 last_allocated_blk;
+	struct ssdfs_bitmap_array lbmap;
+	struct ssdfs_dynamic_array lblk2off;
+	struct ssdfs_dynamic_array migrating_blks;
+	u16 lblk2off_capacity;
+
+	struct ssdfs_phys_offset_table_array *peb;
+	u16 pebs_count;
+
+	struct completion partial_init_end;
+	struct completion full_init_end;
+	wait_queue_head_t wait_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+#define SSDFS_OFF_POS(ptr) \
+	((struct ssdfs_offset_position *)(ptr))
+#define SSDFS_MIGRATING_BLK(ptr) \
+	((struct ssdfs_migrating_block *)(ptr))
+#define SSDFS_TRANS_EXT(ptr) \
+	((struct ssdfs_translation_extent *)(ptr))
+
+enum {
+	SSDFS_BLK2OFF_OBJECT_UNKNOWN,
+	SSDFS_BLK2OFF_OBJECT_CREATED,
+	SSDFS_BLK2OFF_OBJECT_PARTIAL_INIT,
+	SSDFS_BLK2OFF_OBJECT_COMPLETE_INIT,
+	SSDFS_BLK2OFF_OBJECT_STATE_MAX,
+};
+
+/*
+ * struct ssdfs_blk2off_table_snapshot - table state snapshot
+ * @cno: checkpoint of snapshot
+ * @bmap_copy: copy of modification bitmap
+ * @tbl_copy: copy of translation table
+ * @capacity: capacity of table
+ * @used_logical_blks: count of used logical blocks
+ * @free_logical_blks: count of free logical blocks
+ * @last_allocated_blk: last allocated block (hint for allocation)
+ * @peb_index: PEB index
+ * @start_sequence_id: sequence ID of the first dirty fragment
+ * @new_sequence_id: sequence ID of the first newly added fragment
+ * @start_offset_id: starting offset ID
+ * @end_offset_id: ending offset ID
+ * @dirty_fragments: count of dirty fragments
+ * @fragments_count: total count of fragments
+ *
+ * The @bmap_copy and @tbl_copy are allocated during getting
+ * snapshot inside of called function. Freeing of allocated
+ * memory SHOULD BE MADE by caller.
+ */
+struct ssdfs_blk2off_table_snapshot {
+	u64 cno;
+
+	unsigned long *bmap_copy;
+	struct ssdfs_offset_position *tbl_copy;
+	u16 capacity;
+
+	u16 used_logical_blks;
+	u16 free_logical_blks;
+	u16 last_allocated_blk;
+
+	u16 peb_index;
+	u16 start_sequence_id;
+	u16 new_sequence_id;
+	u16 start_offset_id;
+	u16 end_offset_id;
+	u16 dirty_fragments;
+	u32 fragments_count;
+};
+
+/*
+ * Inline functions
+ */
+
+/*
+ * ssdfs_blk2off_table_bmap_bytes() - calculate bmap bytes count
+ * @items_count: bits count in bitmap
+ */
+static inline
+size_t ssdfs_blk2off_table_bmap_bytes(size_t items_count)
+{
+	size_t bytes;
+
+	bytes = (items_count + BITS_PER_LONG - 1) / BITS_PER_LONG;
+	bytes *= sizeof(unsigned long);
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("items_count %zu, bmap_bytes %zu\n",
+		  items_count, bytes);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return bytes;
+}
+
+static inline
+bool is_ssdfs_logical_block_migrating(int blk_state)
+{
+	bool is_migrating = false;
+
+	switch (blk_state) {
+	case SSDFS_LBLOCK_UNDER_MIGRATION:
+	case SSDFS_LBLOCK_UNDER_COMMIT:
+		is_migrating = true;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return is_migrating;
+}
+
+/* Function prototypes */
+struct ssdfs_blk2off_table *
+ssdfs_blk2off_table_create(struct ssdfs_fs_info *fsi,
+			   u16 items_count, u8 type,
+			   int state);
+void ssdfs_blk2off_table_destroy(struct ssdfs_blk2off_table *table);
+int ssdfs_blk2off_table_partial_clean_init(struct ssdfs_blk2off_table *table,
+					   u16 peb_index);
+int ssdfs_blk2off_table_partial_init(struct ssdfs_blk2off_table *table,
+				     struct ssdfs_read_init_env *env,
+				     u16 peb_index, u64 peb_id, u64 cno);
+int ssdfs_blk2off_table_blk_desc_init(struct ssdfs_blk2off_table *table,
+					u16 logical_blk,
+					struct ssdfs_offset_position *pos);
+int ssdfs_blk2off_table_resize(struct ssdfs_blk2off_table *table,
+				u16 new_items_count);
+int ssdfs_blk2off_table_snapshot(struct ssdfs_blk2off_table *table,
+				 u16 peb_index, u64 peb_id,
+				 struct ssdfs_blk2off_table_snapshot *snapshot);
+void ssdfs_blk2off_table_free_snapshot(struct ssdfs_blk2off_table_snapshot *sp);
+int ssdfs_blk2off_table_extract_extents(struct ssdfs_blk2off_table_snapshot *sp,
+					struct ssdfs_dynamic_array *array,
+					u16 capacity, u16 *extent_count);
+
+int
+ssdfs_blk2off_table_prepare_for_commit(struct ssdfs_blk2off_table *table,
+				       u16 peb_index, u16 sequence_id,
+				       struct ssdfs_blk2off_table_snapshot *sp);
+int ssdfs_peb_store_offsets_table_header(struct ssdfs_peb_info *pebi,
+					struct ssdfs_blk2off_table_header *hdr,
+					struct ssdfs_peb_log_offset *log_offset);
+int
+ssdfs_peb_store_offsets_table_extents(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_dynamic_array *array,
+				      u16 extent_count,
+				      struct ssdfs_peb_log_offset *log_offset);
+int ssdfs_peb_store_offsets_table_fragment(struct ssdfs_peb_info *pebi,
+					struct ssdfs_blk2off_table *table,
+					u16 peb_index, u16 sequence_id,
+					struct ssdfs_peb_log_offset *log_offset);
+int ssdfs_blk2off_table_pre_delete_fragment(void *item, u64 peb_id);
+int ssdfs_peb_store_offsets_table(struct ssdfs_peb_info *pebi,
+				  struct ssdfs_metadata_descriptor *desc,
+				  struct ssdfs_peb_log_offset *log_offset);
+int
+ssdfs_blk2off_table_forget_snapshot(struct ssdfs_blk2off_table *table,
+				    struct ssdfs_blk2off_table_snapshot *sp,
+				    struct ssdfs_dynamic_array *array,
+				    u16 extent_count);
+
+bool ssdfs_blk2off_table_dirtied(struct ssdfs_blk2off_table *table,
+				 u16 peb_index);
+bool ssdfs_blk2off_table_initialized(struct ssdfs_blk2off_table *table,
+				     u16 peb_index);
+
+int ssdfs_blk2off_table_get_used_logical_blks(struct ssdfs_blk2off_table *tbl,
+						u16 *used_blks);
+int ssdfs_blk2off_table_get_offset_position(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    struct ssdfs_offset_position *pos);
+struct ssdfs_phys_offset_descriptor *
+ssdfs_blk2off_table_convert(struct ssdfs_blk2off_table *table,
+			    u16 logical_blk, u16 *peb_index,
+			    int *migration_state,
+			    struct ssdfs_offset_position *pos);
+int ssdfs_blk2off_table_allocate_block(struct ssdfs_blk2off_table *table,
+					u32 max_blk,
+					u16 *logical_blk);
+int ssdfs_blk2off_table_allocate_extent(struct ssdfs_blk2off_table *table,
+					u16 len, u32 max_blk,
+					struct ssdfs_blk2off_range *extent);
+int ssdfs_blk2off_table_change_offset(struct ssdfs_blk2off_table *table,
+				      u16 logical_blk,
+				      u16 peb_index,
+				      u64 peb_id,
+				      struct ssdfs_block_descriptor *blk_desc,
+				      struct ssdfs_phys_offset_descriptor *off);
+int ssdfs_blk2off_table_free_block(struct ssdfs_blk2off_table *table,
+				   u16 peb_index, u64 peb_id, u16 logical_blk);
+int ssdfs_blk2off_table_free_extent(struct ssdfs_blk2off_table *table,
+				    u16 peb_index, u64 peb_id,
+				    struct ssdfs_blk2off_range *extent);
+bool is_ssdfs_blk2off_table_extent_modified(struct ssdfs_blk2off_table *table,
+					    u16 peb_index,
+					    struct ssdfs_blk2off_range *extent);
+
+int ssdfs_blk2off_table_get_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index);
+int ssdfs_blk2off_table_set_block_migration(struct ssdfs_blk2off_table *table,
+					    u16 logical_blk,
+					    u16 peb_index,
+					    struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_get_block_state(struct ssdfs_blk2off_table *table,
+					struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_update_block_state(struct ssdfs_blk2off_table *table,
+					   struct ssdfs_segment_request *req);
+int ssdfs_blk2off_table_set_block_commit(struct ssdfs_blk2off_table *table,
+					 u16 logical_blk,
+					 u16 peb_index);
+int ssdfs_blk2off_table_revert_migration_state(struct ssdfs_blk2off_table *tbl,
+						u16 peb_index);
+
+#ifdef CONFIG_SSDFS_TESTING
+int ssdfs_blk2off_table_fragment_set_clean(struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id);
+#else
+static inline
+int ssdfs_blk2off_table_fragment_set_clean(struct ssdfs_blk2off_table *table,
+					   u16 peb_index, u16 sequence_id)
+{
+	SSDFS_ERR("set fragment clean is not supported\n");
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SSDFS_TESTING */
+
+#endif /* _SSDFS_OFFSET_TRANSLATION_TABLE_H */
-- 
2.34.1

