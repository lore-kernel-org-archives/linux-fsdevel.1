Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469683C09E2
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621417; cv=none; b=hte0ncMeMZXvtKEyX2b7FdiNNx4H5B24wztSEWQ1wXkKY9Q0ZuSoyLiIj/dt2YNn9PKu6YDjSNaF5RmgAHBFxPbv8qV9nGeCILRSa6miV/yN+foyWD2CBekNPD1B5FxSPIuOspGzhizBcwR1jvprIuF53w4t6fv7YXCn0aBWVr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621417; c=relaxed/simple;
	bh=BBtSjGcebtyP/J62sgW6cmqmnPgGPP5+1UUDQu7d5BQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=XfUWUVazVi2Q42HQuaQ4RZ90VenJ0BnZV/soChLbtK+QMUYly3lBdrnDzoYjqTbb1S7iTmQo80obJixGP55fRLLme/QsNfgVaQsrmvZkEd/wJuFR6CdYfG6rTbBzeagcB9SLackHIPmnwOJRVrLGff8hlJFdJcVOlAcAW0ZY2XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=MnkiMMJn; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="MnkiMMJn"
X-KPN-MessageId: aa5f1a3d-6992-11f1-89f8-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id aa5f1a3d-6992-11f1-89f8-00505699b430;
	Tue, 16 Jun 2026 16:50:06 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id aa5dc17d-6992-11f1-ae48-0050569981f5;
	Tue, 16 Jun 2026 16:50:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=ma0GaFtXuJWq1Qr5mzmCFMElXBGDhzCawp7JuPPTNeU=;
	b=MnkiMMJnYg9aaHM4jZ8ISo2DLum512dALRUNWhRxiHKAA8cSdKihnUnpUvcAh0S/r3lahPbnlJGr0
	 8/aSLxU9v0df9pHWpzZ2q76d0C+lF9y2+SBQ5+FOjtc/5DeXWwlWurMxY3kam6w+9fJ2JSo8PVHfSk
	 6iV4fIv0dTcT2LX+QerEUk7r1zXzsPYBWrEcj0ylaroMTd35tOQaJCuR4JDy6ddI2CDcy2ThVV92L4
	 /guFQSTySggfot492J19rWwTSpIKaw0FgP8QXft44evjY0qj/aBEB6o29AJpHqZhK2HW7QG4e9cNTV
	 V0ii6SayYPbB/d038HXKI2lB9rgFhGw==
X-KPN-MID: 33|Qgi34RFIW2+KxsIpCNUy7omm4gOfqR0cnWHydssFjis8+1lNnQ+T+M8xidiRYJv
 P1wy8Qdt0mrLuN1UwzJgI6OPdntl8isjt+Sbvwo2fTt8=
X-CMASSUN: 33|/CQ8ZWo43E3Wyt0AXEPbXCorT4h/VGQYTGiTCmHfwhXpOcEkpZ29vA0O8hXBdg7
 OhFvqb8NbOeMaWHN/c+uVyg==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh06 (cpxoxapps-mh06.personalcloud.so.kpn.org [10.128.135.212])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id aa4cf9e7-6992-11f1-8edb-00505699eff2;
	Tue, 16 Jun 2026 16:50:06 +0200 (CEST)
Date: Tue, 16 Jun 2026 16:50:06 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: brauner@kernel.org, broonie@kernel.org, cyphar@cyphar.com,
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
	linux-kernel@vger.kernel.org
Message-ID: <255283964.1967141.1781621406847@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260616102250.3652779-1-geert+renesas@glider.be>
References: <20260604222405.5382-1-jkoolstra@xs4all.nl>
 <20260616102250.3652779-1-geert+renesas@glider.be>
Subject: Re: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1
 << n) for O_ flags
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

Dag Geert,

> Op 16-06-2026 12:22 CEST schreef Geert Uytterhoeven <geert+renesas@glider.be>:
> 
>  
> Hi Jori,
> 
> > A recent build failure[1] exposed the diffculty of working with the
> > current octal and hex definitions of O_ flags when trying to find a gap
> > for a new flag. This difficulty is compounded by the fact that O_ flags
> > may have architectural specific values.
> > 
> > Replace the hex/octal #defines, which are hard to parse when looking for
> > free bits, with explicit bit shifts like (1 << 11). Also, add comments
> > that identify which architectures redefine some of the seemingly free
> > ("cursed") bits in uapi/asm-generic/fcntl.h. These should not be used to
> > define new O_ flags (for now, at least).
> > 
> > The translastion was done with Claude Opus 4.8, and verified with a
> > (non-AI) gawk script. The accounting of which architectures claim
> > which bit-gaps in uapi/asm-generic/fcntl.h is also done by hand.
> > 
> > [1]: https://lore.kernel.org/all/agruPPybCx8q2XcJ@sirena.org.uk/
> > 
> > Assisted-by: Claude:Opus 4.8
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> 
> Thanks for your patch, which is now commit 0da79c259ad0554b ("vfs:
> uapi: retire octal and hex numbers in favor of (1 << n) for O_
> flags").
> 
> > --- a/include/uapi/asm-generic/fcntl.h
> > +++ b/include/uapi/asm-generic/fcntl.h
> > @@ -15,51 +15,55 @@
> >   * When introducing new O_* bits, please check its uniqueness in fcntl_init().
> >   */
> > 
> > -#define O_ACCMODE	00000003
> > -#define O_RDONLY	00000000
> > -#define O_WRONLY	00000001
> > -#define O_RDWR		00000002
> > +#define O_ACCMODE	3
> > +#define O_RDONLY	0
> > +#define O_WRONLY	(1 << 0)
> > +#define O_RDWR		(1 << 1)
> 
> And suddenly all these constants became signed? Can't that cause subtle
> issues, especially for uapi headers?

Isn't 00000003 already singed? I am by no means a C language expert, but what
I can find in the C99 standard is:

    The type of an integer constant is the first of the corresponding list in which
    its value can be represented.

and for octal and hex constants this list starts with "int"

> 
> 	#define O_ACCMODE	3U
> 	#define O_RDONLY	0
> 	#define O_WRONLY	(1U << 0)
> 	#define O_RDWR		(1U << 1)
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds

Groet,
Jori.
