Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646C13859FC;
	Thu,  2 Jul 2026 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985460; cv=none; b=BD1WnGh8WP/Fs6neIGXMypHlW6YP58tvhNJu9keC78CHvVIxIit4N1y5jJNSWkJPOOvY6Fh0/qz3iTTCea7LcuLu8KGNoN4KgyMzBcLdEfmw+KkGHwGowRIIfJgjwx5fVO9116T2au+T80mz+TK0Z/l45ec+JROz1EG7k+Teyys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985460; c=relaxed/simple;
	bh=6OKVbkbqcH6Fn6AMPx7ZC9iOfkmYA0nPzMprU6lSMmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFNZNqgLfAgEJG2JSLYOzlzGMSKcLbR4a6sKHl4k+0LTdkuiidk65Ve6Q3+mKZdBnY0EN3fAF7u+KKbQgRLnfQownGpAdWmzPQTNhn5V3+MYyEz3abx+nmuJ/dSme8fSWQcoKffl/zQgeM8TBbkkSTEda+YhM8HmPuD5s8CZT2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvrmsTRZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvrmsTRZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0351F000E9;
	Thu,  2 Jul 2026 09:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985459;
	bh=6OKVbkbqcH6Fn6AMPx7ZC9iOfkmYA0nPzMprU6lSMmo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KvrmsTRZp0bhiZure/2sCA1cLY3F0cPcgXL6Rih01X+q1+eXgHaR6ldSd8JKQE6RH
	 y30XASYWpRprT08c8w5U3TdFHD5WJSK0fv2PA3vONIbFoonUe4WZI5/MVg+h6nu9ZT
	 t56BqyO06qhgJtt2NJQ/oEqAocPqk19VMON4lpJgsM+MfalXJa2F2FsHSTUicOp50p
	 D6k3DVo+hRcpLfeR0oVgF2xK33angsI+Otle0Z7U4jYiLkbRzDEVPwXG0rjIiwSYe9
	 Sh2G7r3TOHDjfCOzFPQpWVEwvSRdj+VCKiNdGckbdM7l5vtOjvhzHb9BnvM8ZHih3p
	 qXT6Go1XT+mQg==
Date: Thu, 2 Jul 2026 10:44:09 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Christian Brauner <brauner@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYx9blvVhIXB5A-@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702093844.GA3491311@killaraus.ideasonboard.com>

On Thu, Jul 02, 2026 at 12:38:44PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 10:44:34AM +0200, Vlastimil Babka (SUSE) wrote:
> > On 7/2/26 10:12, Jori Koolstra wrote:
> > > Ah, I still reigniting this discussion again :)
> > >
> > > What about a combination of what David and Jeff say? The whole point
> > > seems to me that the salient information is not that an LLM was used (or
> > > are we going to tag Sashiko as well or any other LLM-based code review
> > > tool?), but what is was used to do. This information may be relevant for
> > > how the review is approached. The latter should perhaps only be in the
> > > cover letter and then we can drop the assisted-by tags altogether.
> > >
> > > The question about enforcement remains.
> >
> > It's not possible to enforce it. People can deny it if the tag is missing
> > and you confront them and even though the submission has many signs of being
> > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > proof!) that happen in mm.
> >
> > Such situation then penalizes those who disclose so obviously they won't.
>
> I think there's also a penality for those who don't disclose when
> they're told they should: it will lower trust. Kernel development is
> largely based on a trust model. If a contributor decides to adopt a
> deceiptful behaviour, they can expect maintainers to raise the bar for
> accepting patches, when not rejecting them outright.

Yes, I explicitly said this in response to somebody for whom there was
overwhelming evidence they were submitting AI slop, and that they'd need to
build it back up again.

It's precisely the issue as I see it.

But others within the community disagreed with me, so it turned into a very
long and draining discussion that I don't particularly wish to repeat.

So we really need clarity on it being OK to do this (I remember saying this
last year when I made an ultimately unsuccessful submission to the
maintainer's summit about all this :)

What matters overall is being able to _quickly_ dismiss AI slop so that
asymmetry between LLM generation + maintainer time isn't exploited.

And ultimately I think the trust model will end up being 'newcomes have 0,
now build it up'.

Which sucks but this issue is simply existential for open source.

>
> I can't quantifying which of the penalities will be higher, but I hope
> (call me naive if you wish) that the vast majority of contributurs who
> *know* we require disclosure to abide by that rule, even if it incurs a
> penalty. After all, proponents for LLM usage claim such performance
> improvements that a small penalty during review can't be that bad, right
> ? :-)
>
> > We
> > should drop the tag and instead think how we can empower maintainers to be
> > able to use their own judgment and deprioritize dealing with what they
> > perceive as LLM slop, without fearing consequences of not being properly
> > responsible etc, and not rely on any non-enforceable tags for that.
>
> --
> Regards,
>
> Laurent Pinchart

Thanks, Lorenzo
