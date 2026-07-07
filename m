Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1102F3EFD36;
	Tue,  7 Jul 2026 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433891; cv=none; b=bdIOOUQvhOPrgl2x9YDRwx3vZMtTFq9MkXosgyZXWUoDMoheMvnI3HGiJSH76p7bpvph0HFLrj4QP+BDQftPxHBllOn3lZ0spX8o/VY1Ux9qZGOFKpn/ewzjdW1H0zFK7tvzWvpBxoDscqDTOOLa+VP8dVhqvuDBM1pCz+YoZtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433891; c=relaxed/simple;
	bh=7FXO0U8q0YSY+Zd9s0qRnAqixb03/I7Hq5cM4mWdmIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l++LsXPha5rbxNXebGIpKPI91M0DZkUzwNGqeITxBr8GXIiLgHERp+nsMG191pLYnPd/lyUV7tndBpd4kGmeasc+MWAPiGkIyFK2tyVt4Q36dRoacbq781Mrq9AxqwC9Kqi+sc++TdSs8F28FUIuGiJoBVhWQfUDZ8BQeMXfEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Iq+X1lY9; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Iq+X1lY9"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0D956673;
	Tue,  7 Jul 2026 16:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783433836;
	bh=7FXO0U8q0YSY+Zd9s0qRnAqixb03/I7Hq5cM4mWdmIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Iq+X1lY90EJPJ/V8foE1YjHXoKurBinqu/X/3ycpv54pzYaU1VipR1BuFbbh3mkjJ
	 qbCDUwlFojQOGLvibC7Tk1+bVKyVvjBZo4IUwjRdjmIoiyKB6MV201hkDwJLVTBWXV
	 ziDWrjvGr0v0IkgstDaZ9Iix8MadQ35/11p5Qcds=
Date: Tue, 7 Jul 2026 17:18:03 +0300
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
Message-ID: <20260707141803.GA254690@killaraus.ideasonboard.com>
References: <akaWnQ5Pkg_676B-@lucifer>
 <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>

On Tue, Jul 07, 2026 at 03:28:49PM +0200, David Hildenbrand (Arm) wrote:
> On 7/7/26 14:40, Laurent Pinchart wrote:
> > On Tue, Jul 07, 2026 at 11:49:31AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/7/26 11:20, Lorenzo Stoakes wrote:
> >>>
> >>> I think the silence suggests nobody :)
> >>>
> >>> What we could do is send a patch to simply add a section on adding a comment
> >>> explaining _what_ used an LLM and strongly suggesting it would be helpful to do
> >>> so.
> >>>
> >>> That should hopefully be uncontroversial, then later (or alongside that?) we
> >>> could submit an RFC for making the language move to 'you MUST do this', as that
> >>> will probably be the more controversial bit.
> >>
> >> Maybe we should just spell out about which scenario we care about where we really
> >> expect the disclosure.
> >>
> >> Sure, it might be more controversial and we could have that in a separate patch.
> >>
> >> I was thinking of the following end result:
> >>
> >> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> >> index 899f4459c52d2..4c2ab4dfc6da7 100644
> >> --- a/Documentation/process/coding-assistants.rst
> >> +++ b/Documentation/process/coding-assistants.rst
> >> @@ -40,20 +40,37 @@ Attribution
> >>  ===========
> >>  
> >>  When AI tools contribute to kernel development, proper attribution
> >> -helps track the evolving role of AI in the development process.
> >> -Contributions should include an Assisted-by tag in the following format::
> >> +helps track the evolving role of AI in the development process. Further,
> >> +for reviewers and maintainers it is also crucially important to know how
> >> +AI tools were used.
> >>  
> >> -  Assisted-by: AGENT_NAME:MODEL_VERSION [TOOL1] [TOOL2]
> >> +Contributions that used AI to generate significant portions of code,
> >> +comments, or patch descriptions must include an Assisted-by tag in the
> >> +following format::
> >>  
> >> -Where (preferred):
> >> +  Assisted-by: LLM # brief description of usage
> >> +
> >> +Or alternatively::
> >> +
> >> +  Assisted-by: AGENT_NAME:MODEL_VERSION # brief description of usage
> > 
> > I would like to drop this one. As I understand, several people objected
> > to including the product name in the git history as it is just free
> > adverising, and nobody objected to dropping it.
> 
> Yeah. I mean, we could go the following direction (dropping the models and
> encouraging also a description of usage for other tools), but not sure how
> much pushback we will get:

I haven't heard anyone involved in this mail thread objecting to the
concepts you translated into sentences below, so I think it's worth a
try. Of course there may be objections from people who are not aware of
this very conversation.

> diff --git a/Documentation/process/coding-assistants.rst b/Documentation/process/coding-assistants.rst
> index 899f4459c52d2..a085a15d59990 100644
> --- a/Documentation/process/coding-assistants.rst
> +++ b/Documentation/process/coding-assistants.rst
> @@ -40,20 +40,26 @@ Attribution
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
> -Where:
> +  Assisted-by: LLM # mandatory brief description of usage
>  
> -* ``AGENT_NAME`` is the name of the AI tool or framework
> -* ``MODEL_VERSION`` is the specific model version used
> -* ``[TOOL1] [TOOL2]`` are optional specialized analysis tools used
> -  (e.g., coccinelle, sparse, smatch, clang-tidy)
> +Similarly, usage of other specialized analysis tools should be
> +indicated through an Assisted-by tag in the following format::
>  
> -Basic development tools (git, gcc, make, editors) should not be listed.
> +  Assisted-by: [TOOL1] [TOOL2] # optional brief description of usage
>  
> -Example::
> +Examples for ``[TOOL1] [TOOL2]`` are coccinelle, sparse, smatch, and
> +clang-tidy. Basic development tools (git, gcc, make, editors) should not
> +be listed.
>  
> -  Assisted-by: Claude:claude-3-opus coccinelle sparse
> +Examples::
> +
> +  Assisted-by: LLM # translate patch description
> +  Assisted-by: coccinelle # batch conversion with small manual fixups
> davhil01@e142025:~/git/linux$ 

-- 
Regards,

Laurent Pinchart
