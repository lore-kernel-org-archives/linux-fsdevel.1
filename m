Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2113C3CEB9B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 13:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297783; cv=none; b=iH+kq7y4FNNdCLBxSX1iQJCm4nvJ+4b5V6L1gKivS8xrpr1LfkfZttfnaKlYkiR1x/xCPDaig7gfWoNQWD+lONbEcMsTBCtcA5a2fqvYWN2wC9DkPQWbxqMoJnC2W6vSfb1vlRYHbe1DFb3TeBxViUNRUO9v2wRtZUkMSGKg2g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297783; c=relaxed/simple;
	bh=AjJYeSAG0GnokD/V6W2wnCzTxj7FboCo+x/NUg9vvs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qtNEWfRgUmsekfbONnkVC3VmiaPRbGSOP2AUj3qBuK4wByFCxBP+Sx5sKOhpph1NdZr6DM93MeWuuusRj+NxviTJFiNiq8qRFDIvpLAJOABbLY1jLUxB15xIHEAKx8lP95QItAXID/2hmNikoqir6Y1X1Qnl/QseoOgoQaEXDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=feiafxcZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0KOzmJn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="feiafxcZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0KOzmJn"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 530F7EC1452;
	Mon, 27 Apr 2026 09:49:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 27 Apr 2026 09:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777297780;
	 x=1777384180; bh=lSJ4xvZjU6+qO99lxh8ztaq7kd7ernUCqYATsOwQkqY=; b=
	feiafxcZYwj5ZICUWcMyQ/D7K3+51bat2q6rc+15zSdp+Kzgz9e9AIsOAOkyYUds
	2vdnDxfRlC/QB2a7Gn4Sl7O5eN2UgFNR1SX6daHMTVt1to7qNmS6w7DZghYPqXKH
	3tOFisi2hzoRKlH8WSQXk5hFK7kaICnrTXK/BWhXXDXPiYRqi1gBTnPsAzfvN2P4
	2194d8uyinZWwVVKC771twXSw8R4okHN0ikid+/6vBiTJ0moPw4RVyB8W0mBfNz0
	KPtfp7XkvTjohZ3Ev++12BnwDMBXrDVVsNaDr2jbx5yCBQ/1m67bl5M8ujPAX7vV
	uZOuJZgFMHA5YmUoB1AALQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777297780; x=
	1777384180; bh=lSJ4xvZjU6+qO99lxh8ztaq7kd7ernUCqYATsOwQkqY=; b=t
	0KOzmJnvKpaa/oXEi0kOO5lb6wdB1lSAxRvD12WOK4xhF+TgN7msUtPfX/HybwyK
	f3+NcaYWSbTbN6dWBjXcuObDjq9a6inOMCxq2un5XyEbQ54bloVL86WW5WnasbVU
	s1zBdjOgJPFeD7i9oFi9iL9DtkIhSY7+gj++sU/otdy9Kbn7mSQbe+IQ4wI7QJbJ
	LCdMocL88p1y8Eq5R0zUTBwDfgFlJeWDMRdwKDdMn0WSC3wu0oNby9U7DftUoSn3
	RBt5s0zOWdX9X3PRpZj9Fr8EnMRlbTalRHVKePOcyaTXbKXkJKCWPPEoRJUxuwWH
	t8PFbbsO3zS9UQemyuaIQ==
X-ME-Sender: <xms:c2nvaXlhT53yxUrIplnV3y2sd6p805_An1tbwilhonw6apNjyHsBdA>
    <xme:c2nvaeh3XA1t3SLy1ySXXUjZfwGW2Y5X-N2cigLvUivDjp0s2h8ranxNS8gnLTcJS
    RfhA5LV9cSphYiw7g7cAV-dy5xG_J-kMcnQIZl9PsHBqYcyfTer>
X-ME-Received: <xmr:c2nvaXfYvMYK6tjx1mRzcdei6PFIABOEpxGT63gpctXpIwq-jor717hBWnXXEzSuMjyfaYXulurlxtylrJ1JAVFJ3SgLoDdhzCpX8hONjAtvtHlqsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:c2nvaWiEhOzoHIZ-NWmNpeWlywYoOf39qPCJSpDpMNoeEJX1nS_RTw>
    <xmx:c2nvaXyft2kDFm8vh8bSyRJYSUiB42N1ggR06EWxruYpS2KmXThmWA>
    <xmx:c2nvaaNu-Bm7voTsei11MUA4-gUL4Rl_8hCvKZ-eGR4j_GV-902Pgg>
    <xmx:c2nvaQUEeqiLuxQzC4ilxXOSWPa8ymC4NoxFEhGVW3b5Eos6o28AFw>
    <xmx:dGnvaSwnOHS1GMUSqHNoV5-6M4OyOkgH35P4DhmO4mbtKW-XRqZdl9gV>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 09:49:38 -0400 (EDT)
Message-ID: <e5a181d4-635f-4b91-b49a-e8d34b16f495@bsbernd.com>
Date: Mon, 27 Apr 2026 15:49:37 +0200
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
> 
>>
>> My personal opinion is that queue selection needs to return the qid, so
>> that the function can be overriden with eBPF. I didn't have time yet to
>> try that out.
>>
>>>
>>> Additionally, as I understand it, in this series, the ring->q_map
>>> mapping has to get rebuilt every time a new queue gets created. What
>>> do you think about just having the server declare the total queue
>>> count upfront and then the mapping can just get established at ring
>>> creation time? group_cpus_evenly() would only need to be called once,
>>> the cpu_to_qid map would only have to be built once, and we could
>>> avoid the rebuild-on-each-queue-creation complexity entirely. Do you
>>> think something like this makes sense?
>>
>> That is why I said in another mail that a config SQE would make to some
>> extend sense. However, the part where I disagree is that we could make
>> it all entirely dynamic with the current approach.
>> Only the logic for that in libfuse is missing. I.e. it _could_ start
>> with a single queue or one queue per numa and one ring entry. Basically
>> no memory usage then.
>> And now libfuse could add logic - many small requests - set up ring
>> entries with smaller payload size (or smaller pBuf). Many large requests
>> - add more requests with larger payload size. And with the current
>> approach queues can be added dynamically.
> 
> For registered buffers and zero copy, the queue count is needed up
> front at registration time. imo it would be nice to have the
> registration interface for these things be cohesive. Dynamic queues
> could still be added in the future (eg server sends a new uring cmd to
> add a queue, kernel rebuilds mapping, etc).

And that cannot be _max_ number of queues for registered buffers?

Thanks,
Bernd
