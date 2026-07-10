Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366D370D5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783706339; cv=none; b=puO2UTL7Ixqk5m5tmzN3LsgsMfKTrOiBQnr5JuLsoNZ1eusU0hLOz5fVvlGKx4Hjdw3zZTf2aOQZVR7RTd8iMcmgAi7Pyf6YeovBpUU17oYyALA3gMMP6x8ZMJ7lq3eX5tO75/VnwM//UFOJwskEk0bLTPHeqHeZ/cJppt6PrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783706339; c=relaxed/simple;
	bh=IsxJ/S5rx72mGmdChcC8oHjJmBV1gT4OdPLS5ryFt78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgWEFx3r3f8RsnAvvZlV5KBkbLRF0UB4yIBBse+LOJyxHnScqzhEkNsAVEjkuu+SHZoLUj/Xr9EqS73f3GM9IHOhxTGUnCD2IQ5uYgkT6KEhotjm7SldMmeLAfu7NDuMvIPTKGR3Y9UeTikzM5p1wkyM2zKmzLhvTbAXwBQxg5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRLKMdLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fj8lmu1B; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RRLKMdLm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Fj8lmu1B; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRLKMdLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fj8lmu1B";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RRLKMdLm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Fj8lmu1B"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5AB84768AB;
	Fri, 10 Jul 2026 17:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783706336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qdjxGZy8Qv4WzY+B8ukWnDTD5tkUtlsYdD4cIzwMaM=;
	b=RRLKMdLmjQpkBc0z1jE9eDk79r9fwZuIUZGtzOsFuqZFCVZOEaiItby7LmjnYcsGPlNSjM
	sBexDruisZmtJ8vWaENaeB9K+/uQIfsQUaAyhUEUqse4jTOdwhl8NPDnFmHYIJxKhLYaSx
	Gskb+XTvNzkm4fSOek28cKr9wwuMMRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783706336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qdjxGZy8Qv4WzY+B8ukWnDTD5tkUtlsYdD4cIzwMaM=;
	b=Fj8lmu1BSsZKb+k7AA/Nyc1EninbYd7LYJHW2y7h9JCDpr7UjHmRLleYUDuiMlpwjt6Kco
	hdw8nH8lNfwWIDAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783706336; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qdjxGZy8Qv4WzY+B8ukWnDTD5tkUtlsYdD4cIzwMaM=;
	b=RRLKMdLmjQpkBc0z1jE9eDk79r9fwZuIUZGtzOsFuqZFCVZOEaiItby7LmjnYcsGPlNSjM
	sBexDruisZmtJ8vWaENaeB9K+/uQIfsQUaAyhUEUqse4jTOdwhl8NPDnFmHYIJxKhLYaSx
	Gskb+XTvNzkm4fSOek28cKr9wwuMMRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783706336;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3qdjxGZy8Qv4WzY+B8ukWnDTD5tkUtlsYdD4cIzwMaM=;
	b=Fj8lmu1BSsZKb+k7AA/Nyc1EninbYd7LYJHW2y7h9JCDpr7UjHmRLleYUDuiMlpwjt6Kco
	hdw8nH8lNfwWIDAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53219779BD;
	Fri, 10 Jul 2026 17:58:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DVRCFOAyUWqsEQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 10 Jul 2026 17:58:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F3943A109F; Fri, 10 Jul 2026 19:58:51 +0200 (CEST)
Date: Fri, 10 Jul 2026 19:58:51 +0200
From: Jan Kara <jack@suse.cz>
To: Christoph Hellwig <hch@lst.de>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: remove wb_writeout_inc
Message-ID: <4eureaes3mp7uhjpdd3sbcvrtgqorbfo7flr3yisbivom2bvoy@elrlq6ommqax>
References: <20260710051052.1839523-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710051052.1839523-1-hch@lst.de>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Level: 

On Fri 10-07-26 07:10:52, Christoph Hellwig wrote:
> Remove this entirely unused but exported function.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Sure. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/backing-dev.h |  2 --
>  mm/page-writeback.c         | 10 ----------
>  2 files changed, 12 deletions(-)
> 
> diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
> index 5b7d12b40d5e..c2284466e7aa 100644
> --- a/include/linux/backing-dev.h
> +++ b/include/linux/backing-dev.h
> @@ -76,8 +76,6 @@ static inline s64 wb_stat_sum(struct bdi_writeback *wb, enum wb_stat_item item)
>  	return percpu_counter_sum_positive(&wb->stat[item]);
>  }
>  
> -extern void wb_writeout_inc(struct bdi_writeback *wb);
> -
>  /*
>   * maximal error of a stat counter.
>   */
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index e98748112d1e..47495be68598 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -584,16 +584,6 @@ static inline void __wb_writeout_add(struct bdi_writeback *wb, long nr)
>  				       wb->bdi->max_prop_frac, nr);
>  }
>  
> -void wb_writeout_inc(struct bdi_writeback *wb)
> -{
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	__wb_writeout_add(wb, 1);
> -	local_irq_restore(flags);
> -}
> -EXPORT_SYMBOL_GPL(wb_writeout_inc);
> -
>  /*
>   * On idle system, we can be called long after we scheduled because we use
>   * deferred timers so count with missed periods.
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
