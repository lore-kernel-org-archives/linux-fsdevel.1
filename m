Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB423D9DDC
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Apr 2026 09:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777369658; cv=none; b=sz2s59bIf1nVCvbpDcLLicwCdLunKQdElhDMFDCIxKDvwGfEBtviB6HOm4gsaMrZ0Q/abH4GYG29GyarwcZ86u4+KpzlYIsnVM78B/SxhxIAlac2EsIbp5zltIZyfa2QVqWuMFd2d/KRie0X9ZBYeyb0VzZhGkChNLicrW/w62c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777369658; c=relaxed/simple;
	bh=SsqkXeDS1Gyo50pX084H/qyNOVxdDYmDABC2KHoqtXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6SObQ5RLcy5Mt3rRRwxG+oJR0AuDiEG4sUKVdb1Sev5amdt+2etH8Ijbu2ZXEvp7N9gsQCl37QIiLDJrihgZHl5LTL3V0mYeSIPPVbMpVh/hJV+AvqSNm/wfBmiKQIe0NcTZ9euhWn1jIFv+pBGS37S5Y6taVpvGJvbeAbUH2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6QFc5a/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zQ9NhAX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=c6QFc5a/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7zQ9NhAX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6QFc5a/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zQ9NhAX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="c6QFc5a/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zQ9NhAX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4BF7B6A81E;
	Tue, 28 Apr 2026 09:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777369655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeEGehnM9Yn+J3vQq2ELaGTuX8Ip21wZTc9U7YhwItM=;
	b=c6QFc5a/JqyARhwEhPQWDHb0BYoTskOtR1t5ipRXRzaPvzRFM1cPBs6MqRz+1oTQPeKE4n
	ESIdZAAcy2an4BROa+8lnCdwz6siLlz5ga6bdZjg0JhUDSpoPL6VtU3qjx4243U4SKylID
	fu6gBKlzjsVm6GaDrFYlYOGOEqkVDuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777369655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeEGehnM9Yn+J3vQq2ELaGTuX8Ip21wZTc9U7YhwItM=;
	b=7zQ9NhAXvAd5X6khVdPAvbrqVoMB1ucnNNDT48svOE02IjSzJro0znxBCoVsqZ5FH/iMlS
	xyjBqyWBTZfYsiAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777369655; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeEGehnM9Yn+J3vQq2ELaGTuX8Ip21wZTc9U7YhwItM=;
	b=c6QFc5a/JqyARhwEhPQWDHb0BYoTskOtR1t5ipRXRzaPvzRFM1cPBs6MqRz+1oTQPeKE4n
	ESIdZAAcy2an4BROa+8lnCdwz6siLlz5ga6bdZjg0JhUDSpoPL6VtU3qjx4243U4SKylID
	fu6gBKlzjsVm6GaDrFYlYOGOEqkVDuo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777369655;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VeEGehnM9Yn+J3vQq2ELaGTuX8Ip21wZTc9U7YhwItM=;
	b=7zQ9NhAXvAd5X6khVdPAvbrqVoMB1ucnNNDT48svOE02IjSzJro0znxBCoVsqZ5FH/iMlS
	xyjBqyWBTZfYsiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 36F91593B0;
	Tue, 28 Apr 2026 09:47:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JqxmDTeC8GluBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 28 Apr 2026 09:47:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F062AA0B62; Tue, 28 Apr 2026 11:47:34 +0200 (CEST)
Date: Tue, 28 Apr 2026 11:47:34 +0200
From: Jan Kara <jack@suse.cz>
To: fujunjie <fujunjie1@qq.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, 
	Haoran Zhu <zhr1502@sjtu.edu.cn>
Subject: Re: [PATCH v3 1/2] mm/filemap: count only the faulting address as a
 mmap hit
Message-ID: <pkmextergrngpi2cr62ggyxo6dx2fcof4jkr3767ji2sie6rxi@zyhhraxrqycn>
References: <tencent_AA501E9A238337BD167E5C2ACF948A1AF308@qq.com>
 <tencent_756F151FE66F3D80479A6F982C0AB8569F09@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_756F151FE66F3D80479A6F982C0AB8569F09@qq.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[qq.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,qq.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 28-04-26 01:59:43, fujunjie wrote:
> filemap_map_pages() reduces file->f_ra.mmap_miss when fault-around maps
> folios that are already present in the page cache.  That hit accounting
> is too generous because fault-around can install PTEs around the
> faulting address even though the fault only proves that the faulting
> address was accessed.
> 
> Move the mmap_miss update back into filemap_map_pages(), drop the
> mmap_miss argument from the helper functions, and decrement mmap_miss
> only when the helper return value shows that the faulting address was
> mapped.  Keep the existing workingset-folio behavior unchanged.
> 
> Signed-off-by: fujunjie <fujunjie1@qq.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 62 ++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c1..543e51c32397 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3747,8 +3747,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
>  static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  			struct folio *folio, unsigned long start,
>  			unsigned long addr, unsigned int nr_pages,
> -			unsigned long *rss, unsigned short *mmap_miss,
> -			pgoff_t file_end)
> +			unsigned long *rss, pgoff_t file_end)
>  {
>  	struct address_space *mapping = folio->mapping;
>  	unsigned int ref_from_caller = 1;
> @@ -3780,16 +3779,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  		if (PageHWPoison(page + count))
>  			goto skip;
>  
> -		/*
> -		 * If there are too many folios that are recently evicted
> -		 * in a file, they will probably continue to be evicted.
> -		 * In such situation, read-ahead is only a waste of IO.
> -		 * Don't decrease mmap_miss in this scenario to make sure
> -		 * we can stop read-ahead.
> -		 */
> -		if (!folio_test_workingset(folio))
> -			(*mmap_miss)++;
> -
>  		/*
>  		 * NOTE: If there're PTE markers, we'll leave them to be
>  		 * handled in the specific fault path, and it'll prohibit the
> @@ -3836,7 +3825,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
>  
>  static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>  		struct folio *folio, unsigned long addr,
> -		unsigned long *rss, unsigned short *mmap_miss)
> +		unsigned long *rss)
>  {
>  	vm_fault_t ret = 0;
>  	struct page *page = &folio->page;
> @@ -3844,10 +3833,6 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
>  	if (PageHWPoison(page))
>  		goto out;
>  
> -	/* See comment of filemap_map_folio_range() */
> -	if (!folio_test_workingset(folio))
> -		(*mmap_miss)++;
> -
>  	/*
>  	 * NOTE: If there're PTE markers, we'll leave them to be
>  	 * handled in the specific fault path, and it'll prohibit
> @@ -3882,7 +3867,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	vm_fault_t ret = 0;
>  	unsigned long rss = 0;
>  	unsigned int nr_pages = 0, folio_type;
> -	unsigned short mmap_miss = 0, mmap_miss_saved;
>  
>  	/*
>  	 * Recalculate end_pgoff based on file_end before calling
> @@ -3921,6 +3905,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  	folio_type = mm_counter_file(folio);
>  	do {
>  		unsigned long end;
> +		vm_fault_t map_ret;
>  
>  		addr += (xas.xa_index - last_pgoff) << PAGE_SHIFT;
>  		vmf->pte += xas.xa_index - last_pgoff;
> @@ -3928,13 +3913,34 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		end = folio_next_index(folio) - 1;
>  		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
>  
> -		if (!folio_test_large(folio))
> -			ret |= filemap_map_order0_folio(vmf,
> -					folio, addr, &rss, &mmap_miss);
> -		else
> -			ret |= filemap_map_folio_range(vmf, folio,
> -					xas.xa_index - folio->index, addr,
> -					nr_pages, &rss, &mmap_miss, file_end);
> +		if (!folio_test_large(folio)) {
> +			map_ret = filemap_map_order0_folio(vmf, folio, addr,
> +							   &rss);
> +		} else {
> +			unsigned long start = xas.xa_index - folio->index;
> +
> +			map_ret = filemap_map_folio_range(vmf, folio, start,
> +							  addr, nr_pages, &rss,
> +							  file_end);
> +		}
> +		ret |= map_ret;
> +
> +		/*
> +		 * If there are too many folios that are recently evicted
> +		 * in a file, they will probably continue to be evicted.
> +		 * In such situation, read-ahead is only a waste of IO.
> +		 * Don't decrease mmap_miss in this scenario to make sure
> +		 * we can stop read-ahead.
> +		 */
> +		if ((map_ret & VM_FAULT_NOPAGE) &&
> +		    !folio_test_workingset(folio)) {
> +			unsigned short mmap_miss;
> +
> +			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
> +			if (mmap_miss)
> +				WRITE_ONCE(file->f_ra.mmap_miss,
> +					   mmap_miss - 1);
> +		}
>  
>  		folio_unlock(folio);
>  	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
> @@ -3944,12 +3943,6 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  out:
>  	rcu_read_unlock();
>  
> -	mmap_miss_saved = READ_ONCE(file->f_ra.mmap_miss);
> -	if (mmap_miss >= mmap_miss_saved)
> -		WRITE_ONCE(file->f_ra.mmap_miss, 0);
> -	else
> -		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss_saved - mmap_miss);
> -
>  	return ret;
>  }
>  EXPORT_SYMBOL(filemap_map_pages);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
