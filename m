Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD661DF27F
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 15:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783957614; cv=none; b=YrDuq49sDcxP/gXjVKODahgs6af8kic6xHyEQ/v5X7b9TYGCU74rTPzOin8hFcQ/yTghDcVQ1TjrRSM2pPlIknEiK+Cqd2/AxEV45jlYI1q4Tv6ICS+fe7tcOqbTsQI12RtZsF52+Q0mkm8BBg/DEebTfdtjda/gMV7xppdwxEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783957614; c=relaxed/simple;
	bh=VNKpUXYK4fSm3zxW5RuFiIEURf5YtZ6Jk2yHVykoor8=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=aMnrdXlfE8o/P489vmagCDGM0dvxGowKYnowSDsnXsV65mj31/enLBs7wPOhf82KLHdp7/l/DzNk7LXFIBnCilhsiggxfckhQzv0K6t2l6Z0ql23v0hqAS3nak4GACdGBsZDHnmh1qDuWHRBN3qlYNnEQmVIWxEUME0cDe8hVpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=rpUm8oJ5; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="rpUm8oJ5"
X-KPN-MessageId: 0fa2a740-7ed2-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 0fa2a740-7ed2-11f1-bfba-00505699b430;
	Mon, 13 Jul 2026 17:46:49 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 0fa15743-7ed2-11f1-ae77-0050569981f5;
	Mon, 13 Jul 2026 17:46:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=hUxVYFht1tdb/sUwhOuEe8yDpFk9imzzMyufOuZTBPY=;
	b=rpUm8oJ5V8u8CNYpnH7rK4LSR5HlcRAdD1GbbhbmKhmAAhHvjSKvEIe/y9bk+4FJfX0C8LB1hVG/+
	 EgrRQ2ZESYUDkxzMOtMOxGcn9zL0wz1AjaYTQu08blaWURC4y9xA3CzJ6sirdVNxnQrPy3qjHzZZgG
	 ocFDF+2vwhhfP7aYoT1jTeaJnJCiLm0RNyr9fClI4mD86haImeCxJNWbmE5VKGqM8zYs3/kHL74oOp
	 UMNGSuPuhA6vWvVEnQvaWB5RZe/IOYVhfta8FZhhNj2d52j1gFGhEB9r+b9bs/JNtwcAFx7/u6m3eS
	 +gRNVodqP0JvJbttWp8p7B8wHjK+bmg==
X-KPN-MID: 33|tJf6GHfavJYe+yixV6KMl5QCp9MYFWnzf0krHLI4pjDUtje1qABrSYX/sirqiT+
 HSOnyOP8YGhgW5f5eGilcJ1Wao19HjGERTYkpUY7i19M=
X-CMASSUN: 33|IwFtFjTrgl8Oafs6kUPgFfVj910ZH2GzJhZGBERE53rdOPMeERYCAki6Q7IH8h1
 +fFAsDBoebTINIzDmr8QKBA==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 0f9510e4-7ed2-11f1-916a-005056995d6c;
	Mon, 13 Jul 2026 17:46:49 +0200 (CEST)
Date: Mon, 13 Jul 2026 17:46:49 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com
Message-ID: <1048749513.880112.1783957609482@kpc.webmail.kpnmail.nl>
Subject: Re: [PATCH v3 14/24] binfmt_misc: rename load_binfmt_misc() to
 current_binfmt_misc()
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

Maybe put a WARN() there then?

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
