Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0F27081A;
	Thu,  2 Jul 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783033552; cv=none; b=qnEW+SgiXev40v349ndfjWFDkZDr+E1nh7bmGxUXzlUT+uCa+kUauWIw/ZsABK6kITnCD9RHbVvy1YZkP8JzlZidoycv3YcsZHe85bfEBwZIyVrt6JO+fClqUFH5sC3xsMcSmzCTLWo3N2HAaXBfFCifr3V4Y2iYwhYt5wWK+Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783033552; c=relaxed/simple;
	bh=z/PL7fFq4kLVO+b7hoZGEv+ChBPGUpOeKsZUiEv2w5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=myvig1BV6PV9IGxMfKv2D151KMgIH0G9wHYt/ux09+ffSf8HLfcspjZKBzJhMLBIy3Ss+ybcp9ff7JSsyIxksnTRlBBGwauqHfmFFtkDftSiGDq8d+CxV5/kfxC8tokft9Hj5K6hTXFbSTRU4sHvTctx2EUjFd8BEDUEVX4DTKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+ROQ5ff; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+ROQ5ff"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6A91F000E9;
	Thu,  2 Jul 2026 23:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783033550;
	bh=ZBRHqb1NDOH8oHItOd3hyQ5MfmYi1tcrPJ9XDGwB6DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+ROQ5ff0I1CMQF7LqfbXbxZbxZo7E3AaR26HxXLZxvJwnTQUS4mcYloqdo9gf3sC
	 FzBL8mumI4haKcU7WfATnu/h17N8Xcn9XWtDAz0H9wJ6b34MTuwzqBljPVC1HcPoJC
	 EHWydJmluYpOk/atLpq6k8BaG1Vwujf3WfwFsEAKmxa1W0mqbbAI2P8cojJOQy1H0Z
	 Vs1O0SSgO4Nuf2eCzQ3FanFuq8wEaZd4nNsFnuSlwJiyyfRHVNfTh+mCmAhpr5yJG1
	 QpxoanZjLuyGPrQYM8f2j7pcnNlLXeaOO3rY40QoGBhUAESLyIi/P3IdVWlW7EuOQP
	 thIAHCykiQEnQ==
From: SJ Park <sj@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>,
	Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Date: Thu,  2 Jul 2026 16:05:40 -0700
Message-ID: <20260702230540.98160-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <akaWnQ5Pkg_676B-@lucifer>
References: 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 2 Jul 2026 17:50:15 +0100 Lorenzo Stoakes <ljs@kernel.org> wrote:

> On Thu, Jul 02, 2026 at 12:48:22PM -0400, Jeff Layton wrote:
> > On Thu, 2026-07-02 at 18:19 +0200, Greg KH wrote:
> > > On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > > > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > > > We've had this requirement in place in the Documentation for several
> > > > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > > > is quite low.
> > > > > > >
> > > > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > > >
> > > > > > Then let's move to get people to follow it.
> > > > > >
> > > > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > > >
> > > > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > > > not reporting that, I can ask for them to properly attribute it and if
> > > > > > they lie, well, that's on them.
> > > > > >
> > > > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > > >
> > > > > > We want to know if a LLM is being used.
> > > > >
> > > > > But why? What do you intend to do with this information?
> > > > >
> > > > > Do you mean to use it as an indicator that the patch should receive
> > > > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > > > it to generate some sort of statistics at a later time?
> > > >
> > > > I use the information to decide how to review the patch, and what level
> > > > of priority to give it. For that usage I don't need a tag, but I need
> > > > the information in some human-readable form at patch submission time.
> > >
> > > Same here.  I don't care about stats, I care about "how do I review this
> > > patch" and this gives me that signal that I need if faced with a
> > > llm-helped patch.
> > >
> > >
> >
> > Do we need a tag for this though?
> >
> > This seems like the kind of information that we would always require in
> > the cover letter of a series (or the little place in an individual
> > patch for comments that don't get merged). That would also allow you to
> > convey a lot more nuance about how it was used.
> >
> > ISTM asking people to disclose LLM usage in a cover letter would give
> > everyone what they want: Information about whether and possibly how an
> > LLM was used, and it also wouldn't clutter up the changelogs with these
> > tags.

I understand the concern is having the information in the git log.  I agree in
a level.  I wish cloning linux takes not too long time and huge traffic.  I
wish each commit message be lengthy only as much as needed.

> 
> It's much much clearer and easier to just have a standardised tag for that.
> 
> You can see that (and grep for that) immediately, vague paragraphs not so much.

I also agree having a formal tag can be convenient.  LWN's Assisted-by: tag
statistic was interesting enough to make me supporting this idea.

What about keep requesting this formal signature to the submitters, but also
formally allow (or, encourage) subsystem maintainers to remove the tags when
pull-request?  That's already allowed, to my understanding and some maintainers
are doing [1] today.   That can help preventing the git history of a subsystem
bloating or advertising priorietary companies, as much as the maintainer care.
Meanwhile, we can still get the information at review time, and also after
review from the mail archives.  It will still be handy as long as we use tools
like 'lei'.  As some maintainers are already removing the tags from the git
log, this may be anyway a better way.  Someone may interested in only their
subsystem history, but I find LLM users tend to contribute to multiple
subsystems, so this might actually matters.

It might be too clear to formally document this, though.

[1] https://lore.kernel.org/20260701115302.29c66401@kernel.org


Thanks,
SJ

[...]
