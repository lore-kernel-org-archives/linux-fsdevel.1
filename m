Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665606;
	b=nFwCKmK3gkEDfmcwiZ0CaBL5KQDPzY9/Bmnn1kWSo2vgu3yh8ld79yuL1wS9wtm7Qwyi
	 ApDvgGWuuRWcuLb+lgyUIw6gjfDj3989v6sEleq8JvZWjE61WF0ebCj56KUBlrb3Zk/0S
	 ipr3NJhL34+98S/Em+fHcEnADOOk1qeGvolb6HAUWX3wDQxPoc41joVOSqdSHluxOAHNV
	 GTrP9fw1vkSCR8Ta5KmiWqSMUhAweNGbwUsVFLS0zaZRG3O52K/Kfj+VPLqZJRkxAhjdL
	 g0pVLEdca2z4g8EM0nExXL8xJeBXC6qHyAHCQFRGzQkH5HvIZHudAkKqIJITKlGEigA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665606;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=X93xAKcitoNEaoPr0KZdXA53ZByPWjtJnNfPFYluV94=;
	b=meH1QUJ2o6JWM1VfMMfyiO62NFt2Q+B4SPfVO8GJsGhC61T6/PfG9ez8YMa/qb/32/ET
	 pporfbrmG7nExm1VyCtvlpQ9etzQTJpiCUblY4byZPSyIQEzr+jRalbuQd5d9MZMBwRLN
	 oSrWCEOp5mippkcYymXyHC1KEKHH74QLTtvopaUr9jAGUDDvfTPmwJP1OsQAHcWGUoO56
	 66dwfDFbnI3HRQX2HHh8lPv8bwe8RRT5TYCQ4UqyHQQ1jJgR+F9ANvPhSPUHcEmu9fSXK
	 jYVoqs510UtCidZ0Ju/mX5BKXKdf5Uzz/DTnixUM9OQjx961b+mji/rrNUdJ5GqjFCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V+9RZ50Z;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sk2wCm2T;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qBezaMqR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PEGqU7Ui;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C0606A319
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2026 10:40:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D7C0606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=V+9RZ50Z;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sk2wCm2T;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qBezaMqR;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PEGqU7Ui
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 50876220F3;
	Thu, 22 Oct 2026 10:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X93xAKcitoNEaoPr0KZdXA53ZByPWjtJnNfPFYluV94=;
	b=V+9RZ50Z9LBWfBUgZAHHjX88pJI/4TwTfxpUL+1XnjRz48cj0+Qu6kiuVWdvHXGkw4BUW8
	Vxbn2/L3Jrsz0QAZlzXXyapjLP7/Ov+BJTMgXMOGLQhvDZDS4uXNCKwf1npp59X5nR1LoE
	SnVBomJQ7zmKUeeRnDkpkFLIuhc0pyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X93xAKcitoNEaoPr0KZdXA53ZByPWjtJnNfPFYluV94=;
	b=sk2wCm2TBOz70/FJBFADZ5j2Cnp202sybg0QLIfltUyEtw9gGP5TnLd/zlwbP0wzlY4+9S
	VElv/WofiuUL7ICw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665602; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X93xAKcitoNEaoPr0KZdXA53ZByPWjtJnNfPFYluV94=;
	b=qBezaMqREWz3kvF6mCtkGXEXLkFniw4U3DuMcoYEvYn5q2QlMgouda5CEew00UMrbDbkvX
	zuy6rwbvHTus7yFfVwsehniqQv6c8NErl1cf/9iKn24k7vEIVGkcB5D0IbJY3jMnAiFoAp
	tJECyXGZupB8QxhPhxUZljHG/A6v3Us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665602;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=X93xAKcitoNEaoPr0KZdXA53ZByPWjtJnNfPFYluV94=;
	b=PEGqU7UidutLGnNvMfnfVdDA4lkEmk2L2VQ9x24Kfi4KJ4x6wupjvfgAbhfl/x3UMUY/IM
	JN5jxbVpj2NWhlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29732134E6;
	Thu, 22 Oct 2026 10:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PODeAQLo2WqgNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:40:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B1E5EA1417; Thu, 22 Oct 2026 12:40:01 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:40:01 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 13/15] super: remove SUPER_ITER_EXCL
Message-ID: <otqff3oj6fwd4lomezegujey4zjfii5uae7qzgfaj4emxud47i@csxnopvu6sp3>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-13-c727176c5b53@kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261011-work-super-fixes-core-v1-13-c727176c5b53@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sun 11-10-26 17:56:13, Christian Brauner wrote:
> Now that do_emergency_remount() takes s_umount itself in its callback
> nothing iterates with SUPER_ITER_EXCL anymore. Remove it and take
> s_umount shared in __iterate_supers().
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

							Honza

> ---
>  fs/super.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index edd5648d1720..657958a1d135 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -935,9 +935,8 @@ void drop_super_exclusive(struct super_block *sb)
>  }
>  
>  enum super_iter_flags_t {
> -	SUPER_ITER_EXCL		= (1U << 0),
> -	SUPER_ITER_UNLOCKED	= (1U << 1),
> -	SUPER_ITER_REVERSE	= (1U << 2),
> +	SUPER_ITER_UNLOCKED	= (1U << 0),
> +	SUPER_ITER_REVERSE	= (1U << 1),
>  };
>  
>  static inline struct super_block *first_super(enum super_iter_flags_t flags)
> @@ -959,7 +958,6 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  			     enum super_iter_flags_t flags)
>  {
>  	struct super_block *sb, *p = NULL;
> -	bool excl = flags & SUPER_ITER_EXCL;
>  
>  	spin_lock(&sb_lock);
>  
> @@ -976,9 +974,9 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  
>  		if (flags & SUPER_ITER_UNLOCKED) {
>  			f(sb, arg);
> -		} else if (super_lock(sb, excl)) {
> +		} else if (super_lock_shared(sb)) {
>  			f(sb, arg);
> -			super_unlock(sb, excl);
> +			super_unlock_shared(sb);
>  		}
>  
>  		if (p)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
