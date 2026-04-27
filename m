Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C295149C7B
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Apr 2026 00:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777248641; cv=pass; b=W+PojzIPwvlOH66Kf+f/1yAfCCr4G4YIYaMF8/c8IXjcbNp8eCL1rGg4Y0ovyHRvZaZThgz6bSyB8iAnozwTicm4oclHrJm55xFZ6AO8+pfmTZ53IiX2v2NRI00FQlUGgSkaJMaSc/tPh1ngWz1fskKS0GDyLyllsR5x5kZ30n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777248641; c=relaxed/simple;
	bh=MHTVAJv6FlMpGvRAwYwT9xDNR8SkKPgAojjNoi07w4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AsN+JREofd5W4neBVgc4do1fVfm/5PV+a6ZdpEzw1SMrsCsrGJRGrUOz3lFd78/HDuX59NcLtLTbycx7AiZrOeZZObaa9uN80UEq9I64vytQvEsG9zznvF962Irdb3MTYU9GF59EZ+moNwLRJcIYTyDC3bRa00zUsXq4Mfo9nc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIvkddrq; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIvkddrq"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5a2c500750dso10709887e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Apr 2026 17:10:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777248638; cv=none;
        d=google.com; s=arc-20240605;
        b=H4KhcBaSYPMug+ENUvZScW/lUBcFm7Ex+J2qfp0Z4Ncr+S8vwJz3Q+/qsbmbiAVQWF
         2oh9OvEqcdka14SIUORvDg0LNhFWOKUCEPiXfKG3LpaCXAl9+TDDM4UR5B6m9f1HUmm+
         ocIkEcAauUBgJuuBzDSCbC4MlG7PGzDbc/LgD6Jctcrv1DN3i9fk6Kp9/qjoOs6HavRD
         mLMDMcbzMp5v9RBBNc8LaD1YUefQwHiGsUpobeeyGKSAKab8u7yVmFrJ5QBQgMUM8hwK
         nRCpbqKJfpB/pTljutjTYuTMfycW2Brr0NqDQHUUuxYXzWnuMHepE853qSBKl+7nL6x9
         BbWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mKp47mgGQeukavo3+uQ/EV+Ph3dbIu5QR2SgCaoFgIM=;
        fh=m8TMeprvXKpltQwC/Zn58FnQJnMKszdY6fY3tFphBdA=;
        b=R38TvBU8160/fbB5lpfwgroFvgLT0Jgzt3HW8WVLjlObIv9zIrTAZT/FaC7darDlro
         4rkcrSubiHxXb+C3eXqhdAdKIXuN2CgnnD7O5H1/mB1DddwYqKyQKDoovN8jn/YspKSu
         O6LpBdVwWbNw+ub8RmsBOiJbSpKKTi+DwIqizkgZefXiEq03xz1h2UGyhj9cN9HLk8Fu
         u7hl41SzGTVSnr6s+BExrInozOOAhlU9wsjCpuA4ONcEt/7nuYQybUj66ie46oyKKweG
         mJI0qNH93Vl5CQ8Rws30ONu70MTFYZvyMwk0ljeszS0DyBIsIycjtmaDTacqXwMKXKA9
         3WEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777248638; x=1777853438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKp47mgGQeukavo3+uQ/EV+Ph3dbIu5QR2SgCaoFgIM=;
        b=YIvkddrqkAFO8GPLuTNVxvB+9/GMMsCQUf1TjRwVpr20gIm2oMj63yOKmhnp32bkei
         UW9m4D5wpW3C8KxrHzqf69IjWKsqF7isQPChOx+HQaNKCrU++wS/rrOWAR6xUyKGVApJ
         oq8C2Bs9fHzFuFr9xuqPucdZOo1KhpyH4OWoLpeZ+MYFBtpjBg7EDf5filnYHsd2Z459
         PFw11+2SQvky9WqptyJoKeF29A2rjxgFuZUyUZK11GcwW7Q19Z6OsPcxFY50YcATRT6t
         nOGiQjiWoyaUwvuZtuRJ4L4mzWZ9atcaZDrAd7gtDwlE39QtOWORcZGgsb5gK3yDjynI
         lTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777248638; x=1777853438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mKp47mgGQeukavo3+uQ/EV+Ph3dbIu5QR2SgCaoFgIM=;
        b=aU5wgJ5a1+KzXZx4IUhOHbBEeI+WTYMeRYEMcYwiPoXnnolNZRa5QTGROVADsUcxlk
         N/w/3XfJmjpqqbToh9e6Ln1ZI1ZvoDInasdQdS6xRXcaPw0HuKFF0fIVJrvC7aD4anpj
         yWSzTfkmGNaym1drtE/w43NUKvb7BNpHEPI8k6NuaEUrPBjB1/dwUpoS/0yycOIR3ukY
         uasUf982NQHmRmZQs02R9yUxP1uK5e0RoA4xzlmLwlYxq1il1Rex9VAp9+VNk9wdZ2zQ
         kBJ19t6ImObplQFyZzKR+wfR3iib2V10jlA3/QgVRKlgy0JbiAdtkT5RLinMYSQpIsRa
         T4Yg==
X-Forwarded-Encrypted: i=1; AFNElJ+A3+e0Mr/32Q9hAJi26hFNFopkK4z+KtZJIDaK5KM4knFiH8+Tz6XrofAGwg9LuSfkz2h3Sgjdz6N2V3XW@vger.kernel.org
X-Gm-Message-State: AOJu0YyioMRibGXxaKj7Ay3hrALtnj+mmJE6t1nbu6k2ifSVrx28m0JN
	VuZZA008qwt57A885kjR2ohBkUCITrFVnAkGRCIfhx/zGNz17sS0kgl5KphXse1Nzw7O8DW4Vao
	b8bPjW4RTL8L9IKZO2p/KnidgJouV7JYql7Ih
X-Gm-Gg: AeBDiesMi726f33/luAfqbd+84olwP2l/li4hUliKHsM4Iq5d9xjJ/ENj8iArTzpTUF
	Qmu9Mls/N4WRn3FTaDf5uUmp3CrQitoQnFPdmHjubv6aLqTODvyOSz4dnhcty7ooAzcrvZ3hQ+v
	/5q4uPY2SaGIMkhX+Gzc3dvirWcL5mTRtg937LM35vMECnXNKHvMuztxDMiOudqOvBrtqadkSz/
	EaLh1IyEvQbugtygqEFPJBQJTBXoC51tzSqYMP2TeRInH2puyav++T4MQ7UD40BQgEzUMtmyoAx
	pjyG4TvzPXz3YqNXBg==
X-Received: by 2002:a05:6512:39c8:b0:5a4:1145:ce6f with SMTP id
 2adb3069b0e04-5a41717fdc8mr10877057e87.0.1777248638053; Sun, 26 Apr 2026
 17:10:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777175371.git.charsyam@gmail.com> <411dcca8f8b760bf9744a2b590becaf3fb871d84.1777175371.git.charsyam@gmail.com>
In-Reply-To: <411dcca8f8b760bf9744a2b590becaf3fb871d84.1777175371.git.charsyam@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 27 Apr 2026 09:10:26 +0900
X-Gm-Features: AVHnY4KSDH5bPuSV-jSgfNbypPO8v9mlQUxMDofWXcL0LGKg9GID2x2wkCBwIfU
Message-ID: <CANFS6baKRDSdKe9v+5N2u_nKGKtrasaBJSTk4LjOS7cGRFY8YQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ntfs: fix NULL dereference in ntfs_index_walk_down()
To: DaeMyung Kang <charsyam@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 4=EC=9B=94 26=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 1:02, D=
aeMyung Kang <charsyam@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_index_walk_down() allocates ictx->ib when descending from the root
> into an index allocation block. If that allocation fails, the old code
> still passes the NULL buffer to ntfs_ib_read(), which can write through
> it via ntfs_inode_attr_pread().
>
> Allocate the index block into a temporary pointer and return -ENOMEM
> before changing the index context on allocation failure. Also propagate
> ERR_PTR() through ntfs_index_next() and ntfs_readdir() so walk-down
> allocation or index block read failures are not mistaken for normal
> index iteration inside the filesystem.
>
> ntfs_readdir() keeps the existing userspace-visible behavior of
> suppressing readdir errors after marking end_in_iterate; this change only
> prevents the walk-down failure path from dereferencing NULL internally.
>
> The failure was reproduced with failslab fail-nth injection on getdents64=
;
> the original module hits a NULL pointer dereference in memcpy_orig throug=
h
> ntfs_ib_read(), while the patched module reaches the same
> ntfs_index_walk_down() allocation failure without crashing.
>
> Fixes: 0a8ac0c1fa0b ("ntfs: update directory operations")
> Signed-off-by: DaeMyung Kang <charsyam@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/dir.c   | 13 ++++++++++---
>  fs/ntfs/index.c | 17 +++++++++++++----
>  2 files changed, 23 insertions(+), 7 deletions(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index bfa904d2ce66..20f5c7074bdd 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -911,8 +911,8 @@ static int ntfs_readdir(struct file *file, struct dir=
_context *actor)
>
>         if (next->flags & INDEX_ENTRY_NODE) {
>                 next =3D ntfs_index_walk_down(next, ictx);
> -               if (!next) {
> -                       err =3D -EIO;
> +               if (IS_ERR(next)) {
> +                       err =3D PTR_ERR(next);
>                         goto out;
>                 }
>         }
> @@ -920,7 +920,14 @@ static int ntfs_readdir(struct file *file, struct di=
r_context *actor)
>         if (next && !(next->flags & INDEX_ENTRY_END))
>                 goto nextdir;
>
> -       while ((next =3D ntfs_index_next(next, ictx)) !=3D NULL) {
> +       while (1) {
> +               next =3D ntfs_index_next(next, ictx);
> +               if (IS_ERR(next)) {
> +                       err =3D PTR_ERR(next);
> +                       goto out;
> +               }
> +               if (!next)
> +                       break;
>  nextdir:
>                 /* Check the consistency of an index entry */
>                 if (ntfs_index_entry_inconsistent(ictx, vol, next, COLLAT=
ION_FILE_NAME,
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 2080f3969137..a547bdcfa456 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -1969,15 +1969,19 @@ int ntfs_index_remove(struct ntfs_inode *dir_ni, =
const void *key, const u32 keyl
>  struct index_entry *ntfs_index_walk_down(struct index_entry *ie, struct =
ntfs_index_context *ictx)
>  {
>         struct index_entry *entry;
> +       struct index_block *ib;
>         s64 vcn;
>
>         entry =3D ie;
>         do {
>                 vcn =3D ntfs_ie_get_vcn(entry);
>                 if (ictx->is_in_root) {
> +                       ib =3D kvzalloc(ictx->block_size, GFP_NOFS);
> +                       if (!ib)
> +                               return ERR_PTR(-ENOMEM);
>                         /* down from level zero */
>                         ictx->ir =3D NULL;
> -                       ictx->ib =3D kvzalloc(ictx->block_size, GFP_NOFS)=
;
> +                       ictx->ib =3D ib;
>                         ictx->pindex =3D 1;
>                         ictx->is_in_root =3D false;
>                 } else {
> @@ -1991,8 +1995,8 @@ struct index_entry *ntfs_index_walk_down(struct ind=
ex_entry *ie, struct ntfs_ind
>                         ictx->entry =3D ntfs_ie_get_first(&ictx->ib->inde=
x);
>                         entry =3D ictx->entry;
>                 } else
> -                       entry =3D NULL;
> -       } while (entry && (entry->flags & INDEX_ENTRY_NODE));
> +                       entry =3D ERR_PTR(-EIO);
> +       } while (!IS_ERR(entry) && (entry->flags & INDEX_ENTRY_NODE));
>
>         return entry;
>  }
> @@ -2097,10 +2101,15 @@ struct index_entry *ntfs_index_next(struct index_=
entry *ie, struct ntfs_index_co
>
>                 /* walk down if it has a subnode */
>                 if (flags & INDEX_ENTRY_NODE) {
> -                       if (!ictx->ia_ni)
> +                       if (!ictx->ia_ni) {
>                                 ictx->ia_ni =3D ntfs_ia_open(ictx, ictx->=
idx_ni);
> +                               if (!ictx->ia_ni)
> +                                       return ERR_PTR(-EIO);
> +                       }
>
>                         next =3D ntfs_index_walk_down(next, ictx);
> +                       if (IS_ERR(next))
> +                               return next;
>                 } else {
>
>                         /* walk up it has no subnode, nor data */
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
