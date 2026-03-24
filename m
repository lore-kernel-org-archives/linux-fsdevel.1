Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EE23AF672
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 18:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774377643; cv=none; b=f266ci6/gKHdt6aIAx7HSNu/2tkJP92ja5SLQL3JBpPNxilGpsxtQbnvMNUW6zoWbDk3/UDBIEvjwo8kr7qoIzO1lAMcF4BJY1zQA6tAamqdoDFpGUyvpnt0+FTHG5NufjVh777EzQje1TSULDzI5VgJ5gftEwcgM7LCexint4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774377643; c=relaxed/simple;
	bh=aOS0IiAC3fYu7ZpIOq/knBZeoIL/OzGKhqYozxNMBf4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XusFIfjdpcc5Dl9rbLyn+/VpxD5uZePqj/QWOZK/KUEJ4ofOKqLI/GVX//66fLrapRZZZ5+AOhPwfXcnzwnkr22UmjLNMkCu28VYO/Wsrohwsw1DDPHsDkwHyY+HCn9/zMZuPUOTHN8qbebkfDrh+ryIjuMlM/mD7kOnr7VMXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=UfD1TvGn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UlAsebuh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="UfD1TvGn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UlAsebuh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 622211400199;
	Tue, 24 Mar 2026 14:40:39 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Mar 2026 14:40:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774377639;
	 x=1774464039; bh=uv0+42t2/Xnzecz/cTXsGI9LebhPgA618JghLmlsRKo=; b=
	UfD1TvGnbH20zPUrnyTx/4n3PnORlINuSeN77YXXGYk1ENnIUQxay/B+r15CMl1P
	oXVc3lqVVx1GgizvW2gjuTTYI0zTsXu1o/uGAgkfOUQCo11Jh2KMIkWUIJCav8f7
	zX+R+qxs4GktXYgSluNEq2CD5scG79+6ba7aH7cFdtjJNqjr8UUnX6IoQPza1GRq
	aTiqMSTSaCuc+feGJyVvgWWzatkQAUbFnLtJXMqPzNqfRC02V9EJ+vLI83Q9iD+/
	7yi4V8qoHtLR1t6CLduaG3WZWqWUMKVdY0O5uS5BWS5Za8UQIS372frWV78hhE1x
	mXpTHKjDgPxc/RDh6kYSkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774377639; x=
	1774464039; bh=uv0+42t2/Xnzecz/cTXsGI9LebhPgA618JghLmlsRKo=; b=U
	lAsebuh2q/WfAYowkIvPkVmVkR0j0lrGyQruHuHlMiZDvHMFd0nuHzfFqYcWSWNw
	ZkLCkdGqHnKkkXEWl0tCpSJyVgtoX4OCGPLVLAMKqXuLhYDhOKeTo9472TvXsf9L
	v7sBwSkWcOJIPB2amac5HaWr2o5TdlIoTD4S/NSg2v2uCKwlzMxWcHuI4/6mxcOY
	JSYqUKrVzgq5Ll5ylmb+tNgRjHCLGYrD6efH4413uIgdx86ZniGb5lpdEOJxwY79
	iHRG3Z6XLTSMEoXFhnYFloHbuJOSwAWk/VCDZeHyFh6ljQo4Po/1qcrsSB7KQz4e
	Fqe5rm9qdbUFKyokBMeKw==
X-ME-Sender: <xms:p9rCacVGKtaCvk2F_G6arPBro969BgUryTGCJ3kgDSa7jf_AZTOCiQ>
    <xme:p9rCaXcGXloQRltydtOtBLiGRmMDVxQ3FZd3L5gCoiBD2_Jq5gE6u-Vr_xRWikr6e
    e9pdiWFBx3_bEyt5RqEDpaJDvbsYKQmrPrXDPfoaaHtkPcLog08>
X-ME-Received: <xmr:p9rCaYs9nr7xbBqK-tfMTZlR5J_3yfdCPWoqZwU-DF_HY2uOyg_6gBQtedenHvKRfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddvfeefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:p9rCaW9AcCDOHVU-wjBBUkFCPSDGH5dA-0gUfab1DoPBzeREubtiaA>
    <xmx:p9rCaT3mGIcRODBqBpbZ5DqkFvEseRwruBKXUjmHYMzNY09MM1R6dg>
    <xmx:p9rCabAvrQ4ebI165-JQ0XwJ9_aYUyU66krX9aB1xmbiivMdakBizA>
    <xmx:p9rCafe1DsW-CTs_QkzrgtWCUYG08k1OJjmxRd5q1-V2ILCQYRwQEg>
    <xmx:p9rCaZMGl7j4FjmQwiGRcSVujdE6C7rSPWkWcWlbeT74QBmomftqYTE1>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 14:40:38 -0400 (EDT)
Message-ID: <44f05318-7f58-454f-a09d-2ba0a4523daf@bsbernd.com>
Date: Tue, 24 Mar 2026 19:40:37 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/19] Move mount flags to mount_i.h
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-9-a52d3040af69@bsbernd.com>
 <20260323224529.GK6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260323224529.GK6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/23/26 23:45, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:04PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> This is preparation work for the new mount API, which goes into
>> its own file.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/mount.c         | 59 ++++++++---------------------------------------------
>>  lib/mount_i_linux.h | 35 ++++++++++++++++++++++++++++++-
>>  2 files changed, 42 insertions(+), 52 deletions(-)
>>
>> diff --git a/lib/mount.c b/lib/mount.c
>> index fe353e2cc4579adb47473cac5db7d1bae2defb2c..b3ee9ba4c0a74c1d0d55f916e7046e064f8468b0 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -34,16 +34,6 @@
>>  #include "fuse_mount_compat.h"
>>  
>>  #ifdef __NetBSD__
> 
> Hopefully the rest of the bsd stuff can go in its own files too?

Just created another patch for that.

> 
>> -#include <perfuse.h>
>> -
>> -#define MS_RDONLY	MNT_RDONLY
>> -#define MS_NOSUID	MNT_NOSUID
>> -#define MS_NODEV	MNT_NODEV
>> -#define MS_NOEXEC	MNT_NOEXEC
>> -#define MS_SYNCHRONOUS	MNT_SYNCHRONOUS
>> -#define MS_NOATIME	MNT_NOATIME
>> -#define MS_NOSYMFOLLOW	MNT_NOSYMFOLLOW
>> -
>>  #define umount2(mnt, flags) unmount(mnt, (flags == 2) ? MNT_FORCE : 0)
>>  #endif
>>  
>> @@ -51,10 +41,6 @@
>>  #define FUSE_COMMFD_ENV		"_FUSE_COMMFD"
>>  #define FUSE_COMMFD2_ENV	"_FUSE_COMMFD2"
>>  
>> -#ifndef MS_DIRSYNC
>> -#define MS_DIRSYNC 128
>> -#endif
>> -
>>  enum {
>>  	KEY_KERN_FLAG,
>>  	KEY_KERN_OPT,
>> @@ -154,35 +140,6 @@ void fuse_mount_version(void)
>>  			 FUSERMOUNT_PROG);
>>  }
>>  
>> -struct mount_flags {
>> -	const char *opt;
>> -	unsigned long flag;
>> -	int on;
>> -};
>> -
>> -static const struct mount_flags mount_flags[] = {
>> -	{"rw",	    MS_RDONLY,	    0},
>> -	{"ro",	    MS_RDONLY,	    1},
>> -	{"suid",    MS_NOSUID,	    0},
>> -	{"nosuid",  MS_NOSUID,	    1},
>> -	{"dev",	    MS_NODEV,	    0},
>> -	{"nodev",   MS_NODEV,	    1},
>> -	{"exec",    MS_NOEXEC,	    0},
>> -	{"noexec",  MS_NOEXEC,	    1},
>> -	{"async",   MS_SYNCHRONOUS, 0},
>> -	{"sync",    MS_SYNCHRONOUS, 1},
>> -	{"noatime", MS_NOATIME,	    1},
>> -	{"nodiratime",	    MS_NODIRATIME,	1},
>> -	{"norelatime",	    MS_RELATIME,	0},
>> -	{"nostrictatime",   MS_STRICTATIME,	0},
>> -	{"symfollow",	    MS_NOSYMFOLLOW,	0},
>> -	{"nosymfollow",	    MS_NOSYMFOLLOW,	1},
>> -#ifndef __NetBSD__
>> -	{"dirsync", MS_DIRSYNC,	    1},
>> -#endif
>> -	{NULL,	    0,		    0}
>> -};
>> -
>>  unsigned int get_max_read(struct mount_opts *o)
>>  {
>>  	return o->max_read;
>> @@ -192,13 +149,13 @@ static void set_mount_flag(const char *s, int *flags)
>>  {
>>  	int i;
>>  
>> -	for (i = 0; mount_flags[i].opt != NULL; i++) {
>> -		const char *opt = mount_flags[i].opt;
>> +	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
>> +		const char *opt = fuse_mount_flags[i].opt;
>>  		if (strcmp(opt, s) == 0) {
>> -			if (mount_flags[i].on)
>> -				*flags |= mount_flags[i].flag;
>> +			if (fuse_mount_flags[i].on)
>> +				*flags |= fuse_mount_flags[i].flag;
>>  			else
>> -				*flags &= ~mount_flags[i].flag;
>> +				*flags &= ~fuse_mount_flags[i].flag;
>>  			return;
>>  		}
>>  	}
>> @@ -645,9 +602,9 @@ static int get_mnt_flag_opts(char **mnt_optsp, int flags)
>>  	if (!(flags & MS_RDONLY) && fuse_opt_add_opt(mnt_optsp, "rw") == -1)
>>  		return -1;
>>  
>> -	for (i = 0; mount_flags[i].opt != NULL; i++) {
>> -		if (mount_flags[i].on && (flags & mount_flags[i].flag) &&
>> -		    fuse_opt_add_opt(mnt_optsp, mount_flags[i].opt) == -1)
>> +	for (i = 0; fuse_mount_flags[i].opt != NULL; i++) {
>> +		if (fuse_mount_flags[i].on && (flags & fuse_mount_flags[i].flag) &&
>> +		    fuse_opt_add_opt(mnt_optsp, fuse_mount_flags[i].opt) == -1)
>>  			return -1;
>>  	}
>>  	return 0;
>> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
>> index abcd1b08012feedef6b4c8961b55ac847a27496a..c0de6228fce5a4d9070cc246ec76222b66de56fb 100644
>> --- a/lib/mount_i_linux.h
>> +++ b/lib/mount_i_linux.h
>> @@ -10,7 +10,8 @@
>>  #ifndef FUSE_MOUNT_I_H_
>>  #define FUSE_MOUNT_I_H_
>>  
>> -/* Forward declaration for fuse_args */
>> +#include <sys/mount.h>
>> +
>>  struct fuse_args;
>>  
>>  /* Mount options structure */
>> @@ -28,5 +29,37 @@ struct mount_opts {
>>  	unsigned int max_read;
>>  };
>>  
>> +/* Mount flags mapping structure */
>> +struct mount_flags {
>> +	const char *opt;
>> +	unsigned long flag;
>> +	int on;
>> +};
>> +
>> +/* Mount flags table */
>> +static const struct mount_flags fuse_mount_flags[] = {
> 
> Hmmm, doesn't this create a fuse_mount_flags[] in every single .o file
> that #includes this header?  I'd have thought you'd want an extern
> declaration here and a definition elsewhere?

Uh oh, thanks for spotting that. Fixed.

> 
>> +	{"rw",			MS_RDONLY,      0},
>> +	{"ro",			MS_RDONLY,      1},
>> +	{"suid",		MS_NOSUID,      0},
>> +	{"nosuid",		MS_NOSUID,      1},
>> +	{"dev",			MS_NODEV,       0},
>> +	{"nodev",		MS_NODEV,       1},
>> +	{"exec",		MS_NOEXEC,      0},
>> +	{"noexec",		MS_NOEXEC,      1},
>> +	{"async",		MS_SYNCHRONOUS, 0},
>> +	{"sync",		MS_SYNCHRONOUS, 1},
>> +	{"noatime",		MS_NOATIME,     1},
>> +	{"nodiratime",		MS_NODIRATIME,  1},
>> +	{"norelatime",		MS_RELATIME,    0},
>> +	{"nostrictatime",	MS_STRICTATIME, 0},
>> +	{"symfollow",		MS_NOSYMFOLLOW, 0},
>> +	{"nosymfollow",		MS_NOSYMFOLLOW, 1},
>> +#ifndef __NetBSD__
> 
> When would we have __NetBSD__ defined on a Linux build?
> 
> Though I see no meson.build changes here, so I can't tell if
> mount_i_linux.c only gets built on Linux or everywhere or ...?

mount_i_linux.h should be included in files used by linux only. Same
as mount.c. Next patch removes this BSD condition.


Thanks,
Bernd

> 
> --D
> 
>> +	{"dirsync", MS_DIRSYNC,     1},
>> +#endif
>> +	{NULL,      0,          0}
>> +};
>> +
>> +
>>  
>>  #endif /* FUSE_MOUNT_I_H_ */
>>
>> -- 
>> 2.43.0
>>
>>

