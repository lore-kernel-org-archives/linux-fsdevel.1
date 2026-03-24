Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F952DF15C
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 20:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382484; cv=none; b=Ne3q9MvMvkogUXiyMB4fVqXlohTWUqo+vZdPZVKqaEoTEFlJAPjs6o7ebyjwv/WHaYdihKDQLZ6qLpgOB2ntJxTygteq3OmPnHRmfvk2HemaU04zIxmFxm1oQ4ktQv120BdXDZyhQosxy2DDtrxBhTeWWryZXt60NR7daG1qzRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382484; c=relaxed/simple;
	bh=Hy+K7UAa7iwhLK4eBQ4F3BupEQoiTt+JgVZj033h1Vs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IOD+KoBSycTtz7ceMG01K0HsKvKYqVCuv6G0PXKXKwJnSxy2bsrMWOQxfVQw0axdJmezJH9dPzI6t0Kv9fumCvC1fLCwqAkMJ9G7RtPVMwRHGc7BjuqMCNQAxoEmW44bA1YQBwa+1XZw0z133xX6hfUdqGXtOjoPUN3bMbwyIpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=lgRobzcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lMD/p0tD; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="lgRobzcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lMD/p0tD"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3ECEB140006E;
	Tue, 24 Mar 2026 16:01:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 24 Mar 2026 16:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774382478;
	 x=1774468878; bh=BSqcOwFlABxaBoTBwmIeI/TPsMqKW/hKK1T943JDH3Y=; b=
	lgRobzcXTI3zlf/tNjYHmSPxIHe6HipO+IWbL0nZzhafhWvr2BpLUIyfq3s8ywUL
	bpeExy0JC3joY+98cdnSVR5kLVS7FtAzj4mkdCgFuX74o5fnaeaem1jLVUfbL8JS
	8b9w1evyvaN8ditE5B17s8QztK2jH3xVtB9l3e9CkwPh8IoaJQZbOVCPcD+12mtT
	i9JbC/RnJlqg4HAp1WESeSvDfkMWqjW/Y3ZxAgYRVSeZR1HIRt8D79doD6+JaLrf
	lz02ct9s0IcWTeEFCR6s85AGLaz8IcCAs68Wht4mvny3eXtLPi57G/Q2e8pmNAwM
	fJ2M/6bz5MfsBvVtQ7OLbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774382478; x=
	1774468878; bh=BSqcOwFlABxaBoTBwmIeI/TPsMqKW/hKK1T943JDH3Y=; b=l
	MD/p0tDF/2HyNG3OpTSX58rRqaY4Tt0fTadiajoXhk8dd8s/7V0xWa0b+KHMp1rV
	kjEIybShioGzsIuaiLiKdmXZfrsWJ7rggO1iRMD4twtX2Y5BEexM0ouHDzAIvNs+
	zKFhkwBMbuQwNGNOenFUOYLDGwHF4IcZ/2jlAEdlzHBSoBPfZIZkAnQLGcvQpGaY
	z+PHNi4ju6zRiY37BNIL9XCvxLV3Y6CnKiwxXje1XDKURvBy4iWb7sZmBEA5ES2y
	KGHMzL0oTXIqG0LZ9oIhIejf5hLkf7Lm8OBOzQJ5jIwIJsaJVKcQgL+GSDV2ZvPc
	Yfeb3Tcfx4fSU+f08gXJw==
X-ME-Sender: <xms:je3CaQKbV2buEZmQKCR4SOOhYTTfbNdnuluwY-5LNflfeSuwIq2M4g>
    <xme:je3CaXCylQViq1EkCojQwN3QnhE_fyQycoR7GW69mIACtNXbq63cD95NQ8ZbsKdxC
    ULo55XLvUwo15qNMEbf9IhbyanvsJl98pGLI_ZGUXupL8KuDS57>
X-ME-Received: <xmr:je3CaZAsYCG6lUIkGqk1FedVxno8mrCwLjh_Jcr2_FUnnzTSVrJOAVU5xvQ_L4TT2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvgeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehmihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtohepjhhorg
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghstghhuhgsvghr
    thesuggunhdrtghomh
X-ME-Proxy: <xmx:je3CaZCDXRiyH4084_bj1iw9AQxznrdnNcEDKbKqr2g456qZw5anvQ>
    <xmx:je3CaUoh2sGLe7Udvx4S-i_o3QMPLUtKGH8uM7sPvE-wbcvHD22_Sg>
    <xmx:je3CaTkC_WPYOgz8nOqasKk5YpYbtCWaYp4drfTPrmGEqRLeU3Jzbw>
    <xmx:je3CaUxwfrNqXxn2HLodiZbS5c0fyF3NJ0DhcMUwNg5fYYsW_PQPZA>
    <xmx:ju3CaXxf6YpkiI9devc83YZ1QppFtrgcZ8RWXKDV9VMSMBoXWNO0QZ1m>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 16:01:17 -0400 (EDT)
Message-ID: <0eb22615-7b1b-4472-aa55-6445e05d9cc7@bsbernd.com>
Date: Tue, 24 Mar 2026 21:01:16 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/19] New mount API: Filter out "user="
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-18-a52d3040af69@bsbernd.com>
 <20260324195153.GU6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324195153.GU6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 20:51, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:13PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> This gets added in the fusermount process and kernel then fails
>> the mount.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/mount_fsmount.c | 13 ++++++++++++-
>>  1 file changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
>> index f1fec790bb80f8815d485a068dc7efdff1746309..76c14cf9a22465160fc6b206ca9b6c9e7300adba 100644
>> --- a/lib/mount_fsmount.c
>> +++ b/lib/mount_fsmount.c
>> @@ -218,6 +218,16 @@ static int is_mount_attr_opt(const char *opt)
>>  	       strcmp(opt, "symfollow") == 0;
>>  }
>>  
>> +/**
>> + * Check if an option is a mount table option (not passed to fsconfig)
>> + */
>> +static int is_mtab_only_opt(const char *opt)
>> +{
>> +	/* These options are for /run/mount/utab only, not for the kernel */
>> +	return strncmp(opt, "user=", 5) == 0 ||
>> +	       strcmp(opt, "rw") == 0;
> 
> Oh, so these are added to the mount options string by get_mnt_opts
> and now they need to be pulled out so they aren't passed to fsconfig?
> How'd they get into the argument list in the first place?


See the commit message ;) And then check fusermount.c in get_mnt_opts()


Cheers,
Bernd
