Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB539B963
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331054; cv=none; b=dQlS42Y2aMcXSoQG++C0gOoe9bOld8gNx6ggOtzWxvmU5mLyFZ7vSUlkB57Trm4HScQTjc2LgtDJWjPmLbkXdYMrqpPd0bNa74ZkbPg5F9K65YAutKtpbsyfTzvBrzgmNtRAOdRdJdPlAwDO3DGHDewdDZC3pnb040TEkLz3MSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331054; c=relaxed/simple;
	bh=6YINIZYZ766Tkz25/abZGfGK2YbVNTaar/g0XnMoulw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r4kphoXAhI0+tnZCFQQUYXIfjC+Ib+cLklmx/ptYSsX46j1RsXKnwE2FAkrQ7r/JqZfF87/RWFJVosoeonxGOaz8CVeeldYu8eg8TUyO3+/iTpirn1oYOkiG72exMA9AsFtND425Jtksoj8Ja8/QiPj2Ttp4grfbofAwjp27Pkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jOykL+5X; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tV1Mck+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jOykL+5X";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tV1Mck+3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UqNwrKbv1CBFR0H8qiJy6ZZmfZue/paSTki31+psO5M=;
	b=jOykL+5XSwPZHTC1dGHQhENEZGEaEihZlkKi5yiUg4U3z3W+BH86e2VXUPaiRdzJ11KQ2y
	jJv0c9uyT6FMwgYMrNLh3MvB01vGRYBDXNakP15AqlgxGSKK6RrlCid7QyKVr7ZQ5dJJUb
	IXVTQgepn9wX5lxA/YK8yy0iu9NxfGk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-NSDwm3xVMrqf7aCFlnYSmw-1; Thu, 16 Apr 2026 05:17:15 -0400
X-MC-Unique: NSDwm3xVMrqf7aCFlnYSmw-1
X-Mimecast-MFC-AGG-ID: NSDwm3xVMrqf7aCFlnYSmw_1776331034
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-48378df3469so3268725e9.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331034; x=1776935834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UqNwrKbv1CBFR0H8qiJy6ZZmfZue/paSTki31+psO5M=;
        b=tV1Mck+3PZTSRNopKmZwQvGwmLogsMCv5rsE9x/OizpjlKCedHLwScGQ/cdpHwdLNb
         M6+eC2D1ASHDDZimUl8q0L+289JnUcKlvnLfDjSJzKrbzJXi73SQpPXoBUlPWUtZe2ID
         2DRNFYXlTWCc9DkB11eHA7Drp8f/BAqkSRQ11u6GhEH+1PoHdFaKeBLDxFnmQrfFM/S1
         ueiP3hmayHYL6MvOoXJqXwCVJ/lJqkv/stpqLUX5XxKzi/FLGfZY7c3v9Hj6wn6iOdGW
         InWVFZv6YsF9bHGQN5Ejn4Kbzuo51J7BUWbjMZzYtYQ4+kQz5AcpujxHmpB8nywi/lqq
         dbqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331034; x=1776935834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UqNwrKbv1CBFR0H8qiJy6ZZmfZue/paSTki31+psO5M=;
        b=kCgGkDf5gFg60V2yhPgQbledd53q3S9cQiAs6md9EJatrbP+sQ9K96/G8M7cvfNjqg
         i7eqUJPAveTo7yOGX2bZE5+xEwzYRVt1aV/v48U/1TB6yTnkZsvjoxxF+MPty2WM78c3
         uEtOHUVb9q7cpigxwKgyyAcNSJlfO1iVErXTS71mzWYLWqZkeaD6Jpx89hDb5O5B+re1
         t16aD9RVl9qB9fMPD1EanuWlS4et3Np3mBMGjbF1PvPvjhXaTc1wH1YIivEIcBmJThMs
         FDUj1kmvd5HUim5YzV2Qyr57FEpRflw/g222CN3W+KnwGOJzfUjx1fxqWHXV1aNslDB1
         h55w==
X-Forwarded-Encrypted: i=1; AFNElJ+tlv32ZkpDc7SPh4NouJ7t++i7pXNJbBLthosT87iaFwgKlsq+Hafyqs6kjEPJfKLvyzbBwNFNo8tdbYQd@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4QaswUH1v6v9l1oO9FTmjD68fvWreO5USFS5cPPw2wsRedopW
	AGqV+7Fuk+GdvxYtrSLnP1gbXQwLKC2tsNIDl2dA139qAL8XNVgmBxYpugZl+MDF/jNUbe0ZOzF
	/3hpitVGeiPQzg6+e/mM1oOr4D+TBlafvHb7OVBBUESNzAxBCrDs/YO2Y/smblD+qw4hTWB5FMz
	4=
X-Gm-Gg: AeBDiet2CU7tQsg+XHSIX1KjjZFhrBXJGa2YcS1kFPiIMcqsJjUnl0MEY7TQtCaGYNC
	lmfx3yKBbsH8pF7mMTvp58sePcTrJQa4yoSOAIYwOF+mbhQAOXR5dFTnqoAVUI6jvpMXR+wakNH
	LShoTOXleO4FaGu9gjQBFFjqdEaD5iGIhba3T76Wrr7aguh93r7UsLqH/u+EGhfv4/SIgzXAcF5
	SJfrnaxya/aeAGxavs56NVwAcueYKbz1nkSy2NhA5/P8VY2ol/lbDP4ngiLiROg82Q0PDAV+2UN
	8hnUrWScMiC3FQ/2jqVgk6FHVH5L+zAL7hcCLDai7Ta0xcolEk4aK/dDUC3wMVrEW91sIUOsmuU
	2bHZu6EOb6pb+I+XNOTT6Jlx22yEv8II84pSrTvubUZTed4J0p3QYogp0/dEkTWsWoFWzWPYBeG
	lgKDtw7g==
X-Received: by 2002:a05:600c:a303:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488f480976emr24864435e9.10.1776331033735;
        Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a303:b0:486:f893:56c6 with SMTP id 5b1f17b1804b1-488f480976emr24864205e9.10.1776331033231;
        Thu, 16 Apr 2026 02:17:13 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:12 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 08/32] fuse: move io_uring related members to fuse_chan
Date: Thu, 16 Apr 2026 11:16:32 +0200
Message-ID: <20260416091658.462783-9-mszeredi@redhat.com>
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

 - io_uring
 - ring

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c         |  2 +-
 fs/fuse/dev_uring.c   | 26 +++++++++++++-------------
 fs/fuse/dev_uring_i.h |  6 +++---
 fs/fuse/fuse_dev_i.h  |  8 ++++++++
 fs/fuse/fuse_i.h      |  8 --------
 fs/fuse/inode.c       |  2 +-
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9885347df331..4d21e22301ed 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -79,7 +79,7 @@ void fuse_set_initialized(struct fuse_conn *fc)
 static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 {
 	return !fc->chan->initialized || (for_background && fc->chan->blocked) ||
-	       (fc->io_uring && fc->chan->connected && !fuse_uring_ready(fc));
+	       (fc->chan->io_uring && fc->chan->connected && !fuse_uring_ready(fc));
 }
 
 static void fuse_drop_waiting(struct fuse_conn *fc)
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e350b1dc1722..1a7a364c8131 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -159,7 +159,7 @@ static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *lis
 
 bool fuse_uring_request_expired(struct fuse_conn *fc)
 {
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 	struct fuse_ring_queue *queue;
 	int qid;
 
@@ -187,7 +187,7 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 
 void fuse_uring_destruct(struct fuse_conn *fc)
 {
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 	int qid;
 
 	if (!ring)
@@ -218,7 +218,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 
 	kfree(ring->queues);
 	kfree(ring);
-	fc->ring = NULL;
+	fc->chan->ring = NULL;
 }
 
 /*
@@ -231,7 +231,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	struct fuse_ring *res = NULL;
 	size_t max_payload_size;
 
-	ring = kzalloc_obj(*fc->ring, GFP_KERNEL_ACCOUNT);
+	ring = kzalloc_obj(*fc->chan->ring, GFP_KERNEL_ACCOUNT);
 	if (!ring)
 		return NULL;
 
@@ -244,10 +244,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
 
 	spin_lock(&fc->lock);
-	if (fc->ring) {
+	if (fc->chan->ring) {
 		/* race, another thread created the ring in the meantime */
 		spin_unlock(&fc->lock);
-		res = fc->ring;
+		res = fc->chan->ring;
 		goto out_err;
 	}
 
@@ -256,7 +256,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	ring->nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
-	smp_store_release(&fc->ring, ring);
+	smp_store_release(&fc->chan->ring, ring);
 
 	spin_unlock(&fc->lock);
 	return ring;
@@ -879,7 +879,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 								       struct fuse_uring_cmd_req);
 	struct fuse_ring_ent *ent;
 	int err;
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 	struct fuse_ring_queue *queue;
 	uint64_t commit_id = READ_ONCE(cmd_req->commit_id);
 	unsigned int qid = READ_ONCE(cmd_req->qid);
@@ -1082,7 +1082,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 {
 	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe128_cmd(cmd->sqe,
 								       struct fuse_uring_cmd_req);
-	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
+	struct fuse_ring *ring = smp_load_acquire(&fc->chan->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
 	int err;
@@ -1149,7 +1149,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	fc = fud->fc;
 
 	/* Once a connection has io-uring enabled on it, it can't be disabled */
-	if (!enable_uring && !fc->io_uring) {
+	if (!enable_uring && !fc->chan->io_uring) {
 		pr_info_ratelimited("fuse-io-uring is disabled\n");
 		return -EOPNOTSUPP;
 	}
@@ -1172,7 +1172,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 		if (err) {
 			pr_info_once("FUSE_IO_URING_CMD_REGISTER failed err=%d\n",
 				     err);
-			fc->io_uring = 0;
+			fc->chan->io_uring = 0;
 			wake_up_all(&fc->chan->blocked_waitq);
 			return err;
 		}
@@ -1262,7 +1262,7 @@ static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 	int err;
@@ -1305,7 +1305,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 bool fuse_uring_queue_bq_req(struct fuse_req *req)
 {
 	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 9edb8295fdb2..5b981708d04a 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -148,7 +148,7 @@ bool fuse_uring_request_expired(struct fuse_conn *fc);
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 
 	if (ring == NULL)
 		return;
@@ -161,7 +161,7 @@ static inline void fuse_uring_abort(struct fuse_conn *fc)
 
 static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 {
-	struct fuse_ring *ring = fc->ring;
+	struct fuse_ring *ring = fc->chan->ring;
 
 	if (ring)
 		wait_event(ring->stop_waitq,
@@ -170,7 +170,7 @@ static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 
 static inline bool fuse_uring_ready(struct fuse_conn *fc)
 {
-	return fc->ring && fc->ring->ready;
+	return fc->chan->ring && fc->chan->ring->ready;
 }
 
 #else /* CONFIG_FUSE_IO_URING */
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 8afe18ddc891..ff1c62297e01 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -128,6 +128,14 @@ struct fuse_chan {
 
 	/** The number of requests waiting for completion */
 	atomic_t num_waiting;
+
+	/* Use io_uring for communication */
+	unsigned int io_uring;
+
+#ifdef CONFIG_FUSE_IO_URING
+	/**  uring connection information*/
+	struct fuse_ring *ring;
+#endif
 };
 
 #define FUSE_PQ_HASH_BITS 8
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index a56e49c7a324..701bb18dcb00 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -764,9 +764,6 @@ struct fuse_conn {
 	/* Is synchronous FUSE_INIT allowed? */
 	unsigned int sync_init:1;
 
-	/* Use io_uring for communication */
-	unsigned int io_uring;
-
 	/** Maximum stack depth for passthrough backing files */
 	int max_stack_depth;
 
@@ -819,11 +816,6 @@ struct fuse_conn {
 	struct idr backing_files_map;
 #endif
 
-#ifdef CONFIG_FUSE_IO_URING
-	/**  uring connection information*/
-	struct fuse_ring *ring;
-#endif
-
 	/** Only used if the connection opts into request timeouts */
 	struct {
 		/* Worker for checking if any requests have timed out */
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 85ac0e2244bc..c7f7e0ff12f7 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1412,7 +1412,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 					ok = false;
 			}
 			if (flags & FUSE_OVER_IO_URING && fuse_uring_enabled())
-				fc->io_uring = 1;
+				fc->chan->io_uring = 1;
 
 			if (flags & FUSE_REQUEST_TIMEOUT)
 				timeout = arg->request_timeout;
-- 
2.53.0

