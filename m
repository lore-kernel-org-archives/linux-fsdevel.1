Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48343DDDAE
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178420; cv=none; b=IILZBTTsBoDAvIgY8bkDhoUoJVvrlmkO1myXnXTdTwElQSzTyXZI3SRb63apHbqr83ActhOve+tKHg6BZHBXXd4Zisws+r0UrEthJEi+Wowtx9Y5+kqCRj1jamXMqOvieUigouv518O6aHpE8Y2+xCIjJMDzw8h5MNyo4cUV4oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178420; c=relaxed/simple;
	bh=yTvVp8jWCT/lznE3YlhFbCXiVPq0A1229+bzJ1qI6qo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7cVtac8Z86+eiQgjmHkwGLCSo1iEy79+Lj4Yi0rK3AS2sgDyRw2i8z9DlVHvl6Ju8GAdZ3e1SNQaEHurgOCAQjVZg3Pf3MKRZv5PPYJkc10OQO1IrDBApBzEbFdUfKyMsm0vxd6dloW/gg1x8pqVAyi9fcPfBiviWsvQA3mtoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MsAQ8Zot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CLTrt9bB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MsAQ8Zot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLTrt9bB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779178415;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HtAA+X9/Ge/BthibqzJEwtAdlF34UfbOedEu4CxVLpw=;
	b=MsAQ8ZotA7c+Qnkr/Qzr7SIR14w/fSr3m4aIHNwNmolcua/4NIK/dnpHbaNjbbG6ugg4r/
	ZKa4hSGBwnsaWNaWGqQwiY62VDXA5Tc8EwH5hBe3yl66/5l8hHgleonLiCQEX1o1YvV2B0
	r67D7J1Enevt7bddtSlbgFhc0FLEe1c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-170-A4uGAydSMJuKx8z-jr58aw-1; Tue, 19 May 2026 04:13:34 -0400
X-MC-Unique: A4uGAydSMJuKx8z-jr58aw-1
X-Mimecast-MFC-AGG-ID: A4uGAydSMJuKx8z-jr58aw_1779178413
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-4411a36715dso2040575f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 01:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779178413; x=1779783213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HtAA+X9/Ge/BthibqzJEwtAdlF34UfbOedEu4CxVLpw=;
        b=CLTrt9bBnH/77OLlTr+VQLSDyjQxOZuZFRMnRwvUoA585NgmSvQtmI9NKonnDUFQEm
         0ojbilY6iW8rUK5Zt6cmhJ0Yv+7PUSGYrcf4Tes/7vNAwpKCjvdtAFr2RQ6S1305ePd4
         pxSc5YySEtj8pMtXZl3YL4MKybijBk2xDjCKv/HfVq9dMDzS0R+V4qeTrAZmGQ+jDnfD
         ON/GJQm6btspJRoKpyeLCmmNYxWB6YvRqEcpYPfZM5ytaElORZ0AvyD89oPPnO26vdjD
         lg26OYAU0f6KVhCxu1dChrseg8I4NAO7FydouRs1x6O7r6jn0qj9JXsT4f6vW35NeJOT
         zlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178413; x=1779783213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HtAA+X9/Ge/BthibqzJEwtAdlF34UfbOedEu4CxVLpw=;
        b=DhBiYj1ewqJNoGRBVF5mh1MYrxWYyMpDhzZBcgLTzaog7QGN0mdMfoICvmrqILPLwh
         jDmxdEOwdtDWT+9KbmMITuP6YNhHXgrf3NnrI1lzW8TVL0FhVTu49+VVx6ul/1k/Qr1N
         7szseqUtw7JRYp1u4NZBc2hL34JW8XXMkeIV6tPxDFr+vr/6MhHsKiRLWQkA6wO5sS2e
         zUAZUVxQRT7NS4T1mD6lZ35qz9TDDmxakHqrTKgdDfqPahfHoqeBIv0r2cij0IBW2Vn+
         xD2Gep9CcK9mrhxdB0OqSnm4xx8yHS65h9/IGwUWIMBis2BukI2Ip1XZJDhkR/HwYRmt
         eBNQ==
X-Gm-Message-State: AOJu0YxA61hMLp+eYM8NDy15lp1dE2xEGVYoIWzOajEI8uHicUAo9DbB
	c/zor6LlPB9f4RWdj2SrLk+Om2bMZhD1Bp7WxMN9MvrIs9wIqkmWZjoncFZtKd1MlfdSnoz2Be5
	Eof9AhH7aD+DIZI/sLnql2K0nxfUA997KkJT2Z1jBaZQoY8y58KiOWL0tIUEVUcGkZH4D0s0zLI
	NebsDGlZsdVuA//SCN9PIHMX15oTliRP0nzsLKm8mjPvbzNDzDfhE=
X-Gm-Gg: Acq92OH/xSfxDpLVneSVchHlwWTP3EzJzbphAmGd43QQnvFvEBu8YleV22cMH84HN4r
	krGRYAgXmTa/dodnjZdriB9FpS8yYyh7YqjhXNlnr7Q5TARXPQVdTkACooIoiO4jcKBZ1Gna1xv
	CihTyHJItEfyxOI+F8ocRvwhfMEAiYV1vI4tNct2potZNyNuADEgiksBKwjqgVTYEHeJwiWirBE
	vGK/QT6eYKaDG2R40HZ391BiUGCP+hdDg0dZcoK7Tc/WdHPiENSHwZYh6pRYOymJVJZSOkoffcd
	u+8+5BdV4hEhiagiCJBCa14dPlsvZ00tdm/9T3bYEd3dt2b4oUeiUEdM/yWDHx0sxx5u1v3QBzk
	esOQeUdug40TJm+OPFqU4WfxfVoYBtDgwpFZ0UlVavI9Po8uy0lYU8KlTZSfcDUHD46uos+Goqs
	kL
X-Received: by 2002:a05:6000:1ac7:b0:43d:762e:76c6 with SMTP id ffacd0b85a97d-45e5c35da8fmr29620045f8f.7.1779178412391;
        Tue, 19 May 2026 01:13:32 -0700 (PDT)
X-Received: by 2002:a05:6000:1ac7:b0:43d:762e:76c6 with SMTP id ffacd0b85a97d-45e5c35da8fmr29619632f8f.7.1779178408291;
        Tue, 19 May 2026 01:13:28 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-173-121.pool.digikabel.hu. [85.67.173.121])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0fe2464sm45189485f8f.32.2026.05.19.01.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 01:13:27 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: linux-mm@kvack.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 2/3] simple_xattr: change interface to pass struct simple_xattrs **
Date: Tue, 19 May 2026 10:13:22 +0200
Message-ID: <20260519081324.979769-2-mszeredi@redhat.com>
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

Change the simple_xattr API to accept pointer-to-pointer (struct
simple_xattrs **) instead of pointer.  This allows the functions to handle
lazy allocation internally without requiring callers to use
simple_xattrs_lazy_alloc().

The simple_xattr_set(), simple_xattr_set_limited() and simple_xattr_add()
functions now handle allocation when xattrs is NULL.  simple_xattrs_free()
now also frees the xattrs structure itself and sets the pointer to NULL.

This simplifies callers and removes the need for most callers to explicitly
manage xattrs allocation and lifetime.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/kernfs/dir.c       | 12 +++--------
 fs/kernfs/inode.c     | 24 ++++------------------
 fs/pidfs.c            | 37 ++++++----------------------------
 fs/xattr.c            | 46 ++++++++++++++++++++++++++++++++++---------
 include/linux/xattr.h | 21 ++++++--------------
 mm/shmem.c            | 30 ++++++----------------------
 net/socket.c          | 24 +++++-----------------
 7 files changed, 67 insertions(+), 127 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 4f9ade82b08a..368dc4a217d9 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -605,11 +605,8 @@ void kernfs_put(struct kernfs_node *kn)
 	if (kernfs_type(kn) == KERNFS_LINK)
 		kernfs_put(kn->symlink.target_kn);
 
-	if (kn->iattr && kn->iattr->xattrs) {
-		simple_xattrs_free(kn->iattr->xattrs, NULL);
-		kfree(kn->iattr->xattrs);
-		kn->iattr->xattrs = NULL;
-	}
+	if (kn->iattr)
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 
 	spin_lock(&root->kernfs_idr_lock);
 	idr_remove(&root->ino_idr, (u32)kernfs_ino(kn));
@@ -709,10 +706,7 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 
  err_out4:
 	if (kn->iattr) {
-		if (kn->iattr->xattrs) {
-			simple_xattrs_free(kn->iattr->xattrs, NULL);
-			kfree(kn->iattr->xattrs);
-		}
+		simple_xattrs_free(&kn->iattr->xattrs, NULL);
 		kmem_cache_free(kernfs_iattrs_cache, kn->iattr);
 	}
  err_out3:
diff --git a/fs/kernfs/inode.c b/fs/kernfs/inode.c
index 38b28aa7cd02..65721b1b04f7 100644
--- a/fs/kernfs/inode.c
+++ b/fs/kernfs/inode.c
@@ -144,8 +144,7 @@ ssize_t kernfs_iop_listxattr(struct dentry *dentry, char *buf, size_t size)
 	if (!attrs)
 		return -ENOMEM;
 
-	return simple_xattr_list(d_inode(dentry), READ_ONCE(attrs->xattrs),
-				 buf, size);
+	return simple_xattr_list(d_inode(dentry), &attrs->xattrs, buf, size);
 }
 
 static inline void set_default_inode_attr(struct inode *inode, umode_t mode)
@@ -297,34 +296,24 @@ int kernfs_xattr_get(struct kernfs_node *kn, const char *name,
 		     void *value, size_t size)
 {
 	struct kernfs_iattrs *attrs = kernfs_iattrs_noalloc(kn);
-	struct simple_xattrs *xattrs;
 
 	if (!attrs)
 		return -ENODATA;
 
-	xattrs = READ_ONCE(attrs->xattrs);
-	if (!xattrs)
-		return -ENODATA;
-
-	return simple_xattr_get(xattrs, name, value, size);
+	return simple_xattr_get(&attrs->xattrs, name, value, size);
 }
 
 int kernfs_xattr_set(struct kernfs_node *kn, const char *name,
 		     const void *value, size_t size, int flags)
 {
 	struct simple_xattr *old_xattr;
-	struct simple_xattrs *xattrs;
 	struct kernfs_iattrs *attrs;
 
 	attrs = kernfs_iattrs(kn);
 	if (!attrs)
 		return -ENOMEM;
 
-	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return PTR_ERR(xattrs);
-
-	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(&attrs->xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
@@ -362,7 +351,6 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 {
 	const char *full_name = xattr_full_name(handler, suffix);
 	struct kernfs_node *kn = inode->i_private;
-	struct simple_xattrs *xattrs;
 	struct kernfs_iattrs *attrs;
 
 	if (!(kernfs_root(kn)->flags & KERNFS_ROOT_SUPPORT_USER_XATTR))
@@ -372,11 +360,7 @@ static int kernfs_vfs_user_xattr_set(const struct xattr_handler *handler,
 	if (!attrs)
 		return -ENOMEM;
 
-	xattrs = simple_xattrs_lazy_alloc(&attrs->xattrs, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return PTR_ERR(xattrs);
-
-	return simple_xattr_set_limited(xattrs, &attrs->xattr_limits,
+	return simple_xattr_set_limited(&attrs->xattrs, &attrs->xattr_limits,
 					full_name, value, size, flags);
 }
 
diff --git a/fs/pidfs.c b/fs/pidfs.c
index 1cce4f34a051..eb5105bddeca 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -196,12 +196,7 @@ static void pidfs_free_attr_work(struct work_struct *work)
 
 	head = llist_del_all(&pidfs_free_list);
 	llist_for_each_entry_safe(attr, next, head, pidfs_llist) {
-		struct simple_xattrs *xattrs = attr->xattrs;
-
-		if (xattrs) {
-			simple_xattrs_free(xattrs, NULL);
-			kfree(xattrs);
-		}
+		simple_xattrs_free(&attr->xattrs, NULL);
 		kfree(attr);
 	}
 }
@@ -815,14 +810,8 @@ static ssize_t pidfs_listxattr(struct dentry *dentry, char *buf, size_t size)
 {
 	struct inode *inode = d_inode(dentry);
 	struct pid *pid = inode->i_private;
-	struct pidfs_attr *attr = pid->attr;
-	struct simple_xattrs *xattrs;
-
-	xattrs = READ_ONCE(attr->xattrs);
-	if (!xattrs)
-		return 0;
 
-	return simple_xattr_list(inode, xattrs, buf, size);
+	return simple_xattr_list(inode, &pid->attr->xattrs, buf, size);
 }
 
 static const struct inode_operations pidfs_inode_operations = {
@@ -1057,16 +1046,9 @@ static int pidfs_xattr_get(const struct xattr_handler *handler,
 			   const char *suffix, void *value, size_t size)
 {
 	struct pid *pid = inode->i_private;
-	struct pidfs_attr *attr = pid->attr;
-	const char *name;
-	struct simple_xattrs *xattrs;
-
-	xattrs = READ_ONCE(attr->xattrs);
-	if (!xattrs)
-		return -ENODATA;
+	const char *name = xattr_full_name(handler, suffix);
 
-	name = xattr_full_name(handler, suffix);
-	return simple_xattr_get(xattrs, name, value, size);
+	return simple_xattr_get(&pid->attr->xattrs, name, value, size);
 }
 
 static int pidfs_xattr_set(const struct xattr_handler *handler,
@@ -1075,20 +1057,13 @@ static int pidfs_xattr_set(const struct xattr_handler *handler,
 			   const void *value, size_t size, int flags)
 {
 	struct pid *pid = inode->i_private;
-	struct pidfs_attr *attr = pid->attr;
-	const char *name;
-	struct simple_xattrs *xattrs;
+	const char *name = xattr_full_name(handler, suffix);
 	struct simple_xattr *old_xattr;
 
 	/* Ensure we're the only one to set @attr->xattrs. */
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	xattrs = simple_xattrs_lazy_alloc(&attr->xattrs, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return PTR_ERR(xattrs);
-
-	name = xattr_full_name(handler, suffix);
-	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(&pid->attr->xattrs, name, value, size, flags);
 	if (IS_ERR(old_xattr))
 		return PTR_ERR(old_xattr);
 
diff --git a/fs/xattr.c b/fs/xattr.c
index 09ecbaaa1660..9ef7ad8a8f32 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -1311,12 +1311,17 @@ static const struct rhashtable_params simple_xattr_params = {
  * Return: On success the length of the xattr value is returned. On error a
  * negative error code is returned.
  */
-int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
+int simple_xattr_get(struct simple_xattrs **xattrsp, const char *name,
 		     void *buffer, size_t size)
 {
+	struct simple_xattrs *xattrs;
 	struct simple_xattr *xattr;
 	int ret = -ENODATA;
 
+	xattrs = READ_ONCE(*xattrsp);
+	if (!xattrs)
+		return -ENODATA;
+
 	guard(rcu)();
 	xattr = rhashtable_lookup(&xattrs->ht, name, simple_xattr_params);
 	if (xattr) {
@@ -1331,6 +1336,9 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
 	return ret;
 }
 
+static struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
+						      const void *value, int flags);
+
 /**
  * simple_xattr_set - set an xattr object
  * @xattrs: the header of the xattr object
@@ -1362,13 +1370,18 @@ int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
  * Return: On success, the removed or replaced xattr is returned, to be freed
  * by the caller; or NULL if none. On failure a negative error code is returned.
  */
-struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
+struct simple_xattr *simple_xattr_set(struct simple_xattrs **xattrsp,
 				      const char *name, const void *value,
 				      size_t size, int flags)
 {
+	struct simple_xattrs *xattrs;
 	struct simple_xattr *old_xattr = NULL;
 	int err;
 
+	xattrs = simple_xattrs_lazy_alloc(xattrsp, value, flags);
+	if (IS_ERR_OR_NULL(xattrs))
+		return ERR_CAST(xattrs);
+
 	CLASS(simple_xattr, new_xattr)(value, size);
 	if (IS_ERR(new_xattr))
 		return new_xattr;
@@ -1467,7 +1480,7 @@ static inline int simple_xattr_limits_inc(struct simple_xattr_limits *limits,
  * Return: On success zero is returned. On failure a negative error code is
  * returned.
  */
-int simple_xattr_set_limited(struct simple_xattrs *xattrs,
+int simple_xattr_set_limited(struct simple_xattrs **xattrs,
 			     struct simple_xattr_limits *limits,
 			     const char *name, const void *value,
 			     size_t size, int flags)
@@ -1527,10 +1540,11 @@ static bool xattr_is_maclabel(const char *name)
  * Return: On success the required size or the size of the copied xattrs is
  * returned. On error a negative error code is returned.
  */
-ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
+ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrsp,
 			  char *buffer, size_t size)
 {
 	bool trusted = ns_capable_noaudit(&init_user_ns, CAP_SYS_ADMIN);
+	struct simple_xattrs *xattrs;
 	struct rhashtable_iter iter;
 	struct simple_xattr *xattr;
 	ssize_t remaining_size = size;
@@ -1552,6 +1566,7 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
 	remaining_size -= err;
 	err = 0;
 
+	xattrs = READ_ONCE(*xattrsp);
 	if (!xattrs)
 		return size - remaining_size;
 
@@ -1597,9 +1612,15 @@ ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
  * Return: On success zero is returned. On failure a negative error code is
  * returned.
  */
-int simple_xattr_add(struct simple_xattrs *xattrs,
+int simple_xattr_add(struct simple_xattrs **xattrsp,
 		     struct simple_xattr *new_xattr)
 {
+	struct simple_xattrs *xattrs;
+
+	xattrs = simple_xattrs_lazy_alloc(xattrsp, new_xattr->value, 0);
+	if (IS_ERR(xattrs))
+		return PTR_ERR(xattrs);
+
 	return rhashtable_insert_fast(&xattrs->ht, &new_xattr->hash_node,
 				      simple_xattr_params);
 }
@@ -1629,7 +1650,7 @@ int simple_xattrs_init(struct simple_xattrs *xattrs)
  * Return: On success a new simple_xattrs is returned. On failure an
  * ERR_PTR is returned.
  */
-struct simple_xattrs *simple_xattrs_alloc(void)
+static struct simple_xattrs *simple_xattrs_alloc(void)
 {
 	struct simple_xattrs *xattrs __free(kfree) = NULL;
 	int ret;
@@ -1661,8 +1682,8 @@ struct simple_xattrs *simple_xattrs_alloc(void)
  * check with IS_ERR_OR_NULL() and propagate with PTR_ERR() which
  * correctly returns 0 for the NULL no-op case.
  */
-struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
-					       const void *value, int flags)
+static struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
+						      const void *value, int flags)
 {
 	struct simple_xattrs *xattrs;
 
@@ -1697,12 +1718,19 @@ static void simple_xattr_ht_free(void *ptr, void *arg)
  * Destroy all xattrs in @xattr. When this is called no one can hold a
  * reference to any of the xattrs anymore.
  */
-void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space)
+void simple_xattrs_free(struct simple_xattrs **xattrsp, size_t *freed_space)
 {
+	struct simple_xattrs *xattrs = *xattrsp;
+
 	might_sleep();
 
+	if (!xattrs)
+		return;
+
 	if (freed_space)
 		*freed_space = 0;
 	rhashtable_free_and_destroy(&xattrs->ht, simple_xattr_ht_free,
 				    freed_space);
+	kfree(xattrs);
+	*xattrsp = NULL;
 }
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 8b6601367eae..ded446c1ef81 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -133,26 +133,23 @@ static inline void simple_xattr_limits_init(struct simple_xattr_limits *limits)
 }
 
 int simple_xattrs_init(struct simple_xattrs *xattrs);
-struct simple_xattrs *simple_xattrs_alloc(void);
-struct simple_xattrs *simple_xattrs_lazy_alloc(struct simple_xattrs **xattrsp,
-					       const void *value, int flags);
-void simple_xattrs_free(struct simple_xattrs *xattrs, size_t *freed_space);
+void simple_xattrs_free(struct simple_xattrs **xattrs, size_t *freed_space);
 size_t simple_xattr_space(const char *name, size_t size);
 struct simple_xattr *simple_xattr_alloc(const void *value, size_t size);
 void simple_xattr_free(struct simple_xattr *xattr);
 void simple_xattr_free_rcu(struct simple_xattr *xattr);
-int simple_xattr_get(struct simple_xattrs *xattrs, const char *name,
+int simple_xattr_get(struct simple_xattrs **xattrs, const char *name,
 		     void *buffer, size_t size);
-struct simple_xattr *simple_xattr_set(struct simple_xattrs *xattrs,
+struct simple_xattr *simple_xattr_set(struct simple_xattrs **xattrs,
 				      const char *name, const void *value,
 				      size_t size, int flags);
-int simple_xattr_set_limited(struct simple_xattrs *xattrs,
+int simple_xattr_set_limited(struct simple_xattrs **xattrs,
 			     struct simple_xattr_limits *limits,
 			     const char *name, const void *value,
 			     size_t size, int flags);
-ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs *xattrs,
+ssize_t simple_xattr_list(struct inode *inode, struct simple_xattrs **xattrs,
 			  char *buffer, size_t size);
-int simple_xattr_add(struct simple_xattrs *xattrs,
+int simple_xattr_add(struct simple_xattrs **xattrs,
 		     struct simple_xattr *new_xattr);
 int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name);
 
@@ -162,10 +159,4 @@ DEFINE_CLASS(simple_xattr,
 	     simple_xattr_alloc(value, size),
 	     const void *value, size_t size)
 
-DEFINE_CLASS(simple_xattrs,
-            struct simple_xattrs *,
-            if (!IS_ERR_OR_NULL(_T)) { simple_xattrs_free(_T, NULL); kfree(_T); },
-            simple_xattrs_alloc(),
-            void)
-
 #endif	/* _LINUX_XATTR_H */
diff --git a/mm/shmem.c b/mm/shmem.c
index c7897570fc9f..9b401a58ac0e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1425,10 +1425,8 @@ static void shmem_evict_inode(struct inode *inode)
 		}
 	}
 
-	if (info->xattrs) {
-		simple_xattrs_free(info->xattrs, sbinfo->max_inodes ? &freed : NULL);
-		kfree(info->xattrs);
-	}
+	simple_xattrs_free(&info->xattrs, sbinfo->max_inodes ? &freed : NULL);
+
 	shmem_free_inode(inode->i_sb, freed);
 	WARN_ON(inode->i_blocks);
 	clear_inode(inode);
@@ -4233,10 +4231,6 @@ static int shmem_initxattrs(struct inode *inode,
 	const struct xattr *xattr;
 	size_t ispace = 0;
 
-	CLASS(simple_xattrs, xattrs)();
-	if (IS_ERR(xattrs))
-		return PTR_ERR(xattrs);
-
 	if (sbinfo->max_inodes) {
 		for (xattr = xattr_array; xattr->name != NULL; xattr++) {
 			ispace += simple_xattr_space(xattr->name,
@@ -4264,7 +4258,7 @@ static int shmem_initxattrs(struct inode *inode,
 		if (!new_xattr->name)
 			break;
 
-		if (simple_xattr_add(xattrs, new_xattr))
+		if (simple_xattr_add(&info->xattrs, new_xattr))
 			break;
 		retain_and_null_ptr(new_xattr);
 	}
@@ -4278,7 +4272,6 @@ static int shmem_initxattrs(struct inode *inode,
 		return -ENOMEM;
 	}
 
-	smp_store_release(&info->xattrs, no_free_ptr(xattrs));
 	return 0;
 }
 
@@ -4287,14 +4280,9 @@ static int shmem_xattr_handler_get(const struct xattr_handler *handler,
 				   const char *name, void *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct simple_xattrs *xattrs;
-
-	xattrs = READ_ONCE(info->xattrs);
-	if (!xattrs)
-		return -ENODATA;
 
 	name = xattr_full_name(handler, name);
-	return simple_xattr_get(xattrs, name, buffer, size);
+	return simple_xattr_get(&info->xattrs, name, buffer, size);
 }
 
 static int shmem_xattr_handler_set(const struct xattr_handler *handler,
@@ -4305,16 +4293,11 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 {
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
-	struct simple_xattrs *xattrs;
 	struct simple_xattr *old_xattr;
 	size_t ispace = 0;
 
 	name = xattr_full_name(handler, name);
 
-	xattrs = simple_xattrs_lazy_alloc(&info->xattrs, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return PTR_ERR(xattrs);
-
 	if (value && sbinfo->max_inodes) {
 		ispace = simple_xattr_space(name, size);
 		raw_spin_lock(&sbinfo->stat_lock);
@@ -4327,7 +4310,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 			return -ENOSPC;
 	}
 
-	old_xattr = simple_xattr_set(xattrs, name, value, size, flags);
+	old_xattr = simple_xattr_set(&info->xattrs, name, value, size, flags);
 	if (!IS_ERR(old_xattr)) {
 		ispace = 0;
 		if (old_xattr && sbinfo->max_inodes)
@@ -4375,8 +4358,7 @@ static ssize_t shmem_listxattr(struct dentry *dentry, char *buffer, size_t size)
 {
 	struct shmem_inode_info *info = SHMEM_I(d_inode(dentry));
 
-	return simple_xattr_list(d_inode(dentry), READ_ONCE(info->xattrs),
-				 buffer, size);
+	return simple_xattr_list(d_inode(dentry), &info->xattrs, buffer, size);
 }
 #endif /* CONFIG_TMPFS_XATTR */
 
diff --git a/net/socket.c b/net/socket.c
index 22a412fdec07..d3597c858345 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -347,12 +347,8 @@ static struct inode *sock_alloc_inode(struct super_block *sb)
 static void sock_evict_inode(struct inode *inode)
 {
 	struct sockfs_inode *si = SOCKFS_I(inode);
-	struct simple_xattrs *xattrs = si->xattrs;
 
-	if (xattrs) {
-		simple_xattrs_free(xattrs, NULL);
-		kfree(xattrs);
-	}
+	simple_xattrs_free(&si->xattrs, NULL);
 	clear_inode(inode);
 }
 
@@ -443,13 +439,9 @@ static int sockfs_user_xattr_get(const struct xattr_handler *handler,
 				 const char *suffix, void *value, size_t size)
 {
 	const char *name = xattr_full_name(handler, suffix);
-	struct simple_xattrs *xattrs;
-
-	xattrs = READ_ONCE(SOCKFS_I(inode)->xattrs);
-	if (!xattrs)
-		return -ENODATA;
+	struct sockfs_inode *si = SOCKFS_I(inode);
 
-	return simple_xattr_get(xattrs, name, value, size);
+	return simple_xattr_get(&si->xattrs, name, value, size);
 }
 
 static int sockfs_user_xattr_set(const struct xattr_handler *handler,
@@ -460,13 +452,8 @@ static int sockfs_user_xattr_set(const struct xattr_handler *handler,
 {
 	const char *name = xattr_full_name(handler, suffix);
 	struct sockfs_inode *si = SOCKFS_I(inode);
-	struct simple_xattrs *xattrs;
-
-	xattrs = simple_xattrs_lazy_alloc(&si->xattrs, value, flags);
-	if (IS_ERR_OR_NULL(xattrs))
-		return PTR_ERR(xattrs);
 
-	return simple_xattr_set_limited(xattrs, &si->xattr_limits,
+	return simple_xattr_set_limited(&si->xattrs, &si->xattr_limits,
 					name, value, size, flags);
 }
 
@@ -635,8 +622,7 @@ static ssize_t sockfs_listxattr(struct dentry *dentry, char *buffer,
 	struct sockfs_inode *si = SOCKFS_I(d_inode(dentry));
 	ssize_t len, used;
 
-	len = simple_xattr_list(d_inode(dentry), READ_ONCE(si->xattrs),
-				buffer, size);
+	len = simple_xattr_list(d_inode(dentry), &si->xattrs, buffer, size);
 	if (len < 0)
 		return len;
 
-- 
2.54.0

