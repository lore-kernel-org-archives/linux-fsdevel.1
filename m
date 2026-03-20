Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4483C3C12
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774017743; cv=none; b=suiV4/BaTtSqUja81Csh9H+ShBkZUhKM03hqdb0UJCX3jusi9nNFBJu1rsnDSN3Nq1KNyWbmgORtp+RTKjX+h5VgY8+j42lEdtj+JFmVYRkMJOEKxyQu3UZHPOzXO3g1el9a1BgfRldixQKSTPCvrxMatK76+wOEG0RS3/KnSPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774017743; c=relaxed/simple;
	bh=iKV4qtR9ehCYwcp+okMvS1lGYI02V2cpWraaON3S+kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VntrfhgFNhN64zQPmCOgZ2HY/cJ0aqjP70ZN2RP7NUSZiBJAlVxIf6/5h/j43qHvC3QJrLhYEZMfWwIH+0WwAXtRbggLlJZl0qwpCkkj9xMiuozcHUvtmiurzQ2O7FUi70A/tUr8JxJPh0uSSI+d9yJKq1mJNAzFSspJOc09xwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9P8c5j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HH6Sxvqt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K9P8c5j5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HH6Sxvqt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9P8c5j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HH6Sxvqt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K9P8c5j5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HH6Sxvqt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B6CF5BDDF;
	Fri, 20 Mar 2026 14:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774017740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9VUzKgMf5hNdrzdVMsfw7bOId+n7lQuC+5prwGhXeY=;
	b=K9P8c5j5NeE3nZT/QeFabtQCdAeEYNOJe7rdWMgMxX1SH7CydbSDGlxgTCvA2I0pZecwdL
	I3oDatS8dZeW9UBb146AJjojdUWy9sSHRw79fN1yTzX88OjkcbBe1Y+0qh/nxxzLWsMCu9
	81FS/l6Xf071zw5l8JlHwKsuVjtdo0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774017740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9VUzKgMf5hNdrzdVMsfw7bOId+n7lQuC+5prwGhXeY=;
	b=HH6SxvqtwWwEXfookhSTKVEw/oisE53rm0nNzkZHFPQLSeoTUAeN5hsZDe2gOFBdg2jwsi
	BlujbfenUIb3vOAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=K9P8c5j5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=HH6Sxvqt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774017740; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9VUzKgMf5hNdrzdVMsfw7bOId+n7lQuC+5prwGhXeY=;
	b=K9P8c5j5NeE3nZT/QeFabtQCdAeEYNOJe7rdWMgMxX1SH7CydbSDGlxgTCvA2I0pZecwdL
	I3oDatS8dZeW9UBb146AJjojdUWy9sSHRw79fN1yTzX88OjkcbBe1Y+0qh/nxxzLWsMCu9
	81FS/l6Xf071zw5l8JlHwKsuVjtdo0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774017740;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P9VUzKgMf5hNdrzdVMsfw7bOId+n7lQuC+5prwGhXeY=;
	b=HH6SxvqtwWwEXfookhSTKVEw/oisE53rm0nNzkZHFPQLSeoTUAeN5hsZDe2gOFBdg2jwsi
	BlujbfenUIb3vOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0AC7042853;
	Fri, 20 Mar 2026 14:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3KonAsxcvWnxRwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 14:42:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id BDC32A0A81; Fri, 20 Mar 2026 15:42:15 +0100 (CET)
Date: Fri, 20 Mar 2026 15:42:15 +0100
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@quack3, ziy@nvidia.com, hannes@cmpxchg.org, 
	kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm: replace exec_folio_order() with generic
 preferred_exec_order()
Message-ID: <k45xs6btmt62uerbglqe665jozrtkeoklu4rek6odgxjdj63ni@ftw6ef3ug33x>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-3-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-3-usama.arif@linux.dev>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL7pfqg7h1m44jupjp7nguhfec)];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 1B6CF5BDDF

On Fri 20-03-26 06:58:52, Usama Arif wrote:
> Replace the arch-specific exec_folio_order() hook with a generic
> preferred_exec_order() that dynamically computes the readahead folio
> order for executable memory. It targets min(PMD_ORDER, 2M) as the
> maximum, which optimally gives the right answer for contpte (arm64),
> PMD mapping (x86, arm64 4K), and architectures with smaller PMDs
> (s390 1M). It adapts at runtime based on:
> 
> - VMA size: caps the order so folios fit within the mapping
> - Memory pressure: steps down the order when the local node's free
>   memory is below the high watermark for the requested order
> 
> This avoids over-allocating on memory-constrained systems while still
> requesting the optimal order when memory is plentiful.
> 
> Since exec_folio_order() is no longer needed, remove the arm64
> definition and the generic default from pgtable.h.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
...
> +static unsigned int preferred_exec_order(struct vm_area_struct *vma)
> +{
> +	int order;
> +	unsigned long vma_len = vma_pages(vma);
> +	struct zone *zone;
> +	gfp_t gfp;
> +
> +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> +		return 0;
> +
> +	/* Cap at min(PMD_ORDER, 2M) */
> +	order = min(HPAGE_PMD_ORDER, ilog2(SZ_2M >> PAGE_SHIFT));
> +
> +	/* Don't request folios larger than the VMA */
> +	order = min(order, ilog2(vma_len));

Hum, as far as I'm checking page_cache_ra_order() used in
do_sync_mmap_readahead(), ra->order is the preferred order but it will be
trimmed down to fit both within the file and within ra->size. And ra->size
is set for the readahead to fit within the vma so I don't think any order
trimming based on vma length is needed in this place?

> +	/* Step down under memory pressure */
> +	gfp = mapping_gfp_mask(vma->vm_file->f_mapping);
> +	zone = first_zones_zonelist(node_zonelist(numa_node_id(), gfp),
> +				    gfp_zone(gfp), NULL)->zone;
> +	if (zone) {
> +		while (order > 0 &&
> +		       !zone_watermark_ok(zone, order,
> +					  high_wmark_pages(zone), 0, 0))
> +			order--;
> +	}

It looks wrong for this logic to be here. Trimming order based on memory
pressure makes sense (and we've already got reports that on memory limited
devices large order folios in the page cache have too big memory overhead
so we'll likely need to handle that for page cache allocations in general)
but IMHO it belongs to page_cache_ra_order() or some other common place
like that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
