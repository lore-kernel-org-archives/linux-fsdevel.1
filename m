Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5B125776
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 00:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777249136; cv=pass; b=UqPC1j7bJz3LsppZGfazzQubCZFBpHNxz9fBhYb2HN0NhtprKckllNVPYECAhlasB+BLnuSERR/YCc0dV/dIPog+ES3cNsBXhCRMCK1SkEVUgPvsnTLDU0xyOuNzVQbfatw0nzpVKtEoE8tG/+LoG/Ky9JubVbdu/4RpDYWljac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777249136; c=relaxed/simple;
	bh=xwTxbtCfJM8uIKEUDjEeO3vL53GITPmvVDKzPnWdcBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QgFqZ18JCq3Qrz5CRSxy9bWHkcgTasMv9c+AfJoXA2jL1/RleFoCgmSChyZ8Xv91TfzXlRgnzeRmOJLBBpNhRWM7yG2yVD1yzX04D8tGv1p/q2Xxs4ZmogGnXBblsJnj5K2Z4l0xva9Jkcs/QgRJ2QA2jNRR9ATJ4OMYxY0pu84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y4SvY92i; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4SvY92i"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5a2c77c62d7so10281597e87.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 17:18:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777249133; cv=none;
        d=google.com; s=arc-20240605;
        b=Q+6h5HU5E0UrRGDxM/SO/lfgD1Lr7Thq3Xd2nWQe0Amf6PFSMaRf+H9J1NuktNJMih
         oSoDAETD+6FQ7N2nhXVGR72sXjAMNZGIOkXVVsR4iWFn5yKBilj7PDhHViAey5ocjmiC
         w+ION7x0Rf8kGAtmAjmIdbkoz4FDmiomZs5sAM4VGm8jCs7n4nPsROsYz+s9Bdj0hYU+
         DvtbcwbgAe5TgTj6LkYIujGH5yzxCbz6heSK/JH+4n9Lm/GTveIvztcXixhA1L8HdOjI
         2dsVGKShuye6BnpH7nxJ89i3qKKG3/L9ptmD6QKe4MTLRcCqTbIPZL/qNrrhbj+GT5bY
         qAgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xx8r2Q1xe16f1xw6CnBY95tDvnZrCwCMslwUSCLdWNU=;
        fh=a7YyxtV2J1MmAaUKH0vpTOoNaVhRBtGxhZ+dsD9wAyQ=;
        b=MBkCdBjetoJAj9LRmhYLPKlFAI71r/U5HXJlR5WYfEjksDXdaO4LyKd5Y5s++JHHFi
         0ovbvAgSGN6Ls+mjaFr6oKJP307AtoONcDf71eSBDof4q/KZhWpGUQMvA2YbUnz5f8yu
         qOy22K6aEFWFgv/sbJcTB8MLZnduk+3VFfAxjBshTC8QGjXSZt42ecggpCFHx+8qUsOE
         bhC+sj1Ydch5IA61/LP/KKd9kx8GDySoopE5LCHdLeitbSRdBy2EU7maSN5ybvjC1Yr+
         E/t24VHurxAJ0uubK5Tc8fPZapOUgbFF2AJWjEVr+6VqCRPflK9AW8FHWvHPCDwu+PIl
         L0xA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777249133; x=1777853933; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xx8r2Q1xe16f1xw6CnBY95tDvnZrCwCMslwUSCLdWNU=;
        b=Y4SvY92iVyUvsWix3UCHPXkY+plwYAxEr5aNccB4g5KhbsH1tCjZBmv75wmSdAh+Oj
         Tn1S0Wrlm1s1Wi/uEN1MIjhN02xkrdSSRSem4RISJrKD5MhMzV5KfRxKjT4rm+As+DQt
         fwJ8gL8lHO8xuQMoeA+Ygy2XWSJApaieU7UjHsYrpb4iFzTERZEdGw/z+EiakajzLW9A
         WiOUEhhNjquYsSsYDgaQ907Iep+GaC/VkH3Vw4rwYimI6Vt7kxBo3EVFPGG8EzD3tc0A
         RyRMtrIL60wb/FSX8fG3bOv7k71hcfNrrOy3+AffzBTinLDkF0aZreHZz35eV7m8+/5U
         oN5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777249133; x=1777853933;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xx8r2Q1xe16f1xw6CnBY95tDvnZrCwCMslwUSCLdWNU=;
        b=XXepEK2RW2JqHFOx51Guoxx92HLrjx+q2rN7/+z9ig1aXOmBqpEtCkc6Xuru5s0rPN
         GT2ZKh3zN1PjpZNsTO+TZCbWPu0sLdQuXuErQ98R4tt9Ml3hOIvmjSCyLINf5Yq70r78
         gGlBs/9gjuOftK0tSZABWi0tPqGPFHu5zKDj3/Zzr4jOTko7eyNwSz1VuLKXe5GjhTPD
         9E5L2QguQvoCucMIOvlI6uDAmMO11vORNkP4lA3q//v79p7Zr7HYWeuQYV5dwFUbERNB
         jArsffrdlfbQSpigFi9fM0wjyIXrm+v4ANqf1hZPH3wJ6CNiGibMQSWF5m1vbZISYeJo
         eSjQ==
X-Gm-Message-State: AOJu0YwFKoQmQt5Oy6pyiiXNXgJ3stU1gNOivgpgKe3K6YkfuP9IGPYb
	m+MCSAIXea6SMbI3Me42A3pnN8YGpkjCAEfKpplxZoMfWQ01jzZQ04NTpIpwOfz/ugP2EYVB83m
	+6psOs+pkFRvm1bPj1J7FZaUpvktKIgM=
X-Gm-Gg: AeBDietkgxGn05tnJl94XFhQIL5V9fUOOlyau2q8yt3tIG5YH72Q4FJcPnA6ac7sq2P
	HGicXpktJ+M5rHFqS8JqsxY6fu00QtB13+bS1pswsN69lVJQJGHmyrMSC4GLI6tOIi15GrIcV5x
	pz0RWlEVOkIE1SbUkgkD9K48kRgqoM2ef+oHZ82WCH+fSlptVKPfbwWc5Ps4+UaGvJ+ojJ/9hvW
	LL2uiGttXTrrAaHDhYi4y1a+zEuWBkZGfqp77a/JEwr1EPOcjU7kjwd656fwii1X29cuoHVeeO4
	TC4SDM37miEz1WmYdQ==
X-Received: by 2002:a05:6512:3dab:b0:5a3:d2ef:2f9f with SMTP id
 2adb3069b0e04-5a4172da1ddmr13072116e87.20.1777249132325; Sun, 26 Apr 2026
 17:18:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANFS6bY5KfZ34dAw8StDnXkrr59r883ETB2enZr++Ny++B6H=g@mail.gmail.com>
 <20260422094737.194069-1-zhanxusheng@xiaomi.com> <CANFS6bYt4Byg=iqEmVV0ruLKgaBoPHotis-r4=PAwvYwkp8=TQ@mail.gmail.com>
In-Reply-To: <CANFS6bYt4Byg=iqEmVV0ruLKgaBoPHotis-r4=PAwvYwkp8=TQ@mail.gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 27 Apr 2026 09:18:38 +0900
X-Gm-Features: AVHnY4IfCGZn0fz60WB_oIVLPhsd4BNa0n_eWar6dthlsTBZy5px0Yzv_c-fwX8
Message-ID: <CANFS6baCBmm4pigmNpMQLxd5idvVODaJv7oHGVyLuesFi2cddQ@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: fix VCN overflow in ntfs_mapping_pairs_decompress()
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Zhan Xusheng <zhanxusheng@xiaomi.com>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 23=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 8:57, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> 2026=EB=85=84 4=EC=9B=94 22=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 6:47,=
 Zhan Xusheng <zhanxusheng1024@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> > In ntfs_mapping_pairs_decompress(), lowest_vcn is read from
> > on-disk metadata and used as the initial vcn without validation.
> > A malformed value can introduce an invalid (e.g. negative) vcn,
> > corrupting the runlist from the start.
> >
> > Additionally, the accumulation
> >     vcn +=3D deltaxcn
> >
> > does not check for s64 overflow. A crafted mapping pairs array
> > can wrap vcn to a negative value, breaking the monotonically-
> > increasing invariant relied upon by ntfs_rl_vcn_to_lcn() and
> > related helpers.
> >
> > Fix this by validating lowest_vcn and using check_add_overflow()
> > for vcn accumulation.
> >
> > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > ---
> > v2:
> >  - Validate lowest_vcn from on-disk metadata
> >  - Use check_add_overflow() for vcn accumulation
> > ---
> >  fs/ntfs/runlist.c | 19 +++++++++++++++++--
> >  1 file changed, 17 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> > index b213b4976d2b..ee68258ebffb 100644
> > --- a/fs/ntfs/runlist.c
> > +++ b/fs/ntfs/runlist.c
> > @@ -749,6 +749,12 @@ struct runlist_element *ntfs_mapping_pairs_decompr=
ess(const struct ntfs_volume *
> >  #endif
> >         /* Start at vcn =3D lowest_vcn and lcn 0. */
> >         vcn =3D le64_to_cpu(attr->data.non_resident.lowest_vcn);
> > +       /* Validate lowest_vcn from on-disk metadata to ensure it is sa=
ne. */
> > +       if (unlikely(vcn < 0)) {
> > +               ntfs_error(vol->sb, "Invalid lowest_vcn in mapping pair=
s.");
> > +               goto err_out;
> > +       }
>
> How about using overflows_type() ?
> And please include <linux/overflow.h>.

Just a gentle ping.
Please let me know your thoughts.

>
> > +
> >         lcn =3D 0;
> >         /* Get start of the mapping pairs array. */
> >         buf =3D (u8 *)attr +
> > @@ -823,8 +829,17 @@ struct runlist_element *ntfs_mapping_pairs_decompr=
ess(const struct ntfs_volume *
> >                  * element.
> >                  */
> >                 rl[rlpos].length =3D deltaxcn;
> > -               /* Increment the current vcn by the current run length.=
 */
> > -               vcn +=3D deltaxcn;
> > +               /*
> > +                * Increment the current vcn by the current run length.
> > +                * Guard against s64 overflow from a crafted mapping
> > +                * pairs array to preserve the monotonically-increasing
> > +                * vcn invariant.
> > +                */
> > +               if (unlikely(check_add_overflow(vcn, deltaxcn, &vcn))) =
{
> > +                       ntfs_error(vol->sb, "VCN overflow in mapping pa=
irs array.");
> > +                       goto err_out;
> > +               }
> > +
> >                 /*
> >                  * There might be no lcn change at all, as is the case =
for
> >                  * sparse clusters on NTFS 3.0+, in which case we set t=
he lcn
> > --
> > 2.43.0
> >
>
>
> --
> Thanks,
> Hyunchul



--=20
Thanks,
Hyunchul
