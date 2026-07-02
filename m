Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F39480350;
	Thu,  2 Jul 2026 09:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782985030; cv=none; b=W0xhrCq2s+Ohem0inU3D6e3Xf9STN477kEigTUL2g3Qoo8mDwNaQFJv4AITJWcnsIr22ppyJ+fogANPII3b3cX7MRzucOzwmmae2qmCwORkOWhgwOzj/GnOI14I14c+aflIhwX4b9AQiG5su/kefvqX6wjVvST9gekZp4zXm8No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782985030; c=relaxed/simple;
	bh=F256BFkHUVtMHlt+j/IArBp0TcI8EFEg3oC6P2PCN8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDh4o3zO0pvazYSDzlzKAqYXlIsEPJUO2MJOQZk+9xPnJxACqtKESIX4O4w1kCKbDfWkWqMAl+VAdHkfBBJzQvpN9AWM3zTSbfkuzgfrB4TvshGpssR/YN04LAKAw8Z23Mt3tCYkg33YWn9wQvndSI1j8+WXWctCvmlXUDim+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgjtOGjK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgjtOGjK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CA31F000E9;
	Thu,  2 Jul 2026 09:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782985029;
	bh=F256BFkHUVtMHlt+j/IArBp0TcI8EFEg3oC6P2PCN8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZgjtOGjK0zDu0PYPQfJnc2e5FmDQt0zw+ap5VSD8KdNDv+LecZQfYanXQW0ZvHeY8
	 U8In/hdZGig6AvDF4385PlqZJ1XFdhmLkqvGvjgeX8qihKGaFfAx82fY67hpxb2H/0
	 sAtWjfGEIPc/K1zdW9DOm09fP9T33cAI4qh89PfYre/Ul6i/sEFV+GxaKu/yVlrmFf
	 fIGsTHYffKMOPwXDp/rnRXYxGyeGsbzy8x4waqSfXr4eTtXIuJk5xVBN/UFx45iiik
	 CjH1kRkMhF8etAHiF7CYyy6mYNhykksjoYAia/SIZlzN71uLP+dwcVX+LJdr9sWPkE
	 lbKoe9etouBHg==
Date: Thu, 2 Jul 2026 10:37:00 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, 
	Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>, 
	David Hildenbrand <david@kernel.org>, Jeff Layton <jlayton@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] coding-assistants: simplify attribution
Message-ID: <akYvWe505KPzleBL@lucifer>
References: <20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org>
 <akYasD1ckWcH1C0g@lt-jori.localdomain>
 <a17b9a17-0ca7-4912-836d-4637cd0110f7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I think it's helpful to point to guidelines, and I've actively used that in
practice with the recent wave of AI slop in mm.

But yes it quickly becomes very politically difficult if somebody adamently lies
about that, and as you know I've found myself in that situation too :)

However, there are those who _do_ attribute, especially those working at tech
companies that are encouraging LLM-usage, and others who are in good faith, so
having the tag is, I think, helpful.

It also strengthens the case for those who are dishonest if we do at some point
institute a 'well this seems very likely to be so sorry no' approach in mm at
least.

>
> Such situation then penalizes those who disclose so obviously they won't. We
> should drop the tag and instead think how we can empower maintainers to be
> able to use their own judgment and deprioritize dealing with what they
> perceive as LLM slop, without fearing consequences of not being properly
> responsible etc, and not rely on any non-enforceable tags for that.

I agree we should have the ability to do this.

But the amount of time wasted on AI slop is already too much and we're only at
the start of this, we really need a very low effort way to filter it.

Tags with more information WILL help IMO, but I honestly think, in the long run,
we're simply going to have to deprioritise patches from newcomers that do more
than small changes.

Other open source communities are ahead of us in this and that seems to be the
road being taken often (e.g. [0]).

Cheers, Lorenzo

[0]:https://godotengine.org/article/contribution-policy-2026/
