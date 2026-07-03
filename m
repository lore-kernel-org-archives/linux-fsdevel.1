Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86E3CBE7E;
	Fri,  3 Jul 2026 11:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079632; cv=none; b=PujiqMCIXVFmGFQgZAMvywcGGblS75i++noGXZc+XIb+vf+2zXFT3v3pzT4UhPK1gEQ0OpotHSGgnR+JZKMsY7QFrI01mkcznadjophMerX53N9PzllQI3xrA4P9GAS6kLWWB+W3n2D9AONSeVWCl4Y5M1yT40YoR/ucmh+3J2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079632; c=relaxed/simple;
	bh=pf71b/AVgEKRQp/LCupa+IHFkhKe7lSe68g9vfscOwc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOCOgTyaH+Ai43L4HSxhij6EWNy2FnT6g3FUoWmHSuviBSvWFLWUBd7G4OTRg//Qup9uThZOOajgQp0gqVL3e1CP/qKMni7cGhOe5Lc7Qa9y4yNGt39XTvw17hWLAI0tjtRnE2exh3O9rt1g3vmfYRl++GCKK8UEraDPZkbN7eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Uge/SPsL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Uge/SPsL"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84C351121;
	Fri,  3 Jul 2026 13:53:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783079581;
	bh=pf71b/AVgEKRQp/LCupa+IHFkhKe7lSe68g9vfscOwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uge/SPsLAzlN0O/55kXzsg2q6gWLaJTsTKWUVZ25fOxY2SBFovxwM1bX0kzhhpsTt
	 S4W4+L3IrXlPAk01cvaiffK3XNrrKOygVH4JsQ77n4qroCM/VuFM4fgjngpU/6wFKS
	 T2Lkmf9zlegdElKxwWMAxw3We1RMTH/rFbrosD58=
Date: Fri, 3 Jul 2026 14:53:45 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Theodore Tso <tytso@mit.edu>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <20260703115345.GB3659451@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <20260702163215.GC3559965@killaraus.ideasonboard.com>
 <2026070350-drown-untreated-5835@gregkh>
 <a095d9b4-f774-47d9-affd-d519d8acfb34@kernel.org>
 <2026070343-copied-quarters-1e2a@gregkh>
 <akeaouJETPWpE838@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akeaouJETPWpE838@mit.edu>

On Fri, Jul 03, 2026 at 07:42:35AM -0400, Theodore Tso wrote:
> On Fri, Jul 03, 2026 at 09:30:28AM -0500, Greg KH wrote:
> > > So clarifying there that a "Assisted-by: LLM" is also good enough would make
> > > sense if we agree on that.
> > 
> > If we all agree on that, I'm saying that _I_ don't care, but others
> > might.
> 
> I agree that requiring the model name is not a good idea, because some
> developers might be using unreleased products where the name itself
> might not be public.  So allowing the version number of the LLM to be
> elided would be a good change.
> 
> I'll also note that it's starting to be the case where tool is
> actually quite relevant.  So it's not just about the LLM Model, but
> whether you're using Codex, Claude Code, OpenCode, or Shahiko.  You
> can use the tool or the harness with different models.
> 
> So whether the tag is:
> 
> Assisted-By: OpenCode:Gemini 3.5 Pro
> Assisted-By: Claude Code
> Assisted-By: LLM
> 
> I'd be fine with reviewing patches with any of the above.  However, to
> me that's actually not the most interesting part.  See below....
> 
> > For me, the info after "Assisted-by:" doesn't matter, it's the first
> > part.
> 
> For me, what I care most about is *how* the LLM was used.  For
> example, if someone just used the output of Sashiko to fix a problem
> in their commit, that's one kind of "Assisted-by".  If Sahsiko
> identifies a pre-existing bug, and the developer addes a patch to the
> patch series, or creates a new patch series, that's a different kind
> of "Assisted-by".  A third kind of "Assisted-by" might include asking
> the LLM to create a Coccinelle semantic patches (because I'm not smart
> enough to create semantic patches).
> 
> And of course, all of this is quite different from the stereotypical
> "vibe coding" where the LLM generates thousands of lines of code which
> the human doesn't understand before sending the pull request.  :-)
> 
> So for me, adding something after a #-sign comment explaning how the
> LLM was used would be very useful.
> 
> > > My kids should clean up their room; doesn't work.
> > 
> > But, if you notice that your kids didn't clean up their room, and you
> > had told them to, you can then talk to them about doing it properly
> > based on what they are supposed to be doing.
> 
> Another metaphor might be that people shouldn't try to evade paying
> their taxes; merely passing a law saying they have to file correct tax
> returns doesn't guarantee this.  But it was specifically the law
> against tax evasion is how US Law Enforcement arrested the Chicago mob
> boss Al Capone.
> 
> Just because some people might lie doesn't mean that we shouldn't
> bother to ask everyone to fill out tax returns.

I think we're digressing here. The original point, if I understood it
carefully, is that "must" would convey a requirement better than
"should", and I agree with that.

-- 
Regards,

Laurent Pinchart
