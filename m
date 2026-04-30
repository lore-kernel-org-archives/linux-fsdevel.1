Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6095B39150B
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777547339; cv=none; b=NkRFsOz0AkfuGhm3hJfM5txk1CiOdMPybeWgeR75HbU2f86bAPc46WZN3I9JzuV4TV/0ooNKLWMfcR9BBjXwqP1rwRfuW6aPf2ESf9ccm0qB47i9T4GjyeUjT34zFw2aQWwaWFn6w44aHs+1m6YRbzNWiT8/+Q+mGGvk+13C8Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777547339; c=relaxed/simple;
	bh=+Xy0HWjDtT5v3FTMKEEYqwO7djCBEFrxrxDTTP4J70Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KIPMwSoDvlD6F0rUKKQYJfdlrBFq9V8pTB7HXXWSi6UHUqjJN3a3gyN6QUrTqqUZ/uDKkb7ibcxT35LE0/1OZ87XsxB/2tIQCtbjjSPPfZpQZYvI0Jw0495EdjTUcazt415o0ZyayTiYIAvzMVAH1CD6UiryUUBLtOIEMfnjF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDs6yKxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDs6yKxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EE4FC2BCB4;
	Thu, 30 Apr 2026 11:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777547339;
	bh=+Xy0HWjDtT5v3FTMKEEYqwO7djCBEFrxrxDTTP4J70Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=UDs6yKxGBc20y/gJBbOnCv8FPCNX+TUozq/5cOwDcG5kzh8ndk2LPX8oPEpirLXeO
	 UZVpsvXqsRUnZunVzkzfrdyS8JSiGAIp0ZMZQMxnoPcS/UCRGEs6wIFgQSYsyyQGOP
	 3KN2rie08H9dzbnN7ISN5bcc/RyTU+ZyZnuS5+CcbOStJ8ezVFPsQjZiNMjMLj/afx
	 Cy6pI13aWN6sjxFZ2trNIT/SRVKbwdhT6CjQJinDuXHmz91PUO1lnC3w6ptWJpU92m
	 ekWK5fwjSS34XeYWqqaFtwjtgjzTqeQoDtIJEqR1EcsZbZY2j+43DDk5L5tPYX+Aqz
	 xdROvC8hn0x3Q==
Message-ID: <c6977f02cd8c341b80ec5e7cc1bf67e0e455d859.camel@kernel.org>
Subject: Re: [PATCH v2 10/14] fuse: add io-uring buffer rings
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 12:08:55 +0100
In-Reply-To: <20260402162840.2989717-11-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
	 <20260402162840.2989717-11-joannelkoong@gmail.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-02 at 09:28 -0700, Joanne Koong wrote:
> Add fuse buffer rings for servers communicating through the io-uring
> interface. To use this, the server must set the FUSE_URING_BUFRING
> flag and provide header and payload buffers via an iovec array in the
> sqe during registration. The payload buffers are used to back the buffer
> ring. The kernel manages buffer selection and recycling through a simple
> internal ring.
>=20
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
>=20
> Each ring entry gets a fixed ID (sqe->buf_index) that maps to a specific
> header slot in the headers buffer. Payload buffers are selected from
> the ring on demand and recycled after each request. Buffer ring usage is
> set on a per-queue basis. All subsequent registration SQEs for the same
> queue must use consistent flags.
>=20
> The headers are laid out contiguously and provided via iov[0]. Each slot
> maps to ent->id:
>=20
> > <- headers_size (>=3D queue_depth * sizeof(fuse_uring_req_header)) ->|
> +------------------------------+------------------------------+-----+
> > struct fuse_uring_req_header | struct fuse_uring_req_header | ... |
> >        [ent id=3D0]            |        [ent id=3D1]            |     |
> +------------------------------+------------------------------+-----+
>=20
> On the server side, the ent id is used to determine where in the headers
> buffer the headers data for the ent resides. This is done by
> calculating ent_id * sizeof(struct fuse_uring_req_header) as the offset
> into the headers buffer.
>=20
> The buffer ring is backed by the payload buffer, which is contiguous but
> partitioned into individual bufs according to the buf_size passed in at
> registration.
>=20
>   PAYLOAD BUFFER POOL (contiguous, provided via iov[1]):
>     |<-------------- payload_size ------------>|
>     +--------- --+-----------+-----------+-----+
>     |  buf [0]   |  buf [1]  |  buf [2]  | ... |
>     |  buf_size  |  buf_size |  buf_size | ... |
>     +--------- --+-----------+-----------+-----+
>=20
> buffer ring state (struct fuse_bufring, kernel-internal):
> bufs[]: [ used | used | FREE | FREE | FREE ]
> 			^^^^^^^^^^^^^^^^^^^
> 			available for selection
>=20
> The buffer ring logic is as follows:
> select:  buf =3D bufs[head % nbufs]; head++
> recycle: bufs[tail % nbufs] =3D buf; tail++
> empty:   tail =3D=3D head (no buffers available)
> full:    tail - head >=3D nbufs
>=20
> Buffer ring request flow
> ------------------------
> >  Kernel                                  |  FUSE daemon
> >                                          |
> >  [client request arrives]                |
> >  >fuse_uring_send()                      |
> >    [select payload buf from ring]        |
> >    >fuse_uring_select_buffer()           |
> >    [copy headers to ent's header slot]   |
> >    >copy_header_to_ring()                |
> >    [copy payload to selected buf]        |
> >    >fuse_uring_copy_to_ring()            |
> >    [set buf_id in ent_in_out header]     |
> >    >io_uring_cmd_done()                  |
> >                                          |  [CQE received]
> >                                          |  [read headers from header
> >                                          |    slot]
> >                                          |  [read payload from buf_id]
> >                                          |  [process request]
> >                                          |  [write reply to header
> >                                          |    slot]
> >                                          |  [write reply payload to
> >                                          |    buf]
> >                                          |  >io_uring_submit()
> >                                          |   COMMIT_AND_FETCH
> >  >fuse_uring_commit_fetch()              |
> >    >fuse_uring_commit()                  |
> >     [copy reply from ring]               |
> >     >fuse_uring_recycle_buffer()         |
> >    >fuse_uring_get_next_fuse_req()       |
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 363 +++++++++++++++++++++++++++++++++-----
>  fs/fuse/dev_uring_i.h     |  45 ++++-
>  include/uapi/linux/fuse.h |  27 ++-
>  3 files changed, 381 insertions(+), 54 deletions(-)
>=20
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index a061f175b3fd..9f14a2bcde3f 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -41,6 +41,11 @@ enum fuse_uring_header_type {
>  	FUSE_URING_HEADER_RING_ENT,
>  };
> =20
> +static inline bool bufring_enabled(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring !=3D NULL;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -222,6 +227,7 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		}
> =20
>  		kfree(queue->fpq.processing);
> +		kfree(queue->bufring);
>  		kfree(queue);
>  		ring->queues[qid] =3D NULL;
>  	}
> @@ -303,20 +309,102 @@ static int fuse_uring_get_iovec_from_sqe(const str=
uct io_uring_sqe *sqe,
>  	return 0;
>  }
> =20
> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring =
*ring,
> -						       int qid)
> +static int fuse_uring_bufring_setup(struct io_uring_cmd *cmd,
> +				     struct fuse_ring_queue *queue)
> +{
> +	const struct fuse_uring_cmd_req *cmd_req =3D
> +		io_uring_sqe128_cmd(cmd->sqe, struct fuse_uring_cmd_req);
> +	u16 queue_depth =3D READ_ONCE(cmd_req->init.queue_depth);
> +	unsigned int buf_size =3D READ_ONCE(cmd_req->init.buf_size);
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
> +	err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> +	if (err)
> +		return err;
> +
> +	headers =3D iov[FUSE_URING_IOV_HEADERS].iov_base;
> +	headers_size =3D iov[FUSE_URING_IOV_HEADERS].iov_len;
> +	payload =3D iov[FUSE_URING_IOV_PAYLOAD].iov_base;
> +	payload_size =3D iov[FUSE_URING_IOV_PAYLOAD].iov_len;
> +
> +	/* check if there's enough space for all the headers */
> +	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
> +		return -EINVAL;
> +
> +	if (buf_size < queue->ring->max_payload_sz)
> +		return -EINVAL;
> +
> +	nr_bufs =3D payload_size / buf_size;
> +	if (!nr_bufs || nr_bufs > U16_MAX)

What's the significance of U16_MAX here? It looks like the br->nbufs
field is an unsigned int. Is it because struct fuse_uring_ent_in_out
has buf_id as a u16?

Not that I think you'll ever need more than 2^16 buffers, just curious
about the limitation.

> +		return -EINVAL;
> +
> +	/* create the ring buffer */
> +	ring_size =3D struct_size(br, bufs, nr_bufs);
> +	br =3D kzalloc(ring_size, GFP_KERNEL_ACCOUNT);
> +	if (!br)
> +		return -ENOMEM;
> +
> +	br->queue_depth =3D queue_depth;
> +	br->headers =3D headers;
> +
> +	payload_addr =3D (uintptr_t)payload;
> +
> +	/* populate the ring buffer */
> +	for (i =3D 0; i < nr_bufs; i++, payload_addr +=3D buf_size) {
> +		struct fuse_bufring_buf *buf =3D &br->bufs[i];
> +
> +		buf->addr =3D payload_addr;
> +		buf->len =3D buf_size;
> +		buf->id =3D i;
> +	}
> +
> +	br->nbufs =3D nr_bufs;
> +	br->tail =3D nr_bufs;
> +
> +	queue->bufring =3D br;
> +
> +	return 0;
> +}
> +
> +/*
> + * if the queue is already registered, check that the queue was initiali=
zed with
> + * the same init flags set for this FUSE_IO_URING_CMD_REGISTER cmd. all
> + * FUSE_IO_URING_CMD_REGISTER cmds should have the same init fields set =
on a
> + * per-queue basis.
> + */
> +static bool queue_init_flags_consistent(struct fuse_ring_queue *queue,
> +					u64 init_flags)
>  {
> +	bool bufring =3D init_flags & FUSE_URING_BUFRING;
> +
> +	return bufring_enabled(queue) =3D=3D bufring;
> +}
> +
> +static struct fuse_ring_queue *
> +fuse_uring_create_queue(struct io_uring_cmd *cmd, struct fuse_ring *ring=
,
> +			int qid, u64 init_flags)
> +{
> +	bool use_bufring =3D init_flags & FUSE_URING_BUFRING;
>  	struct fuse_conn *fc =3D ring->fc;
>  	struct fuse_ring_queue *queue;
>  	struct list_head *pq;
> =20
>  	queue =3D kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
>  	if (!queue)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	pq =3D kzalloc_objs(struct list_head, FUSE_PQ_HASH_SIZE);
>  	if (!pq) {
>  		kfree(queue);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
> =20
>  	queue->qid =3D qid;
> @@ -334,12 +422,29 @@ static struct fuse_ring_queue *fuse_uring_create_qu=
eue(struct fuse_ring *ring,
>  	queue->fpq.processing =3D pq;
>  	fuse_pqueue_init(&queue->fpq);
> =20
> +	if (use_bufring) {
> +		int err =3D fuse_uring_bufring_setup(cmd, queue);
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

nit: presumably you could skip the if here. If use_bufring is false,
then queue->bufring _should_ be NULL.

>  		kfree(queue);
> -		return ring->queues[qid];
> +
> +		queue =3D ring->queues[qid];
> +		if (!queue_init_flags_consistent(queue, init_flags))
> +			return ERR_PTR(-EINVAL);
> +		return queue;
>  	}
> =20
>  	/*
> @@ -649,7 +754,14 @@ static int copy_header_to_ring(struct fuse_ring_ent =
*ent,
>  	if (offset < 0)
>  		return offset;
> =20
> -	ring =3D (void __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset =3D offset +
> +			sizeof(struct fuse_uring_req_header) * ent->id;
> +
> +		ring =3D ent->queue->bufring->headers + buf_offset;
> +	} else {
> +		ring =3D (void __user *)ent->headers + offset;
> +	}
> =20
>  	if (copy_to_user(ring, header, header_size)) {
>  		pr_info_ratelimited("Copying header to ring failed.\n");
> @@ -669,7 +781,14 @@ static int copy_header_from_ring(struct fuse_ring_en=
t *ent,
>  	if (offset < 0)
>  		return offset;
> =20
> -	ring =3D (void __user *)ent->headers + offset;
> +	if (bufring_enabled(ent->queue)) {
> +		int buf_offset =3D offset +
> +			sizeof(struct fuse_uring_req_header) * ent->id;
> +
> +		ring =3D ent->queue->bufring->headers + buf_offset;
> +	} else {
> +		ring =3D (void __user *)ent->headers + offset;
> +	}
> =20
>  	if (copy_from_user(header, ring, header_size)) {
>  		pr_info_ratelimited("Copying header from ring failed.\n");
> @@ -684,12 +803,20 @@ static int setup_fuse_copy_state(struct fuse_copy_s=
tate *cs,
>  				 struct fuse_ring_ent *ent, int dir,
>  				 struct iov_iter *iter)
>  {
> +	void __user *payload;
>  	int err;
> =20
> -	err =3D import_ubuf(dir, ent->payload, ring->max_payload_sz, iter);
> -	if (err) {
> -		pr_info_ratelimited("fuse: Import of user buffer failed\n");
> -		return err;
> +	if (bufring_enabled(ent->queue))
> +		payload =3D (void __user *)ent->payload_buf.addr;
> +	else
> +		payload =3D ent->payload;
> +
> +	if (payload) {
> +		err =3D import_ubuf(dir, payload, ring->max_payload_sz, iter);
> +		if (err) {
> +			pr_info_ratelimited("fuse: Import of user buffer failed\n");
> +			return err;
> +		}
>  	}
> =20
>  	fuse_copy_init(cs, dir =3D=3D ITER_DEST, iter);
> @@ -741,6 +868,9 @@ static int fuse_uring_args_to_ring(struct fuse_ring *=
ring, struct fuse_req *req,
>  		.commit_id =3D req->in.h.unique,
>  	};
> =20
> +	if (bufring_enabled(ent->queue))
> +		ent_in_out.buf_id =3D ent->payload_buf.id;
> +
>  	err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
>  	if (err)
>  		return err;
> @@ -805,6 +935,96 @@ static int fuse_uring_copy_to_ring(struct fuse_ring_=
ent *ent,
>  				   sizeof(req->in.h));
>  }
> =20
> +static bool fuse_uring_req_has_payload(struct fuse_req *req)
> +{
> +	struct fuse_args *args =3D req->args;
> +
> +	return args->in_numargs > 1 || args->out_numargs;
> +}
> +
> +static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
> +	__must_hold(&ent->queue->lock)
> +{
> +	struct fuse_ring_queue *queue =3D ent->queue;
> +	struct fuse_bufring *br =3D queue->bufring;
> +	struct fuse_bufring_buf *buf;
> +	unsigned int tail =3D br->tail, head =3D br->head;
> +
> +	lockdep_assert_held(&queue->lock);
> +
> +	/* Get a buffer to use for the payload */
> +	if (tail =3D=3D head)
> +		return -ENOBUFS;
> +
> +	buf =3D &br->bufs[head % br->nbufs];
> +	br->head++;
> +
> +	ent->payload_buf =3D *buf;
> +
> +	return 0;
> +}
> +
> +static void fuse_uring_recycle_buffer(struct fuse_ring_ent *ent)
> +	__must_hold(&ent->queue->lock)
> +{
> +	struct fuse_bufring_buf *ent_payload =3D &ent->payload_buf;
> +	struct fuse_ring_queue *queue =3D ent->queue;
> +	struct fuse_bufring_buf *buf;
> +	struct fuse_bufring *br;
> +
> +	lockdep_assert_held(&queue->lock);
> +
> +	if (!bufring_enabled(queue) || !ent_payload->addr)
> +		return;
> +
> +	br =3D queue->bufring;
> +
> +	/* ring should never be full */
> +	WARN_ON_ONCE(br->tail - br->head >=3D br->nbufs);
> +
> +	buf =3D &br->bufs[(br->tail) % br->nbufs];
> +
> +	*buf =3D *ent_payload;
> +
> +	br->tail++;
> +
> +	memset(ent_payload, 0, sizeof(*ent_payload));
> +}
> +
> +static int fuse_uring_next_req_update_buffer(struct fuse_ring_ent *ent,
> +					     struct fuse_req *req)
> +{
> +	bool buffer_selected;
> +	bool has_payload;
> +
> +	if (!bufring_enabled(ent->queue))
> +		return 0;
> +
> +	buffer_selected =3D !!ent->payload_buf.addr;
> +	has_payload =3D fuse_uring_req_has_payload(req);
> +
> +	if (has_payload && !buffer_selected)
> +		return fuse_uring_select_buffer(ent);
> +
> +	if (!has_payload && buffer_selected)
> +		fuse_uring_recycle_buffer(ent);
> +
> +	return 0;
> +}
> +
> +static int fuse_uring_prep_buffer(struct fuse_ring_ent *ent,
> +				  struct fuse_req *req)
> +{
> +	if (!bufring_enabled(ent->queue))
> +		return 0;
> +
> +	/* no payload to copy, can skip selecting a buffer */
> +	if (!fuse_uring_req_has_payload(req))
> +		return 0;
> +
> +	return fuse_uring_select_buffer(ent);
> +}
> +
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
>  				   struct fuse_req *req)
>  {
> @@ -878,10 +1098,21 @@ static struct fuse_req *fuse_uring_ent_assign_req(=
struct fuse_ring_ent *ent)
> =20
>  	/* get and assign the next entry while it is still holding the lock */
>  	req =3D list_first_entry_or_null(req_queue, struct fuse_req, list);
> -	if (req)
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> +	if (req) {
> +		int err =3D fuse_uring_next_req_update_buffer(ent, req);
> =20
> -	return req;
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			return req;
> +		}
> +	}
> +
> +	/*
> +	 * Buffer selection may fail if all the buffers are currently saturated=
.
> +	 * The request will be serviced when a buffer is freed up.
> +	 */
> +	fuse_uring_recycle_buffer(ent);
> +	return NULL;
>  }
> =20
>  /*
> @@ -1041,6 +1272,12 @@ static int fuse_uring_commit_fetch(struct io_uring=
_cmd *cmd, int issue_flags,
>  	 * fuse requests would otherwise not get processed - committing
>  	 * and fetching is done in one step vs legacy fuse, which has separated
>  	 * read (fetch request) and write (commit result).
> +	 *
> +	 * If the server is using bufrings and has populated the ring with less
> +	 * payload buffers than ents, it is possible that there may not be an
> +	 * available buffer for the next request. If so, then the fetch is a
> +	 * no-op and the next request will be serviced when a buffer becomes
> +	 * available.
>  	 */
>  	if (fuse_uring_get_next_fuse_req(ent, queue))
>  		fuse_uring_send(ent, cmd, 0, issue_flags);
> @@ -1120,30 +1357,38 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *c=
md,
> =20
>  	ent->queue =3D queue;
> =20
> -	err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> -	if (err) {
> -		pr_info_ratelimited("Failed to get iovec from sqe, err=3D%d\n",
> -				    err);
> -		goto error;
> -	}
> +	if (bufring_enabled(queue)) {
> +		ent->id =3D READ_ONCE(cmd->sqe->buf_index);
> +		if (ent->id >=3D queue->bufring->queue_depth) {
> +			err =3D -EINVAL;
> +			goto error;
> +		}
> +	} else {
> +		err =3D fuse_uring_get_iovec_from_sqe(cmd->sqe, iov);
> +		if (err) {
> +			pr_info_ratelimited("Failed to get iovec from sqe, err=3D%d\n",
> +					    err);
> +			goto error;
> +		}
> =20
> -	err =3D -EINVAL;
> -	headers =3D &iov[FUSE_URING_IOV_HEADERS];
> -	if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
> -		pr_info_ratelimited("Invalid header len %zu\n", headers->iov_len);
> -		goto error;
> -	}
> +		err =3D -EINVAL;
> +		headers =3D &iov[FUSE_URING_IOV_HEADERS];
> +		if (headers->iov_len < sizeof(struct fuse_uring_req_header)) {
> +			pr_info_ratelimited("Invalid header len %zu\n",
> +					    headers->iov_len);
> +			goto error;
> +		}
> =20
> -	payload =3D &iov[FUSE_URING_IOV_PAYLOAD];
> -	if (payload->iov_len < ring->max_payload_sz) {
> -		pr_info_ratelimited("Invalid req payload len %zu\n",
> -				    payload->iov_len);
> -		goto error;
> +		payload =3D &iov[FUSE_URING_IOV_PAYLOAD];
> +		if (payload->iov_len < ring->max_payload_sz) {
> +			pr_info_ratelimited("Invalid req payload len %zu\n",
> +					    payload->iov_len);
> +			goto error;
> +		}
> +		ent->headers =3D headers->iov_base;
> +		ent->payload =3D payload->iov_base;
>  	}
> =20
> -	ent->headers =3D headers->iov_base;
> -	ent->payload =3D payload->iov_base;
> -
>  	atomic_inc(&ring->queue_refs);
>  	return ent;
> =20
> @@ -1152,6 +1397,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *cm=
d,
>  	return ERR_PTR(err);
>  }
> =20
> +static bool init_flags_valid(u64 init_flags)
> +{
> +	u64 valid_flags =3D FUSE_URING_BUFRING;
> +
> +	return !(init_flags & ~valid_flags);
> +}
> +
>  /*
>   * Register header and payload buffer with the kernel and puts the
>   * entry as "ready to get fuse requests" on the queue
> @@ -1161,6 +1413,7 @@ static int fuse_uring_register(struct io_uring_cmd =
*cmd,
>  {
>  	const struct fuse_uring_cmd_req *cmd_req =3D io_uring_sqe128_cmd(cmd->s=
qe,
>  								       struct fuse_uring_cmd_req);
> +	u64 init_flags =3D READ_ONCE(cmd_req->flags);
>  	struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent;
> @@ -1179,11 +1432,16 @@ static int fuse_uring_register(struct io_uring_cm=
d *cmd,
>  		return -EINVAL;
>  	}
> =20
> +	if (!init_flags_valid(init_flags))
> +		return -EINVAL;
> +
>  	queue =3D ring->queues[qid];
>  	if (!queue) {
> -		queue =3D fuse_uring_create_queue(ring, qid);
> -		if (!queue)
> -			return err;
> +		queue =3D fuse_uring_create_queue(cmd, ring, qid, init_flags);
> +		if (IS_ERR(queue))
> +			return PTR_ERR(queue);
> +	} else if (!queue_init_flags_consistent(queue, init_flags)) {
> +		return -EINVAL;
>  	}
> =20
>  	/*
> @@ -1349,14 +1607,18 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue=
 *fiq, struct fuse_req *req)
>  	req->ring_queue =3D queue;
>  	ent =3D list_first_entry_or_null(&queue->ent_avail_queue,
>  				       struct fuse_ring_ent, list);
> -	if (ent)
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> -	else
> -		list_add_tail(&req->list, &queue->fuse_req_queue);
> -	spin_unlock(&queue->lock);
> +	if (ent) {
> +		err =3D fuse_uring_prep_buffer(ent, req);
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			spin_unlock(&queue->lock);
> +			fuse_uring_dispatch_ent(ent);
> +			return;
> +		}
> +	}
> =20
> -	if (ent)
> -		fuse_uring_dispatch_ent(ent);
> +	list_add_tail(&req->list, &queue->fuse_req_queue);
> +	spin_unlock(&queue->lock);
> =20
>  	return;
> =20
> @@ -1406,14 +1668,17 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req=
)
>  	req =3D list_first_entry_or_null(&queue->fuse_req_queue, struct fuse_re=
q,
>  				       list);
>  	if (ent && req) {
> -		fuse_uring_add_req_to_ring_ent(ent, req);
> -		spin_unlock(&queue->lock);
> +		int err =3D fuse_uring_prep_buffer(ent, req);
> =20
> -		fuse_uring_dispatch_ent(ent);
> -	} else {
> -		spin_unlock(&queue->lock);
> +		if (!err) {
> +			fuse_uring_add_req_to_ring_ent(ent, req);
> +			spin_unlock(&queue->lock);
> +			fuse_uring_dispatch_ent(ent);
> +			return true;
> +		}
>  	}
> =20
> +	spin_unlock(&queue->lock);
>  	return true;
>  }
> =20
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 349418db3374..66d5d5f8dc3f 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -36,11 +36,47 @@ enum fuse_ring_req_state {
>  	FRRS_RELEASED,
>  };
> =20
> +struct fuse_bufring_buf {
> +	uintptr_t addr;
> +	unsigned int len;
> +	unsigned int id;
> +};
> +
> +struct fuse_bufring {
> +	/* pointer to the headers buffer */
> +	void __user *headers;
> +
> +	unsigned int queue_depth;
> +
> +	/* metadata tracking state of the bufring */
> +	unsigned int nbufs;
> +	unsigned int head;
> +	unsigned int tail;
> +
> +	/* the buffers backing the ring */
> +	__DECLARE_FLEX_ARRAY(struct fuse_bufring_buf, bufs);
> +};
> +
>  /** A fuse ring entry, part of the ring queue */
>  struct fuse_ring_ent {
> -	/* userspace buffer */
> -	struct fuse_uring_req_header __user *headers;
> -	void __user *payload;
> +	union {
> +		/* if bufrings are not used */
> +		struct {
> +			/* userspace buffers */
> +			struct fuse_uring_req_header __user *headers;
> +			void __user *payload;
> +		};
> +		/* if bufrings are used */
> +		struct {
> +			/*
> +			 * unique fixed id for the ent. used by kernel/server to
> +			 * locate where in the headers buffer the data for this
> +			 * ent resides
> +			 */
> +			unsigned int id;
> +			struct fuse_bufring_buf payload_buf;
> +		};
> +	};
> =20
>  	/* the ring queue that owns the request */
>  	struct fuse_ring_queue *queue;
> @@ -99,6 +135,9 @@ struct fuse_ring_queue {
>  	unsigned int active_background;
> =20
>  	bool stopped;
> +
> +	/* only allocated if the server uses bufrings */
> +	struct fuse_bufring *bufring;
>  };
> =20
>  /**
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12..8753de7eb189 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -240,6 +240,10 @@
>   *  - add FUSE_COPY_FILE_RANGE_64
>   *  - add struct fuse_copy_file_range_out
>   *  - add FUSE_NOTIFY_PRUNE
> + *
> + *  7.46
> + *  - add FUSE_URING_BUFRING flag
> + *  - add fuse_uring_cmd_req init struct
>   */
> =20
>  #ifndef _LINUX_FUSE_H
> @@ -1263,7 +1267,13 @@ struct fuse_uring_ent_in_out {
> =20
>  	/* size of user payload buffer */
>  	uint32_t payload_sz;
> -	uint32_t padding;
> +
> +	/*
> +	 * if using bufrings, this is the id of the selected buffer.
> +	 * the selected buffer holds the request payload
> +	 */
> +	uint16_t buf_id;
> +	uint16_t padding;
> =20
>  	uint64_t reserved;
>  };
> @@ -1294,6 +1304,9 @@ enum fuse_uring_cmd {
>  	FUSE_IO_URING_CMD_COMMIT_AND_FETCH =3D 2,
>  };
> =20
> +/* fuse_uring_cmd_req flags */
> +#define FUSE_URING_BUFRING		(1 << 0)
> +
>  /**
>   * In the 80B command area of the SQE.
>   */
> @@ -1305,7 +1318,17 @@ struct fuse_uring_cmd_req {
> =20
>  	/* queue the command is for (queue index) */
>  	uint16_t qid;
> -	uint8_t padding[6];
> +	uint16_t padding;
> +
> +	union {
> +		struct {
> +			/* size of the bufring's backing buffers */
> +			uint32_t buf_size;
> +			/* number of entries in the queue */
> +			uint16_t queue_depth;
> +			uint16_t padding;
> +		} init;
> +	};
>  };
> =20
>  #endif /* _LINUX_FUSE_H */

Overall, this looks good though.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
