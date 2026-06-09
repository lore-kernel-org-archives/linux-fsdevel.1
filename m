Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76F175A89
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 00:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780964326; cv=pass; b=kKyURaNNrkfPU2dIR8/s34Uni/Z/a0pyHSlPuRWaoyBwH5c8u3yOVXonSxJxTvqrtZdGGp5xZqz1wkmKpRq3lqBydmooutV1ds/dS1bEUYiVUSgZrMSGcWWADYI3gCRBY47ZChE9a+1Qpn3KaSQ6myk3j9RaEZGIqTHo0IExaBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780964326; c=relaxed/simple;
	bh=g7XFO0IucURDT3pzzC1XEE/GsBTCKmDc2Wzj1qXq2H4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g/rtedCi7sc7+47t/rTAQzdsNk1krhAltC9RD+V1xKKqz4h0zS5ssIrv5unvQwPKfjS5P1senNbnrQU9wyOjg/SkGf0kDdmiG4K3zzsFQZ6gaAkAuuZCniQU7ooDbveH0Q80lnX+FZ+8qvabJfA2vN4gDl1N+LV/9hJYzHlyNTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YuYnNT4x; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YuYnNT4x"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39677245e15so46810891fa.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 17:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780964323; cv=none;
        d=google.com; s=arc-20240605;
        b=ao5LESMBXsMiRDx/UUVWMbJ+Mgdm6UTx5WvuuoXXGQRugyrV/37AFXVA2Gknoh7tnb
         L1VgEK4wm4R9JNnKWzd9OIHw3eAytL0W/mYh36OMmZmXeNlYKIYkgjVUVL/6J0fmdtFz
         1sSNcPtT8631nqfhBbsOKnYfRmGbSZfQY9M0fgxTqScHIvKYFYPUKgY1Li7BA0n1W9zN
         eYDWpXjMl0IBOdGO5CBjtUN9JhfO0P/KEjlXqTr4+QgM2qUe49HIYYWlWALsttah0jrJ
         C9VHO+MPRUHSuIEp6pFbqMBDmRLFjYqqsTZPZHjHH4AtlH58Z8cnLQU/EaUqQ7j+PcjC
         oeYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pHNfRp0QH0ivmNsCb3p1tkED6tQ7dzWkpJwWEGenuCw=;
        fh=pMPAPuHkYcrbEqWe0MbvA4uy7H36YFGOTJud/SXVsrI=;
        b=Hqlyfyc5q+4WWeHi7ivtobn1Jut4iVdUql22HfyLYjLMfAUDg3FDwWV/v7zfyhVKYt
         ntLLOmNX+bKkkkhEuzaDt4IvFp7avmykW/dPYq04lJtw66qSRcN3VPUZInBpf2yGSLU+
         NFRoD/b4SOZBoKE6ZNC7PkGT5O06GMNFxv7JGsyd1ePCPS912VaR+fs81yw3C+1/XTNM
         cv0hfCfBOmdqPnVDOYoZS6FJydrEOt+YvZ6suf2pxhmsWgCdohgNMuJz0rsbJKKcgAJT
         84KSyklzYTmIHEKOuOYGrYbXXTwCnaoD/TRITKZ9XI1YVmgBb60yBp5jqpK+sQdr1CDm
         IJvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780964323; x=1781569123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHNfRp0QH0ivmNsCb3p1tkED6tQ7dzWkpJwWEGenuCw=;
        b=YuYnNT4xrgsHV6+w3yWb6j2+a6U2A22+6vw+K/W2nM6ZEp4ZyAoxkOZq0xgl6u+Om6
         2rLPheqY787EgQlb8DaYdD7lpCZLqP/WN77EnneAUkV5stv2EJEBKiKQLaPuneX9FIDt
         IyTJZ7Ox28mQCs8PHyjg87aacjT4tf8/cM0N3rm8vWkba7npS7N1KxS+Yg4Ax3TXKciz
         x3X5OWvNt3dEoCmgmME+ZqqTBnheV1T68Qc516YTpY06lHRUB2cQuw2whiwW3ROUu6HE
         FT2WM6Iv2UD45EQRZbCNCxKA93dcZ1kLNKWah1dVURg+jH1z0QL/xCXkUTHAGSIDpNsW
         fp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780964323; x=1781569123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHNfRp0QH0ivmNsCb3p1tkED6tQ7dzWkpJwWEGenuCw=;
        b=FlLPvcFJuJ6Z5/Mf6SA334IIChKJDVMW0HnigL/yUf2TSz5hAgfYzqfkVBqv/PrBWQ
         5uGeoUMTetZ/+s8xPDr8riXxIUuTLkF+ZDZ2XZpTRR1TdqWjHyZcHXtYfEgPZxomB5IY
         6hAfl0b1whTmWeexbLLDKt54mO2Z7sFhDhdZAJywjvQ3rsBO/PBa4Y2/Msyh2IYaM8Va
         zN4Wloq8/ZSwDcqZaCa1m4qfYbB5HmmolDJ/3oy6KXluxC0sDLtnlsq2swuCHMkaLH/9
         ZH8k2S7McATN+MIDsR4OEzLdrodHfZMLnccRMb9IuRddqFnqf8zqTmTbYBbFn+5tW+2t
         WiGA==
X-Forwarded-Encrypted: i=1; AFNElJ8v5KqylLzLYvBjRJBDkNEaaZyY/vXRMHPXFLF0NWusGusI+eGAKgxLgqzxeNxvBlueLg0hQ5hDycbxcyIy@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm4LnMzcCiPpOycaK7kJhQ9SNzhH4DpyKTc4hncMa30NUSglpp
	1zu5eJ6K5JroFOiuV/HL/EigmZe/j5L0wW+X24lzL3hDiiQpqyIouzVImb/2RvpocpPWxx79rLt
	PCdz+IRgZPDmOOLERKuMe0zTIVr4R9WU=
X-Gm-Gg: Acq92OHbOa5b4OFhl+wbGv8bIVZkEquCcfGAqMU7hsIOjPC+q+GjgsMdJf9FgBKTy8y
	zyCLG+E4xEkmF7Y/DMzdVm6/+HVEI3AsikaKNUtZ9Cw+bwegBWlde9jB1C6v0QxkoJ/EpSH6Lho
	LERED5fI6CVNhiS+0Alu/oKInaTRsBOoY9u5fr5Jg6ywfyvAf/qpPQz7HE2jts2YtJN1NJELLt+
	x13lDFUHHfGFhIxJF5m787o9+w5wABgjt+s3RpgcyT6aiH5JGaBa7wcE1x8t+9qoNnpojCafoEv
	D2q+rF2edLyerePqZA==
X-Received: by 2002:a2e:be2b:0:b0:396:8d0f:249b with SMTP id
 38308e7fff4ca-396d08d066cmr52060061fa.12.1780964322709; Mon, 08 Jun 2026
 17:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608210618.3437216-1-willy@infradead.org> <20260608210618.3437216-2-willy@infradead.org>
In-Reply-To: <20260608210618.3437216-2-willy@infradead.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 09:18:31 +0900
X-Gm-Features: AVVi8CdkX_aLXqBlaPzMju4XHc5nOcO271OPhrU-2TGGmnU5WyxBdf1WFLomVi4
Message-ID: <CANFS6bb=5JJ0-bBusAugG_EaLW4ws8Z9zvJJJjv2eyWXqRpJpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] ntfs: Inline zero_partial_compressed_page()
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 6:07, Ma=
tthew Wilcox (Oracle) <willy@infradead.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=
=84=B1:
>
> zero_partial_compressed_page() has one caller and the next commit
> will make changes to it that make it inelegant to split across two
> functions.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/compress.c | 34 ++++++++++++----------------------
>  1 file changed, 12 insertions(+), 22 deletions(-)
>
> diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> index 76bd806b41ed..c904858dff3d 100644
> --- a/fs/ntfs/compress.c
> +++ b/fs/ntfs/compress.c
> @@ -96,26 +96,6 @@ void free_compression_buffers(void)
>         mutex_unlock(&ntfs_cb_lock);
>  }
>
> -/*
> - * zero_partial_compressed_page - zero out of bounds compressed page reg=
ion
> - * @page: page to zero
> - * @initialized_size: initialized size of the attribute
> - */
> -static void zero_partial_compressed_page(struct page *page,
> -               const s64 initialized_size)
> -{
> -       u8 *kp =3D page_address(page);
> -       unsigned int kp_ofs;
> -
> -       ntfs_debug("Zeroing page region outside initialized size.");
> -       if (((s64)page->__folio_index << PAGE_SHIFT) >=3D initialized_siz=
e) {
> -               clear_page(kp);
> -               return;
> -       }
> -       kp_ofs =3D initialized_size & ~PAGE_MASK;
> -       memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
> -}
> -
>  /*
>   * handle_bounds_compressed_page - test for&handle out of bounds compres=
sed page
>   * @page: page to check and handle
> @@ -126,8 +106,18 @@ static inline void handle_bounds_compressed_page(str=
uct page *page,
>                 const loff_t i_size, const s64 initialized_size)
>  {
>         if ((page->__folio_index >=3D (initialized_size >> PAGE_SHIFT)) &=
&
> -                       (initialized_size < i_size))
> -               zero_partial_compressed_page(page, initialized_size);
> +                       (initialized_size < i_size)) {
> +               u8 *kp =3D page_address(page);
> +               unsigned int kp_ofs;
> +
> +               ntfs_debug("Zeroing page region outside initialized size.=
");
> +               if (((s64)page->__folio_index << PAGE_SHIFT) >=3D initial=
ized_size) {
> +                       clear_page(kp);
> +                       return;
> +               }
> +               kp_ofs =3D initialized_size & ~PAGE_MASK;
> +               memset(kp + kp_ofs, 0, PAGE_SIZE - kp_ofs);
> +       }
>  }
>
>  /*
> --
> 2.47.3
>
>


--=20
Thanks,
Hyunchul
