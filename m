Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B22238F252;
	Tue,  7 Jul 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451034; cv=none; b=Uzld4q4R9huxnH40FZlXnE4rI7Q18OMFsf1SlBDMhQKIDXliv93HYMOF/pdP3QlUxUFkyGmUIFaPBIJOa09y1V/z7x9gs5lWfp5MsMRA1RU5VYwwBewNJXi07I+gPWn5EXydIQFLJCCJn46cxzCXJu8R5J+KaHmxbZZ/ba1jQEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451034; c=relaxed/simple;
	bh=0VJ6cuRJTTQnnxSz8DchgznATTLiy2kRi3FMEm1nmDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tkIBxADkuvKVYZoXUx721+YCgQ6AawOGGCzcGHHg5ssoENyWTmNfjgFHSitIaA1FsT2pbCxEGENRHuqhfenlUAYmVTIESjvklxQJk+Q9Jk1YBWGbir5vk7lhB7b/6bK5LRX1Uo9GqWcMwZwRx7NdMFNR4nFjKxAYIsTml5YMtfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VLQKCfWj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VLQKCfWj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC91F000E9;
	Tue,  7 Jul 2026 19:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451032;
	bh=YyKq/KokqVzrbkpjbywEAWWCk+N/clH4+72CIChvAuM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VLQKCfWjqAoYWXdnpatWLCxMTS1RBAuuunMGSLnlobAGaJQhMiCJEmU8t3zK83GzM
	 LAdtUOdUrEwp4rXeaP+TGMKEuajRmGJ9xf6n5BTIWLBt1j8omSbuZIiF553DfMe5TG
	 7+BGzOV4OwLn+UWPrQDhNy9TeE8HNcf5qMze5CucwlD0YfttMaAef6UfxjGgOYpP10
	 ZsU4jHwcKRVd4dxXLCdkbvs8ighiaZ2Wml8rrC3YIoxP7h8/mJOMdhJOUNrhTkhqee
	 bXkfZgkjOrG2AT5hzFbyUqkHpQ+ZhabVe404evZLo09A4ofb9sbJPDwkwPST6D8/Tm
	 xM44EHLVA67pA==
Date: Tue, 7 Jul 2026 20:03:44 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <ak1NTrmM2YaMW5Nr@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>

On Wed, Jul 01, 2026 at 05:54:48PM +0200, Christian Brauner wrote:
> I remain very confused by our coding assistant contribution guidelines.
> I'm going to be a bit polemic now but this seriously in good faith.
>
> Why precisely do we require all this detailed information about what
> specific coding assistant was used?
>
> I find it very irritating that our git history has effectively started
> to function a bit like a free advertising platform for a bunch of AI
> companies and their proprietary agents and models.
>
> And it reamins unclear to me what exactly we do get out of this detailed
> information: Do we want to run statistical analysis on what agent and
> model is used the most and publish that on LWN at some point?
>
> I acknowledge that my stance is even more radical: imho we would just
> stop it with any disclosure requirements completely. It's useless imho.
> We already see that other than core contributors most people don't care
> and will just not disclose their usage of AI. I think this is entirely
> pointless and worse it brings in undefined legal status as well. It's
> not like recent events of pulling certain models from the face of the
> earth have made this any less concerning.
>
> But fine, if we want to do this can we please just dumb it down to
>
> Assisted-by: LLM
>
> or
>
> Assisted-by: Coding Assistant
>
> or something else. That still gives the "careful review" signal to
> reviewers that want to pay special attention to LLM generated work while
> avoiding this slew of metadata.
>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

FWIW I'm fine with this. We can always send the comment stuff as a follow up. So:

Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>

Maybe send it non-RFC with a cleaned up commit msg? Feel free to add my tag to
that.

> ---
>  Documentation/process/coding-assistants.rst | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index 899f4459c52d..fe34f3e7e828 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -43,12 +43,8 @@ When AI tools contribute to kernel development, proper attribution
>  helps track the evolving role of AI in the development process.
>  Contributions should include an Assisted-by tag in the following format::
>
> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> +  Assisted-by: LLM [TOOL1] [TOOL2]
>
> -Where:
> -
> -* ``AGENT_NAME`` is the name of the AI tool or framework
> -* ``MODEL_VERSION`` is the specific model version used
>  * ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
>    (e.g., coccinelle, sparse, smatch, clang-tidy)
>
> @@ -56,4 +52,4 @@ Basic development tools (git, gcc, make, editors) should not be listed.
>
>  Example::
>
> -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> +  Assisted-by: LLM coccinelle sparse
>
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260701-work-coding-assistants-650ae1202ee0
>

Cheers, Lorenzo
