Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D49F25A2C9
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 13:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865370; cv=pass; b=cfgSOrD/cJdfJKlNYxeL8rBMPa0aPFnbeu05lEm/fnW3LR3Vv8q/IwMtuBic/nyKCy8rLkn0TDRYs9rb+W1Qvozx1wSIZMO6/ZCFr8UUEN9poNfTWgET/B7QMT1uA5XBZHccFfpDisHu2YMCO9ydegzmsy6Jzdq1RhofSTL+jRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865370; c=relaxed/simple;
	bh=Hx02j8F7guSUuRESHTno0SkBkk/CCcobffe9g3YHI2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NAJ0Royv8Q6vx0kTIcXlLk/nwMdA98Xi9uHsY0wDLtQtgqMYsbtBmCWVFx6WcOcNMuDzyR5/8rco/M299TJWsVsZsTGXzqPt/sujZU5YrprOEQo2EGI6lZsI4Gd+BQXKacleTlawM629fPDhsg+QN34LnGbq2cZ/1FJhCaHe0mI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r4KAqtv5; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r4KAqtv5"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b936331786dso707059466b.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 06:42:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776865365; cv=none;
        d=google.com; s=arc-20240605;
        b=V/hADuOdlHEzhpYwmIhrRxoBqlTmoTO7VmmnD2ykX6EdzHVzxCi69m8xxvcLzxElmq
         1G2SpvxszBXtvALbSfYkIsVtrrVU6raCcIuUZiY0/kU4qPV8GUox5/akhAQbiBLCTeoz
         eFxH8od0J2f9OSKDqa607psIFswhwY05mcYWatnjZuoA4W788cx+9/eGJFIH+RKTMjTW
         CqsrhbUz28m5RKdq8U/4ds9jXnwJMMj8s4zi7Lo5r2lRTRA5jNfgdfhovWQmV2GIwaq8
         IfCeLBRXcqxPY/h60bdDqNik0dP76H24KFBTFqq5y537pTPCBKoYjchFSYHW80F/ztFx
         Lk2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Hx02j8F7guSUuRESHTno0SkBkk/CCcobffe9g3YHI2E=;
        fh=G1RspYrjNucxXdG/v4/bgIvrIO0CiG+f7AnNBN8l3q0=;
        b=AKL7Z46UuvE/YFmR+5uz7Ho13mmBFEswFjzzbvjjiNe9oWoJ0ZnL1nuc3dvZoCL7H0
         AFEGjE+Nl8JzRREyrEr50s+36XksOYBgkZWb7cT0TT+UT0B0rFoBYunGhkwTJUmGnNID
         ULEegg7UzuD0StV9aCqZ2Hv/VP0nmftWurD2uGoehkDj9LnQp1t54WmbRGWwp9U1+6bh
         D8La3tm7SWRxGZsLvrOU5XwIWfO7oRcIX3cizTMb7IOAs4EHevqwxjWA9iDix1fTwwOU
         rxnLEQxZFSrqwlqxFuIFg27TNp5+kckGib0N61Y9K3400DuhgaYWd1b/OAlbFZMseEj1
         Zt8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776865365; x=1777470165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hx02j8F7guSUuRESHTno0SkBkk/CCcobffe9g3YHI2E=;
        b=r4KAqtv5mR6G92ifCcCSj769JlooNcJaAB4wJl6EtXXeGGTNCkyLxUHvnLAPspyseL
         XOr5jK5EEulWE5wKTNeSlmzhq8c6DRGQDbN+qm6VK36tgo3L0GzBsEa2FlkD0aQJ2vrr
         6YnUjM+sNmgwJyyccxbkYJZbmwMZGnT2vMLJ9/HAge/tN7Ryon9yUHyt4Hw432aFykg/
         6nc3X0iiGFX2TtLGYw4B0QzqNfwQ2xvAZkIoVV5yCSNqBZhTV/52J5BE+V7mEuJaCtWL
         x16KXgLlK/5/riVaiEsxYG252lMkf0CaHQ7tsZGzIp8Su6mYJ20r0V5mag7Av6AcnjAk
         qaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776865365; x=1777470165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Hx02j8F7guSUuRESHTno0SkBkk/CCcobffe9g3YHI2E=;
        b=NuAozAyMpFPNvrj9n/SjGGwbOrdK8GkL1x2rXCihfxtDxLq8J3z2PiBdcNBw+qGcbV
         UxnBml+vm5pFj54TGQUIS2sKwmAXy9dJ+2fv3AyNiKJYoq6ubDUxL0ectqKg1Jmt4l+x
         ZzKwJKLElW6xskJgPOaVG1xIrwoZUw26VO+A7P2FCc2nDBcKuxJ8yP/8ydWXnxCGY8Sa
         2tL1P7990gtF9iNlmNMAenbxol7EW1Qe1F/0+e9jVvKLG0pJ+fiAU64FWUsqDoQRpkHF
         WwO6V2fTB91EwYDpf6w8t5iANzTcwhXiNK1L9qmazfK/NZEk586wue38fKUhhqysO1j5
         Xe2w==
X-Forwarded-Encrypted: i=1; AFNElJ+fenSaBVUTQ57HGamWtle8Gn2RLyN1eRZ4E5MhsIuyonHIu6Uzbs0JRWyFlNBS2gxp9kT7plvWL/G0DdTx@vger.kernel.org
X-Gm-Message-State: AOJu0YxH/ooK6kipMsCeii8UX3TJZIARUnksDDz3br0GmHzYvsmYFOn2
	U5Cnz/iamxFdwWPKYpdCEAFs62PF9/U1/PAYE9NiMqP+bENK4xi0eX+SOuDDF2dbBfJOHWmfXHH
	IgfrX8iORyErZu5REOhPb5UA0tcrGPKQ=
X-Gm-Gg: AeBDietpvjrRNgMaDmpUmyNvkxLesAZT5/6VlHW0zS0pLZOxmYBaGpCa0gDwJUeO5C3
	PhB1/24kJk1nx4aMZC+C1AVjRFlMWAf4i5TQ1BzkXZCbAcFUc9U1ZkMQsXhksnTIqWDpMCXPP0z
	TN7pwLNHbU7QTlEEOLSzV3GNnxOAnsHuhYl3OzP2ydAqrZ5yQoBo9dXaZy0+qJcWi4PdCm6E/6c
	yykAbm5Cwm0m7+xDETnGxV/OS2VdX9z0pAu3Ctrc+weRbCeVymuxWTTf/CmZSo/9wtygGmKQ2At
	nbHoMbLli2tz6az4jwQV6XThY/otRgf1AWSq2KX5vheWJATofhE=
X-Received: by 2002:a17:907:a603:b0:ba3:e9be:f77e with SMTP id
 a640c23a62f3a-ba41ac04100mr1102594666b.38.1776865364142; Wed, 22 Apr 2026
 06:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1270238484.1040011.1776859746395@kpc.webmail.kpnmail.nl>
 <20260422-unzeit-gepachtet-8632ca58584d@brauner> <1810988015.1048487.1776863431462@kpc.webmail.kpnmail.nl>
In-Reply-To: <1810988015.1048487.1776863431462@kpc.webmail.kpnmail.nl>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 22 Apr 2026 15:42:31 +0200
X-Gm-Features: AQROBzDEj7iPlTgBI_OKOzxVEOwyTYZYTUYH9mjCjQBAJtCw4mmxkBzkJUPsdgg
Message-ID: <CAOQ4uxg9vvBpmF6in2orYxc-8NFNFf55PP2j4_UC9vWYKaUzHg@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Filesystem breakout sessions
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, lsf-pc <lsf-pc@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 3:10=E2=80=AFPM Jori Koolstra <jkoolstra@xs4all.nl>=
 wrote:
>
>

Jori,

Thanks for raising this subject.
Very hard problem and a very important one to discuss at LSFMM.
It is already on the agenda.

> > Op 22-04-2026 14:34 CEST schreef Christian Brauner <brauner@kernel.org>=
:
> >
> > > 2) If so, do we want to maintain them in-tree?
> >
> > No. Then we're back to square one.
> >
>
> Really? FUSE and libfuse need to have a stable user API anyway.
> They can't just deprecate stuff and remove support, whereas we would
> like that for internal filesystem API.
>

I see what you mean.
Converting to fuse is not a magic solution
It is a retirement plan.
You can think of fusifying an old filesystem as a more graceful deprecation=
.

Like with deprecated filesystems (e.g. reiserfs), the kernel would
first issue a deprecating warning and urge users to install the
fuse alternative.

After the grace period, the kernel filesystem will be removed.

> >
> > It falls onto the VFS maintainers and we pick up bugfixes but don't
> > actively spend time on deprecated filesystems ourselves. We port them t=
o
> > new APIs where it's required but otherwise they bitrot - that's the
> > reality. Ultimately they will be removed as we did with things such as
> > reiserfs.
>
> Do we have a list of filesystems that we do not need new maintainers for
> and let just bitrot?

We do not maintain a list, but see this message from Jan linked from
my doc patch:

https://lore.kernel.org/linux-fsdevel/yndtg2jbj55fzd2kkhsmel4pp5ll5xfvfiaqh=
24tdct3jiqosd@jzbfzf3rrxrd/

"...filesystems like (random selection) bfs, adfs, vboxfs, minix, efs,
freevxfs, etc.
The user base of these is very small, testing is minimal if possible at all=
,
and thus the value of keeping these in the kernel vs the effort they add to
infrastructure changes (like folio conversions, iomap conversion, ...)
is not very favorable.

For these the biggest problem IMO is actually finding someone willing to
invest into doing (and testing) the conversion. I don't think there are
severe technical obstacles for most of them."

Thanks,
Amir.
