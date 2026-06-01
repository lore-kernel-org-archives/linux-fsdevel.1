Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E70A376A10;
	Mon,  1 Jun 2026 12:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780318289; cv=none; b=mCcNZSzLytOVwPWfYVeLP/cgQbZ7hFaB+2eusC/JVIs6dckuOSaQzmzXLOvhn7paK1AN8miNUQcQJvUOg2ru9OlZq7x3X4Y7oYPVKiULZk9uIqx1bsLeuyH2GX3R+b8FgaFKUW3sb1qmN48uvGMMhBDua0Xu5WjRLy54pI2dTHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780318289; c=relaxed/simple;
	bh=6n1bI9SNAe4DHNgAAYSIT7M3aaAfOzbkI7gWuv5tfFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrosPrs8h7lGkJAsp95retFTiqjuFSz+fyiBrNnltYVeagWgBPS4fTszEuijrjwBe5YKE3utOfGOyaSDMklMwh8FXX0yhJFQuux8Rk3wTom7RG9EuK1aduYcqv23Qa/0p4FKQMpMDVo+488hwz42cqdFY3lSrqAC0IRIp2/NDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T/rnueMQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T/rnueMQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TEhv83iWRMPpEwpywpQrzBRVTeVJZLFdszoXaX6/TKo=; b=T/rnueMQa5GcXTkGnfK2SYkp6F
	eRWDyHxOMTbt5VXCpubYEBzzMT2cPaFNj1Ps9BJyOgJMlrGqGDDKTBHQwM+pxwEiOXkMzs/wclx4/
	zuWtcBvOIlKAbggC5VgYjL2wRAtQm9+ACNVagcsedWpyYsOiCtlv4y1QGeEhK4xtHwJkOAXGD2b0H
	ePR95Tv+sIvfzzphjL66dyAcHuSPpCg13U2L/LT9yX9xcho+9ee91Tp5QqzrIGSwmcV6ryBpb+fsW
	HHssm50k7Xcdsfns4/qBLIkKcZKaS4GhUV6f9NMF1ionY+EYV9rb06CIG5DlS2nD9vMMzc3kSPSAp
	5BEUUHXg==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wU26v-000000006aT-0kzb;
	Mon, 01 Jun 2026 12:51:17 +0000
Date: Mon, 1 Jun 2026 13:51:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chi Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH v2 1/5] mm/filemap: reduce unnecessary xarray lookups
 when read cached pages
Message-ID: <ah2ARWo_EiVOaWDI@casper.infradead.org>
References: <20260601055704.167436-1-chizhiling@163.com>
 <20260601055704.167436-2-chizhiling@163.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260601055704.167436-2-chizhiling@163.com>

On Mon, Jun 01, 2026 at 01:57:00PM +0800, Chi Zhiling wrote:
> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> When reading small amounts of data from the page cache, only a single
> folio is typically returned from filemap_read_get_batch(). In this case,
> calling xas_advance() or xas_next() after adding the folio to the batch
> is unnecessary and only introduces extra branches.

I don't think xas_advance() is all that expensive.  The expensive part
is going to be calling xas_next() and realising that the folio now lies
beyond the required range.  I think you'll get just as much benefit from
doing this:

diff --git a/mm/filemap.c b/mm/filemap.c
index 4e636647100c..578b03bd5514 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2459,11 +2459,14 @@ static void filemap_get_read_batch(struct address_space *mapping,
 	XA_STATE(xas, &mapping->i_pages, index);
 	struct folio *folio;
 
+	if (index > max)
+		return;
+
 	rcu_read_lock();
 	for (folio = xas_load(&xas); folio; folio = xas_next(&xas)) {
 		if (xas_retry(&xas, folio))
 			continue;
-		if (xas.xa_index > max || xa_is_value(folio))
+		if (xa_is_value(folio))
 			break;
 		if (xa_is_sibling(folio))
 			break;
@@ -2480,6 +2483,8 @@ static void filemap_get_read_batch(struct address_space *mapping,
 		if (folio_test_readahead(folio))
 			break;
 		xas_advance(&xas, folio_next_index(folio) - 1);
+		if (xas.index >= max)
+			break;
 		continue;
 put_folio:
 		folio_put(folio);
> 
