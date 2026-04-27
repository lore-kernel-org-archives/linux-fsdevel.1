Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDEF314D26
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 14:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300965; cv=none; b=mV3ZBNB2OjXuWRYGK4L4wnWzlXLN/ZtUjmAEryyg60m+J8Vp5tGsMjVZzBa89BqHog7Kv81/4qYFZ6cXPNssx+gSRmi7IxRKHEEAY9wQGkbnDHyQLqq8pmo/Vz8DfDJboNC9AEsPPuIZkLKNMFXughHSHqjD4u2TG3ojXgPnI4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300965; c=relaxed/simple;
	bh=pvIo6hOAjV6offkkg8aKHsEBxUguf+foRJ64GmHShRw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6AiTYc/N8vWDPNXuplp3im4hrMvhF8e6mTzih0KVeaLnJ0vxv2LAnJ6koQnK0MhQxBi5qYQahb7t/uZdUGFzFHBOkK8WGyjtOykV9KpVxiiIpoKJcPvOaxtFmKhJIiHd+/925W84g32Ujfu/gk8gCV4unq7dtI3L10XCKw3e3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=Knmdc8ur; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pgZmbg6M; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="Knmdc8ur";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pgZmbg6M"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E5B2140008B;
	Mon, 27 Apr 2026 10:42:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 27 Apr 2026 10:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777300962;
	 x=1777387362; bh=l5o2oQE4bSU2U3LlXPyyeVAXS+3h6XnJoAZvXLHalcg=; b=
	Knmdc8urJ+Cn2UTlDVGzTeFqiM8E2tZzEcl7FZVGquRhaO0CAhf0I6Dw4EmKOAEw
	njU4z1CvuoU73YeJGWhzXC1EYiEdvZP9KnJuvLOMU0IMEXAcML5JuvkW54mmGAJS
	d0xNGsc29LJmRBxg5P3UpH2hyllW21I7lV8fo5hiBuCCilkafdYSlMnknwWMTcqi
	7E2gQIklVIn2rYncI54HReCTPbRhvm+WHjGMkTh2ltVbHww7cQtpinAyFdUi6Q9j
	2hytQKZP4QPC/dEyvHsEwB2d3zssFZS5eJBLBXbSp04FztpzDe5BNqUTh6ka6U76
	MlU8aPcJZ7y8MKIgczvKQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777300962; x=
	1777387362; bh=l5o2oQE4bSU2U3LlXPyyeVAXS+3h6XnJoAZvXLHalcg=; b=p
	gZmbg6MCce/oIrAOOajmtIATqHx5pi9qminDQqVzO3lwaX5yZELfk9fqG105m2kC
	nY5CEPySOgDAKtY86pRZPliKzq4lDiKcdgsB6t6hsxFrz/XqsqIntfuTVP2uWdcM
	PiLJoJWx0ka47zGP19pKdxlVcN4WHXVHu8CvWTT4fa9DjpJpmoMakjX7O7LInzgo
	QSMfoTkIUWHE/HJotBuAPI6i4+BijELX/Q/17udYU4p4UCXJWY6lbMVaCxS9bIMA
	bVx69SEkUYpIMEG6H7dWqrN7ykbno+cUW4/wzRyKqWpGHzIlhTsP9nqpbKib1bfX
	lbzKJGW3wQ7C5+gAzdcvw==
X-ME-Sender: <xms:4nXvaQ_7q2uLFT4Lsgc26MA4ZiaN41XetvTYOXpBmCywyABuuD-LyA>
    <xme:4nXvaflFyurTKPEXrJ4HiW-y6SYK7CL8-qlFWCPHo-8InJE7LZLuhEg304C6GiHuS
    GBSwoEyVZB9Jz0IOosahlwTdp18le3dR9fQnwHRDqkCzgmvAa4>
X-ME-Received: <xmr:4nXvaeUTnMXujklbxB9C8017EeOulSjkzF-7VL5sAuhaaI0lrcn5swOCHFDM_KJsnf6GnVkzHlTsfvDXFLrAuruUpK36rCi6Q2Oe4gZRIZdtRkSmXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejkeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehl
    ihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    eplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtthhopegutghhghdvtddttdesghhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:4nXvacFgEdAFJWkn23VPSPOThoh9YB-bRqT9rV7dl3esPsLCYr3mLw>
    <xmx:4nXvaSdVVfmDLwG0tYBx4HyIld5f_5zsLPJwkhBuLSgxJCQ1IJvGZw>
    <xmx:4nXvaVKlxin-56NJfyOTyotYTaARjXX2RKVsFlajbeeKfh7-6SHtfA>
    <xmx:4nXvafFX7RvSSx0LfvkO17HPVmYgxo-0B2sFryfUmbFEUx6QVRp_Cg>
    <xmx:4nXvadGH2jBXw1-qE5aoJSdTd-OlcINiEM11ZRvBgTnYQyoP0tJiah-T>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Apr 2026 10:42:41 -0400 (EDT)
Message-ID: <981c9f40-5555-4f3c-89c0-cd120c6fc768@bsbernd.com>
Date: Mon, 27 Apr 2026 16:42:40 +0200
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
Cc: Miklos Szeredi <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-5-982b6414b723@bsbernd.com>
 <CAJnrk1aYYSVU-AdxRoqC5H8xk+4rt9Tf=3BPphsw4vvNxjpEyA@mail.gmail.com>
 <b7e93b2a-7096-4957-bf75-38e096a9dd3e@ddn.com>
 <CAJnrk1aL7xW1Z+=ns=zaOtjcUvOZMRR9icz72B9Ye7d0jYgDeQ@mail.gmail.com>
 <e5a181d4-635f-4b91-b49a-e8d34b16f495@bsbernd.com>
 <CAJnrk1Z1HgPXLzfcKMhOKjdZzcjuXbRH4de+4zQpoqvhSB=A-g@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1Z1HgPXLzfcKMhOKjdZzcjuXbRH4de+4zQpoqvhSB=A-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/27/26 16:10, Joanne Koong wrote:
> On Mon, Apr 27, 2026 at 2:49 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 4/27/26 15:10, Joanne Koong wrote:
>>> On Fri, Apr 24, 2026 at 11:01 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>>>
>>>> On 4/24/26 20:28, Joanne Koong wrote:
>>>>> On Mon, Apr 13, 2026 at 2:41 AM Bernd Schubert via B4 Relay
>>>>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>>>>>
>>>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>>>
>>>>>> Queues selection (fuse_uring_get_queue) can handle reduced number
>>>>>> queues - using io-uring is possible now even with a single
>>>>>> queue and entry.
>>>>>>
>>>>>> The FUSE_URING_REDUCED_Q flag is being introduce tell fuse server that
>>>>>> reduced queues are possible, i.e. if the flag is set, fuse server
>>>>>> is free to reduce number queues.
>>>>>>
>>>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>>>> ---
>>>>>>  fs/fuse/dev_uring.c       | 160 ++++++++++++++++++++++++----------------------
>>>>>>  fs/fuse/inode.c           |   2 +-
>>>>>>  include/uapi/linux/fuse.h |   3 +
>>>>>>  3 files changed, 88 insertions(+), 77 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>>>> index 9dcbc39531f0e019e5abf58a29cdf6c75fafdca1..e68089babaf89fb81741e4a5e605c6e36a137f9e 100644
>>>>>> --- a/fs/fuse/dev_uring.c
>>>>>> +++ b/fs/fuse/dev_uring.c
>>>>>>
>>>>>> -static struct fuse_ring_queue *fuse_uring_task_to_queue(struct fuse_ring *ring)
>>>>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
>>>>>>  {
>>>>>>         unsigned int qid;
>>>>>> -       struct fuse_ring_queue *queue;
>>>>>> +       int node;
>>>>>> +       unsigned int nr_queues;
>>>>>> +       unsigned int cpu = task_cpu(current);
>>>>>>
>>>>>> -       qid = task_cpu(current);
>>>>>> +       cpu = cpu % ring->max_nr_queues;
>>>>>>
>>>>>> -       if (WARN_ONCE(qid >= ring->max_nr_queues,
>>>>>> -                     "Core number (%u) exceeds nr queues (%zu)\n", qid,
>>>>>> -                     ring->max_nr_queues))
>>>>>> -               qid = 0;
>>>>>> +       /* numa local registered queue bitmap */
>>>>>> +       node = cpu_to_node(cpu);
>>>>>> +       if (WARN_ONCE(node >= ring->nr_numa_nodes,
>>>>>> +                     "Node number (%d) exceeds nr nodes (%d)\n",
>>>>>> +                     node, ring->nr_numa_nodes)) {
>>>>>> +               node = 0;
>>>>>> +       }
>>>>>>
>>>>>> -       queue = ring->queues[qid];
>>>>>> -       WARN_ONCE(!queue, "Missing queue for qid %d\n", qid);
>>>>>> +       nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
>>>>>> +       if (nr_queues) {
>>>>>> +               qid = ring->numa_q_map[node].cpu_to_qid[cpu];
>>>>>> +               if (WARN_ON_ONCE(qid >= ring->max_nr_queues))
>>>>>> +                       return NULL;
>>>>>> +               return READ_ONCE(ring->queues[qid]);
>>>>>> +       }
>>>>>
>>>>> Hi Bernd,
>>>>>
>>>>> Thanks for making the changes on this - I really like how much simpler
>>>>> the logic is now.
>>>>>
>>>>> I'm looking through how the block multiqueue code works
>>>>> (block/blk-mq.c and block/blk-mq-cpumap.c) because I think they
>>>>> basically have to do the same thing with figuring out which cpu to
>>>>> dispatch a request to.
>>>>>
>>>>> It looks like what they do is use group_cpus_evenly(), which as I
>>>>> understand it, will partition CPUs taking into account numa nodes (as
>>>>> well as clustering and SMT siblings). I think if we use this for fuse
>>>>> io-uring, it will make things a lot simpler and we could get rid of
>>>>> the per-numa state tracking (eg numa_q_map, registered_q_mask,
>>>>> nr_numa_nodes)  and simplify queue selection where now that can just
>>>>> be a cpu to qid lookup instead of a two-level
>>>>> numa-then-global-fallback lookup.
>>>>>
>>>>> Do you think something like this makes sense?
>>>>
>>>> Maybe, I need to check that code. However, does this really need to be
>>>> done right now? This cannot be updated later? For me it looks a bit like
>>>> we are going to replace one code by another, without a clear advantage.
>>>> I can look into group_cpus_evenly(), but I cannot promise you when that
>>>> will happen.
>>>> My personal preference would be to work on real issue, like getting rid
>>>> of two locks (queue->lock and bg->lock) and distribute max_bg accross
>>>> queues. And that probably requires the distribution across queues, which
>>>> you didn't like in the previous series. Anway, already finding the time
>>>> for that is hard.
>>>
>>> Ok, we should go with what you have then and I'll submit changes as a
>>> separate patch.
>>>
>>>>
>>>> My personal opinion is that queue selection needs to return the qid, so
>>>> that the function can be overriden with eBPF. I didn't have time yet to
>>>> try that out.
>>>>
>>>>>
>>>>> Additionally, as I understand it, in this series, the ring->q_map
>>>>> mapping has to get rebuilt every time a new queue gets created. What
>>>>> do you think about just having the server declare the total queue
>>>>> count upfront and then the mapping can just get established at ring
>>>>> creation time? group_cpus_evenly() would only need to be called once,
>>>>> the cpu_to_qid map would only have to be built once, and we could
>>>>> avoid the rebuild-on-each-queue-creation complexity entirely. Do you
>>>>> think something like this makes sense?
>>>>
>>>> That is why I said in another mail that a config SQE would make to some
>>>> extend sense. However, the part where I disagree is that we could make
>>>> it all entirely dynamic with the current approach.
>>>> Only the logic for that in libfuse is missing. I.e. it _could_ start
>>>> with a single queue or one queue per numa and one ring entry. Basically
>>>> no memory usage then.
>>>> And now libfuse could add logic - many small requests - set up ring
>>>> entries with smaller payload size (or smaller pBuf). Many large requests
>>>> - add more requests with larger payload size. And with the current
>>>> approach queues can be added dynamically.
>>>
>>> For registered buffers and zero copy, the queue count is needed up
>>> front at registration time. imo it would be nice to have the
>>> registration interface for these things be cohesive. Dynamic queues
>>> could still be added in the future (eg server sends a new uring cmd to
>>> add a queue, kernel rebuilds mapping, etc).
>>
>> And that cannot be _max_ number of queues for registered buffers?
> 
> For registered buffers / zero copy, the buffer is contiguously
> allocated by the server up front, passed to the kernel, and then
> pinned. Our servers want to use registered buffers/zero copy with less
> queues than the number of cpus on the machine.

If the buffer is associated with queue, queues still can be registered
dynamically? I don't say that your should be forced to do dynamic
queues, it is just that the current reduced queue patches allow to have
that. And with pBuf I don't see why it shouldn't work either.

Thanks,
Bernd
