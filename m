Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44553431FD;
	Fri,  6 Mar 2026 18:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822477; cv=none; b=bm/K0o8rxxgcA7JVvUOasKbcPV+n4dg4ipUNW2qvCsMCnSMcYU9dH3ic4uhZmV5LGKZIvzqtnFO0U1D8+27ss+n4nmRvTvt56SaS5wtVwZDe1FkYUGFRt1IBSVzRMH790MxQnLMh/n5hlleeKXGEDrpcEZ4xWUpTVfb3xGIDHic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822477; c=relaxed/simple;
	bh=pVQX8UbFQFuwDfMZUkbjtXBKe6Lw0V+LZTPRaPnqEoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QX+Q0ILwEA3QLYlVgfqMGmscV6c4LWMu7bcpAGSFUIojBPHmXMwI3OtBU+jpEOe6UvpM8cA93Dgs9AJhibFKHwAdOYV70v1KYKOCkBwVSSMl0aykDH3xdzFVaLpk/aYGxtGnDrstfwbJZH8LW8YTQ05gCwTU26IBhdym8qWR304=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wg/i8/QW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wg/i8/QW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=VM5um0Un0dBqpJi9mEsTrBTXwrxc0DE4YjAakbTEyXQ=; b=Wg/i8/QWd4Ak3VOJCLKU4dOiuQ
	xhhympkoBIIrndvU9oNWzizRvbkRQ3jezMSezju9eBLweSBuzsBZdBVnJOYqnOrHMvr5SmlnVP7Rg
	Ng7hBgG47iGveYVWERXxjBdpvNRmq5AUyqBbP+7Nd6VQdOMNY/jUo+w/KgoQdH47g2HRf2TYFAWfw
	CCM7PTZXAotdCUsSZQMpGSkloS/Q2nDnr0/Aq9/YgBeRNfhWNv8pPcEzDkNj6deFHagI4erqIHgJp
	eteoq5s9zoTi8qpjjo0mqYvWpKAt2FdK+b+ImQ30AyTXD4aDaJV9zgu+yWXF0XFKvpq91UIqEg4U3
	Eoj2sqbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vya6m-0000000H9Eb-2cL2;
	Fri, 06 Mar 2026 18:41:08 +0000
Date: Fri, 6 Mar 2026 18:41:08 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Chris J Arges <carges@cloudflare.com>, akpm@linux-foundation.org,
	william.kucharski@oracle.com, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC 1/1] mm/filemap: handle large folio split race in
 page cache lookups
Message-ID: <aasfxLYRWzNodAYO@casper.infradead.org>
References: <20260305183438.1062312-1-carges@cloudflare.com>
 <20260305183438.1062312-2-carges@cloudflare.com>
 <aanYdvdJVG6f5WL2@casper.infradead.org>
 <aarVMrFptdXhHsX1@thinkstation>
 <aasAo8qRCV9XSuax@casper.infradead.org>
 <aasddOvIfcMYp3sk@thinkstation>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aasddOvIfcMYp3sk@thinkstation>

On Fri, Mar 06, 2026 at 06:36:30PM +0000, Kiryl Shutsemau wrote:
> The proposed change doesn't fix anything, but hides the problem.
> It would be better to downgrade the VM_BUG_ON_FOLIO() to a warning +
> retry.

The trouble is that a retry only happens to work in ... whatever scenario
this is.  If there's a persistent corruption of the radix tree, a retry
might be an infinite loop which isn't terribly helpful.
