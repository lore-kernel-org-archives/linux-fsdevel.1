Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295039B973
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331071; cv=none; b=ICupMNzeJHbG2cXHT6rlTcC+tvLmr1ADbZGLl9GLfcLuvuSzGTpwUmQWIowJL6M3oJJ0n8FczGUU8IaSXcj+zhQyteWf5EUqeXx/hKda+QX/3VVDaQMwA1menuA7cjyypz9jqMLCPynrCeR636qvKfKkdRzBThtFI9ZosHtNDt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331071; c=relaxed/simple;
	bh=5loFS/euxlawXVeWt3802pcivA2el9WVONMzD26MwaI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQFvByeWQj5ZxSD9Izp92JmSEOsYHacNC+6OsEnN0cA0BjvlOFQAk6qUqIHW0bPmS/iOoKmQ8BPXO0zHsbpCTKuN0cHdfrOYm9rhQ6/VosX28U01Y2b/4QJJD1etJ87bFG3mjyUIDl8CvHKFIEdnFgz6LF2gF5RARcMkX505aJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S57M8UQY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0aVPhyc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S57M8UQY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0aVPhyc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbfjdLx4MGOkOPjrQdQijV6fnhNr+/KcRETAjZnSpCg=;
	b=S57M8UQYLqonLOv55WhWWpTV17VEtOgWlpUz7uvEYJ1Cy+opnJKu/KcBvkgsEz14t8Qkgx
	4vrZJPYJYuhw3hanIsXztA+/p7XI8txpm4esSMW3wJg+/2DUuQXCqBq1Ha2hsX1TCoZJPh
	drqZ2Z0GYdE/SefXKe7zslgV/x7w2Zg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-Ke-E_p-uOUeIRbO_rD7_Uw-1; Thu, 16 Apr 2026 05:17:37 -0400
X-MC-Unique: Ke-E_p-uOUeIRbO_rD7_Uw-1
X-Mimecast-MFC-AGG-ID: Ke-E_p-uOUeIRbO_rD7_Uw_1776331056
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488c2aa6becso62661355e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331056; x=1776935856; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dbfjdLx4MGOkOPjrQdQijV6fnhNr+/KcRETAjZnSpCg=;
        b=L0aVPhycSwCbQcKP09kBZbg3Q4w2bRciN579emQT06qQe7emhAQ5Uv7WS/yUU6ngbN
         h1pv05doNNuHjQfpLxbJsn0Gw8OGPsFKXmydLxRLFZKP6MNWY74tSXvZdP+UNfl7w676
         9aYWVrCbyHTyi7BrE82wVteP7a+7y+7T6ajYneSsXMQ/gzG3iGLaMXirC2oe7zkrXUhf
         NYEcla3tBO4XNqoHEYmYP1D5j1/8Y5jb7aJkNhA0n3XkuxfmJ7bh4UuSAHpZUGOotzre
         ovbUIp2kzwBllZM/k+PhEdN6fM2sC1zQn/3+b03uApnuT8/nQUlEni5N2HZ5JdRvYZCf
         fAmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331056; x=1776935856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dbfjdLx4MGOkOPjrQdQijV6fnhNr+/KcRETAjZnSpCg=;
        b=Oh97DxSfOWDaA2ywvd457MYwqnwESojhF18mHtAbbq6+zcb7X44SkSxHTsU32z8c3R
         D1lAt/jy4vhFz3nRuade84Dep+nP6yY53xYhl+XHFVOzVeWEzuV+lD44WhzoTvZHavBm
         fLv6Fgl3M5hhToD2cOKMG2yBgZJDgk3zjUQPSzGuocBxOBGCXGw0qWRz1fvSI0rjnxs6
         U29rBjD8ebLk6/lYUW3gaoXymDX9oJEaiPgOPcki3P/oMLOYSxu4p/K13KfD1LiPWA8I
         4D++fZ3tK99YotopB2JHZQeTESQjMo1w0ulS+YMKks4JR4owY0DeBjOiLPP6vzmXfkrK
         CrMg==
X-Forwarded-Encrypted: i=1; AFNElJ8xMo+dK3ymxUAwzgNlmc84uh/IXHMYBFH7CGFUYW2G6pcsKU/tL4Ujm1YrmJdkuvLZ9dWqX6INF57i+5FL@vger.kernel.org
X-Gm-Message-State: AOJu0YzsaQsHAQU92mY2M4c5Ix0BCaIVoGeZ7MlDcDRFMdqBx22FvmVM
	w2nAqyZhFQsYdKYtAJAEiBKL8VzD1eT1+oGeF/+0dx3CkGbzRjqbOQeQPgfmPGd1owG+DJ79/KG
	bblySktJosVIs40JNN5j3JvlkMJr0Kgw97yVAMbqSIxZ/XslrIm17CRxI9ILEzyb8r/+l8OOSId
	4=
X-Gm-Gg: AeBDiesbHfeje1aoH6VZ5fygVtCNbmkT8ONuIbNnu0ZkRY/y8Uombz2SgueNx0mepgs
	eGxXrGvmexyUr/HEYECNma89XaMmyKdS14MdJD+EOiaSuUnzCmCr0nDx7InLcUWu53G3AgCdLRd
	5KFqHj5Is05QY47oS0iAAfXse81f7G3tgs4N7njRMt/jFw9vLpGls+D20zxWh5Hzc5M8K1YYmiw
	EenzfZ9R8X1rpmKFsUEJuBFiSgHvxcNjtsGxElFBa3D7GRWkMm0FlcxjsLzm2yieSnmnZ0Uqr2T
	PoPGyErse9At87Ws4qr2S7WnJDTqD9Qg6PGu5Y3GxN96EOzMRoxvkN4/gK/Lbi2j5JmLFSHWvyD
	P25/+OCIvdcumXVTBBkC860r37oYt0NDXZ+TK+xDCM+LsVtdHDfnppOn5JZdTMXxyHFoCEw0/2a
	QSXdBhvw==
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr329678055e9.10.1776331055510;
        Thu, 16 Apr 2026 02:17:35 -0700 (PDT)
X-Received: by 2002:a05:600c:45cd:b0:488:9ed3:1492 with SMTP id 5b1f17b1804b1-488d67f0bb7mr329677355e9.10.1776331054834;
        Thu, 16 Apr 2026 02:17:34 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:33 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/32] fuse: change fud->fc to fud->chan
Date: Thu, 16 Apr 2026 11:16:48 +0200
Message-ID: <20260416091658.462783-25-mszeredi@redhat.com>
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

Store pointer to struct fuse_chan instead of struct fuse_conn in fuse_dev.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c       |  4 +-
 fs/fuse/dev.c        | 96 ++++++++++++++++++++++----------------------
 fs/fuse/dev.h        |  4 +-
 fs/fuse/dev_uring.c  | 54 ++++++++++++-------------
 fs/fuse/fuse_dev_i.h | 20 ++++-----
 fs/fuse/inode.c      |  4 +-
 fs/fuse/virtio_fs.c  |  2 +-
 7 files changed, 92 insertions(+), 92 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index bf5724415b04..bac327cfc7f1 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -521,7 +521,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 */
 	fuse_conn_init(&cc->fc, &cc->fm, file->f_cred->user_ns, no_free_ptr(fch));
 	cc->fc.release = cuse_fc_release;
-	fud = fuse_dev_alloc_install(&cc->fc);
+	fud = fuse_dev_alloc_install(cc->fc.chan);
 	fuse_conn_put(&cc->fc);
 	if (!fud)
 		return -ENOMEM;
@@ -553,7 +553,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 static int cuse_channel_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = __fuse_get_dev(file);
-	struct cuse_conn *cc = fc_to_cc(fud->fc);
+	struct cuse_conn *cc = fc_to_cc(fud->chan->conn);
 
 	/* remove from the conntbl, no more access from this point on */
 	mutex_lock(&cuse_lock);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 95b8de20542a..f3d16a224df7 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -430,34 +430,34 @@ struct fuse_dev *fuse_dev_alloc(void)
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc);
 
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch)
 {
-	struct fuse_conn *old_fc;
+	struct fuse_chan *old_fch;
 
-	spin_lock(&fc->chan->lock);
+	spin_lock(&fch->lock);
 	/*
 	 * Pairs with:
 	 *  - xchg() in fuse_dev_release()
 	 *  - smp_load_acquire() in fuse_dev_fc_get()
 	 */
-	old_fc = cmpxchg(&fud->fc, NULL, fc);
-	if (old_fc) {
+	old_fch = cmpxchg(&fud->chan, NULL, fch);
+	if (old_fch) {
 		/*
-		 * failed to set fud->fc because
+		 * failed to set fud->chan because
 		 *  - it was already set to a different fc
 		 *  - it was set to disconneted
 		 */
-		fc->chan->connected = 0;
+		fch->connected = 0;
 	} else {
-		list_add_tail(&fud->entry, &fc->chan->devices);
-		fuse_conn_get(fc);
+		list_add_tail(&fud->entry, &fch->devices);
+		fuse_conn_get(fch->conn);
 		wake_up_all(&fuse_dev_waitq);
 	}
-	spin_unlock(&fc->chan->lock);
+	spin_unlock(&fch->lock);
 }
 EXPORT_SYMBOL_GPL(fuse_dev_install);
 
-struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_chan *fch)
 {
 	struct fuse_dev *fud;
 
@@ -465,26 +465,26 @@ struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc)
 	if (!fud)
 		return NULL;
 
-	fuse_dev_install(fud, fc);
+	fuse_dev_install(fud, fch);
 	return fud;
 }
 EXPORT_SYMBOL_GPL(fuse_dev_alloc_install);
 
 void fuse_dev_put(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc;
+	struct fuse_chan *fch;
 
 	if (!refcount_dec_and_test(&fud->ref))
 		return;
 
-	fc = fuse_dev_fc_get(fud);
-	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
+	fch = fuse_dev_chan_get(fud);
+	if (fch && fch != FUSE_DEV_CHAN_DISCONNECTED) {
 		/* This is the virtiofs case (fuse_dev_release() not called) */
-		spin_lock(&fc->chan->lock);
+		spin_lock(&fch->lock);
 		list_del(&fud->entry);
-		spin_unlock(&fc->chan->lock);
+		spin_unlock(&fch->lock);
 
-		fuse_conn_put(fc);
+		fuse_conn_put(fch->conn);
 	}
 	kfree(fud->pq.processing);
 	kfree(fud);
@@ -493,17 +493,17 @@ EXPORT_SYMBOL_GPL(fuse_dev_put);
 
 bool fuse_dev_is_installed(struct fuse_dev *fud)
 {
-	struct fuse_conn *fc = fuse_dev_fc_get(fud);
+	struct fuse_chan *fch = fuse_dev_chan_get(fud);
 
-	return fc != NULL && fc != FUSE_DEV_FC_DISCONNECTED;
+	return fch != NULL && fch != FUSE_DEV_CHAN_DISCONNECTED;
 }
 
 /*
  * Checks if @fc matches the one installed in @fud
  */
-bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_conn *fc)
+bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_chan *fch)
 {
-	return fuse_dev_fc_get(fud) == fc;
+	return fuse_dev_chan_get(fud) == fch;
 }
 
 bool fuse_dev_is_sync_init(struct fuse_dev *fud)
@@ -1491,8 +1491,8 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 				struct fuse_copy_state *cs, size_t nbytes)
 {
 	ssize_t err;
-	struct fuse_conn *fc = fud->fc;
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_chan *fch = fud->chan;
+	struct fuse_iqueue *fiq = &fch->iq;
 	struct fuse_pqueue *fpq = &fud->pq;
 	struct fuse_req *req;
 	struct fuse_args *args;
@@ -1514,7 +1514,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	if (nbytes < max_t(size_t, FUSE_MIN_READ_BUFFER,
 			   sizeof(struct fuse_in_header) +
 			   sizeof(struct fuse_write_in) +
-			   fc->max_write))
+			   fch->conn->max_write))
 		return -EINVAL;
 
  restart:
@@ -1533,7 +1533,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	}
 
 	if (!fiq->connected) {
-		err = fc->chan->abort_with_err ? -ECONNABORTED : -ENODEV;
+		err = fch->abort_with_err ? -ECONNABORTED : -ENODEV;
 		goto err_unlock;
 	}
 
@@ -1545,7 +1545,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 
 	if (forget_pending(fiq)) {
 		if (list_empty(&fiq->pending) || fiq->forget_batch-- > 0)
-			return fuse_read_forget(fc, fiq, cs, nbytes);
+			return fuse_read_forget(fch->conn, fiq, cs, nbytes);
 
 		if (fiq->forget_batch <= -8)
 			fiq->forget_batch = 16;
@@ -1589,7 +1589,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
 	if (!fpq->connected) {
-		err = fc->chan->abort_with_err ? -ECONNABORTED : -ENODEV;
+		err = fch->abort_with_err ? -ECONNABORTED : -ENODEV;
 		goto out_end;
 	}
 	if (err) {
@@ -1641,7 +1641,7 @@ struct fuse_dev *fuse_get_dev(struct file *file)
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 	int err;
 
-	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_fc_get(fud) != NULL);
+	err = wait_event_interruptible(fuse_dev_waitq, fuse_dev_chan_get(fud) != NULL);
 	if (err)
 		return ERR_PTR(err);
 
@@ -2263,7 +2263,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 				 struct fuse_copy_state *cs, size_t nbytes)
 {
 	int err;
-	struct fuse_conn *fc = fud->fc;
+	struct fuse_chan *fch = fud->chan;
 	struct fuse_pqueue *fpq = &fud->pq;
 	struct fuse_req *req;
 	struct fuse_out_header oh;
@@ -2285,7 +2285,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	 * and error contains notification code.
 	 */
 	if (!oh.unique) {
-		err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
+		err = fuse_notify(fch->conn, oh.error, nbytes - sizeof(oh), cs);
 		goto copy_finish;
 	}
 
@@ -2313,7 +2313,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 		if (nbytes != sizeof(struct fuse_out_header))
 			err = -EINVAL;
 		else if (oh.error == -ENOSYS)
-			fc->chan->no_interrupt = true;
+			fch->no_interrupt = 1;
 		else if (oh.error == -EAGAIN)
 			err = queue_interrupt(req);
 
@@ -2473,7 +2473,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 	if (IS_ERR(fud))
 		return EPOLLERR;
 
-	fiq = &fud->fc->chan->iq;
+	fiq = &fud->chan->iq;
 	poll_wait(file, &fiq->waitq, wait);
 
 	spin_lock(&fiq->lock);
@@ -2623,9 +2623,9 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 	/* Pairs with cmpxchg() in fuse_dev_install() */
-	struct fuse_conn *fc = xchg(&fud->fc, FUSE_DEV_FC_DISCONNECTED);
+	struct fuse_chan *fch = xchg(&fud->chan, FUSE_DEV_CHAN_DISCONNECTED);
 
-	if (fc) {
+	if (fch) {
 		struct fuse_pqueue *fpq = &fud->pq;
 		LIST_HEAD(to_end);
 		unsigned int i;
@@ -2639,17 +2639,17 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		fuse_dev_end_requests(&to_end);
 
-		spin_lock(&fc->chan->lock);
+		spin_lock(&fch->lock);
 		list_del(&fud->entry);
 		/* Are we the last open device? */
-		last = list_empty(&fc->chan->devices);
-		spin_unlock(&fc->chan->lock);
+		last = list_empty(&fch->devices);
+		spin_unlock(&fch->lock);
 
 		if (last) {
-			WARN_ON(fc->chan->iq.fasync != NULL);
-			fuse_chan_abort(fc->chan, false);
+			WARN_ON(fch->iq.fasync != NULL);
+			fuse_chan_abort(fch, false);
 		}
-		fuse_conn_put(fc);
+		fuse_conn_put(fch->conn);
 	}
 	fuse_dev_put(fud);
 	return 0;
@@ -2664,7 +2664,7 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 		return PTR_ERR(fud);
 
 	/* No locking - fasync_helper does its own locking */
-	return fasync_helper(fd, file, on, &fud->fc->chan->iq.fasync);
+	return fasync_helper(fd, file, on, &fud->chan->iq.fasync);
 }
 
 static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
@@ -2691,10 +2691,10 @@ static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
 		return PTR_ERR(fud);
 
 	new_fud = fuse_file_to_fud(file);
-	if (fuse_dev_fc_get(new_fud))
+	if (fuse_dev_chan_get(new_fud))
 		return -EINVAL;
 
-	fuse_dev_install(new_fud, fud->fc);
+	fuse_dev_install(new_fud, fud->chan);
 
 	return 0;
 }
@@ -2714,7 +2714,7 @@ static long fuse_dev_ioctl_backing_open(struct file *file,
 	if (copy_from_user(&map, argp, sizeof(map)))
 		return -EFAULT;
 
-	return fuse_backing_open(fud->fc, &map);
+	return fuse_backing_open(fud->chan->conn, &map);
 }
 
 static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
@@ -2731,7 +2731,7 @@ static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user *argp)
 	if (get_user(backing_id, argp))
 		return -EFAULT;
 
-	return fuse_backing_close(fud->fc, backing_id);
+	return fuse_backing_close(fud->chan->conn, backing_id);
 }
 
 static long fuse_dev_ioctl_sync_init(struct file *file)
@@ -2740,7 +2740,7 @@ static long fuse_dev_ioctl_sync_init(struct file *file)
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 
 	mutex_lock(&fuse_mutex);
-	if (!fuse_dev_fc_get(fud)) {
+	if (!fuse_dev_chan_get(fud)) {
 		fud->sync_init = true;
 		err = 0;
 	}
@@ -2778,7 +2778,7 @@ static void fuse_dev_show_fdinfo(struct seq_file *seq, struct file *file)
 	if (!fud)
 		return;
 
-	seq_printf(seq, "fuse_connection:\t%u\n", fud->fc->dev);
+	seq_printf(seq, "fuse_connection:\t%u\n", fud->chan->conn->dev);
 }
 #endif
 
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index fb814a0b6782..9a1f79b130bd 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -36,8 +36,8 @@ void fuse_chan_queue_forget(struct fuse_chan *fch, struct fuse_forget_link *forg
 
 DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 
-void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
-bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_conn *fc);
+void fuse_dev_install(struct fuse_dev *fud, struct fuse_chan *fch);
+bool fuse_dev_verify(struct fuse_dev *fud, struct fuse_chan *fch);
 void fuse_dev_put(struct fuse_dev *fud);
 bool fuse_dev_is_installed(struct fuse_dev *fud);
 bool fuse_dev_is_sync_init(struct fuse_dev *fud);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3ef7977dc8de..87066d6ee782 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -225,14 +225,14 @@ void fuse_uring_destruct(struct fuse_chan *fch)
 /*
  * Basic ring setup for this connection based on the provided configuration
  */
-static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
+static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 {
 	struct fuse_ring *ring;
 	size_t nr_queues = num_possible_cpus();
 	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
 
-	ring = kzalloc_obj(*fc->chan->ring, GFP_KERNEL_ACCOUNT);
+	ring = kzalloc_obj(*ring, GFP_KERNEL_ACCOUNT);
 	if (!ring)
 		return NULL;
 
@@ -241,25 +241,25 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	if (!ring->queues)
 		goto out_err;
 
-	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
-	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
+	max_payload_size = max(FUSE_MIN_READ_BUFFER, fch->conn->max_write);
+	max_payload_size = max(max_payload_size, fch->conn->max_pages * PAGE_SIZE);
 
-	spin_lock(&fc->chan->lock);
-	if (fc->chan->ring) {
+	spin_lock(&fch->lock);
+	if (fch->ring) {
 		/* race, another thread created the ring in the meantime */
-		spin_unlock(&fc->chan->lock);
-		res = fc->chan->ring;
+		spin_unlock(&fch->lock);
+		res = fch->ring;
 		goto out_err;
 	}
 
 	init_waitqueue_head(&ring->stop_waitq);
 
 	ring->nr_queues = nr_queues;
-	ring->fc = fc;
+	ring->fc = fch->conn;
 	ring->max_payload_sz = max_payload_size;
-	smp_store_release(&fc->chan->ring, ring);
+	smp_store_release(&fch->ring, ring);
 
-	spin_unlock(&fc->chan->lock);
+	spin_unlock(&fch->lock);
 	return ring;
 
 out_err:
@@ -874,13 +874,13 @@ static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
 
 /* FUSE_URING_CMD_COMMIT_AND_FETCH handler */
 static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
-				   struct fuse_conn *fc)
+				   struct fuse_chan *fch)
 {
 	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe128_cmd(cmd->sqe,
 								       struct fuse_uring_cmd_req);
 	struct fuse_ring_ent *ent;
 	int err;
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = fch->ring;
 	struct fuse_ring_queue *queue;
 	uint64_t commit_id = READ_ONCE(cmd_req->commit_id);
 	unsigned int qid = READ_ONCE(cmd_req->qid);
@@ -899,7 +899,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 		return err;
 	fpq = &queue->fpq;
 
-	if (!READ_ONCE(fc->chan->connected) || READ_ONCE(queue->stopped))
+	if (!READ_ONCE(fch->connected) || READ_ONCE(queue->stopped))
 		return err;
 
 	spin_lock(&queue->lock);
@@ -1079,11 +1079,11 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
  * entry as "ready to get fuse requests" on the queue
  */
 static int fuse_uring_register(struct io_uring_cmd *cmd,
-			       unsigned int issue_flags, struct fuse_conn *fc)
+			       unsigned int issue_flags, struct fuse_chan *fch)
 {
 	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe128_cmd(cmd->sqe,
 								       struct fuse_uring_cmd_req);
-	struct fuse_ring *ring = smp_load_acquire(&fc->chan->ring);
+	struct fuse_ring *ring = smp_load_acquire(&fch->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
 	int err;
@@ -1091,7 +1091,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 
 	err = -ENOMEM;
 	if (!ring) {
-		ring = fuse_uring_create(fc);
+		ring = fuse_uring_create(fch);
 		if (!ring)
 			return err;
 	}
@@ -1129,7 +1129,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 {
 	struct fuse_dev *fud;
-	struct fuse_conn *fc;
+	struct fuse_chan *fch;
 	u32 cmd_op = cmd->cmd_op;
 	int err;
 
@@ -1147,39 +1147,39 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		pr_info_ratelimited("No fuse device found\n");
 		return PTR_ERR(fud);
 	}
-	fc = fud->fc;
+	fch = fud->chan;
 
 	/* Once a connection has io-uring enabled on it, it can't be disabled */
-	if (!enable_uring && !fc->chan->io_uring) {
+	if (!enable_uring && !fch->io_uring) {
 		pr_info_ratelimited("fuse-io-uring is disabled\n");
 		return -EOPNOTSUPP;
 	}
 
-	if (fc->chan->abort_with_err)
+	if (fch->abort_with_err)
 		return -ECONNABORTED;
-	if (!fc->chan->connected)
+	if (!fch->connected)
 		return -ENOTCONN;
 
 	/*
 	 * fuse_uring_register() needs the ring to be initialized,
 	 * we need to know the max payload size
 	 */
-	if (!fc->chan->initialized)
+	if (!fch->initialized)
 		return -EAGAIN;
 
 	switch (cmd_op) {
 	case FUSE_IO_URING_CMD_REGISTER:
-		err = fuse_uring_register(cmd, issue_flags, fc);
+		err = fuse_uring_register(cmd, issue_flags, fch);
 		if (err) {
 			pr_info_once("FUSE_IO_URING_CMD_REGISTER failed err=%d\n",
 				     err);
-			fc->chan->io_uring = 0;
-			wake_up_all(&fc->chan->blocked_waitq);
+			fch->io_uring = 0;
+			wake_up_all(&fch->blocked_waitq);
 			return err;
 		}
 		break;
 	case FUSE_IO_URING_CMD_COMMIT_AND_FETCH:
-		err = fuse_uring_commit_fetch(cmd, issue_flags, fc);
+		err = fuse_uring_commit_fetch(cmd, issue_flags, fch);
 		if (err) {
 			pr_info_once("FUSE_IO_URING_COMMIT_AND_FETCH failed err=%d\n",
 				     err);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 3248a417ade9..c0a2ca6cbaf0 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -284,8 +284,8 @@ struct fuse_dev {
 	/** Issue FUSE_INIT synchronously */
 	bool sync_init;
 
-	/** Fuse connection for this device */
-	struct fuse_conn *fc;
+	/** Fuse channel for this device */
+	struct fuse_chan *chan;
 
 	/** Processing queue */
 	struct fuse_pqueue pq;
@@ -312,21 +312,21 @@ struct fuse_copy_state {
 	} ring;
 };
 
-/* fud->fc gets assigned to this value when /dev/fuse is closed */
-#define FUSE_DEV_FC_DISCONNECTED ((struct fuse_conn *) 1)
+/* fud->chan gets assigned to this value when /dev/fuse is closed */
+#define FUSE_DEV_CHAN_DISCONNECTED ((struct fuse_chan *) 1)
 
 /*
- * Lockless access is OK, because fud->fc is set once during mount and is valid
+ * Lockless access is OK, because fud->chan is set once during mount and is valid
  * until the file is released.
  *
- * fud->fc is set to FUSE_DEV_FC_DISCONNECTED only after the containing file is
+ * fud->chan is set to FUSE_DEV_CHAN_DISCONNECTED only after the containing file is
  * released, so result is safe to dereference in most cases.  Exceptions are:
  * fuse_dev_put() and fuse_fill_super_common().
  */
-static inline struct fuse_conn *fuse_dev_fc_get(struct fuse_dev *fud)
+static inline struct fuse_chan *fuse_dev_chan_get(struct fuse_dev *fud)
 {
 	/* Pairs with xchg() in fuse_dev_install() */
-	return smp_load_acquire(&fud->fc);
+	return smp_load_acquire(&fud->chan);
 }
 
 static inline struct fuse_dev *fuse_file_to_fud(struct file *file)
@@ -338,7 +338,7 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 {
 	struct fuse_dev *fud = fuse_file_to_fud(file);
 
-	if (!fuse_dev_fc_get(fud))
+	if (!fuse_dev_chan_get(fud))
 		return NULL;
 
 	return fud;
@@ -378,7 +378,7 @@ void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
  */
 u64 fuse_get_unique(struct fuse_iqueue *fiq);
 
-struct fuse_dev *fuse_dev_alloc_install(struct fuse_conn *fc);
+struct fuse_dev *fuse_dev_alloc_install(struct fuse_chan *fch);
 struct fuse_dev *fuse_dev_alloc(void);
 
 /**
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index b7dfe8338988..bda1bd4a9357 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1790,7 +1790,7 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	list_add_tail(&fc->entry, &fuse_conn_list);
 	sb->s_root = root_dentry;
 	if (fud)
-		fuse_dev_install(fud, fc);
+		fuse_dev_install(fud, fc->chan);
 
 	mutex_unlock(&fuse_mutex);
 	return 0;
@@ -1836,7 +1836,7 @@ static int fuse_set_no_super(struct super_block *sb, struct fs_context *fsc)
 
 static int fuse_test_super(struct super_block *sb, struct fs_context *fsc)
 {
-	return fuse_dev_verify(fsc->sget_key, get_fuse_conn_super(sb));
+	return fuse_dev_verify(fsc->sget_key, get_fuse_conn_super(sb)->chan);
 }
 
 static int fuse_get_tree(struct fs_context *fsc)
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 53ce21836ba0..a4cf813cebfc 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1607,7 +1607,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 	for (i = 0; i < fs->nvqs; i++) {
 		struct virtio_fs_vq *fsvq = &fs->vqs[i];
 
-		fuse_dev_install(fsvq->fud, fc);
+		fuse_dev_install(fsvq->fud, fc->chan);
 	}
 
 	/* Previous unmount will stop all queues. Start these again */
-- 
2.53.0

