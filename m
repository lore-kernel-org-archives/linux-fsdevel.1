Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEA36C0AC
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779373956; cv=none; b=hiTWC/pSx2RPYiKO6QQoTLrsaMoiZVydNuzKaKt+LPlCyy66hCpcS2DiBl7QRaYay+/mucwUrJOGcg4Fhoi3O9bx5w2wxhMo5E9rDmx3F2FVLyc013VfpnqaNcdDEI8WHf79UnY/lF5Iqt+qUlpdnNdnGsooQkyiztGZ93fs2Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779373956; c=relaxed/simple;
	bh=oe4khfn/mXkLpZpeYCPmEhKIC2yyDCnJTKAa6ugxJzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rUqQq59Vt6fsVZXptJTtQV1ZCOVky5EjX5+UiaHAKmXLOsEJa4qN8+aVZsuEQNU8KvPj0ubqDAvVbNnACSYp3Nyvak41BKUWuwzH3FSz9PXYuwJFOshPnhwTYpcship7cYTxtmuSbndPZmwwIgS3mJIh2zdpjTB/o/eZwM93JgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=p3/6YAcX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YpItAakS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="p3/6YAcX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YpItAakS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0509140008C;
	Thu, 21 May 2026 10:32:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 21 May 2026 10:32:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779373953;
	 x=1779460353; bh=kr3FmYD3aAY4mFH7NrgKj6U1glVPAYBkdl5ncPk3Fqc=; b=
	p3/6YAcX3/cqNR5+P/3S2qwvLEdrs0RSZdsA1QyviQ5MjjbPY806gbniV0g91W6v
	oXKliRPzivYJtqU1EROP7PjtxH7lwBDsRQWf2PJ57rs7StRElrlsRSMp0UcxvJIz
	sCqd8DXDx0VerDBF5hYpUCTOX/pxqLBMes/d8Rfvhg5PQb5jK+NCJs+/F23BxHuL
	O5I6OnfkD/ZeDeVMY2Sg2M7koGrWSdNOO+D+qnaEdhL0lEtw/sy3Lm8gCLjiCYrP
	RYOVpjdIIIybCQUU1BVDCcKK+4GSIiG09lzl/NhAq+rcTDAeYhOzWnOY3JVb05Hi
	sEUD8ckXxGlTgEelZtWnGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779373953; x=
	1779460353; bh=kr3FmYD3aAY4mFH7NrgKj6U1glVPAYBkdl5ncPk3Fqc=; b=Y
	pItAakS5yxDY/c+WSZwZkrw6iyRWH+EELhObelNNwuKCmSuh4rTuCSedWwH8+cem
	WIr5hdcr1NYO/jZ1lse4cCxEr8x7XQBsPZeev19ctdxXsWa9Cet/TsKKKev25TaH
	CK23gHUCyeUZHeTg9ZM099NlgAOuqvA4HQlQm+WTeXfUBcH7KaUv8Nd/rJFccg4I
	H9qB8c6gCn5a3Sb9k2HIYWOt7KG6iU/B1Jo2zhpBcTyM/AAgc9wYX+IpuUvIz+5B
	Sed1sD67O4We/YM7BkQMUVdyT1du/WmwWz+whp3SaH7Sxfazr+AheMXflBxGhyQU
	CuGd0iRxdnv7uiuEdIa8g==
X-ME-Sender: <xms:gRcParcQRIoHgycDwf-EDsuqtUFX6P0bXNBm2gfdayi7cTZkv1JYmA>
    <xme:gRcPaqj3oASe9fO_h9nu7APTvssU1wGP2O1yLZghWWsCyLhIumE859FPvJs5fnQ62
    9JAjoph-wo0yr2Q8_gXwtmkeToUIQRBbjTWiImJg6eBg-p5u9vC>
X-ME-Received: <xmr:gRcParwxYPyYuAID-DgBs0VvMOmBhG_xxwep6QA8ZG4CtQBeqMNeAls9dsWnHx564d4RP1maCzunqFrd-lMqlzff893UlLS0-ZYIbQlYeVD5LifgTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepmhhikhhlohhssehsiigvrhgvug
    hirdhhuhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlihhsthhsrdhlihhnuh
    igrdguvghv
X-ME-Proxy: <xmx:gRcPauMzJFLpNnQjkGv2ZWhW5A1zl4zuFvJNzmuyfReFXRhsn-n5Mg>
    <xmx:gRcPakWAVD3kYhFIi2Fp0osmM7C1UAYKBKheTTbXeJaRRGa0hOIBSA>
    <xmx:gRcPaq2fohwezPRznQyuuoQGT-xvZ2jL0WAY1-Qe1aGKsU0YPaEPIw>
    <xmx:gRcPaqpGc3GvtaFjY2_ascPeUSAZKmNxWx9Fdzb-FUd3chr5hb1euA>
    <xmx:gRcPavu4noZ-SbqksvvK-7T81GKIFrGDcxtQa-tBqWQAyF8pxQpL7u07>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 10:32:32 -0400 (EDT)
Message-ID: <44496dd7-c70b-49f1-a8a4-5efc3c018c1b@bsbernd.com>
Date: Thu, 21 May 2026 16:32:31 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] fuse: use fuse_args in try_service_main instead of
 opencoding it
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, miklos@szeredi.hu,
 linux-fsdevel@vger.kernel.org, fuse-devel@lists.linux.dev
References: <177933241435.3536631.9946604261928168710.stgit@frogsfrogsfrogs>
 <177933241466.3536631.2548927904330465445.stgit@frogsfrogsfrogs>
 <567436e2-46d2-4e23-9647-b9af9670a4ea@bsbernd.com>
 <20260521142453.GN9568@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260521142453.GN9568@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 16:24, Darrick J. Wong wrote:
> On Thu, May 21, 2026 at 10:40:11AM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/21/26 05:06, Darrick J. Wong wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Don't open-code the argument array, just use the existing helpers.
>>>
>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>> ---
>>>  util/mount.fuse.c |   71 +++++++++++++++++++++++++----------------------------
>>>  1 file changed, 34 insertions(+), 37 deletions(-)
>>>
>>>
>>> diff --git a/util/mount.fuse.c b/util/mount.fuse.c
>>> index 00b133e6234489..bbfd8355dc7f48 100644
>>> --- a/util/mount.fuse.c
>>> +++ b/util/mount.fuse.c
>>> @@ -286,12 +286,7 @@ static int mount_service_child(char **argv)
>>>  static int try_service_main(char *argv0, char *fstype, char *source,
>>>  			    const char *mountpoint, char *options)
>>>  {
>>> -	char **argv;
>>> -	char dash_o[] = "-o";
>>> -	char dash_t[] = "-t";
>>> -	char *mntpt;
>>> -	int argc = 5; /* argv[0], -t type, mountpoint, and trailing NULL */
>>> -	int i = 0;
>>> +	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>>>  	int ret;
>>>  
>>>  	if (!mount_service_present(fstype))
>>> @@ -301,44 +296,46 @@ static int try_service_main(char *argv0, char *fstype, char *source,
>>>  	if (source && source[0] == 0)
>>>  		source = NULL;
>>>  
>>> -	mntpt = strdup(mountpoint);
>>> -	if (!mntpt) {
>>> -		perror("mountpoint allocation");
>>> -		return -1;
>>> +	ret = fuse_opt_add_arg(&args, argv0);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	if (source) {
>>> +		ret = fuse_opt_add_arg(&args, source);
>>> +		if (ret)
>>> +			goto out;
>>>  	}
>>>  
>>> -	if (source)
>>> -		argc++;
>>> -	if (options)
>>> -		argc += 2;
>>> +	ret = fuse_opt_add_arg(&args, mountpoint);
>>> +	if (ret)
>>> +		goto out;
>>>  
>>> -	argv = calloc(argc, sizeof(char *));
>>> -	if (!argv) {
>>> -		perror("argv allocation");
>>> -		free(mntpt);
>>> -		return -1;
>>> -	}
>>> +	ret = fuse_opt_add_arg(&args, "-t");
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	ret = fuse_opt_add_arg(&args, fstype);
>>> +	if (ret)
>>> +		goto out;
>>>  
>>> -	argv[i++] = argv0;
>>> -	if (source)
>>> -		argv[i++] = source;
>>> -	argv[i++] = mntpt;
>>> -	argv[i++] = dash_t;
>>> -	argv[i++] = fstype;
>>>  	if (options) {
>>> -		argv[i++] = dash_o;
>>> -		argv[i++] = options;
>>> -	}
>>> -	argv[i] = 0;
>>> +		ret = fuse_opt_add_arg(&args, "-o");
>>> +		if (ret)
>>> +			goto out;
>>>  
>>> -	if (getuid() != 0) {
>>> -		ret = mount_service_child(argv);
>>> -	} else {
>>> -		/* We're root, just do the mount directly. */
>>> -		ret = mount_service_main(argc - 1, argv);
>>> +		ret = fuse_opt_add_arg(&args, options);
>>> +		if (ret)
>>> +			goto out;
>>>  	}
>>> -	free(argv);
>>> -	free(mntpt);
>>> +
>>> +	/* If we're root, just do the mount directly. */
>>> +	if (getuid() != 0)
>>> +		ret = mount_service_child(args.argv);
>>> +	else
>>> +		ret = mount_service_main(args.argc, args.argv);
>>> +
>>> +out:
>>> +	fuse_opt_free_args(&args);
>>>  	return ret;
>>>  }
>>>  #endif
>>>
>>
>>
>> Thanks a lot much better!
>> I think we need something like
>> fuse_opt_add_arg(struct fuse_args *args, ...)
>> Easy enough to convert to that once libfuse has it.
> 
> Oh, you mean like a va_args version of it?  Yeah, that would be useful,
> but iirc the va_args user has to know the length of the args array
> beforehand, and it's not so ergonomic to let people do:
> 
> 	fuse_opt_add_args(&args, 3, "-o", "monkeys");	/* oh no */
> 
> There are some horrible cpp macro tricks you can play in C++20 to call
> fuse_add_opt_arg() recursively until you run out of arguments:
> 
> #define PARENS ()
> 
> #define FOR_EACH_HELPER(func, base, arg, ...) \
>   func(base, arg);                            \
>   __VA_OPT__(FOR_EACH_AGAIN PARENS (func, base, __VA_ARGS__))
> 
> #define FOR_EACH_AGAIN() FOR_EACH_HELPER
> 
> #define FOR_EACH(func, base, ...) \
>   __VA_OPT__(FOR_EACH_HELPER(func, base, __VA_ARGS__))
> 
> #define fuse_opt_add_args(args, ...) \
>   FOR_EACH(fuse_opt_add_arg, args, __VA_ARGS__)
> 
> But now that I've broken my brain I'm going to go do something else for
> a bit. ;)

We can think about a better solution any time later, for now it is fine.


Thanks,
Bernd


