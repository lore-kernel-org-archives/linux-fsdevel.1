Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E633F0AB8
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Apr 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775147409; cv=none; b=iO6JilZmAENUMndjbcQPXLZsSV8Uc6MxoAdqgboI4fgLPPNccTuWk4IthByjFivSqEqYL/MY0NxlZkzEC+qonFIajuXE3FO+PJKslxu1/4AjL2mit00RZW4Iv2kKIxcL35Lkb14t2ODHbUU6a8kSvIq+SlnA3N1lxmyzaB9p6O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775147409; c=relaxed/simple;
	bh=HwbwgHFw+UQSlb2mY6TcwQpSw4buAc+mKdgZtEAZc0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+KTJnT2gF4df5ZWRYT0gcvegbxA91zRtNLfOxBPIyNFiBCKtvUjo8rihV6j6T4MXLFVlrU8NTWoPMpKgr4XKjWDB4Y1aUCmr/9uE8K1Wh5dWtMVSOOJ7cfsp3yqXFdb+ebrcMUZrmba7Rc/VJFBQsy9TYaEDqdNMWyXqpHjFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikXwCPr1; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikXwCPr1"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad617d5b80so6004045ad.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Apr 2026 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775147407; x=1775752207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bPuivHlwfeJGbRoRA2kkYktzOwR04vbxGKEMijs6124=;
        b=ikXwCPr1lT/WxcHJxMA2WL2wPZQILsSsz4YwbeDdpwCy0R9udKCX8eZ7DQV2MN6e9G
         8ktALJ0caC7bFGR8R9EmQLelbcfDZGMgu8GmzM1Mm93ZMx9yqlweoSAftrZ5T89jfLL3
         QYyyKWayn3sXhQao7DslmKHv1mbYjxpR6se6x+N7XL7ozBL8ZwezH5dE/l5SpmFckV/o
         xxBKeaSpH8//MOpPHlbaGwlcpwMRTq0uadfYs69QYPjdXi/LHEkOdSu+bQO7L50OyBWg
         NrqZeJNi21BvJPReWrWwBG9zsw782Mvt1DaacWaHrx+CAITpHQV+g+r3jrmnBwfo8ySh
         JUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775147407; x=1775752207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bPuivHlwfeJGbRoRA2kkYktzOwR04vbxGKEMijs6124=;
        b=BJhGqC35XZbvO9955eY6v+3AQ+985s6rtY6qVXRcRfiGyARAZWxPr95VFLsbWk6dFo
         Ab3oxnN7ffFKlYX0tyixWnMOoWOFrN5mBxFrvSmtHLFoxXnF03dqmt1111si0dFakDKU
         P6KoGxLWbPACzxfq14PkIdmSlb2lNFu+/7EeAgg6J/PfyWpJWWl0Ws+qBMq4Hmgu3Gld
         8GswGxColdNcQQgwfZPz+6c8MMkNpGC7IN0VBCwjoortyarmPeCYqQgIyEJ5nYDuKcBZ
         2gNVTf5pdSDUGqdSG4LsK+4kc0Pz0+/4PNT90lYnili69NubTm7G5l7QjCfcXHkzyl7K
         OdiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQ7hxBXc6ZrCIarFcfiKJisfaJtG/mIXsZpe8VycVVAxFW3dg3I5VyXQ2R70SE1qZweWV+xquR/2aSbe7o@vger.kernel.org
X-Gm-Message-State: AOJu0YxDIbtXwvDzooQDJVSf6ZczO3nKbZ/HiUChq7yN2eSndL1k5oB1
	V85DQsn818dI7pXJhRn1yJ7hoAjIfsxGkC4TFLruXuqX6BsjhvQ5bY1jSQ3+ag==
X-Gm-Gg: AeBDievyMqELbYYP2i4rDBnYcgLUjs+0X6DOMvpMQFAK4E416Y43scdJe4TmhgGmIKe
	WHIAg6r0cvF1einVrqL/wJE5MtGUC0fIz9SmqeGuSYx2M89C1jRCkW5EiBytl+MQ2S3jiz+ImXv
	HtS1KQMX2x9aZlqQE6p4mEicWvcVQc3ovUMEaZv3zw8X2OE0VIAGXfA4M/CdH5Z2cq4F0viPkn/
	zS702Oc2C6TboEC+JVJZH7qOT4lhs5im4cmlm8P1rLG/+e50DfV7tCb/SoJVPFcjNpi1JR0/5WV
	A5TaRbtdaUH/EaJioXMex9koa+AdZQUNGmU5gl+TA+xXjouhGWwhEo0dmlbCOzVkOyPjc9vfdKH
	HHSv6LKtFkQsqWAA33N0NQtyiQl7gRKWlfWOPEBPVkF2NmY5I2iQhm+/R4S/JAPDIZ9rINDFuZF
	LslSRg5iq/qlIjEliRVQ==
X-Received: by 2002:a17:903:1b06:b0:2b0:4a57:e480 with SMTP id d9443c01a7336-2b269cba4b4mr86327455ad.45.1775147406584;
        Thu, 02 Apr 2026 09:30:06 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b274756621sm33160235ad.20.2026.04.02.09.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 09:30:06 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: miklos@szeredi.hu
Cc: bernd@bsbernd.com,
	axboe@kernel.dk,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 10/14] fuse: add io-uring buffer rings
Date: Thu,  2 Apr 2026 09:28:36 -0700
Message-ID: <20260402162840.2989717-11-joannelkoong@gmail.com>
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

Add fuse buffer rings for servers communicating through the io-uring
interface. To use this, the server must set the FUSE_URING_BUFRING
flag and provide header and payload buffers via an iovec array in the
sqe during registration. The payload buffers are used to back the buffer
ring. The kernel manages buffer selection and recycling through a simple
internal ring.

This has the following advantages over the non-bufring (iovec) path:
- Reduced memory usage: in the iovec path, each entry has its own
  dedicated payload buffer, requiring N buffers for N entries where each
  buffer must be large enough to accommodate the maximum possible
  payload size. With buffer rings, payload buffers are pooled and
  selected on demand. Entries only hold a buffer while actively
  processing a request with payload data. When incremental buffer
  consumption is added, this will allow non-overlapping regions of a
  single buffer to be used simultaneously across multiple requests,
  further reducing memory requirements.
- Foundation for pinned buffers: the buffer ring headers and payloads
  are now each passed in as a contiguous memory allocation, which allows
  fuse to easily pin and vmap the entire region in one operation during
  queue setup. This will eliminate the per-request overhead of having to
  pin/unpin user pages and translate virtual addresses and is a
  prerequisite for future optimizations like performing data copies
  outside of the server's task context.

Each ring entry gets a fixed ID (sqe->buf_index) that maps to a specific
header slot in the headers buffer. Payload buffers are selected from
the ring on demand and recycled after each request. Buffer ring usage is
set on a per-queue basis. All subsequent registration SQEs for the same
queue must use consistent flags.

The headers are laid out contiguously and provided via iov[0]. Each slot
maps to ent->id:

|<- headers_size (>= queue_depth * sizeof(fuse_uring_req_header)) ->|
+------------------------------+------------------------------+-----+
| struct fuse_uring_req_header | struct fuse_uring_req_header | ... |
|        [ent id=0]            |        [ent id=1]            |     |
+------------------------------+------------------------------+-----+

On the server side, the ent id is used to determine where in the headers
buffer the headers data for the ent resides. This is done by
calculating ent_id * sizeof(struct fuse_uring_req_header) as the offset
into the headers buffer.

The buffer ring is backed by the payload buffer, which is contiguous but
partitioned into individual bufs according to the buf_size passed in at
registration.

  PAYLOAD BUFFER POOL (contiguous, provided via iov[1]):
    |<-------------- payload_size ------------>|
    +--------- --+-----------+-----------+-----+
    |  buf [0]   |  buf [1]  |  buf [2]  | ... |
    |  buf_size  |  buf_size |  buf_size | ... |
    +--------- --+-----------+-----------+-----+

buffer ring state (struct fuse_bufring, kernel-internal):
bufs[]: [ used | used | FREE | FREE | FREE ]
			^^^^^^^^^^^^^^^^^^^
			available for selection

The buffer ring logic is as follows:
select:  buf = bufs[head % nbufs]; head++
recycle: bufs[tail % nbufs] = buf; tail++
empty:   tail == head (no buffers available)
full:    tail - head >= nbufs

Buffer ring request flow
------------------------
|  Kernel                                  |  FUSE daemon
|                                          |
|  [client request arrives]                |
|  >fuse_uring_send()                      |
|    [select payload buf from ring]        |
|    >fuse_uring_select_buffer()           |
|    [copy headers to ent's header slot]   |
|    >copy_header_to_ring()                |
|    [copy payload to selected buf]        |
|    >fuse_uring_copy_to_ring()            |
|    [set buf_id in ent_in_out header]     |
|    >io_uring_cmd_done()                  |
|                                          |  [CQE received]
|                                          |  [read headers from header
|                                          |    slot]
|                                          |  [read payload from buf_id]
|                                          |  [process request]
|                                          |  [write reply to header
|                                          |    slot]
|                                          |  [write reply payload to
|                                          |    buf]
|                                          |  >io_uring_submit()
|                                          |   COMMIT_AND_FETCH
|  >fuse_uring_commit_fetch()              |
|    >fuse_uring_commit()                  |
|     [copy reply from ring]               |
|     >fuse_uring_recycle_buffer()         |
|    >fuse_uring_get_next_fuse_req()       |

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/dev_uring.c       | 363 +++++++++++++++++++++++++++++++++-----
 fs/fuse/dev_uring_i.h     |  45 ++++-
 include/uapi/linux/fuse.h |  27 ++-
 3 files changed, 381 insertions(+), 54 deletions(-)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index a061f175b3fd..9f14a2bcde3f 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -41,6 +41,11 @@ enum fuse_uring_header_type {
 	FUSE_URING_HEADER_RING_ENT,
 };
 
+static inline bool bufring_enabled(struct fuse_ring_queue *queue)
+{
+	return queue->bufring != NULL;
+}
+
 static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
 				   struct fuse_ring_ent *ring_ent)
 {
@@ -222,6 +227,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
 		}
 
 		kfree(queue->fpq.processing);
+		kfree(queue->bufring);
 		kfree(queue);
 		ring->queues[qid] = NULL;
 	}
@@ -303,20 +309,102 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
 	return 0;
 }
 
-static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
-						       int qid)
+static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
+				     struct fuse_ring_queue *queue)
+{
+	const struct fuse_uring_cmd_req *cmd_req =
+		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
+	u16 queue_depth = READ_ONCE(cmd_req->init.queue_depth);
+	unsigned int buf_size = READ_ONCE(cmd_req->init.buf_size);
+	struct iovec iov[FUSE_URING_IOV_SEGS];
+	void __user *payload, *headers;
+	size_t headers_size, payload_size, ring_size;
+	struct fuse_bufring *br;
+	unsigned int nr_bufs, i;
+	uintptr_t payload_addr;
+	int err;
+
+	if (!queue_depth || !buf_size)
+		return -EINVAL;
+
+	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
+	if (err)
+		return err;
+
+	headers = iov[FUSE_URING_IOV_HEADERS].iov_base;
+	headers_size = iov[FUSE_URING_IOV_HEADERS].iov_len;
+	payload = iov[FUSE_URING_IOV_PAYLOAD].iov_base;
+	payload_size = iov[FUSE_URING_IOV_PAYLOAD].iov_len;
+
+	/* check if there's enough space for all the headers */
+	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
+		return -EINVAL;
+
+	if (buf_size < queue->ring->max_payload_sz)
+		return -EINVAL;
+
+	nr_bufs = payload_size / buf_size;
+	if (!nr_bufs || nr_bufs > U16_MAX)
+		return -EINVAL;
+
+	/* create the ring buffer */
+	ring_size = struct_size(br, bufs, nr_bufs);
+	br = kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
+	if (!br)
+		return -ENOMEM;
+
+	br->queue_depth = queue_depth;
+	br->headers = headers;
+
+	payload_addr = (uintptr_t)payload;
+
+	/* populate the ring buffer */
+	for (i = 0; i < nr_bufs; i++, payload_addr += buf_size) {
+		struct fuse_bufring_buf *buf = &br->bufs[i];
+
+		buf->addr = payload_addr;
+		buf->len = buf_size;
+		buf->id = i;
+	}
+
+	br->nbufs = nr_bufs;
+	br->tail = nr_bufs;
+
+	queue->bufring = br;
+
+	return 0;
+}
+
+/*
+ * if the queue is already registered, check that the queue was initialized with
+ * the same init flags set for this FUSE_IO_URING_CMD_REGISTER cmd. all
+ * FUSE_IO_URING_CMD_REGISTER cmds should have the same init fields set on a
+ * per-queue basis.
+ */
+static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
+					u64 init_flags)
 {
+	bool bufring = init_flags & FUSE_URING_BUFRING;
+
+	return bufring_enabled(queue) == bufring;
+}
+
+static struct fuse_ring_queue *
+fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
+			int qid, u64 init_flags)
+{
+	bool use_bufring = init_flags & FUSE_URING_BUFRING;
 	struct fuse_conn *fc = ring->fc;
 	struct fuse_ring_queue *queue;
 	struct list_head *pq;
 
 	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
 	if (!queue)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
 	if (!pq) {
 		kfree(queue);
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	queue->qid = qid;
@@ -334,12 +422,29 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
 	queue->fpq.processing = pq;
 	fuse_pqueue_init(&queue->fpq);
 
+	if (use_bufring) {
+		int err = fuse_uring_bufring_setup(cmd, queue);
+
+		if (err) {
+			kfree(pq);
+			kfree(queue);
+			return ERR_PTR(err);
+		}
+	}
+
 	spin_lock(&fc->lock);
+	/* check if the queue creation raced with another thread */
 	if (ring->queues[qid]) {
 		spin_unlock(&fc->lock);
 		kfree(queue->fpq.processing);
+		if (use_bufring)
+			kfree(queue->bufring);
 		kfree(queue);
-		return ring->queues[qid];
+
+		queue = ring->queues[qid];
+		if (!queue_init_flags_consistent(queue, init_flags))
+			return ERR_PTR(-EINVAL);
+		return queue;
 	}
 
 	/*
@@ -649,7 +754,14 @@ static int copy_header_to_ring(struct fuse_ring_ent *ent,
 	if (offset < 0)
 		return offset;
 
-	ring = (void __user *)ent->headers + offset;
+	if (bufring_enabled(ent->queue)) {
+		int buf_offset = offset +
+			sizeof(struct fuse_uring_req_header) * ent->id;
+
+		ring = ent->queue->bufring->headers + buf_offset;
+	} else {
+		ring = (void __user *)ent->headers + offset;
+	}
 
 	if (copy_to_user(ring, header, header_size)) {
 		pr_info_ratelimited("Copying header to ring failed.\n");
@@ -669,7 +781,14 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
 	if (offset < 0)
 		return offset;
 
-	ring = (void __user *)ent->headers + offset;
+	if (bufring_enabled(ent->queue)) {
+		int buf_offset = offset +
+			sizeof(struct fuse_uring_req_header) * ent->id;
+
+		ring = ent->queue->bufring->headers + buf_offset;
+	} else {
+		ring = (void __user *)ent->headers + offset;
+	}
 
 	if (copy_from_user(header, ring, header_size)) {
 		pr_info_ratelimited("Copying header from ring failed.\n");
@@ -684,12 +803,20 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
 				 struct fuse_ring_ent *ent, int dir,
 				 struct iov_iter *iter)
 {
+	void __user *payload;
 	int err;
 
-	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
-	if (err) {
-		pr_info_ratelimited("fuse: Import of user buffer failed\n");
-		return err;
+	if (bufring_enabled(ent->queue))
+		payload = (void __user *)ent->payload_buf.addr;
+	else
+		payload = ent->payload;
+
+	if (payload) {
+		err = import_ubuf(dir, payload, ring->max_payload_sz, iter);
+		if (err) {
+			pr_info_ratelimited("fuse: Import of user buffer failed\n");
+			return err;
+		}
 	}
 
 	fuse_copy_init(cs, dir == ITER_DEST, iter);
@@ -741,6 +868,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
 		.commit_id = req->in.h.unique,
 	};
 
+	if (bufring_enabled(ent->queue))
+		ent_in_out.buf_id = ent->payload_buf.id;
+
 	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
 	if (err)
 		return err;
@@ -805,6 +935,96 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
 				   sizeof(req->in.h));
 }
 
+static bool fuse_uring_req_has_payload(struct fuse_req *req)
+{
+	struct fuse_args *args = req->args;
+
+	return args->in_numargs > 1 || args->out_numargs;
+}
+
+static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
+	__must_hold(&ent->queue->lock)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_bufring *br = queue->bufring;
+	struct fuse_bufring_buf *buf;
+	unsigned int tail = br->tail, head = br->head;
+
+	lockdep_assert_held(&queue->lock);
+
+	/* Get a buffer to use for the payload */
+	if (tail == head)
+		return -ENOBUFS;
+
+	buf = &br->bufs[head % br->nbufs];
+	br->head++;
+
+	ent->payload_buf = *buf;
+
+	return 0;
+}
+
+static void fuse_uring_recycle_buffer(struct fuse_ring_ent *ent)
+	__must_hold(&ent->queue->lock)
+{
+	struct fuse_bufring_buf *ent_payload = &ent->payload_buf;
+	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_bufring_buf *buf;
+	struct fuse_bufring *br;
+
+	lockdep_assert_held(&queue->lock);
+
+	if (!bufring_enabled(queue) || !ent_payload->addr)
+		return;
+
+	br = queue->bufring;
+
+	/* ring should never be full */
+	WARN_ON_ONCE(br->tail - br->head >= br->nbufs);
+
+	buf = &br->bufs[(br->tail) % br->nbufs];
+
+	*buf = *ent_payload;
+
+	br->tail++;
+
+	memset(ent_payload, 0, sizeof(*ent_payload));
+}
+
+static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent,
+					     struct fuse_req *req)
+{
+	bool buffer_selected;
+	bool has_payload;
+
+	if (!bufring_enabled(ent->queue))
+		return 0;
+
+	buffer_selected = !!ent->payload_buf.addr;
+	has_payload = fuse_uring_req_has_payload(req);
+
+	if (has_payload && !buffer_selected)
+		return fuse_uring_select_buffer(ent);
+
+	if (!has_payload && buffer_selected)
+		fuse_uring_recycle_buffer(ent);
+
+	return 0;
+}
+
+static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
+				  struct fuse_req *req)
+{
+	if (!bufring_enabled(ent->queue))
+		return 0;
+
+	/* no payload to copy, can skip selecting a buffer */
+	if (!fuse_uring_req_has_payload(req))
+		return 0;
+
+	return fuse_uring_select_buffer(ent);
+}
+
 static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
 				   struct fuse_req *req)
 {
@@ -878,10 +1098,21 @@ static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
 
 	/* get and assign the next entry while it is still holding the lock */
 	req = list_first_entry_or_null(req_queue, struct fuse_req, list);
-	if (req)
-		fuse_uring_add_req_to_ring_ent(ent, req);
+	if (req) {
+		int err = fuse_uring_next_req_update_buffer(ent, req);
 
-	return req;
+		if (!err) {
+			fuse_uring_add_req_to_ring_ent(ent, req);
+			return req;
+		}
+	}
+
+	/*
+	 * Buffer selection may fail if all the buffers are currently saturated.
+	 * The request will be serviced when a buffer is freed up.
+	 */
+	fuse_uring_recycle_buffer(ent);
+	return NULL;
 }
 
 /*
@@ -1041,6 +1272,12 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
 	 * fuse requests would otherwise not get processed - committing
 	 * and fetching is done in one step vs legacy fuse, which has separated
 	 * read (fetch request) and write (commit result).
+	 *
+	 * If the server is using bufrings and has populated the ring with less
+	 * payload buffers than ents, it is possible that there may not be an
+	 * available buffer for the next request. If so, then the fetch is a
+	 * no-op and the next request will be serviced when a buffer becomes
+	 * available.
 	 */
 	if (fuse_uring_get_next_fuse_req(ent, queue))
 		fuse_uring_send(ent, cmd, 0, issue_flags);
@@ -1120,30 +1357,38 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 
 	ent->queue = queue;
 
-	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
-	if (err) {
-		pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
-				    err);
-		goto error;
-	}
+	if (bufring_enabled(queue)) {
+		ent->id = READ_ONCE(cmd->sqe->buf_index);
+		if (ent->id >= queue->bufring->queue_depth) {
+			err = -EINVAL;
+			goto error;
+		}
+	} else {
+		err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
+		if (err) {
+			pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
+					    err);
+			goto error;
+		}
 
-	err = -EINVAL;
-	headers = &iov[FUSE_URING_IOV_HEADERS];
-	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
-		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
-		goto error;
-	}
+		err = -EINVAL;
+		headers = &iov[FUSE_URING_IOV_HEADERS];
+		if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
+			pr_info_ratelimited("Invalid header len %zu\n",
+					    headers->iov_len);
+			goto error;
+		}
 
-	payload = &iov[FUSE_URING_IOV_PAYLOAD];
-	if (payload->iov_len < ring->max_payload_sz) {
-		pr_info_ratelimited("Invalid req payload len %zu\n",
-				    payload->iov_len);
-		goto error;
+		payload = &iov[FUSE_URING_IOV_PAYLOAD];
+		if (payload->iov_len < ring->max_payload_sz) {
+			pr_info_ratelimited("Invalid req payload len %zu\n",
+					    payload->iov_len);
+			goto error;
+		}
+		ent->headers = headers->iov_base;
+		ent->payload = payload->iov_base;
 	}
 
-	ent->headers = headers->iov_base;
-	ent->payload = payload->iov_base;
-
 	atomic_inc(&ring->queue_refs);
 	return ent;
 
@@ -1152,6 +1397,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
 	return ERR_PTR(err);
 }
 
+static bool init_flags_valid(u64 init_flags)
+{
+	u64 valid_flags = FUSE_URING_BUFRING;
+
+	return !(init_flags & ~valid_flags);
+}
+
 /*
  * Register header and payload buffer with the kernel and puts the
  * entry as "ready to get fuse requests" on the queue
@@ -1161,6 +1413,7 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 {
 	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe128_cmd(cmd->sqe,
 								       struct fuse_uring_cmd_req);
+	u64 init_flags = READ_ONCE(cmd_req->flags);
 	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
 	struct fuse_ring_queue *queue;
 	struct fuse_ring_ent *ent;
@@ -1179,11 +1432,16 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
 		return -EINVAL;
 	}
 
+	if (!init_flags_valid(init_flags))
+		return -EINVAL;
+
 	queue = ring->queues[qid];
 	if (!queue) {
-		queue = fuse_uring_create_queue(ring, qid);
-		if (!queue)
-			return err;
+		queue = fuse_uring_create_queue(cmd, ring, qid, init_flags);
+		if (IS_ERR(queue))
+			return PTR_ERR(queue);
+	} else if (!queue_init_flags_consistent(queue, init_flags)) {
+		return -EINVAL;
 	}
 
 	/*
@@ -1349,14 +1607,18 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
 	req->ring_queue = queue;
 	ent = list_first_entry_or_null(&queue->ent_avail_queue,
 				       struct fuse_ring_ent, list);
-	if (ent)
-		fuse_uring_add_req_to_ring_ent(ent, req);
-	else
-		list_add_tail(&req->list, &queue->fuse_req_queue);
-	spin_unlock(&queue->lock);
+	if (ent) {
+		err = fuse_uring_prep_buffer(ent, req);
+		if (!err) {
+			fuse_uring_add_req_to_ring_ent(ent, req);
+			spin_unlock(&queue->lock);
+			fuse_uring_dispatch_ent(ent);
+			return;
+		}
+	}
 
-	if (ent)
-		fuse_uring_dispatch_ent(ent);
+	list_add_tail(&req->list, &queue->fuse_req_queue);
+	spin_unlock(&queue->lock);
 
 	return;
 
@@ -1406,14 +1668,17 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
 	req = list_first_entry_or_null(&queue->fuse_req_queue, struct fuse_req,
 				       list);
 	if (ent && req) {
-		fuse_uring_add_req_to_ring_ent(ent, req);
-		spin_unlock(&queue->lock);
+		int err = fuse_uring_prep_buffer(ent, req);
 
-		fuse_uring_dispatch_ent(ent);
-	} else {
-		spin_unlock(&queue->lock);
+		if (!err) {
+			fuse_uring_add_req_to_ring_ent(ent, req);
+			spin_unlock(&queue->lock);
+			fuse_uring_dispatch_ent(ent);
+			return true;
+		}
 	}
 
+	spin_unlock(&queue->lock);
 	return true;
 }
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 349418db3374..66d5d5f8dc3f 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -36,11 +36,47 @@ enum fuse_ring_req_state {
 	FRRS_RELEASED,
 };
 
+struct fuse_bufring_buf {
+	uintptr_t addr;
+	unsigned int len;
+	unsigned int id;
+};
+
+struct fuse_bufring {
+	/* pointer to the headers buffer */
+	void __user *headers;
+
+	unsigned int queue_depth;
+
+	/* metadata tracking state of the bufring */
+	unsigned int nbufs;
+	unsigned int head;
+	unsigned int tail;
+
+	/* the buffers backing the ring */
+	__DECLARE_FLEX_ARRAY(struct fuse_bufring_buf, bufs);
+};
+
 /** A fuse ring entry, part of the ring queue */
 struct fuse_ring_ent {
-	/* userspace buffer */
-	struct fuse_uring_req_header __user *headers;
-	void __user *payload;
+	union {
+		/* if bufrings are not used */
+		struct {
+			/* userspace buffers */
+			struct fuse_uring_req_header __user *headers;
+			void __user *payload;
+		};
+		/* if bufrings are used */
+		struct {
+			/*
+			 * unique fixed id for the ent. used by kernel/server to
+			 * locate where in the headers buffer the data for this
+			 * ent resides
+			 */
+			unsigned int id;
+			struct fuse_bufring_buf payload_buf;
+		};
+	};
 
 	/* the ring queue that owns the request */
 	struct fuse_ring_queue *queue;
@@ -99,6 +135,9 @@ struct fuse_ring_queue {
 	unsigned int active_background;
 
 	bool stopped;
+
+	/* only allocated if the server uses bufrings */
+	struct fuse_bufring *bufring;
 };
 
 /**
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index c13e1f9a2f12..8753de7eb189 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -240,6 +240,10 @@
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
  *  - add FUSE_NOTIFY_PRUNE
+ *
+ *  7.46
+ *  - add FUSE_URING_BUFRING flag
+ *  - add fuse_uring_cmd_req init struct
  */
 
 #ifndef _LINUX_FUSE_H
@@ -1263,7 +1267,13 @@ struct fuse_uring_ent_in_out {
 
 	/* size of user payload buffer */
 	uint32_t payload_sz;
-	uint32_t padding;
+
+	/*
+	 * if using bufrings, this is the id of the selected buffer.
+	 * the selected buffer holds the request payload
+	 */
+	uint16_t buf_id;
+	uint16_t padding;
 
 	uint64_t reserved;
 };
@@ -1294,6 +1304,9 @@ enum fuse_uring_cmd {
 	FUSE_IO_URING_CMD_COMMIT_AND_FETCH = 2,
 };
 
+/* fuse_uring_cmd_req flags */
+#define FUSE_URING_BUFRING		(1 << 0)
+
 /**
  * In the 80B command area of the SQE.
  */
@@ -1305,7 +1318,17 @@ struct fuse_uring_cmd_req {
 
 	/* queue the command is for (queue index) */
 	uint16_t qid;
-	uint8_t padding[6];
+	uint16_t padding;
+
+	union {
+		struct {
+			/* size of the bufring's backing buffers */
+			uint32_t buf_size;
+			/* number of entries in the queue */
+			uint16_t queue_depth;
+			uint16_t padding;
+		} init;
+	};
 };
 
 #endif /* _LINUX_FUSE_H */
-- 
2.52.0

