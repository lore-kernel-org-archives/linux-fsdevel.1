Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A3D39937B
	for <linux-fsdevel@vger.kernel.org>; Wed, 17 Jun 2026 06:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781678215; cv=none; b=emoZ/ZceK13HefFp2bOHYcOYLFTxRalwN5AKCRoSqdhX1ljDcgz8XbfUyrKiGGTMnFQwDfdWh6CzeluHRJ4VDroJIMiaXcCR9buBPPgtvsbzr2QRXT3g85U1xiqwNc43PUfW7UuAfJ05H6yDNa42rPoGiFcor4Mh0BFZrvPZkS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781678215; c=relaxed/simple;
	bh=YhG5rRPQEXKLsDpwfSe5x+/w7DHVMABOos3kgYchCxk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjya8qeYmqEalJKGKDMquAxHiWZOHe71PwMzcGpLq1WXz6DxqrYVO/ghNzx61KQtRrUmr7IqThG/A7pz6SCWF9ehMwhOELzrjs16vR9MD9oHcrMe+lVApsEJJljV7KA/DGgebjoEnLD3a4trDIkCxFMHSOi3IXwE018nR0ZzbSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-59b074ec7ceso2505322e0c.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 23:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781678213; x=1782283013;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVyPbuY3vmImepQSZpAyv681Vu6cq1jbpl9gx5kv5Yw=;
        b=YiACJNRm8zVM4pRmz/EA3NHmJYcYvE3IU2HAZRZ9IOEAAiMInThnnwx5qFPtnfss+m
         1PUnPrTPiE0upVvzWmGJdE6C55yvuzNov1Hs3Eod3Lb3+ATRg2I5DLkvyC2n5lXsxqjL
         D6p+x2fRzHderw5tLenV3Szg8wBRtYlI+I/aS577n8VQ5H8W7YN8hhzxQm8/XaWtb1Bx
         E73p5Nv7qalRRlOWJC9VsEh4c2NuTmeet2CataO40Q4WL8CNrVmww0DUVIM68he+kyKs
         tSkcsky6TLMmzFwW0RrJYnrBrwUjrxiDUyFtuZsR8ZrEjkHwL8wqZTXxyLlwmJTC9NLG
         qfIw==
X-Forwarded-Encrypted: i=1; AFNElJ9hY6Adph/T/MQwhkZEyMdD5hiSKNvqiykvAOkkMrzbOWqzf9WCtuOsLPWiI6cK2psjXzgdbuS+d3rQtWYY@vger.kernel.org
X-Gm-Message-State: AOJu0YwCJ7rw3ULFT39g/UQBnbSW8A4p5zw5vD76uKBN2levdKr87BNE
	88/fWGUzSoJLaYPm4U1MlGuKQbrnentzkjUQnpssQI7VrjBGox9/rga780BeOw0k
X-Gm-Gg: Acq92OGATTGEiiaFPMVko3Cie4yIq6cjGz/R5vqa4oeBHRC1bgsr8bnxd8Szfl+xIB/
	GHPjMA89QXD1NuCZdj6ir4NHbmmun0Upfcf6NOVy5E75/+tNDdaHnk6/SWpxPcC5kWIpLHCldl4
	aW7SYPtoKZa/1gmljY8TPjyB6wyXl4pLgZ7/dD/MZvWCudd4QWrA2DmZB6CJjku3QSNHqKxpGKP
	jjuS5XNkHmIbr+24tDuZA4iJx54YjXxXJVe4muf9O4eNyf8DDVwaObJPNqVm2eHMyYm44HzxHAR
	uO9C4oqQXzxeG8VTshHY5O1kebmApfMSWOeZJDlOP8UaQ2I5bpkTV/gM7dCMQoUHzlZRo/v8+O9
	m+mlf72/aKLUWIWxXrGom78G0wEKlCmsIG1fAvlpzSwIYEj2njG1pcB3L3kwyAwd1/Rs/f1jIW8
	grKx52IkuiXqNpcda6wmY2tiK0CxajNC1otlTisYoJZZ0SP6BX0zy4jjuIGYwU
X-Received: by 2002:a05:6122:54a:b0:5a0:5805:c8ba with SMTP id 71dfb90a1353d-5bbc0d23109mr681391e0c.11.1781678211535;
        Tue, 16 Jun 2026 23:36:51 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bb901b8a45sm7767938e0c.15.2026.06.16.23.36.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jun 2026 23:36:51 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-6c3154fa46dso2615529137.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Jun 2026 23:36:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8mmXV6X5wlETE7osMPIejaXPYbbUTdGc8Dgpdf1zkEmui7bpQ8I/I8jxPok4qp/scBT3aqGPD8h9NFYHCY@vger.kernel.org
X-Received: by 2002:a05:6102:3ec9:b0:6c3:1bcd:31dd with SMTP id
 ada2fe7eead31-7245d31051emr1322860137.6.1781678210864; Tue, 16 Jun 2026
 23:36:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604222405.5382-1-jkoolstra@xs4all.nl> <20260616102250.3652779-1-geert+renesas@glider.be>
 <255283964.1967141.1781621406847@kpc.webmail.kpnmail.nl>
In-Reply-To: <255283964.1967141.1781621406847@kpc.webmail.kpnmail.nl>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Jun 2026 08:36:39 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWxBPDrE3OLytZjfgHOpkdT=pHYx_V9CWZstUgk+RXE8w@mail.gmail.com>
X-Gm-Features: AVVi8CfsQt4DmyYXsifpVFVTVZzCk_BYWpz-taODbOLF8rmJ9F0-ttpXj--aRgc
Message-ID: <CAMuHMdWxBPDrE3OLytZjfgHOpkdT=pHYx_V9CWZstUgk+RXE8w@mail.gmail.com>
Subject: Re: [PATCH] vfs: uapi: retire octal and hex numbers in favor of (1 <<
 n) for O_ flags
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, broonie@kernel.org, cyphar@cyphar.com, 
	linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hoi Jori,

On Tue, 16 Jun 2026 at 16:51, Jori Koolstra <jkoolstra@xs4all.nl> wrote:
> > Op 16-06-2026 12:22 CEST schreef Geert Uytterhoeven <geert+renesas@glider.be>:
> > > A recent build failure[1] exposed the diffculty of working with the
> > > current octal and hex definitions of O_ flags when trying to find a gap
> > > for a new flag. This difficulty is compounded by the fact that O_ flags
> > > may have architectural specific values.
> > >
> > > Replace the hex/octal #defines, which are hard to parse when looking for
> > > free bits, with explicit bit shifts like (1 << 11). Also, add comments
> > > that identify which architectures redefine some of the seemingly free
> > > ("cursed") bits in uapi/asm-generic/fcntl.h. These should not be used to
> > > define new O_ flags (for now, at least).
> > >
> > > The translastion was done with Claude Opus 4.8, and verified with a
> > > (non-AI) gawk script. The accounting of which architectures claim
> > > which bit-gaps in uapi/asm-generic/fcntl.h is also done by hand.
> > >
> > > [1]: https://lore.kernel.org/all/agruPPybCx8q2XcJ@sirena.org.uk/
> > >
> > > Assisted-by: Claude:Opus 4.8
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> >
> > Thanks for your patch, which is now commit 0da79c259ad0554b ("vfs:
> > uapi: retire octal and hex numbers in favor of (1 << n) for O_
> > flags").
> >
> > > --- a/include/uapi/asm-generic/fcntl.h
> > > +++ b/include/uapi/asm-generic/fcntl.h
> > > @@ -15,51 +15,55 @@
> > >   * When introducing new O_* bits, please check its uniqueness in fcntl_init().
> > >   */
> > >
> > > -#define O_ACCMODE  00000003
> > > -#define O_RDONLY   00000000
> > > -#define O_WRONLY   00000001
> > > -#define O_RDWR             00000002
> > > +#define O_ACCMODE  3
> > > +#define O_RDONLY   0
> > > +#define O_WRONLY   (1 << 0)
> > > +#define O_RDWR             (1 << 1)
> >
> > And suddenly all these constants became signed? Can't that cause subtle
> > issues, especially for uapi headers?
>
> Isn't 00000003 already singed? I am by no means a C language expert, but what
> I can find in the C99 standard is:
>
>     The type of an integer constant is the first of the corresponding list in which
>     its value can be represented.
>
> and for octal and hex constants this list starts with "int"

Sorry, I indeed misremembered[1] that hexadecimal and octal constants
are always unsigned.  Instead, they are only unsigned if they no longer
fit in the corresponding signed type.

So "(1 << n)" has the same signedness as the old octal constants,
unless n is 31 (shifting into the sign bit), or n > 31 (needs an
ULL-suffix for 64-bit).  But your patch has no such cases.

[1] https://lore.kernel.org/all/CAHk-=wgcv_YewP0rgwR1+gj3YF-7Jz8WPVzDgndx0DVMVKzV=Q@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
