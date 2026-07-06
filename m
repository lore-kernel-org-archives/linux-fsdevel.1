Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1BC1A8F7B
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 00:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783297960; cv=pass; b=lisftujybffN6uAQsjv2dvIc1Jy0dtwVXwXFIAo29dps7WtAatZCYTas2iYBsFFtvrJOR4vwNfmyK6JjjZYLlPlEu8seOUAx8f5dzhaqr/zN2K/dh2N5xLn8vrX6IZt2WigjZ+dX3PWqzc7iWIrjQYUmpQUjfAmWoUEXVxd9AXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783297960; c=relaxed/simple;
	bh=zswpdzkeM7Ka/QQjz4jZImHIuVJ2jVdV3Jv/Nlo7RoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G2EqEchqE6YV5bsUrsUOy+nrCYMPghpdHpSqvOTzLCrP9EECuZ3RDj4f+l1UoE+UIr0W7dmu0c6GxmmojoUxgLb08PVUBXxlvQgxaA1oqmEdeFZKGEzhrS4wl763cujN7pJGDqsEztsxYaHhK+RA76xo9EUQyYXGjUdwNIeaW4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdXSqQZV; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdXSqQZV"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso2604784e87.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 Jul 2026 17:32:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783297957; cv=none;
        d=google.com; s=arc-20260327;
        b=Gp9w3nOmROq88Zr6lRevS0M61jgXyn/QaYSW8W1LxSRQZ7bUYNYIDq49cODwHeDuxQ
         fF0Kycs7F2Faj4eiI3Q4FlygiXrpM6G6uGq4RV3SoXWVvcfQ+R37YycrrtfO39QfrbSh
         ELvQ5cG/EkHj6FcAysq8kI5+lyFuCxAMGwzb20JzReliKJoyCQ02pSwxjR8eK+v62VIE
         pLWtnLw28TEsCRTpwzxjzonyVAllz96m7hwFj/5p8MVmqJxZdGbh4aeoR1f4Y3FUzmzD
         P9hXL85XpcDe3bRHTtkETiQzrj7AsC7hBEyIbO0IKTscbTQM09yQMReEFfsB3FlHsOCw
         ofSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M0+Zq7LyGmSzMiOJqGrL+Y0ScXmuWRPN71S5XMrBzK0=;
        fh=+XYEoC8xUss6K+beBQXWNxlSd7j8mR1dv6Om00co5yg=;
        b=rq7TbEJN2r6Xq0zAo3GOJEbXaE17o2UnWCd3HarcoqI5NUREggwgUceqgURL53XdUp
         O4NC9JpfITLqAOtx8PoTjosbSG+ZIS/SGMrgDB+e/SstZhT10wJz+SSMixqYWvzNgBgh
         +zB20n3PJJ9ZeeD06sF+WSa36U/xnbVmiRLTDpJsPjWjnJpbFTYBB4hJkMrk17mLK/Jn
         q1HLll2mqRrZ8kmk7AIYEicjV8tlUXJY5JSLVE1tPdgfqPh53atu+S0wWqy7BJ1bfczf
         1MqURIdb0tzwmt6ckI2D/ZZnK5NGn3Ci0LgKuYP52WnMbd7JCxopsnCZl9vi0AusgGmy
         VEvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783297957; x=1783902757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0+Zq7LyGmSzMiOJqGrL+Y0ScXmuWRPN71S5XMrBzK0=;
        b=UdXSqQZVkPOzvk0y6OfSDE5tFJ6oX6qQGHyo3XAsdj/EDhwlhboJb9aHwn4/qKkNxZ
         kk22TRufqy7akr34Y0Dwbm1eCrcBp+dhFiX68KxT3C/ruPqmL1BObSNXHBmlSNOTppGT
         /pGmnBwPcKjz9dwFmGM2w0zrXa0073cBWgnolMf155tRYrs+EVo00FIFQeRwsDGuIiZt
         b8xAPTIOdhcXYsFt9+RsKkQjRCDOHVzi0XiXDUZtCEEoruRS53Ln0SCiI3yoGYM9+IPV
         qS93Dje2Tf6k12r6QbB6qvySPS+Pt/91XcRlYs74Iip/kWqvPQmp7q9zJxOIKOmW06D2
         F/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783297957; x=1783902757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0+Zq7LyGmSzMiOJqGrL+Y0ScXmuWRPN71S5XMrBzK0=;
        b=qkX+c0vmw2SrP2z4DbGwh7O9L6OAqX7b8VGFwP4Vl6I+V4soazuJxrthfSgD0ZeEzp
         XjsSCminAm9iLplWcvQVXDbRVcwH8elzMQ+2dRocGo1ZVhA0PyZjkOF8xAbZgZBd7Ke9
         K81BCxukO81GpuRnGFLvdWiYsXff7Yde+rc3pKzPCmEGQPjuwYV1T/X54FvcpSrtgxpi
         P4O1MxAM3LpBraSZcooF1yH3gK8C65TxoKMmb4MBtrAlOP4aPKpS8MiOJXqJQUeVRlFN
         kiXCKTYtfyQP2mQ7q9BO7U8w1z6EbfjivzJRL0qfNiGh4OPvFyi5i072mEMtRHu4Hsgz
         4bQg==
X-Forwarded-Encrypted: i=1; AHgh+Rpghoy3yNq9dIL4ao/8rUpSplqtMZWhsHPJo4Bu0jUxyifgZEI3upNQn7nAUBtOYSByrbb0AUZP8d/C+ngV@vger.kernel.org
X-Gm-Message-State: AOJu0YxWhKKWgilQD5AscC9dKH83ATzDrlP5iGy4/uy2OC21BrgLuh24
	+NY3vAAVp4RzmVXAXwqESbABEiVu4OLcS+T2s+Y/rCvlgnOD5jVxz+NdY/4xjJGdI0+MjX3h4/D
	2PEdcSYDIPJNLEy5kItgs34PK5hjv+RU=
X-Gm-Gg: AfdE7clIpmJMGm65g4ua8tmDGTLBZwL6ffVLM3hM4/wP6NuFZ4AHH/5IsdONk3lv027
	vILWSNuB+VrTX2bc63jRTzdEzSxiA7do6z7l6Yrzm9uwGnnker537SgBCAwv8LCl2pYlQmKq4+Q
	NiSYwhCKkox1QOQ5UAMpQbAA7kHUsyknlQWojet6qwJGamREBkLudb3fyx5UOOHP6MBREPZoYKt
	BkC6WsMSmlRFp0oeFbcevHKojTbe9trC5+vausWdfQjc5uZHX0D+PhO33zXS7IH8ATwABww
X-Received: by 2002:a05:6512:12c6:b0:5aa:6e86:55e5 with SMTP id
 2adb3069b0e04-5aed5090771mr1580106e87.13.1783297954399; Sun, 05 Jul 2026
 17:32:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704111057.114173-1-mdshahid03@gmail.com>
In-Reply-To: <20260704111057.114173-1-mdshahid03@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 09:32:22 +0900
X-Gm-Features: AVVi8Ce8fkODXFjuWAjIuJZxO7nboJ6vzCirGgTNAxlWx3d96hyABXm3aZPquww
Message-ID: <CANFS6bZjiPufBrPE7P=G1DuPOdpHYaQq5L7duVMQQ30KoyJcJw@mail.gmail.com>
Subject: Re: [PATCH] ntfs: mft: use kmemdup() instead of kmalloc() and memcpy()
To: mdshahid03@gmail.com
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 4=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 8:11, <m=
dshahid03@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> From: Mohammad Shahid <mdshahid03@gmail.com>
>
> Use kmemdup() instead of a separate kmalloc() and memcpy()
> pair, simplifying the code while preserving the existing
> behavior.
>
> This issue was reported by memdup.cocci.
>
> Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/mft.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index a5019e80951b..fd07d41c2741 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2420,7 +2420,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, =
const int mode,
>                  * record.
>                  */
>
> -               (*ni)->mrec =3D kmalloc(vol->mft_record_size, GFP_NOFS);
> +               (*ni)->mrec =3D kmemdup(m, vol->mft_record_size, GFP_NOFS=
);
>                 if (!(*ni)->mrec) {
>                         folio_unlock(folio);
>                         kunmap_local(m);
> @@ -2429,7 +2429,6 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol, =
const int mode,
>                         goto undo_mftbmp_alloc;
>                 }
>
> -               memcpy((*ni)->mrec, m, vol->mft_record_size);
>                 post_read_mst_fixup((struct ntfs_record *)(*ni)->mrec, vo=
l->mft_record_size);
>                 ntfs_mft_mark_dirty(folio);
>                 folio_unlock(folio);
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
