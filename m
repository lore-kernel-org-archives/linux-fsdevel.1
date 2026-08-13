Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5224F48AE3D
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 16:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786638796; cv=none; b=ckLMd6I4jxVPDTYzdjwLQnDtop0hGdyEOLdZjABbnE7mkQdKbxGWu0xhIWQud/c8h7Be1rgBq7RJTg7SOUZ3kzbxI7HB5RrXepaJTjRFRQUYgm+LObj74rxxDPJHmhfCuMRtP6iUcHwvrUEkGIhrv1ohcdv7JvK5bAFWhOzdwH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786638796; c=relaxed/simple;
	bh=EcbCMs9pu53o4f5hTJEqELgzsV9JHFOQTlkBcJgEjXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chqDaIEcQQKglpv06UUwWETlJG3fxSQpX2FEBju/0W93SNEPGDszgvSuCoCX3iSadU9qF4gig1eHTyddWetnD75HimOosY1M2eFkVOBs2eN1TvkHf6wJCkzoFqQh8RIiGA3C0NGcV9Lxqt24lIn0xhxXlvsq09TbXt9I7C3ZDRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XoqBic57; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XoqBic57"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f88pVlznjU4eedBUyobQ8mnUcw0dBsZ7WpYkkmcfPr8=; b=XoqBic576JQC205dwdswzqlh1C
	BycP0xBQ8Ku3miNJdlvx4wDw0BzkIMcEhfDtqrCjhWQjp/2CpMnmmxhLUBcMBledxDQ5YxfOzQHWY
	PEl1UtWWOaJa3VCF55Kj6c5iSVHgw50jZZrjnQmdUKKKDy+DE2/MyLRUajBXjORWjCL1XBbOU0XGy
	e7wQ5KM/EpgYypZjp/Rvs/siS96FzH66oKnNawl+HY/03B86zQYjV6pag0zhtmtURumXMyPXWePYd
	5DOx/nyaL3DiM3H85WK3nXcJ3GhJ85JXCIRPUlFhN7uYq9SHX9MDDYSAMmqqBwn20Of7VPm8ZWOay
	fkwJzHfQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuYMZ-00000003rfO-2GnM;
	Thu, 13 Aug 2026 16:33:03 +0000
Date: Thu, 13 Aug 2026 17:33:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v9 11/15] filemap: Add hwpoison handling to filemap_read()
Message-ID: <an3xv6Hae6g3aHCh@casper.infradead.org>
References: <20260805210557.1118966-1-willy@infradead.org>
 <20260805210557.1118966-12-willy@infradead.org>
 <an2e1j3C_4DA5KXK@pedro-suse.lan>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an2e1j3C_4DA5KXK@pedro-suse.lan>

On Thu, Aug 13, 2026 at 11:55:44AM +0100, Pedro Falcato wrote:
> > +static size_t adjust_range_hwpoison(const struct folio *folio, size_t offset,
> > +		size_t bytes)
> > +{
> > +	const struct page *page = folio_page(folio, offset / PAGE_SIZE);
> > +	size_t safe_bytes;
> 						    offset >> PAGE_SHIFT would probably be more idiomatic

$ git grep '/ PAGE_SIZE' mm fs |wc -l
116
$ git grep '>> PAGE_SHIFT' mm fs |wc -l
656

it seems relatively common.  Personally I find / easier to understand
because I sometimes get confused between left and right shifts.  I
don't think I've ever been confused between multiply and divide ;-)

> > +	/* Safe to read the remaining bytes in this page. */
> > +	safe_bytes = PAGE_SIZE - (offset % PAGE_SIZE);
> 			similarly, offset_in_page(offset)

yes, that's easier to read.

> (yes, no codegen difference in both cases, but there could be a difference
> if the ARM dynamic page size stuff ever moves forward)

I rather hope it doesn't ... but I do hope it manages to strength-reduce
if it does.

> > +	page++;
> > +
> > +	/* Check each remaining page as long as we are not done yet. */
> > +	for (; safe_bytes < bytes; safe_bytes += PAGE_SIZE, page++)
> > +		if (is_ref_page_hwpoison(folio, page))
> > +			break;
> > +
> > +	return min(safe_bytes, bytes);
> > +}
> 
> Wouldn't this whole logic fit better in copy_folio_to_iter? shmem for
> instance also handrolls its own hwpoison read_iter logic with
> per-page-copies, etc; not amazing.

I did wonder wbout doing that.  We don't currently have the folio in
copy_page_to_iter(), and copy_folio_to_iter() decays to
copy_page_to_iter() immediately.  So it'd be a larger change.

> >  
> > -			copied = copy_folio_to_iter(folio, offset, bytes, iter);
> > +			copied = adjust_range_hwpoison(folio, offset, bytes);
> > +			if (copied < bytes)
> > +				error = -EIO;
> 
> I don't love reusing copied here, but I guess there isn't much better
> (in order to detect hwpoison-derived truncation)

I thought this was neater than using a separate variable.

