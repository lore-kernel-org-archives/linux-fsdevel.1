Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B47318EDC;
	Thu,  2 Jul 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009941; cv=none; b=po+wqU0Xlwn49kWxDzWpumjOvO78/oR69oOOQzci5KhWlWrAX2YEzmms3eEfs4bu+vnOLyZqpXmxRXeFICtuOQ4nzjdQw+KqxtM/DPQwFJjTzPx16Oap0w0TCDQSWIaVfLIrJhZfLfwvxthmpGuTHz3Hv/7HHFVMb/RGhj0wAmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009941; c=relaxed/simple;
	bh=fjj4Z6jD6dncrwYufqoyz44rJobrhzKlnGSRWYgfv2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T1r6Wc3YTHB2DnDaulVm2qxvEBQrKJi7CB5ix8iRFc8fF7AgA9vs3sSAkZp7Xj2VqrBoo3AqBJHrJLufjVI1RDnlorbB+fajrqRDoZp7hYupJib53Yei4XjP8aiQ6j+dYphmr1FsBMPPWo7ln95oacPmi/9C9ywzgZBmVCjDbLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=KAw1N2so; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="KAw1N2so"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9F4088CB;
	Thu,  2 Jul 2026 18:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783009891;
	bh=fjj4Z6jD6dncrwYufqoyz44rJobrhzKlnGSRWYgfv2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KAw1N2solbSlbRkyLcQrDS1HRgG6hrSmt5mynYc3hVv/+vaet+lxx9tW882OjFAxW
	 zqjKxfdIXc+a5dkSejBMPL/M8uwAjNWVQgJsEIw3iPiJlRpe/x1cnEyelWW4/CQfcI
	 AmCH5HOu0SvyzDrunMYwe48PazY+KBNuefv8sSvc=
Date: Thu, 2 Jul 2026 19:32:15 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Greg KH <gregkh@linuxfoundation.org>
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
Message-ID: <20260702163215.GC3559965@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026070227-payroll-eradicate-8f66@gregkh>

On Thu, Jul 02, 2026 at 06:19:15PM +0200, Greg KH wrote:
> On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > We've had this requirement in place in the Documentation for several
> > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > is quite low.
> > > > > 
> > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > 
> > > > Then let's move to get people to follow it.
> > > > 
> > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > 
> > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > not reporting that, I can ask for them to properly attribute it and if
> > > > they lie, well, that's on them.
> > > > 
> > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > 
> > > > We want to know if a LLM is being used.
> > > 
> > > But why? What do you intend to do with this information?
> > > 
> > > Do you mean to use it as an indicator that the patch should receive
> > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > it to generate some sort of statistics at a later time? 
> > 
> > I use the information to decide how to review the patch, and what level
> > of priority to give it. For that usage I don't need a tag, but I need
> > the information in some human-readable form at patch submission time.
> 
> Same here.  I don't care about stats, I care about "how do I review this
> patch" and this gives me that signal that I need if faced with a
> llm-helped patch.
> 
> So it needs to stay please.

There's the free advertising issue we still need to address. Would the
proposed "Assisted-by: LLM" tag to replace product names be an
acceptable option for you ?

-- 
Regards,

Laurent Pinchart
