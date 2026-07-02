Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353BB47DD45
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 13:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997761; cv=none; b=kS47tauAJ3lLilLxw3op61py64COFVpDm+tY/3G6mAzFTJ2wMcta4/YOLGGO4u8FqEkg3pKQ5VIrA4U5EmbZlFmsNVqI+OTRdaIR/7zGhhTjulv1mapQpxICjkE75h8IWZ4cBcwlBMQPeUibYXbWhEv5S8Q24M2Z2ZZepLbJGpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997761; c=relaxed/simple;
	bh=fiJrezrPzd/66Esvi9NNyo7ek1v+7YfLuLcqu8NbMQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY7FftwqyGYLiVYcGzazQdidpt1NeWW7e5KXoLQnYt81JOTm5jXadWEMFSOcahEnkl8kY9ONd0xiTgBzlYjDff4YoYiXAhoIvtPAxavVOxHtU+4CRcN8T/o9jDkfVwBYEna1V1IPrHNNPjL1Ec3YqbTIOrzi6+j44X5XQTLzQbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlm02BNW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlm02BNW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782997758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pk2pYhN52w0a/kFsyxeCmsifCUQ0v8hhl1JGZ0yb2rk=;
	b=Tlm02BNWHxjhSpiSLQKyFHEK3Se9n+OgBnkaoJOUZo5VA3FjeXIdZaSEMtgKNdq5VQDJCl
	cSDAChcl1xSUrvjJO4lT7JqEdGOsUtbasP6HpjXG3zUNzbiWIembhwnimtV2bxHbjO7XHO
	iK9Xw4NcwXIo6XeqV3lIHZJTx0r7VeA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-9HHLOQTTMlCktmfHsFKvaQ-1; Thu,
 02 Jul 2026 09:09:13 -0400
X-MC-Unique: 9HHLOQTTMlCktmfHsFKvaQ-1
X-Mimecast-MFC-AGG-ID: 9HHLOQTTMlCktmfHsFKvaQ_1782997751
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C51CB1944EB6;
	Thu,  2 Jul 2026 13:09:10 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.59])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29A923001D87;
	Thu,  2 Jul 2026 13:09:08 +0000 (UTC)
Date: Thu, 2 Jul 2026 09:09:05 -0400
From: Brian Foster <bfoster@redhat.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
Message-ID: <akZi8XmYA0XUCx2-@bfoster>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZW1RPqTc-4_7jW@lucifer>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

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

Interesting.

> But then it becomes an arms race. People will get AI to try to defeat AI
> detection. So I'm not sure it's a safe road to go down.
> 

Yeah that's fair, but my thinking is the goal would be more to detect
slop content as opposed to just LLM usage. The trend of these
discussions has been that we generally don't care too much about LLM use
in general when it's used properly as a tool, but rather as you stated
earlier we want to be able to quickly dismiss slop to avoid wasting
maintainer and reviewer time.

It seems like we're generally able to sniff out pure LLM generated
content in most cases. That suggests we should be able document some
common patterns that tend to describe slop such that an LLM bot could
detect and flag it. For example, "Slop bot has detected comments have
LLM prose and just repeat what the code does," "Slop bot has detected
unnecessary code volume and duplication," etc. etc.

So the idea with that would be that defeating the slop bot is the point.
Consider it a sort of informal/minimal goal before a submitter is
entitled to human review. But yeah, I guess it's still just a handwavy
theory that you'd be able to reliably disentagle detection of general
LLM code generation from something that more qualifies as LLM slop. Just
thinking out loud.

Brian

> >
> > Brian
> >
> 
> Thanks, Lorenzo
> 

