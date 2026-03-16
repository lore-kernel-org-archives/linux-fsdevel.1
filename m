Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E0D332ED3
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 16:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773680014; cv=none; b=grUl31pok++uC7F60fPjUEbwnIlZeaptOExcLJm2O4c8L2A8CKZ48pKL2iEW6QyNMLyBC6SAcdcvxyMawYXSi2xV0dI5NX+uQr9Jz3OtF/RNzBnSuFl3+EB9ZdwfPfe0P5xqLsRICbg4gGjZB3JaGmVtALLz3FfUjp8mXO+E9NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773680014; c=relaxed/simple;
	bh=V7/0aVvJb0hGmLPYLx/awhgLR82iqF2SL1pKM48WSzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOguEhr646XWKFAYz0CQ9NrsXyM1M6tR3cAwnQwSkvY4HRpUdjXKiFNzY73t8wOCYYFTGSekdjZ5MwZ0A99fIVl1Tai14b54Vkt/XqUyeorNiVWnSEqYBNFoC+klGrncJHzekuZTBiVltS44j7O+ja7ek9HcMN4kRIIfoVf+i2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLIQ8WRN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=KhN60nQ0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLIQ8WRN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="KhN60nQ0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773680009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Kj54NMUu00o5l8o3HK08Ft0maI67U6dhXyaXlc9J+Q=;
	b=aLIQ8WRNsbJhXCqkizjLKgtGJDCsdOLMnxP2qHs5a4PYp3/u91m/9sOAKvJEpJWRNSakAx
	ggiOkWGk2zFaajy/GrUZaMcJmH/xdKYZCVy6C200jwaDCFdZAHDKi2IN1saswq7/QQcc4y
	ytSPsn2F2K/Sd3MlTnddVz/AXWDh58Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-wOF34V9_NqiPzQnVpbJ0hw-1; Mon, 16 Mar 2026 12:53:27 -0400
X-MC-Unique: wOF34V9_NqiPzQnVpbJ0hw-1
X-Mimecast-MFC-AGG-ID: wOF34V9_NqiPzQnVpbJ0hw_1773680006
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so68487225e9.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 09:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773680006; x=1774284806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Kj54NMUu00o5l8o3HK08Ft0maI67U6dhXyaXlc9J+Q=;
        b=KhN60nQ0jkB2NePb9W+ONF2xDUKJBdnjmjQXLghk/xP/7X+ZDp+BOY3Wzr7pARC6wn
         JP6FGNtBF02VR5qltfoYT1cow59uQAcDh3XEixqTunGFEILWE+pVmfF2G1/Mtm4gb5Xh
         RNih4xFeZ86CWI8pVnh04gyrNDRRbgaaBW4sDHRhv6melC9B3bXk4ia5HXNJEUXzBlp7
         pDn4vRecpERSsLeDJxdgmL11cJ4uf3QapfyFwtlGbIjbeknSXs1bSMUU3cE79gkSR2WH
         5UW79cwXJhRpEkKcj+vN+bdbrhEyeTLjKb5LbDzoVMrNdXcDO8GOk6kSYeBfaQOI9QgF
         KdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773680006; x=1774284806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Kj54NMUu00o5l8o3HK08Ft0maI67U6dhXyaXlc9J+Q=;
        b=RoVQXMrRRGehO9DKYANx8ucf6iwgZSiWDnI3KUlJCBgUn7vY6r5+VMiCqkmepTAeS0
         37RmhtHdZOF4JkRKnPG9UW/OiY2VLDDmtknGt7bx9RtIhL/AUhvrFY7AD36jh3aVdRDO
         cjX3ShbmKAuHGibyYXewcFRum+6p5U7JYeh/mqw8PcU27aQwXGMzK7U4FmO9joDt0VGp
         bTB68YsDYTvrPyxhMxfgDNP3QFiqiqW2ec7JjhAtDstOwjDhE+UnDo3dYQ3jUbvkAKR0
         Cu/V++KlQX45qh45e2vF2Z2NtQX1HnhKYg/rScuc1iIwT7XUYXgAgzJjJiakXwVx6N+2
         UcLQ==
X-Gm-Message-State: AOJu0YxCH4tFZ6jmM2EX4FCW44GgIjj5vFXQwaklf7zSYOs9SIIq9lMg
	SDN+iiAoALovRykLATvj8njeK0FgJ7bCY1MhZe6amlzoWbFvA6gNgdmR3dRVLDVu21HueruYzmo
	Kxpmny6ETMjGwPSddT7xqHZbrA0e5gJrLY4Go86pwmUJW8FQdh8hFb/2TUUqPwhOzzTqv/jI7rh
	VblavPd+kKcBfHw4zHmYrj860yumlvxSkE4QY8VWrlaSyOaE07mlE=
X-Gm-Gg: ATEYQzx4SHI5x7M8uWmKh9AkRvTf3duxxbIGJ4syfaMYPtNDL23S54Mzc0AxAnbEcbx
	6JoJXIEaRRkqKMPgkfQV46SoVEVUtOTHYjJfoSLIAKjOyltNM6NN5yI5ZgOYdyt9AwHLwCqsILF
	O8kQCvYj6IR9EN99HwKFyJ/BAbe/zBjT3Sdb8Zj/VC9LY1EeBk1PEpWNPaq/C+UihZT4qycNvJC
	nSn6+qIdJrESH/gah5WPQnictI9CUpKiRj6cWnChnx/LMkeCNwBrrigJaNvmlG8fYCVAT59p4m+
	x9uRs9WP4YMDSR0t6vZOvQ12RcTpg6GLMjCXrjM6398J/dnzrcmS9WS+pcq2s25RyKzJ5j9wb1G
	6mRCKeq6Jshez/47MOy89XJue097zx4AZUijOINhIScNiybS6XfgHrkFTyD4yZcLJ+6g0OzGqkQ
	==
X-Received: by 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48556702853mr226323535e9.21.1773680006170;
        Mon, 16 Mar 2026 09:53:26 -0700 (PDT)
X-Received: by 2002:a05:600c:8b45:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-48556702853mr226322935e9.21.1773680005621;
        Mon, 16 Mar 2026 09:53:25 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-67-172-54.pool.digikabel.hu. [85.67.172.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4856ea9c340sm4978295e9.7.2026.03.16.09.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 09:53:24 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: Bernd Schubert <bernd@bsbernd.com>
Subject: [PATCH v3 3/7] fuse: add refcount to fuse_dev
Date: Mon, 16 Mar 2026 17:53:14 +0100
Message-ID: <20260316165320.3245526-4-mszeredi@redhat.com>
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
 fs/fuse/fuse_dev_i.h | 15 ++++++++-------
 fs/fuse/fuse_i.h     |  7 +++++--
 fs/fuse/inode.c      | 44 ++++++++++++++++++++++++++++++++++++--------
 fs/fuse/virtio_fs.c  |  2 +-
 6 files changed, 58 insertions(+), 21 deletions(-)

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
index fe453634897b..4c926c9c4f39 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2531,7 +2531,8 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = fuse_file_to_fud(file);
-	struct fuse_conn *fc = fuse_dev_fc_get(fud);
+	/* Pairs with cmpxchg() in fuse_dev_install() */
+	struct fuse_conn *fc = xchg(&fud->fc, FUSE_DEV_FC_DISCONNECTED);
 
 	if (fc) {
 		struct fuse_pqueue *fpq = &fud->pq;
@@ -2551,8 +2552,12 @@ int fuse_dev_release(struct inode *inode, struct file *file)
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
index 522b2012cd1f..910f883cd090 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -39,22 +39,23 @@ struct fuse_copy_state {
 	} ring;
 };
 
+/* fud->fc gets assigned to this value when /dev/fuse is closed */
+#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)
+
 /*
  * Lockless access is OK, because fud->fc is set once during mount and is valid
  * until the file is released.
+ *
+ * fud->fc is set to FUSE_DEV_FC_DISCONNECTED only after the containing file is
+ * released, so result is safe to dereference in most cases.  Exceptions are:
+ * fuse_dev_put() and fuse_fill_super_common().
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
index 94b49384a2f7..230201dc3f90 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -577,6 +577,9 @@ struct fuse_pqueue {
  * Fuse device instance
  */
 struct fuse_dev {
+	/** Reference count of this object */
+	refcount_t ref;
+
 	/** Issue FUSE_INIT synchronously */
 	bool sync_init;
 
@@ -1343,8 +1346,8 @@ void fuse_conn_put(struct fuse_conn *fc);
 
 struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
 struct fuse_dev *fuse_dev_alloc(void);
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
-void fuse_dev_free(struct fuse_dev *fud);
+bool fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
+void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index c2d1184d5ba5..0e848e3a13c2 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1623,6 +1623,7 @@ struct fuse_dev *fuse_dev_alloc(void)
 	if (!fud)
 		return NULL;
 
+	refcount_set(&fud->ref, 1);
 	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
 	if (!pq) {
 		kfree(fud);
@@ -1636,12 +1637,32 @@ struct fuse_dev *fuse_dev_alloc(void)
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
 
@@ -1658,11 +1679,16 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
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
+		/* This is the virtiofs case (fuse_dev_release() not called) */
 		spin_lock(&fc->lock);
 		list_del(&fud->entry);
 		spin_unlock(&fc->lock);
@@ -1672,7 +1698,7 @@ void fuse_dev_free(struct fuse_dev *fud)
 	kfree(fud->pq.processing);
 	kfree(fud);
 }
-EXPORT_SYMBOL_GPL(fuse_dev_free);
+EXPORT_SYMBOL_GPL(fuse_dev_put);
 
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
@@ -1901,8 +1927,10 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
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

