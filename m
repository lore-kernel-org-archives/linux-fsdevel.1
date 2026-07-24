Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1CC3E3163
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784909198; cv=none; b=fzVbcigQu9ACRWQNCDTn1M0oTsjl6E/F0ftRkqicyZCD/kb/8zIKZYZbk9Sc43tL1t4oGHqazsgyjX8SwhXxAs96W1Aze+LjAOFwdKIg8PQRZXu0EANEYZADd2jLW/y4N/st8sAirWzM+x5MjfJb/THPMcEm/I0k3xnxOS9LA88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784909198; c=relaxed/simple;
	bh=darSTR7d4BeB2agh1wTXRLBZnrjyzN7+w4o/j299dz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nymXXGN7HmO2OBJuAILTe5pinHn+/v6eTjQshcrLcN+40VnIMXjKBtKein1vZYFUw6r0aVGAQ2qlqgWzsF+iZQoaDLHUJ4BMJLqYZtk+KTjD98S/c/XSb4mfZ8fC06MRccLBRolSD0X3xDPkh3qTM9BGG4D0CmqTpB2KYywDNBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fgOPtMwy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fgOPtMwy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9t83x8ui6APYaDPpbQb5BP7fzrJtMQqqyNXMrEjn00M=; b=fgOPtMwyT8Dy0sQkjYJGxyDXuS
	3BBkNy+Da8QYkx+MePzwZEJq06SrtJtkLKVqP0DStGOLHkxXavRGVyQPoqu7rONrvVZwQkG0HAIUp
	FgTzHlXEwdV/1igOI2caLp9IJePHSWqcGj0CswjVlO3TUPe/LIncF2yydUg1/N/jgsOupgkZNHemU
	wsLnHbBEc+rJXg1kOD8fp9aBpsyOwcHXvKJJ45Aytp0TkYP7AT2uYXr+8Eb8DiS3RInwvVsMw1lHq
	M2H0dQ9ic5gO+cvf8Qre34M3Xpnh2Utfg2mk+ZeUhgdr/6ESpX7pv8sxhN30Ra03pqkEv9iTAm2Sn
	aofsQ3Gg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIPm-00000003sOC-2RcK;
	Fri, 24 Jul 2026 16:06:22 +0000
Date: Fri, 24 Jul 2026 17:06:22 +0100
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
Subject: Re: [PATCH v4 10/14] filemap: Add hwpoison handling to filemap_read()
Message-ID: <amONfpgJInjm8XgF@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-11-willy@infradead.org>

Sashiko review:
> --- Patch [10]: [PATCH v4 10/14] filemap: Add hwpoison handling to filemap_read() ---
> commit c46fb3fcf6cb7055457888cfb186af5ae3a493c2
> Author: Jane Chu <jane.chu@oracle.com>
> 
> filemap: Add hwpoison handling to filemap_read()
> 
> This commit adds hardware poison handling to filemap_read(). It allows the
> read iterator to make a best-effort copy of data from clean pages,
> preventing Machine Check Exceptions when the page cache contains HWpoison.
> 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 9cde74320e48a..b146c5228741c 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -1111,6 +1112,16 @@ static inline bool is_page_hwpoison(const struct page *page)
> >  	return PageHWPoison(page);
> >  }
> >
> > +static inline bool is_ref_page_hwpoison(const struct folio *folio,
> > +		const struct page *page)
> > +{
> > +	if (PageHWPoison(page))
> > +		return true;
> > +	if (folio_test_hugetlb(folio))
> > +		return hugetlb_page_hwpoison(folio, page);
> 
> Does this lockless traversal risk a Use-After-Free?
> 
> When this function calls into hugetlb_page_hwpoison(), it eventually reaches
> precise_page_poisoned() which performs a lockless iteration of the
> hugetlb_hwpoison llist:
> 
> precise_page_poisoned()
>   llist_for_each_entry(p, READ_ONCE(list->first), node) {
>     ...
>   }
> 
> However, a concurrent memory_failure() can free the list nodes while the
> lockless traversal is in progress, since __folio_free_raw_hwp() calls
> kfree(p) on the nodes without an RCU grace period.
> 
> While filemap_read() does not process hugetlb folios, hugetlbfs_read_iter()
> (added earlier in this series) does, making the Use-After-Free directly
> reachable.

Will be addressed by the spinlock I mentioned earlier.

> [ ... ]
> 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 58eb9d2406434..26a5f18121f90 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2483,6 +2483,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
> >
> >  		if (!folio_batch_add(fbatch, folio))
> >  			break;
> > +		if (folio_has_hwpoisoned_page(folio))
> > +			break;
> 
> This isn't a bug introduced by this patch, but does returning a poisoned
> folio here risk a Machine Check Exception if a disk read populates the folio?

Sure, but we remove hwpoisoned pages from the pagecache for
storage-backed files.  So this doesn't come up.

> If a poisoned folio in the page cache is not uptodate,
> filemap_get_read_batch() will return it as the last folio in the batch.
> 
> Then filemap_get_pages() will see !folio_test_uptodate(folio) and call
> filemap_update_page(), which locks the folio and passes it to the
> filesystem's read_folio callback:
> 
> filemap_update_page()
>   error = filemap_read_folio(iocb->ki_filp, mapping->a_ops->read_folio,
>                              folio);
> 
> If the filesystem populates the folio using CPU operations (which is common
> for inline data, fscrypt, squashfs, or block device emulation), the CPU will
> access the poisoned memory and trigger an unrecoverable Machine Check
> Exception. The patch guards the userspace copy path, but misses guarding the
> cache-miss path where the kernel itself reads into the poisoned folio.
> 
> >  		if (!folio_test_uptodate(folio))
> >  			break;
> 
> [ ... ]
> 
> > @@ -2862,14 +2887,18 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> >  			if (writably_mapped)
> >  				flush_dcache_folio(folio);
> >
> > -			copied = copy_folio_to_iter(folio, offset, bytes, iter);
> > +			copied = adjust_range_hwpoison(folio, offset, bytes);
> > +			if (copied < bytes)
> > +				error = -EIO;
> > +			copied = copy_folio_to_iter(folio, offset, copied, iter);
> 
> This isn't a bug introduced by this patch, but will filemap_splice_read()
> still trigger a Machine Check Exception on poisoned pages since it lacks
> similar protection?
> 
> While this patch successfully updates filemap_read() to use
> adjust_range_hwpoison() to prevent reading poisoned memory,
> filemap_splice_read() was left unmodified.

Hugetlb doesn't implement splice_read(), so this is irrelevant.

> filemap_splice_read() uses the same filemap_get_pages() logic, loops over
> the returned batch, and unconditionally splices each folio into the pipe:
> 
> filemap_splice_read()
>   ...
>   n = splice_folio_into_pipe(pipe, folio, *ppos, n);
> 
> When a userspace process subsequently reads from the pipe, the kernel will
> access the poisoned physical page (e.g., via copy_page_to_iter()), triggering
> an unrecoverable Machine Check Exception.
