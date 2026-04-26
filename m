Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED01A4F2F;
	Sun, 26 Apr 2026 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777218530; cv=none; b=E1eNssq4UfgjQuXNsf+GWZ29DCmqX5yDTFzqWMtgQbo96FCNGOkCQIqekORgfG4/kWZQmZLWiT0kcuWQcwuGzoKB9M24E817SfzxMAmAy3ban83HN5b+tyu2oGhrdvU3PRAv0aPxDqi6gdDftJ7mM/Wi60b3DNrJWJg+IbiO0tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777218530; c=relaxed/simple;
	bh=gi+0f4uJmZ893iENp5l4CnJcD+X11vYSam1HWRtNJhk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S/PBEIbU9cSDrVi/hbpAgqlO2raxH3MyHGIInvtRkxoPTGiGHZj+HTDTccco1iyISwCkT3DAiAucFVX4CYMeSqzviSVNFh/vsUkd/yirl9GvV4eJHF9U2ioD2+oO5QE8vY2pVKJzVTm+rc75YDt1m7ezwAgsDpFjvk26t+4YETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=sig+YX6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jf88dSH5; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="sig+YX6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jf88dSH5"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 19EC7140008B;
	Sun, 26 Apr 2026 11:48:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 26 Apr 2026 11:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777218526;
	 x=1777304926; bh=KOeTmF7hmU0obfJ8Wko8w/CZBBggTcJslkudXS/Daeo=; b=
	sig+YX6xGrv3Ao2HrkcDMFw9KtuAXvFLJSmd/BGTd4y7boCwGMT6kSU//l7aHjNA
	aujr8eKxSD1cZ9/r0BjbHAqKTEKeJR14ikuiB9xNTmy632oQtcZ3BYIIxqRYYRlf
	hdm6O/nlfWa4N/udierB3jcIEI8gL6dtdkjpeVXJ6FxXTLbHw6McGBU6HJSgGDkD
	2f3zl40BTvzFEDOYNAWhUQuD76D68VUeIdNmSbBpM0jJHvSnbVJzT9TxqTqE6Mps
	GVBPTxMIG9MyZkULPgwrg+XrcUkecyGDq+4lMNfjkMyNA4xXJXeVvWavVrfKbdzx
	w6FnjUWh36sQBuN5jhUpqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777218526; x=
	1777304926; bh=KOeTmF7hmU0obfJ8Wko8w/CZBBggTcJslkudXS/Daeo=; b=j
	f88dSH5xESY7hR+FzxIj/TRyC02rBBw79mb/6BQRFH+EqPRPDFWqE/5geNsGJJ+h
	HZC3A2Vx4M5oVjK6StBiyQ2SbUAwYWjEyjh7JSWQU+GIJ8DbN9igytIUiQBxzWUk
	SrvlYwuz4h3x9orxy4wsHCH1WrpBTpo4KSSIiA5+wPEENUeE3vVEpH3lWNWMtkyY
	CYN1wNgkhXnDfKUUnfNZXu2bVij8XPBcitUCHYTeEhopnCZDRa6fPOoSG3CM3QKA
	LYrdDy9PGv3TYlzG5Jb2cGROKNjGt5z3sZ/rpqGZhSKWt8JytucXorV1NOdwqvf+
	R3JqdYbh87sZH8YwIrRSg==
X-ME-Sender: <xms:3DPuaaF-lnBXMIvkGaAmpQIm_RWvyjf1dsdS3MON35pBv2C81X5oxA>
    <xme:3DPuaWSvdA_1l4hQRA_AnyIxOFyNbftn4fiiK3w0JNxd8Nprqzj-fVXWgViYohgCh
    cFE8XKe9lumSDXcYmbfStMUMNpbABcJ4J3QHbxrKJUQiuNg1esQ>
X-ME-Received: <xmr:3DPuaTL8euDw7XFg_74OmQUPhQTwkM8PH6-xQW_PImyZndS87N9vwlhPJvoXIU8Wgpw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejiedulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthekredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepfeeggeefffekudduleefheelleehgfffhedujedvgfetvedvtdefieehfeel
    gfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    gvrhhnugessghssggvrhhnugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtoheplhhifigrnhhgsehkhihlihhnohhsrdgtnhdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepfhhushgvqdguvghvvghlse
    hlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3DPuaZZR2Os0bDf6U_VTcKHiGFKmGz_WD0k0WZavmvfx_4li2mbCZg>
    <xmx:3DPuad9c8_mM2IdwpnncmjEf9b13v-0Wzny5w7Iy6lIRC6OqUpYNMw>
    <xmx:3DPuaSZTUqALzvMzpdY5j7MHgSks5Lo3a1HdWWpsZGKoMuU5FakdtQ>
    <xmx:3DPuaZNffhxJLOyRHO-88E-KODS4ob26TWGuUK52iw2EwR0mcQu6GQ>
    <xmx:3jPuaekAwKFw2nFAfvWqTJ0-Re2I9FtKXEIngU4Xg55aa1Yz2XWy70sO>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 11:48:36 -0400 (EDT)
Message-ID: <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com>
Date: Sun, 26 Apr 2026 17:48:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Joanne Koong <joannelkoong@gmail.com>, Li Wang <liwang@kylinos.cn>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260403035752.20206-1-liwang@kylinos.cn>
 <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/24/26 22:38, Joanne Koong wrote:
> On Thu, Apr 23, 2026 at 4:11 AM Li Wang <liwang@kylinos.cn> wrote:
>>
>> Deliver FUSE_FORGET through fuse_uring_queue_fuse_req() when the io_uring
>> is ready and userspace has opted in by setting
>> FUSE_IO_URING_REGISTER_FORGET_COMMIT in fuse_uring_cmd_req.flags on
>> FUSE_IO_URING_CMD_REGISTER. Until any REGISTER
>> carries that bit, FORGET continues to use the legacy
>> fuse_dev_queue_forget() path even while io_uring is active, so unmodified
>> userspace (e.g. libfuse that does not issue a completion SQE for FORGET)
>> does not wedge ring entries.
>>
>> Benefits:
>> - FORGET can share the same commit/fetch loop as other opcodes.
>> - Reduces split transport for high-volume forgets when the ring is primary.
>> - Reuses existing per-queue io-uring machinery and noreply/force
>>   request setup.
>>
>> Signed-off-by: Li Wang <liwang@kylinos.cn>
> 
> Hi Li,
> 
> Thanks for sending this. To be completely honest, I'm not convinced
> delivering forget over io-uring is worth the added complexity/cost. In
> the /dev/fuse path we rely on forget batching/amoritizing and explicit
> scheduling/fairness logic so forget processing makes progress and
> doesn't get drowned out by regular requests; I think we'd likely need
> something comparable for the io-uring path as well. Additionally,
> routing it through io-uring makes forget behave more like a "real"
> request on the ring (it needs per-request state to live until
> userspace completes and the entry can be recyycled) which introduces
> extra allocation/lifetime management on this path and it requires a
> uapi change and corresponding libfuse changes.
> 
> Forgets would consume ring entries but they're tiny one-way
> notifications and imo I don't think they benefit much from io-uring's
> main advantages (eg data-path/zero-copy). I worry theyy could contend
> with read-write heavy traffic where ring capacity is more valuable.

I think when FORGET starts to disturb writes or reads, there also must
be some metadata load that causes many of these requests. Going via
/dev/fuse also includes another two syscalls and cpu task switch to the
libfuse thread handling them - that is not for free either.

However, this currently might disturb reads/writes, if the queue depth
is limited and memory optimized to carry reads/writes. The missing
feature here is to have a multiple request sizes on the same queue.

Btw, syscall overhead is basically the reason why I wouldn't like to
have multiple rings per request size, but one ring with entries of
different sizes. Will try to respond to the other mail later today.

> 
> Given that, my preference would be to keep forget/interrupts on the
> legacy /dev/fuse path even when io-uring is enabled. Sorry for not
> bringing this up earlier in v2. Bernd, I’d also be curious to hear
> your perspective on this.

It is certainly not something that I would count as priority. Though I
don't think it would hurt either. In the end we might be able to run
entirely without /dev/fuse IO and threads and would save a bit resources.

@Li do you see performance improvements with FORGETs through the ring or
could you post your underlying motivation?


Thanks,
Bernd
