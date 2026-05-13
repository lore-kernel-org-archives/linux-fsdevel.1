Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AF64DC520
	for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778685457; cv=pass; b=azIG4YzNKEm4Pf4jdO8eQm5OiLQc4iaeX2S3BmPke2KF5rRiIE3MS2S4S+7ILcClhwp058szCJvTo6uVbOnKuYElpJ8dz4SaIFtb1eIVIhKMgsja1uXlAH/YeOlSFgjcN6yHQZHI6ptLImP1fJT6kIJYEEl8I3SoxgK0DzNeyDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778685457; c=relaxed/simple;
	bh=Kzafc1Q1jsB+AuQBjtH7Zn/FU8wVHvVCIBhpoReKjvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L+eV0BRsfTHIEkRR65iZPuFUpPvHX1EuoixAVALg41/ZLnycMq0G00vQxWBWgDKa/OZW+wA6VF57jo+BvNj75jHiurqDQYkobdp1+s6e9py1YLbez9uE/78AmfLv/zql/UzalkasVsaVbIVOBLJqycTzZVjeznBVBSevBnoYBtI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VwjVYm7Z; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VwjVYm7Z"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651c36a7ee9so1112488d50.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 May 2026 08:17:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778685455; cv=none;
        d=google.com; s=arc-20240605;
        b=B3M3wHB4ZBkGYCzFUw8fef1EEJ14VUsgEHiMpwNBL+/SkzcFIDQVBCIt9GbZPTtaej
         6DFtHQX0sCQ0RgOzQ6x1sjUYN9kTNUAIpcNEBx5Iby85ZsG28cS34gk0poF93Cc9+35h
         owLY/unW86q4nzUeIQXUDYhjaP0QO2FteF/PqGRSdXydftNiTNn3sbRC5fbBaqP1IXzA
         rTwGTdGSuDgXRLS5KK8ASlDdYDBD7QRv79YkeN9cjyHFRCh4XpYSLEEcC80pvgXaO7f9
         zZ4GrYKTtF8CCz0yY+1/PR3YrovK5y8rTW77FQJRCrFswbW2dJHsVs0bst98OaZXqRd3
         rkEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IAILRg2BfARetbiC0BgMl/F7/7byROtZ7INl1EVwMRo=;
        fh=q3VhOJn1YKd1tjoGuhZF2oFGO9iHJuBpzQjKChzV3go=;
        b=ev9Y3KhUdo/yF+8y3LcgrJYSFm+yJhkbBqH+y/0g46QWIHsTvyFLp7k1CnwYRZUkHl
         d9jeRxgIEzNRdLoExcNWK+Sx3qQcImHBGciLt1NaFPKu7VXvQe3S5EltlBAIukQL5mzH
         FtW25VmhacafT5b6QQPcM/xUoHSq4zZLcGPnrqCnjDZKqQZT0YjpMrbkF+lx20AKsrcT
         dR9hD+WxU4x7WYXeEU1cd3r/om64cGUx1Pf3dx9estTuKTU10QW7A6XyLpZkjjRmozkz
         La0cNRKiim7Ns01uh6pS/c4LD6k9KXK4HC+2D6a1sFYdKBdFPTR1t+Y8Qr1X0I0dhoUM
         paEA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778685455; x=1779290255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAILRg2BfARetbiC0BgMl/F7/7byROtZ7INl1EVwMRo=;
        b=VwjVYm7Zt/UNsjGe5GVjsU7/oS4F95WIYp4MSaj29GCyRZ1q4I5/pNqqXUSxG9EXrS
         zYJVGPcCpDD0xWRVxi8Fasmyv0IhdqMLnn88YklWAG4/kzUYxBLh+1L7sHxFCH5EgNvo
         oz/TlKfxu6UFzuG8XADwhhZF6NIbTjCnKEMF/01lpuFplyQl8jg/LHzuyZkSHaRmnbyI
         ABC6F5xU/HDrJe5fjsDsES863Wac6+AwfpptzrGSru17UPgTdT+IPEcQ7gktiZiBgZPr
         nMOjXPaxlqPCt22Upd0zq062BJz4QJGQBGK/HPKpAjjd8nV629tJKT4MoOkqXjRDBIKi
         i9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778685455; x=1779290255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IAILRg2BfARetbiC0BgMl/F7/7byROtZ7INl1EVwMRo=;
        b=Oxpny45LbehsQRx1j38rQ3EqmVFryY3s2q7Ltk3Zr9Tbuwct73NSF0orSBchHAJZZ/
         60O8jClTYdwrMaGGgIM/PgZnv6Me6UeGUmgo6L5UY+cya8oUfkRP3RPfFc3JcL8jTBz9
         TjnUO/Ot4dE6VpvbPcWmtHHPToqwgNoGsBsyKwG6AxeztxiYv9RPQoTd5fG3q3h6kE9A
         csE0yOFnqs6PWW8u7klRSUtuTfCPwbJR23j6ky3VuBAZjCcvW3753v7TnHyke8hf0i9g
         h9J7orNpCE73kuuaI+W7KFtGsuNH2kdnBwStl2KaX9Z9TiN8XX61HcEBihshEWonM9dt
         rzbg==
X-Forwarded-Encrypted: i=1; AFNElJ+tEKIc1VDxQ0OqZ/gI2VSPTAn/2QTG5FU6AGyfZAsb0cO2AmyusMd5NowOMS0YwfvdhGL8PhA4Sm299gio@vger.kernel.org
X-Gm-Message-State: AOJu0YzRilnczNGSDh3DPTBp4E1kHHRwT+Cmae0i6YiqbAOEToLLwlYD
	Juvn81kgOUW7IUZjrhZ4nCgtAZl7yrF+bydV6pc2UPK8tqxr2Oh58wrLCLPr/Op7C+1hX8Kk3Rr
	Gd9NxEJ7LGCwvNVhuwuyEuKxm4pfkuww=
X-Gm-Gg: Acq92OH9/OoWT3ZcDrsDyZwo+Zz9hcDTe97SD+KLsSuce7Niw7mI14crQDOLKvBKmIy
	jcOWFRRlhcycKUu0ukAu+5xSGdQrtRtaUdF7B+StGch4a4F08QRI3+I4YM/+/D/uK2xeWZXhfgu
	jgfnV7WvlARTZOJQG4mWSJIxRHSSrB0R7K7os0XKWF4PRGC+TSuC4K4uBvQV6+vjzJJI/6HpnpB
	AJg1dkExAPDqbttaLLYRxnf5pPxEwfIvEJ8/GybXBuekOs2I9LV+JqDpUlmPY6DE8/Km5kJG4kC
	3pUgSVFq
X-Received: by 2002:a05:690c:b04:b0:7b3:3cbb:d71a with SMTP id
 00721157ae682-7c6ada4b42emr25020957b3.4.1778685455319; Wed, 13 May 2026
 08:17:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513112156.9122-1-linkinjeon@kernel.org> <20260513112156.9122-7-linkinjeon@kernel.org>
In-Reply-To: <20260513112156.9122-7-linkinjeon@kernel.org>
From: CharSyam <charsyam@gmail.com>
Date: Thu, 14 May 2026 00:17:24 +0900
X-Gm-Features: AVHnY4LTtlMbFv0B_uA_27wiNIMIMP6alkGMitAVWp8dZS1LiE5MTQI0gX0GVdc
Message-ID: <CAMrLSE5gy79ph8B_di8GpzzNSsvyOporLMFTSP3QPSroa5UK+A@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] exfat: add data_start_bytes and
 exfat_cluster_to_phys() helper
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, brauner@kernel.org, 
	djwong@kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org, 
	anmuxixixi@gmail.com, dxdt@dev.snart.me, chizhiling@kylinos.cn, 
	chizhiling@163.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Namjae.

The calculation looks correct to me. I just have a minor naming suggestion:
since this helper returns a byte offset, while exFAT already has
exfat_cluster_to_sector() for sector-based addresses, would it be clearer t=
o
name this helper exfat_cluster_to_phys_bytes()?

Thanks
DaeMyung

2026=EB=85=84 5=EC=9B=94 13=EC=9D=BC (=EC=88=98) =EC=98=A4=ED=9B=84 8:27, N=
amjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> This caches the data area start offset in bytes (data_start_bytes)
> and introduces a helper function exfat_cluster_to_phys() to compute
> the physical byte position of a given cluster.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/exfat/exfat_fs.h | 8 ++++++++
>  fs/exfat/super.c    | 1 +
>  2 files changed, 9 insertions(+)
>
> diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
> index 6e7fd6822b01..415f987afa9a 100644
> --- a/fs/exfat/exfat_fs.h
> +++ b/fs/exfat/exfat_fs.h
> @@ -227,6 +227,7 @@ struct exfat_sb_info {
>         unsigned long long FAT1_start_sector; /* FAT1 start sector */
>         unsigned long long FAT2_start_sector; /* FAT2 start sector */
>         unsigned long long data_start_sector; /* data area start sector *=
/
> +       unsigned long long data_start_bytes;
>         unsigned int num_FAT_sectors; /* num of FAT sectors */
>         unsigned int root_dir; /* root dir cluster */
>         unsigned int dentries_per_clu; /* num of dentries per cluster */
> @@ -400,6 +401,13 @@ static inline loff_t exfat_ondisk_size(const struct =
inode *inode)
>         return ((loff_t)inode->i_blocks) << 9;
>  }
>
> +static inline loff_t exfat_cluster_to_phys(struct exfat_sb_info *sbi,
> +               unsigned int clus)
> +{
> +       return ((loff_t)(clus - EXFAT_RESERVED_CLUSTERS) << sbi->cluster_=
size_bits) +
> +               sbi->data_start_bytes;
> +}
> +
>  /*
>   * helpers for cluster size to byte conversion.
>   */
> diff --git a/fs/exfat/super.c b/fs/exfat/super.c
> index cb2f8eefff99..388db271c6bf 100644
> --- a/fs/exfat/super.c
> +++ b/fs/exfat/super.c
> @@ -499,6 +499,7 @@ static int exfat_read_boot_sector(struct super_block =
*sb)
>         if (p_boot->num_fats =3D=3D 2)
>                 sbi->FAT2_start_sector +=3D sbi->num_FAT_sectors;
>         sbi->data_start_sector =3D le32_to_cpu(p_boot->clu_offset);
> +       sbi->data_start_bytes =3D sbi->data_start_sector << p_boot->sect_=
size_bits;
>         sbi->num_sectors =3D le64_to_cpu(p_boot->vol_length);
>         /* because the cluster index starts with 2 */
>         sbi->num_clusters =3D le32_to_cpu(p_boot->clu_count) +
> --
> 2.25.1
>
>
