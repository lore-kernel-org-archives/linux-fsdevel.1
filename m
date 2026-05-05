Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2528848C8C7
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 18:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778006699; cv=none; b=uaxO83w9ICoaFS+A/BvUd38Mbnd03/tWoH37in9OGujD2IFxboFdtHpCyl7rGmHRvKVWk7yrAEkrgQJ/VPanOCH0uuvt2s1tbl5JEwV1dJitwHtLf+Qp1dU+pDpMkRVBPAxdSE0m+MBbkg5TB/mndgQhrnLB+zke7M0UMXjL6OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778006699; c=relaxed/simple;
	bh=z33C034Xv1pE50KXnhQwPCIV38WccmPzhD5zLRERnW4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=fYx3w58pSP3mviBzTOQz5jNSUK5OxneC8nwwBzxsOU//f5RhrFJ/bucO9P1YbpJuv/EsUqNNkc2im91MDpyn4KVZ77MO7kIIBYY6xZicz1gIcb0q7AKcpBHdAyxoEaecdriCl+WXn+a+BADeLSLOnRDK4Zi/YAr0WgDP7tzt41g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=TlBcPyfA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8Iisrld; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="TlBcPyfA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8Iisrld"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4786E7A007D;
	Tue,  5 May 2026 14:44:57 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Tue, 05 May 2026 14:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778006697;
	 x=1778093097; bh=z33C034Xv1pE50KXnhQwPCIV38WccmPzhD5zLRERnW4=; b=
	TlBcPyfA0ePM0KAhoozkmmb/AyhG3tYe0KqPBnRo553tr91FDj6Y7rXwElYg6+ti
	V/F/ylGAqOLFQali1c5Za4RMWSpzjIJn72kLGPP2XnXsT2I+exbIx6HLijkylHQf
	YPT/JGAJ2kGJ8WKpnxitp3dtMNk3H4hdetQbpRRroyfj8SC1YRZ4r4gzQ6aIyi2X
	f2XjM0U3ceIIpc8lr3jdZg9os1Ux4azCKSHE+MNVlcysFdNCJ1N9qkSH7mULQmD7
	KzEo1ExbACaNly2HivePb9r867YDWNBL1lFhE3eEooZAH8/aADmnXpcc0PaEawqo
	szREzytGVfEcs2uhmfF6UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778006697; x=
	1778093097; bh=z33C034Xv1pE50KXnhQwPCIV38WccmPzhD5zLRERnW4=; b=D
	8Iisrld4Det/zh32ASWlC2876Mkm3bszugDapLttxtLHylMX7N3aNvBRvvRTqVb5
	6LvmQPv2jfPmDFnIrWiExbKlbpANP6BoxJBsARt96oBQZ+lCTXiHj5/u+Uy6jQc1
	g0Q4lmbXyhiXrUdM3y74HOa6Gkvfz5puYpMrCUDvlHaLXM+7+QC9pJ/Ipm7fBkIQ
	z9b1BnwMns6PiZM5zAxjnGlnsw1FUg+uqDX+DpPKotpSeccx5gEFOU1UrDSeiRbj
	G9OaQviwOKeF5ma7ZkuWJRMOD1XoorVVvR5twHrITNHcH3d+UGFr4sSUYjU5AlNG
	0KFj3iKwWPl1THkTjjw5w==
X-ME-Sender: <xms:qDr6af_A6d1q5H-cr6P5AkLeck2z3nwPV7DPkj5ZFwhitKL63fhttg>
    <xme:qDr6aWgaj2g40wnK5UfPKVJmCCty0n--WSFTeIfionwHZumRO25Cq2doy5X2xk1pA
    5O6kEGpE7YM7KTY-TUGoaFvILz7YOhZbM3G1P7fm3nFT1MkBEoB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutddvgeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfveholhhi
    nhcuhggrlhhtvghrshdfuceofigrlhhtvghrshesvhgvrhgsuhhmrdhorhhgqeenucggtf
    frrghtthgvrhhnpeffjeeiffevgfeiieetleetfeegueelveffleefudelveehueejjeeh
    keekfeejueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfigrlhhtvghrshesvhgvrhgsuhhm
    rdhorhhgpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrmhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehhtghhsehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtohepvggsihhgghgvrhhssehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehfshhvvghrihhthieslhhishhtshdrlhhinhhugidruggvvhdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinh
    hugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:qDr6aVdRTvUfGifRlaRtsK3Nq3XHTo6XOeRMdjPvrA4eKOeF6aChHw>
    <xmx:qDr6aeLq0Mz4rzG-2-TNi2XIeBvcOi2O--ihl0AMME5UmszymF-9NQ>
    <xmx:qDr6adiEW3oqgWUlEKcu6KceLE4LpmbG6Mh-0ptflZ-aH25xKW6img>
    <xmx:qDr6aUSkPxiuz05gfK0ce4ATvJrwxCZ3Ii5NNqYswyGcIXSt6vLkCw>
    <xmx:qTr6aW3Zhay101_ijdRTwa6hY3g7rA_rb6e4Z4pdn1xtwlpNKyRzlqkS>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id AB515780076; Tue,  5 May 2026 14:44:56 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AMDuz2u8DR1N
Date: Tue, 05 May 2026 14:44:36 -0400
From: "Colin Walters" <walters@verbum.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: "Amir Goldstein" <amir73il@gmail.com>,
 "Christoph Hellwig" <hch@infradead.org>,
 "Miklos Szeredi" <miklos@szeredi.hu>,
 "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
 fsverity@lists.linux.dev
Message-Id: <fcb47ece-926f-45d3-b2f8-734714c462ca@app.fastmail.com>
In-Reply-To: <20260505171827.GB2291@sol>
References: <bf0ba588-002b-4860-848e-e806b193840a@app.fastmail.com>
 <afXCoGk2Bu9rBKvJ@amir-ThinkPad-T480>
 <7baedcfe-534b-49f1-b00c-a8280c2703c0@app.fastmail.com>
 <20260505171827.GB2291@sol>
Subject: Re: overlayfs: verity validation broken since f77f281b6118
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Tue, May 5, 2026, at 1:18 PM, Eric Biggers wrote:

> Please do a fix patch first, and then any cleanup second as separate
> patch(es).
>
> You'll also need to submit your patches correctly, otherwise they cannot
> be accepted into the kernel:
> https://docs.kernel.org/process/submitting-patches.html

Yeah, I kind of intentionally was not formally submitting the patches, just drafting the shape of fixes because again they were more "generated" and I was hoping a maintainer here could pick up things since this is a straight up regression, not a feature I'm arguing for.

But anyways to get things moving I posted the first patch narrowed to a 1-liner after I noticed we didn't actually need the copy_up change because we could rely on the side effects from `ovl_ensure_verity_loaded`.

Posted to https://lore.kernel.org/linux-fsdevel/6630d44f-967d-41f0-81ce-6958b371465a@app.fastmail.com/T/#u
