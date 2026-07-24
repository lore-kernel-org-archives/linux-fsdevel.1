Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0635E1A1
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896462; cv=none; b=EpYMS30ldsvij+93rFHjzti13P95Fs7tyeQYUJnuIozc0Dz9tHP+dvYhqkAABJ9NawSe+f88nUZByknmXOeTxLN+R1t+JyKm5PFgjTdy5ztJXR+k5hv1EDm7yZTOpM1eEiZbeL9201UwOmBOnThgqfxyN3cuobyroIXapONJNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896462; c=relaxed/simple;
	bh=L9LFH+rC95YaGgJEfKl9cIrIA1CTY/vsX9dEBdrOkhc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nmWDNqfocKYNdNxWjr8dnNXz3Etd1qOglVXQX1DngykpkFnm2ZFFvrmG4ldpF/duE600DX0c2ac7Paw971AHrQZJpM4lP2LcmC1nB95xaT5b5HI38D1ncG59xLMFO+0ptv0dg76vXAlqo9KONUBVEEqclgcRPfoWr6uUpwsJAyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fwRUj95j; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fwRUj95j"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HHb3eG+eg47H5YO0KxXiu0C9/zV2I23bNqZBVHabCyw=; b=fwRUj95j56RO6lhoEW7vqtAWZv
	mEWA2xgYkx2aWUlUxnnpDRxIKfWJMPvFf9Nhk/0Xc8FT0h3zKA/UTsp867EW8Tpj7jMA6O+2QLDZL
	X8+wfV4wz45J5iGq5eUPdjr0v/UHwDHCwF6OpiE79ZgwuW0csjd6813dfXTy/MW67drFOANZ4AYRK
	sxiKWtAIXn8yFbMjXL4xHj4ndiFPXuBBzLy6pnRyJ9b3uf4F+C5G87iGF3tNTrA85lA2cdI9PnjFX
	x5hvdrYUJsbX/CrslwdqOd4pahYzAJq14M1ng65HN16yQ/i7cEwL36yHoq9r0KaY8YT2zZW7wdAS6
	ixNbRn4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnF6Q-00000003Sfq-1Yqa;
	Fri, 24 Jul 2026 12:34:10 +0000
Date: Fri, 24 Jul 2026 13:34:10 +0100
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
Subject: Re: [PATCH v4 02/14] memory-failure: Test the page is hwpoison
 before taking the mutex
Message-ID: <amNbwmd6mV9Fte3V@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-3-willy@infradead.org>

Sashiko review:
> --- Patch [2]: [PATCH v4 02/14] memory-failure: Test the page is hwpoison before taking the mutex ---
> commit 1cca344401408425fcfd4ca129165f85229f9227
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> memory-failure: Test the page is hwpoison before taking the mutex
> 
> This patch moves the is_page_hwpoison() check in unpoison_memory() outside
> of mf_mutex. This avoids synchronizing with memory failure just to filter
> out pages which are not hwpoisoned.
> 
> > diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> > index 944e6e1d49719..3615ced0a11bc 100644
> > --- a/mm/memory-failure.c
> > +++ b/mm/memory-failure.c
> > @@ -2677,7 +2677,12 @@ int unpoison_memory(unsigned long pfn)
> >  	p = pfn_to_online_page(pfn);
> >  	if (!p)
> >  		return -EIO;
> > -	folio = page_folio(p);
> > +
> > +	if (!is_page_hwpoison(p)) {
> > +		unpoison_pr_info("%#lx: page is not poisoned\n",
> > +				 pfn, &unpoison_rs);
> > +		return -EBUSY;
> > +	}
> >
> >  	mutex_lock(&mf_mutex);
> >
> > @@ -2688,6 +2693,8 @@ int unpoison_memory(unsigned long pfn)
> >  		goto unlock_mutex;
> >  	}
> >
> > +	folio = page_folio(p);
> > +
> >  	if (is_huge_zero_folio(folio)) {
> >  		unpoison_pr_info("%#lx: huge zero page is not supported\n",
> >  				 pfn, &unpoison_rs);
> > @@ -2695,12 +2702,6 @@ int unpoison_memory(unsigned long pfn)
> >  		goto unlock_mutex;
> >  	}
> >
> > -	if (!is_page_hwpoison(p)) {
> > -		unpoison_pr_info("%#lx: page is not poisoned\n",
> > -				 pfn, &unpoison_rs);
> > -		goto unlock_mutex;
> > -	}
> > -
> 
> Does removing this check from inside the mutex introduce a time-of-check to
> time-of-use race?
> 
> If two threads call unpoison_memory() concurrently on the same PFN, both could
> pass the lockless check. Thread A takes the lock, unpoisons the page, and the
> page is returned to the buddy allocator.
> 
> When Thread B acquires the lock, it will now proceed without re-checking
> is_page_hwpoison(). If the page was concurrently reallocated as a compound tail
> page, the speculative folio_ref_count() or folio_test_slab() checks below
> could trigger a VM_BUG_ON_PGFLAGS crash.
> 
> >  	if (folio_ref_count(folio) > 1) {
> >  		unpoison_pr_info("%#lx: someone grabs the hwpoison page\n",
> >  				 pfn, &unpoison_rs);

Uh.  Yeah.  I wasn't thinking about two simultaneous calls to
unpoison_memory().  I'll just drop this patch; it wasn't important.

