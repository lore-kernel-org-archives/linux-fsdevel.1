Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733083D5662
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240859; cv=pass; b=uO0MZ3+ZNBGKmrK3Y55zfZonXt65IZxOint2rJQe5cM7COsZ3p1U91L/75NWz6Bviw2qfoknwds1GQTO81Q6sMUdIXgFLvcrhYt4mbjdlZKxxEC+hQujHcVakRdvyjaQ7H1zR6LFarNDynk0CvoPRw+LcS0LWOZzjvlSvhFraL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240859; c=relaxed/simple;
	bh=6izFKLAXQ25CZ+35TIl8yC0TEPevxXfyEBfY9m3soAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P7GUWWJFFUTQi/hCAtWfuJUP0o1ZqJIorYIEs4A+twJtgHjGCfD5XgQsUj/FsCSaI1hCGR5lZ/5NgjtBMkcKJXOIGZCudB7lA4SggEccuhd+QLKDQELmvXZZ5tTVtEJ/0QFdLNLTNKj3rIi+1IfEdsrmxHMhUj9zPQieLmxzzJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHToiM3Q; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHToiM3Q"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b015b2d792so8475168e87.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:27:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240855; cv=none;
        d=google.com; s=arc-20260327;
        b=C3WnuRpr/1lz+ZJnnfpeZZ2x6uvKJu21n7gzAknqfFql4sI+YKEohS4z9M8x65gemV
         EoO4nk9Y5SCOIKWslFPnCCjFisEfS+7xQVGHQnasmvwLgNpWJrhV0ii9bOVxVhBd3m+n
         6ZsFT0dsk7STbwhzeIfIDflFVQ6kjno/+ozsLpRIMynNH+uG/NGWeRbIauiUv04uP2kr
         bVh5wlxCksRGhvgzK4WYxXTzj/hQ04Mv2zLksitob8G6wWGdVB4YhyakBeaHCWXTI4OY
         xh2vLHf+Ic9euuR8k7ltZWs8IU3VGx5fg+dirFY4AzVosg5XkZ9svldA/XjBiikV/RJx
         W4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3GNiDb8IqOV9RZOA/kubqQDgw9FaKyVldx5lkoAlLxg=;
        fh=z5rH8JzC7pFpBRNhRYswMgzYDC64s/CGPqC0UwypLQ4=;
        b=TxMm2T93j/jC8sWj40/ApHx4juq0/ete7gqWSU/cQcY72zhQyZrD/sM7mOctioeX7K
         CfZAA1vw2SF5cXMThp2xztaTYIRap8YqqazxKeaIY7n4u2P2UTxiZyoH/hqSj+UYxWpz
         tUpPAcG3SzVNxCVe5C9c/AtXDq1hB4UvETyWLazE8KNOeaneNbTBUoQsNgsUaoX53VGR
         gM197aeC3/Aj0Pve8g+6mZihB7W/wR70uWydCbcJE36X7Gm7dNIoyBUDxTrn16lVCZnE
         U/SNN0SoVYZWKaDRJ4bkkPsLxDf8B/DVGKIbVH8XlBnLhV9aRc5cZJmy4jZ8Fmquwzgf
         rIUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240855; x=1784845655; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3GNiDb8IqOV9RZOA/kubqQDgw9FaKyVldx5lkoAlLxg=;
        b=iHToiM3QJ1w3USrAGJby01hLrhZVRpMENVG55DerguDK59KeCJtV3I5SbeC4z1wqo2
         IiFZyK1XxbrHqbRTbk0RLfISd3PrT2w84s04nZIJfDRiCuU05l4YELAdBJ79LOBj+ULs
         DABPW0ViqnVB2yISeHEjvgvZZ+6TAMSeDbumZNkjxUFraFN7MkjQK50fNo2AAii7xLl7
         NeK7rGH0PKgGxOF8znhgCqfKR3TVuHnKI1/kMhIJYNM46kHmXamWAMzoY0n9NbwyxLaq
         Nemy5HWEpUZm1ymla4UObiW/q9et0ZB4VFQilGqXW8u4YwH2UjiTCcCsIB0aBrIn2UvB
         9jCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240855; x=1784845655;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3GNiDb8IqOV9RZOA/kubqQDgw9FaKyVldx5lkoAlLxg=;
        b=UmQr6/hUHwRh6mKvwsbgwmy5BfDy3XQO0lsaUT4JgYczIzJu7/nzZGV79JSyuEr8ny
         Unv+DeHf3TiI+R/mka58u/+CYy5G1XV+lrAwsG47bHQikY8a9vwCW/FQzeVziV0tNZd+
         /TAGovF3vYDgmK5k2oTxhXrXkNNDoyFesWCU7GyrTP6GLDN8ct3KjY2G4zUBlHOw1xBX
         2mPnxt3lFqBptEoFsGq4Wz0mAuohxrTe9nj4mCM/0AdDpjUpvHIt+lTC0S27Dx4TGwT0
         fecxl52nO0SR+MsiMhnVO+tndQJgEzLxLgfXUeG0mbZCz67FwCcX8b346tdqVXE6YOWc
         zLKg==
X-Forwarded-Encrypted: i=1; AHgh+Rr1/H1a41HK7DqNc4RlUlZTOFAu+MSpHtB1tUW0VZbiJygtbsSpN2BEmKT497BdYQ0fhTaZC6Hk/URK/L4y@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo42XIrZDeUsy9rIbMNByOmcv4OAVm+JTZRS4F+pC8WLQsHbHe
	QkVBSrlWIUnlOpV9HwVR2lVO8u0W3TMeUgAhMDOxsvuIT7+Fj3HW/E4VH1EhlcTOHKocDykPxk1
	Uvt7SdRVDCwMsHqAlAPRZTZcQ/iCf5NXg8vFd
X-Gm-Gg: AfdE7cn1pHfVNGfWWYP/hbTh7Vq/Gq2B3lyoZNn+pbHWS3ZxQoK4Qew+dHs0r2r1Xp3
	7X+YyTnJZChniaYOp6mow9ZsSeNF5YrgrAaodfBB8uJJ7drmKmzaWs2n7tG+bdx8btMI1FnsnFW
	Wjc2MfKFkYfkvDGAV+c82JykyhMzK2gEn1VEik3GAb9zKcVWAdb7L3uS5Gy5x5NkCkQp72zEmbb
	fhkAvEoeQNbSjm6zxt2ZKQVpr3xwIGQ+50uBY7PYjfVC+INGpD+voEf5Lm5dRs=
X-Received: by 2002:a05:6512:6d0:b0:5ae:bd27:a13 with SMTP id
 2adb3069b0e04-5b28fabfad4mr8732e87.54.1784240855266; Thu, 16 Jul 2026
 15:27:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716024640.13396-1-linkinjeon@kernel.org> <20260716024640.13396-3-linkinjeon@kernel.org>
In-Reply-To: <20260716024640.13396-3-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 07:27:22 +0900
X-Gm-Features: AUfX_myYgIQxt1JWeJH9pE66vaB9U7gaT7sPlFxz4ccOXwUwPMo308Xz88zQRmk
Message-ID: <CANFS6bZ7oASEgR57GkQNvos3cSm9G5sLWkVvET=OPUEXruxjcA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: rewrite EA stream before updating metadata
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:47, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Updating an EA removes the old record and appends its replacement.
> Build the complete $EA stream in memory and rewrite it from offset zero,
> rather than committing a compacted stream followed by a separate append.
> generic/642 shows that the append path can leave an invalid record layout
> on disk, including when a new EA entry is added.
>
> When removing an EA, write the compacted stream before updating
> $EA_INFORMATION and restore the original pair if the metadata update
> fails.
>
> When the final EA entry is removed the $EA/$EA_INFORMATION pair is torn
> down. If removing $EA_INFORMATION fails after $EA has already been
> removed, the original $EA is restored so the two attributes stay
> consistent.
>
> Fixes: fc053f05ca28 ("ntfs: add reparse and ea operations")
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/ea.c | 65 +++++++++++++++++++++++++++++++++++++---------------
>  1 file changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> index 88bfd6560692..d0044c61152a 100644
> --- a/fs/ntfs/ea.c
> +++ b/fs/ntfs/ea.c
> @@ -196,6 +196,9 @@ static int ntfs_set_ea(struct inode *inode, const cha=
r *name, size_t name_len,
>         struct ea_attr *p_ea;
>         u32 ea_info_qsize =3D 0;
>         char *ea_buf =3D NULL;
> +       char *new_ea_buf;
> +       char *old_ea_buf =3D NULL;
> +       struct ea_information old_ea_info;
>         size_t new_ea_size =3D ALIGN(struct_size(p_ea, ea_name, 1 + name_=
len + val_size), 4);
>         s64 ea_off, ea_info_size, all_ea_size, ea_size;
>
> @@ -249,6 +252,14 @@ static int ntfs_set_ea(struct inode *inode, const ch=
ar *name, size_t name_len,
>                         err =3D -EEXIST;
>                         goto out;
>                 }
> +               if ((flags & XATTR_REPLACE) && !val_size) {
> +                       old_ea_info =3D *p_ea_info;
> +                       old_ea_buf =3D kvmemdup(ea_buf, all_ea_size, GFP_=
NOFS);
> +                       if (!old_ea_buf) {
> +                               err =3D -ENOMEM;
> +                               goto out;
> +                       }
> +               }
>
>                 /* Check the final $EA size before removing the old entry=
. */
>                 if (val_size &&
> @@ -281,20 +292,33 @@ static int ntfs_set_ea(struct inode *inode, const c=
har *name, size_t name_len,
>                                 goto out;
>
>                         err =3D ntfs_attr_remove(ni, AT_EA_INFORMATION, A=
T_UNNAMED, 0);
> +                       if (err) {
> +                               /* Restore the original $EA if $EA_INFORM=
ATION removal failed. */
> +                               ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, o=
ld_ea_buf,
> +                                             all_ea_size);
> +                               ea_info_qsize =3D le32_to_cpu(old_ea_info=
.ea_query_length);
> +                       }
>                         goto out;
>                 }
>
> -               err =3D ntfs_write_ea(ni, AT_EA_INFORMATION, (char *)p_ea=
_info, 0,
> -                               sizeof(struct ea_information), false);
> -               if (err)
> -                       goto out;
> -
> -               err =3D ntfs_write_ea(ni, AT_EA, ea_buf, 0, ea_info_qsize=
, true);
> -               if (err)
> -                       goto out;
> -
>                 if ((flags & XATTR_REPLACE) && !val_size) {
> -                       /* Remove xattr. */
> +                       err =3D ntfs_write_ea(ni, AT_EA, ea_buf, 0, ea_in=
fo_qsize,
> +                                       true);
> +                       if (err) {
> +                               ntfs_write_ea(ni, AT_EA, old_ea_buf, 0,
> +                                             all_ea_size, false);
> +                               goto out;
> +                       }
> +
> +                       err =3D ntfs_write_ea(ni, AT_EA_INFORMATION, (cha=
r *)p_ea_info,
> +                                       0, sizeof(struct ea_information),=
 false);
> +                       if (err) {
> +                               ntfs_write_ea(ni, AT_EA, old_ea_buf, 0,
> +                                             all_ea_size, false);
> +                               ntfs_write_ea(ni, AT_EA_INFORMATION,
> +                                             (char *)&old_ea_info, 0,
> +                                             sizeof(old_ea_info), false)=
;
> +                       }
>                         goto out;
>                 }
>         } else {
> @@ -309,21 +333,23 @@ static int ntfs_set_ea(struct inode *inode, const c=
har *name, size_t name_len,
>                         goto out;
>                 }
>         }
> -       kvfree(ea_buf);
> -
>  alloc_new_ea:
> -       ea_buf =3D kzalloc(new_ea_size, GFP_NOFS);
> -       if (!ea_buf) {
> +       new_ea_buf =3D kvzalloc(ea_info_qsize + new_ea_size, GFP_NOFS);
> +       if (!new_ea_buf) {
>                 err =3D -ENOMEM;
>                 goto out;
>         }
> +       if (ea_info_qsize)
> +               memcpy(new_ea_buf, ea_buf, ea_info_qsize);
> +       kvfree(ea_buf);
> +       ea_buf =3D new_ea_buf;
> +       p_ea =3D (struct ea_attr *)(ea_buf + ea_info_qsize);
>
>         /*
>          * EA and REPARSE_POINT compatibility not checked any more,
>          * required by Windows 10, but having both may lead to
>          * problems with earlier versions.
>          */
> -       p_ea =3D (struct ea_attr *)ea_buf;
>         memcpy(p_ea->ea_name, name, name_len);
>         p_ea->ea_name_length =3D name_len;
>         p_ea->ea_name[name_len] =3D 0;
> @@ -344,13 +370,13 @@ static int ntfs_set_ea(struct inode *inode, const c=
har *name, size_t name_len,
>          * no EA or EA_INFORMATION : add them
>          */
>         if (!ntfs_attr_exist(ni, AT_EA, AT_UNNAMED, 0)) {
> -               err =3D ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, (char *)p=
_ea,
> -                               new_ea_size);
> +               err =3D ntfs_attr_add(ni, AT_EA, AT_UNNAMED, 0, ea_buf,
> +                               ea_info_qsize + new_ea_size);
>                 if (err)
>                         goto out;
>         } else {
> -               err =3D ntfs_write_ea(ni, AT_EA, (char *)p_ea, ea_info_qs=
ize,
> -                               new_ea_size, false);
> +               err =3D ntfs_write_ea(ni, AT_EA, ea_buf, 0,
> +                               ea_info_qsize + new_ea_size, true);
>                 if (err)
>                         goto out;
>         }
> @@ -370,6 +396,7 @@ static int ntfs_set_ea(struct inode *inode, const cha=
r *name, size_t name_len,
>                 NInoClearHasEA(ni);
>
>         kvfree(ea_buf);
> +       kvfree(old_ea_buf);
>         kvfree(p_ea_info);
>
>         return err;
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
