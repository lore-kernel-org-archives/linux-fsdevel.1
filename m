Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62A53C4555
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 03:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780629526; cv=pass; b=Y9lpge1zTAwFYTwbKaX37nmmhtIvKBtcL+/SyLLiLCZJBBxhAItptQ83fb7X0jWPaNZjJQdqQEzL1mMQXS1No7eYQDYKuR1fCOqorSiwikKfPlmhIqhaSWpvILv29XmgtL9/eM+8x9QyDc2O/5Hlc49puUlNC2S33wGIJtwDKfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780629526; c=relaxed/simple;
	bh=OsDz30IVBotU+ztKqEia+somcDkw/W3hY//s5nXDJSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwDhQ0QLIqSNbO/w+YhPBCirXCOgpwwUhcJOcyPfOeywNfgvG1w/I4omVW4zZAGt4HZVEhBFDTAMJuw8GvjoOOGHeJKil5pQjDoySRr2JUiBseoJ5fmXRL+oMIj6OJJMSixygbBw8LocInU88gAhH4hjNCUWaKWoN3aiqH8udGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ih54TxU1; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ih54TxU1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7e0fc8ead7eso16701917b3.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 20:18:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780629523; cv=none;
        d=google.com; s=arc-20240605;
        b=fHeFrJ45NJddyHpB8yk98BD9TrL1R6vP9vt4w0nxTBoPE/aPisGCbd27tWg7nN6bXu
         o7hwLZ2+6904w8Hr8hB8y7HwWC2yRSZv0BgmKhK9FVwCqpIILEcA6MJNLDQCCE74MY98
         SK6IJ/GEKcScxxGfybOmZVhkmhCK6ku55Vmaa42onZYDjglsWhRXplp+1P62X6wHMgYM
         aaKkUhIfk0nGxKS5EZivNJFArdb63sycAo3qAcWF7xDWre0jXcANbLmP3M//QNujeZ6P
         cSScOcc03WduleLwzy5M1dFuGCikx2jJkexodwnYxLRNbdNrkktt8MAdHqp2XmUfsgmY
         pCGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tbCXIywKYTx3BFmkQIcoj8h/tJ5wTEDhif9yS68+jwo=;
        fh=4p2uLLYz3VKwt2EpO4GqoAj2IBdx13NJJ4TuD8QErCY=;
        b=T1r9yY/SXeA7nznzJ8Ol7RdbubmVsfq0nrbqRlaecGuLszDbJAoGA6PIACFXhjD+GY
         z22HZJ/AUxvD3kFUzjMnw89qFP1FuNoSTgPtp4VbjFOzTX3ppJzqHKwqS2/6pBUMNwQS
         UW6CZKvmabDaDsR5OalKdh5A9+evG+Y7jpky0zWFXu4yopwBVyQWuzzyvqv7xNcKE/iH
         iJG5z+uR3K9Cd9t9fl5lYW5/ngxWLLGgjGw/VzWIKjtAz9cXPOdZrAxeYTZMS7m55RCe
         PIflDkeSOt9wZU8EnQgauGfMrvkeQtAj39ylYHORXn7k97WwTRM4Q/+auG8dZr0lCWnQ
         Qwug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780629523; x=1781234323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tbCXIywKYTx3BFmkQIcoj8h/tJ5wTEDhif9yS68+jwo=;
        b=ih54TxU17fXzxmaP3tHkE6J4R/GlHQ2Y5JaLIVIXeptzxTTEDPHV5wMhcCBwERj5cJ
         14RE9uS0HDHdETzqDTet55S9gR1e13laVFnaEW7mTQEls/EUMSZuttUbXM1xgpXo1Stz
         Wf0PJ25w/ga+vqE7Z6kDoMPTKE7LoZBZltXvPi8x7jDWEwsguCH8eg3yLOuzLfoRP6Lj
         inLYwaTXlqtg9Qkk+2UhpS/Y16yVUpfQEwGUd889p3xQDUv11VmS/Lip7QaSXev2h86G
         1SBuTfJPn2fS6waCZN4fxOGbCM037zNqtbRzCIYali9wR7mW+AmvfQNY2mXAmOIKNV9O
         M5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780629523; x=1781234323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tbCXIywKYTx3BFmkQIcoj8h/tJ5wTEDhif9yS68+jwo=;
        b=IiSCEV9dwXBhuHaT332fwinHXVCErURsNanpcKz1MAgXZ5Mv7IJVhKb4D+6PbGbNwt
         V+MNEGVgUpuQgckShWomsDXW+tlI9WyPiyi8JtDxMHdp+2qsiJI0mW11DB+FzWjnYIAR
         LWkx+23k84fMimRAkIj+jpyth/3ta1tOGQkO04LK4YOd1Wcw3UT4S5zPmeT4ZdVOvRE3
         MqT0K3zc9LZlsdalwNGvbwipsEbP1GnmIz5dwIpgz2LtcIXpeUML3uMGCzIFu+LDarM4
         QYxU5iEbxeg/yLL4QaEW5nY8bMdtwZWBPYX0n8ZAbERr33IN9xGSP26ZYcbZCm+J5hES
         fSgA==
X-Forwarded-Encrypted: i=1; AFNElJ8Bkc+8Tb5KHJDMOtNjVcMUHx6XTWpePoAsHyj7P4SY6gn1kUaZpQyDKziqqXgCG2jcodCOiV+NJX2wywOG@vger.kernel.org
X-Gm-Message-State: AOJu0YyrWQJaYE7iEOthq/r87rcYjQrQa9Q86xQ+rRkLmh5Z+dGZ2q1N
	srkcSlcNzD4DlfBX00Gk2bDqL2waiXbTmAQxTjRMsLaINmz9dDc/cI2dzsixzybVnda4IgG4BZB
	Wr6V7iQgMwbqLN69WSTwm76q/h2xUeu4=
X-Gm-Gg: Acq92OH3b8TW3AiayS6dcfnCMK/D4t8VlQ+GAMf2lTOLpavS88UyJFZrpuMvRkck5N+
	lv7T/dUNr9cX7Zf4puq4egfF7nAebMLRa662M+wChajXMK032rT6b0V4uPEt1eZnvP0xIPllGvV
	C5xozCzuPwAN0akL8TiaS13MBA409Vqy0i0OUymmAPtpo7dg/gwjYUZalEQ9qCbZDUVJYLXUmVs
	CtwlgUfCgeXSYiJSFOIewJ/KkKWJLTZBvK+hbD0yibXnyru6ytdVJvT4+giPlSgqnkLtyVAYy32
	Qhz7BCRd+gWegOGKPA==
X-Received: by 2002:a05:690c:3582:b0:79a:d2ba:3c24 with SMTP id
 00721157ae682-7ed0e963aedmr17602567b3.41.1780629522685; Thu, 04 Jun 2026
 20:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604202441.65226-1-m32285159@gmail.com> <20260604143040.61f70396c568b7433110fb3d@linux-foundation.org>
 <CAKqfh0Eu=sp3rfAGzhTPcx1Vw5p=sjxTigAWhkzskYrAWB9iWQ@mail.gmail.com> <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
In-Reply-To: <20260604195355.c2446336f3f8cdefabadc697@linux-foundation.org>
From: Maxwell Doose <m32285159@gmail.com>
Date: Thu, 4 Jun 2026 22:16:44 -0500
X-Gm-Features: AVVi8CcS4iq9syKlY_voaAgwsqYAPm0ave75wu9DXjMrNm8AING231fdQ61w-9c
Message-ID: <CAKqfh0GR1EbuxTcuTnUUS34QLiinkD7TPCCEqpd-8oS3S824ow@mail.gmail.com>
Subject: Re: [PATCH] fs: efs: Fix compilation bug and use pr_debug()
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Fabian Frederick <fabf@skynet.be>, open list <linux-kernel@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:53=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Thu, 4 Jun 2026 20:40:30 -0500 Maxwell Doose <m32285159@gmail.com> wro=
te:
>
> > On Thu, Jun 4, 2026 at 4:30=E2=80=AFPM Andrew Morton <akpm@linux-founda=
tion.org> wrote:
> > >
> > > (cc linux-fsdevel)
> > >
> >
> > Whoops, I guess I'm too reliant on --cc-cmd :(
> >
> > > On Thu,  4 Jun 2026 15:24:40 -0500 Maxwell Doose <m32285159@gmail.com=
> wrote:
> > >
> > > > Firstly, the current code uses formatters that are incompatible wit=
h the
> > > > most recent GCC for x86_64. Replace them and explicitly cast the
> > > > formatted variables to their respective forms of long long.
> > >
> > > Please quote the compiler output in the changelog.
> > >
> >
> > It's rather lengthy:
> > fs/efs/file.c: In function =E2=80=98efs_get_block=E2=80=99:
> > fs/efs/file.c:26:35: error: =E2=80=98block=E2=80=99 undeclared (first u=
se in this
> > function); did you mean =E2=80=98iblock=E2=80=99?
>
> Right.  You're evidently the first person who tried to compile this in
> more than 20 years.
>
> How about we just delete it all?  If some future developer wants to
> know block numbers and stuff, they know how to use printk.

That sounds good, I'll get that patch going.

--=20
best regards,
max

ps: I noticed this was listed as an orphan in MAINTAINERS. I'd be
happy to step up and maintain this, I've got a bit of experience
maintaining stuff in iio. Hopefully this isn't too far-fetched!
