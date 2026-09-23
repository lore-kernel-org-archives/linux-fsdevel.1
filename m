Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53013803D1
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Sep 2026 19:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190667; cv=none; b=BJnL5c01BFv1DYD1gmdjaABN7c366O8zyvrYhcK+MK1KUO3pV1cwpjdXg5HgCoUDSD9ps34Zymi+NIpfLSZkwMOaJBaxF4q3C/EQd6S4uZms3CnZzoDvq8r7aNi0+SaGaMz/7laKwz0vyWCYZ0kskT5lzrgKpl0QV8tWsLbp994=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190667; c=relaxed/simple;
	bh=01/JPyjt7qn0XS8DYib1LxBpCTAsUOhlHZmvPyyOm4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2tSue+A8vZA6Nfm5LKhIzd+eYWDjHFw20ivBfs7D/eyKKyUUx7RuwNtHCPRGlOyUSwgY0scIkC5kM95hP3LDMcjZxb+8g6jc0Ns3QvSTBBUPQcZrgbt1mg9ujUrKn8phPKPO9CinppKCgZt8RvhXuzrK3r2OouV1+MtzJ0mbJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Hz+vBi8v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Hz+vBi8v"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IdbvxD7XvosJv9AaBZwu35ekz1HVTVwCDc31aTv9+jk=; b=Hz+vBi8vLWbTXjXGcIU8xWLl2K
	TSfQU8Xcj1UQuDAB35cjiUwhEN10TXGaylwmqGeVjRSM/fQfyYZfLBtIDnXYVw4qh16APiCezp/RC
	BBZNVGgjX4MHaf/+oyDfJU5E+Y9cAZB+SFme7xvFHvoAgX4ij+Z2WmzNH8pDgI5nxCBbvH0NoMP0t
	/i+8K93VymoNJ7EVsVqL0MoDGIpGxK91ej5S63t1N3VmRo2Qntg0LVsY2F/wUddRmUAvrNEnE31+J
	Xf8FLVUCgYr6xerl1fGjRqPY780p5dRNiMxWmYpFsitQdNUHzUeEKtMMbp6Id5+29nHV2ZT95Uu71
	goELFdyg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9SMp-0000000ECUY-2y5n;
	Wed, 23 Sep 2026 19:10:56 +0000
Date: Wed, 23 Sep 2026 20:10:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v9 08/15] hugetlb: Use the has_hwpoisoned flag
Message-ID: <arQkP2uEzog8ChN0@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-9-willy@infradead.org>
 <a51a6236-8881-4479-8f04-39676e0e1f14@kernel.org>
 <an3uN4TAAZ2miXhe@casper.infradead.org>
 <7608c80e-645b-4d07-bba3-ef45ee36fba4@kernel.org>
 <arGidwZQrrWVPAoj@casper.infradead.org>
 <7a23511f-365f-436f-b934-6a520510409c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a23511f-365f-436f-b934-6a520510409c@kernel.org>

On Wed, Sep 23, 2026 at 01:40:24PM +0200, David Hildenbrand (Arm) wrote:
> On 9/21/26 23:32, Matthew Wilcox wrote:
> > On Fri, Sep 18, 2026 at 03:44:12PM +0200, David Hildenbrand (Arm) wrote:
> >> I'm a terrible person and it took me way too long to get back to this :(
> >>
> >>>
> >>> You make it sound so easy ;-)
> >>
> >> Heh, as long as you hold a folio reference it really is :)
> >>
> >>>
> >>> If we don't hold a reference on the folio, then the folio (whether it's
> >>> hugetlb or not) can be split.  And then folio_test_hwpoison() can hit
> >>> the assertion that it's now a tail page.
> >>
> >> Right. I am/was missing the connection to "generic_file_read_iter() in hugetlbfs".
> > 
> > We might be able to split this into two series at this point.  
> 
> That would be good, because I suspect the "generic_file_read_iter() in
> hugetlbfs" part is less controversial than the hugetlb cleanup and we can just
> merge that easily without touching too much other code.

Oh, no, it's awful and complicated.  We could strip out the two bugfixes
which are at the start of the series, but why would we want to do that?

It has to do with hugetlb not using the has_hwpoisoned() flag today,
and to do that we need to do all the other cleanup first.  You don't
need to read + understand those earlier patches; they have enough 
review from people familiar with this area.  And sashiko ...

