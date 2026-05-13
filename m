Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2BD3E5ECA
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 11:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670983; cv=none; b=iet+4EJERITZEBaKHIUa7sJPYCVAnaY2hFulsnB1ilSglHf6RXU2TgLq0miPf6g4NmjOcTCINKchf9BfPmMGvqcwEFaGHIZ0pvU1FJNO7HVf5xM/AmflkeJ6d3UjIu6baxxj+KxIxIjil/EkWWNnV9T1YjVI2UFo9Rfv0y7uYjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670983; c=relaxed/simple;
	bh=y9hRUvHZFkgQQiNTzqI+EL00dDCobgs9UXhxWxO0U+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7vq0+SW++lLfFSUQfZgxfKamMDDN6ZOAaJgi2dIuPbrr8C44LAjVWyMtRCuwNyldPSxgfSDhKqI1Gzq4uvLeOstJW2qBvLhAinksf0ke0J3y2nMQyJE0PQxgLkgt6CUF9M0aim5C51KFYoY80KOlAX+AFafDH4t/bsCiDH4THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfFhp2Fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6M7yswMb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JfFhp2Fq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6M7yswMb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfFhp2Fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6M7yswMb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JfFhp2Fq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6M7yswMb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A2A675AC1;
	Wed, 13 May 2026 11:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778670978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lycp/moaJ9lpEBSEImhT67gHpALm4OfaRBlzDnz4+Qs=;
	b=JfFhp2FqnQWMLpq+wOOMAeynqHh69MjGq94AvNQ4gF9ZkpdrgnnMz3rryzu4VfN6gHhgS6
	F0kKfbCzXjIT+L4J33x5U/h4i4tuo7UZy6OswUR/UnRFBFdbpZXu9MVo2/FnU/5wUSKUiH
	bkg77cXivpw3f4jlpLMmQ/0dWQsMt0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778670978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lycp/moaJ9lpEBSEImhT67gHpALm4OfaRBlzDnz4+Qs=;
	b=6M7yswMbrzGxme0KrgazzRA+lz84tIGwq11vrtljhnF9y4ukubt4ZuxtSCwEhpJKDUXMZ2
	7bBy2ydRIP+tFhBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778670978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lycp/moaJ9lpEBSEImhT67gHpALm4OfaRBlzDnz4+Qs=;
	b=JfFhp2FqnQWMLpq+wOOMAeynqHh69MjGq94AvNQ4gF9ZkpdrgnnMz3rryzu4VfN6gHhgS6
	F0kKfbCzXjIT+L4J33x5U/h4i4tuo7UZy6OswUR/UnRFBFdbpZXu9MVo2/FnU/5wUSKUiH
	bkg77cXivpw3f4jlpLMmQ/0dWQsMt0Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778670978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lycp/moaJ9lpEBSEImhT67gHpALm4OfaRBlzDnz4+Qs=;
	b=6M7yswMbrzGxme0KrgazzRA+lz84tIGwq11vrtljhnF9y4ukubt4ZuxtSCwEhpJKDUXMZ2
	7bBy2ydRIP+tFhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4F28E593A9;
	Wed, 13 May 2026 11:16:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fGVKE4JdBGp5VgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 13 May 2026 11:16:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E3A88A0800; Wed, 13 May 2026 13:16:13 +0200 (CEST)
Date: Wed, 13 May 2026 13:16:13 +0200
From: Jan Kara <jack@suse.cz>
To: Frederick Mayle <fmayle@google.com>
Cc: android-mm@google.com, kernel-team@android.com, 
	Kalesh Singh <kaleshsingh@google.com>, Suren Baghdasaryan <surenb@google.com>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: no PG_readahead on EOF
Message-ID: <l237hfckt6dyz2zpsaeewyisqh2rpbgkdciucbfvlpmjkls3lt@2tazs6us2dak>
References: <20260508181237.670645-1-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508181237.670645-1-fmayle@google.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 08-05-26 11:12:31, Frederick Mayle wrote:
> When readahead pulls in all the remaining pages for a file, setting the
> readahead bit is counter productive. The async readahead it would
> trigger would almost certainly be a no-op. Additionally, for mmap'd file
> IO, the readahead bit limits the fault around [0], causing an extra
> minor fault when the page is accessed.
> 
> This was discovered when looking at /sys/kernel/tracing/events/readahead
> traces for a simple program. With the patch applied, fewer
> page_cache_ra_unbounded calls are observed.
> 
> [1] do_fault_around calls filemap_map_pages, which finds eligible pages
>     by calling next_uptodate_folio [2]. next_uptodate_folio skips pages
>     with PG_readahead set [3].
> 
> Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3921-L3939 [2]
> Link: https://github.com/torvalds/linux/blob/v7.0/mm/filemap.c#L3721-L3722 [3]
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Frederick Mayle <fmayle@google.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

The issue Sashiko pointed out is real but preexisting issue which isn't
really related to your changes and your patch doesn't make it worse so I'd
just ignore it.

								Honza

> ---
>  mm/readahead.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8c12b63ccd4a..784a3bde82be 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -329,8 +329,11 @@ static void do_page_cache_ra(struct readahead_control *ractl,
>  	if (index > end_index)
>  		return;
>  	/* Don't read past the page containing the last byte of the file */
> -	if (nr_to_read > end_index - index)
> +	if (nr_to_read > end_index - index) {
>  		nr_to_read = end_index - index + 1;
> +		/* We've reached the end, so don't set a readahead marker. */
> +		lookahead_size = 0;
> +	}
>  
>  	filemap_invalidate_lock_shared(mapping);
>  	page_cache_ra_unbounded(ractl, nr_to_read, lookahead_size);
> @@ -474,7 +477,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	pgoff_t index = start;
>  	unsigned int min_order = mapping_min_folio_order(mapping);
>  	pgoff_t limit;
> -	pgoff_t mark = index + ra->size - ra->async_size;
> +	pgoff_t mark;
>  	unsigned int nofs;
>  	int err = 0;
>  	gfp_t gfp = readahead_gfp_mask(mapping);
> @@ -488,7 +491,13 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  
>  	limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
>  	limit = min(limit, ractl->_max_index);
> -	limit = min(limit, index + ra->size - 1);
> +	if (limit > index + ra->size - 1) {
> +		limit = index + ra->size - 1;
> +		mark = index + ra->size - ra->async_size;
> +	} else {
> +		/* We've reached the end, so don't set a readahead marker. */
> +		mark = ULONG_MAX;
> +	}
>  
>  	new_order = min(mapping_max_folio_order(mapping), new_order);
>  	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> 
> base-commit: 2d565cbaafd43b10b75da56e43e5db9852a56afd
> -- 
> 2.54.0.563.g4f69b47b94-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
