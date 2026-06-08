Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C50286419
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780963015; cv=pass; b=DoO9LcmNId7Ne7RyaWgVGPD4MnrtUPdeoM9tZeEzopI+E/HWSv2dDIFBItpoaTbzJT+yzs+DTT7GLjqYtIkfjFli9MjfDESNDgy2HN9EKZEpR35qFRoul2OA856apnGKMRgCu8bIgIb1TRa2AeVAC9c3XWowN4CJU3GjCrqpLww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780963015; c=relaxed/simple;
	bh=c5/JodvUj9pohEUcSbBZu+Y9HNoGeWXWaTj5tXBKGRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bHyEXMZwFecApn6C5k8QN00OjRbtWLKhz8CCSBxGOrMaUKWXmosGSW8PoN8ey9BQuLxnOCT50N7XRIRd4lcQveJiWTu2uRdgRjZWZcwO5wDaaSmjJndWmjZ589BGZft69McNhS/mukHm8UeEmdNhpOLAWfQOmu8CFSq/rjtOGBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+iDq3k1; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+iDq3k1"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-396bed274b9so41506001fa.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Jun 2026 16:56:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780963012; cv=none;
        d=google.com; s=arc-20240605;
        b=ImW/UlwwG55k9uN1AlFWVpjvE1dem9YqtH6D+LLWblOEMsf7ks4tzjLzjYJ1iHLefs
         I9lasNW4J60luRM5KBz8Jba2pUZWAIXdqtmCkKnvfcovbRBtRhQeCah1ulIcVd0hpw1v
         KugfiefBOOAMx8rn6YD5k1Xb+M262qDuVVUHDJiY47lJ7vydyzbUGhvIWU704WEA9qw6
         xkRjPAQTCb7nXQh3TFi2ILfuXWulwZZwNG7iDwLJxUY5TWKP7OSRPIjdWMvbKmP6PPAd
         NhyWiGYw8GLuNfSS4JGoVMbA/bAwFWB7uOgtrPk3SmbsenDfdpGOTgetsDfiHnQE3Vfb
         nAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=93aHwIYZPSJvu9WY88pHJ6dolHtfgryHV9+2dgiKUbw=;
        fh=nPzYaSNMqqYaRWPrWpJGDxWM+egckpgbHoTacX0gOh4=;
        b=S5/DJECQ6kAuUhuDZDRKsk0zUE/08Ajey8f+GFPQRydOV8g6J7EHdifag+te5MhtrF
         okoixmHis0D4DjNOotKLeISNE3dCDB+8VXjiA6Fj+Rg6IU75r4Sid9QXqiyabsfWAww0
         5Rf7JCQzZxJA3zV8RddoIDqbBnUU2IngB3ZIzb4C8cDoaVeKU0Zcd3TkkrDfiomJoQtA
         yzW2HGh9Vv+qJSPXNczMdwpQymNS3lhx8clbgJrf4bz5w3NdtdLepspXd6nHO0mtI2hU
         SGu6OZHXCdjN9RJ0/Vb3udpaJflFBOATWRLZXRvHLraj1Gl1gH87Ekz1gyQiN64sYmVE
         Kc8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780963012; x=1781567812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=93aHwIYZPSJvu9WY88pHJ6dolHtfgryHV9+2dgiKUbw=;
        b=c+iDq3k1vl8BFMr9fFa7Ub82Y220jbbw7Wl9HgbYOmhSuvLI532lINyYV5oKh1CGzq
         571EklBcY6/9jIr2WjMfLWCGhY1quCy6mx7XL4YjxsFjpHsON/v5/DT7LixuZ91yLrB+
         0Y++ccTuL9cQTuSLQzPzonv414ReXC0FUp3UPSqpNGbiVI0XkkwXGenIDjtTVLjZwArP
         ONDbvFE/Mq2215EKBMkMBlsNe2PmQ+4VNh8gFoq5aTOPUXCwaKsOBCReB8fw+61vd+Cc
         lzbz+zQ2MjM20QBFbK4h/MAi90/56QdwyRSY5rP83tzGWZYU7xFCQhk6enBhqYqTrvGG
         mwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780963012; x=1781567812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=93aHwIYZPSJvu9WY88pHJ6dolHtfgryHV9+2dgiKUbw=;
        b=er3y19HZMEdluPRfxyb1xvl0durCMGSWC63FSSUApSMUnm7DQIIChduHjzGhslRaL0
         khNtVltuDKuZAaznWVfn5bMwMYqtlzNl3T5UORMCuJJqIlAGz6nwp7yNiN7fHpodhVSG
         +GXqAE8Kh9JZ0a/83Ndq83fUUGxD0ORUKbnoDTbfCFPksEtrzLBNvyv1OkxR6K+I6w0Q
         I2aHAk5/FEKwuPa7RJ9u5pe8zgcfTpTSfDvy7fboFecYA4pZitoz4cHte8aRsqQA8vik
         +lAwoETL/Fz/iofxUGHqdAw7qk04N03HfECAc2yb8LpRNqDe8pNKyif/Sy5epwT+46z4
         EMZQ==
X-Forwarded-Encrypted: i=1; AFNElJ991F7KfU93DlBYOdbWsV/HcaLYaLgaoHYU8RsHkOkawsVx4s3UC75hdyXSY8/2161UDQzftS9SzrK0W6rH@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5ErXeIYuaWHRg1c4YMvcl2D8lYxl1Um4dIeN9xh4AvQl1ZMg3
	+YlD/seVnqqTBKiTMbGHbe1qG0ESIKuaneN4pwK76hs5K2IBKMivd1FfGB9vs9jf4g+XUFHgfT6
	OGBAPuTqQIgmsfb+sMVjLtedRK4PKs11cW5FN
X-Gm-Gg: Acq92OHdc/bhizorQwwGtCkH4KOIncjeZ0rWGKLPKx/PbEosO7Ari/J7kLOXsvDYQ3S
	G3dk4rRMtlwW6qe/+tYKfyneMCzRxMRRsHyix8B4A/+KHW4NtiG4k51DkF+4rzaob/+pXNXIfYT
	2cjwkXKNSId3DghnE5UAd2KxzXHu6Om6sbUm79MZ2Xh+At5ct7gapDnVr/7TX4NNC0Wuka0El8H
	WN2tMDhtMZYXDdG54FHlmLsaY134i0wkPrdLOk4nmNgDfg+cuFsWWfdM3tSVC5f8KfYlysxBstZ
	kn1rdD29xU7C/7EweA==
X-Received: by 2002:a2e:bd10:0:b0:396:74ed:a7b1 with SMTP id
 38308e7fff4ca-396d08e4001mr50773521fa.15.1780963011601; Mon, 08 Jun 2026
 16:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260608154917.2703739-1-charsyam@gmail.com> <20260608154917.2703739-3-charsyam@gmail.com>
In-Reply-To: <20260608154917.2703739-3-charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Tue, 9 Jun 2026 08:56:39 +0900
X-Gm-Features: AVVi8CfmLlYkwsJJS-BMVdCetvd0D2XPt4kmjIbjDMSpD21NAb_Pa686BOQK-1M
Message-ID: <CANFS6bZVAq5cT6xbYW7aM7ZFGJewzp2eY+vW5t6R1Ti95hQMyQ@mail.gmail.com>
Subject: Re: [PATCH v6 2/4] ntfs: grow index root value before reparent header update
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 12:49, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_ir_reparent() moves the resident index root entries into an index
> block and leaves a small root stub containing the child VCN. That root
> stub can be larger than the existing resident value. For example, an
> empty root with value_length 48 has an index area of 32 bytes, while the
> large-index root stub needs index_length and allocated_size of 40 bytes.
>
> The current code publishes the larger index.index_length and
> index.allocated_size before resizing the resident value. If the resize
> returns -ENOSPC, the recovery path can call ntfs_inode_add_attrlist(),
> which looks attributes up again while the root header says
> allocated_size 40 but the resident value still only provides 32 bytes of
> index area. Lookup-time $INDEX_ROOT validation then correctly rejects
> that transient layout as corrupt.
>
> This reproduces as a generic/013 failure under qemu. In the failing run,
> the transient root had value_len=3D48, index_size=3D32, index_length=3D40=
, and
> allocated_size=3D40, and ntfsprogs-plus ntfsck reported "Corrupt index
> root in MFT record 1177".
>
> When the root stub grows, resize the resident value before publishing the
> larger root header. If the resize fails, the old root remains valid for
> recovery lookups. Keep the existing header-before-resize ordering for
> shrink or same-size cases so the resident value never temporarily
> exposes an allocated_size beyond its bounds.
>
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/index.c | 78 ++++++++++++++++++++++++++++++-------------------
>  1 file changed, 48 insertions(+), 30 deletions(-)
>
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 8371ff4303e7..052d80fddbbc 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1240,6 +1240,8 @@ static int ntfs_ir_reparent(struct ntfs_index_conte=
xt *icx)
>         struct index_entry *ie;
>         struct index_block *ib =3D NULL;
>         s64 new_ib_vcn;
> +       u32 index_length;
> +       u32 old_value_length;
>         int ix_root_size;
>         int ret =3D 0;
>
> @@ -1287,6 +1289,21 @@ static int ntfs_ir_reparent(struct ntfs_index_cont=
ext *icx)
>                 goto clear_bmp;
>         }
>
> +       old_value_length =3D le32_to_cpu(ctx->attr->data.resident.value_l=
ength);
> +       index_length =3D le32_to_cpu(ir->index.entries_offset) +
> +               sizeof(struct index_entry_header) + sizeof(s64);
> +       ix_root_size =3D offsetof(struct index_root, index) + index_lengt=
h;
> +       /* Grow the resident value before publishing the larger root head=
er. */
> +       if (ix_root_size > old_value_length) {
> +               ret =3D ntfs_resident_attr_value_resize(ctx->mrec, ctx->a=
ttr, ix_root_size);
> +               if (ret)
> +                       goto resize_failed;
> +
> +               icx->idx_ni->data_size =3D ix_root_size;
> +               icx->idx_ni->initialized_size =3D ix_root_size;
> +               icx->idx_ni->allocated_size =3D (ix_root_size + 7) & ~7;
> +       }
> +
>         ntfs_ir_nill(ir);
>
>         ie =3D ntfs_ie_get_first(&ir->index);
> @@ -1295,48 +1312,49 @@ static int ntfs_ir_reparent(struct ntfs_index_con=
text *icx)
>
>         ir->index.flags =3D LARGE_INDEX;
>         NInoSetIndexAllocPresent(icx->idx_ni);
> -       ir->index.index_length =3D cpu_to_le32(le32_to_cpu(ir->index.entr=
ies_offset) +
> -                       le16_to_cpu(ie->length));
> +       ir->index.index_length =3D cpu_to_le32(index_length);
>         ir->index.allocated_size =3D ir->index.index_length;
>
> -       ix_root_size =3D sizeof(struct index_root) - sizeof(struct index_=
header) +
> -               le32_to_cpu(ir->index.allocated_size);
> -       ret  =3D ntfs_resident_attr_value_resize(ctx->mrec, ctx->attr, ix=
_root_size);
> -       if (ret) {
> -               /*
> -                * When there is no space to build a non-resident
> -                * index, we may have to move the root to an extent
> -                */
> -               if ((ret =3D=3D -ENOSPC) && (ctx->al_entry || !ntfs_inode=
_add_attrlist(icx->idx_ni))) {
> +       if (ix_root_size <=3D old_value_length) {
> +               ret =3D ntfs_resident_attr_value_resize(ctx->mrec, ctx->a=
ttr, ix_root_size);
> +               if (ret)
> +                       goto resize_failed;
> +
> +               icx->idx_ni->data_size =3D ix_root_size;
> +               icx->idx_ni->initialized_size =3D ix_root_size;
> +               icx->idx_ni->allocated_size =3D (ix_root_size + 7) & ~7;
> +       }
> +       ntfs_ie_set_vcn(ie, new_ib_vcn);
> +       goto err_out;
> +
> +resize_failed:
> +       /*
> +        * When there is no space to build a non-resident
> +        * index, we may have to move the root to an extent
> +        */
> +       if ((ret =3D=3D -ENOSPC) && (ctx->al_entry || !ntfs_inode_add_att=
rlist(icx->idx_ni))) {
> +               ntfs_attr_put_search_ctx(ctx);
> +               ctx =3D NULL;
> +               ir =3D ntfs_ir_lookup(icx->idx_ni, icx->name, icx->name_l=
en, &ctx);
> +               if (ir && !ntfs_attr_record_move_away(ctx, ix_root_size -
> +                               le32_to_cpu(ctx->attr->data.resident.valu=
e_length))) {
> +                       if (ntfs_attrlist_update(ctx->base_ntfs_ino ?
> +                                                ctx->base_ntfs_ino : ctx=
->ntfs_ino))
> +                               goto clear_bmp;
>                         ntfs_attr_put_search_ctx(ctx);
>                         ctx =3D NULL;
> -                       ir =3D ntfs_ir_lookup(icx->idx_ni, icx->name, icx=
->name_len, &ctx);
> -                       if (ir && !ntfs_attr_record_move_away(ctx, ix_roo=
t_size -
> -                                       le32_to_cpu(ctx->attr->data.resid=
ent.value_length))) {
> -                               if (ntfs_attrlist_update(ctx->base_ntfs_i=
no ?
> -                                                        ctx->base_ntfs_i=
no : ctx->ntfs_ino))
> -                                       goto clear_bmp;
> -                               ntfs_attr_put_search_ctx(ctx);
> -                               ctx =3D NULL;
> -                               goto retry;
> -                       }
> +                       goto retry;
>                 }
> -               goto clear_bmp;
> -       } else {
> -               icx->idx_ni->data_size =3D icx->idx_ni->initialized_size =
=3D ix_root_size;
> -               icx->idx_ni->allocated_size =3D (ix_root_size  + 7) & ~7;
>         }
> -       ntfs_ie_set_vcn(ie, new_ib_vcn);
> -
> +clear_bmp:
> +       ntfs_ibm_clear(icx, new_ib_vcn);
> +       goto err_out;
>  err_out:
>         kvfree(ib);
>         if (ctx)
>                 ntfs_attr_put_search_ctx(ctx);
>  out:
>         return ret;
> -clear_bmp:
> -       ntfs_ibm_clear(icx, new_ib_vcn);
> -       goto err_out;
>  }
>
>  /*
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
