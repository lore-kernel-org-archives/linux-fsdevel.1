Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A6375F83
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921786; cv=none; b=HlkHfd5hQxu4lme95T7Yj8L694rm2GL6DulaDfuz0VDg0hT8sjlEuLxhRvD5z0ZR6lelt1eR7f/rNYkjRkNXEn4Qpi/NQXcReqRTot9IOJ1cQ+vKa3d+/1o7zmuyHcWg6kyRLPFtn5lDKFBEtbCT6KfNlKWX4A1qh76FaBjW2DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921786; c=relaxed/simple;
	bh=LFvAzxjRy5yKMROCT6VzLuXZ4zUNbJdggzJRZ3Ldrtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UL+jAS3VdZgMczC9/0nlr2duOT/rSX+WCCvXqh1SPd5UtuNud0UKrxz5b/LAQrKGXIfWEjTRcvkcQB7PRi9v9buLl/ld6sZIoKb4p5hc8io/yLPAZUS88SFjRS/dH5FZtzjOXHmTsmFFankneW6bbmpgi5bwoJoW9fRbq89kzLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YaWPnGiV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EBbms4Ir; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=miveAcmo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k4L7tQpv; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YaWPnGiV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EBbms4Ir";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="miveAcmo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k4L7tQpv"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E39434D1F8;
	Thu, 19 Mar 2026 12:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773921783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BEr/zL+iTq9OLG7t22kpTRs5fuNK1bo78GluvZaHc=;
	b=YaWPnGiVgfFZI8vGKZfr4GRIiiet/kRBdc18qnUznr/XtyqxcNUlZhVYDQcF3ZNxPwpFLb
	vbGgQ/oGNF421jBS+TV1KfnLxomo4ucmAUJENagE3b+gj4MYcq3keJUV2PM8E9oJPoQTap
	0LhwEs7nlTe2zuQ/X8L9AvLQI355Huc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773921783;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BEr/zL+iTq9OLG7t22kpTRs5fuNK1bo78GluvZaHc=;
	b=EBbms4Irhn5N1IMemBImA7hFnElveA3HlxgVfj3FXWScb87IExptV1ircOm9NceA/mttQj
	xYWHadbH5V7AO3CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773921779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BEr/zL+iTq9OLG7t22kpTRs5fuNK1bo78GluvZaHc=;
	b=miveAcmoNVz13pXCT9ajLBfK6W4Gw71nsI7Y2qkCRMeI4LbUANPYv8ad0+a7SRonvmVA3W
	1IwuFYwuyhxjC49lP218Fd2eNOdyUSMADFc4dNOcrw5z8oZyNyJSw2wYin1yG9YvU6YgjM
	lyZSqUu6uhoKNjfDIC6GhBA3zN+FTlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773921779;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=V/BEr/zL+iTq9OLG7t22kpTRs5fuNK1bo78GluvZaHc=;
	b=k4L7tQpvtzlAF0UrjD6CQtVSvkn3m3pphArldaqwaCzqrBo5CSChmmepd/777qwy1iVnBi
	hZUHCO1+VtYoIeBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5DA34273B;
	Thu, 19 Mar 2026 12:02:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /6g8M/Plu2kKWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 12:02:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 92978A0B32; Thu, 19 Mar 2026 13:02:59 +0100 (CET)
Date: Thu, 19 Mar 2026 13:02:59 +0100
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	"open list:FILESYSTEMS (VFS and infrastructure)" <linux-fsdevel@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] vfs: fix docstring of hash_name()
Message-ID: <b6tzgb7nlxmefkc7mqeyhlpo4o3c6532wdxxpdej5mtoftfch5@6hgola232nx6>
References: <20260318203953.5770-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318203953.5770-1-jkoolstra@xs4all.nl>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	FREEMAIL_TO(0.00)[xs4all.nl];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,xs4all.nl:email,suse.cz:email]
X-Spam-Flag: NO

On Wed 18-03-26 21:39:52, Jori Koolstra wrote:
> The docstring of hash_name() is falsely reporting that it returns the
> component length, whereas it returns a pointer to the terminating '/'
> or NUL character in the pathname being resolved.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/namei.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 58f715f7657e..9e5500dad14f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2437,8 +2437,14 @@ u64 hashlen_string(const void *salt, const char *name)
>  EXPORT_SYMBOL(hashlen_string);
>  
>  /*
> - * Calculate the length and hash of the path component, and
> - * return the length as the result.
> + * hash_name - Calculate the length and hash of the path component
> + * @nd: the path resolution state
> + * @name: the pathname to read the component from
> + * @lastword: if the component fits in a single word, LAST_WORD_IS_DOT,
> + * LAST_WORD_IS_DOTDOT, or some other value depending on whether the
> + * component is '.', '..', or something else. Otherwise, @lastword is 0.
> + *
> + * Returns: a pointer to the terminating '/' or NUL character in @name.
>   */
>  static inline const char *hash_name(struct nameidata *nd,
>  				    const char *name,
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
