Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443CF3290B0;
	Wed, 18 Mar 2026 21:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773870742; cv=none; b=entpv+OwqSMjucDO5hsE1tLme9EoZuKO4B0btelQyz+vlQl7N46ORjjpJUqoX1mykZdWkWRYUE2idYLIIi1wx93veybV9g+reaeOpmpRvoLrlJQ5w8mARE46ue3QHCBlarTE/M8qn9wA7YqyZnnfoR4go5S+CBsaO1vGyCcO8gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773870742; c=relaxed/simple;
	bh=HkeckDnH3fZ4gShLHqNx0P6q83ACFaXFCeRW1MYKUUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a3Xd6n6MU2pI2s79afjHv5E2CPm41JF+vaq/Kz99HhEwgd4DbqgIvJSagirndgi71VubZ36cPFW9kW0/vna6MEBMpP0bDxgWv8TD3MBAQUT47dxzAcK6qQwwbYTe4b1RUXi0CoUeYljj256khjHtvEKi6Rycu9q7ijOFocKgyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZpE+5OpS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6G5ZRKC; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZpE+5OpS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6G5ZRKC"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2AD1F140019F;
	Wed, 18 Mar 2026 17:52:19 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 18 Mar 2026 17:52:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773870739;
	 x=1773957139; bh=JR18axGOe0+5cGvnEDIXBD93iP2BcBuzflhrF3rcIpk=; b=
	ZpE+5OpS+w6DzNiSjx2Bn+GQ9w0FCiBSLW4SQM0LyV9nNzqJthlOLQbHORZ3GRnm
	Wk8xSRZiWNyA5NkGxBAM8mF7qWq29DJ5ia1XFvhgRhFQYhu0UUdp6D5MOfnbZwYo
	a4UnmoCTsanoWJVBhuI4hvRuzIF2UULYwwOgexgBp70dQ2zx2bd6CR73oYgayOyB
	aRgEpDV4fa3yCJQ61AabPDUm1hOXGGaM2nRXsMlx8cQ4TXoz55SJND0Fkp0go/9u
	vkahy+aBChd0IeMZsXjxD5qbk7dtF4Dq6F6si7EpOtiuoNVVd+taqPvJjlGNazoC
	A2oVgh9CgS+0aOGvzhiFug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773870739; x=
	1773957139; bh=JR18axGOe0+5cGvnEDIXBD93iP2BcBuzflhrF3rcIpk=; b=h
	6G5ZRKC+ENKWyUiuRD4rWmWeMW6rSgklEgspSNoGoylr+w7LehrfUCZws2xE0FJ2
	UYRDtCUOLv6OXO9ju0g4N4V0gJX5KOqUl1NWHBlGq3oLD49YB3MrKs+KNaXu15dE
	oj11B7ZZdT5uCzc/7DMVXjhaQqiruheHICvlcEctqsGytaXQedHDDRQ5KqluqqsM
	+NT3dfnkAVrNYJaPqYjVNL/1qsfKt8DA5xbetuI+I8SW90AxQXKTVA7zVPuy+bw9
	C7L0PENo0Og9po97+B3b5h7lSlJrV9WgLLhV6vC4tOKY7iUg8e1M0vP9/FblzPV8
	PJDb3NWiqhSCZ9LnKWmGw==
X-ME-Sender: <xms:kh67aaAFeYE1Iy33UznSnXPhwsVvOXC858DsM-7lm5vbqkim_X7RVQ>
    <xme:kh67ad2UAq_geLj73t53ep5wA9cULVYTMegIo6BLqa5qO1eEYs0auFP6cnrWwkAK_
    o0g-93FF6fHiuwyKiaqXg49sXTqukZkoMKfhrVDzZShEIet3QbxTQ>
X-ME-Received: <xmr:kh67aU2_CR5pX-KJ6duuGM8JzHqCahBraNFrF1AFaAgK16UTgOzQWlCm7BaSnSTod8VgaPYp35GtNns-DfdIQfmsjD0Y3amwu0pOXXPHm8Ja4Wen8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdehvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeefgeegfeffkeduudelfeehleelhefgffehudejvdfgteevvddtfeeiheef
    lefgvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtg
    homhdprhgtphhtthhopehhohhrshhtsegsihhrthhhvghlmhgvrhdrtghomhdprhgtphht
    thhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfh
    hsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhig
    qdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhsghirh
    hthhgvlhhmvghrseguughnrdgtohhm
X-ME-Proxy: <xmx:kh67aaDAMTxo5tE4ijrTdxBtSejXgFwRQMosgLWq_H0WhVp764yFOQ>
    <xmx:kh67ab46x7XYYM_nlEl6s05w7eEVSHOhY46RQ0Ww9Jg3LgkQVccs5Q>
    <xmx:kh67aTK7kE4vIpEcSYT0w_7Qvd3bSRxf-mpkkxDtxPSTcTX0BtaOVg>
    <xmx:kh67aUt8KlVoOucciCVeFkT3WDMoQzVi0B29k47zy9KdCL60c0h8EQ>
    <xmx:kx67aTy1cFkTWgn_C6R7HN8Omuk4jQzX8CI1E98DcK0S3Qm0lqD4gAlN>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Mar 2026 17:52:17 -0400 (EDT)
Message-ID: <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com>
Date: Wed, 18 Mar 2026 22:52:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: when copying a folio delay the mark dirty until the
 end
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>,
 Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box>
 <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box>
 <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Joanne,

On 3/18/26 22:19, Joanne Koong wrote:
> On Wed, Mar 18, 2026 at 7:03 AM Horst Birthelmer <horst@birthelmer.de> wrote:
>>
>> Hi Joanne,
>>
>> I wonder, would something like this help for large folios?
> 
> Hi Horst,
> 
> I don't think it's likely that the pages backing the userspace buffer
> are large folios, so I think this may actually add extra overhead with
> the extra folio_test_dirty() check.
> 
> From what I've seen, the main cost that dwarfs everything else for
> writes/reads is the actual IO, the context switches, and the memcpys.
> I think compared to these things, the set_page_dirty_lock() cost is
> negligible and pretty much undetectable.


a little bit background here. We see in cpu flame graphs that the spin
lock taken in unlock_request() and unlock_request() takes about the same
amount of CPU time as the memcpy. Interestingly, only on Intel, but not
AMD CPUs. Note that we are running with out custom page pinning, which
just takes the pages from an array, so iov_iter_get_pages2() is not used.

The reason for that unlock/lock is documented at the end of
Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well we
don't have that, so for now these checks are modified in our branches to
avoid the lock. Although that is not upstreamable. Right solution is
here to extract an array of pages and do that unlock/lock per pagevec.

Next in the flame graph is setting that set_page_dirty_lock which also
takes as much CPU time as the memcpy. Again, Intel CPUs only.
In the combination with the above pagevec method, I think right solution
is to iterate over the pages, stores the last folio and then set to
dirty once per folio.
Also, I disagree about that the userspace buffers are not likely large
folios, see commit
59ba47b6be9cd0146ef9a55c6e32e337e11e7625 "fuse: Check for large folio)
with SPLICE_F_MOVE". Especially Horst persistently runs into it when
doing xfstests with recent kernels. I think the issue came up first time
with 3.18ish.

One can further enforce that by setting
"/sys/kernel/mm/transparent_hugepage/enabled" to 'always', what I did
when I tested the above commit. And actually that points out that
libfuse allocations should do the madvise. I'm going to do that during
the next days, maybe tomorrow.


Thanks,
Bernd
