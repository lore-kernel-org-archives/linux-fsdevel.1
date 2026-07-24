Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47078439347
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784901660; cv=none; b=SOuqqzlUFHDVyzgF9mM0B/PeA2+SYW+OyB8qJnKtKOaQI1VFmii0h0H9r9qRn7IGOTzGb/fNQqDHNuqUOfyfN+8Bkhp51U8442rG9PszB4oix6k26YJ5eL9CKbzcx6xUwpuEl4eQNNHHaRJZHMW5fnth9CbH0OV0dvT4opvgg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784901660; c=relaxed/simple;
	bh=mOEsGbkRUJgECL4wcW1z3fLAY/eIon0vPdAD5r3GXhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LZsBFXrEghkKzbF1lfa+5TYo6/rnO2S0tbl6aZoZSKBXIFH7WO2ywG9Sz2be41hF4eQlsOfTHpjxuilxnpWMdmLUQAIPnxst3fgMN+60rEg4BhHRM+j3WZTLmsBzq3BV80s+pG4YeC+FW/o5Q4TS7TQayCclczkLiMKFUBZF4D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s8807+jX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s8807+jX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YLWZJH05bPsYo6l/NwF/IdTDbMw1JogUtckT/duPcEU=; b=s8807+jX9Z4Ckxqf1zi2eT/GGH
	5WVUk0PSJhIKjcBfwqldUI7xVMu0LjbnZamXKH/Xe5mqeijRXXCfehjXfHH8IF90YU9V2na3vJUIn
	uuKXh5XyLpGdi1C8UAj388swgUMTMNRLwWp/JPNc8wiY0H+s9RAwTSXfM+6aNbKsBxrUQSKQ9bMj4
	HBGf2nEhPpclRhHRXAkxrJwT5Yya7i7NRXDqkPTURjfcznEdyfz4yfE+nhNYgqLtZvw7EoAlRPpi8
	j4CINfqSfg91ZAg6wN5ZjNyttrgei0tquzo3tbXV4QTil22ElO01vy1lqa+uEOHyrnq9wWejcrUs9
	MKCb7gVA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnGS1-00000003e4P-44QJ;
	Fri, 24 Jul 2026 14:00:34 +0000
Date: Fri, 24 Jul 2026 15:00:33 +0100
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
Subject: Re: [PATCH v4 09/14] mm: Check individual hugetlb pages for poison
Message-ID: <amNwARfIFyEXE_zE@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-10-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-10-willy@infradead.org>

Sashiko review:
> --- Patch [9]: [PATCH v4 09/14] mm: Check individual hugetlb pages for poison ---
> commit 5da9009498dbc7d3d1fea29d7065847731ac20dc
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Subject: mm: Check individual hugetlb pages for poison
> 
> This commit modifies the hugetlb hardware poison checking logic to verify
> individual subpages instead of the entire folio. It introduces a new
> function to safely perform this check without holding a folio reference by
> relying on the hugetlb_lock.
> 
> Link: N/A
> 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 7c4652dd517a3..9cde74320e48a 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> 
> [ ... ]
> 
> > @@ -1090,6 +1090,8 @@ static inline bool PageHuge(const struct page *page)
> >  	return folio_test_hugetlb(page_folio(page));
> >  }
> >  
> > +bool hugetlb_unref_page_hwpoison(const struct page *page);
> 
> Does this cause a build failure when CONFIG_MEMORY_FAILURE is not set?
> 
> When CONFIG_MEMORY_FAILURE=n, mm/memory-failure.c isn't compiled, meaning
> hugetlb_unref_page_hwpoison() is not defined.
> 
> Since is_page_hwpoison() is an inline function that evaluates a runtime
> condition when CONFIG_HUGETLB_PAGE=y, the compiler can't optimize the
> branch away.
> 
> Will this result in an undefined reference to hugetlb_unref_page_hwpoison()
> for callers like fs/proc/kcore.c?

Oh, right, need to define FOLIO_TEST_FLAG_FALSE(huge_poison) if
CONFIG_MEMORY_FAILURE isn't defined.

> > @@ -1104,7 +1106,7 @@ static inline bool is_page_hwpoison(const struct page *page)
> >  		return true;
> >  	folio = page_folio(page);
> 
> This is a pre-existing issue, but can this speculative folio access cause a
> kernel panic?
> 
> In PFN-scanning contexts like /proc/kcore, is_page_hwpoison() is called
> without holding a stabilizing reference.
> 
> It calls page_folio() speculatively and reads flags via
> folio_test_huge_poison().
> 
> If the page is concurrently freed and reallocated to a non-compound user
> (like SLAB) that stores data in the compound_head field, page_folio() will
> return a garbage pointer.

... what?  Slab is a good compound page user.  You're drinking the
bad bot juice again.

> This isn't a bug introduced by this patch, but could the non-atomic
> modification of the poison flag corrupt the buddy allocator?
> 
> unpoison_memory() calls hugetlb_clear_poison(folio) which performs a
> non-atomic read-modify-write:
> 
>     folio->page.page_type &= ~(1 << 23);
> 
> When get_hwpoison_page() returns 0 for a free hugetlb folio,
> unpoison_memory() does not hold a reference. Concurrently, the folio can
> be freed to the buddy allocator.
> 
> If the non-atomic modification in unpoison_memory() races with
> __folio_clear_hugetlb() or the buddy allocator's __SetPageBuddy(), it can
> overwrite their updates.
> 
> For example, if it overwrites the buddy flag, PageBuddy() becomes
> false for a page on the buddy list, crashing the allocator when accessed.

I think it re-found the same problem it complained about earlier.

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
> 
> Can this list traversal result in a use-after-free?

As earlier, I'll protect this with a spinlock.

