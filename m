Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644573090CD
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Mar 2026 20:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774385847; cv=none; b=JFw1tAgpprcN1AA++JjQtSvFo0WBUWTstMkh62NcTqsqyrxNFKDWQKLHpcAcmG3MCyi6GAzVLhWtVBFvsimtcXWoOfh5tXrTZfidn8wn9zcUYEbIsIOFSabe0ms611eGXFq7yznEkMkp2b87ziAFOZqu4qFZlZWi8TY96G17yMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774385847; c=relaxed/simple;
	bh=l+zJUoGSb8e/UgageazLBK494NRBfCQFbkIIpuWq3nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PS9WPXll6vP60bXDMKSKi9k5s3NoN65QkW3HxaST1BPVIlMLasriJ1RIJXhsA1rBbT2H93UWaPQJ1/mIldd6qfl3GOHHqtCnMpv58ylCv1m4dJWvhnKVhSGBIqmdR9O+rvLZ0l4KYzYsP/QOcRDDpmEJQPrdg3y3wLCzYvEFcHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com; spf=pass smtp.mailfrom=bsbernd.com; dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b=RzErnqTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gurxNtK0; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bsbernd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bsbernd.com header.i=@bsbernd.com header.b="RzErnqTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gurxNtK0"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A9EFC1400161;
	Tue, 24 Mar 2026 16:57:25 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 24 Mar 2026 16:57:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bsbernd.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774385845;
	 x=1774472245; bh=6/VX828sSPQSRNj6tUyafeoB40wUX0Y7Q97ow4zc268=; b=
	RzErnqTAu3qMf946v78iKkKrcAnPNbETonS2Eas4Zfsz11xNkcIQlSkx/KfhlrNc
	jrea7wopf/OG9/dl6/i08caVYbIskYas0A2CKOVaLzPFlsTWuQKGwJ9I1tsIEc2R
	SevrjfcvG6HeqBYqZMT2TioIVl6ZR5PGvd7Y5SUo4YJipJ1EioPZ+/ucMHlPXLRm
	yTUnbr6Ak/JMH7RqHnRmNV+MF/K7eIZ3uYOzbu7FXf9oCIA7WQSnXY+6EKpV4cd+
	slqd9M7m+3QTqDq6YWcQJBwAXuACP995JQruPhDE3n9ZUmW8xnDUfm8YXl6I6757
	jJTY7UwL59vcP0cPPluTpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774385845; x=
	1774472245; bh=6/VX828sSPQSRNj6tUyafeoB40wUX0Y7Q97ow4zc268=; b=g
	urxNtK0mKjAWkg57oKthl7VDv5jCIECWkNLOFXm6CGOsgJiP5P3omsngJCUzVKC3
	jBpgVzaz7T9+2bFD/n7W6PIi20Gtc0Eg0h0uQGVLnmcXLV3qXf2r1Sd9dSA6kgc7
	jrwfFtF/6pJW2NazlyWtSk+puWDoSAejBbKekmWcAC8AQ4+az4LMECTcbn7H45UY
	n25uIze2S1Zo86e8GmK0laROyF0GEO7qn+dvIhfOvk6nN76Pvdrpgd/imotHHQK/
	e+vtzn2EEUlt4Op1Xy7d2P9uQ52Hyl4oV1GKi1b2zhjUSY6jwqJ53c1iTSf4iz0q
	gGSk6qAnpvjVwOUTybHLA==
X-ME-Sender: <xms:tfrCaQ6TsN5d_ZY0hWEm1P3IwL6zigEVsxjy1d1wNE4xllHLHYaV6g>
    <xme:tfrCaYwXYkXoqZU3n-6oDadND6vgDE__Lvzme4IrJYduYuxBJngmdjsC-fBG2c6F0
    -biWIJvomSBykL_nY3iMOgSaFn0kiOXJ4ti961--KorPIFAybh2>
X-ME-Received: <xmr:tfrCaXxhDmz4g6iwCSWBbNgQ6O2Ury9Z9B7066qNwJGXOq7WvfwnU9cldVkeS680kg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvddviedtucetufdoteggodetrf
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
X-ME-Proxy: <xmx:tfrCaQwUptkwe9PGn_V2HN_a9PjN6fXkOc4bHhkzA0IckSyh3rptRw>
    <xmx:tfrCaRYO3_nGF6e3Poikp_Ut3cLs35RJVQoTTqFDYzgFILqY8gPTuQ>
    <xmx:tfrCaRUd5d5uQjpY7kCVQAHNrJF17YknBrZZTCoh_wezPcIfEomiXQ>
    <xmx:tfrCafiHQxtx5BuTIyMW4hHYJaUm0BFGMkCttAbRNZF-gzQEcQfgqQ>
    <xmx:tfrCaUbSM8kMc4J5Pkn_LRDF4qVqL4vYJfkRUyxvKBpDaqUgqDbBUfe6>
Feedback-ID: i5c2e48a5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 16:57:24 -0400 (EDT)
Message-ID: <e5baf579-56f4-4647-b85e-3e6557c32aa1@bsbernd.com>
Date: Tue, 24 Mar 2026 21:57:23 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/19] Move more generic mount code to mount_util.{c,h}
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
 Joanne Koong <joannelkoong@gmail.com>, Bernd Schubert <bschubert@ddn.com>
References: <20260323-fuse-init-before-mount-v1-0-a52d3040af69@bsbernd.com>
 <20260323-fuse-init-before-mount-v1-14-a52d3040af69@bsbernd.com>
 <20260324000654.GO6202@frogsfrogsfrogs>
From: Bernd Schubert <bernd@bsbernd.com>
Content-Language: en-US
In-Reply-To: <20260324000654.GO6202@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/24/26 01:06, Darrick J. Wong wrote:
> On Mon, Mar 23, 2026 at 06:45:09PM +0100, Bernd Schubert wrote:
>> From: Bernd Schubert <bschubert@ddn.com>
>>
>> This is to allow fusermount to use the code from mount_fsmount.c.
>> I.e. avoid code dup and add just re-use the new linux api mount
>> functions from that file for fusermount.
>>
>> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
>> ---
>>  lib/mount.c          |  7 -------
>>  lib/mount_common_i.h |  2 --
>>  lib/mount_i_linux.h  |  3 ++-
>>  lib/mount_util.c     | 10 ++++++++++
>>  lib/mount_util.h     |  5 +++++
>>  5 files changed, 17 insertions(+), 10 deletions(-)
>>
>> diff --git a/lib/mount.c b/lib/mount.c
>> index 12df49d9109cf918cc41aa75c5fdf84231d4d5ff..263b05051c236458b830c40181bce7f494803800 100644
>> --- a/lib/mount.c
>> +++ b/lib/mount.c
>> @@ -720,13 +720,6 @@ out:
>>  	return res;
>>  }
>>  
>> -const char *fuse_mnt_get_devname(void)
>> -{
>> -	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
>> -
>> -	return devname ? devname : "/dev/fuse";
>> -}
>> -
>>  char *fuse_mnt_build_source(const struct mount_opts *mo)
>>  {
>>  	const char *devname = fuse_mnt_get_devname();
>> diff --git a/lib/mount_common_i.h b/lib/mount_common_i.h
>> index d27d2aa624ae3806c61a0fe382c2d024080c9bb3..b015e8f98d46980891216e93358aae9f7836d156 100644
>> --- a/lib/mount_common_i.h
>> +++ b/lib/mount_common_i.h
>> @@ -24,8 +24,6 @@ struct mount_opts;
>>  struct mount_opts *parse_mount_opts(struct fuse_args *args);
>>  void destroy_mount_opts(struct mount_opts *mo);
>>  unsigned int get_max_read(struct mount_opts *o);
>> -char *fuse_mnt_build_source(const struct mount_opts *mo);
>> -char *fuse_mnt_build_type(const struct mount_opts *mo);
>>  
>>  
>>  #endif /* FUSE_MOUNT_COMMON_I_H_ */
>> diff --git a/lib/mount_i_linux.h b/lib/mount_i_linux.h
>> index 52eab9e650c055142feec329264f82c2b08be0d5..867105019fa57576682091d1a650302f31e450b3 100644
>> --- a/lib/mount_i_linux.h
>> +++ b/lib/mount_i_linux.h
>> @@ -74,6 +74,7 @@ int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>>  
>>  int fuse_kern_fsmount_mo(const char *mnt, struct mount_opts *mo,
>>  			 const char *mnt_opts);
>> -
>> +char *fuse_mnt_build_source(const struct mount_opts *mo);
>> +char *fuse_mnt_build_type(const struct mount_opts *mo);
> 
> These are linux-only things?  I thought they applied to BSD too and
> should go in mount_util.h...

mount_bsd.c has its own definition of "struct mount_opts *mo" and I
don't want to update that code, until we have full BSD tests. So far the
github BSD test only compiles, but doesn't run the actual tests.

> 
>>  #endif /* FUSE_MOUNT_I_H_ */
> 
> ...but I'm now terribly confused, is mount_i_linux.h just the symbols
> needed to build on Linux, or to build anywhere?

I updated the earlier patch that introduced mount_i_linux.h

#ifndef FUSE_MOUNT_I_LINUX_H_
#define FUSE_MOUNT_I_LINUX_H_

> 
>> diff --git a/lib/mount_util.c b/lib/mount_util.c
>> index a42a02a0b92f98778abb2c491cdc7a01260f56ee..6a7908cb74b429a1ffd811678cfd39c35093b265 100644
>> --- a/lib/mount_util.c
>> +++ b/lib/mount_util.c
>> @@ -10,6 +10,9 @@
>>  
>>  #include "fuse_config.h"
>>  #include "mount_util.h"
>> +#ifdef __linux__
>> +#include "mount_i_linux.h"
>> +#endif
>>  
>>  #include <stdio.h>
>>  #include <unistd.h>
>> @@ -399,3 +402,10 @@ int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
>>  	(void)mnt_opts;
>>  	return 0;
>>  }
>> +
>> +const char *fuse_mnt_get_devname(void)
>> +{
>> +	const char *devname = getenv(FUSE_KERN_DEVICE_ENV);
>> +
>> +	return devname ? devname : "/dev/fuse";
>> +}
>> diff --git a/lib/mount_util.h b/lib/mount_util.h
>> index 4688d00091f001b3ccd36b1ef3b7e799031ed773..00397943a46a58e640d15b0c0531e5bc6e76006b 100644
>> --- a/lib/mount_util.h
>> +++ b/lib/mount_util.h
>> @@ -6,6 +6,9 @@
>>    See the file LGPL2.txt.
>>  */
>>  
>> +#ifndef FUSE_MOUNT_UTIL_H_
>> +#define FUSE_MOUNT_UTIL_H_
> 
> This is a positive development, at least :)
> 
> --D
> 
>> +
>>  #include <sys/types.h>
>>  #include "mount_common_i.h" // IWYU pragma: keep
>>  
>> @@ -22,3 +25,5 @@ int fuse_mnt_parse_fuse_fd(const char *mountpoint);
>>  const char *fuse_mnt_get_devname(void);
>>  int fuse_mnt_add_mount_helper(const char *mnt, const char *source,
>>  			       const char *type, const char *mnt_opts);
>> +
>> +#endif /* FUSE_MOUNT_UTIL_H_ */
>>
>> -- 
>> 2.43.0
>>
>>


Thanks,
Bernd

