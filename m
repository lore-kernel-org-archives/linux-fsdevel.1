Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5183F397B1D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 12:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780662821; cv=none; b=cyjHDwy/ba7z73lD/DaxhsGcsmtgHtIKmQKI8DIciwxViH16kloFl1cplztpBfLZXycUaiX+b/QCg6pMp/mZ9/QtuISpsoMpfhPxOVEHyWWBlqPXQJ367a5uRm/orued0U28zY0n8rLANlVQn2UzVas2QRd9lyS7+R0QwjTaAsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780662821; c=relaxed/simple;
	bh=waKZEEXY9843aO0iphtvui01RZQIwqYugZMN+on49bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkbGTUjY6jpu+Zr6lLp1gIhfWTdntEXuX4Leh1KzeufhwzzCnpj80ETaRIIEKnrUoC9Ae0P12dTwcJzJBELDzPRG9y/At2hQlMBo8zC6XXygjrPKM8KuDOfYKTvPf7LGW9Y6kcS0Bj20WaNrzrWRZkXNqyrki3Gvz7r+T2z7drs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GjVo1NtF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BfjvpJw9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GjVo1NtF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BfjvpJw9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780662819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
	b=GjVo1NtFzn8FK8jH+OB4dsGthS8lww/OAowj5SSeZps5eg8GBPZpejt1pvtosWhd97SJTZ
	+akpMDrzhn59rC8mvu8iGkbcw9f6fnmxfovqSTN0mvzSKN1IlJiKUCmQEL6XwtSR2Ebd6j
	ATslmYiNdz5CFSQBOa/FlUn2UVTmcpY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-JJAdxk7xP4KOhtIe9wmEUQ-1; Fri, 05 Jun 2026 08:33:36 -0400
X-MC-Unique: JJAdxk7xP4KOhtIe9wmEUQ-1
X-Mimecast-MFC-AGG-ID: JJAdxk7xP4KOhtIe9wmEUQ_1780662815
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46016bedbaaso18017f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 05:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780662815; x=1781267615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
        b=BfjvpJw9hxP+TAkVKDP6wYtjGcn4pwPSaV8elQ+MrzAhaEEJD+Ip5clDlNj4FtKetc
         /tgvrW0tRPVA6xjZ6zRPxId2rIm/PHzdR4QOvJvXi6g15Vm9R4Ar1Oa9pwAD0lEGRb2m
         jrcC6zPzwjHP8Mpru1EBbTxf/tit3mKLamZUbSlZrWNQ6OVTKYRMU6Xe19RX0m4VBdDQ
         jqJLmm32fOT1u66+PoosQIbKjKMdKgNVPBXGK6dObzrfdP6xyEZCZGowV7b+FuF3qGXJ
         9fcYXOhI6IipmcdVHY30d6YdVWVqqEaD++E4bqT84MDq7PLF0/DBjvioxaPUUAX5NPP9
         SXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780662815; x=1781267615;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
        b=Pp/PY9X6MUukcwQznldhbDMsAGfMjUhj6wJvoOjgBYkLGTScCbv/UM/aPs6dL7lzho
         KUVcRtzlgIMo0YfbVHrtL+84xE8HseiutQ1SKUA0Ct+jMSBYBiHAGOqCirEedy2bM/gu
         f0apsD6NDc8sBVdWk3yHnLTLtwWAastQtJJnWgYdUFJsbJppoQM8uqKqe1063QVc8NZI
         tC/C63iiyHN0b3Aql0O2IJ/G6zHlsOzjLLeU0wxtNz6pSdb+FeH87L61cbJcGIWznnBR
         d0kCjrA8NFmFF9Hphyn83aMavShkYfKYBjpc8wA1KCoRVN+v6m+QYDVSGuXDpLd83aB6
         22HA==
X-Gm-Message-State: AOJu0Yy9DcX6QRFSaQnXKWbZN7IFeXhslu2gTJDJYbUyTgXI4rl3Yyab
	7BNxYiQRmUXXEQECbdGTtHNxBq2o1XzSptaSS8GHbsq5jN2hHZCxstTTH6KcZ05GJF2lXtBEQHx
	aG/G8TYK4FhLfyMv5D9oNXYCt8rD9DDHoaYS45NeQQ6QWToYhDx0kK7Ex7cNSP+RpSYL4x54QUM
	VVdG3iIYalyTTo5mDBLmZ3xynTySHgpmpcFbw3xnt92RAecEz1Ef0=
X-Gm-Gg: Acq92OFKxXJFoNnUaVIFFKqswh02StbLEzwrvU7ysYwMJPybAsBPTU1JfnmZijAp5XL
	jlvrJRRcjUPLTUIewWyNXMQEgYCxAwUkMR5acU4G5ioyQQMFBXPFcXzidFOSOzmVWGlLLtXn4g/
	y5AQA0g7nG1ETeShLssgoAiV/Q/dLA2vSBCtQbsML5CQyJEfX4FOpghNA7rTgTKEBPf3avnB4e9
	B7u2qoe+eK+1C32eW0UPuxGI9sMqFEdKmi/+l8lcgKZTy3vN1Enj/xfW9pBaKjcJSkzKeL89IsS
	Vru+DSTxxg/tq3dFmCxoUgeq1yby48Eq4aP5PA8nexDfsk9B4ZHJv4sWbUSF0eUODFGe2PBG0a2
	n9wk0GsG3Fa/YzECm1io+D/RSFOJhqH0oHOE0GbEF5gHo7hZRc+6ndK7G27BJd1egyfq53ShdDY
	cxNb3ypA==
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-4603063a715mr4149817f8f.19.1780662814806;
        Fri, 05 Jun 2026 05:33:34 -0700 (PDT)
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id ffacd0b85a97d-4603063a715mr4149758f8f.19.1780662814217;
        Fri, 05 Jun 2026 05:33:34 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm12702780f8f.32.2026.06.05.05.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 05:33:33 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v3 1/4] kernfs: fix xattr race condition with multiple superblocks
Date: Fri,  5 Jun 2026 14:33:26 +0200
Message-ID: <20260605123331.2621677-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605123331.2621677-1-mszeredi@redhat.com>
References: <20260605123331.2621677-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Multiple superblocks with different namespaces can share the same
kernfs_node when kernfs_test_super() finds a matching root but
different namespace. This means multiple inodes from different
superblocks can reference the same kernfs_node->iattr->xattrs
structure.

The VFS layer only holds per-inode locks during xattr operations,
which is insufficient to serialize concurrent xattr modifications on
the shared kernfs_node. This can lead to race conditions in
simple_xattr_set() where the lookup->replace/remove sequence is not
atomic with respect to operations from other superblocks.

Fix this by protecting xattr operations with the existing hashed
kernfs_locks->open_file_mutex[] array, which is already used to
protect per-node open file data. The hashed mutex array provides
scalable per-node serialization (scaled by CPU count, up to 1024 locks
on 32+ CPU systems) with zero memory overhead.

Changes:
- Rename open_file_mutex[] to node_mutex[] to reflect dual purpose
- Add kernfs_node_lock_ptr() and kernfs_node_lock() helpers
- Protect simple_xattr_set() calls in kernfs_xattr_set() and
  kernfs_vfs_user_xattr_set() with the hashed mutex
- Update file.c to use new helpers via compatibility wrappers
- Update documentation to explain the extended lock usage

Fixes: b32c4a213698 ("xattr: add rhashtable-based simple_xattr infrastructure")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260601162454.2116375-1-mszeredi%40redhat.com
Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/file.c            | 13 +++----------
 fs/kernfs/inode.c           | 12 ++++++++++++
 fs/kernfs/kernfs-internal.h | 20 ++++++++++++++++++++
 fs/kernfs/mount.c           |  2 +-
 include/linux/kernfs.h      | 11 ++++++++---
 5 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 1163aa769738..8e0e90c93372 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -40,22 +40,15 @@ struct kernfs_open_node {
 static DEFINE_SPINLOCK(kernfs_notify_lock);
 static struct kernfs_node *kernfs_notify_list = KERNFS_NOTIFY_EOL;
 
+/* Compatibility wrappers - use the common hashed node lock */
 static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
 {
-	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
-
-	return &kernfs_locks->open_file_mutex[idx];
+	return kernfs_node_lock_ptr(kn);
 }
 
 static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
 {
-	struct mutex *lock;
-
-	lock = kernfs_open_file_mutex_ptr(kn);
-
-	mutex_lock(lock);
-
-	return lock;
+	return kernfs_node_lock(kn);
 }
 
 /**
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 38b28aa7cd02..e676737d9531 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -320,6 +320,15 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 	if (!attrs)
 		return -ENOMEM;
 
+	/*
+	 * Protect xattr modifications with the hashed per-node mutex.
+	 * Multiple superblocks (with different namespaces) can share the same
+	 * kernfs_node, so inode locking alone is insufficient. The hashed mutex
+	 * ensures serialization of concurrent xattr operations on the same node,
+	 * including the lazy allocation of the xattrs structure itself.
+	 */
+	CLASS(kernfs_node_lock, lock)(kn);
+
 	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
 	if (IS_ERR_OR_NULL(xattrs))
 		return PTR_ERR(xattrs);
@@ -372,6 +381,9 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (!attrs)
 		return -ENOMEM;
 
+	/* See comment in kernfs_xattr_set() about locking. */
+	CLASS(kernfs_node_lock, lock)(kn);
+
 	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
 	if (IS_ERR_OR_NULL(xattrs))
 		return PTR_ERR(xattrs);
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 8d8912f50b05..1dc6663553d1 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -211,4 +211,24 @@ extern const struct inode_operations kernfs_symlink_iops;
  * kernfs locks
  */
 extern struct kernfs_global_locks *kernfs_locks;
+
+/* Hashed mutex helpers - protect per-node data structures */
+static inline struct mutex *kernfs_node_lock_ptr(struct kernfs_node *kn)
+{
+	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
+
+	return &kernfs_locks->node_mutex[idx];
+}
+
+static inline struct mutex *kernfs_node_lock(struct kernfs_node *kn)
+{
+	struct mutex *lock = kernfs_node_lock_ptr(kn);
+
+	mutex_lock(lock);
+	return lock;
+}
+
+DEFINE_CLASS(kernfs_node_lock, struct mutex *,
+	     mutex_unlock(_T), kernfs_node_lock(kn), struct kernfs_node *kn)
+
 #endif	/* __KERNFS_INTERNAL_H */
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 6e3217b6e481..f183a96778b9 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -446,7 +446,7 @@ static void __init kernfs_mutex_init(void)
 	int count;
 
 	for (count = 0; count < NR_KERNFS_LOCKS; count++)
-		mutex_init(&kernfs_locks->open_file_mutex[count]);
+		mutex_init(&kernfs_locks->node_mutex[count]);
 }
 
 static void __init kernfs_lock_init(void)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index e21b2f7f4159..351a5101c862 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -76,20 +76,25 @@ struct kernfs_iattrs;
  * kernfs_open_file.
  *
  * kernfs_open_files are chained at kernfs_open_node->files, which is
- * protected by kernfs_global_locks.open_file_mutex[i].
+ * protected by kernfs_global_locks.node_mutex[i].
  *
  * To reduce possible contention in sysfs access, arising due to single
- * locks, use an array of locks (e.g. open_file_mutex) and use kernfs_node
+ * locks, use an array of locks (e.g. node_mutex) and use kernfs_node
  * object address as hash keys to get the index of these locks.
  *
  * Hashed mutexes are safe to use here because operations using these don't
  * rely on global exclusion.
  *
+ * The hashed mutex array protects per-node data: the kernfs_open_node for
+ * open file management, and kernfs_node xattr operations (necessary because
+ * multiple superblocks with different namespaces can share the same
+ * kernfs_node, making per-inode locking insufficient).
+ *
  * In future we intend to replace other global locks with hashed ones as well.
  * kernfs_global_locks acts as a holder for all such hash tables.
  */
 struct kernfs_global_locks {
-	struct mutex open_file_mutex[NR_KERNFS_LOCKS];
+	struct mutex node_mutex[NR_KERNFS_LOCKS];
 };
 
 enum kernfs_node_type {
-- 
2.54.0

