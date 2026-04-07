Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1783B38A3
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Apr 2026 12:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564723; cv=none; b=OusKS3UZoPtnD/WRL5bS8amDfrlGG8t7EQLzKD6H/1hvcb4SbfolZ3SeX+r2bFLiB5NHAJ7+fEmkIAdzFCcNVtQnMkXjjz/vEFX8pMZyZEQecSVeHR3tMgG1Y650pU3BEMiBj6BIegk3N1INRkLNcxFMMAQlddPbdOl6RQPsIy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564723; c=relaxed/simple;
	bh=Z1I8AiNIdztZ5i7M8IX7ikH7L3FKfXQFedhn+wA/3nY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lFZ4ZgyTLWj3rqcJtpKcIGgQqupj0Zmd83YXx3CD5SitRXmXtXhxl51NIKq1oTqbi7RA2X6gPLmmx8/F0YL2QyLv3blMGqEwA/vjGf7nI2K6v2xw1C8fFW8E5eMi1byvLiN2uYMzK6Fg18VOeMFfJBO0yWTmaGv5kXNxEPKYtAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=HkjmiOp8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RLMsK1wz; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="HkjmiOp8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RLMsK1wz"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 29606EC04C3;
	Tue,  7 Apr 2026 08:25:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 07 Apr 2026 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1775564720;
	 x=1775651120; bh=IOykJSddlcVbwyy4pjAmoeSGvqWAMdhCcRvCHOL5RDo=; b=
	HkjmiOp8Sw2YqIgUjXEz5X4WN0WaUYQVdUkspWmPSJ7o8o7KZHg6sHQvv8VcF7EY
	0rORP9bgyqr7SaLliDqhJ1hZJqnjjt2FaBZbZl2d8yR53jCBRy3HjLN1ZK6Txqms
	qw6cwiPP+FW+J5lHqTX7tL3BfAtiH3ve9+0dV3T/0nZU4OZcD4EbleDych1n9eL0
	w2RQyKe61SEVuUNpOza048CbBMJnLLOS4W0YtUZUypa2kSqTnHruMGEiYnsRsqRY
	NZ47AU3nctV4u39kElMhnc6e4FVnVBb996H6ZTTDBSXsabj44Cb23/42SWC9Rf8R
	BZB1Ao04rvWkITv+ZE8I2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775564720; x=
	1775651120; bh=IOykJSddlcVbwyy4pjAmoeSGvqWAMdhCcRvCHOL5RDo=; b=R
	LMsK1wz7U/FgLNmVvAk5v+bgdTxMy3TFY1OUuQ7/SpdIOYCTgTKRxAR7Q9DYWXio
	aXpL3MQwXAd1B45MZIccxuy2t5Fqlaa1aiZ9I7r5a/CDAFth2USnMnYu07eEZDDy
	nh2bHlBRQlmH22//LewS46K/DUSk00VJq8RQdo94RzItrxtHks6Bs99PcMf2YQY2
	Hs64FNs1qRXvwJKkV8a3DZSEx9bOnWfaIXXokG3QVK5lrgU8C3dPJJAezEsjRiVw
	8uhXOCDvEJteYOge381n+fjSgaigWg5NvZ22u42F3A4ysTDcyP7TstqtqtlEGFA9
	IFsfo4fIIEbS90+y+3N8g==
X-ME-Sender: <xms:r_fUaYT5arvo8FOQ9YxrDXAm_Ke6ths3o2yElcCOm0DkwfmKs2UZrA>
    <xme:r_fUaYDZNmW0NpMiQSoTVYvmsL--HXM_O1Segmp6Go5lTwWfehsCMP_lk2S0FPgjn
    vouCYOPsa8qEsBhJciL4Rk-HBKNZ1bcZsXDmKQBlTsi1pV2MSs>
X-ME-Received: <xmr:r_fUaYF3B81Gmw-mANMx3EuLdbI9la4ldcMy5o9_x_O7P--1ENvASTvOtJZfadikO4nvNAIlTe6GZ7MU_UWRTquf5tU7GXEHWz0OtgTJRJ0R-6SKKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvtdeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenogfuuh
    hsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefkffggfgfuvfevfhfhjggtgfes
    thejredttddvjeenucfhrhhomhepuegvrhhnugcuufgthhhusggvrhhtuceosggvrhhnug
    essghssggvrhhnugdrtghomheqnecuggftrfgrthhtvghrnhepgfejffetffeiieetvdeh
    tdfhveeggeehueelvddtueetueelueekfeehtdegtdeinecuffhomhgrihhnpehkvghrnh
    gvlhdrohhrghdpshhouhhrtggvfhhorhhgvgdrnhgvthenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsvghrnhgusegsshgsvghrnhgurdgtoh
    hmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegr
    mhhirhejfehilhesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhfshguvg
    hvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhikhhlohhssehs
    iigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhnvghlkhhoohhnghesghhmrghilh
    drtghomhdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepkhgthhgvnhesuggunhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtseguug
    hnrdgtohhm
X-ME-Proxy: <xmx:r_fUaSA2J5nnOfH-fJgMa-e8kTCfT5JzRt2Q19OL7c9aWGV7TGNdDA>
    <xmx:r_fUaQWgh11KbA-3exwaQp24LiQyg8fXNv4JhlkCQmy3uZBoMiGyJg>
    <xmx:r_fUaer_bNmcwAFzkwWYbOMVyZdLaGoohOHEMcay3QqMuQJQWfQ5hQ>
    <xmx:r_fUaUSO58xP-u7eu0hCjbp1ri3nANwd9MRQy1Gzyc250w06SBADXQ>
    <xmx:sPfUaXu6ezKW6K2PRT6VSq6ikyr8umD4yLvo7JrlUlJlZWStFNw6bHGu>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Apr 2026 08:25:18 -0400 (EDT)
Message-ID: <c4ffec34-fad0-40d9-bff1-06c3cd202351@bsbernd.com>
Date: Tue, 7 Apr 2026 14:25:17 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: fuse-devel list on kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, "Darrick J. Wong"
 <djwong@kernel.org>, Kevin Chen <kchen@ddn.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US
In-Reply-To: <adTyw4UJ04qOggCQ@amir-ThinkPad-T480>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/7/26 14:04, Amir Goldstein wrote:
> On Thu, Mar 26, 2026 at 10:34:33PM +0100, Bernd Schubert wrote:
>> I'm taking Darricks example here and posting API changing libfuse
>> changes to linux-fsdevel. We should consider to create a fuse
>> specific list if that is too much. The existing
>> fuse-devel@lists.sourceforge.net is rather hopeless due to lack
>> of spam filtering.
>>
> 
> Let's do this already!
> 
> https://korg.docs.kernel.org/lore-archives.html
> 
> Do you want me to send the email to kernel.org?
> 
> I suggest that we ask for fuse-deve@lists.linux.dev
> and then we can migrated the old sourceforge archives

I'm all for a new fuse mailing list.

> 
> As far as I can understand getting the archives from sourceforge
> required the admin password:
> 
> https://sourceforge.net/p/forge/documentation/Mailing%20List%20Archives/
> 
> Mikos,
> 
> Will you be able to handle the archive migration?

Have that password from Nikolaus.


Thanks,
Bernd
