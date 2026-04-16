Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5939B4A9
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331044; cv=none; b=i9YnVc1Mg+o2KWCI2TToun9RRyZPMwBv+rPutj1XKBOI7WXaynAP9F5F7rLv+plFiKzhG169UTHOsbyYEojkx1LoKW+cQwjYFIZ0Tka7GvwJ/unSydYNrhCwD6hHV6AziSs5TSsL9Xh4aNQmischXaHzGyd//1KjSXPzIgLs76M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331044; c=relaxed/simple;
	bh=cuW4RAM7h5/qPuDbxPiV7iOPZiO8235c1yG7ZJFThkI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bvYO24n04wGvAQFeayI89uAtJcq3u0k4quIjzeE+AkdfZK5hIso5URaf2uG7hcrMYytUC2281kNcu3WPRyGerri8ze+UpVox6alYFW7MKLupYS2Q6z+1XbfhhXGVCNVmI96aF+u8Y7IDMJ1GHE23lCf/ZxBvaxjfA1pBh3iSeqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GA2Juyfj; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TJsAW8ep; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GA2Juyfj";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TJsAW8ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mqg0UPrGn0jGPYkWOZ8y2ITdrMXe8Sb0M3HSxVKPWB8=;
	b=GA2Juyfjk1aCp9AH9QJRxW5SOL4gnSRAl+C7OmZA/vM3yTEmqQZcMRr/frvAdBybLNRhhC
	jB+cL7PsAbd1oJ3ubTFR6yuUoHVYS3jEaAGjpnnhQ+FIjWO7hen63Hfx17Zok8IJpRoiJ+
	WLJ9rnq0yUQR0eggfYCPMVRo7Vwu/3o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-dUl9c5saMQKJxiI2YRjgpQ-1; Thu, 16 Apr 2026 05:17:18 -0400
X-MC-Unique: dUl9c5saMQKJxiI2YRjgpQ-1
X-Mimecast-MFC-AGG-ID: dUl9c5saMQKJxiI2YRjgpQ_1776331037
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-488e1757205so29452675e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331037; x=1776935837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mqg0UPrGn0jGPYkWOZ8y2ITdrMXe8Sb0M3HSxVKPWB8=;
        b=TJsAW8ephV+TIlDJorte3ZkWRe0muNrePcSlRuj/O7e90B4VePtfXwIGXMUAwMcBx9
         0PXu4jt7ESFnTCq1SN+Tf/qaUEqmvPmKxRnKvjb7D836bkBCfP+2BmlF3khQo34//DEn
         vLcws5vEIx//be6g/dE9+lV6X348xFBnOX/uwaw8wnnuwqSm5r7yD28igNVkTA8dAzRU
         6V+oSRCRUxsMtTQ+ZOFYa585GYULBNf5r7/5whBF5ZRTfseCHIu0E58aS0UE4Rs08+VT
         k9l69ZZYUbOYvyoMwlGVvMdoRgB/M7/HnBYPnLGX5rjongSlszlp6MkNnYjt1iclMyLj
         57qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331037; x=1776935837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Mqg0UPrGn0jGPYkWOZ8y2ITdrMXe8Sb0M3HSxVKPWB8=;
        b=njwt11CDuotrLywKlBeJEiHpd2vjBlXSZCrjhv8Qv54ciSuzWyJvFmRPwpOYmE8Qx3
         fUwHYXVNf5QwFUFYD8pV066PJMPJpD4TQYBd8t5Knui9aEFnlpAvtWqBlqdcOxJO2oJK
         gR+XWXiXpQ02HjbfhgR/WwnXYBCGLnqk2OT6JH+gCwy864kcGnly54kEDv9vURCFIYkf
         fyOj3gb0pwvy9KbENObwk7HYgxspfDjnIte769QkgTx4QwN5qoc+9b9754xSxkhfSo7T
         WP8/VF0iJtMLWISyi+iuKKDaKtKTVSmThT/rcFCuodfabOSPzQINnkMm88WA0jrDD6xC
         zqNA==
X-Forwarded-Encrypted: i=1; AFNElJ8Og1kQjjaQzixyZqk8lCdVT/Bi5GqPfa4qVCs9A8fE3AfCYAe2nAER4Ey87Tek1gIXaZafF4TqiUNg00CY@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2iaDhRJJmSS5hN4lTggk6jhJVWjl+TPen70heAkIeZGmpQdN3
	0O97DNZkbrYqxntMdn6dX+FkXr3A29f0/bF253AvLaljL3Nl/ZRgW7sBygoqZMRQBeyd5NA91j9
	57HhZ7DwO6jzuMnSuLGoDPRmbK/XjNkhHYUifC7qy7JqNop+3vThb8tz4m1bOpIlYtP5+DnQyrn
	4=
X-Gm-Gg: AeBDiessxA/+xmnRpWoZqufcwG2MMui02No14w3BNKUyPlRCUjNhhAdcrb0HCVyhyaE
	LPVvc0BlNEkqQnnN8HJunRfkm9c5dFXtQmbLK0QoLGIAnZatj7TXS6fmf+dl/lLFGeQPKn7Hr4H
	KltH2kVLGicEPBGTcX8L1rC0byPh3hYsoZ03n2rPVJh7q3unTd/w52ExI43uhrY59NqztHsnH3P
	J54njP/VH96hlVivgb8AfYsO9czn2cGzta5iLBQpf/BVf6L9XeWAR51O58Ft9h+Oyx8m3KmKlym
	qlBTPgNmahYnKfTkZVKb40QWwnDF/m3CUL01EYBYglwR1ITr38NgDiI94xP0ZMbIpQuqbVVSlhV
	tpZi7t/hGu7P2Mx1+UHPqfsn4gN1iWuxvgpu9B1UiRuHQbYWKnzlCNiIDAApGKr5zdiyDl6ZXU6
	xHXQHdEw==
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488d67b8de8mr258718035e9.4.1776331036806;
        Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
X-Received: by 2002:a05:600c:c0c8:b0:488:af14:f1de with SMTP id 5b1f17b1804b1-488d67b8de8mr258717605e9.4.1776331036241;
        Thu, 16 Apr 2026 02:17:16 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:15 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 10/32] fuse: split off fch->lock from fc->lock
Date: Thu, 16 Apr 2026 11:16:34 +0200
Message-ID: <20260416091658.462783-11-mszeredi@redhat.com>
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

And document which members they protect.

end_polls() is called with both, outer fch->lock is probably unnecessary,
but doesn't hurt for now.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c         | 29 ++++++++++++++++-------------
 fs/fuse/dev_uring.c   | 12 ++++++------
 fs/fuse/fuse_dev_i.h  |  8 ++++++++
 fs/fuse/fuse_i.h      |  8 ++++++--
 fs/fuse/req_timeout.c |  8 ++++----
 5 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 34ef117daa3f..9af71016591d 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -353,6 +353,7 @@ struct fuse_chan *fuse_chan_new(void)
 	if (!fch)
 		return NULL;
 
+	spin_lock_init(&fch->lock);
 	INIT_LIST_HEAD(&fch->devices);
 	spin_lock_init(&fch->bg_lock);
 	INIT_LIST_HEAD(&fch->bg_queue);
@@ -417,7 +418,7 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 {
 	struct fuse_conn *old_fc;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	/*
 	 * Pairs with:
 	 *  - xchg() in fuse_dev_release()
@@ -435,7 +436,7 @@ void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc)
 		list_add_tail(&fud->entry, &fc->chan->devices);
 		fuse_conn_get(fc);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fc->chan->lock);
 }
 EXPORT_SYMBOL_GPL(fuse_dev_install);
 
@@ -462,9 +463,9 @@ void fuse_dev_put(struct fuse_dev *fud)
 	fc = fuse_dev_fc_get(fud);
 	if (fc && fc != FUSE_DEV_FC_DISCONNECTED) {
 		/* This is the virtiofs case (fuse_dev_release() not called) */
-		spin_lock(&fc->lock);
+		spin_lock(&fc->chan->lock);
 		list_del(&fud->entry);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 
 		fuse_conn_put(fc);
 	}
@@ -2055,9 +2056,9 @@ static void fuse_resend(struct fuse_conn *fc)
 	LIST_HEAD(to_queue);
 	unsigned int i;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	if (!fc->chan->connected) {
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 		return;
 	}
 
@@ -2069,7 +2070,7 @@ static void fuse_resend(struct fuse_conn *fc)
 			list_splice_tail_init(&fpq->processing[i], &to_queue);
 		spin_unlock(&fpq->lock);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fc->chan->lock);
 
 	list_for_each_entry_safe(req, next, &to_queue, list) {
 		set_bit(FR_PENDING, &req->flags);
@@ -2485,6 +2486,7 @@ static void end_polls(struct fuse_conn *fc)
 {
 	struct rb_node *p;
 
+	spin_lock(&fc->lock);
 	p = rb_first(&fc->polled_files);
 
 	while (p) {
@@ -2494,6 +2496,7 @@ static void end_polls(struct fuse_conn *fc)
 
 		p = rb_next(p);
 	}
+	spin_unlock(&fc->lock);
 }
 
 /*
@@ -2518,7 +2521,7 @@ void fuse_abort_conn(struct fuse_conn *fc)
 {
 	struct fuse_iqueue *fiq = &fc->chan->iq;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	if (fc->chan->connected) {
 		struct fuse_dev *fud;
 		struct fuse_req *req, *next;
@@ -2573,17 +2576,17 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		kill_fasync(&fiq->fasync, SIGIO, POLL_IN);
 		end_polls(fc);
 		wake_up_all(&fc->chan->blocked_waitq);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 
 		fuse_dev_end_requests(&to_end);
 
 		/*
-		 * fc->lock must not be taken to avoid conflicts with io-uring
+		 * fc->chan->lock must not be taken to avoid conflicts with io-uring
 		 * locks
 		 */
 		fuse_uring_abort(fc);
 	} else {
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 	}
 }
 EXPORT_SYMBOL_GPL(fuse_abort_conn);
@@ -2617,11 +2620,11 @@ int fuse_dev_release(struct inode *inode, struct file *file)
 
 		fuse_dev_end_requests(&to_end);
 
-		spin_lock(&fc->lock);
+		spin_lock(&fc->chan->lock);
 		list_del(&fud->entry);
 		/* Are we the last open device? */
 		last = list_empty(&fc->chan->devices);
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 
 		if (last) {
 			WARN_ON(fc->chan->iq.fasync != NULL);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 1a7a364c8131..794fb7c9ede3 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -243,10 +243,10 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	max_payload_size = max(FUSE_MIN_READ_BUFFER, fc->max_write);
 	max_payload_size = max(max_payload_size, fc->max_pages * PAGE_SIZE);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	if (fc->chan->ring) {
 		/* race, another thread created the ring in the meantime */
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 		res = fc->chan->ring;
 		goto out_err;
 	}
@@ -258,7 +258,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 	ring->max_payload_sz = max_payload_size;
 	smp_store_release(&fc->chan->ring, ring);
 
-	spin_unlock(&fc->lock);
+	spin_unlock(&fc->chan->lock);
 	return ring;
 
 out_err:
@@ -298,9 +298,9 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	queue->fpq.processing = pq;
 	fuse_pqueue_init(&queue->fpq);
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	if (ring->queues[qid]) {
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 		kfree(queue->fpq.processing);
 		kfree(queue);
 		return ring->queues[qid];
@@ -310,7 +310,7 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	 * write_once and lock as the caller mostly doesn't take the lock at all
 	 */
 	WRITE_ONCE(ring->queues[qid], queue);
-	spin_unlock(&fc->lock);
+	spin_unlock(&fc->chan->lock);
 
 	return queue;
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index bfd349b88097..472ee0624a27 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -88,6 +88,14 @@ struct fuse_iqueue {
 };
 
 struct fuse_chan {
+	/** Lock protecting:
+	    - devices
+	    - connected
+	    - ring
+	    - ring->queues[qid]
+	 */
+	spinlock_t lock;
+
 	/** Input queue */
 	struct fuse_iqueue iq;
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 59bdabaf994b..6343218563b1 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -421,7 +421,7 @@ enum fuse_req_flag {
  *
  * .waitq.lock protects the following fields:
  *   - FR_ABORTED
- *   - FR_LOCKED (may also be modified under fc->lock, tested under both)
+ *   - FR_LOCKED (may also be modified under fpq->lock, tested under both)
  */
 struct fuse_req {
 	/** This can be on either pending processing or io lists in
@@ -520,7 +520,11 @@ struct fuse_sync_bucket {
  * fuse_mount is destroyed.
  */
 struct fuse_conn {
-	/** Lock protecting accessess to  members of this structure */
+	/** Lock protecting:
+	    - polled_files
+	    - backing_files_map
+	    - curr_bucket
+	 */
 	spinlock_t lock;
 
 	/** Refcount */
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index ef2e39e4dcf4..401d3545b0a8 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -89,9 +89,9 @@ static void fuse_check_timeout(struct work_struct *work)
 	if (expired)
 		goto abort_conn;
 
-	spin_lock(&fc->lock);
+	spin_lock(&fc->chan->lock);
 	if (!fc->chan->connected) {
-		spin_unlock(&fc->lock);
+		spin_unlock(&fc->chan->lock);
 		return;
 	}
 	list_for_each_entry(fud, &fc->chan->devices, entry) {
@@ -100,13 +100,13 @@ static void fuse_check_timeout(struct work_struct *work)
 		if (fuse_request_expired(fc, &fpq->io) ||
 		    fuse_fpq_processing_expired(fc, fpq->processing)) {
 			spin_unlock(&fpq->lock);
-			spin_unlock(&fc->lock);
+			spin_unlock(&fc->chan->lock);
 			goto abort_conn;
 		}
 
 		spin_unlock(&fpq->lock);
 	}
-	spin_unlock(&fc->lock);
+	spin_unlock(&fc->chan->lock);
 
 	if (fuse_uring_request_expired(fc))
 		goto abort_conn;
-- 
2.53.0

