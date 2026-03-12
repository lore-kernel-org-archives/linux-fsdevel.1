Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B4438CFF5
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773344430; cv=none; b=Zo4AzxIBWquAzDlJevuO/FjiIgJvTBxfRRBPIrVzrjt001Wlkne0Q82EgO8uBZJjJMXTwS6rNcCwy8ERGJSPvVc/hsN6f1nxzKaq3v0ZOliJhos9LDCVfLvx/hrqVulXwepUBKH1iowgFedfmPm3LmaX6mKo7VYCc1k634lwSlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773344430; c=relaxed/simple;
	bh=LeIHoSq/qGwaVKH2Ui43XdQGP5X4RqiER5tApESjKFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LjQ8uFSrdRTJoOTh0a1QD9BxxlsWr9vWRNriRV0LeZ3PBZ/tI9iHeh4xSa6p6QG4XYgHS8wk1rswes/QXbYQRgkhd74kKWMvmWinCNbuZh/v9UUDXmOP2BK1OkpuXD3UgtIUZohIB1usMn9SQuNoTcWqpiVKmCfEwx9GP7E6qII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hHGRl63G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PM5z2N4L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHGRl63G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PM5z2N4L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773344427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YVejvnwjtS3jvgLA7nPcdjuWEkQWUH3wzvFH+atQxns=;
	b=hHGRl63GibxB0L4L431ypNniDxtaOOXByYsb7Nco/dgBoLoGic6XgPqKYPYwdsgRlxI0ye
	mbNFk3PfflWVC8Efkl6faqk++L8TVU7FIRMUHMz1xiprDb6JbeOKKK+zTR4u7ZcECNcsWA
	/gqsP1Fmyqjyg48PSLt3M4I/eusaR3w=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-vJSYHk30ObugydJTqGws6g-1; Thu, 12 Mar 2026 15:40:25 -0400
X-MC-Unique: vJSYHk30ObugydJTqGws6g-1
X-Mimecast-MFC-AGG-ID: vJSYHk30ObugydJTqGws6g_1773344424
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4853b474594so19210925e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2026 12:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773344424; x=1773949224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVejvnwjtS3jvgLA7nPcdjuWEkQWUH3wzvFH+atQxns=;
        b=PM5z2N4LkXCRZaTioHMvyz8aWc/rhEa7qCbMicLmJ8l/fP2RoBX1kTHcywZ5WNg+Gn
         8Rj/i3b+uzjXPDjBCdijf2S/kpqCe730ywwP8X7Dl1heexOkV9YbKoAO6TceGkeNJWKs
         8hmoYIIlxHIgAewL1WeYgbxIx/nmMyFacvvuuD2TeDgA6WmLhHQv8juVvgUHMnr8KJey
         QB6hKe5Tnoe8k36Lm9NrueplkNj2u1byD0UfcANUvY3n4IvaCWR4nv45MGOK5ByxoWju
         PfTl1jkZ28nEWSsfuML0hv5XfBtcqNpn7pKu7E9o415zkDyq5SkAtLUYajVltyH6PCIE
         I6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773344424; x=1773949224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVejvnwjtS3jvgLA7nPcdjuWEkQWUH3wzvFH+atQxns=;
        b=lXoHWKxGl51sI5s3PvMWhSqt1iUs6IqVioKsN+PAs9Yd/bE2G7fB9YkA/GRR1+gEg1
         /LaUiFXm2UnDuOtogohNLWAvumB1C44WP/lx9H894vVAFYJ0jBxXuYXXi6wYkyF3BLUI
         wxasgEk4UP/KslDihNj1J5t6nnYR4JxorNToijufVm1nN0HmwSs1pnxtmp23Ng/yoCpz
         5QkG4pNiA2/n13vSFp6bH8NgyIqc03fW7Gjgqg5FFq9lsMolVEdeWAon12AFNFkXnv8l
         tb+XJCOjZhYphMHniPOejDLprytmfzA/v20Oxi+7S62BesgkHcPBuBIkQ2m2HH/pU18N
         HM4w==
X-Gm-Message-State: AOJu0YzKdI1lTsUhZp+IzfTvcQTe2ycZxSsjbzPuoexKfnzu8a+do+ok
	sfh1Qcqo8mhgUjXg1Bco9plN3C4nxfjq6Fb2AjVxNOg5DxeTqXoGLqzvLsWY+7FKSz139M7pGg3
	Pie1VgfOuG/GdExzOdxncYw+cMcYAKN4QwqXXYvBAulRCdNoszf/sgv23r/xrM/tPGOeFDYeMil
	/Im05zQ0fQ/WsgrzFtGcImU40oeKCRR63brfhY3b8CNdmVIB0/jkE=
X-Gm-Gg: ATEYQzzSqUq2zfihIqPe7FN0Ocv7oYIfEiSL8rYN2dYlAhgIoc5PSqd5KDJPagKjSH2
	H7S+AF4xjteaH3CPIHXBnLE0AyYer453iFZ5KVl+VRZKbEdIT4c+NCoQ04CuDDkiQ0OMejS93uE
	SOC6UgdvX1oX0jL6M2RkeKVrqjDHXcTxYmx/IA5krVBsOMgiT1/p6pamgW88G/3Sjmnq8E31+Vk
	0slWwmMSCQ3/mH7pOUVSdiwr0FBy1Dwp9dmhqXn6p9b5UDVlIoYfEqKcyNmnISNjnKRlrrmaF/q
	uc6DeVFPauR+V4p0fzZ1eaCNYZZyj0ANERlNlUvohPOIuFpm/bGPayqRaPjquC9LkxzdCxqvH3I
	vEhE2fb5CAf/AtRN5vmKEB+5+WT4Y8LlZR74u3FTqB+YKb4a5a27fon1FJ3JL5eu6hBtbzUFnmS
	iHDW0=
X-Received: by 2002:a05:600c:4752:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-48555ac714fmr15490485e9.7.1773344424062;
        Thu, 12 Mar 2026 12:40:24 -0700 (PDT)
X-Received: by 2002:a05:600c:4752:b0:485:38f1:5cec with SMTP id 5b1f17b1804b1-48555ac714fmr15490125e9.7.1773344423526;
        Thu, 12 Mar 2026 12:40:23 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (176-241-63-127.pool.digikabel.hu. [176.241.63.127])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b5e912fsm396705955e9.2.2026.03.12.12.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 12:40:22 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v2 2/6] fuse: add refcount to fuse_dev
Date: Thu, 12 Mar 2026 20:40:00 +0100
Message-ID: <20260312194019.3077902-3-mszeredi@redhat.com>
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

This will make it possible to grab the fuse_dev and subsequently release
the file that it came from.

In the above case, fud->fc will be set to FUSE_DEV_FC_DISCONNECTED to
indicate that this is no longer a functional device.

When trying to assign an fc to such a disconnected fuse_dev, the fc is set
to the disconnected state.

Use atomic operations xchg() and cmpxchg() to prevent races.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c       |  2 +-
 fs/fuse/dev.c        |  9 +++++++--
 fs/fuse/fuse_dev_i.h | 11 ++++-------
 fs/fuse/fuse_i.h     |  6 ++++--
 fs/fuse/inode.c      | 43 +++++++++++++++++++++++++++++++++++--------
 fs/fuse/virtio_fs.c  |  2 +-
 6 files changed, 52 insertions(+), 21 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index dfcb98a654d8..174333633471 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -527,7 +527,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	cc->fc.initialized = 1;
 	rc = cuse_send_init(cc);
 	if (rc) {
-		fuse_dev_free(fud);
+		fuse_dev_put(fud);
 		return rc;
 	}
 	file->private_data = fud;
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4795e3d01b75..3adf6bd38c9b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2527,7 +2527,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = fuse_file_to_fud(file);
-	struct fuse_conn *fc = fuse_dev_fc_get(fud);
+	/* Pairs with cmpxchg() in fuse_dev_install() */
+	struct fuse_conn *fc = xchg(&fud->fc, FUSE_DEV_FC_DISCONNECTED);
 
 	if (fc) {
 		struct fuse_pqueue *fpq = &fud->pq;
@@ -2547,8 +2548,12 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 			WARN_ON(fc->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
+		spin_lock(&fc->lock);
+		list_del(&fud->entry);
+		spin_unlock(&fc->lock);
+		fuse_conn_put(fc);
 	}
-	fuse_dev_free(fud);
+	fuse_dev_put(fud);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_release);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 522b2012cd1f..9eae14ace73c 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,22 +39,19 @@ struct fuse_copy_state {
 	} ring;
 };
 
+/* fud->fc gets assigned to this value when /dev/fuse is closed */
+#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)
+
 /*
  * Lockless access is OK, because fud->fc is set once during mount and is valid
  * until the file is released.
  */
 static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
 {
-	/* Pairs with smp_store_release() in fuse_dev_fc_set() */
+	/* Pairs with xchg() in fuse_dev_install() */
 	return smp_load_acquire(&fud->fc);
 }
 
-static inline void fuse_dev_fc_set(struct fuse_dev *fud, struct fuse_conn *fc)
-{
-	/* Pairs with smp_load_acquire() in fuse_dev_fc_get() */
-	smp_store_release(&fud->fc, fc);
-}
-
 static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
 {
 	return file->private_data;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 739220d96b6f..66ec92f06497 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -576,6 +576,8 @@ struct fuse_pqueue {
  * Fuse device instance
  */
 struct fuse_dev {
+	refcount_t ref;
+
 	bool sync_init;
 
 	/** Fuse connection for this device */
@@ -1341,8 +1343,8 @@ void fuse_conn_put(struct fuse_conn *fc);
 
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
-void fuse_dev_free(struct fuse_dev *fud);
+bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
+void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 53663846db36..ba845092e7f2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1622,6 +1622,7 @@ struct fuse_dev *fuse_dev_alloc(void)
 	if (!fud)
 		return NULL;
 
+	refcount_set(&fud->ref, 1);
 	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
 	if (!pq) {
 		kfree(fud);
@@ -1635,12 +1636,32 @@ struct fuse_dev *fuse_dev_alloc(void)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
+bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 {
-	fuse_dev_fc_set(fud, fuse_conn_get(fc));
+	struct fuse_conn *old_fc;
+
+	fuse_conn_get(fc);
 	spin_lock(&fc->lock);
+	/*
+	 * Pairs with:
+	 *  - xchg() in fuse_dev_release()
+	 *  - smp_load_acquire() in fuse_dev_fc_get()
+	 */
+	old_fc = cmpxchg(&fud->fc, NULL, fc);
+	if (old_fc) {
+		/*
+		 * failed to set fud->fc because
+		 *  - it was already set to a different fc
+		 *  - it was set to disconneted
+		 */
+		spin_unlock(&fc->lock);
+		fuse_conn_put(fc);
+		return false;
+	}
 	list_add_tail(&fud->entry, &fc->devices);
 	spin_unlock(&fc->lock);
+
+	return true;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_install);
 
@@ -1657,11 +1678,15 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
-void fuse_dev_free(struct fuse_dev *fud)
+void fuse_dev_put(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc = fuse_dev_fc_get(fud);
+	struct fuse_conn *fc;
 
-	if (fc) {
+	if (!refcount_dec_and_test(&fud->ref))
+		return;
+
+	fc = fuse_dev_fc_get(fud);
+	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
 		spin_lock(&fc->lock);
 		list_del(&fud->entry);
 		spin_unlock(&fc->lock);
@@ -1671,7 +1696,7 @@ void fuse_dev_free(struct fuse_dev *fud)
 	kfree(fud->pq.processing);
 	kfree(fud);
 }
-EXPORT_SYMBOL_GPL(fuse_dev_free);
+EXPORT_SYMBOL_GPL(fuse_dev_put);
 
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
@@ -1900,8 +1925,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
 	if (fud) {
-		fuse_dev_install(fud, fc);
-		wake_up_all(&fuse_dev_waitq);
+		if (!fuse_dev_install(fud, fc))
+			fc->connected = 0; /* device file got closed */
+		else
+			wake_up_all(&fuse_dev_waitq);
 	}
 	mutex_unlock(&fuse_mutex);
 	return 0;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f685916754ad..12300651a0f1 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -486,7 +486,7 @@ static void virtio_fs_free_devs(struct virtio_fs *fs)
 		if (!fsvq->fud)
 			continue;
 
-		fuse_dev_free(fsvq->fud);
+		fuse_dev_put(fsvq->fud);
 		fsvq->fud = NULL;
 	}
 }
-- 
2.53.0

