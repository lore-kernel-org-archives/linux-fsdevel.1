Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78952282F2C
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 20:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781640331; cv=none; b=Iu5pqxU73YSZTX6pv9m6/SBGyXf9xk7nqT0tjLKt7heZ9+ZymMHZPqegH55lO5iFwLww/0g2AJMPov058WYTV9TBJuFoo7cQEAlAnihvZEkidSYgNShMTxowGv8jit0W6OKMI54FrPMnxsfz1wb6ypKlUE1I68Er+M+A1Vzj+Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781640331; c=relaxed/simple;
	bh=4BmOp7isfHANQ8ijXBq1+6ImYbZeD+NvIUCYVagGHJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h3H1FNEMQ3e2x1THo8vcZtGWyKWgQjTrBNo4Z1SowEBlwLlRLOFjuEWHwVtxNK6dk/MExbF6LGofZOI618OuJLGQrjgv7zAW/0oaawNB5gZnIbGY/nngrpGktzWSLQvshBppU1aPpRz8EEkiirXTrQ+PIXLY0cT9eo2bHZDFGb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEODnDyy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEODnDyy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ac10e337so33783955e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781640328; x=1782245128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNw2t8LP5ojoxPDmcRWaKhHWz4MkqZ+bxfoJSWy6tHI=;
        b=VEODnDyyhknneBpRWgxlTSvYTYx5srS84355nv4t6cQUKjlKGFxzbMad/GNigPLDhN
         Gzx55brBaf4DhbicR+jOtm2Ljod5WIVVaYGxdzVwq7QafopkrHcHBHG8lc14lw2Ql7Mi
         Xljl31rUXhwkfgOQLJXOMXBSqi/uGMkQFZx4F8eWcaS3fzM38FMpMXT1hDxyTV1wXFrC
         IJTzSKzjiRJtaGvd8ikJhy25LkctkNUb9hWGa2vDHd/n0or7Ho0CLTdP1nCh81tXIzqu
         k92AA44SxTNRHvSXYtexYp6HfJKMS7qqZPIP3Wq2OibXFoCDCXWtVJJALKDXRv5H3/3K
         bSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781640328; x=1782245128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LNw2t8LP5ojoxPDmcRWaKhHWz4MkqZ+bxfoJSWy6tHI=;
        b=Rj2/6xJe2wMBoSVHWWJ6gn3riB33vCMcTdX/kkb4oOgoLaeH4VSW04GU33c1HYiwzn
         ufNqC7rBrOmknJO0OaengR05wkz9L+bD3wBiONLDenPj3uJNX/yusmn9HzbR1hUSMn2Q
         313zIsxBy5zNrT0YdCBLi6MMOINLPXu+RgJsI7HC+x5pR2hcTMM7ilCn4L/0qzmMK2kp
         NbNrrzTGtQ5ZAR4We7cKRLpbVuEw/Xt2zXs3CAKo7kSig7wrrL5p0hYhwsd3JsBIl4bj
         2o20MT5RumzmfshUVDoXPrHoscOfcbTSrSTZbTUL4mknzWGGCKhKW3Cz+mLhPjzFLNT3
         ktVQ==
X-Forwarded-Encrypted: i=1; AFNElJ/IQdSloT+PEF1vERI7CIvhKptHcPIZ4zCZD259dXHAWANdhkMiu+CiX7IH/UCxHVkRPj6J6ccittZcq/4g@vger.kernel.org
X-Gm-Message-State: AOJu0YynJUAH9izRtR0k51QVejhqEfK+xwVqf68djddvS3aXd9TXRCR1
	5r0+z7CHhmMOXx8xN1b8aGx/tRZMv5ZbrbyLIUaV1Mb021FhDi/X3aR3
X-Gm-Gg: Acq92OGmKBYcXtxaz88U2yMzDWZmulqXSFGf1NWQLm6gaYcMch36rC7cPO54VbIQJpk
	CgAzIq2otcZRfrQ7UeJGzuef9BCsO/Pl3q+xGBuEXjULDuYr+CiHOf1L3HHSM9Y6Wp+TKA99n6L
	tRZKwoxJP+6G0t3H6I6iznpqbLTbt1TSS39SfXlDnLxV1/9lfvl7zgNkwubNQYVxz8Zc8sBxFYZ
	0RY6fVxAqbUHoaCKzw6BG0qj6ILQrYWbsuHGf/kB0pI3OZm49Rs5EssPe/LDF5CVbKHlHBfnS6i
	Pw8eJB5ci9Z/SFJtxoMs0B5s3yTyrS31UwvVHA22Wt2tj0p400zm3ZHy7CdhYREYCDhMs4lJ3mV
	5iTNbifbH3SHJzYIOc9J25D+qtQBsH7oe3lEV/0fXvt3wVl/HglyUCUl/SLCu21oIXCH/kCJwva
	y7NkUbRq0DSpUrQQn1kif5Mz8nd/bOGEIorYQTY7g6hOLoSDm6AuKV0s8Xpe6/
X-Received: by 2002:a05:600c:a104:b0:490:b642:ce31 with SMTP id 5b1f17b1804b1-492333bac42mr13452535e9.2.1781640327797;
        Tue, 16 Jun 2026 13:05:27 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa96f0esm111413835e9.12.2026.06.16.13.05.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 13:05:27 -0700 (PDT)
Date: Tue, 16 Jun 2026 21:05:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: jkoolstra@xs4all.nl, brauner@kernel.org, broonie@kernel.org,
 cyphar@cyphar.com, linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1
 << n) for O_ flags
Message-ID: <20260616210525.1458974d@pumpkin>
In-Reply-To: <20260616102250.3652779-1-geert+renesas@glider.be>
References: <20260604222405.5382-1-jkoolstra@xs4all.nl>
	<20260616102250.3652779-1-geert+renesas@glider.be>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Jun 2026 12:22:50 +0200
Geert Uytterhoeven <geert+renesas@glider.be> wrote:

> 	Hi Jori,
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

I'm not 100% that changing these uapi constants might not generate compile
error for userspace that has duplicate definitions that are currently fine
because the definitions exactly match.

	David

> 
> And suddenly all these constants became signed? Can't that cause subtle
> issues, especially for uapi headers?
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
> 

