Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412033002AB
	for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 18:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043652; cv=pass; b=orE2zyKewQUR+Yr/nsrSjZSJoSVnuCBbQlLe1q4SGwEP02wEmMvxdbJ5DAObgFbGqbCGWAm5Dsr6tvcxSbV4LzmuCwHpjLf5Y4bX9UV37cp/VaZt0hD0Gb5jtbcUCELMTQIZgOapftZLrLCy/3ngtbo+0t/2rvzZdqD7KjHQCWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043652; c=relaxed/simple;
	bh=X/N8WZtZkrwwEMzZKETROxlzBeCe0DBYSY23QMvHHsU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tZ5E/E8aAF/tIFJL+I9jfxmKyd2v3rbpyBz/pCyCN1RhEc0tSQJtXEnoKJpmfW3OLI3Zl2+a+v5IU2SUDZnLPyGpvBLsQslkIXBF5ubvgoYiYGVIQgTIJTL0mIJAyIfLSFW45mDXTDqxghgrRzPyyH4AtdgRGOQUa3vzsIA7x2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com; spf=pass smtp.mailfrom=skydio.com; dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b=DltF9NND; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=skydio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=skydio.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=skydio.com header.i=@skydio.com header.b="DltF9NND"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7c23248f3a3so8578267b3.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 17 May 2026 11:47:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779043646; cv=none;
        d=google.com; s=arc-20240605;
        b=JvRSkb3Xztw3zL5QjQplkWScynbOk9KV9EBLYAGDbFZf3JljlgECSiF8TEp9zuDcw5
         o/YfOCIDedIqMxsimSDgGSQdCNOxE1khRSW1Oo9nVv/G/r4UZwcAaZT359FRL4rbWklh
         Eh1qjsN6BuvIeDHWIwZVm5wUhq/PjYB5hk69w674mlSBbqN02jqyXJ20m5DOQqYonN3/
         0YccPzsp1M401hXW+KME7JRxNK3De7oA1W2sk1ONm4ulkNpFXnFH8yd+5367WeLodDv1
         W3/hEwemqeWyhRSgCDArMbvSXhq5xZQyZIJITnoC9DaIzv821sSWX0ILHQyVDqYPJZ1k
         sd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rYgr9i3chJZeO1c7PqD61SUi4PZ/NkTCB1FGLsb1fHw=;
        fh=yvVpoD4m4ONiG9Bk6vDT8mruprHNPexjYRCIqNNKjpc=;
        b=f+bYljQ7cQL3xz2xyWDhFMvx33npdkkiY4E2a0o31A3xu90Wac9HQJymF29qJcD557
         46T4wj6xYMt4Q6I6xrDBSjYoiDOPJFPgZmEKqYloUZdIrJ3ZnMzcOVeqzVrtvOt8ACVe
         ZvETSYJ3pZCZXA9Ts67IDIJiR95qWIJ/T6mDK/lPWWG01YlwdbRuuL2cRFZ4orXnPHF1
         PhjErcGCZqVtUNX4YjVh2fFWJK3zhI4gnEkQBE0pNwLyOMrivJtOnUlmcbnAJmg3YJwb
         pIPQkui9cWtAj3FiZWEtrFC50th4uaTEhwLUYau5fjP+l+BNTDxG79Zab8BhKLUmqEw1
         cY1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google; t=1779043646; x=1779648446; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rYgr9i3chJZeO1c7PqD61SUi4PZ/NkTCB1FGLsb1fHw=;
        b=DltF9NNDIE/Q3jN3aJBT2Y0IysL9nGN0s59rIN/s+WVcyMikZ6JWyu4hvvYvthV5Vs
         BKsDJ7fTzhIFbhmyuFSvxD+ZOTpJWd8BuaSOwx81Y9rQI2CTYHLmDK+q90E/m+R0zFwu
         zxA3krxOl0CPdIeKFTjcGazkwLqaA97DUjz6SBd0+5XyDQ+I7i2yj7l2O3L+CL1gywRS
         NR/ymbCasItUo8IvS2hOAtkzOZ4JUBRknX1CiGgo9s6KPHhJx99uUaPMulBScxTL2cKG
         eKzOFdyBo/DXK9doXV+p0e8VW0VxFz0NOJJUCG/ldiMyu2ndIzd2a/HYSaG0QtZ80kIA
         9EMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779043646; x=1779648446;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rYgr9i3chJZeO1c7PqD61SUi4PZ/NkTCB1FGLsb1fHw=;
        b=mMISZ1NT8DEOzwRV7GBQcGWXpDZp0kyHG1G4wTjX+ZlZG+2udGbQMo6Xq0GHr7V/F4
         sF2bs1LHO/QXvGzyRK9Xm+MonsI0hbgY/PS40HkoMFO56MhHD3NUy/7UZVJxyhQdC4xf
         26mUAEEN0pQXH/dRFr/K5uFCymKGKdTCsAzb00M6CVXZnbcu/23vWYBM+Jidfx2r3Vir
         MWw2qoXIH0/6B0M0hp9gPx5PhKRFVxunY/AoKz+2C/JsGFrMx0LelRE3FF7Ox2A6EmNm
         SOmzHOrqt1pRgeBrGvPbPpd+jcOECrACTLE5VHeUBSfMJj6xw47yyF4kHpucgxuSW8g0
         ASoQ==
X-Gm-Message-State: AOJu0Yxm7P5eYY+/rdnFPYF+CCFO5uH6yqldLCcVDSWnmCTJv+Ps2WPQ
	yPJ/O0ByKXfAjW54Kz1BiNnUCNaasLPho8InG10sWptF4dyk8EcS6EkDJ3pdGHBsOr4keW07z1x
	0B++eGxkS6pnFJompVwRuYnhIHUXiimzj3keleFrsCxtS7nM/jqPr42eg0A==
X-Gm-Gg: Acq92OGbk09Wtndbp1W7hOV9DrUtRRrFNzNsoKszHxdvjRs0dzPo0Y9UNARcCkqQ95v
	3Y69UIjj9e7cKGu1Flfznh4NrU9owVA0qzP7B4ssyJIlMtPkJc87/0fQgmcJmmrQ9PxFnWtN90s
	iA2QuCzAh5u+L++eH37PjxksYe5TtqpqhsEoqxG1if7C+zFXyrpjt5bno+PelyewFlEVWk/XlQZ
	aluNDN0KR5xrXIRPstfFhyLBe44L/6PNioDN9sYn9BxWJ52bthVDiHRpNi/CgSRcAi0qu/jOumh
	99Hwwb/SrFoZSORJzA==
X-Received: by 2002:a05:690c:6d84:b0:7bd:a4dc:c26d with SMTP id
 00721157ae682-7c95c9ed858mr134828597b3.41.1779043646389; Sun, 17 May 2026
 11:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKYAXd8z00CwRgbQbU8U15svgyOT6RK4XH-xcaq7k3dBbsRqew@mail.gmail.com>
 <20260517184141.21939-1-rochan.avlur@skydio.com>
In-Reply-To: <20260517184141.21939-1-rochan.avlur@skydio.com>
From: Rochan Avlur <rochan.avlur@skydio.com>
Date: Sun, 17 May 2026 11:47:15 -0700
X-Gm-Features: AVHnY4I4qQ5HuzLMrIf9wIDBPnuWxN3eCSQK2nw-MKV5cRthUNGcMPft-r81RPI
Message-ID: <CAG7tbBXOMLQKoRFn1RJub5xoEVz6GCCAc_S1bvDXaasqf66NYw@mail.gmail.com>
Subject: Re: [PATCH v2] exfat: preserve benign secondary entries during rename
 and move
To: linux-fsdevel@vger.kernel.org
Cc: linkinjeon@kernel.org, sj1557.seo@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Updated regression test (xfstests exfat/001):
https://github.com/rochan-avlur-skydio/xfstests/commit/47aac43778fd3e96566a=
ec528999652e3bb01eac

Tests both same-directory rename (exfat_rename_file) and
cross-directory move (exfat_move_file). Passes with the patch, fails
without it.


On Sun, May 17, 2026 at 11:42=E2=80=AFAM Rochan Avlur <rochan.avlur@gmail.c=
om> wrote:
>
> Commit 8258ef28001a ("exfat: handle unreconized benign secondary
> entries") added cluster freeing for benign secondary entries inside
> exfat_remove_entries().  However, exfat_remove_entries() is also called
> from the rename and move paths (exfat_rename_file and exfat_move_file),
> where the old entry set is being relocated rather than deleted.  This
> causes benign secondary entries such as vendor extension entries to be
> silently destroyed on rename or cross-directory move, violating the
> exFAT spec requirement (section 8.2) that implementations preserve
> unrecognized benign secondary entries.
>
> Fix this by introducing exfat_remove_entries_nofree() that marks entries
> as deleted without freeing benign secondary clusters, and helper
> functions to count and copy trailing benign secondary entries from the
> old entry set to the new one.  Both exfat_rename_file() and
> exfat_move_file() now use these to preserve extra entries across
> relocation.
>
> Fixes: 8258ef28001a ("exfat: handle unreconized benign secondary entries"=
)
> Link: https://lore.kernel.org/linux-fsdevel/CAG7tbBV--waov7XVu2FHQEc6paR9=
2dufS=3Dem9DW5Kzsrpu3iQg@mail.gmail.com/
> Signed-off-by: Rochan Avlur <rochan.avlur@skydio.com>
> ---
> v2: Resend with whitespace intact. v1 was mangled by Gmail's plain-text
>     mode stripping leading whitespace from the diff. No code changes.
>     Apologies for the noise.
>
>  fs/exfat/dir.c      |  14 ++++++
>  fs/exfat/exfat_fs.h |   1 +
>  fs/exfat/namei.c    | 102 +++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 107 insertions(+), 10 deletions(-)
>
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index 3045a58e1..1894f839e 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -523,6 +523,20 @@ void exfat_remove_entries(struct inode *inode, struc=
t exfat_entry_set_cache *es,
>                 es->modified =3D true;
>  }
>
> +void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int o=
rder)
> +{
> +       int i;
> +       struct exfat_dentry *ep;
> +
> +       for (i =3D order; i < es->num_entries; i++) {
> +               ep =3D exfat_get_dentry_cached(es, i);
> +               exfat_set_entry_type(ep, TYPE_DELETED);
> +       }
> +
> +       if (order < es->num_entries)
> +               es->modified =3D true;
> +}
> +
>  void exfat_update_dir_chksum(struct exfat_entry_set_cache *es)
>  {
>         int chksum_type =3D CS_DIR_ENTRY, i;
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 176fef625..9b6dd3dab 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -500,6 +500,7 @@ void exfat_init_ext_entry(struct exfat_entry_set_cach=
e *es, int num_entries,
>                 struct exfat_uni_name *p_uniname);
>  void exfat_remove_entries(struct inode *inode, struct exfat_entry_set_ca=
che *es,
>                 int order);
> +void exfat_remove_entries_nofree(struct exfat_entry_set_cache *es, int o=
rder);
>  void exfat_update_dir_chksum(struct exfat_entry_set_cache *es);
>  int exfat_calc_num_entries(struct exfat_uni_name *p_uniname);
>  int exfat_find_dir_entry(struct super_block *sb, struct exfat_inode_info=
 *ei,
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index dfe957493..8c33d9dfb 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -1008,6 +1008,52 @@ static int exfat_rmdir(struct inode *dir, struct d=
entry *dentry)
>         return err;
>  }
>
> +/*
> + * Count benign secondary entries beyond the filename entries.
> + * Returns the count, or -EIO if the entry set is inconsistent.
> + */
> +static int exfat_count_extra_entries(struct exfat_entry_set_cache *es)
> +{
> +       struct exfat_dentry *stream;
> +       unsigned int name_entries;
> +       int extra;
> +
> +       stream =3D exfat_get_dentry_cached(es, ES_IDX_STREAM);
> +       name_entries =3D EXFAT_FILENAME_ENTRY_NUM(stream->dentry.stream.n=
ame_len);
> +       extra =3D es->num_entries - (ES_IDX_FIRST_FILENAME + name_entries=
);
> +
> +       return extra >=3D 0 ? extra : -EIO;
> +}
> +
> +/*
> + * Copy benign secondary entries from @src_es to @dst_es, placing them a=
fter
> + * the new filename entries.  Updates num_ext and the directory checksum=
.
> + */
> +static int exfat_copy_trailing_entries(struct exfat_entry_set_cache *src=
_es,
> +               struct exfat_entry_set_cache *dst_es)
> +{
> +       struct exfat_dentry *ep;
> +       int extra =3D exfat_count_extra_entries(src_es);
> +       int new_entries =3D dst_es->num_entries - extra;
> +       int i, src_start =3D src_es->num_entries - extra;
> +
> +       if (extra =3D=3D 0)
> +               return 0;
> +       if (extra < 0 || new_entries < ES_IDX_FIRST_FILENAME ||
> +           src_start < ES_IDX_FIRST_FILENAME)
> +               return -EIO;
> +
> +       for (i =3D 0; i < extra; i++) {
> +               *exfat_get_dentry_cached(dst_es, new_entries + i) =3D
> +                       *exfat_get_dentry_cached(src_es, src_start + i);
> +       }
> +
> +       ep =3D exfat_get_dentry_cached(dst_es, ES_IDX_FILE);
> +       ep->dentry.file.num_ext +=3D extra;
> +       exfat_update_dir_chksum(dst_es);
> +       return 0;
> +}
> +
>  static int exfat_rename_file(struct inode *parent_inode,
>                 struct exfat_uni_name *p_uniname, struct exfat_inode_info=
 *ei)
>  {
> @@ -1016,6 +1062,8 @@ static int exfat_rename_file(struct inode *parent_i=
node,
>         struct super_block *sb =3D parent_inode->i_sb;
>         struct exfat_entry_set_cache old_es, new_es;
>         int sync =3D IS_DIRSYNC(parent_inode);
> +       unsigned int num_old_name_entries, num_new_name_entries;
> +       unsigned int num_extra_entries, num_total_entries;
>
>         if (unlikely(exfat_forced_shutdown(sb)))
>                 return -EIO;
> @@ -1023,21 +1071,34 @@ static int exfat_rename_file(struct inode *parent=
_inode,
>         num_new_entries =3D exfat_calc_num_entries(p_uniname);
>         if (num_new_entries < 0)
>                 return num_new_entries;
> +       num_new_name_entries =3D EXFAT_FILENAME_ENTRY_NUM(p_uniname->name=
_len);
>
>         ret =3D exfat_get_dentry_set_by_ei(&old_es, sb, ei);
> -       if (ret) {
> -               ret =3D -EIO;
> -               return ret;
> -       }
> +       if (ret)
> +               return -EIO;
>
>         epold =3D exfat_get_dentry_cached(&old_es, ES_IDX_FILE);
>
> -       if (old_es.num_entries < num_new_entries) {
> +       ret =3D exfat_count_extra_entries(&old_es);
> +       if (ret < 0)
> +               goto put_old_es;
> +       num_extra_entries =3D ret;
> +       num_total_entries =3D num_new_entries + num_extra_entries;
> +       /* needed to detect whether in-place rename would shift extras */
> +       num_old_name_entries =3D
> +               old_es.num_entries - ES_IDX_FIRST_FILENAME - num_extra_en=
tries;
> +
> +       /*
> +        * Relocate when the old slot is too small, or when extra
> +        * entries exist and the name entry count changes.
> +        */
> +       if (old_es.num_entries < num_total_entries ||
> +           (num_extra_entries && num_old_name_entries !=3D num_new_name_=
entries)) {
>                 int newentry;
>                 struct exfat_chain dir;
>
>                 newentry =3D exfat_find_empty_entry(parent_inode, &dir,
> -                               num_new_entries, &new_es);
> +                               num_total_entries, &new_es);
>                 if (newentry < 0) {
>                         ret =3D newentry; /* -EIO or -ENOSPC */
>                         goto put_old_es;
> @@ -1056,11 +1117,15 @@ static int exfat_rename_file(struct inode *parent=
_inode,
>
>                 exfat_init_ext_entry(&new_es, num_new_entries, p_uniname)=
;
>
> +               ret =3D exfat_copy_trailing_entries(&old_es, &new_es);
> +               if (ret)
> +                       goto put_old_es;
> +
>                 ret =3D exfat_put_dentry_set(&new_es, sync);
>                 if (ret)
>                         goto put_old_es;
>
> -               exfat_remove_entries(parent_inode, &old_es, ES_IDX_FILE);
> +               exfat_remove_entries_nofree(&old_es, ES_IDX_FILE);
>                 ei->dir =3D dir;
>                 ei->entry =3D newentry;
>         } else {
> @@ -1069,8 +1134,13 @@ static int exfat_rename_file(struct inode *parent_=
inode,
>                         ei->attr |=3D EXFAT_ATTR_ARCHIVE;
>                 }
>
> -               exfat_remove_entries(parent_inode, &old_es, ES_IDX_FIRST_=
FILENAME + 1);
> +               exfat_remove_entries_nofree(&old_es,
> +                               num_new_entries + num_extra_entries);
>                 exfat_init_ext_entry(&old_es, num_new_entries, p_uniname)=
;
> +               if (num_extra_entries) {
> +                       epold->dentry.file.num_ext +=3D num_extra_entries=
;
> +                       exfat_update_dir_chksum(&old_es);
> +               }
>         }
>         return exfat_put_dentry_set(&old_es, sync);
>
> @@ -1086,6 +1156,7 @@ static int exfat_move_file(struct inode *parent_ino=
de,
>         struct exfat_dentry *epmov, *epnew;
>         struct exfat_entry_set_cache mov_es, new_es;
>         struct exfat_chain newdir;
> +       unsigned int num_extra_entries, num_total_entries;
>
>         num_new_entries =3D exfat_calc_num_entries(p_uniname);
>         if (num_new_entries < 0)
> @@ -1095,8 +1166,14 @@ static int exfat_move_file(struct inode *parent_in=
ode,
>         if (ret)
>                 return -EIO;
>
> +       ret =3D exfat_count_extra_entries(&mov_es);
> +       if (ret < 0)
> +               goto put_mov_es;
> +       num_extra_entries =3D ret;
> +       num_total_entries =3D num_new_entries + num_extra_entries;
> +
>         newentry =3D exfat_find_empty_entry(parent_inode, &newdir,
> -                       num_new_entries, &new_es);
> +                       num_total_entries, &new_es);
>         if (newentry < 0) {
>                 ret =3D newentry; /* -EIO or -ENOSPC */
>                 goto put_mov_es;
> @@ -1115,7 +1192,12 @@ static int exfat_move_file(struct inode *parent_in=
ode,
>         *epnew =3D *epmov;
>
>         exfat_init_ext_entry(&new_es, num_new_entries, p_uniname);
> -       exfat_remove_entries(parent_inode, &mov_es, ES_IDX_FILE);
> +
> +       ret =3D exfat_copy_trailing_entries(&mov_es, &new_es);
> +       if (ret)
> +               goto put_mov_es;
> +
> +       exfat_remove_entries_nofree(&mov_es, ES_IDX_FILE);
>
>         ei->dir =3D newdir;
>         ei->entry =3D newentry;
> --
> 2.45.2
>
