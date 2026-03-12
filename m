Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC803FE34C
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344429; cv=none; b=RZKf/6AvpPBpIw1CT/2smzGJ+HhvNCwhqVCMwOmbmq8Wd9unKBr+Z0s+7lDuweUNuEx7XOYZWhU+u61xqCHYV7LxmAEeaHE9eAx5o9rRa0cfr2GWiTw5q0DMwyCwMrRUR2vnwzP2dkhXUpkP+AOCUdHeqjp8bsWyQVrUN9JB/ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344429; c=relaxed/simple;
	bh=/8UWgkyhjuT/Fdj8a3Zw3JBhGSp5pchWtoIDW6+d8hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P+C1kP/gSB/NoRArEZmBKQXGe6m7ZM6ycGa/eCb3Yao95YzFEfeg8mW37JdTUZCrYGfCXaD+HtYvcgT8OjqDnQhhP7u5waT+RlRBiXZXjRP3UcO15Uvieh5E+ON2Y9fpcnR3mLHd7xtLPcDJGraVAtFfVMZQEmFI+F/BwvTxP7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eX3J5Zx/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cio5j4QL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eX3J5Zx/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cio5j4QL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aqxHUSlcMdy0Xdd2UX7VunaIJn2s7XpEb4zHoZr2eOs=;
	b=eX3J5Zx/J85OO5Oc7LUS5XiQ9jrhm1okZeaMDB+yvFA8GyD7k+4hi2yAF2Qqm/viCPy4Z1
	ug91m3XUjCM+8pqOIoqIgoMA07GQPBrCTnQVuvxNQl0b9/Mx0LTA+pRzDyGzwUrtu+ggc+
	amS+o82q91pD6oF0T9ZhvF35qiWuji8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-k-_2zV83Md-UD0w5M2nFGA-1; Thu, 12 Mar 2026 15:40:24 -0400
X-MC-Unique: k-_2zV83Md-UD0w5M2nFGA-1
X-Mimecast-MFC-AGG-ID: k-_2zV83Md-UD0w5M2nFGA_1773344423
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso17974505e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344423; x=1773949223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqxHUSlcMdy0Xdd2UX7VunaIJn2s7XpEb4zHoZr2eOs=;
        b=Cio5j4QLpMhirUaPp7aoVdF43ldho3DTVGaqAmh6qZFfZIuj7yNK+qCCphJcd1hjk8
         LcLQxGoQ2uhiZSQZKHH9SF1HhYIb0B++EQSBn5ffVGz7KQ4HXoify+8eQx+Jq/jgCUnU
         1kl0MTqvPhi1MDfQkThQsZWIpyxf/1SUiGNxqOYp3f6HRCxuwfnUgDCPihL2RmscL/8l
         M1gXlZMIaZHGUoCCwAOBF4rdj6GQL5KYvVzwR/Tr2NMWUxGxjiORqxNcN+0wgtZIv4qz
         wA2OH1WrYMWWNUsRb/4r6QKC7wFCZPSrQSdnlAM7aVwrRmpncx5a2YLw3EXiFfx9j2wp
         ea2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344423; x=1773949223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aqxHUSlcMdy0Xdd2UX7VunaIJn2s7XpEb4zHoZr2eOs=;
        b=PDExmX3ErrHu3Pw+JBWLGytes9+Z05/nrpQdKSjUgSsYZXgZUv6H7G2wTrZK/CPHjL
         I0u3BfcVpJAXfSBDRv8dIZgyFG3UY7yhLpFEwxATVaeTTvdXyficC9fmNIWYVX1N9Vnj
         MFChBXf9Wqv0DskzGIqd7YYJRkYrTLjX30opBwGF+f+lAwv3HqyjNbboRvQV6S88tbGS
         /qE9j39mHauT0e0+RE4h+XrkLEwrhZ9dMKS42jZ5WtCmznpgObE2Hl4qPlFEWITuYTz5
         aOAefqP3+OjXe/Ttc09XBjmcu4uywlPkgdSXWg+Y3rTr7FzT3vE1vZkAh9xLsB84iffz
         UqhA==
X-Gm-Message-State: AOJu0Yxk9WIzh+85NAKbZKWutdskmVhpR8x82/c6xP8YZoXjuqSx9QG8
	+ZkqSImuCg4EByIKXW4+MI2yGnrzWFp9SLaMlr9S5fpVWJY74zAUwWjqZISJ5/WoGVXzhXVraLH
	LJzJHxF0x72ZLvHZ598K7j1oi6MHNsbZzSVRh8wMV+gX1K+sCapJg5Z1UStVYDkIX4m6vg6BfVf
	3wZJYyPiE1YjeHy5+PooF1NEJ+2elmePLC+uS7zh4IjmhH64VJNDM=
X-Gm-Gg: ATEYQzyxPnUxmCUr6SH+eCT8EEYpWsvh4hRPr6bTbP7mtX+RMhr9QbetQ3aEfj683/I
	iWYhtCzsrTbiKoJwmN3mzRsZh/IiCUJ8f8+ZcyXnweP8KlbIbQCSKItbIWHZe8cWKSGevQdHPHW
	GtPbQgAxN9s4n2rNLIdnNHHccAHa0QptpFB2Hy3NHgL3PuMOy18U6K/TpDo8tFqyIrdY5APAszB
	I1I9QrFh36MvSUbQl5EcpGz1ciHVwlRXlBKTe0eq9e7rzQd9FUGaoQVtfpiT4iM6bJ3EUXYAIdv
	UrlpPx/CCIyU9Jy0uAZ+td0D/1oD8f7cGe41kz79YR5Ihzj++G8lV+e7oLRqzMANtaaAUxACWWw
	ty5XB/MT9UrnAQlihEQNkOZ4FfiXKryxoQ5pMnoekgbpyXKt856Bw2ej9Lhh9Jm6gYkc8E8zDmH
	Oeik4=
X-Received: by 2002:a05:600c:8b6a:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48556711e74mr8200045e9.30.1773344422819;
        Thu, 12 Mar 2026 12:40:22 -0700 (PDT)
X-Received: by 2002:a05:600c:8b6a:b0:485:40c6:f528 with SMTP id 5b1f17b1804b1-48556711e74mr8199535e9.30.1773344422231;
        Thu, 12 Mar 2026 12:40:22 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:21 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
Date: Thu, 12 Mar 2026 20:39:59 +0100
Message-ID: <20260312194019.3077902-2-mszeredi@redhat.com>
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

Allocate struct fuse_dev when opening the device.  This means that unlike
before, ->private_data is always set to a valid pointer.

The use of USE_DEV_SYNC_INIT magic pointer for the private_data is now
replaced with a simple bool sync_init member.

If sync INIT is not set, I/O on the device returns error before mount.
Keep this behavior by checking for the ->fc member.  If fud->fc is set, the
mount has succeeded.  Testing this used READ_ONCE(file->private_data) and
smp_mb() to try and provide the necessary semantics.  Switch this to
smp_store_release() and smp_load_acquire().

Setting fud->fc is protected by fuse_mutex, this is unchanged.

Will need this later so the /dev/fuse open file reference is not held
during FSCONFIG_CMD_CREATE.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 47 +++++++++++++++++---------------------------
 fs/fuse/fuse_dev_i.h | 33 +++++++++++++++++++++++--------
 fs/fuse/fuse_i.h     |  5 ++---
 fs/fuse/inode.c      | 35 +++++++++++----------------------
 fs/fuse/virtio_fs.c  |  2 --
 5 files changed, 56 insertions(+), 66 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 2c16b94357d5..4795e3d01b75 100644
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
+	struct fuse_dev *fud = fuse_file_to_fud(file);
 	int err;
 
-	if (likely(fud))
-		return fud;
-
-	err = wait_event_interruptible(fuse_dev_waitq,
-				       READ_ONCE(file->private_data) != FUSE_DEV_SYNC_INIT);
+	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud));
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
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+	struct fuse_conn *fc = fuse_dev_fc_get(fud);
 
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
@@ -2574,16 +2566,12 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 
 static int fuse_device_clone(struct fuse_conn *fc, struct file *new)
 {
-	struct fuse_dev *fud;
+	struct fuse_dev *new_fud = fuse_file_to_fud(new);
 
-	if (__fuse_get_dev(new))
+	if (fuse_dev_fc_get(new_fud))
 		return -EINVAL;
 
-	fud = fuse_dev_alloc_install(fc);
-	if (!fud)
-		return -ENOMEM;
-
-	new->private_data = fud;
+	fuse_dev_install(new_fud, fc);
 	atomic_inc(&fc->dev_count);
 
 	return 0;
@@ -2657,10 +2645,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 static long fuse_dev_ioctl_sync_init(struct file *file)
 {
 	int err = -EINVAL;
+	struct fuse_dev *fud = fuse_file_to_fud(file);
 
 	mutex_lock(&fuse_mutex);
-	if (!__fuse_get_dev(file)) {
-		WRITE_ONCE(file->private_data, FUSE_DEV_SYNC_INIT);
+	if (!fuse_dev_fc_get(fud)) {
+		fud->sync_init = true;
 		err = 0;
 	}
 	mutex_unlock(&fuse_mutex);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..522b2012cd1f 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,18 +39,35 @@ struct fuse_copy_state {
 	} ring;
 };
 
-#define FUSE_DEV_SYNC_INIT ((struct fuse_dev *) 1)
-#define FUSE_DEV_PTR_MASK (~1UL)
+/*
+ * Lockless access is OK, because fud->fc is set once during mount and is valid
+ * until the file is released.
+ */
+static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
+{
+	/* Pairs with smp_store_release() in fuse_dev_fc_set() */
+	return smp_load_acquire(&fud->fc);
+}
+
+static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
+{
+	/* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
+	smp_store_release(&fud->fc, fc);
+}
+
+static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
+{
+	return file->private_data;
+}
 
 static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
-	/*
-	 * Lockless access is OK, because file->private data is set
-	 * once during mount and is valid until the file is released.
-	 */
-	struct fuse_dev *fud = READ_ONCE(file->private_data);
+	struct fuse_dev *fud = fuse_file_to_fud(file);
+
+	if (!fuse_dev_fc_get(fud))
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
index e57b8af06be9..53663846db36 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1637,7 +1637,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 {
-	fud->fc = fuse_conn_get(fc);
+	fuse_dev_fc_set(fud, fuse_conn_get(fc));
 	spin_lock(&fc->lock);
 	list_add_tail(&fud->entry, &fc->devices);
 	spin_unlock(&fc->lock);
@@ -1659,7 +1659,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
 void fuse_dev_free(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc = fud->fc;
+	struct fuse_conn *fc = fuse_dev_fc_get(fud);
 
 	if (fc) {
 		spin_lock(&fc->lock);
@@ -1822,7 +1822,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
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
+		if (fuse_dev_fc_get(fud))
 			goto err_unlock;
+		if (fud->sync_init)
+			fc->sync_init = 1;
 	}
 
 	err = fuse_ctl_add_conn(fc);
@@ -1906,8 +1899,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr) {
-		*ctx->fudptr = fud;
+	if (fud) {
+		fuse_dev_install(fud, fc);
 		wake_up_all(&fuse_dev_waitq);
 	}
 	mutex_unlock(&fuse_mutex);
@@ -1916,9 +1909,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
  err_unlock:
 	mutex_unlock(&fuse_mutex);
 	dput(root_dentry);
- err_dev_free:
-	if (fud)
-		fuse_dev_free(fud);
  err_free_dax:
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
@@ -1944,13 +1934,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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

