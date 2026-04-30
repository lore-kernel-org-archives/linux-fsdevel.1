Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2463D6674
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 11:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777548567; cv=none; b=Jgd+qHvrXkENguDkcPHY8LzxLLPS9m4CzNxsUaivwuNqrdtDtp9qwXRG4p+lc/MjgBnzfimyl5Y9WkfhsJgObNLXDUcICBU1MDO/o79YaJbHTV8EbaXelRKsfgLJMJBWROAKcDbd5jOD8zA4UBQYX7NCrVbyYE+3zVnzRsZHKDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777548567; c=relaxed/simple;
	bh=U3Up/PRRZCOdfYDvu9RFzUqMl6506ew63nO0+erUgLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0C4xWW2WfGvXtDhbwxMU/zY/5OXHjqqFxZQO2NyEtsCS3CS6i2Tc2chhfSFSB9EchaTu/FK/ZqsAm0e92aplH1pTUUgtEexYO8i9osF5Vg9Wqk4id8ylYIzGWbv3jeDPFyJryau2fR9y8cVOfxr3I5Gzx0oyGi4jHaa8j6Krb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwU01QOO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwU01QOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513CEC2BCB3;
	Thu, 30 Apr 2026 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777548567;
	bh=U3Up/PRRZCOdfYDvu9RFzUqMl6506ew63nO0+erUgLQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QwU01QOO6D9hYlDfV1Qq+yDjBF8oXr0F1jNxueTOLIRBDmOE+OOiYan3hMiq8rdgK
	 MzJ1VIpHQBg8OgQjmuED+RP3THTDsu6dhEk7OmLXgYfyvjY0H7mwiIEXZmJh6bv0kr
	 rsb9fAxrmNMok1n2VRv5tiUNq56YAeXr5XNDUzV6Z7W9PbgiiRACItRRRfjDuodOuU
	 MNq7p1vMgwDS5E0BS7uAGDML7AG18ZoppZBLm3LthdV288ByQn0IGrErg9zV9Yqpvv
	 tBeW9oKibk4dQl+tidOCi+TyL2AHJDHXXB+IOUFWTPQToddGqp34Pujcup29TR8Gb2
	 vdCTH0FdxrYwg==
Message-ID: <f27f236a66a58c93c413a5c04d76b646ff7860e5.camel@kernel.org>
Subject: Re: [PATCH v2 12/14] fuse: add pinned payload buffers capability
 for io-uring buffer rings
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 12:29:24 +0100
In-Reply-To: <20260402162840.2989717-13-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
	 <20260402162840.2989717-13-joannelkoong@gmail.com>
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
> Extend the buffer ring pinning capability to payload buffers via the
> FUSE_URING_PINNED_BUFFERS flag. When set alongside FUSE_URING_BUFRING,
> the kernel pins and vmaps the payload buffer region during queue setup.
>=20
> With pinned payloads, the kernel uses direct memcpy for all payload
> buffer copies, avoiding the per-request overhead of pinning/unpinning
> user pages and translating virtual addresses. This is particularly
> beneficial for large payload copies.
>=20
> As with pinned headers, buffers must be page-aligned. Pinned pages are
> accounted against RLIMIT_MEMLOCK (bypassed with CAP_IPC_LOCK) and
> unpinned in process context during connection abort.
>=20
> In benchmarks using passthrough_hp on a high-performance NVMe-backed
> system, pinned headers and pinned payload buffers showed around a 10%
> throughput improvement for direct randreads (~2150 MiB/s to ~2400
> MiB/s), a 4% improvement for direct sequential reads (~2510 MiB/s to
> ~2620 MiB/s), a 8% improvement for buffered randreads (~2100 MiB/s to
> ~2280 MiB/s), and a 6% improvement for buffered sequential reads (~2500
> MiB/s to ~2670 MiB/s).
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  fs/fuse/dev_uring.c       | 54 +++++++++++++++++++++++++++++++++------
>  fs/fuse/dev_uring_i.h     |  4 +++
>  include/uapi/linux/fuse.h |  2 ++
>  3 files changed, 52 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 79736b02cf9f..06d3d8dc1c82 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -52,6 +52,11 @@ static inline bool bufring_pinned_headers(struct fuse_=
ring_queue *queue)
>  	return queue->bufring->use_pinned_headers;
>  }
> =20
> +static inline bool bufring_pinned_buffers(struct fuse_ring_queue *queue)
> +{
> +	return queue->bufring->use_pinned_buffers;
> +}
> +
>  static void uring_cmd_set_ring_ent(struct io_uring_cmd *cmd,
>  				   struct fuse_ring_ent *ring_ent)
>  {
> @@ -235,6 +240,11 @@ static void fuse_uring_bufring_unpin(struct fuse_rin=
g_queue *queue)
>  		fuse_bufring_unpin_mem(&br->pinned_headers);
>  		br->use_pinned_headers =3D false;
>  	}
> +
> +	if (bufring_pinned_buffers(queue)) {
> +		fuse_bufring_unpin_mem(&br->pinned_bufs);
> +		br->use_pinned_buffers =3D false;
> +	}
>  }
> =20
>  void fuse_uring_destruct(struct fuse_conn *fc)
> @@ -474,6 +484,7 @@ static int fuse_uring_bufring_setup(struct io_uring_c=
md *cmd,
>  	unsigned int buf_size =3D READ_ONCE(cmd_req->init.buf_size);
>  	struct iovec iov[FUSE_URING_IOV_SEGS];
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
> +	bool pinned_bufs =3D init_flags & FUSE_URING_PINNED_BUFFERS;
>  	void __user *payload, *headers;
>  	size_t headers_size, payload_size, ring_size;
>  	struct fuse_bufring *br;
> @@ -523,7 +534,22 @@ static int fuse_uring_bufring_setup(struct io_uring_=
cmd *cmd,
>  		br->headers =3D headers;
>  	}
> =20
> -	payload_addr =3D (uintptr_t)payload;
> +	if (pinned_bufs) {
> +		err =3D fuse_bufring_pin_mem(&br->pinned_bufs, payload,
> +					   payload_size);
> +		if (err) {
> +			if (pinned_headers)
> +				fuse_bufring_unpin_mem(&br->pinned_headers);
> +			kfree(br);
> +			return err;
> +		}
> +		br->use_pinned_buffers =3D true;
> +	}
> +
> +	if (pinned_bufs)
> +		payload_addr =3D (uintptr_t)br->pinned_bufs.addr;
> +	else
> +		payload_addr =3D (uintptr_t)payload;
> =20
>  	/* populate the ring buffer */
>  	for (i =3D 0; i < nr_bufs; i++, payload_addr +=3D buf_size) {
> @@ -553,6 +579,7 @@ static bool queue_init_flags_consistent(struct fuse_r=
ing_queue *queue,
>  {
>  	bool bufring =3D init_flags & FUSE_URING_BUFRING;
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
> +	bool pinned_bufs =3D init_flags & FUSE_URING_PINNED_BUFFERS;
> =20
>  	if (bufring_enabled(queue) !=3D bufring)
>  		return false;
> @@ -560,7 +587,8 @@ static bool queue_init_flags_consistent(struct fuse_r=
ing_queue *queue,
>  	if (!bufring)
>  		return true;
> =20
> -	return bufring_pinned_headers(queue) =3D=3D pinned_headers;
> +	return bufring_pinned_headers(queue) =3D=3D pinned_headers &&
> +		bufring_pinned_buffers(queue) =3D=3D pinned_bufs;
>  }
> =20
>  static struct fuse_ring_queue *
> @@ -1011,13 +1039,15 @@ static int setup_fuse_copy_state(struct fuse_copy=
_state *cs,
>  				 struct fuse_ring_ent *ent, int dir,
>  				 struct iov_iter *iter)
>  {
> -	void __user *payload;
> +	void __user *payload =3D NULL;
> +	bool use_bufring =3D bufring_enabled(ent->queue);
> +	bool pinned_buffers =3D use_bufring && bufring_pinned_buffers(ent->queu=
e);
>  	int err;
> =20
> -	if (bufring_enabled(ent->queue))
> -		payload =3D (void __user *)ent->payload_buf.addr;
> -	else
> +	if (!use_bufring)
>  		payload =3D ent->payload;
> +	else if (!pinned_buffers)
> +		payload =3D (void __user *)ent->payload_buf.addr;
> =20
>  	if (payload) {
>  		err =3D import_ubuf(dir, payload, ring->max_payload_sz, iter);
> @@ -1029,6 +1059,12 @@ static int setup_fuse_copy_state(struct fuse_copy_=
state *cs,
> =20
>  	fuse_copy_init(cs, dir =3D=3D ITER_DEST, iter);
> =20
> +	if (pinned_buffers) {
> +		cs->is_kaddr =3D true;
> +		cs->kaddr =3D (void *)ent->payload_buf.addr;
> +		cs->len =3D ent->payload_buf.len;
> +	}
> +
>  	cs->is_uring =3D true;
>  	cs->req =3D req;
> =20
> @@ -1608,11 +1644,13 @@ fuse_uring_create_ring_ent(struct io_uring_cmd *c=
md,
>  static bool init_flags_valid(u64 init_flags)
>  {
>  	u64 valid_flags =3D
> -		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS;
> +		FUSE_URING_BUFRING | FUSE_URING_PINNED_HEADERS |
> +		FUSE_URING_PINNED_BUFFERS;
>  	bool bufring =3D init_flags & FUSE_URING_BUFRING;
>  	bool pinned_headers =3D init_flags & FUSE_URING_PINNED_HEADERS;
> +	bool pinned_buffers =3D init_flags & FUSE_URING_PINNED_BUFFERS;
> =20
> -	if (pinned_headers && !bufring)
> +	if (!bufring && (pinned_headers || pinned_buffers))
>  		return false;
> =20
>  	return !(init_flags & ~valid_flags);
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 05c0f061a882..859ee4e6ba03 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -57,6 +57,7 @@ struct fuse_bufring_pinned {
> =20
>  struct fuse_bufring {
>  	bool use_pinned_headers: 1;
> +	bool use_pinned_buffers: 1;
>  	unsigned int queue_depth;
> =20
>  	union {
> @@ -65,6 +66,9 @@ struct fuse_bufring {
>  		struct fuse_bufring_pinned pinned_headers;
>  	};
> =20
> +	/* only used if the buffers are pinned */
> +	struct fuse_bufring_pinned pinned_bufs;
> +
>  	/* metadata tracking state of the bufring */
>  	unsigned int nbufs;
>  	unsigned int head;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index e57244c03d42..51ecb66dd6eb 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -245,6 +245,7 @@
>   *  - add FUSE_URING_BUFRING flag
>   *  - add fuse_uring_cmd_req init struct
>   *  - add FUSE_URING_PINNED_HEADERS flag
> + *  - add FUSE_URING_PINNED_BUFFERS flag
>   */
> =20
>  #ifndef _LINUX_FUSE_H
> @@ -1308,6 +1309,7 @@ enum fuse_uring_cmd {
>  /* fuse_uring_cmd_req flags */
>  #define FUSE_URING_BUFRING		(1 << 0)
>  #define FUSE_URING_PINNED_HEADERS	(1 << 1)
> +#define FUSE_URING_PINNED_BUFFERS	(1 << 2)
> =20
>  /**
>   * In the 80B command area of the SQE.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
