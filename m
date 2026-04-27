Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F440846A
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777276977; cv=none; b=BFQm3/n5chV+AQV0zy+KsfUF9KgNcbRq1tvq58x3Ulo1rzYUfQ7TdeRrdiWwIvkRUur/8wxqHh4fKIR35NyQClWsSGnFNCvLV7BEbnj7IHodcoODzOWIXmg7z5kQY+YXadyvw0pQY1XNJbByCF8lwPNtzWHJvzLlvMt3gLHt594=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777276977; c=relaxed/simple;
	bh=tiL5uQkXqGT5eWGwtOviaKVkfFCed3qm6naPm/dsAeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IweVBkVNUa+MbExzk4h/6FF1HigaODC59gnisHVPfBFkSHB8INUqmDSXjJLIQ+8N3uKCd8m0GhETuzGglkBQR68OiJZus71HOB1zPBAelhbLPIxuHm0gCmbWStzN9lgkkoizIFQV/qr3tMMmfW0NRPPmGvck0YfJVwLvfBi3C3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OugRAPKh; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OugRAPKh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=PnjSoo4OSK24mpZhocJP+Qd18FKgHeFukiv2z+J2zkg=; b=OugRAPKh8l2zBxdM7ZPQTPkn7M
	ijS1g8pyBfobcL2p8U0VRIEgYtrUmaZTefjvezs4Qn4+yDxFwCdqFJ9BHzYm9wVU+Nzxd19UU8TRH
	4zT1uIVzRgfOUwa9xq6+TYc5blSjl8cUoii/g5hSQfiSwNBa/iaHhWHO/HT4sy/aZMiyPoa8PxJaJ
	9hk6u8RQ/y4gae3+Gqc9C9F+oQMXHB0zaDaJJxeh4DyW7/oqu0VkkGLLoYKo5OJShBGrEp7BlwCnO
	PgyKR4rkMB5imYZ8Rh7YkJtS9PE+U5jmz+0NuOtCg+wB4eDZme2N6rDE9eKNdLJzCFs0cFDgOfRId
	JW8VWa+Q==;
Received: from bl16-24-16.dsl.telepac.pt ([188.81.24.16] helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wHGvP-002ouX-Gl; Mon, 27 Apr 2026 10:02:38 +0200
From: Luis Henriques <luis@igalia.com>
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>,
  Miklos Szeredi <miklos@szeredi.hu>,  Joanne Koong
 <joannelkoong@gmail.com>,  linux-fsdevel@vger.kernel.org,  Gang He
 <dchg2000@gmail.com>,  Bernd Schubert <bschubert@ddn.com>
Subject: Re: [PATCH v4 3/8] fuse: {io-uring} Use bitmaps to track registered
 queues
In-Reply-To: <859fb89e-81b3-4b49-bd80-532bc7be1395@bsbernd.com> (Bernd
	Schubert's message of "Fri, 24 Apr 2026 17:33:20 +0200")
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
	<20260413-reduced-nr-ring-queues_3-v4-3-982b6414b723@bsbernd.com>
	<874il0o0wi.fsf@igalia.com>
	<859fb89e-81b3-4b49-bd80-532bc7be1395@bsbernd.com>
Date: Mon, 27 Apr 2026 09:02:38 +0100
Message-ID: <87v7dckezl.fsf@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24 2026, Bernd Schubert wrote:

> On 4/24/26 17:04, Luis Henriques wrote:
>> On Mon, Apr 13 2026, Bernd Schubert via B4 Relay wrote:
>>=20
>>> From: Bernd Schubert <bschubert@ddn.com>
>>>
>>> Add per-CPU and per-NUMA node bitmasks to track which
>>> io-uring queues are registered.
>>>
>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>> ---
>>>  fs/fuse/dev_uring.c   | 73 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>>>  fs/fuse/dev_uring_i.h | 20 ++++++++++++++
>>>  2 files changed, 93 insertions(+)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 08c49e5b65ee950a9749a034b1e9d0a8883e1d31..1d1305d38efa07641128a86=
5aec1745d2e040b93 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -186,6 +186,25 @@ bool fuse_uring_request_expired(struct fuse_conn *=
fc)
>>>  	return false;
>>>  }
>>>=20=20
>>> +static void fuse_ring_destruct_q_map(struct fuse_queue_map *q_map)
>>> +{
>>> +	free_cpumask_var(q_map->registered_q_mask);
>>> +	kfree(q_map->cpu_to_qid);
>>> +}
>>> +
>>> +static void fuse_uring_destruct_q_masks(struct fuse_ring *ring)
>>> +{
>>> +	int node;
>>> +
>>> +	fuse_ring_destruct_q_map(&ring->q_map);
>>> +
>>> +	if (ring->numa_q_map) {
>>> +		for (node =3D 0; node < ring->nr_numa_nodes; node++)
>>> +			fuse_ring_destruct_q_map(&ring->numa_q_map[node]);
>>> +		kfree(ring->numa_q_map);
>>> +	}
>>> +}
>>> +
>>>  void fuse_uring_destruct(struct fuse_conn *fc)
>>>  {
>>>  	struct fuse_ring *ring =3D fc->ring;
>>> @@ -217,11 +236,44 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>  		ring->queues[qid] =3D NULL;
>>>  	}
>>>=20=20
>>> +	fuse_uring_destruct_q_masks(ring);
>>>  	kfree(ring->queues);
>>>  	kfree(ring);
>>>  	fc->ring =3D NULL;
>>>  }
>>>=20=20
>>> +static int fuse_uring_init_q_map(struct fuse_queue_map *q_map, size_t =
nr_cpu)
>>> +{
>>> +	if (!zalloc_cpumask_var(&q_map->registered_q_mask, GFP_KERNEL_ACCOUNT=
))
>>> +		return -ENOMEM;
>>> +
>>> +	q_map->cpu_to_qid =3D kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
>>> +					 GFP_KERNEL_ACCOUNT);
>>> +
>>=20
>> Missing NULL check here (and corresponding call to free_cpumask_var()).
>>=20
>>>
>>> +	return 0;
>>> +}
>>> +
>>> +static int fuse_uring_create_q_masks(struct fuse_ring *ring)
>>> +{
>>> +	int err, node;
>>> +
>>> +	err =3D fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	ring->numa_q_map =3D kzalloc_objs(*ring->numa_q_map, ring->nr_numa_no=
des,
>>> +					GFP_KERNEL_ACCOUNT);
>>> +	if (!ring->numa_q_map)
>>> +		return -ENOMEM;
>>=20
>> Missing call to fuse_ring_destruct_q_map().
>>=20
>>> +	for (node =3D 0; node < ring->nr_numa_nodes; node++) {
>>> +		err =3D fuse_uring_init_q_map(&ring->numa_q_map[node],
>>> +					   ring->max_nr_queues);
>>> +		if (err)
>>> +			return err;
>>=20
>> Cleanup also missing here.
>
> I don't think so, for either of both, see error handling in
> fuse_uring_create_q_masks().

Doh! you're right.  The only fuse_uring_create_q_masks() call site is
fuse_uring_create(), which will then call fuse_uring_destruct_q_masks() on
error.  Sorry for the noise :-/

Cheers,
--=20
Lu=C3=ADs
