Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4333AD8B;
	Thu,  2 Jul 2026 15:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783006612; cv=none; b=LKA4nP86ajsUyxvzzbM6uBb4oIBLbcCfoW10RAVPQklhkjHodBH0EWGFzYME8F9QXX0Mfm2J8O3juVbo4zh64pEVCIXONmwdNg/WdHJDSYprL2TaiYzqGnFECx+7rGGQrtPteaJIK8OWHi9TLqgE/DefYN0wbcffwalDpWRbJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783006612; c=relaxed/simple;
	bh=3ZoGGrtDHrhFGSRS92ZY56Lbany7RokCQLjnUpbGhrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JulArMRZ8nQMAmWPmsiysO+jjqyDM3tE2lFyvtrfoSYPO5F1ZnBZF5pUfWZ7/bJPH3ZTHcz0m4rsQncrPiFd6gQu5ccq0jmHh8gDdZMmMvl5CdoIfoy6t8LuQLSLiB+LfreKVooICK5vH0cxzw5+76KUlskNXVGwtcsue5Q/1U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Z6vHtArs; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z6vHtArs"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CECC78FA;
	Thu,  2 Jul 2026 17:36:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783006563;
	bh=3ZoGGrtDHrhFGSRS92ZY56Lbany7RokCQLjnUpbGhrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z6vHtArsZPJSZCWm340TpdxWGzqRuf+jWbbpEjnSZXpy7inaJmDPvhhmsGqRjLBs1
	 N3H4T8PV3L6/c6+JclEZZmzr3vlOrGsw6UHXK8nJLpsL0tVZkVRbmOa+ijlia9Ga8s
	 JclEGZ9AH7z54OphEaTJs0PgRgZLvkTSjaMYSG9Y=
Date: Thu, 2 Jul 2026 18:36:47 +0300
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
Message-ID: <20260702153647.GB3559965@killaraus.ideasonboard.com>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026070224-unholy-commode-cf45@gregkh>

On Thu, Jul 02, 2026 at 05:07:03PM +0200, Greg KH wrote:
> On Thu, Jul 02, 2026 at 10:32:48AM -0400, Jeff Layton wrote:
> > We've had this requirement in place in the Documentation for several
> > months, but it's becoming clear that the signal to noise ratio from this
> > is quite low.
> > 
> > 1/ It's not universally followed. While many people do try to attribute
> > the LLMs in good faith, not everyone does for various reasons.
> 
> Then let's move to get people to follow it.

Has there been any discussion regarding *how* to do so ? Jon mentioned
that in many cases the failure to disclose is simply due to ignorance.
That could be addressed by more advertising (not entirely sure where
though, documentation isn't always read), or restructuring of
coding-assistants.rst (as far as I understand, the file is supposed to
be consumed by agents, so it should be reasonable to expect the LLM
output to contain a tag).

There are also cases where submitters refuse to comply with the rules
(as in [1] apparently). For those cases, a clear message that
maintainers will be fully supported by the community when they push back
could help.

[1] https://lore.kernel.org/linux-mm/20260527110147.17815-1-tao.wangtao@honor.com/

> > 2/ It basically serves as free advertising for proprietary LLM companies.
> 
> Who cares, make up a name, all I want is the "signal" that someone is
> using a LLM so that I can review it as-such.  And if I think someone is
> not reporting that, I can ask for them to properly attribute it and if
> they lie, well, that's on them.
> 
> > 3/ It's not clear why we want to collect this info in the first place.
> 
> We want to know if a LLM is being used.
> 
> > Given that the data this provides is flawed at best and is being
> > collected for a purpose that isn't clear, let's just kill the
> > requirement for these tags from the kernel at large.
> 
> No, please do not do this.  It's useful already for many patches in my
> subsystems, and is only going to be used more in the future.
> 
> thanks,
> 
> greg k-h
> 

-- 
Regards,

Laurent Pinchart
