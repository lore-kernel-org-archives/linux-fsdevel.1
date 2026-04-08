Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADFB3537FC
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Apr 2026 17:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669282; cv=none; b=GNeivk8YlCK+ZfMlgTNodrI2tnPM9Sy+dt3VVTb6ybD923fn2xwSct9aHS0+ah5parCR31HHNvDthbr9NHdCJjgWnkqypexpPFtQh+lrbG+xyDbO8WW7vCN021/UDb0k4RIZB9woC7W3ey9iCK5w5scZ+FuaISd0DG8+NBGjvEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669282; c=relaxed/simple;
	bh=LWTx2GY8slqIDGaaLTanK/z5XYSQoYnAW6llqlo71dw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mMlbgT12VJfS4ruJ89dzdP9kS0GmX/Nq/wcxN/vCpIN91wFDhmTcwRs4lGTnrPIRkWpg3/EekRrj4aREdmqtL2dY0aK+zpwAUGt5cFmRujFNXxHaWB5t8ppDNqZAVO2Y/JWvKOmE8cxAmIMvrkXszCcVbr8NamCPYACqNfVW9RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ewfE3otd; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ewfE3otd"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad21f437eeso963495ad.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Apr 2026 10:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775669280; x=1776274080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0HF3+tN1DpTpfpPPMCKgC2HXznMTy5CA+hodNp+cNrs=;
        b=ewfE3otd+MqQcmtg8be8AW4qBgQw6W8ckRHNUFrVK5c/fhCkkhowdJU3oD/Z49dd6Z
         RqLgiCmpjORrCGhGDRRy/SPSLFO4srZBKn7UXdpVGjfdfIPqeCU8uTGk+FoeTiEYYiSs
         KnV/fu1NUHMMa6+sEOpKsB+Gmd6OuHaUrtowxA6b17RltipNguH9ozx8SLFONpUSHRP0
         XsOi88QqOesnqHFhc4nkHlxf7Uf6YjKNIgxbPWFVohWT7wjIKPnlk5F6oNMOE9z4dnVv
         /sfUmAX0BUD704tYdlEaZbHGI92ROVeNxTX152kOSQ3C7R6IaYxsShykdHr4YmVLIoO8
         ES3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775669280; x=1776274080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0HF3+tN1DpTpfpPPMCKgC2HXznMTy5CA+hodNp+cNrs=;
        b=Xrj90KmJHBFzk7G9BNoFEvCT+EKi/RTNdYaXzcRLdZp2XfJrbjY1ijQug7tff825Zi
         FI6u08L3kxM5ItYXHPWfjnsajtZf+Si9cFDjsU2TSTzqzR+xyNUw6nSF6K7mtO/pscxU
         XMgDkzV+pA2bSzFdBRoaYW7dEpnpfbnEfrj5Jgc6yxbIELOmmJ+ugpTOAbdSLNkQpw0M
         0uYaXo9OJT70GokK29YQw7xIPsKbbkjYSgnVigd4/QwTYhHQ4wvmB7nHJRwB4OZdIve0
         2bLHC+rymuu5b2CWH7jT9PPSi2l92UCjvQIxsDGs9F1tdZd0NdwxG+p9XONpIIdZ9WLA
         MIsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOAeMVBp/ffVntxA1RGkQVzMjQrMOCv4LHt6dHoII3u8gT4vEtMkTLD0sxzIlcriuzhF8/9OdLNWU6loTC@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg5W0r3RGg4y6+IH6CKQjtnlEFXsJryp0Rbw+PtJ4CU6qQwdyl
	mVWYFscIEWwImUOk73yteyfcBomyHsMBtzpzY0dEF9aD9u9rlJ1NdVe8
X-Gm-Gg: AeBDiesJNFr5ZPnMfhPxZ8qMP281BCQe0r8UyULUUu82urZErZvvGtgg06v+U/zs95d
	K+KfGw9h076IZIQBMJeXYpwFb1kKt13lC8w3dJw8joGMulEl418OLzOh+V6+s4XpMTLDIpFmO9a
	LoyZ+FR6EqvtGZGHUTG+hHcvMMa5dTg55ebcNVszXlGoPkotFk8aDcjTe+M9gEykkGpa5NI8Mk5
	H9Ab98HG0SQSTnGc5qSIjDI/5prJv+77S2GdtkNMlSfSJWrnXUZrkhF7tCJbl0pIOXESNEKS7Gv
	IIrfyCEQfmz2qm5TQKPLggwiz7e1I+7LDclfcqr9EhaokK0rNnD7Cm2hkQrfombaLJil4QJ7u9U
	Ki8XquYXZR/3G8bY8dV0V+T/Uy9JWcennD16HNyYUppOyGzO6+3TdnQwZ2IcOtkj3wnyk28E0bB
	vkGplZRsApiMOCQekdBA==
X-Received: by 2002:a17:903:1ac8:b0:2b0:4f7a:1958 with SMTP id d9443c01a7336-2b2c73a442fmr2487605ad.29.1775669279941;
        Wed, 08 Apr 2026 10:27:59 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:14::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749a3af9sm198274025ad.63.2026.04.08.10.27.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 10:27:59 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	hbirthelmer@ddn.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] fuse: fix io-uring background queue dispatch on request completion
Date: Wed,  8 Apr 2026 10:25:10 -0700
Message-ID: <20260408172510.52950-1-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a background request completes via the io_uring path, the
background queue gets flushed to dispatch pending background requests,
but this is done before the connection-level background counters
(fc->num_background, fc->active_background) are properly accounted,
which may reduce effective queue depth to one.

The connection-level counters are decremented in fuse_request_end(), but
flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
the io_uring per-queue bg one, which means pending uring background
requests on the queue are never dispatched in this path.

Fix this by accounting the connection-level background counters first
before flushing the queue's background queue. Since
fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
skip the background cleanup branch entirely, which avoids any
double-decrements; it will call the wake_up(&req->waitq) branch but this
is effectively a no-op as background requests have no waiters on
req->waitq.

Reviewed-by: Bernd Schubert <bernd@bsbernd.com>
Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
v1: https://lore.kernel.org/linux-fsdevel/20260401184915.747714-1-joannelkoong@gmail.com/
v1 -> v2:
* change commit message wording (Bernd)
---
 fs/fuse/dev.c        | 41 ++++++++++++++++++++++++-----------------
 fs/fuse/dev_uring.c  |  1 +
 fs/fuse/fuse_dev_i.h |  1 +
 3 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index b212565a78cf..35cdfc162ba5 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -447,6 +447,29 @@ static void flush_bg_queue(struct fuse_conn *fc)
 	}
 }
 
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req)
+{
+	lockdep_assert_held(&fc->bg_lock);
+
+	clear_bit(FR_BACKGROUND, &req->flags);
+	if (fc->num_background == fc->max_background) {
+		fc->blocked = 0;
+		wake_up(&fc->blocked_waitq);
+	} else if (!fc->blocked) {
+		/*
+		 * Wake up next waiter, if any.  It's okay to use
+		 * waitqueue_active(), as we've already synced up
+		 * fc->blocked with waiters with the wake_up() call
+		 * above.
+		 */
+		if (waitqueue_active(&fc->blocked_waitq))
+			wake_up(&fc->blocked_waitq);
+	}
+
+	fc->num_background--;
+	fc->active_background--;
+}
+
 /*
  * This function is called when a request is finished.  Either a reply
  * has arrived or it was aborted (and not yet sent) or some error
@@ -479,23 +502,7 @@ void fuse_request_end(struct fuse_req *req)
 	WARN_ON(test_bit(FR_SENT, &req->flags));
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		spin_lock(&fc->bg_lock);
-		clear_bit(FR_BACKGROUND, &req->flags);
-		if (fc->num_background == fc->max_background) {
-			fc->blocked = 0;
-			wake_up(&fc->blocked_waitq);
-		} else if (!fc->blocked) {
-			/*
-			 * Wake up next waiter, if any.  It's okay to use
-			 * waitqueue_active(), as we've already synced up
-			 * fc->blocked with waiters with the wake_up() call
-			 * above.
-			 */
-			if (waitqueue_active(&fc->blocked_waitq))
-				wake_up(&fc->blocked_waitq);
-		}
-
-		fc->num_background--;
-		fc->active_background--;
+		fuse_request_bg_finish(fc, req);
 		flush_bg_queue(fc);
 		spin_unlock(&fc->bg_lock);
 	} else {
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 7b9822e8837b..ae916733f18a 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -90,6 +90,7 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
+		fuse_request_bg_finish(fc, req);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index 134bf44aff0d..7da505af6d35 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -59,6 +59,7 @@ unsigned int fuse_req_hash(u64 unique);
 struct fuse_req *fuse_request_find(struct fuse_pqueue *fpq, u64 unique);
 
 void fuse_dev_end_requests(struct list_head *head);
+void fuse_request_bg_finish(struct fuse_conn *fc, struct fuse_req *req);
 
 void fuse_copy_init(struct fuse_copy_state *cs, bool write,
 			   struct iov_iter *iter);
-- 
2.52.0

