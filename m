Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B883E1D06
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782459027; cv=pass; b=urzJpKIGTm+1vosDceyPlaXIE613Qo90+6y73KJezksTNHZmmaMPEFP6yHTsFD00Bkyb71X4GPwV+QmrdRYKSd+hExsf4En7byDlrpKlnMUnYHXfmXnHTILT+xmZfGwY+zBATYdcZ46bH+VoWTkxkHS97WdStIkqA1yWiJHLMnw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782459027; c=relaxed/simple;
	bh=6/AJnmGRYbJrMjs7SYjlFtmXEHumw/A5YA0p2fmnWMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kv+0mSib/TJJDrWIhZbLLxFQ38zVKPfroCx7iTFcLKKhavs9p9OdE7+CBvmGn2IrZESnTlB5ei2XE+jKr/wFaJm+a/GpCn322Z1eu6rYhbA9tD8wCjBYRU5TFndpoI/4ZfN6cjHfLA8dSBphhwH7G/i1nfhh8CqbIcbZnD53I4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NQglTadE; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NQglTadE"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5aea1f4dc7fso573193e87.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jun 2026 00:30:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782459021; cv=none;
        d=google.com; s=arc-20260327;
        b=F7acvgkzAQNDD3GdtnyByZNAO7rTjI2E3/fvwaafMvZInGnm8wm7PebkbcSudhoa8y
         mTVw7MFzTAwXdpSeOO39mC+cdvQ18YPBmYJViRd196nTmzSx/qjw3KEjnp3QU3rtVhaF
         csZu0UYLzIR7sqQt14WBWOPmN5sboGn+Fhs8+aSMFeiu0KTjk9GvNHjCS+JKYLi9R8t5
         in/pZ1xucSIa4viCZX8ATm+YAN4jwfgkXjSw8+sh5mnKiTxUuSUkkYzMl2APKLcWMRIP
         wQ3eGnuclsB6ywZmtZZUYQRCBBxDyYE5pk/sQOZh8QhShBOtysG/MlgBXtDROrhy0E6i
         F3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6SstXhss0PdDiq5C0d81xW/sKjUgwWnFwIyjTzjdLs=;
        fh=roSAsWRWV2XQIm9Il6my8FCZvmZ3fZ/jWyQi94FXUI8=;
        b=Fil55d6vR+sVr15oxBjT+Hp8ANE8quZAJ0qi6FGnejD5gIt27jnV3k1zucuAnYR3nP
         wZuocm1+yrb9hiyzQaJXN9AoxV5GOCDRJ5AeqB8zfwWI8JJZw9Ay277aACww3+Orkh5G
         u575m2qJOO4mZXijv/Wudugs7H7DLFKruJWtSauPM2CIzLcHj4HVZ1pRSCo7DBZWw5MM
         5ohrke6bvYoisYzvXfaYPeukZhMaQG9+iIfbRLdoQgi0Qd95VUtgbZXDTI24Pr5Npbbl
         CiasFpJ0t1gPrt0AJyXnsnKw+cYwkNnPMcV2OuA85fiQvSA8wntpqI5aN0QTmSaQBQza
         cgHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782459021; x=1783063821; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v6SstXhss0PdDiq5C0d81xW/sKjUgwWnFwIyjTzjdLs=;
        b=NQglTadESRmUdGYkvLQUvEyeFgJWcFaPArdA5KgLPk8HOTRH+jTNq1qFV/LkUL4Xrz
         uF8AALk4tT6X872ZhvLorp0os6vqWwe5r1G8knwguO1zFEQh96tjxnCkv84N8oSgp9aN
         VunBRSHtQ91T2s/Yub0dgUvH8xRAUV5rWsbtEnlDfVaTtPpU+3t10thstr7CBJZ7mpHN
         3HewjAps+6fcB1WMPyi6jmd1EbIV73l/YKUZipVH0VS0T58ChDd9rSadtpH2JwsOuEt5
         T/eB4p533/ngbaMoQKwS2EC1cn8KidpVZQ47fPxa5XkkqYgRAH6xZIsmAJHk4cbKeOeQ
         S+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782459021; x=1783063821;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=v6SstXhss0PdDiq5C0d81xW/sKjUgwWnFwIyjTzjdLs=;
        b=HA5UIe2z0yrJ/bfbaGw2/zTdH7Q2pK4Sj9pQmXcl35aTtnkaY33G/tQ7HfPtSZ42or
         2e4zv2kJj0JDegGrOosuC08/eUwxvvDgcYgBvrtfdqHHRTqETq3gY+uEy0NZoH/H0bU4
         vE1sBINqiZO6kahSiVnT9bjFp5PSF4i1qJCuTAkc/PszLmWHYFCzYSNG4eQvXjwwNd5o
         PSd9tb7NtmAFYyF2u8BdE5IAxn+ppz+ZRnKr7eXULOtz45UUN5PbZXvPAQki2AfRciYa
         umM5GQg84AX7Y3+Wi6Hz+Pe7y2sHNZIW9jvYSs6mgyGFp3+uMMXRpL6Y/8GvG+59hv4w
         VgIw==
X-Forwarded-Encrypted: i=1; AHgh+RrzQTOwzWjQngZHofawdbIqOz43ys24YkoDqyBu9R6pBfT+naGPdPpD3wmC4Ub6IJhKzivOwPwfyo5hTU8G@vger.kernel.org
X-Gm-Message-State: AOJu0YztYu0VRTIxsjqTfQuMMlkzihI+k/XED/TDkNghWEaFAklVX9fX
	1a2GJJ5/9h4eFWYGjc+M27KwxhCXf5qhs4H9AiprIv1lUMLYyHGBS42AjkMIqazBR0EdjvJtuDT
	wC38zRrN2pZgXV3WZo+5hPLkQFbEyYZ4=
X-Gm-Gg: AfdE7cnM+f0PfBaWFqewpZ0yoY+LEJ0NTvddHjJQr7Ppuwq5Q4igUytgBTuRORZYLxK
	LNEAd+6rTe6tMmpBhM4ERKsMeCXDyXYVRQ00+9MGcjTuL+ZImTeSuiPFjsOQIQRqEqRXvzn9FwW
	j6thRBS7e+WtRjjLOX6p6RvQRWb9aNyGybkrC7Nl3hOuyjGF3pOoPGtTnxwJvB8lyP/RqeeLS+o
	xBc2+KzD+py4Gyxwq+CR/qgkY8TIBYZomDGL5CnnYM5D3n5bsz9JGuOh7JtXEGx1amG7+MK
X-Received: by 2002:a05:6512:1044:b0:5aa:62df:cd0f with SMTP id
 2adb3069b0e04-5aea1e1f070mr1619670e87.2.1782459020915; Fri, 26 Jun 2026
 00:30:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260626014706.2840003-1-zzzccc427@gmail.com>
In-Reply-To: <20260626014706.2840003-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Fri, 26 Jun 2026 16:30:08 +0900
X-Gm-Features: AVVi8CcnifJ_PghxWOoClsn9uJKFtou6aPQnd4IdgHQWRFR_IYWUAsBmCoSceqk
Message-ID: <CANFS6bYPxyfkSDeUH8vHyjjRNSnP-tgHSEHogA8-ZRiEKqnDsA@mail.gmail.com>
Subject: Re: [PATCH] ntfs: serialize read iomap lookup with mrec_lock
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

2026=EB=85=84 6=EC=9B=94 26=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 10:47, =
Cen Zhang <zzzccc427@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> Take the base inode's mrec_lock in the shared read/seek iomap begin
> wrapper so both resident and non-resident lookups run under the same
> serialization already used by the write-side metadata path.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
> read/seek iomap lookup path:
> 1. Enter __ntfs_read_iomap_begin().
> 2. Enter ntfs_attr_lookup() / ntfs_external_attr_find() on
>    base_ni->attr_list.
> 3. Keep raw attr_list_entry cursors while mapping the extent.
>
> attr-list mutation path:
> 1. Enter ntfs_attrlist_entry_add() or ntfs_attrlist_entry_rm().
> 2. Publish the replacement base_ni->attr_list.
> 3. kvfree() the old buffer.
>
> Validation reproduced this kernel report:
> BUG: KASAN: slab-use-after-free in ntfs_attr_lookup+0x24b2/0x2bf0
>
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x66/0xa0
>  print_report+0xce/0x630
>  ? ntfs_attr_lookup+0x24b2/0x2bf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __virt_addr_valid+0x20d/0x410
>  ? ntfs_attr_lookup+0x24b2/0x2bf0
>  kasan_report+0xe0/0x110
>  ? ntfs_attr_lookup+0x24b2/0x2bf0
>  ntfs_attr_lookup+0x24b2/0x2bf0
>  ? ntfs_attr_lookup+0x9/0x2bf0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? 0xffffffffc00000da
>  ? __pfx_ntfs_attr_lookup+0x10/0x10
>  ntfs_attr_map_whole_runlist+0x488/0x8b0
>  ? __pfx_ntfs_attr_map_whole_runlist+0x10/0x10
>  ? __pfx_do_raw_spin_trylock+0x10/0x10
>  ntfs_attr_vcn_to_rl+0x13a/0x1d0
>  ? filemap_fault+0xf03/0x2080
>  ntfs_read_iomap_begin_non_resident+0x142/0x920
>  ? __pfx_ntfs_read_iomap_begin_non_resident+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __pfx_ntfs_read_iomap_begin+0x10/0x10
>  iomap_iter+0x6de/0x11e0
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? prepare_alloc_pages+0x1c4/0x4d0
>  iomap_readahead+0x239/0x910
>  ? folios_put_refs+0x1ed/0x4f0
>  ? __pfx_iomap_readahead+0x10/0x10
>  ? __pfx_folios_put_refs+0x10/0x10
>  ? lock_release+0x1e0/0x280
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? xas_store+0x871/0x1650
>  ? xas_find_conflict+0x64b/0xb90
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_release+0x1e0/0x280
>  ntfs_readahead+0x193/0x1d0
>  ? __pfx_ntfs_readahead+0x10/0x10
>  ? __filemap_add_folio+0x869/0xa60
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? __pfx___filemap_add_folio+0x10/0x10
>  read_pages+0x18f/0x890
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? folio_alloc_noprof+0x69/0xb0
>  ? __pfx_read_pages+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  page_cache_ra_unbounded+0x389/0x6c0
>  do_page_cache_ra+0x109/0x170
>  filemap_fault+0xf03/0x2080
>  ? __pfx_filemap_fault+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_acquire+0x2b8/0x2f0
>  ? lockdep_init_map_type+0x5c/0x230
>  __do_fault+0xf0/0x260
>  __handle_mm_fault+0xdcf/0x1ca0
>  ? __pfx___handle_mm_fault+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? lock_release+0x1e0/0x280
>  handle_mm_fault+0x19c/0x470
>  do_user_addr_fault+0x23b/0x9c0
>  exc_page_fault+0x5c/0xc0
>  asm_exc_page_fault+0x26/0x30
>
> Allocated by task 511:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  __kasan_kmalloc+0xaa/0xb0
>  __kvmalloc_node_noprof+0x353/0x920
>  ntfs_attrlist_entry_rm+0x28d/0x510
>  ntfs_attr_record_rm+0x4dd/0xda0
>  ntfs_delete+0x50a/0xf90
>  ntfs_unlink+0x212/0x4d0
>  vfs_unlink+0x259/0xb00
>  filename_unlinkat+0x2db/0x5f0
>  __x64_sys_unlink+0x46/0x70
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Freed by task 511:
>  kasan_save_stack+0x33/0x60
>  kasan_save_track+0x14/0x30
>  kasan_save_free_info+0x3b/0x60
>  __kasan_slab_free+0x5f/0x80
>  kfree+0x307/0x580
>  ntfs_attrlist_entry_add+0xc1b/0x1110
>  ntfs_resident_attr_record_add+0x6a8/0xa10
>  ntfs_attr_add+0x682/0xcd0
>  __ntfs_link+0x815/0xde0
>  ntfs_link+0x223/0x3d0
>  vfs_link+0x465/0xcf0
>  filename_linkat+0x316/0x540
>  __x64_sys_link+0x81/0xb0
>  do_syscall_64+0x115/0x6a0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Fixes: b041ca562526 ("ntfs: update iomap and address space operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
>  fs/ntfs/iomap.c | 25 ++++++++++++++++++++-----
>  1 file changed, 20 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
> index 52eecf5cb256..5f15a0432f0c 100644
> --- a/fs/ntfs/iomap.c
> +++ b/fs/ntfs/iomap.c
> @@ -263,11 +263,26 @@ static int __ntfs_read_iomap_begin(struct inode *in=
ode, loff_t offset, loff_t le
>                 unsigned int flags, struct iomap *iomap, struct iomap *sr=
cmap,
>                 bool need_unwritten)
>  {
> -       if (NInoNonResident(NTFS_I(inode)))
> -               return ntfs_read_iomap_begin_non_resident(inode, offset, =
length,
> -                               flags, iomap, need_unwritten);
> -       return ntfs_read_iomap_begin_resident(inode, offset, length,
> -                                            flags, iomap);
> +       struct ntfs_inode *ni =3D NTFS_I(inode);
> +       struct ntfs_inode *base_ni =3D NInoAttr(ni) ? ni->ext.base_ntfs_i=
no : ni;
> +       bool lock_mrec =3D NInoAttrList(base_ni);
> +       int err;
> +
> +       if (lock_mrec)
> +               mutex_lock(&base_ni->mrec_lock);

It looks like there is a race condition here.
The concurrent writer may create attr_list immediately after this check.
In that case, the reader can call ntfs_external_attr_find() from
ntfs_attr_lookup() and access the newly created attr_list without the lock.

There also appears to be a few places such as ntfs_attr_map_whole_runlist()
to call ntfs_attr_lookup() without the lock.

Considering performance, how about introducing the rw_semaphore to
protect attr_list?

> +
> +       if (NInoNonResident(ni))
> +               err =3D ntfs_read_iomap_begin_non_resident(inode, offset,=
 length,
> +                                                        flags, iomap,
> +                                                        need_unwritten);
> +       else
> +               err =3D ntfs_read_iomap_begin_resident(inode, offset, len=
gth,
> +                                                    flags, iomap);
> +
> +       if (lock_mrec)
> +               mutex_unlock(&base_ni->mrec_lock);
> +
> +       return err;
>  }
>
>  static int ntfs_read_iomap_begin(struct inode *inode, loff_t offset, lof=
f_t length,
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
