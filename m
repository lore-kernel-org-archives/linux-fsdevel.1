Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9F7411A0C
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Aug 2026 14:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786200651; cv=pass; b=CvqTr2sduBk1OkX0eROtX45ctydpcki1jD0n8Uk51uWSMQRGo3T3zrbzDZCORpkXRip2WMsfcw6U3PPfAIdTu5lOZuipyq5c5WSgVjFuCb/Kyd/rYvNHHyq7M1QJzgJwMAnHOEdVqMiZpfSLPJaF8PhZWQrvXAddcRrIknBZNmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786200651; c=relaxed/simple;
	bh=ZJ0Suxe4+FK3oVnvK3Qsy+C/3gr/ev7I+Isg4jpK/DM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JALm8HwpBgq/EY6ih3nIBXgyYm9XnF1RD0S1wL+KRTAgsG9U4aotoWXsa7f2Jc+v8jfm2PrKQO8sFLnk1zm4yjRAQhSY5Z2UZndig91MwufdrXqt60Kyf/xd7x6tLxoZvQbO5CMNtKT8hb2nwOg5+PFfeQ0nRN9WUBcozquqf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQJhcANU; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQJhcANU"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso490540a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Aug 2026 07:50:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786200648; cv=none;
        d=google.com; s=arc-20260327;
        b=WWJ22Fmb6aRotFh13Y/nOqZlTwATu/7tvnkbq4Ag0zqlie5UrYv6ASCmOrdjJgRuuR
         qkr3XHB7URC4hyzh1m/0xs7A+p4W2xGrXQYJ1SnG/mWNE+1y6D5YpRM3rY9DC1qxlvWU
         3afP9fIoOFLUOsKbGiJjhIUxDGbvXe2Rvwum6qKl8xb1zHfpwNBul9APcjhRjJDBFBHA
         6nO0Sxioc6rguFzlsmvGzkJVnlPfvD8sq/2mbMnu8XHeuBdqP/AOsnqQGUTC69C7gIV0
         PphOp395Cwejwg5gxFq6To4LbbKRe9LmxkUvnxikHJ2KT+hjOqWIm8WYpIk4oQ9MtLH7
         k/2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pmlKRIQoOZraYIlUPtwbKcO/dm2SSA3YL5tpWx1FcEY=;
        fh=TV+tCmGmBnsRK/WlAn/qO8sQnKAxgQsVPUoCsSlVM4E=;
        b=oQgmIuG3XSZubcgqSFxQ/FHSlC7t3CRsylmlVRvirgCGkeX1jgdvYv6sOcHahclFI2
         w0XUy/Pkm5tZWJuDS+ZE0f72XzNI2UudSfdyk+nSJkZF/2r0B/WBY9yCcjjopCKH9YKu
         hjkftAZc/R5Xo1b2xyzczV5dhUu7MPyxAb7YAqbm73olFn7StNoU1YlssdOKydlVGRWT
         wuRg5CZ7ypw1XVOqg2ydwq+xlGTXV0uNUF16VogPOE/ovQrgwQjFYFNea2DAV4qqK6ba
         2pFM4g5NX7lAbH4LZQBB9oiCbFEG760oGF5+NJ+PIwaHDFwB12lLQGdmnA7aqWF3flV4
         aXQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786200648; x=1786805448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pmlKRIQoOZraYIlUPtwbKcO/dm2SSA3YL5tpWx1FcEY=;
        b=XQJhcANUnVq+w8p/4ViHngnMLuV63jQAfbcaE/tEWhgufnScZsVpt3NYWYL4W71w6y
         wCSi14Mc32p04LssR61rKFkF/a1vxA/sRGyfv7+2q1oJ+hVtf6uHpHwkvBRavHU6iNCQ
         l80/t5Mk1tSpePva+DMID2RM8ZsV6yo5PEZFP9o8V6+E1PQlLimpEaPXbN+w+LCimrjh
         ounBrJM8xvGUmyUZFUc3GatSLfB6BBXPvX1IN9UjsDUebonI7uO4Q/GyCNK6Vpa+bc0/
         oqe2wcUygKI5JcTevSRvUM27SVjncWFb+wri089sTkkGu1pg6eq+ZXrIqyzYbvgYtWNu
         LlSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786200648; x=1786805448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmlKRIQoOZraYIlUPtwbKcO/dm2SSA3YL5tpWx1FcEY=;
        b=V4/YTfRlw/FDsKq10HhBjGo7cSU6mQ+cI0ijCJsPCvU8LjWTWdXzkpQ7dkUMqzqajV
         oFVqjCX7RZWBSblFGc2DbLjdwca45tn2w7hGNFE9IxwBGxts0jdk9CO4f+xLnYju1WZl
         uKoSZnXoadnHA3dlJ74S40q8zKt3mtXly/kLkQIMLnno48vswRkgA/huOhLI3P7gKd7m
         xL/Fb4Kipyy6dIyZteJ8l7h7cga1bzDJAT3dUAkw0c9ekXcF2ofSipjdduN1++Ht8NlO
         D85AU2SaO2IwzyprTEsLk7ZzImfIEeoOgzEixhCvOcrwPTNPb3qbGNkkCFv9OlNHspr+
         U9zw==
X-Forwarded-Encrypted: i=1; AHgh+RoLXjgdidMwc8Dp27KGzATSiVN9v6Btt1yOYAkZZGcxz152ZsSUWwBSrZ8f2EsfhyKf9E9NxUaaX0XAGGSe@vger.kernel.org
X-Gm-Message-State: AOJu0YxKG47dkE8n6G/myRDMP8mp4X6uw1lkKdR96IbKJxLjwE9/J4ys
	ZQXZRuuaB7AtMWBI1/nvdriwcwqL59yCFFpe3AC3Xyrsx0eb1PdkdjRB5+k9pLFYMq9Op8sD/1c
	348Bc7U7YWhA33B4YD3rxeZtIkjveu14=
X-Gm-Gg: AR+sD12JfKG3ObBmbrIR90wUj6qUC0s5ai5w6ozh/2p5Nws2ENWvq6weXhSihEKMThN
	15+9zbnBYfc/wFHTFPgYbPectX/yjNURF9ps0KoLjcUIUwyzOBsq2TXP00JawZnYzuDIAyDQ9/3
	NhIhQQ5Tf/A7jQ0il01WyMO3R0+3wmyxXF9bhbeG2FPVTCnIvl0kjMuOezG322Yg1H3qVOriViQ
	T6npmaTceEoyiI4j+n3c6bJd7UWHk1ZGdJonk5uaWYEaW8Cdk0lxFhB2vmX0CO9KY7qqmtTz+45
	+TJyuzZpXc6quPnTSjpSTr7Rm0vMj/EvaFYh13vnGQsQFw==
X-Received: by 2002:a17:907:72d5:b0:c16:16b9:98fa with SMTP id
 a640c23a62f3a-c2039afa743mr1385647566b.5.1786200647694; Sat, 08 Aug 2026
 07:50:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee23d8f65b44586d6b630bec295fd581a6be1160.camel@dubeyko.com>
 <20260806073358.1184938-1-r772577952@gmail.com> <cbd7003314c530d4f910eacf019ff80adad6687e.camel@dubeyko.com>
In-Reply-To: <cbd7003314c530d4f910eacf019ff80adad6687e.camel@dubeyko.com>
From: Jiaming Zhang <r772577952@gmail.com>
Date: Sat, 8 Aug 2026 22:50:10 +0800
X-Gm-Features: AUfX_mxvm0EHS9bxxNiX4c_p546k5V4nPtS9aeltIBsNrtHH33YKIr4iCnLwc4k
Message-ID: <CANypQFZ-kejru9P3D7rvCzDp5hP-xqM9okq7LpiHEobbU=oQpw@mail.gmail.com>
Subject: Re: [PATCH v6] hfsplus: validate B-tree record offset table
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: frank.li@vivo.com, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, vdubeyko@coreweave.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Viacheslav Dubeyko <slava@dubeyko.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=888=E6=
=97=A5=E5=91=A8=E5=85=AD 08:49=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, 2026-08-06 at 15:33 +0800, Jiaming Zhang wrote:
> > A crafted HFS+ image can contain a corrupted B-tree node. The node
> > descriptor may contain a record count that does not fit in the node,
> > and
> > record offsets may be unordered, unaligned, outside the node, or
> > point into
> > the offset table itself.
> >
> > Several B-tree helpers consume these on-disk fields before validating
> > them:
> > hfs_bnode_dump() can walk past the offset table when num_recs is
> > corrupted,
> > hfs_brec_lenoff() can produce an underflowed length or a record range
> > that
> > overlaps the offset table. This can make the unlink/writeback path
> > repeatedly call hfs_bnode_read_u16() with invalid offsets while
> > holding the
> > HFS+ B-tree lock, producing a flood of "requested invalid offset"
> > messages.
> > Other writeback workers then block on tree->tree_lock and the system
> > reports tasks hung in hfsplus_write_inode().
> >
> > Validate num_recs against the node size before walking the record
> > offset
> > table. Reject record ranges that are unordered, unaligned, outside
> > the
> > node, or overlapping the offset table. Reject invalid record indexes
> > before
> > reading their offset entries, and avoid decrementing an already-zero
> > leaf_count.
> >
> > Closes:
> > https://lore.kernel.org/lkml/CANypQFb_2TqKGrztAXj5m0_v+QChxXDnQVeifzV8J=
25Vuju10Q@mail.gmail.com/
> > Assisted-by: Codex:gpt-5.5-xhigh
> > Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
> > ---
> > Changes in v6:
> > - hfs_bmap_free(): Drop offset checks and print error message when B-
> > tree
> >   map record length is invalid.
> >
> > Changes in v5:
> > - Switch helpers to invalid checker and invert callers.
> > - hfs_brec_offsets_invalid(): Drop the redundant offset-table
> > argument
> >   since it is already covered by the offset-table overlap check and
> > take
> >   just the two neighboring record offsets (off and next_off).
> > - hfs_brec_len_invalid(): reject a length against node_size.
> > - Use hfs_brec_len_invalid() for both length checks in
> > hfs_bmap_get_map_page().
> > - Validate the record offset in hfs_bmap_free().
> > - Check the __hfs_brec_find() return code in [2] and [3]. [1] and [4]
> > call
> >   it to find the insertion slot for a new index key after a split, -
> > ENOENT is
> >   one of expected, even -EINVAL the following hfs_brec_insert() just
> > inserts
> >   at slot 0 of a node already validated by hfs_bnode_find(), so it
> > stays
> >   in-bounds and cannot trigger the invalid-offset flood. Hence no
> > check was
> >   added.
> >
> > [1]
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L160
> > [2]
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L208
> > [3]
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L382
> > [4]
> > https://elixir.bootlin.com/linux/v7.2-rc3/source/fs/hfsplus/brec.c#L449
> >
> > Changes in v4:
> > - Rename hfs_find_reset() to hfs_find_result_init().
> > - Reset find result fields in __hfs_brec_find().
> > - Move num_recs validation next to descriptor field initialization.
> > - Rename hfs_brec_range_valid() to hfs_brec_offpair_valid().
> > - Use U16_MAX for invalid offset/len/keylen sentinels and update
> > callers.
> > - Add hfs_brec_len_valid() to check validity of len/keylen.
> > - Handle invalid B-tree map record lengths in hfs_bmap_get_map_page()
> >   and hfs_bmap_free().
> > - Return -EINVAL instead of -EIO for invalid remove cursor/leaf_count
> > state.
> >
> > Changes in v3:
> > - Drop the keylen =3D=3D len check.
> > - Drop the explicit zero-record check in __hfs_brec_find().
> > - Move find cursor reset into hfs_find_reset() and call it from
> > hfs_find_init() and hfs_brec_find().
> > - Rename helper-local variables as suggested.
> >
> >  fs/hfsplus/bfind.c      | 23 ++++++------
> >  fs/hfsplus/bnode.c      | 16 ++++++---
> >  fs/hfsplus/brec.c       | 53 ++++++++++++++++++---------
> >  fs/hfsplus/btree.c      | 16 +++++++--
> >  fs/hfsplus/hfsplus_fs.h | 79
> > +++++++++++++++++++++++++++++++++++++++++
> >  5 files changed, 155 insertions(+), 32 deletions(-)
> >
> > diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> > index 9a55fa6d5294..ca9813f58a6d 100644
> > --- a/fs/hfsplus/bfind.c
> > +++ b/fs/hfsplus/bfind.c
> > @@ -18,6 +18,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> >
> >       fd->tree =3D tree;
> >       fd->bnode =3D NULL;
> > +     hfs_find_result_init(fd);
> >       ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> >       if (!ptr)
> >               return -ENOMEM;
> > @@ -106,17 +107,21 @@ int __hfs_brec_find(struct hfs_bnode *bnode,
> > struct hfs_find_data *fd,
> >       u16 off, len, keylen;
> >       int rec;
> >       int b, e;
> > -     int res;
> > +     int res =3D -ENOENT;
> >
> >       BUG_ON(!rec_found);
> > +     hfs_find_result_init(fd);
> > +     if (hfs_bnode_num_recs_invalid(bnode))
> > +             goto fail;
> > +
> >       b =3D 0;
> >       e =3D bnode->num_recs - 1;
> > -     res =3D -ENOENT;
> >       do {
> >               rec =3D (e + b) / 2;
> >               len =3D hfs_brec_lenoff(bnode, rec, &off);
> >               keylen =3D hfs_brec_keylen(bnode, rec);
> > -             if (keylen =3D=3D 0) {
> > +             if (hfs_brec_len_invalid(bnode, len) ||
> > +                 hfs_brec_len_invalid(bnode, keylen)) {
> >                       res =3D -EINVAL;
> >                       goto fail;
> >               }
>
>
> I've realized that we have additional issue in HFS+ logic. Potentially,
> keylen and len could be not invalid but we could have negative value
> later in the logic:
>
> done:
>         fd->record =3D e;
>         fd->keyoffset =3D off;
>         fd->keylength =3D keylen;
>         fd->entryoffset =3D off + keylen;
>         fd->entrylength =3D len - keylen; <-- negative value here.
>
> The negative value of fd->entrylength is checked in multiple places.
> However, there is extents tree logic that has no such check [1]:
>
> static int __hfsplus_ext_write_extent(struct inode *inode,
>                 struct hfs_find_data *fd)
> {
> <skipped>
>
>         } else {
>                 if (res)
>                         return res;
>                 hfs_bnode_write(fd->bnode, hip->cached_extents,
>                                 fd->entryoffset, fd->entrylength);
>                 hip->extent_state &=3D ~HFSPLUS_EXT_DIRTY;
>         }
>
> <skipped>
> }
>
> Could you please double check my conclusion? We can fix the issue in
> another patch. Could you please fix the issue?
>

I agree with your conclusion. A crafted image can keep both len and
keylen valid but make fd->entrylength negative (i.e. keylen > len),
which may lead to out-of-bound read and kernel memory leaking.

To fix this issue, we can check validity of fd->entrylength in
__hfsplus_ext_write_extent() like the check in
__hfsplus_ext_read_extent(). For example:

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 813e68b8ecd6..eb7c11524d18 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -110,6 +110,8 @@ static int __hfsplus_ext_write_extent(struct inode *ino=
de,
        } else {
                if (res)
                        return res;
+               if (fd->entrylength !=3D sizeof(hfsplus_extent_rec))
+                       return -EIO;
                hfs_bnode_write(fd->bnode, hip->cached_extents,
                                fd->entryoffset, fd->entrylength);
                hip->extent_state &=3D ~HFSPLUS_EXT_DIRTY;

Do you think this fix is acceptable? If so, I'm happy to send another patch=
.

Best Regards,
Jiaming Zhang
