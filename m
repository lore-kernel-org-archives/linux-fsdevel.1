Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76F633B95A
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 15:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774884380; cv=none; b=gMB7rsv/7I7QnUR96IGaRNlQAe7uX0nRfnt6K2BvUhebRPbmwcu35sOtnkxDhibuUqQHaMPHaxC+mmw8z1ca0Tnl0fppxHBgc1ynkGG7Qzysfn1zsYNT41iw/ae/ntlQR3sBuxrKnOFal9tjakCJ3BNA7Jv8XprYCDWCCdgx7ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774884380; c=relaxed/simple;
	bh=K3CUr1D8i05/guis6NZ95esInScr91gBZj0y+cudQNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j0fcJ4JucOVpz0tYxv6cXXePwihh69/fPdRnGxfycx0bv7dsmv2od37RdSw4pbn/zuVw9B4tMZYhlPVeKXRnufN0e7hc2YbyuyDwOg3Y6xu0nCKer1erqX7ncoOSJ/mTObaPSvzvwZw6xuW0b7AapVpPBv3BP3kPMID0E/bW/ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=pworcmFT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MlgJqhqn; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="pworcmFT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MlgJqhqn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1FBE61D001A1;
	Mon, 30 Mar 2026 11:26:18 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 30 Mar 2026 11:26:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774884377;
	 x=1774970777; bh=S/t5P6rBo4yUmKwhXvkvSziaNKbONrT6rjf00x8Hq8Q=; b=
	pworcmFTMDaiZ74gnlEtf/rdLkqzPyMRGEurK57NTslcCPakO4DleFWzLPJ2vLjt
	pQAoMMyLHDFJJhMZizds9F8EjGZH+yHJ5A76L9aoCG0/4kqSXWiJBIJ5Qy/8tUbc
	hbMcvx1sw+2AiONBvFPlkvIunkyHVv/J4EiLYAse9t5q6uOP0eANJjh+zrokpgrl
	/AdBdAwcGimnkMLTKraqDnsXLqfj7nkDcYrn1/4M+8QtWdAesi7H7PuYqZAGF+LK
	CR0AVAPTX7Ahv9kCv49dCB4NHGbjZhe6wx5cpXKV7pHVFNouzeskEJJm2RI+ZpX5
	n6w7gniJ6nZ5OL+FJwl9HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774884377; x=
	1774970777; bh=S/t5P6rBo4yUmKwhXvkvSziaNKbONrT6rjf00x8Hq8Q=; b=M
	lgJqhqnEQtoj/sz0mWsX+HUvHMtha9xJLFnFT15Wr1mwAxdH7e/71MQGqBEmlDfh
	aO70M2+PoAXg+Q/bId29uoDgmYBt36hnaU+MYn9BJU0tkZJ/HIX/2t4YhYW0G0XS
	thO2lj+fYwDk1Ty5bWJbD3t957Bt2DFwhFnNuFsZGm6lULGCq8YUhRMNr9bEALh6
	H1R0JSGZ/4AxpsRf+iRNLmO9cvjO4T+Yf3IUa8waF77wxseLS/oVSuz4ebtNiAxV
	BdvX40eZjsVoIVVcsYY3XcLXQX+6NF+DAL6C9WXv13u6XpbjEcDWUcfKFVbJxffb
	6oKz/1DdxSMOWVfGr2KzQ==
X-ME-Sender: <xms:GZbKaS4-und3S9DX8g_IBKVVKcynQ1lxBYZjHtZlMpnh7TLVxCBRtw>
    <xme:GZbKaSy0vp-4KEXjSOfNAAGbI6usHpQXMG3zIaA5R3nJNHC2ZnfywGWwPpJc7O3UV
    V0NizqYRHm33RJDHpad6qaUBH9Lx0l6sQNRHWjpohdhcvpNmvRX>
X-ME-Received: <xmr:GZbKaZzRtD0z_rLOiGpwtZ88WOfW1nTzw48Pn_-ZChXkv7x9V9JrWUPhsjPlvDke6NB24NdMdRJSv8uMr4FOYM31RAp0sVOgBsdyxuMZaNVZdGbr1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelfeegucetufdoteggodetrf
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
    hnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgthhgvnhesuggu
    nhdrtghomh
X-ME-Proxy: <xmx:GZbKaayRwMMVbtg7aBUzertVU9zjgD57jOTcopi7Nzh4ovFXzBcLRA>
    <xmx:GZbKaTZLhANmnU75AWEub8pa9ljsT1YsbjkLRqrriKjupujnioBvKQ>
    <xmx:GZbKabXjqojM6_ZeQVdGHxdufgMssMgNqGzVwQJLmwIKmN09Rp8ozA>
    <xmx:GZbKaRjabPCObvMACrcFaz8oCZe8tVqwE7prokQai-CaQHNF5ZerKQ>
    <xmx:GZbKaXhjS6p9qUvnnR0W7kiUMgXq0FHtacMZDZUJcakGhK3KpaqmOAHn>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 11:26:16 -0400 (EDT)
Message-ID: <75b57936-be43-4240-878d-2fa988494bc5@bsbernd.com>
Date: Mon, 30 Mar 2026 17:26:15 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/25] fusermout: Remove the large read check
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Kevin Chen <kchen@ddn.com>
References: <20260326-fuse-init-before-mount-v2-0-b1ca8fcbf60f@bsbernd.com>
 <20260326-fuse-init-before-mount-v2-18-b1ca8fcbf60f@bsbernd.com>
 <20260327033213.GN6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20260327033213.GN6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/27/26 04:32, Darrick J. Wong wrote:
> On Thu, Mar 26, 2026 at 10:34:51PM +0100, Bernd Schubert wrote:
>> <quote Darrick>
>> Nobody's running 2.4 kernels
>> anymore, right?
>> </quote>
>>
>> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
>> Signed-off-by: Bernd Schubert <bernd@bsbernd.com>
>> ---
>>  util/fusermount.c | 37 +------------------------------------
>>  1 file changed, 1 insertion(+), 36 deletions(-)
>>
>> diff --git a/util/fusermount.c b/util/fusermount.c
>> index 8d7598998788f72ea05c2a065a88cb5efd61df35..254f24a98abf935846cfed754693cc1958c8d2ff 100644
>> --- a/util/fusermount.c
>> +++ b/util/fusermount.c
>> @@ -915,33 +915,6 @@ static void free_mount_params(struct mount_params *mp)
>>  	free(mp->mnt_opts);
>>  }
>>  
>> -/*
>> - * Check if option is deprecated large_read.
>> - *
>> - * Returns true if the option should be skipped (large_read on kernel > 2.4),
>> - * false otherwise (all other options or large_read on old kernels).
>> - */
>> -static bool check_large_read(const char *opt, unsigned int len)
>> -{
>> -	struct utsname utsname;
>> -	unsigned int kmaj, kmin;
>> -	int res;
>> -
>> -	if (!opt_eq(opt, len, "large_read"))
>> -		return false;
>> -
>> -	res = uname(&utsname);
>> -	if (res == 0 &&
>> -	    sscanf(utsname.release, "%u.%u", &kmaj, &kmin) == 2 &&
>> -	    (kmaj > 2 || (kmaj == 2 && kmin > 4))) {
>> -		fprintf(stderr,
>> -			"%s: note: 'large_read' mount option is deprecated for %i.%i kernels\n",
>> -			progname, kmaj, kmin);
>> -		return true;
>> -	}
>> -	return false;
>> -}
>> -
>>  /*
>>   * Check if user has permission to use allow_other or allow_root options.
>>   *
>> @@ -1041,19 +1014,11 @@ static int prepare_mount(const char *opts, struct mount_params *mp)
>>  			   !begins_with(s, "rootmode=") &&
>>  			   !begins_with(s, "user_id=") &&
>>  			   !begins_with(s, "group_id=")) {
>> -			bool skip;
>>  
>>  			if (check_allow_permission(s, len) == -1)
>>  				goto err;
>>  
>> -			skip = check_large_read(s, len);
>> -
>> -			/*
>> -			 * Skip deprecated large_read to avoid passing it to
>> -			 * kernel which would reject it as unknown option.
>> -			 */
>> -			if (!skip)
>> -				process_generic_option(s, len, &mp->flags, &d);
>> +			process_generic_option(s, len, &mp->flags, &d);
> 
> Er... we should still ignore large_read, right?  It's been defunct since
> 2.4, but there could be some script/fstab/whatever that still contains
> the mount option.

Dunno, I'm more tempted to remove it and to filter it out if someone
ever complains. 2.4 was a long time ago.


Thanks,
Bernd
