Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8117BA2
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 17:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773682207; cv=pass; b=SARCbQ32dSKgqqaM4T/W+hHUWPxhOESR2qUYGh+/GXqAOC/psz3x74JG1ZiIRh8xuL+jm4xCAugUN+B65pUhLDYclX3tOMdlRmj4LNOCyR9eXzHQw8g19jBK9bC2fVnjAz/cokev741mGeKM07ox+fDfn2Mjr66UNFFIZjNiu9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773682207; c=relaxed/simple;
	bh=r02u6wuzw2kxByaquwBABsaj1jlNywPpvD+Umd/DXxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXPU3FAX/Iwxyh8BCJqwFvAEZVOWt8YX3AYshq6iwr3mNwm8x/zdBXj00YeAOyA6pNTSgjp6IubA/etvuAFVg1bVxu4jsHN0ZvwQVtNejPlpBEbyYHggPO7vwV/YmfaT+Y069r4L1OIIqMLWlpGyj/C8Qy1eTCV7iXIdMCopl00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4GO0qDa; arc=pass smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4GO0qDa"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43b3d9d0695so1496569f8f.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773682204; cv=none;
        d=google.com; s=arc-20240605;
        b=hfTohm1CPKIDUTglCyCeb33aPtHGxaC6LxJMecaXAuApzWHucb9/Tn6AviO46sYE2S
         7CN+XKLAS5713YJ4vDBbkC9Xme2eJS9W0TtGq784g9OOwHb7GgHXCfGtm5lE8PqbP13e
         sfPzW3CBMtTZsh0JjrI5mUwNlQaSiD9WXvu+J0bjxUHUiedXRdSNwF8sbTdvXUKTHNIu
         xvEuagahHdiDh0DcFj0y0u77A3lHRTkGaAQT09rf0y/u3EH1fxIzzIIYjXvR8a9lVeJ1
         V7sXX7Jdr/HfcQfTB1Dm1BdEwEc5Spo05DIsJ9jSP+f7o1myXO7Kl4VS83DmSGRw2xGr
         1wyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jff72pfTrBsPIbSXaasKJiuYQrkU5dxZ9Qq1Opp8/4M=;
        fh=FRGD7QKdJS1lMN65NlYD1CaYaFMwCGjF0L6nFpdM+fc=;
        b=DmuBZWaKVQa+Vb3F7TV9dJ45sfKCPN6FooNl68blbEcERSe4nRXsBbLMhZqFslrEzT
         WapRGEsJCfYKahzGDkjB3IHksq+CDoi7mI9es1AqRXM1oypEPLOB3wTTk/5UhRlV3GF4
         z9onlV4EiXWNMAX0+D4+G10+qibdxGCgu0zoT0DkzIBUWtxflIrcdMsrsrwS468S8rb+
         dN6tiMoQ1rT8YyYfziK0IMb1wWUD9MUxLoWiz7c9MSVjUJrL3X0/UMBC2CI+wdXuaH3n
         /Nr6f3vEV4OeqGvbADQUUedFopcbPWWA4tMG4epL4pXh9hKbQTuVaYOJXlOPpRI1PBOf
         teVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773682204; x=1774287004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jff72pfTrBsPIbSXaasKJiuYQrkU5dxZ9Qq1Opp8/4M=;
        b=P4GO0qDaISzPFgpXL2QBszcQl9AVOX1vqxEWUjEKoeBsa7OfUkQ9n9pFT1Y/QE9sdl
         OULAFOD/cQVo6EUHEm+3aDGIYdWv1n7I5aB4Je+y0gF39LpbBuYTaqXCgEdBd6+FkJlO
         yE9FW4Ak3PWsVla13brI30soCFPaWB31tfZJ42XHvJ2rTdhHRAc33fRUB18q8Q51uX8d
         ZFzn0NKwfrrl8fvtmLsf1OdrmmI0f4ijvJ3m8DoA9el7fdlHmhjyMiNaaQ5HOO4LSbVh
         B8mgoTcdicQSkupki+6UDmrXTkzgjob8nk+P6KiVybB05BVnbNJyDgP2ioBJ2gNs1GDI
         NlTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773682204; x=1774287004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jff72pfTrBsPIbSXaasKJiuYQrkU5dxZ9Qq1Opp8/4M=;
        b=XZuS19QxD3BgxHBNQaW98u0ii71F7QQrQMSH7aOmXrH3A60uQZO8dU2dPVkl/y3AZI
         3J0TBXq6oOjrc5PwTbtsW/BZzn2ziK624De6nPevI7KCYaCEOCg90GLjAKM/Fs2GDHK3
         ac7J3UVvqjbpqSorOhjrEDy1jyzQ/k6L2iDrit5A0c3Fo/bkzR2qnZMPVPLapwiSeaMx
         gfBPRro5lljuOvhiRdt/++oQcJ/IZDd3EsZ+VH1UBzgTme5qu0GKHysZY5pRYfv56daR
         z2AUEV8tpga8cbJsxO2Yd8Okd7zBYchUHy1OXBAwty6G8UMk2JcY6tXISIvRiQxCmks3
         9hCw==
X-Forwarded-Encrypted: i=1; AJvYcCVQr/yD7dyDrkgLjj+fbL+lWIrwGB2f5DeuvxNtxchvT7GAzM7hpwEo6AOxoCtdEA73d2aG/PVTTFPy6JfY@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj14MZ86tzJmTbo7lEo3+2lE8c0XFbiifs4cumfq8MLNgy4EK4
	p/LIebdskS0suLDozO4/S6lZG2IV2cspnDgOAHqoGa8GMaTbV2PcopoQNB6Q2PDIc1J/5W4akUe
	ltL6JkNM+TOrfTK/b7fqOw1TmLWA8lqcE2aOb
X-Gm-Gg: ATEYQzy28Ld8s+v0K17kbjGAhIQfHSb98nreqr3iRZm9mwEReFFPDQqZF5gXrUiYDJl
	p7pnU8fJBtUzLnrxe9UPqh78tclmaCVNYMHtQyfXkXQSB6jgBhUOKSrmTVATz7Xi+RWRmG8LqKh
	JO5nigJO63Q/M1klRya+WjNB3ToXw02caDEIddILl0jLUUUu/He+ZTr/m3T+gncnsWRN8aEv++O
	QIVq+XiM2RjMVgjUlY4rwwXvrNYbBmzfQmgEuUfIhiuGmHqUSKNAo0Xv0m1Z88bljSxoR3ynrmD
	D181vw==
X-Received: by 2002:a05:6000:40cd:b0:43b:4703:9dd5 with SMTP id
 ffacd0b85a97d-43b4982b42fmr784252f8f.18.1773682204245; Mon, 16 Mar 2026
 10:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
In-Reply-To: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 16 Mar 2026 10:29:52 -0700
X-Gm-Features: AaiRm52uoFMpkjYWak9y6r59dECMlQwPxgVigCdVALGt8qr9wusiXrOifqEs7zs
Message-ID: <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
Subject: Re: [PATCH] fuse: when copying a folio delay the mark dirty until the end
To: Horst Birthelmer <horst@birthelmer.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Bernd Schubert <bernd@bsbernd.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 8:16=E2=80=AFAM Horst Birthelmer <horst@birthelmer.=
com> wrote:
>
> From: Horst Birthelmer <hbirthelmer@ddn.com>
>
> Doing set_page_dirty_lock() for every page is inefficient
> for large folios.
> When copying a folio (and with large folios enabled,
> this can be many pages) we can delay the marking dirty
> and flush_dcache_page() until the whole folio is handled
> and do it once per folio instead of once per page.
>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>
> ---
> Currently when doing a folio copy
> flush_dcache_page(cs->pg) and set_page_dirty_lock(cs->pg)
> are called for every page.
>
> We can do this at the end for the whole folio.

Hi Horst,

I think these are two different entities. cs->pg is the page that
corresponds to the userspace buffer / pipe while the (large) folio
corresponds to the pages in the page cache. flush_dcache_folio(folio)
and flush_dcache_page(cs->pg) are not interchangeable (I don't think
it's likely either that the pages backing the userspace buffer/pipe
are large folios).

Thanks,
Joanne

> ---
>  fs/fuse/dev.c        | 9 +++++++--
>  fs/fuse/fuse_dev_i.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170d4640f0b8f3cae8be1f78944a456..ae96a48f898e883b4e96147f3=
b27398261c5e844 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -855,7 +855,7 @@ void fuse_copy_finish(struct fuse_copy_state *cs)
>                         buf->len =3D PAGE_SIZE - cs->len;
>                 cs->currbuf =3D NULL;
>         } else if (cs->pg) {
> -               if (cs->write) {
> +               if (cs->write && !cs->copy_folio) {
>                         flush_dcache_page(cs->pg);
>                         set_page_dirty_lock(cs->pg);
>                 }
> @@ -1126,6 +1126,7 @@ static int fuse_copy_folio(struct fuse_copy_state *=
cs, struct folio **foliop,
>                         folio_zero_range(folio, 0, size);
>         }
>
> +       cs->copy_folio =3D true;
>         while (count) {
>                 if (cs->write && cs->pipebufs && folio) {
>                         /*
> @@ -1167,8 +1168,12 @@ static int fuse_copy_folio(struct fuse_copy_state =
*cs, struct folio **foliop,
>                 } else
>                         offset +=3D fuse_copy_do(cs, NULL, &count);
>         }
> -       if (folio && !cs->write)
> +       if (folio) {
>                 flush_dcache_folio(folio);
> +               if (cs->write)
> +                       folio_mark_dirty_lock(folio);
> +       }
> +       cs->copy_folio =3D false;
>         return 0;
>  }
>
> diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
> index 134bf44aff0d39ae8d5d47cf1518efcf2f1cfc23..4a433d902266d573ad1c19adb=
dd573440e2a77b2 100644
> --- a/fs/fuse/fuse_dev_i.h
> +++ b/fs/fuse/fuse_dev_i.h
> @@ -33,6 +33,7 @@ struct fuse_copy_state {
>         unsigned int offset;
>         bool write:1;
>         bool move_folios:1;
> +       bool copy_folio:1;
>         bool is_uring:1;
>         struct {
>                 unsigned int copied_sz; /* copied size into the user buff=
er */
>
> ---
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c
> change-id: 20260316-mark-dirty-per-folio-be87b6b4bf56
>
> Best regards,
> --
> Horst Birthelmer <hbirthelmer@ddn.com>
>
