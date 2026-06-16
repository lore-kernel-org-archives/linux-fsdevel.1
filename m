Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522A32C0261;
	Tue, 16 Jun 2026 18:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781635698; cv=none; b=ZwVJ7sl3oWaeBQsLqEQh+BC0lSyXIEevoG9cYHQyq+jWc6hL4eAFx9N0ELPXfnv1CKnrH8jXzYv/3O+gQKzN1Ih1mLwnSKd+jbjJjKVv763UPV/2iOpyr0h0XySYxn6jJa82QsQrSYWgqq/11vYsK/hqmbjthvzIBal/KgCb24E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781635698; c=relaxed/simple;
	bh=GiNFy7dQXeYvjClhAV+AHb0daCA+Am+nsxaNpxW00wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usAZYpGmepoimm6HbrnOUGUO6WLBJPMqsTJmh4Pi35BbcrxAlZ+FHLyTQc9QTXGp7evqstSQ2MDuyn8Wfl8w+O9exUmoT8+Od+ewayGuK4KHVfWWGCnjU7V0EHN/uM5artlfsrrTMW17H85Hf+zcHYBHeBPD6AcanoU3hqNrTjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CnlVf9DH; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CnlVf9DH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=z9OG7K87BoFvZjDcA9yWcWHa12S87h7aKhKwnJ2yb0E=; b=CnlVf9DHztA04KJnmyK2gfrmNi
	FqyDHroSxRdXs5mzB8YD0+4Ekyu17y5gjOVGwUkwELv4XAJ4JbEkOeIN5kweKXzYHQWfsHTjqDJKi
	CkQrGUYOZCY25vjWlVhe/jEIzfrQw/CCmUUXyK5KvMvA7kOl0KUF5n+tBWSUtBOYYYNMe75LL0+b5
	9Jf+fQ7YLXenEgB0fX2QDUDwttJSgnIV3Bhhs2/05z/tFIG0UbiPyab31byadrCRc49IaO64gkTWp
	91z4pL1FfR0goS1QI0rnYww/BAGCTe+BNq3gMtVhTA4KE7Lcp2BSkPjue6Y2uPVPeuitUa5vnfolw
	uAgehXDA==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZYpa-0000000BIG1-3UJq;
	Tue, 16 Jun 2026 18:48:14 +0000
Date: Tue, 16 Jun 2026 19:48:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nikolay Amiantov <ab@fmap.me>
Cc: Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.sourceforge.net,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
Message-ID: <ajGabryrn7A2VUAq@casper.infradead.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
 <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D4988E64-C9AB-404C-AA95-E5F4725BB646@fmap.me>

On Wed, Jun 17, 2026 at 02:00:04AM +0800, Nikolay Amiantov wrote:
> > +++ b/mm/filemap.c
> > @@ -2856,6 +2856,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct
> > iov_iter *iter,
> > 
> >                          copied = copy_folio_to_iter(folio, offset, bytes, iter);
> > 
> > +                       /*
> > +                        * Has the folio been truncated?  In that case we could
> > +                        * have been copying stale info (including zeroes after
> > +                        * EOF) for a distributed fs.
> > +                        */
> > +                       if (folio->mapping != mapping)
> > +                               break;
> > +
> >                          already_read += copied;
> >                          iocb->ki_pos += copied;
> >                          last_pos = iocb->ki_pos;
> 
> I may be missing something, but doesn't this still leave a brief race window when i_size is already updated, but the mapping is not yet invalidated? It's invalidated by invalidate_inode_pages2, correct?

The patches you posted earlier in the thread invalidated the page cache
before setting i_size?
