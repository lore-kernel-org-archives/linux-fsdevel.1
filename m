Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EB025B08E
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jul 2026 17:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783703830; cv=none; b=B7/QQoEuNAoXQMPRvDtDLShqTYN5lt3os++HA2LbB2ASUMVQVREQ1GJ4cEh7bxjf1oY6Pn7rla22Q4E/xpKBg0SE95meLSGIwJLogpQrtueL2INruneaoeNU7eNcQFZbwx8tbuSaWKgBozPxUsoFY61JkkrGMigsl7Lm4f+vyEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783703830; c=relaxed/simple;
	bh=TLk6/NaTjUbL+WWRlcwWEIle58HXTKrovr5l3yp660Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2wSjlpen/94C8Yxj23oLZYol3skjC0x2Mc5ZdVrYFH34Pju1M3roLmecN/XE8rBNDr5M4anGZS1u5A3eRYaeZDTSiqAXtLsjSOPUp+Cyk+vh5kAxyphScXBHZ/vezBoSfF2sxELameZ9UKn2Dg/OOcfNF8kM7W9EvcI9L1z+Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wM0amu2R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wM0amu2R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oXE/qdzDgEJh+tk6GkgML+u27UjBbh+JDL0zV5QbKUA=; b=wM0amu2R7kPfLA6TxU6kNtPdMT
	vgVkF+Av+X2ffQ7AozHzzq5I1zXOAPkqdJdlGIR/Vk3Lcy13Xf5RPpPLTaAXtHun5LKjGQixC5t/r
	wkIGDzCU20f+9HZwO5pKjUFjqWikBZIU2sLYJTrbNLNTXrDuiNLksmfz3bRH2dcKwEL/p0Ciw4bbf
	QSqq6E3Qf6khtU0mX/QBG4Y9jM77GcUTiMHKbLaQS9z63TUs8viguVUTA6+QDYH/k2NdXasur0Na9
	MPhur4kHXx+KkYxp0cgZhcRwG08fUarV0vcTv31cLel9NXZ6M5lwvZh3r42AEibLRHTg4QJYPsDty
	FF1gB0VQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wiEqM-00000007WIj-1WXe;
	Fri, 10 Jul 2026 17:16:54 +0000
Date: Fri, 10 Jul 2026 18:16:54 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Message-ID: <alEpBqExnyvBnnxi@casper.infradead.org>
References: <20260709184740.1286561-7-willy@infradead.org>
 <20260710150204.1887475-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710150204.1887475-1-usama.arif@linux.dev>

On Fri, Jul 10, 2026 at 08:02:03AM -0700, Usama Arif wrote:
> > +void folio_clear_hugetlb_hwpoison(struct folio *folio)
> > +{
> > +	mutex_lock(&mf_mutex);
> 
> This wrapper can now sleep, but its external caller is the hugetlb free
> path.  __update_and_free_hugetlb_folio() is reached from
> update_and_free_hugetlb_folio(), which has a comment saying
> "Defer freeing to avoid using GFP_ATOMIC"

Yeah, Sashiko also pointed this out.

I think I'm going to have to change how we track hwpoison in hugetlb
in order to make this work.  Let me think out loud here:

is_page_hwpoison() can be called without a reference on the folio
containing the page.  The answer can be wrong in this case, but any
UAF must be benign.

Grabbing the mf_mutex inside hugetlb_page_hwpoison() is insufficient
because we can't protect against folio_clear_hugetlb_hwpoison() (the
approach attempted in this patch).

We could add a spinlock for protecting freeing & checking of the list.
That's probably simplest.

It'd be better to protect the list with RCU.  But then we'd need to
put an RCU head inside raw_hwp_page, doubling its size from 2 pointers
to 4.

We could completely change how we do this; instead of having an llist,
we could have an array of 32-bit page indices.  Reallocate it when we
run out, doubling its size each time, and put an rcu head in that.
That'd give us 32-bytes the first time, space for 4 indices, then double
to 64 (space for 12 indices), double again to 128 (28 indices), etc.

We could also RCU-free the folio if it's hwpoisoned.  We'd need to
clear the hugetlb flag before asking RCU to cover up this problem
to ensure that any reader that saw the hugetlb flag set started its
grace period before.

Probably all too much trouble.  I think I'll add a global spinlock.

> > +	__folio_clear_hugetlb_hwpoison(folio);
> > +	mutex_unlock(&mf_mutex);
> > +}
> > +
> >  static int get_huge_page_for_hwpoison(unsigned long pfn, int flags,
> >  				 bool *migratable_cleared)
> >  {
> > @@ -2051,7 +2058,7 @@ static int try_memory_failure_hugetlb(unsigned long pfn, int flags)
> >  	folio_lock(folio);
> >  
> >  	if (hwpoison_filter(p)) {
> > -		folio_clear_hugetlb_hwpoison(folio);
> > +		__folio_clear_hugetlb_hwpoison(folio);
> >  		if (migratable_cleared)
> >  			folio_set_hugetlb_migratable(folio);
> >  		folio_unlock(folio);
> > -- 
> > 2.47.3
> > 
> > 
