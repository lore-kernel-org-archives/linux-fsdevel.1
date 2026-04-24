Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA6B245012
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777043729; cv=none; b=VXYpXj+FLN9nUzQ8ZM+tau5KbxghBl+h8lDhQHR/leGWX1u5u4IbTN/jNYcics0sSM+FcfAkAQPEeNpvkCxxSxo8vzfh1Whe77bRQgKdYGVwHzCZ68naXCLMOilHFOvjv6YEYJlZzFn9uo2kg+7gvk74rOZtB8vHCJ5iMLkg0iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777043729; c=relaxed/simple;
	bh=HG7q1ei0ksMG4uS4mYz6WbRUXLtj3HEh28kM0uEhl0Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jsdlBTvf3LPUmWY3RaR7LRns04lVxWQ+P4Qp3YMwW0l1SJRTIlfVHLnwh3qsXObwD6hfIdLwU92O/nakFLMFEXQf3SI135+TvmshhltgFFQo+XkTRaIe2ERv/9IgbUfumTwMygqWCbWUXH0NOZ1gvlaZv1NXH76aAmC7vy/Egyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=b7IkWxUt; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="b7IkWxUt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=gfis2yoKZPhm7+JbcJWq1rDJi75oWTVtc2qaTPJ9lWA=; b=b7IkWxUt3EDPF6O8Vi28KPDmR5
	kArsQ8zMoJisNY/7cfumpYeD7lGwf8et5D19UD4XgPrfE1PoxgYMqfKVHmN86do/sDZqKF6WjTjmW
	iq1rrk5G9YLo7ly0qHEgK0zxt7bWPh78QSqcYtpQ2XGFs9GxbVlizAgTsn0xlb5Rp6FML9pRtDBbh
	NkaATszi4C3zGd1HopFmYjIBGANI2ErnZuzPFkgjIjvBvygOcyUyzx7C7PiMwJcuT2DHKhBRmZpPe
	VHhrFi88QtCDu9CoRk24ZAr8unx+Dftf2eRGipD3ZvevsBD40zS19hfUGG6S/qpq9+7gQk9Q4zcrZ
	7Ce/yTdQ==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wGIFT-001eEx-IL; Fri, 24 Apr 2026 17:15:18 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>,  bernd@bsbernd.com,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>,  Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring
 queues
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
	(Bernd Schubert via's message of "Mon, 13 Apr 2026 11:41:28 +0200")
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
	<20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
Date: Fri, 24 Apr 2026 16:15:13 +0100
Message-ID: <87zf2smltq.fsf@igalia.com>
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
> Queues selection (fuse_uring_get_queue) can handle reduced number
> queues - using io-uring is possible now even with a single
> queue and entry.
>
> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that

nit: "[...] introduced to tell the fuse server [...]"

> reduced queues are possible, i.e. if the flag is set, fuse server
> is free to reduce number queues.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------=
------
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |   3 +
>  3 files changed, 88 insertions(+), 77 deletions(-)
>
> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e=
605c6e36a137f9e 100644
> --- a/fs/fuse/dev_uring.c
> +++ b/fs/fuse/dev_uring.c
> @@ -249,15 +249,17 @@ static int fuse_uring_init_q_map(struct fuse_queue_=
map *q_map, size_t nr_cpu)
>=20=20
>  	q_map->cpu_to_qid =3D kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
>  					 GFP_KERNEL_ACCOUNT);
> +	if (!q_map->cpu_to_qid)
> +		return -ENOMEM;

Ah! I guess this belongs to patch 0001.  And, as I commented there, it
still misses the free_cpumask_var().

>=20=20
>  	return 0;
>  }
>=20=20
> -static int fuse_uring_create_q_masks(struct fuse_ring *ring)
> +static int fuse_uring_create_q_masks(struct fuse_ring *ring, size_t nr_q=
ueues)
>  {
>  	int err, node;
>=20=20
> -	err =3D fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
> +	err =3D fuse_uring_init_q_map(&ring->q_map, nr_queues);
>  	if (err)
>  		return err;
>=20=20
> @@ -267,7 +269,7 @@ static int fuse_uring_create_q_masks(struct fuse_ring=
 *ring)
>  		return -ENOMEM;
>  	for (node =3D 0; node < ring->nr_numa_nodes; node++) {
>  		err =3D fuse_uring_init_q_map(&ring->numa_q_map[node],
> -					   ring->max_nr_queues);
> +					    nr_queues);
>  		if (err)
>  			return err;
>  	}
> @@ -299,7 +301,7 @@ static struct fuse_ring *fuse_uring_create(struct fus=
e_conn *fc)
>  	max_payload_size =3D max(FUSE_MIN_READ_BUFFER, fc->max_write);
>  	max_payload_size =3D max(max_payload_size, fc->max_pages * PAGE_SIZE);
>=20=20
> -	err =3D fuse_uring_create_q_masks(ring);
> +	err =3D fuse_uring_create_q_masks(ring, nr_queues);
>  	if (err)
>  		goto out_err;
>=20=20
> @@ -328,12 +330,36 @@ static struct fuse_ring *fuse_uring_create(struct f=
use_conn *fc)
>  	return res;
>  }
>=20=20
> +static void fuse_uring_cpu_qid_mapping(struct fuse_ring *ring, int qid,
> +				       struct fuse_queue_map *q_map,
> +				       int node)
> +{
> +	int cpu, qid_idx, mapping_count =3D 0;
> +	size_t nr_queues;
> +
> +	cpumask_set_cpu(qid, q_map->registered_q_mask);
> +	nr_queues =3D cpumask_weight(q_map->registered_q_mask);
> +	for (cpu =3D 0; cpu < ring->max_nr_queues; cpu++) {
> +		if (node !=3D -1 && cpu_to_node(cpu) !=3D node)
> +			continue;
> +
> +		qid_idx =3D mapping_count % nr_queues;
> +		q_map->cpu_to_qid[cpu] =3D cpumask_nth(qid_idx,
> +						     q_map->registered_q_mask);
> +		mapping_count++;
> +		pr_debug("%s node=3D%d qid=3D%d qid_idx=3D%d nr_queues=3D%zu %d->%d\n",
> +			 __func__, node, qid, qid_idx, nr_queues, cpu,
> +			 q_map->cpu_to_qid[cpu]);
> +	}
> +}
> +
>  static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring =
*ring,
>  						       int qid)
>  {
>  	struct fuse_conn *fc =3D ring->fc;
>  	struct fuse_ring_queue *queue;
>  	struct list_head *pq;
> +	int node;
>=20=20
>  	queue =3D kzalloc_obj(*queue, GFP_KERNEL_ACCOUNT);
>  	if (!queue)
> @@ -371,6 +397,22 @@ static struct fuse_ring_queue *fuse_uring_create_que=
ue(struct fuse_ring *ring,
>  	 * write_once and lock as the caller mostly doesn't take the lock at all
>  	 */
>  	WRITE_ONCE(ring->queues[qid], queue);
> +
> +	/* Static mapping from cpu to per numa queues */
> +	node =3D cpu_to_node(qid);
> +	fuse_uring_cpu_qid_mapping(ring, qid, &ring->numa_q_map[node], node);
> +
> +	/*
> +	 * smp_store_release, as the variable is read without fc->lock and
> +	 * we need to avoid compiler re-ordering of updating the nr_queues
> +	 * and setting ring->numa_queues[node].cpu_to_qid above
> +	 */
> +	smp_store_release(&ring->numa_q_map[node].nr_queues,
> +			  ring->numa_q_map[node].nr_queues + 1);
> +
> +	/* global mapping */
> +	fuse_uring_cpu_qid_mapping(ring, qid, &ring->q_map, -1);
> +
>  	spin_unlock(&fc->lock);
>=20=20
>  	return queue;
> @@ -1021,65 +1063,6 @@ static int fuse_uring_commit_fetch(struct io_uring=
_cmd *cmd, int issue_flags,
>  	return 0;
>  }
>=20=20
> -static bool is_ring_ready(struct fuse_ring *ring, int current_qid)
> -{
> -	int qid;
> -	struct fuse_ring_queue *queue;
> -	bool ready =3D true;
> -
> -	for (qid =3D 0; qid < ring->max_nr_queues && ready; qid++) {
> -		if (current_qid =3D=3D qid)
> -			continue;
> -
> -		queue =3D ring->queues[qid];
> -		if (!queue) {
> -			ready =3D false;
> -			break;
> -		}
> -
> -		spin_lock(&queue->lock);
> -		if (list_empty(&queue->ent_avail_queue))
> -			ready =3D false;
> -		spin_unlock(&queue->lock);
> -	}
> -
> -	return ready;
> -}
> -
> -/*
> - * fuse_uring_req_fetch command handling
> - */
> -static void fuse_uring_do_register(struct fuse_ring_ent *ent,
> -				   struct io_uring_cmd *cmd,
> -				   unsigned int issue_flags)
> -{
> -	struct fuse_ring_queue *queue =3D ent->queue;
> -	struct fuse_ring *ring =3D queue->ring;
> -	struct fuse_conn *fc =3D ring->fc;
> -	struct fuse_iqueue *fiq =3D &fc->iq;
> -	int node =3D cpu_to_node(queue->qid);
> -
> -	if (WARN_ON_ONCE(node >=3D ring->nr_numa_nodes))
> -		node =3D 0;
> -
> -	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> -
> -	spin_lock(&queue->lock);
> -	ent->cmd =3D cmd;
> -	fuse_uring_ent_avail(ent, queue);
> -	spin_unlock(&queue->lock);
> -
> -	if (!ring->ready) {
> -		bool ready =3D is_ring_ready(ring, queue->qid);
> -
> -		if (ready) {
> -			WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> -			WRITE_ONCE(ring->ready, true);
> -			wake_up_all(&fc->blocked_waitq);
> -		}
> -	}
> -}
> -
>  /*
>   * sqe->addr is a ptr to an iovec array, iov[0] has the headers, iov[1]
>   * the payload
> @@ -1163,6 +1146,7 @@ static int fuse_uring_register(struct io_uring_cmd =
*cmd,
>  	struct fuse_ring *ring =3D smp_load_acquire(&fc->ring);
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent;
> +	struct fuse_iqueue *fiq =3D &fc->iq;
>  	int err;
>  	unsigned int qid =3D READ_ONCE(cmd_req->qid);
>=20=20
> @@ -1194,8 +1178,18 @@ static int fuse_uring_register(struct io_uring_cmd=
 *cmd,
>  	if (IS_ERR(ent))
>  		return PTR_ERR(ent);
>=20=20
> -	fuse_uring_do_register(ent, cmd, issue_flags);
> +	fuse_uring_prepare_cancel(cmd, issue_flags, ent);
> +	if (!ring->ready) {
> +		WRITE_ONCE(fiq->ops, &fuse_io_uring_ops);
> +		WRITE_ONCE(ring->ready, true);
> +		wake_up_all(&fc->blocked_waitq);
> +	}
>=20=20
> +	spin_lock(&queue->lock);
> +	ent->cmd =3D cmd;
> +	spin_unlock(&queue->lock);
> +
> +	/* Marks the ring entry as ready */
>  	fuse_uring_next_fuse_req(ent, queue, issue_flags);
>=20=20
>  	return 0;
> @@ -1312,22 +1306,36 @@ static void fuse_uring_send_in_task(struct io_tw_=
req tw_req, io_tw_token_t tw)
>  	fuse_uring_send(ent, cmd, err, issue_flags);
>  }
>=20=20
> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring=
 *ring)
> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring =
*ring)
>  {
>  	unsigned int qid;
> -	struct fuse_ring_queue *queue;
> +	int node;
> +	unsigned int nr_queues;
> +	unsigned int cpu =3D task_cpu(current);
>=20=20
> -	qid =3D task_cpu(current);
> +	cpu =3D cpu % ring->max_nr_queues;

nit: why set cpu twice?

Cheers,
--=20
Lu=C3=ADs

>=20=20
> -	if (WARN_ONCE(qid >=3D ring->max_nr_queues,
> -		      "Core number (%u) exceeds nr queues (%zu)\n", qid,
> -		      ring->max_nr_queues))
> -		qid =3D 0;
> +	/* numa local registered queue bitmap */
> +	node =3D cpu_to_node(cpu);
> +	if (WARN_ONCE(node >=3D ring->nr_numa_nodes,
> +		      "Node number (%d) exceeds nr nodes (%d)\n",
> +		      node, ring->nr_numa_nodes)) {
> +		node =3D 0;
> +	}
>=20=20
> -	queue =3D ring->queues[qid];
> -	WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
> +	nr_queues =3D READ_ONCE(ring->numa_q_map[node].nr_queues);
> +	if (nr_queues) {
> +		qid =3D ring->numa_q_map[node].cpu_to_qid[cpu];
> +		if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +			return NULL;
> +		return READ_ONCE(ring->queues[qid]);
> +	}
>=20=20
> -	return queue;
> +	/* global registered queue bitmap */
> +	qid =3D ring->q_map.cpu_to_qid[cpu];
> +	if (WARN_ON_ONCE(qid >=3D ring->max_nr_queues))
> +		return NULL;
> +	return READ_ONCE(ring->queues[qid]);
>  }
>=20=20
>  static void fuse_uring_dispatch_ent(struct fuse_ring_ent *ent)
> @@ -1348,7 +1356,7 @@ void fuse_uring_queue_fuse_req(struct fuse_iqueue *=
fiq, struct fuse_req *req)
>  	int err;
>=20=20
>  	err =3D -EINVAL;
> -	queue =3D fuse_uring_task_to_queue(ring);
> +	queue =3D fuse_uring_select_queue(ring);
>  	if (!queue)
>  		goto err;
>=20=20
> @@ -1392,7 +1400,7 @@ bool fuse_uring_queue_bq_req(struct fuse_req *req)
>  	struct fuse_ring_queue *queue;
>  	struct fuse_ring_ent *ent =3D NULL;
>=20=20
> -	queue =3D fuse_uring_task_to_queue(ring);
> +	queue =3D fuse_uring_select_queue(ring);
>  	if (!queue)
>  		return false;
>=20=20
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index c795abe47a4f4a488b9623c389e4afce43c6647d..5cb903186c29a77727551fe72=
c4cabf705a22258 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1506,7 +1506,7 @@ static struct fuse_init_args *fuse_new_init(struct =
fuse_mount *fm)
>  		FUSE_SECURITY_CTX | FUSE_CREATE_SUPP_GROUP |
>  		FUSE_HAS_EXPIRE_ONLY | FUSE_DIRECT_IO_ALLOW_MMAP |
>  		FUSE_NO_EXPORT_SUPPORT | FUSE_HAS_RESEND | FUSE_ALLOW_IDMAP |
> -		FUSE_REQUEST_TIMEOUT;
> +		FUSE_REQUEST_TIMEOUT | FUSE_URING_REDUCED_Q;
>  #ifdef CONFIG_FUSE_DAX
>  	if (fm->fc->dax)
>  		flags |=3D FUSE_MAP_ALIGNMENT;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index c13e1f9a2f12bd39f535188cb5466688eba42263..3da20d9bba1cb6336734511d2=
1da9f64cea0e720 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -448,6 +448,8 @@ struct fuse_file_lock {
>   * FUSE_OVER_IO_URING: Indicate that client supports io-uring
>   * FUSE_REQUEST_TIMEOUT: kernel supports timing out requests.
>   *			 init_out.request_timeout contains the timeout (in secs)
> + * FUSE_URING_REDUCED_Q: Client (kernel) supports less queues - Server i=
s free
> + *			 to register between 1 and nr-core io-uring queues
>   */
>  #define FUSE_ASYNC_READ		(1 << 0)
>  #define FUSE_POSIX_LOCKS	(1 << 1)
> @@ -495,6 +497,7 @@ struct fuse_file_lock {
>  #define FUSE_ALLOW_IDMAP	(1ULL << 40)
>  #define FUSE_OVER_IO_URING	(1ULL << 41)
>  #define FUSE_REQUEST_TIMEOUT	(1ULL << 42)
> +#define FUSE_URING_REDUCED_Q (1ULL << 43)
>=20=20
>  /**
>   * CUSE INIT request/reply flags
>
> --=20
> 2.43.0
>
>
