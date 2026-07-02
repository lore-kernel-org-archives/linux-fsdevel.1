Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4C83382DA;
	Thu,  2 Jul 2026 16:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009322; cv=none; b=MgezYMAxLDVsJ0aj5jkdM2Bn61qgHd2fdMutGZvG2t+AJE5KsNg+bnBigOWsg4x4J6IxyJmiT7LAdN3fDBX4p5pz1rXNEiQdCUUoPUQleBwIB3XQGLVOJHteVwtIAUMI44HwCI6sIwuUB44NHG0GOl5LHVPvJewdT/P0WYAjz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009322; c=relaxed/simple;
	bh=OsSDOQIrgtchdtrVgSK3nnizozNNXFaJwSyg5VreD7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XFc9K2BUtAhp/r1dSSwlXxJKdHX1HbOYEskJpdloX1GrKLZxamrleDpsZ6zANPdfIN/qkxcsSOCII1wGDt7oNfwVPFu6A0yfhG2iD5OetQrrmQtlE8saxv0VGpyiEnHrH6B9JvAxrU+7Y0auh6GBy8HX+5+t237SulYn61/jrIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zApc09pG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zApc09pG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3631F000E9;
	Thu,  2 Jul 2026 16:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783009321;
	bh=kK4vBztoIykW9+OGgKvTHApPTBMrfjJGiJlwKiL6kOg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zApc09pGa6ijstV9hQYvpSJDrSI7IbslYravwN/5RkJD9XwRhzlLk6ASUxpxWJiVk
	 LopIiO17izoTFkYfkjliqyajJ+myI0ZHqR+smtB9wWBXxKHw2x7gPN6wezCbqw71n6
	 Mzds3mfibgDnSK86ov2VKFNRcytYY4IKSAGtLJns=
Date: Thu, 2 Jul 2026 18:19:15 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Jeff Layton <jlayton@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Lorenzo Stoakes <ljs@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
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
Message-ID: <2026070227-payroll-eradicate-8f66@gregkh>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702161330.GH3534761@killaraus.ideasonboard.com>

On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > We've had this requirement in place in the Documentation for several
> > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > is quite low.
> > > > 
> > > > 1/ It's not universally followed. While many people do try to attribute
> > > > the LLMs in good faith, not everyone does for various reasons.
> > > 
> > > Then let's move to get people to follow it.
> > > 
> > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > 
> > > Who cares, make up a name, all I want is the "signal" that someone is
> > > using a LLM so that I can review it as-such.  And if I think someone is
> > > not reporting that, I can ask for them to properly attribute it and if
> > > they lie, well, that's on them.
> > > 
> > > > 3/ It's not clear why we want to collect this info in the first place.
> > > 
> > > We want to know if a LLM is being used.
> > 
> > But why? What do you intend to do with this information?
> > 
> > Do you mean to use it as an indicator that the patch should receive
> > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > it to generate some sort of statistics at a later time? 
> 
> I use the information to decide how to review the patch, and what level
> of priority to give it. For that usage I don't need a tag, but I need
> the information in some human-readable form at patch submission time.

Same here.  I don't care about stats, I care about "how do I review this
patch" and this gives me that signal that I need if faced with a
llm-helped patch.

So it needs to stay please.

thanks,

greg k-h
