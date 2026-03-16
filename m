Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9778030FC30
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627585; cv=none; b=aTBlECTLQ7PYJWR7km1gPIZA027UPvTf4hJVzEsQIbP9QvTBewg2jK9Ti+X/HrcssUfgUbrNw2BFB6jeBVchp9perItQUCpN1Aqi9KYlrE72NMVA4NRdkWymiWsvYEl5yaWHHadcied1F3VFFSoCQ8ypT86Wol149tTLcQSl2Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627585; c=relaxed/simple;
	bh=YRX6XnI1QoXQAEkADobKtwyy349//xC5aKfOrg+Od90=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3mRVAWTr3RkR+2LJyQ0ivPaFJaAGyxrN9KPDsz2jhfG8YhSVQHViOjHH0OZEC3ceCqHGQn9Q+e4HawoLdLX9tHP6H4XmuLPiTYh7S7MgqdJ1aB/Lrr7vVpsba1Me7KYx9TNq5Rq4LsGT26sVacLg5wdjkxmyeZv+sVewweT1aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=qA+qO0yy; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="qA+qO0yy"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-799569f6e9dso39414047b3.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627579; x=1774232379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uhuxej03SVxbvY8lEu/pWlY20tEfKm1um8sySX/uRyI=;
        b=qA+qO0yy+z7T3n92SCfUTJ1GVyApr8BfOg3RMlYHZN+hUjcBg2dZnrBpDYEHqx2RRu
         5Qb/wfHsg6r+auchVsCiDMzklQSK44trD2hdhpV3rL79t18CL9z6onjH6JFvRIlkctQ3
         3CoD9NKvUPlkVkNCDfUAvrHedfKU7uCPl4n3JY/Myp9kI1IzCIMkccGEoN3MYnYWgjEg
         nb2YjCuMXd88akfqQzw0xrommKGZBqEC1pmhUCk0Ug41jbGSpQQLXfuYAr5iTp/zPETz
         JLlnmnHMYZbSa3DfduKbUilF7d+d4Bzxq1ircNY54E7zdyGoYjfwv3lvzrJepVX1wY0l
         V9Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627579; x=1774232379;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Uhuxej03SVxbvY8lEu/pWlY20tEfKm1um8sySX/uRyI=;
        b=LF3/PR9y2LtuBZ68PonDZtxiDEAyiDKHMLVTTFkTDMfXOZtRXmoufbk/OOOErDHNor
         51WSqNISZ41IlrecWyab5jrO9i1h13I6AbRsl4mrze6AlSNW+KkDvqBY3CMgFFUHCHAu
         KEWK96sqf28uC1PHuD54wzEDO4oZ/QYRvxp9tnpNUH8Ew8rsWw2yNwe3Z10m/aYRAYsL
         5Ybd7srBM/PyHXY0do6KX9jucWm6a2wctHBWM2pdfO4nFeSJ6frfrYhhNTiku4oZ2g1J
         8h+I1BcdcknVhOMt0BpKN/YHKhtAgCPcIYtpOJh6tfJVbPucCBzfU7W9hi08CBlYLkvy
         JPlA==
X-Gm-Message-State: AOJu0YwMK7qVBviAs97veCPiTN2H5frYjS729b8ti0DqdgNYIwU0Jt95
	NQwEtDkh2BXzdrWxsQViwl817mW4/D+pq3Xgoj5Ek3s2tnY734dEQOxT3W6txnH+3Mbwy0HI18J
	4sR1P
X-Gm-Gg: ATEYQzzi25/rlTO++YSrxPOJ9AvLovDAZjJJwvaSErB3enU4j1BtilOBuWceld4W0jm
	OYDNwOE2/e/1XzKTFr0QLWjFiugZH+nYncmn8IS6jiRauySFT6zL7P3qacrjMwf+WVgFJtaM0/9
	rmhLqmwFSta/2ngS+xwN2CvVahYtojr2fQUM6/j3YumPG39FDl4tZ7uXZtLyP2zNmrEGv2rG/xQ
	8Pg1OdJVk4zpK5Re9XER0KHIImkKoia+qOEo/0IE5Q8wtqXQ7UShUo5cTRw2V+2M1T5kxaxyR+E
	ZBK3QzWX1+Yvvy328C42ldb96nhvgsnRgiiGu4RkuwNKQR0fenq/ffcM9obaRUEL8KzPv7v/gaS
	dT/32+geo/iAjvbckquRsRuE3Bhv8im7jBKJlw8r4q0Un7K1FR7e2gIcKQiE3dk1kZAMFiCa3jL
	WV91Rs2jv+Ohy1eDxP/L7685N/HoaldbW8XsFgkPxWFDEhCehjEQxTyTZI4wUS7+EoOCQOiGEDJ
	1E2PVxDlPCPZ6UBQoXf+Py4aqIdR364qZI=
X-Received: by 2002:a05:690c:6e86:b0:794:d887:726e with SMTP id 00721157ae682-79a1c20c30fmr111722607b3.57.1773627578985;
        Sun, 15 Mar 2026 19:19:38 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:38 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 24/79] ssdfs: introduce PEB object
Date: Sun, 15 Mar 2026 19:17:39 -0700
Message-ID: <20260316021800.1694650-13-slava@dubeyko.com>
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
Block (PEB). PEB represent concept of erase block or zone
that can be allocated, be filled by logs, and be erased.
PEB object keeps knowledge about PEB ID, index in segment,
and current log details.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/peb.h      | 600 ++++++++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/peb_init.h | 364 +++++++++++++++++++++++++++
 2 files changed, 964 insertions(+)
 create mode 100644 fs/ssdfs/peb.h
 create mode 100644 fs/ssdfs/peb_init.h

diff --git a/fs/ssdfs/peb.h b/fs/ssdfs/peb.h
new file mode 100644
index 000000000000..5f1d81683e8d
--- /dev/null
+++ b/fs/ssdfs/peb.h
@@ -0,0 +1,600 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb.h - Physical Erase Block (PEB) object declarations.
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
+#ifndef _SSDFS_PEB_H
+#define _SSDFS_PEB_H
+
+#include "request_queue.h"
+#include "fingerprint_array.h"
+#include "peb_init.h"
+
+/*
+ * struct ssdfs_protection_window - protection window length
+ * @cno_lock: lock of checkpoints set
+ * @create_cno: creation checkpoint
+ * @last_request_cno: last request checkpoint
+ * @reqs_count: current number of active requests
+ * @protected_range: last measured protected range length
+ * @future_request_cno: expectation to receive a next request in the future
+ */
+struct ssdfs_protection_window {
+	spinlock_t cno_lock;
+	u64 create_cno;
+	u64 last_request_cno;
+	u32 reqs_count;
+	u64 protected_range;
+	u64 future_request_cno;
+};
+
+/*
+ * struct ssdfs_peb_diffs_area_metadata - diffs area's metadata
+ * @hdr: diffs area's table header
+ */
+struct ssdfs_peb_diffs_area_metadata {
+	struct ssdfs_block_state_descriptor hdr;
+};
+
+/*
+ * struct ssdfs_peb_journal_area_metadata - journal area's metadata
+ * @hdr: journal area's table header
+ */
+struct ssdfs_peb_journal_area_metadata {
+	struct ssdfs_block_state_descriptor hdr;
+};
+
+/*
+ * struct ssdfs_peb_area_metadata - descriptor of area's items chain
+ * @area.blk_desc.table: block descriptors area table
+ * @area.blk_desc.flush_buf: write block descriptors buffer (compression case)
+ * @area.blk_desc.capacity: max number of block descriptors in reserved space
+ * @area.blk_desc.items_count: number of items in the whole table
+ * @area.diffs.table: diffs area's table
+ * @area.journal.table: journal area's table
+ * @area.main.desc: main area's descriptor
+ * @reserved_offset: reserved write offset of table
+ * @sequence_id: fragment's sequence number
+ */
+struct ssdfs_peb_area_metadata {
+	union {
+		struct {
+			struct ssdfs_area_block_table table;
+			struct ssdfs_peb_temp_buffer flush_buf;
+			int capacity;
+			int items_count;
+		} blk_desc;
+
+		struct {
+			struct ssdfs_peb_diffs_area_metadata table;
+		} diffs;
+
+		struct {
+			struct ssdfs_peb_journal_area_metadata table;
+		} journal;
+
+		struct {
+			struct ssdfs_block_state_descriptor desc;
+		} main;
+	} area;
+
+	u32 reserved_offset;
+	u8 sequence_id;
+};
+
+/*
+ * struct ssdfs_peb_area - log's area descriptor
+ * @has_metadata: does area contain metadata?
+ * @metadata: descriptor of area's items chain
+ * @write_offset: current write offset
+ * @compressed_offset: current write offset for compressed data
+ * @frag_offset: offset of current fragment
+ * @array: area's memory folios
+ */
+struct ssdfs_peb_area {
+	bool has_metadata;
+	struct ssdfs_peb_area_metadata metadata;
+
+	u32 write_offset;
+	u32 compressed_offset;
+	u32 frag_offset;
+	struct ssdfs_folio_array array;
+};
+
+/*
+ * struct ssdfs_blk2off_table_area - blk2off table descriptor
+ * @hdr: offset descriptors area table's header
+ * @reserved_offset: reserved header offset
+ * @compressed_offset: current write offset for compressed data
+ * @sequence_id: fragment's sequence number
+ */
+struct ssdfs_blk2off_table_area {
+	struct ssdfs_blk2off_table_header hdr;
+
+	u32 reserved_offset;
+	u32 compressed_offset;
+	u8 sequence_id;
+};
+
+/* Log possible states */
+enum {
+	SSDFS_LOG_UNKNOWN,
+	SSDFS_LOG_PREPARED,
+	SSDFS_LOG_INITIALIZED,
+	SSDFS_LOG_CREATED,
+	SSDFS_LOG_COMMITTED,
+	SSDFS_LOG_STATE_MAX,
+};
+
+/*
+ * struct ssdfs_peb_prev_log - previous log's details
+ * @bmap_bytes: bytes count in block bitmap of previous log
+ * @blk2off_bytes: bytes count in blk2off table of previous log
+ * @blk_desc_bytes: bytes count in blk desc table of previous log
+ */
+struct ssdfs_peb_prev_log {
+	u32 bmap_bytes;
+	u32 blk2off_bytes;
+	u32 blk_desc_bytes;
+};
+
+/*
+ * struct ssdfs_peb_log - current log
+ * @lock: exclusive lock of current log
+ * @state: current log's state
+ * @sequence_id: index of partial log in the sequence
+ * @start_block: current log's start block index
+ * @reserved_blocks: metadata blocks in the log
+ * @free_data_blocks: free data blocks capacity
+ * @seg_flags: segment header's flags for the log
+ * @prev_log: previous log's details
+ * @last_log_time: creation timestamp of last log
+ * @last_log_cno: last log checkpoint
+ * @bmap_snapshot: snapshot of block bitmap
+ * @blk2off_tbl: blk2off table descriptor
+ * @area: log's areas (main, diff updates, journal)
+ */
+struct ssdfs_peb_log {
+	struct mutex lock;
+	atomic_t state;
+	atomic_t sequence_id;
+	u32 start_block;
+	u32 reserved_blocks; /* metadata blocks in the log */
+	u32 free_data_blocks; /* free data blocks capacity */
+	u32 seg_flags;
+	struct ssdfs_peb_prev_log prev_log;
+	u64 last_log_time;
+	u64 last_log_cno;
+	struct ssdfs_folio_vector bmap_snapshot;
+	struct ssdfs_blk2off_table_area blk2off_tbl;
+	struct ssdfs_peb_area area[SSDFS_LOG_AREA_MAX];
+};
+
+/*
+ * struct ssdfs_peb_log_offset - current log offset
+ * @blocksize_shift: log2(block size)
+ * @log_blocks: count of blocks in full partial log
+ * @start_block: current log's start block index
+ * @cur_block: current block in the log
+ * @offset_into_block: current offset into block
+ */
+struct ssdfs_peb_log_offset {
+	u32 blocksize_shift;
+	u32 log_blocks;
+	pgoff_t start_block;
+	pgoff_t cur_block;
+	u32 offset_into_block;
+};
+
+/*
+ * struct ssdfs_peb_deduplication - PEB deduplication environment
+ * @shash_tfm: message digest handle
+ * @fingerprints: fingeprints array
+ */
+struct ssdfs_peb_deduplication {
+	struct crypto_shash *shash_tfm;
+	struct ssdfs_fingerprint_array fingerprints;
+};
+
+/*
+ * struct ssdfs_peb_info - Physical Erase Block (PEB) description
+ * @peb_id: PEB number
+ * @peb_index: PEB index
+ * @log_blocks: count of blocks in full partial log
+ * @peb_create_time: PEB creation timestamp
+ * @peb_migration_id: identification number of PEB in migration sequence
+ * @state: PEB object state
+ * @init_end: wait of full init ending
+ * @peb_state: current PEB state
+ * @reserved_bytes.blk_bmap: reserved bytes for block bitmap
+ * @reserved_bytes.blk2off_tbl: reserved bytes for blk2off table
+ * @reserved_bytes.blk_desc_tbl: reserved bytes for block descriptor table
+ * @current_log: PEB's current log
+ * @dedup: PEB's deduplication environment
+ * @read_buffer: temporary read buffers (compression case)
+ * @env: init environment
+ * @cache: PEB's memory folios
+ * @pebc: pointer on parent container
+ */
+struct ssdfs_peb_info {
+	/* Static data */
+	u64 peb_id;
+	u16 peb_index;
+	u32 log_blocks;
+
+	u64 peb_create_time;
+
+	/*
+	 * The peb_migration_id is stored in two places:
+	 * (1) struct ssdfs_segment_header;
+	 * (2) struct ssdfs_blk_state_offset.
+	 *
+	 * The goal of peb_migration_id is to distinguish PEB
+	 * objects during PEB object's migration. Every
+	 * destination PEB is received the migration_id that
+	 * is incremented migration_id value of source PEB
+	 * object. If peb_migration_id is achieved value of
+	 * SSDFS_PEB_MIGRATION_ID_MAX then peb_migration_id
+	 * is started from SSDFS_PEB_MIGRATION_ID_START again.
+	 *
+	 * A PEB object is received the peb_migration_id value
+	 * during the PEB object creation operation. The "clean"
+	 * PEB object receives SSDFS_PEB_MIGRATION_ID_START
+	 * value. The destinaton PEB object receives incremented
+	 * peb_migration_id value of source PEB object during
+	 * creation operation. Otherwise, the real peb_migration_id
+	 * value is set during PEB's initialization
+	 * by means of extracting the actual value from segment
+	 * header.
+	 */
+	atomic_t peb_migration_id;
+
+	atomic_t state;
+	struct completion init_end;
+
+	atomic_t peb_state;
+
+	/* Reserved bytes */
+	struct {
+		atomic_t blk_bmap;
+		atomic_t blk2off_tbl;
+		atomic_t blk_desc_tbl;
+	} reserved_bytes;
+
+	/* Current log */
+	struct ssdfs_peb_log current_log;
+
+	/* Fingerprints array */
+#ifdef CONFIG_SSDFS_PEB_DEDUPLICATION
+	struct ssdfs_peb_deduplication dedup;
+#endif /* CONFIG_SSDFS_PEB_DEDUPLICATION */
+
+	/* Read buffer */
+	struct ssdfs_peb_temp_read_buffers read_buffer;
+
+	/* Init environment */
+	struct ssdfs_read_init_env env;
+
+	/* PEB's memory folios */
+	struct ssdfs_folio_array cache;
+
+	/* Parent container */
+	struct ssdfs_peb_container *pebc;
+};
+
+/* PEB object states */
+enum {
+	SSDFS_PEB_OBJECT_UNKNOWN_STATE,
+	SSDFS_PEB_OBJECT_CREATED,
+	SSDFS_PEB_OBJECT_INITIALIZED,
+	SSDFS_PEB_OBJECT_STATE_MAX
+};
+
+#define SSDFS_AREA_TYPE2INDEX(type)({ \
+	int index; \
+	switch (type) { \
+	case SSDFS_LOG_BLK_DESC_AREA: \
+		index = SSDFS_BLK_DESC_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_MAIN_AREA: \
+		index = SSDFS_COLD_PAYLOAD_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_DIFFS_AREA: \
+		index = SSDFS_WARM_PAYLOAD_AREA_INDEX; \
+		break; \
+	case SSDFS_LOG_JOURNAL_AREA: \
+		index = SSDFS_HOT_PAYLOAD_AREA_INDEX; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	index; \
+})
+
+#define SSDFS_AREA_TYPE2FLAG(type)({ \
+	int flag; \
+	switch (type) { \
+	case SSDFS_LOG_BLK_DESC_AREA: \
+		flag = SSDFS_LOG_HAS_BLK_DESC_CHAIN; \
+		break; \
+	case SSDFS_LOG_MAIN_AREA: \
+		flag = SSDFS_LOG_HAS_COLD_PAYLOAD; \
+		break; \
+	case SSDFS_LOG_DIFFS_AREA: \
+		flag = SSDFS_LOG_HAS_WARM_PAYLOAD; \
+		break; \
+	case SSDFS_LOG_JOURNAL_AREA: \
+		flag = SSDFS_LOG_HAS_HOT_PAYLOAD; \
+		break; \
+	default: \
+		BUG(); \
+	}; \
+	flag; \
+})
+
+/*
+ * Inline functions
+ */
+
+/*
+ * ssdfs_peb_current_log_state() - check current log's state
+ * @pebi: pointer on PEB object
+ * @state: checked state
+ */
+static inline
+bool ssdfs_peb_current_log_state(struct ssdfs_peb_info *pebi,
+				 int state)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(state < SSDFS_LOG_UNKNOWN || state >= SSDFS_LOG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&pebi->current_log.state) >= state;
+}
+
+/*
+ * ssdfs_peb_set_current_log_state() - set current log's state
+ * @pebi: pointer on PEB object
+ * @state: new log's state
+ */
+static inline
+void ssdfs_peb_set_current_log_state(struct ssdfs_peb_info *pebi,
+				     int state)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(state < SSDFS_LOG_UNKNOWN || state >= SSDFS_LOG_STATE_MAX);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_set(&pebi->current_log.state, state);
+}
+
+/*
+ * IS_SSDFS_BLK_STATE_OFFSET_INVALID() - check that block state offset invalid
+ * @desc: block state offset
+ */
+static inline
+bool IS_SSDFS_BLK_STATE_OFFSET_INVALID(struct ssdfs_blk_state_offset *desc)
+{
+	if (!desc)
+		return true;
+
+	if (le16_to_cpu(desc->log_start_page) == U16_MAX &&
+	    desc->log_area == U8_MAX &&
+	    desc->peb_migration_id == U8_MAX &&
+	    le32_to_cpu(desc->byte_offset) == U32_MAX) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log_start_block %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(desc->log_start_page),
+			  desc->log_area,
+			  desc->peb_migration_id,
+			  le32_to_cpu(desc->byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+	}
+
+	if (desc->peb_migration_id == SSDFS_PEB_UNKNOWN_MIGRATION_ID) {
+#ifdef CONFIG_SSDFS_DEBUG
+		SSDFS_DBG("log_start_block %u, log_area %u, "
+			  "peb_migration_id %u, byte_offset %u\n",
+			  le16_to_cpu(desc->log_start_page),
+			  desc->log_area,
+			  desc->peb_migration_id,
+			  le32_to_cpu(desc->byte_offset));
+#endif /* CONFIG_SSDFS_DEBUG */
+		return true;
+	}
+
+	return false;
+}
+
+/*
+ * SSDFS_BLK_DESC_INIT() - init block descriptor
+ * @blk_desc: block descriptor
+ */
+static inline
+void SSDFS_BLK_DESC_INIT(struct ssdfs_block_descriptor *blk_desc)
+{
+	if (!blk_desc) {
+		SSDFS_WARN("block descriptor pointer is NULL\n");
+		return;
+	}
+
+	memset(blk_desc, 0xFF, sizeof(struct ssdfs_block_descriptor));
+}
+
+/*
+ * IS_SSDFS_BLK_DESC_EXHAUSTED() - check that block descriptor is exhausted
+ * @blk_desc: block descriptor
+ */
+static inline
+bool IS_SSDFS_BLK_DESC_EXHAUSTED(struct ssdfs_block_descriptor *blk_desc)
+{
+	struct ssdfs_blk_state_offset *offset = NULL;
+
+	if (!blk_desc)
+		return true;
+
+	offset = &blk_desc->state[SSDFS_BLK_STATE_OFF_MAX - 1];
+
+	if (!IS_SSDFS_BLK_STATE_OFFSET_INVALID(offset))
+		return true;
+
+	return false;
+}
+
+static inline
+bool IS_SSDFS_BLK_DESC_READY_FOR_DIFF(struct ssdfs_block_descriptor *blk_desc)
+{
+	return !IS_SSDFS_BLK_STATE_OFFSET_INVALID(&blk_desc->state[0]);
+}
+
+static inline
+u8 SSDFS_GET_BLK_DESC_MIGRATION_ID(struct ssdfs_block_descriptor *blk_desc)
+{
+	if (IS_SSDFS_BLK_STATE_OFFSET_INVALID(&blk_desc->state[0]))
+		return U8_MAX;
+
+	return blk_desc->state[0].peb_migration_id;
+}
+
+static inline
+void DEBUG_BLOCK_DESCRIPTOR(u64 seg_id, u64 peb_id,
+			    struct ssdfs_block_descriptor *blk_desc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	int i;
+
+	SSDFS_DBG("seg_id %llu, peb_id %llu, ino %llu, "
+		  "logical_offset %u, peb_index %u, peb_page %u\n",
+		  seg_id, peb_id,
+		  le64_to_cpu(blk_desc->ino),
+		  le32_to_cpu(blk_desc->logical_offset),
+		  le16_to_cpu(blk_desc->peb_index),
+		  le16_to_cpu(blk_desc->peb_page));
+
+	for (i = 0; i < SSDFS_BLK_STATE_OFF_MAX; i++) {
+		SSDFS_DBG("BLK STATE OFFSET %d: "
+			  "log_start_page %u, log_area %#x, "
+			  "byte_offset %u, peb_migration_id %u\n",
+			  i,
+			  le16_to_cpu(blk_desc->state[i].log_start_page),
+			  blk_desc->state[i].log_area,
+			  le32_to_cpu(blk_desc->state[i].byte_offset),
+			  blk_desc->state[i].peb_migration_id);
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * PEB object's API
+ */
+int ssdfs_peb_object_create(struct ssdfs_peb_info *pebi,
+			    struct ssdfs_peb_container *pebc,
+			    u64 peb_id, int peb_state,
+			    u8 peb_migration_id);
+int ssdfs_peb_object_destroy(struct ssdfs_peb_info *pebi);
+void ssdfs_peb_current_log_init(struct ssdfs_peb_info *pebi,
+				u32 free_blocks,
+				u32 start_block,
+				int sequence_id,
+				struct ssdfs_peb_prev_log *prev_log);
+u64 ssdfs_get_leb_id_for_peb_index(struct ssdfs_fs_info *fsi,
+				   u64 seg, u32 peb_index);
+u64 ssdfs_get_seg_id_for_leb_id(struct ssdfs_fs_info *fsi,
+				u64 leb_id);
+int ssdfs_get_peb_migration_id(struct ssdfs_peb_info *pebi);
+bool is_peb_migration_id_valid(int peb_migration_id);
+int ssdfs_get_peb_migration_id_checked(struct ssdfs_peb_info *pebi);
+void ssdfs_set_peb_migration_id(struct ssdfs_peb_info *pebi,
+				int id);
+int __ssdfs_define_next_peb_migration_id(int prev_id);
+int ssdfs_define_next_peb_migration_id(struct ssdfs_peb_info *src_peb);
+int ssdfs_define_prev_peb_migration_id(struct ssdfs_peb_info *pebi);
+
+#ifdef CONFIG_SSDFS_PEB_DEDUPLICATION
+bool is_ssdfs_block_duplicated(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_fingerprint_pair *pair);
+int ssdfs_peb_deduplicate_logical_block(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					struct ssdfs_fingerprint_pair *pair,
+					struct ssdfs_block_descriptor *blk_desc);
+bool should_ssdfs_save_fingerprint(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_segment_request *req);
+int ssdfs_peb_save_fingerprint(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_block_descriptor *blk_desc,
+				struct ssdfs_fingerprint_pair *pair);
+#else
+static inline
+bool is_ssdfs_block_duplicated(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_fingerprint_pair *pair)
+{
+	return false;
+}
+static inline
+int ssdfs_peb_deduplicate_logical_block(struct ssdfs_peb_info *pebi,
+					struct ssdfs_segment_request *req,
+					struct ssdfs_fingerprint_pair *pair,
+					struct ssdfs_block_descriptor *blk_desc)
+{
+	return -EOPNOTSUPP;
+}
+static inline
+bool should_ssdfs_save_fingerprint(struct ssdfs_peb_info *pebi,
+				   struct ssdfs_segment_request *req)
+{
+	return false;
+}
+static inline
+int ssdfs_peb_save_fingerprint(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_block_descriptor *blk_desc,
+				struct ssdfs_fingerprint_pair *pair)
+{
+	return -EOPNOTSUPP;
+}
+#endif /* CONFIG_SSDFS_PEB_DEDUPLICATION */
+
+/*
+ * PEB internal functions declaration
+ */
+int ssdfs_unaligned_read_cache(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				u32 area_offset, u32 area_size,
+				void *buf);
+int ssdfs_peb_read_log_hdr_desc_array(struct ssdfs_peb_info *pebi,
+				      struct ssdfs_segment_request *req,
+				      u16 log_start_block,
+				      struct ssdfs_metadata_descriptor *array,
+				      size_t array_size);
+u16 ssdfs_peb_estimate_min_partial_log_pages(struct ssdfs_peb_info *pebi);
+u32 ssdfs_request_rest_bytes(struct ssdfs_peb_info *pebi,
+			     struct ssdfs_segment_request *req);
+bool is_ssdfs_peb_exhausted(struct ssdfs_fs_info *fsi,
+			    struct ssdfs_peb_info *pebi);
+bool is_ssdfs_peb_ready_to_exhaust(struct ssdfs_fs_info *fsi,
+				   struct ssdfs_peb_info *pebi);
+
+#endif /* _SSDFS_PEB_H */
diff --git a/fs/ssdfs/peb_init.h b/fs/ssdfs/peb_init.h
new file mode 100644
index 000000000000..658f5f73e6bc
--- /dev/null
+++ b/fs/ssdfs/peb_init.h
@@ -0,0 +1,364 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_init.h - PEB init structures' declarations.
+ *
+ * Copyright (c) 2024-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_PEB_INIT_H
+#define _SSDFS_PEB_INIT_H
+
+/*
+ * struct ssdfs_contigous_bytes - contigous sequence of bytes
+ * @offset: offset of sequence in bytes
+ * @size: length of sequence in bytes
+ */
+struct ssdfs_contigous_bytes {
+	u32 offset;
+	u32 size;
+};
+
+/*
+ * struct ssdfs_compressed_area - compressed area descriptor
+ * @compressed: descriptor of compressed byte stream
+ * @meta_desc: copy of metadata area's descriptor
+ */
+struct ssdfs_compressed_area {
+	struct ssdfs_contigous_bytes compressed;
+	struct ssdfs_metadata_descriptor meta_desc;
+
+};
+
+/*
+ * struct ssdfs_compressed_portion - compressed portion descriptor
+ * @area: descriptor of area that contains portion
+ * @header_size: size of the portion header
+ * @compressed: descriptor of compressed state of portion
+ * @uncompressed: descriptor of decompressed state of portion
+ */
+struct ssdfs_compressed_portion {
+	struct ssdfs_compressed_area area;
+
+	size_t header_size;
+
+	struct ssdfs_contigous_bytes compressed;
+	struct ssdfs_contigous_bytes uncompressed;
+};
+
+/*
+ * struct ssdfs_compressed_fragment - compressed fragment descriptor
+ * @portion: portion descriptor that contains fragment
+ * @compressed: descriptor of compressed state of fragment
+ * @uncompressed: descriptor of decompressed state of fragment
+ * @frag_desc: fragment descriptor
+ */
+struct ssdfs_compressed_fragment {
+	struct ssdfs_compressed_portion portion;
+
+	struct ssdfs_contigous_bytes compressed;
+	struct ssdfs_contigous_bytes uncompressed;
+
+	struct ssdfs_fragment_desc frag_desc;
+};
+
+/*
+ * struct ssdfs_fragment_raw_iterator - raw fragment iterator
+ * @frag_desc: fragment descriptor
+ * @offset: current offset
+ * @bytes_count: total number of bytes
+ * @processed_bytes: number of processed bytes
+ * @fragments_count: total number of fragments
+ * @processed_fragments: number of preocessed fragments
+ */
+struct ssdfs_fragment_raw_iterator {
+	struct ssdfs_compressed_fragment fragment_desc;
+
+	u32 offset;
+	u32 bytes_count;
+	u32 processed_bytes;
+
+	u32 fragments_count;
+	u32 processed_fragments;
+};
+
+/*
+ * struct ssdfs_raw_iterator - raw stream iterator
+ * @start_offset: start offset in stream
+ * @current_offset: current offset in stream
+ * @bytes_count: total size of content in bytes
+ */
+struct ssdfs_raw_iterator {
+	u32 start_offset;
+	u32 current_offset;
+	u32 bytes_count;
+};
+
+/*
+ * struct ssdfs_content_stream - content stream
+ * @batch: folio vector with content's byte stream
+ * @write_iter: write iterator
+ */
+struct ssdfs_content_stream {
+	struct ssdfs_folio_vector batch;
+//	struct ssdfs_raw_iterator write_iter;
+
+	u32 write_off;
+	u32 bytes_count;
+};
+
+#define SSDFS_BLKBMAP_FRAG_HDR_CAPACITY \
+	(sizeof(struct ssdfs_block_bitmap_fragment) + \
+	 (sizeof(struct ssdfs_fragment_desc) * \
+	  SSDFS_BLK_BMAP_FRAGMENTS_CHAIN_MAX))
+
+#define SSDFS_BLKBMAP_HDR_CAPACITY \
+	(sizeof(struct ssdfs_block_bitmap_header) + \
+	 SSDFS_BLKBMAP_FRAG_HDR_CAPACITY)
+
+/*
+ * struct ssdfs_blk_bmap_init_env - block bitmap init environment
+ * @raw.content: folio vector that stores block bitmap content
+ * @raw.metadata: block bitmap fragment's metadata buffer
+ * @header.ptr: pointer on block bitmap header
+ * @fragment.index: index of block bitmap's fragment
+ * @fragment.header: block bitmap fragment's header
+ * @read_bytes: counter of all read bytes
+ */
+struct ssdfs_blk_bmap_init_env {
+	struct {
+		struct ssdfs_folio_vector content;
+		u8 metadata[SSDFS_BLKBMAP_HDR_CAPACITY];
+	} raw;
+
+	struct {
+		struct ssdfs_block_bitmap_header *ptr;
+	} header;
+
+	struct {
+		int index;
+		struct ssdfs_block_bitmap_fragment *header;
+	} fragment;
+
+	u32 read_bytes;
+};
+
+/*
+ * struct ssdfs_blk2off_table_init_env - blk2off table init environment
+ * @extents.stream: translation extents sequence
+ * @extents.count: count of extents in sequence
+ * @portion.header: blk2off table header
+ * @portion.fragments.stream: phys offset descriptors sequence
+ * @portion.read_iter: read iterator in portion
+ * @portion.area_offset: offset to the blk2off area
+ * @portion.read_off: current read offset
+ */
+struct ssdfs_blk2off_table_init_env {
+	struct {
+		struct ssdfs_content_stream stream;
+		u32 count;
+	} extents;
+
+	struct {
+		struct ssdfs_blk2off_table_header header;
+
+		struct {
+			struct ssdfs_content_stream stream;
+		} fragments;
+
+//		struct ssdfs_fragment_raw_iterator read_iter;
+		u32 area_offset;
+		u32 read_off;
+	} portion;
+};
+
+/*
+ * struct ssdfs_blk_desc_table_init_env - blk desc table init environment
+ * @portion.header: blk desc table header
+ * @portion.raw.content: pagevec with blk desc table fragment
+ * @portion.read_iter: read iterator in portion
+ * @portion.area_offset: offset to the blk2off area
+ * @portion.read_off: current read offset
+ * @portion.write_off: current write offset
+ */
+struct ssdfs_blk_desc_table_init_env {
+	struct {
+		struct ssdfs_area_block_table header;
+
+		struct {
+			struct ssdfs_folio_vector content;
+		} raw;
+
+//		struct ssdfs_fragment_raw_iterator read_iter;
+		u32 area_offset;
+		u32 read_off;
+		u32 write_off;
+	} portion;
+};
+
+/*
+ * struct ssdfs_read_init_env - read operation init environment
+ * @peb.cur_migration_id: current PEB's migration ID
+ * @peb.prev_migration_id: previous PEB's migration ID
+ * @peb.free_pages: PEB's free pages
+ * @log.offset: offset in pages of the requested log
+ * @log.blocks: blocks count in every log of segment
+ * @log.bytes: number of bytes in the requested log
+ * @log.header.ptr: log header
+ * @log.header.of_full_log: is it full log header (segment header)?
+ * @log.footer.ptr: log footer
+ * @log.footer.is_present: does log have footer?
+ * @log.bmap: block bitmap init environment
+ * @log.off_tbl: blk2off table init environment
+ * @log.desc_tbl: blk desc table init environment
+ */
+struct ssdfs_read_init_env {
+	struct {
+		int cur_migration_id;
+		int prev_migration_id;
+		int free_pages;
+	} peb;
+
+	struct {
+		u32 offset;
+		u32 blocks;
+		u32 bytes;
+
+		struct {
+			void *ptr;
+			bool of_full_log;
+		} header;
+
+		struct {
+			struct ssdfs_log_footer *ptr;
+			bool is_present;
+		} footer;
+
+		struct ssdfs_blk_bmap_init_env blk_bmap;
+		struct ssdfs_blk2off_table_init_env blk2off_tbl;
+		struct ssdfs_blk_desc_table_init_env blk_desc_tbl;
+	} log;
+};
+
+/*
+ * struct ssdfs_peb_read_buffer - read buffer
+ * @ptr: pointer on buffer
+ * @buf_size: buffer size in bytes
+ * @frag_desc: fragment descriptor
+ */
+struct ssdfs_peb_read_buffer {
+	void *ptr;
+	size_t buf_size;
+
+	struct ssdfs_compressed_fragment frag_desc;
+};
+
+/*
+ * struct ssdfs_peb_temp_read_buffers - read temporary buffers
+ * @lock: temporary buffers lock
+ * @blk_desc: block descriptor table's temp read buffer
+ */
+struct ssdfs_peb_temp_read_buffers {
+	struct rw_semaphore lock;
+	struct ssdfs_peb_read_buffer blk_desc;
+};
+
+/*
+ * struct ssdfs_peb_temp_buffer - temporary (write) buffer
+ * @ptr: pointer on buffer
+ * @write_offset: current write offset into buffer
+ * @granularity: size of one item in bytes
+ * @size: buffer size in bytes
+ */
+struct ssdfs_peb_temp_buffer {
+	void *ptr;
+	u32 write_offset;
+	size_t granularity;
+	size_t size;
+};
+
+struct ssdfs_peb_log_offset;
+
+/*
+ * PEB object init API
+ */
+void ssdfs_create_content_stream(struct ssdfs_content_stream *stream,
+				 u32 capacity);
+void ssdfs_reinit_content_stream(struct ssdfs_content_stream *stream);
+void ssdfs_destroy_content_stream(struct ssdfs_content_stream *stream);
+
+bool IS_SSDFS_CONTIGOUS_BYTES_DESC_INVALID(struct ssdfs_contigous_bytes *desc);
+void SSDFS_INIT_CONTIGOUS_BYTES_DESC(struct ssdfs_contigous_bytes *desc,
+				     u32 offset, u32 size);
+u32 SSDFS_AREA_COMPRESSED_OFFSET(struct ssdfs_compressed_area *area);
+u32 SSDFS_AREA_COMPRESSED_SIZE(struct ssdfs_compressed_area *area);
+bool IS_SSDFS_COMPRESSED_AREA_DESC_INVALID(struct ssdfs_compressed_area *desc);
+void SSDFS_INIT_COMPRESSED_AREA_DESC(struct ssdfs_compressed_area *desc,
+				     struct ssdfs_metadata_descriptor *meta_desc);
+u64 SSDFS_COMPRESSED_AREA_UPPER_BOUND(struct ssdfs_compressed_area *desc);
+
+bool IS_SSDFS_COMPRESSED_PORTION_INVALID(struct ssdfs_compressed_portion *desc);
+u32 SSDFS_PORTION_COMPRESSED_OFFSET(struct ssdfs_compressed_portion *portion);
+u32 SSDFS_PORTION_UNCOMPRESSED_OFFSET(struct ssdfs_compressed_portion *portion);
+bool IS_SSDFS_COMPRESSED_PORTION_IN_AREA(struct ssdfs_compressed_portion *desc);
+void SSDFS_INIT_COMPRESSED_PORTION_DESC(struct ssdfs_compressed_portion *desc,
+					struct ssdfs_metadata_descriptor *meta,
+					struct ssdfs_fragments_chain_header *hdr,
+					size_t header_size);
+int SSDFS_ADD_COMPRESSED_PORTION(struct ssdfs_compressed_portion *desc,
+				 struct ssdfs_fragments_chain_header *hdr);
+bool IS_OFFSET_INSIDE_UNCOMPRESSED_PORTION(struct ssdfs_compressed_portion *desc,
+					   u32 offset);
+u64 SSDFS_COMPRESSED_PORTION_UPPER_BOUND(struct ssdfs_compressed_portion *desc);
+u64 SSDFS_UNCOMPRESSED_PORTION_UPPER_BOUND(struct ssdfs_compressed_portion *desc);
+
+bool IS_SSDFS_COMPRESSED_FRAGMENT_INVALID(struct ssdfs_compressed_fragment *desc);
+bool
+IS_SSDFS_COMPRESSED_FRAGMENT_IN_PORTION(struct ssdfs_compressed_fragment *desc);
+int SSDFS_INIT_COMPRESSED_FRAGMENT_DESC(struct ssdfs_compressed_fragment *desc,
+					 struct ssdfs_fragment_desc *frag);
+int SSDFS_ADD_COMPRESSED_FRAGMENT(struct ssdfs_compressed_fragment *desc,
+				  struct ssdfs_fragment_desc *frag);
+u32 SSDFS_FRAGMENT_COMPRESSED_OFFSET(struct ssdfs_compressed_fragment *desc);
+u32 SSDFS_FRAGMENT_UNCOMPRESSED_OFFSET(struct ssdfs_compressed_fragment *desc);
+bool
+IS_OFFSET_INSIDE_UNCOMPRESSED_FRAGMENT(struct ssdfs_compressed_fragment *desc,
+					u32 offset);
+
+bool IS_SSDFS_FRAG_RAW_ITER_INVALID(struct ssdfs_fragment_raw_iterator *iter);
+void SSDFS_FRAG_RAW_ITER_CREATE(struct ssdfs_fragment_raw_iterator *iter);
+void SSDFS_FRAG_RAW_ITER_INIT(struct ssdfs_fragment_raw_iterator *iter,
+			      u32 offset, u32 bytes_count, u32 fragments_count);
+int SSDFS_FRAG_RAW_ITER_ADD_FRAGMENT(struct ssdfs_fragment_raw_iterator *iter,
+				     struct ssdfs_fragment_desc *frag);
+int SSDFS_FRAG_RAW_ITER_SHIFT_OFFSET(struct ssdfs_fragment_raw_iterator *iter,
+				     u32 shift);
+bool IS_SSDFS_FRAG_RAW_ITER_ENDED(struct ssdfs_fragment_raw_iterator *iter);
+
+void SSDFS_LOG_OFFSET_INIT(struct ssdfs_peb_log_offset *log,
+			   u32 block_size,
+			   u32 log_blocks,
+			   pgoff_t start_block);
+bool IS_SSDFS_LOG_OFFSET_VALID(struct ssdfs_peb_log_offset *log);
+u64 SSDFS_ABSOLUTE_LOG_OFFSET(struct ssdfs_peb_log_offset *log);
+u32 SSDFS_LOCAL_LOG_OFFSET(struct ssdfs_peb_log_offset *log);
+int SSDFS_SHIFT_LOG_OFFSET(struct ssdfs_peb_log_offset *log,
+			   u32 shift);
+bool IS_SSDFS_LOG_OFFSET_UNALIGNED(struct ssdfs_peb_log_offset *log);
+void SSDFS_ALIGN_LOG_OFFSET(struct ssdfs_peb_log_offset *log);
+u32 ssdfs_peb_correct_area_write_offset(u32 write_offset, u32 data_size);
+int SSDFS_CORRECT_LOG_OFFSET(struct ssdfs_peb_log_offset *log,
+			     u32 data_size);
+
+size_t ssdfs_peb_temp_buffer_default_size(u32 pagesize);
+int ssdfs_peb_realloc_read_buffer(struct ssdfs_peb_read_buffer *buf,
+				  size_t new_size);
+int ssdfs_peb_realloc_write_buffer(struct ssdfs_peb_temp_buffer *buf);
+
+#endif /* _SSDFS_PEB_INIT_H */
-- 
2.34.1

