Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C433EF0B3
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147392; cv=none; b=BlB4fU9WYIx6GgpXFSrF3LYAqC6ZV6Juud1/hTBnghvAUC6ezy2DZtApBrjPKdwSxTn63u+bMh9FDBocfSdCA1JVMB3fu86jYcIgrRIpiNVtIvBBNQyxUZT9EFGYQHj4ksHGos4nO6Uw5Al2D6KzsDWbQm9UYx/PFUBgLBXPtEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147392; c=relaxed/simple;
	bh=bNojUduJx4mT8xAk13oYH5xzgiN1uT94k0vj14LLLfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPaikQSftkaLCxEGmg7w332bPO2/z8xj0gHiPA6Nmgicij4AvmFLPcWPs5Znwdf7sudCNt+hDK+bNSUWB/k1xAGrVFlQtM/7lGhzIXK9VDNJyPYoAmapM7sywJMx111pPCe6/8a9xKqNX1Q5nWg/T0SR7w/4bJXiQGzJ7iVz6KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxyEeeB8; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxyEeeB8"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b258576d8cso7117415ad.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147391; x=1775752191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tsp7R1CEM/G1ahxgdRVjeVwJWWxyvPo9ssp/26mb8g=;
        b=UxyEeeB8FKwXGWlZUU98A4snRequGrzhtIVugex4QG6kTDYXI9jTXK4ZaBZ11UGvWT
         kbOE/onqVBWApL0idKDTbPJL/A45abhVqrn8cOmJwJiFGIrNpDh096AUYvZbjPLlzSCK
         /49rIP93NA6cOias9BUP5MnSTNaltZlCsKqsm+QXEtzG6ubeO8i7/ji66wJ9BjwQSrRJ
         FZVqV3dpj8katcezP0a7l0XIvodrQJSZFOXj2VZzjE7dRTd6SBqrMpa/0+6MGOtubtI2
         NGJijxtkcTRtSyf6t7D4tFz+pZIv2kxGMnSJMOP6/73DBdazuKzWMvVPtlUWU2OTlCSb
         dMpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147391; x=1775752191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tsp7R1CEM/G1ahxgdRVjeVwJWWxyvPo9ssp/26mb8g=;
        b=eEaPDeQ+mg1W06p0QwEcPZ3PtMOuBU8bU79lkGhmiymDAUYMMJ1QnHuKIkZae5K2NF
         QyotcJ52hkUlS/rpJQWlgUCHS9HCJ5mua/gsmaJU8hiJklyTqHBWd1u9txDtIWNoT26I
         y/FMfq3cS9otJ0ghFT1z9RtpHwyePK8Io2wioSiQRo9fXUbEkmfXTfq2kTv6a61asOA6
         UjbCaddeokNfAI85dttmY0xFSBWua9+iifIlxJ6R0fWOOFUdTq2s5ruSNYoGQKVbqI4Q
         yAFmTNy5lxa8Jld/LNuTDSPzANKBMLOqKxpxW/7l8i5oDwEz60wePFgT+NfR4Qr5ysX0
         lTXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbnJRAJRHrFlgL3rVlwLH+D7IosyQNcxPaWJX+Kp3B4U11rRgk8WVwW4qDOslxg0cQouDVjNIZVIux1S45@vger.kernel.org
X-Gm-Message-State: AOJu0YyCPUiagZOjJ30SsBeuQftbl+zXwLharZO9wSg6fisICOEPy3UJ
	mSDCFNN7mZUXZl5MDDMKZBg7EMMcE561Dd8P8RMVFoZr962DQFpplwn7
X-Gm-Gg: AeBDieso7HcPBaP+g2Ed38eFaw9mcQbiSQid0gIWYmiFSU/zGQiPK2oOCqTNEwOHb+Z
	H5X/+WZP/EJArV67Vjc7OeM81bgLSsFE4Tq/YO6rCjLZFVps7JhZ6Xj80t6WGnDaneaPk8nOuhZ
	r7CsIe5p1+J0iVrgW7JelQS4Se4uNkJ/v9fl+2gZkdRZOt32bT69eQuw5sAGXsEC60o5crOSbRz
	+YWWKKY1fTLDmoneyhU9Lt4zAEnJB3BQmQ5JMwqeIEIK+ub5/neUQWBedjE4963xdeFYnbHAV3A
	9WgKtiMchwJ6rxIxWGKwnypxUale0M6COWgIjEiZWL3/Rer2YDGd3hlVsnvHa90HKgZaxCWfgkl
	/LJNIVHKgUX9LbOaMTAJwOH+yzPv8pWtDBFLw8V1I+nRd1f7IHkxj4xFvjFUI8Z118Yuxp117HU
	XZlfkug0lHQotYXeDggg==
X-Received: by 2002:a17:903:4b48:b0:2b2:4eec:980b with SMTP id d9443c01a7336-2b269a9cb00mr93927465ad.7.1775147390769;
        Thu, 02 Apr 2026 09:29:50 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af47sm51094655ad.42.2026.04.02.09.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:29:50 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org,
	Bernd Schubert <bschubert@ddn.com>
Subject: [PATCH v2 01/14] fuse: separate next request fetching from sending logic
Date: Thu,  2 Apr 2026 09:28:27 -0700
Message-ID: <20260402162840.2989717-2-joannelkoong@gmail.com>
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

Simplify the logic for fetching + sending off the next request.

This gets rid of fuse_uring_send_next_to_ring() which contained
duplicated logic from fuse_uring_send(). This decouples request fetching
from the send operation, which makes the control flow clearer and
reduces unnecessary parameter passing.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 78 ++++++++++++++++-----------------------------
 1 file changed, 28 insertions(+), 50 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3a38b61aac26..54436d3fda4d 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -714,34 +714,6 @@ static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 	return err;
 }
 
-/*
- * Write data to the ring buffer and send the request to userspace,
- * userspace will read it
- * This is comparable with classical read(/dev/fuse)
- */
-static int fuse_uring_send_next_to_ring(struct fuse_ring_ent *ent,
-					struct fuse_req *req,
-					unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-	int err;
-	struct io_uring_cmd *cmd;
-
-	err = fuse_uring_prepare_send(ent, req);
-	if (err)
-		return err;
-
-	spin_lock(&queue->lock);
-	cmd = ent->cmd;
-	ent->cmd = NULL;
-	ent->state = FRRS_USERSPACE;
-	list_move_tail(&ent->list, &queue->ent_in_userspace);
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, 0, issue_flags);
-	return 0;
-}
-
 /*
  * Make a ring entry available for fuse_req assignment
  */
@@ -838,11 +810,13 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
 }
 
 /*
- * Get the next fuse req and send it
+ * Get the next fuse req.
+ *
+ * Returns true if the next fuse request has been assigned to the ent.
+ * Else, there is no next fuse request and this returns false.
  */
-static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
-				     struct fuse_ring_queue *queue,
-				     unsigned int issue_flags)
+static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
+					 struct fuse_ring_queue *queue)
 {
 	int err;
 	struct fuse_req *req;
@@ -854,10 +828,12 @@ static void fuse_uring_next_fuse_req(struct fuse_ring_ent *ent,
 	spin_unlock(&queue->lock);
 
 	if (req) {
-		err = fuse_uring_send_next_to_ring(ent, req, issue_flags);
+		err = fuse_uring_prepare_send(ent, req);
 		if (err)
 			goto retry;
 	}
+
+	return req != NULL;
 }
 
 static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
@@ -875,6 +851,20 @@ static int fuse_ring_ent_set_commit(struct fuse_ring_ent *ent)
 	return 0;
 }
 
+static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
+			    ssize_t ret, unsigned int issue_flags)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+
+	spin_lock(&queue->lock);
+	ent->state = FRRS_USERSPACE;
+	list_move_tail(&ent->list, &queue->ent_in_userspace);
+	ent->cmd = NULL;
+	spin_unlock(&queue->lock);
+
+	io_uring_cmd_done(cmd, ret, issue_flags);
+}
+
 /* FUSE_URING_CMD_COMMIT_AND_FETCH handler */
 static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 				   struct fuse_conn *fc)
@@ -947,7 +937,8 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	 * and fetching is done in one step vs legacy fuse, which has separated
 	 * read (fetch request) and write (commit result).
 	 */
-	fuse_uring_next_fuse_req(ent, queue, issue_flags);
+	if (fuse_uring_get_next_fuse_req(ent, queue))
+		fuse_uring_send(ent, cmd, 0, issue_flags);
 	return 0;
 }
 
@@ -1196,20 +1187,6 @@ int fuse_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	return -EIOCBQUEUED;
 }
 
-static void fuse_uring_send(struct fuse_ring_ent *ent, struct io_uring_cmd *cmd,
-			    ssize_t ret, unsigned int issue_flags)
-{
-	struct fuse_ring_queue *queue = ent->queue;
-
-	spin_lock(&queue->lock);
-	ent->state = FRRS_USERSPACE;
-	list_move_tail(&ent->list, &queue->ent_in_userspace);
-	ent->cmd = NULL;
-	spin_unlock(&queue->lock);
-
-	io_uring_cmd_done(cmd, ret, issue_flags);
-}
-
 /*
  * This prepares and sends the ring request in fuse-uring task context.
  * User buffers are not mapped yet - the application does not have permission
@@ -1226,8 +1203,9 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	if (!tw.cancel) {
 		err = fuse_uring_prepare_send(ent, ent->fuse_req);
 		if (err) {
-			fuse_uring_next_fuse_req(ent, queue, issue_flags);
-			return;
+			if (!fuse_uring_get_next_fuse_req(ent, queue))
+				return;
+			err = 0;
 		}
 	} else {
 		err = -ECANCELED;
-- 
2.52.0

