Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE793DB324
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 15:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780327421; cv=none; b=SKjL+vLoUhfmPpEFeLARmf7cGc/853vZ/IThjcxVwI63w7j+zTh0Cke3JW0KXR5cQImrrUHrdATFlLqfqZOMJheo5PgadknNVzrX5bOFmdT+F9i7oDGrhAJN6awHVo/uthfK4iyCn5lyOK5Qx0hbBlqcCsDhCjgBAAMV7KWBl38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780327421; c=relaxed/simple;
	bh=a59E96RrLt/QrzSX8t0sThXtJvlE6fYA2T46kXhbG98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u5iloJQndB0nINyd/kh/q+sRPpQUBr5iHoANHl3zR5w3+dPM0JZ+3iWTw8bGrOuFv9otlmCV4vYLimP2Cqx4VNV6vPyZbQHm6AyvPt33AYDhzZz8KacjlUkr9jU+RNevv2J1PvHvMw60AcL8IKcTROBkz4jWiHQkuKU1EAY22dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CSlzJ6Ms; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=sGw6chV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSlzJ6Ms";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="sGw6chV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780327412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fXAcMFoMzcsb9TnsH3R4FVx/dV3JAforQW3Xv9fTcQg=;
	b=CSlzJ6MsmLH7AechFEhPTXrwZqIgIPwDVbPfyjszhdcZnpiUJCgfT57E3FGO7Un8xMuvWe
	3LGIAABPyBFnz9znUuec4ZfScRQDJat8Lo+V2REPcNmwBwt8/GBnOnEVlk/52DEmn5joZl
	tGesxoElg/40PS2zAVr6j3iZgXTHuxY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-1NgHw1BOOtSJ-LvY7oQKDA-1; Mon, 01 Jun 2026 11:23:31 -0400
X-MC-Unique: 1NgHw1BOOtSJ-LvY7oQKDA-1
X-Mimecast-MFC-AGG-ID: 1NgHw1BOOtSJ-LvY7oQKDA_1780327410
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490a762e646so14187405e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Jun 2026 08:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780327410; x=1780932210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fXAcMFoMzcsb9TnsH3R4FVx/dV3JAforQW3Xv9fTcQg=;
        b=sGw6chV/sRtaqIFewPTusxm8RtRYQfcU6gml81aLZzNsmAaSDi//cz53c4UptwKY9Z
         nCFeYePcqC9B+YxxEZGB25HS5Er7K0dfcnYDQHexpXL/2ND6FMhkPQd3rBzvbMvEvPZz
         0C4n++vT5Fx52KQHPrrfh3zED5HA5r5gzjw19l64RQSVZL792s1B4h0VYMRAktUZqPQL
         zjlXc3gLMfLeFph9gTOf0IIFQ50Cy9/pEz5kHqZjsx2W+LzdBm8LBLrW2B74dlQ6STIy
         gN1alGNCXJbnjCLsVc6dYfrAYu55SvEcei6WMvhmxebYjfFpeQcrZpmp4FmBUTBc3iJ+
         tOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780327410; x=1780932210;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fXAcMFoMzcsb9TnsH3R4FVx/dV3JAforQW3Xv9fTcQg=;
        b=KfvvaaInmAtf8t2FUR6mAOlTZfnXwLbcfEwj2XDd+0GuCyIFuICZeI8dUDj/ogGGRs
         6OzWNoC2yl4Ae45mqooX0IREj6qo0IKFvmDiok1yB0U0CE7jvvkCVT7IBoJz4aa4TtUG
         EPasDXBhrdaD2meUx7SKW24cHGmwLOYhglj9JGXcKJrdGVzq3HtQjJrPJjMEYY9qVEEw
         b7aj4W54H4Nh1XjY6ZtmE064H8gJ1Y76kRh5EjgEwxBSY+mYovZu4thNQHOqOs2d+Qgx
         3gAxgOjOvaQtwsZL+TXAteZXwkB1YohjSWxGlPTfk2EIbKs5yEUN+42NAVzluloxqBTv
         eSkw==
X-Forwarded-Encrypted: i=1; AFNElJ+ggsm64VhPzRDhqKyHgEyLcx3hvqep5encm+sJnuLKmmP+ISzkTTmhaFrmDeEgx4XUfHdXJPaO3TwS4eC3@vger.kernel.org
X-Gm-Message-State: AOJu0YwMDPH4ZRV4ORx0cXZA5ggizNI6YK7bZ9yCdM+U7G6o3pjF1sKq
	J6T3ptyBo65H4N4B3BRqjGRpefuf9ZLFjG5mUQPyZYbaCKYS9TWGnwIYh2WR3aMnlQQX9zR/Zc+
	gYUNDTB6rlEAMM8zbzYfWoV8/DGY5sbYFsfgyF8R9My8QIV4MvpbjvUgvZwB8CC4QXrs=
X-Gm-Gg: Acq92OEE87wKIVE+JxNRyD2+fsW72DpS8leD36Z7WArlx2kFDIkU70eqDqmtJ7m0LeF
	QIB0qJi+vlCKWFjEhRoYfPB6ZX08aXKEAvcVgm91YrJpHBBVo6c73kZRbLTbcQttbWvrKmRvBKV
	nh2KiwG6vUy/qe5PJqE0tdaA3Ix1iYePKBxh5zog4pJPLNOI9zyYwLbkG3xcrUMcyjgfbzuiKLO
	7yD5fHySdjUx5VUoHOnpY64UiaMJnwcDB1GLlmUev7lUfpVI3u/pkW8tVOAThtzquOQo1eN3RG7
	ft4WbtssqixZBABl17cUievpBlAkdtB20scG4CoBcc5qNPBfVoFK0Jy/doODJVulKOZv2M7uOim
	Sxa/KESERxwsgLidWL0rVU2qX/iL/8FIIBwaHfmdQIWizguaMurgkhM/lZdtT7uPRS9RO79jQAx
	oD+L7ZANDvMx8=
X-Received: by 2002:a05:600c:4fd3:b0:48f:e230:d5ab with SMTP id 5b1f17b1804b1-490b0704533mr8847025e9.31.1780327409605;
        Mon, 01 Jun 2026 08:23:29 -0700 (PDT)
X-Received: by 2002:a05:600c:4fd3:b0:48f:e230:d5ab with SMTP id 5b1f17b1804b1-490b0704533mr8846105e9.31.1780327408793;
        Mon, 01 Jun 2026 08:23:28 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (78-131-46-194.pool.digikabel.hu. [78.131.46.194])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a065esm26789306f8f.5.2026.06.01.08.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 08:23:28 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: John Groves <jgroves@micron.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>,
	fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
Date: Mon,  1 Jun 2026 17:23:24 +0200
Message-ID: <20260601152327.2069787-1-mszeredi@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add striped "virtual" backing devices (idea from Darrick).

This decouples interleaving from extents, since the interleaving is
configured on the striped backing device, while simple extents select which
striped device is to be used and the length/offset within that virtual
device.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---

This is the second part of what we were talking about: using the backing
API for striping.

It's on top of the famfs-v10 patchset + the FUSE_BACKING_DAXDEV patch

Totally Untested (TM).

The third part will be to use the fuse-iomap uAPI (and just the API, not
any of the code) from Darrick to describe the simple extents themselves.

And that should be it.  Just some review and testing and I'll be happy to
move this into fuse-next.

Thanks,
Miklos

 fs/fuse/backing.c         | 108 +++++++++-----
 fs/fuse/dev.c             |  38 +++++
 fs/fuse/famfs.c           | 296 +++++++++-----------------------------
 fs/fuse/famfs_kfmap.h     |  25 +---
 fs/fuse/fuse_i.h          |  23 ++-
 include/uapi/linux/fuse.h |  29 ++--
 6 files changed, 219 insertions(+), 300 deletions(-)

diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
index e56b7f8d5d2b..d680a01c9f38 100644
--- a/fs/fuse/backing.c
+++ b/fs/fuse/backing.c
@@ -37,14 +37,14 @@ void fuse_backing_files_init(struct fuse_conn *fc)
 	idr_init(&fc->backing_files_map);
 }
 
-int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj)
+int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing_common *backing)
 {
 	int id;
 
 	idr_preload(GFP_KERNEL);
 	spin_lock(&fc->lock);
 	/* FIXME: xarray might be space inefficient */
-	id = idr_alloc_cyclic(&fc->backing_files_map, obj, 1, 0, GFP_ATOMIC);
+	id = idr_alloc_cyclic(&fc->backing_files_map, backing, 1, 0, GFP_ATOMIC);
 	spin_unlock(&fc->lock);
 	idr_preload_end();
 
@@ -52,33 +52,43 @@ int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj)
 	return id;
 }
 
-static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
-						   int id)
+static void fuse_backing_file_free(struct fuse_backing_common *backing)
 {
-	struct fuse_backing *fb;
+	struct fuse_backing *fb = container_of(backing, typeof(*fb), backing);
 
-	spin_lock(&fc->lock);
-	fb = idr_remove(&fc->backing_files_map, id);
-	spin_unlock(&fc->lock);
+	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
+	fuse_backing_free(fb);
+}
 
-	return fb;
+static void fuse_stripe_free(struct fuse_backing_common *backing)
+{
+	struct fuse_backing_stripe *bstripe = container_of(backing, typeof(*bstripe), backing);
+
+	kfree(bstripe->stripe);
+	kfree(bstripe);
 }
 
 static int fuse_backing_id_free(int id, void *p, void *data)
 {
-	struct fuse_backing *fb = p;
-
-	WARN_ON_ONCE(refcount_read(&fb->count) != 1);
-	fuse_backing_free(fb);
+	struct fuse_backing_common *backing = p;
+
+        switch (backing->type) {
+	case FUSE_BCK_FILE:
+		fuse_backing_file_free(backing);
+		break;
+	case FUSE_BCK_DAXDEV:
+		famfs_devidx_free(backing);
+		break;
+	case FUSE_BCK_STRIPE:
+		fuse_stripe_free(backing);
+		break;
+	}
 	return 0;
 }
 
 void fuse_backing_files_free(struct fuse_conn *fc)
 {
-	if (fc->famfs_iomap)
-		famfs_teardown(fc);
-	else
-		idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
+	idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
 	idr_destroy(&fc->backing_files_map);
 }
 
@@ -130,11 +140,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (!fb)
 		goto out_fput;
 
+	fb->backing.type = FUSE_BCK_FILE;
 	fb->file = file;
 	fb->cred = prepare_creds();
 	refcount_set(&fb->count, 1);
 
-	res = fuse_backing_id_alloc(fc, fb);
+	res = fuse_backing_id_alloc(fc, &fb->backing);
 	if (res < 0) {
 		fuse_backing_free(fb);
 		fb = NULL;
@@ -150,30 +161,54 @@ int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	goto out;
 }
 
+int fuse_stripe_open(struct fuse_conn *fc, struct fuse_stripe *stripe)
+{
+	int res;
+	struct fuse_backing_stripe *bstripe __free(kfree) = kmalloc_obj(*bstripe);
+
+	if (!bstripe)
+		return -ENOMEM;
+
+	bstripe->backing.type = FUSE_BCK_STRIPE;
+	bstripe->stripe = stripe;
+
+	res = fuse_backing_id_alloc(fc, &bstripe->backing);
+	if (res >= 0)
+		retain_and_null_ptr(bstripe);
+
+	return res;
+}
+
 int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 {
+	struct fuse_backing_common *backing;
 	struct fuse_backing *fb = NULL;
 	int err;
 
 	pr_debug("%s: backing_id=%d\n", __func__, backing_id);
 
-	/* No close for dax device (yet) */
-	if (fc->famfs_iomap)
-		return -EINVAL;
-
-	/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
-	err = -EPERM;
-	if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
-		goto out;
-
 	err = -EINVAL;
 	if (backing_id <= 0)
 		goto out;
 
-	err = -ENOENT;
-	fb = fuse_backing_id_remove(fc, backing_id);
-	if (!fb)
-		goto out;
+	scoped_guard(spinlock, &fc->lock) {
+		err = -ENOENT;
+		backing = idr_find(&fc->backing_files_map, backing_id);
+		if (!backing)
+			goto out;
+		err = -EINVAL;
+		if (backing->type != FUSE_BCK_FILE)
+			goto out;
+
+		fb = container_of(backing, typeof(*fb), backing);
+
+		/* TODO: relax CAP_SYS_ADMIN once backing files are visible to lsof */
+		err = -EPERM;
+		if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
+			goto out;
+
+		WARN_ON(idr_remove(&fc->backing_files_map, backing_id) != backing);
+	}
 
 	fuse_backing_put(fb);
 	err = 0;
@@ -185,14 +220,13 @@ int fuse_backing_close(struct fuse_conn *fc, int backing_id)
 
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id)
 {
-	struct fuse_backing *fb;
-
-	if (fc->famfs_iomap)
-		return NULL;
+	struct fuse_backing_common *backing;
+	struct fuse_backing *fb = NULL;
 
 	rcu_read_lock();
-	fb = idr_find(&fc->backing_files_map, backing_id);
-	fb = fuse_backing_get(fb);
+	backing = idr_find(&fc->backing_files_map, backing_id);
+	if (backing && backing->type == FUSE_BCK_FILE)
+		fb = fuse_backing_get(container_of(backing, typeof(*fb), backing));
 	rcu_read_unlock();
 
 	return fb;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 0b0241f47170..dd80a174124d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2636,6 +2636,41 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	return fuse_backing_open(fud->fc, &map);
 }
 
+
+static long fuse_dev_ioctl_stripe_open(struct file *file, struct fuse_stripe __user *argp)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_stripe hdr;
+	size_t size;
+	int backing_id;
+
+	if (IS_ERR(fud))
+		return PTR_ERR(fud);
+
+	if (!IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
+		return -EOPNOTSUPP;
+
+	if (copy_from_user(&hdr, argp, sizeof(hdr)))
+		return -EFAULT;
+
+	if (hdr.nr_strips > FUSE_STRIPS_MAX)
+		return -EINVAL;
+
+	size = offsetof(struct fuse_stripe, strips[hdr.nr_strips]);
+	struct fuse_stripe *stripe __free(kfree) = kmalloc(size, GFP_KERNEL_ACCOUNT);
+	if (!stripe)
+		return -ENOMEM;
+
+	if (copy_from_user(stripe, argp, size))
+		return -EFAULT;
+
+	backing_id = fuse_stripe_open(fud->fc, stripe);
+	if (backing_id >= 0)
+		retain_and_null_ptr(stripe);
+
+	return backing_id;
+}
+
 static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
@@ -2678,6 +2713,9 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	case FUSE_DEV_IOC_BACKING_OPEN:
 		return fuse_dev_ioctl_backing_open(file, argp);
 
+	case FUSE_DEV_IOC_STRIPE_OPEN:
+		return fuse_dev_ioctl_stripe_open(file, argp);
+
 	case FUSE_DEV_IOC_BACKING_CLOSE:
 		return fuse_dev_ioctl_backing_close(file, argp);
 
diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
index c49362d19b36..043b451c3584 100644
--- a/fs/fuse/famfs.c
+++ b/fs/fuse/famfs.c
@@ -65,21 +65,11 @@ static void famfs_daxdev_free(struct famfs_daxdev *dd)
 
 DEFINE_FREE(famfs_daxdev_free, struct famfs_daxdev *, if (_T) famfs_daxdev_free(_T));
 
-static int famfs_devidx_free(int id, void *p, void *data)
+void famfs_devidx_free(struct fuse_backing_common *backing)
 {
-	famfs_daxdev_free(p);
-	return 0;
-}
+	struct famfs_daxdev *dd = container_of(backing, typeof(*dd), backing);
 
-/*
- * famfs_teardown()
- *
- * Deallocate famfs metadata for a fuse_conn
- */
-void
-famfs_teardown(struct fuse_conn *fc)
-{
-	idr_for_each(&fc->backing_files_map, famfs_devidx_free,  NULL);
+	famfs_daxdev_free(dd);
 }
 
 static int
@@ -140,6 +130,8 @@ int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	struct famfs_daxdev *dd __free(famfs_daxdev_free) = kzalloc_obj(*dd);
 	int rc;
 
+	dd->backing.type = FUSE_BCK_DAXDEV;
+
 	CLASS(fd_raw, f)(map->fd);
 	if (fd_empty(f))
 		return -EBADF;
@@ -148,7 +140,7 @@ int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map)
 	if (rc)
 		return rc;
 
-	rc = fuse_backing_id_alloc(fc, dd);
+	rc = fuse_backing_id_alloc(fc, &dd->backing);
 	if (rc >= 0)
 		retain_and_null_ptr(dd);
 
@@ -174,22 +166,7 @@ void __famfs_meta_free(void *famfs_meta)
 	if (!fmap)
 		return;
 
-	switch (fmap->fm_extent_type) {
-	case SIMPLE_DAX_EXTENT:
-		kfree(fmap->se);
-		break;
-	case INTERLEAVED_EXTENT:
-		if (fmap->ie) {
-			for (int i = 0; i < fmap->fm_niext; i++)
-				kfree(fmap->ie[i].ie_strips);
-		}
-		kfree(fmap->ie);
-		break;
-	default:
-		pr_err("%s: invalid fmap type\n", __func__);
-		break;
-	}
-
+	kfree(fmap->se);
 	kfree(fmap);
 }
 DEFINE_FREE(__famfs_meta_free, void *, if (_T) __famfs_meta_free(_T))
@@ -231,7 +208,7 @@ famfs_fuse_meta_alloc(
 	size_t extent_total = 0;
 	size_t next_offset = 0;
 	int errs = 0;
-	int i, j;
+	int i;
 
 	fmh = fmap_buf;
 
@@ -262,7 +239,6 @@ famfs_fuse_meta_alloc(
 	meta->error = false;
 	meta->file_type = fmh->file_type;
 	meta->file_size = fmh->file_size;
-	meta->fm_extent_type = fmh->ext_type;
 
 	switch (fmh->ext_type) {
 	case FUSE_FAMFS_EXT_SIMPLE: {
@@ -301,109 +277,6 @@ famfs_fuse_meta_alloc(
 		break;
 	}
 
-	case FUSE_FAMFS_EXT_INTERLEAVE: {
-		s64 size_remainder = meta->file_size;
-		struct fuse_famfs_iext *ie_in;
-		int niext = fmh->nextents;
-
-		meta->fm_niext = niext;
-
-		/* Allocate interleaved extent */
-		meta->ie = kcalloc(niext, sizeof(*(meta->ie)), GFP_KERNEL);
-		if (!meta->ie)
-			return -ENOMEM;
-
-		/*
-		 * Each interleaved extent has a simple extent list of strips.
-		 * Outer loop is over separate interleaved extents
-		 */
-		for (i = 0; i < niext; i++) {
-			u64 nstrips;
-			struct fuse_famfs_simple_ext *sie_in;
-
-			/* ie_in = one interleaved extent in fmap_buf */
-			ie_in = fmap_buf + next_offset;
-
-			/* Move past 1 interleaved extent header in fmap_buf */
-			next_offset += sizeof(*ie_in);
-			if (next_offset > fmap_buf_size) {
-				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
-				       __func__, __LINE__, next_offset,
-				       fmap_buf_size);
-				return -EINVAL;
-			}
-
-			if (!IS_ALIGNED(ie_in->ie_chunk_size, PMD_SIZE)) {
-				pr_err("%s: chunk_size %lld not PMD-aligned\n",
-				       __func__, meta->ie[i].fie_chunk_size);
-				return -EINVAL;
-			}
-
-			if (ie_in->ie_nbytes == 0) {
-				pr_err("%s: zero-length interleave!\n",
-				       __func__);
-				return -EINVAL;
-			}
-
-			nstrips = ie_in->ie_nstrips;
-			meta->ie[i].fie_chunk_size = ie_in->ie_chunk_size;
-			meta->ie[i].fie_nstrips    = ie_in->ie_nstrips;
-			meta->ie[i].fie_nbytes     = ie_in->ie_nbytes;
-
-			/* sie_in = the strip extents in fmap_buf */
-			sie_in = fmap_buf + next_offset;
-
-			/* Move past strip extents in fmap_buf */
-			next_offset += nstrips * sizeof(*sie_in);
-			if (next_offset > fmap_buf_size) {
-				pr_err("%s:%d: fmap_buf underflow offset/size %ld/%ld\n",
-				       __func__, __LINE__, next_offset,
-				       fmap_buf_size);
-				return -EINVAL;
-			}
-
-			if ((nstrips > FUSE_FAMFS_MAX_STRIPS) || (nstrips < 1)) {
-				pr_err("%s: invalid nstrips=%lld (max=%d)\n",
-				       __func__, nstrips,
-				       FUSE_FAMFS_MAX_STRIPS);
-				errs++;
-			}
-
-			/* Allocate strip extent array */
-			meta->ie[i].ie_strips =
-				kcalloc(ie_in->ie_nstrips,
-					sizeof(meta->ie[i].ie_strips[0]),
-					GFP_KERNEL);
-			if (!meta->ie[i].ie_strips)
-				return -ENOMEM;
-
-			/* Inner loop is over strips */
-			for (j = 0; j < nstrips; j++) {
-				struct famfs_meta_simple_ext *strips_out;
-				u64 devindex = sie_in[j].se_devindex;
-				u64 offset   = sie_in[j].se_offset;
-				u64 len      = sie_in[j].se_len;
-
-				strips_out = meta->ie[i].ie_strips;
-				strips_out[j].dev_index  = devindex;
-				strips_out[j].ext_offset = offset;
-				strips_out[j].ext_len    = len;
-
-				extent_total += len;
-				errs += famfs_check_ext_alignment(&strips_out[j]);
-				size_remainder -= len;
-			}
-		}
-
-		if (size_remainder > 0) {
-			/* Sum of interleaved extent sizes is less than file size! */
-			pr_err("%s: size_remainder %lld (0x%llx)\n",
-			       __func__, size_remainder, size_remainder);
-			return -EINVAL;
-		}
-		break;
-	}
-
 	default:
 		pr_err("%s: invalid ext_type %d\n", __func__, fmh->ext_type);
 		return -EINVAL;
@@ -513,95 +386,64 @@ static int famfs_dax_err(struct famfs_daxdev *dd)
 	return 0;
 }
 
-static struct famfs_daxdev *
-famfs_daxdev_lookup(struct fuse_conn *fc, int devidx)
+static struct fuse_backing_common *fuse_backing_find(struct fuse_conn *fc, int backing_id)
 {
-	struct famfs_daxdev *dd;
+	struct fuse_backing_common *backing;
 
 	rcu_read_lock();
-	dd = idr_find(&fc->backing_files_map, devidx);
+	backing = idr_find(&fc->backing_files_map, backing_id);
 	rcu_read_unlock();
 
+	return backing;
+}
+
+static struct famfs_daxdev *famfs_backing_to_daxdev(struct fuse_backing_common *backing)
+{
+	struct famfs_daxdev *dd = NULL;
+	if (backing && backing->type == FUSE_BCK_DAXDEV)
+		dd = container_of(backing, typeof(*dd), backing);
 	return dd;
 }
 
 static int
-famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
-			 loff_t file_offset, off_t len, unsigned int flags)
+famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct fuse_stripe *stripe,
+				   struct iomap *iomap)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct famfs_file_meta *meta = fi->famfs_meta;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t local_offset = file_offset;
+	struct famfs_daxdev *dd;
+	loff_t local_offset = iomap->addr;
+	u64 chunk_size = stripe->chunk_size;
+	u64 nstrips = stripe->nr_strips;
+	u64 chunk_num       = local_offset / chunk_size;
+	u64 chunk_offset    = local_offset % chunk_size;
+	u64 chunk_remainder = chunk_size - chunk_offset;
+	u64 stripe_num      = chunk_num / nstrips;
+	u64 strip_num       = chunk_num % nstrips;
+	u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
+	u64 strip_dax_ofs = stripe->strips[strip_num].offset;
+	u64 strip_devidx = stripe->strips[strip_num].backing_id;
+	int rc;
 
-	/* This function is only for extent_type INTERLEAVED_EXTENT */
-	if (meta->fm_extent_type != INTERLEAVED_EXTENT) {
-		pr_err("%s: bad extent type\n", __func__);
+	dd = famfs_backing_to_daxdev(fuse_backing_find(fc, strip_devidx));
+	if (!dd) {
+		pr_err("%s: daxdev=%lld invalid\n", __func__,
+		       strip_devidx);
 		goto err_out;
 	}
 
-	if (famfs_file_bad(inode))
-		goto err_out;
-
-	iomap->offset = file_offset;
-
-	for (int i = 0; i < meta->fm_niext; i++) {
-		struct famfs_meta_interleaved_ext *fei = &meta->ie[i];
-		u64 chunk_size = fei->fie_chunk_size;
-		u64 nstrips = fei->fie_nstrips;
-		u64 ext_size =  min(fei->fie_nbytes, meta->file_size);
-
-		if (!IS_ALIGNED(chunk_size, PMD_SIZE)) {
-			pr_err("%s: chunk_size %lld not PMD-aligned\n",
-			       __func__, meta->ie[i].fie_chunk_size);
-			return -EINVAL;
-		}
-		if (ext_size == 0) {
-			pr_err("%s: ext_size=%lld file_size=%ld\n",
-			       __func__, fei->fie_nbytes, meta->file_size);
-			goto err_out;
-		}
-
-		/* Is the data is in this striped extent? */
-		if (local_offset < ext_size) {
-			struct famfs_daxdev *dd;
-			u64 chunk_num       = local_offset / chunk_size;
-			u64 chunk_offset    = local_offset % chunk_size;
-			u64 chunk_remainder = chunk_size - chunk_offset;
-			u64 stripe_num      = chunk_num / nstrips;
-			u64 strip_num       = chunk_num % nstrips;
-			u64 strip_offset    = chunk_offset + (stripe_num * chunk_size);
-			u64 strip_dax_ofs = fei->ie_strips[strip_num].ext_offset;
-			u64 strip_devidx = fei->ie_strips[strip_num].dev_index;
-			int rc;
-
-			dd = famfs_daxdev_lookup(fc, strip_devidx);
-			if (!dd) {
-				pr_err("%s: daxdev=%lld invalid\n", __func__,
-					strip_devidx);
-				goto err_out;
-			}
-
-			rc = famfs_dax_err(dd);
-			if (rc) {
-				/* Shut down access to this file */
-				meta->error = true;
-				return rc;
-			}
-
-			iomap->addr    = strip_dax_ofs + strip_offset;
-			iomap->offset  = file_offset;
-			iomap->length  = min_t(loff_t, len, chunk_remainder);
-
-			iomap->dax_dev = dd->devp;
-
-			iomap->type    = IOMAP_MAPPED;
-			iomap->flags   = flags;
-
-			return 0;
-		}
-		local_offset -= ext_size; /* offset is beyond this striped extent */
+	rc = famfs_dax_err(dd);
+	if (rc) {
+		/* Shut down access to this file */
+		meta->error = true;
+		return rc;
 	}
+	iomap->addr  = strip_dax_ofs + strip_offset;
+	iomap->length  = min_t(loff_t, iomap->length, chunk_remainder);
+	iomap->dax_dev = dd->devp;
+
+	return 0;
 
  err_out:
 	pr_err("%s: err_out\n", __func__);
@@ -611,11 +453,8 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 	 * This just means that the r/w is past EOF
 	 */
 	iomap->addr    = 0; /* there is no valid dax device offset */
-	iomap->offset  = file_offset; /* file offset */
 	iomap->length  = 0; /* this had better result in no access to dax mem */
 	iomap->dax_dev = NULL;
-	iomap->type    = IOMAP_MAPPED;
-	iomap->flags   = flags;
 
 	return -EIO;
 }
@@ -644,24 +483,16 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
  * Return values: 0. (info is returned in a modified @iomap struct)
  */
 static int
-famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
-			loff_t file_offset, off_t len, unsigned int flags)
+famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
 	struct famfs_file_meta *meta = fi->famfs_meta;
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	loff_t local_offset = file_offset;
+	loff_t local_offset = iomap->offset;
 
 	if (famfs_file_bad(inode))
 		goto err_out;
 
-	if (meta->fm_extent_type == INTERLEAVED_EXTENT)
-		return famfs_interleave_fileofs_to_daxofs(inode, iomap,
-							  file_offset,
-							  len, flags);
-
-	iomap->offset = file_offset;
-
 	for (int i = 0; i < meta->fm_nextents; i++) {
 		/* TODO: check devindex too */
 		loff_t dax_ext_offset = meta->se[i].ext_offset;
@@ -680,10 +511,20 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 		 */
 		if (local_offset < dax_ext_len) {
 			loff_t ext_len_remainder = dax_ext_len - local_offset;
+			struct fuse_backing_common *backing = fuse_backing_find(fc, daxdev_idx);
 			struct famfs_daxdev *dd;
 			int rc;
 
-			dd = famfs_daxdev_lookup(fc, daxdev_idx);
+			iomap->length = min_t(loff_t, iomap->length, ext_len_remainder);
+			iomap->addr = dax_ext_offset + local_offset;
+			if (backing && backing->type == FUSE_BCK_STRIPE) {
+				struct fuse_backing_stripe *bstripe =
+					container_of(backing, typeof(*bstripe), backing);
+
+				return famfs_interleave_fileofs_to_daxofs(inode, bstripe->stripe,
+									  iomap);
+			}
+			dd = famfs_backing_to_daxdev(backing);
 			if (!dd) {
 				pr_err("%s: daxdev=%lld invalid\n", __func__,
 					daxdev_idx);
@@ -710,14 +551,8 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 			 * iomap->offset: the file offset
 			 * iomap->length: the valid length resolved here
 			 */
-			iomap->addr    = dax_ext_offset + local_offset;
-			iomap->offset  = file_offset;
-			iomap->length  = min_t(loff_t, len, ext_len_remainder);
-
 			iomap->dax_dev = dd->devp;
 
-			iomap->type    = IOMAP_MAPPED;
-			iomap->flags   = flags;
 			return 0;
 		}
 		local_offset -= dax_ext_len; /* Get ready for the next extent */
@@ -731,11 +566,8 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct iomap *iomap,
 	 * This just means that the r/w is past EOF
 	 */
 	iomap->addr    = 0; /* there is no valid dax device offset */
-	iomap->offset  = file_offset; /* file offset */
 	iomap->length  = 0; /* this had better result in no access to dax mem */
 	iomap->dax_dev = NULL;
-	iomap->type    = IOMAP_MAPPED;
-	iomap->flags   = flags;
 
 	return -EIO;
 }
@@ -767,8 +599,12 @@ famfs_fuse_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 	size = i_size_read(inode);
 
 	WARN_ON(size != meta->file_size);
+	iomap->offset = offset;
+	iomap->type = IOMAP_MAPPED;
+	iomap->flags = flags;
+	iomap->length = length;
 
-	return famfs_fileofs_to_daxofs(inode, iomap, offset, length, flags);
+	return famfs_fileofs_to_daxofs(inode, iomap);
 }
 
 /* Note: We never need a special set of write_iomap_ops because famfs never
diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
index 3f72ae8e4696..33a0e2d08c6b 100644
--- a/fs/fuse/famfs_kfmap.h
+++ b/fs/fuse/famfs_kfmap.h
@@ -7,6 +7,8 @@
 #ifndef FAMFS_KFMAP_H
 #define FAMFS_KFMAP_H
 
+#include "fuse_i.h"
+
 /* KABI version 43 (aka v2) fmap structures
  *
  * The location of the memory backing for a famfs file is described by
@@ -96,13 +98,6 @@ enum famfs_file_type {
 	FAMFS_LOG,
 };
 
-/* We anticipate the possibility of supporting additional types of extents */
-enum famfs_extent_type {
-	SIMPLE_DAX_EXTENT,
-	INTERLEAVED_EXTENT,
-	INVALID_EXTENT_TYPE,
-};
-
 struct famfs_meta_simple_ext {
 	u64 dev_index;
 	u64 ext_offset;
@@ -122,18 +117,9 @@ struct famfs_meta_interleaved_ext {
 struct famfs_file_meta {
 	bool                   error;
 	enum famfs_file_type   file_type;
-	size_t                 file_size;
-	enum famfs_extent_type fm_extent_type;
-	union {
-		struct {
-			size_t         fm_nextents;
-			struct famfs_meta_simple_ext  *se;
-		};
-		struct {
-			size_t         fm_niext;
-			struct famfs_meta_interleaved_ext *ie;
-		};
-	};
+	size_t file_size;
+	size_t fm_nextents;
+	struct famfs_meta_simple_ext *se;
 };
 
 /*
@@ -143,6 +129,7 @@ struct famfs_file_meta {
  * the responses to GET_FMAP messages
  */
 struct famfs_daxdev {
+	struct fuse_backing_common backing;
 	/* Include dev uuid? */
 	bool error; /* Dax has reported a memory error (probably poison) */
 	bool dax_err; /* fs_dax_get() failed */
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index adc88a8681e2..3fda819865e7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -103,8 +103,19 @@ struct fuse_submount_lookup {
 	struct fuse_forget_link *forget;
 };
 
+enum fuse_backing_type {
+	FUSE_BCK_FILE,
+	FUSE_BCK_DAXDEV,
+	FUSE_BCK_STRIPE,
+};
+
+struct fuse_backing_common {
+	enum fuse_backing_type type;
+};
+
 /** Container for data related to mapping to backing file */
 struct fuse_backing {
+	struct fuse_backing_common backing;
 	struct file *file;
 	struct cred *cred;
 
@@ -113,6 +124,11 @@ struct fuse_backing {
 	struct rcu_head rcu;
 };
 
+struct fuse_backing_stripe {
+	struct fuse_backing_common backing;
+	struct fuse_stripe *stripe;
+};
+
 /** FUSE inode */
 struct fuse_inode {
 	/** Inode data */
@@ -1567,7 +1583,7 @@ void fuse_file_release(struct inode *inode, struct fuse_file *ff,
 struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
 void fuse_backing_put(struct fuse_backing *fb);
 struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backing_id);
-int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj);
+int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing_common *backing);
 #else
 
 static inline struct fuse_backing *fuse_backing_get(struct fuse_backing *fb)
@@ -1588,6 +1604,7 @@ static inline struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
 void fuse_backing_files_init(struct fuse_conn *fc);
 void fuse_backing_files_free(struct fuse_conn *fc);
 int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *map);
+int fuse_stripe_open(struct fuse_conn *fc, struct fuse_stripe *stripe);
 int fuse_backing_close(struct fuse_conn *fc, int backing_id);
 
 /* passthrough.c */
@@ -1649,7 +1666,7 @@ int famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma);
 void __famfs_meta_free(void *map);
 
 int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map);
-void famfs_teardown(struct fuse_conn *fc);
+void famfs_devidx_free(struct fuse_backing_common *backing);
 
 /* Set fi->famfs_meta iff the current value is NULL */
 static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
@@ -1675,7 +1692,7 @@ int fuse_get_fmap(struct fuse_mount *fm, struct inode *inode);
 
 #else /* !CONFIG_FUSE_FAMFS_DAX */
 
-static inline void famfs_teardown(struct fuse_conn *fc)
+static inline void famfs_devidx_free(struct fuse_backing_common *backing)
 {
 }
 static inline ssize_t famfs_fuse_write_iter(struct kiocb *iocb,
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index d6e8dc75c8a1..70136f27299b 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -245,7 +245,6 @@
  *  - Add FUSE_DAX_FMAP capability - ability to handle in-kernel fsdax maps
  *  - Add the following structures for the GET_FMAP message reply components:
  *    - struct fuse_famfs_simple_ext
- *    - struct fuse_famfs_iext
  *    - struct fuse_famfs_fmap_header
  *  - Add the following structs for the GET_DAXDEV message and reply
  *    - struct fuse_get_daxdev_out
@@ -1153,6 +1152,23 @@ struct fuse_backing_map {
 	uint64_t	padding;
 };
 
+struct fuse_strip {
+	uint32_t backing_id;
+	uint32_t reserved;
+	uint64_t offset;
+};
+
+#define FUSE_STRIPS_MAX  (256)
+
+struct fuse_stripe {
+	uint16_t nr_strips;
+	uint16_t reserved1;
+	uint32_t reserved2;
+	uint64_t chunk_size;
+
+	struct fuse_strip strips[] __counted_by(nr_strips);
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
@@ -1160,6 +1176,7 @@ struct fuse_backing_map {
 					     struct fuse_backing_map)
 #define FUSE_DEV_IOC_BACKING_CLOSE	_IOW(FUSE_DEV_IOC_MAGIC, 2, uint32_t)
 #define FUSE_DEV_IOC_SYNC_INIT		_IO(FUSE_DEV_IOC_MAGIC, 3)
+#define FUSE_DEV_IOC_STRIPE_OPEN	_IOW(FUSE_DEV_IOC_MAGIC, 4, struct fuse_stripe)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
@@ -1345,7 +1362,6 @@ enum fuse_famfs_file_type {
 
 enum famfs_ext_type {
 	FUSE_FAMFS_EXT_SIMPLE = 0,
-	FUSE_FAMFS_EXT_INTERLEAVE = 1,
 };
 
 struct fuse_famfs_simple_ext {
@@ -1355,15 +1371,6 @@ struct fuse_famfs_simple_ext {
 	uint64_t se_len;
 };
 
-struct fuse_famfs_iext { /* Interleaved extent */
-	uint32_t ie_nstrips;
-	uint32_t ie_chunk_size;
-	uint64_t ie_nbytes; /* Total bytes for this interleaved_ext;
-			     * sum of strips may be more
-			     */
-	uint64_t reserved;
-};
-
 struct fuse_famfs_fmap_header {
 	uint8_t file_type; /* enum famfs_file_type */
 	uint8_t reserved;
-- 
2.54.0

