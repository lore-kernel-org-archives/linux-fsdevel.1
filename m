Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE87364953
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 20:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782420386; cv=pass; b=QWy6+XAoJdeUZjE9sOL+xTx2GDHtk390OwMV7di6gmGMOEUj6OfmPSEUZdMzy1aAcI3wSGKMN5FabEB9vx/QnkiAfynQGG5+HjcsO0aJ8jEEkkFUBcDgdMh+yRPGltqidWFzI9AE/EaQkmp2yG9zBcaROdE9m+So1F4RICBVEsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782420386; c=relaxed/simple;
	bh=HaomIJc4u8uV5s3jV8UCaYpd7LDFvMKtwdb2kF5+QTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGDbhToo8/CRC9QJYQXNfuW5JO5d8mAiTSYl73WUobitlTX64+zZDxqODCsSDqE122tsg0Je+gUtUcrnFAYXUE+G6ZAFQfyJu9eUWciCLE+3kAoNyDsIaC9WxrY3Dd0cGic8JMTivagxR6+BrjUHa2Q9UEujf0yENRsj7cdF16o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EiIhvuzg; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EiIhvuzg"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso2039535e9.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 13:46:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782420384; cv=none;
        d=google.com; s=arc-20260327;
        b=F1RFFfi/VZHLtipwWtqFLhUh2esVdNq1p3CzE5fMpw2h/+rHyeq7O1ERTfZyqMDzyV
         4j8ILZ21fKmlCd6n7/i8QaBL+ACD9lWFXBWdSk70zALhskG8A3ua4yGDtJjsZANuetQO
         giW8j+mLWpcsQGscOiPKButBlRK0+cu2q6E4NNwr6iuuEJlYcOiqyEDkbGG+tIw2m+ff
         xED3XB0xuJghCu8dJUxY8kTW9Sk9KDZ2mInoqiUVKYytUqwmIs827V0RQ8n6Xt7WDQWF
         WFxcIKYz4qaleHSFumt28nmpput2Huozk85AToANwpymyx3WOGgbjktdi51g0Rer33VF
         G+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fAXfS4CBZdCJEVQc+BhQ1oRfBye22ZsCLRnQyf7mhxw=;
        fh=4qBMA3ejZQDbfr+rlIZp6IRzPeHyjgeU/qZwWaqRiOk=;
        b=hyVuogfag9XrwkIlGr4NFux46DwT+g5momnL2K5L2WrmE0h42svwpxsgD6zlN1LCyt
         qyw63SF49fkZhKn1DGujRxyvco2q1C3ToEq5EGh9pz2DohOMrwgSvSXzRYbaBX5/5GaJ
         3/XD3CMhVapoc1yVq/P4zGsuKK1IXETLHsObJUwnWMGuA7rhmGkseShcqvtjdUG9BkTH
         LupBPA8BfyjzsdPDXdeyz71OOXyzDyZzzsbJfMf55rvBF31EfPQPx9Ae7Td1yKAXZb3P
         jquz1yChh78NdK8J17J4h0pxKS5EvaFOEdgrAG09ETvD10g08SOfv1nPpcyCCpWViZJx
         RMWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782420384; x=1783025184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fAXfS4CBZdCJEVQc+BhQ1oRfBye22ZsCLRnQyf7mhxw=;
        b=EiIhvuzgxNYirqLKBSo/yH0wjd6874AAp7N6qM7fE6nbqC50ToXn5bwP2FlAGypa9m
         0WWExNGyIvtu4nr1gr/RbPtVS+YotC8/ICcOP7IIw4oXHQH2xzIrim7CQleAMenCkzB8
         a059xWHt/yajq5lQSuFkfEKvga5u7zejCA6/OTohQgdjqeqr0cPtoGm7e1Vjtg/OyGtm
         gcZWcPgmsJslOerTVMO2LgnfBOPsLoE2iq+HxKCeGuGMciiCtnN2mhcqJ4Q6tQ5h6f92
         ZJ/pMSOTvpoO5lAVGtNFfwPX/QvDZE1oENs9SsHc7j6DcaOLhtNfQw2fHOdA+xU/dRBC
         czRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782420384; x=1783025184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fAXfS4CBZdCJEVQc+BhQ1oRfBye22ZsCLRnQyf7mhxw=;
        b=s6WtQr7IhEeyF1whPUk2Bp7VBnyiZQaJ2ghgG34KFLtiJLW8yZlctR6zdLr6lp3riB
         1MYe1+X+Bpp6cVDutFsI4bgmK8OPvxkxGRlFXqcVmfZuHLjv/MspmgnqDDnrrDlmlNOw
         a0gRO4y9Lrp4+Adim02TOWM4xmxHGBYy+kBbkEq9rlIn35BzhEBQQRBC2qgsRNoE17Lp
         L9G6UrzKeri2sP6FgoOexg0r3mTLl8U5XWAjBlwLrF4LSGM9zjRW8+l0QgDdDiaGniY0
         HC8AqyKQ1rARjJZikuQVOlB/5y5YbmgpquWmNr2eKQyN3w6Rr6VT/yXt5fzZP6V9Y438
         EK+Q==
X-Forwarded-Encrypted: i=1; AFNElJ+TfgeS90QsLb+0292blwUJXIpC81yEJAG0XoONrmiH5ww8a16SOQ9TXF9HkWbn1krnJpo8z+Hc+56uXPCF@vger.kernel.org
X-Gm-Message-State: AOJu0YwOp6fTso2SYD7kDoDqY+oBgy4Lu6ln9rkk1dAdr+2/CvyJQCzC
	JMiLA73LTVTbWsWUQJHtdNwiXc1SRvCd1B6CSnVzdN8I7UHmckPWwpjEiZl6Ec+zs1jgxgGw3Uq
	10RxxKT78dhTp7RXUaa+OBPMQKOhL2Quqdm4fozo=
X-Gm-Gg: AfdE7clw/3v4PwlG66Q2Ah0PUYBXKtrgqyA+pwmyh/ho84BcnKy0+K5aTCYXZM4/BPJ
	6bDP3WwuNqXYOmxcLSOzYH8DW9SQe02NBrRfq3T7C+iNuGmt7vBGBRctdlN5QchbOo31ZofFDRN
	uuCplp1qfJ4SoFcA194UalOGyFolmVb3pvfQ/SbDgDzb2U/7dITu7KPaDdl+PS/Tydtrlnq9HwD
	IAf3dKn8czKyTQtdvC9KXrWp5Lgqd+dMyTTV3kwjuL2vOf5T8SXav/kEhPLRKZT1M6iKGDeT4EX
	nKLIY60FExTF1Nxv8HTzH8Ml4RWDezgahhGIgJ/1865FQcEsX7vt
X-Received: by 2002:a05:600c:6215:b0:490:e180:2ed with SMTP id
 5b1f17b1804b1-4926683879fmr52200165e9.4.1782420383858; Thu, 25 Jun 2026
 13:46:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625024723.1611000-1-joannelkoong@gmail.com>
 <20260625024723.1611000-4-joannelkoong@gmail.com> <20260625130052.GB22620@lst.de>
In-Reply-To: <20260625130052.GB22620@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 25 Jun 2026 13:46:12 -0700
X-Gm-Features: AVVi8CfoOIpJ3dhVoByHIMdE8LKxW__DmkmAxVoEMGk8sDBKcpsewrJWmavq_XY
Message-ID: <CAJnrk1Z=o701G_gNFM2MNaQPN9_vFCxfK3FvKSjz6pf1Qwj-YA@mail.gmail.com>
Subject: Re: [RFC PATCH v1 3/3] xfs: example of devirtualizing buffered write
 iomap callbacks
To: Christoph Hellwig <hch@lst.de>
Cc: willy@infradead.org, djwong@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, Fengnan <changfengnan@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 6:00=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Wed, Jun 24, 2026 at 07:47:23PM -0700, Joanne Koong wrote:
> > This is an example of what removing the indirect call would look like.
> > With the inlined iomap_buffered_write_inline() that gets passed
> > xfs_buffered_write_iomap_begin() and xfs_buffered_write_iomap_end() as
> > constant callbacks, the compiler is able to call the callbacks directly
> > and drop the indirect call through struct iomap_ops:
>
> Nice.  Btw, a more critical path would be direct I/O.
>
> Fengnan, maybe you can play around with this series and your direct read
> fast path?
>
> > +     /*
> > +      * Call inlined iomap buffered write and pass constant begin/end
> > +      * function pointers so the compiler can devirtualize them and av=
oid the
> > +      * indirect call through struct iomap_ops.
> > +      */
> > +     iter =3D (struct iomap_iter){
> > +             .inode          =3D inode,
> > +             .pos            =3D iocb->ki_pos,
> > +             .len            =3D iov_iter_count(from),
> > +             .flags          =3D IOMAP_WRITE,
> > +     };
> > +     if (iocb->ki_flags & IOCB_NOWAIT)
> > +             iter.flags |=3D IOMAP_NOWAIT;
> > +     if (iocb->ki_flags & IOCB_DONTCACHE)
> > +             iter.flags |=3D IOMAP_DONTCACHE;
>
> We'll probably want a helper for this initializion boilerplate.
> Or make it part of iomap_buffered_write_inline somehow?
>
> > +     ret =3D iomap_buffered_write_inline(&iter, from,
> > +                     xfs_buffered_write_iomap_begin,
> > +                     xfs_buffered_write_iomap_end,
>
> So we're not even doing the _next scheme here and already get
> results, nice!
>
> > +     if (ret > 0)
> > +             iocb->ki_pos =3D iter.pos;
>
> Similarly here, it would be great if we could somehow avoid
> too much boilerplate.
>

Agreed, I think this can all just be moved into
iomap_buffered_write_inline() and then the call would just be:

  ret =3D iomap_buffered_write_inline(iocb, from,
                xfs_buffered_write_iomap_begin, xfs_buffered_write_iomap_en=
d,
                &xfs_iomap_write_ops, NULL);

I'll clean this up for v2.

Thanks,
Joanne
