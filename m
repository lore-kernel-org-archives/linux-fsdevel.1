Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A8D31E848
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 13:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780062064; cv=none; b=Qt1UDNJ6gPkQKqNt1tuOMofyPj8xL/Z8fnKqNR8yAPESmcn7XERAzj6TdIQWX9nTM464JmYXg9BdWNKmDn7FlCxM2PVo+rJ5zos4GHQqXAODGylESWICChzfE33dlh//M9djmxgBNZHv7SUNngJu2AIuWAtHHdB0hv67Ui9KN84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780062064; c=relaxed/simple;
	bh=8CYST1jWCC9+cRIMX01a1XWF7O4LOINLs3Omy3fgkKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7QY9O7TekckCepnVCAS2ZFWIew7sO6xywd5nTrpfSU2NOcaepJho4p5GJVy7VUX5sKE7OLs5vsO+UumpMAVKHgNzSvnqzmfInbGurJLKTm7cDeXD1vaPBiWfQrHBHTHgIlyPHlNluF/1OXCu2cBY02MyR4xVJfMbVM0dhVtL/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=DEue8dJr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8TUzjug6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=siCI9h5d; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=qtfdEoZt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="DEue8dJr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8TUzjug6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="siCI9h5d";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qtfdEoZt"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E29BF66E0D;
	Fri, 29 May 2026 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780062061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZs2J/OwZaUSPlUaqUDczW1jndaLqp3e7/hI6A90EJA=;
	b=DEue8dJrjpQwUt8QTe5EnBLUBu6Wdkam+wbrBeJHKgB2+qtg8002crZK4mrOPGy31+u5cl
	BKwHPrXw3eZLKgWf6jdt51TOrI9eOCPA/rXCj3nF4zyV6j3GPzyzIPTZ5tkJb4tYfn7P6c
	+HI80ZYO4UMKqbAAHB210n9I6Xphjdw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780062061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZs2J/OwZaUSPlUaqUDczW1jndaLqp3e7/hI6A90EJA=;
	b=8TUzjug6K/BHTB4ZI/HmSs4LalhQCeK67KOJddCYHQdl1GOAOPEuZtKyIS6NO+IQxkVlyn
	uMff9s0P4zvg9yCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=siCI9h5d;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qtfdEoZt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780062060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZs2J/OwZaUSPlUaqUDczW1jndaLqp3e7/hI6A90EJA=;
	b=siCI9h5d5uaucP0PokO+PEbXYpVBOsZd8FuEv05PASgzH5TcDycx52y5F0FyFlthYYdH4d
	Up37x4AL8FgSnuIOIXxmzSwH5ZWjeGJFtlceym3ct4Ap6YouZiIpZK07BXvlTHzRsI3Nfk
	rj+a0hSHnLGERhensGPF560cVGy9G+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780062060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jZs2J/OwZaUSPlUaqUDczW1jndaLqp3e7/hI6A90EJA=;
	b=qtfdEoZtbaGbrAEBggMYZS/t62f9jR0kkyXYk3H5xhTS0blITWxKebZGno+WUZBjI+vmjN
	o8D3z5KmPF1iBoAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7637D779A7;
	Fri, 29 May 2026 13:40:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9q0sGWqXGWqHUQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 29 May 2026 13:40:58 +0000
Date: Fri, 29 May 2026 14:40:56 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	Andrew Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	"Liam R. Howlett" <liam@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com, 
	npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com, 
	rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@pedro-suse.lan, ziy@nvidia.com, 
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v6 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
Message-ID: <ahmSolHvUChl-3vM@pedro-suse.lan>
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-3-usama.arif@linux.dev>
 <ahlh2vdHEGo6ZSot@pedro-suse.lan>
 <cc9a1cf7-7b96-439a-b0be-ecdcf27b5da5@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9a1cf7-7b96-439a-b0be-ecdcf27b5da5@linux.dev>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E29BF66E0D
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[37];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Fri, May 29, 2026 at 01:19:03PM +0100, Usama Arif wrote:
> 
> 
> On 29/05/2026 11:01, Pedro Falcato wrote:
> > On Thu, May 28, 2026 at 09:55:20AM -0700, Usama Arif wrote:
> >> The force_thp_readahead path in do_sync_mmap_readahead() is gated on
> >> HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always requests
> >> HPAGE_PMD_ORDER / HPAGE_PMD_NR. On configurations where HPAGE_PMD_ORDER
> >> exceeds MAX_PAGECACHE_ORDER, notably arm64 with a 64K base page size,
> >> VM_HUGEPAGE mappings cannot use this path and fall back to the non-forced
> >> mmap readahead path even when the mapping supports useful large folios.
> >>
> >> Keep the existing PMD-sized behavior when HPAGE_PMD_ORDER fits in the
> >> page cache. When it does not, enable forced readahead for mappings that
> >> support large folios and request an order capped by both
> >> mapping_max_folio_order(mapping) and 2MB.
> >>
> >> 2MB is chosen as the cap because it matches the PMD size on x86_64
> >> and on arm64 with 4K or 16K base pages, so the size/memory-pressure
> > 
> > 16K base page size's PMDs should be 32M, no? Am I misunderstanding what
> > you mean here?
> > 
> 
> Yes, should have just said 4K. Messed up when rewriting the commit
> message. Andrew Thanks for merging in mm-new, would it be possible
> to remove "or 16K" from the commit message. I can send a new revision
> as well if that is easier and preferred.
> 
> >> tradeoff for folios of that size is already well understood. On arm64
> >> with a 64K base page size, 2MB is also the contiguous-PTE (contpte)
> >> block size, so the resulting folios coalesce into a single TLB entry
> >> and reduce TLB pressure on the readahead path.
> >>
> >> The final allocation order may still be clamped by page_cache_ra_order()
> >> to the mapping and request geometry, but this gives VM_HUGEPAGE mappings
> >> on such configurations a large-folio readahead request instead of
> >> dropping back to base-page readahead.
> >>
> >> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >> ---
> >>  mm/filemap.c | 27 +++++++++++++++++++--------
> >>  1 file changed, 19 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/mm/filemap.c b/mm/filemap.c
> >> index a16b33e0fc71..bfb891d9da1f 100644
> >> --- a/mm/filemap.c
> >> +++ b/mm/filemap.c
> >> @@ -3312,14 +3312,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >>  	struct file *fpin = NULL;
> >>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
> >>  	bool force_thp_readahead = false;
> >> +	unsigned int thp_order = 0;
> >>  	unsigned short mmap_miss;
> >>  
> >>  	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
> >>  
> >>  	/* Use the readahead code, even if readahead is disabled */
> >> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >> -	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> >> -		force_thp_readahead = true;
> >> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> >> +		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> >> +			force_thp_readahead = true;
> >> +			thp_order = HPAGE_PMD_ORDER;
> >> +		} else if (mapping_large_folio_support(mapping)) {
> >> +			force_thp_readahead = true;
> >> +			thp_order = min_t(unsigned int,
> >> +					  mapping_max_folio_order(mapping),
> >> +					  get_order(SZ_2M));
> > 
> > This looks somewhat arbitrary to me (as does the old logic). It seems more
> > natural (correct?) to do this:
> > 
> > 	if (THP_ENABLED && (vm_flags & VM_HUGEPAGE)) {
> > 		if (mapping_large_folio_support(mapping)) {
> > 			force_thp_readahead = true;
> > 			/*
> > 			 * Cap THP readahead to either the max folio order the
> > 			 * mapping supports, or the max order the page cache
> > 			 * supports (useless to try more), or the hugepage PMD
> > 			 * order (CPU can't benefit from larger).
> > 			 */
> > 			thp_order = min3(mapping_max_folio_order(mapping),
> > 					MAX_PAGECACHE_ORDER, HPAGE_PMD_ORDER);
> > 		}
> > 	}
> > 
> 
> So this can result in extreme memory pressure. For example, on 64K base page size,
> with HPAGE_PMD_ORDER = 13 (512M) and MAX_PAGECACHE_ORDER = 11 (128M), this will evaluate
> THP order to 128M. I think Jan mentioned in previous versions that there are already
> reports of high memory pressure due to large file folios, and we are seeing this
> in our fleet as well with xfs.
> 
> I chose 2M cap as that is what most (not all) architectures which currently support this
> hugepage code flow are currently used to, and on archs + base page size combination which
> just evaluate this code to base page, for example 64K base page size, it will provide a
> performance uplift without causing excessive memory pressure.

For what it's worth, memory pressure is still a problem even on 2MB folios. But
yes, I understand.

For what it's worth, I don't think it's such a big issue in this case - you're
asking for THPs, and you're getting them - though maybe not efficiently because
these aren't at the PMD level. But this is also true for e.g x86 where an
an order-3 folio or order-7 folio are completely useless for the hardware, since
there is no mTHP to speak of (and, with that, you also lose PG_active and
PG_reference precision as you only keep one of each for each folio, amongst
other tradeoffs).

> 
> In pagemap.h, we have
> 
> #define PREFERRED_MAX_PAGECACHE_ORDER	HPAGE_PMD_ORDER
> #define MAX_PAGECACHE_ORDER	min(MAX_XAS_ORDER, PREFERRED_MAX_PAGECACHE_ORDER)
> 
> So MAX_PAGECACHE_ORDER <= HPAGE_PMD_ORDER is always true.
> 
> At filesystem/inode setup: mapping_set_folio_order_range() 
> 
> 	if (max > MAX_PAGECACHE_ORDER)
> 		max = MAX_PAGECACHE_ORDER;
> 
> so mapping_max_folio_order() <= MAX_PAGECACHE_ORDER is also always true.

Right, good point. (well, I suppose it will not be true in the future as
someone tries to harness PMD-level cont bits)

> 
> which means mapping_max_folio_order(mapping) <= MAX_PAGECACHE_ORDER <= HPAGE_PMD_ORDER is always
> true, and you dont need the min3(..) in your diff.
> 
> Now the question is if then why not just do:
> 
> 	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> 		if (mapping_large_folio_support(mapping)) {
> 			force_thp_readahead = true;
> 			thp_order = min_t(unsigned int,
> 					  mapping_max_folio_order(mapping),
> 					  get_order(SZ_2M));
> 		}
> 	}
> 
> 
> This is because this will regress the 16K ARM case where we already got 32M
> folios. Someone might upgrade the kernel and start getting 2M folios now.

So maybe limit to 32MB? It's still arbitrary but at least you get simpler
logic. If the architecture does not support 32MiB folios, it will clamp
the maximum folio order to HPAGE_PMD_ORDER, and you get the same result.

Does this sound correct?

> 
> So IMHO the current code is correct, both in maintaining what the
> existing behaviour has been, but also trying to provide large folios to
> architectures that currently dont get them but in a controlled way.
> 
> Later on, when we think or evaluate that 2M was too small a cap, it can
> be raised. I think its very easy to raise a cap, but much more difficult
> to make the cap smaller, as we might get reports on kernel upgrades that
> someone was getting a certain size of folio but now its much smaller.

I don't think this is a valid argument. You can also have reports that now
folios are too large and they're regressing workloads because of thrashing/
compaction/possibly TLB thrashing. And indeed we have several reports of that
(https://lore.kernel.org/linux-fsdevel/20260403193535.9970-1-dipiets@amazon.it/
comes to mind, plus all of the anon THP regressions over the years, including
in $current_year).

Bottom line is that changing things will always affect someone :) Particularly
since the logic we have is not too careful at deciding what should or should
not be a THP (both in anon and file cases). And if (once?) we make it smarter,
it will surely also regress someone!

-- 
Pedro
