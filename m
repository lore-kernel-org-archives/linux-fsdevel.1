Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBA247CC6C
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Apr 2026 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775069412; cv=none; b=hpbD+QpVqCedmM33Tv/IyrkeLmLUrK341rhwpL3Pvj+pf7FYMyzAPDT6dj3Fr9W30RIZKXUGBQRcwHAZ05n3W8sSy4bfy7h5HOaVfONbirMKQtOs13/8xU65loCnJY47CCK7efTtnFkhtymb4Ok42iI/5Qj02mqsBFF5V+5BGfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775069412; c=relaxed/simple;
	bh=1GnI4YZW3N2JC1IinpFjDEYdd9ykHsrCmlasNHYbQ98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgVyjDDLCrLEOppJykgStbJsfpUVFRh6t6TpgJfV9DJq/zIa/EbT6rm82NP3t60zLnyqfpcydY2CW16ksuBgODg+8yw4W7w+iqspfCXHRV+Jdp/Si+wJWVIU5KN9ejovXACHHv0J9SbnI67ciOcopFdD+S+mcpAAPVPvrPP0tVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9K4tCpz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9K4tCpz"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82c70e4654eso41177b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Apr 2026 11:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775069411; x=1775674211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ICaAFpbMGQboIAi9OiYLR3EBM6U+PTOXmuN9mYNMh0M=;
        b=T9K4tCpzpvLdXjBOYFklVSRkqAMWbDA4ryLrylLhtTahjHO7dguuJswPxscAFsLgit
         1d+xy3vOso4isSpU8WEmfs1rW7vyyHQBX95ozKEsn2TIRX/3l17itopS3t86s8iyyTse
         30lbii+I/PtrdyScDzYsAlDjFCPleZfK0CSYaVuh/JMyjXN9K63vGjxcCmmJeO0Ms6kV
         c5lDW4oCDVA3PCyJ3hexNh2KWb6NfjDpz/JWSBrghkuLxSNZdmQuOUwBkYM1oSRUyp8c
         LFWp8xlBPdrNjDOM4Trhx2WpLKWNpyj1xqJxHVKF3JUeGywoPMbvL1FIC0qAjEXMbJq5
         e3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775069411; x=1775674211;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICaAFpbMGQboIAi9OiYLR3EBM6U+PTOXmuN9mYNMh0M=;
        b=G8Q+6PTHYFKJoHPjFoa7bRhNyLjiBAED0oYlOvlA7IYKo6Zd9I+MEpjl8npV5QZJgT
         JiK++pWH1ypIUXfL2CWSdPe1Fh90D/sjXSREKQd7g138sTYzWlfn910+RQC54Y8yKTmu
         oKmkfKTbOnE5SH4fISDVys7JWw6NPyWsSNJzHd/vQ48qihI4LddNBAeIET9nKqkkHhIl
         a/10SBd/1Qw9Z6JUW7eTAM5lXIbf55chWm4zl7uX9etcaZNnZymPXH461r+d4YsGTffU
         fsF+S/tTG0suOVOCglK0Nkpdey2j5X8QzxoS7PdCdNFDNHPTpoGpJDLwhUneZDUMY3qg
         IFuA==
X-Forwarded-Encrypted: i=1; AJvYcCV3T1XAPA1+ctwyg9sHjZ+m032BXUDHEcvf/DulgUfEwX+COB+U3kMsuN4nvFVS2CGa037tgwFah/f0r7dO@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh9XN08soCo69oKF1uZd2vqiH5k4jfWscWwy1prIIFktaWzIBf
	dS5DLu5Xtg3NfKkQKiJev11qY41m3OfWb/OeIU3w2WN+iHcim66kjnyB
X-Gm-Gg: ATEYQzwLY/Bw7grj1EiOmnBIfmEOuU3SjJN38JqJ+gFQZT92B5NriRPH2hoQA0xdhyb
	/tLYaYYilWiVRQ/TxDANfMjAaqRin4ih9ZTTDoc510KPWYyVgp2hTBOMTMs2DpbRTEKoA7yYMpL
	0vxB4w5KQ+URsf1ppmtWeC/7q0XfMnEIvxjPn92z48g18xgCDB8fp2dcDlgyKnUtf9PYtHW2E/k
	BbVfxP71sXmsOcb2TbZHFgwWoT4I68moKMAbPpJTAHwRAYQeBIbrHoCCxeJEfOMpN0Zj3vcTLNC
	WxHcYOrGCdqYmap671n5bfKLAkPxz+DxuenfidZVanyJooYqeDnyw5ZVwMsukoWd2DhDDcuFWFx
	hhmdkkDqw3iAqVHViGjK8BMFfdDg1kIO8CkzaBdfMjtM5xwDMGL+2YzQD+6WHxYsOXM1dNCfv4Y
	b6oPnaNpSOjsWVZEV/Vw==
X-Received: by 2002:a05:6a00:600a:b0:82c:2480:4e3d with SMTP id d2e1a72fcca58-82cfb85d64amr604949b3a.9.1775069410480;
        Wed, 01 Apr 2026 11:50:10 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:54::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c72967sm628158b3a.49.2026.04.01.11.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 11:50:10 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] fuse: fix io-uring background queue stall on request completion
Date: Wed,  1 Apr 2026 11:49:15 -0700
Message-ID: <20260401184915.747714-1-joannelkoong@gmail.com>
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
which can leave pending background requests stuck in the per-queue
background queue.

The connection-level counters are decremented in fuse_request_end(), but
flush_bg_queue() flushes the /dev/fuse path queue (fc->bg_queue), not
the io_uring per-queue bg one, which means pending uring background
requests on the queue are never dispatched.

Fix this by accounting the connection-level background counters first
before flushing the queue's background queue. Since
fuse_request_bg_finish() clears FR_BACKGROUND, fuse_request_end() will
skip the background cleanup branch entirely, which avoids any
double-decrements; it will call the wake_up(&req->waitq) branch but this
is effectively a no-op as background requests have no waiters on
req->waitq.

Fixes: 857b0263f30e ("fuse: Allow to queue bg requests through io-uring")
Cc: stable@vger.kernel.org
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
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

