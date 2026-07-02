Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339B948C8A1;
	Thu,  2 Jul 2026 13:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997673; cv=none; b=UO9QrICou+24Di3QWxxclhSVW9nsYL+/26vO3dXP5D3v4s0gBi/0I/S9+pf1OBkzhKVlDkN/qzK1Qwai6KWndrGhZKZQJnsGC8VIP1UEdPv8dhU4QrRaEHddTvxOfFfA+Mi6NqLspAp3RVGXb42lTrWVmbsXopuaXrqLPfos2mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997673; c=relaxed/simple;
	bh=5dr//tfMOhqPbri/FQ9+o/A+RTH+vCjcdGSY4+mZ/MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JUG6zPtuZ9u0B452B0Cp7RZg1ot5aL2CSGJominW/M36fwixWjOCRhmQzjwGcHdNJfHrSGkYde0px0XDsvHCYCgXejnr/DkBDgL9122jhq7o1Yazc5lnXuaXXgOciLl0tM5aXsI+XyZFFaYMCiMZD363UXq0UbxSzYYwmkO3Ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=BT/gjmaH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="BT/gjmaH"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0C7423A2;
	Thu,  2 Jul 2026 15:06:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782997617;
	bh=5dr//tfMOhqPbri/FQ9+o/A+RTH+vCjcdGSY4+mZ/MM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BT/gjmaHIxgKrSuuqeYr7xoSarPN2c/U2bL2Yka6+jzeWLInWwmx4b4TYMbGy7mFV
	 RdnY4dqK26RSVLzCNV5TcdsI4FDXGM6Apvw/x11LMM7bQJIThpoZO+9aQ8adhcJj2s
	 5xdHwDyAblqt6adcasCPd2YeBMXDq32QeitSIuV4=
Date: Thu, 2 Jul 2026 16:07:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Brian Foster <bfoster@redhat.com>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702130740.GB3534761@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
 <akYx9blvVhIXB5A-@lucifer>
 <akZSOa4awK5l9x_w@bfoster>
 <akZW1RPqTc-4_7jW@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akZW1RPqTc-4_7jW@lucifer>

On Thu, Jul 02, 2026 at 01:18:06PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 07:57:45AM -0400, Brian Foster wrote:
> > On Thu, Jul 02, 2026 at 10:44:09AM +0100, Lorenzo Stoakes wrote:
> > > On Thu, Jul 02, 2026 at 12:38:44PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Jul 02, 2026 at 10:44:34AM +0200, Vlastimil Babka (SUSE) wrote:
> > > > > On 7/2/26 10:12, Jori Koolstra wrote:
> > > > > > Ah, I still reigniting this discussion again :)
> > > > > >
> > > > > > What about a combination of what David and Jeff say? The whole point
> > > > > > seems to me that the salient information is not that an LLM was used (or
> > > > > > are we going to tag Sashiko as well or any other LLM-based code review
> > > > > > tool?), but what is was used to do. This information may be relevant for
> > > > > > how the review is approached. The latter should perhaps only be in the
> > > > > > cover letter and then we can drop the assisted-by tags altogether.
> > > > > >
> > > > > > The question about enforcement remains.
> > > > >
> > > > > It's not possible to enforce it. People can deny it if the tag is missing
> > > > > and you confront them and even though the submission has many signs of being
> > > > > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > > > > proof!) that happen in mm.
> > > > >
> > > > > Such situation then penalizes those who disclose so obviously they won't.
> > > >
> > > > I think there's also a penality for those who don't disclose when
> > > > they're told they should: it will lower trust. Kernel development is
> > > > largely based on a trust model. If a contributor decides to adopt a
> > > > deceiptful behaviour, they can expect maintainers to raise the bar for
> > > > accepting patches, when not rejecting them outright.
> > >
> > > Yes, I explicitly said this in response to somebody for whom there was
> > > overwhelming evidence they were submitting AI slop, and that they'd need to
> > > build it back up again.
> > >
> > > It's precisely the issue as I see it.
> > >
> > > But others within the community disagreed with me, so it turned into a very
> > > long and draining discussion that I don't particularly wish to repeat.
> > >
> > > So we really need clarity on it being OK to do this (I remember saying this
> > > last year when I made an ultimately unsuccessful submission to the
> > > maintainer's summit about all this :)
> > >
> > > What matters overall is being able to _quickly_ dismiss AI slop so that
> > > asymmetry between LLM generation + maintainer time isn't exploited.
> > >
> > > And ultimately I think the trust model will end up being 'newcomes have 0,
> > > now build it up'.
> > >
> > > Which sucks but this issue is simply existential for open source.
> > >
> >
> > Has anybody tried throwing any of the obvious LLM slop submissions we
> > have seen into one of these LLM detector things? To be clear, I've never
> > tried those so I'm certainly no authority on if they even work reliably,
> > but if so I wonder if something like that is a potential solution for
> > elminating the worst cases..
> >
> > I.e., suppose we had some Sashiko type LLM/bot whose job was mainly to
> > detect purely LLM generated content based on some minimum level of
> > confidence and reply with a loud and clear message to the thread. Maybe
> > that would be a clear enough signal to maintainers and reviewers that
> > something is not worth prioritizing for review.. Maybe also some "slop
> > detected" feedback would help disincentivize flinging slop onto the
> > lists. At the very least that could be something that is more easily
> > configured/enabled per-subsystem without having to use per-subsystem
> > commit tags.
> 
> Yup I thought of this, have done this on series and they do detect it
> reliably.
> 
> But then it becomes an arms race. People will get AI to try to defeat AI
> detection. So I'm not sure it's a safe road to go down.

That would be my concern too.

At this stage, I think it's better to make sure people know our
expectations, and expect that the vast majority will understand it's a
trust-based system where being caught willingly breaching trust will
have a very high cost. Or have we reached a point where that doesn't
work any more ?

-- 
Regards,

Laurent Pinchart
