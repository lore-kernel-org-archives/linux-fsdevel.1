Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C502E54B6;
	Thu,  2 Jul 2026 08:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782979815; cv=none; b=NR/dkO0BpVyze9vz7GDSMu86CEVJ8qZuNAEyvQZz3/nPpWomX1BjFGsTkBOuo7Q0zz3lHr3Quk0hThgmYAIjB1M+Gkv4QLz5sfPxwiubdaIuC1EctopEXLdhyqmFDEmSUJKssrKvkplwUrLl445a7ansALQaUyRMZIX4evifm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782979815; c=relaxed/simple;
	bh=jWqGOLYEwcxUSE4GytNyglSLHUxQeuh8bagE+ikcKE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAgGPQHhpTVmrjPaP/6o65inM60d0H+LZGqfu3xheDsWWvlTqGZsd6SRY2WMXs4w4pgSfrGJ+8fPDILjHqRppwyc4LANQECRCTo6fWwAQw+Ccjtm/ZItBwAFuBStFndE/t+4kA5picrScQjb6629U50JIlfROEOV0hYFtUIKqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kaNN1ScB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kaNN1ScB"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C005C3A2;
	Thu,  2 Jul 2026 10:09:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782979767;
	bh=jWqGOLYEwcxUSE4GytNyglSLHUxQeuh8bagE+ikcKE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kaNN1ScBwDRNFudteGM8zlX4A7pn88HH5iSTMRw9gf6P3UZA7/YSV04THKWGhIGK/
	 gLd/ARFMrnqSbvfhfRLbkVvipwUMLd+fL26FG3W/7TwAUJe5geYP2siirIQS1MPFQD
	 H9WxA3ZF/iPDgkUpF7E0Zw/vqY+P+Z1PoNu3EeqM=
Date: Thu, 2 Jul 2026 11:10:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Jeff Layton <jlayton@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702081011.GH3433808@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <5e7b9d23-4291-48fb-bdc6-47db82d33c80@kernel.org>
 <20260702-seekrank-stilrichtung-mitentscheiden-69a64ee097ec@brauner>
 <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1f29f48d-b9ff-4de2-a392-dc05781728be@kernel.org>

On Thu, Jul 02, 2026 at 09:46:37AM +0200, David Hildenbrand (Arm) wrote:
> On 7/2/26 09:27, Christian Brauner wrote:
> >> What would be much more relevant to know is to which degree LLMs were used.
> >>
> >> Assisted-by: LLM # translate commit message
> >> Assisted-by: LLM # generate some test cases
> >> Assisted-by: LLM # cleanup logic
> >> Assisted-by: LLM # everything and I have no clue what any in here does
> > 
> > I think we should just drop any attribution as a general kernel-wide
> > rule and let subsystems require them as needed. Then you can have all
> > the complexity in mm for this that you think is needed for your
> > workflow to function. This is precisely what the subsystem profiles are
> > for. So maybe just add:
> > 
> > Documentation/process/maintainer-mm.rst
> > 
> > alongside
> > 
> > Documentation/process/maintainer-{tip,netdev,x86}.rst
> > 
> > and lay down the rules that you require for LLM based submissions in
> > whatever detail you need.
> 
> I'm not really sure if having (more?) subsystem-specific tags is the way to go.
> (below)
> 
> So either we find a very simple, kernel-wide rule for such tags, or we drop them
> entirely.
> 
> > 
> > I don't see how this additional commentary you want would ever be
> > enforced consistently across the kernel or who would even enforce it. I
> > don't need more beaurocracy to chase after people in my subsystems tbh.
> 
> That's certainly a good thing to discuss. (below)
> 
> > 
> > The other thing is that I think this Assisted-by annotation is just
> > noise in the changelog. If you want to know in detail what an LLM was
> > used for when generating the patch it's mostly a signal for how
> > "intense" of a review this will get afaict (already questionable imho
> > but sure that's just something to disagree on).
> 
> I'd be happy to just have such information in the cover letter. Without any
> tags. Having subsystem-specific rules on the disclosure on that might be more
> reasonable.
> 
> I agree on the "enforce" aspect. It's impossible, but it's still easy to catch
> people using AI irresponsibly today ... and that's what we care about. Not
> people that know what they are doing using AI responsibly.

I have to reply to the "responsible" part: there's no possible ethical
use of generative AI in FOSS development today.

> > If the information is mostly useful during review then I still would
> > question why it has to end up in our git logs. It's completely
> > irrelevant information imho.
> 
> Fully agreed. In the tree it's irrelevant.

-- 
Regards,

Laurent Pinchart
