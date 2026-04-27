Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406A53B27E5;
	Mon, 27 Apr 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283779; cv=none; b=a8D56t5SCnUZnunl5Tjfnuvc56bFlFfICeePyNb9kFaJIKdJ7iFFGpvIYi/UaRlH3JnyaZSuzvzu/WWKMF1zYZ+f72PX7W+YxaC0A6fX82/suJsxp+IqI13cj1qPw2vwtF/AiMeUgL5lo4id15JBjFCellFJ8deWrvpiVcshXLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283779; c=relaxed/simple;
	bh=f6suBYbBCeHoikHlAcfzsdD0ZbplLPgF1eRZyJEd3Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6UKwRxsN2jj2zpHAySm4bn/VBirrzDywg9yTEFEbk/sv/8hE+B+IcoIkWQLCAF7z9YmWHM5bkGMSSubxEmjqX5joSsGnLyG3JugtieScSwwSPTfl0UyYxXvBaz2AOtCEef3s7b205JhQuynABptcjbfWxPL7/H/LR28EEDdWPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 5096f9de421f11f1aa26b74ffac11d73-20260427
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:648bb190-e3fb-4e9d-a5fb-5d2e0fc392c7,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:2fc42c9fce4bd1b9e104f74585c4c8fe,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|898,TC:nil,Content:0|15|
	50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
	,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5096f9de421f11f1aa26b74ffac11d73-20260427
X-User: liwang@kylinos.cn
Received: from [10.42.16.85] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liwang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 624601296; Mon, 27 Apr 2026 17:56:08 +0800
Message-ID: <25e00efd-c0ef-446e-a246-6eebd7a68c9d@kylinos.cn>
Date: Mon, 27 Apr 2026 17:56:06 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
Content-Language: en-GB
To: Bernd Schubert <bernd@bsbernd.com>, Joanne Koong <joannelkoong@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403035752.20206-1-liwang@kylinos.cn>
 <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
 <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
From: Li Wang <liwang@kylinos.cn>
In-Reply-To: <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Bernd and Joanne,

On 26/04/2026 23:48, Bernd Schubert wrote:
> 
> 
> On 4/24/26 22:38, Joanne Koong wrote:
>> On Thu, Apr 23, 2026 at 4:11 AM Li Wang <liwang@kylinos.cn> wrote:
>>>
>>> Deliver FUSE_FORGET through fuse_uring_queue_fuse_req() when the io_uring
>>> is ready and userspace has opted in by setting
>>> FUSE_IO_URING_REGISTER_FORGET_COMMIT in fuse_uring_cmd_req.flags on
>>> FUSE_IO_URING_CMD_REGISTER. Until any REGISTER
>>> carries that bit, FORGET continues to use the legacy
>>> fuse_dev_queue_forget() path even while io_uring is active, so unmodified
>>> userspace (e.g. libfuse that does not issue a completion SQE for FORGET)
>>> does not wedge ring entries.
>>>
>>> Benefits:
>>> - FORGET can share the same commit/fetch loop as other opcodes.
>>> - Reduces split transport for high-volume forgets when the ring is primary.
>>> - Reuses existing per-queue io-uring machinery and noreply/force
>>>   request setup.
>>>
>>> Signed-off-by: Li Wang <liwang@kylinos.cn>
>>
>> Hi Li,
>>
>> Thanks for sending this. To be completely honest, I'm not convinced
>> delivering forget over io-uring is worth the added complexity/cost. In
>> the /dev/fuse path we rely on forget batching/amoritizing and explicit
>> scheduling/fairness logic so forget processing makes progress and
>> doesn't get drowned out by regular requests; I think we'd likely need
>> something comparable for the io-uring path as well. Additionally,
>> routing it through io-uring makes forget behave more like a "real"
>> request on the ring (it needs per-request state to live until
>> userspace completes and the entry can be recyycled) which introduces
>> extra allocation/lifetime management on this path and it requires a
>> uapi change and corresponding libfuse changes.
>>
>> Forgets would consume ring entries but they're tiny one-way
>> notifications and imo I don't think they benefit much from io-uring's
>> main advantages (eg data-path/zero-copy). I worry theyy could contend
>> with read-write heavy traffic where ring capacity is more valuable.
> 
> I think when FORGET starts to disturb writes or reads, there also must
> be some metadata load that causes many of these requests. Going via
> /dev/fuse also includes another two syscalls and cpu task switch to the
> libfuse thread handling them - that is not for free either.
> 
> However, this currently might disturb reads/writes, if the queue depth
> is limited and memory optimized to carry reads/writes. The missing
> feature here is to have a multiple request sizes on the same queue.
> 
> Btw, syscall overhead is basically the reason why I wouldn't like to
> have multiple rings per request size, but one ring with entries of
> different sizes. Will try to respond to the other mail later today.
> 
>>
>> Given that, my preference would be to keep forget/interrupts on the
>> legacy /dev/fuse path even when io-uring is enabled. Sorry for not
>> bringing this up earlier in v2. Bernd, I’d also be curious to hear
>> your perspective on this.
> 
> It is certainly not something that I would count as priority. Though I
> don't think it would hurt either. In the end we might be able to run
> entirely without /dev/fuse IO and threads and would save a bit resources.
> 
> @Li do you see performance improvements with FORGETs through the ring or
> could you post your underlying motivation?
> 
To be honest, my initial motivation for this wasn't necessarily performance, 
but rather architectural simplicity. Maintaining two separate paths and 
thread pools for forget/interrupt and I/O requests adds a bit of complexity 
to the code and introduces relatively higher overhead, as well as some 
resource redundancy.

Furthermore, in the current implementation, forget and I/O requests are 
dispatched through different paths and handled by different sets of threads. 
This means we cannot guarantee their original priority order upon reception, 
and it potentially introduces extra context-switching overhead, which 
impacts the processing efficiency of both.

Theoretically, optimization measures such as batching forget requests can 
also be implemented via the io_uring path. This would allow us to amortize 
the state maintenance and completion overhead of forget requests, while also 
addressing the issue of uniform request sizes within the same ring. I'll 
get around to running some performance benchmarks.

Thanks,
Li
