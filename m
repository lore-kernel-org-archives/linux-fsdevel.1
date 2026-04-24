Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF622BD59C
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044405; cv=none; b=mFca/xBSpmw/3HHNJ3wKSw5qjTA1/8KCbPlLetEaOMHwE3N+EWY8egWwTJ9CYjR7EFsXIvAQSn0aulAOtAeWJh+OI4diVwZfkvgmKmALpylSwaiVTYm823N5GulHEubt6eRJByoUkjp5HEHXwjFN4sK9M4dEiATkqrt8OXy2SdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044405; c=relaxed/simple;
	bh=/EhCKxE0pNv0ku1Bd2x6HObIE8VX2mmiiCjwiDo2Bh0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pKPxCpEHwALWv1KP96Rui98ktbqhUqY7cd76hlk+0PXbMfCpyXDJ3CVVNAVbfVF38HE3W6BQveZ3HOBpyM2lF4Ucdt4MkfrsDFa9KOL4QnSRXhcJO8JFg26s/0NqW/8zmsz7o7q4dr1532t7iqb9AQjhp2DvP80bmeY8Vi1mdWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kGAuiOLc; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kGAuiOLc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=DWEwqllkzbvUbY9bSKr4V7pg96JAlrybAvuC/+Aloy0=; b=kGAuiOLc6p/roTEHBpy4+WVLPr
	N1HuFJNsEVc+UY2dbpoq/jvZwbDI7ruDZi3LBwlicz+WAAlPlm4okv9cXfH45PcW+zyoVKMAgl5cl
	men94lsoh8H04luiI9W85Q58C4vpxMHOM2rDLNmGu81qmvdEEMRH1cPAyEVFhKOtYWzO7kRES9lP2
	v3guYT01A12Gq6zrECVzCdON/pqTbtG9nGfxu3dJsO912xQrTXNzEn20pPD0r7coYfLR7+/8ePRv9
	jOo8wXHTQiAGO1NYzA9ZEtJlEIPPr4/0u7z5joaSaRQmJCocDu1sTtkVjE0gxQ+QU4mhm2IUWPvgn
	lJuKYdHQ==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGIQI-001eU5-G1; Fri, 24 Apr 2026 17:26:30 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  bernd@bsbernd.com,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>,  Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
	(Bernd Schubert via's message of "Mon, 13 Apr 2026 11:41:29 +0200")
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
	<20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
Date: Fri, 24 Apr 2026 16:26:22 +0100
Message-ID: <87v7dgmlb5.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13 2026, Bernd Schubert via B4 Relay wrote:

> From: Bernd Schubert <bschubert@ddn.com>
>
> Running background IO on a different core makes quite a difference.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
>  --direct=3D1
>
> unpatched
>    READ: bw=3D272MiB/s (285MB/s) ...
> patched
>    READ: bw=3D650MiB/s (682MB/s)
>
> Reason is easily visible, the fio process is migrating between CPUs
> when requests are submitted on the queue for the same core.
>
> With --iodepth=3D8
>
> unpatched
>    READ: bw=3D466MiB/s (489MB/s)
> patched
>    READ: bw=3D641MiB/s (672MB/s)
>
> Without io-uring (--iodepth=3D8)
>    READ: bw=3D729MiB/s (764MB/s)
>
> Without fuse (--iodepth=3D8)
>    READ: bw=3D2199MiB/s (2306MB/s)
>
> (Test were done with
> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
> [-o io_uring] /tmp/source /tmp/dest
> )
>
> Additional notes:
>
> With FURING_NEXT_QUEUE_RETRIES=3D0 (--iodepth=3D8)
>    READ: bw=3D903MiB/s (946MB/s)
>
> With just a random qid (--iodepth=3D8)
>    READ: bw=3D429MiB/s (450MB/s)
>
> With --iodepth=3D1
> unpatched
>    READ: bw=3D195MiB/s (204MB/s)
> patched
>    READ: bw=3D232MiB/s (243MB/s)
>
> With --iodepth=3D1 --numjobs=3D2
> unpatched
>    READ: bw=3D366MiB/s (384MB/s)
> patched
>    READ: bw=3D472MiB/s (495MB/s)
>
> With --iodepth=3D1 --numjobs=3D8
> unpatched
>    READ: bw=3D1437MiB/s (1507MB/s)
> patched
>    READ: bw=3D1529MiB/s (1603MB/s)
> fuse without io-uring
>    READ: bw=3D1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
> no-fuse
>    READ: bw=3D2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>
> In summary, for async requests the core doing application IO is busy
> sending requests and processing IOs should be done on a different core.
> Spreading the load on random cores is also not desirable, as the core
> might be frequency scaled down and/or in C1 sleep states. Not shown here,
> but differnces are much smaller when the system uses performance govenor
> instead of schedutil (ubuntu default). Obviously at the cost of higher
> system power consumption for performance govenor - not desirable either.
>
> Results without io-uring (which uses fixed libfuse threads per queue)
> heavily depend on the current number of active threads. Libfuse uses
> default of max 10 threads, but actual nr max threads is a parameter.
> Also, no-fuse-io-uring results heavily depend on, if there was already
> running another workload before, as libfuse starts these threads
> dynamically - i.e. the more threads are active, the worse the
> performance.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb51d=
d6957fe1704ec87 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_tw_=
req tw_req, io_tw_token_t tw)
>  	fuse_uring_send(ent, cmd, err, issue_flags);
>  }
>=20=20
> -static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring)
> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring,
> +						       bool background)
>  {
>  	unsigned int qid;
>  	int node;
>  	unsigned int nr_queues;
>  	unsigned int cpu =3D task_cpu(current);
>=20=20
> +	/*
> +	 *  Background requests result in better performance on a different
> +	 *  CPU, unless CPUs are already busy.
> +	 */
> +	if (background)
> +		cpu++;
> +

The performance number look great, but I was wondering if you get similar
improvements for write operations.

Also, isn't 'cpu++' too arbitrary?  I mean, isn't there some heuristics
that could be used?  I understand the goal is just to push the request
somewhere else, but does it make sense to push it to the next cpu on the
same node?  Or to the next cpu in a different core?  I'm just thinking out
loud, and maybe this is non-sense ;-)

Finally, shouldn't this behaviour be behind some knob?  Maybe it's
over-complicating for no good reason, but being able to: 1) enable/disable
it, 2) enable by pushing it to the next cpu (this behaviour), 3) enable by
pushing to the next cpu on the same/different node, etc.

Cheers,
--=20
Lu=C3=ADs

>  	cpu =3D cpu % ring->max_nr_queues;
>=20=20
>  	/* numa local registered queue bitmap */
> @@ -1356,7 +1364,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>  	int err;
>=20=20
>  	err =3D -EINVAL;
> -	queue =3D fuse_uring_select_queue(ring);
> +	queue =3D fuse_uring_select_queue(ring, false);
>  	if (!queue)
>  		goto err;
>=20=20
> @@ -1400,7 +1408,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent =3D NULL;
>=20=20
> -	queue =3D fuse_uring_select_queue(ring);
> +	queue =3D fuse_uring_select_queue(ring, true);
>  	if (!queue)
>  		return false;
>=20=20
>
> --=20
> 2.43.0
>
>
