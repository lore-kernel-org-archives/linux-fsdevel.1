Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746023CEBA3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680016; cv=none; b=AEWbTIjaW5+ibwjq5CY9KDD9NjHLSt9G4i60nWERzLOItOi5Mjc+UGmK6CPvkG7zXsp5eSGKScu3NFsokjcrCo8vLpwJ0Km7dKpmUc5lrqyf1gp5zKcinYwgI7z+Z766cIgPzNs0jPDwSnm7D4N2ap0hgqj6bxoJNXIpJV/gbPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680016; c=relaxed/simple;
	bh=ByTyTKvxVFGGl11XgCkhadJfcW2tKgYgCLhAqMS77Zk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J535H+qES6ZJMsNMF+McDOSJ/aZgN2bS6wzYEslf5YS5ljhV6MsNfQU2QJS0kpRCMD2uVhG8bdbZSPGeDrtCIabR1ehVeydxQcibYDMvc6NNGXNmJbLB7QVhxluHH1fiVfyNfO/7IMcTcYVpZ1QWuJ6jXplhW/XBBAvdz2LEDUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RFMuuZqQ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LSUY8MmA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RFMuuZqQ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSUY8MmA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680013;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFIYzJn+rr9/zRNCmBVVLAWKzxqm7ZSP84csGkSi0Y8=;
	b=RFMuuZqQ2wANPZB4ibJj5XpdPsct6n3cE4nSqM2KWzUHMwnQaVaVeIB55TIut1na6qwimO
	Ppf0F+V2xZW8JT60/tfsPcCTEpaZDI61RUHIfUL30A/yeyoKgljhzDGmed0m1Kx12YZ8Ki
	n3ZDA2Hqyz4I1oMrLh+R7yoNt9fVePI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-rx8SwaPCNdCEklQHOJ9YGg-1; Mon, 16 Mar 2026 12:53:32 -0400
X-MC-Unique: rx8SwaPCNdCEklQHOJ9YGg-1
X-Mimecast-MFC-AGG-ID: rx8SwaPCNdCEklQHOJ9YGg_1773680011
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853466655dso45634075e9.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680010; x=1774284810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JFIYzJn+rr9/zRNCmBVVLAWKzxqm7ZSP84csGkSi0Y8=;
        b=LSUY8MmANRCyL5iyR8VmWGJT5ptL0BDghDfSw6dPKCl1FVU3yuCSGO8Lwxf5RKN8Ny
         D//Ipmr4Qo7jlrpY0AbWhm3z6YO80GvaoSkyjSQSlc+Mrh/VAbi9LuID/YcnBbms3CN6
         wIJNw2DNokkhp/9PZrAMIaNAmKdT+PcFwoVr1mEduTaSWDmSPs/sax9cvVqu6IKbUHGj
         QbayTDFiTggfYLw4OBkmYS3tZPJcVy+RyaE8ZPn7AdCITGE4mxHySdZMwv51jDsCRrYy
         OU3EX/FLX6LQ/LD15yp14Ue+IBWCzuCMVKn6e7TYhjSvaeLNZcaLO/jdu5thXhvapQ4a
         bKlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680010; x=1774284810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JFIYzJn+rr9/zRNCmBVVLAWKzxqm7ZSP84csGkSi0Y8=;
        b=bwC4llA58ZDK6a3Gehu2nRgz456WO6oXePl0Skwqopc8nPKJ+wyyGVy3yAoSSyZCLX
         jsSfApnrdiNitlUuGaSeVGtnLkvgnQEscoJeeNxxPTnxAnjETGaYwBu1/jbuXlxxy1Gj
         V96Cc7eWjbl/9XtSTu70q9hqXIRfBdXNp70/u2x2MHhCNBgjwm0+w0gdY/rRoMfJMF6M
         5avhU5sanH6E/lcAMWz4dnnCUa9uRhoozh/nijIKpZ58qM4Z0o9MRTdJsmxFUWzLNAOq
         YB307E0XQkprRpuK4ylkNXNabUuDlV98BuePAPCviKRrOSLyQLZ2OgbiuIC+Sgkvr3q7
         BWag==
X-Gm-Message-State: AOJu0YxP2MrRdYvWDn/5ZbalTcM7Hgl/4ofxxnGBHFoXJT/B0bQcGdDC
	LXDKgoG9HupXh0yIBENj7qlqzDdMGH8CLKaL7T7gKu+mM7cBSnvZZzYhgE29LAGnpHz0u/rtPwP
	gUJ4mrdI8DuLnQUWaMghtJo4LFh45ndAl6xlJzuhhmsv70fAQjagiLP6U9Mboz/AakoEw28I0ty
	N8pZSl9rxzsIS7mlikBux2ZjxYGj0y5ZbkcwD2usmpuk9IXqHqn90=
X-Gm-Gg: ATEYQzz5jmk80x+HmV4/XXdQiKb0wf0RCeCjuFTz1jJhmM/V0l18g1gB78ex4FitNeF
	Qz14F8/ghaEsUyabtJKNeGbImfSDunV1NBtxmfnPmBOTrfGaiPgBEbO6/DU8vnurjdTCS//pBj+
	yaF2uZZG8t8qUiQvqZgGPLyrn5SLEU1jJ6h4sH90IpVUMZ4HP0GTz7ZMTGCGWd79qXHoNeFfgaa
	hhnHj9uB1skUSYyIw6xDyt1lPQXO1wICjwM8adBGpY6+jOvvCCUVMhONWD0yYtQl5guUrI65DZb
	mBHlkCAUXgBPtNg27ufBY9KzjscQod/pKpM8jtDB6cQOuY/DTnXt5goBkfETyitn0G215fF5iGe
	bwYpvuTueno2R4dbnBS9GmlHZgyBq4E8EoeykR7blf10w8JNPB/Q/Liw18TtRQk3Zucd1kqLgGg
	==
X-Received: by 2002:a05:600d:8489:20b0:485:364e:934e with SMTP id 5b1f17b1804b1-48556715009mr173237565e9.21.1773680010378;
        Mon, 16 Mar 2026 09:53:30 -0700 (PDT)
X-Received: by 2002:a05:600d:8489:20b0:485:364e:934e with SMTP id 5b1f17b1804b1-48556715009mr173236975e9.21.1773680009721;
        Mon, 16 Mar 2026 09:53:29 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:28 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v3 6/7] fuse: alloc pqueue before installing fc
Date: Mon, 16 Mar 2026 17:53:17 +0100
Message-ID: <20260316165320.3245526-7-mszeredi@redhat.com>
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
index 3d6578fcb386..d18796b1010c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -1546,7 +1546,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 static int fuse_dev_open(struct inode *inode, struct file *file)
 {
-	struct fuse_dev *fud = fuse_dev_alloc();
+	struct fuse_dev *fud = fuse_dev_alloc(false);
 
 	if (!fud)
 		return -ENOMEM;
@@ -2580,6 +2580,7 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 {
 	int oldfd;
 	struct fuse_dev *fud, *new_fud;
+	struct list_head *pq;
 
 	if (get_user(oldfd, argp))
 		return -EFAULT;
@@ -2599,8 +2600,12 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
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
index 77f1c7cf24d2..e22d65e5ecff 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -1340,8 +1340,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
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
index 7065614d02c9..f388d57fdd8f 100644
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
@@ -1633,33 +1640,38 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
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
@@ -1687,13 +1699,12 @@ EXPORT_SYMBOL_GPL(fuse_dev_install);
 
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
@@ -1871,10 +1882,14 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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
@@ -1946,7 +1961,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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

