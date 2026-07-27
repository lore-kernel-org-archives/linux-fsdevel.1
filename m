Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D1E37A847
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180309; cv=none; b=HRDtG7TXgtzX/XjY+34xe6GYn5J9cUXFTBopSOAnuSB8jhRkKJqR9u1DBl7h5o+5O6R1Wdk0YHKnMJEUypdudlztUe9qhn3kB3hX9gTB7Zf48W+yiEG23X054kn8u3WVoRe50LLAxANiuYf1Aid+XdwrB7/1yn2XK41lOWvfmGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180309; c=relaxed/simple;
	bh=1Iwop5PIEJSfW6S00jSU3S+cpWIOiwz/MRf19lRjoWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HduHnWFR0cMbHx52OGrBtXSdBjYfjLSeQZlfXuP0c/csBR8B2n/AuGLZnR0DhuUjyf/9bqE2mwtGl5DqtUpZp+Ewu+O8Mqm5Qw8gX8HCv+EmBW6Yns195O7nMo2Oj2Us3ta9IefjpAqYAExc/aLyAltKXhcB4ho7MnnSnwWRQEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iR3yzklN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iR3yzklN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7emG/Bu3YrbljPGVbZoShTn41m9g5LjbzcKv5pUpsVk=; b=iR3yzklNb9UCT2hcw6Lnf0nBOP
	9qLjT8AOHqUKvFLV6YXWgneW/EmsUkc+6ES5oCkubbctAUec/DrZmMBBBwq6dM7QuYj9Z5Q18mg6P
	0cbXXTvdJh97l+VIomDxcBr7dOnbKX9Sm8l/cFOGPM1pK2MKDNZls5Gsx0Zb8D8B2oSMn6hzF+57s
	VTv8BxP60JgpI3jEklbeEU73a63fVys1IMusuDw0b4c2zVzE7BYv34kyA/FLWrm1KhPk1zoF2UnRd
	mP4NDB9mi36WTgu4lRY3tOQpNLSzqy8ZhzeDr0bbAa4i/Kys7REvDm2OZ/Wg+zNmKymYKVNNeKtmu
	sZqEgwGA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woQwV-0000000BJN2-1xCB;
	Mon, 27 Jul 2026 19:24:51 +0000
Date: Mon, 27 Jul 2026 20:24:51 +0100
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
Subject: Re: [PATCH v6 05/12] hugetlb: Use the has_hwpoisoned flag
Message-ID: <amewgw3vDEu6sC2V@casper.infradead.org>
References: <20260727181310.2671972-1-willy@infradead.org>
 <20260727181310.2671972-6-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727181310.2671972-6-willy@infradead.org>

Sashiko:
> --- Patch [5]: [PATCH v6 05/12] hugetlb: Use the has_hwpoisoned flag ---
> commit 0c26849a193942cada35af35e9ebcde14770667c
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> hugetlb: Use the has_hwpoisoned flag
> 
> This commit converts hugetlb to use the has_hwpoisoned flag like other large
> folios, introducing folio_test_huge_poison() to handle racy lockless checks.
> It addresses a gap where previously-poisoned hugetlb folios might not show
> the hwpoison bit correctly.
> 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> 
> [ ... ]
> 
> > @@ -1255,7 +1255,7 @@ static struct folio *dequeue_hugetlb_folio_node_exact(struct hstate *h,
> >  		if (pin && !folio_is_longterm_pinnable(folio))
> >  			continue;
> >  
> > -		if (folio_test_hwpoison(folio))
> > +		if (folio_test_has_hwpoisoned(folio))
> 
> Can soft-offlined pages bypass this new check and get allocated?
> 
> When soft_offline_page() processes a free hugetlb folio, it calls
> TestSetPageHWPoison() to set the per-page poison flag, but it does not
> set the folio-level has_hwpoisoned flag. Since this allocation path now
> exclusively checks the folio-level has_hwpoisoned flag, it looks like it
> will fail to detect the poison and hand out corrupted memory to userspace.

Seems like a hallucination to me.  There's only one place we call
TestSetPageHWPoison:

try_again:
        res = try_memory_failure_hugetlb(pfn, flags);
        /*
         * -ENOENT means the page we found is not hugetlb, so proceed with norma
l page handling
         */
        if (res != -ENOENT)
                goto unlock_mutex;

        if (TestSetPageHWPoison(p)) {
                res = -EHWPOISON;

so hugetlb memory is already handled first, and won't fall through to
here.

> >  			continue;
> >  
> >  		if (is_migrate_isolate_page(&folio->page))
> 
> [ ... ]
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> 
> [ ... ]
> 
> > @@ -2725,13 +2748,17 @@ int unpoison_memory(unsigned long pfn)
> >  
> >  	ghp = get_hwpoison_page(p, MF_UNPOISON);
> >  	if (!ghp) {
> > +		spin_lock_irq(&hugetlb_lock);
> >  		if (folio_test_hugetlb(folio)) {
> >  			huge = true;
> >  			count = folio_free_raw_hwp(folio, false);
> >  			if (count == 0)
> >  				goto unlock_mutex;
> 
> Does this error path leak the hugetlb_lock spinlock?

*sigh*.  Fixed thusly:

+++ b/mm/memory-failure.c
@@ -2752,8 +2752,10 @@ int unpoison_memory(unsigned long pfn)
                if (folio_test_hugetlb(folio)) {
                        huge = true;
                        count = folio_free_raw_hwp(folio, false);
-                       if (count == 0)
+                       if (count == 0) {
+                               spin_unlock_irq(&hugetlb_lock);
                                goto unlock_mutex;
+                       }
                        ret = hugetlb_clear_poison(folio);
                } else {
                        ret = TestClearPageHWPoison(p) ? 0 : -EBUSY;

