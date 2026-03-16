Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E97330D24
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 22:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773698777; cv=pass; b=R4lxAiZvdXCLeHWNs96wqJlP3nKkZGVruiPkk3ioeDJJULHTxaqXtdHF43Q9UG8LipvZSPlRAchJxU0oPZxYM4f/iipEG1GMZOazCyhT7CkZqJkVfeWKGLVDpMrNR6V0tMpQ7HFwUrK6ffY6DnAhRgKrGiYIB5wJgX8dhgaymBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773698777; c=relaxed/simple;
	bh=0Z8kujS9Buhi9Mpliex5pzdCgRluoXOSMknTYfL71Ik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZGI1Voz2lzJEH6e2lnr3uU3qrjUTUhk3v0DLhQQzaJYY37R7W2Z6UVSmSaJDPn6WH1dqRcmykfqkuuuvT11U8b/m9teWLQbDfNOg68g0QaBelQqW1G4xzI5vraKp+9KL8PSwfqJlICqDzOG9kOTKKcnc9POsmzFA0gcxKwJ1sLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LEk8j0ga; arc=pass smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LEk8j0ga"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-43a03cb1df9so5001552f8f.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 15:06:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773698775; cv=none;
        d=google.com; s=arc-20240605;
        b=MZ2Sk+eBWLn7dMd9pc3bpn11E8VrkT+Bigu+9fc0qMl1I4g3IrM8ORfKzq4nwlAcKB
         H1M4lnpdfzxFyEQ4DbWleDYhJaD/SLdrFwNI9Os2t3WXQBvqv8kjeN36vmQHEWmidcQN
         7uG2d/c2H3ylp2vet2dD0zs9I93Y6i8jcKi50RcYe9vRfm8/om/ZODbiE7fAScP4ZueC
         GkjtZHqvv2i9EZMazlQGL4tJn+QmiXX2N5I13MFje+AKFPbrpCdQOZW3N+oA39Eb9OEM
         vjR7tOW9uEUZ8Tb+0ZpKhW2+Gvx/4kIA1MPkA6UMhYFX6MVg5B2YkOdzywX5rWAqfgZz
         rEmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qU7C14CeH1fciNwVpxpFcS1pcvbsagT4oNAGuB9LZXk=;
        fh=o3yXmf7dlC/aEu5CPOtrnoqWvysyNyU4ztxK2gjie8g=;
        b=D0cwzJHp6nmTY9OzaWNMktMMx2Rze9RRfvUqTxx/BIWTZ0vnDc0/wW6mblPzEL0npR
         b3iZQpfePO+ibZ1+ZUHO9CBS6mB17tVzVSDahyW7u+dI1sN5nuAb3QHhczPEtphdnnEL
         MW9FVqsoB9ZswNMgakC19e2kVQTbv9vrFhEVqYBjtBozStMJcwUlUZxtAfdo3Tx8DIeV
         V0gQHytBf73mXG/K4bsJiRNOMDBu2l4q+oLs1RdI/5V9IbR9gFYKbidDB4OS5gp2tklm
         FgcL0iy7jJ0aj8xXvN7Rh44rWn2I+QoJlUVW72iEWvARRkGgZ8T+II4BCWIvQOXCCYgn
         2RlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773698775; x=1774303575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qU7C14CeH1fciNwVpxpFcS1pcvbsagT4oNAGuB9LZXk=;
        b=LEk8j0gauvS/nQBCaaAAvJyn/3NkivTOuUllnuv29lgvW0qxOT6rx+JC+kCePJqzAd
         8ByTU+eH64QhyPqDaoTMFpQRZ4CK/vpRCD/q9Lq9YBqQDQMwES4+3tQBvcns76z1X9Qu
         13pj7xTj1Pwx6c7zK1mLPIVCK0+2TBibk1i1k66gDiGipYMbXT+kB32kSYQc2odes/Ar
         rrvXf6Ps/Y6rUl3Q3P6Evnus74mAYbG7YkoW7f2k4lazdQIH9ZkcFQzh1VrgLEAwwfyV
         bcdmOxrYifcElPYUqIC9J/5IhjRJFnaWLy9fH1q2wltuGAP5aDedf4aXXfqvvM+YuVZG
         YvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773698775; x=1774303575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qU7C14CeH1fciNwVpxpFcS1pcvbsagT4oNAGuB9LZXk=;
        b=VucQiq8R5nZZfYrLW1uIC5VO/uJyNBLYyYgf8yHPg911myl8w09LiMuUkywl2Rzduj
         LmktefYMHppl9hiXIFHug3McqjogIl9YnE8NqBxfOlik4URNTnc5K/K2mx1FWRYXHdLa
         ghZ/RTVpUOId2ifXdbT3msRBB3L59mBEMzlD012wDeZVmieL0LUu3FWT+4VsrsaAtmS0
         3QiO8GybyPcIWMANJVYIfQ/Um7ko7ePmgTmWD91MACroKvDCLa5k4cjJjdVpEWyCdvpo
         NdHi+wsm0/X/M+bkStuxrU9xjTAY9ad3SXmZ2M5ZzOjStY0LQOH13vb+l5Vr38BwGFM7
         Avrg==
X-Forwarded-Encrypted: i=1; AJvYcCX0GOYNQuB69WTVoAEeG9t606YBMQ2rIEFwQPwrivuQdI8oBmcJNmgLNM/6LXmmukY/n3Hhs7fq/hA+PSLk@vger.kernel.org
X-Gm-Message-State: AOJu0YwAqgEsoUF56a3CNYXhS0i+btjL+o+9ZVbIG6uo0c1TuZLpEG/z
	XORI84O4Z1gd8aXN+P9KeSLmrVzTWdZ9aPwP+dYDtkitbXV04Sr764WrBlIrz9/aX7WXSwGGP+5
	iynhmlyq4HUoNE7tivk5ICFDHuddi/E4=
X-Gm-Gg: ATEYQzzXLyPh6O04/UDvcd4otBCwCj5u/EvY+5CWo5EyejFbhlkcw+9TcNBetpvFDqW
	vJxMI0D8C+EFApgsqHx3bxHJGQS0NyZfubdKho6tr5duVytWcdwzm70B6g3tRYDYUjUFitO8o+r
	IknMX3/CpCStb+IbffExsuuiYDnNEiX/fIomngoFhKJXP9QxUPP2g4ekZJZIyoYURw4Cupp6iEw
	S91e38PRJjz0hcpA8s0KSQkNIjdvi3ozK6i+PHnwiMg1UtwElLB9m+FhSq9rIagnhMxq3ULqXyh
	/FQ6Nw==
X-Received: by 2002:a05:6000:2dc6:b0:439:be78:e1e9 with SMTP id
 ffacd0b85a97d-43a04d87bc2mr25354681f8f.14.1773698774395; Mon, 16 Mar 2026
 15:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com> <abhg4tbxDhYO_iHV@fedora.fritz.box>
In-Reply-To: <abhg4tbxDhYO_iHV@fedora.fritz.box>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 15:06:02 -0700
X-Gm-Features: AaiRm53e17JwMIRGLuJU1yerPcc21P0pFKcCsJEIDrZMXRooGe-xVtaRXOwFyBY
Message-ID: <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
Subject: Re: Re: [PATCH] fuse: when copying a folio delay the mark dirty until
 the end
To: Horst Birthelmer <horst@birthelmer.de>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 1:02=E2=80=AFPM Horst Birthelmer <horst@birthelmer.=
de> wrote:
>
> On Mon, Mar 16, 2026 at 10:29:52AM -0700, Joanne Koong wrote:
> > On Mon, Mar 16, 2026 at 8:16=E2=80=AFAM Horst Birthelmer <horst@birthel=
mer.com> wrote:
> > >
> > > From: Horst Birthelmer <hbirthelmer@ddn.com>
> > >
> > > Doing set_page_dirty_lock() for every page is inefficient
> > > for large folios.
> > > When copying a folio (and with large folios enabled,
> > > this can be many pages) we can delay the marking dirty
> > > and flush_dcache_page() until the whole folio is handled
> > > and do it once per folio instead of once per page.
> > >
> > > Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> > > ---
> > > Currently when doing a folio copy
> > > flush_dcache_page(cs->pg) and set_page_dirty_lock(cs->pg)
> > > are called for every page.
> > >
> > > We can do this at the end for the whole folio.
> >
> > Hi Horst,
> >
> > I think these are two different entities. cs->pg is the page that
> > corresponds to the userspace buffer / pipe while the (large) folio
> > corresponds to the pages in the page cache. flush_dcache_folio(folio)
> > and flush_dcache_page(cs->pg) are not interchangeable (I don't think
> > it's likely either that the pages backing the userspace buffer/pipe
> > are large folios).
> >
> > Thanks,
> > Joanne
>
> Hi Joanne,
>
> I feel a bit embarassed ... but you are completely right.
> I was interested in solving this case:
>
>   fuse_uring_args_to_ring() or fuse_uring_args_to_ring_pages()
>     fuse_copy_init(&cs, true, &iter)  =E2=86=90 cs->write =3D TRUE
>     fuse_copy_args(&cs, num_args, args->in_pages, ...)
>       if (args->in_pages)
>         fuse_copy_folios(cs, arg->size, 0)
>           fuse_copy_folio(cs, &ap->folios[i], ...)
>
> when we have large folios

No worries, the naming doesn't make the distinction obvious at all.
For copying out large folios right now, the copy is still page by page
due to extracting 1 userspace buffer page at a time (eg the
iov_iter_get_pages2(... PAGE_SIZE, 1, ...) call in fuse_copy_fill()).
If we pass in a pages array, iov_iter_getpages2 is able to extract
multiple pages at a time and save extra overhead with the GUP setup /
irq save+restore / pagetable walk and the extra req->waitq
locking/unlocking calls, but when I benchmarked it last year I didn't
see any noticeable performance improvements from doing this. The extra
complexity didn't seem worth it. For optimized copying, I think in the
future high-performance servers will mostly just use fuse-over-iouring
zero-copy.

Thanks,
Joanne

>
> But those are not the same.
>
> Thanks,
> Horst
