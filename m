Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCB339A054
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331073; cv=none; b=QI9CDlW1KTXpTFMXCL86A/EI1JXWAgIuGxkbF0fgFOhfXc1J7bI+FRmvYrUUEHFqLesop4zDlnf0qLybbnaoRCppt3Xg+9l24hY9p58bfpx/9gnzf0W9cpwHLQA7Dom+XsRwfVwkI/Cb2tIiNbtLQt1lxsXqDZgmcxqfmownqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331073; c=relaxed/simple;
	bh=Gi3+d+Fi9cO/mFeXeEY77zKHcoqaGBusUXNF/IBFtMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cggPbOGdyYFj6ZO779SAr8ORtlUqrXRtss6tk0JOAM8bmfbS0aqbCBs7MUFecl6KyxNchXynso2eppWS4kNsZdSzFeC6Y065INABj9xBEyBT7p5e9dGV11EiGucGznNnVC2UTF1wFCr6Ser22ynE7R+U3wBXR3lN2oOsTSXQ4ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqwNH7TU; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQvdTRBZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqwNH7TU";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQvdTRBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rr2lB9mjk2I1CanusyLJPfIhz/LPmkHr/AEi1I8eAJ8=;
	b=JqwNH7TUPbOE3ErihfC9+oX/jbOiF7jPGquzeo30NnJNg9oD/1TikqC9v80EVjXGSWABm9
	izHjOBv/Uo9WE+29cMFecM0WhFF4PoMYXZ0k6JE6cOhdYbmaB7gtUxFtuBnop3y3EYMIFB
	ERKCAOcrEwrWcN01Sm9twMSn7jK7gtY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-_tO3Y8QePuCPsikD5vvMcQ-1; Thu, 16 Apr 2026 05:17:43 -0400
X-MC-Unique: _tO3Y8QePuCPsikD5vvMcQ-1
X-Mimecast-MFC-AGG-ID: _tO3Y8QePuCPsikD5vvMcQ_1776331062
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488ba2919b9so51734615e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331062; x=1776935862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rr2lB9mjk2I1CanusyLJPfIhz/LPmkHr/AEi1I8eAJ8=;
        b=WQvdTRBZIYvGAFJk0iEljsgBi3F8w3cReEpEyLts8RByaMG1apBiIr/iF8oAipVS6j
         CJ9aC0Fajj1VjyOHi2VyAtUs1jjgrd/+Fh3qfHRNmzULJJPh/KpLWIylVIXeqOYZpZqI
         6SYjz/6na5S85XK2aUrHgiQkJXXLeWzWvfpP+JSNGdj3YwyK2ceSC5M3D4GC2XiuCDGG
         t9yEtza4WkBl/Iy+Gx15i1WK/3J8qkHXcmail5r/YldA8iHICUB/9ONFyy+UMN6QFmFr
         w3R1Ii6TmBTVu6CfdRprIIDvxfwtNs12JveOMDfZDZeKxe3Dzm/N629KL3QmYlKG+qK/
         0pxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331062; x=1776935862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Rr2lB9mjk2I1CanusyLJPfIhz/LPmkHr/AEi1I8eAJ8=;
        b=i3NkfAi5VkSIHmg0xr7EgbRlHk2VWCEElC6TbTQFLGctjFwJwN6GuwnItMN9xLNqhZ
         B1auUHpESfh7crFn2YVrikjQTYXAJ0fRIaffIZ5+9D4qEAUx8WjgIAYLQPTb6R0ESgB7
         l4tUuZIveG4LgiIhbpUMF9oyYJE5BxE5MKvg/HUgq5TQzP+0j7dOYCU3C5BpKfmClrxh
         06ngbmazIutFRVl4phJ5tsydrnG4orYID3lP+IuD0mqhKaftCLPZj0c0uzYi2hyNx1FF
         anCDshjWTh2hb/YgLDpmEuFnKA5IErUfwLxfvgrm9jPDb11HLXHsA3bBf9kAdAbVrbQ6
         IBIA==
X-Forwarded-Encrypted: i=1; AFNElJ8zVfoxiwq2QIzLWpO4MJ3l0+UI4qfNIviI4sG8O6IAwPJDOd4zdM3A8cCE+osmuKLdYjrhKELc5kdBnuH5@vger.kernel.org
X-Gm-Message-State: AOJu0YxLJg01IIefUcqqU8fa3XYASmuzkzZIrTBltj7Mh5Qn6VGO5Bv+
	eHkX7gUF4G7J4/ykvppjK3JqUb8EvD1Njh2+TPnqwJ8daiqybSJSYMw331+jqZ4EmQ+fVw7dorZ
	4hNf+XY9SYXOpWANoiPxd3wlSi+Ktip70+vGybX0VY9N2cU/aS903Rk+TfFzz6zpYWfHqlp0lcT
	E=
X-Gm-Gg: AeBDiestNKPA3zAOCk6X/73+JrCA+X0gCKnGGIYYEplUtGjq8FHfoyEC0c2tsnz1v9F
	jTzq9bui5UZ4XXaxnBx02dOzAwnuWA3++MCPsO8PpcZ6m8PnRI7RJ/61pHDzBf3ZBEdq0M+SYVc
	5v3etyAsZx/bWMMvNYd0F4Nm+Y1VQjI3azsyOHfxj3W2+06+X2yfooFr1FiS6l5AI8ytIbWPyFy
	qdu5ahWdgRNRH38rlzuXrEyPgdx5jjsYcrhRCzArFB5SDl/2YQWt7RbofbpSyQXF4nAf2wtP24W
	k8vrCA7HDfkxZW+uaW3YiuO6Kb9fCIw3EEzCoV/xUsnWzM36Ij41KFYvEKwLxFKMVYtgTP29MTM
	SZjT3gBJ41KmoTPVWKVke5UzHbTK6Wlz8MF6SdswxNOoynyyhBm5m6l+M0FeHK+5z9D0YALueP1
	QTRWeVOQ==
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488d67bf744mr249661365e9.4.1776331061682;
        Thu, 16 Apr 2026 02:17:41 -0700 (PDT)
X-Received: by 2002:a05:600c:c088:b0:486:fa35:aef2 with SMTP id 5b1f17b1804b1-488d67bf744mr249661005e9.4.1776331061039;
        Thu, 16 Apr 2026 02:17:41 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:40 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 29/32] fuse: change ring->fc to ring->chan
Date: Thu, 16 Apr 2026 11:16:53 +0200
Message-ID: <20260416091658.462783-30-mszeredi@redhat.com>
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

Store pointer to struct fuse_chan instead of struct fuse_conn in fuse_ring.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev_uring.c   | 44 +++++++++++++++++++++----------------------
 fs/fuse/dev_uring_i.h |  2 +-
 2 files changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f6bed983fea0..64883cf94ab4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -52,10 +52,10 @@ static struct fuse_ring_ent *uring_cmd_to_ring_ent(struct io_uring_cmd *cmd)
 static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 {
 	struct fuse_ring *ring = queue->ring;
-	struct fuse_conn *fc = ring->fc;
+	struct fuse_chan *fch = ring->chan;
 
 	lockdep_assert_held(&queue->lock);
-	lockdep_assert_held(&fc->chan->bg_lock);
+	lockdep_assert_held(&fch->bg_lock);
 
 	/*
 	 * Allow one bg request per queue, ignoring global fc limits.
@@ -63,14 +63,14 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
 	 * eliminates the need for remote queue wake-ups when global
 	 * limits are met but this queue has no more waiting requests.
 	 */
-	while ((fc->chan->active_background < fc->chan->max_background ||
+	while ((fch->active_background < fch->max_background ||
 		!queue->active_background) &&
 	       (!list_empty(&queue->fuse_req_bg_queue))) {
 		struct fuse_req *req;
 
 		req = list_first_entry(&queue->fuse_req_bg_queue,
 				       struct fuse_req, list);
-		fc->chan->active_background++;
+		fch->active_background++;
 		queue->active_background++;
 
 		list_move_tail(&req->list, &queue->fuse_req_queue);
@@ -82,7 +82,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
-	struct fuse_conn *fc = ring->fc;
+	struct fuse_chan *fch = ring->chan;
 
 	lockdep_assert_not_held(&queue->lock);
 	spin_lock(&queue->lock);
@@ -90,9 +90,9 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	list_del_init(&req->list);
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
-		spin_lock(&fc->chan->bg_lock);
+		spin_lock(&fch->bg_lock);
 		fuse_uring_flush_bg(queue);
-		spin_unlock(&fc->chan->bg_lock);
+		spin_unlock(&fch->bg_lock);
 	}
 
 	spin_unlock(&queue->lock);
@@ -124,7 +124,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 {
 	int qid;
 	struct fuse_ring_queue *queue;
-	struct fuse_conn *fc = ring->fc;
+	struct fuse_chan *fch = ring->chan;
 
 	for (qid = 0; qid < ring->nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
@@ -133,11 +133,11 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 
 		queue->stopped = true;
 
-		WARN_ON_ONCE(ring->fc->chan->max_background != UINT_MAX);
+		WARN_ON_ONCE(fch->max_background != UINT_MAX);
 		spin_lock(&queue->lock);
-		spin_lock(&fc->chan->bg_lock);
+		spin_lock(&fch->bg_lock);
 		fuse_uring_flush_bg(queue);
-		spin_unlock(&fc->chan->bg_lock);
+		spin_unlock(&fch->bg_lock);
 		spin_unlock(&queue->lock);
 		fuse_uring_abort_end_queue_requests(queue);
 	}
@@ -255,7 +255,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 	init_waitqueue_head(&ring->stop_waitq);
 
 	ring->nr_queues = nr_queues;
-	ring->fc = fch->conn;
+	ring->chan = fch;
 	ring->max_payload_sz = max_payload_size;
 	smp_store_release(&fch->ring, ring);
 
@@ -271,7 +271,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_chan *fch)
 static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 						       int qid)
 {
-	struct fuse_conn *fc = ring->fc;
+	struct fuse_chan *fch = ring->chan;
 	struct fuse_ring_queue *queue;
 	struct list_head *pq;
 
@@ -299,9 +299,9 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	queue->fpq.processing = pq;
 	fuse_pqueue_init(&queue->fpq);
 
-	spin_lock(&fc->chan->lock);
+	spin_lock(&fch->lock);
 	if (ring->queues[qid]) {
-		spin_unlock(&fc->chan->lock);
+		spin_unlock(&fch->lock);
 		kfree(queue->fpq.processing);
 		kfree(queue);
 		return ring->queues[qid];
@@ -311,7 +311,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	 * write_once and lock as the caller mostly doesn't take the lock at all
 	 */
 	WRITE_ONCE(ring->queues[qid], queue);
-	spin_unlock(&fc->chan->lock);
+	spin_unlock(&fch->lock);
 
 	return queue;
 }
@@ -532,8 +532,7 @@ static void fuse_uring_prepare_cancel(struct io_uring_cmd *cmd, int issue_flags,
  * Checks for errors and stores it into the request
  */
 static int fuse_uring_out_header_has_err(struct fuse_out_header *oh,
-					 struct fuse_req *req,
-					 struct fuse_conn *fc)
+					 struct fuse_req *req)
 {
 	int err;
 
@@ -813,7 +812,6 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 			      unsigned int issue_flags)
 {
 	struct fuse_ring *ring = ent->queue->ring;
-	struct fuse_conn *fc = ring->fc;
 	ssize_t err = 0;
 
 	err = copy_from_user(&req->out.h, &ent->headers->in_out,
@@ -823,7 +821,7 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 		goto out;
 	}
 
-	err = fuse_uring_out_header_has_err(&req->out.h, req, fc);
+	err = fuse_uring_out_header_has_err(&req->out.h, req);
 	if (err) {
 		/* req->out.h.error already set */
 		goto out;
@@ -982,8 +980,8 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 {
 	struct fuse_ring_queue *queue = ent->queue;
 	struct fuse_ring *ring = queue->ring;
-	struct fuse_conn *fc = ring->fc;
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_chan *fch = ring->chan;
+	struct fuse_iqueue *fiq = &fch->iq;
 
 	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
 
@@ -998,7 +996,7 @@ static void fuse_uring_do_register(struct fuse_ring_ent *ent,
 		if (ready) {
 			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
 			WRITE_ONCE(ring->ready, true);
-			wake_up_all(&fc->chan->blocked_waitq);
+			wake_up_all(&fch->blocked_waitq);
 		}
 	}
 }
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 741fdead2161..b8b5a958c4f9 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -107,7 +107,7 @@ struct fuse_ring_queue {
  */
 struct fuse_ring {
 	/* back pointer */
-	struct fuse_conn *fc;
+	struct fuse_chan *chan;
 
 	/* number of ring queues */
 	size_t nr_queues;
-- 
2.53.0

