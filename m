Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C3C292B4B
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 13:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784899465; cv=none; b=pbLqQX2DGZcAsjN94KALb4ExdJfF3b2nAC1mChAuKnKKd44yKgQI1U8xrLDTk6EBhyrvRw7dTbpl8S3BCZrgeRQf+5WlbFezuw/LL2K0etSJdD72/fNG3eISMBQ/+PM+/54FWZmb9tJMptmwmqT0xC2rC58ZGVvyE7l+jwRBcHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784899465; c=relaxed/simple;
	bh=CCR/CNjHeZnRUa1UuVfZS+SeH6RZ4wd0AcFZt1wbAi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lo0dRhC1LGudZDy1Dyh32BKdHa1EJNORf/N/9x4Z9wI9vTEMXQyZkwnGXpaCXXoCepdiF5gzPY21Tf2xhshEjzhPeSzIWnHpmKscnnLdp0cfYyNM6w1YuYrhcWjnAlEIakEKyTYGujKTZIhDloyysh/CniqGGJUKNHvBT2z2jcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=G0eEmgn+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G0eEmgn+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=gNZt1Lmyz9OGAAhL0ppxm6oxc4dour8CHkwYM0ZCDr4=; b=G0eEmgn+6+kn4CtVtHA7ghXxmJ
	TuvP6rDtyJj6YSFCunmL2hd5XCus7VuVpuaJy9glVb/qRJ5eHsbgVI6wiXZpb1Gw7uxf/qvOT/yGd
	FV4sGUUKG2MWVETPatCgY9ko7X0J06AUKeKFQAMOsRTDY6Qn1xJMpRAnWe41Mw+Ap75OPIh9BzGkb
	isjLKrXFM230Nlrz7WGJ1yBEJQn+k5O7e/0+3nr8Fp2WIGNfIJ/VaG9cAA8/Bitf0+/770jGNumNR
	8Cac16d3BvbeY3/IdIyt0JXJkojvORSs8esxA2RRip+nzSu8q6+mJ86cNqfqp8u2AMhw+QblIjmyv
	4/G9llBQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnFsw-00000003XuZ-03Cn;
	Fri, 24 Jul 2026 13:24:18 +0000
Date: Fri, 24 Jul 2026 14:24:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>, Usama Arif <usama.arif@linux.dev>
Subject: Re: [PATCH v4 03/14] mm: Rename folio_contain_hwpoison_page() to
 folio_has_hwpoison_page()
Message-ID: <amNngTk1E1vrbvCd@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-4-willy@infradead.org>
 <20260724085124-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260724085124-mutt-send-email-mst@kernel.org>

On Fri, Jul 24, 2026 at 08:52:13AM -0400, Michael S. Tsirkin wrote:
> > -static inline bool folio_contain_hwpoisoned_page(struct folio *folio)
> > +static inline bool folio_has_hwpoisoned_page(const struct folio *folio)
> >  {
> >  	return folio_test_hwpoison(folio) ||
> > -	    (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> > +	       (folio_test_large(folio) && folio_test_has_hwpoisoned(folio));
> >  }
> >
> 
> It probably makes sense to document when this should be used
> in preference to folio_test_hwpoison, given a lot of people
> got this wrong?

folio_test_hwpoison() / folio_set_hwpoison() / folio_clear_hwpoison()
need to stop existing.  I know how to do it, but it's a lot of churn
to page-flags.h.  Not something for this series, but it's on my radar.
