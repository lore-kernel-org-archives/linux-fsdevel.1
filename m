Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4202426B764
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 15:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785167752; cv=none; b=XOoK4+f2j/WZ6DxQXtEUWykwDPYTZNpLftSPKtknoQC4HbNMhBYNB55DMDtgwfwyxJlOTP5bdUFtnAtvB0OWC7+iodHOAkR+K5UUbA2nTvTNOpqTK1tSgNqhpFjlcoDp41chXAMGIaoVLn6jOcvHKzvR2cUxquT30ZeH1RH+zzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785167752; c=relaxed/simple;
	bh=gCPf9W7lA9+zKja3T2wHMt7X/gMAmjiY5tGephwJo0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NNWqBKT5snWx1YPukZDbG1TpOnC/2B/Ud6h2lMWytnsDbfrzBkOw1ooIF1RYdlzHTAcAasICaYnR7fwHZc5LF7jmlA3njcoxpyVKAa2K31xKujLfCyj85N9QQAIfgCIL1wzoC/99bY3zuGqLaCMB1g/Ymm5zBAepjJDlBQud6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gGRvTUpO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gGRvTUpO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=r1YKY8dxDVPOObAhaY7i0KmqUanNkeNYqSbIMl3UWEo=; b=gGRvTUpOQQT2es9H0vC5I1nKpZ
	Fh95dMgoA6vVOVbzwRAMkDS7OJfs0dsdoCGbtglMscHw9WN9atinw840A+VcPjErxYvzcE7ghYFPE
	yg2JaV+h0TV9D6OxoT7lp6000dEA8g+ruuYod3u0OvPs2mWOf/3mpkcrKpcShIpsQ346hZ4aK4gPJ
	AdLA8D7lejucGBnSAYtQvuR0vWvcnVKB9AI1cJ1LIgIZ1+f2ffISGpMltDGYhCN4BLOF/tzZXYEov
	yl3bwNaljPe7NPDPDydnB9G8w6N3V9MaXBRvv0ipspBxz7OkymphVIfA2ycMHvBJny2ILGkYmH+Jw
	fOukjkHA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woNg1-0000000AzL0-3X7z;
	Mon, 27 Jul 2026 15:55:37 +0000
Date: Mon, 27 Jul 2026 16:55:37 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jane Chu <jane.chu@oracle.com>, linux-mm@kvack.org
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Christian Brauner <christian@brauner.io>,
	Jiaqi Yan <jiaqiyan@google.com>
Subject: Re: [PATCH v5 11/12] filemap: Add support for authoritative mappings
Message-ID: <amd_eb908Co9JeyH@casper.infradead.org>
References: <20260725160042.1557264-1-willy@infradead.org>
 <20260725160042.1557264-12-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725160042.1557264-12-willy@infradead.org>

Sashiko:
> --- Patch [11]: [PATCH v5 11/12] filemap: Add support for authoritative mappings ---
> commit 7b270a787d853107f7a64dd3127d799a28d3142e
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> filemap: Add support for authoritative mappings
> 
> An authoritative mapping knows about all the folios in the mapping.
> If read() finds a missing folio, there's no reason to allocate one and
> try to read it because we know it's a zero region of the file.  We can
> just call iov_iter_zero() instead.
> 
> > diff --git a/mm/filemap.c b/mm/filemap.c
> > index 26a5f18121f90..5a8cc20e624e4 100644
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -2697,6 +2697,8 @@ static int filemap_get_pages(struct kiocb *iocb, size_t count,
> >  	if (!folio_batch_count(fbatch)) {
> >  		DEFINE_READAHEAD(ractl, filp, &filp->f_ra, mapping, index);
> >  
> > +		if (mapping_is_authoritative(mapping))
> > +			return 0;
> 
> Does returning 0 here cause an infinite loop in filemap_splice_read()?

As before, hugetlb doesn't use splice_read() so adding support would be
dead untestable code.  We'll add support here when we need it.

> > @@ -2853,6 +2855,22 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> >  			goto put_folios;
> >  		end_offset = min_t(loff_t, isize, iocb->ki_pos + iter->count);
> >  
> > +		if (!folio_batch_count(&fbatch)) {
> > +			size_t fsize = mapping_min_folio_nrbytes(mapping);
> > +			size_t offset = iocb->ki_pos & (fsize - 1);
> > +			size_t bytes = min_t(loff_t, end_offset - iocb->ki_pos,
> > +					     fsize - offset);
> > +			size_t copied = iov_iter_zero(bytes, iter);
> > +
> > +			already_read += copied;
> > +			iocb->ki_pos += copied;
> > +			last_pos = iocb->ki_pos;
> > +
> > +			if (copied < bytes)
> > +				error = -EFAULT;
> > +			continue;
> > +		}
> 
> Should filemap_fault() also be updated to handle authoritative mappings?

Eventually, if hugetlbfs is ever converted to use filemap_fault().
As above, it'd be dead code.


That's it for interesting Sashiko reviews.  I've omitted some which
are suplicates, either within this patch series or have been reported
against previous patch series.  Feels like we're close!
