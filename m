Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3C3FBA7;
	Thu, 11 Jun 2026 15:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781190624; cv=none; b=InjE4BUhrVnOM6cAHZROGz6RFOK9P5+StwdIcWRWQN/fIZjy/va6JUjhrSedMJ+ER4zCtQMYUAkEYbP7VF2vo4kM/1IvjPO4+RcbmuKlW5NT7SQ4DuGquTBjuqrNw9nGa3vflSm8DIbE4utmifKQ1pWPWzd5KPo28UeWTf2Rcws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781190624; c=relaxed/simple;
	bh=D9KsewpHZCi4xCc7DVrJ6r275RneJRL2/4tWz/TrQrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mtJpxMFMamfKY+F0NqE2Uk9DtHY85qqL63RIW65MclEUVbbF960XmHdr2k6uMCCRtmrwB0FA43CaQiMIyGIWR5ecjxEoIoWMHn6RaHNQO4bG3Ln2EUrl/lq6APogMt5d6vRC9e827c9SARGaOby3p5XPI4rIB7MYLMhP1TILPnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h0YRGmiU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0YRGmiU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3HxeAVNS/UOxAsIyrZo4OUMh7E2TC38v0xDmizeD57U=; b=h0YRGmiU0nMFVgeJF612l0xWmr
	56qRbqJVEvjmESKxg2obet4KEItoYlDQT3fzZwtx0udB+3OnAnZIDm9/9Q2aKXRMYUE3GKA45paTW
	S79a40768cpnscmGks123yWlU1EGpvgcX3W+a9alFL4l5nz5GXooCe67Agi8MdNJ9GCLSLD+VvSx1
	Jlc3D00KOZf9yQ3CGChYAHrUXU46ypU8lsl506EIPgWdW7d4oQCCYHxCnruc4ivNNqM5gYS6YX28Z
	wAtIcLBOdaHEMapWera8mTm91G0Zc+Gyk8kAVX0DIv2CBFiOVMIrF4YfAZrjW+aphjtopmZf80+D9
	QMUWZOtQ==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXh2w-0000000284F-1uLI;
	Thu, 11 Jun 2026 15:10:18 +0000
Date: Thu, 11 Jun 2026 16:10:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Nikolay Amiantov <ab@fmap.me>, fuse-devel@lists.sourceforge.net,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Amir Goldstein <amir73il@gmail.com>, fuse-devel@lists.linux.dev,
	linux-mm <linux-mm@kvack.org>
Subject: Re: [fuse-devel] Debugging a stale kernel cache during file growth
Message-ID: <airP2mGxFu8yw6Ho@casper.infradead.org>
References: <898a4e10-6193-4671-b3b1-7c7bc562a671@fmap.me>
 <CAOQ4uxjoS-PvnZ2poh0bx0C6ocTYwuEpfV0q5md15SjS620OMg@mail.gmail.com>
 <CAJfpegvxF7F+XKFKokSH4eOgCA0V2RNm6B54MS9nr9wG=U66OA@mail.gmail.com>
 <59ab54f6-680e-456e-91f4-0a26889844ef@fmap.me>
 <aeFuarTL7xBbut0F@casper.infradead.org>
 <CAJfpegtAeyMRENdneJkJrMKu8Uwnyk9LYBThjvTrFjHmPr6O_g@mail.gmail.com>
 <9fe5ff50-4c1c-49ee-a8c2-4cacc3c6781d@fmap.me>
 <CAJfpegum=LJTCGqMUfLHehQE19kgdZbE2eXS_002fdpX_sd6jw@mail.gmail.com>
 <aiq_W6PD7dZhTYPL@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiq_W6PD7dZhTYPL@casper.infradead.org>

On Thu, Jun 11, 2026 at 02:59:55PM +0100, Matthew Wilcox wrote:
> >                         copied = copy_folio_to_iter(folio, offset, bytes, iter);
> > 
> > +                       /*
> > +                        * Has the folio been truncated?  In that case we could
> > +                        * have been copying stale info (including zeroes after
> > +                        * EOF) for a distributed fs.
> > +                        */
> > +                       if (folio->mapping != mapping)
> > +                               break;
> 
> But we've already advanced the iter, so we need to rewind it too.
> 
> 			/*
> 			 * A truncated folio may contain stale data
> 			 * from a distributed filesystem
> 			 */
> 			if (!folio->mapping) {
> 				iov_iter_revert(iter, bytes);

s/bytes/copied/ of course.  sorry.

