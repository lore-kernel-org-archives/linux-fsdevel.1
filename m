Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65A311583
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 09:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331048; cv=none; b=SVbGo+PXnn7Z8azQ+aNdQdKHgbjtw1hINP6w9JfU+EChjkyhrAv4WpdWOvuwNk4QTrF+Y1/FrRsBb/NaYZffw/VoLj2Y8uqKU/J97gThdX+t2uRy8Um7algepqfQqU8NU0nGfY8RJeoKPkB1/ucRpwtA1UJb6HOtF7ZZept2mns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331048; c=relaxed/simple;
	bh=UPIODV8sOmt9L86MxggJbP3/KBEuPeZfe7vgbJ+0MHo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXzkTTJsHt/nhYazV7AsjJEeGniQlHnHmhSTeBu9XBczVMDLlHGZ7h+fhzbtWSe/85yoxWmoixIcs7oyxrZJ4NsZIm8KxvBYZ8H7OYTRsbEa6wmS+KNB0kHf8Xj846DiEgtY8HmRbwpBeJMN3aO6ciPQbKscUr9J1uu0CRBikSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h9ekhVun; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=YYgzjH3/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h9ekhVun";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="YYgzjH3/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776331042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LxcoodLdByYTvjPNsxvAVgxY2vgrgXidGPrUEg26FpU=;
	b=h9ekhVunLVkP30xV9BoQ2inwXTGQBARuEoOiqv2zgbUjurcUqasDa+WEqb9slqlNPGWW59
	NumpAnCvODe5w8KwUcsom1TIIW2YUhYTYGVGfo7qBQuG0nMk4RRK+Fzx4xs4TiCFLmap6U
	s18NXXN1HBKg9NswbOMHkovRulKxuk0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-0hjLNJoNM5i3Z1YYrRcz0g-1; Thu, 16 Apr 2026 05:17:20 -0400
X-MC-Unique: 0hjLNJoNM5i3Z1YYrRcz0g-1
X-Mimecast-MFC-AGG-ID: 0hjLNJoNM5i3Z1YYrRcz0g_1776331039
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488d9e1e61aso42541695e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 02:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776331039; x=1776935839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LxcoodLdByYTvjPNsxvAVgxY2vgrgXidGPrUEg26FpU=;
        b=YYgzjH3/1en9+BQkAM3INFUX83CCEAQq4QWzWj7Pjl3aAehQoxUmnsN7OMvuEc53ch
         iCykvG6nvnfK5bSDgVd5nq4UMiV6tfvpQME973J/34m+YWci1nYPqg8UJdBeLBmK5GUY
         bcxWbzYzuNPIHY731Fk/affG2bMJYz7GZU4GLZGCWVJNeNcfR5JBrTZDEQHtZf83IphJ
         FKdI5Mb/fA8Yyp/PZi6xZTdxM8dXTZO7M4s+wbSIJBhaGm9zxBhTrs2u1ffKCGpLRMv2
         9NTJ0078s9x0cokFglua+EPtTkJmhWcSfbj3DP8yAr0p7l1slMXz425OqaN86fssQchk
         FUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331039; x=1776935839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LxcoodLdByYTvjPNsxvAVgxY2vgrgXidGPrUEg26FpU=;
        b=C+gCoZ92yqbLv4HKyDMaDKfTtERhqP7IakgpmPjrbCpt/xhIsGcGNuiC4R6kW4X2pj
         ukdLi78BzeXGBD01GzNt7faX6Htav0PkvYe5BM/nJW5CMWAwgcO91p2qLHakQS0w4pNn
         8IJb4wtAyL7tbIHVU2oDgd5LOmyn0SeLg6wSAVrX1z+WkeNgQiY4jlt2Ptjt5R5k6Mup
         6XS2jzDmcYD8pkkoSgh+4eh6ggWjIEUz1Y+xd98pY8w6PWhUpa2FDzEwOn4FTdij2fCg
         iKra1ECNeeFveM88iLiodNDyo++jqk2fvJePZN68tVutTMc3XyPylmTLq+dpKVVn9ZuD
         cHZw==
X-Forwarded-Encrypted: i=1; AFNElJ+UIzmguMjDFczDxUSTkeirdfEr5spm6nVPYN2NcW1OYyAr22PtKe20/xuuhVP4l2utLI/Aac7J1KZ784ht@vger.kernel.org
X-Gm-Message-State: AOJu0Yygk2uB0lVAgcW0zgfXevbH8ZY9Rjolmdn2ZgtOSGIU0yHp3e3+
	5pXqNtzYx7Zka6PBvUWY6lkAXckW8pMknaKL+0OweORGiGiLQN5uAEwmv3oWvnn0xPNpHqikh9y
	vm8vnZYDBw6TN7GdGPgah+GicRX2tFQz7rn50Yc3D+I72ul/nmDIljGv8CjMGS/ZU/KVHWQJ5eB
	8=
X-Gm-Gg: AeBDiettSBiwFVGTN1NRrUekAguKLObH+pfohUEjxvaNM5eFw6bEZhm7HP8iPTnYtH/
	aKk9eCt10YKm2VpQmESgQ6FOFakpFBxyot07kGJt+2RONy2HFJAGo5ephv3izqYK9FHoE+TTejo
	rVqAHQ4Iu1Yy0AmYwsWRZTSvq9fCWIQZc7BiB9ZEN7hMxiN4LjPRIn6yLqahLZGXlsDqQrL2J9v
	sgLB1Xs7Z0XrSLBS72UNtpptCLUYg7vuA0PFXcPumWUi12rkftp8gFytkOa2YHInuP1bLokm6NS
	LNqoWTwij/In+R9DEoRf9nuvEijm2BXfY9DaUasesyd5+XTK7ZQbXL/NjGznLfiRYzTSoPTgVFN
	BSAQMeWsljkNp3UHGYmDqVMPnaHKPsxb+YFZeoHJzfeVEwrIftvO1u9G1HQ29L+pBdVXOSgoj3/
	nzB0qVuw==
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488d68865f6mr269315665e9.28.1776331038985;
        Thu, 16 Apr 2026 02:17:18 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:488:8b99:54a1 with SMTP id 5b1f17b1804b1-488d68865f6mr269315365e9.28.1776331038488;
        Thu, 16 Apr 2026 02:17:18 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (85-66-37-19.pool.digikabel.hu. [85.66.37.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f57d80d3sm38597975e9.0.2026.04.16.02.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:17:17 -0700 (PDT)
From: Miklos Szeredi <mszeredi@redhat.com>
To: fuse-devel@lists.linux.dev,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 12/32] fuse: move request timeout to fuse_chan
Date: Thu, 16 Apr 2026 11:16:36 +0200
Message-ID: <20260416091658.462783-13-mszeredi@redhat.com>
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

 - timeout

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dev.c         |  5 ++--
 fs/fuse/dev.h         |  2 +-
 fs/fuse/dev_uring.c   | 16 ++++++------
 fs/fuse/dev_uring_i.h |  4 +--
 fs/fuse/fuse_dev_i.h  | 11 ++++++++-
 fs/fuse/fuse_i.h      |  9 -------
 fs/fuse/inode.c       |  7 +++---
 fs/fuse/req_timeout.c | 57 +++++++++++++++++++++----------------------
 8 files changed, 55 insertions(+), 56 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 9af71016591d..fa2d027dfa36 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -363,6 +363,7 @@ struct fuse_chan *fuse_chan_new(void)
 	fch->initialized = 0;
 	fch->blocked = 0;
 	fch->connected = 1;
+	fch->timeout.req_timeout = 0;
 
 	return fch;
 }
@@ -2528,8 +2529,8 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		LIST_HEAD(to_end);
 		unsigned int i;
 
-		if (fc->timeout.req_timeout)
-			cancel_delayed_work(&fc->timeout.work);
+		if (fc->chan->timeout.req_timeout)
+			cancel_delayed_work(&fc->chan->timeout.work);
 
 		/* Background queuing checks fc->chan->connected under bg_lock */
 		spin_lock(&fc->chan->bg_lock);
diff --git a/fs/fuse/dev.h b/fs/fuse/dev.h
index 2630dab3ef56..df8a199b42d2 100644
--- a/fs/fuse/dev.h
+++ b/fs/fuse/dev.h
@@ -21,6 +21,6 @@ DEFINE_FREE(fuse_chan_free, struct fuse_chan *, if (_T) fuse_chan_free(_T))
 void fuse_dev_install(struct fuse_dev *fud, struct fuse_conn *fc);
 void fuse_dev_put(struct fuse_dev *fud);
 
-void fuse_init_server_timeout(struct fuse_conn *fc, unsigned int timeout);
+void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout);
 
 #endif /* _FS_FUSE_DEV_H */
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 794fb7c9ede3..97059069316e 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -142,7 +142,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	}
 }
 
-static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *list)
+static bool ent_list_request_expired(struct fuse_chan *fch, struct list_head *list)
 {
 	struct fuse_ring_ent *ent;
 	struct fuse_req *req;
@@ -154,12 +154,12 @@ static bool ent_list_request_expired(struct fuse_conn *fc, struct list_head *lis
 	req = ent->fuse_req;
 
 	return time_is_before_jiffies(req->create_time +
-				      fc->timeout.req_timeout);
+				      fch->timeout.req_timeout);
 }
 
-bool fuse_uring_request_expired(struct fuse_conn *fc)
+bool fuse_uring_request_expired(struct fuse_chan *fch)
 {
-	struct fuse_ring *ring = fc->chan->ring;
+	struct fuse_ring *ring = fch->ring;
 	struct fuse_ring_queue *queue;
 	int qid;
 
@@ -172,10 +172,10 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 			continue;
 
 		spin_lock(&queue->lock);
-		if (fuse_request_expired(fc, &queue->fuse_req_queue) ||
-		    fuse_request_expired(fc, &queue->fuse_req_bg_queue) ||
-		    ent_list_request_expired(fc, &queue->ent_w_req_queue) ||
-		    ent_list_request_expired(fc, &queue->ent_in_userspace)) {
+		if (fuse_request_expired(fch, &queue->fuse_req_queue) ||
+		    fuse_request_expired(fch, &queue->fuse_req_bg_queue) ||
+		    ent_list_request_expired(fch, &queue->ent_w_req_queue) ||
+		    ent_list_request_expired(fch, &queue->ent_in_userspace)) {
 			spin_unlock(&queue->lock);
 			return true;
 		}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 5b981708d04a..8aa33f989e4c 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -144,7 +144,7 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
 bool fuse_uring_remove_pending_req(struct fuse_req *req);
-bool fuse_uring_request_expired(struct fuse_conn *fc);
+bool fuse_uring_request_expired(struct fuse_chan *fch);
 
 static inline void fuse_uring_abort(struct fuse_conn *fc)
 {
@@ -202,7 +202,7 @@ static inline bool fuse_uring_remove_pending_req(struct fuse_req *req)
 	return false;
 }
 
-static inline bool fuse_uring_request_expired(struct fuse_conn *fc)
+static inline bool fuse_uring_request_expired(struct fuse_chan *fch)
 {
 	return false;
 }
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 0bace11373b9..2e0193acc9c2 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -150,6 +150,15 @@ struct fuse_chan {
 	/**  uring connection information*/
 	struct fuse_ring *ring;
 #endif
+
+	/** Only used if the connection opts into request timeouts */
+	struct {
+		/* Worker for checking if any requests have timed out */
+		struct delayed_work work;
+
+		/* Request timeout (in jiffies). 0 = no timeout */
+		unsigned int req_timeout;
+	} timeout;
 };
 
 #define FUSE_PQ_HASH_BITS 8
@@ -261,7 +270,7 @@ void fuse_dev_queue_forget(struct fuse_iqueue *fiq,
 void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_remove_pending_req(struct fuse_req *req, spinlock_t *lock);
 
-bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list);
+bool fuse_request_expired(struct fuse_chan *fch, struct list_head *list);
 
 /**
  * Assign a unique id to a fuse request
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 6343218563b1..7bc6c2054d1a 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -816,15 +816,6 @@ struct fuse_conn {
 	/** IDR for backing files ids */
 	struct idr backing_files_map;
 #endif
-
-	/** Only used if the connection opts into request timeouts */
-	struct {
-		/* Worker for checking if any requests have timed out */
-		struct delayed_work work;
-
-		/* Request timeout (in jiffies). 0 = no timeout */
-		unsigned int req_timeout;
-	} timeout;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d31d7b80c184..03da955d419d 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -987,7 +987,6 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = fuse_max_pages_limit;
 	fc->name_max = FUSE_NAME_LOW_MAX;
-	fc->timeout.req_timeout = 0;
 
 	if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
 		fuse_backing_files_init(fc);
@@ -1020,8 +1019,8 @@ void fuse_conn_put(struct fuse_conn *fc)
 
 	if (IS_ENABLED(CONFIG_FUSE_DAX))
 		fuse_dax_conn_free(fc);
-	if (fc->timeout.req_timeout)
-		cancel_delayed_work_sync(&fc->timeout.work);
+	if (fc->chan->timeout.req_timeout)
+		cancel_delayed_work_sync(&fc->chan->timeout.work);
 	cancel_work_sync(&fc->epoch_work);
 	fuse_chan_release(fc->chan);
 	put_pid_ns(fc->pid_ns);
@@ -1423,7 +1422,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 			fc->no_flock = 1;
 		}
 
-		fuse_init_server_timeout(fc, timeout);
+		fuse_init_server_timeout(fc->chan, timeout);
 
 		fm->sb->s_bdi->ra_pages =
 				min(fm->sb->s_bdi->ra_pages, ra_pages);
diff --git a/fs/fuse/req_timeout.c b/fs/fuse/req_timeout.c
index 401d3545b0a8..ef464bebc0b6 100644
--- a/fs/fuse/req_timeout.c
+++ b/fs/fuse/req_timeout.c
@@ -29,22 +29,22 @@ unsigned int fuse_default_req_timeout;
  */
 unsigned int fuse_max_req_timeout;
 
-bool fuse_request_expired(struct fuse_conn *fc, struct list_head *list)
+bool fuse_request_expired(struct fuse_chan *fch, struct list_head *list)
 {
 	struct fuse_req *req;
 
 	req = list_first_entry_or_null(list, struct fuse_req, list);
 	if (!req)
 		return false;
-	return time_is_before_jiffies(req->create_time + fc->timeout.req_timeout);
+	return time_is_before_jiffies(req->create_time + fch->timeout.req_timeout);
 }
 
-static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *processing)
+static bool fuse_fpq_processing_expired(struct fuse_chan *fch, struct list_head *processing)
 {
 	int i;
 
 	for (i = 0; i < FUSE_PQ_HASH_SIZE; i++)
-		if (fuse_request_expired(fc, &processing[i]))
+		if (fuse_request_expired(fch, &processing[i]))
 			return true;
 
 	return false;
@@ -67,68 +67,67 @@ static bool fuse_fpq_processing_expired(struct fuse_conn *fc, struct list_head *
 static void fuse_check_timeout(struct work_struct *work)
 {
 	struct delayed_work *dwork = to_delayed_work(work);
-	struct fuse_conn *fc = container_of(dwork, struct fuse_conn,
-					    timeout.work);
-	struct fuse_iqueue *fiq = &fc->chan->iq;
+	struct fuse_chan *fch = container_of(dwork, struct fuse_chan, timeout.work);
+	struct fuse_iqueue *fiq = &fch->iq;
 	struct fuse_dev *fud;
 	struct fuse_pqueue *fpq;
 	bool expired = false;
 
-	if (!atomic_read(&fc->chan->num_waiting))
+	if (!atomic_read(&fch->num_waiting))
 		goto out;
 
 	spin_lock(&fiq->lock);
-	expired = fuse_request_expired(fc, &fiq->pending);
+	expired = fuse_request_expired(fch, &fiq->pending);
 	spin_unlock(&fiq->lock);
 	if (expired)
 		goto abort_conn;
 
-	spin_lock(&fc->chan->bg_lock);
-	expired = fuse_request_expired(fc, &fc->chan->bg_queue);
-	spin_unlock(&fc->chan->bg_lock);
+	spin_lock(&fch->bg_lock);
+	expired = fuse_request_expired(fch, &fch->bg_queue);
+	spin_unlock(&fch->bg_lock);
 	if (expired)
 		goto abort_conn;
 
-	spin_lock(&fc->chan->lock);
-	if (!fc->chan->connected) {
-		spin_unlock(&fc->chan->lock);
+	spin_lock(&fch->lock);
+	if (!fch->connected) {
+		spin_unlock(&fch->lock);
 		return;
 	}
-	list_for_each_entry(fud, &fc->chan->devices, entry) {
+	list_for_each_entry(fud, &fch->devices, entry) {
 		fpq = &fud->pq;
 		spin_lock(&fpq->lock);
-		if (fuse_request_expired(fc, &fpq->io) ||
-		    fuse_fpq_processing_expired(fc, fpq->processing)) {
+		if (fuse_request_expired(fch, &fpq->io) ||
+		    fuse_fpq_processing_expired(fch, fpq->processing)) {
 			spin_unlock(&fpq->lock);
-			spin_unlock(&fc->chan->lock);
+			spin_unlock(&fch->lock);
 			goto abort_conn;
 		}
 
 		spin_unlock(&fpq->lock);
 	}
-	spin_unlock(&fc->chan->lock);
+	spin_unlock(&fch->lock);
 
-	if (fuse_uring_request_expired(fc))
+	if (fuse_uring_request_expired(fch))
 		goto abort_conn;
 
 out:
-	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
+	queue_delayed_work(system_percpu_wq, &fch->timeout.work,
 			   fuse_timeout_timer_freq);
 	return;
 
 abort_conn:
-	fuse_abort_conn(fc);
+	fuse_abort_conn(fch->conn);
 }
 
-static void set_request_timeout(struct fuse_conn *fc, unsigned int timeout)
+static void set_request_timeout(struct fuse_chan *fch, unsigned int timeout)
 {
-	fc->timeout.req_timeout = secs_to_jiffies(timeout);
-	INIT_DELAYED_WORK(&fc->timeout.work, fuse_check_timeout);
-	queue_delayed_work(system_percpu_wq, &fc->timeout.work,
+	fch->timeout.req_timeout = secs_to_jiffies(timeout);
+	INIT_DELAYED_WORK(&fch->timeout.work, fuse_check_timeout);
+	queue_delayed_work(system_percpu_wq, &fch->timeout.work,
 			   fuse_timeout_timer_freq);
 }
 
-void fuse_init_server_timeout(struct fuse_conn *fc, unsigned int timeout)
+void fuse_init_server_timeout(struct fuse_chan *fch, unsigned int timeout)
 {
 	if (!timeout && !fuse_max_req_timeout && !fuse_default_req_timeout)
 		return;
@@ -145,6 +144,6 @@ void fuse_init_server_timeout(struct fuse_conn *fc, unsigned int timeout)
 
 	timeout = max(FUSE_TIMEOUT_TIMER_FREQ, timeout);
 
-	set_request_timeout(fc, timeout);
+	set_request_timeout(fch, timeout);
 }
 
-- 
2.53.0

