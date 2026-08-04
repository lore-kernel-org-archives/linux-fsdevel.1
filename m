Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890DC47A88B
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 16:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785861782; cv=none; b=UtqiND9TTAAeQn8ksvqwj6/mv4H46eqYLV5wMbYNQ6eTqKY7ajuwD/ROopl65UWhznVs6qVSnN5Y8CT66ESWa9I1inf5/h0Km1Qoa3Si1bnBVitcGQt3FpPoF9zSfFakRNg060s89u4509k2PDbaPPoscmZuovRIt8vnH9bdRG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785861782; c=relaxed/simple;
	bh=KQB+LPwkZnWAGzEAxjVpHjUAfDkQimgMWXQGrPiB6o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0nkxMnrZ4NxurnNIh1VbqUjRQBcRziJRx8C7Cr8VOJNCJ66AWu7o3SZjeSj1VQV1BADCv8w5DVt3g7apWJ0QZDDZyJ8euf3pBRN+Q8v8r7Ff1RePW3r/i+8XDBA+HijZtTz9/k7jw5iElRAuGCqQ5zzkuJ45dwa4K0vA7pv4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=MjXC96u9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MjXC96u9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7FgAlcxiaqBdg50AghxKto22Y8/6j7/dUrK1xbeiU0Y=; b=MjXC96u9Vz+lNdgr6Hsuj0Wjt6
	xamRGnnicLl9RltHZ1rSauQbn5Gs2RCUzfU7fm/u2aRSSrxkM1PUL5ontnCkbc7A6gs3baRDVaDJs
	jmloGB7oiEZ/tlqtMHKHl2xb1JpUbZfFfSrJvxo10gt4FqOgjJExsf6Fi/vut7IXbrAfz/DRqsXcM
	9+27RbJ8ZUNpIvMqFVPIHHeV72He0Q+uGPquhlKcuLZRRdZa702F6uGf8unm7AZT6JD3a6xwVEWck
	tJ41FCkQcTzUv6rY+VeACn4mPeRCyRMBBQcqZ4WP2xJyjC4toXdg5X9qc2L40a6vZqIRGMa7dV9sx
	XcN5HCaA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrIDk-00000004IOi-34Nw;
	Tue, 04 Aug 2026 16:42:28 +0000
Date: Tue, 4 Aug 2026 17:42:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Gregory Price <gourry@gourry.net>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v8 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <anIWdALS_1pmGA-t@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-9-willy@infradead.org>
 <anISVv340bo1l9as@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anISVv340bo1l9as@gourry-fedora-PF4VCD3F>

On Tue, Aug 04, 2026 at 12:28:06PM -0400, Gregory Price wrote:
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks, will add.

> > -#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_TRANSPARENT_HUGEPAGE)
> > +#if defined(CONFIG_MEMORY_FAILURE) && defined(CONFIG_LARGE_FOLIO)
> >  /*
> > - * PageHasHWPoisoned indicates that at least one subpage is hwpoisoned in the
> > - * compound page.
> > + * folio_has_hwpoisoned indicates that at least one page is hwpoisoned in the
> > + * folio.  That page will usually also have the HWPoison flag set, but this
> > + * is not possible for folios which have HVO (see memory-failure for the
> > + * scheme used in that case).  You probably don't want to call this directly;
> > + * use folio_has_hwpoisoned_page() instead.
> >   *
> >   * This flag is set by hwpoison handler.  Cleared by THP split or free page.
> >   */
> 
> Had to google HVO, and didn't see HVO directly mentioned in
> memory-failure.  Maybe worth expanding HVO to its actual definition and
> a sentence on the quirk.

It is mentioned earlier in the same file:

include/linux/page-flags.h:      * Limit mask usage to HugeTLB vmemmap optimization (HVO) where it

but that's not obvious when reading a patch.  I'll just expand it here:

 * The has_hwpoisoned flag indicates that at least one page is hwpoisoned
 * in the folio.  That page will usually also have the HWPoison flag
 * set, but this is not possible for folios which have HugeTLB vmemmap
 * optimization (see hugetlb_update_hwpoison() for the scheme used
 * in that case).  You probably don't want to call this directly; use
 * folio_has_hwpoisoned_page() instead.

> Does "Hugepage Vmapmem Optimization" just report poison for the head and
> we lose the sub-page poison information in general?

We only lose the sub-folio poison information if kmalloc fails in
hugetlb_update_hwpoison().  In the happy case, we retain knowledge
of which pages contain hwpoison (and later in this series, we actually
expose that information instead of just pretending the whole folio is
poisoned)
