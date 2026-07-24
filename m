Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EC0431A32
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 12:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896612; cv=none; b=spdy95ghiFixrKQ0FXXhisB7vdsOWLztnXZH9HdNaS5jF9R7XmDKt3J8Mu7bv3IY0NKshcybceCnB9paqYrXkT0GMhLMFYIj5/U6eXECmU3f74pK49CK8tfP3gOZ2579SlOmx5MtpKjTgQz3mL3jI6a93S7VcYd5Ys07qTYZHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896612; c=relaxed/simple;
	bh=QoVBuHNqJJH5ztCqNR64btB3ogonTlw3XzKiFoF+rL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qb16JQxowjb7CwDwLKVsEGFDC2Rggtt15jE04elCR/g/CbZyPp7V+12INZmjjU96sBFPQNNJMQ5rqHPHo9fP/Z0J9S9oRkJi9ieDFqYNuWUZSkgaHHl/9siY8+a1PKggJFxH/x4YlOSqlrLypD55/UTJAQ40TgRLioZXhlP6Ho8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AsEU+6LX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AsEU+6LX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pAcRu8XyRC6c1KYvag2E6br+9Ab27aPo7Usr2cRo7Bg=; b=AsEU+6LXkOOTnSJN5srnxDHToM
	3BkK3affkSfkdzX83j3/PTatcDBhdCqF3kRdsxk2dO6SHqa5SVAoRuhxmmf1FLIAL/UtYw4tVwfY+
	c0jRgm28iGO8JiBIW8BPe8M/kqS3Uv0x7S6JEyAW82VtWay9DuYWE8lMAjL7qn1107zWs0q9lUZDl
	bVV1zMxfKpOB4TgSvcDclocdtcU6k/NUYnykQXqHtWieQNwIS0EGTEeOyC7oR21bvKj/5ejrRLhss
	CJMt/yPrmAAN4nMSvNU5Kw8/61i0E+qBPoiDO4sWZ0TqRwQxxPirg8gorwIWmukjjI5CJCL7dPHAE
	JIMivmyw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnF8s-00000003SyC-0Fy2;
	Fri, 24 Jul 2026 12:36:42 +0000
Date: Fri, 24 Jul 2026 13:36:41 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v4 03/14] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
Message-ID: <amNcWf9ORxyNqpiU@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723143034.175661-4-willy@infradead.org>

Sashiko review:
> --- Patch [3]: [PATCH v4 03/14] mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page() ---
> commit 82722dc6d8a8b8030006cbc0fae2e5f36ec21fa1
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> mm: Rename folio_contain_hwpoison_page() to folio_has_hwpoison_page()
> 
> This commit renames folio_contain_hwpoison_page() to
> folio_has_hwpoison_page() for better naming clarity. It also makes the
> argument const to allow other callers to be made const, with no functional
> change.
> 
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index 7223f6f4e2b40..4185a03a45cf7 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -1083,10 +1083,10 @@ static inline bool is_page_hwpoison(const struct page *page)
> >  	return folio_test_hugetlb(folio) && PageHWPoison(&folio->page);
> >  }
> 
> This is a pre-existing issue, but while reviewing the surrounding context I
> noticed a speculative folio access here.
> 
> When a privileged process reads /proc/kcore, read_kcore_iter() in 
> fs/proc/kcore.c iterates over PFNs and calls is_page_hwpoison() on raw
> page pointers without holding a reference:
> 
> fs/proc/kcore.c:read_kcore_iter() {
> 	...
> 	page = pfn_to_online_page(pfn);
> 	if (!page || PageOffline(page) ||
> 	    is_page_hwpoison(page) || !pfn_is_ram(pfn) ||
> 	...
> }
> 
> Inside is_page_hwpoison(), the page is converted to a folio and its flags
> are accessed immediately:
> 
> 	const struct folio *folio = page_folio(page);
> 	return folio_test_hugetlb(folio) && ...
> 
> Since the folio is unreferenced, could this cause a kernel panic via
> VM_BUG_ON_PGFLAGS(PageTail(page), page) in const_folio_flags() if the
> compound page is split or freed concurrently? 
> 
> Should this path stabilize the folio with folio_try_get() and re-validate
> before checking folio_test_hugetlb()?

This is fixed later in the patch series.  Bad bot, no cookie.
