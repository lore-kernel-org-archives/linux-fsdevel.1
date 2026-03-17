Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BDE3368B0
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 19:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773776920; cv=pass; b=XqLXl637qT77bNcCmZaVVI7uAseyZsQ6UZVWOswuXgPeBkyjCYNTTd8fQiRQopTFaI3JopzrP2N6YZHDwq6tk1LJg6HaOPKSCTO16TXdwt9MBWD9zci2Gn9IR5+aLjXe5qO0NOSd23MhZHKXc/QobHB2KPcldmqG5W8tnA3aOzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773776920; c=relaxed/simple;
	bh=tZU0I8NjPrmQDRDzzPj63zXau8Iqq4tM/lhoKOJa/lg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SEGLcz79YM54a42HqMY+P7c0Sg2xnQbzSGe7KumLbRldEZx5maBVKLEy1P9k9tzoeYZmjeBSrJpX9HuHZgklzYAYh0iPaWuTgy6ibrucA56VcVp2mBuy1AbPRuTYNZIPbVTbGDx+cdPHR8RsiJut6dJUpWAeTmzSC6oTl2KxpxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bf7OVMUf; arc=pass smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bf7OVMUf"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4327790c4e9so4485614f8f.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 12:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773776917; cv=none;
        d=google.com; s=arc-20240605;
        b=Oo6yhOtQVOXee8c8lD5vZX2vHkXt6k4qnT2yOYblkRCsSOt4fq/rs2fTVSUVGjS4GT
         pI7U+FYH1G5VZgwy3gShMaPo3SBNVgDIS8fCPN/vsfyfwH6hmGcnOKJIuNitaRleg/Gn
         PppdWayRzAiWSoycXGdFoF3lX3XxO+it9Wav8CfO3GnFBGKnYwmgfdc1U0HffF8eB5Bu
         ocLlfiMHiJq6imRXuua1bNSyObD9HMYenr4qv4I8q31fIbbZPSCajCu5ng2GlGvfZLWY
         pjIE3aMVay3vz6hev8DgywgAp0FoaxEdF0MphOsLIQCfastH2N/wqj0SR8eYKUSUSO28
         T2ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P2bR4eFSME9IPa0sX9OnzBihzzNKILnmapoRH++2ebw=;
        fh=h/dfvY/M0fgQSU5sjMaOGS/FGT8IM9WVJs5hcX5Rb08=;
        b=iQNhC2apmNO7z58+1fESTByfy4aN3L663V/FpM3LsXFy2p9XtMuiOBzQHu0K/t4s0i
         svmQzos270KIj9oYL0aZQ9CSOg0+FqZnSxOBHmITtB0Cc5I0aD/BBkXnpApi6J2QmVOA
         FAyl/2WbVcYJHQTEpBlFKzMMSaeOOJcy105DS7eC1V3YkiedM2J0wjSYwuoiVd4bzEvw
         0IuOe/avG8YNN37tzDp0GIv5BO1qTsgV6oA7l7GiwJaBehBAFkbjt+Ad+aG2Tkv9N2Nw
         IIEKbe2SKXPhjWjqsc9ccU9qEha0aiz374ObcZ5TtF170Eff1/Fi4ZQvPZuKtzpcbnwG
         RdWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773776917; x=1774381717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2bR4eFSME9IPa0sX9OnzBihzzNKILnmapoRH++2ebw=;
        b=bf7OVMUfOh/u8du65qfPymOgaPfO1+rUjX3q84aVFZbG6NCfGVqwvJ91c/kqEHlwAc
         UKQjx5j4EMdw8geq2jGz9dfK2TiNt5Laq1MbpJu+BCzbMaDRxAKqoBJ4pzFBlMf789MS
         n2h2cGWCU0ftDlQTZfDzuEVxpcQEfkkuj+TsriyHWYgc3nOugZ3s1K5K4LV2xsbdBFr/
         HJFkqRePU7yWkXyZ8a+oqq8an6Qd3tHc7cbiB0owL8R/3gMc7s5h41JfzMYDnf7Fy03x
         d2WVekm330DT8+2hD/sBgqkLOYnsditT6Fny5pE0V26FD/uKFiVtwn2/OxwG45MYdk/b
         4gkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773776917; x=1774381717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P2bR4eFSME9IPa0sX9OnzBihzzNKILnmapoRH++2ebw=;
        b=jgzHyqdpnBnLG3IPgoUuDGByOxyNmPEWXRA/E90oRDfBlMPkGR+C9t+cmIJu8oRo6+
         TeZYzQpIeuNLXsqlKyf2+aw9zWfmZ4lF3CR8Rn/e7gqfGsj+RTr8xloHOHreN14Nu3AG
         mjQemSRrPBVtZ5UMzq1/SD3bYOEV8yDhZ9IpvF9zENiTPt2ANoYBTIrwLldH/2FEfouP
         qZVpiZZq8Hricgm1aTbXetiqF7HrWCl4u02rB7n8WsUUia1d3vC43v5jRhPp8apcBnKY
         sCnNLmfCIAGRGkA0diGxd5/OjruwL8w/JfZLZNKAn9XTgWip2+KpLbcg17K3Vj0Cuqwo
         qtQA==
X-Gm-Message-State: AOJu0YyLKZvkfdm5AZyFCdBmbgBBOad7cS8MMjgTynji1fpbeRtEp8Xm
	9Ed4ZXAhhA7bhreeyhJwHXgZoVzEnd/byFr/Uu4BHrGLV5JbAmIM0kr0bSzMzaMAJW52oiz2tNa
	PdWNVmorWy2m/5t5zFU8OnxSwD9KgvR2P72Fd
X-Gm-Gg: ATEYQzzovwWsy/wRSSuJL6nYRDYmv3GI9ASb/kB7T3/SXB7KyVwzaIEGt9kuy8rI2Ck
	OsM5JLPpMD50++XjEWiizEEKxN7twkiNod6zJTrL+tJayIqi42tcNWJnGNNLNk5wLsOiSkJomcR
	ILymTey/Id+a4EkH1i+ZE+Gxoy7nptjVBqF1OZhESh6kD6alkqtHU37PsZrv7RIA3uWwIovKfqw
	yeFGp7WRXYwbq0346atGSHHMqBn1OMudpUCMCI9Ejuw4bkRimyHdaC3tC6Ry2egsvMtV6T/dLzB
	JMBm3g==
X-Received: by 2002:a05:6000:26d3:b0:43b:3dcc:8af3 with SMTP id
 ffacd0b85a97d-43b527c5648mr852653f8f.39.1773776917095; Tue, 17 Mar 2026
 12:48:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com> <CAJnrk1a0BLS1+1uf8BqKCZ6+vXdxDHkp3WtjGgz8A4e=sx9C0g@mail.gmail.com>
 <35327273-23ae-4fc7-93b9-03bd4abf631a@wdc.com> <CAJnrk1YSW5m6mHuFX6cMxZHBt2qdc8aEx9B623WGoTyL1cjjBg@mail.gmail.com>
 <CAJnrk1ao_0tp9oe2kisPPgY43YRqrQV=-GHSkgiwx_+WPUPD2Q@mail.gmail.com> <194b3338-ec8c-4894-a03c-ac982170c6a7@wdc.com>
In-Reply-To: <194b3338-ec8c-4894-a03c-ac982170c6a7@wdc.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 17 Mar 2026 12:48:25 -0700
X-Gm-Features: AaiRm510LgPHJTcPR9KI7zoRBCxXT2eFJYs0leqBuCIZqdehaUhxQWfBUEgZ_Mw
Message-ID: <CAJnrk1Zq87m8xwJy4rueOXx=Nz39wBJA+DaY09Qa0WvVVqskXw@mail.gmail.com>
Subject: Re: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 2:35=E2=80=AFAM Johannes Thumshirn
<Johannes.Thumshirn@wdc.com> wrote:
>
> On 3/10/26 10:55 PM, Joanne Koong wrote:
> > On Tue, Mar 10, 2026 at 2:08=E2=80=AFPM Joanne Koong <joannelkoong@gmai=
l.com> wrote:
> >> On Tue, Mar 10, 2026 at 4:44=E2=80=AFAM Johannes Thumshirn
> >> <Johannes.Thumshirn@wdc.com> wrote:
> >>
> >> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> >> index 867e8ac761c8..03a97361570f 100644
> >> --- a/fs/iomap/buffered-io.c
> >> +++ b/fs/iomap/buffered-io.c
> >> @@ -543,7 +543,7 @@ static int iomap_read_folio_iter(struct iomap_iter=
 *iter,
> >>                           * helper, then the helper owns the folio and=
 will end
> >>                           * the read on it.
> >>                           */
> >> -                       if (*bytes_submitted =3D=3D folio_len)
> >> +                       if (*bytes_submitted =3D=3D folio_len || !ifs)
> >>                                  ctx->cur_folio =3D NULL;
> >>                  }
> > it should be this instead:
> >
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 867e8ac761c8..b803f518adaf 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -497,6 +497,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >          loff_t length =3D iomap_length(iter);
> >          struct folio *folio =3D ctx->cur_folio;
> >          size_t folio_len =3D folio_size(folio);
> > +       struct iomap_folio_state *ifs;
> >          size_t poff, plen;
> >          loff_t pos_diff;
> >          int ret;
> > @@ -508,7 +509,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >                  return iomap_iter_advance(iter, length);
> >          }
> >
> > -       ifs_alloc(iter->inode, folio, iter->flags);
> > +       ifs =3D ifs_alloc(iter->inode, folio, iter->flags);
> >
> >          length =3D min_t(loff_t, length, folio_len - offset_in_folio(f=
olio, pos));
> >          while (length) {
> > @@ -543,7 +544,7 @@ static int iomap_read_folio_iter(struct iomap_iter =
*iter,
> >                           * helper, then the helper owns the folio and =
will end
> >                           * the read on it.
> >                           */
> > -                       if (*bytes_submitted =3D=3D folio_len)
> > +                       if (*bytes_submitted =3D=3D folio_len || !ifs)
> >                                  ctx->cur_folio =3D NULL;
> >                  }
> >
> > Thanks,
> > Joanne
> >
> This version is making the test pass again,
>
> Reported-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Tested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
>
> Thanks a lot for this!
>

Thanks for reporting this and testing / helping to debug the issue.
I'll submit the fix for this upstream today.

Thanks,
Joanne
