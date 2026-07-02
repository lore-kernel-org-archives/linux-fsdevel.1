Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF912580F2;
	Thu,  2 Jul 2026 15:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783005331; cv=none; b=tPiyL1s3kfs7C7TxFOynHi7SfC8UzpBlCRBJG9M31Dz2pVGqNpha2G4OaWYrtqYBn+yfp38AKbgv1e3XJxUdwNSV8dZ2A7lI9LaGUmx6Jt4B/1504h9LLSrEQ4edCpFpKZwPIFX4UGd5n40bswDRQBR1gFiqswLNYgNiSbTVbZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783005331; c=relaxed/simple;
	bh=ILdIatvfROrbmleQt3e624R/tZsjOyvps3DferKuSX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNSi7eC6r/OwIwZd5JPBf7tmqCpdvenEvIqO+vno6hnqIZ2ZNMZGUHeh1fGtNYtftZ/A8mXuRcNgbiuXObBQI5gW16wRcG7mXZBxhGFK2YQBxAKwORVeZrC9nlqTMA7NaRRS9s4afEnSkpUxsWJM8AT6GkzsZ8E77I+JhIL9J7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=msvV77h1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="msvV77h1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6778B1F000E9;
	Thu,  2 Jul 2026 15:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783005330;
	bh=er3qb3iuTtb5rJPIxVuH9vOh6hBTypWdJKU0a3YM7qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=msvV77h14T6pSSejLs1EuwDuy8Q213IBH16tJRLNTQKCGSREfejts2Celor1owqI/
	 JsYxggWaE0mZoF0beZJfnW3s7YK7JR0kxDSkYNIQMpHf1XbQY2EQLLoEQvuzkHh+nD
	 WgILbhK1xlrncTngc1RTVCkw6vDeb7Cjd1pkA0CDvklh5KufAYk+eFqYVVuqbB6i81
	 miOqOWnVRVd3lMVKMB7Ge+7pfgDCPbD/gL3WURwDTZ18T1P2Wk54nKi1tmEGJUS5Nw
	 I6BfF7m8JcQhkVkHdnV5Zw6gy9EOoffapPha8o53gIrlIPtUfKko7mstBK0NJI84qn
	 5KcWJvdYhRCfg==
Date: Thu, 2 Jul 2026 16:15:18 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Jeff Layton <jlayton@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Justin Stitt <justinstitt@google.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Jori Koolstra <jkoolstra@xs4all.nl>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>, 
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Christian Brauner (Amutable)" <brauner@kernel.org>, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <akaAL7XWIvbumwpj@lucifer>
References: <20260702-aidoc-v1-1-735572dfb995@kernel.org>
 <2026070224-unholy-commode-cf45@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
>
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

Entirely my view and experience. The tags are proactively useful, even if flawed
and (possibly very) incomplete.

I am totally fine with getting rid of the model however, and I do think it'd be
useful to add a small paragraph suggesting that people add a comment indicating
_how much_ of the patch was LLM-generated, even if it's vague and fuzzy.

Some information > no information.

Thanks, Lorenzo
