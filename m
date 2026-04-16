Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6547F39B960
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331068; cv=none; b=gxMP8wDBPlj/DO8MvMMPw6kBS1hbAHkjhYip3531waSqSSRgT+oqj3DhQhlM2n9ETavJvl0SBp/deUswKE8zopX/HSnMQ6Q9xasd+e6HpMZGbHqfpM6xzliq1/tg2+FnILMRKr1e//0ZPiebEx44tNDKWEpJ30s4QALXbFbgZ08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331068; c=relaxed/simple;
	bh=UUeliXHLUW882BCw+uuZb7kXttcDG3lLb/LHMZb0qTI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cvxI7L2uwgtoEJNB2s+tb10SH4fpDa8VDVRnVhWXw0dN8PNtvC2OSPV3FZPGKgsnWQxUv9udtcyGXqmikxDgt6uVw+haTGhvgQe1c7BTGgHbNPXtGsxzDZam7iF2jJkQF0PeAbKevpYl4JwpTUURjyKae+bbs8zkLDRvTUhMGT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R8WU/fQF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tRuIF+BA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R8WU/fQF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tRuIF+BA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KcKnfz025LBPQi8Qqil8/m73QDn/r7T9kZb9tDw6FCg=;
	b=R8WU/fQFieBVYFjhn94LSox+sYstVHQ7XzWzD8n4A5r3zj1z3scHVDFfXC9r44XWUM6F6G
	5gphx611NX1THFwawAc7YhtjBRNjvCQKj8QTJjrMZCOmKt6CPFU9yky2iKSqAOK5ivLlub
	qHcEFP45YXlJ5XMhHkeEuEZN7+01fzM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-zMxZMVTuOl6A9Oc94iT7cA-1; Thu, 16 Apr 2026 05:17:34 -0400
X-MC-Unique: zMxZMVTuOl6A9Oc94iT7cA-1
X-Mimecast-MFC-AGG-ID: zMxZMVTuOl6A9Oc94iT7cA_1776331054
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so43617085e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331053; x=1776935853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KcKnfz025LBPQi8Qqil8/m73QDn/r7T9kZb9tDw6FCg=;
        b=tRuIF+BAp0yBmUtZXCYFhEKQQlwp7eJx+ecnSBpH4tHX1jjYIO+yQQ6BGSB/cZbNLx
         4woq08gIEcexOKTenzoMUdB6g4cCLjOCYuLIRx3PP/f8wAOaFcXEqClZeKhpo/6jCpMC
         lUS4YbI0G+b30xkjBXrKYxGYZcnBpjBflxWsuOarLMsScwUBXzUkTyo0CiLgAfVdTHso
         av5S1qSh3kdOJJbmejebKFcd0f68vcnTMuNTZvnbfWwpsEAirCqNmBaPrIbNl9MWO2c3
         PMXVyVdFtLC/p4Wma5SGDlV8STelvb7hWLSZ1Ni9Sdu10aIqCJiA8fj2eFa6HNGiwe/e
         rBBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331053; x=1776935853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KcKnfz025LBPQi8Qqil8/m73QDn/r7T9kZb9tDw6FCg=;
        b=d5Cj2EmYAMN6LpxS0CICZ5N+gf+076Eix0JdZUefbm7R6Ccfsn2DVxJClqfLncEdc7
         kI1EC6GajxTVSMoJ+ugcLo6I0fh5G1N3t6bL0k6S2VqExl0BzbUuNAN7Ct0R4ExfY5hT
         w9bhtxrIHgdrJecyThDRtQclkUuaHxoXPsoKEU9+n73bc0VjVA3JAw0CeANjZfNMp4qU
         lcu+liGt1GhUGiIe5Xbrb6KbOvoYyvyFDpDYjJMAmJrS09xTA0lpphebXuIDBQA1jau+
         yijtuotInY3cKv1vqZo6u4lN5HI+Emkjz5vc0DBa7isifhC1NI9fzCUyb+9kEBaZRZFP
         UOkQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xSox5u6r3qbZCKUxgne0D1+gn01HFaIAlKMgSUJvOoDQIF3O4x5vsDN8ggu+KFs93s8MYzdvbrHx7sVaR@vger.kernel.org
X-Gm-Message-State: AOJu0YwPm8RxgN45iiclTvSlujESK+v5DzShPsVwGIjrdZyiQFVAjloT
	Qtu2FK5sYLCc3A91QThjaXGq2Umi+PB1hP7TdlUVZts4ufnv0UglZZJq/HVPMV1gbWV3hlDcVzP
	IUlrR5KPMqP1TJKb8/rgze1mUoEMy71DI/kGuRQCJX7sfaVVJPmoEJ/lMBuBCQaHM1jDX0E+nRB
	g=
X-Gm-Gg: AeBDiet71hwBbq6KwIrMHI04oxQgIXMckyJmI6TXwrKhqk3/bHV0ZZqqmRACBdfzmOm
	f+76P2kowa7IZp4/FHhJYbk45Flwmtou0sr4IWUIf9Jsu5ZkcSX1B3MyR+SIRqojnuV6gykfn4j
	GD3K5sHdzErLwmcA+ea37vYGi8V+3zYPWGdzdQ/COkDRV4hCh5bKbGOjdU6KmI9Kk6O8RqcKf7O
	tARqws6r/7L/09hwp+JGOthili3ri2kK8BLu76OkccvsRtutVc9BZ/ZWfQVhxiSNRRLTw9AOpC6
	w83Xcn4gnDjagGkgloPEK2GkUFwLuyYZD8OxKxLie10ANhtMTeQy6ASLzJZVvuNOxB01j5dGPBe
	n6cd5csIUFRDMS9e8RodM45zPeXQMj1p0jGh2x9JHbhQJl4BwS7mVu4QvwC2ognyRgwWKeaEinm
	vST4mJ6Q==
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr347077445e9.13.1776331053140;
        Thu, 16 Apr 2026 02:17:33 -0700 (PDT)
X-Received: by 2002:a05:600c:3b96:b0:488:b098:b653 with SMTP id 5b1f17b1804b1-488d67f0a8amr347076825e9.13.1776331052553;
        Thu, 16 Apr 2026 02:17:32 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:31 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 22/32] fuse: change req->fm to req->chan
Date: Thu, 16 Apr 2026 11:16:46 +0200
Message-ID: <20260416091658.462783-23-mszeredi@redhat.com>
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

Store a struct fuse_chan pointer in fuse_req instead of a struct fuse_mount
pointer.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c        | 117 +++++++++++++++++++++----------------------
 fs/fuse/dev_uring.c  |  17 +++----
 fs/fuse/fuse_dev_i.h |   4 +-
 fs/fuse/fuse_trace.h |   4 +-
 4 files changed, 69 insertions(+), 73 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index f1e7e67912a3..5b74bd4d7cc3 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -35,22 +35,22 @@ static DECLARE_WAIT_QUEUE_HEAD(fuse_dev_waitq);
 
 static struct kmem_cache *fuse_req_cachep;
 
-static void fuse_request_init(struct fuse_mount *fm, struct fuse_req *req)
+static void fuse_request_init(struct fuse_chan *fch, struct fuse_req *req)
 {
 	INIT_LIST_HEAD(&req->list);
 	INIT_LIST_HEAD(&req->intr_entry);
 	init_waitqueue_head(&req->waitq);
 	refcount_set(&req->count, 1);
 	__set_bit(FR_PENDING, &req->flags);
-	req->fm = fm;
+	req->chan = fch;
 	req->create_time = jiffies;
 }
 
-static struct fuse_req *fuse_request_alloc(struct fuse_mount *fm, gfp_t flags)
+static struct fuse_req *fuse_request_alloc(struct fuse_chan *fch, gfp_t flags)
 {
 	struct fuse_req *req = kmem_cache_zalloc(fuse_req_cachep, flags);
 	if (req)
-		fuse_request_init(fm, req);
+		fuse_request_init(fch, req);
 
 	return req;
 }
@@ -85,17 +85,17 @@ static bool fuse_block_alloc(struct fuse_conn *fc, bool for_background)
 	       (fc->chan->io_uring && fc->chan->connected && !fuse_uring_ready(fc->chan));
 }
 
-static void fuse_drop_waiting(struct fuse_conn *fc)
+static void fuse_drop_waiting(struct fuse_chan *fch)
 {
 	/*
-	 * lockess check of fc->chan->connected is okay, because atomic_dec_and_test()
+	 * lockess check of fch->connected is okay, because atomic_dec_and_test()
 	 * provides a memory barrier matched with the one in fuse_chan_wait_aborted()
 	 * to ensure no wake-up is missed.
 	 */
-	if (atomic_dec_and_test(&fc->chan->num_waiting) &&
-	    !READ_ONCE(fc->chan->connected)) {
+	if (atomic_dec_and_test(&fch->num_waiting) &&
+	    !READ_ONCE(fch->connected)) {
 		/* wake up aborters */
-		wake_up_all(&fc->chan->blocked_waitq);
+		wake_up_all(&fch->blocked_waitq);
 	}
 }
 
@@ -132,7 +132,7 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	if (fc->conn_error)
 		goto out;
 
-	req = fuse_request_alloc(fm, GFP_KERNEL);
+	req = fuse_request_alloc(fc->chan, GFP_KERNEL);
 	err = -ENOMEM;
 	if (!req) {
 		if (for_background)
@@ -169,13 +169,13 @@ static struct fuse_req *fuse_get_req(struct mnt_idmap *idmap,
 	return req;
 
  out:
-	fuse_drop_waiting(fc);
+	fuse_drop_waiting(fc->chan);
 	return ERR_PTR(err);
 }
 
 static void fuse_put_request(struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_chan *fch = req->chan;
 
 	if (refcount_dec_and_test(&req->count)) {
 		if (test_bit(FR_BACKGROUND, &req->flags)) {
@@ -183,15 +183,15 @@ static void fuse_put_request(struct fuse_req *req)
 			 * We get here in the unlikely case that a background
 			 * request was allocated but not sent
 			 */
-			spin_lock(&fc->chan->bg_lock);
-			if (!fc->chan->blocked)
-				wake_up(&fc->chan->blocked_waitq);
-			spin_unlock(&fc->chan->bg_lock);
+			spin_lock(&fch->bg_lock);
+			if (!fch->blocked)
+				wake_up(&fch->blocked_waitq);
+			spin_unlock(&fch->bg_lock);
 		}
 
 		if (test_bit(FR_WAITING, &req->flags)) {
 			__clear_bit(FR_WAITING, &req->flags);
-			fuse_drop_waiting(fc);
+			fuse_drop_waiting(fch);
 		}
 
 		fuse_request_free(req);
@@ -594,9 +594,8 @@ static void flush_bg_queue(struct fuse_chan *fch)
  */
 void fuse_request_end(struct fuse_req *req)
 {
-	struct fuse_mount *fm = req->fm;
-	struct fuse_conn *fc = fm->fc;
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_chan *fch = req->chan;
+	struct fuse_iqueue *fiq = &fch->iq;
 
 	if (test_and_set_bit(FR_FINISHED, &req->flags))
 		goto put_request;
@@ -615,26 +614,26 @@ void fuse_request_end(struct fuse_req *req)
 	WARN_ON(test_bit(FR_PENDING, &req->flags));
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
-		spin_lock(&fc->chan->bg_lock);
+		spin_lock(&fch->bg_lock);
 		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->chan->num_background == fc->chan->max_background) {
-			fc->chan->blocked = 0;
-			wake_up(&fc->chan->blocked_waitq);
-		} else if (!fc->chan->blocked) {
+		if (fch->num_background == fch->max_background) {
+			fch->blocked = 0;
+			wake_up(&fch->blocked_waitq);
+		} else if (!fch->blocked) {
 			/*
 			 * Wake up next waiter, if any.  It's okay to use
 			 * waitqueue_active(), as we've already synced up
-			 * fc->chan->blocked with waiters with the wake_up() call
+			 * fch->blocked with waiters with the wake_up() call
 			 * above.
 			 */
-			if (waitqueue_active(&fc->chan->blocked_waitq))
-				wake_up(&fc->chan->blocked_waitq);
+			if (waitqueue_active(&fch->blocked_waitq))
+				wake_up(&fch->blocked_waitq);
 		}
 
-		fc->chan->num_background--;
-		fc->chan->active_background--;
-		flush_bg_queue(fc->chan);
-		spin_unlock(&fc->chan->bg_lock);
+		fch->num_background--;
+		fch->active_background--;
+		flush_bg_queue(fch);
+		spin_unlock(&fch->bg_lock);
 	} else {
 		/* Wake up waiter sleeping in request_wait_answer() */
 		wake_up(&req->waitq);
@@ -649,7 +648,7 @@ EXPORT_SYMBOL_GPL(fuse_request_end);
 
 static int queue_interrupt(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->chan->iq;
+	struct fuse_iqueue *fiq = &req->chan->iq;
 
 	/* Check for we've sent request to interrupt this req */
 	if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags)))
@@ -680,11 +679,11 @@ bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock)
 
 static void request_wait_answer(struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_chan *fch = req->chan;
+	struct fuse_iqueue *fiq = &fch->iq;
 	int err;
 
-	if (!fc->chan->no_interrupt) {
+	if (!fch->no_interrupt) {
 		/* Any signal may interrupt this */
 		err = wait_event_interruptible(req->waitq,
 					test_bit(FR_FINISHED, &req->flags));
@@ -708,7 +707,7 @@ static void request_wait_answer(struct fuse_req *req)
 			return;
 
 		if (req->args->abort_on_kill) {
-			fuse_chan_abort(fc->chan, false);
+			fuse_chan_abort(fch, false);
 			return;
 		}
 
@@ -729,7 +728,7 @@ static void request_wait_answer(struct fuse_req *req)
 
 static void __fuse_request_send(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &req->fm->fc->chan->iq;
+	struct fuse_iqueue *fiq = &req->chan->iq;
 
 	BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
 
@@ -776,11 +775,11 @@ static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args *args)
 	}
 }
 
-static void fuse_force_creds(struct fuse_req *req)
+static void fuse_force_creds(struct fuse_mount *fm, struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
+	struct fuse_conn *fc = fm->fc;
 
-	if (!req->fm->sb || req->fm->sb->s_iflags & SB_I_NOIDMAP) {
+	if (!fm->sb || fm->sb->s_iflags & SB_I_NOIDMAP) {
 		req->in.h.uid = from_kuid_munged(fc->user_ns, current_fsuid());
 		req->in.h.gid = from_kgid_munged(fc->user_ns, current_fsgid());
 	} else {
@@ -812,10 +811,10 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 
 	if (args->force) {
 		atomic_inc(&fc->chan->num_waiting);
-		req = fuse_request_alloc(fm, GFP_KERNEL | __GFP_NOFAIL);
+		req = fuse_request_alloc(fc->chan, GFP_KERNEL | __GFP_NOFAIL);
 
 		if (!args->nocreds)
-			fuse_force_creds(req);
+			fuse_force_creds(fm, req);
 
 		__set_bit(FR_WAITING, &req->flags);
 		if (!args->abort_on_kill)
@@ -845,10 +844,9 @@ ssize_t __fuse_simple_request(struct mnt_idmap *idmap,
 }
 
 #ifdef CONFIG_FUSE_IO_URING
-static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
-					       struct fuse_req *req)
+static bool fuse_request_queue_background_uring(struct fuse_req *req)
 {
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_iqueue *fiq = &req->chan->iq;
 
 	req->in.h.len = sizeof(struct fuse_in_header) +
 		fuse_len_args(req->args->in_numargs,
@@ -864,32 +862,31 @@ static bool fuse_request_queue_background_uring(struct fuse_conn *fc,
  */
 static int fuse_request_queue_background(struct fuse_req *req)
 {
-	struct fuse_mount *fm = req->fm;
-	struct fuse_conn *fc = fm->fc;
+	struct fuse_chan *fch = req->chan;
 	bool queued = false;
 
 	WARN_ON(!test_bit(FR_BACKGROUND, &req->flags));
 	if (!test_bit(FR_WAITING, &req->flags)) {
 		__set_bit(FR_WAITING, &req->flags);
-		atomic_inc(&fc->chan->num_waiting);
+		atomic_inc(&fch->num_waiting);
 	}
 	__set_bit(FR_ISREPLY, &req->flags);
 
 #ifdef CONFIG_FUSE_IO_URING
-	if (fuse_uring_ready(fc->chan))
-		return fuse_request_queue_background_uring(fc, req);
+	if (fuse_uring_ready(fch))
+		return fuse_request_queue_background_uring(req);
 #endif
 
-	spin_lock(&fc->chan->bg_lock);
-	if (likely(fc->chan->connected)) {
-		fc->chan->num_background++;
-		if (fc->chan->num_background == fc->chan->max_background)
-			fc->chan->blocked = 1;
-		list_add_tail(&req->list, &fc->chan->bg_queue);
-		flush_bg_queue(fc->chan);
+	spin_lock(&fch->bg_lock);
+	if (likely(fch->connected)) {
+		fch->num_background++;
+		if (fch->num_background == fch->max_background)
+			fch->blocked = 1;
+		list_add_tail(&req->list, &fch->bg_queue);
+		flush_bg_queue(fch);
 		queued = true;
 	}
-	spin_unlock(&fc->chan->bg_lock);
+	spin_unlock(&fch->bg_lock);
 
 	return queued;
 }
@@ -901,7 +898,7 @@ int fuse_simple_background(struct fuse_mount *fm, struct fuse_args *args,
 
 	if (args->force) {
 		WARN_ON(!args->nocreds);
-		req = fuse_request_alloc(fm, gfp_flags);
+		req = fuse_request_alloc(fm->fc->chan, gfp_flags);
 		if (!req)
 			return -ENOMEM;
 		__set_bit(FR_BACKGROUND, &req->flags);
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 4a0291a1f371..3ef7977dc8de 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1262,8 +1262,7 @@ static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
 /* queue a fuse request and send it if a ring entry is available */
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = req->chan->ring;
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 	int err;
@@ -1305,8 +1304,8 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 
 bool fuse_uring_queue_bq_req(struct fuse_req *req)
 {
-	struct fuse_conn *fc = req->fm->fc;
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_chan *fch = req->chan;
+	struct fuse_ring *ring = fch->ring;
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
@@ -1326,12 +1325,12 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
-	spin_lock(&fc->chan->bg_lock);
-	fc->chan->num_background++;
-	if (fc->chan->num_background == fc->chan->max_background)
-		fc->chan->blocked = 1;
+	spin_lock(&fch->bg_lock);
+	fch->num_background++;
+	if (fch->num_background == fch->max_background)
+		fch->blocked = 1;
 	fuse_uring_flush_bg(queue);
-	spin_unlock(&fc->chan->bg_lock);
+	spin_unlock(&fch->bg_lock);
 
 	/*
 	 * Due to bg_queue flush limits there might be other bg requests
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 534d037799ff..3248a417ade9 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -97,8 +97,8 @@ struct fuse_req {
 	void *argbuf;
 #endif
 
-	/** fuse_mount this request belongs to */
-	struct fuse_mount *fm;
+	/** fuse_chan this request belongs to */
+	struct fuse_chan *chan;
 
 #ifdef CONFIG_FUSE_IO_URING
 	void *ring_entry;
diff --git a/fs/fuse/fuse_trace.h b/fs/fuse/fuse_trace.h
index bbe9ddd8c716..4e34ddb172ed 100644
--- a/fs/fuse/fuse_trace.h
+++ b/fs/fuse/fuse_trace.h
@@ -90,7 +90,7 @@ TRACE_EVENT(fuse_request_send,
 	),
 
 	TP_fast_assign(
-		__entry->connection	=	req->fm->fc->dev;
+		__entry->connection	=	req->chan->conn->dev;
 		__entry->unique		=	req->in.h.unique;
 		__entry->opcode		=	req->in.h.opcode;
 		__entry->len		=	req->in.h.len;
@@ -114,7 +114,7 @@ TRACE_EVENT(fuse_request_end,
 	),
 
 	TP_fast_assign(
-		__entry->connection	=	req->fm->fc->dev;
+		__entry->connection	=	req->chan->conn->dev;
 		__entry->unique		=	req->in.h.unique;
 		__entry->len		=	req->out.h.len;
 		__entry->error		=	req->out.h.error;
-- 
2.53.0

