Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685599460;
	Tue, 18 Aug 2026 21:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087732; cv=none; b=o/W8xEhYpB9tRel8i3R5NrRPs49O2W2qC1E6I1B90AfmWnPoxgdoiVPPF+YAQHZkTMgG5zRo+QFQ09zsVP0FHYD9jwgATCosGsVICIFiDNkek2q1B5awy3HLJsKsyhK0rx3+72rFMyFaAYpeZy14p0hLVkM7kSHhizuVou+1tt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087732; c=relaxed/simple;
	bh=nY7owJk0dymeTR3QJP4pXtqcJu/9V+XJ5b4QLNI+uGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W8TuqmXKWeBigptVfm72GawJ62zJebZxzo7Zr8dEtW+Rn7YvvKmFZ41e4bDLxdem4BqqigXeeOHsnydspJHw6v4wNlobkE/LffOlgHQHZ4kbiXxu6cMQRCyTLsXwCOzVpRI42m/rO//IBdvqcno6zz2csu5pUADmZNS7cgU3wi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kc7y9yG/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=H8OBJGkG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OZxPZnFf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3Zxh5qRH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kc7y9yG/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H8OBJGkG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OZxPZnFf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3Zxh5qRH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C54683E0D;
	Tue, 18 Aug 2026 21:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787087658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUz89g6bZOzCHMpF6sYf+x1yIa9qX7Sl8l0OZsybqXk=;
	b=kc7y9yG/MSEOBwB9pKX5jdNfNKlJomqiL9PUPjEBUEV7mm4WU0hELH3fGYcgvTC7BRgd00
	tL8ii05xgmK2fxvmh5FImJ3ip5BW8w4XHTExaCrfEzFNfRrNkeAmmwPyaNjAz0h5r74ct5
	+wbWsDY9osJFxbp6gujxBvZd+w9W22M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787087658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUz89g6bZOzCHMpF6sYf+x1yIa9qX7Sl8l0OZsybqXk=;
	b=H8OBJGkGdVjgyGLaNb6YGj7hBFYudDHJjpUhTVBMtakBH/n+fHTT2ZIxiMDkqsfqxD6vUk
	8e19LX6ZH1uYw0Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787087653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUz89g6bZOzCHMpF6sYf+x1yIa9qX7Sl8l0OZsybqXk=;
	b=OZxPZnFfiLiNYeDl8lCyP8MIcDyzAXUU2BYyGS1QJW/R0Cea5QUZe1wbAJsGoOQFCaKObi
	eV3jMwh6vlyHKIBJlOGhu2RBP/AivYghGcsTOGUZ7VPYRmVVKA2Tf0SiHrnw0WI6nx/a2H
	1vAzdkWMi0TcVIo7sXictQsMdKHBvFE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787087653;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jUz89g6bZOzCHMpF6sYf+x1yIa9qX7Sl8l0OZsybqXk=;
	b=3Zxh5qRHQyyRXApTIwIn+mhjRZw3wyWQM2p5OJPdJO6tl+907Hx7HwvCpROJHrYB8QRkpI
	6vSI4G4YSoRYnFBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC11622BA;
	Tue, 18 Aug 2026 21:14:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VXrfLSXLhGrofgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 18 Aug 2026 21:14:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7DD1EA13AD; Tue, 18 Aug 2026 23:14:09 +0200 (CEST)
Date: Tue, 18 Aug 2026 23:14:09 +0200
From: Jan Kara <jack@suse.cz>
To: Mark Sercombe <sercombe.joel.mark@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, bcrl@kvack.org, 
	jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-aio@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/aio: fix comment typos
Message-ID: <odioi7synjmo7vlotx7e2svjacqayrbokqws76bsxxkscntigo@px2xp3rfd55x>
References: <20260813231455.558829-1-sercombe.joel.mark@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813231455.558829-1-sercombe.joel.mark@gmail.com>
X-Spam-Score: -2.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]

On Fri 14-08-26 01:14:55, Mark Sercombe wrote:
> Fix two spelling mistakes in code comments. This is a comment only
> change with no functional impact.
> 
> Signed-off-by: Mark Sercombe <sercombe.joel.mark@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index f57fa21a2503..fb991c66afdb 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -936,7 +936,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
>  
>  /*
>   * exit_aio: called when the last user of mm goes away.  At this point, there is
> - * no way for any new requests to be submited or any of the io_* syscalls to be
> + * no way for any new requests to be submitted or any of the io_* syscalls to be
>   * called on the context.
>   *
>   * There may be outstanding kiocbs, but free_ioctx() will explicitly wait on
> @@ -1280,7 +1280,7 @@ static long aio_read_events_ring(struct kioctx *ctx,
>  	 * The mutex can block and wake us up and that will cause
>  	 * wait_event_interruptible_hrtimeout() to schedule without sleeping
>  	 * and repeat. This should be rare enough that it doesn't cause
> -	 * peformance issues. See the comment in read_events() for more detail.
> +	 * performance issues. See the comment in read_events() for more detail.
>  	 */
>  	sched_annotate_sleep();
>  	mutex_lock(&ctx->ring_lock);
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
