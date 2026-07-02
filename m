Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EEC22AE48;
	Thu,  2 Jul 2026 07:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977291; cv=none; b=RzyaT9HvCpef/ZATphxN3m7J7hc5Ik8W8MidSZ5SlTOps0gH1fnYzrWvtko5245JStyEZDATx5PGwNO6ctPpFGnQTc3noiCJ7KKvFj5OVM9lKhFBhsjEPqb9iKNhfVi/m+zqq1GNbCmNHNvYE2Q9mMuzzddCGDEeukLwIZec/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977291; c=relaxed/simple;
	bh=V6rR3G5QQQaAclYfKh2FZObCQoeYebWwyXda8cZc+JA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=RScoTvdQlulORm6NGGUr65+zCCvL+bAczubAuxkrAMKFSujQOTJ3GejpWBDZt4CqJFpwNOB9HkAFdIZ2HKcA2/kdhRW/upImz0fJkjemhaFNdZ/TOhkTRlWjIkzO1DUbuStw2i3L8D8rBP8L6lzy8SwBlr5fGZzELPfq/30UZ6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cu2ZqfIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cu2ZqfIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C68961F000E9;
	Thu,  2 Jul 2026 07:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782977290;
	bh=V1nke6B8RPgiDenv6Vl1w+IcU3ZP+J7NQjuoPM29too=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=cu2ZqfIWefe7ooK5AZxaX3g2IOmHylHHM1ClKjaYA2z7lpV7UO6qrtScD6yGJDxdE
	 9mFRSXCSdekaZEc6lEbxmAuqtDMN8TQBpxZOINqjuPR2G9/jwLpAaPUwRWWYjyMhyW
	 KBaYQ4qKkJfyLtvAHWH7k/A9zCO8y7fDOPed27pIxMnbFkJHqFN6U61btxk0ulkMWr
	 5NjDXKwODdIZGYg0Lg/Gvf6OjfKZ/a+19L95WpE/naNqZ49RTXgdbiOT1BXaIj3IAo
	 3dfo9Nf9PnLnuXw2Bi6bxCIGYVt/tFw9JAhmSrmXVAMqu1Q7AwRxdgVIKcmdm59rzT
	 ZOr5Vz8SAHWlw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
From: Christian Brauner <brauner@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <bffcce9436c47e8762e6f4fa4cae9f7ddd183b8f.camel@kernel.org>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <bffcce9436c47e8762e6f4fa4cae9f7ddd183b8f.camel@kernel.org>
Date: Thu, 02 Jul 2026 09:28:05 +0200
Message-Id: <20260702-hinarbeiten-hergab-altbacken-a024cf20038c@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=3632; i=brauner@kernel.org;
 h=from:subject:message-id; bh=V6rR3G5QQQaAclYfKh2FZObCQoeYebWwyXda8cZc+JA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWS5CbP/Z732+V5FrcYp7uu9cy8eb2pOMmbP+1jGaRXq+
 Mfx7kWOjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgInsmc3wT/Ock/aC79sXlSu8
 bG9XtJwYt2lrzf475sYhO6aeyd+zkYfhf3rz6ycpRaeETh1g9vb4Eal7adWHPefPqim/uejPIN6
 hwAcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-01 14:35 -0400, Jeff Layton wrote:
> On Wed, 2026-07-01 at 17:54 +0200, Christian Brauner wrote:
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
> > 
> > or something else. That still gives the "careful review" signal to
> > reviewers that want to pay special attention to LLM generated work while
> > avoiding this slew of metadata.
> > 
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  Documentation/process/coding-assistants.rst | 8 ++------
> >  1 file changed, 2 insertions(+), 6 deletions(-)
> > 
> > diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> > index 899f4459c52d..fe34f3e7e828 100644
> > --- a/Documentation/process/coding-assistants.rst
> > +++ b/Documentation/process/coding-assistants.rst
> > @@ -43,12 +43,8 @@ When AI tools contribute to kernel development, proper attribution
> >  helps track the evolving role of AI in the development process.
> >  Contributions should include an Assisted-by tag in the following format::
> >  
> > -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > +  Assisted-by: LLM [TOOL1] [TOOL2]
> >  
> > -Where:
> > -
> > -* ``AGENT_NAME`` is the name of the AI tool or framework
> > -* ``MODEL_VERSION`` is the specific model version used
> >  * ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> >    (e.g., coccinelle, sparse, smatch, clang-tidy)
> >  
> > @@ -56,4 +52,4 @@ Basic development tools (git, gcc, make, editors) should not be listed.
> >  
> >  Example::
> >  
> > -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> > +  Assisted-by: LLM coccinelle sparse
> > 
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260701-work-coding-assistants-650ae1202ee0
> 
> 
> In general, collecting data for nebulous purposes usually turns out to
> be a bad idea. If we're not 100% clear on why we want this data, then
> we're probably better off not collecting it at all.

Agreed.

> With that in mind: if we're going to water down the tag, then I say
> just remove the requirement altogether. If we later decide that we want
> to start collecting more detailed info for some (clear) purpose then we
> can revisit the idea.

Agreed.

