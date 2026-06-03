Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7D9389455
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 18:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510225; cv=pass; b=b+ZGch3Jp9FQR9uoNUIwwsZZycsKg/yGYxmXqXnC4wyipWhlZm7APz+HX9vLH+h946LR4J7T0FzuAQeNpUKuIW9YSH18PO+qoIsXYRn0qC4lPSFgHSxyzkzeHL/vD/S9k7lZHeKvTf7gwu85GmXLwga94mgQkAV3XPXTkG+BzN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510225; c=relaxed/simple;
	bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MmBEbdEGE/LyUF15/wbsEtENVKTV78MKdFmKWE5/4CCscvNoitqpL+GXIxn3XYIFc2PIQqMJyUQgZRXTMO5Ru+HVcwbIRk5Fr/DDiwOD2S0b6p6MkIzAHl+q5zDZKEhlHa71HwGH/WRi78caMc7n10Js79FHQkJIPwNwbMozaFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Ycii7cT0; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="Ycii7cT0"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa7a7ad475so1658065e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 11:10:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780510220; cv=none;
        d=google.com; s=arc-20240605;
        b=AAOaCULirvf55cqG5BV7srCfK+prK8sf74OYh24/GVoHHx6K+5pKuYeQOhIP/lhSqW
         9q7Z/N4dzSTsAUor0otEnp1khAGgbNIau+pI7El6xO+7xjQUCAg70STFen9QcOo4inNY
         B1OPNjiEEyUj+pdF26RoXEM7waYSJakzIvYYqRCjs0aw3lEFbnhAvuNAGRkBk87BXlX0
         5xK2pBkWUj5T5GpalQLvlKHbqqwrW+GLK7cIOcsPzBvAJ2TunYFjJ6T2JJolqZHfHRTJ
         C/6XQLqtC/8rKGtPC1kmaYBcW1+DxFNUwlMqeIoHvTntJQeD8Lzk9+qjifCiTgcjNsua
         tCmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        fh=JSmb/6TmvShmJPsqcV5DG6ITDVzzBTOdffI92wZUMvQ=;
        b=ZtSHP8jLP6nFjThPVC3J8zSQOr7JQOD+x53IK+M1Lecwl7L2Ep84gWljlxPOLgwNJJ
         2tBAFAUY6Y66QeC2GcgoGrz/q3/v30yukNmzE9+1msS/oDSAyT5t2J2VSGeivUZjW5dN
         yRa5vYv7RE4g9+kkF+x9TZpkKsVFHKPPOyH9YCDKayNpz6VRXJo6jR/oTlWfBdIY8EAs
         evqX3yLau7jEpXI2TV44JDNW/niI/tnb3TKh66+ISTKjX0fHZlZg+EbHgbW17SBF8OhH
         ljd/kg1Se1rtR9tD+dqhUyLlNurIYVnfjwD70etn1sQPIe9dM5APTeVexMmYd/Yd2axo
         GJ+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780510220; x=1781115020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        b=Ycii7cT0JXbZoT1HegxGgvqaSMKThW4bkvG6TukTUJa8mzOrUCAQZbykUj6hte7pHj
         V5Tpr7d5OOSZ1Xvg/Tb/VCzN3xB1zWnN0XRM5eav+EI12K7sidrRvdKt/muCEahtB5pt
         +FG5pFvtxbd7AdNGJby6pbXRb8ot3BuqBAhZPKLoBILX87RO8EtOO74dehQUXMLayloW
         brJyPG8l0TFxADH6C4EkozCNfKLInRFAAgVV5TesPbAhUryU0++NrA59NPahO4rDy200
         StpKVms/jc6L2u/Rozww7BNqylkR1Uz25oTiAEd2X6TD38LTPETCHMt927slju0MYu0l
         i7nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780510220; x=1781115020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QI5X4GxUbtQqHSEMGf2m2zt26rBr9KAW94estlSgOxQ=;
        b=HnJ+RZvGduH0r3adwi34GFaSXWOl5Ks81fA4Zk8redCJEs4YO/zbebmFO/b5RRfyan
         s3EKyOTknCHtrwzjANr51JO3IcvifJG0yuR4Qm/MgVAZrujeAaHy2yX1Jhw1pqtB8t/T
         UKPDG8tX40/zFKSeIhtllTy4oB22kiFiX/w0g31oNJpQqtt0+rmCGea76lhlk2GH2ceo
         zkJqodJw/OE08Oa7eZTV3o8jPqr06AmA5jejvSkslRaScn9a+37fysHbuFUWpB3RyyBD
         zfaCITPWpunsR5RI7x8log1N3xJWMjzoWhpdTEqLg3U8hIsq2/4ENgbMXrxx3EqftsVp
         umNQ==
X-Forwarded-Encrypted: i=1; AFNElJ/248WglvQWuxR7WZBWkZwnGBmLiCuY4w6DAXDruC1wZTCV3aZ60P+Xru4ZUjsJ7TM4vMPxRZqI8Ph5yjo/@vger.kernel.org
X-Gm-Message-State: AOJu0YyaMobJyLrIR+DtMEALwvPxXCcgkbTR0ZbSsnbN90HWFpRgzjAr
	MOZ0h7ywDSA1Dwod/2Aa+/cHdt76OyCFh7hZBLNqqOhtA7Yz3zdfJVJ944SmC6pNNk5zSP/IgNm
	kC10rk0JRICPxk5qY0I9wsz6VCwaeJbhLErYKLWR0
X-Gm-Gg: Acq92OETRBoNZK2wUW+NlaI6AbTqzuKOOI34jRFLwYPCm1+erk22fKEXjc/F6l7Vvg3
	J93DvvYw+XQp8ILXSfBMOMGvjbNIuP8zo4LmxVLPc9jLE8AEfu/OL6gUXhQawXIhIj6l+JULo1x
	6IvxGaYse5KNFU2qQZ0uC2qh2Lie3OBqSELGphvULvP0DkfRFkQ7Tfg7MK44A5bYEzTy2eeI2jg
	DRATtYigshtmcP9XKvvYPvtM0E4Y48d12SfKICNlvwa1oahemtEvulejv48EG7iZTfO992ZMNM/
	leyIOM2jli7upNvDUOo=
X-Received: by 2002:a05:6512:1316:b0:5aa:6917:da62 with SMTP id
 2adb3069b0e04-5aa7c0feb48mr1695669e87.22.1780510220289; Wed, 03 Jun 2026
 11:10:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com> <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
In-Reply-To: <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 11:10:07 -0700
X-Gm-Features: AVHnY4I8xlGMoYvHWadfAyp7JPxqtCaCokQuJfO8Z8xN2WDEFYt6TSKYy0-h7os
Message-ID: <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> On Jun 2, 2026, at 9:20=E2=80=AFPM, Linus Torvalds <torvalds@linux-founda=
tion.org> wrote:
>
> =EF=BB=BFOn Tue, 2 Jun 2026 at 20:51, Andy Lutomirski <luto@amacapital.ne=
t> wrote:
>>
>> Am I understanding correctly that this will completely break zerocopy
>> sendfile?
>
> Very much, yes.
>
> And it's worth making it very very clear that ABSOLUTELY NONE of the
> recent big security bugs were in splice.
>
> They were all in the networking and crypto code that just didn't deal
> with shared data correctly.
>
> So in that sense, it's a bit sad to discuss castrating splice.
>
> But it's probably still the right thing to at least try.
>
> I've seen very impressive benchmark numbers over the years, but
> they've often smelled more like benchmarketing than actual real work.
>
> There's also a real possibility that a lot of the sendfile / splice
> advantage has little to do with zero-copy, and more to do with the
> cost of mapping and maintaining buffers in user space.
>
> If you are sending file data using plain reads and writes, it's not
> just the "copy from user space to socket data structures".
>
> There's also the cost of populating user space in the first place:
> page faults for mmap made *that* historical copy avoidance basically a
> fairy tale.
>
> And not using mmap means that you have the cost of double caching in
> the kernel _and_ user space etc.
>
> So sendfile() as a concept (whether you use combinations of splice()
> system calls or the sendfile system call itsefl) isn't necessarily
> only about the zero-copy, it's really also about avoiding the user
> space memory management.

So maybe we should make sure that, if we go down the route of
disabling all the splice magic, that we leave an API, maybe the
existing sendfile or maybe something else, that does an optimized copy
from one fd to another and that is at least capable of sending from a
file to the network with at most one CPU-side copy.

Even if we=E2=80=99re just doing that, I continue to find it strange that w=
e
require that a pipe be involved. What=E2=80=99s so special about pipes that=
 we
allow splicing from file to pipe and then pipe to socket (this
requiring that the pipe retain a reference to the file=E2=80=99s page cache
structures to avoid *two* copies), but we can=E2=80=99t splice straight fro=
m
file to socket. Heck, even sendfile is implemented under the hood as a
pair of splices!
