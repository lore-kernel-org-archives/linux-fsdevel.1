Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DBC17A31E
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 23:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778024734; cv=none; b=C7U4MUd9ogBdc8D2WSP2AYiiv3FAWw25XWQWr99HeTm8PGMQ8ArDRSMw7LcLWbJPYLB/JsL1RgMYcczYUlk9g4iG09vA3AoRWaULWyjZJzsQfOApy+DOWRlUJgFGnuP64BJuxr8vS2gis8W9TqkjOdC6lx5oE+ndX4lxUI6FN10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778024734; c=relaxed/simple;
	bh=MYaW/X5HDB3e/alCxXpoSNzuQeFH6zSMQRzc65gEK80=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpKe+MkTOgV6NWhIc/EgIabsWitz8j9kVW5bL+jwb0ZNHVufigMLSK2KSLunJREq20AuZoyEFilyWISwXAmLoHWYB8SOcdyiYuYJ23sBPoQI8RmLwMgI58iFva3fImkNQSwPWR5D929TK6bPWiZmyS3KyLAttjygjC0Hjj7ih5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=HwPiP685; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j2xkGAiy; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="HwPiP685";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j2xkGAiy"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A3EE61400135;
	Tue,  5 May 2026 19:45:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 19:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778024731;
	 x=1778111131; bh=d+MwDueIDg1FCCHHt87kvAAmMPmHi9pNGLHRF2asQiM=; b=
	HwPiP685P7RLveNMrmbm//EFU01tDWPQzYMdxZo4CMXFpIZs6ScjMiFOv18Or+cZ
	4h9CHmTIcDd7kxe/JObaGS/kr3qm5ht0LDbgibqsbzfmiEy/m2DSCv6+9eXelAMQ
	g82PzObY1ry/wnbwa54Ui9YhQPUPM+ZiVLls5owbSoYLZlJac7TluqP8jwbOUJbi
	4qaqWaCU6ARPYIertB+yYyH3etDJkC0v0UIbsyYs02tVmTLM3s3kau16MJaW3PcG
	zp9/dwAmzMC4hMZKkE6HDdfquHwTGuAIT/Z6ZfbR563gYp6iL0IIk7l2UW4AWgPr
	tADYzximjTO+tZi2fVvMbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778024731; x=
	1778111131; bh=d+MwDueIDg1FCCHHt87kvAAmMPmHi9pNGLHRF2asQiM=; b=j
	2xkGAiyM00Mv/jUeJ/ccm9KJPLSuZqm1AW8vHCOQBjdSS6x9u5hP7vrxP09qexlT
	zWkC1ZLSm4fRktjbcg8ULCARrcI0m6urYB5tnFvbcQ14c9Sg+T1xth9cHoKi+b/Z
	De2cr+ORp6eDFgCOflmITCs+Ro7cnaaZUow+W+nBZsOoH/ev3K3pRMPQVnRqrP78
	fgPOealRpm1C43Pv17kbQ7ZE5VkXI43ATGjZdOM1nblDmg4wW/h5G5ipOOHnUwAG
	t8IT2uZxAr6HIrz4tzIg8IncUHqs6UzNsslpLHYO0CzOrrycOvG0Vahb7hNJvnSR
	961y6mjYP9R7mIg8ceOQg==
X-ME-Sender: <xms:G4H6aThFcUt5fCcwqdzRTDkKK8wfPY38d-VkCG3bYhLafE9by17Trw>
    <xme:G4H6aXCJOabpDi0UwV83jqWwIygCttPLU-JRqMyqvPHlgFpaOdFcJoZSJfLtFC1Dz
    4bpnCZBDvO3Nll2Hrao9xrc4Xh4nM4IfYEuEEOjKUHtTzG3_60J>
X-ME-Received: <xmr:G4H6aYEyJLn4j3F_t6Gcvh-v8vskm3JPJUNOpTjSiyQySimKS-_ZH1ktWkCasA-I_5VMqX6hmFshSA6mLFoS5A8rPaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdeftdeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:G4H6afJ01Z8QMTg4my2GuTos9d7clSazyR1O1-CsJDpUeI7qSXMrVA>
    <xmx:G4H6aclsTS2NjKbVeiBQ1yELkdtFpgdoO2UUKi_KIi098OjSf1Waew>
    <xmx:G4H6aXQ1lr8D3vybAUdWE0bZKZi74Ze_Evnr5f1uKJ4acZxOoD2Gww>
    <xmx:G4H6aeIN1u1KLf71RcYDhaLVN1GiDOSg0zvcS0ZElv8R_y5dpIclSA>
    <xmx:G4H6adfUePH5T7n_d20SB8w70NPzHlBvz7ST1SqOkhP1FcEapS0Poxqu>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 19:45:27 -0400 (EDT)
Message-ID: <45e57cb2-6b0c-46b7-b614-a32eb9aa394c@bsbernd.com>
Date: Wed, 6 May 2026 01:45:24 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-14-joannelkoong@gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260402162840.2989717-14-joannelkoong@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 18:28, Joanne Koong wrote:
> Implement zero-copy data transfer for fuse over io-uring, eliminating
> memory copies between userspace, the kernel, and the fuse server for
> page-backed read/write operations.
> 
> When the FUSE_URING_ZERO_COPY flag is set alongside FUSE_URING_BUFRING,
> the kernel registers the client's underlying pages as a sparse buffer at
> the entry's fixed id via io_buffer_register_bvec(). The fuse server can
> then perform io_uring read/write operations directly on these pages.
> Non-page-backed args (eg out headers) go through the payload buffer as
> normal.
> 
> This requires CAP_SYS_ADMIN and buffer rings with pinned headers and
> buffers. Gating on pinned headers and buffers keeps the configuration
> space small and avoids partially-optimized modes that are unlikely to be
> useful in practice. Pages are unregistered when the request completes.
> 
> The request flow for the zero-copy write path (client writes data,
> server reads it) is as follows:
> =======================================================================
> |  Kernel                                   |  FUSE server
> |                                           |
> |  "write(fd, buf, 1MB)"                    |
> |                                           |
> |  >sys_write()                             |
> |    >fuse_file_write_iter()                |
> |      >fuse_send_one()                     |
> |        [req->args->in_pages = true]       |
> |        [folios hold client write data]    |
> |                                           |
> |  >fuse_uring_copy_to_ring()               |
> |    >copy_header_to_ring(IN_OUT)           |
> |      [memcpy fuse_in_header to            |
> |       pinned headers buf via kaddr]       |
> |    >copy_header_to_ring(OP)               |
> |      [memcpy write_in header]             |
> |                                           |
> |    >fuse_uring_args_to_ring()             |
> |      >setup_fuse_copy_state()             |
> |        [is_kaddr = true]                  |
> |        [skip_folio_copy = true]           |
> |                                           |
> |      >fuse_uring_set_up_zero_copy()       |
> |        [folio_get for each client folio]  |
> |        [build bio_vec array from folios]  |
> |        >io_buffer_register_bvec()         |
> |          [register pages at ent->id]      |

Somehow I find ent->id really confusing here. ent->slot_idx? Or even
ent->tag?

> |        [ent->zero_copied = true]          |
> |                                           |
> |      >fuse_copy_args()                    |
> |        [skip_folio_copy => return 0       |
> |         for page arg, skip data copy]     |
> |                                           |
> |    >copy_header_to_ring(RING_ENT)         |
> |      [memcpy ent_in_out]                  |
> |    >io_uring_cmd_done()                   |
> |                                           |
> |                                           | [CQE received]
> |                                           |
> |                                           | [issue io_uring READ at
> |                                           |  ent->id]
> |                                           | [reads directly from
> |                                           |client's pages (ZERO_COPY)]
> |                                           |
> |                                           | [write data to backing
> |                                           | store]
> |                                           |  [submit COMMIT AND FETCH]
> |                                           |
> |  >fuse_uring_commit_fetch()               |
> |    >fuse_uring_commit()                   |
> |      >fuse_uring_copy_from_ring()         |
> |    >fuse_uring_req_end()                  |
> |      >io_buffer_unregister(ent->id)       |
> |        [unregister sparse buffer]         |
> |      >fuse_zero_copy_release()            |
> |        [folio_put for each folio]         |
> |      [ent->zero_copied = false]           |
> |      >fuse_request_end()                  |
> |        [wake up client]                   |
> 
> The zero-copy read path is analogous.
> 
> Some requests may have both page-backed args and non-page-backed args.
> For these requests, the page-backed args are zero-copied while the
> non-page-backed args are copied to the buffer selected from the buffer
> ring:
>     zero-copy: pages registered via io_buffer_register_bvec()
>     non-page-backed: copied to payload buffer via fuse_copy_args()
> 
> For a request whose payload is zero-copied, the
> registration/unregistration path looks like:
> 
>     register:  fuse_uring_set_up_zero_copy()
>                  folio_get() for each folio
>                  io_buffer_register_bvec(ent->id)
> 
>     [server accesses pages via io_uring fixed buf at ent->id]
> 
>     unregister: fuse_uring_req_end()
>                   io_buffer_unregister(ent->id)
>                   -> fuse_zero_copy_release() callback
>                      folio_put() for each folio
> 
> The throughput improvement from zero-copy depends on how much of the
> per-request latency is spent on data copying vs backing I/O. When
> backing I/O dominates, the saved memcpy is a negligible fraction of
> overall latency. Please also note that for the server to read/write
> into the zero-copied pages, the read/write must go through io-uring
> as an IORING_OP_READ_FIXED / IORING_OP_WRITE_FIXED operation. If the
> server's backing I/O is instantaneous (eg served from cache), the
> overhead of the additional io_uring operation may negate the savings
> from eliminating the memcpy.
> 
> In benchmarks using passthrough_hp on a high-performance NVMe-backed
> system, zero-copy showed around a 35% throughput improvement for direct
> randreads (~2150 MiB/s to ~2900 MiB/s), a 15% improvement for direct
> sequential reads (~2510 MiB/s to ~2900 MiB/s), a 15% improvement for
> buffered randreads (~2100 MiB/s to ~2470 MiB/s), and a 10% improvement
> for buffered sequential reads (~2500 MiB/s to ~2750 MiB/s).
> 
> The benchmarks were run using:
>   fio --name=test_run --ioengine=sync --rw=rand{read,write} --bs=1M
>   --size=1G --numjobs=2 --ramp_time=30 --group_reporting=1
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c             |   7 +-
>  fs/fuse/dev_uring.c       | 167 +++++++++++++++++++++++++++++++++-----
>  fs/fuse/dev_uring_i.h     |   4 +
>  fs/fuse/fuse_dev_i.h      |   1 +
>  include/uapi/linux/fuse.h |   5 ++
>  5 files changed, 160 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index a87939eaa103..cd326e61831b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1233,10 +1233,13 @@ int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
>  
>  	for (i = 0; !err && i < numargs; i++)  {
>  		struct fuse_arg *arg = &args[i];
> -		if (i == numargs - 1 && argpages)
> +		if (i == numargs - 1 && argpages) {
> +			if (cs->skip_folio_copy)
> +				return 0;
>  			err = fuse_copy_folios(cs, arg->size, zeroing);
> -		else
> +		} else {
>  			err = fuse_copy_one(cs, arg->value, arg->size);
> +		}
>  	}
>  	return err;
>  }
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 06d3d8dc1c82..d9f1ee4beaf3 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -31,6 +31,11 @@ struct fuse_uring_pdu {
>  	struct fuse_ring_ent *ent;
>  };
>  
> +struct fuse_zero_copy_bvs {
> +	unsigned int nr_bvs;
> +	struct bio_vec bvs[];
> +};
> +
>  static const struct fuse_iqueue_ops fuse_io_uring_ops;
>  
>  enum fuse_uring_header_type {
> @@ -57,6 +62,11 @@ static inline bool bufring_pinned_buffers(struct fuse_ring_queue *queue)
>  	return queue->bufring->use_pinned_buffers;
>  }
>  
> +static inline bool bufring_zero_copy(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring->use_zero_copy;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -102,8 +112,18 @@ static void fuse_uring_flush_bg(struct fuse_ring_queue *queue)
>  	}
>  }
>  
> +static bool can_zero_copy_req(struct fuse_ring_ent *ent, struct fuse_req *req)
> +{
> +	struct fuse_args *args = req->args;
> +
> +	if (!bufring_enabled(ent->queue) || !bufring_zero_copy(ent->queue))
> +		return false;
> +
> +	return args->in_pages || args->out_pages;
> +}
> +
>  static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
> -			       int error)
> +			       int error, unsigned int issue_flags)
>  {
>  	struct fuse_ring_queue *queue = ent->queue;
>  	struct fuse_ring *ring = queue->ring;
> @@ -122,6 +142,11 @@ static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_req *req,
>  
>  	spin_unlock(&queue->lock);
>  
> +	if (ent->zero_copied) {
> +		io_buffer_unregister(ent->cmd, ent->id, issue_flags);
> +		ent->zero_copied = false;
> +	}
> +
>  	if (error)
>  		req->out.h.error = error;
>  
> @@ -485,6 +510,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
>  	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
>  	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
> +	bool zero_copy = init_flags & FUSE_URING_ZERO_COPY;
>  	void __user *payload, *headers;
>  	size_t headers_size, payload_size, ring_size;
>  	struct fuse_bufring *br;
> @@ -508,7 +534,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
>  	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
>  		return -EINVAL;
>  
> -	if (buf_size < queue->ring->max_payload_sz)
> +	if (!zero_copy && buf_size < queue->ring->max_payload_sz)
>  		return -EINVAL;
>  
>  	nr_bufs = payload_size / buf_size;
> @@ -521,6 +547,7 @@ static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
>  	if (!br)
>  		return -ENOMEM;
>  
> +	br->use_zero_copy = zero_copy;
>  	br->queue_depth = queue_depth;
>  	if (pinned_headers) {
>  		err = fuse_bufring_pin_mem(&br->pinned_headers, headers,
> @@ -580,6 +607,7 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
>  	bool bufring = init_flags & FUSE_URING_BUFRING;
>  	bool pinned_headers = init_flags & FUSE_URING_PINNED_HEADERS;
>  	bool pinned_bufs = init_flags & FUSE_URING_PINNED_BUFFERS;
> +	bool zero_copy = init_flags & FUSE_URING_ZERO_COPY;
>  
>  	if (bufring_enabled(queue) != bufring)
>  		return false;
> @@ -588,7 +616,8 @@ static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
>  		return true;
>  
>  	return bufring_pinned_headers(queue) == pinned_headers &&
> -		bufring_pinned_buffers(queue) == pinned_bufs;
> +		bufring_pinned_buffers(queue) == pinned_bufs &&
> +		bufring_zero_copy(queue) == zero_copy;
>  }
>  
>  static struct fuse_ring_queue *
> @@ -1063,6 +1092,7 @@ static int setup_fuse_copy_state(struct fuse_copy_state *cs,
>  		cs->is_kaddr = true;
>  		cs->kaddr = (void *)ent->payload_buf.addr;
>  		cs->len = ent->payload_buf.len;
> +		cs->skip_folio_copy = ent->zero_copied;
>  	}
>  
>  	cs->is_uring = true;
> @@ -1095,11 +1125,70 @@ static int fuse_uring_copy_from_ring(struct fuse_ring *ring,
>  	return err;
>  }
>  
> +static void fuse_zero_copy_release(void *priv)
> +{
> +	struct fuse_zero_copy_bvs *zc_bvs = priv;
> +	unsigned int i;
> +
> +	for (i = 0; i < zc_bvs->nr_bvs; i++)
> +		folio_put(page_folio(zc_bvs->bvs[i].bv_page));
> +
> +	kfree(zc_bvs);
> +}
> +
> +static int fuse_uring_set_up_zero_copy(struct fuse_ring_ent *ent,
> +				       struct fuse_req *req,
> +				       unsigned int issue_flags)
> +{
> +	struct fuse_args_pages *ap;
> +	int err, i, ddir = 0;
> +	struct fuse_zero_copy_bvs *zc_bvs;
> +	struct bio_vec *bvs;
> +
> +	/* out_pages indicates a read, in_pages indicates a write */
> +	if (req->args->out_pages)
> +		ddir |= IO_BUF_DEST;
> +	if (req->args->in_pages)
> +		ddir |= IO_BUF_SOURCE;
> +
> +	WARN_ON_ONCE(!ddir);
> +
> +	ap = container_of(req->args, typeof(*ap), args);
> +
> +	zc_bvs = kmalloc(struct_size(zc_bvs, bvs, ap->num_folios),
> +			 GFP_KERNEL_ACCOUNT);
> +	if (!zc_bvs)
> +		return -ENOMEM;
> +
> +	zc_bvs->nr_bvs = ap->num_folios;
> +	bvs = zc_bvs->bvs;
> +	for (i = 0; i < ap->num_folios; i++) {
> +		bvs[i].bv_page = folio_page(ap->folios[i], 0);

Hmm, I thought everything was prepared for huge folios? Shouldn't this
function here be updated to handle that? Iterate over all folios add up
the number of pages and then iterate over all folios and pages?

> +		bvs[i].bv_offset = ap->descs[i].offset;
> +		bvs[i].bv_len = ap->descs[i].length;
> +		folio_get(ap->folios[i]);
> +	}
> +

Maybe a commment here like

/* ent->id is used in fuse-server with io_uring_prep_{write,read}_fixed */ ?


Thanks,
Bernd
