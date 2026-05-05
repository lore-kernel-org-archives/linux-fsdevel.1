Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF82DECB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021259; cv=none; b=jiqjc0p8yaRKLJDrvGQrxGM0X/vK9nshHJf6NUff2FdXqVZNihS60qT4RuJNv31CdS6xmMT+v6gxzwpPkcze/pERUKbEtr8/NPSbOOc6nAV8kVN4H0d8FWZ3WI3e09s7xSLGbZ1zsDgNTRxlYOmXtOAKfSXLMIeb+xjlsI6Nq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021259; c=relaxed/simple;
	bh=2BQhioqJjCRuJwMcbZtpsxW/hlm7IYi+NgZhmA28IA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MNxp4yWDgAM34Nv+yPfav9v8dQS+nxumBnM/wZV/bnvZMyy7iuurxwyislhmmrUi7XOYfBgIhAbRFFUOdFzFeGMtaH3oazKLc3BzbBK5o/a+HC6O8HcpcgHRS/XZKNI5ThM5AIC/nsSBT2Efy2vRwP+V/XBvk2INJ1FBHiXMmQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=C8w3Wdoq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=npRLCdoN; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="C8w3Wdoq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="npRLCdoN"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 6D40CEC00FB;
	Tue,  5 May 2026 18:47:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 05 May 2026 18:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778021256;
	 x=1778107656; bh=VfxiRpCMcm1azWcDejRJz90IL8vJGuBIBjtOg7zJqG0=; b=
	C8w3WdoqsFbNfDn+tVYgii6crXjIqN1MowZebjfPOj/0azp/tVEev3UGfhX1yq56
	TRm3bv1kmig/Z4r6qcQJ0h/yigAPEvrzsYlR62H8SfrDRoFuRBVJDTtvoxr7ReCu
	Yxg2NIxx1HkQvOQMiIbwbMOVktWqcBkH4TGdwM24YfOuB/92r0SglafF9uoa7NHF
	TmQdl0DaUkextXHommrSDkZDd/NLZ0pNfts9rHRWu7hPBE2NEBMxAnqksvtsGrBv
	z09qUfuGs3GaVI89QIRZwMEuSkDiCvSO/wuWDLG+sfB+CT2Obuan7+Yi7kcaUde9
	MUFiqO8AaoC+6OKtg3Z3lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778021256; x=
	1778107656; bh=VfxiRpCMcm1azWcDejRJz90IL8vJGuBIBjtOg7zJqG0=; b=n
	pRLCdoN1pfyhZQ0xdVnuTyS4g59mo94itLZ9SpQRzY/aNBryQ5x61Qj/BrRqCaHQ
	GiFDakl8oUc07BVGFrbRmkzZ2tgMdz5TzmQpV7NF73RBdWllowBtFN5oeeYsezM7
	bvxn5rFgf14SW9rsKXgJtIIPhRvfn+4G3BhP1li7Y/6eLm3tsx/LFJJXXr7QWlwV
	Lq/UdYImoEf04plP5k7DhQjrpYqDKb9Wa5ZdWUuGLANjAEdVyLjfvjbOvsEmH6RS
	0y5aixjtS/1lAdu2mzMM786aVwh3jkCbcZFfiw8bceVv+T33AoV6bha3YSnb77ov
	VSEQ/f6FsLVe29vpagOlQ==
X-ME-Sender: <xms:iHP6aYMc_pVRh1tAHAaLx_NjX5cRgcMuIWBjr5rpZLX94vg8NNDdTA>
    <xme:iHP6aZjjfXum_IdFhBA-WGKzvWKmWtuTjJZhSDGXdyLrpJsBAXSFCjcDygHSh-Eu9
    qgZZ_WmUSoPAB7Psqvnid1HYHF6C166aiBnt7JKyZ1xvZkqxRk>
X-ME-Received: <xmr:iHP6ab2FVCi-5Lp-RDlJda44pb3sEHcOwwugq_eCZoLK9CcBIjZxTl8YTxTuDz0GAA82Cz8OZ2jAMH9wV-uK9aNQWOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohep
    rgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvg
    hlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iHP6aTj1oflG37yGGZHkn6OjL6vZw3wCOQ9NmPl7fujKHUidUVMi3w>
    <xmx:iHP6abcGfLoOaorLmYGOc-AjNVq5kOmZGE-rlE-tHsRlAYoXqPZnaw>
    <xmx:iHP6aWlZdj-X_zspL0h7r1IHrcTZRS4cxFmXSh4jxeJRV_ByhAHvog>
    <xmx:iHP6aUtOse9o9CyqXdZGDpqnNH8eVjXYJspIc5QqK08tzvsBF97yYA>
    <xmx:iHP6aWxRjdTQsvACN9Z1e2VJqNnyW9hsAbVZ5IMk-XLYCAuCZrkw6S14>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 18:47:33 -0400 (EDT)
Message-ID: <456f05a2-dec3-487d-89ea-06fe0acd084a@bsbernd.com>
Date: Wed, 6 May 2026 00:47:30 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] fuse: add io-uring buffer rings
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-11-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260402162840.2989717-11-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Add fuse buffer rings for servers communicating through the io-uring
> interface. To use this, the server must set the FUSE_URING_BUFRING
> flag and provide header and payload buffers via an iovec array in the
> sqe during registration. The payload buffers are used to back the buffer
> ring. The kernel manages buffer selection and recycling through a simple
> internal ring.
> 
> This has the following advantages over the non-bufring (iovec) path:
> - Reduced memory usage: in the iovec path, each entry has its own
>   dedicated payload buffer, requiring N buffers for N entries where each
>   buffer must be large enough to accommodate the maximum possible
>   payload size. With buffer rings, payload buffers are pooled and
>   selected on demand. Entries only hold a buffer while actively
>   processing a request with payload data. When incremental buffer
>   consumption is added, this will allow non-overlapping regions of a
>   single buffer to be used simultaneously across multiple requests,
>   further reducing memory requirements.
> - Foundation for pinned buffers: the buffer ring headers and payloads
>   are now each passed in as a contiguous memory allocation, which allows
>   fuse to easily pin and vmap the entire region in one operation during
>   queue setup. This will eliminate the per-request overhead of having to
>   pin/unpin user pages and translate virtual addresses and is a
>   prerequisite for future optimizations like performing data copies
>   outside of the server's task context.
> 
> Each ring entry gets a fixed ID (sqe->buf_index) that maps to a specific
> header slot in the headers buffer. Payload buffers are selected from
> the ring on demand and recycled after each request. Buffer ring usage is
> set on a per-queue basis. All subsequent registration SQEs for the same
> queue must use consistent flags.
> 
> The headers are laid out contiguously and provided via iov[0]. Each slot
> maps to ent->id:
> 
> |<- headers_size (>= queue_depth * sizeof(fuse_uring_req_header)) ->|
> +------------------------------+------------------------------+-----+
> | struct fuse_uring_req_header | struct fuse_uring_req_header | ... |
> |        [ent id=0]            |        [ent id=1]            |     |
> +------------------------------+------------------------------+-----+
> 
> On the server side, the ent id is used to determine where in the headers
> buffer the headers data for the ent resides. This is done by
> calculating ent_id * sizeof(struct fuse_uring_req_header) as the offset
> into the headers buffer.
> 
> The buffer ring is backed by the payload buffer, which is contiguous but
> partitioned into individual bufs according to the buf_size passed in at
> registration.
> 
>   PAYLOAD BUFFER POOL (contiguous, provided via iov[1]):
>     |<-------------- payload_size ------------>|
>     +--------- --+-----------+-----------+-----+
>     |  buf [0]   |  buf [1]  |  buf [2]  | ... |
>     |  buf_size  |  buf_size |  buf_size | ... |
>     +--------- --+-----------+-----------+-----+
> 
> buffer ring state (struct fuse_bufring, kernel-internal):
> bufs[]: [ used | used | FREE | FREE | FREE ]
> 			^^^^^^^^^^^^^^^^^^^
> 			available for selection
> 
> The buffer ring logic is as follows:
> select:  buf = bufs[head % nbufs]; head++
> recycle: bufs[tail % nbufs] = buf; tail++
> empty:   tail == head (no buffers available)
> full:    tail - head >= nbufs
> 
> Buffer ring request flow
> ------------------------
> |  Kernel                                  |  FUSE daemon
> |                                          |
> |  [client request arrives]                |
> |  >fuse_uring_send()                      |
> |    [select payload buf from ring]        |
> |    >fuse_uring_select_buffer()           |
> |    [copy headers to ent's header slot]   |
> |    >copy_header_to_ring()                |
> |    [copy payload to selected buf]        |
> |    >fuse_uring_copy_to_ring()            |
> |    [set buf_id in ent_in_out header]     |
> |    >io_uring_cmd_done()                  |
> |                                          |  [CQE received]
> |                                          |  [read headers from header
> |                                          |    slot]
> |                                          |  [read payload from buf_id]
> |                                          |  [process request]
> |                                          |  [write reply to header
> |                                          |    slot]
> |                                          |  [write reply payload to
> |                                          |    buf]
> |                                          |  >io_uring_submit()
> |                                          |   COMMIT_AND_FETCH
> |  >fuse_uring_commit_fetch()              |
> |    >fuse_uring_commit()                  |
> |     [copy reply from ring]               |
> |     >fuse_uring_recycle_buffer()         |
> |    >fuse_uring_get_next_fuse_req()       |
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 363 +++++++++++++++++++++++++++++++++-----
>  fs/fuse/dev_uring_i.h     |  45 ++++-
>  include/uapi/linux/fuse.h |  27 ++-
>  3 files changed, 381 insertions(+), 54 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index a061f175b3fd..9f14a2bcde3f 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -41,6 +41,11 @@ enum fuse_uring_header_type {
>  	FUSE_URING_HEADER_RING_ENT,
>  };
>  
> +static inline bool bufring_enabled(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring != NULL;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -222,6 +227,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		}
>  
>  		kfree(queue->fpq.processing);
> +		kfree(queue->bufring);
>  		kfree(queue);
>  		ring->queues[qid] = NULL;
>  	}
> @@ -303,20 +309,102 @@ static int fuse_uring_get_iovec_from_sqe(const struct io_uring_sqe *sqe,
>  	return 0;
>  }
>  
> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
> -						       int qid)
> +static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
> +				     struct fuse_ring_queue *queue)
> +{
> +	const struct fuse_uring_cmd_req *cmd_req =
> +		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
> +	u16 queue_depth = READ_ONCE(cmd_req->init.queue_depth);
> +	unsigned int buf_size = READ_ONCE(cmd_req->init.buf_size);
> +	struct iovec iov[FUSE_URING_IOV_SEGS];
> +	void __user *payload, *headers;
> +	size_t headers_size, payload_size, ring_size;
> +	struct fuse_bufring *br;
> +	unsigned int nr_bufs, i;
> +	uintptr_t payload_addr;
> +	int err;
> +
> +	if (!queue_depth || !buf_size)
> +		return -EINVAL;
> +
> +	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> +	if (err)
> +		return err;
> +
> +	headers = iov[FUSE_URING_IOV_HEADERS].iov_base;
> +	headers_size = iov[FUSE_URING_IOV_HEADERS].iov_len;
> +	payload = iov[FUSE_URING_IOV_PAYLOAD].iov_base;
> +	payload_size = iov[FUSE_URING_IOV_PAYLOAD].iov_len;
> +
> +	/* check if there's enough space for all the headers */
> +	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
> +		return -EINVAL;
> +
> +	if (buf_size < queue->ring->max_payload_sz)
> +		return -EINVAL;
> +
> +	nr_bufs = payload_size / buf_size;
> +	if (!nr_bufs || nr_bufs > U16_MAX)
> +		return -EINVAL;
> +
> +	/* create the ring buffer */
> +	ring_size = struct_size(br, bufs, nr_bufs);
> +	br = kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
> +	if (!br)
> +		return -ENOMEM;
> +
> +	br->queue_depth = queue_depth;
> +	br->headers = headers;
> +
> +	payload_addr = (uintptr_t)payload;
> +
> +	/* populate the ring buffer */
> +	for (i = 0; i < nr_bufs; i++, payload_addr += buf_size) {
> +		struct fuse_bufring_buf *buf = &br->bufs[i];
> +
> +		buf->addr = payload_addr;
> +		buf->len = buf_size;
> +		buf->id = i;
> +	}
> +
> +	br->nbufs = nr_bufs;
> +	br->tail = nr_bufs;
> +
> +	queue->bufring = br;
> +
> +	return 0;
> +}
> +
> +/*
> + * if the queue is already registered, check that the queue was initialized with
> + * the same init flags set for this FUSE_IO_URING_CMD_REGISTER cmd. all
> + * FUSE_IO_URING_CMD_REGISTER cmds should have the same init fields set on a
> + * per-queue basis.
> + */
> +static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
> +					u64 init_flags)
>  {
> +	bool bufring = init_flags & FUSE_URING_BUFRING;
> +
> +	return bufring_enabled(queue) == bufring;
> +}
> +
> +static struct fuse_ring_queue *
> +fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
> +			int qid, u64 init_flags)
> +{
> +	bool use_bufring = init_flags & FUSE_URING_BUFRING;
>  	struct fuse_conn *fc = ring->fc;
>  	struct fuse_ring_queue *queue;
>  	struct list_head *pq;
>  
>  	queue = kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
>  	if (!queue)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	pq = kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
>  	if (!pq) {
>  		kfree(queue);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  
>  	queue->qid = qid;
> @@ -334,12 +422,29 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  	queue->fpq.processing = pq;
>  	fuse_pqueue_init(&queue->fpq);
>  
> +	if (use_bufring) {
> +		int err = fuse_uring_bufring_setup(cmd, queue);
> +
> +		if (err) {
> +			kfree(pq);
> +			kfree(queue);
> +			return ERR_PTR(err);
> +		}
> +	}
> +
>  	spin_lock(&fc->lock);
> +	/* check if the queue creation raced with another thread */
>  	if (ring->queues[qid]) {
>  		spin_unlock(&fc->lock);
>  		kfree(queue->fpq.processing);
> +		if (use_bufring)
> +			kfree(queue->bufring);
>  		kfree(queue);
> -		return ring->queues[qid];
> +
> +		queue = ring->queues[qid];
> +		if (!queue_init_flags_consistent(queue, init_flags))
> +			return ERR_PTR(-EINVAL);
> +		return queue;
>  	}
>  
>  	/*
> @@ -649,7 +754,14 @@ static int copy_header_to_ring(struct fuse_ring_ent *ent,
>  	if (offset < 0)
>  		return offset;
>  
> -	ring = (void __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset = offset +
> +			sizeof(struct fuse_uring_req_header) * ent->id;
> +
> +		ring = ent->queue->bufring->headers + buf_offset;
> +	} else {
> +		ring = (void __user *)ent->headers + offset;
> +	}
>  
>  	if (copy_to_user(ring, header, header_size)) {
>  		pr_info_ratelimited("Copying header to ring failed.\n");
> @@ -669,7 +781,14 @@ static int copy_header_from_ring(struct fuse_ring_ent *ent,
>  	if (offset < 0)
>  		return offset;
>  
> -	ring = (void __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset = offset +
> +			sizeof(struct fuse_uring_req_header) * ent->id;
> +
> +		ring = ent->queue->bufring->headers + buf_offset;
> +	} else {
> +		ring = (void __user *)ent->headers + offset;
> +	}
>  
>  	if (copy_from_user(header, ring, header_size)) {
>  		pr_info_ratelimited("Copying header from ring failed.\n");
> @@ -684,12 +803,20 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
>  				 struct fuse_ring_ent *ent, int dir,
>  				 struct iov_iter *iter)
>  {
> +	void __user *payload;
>  	int err;
>  
> -	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
> -	if (err) {
> -		pr_info_ratelimited("fuse: Import of user buffer failed\n");
> -		return err;
> +	if (bufring_enabled(ent->queue))
> +		payload = (void __user *)ent->payload_buf.addr;
> +	else
> +		payload = ent->payload;
> +
> +	if (payload) {
> +		err = import_ubuf(dir, payload, ring->max_payload_sz, iter);
> +		if (err) {
> +			pr_info_ratelimited("fuse: Import of user buffer failed\n");
> +			return err;
> +		}
>  	}
>  
>  	fuse_copy_init(cs, dir == ITER_DEST, iter);
> @@ -741,6 +868,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_req *req,
>  		.commit_id = req->in.h.unique,
>  	};
>  
> +	if (bufring_enabled(ent->queue))
> +		ent_in_out.buf_id = ent->payload_buf.id;
> +
>  	err = setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
>  	if (err)
>  		return err;
> @@ -805,6 +935,96 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
>  				   sizeof(req->in.h));
>  }
>  
> +static bool fuse_uring_req_has_payload(struct fuse_req *req)
> +{
> +	struct fuse_args *args = req->args;
> +
> +	return args->in_numargs > 1 || args->out_numargs;
> +}
> +
> +static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
> +	__must_hold(&ent->queue->lock)
> +{
> +	struct fuse_ring_queue *queue = ent->queue;
> +	struct fuse_bufring *br = queue->bufring;
> +	struct fuse_bufring_buf *buf;
> +	unsigned int tail = br->tail, head = br->head;
> +
> +	lockdep_assert_held(&queue->lock);
> +
> +	/* Get a buffer to use for the payload */
> +	if (tail == head)
> +		return -ENOBUFS;
> +
> +	buf = &br->bufs[head % br->nbufs];
> +	br->head++;

Just a minor annotation and we can do this any time later. For cache
effects (mostly large L3) it might be worth to update buffer selection
and buffer recycling to LIFO.


Thanks,
Bernd

