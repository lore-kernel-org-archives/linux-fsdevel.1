Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F287839B96B
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331072; cv=none; b=tCVRJskr+lYoTtS4k7VvUIPA1EdmHJCeZ0CGgE295wHkVJ0FLw2iNnpTKum8ltm1IfEDV6K3LgxGiUrX78EOuKz9ART6PoDaFylltwYMDPma2zRbtoQLBwSOzJbBY2YfJC3nFl+ZnvfEZZJ3V/dJj4GKlmO1QurfCooRpmLQ2A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331072; c=relaxed/simple;
	bh=/WsXvBvGtjgMv62tgmQ6XWbX9eLFvWirZFGDtxFZanU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sFuqIC1FOmkolg3SZZ0/UWi2yfEc4VKWIHvCkgGWMzPt24brH0a3//2PV2r2PmZzAKgpvF/OdPSGuWgdf+bqgxg0aGs6MfSR1r723Y4VRFLsshBQNE38FBiOpfLbDhTb5ObeN65R1Iw6+R663knSX9HxpWpgMOnhkIHv9xgGnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJSdARl/; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TK1BEdln; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJSdARl/";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TK1BEdln"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331063;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QJGjyLLnQZaRSgIVo9Df8T3YOv3JarZzvqooAjEHjA4=;
	b=gJSdARl/yI4vQVBkpuAaX+lo+SQmB8q2U7NIYdAx9karDVblC0DxIGmOZ5Xki3BgVYVbIJ
	Npi0TpPXe3QiNdfy5/FmgeNqyEjEkUAXVja34qfU91Ps1reE7fDrDX6ssNefpZvMMTIxZ0
	maZwar4eawwSJS2Ke1MS3Q4BVnpdOX4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-4UBM2ZQFObe05hBFh4wOuw-1; Thu, 16 Apr 2026 05:17:31 -0400
X-MC-Unique: 4UBM2ZQFObe05hBFh4wOuw-1
X-Mimecast-MFC-AGG-ID: 4UBM2ZQFObe05hBFh4wOuw_1776331050
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d3eec9bcso39715085e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331049; x=1776935849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QJGjyLLnQZaRSgIVo9Df8T3YOv3JarZzvqooAjEHjA4=;
        b=TK1BEdln1SHiqdus+eqTdOT/u059iq02bRCImo37Rbz/IiDl5/cHP+spYo0Xe9XZRO
         PIKNVM9GoHTyI6R8CfCCpOINqLgZyOBhXRTns73ez1lIxNXu2xrJKpDPcrAtue66/lE+
         7OW1VaYRgJfygXte1e90+ZfLqvchM8SxNG0nMpJiqAEl2w8BGwxV6ty1dQ85HdaemIvM
         7Ng/q1VOvYZ/Cp5GuR4o4FbpprZ4u3IG2Cn/Wo1uI9cHcpt+V3zl+Do0wsNskdxNkRnt
         jSngNoqwZDIXepVKlZVykzqcxm32+67bh3jrntZG1QGURUibNKdpluOwFyVcoUGETCxa
         QFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331049; x=1776935849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJGjyLLnQZaRSgIVo9Df8T3YOv3JarZzvqooAjEHjA4=;
        b=a1e5Sdh6AHmYRuljDj+mQ3E3ywjjzyWW47zla+6sZ1grvzkL7ndtVzEferuG1vTTWl
         qAAZmIA3BCUYiN0SF0pJ1TNrdhyYnGhv/uGF1KROayUF56hKSsItCGjzLLarMjlD7HnI
         jhYJ7lu5DO3xqeg3jxOErhxdG7mGu2MVK9XVzYkZmKesYPemFqISTCMMaf0L6YP8fqee
         HulAn4hr/BvVXQb8mOtcp47TjWeN8x4sxMp2WYXe/xVdsM5BAJHqQtwg+PIRg4Nxsr1I
         ZxolWcUo8f1sLGedqj6po2l8zobWz3XzG3DVjLucVSA91YqZmR736T7PQ0ZLIyFWIcrq
         ANUw==
X-Forwarded-Encrypted: i=1; AFNElJ80+Y32oEQHvwF8aqW+YWPgfeVd7uaZa+C6GWXJyUe8sNdh6mS2UFW7xJ57WhVWXHOuGJOhy55NluAQQGBk@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22nYAwbnQRXfNJ/VBP0crjHbSlpvuOubDSziMKw+ZWggwKOgH
	Sn8Bx/aTUUcQtGt+U0Kc93x1qp1ZZGNcypatLR+46UHidbBHJpKlLgk+tz7oJ0MXwrmdDE4XomT
	yAVuGmd3sNIIURwBI7t6bYlmk8l4uQIPcttagn8W4mMwHZ6tnTDgNCya7vNhV1fqkpkBBT2KJ1G
	g=
X-Gm-Gg: AeBDiet5a4N1YnovubdshkVjQHmbDPlEEUuoNT8HnT3uC9/EYN5QnfqAsyYWARL2wuR
	KnDfYqDGM3/BgaAS/yaDhRqKIDwpmAY2s4KbAm1Wx+zBGzS6NQf9CbWKPadwpbZDiVq3vb+is3l
	2r2i8DRD+6HjsFCsceNUP1e6QXXP1eVtHWuCBIbY3I1lXLXcoZDb2LvMlMeJuY29AJlMF1E/SPA
	DRVtMuAgQvRh3eVCOQDZouddq/e4kZZGIO3agyeVaUx8Wd/7gUbtJOuU8BN2+u8aOMe1kC3FPE1
	xER97n4B9nmAxFY29FgACqNWwRpSQfyyRLYaqiHa+nEY7aO52MuxKwprAMXduYtgzGAq9ho0lcl
	hnPP+jvPemg+hgMnMcdzxnIFD+1Rj1zt6x6dSZrO2kDDqeARnjC0VQu/1aG1z7T38RiPCmOONyC
	hUYmpYyQ==
X-Received: by 2002:a05:600d:12:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-488d67df3f9mr280274595e9.4.1776331049209;
        Thu, 16 Apr 2026 02:17:29 -0700 (PDT)
X-Received: by 2002:a05:600d:12:b0:485:2ce2:4c87 with SMTP id 5b1f17b1804b1-488d67df3f9mr280274075e9.4.1776331048710;
        Thu, 16 Apr 2026 02:17:28 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:27 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 19/32] fuse: abort related layering cleanup
Date: Thu, 16 Apr 2026 11:16:43 +0200
Message-ID: <20260416091658.462783-20-mszeredi@redhat.com>
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

 - rename fuse_abort_conn() to fuse_chan_abort(), pass fuse_chan pointer
   instead of fuse_conn

 - pass an abort_with_err argument that tells fuse_dev_(read|write) to
   return with ECONNABORTED instead of ENODEV

 - move fc->aborted to fch->abort_with_err

 - rename fuse_wait_aborted() to fuse_chan_wait_aborted()

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c     |  4 +--
 fs/fuse/cuse.c        |  4 +--
 fs/fuse/dev.c         | 84 ++++++++++++++++++++++---------------------
 fs/fuse/dev.h         |  3 +-
 fs/fuse/dev_uring.c   |  2 +-
 fs/fuse/fuse_dev_i.h  |  3 ++
 fs/fuse/fuse_i.h      |  5 ---
 fs/fuse/inode.c       |  6 ++--
 fs/fuse/req_timeout.c | 12 +++----
 9 files changed, 61 insertions(+), 62 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index e6f513eb7d4a..925a15488499 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -38,9 +38,7 @@ static ssize_t fuse_conn_abort_write(struct file *file, const char __user *buf,
 {
 	struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
 	if (fc) {
-		if (fc->abort_err)
-			fc->aborted = true;
-		fuse_abort_conn(fc);
+		fuse_chan_abort(fc->chan, fc->abort_err);
 		fuse_conn_put(fc);
 	}
 	return count;
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 728608d35d0a..9341bb5a88cb 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -424,7 +424,7 @@ static void cuse_process_init_reply(struct fuse_mount *fm,
 err_region:
 	unregister_chrdev_region(devt, 1);
 err:
-	fuse_abort_conn(fc);
+	fuse_chan_abort(fc->chan, false);
 	goto out;
 }
 
@@ -594,7 +594,7 @@ static ssize_t cuse_class_abort_store(struct device *dev,
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
-	fuse_abort_conn(&cc->fc);
+	fuse_chan_abort(cc->fc.chan, false);
 	return count;
 }
 static DEVICE_ATTR(abort, 0200, NULL, cuse_class_abort_store);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index fadad23e8369..cbf8f086536c 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -89,7 +89,7 @@ static void fuse_drop_waiting(struct fuse_conn *fc)
 {
 	/*
 	 * lockess check of fc->chan->connected is okay, because atomic_dec_and_test()
-	 * provides a memory barrier matched with the one in fuse_wait_aborted()
+	 * provides a memory barrier matched with the one in fuse_chan_wait_aborted()
 	 * to ensure no wake-up is missed.
 	 */
 	if (atomic_dec_and_test(&fc->chan->num_waiting) &&
@@ -569,17 +569,17 @@ void fuse_chan_queue_forget(struct fuse_chan *fch, struct fuse_forget_link *forg
 	fiq->ops->send_forget(fiq, forget);
 }
 
-static void flush_bg_queue(struct fuse_conn *fc)
+static void flush_bg_queue(struct fuse_chan *fch)
 {
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_iqueue *fiq = &fch->iq;
 
-	while (fc->chan->active_background < fc->chan->max_background &&
-	       !list_empty(&fc->chan->bg_queue)) {
+	while (fch->active_background < fch->max_background &&
+	       !list_empty(&fch->bg_queue)) {
 		struct fuse_req *req;
 
-		req = list_first_entry(&fc->chan->bg_queue, struct fuse_req, list);
+		req = list_first_entry(&fch->bg_queue, struct fuse_req, list);
 		list_del(&req->list);
-		fc->chan->active_background++;
+		fch->active_background++;
 		fuse_send_one(fiq, req);
 	}
 }
@@ -633,7 +633,7 @@ void fuse_request_end(struct fuse_req *req)
 
 		fc->chan->num_background--;
 		fc->chan->active_background--;
-		flush_bg_queue(fc);
+		flush_bg_queue(fc->chan);
 		spin_unlock(&fc->chan->bg_lock);
 	} else {
 		/* Wake up waiter sleeping in request_wait_answer() */
@@ -708,7 +708,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 
 		if (req->args->abort_on_kill) {
-			fuse_abort_conn(fc);
+			fuse_chan_abort(fc->chan, false);
 			return;
 		}
 
@@ -886,7 +886,7 @@ static int fuse_request_queue_background(struct fuse_req *req)
 		if (fc->chan->num_background == fc->chan->max_background)
 			fc->chan->blocked = 1;
 		list_add_tail(&req->list, &fc->chan->bg_queue);
-		flush_bg_queue(fc);
+		flush_bg_queue(fc->chan);
 		queued = true;
 	}
 	spin_unlock(&fc->chan->bg_lock);
@@ -1591,7 +1591,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	}
 
 	if (!fiq->connected) {
-		err = fc->aborted ? -ECONNABORTED : -ENODEV;
+		err = fc->chan->abort_with_err ? -ECONNABORTED : -ENODEV;
 		goto err_unlock;
 	}
 
@@ -1629,7 +1629,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	spin_lock(&fpq->lock);
 	/*
 	 *  Must not put request on fpq->io queue after having been shut down by
-	 *  fuse_abort_conn()
+	 *  fuse_chan_abort()
 	 */
 	if (!fpq->connected) {
 		req->out.h.error = err = -ECONNABORTED;
@@ -1647,7 +1647,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 	spin_lock(&fpq->lock);
 	clear_bit(FR_LOCKED, &req->flags);
 	if (!fpq->connected) {
-		err = fc->aborted ? -ECONNABORTED : -ENODEV;
+		err = fc->chan->abort_with_err ? -ECONNABORTED : -ENODEV;
 		goto out_end;
 	}
 	if (err) {
@@ -2593,27 +2593,29 @@ static void end_polls(struct fuse_conn *fc)
  * is OK, the request will in that case be removed from the list before we touch
  * it.
  */
-void fuse_abort_conn(struct fuse_conn *fc)
+void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err)
 {
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_iqueue *fiq = &fch->iq;
 
-	spin_lock(&fc->chan->lock);
-	if (fc->chan->connected) {
+	fch->abort_with_err = abort_with_err;
+
+	spin_lock(&fch->lock);
+	if (fch->connected) {
 		struct fuse_dev *fud;
 		struct fuse_req *req, *next;
 		LIST_HEAD(to_end);
 		unsigned int i;
 
-		if (fc->chan->timeout.req_timeout)
-			cancel_delayed_work(&fc->chan->timeout.work);
+		if (fch->timeout.req_timeout)
+			cancel_delayed_work(&fch->timeout.work);
 
-		/* Background queuing checks fc->chan->connected under bg_lock */
-		spin_lock(&fc->chan->bg_lock);
-		fc->chan->connected = 0;
-		spin_unlock(&fc->chan->bg_lock);
+		/* Background queuing checks fch->connected under bg_lock */
+		spin_lock(&fch->bg_lock);
+		fch->connected = 0;
+		spin_unlock(&fch->bg_lock);
 
-		fuse_chan_set_initialized(fc->chan);
-		list_for_each_entry(fud, &fc->chan->devices, entry) {
+		fuse_chan_set_initialized(fch);
+		list_for_each_entry(fud, &fch->devices, entry) {
 			struct fuse_pqueue *fpq = &fud->pq;
 
 			spin_lock(&fpq->lock);
@@ -2634,11 +2636,11 @@ void fuse_abort_conn(struct fuse_conn *fc)
 						      &to_end);
 			spin_unlock(&fpq->lock);
 		}
-		spin_lock(&fc->chan->bg_lock);
-		fc->chan->blocked = 0;
-		fc->chan->max_background = UINT_MAX;
-		flush_bg_queue(fc);
-		spin_unlock(&fc->chan->bg_lock);
+		spin_lock(&fch->bg_lock);
+		fch->blocked = 0;
+		fch->max_background = UINT_MAX;
+		flush_bg_queue(fch);
+		spin_unlock(&fch->bg_lock);
 
 		spin_lock(&fiq->lock);
 		fiq->connected = 0;
@@ -2650,30 +2652,30 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		wake_up_all(&fiq->waitq);
 		spin_unlock(&fiq->lock);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
-		end_polls(fc);
-		wake_up_all(&fc->chan->blocked_waitq);
-		spin_unlock(&fc->chan->lock);
+		end_polls(fch->conn);
+		wake_up_all(&fch->blocked_waitq);
+		spin_unlock(&fch->lock);
 
 		fuse_dev_end_requests(&to_end);
 
 		/*
-		 * fc->chan->lock must not be taken to avoid conflicts with io-uring
+		 * fch->lock must not be taken to avoid conflicts with io-uring
 		 * locks
 		 */
-		fuse_uring_abort(fc->chan);
+		fuse_uring_abort(fch);
 	} else {
-		spin_unlock(&fc->chan->lock);
+		spin_unlock(&fch->lock);
 	}
 }
-EXPORT_SYMBOL_GPL(fuse_abort_conn);
+EXPORT_SYMBOL_GPL(fuse_chan_abort);
 
-void fuse_wait_aborted(struct fuse_conn *fc)
+void fuse_chan_wait_aborted(struct fuse_chan *fch)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
-	wait_event(fc->chan->blocked_waitq, fuse_chan_num_waiting(fc->chan) == 0);
+	wait_event(fch->blocked_waitq, fuse_chan_num_waiting(fch) == 0);
 
-	fuse_uring_wait_stopped_queues(fc->chan);
+	fuse_uring_wait_stopped_queues(fch);
 }
 
 int fuse_dev_release(struct inode *inode, struct file *file)
@@ -2704,7 +2706,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		if (last) {
 			WARN_ON(fc->chan->iq.fasync != NULL);
-			fuse_abort_conn(fc);
+			fuse_chan_abort(fc->chan, false);
 		}
 		fuse_conn_put(fc);
 	}
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index efdaf0bf6f0f..a0c1212573d6 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -42,7 +42,8 @@ struct fuse_dev *fuse_dev_grab(struct file *file);
 void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout);
 
 /* Abort all requests */
-void fuse_abort_conn(struct fuse_conn *fc);
+void fuse_chan_abort(struct fuse_chan *fch, bool abort_with_err);
+void fuse_chan_wait_aborted(struct fuse_chan *fch);
 
 #ifdef CONFIG_FUSE_IO_URING
 bool fuse_uring_enabled(void);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 2c7331e49630..4a0291a1f371 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1155,7 +1155,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		return -EOPNOTSUPP;
 	}
 
-	if (fc->aborted)
+	if (fc->chan->abort_with_err)
 		return -ECONNABORTED;
 	if (!fc->chan->connected)
 		return -ENOTCONN;
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index fd1ccc8df60d..534d037799ff 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -239,6 +239,9 @@ struct fuse_chan {
 	/* Use io_uring for communication */
 	unsigned int io_uring;
 
+	/** Connection aborted via sysfs, respond with ECONNABORTED on device I/O */
+	bool abort_with_err;
+
 #ifdef CONFIG_FUSE_IO_URING
 	/**  uring connection information*/
 	struct fuse_ring *ring;
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index af8e05a403e5..b8655c3b48e2 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -483,9 +483,6 @@ struct fuse_conn {
 	/** Number of background requests at which congestion starts */
 	unsigned congestion_threshold;
 
-	/** Connection aborted via sysfs */
-	bool aborted;
-
 	/** Connection failed (version mismatch).  Cannot race with
 	    setting other bitfields since it is only set once in INIT
 	    reply, before any other request, and never cleared */
@@ -996,8 +993,6 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
-void fuse_wait_aborted(struct fuse_conn *fc);
-
 void fuse_dentry_tree_init(void);
 void fuse_dentry_tree_cleanup(void);
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 88a4dc402155..5cb0cc9b365e 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -612,7 +612,7 @@ static void fuse_umount_begin(struct super_block *sb)
 	if (fc->no_force_umount)
 		return;
 
-	fuse_abort_conn(fc);
+	fuse_chan_abort(fc->chan, false);
 
 	// Only retire block-device-based superblocks.
 	if (sb->s_bdev != NULL)
@@ -1951,8 +1951,8 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 	if (fc->destroy)
 		fuse_send_destroy(fm);
 
-	fuse_abort_conn(fc);
-	fuse_wait_aborted(fc);
+	fuse_chan_abort(fc->chan, false);
+	fuse_chan_wait_aborted(fc->chan);
 
 	if (!list_empty(&fc->entry)) {
 		mutex_lock(&fuse_mutex);
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index 9c48789b941a..6cc6fc491343 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -79,13 +79,13 @@ static void fuse_check_timeout(struct work_struct *work)
 	expired = fuse_request_expired(fch, &fiq->pending);
 	spin_unlock(&fiq->lock);
 	if (expired)
-		goto abort_conn;
+		goto chan_abort;
 
 	spin_lock(&fch->bg_lock);
 	expired = fuse_request_expired(fch, &fch->bg_queue);
 	spin_unlock(&fch->bg_lock);
 	if (expired)
-		goto abort_conn;
+		goto chan_abort;
 
 	spin_lock(&fch->lock);
 	if (!fch->connected) {
@@ -99,7 +99,7 @@ static void fuse_check_timeout(struct work_struct *work)
 		    fuse_fpq_processing_expired(fch, fpq->processing)) {
 			spin_unlock(&fpq->lock);
 			spin_unlock(&fch->lock);
-			goto abort_conn;
+			goto chan_abort;
 		}
 
 		spin_unlock(&fpq->lock);
@@ -107,15 +107,15 @@ static void fuse_check_timeout(struct work_struct *work)
 	spin_unlock(&fch->lock);
 
 	if (fuse_uring_request_expired(fch))
-		goto abort_conn;
+		goto chan_abort;
 
 out:
 	queue_delayed_work(system_percpu_wq, &fch->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
-abort_conn:
-	fuse_abort_conn(fch->conn);
+chan_abort:
+	fuse_chan_abort(fch, false);
 }
 
 static void set_request_timeout(struct fuse_chan *fch, unsigned int timeout)
-- 
2.53.0

