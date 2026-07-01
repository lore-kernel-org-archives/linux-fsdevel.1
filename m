Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E79175A9C;
	Wed,  1 Jul 2026 18:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782931985; cv=none; b=taoxjxrZRYkCz0fvpSEUvWK8iKknKD5ePgnLQUfVEZaMjHnKnUt3tl+wP7cmoAmGaVJtpcYMbl8nOJgC43S6DUMdtGjdhPG+AWwIzzY2yXMb4k+AN7YtP6ACTbdE82JQPqV3cY6K2vbZpbJECCqzzl907TGz5WdDVwrfCHrcji8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782931985; c=relaxed/simple;
	bh=JJ2bCvF9V9faRtkSVez83R/oSccusPAWgLiUuakKyvM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QrK0op8V/aZDo3Eid5DBPhyRSMseFhjN9crhTESnJoA6YGwBfOUT8DCVvM/syRsEoQWmKeZGP3Xws9HYX1IYN3RmVsZ7Sa0QT1/tdzm13HM9OCK5NBijwIWt2iTe9Phs+wFxS7AKQhHv4O+zowEPt4p+A9TodMJY+4oRLsrFtak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P6cpzUM4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P6cpzUM4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F061F000E9;
	Wed,  1 Jul 2026 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782931983;
	bh=TNz7DIIDlkzXwzuwPEkNP0afeY/1aW0PYOsxFj/Jr6c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=P6cpzUM4FLbh2hMauoymkBbq26tRWfe6OhHarMMy5mVfPLJUzeHNRBKFKX1jfrWu1
	 aFgzL0YfCF+JrSOjuRbwxx3OY/0g6xQce7WUhQbI4OulM73Nn/dyudyil7H9hIlXpB
	 xuma73m7yo3FiFhQfBbiAgbdPvDlBPZl+vw8uTUZ7wffYSkrsLAfQS96x8FrlM1mI7
	 PUM9vpv24jgMXghqLmBC5zJQg1+GbJcMI9KXQQgNE9W7WNDg8fAX+Z+L2Ofa05B/BV
	 89tKMRnsv69cSruy2SEJ/X60YNS1kGjlk/RqxjdnSvek/Methvdj0s4Jp+BdwVfaSk
	 7JyPGYdU5sxdg==
Date: Wed, 1 Jul 2026 11:53:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds  <torvalds@linux-foundation.org>, Jonathan Corbet
 <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, David Hildenbrand
 <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260701115302.29c66401@kernel.org>
In-Reply-To: <bffcce9436c47e8762e6f4fa4cae9f7ddd183b8f.camel@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
	<bffcce9436c47e8762e6f4fa4cae9f7ddd183b8f.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 01 Jul 2026 14:35:08 -0400 Jeff Layton wrote:
> On Wed, 2026-07-01 at 17:54 +0200, Christian Brauner wrote:
> > I remain very confused by our coding assistant contribution guidelines.
> > I'm going to be a bit polemic now but this seriously in good faith.
> >=20
> > Why precisely do we require all this detailed information about what
> > specific coding assistant was used?
> >=20
> > I find it very irritating that our git history has effectively started
> > to function a bit like a free advertising platform for a bunch of AI
> > companies and their proprietary agents and models.

FWIW, this is exactly how I feel. I added a regex to strip these in
my git hooks. So at least the net/ history should be ads-free =F0=9F=A4=B7=
=EF=B8=8F

Inexperienced developers who just trust the LLM output, and therefore
are the group where the tags would be most useful, tend not to add
them. Either because they are ashamed or because they want full credit.
This correlation kills the utility of the tag.

> > And it reamins unclear to me what exactly we do get out of this detailed
> > information: Do we want to run statistical analysis on what agent and
> > model is used the most and publish that on LWN at some point?
> >=20
> > I acknowledge that my stance is even more radical: imho we would just
> > stop it with any disclosure requirements completely. It's useless imho.
> > We already see that other than core contributors most people don't care
> > and will just not disclose their usage of AI. I think this is entirely
> > pointless and worse it brings in undefined legal status as well. It's
> > not like recent events of pulling certain models from the face of the
> > earth have made this any less concerning.
> >=20
> > But fine, if we want to do this can we please just dumb it down to
> >=20
> > Assisted-by: LLM
> >=20
> > or
> >=20
> > Assisted-by: Coding Assistant
> >=20
> > or something else. That still gives the "careful review" signal to
> > reviewers that want to pay special attention to LLM generated work while
> > avoiding this slew of metadata.
> >=20
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  Documentation/process/coding-assistants.rst | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/Documentation/process/coding-assistants.rst b/Documentatio=
n/process/coding-assistants.rst
> > index 899f4459c52d..fe34f3e7e828 100644
> > --- a/Documentation/process/coding-assistants.rst
> > +++ b/Documentation/process/coding-assistants.rst
> > @@ -43,12 +43,8 @@ When AI tools contribute to kernel development, prop=
er attribution
> >  helps track the evolving role of AI in the development process.
> >  Contributions should include an Assisted-by tag in the following forma=
t::
> > =20
> > -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > +  Assisted-by: LLM [TOOL1] [TOOL2]
> > =20
> > -Where:
> > -
> > -* ``AGENT_NAME`` is the name of the AI tool or framework
> > -* ``MODEL_VERSION`` is the specific model version used
> >  * ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> >    (e.g., coccinelle, sparse, smatch, clang-tidy)
> > =20
> > @@ -56,4 +52,4 @@ Basic development tools (git, gcc, make, editors) sho=
uld not be listed.
> > =20
> >  Example::
> > =20
> > -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> > +  Assisted-by: LLM coccinelle sparse
> >=20
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260701-work-coding-assistants-650ae1202ee0 =20
>=20
>=20
> In general, collecting data for nebulous purposes usually turns out to
> be a bad idea. If we're not 100% clear on why we want this data, then
> we're probably better off not collecting it at all.
>=20
> With that in mind: if we're going to water down the tag, then I say
> just remove the requirement altogether. If we later decide that we want
> to start collecting more detailed info for some (clear) purpose then we
> can revisit the idea.

+1

Honestly even tool attribution feels increasingly moot.
People vibe code tools and AI-in-the-loop pipelines which they never
publish. Open source tools are (hopefully?) used in pre-commit
pipelines, so they have the "kbuild bot problem" of problems getting
fixed before the code is merged. And we have the same free advertising
problem for the rest.

It's 100 times more important to drill into people to provide sufficient
information in plain English. How was the bug discovered, has it been
triggered / proven and how, what is the user impact. I wonder if
inventing tags distracts contributors from what really matters.
