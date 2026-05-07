Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E019017B505
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 00:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778114278; cv=pass; b=O4wbNC9FIFLG7qQG0XJJaGnaT02isnrSdMGWZSTOQ3vWxL4/DjVmp6/oG73wuSk5UW4kQkBDejh0B020biCmB57CVm/l3OJFKoCdxyGg1zkwA1uAD6FFDd3J/8MyYjndX2bRt7OjUYfOzunqU+K/4sy3lIcVKxWSA7q39tmzMZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778114278; c=relaxed/simple;
	bh=Jxu7Y1eGJl6U83lJ4jhat/I8Cno0NNBUExqD1lDFdKA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWEGI1BC6qbj6zBBInl6p7g+4IdXX7LLkTUDWK9zjIp0+eYfOAVkBCs7FbJPsnWd06cuiWa0PSAUbrVnd3dcQ/bBQq7sRTYdT5lidW+TS421k/EsCHVMU1oxDBZbriA2wPpjeiJkeooiY7C6pTk5upwihrZaV83ATSdjOVu1/9E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASLA8D5m; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASLA8D5m"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5a8891f0c88so106724e87.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 May 2026 17:37:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778114275; cv=none;
        d=google.com; s=arc-20240605;
        b=IVdRpaCWe0JBh8AX3gc6rbnsBkRF0jPkWb6q1lYV3+bW6qV/ibRnX/RWWhN+jly+cG
         qpZsFSedQb9eO4GE4Z31A/Kog3uisTAmDM+hPgWOK3VwHJ5zgicvOeye3We/MpMtSSt4
         T9mSD59tb+Uuptbf1PdMnQBFgGGF4wHwojkAXdEuUwG4BEyYnNsEWPKIzuTxsbaY62c0
         nvu98XOl5C2xo+pF80UAAyLlowgMj7CZldDIAFsqd79vnHjgZ5Z9M9rsrDpv1C0Xw9hD
         Fc5jTnm8ArzvsOTuD1MUBQ5qc9kJ/TUnYjJ0BFuwetDE1jzeiVbmB+NhFKlkpWDllCwf
         HaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SWTky9olgwRWos5xPnFO3z9gIi329MqARM2x3epwAek=;
        fh=uipGaW92tKSWoR/XkDaZ6tU8E5N99oEvUsW3cR9zo/Y=;
        b=DQ7FWaoJYtZmp4zhEJ0C8j5SBQn55SqbZjNx9icHFzqqE9lC1K0W8E6vDLfr09e6Nl
         jHApCG+5lbRlSyOXr3gmGUDbluwF6KsVsgtei6eFdEEPKs+jO78UZiKdLn+tdoge0DjB
         +8ryrrlG8o7UsAzgkii4dLJdbi6io23saX/6csIVvRfzkHgHddKM1qJPSh97gDMQ3Phs
         b46s4/fxN490ZfKCLNse+SWLDgBOWTO5EM8xgl0ooOog702VWVPkg8W2/bVojwmGS/ad
         /V9V6K+aF5ZOBF9TTfRUG9MEE2Y7tZT/9acQUprE3pukcz3806RYX6QNPC6tdLccI1F6
         xQBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778114275; x=1778719075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SWTky9olgwRWos5xPnFO3z9gIi329MqARM2x3epwAek=;
        b=ASLA8D5mmIaUei/U5P7wR0K/zAfrJLkAtfeOef37I5gHb6jI8Jsnn1hjdV6gibKUvx
         KytGBKaagPqv3xsxf8s1BeblrDx58QjL4RYtAqxirQ7D65bcbXZZeWNWYDsjnFYVizAV
         BAFPdKxmABGgw7K2hjP1GuVUZyo5JG1VaytuV6U3JjNtFsUE3nHulXDG/rvlLidbMGO5
         H6M469BgoDqU/5ffTcGfq757FyIFiTreSvkgbRC1ivtQtqJs54QjacsxUpeRTQCMJzcG
         56B9O78AmerVjX5NKqBAvVW/IgeUG+DPKRbmhXJ3lJIZ/IqpLcAgkVKUACZEqaEfXij/
         pnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778114275; x=1778719075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SWTky9olgwRWos5xPnFO3z9gIi329MqARM2x3epwAek=;
        b=BggB5Ed660RX+5FMHO0KtceQDstRfLn3Vq5/S1TVrqsdRCgcMfJmLc9U7uXi4BxSco
         R0p3VcZUI987yQfi2RXRmmUvB6YkEYfoOgPHAE7tc5LOd6f6Jkot76XlWryIQRlRbMRd
         KO3EPwu5fJvApTMFRyb/hVI6OcQGFVydV2eqxvgClt0N5CgyCPkrvzat2YxOlKv/oNKN
         oxmckeYGDzn2DOkc7wNIgHB/3gbnATvwj5f17ft+ZIbzp4lrBRL02OzjbhyaHSiCs9XW
         NopB6YqWgnWP4MF6TnVyceKCypyiM4fo69v9vlUA1JoH3/h0pCWulahKSSOYw54QydHn
         THeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+EiibbHoyFK8UK9PBjodeKY6wiZ9mVBrAYMtBnBKWYkO/aYLP4GqPthVtmSjL0Z5VKnKK+vRjaHCf8s0+q@vger.kernel.org
X-Gm-Message-State: AOJu0YwN0jA564wIiCGK16sIf7XygIs01KFWzTwPkc1xeBiaQtRafY6U
	z135yezyHCaEMv0zXzcULJj69w56aZ9SYonchYUqPUFgZ6uCUghyoseoKysWkWwNJWuW4xVXQ6s
	QpuZEdBVnQ9fdph/MUo95sHYm37AuNL8=
X-Gm-Gg: AeBDievtBtoYR1epejJgQt5WDm2uQTWqXuR0Go0Fb+rKEWnpMQ/AZGBBiBkAy4dyllk
	iIwv0epabS/97UiupcN09+i8/gmCqwXmwxBe9bE6bddVdhssIza2eICcIcMQjuuX826gmjiz8um
	HCeYLZ2f3jUivvl4v+/1DaLsfMhskalaGYhMLQup6M0c29p+6FYtyw9Wz4C8CnTgIHZDsYh8hCj
	ClN7xigFIe/WlrhCHzGTmutrydj/rxhzS2yRHCNg6iJHTNdf/dVh7CAb9xYgbX4ueApvlvDXEWe
	E5NIxJvvla31M+gCEBeQX3tyxP99
X-Received: by 2002:a05:6512:10ce:b0:5a4:1672:59e0 with SMTP id
 2adb3069b0e04-5a887cdec58mr2197323e87.19.1778114275013; Wed, 06 May 2026
 17:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506153850.774060-1-charsyam@gmail.com>
In-Reply-To: <20260506153850.774060-1-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 7 May 2026 09:37:41 +0900
X-Gm-Features: AVHnY4IyGfg1LdpTSEg07HRxTHFOBlXxx0-BEYBLQyMyFvQwQ3fGt9ySWzBNYRk
Message-ID: <CANFS6bZbLwzBTfODf71sO4Ok65w1BcWEsPjViA0bPj_nxumfnQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fix out-of-bounds write in ntfs_index_walk_down()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 5=EC=9B=94 7=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 12:38, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_index_walk_down() used to update the index traversal depth
> directly before writing parent_pos[] and parent_vcn[]. A malformed
> directory index with too many child-node levels can therefore advance
> pindex past MAX_PARENT_VCN and write past the fixed arrays in struct
> ntfs_index_context, corrupting context state used by later index
> traversal.
>
> Use ntfs_icx_parent_inc() for walk-down transitions so the existing
> depth limit is enforced before the arrays are updated. Make the helper
> check the limit before incrementing pindex so failed callers do not
> leave the context at an out-of-range depth.
>
> This is reachable by iterating a crafted NTFS directory after the volume
> has been mounted, including read-only mounts. The reproducer uses
> getdents64() on an index root that points to an excessively deep chain
> of child index blocks.
>
> A crafted directory index with a chain of child-node entries reproduced
> UBSAN array-index-out-of-bounds reports in ntfs_index_walk_down() and
> subsequent KASAN reports in ntfs_index_walk_up(). With this change, the
> same image is rejected with "Index is over 32 level deep" and no KASAN
> or UBSAN report is emitted.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>


> ---
>  fs/ntfs/index.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index a547bdcfa456..35c4eaa4e394 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -677,11 +677,11 @@ static int ntfs_ib_read(struct ntfs_index_context *=
icx, s64 vcn, struct index_bl
>
>  static int ntfs_icx_parent_inc(struct ntfs_index_context *icx)
>  {
> -       icx->pindex++;
> -       if (icx->pindex >=3D MAX_PARENT_VCN) {
> +       if (icx->pindex >=3D MAX_PARENT_VCN - 1) {
>                 ntfs_error(icx->idx_ni->vol->sb, "Index is over %d level =
deep", MAX_PARENT_VCN);
>                 return -EOPNOTSUPP;
>         }
> +       icx->pindex++;
>         return 0;
>  }
>
> @@ -1970,6 +1970,7 @@ struct index_entry *ntfs_index_walk_down(struct ind=
ex_entry *ie, struct ntfs_ind
>  {
>         struct index_entry *entry;
>         struct index_block *ib;
> +       int err;
>         s64 vcn;
>
>         entry =3D ie;
> @@ -1979,14 +1980,20 @@ struct index_entry *ntfs_index_walk_down(struct i=
ndex_entry *ie, struct ntfs_ind
>                         ib =3D kvzalloc(ictx->block_size, GFP_NOFS);
>                         if (!ib)
>                                 return ERR_PTR(-ENOMEM);
> -                       /* down from level zero */
> +                       /* is_in_root implies pindex =3D=3D 0; move to th=
e first child level. */
> +                       err =3D ntfs_icx_parent_inc(ictx);
> +                       if (err) {
> +                               kvfree(ib);
> +                               return ERR_PTR(err);
> +                       }
>                         ictx->ir =3D NULL;
>                         ictx->ib =3D ib;
> -                       ictx->pindex =3D 1;
>                         ictx->is_in_root =3D false;
>                 } else {
>                         /* down from non-zero level */
> -                       ictx->pindex++;
> +                       err =3D ntfs_icx_parent_inc(ictx);
> +                       if (err)
> +                               return ERR_PTR(err);
>                 }
>
>                 ictx->parent_pos[ictx->pindex] =3D 0;
> --
> 2.43.0
>


--
Thanks,
Hyunchul
