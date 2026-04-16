Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26B39A049
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331036; cv=none; b=Uy+tuAPXuryR6qY49RwxATQQcBygmNSsWOHOg7SZy+maxwOsXsNRCGA/1otvV/1geS53e/S+Tf698IPSoo4pQKhVtYTzvBpOUM3Kjlknh2OxohudFKiGsX3kRY3WoKKJrts4c29/IQNXh4rl1GcbTfam9APBpmfrMgj7NThYBS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331036; c=relaxed/simple;
	bh=y+orVCH+zQgPdqn2Eusu6Cek91uZkd142JxB1UoYGcY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZFa0u73uxwkoRloIJPtDIZ7Zaq3kJZHVm/2NPusHXhpI/9GKMIsGInGr/I8vjH62YrJZ3DXfTZSvPL1MNXq+uqud5x4oHf35kmRvtTuz8koioYGrdkkaZw27TqUeZ45Hn0cxd3D9cSs00TZy7vPQcD4ZRix0AGZZ06QZGcDw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WlxOY9Jh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hgQ8sPis; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlxOY9Jh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hgQ8sPis"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yhm7tF2hpHOWx+f/PeP+VBuIollGckemDuVHUk3dgZU=;
	b=WlxOY9JhwoipFkPL06k7aTrkfGsLJz37K4AI3XupX9cnKKQrFH2lClOvNn7okoac4Fr8RK
	5SyDkCQpma9lvywnbjniHHqel3glLunCQ/EJ2Pbut7bdfSjrSUenlLdK6PVxxy3pr0ezDf
	5qQ2gVkycL/qAGbFAS2BaUP6IO6gk2E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-155-6mvvidQoN9Ck4rZw2h3zRw-1; Thu, 16 Apr 2026 05:17:08 -0400
X-MC-Unique: 6mvvidQoN9Ck4rZw2h3zRw-1
X-Mimecast-MFC-AGG-ID: 6mvvidQoN9Ck4rZw2h3zRw_1776331028
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d1dfad98so45016815e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331027; x=1776935827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yhm7tF2hpHOWx+f/PeP+VBuIollGckemDuVHUk3dgZU=;
        b=hgQ8sPisj4Wf8NLv4im0tM7Q1H9cVK3xd0HaFEeCNj5V09Bf3RihPL4GnyBLBxW4+d
         +89JTGpbrY8WCRk6MgCAW0qkI5rBlJH0ZLZbGK3jOP6CWOYIUGL2Oo62eSOUjMoZpekk
         LMl+NpCaIgHJSMgzQTmzwFz1fq+JjNPHsrceFr5kd2R6Wr7fb9FWBX9BM31/tDLVnLTY
         w9VFLemo7+/nXQrggz035LNNDPaU311Pz4oRK97XSJdv3x5OtTUEP9VPXrXfp17UlCzk
         0wDqHWHThdw/hj3ZDtGdBaDF2Skx/vQQa/LIbAkUQDdbtbboR2WmYHKBL3bByxc19z/Z
         iztA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331027; x=1776935827;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Yhm7tF2hpHOWx+f/PeP+VBuIollGckemDuVHUk3dgZU=;
        b=CqMv6poGlGKjHPTX2L5HDaWj9nkhCNYCmhPSJowHws6LRrGJPwyRxIYq6B1qh7G+y2
         CQMjFI/a/6Cf8Vj9w+pMts1lBeMxItAUzy7sfuvpzp0Aadg26awXiI/sTJZwjMhJ6CwF
         44xmi4/85viJYPOQ/DhfKzBXxwaglyDe+83DfWudt8htWBJJiimYiE/N4XGCIztC0x4f
         l6J+hmJ3orehqEKzhmEw6eUj18poOMXnl6EUbpUKfEEmbBapSUIk5UAovP0zgwFJFoLC
         Zp0KhKw22vSOHQRBi8J70sfQobo24i9VjdUjeWAIhqKdCVcj0asKyzAsDJjx9UGSGF0q
         ikgA==
X-Forwarded-Encrypted: i=1; AFNElJ87eQy+ikX+WHNH7PV/+1exGmnSCYRnzjzB8RGBsPi6lnpIaxYBhchFlFq9xKAFdlMLi7fiYieR5DaMrUtS@vger.kernel.org
X-Gm-Message-State: AOJu0YyZvpWj3tuj8zIXi79qkasueHrO9ThWmjQ/Q+HifYUrnoPtUC8T
	ZQhVTpUABWWWRuhoQC9kp4hyu4Dy8hCkfRQXxMtl/M9DZISEFZOcDgc90oWK11Jj2Uuuu6AtyEi
	egng1iXkgnshMLuXpyDblixp7rGqZVRx+IXB4jMsvZaF3XCWSkYmCnh6Q/lss+6shc4J/nBkJCQ
	k=
X-Gm-Gg: AeBDiesQJ3GPlcxTeDR8o86Cd7M8vYjg11H7ZH0wy8opGArgPrXL+/YOW4UcPoAmzYe
	+RW5Z/cgZdVNdIO62pmcU7AB5XGpsmvbu0ecoDj3mlZCzMBd42adCOtjOajG7437MxGrlOyT2UX
	D57Weoi05xw7A4qL6A3j4MYEQCGXLD5hYErkZr4aptnIh5w4NcIekDL1dd7E/agm8mWMIfuqLYT
	Uq0hTV7Z44Ix73LjYj4jvlhHvARiT8qwqbCLr1BDFIM3y34EyS+r8nLOFQH5FGm/27Q8rD+U+Kh
	pnlvnqm/YWEzOkDyjRFlqwj8ttCOSH2w+gYNqn0C3DqW5iJtsH2GpVsc+kjxi2yZaDMfREdMhuJ
	gwO3MPzSk8EyR/V/mx65f4l6ICaAZvIFL4hbW3yZ0XyXamF6YjSnaXqCGoibfWaOXmD8lmUxF6O
	rbLXdERg==
X-Received: by 2002:a05:600c:3b0e:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488d67e65fdmr352299685e9.11.1776331027160;
        Thu, 16 Apr 2026 02:17:07 -0700 (PDT)
X-Received: by 2002:a05:600c:3b0e:b0:487:20ee:bef6 with SMTP id 5b1f17b1804b1-488d67e65fdmr352298905e9.11.1776331026553;
        Thu, 16 Apr 2026 02:17:06 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/32] fuse: move fuse_dev and fuse_pqueue to dev.c
Date: Thu, 16 Apr 2026 11:16:28 +0200
Message-ID: <20260416091658.462783-5-mszeredi@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416091658.462783-1-mszeredi@redhat.com>
References: <20260416091658.462783-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move function definitions to dev.c, struct definitions to fuse_dev_i.h.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 94 ++++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev.h        |  4 ++
 fs/fuse/fuse_dev_i.h | 46 ++++++++++++++++++++++
 fs/fuse/fuse_i.h     | 46 ----------------------
 fs/fuse/inode.c      | 94 --------------------------------------------
 5 files changed, 144 insertions(+), 140 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d3bcd8a11b40..416c144c6e0d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -364,6 +364,100 @@ struct fuse_chan *fuse_dev_chan_new(void)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_chan_new);
 
+void fuse_pqueue_init(struct fuse_pqueue *fpq)
+{
+	unsigned int i;
+
+	spin_lock_init(&fpq->lock);
+	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
+		INIT_LIST_HEAD(&fpq->processing[i]);
+	INIT_LIST_HEAD(&fpq->io);
+	fpq->connected = 1;
+}
+
+struct fuse_dev *fuse_dev_alloc(void)
+{
+	struct fuse_dev *fud;
+	struct list_head *pq;
+
+	fud = kzalloc_obj(struct fuse_dev);
+	if (!fud)
+		return NULL;
+
+	refcount_set(&fud->ref, 1);
+	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
+	if (!pq) {
+		kfree(fud);
+		return NULL;
+	}
+
+	fud->pq.processing = pq;
+	fuse_pqueue_init(&fud->pq);
+
+	return fud;
+}
+EXPORT_SYMBOL_GPL(fuse_dev_alloc);
+
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
+{
+	struct fuse_conn *old_fc;
+
+	spin_lock(&fc->lock);
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
+		fc->connected = 0;
+	} else {
+		list_add_tail(&fud->entry, &fc->devices);
+		fuse_conn_get(fc);
+	}
+	spin_unlock(&fc->lock);
+}
+EXPORT_SYMBOL_GPL(fuse_dev_install);
+
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
+{
+	struct fuse_dev *fud;
+
+	fud = fuse_dev_alloc();
+	if (!fud)
+		return NULL;
+
+	fuse_dev_install(fud, fc);
+	return fud;
+}
+EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
+
+void fuse_dev_put(struct fuse_dev *fud)
+{
+	struct fuse_conn *fc;
+
+	if (!refcount_dec_and_test(&fud->ref))
+		return;
+
+	fc = fuse_dev_fc_get(fud);
+	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
+		/* This is the virtiofs case (fuse_dev_release() not called) */
+		spin_lock(&fc->lock);
+		list_del(&fud->entry);
+		spin_unlock(&fc->lock);
+
+		fuse_conn_put(fc);
+	}
+	kfree(fud->pq.processing);
+	kfree(fud);
+}
+EXPORT_SYMBOL_GPL(fuse_dev_put);
+
 static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index d5ccfae80115..1f8f2cf1ecfd 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -7,6 +7,7 @@
 
 struct fuse_conn;
 struct fuse_chan;
+struct fuse_dev;
 
 struct fuse_chan *fuse_chan_new(void);
 struct fuse_chan *fuse_dev_chan_new(void);
@@ -14,6 +15,9 @@ void fuse_chan_release(struct fuse_chan *fch);
 void fuse_chan_free(struct fuse_chan *fch);
 DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
+void fuse_dev_put(struct fuse_dev *fud);
+
 void fuse_init_server_timeout(struct fuse_conn *fc, unsigned int timeout);
 
 #endif /* _FS_FUSE_DEV_H */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index eca9d463d571..e80409c2f496 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -92,6 +92,43 @@ struct fuse_chan {
 	struct fuse_iqueue iq;
 };
 
+#define FUSE_PQ_HASH_BITS 8
+#define FUSE_PQ_HASH_SIZE (1 << FUSE_PQ_HASH_BITS)
+
+struct fuse_pqueue {
+	/** Connection established */
+	unsigned connected;
+
+	/** Lock protecting accessess to  members of this structure */
+	spinlock_t lock;
+
+	/** Hash table of requests being processed */
+	struct list_head *processing;
+
+	/** The list of requests under I/O */
+	struct list_head io;
+};
+
+/**
+ * Fuse device instance
+ */
+struct fuse_dev {
+	/** Reference count of this object */
+	refcount_t ref;
+
+	/** Issue FUSE_INIT synchronously */
+	bool sync_init;
+
+	/** Fuse connection for this device */
+	struct fuse_conn *fc;
+
+	/** Processing queue */
+	struct fuse_pqueue pq;
+
+	/** list entry on fc->devices */
+	struct list_head entry;
+};
+
 struct fuse_copy_state {
 	struct fuse_req *req;
 	struct iov_iter *iter;
@@ -176,5 +213,14 @@ void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc(void);
+
+/**
+ * Initialize the fuse processing queue
+ */
+void fuse_pqueue_init(struct fuse_pqueue *fpq);
+
+
 #endif
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 29126f5cb66c..fd5f741693ca 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -469,43 +469,6 @@ struct fuse_req {
 	unsigned long create_time;
 };
 
-#define FUSE_PQ_HASH_BITS 8
-#define FUSE_PQ_HASH_SIZE (1 << FUSE_PQ_HASH_BITS)
-
-struct fuse_pqueue {
-	/** Connection established */
-	unsigned connected;
-
-	/** Lock protecting accessess to  members of this structure */
-	spinlock_t lock;
-
-	/** Hash table of requests being processed */
-	struct list_head *processing;
-
-	/** The list of requests under I/O */
-	struct list_head io;
-};
-
-/**
- * Fuse device instance
- */
-struct fuse_dev {
-	/** Reference count of this object */
-	refcount_t ref;
-
-	/** Issue FUSE_INIT synchronously */
-	bool sync_init;
-
-	/** Fuse connection for this device */
-	struct fuse_conn *fc;
-
-	/** Processing queue */
-	struct fuse_pqueue pq;
-
-	/** list entry on fc->devices */
-	struct list_head entry;
-};
-
 enum fuse_dax_mode {
 	FUSE_DAX_INODE_DEFAULT,	/* default */
 	FUSE_DAX_ALWAYS,	/* "-o dax=always" */
@@ -1227,11 +1190,6 @@ void fuse_change_entry_timeout(struct dentry *entry, struct fuse_entry_out *o);
  */
 struct fuse_conn *fuse_conn_get(struct fuse_conn *fc);
 
-/**
- * Initialize the fuse processing queue
- */
-void fuse_pqueue_init(struct fuse_pqueue *fpq);
-
 /**
  * Initialize fuse_conn
  */
@@ -1243,10 +1201,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
  */
 void fuse_conn_put(struct fuse_conn *fc);
 
-struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
-struct fuse_dev *fuse_dev_alloc(void);
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
-void fuse_dev_put(struct fuse_dev *fud);
 int fuse_send_init(struct fuse_mount *fm);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 932d83883ce1..ac6a0b736fb9 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -969,17 +969,6 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-void fuse_pqueue_init(struct fuse_pqueue *fpq)
-{
-	unsigned int i;
-
-	spin_lock_init(&fpq->lock);
-	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-		INIT_LIST_HEAD(&fpq->processing[i]);
-	INIT_LIST_HEAD(&fpq->io);
-	fpq->connected = 1;
-}
-
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 		    struct user_namespace *user_ns, struct fuse_chan *fch)
 {
@@ -1597,89 +1586,6 @@ static int fuse_bdi_init(struct fuse_conn *fc, struct super_block *sb)
 	return 0;
 }
 
-struct fuse_dev *fuse_dev_alloc(void)
-{
-	struct fuse_dev *fud;
-	struct list_head *pq;
-
-	fud = kzalloc_obj(struct fuse_dev);
-	if (!fud)
-		return NULL;
-
-	refcount_set(&fud->ref, 1);
-	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
-	if (!pq) {
-		kfree(fud);
-		return NULL;
-	}
-
-	fud->pq.processing = pq;
-	fuse_pqueue_init(&fud->pq);
-
-	return fud;
-}
-EXPORT_SYMBOL_GPL(fuse_dev_alloc);
-
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
-{
-	struct fuse_conn *old_fc;
-
-	spin_lock(&fc->lock);
-	/*
-	 * Pairs with:
-	 *  - xchg() in fuse_dev_release()
-	 *  - smp_load_acquire() in fuse_dev_fc_get()
-	 */
-	old_fc = cmpxchg(&fud->fc, NULL, fc);
-	if (old_fc) {
-		/*
-		 * failed to set fud->fc because
-		 *  - it was already set to a different fc
-		 *  - it was set to disconneted
-		 */
-		fc->connected = 0;
-	} else {
-		list_add_tail(&fud->entry, &fc->devices);
-		fuse_conn_get(fc);
-	}
-	spin_unlock(&fc->lock);
-}
-EXPORT_SYMBOL_GPL(fuse_dev_install);
-
-struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
-{
-	struct fuse_dev *fud;
-
-	fud = fuse_dev_alloc();
-	if (!fud)
-		return NULL;
-
-	fuse_dev_install(fud, fc);
-	return fud;
-}
-EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
-
-void fuse_dev_put(struct fuse_dev *fud)
-{
-	struct fuse_conn *fc;
-
-	if (!refcount_dec_and_test(&fud->ref))
-		return;
-
-	fc = fuse_dev_fc_get(fud);
-	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
-		/* This is the virtiofs case (fuse_dev_release() not called) */
-		spin_lock(&fc->lock);
-		list_del(&fud->entry);
-		spin_unlock(&fc->lock);
-
-		fuse_conn_put(fc);
-	}
-	kfree(fud->pq.processing);
-	kfree(fud);
-}
-EXPORT_SYMBOL_GPL(fuse_dev_put);
-
 static void fuse_fill_attr_from_inode(struct fuse_attr *attr,
 				      const struct fuse_inode *fi)
 {
-- 
2.53.0

