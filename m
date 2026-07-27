Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FC92D0615
	for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2026 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785116704; cv=pass; b=kO5PnoKVrUb4Ba5huzn8LJ6uf9fLAjBGpLkXQO5nDZnA/CyrFRN+lTINuaAr1PpGBQtQNX8Hh0mnAZtj28SNnfjaSJrSU2gr43ynpXSQTbYmlG+sx2dYyjD1RqIc8g9i6mmmOBNdGCW8R9Z0DMpnB6KHBg1pah+Qn2cXlWkU5J0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785116704; c=relaxed/simple;
	bh=GpPVqK0yedI7MogcuOKKw0y9EmEKpyxWE9J7owI0ioU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jXYifnHwXCBehkyz0lwbAuFuR/CpNFkGoA46aOfIBp5rzu06xi9niMAas1+IXtojZIAotmQTxauOnZB/N7VQyP4GBm7Vp6NLdr5PrpSwEkyP8p8XjSUXr35gz9L9FZBsljck7UoCe4Mf9XEQSrV33fN3aa4PwiD0IEiPsmQ+yLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRUPeRq0; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRUPeRq0"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so20041401fa.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 Jul 2026 18:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785116701; cv=none;
        d=google.com; s=arc-20260327;
        b=DUyQt3ephPEdPkZH1/1vyQjGUM6Y/mrMTatziS2KX3XR7vPe3Pa/0vGb5zqcWVdEe7
         JevlmDMERSU4L1JpHYTXoHT4/c3Imo8aTg2Mi74rR6zLsr9wbHt8U9ayOdo11HkkKAAZ
         BADkV8hCcOC2vuzw9LD3MuQLJN29lBxDuStpUmDfo5zr7xofUdSWXWif0LaFIA0EVEaw
         xtahnLelgOVM2D9LT4nk3KaDveW9sR7tveAbQOV0eYjpctyBCwmEL+13/dPPZDV1Y2Qh
         ZGcR6jwk6OAPiMA2B6i9RXnIsKR8+pBPrH5HpOPIfXukxFvPdxDMOMzsB5ytDa1jyqx5
         5rIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kP+3DJgbSuTQTP0Qr8L5IJefZbj+1ZijbjemjjV/pQs=;
        fh=nvtUOxwGLj+JixrjIjalo5YGk+AOZvWx1QyMy711wXM=;
        b=KHlnqDvkWwqaUa5nrad9AUWIrFlJqrpXGUlZXuq3+fv8sqERtpgJ7n3yUF9nFQV1Xk
         wo6BqB0NXZd0+s5PP933kupz11wCJCwnGUFW9BwTGawuI98I/cMvgjQrx0miXllc+eIe
         C3RwUXJDNV2LSyjfr+yyxdn8CebUfCnY9/jcjg1/vAICkEhkAHZbG8N6mb+ZOcsxTco/
         zmwDJG2NQ4DSkdJzfHffNfLZrxFhqY6mZZqQPZAxn14lXMUO89dcU45yUDSj4MqPeyBz
         Cdlz+3g66dq2J9bS35xroshIkpssLTkwGjmQarl5N0WBauxiEMaYLMjOJ/MxJ+mbvGnC
         B+1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785116701; x=1785721501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kP+3DJgbSuTQTP0Qr8L5IJefZbj+1ZijbjemjjV/pQs=;
        b=TRUPeRq0z0cw/Bd8bGxdH6z1ug73Y/KHn4XVB4gjRgk1eSHMFROQj5VCV+e3ey4VVR
         ERBikHs7lfHvU1FG0Skwt16i5d9JB26THIPtKjy5tpkBatYXKMzY8MWqSLA0yF4BkZs6
         3/xCh3kFaov62Yk9tRFZ4Iftg6hpnR/hQ2iwTQw4Kry99vtRBBoWszU1asinXtkfs53x
         8TEdPzQ8+dOedsFAEmqOK4wSsVerdPx0rEpaPtunvUznXGslc+fZq6fBiSwxU0Eeoojm
         UUit0+GWl4FMS4jNp8WaVhBzlUW2mgUsJdPt4uCgM9SonVBzWlmrAEA/QJKSS5PvSyR5
         DE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785116701; x=1785721501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kP+3DJgbSuTQTP0Qr8L5IJefZbj+1ZijbjemjjV/pQs=;
        b=dxy/iStY9oULdSDdd7kdSRPCZJWPJe9asME696XV4TeqHPTgeCaNiB80sVW8HktU5u
         GzV2CCOv+jDXlz485lzCNXLK/M0HBMfPp96Kt+rNMaBriaUz91un+HPojWtnl3TAVO0e
         0/ZmM+uZ7IUbp7O8KehWnJbsJQNr3PV/VxXG8XErZq9PEX3JBoUC5Ny2yzF4FoIuT55H
         brxzKzVPvgBzjJ1ySaY9XAd9Vyr/boyjG4yNlQ2e3nFGIt2ywqfPrP4UO84QADy5Nl7A
         uOJqMtMoXIfclu9hNQVxbmBYsxRHlKUMRMNepsZ7nBnCr35Y90c4uzBCrQ7LEOfcnSxI
         t5kg==
X-Forwarded-Encrypted: i=1; AHgh+Rqm7ZearNSI71U8JbJZ9+t7AS2uz/HYXSs11ED1No7cqPMvEfZUw03/OU/Kyep9i7dgiAkdIVvBr7ly9/jw@vger.kernel.org
X-Gm-Message-State: AOJu0YwWNjWvhPcIclP/saTa95nmu8p5t+lHXE/Cqn2itWue5gD1u9/C
	mUi7QA+1L+VFCfXMIQ1QZn20rNntZRN71iodPjGIfwXWiAO9bszN16PaxahHoEOZ/XAxID+i7HO
	xebQ0kFZSRx2zbtEnsmWGKWzPAm9FI2k=
X-Gm-Gg: AR+sD106dGe8CJXXxkesFHIw0oWasI6u4yev6CTRBZl89vxu6MTUxDxEmpVmh7eBZRF
	9KHCVr++4IlDk8yXsIoE0dCe2m3VUScjl+RBlXnESa2QS9gRaXzzm8w03WHgr66P/3yOQBF9kjA
	jmiliQMewOSm6fJis2TbdS3ZT7bwK1rM8MEBY+spfHBUeUvo0XkaGsKYtIEl08VhtgQNf1VADEt
	uEW1u4ay7QXhQhBE4ZrPycMAPq8N7An0F//iVP9VswwRoic+48RqsshgHE4ZQ==
X-Received: by 2002:a05:6512:2351:b0:5ae:b969:417d with SMTP id
 2adb3069b0e04-5b2c1abf0ccmr1207806e87.0.1785116700314; Sun, 26 Jul 2026
 18:45:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726-b4-disp-9cd2a8a2-v1-1-8d66c6dceac4@proton.me>
In-Reply-To: <20260726-b4-disp-9cd2a8a2-v1-1-8d66c6dceac4@proton.me>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 27 Jul 2026 10:44:48 +0900
X-Gm-Features: AUfX_mzBW712rPgRVkvS8eIPzeTBF7pkrZhvHO3OPVMOgiixtgb_q9TmtN_9pAg
Message-ID: <CANFS6bYise8cD8AttfFMnLkmGRzwGxQriOWTavRZo7nCQwiRJA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: bound the free-cluster bitmap scan to the volume
To: hexlabsecurity@proton.me
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-kernel@vger.kernel.org, 
	ntfs@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 27=EC=9D=BC (=EC=9B=94) =EC=98=A4=EC=A0=84 8:29, B=
ryam Vargas via B4 Relay
<devnull+hexlabsecurity.proton.me@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> From: Bryam Vargas <hexlabsecurity@proton.me>
>
> vol->lcn_empty_bits_per_page is sized from vol->nr_clusters at mount, but
> ntfs_cluster_alloc() bounds its scan of that array by the size of $Bitmap=
.
> Those are independent on-disk quantities and the mount-time check only
> rejects a $Bitmap that is too small, so an image whose $Bitmap covers mor=
e
> clusters than the volume has lets the scan index past the array.  A run
> whose LCN lies in that gap takes the allocator straight there, since the
> caller passes the file's own last LCN as its locality hint.  KASAN report=
s
> a slab out-of-bounds read when a file on such a volume is extended.
>
> Clamp the scan to what that array covers, mirroring the max_index
> calculation the mount-time scan already uses, and reject a decoded LCN
> at or beyond nr_clusters in the mapping pairs decoder.  Conforming
> volumes are unaffected.
>
> Fixes: 11ccc9107dc4 ("ntfs: update runlist handling and cluster allocator=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
> Either hunk alone stops the access; they close it at different levels.  T=
he
> clamp bounds the index whatever the caller passes as a hint.  The decoder
> check stops a run pointing outside the volume from being accepted at all,
> which also covers ntfs_cluster_free_from_rl(), where the only test today =
is
> lcn < 0.  Happy to drop either one if you'd rather keep it minimal.
>
> Reproducer.  A volume whose $Bitmap covers more pages than nr_clusters
> requires, with one file's data run placed in the resulting gap:
>
>   truncate -s 13G img && mkntfs -F -f img
>   mount -i -t ntfs -o rw img /mnt && dd if=3D/dev/urandom of=3D/mnt/v.bin=
 \
>       bs=3D4096 count=3D16 && umount /mnt
>
>   # $Boot total_sectors (0x28) -> 1703936*8, i.e. nr_clusters =3D 1703936=
,
>   # just above mftmirr_lcn.  lcn_empty_bits_per_page then covers 52 pages
>   # while $Bitmap still spans 104, leaving indices 52..103 unbacked.
>   # v.bin's single data run (3-byte LCN delta) -> LCN 3000000, index 91.
>
>   mount -i -t ntfs -o rw img /mnt
>   dd if=3D/dev/zero bs=3D4096 count=3D8 >> /mnt/v.bin
>
> mount -i matters: without it the ntfs-3g helper takes the volume and this
> code never runs.
>
> A/B on v7.2-rc1 with KASAN, one arm per boot:
>
>   unpatched, crafted image:
>     BUG: KASAN: slab-out-of-bounds in ntfs_cluster_alloc+0x249e/0x2db0 [n=
tfs]
>     Read of size 4 at addr ffff8881029dad6c by task kworker/u32:6/96
>     Workqueue: writeback wb_workfn (flush-7:0)
>      ntfs_cluster_alloc+0x249e/0x2db0 [ntfs]
>      ntfs_attr_map_cluster+0x444/0xf50 [ntfs]
>      __ntfs_write_iomap_begin+0x8b7/0x22c0 [ntfs]
>      ntfs_writeback_range+0xd3/0x130 [ntfs]
>     Allocated by task 2255:
>      __kvmalloc_node_noprof+0x1cc/0x5d0
>      ntfs_fill_super+0x16c0/0x6fd0 [ntfs]
>     The buggy address is located 156 bytes to the right of
>      allocated 208-byte region [ffff8881029dac00, ffff8881029dacd0)
>
>   52 pages * sizeof(unsigned int) is 208 bytes, and index 91 is offset 36=
4.
>
>   clamp only:    clean; the volume mounts and the append completes
>   decoder only:  clean; the run is refused
>   both:          clean; the append returns EIO and the decoder logs
>                  "LCN >=3D nr_clusters in mapping pairs array"
>   pristine mkntfs volume, unpatched, same operations: clean
>
> The write side takes the same LCN.  A kprobe caught
> __ntfs_bitmap_set_bits_in_run() with start_bit=3D3000000 count=3D16, whic=
h lands
> on the same array through ntfs_set_lcn_empty_bits(); KASAN reports once p=
er
> boot, so only the read above splatted.
> ---
>  fs/ntfs/lcnalloc.c | 7 ++++++-
>  fs/ntfs/runlist.c  | 7 +++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ntfs/lcnalloc.c b/fs/ntfs/lcnalloc.c
> index 835a041023a2..aa2e017a4384 100644
> --- a/fs/ntfs/lcnalloc.c
> +++ b/fs/ntfs/lcnalloc.c
> @@ -298,7 +298,12 @@ struct runlist_element *ntfs_cluster_alloc(struct nt=
fs_volume *vol, const s64 st
>         clusters =3D count;
>         rlpos =3D rlsize =3D 0;
>         mapping =3D lcnbmp_vi->i_mapping;
> -       i_size =3D i_size_read(lcnbmp_vi);
> +       /*
> +        * lcn_empty_bits_per_page is sized from nr_clusters, but $Bitmap=
 can
> +        * cover more clusters than that; bound the scan by the array.
> +        */
> +       i_size =3D min_t(s64, i_size_read(lcnbmp_vi),
> +                      ((s64)vol->nr_clusters + 7) >> 3);
>         while (1) {
>                 ntfs_debug("Start of outer while loop: done_zones 0x%x, s=
earch_zone %i, pass %i, zone_start 0x%llx, zone_end 0x%llx, bmp_initial_pos=
 0x%llx, bmp_pos 0x%llx, rlpos %i, rlsize %i.",
>                                 done_zones, search_zone, pass,
> diff --git a/fs/ntfs/runlist.c b/fs/ntfs/runlist.c
> index cbb6576cf725..74f94b4b6c5b 100644
> --- a/fs/ntfs/runlist.c
> +++ b/fs/ntfs/runlist.c
> @@ -880,6 +880,13 @@ struct runlist_element *ntfs_mapping_pairs_decompres=
s(const struct ntfs_volume *
>                                         ntfs_error(vol->sb, "lcn =3D=3D -=
1");
>                         }
>  #endif
> +                       /* Check lcn is within the volume. */
> +                       if (unlikely(lcn >=3D (s64)vol->nr_clusters)) {
> +                               ntfs_error(vol->sb,
> +                                               "LCN >=3D nr_clusters in =
mapping pairs array.");
> +                               goto err_out;
> +                       }
> +
>                         /* Check lcn is not below -1. */
>                         if (unlikely(lcn < -1)) {
>                                 ntfs_error(vol->sb, "Invalid s64 < -1 in =
mapping pairs array.");
>
> ---
> base-commit: 4235cb24ec1e8e96843f3671ba4da2a6ccca2c7b
> change-id: 20260726-b4-disp-9cd2a8a2-007c3a970c87
>
> Best regards,
> --
> Bryam Vargas <hexlabsecurity@proton.me>
>
>


--=20
Thanks,
Hyunchul
