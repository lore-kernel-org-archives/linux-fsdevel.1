Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D6632860B;
	Tue,  7 Jul 2026 09:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783416018; cv=none; b=DlvsU/4fzg4o75rmyevGNjLy/O8JTq1Ekisex8fbr3mP1vHzZn5y/0UQXJ6fYJecT3M+Sy99682l/FZk9edSjQvh/vWyGZ4TRs1fxGzJTMwzxfE8RawADLydJIbwo5r9lPnkYm3Z7h0I9nZWkbfpS0z6dhF8oZ/LIBTkH1Iy0u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783416018; c=relaxed/simple;
	bh=XfW5DENqOA3L5d9hgUctKtHR0rM0RosCcOlLerb+5rI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3KTMBbYKG+DyF9dgR9XYk5ij3qx4p5XVzDDFz3T84bx4EOqHlYJFExWQ3iNrpiecn3gYFVNAwHm+lu75t4NAJ8/iSlT2SAqdbTGISOTkTeYyF/f73Mg3REc3g5y1FRwe38sL3b3Hvt/CTZ6oDTj3wiF5CNe/sCzt3P7xuNgfkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubv1xlhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubv1xlhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456D91F000E9;
	Tue,  7 Jul 2026 09:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783416017;
	bh=XfW5DENqOA3L5d9hgUctKtHR0rM0RosCcOlLerb+5rI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ubv1xlhpcHWZLUuL6aG2ncV9JwQM74D/Key5E7JIQ4AiUqr7MaQSx4WMIv+7ilKWU
	 /lACjXOA6DuS87yBG6c9VI4Tfvx9CB5N/BXTUSGlN8Qbe5GNhcwBgOosScD3Yllaqz
	 LViD5QICoOwOa+CFRX0Xyq18HEyjoeD6uQi7qNUfk50gwGOh0uMzDAjIPHz58AgmY/
	 SlIF0ZaPMfEyd9jQxbg7HI98TjfywUpMOQiKS2PCeeWmn0LPIYsjM9eOHBvHXZil95
	 UmMPQuvMoimGh8eAhNsVgMrwp5fzisUstmUYs+D4lnDYnnXM76NE7vf+a0wQ/izBVm
	 9lL2gxhxr/06Q==
Date: Tue, 7 Jul 2026 10:20:04 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akzETpsps4TMfqpC@lucifer>
References: <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>

On Fri, Jul 03, 2026 at 08:22:20PM +0200, David Hildenbrand (Arm) wrote:
> On 7/3/26 18:32, Laurent Pinchart wrote:
> > On Fri, Jul 03, 2026 at 02:12:40PM +0100, Lorenzo Stoakes wrote:
> >> On Fri, Jul 03, 2026 at 09:05:58AM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> I personally think 1-2 are the only relevant cases.
> >>
> >>>
> >>> Yes, I raised something similar as reply to Christian's RFC [1], where I said
> >>> that for me the information *how* it was used is much more important:
> >>>
> >>> "
> >>> Assisted-by: LLM # translate commit message
> >>> Assisted-by: LLM # generate some test cases
> >>> Assisted-by: LLM # cleanup logic
> >>> Assisted-by: LLM # everything and I have no clue what any in here does
> >>> "
> >>
> >> Yup, and we don't need complicated rules for that just 'document what you used
> >> it for and give a sense of how much'.
> >>
> >> It's fuzzy but useful.
> >>
> >>>
> >>> That tag is it stands is pretty useless, really.
> >>
> >> Not to go over it all again but I disagree, even as it stands, it allows us to
> >> engage in conversation about the LLM usage if admitted, and to point those who
> >> are misbehaving at the rules if not.
> >>
> >> And it is a clear way to get the boolean 'is this person saying they used an
> >> LLM'.
> >>
> >> But I agree with you it'd be MUCH more useful if we did the above.
> >>
> >> I wonder if we could get consensus on adding a section to the doc saying that
> >> it'd be _useful_ to add a comment explaining _what_ you did, and explaining the
> >> concept with some examples?
> >
> > I'd support a patch that replaces
> >
> > Assisted-by: Claude:claude-3-opus coccinelle sparse
> >
> > with
> >
> > Assisted-by: LLM # generate some test cases
> >
> > and rewrites the Attribution section of
> > Documentation/process/coding-assistants.rst accordingly.
> >
> > I think most people in this mail thread have expressed that how
> > generative AI was used is the most important information, and several
> > people (including myself) have expressed a desire to stop the free
> > advertising. Unless I missed something, I don't think anyone has
> > expressed an interest in keeping the agent name and model.
>
> Yes, that's something I would enjoy seeing. Who reading along has a problem with
> that? (assuming that the tag must stay)

I think the silence suggests nobody :)

What we could do is send a patch to simply add a section on adding a comment
explaining _what_ used an LLM and strongly suggesting it would be helpful to do
so.

That should hopefully be uncontroversial, then later (or alongside that?) we
could submit an RFC for making the language move to 'you MUST do this', as that
will probably be the more controversial bit.

I don't see any reason why we can't just send the softer version right away.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo
