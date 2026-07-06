Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D03287257
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783370864; cv=none; b=Ai7xkORjjDGRrckVlBLL8fgsf5Msmn8bfclsk94W/u3p7OdaKLRUkThwhkAnYVXcMKYZljvsbzphkk+JkGs6OLcBrKD829g+y6I1GPDG4usgcjLORpMk4U9/iICo4Eh++OWukF7ceba0cfPd7YqJGOXF6HylWyjDoQFqm15yUak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783370864; c=relaxed/simple;
	bh=Lf93dUdHxBVLUDJymnZHFJwRoBGrs7hdj6qLUcfZ+fs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=na8mlort7UlOQxS/cesjUwq16tCRjhDu2dO6GDlBySse14c2ZbPLtyD8aa41AJy3oOeh9HRcmoGFJhaRE1RsRSQLaO/ROJQN1O4bUxsjbmpAWrclq7T+c3zU7j0iaN/2iBRo/38SvmMMftgOslg7eEmHKUB40zaLZDT8zYUMLYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=ifcKmAwV; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="ifcKmAwV"
X-KPN-MessageId: e96977e5-797b-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id e96977e5-797b-11f1-a59f-005056994fde;
	Mon, 06 Jul 2026 22:47:32 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id e9687087-797b-11f1-ae6a-0050569981f5;
	Mon, 06 Jul 2026 22:47:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=gf7ZbOddbbb1kDXO7xeT4kT27RWicQybeKhWT4sl+sI=;
	b=ifcKmAwVCmzhz5GF6a/bFNh54i+MS8rgyN+Wl3BjkSlAvj0pfGtlSJA23UES8Ij5xnZR7RUnA59fm
	 K0R0V4A/nBS4c1RqGxNtJLS54gqeDum6kMuMHHwU99+PWl5BJ28hQhiyycHq5lw+YwBRiTPHCJ38pP
	 e03rYhGb+swwMPKH3gPGpfjwJUtBGRFE2PV59MUAlEwo2qm6vTBuVMRUbn8gAiEoyn3xcr2TPzktld
	 BKC5v/jrSgJLcEceg4AC0L6wfSUpa2fI8RAIKPBrEuh2CjF+G9/rt7N4DHmMte/mh8+20ZEZEbkXAL
	 Vh1HApbpo1EqiO72DvSM5tbQmZfOrmw==
X-KPN-MID: 33|qpoOXjdBbpHAHqy/MiySwHleOCtEnYeXtEGtcqJQyUFrsFXCDFdnTFcZPeeuARN
 fpsOZYREibiO+ZOnlroB2Ag==
X-CMASSUN: 33|0XNythghk88H6Uf/HdyRbBMKNhYRKgG//TXVDnUFUABkP6l3y/OAbhFl0iZmyp8
 VryUgRO0ZFiYpuNNK9yBoXQ==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id e9545efe-797b-11f1-916a-005056995d6c;
	Mon, 06 Jul 2026 22:47:32 +0200 (CEST)
Date: Mon, 6 Jul 2026 22:47:32 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Jeremy Bingham <jbingham@gmail.com>, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, brauner@kernel.org, jack@suse.cz
Message-ID: <942891560.128364.1783370852771@kpc.webmail.kpnmail.nl>
In-Reply-To: <7d62598a8be99c6218d05bfca56bc37f1e634a49.1783360491.git.jbingham@gmail.com>
References: <cover.1783360491.git.jbingham@gmail.com>
 <7d62598a8be99c6218d05bfca56bc37f1e634a49.1783360491.git.jbingham@gmail.com>
Subject: Re: [PATCH 1/2] minix: define constants for dirsize and namelen
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 06-07-2026 20:22 CEST schreef Jeremy Bingham <jbingham@gmail.com>:
> 
>  
> The different versions of the minix fs have different values for
> directory size and name length. Versions 1 and 2 each have two possible
> values for each of those, while version 3 has one set of values for
> each. Add defines for all of these to minix.h so we don't need to set
> those values as magic numbers in minix_fill_super() in inode.c
> 
> Before:
> 	sbi->s_dirsize = 16;
> After:
> 	sbi->s_dirsize = MINIX_V1_DIRSIZE;
> 
> There are no functional changes with this patch.
> 
> Signed-off-by: Jeremy Bingham <jbingham@gmail.com>
> ---
>  fs/minix/inode.c | 20 ++++++++++----------
>  fs/minix/minix.h | 23 ++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/minix/inode.c b/fs/minix/inode.c
> index c30cc590698d..95fa8371e4ea 100644
> --- a/fs/minix/inode.c
> +++ b/fs/minix/inode.c
> @@ -258,25 +258,25 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
>  	s->s_magic = ms->s_magic;
>  	if (s->s_magic == MINIX_SUPER_MAGIC) {
>  		sbi->s_version = MINIX_V1;
> -		sbi->s_dirsize = 16;
> -		sbi->s_namelen = 14;
> +		sbi->s_dirsize = MINIX_V1_DIRSIZE;
> +		sbi->s_namelen = MINIX_V1_NAMELEN;
>  		s->s_max_links = MINIX_LINK_MAX;
>  	} else if (s->s_magic == MINIX_SUPER_MAGIC2) {
>  		sbi->s_version = MINIX_V1;
> -		sbi->s_dirsize = 32;
> -		sbi->s_namelen = 30;
> +		sbi->s_dirsize = MINIX_V1_DIRSIZE2;
> +		sbi->s_namelen = MINIX_V1_NAMELEN2;
>  		s->s_max_links = MINIX_LINK_MAX;
>  	} else if (s->s_magic == MINIX2_SUPER_MAGIC) {
>  		sbi->s_version = MINIX_V2;
>  		sbi->s_nzones = ms->s_zones;
> -		sbi->s_dirsize = 16;
> -		sbi->s_namelen = 14;
> +		sbi->s_dirsize = MINIX_V2_DIRSIZE;
> +		sbi->s_namelen = MINIX_V2_NAMELEN;
>  		s->s_max_links = MINIX2_LINK_MAX;
>  	} else if (s->s_magic == MINIX2_SUPER_MAGIC2) {
>  		sbi->s_version = MINIX_V2;
>  		sbi->s_nzones = ms->s_zones;
> -		sbi->s_dirsize = 32;
> -		sbi->s_namelen = 30;
> +		sbi->s_dirsize = MINIX_V2_DIRSIZE2;
> +		sbi->s_namelen = MINIX_V2_NAMELEN2;
>  		s->s_max_links = MINIX2_LINK_MAX;
>  	} else if ( *(__u16 *)(bh->b_data + 24) == MINIX3_SUPER_MAGIC) {
>  		m3s = (struct minix3_super_block *) bh->b_data;
> @@ -288,8 +288,8 @@ static int minix_fill_super(struct super_block *s, struct fs_context *fc)
>  		s->s_maxbytes = m3s->s_max_size;
>  		sbi->s_ninodes = m3s->s_ninodes;
>  		sbi->s_nzones = m3s->s_zones;
> -		sbi->s_dirsize = 64;
> -		sbi->s_namelen = 60;
> +		sbi->s_dirsize = MINIX_V3_DIRSIZE;
> +		sbi->s_namelen = MINIX_V3_NAMELEN;
>  		sbi->s_version = MINIX_V3;
>  		sbi->s_mount_state = MINIX_VALID_FS;
>  		if (!sb_set_blocksize(s, m3s->s_blocksize))
> diff --git a/fs/minix/minix.h b/fs/minix/minix.h
> index f2025c9b5825..972a71c5b481 100644
> --- a/fs/minix/minix.h
> +++ b/fs/minix/minix.h
> @@ -11,6 +11,27 @@
>  #define MINIX_V2		0x0002		/* minix V2 fs */
>  #define MINIX_V3		0x0003		/* minix V3 fs */
>  
> +/* Define version and sub-version specific values for dirsize and name length.
> + * These are not as clear-cut as having different values for versions 1, 2, and
> + * 3, unfortunately, but rather there two possible values for each for versions
> + * 1 and 2 and one possible set of values for version 3.
> + *
> + * These have separate defines for each subversion value for versions 1 and 2,
> + * though; even though they duplicate each other, it will be more clear to have
> + * them separate than trying to come up with a name that encompasses both
> + * versions yet not be totally confusing.
> + */
> +#define MINIX_V1_DIRSIZE	16
> +#define MINIX_V1_NAMELEN	14
> +#define MINIX_V1_DIRSIZE2	32
> +#define MINIX_V1_NAMELEN2	30
> +#define MINIX_V2_DIRSIZE	16
> +#define MINIX_V2_NAMELEN	14
> +#define MINIX_V2_DIRSIZE2	32
> +#define MINIX_V2_NAMELEN2	30
> +#define MINIX_V3_DIRSIZE	64
> +#define MINIX_V3_NAMELEN	60
> +
>  /*
>   * minix fs inode data in memory
>   */
> -- 
> 2.47.3

Hi Jeremy,

Thanks for taking the time to look at minix. I have a particular fondness of the
filesystem, so I am happy someone takes an interest.

However, I don't like this series. There is no reason for all this churn or the
exorbitant amount of comments. If you can get iomap to work that would be great,
but please don't do this.

Thanks,
Jori.
