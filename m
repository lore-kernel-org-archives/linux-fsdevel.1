Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FF13D9670;
	Thu, 11 Jun 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186399; cv=none; b=tmiqHxpu8Tq7aO45NLrYA73eyS9qPlD2s70chaHkiZnEE2Wqhux/MVJpxDZN+LoYPcPyqvUVwvtx7HkGxHKjxS0YBqXPlXpVOZBIkDS4UzfGyzKtfhCuKB36o99E/s8Ggf5M8kKazRTmzf0q3UA6EuYDQIcfS2AbA3sTie6HNy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186399; c=relaxed/simple;
	bh=DEeQMErtdWw/Pi85VicRCKB0keWFNrVuVkKidiLvWQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un7bu9aYoDk916zJMW33JCMitgJkdYaVL79uG0VB35AiA4Ee3G2U1jq98J3YQVp2kDLth4omW4lO8j617J8EBYVtQs11iEIhtfdz8TBvO4P88r390PphkNQzwnHLxkKIHtcXWVcuXiVyG0rEZOTQeOSrYzMOt5WUYwTR44+o9nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PjKu1KWB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PjKu1KWB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=CUxPEqooOCnvy8vKSlOOoS0NIVVGGJbXo27C3roXzDQ=; b=PjKu1KWBNt2xwOToKxdQY7e+Ez
	M8XDwHokFUZ+SfiCkxoQjF1AJYhYZSZCfOaPl3zBnPPjbS/ALDUI/JUeBB5FTEkfrWy1HZFPCGZZV
	RsSBm+kgrRC7qQcGqMxIoZNlEvXHD3ro/K+NByZptmx3D4gn+V/OiUYlaaY2ZwY3eS/E9wXTaENwa
	CoZVcQuhtbroSFD9KXKlLvp9mfP4p1PsaICVR5MDRQjtslxA1D4LheA1BmCrbcQfIVDpkk46q68/2
	qsfSxLeUJ8+Yunvq1mY+ZsHgrvPuJTV3GgfAjwc7tOdWvSVBJr/rNSNlEaHd4R/J1jutv5CJGmPys
	224BouNw==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXfwp-00000001zqQ-1E1q;
	Thu, 11 Jun 2026 13:59:55 +0000
Date: Thu, 11 Jun 2026 14:59:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Nikolay Amiantov <ab@fmap.me>, fuse-devel@lists.sourceforge.net,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
Message-ID: <aiq_W6PD7dZhTYPL@casper.infradead.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>

On Thu, Jun 11, 2026 at 01:36:56PM +0200, Miklos Szeredi wrote:
> Sorry, this got lost in the noise.

Uh, yeah, mea culpa.

> I was thinking of something like the below for fixing the invalidation
> race (untested, whitespace damaged):
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..c9ab0eb35afb 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -2856,6 +2856,14 @@ ssize_t filemap_read(struct kiocb *iocb, struct
> iov_iter *iter,
> 
>                         copied = copy_folio_to_iter(folio, offset, bytes, iter);
> 
> +                       /*
> +                        * Has the folio been truncated?  In that case we could
> +                        * have been copying stale info (including zeroes after
> +                        * EOF) for a distributed fs.
> +                        */
> +                       if (folio->mapping != mapping)
> +                               break;

But we've already advanced the iter, so we need to rewind it too.

			/*
			 * A truncated folio may contain stale data
			 * from a distributed filesystem
			 */
			if (!folio->mapping) {
				iov_iter_revert(iter, bytes);
				break;
			}

