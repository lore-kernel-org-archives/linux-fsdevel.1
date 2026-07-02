Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C32337A853;
	Thu,  2 Jul 2026 15:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006593; cv=none; b=iZD4fOpLa5lZg1bxBaY/jRXn/RPDTE+ZumJRkA4C1HbQoIxH880o9xUlAg0DlxQXpoVONtHFfR0A/t3MX6Ujjl3gSNCyMI0LNcXkNPgob/K5y0VHOHkvd3V6oNFOR1Gj05S9tfVPxkMXLRB17f4NooY6JfOc4VWEOJpUknFQFdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006593; c=relaxed/simple;
	bh=bknj0A0ga6wvQQcEPEtWMzUPmI1nq9bEtzU0zJoAJbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZyDaY/W29KKqD2ox6z9YRvEspULLIpg4MePFS54Dlw5IzdrjPol0YRFKGNDYxyyu5DesnfayVlplhkcXHLBAB0Xg4lWGc658N/eDHb1sC1eEZhcg1dvq0+/VIg0p+HTIRlhEylAe/NtSxhK/32hlxdH9DNxJYdXuBi9DTvsxM6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K4IMr2Va; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K4IMr2Va"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC8A1F000E9;
	Thu,  2 Jul 2026 15:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783006591;
	bh=HyF0vJ0X6U4d51644ogYH3jz+4yi7mbiJH95pEBmC7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K4IMr2Va6KrpxsRiNfGQJ4AzTgueEVoxNc0nAcncFDZrfmYJ9QDkCfeQv/2bDiovK
	 x9e3AoWBX8F2F9OgGekGaqdwmqtwJnMCJsMYWqQPbeEuMCjwnXBuepxsnBZLzXXpj4
	 SDuzHDqp7LPzYQYjSLsarx0Gac2D5IMLkA/FCRHiE1XTYPYwYwX0lSds+P69rSwWTm
	 WHHpmSp0ua58/gpFQvvs6OKCG9D1DyrYZ32AnXn21C0KcX02vgq/UQ6PhTa29HZK4J
	 v7+jgv1+SDHHwi66q1hnC4Nb1xbBqMpwumxtY3mUBlkKeNceeK7ujzlIdVTe48FDX7
	 vNiBF5jy8ROfA==
Date: Thu, 2 Jul 2026 16:36:20 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Carlos Maiolino <cem@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Christian Brauner (Amutable)" <brauner@kernel.org>, 
	workflows@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akaEcP2E7xYsIAqW@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <akZ5_aiOuOpgLII1@lucifer>
 <20260702152815.GA3559965@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702152815.GA3559965@killaraus.ideasonboard.com>

On Thu, Jul 02, 2026 at 06:28:15PM +0300, Laurent Pinchart wrote:
> Hi Lorenzo,
>
> On Thu, Jul 02, 2026 at 03:57:11PM +0100, Lorenzo Stoakes wrote:
> > I'm a little surprised I'm cc'd on this :) I'm not entirely sure if my pushing
> > back on this is going to mean anything but I suppose here goes nothing.
> >
> > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > We've had this requirement in place in the Documentation for several
> > > months, but it's becoming clear that the signal to noise ratio from this
> > > is quite low.
> > >
> > > 1/ It's not universally followed. While many people do try to attribute
> > > the LLMs in good faith, not everyone does for various reasons.
> >
> > Does something not being universally followed therefore make it worthless?
> >
> > You really have to explain that, because this is literally true of any rule
> > whatsoever we might have in the kernel, should we drop all of them?
> >
> > I think you should replace this with a cogent argument such as that you feel it
> > is not being used in the _majority_ of cases or is very rarely used, and that
> > value is in your view not there.
> >
> > >
> > > 2/ It basically serves as free advertising for proprietary LLM companies.
> >
> > I agree with this point, we should drop the model.
> >
> > > 3/ It's not clear why we want to collect this info in the first place.
> >
> > Well I made arguments on the other thread, but to repeat:
> >
> > - It makes it easier to engage with people when they do ack it.
> >
> > - It makes it far quicker to be able to do so.
> >
> > - There's a barrier to mentioning an LLM if it's not provided - people can get
> >   upset, or it can cause issues to raise it as a concern.
> >
> > - Even if it's only there in _some_ cases, it makes _those_ cases easier to deal
> >   with.
>
> As far as I understand, all the above arguments would also be addressed
> with either a free-formed mention of LLM usage, or a formal
> "non-advertising" tag that is not merged in the kernel history, right ?

Well I prefer a tag for reasons below. I'm fine with non-advertising yeah.

>
> > - It provides some (incomplete) data that might make it easier to deal with
> >   bug-causing patches.
> >
> > - It provides some (incomplete) data on bug rates with/without LLMs.
>
> For those two I suppose a machine-parseable tag in the git history could
> improve things slightly compared to information provided in the patch
> submission that would not get recorded in the history.

Yeah, again I could live without it being in the tree. I think there's some
advantages though.

See below for tag argument.

>
> Is this why you have a preference for a formal tag compared to a
> free-formed mention ?
>
> > I do agree they're far far less useful when there's not some indication of how
> > much of the patch was LLM-generated.
> >
> > Their usefulness is obviously deeply far from perfect, but not zero.
> >
> > > Given that the data this provides is flawed at best and is being
> > > collected for a purpose that isn't clear, let's just kill the
> > > requirement for these tags from the kernel at large.
> >
> > I feel there are purposes. Perhaps the argument is stronger for having the tags
> > on submissions rather than actually in-tree, however.
>
> I really think we need to have the information at submission. I think I
> have a slight preference for not recording it in the kernel tree, but
> only slight.

It seems we are more in agreement than it seems :)

I prefer a tag as it's clear cut and easily greppable and easily noticeable.

If it's words it can be vague or be unclear or inconsistent and you might miss
etc.

So I have a strong preference for a tag, would love to add details about how
much LLM done (that'll be vague obviously + have grey lines).

I agree gettig rid of model is worthwhile but I'm not bothered if we don't do
that.

Thanks, Lorenzo
