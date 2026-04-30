Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1036F40F8F9
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777553964; cv=none; b=n/mrRknm44H+PJEWy1Ai606UeszxGG2y858mKgo9m0k+sQ72F3O3m4xrcEc0G8BDsf3Y6AieTBTPHKQBOonDdTdznUHU+glyum/djelWZwpXybp3YuQxINdsOnFcBChZFzENlbDNYiL2HqSq8aSy1y1XBl+hHMMx4rHvLgUPYVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777553964; c=relaxed/simple;
	bh=RO9AMBx1mGt23i8/tpPEkax82KnBXZueuhiAZwqhCSQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H2efkwd17v5ZIcJB6Uj7msAuFwu8xbFFTqV784Yq6XZuoNhiZE5r9w8WDpAeqBdMrwNuvvQzQ4tltAcysSgupfn4NCVaRsNA74YX36+iQjy0U6+5HqfzTo9T9h+Jp8QZekiw3Q8ynnb8EjMblBKEPlccSQug/qhEZlFyqSfj6/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R6zGpSHt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R6zGpSHt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67B2C2BCB3;
	Thu, 30 Apr 2026 12:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777553963;
	bh=RO9AMBx1mGt23i8/tpPEkax82KnBXZueuhiAZwqhCSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=R6zGpSHt1C0/DfwFv57/3EpAStBZVQB53ZQniPrzGIDOg6/W7vnZuF7go7DWKPqSV
	 upMm8mvXGjsjHwBZa1/WnHmEi45LjcpsZ3a6X1Ju2ewux6oVuJ+NWzmmX4u4/yZCni
	 R8LP9IQuVqklhLuRxcLaD9kf6Ce74qnpSCpKebVGYAo/Iy2lboNXwFHxunNEne3pON
	 gfUa1eOgarBK3bNycrp6sjN45ltI+qRV1lJEWXXTMBxHuPhBdxthGlgEkCKTnFzyLR
	 HY981xFC/pyQqQXb34dBwcCua6vpp/5EBBDEpFg50JfEklUjDPngZA8rv0q9FnoeHk
	 DfGChNWMbmWRA==
Message-ID: <8b120087b497c20aca3f0c73669d55c9fb779baa.camel@kernel.org>
Subject: Re: [PATCH v2 00/14] fuse: add io-uring buffer rings and zero-copy
From: Jeff Layton <jlayton@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: bernd@bsbernd.com, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
Date: Thu, 30 Apr 2026 13:59:20 +0100
In-Reply-To: <20260402162840.2989717-1-joannelkoong@gmail.com>
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
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
> This series adds buffer ring and zero-copy capabilities to fuse over io-u=
ring.
>=20
> Using buffer rings has advantages over the non-buffer-ring (iovec) path:
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
> This series adds the capability to pin the underlying header and payload
> buffers by setting init flags at registration time, depending on the user=
's
> mlock limit.
>=20
> Zero-copy (only for privileged servers) is also opt-in by setting an init=
 flag
> at registration time. Zero-copy eliminates the memory copies between kern=
el and
> userspace for read/write/payload-heavy operations by allowing the server =
to
> directly operate on the client's underlying pages.
>=20
> This series has a dependency on io-uring registered bvec buffers changes
> in [1].
>=20
> The throughput improvements from pinned buffers and zero-copy depends on =
how
> much of the server's per-request latency is spent on data copying vs back=
ing
> I/O. When backing I/O dominates, the saved memcpy is a negligible fractio=
n of
> overall latency. Please also note that for the server to read/write
> into the zero-copied pages, the read/write must go through io-uring
> as an IORING_OP_READ_FIXED / IORING_OP_WRITE_FIXED operation. If the
> server's backing I/O is instantaneous (eg served from cache), the
> overhead of the additional io_uring operation may negate the savings
> from eliminating the memcpy.
>=20
> In benchmarks using passthrough_hp on a high-performance NVMe-backed
> system, pinned headers and pinned payload buffers showed around a 10%
> throughput improvement for direct randreads (~2150 MiB/s to ~2400
> MiB/s), a 4% improvement for direct sequential reads (~2510 MiB/s to
> ~2620 MiB/s), a 8% improvement for buffered randreads (~2100 MiB/s to
> ~2280 MiB/s), and a 6% improvement for buffered sequential reads (~2500
> MiB/s to ~2670 MiB/s).
>=20
> Zero-copy showed around a 35% throughput improvement for direct
> randreads (~2150 MiB/s to ~2900 MiB/s), a 15% improvement for direct
> sequential reads (~2510 MiB/s to ~2900 MiB/s), a 15% improvement for
> buffered randreads (~2100 MiB/s to ~2470 MiB/s), and a 10% improvement
> for buffered sequential reads (~2500 MiB/s to ~2750 MiB/s). I didn't see
> enough of a clear improvement for writes due to write latency being I/O
> dominated.
>=20
> The benchmarks were run using:
>   fio --name=3Dtest_run --ioengine=3Dsync --rw=3Drand{read,write} --bs=3D=
1M
>   --size=3D1G --numjobs=3D2 --ramp_time=3D30 --group_reporting=3D1
>=20
> To run the benchmark, please also add this patch [2].
>=20
> The libfuse changes can be found in [3]. To test the server, run:
> sudo ~/libfuse/build/example/passthrough_hp ~/src ~/mounts/tmp
> --nopassthrough -o io_uring_zero_copy -o io_uring_q_depth=3D8
> Once this series is merged, the libfuse changes will be tidied up and
> submitted upstream.
>=20
> Further optimizations for incremental buffer consumption, request
> dispatching in current task context, and backing buffer integration with
> IORING_OP_READ/IORING_OP_WRITE operations will be submitted as part of a
> separate series.
>=20
> Thanks,
> Joanne=20
>=20
> [1] https://lore.kernel.org/io-uring/20260402160929.2749744-1-joannelkoon=
g@gmail.com/T/#t
> [2] https://lore.kernel.org/linux-fsdevel/20260326215127.3857682-2-joanne=
lkoong@gmail.com/
> [3] https://github.com/joannekoong/libfuse/commits/zero_copy_v2/
>=20
> Changelog
> ---------
> v1: https://lore.kernel.org/linux-fsdevel/20260324224532.3733468-1-joanne=
lkoong@gmail.com/
> v1 -> v2:
> * Drop kernel managed buffers from io-uring infrastructure and instead mo=
ve
>   logic into fuse. To later use buffers with io-uring requests natively w=
ill
>   require fuse to place the backing buffer as a fixed buffer in a sparse =
slot
>   for the server, but that will be added as an optimization in a separate
>   series. This makes the io-uring code cleaner and accomodates for more f=
lexible
>   fuse user configurations (eg mlock limits) and easier setup (me)
> * Run more benchmarks and get more numbers (me)
> * Add visual diagrams and more documentatoin to commit messages and
>   documentation patch (Bernd)
>=20
> Joanne Koong (14):
>   fuse: separate next request fetching from sending logic
>   fuse: refactor io-uring header copying to ring
>   fuse: refactor io-uring header copying from ring
>   fuse: use enum types for header copying
>   fuse: refactor setting up copy state for payload copying
>   fuse: support buffer copying for kernel addresses
>   fuse: use named constants for io-uring iovec indices
>   fuse: move fuse_uring_abort() from header to dev_uring.c
>   fuse: rearrange io-uring iovec and ent allocation logic
>   fuse: add io-uring buffer rings
>   fuse: add pinned headers capability for io-uring buffer rings
>   fuse: add pinned payload buffers capability for io-uring buffer rings
>   fuse: add zero-copy over io-uring
>   docs: fuse: add io-uring bufring and zero-copy documentation
>=20
>  .../filesystems/fuse/fuse-io-uring.rst        |  189 +++
>  fs/fuse/dev.c                                 |   30 +-
>  fs/fuse/dev_uring.c                           | 1042 ++++++++++++++---
>  fs/fuse/dev_uring_i.h                         |   86 +-
>  fs/fuse/fuse_dev_i.h                          |    8 +-
>  include/uapi/linux/fuse.h                     |   36 +-
>  6 files changed, 1194 insertions(+), 197 deletions(-)
>=20
>=20
> base-commit: 619fa72e875483dabf7683001496cc0ca4480aa6

Nice work, Joanne! This seems to be in great shape overall.

I'll note that the first 9 patches or so (maybe modulo patch #6) could
be merged in advance of the bigger io_uring changes.
=20
--=20
Jeff Layton <jlayton@kernel.org>
