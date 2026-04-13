Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2A3B19AE
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073286; cv=none; b=lC7jCq3Ppf/DOJrm8W3g6Yuyre1ppBL/OOn/b/ClfZhrkINKNTPnmJZqhCo0Q07h/bwv6QWsyAkJq/mg5ntzGtuI0Z4gKu3b8ppSU3brQQ1Bjnw1LwvLNZfU4e08Ebm/bZWwrNjmMd3hKDuBgMia3pfnD9QHips3qzkw9SWIeqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073286; c=relaxed/simple;
	bh=HLLq7Wuuu38Zz0+YN7FamW9mMFkiLSITGz1PgkmGrvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dTe+RPa3fTIxOyJCN748AoqHqaa7tzH9rkJf6BtXI/h7si1KG20GV9v4EqR6QepgpMkTQpzC5EVJlufZH9MmCgnsdMypvM0sj/MTJqHFkjhz0wO4Us80BNKDuU0+m1/bx6CWau6QamkCGIW8t4zGbXt/4TzkNO5Q5snHtneKzK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tn8XNnob; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tn8XNnob"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 74E68C2BCB8;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776073286;
	bh=HLLq7Wuuu38Zz0+YN7FamW9mMFkiLSITGz1PgkmGrvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=tn8XNnobQqmJFIqzVdWEbU4VCZY68aK7h53We4wU2ss9oOHdtsx/UGQe1StVS1NNd
	 FvmKXCM5ue3NTIM1cjk9D5rlQiY2w8ER6SW+2wXi64dFb3UJfFzYFbwhrPKT1S9bdi
	 ISPEaPPrCbK2el2JrQ8qG6xVQQVdkS0xRxUACpHVXy5aQemuTMBAbrSboT3+sPyWgc
	 x26EEZInd5TeETvrJxKaA8YUucjySgAnLnFp5/VfMKl+O31vBtC3Pz1QNLO1Asx4B9
	 nOHg6qP53whyGxlVd4t/pmCk+EtiG+0nJVLm7+ZbXkCFom43LcvkpAEvlmQCzOoFW9
	 24wGDNcYEu2og==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D9ACEBFD28;
	Mon, 13 Apr 2026 09:41:26 +0000 (UTC)
From: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Date: Mon, 13 Apr 2026 11:41:29 +0200
Subject: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Joanne Koong <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org, 
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, 
 Bernd Schubert <bschubert@ddn.com>
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776073284; l=4063;
 i=bernd@bsbernd.com; s=20240529; h=from:subject:message-id;
 bh=mMDlImRJRlCeDhI9Ouod3ahQjmVI7gKwtzW3G1Ryeig=;
 b=Uax68Ou2B6FhDCOYgGC62V1K0FbG0Hj81OzlwJ13XNRHPL05bUVuyuIppP8GC+XzlnDn+Ew9H
 +FcIRoSb9OOAKa4X3ACmNLcb9M4I13vSkR5mRUPceRF5dRemY8Y8ao6
X-Developer-Key: i=bernd@bsbernd.com; a=ed25519;
 pk=EZVU4bq64+flgoWFCVQoj0URAs3Urjno+1fIq9ZJx8Y=
X-Endpoint-Received: by B4 Relay for bernd@bsbernd.com/20240529 with
 auth_id=732
X-Original-From: Bernd Schubert <bernd@bsbernd.com>
Reply-To: bernd@bsbernd.com

From: Bernd Schubert <bschubert@ddn.com>

Running background IO on a different core makes quite a difference.

fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
--bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
--runtime=30s --group_reporting --ioengine=io_uring\
 --direct=1

unpatched
   READ: bw=272MiB/s (285MB/s) ...
patched
   READ: bw=650MiB/s (682MB/s)

Reason is easily visible, the fio process is migrating between CPUs
when requests are submitted on the queue for the same core.

With --iodepth=8

unpatched
   READ: bw=466MiB/s (489MB/s)
patched
   READ: bw=641MiB/s (672MB/s)

Without io-uring (--iodepth=8)
   READ: bw=729MiB/s (764MB/s)

Without fuse (--iodepth=8)
   READ: bw=2199MiB/s (2306MB/s)

(Test were done with
<libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
[-o io_uring] /tmp/source /tmp/dest
)

Additional notes:

With FURING_NEXT_QUEUE_RETRIES=0 (--iodepth=8)
   READ: bw=903MiB/s (946MB/s)

With just a random qid (--iodepth=8)
   READ: bw=429MiB/s (450MB/s)

With --iodepth=1
unpatched
   READ: bw=195MiB/s (204MB/s)
patched
   READ: bw=232MiB/s (243MB/s)

With --iodepth=1 --numjobs=2
unpatched
   READ: bw=366MiB/s (384MB/s)
patched
   READ: bw=472MiB/s (495MB/s)

With --iodepth=1 --numjobs=8
unpatched
   READ: bw=1437MiB/s (1507MB/s)
patched
   READ: bw=1529MiB/s (1603MB/s)
fuse without io-uring
   READ: bw=1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
no-fuse
   READ: bw=2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...

In summary, for async requests the core doing application IO is busy
sending requests and processing IOs should be done on a different core.
Spreading the load on random cores is also not desirable, as the core
might be frequency scaled down and/or in C1 sleep states. Not shown here,
but differnces are much smaller when the system uses performance govenor
instead of schedutil (ubuntu default). Obviously at the cost of higher
system power consumption for performance govenor - not desirable either.

Results without io-uring (which uses fixed libfuse threads per queue)
heavily depend on the current number of active threads. Libfuse uses
default of max 10 threads, but actual nr max threads is a parameter.
Also, no-fuse-io-uring results heavily depend on, if there was already
running another workload before, as libfuse starts these threads
dynamically - i.e. the more threads are active, the worse the
performance.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
---
 fs/fuse/dev_uring.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb51dd6957fe1704ec87 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
 	fuse_uring_send(ent, cmd, err, issue_flags);
 }
 
-static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
+static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
+						       bool background)
 {
 	unsigned int qid;
 	int node;
 	unsigned int nr_queues;
 	unsigned int cpu = task_cpu(current);
 
+	/*
+	 *  Background requests result in better performance on a different
+	 *  CPU, unless CPUs are already busy.
+	 */
+	if (background)
+		cpu++;
+
 	cpu = cpu % ring->max_nr_queues;
 
 	/* numa local registered queue bitmap */
@@ -1356,7 +1364,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	int err;
 
 	err = -EINVAL;
-	queue = fuse_uring_select_queue(ring);
+	queue = fuse_uring_select_queue(ring, false);
 	if (!queue)
 		goto err;
 
@@ -1400,7 +1408,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent = NULL;
 
-	queue = fuse_uring_select_queue(ring);
+	queue = fuse_uring_select_queue(ring, true);
 	if (!queue)
 		return false;
 

-- 
2.43.0


