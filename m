Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9323343894
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 14:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781015691; cv=none; b=Ya0rD/qGVFHFQV714dvxkqHEDSPTYolzYm38hOr/x22hYbyo1BV+juB5YDYmm/ldNMb9S3EzXZWS+bwstJw22QkGnhuoM0U+USnnAzDiiG/LOUCBg6wuO3EA1SBQU4B4KYut35gYVRQULwAJ/l0+1noKt8r1nT45goFVjIn+Khw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781015691; c=relaxed/simple;
	bh=oWymmpEgWzRNNEf6xrKMqFRkAZ7Ibb8c9FuWX6uFmxI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=US07XX6X/VlgZyk7d1qEydoxBaXsCd9klQp8qMySlDRjGF69Hptimy1g5oZY/blA7D8uCRd73X8lLc3/u8BSEfTjNmd6yhO9Hf1JCnDoXQmmooUuDKf8M/c2v0ZgMdhjGSRh4VVcCbBeG5SZLi7A8v/tSet9Osuma9oQdlP5OOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dnczqqpE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dnczqqpE"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=h4bIh5NbfhAERUp7/8LJ4i3CTv6SkjIH+Edzb6aQu9c=; b=dnczqqpEaE1tHQHEWp9Y0Om4fo
	dtX5XBMI8DrHEgRIH8wsvtz+5FjF0OVS+EQD6Fp+ai7XSPP9dZJKDbEJIKtAZHHtvEn+5Ce11/Hyi
	TlOoFTe6C7GBSoGV3K6bzzUC9iubFcKq+P+pW0zbc5VMSu7JO6LEZFOPoFb5gGLjpkUTD5ulEdHy3
	YJOn3yg/pEK3UCiL1xBouFG4SD1sz9/qDmE82ASYFJoZWP5qwyodQDiNcYmcZmSMXmZvhF1iVfVba
	OrmEGQksDp555/WZ/exocpRJEXUVLeZ9qN4yov8OQyc3qZiiI0LNl1l62ToK57Nn7kBsoeiIRCxZs
	vnsqbMYA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWxXT-0000000FrLz-0Ck9;
	Tue, 09 Jun 2026 14:34:47 +0000
Date: Tue, 9 Jun 2026 15:34:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 2/6] ntfs: Remove use of __folio_index in
 handle_bounds_compressed_page()
Message-ID: <aigkhkcXuQx7yfPu@casper.infradead.org>
References: <20260608210618.3437216-3-willy@infradead.org>
 <20260609131724.3114804-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609131724.3114804-1-usama.arif@linux.dev>

[Editing your response to patch 3 into here]

On Tue, Jun 09, 2026 at 06:17:23AM -0700, Usama Arif wrote:
> On Mon,  8 Jun 2026 22:06:12 +0100 "Matthew Wilcox (Oracle)" <willy@infradead.org> wrote:
> 
> > Nobody is supposed to use page->__folio_index.  Use page_offset()
> > instead, and simplify by working exclusively in loff_t instead of mixing
> > up loff_t and pgoff_t.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  fs/ntfs/compress.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> > index c904858dff3d..b279f38636d6 100644
> > --- a/fs/ntfs/compress.c
> > +++ b/fs/ntfs/compress.c
> > @@ -105,13 +105,14 @@ void free_compression_buffers(void)
> >  static inline void handle_bounds_compressed_page(struct page *page,
> >  		const loff_t i_size, const s64 initialized_size)
> >  {
> > -	if ((page->__folio_index >= (initialized_size >> PAGE_SHIFT)) &&
> > -			(initialized_size < i_size)) {
> > +	loff_t pos = page_offset(page);
> > +
> > +	if ((pos >= initialized_size) && (initialized_size < i_size)) {
> >  		u8 *kp = page_address(page);
> >  		unsigned int kp_ofs;
> >  
> >  		ntfs_debug("Zeroing page region outside initialized size.");
> > -		if (((s64)page->__folio_index << PAGE_SHIFT) >= initialized_size) {
> > +		if (pos >= initialized_size) {
> 
> Is the else branch over here unreacheable as the outer if statement
> already had if ((pos >= initialized_size) &&...

Are you saying my transformation is non-equivalent (and I have
introduced a bug), or are you noting that this is a pre-existing bug?

If the latter, is the error that the else branch exists, or did the
author intend to write a different test?
