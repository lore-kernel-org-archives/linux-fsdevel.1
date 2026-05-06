Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADBB34A3BF
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 May 2026 21:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778103378; cv=none; b=KB0j3wkhxtE7X6xTOp8wbyhZNvsrtrfBy59PUC8pNjtQmIFQfbGq1ZefL0EbN7+Xjuqx2Apik6m3G0M0ibRliMOiRPq6PYJdtsNp63hOXzo+gw6U4vAM8G/c3eOnPlaAgX1sXE4CKGbbYjy7awoD9NhKHxqJGTTUgyvmvCqO+8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778103378; c=relaxed/simple;
	bh=g2gTSm0Xn06tTbWQMYs9+0zqL22HjasOMjUgnvdT3OE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=H4EU6sQFe5DPzLHkrJxYZCaeB4iYMVKm/5ndRaVg587m8fEXx6KGJfg8x7lbPqcLUzjTjMAbwLZMs1ScRd6HYGzjZYBMx4/rd8PpGYBgNzoyt2xLsjihKg9iqYfyAATREYL1hKl3uviVhujHgriMG6wDfqmFpA+/kz6aRtnDuvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lgRmXONr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPcwi7+H; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lgRmXONr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPcwi7+H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 73CF7140009C;
	Wed,  6 May 2026 17:36:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 06 May 2026 17:36:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778103376;
	 x=1778189776; bh=2i+OyQS09XZNh69e+3fgbxGfkkFN3izUXIbJEUWyssw=; b=
	lgRmXONrmb2h20/WtuocCHbZU9KH1T+AOaNuDjDPXjuv/EFpacXcehB8LuTubRTi
	T2vfBcpHJc0EzoG8fUpQqbrq000HH9xuglzTWZqs929lUouRMQoQaDob2AuiasIZ
	Vku6h8BrjJCTZb3J2SmjO0yQKxSaVWlgDa+HKxU3gpKU43bv/FZ/9qkSc7J69wF3
	39w9sRfoaqvUEW3DwI67oi7QlaTMLukPmCON2Ji1XQTdIMOTHZpExG8h9bS1JKZS
	sd1hmNxYsAAGtVC6xqmn/9NPMj95tsKWaiK98qASb3zcUnucPQmazAR8xXL457hz
	vvbI1x+Eu9eo35Cb/yxyoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778103376; x=
	1778189776; bh=2i+OyQS09XZNh69e+3fgbxGfkkFN3izUXIbJEUWyssw=; b=F
	Pcwi7+HEwfEiBfprBBCHe7Td5cKw1Mj/7xBUQ32S9vedehq/MfIVueoUIqNa4efF
	ZlaTVrvUunJZSoAdqY9vv7ZV8Ok6nqC97gGVnl5NPfDpcHLmzlFkluUbkDDsYCvZ
	FGhyqE4C+GWYkg+QsGP2H0moDZu7CojBG6BoMwnq5to31LBBA+evjcLKaSgeT9iq
	EKea6lGtd1GUdjNBJ2e055GN5JN9RcdDNcndkZojna/wMYXKsBjnlpi65SnszZB8
	4lx0H012xMXJU0t9ywRvUXkyYzeAk0L1pSz+RY/2z/t1WWqoIdbGolgH8bm7frDD
	ofOss39uh9M50EtmXFHcA==
X-ME-Sender: <xms:ULT7aUOZPNprmM2JqygFX0iKvwH-wpT9pfvADPRL0pk7dYI4-mpNCQ>
    <xme:ULT7aUTjMKWfyHhCuP9wRtxm1BJSaDdfWv-Fuux96G68nLgfUW0KErMDWTDVcrTXr
    KZJ-8D2bxojeuv4rUSEB-NKCnt5DWQWoIcVp5U6TK8fZdgCYb7uDw>
X-ME-Received: <xmr:ULT7aSirJSMpDQ1DU1j_2sXBaXA_XKv4a6ObQCgPKRM4PmNpWEtSapW7uwvmlmJuqRMBirNpEYJyQQgfvBNlRu7VhtFYml-ccJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdehieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffhvfevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeelleegudduueffuddvteegffehudeuieffledtudehkeehffegteegfeeh
    vedtteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhu
X-ME-Proxy: <xmx:ULT7ad_u39ZxMXZk0ZPWPlxzVDiS1ktjpDnvHdBMQlLKyalC_pmpzg>
    <xmx:ULT7aZGFkVPo-b7nhX4I_hWEpaWCHl3mz_tZQuU0j2Co6UiyaEnCOg>
    <xmx:ULT7aQkpcDFUkUwNmD2Wu9g8NOitKGFlk1KxI1fxn-JC6CRL0L4sLA>
    <xmx:ULT7adZqL18ndDeTHt-JwvI7b0NlnLeTrUTrnWa8V8n9MoGU-mOarw>
    <xmx:ULT7acdJO0Qdlp8kGwSdHgmaix4ks-yoM288iCQz_4TXm9Q5xxlsp8hg>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 May 2026 17:36:12 -0400 (EDT)
Message-ID: <39b1d822-e198-4f9b-8469-9424f165979e@bsbernd.com>
Date: Wed, 6 May 2026 23:36:10 +0200
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
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <20260505052133.GR7765@frogsfrogsfrogs>
 <177795853647.1133612.5178638086120838710.stgit@frogsfrogsfrogs>
 <605ed94c-82f8-430f-b753-99b06eec27fa@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <605ed94c-82f8-430f-b753-99b06eec27fa@bsbernd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/6/26 23:27, Bernd Schubert wrote:
> 
> 
> On 5/5/26 07:23, Darrick J. Wong wrote:
>> Hi all,
>>
>> This is a collection of bug fixes and cppcheck cleanups for the new fuse
>> service container code.
>>
>> With a bit of luck, this should all go splendidly.
>> Comments and questions are, as always, welcome.
> 
> Hi Darrick,
> 
> do you have by any chance a branch I could pull from? With PATCHSET 1 in
> the same thread I don't know how to handle it with "b4 shazam".
> Alternatively, I'm also open to learn new b4 or git am commands.
> 
> I will try to review it at airport or during the flight, but would
> reallu help me, if I could just get the patches into a branch for
> offline processing.
> 

Sorry, never mind, just found the pull request mail. Thanks a lot for
that! Pull and pushed to my github repo. Let's see how tests go :)


Thanks,
Bernd



