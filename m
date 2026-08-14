Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F3046EC61
	for <linux-fsdevel@vger.kernel.org>; Fri, 14 Aug 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786712562; cv=none; b=fcm6Fhn9kxQg5lbsZQ1wEktdvVJuYGxKRvA28tI6jQiNPpr4M88gKDXW1fmnINH1e4EVoF64JKh2qu9LLjVf5+xGjrdrJ/A7gDy0azQXosknRLiFHJ8L2lQdh97qlowLrYLpbPU7JOQZO/ggy8MgKfpFJkKV0mrx2BfxGeQJUBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786712562; c=relaxed/simple;
	bh=HDy2Z7/19cG3MeawO1NCZPkI6O860csbEKEOPze4VeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/Er6AGFtUObXfD9yLQ4QGfC/7H61Zj1yfc6aZPySSD9G9utu9hNoO2KvNwvdj9m8dYyGp5M/h9SpylkQqyjvRqirbIhWkmeLG83k9hXusXqXUa/3J3/bIfw8XDxQWb5nwYele2xydEcB/zdSbRkXupV0entP7qGPLHiJ5ROnf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRwhsrIp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRwhsrIp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC841F000E9;
	Fri, 14 Aug 2026 13:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786712560;
	bh=9u1rGVG6agDFZWdG40l3zEmJc1IeDbuPGBZf6iWuaOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WRwhsrIpWrAeXQ6+P5BbK653mIKbVuP3KoJuEhKi7AYB2Cy4IwT2135T3HzhsQn3z
	 pAz+xiSbm2blljK4UjJ1Uyl/H2qnJ8/qxqgINpoU4b3IhCVSVEOYQ81GjtNIsE3VXh
	 NO+eBPFpJYwfl57ePvXhg5q04txgqXy5lW6XmgTnUQ8RPzyg1UXbKcuZdfWM8NlC8P
	 bGEnViqmf1FTXg4JskvS8iA+UMoX0mcTHM5VyDDP7pdUJVqRqRxcjKOFfXSYIbaI+d
	 t+JJrebOkmosntcpdRtPblcAI3spk1A78mewlJ7fp5lRojtQB0uHk1BLwNQTkXV5kP
	 ymsFTF5pCkAgA==
Date: Fri, 14 Aug 2026 14:02:21 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Hajime Tazaki <thehajime@gmail.com>
Cc: daniel@thingy.jp, gregkh@linuxfoundation.org, linux-mm@kvack.org, 
	geert@linux-m68k.org, arnd@arndb.de, willy@infradead.org, jack@suse.cz, 
	akpm@linux-foundation.org, liam@infradead.org, vbabka@kernel.org, jannh@google.com, 
	pfalcato@suse.de, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <an8PTKUAuZh3BtJm@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
 <an3COKVbgQKdY52d@lucifer>
 <m25x1crhym.wl-thehajime@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m25x1crhym.wl-thehajime@gmail.com>

On Fri, Aug 14, 2026 at 09:42:57PM +0900, Hajime Tazaki wrote:
>
> Hello Lorenzo,
>
> On Thu, 13 Aug 2026 22:29:38 +0900,
> Lorenzo Stoakes (ARM) wrote:
> >
> > On Thu, Aug 13, 2026 at 09:43:37PM +0900, Daniel Palmer wrote:
> > > Hi Greg,
> > >
> > > On Thu, 13 Aug 2026 at 21:26, Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > >
> > > > Given the age of this issue, I don't think anyone uses no-mmu systems
> > > > anymore :(
> > >
> > > There are a few of us using it for hobby stuff[0][1] and there are
> > > apparently people using it for actual commercial stuff.
> > > There was a session about this at LPC 2025...
> > >
> > > One of the big problems for nommu seems to be that everyone is
> > > convinced it is completely unused and totally broken. :)
> >
> > No, the issue is that nobody seems to do any testing or contribute any code
> > aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
> > I am missing people's names here!)
> >
> > There's been situtions where nommu has been broken for a year and _nobody
> > noticed_.
> >
> > And yet whenever nommu comes up people always seem to pop up and say how
> > important it is, then mention a talk etc.
> >
> > Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> > code. Any or all of it :)
> >
> > Meanwhile we in mm have to _constantly_ fix stuff up in nommu because it's a
> > total mess and has real maintenance overhead.
> >
> > Having to account for legacy systems that make no sense in 2026 when you're
> > trying to make improvements to systems people use, or not being able to do
> > certain things, really grates after a while.
> >
> > I mean if you don't believe me git log mm/nommu.c. This overhead reason is why I
> > now co-maintain it.
>
> after spending more times to look at code, fixing issues, finding
> other flaws, etc, now I become to understand what you meant in past
> emails, when you're saying a more maintainable way of implementation
> of nommu.c.

Yes :)

Thanks for having some empathy about this :) It seems a lot of the nommu
advocates simply assume it's little or no overhead and is 'working
code'. No and no.

I know Liam had to do a _lot_ of work on maple tree to make things work
there, for instance.

And the recent VMA flags changes have had to be heavily updated to account
for nommu.

And the list goes on. New features have to touch it all the time to avoid
build failures even, and etc. etc.

It's a really absurd situation to be honest and the RoI isn't there at all.

There's a reason I keep going on about this :)

>
> Since I wish to use nommu.c in future with the latest kernel, I'd like
> to contribute it for, let's say, refactoring the nommu component which
> mm subsystem currently has.
>
> but for the moment, I wish to start with introducing test cases from
> very basic checks (which is in the [6/6] patch of this series).
> Without such a base, we may not have any chances to improve this nasty
> situation of nommu component in mm subsystem.
>
> # this motivation also applies to LTP (linux test project) which
>   currently doesn't support running tests on nommu platforms (I've
>   already started).
>
> And also as I mentioned before, ideally the code should be maintained
> by people who use it.  And if I claimed that I used/use/will use
> nommu.c, I wish to maintain this, or at least wish to help to decrease
> the overhead of maintainers.  This series is a very fist step toward
> this.
>
> I hope it clarifies a bit for your concerns,

Thanks, and I appreciate that you're actually doing work here, but I'm not
sure a single person suffices for this, as well intentioned as you are.

And as reviewed, these changes seem to be adding _more_ maintainership
overhead rather than less, I fear.

I believe nommu is pretty broken across many domains (it's fun to set
claude on it for instance).

And we've already spoken about broken things that have sat around for
a long time.

The way it's implemented now is just horrendous in any case, if we were
forced to keep it in the upstream kernel then the correct solution would be
something that somehow 'emulates' an mmu system.

But I'm not sure that's even workable, and likely implies heavy
maintainership headaches.

> -- Hajime
>

--
Cheers, Lorenzo
