Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5653264F7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Apr 2026 15:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777044806; cv=none; b=RUNhmSsD9VuGjQMsR8nvyX7Caa7ba8mfrVci5ZPpTjg505cWJY8276icJ4FvlJpbSu41IH6gLXeVmHYYgwi4QFfoIOW6tcOQQGAlahNSM/lCcH1kEgTnC3JgA8upji+cnspXLFr2tDU4AaUuQl4yWrdo4NQvSa6GJu3GWbIfuEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777044806; c=relaxed/simple;
	bh=ITBLPrctCIKLjJ+a2Esa7/0b5w/8tCdXT+uVuFonZ7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AZo4Suq6aG1+6+Y4xWPBZexfwNb+8ullEukEe0zzbMTGSadpyWQIF5OCfEWzTD20z88BZmmEdxf7tJKzv4vQA4oJxIuI9MGcmR8fgkyaJ060MCS7oPnzrhfkFALAc5UMyWcbW9aJuqonxivhZejVlGmGLI+4HDuflzvV/294S1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=brLHhuzy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oyUwW8K5; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="brLHhuzy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oyUwW8K5"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 304B07A0025;
	Fri, 24 Apr 2026 11:33:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 24 Apr 2026 11:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777044802;
	 x=1777131202; bh=aLl7S0EyqH7LJ4gPdalN+JJtZ0uEYBnrsGkIeKaRyrE=; b=
	brLHhuzyMMYtqy7xYKgJCS8n3j/alaJZ4q4WvaOpykDJ96C+gvZ/uLIQOftHLwgm
	Nb+al0OU3p3qy5In5ro7nd6poS9fiXHsGwgqOuatPPl8q0fOOSfKG12DghIVt3KI
	7nj93v+53AxfdG1xnEAm5e3f8WzjxacSuqw/JiVD0n5sPAfDh7XdhDPRl87JIsKS
	44xg2P+bAW9DRHGEl4abG3OmGJxhpWB69fPpo4q5xXScOuB/c3+L6oEo90qPzz8c
	J+0gCqmylOz5TlOctZdhdaHUZ5/XyVXdx0OOSv11HrWg0KLyOxe+ERh+D24ifC1E
	IkBUjEBby2vy8iMLz5Q4mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777044802; x=
	1777131202; bh=aLl7S0EyqH7LJ4gPdalN+JJtZ0uEYBnrsGkIeKaRyrE=; b=o
	yUwW8K5nvLobzTib4gvWc8J179jFSCOnwDsGJZySn/oxVFzs4PsMTBmxDecmR/zw
	wdMP9/3rvBRuBPeJlbdXX+KvBqHO/5CTZyk0jZFTvcZFmQivCx6HqYreHFJq6+Qc
	2hVQSwwn/Yx7OQj/4ifnWxwhdCEpDhofOVJLbywiXxEbiyQaKU2964+DRB6v5guO
	rcIwlMDPVSTE6livdUoYzmsjlNy3RFvOtYt3GQRoXH3UsTQn+m9rqw82BXSSgR95
	WAyvXcDy1skPezXoPnCMo5zAQ1xCHzkcXbdCyW3TiIxIOrWOimxD+aoURGI6fcEy
	tRiKQDip9+ERQwZ9LIFfA==
X-ME-Sender: <xms:Qo3raf0CrBOBcrtv4TSWe76KeRYNK0U3_6hvzsOtHVvY5YekmYfmVQ>
    <xme:Qo3raQWY9hDCkAGYwsTcK_zOR5jZ2VQdPFo0kF491SQhIxL45v92T_hL3U20xJS31
    Nznm8PeI1Pgyf629IDu7PLTBhQ2-7GcfwxXu_xpXM1kCVjJTwDeLA>
X-ME-Received: <xmr:Qo3raSIUcyuDeZ7eurpq_daZ2hLWZSlFhaKiF7a8681nnHtmKh2FE8hpEI6O81O-AsVlSa7M3_zn9Ny3Zq2Ajdd522yXMsibUyzifaWVG444fK9_hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejtdegtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhephefhjeeujeelhedtheetfedvgfdtleffuedujefhheegudefvdfhheeuvedu
    ueegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtth
    hopeguvghvnhhulhhlodgsvghrnhgurdgsshgsvghrnhgurdgtohhmsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoh
    epjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheplhhinhhu
    gidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegutg
    hhghdvtddttdesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtsegu
    ughnrdgtohhm
X-ME-Proxy: <xmx:Qo3raa2MHX5EuQ4otbxFcEBfidVYQxJz1gMEaTxIAl7TvxAWlTVSsA>
    <xmx:Qo3raQ4oKTz4RF-7G2MvlnXAEp9yJ4sGnmLRT96IjqcmD1C6BP_F7g>
    <xmx:Qo3rab8BuPr4Nnb7-W6UN-7YRajqh0mn4p089UL3AR7WZAYVBK3VPQ>
    <xmx:Qo3rafWz2MN4U0DSxPDIibxeBukQDyTAzUHLO5fQJkBwyUjOESzbZA>
    <xmx:Qo3raX7SIyMpZbCcxT38GMzDwZGjrPnoXApJ3Xt6Ow50Ur2MeT6WoBuo>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Apr 2026 11:33:21 -0400 (EDT)
Message-ID: <859fb89e-81b3-4b49-bd80-532bc7be1395@bsbernd.com>
Date: Fri, 24 Apr 2026 17:33:20 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] fuse: {io-uring} Use bitmaps to track registered
 queues
To: Luis Henriques <luis@igalia.com>,
 Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong
 <joannelkoong@gmail.com>, linux-fsdevel@vger.kernel.org,
 Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-3-982b6414b723@bsbernd.com>
 <874il0o0wi.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <874il0o0wi.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/24/26 17:04, Luis Henriques wrote:
> On Mon, Apr 13 2026, Bernd Schubert via B4 Relay wrote:
> 
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> Add per-CPU and per-NUMA node bitmasks to track which
>> io-uring queues are registered.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  fs/fuse/dev_uring.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>  fs/fuse/dev_uring_i.h | 20 ++++++++++++++
>>  2 files changed, 93 insertions(+)
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 08c49e5b65ee950a9749a034b1e9d0a8883e1d31..1d1305d38efa07641128a865aec1745d2e040b93 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -186,6 +186,25 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>>  	return false;
>>  }
>>  
>> +static void fuse_ring_destruct_q_map(struct fuse_queue_map *q_map)
>> +{
>> +	free_cpumask_var(q_map->registered_q_mask);
>> +	kfree(q_map->cpu_to_qid);
>> +}
>> +
>> +static void fuse_uring_destruct_q_masks(struct fuse_ring *ring)
>> +{
>> +	int node;
>> +
>> +	fuse_ring_destruct_q_map(&ring->q_map);
>> +
>> +	if (ring->numa_q_map) {
>> +		for (node = 0; node < ring->nr_numa_nodes; node++)
>> +			fuse_ring_destruct_q_map(&ring->numa_q_map[node]);
>> +		kfree(ring->numa_q_map);
>> +	}
>> +}
>> +
>>  void fuse_uring_destruct(struct fuse_conn *fc)
>>  {
>>  	struct fuse_ring *ring = fc->ring;
>> @@ -217,11 +236,44 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>  		ring->queues[qid] = NULL;
>>  	}
>>  
>> +	fuse_uring_destruct_q_masks(ring);
>>  	kfree(ring->queues);
>>  	kfree(ring);
>>  	fc->ring = NULL;
>>  }
>>  
>> +static int fuse_uring_init_q_map(struct fuse_queue_map *q_map, size_t nr_cpu)
>> +{
>> +	if (!zalloc_cpumask_var(&q_map->registered_q_mask, GFP_KERNEL_ACCOUNT))
>> +		return -ENOMEM;
>> +
>> +	q_map->cpu_to_qid = kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
>> +					 GFP_KERNEL_ACCOUNT);
>> +
> 
> Missing NULL check here (and corresponding call to free_cpumask_var()).
> 
>>
>> +	return 0;
>> +}
>> +
>> +static int fuse_uring_create_q_masks(struct fuse_ring *ring)
>> +{
>> +	int err, node;
>> +
>> +	err = fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
>> +	if (err)
>> +		return err;
>> +
>> +	ring->numa_q_map = kzalloc_objs(*ring->numa_q_map, ring->nr_numa_nodes,
>> +					GFP_KERNEL_ACCOUNT);
>> +	if (!ring->numa_q_map)
>> +		return -ENOMEM;
> 
> Missing call to fuse_ring_destruct_q_map().
> 
>> +	for (node = 0; node < ring->nr_numa_nodes; node++) {
>> +		err = fuse_uring_init_q_map(&ring->numa_q_map[node],
>> +					   ring->max_nr_queues);
>> +		if (err)
>> +			return err;
> 
> Cleanup also missing here.

I don't think so, for either of both, see error handling in
fuse_uring_create_q_masks().


Thanks,
Bernd



