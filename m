Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D763655C5
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Aug 2026 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878544; cv=none; b=HJkhQNZj/j8ugCd1AwS4rvY5SC0Y/GLaTblOYFPPbcTPT+cKD8SL9NB/oxpiNojcZQPIhR3u7dv2JXPC9sIWVUW/bnw4L5NzG7WZOO3fcnrJsI+inpNRq80r3nGSh4KeUxs+1njllj91H7EqVJqZKHC5snc6+7RiyYGOcPrQ3vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878544; c=relaxed/simple;
	bh=t7zNNv6AeDGumbehI8iJHWTrVV/7TSldTXAjlr2R0jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvpIHFmo7KxwaK/3IDIOTcVEl+p4e92eTn+mbivPXw4x8wqO6i92PsspGB4ncuMy/ryNIgHu0sErxlITcfTC6ul0HIrvzWz+VKLhI5aAZ/dUTqtUGW0Y5mZQ/AKCHZGQqpWcP/fsPhq0qPb0kApK8ELnTcSeZt8lI0ioWHoHmEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=L4DABoEF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L4DABoEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qs1s8L5LRmXTdCMqmij4CMcIl3PXcjczNV0suhyRfvY=; b=L4DABoEFIYp/1VRcJI3ynzeSTY
	ZBzpvXIDfmOkjlGTMXO9laKtVOr2MjBIxQz9m1EpPPGNQz81nmnCmYnrM0/gWqd64zj+JYeL3C5ec
	BsVVMBmcd0AThvU3YSsQUO4jrGPJ4hQn8xfWugSHaCVi4k8W3YCpoPyK16JkTGHrCCCyZloBIlehQ
	pMo6ANdAYk8TJG8hRs/LAjiia8Y1t6YkuSKs+XE2iEkMq9xP7S8M4W/w9ZQQh/eOsgqayTsSBDr6V
	tnf42RIM0J7ua1WffOiiMA9S0OtV3mP9kfonVuSRCUuUtUs86r/gYR27p2XPDSzr1PYczDGa1K3oF
	NBuphS8A==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wrMZl-00000004myG-3AFG;
	Tue, 04 Aug 2026 21:21:37 +0000
Date: Tue, 4 Aug 2026 22:21:29 +0100
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
Subject: Re: [PATCH v8 10/15] mm: Check individual hugetlb pages for poison
Message-ID: <anJX2bjH57IHz-jX@casper.infradead.org>
References: <20260731200802.574821-1-willy@infradead.org>
 <20260731200802.574821-11-willy@infradead.org>
 <anI5bPVScck1WXvh@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anI5bPVScck1WXvh@gourry-fedora-PF4VCD3F>

On Tue, Aug 04, 2026 at 03:15:37PM -0400, Gregory Price wrote:
> On Fri, Jul 31, 2026 at 09:07:55PM +0100, Matthew Wilcox (Oracle) wrote:
> > +/*
> > + * We have no reference on the folio containing this page.
> > + * The hugetlb_lock keeps hugetlb folios from being freed.
> > + */
> > +bool hugetlb_unref_page_hwpoison(const struct page *page)
> > +{
> > +	const struct folio *folio;
> > +	unsigned long flags;
> > +	bool ret;
> > +
> > +	spin_lock_irqsave(&hugetlb_lock, flags);
> > +	folio = page_folio(page);
> > +	if (!folio_test_huge_poison(folio)) {
> > +		ret = PageHWPoison(page);
> > +		goto unlock;
> > +	}
> > +
> > +	ret = precise_page_poisoned(folio, page);
> > +unlock:
> > +	spin_unlock_irqrestore(&hugetlb_lock, flags);
> > +	return ret;
> > +}
> > +
> 
> I ended up with the same question as sashiko - i think this behavior
> implies we must hold a reference on the page, otherwise the folio can
> be invalid and all these accesses are unsafe.
> 
> But that must be the existing behavior for poison checks like this, so
> this is at least no worse. Not sure it's worth addressing.

Let me just paste Sashiko's comment in here so we preserve it in the
lore archives and so we're definitely talking about the same thing:

> This is a pre-existing issue, but does calling page_folio()
> here without holding a reference to the page risk a panic during
> lockless PFN scanning?  If a monitoring tool reads /proc/kpageflags or
> /proc/kcore, pfn_to_online_page() retrieves the page without acquiring
> a reference. If the page is concurrently freed and reallocated for
> driver use, compound_info (which aliases lru.next) could be modified.
> Could this cause page_folio() to misidentify the page as a tail page
> and return an invalid folio pointer, leading to an out-of-bounds memory
> read when folio_test_huge_poison() accesses folio->page.page_type?
> While the hugetlb_lock is held here, can it stabilize unreferenced
> pages that might have already been repurposed into non-hugetlb pages?

Sashiko is mistaken (... and fair enough, I suspect you aren't the only
human who's confused by this either)

It's quite right that we can observe a page in literally any state since
we do not hold a refcount.  But it is forbidden to use bit 0 of lru.next
for any purpose other than indicating "this is a tail page":

       /*
         * Five words (20/40 bytes) are available in this union.
         * WARNING: bit 0 of the first word is used for PageTail(). That
         * means the other users of this union MUST NOT use the bit to
         * avoid collision and false-positive PageTail().
         */

That's been the rule since 2015 with commit 1d798ca3f164

So the pointer we get back from page_folio() must have been a folio _at
some point_.  It may not be a folio now.  It may be a folio, but not one
that contains this page.  But it's not a wild pointer, and treating it
as if it's a folio won't cause any harm (as long as we're really careful).

Specifically, we call:

> +	if (!folio_test_huge_poison(folio)) {

and all that does is access folio->page.page_type aka mapcount.  So if
the pointer we have is not a current folio, it'll just return false and
we'll check PageHWPoison.

So the only case this can return 'true' is if the folio was hugetlb
at that exact point.  And we've got the hugetlb lock, so it can't stop
being a hugetlb folio.  At this point it's safe to walk the list.

That's my reasoning, and I think Sashiko has explained enough of its
reasoning to be fairly sure Sashiko is wrong about this.  But hey,
you're not Sashiko.  Maybe you've found a gap in my logic.
