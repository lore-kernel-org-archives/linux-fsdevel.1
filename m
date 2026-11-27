Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795755214;
	b=0NXsJVz5fH/xTVbgpkHSxPgACnfiH3iWXMvUW8o84qjLlBhLLrGSltvP3je7YS4orEYH
	 9UX9Pz+cqwTRSdlQVOde/Cyh39oAP/OpTdW+vMPO//W4KzJl2DYJb/jmULz+j5UmZVA2Z
	 GckBtk9yh/jf5zrrs9Io9kcESa5iasFgVptVXeeRrRg4BNi1PXIgRNiymuVo10zp0hGe9
	 pCtvCBKXf9CtmXq3jz4aZuXlSwC975uJ8QTZavklhrEYdYZn6UscmKv0L8OXLsdcKdCcb
	 taOIowyc0s2WrI85+w3qs7mc6Ecg5bY9FiHCWxGSJqFNOvVcMzotPwdQY1nID3xki/g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755214;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RA8MnaFxPbfZtJQ9ShnVPAAbDWkDdQmpX/eQuzR+R54=;
	b=LZ4CEZqe7958hoyDRlVLoQ/qbpxQ9mnP5eOrWJkPWMBmZ/zWWwTDcC4cUzm+IKPySrBv
	 PUmneV3dJACx/36nyDAAyg+c/wnL+eZGZ/dGJxoBTR88Iyqv4oJ6s3bZ4Iry3wzl9ut6c
	 YqM0FPDIwQCvIsPef74PrRM1S2F675AkqgtC/n+A63CXw+Nns7EbwwWgSJmazNk7kIhdb
	 GIL5gPWgZfJmpD0eCnKo4hf7TnJguJ+VSr0OeFIB8A3OnGpSlovrv6ATZ+V6lJP9hOVSz
	 YUoUVuOZDgtyrFyxLSug+VXdao43RH5IdlyiQNApdrn7kgSoCUkWveEp1h7BP5Xf+7A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsOaZ6IO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1B606A31C
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Nov 2026 04:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84B1B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=EsOaZ6IO
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b4fb5d96b3so117876807b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2026 20:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795755212; cv=none;
        d=google.com; s=arc-20260327;
        b=eqOrj3mOJYeUkV6Bp5lkslnrWV3oIz+6RCkK8FQMGZ3B4QVVKRGNHOjiyPrLII5mWS
         lB7iLp9kjnPUhpj2DKNOjkjrb2eQBfCa9k4k5L0TAvYP6tYf9YE2TDJ7XT2N7n+JR5Tj
         OygfThZUe21XaOpXfPrExntMjIX/BkOLSbGztYjLOg/pRQrFxmhPvQDj1us2zYBXnblW
         3LoF3jIPiYgwFozZRl3/pTQ5zA/DpgDFgAkpmtgNJT5X4YuSF7SCaEAQjkaiY2WHmu4B
         a36vbHgrPYw/C7YsVEL5ExqMfjzEAfJseMEIkPUh7V6IgzQmvN3Pt/4WnJwtaM0IlIZ3
         ldHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RA8MnaFxPbfZtJQ9ShnVPAAbDWkDdQmpX/eQuzR+R54=;
        fh=A5pMChv2TnU1h3TA4zMmfWWW02haAGzeBT16xnXz2lw=;
        b=nbHM2LmJirOwQpUZg7naD8bqFtUnPzBt3kuC7U0qc6Eu3+VDFOw27crNTU4lKxfAZN
         EKl5VtelUdsIpHVD+axoichf1eVVN0aioqy0jB3n4lIy1n78so7E9CCpp2wGnyROOij1
         KnylEU1I7KwFN/ngU5BRZf5tG+rnMLRfgNUIEVN14WLPgicPt20rgxSHBk6JaZfZ/wCE
         6gj/Dqs+n8XmazR1WwcithAPdCTR7MhxlpaqJ0s9empDQjNSYRONxKcguZlUhKSU687T
         4N04ZaSmUkkofi96fnW/+T95tuLS4sL4b37qCWtmlFEc45FkSzf7qx8+Rnwm+3WgyNOE
         XUMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755212; x=1796360012; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RA8MnaFxPbfZtJQ9ShnVPAAbDWkDdQmpX/eQuzR+R54=;
        b=EsOaZ6IO94Lbw8aAa/Umr8L80vxsqxAgW6q/+Eo7acG4er7qMMfJatnuReb8h1o047
         VD2kHGC004AA+Czy3giOrODRGanS5ELn7AqFfVi83AzL8KdAom9zcc6BkUtcc0vS4uAK
         hZyUXmtd3oZg+OosUZVsAlIVBigMjoP4q7YcR5646tjT7A2L3qH4stF/U9X3lnrNF004
         KrudvbrTNk6CZwXDk5r6JEbv1SORH9OyWkuorWxCp/UvsbzYiNJHxQLQ8/9IySr1NctQ
         p5cntYZ873O0u5ES0aunuIdDHNBeuiQUtUlRPho7J4FPA5hS9oOrwJpzQtk0BCj0U/G7
         /8Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755212; x=1796360012;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RA8MnaFxPbfZtJQ9ShnVPAAbDWkDdQmpX/eQuzR+R54=;
        b=LCiP1vZTgG1VSpYCUAb3DhXfQemNLxKaarGtONUTjybo/mLCca8s0MCVI0RxOAalNf
         uNiIFTc+60ysyegVnzaoae+dXcndWN83iJRyq2pCvYzV4tKxa/pR4KlWT34CKvsmJ78X
         LieEbAUgsGPNKCre+x7WqRMYEsdjSG9ZYAIBbYup17YS4dgkGJ5Y+zk1hgN9hHUT3Ky1
         PagBxhU5i875kDQymAJ2gFMepZm/eqfwM1tCH0WvCoGYAGgoU+nTfUSfE3+q40GwC+un
         BkE8FBK73aAKcctqkCNiJGQ+MWVvMsITRitC5bcsfEKdejHMV1OK5CfYjGcMVSklkSOX
         c3Pw==
X-Forwarded-Encrypted: i=1; AL+hErHB2xtfFdlfmOcQgQW/DVTtODVmZsd2lPDDiu5aguLvK0tzg+SXBbkBPsAVVbm9QqLgzHFyhqQ+H8BJZGHV@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fsf+MwVFpbfr7LGMl8P3L/31VNArB+kamznbwloRh5jva1PxV
	aPXRF/PRtUZ7N/XVAMhBXGpvh7ROOBbNxMlTLPTjISRbdpdnXhYVF+dXg664rv0ru3B0CIPLPP0
	BV7IO/199hCN5jVZ1fNYMVYPamkSS8+Y=
X-Gm-Gg: AZFdTZf24VmY8SQi51YhpamgWR2HoZypR/rfKculO42i8dyjc1LZoUW9RWq3pbube8B
	Y4XaayVvWvR2Gkmy5/KJI5WFFDeJmnC7O6MgAqxf57jwOvszL5gdzfR9aCzZcWBHzi3AfqcgxRv
	OhesVHCbNeYkAXSRpfoyFRsplvmdvLYUkYhm00BW0bf70DeKJUfuzCZaNayHcTx9SlP2d3NuX2z
	M0tqKnBq1DaHqwckBo5+kxsX28iFT7i/KG+UdvDHp60562PSCvcnduLi035IjP4SS6CTqWudIJt
	ZUrUcsU4OxQM6D8fHRIxG2by3i/rZLDWnLVggAotLnAQ88JmZp0aWyeZH6Af//IFjdp/LZukGb3
	SQoul+ZZDpxUKJBtCxkWkHOR+Z8ofAEVLE2YWNC9V1uwYvIP09vFBDMF2hKWOc0vfzq8nu/GgQL
	nVNOMrbAm2reMy+W64eo30EkJh
X-Received: by 2002:a05:690c:60c1:b0:8b1:8185:6f97 with SMTP id
 00721157ae682-8b518f44761mr83719997b3.28.1795755212245; Thu, 26 Nov 2026
 20:53:32 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
 <20261119005943.37851-1-ozgunkultekin@gmail.com> <20261119005943.37851-3-ozgunkultekin@gmail.com>
 <cc1627ab6fc51312b610c8af19f63c70c3a92ac9.camel@dubeyko.com>
In-Reply-To: <cc1627ab6fc51312b610c8af19f63c70c3a92ac9.camel@dubeyko.com>
From: =?UTF-8?B?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>
Date: Thu, 26 Nov 2026 20:53:19 -0800
X-Gm-Features: Aa3M54qyx8s16dyHBAtYb7nSDe37vFPpxJzfHou0PFrxYDvsqmNKFvrvrF-OTwM
Message-ID: <CAP2AQ-Bto4sAHp7TLmezxRN02Pw4KZ-H7S5gkDFpnU7b4gGV1A@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] hfsplus: pass the key buffer size to hfs_bnode_read_key()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, yangguikun19@qq.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Thanks for the review. v4 follows; point by point:

- Order: the fixes are now 1/3 (hfsplus) and 2/3 (hfs) with Cc:
stable, and the HFS_BNODE_DESC_SIZE cleanup is 3/3 without it. The
"next two patches" wording is gone.
- "+ 4": it is not double counting. The header's max_key_len does not
include key_len. hfs_btree_open() requires HFSPLUS_*_KEYLEN -
sizeof(u16) (fs/hfsplus/btree.c:318/331/350), and hfs_bnode_read_key()
reads the on-disk length + 2. The extents tree has max_key_len 10, but
a full key is 12 bytes. hfs is the same with a u8 length
(HFS_MAX_*_KEYLEN =3D sizeof - sizeof(u8)). The + 2 stays, and the
comment on the constant now says why.
- Name: key_buf_size is now key_capacity.
- Layout: I used your struct, with key_capacity after bnode. pahole
gives 56 bytes before and after in both drivers, with no hole.
Comments are now section headings only, with nothing inside the
declarations.
- extern: kept on the hfs prototype, like its neighbours.
- hfs: the same changes as hfsplus.
- 3/3: added HFS_BNODE_FIRST_REC_OFF for offsets. node_desc_size,
desc_size and sizeof(struct hfs_bnode_desc) are converted too. There
is a local cnid_off, sizeof(cnid) instead of 4, line breaks after "=3D",
and aligned conditions.

1/3 and 2/3 also apply to 6.12.y and 6.6.y except for one context line
in hfs_find_init(), and the fixed-up backports build.

ozgun

On Thu, Nov 19, 2026 at 2:32=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Wed, 2026-11-18 at 16:59 -0800, ozgun kultekin wrote:
> > hfs_bnode_read_key() reads the key length of leaf records (and of all
> > records of variable-key and attributes trees) from disk and only
> > checks
> > it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> > always one of the two key buffers hfs_find_init() allocates, each
> > tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> > fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> > key
> > writes up to 516 bytes from the image into kmalloc-32. The error path
> > clears 518 bytes of the same buffer.
> >
> > hfs_brec_insert() reaches this with a key that was never validated:
> > when the tree root is 0 it reads the key of record 0 of the leaf it
> > inserts into, and after a split it reads the first key of the new
> > node.
> > A read-write mount that extends the catalog, or an append to a file
> > whose extents spill into the extents tree, is enough.
> >
> > Do not let hfs_bnode_read_key() assume the size of the buffer. Store
> > the size of each key buffer in struct hfs_find_data as key_buf_size
> > in
> > hfs_find_init(), allocate the two buffers from it, and pass it to
> > every
> > hfs_bnode_read_key() call. Keys longer than the buffer are rejected
> > as
> > before, and the error path clears only the buffer.
> >
> > The allocation size does not change: max_key_len * 2 + 4 is now
> > written
> > as HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE). Document
> > struct hfs_find_data while adding the field.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> > hfs_bnode_read_key")
> > Reported-by: Guikun Yang <yangguikun19@qq.com>
> > Closes:
> > https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F0=
8@qq.com/
> > Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> > ---
> > v3: key_size renamed to key_buf_size and moved to the "filled by
> > caller"
> >     part of struct hfs_find_data, struct and fields commented, buffer
> >     size written with named constants, as requested by Viacheslav
> > v2:
> > https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.=
com/
> > v1:
> > https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.=
com/
> >
> >  fs/hfsplus/bfind.c      |  5 +++--
> >  fs/hfsplus/bnode.c      |  7 ++++---
> >  fs/hfsplus/brec.c       | 10 ++++++----
> >  fs/hfsplus/hfsplus_fs.h | 28 ++++++++++++++++++++--------
> >  4 files changed, 33 insertions(+), 17 deletions(-)
> >
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index ca9813f58..948bc3086 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -19,11 +19,12 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> >       fd->tree =3D tree;
> >       fd->bnode =3D NULL;
> >       hfs_find_result_init(fd);
> > -     ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
>
> OK. It looks like we try to reserve the space for two hfsplus_btree_key
> (search_key + key) and for two __be16 key_len. Correct? But any key
> struct hfsplus_cat_key, struct hfsplus_ext_key, struct hfsplus_attr_key
> already include __be16 key_len:
>
> struct hfsplus_ext_key {
>         __be16 key_len;
>         u8 fork_type;
>         u8 pad;
>         hfsplus_cnid cnid;
>         __be32 start_block;
> } __packed;
>
> Do we really need to add this 4 or sizeof_field(hfsplus_btree_key,
> key_len)? I assume that tree->max_key_len should include the size of
> key_len. Am I right?
>
> > +     fd->key_buf_size =3D tree->max_key_len + HFSPLUS_KEY_LEN_SIZE;
> > +     ptr =3D kzalloc(HFS_FIND_KEY_BUFS * fd->key_buf_size,
> > GFP_KERNEL);
> >       if (!ptr)
> >               return -ENOMEM;
> >       fd->search_key =3D ptr;
> > -     fd->key =3D ptr + tree->max_key_len + 2;
> > +     fd->key =3D ptr + fd->key_buf_size;
> >       hfs_dbg("cnid %d, caller %ps\n",
> >               tree->cnid, __builtin_return_address(0));
> >       mutex_lock_nested(&tree->tree_lock,
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 3a1a1fa6f..9fd06ce88 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> > off)
> >       return data;
> >  }
> >
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_buf_size)
>
> The key_capacity looks better.
>
> >  {
> >       struct hfs_btree *tree;
> >       u32 key_len;
> > @@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> > void *key, u32 off)
> >       else
> >               key_len =3D tree->max_key_len + 2;
> >
> > -     if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> > -             memset(key, 0, sizeof(hfsplus_btree_key));
> > +     if (key_len > key_buf_size || key_len < 1) {
> > +             memset(key, 0, key_buf_size);
> >               pr_err("hfsplus: Invalid key length: %u\n",
> > key_len);
> >               return;
> >       }
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index 37e058c5d..2a63b06d8 100644
> > --- a/fs/hfsplus/brec.c
> > +++ b/fs/hfsplus/brec.c
> > @@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, u32 entry_len)
> >        * at the start of the node and it is not the new node
> >        */
> >       if (!rec && new_node !=3D node) {
> > -             hfs_bnode_read_key(node, fd->search_key, data_off +
> > size);
> > +             hfs_bnode_read_key(node, fd->search_key, data_off +
> > size,
> > +                                fd->key_buf_size);
> >               hfs_brec_update_parent(fd);
> >       }
> >
> > @@ -167,7 +168,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, u32 entry_len)
> >
> >               /* get index key */
> >               hfs_bnode_read_key(new_node, fd->search_key,
> > -                                HFS_BNODE_DESC_SIZE);
> > +                                HFS_BNODE_DESC_SIZE, fd-
> > >key_buf_size);
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> >
> >               hfs_bnode_put(new_node);
> > @@ -467,7 +468,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >               fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> >               /* create index key and entry */
> >               hfs_bnode_read_key(new_node, fd->search_key,
> > -                                HFS_BNODE_DESC_SIZE);
> > +                                HFS_BNODE_DESC_SIZE, fd-
> > >key_buf_size);
> >               cnid =3D cpu_to_be32(new_node->this);
> >
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> > @@ -480,7 +481,8 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >                               goto out;
> >                       /* restore search_key */
> >                       hfs_bnode_read_key(node, fd->search_key,
> > -                                        HFS_BNODE_DESC_SIZE);
> > +                                        HFS_BNODE_DESC_SIZE,
> > +                                        fd->key_buf_size);
> >               }
> >               new_node =3D NULL;
> >       }
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index dd88053cc..f19787eba 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -257,17 +257,28 @@ static inline void
> > hfsplus_mark_inode_dirty(struct inode *inode,
> >       mark_inode_dirty(inode);
> >  }
> >
> > +/* hfs_find_init() allocates search_key and key as one buffer */
> > +#define HFS_FIND_KEY_BUFS    2
> > +
> > +/* Size of the key_len field at the start of every key */
> > +#define HFSPLUS_KEY_LEN_SIZE sizeof_field(hfsplus_btree_key,
> > key_len)
> > +
> > +/*
> > + * State of one b-tree search. hfs_find_init() sets up the key
> > buffers
> > + * and the tree, the search functions fill in the rest.
> > + */
>
> I expected to have comments here but not inside the structure
> declarations.
>
> >  struct hfs_find_data {
> >       /* filled by caller */
> > -     hfsplus_btree_key *search_key;
> > -     hfsplus_btree_key *key;
> > +     hfsplus_btree_key *search_key;  /* key to search for */
> > +     hfsplus_btree_key *key;         /* key of the found
> > record */
> > +     u32 key_buf_size;               /* size of each of
> > search_key and key */
>
> I think key_capacity could be better name, finally.
>
> I spent some time for analysis. I think my request to put it here was
> not good suggestion. Putting u32 key_buf_size after the two pointers
> leaves a 4-byte hole, and pahole shows struct hfs_find_data growing
> from 56 to 64 bytes. Also, "filled by caller" heading was already wrong
> (hfs_find_init() fills these fields, and tree too).
>
> >       /* filled by find */
> > -     struct hfs_btree *tree;
> > -     struct hfs_bnode *bnode;
> > +     struct hfs_btree *tree;         /* tree being
> > searched */
> > +     struct hfs_bnode *bnode;        /* node with the found
> > record */
> >       /* filled by findrec */
> > -     int record;
> > -     int keyoffset, keylength;
> > -     int entryoffset, entrylength;
> > +     int record;                     /* index of the record in
> > bnode */
> > +     int keyoffset, keylength;       /* offset and length of its
> > key */
> > +     int entryoffset, entrylength;   /* offset and length of its
> > data */
> >  };
>
> I am thinking about this:
>
> struct hfs_find_data {
>         /* set by hfs_find_init() */
>         hfsplus_btree_key *search_key;
>         hfsplus_btree_key *key;
>         struct hfs_btree *tree;
>         /* filled by find */
>         struct hfs_bnode *bnode;
>         /* set by hfs_find_init() */
>         u32 key_capacity;
>         /* filled by findrec, reset by hfs_find_result_init() */
>         int record;
>         int keyoffset, keylength;
>         int entryoffset, entrylength;
> };
>
> Thanks,
> Slava.
>
> >
> >  struct hfsplus_readdir_data {
> > @@ -372,7 +383,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
> >  void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> >  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_buf_size);
> >  void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
> >  void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
