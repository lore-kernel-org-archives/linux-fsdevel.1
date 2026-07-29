Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC3338D006
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Jul 2026 02:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785293726; cv=none; b=m3Ws8sw+tewjDtm4TTsHs+jny4ztkMirTjVKjFNLbW8B1SYvA0ZRo+hWSZqz7+KX8NtkQ/Kt2a2l4gojnJbQouhJ8e6aibmNv+zWaAijh1lPo1URyd0uezd/sDfsXubJ2fain45/lPCiTEA6ehfT+s3c/RrMF/xZMHLKYdVP3Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785293726; c=relaxed/simple;
	bh=ORyHdUKzHlFoAmJBWF5TGup2d5ltZXSNhaSKqkX2Ovg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjN/RJloxmCf0tqJuEr6S6UV5t6Dk2y6LmGFS/CmBV9VJFjYU4LM1MhsqINDlI9o2fqRMaUJsN6wIbqiEQOyQAQiF/b2NsJZfAyqfSVC0VuuO9A0bgyZfBfle2OxKLM3K2ullcXVKGqDZXRg3XdVn0tXqK6MYLIPzAaIS8Z7NVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IW6AfO+Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IW6AfO+Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=4Gu5Num2xknD+iSWUiEOP3hmmUxH8WHbfsyozOqoPB4=; b=IW6AfO+Ql8jIDXXzqJcDalbSw8
	KUcVJJ9nMB7BI93VpUXYAFGY3yjwmLmUKnX831IfMXwYgrny9DSgtEjzg1y4use9FqnyejzsaqVRq
	2k0MYuzWXI9gWADvQklRwrbBRTsfH2f/6O8iBspMmT4KgYY4W/qS1z92UlHMUYCgCRJZxEnk4inMj
	I2IIkhzQBxKzw00yL10G0TL0Qyh7jxYVpg7eI8lDiwUIOd8qV3Ke5hzRwwqHhHisjh0CvXsI+TfqH
	SHQc9sf/lk9qUMdfAtfYsv2QAt4NnRx+WFgSQFNBSrBBTMcJU3O9YECmM2SDfChoGOPZQxnHNWZ8Z
	2FyUvXAQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wouRq-0000000F0aA-1Ytc;
	Wed, 29 Jul 2026 02:55:10 +0000
Date: Wed, 29 Jul 2026 03:55:10 +0100
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
Subject: Re: [PATCH v7 06/13] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amlrjtaFSEQLYbEO@casper.infradead.org>
References: <20260728204409.3396238-1-willy@infradead.org>
 <20260728204409.3396238-7-willy@infradead.org>
 <amlQYkGgLmxmwX9_@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amlQYkGgLmxmwX9_@gourry-fedora-PF4VCD3F>

On Tue, Jul 28, 2026 at 09:36:37PM -0400, Gregory Price wrote:
> On Tue, Jul 28, 2026 at 09:43:58PM +0100, Matthew Wilcox (Oracle) wrote:
> > +
> > +#ifdef CONFIG_MEMORY_FAILURE
> > +static inline bool folio_test_huge_poison(const struct folio *folio)
> > +{
> > +	return (READ_ONCE(folio->page.page_type) >> 23) ==
> > +		((PGTY_hugetlb << 1) | 1);
> > +}
> > +
> > +static inline void folio_set_huge_poison(struct folio *folio)
> > +{
> > +	folio->page.page_type |= (1 << 23);
> > +}
> > +
> > +static inline void folio_clear_huge_poison(struct folio *folio)
> > +{
> > +	folio->page.page_type &= ~(1 << 23);
> > +}
> > +#else
> 
> Took me a second to realize why this was open-coded instead of using
> the generator macros.  The reasoning is buried in this comment:

I believe hugetlb is the first user of the low 24 bits of page_type.
As such, there aren't any generator macros yet ... and I'd probably want
there to be at least three before creating any.

> /*
>  * Check if a page is currently marked HWPoisoned.  This check is best
>  * effort only and inherently racy: there is no way to synchronize with
>  * failing hardware.  The caller may not have a refcount on the folio
>  * containing the page, so we must be careful to not trip any assertions.
>  */
>  static inline bool is_page_hwpoison(const struct page *page)
>  ...
> 
> which i presume is referring to VM_BUG_ON_FOLIO() in the set/clear in
> the macros.  Might be worth just note here if only so no one comes along
> and "fixes" this or writes more of these without the same reasoning.

It's even in the test ...

FOLIO_FLAG(has_hwpoisoned, FOLIO_SECOND_PAGE)
#define FOLIO_SECOND_PAGE       1
#define FOLIO_FLAG(name, page)                                          \
FOLIO_TEST_FLAG(name, page)                                             \
#define FOLIO_TEST_FLAG(name, page)                                     \
static __always_inline bool folio_test_##name(const struct folio *folio) \
{ return test_bit(PG_##name, const_folio_flags(folio, page)); }

static const unsigned long *const_folio_flags(const struct folio *folio,
                unsigned n)
{
        const struct page *page = &folio->page;

        VM_BUG_ON_PGFLAGS(page->compound_info & 1, page);
        VM_BUG_ON_PGFLAGS(n > 0 && !test_bit(PG_head, &page->flags.f), page);
        return &page[n].flags.f;
}

So there's two asserts that might trip; the first if the folio is freed
then reallocated into a larger folio and the former folio becomes a tail
page.  That's pretty unlikely for a hugetlb folio, but the second is
more likely.  That'll happen just by freeing the folio.

> > @@ -2725,13 +2748,19 @@ int unpoison_memory(unsigned long pfn)
> >  
> >  	ghp = get_hwpoison_page(p, MF_UNPOISON);
> >  	if (!ghp) {
> > +		spin_lock_irq(&hugetlb_lock);
> >  		if (folio_test_hugetlb(folio)) {
> >  			huge = true;
> >  			count = folio_free_raw_hwp(folio, false);
> > -			if (count == 0)
> > +			if (count == 0) {
> > +				spin_unlock_irq(&hugetlb_lock);
> >  				goto unlock_mutex;
> > +			}
> > +			ret = hugetlb_clear_poison(folio);
> > +		} else {
> > +			ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;
> >  		}
> > -		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
> > +		spin_unlock_irq(&hugetlb_lock);
> 
> Adding new synchronization here without noting why - it's not
> immediately clear what this synchronizes.
> 
> Is this just fixing an unrelated bug / should it be a separate patch?

This prevents a hugetlb folio (which in this arm we don't have a
reference on) from being freed.  I think it ended up in this patch
because Sashiko pointed out the race during review of this patch.
It could probably go in its own patch 
