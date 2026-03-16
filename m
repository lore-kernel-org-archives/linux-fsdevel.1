Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71E30E0D5
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627585; cv=none; b=VaqJo70OjddEH7WflAbIG2MkIfoJpMP3ikOv4JXCEcVtOY+p3ObvjdEyxdE8uwgvxBwJTx/uTHur4cq6ihKMCxNig0RxTgg8g0Sh6NHYfv0Gx9Tfz/afOBBIuTpNFr5RvD9Vy1D2CCZn77B4suNks+WAjMRo2pm1tSOMtr76WY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627585; c=relaxed/simple;
	bh=XcuteyiBQYHNCbFqVgedx3kzpSX474xQYrxV1wrpz1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U3/E/j9B37QzRsArGO1W1BlhQ49Q4AFQ1lX+5jgaP0b0zcJwo6OqIJjTrqhvJplM3S/DIv9+Bevc8aPpJ2Ooau8XUc8p2CaTOcs4O/fzCFI4jJzRG711Jd0evf1amZMnHUzPOLaEhmf9q9Djn4qmGnEjour4o1iW3krFvfN9nDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=RTU+UhQJ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="RTU+UhQJ"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79901821bb0so40599947b3.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627580; x=1774232380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MiSKWzTbL8tD6msntNhNOk37ZibqeiewRJjUf9p+H3w=;
        b=RTU+UhQJDLqoZ6EkJi5jOAHXWYIM003IT0Dv5qMcU+pg0rqsNUQ2Ens8YaNyENE+w5
         heystoZ5SMrrPCXYtBgOFxFvSXPa7zs91G8Sj/UxhXCAKpdXBsYb1ZfF9z6VB8AApUmv
         2zASFJGqFg+dbonNpMWqqAThZ4nsRcBLrYqKUkPVRW+RFcZ41yrULOWuaPSOpd1HiB6U
         8aD9en6IBgp1wkqcsg9Uu+QzsL/M1WBC5Cry+S51AMhkrsU+LTf94VU5U7JjKN0YRoQC
         i7NDzs5XDhTZDhow9CucYn0o/jDs2UmO75CjHLVx9NQSZNy08aAooYux+Uz+40msYO/7
         49YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627580; x=1774232380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MiSKWzTbL8tD6msntNhNOk37ZibqeiewRJjUf9p+H3w=;
        b=NLb3jdqprxmaSGstlM5gyjMd+H4hhCP0lmPOrzpDLeI+SFaqwdCAUSbkUvrf1VZzpA
         hJto5SuKLdnrkxFaHC5CAEmcYDoY2eArwL7GnKcDbINdqGrxJxtTpWtDne6g8xk4Turz
         7YeDrU5sp18nmkOJCIMHZjlBDwfs27JIvrVYosY9PywUrV51TY5KYUkw9w2EyvW5q/ru
         l15r+CMKHEf6GefJUYzj5jlr+MUlyr8Wcx+wW5yfpFPBOgSA9WFTjSSAUC9cny34BgJh
         fT9xyxM7V+KJDqfJFQkUteJ+hEijqeCqn1EowFCjtQc/epFGBmv+lxU56NDGfxMtNeqk
         6N/Q==
X-Gm-Message-State: AOJu0YwHMQX2FQy+4EXewar/22od4LSt/s9IxGoNj27x0OFSuEWSu4W/
	Kn09QnVgZ9E0VY9cixvEFSbXlaab1rqkuXrtrTJxm1WYNm8BQJs7JpoFlW3xXhHdNIIoI/Mi95d
	eJ4Re
X-Gm-Gg: ATEYQzxmRJDiCRx/xDDgYX+Id6N7jMUnOrBZBC8JRAiPp878i7GTKzdEn7RmIlhEis4
	Gehl6HtcFaKQbxPqyH0ojtnWfDYMnlDsBvE2/qo2ne3YjAYWtJieIFbk+j0T3S58DmQXCrfuKUr
	/rLUv+I7OsAlxfDIHREWflAzKu5TzN3CmgKlaL8sjYmNEigT9/CH/6bw4Q8MsWXzszBtKbpRk8L
	jENLdyFisCVPO6urOlt1NbQqKnhn0KVQCy/XpKNLmGF2UvM0jQc7XZ6QCcjd09tHcAjMg5hnZ8t
	ckX6FpfIrclRI8OA6e8wYQBYkmgUxW56j3yH2UX7FlMYhgg20jyJNFKb7LKGZor2g4loKO0XO/Z
	4JesPSZtWy6Si569cU+Vq8czdsNbRfpli+L54zUaL4/NrZ7KdDIJYSkLsCatm+P2+W7Ox9LkeqG
	K/aAWbwrQwldboPEpUIMFUbAotcvhI1RZpvZ6/WNPB1jIaLakywFGP9lwPW9LY39ZmrmEgr5eZh
	ejzDQsosqTLHV4r6F1Zi9UjoSVer6bIUW0=
X-Received: by 2002:a05:690c:dc4:b0:79a:2ef2:82a with SMTP id 00721157ae682-79a2ef20e30mr72713177b3.20.1773627580438;
        Sun, 15 Mar 2026 19:19:40 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:39 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 27/79] ssdfs: introduce PEB container
Date: Sun, 15 Mar 2026 19:17:40 -0700
Message-ID: <20260316021800.1694650-14-slava@dubeyko.com>
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
clean state. To implement the migration scheme concept, SSDFS
introduces PEB container that includes source and destination
erase blocks. PEB container object keeps the pointers on source
and destination PEB objects during migration logic execution.

"Physical" Erase Block object can be in one of the possible
state (clean, using, used, pre-dirty, dirty). It means that
PEB container creation logic needs to define the state of
particular erase block and detect that it's under migration
or not. As a result, creation logic prepare proper sequence
of initialization requests, add these request into request
queue, and start threads that executes PEB container
initialization.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/peb_container.h | 631 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 631 insertions(+)
 create mode 100644 fs/ssdfs/peb_container.h

diff --git a/fs/ssdfs/peb_container.h b/fs/ssdfs/peb_container.h
new file mode 100644
index 000000000000..9e7bc76cb043
--- /dev/null
+++ b/fs/ssdfs/peb_container.h
@@ -0,0 +1,631 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/peb_container.h - PEB container declarations.
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
+#ifndef _SSDFS_PEB_CONTAINER_H
+#define _SSDFS_PEB_CONTAINER_H
+
+#include "block_bitmap.h"
+#include "peb.h"
+
+/* PEB container's array indexes */
+enum {
+	SSDFS_SEG_PEB1,
+	SSDFS_SEG_PEB2,
+	SSDFS_SEG_PEB_ITEMS_MAX
+};
+
+/* PEB container possible states */
+enum {
+	SSDFS_PEB_CONTAINER_EMPTY,
+	SSDFS_PEB1_SRC_CONTAINER,
+	SSDFS_PEB1_DST_CONTAINER,
+	SSDFS_PEB1_SRC_PEB2_DST_CONTAINER,
+	SSDFS_PEB1_SRC_EXT_PTR_DST_CONTAINER,
+	SSDFS_PEB2_SRC_CONTAINER,
+	SSDFS_PEB2_DST_CONTAINER,
+	SSDFS_PEB2_SRC_PEB1_DST_CONTAINER,
+	SSDFS_PEB2_SRC_EXT_PTR_DST_CONTAINER,
+	SSDFS_PEB_CONTAINER_STATE_MAX
+};
+
+/*
+ * PEB migration state
+ */
+enum {
+	SSDFS_PEB_UNKNOWN_MIGRATION_STATE,
+	SSDFS_PEB_NOT_MIGRATING,
+	SSDFS_PEB_MIGRATION_PREPARATION,
+	SSDFS_PEB_RELATION_PREPARATION,
+	SSDFS_PEB_UNDER_MIGRATION,
+	SSDFS_PEB_FINISHING_MIGRATION,
+	SSDFS_PEB_MIGRATION_STATE_MAX
+};
+
+/*
+ * PEB migration phase
+ */
+enum {
+	SSDFS_PEB_MIGRATION_STATUS_UNKNOWN,
+	SSDFS_SRC_PEB_NOT_EXHAUSTED,
+	SSDFS_DST_PEB_RECEIVES_DATA,
+	SSDFS_SHARED_ZONE_RECEIVES_DATA,
+	SSDFS_PEB_MIGRATION_PHASE_MAX
+};
+
+/*
+ * struct ssdfs_thread_execution_point - execution point in thread logic
+ * @file: file name
+ * @function: function name
+ * @code_line: line number
+ */
+struct ssdfs_thread_execution_point {
+	const char *file;
+	const char *function;
+	u32 code_line;
+};
+
+/*
+ * struct ssdfs_thread_call_stack - thread's call stack
+ * @points: execution points array
+ * @count: current number of execution points in array
+ */
+struct ssdfs_thread_call_stack {
+#define SSDFS_CALL_STACK_CAPACITY	(16)
+	struct ssdfs_thread_execution_point points[SSDFS_CALL_STACK_CAPACITY];
+	u32 count;
+};
+
+/*
+ * struct ssdfs_thread_state - PEB container's thread state
+ * @state: current state of the thread
+ * @req: pointer on segment request
+ * @postponed_req: pointer on postponed segment request
+ * @skip_finish_flush_request: should commit skip the finish request?
+ * @has_extent_been_invalidated: has been extent invalidated?
+ * @has_migration_check_requested: has migration check been requested?
+ * @err: current error
+ */
+struct ssdfs_thread_state {
+#define SSDFS_THREAD_UNKNOWN_STATE	(-1)
+	int state;
+	struct ssdfs_segment_request *req;
+	struct ssdfs_segment_request *postponed_req;
+	bool has_extent_been_invalidated;
+	bool has_migration_check_requested;
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_thread_call_stack call_stack;
+	int unfinished_reqs;
+#endif /* CONFIG_SSDFS_DEBUG */
+};
+
+/*
+ * struct ssdfs_peb_container - PEB container
+ * @peb_type: type of PEB
+ * @peb_index: index of PEB in the array
+ * @log_blocks: count of logical blocks in full log
+ * @peb_state: aggregated PEB container state
+ * @thread_state: threads state
+ * @threads: PEB container's threads array
+ * @read_rq: read requests queue
+ * @update_rq: update requests queue
+ * @crq_ptr_lock: lock of pointer on create requests queue
+ * @create_rq: pointer on shared new page requests queue
+ * @fsck_rq: online FSCK requests queue
+ * @parent_si: pointer on parent segment object
+ * @migration_lock: migration lock
+ * @migration_state: PEB migration state
+ * @migration_phase: PEB migration phase
+ * @items_state: items array state
+ * @shared_free_dst_blks: count of blocks that destination is able to share
+ * @migration_wq: wait queue for migration operations
+ * @cache_protection: PEB cache protection window
+ * @lock: container's internals lock
+ * @src_peb: pointer on source PEB
+ * @dst_peb: pointer on destination PEB
+ * @dst_peb_refs: reference counter of destination PEB (sharing counter)
+ * @items: buffers for PEB objects
+ * @peb_kobj: /sys/fs/ssdfs/<device>/<segN>/<pebN> kernel object
+ * @peb_kobj_unregister: completion state for <pebN> kernel object
+ */
+struct ssdfs_peb_container {
+	/* Static data */
+	u8 peb_type;
+	u16 peb_index;
+	u32 log_blocks;
+
+	atomic_t peb_state;
+
+	/* PEB container's threads */
+	struct ssdfs_thread_state thread_state[SSDFS_PEB_THREAD_TYPE_MAX];
+	struct ssdfs_thread_info thread[SSDFS_PEB_THREAD_TYPE_MAX];
+
+	/* Read requests queue */
+	struct ssdfs_requests_queue read_rq;
+
+	/* Update requests queue */
+	struct ssdfs_requests_queue update_rq;
+
+	spinlock_t pending_lock;
+	u32 pending_updated_user_data_pages;
+
+	/* Shared new page requests queue */
+	spinlock_t crq_ptr_lock;
+	struct ssdfs_requests_queue *create_rq;
+
+	/* Online FSCK requests queue */
+#ifdef CONFIG_SSDFS_ONLINE_FSCK
+	struct ssdfs_requests_queue fsck_rq;
+#endif /* CONFIG_SSDFS_ONLINE_FSCK */
+
+	/* Parent segment */
+	struct ssdfs_segment_info *parent_si;
+
+	/* Migration info */
+	struct mutex migration_lock;
+	atomic_t migration_state;
+	atomic_t migration_phase;
+	atomic_t items_state;
+	atomic_t shared_free_dst_blks;
+	wait_queue_head_t migration_wq;
+
+	/* PEB cache protection window */
+	struct ssdfs_protection_window cache_protection;
+
+	/* PEB objects */
+	struct rw_semaphore lock;
+	struct ssdfs_peb_info *src_peb;
+	struct ssdfs_peb_info *dst_peb;
+	atomic_t dst_peb_refs;
+	struct ssdfs_peb_info items[SSDFS_SEG_PEB_ITEMS_MAX];
+
+	/* /sys/fs/ssdfs/<device>/<segN>/<pebN> */
+	struct kobject peb_kobj;
+	struct completion peb_kobj_unregister;
+
+#ifdef CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING
+	atomic64_t writeback_folios;
+#endif /* CONFIG_SSDFS_MEMORY_LEAKS_ACCOUNTING */
+};
+
+#define PEBI_PTR(pebi) \
+	((struct ssdfs_peb_info *)(pebi))
+#define PEBC_PTR(pebc) \
+	((struct ssdfs_peb_container *)(pebc))
+#define READ_RQ_PTR(pebc) \
+	(&PEBC_PTR(pebc)->read_rq)
+
+#define SSDFS_GC_FINISH_MIGRATION	(4)
+
+/*
+ * Inline functions
+ */
+static inline
+bool is_peb_container_empty(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	return atomic_read(&pebc->items_state) == SSDFS_PEB_CONTAINER_EMPTY;
+}
+
+/*
+ * is_create_requests_queue_empty() - check that create queue has requests
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool is_create_requests_queue_empty(struct ssdfs_peb_container *pebc)
+{
+	bool is_create_rq_empty = true;
+
+	spin_lock(&pebc->crq_ptr_lock);
+	if (pebc->create_rq) {
+		is_create_rq_empty =
+			is_ssdfs_requests_queue_empty(pebc->create_rq);
+	}
+	spin_unlock(&pebc->crq_ptr_lock);
+
+	return is_create_rq_empty;
+}
+
+/*
+ * have_flush_requests() - check that create or update queue have requests
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool have_flush_requests(struct ssdfs_peb_container *pebc)
+{
+	bool is_create_rq_empty = true;
+	bool is_update_rq_empty = true;
+
+	is_create_rq_empty = is_create_requests_queue_empty(pebc);
+	is_update_rq_empty = is_ssdfs_requests_queue_empty(&pebc->update_rq);
+
+	return !is_create_rq_empty || !is_update_rq_empty;
+}
+
+/*
+ * is_fsck_requests_queue_empty() - check that FSCK queue has requests
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool is_fsck_requests_queue_empty(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_ONLINE_FSCK
+	return is_ssdfs_requests_queue_empty(&pebc->fsck_rq);
+#else
+	return true;
+#endif /* CONFIG_SSDFS_ONLINE_FSCK */
+}
+
+static inline
+bool is_ssdfs_peb_containing_user_data(struct ssdfs_peb_container *pebc)
+{
+	return pebc->peb_type == SSDFS_MAPTBL_DATA_PEB_TYPE;
+}
+
+static inline
+void SSDFS_THREAD_CALL_STACK_INIT(struct ssdfs_thread_call_stack *call_stack)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_thread_execution_point *point;
+	int i;
+
+	for (i = 0; i < SSDFS_CALL_STACK_CAPACITY; i++) {
+		point = &call_stack->points[i];
+		point->file = NULL;
+		point->function = NULL;
+		point->code_line = U32_MAX;
+	}
+
+	call_stack->count = 0;
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+static inline
+void SSDFS_THREAD_STATE_INIT(struct ssdfs_thread_state *thread_state)
+{
+	thread_state->state = SSDFS_THREAD_UNKNOWN_STATE;
+	thread_state->req = NULL;
+	thread_state->postponed_req = NULL;
+	thread_state->has_extent_been_invalidated = false;
+	thread_state->has_migration_check_requested = false;
+	thread_state->err = 0;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_THREAD_CALL_STACK_INIT(&thread_state->call_stack);
+	thread_state->unfinished_reqs = 0;
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_peb_container_lock() - lock PEB container
+ * @pebc: pointer on PEB container object
+ */
+static inline
+void ssdfs_peb_container_lock(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	down_read(&pebc->lock);
+	mutex_lock(&pebc->migration_lock);
+}
+
+/*
+ * ssdfs_peb_container_unlock() - unlock PEB container
+ * @pebc: pointer on PEB container object
+ */
+static inline
+void ssdfs_peb_container_unlock(struct ssdfs_peb_container *pebc)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebc);
+	WARN_ON(!mutex_is_locked(&pebc->migration_lock));
+	WARN_ON(!rwsem_is_locked(&pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_unlock(&pebc->migration_lock);
+	up_read(&pebc->lock);
+}
+
+/*
+ * is_ssdfs_peb_container_locked() - is PEB container locked?
+ * @pebc: pointer on PEB container object
+ */
+static inline
+bool is_ssdfs_peb_container_locked(struct ssdfs_peb_container *pebc)
+{
+	return rwsem_is_locked(&pebc->lock) &&
+		mutex_is_locked(&pebc->migration_lock);
+}
+
+/*
+ * ssdfs_peb_current_log_lock() - lock current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_current_log_lock(struct ssdfs_peb_info *pebi)
+{
+	int err;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!rwsem_is_locked(&pebi->pebc->lock));
+	BUG_ON(!mutex_is_locked(&pebi->pebc->migration_lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	err = mutex_lock_killable(&pebi->current_log.lock);
+	WARN_ON(err);
+}
+
+/*
+ * ssdfs_peb_current_log_unlock() - unlock current log object
+ * @pebi: pointer on PEB object
+ */
+static inline
+void ssdfs_peb_current_log_unlock(struct ssdfs_peb_info *pebi)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	BUG_ON(!pebi->pebc);
+	WARN_ON(!mutex_is_locked(&pebi->current_log.lock));
+	WARN_ON(!mutex_is_locked(&pebi->pebc->migration_lock));
+	WARN_ON(!rwsem_is_locked(&pebi->pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	mutex_unlock(&pebi->current_log.lock);
+}
+
+static inline
+bool is_ssdfs_peb_current_log_locked(struct ssdfs_peb_info *pebi)
+{
+	bool is_locked;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	BUG_ON(!pebi);
+	WARN_ON(!mutex_is_locked(&pebi->pebc->migration_lock));
+	WARN_ON(!rwsem_is_locked(&pebi->pebc->lock));
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	is_locked = mutex_is_locked(&pebi->current_log.lock);
+
+	return is_locked;
+}
+
+/*
+ * can_peb_receive_new_blocks() - check that PEB can receive new blocks
+ * @fsi: shared file system information
+ * @pebc: PEB container object
+ * @peb_used_pages: number of used pages in PEB
+ */
+static inline
+bool can_peb_receive_new_blocks(struct ssdfs_fs_info *fsi,
+				struct ssdfs_peb_container *pebc,
+				int peb_used_pages)
+{
+	bool is_peb_under_migration = false;
+	bool is_peb_inflated = false;
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_UNDER_MIGRATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		is_peb_under_migration = true;
+		break;
+
+	default:
+		is_peb_under_migration = false;
+		break;
+	}
+
+	is_peb_inflated = peb_used_pages > fsi->pages_per_peb;
+
+#ifdef CONFIG_SSDFS_DEBUG
+	SSDFS_DBG("is_peb_under_migration %#x, "
+		  "is_peb_inflated %#x\n",
+		  is_peb_under_migration,
+		  is_peb_inflated);
+#endif /* CONFIG_SSDFS_DEBUG */
+
+	if (is_peb_under_migration && is_peb_inflated) {
+		return false;
+	}
+
+	return true;
+}
+
+/*
+ * is_peb_preparing_migration() - check that PEB preparing migration
+ * @pebc: pointer on PEB container
+ */
+static inline
+bool is_peb_preparing_migration(struct ssdfs_peb_container *pebc)
+{
+	bool is_preparing = false;
+
+	switch (atomic_read(&pebc->migration_state)) {
+	case SSDFS_PEB_MIGRATION_PREPARATION:
+	case SSDFS_PEB_RELATION_PREPARATION:
+	case SSDFS_PEB_FINISHING_MIGRATION:
+		is_preparing = true;
+		break;
+
+	default:
+		/* do nothing */
+		break;
+	}
+
+	return is_preparing;
+}
+
+/*
+ * ssdfs_thread_call_stack_remember() - remember execution point
+ * @stack: thread's call stack
+ * @file: file name pointer
+ * @function: function name pointer
+ * @code_line: code line in file
+ */
+static inline
+void ssdfs_thread_call_stack_remember(struct ssdfs_thread_call_stack *stack,
+					const char *file,
+					const char *function,
+					u32 code_line)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_thread_execution_point *point;
+
+	if (stack->count < SSDFS_CALL_STACK_CAPACITY) {
+		if (stack->count > 0) {
+			point = &stack->points[stack->count - 1];
+
+			if (point->function && function) {
+				if (strcmp(point->function, function) == 0)
+					point->code_line = code_line;
+				else
+					goto process_new_execution_point;
+			} else
+				goto process_new_execution_point;
+		} else {
+process_new_execution_point:
+			point = &stack->points[stack->count];
+			point->file = file;
+			point->function = function;
+			point->code_line = code_line;
+			stack->count++;
+		}
+	} else
+		stack->count++;
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * ssdfs_thread_call_stack_forget() - forget execution point
+ * @stack: thread's call stack
+ */
+static inline
+void ssdfs_thread_call_stack_forget(struct ssdfs_thread_call_stack *stack)
+{
+#ifdef CONFIG_SSDFS_DEBUG
+	struct ssdfs_thread_execution_point *point;
+
+	stack->count--;
+
+	if (stack->count < SSDFS_CALL_STACK_CAPACITY) {
+		point = &stack->points[stack->count];
+
+		point->file = NULL;
+		point->function = NULL;
+		point->code_line = U32_MAX;
+	}
+#endif /* CONFIG_SSDFS_DEBUG */
+}
+
+/*
+ * PEB container's API
+ */
+int ssdfs_peb_container_create(struct ssdfs_fs_info *fsi,
+				u64 seg, u32 peb_index,
+				u8 peb_type,
+				u32 log_pages,
+				struct ssdfs_segment_info *si);
+void ssdfs_peb_container_destroy(struct ssdfs_peb_container *pebc);
+
+int ssdfs_peb_container_invalidate_block(struct ssdfs_peb_container *pebc,
+				    struct ssdfs_phys_offset_descriptor *desc);
+int ssdfs_peb_get_free_pages(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_get_used_data_pages(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_get_invalid_pages(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_get_pages_capacity(struct ssdfs_peb_container *pebc);
+
+int ssdfs_peb_join_create_requests_queue(struct ssdfs_peb_container *pebc,
+					 struct ssdfs_requests_queue *create_rq);
+void ssdfs_peb_forget_create_requests_queue(struct ssdfs_peb_container *pebc);
+bool is_peb_joined_into_create_requests_queue(struct ssdfs_peb_container *pebc);
+
+struct ssdfs_peb_info *
+ssdfs_get_current_peb_locked(struct ssdfs_peb_container *pebc);
+void ssdfs_unlock_current_peb(struct ssdfs_peb_container *pebc);
+struct ssdfs_peb_info *
+ssdfs_get_peb_for_migration_id(struct ssdfs_peb_container *pebc,
+			       u8 migration_id);
+
+int ssdfs_peb_container_create_destination(struct ssdfs_peb_container *ptr);
+int ssdfs_peb_container_forget_source(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_container_forget_relation(struct ssdfs_peb_container *pebc);
+int ssdfs_peb_container_change_state(struct ssdfs_peb_container *pebc);
+
+/*
+ * PEB container's private API
+ */
+int ssdfs_peb_gc_thread_func(void *data);
+int ssdfs_peb_read_thread_func(void *data);
+int ssdfs_peb_flush_thread_func(void *data);
+int ssdfs_peb_fsck_thread_func(void *data);
+
+u16 ssdfs_peb_estimate_reserved_metapages(u32 page_size, u32 pages_per_peb,
+					  u16 log_pages, u32 pebs_per_seg,
+					  bool is_migrating);
+int ssdfs_peb_read_page(struct ssdfs_peb_container *pebc,
+			struct ssdfs_segment_request *req,
+			struct completion **end);
+int ssdfs_peb_readahead_pages(struct ssdfs_peb_container *pebc,
+			      struct ssdfs_segment_request *req,
+			      struct completion **end);
+void ssdfs_peb_mark_request_block_uptodate(struct ssdfs_peb_container *pebc,
+					   struct ssdfs_segment_request *req,
+					   int blk_index);
+int ssdfs_peb_copy_block(struct ssdfs_peb_container *pebc,
+			 u32 logical_blk,
+			 struct ssdfs_segment_request *req);
+int ssdfs_peb_copy_blocks_range(struct ssdfs_peb_container *pebc,
+				struct ssdfs_block_bmap_range *range,
+				struct ssdfs_segment_request *req);
+int ssdfs_peb_copy_pre_alloc_block(struct ssdfs_peb_container *pebc,
+				   u32 logical_blk,
+				   struct ssdfs_segment_request *req);
+int __ssdfs_peb_get_block_state_desc(struct ssdfs_peb_info *pebi,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_metadata_descriptor *area_desc,
+				struct ssdfs_block_state_descriptor *desc,
+				u64 *cno, u64 *parent_snapshot);
+int ssdfs_blk_desc_buffer_init(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size);
+int ssdfs_peb_read_block_state(struct ssdfs_peb_container *pebc,
+				struct ssdfs_segment_request *req,
+				struct ssdfs_phys_offset_descriptor *desc_off,
+				struct ssdfs_offset_position *pos,
+				struct ssdfs_metadata_descriptor *array,
+				size_t array_size);
+bool ssdfs_peb_has_dirty_folios(struct ssdfs_peb_info *pebi);
+int ssdfs_collect_dirty_segments_now(struct ssdfs_fs_info *fsi);
+bool can_peb_process_create_requests(struct ssdfs_peb_container *pebc);
+
+#endif /* _SSDFS_PEB_CONTAINER_H */
-- 
2.34.1

