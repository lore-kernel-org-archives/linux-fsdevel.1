Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189C0309EE6
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899275; cv=none; b=fnd6Li1AZAvC2QmSukqRYe33P8bfPrXnx7yBlvgq9DWJzhjArHZkz3iZFhZYPPyLoueapwAiNtYPUlDaTzi5Hrjqspgq7LQFKnFgPHqM52pEibZ1P1R7mz4uoXDywBRbZ4KaIKzVH5m+zFehRf8zbfmAhWIddLNf+pFBzBZpqEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899275; c=relaxed/simple;
	bh=jUJ+mh0vQ9xBHqEDnGm7zKCicOi2z5BRCVD9+cgDOls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8fYhadJN+eF/2aDgwy/rgGImXD6BSBq4TVKdMIE3ultnXwq75+tAkxqSc270BfN1ag07xCPk9fic2DiOUb4H6lx5kfD5A5IF0evIpWD+AYYVRkBMLQONCIVSmNJMXwHJ59HYnM+YKzzKeVzXUBAajC39nVcPhCRNxm18011jtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Lr0qAArm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Lr0qAArm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=B1sCc/4/2+c9lGryyMIrT+t7xrQYTOS4UkDA1UHfcbk=; b=Lr0qAArm/6fzGDvHy+WFibQPFT
	H4P7PEcDF7n5ILR+emVLh4kAJdiZiQ4FCxf/S4iCdZz79LfMHlcEevk3lQkvCyzMDMs70FXx+HBQ6
	qlOnAagDuOqQDAj1HD5cCLfucV8qN6GsZm1l6Pq1DQ3S57AmsdlZIa1q2wAUgkHXjJkIDFGHLZSzY
	q8H9FAD8XXcEBUvFHuX4jL2v4MWT1pB3c/mKzZAficbtwGTfXzxqynN6EqL9koZGpbc2Km7b8t7s9
	QZj/tI8UgrygUuej7T17juSh7ycCf13QflR2CELqhChJAe292dAACVmcbLTzHBIHpeHGGRjQ/cxXb
	e1X/mf7w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFpm-00000003XfT-3Efs;
	Fri, 24 Jul 2026 13:21:02 +0000
Date: Fri, 24 Jul 2026 14:21:02 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v4 07/14] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amNmvtOLZxEwF-cg@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-8-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-8-willy@infradead.org>

Sashiko review:
> --- Patch [7]: [PATCH v4 07/14] hugetlb: Use the has_hwpoisoned flag ---
> commit f67cbd0b3ba7a67258490d423b9fc8352cb972aa
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> hugetlb: Use the has_hwpoisoned flag
> 
> Other large folios use the has_hwpoisoned flag.  Convert hugetlb to match.
> This will help us use the per-page hwpoison flag in the future.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 18691c905ac94..4200deab2c3c4 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> 
> [ ... ]
> 
> > @@ -1874,6 +1874,23 @@ static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> >  #define	MF_HUGETLB_FOLIO_PRE_POISONED	3	/* folio already poisoned */
> >  #define	MF_HUGETLB_PAGE_PRE_POISONED	4	/* exact page already poisoned */
> >  #define	MF_HUGETLB_RETRY		5	/* hugepage is busy, retry */
> > +
> > +static inline int hugetlb_set_poison(struct folio *folio)
> > +{
> > +	if (folio_test_set_has_hwpoisoned(folio))
> > +		return MF_HUGETLB_FOLIO_PRE_POISONED;
> > +	folio_set_huge_poison(folio);
> > +	return 0;
> > +}
> 
> By replacing folio_test_set_hwpoison(folio) and no longer propagating 
> PG_hwpoison to the head page, does this break memory failure unmapping and 
> silently bypass hwpoison swap entry creation?
> 
> If a hardware memory error occurs on a tail page of a hugetlb folio, 
> memory_failure() calls TestSetPageHWPoison(p) on the exact tail page. It then 
> calls hugetlb_set_poison(), which sets PG_has_hwpoisoned but no longer sets 
> PG_hwpoison on the head page.
> 
> When unmapping the folio in try_to_unmap_one() in mm/rmap.c, the code 
> extracts the base PFN from the hugetlb PTE, calculates subpage as the head 
> page, and checks PageHWPoison(subpage):
> 
> mm/rmap.c:try_to_unmap_one() {
>     ...
>     VM_BUG_ON_PAGE(!PageHWPoison(subpage), subpage);
>     ...
>     if (PageHWPoison(subpage) && (flags & TTU_HWPOISON)) {
>         pteval = swp_entry_to_pte(make_hwpoison_entry(subpage));
>     ...
> }
> 
> Since PG_hwpoison is no longer on the head page, this check fails, triggering 
> VM_BUG_ON_PAGE. Without DEBUG_VM, the code skips inserting the hwpoison swap 
> entry, simply clearing the PTE, which silently allocates a new zeroed page on 
> subsequent accesses instead of delivering SIGBUS.

Oh; this is a good catch.  I have now reworked try_to_unmap() to handle
hugetlb pages a bit better and it'll be part of this patch in v5.

> > +
> > +static inline int hugetlb_clear_poison(struct folio *folio)
> > +{
> > +	if (!folio_test_clear_has_hwpoisoned(folio))
> > +		return -EBUSY;
> > +	folio_clear_huge_poison(folio);
> > +	return 0;
> > +}
> 
> Does this sequence open a race window with concurrent hugetlb freeing that 
> results in memory corruption?
> 
> When unpoison_memory() is called on a free hugetlb folio, 
> hugetlb_clear_poison() atomically clears PG_has_hwpoisoned first. This 
> exposes the folio to concurrent hugetlb demotion (demote_pool_huge_page()), 
> which can pick up the folio and call __update_and_free_hugetlb_folio(). This 
> function sets folio->page.page_type = UINT_MAX to return it to the buddy 
> allocator.
> 
> Concurrently, hugetlb_clear_poison() proceeds to execute 
> folio_clear_huge_poison() (defined in include/linux/page-flags.h), which 
> performs a non-atomic read-modify-write:
> 
> include/linux/page-flags.h:folio_clear_huge_poison() {
>     folio->page.page_type &= ~(1 << 23);
> }
> 
> This non-atomic write can overwrite the buddy allocator's UINT_MAX with 
> 0xFF7FFFFF. When the buddy allocator receives the page, it expects 
> page_type == UINT_MAX and will crash.

I'm not sure that it can be demoted while we're holding a reference to
the folio.  But I think it makes sense to change thusly:

+static inline int hugetlb_clear_poison(struct folio *folio)
+{
+	if (!folio_test_has_hwpoisoned(folio))
+		return -EBUSY;
+	folio_clear_huge_poison(folio);
+	folio_clear_has_hwpoisoned(folio));
+	return 0;
+}

(looking at Jiaqi's patches, maybe we shouldn't be clearing has_hwpoisoned
before freeing the folio?)
