Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4FD3D6493
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 20:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790021340; cv=none; b=gCB1HWl1bX7DuOWGnghp6UbAlO5mml5GUw/m9/O4YBQRXCn3eAEQSEFMrqcQaY8DG5EFmwBqpL5P1wm7ZF02Yp3WQyOk4m1Ogyy7dg9wq7eHEHeg0NPirtq3+s8tElN+dk7BsUhk94hq3+rcAIi9lYJrYzHLgBhSvYbLJqt1NJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790021340; c=relaxed/simple;
	bh=KZa7T/CXcxSe1/UEvhUpMM3oYC27lLt90SGzebGXCaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idPfIq6o2ddomOat6ybFL9lLQkgFxCn++BksKI3cAJHd56z7/fP+ovfDPYCzjc4E2FU9UzKnb9Am7RvAaOid05FTIPMYdHa3W3Cay6P13oo9Qg5IvZc5rZ9OLCTtg8sGeojuO7J6wPPbo+NtRx+rgVNMSBlPdDw3PIXaKatdjFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQBUGlf1; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQBUGlf1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kpz1np6I94fifnMxNnYzzaYhhtfOM5zzK657a0adnvs=; b=sQBUGlf1YuwmcgH77+BVsC0fJq
	e4+F8LMr9HvpRk/GSeWJjWU2bcwy6PvypQT2+UkvY4V5gdDxC6UaP02gjLZc/9B3FpjtT1J4eYq1w
	6RY6uL+2t4YikBGmjKBbsxrj9pOIrIpiBUlD+NFRECei/llXpaYntuVHInyS0aG1zHLRSEnwHKzpL
	/EfYBX8uq5iP8wyWPjUyaLRlKx6ZDHUb9UdA2WqinD5qoi9Svbk65/4JxWKfH/9pMaQ968XdArnFQ
	9faWhcBGnzAUK4RaiGb8Vyc4w42HUUhYzZ+tAvjqSBVEYsMqfSaa40bnAuzof/kSYvsHYUS/0kLDG
	HQbq6p/Q==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8kJh-00000005DB6-2jl4;
	Mon, 21 Sep 2026 20:08:45 +0000
Date: Mon, 21 Sep 2026 21:08:45 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Pedro Falcato <pfalcato@suse.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 11/15] filemap: Add hwpoison handling to filemap_read()
Message-ID: <arGOzZkXQUdSpIc2@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-12-willy@infradead.org>
 <an2e1j3C_4DA5KXK@pedro-suse.lan>
 <an3xv6Hae6g3aHCh@casper.infradead.org>
 <813a2644-fa9f-4ee7-8655-ca69ef0e8a98@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <813a2644-fa9f-4ee7-8655-ca69ef0e8a98@kernel.org>

On Fri, Sep 18, 2026 at 03:47:18PM +0200, David Hildenbrand (Arm) wrote:
> On 8/13/26 18:33, Matthew Wilcox wrote:
> > On Thu, Aug 13, 2026 at 11:55:44AM +0100, Pedro Falcato wrote:
> >>> +static size_t adjust_range_hwpoison(const struct folio *folio, size_t offset,
> >>> +		size_t bytes)
> >>> +{
> >>> +	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
> >>> +	size_t safe_bytes;
> >> 						    offset >> PAGE_SHIFT would probably be more idiomatic
> > 
> > $ git grep '/ PAGE_SIZE' mm fs |wc -l
> > 116
> > $ git grep '>> PAGE_SHIFT' mm fs |wc -l
> > 656
> > 
> > it seems relatively common.  Personally I find / easier to understand
> > because I sometimes get confused between left and right shifts.  I
> > don't think I've ever been confused between multiply and divide ;-)
> 
> Linus once explained why ">> PAGE_SHIFT" is preferable when the type of the
> function might be signed, as the shift generates better code.
> 
> I personally find "offset / PAGE_SIZE" more intuitive, but I also have sympathy
> for PHYS_PFN() to abstract the operation.

Oof.  I appreciate PHYS_PFN() is literally 'shift by PAGE_SHIFT' but
it implies that the parameter is a physical address, which this isn't
(it's a byte offset within a folio).

> (SIZE_TO_PAGES would be a bit mouthful so I wouldn't ever dare suggesting to
> introduce a new helper)

I wouldn't mind a new helper, but it'd have to be a pithy name, and
I don't have one in mind.
