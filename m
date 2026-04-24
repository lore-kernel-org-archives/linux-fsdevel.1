Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA743126CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044494; cv=none; b=dQ7Cx/0uMcNLxknY794zzm1kLTyu+2uDbT9Q3jgOpuT6/DmVVXmIZ/CQKiz9IEUr+9QOwCw7cYGDmvfL7mEuCR1SlmAQ189kjvw/xr8A/m8oRazvAn1heqRCgaX81wMVeJwusJWP0zq+afVqKgp1tHRa0Bqcg3IYvLTctJM02BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044494; c=relaxed/simple;
	bh=9gTlJuYsEHsCEJaO5v7fYlCPufR8B84uOdxazbJdLCc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZGkVnlRov4JiAfFltY7+iBWajqVUb+duyD0zyazAdFu3VfIHER/lCh4v71aHz3ymuYVpKSr29aQkMh0rb0CJGP2SQFlAH2chhnRRKYLIC6r3egbzTvi7BqijVG/T9w0Aq0/Mmk+IBjeS1B8b0lPnv/o6aCM8Kj6NFRJMgIx/6oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JD+4LRmL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JD+4LRmL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pa1h7ac8qV0yPtNRiFA5vViA8G5T5/eh//+xoTvOEgM=; b=JD+4LRmLigFt2lGIpIbf8um6d8
	nuERqqpHj+UTYl7FLITqWudppvw8VK1L+wEpdRbsMkLLhhYM2TJaQV1Axj3R1TjGTCUfXp87f49VU
	G0VVX9iDFWy0NLdB6hw3gWFMqz+FYYD0NCNcfKuwkEc5xvtONmAa0t6UL3B0b2oZcMs+W7aQZrao/
	1fehew2J1d0ZcRJe3LyI1jQL3fCZnkmXAmYNNPGof2k3d4Ap5ucz/YM/VzngVhsU/V+bN8f0ARK3X
	EjFjcA7BO0mNA9WJy5In3A2W+6XRt+8hFpcoFBUTPreE2Bqau27Fdbhgb9oK+KFwOeEtwfl3RvhRc
	LeFLZIvA==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGIRq-001eW5-Vb; Fri, 24 Apr 2026 17:28:06 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  bernd@bsbernd.com,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>,  Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 7/8] fuse: Add retry attempts for numa local queues
 for load distribution
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-7-982b6414b723@bsbernd.com>
	(Bernd Schubert via's message of "Mon, 13 Apr 2026 11:41:30 +0200")
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
	<20260413-reduced-nr-ring-queues_3-v4-7-982b6414b723@bsbernd.com>
Date: Fri, 24 Apr 2026 16:28:05 +0100
Message-ID: <87tst0ml8a.fsf@igalia.com>
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
> This is to further improve performance.
>
> fio --directory=3D/tmp/dest --name=3Diops.\$jobnum --rw=3Drandread \
> --bs=3D4k --size=3D1G --numjobs=3D1 --iodepth=3D4 --time_based\
> --runtime=3D30s --group_reporting --ioengine=3Dio_uring\
> --direct=3D1
>
> unpatched
>    READ: bw=3D650MiB/s (682MB/s)
> patched:
>    READ: bw=3D995MiB/s (1043MB/s)
>
> with --iodepth=3D8
>
> unpatched
>    READ: bw=3D641MiB/s (672MB/s)
> patched
>    READ: bw=3D966MiB/s (1012MB/s)
>
> Reason is that with --iodepth=3Dx (x > 1) fio submits multiple async
> requests and a single queue might become CPU limited. I.e. spreading
> the load helps.
> ---
>  fs/fuse/dev_uring.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index ed061e239b8ed70ff36deb51dd6957fe1704ec87..e06d45b161d5000e24431314b=
2222b66bdea58aa 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -19,6 +19,7 @@ MODULE_PARM_DESC(enable_uring,
>=20=20
>  #define FUSE_URING_IOV_SEGS 2 /* header and payload */
>=20=20
> +#define FUSE_URING_Q_THRESHOLD 2
>=20=20
>  bool fuse_uring_enabled(void)
>  {
> @@ -1310,9 +1311,10 @@ static struct fuse_ring_queue *fuse_uring_select_q=
ueue(struct fuse_ring *ring,
>  						       bool background)
>  {
>  	unsigned int qid;
> -	int node;
> +	int node, retries =3D 0;
>  	unsigned int nr_queues;
>  	unsigned int cpu =3D task_cpu(current);
> +	struct fuse_ring_queue *queue, *primary_queue =3D NULL;
>=20=20
>  	/*
>  	 *  Background requests result in better performance on a different
> @@ -1321,6 +1323,7 @@ static struct fuse_ring_queue *fuse_uring_select_qu=
eue(struct fuse_ring *ring,
>  	if (background)
>  		cpu++;
>=20=20
> +retry:
>  	cpu =3D cpu % ring->max_nr_queues;
>=20=20
>  	/* numa local registered queue bitmap */
> @@ -1336,12 +1339,35 @@ static struct fuse_ring_queue *fuse_uring_select_=
queue(struct fuse_ring *ring,
>  		qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
>  		if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
>  			return NULL;
> -		return READ_ONCE(ring->queues[qid]);
> +		queue =3D READ_ONCE(ring->queues[qid]);
> +
> +		/* Might happen on teardown */
> +		if (unlikely(!queue))
> +			return NULL;
> +
> +		if (queue->nr_reqs < FUSE_URING_Q_THRESHOLD)
> +			return queue;
> +
> +		/* Retries help for load balancing */
> +		if (retries < FUSE_URING_Q_THRESHOLD) {
> +			if (!retries)
> +				primary_queue =3D queue;
> +
> +			/* Increase cpu, assuming it will map to a differet qid*/

nit: "different"

> +			cpu++;
> +			retries++;
> +			goto retry;
> +		}
>  	}
>=20=20
> +	/* Retries exceeded, take the primary target queue */
> +	if (primary_queue)
> +		return primary_queue;
> +
>  	/* global registered queue bitmap */
>  	qid =3D ring->q_map.cpu_to_qid[cpu];
>  	if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +	/* Might happen on teardown */

This comment should probably be in the line above the 'if' statement.

Cheers,
--=20
Lu=C3=ADs

>  		return NULL;
>  	return READ_ONCE(ring->queues[qid]);
>  }
>
> --=20
> 2.43.0
>
>

