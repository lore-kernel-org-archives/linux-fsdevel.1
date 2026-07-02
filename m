Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963D304BA3;
	Thu,  2 Jul 2026 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004881; cv=none; b=arrPexDMl6Hr77yFfpuBlLHOhe4OARqIqiG60O4JeB9NlLk7jNEtdja/TPN5a4CkvI5X++3obaKp8+amn6X/FbklFa2RcVWS2Y+69ZMWtHDvHI2aF69X4q+VnVtLvcnuEweAKy9uOGlcLiLxDQ5z7jTHvC6aiZc5CqYu5CliJls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004881; c=relaxed/simple;
	bh=y4zASIOpDcdHNpVyvC0V7pZR6lTxoHxe/cShlwJcbxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LcFPeWbWMOKmwWwh5Uenr2nylgsnuzemBzLu98pEHcD7/8ifEGKSsKZM2EGH8leujS5ZYkDOy1v6JtZ/j3rEiFUM7x3y2Clz/w8BJhH80Dy7WlDhbxAsKLNZwFnvsfaW5l0CBPh0NdelwbS1wLT3ioF5OY7lZDYyB3m6gbHKUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a4Gnl3tS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a4Gnl3tS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDA51F000E9;
	Thu,  2 Jul 2026 15:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004880;
	bh=SMdTlZSyfYXIySwapoErHbyj0uzKe07jFauf8iJA+Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=a4Gnl3tStGH7RXQ//+xF/BSggNAlae1CK+r+l2EfL4WbA5ScMFREkIkCRJUmtOA29
	 FU0Nugw6scm8cddkC3g7Km5GNuRDDPb8TPuNzmv0rVcZpSdP+YmNhtydo6qq22qlya
	 0aRi4YiBevV/DRw6I/LekVEZEqWo637T58bz1zTm8VWXa494/26F5kEsBqE2YKPeE8
	 OLMb6lDdwuvw54/qbWz5swglGC2O06Glcen8UycBue3SbWQI/scubg8jsbHGvH+y3O
	 gpRjo41H3rQAijyjyCVzXMbzqjpvJ0UhdAFw4TbEhBjixetkTYNhs9K9haZu69AcTI
	 8HgJHw9AjIj2w==
Date: Thu, 2 Jul 2026 16:07:48 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Carlos Maiolino <cem@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akZ-NTnx9EiNZqu6@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <20260702145322.GG3534761@killaraus.ideasonboard.com>
 <8a1cbee162ce85bb34b279de60726bee565d7279.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a1cbee162ce85bb34b279de60726bee565d7279.camel@kernel.org>

On Thu, Jul 02, 2026 at 11:02:19AM -0400, Jeff Layton wrote:
> On Thu, 2026-07-02 at 17:53 +0300, Laurent Pinchart wrote:
> > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > We've had this requirement in place in the Documentation for several
> > > months, but it's becoming clear that the signal to noise ratio from this
> > > is quite low.
> > >
> > > 1/ It's not universally followed. While many people do try to attribute
> > > the LLMs in good faith, not everyone does for various reasons.
> > >
> > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > >
> > > 3/ It's not clear why we want to collect this info in the first place.
> > >
> > > Given that the data this provides is flawed at best and is being
> > > collected for a purpose that isn't clear, let's just kill the
> > > requirement for these tags from the kernel at large.
> > >
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > > Christian had proposed watering down the LLM attribution, but I think
> > > it's not productive to try and track this until we have a clearer sense
> > > of what we want to do with this information and how to make it more
> > > reliable.
> > > ---
> > >  Documentation/process/coding-assistants.rst  | 22 ----------------------
> > >  Documentation/process/submitting-patches.rst | 10 ----------
> >
> > You're missing scripts/checkpatch.pl.
> >
> > >  2 files changed, 32 deletions(-)
> > >
> > > diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> > > index 899f4459c52d..c4cc0917fc92 100644
> > > --- a/Documentation/process/coding-assistants.rst
> > > +++ b/Documentation/process/coding-assistants.rst
> > > @@ -35,25 +35,3 @@ is responsible for:
> > >  * Ensuring compliance with licensing requirements
> > >  * Adding their own Signed-off-by tag to certify the DCO
> > >  * Taking full responsibility for the contribution
> > > -
> > > -Attribution
> > > -===========
> > > -
> > > -When AI tools contribute to kernel development, proper attribution
> > > -helps track the evolving role of AI in the development process.
> > > -Contributions should include an Assisted-by tag in the following format::
> > > -
> > > -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > > -
> > > -Where:
> > > -
> > > -* ``AGENT_NAME`` is the name of the AI tool or framework
> > > -* ``MODEL_VERSION`` is the specific model version used
> > > -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> > > -  (e.g., coccinelle, sparse, smatch, clang-tidy)
> > > -
> > > -Basic development tools (git, gcc, make, editors) should not be listed.
> > > -
> > > -Example::
> > > -
> > > -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> >
> > Documentation/process/generated-content.rst still clearly requests
> > contributors to disclose usage of code-generation tools. Even if we drop
> > the Assisted-by tag, I think it is useful to mention the requirement
> > here (probably including a link to generated-content.rst).
> >
>
> Fair point. Maybe we should keep the Attribution section then, and give
> it some brief text like:

I really do not understand how requiring disclosure but not tags isn't a
contradictory position?

If disclosure via tags is worthless because people don't always do it, how is
disclosure using rules not also worthless?

Tags seem like the clearest possible means of expressing this so now I'm
confused as to the point being argued here...

>
> "Contributions developed with LLM help should also follow the
> guidelines outlined in the generated-content document."
>
> With a link to generated-content.rst?

Again I proposed to send this patch alrady but oppose your one, so how should we
move forwards?

If the patch will land over my objections then fine I can save some time, but if
it's in question, maybe I can just do that bit separately?...

>
>
> > > diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> > > index cc6a1f73d7f2..b74c38aa9770 100644
> > > --- a/Documentation/process/submitting-patches.rst
> > > +++ b/Documentation/process/submitting-patches.rst
> > > @@ -634,16 +634,6 @@ bugzilla.kernel.org is a public place in this sense, but email addresses
> > >  used there are private; so do not expose them in tags, unless the person
> > >  used them in earlier contributions.
> > >
> > > -Using Assisted-by:
> > > -------------------
> > > -
> > > -If you used any sort of advanced coding tool in the creation of your patch,
> > > -you need to acknowledge that use by adding an Assisted-by tag.  Failure to
> > > -do so may impede the acceptance of your work.  Please see
> > > -Documentation/process/coding-assistants.rst for details regarding the
> > > -acknowledgment of coding assistants.
> > > -
> > > -
> > >  .. _the_canonical_patch_format:
> > >
> > >  The canonical patch format
> > >
> > > ---
> > > base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
> > > change-id: 20260702-aidoc-7e18f221d63a
>
> --
> Jeff Layton <jlayton@kernel.org>

Thanks, Lorenzo
