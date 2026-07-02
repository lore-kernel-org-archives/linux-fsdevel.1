Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6E7433E65;
	Thu,  2 Jul 2026 14:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004245; cv=none; b=BTWyBdBrchOL06jOIivgHzSvN6kk7UCmlsNrFmuDeTY4iEufQqYWtOdwz6Umj9wbhohwnIhRHyYRsAA1LgEC5W9eliboJl9TxMUf2pp2fbbmmilPBuiyVx5m2LBNglCyBGnkXJPCTfgt5DxlwZ591qCWxT19w2fy+11Ef0qShcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004245; c=relaxed/simple;
	bh=60bukgHJpyxIUqcr7LqUTIJt2Dg3r3h+Em48QTYgA4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQ6rrw2YVxek4TGCl4DXf+ivaTulYzVvoJGngKM+5GsErguOVG++aIZilex1S1pVsIitEzmaD2TJ0OaOxSJ7/KKKPckZs+yg/60K+AYBq9MHRTwXkI5BzwtyjHDy27KZr/g9c/nuAPWgNkbuybdXtlhLLt0RQ3pRRBGVn+Mi2ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQpbewK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQpbewK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDA41F000E9;
	Thu,  2 Jul 2026 14:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783004243;
	bh=4yuXlVHn6Pyak7JOlpG9NCZhDnZXAFm+smz+8Wr/tzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LQpbewK77dimVIV67sbl0LG60CacyZDIFm/LOtg7Jy9KyPuLgrLT+F8Vhu54+bYd6
	 gpOf2Sx0paZOiXpUh91lISOgFgA2kyP7IWeCnXgMqlSXFIVDfgTdggVfrfNf1HtO4v
	 Sv497hhAw0DWkHOuA0fIVsbhR45+ZqBjpw/qPiN9hCe2lw8uriuRTFXc2dH70Gof3d
	 dqDm3PeZmZCt5eEBtjJzq83QCJeGq3E/7GePw6As599JC8VKnhQ9MZCP6+2EIW1njx
	 w5nKFrk5nX/HfaEhjQP22XqU22G7Kc9vin9bJrMSmWXVTC0sGujbByvZQ8qMNeO/4k
	 3wYASoYToJT9w==
Date: Thu, 2 Jul 2026 15:57:11 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Carlos Maiolino <cem@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akZ5_aiOuOpgLII1@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-aidoc-v1-1-735572dfb995@kernel.org>

I'm a little surprised I'm cc'd on this :) I'm not entirely sure if my pushing
back on this is going to mean anything but I suppose here goes nothing.

On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> We've had this requirement in place in the Documentation for several
> months, but it's becoming clear that the signal to noise ratio from this
> is quite low.
>
> 1/ It's not universally followed. While many people do try to attribute
> the LLMs in good faith, not everyone does for various reasons.

Does something not being universally followed therefore make it worthless?

You really have to explain that, because this is literally true of any rule
whatsoever we might have in the kernel, should we drop all of them?

I think you should replace this with a cogent argument such as that you feel it
is not being used in the _majority_ of cases or is very rarely used, and that
value is in your view not there.

>
> 2/ It basically serves as free advertising for proprietary LLM companies.

I agree with this point, we should drop the model.

>
> 3/ It's not clear why we want to collect this info in the first place.

Well I made arguments on the other thread, but to repeat:

- It makes it easier to engage with people when they do ack it.

- It makes it far quicker to be able to do so.

- There's a barrier to mentioning an LLM if it's not provided - people can get
  upset, or it can cause issues to raise it as a concern.

- Even if it's only there in _some_ cases, it makes _those_ cases easier to deal
  with.

- It provides some (incomplete) data that might make it easier to deal with
  bug-causing patches.

- It provides some (incomplete) data on bug rates with/without LLMs.

I do agree they're far far less useful when there's not some indication of how
much of the patch was LLM-generated.

Their usefulness is obviously deeply far from perfect, but not zero.

>
> Given that the data this provides is flawed at best and is being
> collected for a purpose that isn't clear, let's just kill the
> requirement for these tags from the kernel at large.

I feel there are purposes. Perhaps the argument is stronger for having the tags
on submissions rather than actually in-tree, however.

>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I think simplifying by requiring only 'LLM' and adding a line simply suggesting
a comment giving a sense of how much was used, and then perhaps a paragraph saying

	Subsystems may vary in their acceptance of this patch blah blah blah

Could be a compromise?

> ---
> Christian had proposed watering down the LLM attribution, but I think
> it's not productive to try and track this until we have a clearer sense
> of what we want to do with this information and how to make it more
> reliable.

Well he's moved now to stridently saying we should do what you're doing here so
presumably you're now in alignment.

> ---
>  Documentation/process/coding-assistants.rst  | 22 ----------------------
>  Documentation/process/submitting-patches.rst | 10 ----------
>  2 files changed, 32 deletions(-)
>
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index 899f4459c52d..c4cc0917fc92 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -35,25 +35,3 @@ is responsible for:
>  * Ensuring compliance with licensing requirements
>  * Adding their own Signed-off-by tag to certify the DCO
>  * Taking full responsibility for the contribution
> -
> -Attribution
> -===========
> -
> -When AI tools contribute to kernel development, proper attribution
> -helps track the evolving role of AI in the development process.
> -Contributions should include an Assisted-by tag in the following format::
> -
> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> -
> -Where:
> -
> -* ``AGENT_NAME`` is the name of the AI tool or framework
> -* ``MODEL_VERSION`` is the specific model version used
> -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> -  (e.g., coccinelle, sparse, smatch, clang-tidy)
> -
> -Basic development tools (git, gcc, make, editors) should not be listed.
> -
> -Example::
> -
> -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
> index cc6a1f73d7f2..b74c38aa9770 100644
> --- a/Documentation/process/submitting-patches.rst
> +++ b/Documentation/process/submitting-patches.rst
> @@ -634,16 +634,6 @@ bugzilla.kernel.org is a public place in this sense, but email addresses
>  used there are private; so do not expose them in tags, unless the person
>  used them in earlier contributions.
>
> -Using Assisted-by:
> -------------------
> -
> -If you used any sort of advanced coding tool in the creation of your patch,
> -you need to acknowledge that use by adding an Assisted-by tag.  Failure to
> -do so may impede the acceptance of your work.  Please see
> -Documentation/process/coding-assistants.rst for details regarding the
> -acknowledgment of coding assistants.
> -
> -
>  .. _the_canonical_patch_format:
>
>  The canonical patch format
>
> ---
> base-commit: 665159e246749578d4e4bfe106ee3b74edcdab18
> change-id: 20260702-aidoc-7e18f221d63a
>
> Best regards,
> --
> Jeff Layton <jlayton@kernel.org>
>

Thanks, Lorenzo
