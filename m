Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DDD83FE64D
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 12:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778673977; cv=pass; b=gjx9URWLSycEB80Rrpo3XKtUq4GHLpvxNNgMznyECdlubJfWmyL14Xz+GFqEmWIScpQGNDh4b60c+7q5SDd6MW57geuoEhGCbNVCjIjZPodgEGEiYJmWgnq0reb2CRPG49x1wUMwfBjkvo/TGyepJ8uY7FCD5gZ3N1B+HqVvgWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778673977; c=relaxed/simple;
	bh=31Wgk6WZtu79qCiBADkqGs2rIthLTccoKzc2S7oCBxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tqK115Nz0ithY4UxASLZdqPr0oLwQvBMgq1ZtoqKJaZg2JhzSpx7hYL0rrk0ib+B9APMfonQcGgN32FblrHKF8XA8uTMzSS+rXE6+6bT9pRbqvxkNUUQB7Sj9hdvGNVvzQCDmw3XQEEB/TwMeOOkiipirxfMX95gkm9EuTF50iY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVNpL86z; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVNpL86z"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bdf6db2c70so7751797b3.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 05:06:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778673975; cv=none;
        d=google.com; s=arc-20240605;
        b=VbSTpgd70Q97El81SJ9QU4G/SZFoBtrEcVFb/kIKLM7zHMxK2ZojqVDfWD0a8zgF+0
         Q1uv1oAEmD8FOy5pabPnyTlY+a+Ob9Daptd6aEn4bMwA2tki4Km3sfkUlOXUI0kSw5pT
         xK6RSFanO7ztevsqo7u8oGEq6TXxaSjyi2eekpy9ALSBLVCd2DLlZAueiJV6EwezLZ18
         lAIqPeM1MPaLTJz9m5zxy/u8z4qanflWXGo6RENifnn2cpOGURlAw+RVbW+SHp3rRY/D
         BxNCSi/v9AXSP1qSDSz52gWM3FBT68wFfTRp3/NbxzX5Uhn3nb9l0kuxL32uoSkMNtDe
         vBgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bSrJ9uyB5YcP/PyCKuM32TEePX2kuaGlLagkEceOIns=;
        fh=0dsBR/c6RXpy7zGWTe3h4Q1BjftbtZMG7OmKVSkOIZQ=;
        b=luziv8n3rQzJCWAWjLtQdLDpLsNm50XxB3Zw6O+LsXowVwZQVGlgMvRl9+5eOjAUHS
         YXOTiL2RwgXglqsJ3fdNt+x+j8ffV1UjWOfff8Gk4lHPzNJq84kIYQhXiuxMlAZJ1745
         ntMtX9PA8jnIqOCgmq6dPV6niLFCjtifli4FW0tpHkrfQVuRsBz3htSHglQ2ZESFWu9B
         yzfMTVYWwBHuOIj+9tJIG5b73nIxvQwb13ZU3y9dD4HDcYdQ9vGv42cRq68LkNoIJk+Q
         5NHSyPQ3WKu7+R6BFB7WOXAMMaJtlbk4ZCB+lm/3z3s4WtfycLXVFQW4mG2Hh0b5rq+J
         H5qQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778673975; x=1779278775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bSrJ9uyB5YcP/PyCKuM32TEePX2kuaGlLagkEceOIns=;
        b=JVNpL86z4RO90JLgipIT6q9Gv4bQfma9TkjvH9sP6S2/Sz3BzBnadiMccC0ONb19ff
         2l/3eJHYYTkd+MZk52DS2cohK5wqTL6J+eIeyMhn2PTrN6gaZdze4pS4HRsUu+oGXCfg
         WKR+nqpDGs+ng2Hcwt3sKwVlBSZt08CzF00Tbxs/XTY2Ok36Yx72+a43MDiyzdjt9GCW
         HV49PnGIUi1I/YzDjTQRF85NfO283zoHuYhBnGU66ZWbP4zVsVJV4lI30iN6yIUiuogY
         DWgfHUPOxjFf4O3SRhNg3WFwH60Zgh2bmTaFWKN0ZrQ2Ca0curQXiOJLdaYqXb1HRWLi
         0lvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778673975; x=1779278775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bSrJ9uyB5YcP/PyCKuM32TEePX2kuaGlLagkEceOIns=;
        b=GRXZTNKDS6YYg6+IsJHcE/2MD9qmt3cUNBFeprZMi/oVs3X1Ycs7RU2wvtYrv9pdz9
         2kucoGAleEE9szTGuHSN5EkLiGAlfmU+PyU73b/8nD0WwsKyN+dIPP/4oqKcHSEuui7o
         XPGfKNY4muB9OVaLlqgfrPKRf84/EII4QlnLazJVrV2iRYxYL4sVBGtek1xfDKSfPcu+
         bh9XBN1mCkVEvbOBDvK2PogjmU5CjmkVhdUvRQp/YN+WBvbatKQcJOfHCir3T5Ak+IPP
         W/nALH2r3A7+D5j2CM3eLaEkLqCsI+WM9vLfghllEh6wRO2og9Vfp5L2fuM0BzrfBu1n
         HG0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/GwIcVhVcAjUS426wziNgY3QcQTdI/KNM8BHpFLva0HSc8ki0QX8Xh9sXHj5P8Y7gwckPfMXMWiXJI2D8K@vger.kernel.org
X-Gm-Message-State: AOJu0YzZRyTBTReBNR2pbcZcyiRaM76pd4pSu0H8Ej2NQ9oHFwUHCMWh
	vTcST4abTfgnOQTVjtbeOoYgalqEyhrfVopQNyvXpyeZkWfFqdsQLIiS2sqrbbXRkX4HDwt62B3
	vQq1rnK0mkr01fp8OWQjv0j7RtrhUp7Y=
X-Gm-Gg: Acq92OGGdHlkFIy3RJiExkgl76Vvi7wjMsVLYk08Q0HRBgGMRrDCiCNfDXaTIFkiblc
	vtRp2b07DO60L9xE47JmO/d72/3enBkkiDk3G7CwlHakJTK41IjgDMEmknhLogtcnk+3xY8Q066
	9BXfla/NvTY4t5YGm3pfoSxV/2u688ngBbvqMvdWE+1KeWIKbNwOAIiENYmXhVdPFrE9Gu3dcUS
	9S0J+9/gC1iOLlJh2AQ9MFFeQKvXG0eFjgTwEmGECm1ofoD58J9EQf7C4xpAPgh850fv1iStyi8
	s7GXx9gN
X-Received: by 2002:a05:690c:6e0d:b0:7b6:40ef:6fe0 with SMTP id
 00721157ae682-7c6ac8a6efbmr19570957b3.5.1778673974904; Wed, 13 May 2026
 05:06:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-5-linkinjeon@kernel.org>
In-Reply-To: <20260513112156.9122-5-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Wed, 13 May 2026 21:06:04 +0900
X-Gm-Features: AVHnY4KV2vCDmBoHSzcRlMaPlawD_XQb1TMBsNVKH-DeX_KKxSoAYorbNbOuelk
Message-ID: <CAMrLSE7nvE97mwy__geEVadC8cmzSShGFPK5ZpnjrcPpYXyaPQ@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] exfat: add exfat_file_open()
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	chizhiling@163.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Namjae.

Looks good to me.

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 13=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 8:25, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Add exfat_file_open() to handle file open operation for exFAT.
> This change is a preparation step before introducing iomap-based direct
> IO support.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/file.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 29a36a80e29b..d0ecdcb4bf7a 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -800,7 +800,16 @@ static ssize_t exfat_splice_read(struct file *in, lo=
ff_t *ppos,
>         return filemap_splice_read(in, ppos, pipe, len, flags);
>  }
>
> +static int exfat_file_open(struct inode *inode, struct file *filp)
> +{
> +       if (unlikely(exfat_forced_shutdown(inode->i_sb)))
> +               return -EIO;
> +
> +       return generic_file_open(inode, filp);
> +}
> +
>  const struct file_operations exfat_file_operations =3D {
> +       .open           =3D exfat_file_open,
>         .llseek         =3D generic_file_llseek,
>         .read_iter      =3D exfat_file_read_iter,
>         .write_iter     =3D exfat_file_write_iter,
> --
> 2.25.1
>
>
