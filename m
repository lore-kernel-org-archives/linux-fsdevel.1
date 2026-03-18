Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8224E2EFDBA
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773852239; cv=none; b=OmO5kbiYexArWAMk3dB9mPC6qto8fsuwrygXQComYm+uqmR+hsTeD7GwGvUZ6uBemTCNJTkM4OaJsSGsvxS48+Yc/CWkgSYdyBBqIeEKqDtuC1nz8YpWOXe7xfuTp1ivNifY2v3E+fgSkAxsZL2Jj+0Icxu6KS9mdNe3wyZz3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773852239; c=relaxed/simple;
	bh=SSM27nyOcLn9keIcsWRK5Oar3joAba2nZLAajbv2Uz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETUjaBZvxs9fGL1p2CfMp8z3qFWj4DBEg7hio6YKvWe1qE0mKrqy6cxyZF3FFZmqvKvpK63khnA0Xfgcyviy5p1LyYzCzi1Q6QcCUE/lAWBMyLmMRZ9E1fS+tOMw0JLexUQhBST1nUvUkd9ISKCX0wJ0CVzF1B9nhmvyU309bhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HcU2XUrp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eYScP0Rw; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=v3WgJK3B; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6QnaeyRy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HcU2XUrp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eYScP0Rw";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="v3WgJK3B";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6QnaeyRy"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8CCB74D3FC;
	Wed, 18 Mar 2026 16:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773852234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yq6umHZrQ3rXklmbUtuDZyytvfdqt87VQPHzx41pFPU=;
	b=HcU2XUrp7tTN82bwTT/V/dn7JQb+ud5yJWO2ezKFWJkAtNSnW6FHEvEGlepmICnpF7CcB0
	HmePo7NRMHYrZLW3wSH6E4F5omNGswsGcaluq+GAIPbiazfF7IMK2xsWueV8yhg7F7Uee8
	YZrZ4I7gK5wH/Ez5DjgAO0S8lZ40vNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773852234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yq6umHZrQ3rXklmbUtuDZyytvfdqt87VQPHzx41pFPU=;
	b=eYScP0RwXSrnZsvcBe6RBmZBZx+683ScFXXtoLujDNfldcTonWTY5mdmHzSi8SwyivOsDt
	Yu7rpZwSzZijqeCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773852233; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yq6umHZrQ3rXklmbUtuDZyytvfdqt87VQPHzx41pFPU=;
	b=v3WgJK3BkQ3U9xZCGYD3hG5fiC5rsWkrSJ08bx3GRM83sdYyZFuzM1nEjzwVIn0NY6sOXB
	q2nAzHkE6xycu0KyV08n5KKZnVxx3ILn2rw57nW6oWJkLXGLBv9X+NCSdisXBTpYKSJgKm
	xTKaQ3zrmJxpoOQFrwAVNP0erfzjHgU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773852233;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yq6umHZrQ3rXklmbUtuDZyytvfdqt87VQPHzx41pFPU=;
	b=6QnaeyRyNOyl3U1h9EDt8rDAYrgUmw7AhgCTBE/dzz4BX5VdXOGANHHg68eMsZ/QCzindq
	3+jKuRnYJdZD0iAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E5EF4273C;
	Wed, 18 Mar 2026 16:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Um7THknWummKcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Mar 2026 16:43:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32AD6A0AFF; Wed, 18 Mar 2026 17:43:53 +0100 (CET)
Date: Wed, 18 Mar 2026 17:43:53 +0100
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, ryan.roberts@arm.com, 
	david@kernel.org, ajd@linux.ibm.com, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org, 
	catalin.marinas@arm.com, dev.jain@arm.com, jack@suse.cz, kees@kernel.org, 
	kevin.brodsky@arm.com, lance.yang@linux.dev, Liam.Howlett@oracle.com, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, lorenzo.stoakes@oracle.com, npache@redhat.com, 
	rmclure@linux.ibm.com, Al Viro <viro@zeniv.linux.org.uk>, will@kernel.org, 
	willy@infradead.org, ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH 2/4] mm: bypass mmap_miss heuristic for VM_EXEC readahead
Message-ID: <wwaqkpuvvrnp4obj6nyebbgqvugjsmelbdkunoiadqtebh4zr7@ckyn5taaz4jy>
References: <20260310145406.3073394-1-usama.arif@linux.dev>
 <20260310145406.3073394-3-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310145406.3073394-3-usama.arif@linux.dev>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_RATELIMIT(0.00)[to_ip_from(RL7mtgmzbc679884y4uzi7oxw9)];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 10-03-26 07:51:15, Usama Arif wrote:
> The mmap_miss counter in do_sync_mmap_readahead() tracks whether
> readahead is useful for mmap'd file access. It is incremented by 1 on
> every page cache miss in do_sync_mmap_readahead(), and decremented in
> two places:
> 
>   - filemap_map_pages(): decremented by N for each of N pages
>     successfully mapped via fault-around (pages found already in cache,
>     evidence readahead was useful). Only pages not in the workingset
>     count as hits.
> 
>   - do_async_mmap_readahead(): decremented by 1 when a page with
>     PG_readahead is found in cache.
> 
> When the counter exceeds MMAP_LOTSAMISS (100), all readahead is
> disabled, including the targeted VM_EXEC readahead [1] that requests
> arch-preferred folio orders for contpte mapping.
> 
> On arm64 with 64K base pages, both decrement paths are inactive:
> 
>   1. filemap_map_pages() is never called because fault_around_pages
>      (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
>      requires fault_around_pages > 1. With only 1 page in the
>      fault-around window, there is nothing "around" to map.
> 
>   2. do_async_mmap_readahead() never fires for exec mappings because
>      exec readahead sets async_size = 0, so no PG_readahead markers
>      are placed.
> 
> With no decrements, mmap_miss monotonically increases past
> MMAP_LOTSAMISS after 100 page faults, disabling all subsequent
> exec readahead.
> 
> Fix this by moving the VM_EXEC readahead block above the mmap_miss
> check. The exec readahead path is targeted. It reads a single folio at
> the fault location with async_size=0, not speculative prefetch, so the
> mmap_miss heuristic designed to throttle wasteful speculative readahead
> should not gate it. The page would need to be faulted in regardless,
> the only question is at what order.
> 
> [1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

I can see the problem but I'm not sure what you propose is the right fix.
If you move the VM_EXEC logic earlier, you'll effectively disable
VM_HUGEPAGE handling for VM_EXEC vmas which I don't think we want. So
shouldn't we rather disable mmap_miss logic for VM_EXEC vmas like:

	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
		...
	}

								Honza

> ---
>  mm/filemap.c | 72 ++++++++++++++++++++++++++++------------------------
>  1 file changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4adab..c064f31ecec5a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3331,6 +3331,37 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		}
>  	}
>  
> +	if (vm_flags & VM_EXEC) {
> +		/*
> +		 * Allow arch to request a preferred minimum folio order for
> +		 * executable memory. This can often be beneficial to
> +		 * performance if (e.g.) arm64 can contpte-map the folio.
> +		 * Executable memory rarely benefits from readahead, due to its
> +		 * random access nature, so set async_size to 0.
> +		 *
> +		 * Limit to the boundaries of the VMA to avoid reading in any
> +		 * pad that might exist between sections, which would be a waste
> +		 * of memory.
> +		 *
> +		 * This is targeted readahead (one folio at the fault location),
> +		 * not speculative prefetch, so bypass the mmap_miss heuristic
> +		 * which would otherwise disable it after MMAP_LOTSAMISS faults.
> +		 */
> +		struct vm_area_struct *vma = vmf->vma;
> +		unsigned long start = vma->vm_pgoff;
> +		unsigned long end = start + vma_pages(vma);
> +		unsigned long ra_end;
> +
> +		ra->order = exec_folio_order();
> +		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
> +		ra->start = max(ra->start, start);
> +		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
> +		ra_end = min(ra_end, end);
> +		ra->size = ra_end - ra->start;
> +		ra->async_size = 0;
> +		goto do_readahead;
> +	}
> +
>  	if (!(vm_flags & VM_SEQ_READ)) {
>  		/* Avoid banging the cache line if not needed */
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
> @@ -3361,40 +3392,15 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		return fpin;
>  	}
>  
> -	if (vm_flags & VM_EXEC) {
> -		/*
> -		 * Allow arch to request a preferred minimum folio order for
> -		 * executable memory. This can often be beneficial to
> -		 * performance if (e.g.) arm64 can contpte-map the folio.
> -		 * Executable memory rarely benefits from readahead, due to its
> -		 * random access nature, so set async_size to 0.
> -		 *
> -		 * Limit to the boundaries of the VMA to avoid reading in any
> -		 * pad that might exist between sections, which would be a waste
> -		 * of memory.
> -		 */
> -		struct vm_area_struct *vma = vmf->vma;
> -		unsigned long start = vma->vm_pgoff;
> -		unsigned long end = start + vma_pages(vma);
> -		unsigned long ra_end;
> -
> -		ra->order = exec_folio_order();
> -		ra->start = round_down(vmf->pgoff, 1UL << ra->order);
> -		ra->start = max(ra->start, start);
> -		ra_end = round_up(ra->start + ra->ra_pages, 1UL << ra->order);
> -		ra_end = min(ra_end, end);
> -		ra->size = ra_end - ra->start;
> -		ra->async_size = 0;
> -	} else {
> -		/*
> -		 * mmap read-around
> -		 */
> -		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> -		ra->size = ra->ra_pages;
> -		ra->async_size = ra->ra_pages / 4;
> -		ra->order = 0;
> -	}
> +	/*
> +	 * mmap read-around
> +	 */
> +	ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +	ra->size = ra->ra_pages;
> +	ra->async_size = ra->ra_pages / 4;
> +	ra->order = 0;
>  
> +do_readahead:
>  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  	ractl._index = ra->start;
>  	page_cache_ra_order(&ractl, ra);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
