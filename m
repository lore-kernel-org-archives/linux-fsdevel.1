Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A1538758F
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493947; cv=none; b=OKADjh5RIukwiYG1HJVKd2KgqpeIw2i4xQFT/zF+OaoExoSTJv6cBiDGC06rfR3vUY6bLVJvwSgPMfMelrKC93EC0dGl5B4seDTel8ytu7L26PIdlrkXP3ngROu2K9XI7x5XuqsZiJN1SUMkw8vC36RsBXvO5XNHNhRMLVbQ7EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493947; c=relaxed/simple;
	bh=keFjrK36DTK0rFuYciJckEHqLXHV5Ql58PbY+9b3u8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6vuZYt9wpUTTaagMzwHNkhJLVHynVl2wq5iSTGoTKvRumwZFjtyRTkxR8hUni2fuzc/36lesn5v7AO1ODQKvP9AjebQ7ssv1ff+Yrz5xg1MDMC5dVGCGLMzjVsw0eBXCPyQh0o0k0I2kOhuSdTtX2mdmtbbgzLB4RkyRSAQXqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=aJTndrPs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eKRXND/x; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="aJTndrPs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eKRXND/x"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D87A71400090;
	Wed, 29 Apr 2026 16:19:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 29 Apr 2026 16:19:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777493943;
	 x=1777580343; bh=DS7zNKAUGLavCp/P3rOQZwK9/P0DaUXG5vNIhDM95CA=; b=
	aJTndrPs2aRxl+DIkwkkS4f+vjoklSgNA97715uR/nMlPIPU24kRJl7OHWM1ZlkQ
	nq/eyAaBqupb1gsH2jlmQ2E3+89+3kIltkxRCNkUznfN2cfDwZAKNLIh6SoHP4WB
	fmwua1CK6+M2+soaQx7yVHEM2L2yk+upguBSKlW7StmjIvIhhWwZ8UKU/pkzJiFX
	8FWmVQ96wdOGI0f/KHcc4Y90kDLSMuAXAApqknTzRoyqYNGuA6AGZeUQtNUFEE0S
	YVwgk9lylSZbmGowOfG+swR4P73tExx2Aerrh+xuWRAyA7QPrmHntozqPiahy5Vd
	/SCJbSzZsPSPnQAovZzhuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777493943; x=
	1777580343; bh=DS7zNKAUGLavCp/P3rOQZwK9/P0DaUXG5vNIhDM95CA=; b=e
	KRXND/x0PVKYrEfPOmgkMmsAhHZ1/CZFv0g7y1Y5ZtOQH5ZX9Nu4vsmnWszqeuGm
	svFF2Uf1JH1acWkbMkMFcxoJIhqPWRvKzsAy8t+hdz8XFqxg22+mmOVtC1h36sYy
	UTcLseFkVgrpoSTYE8gAfvey/iJ9/sbVZOTbYUqDA0Nu4vaUfdwqELKQqvqSv3fj
	fPpXU1YIf1T7PERAC48ZwlnqNXn9CERWixWneiO72rGH1CPQxSSsX7OyVnMms0sz
	4qJgY87gdM/l7r+nrBnkMqfiULOas9yicvzSyI7gvKDfo/eKaOvhJUc2mTTowT+U
	fZN5+VRJ5GJVASvLiuoqQ==
X-ME-Sender: <xms:tmfyaSJ26RFCBssHGMwlZ6RBnVxNzMZcgsJfkyWPbgYdaBWNgdSAoA>
    <xme:tmfyad0ZU7v1D--gA9lGBBKCv4GN47xMgry8IPfKS0PYXa0rE3BLiiQwxcMTyX1t6
    -9v-cn_MtEWixX4tOhmrM3rdzeo6Ori_xWiooAutiKSL-hqpTX6>
X-ME-Received: <xmr:tmfyacjrHTL-su-HfWKYAIo2Nx9EePVlP9M1SD7OpuDC0EW_WHuxTi7JMUOnycWogWJN3uuCDibCbiPvA_U1lQPcuWCa3hz94v4uz1lHLd58Y-Owug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekheefkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepjeffuddtgefhfffggfejheetjeeukeeiteeiheevheetueeigfeiueelkeej
    keeunecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtohhm
    pdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjoh
    grnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopegsshgthhhusggv
    rhhtseguughnrdgtohhmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuh
    dprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheplhhuihhssehighgrlhhirgdrtghomhdprhgtphhtthhopegutg
    hhghdvtddttdesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:tmfyaeWD4OjCKldDVu8RXxwHMhC6CIz5V_7Nb72nFgYcf40VrO_6TA>
    <xmx:tmfyabW1qXER1IJ0Qr9aSX5G4xOC9DyqQaiPgABhJAJVwfr1km397g>
    <xmx:tmfyaegaj-ammoffgl7IHFEyyff7waJQDKyLqe-qlL14u4XJmMU6nw>
    <xmx:tmfyaWZbA8m9_zjBMLcIogrhn0een9eFNGCjgaiUT1mHAu_-Kd3XyQ>
    <xmx:t2fyaTC-4uNgHlsesvvOFcyabPjhpxVuqzwIlZDA5pwdLcFS3GqCdg-_>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 16:19:01 -0400 (EDT)
Message-ID: <872b2673-c37b-4717-902b-853b073f5726@bsbernd.com>
Date: Wed, 29 Apr 2026 22:19:00 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/8] fuse: {io-uring} Queue background requests on a
 different core
To: Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
 <20260413-reduced-nr-ring-queues_3-v4-6-982b6414b723@bsbernd.com>
 <CAJnrk1ZBFkQSE1XGvM0zuVpiMVpCvh7W8nrbsbFRt2Upt-KAAg@mail.gmail.com>
 <f3031d36-0f58-432b-8494-7cf6b1762925@ddn.com>
 <CAJnrk1Z27=vrW4tC6czXP3T2TSV3aQ06Agp=xQvbmvJ41nrCug@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1Z27=vrW4tC6czXP3T2TSV3aQ06Agp=xQvbmvJ41nrCug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/29/26 18:56, Joanne Koong wrote:
> On Wed, Apr 29, 2026 at 5:01 PM Bernd Schubert <bschubert@ddn.com> wrote:
>>
>>
>> On 4/29/26 16:43, Joanne Koong wrote:
>>> On Mon, Apr 13, 2026 at 10:41 AM Bernd Schubert via B4 Relay
>>> <devnull+bernd.bsbernd.com@kernel.org> wrote:
>>>>
>>>> From: Bernd Schubert <bschubert@ddn.com>
>>>>
>>>> Running background IO on a different core makes quite a difference.
>>>>
>>>> fio --directory=/tmp/dest --name=iops.\$jobnum --rw=randread \
>>>> --bs=4k --size=1G --numjobs=1 --iodepth=4 --time_based\
>>>> --runtime=30s --group_reporting --ioengine=io_uring\
>>>>  --direct=1
>>>>
>>>> unpatched
>>>>    READ: bw=272MiB/s (285MB/s) ...
>>>> patched
>>>>    READ: bw=650MiB/s (682MB/s)
>>>>
>>>> Reason is easily visible, the fio process is migrating between CPUs
>>>> when requests are submitted on the queue for the same core.
>>>>
>>>> With --iodepth=8
>>>>
>>>> unpatched
>>>>    READ: bw=466MiB/s (489MB/s)
>>>> patched
>>>>    READ: bw=641MiB/s (672MB/s)
>>>>
>>>> Without io-uring (--iodepth=8)
>>>>    READ: bw=729MiB/s (764MB/s)
>>>>
>>>> Without fuse (--iodepth=8)
>>>>    READ: bw=2199MiB/s (2306MB/s)
>>>>
>>>> (Test were done with
>>>> <libfuse>/example/passthrough_hp -o allow_other --nopassthrough  \
>>>> [-o io_uring] /tmp/source /tmp/dest
>>>> )
>>>>
>>>> Additional notes:
>>>>
>>>> With FURING_NEXT_QUEUE_RETRIES=0 (--iodepth=8)
>>>>    READ: bw=903MiB/s (946MB/s)
>>>>
>>>> With just a random qid (--iodepth=8)
>>>>    READ: bw=429MiB/s (450MB/s)
>>>>
>>>> With --iodepth=1
>>>> unpatched
>>>>    READ: bw=195MiB/s (204MB/s)
>>>> patched
>>>>    READ: bw=232MiB/s (243MB/s)
>>>>
>>>> With --iodepth=1 --numjobs=2
>>>> unpatched
>>>>    READ: bw=366MiB/s (384MB/s)
>>>> patched
>>>>    READ: bw=472MiB/s (495MB/s)
>>>>
>>>> With --iodepth=1 --numjobs=8
>>>> unpatched
>>>>    READ: bw=1437MiB/s (1507MB/s)
>>>> patched
>>>>    READ: bw=1529MiB/s (1603MB/s)
>>>> fuse without io-uring
>>>>    READ: bw=1314MiB/s (1378MB/s), 1314MiB/s-1314MiB/s ...
>>>> no-fuse
>>>>    READ: bw=2566MiB/s (2690MB/s), 2566MiB/s-2566MiB/s ...
>>>>
>>>> In summary, for async requests the core doing application IO is busy
>>>> sending requests and processing IOs should be done on a different core.
>>>> Spreading the load on random cores is also not desirable, as the core
>>>> might be frequency scaled down and/or in C1 sleep states. Not shown here,
>>>> but differnces are much smaller when the system uses performance govenor
>>>> instead of schedutil (ubuntu default). Obviously at the cost of higher
>>>> system power consumption for performance govenor - not desirable either.
>>>>
>>>> Results without io-uring (which uses fixed libfuse threads per queue)
>>>> heavily depend on the current number of active threads. Libfuse uses
>>>> default of max 10 threads, but actual nr max threads is a parameter.
>>>> Also, no-fuse-io-uring results heavily depend on, if there was already
>>>> running another workload before, as libfuse starts these threads
>>>> dynamically - i.e. the more threads are active, the worse the
>>>> performance.
>>>>
>>>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>>>> ---
>>>>  fs/fuse/dev_uring.c | 14 +++++++++++---
>>>>  1 file changed, 11 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>>> index e68089babaf89fb81741e4a5e605c6e36a137f9e..ed061e239b8ed70ff36deb51dd6957fe1704ec87 100644
>>>> --- a/fs/fuse/dev_uring.c
>>>> +++ b/fs/fuse/dev_uring.c
>>>> @@ -1306,13 +1306,21 @@ static void fuse_uring_send_in_task(struct io_tw_req tw_req, io_tw_token_t tw)
>>>>         fuse_uring_send(ent, cmd, err, issue_flags);
>>>>  }
>>>>
>>>> -static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring)
>>>> +static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>>> +                                                      bool background)
>>>>  {
>>>>         unsigned int qid;
>>>>         int node;
>>>>         unsigned int nr_queues;
>>>>         unsigned int cpu = task_cpu(current);
>>>>
>>>> +       /*
>>>> +        *  Background requests result in better performance on a different
>>>> +        *  CPU, unless CPUs are already busy.
>>>> +        */
>>>> +       if (background)
>>>> +               cpu++;
>>>> +
>>
>> Thanks a lot for your reviews!
>>
>> Ah yes, I think the fix is straight forward, by only getting the
>> numa node once on entering the function.
>>
>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>> index 44e1b795a636..dbccaa0971c9 100644
>> --- a/fs/fuse/dev_uring.c
>> +++ b/fs/fuse/dev_uring.c
>> @@ -1321,6 +1321,14 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>         unsigned int cpu = task_cpu(current);
>>         struct fuse_ring_queue *queue, *primary_queue = NULL;
>>
>> +       /* numa local registered queue bitmap */
>> +       node = cpu_to_node(cpu);
>> +       if (WARN_ONCE(node >= ring->nr_numa_nodes,
>> +                     "Node number (%d) exceeds nr nodes (%d)\n", node,
>> +                     ring->nr_numa_nodes)) {
>> +               node = 0;
>> +       }
>> +
>>         /*
>>          *  Background requests result in better performance on a different
>>          *  CPU, unless CPUs are already busy.
>> @@ -1331,14 +1339,6 @@ static struct fuse_ring_queue *fuse_uring_select_queue(struct fuse_ring *ring,
>>  retry:
>>         cpu = cpu % ring->max_nr_queues;
>>
>> -       /* numa local registered queue bitmap */
>> -       node = cpu_to_node(cpu);
>> -       if (WARN_ONCE(node >= ring->nr_numa_nodes,
>> -                     "Node number (%d) exceeds nr nodes (%d)\n",
>> -                     node, ring->nr_numa_nodes)) {
>> -               node = 0;
>> -       }
>> -
>>         nr_queues = READ_ONCE(ring->numa_q_map[node].nr_queues);
>>         if (nr_queues) {
>>                 /* prefer the queue that corresponds to the current cpu */
>>
> 
> I think this still runs into some numa-crossing issues. for example if
> cpu 3 is in node 0 and then cpu 4 is in node 1, the
> 
>         if (nr_queues) {
>                 /* prefer the queue that corresponds to the current cpu */
>                 queue = READ_ONCE(ring->queues[cpu]);
>                 if (queue) {
>                         if (queue->nr_reqs <= FUSE_URING_Q_THRESHOLD)
>                                 return queue;
>                         primary_queue = queue;
>                 }
> 
>                 qid = ring->numa_q_map[node].cpu_to_qid[cpu];
> 
> check will still assign it to node 1 in the "queue =
> READ_ONCE(ring->queues[cpu])" line and in the last line (" qid =
> ring->numa_q_map[node].cpu_to_qid[cpu];") I think this will just
> default to assigning it to queue 0 since cpu 4 is not node 0's
> cpu_to_qid mapping.

Oh I see, because in fuse_uring_cpu_qid_mapping() we ignore all cpus not
belonging to the current node. That could be changed.

> 
> imo the simplest way to get around this would be to use the node's
> registered_q_mask map with cpumask_next_wrap().

I was initially a bit concerned that it does not follow the static
mapping as defined in fuse_uring_cpu_qid_mapping and might cause some
imbalance, but now I think it should work.

Btw, for v4 I'm also going to remove the pr_debug() in
fuse_uring_cpu_qid_mapping(), which I had used to verify. The better
approach is to print that with debugfs.

https://github.com/bsbernd/linux/tree/fuse-debugfs

Maybe I find some time next week to polish and send it.


Thanks,
Bernd



