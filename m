Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6F26D4C3
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 May 2026 03:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779419785; cv=pass; b=kGzjfl+goS3NBrNeqO2uxZ/kMStqgL1Y1YUYKXvOAMHHvMIRni2wWyKnrCrz+4nvMBuKnWM2QypSEOsFGay7vpA+Ah1hYknE47C0ImtkXm57qXuPK9V0wxkh9vLbX6gDjuZXBOcK945CggZAIn9GvNiwqwPJWSAGngXUmF0AVTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779419785; c=relaxed/simple;
	bh=2Q0PcH6UmqiLE1B7fhpi8re4VEgW9tqj2ga0KJ+U/ZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O1U5pQLIEfAzGDY9WV1xNd1lWsHRdq+AGygOL1KntWeL3XLN+hbUMEAWy5y9GBRGGBDJ6I4sqPDpg4roKB8tYIMRGdSXOpInRYdYwJOPUOrQzcAOp1QGbsNPKIUp3Oo8XS+gNSPuX2+FRllVGdveLiMoKHTES6oHYcVWOtSHS5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiZAsgqk; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiZAsgqk"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65e81d623bbso359898d50.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 20:16:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419783; cv=none;
        d=google.com; s=arc-20240605;
        b=iKQvu3wGVCYtxXMJqxCxZ8Bu4oM3BB8YSxgcNFcdrXPUt2JrwzDvWdprbkHQGxqh6+
         LluAEI4dAxGNY1SglSgDrcnousw63Pbjf7xIm5KYLXjZaudNYBfMM0rbmXaFABcxYJuo
         FiSqX+kBMMbCGalKa0I2byhMeQc0Igj960uRB537DpmB1PdkgI+A01IxipxDHZcLVhys
         vYGLg3fNHoI+JiQgbQPABMT+ILeB3RYKqVWVCxnCoeShvKkRajqumygHK7Km4YOO8f0y
         tasU8hujrk7M1pDWpogBORxawEJwlX1Wdx0TbjAUNdy/2Hd99KHvnKDji0Txv+Qveg6Z
         t88A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=robsLewux4vBHKDttIjt09yfXrWmGYjitlpcRHvjuX8=;
        fh=D//4vXVrOrwp/nB5p34LbfUVsfGya+MYkFlZfF09jcs=;
        b=ZLYiMQKs/hdfrQQ18uNxjHLy4jUxB/TnEMdJef60//D4P3ytTYYaaFQBOkjg6tDlYg
         5nLSY6yOJRJl8k8z5soeeEZS+QbEk9POzXgZ3bNI1pQBoT0gFMZMSweZA4wPliGsRDJF
         d0n4qm3uqv7c2/XUgKINx72PM++ORhzfC+KYjj+T4RgbwMF6ni13E3cNAqUuwgZx/w3V
         qL3j2aiQ1c/gApzuQp/7VUjryLWbo+o70k2sCOZtLMy2GCpD+A0w9rcz+ObVxrf/PfS7
         VZPTUHsyJjEn0jku1CzPAMRGp6Hyd3F3M4e8N6pjb8VnmS2G6tC7XtJHrwEuVpPKF63o
         jFFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779419783; x=1780024583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=robsLewux4vBHKDttIjt09yfXrWmGYjitlpcRHvjuX8=;
        b=XiZAsgqk2r8PuzfoTYUfkUlsWe24zEyekCfoaQusNPI1cwmtjmiCtTWj92umL27uIp
         uz19X8EaqlwVIl27JwGpgNSnCX0gE2GCqR9ddPoZxAkSpPrf6P1vSz3s8+qV9seQWGur
         Yt/oGKyfIpBZAhsQxFcYf208HHaUhrRGDutZG0OM6Q3HLbqr2s1OSuvfYcWGQScTQ/Vy
         DsdsYXnX2GGO5WZWrdTcuuqHNScdnYl0WRPXzX3I6/SsltbF0Z3zgKZCDdcwheKDTF1h
         ixEFoG7PvKELEKVb+LyvwkiJDX0eNz8cS9NJxU8R/2hpkL1wbSNV4ZgC1MONd/HSSP+x
         hqQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779419783; x=1780024583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=robsLewux4vBHKDttIjt09yfXrWmGYjitlpcRHvjuX8=;
        b=sZWlSIER7oA18vUN2AOLJrBHLF2hwJWBkg99m1bNLYeYcOBU7FNhhCVy9Ev7NUmpaF
         agK1N2wgvvRk7dBB5EYSJOKrvqe6ca0ximHPzggkdEUKD3rjo47zZx7bzEEFclY7tXQk
         eidCTydX6yGOofXigclyRpFl3MgvHkKMfc10YDyhRfRHHveq0Iwjf2IgUZ4gkOQHqoL0
         UF06a/9Vmv3thHWbeYEk58zHPs0s3LdsTPoWsn8QRZbD019B3Xt3haA3LkWwgTgX69xh
         qdpHwm1XAwQ1mD19jdVfWBdUSUaVQlabSty7xzrPCBsHLxgzdMApw2KWOgAF7MvBxXig
         mBdA==
X-Forwarded-Encrypted: i=1; AFNElJ8YH5AlwH86EELx7KLTjRPv4UbmUV3aLvSIfO7IPeZ7Kn+YDaikdlvulMEELCXKDjKqxw3Uw8XAWuTh/VyX@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZ/Gu4l6c3K6i19X7yS8tLgUOqVexyEQl2GbaJ8NF+1P+hQfe
	kNcaPVD1xzQkXQJn+RwFlKhAeajrtlL8Dp/8GG1DnzOWG56nJUVPAY7mdKFh1eXugofjXrBH4h7
	lFue2EDsr0sYK3xOtMaXb4nox9k4Pufw=
X-Gm-Gg: Acq92OE6RuPX9/C9lliX1S0eRsPMasgMDqsCrJB/bRR5sjnALLlu+YqSXh9+OifjlkE
	Gl3U2DDBH5YJXH6RMNLY6AnhO3/b50UJuTAYav/mK4cviHtXBoTnkQt4HUys94ikEHI3e+WD2G5
	E/GuDiVym5KbHdAfDejMo2pwYLN32GQWTpjfTPXfFP4/tF/2iltgusEGgR0ocXOmop1BZPRYYpz
	JTdMYjJJjet7dIzl7Jvu7GITJrXGmf7dd6LgOyThjyOCYuB2+7Fj5HexfW1m3yAUYy60gcuxpL2
	n5nnr6tKXHxEjLsjDn0=
X-Received: by 2002:a05:690e:12cd:b0:65d:6f14:9070 with SMTP id
 956f58d0204a3-65ec98c900bmr1434517d50.4.1779419782516; Thu, 21 May 2026
 20:16:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522-t-fix-oob-v2-v1-0-0bea6582a361@gmail.com> <20260522-t-fix-oob-v2-v1-1-0bea6582a361@gmail.com>
In-Reply-To: <20260522-t-fix-oob-v2-v1-1-0bea6582a361@gmail.com>
From: CharSyam <charsyam@gmail.com>
Date: Fri, 22 May 2026 12:16:11 +0900
X-Gm-Features: AVHnY4KZoBluaEbi5Vwoddc33ip6icp0RrXFNHfcULjZQmVuc1qTtAefzySj3fk
Message-ID: <CAMrLSE6Zw4hzX_rXG3u5+1=WPj9G012ZL1XFc2ygwMGR-XpYVw@mail.gmail.com>
Subject: Re: [PATCH 1/4] ntfs: validate index block header more strictly
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Hyunchul.

 err =3D ntfs_index_block_inconsistent(...) now stores the helper's -1.
Previously err was still
0 at this point, so the common exit path normalized corruption errors
to -EIO via if (!err)
err =3D -EIO;. With this patch, the -1 skips that normalization and is
exposed to callers as
-EPERM.

 Was that intended? If not, this path should set err =3D -EIO before
jumping to unm_err_out, or
ntfs_index_block_inconsistent() should be converted to return real
errno values. The latter
may be cleaner, since ntfs_index_header_inconsistent() already returns
-EIO but the caller
currently collapses it back to -1.

Thanks.
DaeMyung.

2026=EB=85=84 5=EC=9B=94 22=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 9:48, H=
yunchul Lee <hyc.lee@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Modify ntfs_index_block_inconsisent() to perform stricter validation of
> INDEX_HEADER geometry in INDX blocks, and update
> ntfs_lookup_inode_by_name() to use that function to validate INDX
> blocks.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
> ---
>  fs/ntfs/dir.c   | 38 +++++---------------------
>  fs/ntfs/index.c | 85 +++++++++++++++++++++++++++++++++++++++++----------=
------
>  fs/ntfs/index.h |  3 ++
>  3 files changed, 72 insertions(+), 54 deletions(-)
>
> diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> index 20f5c7074bdd..6745a0e6e3e7 100644
> --- a/fs/ntfs/dir.c
> +++ b/fs/ntfs/dir.c
> @@ -342,43 +342,19 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *di=
r_ni, const __le16 *uname,
>                         dir_ni->mft_no);
>                 goto unm_err_out;
>         }
> -       /* Catch multi sector transfer fixup errors. */
> -       if (unlikely(!ntfs_is_indx_record(ia->magic))) {
> -               ntfs_error(sb,
> -                       "Directory index record with vcn 0x%llx is corrup=
t.  Corrupt inode 0x%llx.  Run chkdsk.",
> -                       vcn, dir_ni->mft_no);
> -               goto unm_err_out;
> -       }
> -       if (le64_to_cpu(ia->index_block_vcn) !=3D vcn) {
> -               ntfs_error(sb,
> -                       "Actual VCN (0x%llx) of index buffer is different=
 from expected VCN (0x%llx). Directory inode 0x%llx is corrupt or driver bu=
g.",
> -                       le64_to_cpu(ia->index_block_vcn),
> -                       vcn, dir_ni->mft_no);
> -               goto unm_err_out;
> -       }
> -       if (le32_to_cpu(ia->index.allocated_size) + 0x18 !=3D
> -                       dir_ni->itype.index.block_size) {
> -               ntfs_error(sb,
> -                       "Index buffer (VCN 0x%llx) of directory inode 0x%=
llx has a size (%u) differing from the directory specified size (%u). Direc=
tory inode is corrupt or driver bug.",
> -                       vcn, dir_ni->mft_no,
> -                       le32_to_cpu(ia->index.allocated_size) + 0x18,
> -                       dir_ni->itype.index.block_size);
> -               goto unm_err_out;
> -       }
>         index_end =3D (u8 *)ia + dir_ni->itype.index.block_size;
>         if (index_end > kaddr + PAGE_SIZE) {
>                 ntfs_error(sb,
> -                       "Index buffer (VCN 0x%llx) of directory inode 0x%=
llx crosses page boundary. Impossible! Cannot access! This is probably a bu=
g in the driver.",
> -                       vcn, dir_ni->mft_no);
> +                          "Index buffer (VCN 0x%llx) of directory inode =
0x%llx crosses page boundary. Impossible! Cannot access! This is probably a=
 bug in the driver.",
> +                          vcn, dir_ni->mft_no);
>                 goto unm_err_out;
>         }
> -       index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_leng=
th);
> -       if (index_end > (u8 *)ia + dir_ni->itype.index.block_size) {
> -               ntfs_error(sb,
> -                       "Size of index buffer (VCN 0x%llx) of directory i=
node 0x%llx exceeds maximum size.",
> -                       vcn, dir_ni->mft_no);
> +       err =3D ntfs_index_block_inconsistent(vol, ia,
> +                                           dir_ni->itype.index.block_siz=
e,
> +                                           vcn, dir_ni->mft_no);
> +       if (err)
>                 goto unm_err_out;
> -       }
> +       index_end =3D (u8 *)&ia->index + le32_to_cpu(ia->index.index_leng=
th);
>         /* The first index entry. */
>         ie =3D (struct index_entry *)((u8 *)&ia->index +
>                         le32_to_cpu(ia->index.entries_offset));
> diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> index 146e011c1a41..c203a5ad47b6 100644
> --- a/fs/ntfs/index.c
> +++ b/fs/ntfs/index.c
> @@ -303,6 +303,53 @@ static int ntfs_ie_end(struct index_entry *ie)
>         return ie->flags & INDEX_ENTRY_END || !ie->length;
>  }
>
> +static int ntfs_index_header_inconsistent(struct ntfs_volume *vol,
> +                                         const struct index_header *ih,
> +                                         u32 bytes_available, u64 inum)
> +{
> +       u32 entries_offset =3D le32_to_cpu(ih->entries_offset);
> +       u32 index_length =3D le32_to_cpu(ih->index_length);
> +       u32 allocated_size =3D le32_to_cpu(ih->allocated_size);
> +
> +       if (bytes_available < sizeof(struct index_header)) {
> +               ntfs_error(vol->sb,
> +                          "index block in inode %llu is smaller than an =
index header.",
> +                          (unsigned long long)inum);
> +               return -EIO;
> +       }
> +
> +       if (entries_offset < sizeof(struct index_header) ||
> +           entries_offset > bytes_available) {
> +               ntfs_error(vol->sb,
> +                          "Invalid index entry offset in inode %llu.",
> +                          (unsigned long long)inum);
> +               return -EIO;
> +       }
> +
> +       if (index_length <=3D entries_offset) {
> +               ntfs_error(vol->sb,
> +                          "No space for index entries in inode %llu.",
> +                          (unsigned long long)inum);
> +               return -EIO;
> +       }
> +
> +       if (allocated_size < index_length) {
> +               ntfs_error(vol->sb,
> +                          "Index entries overflow in inode %llu.",
> +                          (unsigned long long)inum);
> +               return -EIO;
> +       }
> +
> +       if (allocated_size > bytes_available || index_length > bytes_avai=
lable) {
> +               ntfs_error(vol->sb,
> +                          "Index entries in inode %llu exceed the availa=
ble buffer.",
> +                          (unsigned long long)inum);
> +               return -EIO;
> +       }
> +
> +       return 0;
> +}
> +
>  /*
>   *  Find the last entry in the index block
>   */
> @@ -452,20 +499,19 @@ static struct index_entry *ntfs_ie_dup_novcn(struct=
 index_entry *ie)
>   *
>   * size(struct index_header) <=3D ent_offset < ind_length <=3D alloc_siz=
e < bk_size
>   */
> -static int ntfs_index_block_inconsistent(struct ntfs_index_context *icx,
> -               struct index_block *ib, s64 vcn)
> +int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> +                                 const struct index_block *ib,
> +                                 u32 block_size, s64 vcn, u64 inum)
>  {
>         u32 ib_size =3D (unsigned int)le32_to_cpu(ib->index.allocated_siz=
e) +
>                 offsetof(struct index_block, index);
> -       struct super_block *sb =3D icx->idx_ni->vol->sb;
> -       unsigned long long inum =3D icx->idx_ni->mft_no;
> +       struct super_block *sb =3D vol->sb;
>
>         ntfs_debug("Entering\n");
>
>         if (!ntfs_is_indx_record(ib->magic)) {
> -
>                 ntfs_error(sb, "Corrupt index block signature: vcn %lld i=
node %llu\n",
> -                               vcn, (unsigned long long)icx->idx_ni->mft=
_no);
> +                          vcn, (unsigned long long)inum);
>                 return -1;
>         }
>
> @@ -477,27 +523,18 @@ static int ntfs_index_block_inconsistent(struct ntf=
s_index_context *icx,
>                 return -1;
>         }
>
> -       if (ib_size !=3D icx->block_size) {
> +       if (ib_size !=3D block_size) {
>                 ntfs_error(sb,
> -                       "Corrupt index block : s64 (%lld) of inode %llu h=
as a size (%u) differing from the index specified size (%u)\n",
> -                       vcn, inum, ib_size, icx->block_size);
> +                          "Corrupt index block : s64 (%lld) of inode %ll=
u has a size (%u) differing from the index specified size (%u)\n",
> +                          vcn, inum, ib_size, block_size);
>                 return -1;
>         }
>
> -       if (le32_to_cpu(ib->index.entries_offset) < sizeof(struct index_h=
eader)) {
> -               ntfs_error(sb, "Invalid index entry offset in inode %lld\=
n", inum);
> -               return -1;
> -       }
> -       if (le32_to_cpu(ib->index.index_length) <=3D
> -           le32_to_cpu(ib->index.entries_offset)) {
> -               ntfs_error(sb, "No space for index entries in inode %lld\=
n", inum);
> +       if (ntfs_index_header_inconsistent(vol, &ib->index,
> +                                          block_size -
> +                                          offsetof(struct index_block, i=
ndex),
> +                                          inum))
>                 return -1;
> -       }
> -       if (le32_to_cpu(ib->index.allocated_size) <
> -           le32_to_cpu(ib->index.index_length)) {
> -               ntfs_error(sb, "Index entries overflow in inode %lld\n", =
inum);
> -               return -1;
> -       }
>
>         return 0;
>  }
> @@ -669,7 +706,9 @@ static int ntfs_ib_read(struct ntfs_index_context *ic=
x, s64 vcn, struct index_bl
>         }
>
>         post_read_mst_fixup((struct ntfs_record *)((u8 *)dst), icx->block=
_size);
> -       if (ntfs_index_block_inconsistent(icx, dst, vcn))
> +       if (ntfs_index_block_inconsistent(icx->idx_ni->vol, dst,
> +                                         icx->block_size, vcn,
> +                                         icx->idx_ni->mft_no))
>                 return -1;
>
>         return 0;
> diff --git a/fs/ntfs/index.h b/fs/ntfs/index.h
> index e68d6fabaf9f..3451ec8a1c4e 100644
> --- a/fs/ntfs/index.h
> +++ b/fs/ntfs/index.h
> @@ -89,6 +89,9 @@ struct ntfs_index_context {
>         bool sync_write;
>  };
>
> +int ntfs_index_block_inconsistent(struct ntfs_volume *vol,
> +                                 const struct index_block *ib,
> +                                 u32 block_size, s64 vcn, u64 inum);
>  int ntfs_index_entry_inconsistent(struct ntfs_index_context *icx, struct=
 ntfs_volume *vol,
>                 const struct index_entry *ie, __le32 collation_rule, u64 =
inum);
>  struct ntfs_index_context *ntfs_index_ctx_get(struct ntfs_inode *ni, __l=
e16 *name,
>
> --
> 2.43.0
>
>
