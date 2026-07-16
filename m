Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E002B3D668F
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 22:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784240928; cv=pass; b=byrb1h+ibKKj18aaxxSoZP3D4oMvZFOeLsL7YX7kLe6dn709g8FafxukMWVmVWFdO/mBHrA+JzP9UJsJtku7ZpxySb8GW7DZEGfSNa8NomS199spqmHl6Hxr97YXw/hvOOFY51hP0LaF1mN1ycOlfS8xFVnr8++8pQYQYND/n5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784240928; c=relaxed/simple;
	bh=ONDagBgJZvR9dg0unKgoZjq6Nl27AmeBJzUlL+tmTEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DcrjEGlfOXrRZSccrPKlIEuyO992DEc4CpYRCrgVYr4ts3wJwXbzufb0X98m9AdAdjfaMmXoYq/3/CA5EDCkw0YUWiQvyFDrhjd7EiCeMjXCgIhe4iGacC8hJuhHxvEi2iOgYuy6Mszq4mLGCeyl7x69NMRjj2hXWlOX6fiT8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dSetqGis; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dSetqGis"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aeba09900bso2944041e87.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 15:28:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784240925; cv=none;
        d=google.com; s=arc-20260327;
        b=ZJ6Lmw2s+XKWFtzOJMzt3EwG4RGg5lTq4OcertUdgMFacP6NQXvhUA1U9GdPCe96Ic
         qiqjNmq3PjfV73M0jondgu9mt9iKHsp8ZyqEYg72YV5AAP8pG1vTdLfg3/5evlhQO9TE
         tHmxhGRxdfpxj/uHGgvbO8iIsGCtLUj9ntPdbw9MI5J5a3ZXtpcQN27dvJjtKNNFcL+S
         wAPrvjjaRb01VFnn4Zy8RiN3N/U0zbIfQakOH6Cwq2mystolv6So8xjOgdPGW+q3HOS9
         ZghmlDRqsy2zl5iTfriTxBf0BgdFkSmr4GEEpggp461+0buph1z9DWFoP7NOFTqYaMIH
         DgfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4g3hX9kwv1LG4AWh7Eb8rRRUHNBzvOmYbs7dqFRKrU=;
        fh=ehDSHjDxIqk/4X7i8AmqSZA6Waf8AyShKvRN2skixsU=;
        b=NQhXzgKUDuYZaRXANSSnHfurRaKUZuyfrG1T8zJpl0lM/g65FZMA4GtPuPb8NypHVw
         NmgBqkb2gdT/vpwTAuBj5DfEINLhtbVr8mY4YvtYuueMsFFKzQL3oYcg8aXA2PdzCE4q
         uCgo5QAdWYVmeA6neHAag3RdXMOksCq+uxq4B/HNBJeitN/NMW98T6pNWSIZ031SlIU8
         DwSKGCPIDux2Zu1UJKDLNmuvcVhigqgw17TwQbNaT/a5qBegO3jdal8sOXVXWyzsT9tp
         cgui6/4M0tM1IjfstFLsfWx/vbM/85At2QgkZeYKdFsiJlUxs9X+MOfgASI8cbh7tI88
         1NqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784240925; x=1784845725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y4g3hX9kwv1LG4AWh7Eb8rRRUHNBzvOmYbs7dqFRKrU=;
        b=dSetqGiskJdJwYslfss1/tD/XF51tSxRFtWyVVQPDlj0fHHUHmKHlbbHBd+94+KLry
         agzgxOztZnarhIn6LFS9YHcF9BDF27YhWhIvBVZ0JHYMvKFblPHMSD0XMKCbj3Kp70x4
         8GhnclokJS2iKuF3WfIFnO9XM8Q2Pst1sEz9NOb5WgKDCKsVXdoouvxWqwUPJhfrSUzD
         V/OAlmqJ3kMxsJGEXeR+JSxm6wL7KYAUkVrtSulAktmn/zfqbI+VSn+cxtx7bZdPLuop
         YjwYs02AtVlbaPJLGRLJVCgizDjxJV63zk/k13vroPEAzfZPM0OrVsQVZuelDo8qJC4x
         lhTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784240925; x=1784845725;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y4g3hX9kwv1LG4AWh7Eb8rRRUHNBzvOmYbs7dqFRKrU=;
        b=iYSz2Ml/6qKdnJtLtSz/WuffVDTSHAlsv9FIXdA+gliTgm3kffIL47CEnkk6iaQrUL
         U59K9jtkfdPzApDzzObaZnkaxI87Qu9iM9Xiwl3ngruePKJPK6NhQmlkJ33AkiIXmjZE
         XNsmKfXhi8q1zYzvaTbeyld5NAMVQIVzeHSmn9FvId4BFfRPzLVvaH1Q8Yqu+juh+GDC
         A21vWMGz/tzBclGaLZ8Jb+Di8r60VGtG8DrGpzeBBfjsBsp8HCXJBhtLqLln9nQTBTHV
         7sTR6owH81gD+lXtsTpcST+1WB1E1K5OVFARs9Klo2x+341xQ54ii9ozduRk6escb6Oo
         5nsg==
X-Forwarded-Encrypted: i=1; AHgh+RoYV5g9w2rRr39JZstUECMj2iQWzcNhjUFx8ARiSMGVXMqB+84KN29j9vqZh3c5ToYxFZa9apz5E5Fga7CL@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+QYAedzzxKQSF/bskOHN4+JahCaTIpyBPYFzWKKcC2IUjoXx+
	Ca2yp8Wjjk24nxMHbTAAm0sUFsCOd5gvTyyC/GcN9FT4tqUeE+4SBY6WE9ePP5rTK2r5IlB+XJC
	/YXSKg/yBZrrsdKwTFnTS5ICgPgX6478=
X-Gm-Gg: AfdE7ck0ixATHK3fE4jVVXWaHfU+17p7X/2CehHGORcA+4pO6x/0J9jDW3O7ohXdS9W
	3booCwHypXrdgrA8Yl/G5hbQMxLTDr7ScuRjLvyStuN1lyQXE2d6DG1KXlQnw9FkY2gm51hvBAT
	PO1+9S4W5/KDUSxtlXbZmTe8kFzGwlWzInMhCwXaTtRuhPmwEIVnzLV8hq9MBEdS1h7lefDMHdP
	aZ8E9NG2so1+Yac+5nFt9xI2NcbpX2gxeFRoN+8408j019v3fmFOxlO9LfElTw=
X-Received: by 2002:a05:6512:3f14:b0:5ae:be77:44bc with SMTP id
 2adb3069b0e04-5b28f855ba9mr16942e87.4.1784240924521; Thu, 16 Jul 2026
 15:28:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716024640.13396-1-linkinjeon@kernel.org> <20260716024640.13396-6-linkinjeon@kernel.org>
In-Reply-To: <20260716024640.13396-6-linkinjeon@kernel.org>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 17 Jul 2026 07:28:31 +0900
X-Gm-Features: AUfX_mzo8ufpztJCsPoHqaOj_Q_a4qhA1ZcnM4PGnuZvkNbyplUZqoSjp_daTnU
Message-ID: <CANFS6bbPxFJw1vBD_16AfAGFONMPBh7Uk6roDBnuxZmo_tKP8w@mail.gmail.com>
Subject: Re: [PATCH] ntfs: use pagecache_isize_extended() on size extension
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 16=EC=9D=BC (=EB=AA=A9) =EC=98=A4=EC=A0=84 11:47, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When extending file size, call truncate_pagecache() first, then update
> i_size, and use pagecache_isize_extended() instead of manual
> iomap_zero_range(). This ensures the straddling folio is properly marked
> RO so page_mkwrite() is called and post-EOF area is zeroed.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/file.c | 28 ++++++++++------------------
>  1 file changed, 10 insertions(+), 18 deletions(-)
>
> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> index 9061f8f77f7e..c8e49f83fd92 100644
> --- a/fs/ntfs/file.c
> +++ b/fs/ntfs/file.c
> @@ -268,23 +268,19 @@ static int ntfs_setattr_size(struct inode *vi, stru=
ct iattr *attr)
>                 return err;
>
>         inode_dio_wait(vi);
> -       truncate_setsize(vi, attr->ia_size);
> +       if (attr->ia_size > old_size) {
> +               truncate_pagecache(vi, old_size);
> +               i_size_write(vi, attr->ia_size);
> +               pagecache_isize_extended(vi, old_size, attr->ia_size);
> +       } else
> +               truncate_setsize(vi, attr->ia_size);
> +
>         err =3D ntfs_truncate_vfs(vi, attr->ia_size, old_size);
>         if (err) {
>                 i_size_write(vi, old_size);
>                 return err;
>         }
>
> -       if (NInoNonResident(ni) && attr->ia_size > old_size &&
> -           old_size % PAGE_SIZE !=3D 0) {
> -               loff_t len =3D min_t(loff_t,
> -                               round_up(old_size, PAGE_SIZE) - old_size,
> -                               attr->ia_size - old_size);
> -               err =3D iomap_zero_range(vi, old_size, len,
> -                               NULL, &ntfs_seek_iomap_ops,
> -                               &ntfs_iomap_folio_ops, NULL);
> -       }
> -
>         return err;
>  }
>
> @@ -1165,13 +1161,9 @@ static long ntfs_fallocate(struct file *file, int =
mode, loff_t offset, loff_t le
>                 filemap_invalidate_unlock(vi->i_mapping);
>         if (!err) {
>                 if (mode =3D=3D 0 && NInoNonResident(ni) &&
> -                   offset > old_size && old_size % PAGE_SIZE !=3D 0) {
> -                       loff_t len =3D min_t(loff_t,
> -                                          round_up(old_size, PAGE_SIZE) =
- old_size,
> -                                          offset - old_size);
> -                       err =3D iomap_zero_range(vi, old_size, len, NULL,
> -                                              &ntfs_seek_iomap_ops,
> -                                              &ntfs_iomap_folio_ops, NUL=
L);
> +                   offset > old_size) {
> +                       truncate_pagecache(vi, old_size);
> +                       pagecache_isize_extended(vi, old_size, offset);
>                 }
>                 NInoSetFileNameDirty(ni);
>                 inode_set_mtime_to_ts(vi, inode_set_ctime_current(vi));
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
