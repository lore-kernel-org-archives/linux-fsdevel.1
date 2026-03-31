Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25C3280CD5
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774934971; cv=none; b=g+biBXaQ3sXaYW/ZJlU+J4Dhq01+wlMEixZVcwbR1viNjYSj9yCyGVmc9pkqEVDRW2TyZmErIvtdIMjLwAp7JZvUO3Z0gx11XK+kgABw9xmlTf0ttpHqJd4dwMuAR506EZNl/zzOC8oqY92BS904Jc5RF/aoiNnhxa2PepdZ1JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774934971; c=relaxed/simple;
	bh=E8n17bf9CyiMOfkwaxwLMUcE1CYsSWCiXlDrpen1MTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2viRbeto/daE2jvoMhAzjTeTd37hmOnZ1bILkJOH11DAxrGt+OKoIWCPnVZ+dxW0orDvp6V2/IQ5L1nEr0cFt76HTHO4FJU1ufMWecHRAChupgmgbxn2NU0al0wYPV0XwZwLJg5uL7zmDswP3rWJVlc1DaaPZwujCu/nAmWyUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rgjeml1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rgjeml1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6160FC2BCB0
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Mar 2026 05:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774934971;
	bh=E8n17bf9CyiMOfkwaxwLMUcE1CYsSWCiXlDrpen1MTk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Rgjeml1ePgTxAiew5evfpfpWzWHpa/BIBz/VOTCf9+H5F+D3e6IJXEJPy4cGDTVl2
	 9WqRkpLUYYvfGmddj5UAOj0CxmkI3wFJhNnuDm0a5Xgcq92BGbAQe01RH2L4MjK1Fv
	 YXiLTEG4yQhLod52Ww7YOMvSiNtC9w5dKIyDW+80hnsasoYcJHFti4KfWqM/YNmkRW
	 PjkuLc7MV7iJXbtkmOoFapDNm93sY+xyK1Iou+OUzYMApe+5rc3uWu3QD3dScgDdG6
	 7/LEAjSInD8x4sEk+tcc+Z57mu+nSWZZAKu1yjyA1ciLv0uV4NCFUT0WhBWLIBf5QN
	 Bi0WvpUyWe9wA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b93698bb57aso975880866b.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 30 Mar 2026 22:29:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfRmgSsHzvbRQoDU+DaHNqbDGuLSxnv862XflhQiQc+mVYB6L5sx/GvDEuSzxtmGSvYtBILI7b9nCPdPW5@vger.kernel.org
X-Gm-Message-State: AOJu0YwWXRLE+O+ZgLWqGgyzGlctZezt2dLwpDg7i8TKOzgVXHvoqYwE
	Cu7Kgi2+Bsuo7LAGg8fMP6j/NbGWXASKMlvpTdeW7Pxs9mcGQ9byeptw2hIMmFBJfQi+lCKRAZX
	T8ojpnMrcxmUylIjlmOyiQDLwCn+TGUM=
X-Received: by 2002:a17:907:3e24:b0:b97:fec5:eced with SMTP id
 a640c23a62f3a-b9be7d57927mr135304066b.0.1774934969972; Mon, 30 Mar 2026
 22:29:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326115045.9525-1-linkinjeon@kernel.org> <20260326115045.9525-2-linkinjeon@kernel.org>
 <ef4497a2-1129-47b8-ae44-3193899a6fe2@163.com>
In-Reply-To: <ef4497a2-1129-47b8-ae44-3193899a6fe2@163.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 31 Mar 2026 14:29:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9YHdFPowGkFaO-LHRy0UNrMny6RjusaRzgxDFm97gcRg@mail.gmail.com>
X-Gm-Features: AQROBzAGj_EtKRbMwmkvp2ctKDLieSLIA8dI9lSrNUzAbEPQpK_XP_WPcm_LLyM
Message-ID: <CAKYAXd9YHdFPowGkFaO-LHRy0UNrMny6RjusaRzgxDFm97gcRg@mail.gmail.com>
Subject: Re: [PATCH 1/5] exfat: add iomap support
To: Chi Zhiling <chizhiling@163.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, anmuxixixi@gmail.com, dxdt@dev.snart.me, 
	chizhiling@kylinos.cn, hch@lst.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 11:46=E2=80=AFAM Chi Zhiling <chizhiling@163.com> w=
rote:
>
> Hi, Namjae
Hi Chi,
>
> Could you CC my personal email "chizhiling@163.com" when sending v2?
> since my work email can=E2=80=99t receive messages immediately.
Sure.
> > +     mutex_lock(&sbi->s_lock);
> > +     old_valid_size =3D ei->valid_size;
> > +     mutex_unlock(&sbi->s_lock);
>
> I=E2=80=99ve recently been refactoring around this lock :)
Okay.
> > +     cluster_offset =3D EXFAT_CLU_OFFSET(offset, sbi);
> > +     cluster_length =3D EXFAT_CLU_TO_B(num_clusters, sbi);
> > +     if (length > cluster_length - cluster_offset)
> > +             iomap->length =3D cluster_length - cluster_offset;
> > +     else
> > +             iomap->length =3D length;
>
> Using min here would be clearer
Okay.
>
> > +
> > +     iomap->addr =3D exfat_cluster_to_phys(sbi, cluster) + cluster_off=
set;
> > +     if (offset >=3D ei->valid_size)
> > +             iomap->type =3D IOMAP_UNWRITTEN;
> > +     else
> > +             iomap->type =3D IOMAP_MAPPED;
> > +
> > +     if (!(flags & IOMAP_ZERO) && iomap->type =3D=3D IOMAP_MAPPED &&
> > +         iomap->offset < ei->valid_size &&
> > +         iomap->offset + iomap->length > ei->valid_size) {
> > +             iomap->length =3D round_up(ei->valid_size, 1 << inode->i_=
blkbits) -
> > +                     iomap->offset;
>
> Aligning the end of the extent to the block size seems like a good
> option, since iomap can=E2=80=99t handle unaligned cases.
>
> However, If valid_size isn=E2=80=99t block-aligned, then the extent will =
cover
> valid_size, and we should clear the region beyond valid_size, right?
>
> But it seems that reads don=E2=80=99t do this, and they don=E2=80=99t cal=
l
> exfat_iomap_put_folio.
> Have I missed something?
You seem right, I will check it more.
Thanks for your review:)
