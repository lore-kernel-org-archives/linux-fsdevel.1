Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03A9282F3F
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043073; cv=none; b=T8H+u6HeqxaAqBufFSlcwXC+UksjEUxlIh7b9oRvRPa4CVD4QRMGobLa4PEFOqvOIPrZEb7bEPdXoV0ScZPq3fmj9OsygFpLa25i77+kjkK7rRO95itBL7t1KymcEJ50mYxluytd2JfC9IW7QdQjUXNocXMTYK1G9Q2dNHemzco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043073; c=relaxed/simple;
	bh=bQw4Tl1Og/0SkXbPLUsPpkaaOalLF7lriSdna3fnWRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ll7dyF3w/SFqE3xDjo9W+S6qQe2jOpUZygggWLe4UWRGKhpXdPyVJOp+eNzAG2KsLHgvasx7np+VzaI5SusVuO/bS1ImrS3ylhZtuyHCkWAWzOmx9OIAS4f7MIjZX5BJnACjcbWP/iackfhWd6Eq8D7L6Hy/wiJVn0UldvJClDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=kvXny8tG; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="kvXny8tG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=QvhzIwXaICP60ul0iBXccYuhc7ELJO5X0b7d1XMxEOE=; b=kvXny8tGKs+Tfu9obSCGyjta2A
	+mXIDWVds12pViVecwBJG5Wa4ZoJIYF8/yRAlMSV31iFg49sC2KtcQPTn9RC2cw3WMtJ4LwqGpCvi
	FasOHoyVgasXmVDL5HoUeWxC+tiKglMb6F67kP94+pxoOB6siPSHR4ymbfV7Waab5bAug8I4vQrE2
	8cnfdzrhaTGRmBmU0taSboaWLIAI8mt9cT9/E61t/+RaCxztV7bztlGfMV41BlvpMqmQrFh+fE44g
	dqobhvTls8c3MtCM7LoCSUuI/lrCoX9hv3UwkqJcCmxupo+kqOxgEfQ1Sc9PodTNS8HuZTnK1Vigg
	94mgQzcA==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGI4p-001dxF-IY; Fri, 24 Apr 2026 17:04:18 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  bernd@bsbernd.com,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>,  Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 3/8] fuse: {io-uring} Use bitmaps to track registered
 queues
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-3-982b6414b723@bsbernd.com>
	(Bernd Schubert via's message of "Mon, 13 Apr 2026 11:41:26 +0200")
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
	<20260413-reduced-nr-ring-queues_3-v4-3-982b6414b723@bsbernd.com>
Date: Fri, 24 Apr 2026 16:04:13 +0100
Message-ID: <874il0o0wi.fsf@igalia.com>
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
> Add per-CPU and per-NUMA node bitmasks to track which
> io-uring queues are registered.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  fs/fuse/dev_uring_i.h | 20 ++++++++++++++
>  2 files changed, 93 insertions(+)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 08c49e5b65ee950a9749a034b1e9d0a8883e1d31..1d1305d38efa07641128a865a=
ec1745d2e040b93 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -186,6 +186,25 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>  	return false;
>  }
>=20=20
> +static void fuse_ring_destruct_q_map(struct fuse_queue_map *q_map)
> +{
> +	free_cpumask_var(q_map->registered_q_mask);
> +	kfree(q_map->cpu_to_qid);
> +}
> +
> +static void fuse_uring_destruct_q_masks(struct fuse_ring *ring)
> +{
> +	int node;
> +
> +	fuse_ring_destruct_q_map(&ring->q_map);
> +
> +	if (ring->numa_q_map) {
> +		for (node =3D 0; node < ring->nr_numa_nodes; node++)
> +			fuse_ring_destruct_q_map(&ring->numa_q_map[node]);
> +		kfree(ring->numa_q_map);
> +	}
> +}
> +
>  void fuse_uring_destruct(struct fuse_conn *fc)
>  {
>  	struct fuse_ring *ring =3D fc->ring;
> @@ -217,11 +236,44 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>  		ring->queues[qid] =3D NULL;
>  	}
>=20=20
> +	fuse_uring_destruct_q_masks(ring);
>  	kfree(ring->queues);
>  	kfree(ring);
>  	fc->ring =3D NULL;
>  }
>=20=20
> +static int fuse_uring_init_q_map(struct fuse_queue_map *q_map, size_t nr=
_cpu)
> +{
> +	if (!zalloc_cpumask_var(&q_map->registered_q_mask, GFP_KERNEL_ACCOUNT))
> +		return -ENOMEM;
> +
> +	q_map->cpu_to_qid =3D kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
> +					 GFP_KERNEL_ACCOUNT);
> +

Missing NULL check here (and corresponding call to free_cpumask_var()).

>=20
> +	return 0;
> +}
> +
> +static int fuse_uring_create_q_masks(struct fuse_ring *ring)
> +{
> +	int err, node;
> +
> +	err =3D fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
> +	if (err)
> +		return err;
> +
> +	ring->numa_q_map =3D kzalloc_objs(*ring->numa_q_map, ring->nr_numa_node=
s,
> +					GFP_KERNEL_ACCOUNT);
> +	if (!ring->numa_q_map)
> +		return -ENOMEM;

Missing call to fuse_ring_destruct_q_map().

> +	for (node =3D 0; node < ring->nr_numa_nodes; node++) {
> +		err =3D fuse_uring_init_q_map(&ring->numa_q_map[node],
> +					   ring->max_nr_queues);
> +		if (err)
> +			return err;

Cleanup also missing here.

Cheers,
--=20
Lu=C3=ADs

> +	}
> +	return 0;
> +}
> +
>  /*
>   * Basic ring setup for this connection based on the provided configurat=
ion
>   */
> @@ -231,6 +283,7 @@ static struct fuse_ring *fuse_uring_create(struct fus=
e_conn *fc)
>  	size_t nr_queues =3D num_possible_cpus();
>  	struct fuse_ring *res =3D NULL;
>  	size_t max_payload_size;
> +	int err;
>=20=20
>  	ring =3D kzalloc_obj(*fc->ring, GFP_KERNEL_ACCOUNT);
>  	if (!ring)
> @@ -241,9 +294,15 @@ static struct fuse_ring *fuse_uring_create(struct fu=
se_conn *fc)
>  	if (!ring->queues)
>  		goto out_err;
>=20=20
> +	ring->nr_numa_nodes =3D num_online_nodes();
> +
>  	max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fc->max_write);
>  	max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZE);
>=20=20
> +	err =3D fuse_uring_create_q_masks(ring);
> +	if (err)
> +		goto out_err;
> +
>  	spin_lock(&fc->lock);
>  	if (fc->ring) {
>  		/* race, another thread created the ring in the meantime */
> @@ -263,6 +322,7 @@ static struct fuse_ring *fuse_uring_create(struct fus=
e_conn *fc)
>  	return ring;
>=20=20
>  out_err:
> +	fuse_uring_destruct_q_masks(ring);
>  	kfree(ring->queues);
>  	kfree(ring);
>  	return res;
> @@ -425,6 +485,7 @@ static void fuse_uring_log_ent_state(struct fuse_ring=
 *ring)
>  			pr_info(" ent-commit-queue ring=3D%p qid=3D%d ent=3D%p state=3D%d\n",
>  				ring, qid, ent, ent->state);
>  		}
> +
>  		spin_unlock(&queue->lock);
>  	}
>  	ring->stop_debug_log =3D 1;
> @@ -471,6 +532,7 @@ static void fuse_uring_async_stop_queues(struct work_=
struct *work)
>  void fuse_uring_stop_queues(struct fuse_ring *ring)
>  {
>  	int qid;
> +	int node;
>=20=20
>  	for (qid =3D 0; qid < ring->max_nr_queues; qid++) {
>  		struct fuse_ring_queue *queue =3D READ_ONCE(ring->queues[qid]);
> @@ -481,6 +543,13 @@ void fuse_uring_stop_queues(struct fuse_ring *ring)
>  		fuse_uring_teardown_entries(queue);
>  	}
>=20=20
> +	/* Reset all queue masks, we won't process any more IO */
> +	cpumask_clear(ring->q_map.registered_q_mask);
> +	for (node =3D 0; node < ring->nr_numa_nodes; node++) {
> +		if (ring->numa_q_map)
> +			cpumask_clear(ring->numa_q_map[node].registered_q_mask);
> +	}
> +
>  	if (atomic_read(&ring->queue_refs) > 0) {
>  		ring->teardown_time =3D jiffies;
>  		INIT_DELAYED_WORK(&ring->async_teardown_work,
> @@ -988,6 +1057,10 @@ static void fuse_uring_do_register(struct fuse_ring=
_ent *ent,
>  	struct fuse_ring *ring =3D queue->ring;
>  	struct fuse_conn *fc =3D ring->fc;
>  	struct fuse_iqueue *fiq =3D &fc->iq;
> +	int node =3D cpu_to_node(queue->qid);
> +
> +	if (WARN_ON_ONCE(node >=3D ring->nr_numa_nodes))
> +		node =3D 0;
>=20=20
>  	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
>=20=20
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 708412294982566919122a1a0d7f741217c763ce..83506f431b97249c8f0c82f89=
f0fce41021288dd 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -104,6 +104,17 @@ struct fuse_ring_queue {
>  	bool stopped;
>  };
>=20=20
> +struct fuse_queue_map {
> +	/* Tracks which queues are registered */
> +	cpumask_var_t registered_q_mask;
> +
> +	/* number of registered queues */
> +	size_t nr_queues;
> +
> +	/* cpu to qid mapping */
> +	int *cpu_to_qid;
> +};
> +
>  /**
>   * Describes if uring is for communication and holds alls the data needed
>   * for uring communication
> @@ -115,6 +126,9 @@ struct fuse_ring {
>  	/* number of ring queues */
>  	size_t max_nr_queues;
>=20=20
> +	/* number of numa nodes */
> +	int nr_numa_nodes;
> +
>  	/* maximum payload/arg size */
>  	size_t max_payload_sz;
>=20=20
> @@ -125,6 +139,12 @@ struct fuse_ring {
>  	 */
>  	unsigned int stop_debug_log : 1;
>=20=20
> +	/* per numa node queue tracking */
> +	struct fuse_queue_map *numa_q_map;
> +
> +	/* all queue tracking */
> +	struct fuse_queue_map q_map;
> +
>  	wait_queue_head_t stop_waitq;
>=20=20
>  	/* async tear down */
>
> --=20
> 2.43.0
>
>
