Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CDE425866
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 14:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784211891; cv=none; b=kJyolkiklnv9+gAHSAcF3CXPJ3nM7LAfDvEZJ6pm4Zq5hEcucKPG5KxkX8v/11Jaud1VaOU8F2aMrc4AGW9hQx2G3Fa1nF6dnXsTvMA1t6N6wDjqaWq+JJ7t9V+SKOVoOnB2LoLcolPN+SSxatec3Td42IV8TMLdb4LFbsRCMw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784211891; c=relaxed/simple;
	bh=ih7hOC0PzgeSeXT+OoFRS9XeK7WVhEtSnLc0MPiKDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKUpNPvY8nQFTPw3mbS/Ix1incQIg1e5DWq0+pSDcO1bM4TUJ89uh7Oq8UGninCibfwuBnB+MPdCfbePIo6tM1zkswOmq7LA6O13IG4xPRH7b/w+cyzSZWr22/umm+5zIQwh3PqRJegfaFXd+3UFniKFIcSVSpFF7BsX+bFLlYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ifn++u3N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ifn++u3N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X0b0D6Kjf9xQir7X3LyFTEp/Zq+ZumCcrEIpFFWjBNI=; b=ifn++u3NseCju98sW1l2S0xUR6
	b/1dZVJ8iwqUItdOL0ICrvxwBfopYJ9SndKW409lFySe8+hPnJXR083jDS5wksU1pPtIY1DcXIMPa
	GxM1Cj4HoISaIDGYKuUTu9pP4ANmWvqIAKNLa7BuU/189WniSqd7yAAisTPfkLYrXB1jXE3Dn6Oe/
	dTNd0Wlwoag2HX2pD8xo/8Bb3JHXU9oKHIXbX7TgcgWhautMeJ6fYjqTcbf4C0ADMxBF/0M/0e219
	45dNYIdar7dn1wdkDZYfrape1U51J9B1OyfnSM0hg2TrhR6aFsUWKPI/IkA7PgydOQL0WOrHGZcg1
	7xTm9leg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkN0s-00000002fXC-2Fnb;
	Thu, 16 Jul 2026 14:24:34 +0000
Date: Thu, 16 Jul 2026 15:24:34 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>,
	Jiaqi Yan <jiaqiyan@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH v2 06/10] memory-failure: Prevent UAF in raw_hwp_page list
Message-ID: <aljporPjnUCyhQUs@casper.infradead.org>
References: <20260709184740.1286561-1-willy@infradead.org>
 <20260709184740.1286561-7-willy@infradead.org>
 <7f630930-fbf7-42bd-945d-664484defc2c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f630930-fbf7-42bd-945d-664484defc2c@kernel.org>

On Thu, Jul 16, 2026 at 11:16:48AM +0200, David Hildenbrand (Arm) wrote:
> On 7/9/26 20:47, Matthew Wilcox (Oracle) wrote:
> > Most accesses to the raw_hwp_page list are protected by mf_mutex.
> > However, the call to folio_clear_hugetlb_hwpoison() in mm/hugetlb.c
> > does not.  This is probably OK today as this is in the freeing path and
> > I think all current calls to is_raw_hwpoison_page_in_hugepage() hold a
> > reference to the folio.  However, the next patch will call this function
> > without holding a reference on the folio, which will expose this race.
> 
> As mentioned yesterday, I wonder if we can remove the entire subpage hwpoison
> tracking. With HVO it is just beyond ugly and not really fun to maintain as it
> seems.

I have other ideas for making it better.  Even with HVO, we have space
in the array of struct pages to store this information.  We keep
PAGE_SIZE worth of struct pages writable and map the rest as aliases.
With a 4KiB PAGE_SIZE, a PUD is 1GB, composed of 2^18 pages.  A bitmap
would be 2^15 (32KiB), so there's no space for one bit per page, but
memory failure should be relatively rare.  We have about 32 uncommitted
bytes per tail page, so we could store 8 32-bit page indices in each of
about 60 tail pages, allowing us to track 480 defective pages in a 1GB
page.  That feels somewhat more reasonable than this llist_head
structure.

> Regarding read(), it was added 3 years ago [1], and the cover letter did not
> even state a single real use case.
> 
> "Since memory_failure already tracks the raw HWPOISON subpages in a
> hugepage, a natural improvement is possible: if userspace only asks for
> healthy subpages in the pagecache, kernel can return these data."
> 
> I doubt there is practical use. But I'm happy to be educated :)
> 
> Is anybody aware of practical use for that?
> 
> [1] https://lore.kernel.org/linux-mm/20230713001833.3778937-1-jiaqiyan@google.com/

I don't think Google did that for fun ;-)  Take a look at
https://lore.kernel.org/linux-mm/20240924043924.3562257-2-jiaqiyan@google.com/

and it's fairly obvious their use case is for trying to recover from bad
memory when using hugetlb to back guest memory.

But hey, Jiaqi is still active, so they can speak for themselves.  Cc
added.
