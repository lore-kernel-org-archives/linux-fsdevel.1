Received: from smtp01-ext2.udag.de (smtp01-ext2.udag.de [62.146.106.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A938E122;
	Mon, 16 Mar 2026 20:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.146.106.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691913; cv=none; b=GMo8BC72sXsYA2HlnfLhhiIk0CcVsAXBI/d3sq3MfM0C1YuciA1X7P+6KvZJHN+BT+w0tG5kNjgCPlKY4PJIF855UQ0js/MlkEEJpD9syYdxqAVvoZZyVyRX1uyC5iCUrsPqAIZPpg76wf2zv3lO4JaI7tJUKYuodmLukRlkWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691913; c=relaxed/simple;
	bh=0QXcZN4r3+iFBRtpsbBT9OFAF704u4rdFjEwI2LHFig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LJRtertsMwvHxsphovzCkfXCzqh8+nlQDQu5cEk6h+REXeFdwrWSlCEVJTis0wmg42wOTE5GRiiSsdG9EFF+lxcQ7mm29igf+jvWvQEaof+V/L+lcVKiw77Ul66uPFg0Ll/9pLi+AL1ibDcz7QfNE8lrZwgTwMLgKYG+Fc+Hwz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de; spf=pass smtp.mailfrom=birthelmer.de; arc=none smtp.client-ip=62.146.106.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=birthelmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birthelmer.de
Received: from localhost (200-143-067-156.ip-addr.inexio.net [156.67.143.200])
	by smtp01-ext2.udag.de (Postfix) with ESMTPA id A459BE0296;
	Mon, 16 Mar 2026 21:02:04 +0100 (CET)
Authentication-Results: smtp01-ext2.udag.de;
	auth=pass smtp.auth=birthelmercom-0001 smtp.mailfrom=horst@birthelmer.de
Date: Mon, 16 Mar 2026 21:02:03 +0100
From: Horst Birthelmer <horst@birthelmer.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Subject: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty
 until the end
Message-ID: <abhg4tbxDhYO_iHV@fedora.fritz.box>
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>

On Mon, Mar 16, 2026 at 10:29:52AM -0700, Joanne Koong wrote:
> On Mon, Mar 16, 2026 at 8:16 AM Horst Birthelmer <horst@birthelmer.com> wrote:
> >
> > From: Horst Birthelmer <hbirthelmer@ddn.com>
> >
> > Doing set_page_dirty_lock() for every page is inefficient
> > for large folios.
> > When copying a folio (and with large folios enabled,
> > this can be many pages) we can delay the marking dirty
> > and flush_dcache_page() until the whole folio is handled
> > and do it once per folio instead of once per page.
> >
> > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > ---
> > Currently when doing a folio copy
> > flush_dcache_page(cs->pg) and set_page_dirty_lock(cs->pg)
> > are called for every page.
> >
> > We can do this at the end for the whole folio.
> 
> Hi Horst,
> 
> I think these are two different entities. cs->pg is the page that
> corresponds to the userspace buffer / pipe while the (large) folio
> corresponds to the pages in the page cache. flush_dcache_folio(folio)
> and flush_dcache_page(cs->pg) are not interchangeable (I don't think
> it's likely either that the pages backing the userspace buffer/pipe
> are large folios).
> 
> Thanks,
> Joanne

Hi Joanne,

I feel a bit embarassed ... but you are completely right.
I was interested in solving this case:

  fuse_uring_args_to_ring() or fuse_uring_args_to_ring_pages()
    fuse_copy_init(&cs, true, &iter)  ← cs->write = TRUE
    fuse_copy_args(&cs, num_args, args->in_pages, ...)
      if (args->in_pages)
        fuse_copy_folios(cs, arg->size, 0)
          fuse_copy_folio(cs, &ap->folios[i], ...)

when we have large folios

But those are not the same.

Thanks,
Horst
