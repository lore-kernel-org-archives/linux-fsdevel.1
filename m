Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E2C3D1A97
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178421; cv=none; b=XqoaJDgdHDvfumIgSFuYK5R5RTOjMnCJk6CRCKNWxsvw+fpwwiKYSKisEdUahEbSvMBW9/VTfPfvSYmKt9/0KUf/nUYhOc/MAZ6HA8/LXknxa5rn9HZSiY45bdylaySVn0NaCUBgCRcI16YUK8euRg4hR6AvZqI+C4y6sss+sms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178421; c=relaxed/simple;
	bh=ZYgjPBO8TKRsb2+vQSVhm1xXGS4UaNLQxTX7/EKjbVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxDd2cmsZ5MxSHjveAbfBZL3yy9C1bK2lmby4nrQpZCyJWJyIF7mnKOAAP9hXBVtJfWezzhHiFsX8ELHKvTbJjgAbdD1AXVOcKiHboxXiRqEA4H6CZm67diz3RMFi+uIALwe7PROAFqSpjFtFxgMtQ7R24qnXU0JN6LvuI2U7yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DR+bnl0A; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ml7SGtYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DR+bnl0A";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ml7SGtYU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779178417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2HPAA9nmwuWoPlMe7nCLMDGelqKx0ZUUX1G4kUO3L4=;
	b=DR+bnl0AtoIgD5ZNeQ8JHS0JyBaVwhJM+f732B+AHAOabdvnm/pZFY5TZE6pmTn29JwE15
	2a0rxL1kyMh0t9Gm0fyfQWkAn1AkTG0Q9MDVsrztDqRY7ugt70NjI3Ljz7xrG5ehqZIVbl
	S4VPLHKNblX3MWpX/9d3wb8Nd9FlFNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-pVzOgmg-OCmrluKI0nqUHg-1; Tue, 19 May 2026 04:13:35 -0400
X-MC-Unique: pVzOgmg-OCmrluKI0nqUHg-1
X-Mimecast-MFC-AGG-ID: pVzOgmg-OCmrluKI0nqUHg_1779178414
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-447f2ce5556so2785670f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 01:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779178414; x=1779783214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+2HPAA9nmwuWoPlMe7nCLMDGelqKx0ZUUX1G4kUO3L4=;
        b=Ml7SGtYUbVvpzZnJxA5KdK6Za1FQelzLK0vGlql/7cqBbcF0e/upOeKqEIEbBgtOXL
         HpBtiMA/lKVojLOG64xigCWSSzNoygy9H6I060XDUNO3v/2+sDLI0quRAmxzJlDT4TYJ
         H+2b4WL+8yleU7CZpK5DZf166egp9U6Tivz5jayx7X9k/xeAR1UPOv2Z6LLR4rj43DiQ
         tTFGNB29NKowfnPlzdrOSo5FqCPKs5msMArv6t1ODyx7QKJocuGJisu2yZSD3zAzTjIZ
         6cs4C9PJ+ZdBwztIIY3/okgmUHcHvdFtHUBVn3wOeYVHE46fjolmex8bIBWf6x1Ey3m0
         ZuaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178414; x=1779783214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+2HPAA9nmwuWoPlMe7nCLMDGelqKx0ZUUX1G4kUO3L4=;
        b=V2i2Q2IMNntiWNtKdLk0V1y/RvvVyBmhUmIVHd4VMunSXYphk+SwRkKKHHLBHSCwkh
         3Kr3d136Wkl3Qb7Xvu4VHHV6chbsz/El13VRZFwmdGDTdMy/6/Dw31csA9d7ho4aLtzp
         CkH6E1gdt8cX1Xn6twfzVINuQTAPqkM6hdWvO38f2LvUdVedmpI32MygmZo34S7drmlo
         OL0KwB+EjZP3NxKx+pIFp5x2lz2Bs7oHugDA3ApQo6luN4zO56kFaaTuhQZhL4z/aZ6T
         W4/ugyyt56Y9XvBDUVbaG9WnI2mHQ2T+alj/w+5GNix6Prna4vorIApucM4Zeh4i7zpY
         FjdQ==
X-Gm-Message-State: AOJu0YxrXDMa4R/aUedIlhCOmEXA7WFYcPXLP26k4ixb9BpIROCj0TTT
	jHL55i04uLlJwF/xHanuM7/jctDdgcIuHSdbvhIRRaw8VHDEKC1Y/2+dap6aRh57DEWlNl9bYPb
	cSXNksYLbCAXBf3zeuWnHAiIHvNBwCAEUM+5kqsULBVyj18J5D5DUslhJ6FQcxfck8WbqQwQgAx
	ipuqYDrIQ5OcXYuWq52syPwJNKVFGPJyhfLDh+J894GWmtQSVCK0Y=
X-Gm-Gg: Acq92OHLJNjdH+PAM6FY+PoMRI0u/Uw5IBWNNWatKCZkZRzRXkLaWBWUTFGHrL5r69u
	/FXgqCqjC/T5E2pOucIF9ukTeK9k/tYrQlPTYBUDKctW7Ds0Jbblq1HqXECMuNe1J7ZiwRDQTjo
	gHbEiud40ZCSYFi0mD6fkC+Sn2IoexQJJhtQXfHr50HE/R1z5Du+NjGWJh6vtyyAWuah16f27JV
	ttBpzW51SqgsU0LDL/ttqGRevMRdFQqlx34yZej+S+ekIseGZMd2JVr7Gr3X25leSZU8IRX8exl
	tirJ/TvwGLzfzP+M8+hwb+MzAGGt1Ywix47Hiex2tTIr0eT40gzPIiP7qu6zir47P9hTznCqFOc
	5d9WLg6ctnyh9NIYu/DTqeAmWgUEWLyS9l8fsY6qIAqFapDJeQeZczJfVxX4tlCtNn/Ecjte5ZE
	VW
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id 5b1f17b1804b1-490031ed905mr170973785e9.18.1779178413658;
        Tue, 19 May 2026 01:13:33 -0700 (PDT)
X-Received: by 2002:a05:600c:5296:b0:490:31e:d6f4 with SMTP id 5b1f17b1804b1-490031ed905mr170973045e9.18.1779178412956;
        Tue, 19 May 2026 01:13:32 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-173-121.pool.digikabel.hu. [85.67.173.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm45189485f8f.32.2026.05.19.01.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:32 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 3/3] simpe_xattr: use per-sb cache
Date: Tue, 19 May 2026 10:13:23 +0200
Message-ID: <20260519081324.979769-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519081324.979769-1-mszeredi@redhat.com>
References: <20260519081324.979769-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the hash table to the super block to remove excessive overhead in case
of small number of xattrs per inode.

Add linked list to the inode, used for listxattr and eviction.  Listxattr
uses rcu protection to iterate the list of xattrs.

Following stats are based on slabinfo diff, after creating 100k empty
files, then adding a "user.test=foo" xattr to each:

v7.0 (no rhashtable):
  File creation: 993.40 bytes/file
  Xattr addition: 79.99 bytes/file

v7.1-rc2 (per-inode rhashtable):
  File creation: 939.73 bytes/file
  Xattr addition: 1296.08 bytes/file

v7.1-rc2 + this patch (per-sb rhashtable)
  File creation: 947.08 bytes/file
  Xattr addition: 79.95 bytes/file

This patch reverts the xattr overhead to the v7.0 level.

Fixes: b32c4a213698 ("xattr: add rhashtable-based simple_xattr infrastructure")
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c             |   5 +-
 fs/kernfs/inode.c           |  10 +-
 fs/kernfs/kernfs-internal.h |   4 +-
 fs/pidfs.c                  |  14 +-
 fs/xattr.c                  | 265 ++++++++++++++++--------------------
 include/linux/shmem_fs.h    |   3 +-
 include/linux/xattr.h       |  30 ++--
 mm/shmem.c                  |  13 +-
 net/socket.c                |  12 +-
 9 files changed, 178 insertions(+), 178 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 368dc4a217d9..8ba2f2f3da9e 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -606,7 +606,7 @@ void kernfs_put(struct kernfs_node *kn)
 		kernfs_put(kn->symlink.target_kn);
 
 	if (kn->iattr)
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		simple_xattrs_free(&root->xa_cache, &kn->iattr->xattrs, NULL);
 
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
@@ -621,6 +621,7 @@ void kernfs_put(struct kernfs_node *kn)
 	} else {
 		/* just released the root kn, free @root too */
 		idr_destroy(&root->ino_idr);
+		simple_xattr_cache_cleanup(&root->xa_cache);
 		kfree_rcu(root, rcu);
 	}
 }
@@ -706,7 +707,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
  err_out4:
 	if (kn->iattr) {
-		simple_xattrs_free(&kn->iattr->xattrs, NULL);
+		simple_xattrs_free(&root->xa_cache, &kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
  err_out3:
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 65721b1b04f7..41e471261a62 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -37,6 +37,7 @@ static struct kernfs_iattrs *__kernfs_iattrs(struct kernfs_node *kn, bool alloc)
 	if (!ret)
 		return NULL;
 
+	INIT_LIST_HEAD_RCU(&ret->xattrs);
 	/* assign default attributes */
 	ret->ia_uid = GLOBAL_ROOT_UID;
 	ret->ia_gid = GLOBAL_ROOT_GID;
@@ -296,11 +297,12 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 		     void *value, size_t size)
 {
 	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
+	struct simple_xattr_cache *cache = &kernfs_root(kn)->xa_cache;
 
 	if (!attrs)
 		return -ENODATA;
 
-	return simple_xattr_get(&attrs->xattrs, name, value, size);
+	return simple_xattr_get(cache, &attrs->xattrs, name, value, size);
 }
 
 int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
@@ -308,12 +310,13 @@ int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 {
 	struct simple_xattr *old_xattr;
 	struct kernfs_iattrs *attrs;
+	struct simple_xattr_cache *cache = &kernfs_root(kn)->xa_cache;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(cache, &attrs->xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
@@ -360,7 +363,8 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_set_limited(&attrs->xattrs, &attrs->xattr_limits,
+	return simple_xattr_set_limited(&kernfs_root(kn)->xa_cache,
+					&attrs->xattrs, &attrs->xattr_limits,
 					full_name, value, size, flags);
 }
 
diff --git a/fs/kernfs/kernfs-internal.h b/fs/kernfs/kernfs-internal.h
index 8d8912f50b05..4c8c9c3ed639 100644
--- a/fs/kernfs/kernfs-internal.h
+++ b/fs/kernfs/kernfs-internal.h
@@ -26,7 +26,7 @@ struct kernfs_iattrs {
 	struct timespec64	ia_mtime;
 	struct timespec64	ia_ctime;
 
-	struct simple_xattrs	*xattrs;
+	struct list_head	xattrs;
 	struct simple_xattr_limits xattr_limits;
 };
 
@@ -54,6 +54,8 @@ struct kernfs_root {
 	rwlock_t		kernfs_rename_lock;
 
 	struct rcu_head		rcu;
+
+	struct simple_xattr_cache xa_cache;
 };
 
 /* +1 to avoid triggering overflow warning when negating it */
diff --git a/fs/pidfs.c b/fs/pidfs.c
index eb5105bddeca..143d0aec16af 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -37,6 +37,8 @@ static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
 
 static struct path pidfs_root_path = {};
 
+static struct simple_xattr_cache pidfs_xa_cache;
+
 void pidfs_get_root(struct path *path)
 {
 	*path = pidfs_root_path;
@@ -96,7 +98,7 @@ static const struct rhashtable_params pidfs_ino_ht_params = {
  * use file handles.
  */
 struct pidfs_attr {
-	struct simple_xattrs *xattrs;
+	struct list_head xattrs;
 	union {
 		struct pidfs_anon_attr;
 		struct llist_node pidfs_llist;
@@ -196,7 +198,7 @@ static void pidfs_free_attr_work(struct work_struct *work)
 
 	head = llist_del_all(&pidfs_free_list);
 	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
-		simple_xattrs_free(&attr->xattrs, NULL);
+		simple_xattrs_free(&pidfs_xa_cache, &attr->xattrs, NULL);
 		kfree(attr);
 	}
 }
@@ -224,7 +226,7 @@ void pidfs_free_pid(struct pid *pid)
 	if (IS_ERR(attr))
 		return;
 
-	if (likely(!attr->xattrs))
+	if (likely(list_empty(&attr->xattrs)))
 		kfree(attr);
 	else if (llist_add(&attr->pidfs_llist, &pidfs_free_list))
 		schedule_work(&pidfs_free_work);
@@ -1007,6 +1009,8 @@ int pidfs_register_pid(struct pid *pid)
 	if (!new_attr)
 		return -ENOMEM;
 
+	INIT_LIST_HEAD_RCU(&new_attr->xattrs);
+
 	/* Synchronize with pidfs_exit(). */
 	guard(spinlock_irq)(&pid->wait_pidfd.lock);
 
@@ -1048,7 +1052,7 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
 	struct pid *pid = inode->i_private;
 	const char *name = xattr_full_name(handler, suffix);
 
-	return simple_xattr_get(&pid->attr->xattrs, name, value, size);
+	return simple_xattr_get(&pidfs_xa_cache, &pid->attr->xattrs, name, value, size);
 }
 
 static int pidfs_xattr_set(const struct xattr_handler *handler,
@@ -1063,7 +1067,7 @@ static int pidfs_xattr_set(const struct xattr_handler *handler,
 	/* Ensure we're the only one to set @attr->xattrs. */
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	old_xattr = simple_xattr_set(&pid->attr->xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(&pidfs_xa_cache, &pid->attr->xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 9ef7ad8a8f32..31cae48e11a4 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -23,11 +23,17 @@
 #include <linux/vmalloc.h>
 #include <linux/posix_acl_xattr.h>
 #include <linux/rhashtable.h>
+#include <linux/xxhash.h>
 
 #include <linux/uaccess.h>
 
 #include "internal.h"
 
+struct sx_key {
+	const struct list_head *parent;
+	const char *name;
+};
+
 static const char *
 strcmp_prefix(const char *a, const char *a_prefix)
 {
@@ -1269,23 +1275,32 @@ struct simple_xattr *simple_xattr_alloc(const void *value, size_t size)
 	return new_xattr;
 }
 
+static u32 sx_hashfn(const char *name, const struct list_head *parent, u32 seed)
+{
+	return xxh32(name, strlen(name), xxh32(&parent, sizeof(parent), seed));
+}
+
 static u32 simple_xattr_hashfn(const void *data, u32 len, u32 seed)
 {
-	const char *name = data;
-	return jhash(name, strlen(name), seed);
+	const struct sx_key *key = data;
+
+	return sx_hashfn(key->name, key->parent, seed);
 }
 
 static u32 simple_xattr_obj_hashfn(const void *obj, u32 len, u32 seed)
 {
 	const struct simple_xattr *xattr = obj;
-	return jhash(xattr->name, strlen(xattr->name), seed);
+
+	return sx_hashfn(xattr->name, xattr->parent, seed);
 }
 
 static int simple_xattr_obj_cmpfn(struct rhashtable_compare_arg *arg,
 				   const void *obj)
 {
 	const struct simple_xattr *xattr = obj;
-	return strcmp(xattr->name, arg->key);
+	const struct sx_key *key = arg->key;
+
+	return xattr->parent != key->parent || strcmp(xattr->name, key->name);
 }
 
 static const struct rhashtable_params simple_xattr_params = {
@@ -1298,6 +1313,7 @@ static const struct rhashtable_params simple_xattr_params = {
 
 /**
  * simple_xattr_get - get an xattr object
+ * @cache: anchor for the hash table
  * @xattrs: the header of the xattr object
  * @name: the name of the xattr to retrieve
  * @buffer: the buffer to store the value into
@@ -1311,19 +1327,20 @@ static const struct rhashtable_params simple_xattr_params = {
  * Return: On success the length of the xattr value is returned. On error a
  * negative error code is returned.
  */
-int simple_xattr_get(struct simple_xattrs **xattrsp, const char *name,
-		     void *buffer, size_t size)
+int simple_xattr_get(struct simple_xattr_cache *cache, struct list_head *xattrs,
+		     const char *name, void *buffer, size_t size)
 {
-	struct simple_xattrs *xattrs;
 	struct simple_xattr *xattr;
+	struct sx_key key = { .parent = xattrs, .name = name };
+	/* cache->ht is stored set once from NULL to non-NULL */
+	struct rhashtable *ht = smp_load_acquire(&cache->ht);
 	int ret = -ENODATA;
 
-	xattrs = READ_ONCE(*xattrsp);
-	if (!xattrs)
-		return -ENODATA;
+	if (!ht)
+		return ret;
 
 	guard(rcu)();
-	xattr = rhashtable_lookup(&xattrs->ht, name, simple_xattr_params);
+	xattr = rhashtable_lookup(ht, &key, simple_xattr_params);
 	if (xattr) {
 		ret = xattr->size;
 		if (buffer) {
@@ -1336,11 +1353,35 @@ int simple_xattr_get(struct simple_xattrs **xattrsp, const char *name,
 	return ret;
 }
 
-static struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
-						      const void *value, int flags);
+static struct rhashtable *simple_xattrs_lazy_alloc(struct simple_xattr_cache *cache,
+						   const void *value, int flags)
+{
+	struct rhashtable *ht = cache->ht;
+	int err;
+
+	if (unlikely(!ht)) {
+		if (!value)
+			return (flags & XATTR_REPLACE) ? ERR_PTR(-ENODATA) : NULL;
+
+		ht = kzalloc_obj(*ht);
+		if (!ht)
+			return ERR_PTR(-ENOMEM);
+
+		err = rhashtable_init(ht, &simple_xattr_params);
+		if (err) {
+			kfree(ht);
+			return ERR_PTR(err);
+		}
+
+		/* Paris with smp_load_acquire() in simple_xattr_get() */
+		smp_store_release(&cache->ht, ht);
+	}
+	return ht;
+}
 
 /**
  * simple_xattr_set - set an xattr object
+ * @cache: anchor for the hash table
  * @xattrs: the header of the xattr object
  * @name: the name of the xattr to retrieve
  * @value: the value to store along the xattr
@@ -1370,50 +1411,54 @@ static struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xat
  * Return: On success, the removed or replaced xattr is returned, to be freed
  * by the caller; or NULL if none. On failure a negative error code is returned.
  */
-struct simple_xattr *simple_xattr_set(struct simple_xattrs **xattrsp,
+struct simple_xattr *simple_xattr_set(struct simple_xattr_cache *cache, struct list_head *xattrs,
 				      const char *name, const void *value,
 				      size_t size, int flags)
 {
-	struct simple_xattrs *xattrs;
+	struct sx_key key = { .parent = xattrs, .name = name };
 	struct simple_xattr *old_xattr = NULL;
+	struct rhashtable *ht;
 	int err;
 
-	xattrs = simple_xattrs_lazy_alloc(xattrsp, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return ERR_CAST(xattrs);
+	ht = simple_xattrs_lazy_alloc(cache, value, flags);
+	if (IS_ERR_OR_NULL(ht))
+		return ERR_CAST(ht);
 
 	CLASS(simple_xattr, new_xattr)(value, size);
 	if (IS_ERR(new_xattr))
 		return new_xattr;
 
 	if (new_xattr) {
+		new_xattr->parent = xattrs;
 		new_xattr->name = kstrdup(name, GFP_KERNEL_ACCOUNT);
 		if (!new_xattr->name)
 			return ERR_PTR(-ENOMEM);
 	}
 
 	/* Lookup is safe without RCU here since writes are serialized. */
-	old_xattr = rhashtable_lookup_fast(&xattrs->ht, name,
-					   simple_xattr_params);
-
+	old_xattr = rhashtable_lookup_fast(ht, &key, simple_xattr_params);
 	if (old_xattr) {
 		/* Fail if XATTR_CREATE is requested and the xattr exists. */
 		if (flags & XATTR_CREATE)
 			return ERR_PTR(-EEXIST);
 
 		if (new_xattr) {
-			err = rhashtable_replace_fast(&xattrs->ht,
+			err = rhashtable_replace_fast(ht,
 						      &old_xattr->hash_node,
 						      &new_xattr->hash_node,
 						      simple_xattr_params);
 			if (err)
 				return ERR_PTR(err);
+
+			list_replace_rcu(&old_xattr->node, &new_xattr->node);
 		} else {
-			err = rhashtable_remove_fast(&xattrs->ht,
+			err = rhashtable_remove_fast(ht,
 						     &old_xattr->hash_node,
 						     simple_xattr_params);
 			if (err)
 				return ERR_PTR(err);
+
+			list_del_rcu(&old_xattr->node);
 		}
 	} else {
 		/* Fail if XATTR_REPLACE is requested but no xattr is found. */
@@ -1425,11 +1470,13 @@ struct simple_xattr *simple_xattr_set(struct simple_xattrs **xattrsp,
 		 * new value simply insert it.
 		 */
 		if (new_xattr) {
-			err = rhashtable_insert_fast(&xattrs->ht,
+			err = rhashtable_insert_fast(ht,
 						     &new_xattr->hash_node,
 						     simple_xattr_params);
 			if (err)
 				return ERR_PTR(err);
+
+			list_add_tail_rcu(&new_xattr->node, xattrs);
 		}
 
 		/*
@@ -1466,6 +1513,7 @@ static inline int simple_xattr_limits_inc(struct simple_xattr_limits *limits,
 
 /**
  * simple_xattr_set_limited - set an xattr with per-inode user.* limits
+ * @cache: anchor for the hash table
  * @xattrs: the header of the xattr object
  * @limits: per-inode limit counters for user.* xattrs
  * @name: the name of the xattr to set or remove
@@ -1480,7 +1528,7 @@ static inline int simple_xattr_limits_inc(struct simple_xattr_limits *limits,
  * Return: On success zero is returned. On failure a negative error code is
  * returned.
  */
-int simple_xattr_set_limited(struct simple_xattrs **xattrs,
+int simple_xattr_set_limited(struct simple_xattr_cache *cache, struct list_head *xattrs,
 			     struct simple_xattr_limits *limits,
 			     const char *name, const void *value,
 			     size_t size, int flags)
@@ -1494,7 +1542,7 @@ int simple_xattr_set_limited(struct simple_xattrs **xattrs,
 			return ret;
 	}
 
-	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(cache, xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr)) {
 		if (value)
 			simple_xattr_limits_dec(limits, size);
@@ -1540,12 +1588,10 @@ static bool xattr_is_maclabel(const char *name)
  * Return: On success the required size or the size of the copied xattrs is
  * returned. On error a negative error code is returned.
  */
-ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrsp,
+ssize_t simple_xattr_list(struct inode *inode, struct list_head *xattrs,
 			  char *buffer, size_t size)
 {
 	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
-	struct simple_xattrs *xattrs;
-	struct rhashtable_iter iter;
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
 	int err = 0;
@@ -1566,21 +1612,11 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrsp,
 	remaining_size -= err;
 	err = 0;
 
-	xattrs = READ_ONCE(*xattrsp);
 	if (!xattrs)
 		return size - remaining_size;
 
-	rhashtable_walk_enter(&xattrs->ht, &iter);
-	rhashtable_walk_start(&iter);
-
-	while ((xattr = rhashtable_walk_next(&iter)) != NULL) {
-		if (IS_ERR(xattr)) {
-			if (PTR_ERR(xattr) == -EAGAIN)
-				continue;
-			err = PTR_ERR(xattr);
-			break;
-		}
-
+	rcu_read_lock();
+	list_for_each_entry_rcu(xattr, xattrs, node) {
 		/* skip "trusted." attributes for unprivileged callers */
 		if (!trusted && xattr_is_trusted(xattr->name))
 			continue;
@@ -1593,15 +1629,14 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrsp,
 		if (err)
 			break;
 	}
-
-	rhashtable_walk_stop(&iter);
-	rhashtable_walk_exit(&iter);
+	rcu_read_unlock();
 
 	return err ? err : size - remaining_size;
 }
 
 /**
  * simple_xattr_add - add xattr objects
+ * @cache: anchor for the hash table
  * @xattrs: the header of the xattr object
  * @new_xattr: the xattr object to add
  *
@@ -1612,125 +1647,63 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrsp,
  * Return: On success zero is returned. On failure a negative error code is
  * returned.
  */
-int simple_xattr_add(struct simple_xattrs **xattrsp,
+int simple_xattr_add(struct simple_xattr_cache *cache, struct list_head *xattrs,
 		     struct simple_xattr *new_xattr)
 {
-	struct simple_xattrs *xattrs;
-
-	xattrs = simple_xattrs_lazy_alloc(xattrsp, new_xattr->value, 0);
-	if (IS_ERR(xattrs))
-		return PTR_ERR(xattrs);
-
-	return rhashtable_insert_fast(&xattrs->ht, &new_xattr->hash_node,
-				      simple_xattr_params);
-}
-
-/**
- * simple_xattrs_init - initialize new xattr header
- * @xattrs: header to initialize
- *
- * Initialize the rhashtable used to store xattr objects.
- *
- * Return: On success zero is returned. On failure a negative error code is
- * returned.
- */
-int simple_xattrs_init(struct simple_xattrs *xattrs)
-{
-	return rhashtable_init(&xattrs->ht, &simple_xattr_params);
-}
-
-/**
- * simple_xattrs_alloc - allocate and initialize a new xattr header
- *
- * Dynamically allocate a simple_xattrs header and initialize the
- * underlying rhashtable. This is intended for consumers that want
- * to lazily allocate xattr storage only when the first xattr is set,
- * avoiding the per-inode rhashtable overhead when no xattrs are used.
- *
- * Return: On success a new simple_xattrs is returned. On failure an
- * ERR_PTR is returned.
- */
-static struct simple_xattrs *simple_xattrs_alloc(void)
-{
-	struct simple_xattrs *xattrs __free(kfree) = NULL;
-	int ret;
+	struct rhashtable *ht;
+	int err;
 
-	xattrs = kzalloc(sizeof(*xattrs), GFP_KERNEL);
-	if (!xattrs)
-		return ERR_PTR(-ENOMEM);
+	ht = simple_xattrs_lazy_alloc(cache, new_xattr->value, 0);
+	if (IS_ERR(ht))
+		return PTR_ERR(ht);
 
-	ret = simple_xattrs_init(xattrs);
-	if (ret)
-		return ERR_PTR(ret);
+	new_xattr->parent = xattrs;
+	err = rhashtable_insert_fast(ht, &new_xattr->hash_node, simple_xattr_params);
+	if (err)
+		return err;
 
-	return no_free_ptr(xattrs);
+	list_add_tail_rcu(&new_xattr->node, xattrs);
+	return 0;
 }
 
 /**
- * simple_xattrs_lazy_alloc - get or allocate xattrs for a set operation
- * @xattrsp: pointer to the xattrs pointer (may point to NULL)
- * @value: value being set (NULL means remove)
- * @flags: xattr set flags
- *
- * For lazily-allocated xattrs on the write path. If no xattrs exist yet
- * and this is a remove operation, returns the appropriate result without
- * allocating. Otherwise ensures xattrs is allocated and published with
- * store-release semantics.
+ * simple_xattrs_free - free xattrs
+ * @cache: anchor for the hash table
+ * @xattrs: xattr header whose xattrs to destroy
+ * @freed_space: approximate number of bytes of memory freed from @xattrs
  *
- * Return: On success a valid pointer to the xattrs is returned. On
- * failure or early-exit an ERR_PTR or NULL is returned. Callers should
- * check with IS_ERR_OR_NULL() and propagate with PTR_ERR() which
- * correctly returns 0 for the NULL no-op case.
+ * Destroy all xattrs in @xattrs. When this is called no one can hold a
+ * reference to any of the xattrs anymore.
  */
-static struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
-						      const void *value, int flags)
+void simple_xattrs_free(struct simple_xattr_cache *cache, struct list_head *xattrs,
+			size_t *freed_space)
 {
-	struct simple_xattrs *xattrs;
-
-	xattrs = READ_ONCE(*xattrsp);
-	if (xattrs)
-		return xattrs;
-
-	if (!value)
-		return (flags & XATTR_REPLACE) ? ERR_PTR(-ENODATA) : NULL;
-
-	xattrs = simple_xattrs_alloc();
-	if (!IS_ERR(xattrs))
-		smp_store_release(xattrsp, xattrs);
-	return xattrs;
-}
+	if (freed_space)
+		*freed_space = 0;
 
-static void simple_xattr_ht_free(void *ptr, void *arg)
-{
-	struct simple_xattr *xattr = ptr;
-	size_t *freed_space = arg;
+	while (!list_empty(xattrs)) {
+		struct simple_xattr *xattr = list_first_entry(xattrs, typeof(*xattr), node);
 
-	if (freed_space)
-		*freed_space += simple_xattr_space(xattr->name, xattr->size);
-	simple_xattr_free(xattr);
+		rhashtable_remove_fast(cache->ht, &xattr->hash_node, simple_xattr_params);
+		list_del(&xattr->node);
+		if (freed_space)
+			*freed_space += simple_xattr_space(xattr->name, xattr->size);
+		simple_xattr_free(xattr);
+	}
 }
 
 /**
- * simple_xattrs_free - free xattrs
- * @xattrs: xattr header whose xattrs to destroy
- * @freed_space: approximate number of bytes of memory freed from @xattrs
+ * simple_xattr_cache_cleanup - free the cache
+ * @cache: anchor for the hash table
  *
- * Destroy all xattrs in @xattr. When this is called no one can hold a
- * reference to any of the xattrs anymore.
+ * Destroy the cache table, which was lazily allocated on adding the first xattr.
  */
-void simple_xattrs_free(struct simple_xattrs **xattrsp, size_t *freed_space)
+void simple_xattr_cache_cleanup(struct simple_xattr_cache *cache)
 {
-	struct simple_xattrs *xattrs = *xattrsp;
-
-	might_sleep();
-
-	if (!xattrs)
-		return;
-
-	if (freed_space)
-		*freed_space = 0;
-	rhashtable_free_and_destroy(&xattrs->ht, simple_xattr_ht_free,
-				    freed_space);
-	kfree(xattrs);
-	*xattrsp = NULL;
+	if (cache->ht) {
+		WARN_ON(atomic_read(&cache->ht->nelems));
+		rhashtable_destroy(cache->ht);
+		kfree(cache->ht);
+		cache->ht = NULL;
+	}
 }
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 93a0ba872ebe..69b0177da156 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -48,7 +48,7 @@ struct shmem_inode_info {
 	};
 	struct timespec64	i_crtime;	/* file creation time */
 	struct shared_policy	policy;		/* NUMA memory alloc policy */
-	struct simple_xattrs	*xattrs;	/* list of xattrs */
+	struct list_head        xattrs;		/* list of xattrs */
 	pgoff_t			fallocend;	/* highest fallocate endindex */
 	unsigned int		fsflags;	/* for FS_IOC_[SG]ETFLAGS */
 	atomic_t		stop_eviction;	/* hold when working on inode */
@@ -89,6 +89,7 @@ struct shmem_sb_info {
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
 	struct shmem_quota_limits qlimits; /* Default quota limits */
+	struct simple_xattr_cache xa_cache;
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index ded446c1ef81..a75b99eb1f04 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -106,13 +106,17 @@ static inline const char *xattr_prefix(const struct xattr_handler *handler)
 	return handler->prefix ?: handler->name;
 }
 
-struct simple_xattrs {
-	struct rhashtable ht;
+struct simple_xattr_cache {
+	struct rhashtable *ht;
 };
 
 struct simple_xattr {
 	struct rhash_head hash_node;
-	struct rcu_head rcu;
+	union {
+		struct list_head node;
+		struct rcu_head rcu;
+	};
+	struct list_head *parent;
 	char *name;
 	size_t size;
 	char value[] __counted_by(size);
@@ -132,27 +136,31 @@ static inline void simple_xattr_limits_init(struct simple_xattr_limits *limits)
 	atomic_set(&limits->xattr_size, 0);
 }
 
-int simple_xattrs_init(struct simple_xattrs *xattrs);
-void simple_xattrs_free(struct simple_xattrs **xattrs, size_t *freed_space);
+void simple_xattrs_free(struct simple_xattr_cache *cache, struct list_head *xattrs,
+			size_t *freed_space);
 size_t simple_xattr_space(const char *name, size_t size);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 void simple_xattr_free(struct simple_xattr *xattr);
 void simple_xattr_free_rcu(struct simple_xattr *xattr);
-int simple_xattr_get(struct simple_xattrs **xattrs, const char *name,
-		     void *buffer, size_t size);
-struct simple_xattr *simple_xattr_set(struct simple_xattrs **xattrs,
+int simple_xattr_get(struct simple_xattr_cache *cache, struct list_head *xattrs,
+		     const char *name, void *buffer, size_t size);
+struct simple_xattr *simple_xattr_set(struct simple_xattr_cache *cache,
+				      struct list_head *xattrs,
 				      const char *name, const void *value,
 				      size_t size, int flags);
-int simple_xattr_set_limited(struct simple_xattrs **xattrs,
+int simple_xattr_set_limited(struct simple_xattr_cache *cache,
+			     struct list_head *xattrs,
 			     struct simple_xattr_limits *limits,
 			     const char *name, const void *value,
 			     size_t size, int flags);
-ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrs,
+ssize_t simple_xattr_list(struct inode *inode, struct list_head *xattrs,
 			  char *buffer, size_t size);
-int simple_xattr_add(struct simple_xattrs **xattrs,
+int simple_xattr_add(struct simple_xattr_cache *cache, struct list_head *xattrs,
 		     struct simple_xattr *new_xattr);
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
 
+void simple_xattr_cache_cleanup(struct simple_xattr_cache *cache);
+
 DEFINE_CLASS(simple_xattr,
 	     struct simple_xattr *,
 	     if (!IS_ERR_OR_NULL(_T)) simple_xattr_free(_T),
diff --git a/mm/shmem.c b/mm/shmem.c
index 9b401a58ac0e..5ddea131a8f7 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1425,7 +1425,7 @@ static void shmem_evict_inode(struct inode *inode)
 		}
 	}
 
-	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
+	simple_xattrs_free(&sbinfo->xa_cache, &info->xattrs, sbinfo->max_inodes ? &freed : NULL);
 
 	shmem_free_inode(inode->i_sb, freed);
 	WARN_ON(inode->i_blocks);
@@ -3084,6 +3084,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	inode->i_generation = get_random_u32();
 	info = SHMEM_I(inode);
 	memset(info, 0, (char *)inode - (char *)info);
+	INIT_LIST_HEAD_RCU(&info->xattrs);
 	spin_lock_init(&info->lock);
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
@@ -4258,7 +4259,7 @@ static int shmem_initxattrs(struct inode *inode,
 		if (!new_xattr->name)
 			break;
 
-		if (simple_xattr_add(&info->xattrs, new_xattr))
+		if (simple_xattr_add(&sbinfo->xa_cache, &info->xattrs, new_xattr))
 			break;
 		retain_and_null_ptr(new_xattr);
 	}
@@ -4279,10 +4280,11 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 				   struct dentry *unused, struct inode *inode,
 				   const char *name, void *buffer, size_t size)
 {
+	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	struct shmem_inode_info *info = SHMEM_I(inode);
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_get(&info->xattrs, name, buffer, size);
+	return simple_xattr_get(&sbinfo->xa_cache, &info->xattrs, name, buffer, size);
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
@@ -4310,7 +4312,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 			return -ENOSPC;
 	}
 
-	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(&sbinfo->xa_cache, &info->xattrs, name, value, size, flags);
 	if (!IS_ERR(old_xattr)) {
 		ispace = 0;
 		if (old_xattr && sbinfo->max_inodes)
@@ -4959,6 +4961,9 @@ static void shmem_put_super(struct super_block *sb)
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
+#ifdef CONFIG_TMPFS_XATTR
+	simple_xattr_cache_cleanup(&sbinfo->xa_cache);
+#endif
 	kfree(sbinfo);
 	sb->s_fs_info = NULL;
 }
diff --git a/net/socket.c b/net/socket.c
index d3597c858345..a8014f930d9e 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -310,8 +310,10 @@ static int move_addr_to_user(struct sockaddr_storage *kaddr, int klen,
 
 static struct kmem_cache *sock_inode_cachep __ro_after_init;
 
+static struct simple_xattr_cache sockfs_xa_cache;
+
 struct sockfs_inode {
-	struct simple_xattrs *xattrs;
+	struct list_head xattrs;
 	struct simple_xattr_limits xattr_limits;
 	struct socket_alloc;
 };
@@ -328,7 +330,7 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 	si = alloc_inode_sb(sb, sock_inode_cachep, GFP_KERNEL);
 	if (!si)
 		return NULL;
-	si->xattrs = NULL;
+	INIT_LIST_HEAD_RCU(&si->xattrs);
 	simple_xattr_limits_init(&si->xattr_limits);
 
 	init_waitqueue_head(&si->socket.wq.wait);
@@ -348,7 +350,7 @@ static void sock_evict_inode(struct inode *inode)
 {
 	struct sockfs_inode *si = SOCKFS_I(inode);
 
-	simple_xattrs_free(&si->xattrs, NULL);
+	simple_xattrs_free(&sockfs_xa_cache, &si->xattrs, NULL);
 	clear_inode(inode);
 }
 
@@ -441,7 +443,7 @@ static int sockfs_user_xattr_get(const struct xattr_handler *handler,
 	const char *name = xattr_full_name(handler, suffix);
 	struct sockfs_inode *si = SOCKFS_I(inode);
 
-	return simple_xattr_get(&si->xattrs, name, value, size);
+	return simple_xattr_get(&sockfs_xa_cache, &si->xattrs, name, value, size);
 }
 
 static int sockfs_user_xattr_set(const struct xattr_handler *handler,
@@ -453,7 +455,7 @@ static int sockfs_user_xattr_set(const struct xattr_handler *handler,
 	const char *name = xattr_full_name(handler, suffix);
 	struct sockfs_inode *si = SOCKFS_I(inode);
 
-	return simple_xattr_set_limited(&si->xattrs, &si->xattr_limits,
+	return simple_xattr_set_limited(&sockfs_xa_cache, &si->xattrs, &si->xattr_limits,
 					name, value, size, flags);
 }
 
-- 
2.54.0

