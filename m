Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310ED3DCD8E
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178963; cv=none; b=gYnCtWTllfSFk4MqzzuKkKdQR8L3VyqWUwyLHPLU9Yzw04hrrwmezWK4cEI7XMDe0Vb7MLgYo10ZVLdv1Gqs9GnmoZQTbU4RfX1xK8POd4mgBAPRDf+SZHpZiBDPj4/pAQHSDMYruBqTrwMha3rOX+GfxPOyxz8ltcCBHcyn9qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178963; c=relaxed/simple;
	bh=cCLWHz6s/kKj066yPPUVgEVfsPtlrqWrxgWbfl+XOa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCBE/uNtnaG15uJBrLpSym5UyjphcHnQrxZJaDu8tORmBr/pG+Zb63Pm+oEALrWnC3FIFu+rXfUERS8cr36g8rCXD9biynAUsbXFQ587B6hu6wEmoiMBE9D4ldWdC//mIC9LjOu2O8BJOnPXE22vu1PsIdDg2DatOxI4Pag8SA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7hXrXc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ws3P4oX5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K7hXrXc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ws3P4oX5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7hXrXc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ws3P4oX5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K7hXrXc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ws3P4oX5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44493640E0;
	Tue, 19 May 2026 08:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779178960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3G/L6XNSJ3Virpi1kuVQgznpWo59FybcDYBvi5oVS8=;
	b=K7hXrXc4iKF15aR/W9YA3P9brLc1vHWy5acWxx4DGyE2cAlcWMzFbgnayVLsPUQaTjoBVb
	n1grR6BufIIpIP4drcZc+XsRQQr1Dbjm5cXpZ3AdQ8lGOPo3rygcHn1v3AY5x+Z+ClbAdr
	hO+HTjbgtBBDfYMvsQLITFb0ZSqlaM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779178960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3G/L6XNSJ3Virpi1kuVQgznpWo59FybcDYBvi5oVS8=;
	b=ws3P4oX5+LMhNzXIwJ0bwMekAEHC6K+J/7suJs2iIBda1YorDTUG1tnZqkl4Llj/biYDoq
	j+OsS8HkHg6O/OBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779178960; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3G/L6XNSJ3Virpi1kuVQgznpWo59FybcDYBvi5oVS8=;
	b=K7hXrXc4iKF15aR/W9YA3P9brLc1vHWy5acWxx4DGyE2cAlcWMzFbgnayVLsPUQaTjoBVb
	n1grR6BufIIpIP4drcZc+XsRQQr1Dbjm5cXpZ3AdQ8lGOPo3rygcHn1v3AY5x+Z+ClbAdr
	hO+HTjbgtBBDfYMvsQLITFb0ZSqlaM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779178960;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b3G/L6XNSJ3Virpi1kuVQgznpWo59FybcDYBvi5oVS8=;
	b=ws3P4oX5+LMhNzXIwJ0bwMekAEHC6K+J/7suJs2iIBda1YorDTUG1tnZqkl4Llj/biYDoq
	j+OsS8HkHg6O/OBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 38D10593AB;
	Tue, 19 May 2026 08:22:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gt7bDdAdDGo5CAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 08:22:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BBAF9A0ADE; Tue, 19 May 2026 10:22:39 +0200 (CEST)
Date: Tue, 19 May 2026 10:22:39 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [MEH PATCH] fs/pipe: write to ->poll_usage only once
Message-ID: <mzjeex2gkhgndpzhebflu4sooa7r47bmxnwdf5qtzfqmncshgg@fe5wtl47ekgv>
References: <20260516021852.256932-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260516021852.256932-1-mjguzik@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Level: 

On Sat 16-05-26 04:18:52, Mateusz Guzik wrote:
> Both GNU and BSD makes share a "token pipe" between their instances, as
> a result a -j $BIGNUM invocation results in multicore perf problems in
> the poll handler.
> 
> Avoiding the store will reduce it a little bit. However, the crux of the
> problem is the locked queuing up in poll_wait().
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

I guess doesn't harm to reduce cacheline invalidations. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> disclaimer: could not be bothered to bench this
> 
>  fs/pipe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 9841648c9cf3..e37c79935ecb 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -664,7 +664,8 @@ pipe_poll(struct file *filp, poll_table *wait)
>  	union pipe_index idx;
>  
>  	/* Epoll has some historical nasty semantics, this enables them */
> -	WRITE_ONCE(pipe->poll_usage, true);
> +	if (unlikely(!READ_ONCE(pipe->poll_usage)))
> +		WRITE_ONCE(pipe->poll_usage, true);
>  
>  	/*
>  	 * Reading pipe state only -- no need for acquiring the semaphore.
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
