Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5A262FD0
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 05:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782970261; cv=pass; b=EHoVO0f3QY57nZPZ0Qh1FP/4QryP8PLWe2ODO0huAhe2pC69CZI9H6wFD+NgDRiBv+hO68KdWdOI+pFrnVfVCRoFEmlgCsz40+kL1HOttPZu9oHxCqpUQV5h7jw6Po3P/J8iNxtG+hLMOpC+ap+ywWXDILEPCaqfvZ1D/mg9Esc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782970261; c=relaxed/simple;
	bh=kI/47gROSL4oU949/2kjwzdE7BGfMCwBjrkqCWUFK2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Snwo9TbJZhLTgIgrwf8mRYo0tLjh0h0OPcDx5xQFbWMshvokxCfK2chdi8CyKgH/PFJZMDyKpucSDkBCxd0c4gN2Tyfa8DGE70kNTGD+b40uTvHAFuYVc+sWfeYEsH7AOt8f5jj1RdqMf95zwP3Q+V8v27tOIB+MypKAYE3vaMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IymwPp9T; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IymwPp9T"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c125fbfbae0so145856766b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 22:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782970257; cv=none;
        d=google.com; s=arc-20260327;
        b=OAH8pLEj/RSd9UrrTMLMB2cI03pRm+QudZ7RTEiB8VgpIL0AoN5Yy8KgabS6ReSM6+
         zom4ZukuK4612cwtoq/gv4aKPxDSVBEWpp44Wr7zQO6oblgUr9qCTAJZrlyPPD2P0v2M
         +BMGJ0D0LNmoo2OXy7qTJB1VUHztqqbrd77elnGSAlHxZVW3zGlT4dNkWuz+hU1lwUQy
         tGrCpQKuBArbFPhfGrUQk0KbTaPomI47Shuf0nE6CdkFT0dg7/AobDc47Pk8JSSvDh+D
         N8A9W6eXfJ5IG3JgPut1M1oSyWKw4TrBcQsMk3DX767KSFRCrlmeYRCw7WnvCuMITU54
         cOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bELejxA6xNl1rTCERHzNWjc3NY2ffQPjFphF1wY/jKo=;
        fh=kLF9CSy4ytoCPe04lVNxfnhwvjp2z7Dgf57XTsMHnv0=;
        b=pXaGaQbu7LxUMM0zg7ZTcc3m+mbnKEF/O+rZLVkFFCH6p5xaDqsDkbIHPvOyMX3VGq
         bB48Zy4puDip3fCXTEenCDstc/C763kmoMzNttP2D/vB7orvvh1lgHNDC55rGUXlzwJo
         sSUkgUovJdpyxguBYCbMAhvFd/mMYEitt88ZatIZ3SYiQNVdJjKncio1ehajBLjwh/KM
         1l4GIm+8Ft2B8x6LOYP6zVcv84QVgcVIa7DNBUGob4vsiD4khsERbNNoaDVv+ryt1NcK
         stlTaNi339v8M3AlwcadAfHqfiTUXWAC5ErNyQSGIa9XytVxRW02lobSjY73pdxIyq3e
         DhtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782970257; x=1783575057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bELejxA6xNl1rTCERHzNWjc3NY2ffQPjFphF1wY/jKo=;
        b=IymwPp9TwHVr1QDcOaTdJilM+0Vhi76O2aWxiGliQEhshk76QmPb4LD2yaCs1+WL52
         rTic8ho/yIYozLSDJ7369xPyFRxqXxxkoRvDB+l1Wc8OHlYGOQoLkC5YSD2aIq8UvMEY
         oEtdHGnLdZbe+2i/Bp4CSik/UgztSYXdRX9Z1MzOMgX232TydoQuE1k5ewP6mvlCvqJl
         abtUdbNthme/O7v3v4GmNH8QWwvP072z+avwPmsoGO5BsZ9iS9ony6GquL1HYTGWVO33
         y8zdM6kWX+tmJB4DKFKvb7JyjAMUV0q/NWeHLbNLJD3pQ0gZQhFvwgdXe8FOklcJUGPy
         HmzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782970257; x=1783575057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bELejxA6xNl1rTCERHzNWjc3NY2ffQPjFphF1wY/jKo=;
        b=KBT8YbEZkQR7+/xg/ieIfQQkp9NndRbgKE1z44EZptzZGwZB8I1adHj+Kw/g8Z0z8u
         Spc7F6tp4sEvs/H5c/LsWw28YP6f6yHqd1cnjQ4UxBoIB3WJIkI/p60rW4AlQStCj5RK
         iMGfmsfiDwRObCsYD0fKXxPufOzKtEc/vbnnTeoDfK2iTiE0Tglmmasatb+7ZWAKvdG5
         GYPjnsuer70jLj4Na4AttrGAhyJvEAt3MrCCb6DSX0pwnX3BBwHjumUT0dQz3d1RRIHS
         IEhK8AkXSEQua/LOrI9s198QeQ4ElRxg/no4EDqRFqTZK9AxzaSHTL4dLx0qiD/d9vuf
         MNYA==
X-Forwarded-Encrypted: i=1; AHgh+Rqdxk4RYzL/e3o8IJJrWvlXx9ROiurhH8GuKI2tE+hagSv1IA/Chnr7Plxbdg0Nqd5w2AdyCqJon4Jc6B2W@vger.kernel.org
X-Gm-Message-State: AOJu0YyRhkehD1FECoxs+dRxwlqXZ6unUavdlEe/Gj6ANkjuzEWkQ6Mn
	2XvPbg1gfDFQlrMh9C+ADwtvhBF+A+6wzBiZ737Ux8FY03M2epnH2DoSQwdcehyBqvql/iXPiua
	hXKDkYFBETYpdvx5Q2BSud2vTseQVG6MvFhHggS8cAA==
X-Gm-Gg: AfdE7cn0b0/yVSEdqrkrX9vFlYqt5qiR42SISHb4Z9cGKiyiS2a8bcsyCnXzFLyeDtm
	SokbJUx4pPqfUfGaWln162f02vr8i58GIQzlhfXN26X8NaVqZCWST3UCs8gmoaUr2DYYVQj/t45
	pLUeMq1f8X9SsLweQGeqVKAUe04vXEgvgebuYGQwD2u6PabP+8jZpljHIeX20lvDx5Yr6/bQurK
	xWmwSvYBzSnPjwGnXPYxw+Hqy96/lAbmxLK4rNFwKZRFIBlfm+LgaSt22ZSDl839FW94LPP8IB/
	fXRSc0nOUd8cfjcaMIkB7nnHpsa+fU8=
X-Received: by 2002:a17:907:c408:b0:c12:51d9:bb78 with SMTP id
 a640c23a62f3a-c12a9de6f7bmr208925966b.28.1782970256938; Wed, 01 Jul 2026
 22:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623093750.2311-1-aditya.ansh182@gmail.com> <5c6c46993f8fbf44300814e2b37ca62e637cdc66.camel@dubeyko.com>
In-Reply-To: <5c6c46993f8fbf44300814e2b37ca62e637cdc66.camel@dubeyko.com>
From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
Date: Thu, 2 Jul 2026 11:00:44 +0530
X-Gm-Features: AVVi8CdMmTDZbW6mldyfqemSDkmPkFB9BzKF7Qzjmxm8e-M469FGs0vLtOSbd-c
Message-ID: <CAK5ssPN-7631-=bZT1QhovU5jq_z=a8sjEK4g+GaMa1jOFFU3g@mail.gmail.com>
Subject: Re: [PATCH] hfs: port HFS+ b-tree bitmap corruption check
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: glaubitz@physik.fu-berlin.de, frank.li@vivo.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Slava,

Thanks for the suggestion.

You're right. The initial implementation ended up a bit more
complex because HFS lacks the struct hfs_bmap_ctx and
hfs_bmap_get_map_page() helpers that HFS+ already has.

Porting those helpers to HFS is straightforward since both
filesystems use the same b-tree map layout (record index 2 for
the header node map and record index 0 for map nodes). Doing so
also lets hfs_bmap_test_bit() follow the same implementation as
HFS+, which is much cleaner.

I'll update this in v2 by:

adding struct hfs_bmap_ctx to fs/hfs/btree.c;
porting hfs_bmap_get_map_page();
simplifying hfs_bmap_test_bit() to match the HFS+
implementation; and
updating hfs_btree_open() to call
hfs_bmap_test_bit(node, 0) accordingly.

I'll send a v2 with these changes.

Thanks,
Aditya

On Thu, Jul 2, 2026 at 8:21=E2=80=AFAM Viacheslav Dubeyko <slava@dubeyko.co=
m> wrote:
>
> On Tue, 2026-06-23 at 09:37 +0000, Aditya Srivastava wrote:
> > From: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> >
> > In HFS+ filesystems, during b-tree open (hfs_btree_open()), the code
> > verifies that the allocation map bit for the tree header (node 0) is
> > set.
> > If not, it indicates a corrupted map record/bitmap and mounts the
> > volume
> > as read-only (SB_RDONLY) to prevent further damage.
> >
> > HFS filesystems share the same b-tree structure but currently lack
> > this
> > corruption detection check, which was highlighted by the maintainer.
> >
> > Port this check to HFS:
> > 1. Implement hfs_bmap_test_bit() in fs/hfs/btree.c (which safely
> > traverses
> >    the b-tree map nodes to inspect the desired bit, identical to
> > HFS+).
> > 2. Invoke hfs_bmap_test_bit() for node 0 at the end of
> > hfs_btree_open(),
> >    warning and forcing read-only if corruption is detected.
> >
> > Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > Link:
> > https://lore.kernel.org/all/6a36101b.be22b350.2a3e9.0001.GAE@google.com=
/T/#r446d0fed2a2900bd805534bbcb799d86619ae2ea
> > Signed-off-by: Aditya Prakash Srivastava <aditya.ansh182@gmail.com>
> > ---
> >  fs/hfs/btree.c | 52
> > ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/hfs/btree.h |  1 +
> >  2 files changed, 53 insertions(+)
> >
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index 2eb37a2f64e8..4293399d377e 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -155,6 +155,14 @@ struct hfs_btree *hfs_btree_open(struct
> > super_block *sb, u32 id, btree_keycmp ke
> >       kunmap_local(head);
> >       folio_unlock(folio);
> >       folio_put(folio);
> > +
> > +     if (!hfs_bmap_test_bit(tree, 0)) {
> > +             pr_warn("(%s): %s (cnid 0x%x) map record invalid or
> > bitmap corruption detected, forcing read-only.\n",
> > +                     sb->s_id, id =3D=3D HFS_EXT_CNID ? "extents" :
> > "catalog", id);
> > +             pr_warn("Run fsck.hfs to repair.\n");
> > +             sb->s_flags |=3D SB_RDONLY;
> > +     }
> > +
> >       return tree;
> >
> >  fail_folio:
> > @@ -356,6 +364,50 @@ struct hfs_bnode *hfs_bmap_alloc(struct
> > hfs_btree *tree)
> >       }
> >  }
> >
> > +bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx)
> > +{
> > +     struct hfs_bnode *node;
> > +     struct page *page;
> > +     u16 off, len;
> > +     u8 *data, byte, m;
> > +     bool res =3D false;
> > +
> > +     node =3D hfs_bnode_find(tree, 0);
> > +     if (IS_ERR(node))
> > +             return false;
> > +
> > +     len =3D hfs_brec_lenoff(node, 2, &off);
> > +     while (nidx >=3D len * 8) {
> > +             u32 i;
> > +
> > +             nidx -=3D len * 8;
> > +             i =3D node->next;
> > +             if (!i) {
> > +                     hfs_bnode_put(node);
> > +                     return false;
> > +             }
> > +             hfs_bnode_put(node);
> > +             node =3D hfs_bnode_find(tree, i);
> > +             if (IS_ERR(node))
> > +                     return false;
> > +             if (node->type !=3D HFS_NODE_MAP) {
> > +                     hfs_bnode_put(node);
> > +                     return false;
> > +             }
> > +             len =3D hfs_brec_lenoff(node, 0, &off);
> > +     }
> > +     off +=3D node->page_offset + nidx / 8;
> > +     page =3D node->page[off >> PAGE_SHIFT];
> > +     data =3D kmap_local_page(page);
> > +     off &=3D ~PAGE_MASK;
> > +     m =3D 1 << (~nidx & 7);
> > +     byte =3D data[off];
> > +     res =3D (byte & m) !=3D 0;
> > +     kunmap_local(data);
> > +     hfs_bnode_put(node);
> > +     return res;
> > +}
>
> Why we cannot follow to the approach is implemented in HFS+?
>
> static bool hfs_bmap_test_bit(struct hfs_bnode *node, u32 node_bit_idx)
> {
>         struct hfs_bmap_ctx ctx;
>         struct page *page;
>         u8 *bmap, byte, mask;
>
>         page =3D hfs_bmap_get_map_page(node, &ctx, node_bit_idx /
> BITS_PER_BYTE);
>         if (IS_ERR(page))
>                 return false;
>
>         bmap =3D kmap_local_page(page);
>         byte =3D bmap[ctx.off];
>         kunmap_local(bmap);
>
>         mask =3D 1 << (7 - (node_bit_idx % BITS_PER_BYTE));
>         return (byte & mask) !=3D 0;
> }
>
> Currently implemented function looks slightly complicated. Also, I
> would like to have similar logic in HFS and HFS+ with the goal to make
> b-tree logic something like library that HFS and HFS+ code can use.
>
> Thanks,
> Slava.
>
> > +
> >  void hfs_bmap_free(struct hfs_bnode *node)
> >  {
> >       struct hfs_btree *tree;
> > diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> > index 99be858b2446..efe88f66c856 100644
> > --- a/fs/hfs/btree.h
> > +++ b/fs/hfs/btree.h
> > @@ -93,6 +93,7 @@ extern void hfs_btree_write(struct hfs_btree
> > *tree);
> >  extern int hfs_bmap_reserve(struct hfs_btree *tree, u32 rsvd_nodes);
> >  extern struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *tree);
> >  extern void hfs_bmap_free(struct hfs_bnode *node);
> > +extern bool hfs_bmap_test_bit(struct hfs_btree *tree, u32 nidx);
> >
> >  /* bnode.c */
> >  extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32
> > off, u32 len);
