Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28B6406269
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553824; cv=none; b=VFQBCwMMer8WX670mC2v9PF8Gv/EwW48j+REXqHQPaeoDAPNLBXRoR+xnUmSQLHHaZPDqn5M1aMLO2ind47WQo3qsAxCV97ztQ6AhEe8puT4RT5DNs5wJgvtq48Zi9rQfEDxh03Fu+k5/hyglE8gFOg64WlXIolH+TBKkiI+Feg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553824; c=relaxed/simple;
	bh=Cax0EkstDZnIZoxEe/zAVh3M5U+jCPNrC7XUMm+Iszs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LamzGAq9GAwmJxBNqGYO+pidx4LiX8CE0NDDnizH2XFDlAvyfM8ZZL5IwzVEbze1o37KGbxiMXSql8q2nSge4dFayAvBXO5Vh+o8nkD7oDma0JdOpHFB0Pko8NfBoczKKdnEN9Riq+Ng+SrPDHubnXJKyyTx48nCzz87KUqjLNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7r3hyU4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7r3hyU4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C0DCC2BCB9;
	Thu, 30 Apr 2026 12:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777553823;
	bh=Cax0EkstDZnIZoxEe/zAVh3M5U+jCPNrC7XUMm+Iszs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=T7r3hyU4hQVtLqZLJrws3ygn0K7OveYbXvk6o3szhNtPhS32eZ0BYO+egR5lxjA1d
	 B4otLlV7Zh+/sgqf3j5rYgDJ4F3IQPhqQzGRASUn0aB86IWRxcqKvQZVV1gL/Mcxtt
	 KhDxh0vegcCUtirv2JnYd5iTqrtir/fqMHmqZClXTCsDqNGJaybpH84ATe2XZm5CF3
	 y8VGqiWBoosvTn6p2/nKOD/ZdyBnfM3Ev4+kr4kM+ugpo2phoIMhOHTHDR0EXMlAil
	 AODH34r2vlEkxNIYaSprseZzIea6R7H6vcAaMhgeQuO/oL2iEGoOcBnyog/oCZnXLA
	 OsvGwbsUMjH7g==
Message-ID: <b8653c7c80e21cf1fad7e66562f2e4f4127683e0.camel@kernel.org>
Subject: Re: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy
 documentation
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 13:57:00 +0100
In-Reply-To: <20260402162840.2989717-15-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
	 <20260402162840.2989717-15-joannelkoong@gmail.com>
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
> Add documentation for fuse over io-uring usage of buffer rings and
> zero-copy.
>=20
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>=20
> diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documenta=
tion/filesystems/fuse/fuse-io-uring.rst
> index d73dd0dbd238..bc47686c023f 100644
> --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
> +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
> @@ -95,5 +95,194 @@ Sending requests with CQEs
>   |    <fuse_unlink()                         |
>   |  <sys_unlink()                            |
> =20
> +Buffer rings
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> +Buffer rings have two main advantages:
> =20
> +* Reduced memory usage: payload buffers are pooled and selected on deman=
d
> +  rather than dedicated per-entry, allowing fewer buffers than entries. =
This
> +  infrastructure also allows for future optimizations like incremental b=
uffer
> +  consumption where non-overlapping parts of a buffer may be used across
> +  concurrent requests.
> +* Foundation for pinned buffers: contiguous buffer allocations allow the
> +  kernel to pin and vmap the entire region, avoiding per-request page
> +  resolution overhead
> +
> +At a high-level, this is how fuse uses buffer rings:
> +
> +* The first REGISTER SQE for a queue creates the queue and sets up the
> +  buffer ring. The server provides two iovecs: one for headers and one f=
or
> +  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that maps
> +  to a specific header slot.
> +* When a client request arrives, the kernel selects a payload buffer fro=
m
> +  the ring (if the request has copyable data), copies headers and payloa=
d
> +  data, and completes the sqe.
> +* The buf_id of the selected payload buffer is communicated to the serve=
r
> +  via the fuse_uring_ent_in_out header. The server uses this to locate t=
he
> +  payload data in its buffer.
> +* The server processes the request and sends a COMMIT_AND_FETCH SQE with
> +  the reply. The kernel processes the reply and recycles the buffer.
> +
> +Visually, this looks like::
> +
> + Headers buffer:
> + +-----------------------+-----------------------+-----+
> + | fuse_uring_req_header | fuse_uring_req_header | ... |
> + | [ent 0]               | [ent 1]               |     |
> + +-----------------------+-----------------------+-----+
> + ^                       ^
> + |                       |
> + ent 0 header slot       ent 1 header slot
> + (sqe->buf_index=3D0)      (sqe->buf_index=3D1)
> +
> + Payload buffer pool:
> + +-----------+-----------+-----------+-----+
> + | buf 0     | buf 1     | buf 2     | ... |
> + | (buf_size)| (buf_size)| (buf_size)|     |
> + +-----------+-----------+-----------+-----+
> + selected on demand, recycled after each request
> +
> +Buffer ring request flow
> +------------------------::
> +
> +|  Kernel                                  |  FUSE daemon
> +|                                          |
> +|  [client request arrives]                |
> +|  >fuse_uring_send()                      |
> +|    [select payload buf from ring]        |
> +|    >fuse_uring_select_buffer()           |
> +|    [copy headers to ent's header slot]   |
> +|    >copy_header_to_ring()                |
> +|    [copy payload to selected buf]        |
> +|    >fuse_uring_copy_to_ring()            |
> +|    [set buf_id in ent_in_out header]     |
> +|    >io_uring_cmd_done()                  |
> +|                                          |  [CQE received]
> +|                                          |  [read headers from header =
slot]
> +|                                          |  [read payload from buf_id]
> +|                                          |  [process request]
> +|                                          |  [write reply to header slo=
t]
> +|                                          |  [write reply payload to bu=
f]
> +|                                          |  >io_uring_submit()
> +|                                          |   COMMIT_AND_FETCH
> +|  >fuse_uring_commit_fetch()              |
> +|    >fuse_uring_commit()                  |
> +|     [copy reply from ring]               |
> +|     >fuse_uring_recycle_buffer()         |
> +|    >fuse_uring_get_next_fuse_req()       |
> +
> +Pinned buffers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Servers can optionally pin their header and/or payload buffers by settin=
g
> +FUSE_URING_PINNED_HEADERS and/or FUSE_URING_PINNED_BUFFERS flags. When
> +set, the kernel pins the user pages and vmaps them during queue setup,
> +enabling memcpy to/from the kernel virtual address instead of
> +copy_to_user/copy_from_user.
> +
> +This avoids the per-request cost of pinning/unpinning user pages and
> +translating virtual addresses. Buffers must be page-aligned. The pinned =
pages
> +are accounted against RLIMIT_MEMLOCK (bypassable with CAP_IPC_LOCK).
> +
> +Zero-copy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Fuse io-uring zero-copy allows the server to directly read from / write =
to
> +the client's pages, bypassing any intermediary buffer copies. This requi=
res
> +the FUSE_URING_ZERO_COPY flag, buffer rings with pinned headers and buff=
ers,
> +and CAP_SYS_ADMIN.
> +
> +The kernel registers the client's underlying pages as a sparse buffer at
> +the entry's fixed id via io_buffer_register_bvec(). The fuse server can
> +then perform io_uring read/write operations directly on these pages.
> +Non-page-backed args (eg out headers) go through the payload buffer as
> +normal. Pages are unregistered when the request completes.
> +
> +The request flow for the zero-copy write path (client writes data, serve=
r
> +reads it) is as follows:
> +
> +Zero-copy write
> +---------------::
> +|  Kernel                                   |  FUSE server
> +|                                           |
> +|  "write(fd, buf, 1MB)"                    |
> +|                                           |
> +|  >sys_write()                             |
> +|    >fuse_file_write_iter()                |
> +|      >fuse_send_one()                     |
> +|        [req->args->in_pages =3D true]       |
> +|        [folios hold client write data]    |
> +|                                           |
> +|  >fuse_uring_copy_to_ring()               |
> +|    >copy_header_to_ring(IN_OUT)           |
> +|      [memcpy fuse_in_header to            |
> +|       pinned headers buf via kaddr]       |
> +|    >copy_header_to_ring(OP)               |
> +|      [memcpy write_in header]             |
> +|                                           |
> +|    >fuse_uring_args_to_ring()             |
> +|      >setup_fuse_copy_state()             |
> +|        [is_kaddr =3D true]                  |
> +|        [skip_folio_copy =3D true]           |
> +|                                           |
> +|      >fuse_uring_set_up_zero_copy()       |
> +|        [folio_get for each client folio]  |
> +|        [build bio_vec array from folios]  |
> +|        >io_buffer_register_bvec()         |
> +|          [register pages at ent->id]      |
> +|        [ent->zero_copied =3D true]          |
> +|                                           |
> +|      >fuse_copy_args()                    |
> +|        [skip_folio_copy =3D> return 0       |
> +|         for page arg, skip data copy]     |
> +|                                           |
> +|    >copy_header_to_ring(RING_ENT)         |
> +|      [memcpy ent_in_out]                  |
> +|    >io_uring_cmd_done()                   |
> +|                                           |
> +|                                           | [CQE received]
> +|                                           |
> +|                                           | [issue io_uring READ at
> +|                                           |  ent->id]
> +|                                           | [reads directly from
> +|                                           | client's pages (ZERO_COPY)=
]
> +|                                           |
> +|                                           | [write data to backing
> +|                                           | store]
> +|                                           |  [submit COMMIT AND FETCH]
> +|                                           |
> +|  >fuse_uring_commit_fetch()               |
> +|    >fuse_uring_commit()                   |
> +|      >fuse_uring_copy_from_ring()         |
> +|    >fuse_uring_req_end()                  |
> +|      >io_buffer_unregister(ent->id)       |
> +|        [unregister sparse buffer]         |
> +|      >fuse_zero_copy_release()            |
> +|        [folio_put for each folio]         |
> +|      [ent->zero_copied =3D false]           |
> +|      >fuse_request_end()                  |
> +|        [wake up client]                   |
> +
> +The zero-copy read path is analogous.
> +
> +Some requests may have both page-backed args and non-page-backed args.
> +For these requests, the page-backed args are zero-copied while the
> +non-page-backed args are copied to the buffer selected from the buffer
> +ring:
> +  zero-copy: pages registered via io_buffer_register_bvec()
> +  non-page-backed: copied to payload buffer via fuse_copy_args()
> +
> +For a request whose payload is zero-copied, the registration/unregistrat=
ion
> +path looks like:
> +
> +register:  fuse_uring_set_up_zero_copy()
> +	     folio_get() for each folio
> +	     io_buffer_register_bvec(ent->id)
> +
> +[server accesses pages via io_uring fixed buf at ent->id]
> +
> +unregister: fuse_uring_req_end()
> +	      io_buffer_unregister(ent->id)
> +	      -> fuse_zero_copy_release() callback
> +		 folio_put() for each folio

Reviewed-by: Jeff Layton <jlayton@kernel.org>
