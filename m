Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6C147AF42
	for <linux-fsdevel@vger.kernel.org>; Thu, 13 Aug 2026 14:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786630088; cv=none; b=h5EKFQWRxmSNJllwrHz9AJ7xEQ03vrBjg5n6YufMCpGlswp3gusTv2ERYhtP/s5y6HixACIPuAhQhf3YZyzR2LOnGrYysG/LaNOcrpVdVoFSA4uhC3/V7KIZV8FIW3NOYng1lr8FL8R9ds6ZRvecXOEAkMzZgeS6JL4bHdEDg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786630088; c=relaxed/simple;
	bh=RJSJZWefU1czaGTh4s7+rDOpSEJVL4LSUK3ee4wu4RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1Bn+WRhJ+Az+O9Wr10YBewfrHAAYTFWxj78csOkqLcd1kOE/YaO0pZi7vDqPIHtzM03bnr7620fqV4UmbceDGsa0XxLVDjuvc5csLUhCdOT4AQeREI0AfSShSVO3u338EqJ1muA49cZ7h5tZXFTU7WvYD7psVPTqLTgKTHIw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Jo4EJJT7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Jo4EJJT7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4F61F000E9;
	Thu, 13 Aug 2026 14:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786630087;
	bh=ILJpY2zOeVhfdUYo8J0UMIm0dyJAM7pQkJ2oTlpZAH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Jo4EJJT7ekasvk1jXDjxSIOfXcu2sd8vYPAdDUba8IOdeWRPVJ3DS1M7aJFDnpvIi
	 VRNE57tRh+FU7UU+Ga7XtJ8diU/77qaBeR0atIA56y2YZhgczBuDXh6sUdM3LXB+qq
	 p/JFPbe9ULhEk3nsdx4C7Sr5/JsXFLZeWBiSFqv8=
Date: Thu, 13 Aug 2026 23:06:33 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Palmer <daniel@thingy.jp>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Hajime Tazaki <thehajime@gmail.com>, linux-mm@kvack.org,
	geert@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 3/6] mm: nommu: fix an issue on map request to
 /dev/zero
Message-ID: <2026081357-shifty-magnetism-aad9@gregkh>
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
> 
> > Well if it's important, test it. Test the tip kernel. Report bugs. Contribute
> > code. Any or all of it :)
> 
> I rebase my 68000 tree on mainline regularly and make sure it still
> works. That's how I noticed and reported the above bug.
> I have a bunch of stuff that claude fable found, validated with QEMU
> and then I checked on real hardware but I'm not sure how to send that
> without it getting instantly marked as slop. :(

I didn't say anything about slop here, and in fact, _I_ have fixed up an
io_uring nommu bug in the past, using LLM tooling.  I am not objecting
to the use of that tool here at all, I am only commenting on the fact
that this bug has been present since 2020 without anyone noticing before
now, which implies a severe lack of users.

Heck, the out-of-tree ia64 developers report things faster than this :)

thanks,

greg k-h
