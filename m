Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD064412271;
	Thu,  2 Jul 2026 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782984300; cv=none; b=DOTLiUSgl6EIMYCkXzDRrRVFdAF5Z4LYe7rPJRjFeU8YrYKA1VBeA6oLAxF6VJllt1FsXSbaYNLfyJi1M5q6ZacLMH7hSkGTE2KAdpMvCRFZfMjVvtWBB8OBN802ceJfht26edTVN/oDIUg/g86uuT0PhNlYYW83GHR2plh1iHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782984300; c=relaxed/simple;
	bh=ZS7u7hz1Qbli0QqnmbwELxK1FEHM1yiG9rosI7WRkco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=um48A4v/2pQ2rBCr1xxSbclxo2QYJgSPsS0cZOZyk+1aDeDS6T/5WXuv0ODCj1ZiODfjRFOKCCG03Haubyv16C04+X17vyiLOG611VfBZ4hLEMLhqNTbXpMvVIg1zaVYxU1FTC7+9SbfEbjUvAGaYTr4ZlFxuX24hPRztcf9qm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpPbJ4g3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpPbJ4g3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6B31F00A3A;
	Thu,  2 Jul 2026 09:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782984298;
	bh=fWN2PUZqz314MN6aw/zLCpIVBp40dgc/RS82IgvPVMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PpPbJ4g310gK8zS/jgvsvWNGJUjuzCQkeJltv5RR3fm3WEyQnzATo6Tu7ZlqpjlaY
	 KvH/MGkLBv3LPh8q20cdGdZjWjaFoNNmbjqrnFAHQXclwoCvFlhG0WV7M552ZXNSrL
	 0OWfiAhjYpjzACxY6BsCt55l4MrQcvj9xgDOhCWSkL8RDm3sgp0PJmoVmFw9vd9nlL
	 tdcZciGoy6Qn6BRP7sD7snET3sdFlOtJrYxzvEs9ARi+ITy1i0wx6UBmYlOVjr2sEh
	 nOvr++WrQzSv17CMWZWNlq5bxBnXyAUqJsaGrEptPfJ03G4ZJA4oLPAv5+Lb97e+hJ
	 72gKjkjWYOjjA==
Date: Thu, 2 Jul 2026 10:24:51 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	Jeff Layton <jlayton@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYjFXFaVDCx6WH0@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>

On Wed, Jul 01, 2026 at 06:10:48PM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 17:54, Christian Brauner wrote:
> > I remain very confused by our coding assistant contribution guidelines.
> > I'm going to be a bit polemic now but this seriously in good faith.
> >
> > Why precisely do we require all this detailed information about what
> > specific coding assistant was used?
> >
> > I find it very irritating that our git history has effectively started
> > to function a bit like a free advertising platform for a bunch of AI
> > companies and their proprietary agents and models.
> >
> > And it reamins unclear to me what exactly we do get out of this detailed
> > information: Do we want to run statistical analysis on what agent and
> > model is used the most and publish that on LWN at some point?
> >
> > I acknowledge that my stance is even more radical: imho we would just
> > stop it with any disclosure requirements completely. It's useless imho.
> > We already see that other than core contributors most people don't care
> > and will just not disclose their usage of AI. I think this is entirely
> > pointless and worse it brings in undefined legal status as well. It's
> > not like recent events of pulling certain models from the face of the
> > earth have made this any less concerning.
> >
> > But fine, if we want to do this can we please just dumb it down to
> >
> > Assisted-by: LLM
> >
> > or
> >
> > Assisted-by: Coding Assistant
>
> I'd prefer this.

Yeah I don't see any reason why we need to know precisely which model or version
of said model we need.

>
> The doc states "proper attribution helps track the evolving role of AI in the
> development process". If there is another reason why we need the free
> advertisement, we should document it.

Yup.

Honestly I find the phrasing here quite vague.

While it is interesting to track the degree of AI involvement (where that's
disclosed) a really important part of this is how maintainers deal with AI
submissions.

Also we have a schism in the documentation anyway, there's [0] which is
literally indexed as 'AI Coding Assistants', which says NOTHING about how
people are supposed to use them etc. and there's [1] Which DOES say
something about that, but which isn't linked to by [0], nor links to it.

Before I happened across this thread, I was thinking of sending a patch to
at least link one to the other. Now I think I definitely will.

>
> Side note: if someone instructs an LLM exactly what to do, and would have
> achieved the same thing just typing it in, the use of the tag is not any helpful
> to me. (similar to "Assisted-by: vim" would not be helpful).
>
> What would be much more relevant to know is to which degree LLMs were used.

As I mentioned off-list I do agree that this is key.

Having this information helps with the most important issue we face when it
comes to AI - an EXISTENTIAL issue actually IMO - the asymmetry between how
much code can be generated, and available maintainer/reviewer resource.

Being able to, at a glance, see that a series was both wholly generated
seems substandard means we can quickly ask for more human attention.

And I know what the argument's going to be - 'bad faith people will lie
about it' - and sure, yes they will.

But now that there's been a huge surge of AI generated code in mm I can
speak from experience - many DO attribute, and for those that don't it's
very useful to have guidelines to point to.

Both aid in dealing with this asymmetry.

(as an example, I've had to push back quite strongly on an _attributed_
series ([2] and [3]) that appeared to be wholly generated. Having this
information would have helped there).

>
> Assisted-by: LLM # translate commit message
> Assisted-by: LLM # generate some test cases
> Assisted-by: LLM # cleanup logic
> Assisted-by: LLM # everything and I have no clue what any in here does

Yeah this format works I think!

>
> I thought we ask for that in some document, but couldn't immediately find it
> (and nobody does that).

Well you're probably thinking of [1], e.g.:

	Second, when making a contribution, be transparent about the origin
	of content in cover letters and changelogs. You can be more
	transparent by adding information like this:

	...

	- Which portions of the content were affected by that tool?

	...


And also from the same document:

	If tools permit you to generate a contribution automatically,
	expect additional scrutiny in proportion to how much of it was
	generated.

	As with the output of any tooling, the result may be incorrect or
	inappropriate. You are expected to understand and to be able to
	defend everything you submit. If you are unable to do so, then do
	not submit the resulting changes.

	If you do so anyway, maintainers are entitled to reject your series
	without detailed review.

This only speaks more to the need to link the two documents together. I'll
send a patch.

>
> --
> Cheers,
>
> David

Thanks, Lorenzo

[0]:https://docs.kernel.org/process/coding-assistants.html
[1]:https://docs.kernel.org/process/generated-content.html
[2]:https://lore.kernel.org/linux-mm/aj9yrlB0TrlYCLlf@lucifer/
[3]:https://lore.kernel.org/linux-mm/akIjA_dqh4OHAYo4@lucifer/
