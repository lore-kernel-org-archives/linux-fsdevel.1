Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C13A05C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jun 2026 09:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782121509; cv=none; b=iEfDduxoqcWhq0Vmqi9SDiZw9G5N+ZjnITFc8M0U5uVk2n89geLWwvU90mZ+H73ASpdAJdHWJAc4TT8lpWLLM8lMFjBhjnxan4FF13JAWiTBep+1zrlC6eNUfCKAalpsBYwuu6S9ajnpzVH5PYPSpNnhryT5+U9W5b4IN6jhCWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782121509; c=relaxed/simple;
	bh=zjjtBa53PJ/D9RGfSxEde79Db7Oj8b5OJICqQSHlqW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnw0/0fijFniNSYngAa1J8O+SI09jNUAm1bxeskW/FHtpJJaBnv6TlWeTKUkj9ud2cwZ050tKrmH0QGhi3F36a69IFVXiq4xi0q1w64K4L4UhIMlJUauHMbZ1rBalaeh3PDS3vEVJnROAaEG0t93MDQfLa2GFDmigHsRFC1wFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=07fja9HP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9XY7ja74; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MOop4gpu; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7oEoYWGq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="07fja9HP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9XY7ja74";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MOop4gpu";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7oEoYWGq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 411AD75C77;
	Mon, 22 Jun 2026 09:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782121504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awkGMLcNQTXeoZYS3WSSrFuhu9UYarp2Pp+iMwFqadQ=;
	b=07fja9HPTM9mrOeQ9kTjjZDpnykpKOVj2QGbffa2CkoCM2ZB1HokGz9okyUKeZzadJiW4o
	Mkxbm+HrsFadSfZu4HHP5CXExQW28qGD9lNwcnlQFtMIY8YBIVXcwSJ+1y3bcs+Wxv+sLy
	S3FO8An8KzUrF/fTxvPNa0VjahDJrDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782121504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awkGMLcNQTXeoZYS3WSSrFuhu9UYarp2Pp+iMwFqadQ=;
	b=9XY7ja74QqMm2l2oUaeWaUOIVYpUhMefDP2PUO5nXRYPxfjpGvK2p7rvcJ23v2HdNa+EuL
	ePxOhdM31pwzbIDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MOop4gpu;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7oEoYWGq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782121503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awkGMLcNQTXeoZYS3WSSrFuhu9UYarp2Pp+iMwFqadQ=;
	b=MOop4gpuAEmAdUk2XT1F0kBCviZXTkmFbodDR+hzYA1agCt2L0oqcVUtsm0UDhYNR4d/+W
	kmMyAZzX8jX4uIe2RXGyRBQLlwFqG6qunCXyprlAg7/pcwRN0uWdLZQWyj7JJReWeLa9vu
	GHwqP8gnrzlBrR+ZhvqHNVXNqcdXQmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782121503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=awkGMLcNQTXeoZYS3WSSrFuhu9UYarp2Pp+iMwFqadQ=;
	b=7oEoYWGqzLPNkxotKFWQtvkIrjJTNMjiCPrPQzrvJRa1eFXeja11YfC6CUPAXMb/gdBgI4
	FmhUFOKSvBSmVyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 390B3779A8;
	Mon, 22 Jun 2026 09:45:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GRTsDR8EOWrfRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 22 Jun 2026 09:45:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D5086A12DE; Mon, 22 Jun 2026 11:45:02 +0200 (CEST)
Date: Mon, 22 Jun 2026 11:45:02 +0200
From: Jan Kara <jack@suse.cz>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH 2/2] mm/filemap: reduce unnecessary xarray lookups in
 filemap_get_folios_contig()
Message-ID: <wznnhy6lnmwiwb6yay3rnuq23ougftzkxlckdne2ujrfi57g24@ylpkr7snc6ho>
References: <20260620062446.351475-1-chizhiling@163.com>
 <20260620062446.351475-3-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260620062446.351475-3-chizhiling@163.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 411AD75C77
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[163.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[163.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email,kylinos.cn:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Sat 20-06-26 14:24:46, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> Apply the same optimization used in filemap_get_read_batch() by moving
> the boundary check from the loop condition to before xas_next(),
> avoiding an unnecessary xarray lookup and reducing branches in the fast
> path.
> 
> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 29 ++++++++++++++---------------
>  1 file changed, 14 insertions(+), 15 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 199c835c68bf..4ee591bc7e71 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2270,10 +2270,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  	unsigned long nr;
>  	struct folio *folio;
>  
> -	rcu_read_lock();
> +	if (*start > end)
> +		return 0;
>  
> -	for (folio = xas_load(&xas); folio && xas.xa_index <= end;
> -			folio = xas_next(&xas)) {
> +	rcu_read_lock();
> +	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
>  		if (xas_retry(&xas, folio))
>  			continue;
>  		/*
> @@ -2281,11 +2282,11 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  		 * No current caller is looking for DAX entries.
>  		 */
>  		if (xa_is_value(folio))
> -			goto update_start;
> +			break;
>  
>  		/* If we landed in the middle of a THP, continue at its end. */
>  		if (xa_is_sibling(folio))
> -			goto update_start;
> +			break;
>  
>  		if (!folio_try_get(folio))
>  			goto retry;
> @@ -2293,29 +2294,27 @@ unsigned filemap_get_folios_contig(struct address_space *mapping,
>  		if (unlikely(folio != xas_reload(&xas)))
>  			goto put_folio;
>  
> -		if (!folio_batch_add(fbatch, folio)) {
> -			*start = folio_next_index(folio);
> -			goto out;
> -		}
> +		if (!folio_batch_add(fbatch, folio))
> +			break;
> +
>  		xas_advance(&xas, folio_next_index(folio) - 1);
> +		if (xas.xa_index >= end)
> +			break;
>  		continue;
> +
>  put_folio:
>  		folio_put(folio);
> -
>  retry:
>  		xas_reset(&xas);
>  	}
> +	rcu_read_unlock();
>  
> -update_start:
>  	nr = folio_batch_count(fbatch);
> -
>  	if (nr) {
>  		folio = fbatch->folios[nr - 1];
>  		*start = folio_next_index(folio);
>  	}
> -out:
> -	rcu_read_unlock();
> -	return folio_batch_count(fbatch);
> +	return nr;
>  }
>  EXPORT_SYMBOL(filemap_get_folios_contig);
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
