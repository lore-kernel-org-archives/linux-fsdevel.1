Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6EA3D1CBE
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166390; cv=none; b=hePd9mFKKmJi8YnGZuH5x0rmvZuDCEfDhKPftfhYvacvTToFrpzYt6g6z7fwA2zhhYoBg21R8XEj8FYmSsNgEtzIgqqyOCSgw2PZvwkqU4bjJXB88WugGYIkaxu5n9BaaR/xjdLbjicGp9LiKVYgSgFZGDn1DPdXxVX2Tdtcrfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166390; c=relaxed/simple;
	bh=Zqq9qbFv5M+FszmPP8yoR4xQaUqEcKrJ7JQu6CVAL4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJh8ZPwuoFHgWLdTfrM1B2qHbdSN0sE5eF6jqDq6Ek2UQeOfhL2OCrBuympJvGurShA1J9Sp+/RKOvVD2HUb4dT5e60guQqs63rDHzJjq0WmPo+LUF9FX9fOQ1JuLzDbSanb5XBfn9LjHKdoU0xwg1jhKniKoCIu2TU5tz+FfCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jtLJ/fg5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xSV2K70G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YFyC1I+U; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fLkXvgyz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jtLJ/fg5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xSV2K70G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YFyC1I+U";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fLkXvgyz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CEF4221B8;
	Mon, 31 Aug 2026 08:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166382; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uox9wyt7bGtCbcnqQOYrZzQnYkQzNlSlge+IE5qfqgI=;
	b=jtLJ/fg5eecxRPMIA6tpe//fjjD05epkjfbFE2GCPindnKWdFNMKab0ybhHjOC3yDmPss0
	ajg2LtNChf3hAY0tdxqEfOyRzRSL9zhLZpYZLf/2XAkSTsNYfq341MnG/79hXvxP2X9+i1
	XAv5EP2Cc4DAO8HNVmlZnoBfWDuACsA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166382;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uox9wyt7bGtCbcnqQOYrZzQnYkQzNlSlge+IE5qfqgI=;
	b=xSV2K70GXZuSRs4pDpY4g2plTOIGhEZ5iDR6D5RIXszN3EKlP/20xhD2Nx/A9AWqFU8emE
	Al57hCGg1rn+tJAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788166378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uox9wyt7bGtCbcnqQOYrZzQnYkQzNlSlge+IE5qfqgI=;
	b=YFyC1I+UgVPKENTT0f8LeGTOONi4GAGlMtd+R7YI7UBt1RAbg/JTKGgQJfwdkoTzYDvB9a
	59Q8j08FCmOJapfC/9TV7FhGNjeybw5Q4epUQQxnBOBzFs7osm8OrISZFojpoz+5n1k9H1
	2DjVXw43NQ8hyAdVGFKthkdPABvMwgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788166378;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uox9wyt7bGtCbcnqQOYrZzQnYkQzNlSlge+IE5qfqgI=;
	b=fLkXvgyzDC96I47wSls0z7y3la4h5YE1pv4uYKdRguMsXBjiYM3CCIBYsk2cDWzUAooNVa
	27KcFEAeVqezzcDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D91C13694;
	Mon, 31 Aug 2026 08:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GL66GupAlWopLgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:52:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1003EA13B5; Mon, 31 Aug 2026 10:52:54 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:52:54 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 6/6] buffer: Rename label
Message-ID: <3qeii2sawy5um2nrg34yr5u56fhcezdwxuebpzm4zy7s55bgnn@ogz2l4oqf4be>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-7-willy@infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email]
X-Spam-Flag: NO

On Fri 28-08-26 21:54:26, Matthew Wilcox (Oracle) wrote:
> We now unlock the folio, not the page.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 9b4e462903a1..c9342aeb8cdf 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1654,7 +1654,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
>  			/* Recheck when the folio is locked which pins bhs */
>  			head = folio_buffers(folio);
>  			if (!head)
> -				goto unlock_page;
> +				goto unlock_folio;
>  			bh = head;
>  			do {
>  				if (!buffer_mapped(bh) || (bh->b_blocknr < block))
> @@ -1667,7 +1667,7 @@ void clean_bdev_aliases(struct block_device *bdev, sector_t block, sector_t len)
>  next:
>  				bh = bh->b_this_page;
>  			} while (bh != head);
> -unlock_page:
> +unlock_folio:
>  			folio_unlock(folio);
>  		}
>  		folio_batch_release(&fbatch);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
