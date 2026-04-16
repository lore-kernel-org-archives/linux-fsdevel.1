Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F9C39891E
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331040; cv=none; b=Cz7InBtAeJdaE1oaYEUy2lChOaZgVBkxnks1ivJJYMy9KQB4CBOLYGXOBhGl5/gTFW0LasYcnxxABdIcD2wocRgpryRJ298bXFpA0w9Q26meFs6toMoXZnEGszg+BBQDezkft5fTXe8qYqZDoUGp8qOToCHAs8BUxKseGCTDHOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331040; c=relaxed/simple;
	bh=UIlwrXVges/DlR+VJbkCv9wNlgnTZzKF8Uep4d4A3ys=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuQokFw1Ezbxaq9mh53OifmMpFFilMWMFqSofi5M1H5owkgwCYUDiPUm6kJ43x4ujw0pJNqNzsCWZ/Ghe1/hkbfwvNABrxNGiCcTLZ7JSxRYmySzII2FUXsFfGUHTQLpltKeP0pvaI6Zq0mIK32uTYlU5W4QjS5pY63yCRKCOyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jkx2IY5W; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rgs3gye+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jkx2IY5W";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rgs3gye+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2kB1Kq1bBgJtjs+jQeyFG99zrDpPeWx7BqpoxF9T4ks=;
	b=Jkx2IY5WhopvOMhEPjQfRda8OBMbIyHuvX1rV5kKtFrrsTmHkf4Qm95QH2IhUy24f34b6f
	ZcNMnYJtbbvrNTzbkkt/hayrZUQtxkUTGjx0/4KX8KAYXkO5QPpLfr4dOPLdsMdNHjkAKr
	TaJozGR9hDTGZcjnfwwYs0HX4MXRx9M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-237--ZCrD_rHN3melnXpJ5GlBA-1; Thu, 16 Apr 2026 05:17:14 -0400
X-MC-Unique: -ZCrD_rHN3melnXpJ5GlBA-1
X-Mimecast-MFC-AGG-ID: -ZCrD_rHN3melnXpJ5GlBA_1776331033
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d76eeb303so4505978f8f.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331033; x=1776935833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2kB1Kq1bBgJtjs+jQeyFG99zrDpPeWx7BqpoxF9T4ks=;
        b=rgs3gye+w8YUqQoNQSj+Bz8cMzqj3nCpknqOaxnf/1y1lcwutNCaiJwf900P0DMVdS
         vYhru5Zqv8/dOdtGRiQF945xz4YRiSIqZiHLMo3BOX3LnhknCucR0rUKB73kS9BQQ1CZ
         NXQZ0F/ynenoX6EOgl57dDjqdKruQD7+2F/CCzEtF37IS7eTDt74I9ikVw4I90l3cQmc
         bdyxkVqHDkzkg0tS3a/3MXS0D07qoZ5tDQTh49W63kjM3vJTpn8LD332KIk3U1RvFdcV
         nkA5AnGLtFBNBVNLQufWiqlNDBf0Q3ThfqpzBqmUOR5lKVvUcSmI9J99v+ZHVOkhUHHp
         Ow9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331033; x=1776935833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2kB1Kq1bBgJtjs+jQeyFG99zrDpPeWx7BqpoxF9T4ks=;
        b=V28g8nXSyUWliqZc3ZkEpd4wHzSpkMOuayjFjswmKgxbNnm+k3g+Cy4lTTmx/rEOUW
         vHG5iXE0mhfflGh8VvCoW0xl5d3oMxzQbJxeufOfk2a9PkVtjYsfK/U/cOn0E6OZaoEl
         9xsjSZONxqKG9shNtK+Q9Qj9BqgVgj8FhEJTpOfTHtidbYFs6DnhLafck0o6AJtEutt3
         Z/Pk2P+EibPZBeVzHms8ju2FUmu6vIyU//5PbkcS/00419p4taTPtuGJ1G/BOnYLCPxX
         x6TWAOcpDUTuWnqfkmbokT00u01Kjod4/o6g43Zg53TdjqyDtTeqvHZ28mEZmj9sFgOy
         Qqbw==
X-Forwarded-Encrypted: i=1; AFNElJ8ge1v3mAPD9zha5Qwhocc/ziACZ7Vl77XsB/f2LYUukjJBkmBzHanQ13PewuaneXGg1QjuN/QRcQHpO8c+@vger.kernel.org
X-Gm-Message-State: AOJu0YzbsqdLLcGh0dtCg0NiJ2KEWFQx4QOyNd4TSz27QG5Iql/bUTzG
	gNDzN5wjnARaAvnXBe9Sp7cRB47Dcw8ucU6QaNbw1W0Rg957SabnDGZKEq2XTcjg3RNHkkN4uJK
	iisFYfOzXPRidaWvfr5LrxHGyOOy9vwGslEK7tO7wAdfyM+8utshZ1YFgTQs4HkbKyBgQl5lseB
	I=
X-Gm-Gg: AeBDieuZaJXiR9bWReUCH6SDMgX6DnzVMz7HiRWX4OsWitOuUkS43ZudOyQ+cOyyGdS
	IsYMg6JeNi3r+fHI3fNuWjBOPrvw0gIrCP6+SQPsFOj8pp0Be/g+MNII/dYDyE7sTMWi1JElMps
	BPa8OF5SswrAWLJpVHdyd25s7Go/BSNLWsV1tMK6/hG37XkBMY7EfL7yOlOPsm0O2KY0UYTMbDQ
	kAd12y1Cu7//iLIKuXBF4/FA2WRbsSLJkGpKT6JkmeabR0fhtqM3+uGpYeQ3eEEif0D0h8TIhO0
	AlqYi3cvjHc7Z8KrKTafVqJuG5ziZiAakaNwVXLo6htVMEGv3pmENBqOqUS0aRbJdW0e83xyzfN
	IaJp80fHhvUJdCpHHvmKxDGCpu3gWKayWFafv8nYiNcrUG1gi2uYdFQO6GNlPyim/2D8JM3Q/uJ
	DtBfLIWw==
X-Received: by 2002:a05:600c:8207:b0:488:bf0c:a372 with SMTP id 5b1f17b1804b1-488d68a0ec8mr353138915e9.31.1776331032534;
        Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
X-Received: by 2002:a05:600c:8207:b0:488:bf0c:a372 with SMTP id 5b1f17b1804b1-488d68a0ec8mr353138425e9.31.1776331032019;
        Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:10 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/32] fuse: move request blocking related members to fuse_chan
Date: Thu, 16 Apr 2026 11:16:31 +0200
Message-ID: <20260416091658.462783-8-mszeredi@redhat.com>
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

 - initialized
 - blocked
 - blocked_waitq
 - connected
 - num_waiting

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/control.c     |  8 ++---
 fs/fuse/cuse.c        |  4 +--
 fs/fuse/dev.c         | 69 +++++++++++++++++++++++--------------------
 fs/fuse/dev_uring.c   | 12 ++++----
 fs/fuse/fuse_dev_i.h  | 19 ++++++++++++
 fs/fuse/fuse_i.h      | 19 ------------
 fs/fuse/inode.c       |  7 +----
 fs/fuse/req_timeout.c |  4 +--
 8 files changed, 71 insertions(+), 71 deletions(-)

diff --git a/fs/fuse/control.c b/fs/fuse/control.c
index 6279a37716c5..228e1e7114b7 100644
--- a/fs/fuse/control.c
+++ b/fs/fuse/control.c
@@ -58,7 +58,7 @@ static ssize_t fuse_conn_waiting_read(struct file *file, char __user *buf,
 		if (!fc)
 			return 0;
 
-		value = atomic_read(&fc->num_waiting);
+		value = atomic_read(&fc->chan->num_waiting);
 		file->private_data = (void *)value;
 		fuse_conn_put(fc);
 	}
@@ -132,9 +132,9 @@ static ssize_t fuse_conn_max_background_write(struct file *file,
 		if (fc) {
 			spin_lock(&fc->chan->bg_lock);
 			fc->chan->max_background = val;
-			fc->blocked = fc->chan->num_background >= fc->chan->max_background;
-			if (!fc->blocked)
-				wake_up(&fc->blocked_waitq);
+			fc->chan->blocked = fc->chan->num_background >= fc->chan->max_background;
+			if (!fc->chan->blocked)
+				wake_up(&fc->chan->blocked_waitq);
 			spin_unlock(&fc->chan->bg_lock);
 			fuse_conn_put(fc);
 		}
diff --git a/fs/fuse/cuse.c b/fs/fuse/cuse.c
index 35a964a47901..728608d35d0a 100644
--- a/fs/fuse/cuse.c
+++ b/fs/fuse/cuse.c
@@ -527,7 +527,7 @@ static int cuse_channel_open(struct inode *inode, struct file *file)
 
 	INIT_LIST_HEAD(&cc->list);
 
-	cc->fc.initialized = 1;
+	cc->fc.chan->initialized = 1;
 	rc = cuse_send_init(cc);
 	if (rc) {
 		fuse_dev_put(fud);
@@ -584,7 +584,7 @@ static ssize_t cuse_class_waiting_show(struct device *dev,
 {
 	struct cuse_conn *cc = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", atomic_read(&cc->fc.num_waiting));
+	return sprintf(buf, "%d\n", atomic_read(&cc->fc.chan->num_waiting));
 }
 static DEVICE_ATTR(waiting, 0400, cuse_class_waiting_show, NULL);
 
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 68a96b41f7e6..9885347df331 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -73,26 +73,26 @@ void fuse_set_initialized(struct fuse_conn *fc)
 {
 	/* Make sure stores before this are seen on another CPU */
 	smp_wmb();
-	fc->initialized = 1;
+	fc->chan->initialized = 1;
 }
 
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 {
-	return !fc->initialized || (for_background && fc->blocked) ||
-	       (fc->io_uring && fc->connected && !fuse_uring_ready(fc));
+	return !fc->chan->initialized || (for_background && fc->chan->blocked) ||
+	       (fc->io_uring && fc->chan->connected && !fuse_uring_ready(fc));
 }
 
 static void fuse_drop_waiting(struct fuse_conn *fc)
 {
 	/*
-	 * lockess check of fc->connected is okay, because atomic_dec_and_test()
+	 * lockess check of fc->chan->connected is okay, because atomic_dec_and_test()
 	 * provides a memory barrier matched with the one in fuse_wait_aborted()
 	 * to ensure no wake-up is missed.
 	 */
-	if (atomic_dec_and_test(&fc->num_waiting) &&
-	    !READ_ONCE(fc->connected)) {
+	if (atomic_dec_and_test(&fc->chan->num_waiting) &&
+	    !READ_ONCE(fc->chan->connected)) {
 		/* wake up aborters */
-		wake_up_all(&fc->blocked_waitq);
+		wake_up_all(&fc->chan->blocked_waitq);
 	}
 }
 
@@ -109,11 +109,11 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	kgid_t fsgid;
 	int err;
 
-	atomic_inc(&fc->num_waiting);
+	atomic_inc(&fc->chan->num_waiting);
 
 	if (fuse_block_alloc(fc, for_background)) {
 		err = -EINTR;
-		if (wait_event_state_exclusive(fc->blocked_waitq,
+		if (wait_event_state_exclusive(fc->chan->blocked_waitq,
 				!fuse_block_alloc(fc, for_background),
 				(TASK_KILLABLE | TASK_FREEZABLE)))
 			goto out;
@@ -122,7 +122,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	smp_rmb();
 
 	err = -ENOTCONN;
-	if (!fc->connected)
+	if (!fc->chan->connected)
 		goto out;
 
 	err = -ECONNREFUSED;
@@ -133,7 +133,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	err = -ENOMEM;
 	if (!req) {
 		if (for_background)
-			wake_up(&fc->blocked_waitq);
+			wake_up(&fc->chan->blocked_waitq);
 		goto out;
 	}
 
@@ -181,8 +181,8 @@ static void fuse_put_request(struct fuse_req *req)
 			 * request was allocated but not sent
 			 */
 			spin_lock(&fc->chan->bg_lock);
-			if (!fc->blocked)
-				wake_up(&fc->blocked_waitq);
+			if (!fc->chan->blocked)
+				wake_up(&fc->chan->blocked_waitq);
 			spin_unlock(&fc->chan->bg_lock);
 		}
 
@@ -356,7 +356,12 @@ struct fuse_chan *fuse_chan_new(void)
 	INIT_LIST_HEAD(&fch->devices);
 	spin_lock_init(&fch->bg_lock);
 	INIT_LIST_HEAD(&fch->bg_queue);
+	init_waitqueue_head(&fch->blocked_waitq);
+	atomic_set(&fch->num_waiting, 0);
 	fch->max_background = FUSE_DEFAULT_MAX_BACKGROUND;
+	fch->initialized = 0;
+	fch->blocked = 0;
+	fch->connected = 1;
 
 	return fch;
 }
@@ -425,7 +430,7 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 		 *  - it was already set to a different fc
 		 *  - it was set to disconneted
 		 */
-		fc->connected = 0;
+		fc->chan->connected = 0;
 	} else {
 		list_add_tail(&fud->entry, &fc->chan->devices);
 		fuse_conn_get(fc);
@@ -536,17 +541,17 @@ void fuse_request_end(struct fuse_req *req)
 		spin_lock(&fc->chan->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
 		if (fc->chan->num_background == fc->chan->max_background) {
-			fc->blocked = 0;
-			wake_up(&fc->blocked_waitq);
-		} else if (!fc->blocked) {
+			fc->chan->blocked = 0;
+			wake_up(&fc->chan->blocked_waitq);
+		} else if (!fc->chan->blocked) {
 			/*
 			 * Wake up next waiter, if any.  It's okay to use
 			 * waitqueue_active(), as we've already synced up
-			 * fc->blocked with waiters with the wake_up() call
+			 * fc->chan->blocked with waiters with the wake_up() call
 			 * above.
 			 */
-			if (waitqueue_active(&fc->blocked_waitq))
-				wake_up(&fc->blocked_waitq);
+			if (waitqueue_active(&fc->chan->blocked_waitq))
+				wake_up(&fc->chan->blocked_waitq);
 		}
 
 		fc->chan->num_background--;
@@ -729,7 +734,7 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 	ssize_t ret;
 
 	if (args->force) {
-		atomic_inc(&fc->num_waiting);
+		atomic_inc(&fc->chan->num_waiting);
 		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
 
 		if (!args->nocreds)
@@ -789,7 +794,7 @@ static int fuse_request_queue_background(struct fuse_req *req)
 	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
 	if (!test_bit(FR_WAITING, &req->flags)) {
 		__set_bit(FR_WAITING, &req->flags);
-		atomic_inc(&fc->num_waiting);
+		atomic_inc(&fc->chan->num_waiting);
 	}
 	__set_bit(FR_ISREPLY, &req->flags);
 
@@ -799,10 +804,10 @@ static int fuse_request_queue_background(struct fuse_req *req)
 #endif
 
 	spin_lock(&fc->chan->bg_lock);
-	if (likely(fc->connected)) {
+	if (likely(fc->chan->connected)) {
 		fc->chan->num_background++;
 		if (fc->chan->num_background == fc->chan->max_background)
-			fc->blocked = 1;
+			fc->chan->blocked = 1;
 		list_add_tail(&req->list, &fc->chan->bg_queue);
 		flush_bg_queue(fc);
 		queued = true;
@@ -2051,7 +2056,7 @@ static void fuse_resend(struct fuse_conn *fc)
 	unsigned int i;
 
 	spin_lock(&fc->lock);
-	if (!fc->connected) {
+	if (!fc->chan->connected) {
 		spin_unlock(&fc->lock);
 		return;
 	}
@@ -2149,7 +2154,7 @@ static int fuse_notify(struct fuse_conn *fc, enum fuse_notify_code code,
 	 * Only allow notifications during while the connection is in an
 	 * initialized and connected state
 	 */
-	if (!fc->initialized || !fc->connected)
+	if (!fc->chan->initialized || !fc->chan->connected)
 		return -EINVAL;
 
 	/* Don't try to move folios (yet) */
@@ -2514,7 +2519,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 	struct fuse_iqueue *fiq = &fc->chan->iq;
 
 	spin_lock(&fc->lock);
-	if (fc->connected) {
+	if (fc->chan->connected) {
 		struct fuse_dev *fud;
 		struct fuse_req *req, *next;
 		LIST_HEAD(to_end);
@@ -2523,9 +2528,9 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		if (fc->timeout.req_timeout)
 			cancel_delayed_work(&fc->timeout.work);
 
-		/* Background queuing checks fc->connected under bg_lock */
+		/* Background queuing checks fc->chan->connected under bg_lock */
 		spin_lock(&fc->chan->bg_lock);
-		fc->connected = 0;
+		fc->chan->connected = 0;
 		spin_unlock(&fc->chan->bg_lock);
 
 		fuse_set_initialized(fc);
@@ -2551,7 +2556,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 			spin_unlock(&fpq->lock);
 		}
 		spin_lock(&fc->chan->bg_lock);
-		fc->blocked = 0;
+		fc->chan->blocked = 0;
 		fc->chan->max_background = UINT_MAX;
 		flush_bg_queue(fc);
 		spin_unlock(&fc->chan->bg_lock);
@@ -2567,7 +2572,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fiq->lock);
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 		end_polls(fc);
-		wake_up_all(&fc->blocked_waitq);
+		wake_up_all(&fc->chan->blocked_waitq);
 		spin_unlock(&fc->lock);
 
 		fuse_dev_end_requests(&to_end);
@@ -2587,7 +2592,7 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
-	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
+	wait_event(fc->chan->blocked_waitq, atomic_read(&fc->chan->num_waiting) == 0);
 
 	fuse_uring_wait_stopped_queues(fc);
 }
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 4a5e64a6fe8a..e350b1dc1722 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -898,7 +898,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 		return err;
 	fpq = &queue->fpq;
 
-	if (!READ_ONCE(fc->connected) || READ_ONCE(queue->stopped))
+	if (!READ_ONCE(fc->chan->connected) || READ_ONCE(queue->stopped))
 		return err;
 
 	spin_lock(&queue->lock);
@@ -997,7 +997,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 		if (ready) {
 			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
 			WRITE_ONCE(ring->ready, true);
-			wake_up_all(&fc->blocked_waitq);
+			wake_up_all(&fc->chan->blocked_waitq);
 		}
 	}
 }
@@ -1156,14 +1156,14 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 
 	if (fc->aborted)
 		return -ECONNABORTED;
-	if (!fc->connected)
+	if (!fc->chan->connected)
 		return -ENOTCONN;
 
 	/*
 	 * fuse_uring_register() needs the ring to be initialized,
 	 * we need to know the max payload size
 	 */
-	if (!fc->initialized)
+	if (!fc->chan->initialized)
 		return -EAGAIN;
 
 	switch (cmd_op) {
@@ -1173,7 +1173,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 			pr_info_once("FUSE_IO_URING_CMD_REGISTER failed err=%d\n",
 				     err);
 			fc->io_uring = 0;
-			wake_up_all(&fc->blocked_waitq);
+			wake_up_all(&fc->chan->blocked_waitq);
 			return err;
 		}
 		break;
@@ -1328,7 +1328,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	spin_lock(&fc->chan->bg_lock);
 	fc->chan->num_background++;
 	if (fc->chan->num_background == fc->chan->max_background)
-		fc->blocked = 1;
+		fc->chan->blocked = 1;
 	fuse_uring_flush_bg(queue);
 	spin_unlock(&fc->chan->bg_lock);
 
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index efc321b2bf5d..8afe18ddc891 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -109,6 +109,25 @@ struct fuse_chan {
 	/** Protects: max_background, congestion_threshold, num_background,
 	 * active_background, bg_queue, blocked */
 	spinlock_t bg_lock;
+
+	/** Flag indicating that INIT reply has been received. Allocating
+	 * any fuse request will be suspended until the flag is set */
+	int initialized;
+
+	/** Flag indicating if connection is blocked.  This will be
+	    the case before the INIT reply is received, and if there
+	    are too many outstading backgrounds requests */
+	int blocked;
+
+	/** waitq for blocked connection */
+	wait_queue_head_t blocked_waitq;
+
+	/** Connection established, cleared on umount, connection
+	    abort and device release */
+	unsigned connected;
+
+	/** The number of requests waiting for completion */
+	atomic_t num_waiting;
 };
 
 #define FUSE_PQ_HASH_BITS 8
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index ccf0db3a4eeb..a56e49c7a324 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -569,22 +569,6 @@ struct fuse_conn {
 	/** Number of background requests at which congestion starts */
 	unsigned congestion_threshold;
 
-	/** Flag indicating that INIT reply has been received. Allocating
-	 * any fuse request will be suspended until the flag is set */
-	int initialized;
-
-	/** Flag indicating if connection is blocked.  This will be
-	    the case before the INIT reply is received, and if there
-	    are too many outstading backgrounds requests */
-	int blocked;
-
-	/** waitq for blocked connection */
-	wait_queue_head_t blocked_waitq;
-
-	/** Connection established, cleared on umount, connection
-	    abort and device release */
-	unsigned connected;
-
 	/** Connection aborted via sysfs */
 	bool aborted;
 
@@ -786,9 +770,6 @@ struct fuse_conn {
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
-	/** The number of requests waiting for completion */
-	atomic_t num_waiting;
-
 	/** Negotiated minor version */
 	unsigned minor;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 16b9879c924b..85ac0e2244bc 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -975,15 +975,10 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	refcount_set(&fc->count, 1);
 	atomic_set(&fc->epoch, 1);
 	INIT_WORK(&fc->epoch_work, fuse_epoch_work);
-	init_waitqueue_head(&fc->blocked_waitq);
 	INIT_LIST_HEAD(&fc->entry);
-	atomic_set(&fc->num_waiting, 0);
 	fc->congestion_threshold = FUSE_DEFAULT_CONGESTION_THRESHOLD;
 	atomic64_set(&fc->khctr, 0);
 	fc->polled_files = RB_ROOT;
-	fc->blocked = 0;
-	fc->initialized = 0;
-	fc->connected = 1;
 	atomic64_set(&fc->attr_version, 1);
 	atomic64_set(&fc->evict_ctr, 1);
 	get_random_bytes(&fc->scramble_key, sizeof(fc->scramble_key));
@@ -1444,7 +1439,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 	}
 
 	fuse_set_initialized(fc);
-	wake_up_all(&fc->blocked_waitq);
+	wake_up_all(&fc->chan->blocked_waitq);
 }
 
 static struct fuse_init_args *fuse_new_init(struct fuse_mount *fm)
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index ee2b4dc394e0..ef2e39e4dcf4 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -74,7 +74,7 @@ static void fuse_check_timeout(struct work_struct *work)
 	struct fuse_pqueue *fpq;
 	bool expired = false;
 
-	if (!atomic_read(&fc->num_waiting))
+	if (!atomic_read(&fc->chan->num_waiting))
 		goto out;
 
 	spin_lock(&fiq->lock);
@@ -90,7 +90,7 @@ static void fuse_check_timeout(struct work_struct *work)
 		goto abort_conn;
 
 	spin_lock(&fc->lock);
-	if (!fc->connected) {
+	if (!fc->chan->connected) {
 		spin_unlock(&fc->lock);
 		return;
 	}
-- 
2.53.0

