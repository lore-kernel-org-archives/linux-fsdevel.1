Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150703F54B7
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778262621; cv=none; b=ul1XoFztsmDwSdxHmr5hcS8UmXyUFKJ1exbZADD9ZyC77FJIOc7yy8S80hTbhCfwUrureTCq4ouH/eKBq38Nfl6c1u/cW6WNq65rFjCuo9qzPBE1JcDIFars7khFHW6qWXA3AjlfP5J2IYVPmmwqtSU5XsIpa1/BRvuKQx7LvZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778262621; c=relaxed/simple;
	bh=QlNREhgjSj6RkXr9LSsqPXzzAgrQh/euMjY5EgO+PXA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pyig5cffXN+B8ov+6vzAyVNru6VAAL4ko6xXGTXoXGR6wuCT7r6X7w0JabB8xaVnd2srEcxYiBVidg4y1sO0XPy2abjbh6mrhYYJHShvQliuaipEtCEneSRF5VCl6uPLlxJKX04Jik00hqcXR5iV3+g8to2sli6B+7lW8p6rbYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=MCa0gHc2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WkelCjVZ; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="MCa0gHc2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WkelCjVZ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 46FC01400157;
	Fri,  8 May 2026 13:50:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 08 May 2026 13:50:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778262619;
	 x=1778349019; bh=YtGGVd0F6RwRKCRnKXnUPtxjAHt8xRwvk2NFNRkgUc8=; b=
	MCa0gHc23XoejOg3G5iavczGABv0++ZfJBMp9VULkoR+g+TXemG5Cbujy0GQnPMw
	BFqyinVs4t3U2zT4dPcFuY74pM1g2cFBEqY6KmyYub3LZNoVcxBqME57jcnBKKUV
	4Z8tO9AowDVKCtR+Y84u60bI3i3FImba+peq1wKQ83DzOaXUzgMGE79wU+HA/mts
	WtDGiWiFdaLCK5zpA9ADNDF8oCe78bS8UdQy93T2sgDZerJ15rtU/Z5MSSUjX7Nl
	U4g1FgwIzXt1Yx8/sCFOZrD3F1oIl9acqya2iAN1yu/xhAma3nVjXkHMNLt69qKi
	otUh93QDXaRBvHqTZnmeig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778262619; x=
	1778349019; bh=YtGGVd0F6RwRKCRnKXnUPtxjAHt8xRwvk2NFNRkgUc8=; b=W
	kelCjVZ+ZZ6i09I6BLqP1pS7tvBPgEBYwuQqbJqQQK6LTTA5REsN8gEzgI3e3olK
	3zI5pv05Fbfk5q8KS9sE7oUu5XaPmxDzL7qmQwpTkWTMzYjQOUN06nKwm30AHGbr
	+ZhwSTHcbzwszAg5WFgccVSwzpU+YLNqj2KksTFYqMkOy5f/+OHhZmJnlKVIGtBC
	T91G6FRLHXzog2F9rK3p24Nhi40J7jsE8Yl6hVeREmDrN2jHY0bJbtkXSGn0HEp1
	10ihPjO0/HsvMFMxLbVcLCetz4p7uIROFupcZH80pykkbYUn/+F9MAWl8eaT3rKI
	cITUMA04P/4i5M0z+Rjuw==
X-ME-Sender: <xms:WyL-aYlVO0Gnzs3iIxKjZvY9l-l5jKqZgsF1mwdsad0fs9HA-NNZFA>
    <xme:WyL-aRLxVaEk54su4noOlyekC1o0OKznYtbQ_q0KoFFdcxh3VJF1SLWNc4PFuHqWK
    wYFghfUZHvGpjT0qR58ulD0hElJrm5-CKkmnI5VAeGzVoTOBfNA>
X-ME-Received: <xmr:WyL-ad6fOyfQwKE3ZMD2r0QoZzNdDsLHJSXFMgnZ7-CKCxxaVi9hS0BUPVQme2y5FZJD5ST8wVndJxkmSjLpCcBMBP63a4R5dDw7an7SEXwPHNb7aA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpefgtdduheetudejleeuieehffdugeejvefhkeevgffgkeeitefgffeiffei
    jeeujeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhnugdrtgho
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepug
    hjfihonhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghr
    vgguihdrhhhupdhrtghpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuhigrdguvghv
    pdhrtghpthhtohepnhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtoheplhhinhhugi
    dqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:WyL-aV2k3LkkvlwEPLDXc-Dmu0MPDgNKUNBQej3pUB6izOCd3VxSBA>
    <xmx:WyL-aTcAYpgvHWSSDPb29-H43gl-h1W80Sm8YMRrqM74YsdojV8TLA>
    <xmx:WyL-abeFbdEyXvnC3eqgUHCG3FrotVPWMcDvmwEzWKz06KrXgiJAKg>
    <xmx:WyL-aew0vHO0lC9RXqLPynMvf74TIC-7DYzkiVvzXQLCJ9JJOEmpNA>
    <xmx:WyL-aS2KTsdLGLasPMNUW0CWRV5FagEBvpE0auDQGxk5yRbFyqZ8Zx3q>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 13:50:18 -0400 (EDT)
Message-ID: <7742cf2b-169c-40c3-a4d2-c8286f3cfd74@bsbernd.com>
Date: Fri, 8 May 2026 19:50:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHSET 2/2] libfuse: new mount service container fixes
From: Bernd Schubert <bernd@bsbernd.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <11a04b4e-db8c-423e-a351-e7fd2a8bcc7a@bsbernd.com>
 <8c59846a-0e7e-4366-a8ec-206f5684284a@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <8c59846a-0e7e-4366-a8ec-206f5684284a@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/26 19:12, Bernd Schubert wrote:
> Hi Darrick,
> 
> could you please also look into the CodeQL reports?
> 
> https://github.com/libfuse/libfuse/pull/1444#discussion_r3144133589

The GUI allows me to click away issues. However, would be good if I
wouldn't need to do all the decisions on my own :)


Thanks,
Bernd
