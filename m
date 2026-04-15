Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8713AF2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776250510; cv=none; b=nSbkcKKCXTBVsfdHB98NgJ+Vfz5Ls3dzzqMKPnjjdmTqvczbSb4VQNJ41asTX844z0cH34IIAthpV+xYvSciqQornbx9pHEb7BleeO5T1zq3sxbZJ6VmbTbE5jCVz4oMVON9/JmlQZVA66GKsPwvKjvtDv2PQNavqcUiYylFBdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776250510; c=relaxed/simple;
	bh=sQDX58AGhqjtXgkjP0ITh3FMqUFQ8kSKZoISzcZvBSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2b0ckAFal391qdbOwM1AgV2q2Gwl3Nw0AT6sK1w/JGaRnDW65I5ulsn4eJrvjsLor0RTrlK011XBGsB6ayORtxyn7yw1ZfDXX/tEGfv2jw58q50zNkWB5N38HgRrzaHn5dYXSzeRndzlQEYawlFhqTWxq9QxnujK5wgKmky2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=dB4zVYqz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BUZSWqjO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="dB4zVYqz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BUZSWqjO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B6D311D000E8;
	Wed, 15 Apr 2026 06:55:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 06:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776250506;
	 x=1776336906; bh=udzBOPRVMLNcLzXApp/4s9HBOsMoTwVEKBzT53L1J7U=; b=
	dB4zVYqzE+iZjFy9W6GgvB/I7vHmrq2yu4eZW+prpK4n4dynnoSlbqQULgSnfg87
	VXXSq+0Zlm/rQ5vvtyLAQgTmmOBSzdGqkLw3ncLQ9/q+6joCg3Y6K4snZzXlsFU+
	nFauzdoQ1VpVUBHotHlrQY8ODn9ftObIO2Zi7FkymzLULxcd6Ml0A9n0VzYn8a9I
	sWE5uBh25GC7JFkPFzHzcvsoNvPhizSff288b7ahX5u3cFTETgDHVXpOPPJUwbgs
	stePOmFqN7UuTlAEiYQC5BpQxDSjBVqdu3zSqQKKrJX5UJO2k16IoURBsrAcmX+R
	pS8Iu/tvCvCCktkxX3e0Sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776250506; x=
	1776336906; bh=udzBOPRVMLNcLzXApp/4s9HBOsMoTwVEKBzT53L1J7U=; b=B
	UZSWqjOyCKmdBDLK0VT3Vs3VffZdfAkJmWDPzDI/fDrbsLMc+DD5a91ynkFfGdy/
	pJErj/XPkNJ/Rrl4PsYSfd4ldztGIR/bXQwX9R/7V9rJVyCh2zod1nHJxK6pRp+J
	L6pVwF4klJVcHy8a4bEKRMs752xWPg1RkTRKq74vzkIbLGAEoF3utgQzMCMTEHqr
	rC9ronM+aou3M8bz+JFmq81EB9Yo+KZNn/yc1Z3Xs4dpzON1qpsvfwJf3B1aLCWa
	3JwvxfXQPX4xxA0H2oIwYsogQtjXeeFszpeNXa9xl094LHL/70MkS7ja6BZ+/mQf
	qtX2VSGiWxPWFdc6PTvwg==
X-ME-Sender: <xms:iW7faYULoTFVlrcnORrTB0gecLIx_eZh25MSEu6lE6IHM329CgWKZw>
    <xme:iW7faTkmtimMsDSQaRWN6vb8qfqMKI8lLOC-XCva9t-ThVrKrcDAX6QyDLSW4kbVv
    UdbVxaa7Ru4Vdeak5pLVSO0_Wo_CJKOSv1VLr4Zh-umh91xZB24>
X-ME-Received: <xmr:iW7faRaKW4F9ZGD3egxhEfjMICny8xXtbor1T3PofoXXHwvwbbPKnQVFWth4hrNYE2yPutRi2JnOI8po3zHWB_4mdtN8KgJZZH9IYrvoLeiKXwhqbw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegfeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegr
    gigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlh
    esvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:im7faWOdcYsSeRyavlArLxbfjYimt7NyNzduopgji8NeTGt9_993TA>
    <xmx:im7faeYqTBEQyViOshE_5A3OYWpIp6teyqsWnD_ayQL_42Cm8T_qDA>
    <xmx:im7fac01lxolm3HEDEn5Mhr9wlcRmKSTAL9biBzQ6TFSVO6az9detw>
    <xmx:im7faccpnxMXW50147Xl3-MQSdPjm5tw-gQ6jQWi5lQgUzgWbWo5OQ>
    <xmx:im7facw88gnMIejITuusEtMsYB9xyueVR_6TIF3jr0frF_Pul2k2Frfe>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 06:55:04 -0400 (EDT)
Message-ID: <ff596299-38c1-4c5a-8f1d-14931dd84ef0@bsbernd.com>
Date: Wed, 15 Apr 2026 12:55:02 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] docs: fuse: add io-uring bufring and zero-copy
 documentation
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-15-joannelkoong@gmail.com>
 <0f2b87c5-2c98-4463-9a9c-bfca91e83cfc@bsbernd.com>
 <CAJnrk1ZAcbYkewWz=CbxgzkvXnk2-QKLjSk-oA0hywbnVUSM9A@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr
In-Reply-To: <CAJnrk1ZAcbYkewWz=CbxgzkvXnk2-QKLjSk-oA0hywbnVUSM9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/15/26 03:10, Joanne Koong wrote:
> On Tue, Apr 14, 2026 at 2:05 PM Bernd Schubert <bernd@bsbernd.com> wrote:
>>
>> On 4/2/26 18:28, Joanne Koong wrote:
>>> Add documentation for fuse over io-uring usage of buffer rings and
>>> zero-copy.
>>>
>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>> ---
>>>  .../filesystems/fuse/fuse-io-uring.rst        | 189 ++++++++++++++++++
>>>  1 file changed, 189 insertions(+)
>>>
>>> diff --git a/Documentation/filesystems/fuse/fuse-io-uring.rst b/Documentation/filesystems/fuse/fuse-io-uring.rst
>>> index d73dd0dbd238..bc47686c023f 100644
>>> --- a/Documentation/filesystems/fuse/fuse-io-uring.rst
>>> +++ b/Documentation/filesystems/fuse/fuse-io-uring.rst
>>> @@ -95,5 +95,194 @@ Sending requests with CQEs
>>>   |    <fuse_unlink()                         |
>>>   |  <sys_unlink()                            |
>>>
>>> +Buffer rings
>>> +============
>>>
>>> +Buffer rings have two main advantages:
>>>
>>> +* Reduced memory usage: payload buffers are pooled and selected on demand
>>> +  rather than dedicated per-entry, allowing fewer buffers than entries. This

Then don't register that many entries? An entry is useless if it cannot
carry data - why do you need to register that many entries then?

>>> +  infrastructure also allows for future optimizations like incremental buffer
>>> +  consumption where non-overlapping parts of a buffer may be used across
>>> +  concurrent requests.
>>> +* Foundation for pinned buffers: contiguous buffer allocations allow the
>>> +  kernel to pin and vmap the entire region, avoiding per-request page
>>> +  resolution overhead

Pinning can be done per buffer as well. The part that is harder is
pinning of the headers - this is why libfuse currently allocates 4K for
every header - prepares the pinning. From my point of view, we _should_
make use of that and set at registration time that the header is
allocated as 4K and then small requests can be inlined into the
remaining part of those 4K. With that ring bufs become useful, because
most metadata do not need a new payload buffer anymore.
However, I think in your current design headers are mapped into a large
region and there is no way to use extra space. I think that is fine, as
long as we have the capability to have multi size buf pools.


Contiguous buffer allocation can be done for entries as well - userspace
just needs to assign it to buffers that way. It becomes it a bit harder
with dynamic entry registration - entries buffers should then allocat in
sizes of system huge pages.


In fact I initially had that in libfuse and had allocated all userspace
buffers as one big memory. Then 'temporarily' removed it because I had
development stability issues - the single buffer needs to be marked with
ASAN areas in order to catch issues. For initial development that was
just overkill, but could be added now, in combination with ASAN buf marking.
For pools it would be good think about ASAN as well.

>>> +
>>> +At a high-level, this is how fuse uses buffer rings:
>>> +
>>> +* The first REGISTER SQE for a queue creates the queue and sets up the
>>> +  buffer ring. The server provides two iovecs: one for headers and one for
>>> +  payload buffers. Each entry gets a fixed ID (sqe->buf_index) that maps
>>> +  to a specific header slot.
>>
>> Hi Joanne,
>>
>> thanks a lot for this document! Could we discuss if we could just hook
>> in here and allow SQEs with different iovecs for the payload buffer?
>> Let's say fuse-server wants multiple IO sizes - it could easily do that
>> via different pBufs and just needs to specify the dedicated IO size per
>> pBuf. Those buffers could then get sorted into an array - we could
>> define either via FUSE init the number of buf sizes or use a fixed size
>> array. Fuse requests then would just need to pick the right array.
>> This is basically what I'm currently working on for ublk.
>>
>> I think it would be good to agree on the design before it gets merged so
>> that uapi doesn't change.
> 
> Hi Bernd,
> 
> I'm not certain I fully see the use case for a fuse server preferring
> a static preallocation of multiple IO sizes over using incremental
> buffer consumption, but in my mind to support multiple IO size

I have to admit that I don't see why we need pbuf for dynamic
allocation. While the io-uring ring has a fixed number of SQEs/CQEs and
while libfuse currently strongly couples these to fuse buffers, there is
no technical reason. Initially it was, because I had taken the 'tags'
from ublk design, but then Miklos asked to make it lists that just get
appended whenever a FUSE_IO_URING_CMD_REGISTER is send. Which means
libfuse _could_ add new entries any time. You could start with 1 entry
per queue, additionally with the reduce-nr-queue patches you could even
start with a single queue and a single entry - and then extend that at
any time to what libfuse or the application believes is needed.
I.e. except of io-uring setup, adding or even removing ring entries and
their buffers is mainly a missing userspace issue. In order to remove
idle entries, we could add another notification type like
FUSE_NOTIFY_WAKE_RING_ENTRIES and it would then wake a given amount per
queue and maybe send via a new op code like FUSE_NOOP. All of that seems
to be easy.

> payloads, I was thinking something like this might work best:
> 
> * iov[0] for the headers stays the same. no matter how many IO size
> payloads there are, the ent always maps to a header and the headers
> are a fixed size
> * iov[1...x] are the payload buffers. From the uapi perspective, in
> the fues_uring_cmd_req init struct, there would need to be an array of
> uint32_t buf_sizes. Each index in the array would correspond to index
> + 1 in the iov[] payloads passed
> * on the fuse side, each of the buffer pools has its own ring. I think
> this makes managing the different buffers a lot easier and gets rid of
> having to do any array sorting, and makes buffer selection/recycling
> O(1).


Let's say we would have per queue

    struct fuse_bufring {
        bool use_pinned_headers: 1;
        bool use_zero_copy: 1;
        unsigned int max_queue_depth; /* headers buffer capacity; frozen
at first REGISTER */

        union {
            void __user *headers;
            struct fuse_bufring_pinned pinned_headers;
        };

        unsigned int nr_pools;
        struct fuse_bufring_pool *pools[FUSE_URING_MAX_POOLS];

        /* lookup: order (req size) pool */
        struct fuse_bufring_pool *order_map[FUSE_URING_NR_ORDERS];
    };


Order map is then dynamically created at buf pool registration time, and
then we would eventually get to

struct fuse_bufring_pool *pool = order_map[get_order(fuse_len_args())];

(obviously the final code needs to get a check that we don't exceed max
payload size.)

The looked up pool can be stored into ring_ent for buf recycling.



And then

  struct fuse_uring_cmd_req {

      ...
      union {
          struct {
              __u32 max_queue_depth;      /* (renamed from queue_depth) */
              __u32 buf_size;

              __u8  pool_idx;
              __u8  _pad[3];

          } init;
          ...

      };

  };



I think pool_idx is needed one way or the other, because the io-uring
ring owner might have other pools for its own purposes.


Thanks,
Bernd
