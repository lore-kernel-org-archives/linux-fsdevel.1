Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3173C39A801;
	Tue,  7 Jul 2026 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783418151; cv=none; b=oKlpnrfa2vFNZlCe14CAFCjWEdoqNpZoAA1qlIe5Zal7a01u45dpxqtanC32hGlgP0fLNfKv03x8nae2P19hmn8FeeEonYrmjIObMysFLuDA4fDdwTRgxl+tT1nItHQi6R3y4extTzUZIRhScAuwTaraJsi47fswYMNjp+6BQKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783418151; c=relaxed/simple;
	bh=bRXijf6pN8R3U02xRaYPPiarq8OJih9lODmiR0gQ0zA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLS7SDBgPcd/SVnrxgxMrD/5qrzSYTD5uJ2rshWZaaHpi5koRk72eBMSdVnsp4+R6iYnuw69m6SABXuw1nMqIEzfupnZfLQFR6KkFTRVQS9pMhReu5BlylbsF+v8ZSoK0SnBk6Lp9pc3/LD3pFgFen9WC2ckkcUigBLgJdh9iZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtT/TmHl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtT/TmHl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F0A1F000E9;
	Tue,  7 Jul 2026 09:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783418149;
	bh=4eShXnZjQrBZzD7tSod9FxJY+zcWPKsuMcAi+5dgtOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UtT/TmHlfkXLJe1+62NT4v9iduzzRGtwma0XqhhBGhnDvlO3aJcxbtTDD4PCsqBQ9
	 ETU+7p2tLcI766xFLMiIbBhqPXoTvlXRvCDIo/cfk5nVTBubHJRFUNxLGGrh0vfepn
	 1UMn5R/vbQK1qk1ctZkiZoqJgdR/7LOJ5Z43QvGt1QRsvohYgwqngKP3pEt//sSSsR
	 7SbT+toOSlDvbPhyPOeYGCs7s9TOE278MxMOnbLvktUxDbd2gP1qENRHs6kFg4LOJK
	 yYDFGB0hUGZKTQh9skRJ3l+2B/1gqP97UFK6axfdiKjb5IMiYodF2QAvVecw0r1P6o
	 79hsf72IJFrkw==
Date: Tue, 7 Jul 2026 10:55:35 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Justin Stitt <justinstitt@google.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akzMh-ySQ2fN0d8R@lucifer>
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
Content-Type: text/plain; charset=us-ascii
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

LGTM! Do you want to send that then? People can comment on the actual path then
(probably worth cc'ing everybody here on that also).

>
>
> But I am not really sure why we should specify other tools here, really.
> People usually do that as part of the patch description, including sharing
> coccinelle scripts etc.
>
> Because looking at the history:
>

(for succinctness :P)

$ git log | grep "Assisted-by" | grep -Ei "(coccinelle|sparse|smatch|clang)" | wc -l
30

Yeah, doesn't seem much used, but I guess for the non-controversial version
worth keeping that stuff around in the doc.

> --
> Cheers,
>
> David

Cheers, Lorenzo
