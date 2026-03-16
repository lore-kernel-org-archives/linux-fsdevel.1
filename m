Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF4A318BA6
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 02:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627599; cv=none; b=lkPyURlGaYKOZ1gbD6JarLS34FhOBWxl/fgWuH60tdPeWq7zrK7H45XGcxBbb4YRXKFqHbiwpwOXKP9b0nEFu5jbNsewaQcBPJt610TItDOgKk1/6BO8IuuOTXB7sSBDsB5UOiJS2bPznWTnPToMdfaIoc6zvDgaaKVjL+EQEx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627599; c=relaxed/simple;
	bh=Qy29wzu+vWbZFQN4M+W+zI7n6KDsxTMZd1VOijMGW5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZD29hQb6BAe3AOcxBFy5fsUXMt/qVAUMceS6UE/YFz3aHrFk/uKghqHcfn5AztrFg8X5P5kZ6mom/2/XP59kCPsxQMmXc59JNFrwKkkiMC/bUZF8a+TY3LfPCi1YcYzl6S5QNa2I5I8bMkpxDW10JfNznkGgG8YoULnTVI2A4is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=ess3Dgf6; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="ess3Dgf6"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79853c0f5b9so30141397b3.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Mar 2026 19:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773627593; x=1774232393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmsYEzpebRMfQf5tWbMrLT+5D2InoOwaKFntfSmsXoQ=;
        b=ess3Dgf6ad5/++I/pe9wQCBolKo8iWZHLMGI5V4jzrIFOyd35MQkySzVdqfs4ckuCJ
         72ZVrycfbgpQiEgu5bz3NNg+bne8OZnmkdk3d0vmoaDtktPQimBwWwQUYXZ1kED/uOuI
         rX3Fgnu+GYO3MLdBlRYl+WcfVjy2lTIIZYzYm0/8cca+dxxUQuE8WKtTJ36bgu9h+1lh
         VNNxvvstLLJjaoPnLIduGtBIw+kY11i8buieQ+HJx8cbFkUMHrE0jm57lr710LlgSEsy
         ixgF4TaX6dd7o4p+xcun+VCRfwN+Q4088ILmhkfAcYSGhb0mKYhMvEslCUTNQKJO8oez
         FyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773627593; x=1774232393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KmsYEzpebRMfQf5tWbMrLT+5D2InoOwaKFntfSmsXoQ=;
        b=km081ISuk8QzNTOD9B8rrvzDqJ5cMZlhejYnVUVSPNhSHYBLNDvrg3ICIa5DvG2YJT
         HDLvGLMNwh4F+EkWAS0DVUkjtVCYdz5F5xoJYCSwowxJ4d+Puw47WkpSAauMtk7YLT8P
         iMc3HPptJoWaBhLo37uKOtt5+Y9UDc/Xe2kQGHjPz5nrs6twLstl6WJklamaB9yVS3uJ
         25UhT6h0LbqfpeIywFC605EDKvril1ZE4aJI0BlPU5/G7kE/fKpeQ2VVGBAkrTkxvDr7
         u1hz/8cU36BCrbQwW28LQqnXmTIVAvpL3Aeav2pICf4Z+uS8l2kW/0tymC2yviZGCKHq
         rX2g==
X-Gm-Message-State: AOJu0YxYVCugZIOeemwd/nde49O1dzJBlut02tI+rdL8kXN4ZsvDB8Hr
	KqKbFt+RWSziyBRIRoref5xWkFY+qqNzVwg8ktd4sEdEk5CcbMWMFojYc/1S4LY0yOfCIUG/xwA
	s+fmq
X-Gm-Gg: ATEYQzzG091zPlyw/EI465TIUQelaO+wryDExV2JukVlzF2NB6RSikdY9pa8TR/1l1h
	rA8ascm5bWUF0k/8rJ2AF5m/0gOEFDAKEKAYC72KZrdx4j/SD5YjVZ1mwJVJ3MvpyRuag0bzO2S
	W8mCvY4UjLYZx5vDBLzY08jbN73m974fd/4iAkwa7/6tovhNIbsbLwsvhoa11VDqQVfLZMidjmM
	GVaOJ06FBzxUf+J6Eu81skMkUOAfgMA/dV7VaGNRsEfa8T0GsDLZVh5CaH4joYmGUCPzRtkA02k
	SNzPy/B1kEXrA67+TupYjbtVZglQVmOQUtMZty6WOGrthnIh6bUsXL1ryPekNVy1MclCVtkYnxX
	ZrBxCw/dCGvuOL34SVaMc8z6u9QnxR2iaqeHXWPDD8AuxG5ypTVwAXYuhNCWHLkqv6X3iH+XSUx
	oPCv1x6avcESKCkGxjlTTHmw+2FEG2xTjeNjcZQElzWlRExlojFU7vdkU9VoxezxBl8Qt2MajfF
	h+A2Za+r+Hjs/qYT/j1Mbkl
X-Received: by 2002:a05:690c:e3ed:b0:798:1b2d:4b6c with SMTP id 00721157ae682-79a1c0aaf07mr124634557b3.11.1773627592659;
        Sun, 15 Mar 2026 19:19:52 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:6939:3e01:5e8f:6093])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917deb69asm79721617b3.10.2026.03.15.19.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 19:19:52 -0700 (PDT)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH v2 52/79] ssdfs: introduce dentries b-tree
Date: Sun, 15 Mar 2026 19:17:49 -0700
Message-ID: <20260316021800.1694650-23-slava@dubeyko.com>
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

Dentries b-tree is the hybrid b-tree with the root node is stored into
the private inode’s area. By default, inode’s private area has 128 bytes
in size. Also SSDFS dentry has 32 bytes in size. As a result, inode’s
private area provides enough space for 4 inline dentries. Generally
speaking, if a folder contains 4 or lesser files then the dentries
can be stored into the inode’s private area without the necessity
to create the dentries b-tree. Otherwise, if a folder includes
more than 4 files or folders then it needs to create the regular
dentries b-tree with the root node is stored into the private area
of inode. Actually, every node of dentries b-tree contains the header,
index area (for the case of hybrid node), and array of dentries are ordered
by hash value of filename. Moreover, if a b-tree node has 8 KB size then
it is capable to contain maximum 256 dentries. Generally speaking,
the hybrid b-tree was opted for the dentries metadata structure
by virtue of compactness of metadata structure representation and
efficient lookup mechanism. Dentries is ordered on the basis of
name’s hash. Every node of dentries b-tree has: (1) dirty bitmap -
tracking modified dentries, (2) lock bitmap - exclusive locking of
particular dentries without the necessity to lock the whole b-tree
node. Actually, it is expected that dentries b-tree could contain
not many nodes in average because the two nodes (8K in size) of
dentries b-tree is capable to store about 400 dentries.

Dentries b-tree implements API:
(1) create - create dentries b-tree
(2) destroy - destroy dentries b-tree
(3) flush - flush dirty dentries b-tree
(4) find - find dentry for a name in b-tree
(5) add - add dentry object into b-tree
(6) change - change/update dentry object in b-tree
(7) delete - delete dentry object from b-tree
(8) delete_all - delete all dentries from b-tree

Dentries b-tree node implements a specialized API:
(1) find_item - find item in the node
(2) find_range - find range of items in the node
(3) extract_range - extract range of items (or all items) from node
(4) insert_item - insert item in the node
(5) insert_range - insert range of items in the node
(6) change_item - change item in the node
(7) delete_item - delete item from the node
(8) delete_range - delete range of items from the node

Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/ssdfs/dentries_tree.h | 158 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 fs/ssdfs/dentries_tree.h

diff --git a/fs/ssdfs/dentries_tree.h b/fs/ssdfs/dentries_tree.h
new file mode 100644
index 000000000000..1428e5d70d49
--- /dev/null
+++ b/fs/ssdfs/dentries_tree.h
@@ -0,0 +1,158 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause-Clear
+ *
+ * SSDFS -- SSD-oriented File System.
+ *
+ * fs/ssdfs/dentries_tree.h - dentries btree declarations.
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
+#ifndef _SSDFS_DENTRIES_TREE_H
+#define _SSDFS_DENTRIES_TREE_H
+
+#define SSDFS_INLINE_DENTRIES_COUNT		(2 * SSDFS_INLINE_DENTRIES_PER_AREA)
+#define SSDFS_FOLDER_DEFAULT_SHORTCUTS_COUNT	(2)
+
+/*
+ * struct ssdfs_dentries_btree_info - dentries btree info
+ * @type: dentries btree type
+ * @state: dentries btree state
+ * @dentries_count: count of the dentries in the whole dentries tree
+ * @lock: dentries btree lock
+ * @generic_tree: pointer on generic btree object
+ * @inline_dentries: pointer on inline dentries array
+ * @buffer.tree: piece of memory for generic btree object
+ * @buffer.dentries: piece of memory for the inline dentries
+ * @root: pointer on root node
+ * @root_buffer: buffer for root node
+ * @desc: b-tree descriptor
+ * @owner: pointer on owner inode object
+ * @fsi: pointer on shared file system object
+ *
+ * A newly created inode tries to store dentries into inline
+ * dentries. The raw on-disk inode has internal private area
+ * that is able to contain the four inline dentries or
+ * root node of extents btree and extended attributes btree.
+ * If inode hasn't extended attributes and the amount of dentries
+ * are lesser than four then everithing can be stored inside of
+ * inline dentries. Otherwise, the real dentries btree should
+ * be created.
+ */
+struct ssdfs_dentries_btree_info {
+	atomic_t type;
+	atomic_t state;
+	atomic64_t dentries_count;
+
+	struct rw_semaphore lock;
+	struct ssdfs_btree *generic_tree;
+	struct ssdfs_dir_entry *inline_dentries;
+	union {
+		struct ssdfs_btree tree;
+		struct ssdfs_dir_entry dentries[SSDFS_INLINE_DENTRIES_COUNT];
+	} buffer;
+	struct ssdfs_btree_inline_root_node *root;
+	struct ssdfs_btree_inline_root_node root_buffer;
+
+	struct ssdfs_dentries_btree_descriptor desc;
+	struct ssdfs_inode_info *owner;
+	struct ssdfs_fs_info *fsi;
+};
+
+/* Dentries tree types */
+enum {
+	SSDFS_DENTRIES_BTREE_UNKNOWN_TYPE,
+	SSDFS_INLINE_DENTRIES_ARRAY,
+	SSDFS_PRIVATE_DENTRIES_BTREE,
+	SSDFS_DENTRIES_BTREE_TYPE_MAX
+};
+
+/* Dentries tree states */
+enum {
+	SSDFS_DENTRIES_BTREE_UNKNOWN_STATE,
+	SSDFS_DENTRIES_BTREE_CREATED,
+	SSDFS_DENTRIES_BTREE_INITIALIZED,
+	SSDFS_DENTRIES_BTREE_DIRTY,
+	SSDFS_DENTRIES_BTREE_CORRUPTED,
+	SSDFS_DENTRIES_BTREE_STATE_MAX
+};
+
+/*
+ * Inline methods
+ */
+static inline
+size_t ssdfs_inline_dentries_size(void)
+{
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	return dentry_size * SSDFS_INLINE_DENTRIES_COUNT;
+}
+
+static inline
+size_t ssdfs_area_dentries_size(void)
+{
+	size_t dentry_size = sizeof(struct ssdfs_dir_entry);
+	return dentry_size * SSDFS_INLINE_DENTRIES_PER_AREA;
+}
+
+/*
+ * Dentries tree API
+ */
+int ssdfs_dentries_tree_create(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+int ssdfs_dentries_tree_init(struct ssdfs_fs_info *fsi,
+			     struct ssdfs_inode_info *ii);
+void ssdfs_dentries_tree_destroy(struct ssdfs_inode_info *ii);
+int ssdfs_dentries_tree_flush(struct ssdfs_fs_info *fsi,
+				struct ssdfs_inode_info *ii);
+
+int ssdfs_dentries_tree_find(struct ssdfs_dentries_btree_info *tree,
+			     const char *name, size_t len,
+			     struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_add(struct ssdfs_dentries_btree_info *tree,
+			    const struct qstr *str,
+			    struct ssdfs_inode_info *ii,
+			    struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_change(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t old_ino,
+				const struct qstr *str,
+				struct ssdfs_inode_info *new_ii,
+				struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_delete(struct ssdfs_dentries_btree_info *tree,
+				u64 name_hash, ino_t ino,
+				struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_delete_all(struct ssdfs_dentries_btree_info *tree);
+
+/*
+ * Internal dentries tree API
+ */
+u64 ssdfs_generate_name_hash(const struct qstr *str);
+int ssdfs_dentries_tree_find_leaf_node(struct ssdfs_dentries_btree_info *tree,
+					u64 name_hash,
+					struct ssdfs_btree_search *search);
+int ssdfs_dentries_tree_extract_range(struct ssdfs_dentries_btree_info *tree,
+				      u16 start_index, u16 count,
+				      struct ssdfs_btree_search *search);
+
+void ssdfs_debug_dentries_btree_object(struct ssdfs_dentries_btree_info *tree);
+
+/*
+ * Dentries btree specialized operations
+ */
+extern const struct ssdfs_btree_descriptor_operations
+						ssdfs_dentries_btree_desc_ops;
+extern const struct ssdfs_btree_operations ssdfs_dentries_btree_ops;
+extern const struct ssdfs_btree_node_operations ssdfs_dentries_btree_node_ops;
+
+#endif /* _SSDFS_DENTRIES_TREE_H */
-- 
2.34.1

