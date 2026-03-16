Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D81327C1D
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627604; cv=none; b=b2R/qEKNf8U8Ldifs3uCnglmR0V8Q7f2z1q//9FF9n/UTXxvqFi60wgWuFTFEcD3JIOOnw7E/zrBYOPQq/+3Fu+5gjGOuFi5f7a0r1ZD4X6u63F6+vHMYNF8XIhISkPNK1/7FACdJMfaGrImb+g+sIuhMJKKJyqc4kMfvKVs1S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627604; c=relaxed/simple;
	bh=LEzT7nIeosuzdQtjKm6vfwKkZy4PUe6297df6lEaOrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oajLkktEcU4DTKx0V8juP8FCx3+WRTEhvNRqbLMA88m6NszkTi3/GuvuL2Jj8FLB4yG1mIFdX88UYRNPMza1b07lIQaFRbE9fiu70+5O6qrXyRP0JxtrPtVzOIEHbZCFgqRGZV+yby1pN+2RHJKiQMOr9Ei4SZe3Z3LK3RrpOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=YxNJhz1U; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="YxNJhz1U"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-79853c0f5b9so30141787b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627599; x=1774232399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjFFscnCBServfoAAsYVc/EFu1HcCw4rQVzZigepem8=;
        b=YxNJhz1ULucHLh30LvpmWuT5nrZvmK3D0qFN6sfD6enber4vYoSC/kKKgaFUdjeHPd
         ZvcIq1X4SKNhxZTh9qoGfm8qoASH+8+Ba08maDrqA0/HwcpGPvDg1tb5krScYZ4dcjiN
         er6twpnDlYEUrvlb3gsrpYgZBIz6hIvDUWh5/qtCvKEdqi9gbC/DqDZgGXrDFNMbXZlS
         FyR1Dk9/w4v7sH6i5CdEniqbKzUqywRvp2lvHZP6H9b1Ke9saZdRF3hmeSzBnorPbw6f
         wX6Cp4J4TNZW7ryfi4CvUS7+Kwzs0bmoBHY3/deyFbQKUe/Y2luJByzSnY+HLA//GF9Q
         rbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627599; x=1774232399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjFFscnCBServfoAAsYVc/EFu1HcCw4rQVzZigepem8=;
        b=ATaW1cnR1fKLzl/QaQd1EqK5AnsohPE8+bcbwOn/JUE4v7oFIZzhz3YHIKJgGvXxij
         bcE2q4/JJIe/3pKSRo1JgX4ppWwHdBHcuGdAbS7NKeqhyd7Rr76u4DdFA/1iyqBN33/E
         mD2ZYkpp9y4YIubbyukqGRcLnUh+NoOE/UUMsgJ7WA92GQZKx0mxYLH1kB0zmm/EkruN
         AzrZlFEtdb8f0YTl/GH5Pc/1j+8kSCFfH15JytW9V0ZMJLX+iZsAZ1Z7mmkqhMLMX2Wq
         xE/JVwbVK6TOrTBmwbVBJCms05izNHbl9LDoSkpYIgw0UaM9YohMnHTQBO6EWFXoytM7
         3lHw==
X-Gm-Message-State: AOJu0YwKHHVzmkB4O74E0HfXPDuRLlUp+typciiK8ug3G7xsOxXQEP8Z
	J5OueR4AbvJW0zxQID7VTEWm2JAFdtUVP0yBGEUKAbt7H3xnDiFCuTdErWIdgm7c5gH5rwIxd95
	Rw/j3
X-Gm-Gg: ATEYQzw/9BbFkTonjKEIeY6FLAOqPFuawXzw2iLc7TZjhWHBPvZMoRiDY7fluSwju/7
	xKBiHkPNPphKX5Ds+z+VDP5I9POgEHK8azKGkxyceS/Eavc8wo6CpmUI7DlGw7BBZhB50W3z3MQ
	+vCJHkDw1Q7SscnKifCNvJC3OUdv4GY0Cp205ne+Ii7brcDYZZGlDCLQ0XSctoUzvHRPlRaRb8h
	jqo0U9WpX1NOe9EXCzpw7kD6Y1nKKdebH1+SpgTseANcKjA4rg70SNhE+XZpw3HsbRwoMLe2ieN
	zw0JT7um0cNVjkZddUhaAAI5KEj1PH/2kHE30tsv75i+5ApigdYQlTEBA1TL9fupm3N+1blljHM
	RrpOyei6RQqE99+M4vAOvCtfLCM3D2OUEzJjrZk2nnZZ+XBMF/CiUVGumCxfrbpwDS3r3xplNDS
	4wAZkLt1w/j4K2XbpZvH9KmLwTZHQV0Cx2NzL3LjlM1poXKFS1NMJRIfddSPBG5sA3wlNiITl7t
	5N/uo8KAOvMtRwVG3F17iZt
X-Received: by 2002:a05:690c:1e:b0:79a:4fe4:ff43 with SMTP id 00721157ae682-79a4fe506d3mr16957877b3.25.1773627598981;
        Sun, 15 Mar 2026 19:19:58 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:58 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 62/79] ssdfs: introduce shared dictionary b-tree
Date: Sun, 15 Mar 2026 19:17:54 -0700
Message-ID: <20260316021800.1694650-28-slava@dubeyko.com>
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

SSDFS dentry is the metadata structure of fixed size (32 bytes).
It contains inode ID, name hash, name length, and inline string
for 12 symbols. Generally speaking, the dentry is able to store
8.3 filename inline. If the name of file/folder has longer name
(more than 12 symbols) then the dentry will keep only the portion of
the name but the whole name will be stored into a shared dictionary.
The goal of such approach is to represent the dentry by compact
metadata structure of fixed size for the fast and efficient operations
with the dentries. It is possible to point out that there are a lot of
use-cases when the length of file or folder is not very long. As a result,
dentry’s inline string could be only storage for the file/folder name.
Moreover, the goal of shared dictionary is to store the long names
efficiently by means of using the deduplication mechanism.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/shared_dictionary.h | 204 +++++++++++++++++++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 fs/ssdfs/shared_dictionary.h

diff --git a/fs/ssdfs/shared_dictionary.h b/fs/ssdfs/shared_dictionary.h
new file mode 100644
index 000000000000..3bd18a0682cb
--- /dev/null
+++ b/fs/ssdfs/shared_dictionary.h
@@ -0,0 +1,204 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/shared_dictionary.h - shared dictionary btree declarations.
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
+#ifndef _SSDFS_SHARED_DICTIONARY_TREE_H
+#define _SSDFS_SHARED_DICTIONARY_TREE_H
+
+/*
+ * struct ssdfs_names_queue - names queue descriptor
+ * @lock: names queue's lock
+ * @list: names queue's list
+ */
+struct ssdfs_names_queue {
+	spinlock_t lock;
+	struct list_head list;
+};
+
+/*
+ * struct ssdfs_name_descriptor - name descriptor
+ * @hash: name hash
+ * @len: name length
+ * @str_buf: name string
+ */
+struct ssdfs_name_descriptor {
+	u64 hash;
+	size_t len;
+	unsigned char str_buf[SSDFS_MAX_NAME_LEN];
+};
+
+/*
+ * struct ssdfs_name_info - name info
+ * @list: names queue list
+ * @type: operation type
+ * @desc.name: name descriptor
+ * @index: node's index
+ */
+struct ssdfs_name_info {
+	struct list_head list;
+	int type;
+
+	union {
+		struct ssdfs_name_descriptor name;
+		struct ssdfs_btree_index index;
+	} desc;
+};
+
+/* Possible type of operations with name */
+enum {
+	SSDFS_NAME_UNKNOWN_OP,
+	SSDFS_INIT_SHDICT_NODE,
+	SSDFS_NAME_ADD,
+	SSDFS_NAME_CHANGE,
+	SSDFS_NAME_DELETE,
+	SSDFS_NAME_OP_MAX
+};
+
+/*
+ * struct ssdfs_name_requests_queue - name requests queue
+ * @queue: name requests queue object
+ * @thread: descriptor of queue's thread
+ */
+struct ssdfs_name_requests_queue {
+	struct ssdfs_names_queue queue;
+	struct ssdfs_thread_info thread;
+};
+
+/*
+ * struct ssdfs_shared_dict_btree_info - shared dictionary btree info
+ * @state: shared dictionary btree state
+ * @lock: shared dictionary tree's lock
+ * @generic_tree: generic btree description
+ * @read_reqs: current count of read requests
+ * @requests: name requests queue
+ * @wait_queue: wait queue of shared dictionary tree's thread
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_shared_dict_btree_info {
+	atomic_t state;
+	struct rw_semaphore lock;
+	struct ssdfs_btree generic_tree;
+
+	atomic_t read_reqs;
+
+	struct ssdfs_name_requests_queue requests;
+	wait_queue_head_t wait_queue;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Shared dictionary tree states */
+enum {
+	SSDFS_SHDICT_BTREE_UNKNOWN_STATE,
+	SSDFS_SHDICT_BTREE_CREATED,
+	SSDFS_SHDICT_BTREE_UNDER_INIT,
+	SSDFS_SHDICT_BTREE_INITIALIZED,
+	SSDFS_SHDICT_BTREE_CORRUPTED,
+	SSDFS_SHDICT_BTREE_STATE_MAX
+};
+
+#define SSDFS_HTBL_DESC(ptr) \
+	((struct ssdfs_shdict_htbl_item *)(ptr))
+#define SSDFS_LTBL2_DESC(ptr) \
+	((struct ssdfs_shdict_ltbl2_item *)(ptr))
+#define SSDFS_LTBL1_DESC(ptr) \
+	((struct ssdfs_shdict_ltbl1_item *)(ptr))
+#define SSDFS_SEARCH_KEY(ptr) \
+	((union ssdfs_shdict_search_key *)(ptr))
+
+/*
+ * Shared dictionary tree API
+ */
+int ssdfs_shared_dict_btree_create(struct ssdfs_fs_info *fsi);
+int ssdfs_shared_dict_btree_init(struct ssdfs_fs_info *fsi);
+void ssdfs_shared_dict_btree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_shared_dict_btree_flush(struct ssdfs_shared_dict_btree_info *tree);
+
+int ssdfs_shared_dict_get_name(struct ssdfs_shared_dict_btree_info *tree,
+				u64 hash,
+				struct ssdfs_name_string *name);
+int ssdfs_shared_dict_save_name(struct ssdfs_shared_dict_btree_info *tree,
+				u64 hash,
+				const struct qstr *str);
+
+/*
+ * Shared dictionary tree internal API
+ */
+int ssdfs_shared_dict_tree_find(struct ssdfs_shared_dict_btree_info *tree,
+				u64 name_hash,
+				struct ssdfs_btree_search *search);
+int ssdfs_shared_dict_tree_add(struct ssdfs_shared_dict_btree_info *tree,
+				u64 name_hash,
+				const char *name, size_t len,
+				struct ssdfs_btree_search *search);
+int ssdfs_shared_dict_btree_node_left_items(struct ssdfs_btree_node *node,
+					    u32 threshold,
+					    u16 *free_space);
+int ssdfs_shared_dict_btree_node_right_items(struct ssdfs_btree_node *node,
+					     u32 threshold,
+					     u16 *free_space);
+
+int ssdfs_shared_dict_start_thread(struct ssdfs_shared_dict_btree_info *tree);
+int ssdfs_shared_dict_stop_thread(struct ssdfs_shared_dict_btree_info *tree);
+
+/*
+ * Name info's API
+ */
+void ssdfs_zero_name_info_cache_ptr(void);
+int ssdfs_init_name_info_cache(void);
+void ssdfs_destroy_name_info_cache(void);
+struct ssdfs_name_info *ssdfs_name_info_alloc(void);
+void ssdfs_name_info_free(struct ssdfs_name_info *ni);
+void ssdfs_name_info_init(int type, u64 hash,
+			  const unsigned char *str,
+			  const size_t len,
+			  struct ssdfs_name_info *ni);
+void ssdfs_node_index_init(int type, struct ssdfs_btree_index *index,
+			   struct ssdfs_name_info *ni);
+
+/*
+ * Names queue API
+ */
+void ssdfs_names_queue_init(struct ssdfs_names_queue *nq);
+bool is_ssdfs_names_queue_empty(struct ssdfs_names_queue *nq);
+bool has_queue_unprocessed_names(struct ssdfs_shared_dict_btree_info *tree);
+void ssdfs_names_queue_add_tail(struct ssdfs_names_queue *nq,
+				struct ssdfs_name_info *ni);
+void ssdfs_names_queue_add_head(struct ssdfs_names_queue *nq,
+				struct ssdfs_name_info *ni);
+int ssdfs_names_queue_remove_first(struct ssdfs_names_queue *nq,
+				   struct ssdfs_name_info **ni);
+void ssdfs_names_queue_remove_all(struct ssdfs_names_queue *nq);
+
+void ssdfs_debug_shdict_btree_object(struct ssdfs_shared_dict_btree_info *tree);
+void ssdfs_debug_btree_search_result_name(struct ssdfs_btree_search *search);
+
+/*
+ * Shared dictionary btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+					ssdfs_shared_dict_btree_desc_ops;
+extern const struct ssdfs_btree_operations
+					ssdfs_shared_dict_btree_ops;
+extern const struct ssdfs_btree_node_operations
+					ssdfs_shared_dict_btree_node_ops;
+
+#endif /* _SSDFS_SHARED_DICTIONARY_TREE_H */
-- 
2.34.1

