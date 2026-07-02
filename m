Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA03E51DE;
	Thu,  2 Jul 2026 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979734; cv=none; b=kSAdxFwFlOgaNykP8HMzOd94H1DeBSyIKH3ey/YSSgVkub3r966rokrgMQmdghmE9sP3RIRv4d+w9E0FZff4ulBULDy/fHCoBTCwz6kP7u/xulFAeOzMXkzFFSQWWbFOY72SyZS7ReWhR/yw2d0O0X5mul4Uu17s6/rhoj2D4m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979734; c=relaxed/simple;
	bh=c1k3M6iHOUB3h5EFXN8LOj/croNgm92w04O8kuYt4eM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBHC2bXuKQeqbSHmCoCk1MHcO0SYiipCm94zvqKqB5EUP4xCdLEZbKwvwRprqRDyYqb+IOZ6hsDlpBPQhAnhdvFo6OCLPOOVYZ2/4FPrR94zyud2Us1QD7+vDREC4D8X1RnROOoW6ktTJ2akXnKx9rGiPo7wlRQUSsqs4/UyVP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=aM2chEHQ; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="aM2chEHQ"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 931093A2;
	Thu,  2 Jul 2026 10:07:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782979676;
	bh=c1k3M6iHOUB3h5EFXN8LOj/croNgm92w04O8kuYt4eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aM2chEHQPj3sxLc7yKrtsij9xTeRKVrwOTkVrNYRFMCV2A9xqAWiJVR2hMaFqWOPu
	 XraaabnHAfupKQpYE33k3gbLAuVlmKDP7e54GGYv6HhJW4VTqy5uxvSpmx3UZwBaBZ
	 SJAfkRODEMA1202tW4CaD8p7Ch8AAgy9UPCQLaUk=
Date: Thu, 2 Jul 2026 11:08:40 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Christian Brauner <brauner@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702080840.GG3433808@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>

On Thu, Jul 02, 2026 at 09:27:37AM +0200, Christian Brauner wrote:
> > What would be much more relevant to know is to which degree LLMs were used.
> > 
> > Assisted-by: LLM # translate commit message
> > Assisted-by: LLM # generate some test cases
> > Assisted-by: LLM # cleanup logic
> > Assisted-by: LLM # everything and I have no clue what any in here does
> 
> I think we should just drop any attribution as a general kernel-wide
> rule and let subsystems require them as needed. Then you can have all
> the complexity in mm for this that you think is needed for your
> workflow to function. This is precisely what the subsystem profiles are
> for. So maybe just add:
> 
> Documentation/process/maintainer-mm.rst
> 
> alongside
> 
> Documentation/process/maintainer-{tip,netdev,x86}.rst
> 
> and lay down the rules that you require for LLM based submissions in
> whatever detail you need.
> 
> I don't see how this additional commentary you want would ever be
> enforced consistently across the kernel or who would even enforce it. I
> don't need more beaurocracy to chase after people in my subsystems tbh.
> 
> The other thing is that I think this Assisted-by annotation is just
> noise in the changelog. If you want to know in detail what an LLM was
> used for when generating the patch it's mostly a signal for how
> "intense" of a review this will get afaict (already questionable imho
> but sure that's just something to disagree on).
> 
> If the information is mostly useful during review then I still would
> question why it has to end up in our git logs. It's completely
> irrelevant information imho.

Food for thought, the Kubernetes project has published a disclosure
policy ([1], reported by LWN.net at [2], with a blog post explaininig it
at [3]). Quoting LWN.net,

"Of note, the project requires disclosure when AI tools have been used
to assist in the creation of a contribution but forbids the use of
listing AI as a co-author or including "assisted-by" or "co-developed"
trailers to attribute work to an LLM tool."

I personally don't see a lot of value in the Assisted-by trailer, but I
would like the submitter to include the information in a place that
doesn't end up in the git commit history (cover letter or below the ---
line).

[1] https://www.kubernetes.dev/docs/guide/pull-requests/#ai-guidance
[2] https://lwn.net/Articles/1080144/
[3] https://kubernetes.io/blog/2026/06/26/open-source-maintainership-in-the-age-of-ai/

> > I thought we ask for that in some document, but couldn't immediately find it
> > (and nobody does that).

-- 
Regards,

Laurent Pinchart
