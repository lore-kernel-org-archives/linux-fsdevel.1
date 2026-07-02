Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4A537A834;
	Thu,  2 Jul 2026 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004009; cv=none; b=nYkDRJQsRxEN92H0H4bcHElFDwqOQErWdLCRfINdxWcG8l7SBTEEpPpBzciD7zg8vwhvEgcKNK0QU4rqFFe3u9qLLBiaw5v9a52lMIDAWPfwNHQgsraIlpNNG6wSTRSnYKwdkRACD63f36TIlXhuQOn9NgzAMtezGvrzepbWe6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004009; c=relaxed/simple;
	bh=xwEv232ts11dKM8By8JjzhRb/0e6CPb3Ab7ZCA6ouQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KT9Wnz5rwzL/8x/nDAirU+QbUba2H7ME/RIAgIvsVzoMuRbL4E5t8U7lRXRSMJvy4xlXxpjsItCu6+tFHcwyqNmJ4dLawg4s0+meb3QkDROwQ/GYk6pb7Y94NoR6udd2ZKRgTcEW/Xsfj/fWNz0w87Dxjx6wX4kIq7cDO15BFFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RzZROcgv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RzZROcgv"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1818F8CB;
	Thu,  2 Jul 2026 16:52:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783003958;
	bh=xwEv232ts11dKM8By8JjzhRb/0e6CPb3Ab7ZCA6ouQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RzZROcgvBGdlXdQCYyCE7B1RpqHE/Q3iuphO6vxDeN4syU/d8z/w7bsabKyZyTyhn
	 GHy2QJ8XBGeBrrW8OjvWJSeg7jRF6LpXjARSogl/G5ZItcc589aVSfTOsAKtaKk52P
	 Ic3ShpLy/jBM2YPUspoCYlLu3yOzrwdxGE5syYHo=
Date: Thu, 2 Jul 2026 17:53:22 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <20260702145322.GG3534761@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-aidoc-v1-1-735572dfb995@kernel.org>

On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> We've had this requirement in place in the Documentation for several
> months, but it's becoming clear that the signal to noise ratio from this
> is quite low.
> 
> 1/ It's not universally followed. While many people do try to attribute
> the LLMs in good faith, not everyone does for various reasons.
> 
> 2/ It basically serves as free advertising for proprietary LLM companies.
> 
> 3/ It's not clear why we want to collect this info in the first place.
> 
> Given that the data this provides is flawed at best and is being
> collected for a purpose that isn't clear, let's just kill the
> requirement for these tags from the kernel at large.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Christian had proposed watering down the LLM attribution, but I think
> it's not productive to try and track this until we have a clearer sense
> of what we want to do with this information and how to make it more
> reliable.
> ---
>  Documentation/process/coding-assistants.rst  | 22 ----------------------
>  Documentation/process/submitting-patches.rst | 10 ----------

You're missing scripts/checkpatch.pl.

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

Documentation/process/generated-content.rst still clearly requests
contributors to disclose usage of code-generation tools. Even if we drop
the Assisted-by tag, I think it is useful to mention the requirement
here (probably including a link to generated-content.rst).

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

-- 
Regards,

Laurent Pinchart
