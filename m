Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD5D347515
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 12:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777466311; cv=pass; b=IbKcCCXvmWMiayorPpnhgXEB4uTKu23BlKi0ibhvEd39jn0rgJgU9qXyKvfIFT7RXpgUtvRZTjNTPFoMOxsKMffjPiRNQSzitkREYpQDnupjhI6cUVPaF64XeIyfUmxgsHuwn9BwsRqLjd49HQRhZCSRPT4NlJF/rPx3sDPqi/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777466311; c=relaxed/simple;
	bh=VjhBgsq15Uhr29mI8KAskfSdJKxjDkwt7+LMJEXOUrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=syN7jSuG5mLIXh3XVU67/TJpujph6PMrQ5Fx0DrKFVn6Xr9YNTlLpmb4DSm+C4R2xOeGrcYW6ySTV6Z2NjlYiTRFLpQyLCivYR9jHaH6XMvMOkSkNiifUmC1BhI0Cl642EgIDZ0qNaD7uhqSQhO3z9j1VGSS+X2GmIKXtNph1vY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BwfzB/ux; arc=pass smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BwfzB/ux"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43d73352cf2so10517088f8f.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 05:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777466309; cv=none;
        d=google.com; s=arc-20240605;
        b=QmkZitlyHbi7WvH8nloZ1V/9hdBqCm2TXpe4YkxeTA/CovNGP8su/Alu0MjahlAqgk
         SEE91kj88ijCbdUw4E/2LrJdAFAqCYHhklKCR9eGxYEXfnzAl6mDeNV/QGWZxdSMENrh
         4+sXk+IV/Qc+khA9pcLVF9QSo7yTVmOaok4HDH+1CZj+1N5s1FkxfmxRNUvV99r6FGId
         7DfFyfTSYEs6zvK1PP0gGLyKTYc5WEK1eBebGyvKam6L5SrLRz6ohCmjcmgQIq1q0Yxn
         2IQJvvUD1st9cRP9wZ7hswbcqc3tKFhE7MmB62PyhjEt9bL45GVvX0tJSceIHaLXbIN2
         iAOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VjhBgsq15Uhr29mI8KAskfSdJKxjDkwt7+LMJEXOUrA=;
        fh=ll6iLcYH0izkTUJZYIxH4gEEiRnS/r75vAuMnAmpwNE=;
        b=kQyIkWVh1XHE4OfMmFWbY46N0ZwE+UNwAw82QAZ2Ef1Pi1DEVdmq5j0IAc9Vq0s/K1
         A2W803u2ODYSx3wO8QJ0n0zgNK9Iryosq71/wHlxHKibLwEVJzoTBtBtZf/in73moKAy
         TMaR6O+ejNT1AIqVE5YDneF0w/5EeGgx0cX2QjcQn3yTBuRimfkaPbn2G7+PFizz9X2G
         uFWDfmwPBkZk/zSOPQ3GO88mKQPkw6eT2IC0wzjR+3OuMKSKL18kjr79bkuwevrtVovQ
         DlZ2SuW2OBSbwyr7oo0+RvGmJc4W2+asTDEBzdU+aJndrdhdH+5f3xIZMWpEltSnCvvZ
         A6cA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777466309; x=1778071109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VjhBgsq15Uhr29mI8KAskfSdJKxjDkwt7+LMJEXOUrA=;
        b=BwfzB/ux3+AFvHgWmpTGOvrd+C9I1tBzmj7rfPXk3QeiBafHIrxz7Bl9sJiEBERZp4
         FAj0Rc9n9kCNKs5kfpKOJY6ZC2WurX70x6wnlAT/FI16GgWYrG6hRcLi8qnana6Yy6z5
         Sr75p+W1va9e66uv2rBlC18FtEr+H1nI0eBXUDoX0MG09rF804ezOgsOTm0sbKDrwwZB
         yQohrAB2hXjdNFovP2br3uuoDl51nlOJjh94iPiJYwungkU9Ezdq1nGoxV1xvaWIDALQ
         W2KQcX7pfGMkET7m/zRlWSa58sray04H+MtFMgUtTB6A9dchLCaAWCJfQwznN0B7mBgh
         1fAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777466309; x=1778071109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VjhBgsq15Uhr29mI8KAskfSdJKxjDkwt7+LMJEXOUrA=;
        b=sGtfy6p0dANWRMTVDxVo6JYJDdoo1duS/W2Ju4Hr1l2xXB7ycrXzQM7oPRobJv/IAR
         /crp5xU85n6g61FfxN4kLWYP2b3KspDNfB4jl9npHvW88ZJCaI4xTPuV2Nc9wectmsZT
         kZRMDMW1QU8WMY1dlDAGsqSsQDb7a2UcXnMFhRvGY9+PpFZ7mnOYohb+RjPIOAYih/rD
         Fj6FIy3JkE6Ixuh+8FDajZG56RL8L24fc3W/xdDzm/E8uOX6euigaFVEBlZ0k9vX3ejO
         AwAZ4Nr0o1dhKSAkkOaFFVL7jSW+bTUAP3lPOgLe+kDW4hVUXBSiyVUZ1aPZbWmU3yfD
         ZPnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+6mAOTglg3Pf+Z/eVFPR6HCQt7AGm6JDFJFLw24unjaChATKe77rQdwLU4kBUjz1EdOp7EvbheiBePPfsK@vger.kernel.org
X-Gm-Message-State: AOJu0YyVTh+1OfA0Ykk/YD/4i0NPNipRNC8Erbj0WFD4iuQlih/gkiUP
	PaIVTEy+zUA5FhnmTtRMoTaV9E/qrc5AETwrFrB37lwBqYVxMVOtmTFwoirhNWbm2qeDylf4R8X
	XrH1TxWkhxYAix0DPzibuJ9SelzJoen8=
X-Gm-Gg: AeBDievmK0zWEZyaOuLuenTZBhrz//Kq0XHu8gFbd/YrEjm2t1ouqGU0M6lLITdfMBp
	gDdBAa1fhSJla21sIinpK8dlMr8TSgJlAoJhT5V3DwUwBV4+oGABP8ZSlTYOI9UEJ66W5dZ40d6
	M1OutNWpLw7Fg2A4MPnM1j6A3mgsDp0H3lYPr1hU9NEyMKtnlhV5tWExZiTwxPkW4pYbTFo29Ja
	i27zKAStRTSOSKoPUJNRL46OK6sMB0vtELqCqsN1eR68TyMBbVczjDXsQQhdSyTL+jM2S46A/bo
	yWwdnHsx/tiifubbcoulZvYGc5RdH0571A==
X-Received: by 2002:a05:6000:186c:b0:43e:a70d:7632 with SMTP id
 ffacd0b85a97d-4464a168496mr13327467f8f.25.1777466308707; Wed, 29 Apr 2026
 05:38:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403035752.20206-1-liwang@kylinos.cn> <20260423110954.2676-1-liwang@kylinos.cn>
 <CAJnrk1Zb=+syR_aOLVs4aXMTOUO7BRBi=MU-20xQOcDpf2iQ5g@mail.gmail.com>
 <1a25fd7d-f122-42b0-91e2-487235263af5@bsbernd.com> <25e00efd-c0ef-446e-a246-6eebd7a68c9d@kylinos.cn>
 <CAJnrk1ZyucU4LMn6UFDAJpmpUJzhzroLTvJnA-hL5SHR5zedMw@mail.gmail.com> <25cfcc60-03c9-4343-9b15-4424e1e419a0@kylinos.cn>
In-Reply-To: <25cfcc60-03c9-4343-9b15-4424e1e419a0@kylinos.cn>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 13:38:12 +0100
X-Gm-Features: AVHnY4KeLOxwnWaoFI862YcC3UAKaiAHvQ4MOLKXReS3lWeSvCaXbBe9Yf1yAb0
Message-ID: <CAJnrk1YBoQoS-RXvGDt86okLidYaKqsnm8G-jZEGEzNdrBu9+A@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: optional FORGET delivery over io_uring
To: Li Wang <liwang@kylinos.cn>
Cc: Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 10:06=E2=80=AFAM Li Wang <liwang@kylinos.cn> wrote:
>
> Hi Joanne,
>
> On 27/04/2026 19:31, Joanne Koong wrote:
> > On Mon, Apr 27, 2026 at 10:56=E2=80=AFAM Li Wang <liwang@kylinos.cn> wr=
ote:
> >>
> >> Hi Bernd and Joanne,
> >>
> >> On 26/04/2026 23:48, Bernd Schubert wrote:
> >>>
> >> Furthermore, in the current implementation, forget and I/O requests ar=
e
> >> dispatched through different paths and handled by different sets of th=
reads.
> >> This means we cannot guarantee their original priority order upon rece=
ption,
> >
> > I don't think ordering matters. forgets are inherently asynchronous
> > and there's no correctness dependency on a forget arriving before or
> > after a read/write request. In the /dev/fuse path ordering isn't
> > preserved either (eg the order they're queued by the kernel is not the
> > order they're delivered to userspace).
> >
>
> Yeah, I agree, and I apologize for the confusion. By 'original',
> I meant the logic used before the io_uring path was introduced =E2=80=94 =
where the
> system prioritized reading FORGET requests into the userspace buffer
> while still maintaining fairness. I wasn't referring to the order in whic=
h
> the system receives those requests.

Gotcha, thanks for clarifying.

>
> That said, I=E2=80=99m curious: since FORGET is asynchronous and doesn't =
require
> a reply, it doesn't seem particularly urgent. Why prioritize it? To preve=
nt
> a large memory footprint for metadata-heavy workloads? Could we be more

As I understand it, yes, forgets are the only way the server has of
knowing it is safe to release resources / clean up state. Luis is
working on lookup handles [1] which will help mitigate how much state
the server needs to keep track of, but without that the server needs
to keep locally stashed info for that inode alive so if future
requests for that nodeid come in, it can serve them.

[1] https://lore.kernel.org/linux-fsdevel/20260225112439.27276-1-luis@igali=
a.com/

> aggressive with delays and only send them in batches once a certain
> threshold is met? Also, if a FORGET request is lost for whatever reason,

I think we could but the current approach seems like a reasonable
balance already. i'm not sure I see the benefit, as it seems like the
right threshold would be different for different workloads. imo this
would add complexity for unclear benefit, but I think it'd be ideal to
keep things as simple as possible.

> what are the consequences? Is it just a matter of causing a memory leak?

If a forget request is lost, the server has to keep maintaining local
state for that inode. on server teardown everything gets cleaned up
normally but while the server is alive it's effectively a memory leak.

Thanks,
Joanne

>
> Thanks,
> Li
>
