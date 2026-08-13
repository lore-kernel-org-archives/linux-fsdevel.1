Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E313955D8
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786627800; cv=none; b=grjdNutDg6dMQWYN6AXB1SflTlAHWNq15D6/ri9AyTGBuQ/XpfY8I922Tz3Muy9drLYlhAdtUj63hR+TLJGqCEclZ5xHn8B7fgfYbOwAwlV+lqApSQnbHzCtvAswSxx6DeLqUvzvyz82BBb6OHi2TasxaB6j6qQbRJaIQosu7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786627800; c=relaxed/simple;
	bh=hnj6l11DOGe2FFvkb9OwsGJ2XNY4AlAJ9yRSdpoEkMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbgf6U8U5FutgnF9KsD8aGf8PHRtLx3NtjnjRRAPokxfe0eonCMeJyd0zavrky+c5pOUSwuy/NfOYvHs4QO2kWyLo6LTtaNw7z2f29Yk0Sj3y904Uzn+lpAy0j8N/6RE/GPYJJMgJPXn2Nct44sq1cqk8Q6ROJtepWle9ZuaMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jjdfiP4p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jjdfiP4p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C331F00A3A;
	Thu, 13 Aug 2026 13:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786627798;
	bh=hnj6l11DOGe2FFvkb9OwsGJ2XNY4AlAJ9yRSdpoEkMQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jjdfiP4pElG6O8LByz2BX6u3wmZjkW7AsFndE2/slClzbpHkNNutcG/RtJaxbpcPn
	 tDOsq8gSItTRf3ZhgK+OZqhMOb1PVbeSDC88nqPNWJXCWBVftPfUsGfMmKF8C8lN8J
	 P1P/Rs7xJLisicCaSyXn6r1rbRG9TpOoS7EdSX80lQbQN+IK784vH31NMUYjciqVPG
	 wLXdDQ+GUOcBj1ELtDEHUxmeVY++0qzJCU4LmQRv9HBA/fQoaW9PW6I1MV49Pbbl6V
	 PVJ2NNBdjSWAkaeiGmNCYXkYK9tPGNftAngAeNIarP/FuVLX4TB+Hct4U1VBIvQ4w3
	 +u6SMLpswsTlQ==
Date: Thu, 13 Aug 2026 14:29:38 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org, geert@linux-m68k.org, 
	Arnd Bergmann <arnd@arndb.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <an3COKVbgQKdY52d@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> Hi Greg,
>
> On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>
> > Given the age of this issue, I don't think anyone uses no-mmu systems
> > anymore :(
>
> There are a few of us using it for hobby stuff[0][1] and there are
> apparently people using it for actual commercial stuff.
> There was a session about this at LPC 2025...
>
> One of the big problems for nommu seems to be that everyone is
> convinced it is completely unused and totally broken. :)

No, the issue is that nobody seems to do any testing or contribute any code
aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
I am missing people's names here!)

There's been situtions where nommu has been broken for a year and _nobody
noticed_.

And yet whenever nommu comes up people always seem to pop up and say how
important it is, then mention a talk etc.

Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
code. Any or all of it :)

Meanwhile we in mm have to _constantly_ fix stuff up in nommu because it's a
total mess and has real maintenance overhead.

Having to account for legacy systems that make no sense in 2026 when you're
trying to make improvements to systems people use, or not being able to do
certain things, really grates after a while.

I mean if you don't believe me git log mm/nommu.c. This overhead reason is why I
now co-maintain it.

So I'm honestly a bit tired of people popping up when the whole 'why nommu'
thing comes up, then disappearing when there's work to be done.

In general - it's not really for those not doing the work to dictate terms to
those who do, IMO.

So while I appreciate you confirming there are users (yes we know :) frankly
that's not the question. The question is - why isn't a downstream kernel enough
for you?

Last time I brought this up I basically got radio silence, a couple times before
that I was told 'nommu has no maintenance overhead and is perfectly good code
and we have products' by somebody who contributes little to nothing in terms of
code and nothing no testing.

So bah humbug.

AFAIC it needs to go and we should never have allowed risc v to add a new nommu
arch.

>
> Cheers,
>
> Daniel
>
> 0 - Really good example(s) of the 68000 port
> https://github.com/crmaykish/mackerel-68k
> 1 - https://github.com/LinuxMD/linuxmd my version of the 68000 code
> with devicetree like those fancy ARM things running on a sega
> megadrive.

--
Cheers, Lorenzo
