Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E70E305E10;
	Fri,  3 Jul 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783096378; cv=none; b=uERaFn4Ofd7g56j9AsLrHjm4Bmod227PZeFrAAHegPD3fvdmi22NRLbZHkphPwxWE2M2Ee1g9nels5BoW3FcIW3vAs+mdcdbPirOTv2baax0IyxgBelXPFVOp90QLOxAz75RuHWJVKM0AMky8Eh9JrxiFOEACVJnFJDOK+bZvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783096378; c=relaxed/simple;
	bh=i6TVWHWqQQudxIMe0+xzj3AFPAlFnTOKf5VgUwJrtu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KR19RlHmyjnLD5pBLHOuYRfrghQTAE+IMqqMsyaUy/qWfToBiSwjqt1jO4gvGBSHJmu02tEd5TbYPRIy1fkMRvwVYAMNe0b/eseaiHkS9yrEgbo2wErL1inIsCahkBzV0tICn/8ss2q1Jc0u1ZU/pniM7XxoxFLhw7+CgPtSlpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=cog6V7xo; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="cog6V7xo"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DF3FA11DD;
	Fri,  3 Jul 2026 18:32:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783096327;
	bh=i6TVWHWqQQudxIMe0+xzj3AFPAlFnTOKf5VgUwJrtu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cog6V7xozYBDGu5dRA4fDh2oxyhep48ghjhVee8mCVA3DzavrXI16kNBD2bt2nnyp
	 obDQJb7dZtUpmR5RDV1jE69ggoiA9FgVvHentCXJaq6cBfLcCSN2TuyT98JzPp+z/5
	 HADOtt1f6FNs1N+SAaH7JskENQrGq697BYYmO2mE=
Date: Fri, 3 Jul 2026 19:32:51 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <20260703163251.GB3734786@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akez23ZhLRSGMFQ1@lucifer>

On Fri, Jul 03, 2026 at 02:12:40PM +0100, Lorenzo Stoakes wrote:
> On Fri, Jul 03, 2026 at 09:05:58AM +0200, David Hildenbrand (Arm) wrote:
> > On 7/2/26 23:17, Boris Burkov wrote:
> > > On Thu, Jul 02, 2026 at 05:50:15PM +0100, Lorenzo Stoakes wrote:
> > >> On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
> > >>>
> > >>> Do we need a tag for this though?
> > >>>
> > >>> This seems like the kind of information that we would always require in
> > >>> the cover letter of a series (or the little place in an individual
> > >>> patch for comments that don't get merged). That would also allow you to
> > >>> convey a lot more nuance about how it was used.
> > >>>
> > >>> ISTM asking people to disclose LLM usage in a cover letter would give
> > >>> everyone what they want: Information about whether and possibly how an
> > >>> LLM was used, and it also wouldn't clutter up the changelogs with these
> > >>> tags.
> > >>
> > >> It's much much clearer and easier to just have a standardised tag for that.
> > >>
> > >> You can see that (and grep for that) immediately, vague paragraphs not so much.
> > >>
> > >
> > > At the risk of being pedantic on a point where I think the document is
> > > kind of lacking:
> > >
> > > What level of assistance crosses the bar for an "Assisted-by: LLM" tag?
> > >
> > > Some sample levels of assistance to illustrate the point:
> > >
> > > 1. I used an llm to one-shot vibe-code a patch
> > > 2. I used an llm to write a patch but carefully reviewed every line
> > > 3. I used an llm to explore the design space for a patch but wrote it
> > > manually
> > > 4. I used an llm to debug or reproduce a kernel issue but then wrote the
> > > fix manually after fully understanding the defect
> > > 5. I used an llm to review a patch I wrote
> > > 6. I used an llm to research some chunk of code while writing a patch
> > > 7. I used Google while writing a patch and learned something valuable
> > > from the AI overview at the top
> > >
> > > I personally would 100% use the tag for 1 or 2, and have already done
> > > so. I have not been doing it for 3-5, as I think that will basically
> > > make every patch llm-assisted to the point of the distinction being
> > > meaningless. If we should be doing it for 3-5 (or some subset thereof)
> > > then my mistake and I will certainly start doing so. I would hope most
> > > people agree 6-7 and similar need no tag.
> 
> I personally think 1-2 are the only relevant cases.
> 
> > >
> > > Similar questions abound if you use an llm to help with writing the
> > > English text in the patch or emails.
> > >
> > > I have a feeling that this ambiguity is part of the reason we aren't all
> > > agreeing on the value of the tag?
> >
> > Yes, I raised something similar as reply to Christian's RFC [1], where I said
> > that for me the information *how* it was used is much more important:
> >
> > "
> > Assisted-by: LLM # translate commit message
> > Assisted-by: LLM # generate some test cases
> > Assisted-by: LLM # cleanup logic
> > Assisted-by: LLM # everything and I have no clue what any in here does
> > "
> 
> Yup, and we don't need complicated rules for that just 'document what you used
> it for and give a sense of how much'.
> 
> It's fuzzy but useful.
> 
> >
> > That tag is it stands is pretty useless, really.
> 
> Not to go over it all again but I disagree, even as it stands, it allows us to
> engage in conversation about the LLM usage if admitted, and to point those who
> are misbehaving at the rules if not.
> 
> And it is a clear way to get the boolean 'is this person saying they used an
> LLM'.
> 
> But I agree with you it'd be MUCH more useful if we did the above.
> 
> I wonder if we could get consensus on adding a section to the doc saying that
> it'd be _useful_ to add a comment explaining _what_ you did, and explaining the
> concept with some examples?

I'd support a patch that replaces

Assisted-by: Claude:claude-3-opus coccinelle sparse

with

Assisted-by: LLM # generate some test cases

and rewrites the Attribution section of
Documentation/process/coding-assistants.rst accordingly.

I think most people in this mail thread have expressed that how
generative AI was used is the most important information, and several
people (including myself) have expressed a desire to stop the free
advertising. Unless I missed something, I don't think anyone has
expressed an interest in keeping the agent name and model.

> I can't imagine anybody would disagree with that, and that would get us positive
> forward progress.
> 
> Then later we could debate the details further?
> 
> > I assume most people only really use it for something in-between 1 and 2, but
> > *who knows*.
> >
> > [1] https://lore.kernel.org/r/5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org

-- 
Regards,

Laurent Pinchart
