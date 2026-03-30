Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2CC3A1A2B
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 21:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774906137; cv=none; b=eIGvscgZQY0kid7CL2s67VYGUjKHmGS7JYDGf3k0C0YlG8fEbfqy1J3n07LaLJT8rhgcq4msi4CXj2CZO9NsexBG7eiMxFVAoMg/GS10ARC10JDVNA7zHoBLpDhKz3fIMBcDS73Yv1aHksMsfCJRUpIb4Cpjk72kyic299Fpnk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774906137; c=relaxed/simple;
	bh=3pULKeUTy2SImiE/CXruAhxc0t655WN7j42Q4PjsedU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hC9G3VvP475mu1PNGUKwQd4xAG/6aKwNAEZ1NzURwyOkAxSY282dwZ5YdlUI/xjoBKn0yY7m68p1VwWc7j6/JIZ5eWTK4LPRDo3zq2I/fXxfdBiC7nbc7TEGqKMYA1tnltX8DXuKMrlL/95SUAOXgoAicwDPz/JPYiJ7muYjhZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Ui/nxLgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g1zQkNWM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Ui/nxLgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g1zQkNWM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 730281D001E3;
	Mon, 30 Mar 2026 17:28:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 17:28:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774906134;
	 x=1774992534; bh=U3SKgZUUwi4uvZvS+true4H6dGAjnfVXAPsKKySlnSM=; b=
	Ui/nxLgyyPbObb/zHcznMLr0Ltwzel6B4wxdAWr2C6fqGyhiWsNKKG7Y8LHcoUZe
	SwmO4SuP82Vyqvy3TqkQgfoDLc+Tul9VayoL8uJ0fQyP+jbootKtNNVp7OW9+Kdw
	xmGaLlafyHMM0PqglN9T224cbRcSsLAL1Ala/vc23dyv9w9aY/W5jfyTsh8iBcz8
	5Avny9odyhM7gAC2PfyaeMynMo/BitGTvah6hPQmI6OB+K8WWKmKH84L6fHEOlFP
	iNGwAEvVqtEh4mQKbOBAMQMuKIBOJk45npZTpLx9kD2JSlVumxmS6Ja15TD3zLsE
	B3NqJqfEesFsBiK9D0T0HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774906134; x=
	1774992534; bh=U3SKgZUUwi4uvZvS+true4H6dGAjnfVXAPsKKySlnSM=; b=g
	1zQkNWMebp1hCqkcB1Kk4Zo8bOmlzB+wOP8Rp6+0Qiq48HlCAJ4L0dqeGNyCRz3Q
	sjJMzJr3J2CO7oCH7RgXnLr4pXJ9td8uFkKiZ1C3a2bqBQ09CIdwa5eHoRw+8Tnp
	PjUADf0mQreddelLvRPSsC11/vv8KMDUu9aGn5GILJFHRw3SPEYzUaBJspxiyifR
	g+KGhJS7A0KmbhucG6TBn9CqsVo3Qs01Wn/AOeFf+5ZLVwsZf3Lf36s5WGbW+1Xo
	u6NydfB7WP8u/f9mxWXOE7nF4FsSzKyu6r4EBoaAfd8OnoajgQSpAsRr4OH9R89E
	GMXmC/4pNEeahfVEM/VxQ==
X-ME-Sender: <xms:FevKaU9MQYsGj6_4IfB8JWMKxkcOwuL6FWEFxeo0T3WpFrFKV6iDwg>
    <xme:FevKaTleXeuVXMSmYi5hsn0U8oFt4xcjjsu5EA1Pab1B2E17G4Lsz8CAwOSku6PK3
    f0PFXUT2pMQgLuHnUCL-abDGfuwPJtA8TVpY_ev5oDVsM-zBiDZOg>
X-ME-Received: <xmr:FevKaSXnBgckAqd1MwhUePSrhav2VrJK4VSMXYjSa0CckjkE6J0Z6G_RK1IUbYe6xsN7i-WWi1OFDy0lhGwV2o460FD3mPyUyRdprhmpu6i7oJvhIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgedttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtohepmhhi
    khhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgthhhusggvrhhtseguug
    hnrdgtohhmpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:FevKaQHTWOOcZv591aYODBrAbSTsA2SjnLMV7hr5Op0aqIsd58eQWg>
    <xmx:FevKaWd6ZjKOsmEzvIfJqyQGeO83gicdi1DL9LjCE7ME-ohB5dDBoQ>
    <xmx:FevKaZIBi7STjAVoh2IFuz_VqWh4sS8m_6MkaSLbxGfyVmAB-NxsOQ>
    <xmx:FevKaTEfaieVlyc-7EIiO4mUblJQ3_xxRKvMOvqpsM7zCpg__-vw2g>
    <xmx:FuvKaWZzmQcBibxsh28dfC4UC8s97gEopF7M7M13vifupO0GiKE9DXUk>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 17:28:52 -0400 (EDT)
Message-ID: <6b066b75-e77e-4b4a-8280-199d547c2e94@bsbernd.com>
Date: Mon, 30 Mar 2026 23:28:51 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
To: Joanne Koong <joannelkoong@gmail.com>, axboe@kernel.dk
Cc: miklos@szeredi.hu, bschubert@ddn.com, linux-fsdevel@vger.kernel.org
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
 <20260324224532.3733468-8-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260324224532.3733468-8-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 23:45, Joanne Koong wrote:
> Add io-uring kernel-managed buffer ring capability for fuse servers
> communicating through the io-uring interface.
> 
> This has two benefits:
> a) eliminates the overhead of pinning/unpinning user pages and
> translating virtual addresses for every server-kernel interaction
> 
> b) reduces the amount of memory needed for the buffers per queue.
> Incremental buffer consumption, when added, will allow non-overlapping
> regions of a buffer to be used simultaneously across multiple requests.
> 
> Buffer ring usage is set on a per-queue basis. In order to use this, the
> server needs to have preregistered a kernel-managed buffer ring and a
> memory region big enough to hold the headers. This should be done before
> queue creation is initiated. The kernel-managed buffer ring will be
> pinned for the lifetime of the io-ring.
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 384 +++++++++++++++++++++++++++++++-------
>  fs/fuse/dev_uring_i.h     |  46 ++++-
>  include/uapi/linux/fuse.h |  19 +-
>  3 files changed, 376 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 81cd20e0d50b..cd45b6a8e6c6 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -10,6 +10,7 @@
>  #include "fuse_trace.h"
>  
>  #include <linux/fs.h>
> +#include <linux/io_uring.h>
>  #include <linux/io_uring/cmd.h>
>  
>  static bool __read_mostly enable_uring;
> @@ -19,6 +20,7 @@ MODULE_PARM_DESC(enable_uring,
>  
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>  
> +#define FUSE_URING_BUFRING_GROUP 0
>  
>  bool fuse_uring_enabled(void)
>  {
> @@ -40,6 +42,11 @@ enum fuse_uring_header_type {
>  	FUSE_URING_HEADER_RING_ENT,
>  };
>  
> +static inline bool bufring_enabled(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring.enabled;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -276,20 +283,89 @@ static struct fuse_ring *fuse_uring_create(struct fuse_conn *fc)
>  	return res;
>  }
>  
> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
> -						       int qid)
> +static void *fuse_uring_get_buf_ring_headers(struct io_uring_cmd *cmd,
> +					     u64 headers_offset,
> +					     unsigned int queue_depth,
> +					     unsigned int issue_flags)
> +{
> +	void *mem_reg_addr;
> +	u64 mem_reg_size, headers_size;
> +	unsigned nr_pages;
> +
> +	/* find the headers in the registered memory region */
> +	mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
> +							  issue_flags);
> +
> +	/* server does not have a registered memory region set up */
> +	if (!mem_reg_addr)
> +		return NULL;
> +
> +	mem_reg_size = (u64)nr_pages * PAGE_SIZE;
> +	if (headers_offset > mem_reg_size)
> +		return NULL;
> +
> +	/* verify headers fit within memory region bounds */
> +	headers_size = (u64)queue_depth * sizeof(struct fuse_uring_req_header);
> +	if (mem_reg_size - headers_offset < headers_size)
> +		return NULL;


Could you add to the commit message how the buffer layout is? I think
this deserves some explanation.

The appraoch kinds of reminds me to my initial patches where I
configured the ring with an additional ioctl. Until Miklos asked to make
it dynamic and to avoid the ioctls (and config SQEs as well). Basically
here every FUSE_IO_URING_CMD_REGISTER gets the the queue depth? Wouldn't
make sense to have a setup SQE per queue then? Or one global
CREATE_RINGS config sqe? With the reduced queue series things would be
definitely easier if we would know the number of queues that are
supposed to get created (right now the it has to re-calculate the the
static mapping for every queue).


Thanks,
Bernd


> +
> +	return mem_reg_addr + headers_offset;
> +}
> +
> +static int fuse_uring_buf_ring_setup(struct io_uring_cmd *cmd,
> +				     struct fuse_ring_queue *queue,
> +				     unsigned int issue_flags)
> +{
> +	const struct fuse_uring_cmd_req *cmd_req =
> +		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
> +	u64 headers_offset = READ_ONCE(cmd_req->init.headers_offset);
> +	unsigned queue_depth = READ_ONCE(cmd_req->init.queue_depth);
> +	void *headers;
> +	int err;
> +
> +	if (!queue_depth)
> +		return -EINVAL;
> +
> +	headers = fuse_uring_get_buf_ring_headers(cmd, headers_offset,
> +						  queue_depth, issue_flags);
> +	if (!headers)
> +		return -EINVAL;
> +
> +	err = io_uring_buf_ring_pin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags,
> +				    &queue->bufring.list);
> +	if (err)
> +		return err;
> +
> +	if (!io_uring_is_kmbuf_ring(cmd, FUSE_URING_BUFRING_GROUP, issue_flags))
> +		goto error;
> +
> +	queue->bufring.headers = headers;
> +	queue->bufring.queue_depth = queue_depth;
> +	queue->bufring.enabled = true;
> +
> +	return 0;
> +
> +error:
> +	io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP, issue_flags);
> +	return -EINVAL;
> +}
> +
> +static struct fuse_ring_queue *
> +fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring,
> +			int qid, bool use_bufring, unsigned int issue_flags)
>  {
>  	struct fuse_conn *fc = ring->fc;
>  	struct fuse_ring_queue *queue;
>  	struct list_head *pq;
> +	int err;
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
> @@ -307,12 +383,29 @@ static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>  	queue->fpq.processing = pq;
>  	fuse_pqueue_init(&queue->fpq);
>  
> +	if (use_bufring) {
> +		err = fuse_uring_buf_ring_setup(cmd, queue, issue_flags);
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
> -		kfree(queue->fpq.processing);
> +		if (use_bufring)
> +			io_uring_buf_ring_unpin(cmd, FUSE_URING_BUFRING_GROUP,
> +						issue_flags);
> +		kfree(pq);
>  		kfree(queue);
> -		return ring->queues[qid];
> +
> +		queue = ring->queues[qid];
> +		if (bufring_enabled(queue) != use_bufring)
> +			return ERR_PTR(-EINVAL);
> +		return queue;
>  	}
>  
>  	/*
> @@ -605,16 +698,25 @@ static __always_inline int copy_header_to_ring(struct fuse_ring_ent *ent,
>  					       size_t header_size)
>  {
>  	int offset = ring_header_type_offset(type);
> -	void __user *ring;
>  
>  	if (offset < 0)
>  		return offset;
>  
> -	ring = (char __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset =
> +			sizeof(struct fuse_uring_req_header) * ent->id;
>  
> -	if (copy_to_user(ring, header, header_size)) {
> -		pr_info_ratelimited("Copying header to ring failed.\n");
> -		return -EFAULT;
> +		memcpy(ent->queue->bufring.headers + buf_offset + offset,
> +		       header, header_size);
> +	} else {
> +		void __user *ring = (char __user *)ent->headers + offset;
> +
> +		if (copy_to_user(ring, header, header_size)) {
> +			pr_info_ratelimited("Copying header to ring failed: "
> +					    "header_type=%u, header_size=%zu\n",
> +					    type, header_size);
> +			return -EFAULT;
> +		}
>  	}
>  
>  	return 0;
> @@ -626,16 +728,25 @@ static __always_inline int copy_header_from_ring(struct fuse_ring_ent *ent,
>  						 size_t header_size)
>  {
>  	int offset = ring_header_type_offset(type);
> -	const void __user *ring;
>  
>  	if (offset < 0)
>  		return offset;
>  
> -	ring = (char __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset =
> +			sizeof(struct fuse_uring_req_header) * ent->id;
>  
> -	if (copy_from_user(header, ring, header_size)) {
> -		pr_info_ratelimited("Copying header from ring failed.\n");
> -		return -EFAULT;
> +		memcpy(header, ent->queue->bufring.headers + buf_offset + offset,
> +		       header_size);
> +	} else {
> +		const void __user *ring = (char __user *)ent->headers + offset;
> +
> +		if (copy_from_user(header, ring, header_size)) {
> +			pr_info_ratelimited("Copying header from ring failed: "
> +					    "header_type=%u, header_size=%zu\n",
> +					    type, header_size);
> +			return -EFAULT;
> +		}
>  	}
>  
>  	return 0;
> @@ -648,14 +759,23 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
>  {
>  	int err;
>  
> -	err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
> -	if (err) {
> -		pr_info_ratelimited("fuse: Import of user buffer failed\n");
> -		return err;
> +	if (!bufring_enabled(ent->queue)) {
> +		err = import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
> +		if (err) {
> +			pr_info_ratelimited("fuse: Import of user buffer "
> +					    "failed\n");
> +			return err;
> +		}
>  	}
>  
>  	fuse_copy_init(cs, dir == ITER_DEST, iter);
>  
> +	if (bufring_enabled(ent->queue)) {
> +		cs->is_kaddr = true;
> +		cs->len = ent->payload_kvec.iov_len;
> +		cs->kaddr = ent->payload_kvec.iov_base;
> +	}
> +
>  	cs->is_uring = true;
>  	cs->req = req;
>  
> @@ -767,6 +887,91 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
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
> +static int fuse_uring_select_buffer(struct fuse_ring_ent *ent,
> +				    unsigned int issue_flags)
> +	__must_hold(&queue->lock)
> +{
> +	struct io_br_sel sel;
> +	size_t len = 0;
> +
> +	lockdep_assert_held(&ent->queue->lock);
> +
> +	/* Get a buffer to use for the payload */
> +	sel = io_ring_buffer_select(cmd_to_io_kiocb(ent->cmd), &len,
> +				    ent->queue->bufring.list, issue_flags);
> +	if (sel.val)
> +		return sel.val;
> +	if (!sel.kaddr)
> +		return -ENOENT;
> +
> +	ent->payload_kvec.iov_base = sel.kaddr;
> +	ent->payload_kvec.iov_len = len;
> +	ent->buf_id = sel.buf_id;
> +
> +	return 0;
> +}
> +
> +static void fuse_uring_recycle_buffer(struct fuse_ring_ent *ent,
> +				      unsigned int issue_flags)
> +	__must_hold(&queue->lock)
> +{
> +	struct kvec *kvec = &ent->payload_kvec;
> +
> +	lockdep_assert_held(&ent->queue->lock);
> +
> +	if (!bufring_enabled(ent->queue) || !kvec->iov_base)
> +		return;
> +
> +	WARN_ON_ONCE(io_uring_kmbuf_recycle(ent->cmd, FUSE_URING_BUFRING_GROUP,
> +					    (u64)(uintptr_t)kvec->iov_base,
> +					    kvec->iov_len, ent->buf_id,
> +					    issue_flags));
> +
> +	memset(kvec, 0, sizeof(*kvec));
> +}
> +
> +static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent,
> +					     struct fuse_req *req,
> +					     unsigned int issue_flags)
> +{
> +	bool buffer_selected;
> +	bool has_payload;
> +
> +	if (!bufring_enabled(ent->queue))
> +		return 0;
> +
> +	buffer_selected = ent->payload_kvec.iov_base != NULL;
> +	has_payload = fuse_uring_req_has_payload(req);
> +
> +	if (has_payload && !buffer_selected)
> +		return fuse_uring_select_buffer(ent, issue_flags);
> +
> +	if (!has_payload && buffer_selected)
> +		fuse_uring_recycle_buffer(ent, issue_flags);
> +
> +	return 0;
> +}
> +
> +static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
> +				  struct fuse_req *req, unsigned issue_flags)
> +{
> +	if (!bufring_enabled(ent->queue))
> +		return 0;
> +
> +	/* no payload to copy, can skip selecting a buffer */
> +	if (!fuse_uring_req_has_payload(req))
> +		return 0;
> +
> +	return fuse_uring_select_buffer(ent, issue_flags);
> +}
> +
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
>  				   struct fuse_req *req)
>  {
> @@ -829,21 +1034,29 @@ static void fuse_uring_add_req_to_ring_ent(struct fuse_ring_ent *ent,
>  }
>  
>  /* Fetch the next fuse request if available */
> -static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent)
> +static struct fuse_req *fuse_uring_ent_assign_req(struct fuse_ring_ent *ent,
> +						  unsigned int issue_flags)
>  	__must_hold(&queue->lock)
>  {
>  	struct fuse_req *req;
>  	struct fuse_ring_queue *queue = ent->queue;
>  	struct list_head *req_queue = &queue->fuse_req_queue;
> +	int err;
>  
>  	lockdep_assert_held(&queue->lock);
>  
>  	/* get and assign the next entry while it is still holding the lock */
>  	req = list_first_entry_or_null(req_queue, struct fuse_req, list);
> -	if (req)
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> +	if (req) {
> +		err = fuse_uring_next_req_update_buffer(ent, req, issue_flags);
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			return req;
> +		}
> +	}
>  
> -	return req;
> +	fuse_uring_recycle_buffer(ent, issue_flags);
> +	return NULL;
>  }
>  
>  /*
> @@ -883,7 +1096,8 @@ static void fuse_uring_commit(struct fuse_ring_ent *ent, struct fuse_req *req,
>   * Else, there is no next fuse request and this returns false.
>   */
>  static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
> -					 struct fuse_ring_queue *queue)
> +					 struct fuse_ring_queue *queue,
> +					 unsigned int issue_flags)
>  {
>  	int err;
>  	struct fuse_req *req;
> @@ -891,7 +1105,7 @@ static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
>  retry:
>  	spin_lock(&queue->lock);
>  	fuse_uring_ent_avail(ent, queue);
> -	req = fuse_uring_ent_assign_req(ent);
> +	req = fuse_uring_ent_assign_req(ent, issue_flags);
>  	spin_unlock(&queue->lock);
>  
>  	if (req) {
> @@ -1003,8 +1217,14 @@ static int fuse_uring_commit_fetch(struct io_uring_cmd *cmd, int issue_flags,
>  	 * fuse requests would otherwise not get processed - committing
>  	 * and fetching is done in one step vs legacy fuse, which has separated
>  	 * read (fetch request) and write (commit result).
> +	 *
> +	 * If the server is using bufrings and has populated the ring with less
> +	 * payload buffers than ents, it is possible that there may not be an
> +	 * available buffer for the next request. If so, then the fetch is a
> +	 * no-op and the next request will be handled when a buffer becomes
> +	 * available.
>  	 */
> -	if (fuse_uring_get_next_fuse_req(ent, queue))
> +	if (fuse_uring_get_next_fuse_req(ent, queue, issue_flags))
>  		fuse_uring_send(ent, cmd, 0, issue_flags);
>  	return 0;
>  }
> @@ -1100,39 +1320,51 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cmd,
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
>  	int err;
>  
> -	err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> -	if (err) {
> -		pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
> -				    err);
> -		return ERR_PTR(err);
> -	}
> -
> -	err = -EINVAL;
> -	if (iov[0].iov_len < sizeof(struct fuse_uring_req_header)) {
> -		pr_info_ratelimited("Invalid header len %zu\n", iov[0].iov_len);
> -		return ERR_PTR(err);
> -	}
> -
> -	payload_size = iov[1].iov_len;
> -	if (payload_size < ring->max_payload_sz) {
> -		pr_info_ratelimited("Invalid req payload len %zu\n",
> -				    payload_size);
> -		return ERR_PTR(err);
> -	}
> -
> -	err = -ENOMEM;
>  	ent = kzalloc_obj(*ent, GFP_KERNEL_ACCOUNT);
>  	if (!ent)
> -		return ERR_PTR(err);
> +		return ERR_PTR(-ENOMEM);
>  
>  	INIT_LIST_HEAD(&ent->list);
>  
>  	ent->queue = queue;
> -	ent->headers = iov[0].iov_base;
> -	ent->payload = iov[1].iov_base;
> +
> +	if (bufring_enabled(queue)) {
> +		ent->id = READ_ONCE(cmd->sqe->buf_index);
> +		if (ent->id >= queue->bufring.queue_depth) {
> +			err = -EINVAL;
> +			goto error;
> +		}
> +	} else {
> +		err = fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> +		if (err) {
> +			pr_info_ratelimited("Failed to get iovec from sqe, err=%d\n",
> +					    err);
> +			goto error;
> +		}
> +
> +		err = -EINVAL;
> +		if (iov[0].iov_len < sizeof(struct fuse_uring_req_header)) {
> +			pr_info_ratelimited("Invalid header len %zu\n",
> +					    iov[0].iov_len);
> +			goto error;
> +		}
> +
> +		payload_size = iov[1].iov_len;
> +		if (payload_size < ring->max_payload_sz) {
> +			pr_info_ratelimited("Invalid req payload len %zu\n",
> +					    payload_size);
> +			goto error;
> +		}
> +		ent->headers = iov[0].iov_base;
> +		ent->payload = iov[1].iov_base;
> +	}
>  
>  	atomic_inc(&ring->queue_refs);
>  	return ent;
> +
> +error:
> +	kfree(ent);
> +	return ERR_PTR(err);
>  }
>  
>  /*
> @@ -1144,6 +1376,8 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  {
>  	const struct fuse_uring_cmd_req *cmd_req = io_uring_sqe128_cmd(cmd->sqe,
>  								       struct fuse_uring_cmd_req);
> +	unsigned int init_flags = READ_ONCE(cmd_req->flags);
> +	bool use_bufring = init_flags & FUSE_URING_BUF_RING;
>  	struct fuse_ring *ring = smp_load_acquire(&fc->ring);
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent;
> @@ -1164,9 +1398,13 @@ static int fuse_uring_register(struct io_uring_cmd *cmd,
>  
>  	queue = ring->queues[qid];
>  	if (!queue) {
> -		queue = fuse_uring_create_queue(ring, qid);
> -		if (!queue)
> -			return err;
> +		queue = fuse_uring_create_queue(cmd, ring, qid, use_bufring,
> +						issue_flags);
> +		if (IS_ERR(queue))
> +			return PTR_ERR(queue);
> +	} else {
> +		if (bufring_enabled(queue) != use_bufring)
> +			return -EINVAL;
>  	}
>  
>  	/*
> @@ -1270,7 +1508,8 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>  	if (!tw.cancel) {
>  		err = fuse_uring_prepare_send(ent, ent->fuse_req);
>  		if (err) {
> -			if (!fuse_uring_get_next_fuse_req(ent, queue))
> +			if (!fuse_uring_get_next_fuse_req(ent, queue,
> +							  issue_flags))
>  				return;
>  			err = 0;
>  		}
> @@ -1332,14 +1571,19 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *fiq, struct fuse_req *req)
>  	req->ring_queue = queue;
>  	ent = list_first_entry_or_null(&queue->ent_avail_queue,
>  				       struct fuse_ring_ent, list);
> -	if (ent)
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> -	else
> -		list_add_tail(&req->list, &queue->fuse_req_queue);
> -	spin_unlock(&queue->lock);
> +	if (ent) {
> +		err = fuse_uring_prep_buffer(ent, req, IO_URING_F_UNLOCKED);
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			spin_unlock(&queue->lock);
> +			fuse_uring_dispatch_ent(ent);
> +			return;
> +		}
> +		WARN_ON_ONCE(err != -ENOENT);
> +	}
>  
> -	if (ent)
> -		fuse_uring_dispatch_ent(ent);
> +	list_add_tail(&req->list, &queue->fuse_req_queue);
> +	spin_unlock(&queue->lock);
>  
>  	return;
>  
> @@ -1357,6 +1601,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	struct fuse_ring *ring = fc->ring;
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent = NULL;
> +	int err;
>  
>  	queue = fuse_uring_task_to_queue(ring);
>  	if (!queue)
> @@ -1389,14 +1634,15 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	req = list_first_entry_or_null(&queue->fuse_req_queue, struct fuse_req,
>  				       list);
>  	if (ent && req) {
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> -		spin_unlock(&queue->lock);
> -
> -		fuse_uring_dispatch_ent(ent);
> -	} else {
> -		spin_unlock(&queue->lock);
> +		err = fuse_uring_prep_buffer(ent, req, IO_URING_F_UNLOCKED);
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			spin_unlock(&queue->lock);
> +			fuse_uring_dispatch_ent(ent);
> +			return true;
> +		}
>  	}
> -
> +	spin_unlock(&queue->lock);
>  	return true;
>  }
>  
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 51a563922ce1..36496013e3e8 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -38,9 +38,31 @@ enum fuse_ring_req_state {
>  
>  /** A fuse ring entry, part of the ring queue */
>  struct fuse_ring_ent {
> -	/* userspace buffer */
> -	struct fuse_uring_req_header __user *headers;
> -	void __user *payload;
> +	union {
> +		/* queue->bufring.enabled == false */
> +		struct {
> +			/* userspace buffers */
> +			struct fuse_uring_req_header __user *headers;
> +			void __user *payload;
> +		};
> +		/* queue->bufring.enabled == true */
> +		struct {
> +			/*
> +			 * unique fixed id for the ent. Used by kernel/server to
> +			 * locate the header data.
> +			 */
> +			unsigned int id;
> +			/*
> +			 * id of the bufring buffer the ent is using for the
> +			 * current request. May differ per-request.
> +			 *
> +			 * this needs to be tracked so we can recycle the buffer
> +			 * back to the ring when the request is done.
> +			 */
> +			unsigned int buf_id;
> +			struct kvec payload_kvec;
> +		};
> +	};
>  
>  	/* the ring queue that owns the request */
>  	struct fuse_ring_queue *queue;
> @@ -99,6 +121,24 @@ struct fuse_ring_queue {
>  	unsigned int active_background;
>  
>  	bool stopped;
> +
> +	/*
> +	 * kernel-managed buffer ring support
> +	 *
> +	 * the following fields are only used if the server chooses to use
> +	 * bufrings
> +	 */
> +	struct {
> +		bool enabled: 1;
> +		unsigned int queue_depth;
> +		/*
> +		 * pointer to where the headers reside in the registered memory
> +		 * region
> +		 */
> +		void *headers;
> +		/* synchronized by the queue lock */
> +		struct io_buffer_list *list;
> +	} bufring;
>  };
>  
>  /**
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..8f6ab0693a3d 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,10 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *  - add FUSE_URING_BUF_RING flag
> + *  - add fuse_uring_cmd_req init struct
>   */
>  
>  #ifndef _LINUX_FUSE_H
> @@ -1294,6 +1298,9 @@ enum fuse_uring_cmd {
>  	FUSE_IO_URING_CMD_COMMIT_AND_FETCH = 2,
>  };
>  
> +/* fuse_uring_cmd_req flags */
> +#define FUSE_URING_BUF_RING	(1 << 0)
> +
>  /**
>   * In the 80B command area of the SQE.
>   */
> @@ -1305,7 +1312,17 @@ struct fuse_uring_cmd_req {
>  
>  	/* queue the command is for (queue index) */
>  	uint16_t qid;
> -	uint8_t padding[6];
> +
> +	union {
> +		struct {
> +			/*
> +			 * Byte offset into the ring's registered memory region.
> +			 * This is where the headers must reside.
> +			 */
> +			uint64_t headers_offset;
> +			uint16_t queue_depth;
> +		} init;
> +	};
>  };
>  
>  #endif /* _LINUX_FUSE_H */

