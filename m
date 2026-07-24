Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DCF3DA5C8
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 16:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784910591; cv=none; b=PzvjHDkVqe7wz+4UIXXnD0zG5Fv9hKY15OrPsmT2FRiVoXPPI/vojTpMYLC4iaZyeOLiBC6iE9gmBwYiWQ5GuQhfnEvd8gDH54mJ+e6K7RGh89CnBM/1omxTZ8RKr4UR7JpmAAU5+ApN1xcqOU33KJHbB4MGgJO7mazIgj2twKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784910591; c=relaxed/simple;
	bh=uT/ypRU3GMRjQvaM8DJt32vG09iCeumT/M0l+Mza+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UvZAid86x0eDCGDFF0QtP5dGunpGW9AJoQnfp2dsa/eOnj5ZnrUhpcliFFtfaqdFyVRjDZq5rqXQI8zzIr+oYqbZD2fU62UXWsbSlFUkR9ng3KObts2C3+/lMrvx/u2ZsniaA6j00X2V7mwjUNTk03/TRimNlCRgBlIMIbrAB4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hZVt3P9Q; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZVt3P9Q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sOZZlCJxNPr51QtdtbTR7W+DtVn2iPlfQzvwzGkEI3E=; b=hZVt3P9QAnETqCWd8fAxY8nSli
	ropuX5BBnaiGoppwSfjNW8v2sVuCaYVW1UmNoII4fsAU4vP4TW8wy8lV8uRSn+fryoFN1KH7T56VH
	tplAO4DN98c1V06e9ZGoXKmIKerzz4OjvkXGUugIqd24z0VfMkIHuHcvRHIFI3tlNenHTJbyor474
	493Nra6c1gtx+cRqzqdtS/+eO1MQwdWNVFLdxWSPyf549lVtmrCxdJNJ2z//ieZHE1MV/qvxXl+dV
	Y6j4lQl6H3Qaor4gm1dywZV1ydxrLBv+Mbh4HpfAcQnWmfbDD6oNZJ/7p8NLCB0n0O48z7feGlroh
	KBpap71w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnImM-00000003ul9-3uU4;
	Fri, 24 Jul 2026 16:29:42 +0000
Date: Fri, 24 Jul 2026 17:29:42 +0100
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
Subject: Re: [PATCH v4 13/14] filemap: Add support for authoritative mappings
Message-ID: <amOS9nXAJDIM5KCA@casper.infradead.org>
References: <20260723143034.175661-1-willy@infradead.org>
 <20260723143034.175661-14-willy@infradead.org>
 <amOPh_oXhrIE44nE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amOPh_oXhrIE44nE@casper.infradead.org>

On Fri, Jul 24, 2026 at 05:15:03PM +0100, Matthew Wilcox wrote:
> Sashiko review identifies only a problem identified in the previous patch.
Er, this should have been the reply to patch 12, not 13.

Sashiko review:
> --- Patch [13]: [PATCH v4 13/14] filemap: Add support for authoritative mappings ---
> commit f97ea9a8250c2693263cf2f409975e439e79ddd4
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> filemap: Add support for authoritative mappings
> 
> An authoritative mapping knows about all the folios in the mapping.
> If read() finds a missing folio, we know it's a zero region of the file
> and can call iov_iter_zero() instead of allocating and trying to read one.
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
> >  		if (iocb->ki_flags & IOCB_NOIO)
> >  			return -EAGAIN;
> 
> Does this early return cause an infinite loop in filemap_splice_read()
> when reading a hole?
> 
> When an AS_AUTHORITATIVE mapping has a hole, filemap_get_pages() now
> returns 0 and leaves fbatch empty. filemap_read() was updated in this patch
> to handle an empty batch, but filemap_splice_read() appears to assume that
> a return value of 0 means progress was made.
> 
> If filemap_splice_read() receives an empty fbatch:
> 
> mm/filemap.c:filemap_splice_read() {
>         ...
>         error = filemap_get_pages(&iocb, len, &fbatch, true);
>         if (error < 0)
>                 break;
> 
>         ...
>         for (i = 0; i < folio_batch_count(&fbatch); i++) {
>                 struct folio *folio = fbatch.folios[i];
>                 // updates to *ppos and len
>         }
> 
>         folio_batch_release(&fbatch);
>     } while (len);
> 
> Since the for loop is skipped, len and *ppos remain unchanged, which
> could cause the outer do-while loop to spin indefinitely.

This is a latent footgun, I guess.  When we come to it, we can move the
code from shmem_file_splice_read() here.
