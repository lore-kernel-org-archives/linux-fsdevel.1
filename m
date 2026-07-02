Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4F53988EB;
	Thu,  2 Jul 2026 12:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996808; cv=none; b=D2zoL3chb97DrDHUdDVcfeCWCCCWGUH/NMi0ssj1RNEhTsFu4iLc5MbO7/rCv02dpU1ynt/IrDX5huT6/6hCiWpsgFSlohneIAUFP5qRaO2xUb630Q50/24vPxhNCmzW/pg5dkNu8WuqrJUL+CR8mp9GAw0Z70qgnohOEGKWpmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996808; c=relaxed/simple;
	bh=KnYaGPytNowltYvOHn+39oUPEQvt8u9kntm9HjtpUXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eQEva189rFr+HSIqABx+sLpvqEmQvTvxaQP1Wd2VY1yfIzc4MmHTNjGOm2d31rroJ/seZ+Rv+cJX0umo+g1xpZOljyene3bu9pI3P8CB4omr2VekmLu8opJWB3SehKAef8G/bz3nv1Vxbzx7W8nKr8u5sDM01VqNVycGy5/hp+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6R53IfS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6R53IfS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED72F1F000E9;
	Thu,  2 Jul 2026 12:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782996806;
	bh=KnYaGPytNowltYvOHn+39oUPEQvt8u9kntm9HjtpUXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=f6R53IfS5kX5G2QfT1OGVtE7NxG8Zqca80nOcgAwlnIYUxMIWpa/5AAa3ZLWKcQ1b
	 4hCvUATj5mIUfCYLTm1AQgs4EvX0A1YvHSqk6bflrACha4Gq50dYnqgJJdMwftgLiE
	 GI5XH3YoZm5FZ9jY6GNzOHFk4Kp+yt4ZJJc2wncFnnc2soKuJA7gTmhjmhj+NkKHp5
	 P8q+ZFpa2APMrRGqoseKkXh0igOGBJy/eZQiphAlW5s581mIwe6OEFzMYThd3zdgv6
	 PGodZD1Um779Yx6tRvHUvX0OFUGuuiPKxlKeJ6AfXTQ708Mfngrb3XFVh+qksbKl5J
	 MpMLhy6wnkUgA==
Date: Thu, 2 Jul 2026 13:53:17 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZeZ9GTjSp1L58S@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <afd0635c-1903-4c7b-8023-cbcd1823e081@kernel.org>
 <akZXGJSy0FA3kQ3-@lucifer>
 <a4406124-2d0c-4703-9ee6-174af94d6fd9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4406124-2d0c-4703-9ee6-174af94d6fd9@kernel.org>

On Thu, Jul 02, 2026 at 02:39:53PM +0200, Krzysztof Kozlowski wrote:
> On 02/07/2026 14:23, Lorenzo Stoakes wrote:
> > On Thu, Jul 02, 2026 at 12:34:34PM +0200, Krzysztof Kozlowski wrote:
> >> On 02/07/2026 10:44, Vlastimil Babka (SUSE) wrote:
> >>> On 7/2/26 10:12, Jori Koolstra wrote:
> >>>> Ah, I still reigniting this discussion again :)
> >>>>
> >>>> What about a combination of what David and Jeff say? The whole point
> >>>> seems to me that the salient information is not that an LLM was used (or
> >>>> are we going to tag Sashiko as well or any other LLM-based code review
> >>>> tool?), but what is was used to do. This information may be relevant for
> >>>> how the review is approached. The latter should perhaps only be in the
> >>>> cover letter and then we can drop the assisted-by tags altogether.
> >>>>
> >>>> The question about enforcement remains.
> >>>
> >>> It's not possible to enforce it. People can deny it if the tag is missing
> >>> and you confront them and even though the submission has many signs of being
> >>> obviously LLM, there is no definite proof. We've seen (likely, as there's no
> >>> proof!) that happen in mm.
> >>>
> >>> Such situation then penalizes those who disclose so obviously they won't. We
> >>> should drop the tag and instead think how we can empower maintainers to be
> >>> able to use their own judgment and deprioritize dealing with what they
> >>> perceive as LLM slop, without fearing consequences of not being properly
> >>> responsible etc, and not rely on any non-enforceable tags for that.
> >>
> >> +1
> >>
> >> I see no benefits of enforcing the tag for these exact reasons. Every
> >> LLM slop will miss the tag. OTOH, seeing reasonable contribution with
> >> the tag makes my spider-senses tingling and causing unnecessary
> >> prejudice. If the contribution is reasonable, how does the tag
> >> information helps me? I trust (or not) the person, regardless what tool
> >> they use.
> >>
> >> And if we think about any future possible copyright issues with LLM
> >> contributions (like if there is ever a ruling that model trained on BSD
> >> data creates BSD-derivative work etc), does that tag anyhow solve it?
> >> Like if that ruling appear we will go through the history and revert the
> >> commits?
> >
> > Why would you take information _away_ from maintainers?
> >
> > You're making every LLM 'accusation' a risk for a maintainer because you might
> > get the 'how dare you accuse me of using an LLM rah rah rah' response.
> >
> > Why not eliminate that in at least some cases?
>
> Because I don't think we will be able to enforce that information,
> therefore it is close to pointless.

'We can't have complete data so let's have no data'

Not sure that's convincing, sorry.

>
> And if you ask about future copyright issues, I simply do not believe
> the tags will matter based on argument (repeating): what are you going
> to do with that information that commit was involving LLM tool which now
> received some copyright-related verdict?

And if undisclosed, but detectable by LLM checks or otherwise evidenced...? Not
sure you can argue 'no point in tags because people don't use them' but also
'copyright issues only with tags'.

Anyway I think this is likely to be a non-issue given global regulatory trends
on this stuff.

>
> >
> > I continue to be baffled at people's opposition adding a single line to emails,
> > or a single little comment on the end of it.
> >
> > I do agree with Vlasta that we need to have a clearer way to just say no (TM) if
> > we strongly suspect an LLM.
>
> This part is not being discussed by me and I think the thread itself is
> not about it.

Well ok on your part, but I think it's clearly part of it, quoting Vlasta:

"instead think how we can empower maintainers to be able to use their own
judgment and deprioritize dealing with what they perceive as LLM slop, without
fearing consequences of not being properly responsible etc, and not rely on any
non-enforceable tags for that."

>
> >
> > I had a very unpleasant experience dealing with blowback for doing that in a
> > _very_ blatant case and I'd rather not repeat it if it's at all possible.
>
> Well, I made here the point already - that blatant blowback and any
> future similar slop will not use any tags, thus the tags do not solve
> that problem.
>
> Basically having the tag solves no problems we experience. The tags are
> worthless in problem solving...

Well in my actual experience of doing review I am finding them useful as a
low-cost way of being able to bring up LLMs.

Some information > no information.

And requiring disclosure makes not disclosing an easier sell. If we drop it then
people will take that as carte blanche to do whatever.

>
> Best regards,
> Krzysztof

Thanks, Lorenzo
