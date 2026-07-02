Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8C22D7DF1
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783004969; cv=pass; b=aaGflZN5Ho2sB0wbOzMOhtPDLWJ8IScOexhzmC+RwubGr44JOj8iwWzpUyWT8f83Hg2fHncCqzrDiNpt9N/9sDchC419ZfD0YJQOH89RAR0AoYp9S71Y5EjSdLqMaCU2GKnPByDQj0GXKl9t7BGEHtZYyh7NVO1Ato19iiNcGjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783004969; c=relaxed/simple;
	bh=oUL80PbSOMQuEZII+E4D/F59UvSMUBlV+WWPibvhP/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8wp7MAcClMI0hozqcw5nnNGP2bbEqFTI5/I52Qlipo9LaSjJwO0QeLHGQIZK6qCmZbDet4U8VQGV4LXvYtfhc4wPuD4CnvwRzvMUJRH6rX4Uge4uf6nyiMbcnAhFDEM+vbzdH+1S/60k0Qq5uPWbmnvlppF5NbsV9874pVFdxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=roMzi0Q+; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="roMzi0Q+"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7dbcb505578so17029077b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 08:09:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783004963; cv=none;
        d=google.com; s=arc-20260327;
        b=Xshgtof8wYeP2VzPVjjZmu3fPEux9Nw+LdtEv7gTNSRt/8MsDYMGuOD6IVP8NJAU8U
         8XpDC1ot7qkMGwrQz+I3imA3topGdOAD6R0u28IjieI9r1WG+BVEnMC5MQU6uvJLIEVj
         8Ho7+Jbx9tZ4Xivknb8BC2lc1QlLbWGXFSA9qlCoAs30MqzPokj4KgCEldVTqZMO9BMk
         A4ssYzfkKd+mZUyngEHaP6wodwWyj7pTxWUIP2d5xA6pan4KLRF/EDi7PO5mG8qKtedo
         an5u/2FSBbrQminFHWYeD1cc1F9gx3tFY65vTfzMIJINzK/nrOhSJq6p0ZyCGSqPu8NG
         X/rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1znAAf7+ehDTMmCCqSGjw2UYgODzHODAsmCL3MxDDDU=;
        fh=DlCOj+zVZ8ePcDBgkRjeoYcZAed+UUvTnRrYxou49lI=;
        b=Dd3s8+AlzG5KJFs0pIK5onwY4H+xDsBGEyDXZHv8L+CqumxU6/znKDrjk0G4m2k2HC
         NTJTRCEYG5jJn/CRLUuR/HSh4l+rN32eJ8MCaMKHpR2maTDtcRzDfbyAZ9FQquFF7rUx
         oAAgSqUHBw7bdxklmssPrgOhRZDLX1VvbqB1okKKVq3GrOVvRNr19Di21EoDWnOk3ZUk
         UTUg1TwJ6rIljsPJtl/OH0it4KKheD/57M2Y0yXsiIfTqD5xG2JMuD05NBLTm26j6ybz
         zFBS7UQ4qox/h0/TvbzIr7+8d3x0QcSRN7cGD+xt0DTmIAQhJVhLY6+N5/nJG+qtTZ71
         VMGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783004963; x=1783609763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1znAAf7+ehDTMmCCqSGjw2UYgODzHODAsmCL3MxDDDU=;
        b=roMzi0Q+28HRmiFkkA/IaML+L/ddFmJXyHP4KCmgVF7CMGdDJikGfJekRuGamRZXYE
         oPadCBP6Or2280troefadq/HuRXHXR2PvC5l1ioMxnBDm6ZUUbdoduu/ZnU6RLVM6Nks
         N+OY6uogOlD9dFN6ZAzdDbXj84tYbJLCF5iG0k/l5q+NXLXgUi/MNRMGQU9fg+X5DlxS
         X9lEckM61dA4aPUKdsyfo6vRSPYNV8kqsbqiIPfS6QyblFdLmzNDhTi1lPa38TNyPAY5
         fS6AuRrnuZASr5qNBTlMdvLTbuNrG1wc/FqRAlSF/cWsVRPj1+GSCAodZ6DFZ7AYW1Iy
         TPfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783004963; x=1783609763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1znAAf7+ehDTMmCCqSGjw2UYgODzHODAsmCL3MxDDDU=;
        b=fP4ncORYibYRyAgUcynjI7o9bSNnRHrr1EmCmKuXTB2eT4uUlVoHlsQBp6tBGVE/gL
         3Su27AxtkKPMSDBelcAvLIsTnNhhhUVqO8HGPrpHGLwHhjp1t049LpiBoohJW5AB6IXj
         rAMatZ70q4jCRMn6UJLSTdvQQs1DqoHWFdZN1+eAyOh2tcSL9+N9gJ0qmz9IpBEmOB9+
         79/hjiuBkK7DRStoMekUDugB0iZuhtt32rXC8RHUaE+4VViUEBuiNnBXeqfv8o7W6OEl
         b9A+SYSi0eQhzmBrGT911lASihJDy/Lrr30I6K8xu/QyhBY+T/wqzkKzQLuudI83+c6l
         I5tQ==
X-Forwarded-Encrypted: i=1; AHgh+RpYqkV4tno+5ecNBBYkVBIs14Q+chOs+94UdoqRpzR6lg9ObK1tsKjVwEkQUYEj4fSCEW/50HNQ7EXAThjT@vger.kernel.org
X-Gm-Message-State: AOJu0YyVkxUMQPloWsH61znvadV2J6gur7zs9yw0WG7jGgdvIkQxVNt8
	qk+ofNhw8xdxGjE7JFhl//I07yTRxBdfPFV/M8OyDB3dtunAmoGKM7ct7RucmVJ2pgDhtM8q/Hu
	W9QUWk5HoAH2ipGPQq6KAhmwr9pCwOKA=
X-Gm-Gg: AfdE7ck8COtBQJIMoS0RZRTykMYsOu5hxo4KUebDAstVhvMZoHnwp6JdKhHzY+ICS5C
	ZwS9+1JBaZoU79TaZyOmQF5i1kxadztoQlKMsT4zTiCjVYcO0grtxZfStTU3fwQUerdgWi8+r3K
	l/RynrTQJqQaPiz+G3FD6aHWhq7NAo/9mSdXntSQ7uH8L/HanV80Sr/CXgmHPRhrRmolE6kmhDf
	5/aBARLaNIagy1Zaw6hYHSIGUU4ZZV+/JUquGYQ8fXnwoU30c7UCisENa0+ClQ37PC/MvS0ggo=
X-Received: by 2002:a05:690c:e1ce:10b0:814:3d11:b88c with SMTP id
 00721157ae682-8143d11be0dmr39927137b3.19.1783004962278; Thu, 02 Jul 2026
 08:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260629045753.2087750-1-zzzccc427@gmail.com> <akTMnTvQBvOIrNr6@hyunchul-PC02>
In-Reply-To: <akTMnTvQBvOIrNr6@hyunchul-PC02>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 2 Jul 2026 23:09:10 +0800
X-Gm-Features: AVVi8CeNCOdTFiUbRCOVf9JyMHRwPS1FZ3qB38XDR2zRSFssDfJV-Xkm89BdGvY
Message-ID: <CAFRLqsUzqQHEaQJ9idU61e1kYC5JbPbELS=xofVn5HA9oPF7rw@mail.gmail.com>
Subject: Re: [PATCH v3] ntfs: serialize attribute-list replacement with lookups
To: Hyunchul Lee <hyc.lee@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hyunchul,

Thank you for your review and comments.

I will take a closer look at your comments to make the corresponding
fixes and rebase it.

Best regards,
Cen Zhang

Hyunchul Lee <hyc.lee@gmail.com> =E4=BA=8E2026=E5=B9=B47=E6=9C=881=E6=97=A5=
=E5=91=A8=E4=B8=89 16:15=E5=86=99=E9=81=93=EF=BC=9A
>
> Hi Cen,
>
> Thank you for the patch, but it has conflicts and needs to be rebased ont=
o
> ntfs-for-7.2-rc1 from the repository below:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/ntfs.git
>
> I left a few comments below.
>
> On Mon, Jun 29, 2026 at 12:57:53PM +0800, Cen Zhang wrote:
> > ntfs_external_attr_find() walks base_ni->attr_list with raw
> > attr_list_entry cursors stored in ctx->al_entry and local variables.  O=
ther
> > metadata paths can replace base_ni->attr_list and free the old buffer w=
hile
> > a lookup still carries one of those cursors.
> >
> > The buggy scenario involves two paths, with each column showing the ord=
er
> > within that path:
> >
> >   attribute lookup path:              attribute-list mutation path:
> >   1. enters ntfs_attr_lookup()        1. enters an attr-list add/remove
> >   2. reads base_ni->attr_list         2. builds a replacement buffer
> >   3. keeps ctx->al_entry/al_entry     3. publishes base_ni->attr_list
> >      pointing into that buffer        4. frees the previous buffer
> >   4. continues the attribute search
> >   5. dereferences the saved cursor
> >
> > Validation reproduced this kernel report:
> > BUG: KASAN: slab-use-after-free in ntfs_attr_lookup+0x24b2/0x2bf0
> >
> > Call Trace:
> >  <TASK>
> >  dump_stack_lvl+0x66/0xa0
> >  print_report+0xce/0x630
> >  ? ntfs_attr_lookup+0x24b2/0x2bf0
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? __virt_addr_valid+0x20d/0x410
> >  ? ntfs_attr_lookup+0x24b2/0x2bf0
> >  kasan_report+0xe0/0x110
> >  ? ntfs_attr_lookup+0x24b2/0x2bf0
> >  ntfs_attr_lookup+0x24b2/0x2bf0
> >  ? ntfs_attr_lookup+0x9/0x2bf0
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? 0xffffffffc00000da
> >  ? __pfx_ntfs_attr_lookup+0x10/0x10
> >  ntfs_attr_map_whole_runlist+0x488/0x8b0
> >  ? __pfx_ntfs_attr_map_whole_runlist+0x10/0x10
> >  ? __pfx_do_raw_spin_trylock+0x10/0x10
> >  ntfs_attr_vcn_to_rl+0x13a/0x1d0
> >  ? filemap_fault+0xf03/0x2080
> >  ntfs_read_iomap_begin_non_resident+0x142/0x920
> >  ? __pfx_ntfs_read_iomap_begin_non_resident+0x10/0x10
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? __pfx_ntfs_read_iomap_begin+0x10/0x10
> >  iomap_iter+0x6de/0x11e0
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? prepare_alloc_pages+0x1c4/0x4d0
> >  iomap_readahead+0x239/0x910
> >  ? folios_put_refs+0x1ed/0x4f0
> >  ? __pfx_iomap_readahead+0x10/0x10
> >  ? __pfx_folios_put_refs+0x10/0x10
> >  ? lock_release+0x1e0/0x280
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? xas_store+0x871/0x1650
> >  ? xas_find_conflict+0x64b/0xb90
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? lock_release+0x1e0/0x280
> >  ntfs_readahead+0x193/0x1d0
> >  ? __pfx_ntfs_readahead+0x10/0x10
> >  ? __filemap_add_folio+0x869/0xa60
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? lock_acquire+0x2b8/0x2f0
> >  ? __pfx___filemap_add_folio+0x10/0x10
> >  read_pages+0x18f/0x890
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? folio_alloc_noprof+0x69/0xb0
> >  ? __pfx_read_pages+0x10/0x10
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  page_cache_ra_unbounded+0x389/0x6c0
> >  do_page_cache_ra+0x109/0x170
> >  filemap_fault+0xf03/0x2080
> >  ? __pfx_filemap_fault+0x10/0x10
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? lock_acquire+0x2b8/0x2f0
> >  ? lockdep_init_map_type+0x5c/0x230
> >  __do_fault+0xf0/0x260
> >  __handle_mm_fault+0xdcf/0x1ca0
> >  ? __pfx___handle_mm_fault+0x10/0x10
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? srso_alias_return_thunk+0x5/0xfbef5
> >  ? lock_release+0x1e0/0x280
> >  handle_mm_fault+0x19c/0x470
> >  do_user_addr_fault+0x23b/0x9c0
> >  exc_page_fault+0x5c/0xc0
> >  asm_exc_page_fault+0x26/0x30
> >
> > Allocated by task 511:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x14/0x30
> >  __kasan_kmalloc+0xaa/0xb0
> >  __kvmalloc_node_noprof+0x353/0x920
> >  ntfs_attrlist_entry_rm+0x28d/0x510
> >  ntfs_attr_record_rm+0x4dd/0xda0
> >  ntfs_delete+0x50a/0xf90
> >  ntfs_unlink+0x212/0x4d0
> >  vfs_unlink+0x259/0xb00
> >  filename_unlinkat+0x2db/0x5f0
> >  __x64_sys_unlink+0x46/0x70
> >  do_syscall_64+0x115/0x6a0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Freed by task 511:
> >  kasan_save_stack+0x33/0x60
> >  kasan_save_track+0x14/0x30
> >  kasan_save_free_info+0x3b/0x60
> >  __kasan_slab_free+0x5f/0x80
> >  kfree+0x307/0x580
> >  ntfs_attrlist_entry_add+0xc1b/0x1110
> >  ntfs_resident_attr_record_add+0x6a8/0xa10
> >  ntfs_attr_add+0x682/0xcd0
> >  __ntfs_link+0x815/0xde0
> >  ntfs_link+0x223/0x3d0
> >  vfs_link+0x465/0xcf0
> >  filename_linkat+0x316/0x540
> >  __x64_sys_link+0x81/0xb0
> >  do_syscall_64+0x115/0x6a0
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > Add a per-ntfs_inode attr_list_lock and couple it to
> > ntfs_attr_search_ctx.  Search contexts that may carry attr-list cursors
> > take the read side for their full lifetime, so ctx->al_entry remains
> > protected until ntfs_attr_put_search_ctx().  Attribute-list mutation pa=
ths
> > use the write side while deriving offsets from the old list and publish=
ing
> > the replacement list.  Contexts used under runlist.lock use an explicit
> > NONE mode so the ordering stays:
> >
> >   mrec_lock =3D> attr_list_lock =3D> runlist.lock
> >
> > Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> > Assisted-by: Codex:gpt-5.5
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> > v3:
> > - Keep attr_list_lock tied to ntfs_attr_search_ctx lifetime instead of
> >   taking it only around ntfs_attr_lookup().
> > - Add nolock helpers for paths that already hold attr_list_lock before
> >   runlist.lock, preserving the mrec_lock =3D> attr_list_lock =3D> runli=
st.lock
> >   order.
> > - Protect the remaining direct attr_list walker in
> >   ntfs_inode_attach_all_extents().
> >
> >  fs/ntfs/aops.c     |   3 +
> >  fs/ntfs/attrib.c   | 287 ++++++++++++++++++++++++++++++++++++---------
> >  fs/ntfs/attrib.h   |  27 ++++-
> >  fs/ntfs/attrlist.c |  30 +++--
> >  fs/ntfs/compress.c |   6 +-
> >  fs/ntfs/dir.c      |   8 +-
> >  fs/ntfs/ea.c       |   2 +-
> >  fs/ntfs/file.c     |  13 +-
> >  fs/ntfs/index.c    |   5 +-
> >  fs/ntfs/inode.c    |  88 +++++++++++---
> >  fs/ntfs/inode.h    |   7 ++
> >  fs/ntfs/iomap.c    |  16 ++-
> >  fs/ntfs/mft.c      |  63 +++++++---
> >  fs/ntfs/namei.c    |   6 +-
> >  fs/ntfs/super.c    |   6 +-
> >  15 files changed, 445 insertions(+), 122 deletions(-)
> >
> > diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
> > index 1fbf832ad1654..981777ff24279 100644
> > --- a/fs/ntfs/aops.c
> > +++ b/fs/ntfs/aops.c
> > @@ -131,6 +131,7 @@ static sector_t ntfs_bmap(struct address_space *map=
ping, sector_t block)
> >       s64 lcn;
> >       unsigned long blocksize, flags;
> >       struct ntfs_inode *ni =3D NTFS_I(mapping->host);
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct ntfs_volume *vol =3D ni->vol;
> >       unsigned int delta;
> >       unsigned char blocksize_bits;
> > @@ -160,10 +161,12 @@ static sector_t ntfs_bmap(struct address_space *m=
apping, sector_t block)
> >        */
> >       if (unlikely(ofs >=3D size || (ofs + blocksize > size && size < i=
_size)))
> >               goto hole;
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> >       down_read(&ni->runlist.lock);
> >       lcn =3D ntfs_attr_vcn_to_lcn_nolock(ni, ntfs_bytes_to_cluster(vol=
, ofs),
> >                       false);
> >       up_read(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> >       if (unlikely(lcn < LCN_HOLE)) {
> >               /*
> >                * Step down to an integer to avoid gcc doing a long long
> > diff --git a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
> > index 97b660eaa00c1..21662be1594ff 100644
> > --- a/fs/ntfs/attrib.c
> > +++ b/fs/ntfs/attrib.c
> > @@ -107,7 +107,7 @@ int ntfs_map_runlist_nolock(struct ntfs_inode *ni, =
s64 vcn, struct ntfs_attr_sea
> >               m =3D map_mft_record(base_ni);
> >               if (IS_ERR(m))
> >                       return PTR_ERR(m);
> > -             ctx =3D ntfs_attr_get_search_ctx(base_ni, m);
> > +             ctx =3D ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CT=
X_LOCK_NONE);
> >               if (unlikely(!ctx)) {
> >                       err =3D -ENOMEM;
> >                       goto err_out;
> > @@ -299,14 +299,17 @@ int ntfs_map_runlist_nolock(struct ntfs_inode *ni=
, s64 vcn, struct ntfs_attr_sea
> >   */
> >  int ntfs_map_runlist(struct ntfs_inode *ni, s64 vcn)
> >  {
> > +     struct ntfs_inode *attr_lock_ni;
> >       int err =3D 0;
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> >       down_write(&ni->runlist.lock);
> >       /* Make sure someone else didn't do the work while we were sleepi=
ng. */
> >       if (likely(ntfs_rl_vcn_to_lcn(ni->runlist.rl, vcn) <=3D
> >                       LCN_RL_NOT_MAPPED))
> >               err =3D ntfs_map_runlist_nolock(ni, vcn, NULL);
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> >       return err;
> >  }
> >
> > @@ -317,7 +320,7 @@ struct runlist_element *ntfs_attr_vcn_to_rl(struct =
ntfs_inode *ni, s64 vcn, s64
> >       bool is_retry =3D false;
> >
> >       if (!rl) {
> > -             err =3D ntfs_attr_map_whole_runlist(ni);
> > +             err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >               if (err)
> >                       return ERR_PTR(-ENOENT);
> >               rl =3D ni->runlist.rl;
> > @@ -1436,6 +1439,81 @@ int ntfs_attr_lookup(const __le32 type, const __=
le16 *name,
> >                       val, val_len, ctx);
> >  }
> >
> > +static struct ntfs_inode *ntfs_attr_search_lock_inode(struct ntfs_inod=
e *ni)
> > +{
> > +     if (!ni)
> > +             return NULL;
> > +     if (NInoAttr(ni)) {
> > +             if (ni->type =3D=3D AT_ATTRIBUTE_LIST)
> > +                     return NULL;
> > +             return ni->ext.base_ntfs_ino;
> > +     }
> > +     return ni;
> > +}
> > +
> > +struct ntfs_inode *ntfs_attr_list_lock(struct ntfs_inode *ni,
> > +                                    enum ntfs_attr_search_ctx_lock_mod=
e lock_mode)
> > +{
> > +     struct ntfs_inode *lock_ni;
> > +
> > +     if (lock_mode =3D=3D NTFS_ATTR_CTX_LOCK_NONE)
> > +             return NULL;
>
> For the NONE case, it would be better to call rwsem_assert_held().
>
> > +
> > +     lock_ni =3D ntfs_attr_search_lock_inode(ni);
> > +     if (!lock_ni)
> > +             return NULL;
> > +
> > +     if (lock_mode =3D=3D NTFS_ATTR_CTX_LOCK_WRITE)
> > +             down_write(&lock_ni->attr_list_lock);
> > +     else
> > +             down_read(&lock_ni->attr_list_lock);
> > +
> > +     return lock_ni;
> > +}
> > +
> > +void ntfs_attr_list_unlock(struct ntfs_inode *lock_ni,
> > +                        enum ntfs_attr_search_ctx_lock_mode lock_mode)
> > +{
> > +     if (!lock_ni || lock_mode =3D=3D NTFS_ATTR_CTX_LOCK_NONE)
> > +             return;
> > +
> > +     if (lock_mode =3D=3D NTFS_ATTR_CTX_LOCK_WRITE)
> > +             up_write(&lock_ni->attr_list_lock);
> > +     else
> > +             up_read(&lock_ni->attr_list_lock);
> > +}
> > +
> > +void ntfs_attr_lock_search_ctx(struct ntfs_attr_search_ctx *ctx,
> > +                            struct ntfs_inode *ni,
> > +                            enum ntfs_attr_search_ctx_lock_mode lock_m=
ode)
> > +{
> > +     struct ntfs_inode *lock_ni;
> > +
> > +     ctx->attr_list_lock_ni =3D NULL;
> > +     ctx->attr_list_lock_mode =3D NTFS_ATTR_CTX_LOCK_NONE;
> > +
> > +     if (lock_mode =3D=3D NTFS_ATTR_CTX_LOCK_NONE)
> > +             return;
>
> As mentioned above, a call to rwsem_assert_held() would be better.
>
> > +
> > +     lock_ni =3D ntfs_attr_list_lock(ni, lock_mode);
> > +     if (!lock_ni)
> > +             return;
> > +
> > +     ctx->attr_list_lock_ni =3D lock_ni;
> > +     ctx->attr_list_lock_mode =3D lock_mode;
> > +}
> > +
> > +void ntfs_attr_unlock_search_ctx(struct ntfs_attr_search_ctx *ctx)
> > +{
> > +     if (!ctx->attr_list_lock_ni)
> > +             return;
> > +
> > +     ntfs_attr_list_unlock(ctx->attr_list_lock_ni, ctx->attr_list_lock=
_mode);
> > +
> > +     ctx->attr_list_lock_ni =3D NULL;
> > +     ctx->attr_list_lock_mode =3D NTFS_ATTR_CTX_LOCK_NONE;
> > +}
> > +
> >  /**
> >   * ntfs_attr_init_search_ctx - initialize an attribute search context
> >   * @ctx:        attribute search context to initialize
> > @@ -1466,6 +1544,8 @@ static bool ntfs_attr_init_search_ctx(struct ntfs=
_attr_search_ctx *ctx,
> >       ctx->base_mrec =3D NULL;
> >       ctx->base_attr =3D NULL;
> >       ctx->mapped_base_mrec =3D false;
> > +     ctx->attr_list_lock_ni =3D NULL;
> > +     ctx->attr_list_lock_mode =3D NTFS_ATTR_CTX_LOCK_NONE;
> >       return true;
> >  }
> >
> > @@ -1481,6 +1561,9 @@ static bool ntfs_attr_init_search_ctx(struct ntfs=
_attr_search_ctx *ctx,
> >   */
> >  void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx)
> >  {
> > +     struct ntfs_inode *attr_list_lock_ni =3D ctx->attr_list_lock_ni;
> > +     enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode =3D
> > +             ctx->attr_list_lock_mode;
> >       bool mapped_mrec;
> >
> >       if (likely(!ctx->base_ntfs_ino)) {
> > @@ -1502,6 +1585,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr=
_search_ctx *ctx)
> >       mapped_mrec =3D ctx->mapped_base_mrec;
> >       ntfs_attr_init_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec=
);
> >       ctx->mapped_mrec =3D mapped_mrec;
> > +     ctx->attr_list_lock_ni =3D attr_list_lock_ni;
> > +     ctx->attr_list_lock_mode =3D attr_list_lock_mode;
> >  }
> >
> >  /*
> > @@ -1513,7 +1598,8 @@ void ntfs_attr_reinit_search_ctx(struct ntfs_attr=
_search_ctx *ctx)
> >   * and return it. Return NULL if allocation failed.
> >   */
> >  struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inod=
e *ni,
> > -             struct mft_record *mrec)
> > +             struct mft_record *mrec,
> > +             enum ntfs_attr_search_ctx_lock_mode lock_mode)
> >  {
> >       struct ntfs_attr_search_ctx *ctx;
> >       bool init;
> > @@ -1524,6 +1610,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search=
_ctx(struct ntfs_inode *ni,
> >               if (init =3D=3D false) {
> >                       kmem_cache_free(ntfs_attr_ctx_cache, ctx);
> >                       ctx =3D NULL;
> > +             } else {
> > +                     ntfs_attr_lock_search_ctx(ctx, ni, lock_mode);
> >               }
> >       }
> >
> > @@ -1539,6 +1627,8 @@ struct ntfs_attr_search_ctx *ntfs_attr_get_search=
_ctx(struct ntfs_inode *ni,
> >   */
> >  void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx)
> >  {
> > +     ntfs_attr_unlock_search_ctx(ctx);
> > +
> >       if (ctx->mapped_mrec)
> >               unmap_mft_record(ctx->ntfs_ino);
> >
> > @@ -1808,7 +1898,7 @@ int ntfs_attr_make_non_resident(struct ntfs_inode=
 *ni, const u32 data_size)
> >               ctx =3D NULL;
> >               goto err_out;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_R=
EAD);
> >       if (unlikely(!ctx)) {
> >               err =3D -ENOMEM;
> >               goto err_out;
> > @@ -2147,7 +2237,7 @@ int ntfs_attr_set_initialized_size(struct ntfs_in=
ode *ni, loff_t new_size)
> >       if (!NInoNonResident(ni))
> >               return -EINVAL;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx)
> >               return -ENOMEM;
> >
> > @@ -2247,7 +2337,7 @@ int ntfs_resident_attr_record_add(struct ntfs_ino=
de *ni, __le32 type,
> >       }
> >
> >       /* Locate place where record should be. */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NON=
E);
> >       if (!ctx) {
> >               ntfs_error(ni->vol->sb, "%s: Failed to get search context=
",
> >                               __func__);
> > @@ -2369,7 +2459,7 @@ static int ntfs_non_resident_attr_record_add(stru=
ct ntfs_inode *ni, __le32 type,
> >       }
> >
> >       /* Locate place where record should be. */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NON=
E);
> >       if (!ctx) {
> >               pr_err("%s: Failed to get search context\n", __func__);
> >               return -ENOMEM;
> > @@ -2479,6 +2569,7 @@ static int ntfs_non_resident_attr_record_add(stru=
ct ntfs_inode *ni, __le32 type,
> >  int ntfs_attr_record_rm(struct ntfs_attr_search_ctx *ctx)
> >  {
> >       struct ntfs_inode *base_ni, *ni;
> > +     u8 *old_al =3D NULL;
> >       __le32 type;
> >       int err;
> >
> > @@ -2517,9 +2608,11 @@ int ntfs_attr_record_rm(struct ntfs_attr_search_=
ctx *ctx)
> >       /* Post $ATTRIBUTE_LIST delete setup. */
> >       if (type =3D=3D AT_ATTRIBUTE_LIST) {
> >               if (NInoAttrList(base_ni) && base_ni->attr_list)
> > -                     kvfree(base_ni->attr_list);
> > +                     old_al =3D base_ni->attr_list;
> >               base_ni->attr_list =3D NULL;
> > +             base_ni->attr_list_size =3D 0;
> >               NInoClearAttrList(base_ni);
> > +             kvfree(old_al);
> >       }
> >
> >       /* Free MFT record, if it doesn't contain attributes. */
> > @@ -2944,7 +3037,7 @@ int ntfs_attr_open(struct ntfs_inode *ni, const _=
_le32 type,
> >               newname =3D name;
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               pr_err("%s: Failed to get search context\n", __func__);
> > @@ -3096,7 +3189,7 @@ void ntfs_attr_close(struct ntfs_inode *ni)
> >   * will map the runlist fragments from each of the extents thus giving=
 access
> >   * to the entirety of the disk allocation of an attribute.
> >   */
> > -int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
> > +int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni)
> >  {
> >       s64 next_vcn, last_vcn, highest_vcn;
> >       struct ntfs_attr_search_ctx *ctx;
> > @@ -3119,7 +3212,7 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inode=
 *ni)
> >       else
> >               base_ni =3D ni;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_NONE);
> >       if (!ctx) {
> >               ntfs_error(sb, "%s: Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -3211,6 +3304,18 @@ int ntfs_attr_map_whole_runlist(struct ntfs_inod=
e *ni)
> >       return err;
> >  }
> >
> > +int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni)
> > +{
> > +     struct ntfs_inode *attr_lock_ni;
> > +     int err;
> > +
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> > +     err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> > +
> > +     return err;
> > +}
> > +
> >  /*
> >   * ntfs_attr_record_move_to - move attribute record to target inode
> >   * @ctx:     attribute search context describing the attribute record
> > @@ -3245,7 +3350,7 @@ int ntfs_attr_record_move_to(struct ntfs_attr_sea=
rch_ctx *ctx, struct ntfs_inode
> >
> >       /* Find place in MFT record where attribute will be moved. */
> >       a =3D ctx->attr;
> > -     nctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     nctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_NO=
NE);
> >       if (!nctx) {
> >               ntfs_error(sb, "%s: Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -3332,7 +3437,7 @@ int ntfs_attr_record_move_away(struct ntfs_attr_s=
earch_ctx *ctx, int extra)
> >               return -EINVAL;
> >       }
> >
> > -     err =3D ntfs_inode_attach_all_extents(ctx->ntfs_ino);
> > +     err =3D ntfs_inode_attach_all_extents_nolock(ctx->ntfs_ino);
> >       if (err) {
> >               ntfs_error(sb, "Couldn't attach extents, inode=3D%llu",
> >                       (unsigned long long)base_ni->mft_no);
> > @@ -3431,9 +3536,8 @@ static int ntfs_attr_update_meta(struct attr_reco=
rd *a, struct ntfs_inode *ni,
> >               if ((le32_to_cpu(a->length) -
> >                    le16_to_cpu(a->data.non_resident.mapping_pairs_offse=
t) =3D=3D 8) &&
> >                   !(le32_to_cpu(m->bytes_allocated) - le32_to_cpu(m->by=
tes_in_use))) {
> > -
> >                       if (!NInoAttrList(base_ni)) {
> > -                             err =3D ntfs_inode_add_attrlist(base_ni);
> > +                             err =3D ntfs_inode_add_attrlist_nolock(ba=
se_ni);
> >                               if (err)
> >                                       goto out;
> >                               err =3D -EAGAIN;
> > @@ -3534,7 +3638,8 @@ static int ntfs_attr_update_meta(struct attr_reco=
rd *a, struct ntfs_inode *ni,
> >   * call to this function. Vice-versa @na->compressed_size will be calc=
ulated and
> >   * set to correct value during this function.
> >   */
> > -int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn=
)
> > +static int __ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64=
 from_vcn,
> > +                                         enum ntfs_attr_search_ctx_loc=
k_mode lock_mode)
>
> All callers pass NONE, so is the lock_mode still necessary?
>
> >  {
> >       struct ntfs_attr_search_ctx *ctx;
> >       struct ntfs_inode *base_ni;
> > @@ -3566,7 +3671,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_in=
ode *ni, s64 from_vcn)
> >       else
> >               base_ni =3D ni;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, lock_mode);
> >       if (!ctx) {
> >               ntfs_error(sb, "%s: Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -3666,8 +3771,8 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_in=
ode *ni, s64 from_vcn)
> >                        */
> >                       if (ni->type =3D=3D AT_ATTRIBUTE_LIST) {
> >                               ntfs_attr_put_search_ctx(ctx);
> > -                             if (ntfs_inode_free_space(base_ni, mp_siz=
e -
> > -                                                     cur_max_mp_size))=
 {
> > +                             if (ntfs_inode_free_space_nolock(base_ni,=
 mp_size -
> > +                                                             cur_max_m=
p_size)) {
> >                                       ntfs_debug("Attribute list is too=
 big. Defragment the volume\n");
> >                                       return -ENOSPC;
> >                               }
> > @@ -3679,7 +3784,7 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_in=
ode *ni, s64 from_vcn)
> >                       /* Add attribute list if it isn't present, and re=
try. */
> >                       if (!NInoAttrList(base_ni)) {
> >                               ntfs_attr_put_search_ctx(ctx);
> > -                             if (ntfs_inode_add_attrlist(base_ni)) {
> > +                             if (ntfs_inode_add_attrlist_nolock(base_n=
i)) {
> >                                       ntfs_error(sb, "Can not add attrl=
ist");
> >                                       return -EIO;
> >                               }
> > @@ -3883,6 +3988,24 @@ int ntfs_attr_update_mapping_pairs(struct ntfs_i=
node *ni, s64 from_vcn)
> >       return err;
> >  }
> >
> > +int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn=
)
> > +{
> > +     struct ntfs_inode *attr_lock_ni;
> > +     int err;
> > +
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> > +     err =3D __ntfs_attr_update_mapping_pairs(ni, from_vcn, NTFS_ATTR_=
CTX_LOCK_NONE);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> > +
> > +     return err;
> > +}
> > +
> > +int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 f=
rom_vcn)
> > +{
> > +     return __ntfs_attr_update_mapping_pairs(ni, from_vcn,
> > +                     NTFS_ATTR_CTX_LOCK_NONE);
> > +}
> > +
> >  /*
> >   * ntfs_attr_make_resident - convert a non-resident to a resident attr=
ibute
> >   * @ni:              open ntfs attribute to make resident
> > @@ -3940,7 +4063,7 @@ static int ntfs_attr_make_resident(struct ntfs_in=
ode *ni, struct ntfs_attr_searc
> >       }
> >
> >       /* Read and cache the whole runlist if not already done. */
> > -     err =3D ntfs_attr_map_whole_runlist(ni);
> > +     err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >       if (err)
> >               return err;
> >
> > @@ -4077,7 +4200,7 @@ static int ntfs_non_resident_attr_shrink(struct n=
tfs_inode *ni, const s64 newsiz
> >                       return err;
> >               }
> >
> > -             ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +             ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_=
LOCK_READ);
> >               if (!ctx) {
> >                       ntfs_error(vol->sb, "%s: Failed to get search con=
text", __func__);
> >                       return -ENOMEM;
> > @@ -4125,7 +4248,7 @@ static int ntfs_non_resident_attr_shrink(struct n=
tfs_inode *ni, const s64 newsiz
> >       }
> >
> >       /* Get the first attribute record. */
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_READ);
> >       if (!ctx) {
> >               ntfs_error(vol->sb, "%s: Failed to get search context", _=
_func__);
> >               return -ENOMEM;
> > @@ -4237,7 +4360,8 @@ static int ntfs_non_resident_attr_expand(struct n=
tfs_inode *ni, const s64 newsiz
> >        * clusters if there is a change.
> >        */
> >       if (ntfs_bytes_to_cluster(vol, ni->allocated_size) < first_free_v=
cn) {
> > -             err =3D ntfs_attr_map_whole_runlist(ni);
> > +             err =3D need_lock ? ntfs_attr_map_whole_runlist(ni) :
> > +                             ntfs_attr_map_whole_runlist_nolock(ni);
> >               if (err) {
> >                       ntfs_error(sb, "ntfs_attr_map_whole_runlist faile=
d");
> >                       return err;
> > @@ -4356,14 +4480,15 @@ static int ntfs_non_resident_attr_expand(struct=
 ntfs_inode *ni, const s64 newsiz
> >
> >               /* Prepare to mapping pairs update. */
> >               ni->allocated_size =3D ntfs_cluster_to_bytes(vol, first_f=
ree_vcn);
> > -             err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +             err =3D need_lock ? ntfs_attr_update_mapping_pairs(ni, 0)=
 :
> > +                             ntfs_attr_update_mapping_pairs_nolock(ni,=
 0);
> >               if (err) {
> >                       ntfs_debug("Mapping pairs update failed");
> >                       goto rollback;
> >               }
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               if (ni->allocated_size =3D=3D org_alloc_size)
> > @@ -4414,16 +4539,22 @@ static int ntfs_non_resident_attr_expand(struct=
 ntfs_inode *ni, const s64 newsiz
> >               kvfree(ni->runlist.rl);
> >               ni->runlist.rl =3D NULL;
> >               ntfs_error(sb, "Couldn't truncate runlist. Rollback faile=
d");
> > -     } else {
> > -             /* Prepare to mapping pairs update. */
> > -             ni->allocated_size =3D org_alloc_size;
> > -             /* Restore mapping pairs. */
> > -             if (need_lock)
> > -                     down_read(&ni->runlist.lock);
> > -             if (ntfs_attr_update_mapping_pairs(ni, 0))
> > -                     ntfs_error(sb, "Failed to restore old mapping pai=
rs");
> > -             if (need_lock)
> > -                     up_read(&ni->runlist.lock);
> > +             } else {
> > +                     /* Prepare to mapping pairs update. */
> > +                     ni->allocated_size =3D org_alloc_size;
> > +                     /* Restore mapping pairs. */
> > +                     if (need_lock) {
> > +                             struct ntfs_inode *attr_lock_ni;
> > +
> > +                             attr_lock_ni =3D ntfs_attr_list_lock(ni, =
NTFS_ATTR_CTX_LOCK_WRITE);
> > +                             down_read(&ni->runlist.lock);
> > +                             if (ntfs_attr_update_mapping_pairs_nolock=
(ni, 0))
> > +                                     ntfs_error(sb, "Failed to restore=
 old mapping pairs");
> > +                             up_read(&ni->runlist.lock);
> > +                             ntfs_attr_list_unlock(attr_lock_ni, NTFS_=
ATTR_CTX_LOCK_WRITE);
> > +                     } else if (ntfs_attr_update_mapping_pairs_nolock(=
ni, 0)) {
> > +                             ntfs_error(sb, "Failed to restore old map=
ping pairs");
> > +                     }
> >
> >               if (NInoSparse(ni) || NInoCompressed(ni)) {
> >                       ni->itype.compressed.size =3D  org_compressed_siz=
e;
> > @@ -4469,7 +4600,7 @@ static int ntfs_resident_attr_resize(struct ntfs_=
inode *attr_ni, const s64 newsi
> >               base_ni =3D attr_ni;
> >
> >       /* Get the attribute record that needs modification. */
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_READ);
>
> attr_list_lock can be acquired recursively. this function calls
> ntfs_attr_make_non_resident(), which also calls
> ntfs_attr_get_search_ctx().
>
> >       if (!ctx) {
> >               ntfs_error(sb, "%s: Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -4698,12 +4829,16 @@ int __ntfs_attr_truncate_vfs(struct ntfs_inode =
*ni, const s64 newsize,
> >
> >       if (NInoNonResident(ni)) {
> >               if (newsize > i_size) {
> > +                     struct ntfs_inode *attr_lock_ni;
> > +
> > +                     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATT=
R_CTX_LOCK_WRITE);
> >                       down_write(&ni->runlist.lock);
> >                       err =3D ntfs_non_resident_attr_expand(ni, newsize=
, 0,
> >                                                           NVolDisableSp=
arse(ni->vol) ?
> >                                                           HOLES_NO : HO=
LES_OK,
> >                                                           false);
> >                       up_write(&ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >               } else
> >                       err =3D ntfs_non_resident_attr_shrink(ni, newsize=
);
> >       } else
> > @@ -4833,14 +4968,17 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni=
, s64 vcn_start, s64 *lcn_start,
> >       int err =3D 0;
> >       size_t new_rl_count;
> >
> > -     err =3D ntfs_attr_map_whole_runlist(ni);
> > +     err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >       if (err)
> >               return err;
> >
> > -     if (NInoAttr(ni))
> > -             ctx =3D ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, N=
ULL);
> > -     else
> > -             ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     if (NInoAttr(ni)) {
> > +             struct ntfs_inode *base_ni =3D ni->ext.base_ntfs_ino;
> > +
> > +             ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR=
_CTX_LOCK_NONE);
> > +     } else {
> > +             ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_=
LOCK_NONE);
> > +     }
> >       if (!ctx) {
> >               ntfs_error(vol->sb, "%s: Failed to get search context", _=
_func__);
> >               return -ENOMEM;
> > @@ -4947,7 +5085,7 @@ int ntfs_attr_map_cluster(struct ntfs_inode *ni, =
s64 vcn_start, s64 *lcn_start,
> >
> >       if (update_mp) {
> >               ntfs_attr_reinit_search_ctx(ctx);
> > -             err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +             err =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >               if (err) {
> >                       int err2;
> >
> > @@ -5000,7 +5138,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
> >               err =3D ntfs_attr_map_whole_runlist(ni);
> >               if (err)
> >                       return err;
> > -             ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +             ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_=
LOCK_READ);
> >               if (!ctx) {
> >                       ntfs_error(sb, "%s: Failed to get search context"=
, __func__);
> >                       return -ENOMEM;
> > @@ -5014,7 +5152,7 @@ int ntfs_attr_rm(struct ntfs_inode *ni)
> >       }
> >
> >       /* Search for attribute extents and remove them all. */
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_WRITE);
> >       if (!ctx) {
> >               ntfs_error(sb, "%s: Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -5046,7 +5184,7 @@ int ntfs_attr_exist(struct ntfs_inode *ni, const =
__le32 type, __le16 *name,
> >
> >       ntfs_debug("Entering\n");
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               ntfs_error(ni->vol->sb, "%s: Failed to get search context=
",
> >                               __func__);
> > @@ -5155,6 +5293,7 @@ void *ntfs_attr_readall(struct ntfs_inode *ni, co=
nst __le32 type,
> >  int ntfs_non_resident_attr_insert_range(struct ntfs_inode *ni, s64 sta=
rt_vcn, s64 len)
> >  {
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *hole_rl, *rl;
> >       struct ntfs_attr_search_ctx *ctx;
> >       int ret;
> > @@ -5175,16 +5314,19 @@ int ntfs_non_resident_attr_insert_range(struct =
ntfs_inode *ni, s64 start_vcn, s6
> >       hole_rl[1].lcn =3D LCN_ENOENT;
> >       hole_rl[1].length =3D 0;
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> > -     ret =3D ntfs_attr_map_whole_runlist(ni);
> > +     ret =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >       if (ret) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return ret;
> >       }
> >
> >       rl =3D ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
> >       if (!rl) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               kfree(hole_rl);
> >               return -EIO;
> >       }
> > @@ -5193,6 +5335,7 @@ int ntfs_non_resident_attr_insert_range(struct nt=
fs_inode *ni, s64 start_vcn, s6
> >                                 hole_rl, 1, &new_rl_count);
> >       if (IS_ERR(rl)) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               kfree(hole_rl);
> >               return PTR_ERR(rl);
> >       }
> > @@ -5203,12 +5346,13 @@ int ntfs_non_resident_attr_insert_range(struct =
ntfs_inode *ni, s64 start_vcn, s6
> >       ni->data_size +=3D ntfs_cluster_to_bytes(vol, len);
> >       if (ntfs_cluster_to_bytes(vol, start_vcn) < ni->initialized_size)
> >               ni->initialized_size +=3D ntfs_cluster_to_bytes(vol, len)=
;
> > -     ret =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +     ret =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       if (ret)
> >               return ret;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               ret =3D -ENOMEM;
> >               return ret;
> > @@ -5233,6 +5377,7 @@ int ntfs_non_resident_attr_insert_range(struct nt=
fs_inode *ni, s64 start_vcn, s6
> >  int ntfs_non_resident_attr_collapse_range(struct ntfs_inode *ni, s64 s=
tart_vcn, s64 len)
> >  {
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *punch_rl, *rl;
> >       struct ntfs_attr_search_ctx *ctx =3D NULL;
> >       s64 end_vcn;
> > @@ -5247,10 +5392,12 @@ int ntfs_non_resident_attr_collapse_range(struc=
t ntfs_inode *ni, s64 start_vcn,
> >       if (start_vcn >=3D end_vcn)
> >               return -EINVAL;
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> > -     ret =3D ntfs_attr_map_whole_runlist(ni);
> > +     ret =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >       if (ret) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return ret;
> >       }
> >
> > @@ -5260,6 +5407,7 @@ int ntfs_non_resident_attr_collapse_range(struct =
ntfs_inode *ni, s64 start_vcn,
> >       rl =3D ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
> >       if (!rl) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return -EIO;
> >       }
> >
> > @@ -5267,6 +5415,7 @@ int ntfs_non_resident_attr_collapse_range(struct =
ntfs_inode *ni, s64 start_vcn,
> >                                   start_vcn, len, &punch_rl, &new_rl_cn=
t);
> >       if (IS_ERR(rl)) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return PTR_ERR(rl);
> >       }
> >       ni->runlist.rl =3D rl;
> > @@ -5288,15 +5437,17 @@ int ntfs_non_resident_attr_collapse_range(struc=
t ntfs_inode *ni, s64 start_vcn,
> >       }
> >
> >       if (ni->allocated_size > 0) {
> > -             ret =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +             ret =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >               if (ret) {
> >                       up_write(&ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >                       goto out_rl;
> >               }
> >       }
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               ret =3D -ENOMEM;
> >               goto out_rl;
> > @@ -5328,6 +5479,7 @@ int ntfs_non_resident_attr_collapse_range(struct =
ntfs_inode *ni, s64 start_vcn,
> >  int ntfs_non_resident_attr_punch_hole(struct ntfs_inode *ni, s64 start=
_vcn, s64 len)
> >  {
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *punch_rl, *rl;
> >       s64 end_vcn;
> >       int dst_cnt;
> > @@ -5341,10 +5493,12 @@ int ntfs_non_resident_attr_punch_hole(struct nt=
fs_inode *ni, s64 start_vcn, s64
> >       if (start_vcn >=3D end_vcn)
> >               return -EINVAL;
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> > -     ret =3D ntfs_attr_map_whole_runlist(ni);
> > +     ret =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >       if (ret) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return ret;
> >       }
> >
> > @@ -5354,6 +5508,7 @@ int ntfs_non_resident_attr_punch_hole(struct ntfs=
_inode *ni, s64 start_vcn, s64
> >       rl =3D ntfs_rl_find_vcn_nolock(ni->runlist.rl, start_vcn);
> >       if (!rl) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return -EIO;
> >       }
> >
> > @@ -5361,13 +5516,15 @@ int ntfs_non_resident_attr_punch_hole(struct nt=
fs_inode *ni, s64 start_vcn, s64
> >                               start_vcn, len, &punch_rl, &new_rl_count)=
;
> >       if (IS_ERR(rl)) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               return PTR_ERR(rl);
> >       }
> >       ni->runlist.rl =3D rl;
> >       ni->runlist.count =3D new_rl_count;
> >
> > -     ret =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +     ret =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       if (ret) {
> >               kvfree(punch_rl);
> >               return ret;
> > @@ -5398,9 +5555,13 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, l=
off_t start, loff_t byte_len, bo
> >               return -EINVAL;
> >
> >       if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
> > +             struct ntfs_inode *attr_lock_ni;
> > +
> > +             attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LO=
CK_READ);
> >               down_write(&ni->runlist.lock);
> > -             err =3D ntfs_attr_map_whole_runlist(ni);
> > +             err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >               if (err)
> >                       return err;
> >       }
> > @@ -5412,7 +5573,7 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, lo=
ff_t start, loff_t byte_len, bo
> >               return PTR_ERR(mrec);
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto out_unmap;
> > @@ -5487,11 +5648,15 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, =
loff_t start, loff_t byte_len, bo
> >                       }
> >
> >                       while (try_alloc_cnt > 0) {
> > +                             struct ntfs_inode *attr_lock_ni;
> > +
> >                               mutex_lock_nested(&ni->mrec_lock, NTFS_IN=
ODE_MUTEX_NORMAL);
> > +                             attr_lock_ni =3D ntfs_attr_list_lock(ni, =
NTFS_ATTR_CTX_LOCK_WRITE);
> >                               down_write(&ni->runlist.lock);
> >                               err =3D ntfs_attr_map_cluster(ni, vcn, &l=
cn, &alloc_cnt,
> >                                                           try_alloc_cnt=
, &balloc, false, false);
> >                               up_write(&ni->runlist.lock);
> > +                             ntfs_attr_list_unlock(attr_lock_ni, NTFS_=
ATTR_CTX_LOCK_WRITE);
> >                               mutex_unlock(&ni->mrec_lock);
> >                               if (err)
> >                                       goto out;
> > @@ -5517,11 +5682,15 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, =
loff_t start, loff_t byte_len, bo
> >       /* allocate clusters outside of initialized_size */
> >       try_alloc_cnt =3D vcn_end - vcn;
> >       while (try_alloc_cnt > 0) {
> > +             struct ntfs_inode *attr_lock_ni;
> > +
> >               mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL=
);
> > +             attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LO=
CK_WRITE);
> >               down_write(&ni->runlist.lock);
> >               err =3D ntfs_attr_map_cluster(ni, vcn, &lcn, &alloc_cnt,
> >                                           try_alloc_cnt, &balloc, false=
, false);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               mutex_unlock(&ni->mrec_lock);
> >               if (err || signal_pending(current))
> >                       goto out;
> > @@ -5532,14 +5701,18 @@ int ntfs_attr_fallocate(struct ntfs_inode *ni, =
loff_t start, loff_t byte_len, bo
> >       }
> >
> >       if (NInoRunlistDirty(ni)) {
> > +             struct ntfs_inode *attr_lock_ni;
> > +
> >               mutex_lock_nested(&ni->mrec_lock, NTFS_INODE_MUTEX_NORMAL=
);
> > +             attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LO=
CK_WRITE);
> >               down_write(&ni->runlist.lock);
> > -             err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +             err =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >               if (err)
> >                       ntfs_error(ni->vol->sb, "Updating mapping pairs f=
ailed");
> >               else
> >                       NInoClearRunlistDirty(ni);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               mutex_unlock(&ni->mrec_lock);
> >       }
> >       return err;
> > diff --git a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
> > index f7acc7986b090..b4d457b267797 100644
> > --- a/fs/ntfs/attrib.h
> > +++ b/fs/ntfs/attrib.h
> > @@ -26,6 +26,8 @@ extern __le16 AT_UNNAMED[];
> >   * @base_ntfs_ino: Base inode
> >   * @mapped_base_mrec: true if @base_mrec was mapped by the search
> >   * @base_attr: Base attribute record pointer
> > + * @attr_list_lock_ni: Base inode whose attr_list_lock is held
> > + * @attr_list_lock_mode: attr_list_lock mode held by this context
> >   *
> >   * Structure must be initialized to zero before the first call to one =
of the
> >   * attribute search functions. Initialize @mrec to point to the mft re=
cord to
> > @@ -39,6 +41,12 @@ extern __le16 AT_UNNAMED[];
> >   * any modification of the search context, to automagically get the ne=
xt
> >   * matching attribute.
> >   */
> > +enum ntfs_attr_search_ctx_lock_mode {
> > +     NTFS_ATTR_CTX_LOCK_NONE,
> > +     NTFS_ATTR_CTX_LOCK_READ,
> > +     NTFS_ATTR_CTX_LOCK_WRITE,
> > +};
> > +
> >  struct ntfs_attr_search_ctx {
> >       struct mft_record *mrec;
> >       bool mapped_mrec;
> > @@ -50,6 +58,8 @@ struct ntfs_attr_search_ctx {
> >       struct mft_record *base_mrec;
> >       bool mapped_base_mrec;
> >       struct attr_record *base_attr;
> > +     struct ntfs_inode *attr_list_lock_ni;
> > +     enum ntfs_attr_search_ctx_lock_mode attr_list_lock_mode;
> >  };
> >
> >  enum {                  /* ways of processing holes when expanding */
> > @@ -66,6 +76,7 @@ struct runlist_element *ntfs_attr_find_vcn_nolock(str=
uct ntfs_inode *ni,
> >               const s64 vcn, struct ntfs_attr_search_ctx *ctx);
> >  struct runlist_element *__ntfs_attr_find_vcn_nolock(struct runlist *ru=
nlist,
> >               const s64 vcn);
> > +int ntfs_attr_map_whole_runlist_nolock(struct ntfs_inode *ni);
> >  int ntfs_attr_map_whole_runlist(struct ntfs_inode *ni);
> >  int ntfs_attr_lookup(const __le32 type, const __le16 *name,
> >               const u32 name_len, const u32 ic,
> > @@ -83,7 +94,16 @@ static inline s64 ntfs_attr_size(const struct attr_r=
ecord *a)
> >
> >  void ntfs_attr_reinit_search_ctx(struct ntfs_attr_search_ctx *ctx);
> >  struct ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(struct ntfs_inod=
e *ni,
> > -             struct mft_record *mrec);
> > +             struct mft_record *mrec,
> > +             enum ntfs_attr_search_ctx_lock_mode lock_mode);
> > +struct ntfs_inode *ntfs_attr_list_lock(struct ntfs_inode *ni,
> > +                                    enum ntfs_attr_search_ctx_lock_mod=
e lock_mode);
> > +void ntfs_attr_list_unlock(struct ntfs_inode *lock_ni,
> > +                        enum ntfs_attr_search_ctx_lock_mode lock_mode)=
;
> > +void ntfs_attr_lock_search_ctx(struct ntfs_attr_search_ctx *ctx,
> > +                            struct ntfs_inode *ni,
> > +                            enum ntfs_attr_search_ctx_lock_mode lock_m=
ode);
> > +void ntfs_attr_unlock_search_ctx(struct ntfs_attr_search_ctx *ctx);
> >  void ntfs_attr_put_search_ctx(struct ntfs_attr_search_ctx *ctx);
> >  int ntfs_attr_size_bounds_check(const struct ntfs_volume *vol,
> >               const __le32 type, const s64 size);
> > @@ -129,6 +149,7 @@ int ntfs_resident_attr_record_add(struct ntfs_inode=
 *ni, __le32 type,
> >               __le16 *name, u8 name_len, u8 *val, u32 size,
> >               __le16 flags);
> >  int ntfs_attr_update_mapping_pairs(struct ntfs_inode *ni, s64 from_vcn=
);
> > +int ntfs_attr_update_mapping_pairs_nolock(struct ntfs_inode *ni, s64 f=
rom_vcn);
> >  struct runlist_element *ntfs_attr_vcn_to_rl(struct ntfs_inode *ni, s64=
 vcn, s64 *lcn);
> >
> >  /*
> > @@ -144,7 +165,9 @@ struct runlist_element *ntfs_attr_vcn_to_rl(struct =
ntfs_inode *ni, s64 vcn, s64
> >   *       @ni, you can simply do:
> >   *
> >   *   int err;
> > - *   struct ntfs_attr_search_ctx *ctx =3D ntfs_attr_get_search_ctx(ni,=
 NULL);
> > + *   struct ntfs_attr_search_ctx *ctx;
> > + *
> > + *   ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >   *   if (!ctx)
> >   *           // Error code is in errno. Handle this case.
> >   *   while (!(err =3D ntfs_attrs_walk(ctx))) {
> > diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
> > index bd501e8a628c4..56967aca8c7a2 100644
> > --- a/fs/ntfs/attrlist.c
> > +++ b/fs/ntfs/attrlist.c
> > @@ -153,7 +153,7 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, =
struct attr_record *attr)
> >               return -ENOMEM;
> >
> >       /* Find place for the new entry. */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WRI=
TE);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               ntfs_error(ni->vol->sb, "Failed to get search context");
> > @@ -172,7 +172,6 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni, =
struct attr_record *attr)
> >               if (ctx->al_entry->lowest_vcn =3D=3D attr->data.non_resid=
ent.lowest_vcn) {
> >                       err =3D -EEXIST;
> >                       ntfs_debug("Such attribute already present in the=
 attribute list.\n");
> > -                     ntfs_attr_put_search_ctx(ctx);
> >                       goto err_out;
> >               }
> >               /* Add new entry after this extent. */
> > @@ -182,15 +181,11 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni=
, struct attr_record *attr)
> >               /* Check for real errors. */
> >               if (err !=3D -ENOENT) {
> >                       ntfs_debug("Attribute lookup failed.\n");
> > -                     ntfs_attr_put_search_ctx(ctx);
> >                       goto err_out;
> >               }
> >               /* No previous extents found. */
> >               ale =3D ctx->al_entry;
> >       }
> > -     /* Don't need it anymore, @ctx->al_entry points to @ni->attr_list=
. */
> > -     ntfs_attr_put_search_ctx(ctx);
> > -
> >       /* Determine new entry offset. */
> >       entry_offset =3D ((u8 *)ale - ni->attr_list);
> >       /* Set pointer to new entry. */
> > @@ -219,16 +214,22 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni=
, struct attr_record *attr)
> >       old_al =3D ni->attr_list;
> >       ni->attr_list =3D new_al;
> >       ni->attr_list_size =3D ni->attr_list_size + entry_len;
> > +     ntfs_attr_put_search_ctx(ctx);
> > +     ctx =3D NULL;
> >
> >       err =3D ntfs_attrlist_update(ni);
> >       if (err) {
> > +             down_write(&ni->attr_list_lock);
> >               ni->attr_list =3D old_al;
> >               ni->attr_list_size -=3D entry_len;
> > +             up_write(&ni->attr_list_lock);
> >               goto err_out;
> >       }
> >       kvfree(old_al);
> >       return 0;
> >  err_out:
> > +     if (ctx)
> > +             ntfs_attr_put_search_ctx(ctx);
> >       kvfree(new_al);
> >       return err;
> >  }
> > @@ -244,9 +245,12 @@ int ntfs_attrlist_entry_add(struct ntfs_inode *ni,=
 struct attr_record *attr)
> >  int ntfs_attrlist_entry_rm(struct ntfs_attr_search_ctx *ctx)
> >  {
> >       u8 *new_al;
> > -     int new_al_len;
> > +     int err, new_al_len;
> >       struct ntfs_inode *base_ni;
> >       struct attr_list_entry *ale;
> > +     enum ntfs_attr_search_ctx_lock_mode lock_mode;
> > +     bool ctx_locked;
> > +     u8 *old_al;
> >
> >       if (!ctx || !ctx->ntfs_ino || !ctx->al_entry) {
> >               ntfs_debug("Invalid arguments.\n");
> > @@ -281,9 +285,17 @@ int ntfs_attrlist_entry_rm(struct ntfs_attr_search=
_ctx *ctx)
> >                               ale->length), new_al_len - ((u8 *)ale - b=
ase_ni->attr_list));
> >
> >       /* Set new runlist. */
> > -     kvfree(base_ni->attr_list);
> > +     old_al =3D base_ni->attr_list;
> >       base_ni->attr_list =3D new_al;
> >       base_ni->attr_list_size =3D new_al_len;
> > +     kvfree(old_al);
> >
> > -     return ntfs_attrlist_update(base_ni);
> > +     ctx_locked =3D ctx->attr_list_lock_ni;
> > +     lock_mode =3D ctx->attr_list_lock_mode;
> > +     if (ctx_locked)
> > +             ntfs_attr_unlock_search_ctx(ctx);
> > +     err =3D ntfs_attrlist_update(base_ni);
> > +     if (ctx_locked)
> > +             ntfs_attr_lock_search_ctx(ctx, base_ni, lock_mode);
> > +     return err;
> >  }
> > diff --git a/fs/ntfs/compress.c b/fs/ntfs/compress.c
> > index 76bd806b41edd..bac6b32069475 100644
> > --- a/fs/ntfs/compress.c
> > +++ b/fs/ntfs/compress.c
> > @@ -1287,6 +1287,7 @@ static int ntfs_write_cb(struct ntfs_inode *ni, l=
off_t pos, struct page **pages,
> >       /* more compressed zeroes, to be followed by some count */
> >       static char morezeroes[] =3D {0x03, 0xb0, 0x02, 0x00};
> >       struct page **pages_disk =3D NULL, *pg;
> > +     struct ntfs_inode *attr_lock_ni;
> >       s64 bio_lcn;
> >       struct runlist_element *rlc, *rl;
> >       int i, err;
> > @@ -1390,10 +1391,12 @@ static int ntfs_write_cb(struct ntfs_inode *ni,=
 loff_t pos, struct page **pages,
> >       }
> >
> >       bio_lcn =3D rlc->lcn;
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> >       rl =3D ntfs_runlists_merge(&ni->runlist, rlc, 0, &new_rl_count);
> >       if (IS_ERR(rl)) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               ntfs_error(vol->sb, "Failed to merge runlists");
> >               err =3D PTR_ERR(rl);
> >               if (ntfs_cluster_free_from_rl(vol, rlc))
> > @@ -1405,8 +1408,9 @@ static int ntfs_write_cb(struct ntfs_inode *ni, l=
off_t pos, struct page **pages,
> >       ni->runlist.count =3D new_rl_count;
> >       ni->runlist.rl =3D rl;
> >
> > -     err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +     err =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       if (err) {
> >               err =3D -EIO;
> >               goto out;
> > diff --git a/fs/ntfs/dir.c b/fs/ntfs/dir.c
> > index 20f5c7074bdd1..84ca11227d060 100644
> > --- a/fs/ntfs/dir.c
> > +++ b/fs/ntfs/dir.c
> > @@ -91,7 +91,7 @@ u64 ntfs_lookup_inode_by_name(struct ntfs_inode *dir_=
ni, const __le16 *uname,
> >                               -PTR_ERR(m));
> >               return ERR_MREF(PTR_ERR(m));
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(dir_ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(dir_ni, m, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >       if (unlikely(!ctx)) {
> >               err =3D -ENOMEM;
> >               goto err_out;
> > @@ -854,7 +854,7 @@ static int ntfs_readdir(struct file *file, struct d=
ir_context *actor)
> >               file->private_data =3D private;
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ndir, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ndir, NULL, NTFS_ATTR_CTX_LOCK_R=
EAD);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto out;
> > @@ -1061,7 +1061,7 @@ int ntfs_check_empty_dir(struct ntfs_inode *ni, s=
truct mft_record *ni_mrec)
> >       if (!(ni_mrec->flags & MFT_RECORD_IS_DIRECTORY))
> >               return 0;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               ntfs_error(ni->vol->sb, "Failed to get search context");
> >               return -ENOMEM;
> > @@ -1162,7 +1162,7 @@ static int ntfs_dir_fsync(struct file *filp, loff=
_t start, loff_t end,
> >       if (NVolShutdown(vol))
> >               return -EIO;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx)
> >               return -ENOMEM;
> >
> > diff --git a/fs/ntfs/ea.c b/fs/ntfs/ea.c
> > index c4a4a3e3e5996..3cba0ff9606cb 100644
> > --- a/fs/ntfs/ea.c
> > +++ b/fs/ntfs/ea.c
> > @@ -587,7 +587,7 @@ static int ntfs_new_attr_flags(struct ntfs_inode *n=
i, __le32 fattr)
> >       if (IS_ERR(m))
> >               return PTR_ERR(m);
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto err_out;
> > diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
> > index e8bea22b81a75..038ed723c4bff 100644
> > --- a/fs/ntfs/file.c
> > +++ b/fs/ntfs/file.c
> > @@ -22,6 +22,7 @@
> >  #include "ea.h"
> >  #include "iomap.h"
> >  #include "bitmap.h"
> > +#include "attrib.h"
> >
> >  #include <linux/filelock.h>
> >
> > @@ -78,6 +79,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
> >  {
> >       struct ntfs_inode *ni =3D NTFS_I(vi);
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *rl;
> >       s64 aligned_data_size;
> >       s64 vcn_ds, vcn_tr;
> > @@ -86,6 +88,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
> >
> >       inode_lock(vi);
> >       mutex_lock(&ni->mrec_lock);
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> >
> >       aligned_data_size =3D round_up(ni->data_size, vol->cluster_size);
> > @@ -110,7 +113,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
> >                       ntfs_error(vol->sb, "Preallocated block rollback =
failed");
> >               } else {
> >                       ni->allocated_size =3D ntfs_cluster_to_bytes(vol,=
 vcn_tr);
> > -                     err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +                     err =3D ntfs_attr_update_mapping_pairs_nolock(ni,=
 0);
> >                       if (err)
> >                               ntfs_error(vol->sb,
> >                                          "Failed to rollback mapping pa=
irs for prealloc");
> > @@ -119,6 +122,7 @@ static int ntfs_trim_prealloc(struct inode *vi)
> >
> >  out_unlock:
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       mutex_unlock(&ni->mrec_lock);
> >       inode_unlock(vi);
> >
> > @@ -176,7 +180,7 @@ static int ntfs_file_fsync(struct file *filp, loff_=
t start, loff_t end,
> >               ret =3D __ntfs_write_inode(vi, 1);
> >       write_inode_now(vi, !datasync);
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx)
> >               return -ENOMEM;
> >
> > @@ -1028,6 +1032,7 @@ static long ntfs_fallocate(struct file *file, int=
 mode, loff_t offset, loff_t le
> >       struct inode *vi =3D file_inode(file);
> >       struct ntfs_inode *ni =3D NTFS_I(vi);
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       int err =3D 0;
> >       loff_t old_size;
> >       bool map_locked =3D false;
> > @@ -1042,9 +1047,11 @@ static long ntfs_fallocate(struct file *file, in=
t mode, loff_t offset, loff_t le
> >               return -ENOSPC;
> >
> >       if (NInoNonResident(ni) && !NInoFullyMapped(ni)) {
> > +             attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LO=
CK_READ);
> >               down_write(&ni->runlist.lock);
> > -             err =3D ntfs_attr_map_whole_runlist(ni);
> > +             err =3D ntfs_attr_map_whole_runlist_nolock(ni);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >               if (err)
> >                       return err;
> >       }
> > diff --git a/fs/ntfs/index.c b/fs/ntfs/index.c
> > index a547bdcfa4561..f6d31465c7b93 100644
> > --- a/fs/ntfs/index.c
> > +++ b/fs/ntfs/index.c
> > @@ -509,7 +509,7 @@ static struct index_root *ntfs_ir_lookup(struct ntf=
s_inode *ni, __le16 *name,
> >       struct index_root *ir =3D NULL;
> >
> >       ntfs_debug("Entering\n");
> > -     *ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     *ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >       if (!*ctx) {
> >               ntfs_error(ni->vol->sb, "%s, Failed to get search context=
", __func__);
> >               return NULL;
> > @@ -1240,7 +1240,8 @@ static int ntfs_ir_reparent(struct ntfs_index_con=
text *icx)
> >                * When there is no space to build a non-resident
> >                * index, we may have to move the root to an extent
> >                */
> > -             if ((ret =3D=3D -ENOSPC) && (ctx->al_entry || !ntfs_inode=
_add_attrlist(icx->idx_ni))) {
> > +             if ((ret =3D=3D -ENOSPC) &&
> > +                 (ctx->al_entry || !ntfs_inode_add_attrlist_nolock(icx=
->idx_ni))) {
> >                       ntfs_attr_put_search_ctx(ctx);
> >                       ctx =3D NULL;
> >                       ir =3D ntfs_ir_lookup(icx->idx_ni, icx->name, icx=
->name_len, &ctx);
> > diff --git a/fs/ntfs/inode.c b/fs/ntfs/inode.c
> > index 16890d411194d..1cbeb6a68e915 100644
> > --- a/fs/ntfs/inode.c
> > +++ b/fs/ntfs/inode.c
> > @@ -326,7 +326,7 @@ static int ntfs_non_resident_dealloc_clusters(struc=
t ntfs_inode *ni)
> >       struct ntfs_attr_search_ctx *actx;
> >       int err =3D 0;
> >
> > -     actx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     actx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >       if (!actx)
> >               return -ENOMEM;
> >       WARN_ON(actx->mrec->link_count !=3D 0);
> > @@ -475,6 +475,7 @@ void __ntfs_init_inode(struct super_block *sb, stru=
ct ntfs_inode *ni)
> >       ni->folio =3D NULL;
> >       ni->folio_ofs =3D 0;
> >       ni->mrec =3D NULL;
> > +     init_rwsem(&ni->attr_list_lock);
> >       ni->attr_list_size =3D 0;
> >       ni->attr_list =3D NULL;
> >       ni->itype.index.block_size =3D 0;
> > @@ -711,7 +712,7 @@ static int ntfs_read_locked_inode(struct inode *vi)
> >               goto err_out;
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto unm_err_out;
> > @@ -1265,7 +1266,7 @@ static int ntfs_read_locked_attr_inode(struct ino=
de *base_vi, struct inode *vi)
> >               err =3D PTR_ERR(m);
> >               goto err_out;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_R=
EAD);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto unm_err_out;
> > @@ -1506,7 +1507,7 @@ static int ntfs_read_locked_index_inode(struct in=
ode *base_vi, struct inode *vi)
> >               err =3D PTR_ERR(m);
> >               goto err_out;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, m, NTFS_ATTR_CTX_LOCK_R=
EAD);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto unm_err_out;
> > @@ -1897,7 +1898,7 @@ int ntfs_read_inode_mount(struct inode *vi)
> >       /* Provides read_folio() for map_mft_record(). */
> >       vi->i_mapping->a_ops =3D &ntfs_mft_aops;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto err_out;
> > @@ -2447,7 +2448,7 @@ static int ntfs_inode_sync_standard_information(s=
truct inode *vi, struct mft_rec
> >       bool modified =3D false;
> >
> >       /* Update the access times in the standard information attribute.=
 */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR_CTX_LOCK_READ);
> >       if (unlikely(!ctx))
> >               return -ENOMEM;
> >       err =3D ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
> > @@ -2548,7 +2549,7 @@ int ntfs_inode_sync_filename(struct ntfs_inode *n=
i)
> >
> >       ntfs_debug("Entering for inode %llu\n", ni->mft_no);
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx)
> >               return -ENOMEM;
> >
> > @@ -2740,11 +2741,15 @@ int __ntfs_write_inode(struct inode *vi, int sy=
nc)
> >       }
> >
> >       if (NInoNonResident(ni) && NInoRunlistDirty(ni)) {
> > +             struct ntfs_inode *attr_lock_ni;
> > +
> > +             attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LO=
CK_WRITE);
> >               down_write(&ni->runlist.lock);
> > -             err =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +             err =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >               if (!err)
> >                       NInoClearRunlistDirty(ni);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >       }
> >
> >       err =3D ntfs_inode_sync_standard_information(vi, m);
> > @@ -2963,7 +2968,7 @@ static struct ntfs_inode *ntfs_extent_inode_open(=
struct ntfs_inode *base_ni,
> >   *
> >   * Return 0 on success and error.
> >   */
> > -int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
> > +int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni)
> >  {
> >       struct attr_list_entry *ale;
> >       u64 prev_attached =3D 0;
> > @@ -3003,13 +3008,25 @@ int ntfs_inode_attach_all_extents(struct ntfs_i=
node *ni)
> >       return 0;
> >  }
> >
> > +int ntfs_inode_attach_all_extents(struct ntfs_inode *ni)
> > +{
> > +     struct ntfs_inode *attr_lock_ni;
> > +     int err;
> > +
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> > +     err =3D ntfs_inode_attach_all_extents_nolock(ni);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> > +
> > +     return err;
> > +}
> > +
> >  /*
> >   * ntfs_inode_add_attrlist - add attribute list to inode and fill it
> >   * @ni: opened ntfs inode to which add attribute list
> >   *
> >   * Return 0 on success or error.
> >   */
> > -int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
> > +int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni)
> >  {
> >       int err;
> >       struct ntfs_attr_search_ctx *ctx;
> > @@ -3034,7 +3051,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni=
)
> >               return -EIO;
> >
> >       /* Form attribute list. */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, ni_mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, ni_mrec, NTFS_ATTR_CTX_LOCK_=
NONE);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto err_out;
> > @@ -3092,7 +3109,6 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni=
)
> >               goto put_err_out;
> >       }
> >
> > -     /* Set in-memory attribute list. */
> >       ni->attr_list =3D al;
> >       ni->attr_list_size =3D al_len;
> >       NInoSetAttrList(ni);
> > @@ -3102,7 +3118,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni=
)
> >       /* Free space if there is not enough it for $ATTRIBUTE_LIST. */
> >       if (le32_to_cpu(ni_mrec->bytes_allocated) -
> >                       le32_to_cpu(ni_mrec->bytes_in_use) < attr_al_len)=
 {
> > -             if (ntfs_inode_free_space(ni, (int)attr_al_len)) {
> > +             if (ntfs_inode_free_space_nolock(ni, (int)attr_al_len)) {
> >                       /* Failed to free space. */
> >                       err =3D -ENOSPC;
> >                       ntfs_error(ni->vol->sb, "Failed to free space for=
 attrlist");
> > @@ -3129,6 +3145,7 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *ni=
)
> >  remove_attrlist_record:
> >       /* Prevent ntfs_attr_recorm_rm from freeing attribute list. */
> >       ni->attr_list =3D NULL;
> > +     ni->attr_list_size =3D 0;
> >       NInoClearAttrList(ni);
> >       /* Remove $ATTRIBUTE_LIST record. */
> >       ntfs_attr_reinit_search_ctx(ctx);
> > @@ -3182,6 +3199,18 @@ int ntfs_inode_add_attrlist(struct ntfs_inode *n=
i)
> >       return err;
> >  }
> >
> > +int ntfs_inode_add_attrlist(struct ntfs_inode *ni)
> > +{
> > +     struct ntfs_inode *attr_lock_ni;
> > +     int err;
> > +
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> > +     err =3D ntfs_inode_add_attrlist_nolock(ni);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> > +
> > +     return err;
> > +}
> > +
> >  /*
> >   * ntfs_inode_close - close an ntfs inode and free all associated memo=
ry
> >   * @ni:              ntfs inode to close
> > @@ -3325,7 +3354,8 @@ static int ntfs_attr_position(__le32 type, struct=
 ntfs_attr_search_ctx *ctx)
> >   *
> >   * Return 0 on success or error.
> >   */
> > -int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
> > +static int __ntfs_inode_free_space(struct ntfs_inode *ni, int size,
> > +                                enum ntfs_attr_search_ctx_lock_mode lo=
ck_mode)
> >  {
> >       struct ntfs_attr_search_ctx *ctx;
> >       int freed, err;
> > @@ -3349,7 +3379,7 @@ int ntfs_inode_free_space(struct ntfs_inode *ni, =
int size)
> >       if (size <=3D freed)
> >               return 0;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, lock_mode);
> >       if (!ctx) {
> >               ntfs_error(sb, "%s, Failed to get search context", __func=
__);
> >               return -ENOMEM;
> > @@ -3435,6 +3465,23 @@ int ntfs_inode_free_space(struct ntfs_inode *ni,=
 int size)
> >       return err;
> >  }
> >
> > +int ntfs_inode_free_space_nolock(struct ntfs_inode *ni, int size)
> > +{
> > +     return __ntfs_inode_free_space(ni, size, NTFS_ATTR_CTX_LOCK_NONE)=
;
> > +}
> > +
> > +int ntfs_inode_free_space(struct ntfs_inode *ni, int size)
> > +{
> > +     struct ntfs_inode *attr_lock_ni;
> > +     int err;
> > +
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> > +     err =3D __ntfs_inode_free_space(ni, size, NTFS_ATTR_CTX_LOCK_NONE=
);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> > +
> > +     return err;
> > +}
> > +
> >  s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *bu=
f)
> >  {
> >       struct address_space *mapping =3D vi->i_mapping;
> > @@ -3459,10 +3506,11 @@ s64 ntfs_inode_attr_pread(struct inode *vi, s64=
 pos, s64 count, u8 *buf)
> >               count =3D isize - pos;
> >
> >       if (!NInoNonResident(ni)) {
> > +             struct ntfs_inode *base_ni =3D ni->ext.base_ntfs_ino;
> >               struct ntfs_attr_search_ctx *ctx;
> >               u8 *attr;
> >
> > -             ctx =3D ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, N=
ULL);
> > +             ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR=
_CTX_LOCK_READ);
> >               if (!ctx) {
> >                       ntfs_error(vi->i_sb, "Failed to get attr search c=
tx");
> >                       err =3D -ENOMEM;
> > @@ -3650,6 +3698,8 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(=
struct inode *vi,
> >
> >               if (sync) {
> >                       struct ntfs_volume *vol =3D ni->vol;
> > +                     struct ntfs_inode *attr_lock_ni;
> > +                     enum ntfs_attr_search_ctx_lock_mode mode;
> >                       s64 lcn, lcn_count;
> >                       unsigned int lcn_folio_off =3D 0;
> >                       struct bio *bio;
> > @@ -3659,13 +3709,16 @@ static s64 __ntfs_inode_non_resident_attr_pwrit=
e(struct inode *vi,
> >
> >                       lcn_count =3D max_t(s64, 1, ntfs_bytes_to_cluster=
(vol, attr_len));
> >                       vcn =3D ntfs_pidx_to_cluster(vol, folio->index);
> > +                     mode =3D NTFS_ATTR_CTX_LOCK_READ;
> >
> >                       do {
> > +                             attr_lock_ni =3D ntfs_attr_list_lock(ni, =
mode);
> >                               down_write(&ni->runlist.lock);
> >                               rl =3D ntfs_attr_vcn_to_rl(ni, vcn, &lcn)=
;
> >                               if (IS_ERR(rl)) {
> >                                       ret =3D PTR_ERR(rl);
> >                                       up_write(&ni->runlist.lock);
> > +                                     ntfs_attr_list_unlock(attr_lock_n=
i, mode);
> >                                       goto err_unlock_folio;
> >                               }
> >
> > @@ -3677,6 +3730,7 @@ static s64 __ntfs_inode_non_resident_attr_pwrite(=
struct inode *vi,
> >                                       lcn_count =3D 0;
> >                               }
> >                               up_write(&ni->runlist.lock);
> > +                             ntfs_attr_list_unlock(attr_lock_ni, mode)=
;
> >
> >                               if (vol->cluster_size_bits > PAGE_SHIFT) =
{
> >                                       lcn_folio_off =3D folio->index <<=
 PAGE_SHIFT;
> > @@ -3737,7 +3791,7 @@ s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 =
pos, s64 count, u8 *buf, bool s
> >
> >       WARN_ON(!NInoAttr(ni));
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni->ext.base_ntfs_ino, NULL, NTF=
S_ATTR_CTX_LOCK_READ);
> >       if (!ctx) {
> >               ntfs_error(vi->i_sb, "Failed to get attr search ctx");
> >               return -ENOMEM;
> > diff --git a/fs/ntfs/inode.h b/fs/ntfs/inode.h
> > index 67942b97fac6d..43783e77c4f0e 100644
> > --- a/fs/ntfs/inode.h
> > +++ b/fs/ntfs/inode.h
> > @@ -10,6 +10,8 @@
> >  #ifndef _LINUX_NTFS_INODE_H
> >  #define _LINUX_NTFS_INODE_H
> >
> > +#include <linux/rwsem.h>
> > +
> >  #include "debug.h"
> >
> >  enum ntfs_inode_mutex_lock_class {
> > @@ -66,6 +68,7 @@ enum ntfs_inode_mutex_lock_class {
> >   * Attribute list support (only for use by the attribute lookup
> >   * functions). Setup during read_inode for all inodes with attribute
> >   * lists. Only valid if NI_AttrList is set in state.
> > + * @attr_list_lock: Serializes attribute list pointer updates with loo=
kups.
> >   * @attr_list_size: Length of attribute list value in bytes.
> >   * @attr_list: Attribute list value itself.
> >   *
> > @@ -118,6 +121,7 @@ struct ntfs_inode {
> >       int folio_ofs;
> >       s64 mft_lcn[2];
> >       unsigned int mft_lcn_count;
> > +     struct rw_semaphore attr_list_lock;
> >       u32 attr_list_size;
> >       u8 *attr_list;
> >       union {
> > @@ -334,9 +338,12 @@ int ntfs_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
> >
> >  int ntfs_get_block_mft_record(struct ntfs_inode *mft_ni, struct ntfs_i=
node *ni);
> >  int __ntfs_write_inode(struct inode *vi, int sync);
> > +int ntfs_inode_attach_all_extents_nolock(struct ntfs_inode *ni);
> >  int ntfs_inode_attach_all_extents(struct ntfs_inode *ni);
> > +int ntfs_inode_add_attrlist_nolock(struct ntfs_inode *ni);
> >  int ntfs_inode_add_attrlist(struct ntfs_inode *ni);
> >  void ntfs_destroy_ext_inode(struct ntfs_inode *ni);
> > +int ntfs_inode_free_space_nolock(struct ntfs_inode *ni, int size);
> >  int ntfs_inode_free_space(struct ntfs_inode *ni, int size);
> >  s64 ntfs_inode_attr_pread(struct inode *vi, s64 pos, s64 count, u8 *bu=
f);
> >  s64 ntfs_inode_attr_pwrite(struct inode *vi, s64 pos, s64 count, u8 *b=
uf,
> > diff --git a/fs/ntfs/iomap.c b/fs/ntfs/iomap.c
> > index dc7d8c893a699..f2bed2e0c8c8b 100644
> > --- a/fs/ntfs/iomap.c
> > +++ b/fs/ntfs/iomap.c
> > @@ -96,7 +96,7 @@ static int ntfs_read_iomap_begin_resident(struct inod=
e *inode, loff_t offset, lo
> >       else
> >               base_ni =3D ni;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(base_ni, NULL, NTFS_ATTR_CTX_LOC=
K_READ);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto out;
> > @@ -196,6 +196,7 @@ static int ntfs_read_iomap_begin_non_resident(struc=
t inode *inode, loff_t offset
> >               bool need_unwritten)
> >  {
> >       struct ntfs_inode *ni =3D NTFS_I(inode);
> > +     struct ntfs_inode *attr_lock_ni;
> >       s64 vcn;
> >       s64 lcn;
> >       struct runlist_element *rl;
> > @@ -206,20 +207,24 @@ static int ntfs_read_iomap_begin_non_resident(str=
uct inode *inode, loff_t offset
> >       vcn =3D ntfs_bytes_to_cluster(vol, offset);
> >       vcn_ofs =3D ntfs_bytes_to_cluster_off(vol, offset);
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> >       down_write(&ni->runlist.lock);
> >       rl =3D ntfs_attr_vcn_to_rl(ni, vcn, &lcn);
> >       if (IS_ERR(rl)) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >               return PTR_ERR(rl);
> >       }
> >
> >       if (flags & IOMAP_REPORT) {
> >               if (lcn < LCN_HOLE) {
> >                       up_write(&ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_READ);
> >                       return -ENOENT;
> >               }
> >       } else if (lcn < LCN_ENOENT) {
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >               return -EINVAL;
> >       }
> >
> > @@ -247,6 +252,7 @@ static int ntfs_read_iomap_begin_non_resident(struc=
t inode *inode, loff_t offset
> >                               "runlist(vcn : %lld, length : %lld, lcn :=
 %lld) is corrupted\n",
> >                               rl->vcn, rl->length, rl->lcn);
> >               up_write(&ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >               return -EIO;
> >       }
> >
> > @@ -255,6 +261,7 @@ static int ntfs_read_iomap_begin_non_resident(struc=
t inode *inode, loff_t offset
> >       else
> >               iomap->length =3D length;
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> >
> >       if (!(flags & IOMAP_ZERO) &&
> >                       iomap->type =3D=3D IOMAP_MAPPED &&
> > @@ -572,6 +579,7 @@ static int ntfs_write_da_iomap_begin_non_resident(s=
truct inode *inode,
> >  {
> >       struct ntfs_inode *ni =3D NTFS_I(inode);
> >       struct ntfs_volume *vol =3D ni->vol;
> > +     struct ntfs_inode *attr_lock_ni;
> >       loff_t vcn_ofs, rl_length;
> >       s64 vcn, start_lcn, lcn_count;
> >       bool balloc =3D false, update_mp;
> > @@ -584,11 +592,13 @@ static int ntfs_write_da_iomap_begin_non_resident=
(struct inode *inode,
> >
> >       update_mp =3D ntfs_iomap_flags & (NTFS_IOMAP_FLAGS_DIO | NTFS_IOM=
AP_FLAGS_MKWRITE) ||
> >                       NInoAttr(ni) || ni->mft_no < FILE_first_user;
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_WRITE=
);
> >       down_write(&ni->runlist.lock);
> >       err =3D ntfs_attr_map_cluster(ni, vcn, &start_lcn, &lcn_count,
> >                       max_clu_count, &balloc, update_mp,
> >                       ntfs_iomap_flags & NTFS_IOMAP_FLAGS_WRITEBACK);
> >       up_write(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       mutex_unlock(&ni->mrec_lock);
> >       if (err) {
> >               ni->i_dealloc_clusters =3D 0;
> > @@ -661,7 +671,7 @@ static int ntfs_write_iomap_begin_resident(struct i=
node *inode, loff_t offset,
> >       char *kattr;
> >       struct page *ipage;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto out;
> > @@ -785,7 +795,7 @@ static int ntfs_write_iomap_end_resident(struct ino=
de *inode, loff_t pos,
> >       struct page *ipage =3D iomap->private;
> >
> >       mutex_lock(&ni->mrec_lock);
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               written =3D -ENOMEM;
> >               goto err_out;
> > diff --git a/fs/ntfs/mft.c b/fs/ntfs/mft.c
> > index 7d989267a82b9..e2b2e21abb7f5 100644
> > --- a/fs/ntfs/mft.c
> > +++ b/fs/ntfs/mft.c
> > @@ -12,6 +12,7 @@
> >  #include <linux/bio.h>
> >  #include <linux/iomap.h>
> >
> > +#include "attrib.h"
> >  #include "bitmap.h"
> >  #include "lcnalloc.h"
> >  #include "mft.h"
> > @@ -1093,7 +1094,7 @@ static int ntfs_mft_attr_extend(struct ntfs_inode=
 *ni)
> >               base_ni =3D ni;
> >
> >       if (!NInoAttrList(base_ni)) {
> > -             ret =3D ntfs_inode_add_attrlist(base_ni);
> > +             ret =3D ntfs_inode_add_attrlist_nolock(base_ni);
> >               if (ret) {
> >                       pr_err("Can not add attrlist\n");
> >                       goto out;
> > @@ -1103,7 +1104,7 @@ static int ntfs_mft_attr_extend(struct ntfs_inode=
 *ni)
> >               }
> >       }
> >
> > -     ret =3D ntfs_attr_update_mapping_pairs(ni, 0);
> > +     ret =3D ntfs_attr_update_mapping_pairs_nolock(ni, 0);
> >       if (ret)
> >               pr_err("MP update failed\n");
> >
> > @@ -1135,6 +1136,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >       unsigned long flags;
> >       struct folio *folio;
> >       struct ntfs_inode *mft_ni, *mftbmp_ni;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *rl, *rl2 =3D NULL;
> >       struct ntfs_attr_search_ctx *ctx =3D NULL;
> >       struct mft_record *mrec;
> > @@ -1153,6 +1155,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >       ntfs_debug("Extending mft bitmap allocation.");
> >       mft_ni =3D NTFS_I(vol->mft_ino);
> >       mftbmp_ni =3D NTFS_I(vol->mftbmp_ino);
> > +     attr_lock_ni =3D ntfs_attr_list_lock(mftbmp_ni, NTFS_ATTR_CTX_LOC=
K_WRITE);
> >       /*
> >        * Determine the last lcn of the mft bitmap.  The allocated size =
of the
> >        * mft bitmap cannot be zero so we are ok to do this.
> > @@ -1165,6 +1168,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >                       NTFS_B_TO_CLU(vol, ll - 1), NULL);
> >       if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
> >               up_write(&mftbmp_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               ntfs_error(vol->sb,
> >                       "Failed to determine last allocated cluster of mf=
t bitmap attribute.");
> >               if (!IS_ERR(rl))
> > @@ -1186,6 +1190,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >                       ll >> PAGE_SHIFT, NULL);
> >       if (IS_ERR(folio)) {
> >               up_write(&mftbmp_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               ntfs_error(vol->sb, "Failed to read from lcn bitmap.");
> >               return PTR_ERR(folio);
> >       }
> > @@ -1217,6 +1222,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >                               true, false, false);
> >               if (IS_ERR(rl2)) {
> >                       up_write(&mftbmp_ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >                       ntfs_error(vol->sb,
> >                                       "Failed to allocate a cluster for=
 the mft bitmap.");
> >                       return PTR_ERR(rl2);
> > @@ -1224,6 +1230,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >               rl =3D ntfs_runlists_merge(&mftbmp_ni->runlist, rl2, 0, &=
new_rl_count);
> >               if (IS_ERR(rl)) {
> >                       up_write(&mftbmp_ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >                       ntfs_error(vol->sb, "Failed to merge runlists for=
 mft bitmap.");
> >                       if (ntfs_cluster_free_from_rl(vol, rl2)) {
> >                               ntfs_error(vol->sb, "Failed to deallocate=
 allocated cluster.%s",
> > @@ -1251,7 +1258,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >               ret =3D PTR_ERR(mrec);
> >               goto undo_alloc;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK=
_NONE);
> >       if (unlikely(!ctx)) {
> >               ntfs_error(vol->sb, "Failed to get search context.");
> >               ret =3D -ENOMEM;
> > @@ -1343,6 +1350,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >       ntfs_attr_put_search_ctx(ctx);
> >       unmap_mft_record(mft_ni);
> >       up_write(&mftbmp_ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       ntfs_debug("Done.");
> >       return 0;
> >
> > @@ -1359,6 +1367,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >               ntfs_attr_put_search_ctx(ctx);
> >               unmap_mft_record(mft_ni);
> >               up_write(&mftbmp_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               /*
> >                * The only thing that is now wrong is ->allocated_size o=
f the
> >                * base attribute extent which chkdsk should be able to f=
ix.
> > @@ -1402,7 +1411,8 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >                       NVolSetErrors(vol);
> >               }
> >               mark_mft_record_dirty(ctx->ntfs_ino);
> > -     } else if (status.mp_extended && ntfs_attr_update_mapping_pairs(m=
ftbmp_ni, 0)) {
> > +     } else if (status.mp_extended &&
> > +                ntfs_attr_update_mapping_pairs_nolock(mftbmp_ni, 0)) {
> >               ntfs_error(vol->sb, "Failed to restore mapping pairs.%s",=
 es);
> >               NVolSetErrors(vol);
> >       }
> > @@ -1411,6 +1421,7 @@ static int ntfs_mft_bitmap_extend_allocation_nolo=
ck(struct ntfs_volume *vol)
> >       if (!IS_ERR(mrec))
> >               unmap_mft_record(mft_ni);
> >       up_write(&mftbmp_ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       return ret;
> >  }
> >
> > @@ -1449,7 +1460,7 @@ static int ntfs_mft_bitmap_extend_initialized_nol=
ock(struct ntfs_volume *vol)
> >               ntfs_error(vol->sb, "Failed to map mft record.");
> >               return PTR_ERR(mrec);
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK=
_READ);
> >       if (unlikely(!ctx)) {
> >               ntfs_error(vol->sb, "Failed to get search context.");
> >               ret =3D -ENOMEM;
> > @@ -1501,7 +1512,7 @@ static int ntfs_mft_bitmap_extend_initialized_nol=
ock(struct ntfs_volume *vol)
> >               NVolSetErrors(vol);
> >               return ret;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK=
_READ);
> >       if (unlikely(!ctx)) {
> >               ntfs_error(vol->sb, "Failed to get search context.%s", es=
);
> >               NVolSetErrors(vol);
> > @@ -1568,6 +1579,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >       s64 min_nr, nr, ll;
> >       unsigned long flags;
> >       struct ntfs_inode *mft_ni;
> > +     struct ntfs_inode *attr_lock_ni;
> >       struct runlist_element *rl, *rl2;
> >       struct ntfs_attr_search_ctx *ctx =3D NULL;
> >       struct mft_record *mrec;
> > @@ -1579,6 +1591,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >
> >       ntfs_debug("Extending mft data allocation.");
> >       mft_ni =3D NTFS_I(vol->mft_ino);
> > +     attr_lock_ni =3D ntfs_attr_list_lock(mft_ni, NTFS_ATTR_CTX_LOCK_W=
RITE);
> >       /*
> >        * Determine the preferred allocation location, i.e. the last lcn=
 of
> >        * the mft data attribute.  The allocated size of the mft data
> > @@ -1592,6 +1605,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >                       NTFS_B_TO_CLU(vol, ll - 1), NULL);
> >       if (IS_ERR(rl) || unlikely(!rl->length || rl->lcn < 0)) {
> >               up_write(&mft_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               ntfs_error(vol->sb,
> >                       "Failed to determine last allocated cluster of mf=
t data attribute.");
> >               if (!IS_ERR(rl))
> > @@ -1622,6 +1636,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >                       ntfs_warning(vol->sb,
> >                               "Cannot allocate mft record because the m=
aximum number of inodes (2^32) has already been reached.");
> >                       up_write(&mft_ni->runlist.lock);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >                       return -ENOSPC;
> >               }
> >       }
> > @@ -1646,6 +1661,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >                       ntfs_error(vol->sb,
> >                               "Failed to allocate the minimal number of=
 clusters (%lli) for the mft data attribute.",
> >                               nr);
> > +                     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX=
_LOCK_WRITE);
> >                       return PTR_ERR(rl2);
> >               }
> >               /*
> > @@ -1661,6 +1677,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >       rl =3D ntfs_runlists_merge(&mft_ni->runlist, rl2, 0, &new_rl_coun=
t);
> >       if (IS_ERR(rl)) {
> >               up_write(&mft_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               ntfs_error(vol->sb, "Failed to merge runlists for mft dat=
a attribute.");
> >               if (ntfs_cluster_free_from_rl(vol, rl2)) {
> >                       ntfs_error(vol->sb,
> > @@ -1686,7 +1703,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >               down_write(&mft_ni->runlist.lock);
> >               goto undo_alloc;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(mft_ni, mrec, NTFS_ATTR_CTX_LOCK=
_NONE);
> >       if (unlikely(!ctx)) {
> >               ntfs_error(vol->sb, "Failed to get search context.");
> >               ret =3D -ENOMEM;
> > @@ -1782,6 +1799,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >       ntfs_attr_put_search_ctx(ctx);
> >       unmap_mft_record(mft_ni);
> >       ntfs_debug("Done.");
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       return 0;
> >  restore_undo_alloc:
> >       ntfs_attr_reinit_search_ctx(ctx);
> > @@ -1795,6 +1813,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >               ntfs_attr_put_search_ctx(ctx);
> >               unmap_mft_record(mft_ni);
> >               up_write(&mft_ni->runlist.lock);
> > +             ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >               /*
> >                * The only thing that is now wrong is ->allocated_size o=
f the
> >                * base attribute extent which chkdsk should be able to f=
ix.
> > @@ -1814,7 +1833,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >               ntfs_error(vol->sb, "Failed to truncate mft data attribut=
e runlist.%s", es);
> >               NVolSetErrors(vol);
> >       }
> > -     if (mp_extended && ntfs_attr_update_mapping_pairs(mft_ni, 0)) {
> > +     if (mp_extended && ntfs_attr_update_mapping_pairs_nolock(mft_ni, =
0)) {
> >               ntfs_error(vol->sb, "Failed to restore mapping pairs.%s",
> >                          es);
> >               NVolSetErrors(vol);
> > @@ -1843,6 +1862,7 @@ static int ntfs_mft_data_extend_allocation_nolock=
(struct ntfs_volume *vol)
> >       }
> >       if (!IS_ERR(mrec))
> >               unmap_mft_record(mft_ni);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_WRITE);
> >       return ret;
> >  }
> >
> > @@ -2326,7 +2346,7 @@ int ntfs_mft_record_alloc(struct ntfs_volume *vol=
, const int mode,
> >               err =3D PTR_ERR(m);
> >               goto undo_data_init;
> >       }
> > -     ctx =3D ntfs_attr_get_search_ctx(mft_ni, m);
> > +     ctx =3D ntfs_attr_get_search_ctx(mft_ni, m, NTFS_ATTR_CTX_LOCK_RE=
AD);
> >       if (unlikely(!ctx)) {
> >               ntfs_error(vol->sb, "Failed to get search context.");
> >               err =3D -ENOMEM;
> > @@ -2671,14 +2691,17 @@ int ntfs_mft_record_free(struct ntfs_volume *vo=
l, struct ntfs_inode *ni)
> >  static s64 lcn_from_index(struct ntfs_volume *vol, struct ntfs_inode *=
ni,
> >               unsigned long index)
> >  {
> > +     struct ntfs_inode *attr_lock_ni;
> >       s64 vcn;
> >       s64 lcn;
> >
> >       vcn =3D ntfs_pidx_to_cluster(vol, index);
> >
> > +     attr_lock_ni =3D ntfs_attr_list_lock(ni, NTFS_ATTR_CTX_LOCK_READ)=
;
> >       down_read(&ni->runlist.lock);
> >       lcn =3D ntfs_attr_vcn_to_lcn_nolock(ni, vcn, false);
> >       up_read(&ni->runlist.lock);
> > +     ntfs_attr_list_unlock(attr_lock_ni, NTFS_ATTR_CTX_LOCK_READ);
> >
> >       return lcn;
> >  }
> > @@ -2788,14 +2811,20 @@ static int ntfs_write_mft_block(struct folio *f=
olio, struct writeback_control *w
> >                               bio =3D NULL;
> >                       }
> >
> > -                     if (vol->cluster_size < folio_size(folio)) {
> > -                             down_write(&ni->runlist.lock);
> > -                             rl =3D ntfs_attr_vcn_to_rl(ni, vcn_off, &=
lcn);
> > -                             up_write(&ni->runlist.lock);
> > -                             if (IS_ERR(rl) || lcn < 0) {
> > -                                     err =3D -EIO;
> > -                                     goto unm_done;
> > -                             }
> > +                             if (vol->cluster_size < folio_size(folio)=
) {
> > +                                     struct ntfs_inode *attr_lock_ni;
> > +                                     enum ntfs_attr_search_ctx_lock_mo=
de mode;
> > +
> > +                                     mode =3D NTFS_ATTR_CTX_LOCK_READ;
> > +                                     attr_lock_ni =3D ntfs_attr_list_l=
ock(ni, mode);
> > +                                     down_write(&ni->runlist.lock);
> > +                                     rl =3D ntfs_attr_vcn_to_rl(ni, vc=
n_off, &lcn);
> > +                                     up_write(&ni->runlist.lock);
> > +                                     ntfs_attr_list_unlock(attr_lock_n=
i, mode);
> > +                                     if (IS_ERR(rl) || lcn < 0) {
> > +                                             err =3D -EIO;
> > +                                             goto unm_done;
> > +                                     }
> >
> >                               if (bio &&
> >                                  (bio_end_sector(bio) >> (vol->cluster_=
size_bits - 9)) !=3D
> > diff --git a/fs/ntfs/namei.c b/fs/ntfs/namei.c
> > index 96c450e62efca..6dd72071eb25c 100644
> > --- a/fs/ntfs/namei.c
> > +++ b/fs/ntfs/namei.c
> > @@ -267,7 +267,7 @@ static struct dentry *ntfs_lookup(struct inode *dir=
_ino, struct dentry *dent,
> >                               ctx =3D NULL;
> >                               goto err_out;
> >                       }
> > -                     ctx =3D ntfs_attr_get_search_ctx(ni, m);
> > +                     ctx =3D ntfs_attr_get_search_ctx(ni, m, NTFS_ATTR=
_CTX_LOCK_READ);
> >                       if (unlikely(!ctx)) {
> >                               err =3D -ENOMEM;
> >                               goto err_out;
> > @@ -856,7 +856,7 @@ static int ntfs_delete(struct ntfs_inode *ni, struc=
t ntfs_inode *dir_ni,
> >        * If filename in DOS or in WIN32 namespace, then remove DOS name=
 first,
> >        * only then remove WIN32 name.
> >        */
> > -     actx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     actx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_WR=
ITE);
> >       if (!actx) {
> >               ntfs_error(sb, "%s, Failed to get search context", __func=
__);
> >               if (need_lock) {
> > @@ -1618,7 +1618,7 @@ static struct dentry *ntfs_get_parent(struct dent=
ry *child_dent)
> >       if (IS_ERR(mrec))
> >               return ERR_CAST(mrec);
> >       /* Find the first file name attribute in the mft record. */
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, mrec);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, mrec, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (unlikely(!ctx)) {
> >               unmap_mft_record(ni);
> >               return ERR_PTR(-ENOMEM);
> > diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
> > index 22dc7865eca79..4b558c058934a 100644
> > --- a/fs/ntfs/super.c
> > +++ b/fs/ntfs/super.c
> > @@ -350,7 +350,7 @@ static int ntfs_write_volume_flags(struct ntfs_volu=
me *vol, const __le16 flags)
> >       if (vol->vol_flags =3D=3D flags)
> >               goto done;
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(ni, NULL, NTFS_ATTR_CTX_LOCK_REA=
D);
> >       if (!ctx) {
> >               err =3D -ENOMEM;
> >               goto put_unm_err_out;
> > @@ -434,7 +434,7 @@ int ntfs_write_volume_label(struct ntfs_volume *vol=
, char *label)
> >       }
> >
> >       mutex_lock(&vol_ni->mrec_lock);
> > -     ctx =3D ntfs_attr_get_search_ctx(vol_ni, NULL);
> > +     ctx =3D ntfs_attr_get_search_ctx(vol_ni, NULL, NTFS_ATTR_CTX_LOCK=
_WRITE);
> >       if (!ctx) {
> >               ret =3D -ENOMEM;
> >               goto  out;
> > @@ -1492,7 +1492,7 @@ static bool load_system_files(struct ntfs_volume =
*vol)
> >               goto volume_failed;
> >       }
> >
> > -     ctx =3D ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m);
> > +     ctx =3D ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m, NTFS_AT=
TR_CTX_LOCK_READ);
> >       if (!ctx) {
> >               ntfs_error(sb, "Failed to get attribute search context.")=
;
> >               goto get_ctx_vol_failed;
> > --
> > 2.43.0
>
> --
> Thanks,
> Hyunchul
