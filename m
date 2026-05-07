Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E31D3F65F7
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 May 2026 13:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161281; cv=pass; b=YjapuAj0u6MO61/VmF1ghNMSPW6napgxnnRDzixJVcG2toqQrKAjU5gXqetuoSIdrLP6tWTQNWc2qJUqUmqkaMkPGDdH5zuGK3hJ86jPjvVMxj3qQ+Eqohbu4h+zLZ18kTWfPFGnO+DHG3dr2hvqXBPT/K1ZyNWX7ZS5CQUuIfc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161281; c=relaxed/simple;
	bh=e1EouQRJBS2OpO95N9ZpY7Cmzo5FVl43iVUM+9A455s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L/4taZD9kgvAp0xzCHWHpHCgJeQ/bGGKkpRnuEmtGoAWKiWhcobZXbywMNM0uLDU/Fm48w+HQb3YPzRcy4YAE18xAwhQOlO/VBa8o5DGdtrT1DLMtWUPao+MD/gUz0Kda3fA2Yj96bORigXCNw++KI+0fBKdBd/IguerQ3Ys+yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8iLB0Yz; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8iLB0Yz"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651bc5494b4so96255d50.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 May 2026 06:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778161277; cv=none;
        d=google.com; s=arc-20240605;
        b=Wv9WIOioThutABadSsfY/zsaLmiNHNzRSodWBY8dCKfYHffD1kqy9W1Jy8w+n2uPlu
         S7ZeutfYSE1Fv8wVonnRDIvoDro9EdAzishOOEUU3VHLOg0r/IcvsyOclWJLaOoAVuL9
         fNF9PZAeAkp3fnhm82F7gXBj0QKZkvEwDFXR4lSVchdyKl1XVoyPmckkwW3WdO3lKIbd
         /TL1VH8sB5JCB32f73AJoCqaqngrUGzfxcnAvPOC03+BQKnLATVy6uVoQKfv5JDXvhzm
         Zmb21yr4/Mdn0xpG0EAqlKdclulL3C5oVFDTAtQv8+DB6tguL3rhEipJ6u4hrpzv8Dfp
         18mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9kcV301eTRRKXFEt0889UyrUdzHii+lbJFE7ZtI3XR0=;
        fh=OoNsFFmz76mvuJh5GUT98ViEs7NJbp6X/0ANUZBbpNg=;
        b=S2OTlG9Y6HARVjltBWeaFvlAYwlEPRkM3cbS7OkDlqounLiVkFI1hu5a2EChNDFZap
         +oiEUDjQKquzR/WcPxlCTq2Tb5/Y/q040OJnwWhv5hkRPJwF0Oxq9pa4m7UaQeRe35lw
         aFiwqxwHtVukFOqHKcbXVRR4Sfr7kc01w+Pi8jOJA018VipwQaw0wGzMA8wvt7jaOdpp
         gkXW4xAhDgjjF53im5/9obCMpGhW4cr7fePcZ41COLsAl7eP3BRfsOI2duhTfuPlknrq
         S18kw6ZTLEKr2WiBiFbPfyAqf5rW0t/QrSRqXPj2qG78eGulc6LksZf2WEaFE9XOeu/T
         GgVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778161277; x=1778766077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kcV301eTRRKXFEt0889UyrUdzHii+lbJFE7ZtI3XR0=;
        b=Q8iLB0YzMWsUrOyfM9Lzl4YHfDNDP8fZMkzY0WZ4UBjoxIdOH2YYDEy4c5XOs6BAUB
         f8Ufr/TEUipx06KrCS1nM+OptfnbQaJItZLkD4VAvFdMAK9II+463j7KOysh7I0GeO52
         9nL7tPuuy7N14Jo5xehClfOpoEIbVb2q3sy0sutV8L5wVWtXWsz9rfxATtg6xvRdbe2M
         c0ENjmnGWSE2jkrlqYTtQM8GNBjhRshlzXqf4LANhQUJauJ7nAfGULuULh0icObaoCo2
         hEBRQ6bz2ht1S1+ek0FnwuOspkW4UWeDdY3ig810RBmDtmZbj8fMuyGcH/rmi3Kd3rTG
         EN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778161277; x=1778766077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kcV301eTRRKXFEt0889UyrUdzHii+lbJFE7ZtI3XR0=;
        b=Bo5aOoOPPVsZ7biuyeGruEXrvak7MlrT0Rl30epCtYKfpxKkW6WRptEYRK/jKPLBwP
         rFAJLNSli5XWkWLk/z9FEtHc0SIZkezfEzgduIeI6Ys6EjZbYnm4/VyimEMwtxllMjM+
         iql0+8+PD+pxnK1USj4KHGpiGTAiIepK+aLNBCd3Qb026MhuNOT3cohZFV8fAIlFfEgz
         CJ6Xy1Wt88ZZuJzXEl2tT11H+WWw6fcJjBDOQGjVbcffy85VEVH0Jo44kva9w1g5l41v
         rRcMRD6hO6ClYBjuToMSJ2A35l2oNElKC9ijECYdTpjmAv6e52crOudrJILXcikRM5J2
         PDlA==
X-Forwarded-Encrypted: i=1; AFNElJ+FsDJuJXkv19XKh4oBXJpTu6cuRoMOuzyWeGoFvBYzZ0/C4uloFZCQbpn5Id1OxDiErTmalSvMUPOz1mo2@vger.kernel.org
X-Gm-Message-State: AOJu0YxsbhlRTkKHddZ9vWWQRJDDIgIF/QS21Ly6UDo4hpn4cm5lSy4J
	ZwLmBAPaaiN4gz7jb6ytQywjxUZQMWVlnPWSEQ02hBA5jpsr9aQbsmyLS3VT3APFzqts3ke2hRt
	vjL9w9ZjfMLV8g4TVAeH1jzCezn/bF0w=
X-Gm-Gg: Acq92OFIo1XRzmtHeqUQJUd9CnLtFwE6O+WLJbRwfEOdDzO8C0qINgsmboE2obdZh0z
	ga6rUg/x6zdygyuv8G2Svn7fMdsQieL6YEfpenqcot1cf3tyIXy6/WNG/bpQdUW0QJ16dUaDnX0
	XiuwfimZS6s2a0wkVaVHbqBGb7n31F/AW2jY6kP9oKuwCIP0qgCWsEtQAm0DVrbw8nHFe2ka6sF
	RsavH2vw1AMY/hVJ601PpKTAIoUXDMcquoQC4U5BukNQg78p32JwF7GcFYyylJ1JASJNm7x+BXN
	p7RJIYt6wXPkJV1q5uVvkM+7eIAatHc=
X-Received: by 2002:a05:690e:16a1:b0:65c:391:454f with SMTP id
 956f58d0204a3-65c7ba0f8d2mr4512616d50.7.1778161277035; Thu, 07 May 2026
 06:41:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507124238.7313-1-linkinjeon@kernel.org> <20260507124238.7313-2-linkinjeon@kernel.org>
In-Reply-To: <20260507124238.7313-2-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 7 May 2026 22:41:04 +0900
X-Gm-Features: AVHnY4IJbPnF-XJV2RFrku8rNzOlY7PAl1n5Bqm7ccnBjZtpT4aZZzUn6EEz9lI
Message-ID: <CAMrLSE4570TxqBgTZGz+oAsaVOM-_tbwRro=e4MMGM4aYnwmtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] exfat: replace unsafe macros with static inline functions
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi. Namjae.

in fs/exfat/inode.c

-               inode->i_blocks +=3D EXFAT_CLU_TO_B(num_to_be_allocated,
sbi) >> 9;
+               inode->i_blocks +=3D
+                       exfat_cluster_to_sectors(sbi, num_to_be_allocated) =
>> 9;

exfat_cluster_to_sectors() already returns a 512-byte block count, so
the extra >> 9 makes i_blocks 512 times too small.


2026=EB=85=84 5=EC=9B=94 7=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:44, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> The current exFAT driver relies on various macros for unit conversions
> between clusters, blocks, sectors, and directory entries. These macros
> are structurally unsafe as they lack type enforcement and are prone to
> potential integer overflows during bit-shift operations, especially
> on 64-bit architectures. Replace all arithmetic macros with static inline
> functions to provide strict type checking and explicit casting.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/balloc.c   |   2 +-
>  fs/exfat/dir.c      |  48 ++++++++---------
>  fs/exfat/exfat_fs.h | 122 ++++++++++++++++++++++++++++++++------------
>  fs/exfat/fatent.c   |   4 +-
>  fs/exfat/file.c     |   8 +--
>  fs/exfat/inode.c    |  19 +++----
>  fs/exfat/namei.c    |  26 +++++-----
>  fs/exfat/super.c    |   4 +-
>  8 files changed, 147 insertions(+), 86 deletions(-)
>
> diff --git a/fs/exfat/balloc.c b/fs/exfat/balloc.c
> index 625f2f14d4fe..e66ebf899778 100644
> --- a/fs/exfat/balloc.c
> +++ b/fs/exfat/balloc.c
> @@ -112,7 +112,7 @@ static int exfat_allocate_bitmap(struct super_block *=
sb,
>         }
>
>         if (exfat_test_bitmap_range(sb, sbi->map_clu,
> -               EXFAT_B_TO_CLU_ROUND_UP(map_size, sbi)) =3D=3D false)
> +               exfat_bytes_to_cluster_round_up(sbi, map_size)) =3D=3D fa=
lse)
>                 goto err_out;
>
>         return 0;
> diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
> index ac008ccaa97d..ca9d707220df 100644
> --- a/fs/exfat/dir.c
> +++ b/fs/exfat/dir.c
> @@ -76,7 +76,7 @@ static int exfat_readdir(struct inode *inode, loff_t *c=
pos, struct exfat_dir_ent
>         struct super_block *sb =3D inode->i_sb;
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
>         struct exfat_inode_info *ei =3D EXFAT_I(inode);
> -       unsigned int dentry =3D EXFAT_B_TO_DEN(*cpos) & 0xFFFFFFFF;
> +       unsigned int dentry =3D exfat_bytes_to_dentries(*cpos) & 0xFFFFFF=
FF;
>         struct buffer_head *bh;
>
>         /* check if the given file ID is opened */
> @@ -84,13 +84,13 @@ static int exfat_readdir(struct inode *inode, loff_t =
*cpos, struct exfat_dir_ent
>                 return -EPERM;
>
>         exfat_chain_set(&dir, ei->start_clu,
> -               EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flags);
> +               exfat_bytes_to_cluster(sbi, i_size_read(inode)), ei->flag=
s);
>
>         dentries_per_clu =3D sbi->dentries_per_clu;
> -       max_dentries =3D (unsigned int)min_t(u64, MAX_EXFAT_DENTRIES,
> -                               (u64)EXFAT_CLU_TO_DEN(sbi->num_clusters, =
sbi));
> +       max_dentries =3D min(MAX_EXFAT_DENTRIES,
> +                       exfat_cluster_to_dentries(sbi, sbi->num_clusters)=
);
>
> -       clu_offset =3D EXFAT_DEN_TO_CLU(dentry, sbi);
> +       clu_offset =3D exfat_dentries_to_cluster(sbi, dentry);
>         exfat_chain_dup(&clu, &dir);
>
>         if (clu.flags =3D=3D ALLOC_FAT_CHAIN) {
> @@ -147,10 +147,10 @@ static int exfat_readdir(struct inode *inode, loff_=
t *cpos, struct exfat_dir_ent
>                         dir_entry->dir =3D clu;
>                         brelse(bh);
>
> -                       ei->hint_bmap.off =3D EXFAT_DEN_TO_CLU(dentry, sb=
i);
> +                       ei->hint_bmap.off =3D exfat_dentries_to_cluster(s=
bi, dentry);
>                         ei->hint_bmap.clu =3D clu.dir;
>
> -                       *cpos =3D EXFAT_DEN_TO_B(dentry + 1 + num_ext);
> +                       *cpos =3D exfat_dentries_to_bytes(dentry + 1 + nu=
m_ext);
>                         return 0;
>                 }
>
> @@ -160,7 +160,7 @@ static int exfat_readdir(struct inode *inode, loff_t =
*cpos, struct exfat_dir_ent
>
>  out:
>         dir_entry->namebuf.lfn[0] =3D '\0';
> -       *cpos =3D EXFAT_DEN_TO_B(dentry);
> +       *cpos =3D exfat_dentries_to_bytes(dentry);
>         return 0;
>  }
>
> @@ -465,7 +465,7 @@ static void exfat_free_benign_secondary_clusters(stru=
ct inode *inode,
>                 return;
>
>         exfat_chain_set(&dir, start_clu,
> -                       EXFAT_B_TO_CLU_ROUND_UP(size, EXFAT_SB(sb)),
> +                       exfat_bytes_to_cluster_round_up(EXFAT_SB(sb), siz=
e),
>                         flags);
>         exfat_free_cluster(inode, &dir);
>  }
> @@ -556,10 +556,11 @@ static int exfat_find_location(struct super_block *=
sb, struct exfat_chain *p_dir
>         unsigned int off, clu =3D 0;
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
>
> -       off =3D EXFAT_DEN_TO_B(entry);
> +       off =3D exfat_dentries_to_bytes(entry);
>
>         clu =3D p_dir->dir;
> -       ret =3D exfat_cluster_walk(sb, &clu, EXFAT_B_TO_CLU(off, sbi), p_=
dir->flags);
> +       ret =3D exfat_cluster_walk(sb, &clu, exfat_bytes_to_cluster(sbi, =
off),
> +                       p_dir->flags);
>         if (ret)
>                 return ret;
>
> @@ -567,7 +568,7 @@ static int exfat_find_location(struct super_block *sb=
, struct exfat_chain *p_dir
>                 exfat_fs_error(sb,
>                         "unexpected early break in cluster chain (clu : %=
u, len : %d)",
>                         p_dir->dir,
> -                       EXFAT_B_TO_CLU(off, sbi));
> +                       exfat_bytes_to_cluster(sbi, off));
>                 return -EIO;
>         }
>
> @@ -577,13 +578,13 @@ static int exfat_find_location(struct super_block *=
sb, struct exfat_chain *p_dir
>         }
>
>         /* byte offset in cluster */
> -       off =3D EXFAT_CLU_OFFSET(off, sbi);
> +       off =3D exfat_cluster_offset(sbi, off);
>
>         /* byte offset in sector    */
> -       *offset =3D EXFAT_BLK_OFFSET(off, sb);
> +       *offset =3D exfat_block_offset(sb, off);
>
>         /* sector offset in cluster */
> -       *sector =3D EXFAT_B_TO_BLK(off, sb);
> +       *sector =3D exfat_bytes_to_block(sb, off);
>         *sector +=3D exfat_cluster_to_sector(sbi, clu);
>         return 0;
>  }
> @@ -593,7 +594,7 @@ struct exfat_dentry *exfat_get_dentry(struct super_bl=
ock *sb,
>  {
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
>         unsigned int sect_per_clus =3D sbi->sect_per_clus;
> -       unsigned int dentries_per_page =3D EXFAT_B_TO_DEN(PAGE_SIZE);
> +       unsigned int dentries_per_page =3D exfat_bytes_to_dentries(PAGE_S=
IZE);
>         int off;
>         sector_t sec;
>
> @@ -672,8 +673,8 @@ struct exfat_dentry *exfat_get_dentry_cached(
>         struct exfat_entry_set_cache *es, int num)
>  {
>         int off =3D es->start_off + num * DENTRY_SIZE;
> -       struct buffer_head *bh =3D es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> -       char *p =3D bh->b_data + EXFAT_BLK_OFFSET(off, es->sb);
> +       struct buffer_head *bh =3D es->bh[exfat_bytes_to_block(es->sb, of=
f)];
> +       char *p =3D bh->b_data + exfat_block_offset(es->sb, off);
>
>         return (struct exfat_dentry *)p;
>  }
> @@ -741,7 +742,7 @@ static int __exfat_get_dentry_set(struct exfat_entry_=
set_cache *es,
>
>         es->num_entries =3D num_entries;
>
> -       num_bh =3D EXFAT_B_TO_BLK_ROUND_UP(off + num_entries * DENTRY_SIZ=
E, sb);
> +       num_bh =3D exfat_bytes_to_block_round_up(sb, off + num_entries * =
DENTRY_SIZE);
>         if (num_bh > ARRAY_SIZE(es->__bh)) {
>                 es->bh =3D kmalloc_objs(*es->bh, num_bh, GFP_NOFS);
>                 if (!es->bh) {
> @@ -830,7 +831,7 @@ static int exfat_validate_empty_dentry_set(struct exf=
at_entry_set_cache *es)
>
>  err_used_follow_unused:
>         off =3D es->start_off + (i << DENTRY_SIZE_BITS);
> -       bh =3D es->bh[EXFAT_B_TO_BLK(off, es->sb)];
> +       bh =3D es->bh[exfat_bytes_to_block(es->sb, off)];
>
>         exfat_fs_error(es->sb,
>                 "in sector %lld, dentry %d should be unused, but 0x%x",
> @@ -839,7 +840,8 @@ static int exfat_validate_empty_dentry_set(struct exf=
at_entry_set_cache *es)
>         return -EIO;
>
>  count_skip_entries:
> -       es->num_entries =3D EXFAT_B_TO_DEN(EXFAT_BLK_TO_B(es->num_bh, es-=
>sb) - es->start_off);
> +       es->num_entries =3D
> +               exfat_bytes_to_dentries(exfat_block_to_bytes(es->sb, es->=
num_bh) - es->start_off);
>         for (; i < es->num_entries; i++) {
>                 ep =3D exfat_get_dentry_cached(es, i);
>                 if (IS_EXFAT_DELETED(ep->type))
> @@ -892,7 +894,7 @@ static inline void exfat_set_empty_hint(struct exfat_=
inode_info *ei,
>  {
>         if (ei->hint_femp.eidx =3D=3D EXFAT_HINT_NONE ||
>             ei->hint_femp.eidx > dentry) {
> -               int total_entries =3D EXFAT_B_TO_DEN(i_size_read(&ei->vfs=
_inode));
> +               int total_entries =3D exfat_bytes_to_dentries(i_size_read=
(&ei->vfs_inode));
>
>                 if (candi_empty->count =3D=3D 0) {
>                         candi_empty->cur =3D *clu;
> @@ -1215,7 +1217,7 @@ static int exfat_get_volume_label_dentry(struct sup=
er_block *sb,
>                         es->bh =3D es->__bh;
>                         es->bh[0] =3D bh;
>                         es->num_bh =3D 1;
> -                       es->start_off =3D EXFAT_DEN_TO_B(i) % sb->s_block=
size;
> +                       es->start_off =3D exfat_dentries_to_bytes(i) % sb=
->s_blocksize;
>
>                         return 0;
>                 }
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 89ef5368277f..9c8ab3df7a42 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -84,38 +84,6 @@ enum {
>         (min_t(blkcnt_t, (sb)->s_bdi->ra_pages, (sb)->s_bdi->io_pages) \
>         << (PAGE_SHIFT - (sb)->s_blocksize_bits))
>
> -/*
> - * helpers for cluster size to byte conversion.
> - */
> -#define EXFAT_CLU_TO_B(b, sbi)         ((b) << (sbi)->cluster_size_bits)
> -#define EXFAT_B_TO_CLU(b, sbi)         ((b) >> (sbi)->cluster_size_bits)
> -#define EXFAT_B_TO_CLU_ROUND_UP(b, sbi)        \
> -       (((b - 1) >> (sbi)->cluster_size_bits) + 1)
> -#define EXFAT_CLU_OFFSET(off, sbi)     ((off) & ((sbi)->cluster_size - 1=
))
> -
> -/*
> - * helpers for block size to byte conversion.
> - */
> -#define EXFAT_BLK_TO_B(b, sb)          ((b) << (sb)->s_blocksize_bits)
> -#define EXFAT_B_TO_BLK(b, sb)          ((b) >> (sb)->s_blocksize_bits)
> -#define EXFAT_B_TO_BLK_ROUND_UP(b, sb) \
> -       (((b - 1) >> (sb)->s_blocksize_bits) + 1)
> -#define EXFAT_BLK_OFFSET(off, sb)      ((off) & ((sb)->s_blocksize - 1))
> -
> -/*
> - * helpers for block size to dentry size conversion.
> - */
> -#define EXFAT_B_TO_DEN(b)              ((b) >> DENTRY_SIZE_BITS)
> -#define EXFAT_DEN_TO_B(b)              ((b) << DENTRY_SIZE_BITS)
> -
> -/*
> - * helpers for cluster size to dentry size conversion.
> - */
> -#define EXFAT_CLU_TO_DEN(clu, sbi)     \
> -       ((clu) << ((sbi)->cluster_size_bits - DENTRY_SIZE_BITS))
> -#define EXFAT_DEN_TO_CLU(dentry, sbi)  \
> -       ((dentry) >> ((sbi)->cluster_size_bits - DENTRY_SIZE_BITS))
> -
>  /*
>   * helpers for fat entry.
>   */
> @@ -149,7 +117,7 @@ enum {
>   * The 608 bytes are in 3 sectors at most (even 512 Byte sector).
>   */
>  #define DIR_CACHE_SIZE         \
> -       (DIV_ROUND_UP(EXFAT_DEN_TO_B(ES_MAX_ENTRY_NUM), SECTOR_SIZE) + 1)
> +       (DIV_ROUND_UP(ES_MAX_ENTRY_NUM << DENTRY_SIZE_BITS, SECTOR_SIZE) =
+ 1)
>
>  /* Superblock flags */
>  #define EXFAT_FLAGS_SHUTDOWN   1
> @@ -432,6 +400,94 @@ static inline loff_t exfat_ondisk_size(const struct =
inode *inode)
>         return ((loff_t)inode->i_blocks) << 9;
>  }
>
> +/*
> + * helpers for cluster size to byte conversion.
> + */
> +static inline loff_t exfat_cluster_to_bytes(struct exfat_sb_info *sbi,
> +               u32 nr_clusters)
> +{
> +       return (loff_t)nr_clusters << sbi->cluster_size_bits;
> +}
> +
> +static inline blkcnt_t exfat_cluster_to_sectors(struct exfat_sb_info *sb=
i,
> +               u32 nr_clusters)
> +{
> +       return (blkcnt_t)nr_clusters << (sbi->cluster_size_bits - 9);
> +}
> +
> +static inline u32 exfat_bytes_to_cluster(struct exfat_sb_info *sbi, loff=
_t size)
> +{
> +       return (u32)(size >> sbi->cluster_size_bits);
> +}
> +
> +static inline u32 exfat_bytes_to_cluster_round_up(struct exfat_sb_info *=
sbi,
> +               loff_t size)
> +{
> +       if (size <=3D 0)
> +               return 0;
> +       return (u32)((size - 1) >> sbi->cluster_size_bits) + 1;
> +}
> +
> +static inline u32 exfat_cluster_offset(struct exfat_sb_info *sbi, loff_t=
 off)
> +{
> +       return off & (sbi->cluster_size - 1);
> +}
> +
> +/*
> + * helpers for block size to byte conversion.
> + */
> +static inline loff_t exfat_block_to_bytes(struct super_block *sb,
> +               sector_t block)
> +{
> +       return (loff_t)block << sb->s_blocksize_bits;
> +}
> +
> +static inline sector_t exfat_bytes_to_block(struct super_block *sb, loff=
_t size)
> +{
> +       return (sector_t)(size >> sb->s_blocksize_bits);
> +}
> +
> +static inline sector_t exfat_bytes_to_block_round_up(struct super_block =
*sb,
> +               loff_t size)
> +{
> +       if (size <=3D 0)
> +               return 0;
> +       return (sector_t)(((size - 1) >> sb->s_blocksize_bits) + 1);
> +}
> +
> +static inline u32 exfat_block_offset(struct super_block *sb, loff_t off)
> +{
> +       return (u32)(off & (sb->s_blocksize - 1));
> +}
> +
> +/*
> + * helpers for block size to dentry size conversion.
> + */
> +static inline u32 exfat_bytes_to_dentries(loff_t b)
> +{
> +       return (u32)(b >> DENTRY_SIZE_BITS);
> +}
> +
> +static inline u32 exfat_dentries_to_bytes(u32 dentry)
> +{
> +       return dentry << DENTRY_SIZE_BITS;
> +}
> +
> +/*
> + * helpers for cluster size to dentry size conversion.
> + */
> +static inline u32 exfat_cluster_to_dentries(struct exfat_sb_info *sbi,
> +               u32 nr_clusters)
> +{
> +       return nr_clusters << (sbi->cluster_size_bits - DENTRY_SIZE_BITS)=
;
> +}
> +
> +static inline u32 exfat_dentries_to_cluster(struct exfat_sb_info *sbi,
> +               u32 dentry)
> +{
> +       return dentry >> (sbi->cluster_size_bits - DENTRY_SIZE_BITS);
> +}
> +
>  /* super.c */
>  int exfat_set_volume_dirty(struct super_block *sb);
>  int exfat_clear_volume_dirty(struct super_block *sb);
> diff --git a/fs/exfat/fatent.c b/fs/exfat/fatent.c
> index dce0955e689a..45b0b754a2e4 100644
> --- a/fs/exfat/fatent.c
> +++ b/fs/exfat/fatent.c
> @@ -412,8 +412,8 @@ int exfat_zeroed_cluster(struct inode *dir, unsigned =
int clu)
>
>         if (IS_DIRSYNC(dir))
>                 return sync_blockdev_range(sb->s_bdev,
> -                               EXFAT_BLK_TO_B(blknr, sb),
> -                               EXFAT_BLK_TO_B(last_blknr, sb) - 1);
> +                               exfat_block_to_bytes(sb, blknr),
> +                               exfat_block_to_bytes(sb, last_blknr) - 1)=
;
>
>         return 0;
>  }
> diff --git a/fs/exfat/file.c b/fs/exfat/file.c
> index 354bdcfe4abc..29a36a80e29b 100644
> --- a/fs/exfat/file.c
> +++ b/fs/exfat/file.c
> @@ -33,9 +33,9 @@ static int exfat_cont_expand(struct inode *inode, loff_=
t size)
>         if (ret)
>                 return ret;
>
> -       num_clusters =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
> +       num_clusters =3D exfat_bytes_to_cluster(sbi, exfat_ondisk_size(in=
ode));
>         /* integer overflow is already checked in inode_newsize_ok(). */
> -       new_num_clusters =3D EXFAT_B_TO_CLU_ROUND_UP(size, sbi);
> +       new_num_clusters =3D exfat_bytes_to_cluster_round_up(sbi, size);
>
>         if (new_num_clusters =3D=3D num_clusters)
>                 goto out;
> @@ -200,8 +200,8 @@ int __exfat_truncate(struct inode *inode)
>
>         exfat_set_volume_dirty(sb);
>
> -       num_clusters_new =3D EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), =
sbi);
> -       num_clusters_phys =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sb=
i);
> +       num_clusters_new =3D exfat_bytes_to_cluster_round_up(sbi, i_size_=
read(inode));
> +       num_clusters_phys =3D exfat_bytes_to_cluster(sbi, exfat_ondisk_si=
ze(inode));
>
>         exfat_chain_set(&clu, ei->start_clu, num_clusters_phys, ei->flags=
);
>
> diff --git a/fs/exfat/inode.c b/fs/exfat/inode.c
> index 1ea4c740fef9..d25e0a69865b 100644
> --- a/fs/exfat/inode.c
> +++ b/fs/exfat/inode.c
> @@ -135,7 +135,7 @@ static int exfat_map_cluster(struct inode *inode, uns=
igned int clu_offset,
>         unsigned int local_clu_offset =3D clu_offset;
>         unsigned int num_to_be_allocated =3D 0, num_clusters;
>
> -       num_clusters =3D EXFAT_B_TO_CLU(exfat_ondisk_size(inode), sbi);
> +       num_clusters =3D exfat_bytes_to_cluster(sbi, exfat_ondisk_size(in=
ode));
>
>         if (clu_offset >=3D num_clusters)
>                 num_to_be_allocated =3D clu_offset - num_clusters + 1;
> @@ -216,7 +216,8 @@ static int exfat_map_cluster(struct inode *inode, uns=
igned int clu_offset,
>
>                 *clu =3D new_clu.dir;
>
> -               inode->i_blocks +=3D EXFAT_CLU_TO_B(num_to_be_allocated, =
sbi) >> 9;
> +               inode->i_blocks +=3D
> +                       exfat_cluster_to_sectors(sbi, num_to_be_allocated=
) >> 9;
>
>                 /*
>                  * Move *clu pointer along FAT chains (hole care) because=
 the
> @@ -254,12 +255,12 @@ static int exfat_get_block(struct inode *inode, sec=
tor_t iblock,
>
>         mutex_lock(&sbi->s_lock);
>         i_size =3D i_size_read(inode);
> -       last_block =3D EXFAT_B_TO_BLK_ROUND_UP(i_size, sb);
> +       last_block =3D exfat_bytes_to_block_round_up(sb, i_size);
>         if (iblock >=3D last_block && !create)
>                 goto done;
>
>         /* Is this block already allocated? */
> -       count =3D EXFAT_B_TO_CLU_ROUND_UP(bh_result->b_size, sbi);
> +       count =3D exfat_bytes_to_cluster_round_up(sbi, bh_result->b_size)=
;
>         err =3D exfat_map_cluster(inode, iblock >> sbi->sect_per_clus_bit=
s,
>                         &cluster, &count, create);
>         if (err) {
> @@ -296,9 +297,9 @@ static int exfat_get_block(struct inode *inode, secto=
r_t iblock,
>          * care the last nested block if valid_size is not equal to i_siz=
e.
>          */
>         if (i_size =3D=3D ei->valid_size || create || !bh_result->b_folio=
)
> -               valid_blks =3D EXFAT_B_TO_BLK_ROUND_UP(ei->valid_size, sb=
);
> +               valid_blks =3D exfat_bytes_to_block_round_up(sb, ei->vali=
d_size);
>         else
> -               valid_blks =3D EXFAT_B_TO_BLK(ei->valid_size, sb);
> +               valid_blks =3D exfat_bytes_to_block(sb, ei->valid_size);
>
>         /* The range has been fully written, map it */
>         if (iblock + max_blocks < valid_blks)
> @@ -313,7 +314,7 @@ static int exfat_get_block(struct inode *inode, secto=
r_t iblock,
>         /* The area has not been written, map and mark as new for create =
case */
>         if (create) {
>                 set_buffer_new(bh_result);
> -               ei->valid_size =3D EXFAT_BLK_TO_B(iblock + max_blocks, sb=
);
> +               ei->valid_size =3D exfat_block_to_bytes(sb, iblock + max_=
blocks);
>                 mark_inode_dirty(inode);
>                 goto done;
>         }
> @@ -343,7 +344,7 @@ static int exfat_get_block(struct inode *inode, secto=
r_t iblock,
>                         goto done;
>                 }
>
> -               pos =3D EXFAT_BLK_TO_B(iblock, sb);
> +               pos =3D exfat_block_to_bytes(sb, iblock);
>                 size =3D ei->valid_size - pos;
>                 addr =3D folio_address(bh_result->b_folio) +
>                         offset_in_folio(bh_result->b_folio, pos);
> @@ -374,7 +375,7 @@ static int exfat_get_block(struct inode *inode, secto=
r_t iblock,
>          */
>         clear_buffer_mapped(bh_result);
>  done:
> -       bh_result->b_size =3D EXFAT_BLK_TO_B(max_blocks, sb);
> +       bh_result->b_size =3D exfat_block_to_bytes(sb, max_blocks);
>         if (err < 0)
>                 clear_buffer_mapped(bh_result);
>  unlock_ret:
> diff --git a/fs/exfat/namei.c b/fs/exfat/namei.c
> index 2c5636634b4a..752fbec9316b 100644
> --- a/fs/exfat/namei.c
> +++ b/fs/exfat/namei.c
> @@ -208,7 +208,7 @@ static int exfat_search_empty_slot(struct super_block=
 *sb,
>         int dentries_per_clu;
>         struct exfat_chain clu;
>         struct exfat_sb_info *sbi =3D EXFAT_SB(sb);
> -       int total_entries =3D EXFAT_CLU_TO_DEN(p_dir->size, sbi);
> +       unsigned int total_entries =3D exfat_cluster_to_dentries(sbi, p_d=
ir->size);
>
>         dentries_per_clu =3D sbi->dentries_per_clu;
>
> @@ -266,7 +266,7 @@ static int exfat_search_empty_slot(struct super_block=
 *sb,
>
>  static int exfat_check_max_dentries(struct inode *inode)
>  {
> -       if (EXFAT_B_TO_DEN(i_size_read(inode)) >=3D MAX_EXFAT_DENTRIES) {
> +       if (exfat_bytes_to_dentries(i_size_read(inode)) >=3D MAX_EXFAT_DE=
NTRIES) {
>                 /*
>                  * exFAT spec allows a dir to grow up to 8388608(256MB)
>                  * dentries
> @@ -314,7 +314,8 @@ int exfat_find_empty_entry(struct inode *inode,
>         }
>
>         exfat_chain_set(p_dir, ei->start_clu,
> -                       EXFAT_B_TO_CLU(i_size_read(inode), sbi), ei->flag=
s);
> +                       exfat_bytes_to_cluster(sbi, i_size_read(inode)),
> +                       ei->flags);
>
>         while ((dentry =3D exfat_search_empty_slot(sb, &hint_femp, p_dir,
>                                         num_entries, es)) < 0) {
> @@ -375,7 +376,7 @@ int exfat_find_empty_entry(struct inode *inode,
>
>                 hint_femp.cur.size++;
>                 p_dir->size++;
> -               size =3D EXFAT_CLU_TO_B(p_dir->size, sbi);
> +               size =3D exfat_cluster_to_bytes(sbi, p_dir->size);
>
>                 /* directory inode should be updated in here */
>                 i_size_write(inode, size);
> @@ -604,7 +605,7 @@ static int exfat_find(struct inode *dir, const struct=
 qstr *qname,
>                 return ret;
>
>         exfat_chain_set(&cdir, ei->start_clu,
> -               EXFAT_B_TO_CLU(i_size_read(dir), sbi), ei->flags);
> +               exfat_bytes_to_cluster(sbi, i_size_read(dir)), ei->flags)=
;
>
>         /* check the validation of hint_stat and initialize it if require=
d */
>         if (ei->version !=3D (inode_peek_iversion_raw(dir) & 0xffffffff))=
 {
> @@ -681,7 +682,7 @@ static int exfat_find(struct inode *dir, const struct=
 qstr *qname,
>                 return -EIO;
>         }
>
> -       if (unlikely(EXFAT_B_TO_CLU_ROUND_UP(info->size, sbi) > sbi->used=
_clusters)) {
> +       if (unlikely(exfat_bytes_to_cluster_round_up(sbi, info->size) > s=
bi->used_clusters)) {
>                 exfat_fs_error(sb, "data size is invalid(%lld)", info->si=
ze);
>                 return -EIO;
>         }
> @@ -695,7 +696,8 @@ static int exfat_find(struct inode *dir, const struct=
 qstr *qname,
>
>         if (info->type =3D=3D TYPE_DIR) {
>                 exfat_chain_set(&cdir, info->start_clu,
> -                               EXFAT_B_TO_CLU(info->size, sbi), info->fl=
ags);
> +                               exfat_bytes_to_cluster(sbi, info->size),
> +                               info->flags);
>                 count =3D exfat_count_dir_entries(sb, &cdir);
>                 if (count < 0)
>                         return -EIO;
> @@ -951,7 +953,7 @@ static int exfat_rmdir(struct inode *dir, struct dent=
ry *dentry)
>         }
>
>         exfat_chain_set(&clu_to_free, ei->start_clu,
> -               EXFAT_B_TO_CLU_ROUND_UP(i_size_read(inode), sbi), ei->fla=
gs);
> +               exfat_bytes_to_cluster_round_up(sbi, i_size_read(inode)),=
 ei->flags);
>
>         err =3D exfat_check_dir_empty(sb, &clu_to_free);
>         if (err) {
> @@ -1158,8 +1160,8 @@ static int __exfat_rename(struct inode *old_parent_=
inode,
>
>                         new_clu.dir =3D new_ei->start_clu;
>                         new_clu.size =3D
> -                               EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_i=
node),
> -                               sbi);
> +                               exfat_bytes_to_cluster_round_up(sbi,
> +                                               i_size_read(new_inode));
>                         new_clu.flags =3D new_ei->flags;
>
>                         ret =3D exfat_check_dir_empty(sb, &new_clu);
> @@ -1203,8 +1205,8 @@ static int __exfat_rename(struct inode *old_parent_=
inode,
>                         struct exfat_chain new_clu_to_free;
>
>                         exfat_chain_set(&new_clu_to_free, new_ei->start_c=
lu,
> -                               EXFAT_B_TO_CLU_ROUND_UP(i_size_read(new_i=
node),
> -                               sbi), new_ei->flags);
> +                               exfat_bytes_to_cluster_round_up(sbi, i_si=
ze_read(new_inode)),
> +                               new_ei->flags);
>
>                         if (exfat_free_cluster(new_inode, &new_clu_to_fre=
e)) {
>                                 /* just set I/O error only */
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index 95d87e2d7717..cb2f8eefff99 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -369,7 +369,7 @@ static int exfat_read_root(struct inode *inode, struc=
t exfat_chain *root_clu)
>         ei->hint_stat.clu =3D sbi->root_dir;
>         ei->hint_femp.eidx =3D EXFAT_HINT_NONE;
>
> -       i_size_write(inode, EXFAT_CLU_TO_B(root_clu->size, sbi));
> +       i_size_write(inode, exfat_cluster_to_bytes(sbi, root_clu->size));
>
>         num_subdirs =3D exfat_count_dir_entries(sb, root_clu);
>         if (num_subdirs < 0)
> @@ -538,7 +538,7 @@ static int exfat_read_boot_sector(struct super_block =
*sb)
>          * machines.
>          */
>         sb->s_maxbytes =3D min(MAX_LFS_FILESIZE,
> -                            EXFAT_CLU_TO_B((loff_t)EXFAT_MAX_NUM_CLUSTER=
, sbi));
> +                            exfat_cluster_to_bytes(sbi, (loff_t)EXFAT_MA=
X_NUM_CLUSTER));
>
>         /* check logical sector size */
>         if (exfat_calibrate_blocksize(sb, 1 << p_boot->sect_size_bits))
> --
> 2.25.1
>
>
