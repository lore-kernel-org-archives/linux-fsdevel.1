Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3833FE0A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884860; cv=none; b=UU80av8ATa9iWVa2anRoM2Bnrv4/pAeL7C2Pc6LcrrgPUwAtA29cO6+T6FPKLrMyMd/t8FgwDWpymMOJUbzCKdl3xrD9JP9yIV+NrkTG0sO605qULkpbHtBOOZIk+PU+oNV3c30FWfcVToEWejB1k+r0YMcgAL+TYmZaHG342q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884860; c=relaxed/simple;
	bh=0sVSo+c5SaYjPX46fTS/HuilzqJjD8Pi22Gazx5ubQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AADyG92/2QJyPvgTIMGxhkUjKdMylYuZNLmv0edvRxDscjVWFW8yNj8EL7BRz4L7yBmUThDFwy6ElqDs6LtFZKdklHASBFI8xKNIB8cvcejSoEn6Om30CUZ8QunS2wMeNoXH9x68d3uTV4PBEn294FvoKr8d9AN90iY4fNMn7xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=CxsPI6kP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kvNZWDyH; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="CxsPI6kP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kvNZWDyH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8F5B31D00037;
	Mon, 30 Mar 2026 11:34:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 11:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774884858;
	 x=1774971258; bh=bcb1RWBc6BHem0gSjCbRiX7erJ4AVCeE7U4bGMzc1dM=; b=
	CxsPI6kPH/9zVqcblhRNmi4kyAFljX50Ef1O5Sge3PjQrsTiPEZx81wNsqr7sKR9
	82iPXzT34x4+sh8GoYJA2Y5ilukijFxjWtrS7IAaaZmUQK4KtvOFOoVyUeNTj+d/
	7ZtAsBpegnkYLQUB33fF6BFz/29QhbLTDf0TmEuEA8n4NiTP8pe0bncBarB16Kwy
	G1dbEa/O0GADVn6/mG13LlKdhy8Axi3kHO4f6xQsPVl9Vs251jJZe6df5Y5cJd8q
	J1jjq4cy0V5NoV0DWdnCayhxQQeUuVyL3fLYvBRGjD+kRprCdB4HqI/g7a7CaMDM
	0YP8MbGHd2TfL+GRYytrAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774884858; x=
	1774971258; bh=bcb1RWBc6BHem0gSjCbRiX7erJ4AVCeE7U4bGMzc1dM=; b=k
	vNZWDyHq70vXe7shx2lgp7c42VSaRBkAxF0C0xPqj0FGgs2uNAe6qP5zl6wuLLF1
	8Qoo4zaOgUfWToIZXOp+MN+IcL26aUqS/2Z4uen18YiPdvC7v5Oj9+tOvkA3Y/3I
	jhgkSGXaZi7zfKrvuxsTHG6mF/joBnsv1wM6bLiX7o56fWAXRbE3HMK9A5EebdFK
	2HODiTqMQLIk+gVAWE2SexS/0EkVUG2ObFUvxASU05jPtXYh9OT2GzIRuEGtNOCi
	pqMTnJWAQxZeRAdSiUvIZqeUKiIWit5w6v/uM4ePCR8m8GhokaqPJP4hvQGXuupZ
	UZibE19jWPMtjNglyqBag==
X-ME-Sender: <xms:-pfKafDZbV2JFlc9L8Twz2q1tVcTDELpYcZfSHEQ7oAfQe8u6tAqTg>
    <xme:-pfKaZOsRHoqgz0NbmYhxgLj5KI-CPv9JfETl_HOs66LlC6L_sn7zvc7XghPWMR5V
    Roh5QZd4QV-Ut8LN8GQ4snLta3iquk5YRFceIwW4e8R5Zx-0arK>
X-ME-Received: <xmr:-pfKaUbnkJwuZCyyw7JnhUg1eTiGW9iX6AJS3LciGDePfkgoODAbckAkoc4UKYgWNlUCsan4spFbio3-f7ewVadpWLCNUizHforywPRNOWNkDpDGyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgthhgvnhesuggu
    nhdrtghomhdprhgtphhtthhopegsshgthhhusggvrhhtseguughnrdgtohhm
X-ME-Proxy: <xmx:-pfKaYvM8KW8A5Qex7ZaCnaP_rKcnfi0LpCuQOaOaD2E-tDpbpfEkw>
    <xmx:-pfKaWPI5X8DJ3Hf14-rdEZqcVVnbThmuZqP577m7Mnij69H7QR1Kg>
    <xmx:-pfKaf5iUwugegHExLg3dgl7tw7h5CO1gzsLfC_drN8rF1lV2h0NfA>
    <xmx:-pfKacTQoVE2xQqhEAv04K0YHcapL6mF9gpIu9Z0TfGLbhoEywK02A>
    <xmx:-pfKaTSkW9ajWReAGOI_z3d5_3YQSr7Wi_vlYs_GlgvfU6k4YmhRT6ll>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:34:17 -0400 (EDT)
Message-ID: <936aeb1d-baea-4c07-8f15-da33247fd03a@bsbernd.com>
Date: Mon, 30 Mar 2026 17:34:16 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/25] Use asprintf() for fuse_mnt_build_{source,type}
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>,
 Bernd Schubert <bschubert@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-9-b1ca8fcbf60f@bsbernd.com>
 <20260327032443.GL6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260327032443.GL6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/26 04:24, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:42PM +0100, Bernd Schubert wrote:
>> Simplify the code by using asprintf.
>>
>> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/mount.c | 28 +++++++++++++---------------
>>  1 file changed, 13 insertions(+), 15 deletions(-)
>>
>> diff --git a/lib/mount.c b/lib/mount.c
>> index fe353e2cc4579adb47473cac5db7d1bae2defb2c..68f9219d2b8beee51346b198ce826138b9528e73 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -754,32 +754,30 @@ char *fuse_mnt_build_source(const struct mount_opts *mo)
>>  {
>>  	const char *devname = fuse_mnt_get_devname();
>>  	char *source;
>> +	int ret;
>>  
>> -	source = malloc((mo->fsname ? strlen(mo->fsname) : 0) +
>> -			(mo->subtype ? strlen(mo->subtype) : 0) +
>> -			strlen(devname) + 32);
>> -	if (!source)
>> +	ret = asprintf(&source, "%s",
>> +		       mo->fsname ? mo->fsname :
>> +				    (mo->subtype ? mo->subtype : devname));
> 
> That works, though I had been expecting something more like:
> 
> 	if (mo->fsname)
> 		ret = asprintf(&source, "%s", mo->fsname);
> 	else if (mo->subtype)
> 		ret = asprintf(&source, "%s", mo->subtype);
> 	else
> 		ret = asprintf(&source, "%s", devname);
> 	return ret ? NULL : source;

Also fine with me, I changed to that version and added your Reviewed-by.


Thanks,
Bernd
