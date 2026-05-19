Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09E33A3E91
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185908; cv=none; b=HCzIFCyVq7x6muKOkHV6KIquCiAYz52vdP4PwD9gkjNpetDxfu24bcYIkZzEjf5b6btLLJ00QM+XGK8opfKlYz5t5v7i03fYUxM5gC8BJmQyU7bMgyeo9slbmrXr6n++VM163HIedOOvdFURdUakeOpNIuggpxFrcq0aVzRvRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185908; c=relaxed/simple;
	bh=+QHXoDzH2/ZGbPzjwqflAe0wMTYGcqw7kEDJU/Z3P58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVU/OdzOkIsIhfxCLR6Tylja4Z07oFICwhRoni4XHEwDbpn6xP+X5myaHnBiQ9VgW4FPF6BMaOhuQ38n93e5xrpLfbQTr8GyFQizwQNaR3zropAkgfYjnMvdYb/NS/0hpBDJTwA5BpoSG+MfFfh402MFFn/Tj2J8PG3E0xNXS6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1QpRv0Gk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKVzKyiU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1QpRv0Gk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LKVzKyiU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QpRv0Gk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKVzKyiU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1QpRv0Gk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LKVzKyiU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C602166FF7;
	Tue, 19 May 2026 10:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779185904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbuaYAKSfL103mcZb+0pJvK7zpAIZol2IE11Hwy3Yb8=;
	b=1QpRv0Gk6L7ii1wJfmHvLRbWara7sL77kuk+ZiPQsC68S35dvTz8LqidnN8c5yGsPGOPFy
	RFjp75vdvzZOupDKsLZI8i3rLCI2HBGVG3ZbYCrM8nd/6b8TuzdwdoISP7YGsMLbl8l31K
	w9xK0xCcGFyM8OQzacnrR1Ng9p5GhN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779185904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbuaYAKSfL103mcZb+0pJvK7zpAIZol2IE11Hwy3Yb8=;
	b=LKVzKyiU9iK0cFlNgL4l5gD/+g0J8vQNXM/EvBg8RxiuPktKmJ65gW9rPha/+s8ZyGgAsY
	etedEurY7eqO+DAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779185904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbuaYAKSfL103mcZb+0pJvK7zpAIZol2IE11Hwy3Yb8=;
	b=1QpRv0Gk6L7ii1wJfmHvLRbWara7sL77kuk+ZiPQsC68S35dvTz8LqidnN8c5yGsPGOPFy
	RFjp75vdvzZOupDKsLZI8i3rLCI2HBGVG3ZbYCrM8nd/6b8TuzdwdoISP7YGsMLbl8l31K
	w9xK0xCcGFyM8OQzacnrR1Ng9p5GhN8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779185904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hbuaYAKSfL103mcZb+0pJvK7zpAIZol2IE11Hwy3Yb8=;
	b=LKVzKyiU9iK0cFlNgL4l5gD/+g0J8vQNXM/EvBg8RxiuPktKmJ65gW9rPha/+s8ZyGgAsY
	etedEurY7eqO+DAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BE8CA593A8;
	Tue, 19 May 2026 10:18:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zo+CLvA4DGrLeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:18:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E3C0FA0ADE; Tue, 19 May 2026 12:18:19 +0200 (CEST)
Date: Tue, 19 May 2026 12:18:19 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 04/14] configfs_depend_prep(): pass configfs_dirent
 instead of dentry
Message-ID: <xjioawfdrk5dsxhg34dx3evoqizmeb3rblhdt5zjgozm77wtun@y3btawn3lr6q>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-5-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -3.80
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.org.uk:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:23, Al Viro wrote:
> Again, the only thing it uses dentry for is dentry->d_fsdata; for the
> recursive call the situation is the same as with configfs_detach_prep()
> and the same observation about ->s_dentry->d_fsdata applies.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 0c071252c9d4..5219c4fd527e 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1067,15 +1067,12 @@ static int configfs_dump(struct configfs_dirent *sd, int level)
>   * much on the stack, though, so folks that need this function - be careful
>   * about your stack!  Patches will be accepted to make it iterative.
>   */
> -static int configfs_depend_prep(struct dentry *origin,
> +static int configfs_depend_prep(struct configfs_dirent *sd,
>  				struct config_item *target)
>  {
> -	struct configfs_dirent *child_sd, *sd;
> +	struct configfs_dirent *child_sd;
>  	int ret = 0;
>  
> -	BUG_ON(!origin || !origin->d_fsdata);
> -	sd = origin->d_fsdata;
> -
>  	if (sd->s_element == target)  /* Boo-yah */
>  		goto out;
>  
> @@ -1083,8 +1080,7 @@ static int configfs_depend_prep(struct dentry *origin,
>  		if ((child_sd->s_type & CONFIGFS_DIR) &&
>  		    !(child_sd->s_type & CONFIGFS_USET_DROPPING) &&
>  		    !(child_sd->s_type & CONFIGFS_USET_CREATING)) {
> -			ret = configfs_depend_prep(child_sd->s_dentry,
> -						   target);
> +			ret = configfs_depend_prep(child_sd, target);
>  			if (!ret)
>  				goto out;  /* Child path boo-yah */
>  		}
> @@ -1105,7 +1101,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
>  
>  	spin_lock(&configfs_dirent_lock);
>  	/* Scan the tree, return 0 if found */
> -	ret = configfs_depend_prep(subsys_dentry, target);
> +	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
>  	if (ret)
>  		goto out_unlock_dirent_lock;
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
