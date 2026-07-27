Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606130EF91
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163902; cv=none; b=ZLA0yksPotrvn/zGPjEcRx8bsnUd0pFq0NsPGToMj9gAhc8MV/4JWhmtmoGLB8+fJ1yEsLPaGkvOrA3SRqps0hBxzM93foUqEznzsIFDuNoMtrOiz2229aHyX2y6cDIj8LwPmqD1oBSyyC9JsheXbhdYy9MWD2nzWwsHglEP9l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163902; c=relaxed/simple;
	bh=WzSrZppPS8AlP4yV/ZPF3i7nsO46ElCelSrv+Z5E3os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WchRcfPodQzUYARozbD/IS8fGVmRYRgqGbdYwkgcR41hpF1TaHqidV3Azl8c3rZH6qB3LHoI7zQ10B+QPjFqP7ABMk4L5pX4mtWy30gNEIrRSKt9Bqi8Hg63hE8r0ijBh2wlRql1sCE8wUaVPaciHHTRIdz+VoomyD4A/OjMEak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IO+ysveH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IO+ysveH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4WLvl4z1mlw8PwVBwzpQShS1aPPG3mcmlz4u5T49hbc=; b=IO+ysveHHPCt6r2bfF/uIbJzR4
	q284PPc1oCSzaF6wGlB8zMPLHVOev/kWX2bfBNwbdhd6psXmmFt57GpC+TO/i71cpDYV7AzuuG3MH
	V39thLJeRr/1QXsbPjKYqpuIOfVKEUHim0sa6jxcvS334jl81aBHNYKX8CiYPkK+/HdpmcbgAa++z
	9vE0Skj+pc2I69I3+COHn55QWpOrr5+N7NhDi7qJgONqAq+K2Bz2Lbaatg1DRbhMra/KYJEWwxurS
	1Hcm7dlh3G2vwump+sPvQnbh5PIKnrMHDU1Fiy4dxfNYcARgSvR8l5HaqLFsxINRtY2Yoyb3+gzHD
	oCFAFOFg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woMfy-0000000AtAg-0kmD;
	Mon, 27 Jul 2026 14:51:30 +0000
Date: Mon, 27 Jul 2026 15:51:29 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v5 02/12] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
Message-ID: <amdwca1VRNPjEl8j@casper.infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
 <20260725160042.1557264-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725160042.1557264-3-willy@infradead.org>

Sashiko review:
> --- Patch [2]: [PATCH v5 02/12] mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page() ---
> commit 8fadf59bc3118e11dab2620f6cc376507c16b29a
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
> 
> This is a better name for this predicate.  Also make the argument const
> to allow other callers to be made const.  No functional change.
> 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 7223f6f4e2b40..4185a03a45cf7 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -1083,10 +1083,10 @@ static inline bool is_page_hwpoison(const struct page *page)
> >  	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
> >  }
> >  
> > -static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
> > +static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
> >  {
> >  	return folio_test_hwpoison(folio) ||
> > -	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> > +	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> >  }
> 
> This isn't a bug introduced by this patch, but can KSM trigger a machine check
> exception when scanning memory?

Good lord.  I renamed a function.  Which apparently causes Sashiko to
look for bugs in every caller

> Looking at cmp_and_merge_page() in mm/ksm.c, the KSM scanner initiates page
> hash calculation:
> 
> mm/ksm.c:cmp_and_merge_page() {
>     ...
>     checksum = calc_checksum(page);
>     ...
> }
> 
> which then maps and reads the page content:
> 
> mm/ksm.c:calc_checksum() {
>     ...
>     void *addr = kmap_local_page(page);
>     checksum = xxhash(addr, PAGE_SIZE, 0);
>     ...
> }
> 
> If a page becomes hardware-poisoned before KSM scans it, shouldn't there be a
> PageHWPoison(page) or folio_has_hwpoisoned_page(folio) check before the read
> to prevent a fatal MCE?
> 
> 
> This is a pre-existing issue, but does migration risk panicking on poisoned
> memory?

Yes, lots of things risk panicking on poisoned memory.  It's never been
a priority for Linux.

> During page migration, pages are passed to __migrate_folio() which copies the
> contents without validation:
> 
> mm/migrate.c:__migrate_folio() {
>     ...
>     rc = folio_mc_copy(dst, src);
>     if (unlikely(rc))
>         return rc;
>     ...
> }
> 
> This executes the page copy in folio_mc_copy():
> 
> mm/util.c:folio_mc_copy() {
>     ...
>     if (copy_mc_highpage(folio_page(dst, i), folio_page(src, i)))
>         return -EHWPOISON;
>     ...
> }
> 
> On architectures lacking copy_mc support, this falls back to copy_highpage().
> Without a prior folio_has_hwpoisoned_page(src) check, could migrating a
> poisoned page via mbind() or move_pages() read poisoned memory and trigger a
> kernel panic?
> 
> 
> This is a pre-existing issue, but does kill_accessing_process() return the
> wrong error code when a task lacks an mm?
> 
> In memory failure handling, if the task is exiting or is a kernel thread,
> p->mm is NULL:
> 
> mm/memory-failure.c:kill_accessing_process() {
>     ...
>     if (!p->mm)
>         return -EFAULT;
>     ...
> }
> 
> Since the memory_failure() API protocol requires returning 0 for a successfully
> recovered state (no user signal needed), does returning -EFAULT cause the
> architecture MCE handler, such as kill_me_maybe(), to erroneously conclude
> recovery failed? Could this trigger unnecessary warnings and incorrectly
> attempt to force a SIGBUS on the dying task?

Dunno, and I'm done with side-quests.  Somebody else can decide if this
is a real problem that needs to be fixed.
