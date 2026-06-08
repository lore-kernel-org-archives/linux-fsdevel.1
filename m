Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920AA37C112
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922642; cv=none; b=Db8x8XSWLL9qqDLCgkwlyIbvflJt6WywyNYMh7MSqpZk0ZJuvzmubzVlYDgT3K+zUi1vBUBhkHVgEoff+T0awi+KCAA/6S/nRy07AIsthwJm1+j1C6K1LuJOQfaGK4HdnT83/CK7pxMIP3qcAj2iDeCRxVAKDonXWGtPbdXqQEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922642; c=relaxed/simple;
	bh=qTqtkPmXIOKjjU47BNtV/0IKQvlYLCYyY/Lvqpz9i/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ib4tFiCaHMHDiDSp6+9txYemXGJ9K70LJAkgGJQFaCR2ivk8zSZ2axD7+jc6cUjrMm+PmpLvIAhqa2q98O7Xo60VSD1dxBu2cficmErPkrssLMUUabeZT+WTLxDCl+5dap9/ugIvI2r9v/vjmSoyYj/8iDUFdLEweQsE7V30Wg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0ag0HQHe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=43kmGD9K; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xPdBchyM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Dgq6pisN; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0ag0HQHe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="43kmGD9K";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xPdBchyM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Dgq6pisN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F160067D1A;
	Mon,  8 Jun 2026 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBhgQm6fIrfRYU5SEVXtgzyrRz7ee7XL3yfC3nqpZJs=;
	b=0ag0HQHeFgH1PjQyqj2t6CyqcGZ+GpSz1+yxucj5VSJ7M347dWgpzNURHV9GMigZLgd259
	elvShme21eH+utoQQxBwMEgLAUD7g7N26/aJx8qF2IYmb9sBSI23S88Q0bLF15wGOiAS6Z
	lqyJ3Ueq90+QHXAuTU51UCVmws4hXx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBhgQm6fIrfRYU5SEVXtgzyrRz7ee7XL3yfC3nqpZJs=;
	b=43kmGD9KXhQS7EJVGaY87Mak2Ao95JxEp/LCwME0aYE+MC4ViNIehPEpoKXNvveehII5Lg
	eQDmsqkKZDumdZDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBhgQm6fIrfRYU5SEVXtgzyrRz7ee7XL3yfC3nqpZJs=;
	b=xPdBchyMI1SHJptBC8q9w8xMqT98KUQeNGcgWZ9q/8mXcxpcYxcYYsZ3aksmjR7gIVNfsT
	NxbP7ugSSDbtk8pBTxIX+B9zTt8WgPSMiPS1YQFKIwDZ53shIXDn0LhaS/RBKGuc8BFbgZ
	y9t7NuR+16sLMwvES0tWwph7N4TuijU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nBhgQm6fIrfRYU5SEVXtgzyrRz7ee7XL3yfC3nqpZJs=;
	b=Dgq6pisN5gBJJ8mM9apJkOphkOnBoLUV42Ghwq9h/u35cLGQs90IC1gMF65u0iSwbVh4Mt
	dr8YlUxTraWO38DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E8132779A7;
	Mon,  8 Jun 2026 12:43:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I1WlOA65JmrjTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:43:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 97213A0923; Mon, 08 Jun 2026 14:43:58 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:43:58 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 18/18] create_default_group(): pass parent's dentry
 instead of config_group
Message-ID: <jk2vscc7acf35ec5pw5vvlignoocsbzlohaw2dnushhwpran3i@6tzf6ealemmp>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-22-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-22-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,linux.org.uk:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 03-06-26 08:48:15, Al Viro wrote:
> the only way parent_group is used there...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 8fc05fe69992..4d82375b0cfd 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -701,14 +701,14 @@ static void detach_groups(struct dentry *dentry)
>   * We could, perhaps, tweak our parent's ->mkdir for a minute and
>   * try using vfs_mkdir.  Just a thought.
>   */
> -static int create_default_group(struct config_group *parent_group,
> +static int create_default_group(struct dentry *parent,
>  				struct config_group *group,
>  				struct configfs_fragment *frag)
>  {
>  	int ret;
>  	struct configfs_dirent *sd;
>  	/* We trust the caller holds a reference to parent */
> -	struct dentry *child, *parent = parent_group->cg_item.ci_dentry;
> +	struct dentry *child;
>  
>  	if (!group->cg_item.ci_name)
>  		group->cg_item.ci_name = group->cg_item.ci_namebuf;
> @@ -735,10 +735,11 @@ static int create_default_group(struct config_group *parent_group,
>  static int populate_groups(struct config_group *group,
>  			   struct configfs_fragment *frag)
>  {
> +	struct dentry *parent = group->cg_item.ci_dentry;
>  	struct config_group *new_group;
>  
>  	list_for_each_entry(new_group, &group->default_groups, group_entry) {
> -		int ret = create_default_group(group, new_group, frag);
> +		int ret = create_default_group(parent, new_group, frag);
>  		if (ret)
>  			return ret;
>  	}
> @@ -1767,7 +1768,7 @@ int configfs_register_group(struct config_group *parent_group,
>  	parent = parent_group->cg_item.ci_dentry;
>  
>  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
> -	ret = create_default_group(parent_group, group, frag);
> +	ret = create_default_group(parent, group, frag);
>  	if (ret)
>  		goto err_out;
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
