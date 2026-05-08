Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CD2FFDD6
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 May 2026 16:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259109; cv=none; b=LODKzVK88UnLEc4T9wyuCH3Ydj8O0ejV9zWGWNyT7flEdE0oLcplZ2bLKmpGez26OtgX8QkwknDBy7wNLNvEDC/SoF1S6Or5cQSOQiETTMnX5rAiARFxhzAmAkauPmAQmMLeWreQYH62JxL8Z83tqGr/EXX1s1wdzD67CTj+JAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259109; c=relaxed/simple;
	bh=KwhyhU6GWB8dyS+6T2LivBuh1jWPL9GtOF3cJt9OZoc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnBnz42E0WtUF4UaP+nTGUrJfnJ4UK6WnElAqtHQa5uU3huOD/gk7vQBRxgsQEhrURN4oSpMZExvZAEBNsZ0/E7oEq5U2vn+X0+ut6H8q8+NLrgL7fwye1QLEX/BPhJcgzQOQxwncLnvPNcPOQT304XyuJ4G++qKDGXSgi7/2mY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=ZyBUiMlP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gSRQ+b0M; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="ZyBUiMlP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gSRQ+b0M"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D5DF0EC007B;
	Fri,  8 May 2026 12:51:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 08 May 2026 12:51:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1778259106;
	 x=1778345506; bh=WhMyh39OUaLKyibfwzXpRIdbFYe5jNx2zZQRlX+Fey0=; b=
	ZyBUiMlPI8DEJBUGdoQ0LdLEY7Hd1Bb7/mn70zV/YN1m6gfs41G7WJUR9lIOME20
	bYccnRuyb7+8Qz2dWdG14p+g1Xo1rvqo1/LKr2OdqtLEWoWO7drxwdpo3CrRxsNa
	XNeDeiqaxIAl+njkNjVlZlbDLiyORukYua1HRU0k1uSuC4XBGgXbU7IWyK8NnDhh
	bmqP4iNO13qI4wKQzoB6u6loLDmYzFlfAkZ/JjI+naFhPxQFWUzGzRIQ9my4TtlM
	n1rIaEBcYgsXSFxGwIq13b+zcypbZpdngz3qqk+pPhfvuBz3/RzRH8pXJ/+ITvCc
	Om4/pu+7cyBVUTxETF9kCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778259106; x=
	1778345506; bh=WhMyh39OUaLKyibfwzXpRIdbFYe5jNx2zZQRlX+Fey0=; b=g
	SRQ+b0M2ib/sBxZvgszunAJ3haVx/Ir07nczmbrhSV4S5PFWgqtOa8NP99+5YZRx
	q/W1dIT4C1TB89K1BMbCXJkgZFt5PbvP+KPlJf0EHhD6zqmVc1wAvJXd11KMWkGV
	3z8hCVmANINgpNLTDGgKONlO9hupNe2dG1ap2KIpdX3d/32pimc2bV20nH7FAkLn
	gxk0yfyW++lYBjdMhHXzvJhJD7sOBs/7UnVTTCLEny6P7A+/5GMfncGVT/ovGkd/
	uEA5Q6tRs3AyoqF5QQdov0QTxmhvapAeBTiNgLtFog2zvfTPajT/AT1VcXvdPtOO
	o//l79TCsDskC47ZCTguA==
X-ME-Sender: <xms:ohT-aSImbxARI_E8pGO9I9Pk7BhgvlgsuvqWqnoS1NU99b2Wz_MrRg>
    <xme:ohT-aTc422JDy9ECcPH3_UnqjJkIGpmIrwK35YReCI5SWUbYeLIXKLS07jAl7pXnk
    cNmMWdVrZOIcc3Fn4Jb-8dqA5FDPuh8RUrLlnDkS39w8sppSEke>
X-ME-Received: <xmr:ohT-aZ8oAvfL600dA9hKDyZ3ETuBzs6Js3Wy6TCGVO5ewY9z6VxcLNxrNY3RKT1LSP35OdWFAgNyIlsE838y-whCZPSmFBuv3EcQMPvPrn-xvmaewg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtkeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ohT-aYpELgACwEeZpBeUVVAWQ_Op5SBJIsJB7Gx-nxv8I1oP1GMNDw>
    <xmx:ohT-aWChh46I_jfvxRusFYM_wxOS7Po_onbxJnmQgMJ9lTGaod707Q>
    <xmx:ohT-aSz6CY4JNXj-SF9adeKLEBDk7VUclcg1NgHkXfHD0Juy01DaHQ>
    <xmx:ohT-ab3o1iQ12p7dNrjurYwUjrIfijEfxku7BB_QLY5oMv43LCffsw>
    <xmx:ohT-afYBP4hVI84pBzp2Ih_HFK2U7XBK7qOQe_lfX0Eym2tHWeFmXDF4>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 12:51:45 -0400 (EDT)
Message-ID: <45b102f5-423f-40de-887a-a54772a8504b@bsbernd.com>
Date: Fri, 8 May 2026 18:51:45 +0200
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
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US, de-DE, ru-RU
In-Reply-To: <177819198067.3490792.2943381236495611249.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/8/26 00:14, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Use the canonical mount flags table in mount_util.c instead of
> opencoding our own version in mount_service.c.
> 
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  util/mount_service.c |   51 +++++++++++++-------------------------------------
>  1 file changed, 13 insertions(+), 38 deletions(-)
> 
> 
> diff --git a/util/mount_service.c b/util/mount_service.c
> index 8c9747b3928a51..79e5b060ba3356 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -1457,73 +1457,48 @@ struct ms_to_mount_map {
>  	unsigned int mount_attr_flag;
>  };
>  
> -static const struct ms_to_mount_map attrs[] = {
> -	{ MS_RDONLY,		MOUNT_ATTR_RDONLY },
> -	{ MS_NOSUID,		MOUNT_ATTR_NOSUID },
> -	{ MS_NODEV,		MOUNT_ATTR_NODEV },
> -	{ MS_NOEXEC,		MOUNT_ATTR_NOEXEC },
> -	{ MS_RELATIME,		MOUNT_ATTR_RELATIME },
> -	{ MS_NOATIME,		MOUNT_ATTR_NOATIME },
> -	{ MS_STRICTATIME,	MOUNT_ATTR_STRICTATIME },
> -	{ MS_NODIRATIME,	MOUNT_ATTR_NODIRATIME },
> -#ifdef MOUNT_ATTR_NOSYMFOLLOW
> -	{ MS_NOSYMFOLLOW,	MOUNT_ATTR_NOSYMFOLLOW },
> -#endif
> -	{ 0, 0 },
> -};
> -
>  static void get_mount_attr_flags(const struct fuse_service_mount_command *oc,
>  				 unsigned int *attr_flags,
>  				 unsigned long *leftover_ms_flags)
>  {
> -	const struct ms_to_mount_map *i;
> +	const struct mount_flags *i;
>  	unsigned int ms_flags = ntohl(oc->ms_flags);
>  	unsigned int mount_attr_flags = 0;
>  
> -	for (i = attrs; i->ms_flag != 0; i++) {
> -		if (ms_flags & i->ms_flag)
> -			mount_attr_flags |= i->mount_attr_flag;
> -		ms_flags &= ~i->ms_flag;
> +	for (i = mount_flags; i->opt != NULL; i++) {
> +		if (!i->on || !(ms_flags & i->flag))
> +			continue;
> +
> +		mount_attr_flags |= i->mount_attr;
> +		ms_flags &= ~i->flag;
>  	}
>  
>  	*leftover_ms_flags = ms_flags;
>  	*attr_flags = mount_attr_flags;
>  }
>  
> -struct ms_to_str_map {
> -	unsigned long ms_flag;
> -	const char *string;
> -};
> -
> -static const struct ms_to_str_map strflags[] = {
> -	{ MS_SYNCHRONOUS,	"sync" },
> -	{ MS_DIRSYNC,		"dirsync" },
> -	{ MS_LAZYTIME,		"lazytime" },
> -	{ 0, 0 },
> -};
> -
>  static int set_ms_flags(struct mount_service *mo, unsigned long ms_flags)
>  {
> -	const struct ms_to_str_map *i;
> +	const struct mount_flags *i;
>  	int ret;
>  
> -	for (i = strflags; i->ms_flag != 0; i++) {
> -		if (!(ms_flags & i->ms_flag))
> +	for (i = mount_flags; i->opt != NULL; i++) {
> +		if (!i->on || !(ms_flags & i->flag))
>  			continue;
>  
> -		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->string,
> +		ret = fsconfig(mo->fsopenfd, FSCONFIG_SET_FLAG, i->opt,
>  			       NULL, 0);
>  		if (ret) {
>  			int error = errno;
>  
>  			fprintf(stderr, "%s: set %s option: %s\n",
> -				mo->msgtag, i->string, strerror(error));
> +				mo->msgtag, i->opt, strerror(error));
>  			emit_fsconfig_messages(mo);
>  
>  			errno = error;
>  			return -1;
>  		}
> -		ms_flags &= ~i->ms_flag;
> +		ms_flags &= ~i->flag;
>  	}
>  
>  	/*
> 
> 


Hi Darrick,

wouldn't it make sense to use the functions from mount_fsmount.c? I can
also clean this up later if you want.
I guess this doesn't handle the case for "ro" going into fsmount() and
fsconfig() yet - update now or later?


Thanks,
Bernd




