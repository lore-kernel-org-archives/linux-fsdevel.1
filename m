Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA303DFC6A
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 07:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782460719; cv=pass; b=X64Gv+2SF8bod/BDkK4obGqsgoIwiuVZn7dekaZhU35ayrR35XRsyxnjhld0EANGNYi74CY3tILfVESOoMHf3PlS9I0basjdItAtaiZMgxOoML5Uqsjf1MwQVPZrh1ZUR3bVkod8T/8v/d1dnWoxFi4UzH8/3nxGJW2JeFwwPq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782460719; c=relaxed/simple;
	bh=g0HD81zpKLU7yfRoKS/aT1hZRYuyfOkVkg6RR9TFpnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h/AOMemULOK4OOAzP8k4YWLpD0Q+cZ25ygVPTQ8fj/bnG/YR5QuuVj09OGvT2aG+ULdicl51pAQJHWMJJCkh8P+26xVlgso1MlEUevQfMCZik5bihKEBZoeXnntm7zGY0dQb+WBwygFNPSohP4lii01W+bHIGSXfrWFPH0gjpC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHfeBXph; arc=pass smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHfeBXph"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39ad400e762so4396321fa.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 00:58:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782460716; cv=none;
        d=google.com; s=arc-20260327;
        b=VUaZOZs0L8kTzG53ondSO/yO/xr164FI6QzMQ4xU9buUnxO9tFNFkZy/8a3/3ftHys
         28UO0VLc9eq0Ug1LyufOTl9JeFVvPChJvBZQDe+WQ7Ke9/uc94WTdHqgMRNlcsrpaYed
         M+3Ti0Tbasz3H12t9phUXqTtWqtcVOrYSD9gmvVsa0bRbdP4VZyR3w8WuHGk1PwUm72h
         fetz8KcfFYs82A6Ow86DrZsgYGPw00t1bkTlEmawr4qFV1NKEXiiyP8CB1WM3a7PGTyu
         ndJ5NUmGpEctCDzxM9B24tS0wx0pyfrNgi2V4t+0gmzEpRBakSpISEJX9VHwT4fhvRm5
         F9xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EboQcNRyoWy32u1f0TF0o9YYezn1b7sgwBo6vz4RF1c=;
        fh=RZe0Zo7/XhwxjwazSpwnQ9mzTZcYqequVqYkag67q3Q=;
        b=Ms7Y5NSQ8kMfZPb0UQoRwhc3kgfmkxlzTJSzRvie5sI7o7xZ3a0KS+FfoR3vOo3zZY
         h4XrdyAbrjTjDDyeiXJ2Clce+iTKOs5959ruxPMQXEwPh/KddGQJTEURAw/JYd5KXDEW
         kRpClaZtbHGfx2xI37XmU/cfrCo6OcuDlpt7Ea6AyQiQJU3clqvf6z9+S00BEkwbGvwV
         +u8F5RaqIVVzqi7USsajgfO1TBA0+4QxfUZNdFOEAyZDoEAGBjCXs15xDoc4rN5eDk1C
         8vmD6qoTC9vH5P0cXjt5Bs0DvGj9XZuVwXPkicgHpvk+3NjwCG8K+gRGUnh+bwHZN+3e
         hCcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782460716; x=1783065516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EboQcNRyoWy32u1f0TF0o9YYezn1b7sgwBo6vz4RF1c=;
        b=iHfeBXphjBoU+UpS1HwbEFTaxPKUc2BPqw8cQGfoo1exjztpG1QOF2ZkElXRN/ZusT
         HhDQsFMMwa/NlW4c1d9crXu5Th9XpDZRuJTaOczG754g96y1298mGbClHcMDr1v0UtqM
         lJoYjLdBFjit/OD+t5Bs6OT7omqjJl13hnB92Rr/xVEOyR3uugswly8Row/CVwUkZCBK
         BIqXLC5zsA+oMU3HQEga2OxfxsDPT80DTAfqK/mbVVINiamdKP/GD8nVnKK1+SJ2shPf
         Hc8peifE9Hrb75j0lcBEX87iYYdyolAGuzKpJZSFADm+LSmwPPNwwoBCS/5oQDMDMoW9
         dTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782460716; x=1783065516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EboQcNRyoWy32u1f0TF0o9YYezn1b7sgwBo6vz4RF1c=;
        b=exUIHzplrUEqhEApK6PmAQGWMEmTOqI6wQmlxXF+G9N1sAM6d2KNEBYQ3kEgctHytT
         Fzetz4fECKoeUCJ26/g/d3USbal94gIKJG3nRHLOeYHbhV9nLXtuzyflpa4MXBkYNdQr
         ldAS5V5mkSRNMiYskRzi65fNMyNOALjAMFA8jFPl1YjtKPjOQHanjFqqAnqFGXUGyWJg
         ap+MdozAb1/f4m0hG3UdDXamU4elRL6eFFImhh1ZQPAeFy/3of1ca5ugnjJ6AVCB0m4r
         FMSetYwXhRaLC2EsZ8/mCdVZmAJG+yiRiUlpt1T7of5yReVi6yahf9SyIH2KzqWuNDHs
         Qhog==
X-Forwarded-Encrypted: i=1; AHgh+RrTYd9Oi596ew7yuLUVs7a1oWp8HL75T+HLk2Geu0S+noauoDqPt3AResALoNRY1yGLd0fy0sIIhmREe64J@vger.kernel.org
X-Gm-Message-State: AOJu0YwmdRYOdbZf/Phs5dnewJMor779iZugNejT+CwX/nRNB7EoCQJQ
	8a8+ch3N6WVFPVtAItIczSJmuPBlZt5X38H3u7cAORNREnb5c+mulE4kFQ8UHfPPvBr+TRYIHqn
	SYSEcv3RJCs4D5dvr/kgrl0p+mqKUw7k=
X-Gm-Gg: AfdE7ckSNd8xjFRJ9UBBCcSySUjSS0+nw6O/oy1mv7EQBa0+4rWwYHc5AzAXTq6piKv
	YeG8J4feCyggws69qtN/DWH7ltTcqPClR59qoPSbzNL510ENJnGTJ8tyUqSECOEnldl+NCsVSIP
	/SQmSUUirxR8mf46mOWKaxYTukQKyp+RczVhWA1MIF3N9FriH+bWi0WfZb9RA8XcIVMAakPxfSe
	6BYmbj84U15tHfDobOxB+3LEmdweVK6fQGoLIVSUvPgSRU7XVvDf20m6etjZNPRv8l3Rvvj
X-Received: by 2002:a05:6512:6712:b0:5aa:6a5c:be4d with SMTP id
 2adb3069b0e04-5aea1f2a5bbmr1609389e87.9.1782460715398; Fri, 26 Jun 2026
 00:58:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625083353.132243-1-zzzccc427@gmail.com>
In-Reply-To: <20260625083353.132243-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 26 Jun 2026 16:58:23 +0900
X-Gm-Features: AVVi8Cd4R6aeGlory-T9EBr-ab7fFxzZjkUzwGxmgY9EYLK6yhr0ANRBze9_bP0
Message-ID: <CANFS6baqSnmOYSAWF28sozgoGhyY-9zCDHy9ppmoOCr9POeuaQ@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid stale runlist element dereference in fallocate
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 5:34, C=
en Zhang <zzzccc427@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_attr_fallocate() walks the data runlist when it allocates holes or
> delayed allocations inside initialized size.  It looks up a struct
> runlist_element under ni->runlist.lock, drops the lock, and then reads
> rl->lcn, rl->length and rl->vcn to decide how far the current extent can
> advance.
>
> That pointer is only borrowed from ni->runlist.rl.  A racing mmap
> page_mkwrite path can enter __ntfs_write_iomap_begin(), map clusters, and
> replace the same runlist through ntfs_runlists_merge().  When
> ntfs_rl_realloc() allocates replacement storage, the old runlist array is
> freed while fallocate still carries the stale element pointer.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> ntfs_attr_fallocate():            mmap page_mkwrite path:
> 1. Look up rl under               1. Enter __ntfs_write_iomap_begin().
>    ni->runlist.lock.              2. Map clusters through
> 2. Drop ni->runlist.lock.            ntfs_attr_map_cluster().
> 3. Read rl->lcn, rl->length       3. Merge a replacement runlist.
>    and rl->vcn.                   4. Free the old runlist array.
>
> Snapshot the needed runlist fields while ni->runlist.lock is still held,
> and use only those scalars after unlock.  This preserves the existing
> fallocate decisions without extending the lock over the later allocation
> and zeroing work.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in ntfs_attr_fallocate+0xbb8/0xd00
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x630
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x20d/0x410
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  kasan_report+0xe0/0x110
>  ? ntfs_attr_fallocate+0xbb8/0xd00
>  ntfs_attr_fallocate+0xbb8/0xd00
>  ? lock_acquire+0x2b8/0x2f0
>  ? __pfx_ntfs_attr_fallocate+0x10/0x10
>  ? 0xffffffffc0000095
>  ? down_write+0x10d/0x1e0
>  ntfs_fallocate+0x5c9/0x1d00
>  ? __pfx_ntfs_fallocate+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? selinux_file_permission+0x3a7/0x510
>  vfs_fallocate+0x29d/0xd30
>  __x64_sys_fallocate+0xc7/0x150
>  ? do_syscall_64+0x81/0x6a0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Allocated by task 410:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kvmalloc_node_noprof+0x353/0x920
>  ntfs_rl_realloc+0x3f/0x110
>  ntfs_runlists_merge+0xaa3/0x3010
>  ntfs_attr_map_cluster+0x4e5/0xf80
>  ntfs_attr_fallocate+0x53f/0xd00
>  ntfs_fallocate+0x5c9/0x1d00
>  vfs_fallocate+0x29d/0xd30
>  __x64_sys_fallocate+0xc7/0x150
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 424:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x307/0x580
>  ntfs_rl_realloc+0x6f/0x110
>  ntfs_runlists_merge+0x7b1/0x3010
>  ntfs_attr_map_cluster+0x4e5/0xf80
>  __ntfs_write_iomap_begin+0x8cd/0x2280
>  iomap_iter+0x6de/0x11e0
>  iomap_page_mkwrite+0x391/0x650
>  ntfs_filemap_page_mkwrite+0x1ac/0x400
>  do_page_mkwrite+0x15c/0x280
>  __handle_mm_fault+0xd6d/0x1ca0
>  handle_mm_fault+0x19c/0x470
>  do_user_addr_fault+0x23b/0x9c0
>  exc_page_fault+0x5c/0xc0
>  asm_exc_page_fault+0x26/0x30
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

Additionally, we need to skip ntfs_dio_zero_range() if
clusters are not allocated.

@@ -5647,9 +5647,10 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni,
loff_t start, loff_t byte_len, bo
                                if (err)
                                        goto out;

-                               err =3D ntfs_dio_zero_range(VFS_I(ni),
-                                                         lcn <<
vol->cluster_size_bits,
-                                                         alloc_cnt <<
vol->cluster_size_bits);
+                               if (balloc)
+                                       err =3D ntfs_dio_zero_range(VFS_I(n=
i),
+                                                                 lcn
<< vol->cluster_size_bits,
+
alloc_cnt << vol->cluster_size_bits);


> ---
>  fs/ntfs/attrib.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index dd8828098511..73e01f32c067 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -5536,6 +5536,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, loff=
_t start, loff_t byte_len, bo
>         s64 old_data_size;
>         s64 vcn_start, vcn_end, vcn_uninit, vcn, try_alloc_cnt;
>         s64 lcn, alloc_cnt;
> +       s64 rl_lcn, rl_length, rl_vcn;
>         int err =3D 0;
>         struct runlist_element *rl;
>         bool balloc;
> @@ -5615,19 +5616,23 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, lo=
ff_t start, loff_t byte_len, bo
>         while (vcn < vcn_uninit) {
>                 down_read(&ni->runlist.lock);
>                 rl =3D ntfs_attr_find_vcn_nolock(ni, vcn, NULL);
> -               up_read(&ni->runlist.lock);
>                 if (IS_ERR(rl)) {
> +                       up_read(&ni->runlist.lock);
>                         err =3D PTR_ERR(rl);
>                         goto out;
>                 }
> +               rl_lcn =3D rl->lcn;
> +               rl_length =3D rl->length;
> +               rl_vcn =3D rl->vcn;
> +               up_read(&ni->runlist.lock);
>
> -               if (rl->lcn > 0) {
> -                       vcn +=3D rl->length - (vcn - rl->vcn);
> -               } else if (rl->lcn =3D=3D LCN_DELALLOC || rl->lcn =3D=3D =
LCN_HOLE) {
> -                       try_alloc_cnt =3D min(rl->length - (vcn - rl->vcn=
),
> +               if (rl_lcn > 0) {
> +                       vcn +=3D rl_length - (vcn - rl_vcn);
> +               } else if (rl_lcn =3D=3D LCN_DELALLOC || rl_lcn =3D=3D LC=
N_HOLE) {
> +                       try_alloc_cnt =3D min(rl_length - (vcn - rl_vcn),
>                                             vcn_uninit - vcn);
>
> -                       if (rl->lcn =3D=3D LCN_DELALLOC) {
> +                       if (rl_lcn =3D=3D LCN_DELALLOC) {
>                                 vcn +=3D try_alloc_cnt;
>                                 continue;
>                         }
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
