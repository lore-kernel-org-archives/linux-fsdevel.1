Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449A47F2EE;
	Thu,  2 Jul 2026 09:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985129; cv=none; b=QUPt5Ue1S53yYI6onS4pcmU0NxtRPsqba2mtT+xUXNg0nG5f9Ym3h1N1g6b7xdMpQvaWZRu8hnn3XsWI5rCi0BXwVqtIGFrT1fN1qTWk5CM/rjOIiJq09WiGTAezizMNHRGYMSR8Z4Ztep9IbFrBZjtKpcM9UsX/YIRGB4qQkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985129; c=relaxed/simple;
	bh=wnMx/Sh938zhMHMISCcZ7pZTpsx1OdGkIPpkEcdw4zs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DwqfS16fu0jpAzoyRNOllmEHFGwaXJS+GU13AiBIdt2+zJ7bq0B6MJFSE1ksNl6hvLvKOocWvatVODf2DLrV3oL+SAUXTovnnHViff0NxzNHEbLlTC1mnQetxsxP+VY6gMNw/69YianNtvqhPLp6V0582WKrCjxR08H9hWIlRg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=upQFpz2e; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="upQFpz2e"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81C128CB;
	Thu,  2 Jul 2026 11:38:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1782985080;
	bh=wnMx/Sh938zhMHMISCcZ7pZTpsx1OdGkIPpkEcdw4zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=upQFpz2eloomqLzv74b7/9X+e6nqHHsQaXe9plX9Snhx4dEyPhULpUr/sDOW8B7cd
	 vWZ1DQxP8fD2FBMIz1B+roJdaaWxGORtL1kmGJ6c04pVT5HqrT5XfoqgR23FJz7bEU
	 zKWQmwReDONyWFaVjsPWAzsh9chv4DZi9mXsBC3E=
Date: Thu, 2 Jul 2026 12:38:44 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>,
	Christian Brauner <brauner@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	David Hildenbrand <david@kernel.org>,
	Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <20260702093844.GA3491311@killaraus.ideasonboard.com>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>

On Thu, Jul 02, 2026 at 10:44:34AM +0200, Vlastimil Babka (SUSE) wrote:
> On 7/2/26 10:12, Jori Koolstra wrote:
> > Ah, I still reigniting this discussion again :)
> > 
> > What about a combination of what David and Jeff say? The whole point
> > seems to me that the salient information is not that an LLM was used (or
> > are we going to tag Sashiko as well or any other LLM-based code review
> > tool?), but what is was used to do. This information may be relevant for
> > how the review is approached. The latter should perhaps only be in the
> > cover letter and then we can drop the assisted-by tags altogether.
> > 
> > The question about enforcement remains.
> 
> It's not possible to enforce it. People can deny it if the tag is missing
> and you confront them and even though the submission has many signs of being
> obviously LLM, there is no definite proof. We've seen (likely, as there's no
> proof!) that happen in mm.
> 
> Such situation then penalizes those who disclose so obviously they won't.

I think there's also a penality for those who don't disclose when
they're told they should: it will lower trust. Kernel development is
largely based on a trust model. If a contributor decides to adopt a
deceiptful behaviour, they can expect maintainers to raise the bar for
accepting patches, when not rejecting them outright.

I can't quantifying which of the penalities will be higher, but I hope
(call me naive if you wish) that the vast majority of contributurs who
*know* we require disclosure to abide by that rule, even if it incurs a
penalty. After all, proponents for LLM usage claim such performance
improvements that a small penalty during review can't be that bad, right
? :-)

> We
> should drop the tag and instead think how we can empower maintainers to be
> able to use their own judgment and deprioritize dealing with what they
> perceive as LLM slop, without fearing consequences of not being properly
> responsible etc, and not rely on any non-enforceable tags for that.

-- 
Regards,

Laurent Pinchart
