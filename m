Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB70C48124C;
	Tue,  7 Jul 2026 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451237; cv=none; b=VDs5E0sLTjY3tw3nb9VthsvQgGKoxQ4OERXSUx5r78Tyog9FEnXBePCbR0IlKvdEBAKi9Y2l1L50R6JmsGPM3uucbEsUoQySGqtaGPeabNHAGLwDFgoambW8csZ0hC4hcoST5SMIfCrUD6Wv2IB1NTkx2LdqDw0nFfvKtqzjWR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451237; c=relaxed/simple;
	bh=yoI/lWG3IaiJYnLbL4tKGnfBEvvYFR60uqX9ZISZsiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmrQvq29AEdP/2KF2Owuyvm8as85SD59LSWKZq8QS13Wr3L6TPlhqAWlHbp2rDovVcNmKovXIWyVtNao8CthX4vKZl6KKIgRQOFuk+dSk7Rpz8J7sGxeuGxtQciej3Ea0EnkJW5RNpaQ0zcwuV7cbZPPYNRmOfVAmCWDxPOrNWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7M7coxi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7M7coxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089A31F00A3A;
	Tue,  7 Jul 2026 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783451229;
	bh=2uavOVc6+8bx0x/e4wZ300EwXCUUBjrmxoMJ45v7fLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7M7coxi3PyFG5acZwSagsmFgv+MMGomOIBe9pN+8QhVg5zqd1iQIS2mdZ3V7XrwR
	 RSsC1kRLEXRcvgpMPVSTFC4zny8Xu6kvSxdMjKHgfN4+jHvtAcxXIhly9pDvLVbm0D
	 BXLvCX0OW9kBl0Qz4ik+pst/1ngHq8vh+ivXHP7GMeKEAt2fxaiOYW981y2WSXE6gY
	 lgs0Ey9IW1iAIVZao0c4WawG8PzjgDrQBEoZyxYfBRb7tD0WNROAhZMr7fTqFU9mO+
	 kXGf/xfymyBCuNvIunxYukngVX3A1wUibO52GyMqRj6EL+ZmJkjkwQipmCqlHN9mjf
	 i4X1j6GKcZs2w==
Date: Tue, 7 Jul 2026 20:06:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Christian Brauner <brauner@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>, 
	Greg KH <gregkh@linuxfoundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Justin Stitt <justinstitt@google.com>, Carlos Maiolino <cem@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Jori Koolstra <jkoolstra@xs4all.nl>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Brian Foster <bfoster@redhat.com>, 
	Christoph Hellwig <hch@infradead.org>, David Disseldorp <ddiss@suse.de>, 
	Mark Brown <broonie@kernel.org>, Jani Nikula <jani.nikula@intel.com>, 
	Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@kernel.org>, workflows@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <ak1NzGiFMwAEFNp0@lucifer>
References: <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
 <20260707-siebzehn-geleast-gastmahl-4889a8f6b474@brauner>
 <20260707-impfschutz-lerngruppen-klubhaus-7aabcc82f3b4@brauner>
 <878q7mr59k.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q7mr59k.fsf@trenco.lwn.net>

On Tue, Jul 07, 2026 at 01:03:51PM -0600, Jonathan Corbet wrote:
> Christian Brauner <brauner@kernel.org> writes:
>
> >> Then someone can basically just merge the original patch I sent since
> >> everyone seems to agree on that front. And then the extension to include
> >> how the LLM was used can be discussed in a separate patch.
> >
> > https://patch.msgid.link/20260701-work-coding-assistants-v1-1-a20a94d1d606@kernel.org
>
> I still have it around :)  I can apply it if that's truly the
> consensus... I'll confess to having not entirely kept up with the
> conversation over the holiday weekend, though, and needing to review
> things.
>
> If you object, do let me know.

I think we need the commit message to be a cleaned up a little :)

Also good to have it out there non-RFC so people know it's actually a contender
for merge.

So I think Christian should send a fresh non-RFC version of that with an updated
commit msg + with the people here cc'd, and I'm fine with that patch going in as
it is (I already gave a tag).

We can always follw up with the comment stuff later (which I consider _really_
important but one thing at a time).

>
> Thanks,
>
> jon

Cheers, Lorenzo
