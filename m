Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45ED324B20
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667611; cv=none; b=dr+f7xppD43ozd/RzqGj7UN6NMSv+H81E8qRR+B94c1YNUGgrCVgVXmkehmG7eKCo0VUEVdm7C3uw1Lqa4tYBIakzGGtf6rp/rrlXVhGSG1MyyT9EMhJHUdTPGvCyXWLRXAV7rv8OSjPfZuJkJvMYUxHnip1j4oPVEOs3Yw0aI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667611; c=relaxed/simple;
	bh=waKZEEXY9843aO0iphtvui01RZQIwqYugZMN+on49bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYANz+TuS28w3JEz7Pe2IUje6WAuB9orDtJ9kn9OtIORkrpY8QBMk78N/iTakY7u80xzkx23WxTKchZ0+bHNEi9qtJnje1FINfJqV/dMIEoODq72WZUMrE5VhRvm30F/YNnFcXKSWG/W2stLg1p1C4FOORC9gyCXiZ1KeJd+D5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XHpA0cN6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=HEqanG/o; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHpA0cN6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="HEqanG/o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780667608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
	b=XHpA0cN6wEBcdrPiodg11hNTGbTt4+IYpRztgzwdpGBD5bM5Mde5dq9298erggnIdfEUCT
	9m/YMA1RnoK2JtIDnTdAKpz26xpAWF1RoStlAYSB9iJrTV4VIPF3bo2xKDtQDr8Myp9RR7
	MYGP82pmvVhs4x+5pBDpBYxSpzoBaBg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-201-PUgr5NTRNF6K7xRaTDHlew-1; Fri, 05 Jun 2026 09:53:26 -0400
X-MC-Unique: PUgr5NTRNF6K7xRaTDHlew-1
X-Mimecast-MFC-AGG-ID: PUgr5NTRNF6K7xRaTDHlew_1780667605
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-490bfd70b0fso18763265e9.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 06:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780667605; x=1781272405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
        b=HEqanG/oeaTISdDsvhSYrzje11orBKfARtDcpAlqGowt+b2iAf+FvjLCwl4lDbqyHe
         pbUjoDD/nIrO76uGMrlMy5d0bnjU9JuMwv3/AI5kGke6xKi6uOF166bNEmkvD4BbKQa8
         rZkNzPXouMdk7j9PdDyZhldxyHyqYlBMnbcwTffrZU08A7zUnv4b9d+ljdRZUNi/fyrR
         cWOYCpeLCPmV+0xzCbI4jX5q54E4LXQEEPeajavFs+OhCraPT3tl7kUAbyAGWeqNOniY
         EKANd9A/60nu21S2ZUjs927/mc/ye3OGzi1rLwvXgUIls1AXq0gXgNs4/S2NeO7WmduO
         Z27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780667605; x=1781272405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8TRPxFGECnjw+M8/0IvOgB7NTMDasli+evg1PYVSz64=;
        b=BEEwjLhb8bAH+j/4nBNFbndmj3yVe4OvB7SloIa98NbHlgmgkLYJf0cPhDthr1rwkq
         MChwMhywbK2KyqSz/fN+CyhS7s5vs99e85XbLd5APk3Pvj3a7di5H4RmoHucU23Yl0w3
         oXYjmZumUsutfJuZ20xmIYkTD1o91vrMYEzwM9TnVJlm4NWGgubNuWtXGpN1tTVo1dEw
         PPLM67LBQlWCDvLP+STVDDesxjbaWcKmo3fyhXfmDoUl8Zucf0rOPrPZc7EF1tPrpuC1
         ckP9h95JzWJZIbBYllv4LcL0+h84k9mRmpi5/tKDRUpSuZlwxIAKdnMQIcBj/R/Blzt/
         vJBg==
X-Gm-Message-State: AOJu0YyZh4bpxFF3fyUo6XNLyz3sAyq6tsN9/xBWOAMhAIuP7/VlINBp
	lZ/p3JoOeMDhavJFowFgmGCapEeg4drVG1MoQSNCjASzJvvOJg6h0YmySh2Kyr/PgZ+GfLbLhQR
	rQh/RU33B2oR785tsze7J5mQpSUE+7zoQiSm6sy8mLThbbcrnVb+M5az9pz/pKs3jUf6RBszlB3
	QtTNJwq194n53ndmDG5a+GRuNSUb062/mulGw4qgx2BDyHGJTARdQ=
X-Gm-Gg: Acq92OHc6Qp9bL5w+6E5mIW49Vvt0UkEwl+mmHrnOXEIkdUpYyW3AQ8LZDN8jrb47DU
	dfB1hvWlhozIv6oCNf6Ulgy/WVNHsqNR3MZGL4LsiublRuK+7zACCWuUJJ5gnq/4FO0TrIYtnXb
	mIX0kDIcCvhF23gCm0rciy3I+ROjKh42aPL4oSY7XmuEvfBEOGKot42vH7kBoTjDLLRuy4tybIl
	A8deYwjZF9nJ13IIOHzYYwclvsPwfS+zNKAbsMHG49KpzzjzDMyd1Xwx7uwE8AI4uksO80OWRI0
	d8aj9ur8EVHdHw9OBDPn3EtoSr6Ad4t9dICblbpU37mdFQPMpU2RSetigbr9wriBinkQHr2hoYS
	z0p2QBDGMWUg9QUFSU4LwBj8aOmndlRXZ9NwUgqMaZ8og23E3slP0PKY9Xh2LhISzzfWx/I2Tm0
	BfEY1i6Q==
X-Received: by 2002:a05:600c:674f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490c25ed266mr66311115e9.13.1780667605458;
        Fri, 05 Jun 2026 06:53:25 -0700 (PDT)
X-Received: by 2002:a05:600c:674f:b0:490:6e11:c303 with SMTP id 5b1f17b1804b1-490c25ed266mr66310545e9.13.1780667605025;
        Fri, 05 Jun 2026 06:53:25 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (84-236-1-92.pool.digikabel.hu. [84.236.1.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3cbfe4sm157999025e9.7.2026.06.05.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 06:53:24 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH v4 1/4] kernfs: fix xattr race condition with multiple superblocks
Date: Fri,  5 Jun 2026 15:53:16 +0200
Message-ID: <20260605135322.2632068-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605135322.2632068-1-mszeredi@redhat.com>
References: <20260605135322.2632068-1-mszeredi@redhat.com>
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

