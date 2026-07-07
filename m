Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70143224234
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 10:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419348; cv=none; b=WA3vCIR3hy89zwDsLRc7j0tmYKWfeGlDlpTH2pnrKpxyVOqYrMUOmvV4/0tTqpS4M6furLw6Gu9zw1V+5AW463yV9ve9PXcwYGQfWY59v5kBT5e23OL2jNDvuNn5cSTQfaTMknxS+MG/cyy5kaVGLvrSlmIh1j6Os9pW2zyQLho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419348; c=relaxed/simple;
	bh=Rl3p0URXys+IWXAxY8I2dgazOTxwsjW4Kf6oIQLur0E=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=RtmAtnPns9R+ErZB/wdECUxouOmhasf12MhBNNEWoY3xHvLpsKSC8W+fhjPvZbPJ4hzHGYTa90mPDp+yaEOHP6BIYlGQNqM2yaseYs5+ODyo6C3EKrNh2oyfyZy2cUaTwERbf4VsgBFYpgMUX0xifUMWPQiMexDdRpiTNW/3vhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=dQR26VBr; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="dQR26VBr"
X-KPN-MessageId: d05c04a6-79ec-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id d05c04a6-79ec-11f1-9e8e-005056999439;
	Tue, 07 Jul 2026 12:15:44 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id d059ea4e-79ec-11f1-91b4-00505699891e;
	Tue, 07 Jul 2026 12:15:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=XrNegeszo3wuoNwRWe/Y6A1G9/9S/OEIl4RN+rC7Vaw=;
	b=dQR26VBrYWmXBHtIQsbzhJdR89ux3uB7Ljbmp+Jv5l8JAZKCtBPFwu5pa9QspPb/c6+nv+IoKBSfz
	 7RmhbytZMsKVlahD1oG5FH+ebY8KZL4ChUwVKizL4KTLOcI4qkJJowCF/G/7DEIGY3aaeHXro+lo2a
	 lY/5XbyyS2MBWApIizlWyE9XdtzCjbaj9E1P3yE/otU/ZZryxThrWSThCKDVn2UCO2dfB3bJiWoQ1Q
	 ns4u1VVh61/Wprhk4I01t3QBM/oikDZM4WGR18sDEWBQPkxro3mqMm1tEv/gCqIshcW9xOv8pVhoT2
	 Xw7DnjIM/VyXZLVshtYu/EG0l8jl6iw==
X-KPN-MID: 33|cnnF+rt6jiBs6YLB8W39m8g07+aG0qSte9UNUbdImx48zcBM+GIW9zzIwkWJnMs
 kKvsuQ/2QQyiKPT11JNnkS2tU2nvyRualoZ/Tp5973Mk=
X-CMASSUN: 33|ryHYDpWzA6391rX2L66HVFKhg9bWKQV2c2lbri89ORF4vWDZgHSaZriJC/zyTcn
 Ozbp3UazShzioVELwIWitlw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id d04de160-79ec-11f1-916a-005056995d6c;
	Tue, 07 Jul 2026 12:15:43 +0200 (CEST)
Date: Tue, 7 Jul 2026 12:15:43 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Lorenzo Stoakes <ljs@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Boris Burkov <boris@bur.io>, Jeff Layton <jlayton@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Stitt <justinstitt@google.com>,
	Carlos Maiolino <cem@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Brian Foster <bfoster@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	David Disseldorp <ddiss@suse.de>, Mark Brown <broonie@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@kernel.org>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	workflows@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Message-ID: <1778033301.182575.1783419343917@kpc.webmail.kpnmail.nl>
In-Reply-To: <akzETpsps4TMfqpC@lucifer>
References: <2114bb79bb5b6e5584a8236de3590e2f4bf0899f.camel@kernel.org>
 <20260702161330.GH3534761@killaraus.ideasonboard.com>
 <2026070227-payroll-eradicate-8f66@gregkh>
 <16c507cea8f2873766e1de586d9a0d73234a3038.camel@kernel.org>
 <akaWnQ5Pkg_676B-@lucifer> <20260702211740.GA639365@zen.localdomain>
 <3f447113-4407-471f-878f-e6d6edafee71@kernel.org>
 <akez23ZhLRSGMFQ1@lucifer>
 <20260703163251.GB3734786@killaraus.ideasonboard.com>
 <e93d28e4-750c-4a4f-8bfd-7a0b404cd05c@kernel.org>
 <akzETpsps4TMfqpC@lucifer>
Subject: Re: [PATCH] Documentation: remove the requirement for LLM
 attribution
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 07-07-2026 11:20 CEST schreef Lorenzo Stoakes <ljs@kernel.org>:
> 
>  
> On Fri, Jul 03, 2026 at 08:22:20PM +0200, David Hildenbrand (Arm) wrote:
> > On 7/3/26 18:32, Laurent Pinchart wrote:
> > > On Fri, Jul 03, 2026 at 02:12:40PM +0100, Lorenzo Stoakes wrote:
> > >> On Fri, Jul 03, 2026 at 09:05:58AM +0200, David Hildenbrand (Arm) wrote:
> > >>
> > >> I personally think 1-2 are the only relevant cases.
> > >>
> > >>>
> > >>> Yes, I raised something similar as reply to Christian's RFC [1], where I said
> > >>> that for me the information *how* it was used is much more important:
> > >>>
> > >>> "
> > >>> Assisted-by: LLM # translate commit message
> > >>> Assisted-by: LLM # generate some test cases
> > >>> Assisted-by: LLM # cleanup logic
> > >>> Assisted-by: LLM # everything and I have no clue what any in here does
> > >>> "
> > >>
> > >> Yup, and we don't need complicated rules for that just 'document what you used
> > >> it for and give a sense of how much'.
> > >>
> > >> It's fuzzy but useful.
> > >>
> > >>>
> > >>> That tag is it stands is pretty useless, really.
> > >>
> > >> Not to go over it all again but I disagree, even as it stands, it allows us to
> > >> engage in conversation about the LLM usage if admitted, and to point those who
> > >> are misbehaving at the rules if not.
> > >>
> > >> And it is a clear way to get the boolean 'is this person saying they used an
> > >> LLM'.
> > >>
> > >> But I agree with you it'd be MUCH more useful if we did the above.
> > >>
> > >> I wonder if we could get consensus on adding a section to the doc saying that
> > >> it'd be _useful_ to add a comment explaining _what_ you did, and explaining the
> > >> concept with some examples?
> > >
> > > I'd support a patch that replaces
> > >
> > > Assisted-by: Claude:claude-3-opus coccinelle sparse
> > >
> > > with
> > >
> > > Assisted-by: LLM # generate some test cases
> > >
> > > and rewrites the Attribution section of
> > > Documentation/process/coding-assistants.rst accordingly.
> > >
> > > I think most people in this mail thread have expressed that how
> > > generative AI was used is the most important information, and several
> > > people (including myself) have expressed a desire to stop the free
> > > advertising. Unless I missed something, I don't think anyone has
> > > expressed an interest in keeping the agent name and model.
> >
> > Yes, that's something I would enjoy seeing. Who reading along has a problem with
> > that? (assuming that the tag must stay)
> 
> I think the silence suggests nobody :)
> 
> What we could do is send a patch to simply add a section on adding a comment
> explaining _what_ used an LLM and strongly suggesting it would be helpful to do
> so.
> 
> That should hopefully be uncontroversial, then later (or alongside that?) we
> could submit an RFC for making the language move to 'you MUST do this', as that
> will probably be the more controversial bit.
> 
> I don't see any reason why we can't just send the softer version right away.
> 
> >
> > --
> > Cheers,
> >
> > David
> 
> Cheers, Lorenzo


I haven't really seen anyone opposed the following I wrote earlier:

- it's more relevant to know how an LLM was used than that it was used (and the
  tag is just a quick indication of this)
- advertising for particular corporations does not really serve any purpose to
  the community, so just say "LLM"
- the tags may be used to prevent arguing
- the requirement to be open about LLM use (whether by tags or whatever) makes
  it easier for maintainers (if they feel the need) to de-prioritize patches
  by someone unwilling to abide by these rules whenever the maintainer perceives
  or suspects prior undeclared LLM use. This prevents an asymmetrical situation
  of LLM slop being produced much faster that what can be reviewed.

Perhaps the last point is more controversial.

I would really like to adept the systemd policy text.[1] If I have time later today
I'll try to write something up... although maybe it is too ambitious :)

[1]: https://lore.kernel.org/linux-fsdevel/20260702-bahnen-ertappen-verspannungen-0eaaf1e3f5af@brauner/
