Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A0722689C;
	Wed, 29 Apr 2026 10:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777459683; cv=none; b=HfUVIx4X1UevcRlL4D302kYl+08rVeNE6Lz5cN3zz6YgLv+4Clw2N/vdUapMQYQ2o0t59yAn4VtzjhddYL1ikc/9BCpRPqRKFZFV1+4iDgt7VwBxH5b2KUCEGSDDkH33B2da4x9XB7SiZ4SotEYlUb6A7NKZI1w1gd0IVoXxzlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777459683; c=relaxed/simple;
	bh=MsbePdaSOZSWhcLNDyfvIX49Q7Ciu15kMm7Xm8axK0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SJwllwtzV0W9+4QvUOHJi05tagmW0airUEr9vWakiUkogxLJCqDROTiFc4Y7zQvjtigorcxAWVrhE1kWu5cf5RkVjAbxD76MkNidQ+ucSMifaT04lwVAUNHY42LFjreWo/gJ1MlPlz0opFsuOIj7hH6r1J+73QRJmb9fYch3pMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=tGe+ioCu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QcsBEh94; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="tGe+ioCu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcsBEh94"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id E2346EC0103;
	Wed, 29 Apr 2026 06:48:00 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 29 Apr 2026 06:48:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777459680;
	 x=1777546080; bh=uQurXgfJba0k0pg+m/blgsqDrbsgGA4JRRrH5Kd73kQ=; b=
	tGe+ioCutFtD2MVq/dYQ8VXPzmsBq9VUAeRYfkT2dCXEj8daS8MwgzQogKMW8Tzg
	JBnTnA9px/02NyReIxWvFgV/ZTqCwwcn8xu8RJLODesSWyqQn2oDwfRCuo2TLKAH
	glonbBKqBx/fDWdC6pBNeTTLVcxOBA3oYyvfQBMHkNcMrURr2pMAwKMv+Z7qejjr
	o4Vv6ucBWZAYf1KvrAtaZKv9KiHjfFSEM8NCAaMkLGjaBWoRfd4lmx9MNO/39KTZ
	dy/f5yerTDPalzsJhNxrNkWS24JfX9bEQLs3koMCiVdlXP2y6fEFMPwVBOjs+k/3
	wgAJsCIs9zjXz211XsB6gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777459680; x=
	1777546080; bh=uQurXgfJba0k0pg+m/blgsqDrbsgGA4JRRrH5Kd73kQ=; b=Q
	csBEh94iRhc3I3ja4sBeTwX9etoD+sEktLxrixGyQjIzju3VlwoX4V2C6DAbKAob
	kIJZ3AF3Eq4/ScrK+hz6/L9Ingn4zFaQRtmAwnCKg2APzyLpaJiIa/8jG2dRCNrY
	laYgdmdPZ6iu531RW70lrpSUMHMya/YDe2yBanJni42KOSo3VxpMXj848ImYzjRF
	UJj/6bl9+SYo16+tLv0vfJEhBQ7aXVOOHiTH2S4KD3bg+EQSsCQasl2Bfa4BpJjf
	PwLhZ4BJR8H2UhVgGIV1ZHqPmQa8OowPmLkDLBhfpN8V67V+tHwUSjcRiqzQl5Rv
	ZPIe9ebU/xpRJNj5qq1ig==
X-ME-Sender: <xms:4OHxaYDvXzMZUClDnqXW7IdlL5XCF48FDf0gljHBSbHSz_8vVj9xlA>
    <xme:4OHxaT1p875AxonIpv7HAM__sN44Tbd8ElsIdOLoEekRM9UcA4WWtiCG_WU2KtZRk
    tvZB5GZmDfklSkKdQH7vb1aJ9PdvRXsS2ItOFyw-cCwvIOOZOscSg>
X-ME-Received: <xmr:4OHxaS1s4k5dXyC0umuHEqv5BkXQChKUVZPm4Mot33yhqoLVXudo6KYp3hXPzf1EHW-i9NJgK_kf9kot-3vKQ1S5EpwAOMqWXfa8qdSVuUKUhvxfEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekgedvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepuegvrhhnugcu
    ufgthhhusggvrhhtuceosggvrhhnugessghssggvrhhnugdrtghomheqnecuggftrfgrth
    htvghrnhepffejvdffjeegfeehiefgffeihfetjeelgfegkeeuveeitdfhgefgvdffhfet
    tdeknecuffhomhgrihhnpehfrhgvvgguvghskhhtohhprdhorhhgnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugessghssggvrhhn
    ugdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopegsshgthhhusggv
    rhhtseguughnrdgtohhmpdhrtghpthhtohepmhhotghhshesnhhvihguihgrrdgtohhmpd
    hrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4OHxaQCcRFIzf0CMXEdxe-1YIbq5WTlv0muVRqvtYildLs5DiHiMMQ>
    <xmx:4OHxaZ7iZontwLq9Bw4IC09sO5o-sxeV6Tl4udSVStD0mh1h957uwg>
    <xmx:4OHxaZJ13tzGzX79TTWSAIxBmDIyVPoPUb4qmWcB931QQuxUsGuLBw>
    <xmx:4OHxaSsXNdIPv-AchYvY6WcHrfS1TXTec9a3hqwjvC2lwDTWuIgNyA>
    <xmx:4OHxaShCTGky-ta6xHKzG1Uh6EU7II1u-LhPbzMU-lM3KSnt3zbF6NU7>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 Apr 2026 06:47:59 -0400 (EDT)
Message-ID: <977f4a2a-5337-449e-b34a-68a128a894da@bsbernd.com>
Date: Wed, 29 Apr 2026 12:47:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fuse: back uncached readdir buffers with pages
To: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bschubert@ddn.com>
Cc: "Matthew R. Ochs" <mochs@nvidia.com>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Joanne Koong <joannelkoong@gmail.com>
References: <20260428233028.2747981-1-mochs@nvidia.com>
 <3e889026-de19-4238-ad5a-6d7b31845603@ddn.com>
 <CAJfpegti_MFgBie0=gX0RfZ7yQTtfzUMaUk6o+qunO9cuOeE4A@mail.gmail.com>
From: Bernd Schubert <bernd@bsbernd.com>
In-Reply-To: <CAJfpegti_MFgBie0=gX0RfZ7yQTtfzUMaUk6o+qunO9cuOeE4A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/29/26 12:38, Miklos Szeredi wrote:
> On Wed, 29 Apr 2026 at 11:29, Bernd Schubert <bschubert@ddn.com> wrote:
> 
>> Josef and Joanne had spent quite some time to allow to use large folios
>> - maybe we should make use of it? Attached is a totally untested patch
>> and that ignores all of Miklos' comments for now. Also cannot be that
>> easily back ported
> 
> I'd be happier if the VM infrastructure for folio arrays was available
> first, then used in fuse.  Not the other way round.

It is only the the missing vm_map part for folios? I had found a patch

https://lists.freedesktop.org/archives/dri-devel/2025-March/497993.html

and added the comment therefore. Maybe we can bring it up with Matthew
or someone else from mm next week.

A bit a pity if there is generic support for large folios and fuse
internals for random reasons then still use single pages.

Thanks,
Bernd
