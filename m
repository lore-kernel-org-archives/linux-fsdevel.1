Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057B63AFAEF;
	Mon,  7 Sep 2026 09:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773703; cv=none; b=UCCSGFStJP8E5Ah1IMo+5o6dpCs6iIO6PERllipRyujCRxAsrfgHSlZzkB5x5EKrUuuSQx+glySR40AXg3UlGPnSYkbh3/dWCEGk22djyjL0/NS+BJvC1YO2mrz1sZnNAdgxI2bMJPIUPXK/fU4DEOjcL/EVOWzwxs34IsQaoHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773703; c=relaxed/simple;
	bh=a8H8jpg4QwUfF4hvTP/sy5BRmF4Qyj0ylhOJEWeS8bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iSXPBXbCmJvnT2Um3OuC60Pl4w6s3FcmHHRXQ5Y/9Lk17K9wLeU5GL4EtIJ78NWw3gdAfZLE91RUjOW6mqpkGCmPkoUlW0iCrPfsIxIb+l5r3T8aI2XXlRuajQRJxJWPwRTdzQxatsgyEPG0hg1xd4IY9YDHPaiiHgGYeiPDqS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rm8rowW4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4UaSXtyp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eaYK6j2M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4llbA5GK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rm8rowW4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4UaSXtyp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eaYK6j2M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4llbA5GK"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 96F661F454;
	Mon,  7 Sep 2026 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788773695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adJVSXwhGmsIk3NzRa6grjuOTSMK7bmU/5x4HpWCdnA=;
	b=rm8rowW4xwmTvxo1UdaiLEbqD9zBepZt8sJ/LjtYLuzoApIUthXI4cASVpDWzmbY5CecT/
	wrzTeylOQWKsTBvmeaeOsNhw9gJkHHRDWZeXits8cqrUH6JkEVBefyIL35rPWds2IuOm/B
	gmoownRDMaohe20MeQUV1n8q/LlC4f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788773695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adJVSXwhGmsIk3NzRa6grjuOTSMK7bmU/5x4HpWCdnA=;
	b=4UaSXtypwrGFsP/mSmYFt+EVAK03tYQJMNjNzOdYmZV3NliLOxaPE2AOvTQg0d1WijdqH3
	EDg9a8Blvnlw52Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788773691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adJVSXwhGmsIk3NzRa6grjuOTSMK7bmU/5x4HpWCdnA=;
	b=eaYK6j2M6xc73fz/rGEuyxXoSF7gde+Av1UaOfDPv6BddWVTDLbjTVuC1DDXLwQn97wwdi
	AdGZxp+lys5Q2xDJs+WVlotJxM0aOHxjIEQ8YLPqGS9Lh0XyL/Zs+9dhGgMXTOcnt4JlPK
	Tk0QWSlRf1FqGL/fz6paAiyYjLM2Zrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788773691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=adJVSXwhGmsIk3NzRa6grjuOTSMK7bmU/5x4HpWCdnA=;
	b=4llbA5GKrx9hciidQdyF7E5LL57l1s4McUG4GVg1hXrlQly088LELaKfuYSrNJZLKZ53d2
	S0bX7wLxO5uSJ6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 77D5913432;
	Mon,  7 Sep 2026 09:34:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id se45HTuFnmqyAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 09:34:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14EB9A13B2; Mon, 07 Sep 2026 11:34:51 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:34:51 +0200
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] isofs: convert the zisofs read path to use folios
Message-ID: <4cnybzi6btbswplm6xeuamkxf7k7a7hlvw5oa4urst6tltbw4x@77nu26jpv5oq>
References: <20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Sun 06-09-26 22:14:59, Tal Zussman wrote:
> Store folios in the array that zisofs_read_folio() passes to
> zisofs_fill_pages() and zisofs_uncompress_block(), use the folio APIs on
> them, and grab the folios with __filemap_get_folio() instead of
> grab_cache_page_nowait(). This removes six compound_head() calls, from
> page_offset(), the three SetPageUptodate() calls, unlock_page() and
> put_page(), and the last struct page usage in isofs.
> 
> grab_cache_page_nowait() passed FGP_NOFS as well, but FGP_NOWAIT already
> prevents reclaim entirely, so leave it out, as FGP_NOFS is on its way
> out [1].
> 
> Change poffset to be unsigned int rather than just unsigned while at
> it.
> 
> [1] https://lore.kernel.org/linux-mm/20260830041901.2668-9-willy@infradead.org/
> 
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Thanks for the conversion! The patch looks mostly good, some smaller
comments below:

> @@ -66,11 +66,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	if (block_size == 0) {
>  		for ( i = 0 ; i < pcount ; i++ ) {
>  			unsigned int off = i ? 0 : poffset;
> +			struct folio *folio = folios[i];
>  
> -			if (!pages[i])
> +			if (!folio)
>  				continue;
> -			memzero_page(pages[i], off, PAGE_SIZE - off);
> -			SetPageUptodate(pages[i]);
> +			folio_zero_range(folio, off, PAGE_SIZE - off);
						     ^^ perhaps
"folio_size(folio) - off" here?

> +			folio_mark_uptodate(folio);
>  		}
>  		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
>  	}
...
> @@ -119,9 +120,11 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	while (curpage < pcount && curbh < haveblocks &&
>  	       zerr != Z_STREAM_END) {
> +		struct folio *folio = folios[curpage];
> +
>  		if (!stream.avail_out) {
> -			if (pages[curpage]) {
> -				stream.next_out = kmap_local_page(pages[curpage])
> +			if (folio) {
> +				stream.next_out = kmap_local_folio(folio, 0)
>  						+ poffset;
						  ^^^ this is just:
					kmap_local_folio(folio, poffset);

>  				stream.avail_out = PAGE_SIZE - poffset;

And this would be probably more idiomatic as "folio_size(folio) - poffset"
after the conversion.

...
> @@ -289,9 +292,11 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  		cstart_block++;
>  	}
>  
> -	if (poffset && *pages) {
> -		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
> -		SetPageUptodate(*pages);
> +	if (poffset && *folios) {
> +		struct folio *folio = *folios;
> +
> +		folio_zero_range(folio, poffset, PAGE_SIZE - poffset);
						 ^^^ again
folio_size(folio) here?

> +		folio_mark_uptodate(folio);
>  	}
>  	brelse(bh);
>  	return 0;

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
