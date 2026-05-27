Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191D627A462
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779903995; cv=pass; b=Rkr2bpD8wICOK9jucmxpE/Va+lb69knPNRkSiYXa+PHBbu7vBaSPw8b0S09ka/vL+RY6fSktijd7FKdwCxk2rvuzddbvFl1pfjbgLGGNb+IacUkc+R5g0HuGlxVxpP4FFtjnPzhuZXSJj3zjqSgXIclcDV+32AxznF3xbzuADZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779903995; c=relaxed/simple;
	bh=XR4W/++OHzgxJ1Ro/Ym0DhhScRtBbBgvnIqClrFK9Lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g7oPIF6Cv1PX3VM8dd02znVpo3TIuI8aJrbp97ew3Qu2IxCyqfd2RI86DbwOLlHNDUQToGSoAddGSAon8joh2l0ovvlTC3o+8YJkBphnPF/caF44hVijYSeIUk88Nd1dCq/0G++X9kuiddoc3RgeOHfLT5zKiesPDa/Q4Ll0FAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndQOjsX5; arc=pass smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndQOjsX5"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38e97e73234so9593021fa.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779903992; cv=none;
        d=google.com; s=arc-20240605;
        b=SegYeW4pDWEydwvx5thNWF9MGeicA80Dg07i2w8zRnYr6o3U6Sy3a/wXFVgyYe3IqL
         v1aqDeP7mz/1If2/c4Y5C9E8PwZreVcOJ7/6woz6FM9xwktOJOhqvWQFJDc0qodJdgwy
         q09+o5ckSDf2vdeG6YYp7nGB9liKqi9OY6LU1eGbldKa/tuOW19q6hVH2WFP3ZIA4Huk
         x6PuMS6VTOn0xIUrK07/KPXhV0SWVzYAq4Wr4IdMyDQdcX7YTuCgy47wozBPlbWoe9du
         1DcqsmNrAfLEKtarX1UHk4Fz6Azm+Smznp7MBOxGOer1p/cZ/SaM3DjlRHTUmaGR6Wa+
         azfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VfE2G1C+qjhJUVcaQFjp7sQ3IUHnwp36WKLMQ0jJzsE=;
        fh=QC3k88L9FXVvshFtIb3JaRR23s46IPE/+49ubID0AzY=;
        b=KnEEWz358Wts/V50/09Dyay/Qhh3cIp4WaYuXXpzXOBfeUP1T58OAXRtGwveds1JZM
         To4wRzkrVlRl8SLtjKhj2zkg7yLuBSlLP/IS2eBB/pLONYzVGjut8w5fpQ1tOqD7nxFu
         DULJ0pDxk1mp877OlQ2u+XQanD+0ZxVLmMebP9VmiVk5CrKijBI4Zh436aQJEFfyHog1
         QTkTEL8O9vDkFx3AkxN8wrGq0UaD8pUb0YBBcjb5SLQcwf77xWxXKTK0HU2bUWKEr696
         xTxSekNf6qPNfxoIPRZhxcMScsVpEGRIctelGBpreQtOciFZ4bEWQsAYLV4U7DKxRvNI
         leTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779903992; x=1780508792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfE2G1C+qjhJUVcaQFjp7sQ3IUHnwp36WKLMQ0jJzsE=;
        b=ndQOjsX5ZHqonvENjWPugH8OJSEUhcsLZSRCQwsSUvAozXIEV/qbf23/cIIUopeIT/
         vmeeAmDYDssT4xUrPxyqJfLLlJmnNJULOiwYqkmbMZtIzGp950eyGfIOkGJJLvlnVjEL
         lmcbP1g+DZbmgvqINy+jjur0v8OkGZyq02sdZqAeps+E1jRHygQxvDZW/X9Y4G+HYB73
         o27g+fvzBGFwf9c7dvlf3KK5RJlBQ8Gs7eCmf7SEn4Hxl28jc9n0k51/ARm/6PPNVxG5
         BWoKBIxB7K6vAoErvEqDLJ+a8W/OH5qvwk5rA2WQ06GOmO/obZIOIHWWCfZFLJI3JFnF
         XlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779903992; x=1780508792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VfE2G1C+qjhJUVcaQFjp7sQ3IUHnwp36WKLMQ0jJzsE=;
        b=VMp/uZgeiM+Pvmqrruz30nAXKfrR4zY3M/UNynkOQidxM6Mnw26ugeKlBrkUHgBmPV
         BypWiNVz/PKCbDOYN8+M9cEXLePSbRsZ+yYYq6DKpN5sU4GjiBtct5JUNFDiA9dPw7ry
         SXaH9/HghJG/ZqRk2i5LA3QbX0Pdvb+YG4Dffyqm6OyG6DwiD+FFAVOJ5VJk5C8u4VEY
         mNOI+8G4Guix2BlQQlRdERmnucG2trPgLzggc6bLY+00GtsvuzOSUDiD6lP8zsyxQmiB
         k8gApkQen6WMl/psqTNfLtYIS8d3QB32lf0L52LgQO7AwbNB4OBfzmHkd61AhknrzZKA
         p49A==
X-Forwarded-Encrypted: i=1; AFNElJ/YRjyqcUb0Vb/RpRwqOXY03k3TvFFMQcOw+TRQDjlEmPPtbzs5ygtAhwU5Q4vPdWpqsxTYlFg4xtzo5lRz@vger.kernel.org
X-Gm-Message-State: AOJu0YwSZcI8E5nY7UHuws/wpnpfqedgB54pl2mzYquYOvO7HJVEyEyu
	V2WKkPSQfDUWF79JTNYkUnuVOLrouMd1sBmGv1nUB1lt4Y55gpatNuju3Q9rbcVFMHroPer28Ed
	Oo0L+8L7OdxDryR4qUwFaO08ysJJpKF8=
X-Gm-Gg: Acq92OHZvHDtsxodyB1aZhEGM1hp0DSbkr+I1lkxH/BvpLXOZN5JddjBAMufPy20UpP
	cjzyTjRXtMASV+JFtnxlQ8jTUguKP9gV8qCKnMYvJi2fUvZP0CIr0IiTHSIz+UXTkaSL0EnC5Ew
	3XmCSkfgsXgJiWr03dfVRmVUeuM8fqwf1e8sa1yfpFu5Er51P0AABfa3AUfxHIwDOTEhz4KLfVT
	i06a8nLyTN1YWJQCUkgsz9EGx7ACA36eOFlzrSSdwHldEzTcGRZlKljMUATIecPNv2PanAk9flf
	+UG62dia
X-Received: by 2002:a05:6512:388f:b0:5a8:6eb1:2b6d with SMTP id
 2adb3069b0e04-5aa32314263mr5170397e87.9.1779903991981; Wed, 27 May 2026
 10:46:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260525171931.4144395-1-willy@infradead.org> <20260525171931.4144395-30-willy@infradead.org>
 <19e4371075163ffa2168cb0ec934da1911e057d7.camel@ibm.com>
In-Reply-To: <19e4371075163ffa2168cb0ec934da1911e057d7.camel@ibm.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Thu, 28 May 2026 02:46:15 +0900
X-Gm-Features: AVHnY4KZNAmHInimcKr_ZQ-hmiqBOBejcKTpW8nKTepeMYPSX-ClbOEtsiDc-9o
Message-ID: <CAKFNMonfZ+VKyhKSWa6=0+hpKy+HtNmch2LV7KezhAgXAa2oDA@mail.gmail.com>
Subject: Re: [PATCH 29/34] nilfs2: Convert nilfs_mdt_submit_block to bh_submit()
To: "willy@infradead.org" <willy@infradead.org>
Cc: Viacheslav Dubeyko <slava.dubeyko@ibm.com>, "jack@suse.cz" <jack@suse.cz>, 
	"linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>, "brauner@kernel.org" <brauner@kernel.org>, 
	"hch@infradead.org" <hch@infradead.org>, 
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 2:53=E2=80=AFAM Viacheslav Dubeyko wrote:
>
> On Mon, 2026-05-25 at 18:19 +0100, Matthew Wilcox (Oracle) wrote:
> > Avoid an extra indirect function call by using bh_submit() instead of
> > submit_bh().
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > Cc: linux-nilfs@vger.kernel.org
> > ---
> >  fs/nilfs2/mdt.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
> > index 09adb40c65e5..26043db677cd 100644
> > --- a/fs/nilfs2/mdt.c
> > +++ b/fs/nilfs2/mdt.c
> > @@ -148,9 +148,8 @@ nilfs_mdt_submit_block(struct inode *inode, unsigne=
d long blkoff, blk_opf_t opf,
> >       }
> >       map_bh(bh, inode->i_sb, (sector_t)blknum);
> >
> > -     bh->b_end_io =3D end_buffer_read_sync;
> >       get_bh(bh);
> > -     submit_bh(opf, bh);
> > +     bh_submit(bh, opf, bh_end_read);
> >       ret =3D 0;
> >
> >       trace_nilfs2_mdt_submit_block(inode, inode->i_ino, blkoff,
>
> Looks good.
>
> Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
>
> Thanks,
> Slava.

Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>

Thanks,
Ryusuke Konishi
