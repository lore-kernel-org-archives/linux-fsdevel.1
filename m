Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CC4406820;
	Mon,  6 Jul 2026 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327482; cv=none; b=BvR8gJaxhs7xi1pl1SXoQoTJ5vLhV2w1LA15S9Zt50AJSuelb5UAtfpNIzurTNkE/UdD/8bek6ZHtjA3oEyKc9gSWVL1tj1fYBFW+dLrbkKXNfPskVxMx6QF+aGLLf3hNEgbAmr6Muv/X4t/N4mBoDehWwipufWK0XYZhNtZ3PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327482; c=relaxed/simple;
	bh=rth18z6YaOz5QBWEWwHDUQ0tPO1BwJ6C7TuIlFhrhws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMNePCA1tc3bEVCo2I3MnW1yt3hrYZcpP6p5Aa4TPLoly9FoSh8eWXM5QhIKFK7C521zcrVJTMAFQ957/OYaREFrDN63ZL/TQ+chCcYXAI6ryxis9rbPCxQBja01ny1Uo2CWvyOlswPV/xMcIoxsZMsO8xsleh7n1psaz8o0kYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iu29N5iR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iu29N5iR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA521F00A3D;
	Mon,  6 Jul 2026 08:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327460;
	bh=Q68xeEYlRpvZZ3fJWppuzDYXgw2sArSGKp7zyhZSU+s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Iu29N5iR7ntPSqbTbtXU7u9y3w6oVk1s/Tz9jj7UtZps2hQUhhq98i5vEwppxu6EB
	 VXluEesnbbyMWBitf/QjJPBqqgCgRdZJZi3IBEnXoTup9nHOeasVETgB1Mx1dGHMuk
	 uINFp67z5uv/eA1AE90sxUC4O5/OhMabdcV09llf4aYxt+BY2pQBAVKNlfmguBjHb1
	 arsbaUBH5Bapz1fx2eEIIxzgkhjZPnxf1Pa1Js05tel94A6bKkCVe6JUOqUye/UudK
	 7kBlSo8rTpHZR4qb+OlasPLUevd7G5jnGgiMTWUtBGBnPwMCxEAfwcoy+vOOXN+MZk
	 iEngu7WUe0HPg==
Received: from localhost ([::1])
	by mail.kernel.org with esmtp (Exim 4.99.4)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1wgew6-0000000Dh4e-27NY;
	Mon, 06 Jul 2026 10:44:18 +0200
Date: Mon, 6 Jul 2026 10:44:17 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Theodore Tso" <tytso@mit.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton
 <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Justin Stitt
 <justinstitt@google.com>, Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Jori Koolstra
 <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster
 <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, David
 Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, Jani Nikula
 <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, Vlastimil Babka
 <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
Message-ID: <20260706104417.0cc72156@localhost>
In-Reply-To: <akeaouJETPWpE838@mit.edu>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
	<2026070224-unholy-commode-cf45@gregkh>
	<2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
	<20260702161330.GH3534761@killaraus.ideasonboard.com>
	<2026070227-payroll-eradicate-8f66@gregkh>
	<20260702163215.GC3559965@killaraus.ideasonboard.com>
	<2026070350-drown-untreated-5835@gregkh>
	<a095d9b4-f774-47d9-affd-d519d8acfb34@kernel.org>
	<2026070343-copied-quarters-1e2a@gregkh>
	<akeaouJETPWpE838@mit.edu>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jul 2026 07:42:35 -0400
"Theodore Tso" <tytso@mit.edu> wrote:

> On Fri, Jul 03, 2026 at 09:30:28AM -0500, Greg KH wrote:
> > > So clarifying there that a "Assisted-by: LLM" is also good enough wou=
ld make
> > > sense if we agree on that. =20
> >=20
> > If we all agree on that, I'm saying that _I_ don't care, but others
> > might. =20
>=20
> I agree that requiring the model name is not a good idea, because some
> developers might be using unreleased products where the name itself
> might not be public.  So allowing the version number of the LLM to be
> elided would be a good change.
>=20
> I'll also note that it's starting to be the case where tool is
> actually quite relevant.  So it's not just about the LLM Model, but
> whether you're using Codex, Claude Code, OpenCode, or Shahiko.  You
> can use the tool or the harness with different models.
>=20
> So whether the tag is:
>=20
> Assisted-By: OpenCode:Gemini 3.5 Pro
> Assisted-By: Claude Code
> Assisted-By: LLM

I don't think an assisted-by for LLM actually helps.

I can't see any difference on adding it or doing something like:

	Assisted-By: smath
	Assisted-By: sparse
	Assisted-By: coverity
	Assisted-By: gcc
	...
	Assisted-By: my-favorite-web-search-engine

=46rom my side, I don't care about whatever tool/process a developer has
to produce a patch. All I want is a proper patch that passes my review
criteria.

Also, identifying bad vibe-coding patches is usually easy: their=20
descriptions look like written by a former literature professor that just=20
took his first job as junior programmer: they come with useless comments,
random variable renames, unneeded code rewrites, etc.

Btw, if one wants them to be tagged as AI-produced, perhaps we can teach=20
Sashiko to identify it and add a big warning on its review. This will
probably be more reliable than asking people to add a LLM tag.

What I think we should do, instead, is to let it clear that vibe coding
is forbidden - e.g. just asking AI to do something and sending it as-is
(*).
So, I would add something like this at
Documentation/process/coding-assistants.rst:

	"All patches shall be written or reviewed and modified by a human.
	 You should be able to understand exactly what the patch is doing,
	 why it is taking such approach and how. Pure non-trivial
	 machine-generated patches will be rejected."

(*) There are of course exceptions for it: typo fix patches for instance
    can be pure machine-generated. Even before AI, we have patches like
    that where people used some spell checker to fix typos. Again, they
    need human review before submission, as sometimes, spell checker fails
    when, for instance, it tries to replace an acronym with resembles
    a word.

--=20
Thanks,
Mauro
