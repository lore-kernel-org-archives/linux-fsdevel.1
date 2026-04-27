Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5C9245005
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 10:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286355; cv=none; b=gtD5vI5kewC6TPgWb+fHgItWOX9oOTX+mcBO0KWJVyktsvOcBJAs8CUGmRw/srflcOmjFcapAn7cZHRh9OKrOO8rIDXr2g5GiJkwdqtMwnPe6nQFSR9g1r5zOsFl6IWZvDydiTYpabl7qg9HrKujjA6WrIFmw2qBJ1SlrG5+P9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286355; c=relaxed/simple;
	bh=rbapMPIfIl4JAW7Oq+iWIdZmzyy9H7c7QWXKQCAWlsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYIijtEJXa95EI3va5OjIiOpS7fP1hcY4/y8L429+vAiZi8Mf919A+EKymxROUnSIBzj9w+RyekZcmhPkjmjFA4Bff9zg2DnByaM1T7VSw+6opEpBwNGwcdt+PsTPIrOmTyfBokKzdNOJ0eBtvKCqmDPYI3qGSvBMb/Rh/Oy/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=R79BG7cQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qrpc2aBS; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="R79BG7cQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qrpc2aBS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 7EC39EC15F9;
	Mon, 27 Apr 2026 06:39:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 06:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777286352;
	 x=1777372752; bh=C2VHadjbjHlVx9t0S5GzEu/bqAdhtwOjL172S8thqt8=; b=
	R79BG7cQy6JMUspDNzHbcbLTeki3otTzhoVmntyRWeDF2mTQWKLqUd54IaCV7SgU
	WJvtBJ/8SkShLUHGGNma3w20RwIejEBeKFPffIK439v2mTPRCmw6duNmTJHwOdYj
	NHl13ys+Q2yEQ9SxArGqsQ1PEqoPdO//chz8DsqclDtW+tTbykYhFmexYOnp8P0Y
	HTX6Pxlo8cb8X5rPl0eVtfGDiPySko+57zRWj21b6X54a1wYuWuPtCD+xMg79Z+O
	fozCtDCQbnqIx87FWG4CTY+ALJ2nZP3qbw3rS8lWvVpdcT2BihxvdSjGdgNuW8Wo
	HnRmXo7lp4t3G7PUSmtUJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777286352; x=
	1777372752; bh=C2VHadjbjHlVx9t0S5GzEu/bqAdhtwOjL172S8thqt8=; b=Q
	rpc2aBSsa30xYjTWZLUpNUNfzGzHk0yH4oRNGIPQzvYW5WrCOZd637gAn8uew6IG
	qHdYUTgoMET3iQ2sRBF4etdln6Kdymx5FWsnH5JE2vZbSOQtJNH6fA5PL7SW2tUF
	YArPBvuil70Vw+vSawJIj7ADVNb+LdoKhWzNMZ9faDxzqH3Ew0cuJDKtxvXKhCzP
	SlFCWUJ29RqRJgi0Y98Ja4v4Iger4l9zhJuD+B4xVPmfScosp0Nipq+aES+ErzyA
	QDujG030MxONGh0ddUbIbeYiY8YOPcLQvaGqbR5vnJHMrNpQTN1ogj/8+58IAnWV
	1g9kz5L8DJHh+Dk4kabSw==
X-ME-Sender: <xms:0DzvaXxweFqbOS2YIpvN2LmF1Y8CHf32HX0pPVSm6jSVhTZO511Grg>
    <xme:0DzvaRhRdfPgHoOiw1jvGeaXUd8t-qc3aNi7xHT0YyLrZICu7Lkx00FvyfeQnnzxr
    Zgjj8px0CSZC-0k1NaZgYlzD0pr7d0nzti1vOrnd87XWj1LzsQcjw>
X-ME-Received: <xmr:0DzvaTnzMo1q3KObQlolfdJDyBSaybDQwPv3gKgaU84ojSOog-qeo2bE3Khjf-oyfno28CoxmrIS0dRuwK7jf3c-u4Lvvbr4Q0mdASs97cI_9x_PUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeegjecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:0DzvaXgzchp6sE7UNqBY_lU3VcrxJPB5TDckr7LHot81c5Owrtm_GA>
    <xmx:0DzvaX2OMqeDTlOueLvpntkCMrxzXNTr8bqFpIE1ajy95dxFmlTlgg>
    <xmx:0DzvaQJZFLC0qmoha8DoEtfz2ifANX_Q7CoHFuhqupYLryXbhbWsYw>
    <xmx:0DzvaXwNVH6qXbyOVL6Bw_HloYDaThDFWdr5flyTslantireF--tdQ>
    <xmx:0DzvaSmf5BOHiJbmpNInCQfJwadCCg0TDuNICV0RikTEY4sBV02vX-2W>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 06:39:11 -0400 (EDT)
Message-ID: <841645f0-60b4-48bb-b213-be0421c0ae80@bsbernd.com>
Date: Mon, 27 Apr 2026 12:39:09 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/8] fuse: {io-uring} Use bitmaps to track registered
 queues
To: Luis Henriques <luis@igalia.com>
Cc: Bernd Schubert via B4 Relay <devnull+bernd.bsbernd.com@kernel.org>,
 Miklos Szeredi <miklos@szeredi.hu>, Joanne Koong <joannelkoong@gmail.com>,
 linux-fsdevel@vger.kernel.org, Gang He <dchg2000@gmail.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-3-982b6414b723@bsbernd.com>
 <874il0o0wi.fsf@igalia.com>
 <859fb89e-81b3-4b49-bd80-532bc7be1395@bsbernd.com>
 <87v7dckezl.fsf@igalia.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <87v7dckezl.fsf@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/27/26 10:02, Luis Henriques wrote:
> On Fri, Apr 24 2026, Bernd Schubert wrote:
> 
>> On 4/24/26 17:04, Luis Henriques wrote:
>>> On Mon, Apr 13 2026, Bernd Schubert via B4 Relay wrote:
>>>
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>
>>>> Add per-CPU and per-NUMA node bitmasks to track which
>>>> io-uring queues are registered.
>>>>
>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>> ---
>>>>  fs/fuse/dev_uring.c   | 73 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>>  fs/fuse/dev_uring_i.h | 20 ++++++++++++++
>>>>  2 files changed, 93 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>> index 08c49e5b65ee950a9749a034b1e9d0a8883e1d31..1d1305d38efa07641128a865aec1745d2e040b93 100644
>>>> --- a/fs/fuse/dev_uring.c
>>>> +++ b/fs/fuse/dev_uring.c
>>>> @@ -186,6 +186,25 @@ bool fuse_uring_request_expired(struct fuse_conn *fc)
>>>>  	return false;
>>>>  }
>>>>  
>>>> +static void fuse_ring_destruct_q_map(struct fuse_queue_map *q_map)
>>>> +{
>>>> +	free_cpumask_var(q_map->registered_q_mask);
>>>> +	kfree(q_map->cpu_to_qid);
>>>> +}
>>>> +
>>>> +static void fuse_uring_destruct_q_masks(struct fuse_ring *ring)
>>>> +{
>>>> +	int node;
>>>> +
>>>> +	fuse_ring_destruct_q_map(&ring->q_map);
>>>> +
>>>> +	if (ring->numa_q_map) {
>>>> +		for (node = 0; node < ring->nr_numa_nodes; node++)
>>>> +			fuse_ring_destruct_q_map(&ring->numa_q_map[node]);
>>>> +		kfree(ring->numa_q_map);
>>>> +	}
>>>> +}
>>>> +
>>>>  void fuse_uring_destruct(struct fuse_conn *fc)
>>>>  {
>>>>  	struct fuse_ring *ring = fc->ring;
>>>> @@ -217,11 +236,44 @@ void fuse_uring_destruct(struct fuse_conn *fc)
>>>>  		ring->queues[qid] = NULL;
>>>>  	}
>>>>  
>>>> +	fuse_uring_destruct_q_masks(ring);
>>>>  	kfree(ring->queues);
>>>>  	kfree(ring);
>>>>  	fc->ring = NULL;
>>>>  }
>>>>  
>>>> +static int fuse_uring_init_q_map(struct fuse_queue_map *q_map, size_t nr_cpu)
>>>> +{
>>>> +	if (!zalloc_cpumask_var(&q_map->registered_q_mask, GFP_KERNEL_ACCOUNT))
>>>> +		return -ENOMEM;
>>>> +
>>>> +	q_map->cpu_to_qid = kzalloc_objs(*q_map->cpu_to_qid, nr_cpu,
>>>> +					 GFP_KERNEL_ACCOUNT);
>>>> +
>>>
>>> Missing NULL check here (and corresponding call to free_cpumask_var()).
>>>
>>>>
>>>> +	return 0;
>>>> +}
>>>> +
>>>> +static int fuse_uring_create_q_masks(struct fuse_ring *ring)
>>>> +{
>>>> +	int err, node;
>>>> +
>>>> +	err = fuse_uring_init_q_map(&ring->q_map, ring->max_nr_queues);
>>>> +	if (err)
>>>> +		return err;
>>>> +
>>>> +	ring->numa_q_map = kzalloc_objs(*ring->numa_q_map, ring->nr_numa_nodes,
>>>> +					GFP_KERNEL_ACCOUNT);
>>>> +	if (!ring->numa_q_map)
>>>> +		return -ENOMEM;
>>>
>>> Missing call to fuse_ring_destruct_q_map().
>>>
>>>> +	for (node = 0; node < ring->nr_numa_nodes; node++) {
>>>> +		err = fuse_uring_init_q_map(&ring->numa_q_map[node],
>>>> +					   ring->max_nr_queues);
>>>> +		if (err)
>>>> +			return err;
>>>
>>> Cleanup also missing here.
>>
>> I don't think so, for either of both, see error handling in
>> fuse_uring_create_q_masks().
> 
> Doh! you're right.  The only fuse_uring_create_q_masks() call site is
> fuse_uring_create(), which will then call fuse_uring_destruct_q_masks() on
> error.  Sorry for the noise :-/

Hi Luis,

no worries at all and thanks for your review. A bit funny part, I had
let AI check the code and it also first reported a leak :)
The reason that the caller cleans it it up is that if any of the
allocations fails, all the other masks have to freed as well.

Thanks,
Bernd
