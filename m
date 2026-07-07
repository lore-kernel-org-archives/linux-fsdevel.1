Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CA93E7BC7;
	Tue,  7 Jul 2026 12:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428036; cv=none; b=C5huw3LR3vD2rkBvNXffXyZOhWQKcYxL4xRsl07az7uCOuUUfBTKsn1tGfjRIm+H7vuZxrrw74nYESJwb78AdQIVvEiFmDqmW/M/tpMBPlcjxKLes1CncAsp+eLoeumCuU5TqenYCsNsoK9/tCq+o8SM1HY7/UyGoegcVTon+Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428036; c=relaxed/simple;
	bh=n0xUh5OGPh9z2w0Sp46nckGuiAEOctFlK6hVKNx2f1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R//Q7eNMPqTbL9RQdnIwLKG/s5Q2o+B5+4LOCJ6RoBWezugJKGvXC3bZ+OQBJW4HzzbwESqgg5sKOJY5ufCxU1JIMYfUXfL1J1x3Ad5GjxnsEaOeYxJUHYOZ/M8gExr8DTYBlEmjGjqDemFY5byRon2QKryyPB9vqfJzafntp+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=pr9ECtD8; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="pr9ECtD8"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9C012673;
	Tue,  7 Jul 2026 14:39:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783427983;
	bh=n0xUh5OGPh9z2w0Sp46nckGuiAEOctFlK6hVKNx2f1c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pr9ECtD8qCdWzZnArS158+LZBum436RpE+whkULJndc87+LXTAapOABZb++49Rzho
	 iUXVsO5t0uLygtqVudGC1v2lgcxflnEP2GsS3Xe3fvRWugXvubQUOw+/c6Nj4ec5Hu
	 QiAE+KFiICDstz+Lw30atdZ648Rl/NBHRS2DmexU=
Date: Tue, 7 Jul 2026 15:40:31 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Boris Burkov <boris@bur.io>,
	Jeff Layton <jlayton@kernel.org>,
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
Message-ID: <20260707124031.GC211515@killaraus.ideasonboard.com>
References: <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>

On Tue, Jul 07, 2026 at 11:49:31AM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 11:20, Lorenzo Stoakes wrote:
> > On Fri, Jul 03, 2026 at 08:22:20PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/3/26 18:32, Laurent Pinchart wrote:
> >>>
> >>> I'd support a patch that replaces
> >>>
> >>> Assisted-by: Claude:claude-3-opus coccinelle sparse
> >>>
> >>> with
> >>>
> >>> Assisted-by: LLM # generate some test cases
> >>>
> >>> and rewrites the Attribution section of
> >>> Documentation/process/coding-assistants.rst accordingly.
> >>>
> >>> I think most people in this mail thread have expressed that how
> >>> generative AI was used is the most important information, and several
> >>> people (including myself) have expressed a desire to stop the free
> >>> advertising. Unless I missed something, I don't think anyone has
> >>> expressed an interest in keeping the agent name and model.
> >>
> >> Yes, that's something I would enjoy seeing. Who reading along has a problem with
> >> that? (assuming that the tag must stay)
> > 
> > I think the silence suggests nobody :)
> > 
> > What we could do is send a patch to simply add a section on adding a comment
> > explaining _what_ used an LLM and strongly suggesting it would be helpful to do
> > so.
> > 
> > That should hopefully be uncontroversial, then later (or alongside that?) we
> > could submit an RFC for making the language move to 'you MUST do this', as that
> > will probably be the more controversial bit.
> 
> Maybe we should just spell out about which scenario we care about where we really
> expect the disclosure.
> 
> Sure, it might be more controversial and we could have that in a separate patch.
> 
> I was thinking of the following end result:
> 
> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index 899f4459c52d2..4c2ab4dfc6da7 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -40,20 +40,37 @@ Attribution
>  ===========
>  
>  When AI tools contribute to kernel development, proper attribution
> -helps track the evolving role of AI in the development process.
> -Contributions should include an Assisted-by tag in the following format::
> +helps track the evolving role of AI in the development process. Further,
> +for reviewers and maintainers it is also crucially important to know how
> +AI tools were used.
>  
> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> +Contributions that used AI to generate significant portions of code,
> +comments, or patch descriptions must include an Assisted-by tag in the
> +following format::
>  
> -Where (preferred):
> +  Assisted-by: LLM # brief description of usage
> +
> +Or alternatively::
> +
> +  Assisted-by: AGENT_NAME:MODEL_VERSION # brief description of usage

I would like to drop this one. As I understand, several people objected
to including the product name in the git history as it is just free
adverising, and nobody objected to dropping it.

> +
> +Where::
>  
>  * ``AGENT_NAME`` is the name of the AI tool or framework
>  * ``MODEL_VERSION`` is the specific model version used
> -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> -  (e.g., coccinelle, sparse, smatch, clang-tidy)
> +
> +If other tools were used, they should be specified through a dedicated
> +Assisted-by tag in the following format::
> +
> +  Assisted-by: [TOOL1] [TOOL2]
> +
> +Where ``[TOOL1] [TOOL2]`` are specialized analysis tools used
> +(e.g., coccinelle, sparse, smatch, clang-tidy)
>  
>  Basic development tools (git, gcc, make, editors) should not be listed.
>  
> -Example::
> +Examples::
>  
> -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> +  Assisted-by: LLM # translate patch description
> +  Assisted-by: Claude:claude-3-opus # generate most of the code
> +  Assisted-by: coccinelle sparse
> 
> 
> But I am not really sure why we should specify other tools here, really.
> People usually do that as part of the patch description, including sharing
> coccinelle scripts etc.

We've mentioned coccinelle usage in commit messages, with a copy of the
semantic patch, for years and years and I'm not aware of anyone giving a
technical reason why we need a tag instead. The only reason I see is to
avoid pointing specifically at LLMs and normalize their usage as "just
another tool". That's a political reason, not a technical one.

> Because looking at the history:
> 
> $ git log | grep "Assisted-by" | grep -E "(coccinelle|sparse|smatch|clang)"
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle
>     Assisted-by: unnamed:deepseek-v3.2 coccinelle

-- 
Regards,

Laurent Pinchart
