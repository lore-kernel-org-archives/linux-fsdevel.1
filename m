Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A464470E88
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 19:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784747047; cv=pass; b=bNQBLTzqSbOWdveVz9ibuiQxStofaUDURgqXjgluuJM/Zv439oK5CnzjLUF0T1l7uhZEKWfkzCHTQHgYyhwVBVK0EEJl/BkHlydpeW2pO8wHUEZDToZ1KQHC1StsrctwWoR8DLGBO9sTXquTJ3DppMhhw9iSCCUPNpgxa37QLJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784747047; c=relaxed/simple;
	bh=RjR3jQi2gBsgZVeOwgl8/wj7aZVnQ+rqU4nHfVrQhFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8M1G30eN1WH9h+Ukz4GbAgF2JMJcz62Ln8hKnJf4WR+NK1gyeM+MgLB+8+0ymKeEF6xpVM7pQbf0m9QGtw83ByznjjlyaREJ6B26l4jmCgcPrGyJ+XJH+ZlZ8qWrE6ImPlcrJP6IR7J87V36OdGijGJ7lNXsBtL5lHW1kt7wQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ix/ullMc; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ix/ullMc"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4954d383e64so32259765e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 12:04:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784747044; cv=none;
        d=google.com; s=arc-20260327;
        b=SXf1Vvz7FJhfwY+AxziBAwcEmDQ0JWmG/Rdfq/nriq981BTXGw8NGxw75J3aoe6iXh
         6eC6cIFEL+c8gO/r52xqIKBfP1OWFqsFtekldowXE+0hFOn9LRbQpE50B5VPtfpQbYoL
         Ii96hfXa+KG4//Dg2hi7F/8BrV0SXkiz0yhL1VutjOGYwd2E42i3qxcM3x9yne2PqRPm
         IenG828Dm1ymkNwRQp5hCGmWemtAfbyE+/HVXNN8E/HU/iDGg7KghsyDVmJKcmJW6F8Z
         I25OcY7m/2w+VIXHw0jwhSpEms+d2GJuY4kyBfU+KHzk6+OSNim1+OiIsibSA8IvtAWV
         VGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C2LthnWkKVdjJeBPBoDYS9yBolahYPpf7Sa0W7ibrK4=;
        fh=namkakssf5zKlZKML8BZ0+d7fe4pZkr4wCljw5DLnAo=;
        b=Q21GsAsq2/9bE3hQWZGUGomGc/4tUu+1qtSm9JNZSib2belH/veu2FWhNJPpouv6Cm
         nAEobLNHTJ5WCBG0lcK0dzzFwdbUckgijsmZPIWCEiS2SdhXYTRpky4h0tiGq3G4uYZQ
         8Qe1Hj7z2UTn6jWlHdOFEaj2iwmUAIInQC2PUV3/VI/S1GqR/0S6+0+W4VYBB24GVTB9
         8OqJJKCLy2GyU4PPjsUGSbCX2FobkMTOZFTFCstzF5371/6kC50e3RK/Nv0gs4sDwX/K
         7KJ7Z6FKwPYPjRt+qxBhTVuIXMBuR9l++tHt+BuSAdMcmgM2G1nnSsQUMqh0GuNTS4FP
         i+Yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784747044; x=1785351844; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C2LthnWkKVdjJeBPBoDYS9yBolahYPpf7Sa0W7ibrK4=;
        b=ix/ullMcBoPPWF5e3ADzkZ+IywKoLmDjmefKgC8K00BRAsAajwslVRnKhHQfJwxHV1
         1JUxzvEx9uB8hUf2B1hjs0irEM9F0DiPPBaY0zndY+K9Obv7SrvPX8czdBRy31jrapxH
         78eEVQ32fNVxAdq3ERdTt29gFlUPQsSc4GE156RUSpAwjYtKz9cYbcx2NWLMDIzgYkYO
         YD8pYeAA9u0c3l4s8uHovb3vJiJ1B9WypCtxmRZcT64ooWBw86zoqh7o6okWyNpdDDqu
         3rnGkfbHlr+UWUTl+86Or3aIU0dMPy5rkc/9zeWOoQLXQyOnPnQBJzL1Yg1MQ1LV02hS
         jh8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784747044; x=1785351844;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C2LthnWkKVdjJeBPBoDYS9yBolahYPpf7Sa0W7ibrK4=;
        b=Sc7lkhpy75qbpP5GeIPgJTKdWiHjer92JQmuGukALp8/jH82uvR66dWKd4qn+hjOth
         tDkSaj38/XQOmlzPWK1fYKzjtK7ERxs3IEBiYuMSU8+bWmA16Nsvm0cdchgIzY+Z7qBn
         MmqJs7gxtXzinMA6rntjb9KoUmFI+uQa7E3OyvMrwjkmfPzFhiwGBnGyf2z7BoXBALGR
         6ueztN6/envVoFgf3vtC7AgSZYyfyUtAWovBsN9nInaywTst98Y6lcsudrYWS5zE32Nm
         rx5Tpz+ipSeeHaQng1RgvuzbDYvXPdIdyOu8eLjlr0V3wR1EMOi5z6IDs+CXFwi1Gxul
         /bVg==
X-Forwarded-Encrypted: i=1; AHgh+RqBywmX9IDM3ogp7YRTh4uE/adv6sS/InKGuqYLP5zvJ4h9dsI6LDPNrWCsl+ga1SqqD1651iKnwmRgb6XE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz54oa3U+sw8iCzP/UrdKF6Dx6ZytMsP+CtMZjMoi0103XBDNJw
	EzCxZ/BUdHMqg8PDz0vOPeFxJbGsQkaG27YrMecx5FinJ0uW7erv1CybLnS5AZKz0OlYj7GcHir
	zgxY8sf7oeFMDVc1t+L3P00t/9YZGt5KLR76prRs=
X-Gm-Gg: AR+sD13wFqyGyd2Eu+S7+zWjHNOR7uQoAkkpS9aYi3OOamD8+dvYAhJijMPhRFpv3nB
	o97TPS9jfXyi1lMccWTsWLFh6yksEoHNhUC/wgEsB9/cET4xqULCAo5vOkZaoD4t7ql8nXFW0eB
	yZEAcaeEnLphAfAndIdX0jVmKBM+/NAW7xHj0s+cjpDVx/a5Eyfvr2tcqZnFA4Za+MwWBnnc7wb
	wh/1zYEhSiHDS3DfxnKMk3749yyRcdIfDUlMbh4pBqgzztxxXm5b8pJOsWl4KtyjKbVboOhul+P
	cbnS+X/dQcNmz6OLSat3pLyp1gi9MnAXW/sJhE181A==
X-Received: by 2002:a05:600c:6dd6:b0:493:eed4:7210 with SMTP id
 5b1f17b1804b1-49573cc97c2mr12295e9.11.1784747043588; Wed, 22 Jul 2026
 12:04:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722124931.3159664-1-hch@lst.de> <20260722124931.3159664-3-hch@lst.de>
In-Reply-To: <20260722124931.3159664-3-hch@lst.de>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Jul 2026 12:03:49 -0700
X-Gm-Features: AUfX_mxCN-UiJvZqNWKKnJg-a9PvQboW-uvuAIlNOX_o9tC053nEiX26K1BE1v8
Message-ID: <CAJnrk1a_cc55HcpRAi+H-mqOn7XUt_BxKJTre=Mw=xaE-5A5Rg@mail.gmail.com>
Subject: Re: [PATCH 2/3] iomap: decouple simple direct I/O reads from iomap_dio_rw
To: Christoph Hellwig <hch@lst.de>
Cc: changfengnan@bytedance.com, "Darrick J. Wong" <djwong@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>, Carlos Maiolino <cem@kernel.org>, 
	linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 5:49=E2=80=AFAM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> The pending iomap_iter_next conversion creates performance issues for the
> new simple direct I/O read fast path, because it assumes a model where
> the iterator must be advanced at the end, which the direct I/O read fast
> path tries to avoid.
>
> Side step this by splitting the simple path from iomap_dio_rw, and
> require the file systems to call into it explicitly, and pass only a
> ->begin callback.  This allows to drop various checks for incompatible
> features while creating a requirement for the file system to only call
> the simple path for cases that it can handle.

Nice, this approach looks cleaner to me.

>
> As a side-benefit we can now inline the initial part of the simple
> direct I/O read fast path and let the compiler convert the indirect call
> to ->begin into a direct call.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/ext4/ext4.h        |   3 +
>  fs/ext4/file.c        |   4 +-
>  fs/ext4/inode.c       |   2 +-
>  fs/iomap/direct-io.c  | 209 ++++++++++--------------------------------
>  fs/xfs/xfs_file.c     |  14 +--
>  fs/xfs/xfs_iomap.c    |   2 +-
>  fs/xfs/xfs_iomap.h    |   4 +
>  include/linux/iomap.h |  65 +++++++++++++
>  8 files changed, 133 insertions(+), 170 deletions(-)
>
> index 3df851d0f76b..810dc4b8dc94 100644
> --- a/include/linux/iomap.h
> +++ b/include/linux/iomap.h
>
> +/*
> + * Fast path for small, block-aligned direct I/Os that map to a single
> + * contiguous on-disk extent.
> + *
> + * @iter must describe a non-empty READ no larger than the inode block s=
ize:
> + * writes, zero-length I/O, and larger requests need the generic iomap d=
irect
> + * I/O path.
> + *
> + * Does not support iomap_dio_ops, dio_flags, done_before or private dat=
a.
> + * The range must also stay within i_size and encrypted inodes must use =
the
> + * generic iomap direct I/O path.
> + *
> + * -ENOTBLK inidicates the generic path must be used by the caller inste=
ad.
> + * Any other errno is a real result and is propagated as-is, in particul=
ar
> + * -EAGAIN for IOCB_NOWAIT must reach the caller.
> + *
> + * The caller can only provide an iomap begin handler, and the iterator
> + * is never advanced.
> + */
> +ssize_t __iomap_dio_simple(struct kiocb *iocb, struct iov_iter *iter,
> +               struct iomap_iter *iomi);

Might be nice to have _read_ in this name as well, eg __iomap_dio_read_simp=
le

> +static __always_inline ssize_t iomap_dio_read_simple(struct kiocb *iocb,
> +               struct iov_iter *iter, iomap_iter_begin_fn begin)
> +{
> +       struct iomap_iter iomi =3D {
> +               .inode          =3D file_inode(iocb->ki_filp),
> +               .pos            =3D iocb->ki_pos,
> +               .len            =3D iov_iter_count(iter),
> +               .flags          =3D IOMAP_DIRECT,
> +       };
> +       ssize_t ret;
> +
> +       if (!iomi.len)
> +               return 0;
> +
> +       /*
> +        * Simple dio is an optimization for small IO. Filter out large I=
O
> +        * early as it's the most common case to fail for typical direct =
IO
> +        * workloads.
> +        */
> +       if (iomi.len > iomi.inode->i_sb->s_blocksize)
> +               return -ENOTBLK;
> +       if (iocb->ki_pos + iomi.len > i_size_read(iomi.inode))
> +               return -ENOTBLK;
> +       if (IS_ENCRYPTED(iomi.inode))
> +               return -ENOTBLK;
> +
> +       ret =3D kiocb_write_and_wait(iocb, iomi.len);
> +       if (ret)
> +               return ret;
> +
> +       if (iocb->ki_flags & IOCB_NOWAIT)
> +               iomi.flags |=3D IOMAP_NOWAIT;
> +
> +       inode_dio_begin(iomi.inode);
> +       ret =3D begin(iomi.inode, iomi.pos, iomi.len, iomi.flags, &iomi.i=
omap,
> +                       &iomi.srcmap);
> +       if (!ret)
> +               ret =3D __iomap_dio_simple(iocb, iter, &iomi);
> +       if (ret <=3D 0 && ret !=3D -EIOCBQUEUED)
> +               inode_dio_end(iomi.inode);

afaict, the inode_dio_end() error handling has to be done by
__iomap_dio_simple() to properly account for the synchronous case. I
ran into this earlier when doing the iomap_next_fn inlining. For the
synchronous case, __iomap_dio_simple() calls
iomap_dio_simple_complete() which calls inode_dio_end() even on
errors.

Thanks,
Joanne

> +       return ret;
> +}
