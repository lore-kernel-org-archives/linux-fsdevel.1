Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFB2480DEC
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630280; cv=none; b=WKPxSYbH5GH/FF6f/9HHniQz4r1sKsWTTKVgW2VIUOinUde9GT6myMQCFggds1jsKkxIdP1wJwDRvl2U6Cpeeckjb1sFsQ7kFEkFNu0856FKAuLjG/8i6UEGXFOAfacdTK/Uh0NuSpNPX+3EwzLLc9BFALOM1u8SFWoWFa1Umpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630280; c=relaxed/simple;
	bh=i5xAL+Z6ioL1kBxUqERbF2n1+xxFZM3APIleQ/627xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ScYLv12OQbiifI7Yw+DuEcyoa3iqiJAgAu0n9ZYyKFy9bQhvu6OAIZ/yX9CD2VfH0BwNkn1/kJ7usStc1pC0rLJX5i0GSmqOBPyyLMqv5C2UtwxgdQDZzQyATpF8r1d7JAEuanJUEzPFvW+Y9V7FDa3lM+YXqw29qOJLtWyBWu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0LPBiv3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0LPBiv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15BD31F000E9;
	Thu, 13 Aug 2026 14:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786630279;
	bh=i5xAL+Z6ioL1kBxUqERbF2n1+xxFZM3APIleQ/627xg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C0LPBiv3ugznhdJe2Kxnmfk8+i054ETuqXdHulKqnl6sEdQRjyAFzmJGpuHMDagFD
	 q7Psv29rlT+SxjseUoDD7KqNUHPP9PJspfrL8fke3bZcdG+T3QheYoIutMkwY9XUHX
	 iGjeOuGJfuIT9Kydmd4Uh5brx/KPWXW3rQFQEAk7oW1ka0xxQyT74dimFPL0p3YdBL
	 sEuFvfc2bs4QFmHQlcTtk/X0xG3xkyz1BAG8aQBld3f0t+13006b4uxU3OuNlt5JxH
	 ulqxu+YMkIHKFRFmYDqcivA9S/9L/aNWjvNykv2H1qya4UaA5zwHtfEPdEEDjkukhz
	 d0PYjywOjc3XA==
Date: Thu, 13 Aug 2026 15:10:59 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Palmer <daniel@thingy.jp>, Hajime Tazaki <thehajime@gmail.com>, 
	linux-mm@kvack.org, geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <an3O9QHUZSSGIiZD@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
 <2026081308-amigo-paragraph-3afd@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2026081308-amigo-paragraph-3afd@gregkh>

+cc Christoph

On Thu, Aug 13, 2026 at 11:02:18PM +0900, Greg Kroah-Hartman wrote:
> On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> > Hi Greg,
> >
> > On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >
> > > Given the age of this issue, I don't think anyone uses no-mmu systems
> > > anymore :(
> >
> > There are a few of us using it for hobby stuff[0][1] and there are
> > apparently people using it for actual commercial stuff.
> > There was a session about this at LPC 2025...
>
> This patch is fixing a very obvious issue that showed up in the 5.10
> kernel, which was released in December 2020.
>
> So I think the fact that no one has reported it before now means that no
> one is actually using it :)

Maybe Christoph has a view on this?

I brought this up a couple years ago and he claimed there are commerical
products which use the latest long-term stable kernel (6.18 at the time of
writing).

See https://lore.kernel.org/linux-mm/20241122123833.GA26432@lst.de/

Christoph - can you explain why none of these vendors encountered any of these
bugs or breakages?

If they are doing fixes that are downstream only, then that argues against
upstream nommu.

If they are not, in fact, using long term stable kernels, that argues against
upstream nommu.

The fact they seem to be assigning zero resource to upstream also argues against
upstream nommu.

nommu continues to be a ongoing burden for core mm that interferes with work on
real architectures on a fairly regularly basis, which argues against upstream
nommu.

I'm curious to learn what the arguments _for_ upstream nommu are?

>
> thanks,
>
> greg k-h

--
Cheers, Lorenzo
