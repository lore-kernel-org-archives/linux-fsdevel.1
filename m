Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1054A2E16;
	Thu,  2 Jul 2026 13:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782998743; cv=none; b=c116GdMhG7waVa8F7Vhts7QNA9kcoUd1J7pyL6Gb46IOvRf05pFgg8ooAvpjnkRDsoYjYEsyB8AE+2ku+HU0R00vszeXoIPeOFAymogAi//w+MMTeHb8bOCQImEcRt1Er0IYRTDsNr5zgPiplSG4XJQKQjERM/MK0PC5avcjfc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782998743; c=relaxed/simple;
	bh=cYAm9nlSexe7nKSLuQUVU8DabenGTVMaWZc0yXMFmt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVmBqlahh3XIYlYyN4T/M9rjJFPYiETPnZqSOs1zlPobtbCeDh/hEDSvpx/7oUIeKYC0q4gOwra4gv5t9tNnqgPTC6QoMDZgmcVNu26T47RpK4VBgE7TMKafZ4rMSJKzLblhNDQnRqxauJi3SoQK1ZfGt2CYGj6soBxIJNtJHn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Viy+MX3w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viy+MX3w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA431F000E9;
	Thu,  2 Jul 2026 13:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782998741;
	bh=cYAm9nlSexe7nKSLuQUVU8DabenGTVMaWZc0yXMFmt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Viy+MX3wVZESV/1DQnGAItDqvZFVIbnPdrLsUaJvq+WZqxYGfqcuA8ZT/RgeoTvy7
	 TAyNh4Y6hODqW5PXnsHvVLOw8vUiU7wEvaKk0qPVZhBebMsUDqDbQ7vThzgePEtM/0
	 WVg0ON8hmzG7x5hQvMFzELCVjsgKrftNO+vAuBYSs+QZe61GZavlOFLmLCp8CV1MrE
	 WxQjVK5riBQqDfbnSEUigVIXIlPc8T44ji4M3lic499hC008pwz3pTmYKWQsNbTRgX
	 xUQnohoZWlsWqrZEvQQJFYS5ODdgsmjk96aQ18Z/EXUEZKPlJSkVJZkSjxlDb4n0ZT
	 VtNsqdw8tdu6A==
Date: Thu, 2 Jul 2026 14:25:31 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZmJgbSdyM2Ww-t@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
 <akYx9blvVhIXB5A-@lucifer>
 <akZSOa4awK5l9x_w@bfoster>
 <akZW1RPqTc-4_7jW@lucifer>
 <akZi8XmYA0XUCx2-@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZi8XmYA0XUCx2-@bfoster>

On Thu, Jul 02, 2026 at 09:09:05AM -0400, Brian Foster wrote:
> On Thu, Jul 02, 2026 at 01:18:06PM +0100, Lorenzo Stoakes wrote:
> > On Thu, Jul 02, 2026 at 07:57:45AM -0400, Brian Foster wrote:
> > > On Thu, Jul 02, 2026 at 10:44:09AM +0100, Lorenzo Stoakes wrote:
> > > > On Thu, Jul 02, 2026 at 12:38:44PM +0300, Laurent Pinchart wrote:
> > > > > On Thu, Jul 02, 2026 at 10:44:34AM +0200, Vlastimil Babka (SUSE) wrote:
> > > > > > On 7/2/26 10:12, Jori Koolstra wrote:
> > > > > > > Ah, I still reigniting this discussion again :)
> > > > > > >
> > > > > > > What about a combination of what David and Jeff say? The whole point
> > > > > > > seems to me that the salient information is not that an LLM was used (or
> > > > > > > are we going to tag Sashiko as well or any other LLM-based code review
> > > > > > > tool?), but what is was used to do. This information may be relevant for
> > > > > > > how the review is approached. The latter should perhaps only be in the
> > > > > > > cover letter and then we can drop the assisted-by tags altogether.
> > > > > > >
> > > > > > > The question about enforcement remains.
> > > > > >
> > > > > > It's not possible to enforce it. People can deny it if the tag is missing
> > > > > > and you confront them and even though the submission has many signs of being
> > > > > > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > > > > > proof!) that happen in mm.
> > > > > >
> > > > > > Such situation then penalizes those who disclose so obviously they won't.
> > > > >
> > > > > I think there's also a penality for those who don't disclose when
> > > > > they're told they should: it will lower trust. Kernel development is
> > > > > largely based on a trust model. If a contributor decides to adopt a
> > > > > deceiptful behaviour, they can expect maintainers to raise the bar for
> > > > > accepting patches, when not rejecting them outright.
> > > >
> > > > Yes, I explicitly said this in response to somebody for whom there was
> > > > overwhelming evidence they were submitting AI slop, and that they'd need to
> > > > build it back up again.
> > > >
> > > > It's precisely the issue as I see it.
> > > >
> > > > But others within the community disagreed with me, so it turned into a very
> > > > long and draining discussion that I don't particularly wish to repeat.
> > > >
> > > > So we really need clarity on it being OK to do this (I remember saying this
> > > > last year when I made an ultimately unsuccessful submission to the
> > > > maintainer's summit about all this :)
> > > >
> > > > What matters overall is being able to _quickly_ dismiss AI slop so that
> > > > asymmetry between LLM generation + maintainer time isn't exploited.
> > > >
> > > > And ultimately I think the trust model will end up being 'newcomes have 0,
> > > > now build it up'.
> > > >
> > > > Which sucks but this issue is simply existential for open source.
> > > >
> > >
> > > Has anybody tried throwing any of the obvious LLM slop submissions we
> > > have seen into one of these LLM detector things? To be clear, I've never
> > > tried those so I'm certainly no authority on if they even work reliably,
> > > but if so I wonder if something like that is a potential solution for
> > > elminating the worst cases..
> > >
> > > I.e., suppose we had some Sashiko type LLM/bot whose job was mainly to
> > > detect purely LLM generated content based on some minimum level of
> > > confidence and reply with a loud and clear message to the thread. Maybe
> > > that would be a clear enough signal to maintainers and reviewers that
> > > something is not worth prioritizing for review.. Maybe also some "slop
> > > detected" feedback would help disincentivize flinging slop onto the
> > > lists. At the very least that could be something that is more easily
> > > configured/enabled per-subsystem without having to use per-subsystem
> > > commit tags.
> >
> > Yup I thought of this, have done this on series and they do detect it
> > reliably.
> >
>
> Interesting.
>
> > But then it becomes an arms race. People will get AI to try to defeat AI
> > detection. So I'm not sure it's a safe road to go down.
> >
>
> Yeah that's fair, but my thinking is the goal would be more to detect
> slop content as opposed to just LLM usage. The trend of these
> discussions has been that we generally don't care too much about LLM use
> in general when it's used properly as a tool, but rather as you stated
> earlier we want to be able to quickly dismiss slop to avoid wasting
> maintainer and reviewer time.
>
> It seems like we're generally able to sniff out pure LLM generated
> content in most cases. That suggests we should be able document some
> common patterns that tend to describe slop such that an LLM bot could
> detect and flag it. For example, "Slop bot has detected comments have
> LLM prose and just repeat what the code does," "Slop bot has detected
> unnecessary code volume and duplication," etc. etc.

Yep it might be helpful.

But it turns out this is more contentious than you might think, and it might be
a hard sell.

>
> So the idea with that would be that defeating the slop bot is the point.
> Consider it a sort of informal/minimal goal before a submitter is
> entitled to human review. But yeah, I guess it's still just a handwavy
> theory that you'd be able to reliably disentagle detection of general
> LLM code generation from something that more qualifies as LLM slop. Just
> thinking out loud.

Yeah tbh it'd not be perfect but I wouldn't mind if we did this.

Some information > no information.

>
> Brian
>
> > >
> > > Brian
> > >
> >
> > Thanks, Lorenzo
> >
>

Thanks, Lorenzo
