Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794868885;
	b=Lm6eLDqPii09FmzP0cvOmBizN2IJuIuITooK74KM3deA6QznuBTtvGzwCywgPXvfzAA3
	 tgmwdlyJyhonMV+u9hn35waR+kGRN0QuM9rSzQK7ZcjfYsw48qzmVZ7+AuXgQsEF0yEQU
	 NBhCDmw+R4rwI4Uris7zQN5OYw8QYJt6FCBIQstxINsG9hIRXM3W5EDGTJIdMPWW/eNXh
	 O2RElFLPp6o+gwiC7mgbYi3kneZ685fhH5+chY6Uvv+vrzT3OLOPfsTG9lgH1uBZDu6ql
	 ehKT7faNMoDe8Gm+5bzKZyL4OLzYcHNifPd6MqOw44hzrxWDHJ4jk9eE7tndVil7rkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794868885;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
	b=P0RcT1BSQe58dko9tcRp+NmbkE7eWCMJA0I4oTKOsGXBNJXsy8QjolCBlRPgHTlNLuId
	 mYyv4338LxPDSzGBScAIUotf0WbX+Bxs+cnR+gBRclPUDTKikL62c5lnGlFbE/BMBdGdS
	 4qEC9OqRH35vNZ54sPodYyzQf+c3MsuYnGOV0wc/Oea9zI6+yStK1EbcNcMcQlD8KxtMe
	 41eqk+R9qhxCU8GvTpOYZCQKPy6skWF7HbErFgs7GD944wL6VOcAEbAGPE8uNew/GzM7m
	 OCAx8ECzqqD/+UYQ2f8so5rRRxpgxJnmKxSW7LxZgCCOCR1hbRyOq6Ya/OsCY4hT1gw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc5k7Grm;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACD606A323
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 22:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3ACD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jc5k7Grm
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8b335ef6441so30216177b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 14:41:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794868884; cv=none;
        d=google.com; s=arc-20260327;
        b=d6jDpPvdIKDjcVRq2yVbX0Zkcw5Pwz9flo+5Hsu4zyx7Wr/ujM4Gp9hFW8IVTHy4Dj
         I0wcSWHJiXqCp7Kr9pFuPQELkYMDmZP3zko9fbi7cByR+gbxltpRafzVQ/LRvJLmaxwf
         zh2zSJ3j5pAwJyW2WzaKu/GIAFf/CH+7N9Y0kLJotaTwbPpSRyFy4aS9NlsaA5J9ZBNi
         IsMeUoXodDB/c8XtAF8QymcXiHfTHEtmGZv002Ab7DGs7vXsak8x3ZS8T4J/Xfo8Q487
         Pl4Jpo5kUhwAGOBzoTwHSJeR084UCw6pti7u5myXxqw/iDRTRjPaDYbqmQrX7fATXX4m
         sH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        fh=Zduv5dCtnUYaPtrZzEYOci5rwqhEObP9eJALRyYaCeY=;
        b=U6YgX1QswMcTxXmgvKj5o6cDu530W8BvJJ5HngSpUwEF5RgViUqEJMtaQHjggO2gEA
         5sDHUei4BjZWQ+Q/qL6SXGmJnIs/R5V2PRcKiplBX8u1HXfdbgo3cEwa6WksbwV1k9qM
         tYt3GpdWzaRWk5kjm7eO8BO/byo7628ZDyX8pc/XSH0lnoJOAQ8wEquI/DXuaPTFiAMR
         lti/Z+2iGX5RpIaX81OcuL6eDewuuQgglg/QAo1TJ/XrASUVFTQFe0PeF1wMsmS/wy4o
         Ja+K+pAoS/59mLU3bN6xZat86vGN16WGe0ByKsMm2mth0y1LIik08xNKwGOctP7nzeQt
         xCiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794868884; x=1795473684; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        b=Jc5k7GrmHEAmt0UUyFczLhxRSOuPWwl9lkXkjJO+coclp8jShxdCh0xiK40mf4cbI3
         Lm6UzEYuK+CdmbE/GoMPm5HecHiE3W2LnDpQz1Jg2pXwCDQ6shRhgnna/3QVI01ZrgMQ
         tdmUfTuugImvJHhXtOenDPHT7Dw0nkMM/7nsWp5HgtqJ3Weybze7/rW2HT1Ung5GdW/F
         49yT89/xGe7x2mKOQxwzcL/2WXKpr59fYtbAYYg34WdvMFr0D73/sX9IhaPA4CGEUSch
         ZExOKzyQGBB1/WNxnNWuCJGcF4H/+t/dEj8pLEuEInKLFiW1yGVrFLBrROLgP4UO6t1x
         hU6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794868884; x=1795473684;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gpp9LcCSgKl2cI7lJtnwvTOl6rqLL+9p0xxnoRcf0oE=;
        b=jqS2rpg6nftA74zcAfOkdjsNMvbwO6wW4qL6FImXdK3f3NEPg+d7zvaetJrJukD/cT
         MQPxsdfyIhv0XBVkB9nP4w5ROyXgC3zqDcciRq4fRUyMQo8PxyoL2S7oX6Jppsk3EbMb
         a3bS5OjfMp7GRf871js0KWZC7saYJSSFtDVOhUF2ASkV63KpDAXcLjH5TG98O0fwJgNo
         8axlycf4KMw/xGZIMpLLUzx5lTQHuXhNNAouMFNo9T4kYdEajsEcwg4yYZdgQIR2KLMh
         1HQQLrRU016fXKs5kNUGy6K8lvTwRB4A4jcxn9C8GklZ5K8efovXsLOdlEBX5TXVkxOP
         yfaQ==
X-Forwarded-Encrypted: i=1; AL+hErEVsa926lsnm2IHi1cWJP2NZmbrwqFqwL5NF3ZZ3UqSd22udEGM6tJUaFAnvZ9A8sw7ezmrfDrx6KYQcP8l@vger.kernel.org
X-Gm-Message-State: APuU4Z8LmhEjidmEi6VENE7xzfDeSEzOCrnwKZrz6ibxMjSLEyN7+ynb
	EWAey0JxgTHV6pAtXUU+ON9Dur+3WL6yq47cDcjubCbuZN6TtOo72dibJRPsooF74t9UG4j08fX
	kCV9AKET35IRVDJV75MeAeftFedY4Fm0ZJTuc
X-Gm-Gg: AZFdTZd2k0QhPQNqblooJVlIKjHBNoS5RwLY5XhCTXs1q2F+SDrpF5ImjIMBO8BITUj
	T8MvgzvQxxtH3SiB4IKgzTpvCFpoKL4iEX6BC9eV9/O8GQDH8OIEzGu6nXEXQ7ritv7tN3oskSH
	N6+RHanzH5568loFC5LYZ5wLPvXVCPmSgGIucscem/SkQwuM61/VjkKNMYiehfK86vJkfbaeIAV
	9ySTZtCJ9fxvK6tnITglnHziktUYkx2eoquTln9zy28Ctzki7baBUTwLsv5Q7hkZtJ/WQ8HwoOT
	b5giXwUHzdjwU7SHrcChYiQaIgxCBeGCKIsW1ss7Md7a22jTe1eVqq1il6LE+CyCbSiuzoMUl9o
	JFxtlalQ7AVIEHtolDpNFhx562eSuuYiO1WVGC+6hI/W9qFQF9y4hAIAi/7/XCyu0OA6YJwsnTY
	OnpiRZs8M4Nf/u55yo9PRkiKAnxbhoa4hKs4546MRcG+Eq
X-Received: by 2002:a05:690c:19:b0:8b3:7621:f691 with SMTP id
 00721157ae682-8b4aa39510dmr61981927b3.58.1794868883895; Mon, 16 Nov 2026
 14:41:23 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261114043522.48764-1-ozgunkultekin@gmail.com> <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
In-Reply-To: <342f864c01c694acc0ec59b4d79f18e627a1ea24.camel@dubeyko.com>
From: =?UTF-8?B?w5Z6Z8O8biBLw7xsdGVraW4=?= <ozgunkultekin@gmail.com>
Date: Mon, 16 Nov 2026 14:41:12 -0800
X-Gm-Features: Aa3M54pYTt9GjzCqNOUVY3T7b3LZBifqVTCc5WOUnoDmeg9LkLB7qIWfc1SBSbc
Message-ID: <CAP2AQ-AnKOvRguMAdxi6KhTw_XYME+8EqdeSpnbxWVRHwcC-=A@mail.gmail.com>
Subject: Re: [PATCH 1/2] hfsplus: bound btree keys by the tree's max_key_len
 in hfs_bnode_read_key()
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, Guikun Yang <yangguikun19@qq.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Sorry, the commit message was too dense. Here is the issue step by step.

hfs_find_init() allocates one buffer for the search key and the found key:

 ptr =3D kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
 fd->search_key =3D ptr;
 fd->key =3D ptr + tree->max_key_len + 2;

For the extents tree max_key_len is 10, so the allocation is 24 bytes
and each key buffer is 12 bytes.

hfs_bnode_read_key() takes the key length from disk (for leaf records
of the extents tree) and only checks it against
sizeof(hfsplus_btree_key), which is 518:

 if (key_len > sizeof(hfsplus_btree_key) || key_len < 1)

So an extents leaf record with key length 514 passes the check, and
hfs_bnode_read() copies 516 bytes into the 24-byte allocation. The
check from bb5e07cb9277 protects the catalog tree, where the buffers
are big enough, but not the extents tree.

It is reached from hfs_brec_insert(), which calls hfs_bnode_read_key()
on a key that was never validated (record 0 of the leaf when the tree
has no root yet, or the first key of a new node after a split).
Mounting the crafted image read-write is enough: hfsplus_fill_super()
creates the private data directory, which extends the catalog file and
inserts an extents record.

KASAN on Fedora 7.3.3-300.fc45.x86_64+debug, mount only:

BUG: KASAN: slab-out-of-bounds in hfsplus_bnode_read+0x39/0x360 [hfsplus]
Write of size 516 at addr ff11000003a0e740 by task pool-1/1720
Call Trace:
 __asan_memset+0x27/0x50
 hfsplus_bnode_read+0x39/0x360 [hfsplus]
 hfsplus_bnode_read_key+0x12b/0x230 [hfsplus]
 hfsplus_brec_insert+0x554/0xcc0 [hfsplus]
 __hfsplus_ext_write_extent+0x4fd/0x750 [hfsplus]
 hfsplus_ext_read_extent+0x7a7/0xaa0 [hfsplus]
 hfsplus_file_extend+0x862/0x12a0 [hfsplus]
 hfsplus_bmap_reserve+0x2e1/0x4c0 [hfsplus]
 hfsplus_fill_super+0x135a/0x1910 [hfsplus]
Allocated by task 1720:
 __kmalloc_noprof+0x353/0x9d0
 hfsplus_find_init+0x18c/0x400 [hfsplus]
 hfsplus_fill_super+0x135a/0x1910 [hfsplus]
The buggy address is located 0 bytes inside of allocated 24-byte
region [ff11000003a0e740, ff11000003a0e758)

The error path has the same problem: memset(key, 0,
sizeof(hfsplus_btree_key)) clears 518 bytes of the same buffer.

The fix checks key_len against tree->max_key_len + 2, the real size of
each key buffer, and clears only that much on error. max_key_len is
already validated per tree in hfs_btree_open(), so valid keys still
pass, including the 518-byte catalog keys. With the patch the image is
refused with "hfsplus: Invalid key length: 516" and there is no KASAN
report. Normal HFS+ volumes still work (create, append into the
extents tree, rename, delete, xattrs) and fsck.hfsplus reports them
clean.

Patch 2/2 is the same bug in classic hfs: there the extents key
buffers are 18 bytes in total, and the check is against
sizeof(hfs_btree_key).

I can send the image generator, or a v2 with this text in the commit
message if that helps.

Thanks,
ozgun


On Mon, Nov 16, 2026 at 2:02=E2=80=AFPM Viacheslav Dubeyko <slava@dubeyko.c=
om> wrote:
>
> On Fri, 2026-11-13 at 20:35 -0800, ozgun kultekin wrote:
> > hfs_bnode_read_key() reads the key length of leaf records (and of all
> > records of variable-key and attributes trees) from disk and only
> > checks
> > it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
> > always one of the two key buffers hfs_find_init() allocates, each
> > tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
> > fixed at 10, so the whole allocation is 24 bytes and a crafted leaf
> > key
> > writes up to 516 attacker-controlled bytes into kmalloc-32. The error
> > path has the same problem: it clears 518 bytes of the 24-byte buffer.
> >
> > hfs_brec_insert() reaches this with an unvalidated key: when the tree
> > root is 0 it reads the key of record 0 of the leaf it inserts into,
> > and
> > after a split it reads the first key of the new node. A read-write
> > mount
> > that extends the catalog (creating the private data directory), or an
> > append to a file whose extents spill into the extents tree, is
> > enough;
> > no other file operation is needed.
> >
> > The 518-byte bound was added by commit bb5e07cb9277 ("hfs/hfsplus:
> > fix
> > slab-out-of-bounds in hfs_bnode_read_key"); it covers the catalog and
> > attributes buffers but not the extents buffer. Bound the key length
> > by
> > the tree's own maximum, which btree.c already validates per tree, and
> > only clear the bytes the buffer actually has.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in
> > hfs_bnode_read_key")
> > Reported-by: Guikun Yang <yangguikun19@qq.com>
> > Closes:
> > https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F0=
8@qq.com/
> > Cc: stable@vger.kernel.org
> > Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
> > ---
> > diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> > index 3a1a1fa..f414020 100644
> > --- a/fs/hfsplus/bnode.c
> > +++ b/fs/hfsplus/bnode.c
> > @@ -84,8 +84,13 @@ void hfs_bnode_read_key(struct hfs_bnode *node,
> > void *key, u32 off)
> >       else
> >               key_len =3D tree->max_key_len + 2;
> >
> > -     if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
> > -             memset(key, 0, sizeof(hfsplus_btree_key));
> > +     /*
> > +      * The key buffers come from hfs_find_init() and hold
> > +      * tree->max_key_len + 2 bytes each, which is far less than
> > +      * sizeof(hfsplus_btree_key) for the extents tree.
> > +      */
> > +     if (key_len > tree->max_key_len + 2 || key_len < 1) {
> > +             memset(key, 0, tree->max_key_len + 2);
> >               pr_err("hfsplus: Invalid key length: %u\n",
> > key_len);
> >               return;
> >       }
> > --
> > 2.47.0
>
> I don't quite follow to the fix. What issue are you trying to fix?
> Could you please explain it more clearly?
>
> Thanks,
> Slava.
