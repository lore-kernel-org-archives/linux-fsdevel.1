Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EDD3B1B3
	for <linux-fsdevel@vger.kernel.org>; Mon, 29 Jun 2026 00:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782692954; cv=pass; b=QCFD2PltxtvkQloy1mSyKfvHFd8IEYvsPrYs9cx5Lvpna6pL4y0wnQENegahnAPgSyaj7cT1XtMlJqt8J3lQW9pZ9xg73a4sdklA4AVGKRInAZVNECNwd/gTwS81aZPT77//SvZrNbCrqajdKcXKQ4QgLXldDs/h3pSXCzM2Ni0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782692954; c=relaxed/simple;
	bh=++rcTmkcEQ5y5VlKY/ZSTExjniqGoW4uEGUa5cAG8hU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBi7/ueSPGbO2mJt4HGQ/bq7S6K2nHLtSTwnuW2eqJQDQ7tJ0TwmYx4237qkv6Z6qzFWea1njB9CmQZL933N3+euBfN7itSkk19VUHGHR/WPncVeDexQZL40H06u1BMpkFemotn8XCGhNXdQOC4VtYhnr7ZQH7yfToIEXk3ZErY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4VygRxq; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4VygRxq"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb7467a8dso529307e87.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Jun 2026 17:29:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782692951; cv=none;
        d=google.com; s=arc-20260327;
        b=CswIL6F6gA3H1fK+lPeYc1UQvqjBWY0cBI69T12Pptu2t+7hUs4qKNNYLUNjoFywel
         yOlHjGkJ+r8TAXqKnur6uMy/k06Gu9a3hqlvNv6og4CIwtoBgsRlT2eovMCCCBWeXS/g
         1Cqaiq2Ikw2B3WtwMEYvcFdebA9Vmmq6pKofiuao7oQWvupfY29UyBDvIp4WQMQFkevd
         DT6gMPY/dBDpVvdaJDW3lA2JC/0gcA6niidKBDbIZSFbg9KhPlzunN3GURWb95tSO2xR
         k9iFGiHCohP8yY/DSga9CK91zrox4tUanYHXYGCDRJnTV78Vcbez4UQcpKj9bMRfQHS/
         ibAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W7CBkID6B5s8Pw+MFYEXHCDbfTGrGnCA/p9jFnR7ock=;
        fh=oGmzJRpi/ggcbHjcX53A5jUn/++DVzSwNUdUD2BO6hg=;
        b=fdlYija+TfG8wUsEX1Kz//P2jZSU8gsHm0cfzHfwQXWubzNRbRqSx0VlLEIXP38VCA
         QLhFIpyiyFPlkXF+y65UgI87yDFTu8K+7R8hcPSatWSC91EaQ5/UY4TJoqMoETrIcYao
         vljIIkE8DKwl7Of+wDQ1+lWsPVXnGSLXwN0juVVL5wgH3JCjYqCVsPHm44/Ru9ITu3wI
         rXuY+ThYI1Lt7XVAUS6PqEO1fPduqptvlj1YRKdWBDUcpnGKw+8A0+EliK04u/0zrOcc
         BMwuDOiD2sTddjiG+Fz2CtZKBtm0+Z+zXFKz06u8T4p5/PdgdJWG4fvDABQEI9J3YmPy
         21ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782692951; x=1783297751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7CBkID6B5s8Pw+MFYEXHCDbfTGrGnCA/p9jFnR7ock=;
        b=j4VygRxqYRTaHzgpCkyKtQN3HQpGAjz60UdaEYr6wm/cIv0kmVLwqrsr/EspiPJiso
         W4YX9QyeL62g52SMBSwD0TJRlgmAUjYqhCKzhlE7aVjS4l4/XP4eoeMRwax1AuoKqwU1
         r+a9RkZWitd/PNwqZu6FntCyNxYZdSH1IUntw0iT+1gxvc0LCPTJhhSdbvbQaHlXdtmB
         UCC1O8wA8c6vamQ00D0gGytap3991N9ABn6T/RGCkfNIWaho9Q9ppLNIOkjzBXkrY2mM
         SU8zRbLrq6CgeyvFgo40ZwgsGa0A/3tNdYXBuGVtthzKembt9PebLDPYRC+K5mRGddSV
         PMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782692951; x=1783297751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W7CBkID6B5s8Pw+MFYEXHCDbfTGrGnCA/p9jFnR7ock=;
        b=nVN/WLndGrz054rnLR1NBAFeNvBkXp6LybMMoT5Ak5JEGngQ0SFzu+oeSPbEQ4rZmc
         NphFOLZydnI781ETbYczjo5ePrd1qPFdV3vjCIWx4xk68xvgUsgb1g98Lqf+9dPinn5u
         isEUi1chLoclow3+MXstugBShQPbI9s9hiaQ9tuw/FPy3uN8fPfrwOOmDQJibPLF0tY6
         2XrPyendiUSHThkUWGQJEC8QOGkDUmCYpkoeGw/qW6XLt3ZXt6ksYk1cYbGiL5+xCTCA
         VHiaB1h0FVfxhIv9hJK2l8q3A6w0jETwxGrN8g6bqVNq/9r6Hm6V+zD2j4qVZAVJNfKx
         2Bng==
X-Forwarded-Encrypted: i=1; AHgh+RqGibWmwvvJYGxM8HQNgy8R15Jp6w06ei5XwW0fbklGKAePtRu3Nq0XdAB14p7FpZdB3ScFfiItuBX8jRgG@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/9qtqChD96pO7wrsGDknsNjLT73uobFpZ0ljvlVr6aV0W+GlG
	n4O4DTYfRV21G45UhRbwcvntOB8gtvEDkMBBc1jJ/13Dzz7bi4QcrjzDKdPEk4HFxSV2T01fSvK
	MuMlxKswKAI/23n2gkKkxTDbQyNkYrt8=
X-Gm-Gg: AfdE7cndlZ8fUIVnmvY8FI7IiFr5lWk5nf43lJOS0q6GeY1kVclwdFCqp93g+NJ2opX
	0ks4dyVf80epjOFI00RXdMaf5U609gScjuL+u+nZkp3nm+MSl6TcsKmQWJ76lbZLaWSM3I1GPC4
	ys+/d2nHM5mkfZfu6Hd2sP9SadZ9tpouT5Kw13jrPTMQtB/HWllGY0vcWJ5YwpNfk3OCj2EO2im
	qhXgVHfdmRnQwWN+WkaxEQ12L1t046LkoGJeoGuigDfKOWpbfNE7pEyzCqkcXrjBUig7Sk4
X-Received: by 2002:ac2:4bd3:0:b0:5ae:b7a3:6dc3 with SMTP id
 2adb3069b0e04-5aeb7a36f7emr631951e87.0.1782692950222; Sun, 28 Jun 2026
 17:29:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627042816.2842609-1-zzzccc427@gmail.com>
In-Reply-To: <20260627042816.2842609-1-zzzccc427@gmail.com>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 29 Jun 2026 09:28:58 +0900
X-Gm-Features: AVVi8CdBlie8n4hwQxAl3T5u_ydyJM5at-L6ZmUYptJeqF3yYGPUWGz_TuCDxmc
Message-ID: <CANFS6baiHaz-U-uCPjh2oERc5TM8yU1OHYEN3WJ3KbXS524M+A@mail.gmail.com>
Subject: Re: [PATCH v2] ntfs: serialize attribute-list replacement with lookups
To: Cen Zhang <zzzccc427@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Cen,

Hi Cen,

I reviewed and noticed a few concurrency issues.

* ntfs_attr_lookup() releases the read lock before returning, which leaves
the ctx->al_entry unprotected during the lifetime of the search context.

* In some functions such as ntfs_attrlist_entry_add(), the memcpy()
reads base_ni->attr_list outside of the writ lock. If another thread
frees it concurrently, this leads to a UAF.

To resolve these issues, How about coupling the attr_list_lock directly
with the search context?

* Extend ntfs_attr_get_search_ctx with a lock mode (NONE, READ, WRITE)
to automatically acquire the lock unpon context creation and release
it in ntfs_attr_put_search_ctx().

* To prevent deadlocks, the following lock ordering is needed:
base_ni->mrec_lock =3D> base_ni->attr_list_lock =3D> ni->runlist.lock.
And to prevent nesting attr_list_lock under runlist.lock, The NONE
mode bypasses context-owned locking and is required for paths
that must control ordering manually (e.g, ntfs_attr_vcn_to_lcn_nlock()).

2026=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=ED=86=A0) =EC=98=A4=ED=9B=84 1:28, C=
en Zhang <zzzccc427@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> ntfs_external_attr_find() walks base_ni->attr_list with raw
> attr_list_entry cursors stored in ctx->al_entry and local variables.  Oth=
er
> metadata paths can replace base_ni->attr_list and free the old buffer whi=
le
> a lookup still carries one of those cursors.
>
> The buggy scenario involves two paths, with each column showing the order
> within that path:
>
>   attribute lookup path:              attribute-list mutation path:
>   1. enters ntfs_attr_lookup()        1. enters an attr-list add/remove
>   2. reads base_ni->attr_list         2. builds a replacement buffer
>   3. keeps ctx->al_entry/al_entry     3. publishes base_ni->attr_list
>      pointing into that buffer        4. frees the previous buffer
>   4. continues the attribute search
>   5. dereferences the saved cursor
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
> Add a per-ntfs_inode attr_list_lock.  ntfs_attr_lookup() takes the read
> side around the NInoAttrList() decision and the selected local or
> external lookup, so any attr-list cursor derived during the lookup is
> protected until the lookup returns.  Writers take the write side only
> while publishing, rolling back, detaching, or clearing the in-memory
> attr_list pointer, size, and state.  The on-disk ntfs_attrlist_update()
> work stays outside the write side.
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> ---
> v2:
> - Replace the read-iomap mrec_lock wrapper with a per-inode attr_list rws=
em,
>   following Hyunchul Lee's review.
> - Protect attr-list creation, replacement, rollback, detach, and clear
>   transitions, while keeping ntfs_attrlist_update() outside the write sid=
e.
> - Update the Fixes tag to the attribute operations commit.
>
>  fs/ntfs/attrib.c   | 21 +++++++++++++++++----
>  fs/ntfs/attrlist.c | 10 +++++++++-
>  fs/ntfs/inode.c    | 10 ++++++++++
>  fs/ntfs/inode.h    |  4 ++++
>  4 files changed, 40 insertions(+), 5 deletions(-)
>
> diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> index dd8828098511..e630f63ed7ad 100644
> --- a/fs/ntfs/attrib.c
> +++ b/fs/ntfs/attrib.c
> @@ -1565,6 +1565,7 @@ int ntfs_attr_lookup(const __le32 type, const __le1=
6 *name,
>                 struct ntfs_attr_search_ctx *ctx)
>  {
>         struct ntfs_inode *base_ni;
> +       int err;
>
>         ntfs_debug("Entering.");
>         if (ctx->base_ntfs_ino)
> @@ -1572,11 +1573,18 @@ int ntfs_attr_lookup(const __le32 type, const __l=
e16 *name,
>         else
>                 base_ni =3D ctx->ntfs_ino;
>         /* Sanity check, just for debugging really. */
> -       if (!base_ni || !NInoAttrList(base_ni) || type =3D=3D AT_ATTRIBUT=
E_LIST)
> +       if (!base_ni)
>                 return ntfs_attr_find(type, name, name_len, ic, val, val_=
len,
>                                 ctx);
> -       return ntfs_external_attr_find(type, name, name_len, ic, lowest_v=
cn,
> -                       val, val_len, ctx);
> +
> +       down_read(&base_ni->attr_list_lock);
> +       if (!NInoAttrList(base_ni) || type =3D=3D AT_ATTRIBUTE_LIST)
> +               err =3D ntfs_attr_find(type, name, name_len, ic, val, val=
_len, ctx);
> +       else
> +               err =3D ntfs_external_attr_find(type, name, name_len, ic,
> +                                             lowest_vcn, val, val_len, c=
tx);
> +       up_read(&base_ni->attr_list_lock);
> +       return err;
>  }
>
>  /**
> @@ -2622,6 +2630,7 @@ static int ntfs_non_resident_attr_record_add(struct=
 ntfs_inode *ni, __le32 type,
>  int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
>  {
>         struct ntfs_inode *base_ni, *ni;
> +       u8 *old_al =3D NULL;
>         __le32 type;
>         int err;
>
> @@ -2659,10 +2668,14 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_c=
tx *ctx)
>
>         /* Post $ATTRIBUTE_LIST delete setup. */
>         if (type =3D=3D AT_ATTRIBUTE_LIST) {
> +               down_write(&base_ni->attr_list_lock);
>                 if (NInoAttrList(base_ni) && base_ni->attr_list)
> -                       kvfree(base_ni->attr_list);
> +                       old_al =3D base_ni->attr_list;
>                 base_ni->attr_list =3D NULL;
> +               base_ni->attr_list_size =3D 0;
>                 NInoClearAttrList(base_ni);
> +               up_write(&base_ni->attr_list_lock);
> +               kvfree(old_al);
>         }
>
>         /* Free MFT record, if it doesn't contain attributes. */
> diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
> index afb13038ba42..e91fc74eda31 100644
> --- a/fs/ntfs/attrlist.c
> +++ b/fs/ntfs/attrlist.c
> @@ -220,14 +220,18 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, =
struct attr_record *attr)
>                         entry_offset, ni->attr_list_size - entry_offset);
>
>         /* Set new runlist. */
> +       down_write(&ni->attr_list_lock);
>         old_al =3D ni->attr_list;
>         ni->attr_list =3D new_al;
>         ni->attr_list_size =3D ni->attr_list_size + entry_len;
> +       up_write(&ni->attr_list_lock);
>
>         err =3D ntfs_attrlist_update(ni);
>         if (err) {
> +               down_write(&ni->attr_list_lock);
>                 ni->attr_list =3D old_al;
>                 ni->attr_list_size -=3D entry_len;
> +               up_write(&ni->attr_list_lock);
>                 goto err_out;
>         }
>         kvfree(old_al);
> @@ -251,6 +255,7 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ct=
x *ctx)
>         int new_al_len;
>         struct ntfs_inode *base_ni;
>         struct attr_list_entry *ale;
> +       u8 *old_al;
>
>         if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
>                 ntfs_debug("Invalid arguments.\n");
> @@ -285,9 +290,12 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search_c=
tx *ctx)
>                                 ale->length), new_al_len - ((u8 *)ale - b=
ase_ni->attr_list));
>
>         /* Set new runlist. */
> -       kvfree(base_ni->attr_list);
> +       down_write(&base_ni->attr_list_lock);
> +       old_al =3D base_ni->attr_list;
>         base_ni->attr_list =3D new_al;
>         base_ni->attr_list_size =3D new_al_len;
> +       up_write(&base_ni->attr_list_lock);
> +       kvfree(old_al);
>
>         return ntfs_attrlist_update(base_ni);
>  }
> diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> index c2715521e562..25e957401892 100644
> --- a/fs/ntfs/inode.c
> +++ b/fs/ntfs/inode.c
> @@ -475,6 +475,7 @@ void __ntfs_init_inode(struct super_block *sb, struct=
 ntfs_inode *ni)
>         ni->folio =3D NULL;
>         ni->folio_ofs =3D 0;
>         ni->mrec =3D NULL;
> +       init_rwsem(&ni->attr_list_lock);
>         ni->attr_list_size =3D 0;
>         ni->attr_list =3D NULL;
>         ni->itype.index.block_size =3D 0;
> @@ -3112,9 +3113,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
>         }
>
>         /* Set in-memory attribute list. */
> +       down_write(&ni->attr_list_lock);
>         ni->attr_list =3D al;
>         ni->attr_list_size =3D al_len;
>         NInoSetAttrList(ni);
> +       up_write(&ni->attr_list_lock);
>
>         attr_al_len =3D offsetof(struct attr_record, data.resident.reserv=
ed) + 1 +
>                 ((al_len + 7) & ~7);
> @@ -3147,8 +3150,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
>
>  remove_attrlist_record:
>         /* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
> +       down_write(&ni->attr_list_lock);
>         ni->attr_list =3D NULL;
> +       ni->attr_list_size =3D 0;
>         NInoClearAttrList(ni);
> +       up_write(&ni->attr_list_lock);
>         /* Remove $ATTRIBUTE_LIST record. */
>         ntfs_attr_reinit_search_ctx(ctx);
>         if (!ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0,
> @@ -3160,9 +3166,11 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
>         }
>
>         /* Setup back in-memory runlist. */
> +       down_write(&ni->attr_list_lock);
>         ni->attr_list =3D al;
>         ni->attr_list_size =3D al_len;
>         NInoSetAttrList(ni);
> +       up_write(&ni->attr_list_lock);
>  rollback:
>         /*
>          * Scan attribute list for attributes that placed not in the base=
 MFT
> @@ -3189,10 +3197,12 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni=
)
>         }
>
>         /* Remove in-memory attribute list. */
> +       down_write(&ni->attr_list_lock);
>         ni->attr_list =3D NULL;
>         ni->attr_list_size =3D 0;
>         NInoClearAttrList(ni);
>         NInoClearAttrListDirty(ni);
> +       up_write(&ni->attr_list_lock);
>  put_err_out:
>         ntfs_attr_put_search_ctx(ctx);
>  err_out:
> diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
> index 9aacd5787ffe..0aaa6c90a7fb 100644
> --- a/fs/ntfs/inode.h
> +++ b/fs/ntfs/inode.h
> @@ -10,6 +10,8 @@
>  #ifndef _LINUX_NTFS_INODE_H
>  #define _LINUX_NTFS_INODE_H
>
> +#include <linux/rwsem.h>
> +
>  #include "debug.h"
>
>  enum ntfs_inode_mutex_lock_class {
> @@ -66,6 +68,7 @@ enum ntfs_inode_mutex_lock_class {
>   * Attribute list support (only for use by the attribute lookup
>   * functions). Setup during read_inode for all inodes with attribute
>   * lists. Only valid if NI_AttrList is set in state.
> + * @attr_list_lock: Serializes attribute list pointer updates with looku=
ps.
>   * @attr_list_size: Length of attribute list value in bytes.
>   * @attr_list: Attribute list value itself.
>   *
> @@ -118,6 +121,7 @@ struct ntfs_inode {
>         int folio_ofs;
>         s64 mft_lcn[2];
>         unsigned int mft_lcn_count;
> +       struct rw_semaphore attr_list_lock;
>         u32 attr_list_size;
>         u8 *attr_list;
>         union {
> --
> 2.43.0



--=20
Thanks,
Hyunchul
