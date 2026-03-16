Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C84D1D5170
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680012; cv=none; b=CefsoKmVkyyN3JgJC/M9DHYpPdaeMWyDxQIDki2p1ZyhqL8ezVv2l7agyKFx0kBhxxym30Cic+z2Jr7vFkCsEMe4avZzTVoRcSdQ5ZQ6lRD1fXQL0oPtTAPTg8K5PKuik8XnDTCaA2/hzOe+R3PJ0+gI9w13k2FYllPbzNDJHMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680012; c=relaxed/simple;
	bh=xN2VahQUQ8lRGEazcBljReSPKNHPjPGG5Upe/EuEudY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd+vMSb5nk2fgFphWc9auQh3jVshqAmTO+wgOAU7JXqbdTeRHRgJpJfXcFUUglieYcUV7xgV6SgsfjpIXUWQC1kzknxkp0B9uPb/3WIlglJkNSUCjhmOE653kUnDSgRDVm0IJLeamBOtGDB0NqVBnRe9t0ZyWISHjmDmKoqRN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hsd5yVuJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Va2jTJNT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsd5yVuJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Va2jTJNT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FESgm8rFSeWWjmoMXgrnhEWe8vedXcgKo4qrV2koNPE=;
	b=hsd5yVuJfZjLj8NV87wYmrxyoWEJumg5mbX8x0dBLDsnHyGu1zvaxkhefQqdFzjZ24N0V1
	i6t7tC8oZ4F/DXvudAjQSV1dsSLKTsTtHwOw7GdZtCrBUS393QA+d1uOLVnNrTPhDAcb1J
	F56cvGYNAnYzesPaJepDHotB+jEXCb4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-6epg8RRrPM-3tY_H1jrE2Q-1; Mon, 16 Mar 2026 12:53:26 -0400
X-MC-Unique: 6epg8RRrPM-3tY_H1jrE2Q-1
X-Mimecast-MFC-AGG-ID: 6epg8RRrPM-3tY_H1jrE2Q_1773680005
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4853553944fso49923435e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680005; x=1774284805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FESgm8rFSeWWjmoMXgrnhEWe8vedXcgKo4qrV2koNPE=;
        b=Va2jTJNTzP2r7glaxxltaytycOOY3PL0hb+cVxJBIEUggPkC1V0JMiJbFJb3z0cZV0
         I/5D+Gy35qetyNvKv+ycd3ZqX1oqPWblQkoaSXOmt25gXU5tGN0/5MPjhOz4e083kczU
         fvjlGkE4daw3Y3vLn7NiYA2tlxs2MwXDVGmBCeHi6DeigVAy5zfEew/WNSbwNf78ilSp
         R+kuKTSjZuZjShYrqsrWydDup6/nV1ctSzRHFOARCVbXu8kBwcCJS71VUC7YtPnVWnxG
         fRYOxwrj6h0T2l+wVqEymM/T3IOySoxnFRupKVNTzZIQZQH/OQ4DE8lqLbmxnODToj54
         gwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680005; x=1774284805;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FESgm8rFSeWWjmoMXgrnhEWe8vedXcgKo4qrV2koNPE=;
        b=Pou/6gZwJQoREM+yrxve5BGs++ufVnXi3+EyoTPUU0Ua1TQFPiFrEARZxGZJ7betKr
         kK8HP+m4fx7puLzti9F+j4TkESdn1Zw/Q/oDmt8Y5dIDw3ucodnEMH8EpnGwR5ACnBpR
         79tlD1TzP/Wii6JCwnVTsE7UE2hhXDPk0BB7byg91qdo6Jy4NrMuQb0Ec4l4fyhoQN4I
         YQZ6ojUcMBCV98UHHC8W7aS2r3zsFlVB81jnpfQq5DO1plg/lDMtnxMNu5XD3Dt0TBlf
         T8YWY1wY4WvkfRzXfU769OknO/D2kstHW+PUgwus0W6v4x23jHJVdgq1BFLlrBb8m0W4
         SVLw==
X-Gm-Message-State: AOJu0YwvcKWCFzcggonkIJsCzLT8r9GHluc0np5920MTO/UHBlNSWRnp
	gxtZHX83KaruEspADqQwQ+Ie+eU8yY52b2L6wgxnCej5Ku5OWn5WLjtQVJU28SM2BOknbXAiQ9G
	LqG7W4B43jsqhSlOvgMErQBexr9RRBWW7bz6tsnP9co73Uv4cp/57NyNtILu1oAIOm+QpRv9IuP
	aO8/ssdNSNnwV6dx5AskE93OI/fT3yK9ZU54UEi6KHbP/qUTNkI0s=
X-Gm-Gg: ATEYQzx06O+7ujKxHbjbkztd1XVgAbduJj/yodiA2BjuZIsX+RTt3FSqdSglFXHDIb8
	JZgq/YJxsUGwZmwxHlBkpCLBiOP40Ktls2mpLz6RLzV4f8nGGemC41s+y9V+QP6fvOQS3Qt171u
	rKpvwzxw1Q8E2EppN5nFD/KqVPrY4MdGGpS+AXhxCBOG4S0hUTA5zmr3MjkAwWmuWWpzYEqeenQ
	zgC9KXy2FGC5rH/Goqp9wNko45IhkroG9lAtgwbk0kca6Y1tZSnNRi4eGoSUTt7xG9r9n0ij+0G
	ftv6zVi8aY9IWbGAclu1hLQUU8KjwXHQk7vAk3yF1HYi63NT2sDHsfdHpbqMawrF7pkQhPVnoZL
	uFNG7Vdb2KOBHzFmX/TNKTBlkNWzMS1p+peeeGKTi0fCpskz7d4USM3F8yeyi7p4d4hQEHS/M2g
	==
X-Received: by 2002:a05:600c:3e1a:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4856eab522emr5558175e9.4.1773680004929;
        Mon, 16 Mar 2026 09:53:24 -0700 (PDT)
X-Received: by 2002:a05:600c:3e1a:b0:485:3428:774c with SMTP id 5b1f17b1804b1-4856eab522emr5557405e9.4.1773680004313;
        Mon, 16 Mar 2026 09:53:24 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:23 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v3 2/7] fuse: create fuse_dev on /dev/fuse open instead of mount
Date: Mon, 16 Mar 2026 17:53:13 +0100
Message-ID: <20260316165320.3245526-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316165320.3245526-1-mszeredi@redhat.com>
References: <20260316165320.3245526-1-mszeredi@redhat.com>
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
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/fuse/dev.c        | 47 +++++++++++++++++---------------------------
 fs/fuse/fuse_dev_i.h | 33 +++++++++++++++++++++++--------
 fs/fuse/fuse_i.h     |  6 +++---
 fs/fuse/inode.c      | 35 +++++++++++----------------------
 fs/fuse/virtio_fs.c  |  2 --
 5 files changed, 57 insertions(+), 66 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f0631c48abef..fe453634897b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1546,32 +1546,24 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
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
+	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud) != NULL);
 	if (err)
 		return ERR_PTR(err);
 
-	fud = __fuse_get_dev(file);
-	if (!fud)
-		return ERR_PTR(-EPERM);
-
 	return fud;
 }
 
@@ -2538,10 +2530,10 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 
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
@@ -2559,8 +2551,8 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
-		fuse_dev_free(fud);
 	}
+	fuse_dev_free(fud);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
@@ -2578,16 +2570,12 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 
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
@@ -2661,10 +2649,11 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
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
index 23a241f18623..94b49384a2f7 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -577,6 +577,9 @@ struct fuse_pqueue {
  * Fuse device instance
  */
 struct fuse_dev {
+	/** Issue FUSE_INIT synchronously */
+	bool sync_init;
+
 	/** Fuse connection for this device */
 	struct fuse_conn *fc;
 
@@ -623,9 +626,6 @@ struct fuse_fs_context {
 
 	/* DAX device, may be NULL */
 	struct dax_device *dax_dev;
-
-	/* fuse_dev pointer to fill in, should contain NULL on entry */
-	void **fudptr;
 };
 
 struct fuse_sync_bucket {
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 84f78fb89d35..c2d1184d5ba5 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1638,7 +1638,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 {
-	fud->fc = fuse_conn_get(fc);
+	fuse_dev_fc_set(fud, fuse_conn_get(fc));
 	spin_lock(&fc->lock);
 	list_add_tail(&fud->entry, &fc->devices);
 	spin_unlock(&fc->lock);
@@ -1660,7 +1660,7 @@ EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
 void fuse_dev_free(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc = fud->fc;
+	struct fuse_conn *fc = fuse_dev_fc_get(fud);
 
 	if (fc) {
 		spin_lock(&fc->lock);
@@ -1823,7 +1823,7 @@ EXPORT_SYMBOL_GPL(fuse_init_fs_context_submount);
 
 int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 {
-	struct fuse_dev *fud = NULL;
+	struct fuse_dev *fud = ctx->file ? fuse_file_to_fud(ctx->file) : NULL;
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
 	struct inode *root;
@@ -1857,18 +1857,11 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
@@ -1890,15 +1883,15 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
@@ -1907,8 +1900,8 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
-	if (ctx->fudptr) {
-		*ctx->fudptr = fud;
+	if (fud) {
+		fuse_dev_install(fud, fc);
 		wake_up_all(&fuse_dev_waitq);
 	}
 	mutex_unlock(&fuse_mutex);
@@ -1917,9 +1910,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
  err_unlock:
 	mutex_unlock(&fuse_mutex);
 	dput(root_dentry);
- err_dev_free:
-	if (fud)
-		fuse_dev_free(fud);
  err_free_dax:
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
@@ -1945,13 +1935,10 @@ static int fuse_fill_super(struct super_block *sb, struct fs_context *fsc)
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

