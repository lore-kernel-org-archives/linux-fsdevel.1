Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF094A33F4;
	Thu,  2 Jul 2026 13:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782999469; cv=none; b=Fnhqtvc3XfDnjxVWG6ZN7ogOoIBgB0SHLUBlnMG5anqs3BWeJHjelF2sFA/5KvO//ksfBHv3UmVpiurDc/j+UKQjrZKLY3Pmeg/bAEp8nrDW5+TjskFQwqzPoB5VCBHD5FyW5d6xw23476IecHEERZHkXwP2H9x+zH/vpnr44dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782999469; c=relaxed/simple;
	bh=JNZnExOtB82Fi26v5BmqQOoWHVWJGKE5Ti6BYAj4DXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0YTmxjJbCdnO9VH45G1PUwW/LEYP9elwkgflmqMqUvUsVSK46QHZHv5pWzHxPWQJdBOFmyr0d65TvApWmS7c+HppuZrjotAGbB7drSy5CZYY7YiKEbgohmc44wpcEZYIdqYWk16vNqI2YXTKK7ReAz1GPIL1tcjOggWJW9D/Vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wt1UCLzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wt1UCLzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326361F00A3E;
	Thu,  2 Jul 2026 13:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782999468;
	bh=JNZnExOtB82Fi26v5BmqQOoWHVWJGKE5Ti6BYAj4DXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Wt1UCLzgyDhu2/N/K9SmjKXYvdFyyMDfJj7QGXQRFspl2qGmJROWaavSnL6bxCBSd
	 iKcBIRpCRhFN0Yr27WavUAXJSd4ljplG6d13Vv7Cu3nQa2yR0b0oQ7Yo9E9BKVjqWy
	 uW5gUJn1Pv4ErC0eoQhxdmw3YqwCBxwoi3i2WEuuyL9UHY46IB+dBrEDWlGuwxNRgu
	 sjFKWuORVqWiyb+bCvde33AoOEZrJ7dpXwQ3v5l6wQs0/wq/SeHD9/0mqez/AQNGmo
	 HFfRh3gTgXt0FaDY5vMGgQrjmoOG18mg5bt5cNLQmWqWCBKzRS5R8ieyTI2tZE852S
	 nkVkqmS60gPRw==
Date: Thu, 2 Jul 2026 14:37:38 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Brian Foster <bfoster@redhat.com>, 
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akZm3abpMGPe-s20@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
 <20260702093844.GA3491311@killaraus.ideasonboard.com>
 <akYx9blvVhIXB5A-@lucifer>
 <akZSOa4awK5l9x_w@bfoster>
 <akZW1RPqTc-4_7jW@lucifer>
 <20260702130740.GB3534761@killaraus.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702130740.GB3534761@killaraus.ideasonboard.com>

On Thu, Jul 02, 2026 at 04:07:40PM +0300, Laurent Pinchart wrote:
> On Thu, Jul 02, 2026 at 01:18:06PM +0100, Lorenzo Stoakes wrote:
> > But then it becomes an arms race. People will get AI to try to defeat AI
> > detection. So I'm not sure it's a safe road to go down.
>
> That would be my concern too.
>
> At this stage, I think it's better to make sure people know our
> expectations, and expect that the vast majority will understand it's a
> trust-based system where being caught willingly breaching trust will
> have a very high cost. Or have we reached a point where that doesn't
> work any more ?

Unfortunately there's a lot of people who have bad motives or feel there's
prestige in kernel commits and are willing to cheat their way to it, or are
pressured by their workplace, or etc. etc.

So I think this is far too idealistic. I've seen too much undisclosed AI being
submitted and those people stridently denying they used it when it's brought up.

So I think tags are really useful to push back against those who are in good
faith.

And for those who submit it dishonestly, I personally believe _reasonable_ and
_strong_ evidence to believe it's generated should be enough to reject.

But there's not universal agreement on that, unfortunately, which makes it
politically difficult.

I think honestly the only solution long-term will not even be to reject like
this but rather we'll have to basically restrict newcomers to a very narrow band
of submissions and have them build trust before they can send more.

Which really, really sucks but I don't see how we can keep the kernel alive any
other way when the slop really ramps up.

>
> --
> Regards,
>
> Laurent Pinchart

Thanks, Lorenzo
