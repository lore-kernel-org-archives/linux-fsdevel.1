Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AD29BD9A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Jul 2026 21:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783806176; cv=none; b=IeEA/3sacAWFZhtY9gpcG42qzOvnTjH8QeYxgprTJRkV8v4SQwbziYexrDCt5BxihfQsZv6mnZolVo5KOCk4rXbooQzlTypuvB4VaQycwtTxR5iAf96xmMZJHah3MM1DN/WyDKgQi7ZZ9tjJG+BjGYQWxSQIv+5MAxrR89yg5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783806176; c=relaxed/simple;
	bh=8LDbRgkC6bfzQz+llSU8iS7MU2C3Ofko5FSJxy2JWpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y2j7V3Dfa4uAebehF7XGEvC+ULaC7XpiI8jKof8GUZ6POZfGhurLyZH7GCLYyOqKFDhMqsRvn/8hfQyvvzSCeMIoxBmSY3Ya7cnMaCM6FugOdoddPyGtfaHDV5nh4VUHkH59fzwTpBr+OK4QwlHSbVJv2Py4Ciy2Q2cpt9TF6zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=p1avmPrl; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="p1avmPrl"
X-KPN-MessageId: 73b96498-7d71-11f1-a055-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 73b96498-7d71-11f1-a055-005056abad63;
	Sat, 11 Jul 2026 23:42:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=rtN4lv+1kngkopVJIoncS5mZyRX96lwCtHji1G/RN2c=;
	b=p1avmPrlNtS0HMXKp4j8Xv2lkdGoFosSruSEqODb3MHJsaExdYYUQwUjEEBY1v5lT0bbn9bXU3261
	 4AbeCdyzGFQzs/E592hi3mr1maKFc4uOr2abGzckwv2S1tI4QaSjRHTDJFFW/XpEUPqRk/ZqtYzZS1
	 7NngUHnysjX8WjQqnjnGEkwvkMsust4bSUvd8w19lsRKPulzGwY2xquQROLsb3KnmEvGapj+gcWuJF
	 A1mMGA2Br2FnisBRq/LRuvt+nCJ/8kJmcV96iO1PdHFGHG+y9A8bGMANGF7ELnw2FPkLMBztCoOfCA
	 BTDjFRMTQ+FVnfBlV0fQzkF4ylGfgRQ==
X-KPN-MID: 33|S77Nnj0yvyNWGG/8+Yeki2HcpREekr9q/ExwtnK0GBIaaudvvN3KxJTiGlXLevx
 7z+Pv73wYo6Yy+74NYOlUPGDUQCkgGwmRVRHCkkykH0E=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|JfWW5ThqMZgwxO+egTXdO/i1sO3iibo5cWX55NlFCVkzFaDphgzBf1kbsHLMyko
 ww4JM0SdJ5g983QhdMkTfxw==
Received: from localhost (unknown [178.226.150.234])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 72916858-7d71-11f1-a998-005056abf0db;
	Sat, 11 Jul 2026 23:42:45 +0200 (CEST)
Date: Sat, 11 Jul 2026 23:42:45 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 06/24] binfmt_misc: annotate racy accesses to ->enabled
Message-ID: <alK3zIab-_Hq9JGZ@lt-jori.localdomain>
Mail-Followup-To: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-6-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-6-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:07AM +0200, Christian Brauner wrote:
> ->enabled has always been read and written locklessly: every exec
> reads it in load_misc_binary() while bm_status_write() or a concurrent
> remount via bm_fill_super() may flip it. That is fine as it is an
> independent boolean toggle but the accesses should be marked

Right, remounting counts as reenabling.

> accordingly for KCSAN. Annotate them with READ_ONCE()/WRITE_ONCE().
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index bd7790a1317b..0b9758da1f88 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -217,7 +217,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	struct binfmt_misc *misc;
>  
>  	misc = load_binfmt_misc();
> -	if (!misc->enabled)
> +	if (!READ_ONCE(misc->enabled))
>  		return retval;
>  
>  	fmt = get_binfmt_handler(misc, bprm);
> @@ -875,7 +875,7 @@ bm_status_read(struct file *file, char __user *buf, size_t nbytes, loff_t *ppos)
>  	char *s;
>  
>  	misc = i_binfmt_misc(file_inode(file));
> -	s = misc->enabled ? "enabled\n" : "disabled\n";
> +	s = READ_ONCE(misc->enabled) ? "enabled\n" : "disabled\n";
>  	return simple_read_from_buffer(buf, nbytes, ppos, s, strlen(s));
>  }
>  
> @@ -892,11 +892,11 @@ static ssize_t bm_status_write(struct file *file, const char __user *buffer,
>  	switch (res) {
>  	case 1:
>  		/* Disable all handlers. */
> -		misc->enabled = false;
> +		WRITE_ONCE(misc->enabled, false);
>  		break;
>  	case 2:
>  		/* Enable all handlers. */
> -		misc->enabled = true;
> +		WRITE_ONCE(misc->enabled, true);
>  		break;
>  	case 3:
>  		/* Delete all handlers. */
> @@ -1007,7 +1007,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  	 * someone mounts binfmt_misc for the first time or again we simply
>  	 * reset ->enabled to true.
>  	 */
> -	misc->enabled = true;
> +	WRITE_ONCE(misc->enabled, true);
>  
>  	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
>  	if (!err)
> 
> -- 
> 2.53.0
> 


Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
