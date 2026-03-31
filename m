Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF52D41B36F
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 21:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992648; cv=none; b=ZPJkc5yQdoWSDGuPVpVA3FxpYUOZgN38KnbsTxrr0nJbPa9E6sHoXELWvJV4ayFEC7BI/lQW3KIBy974kCJbMrjZ8Xmqi8UWvQ5TED5gx+5jiDjJK2tuqsFO1MCBmogv98MXizgY0EvWSmmw/hxpSy2edOxnhAb95h3yMB/QjSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992648; c=relaxed/simple;
	bh=pqvoEhr7ppoNITFEsBSKDwbA5AArTfXgaIvQY5Pmo4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAIVE0VF/EvbqbWTkBQinCGXVRp8Z1KRWcM4XhDtjULkNC8vwQdHqFB06Yj5QG802LFAL2qtRCo1ZXxZMuPEu9XcC5u96CKmUnEkdsj1sJiRqsYZK4dvQAsqYPQB2/Wv0xXvMe7d8eX+4FCAmWPxMK+bK2xxcKnzTVIGGDjFp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=erZAFxDz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MUDevvNZ; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="erZAFxDz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MUDevvNZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 11761EC0291;
	Tue, 31 Mar 2026 17:30:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 31 Mar 2026 17:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774992646;
	 x=1775079046; bh=2SiaWp8Pf29Zes1NcgEirvuNiYDNOM8AepMOkwegL1s=; b=
	erZAFxDzXcpfuZ6i9OGAkzxqnflxQZp/ByBeLS57czZG8fHGottBcaLu0LKPJfHp
	B2UNvw32v57FKDx7EUIZigZ8gq3ThPV+4fw74YRxvPHpUOrdUVmkw5TxCw21hXec
	IG/8KNoDr2KGPUJFsWp5zDu7XpX9TLGqp5Pl2Mq8jJnEmAWvalCcqPg+LXIxnPma
	OxFuK4J8Rtm3WqyyaaF4Qe+Pojv6GwWbgPGo/yVnEdx152Qetc5bfj+m5pbAec4D
	ud5PhMMBmsYWHWz01wE/ZBNxinX/iUPzsQo97L02X9gCiPGuk5M9OUTS7/zntQH8
	ff+DOq0gc7++coUpC+qrSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1774992646; x=
	1775079046; bh=2SiaWp8Pf29Zes1NcgEirvuNiYDNOM8AepMOkwegL1s=; b=M
	UDevvNZGfTwUImVx6juiAFIipN2coeDE2zg9LldOpHfaQ8BWY62Gd0t8lm3F1oRb
	E2T3zsoEk0KiY8jjPm0u/w5f4wBkKpyomHYsZ1Qpp76POQaDcFBr2KV/PaHXw02Z
	DLfpWfZ+p8gydFCZjU9dYPCFzamspToFzBT+WvYta4Z4jMLgRlMQVDXO52oyuz0j
	LzQBnldDsAmbVuFcxKGtjYYQU2e9uirk6xBbD+v6EBx2qzCsoM/FakgKUmfa+EOT
	UZex4T1Zp7hzclNlM9Uj4TotUggGs+Rfqg+3zENC8wNRxJVN0kO1qQvfoPf39jA0
	nLP4fpeiR74Nv3xmu3n+A==
X-ME-Sender: <xms:BT3MaU_cE5mx1RfU3R54lBMAbNvYJo_IsqxrSYXRjMZI-KxtYGcsng>
    <xme:BT3MaTmuZLs3jjv4_svS8d4AlkWKnh6uyp-5CNxJWePxG8k9yVGxA3G4i3pJbJF3k
    QZHVe02Ms6Eu6I3mtnZyiUrDGbCwxwVpz3yOgPQLxzi07QT64ffqg>
X-ME-Received: <xmr:BT3MaSX3A-xjBWt5MZ37ooXgUGajj4Uz5xif2haNwWFSP7ZjRZxhOn2Sz81pIYhhk89kb0QKy73ri14cS3riuexhvlMIxmQSzygcnvT1X4DfHh94_w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhguucfu
    tghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrghtth
    gvrhhnpeejffdutdeghfffgffgjeehteejueekieetieehveehteeuiefgieeuleekjeek
    ueenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtghomhdp
    nhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprgigsghovgeskhgv
    rhhnvghlrdgukhdprhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtg
    hpthhtohepsghstghhuhgsvghrthesuggunhdrtghomhdprhgtphhtthhopehlihhnuhig
    qdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BT3MaQGjeH9I6K3UentzjLw7bTfhwmWH_E2wLpzzmexiEtPHpXe-oQ>
    <xmx:BT3MaWcK0gDPdH2jyFg7mdYnzLAYCT6w60pCOYV09sB3i1lzxOD38A>
    <xmx:BT3MaZJRt_vVGFNtulO36yckF4AbyU0rQthJy1JvZAYjL01WbpJ9iA>
    <xmx:BT3MaTEvKAVDyWFoTxBg2g7ElvPdnkZOKK_MO0J1qCranM1HdjygKg>
    <xmx:Bj3MaWZDgxbfRUehgyQ2RGWxH_rF_VCnSQRwgOiaocOvFaazXV9pB7Hj>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 17:30:44 -0400 (EDT)
Message-ID: <da379913-df64-446e-af56-a75b8c00e631@bsbernd.com>
Date: Tue, 31 Mar 2026 21:30:43 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 7/9] fuse: add io-uring kernel-managed buffer ring
To: Joanne Koong <joannelkoong@gmail.com>
Cc: axboe@kernel.dk, miklos@szeredi.hu, bschubert@ddn.com,
 linux-fsdevel@vger.kernel.org
References: <20260324224532.3733468-1-joannelkoong@gmail.com>
 <20260324224532.3733468-8-joannelkoong@gmail.com>
 <6b066b75-e77e-4b4a-8280-199d547c2e94@bsbernd.com>
 <CAJnrk1aTOzsQgh4DfT=6h+n7=OZx0xfHGbV_H5VcvZZF0bp6Bw@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1aTOzsQgh4DfT=6h+n7=OZx0xfHGbV_H5VcvZZF0bp6Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/30/26 23:19, Joanne Koong wrote:
> On Mon, Mar 30, 2026 at 2:28 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 3/24/26 23:45, Joanne Koong wrote:
>>> Add io-uring kernel-managed buffer ring capability for fuse servers
>>> communicating through the io-uring interface.
>>>
>>> This has two benefits:
>>> a) eliminates the overhead of pinning/unpinning user pages and
>>> translating virtual addresses for every server-kernel interaction
>>>
>>> b) reduces the amount of memory needed for the buffers per queue.
>>> Incremental buffer consumption, when added, will allow non-overlapping
>>> regions of a buffer to be used simultaneously across multiple requests.
>>>
>>> Buffer ring usage is set on a per-queue basis. In order to use this, the
>>> server needs to have preregistered a kernel-managed buffer ring and a
>>> memory region big enough to hold the headers. This should be done before
>>> queue creation is initiated. The kernel-managed buffer ring will be
>>> pinned for the lifetime of the io-ring.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  fs/fuse/dev_uring.c       | 384 +++++++++++++++++++++++++++++++-------
>>>  fs/fuse/dev_uring_i.h     |  46 ++++-
>>>  include/uapi/linux/fuse.h |  19 +-
>>>  3 files changed, 376 insertions(+), 73 deletions(-)
>>>
>>> diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
>>> index 81cd20e0d50b..cd45b6a8e6c6 100644
>>> --- a/fs/fuse/dev_uring.c
>>> +++ b/fs/fuse/dev_uring.c
>>> @@ -10,6 +10,7 @@
>>>  #include "fuse_trace.h"
>>>
>>>  #include <linux/fs.h>
>>> +#include <linux/io_uring.h>
>>>  #include <linux/io_uring/cmd.h>
>>>
>>>  static bool __read_mostly enable_uring;
>>> @@ -19,6 +20,7 @@ MODULE_PARM_DESC(enable_uring,
>>>
>>> -static struct fuse_ring_queue *fuse_uring_create_queue(struct fuse_ring *ring,
>>> -                                                    int qid)
>>> +static void *fuse_uring_get_buf_ring_headers(struct io_uring_cmd *cmd,
>>> +                                          u64 headers_offset,
>>> +                                          unsigned int queue_depth,
>>> +                                          unsigned int issue_flags)
>>> +{
>>> +     void *mem_reg_addr;
>>> +     u64 mem_reg_size, headers_size;
>>> +     unsigned nr_pages;
>>> +
>>> +     /* find the headers in the registered memory region */
>>> +     mem_reg_addr = io_uring_registered_mem_region_get(cmd, &nr_pages,
>>> +                                                       issue_flags);
>>> +
>>> +     /* server does not have a registered memory region set up */
>>> +     if (!mem_reg_addr)
>>> +             return NULL;
>>> +
>>> +     mem_reg_size = (u64)nr_pages * PAGE_SIZE;
>>> +     if (headers_offset > mem_reg_size)
>>> +             return NULL;
>>> +
>>> +     /* verify headers fit within memory region bounds */
>>> +     headers_size = (u64)queue_depth * sizeof(struct fuse_uring_req_header);
>>> +     if (mem_reg_size - headers_offset < headers_size)
>>> +             return NULL;
>>
>>
>> Could you add to the commit message how the buffer layout is? I think
>> this deserves some explanation.
> 
> I will add a visual diagram for this. The headers buffer is laid out
> contiguously in memory. On the server side the server is able to map
> from ent id to where in the headers buffer the data for that ent
> resides by calculating ent_id * sizeof(struct fuse_uring_req_header).
> I'll also add a diagram for the buffer ring as well. I am going to be
> sending out a v2 that has some updates. The bulk of the fuse logic is
> pretty much the same but the buffer rings and memory accounting
> infrastructure will be moved to fuse instead of going through the
> io-uring uapi.
> 
>>
>> The appraoch kinds of reminds me to my initial patches where I
>> configured the ring with an additional ioctl. Until Miklos asked to make
>> it dynamic and to avoid the ioctls (and config SQEs as well). Basically
>> here every FUSE_IO_URING_CMD_REGISTER gets the the queue depth? Wouldn't
> 
> I don't think an additional ioctl or config setup cmd op is needed
> because this can go through the registration flow we currently have
> without a problem. Every registration sqe will pass the queue_depth in
> the fuse_uring_cmd_req data. There is logic to ensure that all ents
> for a given queue set the same queue depth. For the code logic, only

Yeah, just a bit counter intuitive to do the same repeated work for
every reg sqe.

> the first registration sqe needs to set queue depth, but I think it
> makes the interface simpler to just have all the registration sqes
> pass in the queue depth, since in the dev_uring code we also account
> for edge cases where the same queue gets registered concurrently on
> multiple threads. I don't think a separate setup cmd op is necessary
> here.
> 
>> make sense to have a setup SQE per queue then? Or one global
>> CREATE_RINGS config sqe? With the reduced queue series things would be
>> definitely easier if we would know the number of queues that are
>> supposed to get created (right now the it has to re-calculate the the
>> static mapping for every queue).
> 
> Do you have a link to the reduced queue series version you're
> referencing? I'm not sure without looking at that code whether that
> could use the current registration flow in the same way or whether
> that needs a new config sqe.


https://github.com/bsbernd/linux/tree/reduced-nr-ring-queues_4-v7.0

I just updated it with all the fixes we have in the DDN branch and
running xfstests now. Let's see if I have access to that when I wake up
;) (I was promised I should have).
If all goes well, I will send the updated series tomorrow.


Thanks,
Bernd
