Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB347885D
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993483; cv=none; b=WUZHyLFCo4LCSKKMgoNMU3srYBb15Nv9P7L4J0JKPuu/GpuZGmNJ48crdJSJVT+aQFZWGGn9uCiZeQe2wLCcvkFbz4fUsHw3ZJocu+8pOILe/tJ/PEnldp8rF3cKONVNZf1k6w2yr1IAjXusCkpdsV/DZtrMQ+tCwjD2P5ohnvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993483; c=relaxed/simple;
	bh=ol1u6qHXQ2AZmxoHjQqoDN+JlTGFk0++bJU8o4AE304=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7GcGsRJ7cIo3YvSBrJr/2WBo/7Rd+WtZFBxzFTLoyS0epktQIr4q2XK6S81HQDqyaTrMh5fGJiEosL8WMhJ6SqSNSExE8j4JfdzWzpKYD0l99BwSfSjLHNKLtd4RN2BhrllWksJIQQ+6Mmmx5IFhkxNOJy05er1KsqO/g7+UYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uhanx+4S; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uhanx+4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782993481;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8xm+vDnzT7DuBwAtfuNAFkFCTgwEZyXMnG++VqJgtfM=;
	b=Uhanx+4SJi5CY746BqvU5pyhqtrmO6haMKFUPp1bpoxei/NCodLAcxaaJdfTXMuVjmdpuS
	O7jh/RScRrwZ/GaxrGiE4MLy6OIsB4lqiptLgHNMR1VLDNE0fwBm/VfpCe/A2B/RwLAZZC
	QUGW0xuhA9tBq8nmTxK3XEwKhIOnKsI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-4Ze0ABGpN0qJj3vSxX-E3g-1; Thu,
 02 Jul 2026 07:57:52 -0400
X-MC-Unique: 4Ze0ABGpN0qJj3vSxX-E3g-1
X-Mimecast-MFC-AGG-ID: 4Ze0ABGpN0qJj3vSxX-E3g_1782993470
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 23BD81944B00;
	Thu,  2 Jul 2026 11:57:50 +0000 (UTC)
Received: from bfoster (unknown [10.22.80.59])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 403991966663;
	Thu,  2 Jul 2026 11:57:47 +0000 (UTC)
Date: Thu, 2 Jul 2026 07:57:45 -0400
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
Message-ID: <akZSOa4awK5l9x_w@bfoster>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
 <akYx9blvVhIXB5A-@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akYx9blvVhIXB5A-@lucifer>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On Thu, Jul 02, 2026 at 10:44:09AM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 12:38:44PM +0300, Laurent Pinchart wrote:
> > On Thu, Jul 02, 2026 at 10:44:34AM +0200, Vlastimil Babka (SUSE) wrote:
> > > On 7/2/26 10:12, Jori Koolstra wrote:
> > > > Ah, I still reigniting this discussion again :)
> > > >
> > > > What about a combination of what David and Jeff say? The whole point
> > > > seems to me that the salient information is not that an LLM was used (or
> > > > are we going to tag Sashiko as well or any other LLM-based code review
> > > > tool?), but what is was used to do. This information may be relevant for
> > > > how the review is approached. The latter should perhaps only be in the
> > > > cover letter and then we can drop the assisted-by tags altogether.
> > > >
> > > > The question about enforcement remains.
> > >
> > > It's not possible to enforce it. People can deny it if the tag is missing
> > > and you confront them and even though the submission has many signs of being
> > > obviously LLM, there is no definite proof. We've seen (likely, as there's no
> > > proof!) that happen in mm.
> > >
> > > Such situation then penalizes those who disclose so obviously they won't.
> >
> > I think there's also a penality for those who don't disclose when
> > they're told they should: it will lower trust. Kernel development is
> > largely based on a trust model. If a contributor decides to adopt a
> > deceiptful behaviour, they can expect maintainers to raise the bar for
> > accepting patches, when not rejecting them outright.
> 
> Yes, I explicitly said this in response to somebody for whom there was
> overwhelming evidence they were submitting AI slop, and that they'd need to
> build it back up again.
> 
> It's precisely the issue as I see it.
> 
> But others within the community disagreed with me, so it turned into a very
> long and draining discussion that I don't particularly wish to repeat.
> 
> So we really need clarity on it being OK to do this (I remember saying this
> last year when I made an ultimately unsuccessful submission to the
> maintainer's summit about all this :)
> 
> What matters overall is being able to _quickly_ dismiss AI slop so that
> asymmetry between LLM generation + maintainer time isn't exploited.
> 
> And ultimately I think the trust model will end up being 'newcomes have 0,
> now build it up'.
> 
> Which sucks but this issue is simply existential for open source.
> 

Has anybody tried throwing any of the obvious LLM slop submissions we
have seen into one of these LLM detector things? To be clear, I've never
tried those so I'm certainly no authority on if they even work reliably,
but if so I wonder if something like that is a potential solution for
elminating the worst cases..

I.e., suppose we had some Sashiko type LLM/bot whose job was mainly to
detect purely LLM generated content based on some minimum level of
confidence and reply with a loud and clear message to the thread. Maybe
that would be a clear enough signal to maintainers and reviewers that
something is not worth prioritizing for review.. Maybe also some "slop
detected" feedback would help disincentivize flinging slop onto the
lists. At the very least that could be something that is more easily
configured/enabled per-subsystem without having to use per-subsystem
commit tags.

Brian

> >
> > I can't quantifying which of the penalities will be higher, but I hope
> > (call me naive if you wish) that the vast majority of contributurs who
> > *know* we require disclosure to abide by that rule, even if it incurs a
> > penalty. After all, proponents for LLM usage claim such performance
> > improvements that a small penalty during review can't be that bad, right
> > ? :-)
> >
> > > We
> > > should drop the tag and instead think how we can empower maintainers to be
> > > able to use their own judgment and deprioritize dealing with what they
> > > perceive as LLM slop, without fearing consequences of not being properly
> > > responsible etc, and not rely on any non-enforceable tags for that.
> >
> > --
> > Regards,
> >
> > Laurent Pinchart
> 
> Thanks, Lorenzo
> 

