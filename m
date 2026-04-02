Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15C33F2108
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147404; cv=none; b=CB4TJqpHkBxTaa8EG5fQnSeLNZxNp0cLhAFx7c6jmRVPabmTDSmZJEzZ9kh+WlxMxXVw7g5CHJiGYL9YzeZlhEedU0l/a4gMFVk9zcuburoMAI1B+aukj2i+HcjTFjqkhP5HrQjFcLO0BTTEdC3aheytJOEflQ/kvgn+KMofwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147404; c=relaxed/simple;
	bh=SpLiDnbAd0UnCcYWrPWDMahDpvJk133JrZ2RsCRj3uU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tD+yuBMS5W2EzLKdjslZ9HmcaI1Qg7EFnDMCHAKNyWSNZUr6XE4S0k3hxxgIApEfC6pufuUhCgCfsvd1CCIUXZ/eC8OOGmOGXWvFrT7KfmiUvjKOl66vT2t8jiZEv9vzJx2H3xWqLaa0bnIHCKGNJOtmKaN9YXCNgeAKcF3JacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pjo0MvMT; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pjo0MvMT"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82c68339cf0so1384894b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147403; x=1775752203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vV+E8ILz/KFLO2ZZOB1e8mT2z2bGVYiI9vPMjVDtvWU=;
        b=Pjo0MvMTZlS2jIQJH8DxCE8QznlDA7KVojIpxt2bXpDrPXDy+1+SFo1UmDicScrLYM
         zMwONHxsn17zt73vSiYKr9SZMHnBlaZrjTae0SP8mWOi/eF25HH51VffEqxtHS/QL95p
         DybWfkXYkSaiE0EE3txNhb3TeusLR/hWXijvt2Zx/lHLLslT4bDP8T1cRNQKaCfTISjo
         daBynVFGuEXPrTUfoHMfq26EU2kWajJF5Ow8pU+TIGp4SnZNINI3CLpns7xzb/DX+nGL
         Or96jrtJXeLdrPJFgVjKXMsACAeR/gFIQ1HJ761OBzSy2uMkbxWy2G2yH83WqUWK3zKs
         wb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147403; x=1775752203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vV+E8ILz/KFLO2ZZOB1e8mT2z2bGVYiI9vPMjVDtvWU=;
        b=MYO5pQp3b/frqWalLD/YWp+KC2jOKmJJcKPLOvnNlwnCvOCoP2q2RTmMlOFJ5oKwUM
         32QY7H5fRfVdX7v/7P+MAA+tqpU7LROfRXQ9Qm+jBGBMh+SisyPYvz5ZPcKTc6wS5xO6
         58rx3+oBSnEIg9kkJA9YNaRJmRX+PcicVWLCC7F5HttMBvBDPr17Bd4xFSCznMOMDNoN
         LnUpxmVmEmA/MpiY+zqbprjjzNIC9DNszOiCQg6qgyNRWfqOGnxAQgH1njk+lPg5KiXu
         oRP7Ihi7skXbcLAc8eZ1jZQjMEaEwhiEO2uPmI+0oZprwxuhmvsGAzYcXXMidV96GC1S
         xpQg==
X-Forwarded-Encrypted: i=1; AJvYcCXnuzaRU9p7188ByDZrFes4EVeLW23DaRL6/Cp2uO6REHoExB+Y1hGOLDx9AWb1Vzo1LjWD3rv8HXzXSCgK@vger.kernel.org
X-Gm-Message-State: AOJu0YxMMxwdOvVP782dTyKYrzmsMfMdB4X156KZRhP/yPfCtZ2pI6M1
	+qwDEECOUJcwOI+r1dJXTn+DQvWav8cAvMGUwwOns/eucquiR38RV+VK
X-Gm-Gg: ATEYQzxOK5ewvCcjKTNl2QgYRQwMOz7N7COMbyktxnOFKHY2w4dAEVmi2WQp/pfF7Zt
	MV8vPT1SVD6DJmJq3hxyfbfOItR6NZjpiUKyLfR3YLt75qbowwwGZOZb+QPL/8SHrTYorlLqlB6
	cbgyd1+WD+Tts/D/FDGXEKMFqsFfaw0pCsDybwT5jKJsuVCjrth3ohcDhiv4g3Io+eEO94z5Mbf
	FFOkb7BAXILKZrC4Yrk0S58vZL1GOy5Gf6nemxLh10SBf6EssyKvRUxuNjWMtfEhj0KBK2oqdLa
	8656rTaP0Y53U8lE7zTHo9JZw92jzzfnXXEW0GAc/FP7DAtgyzJDznQDZ8DxnVJrTI7hUBsBY9i
	p3mU171ltT23+N75wcRVHItiVHLbjtep0SGBO5i9mG/1FHX321hOzupTDhd8tkZ8+VyYdPZtcR5
	yBl0isBMiUc+iWonyWgA==
X-Received: by 2002:a05:6a00:c8b:b0:827:32dd:59c5 with SMTP id d2e1a72fcca58-82d0038878bmr3466846b3a.28.1775147403118;
        Thu, 02 Apr 2026 09:30:03 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:44::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9b2694csm3517639b3a.2.2026.04.02.09.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:02 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 08/14] fuse: move fuse_uring_abort() from header to dev_uring.c
Date: Thu,  2 Apr 2026 09:28:34 -0700
Message-ID: <20260402162840.2989717-9-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move fuse_uring_abort() out of the inline header definition and into
dev_uring.c. This function calls several internal helpers (abort
requests, stop queues) that are all defined in dev_uring.c so inlining
it in the header unnecessarily exposes implementation details.

This will make the subsequent commit that adds pinning capabilties for
fuse buffers cleaner.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 17 +++++++++++++++--
 fs/fuse/dev_uring_i.h | 16 +---------------
 2 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index a85acd9c2b71..cce8994241b7 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -129,7 +129,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
 	fuse_dev_end_requests(&req_list);
 }
 
-void fuse_uring_abort_end_requests(struct fuse_ring *ring)
+static void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 {
 	int qid;
 	struct fuse_ring_queue *queue;
@@ -477,7 +477,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 /*
  * Stop the ring queues
  */
-void fuse_uring_stop_queues(struct fuse_ring *ring)
+static void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
 
@@ -501,6 +501,19 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 	}
 }
 
+void fuse_uring_abort(struct fuse_conn *fc)
+{
+	struct fuse_ring *ring = fc->ring;
+
+	if (ring == NULL)
+		return;
+
+	if (atomic_read(&ring->queue_refs) > 0) {
+		fuse_uring_abort_end_requests(ring);
+		fuse_uring_stop_queues(ring);
+	}
+}
+
 /*
  * Handle IO_URING_F_CANCEL, typically should come on daemon termination.
  *
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce1..349418db3374 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -137,27 +137,13 @@ struct fuse_ring {
 
 bool fuse_uring_enabled(void);
 void fuse_uring_destruct(struct fuse_conn *fc);
-void fuse_uring_stop_queues(struct fuse_ring *ring);
-void fuse_uring_abort_end_requests(struct fuse_ring *ring);
+void fuse_uring_abort(struct fuse_conn *fc);
 int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
 void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req);
 bool fuse_uring_queue_bq_req(struct fuse_req *req);
 bool fuse_uring_remove_pending_req(struct fuse_req *req);
 bool fuse_uring_request_expired(struct fuse_conn *fc);
 
-static inline void fuse_uring_abort(struct fuse_conn *fc)
-{
-	struct fuse_ring *ring = fc->ring;
-
-	if (ring == NULL)
-		return;
-
-	if (atomic_read(&ring->queue_refs) > 0) {
-		fuse_uring_abort_end_requests(ring);
-		fuse_uring_stop_queues(ring);
-	}
-}
-
 static inline void fuse_uring_wait_stopped_queues(struct fuse_conn *fc)
 {
 	struct fuse_ring *ring = fc->ring;
-- 
2.52.0

