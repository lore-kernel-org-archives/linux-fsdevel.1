Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E974404BF0
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784548191; cv=none; b=g46k3Ux1ZcJIAeSM0r8Q7ThdVvcKgXD3mrKnzlQlp4a9KLYWlr3X5E4nk9Fhhk3kApUWNFv9vyJ9rMaUfzfXJFmvouozjca6PmsKmQyyZ6VDU0hASMK1ZhOSV4sWH4wFEEN7NNf70cgEQPqxhVj4rYnHT9SIGEOxYonN4OnQgog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784548191; c=relaxed/simple;
	bh=xiy03oNamLsbQw5D4+EFCCgfY137mB+zMVhxt4Gdijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdOhyMU6/2scIhUbhSJYGkpPpsA2+oQBGJxW7QCPMc12FhMh95nazrXJ/a2ovMQZ9rEAu/x3GfPoZXSk4NGdED0C62ABu5gH4ciBM3EC7NXNRRPS5pPaCVSfgNK/i8O9PCdUhSQZqgxQGyMmbwIszGugcdlwasgQ//fImid92gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=VM1pZZxA; arc=none smtp.client-ip=195.121.94.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="VM1pZZxA"
X-KPN-MessageId: 167054cf-8431-11f1-861c-005056aba152
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 167054cf-8431-11f1-861c-005056aba152;
	Mon, 20 Jul 2026 13:49:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=GM15Hw/y8vAWVd9RDd60/VGhkONeITiDiE95kkjf3Mc=;
	b=VM1pZZxAUPiKXpBIDPlHuAN4E6lTTpp21Luz3f2RNQm6zQTTZ66lzTxY1u1rAwW7hg96HV6j6/BeO
	 lD8QXsONhd//dMAzK1t1cjHtSxy2dTT/p2+Jy9RGwkKPY3/JQsZH1+g/PTioNkz24jJQfL6R30gID3
	 Yi2NEO5zihsWZmVOgrVyG8EigXuaJqQEwkvI03/vkgfDHPbmnHbYKetqV/cPvzfPrp+Ek7ag7PEl8o
	 01JhDpR4/W+zQDtfLdN4fL2e1brXsyZeRxvdD190PdZQ2YrcicPSkr3o8g0jb6E6XKqkOUvYFYbSfJ
	 3SCYZL0Hj82S2wYg2NQfcLkWUbaznCA==
X-KPN-MID: 33|jXjz54IGHVWI+wMXj4gUEVc+kRHHpY+7zXcevBfzK3/+kdtkZZbV5437DpqzDIs
 BZ45Ibda5XNb7uzftKhNWwhBpuzcicn12uvhLa5bQfWc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6UOv8fBLdNSUqeKJnEzT2nVqgCpPoEpvs1xRt8hK6sdCDaSIXd6IEA8w7aVPYBA
 caYO0rlbT6Z7X94HZf1/UYA==
Received: from localhost (unknown [178.231.6.170])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 16403953-8431-11f1-9212-005056ab1411;
	Mon, 20 Jul 2026 13:49:38 +0200 (CEST)
Date: Mon, 20 Jul 2026 13:51:06 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mount: remove redundant panic() in mnt_init()
Message-ID: <al4K4VVOtKuXxwDk@daedalus>
References: <20260720112331.1096530-1-hamzamahfooz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260720112331.1096530-1-hamzamahfooz@linux.microsoft.com>

On Mon, Jul 20, 2026 at 07:23:31AM -0400, Hamza Mahfooz wrote:
> Since at least as far back as commit 0818bf27c05b ("resizable
> namespace.c hashes"), we call alloc_large_system_hash() in
> mnt_init() which already panics if the table is NULL.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> ---
>  fs/namespace.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index fe919abd2f01..43de01ce023e 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6248,9 +6248,6 @@ void __init mnt_init(void)
>  				HASH_ZERO,
>  				&mp_hash_shift, &mp_hash_mask, 0, 0);
>  
> -	if (!mount_hashtable || !mountpoint_hashtable)
> -		panic("Failed to allocate mount hash table\n");
> -
>  	kernfs_init();
>  
>  	err = sysfs_init();
> -- 
> 2.55.0
> 

There isn't a reasonable way to return from this, and I see the other
uses of alloc_large_system_hash() also don't check for NULL, so this
is an OK clean-up.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
