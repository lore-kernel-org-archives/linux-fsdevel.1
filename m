Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618C4EBADC;
	Tue,  8 Sep 2026 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859633; cv=none; b=fmGSl9LybvJAJKnuHFH8WFURPtDdhXX0WkxPEp/DzsCKlLD8PvBRSTwHaeIPx7vDt4JWUr2XRpbIazJJs8b3Ss4Ci5dn2Q7iagmeWQVVCFQHImppJvmkoteEPLug0yrYMLmGm98UAq1jxliVO5Dkvqu4BQ3cZtIgquVu31bMjzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859633; c=relaxed/simple;
	bh=gV63zHCi7shw/Oa+eFIH0iTh+5EdixT92i8snzno4Es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qciFU5lIpFZvSJGy7OLtnTTKFf3tt1r+ph0ZpTx3hACSkhdZ9SMa1Y4qQcLp3q+HiRfh1p5feAZtLZ5kAqwu1GWR5jwG+1No8WF1IUSEZJsxso0K8EKTz4oiukjEZIWpsQLZTdVRffWuOVHHLih/jBrQPYjYM3eOG8QKHm+PHXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KEGrH+0/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NQRf2cZb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oXEHshzo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xXbjOXqV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KEGrH+0/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NQRf2cZb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oXEHshzo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xXbjOXqV"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CFBB021A35;
	Tue,  8 Sep 2026 09:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788859626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWGzYGgNIklpiS6XLM7Zm8kgqN/+DKlX7bMJrGwLqYU=;
	b=KEGrH+0/RoLlAYH0/UN/au5tKCS2TWkeBzSgB3LYaszFjJgXpYuljxZC1mj59dDuqKQYOd
	7TEXUuEFc+cQt1aXZxOBiLuUN3vdjUQ8lOfmgNV8+R/vIq6kBW4zc/ZsMlUtXcYJR4m5Nb
	bQUN2DjIpukCT0FieX1KmFrorKfYENk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788859626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWGzYGgNIklpiS6XLM7Zm8kgqN/+DKlX7bMJrGwLqYU=;
	b=NQRf2cZb7Uv51vqLo0+KsGutQOHl/zKrKKnkcFI0tE/HY+1fLU9tBo2uVjCAtPsYbKOLLX
	E8ZgHK8RNU7O8FAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788859621; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWGzYGgNIklpiS6XLM7Zm8kgqN/+DKlX7bMJrGwLqYU=;
	b=oXEHshzoTCnF1r1TlmbXnCyJOBBpD5Uarjj/MVKX/57jM5GwG3oTChd8PP7z4faeZRJbTR
	NhhOGtHj7XsD/enxXCnyhA7hM+PO8vjBfp99QJ2hLW65QfzBRDaxAII4AEqTK+SYGW18NB
	vPgS77LMkk0ZjgSXbxCZ6Aozj0VBJ+g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788859621;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AWGzYGgNIklpiS6XLM7Zm8kgqN/+DKlX7bMJrGwLqYU=;
	b=xXbjOXqVF26Q9UHa+S/UnsIVQ6SxBWgFZfNvcUDTUQa9s+RzXJkqibMNKzHx2XNQAPy9pc
	fg4aKWAdayZfXMCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8F6013332;
	Tue,  8 Sep 2026 09:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Az44KeXUn2qwWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Sep 2026 09:27:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 38A40A12E2; Tue, 08 Sep 2026 11:26:57 +0200 (CEST)
Date: Tue, 8 Sep 2026 11:26:57 +0200
From: Jan Kara <jack@suse.cz>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] isofs: convert the zisofs read path to use folios
Message-ID: <snq6ii4qrjqvohdcb6ybmarzjvkqpibcmnujh7ut2tbftx6egs@y7ocbbe36oap>
References: <20260907-isofs-zisofs-folio-v2-1-c2e430abfcbc@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907-isofs-zisofs-folio-v2-1-c2e430abfcbc@columbia.edu>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
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
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,suse.com:email,imap1.dmz-prg2.suse.org:helo,columbia.edu:email]

On Mon 07-09-26 11:18:38, Tal Zussman wrote:
> Store folios in the array that zisofs_read_folio() passes to
> zisofs_fill_pages() and zisofs_uncompress_block(), use the folio APIs on
> them, and grab the folios with __filemap_get_folio() instead of
> grab_cache_page_nowait(). This removes six compound_head() calls, from
> page_offset(), the three SetPageUptodate() calls, unlock_page() and
> put_page(), and the last struct page usage in isofs.
> 
> isofs only uses order-0 folios, so folio_size() is PAGE_SIZE and the
> logic is unchanged.
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

Thanks! I've added the patch to my tree.

								Honza


> ---
> Changes in v2:
> - Pass the offset to kmap_local_folio() and use folio_size(), per Jan
> - Add a sentence in the commit message about how all folios here are
>   order-0 for now
> - Link to v1: https://patch.msgid.link/20260906-isofs-zisofs-folio-v1-1-cbea614a773f@columbia.edu
> ---
>  fs/isofs/compress.c | 77 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 34 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index f9869d62b850..2d23abaeb874 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -39,7 +39,7 @@ static DEFINE_MUTEX(zisofs_zlib_lock);
>   */
>  static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  				      loff_t block_end, int pcount,
> -				      struct page **pages, unsigned poffset,
> +				      struct folio **folios, unsigned int poffset,
>  				      int *errp)
>  {
>  	unsigned int zisofs_block_shift = ISOFS_I(inode)->i_format_parm[1];
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
> +			folio_zero_range(folio, off, folio_size(folio) - off);
> +			folio_mark_uptodate(folio);
>  		}
>  		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
>  	}
> @@ -119,11 +120,12 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  	while (curpage < pcount && curbh < haveblocks &&
>  	       zerr != Z_STREAM_END) {
> +		struct folio *folio = folios[curpage];
> +
>  		if (!stream.avail_out) {
> -			if (pages[curpage]) {
> -				stream.next_out = kmap_local_page(pages[curpage])
> -						+ poffset;
> -				stream.avail_out = PAGE_SIZE - poffset;
> +			if (folio) {
> +				stream.next_out = kmap_local_folio(folio, poffset);
> +				stream.avail_out = folio_size(folio) - poffset;
>  				poffset = 0;
>  			} else {
>  				stream.next_out = (void *)&zisofs_sink_page;
> @@ -173,9 +175,9 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  
>  		if (!stream.avail_out) {
>  			/* This page completed */
> -			if (pages[curpage]) {
> -				flush_dcache_page(pages[curpage]);
> -				SetPageUptodate(pages[curpage]);
> +			if (folio) {
> +				flush_dcache_folio(folio);
> +				folio_mark_uptodate(folio);
>  			}
>  			if (stream.next_out != (unsigned char *)zisofs_sink_page) {
>  				kunmap_local(stream.next_out);
> @@ -206,7 +208,7 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>   * fills in other pages if we have data for them.
>   */
>  static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
> -			     struct page **pages)
> +			     struct folio **folios)
>  {
>  	loff_t start_off, end_off;
>  	loff_t block_start, block_end;
> @@ -221,14 +223,14 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  	int err;
>  	loff_t ret;
>  
> -	BUG_ON(!pages[full_page]);
> +	BUG_ON(!folios[full_page]);
>  
>  	/*
>  	 * We want to read at least 'full_page' page. Because we have to
>  	 * uncompress the whole compression block anyway, fill the surrounding
>  	 * pages with the data we have anyway...
>  	 */
> -	start_off = page_offset(pages[full_page]);
> +	start_off = folio_pos(folios[full_page]);
>  	end_off = min_t(loff_t, start_off + PAGE_SIZE, inode->i_size);
>  
>  	cstart_block = start_off >> zisofs_block_shift;
> @@ -267,9 +269,9 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  		}
>  		err = 0;
>  		ret = zisofs_uncompress_block(inode, block_start, block_end,
> -					      pcount, pages, poffset, &err);
> +					      pcount, folios, poffset, &err);
>  		poffset += ret;
> -		pages += poffset >> PAGE_SHIFT;
> +		folios += poffset >> PAGE_SHIFT;
>  		pcount -= poffset >> PAGE_SHIFT;
>  		full_page -= poffset >> PAGE_SHIFT;
>  		poffset &= ~PAGE_MASK;
> @@ -289,9 +291,11 @@ static int zisofs_fill_pages(struct inode *inode, int full_page, int pcount,
>  		cstart_block++;
>  	}
>  
> -	if (poffset && *pages) {
> -		memzero_page(*pages, poffset, PAGE_SIZE - poffset);
> -		SetPageUptodate(*pages);
> +	if (poffset && *folios) {
> +		struct folio *folio = *folios;
> +
> +		folio_zero_range(folio, poffset, folio_size(folio) - poffset);
> +		folio_mark_uptodate(folio);
>  	}
>  	brelse(bh);
>  	return 0;
> @@ -312,7 +316,7 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  	unsigned int zisofs_pages_per_cblock =
>  		PAGE_SHIFT <= zisofs_block_shift ?
>  		(1 << (zisofs_block_shift - PAGE_SHIFT)) : 0;
> -	struct page **pages;
> +	struct folio **folios;
>  	pgoff_t index = folio->index, end_index;
>  
>  	end_index = (inode->i_size + PAGE_SIZE - 1) >> PAGE_SHIFT;
> @@ -336,33 +340,38 @@ static int zisofs_read_folio(struct file *file, struct folio *folio)
>  		full_page = 0;
>  		pcount = 1;
>  	}
> -	pages = kzalloc_objs(*pages,
> -			     max_t(unsigned int, zisofs_pages_per_cblock, 1));
> -	if (!pages) {
> +	folios = kzalloc_objs(*folios,
> +			      max_t(unsigned int, zisofs_pages_per_cblock, 1));
> +	if (!folios) {
>  		folio_unlock(folio);
>  		return -ENOMEM;
>  	}
> -	pages[full_page] = &folio->page;
> +	folios[full_page] = folio;
>  
>  	for (i = 0; i < pcount; i++, index++) {
> -		if (i != full_page)
> -			pages[i] = grab_cache_page_nowait(mapping, index);
> +		if (i == full_page)
> +			continue;
> +		folios[i] = __filemap_get_folio(mapping, index,
> +				FGP_LOCK | FGP_CREAT | FGP_NOWAIT,
> +				mapping_gfp_mask(mapping));
> +		if (IS_ERR(folios[i]))
> +			folios[i] = NULL;
>  	}
>  
> -	err = zisofs_fill_pages(inode, full_page, pcount, pages);
> +	err = zisofs_fill_pages(inode, full_page, pcount, folios);
>  
> -	/* Release any residual pages, do not SetPageUptodate */
> +	/* Release any residual folios, do not mark them uptodate */
>  	for (i = 0; i < pcount; i++) {
> -		if (pages[i]) {
> -			flush_dcache_page(pages[i]);
> -			unlock_page(pages[i]);
> +		if (folios[i]) {
> +			flush_dcache_folio(folios[i]);
> +			folio_unlock(folios[i]);
>  			if (i != full_page)
> -				put_page(pages[i]);
> +				folio_put(folios[i]);
>  		}
> -	}			
> +	}
>  
>  	/* At this point, err contains 0 or -EIO depending on the "critical" page */
> -	kfree(pages);
> +	kfree(folios);
>  	return err;
>  }
>  
> 
> ---
> base-commit: df2908090cda368b01ff43709f51890076c56157
> change-id: 20260906-isofs-zisofs-folio-5b1621d694e4
> 
> Best regards,
> --  
> Tal Zussman <tz2294@columbia.edu>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
