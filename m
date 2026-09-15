Received: from mail-yx2-f22.google.com (mail-yx2-f22.google.com [74.125.224.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF4C31355C
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 23:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789516108; cv=none; b=FwcM/MbzQ27jGQ3i1ilXjRx0OTCB1UUbp642GMRaupPRS8vX5zAOvt2BtiO5fLmzeIET+Mht6lPKUSaEKNZrY2fYdBafwyeB1uNUIgGjnGPVVuLVLVsVrhM4gqGf6tjjH+H8BkUg5NElxKdcJklX/CMFTMGTg44R0IVble0VYKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789516108; c=relaxed/simple;
	bh=s+OIyXRdgwnZR1ziP4GjQx8+xS5Ni5jQlk4FMULFipA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PyeegAfnSWTaMBoaPR5+V4LIEmb+og1wySKHA4E1uIfHoJTG/azzZEo9swm6MDf98+S8se7A+lTxjN+zeETbDC+q5V/NhdFgRl1+J7exJpTGpUNBIKE+8MbaBrz5pgXljjO3IZ1TDVBDcG9XFEUvneowrvDqpKzYvrvSpC4HxYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=hhBDw/CU; arc=none smtp.client-ip=74.125.224.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="hhBDw/CU"
Received: by mail-yx2-f22.google.com with SMTP id 00721157ae682-85d4ddd1d91so2483507b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789516106; x=1790120906; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBIxDF51BixzYXSIw3R/3iVxilVITCxMF4/ZGDvxozE=;
        b=hhBDw/CUlN3PJ1dtH74/berlt+rDn7HUHxsWAgxNFwkS5KTKR43ALRTlfp9Ag8oK7D
         HzqxuOkpuM94T1fhP11ASfF2DWYrXEA1QZmb0GbXzFrx7N+nAb4/qmTRRX4CDbHb6TbP
         2Smv/p0isIpdwo+sP1SLAcyrARk3tKIwSAvxvsKiGOgLmtJ5d9++3+IMmQdyqJAuJnGz
         tiqZKE/SshTJIB7uciegIbBDsilFGxfvLqeiitX1vj8/s/eU07xmy+0em7cqftrLhVYz
         YecYekR7Sm+jQla0KEJHgH9EjPqUseBVlBsAxuOcN93zKR8ttZD3OBr0mawaXP9rR8jl
         82Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789516106; x=1790120906;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YBIxDF51BixzYXSIw3R/3iVxilVITCxMF4/ZGDvxozE=;
        b=mAK4T2yeQiGRNu5KaeUHm1L2SkRM1m2fGXWLa9iiBAxeLZgosea+Hg7RdR0a4f+F6v
         WmaUWsZWwlkXcI4VAGb1iyea8AI9Dfvt9OyCyBcKD/reyvSnBwyxTUX4kfM5LjNEP+p8
         QyYg+U7TWIL80Amt2JJlvdCD7Fj1FowACEWI+dEVhR4CC+x4pocW6QfR6kjWXUFRsQZn
         IclPKs/CLkuqNQNS7iRmYBGSqt/tUg4gUohpbYwUbFJzF0+EwDwSFSeNo1G5duz2MB9i
         RW1ymrAqj78ryy+1bVWEhiNdEW+DDsRga409lOsj825LGfbTcfqxeAH7DLUHYCxEpb3u
         ryuQ==
X-Forwarded-Encrypted: i=1; AKwUvBw+6llLzd6fszsfhDvIrC366q5NnRnIDZGCugi9pVoC25DuBPqI9X7g1U7OF7XDZocvBuPyu0yBWDLeoBe4@vger.kernel.org
X-Gm-Message-State: AFuF++mJx1f1qAsQRR+5/n2LfcZgkvOPMlfdqa2IPG9vGIPAkqZ6+kku
	GnE2XlKIjIEZxLkvTrzk802yKC0LQueTjl3JSCYSVV9e4Uw+fgX87QtbxgiK/exMMrNpRlGYGtr
	tyumfxV1O0Q==
X-Gm-Gg: AYBFou1dJsZXb7yBTO0eZfdeQz9wdN65n2f2UbyhdidDPKIAdAeood0bUkndQkRIdTP
	Nll5/vC1Psyzis9+Skkb3EJdNX050MggDk5HE4RvDrvRsZYNUu6xsPIGGpcx8cT9U6QfH3ll9Tt
	9/vnkpRxPMwajmI/JR9+F+4kxZLpHChyPO8rgp7i9GAmrNGNIMtBBKDkID9x6yuR+85QWT/L4ta
	R66xtrlumX/Qk1W8P2RmwGHkc3updBrlMpL/2Yz00+wcG3Wrdz065FPvgJ9w6vq9omQfxO/u81I
	rrTeltLXcpwhdWApRFquHiXbLF1+UN4U3xk7zGceLcG+O+KaJosrORHGlIw0qDjWWMOOqF25+xn
	c88fUiamjHKT3fhSaRVXgdZpkenuGhs1BjVeWqD/L5x4Gc9eLvz75NjpgnytHC0P0acef391eYS
	r/NEAZhm3ZcHufR2NJsxxloc8iRTNzlDnDFD23YTylCWWUvA2ECsAa3uukyssB/OfS7X1QfNsyN
	NZqwrZpcEcxjcjRvzMw+f9wiHdLXDpjDOSaixWrudMbiyXBTqswCWCNfsu4zKh9datrtXv4xyqi
	3e+UZo9jC9QeINJ8tXAufoMzV2PSdc22stdhZuJ5kvpgE/Nn8xvK58tVHCWcThA/pQHCWU4uF4M
	=
X-Received: by 2002:a05:690c:113:b0:871:bc3:9844 with SMTP id 00721157ae682-89223ce4cd5mr2521057b3.7.1789516105783;
        Tue, 15 Sep 2026 16:48:25 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e9c6:4a77:70a9:9f1d? ([2600:1700:6476:1430:e9c6:4a77:70a9:9f1d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891ee4a951asm2593447b3.9.2026.09.15.16.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:48:24 -0700 (PDT)
Message-ID: <7d1b09519cddf5124def5fdda42a5a3c8ba4ef11.camel@dubeyko.com>
Subject: Re: [PATCH v4 2/2] hfsplus: validate b-tree fork extents at mount
 time
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Tue, 15 Sep 2026 16:48:23 -0700
In-Reply-To: <20260915141543.24335-1-ngocthang2710.1999@gmail.com>
References: <cbc98010b9f6657e162cfcc6ac5ba6032e7b729d.camel@dubeyko.com>
	 <20260915141543.24335-1-ngocthang2710.1999@gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Nguyen Ngoc,

Please, don't move your answers from the code where I left my
questions. I really cannot follow to your answers and the whole
discussion is broken. I cannot follow to your answers. I am simply
rejecting the whole email.

Thanks,
Slava.


On Tue, 2026-09-15 at 21:15 +0700, Nguyen Ngoc Thang wrote:
> Hi Slava,
>=20
> Thanks again for the review, replies inline, v5 diff (applies on top
> of the v5 1/2 I just sent) at the bottom.
>=20
> > If we return error code for corrupted fork (that makes more sense),
> > then we don't need in switch here.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case -EIO:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 pr_err("%s (cnid 0x%x) fork's first extent is
> > > corrupt\n",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_btree_name(id), =
id);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto free_inode;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 case 1:
> >=20
> > I don't see the point returning 1 from the function. It should be
> > error
> > code.
>=20
> Agreed, done. hfsplus_check_fork() now returns 0 (consistent),
> -EUCLEAN (corrupt past the first extent, tree still locatable, mount
> read-only), or -EIO (first extent corrupt, or no used extent at all -
> -
> see below). hfs_btree_open() now just checks the return value with
> if/else instead of switching on it.
>=20
> > Why not struct hfsplus_fork_raw here for check?
>=20
> I looked into this, but the b-tree's inode only keeps the decoded
> first_extents/first_blocks fields (see hfsplus_iget()), not the raw
> hfsplus_fork_raw (total_size/clump_size/total_blocks as a struct) --
> that only exists transiently while reading the volume header. Passing
> the raw fork through would mean plumbing it from hfsplus_fill_super()
> into hfs_btree_open() as an extra argument, which felt like a bigger
> restructuring than this patch should take on. I'd rather scope that
> as
> a follow-up than guess at it here -- let me know if you disagree and
> I'll take a pass at it.
>=20
> > Ditto. Related to hardcoded value.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 8; i++, ext++) {
>=20
> Uses HFSPLUS_EXTENT_COUNT now too (same constant added in patch 1/2).
>=20
> > I think that current logic of check looks complicated. [...] For
> > example, fork cannot be completely empty. Could we rework the logic
> > to be more clear? Maybe, we need to introduce the function for
> > extent
> > check, function for checking the extents are logically contiguous?
>=20
> Fixed the empty-fork case: hfsplus_check_fork() now tracks seen_used
> and returns -EIO if no extent was ever in use. Note hs_btree_open()
> already guarded against this indirectly via its existing
> `!first_blocks` check right before calling hfsplus_check_fork(), so
> this makes the function correct on its own instead of relying on that
> caller-side check.
>=20
> I held off on splitting per-extent-check and contiguity-check into
> separate functions -- the loop is short and the two conditions
> (garbage in an unused slot vs. a used extent overflowing/following a
> hole) share the same start/count/seen_hole state per iteration, so
> splitting it looked like it'd add indirection without really
> clarifying anything. Happy to revisit if you still think it's worth
> it.
>=20
> > Ditto. Related to 1. I prefer to have error code instead.
>=20
> Same fix as above (-EUCLEAN).
>=20
> > I don't want to say that this direction is wrong. However, we have
> > flags: [...] Potentially, we can introduce the
> > HFSPLUS_I_CORRUPT_TREE.
>=20
> Done -- dropped struct hfs_btree.corrupt, added
> HFSPLUS_I_CORRUPT_TREE
> next to the existing HFSPLUS_I_*_DIRTY flags, tested via a new
> HFSPLUS_TREE_IS_CORRUPT(tree) helper macro on the tree's own inode.
>=20
> > Currently, only hfsplus_fill_super() can detect the b-tree
> > corruption. Why do we have the check here? Do you mean that xattr
> > b-tree can be created and to be corrupted?
>=20
> No -- corruption is only ever detected once, in hfs_btree_open() at
> initial mount. The hfsplus_reconfigure() check isn't detecting
> anything new; it's re-reading the flag hfs_btree_open() already set,
> so that a remount to rw can't silently clear SB_RDONLY on a volume
> that was already known to be corrupt at mount time. Added a short
> comment there to make that explicit.
>=20
> > If we fail to check any b-tree, then logic should stop. Why haven't
> > we checked the error code of hfs_btree_open()?
>=20
> I checked -- hfsplus_fill_super() already does check every
> hfs_btree_open() call (out_close_ext_tree / out_close_cat_tree /
> out_close_attr_tree gotos) before it ever looks at
> HFSPLUS_TREE_IS_CORRUPT(), so no change was needed there.
>=20
> One more from the previous mail I noticed while redoing this: there
> was also a checkpatch --strict alignment nit on the pr_err()
> continuation line in hfs_btree_open() itself (not one you'd flagged,
> but same category), fixed that too while I was in there.
>=20
> Thanks again for the thorough review -- v5 below.
>=20
> ---
> Changes since v4:
> =C2=A0- hfsplus_check_fork() returns real error codes (0/-EUCLEAN/-EIO)
> =C2=A0=C2=A0 instead of 0/1/-EIO; hfs_btree_open() uses if/else instead o=
f a
> =C2=A0=C2=A0 switch.
> =C2=A0- A fork with no used extent at all is now treated as corrupt.
> =C2=A0- Use HFSPLUS_EXTENT_COUNT instead of hardcoding 8.
> =C2=A0- Track per-tree corruption as an HFSPLUS_I_CORRUPT_TREE inode flag
> =C2=A0=C2=A0 instead of a bool on struct hfs_btree.
> =C2=A0- Comment explaining the corrupt-tree check in
> hfsplus_reconfigure().
> =C2=A0- Fixed a checkpatch --strict alignment nit in hfs_btree_open().
> (all per Slava's review)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 2ea8cd5658e1..2dbbb8096575 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -274,6 +274,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0	struct inode *inode;
> =C2=A0	struct page *page;
> =C2=A0	unsigned int size;
> +	int res;
>=20
> =C2=A0	tree =3D kzalloc_obj(*tree);
> =C2=A0	if (!tree)
> @@ -293,6 +294,17 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0		goto free_inode;
> =C2=A0	}
>=20
> +	res =3D hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)-
> >first_extents);
> +	if (res =3D=3D -EIO) {
> +		pr_err("%s (cnid 0x%x) fork's first extent is
> corrupt\n",
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfs_btree_name(id), id);
> +		goto free_inode;
> +	} else if (res) {
> +		pr_warn("%s (cnid 0x%x) fork has corrupt extents,
> forcing read-only.\n",
> +			hfs_btree_name(id), id);
> +		set_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I(tree-
> >inode)->flags);
> +	}
> +
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	page =3D read_mapping_page(mapping, 0, NULL);
> =C2=A0	if (IS_ERR(page))
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index f3a4b8fd567f..d98261c01b13 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -101,6 +101,39 @@ static bool hfsplus_ext_fork_full(struct
> hfsplus_extent *ext)
> =C2=A0	return true;
> =C2=A0}
>=20
> +/*
> + * Validate a fork's extents. Returns 0 if consistent, -EUCLEAN if
> only
> + * extents past the first are corrupt (safe to mount read-only), or
> + * -EIO if the first extent is corrupt or the fork has no used
> extent.
> + */
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext)
> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	bool seen_hole =3D false;
> +	bool seen_used =3D false;
> +	int i;
> +
> +	for (i =3D 0; i < HFSPLUS_EXTENT_COUNT; i++, ext++) {
> +		u32 start =3D be32_to_cpu(ext->start_block);
> +		u32 count =3D be32_to_cpu(ext->block_count);
> +		bool bad;
> +
> +		if (!count) {
> +			bad =3D start !=3D 0;
> +			seen_hole =3D true;
> +		} else {
> +			bad =3D seen_hole || start + count < start ||
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start + count > sbi->total_blocks;
> +			seen_used =3D true;
> +		}
> +
> +		if (bad)
> +			return i ? -EUCLEAN : -EIO;
> +	}
> +
> +	return seen_used ? 0 : -EIO;
> +}
> +
> =C2=A0static int __hfsplus_ext_write_extent(struct inode *inode,
> =C2=A0		struct hfs_find_data *fd)
> =C2=A0{
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 7c53832f2784..3290812c0fea 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -230,10 +230,15 @@ struct hfsplus_inode_info {
> =C2=A0#define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent
> tree */
> =C2=A0#define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the
> allocation file */
> =C2=A0#define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the
> attributes tree */
> +#define HFSPLUS_I_CORRUPT_TREE	5	/* tree's fork had corrupt
> extents at open time */
>=20
> =C2=A0#define HFSPLUS_IS_RSRC(inode) \
> =C2=A0	test_bit(HFSPLUS_I_RSRC, &HFSPLUS_I(inode)->flags)
>=20
> +/* Test HFSPLUS_I_CORRUPT_TREE on the tree's own inode */
> +#define HFSPLUS_TREE_IS_CORRUPT(tree) \
> +	test_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I((tree)->inode)-
> >flags)
> +
> =C2=A0static inline struct hfsplus_inode_info *HFSPLUS_I(struct inode
> *inode)
> =C2=A0{
> =C2=A0	return container_of(inode, struct hfsplus_inode_info,
> vfs_inode);
> @@ -443,6 +448,7 @@ int hfsplus_free_fork(struct super_block *sb, u32
> cnid,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hfsplus_fork_raw *fork, int=
 type);
> =C2=A0int hfsplus_file_extend(struct inode *inode, bool zeroout);
> =C2=A0void hfsplus_file_truncate(struct inode *inode);
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext);
>=20
> =C2=A0/* inode.c */
> =C2=A0extern const struct address_space_operations hfsplus_aops;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index ff7d6b3336a6..a1669bd45701 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -400,6 +400,14 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			pr_warn("filesystem is marked journaled,
> leaving read-only.\n");
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> +		} else if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
> +				HFSPLUS_TREE_IS_CORRUPT(sbi-
> >cat_tree) ||
> +				(sbi->attr_tree &&
> +				 HFSPLUS_TREE_IS_CORRUPT(sbi-
> >attr_tree))) {
> +			/* Re-checks the flag hfs_btree_open() set
> at mount */
> +			pr_warn("a b-tree fork was corrupt at mount
> time, leaving read-only.\n");
> +			sb->s_flags |=3D SB_RDONLY;
> +			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> =C2=A0	}
> =C2=A0	return 0;
> @@ -564,6 +572,11 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	}
> =C2=A0	sb->s_xattr =3D hfsplus_xattr_handlers;
>=20
> +	if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
> +	=C2=A0=C2=A0=C2=A0 HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
> +	=C2=A0=C2=A0=C2=A0 (sbi->attr_tree && HFSPLUS_TREE_IS_CORRUPT(sbi-
> >attr_tree)))
> +		sb->s_flags |=3D SB_RDONLY;
> +
> =C2=A0	inode =3D hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
> =C2=A0	if (IS_ERR(inode)) {
> =C2=A0		pr_err("failed to load allocation file\n");
> --
> Thanks,
> Nguyen Ngoc Thang
