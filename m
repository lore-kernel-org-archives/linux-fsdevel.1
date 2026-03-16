Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E02329C54
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627606; cv=none; b=pmGxu2rAqC+iWr9l3PZlbCkdlCvzt0eymPazlGuovmlE+aqomPsqdHSPMpqld9mx/+2K5pByJDg8PQBaFO1NjCjqfb8/VPZN36LC+zJM/MRZ5wjjgiKT2CtK1ycWCFUfKue90bzc/o2PdJYW/VAlqfvyqfuSeikeKqSyP9qMPv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627606; c=relaxed/simple;
	bh=l6RVu1J/LgWchNCRIkpVwF/e31usLqHR+4ZS8YJ+du4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dPpw7pDrgZPROrlJ+5Nyl30kRVHb0vX7p6jCOTLOBU227UcXLlFXw2c46eWbEV+Hv+35qH6HO5pWGjNKZGoTznKHWA4A7nXOE655mDwZ0zaOALEmGCPdfFQIaMU3fx2oH2sp96bGrTKVNVrWWjuOIixInwbp8xA8bnUdEs/fSaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=zetPvlIR; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="zetPvlIR"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-64ca9ec3ee7so4710117d50.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627600; x=1774232400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oU/vunUD8C1GCAWOIMWDJATzfNBPreooaS+0PlEiXhw=;
        b=zetPvlIR2HqHTdMhjMG0c+OXA4/AE3tTjeD/OIW8rDQ3aJni2fXKtCMUx/uAqFhcFg
         RbI58b2y7OJTAe7nmMnFA/zCJc54r9Z+hPDyGi/A4kep43G1gMOb5pmwrn03wUZ6jBt5
         h+GaD5IYr6NZsXY3rqh4DuLasBas5lmr8wT3G3nx6sT/nVIIx6WjFiG6km3kKTLnVti2
         TMO+DM5hUprtB4/KpcQVtIp3/6qflnucIMCec2iWhPCmutj1TGI6PB4tNi2btZ2DMs9m
         n/v9G/Y00Brv+eMvSh92ynedUAIr5ujiR14OkUANkV5Alba46pJuXSNckx0sx+WXfFHE
         M3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627600; x=1774232400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oU/vunUD8C1GCAWOIMWDJATzfNBPreooaS+0PlEiXhw=;
        b=NAjmHYfJiwhuNPr0MZmX2PpnpHsZe8kaVhVULxgPhye+gkTiwD9JJZpiAkl6YszKjh
         adP7GiGi89fcGFOhYeRa+6NhQ4dbSUDSOMBly+ui3rnwTx1AiiXRNwlSUCvduXATF8c9
         GGasJe1zNIv5M8uffzw83k1V1KMyD36frmXuyP4Xd96+tN937M4dtS5CISC18pi7joxm
         cHDHN5ShNa3fAQc/Dh5Mf/2dKTKQyYL0ljGh4cLyCTo9sc4zli9gO9reqhVCaK+iFh20
         e4B0sQS3+ltnTwfhW0bL/TShYZ5zb+qLLfqLWlr5imDLeODcKt/o9k23vYKVSrq+qqwZ
         XAYQ==
X-Gm-Message-State: AOJu0Yw2+pBKPY+fxw4lo8EEWfrCYKfYVG2K5VuEjtSKBH23ubRXSt0x
	xODAGmJuSKmF60+WtDlaWGk14ZJH2NLVZ9Z60W3mixjthsyEhzhVeDVRl35IWualJ7Qk3ELj3Uu
	vAByq
X-Gm-Gg: ATEYQzxw8SU2vEYm9PY8YyVmgBPxv5hX9R0BT1FgIaxslv/3Jq3MjBdY85zH3Qu0/Vu
	Xb3nh8/RPFb8SduSRjjEwsSJylYoWYMxWxg7fuVDBpJ2wfyggSCXAwTaoRFK0zV9sF2+ouNgn4b
	kDLekuR8fkjb6bahLxhzULgFSr337NzM4Lo6cGGYgSEoQ7wsPI9ThxHiwaRApN44720QsQnCVlG
	89EOqHn1tUgM0q0LyTPfNOq4NdA89NR6Ik3qcL5UTO1G7ThanX5s/CJy3aIzXQVsUTeZOkfIOC9
	XyrQADd3Yo48Kf9EXxFJo0WI9jPkA56y2ssCnFyF2yTpAzjfFh1TEN5ryjV1rjJ4GcOgh8NF7WT
	yZG2qqN5Ii9Eb5bZRwkvEDP25ixWmnlQ99gJmgQbVF3Dazb4cDxfSdQsbT9xF0lbsdLskymYJXf
	uzZzRyEBe3D5CKjZGnD2HOGQ1rONW5wdJAdX4SaBF8qCm7JOIMIOwSYM/090vTBwwc9LlD1UqIT
	Bz3Gnjb3Hg2E6GXXI/HxKlB
X-Received: by 2002:a05:690c:9691:b0:798:6f20:1c9f with SMTP id 00721157ae682-79a1c089e4emr122783027b3.10.1773627600139;
        Sun, 15 Mar 2026 19:20:00 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:59 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 65/79] ssdfs: introduce snapshots b-tree
Date: Sun, 15 Mar 2026 19:17:55 -0700
Message-ID: <20260316021800.1694650-29-slava@dubeyko.com>
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

SSDFS file system driver stores any payload in the form
of logs. Every log starts by header, continues by payload,
and could be ended by footer. The every header and
footer includes the timestamp of the log's creation.
It means that every log can be imagined like a checkpoint
of file system volume's evolution. By default, if no snapshot
has been created, SSDFS file system logic executes an erase
operation of an erase block upon its complete invalidation
(all valid data has been moved into another erase block).
However, it is possible to create a snapshot(s) with the goal
of protecting the previous state of user data or metadata
in invalidated erase blocks. Snapshot is simple timestamp
that needs to be stored into snapshots b-tree. In the case
of presence of snapshots in the b-tree, SSDFS logic compares
the starting and ending timestamps/checkponts of particular
erase block with snapshot timestamps in the b-tree. If any
timestamp/checkpoint of particular erase block is protected
by snapshot, then this invalidated erase block is excluded
from erase operation with the goal to keep the snapshoted
state of the user data or metadata.

SSDFS provides the opportunity to create a snapshot rule(s).
It means that it is possible to define a frequency of
snapshots creation (for example, every minute, hour, day, etc).
Also, it is possible to define how soon the snapshot could
expire (for example, after hour, day, week, month). Finally,
it means that SSDFS logic is capable to create snapshots and
delete the expired ones on automated basis.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/snapshot.h       | 283 ++++++++++++++++++++++++++++++++++++++
 fs/ssdfs/snapshot_rules.h |  55 ++++++++
 fs/ssdfs/snapshots_tree.h | 248 +++++++++++++++++++++++++++++++++
 3 files changed, 586 insertions(+)
 create mode 100644 fs/ssdfs/snapshot.h
 create mode 100644 fs/ssdfs/snapshot_rules.h
 create mode 100644 fs/ssdfs/snapshots_tree.h

diff --git a/fs/ssdfs/snapshot.h b/fs/ssdfs/snapshot.h
new file mode 100644
index 000000000000..b10d73b98e6e
--- /dev/null
+++ b/fs/ssdfs/snapshot.h
@@ -0,0 +1,283 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/snapshot.h - snapshot's declarations.
+ *
+ * Copyright (c) 2021-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_SNAPSHOT_H
+#define _SSDFS_SNAPSHOT_H
+
+/*
+ * struct ssdfs_time_range - time range definition
+ * @minute: minute of the time range
+ * @hour: hour of the time range
+ * @day: day of the time range
+ * @month: month of the time range
+ * @year: year of the time range
+ */
+struct ssdfs_time_range {
+	u32 minute;
+	u32 hour;
+	u32 day;
+	u32 month;
+	u32 year;
+};
+
+#define SSDFS_ANY_MINUTE			U32_MAX
+#define SSDFS_ANY_HOUR				U32_MAX
+#define SSDFS_ANY_DAY				U32_MAX
+#define SSDFS_ANY_MONTH				U32_MAX
+#define SSDFS_ANY_YEAR				U32_MAX
+
+/*
+ * struct ssdfs_snapshot_details - snapshot details
+ * @create_time: snapshot's timestamp
+ * @cno: snapshot's checkpoint
+ * @mode: snapshot mode (READ-ONLY|READ-WRITE)
+ * @expiration: snapshot expiration time (WEEK|MONTH|YEAR|NEVER)
+ * @ino: target/root object's inode ID
+ * @uuid: snapshot's UUID
+ */
+struct ssdfs_snapshot_details {
+	u64 create_time;
+	u64 cno;
+	u32 mode;
+	u32 expiration;
+	u64 ino;
+	u8 uuid[SSDFS_UUID_SIZE];
+};
+
+/*
+ * struct ssdfs_snapshot_rule_details - snapshot rule details
+ * @mode: snapshot mode (READ-ONLY|READ-WRITE)
+ * @type: snapshot type (PERIODIC|ONE-TIME)
+ * @expiration: snapshot expiration time (WEEK|MONTH|YEAR|NEVER)
+ * @frequency: taking snapshot frequency (FSYNC|HOUR|DAY|WEEK)
+ * @snapshots_threshold: max number of simultaneously available snapshots
+ * @snapshots_number: currently created number of snapshots
+ * @last_snapshot_cno: checkpoint of last snapshot
+ * @ino: target/root object's inode ID
+ * @uuid: snapshot's UUID
+ */
+struct ssdfs_snapshot_rule_details {
+	u32 mode;
+	u32 type;
+	u32 expiration;
+	u32 frequency;
+	u32 snapshots_threshold;
+	u32 snapshots_number;
+	u64 last_snapshot_cno;
+	u64 ino;
+	u8 uuid[SSDFS_UUID_SIZE];
+};
+
+/*
+ * struct ssdfs_snapshot_info - snapshot details
+ * @name: snapshot name
+ * @uuid: snapshot UUID
+ * @mode: snapshot mode (READ-ONLY|READ-WRITE)
+ * @type: snapshot type (PERIODIC|ONE-TIME)
+ * @expiration: snapshot expiration time (WEEK|MONTH|YEAR|NEVER)
+ * @frequency: taking snapshot frequency (FSYNC|HOUR|DAY|WEEK)
+ * @snapshots_threshold: max number of simultaneously available snapshots
+ * @time_range: time range to select/modify/delete snapshots
+ * @buf: buffer to share the snapshot details
+ * @buf_size: size of buffer in bytes
+ */
+struct ssdfs_snapshot_info {
+	char name[SSDFS_MAX_NAME_LEN];
+	u8 uuid[SSDFS_UUID_SIZE];
+
+	int mode;
+	int type;
+	int expiration;
+	int frequency;
+	u32 snapshots_threshold;
+	struct ssdfs_time_range time_range;
+
+	char __user *buf;
+	u64 buf_size;
+};
+
+/* Requested operation */
+enum {
+	SSDFS_UNKNOWN_OPERATION,
+	SSDFS_CREATE_SNAPSHOT,
+	SSDFS_LIST_SNAPSHOTS,
+	SSDFS_MODIFY_SNAPSHOT,
+	SSDFS_REMOVE_SNAPSHOT,
+	SSDFS_REMOVE_RANGE,
+	SSDFS_SHOW_SNAPSHOT_DETAILS,
+	SSDFS_LIST_SNAPSHOT_RULES,
+	SSDFS_OPERATION_TYPE_MAX
+};
+
+/*
+ * struct ssdfs_snapshot_request - snapshot request
+ * @list: snapshot requests queue list
+ * @operation: requested operation
+ * @ino: inode ID of object under snapshot
+ * @info: snapshot request's info
+ */
+struct ssdfs_snapshot_request {
+	struct list_head list;
+	int operation;
+	u64 ino;
+	struct ssdfs_snapshot_info info;
+};
+
+/*
+ * struct ssdfs_snapshot_rule_item - snapshot rule item
+ * @list: snapshot rules list
+ * @rule: snapshot rule's info
+ */
+struct ssdfs_snapshot_rule_item {
+	struct list_head list;
+	struct ssdfs_snapshot_rule_info rule;
+};
+
+/*
+ * struct ssdfs_timestamp_range - range of timestamps
+ * @start: starting timestamp
+ * @end: ending timestamp
+ */
+struct ssdfs_timestamp_range {
+	u64 start;
+	u64 end;
+};
+
+/*
+ * struct ssdfs_snapshot_id - snapshot ID
+ * @timestamp: snapshot timestamp
+ * @uuid: snapshot UUID (could be NULL)
+ * @name: snapshot name (could be NULL)
+ */
+struct ssdfs_snapshot_id {
+	u64 timestamp;
+	u8 *uuid;
+	char *name;
+};
+
+#define SSDFS_UNKNOWN_TIMESTAMP		(0)
+
+#define SSDFS_SNAP_DETAILS(ptr) \
+	((struct ssdfs_snapshot_details *)(ptr))
+#define SSDFS_SNAP_RULE_DETAILS(ptr) \
+	((struct ssdfs_snapshot_rule_details *)(ptr))
+
+struct ssdfs_snapshot_subsystem;
+struct ssdfs_fs_info;
+
+/*
+ * Inline functions
+ */
+
+static inline
+bool is_snapshot_rule_requested(struct ssdfs_snapshot_request *snr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!snr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return snr->info.type == SSDFS_PERIODIC_SNAPSHOT;
+}
+
+static inline
+bool is_ssdfs_snapshot_mode_correct(int mode)
+{
+	switch (mode) {
+	case SSDFS_READ_ONLY_SNAPSHOT:
+	case SSDFS_READ_WRITE_SNAPSHOT:
+		return true;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return false;
+}
+
+static inline
+bool is_ssdfs_snapshot_type_correct(int type)
+{
+	switch (type) {
+	case SSDFS_ONE_TIME_SNAPSHOT:
+	case SSDFS_PERIODIC_SNAPSHOT:
+		return true;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return false;
+}
+
+static inline
+bool is_ssdfs_snapshot_expiration_correct(int expiration)
+{
+	switch (expiration) {
+	case SSDFS_EXPIRATION_IN_WEEK:
+	case SSDFS_EXPIRATION_IN_MONTH:
+	case SSDFS_EXPIRATION_IN_YEAR:
+	case SSDFS_NEVER_EXPIRED:
+		return true;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return false;
+}
+
+static inline
+bool is_ssdfs_snapshot_frequency_correct(int frequency)
+{
+	switch (frequency) {
+	case SSDFS_SYNCFS_FREQUENCY:
+	case SSDFS_HOUR_FREQUENCY:
+	case SSDFS_DAY_FREQUENCY:
+	case SSDFS_WEEK_FREQUENCY:
+	case SSDFS_MONTH_FREQUENCY:
+		return true;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return false;
+}
+
+/*
+ * is_uuids_identical() - check the UUIDs identity
+ * @uuid1: first UUID instance
+ * @uuid2: second UUID instance
+ */
+static inline
+bool is_uuids_identical(const u8 *uuid1, const u8 *uuid2)
+{
+	return memcmp(uuid1, uuid2, SSDFS_UUID_SIZE) == 0;
+}
+
+/*
+ * Snapshots subsystem's API
+ */
+int ssdfs_snapshot_subsystem_init(struct ssdfs_fs_info *fsi);
+int ssdfs_snapshot_subsystem_destroy(struct ssdfs_fs_info *fsi);
+
+int ssdfs_convert_time2timestamp_range(struct ssdfs_fs_info *fsi,
+					struct ssdfs_time_range *range1,
+					struct ssdfs_timestamp_range *range2);
+
+#endif /* _SSDFS_SNAPSHOT_H */
diff --git a/fs/ssdfs/snapshot_rules.h b/fs/ssdfs/snapshot_rules.h
new file mode 100644
index 000000000000..0ce0c214ec96
--- /dev/null
+++ b/fs/ssdfs/snapshot_rules.h
@@ -0,0 +1,55 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/snapshot_rules.h - snapshot rule declarations.
+ *
+ * Copyright (c) 2021-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_SNAPSHOT_RULES_H
+#define _SSDFS_SNAPSHOT_RULES_H
+
+/*
+ * struct ssdfs_snapshot_rules_list - snapshot rules list descriptor
+ * @lock: snapshot rules list's lock
+ * @list: snapshot rules list
+ */
+struct ssdfs_snapshot_rules_list {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * Snapshot rules list API
+ */
+void ssdfs_snapshot_rules_list_init(struct ssdfs_snapshot_rules_list *rl);
+bool is_ssdfs_snapshot_rules_list_empty(struct ssdfs_snapshot_rules_list *rl);
+void ssdfs_snapshot_rules_list_add_tail(struct ssdfs_snapshot_rules_list *rl,
+					struct ssdfs_snapshot_rule_item *ri);
+void ssdfs_snapshot_rules_list_add_head(struct ssdfs_snapshot_rules_list *rl,
+					struct ssdfs_snapshot_rule_item *ri);
+void ssdfs_snapshot_rules_list_remove_all(struct ssdfs_snapshot_rules_list *rl);
+
+/*
+ * Snapshot rule's API
+ */
+struct ssdfs_snapshot_rule_item *ssdfs_snapshot_rule_alloc(void);
+void ssdfs_snapshot_rule_free(struct ssdfs_snapshot_rule_item *ri);
+
+struct folio *ssdfs_snapshot_rules_add_batch_folio(struct folio_batch *batch,
+						   unsigned int order);
+void ssdfs_snapshot_rules_folio_batch_release(struct folio_batch *batch);
+
+int ssdfs_process_snapshot_rules(struct ssdfs_fs_info *fsi);
+int ssdfs_modify_snapshot_rule(struct ssdfs_fs_info *fsi,
+				struct ssdfs_snapshot_request *snr);
+int ssdfs_remove_snapshot_rule(struct ssdfs_snapshot_subsystem *snapshots,
+				struct ssdfs_snapshot_request *snr);
+
+#endif /* _SSDFS_SNAPSHOT_RULES_H */
diff --git a/fs/ssdfs/snapshots_tree.h b/fs/ssdfs/snapshots_tree.h
new file mode 100644
index 000000000000..f3ce051f0eb9
--- /dev/null
+++ b/fs/ssdfs/snapshots_tree.h
@@ -0,0 +1,248 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/snapshots_tree.h - snapshots btree declarations.
+ *
+ * Copyright (c) 2021-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ */
+
+#ifndef _SSDFS_SNAPSHOTS_TREE_H
+#define _SSDFS_SNAPSHOTS_TREE_H
+
+/*
+ * struct ssdfs_snapshots_btree_queue - snapshot requests queue
+ * @queue: snapshot requests queue object
+ * @thread: descriptor of queue's thread
+ */
+struct ssdfs_snapshots_btree_queue {
+	struct ssdfs_snapshot_reqs_queue queue;
+	struct ssdfs_thread_info thread;
+};
+
+/*
+ * struct ssdfs_snapshots_btree_info - snapshots btree info
+ * @state: snapshots btree state
+ * @lock: snapshots btree lock
+ * @generic_tree: generic btree description
+ * @snapshots_count: count of the snapshots in the whole tree
+ * @deleted_snapshots: current number of snapshot delete operations
+ * @requests: snapshot requests queue
+ * @wait_queue: wait queue of snapshots tree's thread
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_snapshots_btree_info {
+	atomic_t state;
+	struct rw_semaphore lock;
+	struct ssdfs_btree generic_tree;
+
+	atomic64_t snapshots_count;
+	atomic64_t deleted_snapshots;
+
+	struct ssdfs_snapshots_btree_queue requests;
+	wait_queue_head_t wait_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Snapshots tree states */
+enum {
+	SSDFS_SNAPSHOTS_BTREE_UNKNOWN_STATE,
+	SSDFS_SNAPSHOTS_BTREE_CREATED,
+	SSDFS_SNAPSHOTS_BTREE_INITIALIZED,
+	SSDFS_SNAPSHOTS_BTREE_DIRTY,
+	SSDFS_SNAPSHOTS_BTREE_CORRUPTED,
+	SSDFS_SNAPSHOTS_BTREE_STATE_MAX
+};
+
+/*
+ * Inline functions
+ */
+
+static inline
+int check_minute(int minute)
+{
+	if (minute < 0 || minute > 60) {
+		SSDFS_ERR("invalid minute value %d\n",
+			  minute);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+int check_hour(int hour)
+{
+	if (hour < 0 || hour > 24) {
+		SSDFS_ERR("invalid hour value %d\n",
+			  hour);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+int check_day(int day)
+{
+	if (day <= 0 || day > 31) {
+		SSDFS_ERR("invalid day value %d\n",
+			  day);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+int check_month(int month)
+{
+	if (month <= 0 || month > 12) {
+		SSDFS_ERR("invalid month value %d\n",
+			  month);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+int check_year(int year)
+{
+	if (year < 1970) {
+		SSDFS_ERR("invalid year value %d\n",
+			  year);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline
+void SHOW_SNAPSHOT_INFO(struct ssdfs_snapshot_request *snr)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("SNAPSHOT INFO: ");
+	SSDFS_DBG("name %s, ", snr->info.name);
+	SSDFS_DBG("UUID %pUb, ", snr->info.uuid);
+	SSDFS_DBG("mode %#x, type %#x, expiration %#x, "
+		  "frequency %#x, snapshots_threshold %u, "
+		  "TIME_RANGE (day %u, month %u, year %u)\n",
+		  snr->info.mode, snr->info.type, snr->info.expiration,
+		  snr->info.frequency, snr->info.snapshots_threshold,
+		  snr->info.time_range.day,
+		  snr->info.time_range.month,
+		  snr->info.time_range.year);
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+bool is_item_snapshot(void *kaddr)
+{
+	struct ssdfs_snapshot *snapshot;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	snapshot = (struct ssdfs_snapshot *)kaddr;
+
+	return le16_to_cpu(snapshot->magic) == SSDFS_SNAPSHOT_RECORD_MAGIC;
+}
+
+static inline
+bool is_item_peb2time_record(void *kaddr)
+{
+	struct ssdfs_peb2time_set *peb2time;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!kaddr);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	peb2time = (struct ssdfs_peb2time_set *)kaddr;
+
+	return le16_to_cpu(peb2time->magic) == SSDFS_PEB2TIME_RECORD_MAGIC;
+}
+
+static inline
+bool is_peb2time_record_requested(struct ssdfs_btree_search *search)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!search);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return search->request.flags & SSDFS_BTREE_SEARCH_HAS_PEB2TIME_PAIR;
+}
+
+/*
+ * Snapshots tree API
+ */
+int ssdfs_snapshots_btree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_snapshots_btree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_snapshots_btree_flush(struct ssdfs_fs_info *fsi);
+
+int ssdfs_snapshots_btree_find(struct ssdfs_snapshots_btree_info *tree,
+				struct ssdfs_snapshot_id *id,
+				struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_find_range(struct ssdfs_snapshots_btree_info *tree,
+				     struct ssdfs_timestamp_range *range,
+				     struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_check_range(struct ssdfs_snapshots_btree_info *tree,
+				      struct ssdfs_timestamp_range *range,
+				      struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_add(struct ssdfs_snapshots_btree_info *tree,
+			     struct ssdfs_snapshot_request *snr,
+			     struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_add_peb2time(struct ssdfs_snapshots_btree_info *tree,
+					struct ssdfs_peb_timestamps *peb2time,
+					struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_change(struct ssdfs_snapshots_btree_info *tree,
+				 struct ssdfs_snapshot_request *snr,
+				 struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_delete(struct ssdfs_snapshots_btree_info *tree,
+				 struct ssdfs_snapshot_request *snr,
+				 struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_delete_peb2time(struct ssdfs_snapshots_btree_info *,
+					  struct ssdfs_peb_timestamps *peb2time,
+					  struct ssdfs_btree_search *search);
+int ssdfs_snapshots_btree_delete_all(struct ssdfs_snapshots_btree_info *tree);
+
+/*
+ * Internal snapshots tree API
+ */
+int ssdfs_start_snapshots_btree_thread(struct ssdfs_fs_info *fsi);
+int ssdfs_stop_snapshots_btree_thread(struct ssdfs_fs_info *fsi);
+int ssdfs_snapshots_tree_find_leaf_node(struct ssdfs_snapshots_btree_info *tree,
+					struct ssdfs_timestamp_range *range,
+					struct ssdfs_btree_search *search);
+int ssdfs_snapshots_tree_get_start_hash(struct ssdfs_snapshots_btree_info *tree,
+					u64 *start_hash);
+int ssdfs_snapshots_tree_node_hash_range(struct ssdfs_snapshots_btree_info *tree,
+					 struct ssdfs_btree_search *search,
+					 u64 *start_hash, u64 *end_hash,
+					 u16 *items_count);
+int ssdfs_snapshots_tree_extract_range(struct ssdfs_snapshots_btree_info *tree,
+				       u16 start_index, u16 count,
+				       struct ssdfs_btree_search *search);
+int ssdfs_snapshots_tree_check_search_result(struct ssdfs_btree_search *search);
+int ssdfs_snapshots_tree_get_next_hash(struct ssdfs_snapshots_btree_info *tree,
+					struct ssdfs_btree_search *search,
+					u64 *next_hash);
+
+void ssdfs_debug_snapshots_btree_object(struct ssdfs_snapshots_btree_info *tree);
+
+/*
+ * Snapshots btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_snapshots_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_snapshots_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_snapshots_btree_node_ops;
+
+#endif /* _SSDFS_SNAPSHOTS_TREE_H */
-- 
2.34.1

