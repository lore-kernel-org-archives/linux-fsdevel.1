Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B71C433E8D;
	Thu,  2 Jul 2026 15:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004544; cv=none; b=l5YrZcWfo7ZkXZ7Q/GLgC5X5x6Ia8tJq7e8fazNt7xseJx/Ox3I3XF3OcTPzmvMJkagtvNFeZiVm3HPnFmXOzjDakNrVIWX655/ATpgHcCMXvEOSxEXoXqnrxW5dgqvCL3O7bbGCnvPDWY60bKn25T8MTvWgFduk1ur7kH6irY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004544; c=relaxed/simple;
	bh=aqVkFHW9/gmUxK+XgDWp2QjbPz/qVa9j1O3pl/9Iu+0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PCTIVj6x3qV8lgQyJbqNqJVFex4P4Ce+grzxOSMnVJ1/MllCdyQy4Fi9ahccsuWqwQxqNq3vecRD9Is1+I/aIJdYvN/ma68qNZCjb6ym1QKG5YWZLRXgjdVpdcG7ydD+8zB17Q2BEtYoGBiRriLxPs3zql5wqAlgD9c54Ocvunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJeu+Gmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJeu+Gmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79291F000E9;
	Thu,  2 Jul 2026 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004542;
	bh=fbMlJs8kZvy7lcBeGYJ8uU8ALlr5OLr/ls1nJtF6HLA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HJeu+GmxBfP7MYs/fl9BimAOmBt9up+b0QM6shN7GmSA6aQeTJTUkqVGg+axlkOKX
	 zji+niGY75ma/kEbtumZVQ2C1PHdRz8e6V/lgy6EuEQmxB4AhPa+Fy2Es8YK9VrW38
	 mKNz63Kjsxe8X3gXM8413+TAeuRduuBOOtL441y8ctk6ODNpFXaIrHnzT5qbFrkjHI
	 CbrwSpf+tZIDea++/oMQ09kyDmCJ3h8fQPmLjEQ1yW4mKqFxyLOi9BJ3uNN09sYuzI
	 DH2vdFzK4nsKvu0Jh60+mCU3y+CN0ma1RRzkmiPwewNTLahnBaA6VE5fhe5rHhbqEa
	 sq8y9rJQryENg==
Message-ID: <8a1cbee162ce85bb34b279de60726bee565d7279.camel@kernel.org>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
From: Jeff Layton <jlayton@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet	
 <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, Lorenzo Stoakes	
 <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>, Jakub Kicinski	
 <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski
	 <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, Christoph Hellwig	
 <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, Mark Brown	
 <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, Jens Axboe	
 <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, Vlastimil Babka	
 <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date: Thu, 02 Jul 2026 11:02:19 -0400
In-Reply-To: <20260702145322.GG3534761@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
	 <20260702145322.GG3534761@killaraus.ideasonboard.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-02 at 17:53 +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > We've had this requirement in place in the Documentation for several
> > months, but it's becoming clear that the signal to noise ratio from thi=
s
> > is quite low.
> >=20
> > 1/ It's not universally followed. While many people do try to attribute
> > the LLMs in good faith, not everyone does for various reasons.
> >=20
> > 2/ It basically serves as free advertising for proprietary LLM companie=
s.
> >=20
> > 3/ It's not clear why we want to collect this info in the first place.
> >=20
> > Given that the data this provides is flawed at best and is being
> > collected for a purpose that isn't clear, let's just kill the
> > requirement for these tags from the kernel at large.
> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> > Christian had proposed watering down the LLM attribution, but I think
> > it's not productive to try and track this until we have a clearer sense
> > of what we want to do with this information and how to make it more
> > reliable.
> > ---
> >  Documentation/process/coding-assistants.rst  | 22 --------------------=
--
> >  Documentation/process/submitting-patches.rst | 10 ----------
>=20
> You're missing scripts/checkpatch.pl.
>=20
> >  2 files changed, 32 deletions(-)
> >=20
> > diff --git a/Documentation/process/coding-assistants.rst b/Documentatio=
n/process/coding-assistants.rst
> > index 899f4459c52d..c4cc0917fc92 100644
> > --- a/Documentation/process/coding-assistants.rst
> > +++ b/Documentation/process/coding-assistants.rst
> > @@ -35,25 +35,3 @@ is responsible for:
> >  * Ensuring compliance with licensing requirements
> >  * Adding their own Signed-off-by tag to certify the DCO
> >  * Taking full responsibility for the contribution
> > -
> > -Attribution
> > -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > -
> > -When AI tools contribute to kernel development, proper attribution
> > -helps track the evolving role of AI in the development process.
> > -Contributions should include an Assisted-by tag in the following forma=
t::
> > -
> > -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> > -
> > -Where:
> > -
> > -* ``AGENT_NAME`` is the name of the AI tool or framework
> > -* ``MODEL_VERSION`` is the specific model version used
> > -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> > -  (e.g., coccinelle, sparse, smatch, clang-tidy)
> > -
> > -Basic development tools (git, gcc, make, editors) should not be listed=
.
> > -
> > -Example::
> > -
> > -  Assisted-by: Claude:claude-3-opus coccinelle sparse
>=20
> Documentation/process/generated-content.rst still clearly requests
> contributors to disclose usage of code-generation tools. Even if we drop
> the Assisted-by tag, I think it is useful to mention the requirement
> here (probably including a link to generated-content.rst).
>=20

Fair point. Maybe we should keep the Attribution section then, and give
it some brief text like:

"Contributions developed with LLM help should also follow the
guidelines outlined in the generated-content document."

With a link to generated-content.rst?


> > diff --git a/Documentation/process/submitting-patches.rst b/Documentati=
on/process/submitting-patches.rst
> > index cc6a1f73d7f2..b74c38aa9770 100644
> > --- a/Documentation/process/submitting-patches.rst
> > +++ b/Documentation/process/submitting-patches.rst
> > @@ -634,16 +634,6 @@ bugzilla.kernel.org is a public place in this sens=
e, but email addresses
> >  used there are private; so do not expose them in tags, unless the pers=
on
> >  used them in earlier contributions.
> > =20
> > -Using Assisted-by:
> > -------------------
> > -
> > -If you used any sort of advanced coding tool in the creation of your p=
atch,
> > -you need to acknowledge that use by adding an Assisted-by tag.  Failur=
e to
> > -do so may impede the acceptance of your work.  Please see
> > -Documentation/process/coding-assistants.rst for details regarding the
> > -acknowledgment of coding assistants.
> > -
> > -
> >  .. _the_canonical_patch_format:
> > =20
> >  The canonical patch format
> >=20
> > ---
> > base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
> > change-id: 20260702-aidoc-7e18f221d63a

--=20
Jeff Layton <jlayton@kernel.org>
