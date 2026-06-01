Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838C2E8E09
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330930; cv=none; b=KbPThk01cMhytpZG2hb4IPeQdPQBtipBgzyAECQKyxl+XpVL13u7q2bw5LlRpA5vfbmE1aFDaSVYsMOJfBCwbO+9JYlLZOJfl4GPU41pVRe7C6WPuDEK5Cg1IGo/g062b8jBd8OnhMMMEjc3OqsMiq4n3jV0LlyLV9tOPJ9mGv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330930; c=relaxed/simple;
	bh=KMLZ4U3IL6Bh3qgA/o44p7T6keZP+j9wktraxWE6f2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGfxKWqzoDjVIhCBXxZf0DCVmFv5gk4wbV14g9ccaPs9QWbQeBEbfluSWEv2WZ2rPeCkIXlPqppA15Entia27rJwwHk3oEbTLWk28LWyEuOHKOJo0ajz+sS9Esmzga5khN30AMUaDZPjLqMKi/uvs1qf7AXLIxsKwcCDL2uyFFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPm/IEwl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3+UC3Ca; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DPm/IEwl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=T3+UC3Ca; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPm/IEwl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3+UC3Ca";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DPm/IEwl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="T3+UC3Ca"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6CD78686BF;
	Mon,  1 Jun 2026 16:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780330927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ72TgsJrRv/vGY/p+18ZB9GO9DQ5TW6tac2G606Edg=;
	b=DPm/IEwlGpkf8NfyX+80UyDZbZ2hucyaoC16feayRVX7XSuuWtIqBDRm5Om34HWmnazyZl
	L6rMA++cI7goHDO5iLaBApGIYXhSv/ssJyTq4x+YJNT4h2mOqQJCmlyFNHIKaytsmbGj3I
	VQ7lqCXTOTJXHiq+kNAOMZFCjg2ixe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780330927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ72TgsJrRv/vGY/p+18ZB9GO9DQ5TW6tac2G606Edg=;
	b=T3+UC3CaTyEWfE5yipWF50DW+yQJdmohfKIaRY+q46sfLFXgCL8qJj6KcxxWxbv6JL7o2B
	IyCdMbhbiL1n1cBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780330927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ72TgsJrRv/vGY/p+18ZB9GO9DQ5TW6tac2G606Edg=;
	b=DPm/IEwlGpkf8NfyX+80UyDZbZ2hucyaoC16feayRVX7XSuuWtIqBDRm5Om34HWmnazyZl
	L6rMA++cI7goHDO5iLaBApGIYXhSv/ssJyTq4x+YJNT4h2mOqQJCmlyFNHIKaytsmbGj3I
	VQ7lqCXTOTJXHiq+kNAOMZFCjg2ixe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780330927;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ72TgsJrRv/vGY/p+18ZB9GO9DQ5TW6tac2G606Edg=;
	b=T3+UC3CaTyEWfE5yipWF50DW+yQJdmohfKIaRY+q46sfLFXgCL8qJj6KcxxWxbv6JL7o2B
	IyCdMbhbiL1n1cBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A802779A7;
	Mon,  1 Jun 2026 16:22:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hFxsFa+xHWqYdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 01 Jun 2026 16:22:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F171AA0EC0; Mon, 01 Jun 2026 18:22:02 +0200 (CEST)
Date: Mon, 1 Jun 2026 18:22:02 +0200
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, pfalcato@suse.de, 
	r@hev.cc, jack@suse.cz, Andrew Donnellan <andrew+kernel@donnellan.id.au>, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org, 
	kevin.brodsky@arm.com, lance.yang@linux.dev, "Liam R. Howlett" <liam@infradead.org>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ljs@kernel.org, mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v7 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
Message-ID: <yoma5mzdqkkcgjnq3qawaeytjx6cjmk7etzxnmkk53mov46sub@ldzkwojakaxs>
References: <20260601102205.3985788-1-usama.arif@linux.dev>
 <20260601102205.3985788-3-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601102205.3985788-3-usama.arif@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[kernel];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLx3ed8f7q4e9s3nf3mrauhj48)];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.com:email,suse.cz:email]
X-Spam-Level: 

On Mon 01-06-26 03:21:18, Usama Arif wrote:
> The force_thp_readahead path in do_sync_mmap_readahead() is gated on
> HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always requests
> HPAGE_PMD_ORDER / HPAGE_PMD_NR. On configurations where HPAGE_PMD_ORDER
> exceeds MAX_PAGECACHE_ORDER, notably arm64 with a 64K base page size,
> VM_HUGEPAGE mappings cannot use this path and fall back to the non-forced
> mmap readahead path even when the mapping supports useful large folios.
> 
> Enable forced readahead for mappings that support large folios and request
> the max folio order supported by the mapping, capped at 2M.
> 2MB is chosen as the cap because it matches the PMD size on x86_64
> and on arm64 with 4K base pages, so the size/memory-pressure tradeoff
> for folios of that size is already well understood. On arm64 with 16K
> and 64K base page sizes, 2MB is also the contiguous-PTE (contpte)
> block size, so the resulting folios coalesce into a single TLB entry
> and reduce TLB pressure on the readahead path. This will result
> in 32M folios not being faulted in with 16K base page size for arm64,
> but with contpte, the performance difference should be negligible.
> 
> The final allocation order may still be clamped by page_cache_ra_order()
> to the mapping and request geometry, but this gives VM_HUGEPAGE mappings
> on such configurations a large-folio readahead request instead of
> dropping back to base-page readahead.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 30 ++++++++++++++++++++++--------
>  1 file changed, 22 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index a16b33e0fc71..9cf89efaf3f1 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3312,14 +3312,26 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	struct file *fpin = NULL;
>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
>  	bool force_thp_readahead = false;
> +	unsigned int thp_order = 0;
>  	unsigned short mmap_miss;
>  
>  	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
>  
>  	/* Use the readahead code, even if readahead is disabled */
> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> -	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> -		force_thp_readahead = true;
> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> +		/*
> +		 * Cap max THP order at 2MB: this is the common PMD-sized
> +		 * hugepage size, and it avoids memory pressure from very
> +		 * large forced readahead when mapping_max_folio_order() is
> +		 * high (for example, 128MB with 64K base pages on arm64).
> +		 */
> +		if (mapping_large_folio_support(mapping)) {
> +			force_thp_readahead = true;
> +			thp_order = min_t(unsigned int,
> +					  mapping_max_folio_order(mapping),
> +					  get_order(SZ_2M));
> +		}
> +	}
>  
>  	if (!force_thp_readahead) {
>  		/*
> @@ -3354,17 +3366,19 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	}
>  
>  	if (force_thp_readahead) {
> +		unsigned long folio_nr_pages = 1UL << thp_order;
> +
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
> -		ractl._index &= ~((unsigned long)HPAGE_PMD_NR - 1);
> -		ra->size = HPAGE_PMD_NR;
> +		ractl._index &= ~(folio_nr_pages - 1);
> +		ra->size = folio_nr_pages;
>  		/*
> -		 * Fetch two PMD folios, so we get the chance to actually
> +		 * Fetch two folios so we get the chance to actually
>  		 * readahead, unless we've been told not to.
>  		 */
>  		if (!(vm_flags & VM_RAND_READ))
>  			ra->size *= 2;
> -		ra->async_size = HPAGE_PMD_NR;
> -		ra->order = HPAGE_PMD_ORDER;
> +		ra->async_size = folio_nr_pages;
> +		ra->order = thp_order;
>  		page_cache_ra_order(&ractl, ra);
>  		return fpin;
>  	}
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
