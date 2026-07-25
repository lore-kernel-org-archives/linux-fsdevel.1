Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA08737C92A
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994808; cv=none; b=Iwfrb37kmq3KzconVWwr/Wrpg1DjshbQuXOhR/q6jkfVF2wywAZnhD49UX7leaV8OV4+bKioKsuftx9tlEPwf9P/KwDTPDdqtjc4r6tqF8GkgGQdRzOp3/KN+SQa8FmRb8HAlSoJbawrHikFBXlrn+FdOsL4QSi/8k9Vl9pCukA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994808; c=relaxed/simple;
	bh=w2NTSZljDwMGgkNL/zn7btvPjhxKBCyZmfUxlStA8Nw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqAuDYMFDGg/I2SspXQINd4qZTSZSi/qNEW8XmuIxeWtdvPf8pW6ry0UFk5QI+ghZsFUYewD4vttX0fZ/KIQoSSvwmTn9P45ID13rXmBK2QcV/jconTYSwqF64FXNvtybHFm3hig15sPyayeoGkEygPg4y8MHMmCno+vTc9F1YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=lAw81lEF; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lAw81lEF"
X-KPN-MessageId: f6722ea7-8840-11f1-b2a8-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f6722ea7-8840-11f1-b2a8-005056abbe64;
	Sat, 25 Jul 2026 17:53:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=QyDxN4rb6c/XRh6ApxXaUggDqwL7NriZKZmwb5ZGNr0=;
	b=lAw81lEFK7S9f/rACqMC/NqmXpYceCpp5cH4vJ17FvnFfPJM908eEIZcgO33m1NYJhLir3B8hfMsB
	 0dkpvjnE0hnL9kyqyJyNFPMyCJJdOXTgIH+3zsUFA4jXjzs8K0WBOWiw9CSqmJ2HkU0Ct4SV+hSldA
	 BxXnVgw/2AiYdKSW+IilNNRFCfuWHxNB5L1BvtwlniHDxXJ1x3GWWxhXVjIIX9o1tZxFwFM65UsZPh
	 MBrAewgAs75Tws1Do3y8QvZgjbSFF0kJmccTmy0BYkvRYLnZxgq5FEpCWTUwxCTbm3p5aMsbq2gsxb
	 qokfxdwaD0FyXEq7mN1UfwP1q4uU92Q==
X-KPN-MID: 33|CbsXFLwPkiZSid3jhTG4eAoG0+HdmFlqVyytflOBzhjRucXogh53OgyTaWYhr2X
 c/37UxYIHX+rJYsSkSZfJ9cq1z1O6hnTsvUIarb8UqeY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|M10uTIOs814OUqOUH87DCyajQ3CPn/5g9oXhZWYWkEj+J4yUp3ywRikiaVEN3cF
 Wpx7wnvTeXEjwz9lyCBzNcw==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id f63a02e1-8840-11f1-86b1-005056ab7584;
	Sat, 25 Jul 2026 17:53:21 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:53:19 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 15/24] binfmt_misc: return errors directly in
 load_misc_binary()
Message-ID: <amTb6I6mG8HcaG3y@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-15-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-15-a162f7cb58d6@kernel.org>

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
