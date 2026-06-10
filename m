Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030637F8C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 20:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781121732; cv=none; b=W0d09b44F0E9SlPWOdH64bkjce2tEbYj2oTUo3vXsyNYjXHQuxWTLTE3tGvkJIhUR1tXWFfCVyU8DS4xwWUa4uN0Y/8ihW54WXLWQL3HgFOdoKaDmmEyIwquZbf1JUlq9ALj9v1Nylw6uaEmmYtuFk9nrJDaaCD0uCbkK65PXb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781121732; c=relaxed/simple;
	bh=ux9c+reJwxLURPHsQke0U2okzfaCvzxH/kKZPKQZB4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CpqYT3zlAE9ys4FZe7svQLGk4ZGq1KD66GP6TZTo13wPARmoaR7XrkAlywlTV0yFW4boq4EWPSCOIjhBUCxH6kT+BwICMDSwBuouXjFbsNgMpxYU7WWyxx9K+kadr/lvkJ0BYeMuGWW9xrAYS3P3yk55GIdkAbyDO/nRlrA1hE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=orhOjg0N; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orhOjg0N"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=6fRTYdQA/O81FSYgvTZlJXnNKEg69vqikPwkNJLsajI=; b=orhOjg0NMFmX8bdRhl6M7//0zI
	bpYrC2Isvsy1bWLaFKgYMMmuEWFSi4Y/CYxJXlTZCVDB12fCOUHYP8wq8b3F5qs1WEbHCmAFbgQoK
	+Pjs1kdn+qRfT7GfDMMsePPpkCfhhBPEXLW6oZP0obyjRxqGWrgNs9odHX5Vo102TB/ApR3wxhlrZ
	OFGvOJ2sG4+ASnwTgpPif2dyKFYGekRc0MmHPgLM7ZaJmh5CuIaLDZ8xSiaf9Tv5tH9I80FmZvFMf
	5mqz8hXbO6NEMAIatYrsL85HCTBWkIu9Lpyxwn4HXs5KAALi2ZdcmauQwyE4alJpZ3uoOAq3u85pq
	i7LipLmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXP7j-00000000YqO-25DQ;
	Wed, 10 Jun 2026 20:02:03 +0000
Date: Wed, 10 Jun 2026 21:02:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 5/6] show_page_info: Remove printing of page index
Message-ID: <ainCu2HZTTdP4skd@casper.infradead.org>
References: <20260608210618.3437216-1-willy@infradead.org>
 <20260608210618.3437216-6-willy@infradead.org>
 <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20a5a752-3ed6-4fde-96c9-e8369b15524c@linux.dev>

On Tue, Jun 09, 2026 at 07:59:28PM +0800, Ye Liu wrote:
> 
> 在 2026/6/9 05:06, Matthew Wilcox (Oracle) 写道:
> > Pages don't have indexes, folios have indexes.  Just delete it.  This
> > script is going to become increasingly barren unless somebody steps up
> > to maintain it.
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: Ye Liu <liuye@kylinos.cn>
> > ---
> >  tools/mm/show_page_info.py | 1 -
> >  1 file changed, 1 deletion(-)
> LGTM, thanks for cleaning this up.

Thanks, but could you explain why you don't just call dump_page()?
It's more comprehensive and will continue to be maintained.
