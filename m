Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A63C6A2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 22:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774392380; cv=none; b=SZTC4mFEu70iqp1mhcht6yGnGagyQKzJLoz9gunVYaMYvxxw9VgO1bMCWYxKynRu5iah9DEbhzDIPTWbBTibWb+QYQVWw61gy5vxWEadbk/mGeVy5xDknnMVAteQHQ+lGWZ5QNdIRqJRzPdYw1LZK9bCD87qBfZofdFHAQ/szWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774392380; c=relaxed/simple;
	bh=bNojUduJx4mT8xAk13oYH5xzgiN1uT94k0vj14LLLfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=meGTLvgG53c3NOs2tDwRUx4nb3dJmxXGBvhHmQXWKX01gaGHqA45u2CHT4Pq9LkKJoIHI16Q3/C2A+s0XSs/1Zc0w5cubLllgzoezjq+1f5x/9a9Cq6gofn338oc0nyHPFPJqyZEX2/uGa11k0u/m+ac+kHwq1aRwmHfCo3EPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ICZBXSVn; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICZBXSVn"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2aae146b604so39606475ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 15:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774392379; x=1774997179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/tsp7R1CEM/G1ahxgdRVjeVwJWWxyvPo9ssp/26mb8g=;
        b=ICZBXSVnnFx71vS++eFjN9E8zaYMwQWZKRP4cvqgTbeSP/I3HYzZ8w4yaHRRPh0IhR
         n+5CydzH9dXoc3DD+WQGfxdvICm1RZOXCpYd/9wW/uNBf33sbiHIIcSqI59TG2IkkWIo
         Xh37VAQ7IROztFChE0L/V8S8HJNGnW2CorywzfJblwpI2HP0IlxG/oYNyLxrxj53xOjJ
         MFQlwgGcZlyVR5WLQoAmr10rHnzBzzSB/3rW45ioZYaOUpn02x/N7idApsn4Qz18b4k7
         Ow1IBbt6R5yckSxFeGSWfUKj7A9b54tpfJHaxK+5+cY2MV4RxIHqXUcop0TCIN6X062j
         XxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774392379; x=1774997179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/tsp7R1CEM/G1ahxgdRVjeVwJWWxyvPo9ssp/26mb8g=;
        b=n55qSAszWPtoj8ZL84ALdJToyWfahngwfos7PWIEduW06pLCTZX+IOZDuG7X4Inv0+
         fAifBumew2C1acsMxUYxUuckxRMl9XaNZbuccyQlMMfgv5ExnakzhXbL4R5F3l83/dBX
         eDqTZqcwW/OfC/HKLeuVIUn0dN8THO42g2eey2IhrWRBs64J+GlfoxtT0pgu3B6yNHaR
         AGqQKnZu1FxYhFbenvZ6BDeXtyJjiCrgUu+y8lSbtydKtF3ov3XyJin7lPQ+d2LJQQQo
         tT81TLg9DeIAhJmiT4C3y27ICzORMhoD22eDBYWHG1EgnVEuWrbJS3sraZ7YAWTW4QZu
         ECPw==
X-Forwarded-Encrypted: i=1; AJvYcCWuy0z8nLx6R2JVxfsTKvKsMoYUCzI5NLp9v3ThD901e4/CC0+Pqjt4f70C+Ic9gyiM1ecSSJWiX+LbwkrY@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4JtaKRk6+CTl0UjeTq7YfnmOf6Qv+Luon8cG5lHWYHvXGwWE
	5OhX1siYiG3MqO+ZuWHrDvKZ19IPcKC5rf0Q+CCwkEZ9eclp0V7AgOsJ
X-Gm-Gg: ATEYQzxeDLpyM8uVMoNETNA1uY9cHDu4dqwrezdQTXpPDM0x+uwXrks44z4uYcQtm/h
	9ozFJjjXNaK0Tx4dgzeoLdE+gnRpRim4IqY7QgbuiB8C+ccHXY9Snl0zZJQ/SuEr01jJItZs9Eg
	LKWSZQpOC8P9yoxEcWdh9L0wFhok0cOzi6DnQ7nfJLtUwGvHDPUyYV1NymuMGOiAoFlO/VT/1x3
	4LcAx7L1xNf9fMlBYCy04zTIRAcAXeVbEURcw47fA+qjnYDjHeEciVvJZ/JM/QY5e7phJj1z9DP
	Fzi3Y8vMwCD/RcQw3guk6bZkzztGOt4I4chlYLFRCW+bCk3RcrcrNCp1v30JK5NkS8DLHlpJFK6
	uCDIm4p4YuvleiFL1BJyrmcaMC8xfnNTr5lSStnXSjSQrERlur3eSoWgQKYIlOmnlddYmrgqG7q
	5nGrfpvhwf+pji9gmr
X-Received: by 2002:a17:903:1248:b0:2ae:483f:b23c with SMTP id d9443c01a7336-2b0b0afa1d8mr13304695ad.36.1774392378674;
        Tue, 24 Mar 2026 15:46:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08340c2edsm183507145ad.0.2026.03.24.15.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 15:46:18 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: axboe@kernel.dk
Cc: miklos@szeredi.hu,
	bschubert@ddn.com,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v1 1/9] fuse: separate next request fetching from sending logic
Date: Tue, 24 Mar 2026 15:45:24 -0700
Message-ID: <20260324224532.3733468-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260324224532.3733468-1-joannelkoong@gmail.com>
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
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

