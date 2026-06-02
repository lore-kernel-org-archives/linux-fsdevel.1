Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A870F3FBB55
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 17:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422401; cv=none; b=lkwWJTiNwsef1/4tppaRC5vQsI8Tl8uZfUo9EK5F/Vu/YmLqMUdtSwYDUCk+S6pz+k0OV+wkTrpn/n1/bNuez5wL4iSbs7i5ZbZdEqPL2PeyGcDCfXvuhm4sqw3ug9OKt7eEXbA6SRvXhG4v+ObZAuHqMBtP8HZty7gbZeCJmQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422401; c=relaxed/simple;
	bh=nsIo23kIDaPQTBkiNSSfaFwDqkulj//hrjom7Q9sNWI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz40pKIHSDG1yfZu5nMv6cGQrw6xb6g37YxFoBnyH9QQr66sUBRGFub9hpvYKfjesuH7EkrTCgZAbOJwaPcb/mAvYSvoniIRIl+ce/neOJ0F203FbqB0JKcMUGO9x3w7ifhFoi6yn8wk4vI5d70soRmE6/sHr0kETU+MbWZ2IRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nK22Too0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BzM/vvSp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=k1DfIejH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ilnX90mN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nK22Too0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BzM/vvSp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k1DfIejH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ilnX90mN"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EC1C66B23F;
	Tue,  2 Jun 2026 17:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780422398; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuMw0XP6ELPe+cm6ErdVU/bLeUkouF/KNF0MaMkAslk=;
	b=nK22Too0AOrBD1x0yqMvCNHtXGpYGbXIQIh+9JuUbolbu13rClZ7cEQwCVBEpCxAkz2+lR
	k4xJpxwuKski9CsGzogPozU0Fisoo8I7swxmWrj/TH9ywRAzy1VqTzhEkbivRWptnob7Qd
	50Bew2HN5IOFfjFmh+m2e2yGhmOFj3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780422398;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuMw0XP6ELPe+cm6ErdVU/bLeUkouF/KNF0MaMkAslk=;
	b=BzM/vvSp8Wf+nGps5rztT0j5NRDpOX38AkDy6Sp3Zw5XOy1fO3Q84wm7WW2uhp9lEYqFKJ
	SLqNDJisMJ7wdJAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780422397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuMw0XP6ELPe+cm6ErdVU/bLeUkouF/KNF0MaMkAslk=;
	b=k1DfIejHfWIM44A9nh6+tWNpezMinj8qDvSYvYf5YznRvrhQowYoRTECcUp5tJEJJnbdwl
	J/Q1ECVuYdqwqEzdI7HfuOmr12HLti8Qq3Y+q3QNck8POi3mmK1sWBVM04B12afvzmrppV
	7NEuoUfOeSnKqbL4oXabunIqOFzlksM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780422397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuMw0XP6ELPe+cm6ErdVU/bLeUkouF/KNF0MaMkAslk=;
	b=ilnX90mNyOgzvxbmB+RGPk4idEuuUy+9VUNbLgKyXZ6tuGm0J27Xbi0tNjRfS6TVhIVsdK
	N2jYntLd7bomCuCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3AFC779A7;
	Tue,  2 Jun 2026 17:46:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /eemI/sWH2oCNAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 02 Jun 2026 17:46:35 +0000
Date: Tue, 2 Jun 2026 18:46:33 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Usama Arif <usama.arif@linux.dev>
Cc: willy@infradead.org, jack@suse.cz, 
	Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org, 
	r@hev.cc, Andrew Donnellan <andrew+kernel@donnellan.id.au>, 
	apopple@nvidia.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, kees@kernel.org, 
	kevin.brodsky@arm.com, lance.yang@linux.dev, "Liam R. Howlett" <liam@infradead.org>, 
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ljs@kernel.org, mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@pedro-suse.lan, ziy@nvidia.com, 
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v6 2/2] mm: use mapping_max_folio_order() for
 force_thp_readahead order
Message-ID: <ah8UmnLyUOKflNz3@pedro-suse>
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-3-usama.arif@linux.dev>
 <ahlh2vdHEGo6ZSot@pedro-suse.lan>
 <cc9a1cf7-7b96-439a-b0be-ecdcf27b5da5@linux.dev>
 <ahmSolHvUChl-3vM@pedro-suse.lan>
 <185f1caf-b33d-4467-beb5-51bd8520ac78@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <185f1caf-b33d-4467-beb5-51bd8520ac78@linux.dev>
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
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLxu57a9hfgn7tttf5jiwuqe5o)];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.dev:email]
X-Spam-Level: 

On Fri, May 29, 2026 at 03:11:54PM +0100, Usama Arif wrote:
> 
> 
> On 29/05/2026 14:40, Pedro Falcato wrote:
> > On Fri, May 29, 2026 at 01:19:03PM +0100, Usama Arif wrote:
> >>
> >>
> >> On 29/05/2026 11:01, Pedro Falcato wrote:
> >>> On Thu, May 28, 2026 at 09:55:20AM -0700, Usama Arif wrote:
> >>>> The force_thp_readahead path in do_sync_mmap_readahead() is gated on
> >>>> HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER and always requests
> >>>> HPAGE_PMD_ORDER / HPAGE_PMD_NR. On configurations where HPAGE_PMD_ORDER
> >>>> exceeds MAX_PAGECACHE_ORDER, notably arm64 with a 64K base page size,
> >>>> VM_HUGEPAGE mappings cannot use this path and fall back to the non-forced
> >>>> mmap readahead path even when the mapping supports useful large folios.
> >>>>
> >>>> Keep the existing PMD-sized behavior when HPAGE_PMD_ORDER fits in the
> >>>> page cache. When it does not, enable forced readahead for mappings that
> >>>> support large folios and request an order capped by both
> >>>> mapping_max_folio_order(mapping) and 2MB.
> >>>>
> >>>> 2MB is chosen as the cap because it matches the PMD size on x86_64
> >>>> and on arm64 with 4K or 16K base pages, so the size/memory-pressure
> >>>
> >>> 16K base page size's PMDs should be 32M, no? Am I misunderstanding what
> >>> you mean here?
> >>>
> >>
> >> Yes, should have just said 4K. Messed up when rewriting the commit
> >> message. Andrew Thanks for merging in mm-new, would it be possible
> >> to remove "or 16K" from the commit message. I can send a new revision
> >> as well if that is easier and preferred.
> >>
> >>>> tradeoff for folios of that size is already well understood. On arm64
> >>>> with a 64K base page size, 2MB is also the contiguous-PTE (contpte)
> >>>> block size, so the resulting folios coalesce into a single TLB entry
> >>>> and reduce TLB pressure on the readahead path.
> >>>>
> >>>> The final allocation order may still be clamped by page_cache_ra_order()
> >>>> to the mapping and request geometry, but this gives VM_HUGEPAGE mappings
> >>>> on such configurations a large-folio readahead request instead of
> >>>> dropping back to base-page readahead.
> >>>>
> >>>> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> >>>> ---
> >>>>  mm/filemap.c | 27 +++++++++++++++++++--------
> >>>>  1 file changed, 19 insertions(+), 8 deletions(-)
> >>>>
> >>>> diff --git a/mm/filemap.c b/mm/filemap.c
> >>>> index a16b33e0fc71..bfb891d9da1f 100644
> >>>> --- a/mm/filemap.c
> >>>> +++ b/mm/filemap.c
> >>>> @@ -3312,14 +3312,23 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
> >>>>  	struct file *fpin = NULL;
> >>>>  	vm_flags_t vm_flags = vmf->vma->vm_flags;
> >>>>  	bool force_thp_readahead = false;
> >>>> +	unsigned int thp_order = 0;
> >>>>  	unsigned short mmap_miss;
> >>>>  
> >>>>  	ractl._max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
> >>>>  
> >>>>  	/* Use the readahead code, even if readahead is disabled */
> >>>> -	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
> >>>> -	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> >>>> -		force_thp_readahead = true;
> >>>> +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) && (vm_flags & VM_HUGEPAGE)) {
> >>>> +		if (HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER) {
> >>>> +			force_thp_readahead = true;
> >>>> +			thp_order = HPAGE_PMD_ORDER;
> >>>> +		} else if (mapping_large_folio_support(mapping)) {
> >>>> +			force_thp_readahead = true;
> >>>> +			thp_order = min_t(unsigned int,
> >>>> +					  mapping_max_folio_order(mapping),
> >>>> +					  get_order(SZ_2M));
> >>>
> >>> This looks somewhat arbitrary to me (as does the old logic). It seems more
> >>> natural (correct?) to do this:
> >>>
> >>> 	if (THP_ENABLED && (vm_flags & VM_HUGEPAGE)) {
> >>> 		if (mapping_large_folio_support(mapping)) {
> >>> 			force_thp_readahead = true;
> >>> 			/*
> >>> 			 * Cap THP readahead to either the max folio order the
> >>> 			 * mapping supports, or the max order the page cache
> >>> 			 * supports (useless to try more), or the hugepage PMD
> >>> 			 * order (CPU can't benefit from larger).
> >>> 			 */
> >>> 			thp_order = min3(mapping_max_folio_order(mapping),
> >>> 					MAX_PAGECACHE_ORDER, HPAGE_PMD_ORDER);
> >>> 		}
> >>> 	}
> >>>
> >>
> >> So this can result in extreme memory pressure. For example, on 64K base page size,
> >> with HPAGE_PMD_ORDER = 13 (512M) and MAX_PAGECACHE_ORDER = 11 (128M), this will evaluate
> >> THP order to 128M. I think Jan mentioned in previous versions that there are already
> >> reports of high memory pressure due to large file folios, and we are seeing this
> >> in our fleet as well with xfs.
> >>
> >> I chose 2M cap as that is what most (not all) architectures which currently support this
> >> hugepage code flow are currently used to, and on archs + base page size combination which
> >> just evaluate this code to base page, for example 64K base page size, it will provide a
> >> performance uplift without causing excessive memory pressure.
> > 
> > For what it's worth, memory pressure is still a problem even on 2MB folios. But
> > yes, I understand.
> > 
> > For what it's worth, I don't think it's such a big issue in this case - you're
> > asking for THPs, and you're getting them - though maybe not efficiently because
> > these aren't at the PMD level. But this is also true for e.g x86 where an
> > an order-3 folio or order-7 folio are completely useless for the hardware, since
> > there is no mTHP to speak of (and, with that, you also lose PG_active and
> > PG_reference precision as you only keep one of each for each folio, amongst
> > other tradeoffs).
> > 
> 
> So there is hardware TLB coalescing on almost every new AMD CPU, I believe it is
> at 32kB, and we would benefit from that. On top of that, we would reduce pagefaults.

(just addressing this, because everything else was addressed in some other ways
and I'm just going through my email backlog; my apologies for the delay)

AMD's TLB coalescing feature requires (as far as I know) A and D bits to match
for every PTE in the cluster. Which means you need to effectively touch every
page in that 32KB cluster (that was then later reduced to 16KB in zen3 if I'm
not mistaken). And as soon as you write to one of them, the D bit gets set and
the TLB entry needs to be torn down. So it's usefulness is unfortunately
limited.

But yes, we do reduce page faults. Though I have to wonder how much that matters
in a world where we have fault-around.

-- 
Pedro
