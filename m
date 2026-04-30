Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA0B406291
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553798; cv=none; b=ieGYqXyj8eLNHiRD/qgQ6dmaeR9ersLqKUcySvn4HmgZeaxnBEpLaFGvOJMEKXlIZ6eskMS8HqlzugPnS8j2y235EAPvLeoipLDWU4SdeYVQGTGpUZj20zFqtd2G5mibN7Bi+8wd2SVOPWjb9jlnpbtrFvnuCKfLFlUZ/IQX+jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553798; c=relaxed/simple;
	bh=SDLdk/C2G2G+sfTYSJ/LnmSp6aBT7ixd/It10NeRDOE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=llO77gqJrqkDNqf5RFKAfGEvfXMsqf8eQW26vdoYlLhh97KDOl0ayBiWmO/FAKPNOLVxAvbwDkg67/RWPoK/CaR6c6W9L02obFuW3FpM5Uii6aqu8OMkQiXR52Gnsq+ius6LFuNJcOVVuoPaPyZ/5ln1Z/OrB/IlF0Dz4h4t/Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RK8W6NxE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RK8W6NxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B33CC2BCB3;
	Thu, 30 Apr 2026 12:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777553797;
	bh=SDLdk/C2G2G+sfTYSJ/LnmSp6aBT7ixd/It10NeRDOE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=RK8W6NxEmzfJCHIpHzZ+3b1U8jdsKVuqy9wBoVx0npb2ligzcbMsUTiDKv6kaW8W5
	 6tvQPhK9inAJOJ35RqtM4Jsv7WpXHXXUorDFKVKMcm20bU/mNxSDSBpR3GQec6BBwQ
	 9TFSEVW7TNveLEfLo6QSc5whAZpQYhznyTeyeVcSYfLpS0osBnxp9cI0h2XY+1bFvy
	 xP8NObXa50ClHzBCuUYGbiG8pI/yCxLJ8+T6P76SqBdEXZMc4sxbAHsJM3O/r7EBim
	 7S/KFqgVUP71rs106IeMaa+Z/LXhb0iP/Pb8/h/sHfbPpQ80aO/wX1iPiVz9C5Zt5g
	 skPIUdTr5sSkQ==
Message-ID: <f8201c9c18a3317cf41d6112f39f7885fb0f64c5.camel@kernel.org>
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 13:56:34 +0100
In-Reply-To: <20260402162840.2989717-14-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
	 <20260402162840.2989717-14-joannelkoong@gmail.com>
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
> Implement zero-copy data transfer for fuse over io-uring, eliminating
> memory copies between userspace, the kernel, and the fuse server for
> page-backed read/write operations.
>=20
> When the FUSE_URING_ZERO_COPY flag is set alongside FUSE_URING_BUFRING,
> the kernel registers the client's underlying pages as a sparse buffer at
> the entry's fixed id via io_buffer_register_bvec(). The fuse server can
> then perform io_uring read/write operations directly on these pages.
> Non-page-backed args (eg out headers) go through the payload buffer as
> normal.
>=20
> This requires CAP_SYS_ADMIN and buffer rings with pinned headers and
> buffers. Gating on pinned headers and buffers keeps the configuration
> space small and avoids partially-optimized modes that are unlikely to be
> useful in practice. Pages are unregistered when the request completes.
>=20
> The request flow for the zero-copy write path (client writes data,
> server reads it) is as follows:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >  Kernel                                   |  FUSE server
> >                                           |
> >  "write(fd, buf, 1MB)"                    |
> >                                           |
> >  >sys_write()                             |
> >    >fuse_file_write_iter()                |
> >      >fuse_send_one()                     |
> >        [req->args->in_pages =3D true]       |
> >        [folios hold client write data]    |
> >                                           |
> >  >fuse_uring_copy_to_ring()               |
> >    >copy_header_to_ring(IN_OUT)           |
> >      [memcpy fuse_in_header to            |
> >       pinned headers buf via kaddr]       |
> >    >copy_header_to_ring(OP)               |
> >      [memcpy write_in header]             |
> >                                           |
> >    >fuse_uring_args_to_ring()             |
> >      >setup_fuse_copy_state()             |
> >        [is_kaddr =3D true]                  |
> >        [skip_folio_copy =3D true]           |
> >                                           |
> >      >fuse_uring_set_up_zero_copy()       |
> >        [folio_get for each client folio]  |
> >        [build bio_vec array from folios]  |
> >        >io_buffer_register_bvec()         |
> >          [register pages at ent->id]      |
> >        [ent->zero_copied =3D true]          |
> >                                           |
> >      >fuse_copy_args()                    |
> >        [skip_folio_copy =3D> return 0       |
> >         for page arg, skip data copy]     |
> >                                           |
> >    >copy_header_to_ring(RING_ENT)         |
> >      [memcpy ent_in_out]                  |
> >    >io_uring_cmd_done()                   |
> >                                           |
> >                                           | [CQE received]
> >                                           |
> >                                           | [issue io_uring READ at
> >                                           |  ent->id]
> >                                           | [reads directly from
> >                                           |client's pages (ZERO_COPY)]
> >                                           |
> >                                           | [write data to backing
> >                                           | store]
> >                                           |  [submit COMMIT AND FETCH]
> >                                           |
> >  >fuse_uring_commit_fetch()               |
> >    >fuse_uring_commit()                   |
> >      >fuse_uring_copy_from_ring()         |
> >    >fuse_uring_req_end()                  |
> >      >io_buffer_unregister(ent->id)       |
> >        [unregister sparse buffer]         |
> >      >fuse_zero_copy_release()            |
> >        [folio_put for each folio]         |
> >      [ent->zero_copied =3D false]           |
> >      >fuse_request_end()                  |
> >        [wake up client]                   |
>=20
> The zero-copy read path is analogous.
>=20
> Some requests may have both page-backed args and non-page-backed args.
> For these requests, the page-backed args are zero-copied while the
> non-page-backed args are copied to the buffer selected from the buffer
> ring:
>     zero-copy: pages registered via io_buffer_register_bvec()
>     non-page-backed: copied to payload buffer via fuse_copy_args()
>=20
> For a request whose payload is zero-copied, the
> registration/unregistration path looks like:
>=20
>     register:  fuse_uring_set_up_zero_copy()
>                  folio_get() for each folio
>                  io_buffer_register_bvec(ent->id)
>=20
>     [server accesses pages via io_uring fixed buf at ent->id]
>=20
>     unregister: fuse_uring_req_end()
>                   io_buffer_unregister(ent->id)
>                   -> fuse_zero_copy_release() callback
>                      folio_put() for each folio
>=20
> The throughput improvement from zero-copy depends on how much of the
> per-request latency is spent on data copying vs backing I/O. When
> backing I/O dominates, the saved memcpy is a negligible fraction of
> overall latency. Please also note that for the server to read/write
> into the zero-copied pages, the read/write must go through io-uring
> as an IORING_OP_READ_FIXED / IORING_OP_WRITE_FIXED operation. If the
> server's backing I/O is instantaneous (eg served from cache), the
> overhead of the additional io_uring operation may negate the savings
> from eliminating the memcpy.
>=20
> In benchmarks using passthrough_hp on a high-performance NVMe-backed
> system, zero-copy showed around a 35% throughput improvement for direct
> randreads (~2150 MiB/s to ~2900 MiB/s), a 15% improvement for direct
> sequential reads (~2510 MiB/s to ~2900 MiB/s), a 15% improvement for
> buffered randreads (~2100 MiB/s to ~2470 MiB/s), and a 10% improvement
> for buffered sequential reads (~2500 MiB/s to ~2750 MiB/s).
>=20
> The benchmarks were run using:
>   fio --name=3Dtest_run --ioengine=3Dsync --rw=3Drand{read,write} --bs=3D=
1M
>   --size=3D1G --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev.c             |   7 +-
>  fs/fuse/dev_uring.c       | 167 +++++++++++++++++++++++++++++++++-----
>  fs/fuse/dev_uring_i.h     |   4 +
>  fs/fuse/fuse_dev_i.h      |   1 +
>  include/uapi/linux/fuse.h |   5 ++
>  5 files changed, 160 insertions(+), 24 deletions(-)
>=20
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index a87939eaa103..cd326e61831b 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1233,10 +1233,13 @@ int fuse_copy_args(struct fuse_copy_state *cs, un=
signed numargs,
> =20
>  	for (i =3D 0; !err && i < numargs; i++)  {
>  		struct fuse_arg *arg =3D &args[i];
> -		if (i =3D=3D numargs - 1 && argpages)
> +		if (i =3D=3D numargs - 1 && argpages) {
> +			if (cs->skip_folio_copy)
> +				return 0;
>  			err =3D fuse_copy_folios(cs, arg->size, zeroing);
> -		else
> +		} else {
>  			err =3D fuse_copy_one(cs, arg->value, arg->size);
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
> =20
> +struct fuse_zero_copy_bvs {
> +	unsigned int nr_bvs;
> +	struct bio_vec bvs[];
> +};
> +
>  static const struct fuse_iqueue_ops fuse_io_uring_ops;
> =20
>  enum fuse_uring_header_type {
> @@ -57,6 +62,11 @@ static inline bool bufring_pinned_buffers(struct fuse_=
ring_queue *queue)
>  	return queue->bufring->use_pinned_buffers;
>  }
> =20
> +static inline bool bufring_zero_copy(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring->use_zero_copy;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -102,8 +112,18 @@ static void fuse_uring_flush_bg(struct fuse_ring_que=
ue *queue)
>  	}
>  }
> =20
> +static bool can_zero_copy_req(struct fuse_ring_ent *ent, struct fuse_req=
 *req)
> +{
> +	struct fuse_args *args =3D req->args;
> +
> +	if (!bufring_enabled(ent->queue) || !bufring_zero_copy(ent->queue))
> +		return false;
> +
> +	return args->in_pages || args->out_pages;
> +}
> +
>  static void fuse_uring_req_end(struct fuse_ring_ent *ent, struct fuse_re=
q *req,
> -			       int error)
> +			       int error, unsigned int issue_flags)
>  {
>  	struct fuse_ring_queue *queue =3D ent->queue;
>  	struct fuse_ring *ring =3D queue->ring;
> @@ -122,6 +142,11 @@ static void fuse_uring_req_end(struct fuse_ring_ent =
*ent, struct fuse_req *req,
> =20
>  	spin_unlock(&queue->lock);
> =20
> +	if (ent->zero_copied) {
> +		io_buffer_unregister(ent->cmd, ent->id, issue_flags);
> +		ent->zero_copied =3D false;
> +	}
> +
>  	if (error)
>  		req->out.h.error =3D error;
> =20
> @@ -485,6 +510,7 @@ static int fuse_uring_bufring_setup(struct io_uring_c=
md *cmd,
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
>  	bool pinned_bufs =3D init_flags & FUSE_URING_PINNED_BUFFERS;
> +	bool zero_copy =3D init_flags & FUSE_URING_ZERO_COPY;
>  	void __user *payload, *headers;
>  	size_t headers_size, payload_size, ring_size;
>  	struct fuse_bufring *br;
> @@ -508,7 +534,7 @@ static int fuse_uring_bufring_setup(struct io_uring_c=
md *cmd,
>  	if (headers_size < queue_depth * sizeof(struct fuse_uring_req_header))
>  		return -EINVAL;
> =20
> -	if (buf_size < queue->ring->max_payload_sz)
> +	if (!zero_copy && buf_size < queue->ring->max_payload_sz)
>  		return -EINVAL;
> =20
>  	nr_bufs =3D payload_size / buf_size;
> @@ -521,6 +547,7 @@ static int fuse_uring_bufring_setup(struct io_uring_c=
md *cmd,
>  	if (!br)
>  		return -ENOMEM;
> =20
> +	br->use_zero_copy =3D zero_copy;
>  	br->queue_depth =3D queue_depth;
>  	if (pinned_headers) {
>  		err =3D fuse_bufring_pin_mem(&br->pinned_headers, headers,
> @@ -580,6 +607,7 @@ static bool queue_init_flags_consistent(struct fuse_r=
ing_queue *queue,
>  	bool bufring =3D init_flags & FUSE_URING_BUFRING;
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
>  	bool pinned_bufs =3D init_flags & FUSE_URING_PINNED_BUFFERS;
> +	bool zero_copy =3D init_flags & FUSE_URING_ZERO_COPY;
> =20
>  	if (bufring_enabled(queue) !=3D bufring)
>  		return false;
> @@ -588,7 +616,8 @@ static bool queue_init_flags_consistent(struct fuse_r=
ing_queue *queue,
>  		return true;
> =20
>  	return bufring_pinned_headers(queue) =3D=3D pinned_headers &&
> -		bufring_pinned_buffers(queue) =3D=3D pinned_bufs;
> +		bufring_pinned_buffers(queue) =3D=3D pinned_bufs &&
> +		bufring_zero_copy(queue) =3D=3D zero_copy;
>  }
> =20
>  static struct fuse_ring_queue *
> @@ -1063,6 +1092,7 @@ static int setup_fuse_copy_state(struct fuse_copy_s=
tate *cs,
>  		cs->is_kaddr =3D true;
>  		cs->kaddr =3D (void *)ent->payload_buf.addr;
>  		cs->len =3D ent->payload_buf.len;
> +		cs->skip_folio_copy =3D ent->zero_copied;
>  	}
> =20
>  	cs->is_uring =3D true;
> @@ -1095,11 +1125,70 @@ static int fuse_uring_copy_from_ring(struct fuse_=
ring *ring,
>  	return err;
>  }
> =20
> +static void fuse_zero_copy_release(void *priv)
> +{
> +	struct fuse_zero_copy_bvs *zc_bvs =3D priv;
> +	unsigned int i;
> +
> +	for (i =3D 0; i < zc_bvs->nr_bvs; i++)
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
> +	int err, i, ddir =3D 0;
> +	struct fuse_zero_copy_bvs *zc_bvs;
> +	struct bio_vec *bvs;
> +
> +	/* out_pages indicates a read, in_pages indicates a write */
> +	if (req->args->out_pages)
> +		ddir |=3D IO_BUF_DEST;
> +	if (req->args->in_pages)
> +		ddir |=3D IO_BUF_SOURCE;
> +
> +	WARN_ON_ONCE(!ddir);
> +
> +	ap =3D container_of(req->args, typeof(*ap), args);
> +
> +	zc_bvs =3D kmalloc(struct_size(zc_bvs, bvs, ap->num_folios),
> +			 GFP_KERNEL_ACCOUNT);
> +	if (!zc_bvs)
> +		return -ENOMEM;
> +
> +	zc_bvs->nr_bvs =3D ap->num_folios;
> +	bvs =3D zc_bvs->bvs;
> +	for (i =3D 0; i < ap->num_folios; i++) {
> +		bvs[i].bv_page =3D folio_page(ap->folios[i], 0);
> +		bvs[i].bv_offset =3D ap->descs[i].offset;
> +		bvs[i].bv_len =3D ap->descs[i].length;
> +		folio_get(ap->folios[i]);
> +	}
> +
> +	err =3D io_buffer_register_bvec(ent->cmd, bvs, ap->num_folios,
> +				      fuse_zero_copy_release, zc_bvs,
> +				      ddir, ent->id,
> +				      issue_flags);
> +	if (err) {
> +		fuse_zero_copy_release(zc_bvs);
> +		return err;
> +	}
> +
> +	ent->zero_copied =3D true;
> +
> +	return 0;
> +}
> +
>  /*
>   * Copy data from the req to the ring buffer
>   */
>  static int fuse_uring_args_to_ring(struct fuse_ring *ring, struct fuse_r=
eq *req,
> -				   struct fuse_ring_ent *ent)
> +				   struct fuse_ring_ent *ent,
> +				   unsigned int issue_flags)
>  {
>  	struct fuse_copy_state cs;
>  	struct fuse_args *args =3D req->args;
> @@ -1112,8 +1201,15 @@ static int fuse_uring_args_to_ring(struct fuse_rin=
g *ring, struct fuse_req *req,
>  		.commit_id =3D req->in.h.unique,
>  	};
> =20
> -	if (bufring_enabled(ent->queue))
> +	if (bufring_enabled(ent->queue)) {
>  		ent_in_out.buf_id =3D ent->payload_buf.id;
> +		if (can_zero_copy_req(ent, req)) {
> +			ent_in_out.flags |=3D FUSE_URING_ENT_ZERO_COPY;
> +			err =3D fuse_uring_set_up_zero_copy(ent, req, issue_flags);
> +			if (err)
> +				return err;
> +		}
> +	}
> =20
>  	err =3D setup_fuse_copy_state(&cs, ring, req, ent, ITER_DEST, &iter);
>  	if (err)
> @@ -1145,12 +1241,17 @@ static int fuse_uring_args_to_ring(struct fuse_ri=
ng *ring, struct fuse_req *req,
>  	}
> =20
>  	ent_in_out.payload_sz =3D cs.ring.copied_sz;
> +	if (cs.skip_folio_copy && args->in_pages)
> +		ent_in_out.payload_sz +=3D
> +			args->in_args[args->in_numargs - 1].size;
> +
>  	return copy_header_to_ring(ent, FUSE_URING_HEADER_RING_ENT,
>  				   &ent_in_out, sizeof(ent_in_out));
>  }
> =20
>  static int fuse_uring_copy_to_ring(struct fuse_ring_ent *ent,
> -				   struct fuse_req *req)
> +				   struct fuse_req *req,
> +				   unsigned int issue_flags)
>  {
>  	struct fuse_ring_queue *queue =3D ent->queue;
>  	struct fuse_ring *ring =3D queue->ring;
> @@ -1168,7 +1269,7 @@ static int fuse_uring_copy_to_ring(struct fuse_ring=
_ent *ent,
>  		return err;
> =20
>  	/* copy the request */
> -	err =3D fuse_uring_args_to_ring(ring, req, ent);
> +	err =3D fuse_uring_args_to_ring(ring, req, ent, issue_flags);
>  	if (unlikely(err)) {
>  		pr_info_ratelimited("Copy to ring failed: %d\n", err);
>  		return err;
> @@ -1179,11 +1280,25 @@ static int fuse_uring_copy_to_ring(struct fuse_ri=
ng_ent *ent,
>  				   sizeof(req->in.h));
>  }
> =20
> -static bool fuse_uring_req_has_payload(struct fuse_req *req)
> +static bool fuse_uring_req_has_copyable_payload(struct fuse_ring_ent *en=
t,
> +						struct fuse_req *req)
>  {
>  	struct fuse_args *args =3D req->args;
> =20
> -	return args->in_numargs > 1 || args->out_numargs;
> +	if (!can_zero_copy_req(ent, req))
> +		return args->in_numargs > 1 || args->out_numargs;
> +
> +	/*
> +	 * the asymmetry between in_numargs > 2 and out_numargs > 1 is because
> +	 * the per-op header is extracted before fuse_copy_args() for inargs bu=
t
> +	 * not for outargs
> +	 */
> +	if ((args->in_numargs > 1) && (!args->in_pages || args->in_numargs > 2)=
)
> +		return true;
> +	if (args->out_numargs && (!args->out_pages || args->out_numargs > 1))
> +		return true;
> +
> +	return false;
>  }
> =20
>  static int fuse_uring_select_buffer(struct fuse_ring_ent *ent)
> @@ -1245,7 +1360,7 @@ static int fuse_uring_next_req_update_buffer(struct=
 fuse_ring_ent *ent,
>  		return 0;
> =20
>  	buffer_selected =3D !!ent->payload_buf.addr;
> -	has_payload =3D fuse_uring_req_has_payload(req);
> +	has_payload =3D fuse_uring_req_has_copyable_payload(ent, req);
> =20
>  	if (has_payload && !buffer_selected)
>  		return fuse_uring_select_buffer(ent);
> @@ -1263,22 +1378,23 @@ static int fuse_uring_prep_buffer(struct fuse_rin=
g_ent *ent,
>  		return 0;
> =20
>  	/* no payload to copy, can skip selecting a buffer */
> -	if (!fuse_uring_req_has_payload(req))
> +	if (!fuse_uring_req_has_copyable_payload(ent, req))
>  		return 0;
> =20
>  	return fuse_uring_select_buffer(ent);
>  }
> =20
>  static int fuse_uring_prepare_send(struct fuse_ring_ent *ent,
> -				   struct fuse_req *req)
> +				   struct fuse_req *req,
> +				   unsigned int issue_flags)
>  {
>  	int err;
> =20
> -	err =3D fuse_uring_copy_to_ring(ent, req);
> +	err =3D fuse_uring_copy_to_ring(ent, req, issue_flags);
>  	if (!err)
>  		set_bit(FR_SENT, &req->flags);
>  	else
> -		fuse_uring_req_end(ent, req, err);
> +		fuse_uring_req_end(ent, req, err, issue_flags);
> =20
>  	return err;
>  }
> @@ -1386,7 +1502,7 @@ static void fuse_uring_commit(struct fuse_ring_ent =
*ent, struct fuse_req *req,
> =20
>  	err =3D fuse_uring_copy_from_ring(ring, req, ent);
>  out:
> -	fuse_uring_req_end(ent, req, err);
> +	fuse_uring_req_end(ent, req, err, issue_flags);
>  }
> =20
>  /*
> @@ -1396,7 +1512,8 @@ static void fuse_uring_commit(struct fuse_ring_ent =
*ent, struct fuse_req *req,
>   * Else, there is no next fuse request and this returns false.
>   */
>  static bool fuse_uring_get_next_fuse_req(struct fuse_ring_ent *ent,
> -					 struct fuse_ring_queue *queue)
> +					 struct fuse_ring_queue *queue,
> +					 unsigned int issue_flags)
>  {
>  	int err;
>  	struct fuse_req *req;
> @@ -1408,7 +1525,7 @@ static bool fuse_uring_get_next_fuse_req(struct fus=
e_ring_ent *ent,
>  	spin_unlock(&queue->lock);
> =20
>  	if (req) {
> -		err =3D fuse_uring_prepare_send(ent, req);
> +		err =3D fuse_uring_prepare_send(ent, req, issue_flags);
>  		if (err)
>  			goto retry;
>  	}
> @@ -1523,7 +1640,7 @@ static int fuse_uring_commit_fetch(struct io_uring_=
cmd *cmd, int issue_flags,
>  	 * no-op and the next request will be serviced when a buffer becomes
>  	 * available.
>  	 */
> -	if (fuse_uring_get_next_fuse_req(ent, queue))
> +	if (fuse_uring_get_next_fuse_req(ent, queue, issue_flags))
>  		fuse_uring_send(ent, cmd, 0, issue_flags);
>  	return 0;
>  }
> @@ -1645,12 +1762,17 @@ static bool init_flags_valid(u64 init_flags)
>  {
>  	u64 valid_flags =3D
>  		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS |
> -		FUSE_URING_PINNED_BUFFERS;
> +		FUSE_URING_PINNED_BUFFERS | FUSE_URING_ZERO_COPY;
>  	bool bufring =3D init_flags & FUSE_URING_BUFRING;
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
>  	bool pinned_buffers =3D init_flags & FUSE_URING_PINNED_BUFFERS;
> +	bool zero_copy =3D init_flags & FUSE_URING_ZERO_COPY;
> +
> +	if (!bufring && (pinned_headers || pinned_buffers || zero_copy))
> +		return false;
> =20
> -	if (!bufring && (pinned_headers || pinned_buffers))
> +	if (zero_copy &&
> +	    (!capable(CAP_SYS_ADMIN) || !pinned_headers || !pinned_buffers))
>  		return false;
> =20
>  	return !(init_flags & ~valid_flags);
> @@ -1795,9 +1917,10 @@ static void fuse_uring_send_in_task(struct io_tw_r=
eq tw_req, io_tw_token_t tw)
>  	int err;
> =20
>  	if (!tw.cancel) {
> -		err =3D fuse_uring_prepare_send(ent, ent->fuse_req);
> +		err =3D fuse_uring_prepare_send(ent, ent->fuse_req, issue_flags);
>  		if (err) {
> -			if (!fuse_uring_get_next_fuse_req(ent, queue))
> +			if (!fuse_uring_get_next_fuse_req(ent, queue,
> +							  issue_flags))
>  				return;
>  			err =3D 0;
>  		}
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 859ee4e6ba03..0546f719fc65 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -58,6 +58,8 @@ struct fuse_bufring_pinned {
>  struct fuse_bufring {
>  	bool use_pinned_headers: 1;
>  	bool use_pinned_buffers: 1;
> +	/* this is only allowed on privileged servers */
> +	bool use_zero_copy: 1;
>  	unsigned int queue_depth;
> =20
>  	union {
> @@ -96,6 +98,8 @@ struct fuse_ring_ent {
>  			 */
>  			unsigned int id;
>  			struct fuse_bufring_buf payload_buf;
> +			/* true if the request's pages are being zero-copied */
> +			bool zero_copied;
>  		};
>  	};
> =20
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index aa1d25421054..67b5bed451fe 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -39,6 +39,7 @@ struct fuse_copy_state {
>  	bool is_uring:1;
>  	/* if set, use kaddr; otherwise use pg */
>  	bool is_kaddr:1;
> +	bool skip_folio_copy:1;
>  	struct {
>  		unsigned int copied_sz; /* copied size into the user buffer */
>  	} ring;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 51ecb66dd6eb..c2e53886cf06 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -246,6 +246,7 @@
>   *  - add fuse_uring_cmd_req init struct
>   *  - add FUSE_URING_PINNED_HEADERS flag
>   *  - add FUSE_URING_PINNED_BUFFERS flag
> + *  - add FUSE_URING_ZERO_COPY flag
>   */
> =20
>  #ifndef _LINUX_FUSE_H
> @@ -1257,6 +1258,9 @@ struct fuse_supp_groups {
>  #define FUSE_URING_IN_OUT_HEADER_SZ 128
>  #define FUSE_URING_OP_IN_OUT_SZ 128
> =20
> +/* Set if the ent's payload is zero-copied */
> +#define FUSE_URING_ENT_ZERO_COPY	(1 << 0)
> +
>  /* Used as part of the fuse_uring_req_header */
>  struct fuse_uring_ent_in_out {
>  	uint64_t flags;
> @@ -1310,6 +1314,7 @@ enum fuse_uring_cmd {
>  #define FUSE_URING_BUFRING		(1 << 0)
>  #define FUSE_URING_PINNED_HEADERS	(1 << 1)
>  #define FUSE_URING_PINNED_BUFFERS	(1 << 2)
> +#define FUSE_URING_ZERO_COPY		(1 << 3)
> =20
>  /**
>   * In the 80B command area of the SQE.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
