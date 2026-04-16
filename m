Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B7939A051
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331038; cv=none; b=HfAXQyYyj517njzwDn22f+I/JZJadQz/sl6naG3olsj92K0IBXRJSzWEOY9evwvLFhdFn1dG/W1UfYV93mt4cVkVrhkWiKecISaNtTFif5jpihrwm9Ao2ayt255f+osLi98YZvKLRC00ytVu0z6ShYmZUwfPQWF7TmNSUIu5l/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331038; c=relaxed/simple;
	bh=ctxnpjnWewu18DlqucHmXjni10VOaPT2KWT+iEC8/DI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DhBPBkg8xyTJCTne5caOF1W9ScfDTZR23XDqPStih7BIuHGSwSETDsalMbZjYroFuFFlAtuBCdzqUz47Tk2RO0ilPJRVYiXBsvjmMsbD9rdYebFfjmm9FbzIJ2wT2b2Zz97X/lv9Jc5dDComdLqacZdCQ56t6RksgL8EEBcSNXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ha+onWfc; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ua71eGYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha+onWfc";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ua71eGYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331033;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zfj5C1fDAl7CmtpUhyMXAQFh36TElG6U4zcCSJCa6T8=;
	b=Ha+onWfc8JPaZOmaqAjra5QU0ioPRhM75/ZWTp718pXqib4LKKGlOLVI/QuV5YMyjNRcfs
	tnZm3p7CKTdZRLJfx2CeMeje3OfxAHbTCE++2sNLCSil5UFq28qUSf0WBJKk1bPMhwjvOw
	1odELNRBwzk3QvgPHxqyQRbAO3+tZiA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-PS6PzW0DMBWA42ORhaa2bQ-1; Thu, 16 Apr 2026 05:17:12 -0400
X-MC-Unique: PS6PzW0DMBWA42ORhaa2bQ-1
X-Mimecast-MFC-AGG-ID: PS6PzW0DMBWA42ORhaa2bQ_1776331031
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488e12db7e0so46151865e9.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331031; x=1776935831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfj5C1fDAl7CmtpUhyMXAQFh36TElG6U4zcCSJCa6T8=;
        b=Ua71eGYsUox+SruFVzqrshHuhCsn6qsN4czuf4/Ca/r6NJWa2+qzEarrPcVrMGrWqj
         MSyB+2iYYsQ9UkoTlr7OV295PJP12x0VA7uzm2/ZWPZNWgl7WQZbhKI/WAFxh6UCrTS/
         P5pQEzIXym4FOzWiXo5ijWVpzle7a/rtpM2Knt6ACGG7kchb2g7ud7GgFL8n70bOKHl5
         92LbiyBAU/d9JidZf97vm2QvoEiVEWnIHhVN3FOGQffKWifQwFHnN4pmzHtGLH5ZOaK2
         nwbg2q0Ph9oMj2ds+5mAAN1EU9WQHV5e94G7LTSjy8ZATpUiB9tsOBdpTbkMvcNzEcxB
         FKnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331031; x=1776935831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zfj5C1fDAl7CmtpUhyMXAQFh36TElG6U4zcCSJCa6T8=;
        b=aUxVWzTJB1iqz//4a9evbtZTh1dr4hDaNvwQj7LpfG6HTZyb6IeNPrPJv5H+Y7FiCN
         Vu5puQimkJ9U0Ar1F8J3hxY3mkkrWDafWFHbCSpa4t6B4COgraUyehY9Skl1fxlxnvss
         ROU4TJ9o+N9d6wW0Hp9O6mlMlPzqr0K7DoObJhRFXYdWSHMQOP2W4U1Imd+128CUM4IW
         1PmAe9ELHJeCh+paeJM+MVZCF6UBxFghjpeT5OmdBnLr6NPOM3S4UReF0HLsqjqtU6Vf
         FmNnC7Q5YcL4UNkHn0MQW4l28uvmiTHnfJcnZ2TTOlnDBInBn8FIlq5zGuHirS4smfEB
         Wukg==
X-Forwarded-Encrypted: i=1; AFNElJ/rA7fpkhIi1ZmHU70ZihqkNl/V6RGS5CrysWEmgndt5Bty9LZ7ApVGyvhRDRsCCqSrqBRkEGIRXsOSOmcL@vger.kernel.org
X-Gm-Message-State: AOJu0YxYth6lBU5GNrx0JhpaevLSt/O4oq6C2U4LJ4dPFWLeI5sfkpEG
	7BSjhrCUX/oXQnySuUpBg6BwdAGyXv2EWpEwLelsl53SiwCVgs/0A3ycIckW/8mNNsrfT/iNEuU
	HkVIN2eY3R5Te1BKXmda5M7JrFlz8+jWJDKhXLImYtS35fFwH0gQ9INZnEDqf18NyAe8vZwc/MR
	E=
X-Gm-Gg: AeBDievMjdG9jBNg6C5UJjgHyDN0jbiVl17d3sww7WsoNGC5wPD80IEK38W8gIcAuLZ
	KVt7QJUyFlHhRzDMMve0Kk6TNb5S7PzZFchwvadfi2k+0lr3iNALrYhG5I+YO2vhBcznrT3LjkM
	asSkpzMkPzJRaIboDDssFOeLfyBDe2WzB4mfEmn2VaWcOOErnsRiFJtkkjpfnFNvq63yudDRD4U
	ldX1QYMGkLcMArl3YVjXVAXSsqjMTsI2oPZ4NRiRqWS3GJPhNW306C/To/e+ESI50XFlCGR3hF/
	KHYdPxib/Mstv2X2vDq8ZNiA1DiH03Z1iFC/s3qMjiNMDcPgc/7I+j3fV/Ez8F+KjZbzce9ZLHT
	n9ni0p/kkzbXlJewrMJeivsm6fmUGPLQ3R1A3mEDMxfWDIWj7YREkJBN7Ll32PrGxa0ljVG/bVI
	3dC285bQ==
X-Received: by 2002:a05:600c:8907:b0:488:80b6:873a with SMTP id 5b1f17b1804b1-488d6860bc3mr239264585e9.21.1776331030670;
        Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
X-Received: by 2002:a05:600c:8907:b0:488:80b6:873a with SMTP id 5b1f17b1804b1-488d6860bc3mr239264125e9.21.1776331030091;
        Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:08 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/32] fuse: move background queuing related members to fuse_chan
Date: Thu, 16 Apr 2026 11:16:30 +0200
Message-ID: <20260416091658.462783-7-mszeredi@redhat.com>
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

Move:

 - max_background
 - num_background
 - active_background
 - bg_queue
 - bg_lock

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c     | 11 ++++++-----
 fs/fuse/dev.c         | 45 +++++++++++++++++++++++--------------------
 fs/fuse/dev.h         |  3 +++
 fs/fuse/dev_uring.c   | 24 +++++++++++------------
 fs/fuse/file.c        |  5 +++--
 fs/fuse/fuse_dev_i.h  | 16 +++++++++++++++
 fs/fuse/fuse_i.h      | 16 ---------------
 fs/fuse/inode.c       | 16 +++++----------
 fs/fuse/req_timeout.c |  6 +++---
 fs/fuse/virtio_fs.c   |  2 +-
 10 files changed, 73 insertions(+), 71 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index f902a7fb4630..6279a37716c5 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -111,7 +112,7 @@ static ssize_t fuse_conn_max_background_read(struct file *file,
 	if (!fc)
 		return 0;
 
-	val = READ_ONCE(fc->max_background);
+	val = READ_ONCE(fc->chan->max_background);
 	fuse_conn_put(fc);
 
 	return fuse_conn_limit_read(file, buf, len, ppos, val);
@@ -129,12 +130,12 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 	if (ret > 0) {
 		struct fuse_conn *fc = fuse_ctl_file_conn_get(file);
 		if (fc) {
-			spin_lock(&fc->bg_lock);
-			fc->max_background = val;
-			fc->blocked = fc->num_background >= fc->max_background;
+			spin_lock(&fc->chan->bg_lock);
+			fc->chan->max_background = val;
+			fc->blocked = fc->chan->num_background >= fc->chan->max_background;
 			if (!fc->blocked)
 				wake_up(&fc->blocked_waitq);
-			spin_unlock(&fc->bg_lock);
+			spin_unlock(&fc->chan->bg_lock);
 			fuse_conn_put(fc);
 		}
 	}
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 18bad9089917..68a96b41f7e6 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -180,10 +180,10 @@ static void fuse_put_request(struct fuse_req *req)
 			 * We get here in the unlikely case that a background
 			 * request was allocated but not sent
 			 */
-			spin_lock(&fc->bg_lock);
+			spin_lock(&fc->chan->bg_lock);
 			if (!fc->blocked)
 				wake_up(&fc->blocked_waitq);
-			spin_unlock(&fc->bg_lock);
+			spin_unlock(&fc->chan->bg_lock);
 		}
 
 		if (test_bit(FR_WAITING, &req->flags)) {
@@ -354,6 +354,9 @@ struct fuse_chan *fuse_chan_new(void)
 		return NULL;
 
 	INIT_LIST_HEAD(&fch->devices);
+	spin_lock_init(&fch->bg_lock);
+	INIT_LIST_HEAD(&fch->bg_queue);
+	fch->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 
 	return fch;
 }
@@ -488,13 +491,13 @@ static void flush_bg_queue(struct fuse_conn *fc)
 {
 	struct fuse_iqueue *fiq = &fc->chan->iq;
 
-	while (fc->active_background < fc->max_background &&
-	       !list_empty(&fc->bg_queue)) {
+	while (fc->chan->active_background < fc->chan->max_background &&
+	       !list_empty(&fc->chan->bg_queue)) {
 		struct fuse_req *req;
 
-		req = list_first_entry(&fc->bg_queue, struct fuse_req, list);
+		req = list_first_entry(&fc->chan->bg_queue, struct fuse_req, list);
 		list_del(&req->list);
-		fc->active_background++;
+		fc->chan->active_background++;
 		fuse_send_one(fiq, req);
 	}
 }
@@ -530,9 +533,9 @@ void fuse_request_end(struct fuse_req *req)
 	WARN_ON(test_bit(FR_PENDING, &req->flags));
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
-		spin_lock(&fc->bg_lock);
+		spin_lock(&fc->chan->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background) {
+		if (fc->chan->num_background == fc->chan->max_background) {
 			fc->blocked = 0;
 			wake_up(&fc->blocked_waitq);
 		} else if (!fc->blocked) {
@@ -546,10 +549,10 @@ void fuse_request_end(struct fuse_req *req)
 				wake_up(&fc->blocked_waitq);
 		}
 
-		fc->num_background--;
-		fc->active_background--;
+		fc->chan->num_background--;
+		fc->chan->active_background--;
 		flush_bg_queue(fc);
-		spin_unlock(&fc->bg_lock);
+		spin_unlock(&fc->chan->bg_lock);
 	} else {
 		/* Wake up waiter sleeping in request_wait_answer() */
 		wake_up(&req->waitq);
@@ -795,16 +798,16 @@ static int fuse_request_queue_background(struct fuse_req *req)
 		return fuse_request_queue_background_uring(fc, req);
 #endif
 
-	spin_lock(&fc->bg_lock);
+	spin_lock(&fc->chan->bg_lock);
 	if (likely(fc->connected)) {
-		fc->num_background++;
-		if (fc->num_background == fc->max_background)
+		fc->chan->num_background++;
+		if (fc->chan->num_background == fc->chan->max_background)
 			fc->blocked = 1;
-		list_add_tail(&req->list, &fc->bg_queue);
+		list_add_tail(&req->list, &fc->chan->bg_queue);
 		flush_bg_queue(fc);
 		queued = true;
 	}
-	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->chan->bg_lock);
 
 	return queued;
 }
@@ -2521,9 +2524,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 			cancel_delayed_work(&fc->timeout.work);
 
 		/* Background queuing checks fc->connected under bg_lock */
-		spin_lock(&fc->bg_lock);
+		spin_lock(&fc->chan->bg_lock);
 		fc->connected = 0;
-		spin_unlock(&fc->bg_lock);
+		spin_unlock(&fc->chan->bg_lock);
 
 		fuse_set_initialized(fc);
 		list_for_each_entry(fud, &fc->chan->devices, entry) {
@@ -2547,11 +2550,11 @@ void fuse_abort_conn(struct fuse_conn *fc)
 						      &to_end);
 			spin_unlock(&fpq->lock);
 		}
-		spin_lock(&fc->bg_lock);
+		spin_lock(&fc->chan->bg_lock);
 		fc->blocked = 0;
-		fc->max_background = UINT_MAX;
+		fc->chan->max_background = UINT_MAX;
 		flush_bg_queue(fc);
-		spin_unlock(&fc->bg_lock);
+		spin_unlock(&fc->chan->bg_lock);
 
 		spin_lock(&fiq->lock);
 		fiq->connected = 0;
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 1f8f2cf1ecfd..2630dab3ef56 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -5,6 +5,9 @@
 
 #include <linux/cleanup.h>
 
+/** Maximum number of outstanding background requests */
+#define FUSE_DEFAULT_MAX_BACKGROUND 12
+
 struct fuse_conn;
 struct fuse_chan;
 struct fuse_dev;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index d28027f9d743..4a5e64a6fe8a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -54,7 +54,7 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	struct fuse_conn *fc = ring->fc;
 
 	lockdep_assert_held(&queue->lock);
-	lockdep_assert_held(&fc->bg_lock);
+	lockdep_assert_held(&fc->chan->bg_lock);
 
 	/*
 	 * Allow one bg request per queue, ignoring global fc limits.
@@ -62,14 +62,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	 * eliminates the need for remote queue wake-ups when global
 	 * limits are met but this queue has no more waiting requests.
 	 */
-	while ((fc->active_background < fc->max_background ||
+	while ((fc->chan->active_background < fc->chan->max_background ||
 		!queue->active_background) &&
 	       (!list_empty(&queue->fuse_req_bg_queue))) {
 		struct fuse_req *req;
 
 		req = list_first_entry(&queue->fuse_req_bg_queue,
 				       struct fuse_req, list);
-		fc->active_background++;
+		fc->chan->active_background++;
 		queue->active_background++;
 
 		list_move_tail(&req->list, &queue->fuse_req_queue);
@@ -89,9 +89,9 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	list_del_init(&req->list);
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
-		spin_lock(&fc->bg_lock);
+		spin_lock(&fc->chan->bg_lock);
 		fuse_uring_flush_bg(queue);
-		spin_unlock(&fc->bg_lock);
+		spin_unlock(&fc->chan->bg_lock);
 	}
 
 	spin_unlock(&queue->lock);
@@ -132,11 +132,11 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 
 		queue->stopped = true;
 
-		WARN_ON_ONCE(ring->fc->max_background != UINT_MAX);
+		WARN_ON_ONCE(ring->fc->chan->max_background != UINT_MAX);
 		spin_lock(&queue->lock);
-		spin_lock(&fc->bg_lock);
+		spin_lock(&fc->chan->bg_lock);
 		fuse_uring_flush_bg(queue);
-		spin_unlock(&fc->bg_lock);
+		spin_unlock(&fc->chan->bg_lock);
 		spin_unlock(&queue->lock);
 		fuse_uring_abort_end_queue_requests(queue);
 	}
@@ -1325,12 +1325,12 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
-	spin_lock(&fc->bg_lock);
-	fc->num_background++;
-	if (fc->num_background == fc->max_background)
+	spin_lock(&fc->chan->bg_lock);
+	fc->chan->num_background++;
+	if (fc->chan->num_background == fc->chan->max_background)
 		fc->blocked = 1;
 	fuse_uring_flush_bg(queue);
-	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->chan->bg_lock);
 
 	/*
 	 * Due to bg_queue flush limits there might be other bg requests
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7294bd347412..64348ffbf202 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -902,7 +903,7 @@ static int fuse_handle_readahead(struct folio *folio,
 		ia = NULL;
 	}
 	if (!ia) {
-		if (fc->num_background >= fc->congestion_threshold &&
+		if (fc->chan->num_background >= fc->congestion_threshold &&
 		    rac->ra->async_size >= readahead_count(rac))
 			/*
 			 * Congested and only async pages left, so skip the
@@ -2293,7 +2294,7 @@ static int fuse_writepages(struct address_space *mapping,
 		return -EIO;
 
 	if (wbc->sync_mode == WB_SYNC_NONE &&
-	    fc->num_background >= fc->congestion_threshold)
+	    fc->chan->num_background >= fc->congestion_threshold)
 		return 0;
 
 	return iomap_writepages(&wpc);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 459f37ece46a..efc321b2bf5d 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -93,6 +93,22 @@ struct fuse_chan {
 
 	/** List of device instances belonging to this connection */
 	struct list_head devices;
+
+	/** Maximum number of outstanding background requests */
+	unsigned max_background;
+
+	/** Number of requests currently in the background */
+	unsigned num_background;
+
+	/** Number of background requests currently queued for userspace */
+	unsigned active_background;
+
+	/** The list of background requests set aside for later queuing */
+	struct list_head bg_queue;
+
+	/** Protects: max_background, congestion_threshold, num_background,
+	 * active_background, bg_queue, blocked */
+	spinlock_t bg_lock;
 };
 
 #define FUSE_PQ_HASH_BITS 8
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6185b97df106..ccf0db3a4eeb 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -566,25 +566,9 @@ struct fuse_conn {
 	/** rbtree of fuse_files waiting for poll events indexed by ph */
 	struct rb_root polled_files;
 
-	/** Maximum number of outstanding background requests */
-	unsigned max_background;
-
 	/** Number of background requests at which congestion starts */
 	unsigned congestion_threshold;
 
-	/** Number of requests currently in the background */
-	unsigned num_background;
-
-	/** Number of background requests currently queued for userspace */
-	unsigned active_background;
-
-	/** The list of background requests set aside for later queuing */
-	struct list_head bg_queue;
-
-	/** Protects: max_background, congestion_threshold, num_background,
-	 * active_background, bg_queue, blocked */
-	spinlock_t bg_lock;
-
 	/** Flag indicating that INIT reply has been received. Allocating
 	 * any fuse request will be suspended until the flag is set */
 	int initialized;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 4d958c53900f..16b9879c924b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -61,9 +61,6 @@ MODULE_PARM_DESC(max_user_congthresh,
 
 #define FUSE_DEFAULT_BLKSIZE 512
 
-/** Maximum number of outstanding background requests */
-#define FUSE_DEFAULT_MAX_BACKGROUND 12
-
 /** Congestion starts at 75% of maximum */
 #define FUSE_DEFAULT_CONGESTION_THRESHOLD (FUSE_DEFAULT_MAX_BACKGROUND * 3 / 4)
 
@@ -974,16 +971,13 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
-	spin_lock_init(&fc->bg_lock);
 	init_rwsem(&fc->killsb);
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
-	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	atomic_set(&fc->num_waiting, 0);
-	fc->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
 	atomic64_set(&fc->khctr, 0);
 	fc->polled_files = RB_ROOT;
@@ -1264,12 +1258,12 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 	sanitize_global_limit(&max_user_bgreq);
 	sanitize_global_limit(&max_user_congthresh);
 
-	spin_lock(&fc->bg_lock);
+	spin_lock(&fc->chan->bg_lock);
 	if (arg->max_background) {
-		fc->max_background = arg->max_background;
+		fc->chan->max_background = arg->max_background;
 
-		if (!cap_sys_admin && fc->max_background > max_user_bgreq)
-			fc->max_background = max_user_bgreq;
+		if (!cap_sys_admin && fc->chan->max_background > max_user_bgreq)
+			fc->chan->max_background = max_user_bgreq;
 	}
 	if (arg->congestion_threshold) {
 		fc->congestion_threshold = arg->congestion_threshold;
@@ -1278,7 +1272,7 @@ static void process_init_limits(struct fuse_conn *fc, struct fuse_init_out *arg)
 		    fc->congestion_threshold > max_user_congthresh)
 			fc->congestion_threshold = max_user_congthresh;
 	}
-	spin_unlock(&fc->bg_lock);
+	spin_unlock(&fc->chan->bg_lock);
 }
 
 struct fuse_init_args {
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index ca44a7940174..ee2b4dc394e0 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -83,9 +83,9 @@ static void fuse_check_timeout(struct work_struct *work)
 	if (expired)
 		goto abort_conn;
 
-	spin_lock(&fc->bg_lock);
-	expired = fuse_request_expired(fc, &fc->bg_queue);
-	spin_unlock(&fc->bg_lock);
+	spin_lock(&fc->chan->bg_lock);
+	expired = fuse_request_expired(fc, &fc->chan->bg_queue);
+	spin_unlock(&fc->chan->bg_lock);
 	if (expired)
 		goto abort_conn;
 
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index d688a2a95753..53ce21836ba0 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1520,7 +1520,7 @@ static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 		if (ret == -ENOSPC) {
 			/*
 			 * Virtqueue full. Retry submission from worker
-			 * context as we might be holding fc->bg_lock.
+			 * context as we might be holding fc->chan->bg_lock.
 			 */
 			spin_lock(&fsvq->lock);
 			list_add_tail(&req->list, &fsvq->queued_reqs);
-- 
2.53.0

