Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31D272801
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958694; cv=none; b=b67qL6Ajqc5pSne742opEpLXX0qHaX1teJVFDBm0xA6zR/t0lH2KPQDiVZRPo3wTaCRbbrNajeqdChj/4ZdM1acXTefnbBoqYJdnCTFmtGgofAFA25njPzIPkdNP+CXpOfvBRjMu7q27Ki+3rLAV6Xfd/JByKauv562XLO4aRng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958694; c=relaxed/simple;
	bh=w2NTSZljDwMGgkNL/zn7btvPjhxKBCyZmfUxlStA8Nw=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=E/6nLCBAk6pVyoeCO8rVep8fGRZgIid1X0f/ggOMi2/WkQcORg2kk4sUrKSJp6KHfBNwOWH/HDJpyRM9xKiKB/T/LA8Kcp96OsuJ1OLNB1CPvQjYkvG0XmHvCI1T6bOuRCv8dYjjOIcz2sR0HwG+1H6nOL/YlBe6FmLc1ursXCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=bQjhkVF/; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="bQjhkVF/"
X-KPN-MessageId: 92cbc407-7ed4-11f1-a59f-005056994fde
Received: from mta.kpnmail.nl (unknown [10.31.161.190])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 92cbc407-7ed4-11f1-a59f-005056994fde;
	Mon, 13 Jul 2026 18:04:48 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 92caa8f3-7ed4-11f1-b307-0050569977a2;
	Mon, 13 Jul 2026 18:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=QyDxN4rb6c/XRh6ApxXaUggDqwL7NriZKZmwb5ZGNr0=;
	b=bQjhkVF/3foAkYKWZM9gG8De2qfD3OH25hbSlUm40YHqaPfmqOKG9Sr2cc7p0aEuOfIIZWMO1KVm/
	 2YJzPvAr/BTgCigqpk+Sy4ohQHjfxYWD49/gDtyjaSFpsGRNXbMh/kHEHMJVH0afaf12/Z015CbhIo
	 gVSdItqHCa65jjLXrorV4c0HPhCCu+lVxPZDCuzJCJBStSyou/oTnNeWh3bGQM3GzTF+b1KLJcZJjp
	 X3q/m1Rq7gpBncM8Rws0/QVuz5UZ9gbOAAOeAPWHNoO4nWEFJ0BHv3Yu/rp+oTLvzx9sfikrYp0nhc
	 AAV+aXr0d4htqk+NZIZn0XUz0mYTjFg==
X-KPN-MID: 33|8ogNYeWAZgjT7SkZzZjdanq6v0VxlLJsJ2kKnB6g2YCeUWVyy60fwDkfpz3wqF6
 lzkztzcHDWCA/N9P7Is8PXcpbMz1zDIJBDEm5qVjtHYQ=
X-CMASSUN: 33|xsZ0uT1g44ma6fztJwKEavrFwzP+rYu77nZbbx2ZlzW4HLqA90ooVL5+wb2a/Za
 hD7KS4+YidSpPsm/jcky0+w==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 92c5c247-7ed4-11f1-916a-005056995d6c;
	Mon, 13 Jul 2026 18:04:48 +0200 (CEST)
Date: Mon, 13 Jul 2026 18:04:48 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <1732140714.875816.1783958688577@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 15/24] binfmt_misc: return errors directly in
 load_misc_binary()
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

On Fri, Jul 10, 2026 at 11:33:16AM +0200, Christian Brauner wrote:
> load_misc_binary() seeds retval with the error for checks that
> happen further down, reassigns it along the way and funnels every
> exit through a ret label whose only job is dropping the entry
> reference, so figuring out what an early return actually returns
> means replaying the assignment history. Give put_binfmt_handler() a
> cleanup class and take the reference with __free() so every failure
> can return its error right where the condition is checked. The
> comment at the label restated what the put_binfmt_handler()
> kernel-doc already explains, it goes with the label. Drop the dead
> NULL initialization of interp_file which is assigned on all paths
> before use.
> 
> No functional change.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 41 ++++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index cd5dbf61771e..06f4849cf1ad 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -183,6 +183,8 @@ static void put_binfmt_handler(struct binfmt_misc_entry *e)
>  	}
>  }
>  
> +DEFINE_FREE(put_binfmt_handler, struct binfmt_misc_entry *, if (_T) put_binfmt_handler(_T))
> +
>  /**
>   * current_binfmt_misc - get the binfmt_misc instance of the caller's user namespace
>   *
> @@ -215,30 +217,29 @@ static struct binfmt_misc *current_binfmt_misc(void)
>   */
>  static int load_misc_binary(struct linux_binprm *bprm)
>  {
> -	struct binfmt_misc_entry *fmt;
> -	struct file *interp_file = NULL;
> -	int retval = -ENOEXEC;
> +	struct binfmt_misc_entry *fmt __free(put_binfmt_handler) = NULL;
> +	struct file *interp_file;
>  	struct binfmt_misc *misc;
> +	int retval;
>  
>  	misc = current_binfmt_misc();
>  	if (!READ_ONCE(misc->enabled))
> -		return retval;
> +		return -ENOEXEC;
>  
>  	fmt = get_binfmt_handler(misc, bprm);
>  	if (!fmt)
> -		return retval;
> +		return -ENOEXEC;
>  
>  	/* Need to be able to load the file after exec */
> -	retval = -ENOENT;
>  	if (bprm->interp_flags & BINPRM_FLAGS_PATH_INACCESSIBLE)
> -		goto ret;
> +		return -ENOENT;
>  
>  	if (fmt->flags & MISC_FMT_PRESERVE_ARGV0) {
>  		bprm->interp_flags |= BINPRM_FLAGS_PRESERVE_ARGV0;
>  	} else {
>  		retval = remove_arg_zero(bprm);
>  		if (retval)
> -			goto ret;
> +			return retval;
>  	}
>  
>  	if (fmt->flags & MISC_FMT_OPEN_BINARY)
> @@ -247,19 +248,19 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	/* make argv[1] be the path to the binary */
>  	retval = copy_string_kernel(bprm->interp, bprm);
>  	if (retval < 0)
> -		goto ret;
> +		return retval;
>  	bprm->argc++;
>  
>  	/* add the interp as argv[0] */
>  	retval = copy_string_kernel(fmt->interpreter, bprm);
>  	if (retval < 0)
> -		goto ret;
> +		return retval;
>  	bprm->argc++;
>  
>  	/* Update interp in case binfmt_script needs it. */
>  	retval = bprm_change_interp(fmt->interpreter, bprm);
>  	if (retval < 0)
> -		goto ret;
> +		return retval;
>  
>  	if (fmt->flags & MISC_FMT_OPEN_FILE) {
>  		interp_file = file_clone_open(fmt->interp_file);
> @@ -274,27 +275,13 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	} else {
>  		interp_file = open_exec(fmt->interpreter);
>  	}
> -	retval = PTR_ERR(interp_file);
>  	if (IS_ERR(interp_file))
> -		goto ret;
> +		return PTR_ERR(interp_file);
>  
>  	bprm->interpreter = interp_file;
>  	if (fmt->flags & MISC_FMT_CREDENTIALS)
>  		bprm->execfd_creds = 1;
> -
> -	retval = 0;
> -ret:
> -
> -	/*
> -	 * If we actually put the entry here all concurrent calls to
> -	 * load_misc_binary() will have finished. We also know
> -	 * that for the refcount to be zero someone must have concurently
> -	 * removed the binary type handler from the list and it's our job to
> -	 * free it.
> -	 */
> -	put_binfmt_handler(fmt);
> -
> -	return retval;
> +	return 0;
>  }
>  
>  /* Command parsers */
> 
> -- 
> 2.53.0
> 

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
