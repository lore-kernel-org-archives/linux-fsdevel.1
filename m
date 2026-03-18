Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE98D2222A9;
	Wed, 18 Mar 2026 14:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843115; cv=none; b=mvK5jsO1ko/Eq1LJZWofROQgUhlUwvA9lDs8v9oYKTquEY0bLfRPKc5AUshCf37kHJDS1Pd2mSh4B1jg5BzFYjuuA2vcCS0F1iGTRo0AnJ3HmZzRmwH8enVfEbbShTKl9svsFy5Z73KEZsm9hJVwUsLoYcwS5ROjWamtbox6Iz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843115; c=relaxed/simple;
	bh=S4gkGw9zUblW31/YD4c0fx34AWa/EmbK3bgDspW+YSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqhDhlYb5T+vL6A01A5Z968MXtTeKvcnYSsjn6ltKo6Ld3mUza4wrehEIV+90StoYLADDFxEPOHJuyeqWyUfH8i+xdKCYCzX6bFZG4rgIvSLEQXtJCCtPKzB86yl/RpPtlhPRTjFHZTd7XfR63cEUDAY0u/znbPX3ok7MexjOhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp05-ext.udag.de (Postfix) with ESMTPA id 02032E0306;
	Wed, 18 Mar 2026 15:03:14 +0100 (CET)
Authentication-Results: smtp05-ext.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Wed, 18 Mar 2026 15:03:13 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
Message-ID: <abqvmS4adTXVxFIW@fedora.fritz.box>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box>
 <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>

On Mon, Mar 16, 2026 at 03:06:02PM -0700, Joanne Koong wrote:
> On Mon, Mar 16, 2026 at 1:02 PM Horst Birthelmer <horst@birthelmer.de> wrote:
> >
> > >
> > > Hi Horst,
> > >
> > > I think these are two different entities. cs->pg is the page that
> > > corresponds to the userspace buffer / pipe while the (large) folio
> > > corresponds to the pages in the page cache. flush_dcache_folio(folio)
> > > and flush_dcache_page(cs->pg) are not interchangeable (I don't think
> > > it's likely either that the pages backing the userspace buffer/pipe
> > > are large folios).
> > >
> > > Thanks,
> > > Joanne
> >
> > Hi Joanne,
> >
> > I feel a bit embarassed ... but you are completely right.
> > I was interested in solving this case:
> >
> >   fuse_uring_args_to_ring() or fuse_uring_args_to_ring_pages()
> >     fuse_copy_init(&cs, true, &iter)  ← cs->write = TRUE
> >     fuse_copy_args(&cs, num_args, args->in_pages, ...)
> >       if (args->in_pages)
> >         fuse_copy_folios(cs, arg->size, 0)
> >           fuse_copy_folio(cs, &ap->folios[i], ...)
> >
> > when we have large folios
> 
> No worries, the naming doesn't make the distinction obvious at all.
> For copying out large folios right now, the copy is still page by page
> due to extracting 1 userspace buffer page at a time (eg the
> iov_iter_get_pages2(... PAGE_SIZE, 1, ...) call in fuse_copy_fill()).
> If we pass in a pages array, iov_iter_getpages2 is able to extract
> multiple pages at a time and save extra overhead with the GUP setup /
> irq save+restore / pagetable walk and the extra req->waitq
> locking/unlocking calls, but when I benchmarked it last year I didn't
> see any noticeable performance improvements from doing this. The extra
> complexity didn't seem worth it. For optimized copying, I think in the
> future high-performance servers will mostly just use fuse-over-iouring
> zero-copy.
> 
> Thanks,
> Joanne
> 

Hi Joanne,

I wonder, would something like this help for large folios?

@@ -856,8 +856,11 @@ void fuse_copy_finish(struct fuse_copy_state *cs)
                cs->currbuf = NULL;
        } else if (cs->pg) {
                if (cs->write) {
+                       struct folio *folio = page_folio(cs->pg);
+
                        flush_dcache_page(cs->pg);
-                       set_page_dirty_lock(cs->pg);
+                       if (!folio_test_dirty(folio))
+                               set_page_dirty_lock(cs->pg);
                }
                put_page(cs->pg);
        }

Do you have seen any problems with spin locks being way too costly while
doing writes?

That was actually why I started looking into this.

Thanks,
Horst
