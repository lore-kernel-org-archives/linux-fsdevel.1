Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB85B946C;
	Sun, 15 Feb 2026 03:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771126708; cv=none; b=X1PkEYqek2yzQxanIq44CcFIyZeUYyh8ZJmmwMQtPzHZWrQMPgNB58c1mfdc0jdOA/bBFuPqIQSEfQezvKrsBOmvNC84kiqgaD7bugvWOYOwUyUlSU4FUyhrKGTXBV2kQWB/H6lC4Ps2BYRS36rgIL2vNy8jPP16SVglW5+BHkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771126708; c=relaxed/simple;
	bh=m3t/eN5rSSG6E2TQwiCNKKMh+1Krq6TTwopIT/wM0UA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hbdIPQbRofzDPJamrSC0SgfSefaL35fpx42u2BiPlo5NkcLVn1B7fSeIQgwqyIpDHvEQX7xWNZNvNBYQAwIeRbtMJJvhcXI6pVsQryfaMvGlB8YyJhuRNEE79hR7JR3O9luxyYVhv4Tv7sgKHJ7xlWICeCVi6ELnKmQcXjXIIbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TJkrfu6e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TJkrfu6e"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0gpfc51mMBICMZmGSyQ+Dobd2xh/Dm49e3wlNSsja6E=; b=TJkrfu6eJ/FrKsuZAPyRl83W5f
	QzHLP50urhisoeJ71skSoKTB7AWEBZPqp7KUIgsVrWg7sy+dlAZdPxqDCzYuT8GktAv8Y5gqiQxeE
	6u4J1eomKJ/2B5nWKYIYUFjg62rdwy4Wp1hnc8qCdB/GfmKRPloI/eXTk+zy5UqhVvHfNArJI/j/3
	p7+KTrSTghBKAgpdHrRVRu6HWianl3SdbEkPH/n5/ZmMsxf5aKtzwor3/NEhsPFNc0KYINvZ1PiDz
	bSg6aFXqBxb7vD4znouXWRu/tu5TfuvxqoQhuLQptAiK5FrCiCmod2RGOB1AilU8Uf/rr9ZXPP4ep
	YyGAGBDw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vrSxg-00000000WIy-1ApT;
	Sun, 15 Feb 2026 03:38:20 +0000
Date: Sun, 15 Feb 2026 03:38:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, linux-f2fs-devel@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/2] f2fs: use fsverity_verify_blocks() instead of
 fsverity_verify_page()
Message-ID: <aZE_rKsOAgYqTjZ_@casper.infradead.org>
References: <20260214211830.15437-1-ebiggers@kernel.org>
 <20260214211830.15437-2-ebiggers@kernel.org>
 <20260214215008.GA15997@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260214215008.GA15997@quark>

On Sat, Feb 14, 2026 at 01:50:08PM -0800, Eric Biggers wrote:
> On Sat, Feb 14, 2026 at 01:18:29PM -0800, Eric Biggers wrote:
> > +++ b/fs/f2fs/compress.c
> > @@ -1811,15 +1811,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
> >  	int i;
> >  
> >  	/* Verify, update, and unlock the decompressed pages. */
> >  	for (i = 0; i < dic->cluster_size; i++) {
> >  		struct page *rpage = dic->rpages[i];
> > +		struct folio *rfolio;
> > +		size_t offset;
> >  
> >  		if (!rpage)
> >  			continue;
> > +		rfolio = page_folio(rpage);
> > +		offset = folio_page_idx(rfolio, rpage) * PAGE_SIZE;
> >  
> > -		if (fsverity_verify_page(dic->vi, rpage))
> > +		if (fsverity_verify_blocks(dic->vi, rfolio, PAGE_SIZE, offset))
> >  			SetPageUptodate(rpage);

Yeah, no.

		if (fsverity_verify_blocks(dic->vi, rfolio,
				folio_size(rfolio), 0));
			folio_mark_uptodate(rfolio);

> >  		else
> >  			ClearPageUptodate(rpage);

This never needed to be here.  The folio must already be !uptodate.
Just delete these two lines.

> >  		unlock_page(rpage);

folio_unlock(rfolio);

