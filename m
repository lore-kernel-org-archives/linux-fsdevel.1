Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3D39A05C
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331033; cv=none; b=kmQpPXFyeV7mZRSltzAnbXj5b8+zftyXnTS4riQZSX4gIwAHuKl2l5Cg7yw3VDYTPd1VxshM7XVJCiMBydYbJIyyIqMu81UUnpSPmk9p9UmE9RpPstyrHIy0x0M3yzJNAjiygbFvpaKzs+S9RcWB7KhCSOlmefWmaAEBvXoAqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331033; c=relaxed/simple;
	bh=CS3xEMRdfHGZ7gK+F04mZbRjBLd/CosPPzEEGSyXx+4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kjNnfnv/8OF5EJHp/X7o1nT2BNA4LFmXo3vAPDJp5weBk329r6wAE5nUJ+YSRZI6sihjlp4jAbtTytTpBFXcJplqWI+qgAJunLuUdO7NYjkQz0Hbq375A5xYooY3Asc/E+nv0k3RvL6mZ8mhEoalInwOFkd56szAcG9/MHh0bCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FMxG5msu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=F7FIDJ+Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FMxG5msu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="F7FIDJ+Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331028;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9avm6xCBgs4bDIOEjKIjvX0iMPVGkaEx3X8OJWDahB4=;
	b=FMxG5msubeGrMy5SiU9Dbo+Qs8hJlvtonZxBXMcRuubWZjJluOsxq1XIUNxSxfQcfXKfIW
	WH3w0JpsiK7FFZ0gJVjVr+F4Ifm2kovJkJgHoFtXxrXaVPgoSah1wmva93lMdI2w65ClUh
	ES/fDnPfBUl00Bh7W4CHsRHzQd8CEko=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-etEy6WKmNI2nDDzvH59cug-1; Thu, 16 Apr 2026 05:17:07 -0400
X-MC-Unique: etEy6WKmNI2nDDzvH59cug-1
X-Mimecast-MFC-AGG-ID: etEy6WKmNI2nDDzvH59cug_1776331026
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488d4ac6ff9so45271295e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331025; x=1776935825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9avm6xCBgs4bDIOEjKIjvX0iMPVGkaEx3X8OJWDahB4=;
        b=F7FIDJ+QFZK9H0zvb/8uivnTqwNlx5K73woHon8ng2/gINpqTM0eCJ+pqr4CmpP+2I
         9pTXD6FkR2lVeop5p7QH1huePqBVZ7lRQw6qE2u9vC2CNBoHa8DdHYdizPxBGrJ654JK
         dqH55PbRBcbXPPNSjyu/wSjvWPHaUx2a7MxVf8NIDmqvZY7m1imZT0Xx9Oj4301lIXHN
         AEi9Pa42hfHu2HJLu612gT9IkWPsLAzpe4OoxamY5lsZbOrkmmfdpqO3+UrBX2erHLEI
         u4+3gGcDHadMSwO638S0H5POU/3rc6vsB/P1UkS6gpxSFLZMJm2KVbZAmM71OHzHu+52
         PNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331025; x=1776935825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9avm6xCBgs4bDIOEjKIjvX0iMPVGkaEx3X8OJWDahB4=;
        b=lnMxpfeRrbht9TtVNSSjYhkklVExc5g+ICSUqHc61z1JqaNS9SgWrhOtSBtRnsz9HN
         WeZV6lQJRWVFcCAwW6Yr0ht/OVImq/14qHK3TARtKr5f2PbsqwqXCIO44SXY20PnIhNw
         ryAGlBHeR4JPsPEUZEPi6E0S2foIqpOo5V7AK0sklm229/LZ4BfDoiJGm62/gB9WYvkA
         3Ku2ReFe6senfo57W0dDswcgm4PCq0hIqSTbN3k5XznC4dD9UTySQQV3j3GU36kFVRMf
         8Aq+BjJoBGjuxDHjB7gvgNzDKfro2h6dnwl0c/CK/vgF4He3/cqO78PLKB89mHMBfZGP
         j8sw==
X-Forwarded-Encrypted: i=1; AFNElJ8nmWLFxcdRcRiiFNG9li8F1i3SwrSODM2Syyu9yYG16wPinK60cpaA7Pqc8EhvfcsxdQdRFzyEVXGSRYAy@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1L3+YS0ijWUKO1Q9IyuzA9cFVxSg9WmXVTMHQCEgkOcSHmMIt
	Xs+hJIDJhvADnWHOISwjubAfVB1oq8LPplR4B1K5Q3357Dz/BM+ovHAh9cE+70dhYAbtasa5pPa
	lfqZsU+ySnWRTmydsBBbYvX+et6M1qug9UvyEZfJRhgNVlJ08sRJ+fX73hfnMVXRGAGhzTSIGA1
	Q=
X-Gm-Gg: AeBDietVgaHbOFjmqVR3ddXPTRFVD/uAy0NqJJkYivooLzZryog70AzckA25xPJTK4Y
	qNEmaj9zUJgm1iYxT5DEy9Dmk+vHpIP2f1g+mwUJ0r8ClAB1ZyC/7OyWfdYYqT5Afae4T/+ud5z
	hjpa/y7+WgL6vovKNaDvICrhJRTmmpqpUihw8iigQM7ng/Y+gVI7esyx+eGu2jjpMwtQTHc4VVr
	1n1pr/2gQIriyZ7x4omgGjfTn2oXH2GVtV2GzAaw+JjjU5mdQHw0Jcgu4St1dGXjDiK1a4VmxGU
	ImPzabK98s69LbyovyI8aKfYXduM9iqj8VRifyvaQbLThznX7xcM6adLtqM3Il0H0t7F8xvqXTb
	LrBh7nPlhvjEjqGmpq10WGWDF7SCWm6oayKoiLcawjg1524W3ehndylG0EAXvoMVl56Ep51kwwj
	RjasohRg==
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr347051105e9.13.1776331025180;
        Thu, 16 Apr 2026 02:17:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr347050395e9.13.1776331024509;
        Thu, 16 Apr 2026 02:17:04 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:03 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/32] fuse: move fuse_iqueue to fuse_chan
Date: Thu, 16 Apr 2026 11:16:27 +0200
Message-ID: <20260416091658.462783-4-mszeredi@redhat.com>
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

Move the 'fiq' member from fuse_conn to fuse_chan.

Move iqueue related structure definitions and function declarations from
"fuse_i.h" to "fuse_dev_i.h".

Add a fuse_dev_chan_new() helper, that returns a fuse_chan initialized with
the fuse_dev_fiq_ops.

Add a fuse_chan_release() function, that calls fiq->ops->release().

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/cuse.c        |  6 +--
 fs/fuse/dev.c         | 64 +++++++++++++++++++++++--------
 fs/fuse/dev.h         |  2 +
 fs/fuse/dev_uring.c   |  2 +-
 fs/fuse/dev_uring_i.h |  1 +
 fs/fuse/fuse_dev_i.h  | 81 +++++++++++++++++++++++++++++++++++++++-
 fs/fuse/fuse_i.h      | 87 +------------------------------------------
 fs/fuse/inode.c       | 27 ++------------
 fs/fuse/req_timeout.c |  2 +-
 fs/fuse/virtio_fs.c   | 11 +++---
 10 files changed, 146 insertions(+), 137 deletions(-)

diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index b135c3281a05..35a964a47901 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -503,7 +503,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 {
 	struct fuse_dev *fud;
 	struct cuse_conn *cc;
-	struct fuse_chan *fch __free(fuse_chan_free) = fuse_chan_new();
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_dev_chan_new();
 	int rc;
 
 	if (!fch)
@@ -518,9 +518,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 	 * Limit the cuse channel to requests that can
 	 * be represented in file->f_cred->user_ns.
 	 */
-	fuse_conn_init(&cc->fc, &cc->fm, file->f_cred->user_ns,
-		       &fuse_dev_fiq_ops, NULL, no_free_ptr(fch));
-
+	fuse_conn_init(&cc->fc, &cc->fm, file->f_cred->user_ns, no_free_ptr(fch));
 	cc->fc.release = cuse_fc_release;
 	fud = fuse_dev_alloc_install(&cc->fc);
 	fuse_conn_put(&cc->fc);
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 3e1e8ce83f1c..d3bcd8a11b40 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -313,12 +313,32 @@ static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	}
 }
 
-const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
+static const struct fuse_iqueue_ops fuse_dev_fiq_ops = {
 	.send_forget	= fuse_dev_queue_forget,
 	.send_interrupt	= fuse_dev_queue_interrupt,
 	.send_req	= fuse_dev_queue_req,
 };
-EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
+
+void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv)
+{
+	spin_lock_init(&fiq->lock);
+	init_waitqueue_head(&fiq->waitq);
+	INIT_LIST_HEAD(&fiq->pending);
+	INIT_LIST_HEAD(&fiq->interrupts);
+	fiq->forget_list_tail = &fiq->forget_list_head;
+	fiq->connected = 1;
+	fiq->ops = ops;
+	fiq->priv = priv;
+}
+EXPORT_SYMBOL_GPL(fuse_iqueue_init);
+
+void fuse_chan_release(struct fuse_chan *fch)
+{
+	struct fuse_iqueue *fiq = &fch->iq;
+
+	if (fiq->ops->release)
+		fiq->ops->release(fiq);
+}
 
 void fuse_chan_free(struct fuse_chan *fch)
 {
@@ -332,6 +352,18 @@ struct fuse_chan *fuse_chan_new(void)
 }
 EXPORT_SYMBOL_GPL(fuse_chan_new);
 
+struct fuse_chan *fuse_dev_chan_new(void)
+{
+	struct fuse_chan *fch = fuse_chan_new();
+	if (!fch)
+		return NULL;
+
+	fuse_iqueue_init(&fch->iq, &fuse_dev_fiq_ops, NULL);
+
+	return fch;
+}
+EXPORT_SYMBOL_GPL(fuse_dev_chan_new);
+
 static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	req->in.h.len = sizeof(struct fuse_in_header) +
@@ -343,7 +375,7 @@ static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *req)
 void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 		       u64 nodeid, u64 nlookup)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	forget->forget_one.nodeid = nodeid;
 	forget->forget_one.nlookup = nlookup;
@@ -353,7 +385,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *forget,
 
 static void flush_bg_queue(struct fuse_conn *fc)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	while (fc->active_background < fc->max_background &&
 	       !list_empty(&fc->bg_queue)) {
@@ -378,7 +410,7 @@ void fuse_request_end(struct fuse_req *req)
 {
 	struct fuse_mount *fm = req->fm;
 	struct fuse_conn *fc = fm->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
@@ -431,7 +463,7 @@ EXPORT_SYMBOL_GPL(fuse_request_end);
 
 static int queue_interrupt(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_iqueue *fiq = &req->fm->fc->chan->iq;
 
 	/* Check for we've sent request to interrupt this req */
 	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags)))
@@ -463,7 +495,7 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
 static void request_wait_answer(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 	int err;
 
 	if (!fc->no_interrupt) {
@@ -511,7 +543,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->iq;
+	struct fuse_iqueue *fiq = &req->fm->fc->chan->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 
@@ -630,7 +662,7 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
 					       struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
@@ -709,7 +741,7 @@ static int fuse_simple_notify_reply(struct fuse_mount *fm,
 				    struct fuse_args *args, u64 unique)
 {
 	struct fuse_req *req;
-	struct fuse_iqueue *fiq = &fm->fc->iq;
+	struct fuse_iqueue *fiq = &fm->fc->chan->iq;
 
 	req = fuse_get_req(&invalid_mnt_idmap, fm, false);
 	if (IS_ERR(req))
@@ -1332,7 +1364,7 @@ static ssize_t fuse_dev_do_read(struct fuse_dev *fud, struct file *file,
 {
 	ssize_t err;
 	struct fuse_conn *fc = fud->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 	struct fuse_pqueue *fpq = &fud->pq;
 	struct fuse_req *req;
 	struct fuse_args *args;
@@ -1910,7 +1942,7 @@ static void fuse_resend(struct fuse_conn *fc)
 {
 	struct fuse_dev *fud;
 	struct fuse_req *req, *next;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 	LIST_HEAD(to_queue);
 	unsigned int i;
 
@@ -2314,7 +2346,7 @@ static __poll_t fuse_dev_poll(struct file *file, poll_table *wait)
 	if (IS_ERR(fud))
 		return EPOLLERR;
 
-	fiq = &fud->fc->iq;
+	fiq = &fud->fc->chan->iq;
 	poll_wait(file, &fiq->waitq, wait);
 
 	spin_lock(&fiq->lock);
@@ -2375,7 +2407,7 @@ static void end_polls(struct fuse_conn *fc)
  */
 void fuse_abort_conn(struct fuse_conn *fc)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	spin_lock(&fc->lock);
 	if (fc->connected) {
@@ -2483,7 +2515,7 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 		spin_unlock(&fc->lock);
 
 		if (last) {
-			WARN_ON(fc->iq.fasync != NULL);
+			WARN_ON(fc->chan->iq.fasync != NULL);
 			fuse_abort_conn(fc);
 		}
 		fuse_conn_put(fc);
@@ -2501,7 +2533,7 @@ static int fuse_dev_fasync(int fd, struct file *file, int on)
 		return PTR_ERR(fud);
 
 	/* No locking - fasync_helper does its own locking */
-	return fasync_helper(fd, file, on, &fud->fc->iq.fasync);
+	return fasync_helper(fd, file, on, &fud->fc->chan->iq.fasync);
 }
 
 static long fuse_dev_ioctl_clone(struct file *file, __u32 __user *argp)
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 70e4a75e6942..d5ccfae80115 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -9,6 +9,8 @@ struct fuse_conn;
 struct fuse_chan;
 
 struct fuse_chan *fuse_chan_new(void);
+struct fuse_chan *fuse_dev_chan_new(void);
+void fuse_chan_release(struct fuse_chan *fch);
 void fuse_chan_free(struct fuse_chan *fch);
 DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..d28027f9d743 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -982,7 +982,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
 	struct fuse_conn *fc = ring->fc;
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..9edb8295fdb2 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -8,6 +8,7 @@
 #define _FS_FUSE_DEV_URING_I_H
 
 #include "fuse_i.h"
+#include "fuse_dev_i.h"
 
 #ifdef CONFIG_FUSE_IO_URING
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 8d69ea8761c5..eca9d463d571 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -21,8 +21,75 @@ struct fuse_req;
 struct fuse_iqueue;
 struct fuse_forget_link;
 
+/**
+ * Input queue callbacks
+ *
+ * Input queue signalling is device-specific.  For example, the /dev/fuse file
+ * uses fiq->waitq and fasync to wake processes that are waiting on queue
+ * readiness.  These callbacks allow other device types to respond to input
+ * queue activity.
+ */
+struct fuse_iqueue_ops {
+	/**
+	 * Send one forget
+	 */
+	void (*send_forget)(struct fuse_iqueue *fiq, struct fuse_forget_link *link);
+
+	/**
+	 * Send interrupt for request
+	 */
+	void (*send_interrupt)(struct fuse_iqueue *fiq, struct fuse_req *req);
+
+	/**
+	 * Send one request
+	 */
+	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
+
+	/**
+	 * Clean up when fuse_iqueue is destroyed
+	 */
+	void (*release)(struct fuse_iqueue *fiq);
+};
+
+struct fuse_iqueue {
+	/** Connection established */
+	unsigned connected;
+
+	/** Lock protecting accesses to members of this structure */
+	spinlock_t lock;
+
+	/** Readers of the connection are waiting on this */
+	wait_queue_head_t waitq;
+
+	/** The next unique request id */
+	u64 reqctr;
+
+	/** The list of pending requests */
+	struct list_head pending;
+
+	/** Pending interrupts */
+	struct list_head interrupts;
+
+	/** Queue of pending forgets */
+	struct fuse_forget_link forget_list_head;
+	struct fuse_forget_link *forget_list_tail;
+
+	/** Batching of FORGET requests (positive indicates FORGET batch) */
+	int forget_batch;
+
+	/** O_ASYNC requests */
+	struct fasync_struct *fasync;
+
+	/** Device-specific callbacks */
+	const struct fuse_iqueue_ops *ops;
+
+	/** Device-specific state */
+	void *priv;
+};
+
 struct fuse_chan {
-	/* will move stuff from struct fuse_conn */
+	/** Input queue */
+	struct fuse_iqueue iq;
 };
 
 struct fuse_copy_state {
@@ -75,6 +142,8 @@ static inline struct fuse_dev *__fuse_get_dev(struct file *file)
 	return fud;
 }
 
+void fuse_iqueue_init(struct fuse_iqueue *fiq, const struct fuse_iqueue_ops *ops, void *priv);
+
 struct fuse_dev *fuse_get_dev(struct file *file);
 
 unsigned int fuse_req_hash(u64 unique);
@@ -97,5 +166,15 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
 bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
 
+/**
+ * Assign a unique id to a fuse request
+ */
+void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
+
+/**
+ * Get the next unique ID for a request
+ */
+u64 fuse_get_unique(struct fuse_iqueue *fiq);
+
 #endif
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index deaffe245284..29126f5cb66c 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -469,77 +469,6 @@ struct fuse_req {
 	unsigned long create_time;
 };
 
-struct fuse_iqueue;
-
-/**
- * Input queue callbacks
- *
- * Input queue signalling is device-specific.  For example, the /dev/fuse file
- * uses fiq->waitq and fasync to wake processes that are waiting on queue
- * readiness.  These callbacks allow other device types to respond to input
- * queue activity.
- */
-struct fuse_iqueue_ops {
-	/**
-	 * Send one forget
-	 */
-	void (*send_forget)(struct fuse_iqueue *fiq, struct fuse_forget_link *link);
-
-	/**
-	 * Send interrupt for request
-	 */
-	void (*send_interrupt)(struct fuse_iqueue *fiq, struct fuse_req *req);
-
-	/**
-	 * Send one request
-	 */
-	void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
-
-	/**
-	 * Clean up when fuse_iqueue is destroyed
-	 */
-	void (*release)(struct fuse_iqueue *fiq);
-};
-
-/** /dev/fuse input queue operations */
-extern const struct fuse_iqueue_ops fuse_dev_fiq_ops;
-
-struct fuse_iqueue {
-	/** Connection established */
-	unsigned connected;
-
-	/** Lock protecting accesses to members of this structure */
-	spinlock_t lock;
-
-	/** Readers of the connection are waiting on this */
-	wait_queue_head_t waitq;
-
-	/** The next unique request id */
-	u64 reqctr;
-
-	/** The list of pending requests */
-	struct list_head pending;
-
-	/** Pending interrupts */
-	struct list_head interrupts;
-
-	/** Queue of pending forgets */
-	struct fuse_forget_link forget_list_head;
-	struct fuse_forget_link *forget_list_tail;
-
-	/** Batching of FORGET requests (positive indicates FORGET batch) */
-	int forget_batch;
-
-	/** O_ASYNC requests */
-	struct fasync_struct *fasync;
-
-	/** Device-specific callbacks */
-	const struct fuse_iqueue_ops *ops;
-
-	/** Device-specific state */
-	void *priv;
-};
-
 #define FUSE_PQ_HASH_BITS 8
 #define FUSE_PQ_HASH_SIZE (1 << FUSE_PQ_HASH_BITS)
 
@@ -665,9 +594,6 @@ struct fuse_conn {
 	/** Constrain ->max_pages to this value during feature negotiation */
 	unsigned int max_pages_limit;
 
-	/** Input queue */
-	struct fuse_iqueue iq;
-
 	/* transport layer object */
 	struct fuse_chan *chan;
 
@@ -1259,11 +1185,6 @@ static inline ssize_t fuse_simple_idmap_request(struct mnt_idmap *idmap,
 int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 			   gfp_t gfp_flags);
 
-/**
- * Assign a unique id to a fuse request
- */
-void fuse_request_assign_unique(struct fuse_iqueue *fiq, struct fuse_req *req);
-
 /**
  * End a finished request
  */
@@ -1315,9 +1236,7 @@ void fuse_pqueue_init(struct fuse_pqueue *fpq);
  * Initialize fuse_conn
  */
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
-		    struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv,
-		    struct fuse_chan *fch);
+		    struct user_namespace *user_ns, struct fuse_chan *fch);
 
 /**
  * Release reference to fuse_conn
@@ -1484,10 +1403,6 @@ int fuse_readdir(struct file *file, struct dir_context *ctx);
  */
 unsigned int fuse_len_args(unsigned int numargs, struct fuse_arg *args);
 
-/**
- * Get the next unique ID for a request
- */
-u64 fuse_get_unique(struct fuse_iqueue *fiq);
 void fuse_free_conn(struct fuse_conn *fc);
 
 /* dax.c */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 758cefa9b9b6..932d83883ce1 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -969,21 +969,6 @@ static int fuse_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
-static void fuse_iqueue_init(struct fuse_iqueue *fiq,
-			     const struct fuse_iqueue_ops *ops,
-			     void *priv)
-{
-	memset(fiq, 0, sizeof(struct fuse_iqueue));
-	spin_lock_init(&fiq->lock);
-	init_waitqueue_head(&fiq->waitq);
-	INIT_LIST_HEAD(&fiq->pending);
-	INIT_LIST_HEAD(&fiq->interrupts);
-	fiq->forget_list_tail = &fiq->forget_list_head;
-	fiq->connected = 1;
-	fiq->ops = ops;
-	fiq->priv = priv;
-}
-
 void fuse_pqueue_init(struct fuse_pqueue *fpq)
 {
 	unsigned int i;
@@ -996,8 +981,7 @@ void fuse_pqueue_init(struct fuse_pqueue *fpq)
 }
 
 void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
-		    struct user_namespace *user_ns,
-		    const struct fuse_iqueue_ops *fiq_ops, void *fiq_priv, struct fuse_chan *fch)
+		    struct user_namespace *user_ns, struct fuse_chan *fch)
 {
 	memset(fc, 0, sizeof(*fc));
 	spin_lock_init(&fc->lock);
@@ -1007,7 +991,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
 	init_waitqueue_head(&fc->blocked_waitq);
-	fuse_iqueue_init(&fc->iq, fiq_ops, fiq_priv);
 	INIT_LIST_HEAD(&fc->bg_queue);
 	INIT_LIST_HEAD(&fc->entry);
 	INIT_LIST_HEAD(&fc->devices);
@@ -1052,7 +1035,6 @@ static void delayed_release(struct rcu_head *p)
 
 void fuse_conn_put(struct fuse_conn *fc)
 {
-	struct fuse_iqueue *fiq = &fc->iq;
 	struct fuse_sync_bucket *bucket;
 
 	if (!refcount_dec_and_test(&fc->count))
@@ -1063,8 +1045,7 @@ void fuse_conn_put(struct fuse_conn *fc)
 	if (fc->timeout.req_timeout)
 		cancel_delayed_work_sync(&fc->timeout.work);
 	cancel_work_sync(&fc->epoch_work);
-	if (fiq->ops->release)
-		fiq->ops->release(fiq);
+	fuse_chan_release(fc->chan);
 	put_pid_ns(fc->pid_ns);
 	bucket = rcu_dereference_protected(fc->curr_bucket, 1);
 	if (bucket) {
@@ -1984,7 +1965,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 	struct fuse_conn *fc;
 	struct fuse_mount *fm;
 	struct super_block *sb;
-	struct fuse_chan *fch __free(fuse_chan_free) = fuse_chan_new();
+	struct fuse_chan *fch __free(fuse_chan_free) = fuse_dev_chan_new();
 	int err;
 
 	if (!fch)
@@ -2000,7 +1981,7 @@ static int fuse_get_tree(struct fs_context *fsc)
 		return -ENOMEM;
 	}
 
-	fuse_conn_init(fc, fm, fsc->user_ns, &fuse_dev_fiq_ops, NULL, no_free_ptr(fch));
+	fuse_conn_init(fc, fm, fsc->user_ns, no_free_ptr(fch));
 	fc->release = fuse_free_conn;
 
 	fsc->s_fs_info = fm;
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index 64d9b503e6c5..5357a2d63b3f 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -69,7 +69,7 @@ static void fuse_check_timeout(struct work_struct *work)
 	struct delayed_work *dwork = to_delayed_work(work);
 	struct fuse_conn *fc = container_of(dwork, struct fuse_conn,
 					    timeout.work);
-	struct fuse_iqueue *fiq = &fc->iq;
+	struct fuse_iqueue *fiq = &fc->chan->iq;
 	struct fuse_dev *fud;
 	struct fuse_pqueue *fpq;
 	bool expired = false;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index f6d41b760210..d688a2a95753 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1563,7 +1563,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 {
 	struct fuse_mount *fm = get_fuse_mount_super(sb);
 	struct fuse_conn *fc = fm->fc;
-	struct virtio_fs *fs = fc->iq.priv;
+	struct virtio_fs *fs = fc->chan->iq.priv;
 	struct fuse_fs_context *ctx = fsc->fs_private;
 	unsigned int i;
 	int err;
@@ -1626,7 +1626,7 @@ static int virtio_fs_fill_super(struct super_block *sb, struct fs_context *fsc)
 static void virtio_fs_conn_destroy(struct fuse_mount *fm)
 {
 	struct fuse_conn *fc = fm->fc;
-	struct virtio_fs *vfs = fc->iq.priv;
+	struct virtio_fs *vfs = fc->chan->iq.priv;
 	struct virtio_fs_vq *fsvq = &vfs->vqs[VQ_HIPRIO];
 
 	/* Stop dax worker. Soon evict_inodes() will be called which
@@ -1674,7 +1674,7 @@ static int virtio_fs_test_super(struct super_block *sb,
 	struct fuse_mount *fsc_fm = fsc->s_fs_info;
 	struct fuse_mount *sb_fm = get_fuse_mount_super(sb);
 
-	return fsc_fm->fc->iq.priv == sb_fm->fc->iq.priv;
+	return fsc_fm->fc->chan->iq.priv == sb_fm->fc->chan->iq.priv;
 }
 
 static int virtio_fs_get_tree(struct fs_context *fsc)
@@ -1694,7 +1694,7 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 		return invalf(fsc, "No source specified");
 
 	/* This gets a reference on virtio_fs object. This ptr gets installed
-	 * in fc->iq->priv. Once fuse_conn is going away, it calls ->put()
+	 * in chan->iq->priv. Once fuse_conn is going away, it calls ->put()
 	 * to drop the reference to this object.
 	 */
 	fs = virtio_fs_find_instance(fsc->source);
@@ -1716,7 +1716,8 @@ static int virtio_fs_get_tree(struct fs_context *fsc)
 	if (!fm)
 		goto out_err;
 
-	fuse_conn_init(fc, fm, fsc->user_ns, &virtio_fs_fiq_ops, fs, no_free_ptr(fch));
+	fuse_iqueue_init(&fch->iq, &virtio_fs_fiq_ops, fs);
+	fuse_conn_init(fc, fm, fsc->user_ns, no_free_ptr(fch));
 
 	fc->release = fuse_free_conn;
 	fc->delete_stale = true;
-- 
2.53.0

