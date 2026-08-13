Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C457481FD6
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629506; cv=none; b=cx+LsdYisk/ozHwOYQB+kKoliczSuxBa4wYhaspgjHlrOhdh4jljMIJHE5LvjRsKMVIByzxIHvEH6gWxRLkWl4MEK6L6NrFCbo+WdmusR3CSdtyTX1hkzZltsJPRHaLEVyC6IpDPLF9ZXoav57paBFQTdOgLEyn551azk8ytO/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629506; c=relaxed/simple;
	bh=qzrHbaU5pAHvUqWsTPrxNR7GVWHprbyOEnCbtAT7AcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvdnCy8XreU+v0U3Hs2lH1Tow3EGN6/RKZbtev7iefYAquJlGf5ftG26bqMAxpbu22n+KjL1iP990R5VyYfuvYCIwfPf6ax5kNdgZeJlVr/XeEF76wWjq9z5k6ZOhQ/xjLaKg6iODMzYM8QzQep7myJpXOYiIeNbmKApt2q0q48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqS+hVh+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqS+hVh+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35ED1F000E9;
	Thu, 13 Aug 2026 13:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786629505;
	bh=qzrHbaU5pAHvUqWsTPrxNR7GVWHprbyOEnCbtAT7AcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bqS+hVh+zLMwWp5u1ZR2TMom7G8p8tYQMYln5CBx+YPB8NVeAG8/vpQxS5u3a2sZu
	 I9zOj0ZKASTYVR7o/NIEG7eT4gVD9GG//5lwE6wELMJ7lEhOpoX/ouxsuxUieyTeZM
	 M+CQSa6bQhjwlmyNYlZc+tFQj8IMypgRtozH9xq5NRZeoCeTv8BgWMZ0ei9JPeETYq
	 9J2hNlUH/5nMZbg3FRISem0dA25oNT9PLqI6p1eMMj9sbRXEp5eZWK6rgZgHjJcFGv
	 I0DfnV8+/1nrVlwhFQ3Nn6tK77ZPB+i85iBKB66WUxKHvATkVYH6j0TmZ0H218X4uU
	 LkxBcDn57Byug==
Date: Thu, 13 Aug 2026 14:58:05 +0100
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
Message-ID: <an3M0qmvzu2BS73y@lucifer>
References: <20260813063401.1786548-1-thehajime@gmail.com>
 <20260813063401.1786548-4-thehajime@gmail.com>
 <2026081355-remold-sterility-84f9@gregkh>
 <CAFr9PX=zC8GnxwrR=wTwA4xQq89cHYpxZWooS+-=Q-WuNbjanQ@mail.gmail.com>
 <an3COKVbgQKdY52d@lucifer>
 <CAFr9PX=dkFhD5Q7JWaR+rXt_Ah5n2hxi2W3biqQsUC77dAaZgQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PX=dkFhD5Q7JWaR+rXt_Ah5n2hxi2W3biqQsUC77dAaZgQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 10:51:39PM +0900, Daniel Palmer wrote:
> HI Lorenzo,
>
> On Thu, 13 Aug 2026 at 22:30, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > > One of the big problems for nommu seems to be that everyone is
> > > convinced it is completely unused and totally broken. :)
> >
> > No, the issue is that nobody seems to do any testing or contribute any code
> > aside from at least Hajime (thanks Haijme :), and possibly others (forgive me if
> > I am missing people's names here!)
>
> > There's been situtions where nommu has been broken for a year and _nobody
> > noticed_.
> >
> > And yet whenever nommu comes up people always seem to pop up and say how
> > important it is, then mention a talk etc.
>
> It also broke sometime around LPC 2025, I spotted it, reported it..
> and told the people in the room at LPC for the nommu talk that it was
> borken and maybe they should take a look. :)
> I think I maybe even told Tazaki-san in person that it was currently
> broken in the hall outside of the session.

OK this is what I like to hear :) please report it on-list.

If you do:

$ scripts/get_maintainer.pl mm/nommu.c

And send reports to all people/lists listed it'd be appreciated!

The grumpiness is not the usual mm reception, and certainly not that to bug
reports/patches.

>
> > Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> > code. Any or all of it :)
>
> I rebase my 68000 tree on mainline regularly and make sure it still
> works. That's how I noticed and reported the above bug.
> I have a bunch of stuff that claude fable found, validated with QEMU
> and then I checked on real hardware but I'm not sure how to send that
> without it getting instantly marked as slop. :(

If you check on real hardware and confirm the bug that's not slop that's a
legitimate bug!

I'd ask that you do a human pass over anything produced and rewrite any of the
insane paragraphs it comes up with and then check to make sure it's all valid
first.

And if you can come up with a patch (please human-written though using AI to
help is absolutely fine - I do the same) all the more better.

>
> Cheers,
>
> Daniel

--
Cheers, Lorenzo
