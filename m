Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813BB37A826;
	Thu,  2 Jul 2026 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783007104; cv=none; b=JpNh4XEVTDEWv6aEp2ePzkCRrPEi3AlBpjoLLYtzw6wfHa3cFL4sVj4U1/HLsWzr5p+HFdPPWQiaC8WR3N3hhHRVLdD1uLBLdyhhn+v8jQpXpNuy/aDrCnD8LM/UZIREuP/MjG855KAf+UhQ+A50ZTxMta+1LrPhoEvq1YESWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783007104; c=relaxed/simple;
	bh=IokGtwCtzjPNBswq4KU+/wPFsryNzpr0U2HW4+iySCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDubGGDvzOYp5kglPUtGa+8EH1g8jOyA3M+xnr9x/SBFTP6VelWxJYnWLHQqiTAov3Uwg+Gk7+2L18kKubGtpiwEYKTKXohcSOd61yvISmCnbYrb3scasS7d+CA20OXaOueVc0Fvd3zPrUfzSy1AlP8Xgey9JxO6Zuqd2WUAMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=HupVj6ss; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="HupVj6ss"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 0B5EA3A2;
	Thu,  2 Jul 2026 17:44:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783007052;
	bh=IokGtwCtzjPNBswq4KU+/wPFsryNzpr0U2HW4+iySCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HupVj6ssi4sOXnC2WZhLPRG32Mp8ikN7gXJZJlsS4VHalbb7hYUcBGRGvurYe4+1m
	 kcg5kmzt94EHT7K0x5WnutXp0PNnHjFTodUz7oPjmmnkII8NHUkssLJ2CGndZl/q5R
	 KI82udqy/SG/LtEU6lyohQxwcsZ8kzTPF+FC59+c=
Date: Thu, 2 Jul 2026 18:44:56 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>,
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
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <20260702154456.GB3562985@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <akZ5_aiOuOpgLII1@lucifer>
 <20260702152815.GA3559965@killaraus.ideasonboard.com>
 <akaEcP2E7xYsIAqW@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akaEcP2E7xYsIAqW@lucifer>

On Thu, Jul 02, 2026 at 04:36:20PM +0100, Lorenzo Stoakes wrote:
> On Thu, Jul 02, 2026 at 06:28:15PM +0300, Laurent Pinchart wrote:
> > Hi Lorenzo,
> >
> > On Thu, Jul 02, 2026 at 03:57:11PM +0100, Lorenzo Stoakes wrote:
> > > I'm a little surprised I'm cc'd on this :) I'm not entirely sure if my pushing
> > > back on this is going to mean anything but I suppose here goes nothing.
> > >
> > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > We've had this requirement in place in the Documentation for several
> > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > is quite low.
> > > >
> > > > 1/ It's not universally followed. While many people do try to attribute
> > > > the LLMs in good faith, not everyone does for various reasons.
> > >
> > > Does something not being universally followed therefore make it worthless?
> > >
> > > You really have to explain that, because this is literally true of any rule
> > > whatsoever we might have in the kernel, should we drop all of them?
> > >
> > > I think you should replace this with a cogent argument such as that you feel it
> > > is not being used in the _majority_ of cases or is very rarely used, and that
> > > value is in your view not there.
> > >
> > > >
> > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > >
> > > I agree with this point, we should drop the model.
> > >
> > > > 3/ It's not clear why we want to collect this info in the first place.
> > >
> > > Well I made arguments on the other thread, but to repeat:
> > >
> > > - It makes it easier to engage with people when they do ack it.
> > >
> > > - It makes it far quicker to be able to do so.
> > >
> > > - There's a barrier to mentioning an LLM if it's not provided - people can get
> > >   upset, or it can cause issues to raise it as a concern.
> > >
> > > - Even if it's only there in _some_ cases, it makes _those_ cases easier to deal
> > >   with.
> >
> > As far as I understand, all the above arguments would also be addressed
> > with either a free-formed mention of LLM usage, or a formal
> > "non-advertising" tag that is not merged in the kernel history, right ?
> 
> Well I prefer a tag for reasons below. I'm fine with non-advertising yeah.
> 
> > > - It provides some (incomplete) data that might make it easier to deal with
> > >   bug-causing patches.
> > >
> > > - It provides some (incomplete) data on bug rates with/without LLMs.
> >
> > For those two I suppose a machine-parseable tag in the git history could
> > improve things slightly compared to information provided in the patch
> > submission that would not get recorded in the history.
> 
> Yeah, again I could live without it being in the tree. I think there's some
> advantages though.
> 
> See below for tag argument.
> 
> > Is this why you have a preference for a formal tag compared to a
> > free-formed mention ?
> >
> > > I do agree they're far far less useful when there's not some indication of how
> > > much of the patch was LLM-generated.
> > >
> > > Their usefulness is obviously deeply far from perfect, but not zero.
> > >
> > > > Given that the data this provides is flawed at best and is being
> > > > collected for a purpose that isn't clear, let's just kill the
> > > > requirement for these tags from the kernel at large.
> > >
> > > I feel there are purposes. Perhaps the argument is stronger for having the tags
> > > on submissions rather than actually in-tree, however.
> >
> > I really think we need to have the information at submission. I think I
> > have a slight preference for not recording it in the kernel tree, but
> > only slight.
> 
> It seems we are more in agreement than it seems :)

I knew we were :-)

> I prefer a tag as it's clear cut and easily greppable and easily noticeable.
> 
> If it's words it can be vague or be unclear or inconsistent and you might miss
> etc.
> 
> So I have a strong preference for a tag, would love to add details about how
> much LLM done (that'll be vague obviously + have grey lines).

I have a slight preference for not recording that in the git history,
but I can live with either.

> I agree gettig rid of model is worthwhile but I'm not bothered if we don't do
> that.

There I have a very strong preference for stopping free advertising.

-- 
Regards,

Laurent Pinchart
