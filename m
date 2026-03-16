Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2ED322749
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627601; cv=none; b=XQmQPqTwyyZ69LzycCRzOKBisdJQc9oYFGnJQPvBPbMA7w3j4gMsE0JExQjHkp85Wlgfhg2ZFBSQtfUjUuMFK8F3up+1muEs0phdgGbL9lnMH202I8HB83V0fv88FKEwb1XmiBbje7bBTSDvHo0PaIk88NecK4HFCWQz9byrhR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627601; c=relaxed/simple;
	bh=LKbNz4jgNvWd0WXarTRp7UuOBIcqVhVPaKZABGufDM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYmQXO2hSiFSdDLusTCGOtuhLwlHzAkJVJp/q+MJ7h03AuN2D/HieR66/6KZFkgbbmahFHqZ04/OuaeQkaHmtIxOtkpDFzVEoZi9Mi6YAN3HLhLvNf+EhJUPnRZ1xvBzcAS3Hl4nSv+OBFncqnOZu9YKmWrL5kVx0tf/NTuim+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=s6JW3EdT; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="s6JW3EdT"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-79a40fb9890so6455597b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627595; x=1774232395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oKbLxfQ7PMyCY2trXnORKfnxYDPCiSg+ux2upmRPiKA=;
        b=s6JW3EdTjO8ybr7nF5rwNoz1o5TquIoVLE6NMDKfjDbs/Cn51YqB/m/c7uHH6dAbXS
         FRDZq8HBHSMgELguXHuyuj9GqIXfDvxyErIa/l5wB03NcgFSFUxwfGNuevytnr3GpsIN
         CVMDY+DnqLLr5S7bBYUTXbbTFs1bAoHRpVTali+3wrc5xTlW6adkGWEyrYnIbv/ZCBEa
         WH6alCTBdIuR5cwiPT1MIzYTWZbwTZewls8XiMGcnSWpT9h+KVp7pqL5dpbuFAIDZWmx
         dEAnjP4vOKxhTgW+rKrjOc0NfF/eZEsJBz9/D8pkbazEnZC+LZ65CurKDxrkHRFnXkkD
         ehDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627595; x=1774232395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oKbLxfQ7PMyCY2trXnORKfnxYDPCiSg+ux2upmRPiKA=;
        b=ol7FB5tUeRpTmiKZ1JIdpx4S205d0nFZ8Ne8HpJLj6jtFtMNq8GWNBi7Y6FO78hp8V
         YfNWePaFl3A8CKxaHcnUALZ5e29dI/hTxCkC9H+tgC/0Vt8pU9DUyqnNM0kEmtmoSHvy
         9NmTiJPCAVZCwRJJedRsZJiy8cdiF2YKbqfF/bkVJ4Eql5FTm4XfGmJTEYqg4+9SKHOi
         Rwx7XGL/QrNEVnfHTfOerTUzvBlWwJcjK6jiHlNAlqFCPySWx4lXv7zCsRksr0fhGrMj
         K/qmJRY4EZyf3RF7ctJpLRhKckxwrdhKpYRnlH+oLaNPRrqgK4AH57rC1SXt0z6jZajj
         OcOw==
X-Gm-Message-State: AOJu0Yy8z6Ddn5jA/IKJZjoiYHXJTY9gWhkMXIcr4RBYlOBEVGj7casC
	ZP0TVm8pAgzMz6YvR6pORPngaWZemHwNEmSR5PwXwzvSNEB9IiVsQb91x9ByFmv/wCrYDfe4MTN
	3l9JS
X-Gm-Gg: ATEYQzzerhtA4NlxdCo0goncm/VwvgcxqwWbXlYSf410N/avx0W7ShgqszJZeI6BdHK
	9IONtZDCI+vNJlqpV2ZQcKPjJHfcgBFBq774V2q9vlOXY11hf17EZ3HPVS9LdmYxq8QuiX3dZOX
	yAlq1YCEbUV6cBypf5v1nBXHuAPGUiPYmGC+eYcknx2YqMq4g40n7DsrIhAM0N5jAxqa4V4hDmk
	801Y9z+83IEoXrKSrm18wn7uTQIUVA1cm998qpG2KU8SUyvt1LdPzz3Ii+r8en4c0XyYe7uZuRR
	5iDnD9vcSDo8BGhNifZkH0VYhCJGD+G7nHkuu5tmmzpjU7T8gZ5iag8yrUkN1wHkOD5noAbhGvl
	Nt8bMhEbHaArZt6TDTGS2b1jeiJkdzYK67sEi7+U45J88jlWIDciJanqQ4AIT8C3d6dJIRYq3ox
	43XSNejbZXEdWIXNNPTJZbySeqmMs7Zq8dkFGHY2dEQydtb8SzKxOJi+eZUDOpkHFjCznGi5dnI
	4eMxxL0oXwADKbjQbjj6wFlijbSFNqaKfY=
X-Received: by 2002:a05:690c:6d83:b0:79a:2ea7:36b7 with SMTP id 00721157ae682-79a2ea74f62mr71656917b3.51.1773627595063;
        Sun, 15 Mar 2026 19:19:55 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:54 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 57/79] ssdfs: introduce invalidated extents b-tree
Date: Sun, 15 Mar 2026 19:17:51 -0700
Message-ID: <20260316021800.1694650-25-slava@dubeyko.com>
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

ZNS SSD operates by zone concept. Zone can be: (1) empty,
(2) open (implicitly or explicitly), (3) closed, (4) full.
The number of open/active zones is limited by some threshold.
To manage open/active zones limitation, SSDFS has current
user data segment for new data and current user data segment
to receive updates for closed zones. Every update of data in
closed zone requires: (1) store updated data into current
segment for updated user data, (2) update extents b-tree by
new data location, (3) add invalidated extent of closed zone
into invalidated extents b-tree. Invalidated extents b-tree
is responsible for: (1) correct erase block's (closed zone)
block bitmap by means of setting moved logical blocks as
invalidated during erase block object initialization,
(2) collect all invalidated extents of closed zone.
If the length of all closed zone's invalidated extents is equal
to zone size, then closed zone can be re-initialized or be erased.

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/invalidated_extents_tree.h | 96 +++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)
 create mode 100644 fs/ssdfs/invalidated_extents_tree.h

diff --git a/fs/ssdfs/invalidated_extents_tree.h b/fs/ssdfs/invalidated_extents_tree.h
new file mode 100644
index 000000000000..a0d1993e5523
--- /dev/null
+++ b/fs/ssdfs/invalidated_extents_tree.h
@@ -0,0 +1,96 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/invalidated_extents_tree.h - invalidated extents btree declarations.
+ *
+ * Copyright (c) 2022-2026 Viacheslav Dubeyko <slava@dubeyko.com>
+ *              http://www.ssdfs.org/
+ * Copyright (c) 2022-2023 Bytedance Ltd. and/or its affiliates.
+ *              https://www.bytedance.com/
+ * All rights reserved.
+ *
+ * Authors: Viacheslav Dubeyko <slava@dubeyko.com>
+ *
+ * Acknowledgement: Cong Wang
+ */
+
+#ifndef _SSDFS_INVALIDATED_EXTENTS_TREE_H
+#define _SSDFS_INVALIDATED_EXTENTS_TREE_H
+
+/*
+ * struct ssdfs_invextree_info - invalidated extents tree object
+ * @state: invalidated extents btree state
+ * @lock: invalidated extents btree lock
+ * @generic_tree: generic btree description
+ * @extents_count: count of extents in the whole tree
+ * @fsi: pointer on shared file system object
+ */
+struct ssdfs_invextree_info {
+	atomic_t state;
+	struct rw_semaphore lock;
+	struct ssdfs_btree generic_tree;
+
+	atomic64_t extents_count;
+
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Invalidated extents tree states */
+enum {
+	SSDFS_INVEXTREE_UNKNOWN_STATE,
+	SSDFS_INVEXTREE_CREATED,
+	SSDFS_INVEXTREE_INITIALIZED,
+	SSDFS_INVEXTREE_DIRTY,
+	SSDFS_INVEXTREE_CORRUPTED,
+	SSDFS_INVEXTREE_STATE_MAX
+};
+
+/*
+ * Invalidated extents tree API
+ */
+int ssdfs_invextree_create(struct ssdfs_fs_info *fsi);
+void ssdfs_invextree_destroy(struct ssdfs_fs_info *fsi);
+int ssdfs_invextree_flush(struct ssdfs_fs_info *fsi);
+
+int ssdfs_invextree_find(struct ssdfs_invextree_info *tree,
+			 struct ssdfs_raw_extent *extent,
+			 struct ssdfs_btree_search *search);
+int ssdfs_invextree_add(struct ssdfs_invextree_info *tree,
+			struct ssdfs_raw_extent *extent,
+			struct ssdfs_btree_search *search);
+int ssdfs_invextree_delete(struct ssdfs_invextree_info *tree,
+			   struct ssdfs_raw_extent *extent,
+			   struct ssdfs_btree_search *search);
+
+/*
+ * Invalidated extents tree's internal API
+ */
+int ssdfs_invextree_find_leaf_node(struct ssdfs_invextree_info *tree,
+				   u64 seg_id,
+				   struct ssdfs_btree_search *search);
+int ssdfs_invextree_get_start_hash(struct ssdfs_invextree_info *tree,
+				   u64 *start_hash);
+int ssdfs_invextree_node_hash_range(struct ssdfs_invextree_info *tree,
+				    struct ssdfs_btree_search *search,
+				    u64 *start_hash, u64 *end_hash,
+				    u16 *items_count);
+int ssdfs_invextree_extract_range(struct ssdfs_invextree_info *tree,
+				  u16 start_index, u16 count,
+				  struct ssdfs_btree_search *search);
+int ssdfs_invextree_check_search_result(struct ssdfs_btree_search *search);
+int ssdfs_invextree_get_next_hash(struct ssdfs_invextree_info *tree,
+				  struct ssdfs_btree_search *search,
+				  u64 *next_hash);
+
+void ssdfs_debug_invextree_object(struct ssdfs_invextree_info *tree);
+
+/*
+ * Invalidated extents btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations ssdfs_invextree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_invextree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_invextree_node_ops;
+
+#endif /* _SSDFS_INVALIDATED_EXTENTS_TREE_H */
-- 
2.34.1

