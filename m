Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61EC29B200
	for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773265888; cv=none; b=Jt3Xib3L0icylbzklZ7a+JUysfk2BkUjfN4eg1tIrzV14nowdpoA5gdonvkbUvM4fCHXNi8MzNZbEcFJyFFlHldXgDmL6S/svqvAUHbgKbauujDkOpjeCV7a9pQ/x7EowrhBUwHp2X6axLOGLs9oLkpdHXp5S7GjOeQOYiT43SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773265888; c=relaxed/simple;
	bh=h40OdqPAiV1OGsId7V7ssU3mtTZzQvzFH6idW2d72WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=joXzZG1GB9L7HuccBD4NZ9XQ4veJZngGgS6MtFKSO8Hbhi57SgTm6sJfNMqVP9+WDhiXT9QWnYKRnwlSqLmia7VSaqf8Kunrn5DLPoDMA4I1NYOEy6iBjDkH5jQ2yycCyd8WHu+wtGWK4ayUsNUIL+92jvGw9EbqoJ5irGd6PaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fa/BN6W0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OMzCF4//; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fa/BN6W0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OMzCF4//"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773265885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EQYceWSppX8/fRzEKnFdb8uEDJ5dgPmOqOUeTHYjiP8=;
	b=fa/BN6W0UiOMCpL0q+MfY/7qJr3rb6jn9xDuEvMLzgtgI0gqeDmtVaE+tJpwfBbFrnCZdP
	r+MsZROXKP3erUJPubmN66n+00YcJRqQSsZjwLkk6JzshlxY9+96rYFvzdu8Fj4maPwbwV
	Ecx5Kjfwg7Xxu4T/v1zahYDJdHlkqUM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-y7uGOJ0uOkivYga0AOq6rA-1; Wed, 11 Mar 2026 17:51:24 -0400
X-MC-Unique: y7uGOJ0uOkivYga0AOq6rA-1
X-Mimecast-MFC-AGG-ID: y7uGOJ0uOkivYga0AOq6rA_1773265883
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-439c794edd9so297578f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Mar 2026 14:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773265883; x=1773870683; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EQYceWSppX8/fRzEKnFdb8uEDJ5dgPmOqOUeTHYjiP8=;
        b=OMzCF4//QeO32zxlGLlWPT9uk5DWCTooj8/UYHW1JcbuY9mXO653r/TssE4rwgLKZg
         LbAU/l1kfHU0hnS1HDIFj4zjuOgKrrgCWSJiJY+wN5i85AG2atNOKKqde7WAPr+IR1Fx
         uFgqtuW9z6ANKKUxNRQE0EpC6wrtfTUDLFzTqo23b0nxEPjS00XlB80VL4JKIABmlT8b
         1qIEw5fVcy/ttLuoM6jgdA+wAbB/Bw1+fDcp1UbM4ejvXOSlQj1UXSrXOm+xudXuRSZF
         +pNodc3nWalzVd+UTmGJE3j4cZLVE+8As+xF/Zhn8BD6jgaf/RRGW6qLUdDWQnQJcYFi
         yQ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773265883; x=1773870683;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EQYceWSppX8/fRzEKnFdb8uEDJ5dgPmOqOUeTHYjiP8=;
        b=BMvp9tIl89d1GQCTZqKNCK7LJpqjMmlijdoG42sbZWagTBoN3iiXb1O6R/MmlMznR5
         63X4VjEByHJXKbFZuU2tp8H36Lnt6ogR+Nfhim9LPS9EsV2zZbXPqobAEjii7fhl9FAA
         kivX8H+vnYzFzvPHTpXtpAFfRmddDoNktmlbLtaGAxkKBeusLXoP4IYnEn7+xJozHR1J
         QBLd/YUyU1ZxxKFE6pRn31fv9Tkwsl7l7k7VJge1rjmYqN/G8DGwanVDp6Eas2GMazrb
         edmt66yy2Nyyq3Y21Qt7Hf9Z8T2SRRh1SE8PAVdumAvNv/qAliv3SUweAbOCKST1bCK1
         o/qw==
X-Gm-Message-State: AOJu0YyvT/qht3Fxxhfn6VmMYyVmg9xukY7LnCXFlu/rR/DsgD29RupP
	1K5obJf3AFqDANQi4Rn2vlzHKngsODVHDRUmWpZB+AC4pmyfWKiW2RKFrRl+ov/1L+67icCyvp0
	m/uJRbjcwcdjQ3h1QVXtNC74ZLUr4Q9KZrKYvtG32O4dS1EoRzdAgLyXuOt8ykbOWgr031tT/+1
	egDTr+qH1/vsuGbIxTR6sPGDwToQBx8iJOkfLRfX9357saFAbNTVM=
X-Gm-Gg: ATEYQzzL9yBuP93hsPKFgnlef3yOOEWOiUMZ2hPBfmb48jwVSoOC6RcQDodHlj9aNrv
	6DlayXRpVaKpBBhmrw1npnccnCj624z6Ow0XDz2BzyungG1fpwu2gJN7hk8IFeEcg4I0t4kHB1I
	wu19NrOLFrSet5RbrmX+65DW+VFRi6U1HrDkOQZHfkuDAYkdlnKpV7Ntf0qArTEJOTR6SYIvBjF
	tRb7ubILuohPfwbTml5K9y0YydaalU2VHXWiczKpj3sdNPDYY6Dw2HWbOIxf8MEIRcGLJsjZPy9
	v9+DoHhhEt6YGRLx9t664LM2Dbc8bm3tZx3keQx3Vd42FPFg+FO9kLKU8DpoKP2sHTyagSgRi9Z
	njCx2cOJcKiuoNrA3Am6HL0e/NK88xRbkKLa4zU7NBpBbUz2Vqgk8+Emg8qVrxUuaA+iMxHjFME
	ExpDQ=
X-Received: by 2002:a05:600c:444d:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-4854b0bfc1fmr73452165e9.14.1773265882844;
        Wed, 11 Mar 2026 14:51:22 -0700 (PDT)
X-Received: by 2002:a05:600c:444d:b0:485:3b34:2f62 with SMTP id 5b1f17b1804b1-4854b0bfc1fmr73451725e9.14.1773265882259;
        Wed, 11 Mar 2026 14:51:22 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e9179sm79881205e9.3.2026.03.11.14.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 14:51:21 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [RFC PATCH 1/3] fuse: create fuse_dev on /dev/fuse open instead of mount
Date: Wed, 11 Mar 2026 22:51:15 +0100
Message-ID: <20260311215118.2891117-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311215118.2891117-1-mszeredi@redhat.com>
References: <20260311215118.2891117-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Will need this later so the /dev/fuse open file reference is not held
during FSCONFIG_CMD_CREATE.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 48 ++++++++++++++++++--------------------------
 fs/fuse/fuse_dev_i.h | 15 +++++++-------
 fs/fuse/fuse_i.h     |  5 ++---
 fs/fuse/inode.c      | 33 ++++++++++--------------------
 fs/fuse/virtio_fs.c  |  2 --
 5 files changed, 40 insertions(+), 63 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c16b94357d5..d114869d6900 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1542,32 +1542,24 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 static int fuse_dev_open(struct inode *inode, struct file *file)
 {
-	/*
-	 * The fuse device's file's private_data is used to hold
-	 * the fuse_conn(ection) when it is mounted, and is used to
-	 * keep track of whether the file has been mounted already.
-	 */
-	file->private_data = NULL;
+	struct fuse_dev *fud = fuse_dev_alloc();
+
+	if (!fud)
+		return -ENOMEM;
+
+	file->private_data = fud;
 	return 0;
 }
 
 struct fuse_dev *fuse_get_dev(struct file *file)
 {
-	struct fuse_dev *fud = __fuse_get_dev(file);
+	struct fuse_dev *fud = file->private_data;
 	int err;
 
-	if (likely(fud))
-		return fud;
-
-	err = wait_event_interruptible(fuse_dev_waitq,
-				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+	err = wait_event_interruptible(fuse_dev_waitq, smp_load_acquire(&fud->fc));
 	if (err)
 		return ERR_PTR(err);
 
-	fud = __fuse_get_dev(file);
-	if (!fud)
-		return ERR_PTR(-EPERM);
-
 	return fud;
 }
 
@@ -2534,10 +2526,10 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = __fuse_get_dev(file);
+	struct fuse_dev *fud = file->private_data;
+	struct fuse_conn *fc = smp_load_acquire(&fud->fc);
 
-	if (fud) {
-		struct fuse_conn *fc = fud->fc;
+	if (fc) {
 		struct fuse_pqueue *fpq = &fud->pq;
 		LIST_HEAD(to_end);
 		unsigned int i;
@@ -2555,8 +2547,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
-		fuse_dev_free(fud);
 	}
+	fuse_dev_free(fud);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
@@ -2574,16 +2566,13 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 
 static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 {
-	struct fuse_dev *fud;
+	struct fuse_dev *fud = new->private_data;
 
-	if (__fuse_get_dev(new))
+	if (fud->fc)
 		return -EINVAL;
 
-	fud = fuse_dev_alloc_install(fc);
-	if (!fud)
-		return -ENOMEM;
-
-	new->private_data = fud;
+	fuse_dev_install(fud, fc);
+	smp_store_release(&fud->fc, fc);
 	atomic_inc(&fc->dev_count);
 
 	return 0;
@@ -2657,10 +2646,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
 	int err = -EINVAL;
+	struct fuse_dev *fud = file->private_data;
 
 	mutex_lock(&fuse_mutex);
-	if (!__fuse_get_dev(file)) {
-		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
+	if (!fud->fc) {
+		fud->sync_init = true;
 		err = 0;
 	}
 	mutex_unlock(&fuse_mutex);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..3db39590fbda 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,18 +39,19 @@ struct fuse_copy_state {
 	} ring;
 };
 
-#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
-#define FUSE_DEV_PTR_MASK (~1UL)
-
 static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
+	struct fuse_dev *fud = file->private_data;
+	struct fuse_conn *fc = smp_load_acquire(&fud->fc);
+
 	/*
-	 * Lockless access is OK, because file->private data is set
-	 * once during mount and is valid until the file is released.
+	 * Lockless access is OK, because fud->fc is set once during mount and
+	 * is valid until the file is released.
 	 */
-	struct fuse_dev *fud = READ_ONCE(file->private_data);
+	if (!fc)
+		return NULL;
 
-	return (typeof(fud)) ((unsigned long) fud & FUSE_DEV_PTR_MASK);
+	return fud;
 }
 
 struct fuse_dev *fuse_get_dev(struct file *file);
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 7f16049387d1..739220d96b6f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -576,6 +576,8 @@ struct fuse_pqueue {
  * Fuse device instance
  */
 struct fuse_dev {
+	bool sync_init;
+
 	/** Fuse connection for this device */
 	struct fuse_conn *fc;
 
@@ -622,9 +624,6 @@ struct fuse_fs_context {
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
-
-	/* fuse_dev pointer to fill in, should contain NULL on entry */
-	void **fudptr;
 };
 
 struct fuse_sync_bucket {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index e57b8af06be9..92f56bd6ac23 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1822,7 +1822,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud = ctx->file ? ctx->file->private_data : NULL;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
@@ -1856,18 +1856,11 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 			goto err;
 	}
 
-	if (ctx->fudptr) {
-		err = -ENOMEM;
-		fud = fuse_dev_alloc_install(fc);
-		if (!fud)
-			goto err_free_dax;
-	}
-
 	fc->dev = sb->s_dev;
 	fm->sb = sb;
 	err = fuse_bdi_init(fc, sb);
 	if (err)
-		goto err_dev_free;
+		goto err_free_dax;
 
 	/* Handle umasking inside the fuse code */
 	if (sb->s_flags & SB_POSIXACL)
@@ -1889,15 +1882,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	set_default_d_op(sb, &fuse_dentry_operations);
 	root_dentry = d_make_root(root);
 	if (!root_dentry)
-		goto err_dev_free;
+		goto err_free_dax;
 
 	mutex_lock(&fuse_mutex);
 	err = -EINVAL;
-	if (ctx->fudptr && *ctx->fudptr) {
-		if (*ctx->fudptr == FUSE_DEV_SYNC_INIT)
-			fc->sync_init = 1;
-		else
+	if (fud) {
+		if (fud->fc)
 			goto err_unlock;
+		if (fud->sync_init)
+			fc->sync_init = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);
@@ -1906,19 +1899,18 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr) {
-		*ctx->fudptr = fud;
+	if (fud) {
+		fuse_dev_install(fud, fc);
+		smp_store_release(&fud->fc, fc);
 		wake_up_all(&fuse_dev_waitq);
 	}
+
 	mutex_unlock(&fuse_mutex);
 	return 0;
 
  err_unlock:
 	mutex_unlock(&fuse_mutex);
 	dput(root_dentry);
- err_dev_free:
-	if (fud)
-		fuse_dev_free(fud);
  err_free_dax:
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
@@ -1944,13 +1936,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
 	if ((ctx->file->f_op != &fuse_dev_operations) ||
 	    (ctx->file->f_cred->user_ns != sb->s_user_ns))
 		return -EINVAL;
-	ctx->fudptr = &ctx->file->private_data;
 
 	err = fuse_fill_super_common(sb, ctx);
 	if (err)
 		return err;
-	/* file->private_data shall be visible on all CPUs after this */
-	smp_mb();
 
 	fm = get_fuse_mount_super(sb);
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 2f7485ffac52..f685916754ad 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1590,8 +1590,6 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 			goto err_free_fuse_devs;
 	}
 
-	/* virtiofs allocates and installs its own fuse devices */
-	ctx->fudptr = NULL;
 	if (ctx->dax_mode != FUSE_DAX_NEVER) {
 		if (ctx->dax_mode == FUSE_DAX_ALWAYS && !fs->dax_dev) {
 			err = -EINVAL;
-- 
2.53.0

