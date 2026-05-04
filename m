Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513FE33121D
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 08:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883153; cv=none; b=R4EQssDQ986rFVNdyLrDBYNv/2TTK3w80RC/1lP6/S/TXhZhWwDGswetlpAikbH/0/9yXTL2pa7VsG7u/Muo3y+SsPVI2khgtwgBd9qN6nri3AF3HQ7nLf2Y4Gx667XAHs8rVoXBNlMtCmchy5hBzhTwPe9sUZ2kuhj3qkg62FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883153; c=relaxed/simple;
	bh=EoSMGZ8BHuo2iYsT5CSwekAK8hSWVeoWPfOgzslGAZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AjSHdkNkS+D4C4UBe9UEObrQmrT198UpmEAcvnAa4gPpBdQ2VL12HE69JeL2297lR8BfgXkTT3Xtp33GdYqmBr5uBfpTeJpSW+ZmYBKJJPQnoKBxMKSdy0kQxMb1tQ7tUIUYknWPtUdwnUaYLqUfkYf4cpwR474lTatAH4wbSO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=BQ2YFozO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nz+Wri1z; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="BQ2YFozO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nz+Wri1z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1CEE81D000CA;
	Mon,  4 May 2026 04:25:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 May 2026 04:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777883146;
	 x=1777969546; bh=4RClhYkzNtn3Uga/Wv0ISUuXXB/2BGhyIMcXqbL/5IE=; b=
	BQ2YFozOOK28q9k6MohS+Uk/ztkoqp6T4FaUdP2QEeH8zQiuH9j+owDiXEQGVoEL
	BVoSyQb44GwRNrTM3oodoCgSf52Kw8FMmeL/3iupYjd+n7Dj2AEsj3aQ04L+dQHi
	sU0svNoTw21pkWQ/qV8C2vj9Q+P/OzZh5F9Va0WLv+4D6S0rOFoh5x2PGtS5ELh+
	TFRbQSdgXn3DCAvZDxMjk+qTaFGGCdmokoSPHVztDouJ7dQS46L6Z0xPeqseBZAe
	2xLLAR9vcT3EoXFaYr0k1YUhtyYXYgLBafGmDTH8pHdcVFe7vldqbC672tdP73g5
	BUAU0/J7i/47roUMOuQiUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777883146; x=
	1777969546; bh=4RClhYkzNtn3Uga/Wv0ISUuXXB/2BGhyIMcXqbL/5IE=; b=n
	z+Wri1zMrsQAw3qiADVO39WM5A23un+wm2Az3YVVQlgG0RsajRcWB6xuTFtKwFiK
	YnqsJN6RS1BwrN6r4En21exHlQlPjsMiHvudVm4zt7LF5h3thrqKd/Nq7TADrsA+
	dDjjocPrN5tb13V1ueDuu+rsj1+efDDoGIj+yIZV5qmiC5E7/7edQtT5AQPLkV5t
	SrsppBL9hNph/jnCbQv4gwASUxcMJtkfjRFneD5Zi/dtVay3yg6HBQ0Lk2VCds0Y
	dSsZOcQdFw6dLlj7MiI5PT7RqW7p0RtkqTSd5B7GX+LLRRPijJf1T2S8QqwIuhBg
	83muaN+R+SumMYSiLNS4g==
X-ME-Sender: <xms:Clj4aeWYYMRLdp96RlcQKXv4f3bnQD3ga5Yf94o-QrlwToGYHxhxoQ>
    <xme:Clj4aeQYDOezHNjRZEEeT0m7rKseNjpsolMnR-ARlX5SuaZ8mzjYFAUa1-LAqbJoR
    OcYb2mTIxV089C9xdRFdzXTB30U09lUSrvnDWDcuK8YCmBWbSqy>
X-ME-Received: <xmr:Clj4acPLdjFYVbO-PlDfXZ28nl2-3ev50GGFxtQjNh680g58j-gmmyZ-29TxVEzyzOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelkeefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepsggvrhhnugessghssggvrhhnugdrtghomhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehluhhishesihhgrghl
    ihgrrdgtohhmpdhrtghpthhtohepuggthhhgvddttddtsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Clj4acRjV6AXDNa_RtpbBINeEpuau0QYlLi9z34hBhhXGoINmWHYnA>
    <xmx:Clj4aahh_R8Mf4Fk6C-xR5EpmbYUTRevEPt-bE0exWKqAivZ8v8wqA>
    <xmx:Clj4aV-jr4rlrZa6nWgI2HUqyVt5l0-fXkFwBdglW3ur_8Fj0Kdh5A>
    <xmx:Clj4aRFgLOWUxBYGnV8lSdqe32fXQk4GqbqptQJ-yowLWAy8Lv5bkg>
    <xmx:Clj4aVjkHKJhfnqzWxsCbm6a0K7Z-zWKzXEIj6-qhUJ2HuujIusuMzc6>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 May 2026 04:25:44 -0400 (EDT)
Message-ID: <34e56fec-e5ca-4138-bb2b-c0ab1515a504@bsbernd.com>
Date: Mon, 4 May 2026 10:25:41 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] fuse: {io-uring} Allow reduced number of ring
 queues
To: Joanne Koong <joannelkoong@gmail.com>
Cc: "bernd@bsbernd.com" <bernd@bsbernd.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
 <CAJnrk1aL7xW1Z+=ns=zaOtjcUvOZMRR9icz72B9Ye7d0jYgDeQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1aL7xW1Z+=ns=zaOtjcUvOZMRR9icz72B9Ye7d0jYgDeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/27/26 15:10, Joanne Koong wrote:
> On Fri, Apr 24, 2026 at 11:01 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>> On 4/24/26 20:28, Joanne Koong wrote:
>>> On Mon, Apr 13, 2026 at 2:41 AM Bernd Schubert via B4 Relay
>>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>>>
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>
>>>> Queues selection (fuse_uring_get_queue) can handle reduced number
>>>> queues - using io-uring is possible now even with a single
>>>> queue and entry.
>>>>
>>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
>>>> reduced queues are possible, i.e. if the flag is set, fuse server
>>>> is free to reduce number queues.
>>>>
>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>> ---
>>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------------
>>>>  fs/fuse/inode.c           |   2 +-
>>>>  include/uapi/linux/fuse.h |   3 +
>>>>  3 files changed, 88 insertions(+), 77 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e605c6e36a137f9e 100644
>>>> --- a/fs/fuse/dev_uring.c
>>>> +++ b/fs/fuse/dev_uring.c
>>>>
>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
>>>>  {
>>>>         unsigned int qid;
>>>> -       struct fuse_ring_queue *queue;
>>>> +       int node;
>>>> +       unsigned int nr_queues;
>>>> +       unsigned int cpu = task_cpu(current);
>>>>
>>>> -       qid = task_cpu(current);
>>>> +       cpu = cpu % ring->max_nr_queues;
>>>>
>>>> -       if (WARN_ONCE(qid >= ring->max_nr_queues,
>>>> -                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
>>>> -                     ring->max_nr_queues))
>>>> -               qid = 0;
>>>> +       /* numa local registered queue bitmap */
>>>> +       node = cpu_to_node(cpu);
>>>> +       if (WARN_ONCE(node >= ring->nr_numa_nodes,
>>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
>>>> +                     node, ring->nr_numa_nodes)) {
>>>> +               node = 0;
>>>> +       }
>>>>
>>>> -       queue = ring->queues[qid];
>>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
>>>> +       nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
>>>> +       if (nr_queues) {
>>>> +               qid = ring->numa_q_map[node].cpu_to_qid[cpu];
>>>> +               if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>>>> +                       return NULL;
>>>> +               return READ_ONCE(ring->queues[qid]);
>>>> +       }
>>>
>>> Hi Bernd,
>>>
>>> Thanks for making the changes on this - I really like how much simpler
>>> the logic is now.
>>>
>>> I'm looking through how the block multiqueue code works
>>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
>>> basically have to do the same thing with figuring out which cpu to
>>> dispatch a request to.
>>>
>>> It looks like what they do is use group_cpus_evenly(), which as I
>>> understand it, will partition CPUs taking into account numa nodes (as
>>> well as clustering and SMT siblings). I think if we use this for fuse
>>> io-uring, it will make things a lot simpler and we could get rid of
>>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
>>> nr_numa_nodes)  and simplify queue selection where now that can just
>>> be a cpu to qid lookup instead of a two-level
>>> numa-then-global-fallback lookup.
>>>
>>> Do you think something like this makes sense?
>>
>> Maybe, I need to check that code. However, does this really need to be
>> done right now? This cannot be updated later? For me it looks a bit like
>> we are going to replace one code by another, without a clear advantage.
>> I can look into group_cpus_evenly(), but I cannot promise you when that
>> will happen.
>> My personal preference would be to work on real issue, like getting rid
>> of two locks (queue->lock and bg->lock) and distribute max_bg accross
>> queues. And that probably requires the distribution across queues, which
>> you didn't like in the previous series. Anway, already finding the time
>> for that is hard.
> 
> Ok, we should go with what you have then and I'll submit changes as a
> separate patch.

I quickly looked into on Satturday and I'm curious if this will be so
much simpler with the follow up patches that go into different queues.
With this current patch that just does a static mapping, yes,
group_cpus_evenly() would be simpler. With the follow up patches that
schedule to other queues, not sure. At minimum we need a nother map. At
best group_cpus_evenly() could be improved or a new generic API invented
that would simplify finding other queues. Virtiofs also might benefit
from that, but is outside of the target of this series.


Thanks,
Bernd
