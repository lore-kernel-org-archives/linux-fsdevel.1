Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59D372EF5
	for <linux-fsdevel@vger.kernel.org>; Sat, 25 Jul 2026 15:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994771; cv=none; b=mMRRKedc1HIj+WULriLNBDVfb1AserWVHNsmE733nqFzpFIsTLfqqi7cM5kHrSIFXJKSFylNDdATEo3OQMp4vh0bzJqDZNXBHECNwHdw/jgTFn/jVp7p6p7oDsPNAbOViXrXx3pViv5pjic3UhfXYBpMLFkL6OjyBnsEPGLgZaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994771; c=relaxed/simple;
	bh=dZ25LLQSRm38LIV6ostZzJkK27/YsK59kFDY5mPxgR4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dPZW//RI/vUYrD2IH0y+AQkl4ApJxhSvRAgKqEZz6d78MHlFe7a4lOTlbXeeOpsEzxkSBYvDbQKPnmH2ZzI+46Jh9d++k1UotKx0RYgIhGWOX4yfadWdQWdITDR0Sxz5J51mQtWiVHeZ7ReU4xNvJmTf+iCb0NOR9MwI3C93lmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HQI6ELAo; arc=none smtp.client-ip=195.121.94.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="HQI6ELAo"
X-KPN-MessageId: df272e7f-8840-11f1-83b3-005056ab378f
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id df272e7f-8840-11f1-83b3-005056ab378f;
	Sat, 25 Jul 2026 17:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=+Oe0jnIXRtpZPsHT6Iavl/LHj6/KkV9pYh02KESLWzc=;
	b=HQI6ELAo91lZBncETmbv37Uo0ySFUFWrXrWq0sYyyXGyx0prLCNPx/RIWCXLN1L5S5ltgD2fmSVwG
	 n9NoGvy8SWb8GIhi466ZNgGnt0NaNP+A/S/MCjkA7rbKeS2KRQudDrPsfd51gxG72hoIyboqRr7cSv
	 12MKXGcyvi0ouLfjypEnCR3m2ftahzUCJrCZm08rnu7Uzw+DP24ugQlF1sSmwYPdNtO8rsH7f6RSxv
	 OwaZTS7eYa/Yc+CsAyUAWSlwn3T5Cl7C++lGT1KZNGwrSMPpdpG/WyBYF5F2Wrb9sPdALqOUNlTzYo
	 86v3FI94WkyxCsqYqgxcY5eXh0rwJeg==
X-KPN-MID: 33|TD21L4c0WDJVGaA49Ef8ARvm1SU68dN1K0LC4/VDeL08o6YCqtkCI1wF6DExL01
 Acl5Bpjh+HYMdOao0+997KXxp9rNqEkFIGpgULhMmFqg=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|gw/haAHwblGQZopLI6Q7IitHaF5BrKRCbX16+2hc+eQLblxd/5j/CHo3el08DmX
 EB7qMIxT3Zm2SHLV8zumHrQ==
Received: from localhost (142-169-144-85.ftth.glasoperator.nl [85.144.169.142])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id def9a23c-8840-11f1-86b1-005056ab7584;
	Sat, 25 Jul 2026 17:52:42 +0200 (CEST)
Date: Sat, 25 Jul 2026 17:52:41 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-mm@kvack.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Subject: Re: [PATCH v3 14/24] binfmt_misc: rename load_binfmt_misc() to
 current_binfmt_misc()
Message-ID: <amTbo4nGAcE4F6Ey@lt-jori.localdomain>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-14-a162f7cb58d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-work-binfmt_misc-locking-v3-14-a162f7cb58d6@kernel.org>

On Fri, Jul 10, 2026 at 11:33:15AM +0200, Christian Brauner wrote:
> load_binfmt_misc() is one word swap away from load_misc_binary(),
> the binfmt loader it serves. It doesn't load anything, it looks up
> the binfmt_misc instance of the caller's user namespace, so name it
> after what it returns in the style of current_user_ns() and friends.
> Tighten the parent walk into a for loop and fix the stale wording
> and typos in the kernel-doc while at it.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_misc.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 6a56f40f23ae..cd5dbf61771e 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -184,29 +184,27 @@ static void put_binfmt_handler(struct binfmt_misc_entry *e)
>  }
>  
>  /**
> - * load_binfmt_misc - load the binfmt_misc of the caller's user namespace
> + * current_binfmt_misc - get the binfmt_misc instance of the caller's user namespace
>   *
> - * To be called in load_misc_binary() to load the relevant struct binfmt_misc.
> - * If a user namespace doesn't have its own binfmt_misc mount it can make use
> - * of its ancestor's binfmt_misc handlers. This mimicks the behavior of
> - * pre-namespaced binfmt_misc where all registered binfmt_misc handlers where
> - * available to all user and user namespaces on the system.
> + * If a user namespace doesn't have its own binfmt_misc mount it uses the
> + * handlers of its closest ancestor with one. This mimics the behavior of
> + * pre-namespaced binfmt_misc where all registered handlers were available
> + * to all users and user namespaces on the system. The init user namespace
> + * instance is statically set up so the fallback is never reached in
> + * practice.
>   *
>   * Return: the binfmt_misc instance of the caller's user namespace
>   */
> -static struct binfmt_misc *load_binfmt_misc(void)
> +static struct binfmt_misc *current_binfmt_misc(void)
>  {
>  	const struct user_namespace *user_ns;
>  	struct binfmt_misc *misc;
>  
> -	user_ns = current_user_ns();
> -	while (user_ns) {
> +	for (user_ns = current_user_ns(); user_ns; user_ns = user_ns->parent) {
>  		/* Pairs with smp_store_release() in bm_fill_super(). */
>  		misc = smp_load_acquire(&user_ns->binfmt_misc);
>  		if (misc)
>  			return misc;
> -
> -		user_ns = user_ns->parent;
>  	}
>  

Maybe a WARN() here?

>  	return &init_binfmt_misc;
> @@ -222,7 +220,7 @@ static int load_misc_binary(struct linux_binprm *bprm)
>  	int retval = -ENOEXEC;
>  	struct binfmt_misc *misc;
>  
> -	misc = load_binfmt_misc();
> +	misc = current_binfmt_misc();
>  	if (!READ_ONCE(misc->enabled))
>  		return retval;
>  
> @@ -983,7 +981,7 @@ static int bm_fill_super(struct super_block *sb, struct fs_context *fc)
>  		INIT_HLIST_HEAD(&misc->entries);
>  		spin_lock_init(&misc->entries_lock);
>  
> -		/* Pairs with smp_load_acquire() in load_binfmt_misc(). */
> +		/* Pairs with smp_load_acquire() in current_binfmt_misc(). */
>  		smp_store_release(&user_ns->binfmt_misc, misc);
>  	}
>  
> 
> -- 
> 2.53.0
> 

At any rate:

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
