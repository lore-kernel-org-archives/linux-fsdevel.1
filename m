Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A1F3DE429
	for <linux-fsdevel@vger.kernel.org>; Tue,  5 May 2026 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777966927; cv=none; b=k7aGf7GPk8c7cw3TlHHmb8BPn6D6fqTqaiHlgH07dMzxqqX/aIeJNSCPuN4chSzqhXItrV6cHNJf8J18qY3AIkx4WhWCbXBVSBNurFzMqrREJgMhFu7aU5y1U08IWyYM+CpflHt5YIf2ZRcVezpnO4ebs1RDaYJrUr/6dqnaicc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777966927; c=relaxed/simple;
	bh=015x3tZSrQSHbVJPhw1RXoNoX9fH+nEeMR8ZEhpOfk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NTmupWhCXvhMiljqs/ypNJ8Resb9FLPXeMr0BMt8fXTypSeKz16fmA1fuzi+XM8pF556ki1vsO3uyvPh2l2vaLo4OEwtujrz0bVeSqSL92y/y1YxRl95C5LTSIJhVQ9H+l8dVZoUenrshFi5sNJnFBn3DdK+FTtdQ+5LZ48m5fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=eEDD1uYt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K2N5TkU7; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="eEDD1uYt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K2N5TkU7"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D08A8140002F;
	Tue,  5 May 2026 03:42:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 May 2026 03:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777966923;
	 x=1778053323; bh=WUj5qGZXtgqTHeKTZGxwLw0uKYyn5Z942FTCLutI7QE=; b=
	eEDD1uYt08piXA5CbWBQYV2uPAI6ozwBQZ7dvPfi8qZ2f1rhHGgP+VTeT+5xnVqe
	hIeSkQKGPeLs7L79yPXCpTPHjTzkRMgDiwErx646v7zH6VNv9T1979mjFmYRErLT
	CPs4Wg91QtcbYEZYQ3DtyEu8ifrlztTxf9LZKt3ZN+asnXV16OUDBw+qbxRNh+K6
	yz+Ancrjt35EMBC1faubQnM1PSmCnAzuX6wTmtkqZnkB+SSc8DhxBXOgNFyJIGCU
	EK5qGYR//PKgvbQpzOXIMCv5G+9e7dISGN8lqHLxn0kA35To1zaokdEYtqsLPGDo
	O+SXbJp4E4EKx3b/8XjnaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1777966923; x=
	1778053323; bh=WUj5qGZXtgqTHeKTZGxwLw0uKYyn5Z942FTCLutI7QE=; b=K
	2N5TkU7MTKwe87MjKxnElpFs5WuC7vLJN5QOlttZu89S0SmdyP99J/2DFgEAXWwo
	8g8ZFBOoCPK05cS/dr1plcNGjwrtSYLdIxRhvlI+AvTzuwjLmn/7T/TLCX93jSDw
	DbF08pvRGTUrE68ZH2dOvW717joL0Z/Wb6/lwW6BDyRgF1qmqSbkWX1Biv4AI/M5
	QeU3ffKPA1kIJmk45yZz5BXNWTxHufnE1gWI63HlrgvX+ryls7dZmJW9LyXhEVPI
	npnn3jJDh2R5+LkJAmpKHeQzHt0xGEJaebcsT+pbFn4+sRZBnMd5+1DFYVTvkx6m
	dt2CyoJue/uPvJt2WW/Zg==
X-ME-Sender: <xms:S5_5aQpJdzyIVAmChRFf7Xms18jo0vjSotlCaEEyatbQKhk39mWcTQ>
    <xme:S5_5af-Ejs_9rvWMk_yjUT_DbOb-6-MUuX5wuYBppLgf6tBGTcjRiHtBRySEPxf8u
    R7Uv4GVj7BvOxA3YFmRrfOJb0QoDoFXcUu5pwXZU9joWgytpg>
X-ME-Received: <xmr:S5_5aceJtY4-WWhpxVl-61m-3o3y3v4c3D7VOzc1adpogV2rEJLSkyt9LmwzMZdvoak>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeuvghrnhgu
    ucfutghhuhgsvghrthcuoegsvghrnhgusegsshgsvghrnhgurdgtohhmqeenucggtffrrg
    htthgvrhhnpeehhfejueejleehtdehteefvdfgtdelffeuudejhfehgedufedvhfehueev
    udeugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsvghrnhgusegsshgsvghrnhgurdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepjhhorghnnhgvlhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    nhgvrghlsehgohhmphgrrdguvghvpdhrtghpthhtohepfhhushgvqdguvghvvghlsehlih
    hsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihhklhhoshesshiivghrvg
    guihdrhhhu
X-ME-Proxy: <xmx:S5_5aZKSuAE51p21gV65XlQybFkUP-loG46fjkNDKkhFArK59XMVdQ>
    <xmx:S5_5acgK5ldBAV5uA3hNjzXnL_sZjZxKcuA1Q-hhjMK0vTx8-xToYA>
    <xmx:S5_5aXRL0Hmd6m75gT0xqbLEPZ6dcnVAFajTTCrSoHc7pEEhIZJ0tg>
    <xmx:S5_5aWU0rhP4nuqBe6qrJkbuy71lNzGsZgYycI75Tp9nkU8owVpG3A>
    <xmx:S5_5aV7Uqi5SitkI81ff5GS0-m1hexgbANoeQkqOCRipJnAlEaVF49eM>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 May 2026 03:42:01 -0400 (EDT)
Message-ID: <3b37a5be-c3c8-461d-8382-04ae86de81cc@bsbernd.com>
Date: Tue, 5 May 2026 09:41:59 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] libfuse: always send the subtype to the kernel when
 using fsconfig()
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: joannelkoong@gmail.com, neal@gompa.dev, fuse-devel@lists.linux.dev,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu
References: <177795853450.1133476.8692790530314969678.stgit@frogsfrogsfrogs>
 <177795853491.1133476.14673788941960394877.stgit@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: fr, en-US
In-Reply-To: <177795853491.1133476.14673788941960394877.stgit@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/5/26 07:23, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Although it's possible to supply a filesystem subtype when calling
> fsopen(), it does not pass the stuff after the dot to the mount option
> parsing mechanism like the legacy mount() call does.  Therefore, it's
> necessary to pass the subtype explicitly via fsconfig() or else the
> subtype will be missing from the /proc/mounts output.
> 
> For example, fuse4fs with the old mount API produces this:
> 
> /dev/sda /mnt fuse.ext4 rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0
> 
> But with the new mount API, we only get:
> 
> /dev/sda /mnt fuse rw,nosuid,nodev,relatime,user_id=0,group_id=0 0 0
> 
> ...which breaks fstests, which requires the fsname to match the string
> that it passes to mount -t.  Update the comment in mount_service.c to
> match this requirement.
> 
> Fixes: 14cb7b93bb9688 ("Add support for the new linux mount API")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---
>  lib/mount_fsmount.c  |   13 +++++++++++++
>  util/mount_service.c |    3 ++-
>  2 files changed, 15 insertions(+), 1 deletion(-)
> 
> 
> diff --git a/lib/mount_fsmount.c b/lib/mount_fsmount.c
> index 615271b09758c3..5e13b34ccfc610 100644
> --- a/lib/mount_fsmount.c
> +++ b/lib/mount_fsmount.c
> @@ -359,6 +359,19 @@ int fuse_kern_fsmount(const char *mnt, unsigned long flags, int blkdev,
>  		goto out_free;
>  	}
>  
> +	/* Configure subtype */
> +	if (subtype) {
> +		res = fsconfig(fsfd, FSCONFIG_SET_STRING, "subtype",
> +			       subtype, 0);
> +		if (res) {
> +			err = -errno;
> +			log_fsconfig_kmsg(fsfd);
> +			fprintf(stderr, "fuse: fsconfig subtype failed: %s\n",
> +				strerror(-err));
> +			goto out_free;
> +		}
> +	}
> +
>  	/* Configure source */
>  	res = fsconfig(fsfd, FSCONFIG_SET_STRING, "source", source, 0);
>  	if (res == -1) {

Oh yes, that had slipped through. Going to apply this.

> diff --git a/util/mount_service.c b/util/mount_service.c
> index bc5940bc900dad..3fbabfdd69300d 100644
> --- a/util/mount_service.c
> +++ b/util/mount_service.c
> @@ -821,7 +821,8 @@ static void try_fsopen(struct mount_service *mo)
>  	/*
>  	 * As of Linux 7.0 you can pass subtypes to fsopen, but the manpage for
>  	 * fsopen only says that you can pass any value of the second column of
> -	 * /proc/filesystems into fsopen.
> +	 * /proc/filesystems into fsopen.  You must still call fsconfig() for
> +	 * the subtype separately, however.
>  	 */
>  	mo->fsopenfd = fsopen(fsname(mo), FSOPEN_CLOEXEC);
>  }
> 

Can we integrate that into you series separately, as it is not merged yet?


Thanks,
Bernd
