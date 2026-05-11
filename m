Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C241421A08
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 15:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778515121; cv=none; b=YBP79ulvHKRlT0qMPsqJtoKofRsOQP+yrS9FRSxdySW01mEduK1Aglhy1dWA9+V9VPJwnhBCS4p7C3Oz7hpMqtvUtRZMaNr3lJH808zLoWriqilNMQ6s3uyIiL50/6ttmxfm21SPgm9AGxi0xqNl5QrqLOxkPRmMECFvMWJgbOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778515121; c=relaxed/simple;
	bh=aPV031t0d0WdK4n4+eFzoib5pTagpaQ8vVYLriVi+zA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8EdOBAZY5arVeOBVx3q1HZsyRXEAbRnYqE5uUTcqf1eAbc0sEFRJQpREJP9Orxxe8Wp5GW5YR+Wj/TwDRCjmKe61GHr7WryuqMZFb11QliSi9UnIiGL9opv9Ehe5PsBW6W1Hec1sD5+GrMW5nwbVBRlrKQgLdxCHYtr80LXGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=BdubbuIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kaactY3+; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="BdubbuIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kaactY3+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B47D2140015D;
	Mon, 11 May 2026 11:58:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 11 May 2026 11:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778515118;
	 x=1778601518; bh=WOTQ21EEPEdU27zFCWnkLIMXPzlh5zaZvgobHRBHCMI=; b=
	BdubbuIHL7BnPo2dywm8fpsZTk4mfowhPsNED40Mvp/2LEMj8gVsNzNJ6KfsjkdG
	+eHGRmgr7vLCZB3/FVv5dzS8goitKu1Yd7LkAHKDIoTR1zMJs4hMGk56cbm1Xx7+
	87EUKl7Ctg1e5Itw5Vp+AGzq5LnLPPQP2CnA8h98VZQfzNM3HsVUee5K75Olp/2r
	RyFgOWdAYJgkeuEVuKk58n31sMA7L9kJT512RExfTh3CKiGOFCc79kKg2I9EhuFc
	Ekw5sOcv10smnUkLQioUeyB4mOvpZXSq467gWpJSKOxNG5p/56o+xHIBUWFR1bEt
	V9rP1TcK6iioZxBq/CUh3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778515118; x=
	1778601518; bh=WOTQ21EEPEdU27zFCWnkLIMXPzlh5zaZvgobHRBHCMI=; b=k
	aactY3+STbN9DCEX1jGn8eaIDRSsKwo1nd6dx04VbIfoDUpCy7uWy7xLW/FGRJXs
	0YBTtccY/glHJ7jmE21N3uYFZlOUUCmkZTZGfAmnOhJiLw0za97WkQzT4SnDnLwJ
	CfWMYISmHK0x5qhGPUgKkiZgUqmOv1rc6ovXUJOUG/QjwGHcdzjCU8G/kQUAXRc0
	ErGyBT/9h8Da/G2aOL3ydfLfrr4KZD78RVQ1j71azUwIKd7gvGuEnCgXSIrJBot4
	0X7rz5oEYkxtIK1ohU3xc86Y9U5yAznvTGl8M2+5IMuA956dyBSa82GVBqd6tsED
	LxltDrRcCLEz6dvVJLiuA==
X-ME-Sender: <xms:rvwBann0-z_AovXv8EPT6HouqbxSe6H4zVA4n034wz-4vAKDkRsiAw>
    <xme:rvwBakI9Zc0lrZ_FHcy443EZA3XJTZn66xLXyVPzHd3nVrLrT9_CTLb8RxaoKSAmd
    gs-BnGMG7ko7gJpctUPbcRRJYKCbXvbvr1E4GrJQ2xx00fg9EpL>
X-ME-Received: <xmr:rvwBak4wcoROpGfLzLcxQjc2ff7rVUUEKnJP4VLz11Dz9ePb3djjzUIoDbHZp_d2I0eYsU5bOHm69DJu-7llpprD3u3sG9gOnDhilivlG8SFNkBKOA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepmhhikhhlohhssehsiigvrhgvughirdhhuhdprhgtphhtthhopehjohgrnhhn
    vghlkhhoohhnghesghhmrghilhdrtghomhdprhgtphhtthhopehfuhhsvgdquggvvhgvlh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehnvggrlhesghhomhhprgdr
    uggvvhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:rvwBag3EHLd35FG0QKaY02Z6wFxlYBUBAO2Xyy3tj1rLhSWGLtfS0w>
    <xmx:rvwBaieeZ9_qR22rSWIvFgNkC06bq2Q_h8fvEVKW4jaLJxxweDvkQg>
    <xmx:rvwBaudk99MZgAw7Cee2vqOHsoQ-ytpGD28sjtz343U0fUHNPu6duA>
    <xmx:rvwBalxcNcfMlF90iVsFFBp2h-9aSqsMAq5Y5kUfolr5UIggtzpVPQ>
    <xmx:rvwBah2Oz3ZfD1M5z1NBXOnH-OLIZpKuWOjZlTsWVvby6yhAdKDBIu72>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:58:37 -0400 (EDT)
Message-ID: <1f30f0f7-5900-4cc6-951e-8762ce312ba1@bsbernd.com>
Date: Mon, 11 May 2026 17:58:36 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] mount_service: use the mount_flags table instead of
 declaring our own
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, fuse-devel@lists.linux.dev,
 neal@gompa.dev, linux-fsdevel@vger.kernel.org
References: <177819198049.3490792.9243635053987314774.stgit@frogsfrogsfrogs>
 <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
 <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>
 <20260508175945.GE2241589@frogsfrogsfrogs>
 <20260509004851.GF7739@frogsfrogsfrogs>
 <37d55a0c-7358-455d-9552-c621160bb269@bsbernd.com>
 <20260511152210.GG7739@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260511152210.GG7739@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/11/26 17:22, Darrick J. Wong wrote:
> On Sat, May 09, 2026 at 09:42:12AM +0200, Bernd Schubert wrote:
>>
>>
>> On 5/9/26 02:48, Darrick J. Wong wrote:
>>> On Fri, May 08, 2026 at 10:59:45AM -0700, Darrick J. Wong wrote:
>>>> On Fri, May 08, 2026 at 06:51:45PM +0200, Bernd Schubert wrote:
>>>>>
>>>>>
>>>>> On 5/8/26 00:14, Darrick J. Wong wrote:
>>>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>>>
>>>>>> Use the canonical mount flags table in mount_util.c instead of
>>>>>> opencoding our own version in mount_service.c.
>>>>>>
>>>>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>>>>> ---
>>>>>>  util/mount_service.c |   51 +++++++++++++-------------------------------------
>>>>>>  1 file changed, 13 insertions(+), 38 deletions(-)
>>>>>>
>>>>>>
>>>>>> diff --git a/util/mount_service.c b/util/mount_service.c
>>>>>> index 8c9747b3928a51..79e5b060ba3356 100644
>>>>>> --- a/util/mount_service.c
>>>>>> +++ b/util/mount_service.c
>>>>>> @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
>>>>>>  	unsigned int mount_attr_flag;
>>>>>>  };
>>>>>>  
>>>>>> -static const struct ms_to_mount_map attrs[] = {
>>>>>> -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
>>>>>> -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
>>>>>> -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
>>>>>> -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
>>>>>> -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
>>>>>> -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
>>>>>> -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
>>>>>> -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
>>>>>> -#ifdef MOUNT_ATTR_NOSYMFOLLOW
>>>>>> -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
>>>>>> -#endif
>>>>>> -	{ 0, 0 },
>>>>>> -};
>>>>>> -
>>>>>>  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
>>>>>>  				 unsigned int *attr_flags,
>>>>>>  				 unsigned long *leftover_ms_flags)
>>>>>>  {
>>>>>> -	const struct ms_to_mount_map *i;
>>>>>> +	const struct mount_flags *i;
>>>>>>  	unsigned int ms_flags = ntohl(oc->ms_flags);
>>>>>>  	unsigned int mount_attr_flags = 0;
>>>>>>  
>>>>>> -	for (i = attrs; i->ms_flag != 0; i++) {
>>>>>> -		if (ms_flags & i->ms_flag)
>>>>>> -			mount_attr_flags |= i->mount_attr_flag;
>>>>>> -		ms_flags &= ~i->ms_flag;
>>>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
>>>>>> +		if (!i->on || !(ms_flags & i->flag))
>>>>>> +			continue;
>>>>>> +
>>>>>> +		mount_attr_flags |= i->mount_attr;
>>>>>> +		ms_flags &= ~i->flag;
>>>>>>  	}
>>>>>>  
>>>>>>  	*leftover_ms_flags = ms_flags;
>>>>>>  	*attr_flags = mount_attr_flags;
>>>>>>  }
>>>>>>  
>>>>>> -struct ms_to_str_map {
>>>>>> -	unsigned long ms_flag;
>>>>>> -	const char *string;
>>>>>> -};
>>>>>> -
>>>>>> -static const struct ms_to_str_map strflags[] = {
>>>>>> -	{ MS_SYNCHRONOUS,	"sync" },
>>>>>> -	{ MS_DIRSYNC,		"dirsync" },
>>>>>> -	{ MS_LAZYTIME,		"lazytime" },
>>>>>> -	{ 0, 0 },
>>>>>> -};
>>>>>> -
>>>>>>  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
>>>>>>  {
>>>>>> -	const struct ms_to_str_map *i;
>>>>>> +	const struct mount_flags *i;
>>>>>>  	int ret;
>>>>>>  
>>>>>> -	for (i = strflags; i->ms_flag != 0; i++) {
>>>>>> -		if (!(ms_flags & i->ms_flag))
>>>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
>>>>>> +		if (!i->on || !(ms_flags & i->flag))
>>>>>>  			continue;
>>>>>>  
>>>>>> -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
>>>>>> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
>>>>>>  			       NULL, 0);
>>>>>>  		if (ret) {
>>>>>>  			int error = errno;
>>>>>>  
>>>>>>  			fprintf(stderr, "%s: set %s option: %s\n",
>>>>>> -				mo->msgtag, i->string, strerror(error));
>>>>>> +				mo->msgtag, i->opt, strerror(error));
>>>>>>  			emit_fsconfig_messages(mo);
>>>>>>  
>>>>>>  			errno = error;
>>>>>>  			return -1;
>>>>>>  		}
>>>>>> -		ms_flags &= ~i->ms_flag;
>>>>>> +		ms_flags &= ~i->flag;
>>>>>>  	}
>>>>>>  
>>>>>>  	/*
>>>>>>
>>>>>>
>>>>>
>>>>>
>>>>> Hi Darrick,
>>>>>
>>>>> wouldn't it make sense to use the functions from mount_fsmount.c? I can
>>>>> also clean this up later if you want.
>>>>
>>>> Oh, hah!  Yes, I'll revise this patch to use them.
>>>
>>> Update: I tried this, but ran into a problem: the two helpers are in
>>> lib/mount_fsmount.c, which means the object code ends up in libfuse.so.
>>> Unfortunately, that means that util/mount_service.c can't use them
>>> unless they're exported from the .so.
>>>
>>> I don't mind doing that, but I feel that I should check with you if it's
>>> ok to add that to the public libfuse API before doing that?
>>>
>>> Though I think a better solution is to move ms_flags_to_mount_attrs and
>>> set_ms_flags to mount_util.c because that's compiled into the util/
>>> programs.
>>>
>>> How about I do that second thing on Monday?
>>
>>
>> I would prefer the 3rd option, like for fusermount3
>>
>> executable('fusermount3', ['fusermount.c', '../lib/mount_util.c',
>> '../lib/mount_fsmount.c', '../lib/util.c'],
>>
>>
>> I.e. add lib/mount_fsmount.c to mount_service_sources.
> 
> That works, will put together a patch to do that. :)

Hi Darrick,

I didn't manage yesterday anymore to work on that, the container branch
is in a total merge conflict with libfuse master. If you want you could
continue on the iomap and I would solve the merge conflicts. Though,
probably not today or tomorrow.


Cheers,
Bernd
