Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A8345757;
	Tue,  7 Jul 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783436720; cv=none; b=gRa8zEhzZ1syJ9nbozOY1L9dydbynpFJlSOq7F6tkyZ10MiOjIe5BFyH7CZC383i8G2fZLi+QEfde5udXc44s+3NRg+CV+s4knP0FrutQSMRCnJY52DNPLUPJxi3yvT/HrEkc/iNIvIwt9+awyLRt8FH5r3fiyYqflHEpsDJnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783436720; c=relaxed/simple;
	bh=V2izBQ5ocu19EBM8LWCHNqThTRdZz0FHDwzAwqwu1lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6zlT5n7DzKUF8J6Sq+oaTSQlC5qD84mGSHm8vvMG46m1/6XShVK6cdG/lOtCP2RtcQ0IbeAEmLHr21RY3xneb3vRYInvccx1FmMcYnVL3NnWdV/a4omNBB3qQ24A4fvZYKHGW+BDo9mhCPbAY5NIQMEyPPHhPJTaDZKyS1rXuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=g38ixdE/; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="g38ixdE/"
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C11ACBAE;
	Tue,  7 Jul 2026 17:04:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783436664;
	bh=V2izBQ5ocu19EBM8LWCHNqThTRdZz0FHDwzAwqwu1lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g38ixdE/e5n+AFvp0Y1waO7j9Ey6zh42gm8UwpI9m2Fqvq1pHCXCi3XNjS+hyFPxC
	 Cjtcz5mmn47QZ54GljMfIS7Isrg5AaGs/ETTqbbqUn2OnmzlcJgnW8C4g+9JMxX7iE
	 jTH8ZqjHmK8IvLnHE1QMwHo47AMvqOibxiREoNj8=
Date: Tue, 7 Jul 2026 18:05:11 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] Documentation: remove the requirement for LLM attribution
Message-ID: <20260707150511.GB254690@killaraus.ideasonboard.com>
References: <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
 <0ba6bf66-e48f-40df-a953-503d317b3dbe@kernel.org>
 <20260707124031.GC211515@killaraus.ideasonboard.com>
 <ebc1f034-7297-459e-975d-5c143567392f@kernel.org>
 <20260707141803.GA254690@killaraus.ideasonboard.com>
 <ak0UK51HkMKHyte2@lucifer>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ak0UK51HkMKHyte2@lucifer>

On Tue, Jul 07, 2026 at 03:59:48PM +0100, Lorenzo Stoakes wrote:
> On Tue, Jul 07, 2026 at 05:18:03PM +0300, Laurent Pinchart wrote:
> > I haven't heard anyone involved in this mail thread objecting to the
> > concepts you translated into sentences below, so I think it's worth a
> > try. Of course there may be objections from people who are not aware of
> > this very conversation.
> 
> To risk repeating myself - why does it all have to be in one?
> 
> Send the non-controversial bit, get that merged so it's there, then follow it up
> with this. Simple no? :)

Sure, but I don't know what part would be the most controversial :-) I
haven't heard any objection in this mail thread.

> Sending this, getting it rejected, then having people's backs up because they'll
> tie the two things together seems the less politically astute move.

-- 
Regards,

Laurent Pinchart
