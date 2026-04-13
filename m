Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600543A383B
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073286; cv=none; b=R1dFe2hCOnG3CTta+hjPxrwQhP3JvIQjniUJ+diWDOA2/ivShJc+WlxbuKOK2Xh9z7CskcQJ7lZBPFc3uWpP+IqPUVNrFcQF+3r6LZLyfkrRbPi9kdRH3I0Ru0HXpX7+3zvOTFxV9HHoJpDOO4dO/ItfbcVOhlcGwbUcVB19Em4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073286; c=relaxed/simple;
	bh=K33T9R4r2TIr0oCPR2FAnoE/1fLyns70acY3zlE59ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iIHGm+U1jWMFsVPiiQtsnx9vrIeHAZTy5XiXZhm3hlxCtheJgs8PQY2hKtfH7d9hjZxxChk4Tcz69nocjKg02mxZ5E+4F9nt9qcWCXgPEE4LiS8ua4DcEGHLxyNjfzPtj4WtEiv9RmSkjkF/DYCyhWpPGIKd9xgghUlHlPR1g1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5j/p3ax; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5j/p3ax"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43336C116C6;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073286;
	bh=K33T9R4r2TIr0oCPR2FAnoE/1fLyns70acY3zlE59ok=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=k5j/p3axA83GWUuEWPdqREa8qjUGgkl+Xd3Ts9+BEKi2nuYfuAEuI1EWZ6c09SNVY
	 Pj8HU7n/sxITQ9Tn6/PsMiaUxgsU0Hio22h3MxmVQAk4sgqRPySuBH1Jaq1R90JigB
	 9aHvg8pMJPhQ7jcY1TkTby3wkXNolwt91cz3zDmUTyrHG0ZWc/t6/godnBojWQqaEv
	 M6s1CHZr5hFcEZH9sv+wslxsmh03L2errF2muvoWDVoNRaW9o615S4IcwWefu+PwK7
	 32eRjvZrglfBgKhwLtfMWeXf9pXCHAL1DLUi5eD08QK4bvu4ntBc4zMhQ5SMJhuamz
	 HwJnh9v1rpajw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360F6EBFD28;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
From: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Date: Mon, 13 Apr 2026 11:41:25 +0200
Subject: [PATCH v4 2/8] fuse: {io-uring} Rename ring->nr_queues to
 max_nr_queues
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-reduced-nr-ring-queues_3-v4-2-982b6414b723@bsbernd.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776073284; l=4316;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=cj91ptzVT7S1ahTHeSWyOVvd903WD6yNwW5LmwkDWTM=;
 b=KMSDM0KTmJEoliiUNrqcSTtXv0qLFO9tE5XsoeZ+VWp+bJb5tmmv0S4CkEYKTdyi2KEFV89m8
 C6U+14+6TilCrBjbEUKBt49n3BL+OeCO2Q7wFQFfwdd/1mLVxvm2RTo
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-Endpoint-Received: by B4 Relay for bernd@bsbernd.com/20240529 with
 auth_id=732
X-Original-From: Bernd Schubert <bernd@bsbernd.com>
Reply-To: bernd@bsbernd.com

From: Bernd Schubert <bschubert@ddn.com>

This is preparation for follow up commits that allow to run with a
reduced number of queues.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c   | 24 ++++++++++++------------
 fs/fuse/dev_uring_i.h |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index f2f1e10da3429748da87884ac6d1f53613d41bc4..08c49e5b65ee950a9749a034b1e9d0a8883e1d31 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -126,7 +126,7 @@ void fuse_uring_abort_end_requests(struct fuse_ring *ring)
 	struct fuse_ring_queue *queue;
 	struct fuse_conn *fc = ring->fc;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -167,7 +167,7 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
 	if (!ring)
 		return false;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		queue = READ_ONCE(ring->queues[qid]);
 		if (!queue)
 			continue;
@@ -194,7 +194,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 	if (!ring)
 		return;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 		struct fuse_ring_ent *ent, *next;
 
@@ -254,7 +254,7 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
 
 	init_waitqueue_head(&ring->stop_waitq);
 
-	ring->nr_queues = nr_queues;
+	ring->max_nr_queues = nr_queues;
 	ring->fc = fc;
 	ring->max_payload_sz = max_payload_size;
 	smp_store_release(&fc->ring, ring);
@@ -406,7 +406,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring *ring)
 	int qid;
 	struct fuse_ring_ent *ent;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = ring->queues[qid];
 
 		if (!queue)
@@ -437,7 +437,7 @@ static void fuse_uring_async_stop_queues(struct work_struct *work)
 		container_of(work, struct fuse_ring, async_teardown_work.work);
 
 	/* XXX code dup */
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -472,7 +472,7 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
 {
 	int qid;
 
-	for (qid = 0; qid < ring->nr_queues; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues; qid++) {
 		struct fuse_ring_queue *queue = READ_ONCE(ring->queues[qid]);
 
 		if (!queue)
@@ -895,7 +895,7 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	if (!ring)
 		return err;
 
-	if (qid >= ring->nr_queues)
+	if (qid >= ring->max_nr_queues)
 		return -EINVAL;
 
 	queue = ring->queues[qid];
@@ -958,7 +958,7 @@ static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
 	struct fuse_ring_queue *queue;
 	bool ready = true;
 
-	for (qid = 0; qid < ring->nr_queues && ready; qid++) {
+	for (qid = 0; qid < ring->max_nr_queues && ready; qid++) {
 		if (current_qid == qid)
 			continue;
 
@@ -1100,7 +1100,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 			return err;
 	}
 
-	if (qid >= ring->nr_queues) {
+	if (qid >= ring->max_nr_queues) {
 		pr_info_ratelimited("fuse: Invalid ring qid %u\n", qid);
 		return -EINVAL;
 	}
@@ -1244,9 +1244,9 @@ static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
 
 	qid = task_cpu(current);
 
-	if (WARN_ONCE(qid >= ring->nr_queues,
+	if (WARN_ONCE(qid >= ring->max_nr_queues,
 		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
-		      ring->nr_queues))
+		      ring->max_nr_queues))
 		qid = 0;
 
 	queue = ring->queues[qid];
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index c63bed9f863d53d4ac2bed7bfbda61941cd99083..708412294982566919122a1a0d7f741217c763ce 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -113,7 +113,7 @@ struct fuse_ring {
 	struct fuse_conn *fc;
 
 	/* number of ring queues */
-	size_t nr_queues;
+	size_t max_nr_queues;
 
 	/* maximum payload/arg size */
 	size_t max_payload_sz;

-- 
2.43.0


