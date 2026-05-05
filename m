Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6372DECB2
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 22:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778021711; cv=none; b=Yhm63wRFrKyuPw83U56zF1vYmIXJl7RsCP5VL5t/Azw9//tsk94glXw3eQfNnG9v2efbZ/qW2edEswPxlwKdIYV3/97qZO5t8vGG2/WA3iuVQU7NLwSSaaV+eARQ3MPfw8MLzH/0oL7PcAIqq8UDnswlCp9PUM9NBPktOa6+R5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778021711; c=relaxed/simple;
	bh=rXaq262EIaXvlHwog0rO29MDBPIN4a3d8ONbsbWTplw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIOKUxkrokVECXqybWjZ7QOm6fCGSpo+6C1IB5yCs5tFjGrQMSyrFjH0vpveo+fAyCjqBAds+4Dqmz40Bk5cSHsBRH2qSCdbAeVseb/yDW5YtO0QgBpuG1wGjVmFi/x6pgTy15Q23Hlc2qlJkJvg+JbSCmL/8EIYv928u89Eu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=gtUlfVZJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WUG5GFsR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="gtUlfVZJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WUG5GFsR"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 6B609EC00A6;
	Tue,  5 May 2026 18:55:09 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 05 May 2026 18:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778021709;
	 x=1778108109; bh=nzwVZbK4/JO/6qOUwsgLKouMJRBm5PTj/fFVZN152k4=; b=
	gtUlfVZJteAd9o+RdKxNuIARSli++0to5gJn2hRXVNjqLfokchwwbGT4xIofGJ14
	q36qmFkAnkTwPIxOT1AfuO8mnTsVlQgOcg2d5yU3OryxW9+LQ4EgXAYIyf4O0C3E
	dV2xisyT7eN1nIrZzJDZqYIHpVnUYpyjNjdZLp+UCWuh4BF7NkBt5RJV6IXCq07f
	k4aePAWKfE8jsoAsR+L+IKXQD7iUm0QjOdMftR/8Urzhe0YKOFx5xkheEztafT3A
	ohuxc6unxw9FkPREK0keLr7ny3GKq+uKRDrIPO2XnV1voog/NbqslTsK8/s49yUi
	NugGiaD3DNSx0ugkC5PZGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778021709; x=
	1778108109; bh=nzwVZbK4/JO/6qOUwsgLKouMJRBm5PTj/fFVZN152k4=; b=W
	UG5GFsRmI6HxLvTrbNPq5F9sxnujcWWvPO3G6UqlgZgfRgLNX7H9cWB0h2gvmgp8
	Y/iic2s3jZ05+c8/IKR84WYjXGMfAT3m0Yk9ZmDoudSXsi0loHxWqYjMwYt2OooA
	crKtgqHNVSraeb92a659hVrXyDB2lPPPLBzZpN1AM0LHCRWl+VeCeYJVUBIWOS7C
	Ku1nB3A0134gkYJ4nqnhisApCBJldnkcvZzrj8CBORnaRs3WSrP76ysHTisduhT2
	i71nogXSGMSsiVDvBdV2t3ds8hWeC8j5zVaomOOxRqzVfB7B7H6veaMhG8fHp+Y4
	ZceiZ0Dr3dpMYhJlas0dA==
X-ME-Sender: <xms:TXX6aWcM4WDLfNu_t0iSd8dHybmUDzgrJScnlCW0JUXuWyG6obj6Uw>
    <xme:TXX6abtk_dQwshD4XNMWJXmzplA1ojWNWeagWGNxwvmwvWUaIiE5Tf6oCuMiQzxNy
    BFSc72od44XLiP73dabs1FYq09gicltQywj-Rzsk2eOrO0OdFUw>
X-ME-Received: <xmr:TXX6ad8PaeS0RAMGt8lb877uQUNYaTPSKMtI_PFrxZhaorFdkF7R90FyZngMVU6PijJhyFRENYxKQ4TSGkd_Da1UO3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthho
    pehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheprgigsghovgeskhgvrh
    hnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TXX6ae3Yp91knGG1ZpfDVaDx92MRwy2BRk4nR_T8RTlNsFssV8vTWw>
    <xmx:TXX6aaCk1LFVN-EVnIKCy77lfs9IUS48LBCGnY06t-YADJqwXjBl6w>
    <xmx:TXX6aScgK50NX7XvjwczaobZnH5Y3K53ijxtKDkOZc3E6e-s58ecnA>
    <xmx:TXX6af77pBfvki9SkrC-Ybjj8b1yNVIJaoPkRYU_6LH_1zQLYnXZqw>
    <xmx:TXX6aUM65bpyhLg0Fj14pKZPELP4tC9PmvGTQ_c-vDBCKzKHdEWKbzdU>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 18:55:05 -0400 (EDT)
Message-ID: <44675f24-e7db-4d92-a7ba-ce2a3c324f59@bsbernd.com>
Date: Wed, 6 May 2026 00:55:01 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] fuse: add zero-copy over io-uring
To: Jeff Layton <jlayton@kernel.org>, Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, axboe@kernel.dk, linux-fsdevel@vger.kernel.org
References: <20260402162840.2989717-1-joannelkoong@gmail.com>
 <20260402162840.2989717-14-joannelkoong@gmail.com>
 <08e937f488a261d7bd3684c0db8d517a1f33422e.camel@kernel.org>
 <CAJnrk1asUJqskOidATL8SBFcgmWLxS=J93ekW5YdJdLAF1Jr=A@mail.gmail.com>
 <04f3c2ba632be1a36d4770ef4bda45c3e156fd95.camel@kernel.org>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <04f3c2ba632be1a36d4770ef4bda45c3e156fd95.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/30/26 14:55, Jeff Layton wrote:
> On Thu, 2026-04-30 at 13:35 +0100, Joanne Koong wrote:
>> On Thu, Apr 30, 2026 at 12:42 PM Jeff Layton <jlayton@kernel.org> wrote:
>>>
>>> On Thu, 2026-04-02 at 09:28 -0700, Joanne Koong wrote:
>>>> Implement zero-copy data transfer for fuse over io-uring, eliminating
>>>> memory copies between userspace, the kernel, and the fuse server for
>>>> page-backed read/write operations.
>>>>
>>>> When the FUSE_URING_ZERO_COPY flag is set alongside FUSE_URING_BUFRING,
>>>> the kernel registers the client's underlying pages as a sparse buffer at
>>>> the entry's fixed id via io_buffer_register_bvec(). The fuse server can
>>>> then perform io_uring read/write operations directly on these pages.
>>>> Non-page-backed args (eg out headers) go through the payload buffer as
>>>> normal.
>>>>
>>>> This requires CAP_SYS_ADMIN and buffer rings with pinned headers and
>>>> buffers. Gating on pinned headers and buffers keeps the configuration
>>>> space small and avoids partially-optimized modes that are unlikely to be
>>>> useful in practice. Pages are unregistered when the request completes.
>>>>
>>>
>>> Can you elaborate a bit more on why CAP_SYS_ADMIN is needed here? It's
>>> not immediately obvious to me.
>>
>> Thank you for reviewing this series, Jeff!
>>
>> This is gated behind CAP_SYS_ADMIN because zero-copy allows the server
>> direct access to the client's underlying pages, rather than operating
>> on an intermediary buffer that the contents of client's pages were
>> copied into. A malicious unprivileged server could keep direct access
>> to the client's pages (eg even if the client tries to cancel a
>> read/write, if the request was already sent to userspace, the server
>> will still have access to the underlying pages). In the non-zero-copy
>> path this isn't possible because the server only operates on the copy
>> of the pages and not on the actual pages.
>>
> 
> Thanks for the explanation. I'd suggest adding that to the commit
> message (and maybe comments near the CAP_SYS_ADMIN checks) in case
> others aren't clear why this is gated on that.

Silly question, isn't it very splice like? Fuse-server doesn't get the
access to the buffer, actually, but only forwards via io-uring. Splice
is allowed without CAP_SYS_ADMIN, so why does this need to have it?


Thanks,
Bernd
