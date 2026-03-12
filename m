Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB7139EF22
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344436; cv=none; b=k3DM1IuinhTcagniD+PW+GbzSGukyZoQmUYRQ8Vh54JZ3iP+eYk99AJWpmglIesXh/aNxw7PBmUWPQJylzZdlosNQd/UuqoLZ7d18feLTPk92xDQxv+HuYYgVMBPIKOivWYdO3mv31uP6EXsRrY0F/xkjz/lwjAxWkTrNx6Bma0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344436; c=relaxed/simple;
	bh=CR/HYRdoPbLoCLH7nM01lCyJmhfgLSu4+yvpayokAsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aMF0/oIVX8HQZd/aQ+uWiOdFPgQicpoeavmvHafq4C0jXujWTURX/5pi4aiR9ELsXGEQQ6ba9QRwq9PdYHItzgr8zVA1rGkqIqvYmZ9wK/bDOnpjJJpRLeoRprHeu0zp3T6bsocTYDjCu9OGGC6YlecAaXVexuUdS/yPM7IckNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FqdANyXh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=km9tq0QG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqdANyXh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="km9tq0QG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTVUwBEWEQQOE3fZufW3bJCpzqXyOehSRDCacJU2QOE=;
	b=FqdANyXhO9at6/5pUKef6abeGfPpOFv4n1trhWejlRsAxtSdvs3zvVEQF+JWHxzlDWdsOn
	1bSe6PkiaKidH6SMIYAfB/MyM8poIW56Yt0noRp+JGM2L3m2pHlfGqtzfRM9DKKUrVrj8B
	0NVpaLgdgej55qTvmbKH7L8fKImfGOU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-8UnRN1o8OdKZu4yWThsfGA-1; Thu, 12 Mar 2026 15:40:30 -0400
X-MC-Unique: 8UnRN1o8OdKZu4yWThsfGA-1
X-Mimecast-MFC-AGG-ID: 8UnRN1o8OdKZu4yWThsfGA_1773344429
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853553944fso17666755e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344429; x=1773949229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTVUwBEWEQQOE3fZufW3bJCpzqXyOehSRDCacJU2QOE=;
        b=km9tq0QGFv0zjyNSlYMFc4uqEeE4iptV2gt/WElIIVs6i51f1MjXET+XcQsq5zhE6w
         fB5r1piwHtDSfnnxrzBIpBMphOitZfMfkYn5AstLKxAkAjiGmbqTJKAnjJVxZ/ZQs248
         5UsM5TyTb+ATWsnB90oCR+Wqx8H7sKnIlPLMObIS1wYFLj3ZO8EEAzTpci8crBFep0Y/
         Tvu08m0TtQISLT138GXsvNXFlUy/gUx8UbC+0mHu8lINq8kcDDuHfPquHHsasCxwMcsJ
         2opZBK+XxwJgyaNmeK1I3UOP5VpWwZV5NaWTnwQar3sGmCFBcagqiXfSNRJccr5lOTVI
         KgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344429; x=1773949229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KTVUwBEWEQQOE3fZufW3bJCpzqXyOehSRDCacJU2QOE=;
        b=vjo+Ys1cnEcFCQXuqXUkD4FNenUrHlTLhwXhiuB3SyN3arrT5UiDyce7k2qvO3okLg
         UtGQm6mr6B5OpPx9wfnAvUTqmrUPgTXukcos23LovLOlvP3DCOwji5GUc1JWOGZ3yswI
         kL/sLCY3qxUvef6V4oi25+Y/IWTS+itH3J+t+19o1qQaRzZ9f83J7YX0nvsa04C5qlEo
         yxiXL++KMw9LLwFz07jrXzrMwhacRlMNF8sGYe4rTAppviVN5CYcrbjQWcTWM8zH4KDK
         yEr9PUFOe+I9eRY3LYWYG+Z2EKNrvLbQfZ4mILBBNoNsMskpyFMunNm3Vfvj4ufqaAzT
         SC5Q==
X-Gm-Message-State: AOJu0YwGTgRgB4RwHIF3B1Acs6bh451vrhUp7PG+3ssPIOF7XzmnrOZQ
	95FmKoFn0uItoCIQiFlIWh3CEGe3yFie9ouNpa4oBlexkUSuSOugMcmdVwakFLnadNs6sBYKws7
	UFuEtEmlTkT7TVLl4xCRlcIUdoEmpYS5sVW5syVQiRRcymTNYkTkIY64qfIX5nWy4pTI2zY13Z7
	d3BALWumQ2I+lI7yR7W8gPnESObTE5wWbZgGDVzMGwEigCaWEUkHE=
X-Gm-Gg: ATEYQzx9gc5D5Oq4cvs0MArOfffGsC9qfiGkmLAgOWku4yzkXN7tOHXP70jfsbU+Sgr
	ck8Qv6CGn19KhKiB28jI7f69AN/wwsSl1IDoUMG+HQbSG259UF85MW4vMf0r2o1kRCIhkpnO8NO
	0JJvT11K4mD6MpiMmBdHIvZWFfvauxRdiTCUznccai+nI9hRZs6zs3Q8R6ayHz+Pzknh7mFMDNS
	i6LBg/OdXC5gIKaAdOhTcZrHwRu9UERorEqcY9BCyvm9K6cXt3hVGwr4psKfttz6aubQxB/ZFcn
	9Bb5hkQNmlIURiTjEMHVaHIC5jgfy1sUSya6riVUlijfcea85/PrU0MHHFaAv65mqn2HxlSWPSq
	OtX4I85DxP3h5NwjTW5e782ixVHtS9FsLNpLOCkdA2X7Nlsm0oeq9O3s4Iwr0qGVS1q0kjJRWW8
	2I3PY=
X-Received: by 2002:a05:600c:8b18:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-48555b47c4dmr13935415e9.15.1773344428747;
        Thu, 12 Mar 2026 12:40:28 -0700 (PDT)
X-Received: by 2002:a05:600c:8b18:b0:479:13e9:3d64 with SMTP id 5b1f17b1804b1-48555b47c4dmr13934945e9.15.1773344428234;
        Thu, 12 Mar 2026 12:40:28 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:27 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 5/6] fuse: alloc pqueue before installing fc
Date: Thu, 12 Mar 2026 20:40:03 +0100
Message-ID: <20260312194019.3077902-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312194019.3077902-1-mszeredi@redhat.com>
References: <20260312194019.3077902-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prior to this patchset, fuse_dev (containing fuse_pqueue) was allocated on
mount.  But now fuse_dev is allocated when opening /dev/fuse, even though
the queues are not needed at that time.

Delay allocation of the pqueue (4k worth of list_head) just before mounting
or cloning a device.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c       |  9 ++++++--
 fs/fuse/dev_uring.c |  2 +-
 fs/fuse/fuse_i.h    |  5 +++--
 fs/fuse/inode.c     | 51 +++++++++++++++++++++++++++++----------------
 fs/fuse/virtio_fs.c |  4 ++--
 5 files changed, 46 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 18cc844cf290..4d11750addbe 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1542,7 +1542,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 static int fuse_dev_open(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = fuse_dev_alloc();
+	struct fuse_dev *fud = fuse_dev_alloc(false);
 
 	if (!fud)
 		return -ENOMEM;
@@ -2574,6 +2574,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
 	int oldfd;
 	struct fuse_dev *fud, *new_fud;
+	struct list_head *pq;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2593,8 +2594,12 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 	if (!fud)
 		return -EINVAL;
 
+	pq = fuse_pqueue_alloc();
+	if (!pq)
+		return -ENOMEM;
+
 	new_fud = fuse_file_to_fud(file);
-	if (!fuse_dev_install(new_fud, fud->fc))
+	if (!fuse_dev_install(new_fud, fud->fc, pq))
 		return -EINVAL;
 
 	return 0;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..fb4f21c871fb 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -277,7 +277,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
 	if (!queue)
 		return NULL;
-	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
+	pq = fuse_pqueue_alloc();
 	if (!pq) {
 		kfree(queue);
 		return NULL;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 92576e28f8ac..eaeda2f097dc 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1337,8 +1337,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 void fuse_conn_put(struct fuse_conn *fc);
 
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
-struct fuse_dev *fuse_dev_alloc(void);
-bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
+struct list_head *fuse_pqueue_alloc(void);
+struct fuse_dev *fuse_dev_alloc(bool alloc_pq);
+bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc, struct list_head *pq);
 void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e42356d60f7a..f951f8d69e47 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -977,15 +977,22 @@ static void fuse_iqueue_init(struct fuse_iqueue *fiq,
 
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
-	unsigned int i;
-
 	spin_lock_init(&fpq->lock);
-	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-		INIT_LIST_HEAD(&fpq->processing[i]);
 	INIT_LIST_HEAD(&fpq->io);
 	fpq->connected = 1;
 }
 
+struct list_head *fuse_pqueue_alloc(void)
+{
+	struct list_head *pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
+
+	if (pq) {
+		for (int i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+			INIT_LIST_HEAD(&pq[i]);
+	}
+	return pq;
+}
+
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 		    struct user_namespace *user_ns,
 		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv)
@@ -1632,33 +1639,38 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	return 0;
 }
 
-struct fuse_dev *fuse_dev_alloc(void)
+struct fuse_dev *fuse_dev_alloc(bool alloc_pq)
 {
 	struct fuse_dev *fud;
-	struct list_head *pq;
+	struct list_head *pq __free(kfree) = NULL;
+
+	if (alloc_pq) {
+		pq = fuse_pqueue_alloc();
+		if (!pq)
+			return NULL;
+	}
 
 	fud = kzalloc_obj(struct fuse_dev);
 	if (!fud)
 		return NULL;
 
 	refcount_set(&fud->ref, 1);
-	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
-	if (!pq) {
-		kfree(fud);
-		return NULL;
-	}
-
-	fud->pq.processing = pq;
+	fud->pq.processing = no_free_ptr(pq);
 	fuse_pqueue_init(&fud->pq);
 
 	return fud;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
-bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
+bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc, struct list_head *pq)
 {
 	struct fuse_conn *old_fc;
 
+	if (!pq)
+		WARN_ON(!fud->pq.processing);
+	else if (cmpxchg(&fud->pq.processing, NULL, pq))
+		kfree(pq);
+
 	fuse_conn_get(fc);
 	spin_lock(&fc->lock);
 	/*
@@ -1686,13 +1698,12 @@ EXPORT_SYMBOL_GPL(fuse_dev_install);
 
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
 {
-	struct fuse_dev *fud;
+	struct fuse_dev *fud = fuse_dev_alloc(true);
 
-	fud = fuse_dev_alloc();
 	if (!fud)
 		return NULL;
 
-	fuse_dev_install(fud, fc);
+	fuse_dev_install(fud, fc, NULL);
 	return fud;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
@@ -1869,10 +1880,14 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	struct fuse_dev *fud = ctx->fud;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
+	struct list_head *pq __free(kfree) = fuse_pqueue_alloc();
 	struct inode *root;
 	struct dentry *root_dentry;
 	int err;
 
+	if (!pq)
+		return -ENOMEM;
+
 	err = -EINVAL;
 	if (sb->s_flags & SB_MANDLOCK)
 		goto err;
@@ -1944,7 +1959,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
 	if (fud) {
-		if (!fuse_dev_install(fud, fc))
+		if (!fuse_dev_install(fud, fc, no_free_ptr(pq)))
 			fc->connected = 0; /* device file got closed */
 		else
 			wake_up_all(&fuse_dev_waitq);
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 12300651a0f1..cc6426992ecd 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1585,7 +1585,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-		fsvq->fud = fuse_dev_alloc();
+		fsvq->fud = fuse_dev_alloc(true);
 		if (!fsvq->fud)
 			goto err_free_fuse_devs;
 	}
@@ -1606,7 +1606,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-		fuse_dev_install(fsvq->fud, fc);
+		fuse_dev_install(fsvq->fud, fc, NULL);
 	}
 
 	/* Previous unmount will stop all queues. Start these again */
-- 
2.53.0

