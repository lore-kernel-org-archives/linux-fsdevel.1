Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5052032D
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 May 2026 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778312537; cv=none; b=bz3a4HO3jCtNe84aO62ZSUlADNPdHqFPIoJlrwmxvyI4rIMAVffVMA0R+k/DqWCQb7HF5T5ujx/DeWwbUOeWoKxNBuDJoEDXxA83ytjdziBedTOP7WE0FGzWLwgnkhavZWcQFI94+4+HO/4Ycg37tFzMnHnX3KE+inA/jwt3bn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778312537; c=relaxed/simple;
	bh=zSAznESrPV1rJaz+GsMNum3YfYH0ug0b/8QEmygbhxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRkEv4e40toVISHY7ysPc+grUwS96subbQBgMG9UjK2eUJFsBfaQScF8BauubsSnQO6c/yKGgSS6BNYrqHwkHznr2Ucixqvkow1bCdJJRofvx9m+AQEtxR47SrRKbqTU6FqjZW8Zp8F/+LmE/3BfHbpwooswL42O6PTb8X1D6fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=EUIB/1QO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ffK0ZMny; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="EUIB/1QO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ffK0ZMny"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CE9B214000BB;
	Sat,  9 May 2026 03:42:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 09 May 2026 03:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778312534;
	 x=1778398934; bh=x+An5n6q1En7EzjV63I1NM0GT+3TOx6VWKvdivMHzto=; b=
	EUIB/1QOwpI+JvSFfip8r6Emmckw2VruUGR4Kdzk5jITnMgP5lQvkW5+CrSY8gkI
	7TE6+VEY7pqmXBlPyLvvhxru1PRKQWiq2/35dzBIHFBheJi6CPlmJu6GPHNKEwxJ
	0HfBM7tsbueK+uCeJOyQY3eYjTE3WnPwNOYMcsmMXk/t4qA2MtGBawtbfgPrSDcV
	3MmtLKa90V+BkxiYLO8LWHlJLnuvRi+J4Py/lvDDqYW/zATMdkOjTj9M75VL9HI4
	vEAtCtfZ86wAxJFIxGJcVaY188nANq8ViH/cBQgaxhKwk9RsBBK1SgyMOeVo+Ke0
	NGlezfbxcZOwHzze8EOi4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778312534; x=
	1778398934; bh=x+An5n6q1En7EzjV63I1NM0GT+3TOx6VWKvdivMHzto=; b=f
	fK0ZMnyU3lmwYIfXihsMSG29+6bBQkqNDdFNkatho45dBcB8abJA9LJ9SIn7LAcI
	Bepujsj1QhsuIOBcjwlx53cegPMuGwVt6nDLYA8SdKcKVb8um4uKE9zg3pxhL0it
	RRBiEtzcn/JLzeGyq6woJHleqQDvtb046bHuaiWAJvZRT8f5n8fWq8f6CWhFU2iR
	vadPpivK/QNvLVZzFECARYC0JwRIHOlFKg/bfVg9pPEJ3iav/aQhI+w5LmXnU3LR
	6F6JmJ9L/iviAQzBGqbpI61dXZTm0pzImUGIvXQRCeZPFCTPdaNmdZM+Cmme7iS9
	EXpcBe5laLgAL9m+RaS4A==
X-ME-Sender: <xms:VuX-aT8a_1bLr70FuPNxAPmrOFBFXmmAv-VbqiSAk-p9a8e6IeNfMw>
    <xme:VuX-aZA2NPSqZuev1sCjvNhpb7di8DM-FrA-H5jIIXyj_JI-iJPVo3QXB9aSskAMa
    O-JElWZVHKIxfzym7_LMF8xTDBtNSFy4JVad_O7DnzpL476fW5C>
X-ME-Received: <xmr:VuX-aYRqdnYCA-lz8tI73_zw6b6yOlgY3K4lne2qAmj3TBARNeuPdUWw3zwTTd2To4o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddvieeiucetufdoteggodetrf
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
X-ME-Proxy: <xmx:VuX-aQsR_gwyn408-7sPbjGdqsqf3EVa_6rkewe8DBO5Sm8x3EkT9A>
    <xmx:VuX-aU2aqRlSDRMbVcLUfPG3_8Vu5beAVKijAIsEk9v3jK1vOPyQ9Q>
    <xmx:VuX-aRXloVGIBezh_QzYlUr65tPuOVqKuYCiP1f2FCbRruPi05_Seg>
    <xmx:VuX-afJDX4a_KH3W_e-PNFj8VIi1FCI2re_BDLobvbne_9rKLNGxnA>
    <xmx:VuX-aQPAhKnDvfe1_w_GPCrStIAgUqW2u78nuYAax55uuU_zY6edO7Lz>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 03:42:13 -0400 (EDT)
Message-ID: <37d55a0c-7358-455d-9552-c621160bb269@bsbernd.com>
Date: Sat, 9 May 2026 09:42:12 +0200
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <20260509004851.GF7739@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/9/26 02:48, Darrick J. Wong wrote:
> On Fri, May 08, 2026 at 10:59:45AM -0700, Darrick J. Wong wrote:
>> On Fri, May 08, 2026 at 06:51:45PM +0200, Bernd Schubert wrote:
>>>
>>>
>>> On 5/8/26 00:14, Darrick J. Wong wrote:
>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>
>>>> Use the canonical mount flags table in mount_util.c instead of
>>>> opencoding our own version in mount_service.c.
>>>>
>>>> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
>>>> ---
>>>>  util/mount_service.c |   51 +++++++++++++-------------------------------------
>>>>  1 file changed, 13 insertions(+), 38 deletions(-)
>>>>
>>>>
>>>> diff --git a/util/mount_service.c b/util/mount_service.c
>>>> index 8c9747b3928a51..79e5b060ba3356 100644
>>>> --- a/util/mount_service.c
>>>> +++ b/util/mount_service.c
>>>> @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
>>>>  	unsigned int mount_attr_flag;
>>>>  };
>>>>  
>>>> -static const struct ms_to_mount_map attrs[] = {
>>>> -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
>>>> -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
>>>> -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
>>>> -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
>>>> -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
>>>> -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
>>>> -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
>>>> -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
>>>> -#ifdef MOUNT_ATTR_NOSYMFOLLOW
>>>> -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
>>>> -#endif
>>>> -	{ 0, 0 },
>>>> -};
>>>> -
>>>>  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
>>>>  				 unsigned int *attr_flags,
>>>>  				 unsigned long *leftover_ms_flags)
>>>>  {
>>>> -	const struct ms_to_mount_map *i;
>>>> +	const struct mount_flags *i;
>>>>  	unsigned int ms_flags = ntohl(oc->ms_flags);
>>>>  	unsigned int mount_attr_flags = 0;
>>>>  
>>>> -	for (i = attrs; i->ms_flag != 0; i++) {
>>>> -		if (ms_flags & i->ms_flag)
>>>> -			mount_attr_flags |= i->mount_attr_flag;
>>>> -		ms_flags &= ~i->ms_flag;
>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
>>>> +		if (!i->on || !(ms_flags & i->flag))
>>>> +			continue;
>>>> +
>>>> +		mount_attr_flags |= i->mount_attr;
>>>> +		ms_flags &= ~i->flag;
>>>>  	}
>>>>  
>>>>  	*leftover_ms_flags = ms_flags;
>>>>  	*attr_flags = mount_attr_flags;
>>>>  }
>>>>  
>>>> -struct ms_to_str_map {
>>>> -	unsigned long ms_flag;
>>>> -	const char *string;
>>>> -};
>>>> -
>>>> -static const struct ms_to_str_map strflags[] = {
>>>> -	{ MS_SYNCHRONOUS,	"sync" },
>>>> -	{ MS_DIRSYNC,		"dirsync" },
>>>> -	{ MS_LAZYTIME,		"lazytime" },
>>>> -	{ 0, 0 },
>>>> -};
>>>> -
>>>>  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
>>>>  {
>>>> -	const struct ms_to_str_map *i;
>>>> +	const struct mount_flags *i;
>>>>  	int ret;
>>>>  
>>>> -	for (i = strflags; i->ms_flag != 0; i++) {
>>>> -		if (!(ms_flags & i->ms_flag))
>>>> +	for (i = mount_flags; i->opt != NULL; i++) {
>>>> +		if (!i->on || !(ms_flags & i->flag))
>>>>  			continue;
>>>>  
>>>> -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
>>>> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
>>>>  			       NULL, 0);
>>>>  		if (ret) {
>>>>  			int error = errno;
>>>>  
>>>>  			fprintf(stderr, "%s: set %s option: %s\n",
>>>> -				mo->msgtag, i->string, strerror(error));
>>>> +				mo->msgtag, i->opt, strerror(error));
>>>>  			emit_fsconfig_messages(mo);
>>>>  
>>>>  			errno = error;
>>>>  			return -1;
>>>>  		}
>>>> -		ms_flags &= ~i->ms_flag;
>>>> +		ms_flags &= ~i->flag;
>>>>  	}
>>>>  
>>>>  	/*
>>>>
>>>>
>>>
>>>
>>> Hi Darrick,
>>>
>>> wouldn't it make sense to use the functions from mount_fsmount.c? I can
>>> also clean this up later if you want.
>>
>> Oh, hah!  Yes, I'll revise this patch to use them.
> 
> Update: I tried this, but ran into a problem: the two helpers are in
> lib/mount_fsmount.c, which means the object code ends up in libfuse.so.
> Unfortunately, that means that util/mount_service.c can't use them
> unless they're exported from the .so.
> 
> I don't mind doing that, but I feel that I should check with you if it's
> ok to add that to the public libfuse API before doing that?
> 
> Though I think a better solution is to move ms_flags_to_mount_attrs and
> set_ms_flags to mount_util.c because that's compiled into the util/
> programs.
> 
> How about I do that second thing on Monday?


I would prefer the 3rd option, like for fusermount3

executable('fusermount3', ['fusermount.c', '../lib/mount_util.c',
'../lib/mount_fsmount.c', '../lib/util.c'],


I.e. add lib/mount_fsmount.c to mount_service_sources.


Thanks,
Bernd
