Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F2359A70;
	Fri,  3 Jul 2026 06:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783060655; cv=none; b=USuI6YOMopPanWjNe/yO/dWF39jLDEUncgoo66c/gS9hMeonvrOi+xsLfzTFFFXDRWIwLSCnB1kYFC2W8mnkDMFe1X41tpaaduAe/tB6seLFJt7q1zcXhUhBL8ATaexhBqM1sTBHGN8FcsdmcKbKrpbsfve5XcI7Ww8Erbupzqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783060655; c=relaxed/simple;
	bh=iA6L52VbbjBG33f9eKOlSm6Ww8Rc80ymjU+xI4qtosg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VxuM5dLmPf3ARh20zIK5/x2+42xwXxFZTUbOvyge6YSMyNop0y8vvXX7e+/j/9JmkTMAI+3bZs3+FYp6DworUEEsS9hyXNvH5Ek8urZtBtJPuH8ghENr+Lke62ApFdzqwFfefSnHrAyRQ7KGvbiSuJPwRPV09mzWxKdyXRUhXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oz8aasAS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oz8aasAS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B53A61F000E9;
	Fri,  3 Jul 2026 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783060653;
	bh=fdvRp4OPiKBvW6+WQNY+4BA/EGWBgSJfC3lb1v8xwDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oz8aasASXZglwpAFn2Zkd3t6Uje5bQogtua7K3bjZ7OSTmFGiGhgfMsFZyVqEQJ0X
	 bptb/4CgXdHGaeFT+yzxQ1LvYDvBOBZszCAQW5802EjQUD8nAHO0XvyHklvObH+yIy
	 et1Vpp2Qsrv/FhWKg+MUFMlpFPfA4NJobdqU1fMc=
Date: Fri, 3 Jul 2026 08:37:43 +0200
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
Message-ID: <2026070350-drown-untreated-5835@gregkh>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
 <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <20260702163215.GC3559965@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702163215.GC3559965@killaraus.ideasonboard.com>

On Thu, Jul 02, 2026 at 07:32:15PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 06:19:15PM +0200, Greg KH wrote:
> > On Thu, Jul 02, 2026 at 07:13:30PM +0300, Laurent Pinchart wrote:
> > > On Thu, Jul 02, 2026 at 11:57:46AM -0400, Jeff Layton wrote:
> > > > On Thu, 2026-07-02 at 17:07 +0200, Greg KH wrote:
> > > > > On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > > > > > We've had this requirement in place in the Documentation for several
> > > > > > months, but it's becoming clear that the signal to noise ratio from this
> > > > > > is quite low.
> > > > > > 
> > > > > > 1/ It's not universally followed. While many people do try to attribute
> > > > > > the LLMs in good faith, not everyone does for various reasons.
> > > > > 
> > > > > Then let's move to get people to follow it.
> > > > > 
> > > > > > 2/ It basically serves as free advertising for proprietary LLM companies.
> > > > > 
> > > > > Who cares, make up a name, all I want is the "signal" that someone is
> > > > > using a LLM so that I can review it as-such.  And if I think someone is
> > > > > not reporting that, I can ask for them to properly attribute it and if
> > > > > they lie, well, that's on them.
> > > > > 
> > > > > > 3/ It's not clear why we want to collect this info in the first place.
> > > > > 
> > > > > We want to know if a LLM is being used.
> > > > 
> > > > But why? What do you intend to do with this information?
> > > > 
> > > > Do you mean to use it as an indicator that the patch should receive
> > > > "extra" review (or maybe that it should be ignored)? Do you mean to use
> > > > it to generate some sort of statistics at a later time? 
> > > 
> > > I use the information to decide how to review the patch, and what level
> > > of priority to give it. For that usage I don't need a tag, but I need
> > > the information in some human-readable form at patch submission time.
> > 
> > Same here.  I don't care about stats, I care about "how do I review this
> > patch" and this gives me that signal that I need if faced with a
> > llm-helped patch.
> > 
> > So it needs to stay please.
> 
> There's the free advertising issue we still need to address. Would the
> proposed "Assisted-by: LLM" tag to replace product names be an
> acceptable option for you ?

I really don't care what the tag says, I just want to see the tag stay
to show that this needs to be evaluated differently than if it was made
only by a person.  Some people might want to "show off" their model
names, while other companies I know refuse to allow the name to be
shown, so it really doesn't hurt anyone to keep it as-is.

thanks,

greg k-h
