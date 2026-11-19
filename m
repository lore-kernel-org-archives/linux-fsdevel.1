Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795049894;
	b=PmzFZu6IP8WnAhZyeiY8Vg/cwZUSy07xDUzS4Ob8ZCzHIBq7z5uxdxYUQX5dn1X/w0Va
	 tlyJ6OCNZlFTilX8fOJiUeQ2W5jSuNGVV8jWeKsRdIa68IMEj7iBptF584+fvADdYXSvo
	 WSbGeIcc0jI12HWEweGeq1niPos1JEmXUhRCADzpgWBRsxRUBxjkzofM38oYySuWnKEmw
	 9/jSMymqGNNygMNXdTV87IqzZesI1sYyQOpSNwmogS9+TLkN7rJrDe7lrWJHT4GYcWJbh
	 Nm8GBG13JntbW+zcb1SdKDJdxR6amHTOcjXlElnTNyGwGy1FBunVcCugCRUe8y976AA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
	b=lWJ7Wz5/YkNojt/29mjGa+mI24/yiuzkKj9wiDlyfzb3F2XgfLsIALyBHywTV92oH0en
	 qtcWPZjennB6A3n2hb7Z30/RBn1LeL70KIWLMcBfX7si2E7jHWI4L/Bb4Cg7L/YONEMY/
	 XFzNIb/ZR8565YjH0fMG9lygYXxqtRiM+IU9+CkwZCuGZUhkIelW6kOzwCHtj0sgRkNuJ
	 81wNaovfBCay3wUMdQeh+4g1wDJJs+nm10QLZvBiHMFp+9MMaLMEbzKxSPpONLCRmXPdf
	 VE21BfV2A2kNk2Y8avE4eoQRuzny1Mk6rSN5B93J1SAI0ltheV5apd0e5uCjqf+KheQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcsnJPEA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.175
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D48606A31C
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 00:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D48606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KcsnJPEA
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8b4d86f5328so11873577b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Nov 2026 16:58:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795049892; cv=none;
        d=google.com; s=arc-20260327;
        b=RZaVW1hK+n+Q39gnCnlgLjfdqMPMROHKnG7Hofrj3QOt4Yu9CwItsJC/bdrMTKaBmR
         7Ra8O18Owup463dWHeY64Cbpjvrb2zvtvNbh6TOWPpYSu57XnApGVkXtfX06YhAfimE1
         yd1nPWuNPLySYK0Y5YvSn4QAmbYrsVG1RM+6pqAle+fRzFkrHUBp+nTUSacC6EQKDbSS
         Y1JugA91aU0+YBRJRBWP9qP0Za5SWdSvTOZdcUv90Pvqr86/ekRVGoPWnSAXyItcliI0
         9CjO2Z/0/XY1+2PRrhgIENoeo6EmqQLUxM14Wa+Qy9c59cnEhK6VzVXykpHTOSPHrrG0
         2oCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        fh=9wxOmRd46/1fRl3Zcoa+gqcaOZKHmA9VBPQvV25lqRA=;
        b=BubBXMPKp2O11CSPnUfNLlBvFXuzYdY1Kj6y4Cp47XoXR67sbX3EFQdpHchORenpYJ
         yiMALUpHhgQrZnkCcacRnteeb68045BOTrNhJICdFz1wk3xbzjmAIC46YVItZF5DatMG
         NAp53VIbvGix/9e5y1P8YjGsNdarRPYDk56Zrh1bkeiox+61vN4b/JtEAQCRqAhXLGbc
         VicztzaCQ9DzeGtj9/3tNdcmm0XpBA4cyUp6cPiLYSRS9JGOjJbiyiWfodtW/bSOhbET
         GQNjJFqYMxDUJ2h4RDy+U6iupVW3wRAhJm57fUhTqY00QKroz/S4242JaVvbEyPziOBg
         XwTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049892; x=1795654692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        b=KcsnJPEAq4go0fmvz1i2YFD7EdXnvLZs3Gb/1vywvS95lmVbCMBJeaNnm23XHvkM8G
         p5HHhaWJacOW2zrzmKqBnYU8DGh+chANp4g1piXPuqtzUQTRCLpjxBrwCOO9AdfHNlPy
         AVdfsWg5xNSTsrb70vA/s17IuWKHEFtq22/i8wuOf3l4J8tnKzKqKQ00vOtiQw+eA5QE
         Afz/VHekdtH+52CXU1o+yOx06JPDFogeofVi2cSfBCtA1kXMtRFijQJg6kLVYKsgBtqu
         y0m74xZIZ6Fl3pfprCgCr6ej8kDHpS89MZUnR/i9Jv7iNu3zfcHvXYlYT2/Z7kO9kSMt
         cbrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049892; x=1795654692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3m4JP2toyOf5wM/Gm/lOr8X0+HToBEJENBBYIRuWj6A=;
        b=kuEYRTbN07d8t6WRUcUDNqN4wGQ8CMR7W3Zcxfx8oKeP6ae6IVip+GP8mUE6hxSvcA
         EY/4K+AQfA2ieqbmqTypvXGC3R430VWp4UJl5yfEsdDbS83Io53UfyagklRQohMG5kdN
         eFs9b/YTgX91L3sNzoLwjq9gbVQTY03vcYST4gB63kJfWmxy9ycrphuCIb04ZEBXVDy2
         YcNvjjdlxhAYfkG+Jt14JiyNgL13ItwY367Frf9nkoAkT5pFc6kxcmaupnhYzkJly6XJ
         X8/yAt10k9gBe8271zLk/cf75TREjNEnL8oXDEWt46jkuu7ObdUHh6qQz4ciFvxQV51Y
         Ne0w==
X-Forwarded-Encrypted: i=1; AL+hErGug2quVCIZovAuRPIv7iDvEKXtnylJinsRE/2+HsMBpkLWO9XFmUpaZC84nGDBaF012rISCQMoIGk3qmk1@vger.kernel.org
X-Gm-Message-State: APuU4Z82z3JP/xYaAtJB/GDWSE4GqVsGNedOJ+SU4pdifv/wVJVdubCk
	m2FA+qOtn0zcGYr3xlG42FmMZs2o27E2H52KG0CjDuBcgNLh9yYLRspmY8lZfwy7Z5ksEYfXEBL
	/Vz/XWSgIvb8baIhrRm+7T+93UpcX/b4=
X-Gm-Gg: AZFdTZf6EmUWnPhQlOb+nQSgdM9PQUYj8Ltb+qsBOj3zMlV08yUHkU+4NF6UF1lgCD/
	W7n8SaZ9Bu5DoNpsrPu6TmpBGTuQdRXDq2qemagVbTzPuK7gY3CHIwHK7QNMvwKWKyxhff/U/xl
	5yrTid8mEoYznMakjq/jKabSB+w/W8+ZbHtOH4Xd7rYbB+w37uEf1YoLgM6Me04UyCEHmMnDf+l
	s84tOyu9Sa6/tlJHP5C/lTaQyAAPnPZ93Le3M1WoY5ott9QP2eNnl7/ryOi1KNXOcJothb5GyIB
	H+Xn7KUn09yDkNhciajB/eAFsMxoWycI+HSAez534mNIBw5hZmazGbsFmeZTgWm1JseyPm5j6Mt
	8kuC5MoHLUKKd8A/t8Pzc5FaoDDosh7w+DGoa65WCbR1BunbOHxo6Vvak1aUnzbYwYO10/a6EmB
	t8DVCevyq4aw+i/7jT0+5/yz9C
X-Received: by 2002:a05:690c:6ac1:b0:8b4:fd7b:be17 with SMTP id
 00721157ae682-8b4fed36c83mr18132497b3.27.1795049892653; Wed, 18 Nov 2026
 16:58:12 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
 <20261118013725.90985-1-ozgunkultekin@gmail.com> <20261118013725.90985-2-ozgunkultekin@gmail.com>
 <906a3c99edd0b9216fecf4994c96a5fed9ca5253.camel@dubeyko.com>
In-Reply-To: <906a3c99edd0b9216fecf4994c96a5fed9ca5253.camel@dubeyko.com>
From: =?UTF-8?B?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>
Date: Wed, 18 Nov 2026 16:58:01 -0800
X-Gm-Features: Aa3M54rfcnLyrJUJ6VbyPAushlyD4haK0Inbg6Dr4Kkg8V4cKKwQVp2gUxaqK6c
Message-ID: <CAP2AQ-CwxT1HHDCS9ZmtD=8Wuq0DXmUK_uDu+WG3ZwpE1ufHkw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] hfsplus: pass the key buffer size to hfs_bnode_read_key()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, yangguikun19@qq.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Yes, 2 * (max_key_len + 2) is the same as max_key_len * 2 + 4, so the
allocation size did not change. v3 writes it with named constants and
addresses all your other points too, including a separate patch that
replaces the 14 with HFS_BNODE_DESC_SIZE.

ozgun

On Wed, Nov 18, 2026 at 11:06=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.=
com> wrote:
>
> On Tue, 2026-11-17 at 17:37 -0800, ozgun kultekin wrote:
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
> > Do not let hfs_bnode_read_key() assume the size of the buffer. Record
> > the size of each key buffer in struct hfs_find_data in
> > hfs_find_init(),
> > allocate the two buffers from it, and pass it to every
> > hfs_bnode_read_key() call. Keys longer than the buffer are rejected
> > as
> > before, and the error path clears only the buffer.
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
> > v2: pass the key buffer size to hfs_bnode_read_key() and keep it in
> >     hfs_find_data, as suggested by Viacheslav
> > v1:
> > https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.=
com/
> >
> >  fs/hfsplus/bfind.c      | 6 ++++--
> >  fs/hfsplus/bnode.c      | 7 ++++---
> >  fs/hfsplus/brec.c       | 9 +++++----
> >  fs/hfsplus/hfsplus_fs.h | 5 ++++-
> >  4 files changed, 17 insertions(+), 10 deletions(-)
> >
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index ca9813f58..5ec72fc98 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -19,11 +19,13 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> >       fd->tree =3D tree;
> >       fd->bnode =3D NULL;
> >       hfs_find_result_init(fd);
> > -     ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > +     /* search_key and key, each holding one key of the largest
> > size */
> > +     fd->key_size =3D tree->max_key_len + 2;
>
> Do you mean + 4?
>
> > +     ptr =3D kzalloc(2 * fd->key_size, GFP_KERNEL);
>
> This is why I would like to exchange this tree->max_key_len * 2 + 4 on
> the statement that includes named constants instead of hardcoded 2 and
> 4. Please, rework it.
>
> >       if (!ptr)
> >               return -ENOMEM;
> >       fd->search_key =3D ptr;
> > -     fd->key =3D ptr + tree->max_key_len + 2;
> > +     fd->key =3D ptr + fd->key_size;
> >       hfs_dbg("cnid %d, caller %ps\n",
> >               tree->cnid, __builtin_return_address(0));
> >       mutex_lock_nested(&tree->tree_lock,
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 3a1a1fa6f..e2335c6d7 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32
> > off)
> >       return data;
> >  }
> >
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_size)
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
> > +     if (key_len > key_size || key_len < 1) {
> > +             memset(key, 0, key_size);
> >               pr_err("hfsplus: Invalid key length: %u\n",
> > key_len);
> >               return;
> >       }
> > diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
> > index f416e562d..779d7df0b 100644
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
> > +                                fd->key_size);
> >               hfs_brec_update_parent(fd);
> >       }
> >
> > @@ -166,7 +167,7 @@ int hfs_brec_insert(struct hfs_find_data *fd,
> > void *entry, u32 entry_len)
> >               entry_len =3D sizeof(cnid);
> >
> >               /* get index key */
> > -             hfs_bnode_read_key(new_node, fd->search_key, 14);
> > +             hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> > >key_size);
>
> We need finally rework this 14 on named constant.
>
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> >
> >               hfs_bnode_put(new_node);
> > @@ -464,7 +465,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >               }
> >               fd->bnode =3D hfs_bnode_find(tree, new_node->parent);
> >               /* create index key and entry */
> > -             hfs_bnode_read_key(new_node, fd->search_key, 14);
> > +             hfs_bnode_read_key(new_node, fd->search_key, 14, fd-
> > >key_size);
>
> Ditto.
>
> >               cnid =3D cpu_to_be32(new_node->this);
> >
> >               __hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
> > @@ -476,7 +477,7 @@ static int hfs_brec_update_parent(struct
> > hfs_find_data *fd)
> >                       if (new_node =3D=3D node)
> >                               goto out;
> >                       /* restore search_key */
> > -                     hfs_bnode_read_key(node, fd->search_key,
> > 14);
> > +                     hfs_bnode_read_key(node, fd->search_key, 14,
> > fd->key_size);
>
> Ditto.
>
> >               }
> >               new_node =3D NULL;
> >       }
> > diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> > index 6f240f87f..d0d4fea94 100644
> > --- a/fs/hfsplus/hfsplus_fs.h
> > +++ b/fs/hfsplus/hfsplus_fs.h
> > @@ -268,6 +268,8 @@ struct hfs_find_data {
> >       int record;
> >       int keyoffset, keylength;
> >       int entryoffset, entrylength;
> > +     /* size of each of the search_key and key buffers */
>
> We need to have a comment before structure declaration. Ideally, it
> will be good to comment every field.
>
> > +     u32 key_size;
>
> This is not proper place for this declaration.
>
> struct hfs_find_data {
>         /* filled by caller */
>         hfsplus_btree_key *search_key;
>         hfsplus_btree_key *key;
>         /* filled by find */
>         struct hfs_btree *tree;
>         struct hfs_bnode *bnode;
>         /* filled by findrec */
>         int record;
>         int keyoffset, keylength;
>         int entryoffset, entrylength;
> };
>
> This is the field is prepared by caller. So, it should be group in the
> first section.
>
> From my point of view, keylength and key_size are not semantically
> different. Could we suggest some better word here?
>
> Thanks,
> Slava.
>
> >  };
> >
> >  struct hfsplus_readdir_data {
> > @@ -372,7 +374,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
> >  void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
> >  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
> > -void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
> > +void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
> > +                     u32 key_size);
> >  void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32
> > len);
> >  void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
> >  void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
