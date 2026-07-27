Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6213AFCF4
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166366; cv=none; b=VI7iL/IokmC51Og3C/3sENtvAqSTvVQxLsjiZyNbDFNxf5SsnUG6BThFNCotElAoAGy1P1O7RljnVUPRnPzPxc4lRN0g3tgcaaDDyznTeGP7HKBMr9il4EARURULCZ9SAeiuUhZoDIoPhbBgDSoto6kdRet0+isPYv7qFuB8AGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166366; c=relaxed/simple;
	bh=Mj1r++BXyS4eipe7r3y6+eArGNX9drLhJK6a8h1QWZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4zUFT2YGEN1+ilY6mfepAawdVYrLMB1KCSZU52BuYOWE1tL9dGkzJP7pPoWkVEPjSv059S6UYZ7eU8lj9WJHhUVrU/K6bLoBtHQKYDWQ/WfaBjLXUFgJQ13R3imKKAGNqoUKZPOYYjM3itlMmzHFOWTwA4X1HqrYsAG6j7Xi/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ISCVbmNi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ISCVbmNi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Qt3GwXR+J86gAMXxU5EG5NejNnyVLlhHQ4wVxklzb3Y=; b=ISCVbmNiUhtqR2WtsX76lwxDNq
	QgXAPepsEXSbiSc1Eie0JLNCyZIFdZhmLu7GYxzEGnptE0KLYFInaf0pg14091Bd66t4L7bNDyfu5
	b2LkgbrdmW5/gVZhpW/4ezxWs2vr+Lq9b1m54nIOE91XTVlTOhcAByqBcdjYZo0LFLg8QzdiaE61X
	X9L6SBKqqeBZiMANyAfZ8eGVkczgAadXmuC+AIjZ+xJe0MPHXrXnWmOhRy32o4JHSQKfUAYc3E94Q
	TyhUkILuNIBrIZDi5nl3sP7jFfNvwA+g0oVaDQ3D+yYXNldhpfK3NHx/Mi1A2mLYGDRhq48JLn8LS
	eWE4oVcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNJj-0000000Ax8U-21RZ;
	Mon, 27 Jul 2026 15:32:35 +0000
Date: Mon, 27 Jul 2026 16:32:35 +0100
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
Subject: Re: [PATCH v5 06/12] mm: Remove locking mf_mutex in
 is_raw_hwpoison_page_in_hugepage()
Message-ID: <amd6E4kg9_0Dtf3y@casper.infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
 <20260725160042.1557264-7-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725160042.1557264-7-willy@infradead.org>

Sashiko:
> --- Patch [6]: [PATCH v5 06/12] mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage() ---
> commit 5aafc5635bbbdae616864594ab6ced23fdde474f
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Remove locking mf_mutex in is_raw_hwpoison_page_in_hugepage()
> 
> This commit replaces mf_mutex with a new spinlock to protect the hwpoison
> list in hugetlb folios, preventing unexpected sleeping in predicate functions.
> It also renames the function to hugetlb_page_hwpoison and simplifies it to
> use a standard singly linked list.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 9d245b4f2b8fe..e2f50b4aba822 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> [ ... ]
> > +bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
> >  {
> [ ... ]
> >  	/*
> > -	 * When RawHwpUnreliable is set, kernel lost track of which subpages
> > -	 * are HWPOISON. So return as if ALL subpages are HWPOISONed.
> > +	 * When RawHwpUnreliable is set, kernel lost track of which pages
> > +	 * are HWPOISON. So return as if ALL pages are HWPOISONed.
> >  	 */
> >  	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
> >  		return true;
> >
> > -	mutex_lock(&mf_mutex);
> > -
> > -	raw_hwp_head = raw_hwp_list_head(folio);
> > -	llist_for_each_entry(p, raw_hwp_head->first, node) {
> > -		if (page == p->page) {
> > -			ret = true;
> > +	spin_lock_irqsave(&hwp_page_lock, flags);
> 
> This isn't a bug introduced by this patch, but is it possible for a race
> to occur if the unreliable flag is checked without holding the lock?
> 
> If CPU1 calls hugetlb_page_hwpoison() and checks the unreliable flag
> locklessly, it might read false.
> 
> Concurrently, CPU2 executing hugetlb_update_hwpoison() might fail to
> allocate a list entry, acquire hwp_page_lock, set the unreliable flag,
> and clear the hugetlb_hwpoison list:
> 
> hugetlb_update_hwpoison()
>     ...
>     p = kmalloc_obj(*p, GFP_ATOMIC);
>     if (p) {
>         ...
>     } else {
>         folio_set_hugetlb_raw_hwp_unreliable(folio);
>         __folio_free_raw_hwp(folio, false);
>     }
>     spin_unlock_irqrestore(&hwp_page_lock, flags);
> 
> CPU1 would then acquire hwp_page_lock, scan the now-empty list, and
> incorrectly conclude the page is safe. This could potentially allow
> poisoned memory to be accessed.
> 
> Would it be safer to check folio_test_hugetlb_raw_hwp_unreliable() inside
> the hwp_page_lock critical section?

Hm, yes, that's true.  I'll fold the fix into this patch:

@@ -1831,14 +1831,17 @@ bool hugetlb_page_hwpoison(const struct folio *folio, const struct page *page)
        if (!folio_test_has_hwpoisoned(folio))
                return false;

+       spin_lock_irqsave(&hwp_page_lock, flags);
+
        /*
         * When RawHwpUnreliable is set, kernel lost track of which pages
         * are HWPOISON. So return as if ALL pages are HWPOISONed.
         */
-       if (folio_test_hugetlb_raw_hwp_unreliable(folio))
+       if (folio_test_hugetlb_raw_hwp_unreliable(folio)) {
+               spin_unlock_irqrestore(&hwp_page_lock, flags);
                return true;
+       }

-       spin_lock_irqsave(&hwp_page_lock, flags);
        for (p = folio->hugetlb_hwpoison; p; p = p->next) {
                if (page == p->page)
                        break;

> > +	for (p = folio->hugetlb_hwpoison; p; p = p->next) {
> > +		if (page == p->page)
> >  			break;
> > -		}
> >  	}
> > +	spin_unlock_irqrestore(&hwp_page_lock, flags);
> >
> > -	mutex_unlock(&mf_mutex);
> > -
> > -	return ret;
> > +	return p != NULL;
> >  }
