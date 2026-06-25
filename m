Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DE12D94B5
	for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jun 2026 05:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782366188; cv=pass; b=DKiDzWPR3RPH4+cKwtUTq8XrAZFHafEhXrf+9GRbniuQAvkE97WD2C/CNTd5/LZXc5D2uoo/rPfrRd7XAY07Ofdz0YTF2SbeLTXjJevm9vjGURwYn6EJUnyvGnow0HbXYsE8AmNK+sgqPD2DzAypP5nfxLV5GHPH4+Je1e5ykMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782366188; c=relaxed/simple;
	bh=P/RMIaxSIoQXB/8hXHK6QguQprn30RPlcIydXBzwJIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRKuTUq9WBP45lNDaSaBaJHTeUQG5KhD1fc7dWI7g8FL9+WAZs9X6JZMYJq4PeDPGaynUHezdF+kFkS36IiOabjgA+rtT81cz41dVFOd7vZUl7iP5jW1AT/Ua4Qzote8JYxDoIxX7CYZgpxhGwZOsrBfY1Tl3WiizYeYHYlTCbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qSZpr8Jp; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qSZpr8Jp"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso1779242e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 24 Jun 2026 22:43:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782366185; cv=none;
        d=google.com; s=arc-20260327;
        b=gEIJulRMVRMwGFxWOPWIx3ezNQDWioA8JH9QTi34NEebZOL8P0dqF57lHU+JUF44OG
         d9q8/xRzQe26VBCwP8e26nR58CNbRCHL8C40FSdTVLS8LMFxk4qIQegaWTGlA2d8Sm6P
         O0Tbv8fAZ+Gcs4xmpPWQaIoLEC6HXLiBjgq3xA+y+fiYtEuz1hIAnSyP4TSwUL9vTaeL
         M7FVi6nsY7rc3kTECpNV3mHw9ou4lzeS/CP3gnMlLDbcpaHbPmZx9U+p5qY9qRgNTIvJ
         j2erLj+ruEv2tnndMUJqd5p6EvULfooYZVuCOHZLkQhzwQvJ+x85p7njqCy6rkFYW2vC
         FkHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EKwQKVDfnoelRxF42t3iF9tvLsKaov017czSk60O5mY=;
        fh=xCPT9vTlUG+VxuxdXA0MZnsV+iu9y3I9cMIw7lP5Vqk=;
        b=YQ4AAIX030qeEAwvk/DbO2hAWMZcrfwza7IO22v/QfA8mftJh5ZgH1i8+D/SESyPGD
         cOE+LLpEe/Md4vabJA1bqMMB/uAgNjh/STYf8LT3qn7DGqPUYK9XG0Mz1srnhv3m6V96
         VRU9QHzNI3rL61sJ5ytgC5SR0OONPoFlWWfjwlk5SHkW9JRpUH2a+LUMccPQWI9wQBmG
         S+Nyuhm2jC8Yydy/QB6Jsr2aJk1NsfeZgZeZKv/q0IlGujOshcPHWbP1+1IXW9uw+F6V
         4a2xxxCTOyoj2qk9xzhzx/yV5P67S7bqrYJojwpP3oi2qG2yFwA6NLf1V+qsT+TKXz67
         +rXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782366185; x=1782970985; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EKwQKVDfnoelRxF42t3iF9tvLsKaov017czSk60O5mY=;
        b=qSZpr8Jpbw07LHj53i6BpQY7ybcMJyg26uzrkBpA8t5z9SlXL2cNrvF33PMw81PcKq
         Afsxu8XEGeNeTz1p+cdWLpVAXNWjR36fiXHVnpl2n3VGxFO4UxIslA30ASu+CZba0Vea
         w30YxpU4B8bsuYxeSIuoKVwjpZJWu6I7ZMc87UYyjHzCLWRsfqGltSOlyyhA0aKtFlPw
         FCbfOgVOZQra2JaM/tLxuOsC+bXEb/WZx1Y/jPbv/ynaUFWyG+7v19aKPdwI2ZEi1vBo
         cXM1AsG5Zpdty59BkrxKI3mCA8SCjHnvCrdujbWR+GxJCBvZPk0HNkyfJ71JEmjOxFoc
         2qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782366185; x=1782970985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EKwQKVDfnoelRxF42t3iF9tvLsKaov017czSk60O5mY=;
        b=F2oKMIlmT/lEBRQs/yJTGBCmNGNCHpYBJT6509bCicgTBZod6ZZ3zOrQVowgllC9Fb
         WcUXgbyEH4etBTHYGSV6mpHhJnV2dKYtSwulFjGhiEPIFYqrNHZswmXVwewgFZaknd+l
         TSAUGzCNm5pfionBvNheSX/gqZNkatjqw7+LOyiDFyEPI+eT14DOPE85qv6D2H3c4nSb
         gF+YMH9CzVykOmlD/WM+8SKQD/gpNqzuxF79LEkrryBthU0tdtMeFmz+3efjNiDvQtB7
         L9MIfmNValWkSt0Kt0e1JmXIKTJEay05ZWPjkyNJyTF9LIMNn1BHAbJbQQcFJH8jFZOl
         m0yQ==
X-Forwarded-Encrypted: i=1; AHgh+RrvgSUjQpWU6ALpE3/mSXcY7Hj8s1ihVZdX939R0VdYnN8PrX7jmxbvGzzUcjkH7wuHPx+Ld/WSoxcppA91@vger.kernel.org
X-Gm-Message-State: AOJu0YzMd5qfJ10yEdoT6Im3ImTqH+/shGE3wp5uskSpDVR5fI+pg8NL
	tFAjXuDK9xtaxmCtiR9moi7zTGvxtwBxo4qv8iG+ymBoJTOnYXz0XmxCJ8jWRvR9uhhk6cfPDPR
	mIPSTfWS+s3owgN/STAtSzhoO3edPAAA=
X-Gm-Gg: AfdE7ck1a/EUB/AqNSRh/eF1t0ENil76aCTffWje84RKKxVAQwPhZV8kFy4fR+YWYp1
	JSR0qjBd6MXEu9v5o6AheioKvFURwCI+Wn8ZZMYapYMDgrFirx0ZnV0DCyGzGoo6h4DUE8nbG+C
	DnOj+Kg15P2UUGmvd5cV8hE4SmfSUMFdw6svvXQpHxOzD8wfgAz8RlP4FBX3KOrQS5EUwoqHGzj
	2xCOU2kbrtxsGdClTTk9t5OOJm4EfubbWPUvuvM1f6Zgp1/R12IkPaus4FEAY5nrGN1lkDT
X-Received: by 2002:a05:6512:6281:b0:5ae:9ea1:a19c with SMTP id
 2adb3069b0e04-5aea1f28f57mr289240e87.3.1782366184654; Wed, 24 Jun 2026
 22:43:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260625044547.3729183-1-zzzccc427@gmail.com>
In-Reply-To: <20260625044547.3729183-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Thu, 25 Jun 2026 14:42:51 +0900
X-Gm-Features: AVVi8CdwIjZNvd0JLPGbgY5jfF-SDUYI7AlFBYDRBYpOhRNGMQjHUw8jNPEUElw
Message-ID: <CANFS6baCEfndqr+7yh1xMmaRvmmcccuuZq+Y28hByysH8f4khA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: avoid stale runlist element dereference in MFT writeback
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 6=EC=9B=94 25=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 1:45, C=
en Zhang <zzzccc427@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_write_mft_block() maps each $MFT record through the $MFT data
> runlist. For sub-folio clusters it looks up a struct runlist_element unde=
r
> ni->runlist.lock, drops the lock, and later uses rl->length and rl->vcn
> when choosing folio_sz.
>
> That pointer is only borrowed from ni->runlist.rl. Concurrent $MFT
> allocation extension can merge a replacement runlist under the same lock,
> and ntfs_rl_realloc() can free the old backing array. If that happens
> between the lookup and the later folio_sz decision, writeback can
> dereference freed runlist storage.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> MFT writeback path:               $MFT allocation extension:
> 1. Look up rl under               1. Extend the $MFT data allocation.
>    ni->runlist.lock.              2. Publish a replacement runlist.
> 2. Drop ni->runlist.lock.         3. Free the old runlist array.
> 3. Read rl->length and rl->vcn
>    to choose folio_sz.
>
> Compute the remaining run length while ni->runlist.lock is still held, an=
d
> use that scalar after unlock. This preserves the existing folio sizing
> decision without carrying a borrowed runlist_element across the lock
> boundary.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in ntfs_mft_writepages+0x1c8d/0x1fb0
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x630
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x20d/0x410
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  kasan_report+0xe0/0x110
>  ? ntfs_mft_writepages+0x1c8d/0x1fb0
>  ntfs_mft_writepages+0x1c8d/0x1fb0
>  ? __pfx_ntfs_mft_writepages+0x10/0x10
>  ? __pfx___mutex_unlock_slowpath+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? iput+0x92/0xa80
>  do_writepages+0x219/0x530
>  ? __pfx_do_writepages+0x10/0x10
>  __writeback_single_inode+0x117/0xf50
>  ? do_raw_spin_lock+0x130/0x270
>  ? __pfx_do_raw_spin_lock+0x10/0x10
>  ? __pfx___writeback_single_inode+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  writeback_sb_inodes+0x65b/0x1810
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? __pfx_writeback_sb_inodes+0x10/0x10
>  ? lock_release+0x1e0/0x280
>  ? _raw_spin_unlock+0x23/0x40
>  ? move_expired_inodes+0x2b8/0x850
>  __writeback_inodes_wb+0xf4/0x270
>  ? __pfx___writeback_inodes_wb+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? queue_io+0x2e4/0x410
>  wb_writeback+0x666/0x880
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_wb_writeback+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? get_nr_dirty_inodes+0x1c/0x170
>  wb_workfn+0x75e/0xbb0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? _raw_spin_unlock_irqrestore+0x27/0x60
>  ? __pfx_wb_workfn+0x10/0x10
>  ? __pfx_debug_object_deactivate+0x10/0x10
>  ? lock_acquire+0x2b8/0x2f0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_release+0x1e0/0x280
>  process_one_work+0x8d0/0x1870
>  ? __pfx_process_one_work+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  worker_thread+0x575/0xf80
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0x2e7/0x3c0
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x576/0x810
>  ? __pfx_ret_from_fork+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __switch_to+0x57e/0xe10
>  ? __switch_to_asm+0x33/0x70
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1a/0x30
>  </TASK>
>
> Allocated by task 970:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kvmalloc_node_noprof+0x353/0x920
>  ntfs_rl_realloc+0x3c/0x80
>  ntfs_runlists_merge+0x1212/0x3010
>  ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
>  ntfs_mft_record_alloc+0x1ab4/0x4f10
>  __ntfs_create+0x680/0x2e50
>  ntfs_create+0x1e6/0x3a0
>  path_openat+0x2b55/0x3c10
>  do_file_open+0x1f4/0x460
>  do_sys_openat2+0xde/0x170
>  __x64_sys_openat+0x122/0x1e0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 1294:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x307/0x580
>  ntfs_rl_realloc+0x66/0x80
>  ntfs_runlists_merge+0x1212/0x3010
>  ntfs_mft_data_extend_allocation_nolock+0x3e0/0x1f40
>  ntfs_mft_record_alloc+0x1ab4/0x4f10
>  __ntfs_create+0x680/0x2e50
>  ntfs_create+0x1e6/0x3a0
>  path_openat+0x2b55/0x3c10
>  do_file_open+0x1f4/0x460
>  do_sys_openat2+0xde/0x170
>  __x64_sys_openat+0x122/0x1e0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: 115380f9a2f9 ("ntfs: update mft operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ntfs/mft.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> index a5019e80951b..fd20d7abd6f5 100644
> --- a/fs/ntfs/mft.c
> +++ b/fs/ntfs/mft.c
> @@ -2637,7 +2637,6 @@ static int ntfs_write_mft_block(struct folio *folio=
, struct writeback_control *w
>         s64 vcn =3D ntfs_pidx_to_cluster(vol, folio->index);
>         s64 end_vcn =3D ntfs_bytes_to_cluster(vol, ni->allocated_size);
>         unsigned int folio_sz;
> -       struct runlist_element *rl =3D NULL;
>         loff_t i_size =3D i_size_read(vi);
>
>         ntfs_debug("Entering for inode 0x%llx, attribute type 0x%x, folio=
 index 0x%lx.",
> @@ -2682,6 +2681,7 @@ static int ntfs_write_mft_block(struct folio *folio=
, struct writeback_control *w
>                                         &tni, &ref_inos[nr_ref_inos])) {
>                         unsigned int mft_record_off =3D 0;
>                         s64 vcn_off =3D vcn;
> +                       s64 rl_len =3D 0;
>
>                         /*
>                          * The record should be written.  If a locked ntf=
s
> @@ -2701,8 +2701,12 @@ static int ntfs_write_mft_block(struct folio *foli=
o, struct writeback_control *w
>                         }
>
>                         if (vol->cluster_size < folio_size(folio)) {
> +                               struct runlist_element *rl;
> +
>                                 down_write(&ni->runlist.lock);
>                                 rl =3D ntfs_attr_vcn_to_rl(ni, vcn_off, &=
lcn);
> +                               if (!IS_ERR(rl))
> +                                       rl_len =3D rl->length - (vcn_off =
- rl->vcn);
>                                 up_write(&ni->runlist.lock);
>                                 if (IS_ERR(rl) || lcn < 0) {
>                                         err =3D -EIO;
> @@ -2733,7 +2737,7 @@ static int ntfs_write_mft_block(struct folio *folio=
, struct writeback_control *w
>
>                         if (vol->cluster_size =3D=3D NTFS_BLOCK_SIZE &&
>                             (mft_record_off ||
> -                            (rl && rl->length - (vcn_off - rl->vcn) =3D=
=3D 1) ||
> +                            rl_len =3D=3D 1 ||
>                              mft_ofs + NTFS_BLOCK_SIZE >=3D PAGE_SIZE))
>                                 folio_sz =3D NTFS_BLOCK_SIZE;
>                         else
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
