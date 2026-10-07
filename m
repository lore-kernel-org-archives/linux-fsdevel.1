Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84D533E355
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 02:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791339914; cv=none; b=nNBv53JMSBlw7JdSFzEOEiWs3si1wnD/txX4Fuj+k0YkvjKU0I+9Rq+eJ5QDFMTfpxZsxpBnGG/39LopxrGzVnwZZB0rD2tY+g9kDSJszG+A85iaCF7frpt0JGdqHb9Cn6aOLpJ0bf7ESuLYVmb+Rp/L+5LEWpipc2X9HDzuuHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791339914; c=relaxed/simple;
	bh=AE3DANbJ/Lt5SPRwcmEoqdNOCeXShWVnJgp3uWxoxig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jJjJu1pJoR9ltH0FExT7HOQMyExaP3Mq0j4fruk3ji70hbkwge0sr5Mq63RXlNWny3eYit0+1eQuVus568DNVrx8ZtCcL3LT+d5zbi8owFzocYHdKQSjC0x/wcb7v6PG4VEUtryPVmro7ISZIpDb+OKZAiCg1XVe6SJU9U0FthA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hy3+nb/V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hy3+nb/V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C5D1F008A2
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Oct 2026 02:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791339913;
	bh=KS/oKwc4/tHrIqXOyK1jCnbU150fQ26jUklE/3Lgg4s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Hy3+nb/VNFG+LeC1JS2f7XZGuv8xOqIvmtr9UEq4sZNm4BtkYfMJjctkUKuwGDmbN
	 fKk5uxP0PZqAeYIW647u6exf1R0gdD9Uu5V1PkL4HXfblCzUdp42p7JLr9k/trkZ0P
	 F8qU5YIGozBptMvCvu75Q2rP7w9PM3U5UDoSqYtxbxHAID42QSgNtLzVDCEuj1G4cT
	 epskTzJhEAckjM1n0GY6V3iLZP0xCG31hJOKA49DFzL0CRLAeHH3slfdlGsi8CiMqc
	 3wClSby9RFuZ/2B4wRl9ppecEeyedwBue/V5AtAA6FT0xhjo2i5OxazkJU1DaRU1ij
	 J+6FicNyllZFg==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2e2007dd8bso198455566b.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Oct 2026 19:25:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzv7UKq2kmpBtlnxJjgSaZdqcu7twxqklBwCJs2e4R74b9vphVC1Qr3YEc9Fkb/dsHiurVchbNOdky03SIs@vger.kernel.org
X-Gm-Message-State: AFq9FYKgti4Tv5FbDTZagwxg17qnl015kR4/opqach9TFkW8Aoydxo/H
	B1/T+YI7qsfATUZFnMcYgj+BBGS0gyHErYSwUN9Ob/E1nIx2kWPzdxzGALHS13AC8pgyw13Il1n
	WJL3/KAMoVnOCyfgCx823hUov4JSKsCQ=
X-Received: by 2002:a17:907:3d4d:b0:c29:6136:9f66 with SMTP id
 a640c23a62f3a-c317bd4c29emr74585366b.14.1791339911958; Tue, 06 Oct 2026
 19:25:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006224024.14535-1-linkinjeon@kernel.org> <20261006224024.14535-2-linkinjeon@kernel.org>
 <CAMrLSE6=2pRW7oQ40NME-vCpP+kdmB-D=kNWTDMY4xVdwGzeyA@mail.gmail.com>
In-Reply-To: <CAMrLSE6=2pRW7oQ40NME-vCpP+kdmB-D=kNWTDMY4xVdwGzeyA@mail.gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 7 Oct 2026 11:24:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-Rfdd+zU3sBvx-pJotiYj=BbAdVGFuJypYYZe0N8Askw@mail.gmail.com>
X-Gm-Features: AclHuK-bloyjpNfLoj2McHACwe9nBJBROYSqdcRi3p4WzXN2yqfuFdJqMnrpTds
Message-ID: <CAKYAXd-Rfdd+zU3sBvx-pJotiYj=BbAdVGFuJypYYZe0N8Askw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ntfs: add named stream ioctls support
To: CharSyam <charsyam@gmail.com>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sebastian.n.feld@gmail.com, 
	cedric.blancher@gmail.com, Lionelcons1972@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 11:07=E2=80=AFAM CharSyam <charsyam@gmail.com> wrote=
:
>
> Hi Namjae,
>
> I found an error-reporting issue in NTFS_IOC_STREAM_READ. The underlying
> bug predates this patch: ntfs_inode_attr_pread() breaks when
> read_mapping_folio() fails without saving PTR_ERR(folio). It therefore
> returns the number of bytes read before the error. The new ioctl treats
> that nonnegative result as success and reports it in bytes_returned.
>
> An I/O error on the first 4 KiB can appear as a successful zero-byte
> read; an error on the second 4 KiB can appear as a successful 4 KiB
> read. A caller copying or backing up the stream may interpret either
> result as EOF and stop, even though the stream is larger. The on-disk
> stream size is unchanged.
>
> I tested this in QEMU with a 16 MiB named stream filled with 'A' and
> an 8 KiB read at offset 0. Using blkdebug to inject EIO on the first
> 4 KiB, the ioctl returned success with bytes_returned=3D0. Injecting EIO
> on the second 4 KiB returned success with bytes_returned=3D4096. After
> the change below, both cases return -EIO and copy no stream data to
> userspace. A retry without the injected fault reads all 8192 bytes.
> A read crossing the actual EOF still succeeds with a short count of
> 4096 bytes.
>
> Please propagate the folio error, including when earlier pages in the
> same request were read:
>
>         folio =3D read_mapping_folio(mapping, index, NULL);
>         if (IS_ERR(folio)) {
>                 err =3D PTR_ERR(folio);
>                 break;
>         }
>
> The existing `return err ? (s64)err : total;` then returns the error.
> The ioctl already copies its temporary kernel buffer to userspace only
> on success, so it will not expose partial data on this failure. The
> UAPI should also state that a successful short read indicates EOF and
> that a read error copies no stream data.
Okay, I will fix it in v3.
Thanks for the review!
