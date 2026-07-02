Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEA349CF2;
	Thu,  2 Jul 2026 16:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783011028; cv=none; b=XD/KvlQg2/nrW/xPu3dh0YOI48U9ynyVPtnZaoAcDh8GKld1acwZfXbETBa5LzfHUQgjb/2/HteaonV+ZA427zD62gqCrTgjdD/il5sblTtP3nWvPA3swyl6tneoYoKtkzxAv1w/tUcGC9p1nOWwwkggJG+UmzIia9pyzkbnKuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783011028; c=relaxed/simple;
	bh=h4chzH7MM2I+Nv1bVeEEsP5ZVrAG/C782EzN9I6JUxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kSGF7wgm9a/BAKrwAStE8/ERgik4RBpkd9wgFnpcixa3BeWTRH0fD20y27tmpo8mBYu3SUGe8VbvYhKF7rtNEBx8trNImmGHX2aAEVSEkucGQoqVklB6PI49CBKpRCf4WB9nq6zjTq/e1TQzdB2dgTZZlPZqytOI0p5aVjGI05Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj+S+1n+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj+S+1n+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672F81F000E9;
	Thu,  2 Jul 2026 16:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783011027;
	bh=VxwP5sbJnHA5aX0cWSiGCuHUNdENo3EBGO3dln8kb20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pj+S+1n+cHOxdLDHnr/zFJ11PPk5uiN9qE6D6DEJsmOuRRZ0Ucv2vdt46rWtzd4/S
	 5eSlxBHqzXguL3/MIE4TpCNzEAXaWv2cNmXIzmS5ZyHzKCzTAvX+TDD4hPrVdfwDBm
	 epj6IKDP7iANNPhNg9Vcy50nuzo2MwqkwqYwflq688M6c1kinTB8HZ8GT+zCrJYEtu
	 o1vsun5lCe50FNf2Z9oRQ5bDVHY/LjBchQgfYWKVsPwgnyY3P0QVz5Ge42tCY2qpc2
	 iMBcbTReE2KgvOJs9t05kiwc/6dAIitF+MEvlau4g1i3SUlEEOdM5RVV17F/ELoDVi
	 b0OCOcAljsj5Q==
Date: Thu, 2 Jul 2026 17:50:15 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akaWnQ5Pkg_676B-@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>

On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
> On Thu, 2026-07-02 at 18:19 +0200, Greg KH wrote:
> > On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > > We've had this requirement in place in the Documentation for several
> > > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > > is quite low.
> > > > > >
> > > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > >
> > > > > Then let's move to get people to follow it.
> > > > >
> > > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > >
> > > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > > not reporting that, I can ask for them to properly attribute it and if
> > > > > they lie, well, that's on them.
> > > > >
> > > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > >
> > > > > We want to know if a LLM is being used.
> > > >
> > > > But why? What do you intend to do with this information?
> > > >
> > > > Do you mean to use it as an indicator that the patch should receive
> > > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > > it to generate some sort of statistics at a later time?
> > >
> > > I use the information to decide how to review the patch, and what level
> > > of priority to give it. For that usage I don't need a tag, but I need
> > > the information in some human-readable form at patch submission time.
> >
> > Same here.  I don't care about stats, I care about "how do I review this
> > patch" and this gives me that signal that I need if faced with a
> > llm-helped patch.
> >
> >
>
> Do we need a tag for this though?
>
> This seems like the kind of information that we would always require in
> the cover letter of a series (or the little place in an individual
> patch for comments that don't get merged). That would also allow you to
> convey a lot more nuance about how it was used.
>
> ISTM asking people to disclose LLM usage in a cover letter would give
> everyone what they want: Information about whether and possibly how an
> LLM was used, and it also wouldn't clutter up the changelogs with these
> tags.

It's much much clearer and easier to just have a standardised tag for that.

You can see that (and grep for that) immediately, vague paragraphs not so much.

> --
> Jeff Layton <jlayton@kernel.org>

Thanks, Lroenzo
