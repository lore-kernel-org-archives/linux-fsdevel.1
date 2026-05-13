Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346E03D4116
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658642; cv=none; b=MsujcQNbsYv4GSNM7Isu2V73jw4U/zlLkZLfYamsuCdrb8jyogAlFEIWO8OVM+JYQHrj+NLekZ6UiY3AIHb1F+1mGifShnnEaLSPGPS7t61wQ8GqSda83fan3C/IXuNSFhM+U3RW/WDYERrhaHRo5Bmk9/R89h6iiMd8ZXRjzSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658642; c=relaxed/simple;
	bh=XkD/aPXDER22x5sNIlssoMKO4PGXb1Vt7UpdHqk4GiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqO2Oq3M18tM44mQpLw+3atoXaR+qHKOZJx0zxuNXfrdBviyIMtVrxXZ+J4f8GDSi4A+wWmszBCYhBuGzhknmwFrYR96Ea7llN5A9ZZ28oyUJDuWqE7IuVAi0cVIZSvpBrlbIySx7HbUv35crhnINFHENw2D/AVzSonan5QEriY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QjY17WuU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3/2LlsYC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QjY17WuU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3/2LlsYC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QjY17WuU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3/2LlsYC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QjY17WuU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3/2LlsYC"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4FDC57605B;
	Wed, 13 May 2026 07:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778658639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo3gnd9tOVkdydRyuHDb1N7zfRJ+dGjn+dOeC9LZ6yc=;
	b=QjY17WuUC58PIFYigADFQvCE3rF/h7uW9OOywqyAXjx1vG5Y3NoffCPLhgtyvp0mxW79sx
	EFDmthKekNV7h28r00oDwLnKbz4VB3BZegvbl6Mcw1I80wHbzw3KcRi5T3Ay3bUnPQ8/B+
	hGPPr+/zMAxyJoGhHXvs0DhL7l9+d5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778658639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo3gnd9tOVkdydRyuHDb1N7zfRJ+dGjn+dOeC9LZ6yc=;
	b=3/2LlsYC0ifFYRzcbHROh0SpDFLMt/DozcOgc/KqGnVAc/UXKLU38yCpof4c1RGNgxqzWC
	U8XzILNX/iIVfWDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QjY17WuU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3/2LlsYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778658639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo3gnd9tOVkdydRyuHDb1N7zfRJ+dGjn+dOeC9LZ6yc=;
	b=QjY17WuUC58PIFYigADFQvCE3rF/h7uW9OOywqyAXjx1vG5Y3NoffCPLhgtyvp0mxW79sx
	EFDmthKekNV7h28r00oDwLnKbz4VB3BZegvbl6Mcw1I80wHbzw3KcRi5T3Ay3bUnPQ8/B+
	hGPPr+/zMAxyJoGhHXvs0DhL7l9+d5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778658639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vo3gnd9tOVkdydRyuHDb1N7zfRJ+dGjn+dOeC9LZ6yc=;
	b=3/2LlsYC0ifFYRzcbHROh0SpDFLMt/DozcOgc/KqGnVAc/UXKLU38yCpof4c1RGNgxqzWC
	U8XzILNX/iIVfWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 46981593A9;
	Wed, 13 May 2026 07:50:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id wwE3EU8tBGrwBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 May 2026 07:50:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C94FAA0800; Wed, 13 May 2026 09:50:34 +0200 (CEST)
Date: Wed, 13 May 2026 09:50:34 +0200
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	Vishal Moola <vishal.moola@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: fix page_cache_prev_miss() when no hole
 is found
Message-ID: <tjfvsxenoioeoxacuj3yy55zygz5acvgwha34lr5uxxm4563xy@hy4a5wfu2ksx>
References: <20260512-prev_miss_fix-v2-1-4af8e5c1ae62@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512-prev_miss_fix-v2-1-4af8e5c1ae62@columbia.edu>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,columbia.edu:email];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,gmail.com,vger.kernel.org,kvack.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4FDC57605B
X-Spam-Level: 

On Tue 12-05-26 16:45:59, Tal Zussman wrote:
> page_cache_prev_miss() is documented to return a value outside the
> searched range when no gap is found. However, the no-gap-found path
> returns xas.xa_index, which after a successful loop is the first index
> in the range. As such, that index is misreported as a gap.
> 
> The sole caller, page_cache_sync_ra(), uses the return value to estimate
> the cached run preceding a sequential read. In some cases, the buggy
> return value can undercount the contiguous range by one, shrinking the
> readahead window or pushing borderline requests into the
> small-random-read branch.
> 
> Fix this by returning the start of the range - 1 when no hole is found.
> Update page_cache_next_miss() for clarity as well.
> 
> Both helpers were previously fixed together in commit 9425c591e06a
> ("page cache: fix page_cache_next/prev_miss off by one"), but the fix
> was reverted because it caused a hugetlb performance regression. hugetlb
> no longer uses these functions and next_miss was subsequently refixed
> in commit 901a269ff3d5 ("filemap: fix page_cache_next_miss() when no
> hole found") and commit bbcaee20e03e ("readahead: fix return value of
> page_cache_next_miss() when no hole is found"), but prev_miss was not
> addressed.
> 
> This was found by pointing Claude Opus 4.7 at mm/filemap.c.
> 
> Fixes: 0d3f92966629 ("page cache: Convert hole search to XArray")
> Assisted-by: Claude:claude-opus-4-7
> Signed-off-by: Tal Zussman <tz2294@columbia.edu>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Change return value for clarity, per Vishal and Jan.
> - Update page_cache_next_miss() for consistency and get rid of nr variable.
> - Link to v1: https://lore.kernel.org/r/20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu
> ---
>  mm/filemap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index ab34cab2416a..4263d9775998 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1808,9 +1808,8 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
>  			     pgoff_t index, unsigned long max_scan)
>  {
>  	XA_STATE(xas, &mapping->i_pages, index);
> -	unsigned long nr = max_scan;
>  
> -	while (nr--) {
> +	while (max_scan--) {
>  		void *entry = xas_next(&xas);
>  		if (!entry || xa_is_value(entry))
>  			return xas.xa_index;
> @@ -1818,7 +1817,8 @@ pgoff_t page_cache_next_miss(struct address_space *mapping,
>  			return 0;
>  	}
>  
> -	return index + max_scan;
> +	/* Return end of the range + 1 when no hole is found */
> +	return xas.xa_index + 1;
>  }
>  EXPORT_SYMBOL(page_cache_next_miss);
>  
> @@ -1849,12 +1849,13 @@ pgoff_t page_cache_prev_miss(struct address_space *mapping,
>  	while (max_scan--) {
>  		void *entry = xas_prev(&xas);
>  		if (!entry || xa_is_value(entry))
> -			break;
> +			return xas.xa_index;
>  		if (xas.xa_index == ULONG_MAX)
> -			break;
> +			return ULONG_MAX;
>  	}
>  
> -	return xas.xa_index;
> +	/* Return start of the range - 1 when no hole is found */
> +	return xas.xa_index - 1;
>  }
>  EXPORT_SYMBOL(page_cache_prev_miss);
>  
> 
> ---
> base-commit: e9dd96806dbc2d50a66770b6a86962bd5d601153
> change-id: 20260510-prev_miss_fix-fcb308472131
> 
> Best regards,
> -- 
> Tal Zussman <tz2294@columbia.edu>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
