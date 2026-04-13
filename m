Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF4F3AD538
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073286; cv=none; b=pt/lLgZpd6bdvgHh/iRPwqyE/o473CRp9C4CSta4/yMtnbj9xOYhCoBRLU2kpbrt626MNeEg9JqdpknqnpEa7rFiILkClxhfghly2QqFg5arzfjGtY4C9c+g5ESS0avNeOfTFXz7hAxROZL6cbM6nSMwqGfPVu9Y8SjQ45prKt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073286; c=relaxed/simple;
	bh=OrfoQlIt6JWg8z4zPVx4Jq0fOYAaI4GIOgRcZEDctn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CMGlPNkeLaFibTcP5XH5yo9Tjr4X/ZILlkwskYgfvgqPM+DD+4I7WlnclA47rZ1+FW6aUPXP4G5NrxCzSILAw/Fian9MOHunlRp8bcGd7XXLkGsiyMHfVD6/+uyh8479M55nhF63eTnjvu4O7g0O2+id6zanYXdXKut1B6PYOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfWOSkgD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfWOSkgD"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 339F0C2BCB3;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073286;
	bh=OrfoQlIt6JWg8z4zPVx4Jq0fOYAaI4GIOgRcZEDctn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=UfWOSkgD5mvSZ2qJwqA2mm2FIIpez2XSCLRAYaFrLL2NX03TJ6YGrES+V7c/5nQ8w
	 3lv1PcXnZSL5lyzAUIcfqJ4bOHid93ysPWKz0jdTWq76Ors5UafOgb3GOW6rTS05E5
	 Inedd8p3ajmcwbrHURo0SxOBkwCVuyb8i3x7tNXSI8xVhvt236D2E3GAg+sJo8wjxt
	 Po8NUqyymELvOmpccRpZhooq1HvjrhYlf97lB11Iz9XlHLcie8SqNllA0xlQ9Cccpm
	 KQ/bWaMy4lcpIGbIuRyLwJBPIRpCppHZiYBTFyVD/s5SSFpSWpqOMfjJaIvFiO6/MA
	 YdwX1vvNqa+2g==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283E7EBFD26;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
From: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Date: Mon, 13 Apr 2026 11:41:24 +0200
Subject: [PATCH v4 1/8] fuse: {io-uring} Add queue length counters
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-reduced-nr-ring-queues_3-v4-1-982b6414b723@bsbernd.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776073284; l=3147;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=uTJhPlsjaVGtlM6+oC7d+IJWVZ0tdbx8AF72z2h5kCo=;
 b=TDqE9TVdcGZNkLZ6ccD1IDBcrXSqqLOtn+QM/eu7726qD8nV80nEsiBpnPUfl+KRxI6M5NWED
 81DgVOvxP+8B3Ov6dyf5zj4tfMFwJJl2sV9OGY60dhQsacmuBxqcnAq
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-Endpoint-Received: by B4 Relay for bernd@bsbernd.com/20240529 with
 auth_id=732
X-Original-From: Bernd Schubert <bernd@bsbernd.com>
Reply-To: bernd@bsbernd.com

From: Bernd Schubert <bschubert@ddn.com>

This is another preparation and will be used for decision
which queue to add a request to.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
Reviewed-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c   | 17 +++++++++++++++--
 fs/fuse/dev_uring_i.h |  3 +++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 3a38b61aac26f7387cdcb7b2d81624e1ac9ececa..f2f1e10da3429748da87884ac6d1f53613d41bc4 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -87,13 +87,13 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
 	spin_lock(&queue->lock);
 	ent->fuse_req = NULL;
 	list_del_init(&req->list);
+	queue->nr_reqs--;
 	if (test_bit(FR_BACKGROUND, &req->flags)) {
 		queue->active_background--;
 		spin_lock(&fc->bg_lock);
 		fuse_uring_flush_bg(queue);
 		spin_unlock(&fc->bg_lock);
 	}
-
 	spin_unlock(&queue->lock);
 
 	if (error)
@@ -113,6 +113,7 @@ static void fuse_uring_abort_end_queue_requests(struct fuse_ring_queue *queue)
 	list_for_each_entry(req, &queue->fuse_req_queue, list)
 		clear_bit(FR_PENDING, &req->flags);
 	list_splice_init(&queue->fuse_req_queue, &req_list);
+	queue->nr_reqs = 0;
 	spin_unlock(&queue->lock);
 
 	/* must not hold queue lock to avoid order issues with fi->lock */
@@ -1287,10 +1288,13 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
+	queue->nr_reqs++;
+
 	if (ent)
 		fuse_uring_add_req_to_ring_ent(ent, req);
 	else
 		list_add_tail(&req->list, &queue->fuse_req_queue);
+
 	spin_unlock(&queue->lock);
 
 	if (ent)
@@ -1326,6 +1330,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	set_bit(FR_URING, &req->flags);
 	req->ring_queue = queue;
 	list_add_tail(&req->list, &queue->fuse_req_bg_queue);
+	queue->nr_reqs++;
 
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
@@ -1358,8 +1363,16 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 bool fuse_uring_remove_pending_req(struct fuse_req *req)
 {
 	struct fuse_ring_queue *queue = req->ring_queue;
+	bool removed = fuse_remove_pending_req(req, &queue->lock);
 
-	return fuse_remove_pending_req(req, &queue->lock);
+	if (removed) {
+		/* Update counters after successful removal */
+		spin_lock(&queue->lock);
+		queue->nr_reqs--;
+		spin_unlock(&queue->lock);
+	}
+
+	return removed;
 }
 
 static const struct fuse_iqueue_ops fuse_io_uring_ops = {
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 51a563922ce14158904a86c248c77767be4fe5ae..c63bed9f863d53d4ac2bed7bfbda61941cd99083 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -94,6 +94,9 @@ struct fuse_ring_queue {
 	/* background fuse requests */
 	struct list_head fuse_req_bg_queue;
 
+	/* number of requests queued or in userspace */
+	unsigned int nr_reqs;
+
 	struct fuse_pqueue fpq;
 
 	unsigned int active_background;

-- 
2.43.0


