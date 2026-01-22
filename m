Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE1238E5F8
	for <linux-fsdevel@vger.kernel.org>; Thu, 22 Jan 2026 02:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769049869; cv=pass; b=focaQQM9jqazzZbb1rr34BiN7WHKsqubu5KxWTu97psw5joqMCfcn634s/axuBH9i+l/imQmz6FVwPI7iuf5n8ns8/NNMMuEtBcpnj8N4tbtEs3dmCMbtt1GljqTdTqdGdmKIyosgZ8EvVmHXNwttpcmmYJrYuhqhVm3YgiNWX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769049869; c=relaxed/simple;
	bh=UR97j5oS5KW66h4wusIQPc7uR0tPcNE6widZpyUVWkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SgBgi/t/jKMvw5BE4f4gP8nkkuwBThfw4S+Yo0RUuo1bAeF5Utqmi8cK1lZrn6v3TCgCwfNMw4NtLaNFqVIE2scpU6bXhZpSmxl+y+K5Srdi/WzkhAaTBlsA7DLDv4IGHkYUn1xg6b0txTUxM2GOYTgGLUYKK04Cl33FqsaB1cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7Epsi75; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7Epsi75"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-50146fcf927so16631471cf.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 18:44:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769049863; cv=none;
        d=google.com; s=arc-20240605;
        b=UmQM5Yle7fZncz2M+z13P/eklRL51XlYNWCrNoNWFdgWl9xQYPyHZDPO7xAotELtVv
         12ox9h+zogDXxnrIkWStkmdt2Ot3h3Yp0tO/Qhpohu6rvSx9Fs5gLB9mnLCbNfAxls9z
         wHyBZwncPn8Lzeq0P02OCHxFFV1zpCmsjDGZKv9+UhT9J+i5bUaRAEM/pdqQsxUfqlKe
         GypWSViVyD6z4Iou6L4BmhBXQf6PKhGGlE6bfalGQ4s0mcQGbX1AiITzppeM4tcAHFTp
         luwFBW2H8h1Fr8ryDwx0lPiZY7B3N/Z8cAX7V1Ed3Npsng7N3RPUhAAt/y5T/ICnkJjR
         creg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        fh=wO5g9qalLm6/Taqb6Gk3YaM5UgCPr9a/YEhhcsZIImw=;
        b=DooeiSUK/uQTaeOF85IW2gKD1FCoD161e/S3w0rged0UGRs2VuJKNEapAAXg2k2TJC
         Fc4TFTqqOZqFrQ+bBdR3N8/uQGxOiPjmQ5h5wxPvAaa1NYhoNUsZVpa9dfDGJ6zq1ry9
         SSJSdmRHzyvHE++1Htd8kxsEFhsoltXd06aIQNgaX3Dujt3jG6UKxhONLJIKYNUSktYb
         jCalMtesuK5um9ijn9XR/MGvbkJoCxytHhkm/XtlbdCtqNfpolSVuqK6DBanI1RkSWd1
         3xdPl52DH3NNaVUs7l2iPsTXp4MfNgEHCty3l7pOoj6r8Ci67Sgp9b/3Y5/EHx+Mnbas
         NyTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769049863; x=1769654663; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        b=H7Epsi75Rhhe3nOnSKPNhy+aGuyneoCLXvwxkcCaSBJWM3fnwt9ZpqEnBXNSH3kXj2
         bU1A8VXiG6VkfoILDNo91BUSR09z/F/UI1rc5npHSqteJkJBrad/i+1uHDsNPqoK9mqE
         jucFluvAejkTaGTolTPXa0MYtCjeIDisagMfuzYtjo3+/vTsxx45LiE9+H6jm/NMTmzo
         w8KFQecrL/Nr/RODNxytPumaA8QduwKH5oNWk3DJlylLw0uy4A6+Ontha4K+WTFb1T8x
         3PNx+C6kREeQSc1VMfvfA+EzHBUKWjScpb5f8lkIPx6uMF0d77H4JSVx7BHxLZWD7xxQ
         Ig6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769049863; x=1769654663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAtbLcPlbXwcqSlVRBCKJrrca7k4pIWb0vsbKliyQro=;
        b=NfwHqVIC9WV0Z+zCRT2habtwBOHwEbBaUILlCiE75cdVOPqviGpi6b5mbly9FwH5tt
         Do3/3pPlu6lnHp4PW171QfKrk94G5zEcZwG4Sr/J8RnWCKZdvxSvpNZuObyFc7ihS0l+
         TEnVbm1OPCsDsxaVyq9tUkSObgJHAnHBPQIwH1bG7WIolTmPSf8uPzZpxYGD77DOwuD2
         zGU3YTDzgFhWpoUQaZiYh8bCS26dhf6BgF78cdLXWN7JdrlzgKm7wYyjV3ki02hkiMom
         42dtyfSVUmdVEAypgjJkpbFugDjRqnVkZ2OQ/DwCZGFICYeAzVjBBv1CTdY+LFU7XQGB
         lGyw==
X-Forwarded-Encrypted: i=1; AJvYcCUvx0oAB7sIx/46TBdveB0tl8Es4tECulL1+5yeaKyBeMuZobpzitCWtK1fiIuczvutNpCjcqpDxv9FRJaQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3opkcGCzPYUM74/I52yBUoaB73bbz4UkG1d46vG6IGniqwAH8
	elb5/raoENdG85WxX6EGBRTX9lzw/ulfXqbmHZUv6gXF/RQwliAP7xCRqmAon+N8Q+QU911rsx5
	7+EBFL0Lb9XV/vJjbwNWOfVY72B36dkw=
X-Gm-Gg: AZuq6aLz5sxb70SNBAl3WFbP1D+nPJc/L0yozQF96HJ8QFXettb5NHw8SCCNTtrsOtJ
	aPrI7iH1QMxNXtzpR7Iva+9221rkn6Bo0ZR9L7bNSYrfpsFRBBuPNY+gSr+B4RrN45OPIjsDaJH
	+yjVXXv6qIE275WpvHkliggpoP8as/gMirLwxKCA04mlfj9gLCNJClMsjBSOEpWXRlhO56G5yFC
	xv0nwYO2FwXCiDJUWv3dbcvOBDb6M2nxU9XLNsCA0Sai7Unz0QD2aC3V+6dyAlRTrm9zg==
X-Received: by 2002:ac8:7c43:0:b0:4ed:bc0a:88c3 with SMTP id
 d75a77b69052e-502eb5b14b5mr24575241cf.33.1769049863440; Wed, 21 Jan 2026
 18:44:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121064339.206019-1-hch@lst.de> <20260121064339.206019-11-hch@lst.de>
 <20260122004451.GN5945@frogsfrogsfrogs>
In-Reply-To: <20260122004451.GN5945@frogsfrogsfrogs>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 21 Jan 2026 18:44:12 -0800
X-Gm-Features: AZwV_Qg4LxBvht9EBcr0hoT1-gc5FWfx00BC6aQnC2V2vC-gMfVpk6AU_v2RXiM
Message-ID: <CAJnrk1YAbcODi8pkG9XawciDpaHqdbZE+ucji73D_F=Jv1kQXg@mail.gmail.com>
Subject: Re: [PATCH 10/15] iomap: only call into ->submit_read when there is a read_ctx
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	Carlos Maiolino <cem@kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, linux-block@vger.kernel.org, 
	nvdimm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 4:44=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Jan 21, 2026 at 07:43:18AM +0100, Christoph Hellwig wrote:
> > Move the NULL check into the callers to simplify the callees.  Not sure
> > how fuse worked before, given that it was missing the NULL check.

In fuse, ctx->read_ctx is always valid. It gets initialized to point
to a local struct before it calls into
iomap_read_folio()/iomap_readahead()

>
> Let's cc Joanne to find out then...? [done]
>
> --D
>
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/bio.c         | 5 +----
> >  fs/iomap/buffered-io.c | 4 ++--
> >  2 files changed, 3 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
> > index cb60d1facb5a..80bbd328bd3c 100644
> > --- a/fs/iomap/bio.c
> > +++ b/fs/iomap/bio.c
> > @@ -21,10 +21,7 @@ static void iomap_read_end_io(struct bio *bio)
> >  static void iomap_bio_submit_read(const struct iomap_iter *iter,
> >               struct iomap_read_folio_ctx *ctx)
> >  {
> > -     struct bio *bio =3D ctx->read_ctx;
> > -
> > -     if (bio)
> > -             submit_bio(bio);
> > +     submit_bio(ctx->read_ctx);
> >  }
> >
> >  static void iomap_read_alloc_bio(const struct iomap_iter *iter,
> > diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> > index 4a15c6c153c4..6367f7f38f0c 100644
> > --- a/fs/iomap/buffered-io.c
> > +++ b/fs/iomap/buffered-io.c
> > @@ -572,7 +572,7 @@ void iomap_read_folio(const struct iomap_ops *ops,
> >               iter.status =3D iomap_read_folio_iter(&iter, ctx,
> >                               &bytes_submitted);
> >
> > -     if (ctx->ops->submit_read)
> > +     if (ctx->read_ctx && ctx->ops->submit_read)
> >               ctx->ops->submit_read(&iter, ctx);
> >
> >       iomap_read_end(folio, bytes_submitted);
> > @@ -636,7 +636,7 @@ void iomap_readahead(const struct iomap_ops *ops,
> >               iter.status =3D iomap_readahead_iter(&iter, ctx,
> >                                       &cur_bytes_submitted);
> >
> > -     if (ctx->ops->submit_read)
> > +     if (ctx->read_ctx && ctx->ops->submit_read)
> >               ctx->ops->submit_read(&iter, ctx);

I wonder if it makes sense to just have submit_read() take in the void
*read_ctx directly instead of it taking in the entire struct
iomap_read_folio_ctx. afaict, the other fields aren't used/necessary.

This patch as-is makes sense to me though.

Reviewed-by: Joanne Koong <joannelkoong@gmail.com>

Thanks,
Joanne

> >
> >       if (ctx->cur_folio)
> > --
> > 2.47.3
> >
> >
