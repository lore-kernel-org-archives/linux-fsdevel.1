Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5240739FCCC
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121307; cv=none; b=NJCtHvvv2OH++DuqVxKvy605lVNPczg9/5zinxxkVC60UG4L6c1hgWVUgtNZFgl0f3ZW8m7rX9hB4slhSiK8ZcylGBBgeRvcYzkSTMCdgTMkiRN0LuuzMV6fO2WxN9yIQqWuI+akti+8r36Cn1W+zDYiyDJTzPIcpK/+gsQsWjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121307; c=relaxed/simple;
	bh=ZsXEm5zJJkcdQMshcQs/Adhc5P+wLA6o424aPjnFuN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gc93mYxzUEA10ZqZQQ0sr8V9kBGJ4o6G5j5c1AVw9t2a22aExeywpiRumJXx6Sb+VzYQOmqTAw6Amv9hirOJnUi9Qi1xgPotXiSI4gqbXW/eSEIna0D4NuHXvjnwD8mGd4cqYSvQ/VY3Kn4i7CrFGT69688iSp7ULYbT95dNJsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c767PsgN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qcBENdQQ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c767PsgN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qcBENdQQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c767PsgN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qcBENdQQ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c767PsgN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qcBENdQQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 52F4670701;
	Mon, 22 Jun 2026 09:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782121300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEP5WSzP4FK9AKt8AuztyiGTL1SDReGNlzFieNHQHCU=;
	b=c767PsgN50IaMO8uSq35nEr18Q/5aMlV0rlKSFVea1+k9hVpMBeDYG2MfxcFJkTqgKuH6i
	0McSNr54ZLk8YLGyxrLCyqM0rlwRb1pBY7SsK7jQoH3UA65xy5u0dZI0QFuUR7EMNA0wQ+
	+BHkVbPUjIg3LciwKdz3ALU1A44JFR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782121300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEP5WSzP4FK9AKt8AuztyiGTL1SDReGNlzFieNHQHCU=;
	b=qcBENdQQY3940Tftz3LBmPNDp5mtyepERPWRxEx7VYMSPhT9nJ2dDsiAt1COsx0dIEHS9/
	6Icv8+70rlT/cABg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782121300; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEP5WSzP4FK9AKt8AuztyiGTL1SDReGNlzFieNHQHCU=;
	b=c767PsgN50IaMO8uSq35nEr18Q/5aMlV0rlKSFVea1+k9hVpMBeDYG2MfxcFJkTqgKuH6i
	0McSNr54ZLk8YLGyxrLCyqM0rlwRb1pBY7SsK7jQoH3UA65xy5u0dZI0QFuUR7EMNA0wQ+
	+BHkVbPUjIg3LciwKdz3ALU1A44JFR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782121300;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OEP5WSzP4FK9AKt8AuztyiGTL1SDReGNlzFieNHQHCU=;
	b=qcBENdQQY3940Tftz3LBmPNDp5mtyepERPWRxEx7VYMSPhT9nJ2dDsiAt1COsx0dIEHS9/
	6Icv8+70rlT/cABg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 491D5779A8;
	Mon, 22 Jun 2026 09:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Il3YEVQDOWpwQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 09:41:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E89E3A12DE; Mon, 22 Jun 2026 11:41:35 +0200 (CEST)
Date: Mon, 22 Jun 2026 11:41:35 +0200
From: Jan Kara <jack@suse.cz>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH 1/2] mm/filemap: reduce unnecessary xarray lookups when
 read cached pages
Message-ID: <b4igdzwm7vim23hcloatr2gpo4wlsbqkavq6bwifm7fbcehdai@op3ekmbv6so7>
References: <20260620062446.351475-1-chizhiling@163.com>
 <20260620062446.351475-2-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620062446.351475-2-chizhiling@163.com>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,kylinos.cn:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Sat 20-06-26 14:24:45, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> When reading small amounts of data from the page cache, only a single
> folio is typically returned from filemap_read_get_batch(). In this case,
> calling xas_advance() or xas_next() after adding the folio to the batch
> is unnecessary and only introduces extra branches.
> 
> The same issue exists for large reads, where one additional xarray walk
> is always performed before termination.
> 
> Quit the loop once we get the last folio in the range, so the final
> redundant xarray advancement can be avoided.
> 
> The xas_next() does not update xa_index when xas->xa_node is set to
> XAS_RESTART, so the put and retry path would not update xa_index,
> hence the warning should therefore never trigger.
> 
> During the 4k reads test, the overhead of this function dropped from
> 2.91% to 2.53%.
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 09cf51fd43b2..199c835c68bf 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2467,11 +2467,14 @@ static void filemap_get_read_batch(struct address_space *mapping,
>  	XA_STATE(xas, &mapping->i_pages, index);
>  	struct folio *folio;
>  
> +	if (index > max)
> +		return;
> +
>  	rcu_read_lock();
>  	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
>  		if (xas_retry(&xas, folio))
>  			continue;
> -		if (xas.xa_index > max || xa_is_value(folio))
> +		if (xa_is_value(folio))
>  			break;
>  		if (xa_is_sibling(folio))
>  			break;
> @@ -2488,6 +2491,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
>  		if (folio_test_readahead(folio))
>  			break;
>  		xas_advance(&xas, folio_next_index(folio) - 1);
> +		if (xas.xa_index >= max)
> +			break;
>  		continue;
>  put_folio:
>  		folio_put(folio);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
