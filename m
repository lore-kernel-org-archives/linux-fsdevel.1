Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FC9385D69;
	Wed, 26 Aug 2026 16:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761510; cv=none; b=imeKrko0UjhSEdL1ZexNnjtYE44MXv5DM0LwQTYSIoAG0Zmhe1aAQjc+CgmvRF7KxftI5KRYhcywiK4fWvNw+QjMUIDSz/J2Nzb1cVYtDXGoZ+v7vvb49nUVC7V9lVQpzq0VJ+L1Rfg8X6quAFiWtL43Wrx8t94NAMK2fMn+2pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761510; c=relaxed/simple;
	bh=I2CK9xodJrQrd9MWlq/eftx9czD/WnLeFPbDS+TrAn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuiFtBUSXLUHodrpv/74wFqt9VihFThqp6f+Fdx4tBAmqOMrnSJ90c0f2dOkpVT6Vz/LQuURPZzL5ySoJpQ5SX4IqICGoNkm6JOL1q8BkdkS6lAO8RCSH83MPX8wcw3kvv8/8tJ6dk8e8pPI3XbhDx7YB+vL6anlz1fL2Lr5Kd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BnkCPKlw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Sgam4sP8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WZQeocIt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eoqOAm2Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BnkCPKlw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Sgam4sP8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WZQeocIt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eoqOAm2Z"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCADE21908;
	Wed, 26 Aug 2026 16:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787761503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ks2dvh3ebHZZbVNixbBgT37X7m24IKlHaDpA8IdCRYU=;
	b=BnkCPKlwDQJhWa6BgiAQzqqrUmaZ1gaLDaHQbEOIMevK5yNjiE+Y+3gJEv7Ljisg0K5CXD
	97W6PS3IIODlVbw50RArlPM62iLyU7ZmcABvFE9Q9UJvt5EmJvbBzOt5ubZ/lH/SmSMiwp
	MWiUssek88ZMkM3U6P1DaVKUD37XYk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787761503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ks2dvh3ebHZZbVNixbBgT37X7m24IKlHaDpA8IdCRYU=;
	b=Sgam4sP8NvwIotX0bNq1r9SmJnqE4HqFK68ZO7/srphWSFG+LJXnDp4SFtazz5zGNHYGHr
	LSX+8HfifTjUDCAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787761498; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ks2dvh3ebHZZbVNixbBgT37X7m24IKlHaDpA8IdCRYU=;
	b=WZQeocItxr+NpVQBRn4q4OktNODHMgkX9wPs3Nq813WoX2OHg8hZkTg9mXBypK4t0EM6d5
	EZcQOGgGxOeV2Lh+nYYYSAa5oxFQD+640GrKfNg4SwJ8MTy3lhovK4NMGgpzhWzph6wlYv
	x83ES6mP+IalwWNiVMqQSB5ECrKy6/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787761498;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ks2dvh3ebHZZbVNixbBgT37X7m24IKlHaDpA8IdCRYU=;
	b=eoqOAm2ZdyK1Hsft5ZFPQt/+ArSngyf0Ray6GtSxWIK+GAbkhbIw2eMP1uzEwPvX6LZBzj
	D8Cf9Dp3AH9BZjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B704813354;
	Wed, 26 Aug 2026 16:24:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TEI+LFoTj2oCGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Aug 2026 16:24:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 496D2A13A7; Wed, 26 Aug 2026 18:24:58 +0200 (CEST)
Date: Wed, 26 Aug 2026 18:24:58 +0200
From: Jan Kara <jack@suse.cz>
To: phucduc.bui@gmail.com
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] chardev: check return value of kobject_set_name() in
 __register_chrdev()
Message-ID: <r2rpiqlkgw33igh262cieoyoeqdv7vd3vh3swjasdf4vdjgyss@e2rrpfe24oub>
References: <20260826052055.19201-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826052055.19201-1-phucduc.bui@gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Wed 26-08-26 12:20:55, phucduc.bui@gmail.com wrote:
> From: bui duc phuc <phucduc.bui@gmail.com>
> 
> The kobject_set_name() function can fail and return -ENOMEM if memory
> allocation fails.
> 
> While all other functions called inside __register_chrdev() are properly
> checked for errors, kobject_set_name() was missing this check. Add the
> error check for kobject_set_name() and jump to the 'out' label on failure
> to maintain consistency and ensure proper error handling.
> 
> Found by manual code inspection.
> 
> Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/char_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/char_dev.c b/fs/char_dev.c
> index 00229e25c10f..5ce5423f6c99 100644
> --- a/fs/char_dev.c
> +++ b/fs/char_dev.c
> @@ -280,7 +280,9 @@ int __register_chrdev(unsigned int major, unsigned int baseminor,
>  
>  	cdev->owner = fops->owner;
>  	cdev->ops = fops;
> -	kobject_set_name(&cdev->kobj, "%s", name);
> +	err = kobject_set_name(&cdev->kobj, "%s", name);
> +	if (err)
> +		goto out;
>  
>  	err = cdev_add(cdev, MKDEV(cd->major, baseminor), count);
>  	if (err)
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
