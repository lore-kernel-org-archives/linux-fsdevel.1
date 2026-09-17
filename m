Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7104A2A58
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789681931; cv=none; b=bd1pNRY5t/keoHp4CDSNsvDkeve9kHTiQLzAKatbubsYaULG7B7eqw9a69eVy6C1gdPvrOt9It40To3NLGmALwxL21mhO6vLKUQOJSqKdzrumzeqPn4AVAxDFl8UHpMH6pjcBK3kLP+A/cJ7SIJFuo1T4/Nl84l4fwkaN1ZJG4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789681931; c=relaxed/simple;
	bh=net0pa2pbzPos7UmBdZuercedWspshQEWw45dNvWa/Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mw3hOeyDXFwXJ45bOG7wYTEZ+NwLx5F4SOSfz0gEfExwLy6veHQqJSXV+Qvr6E6HRe6blwTMnrVLg1/dlf197G09NPFifr2GXwgO1VOxJbEWh3+Voe1v29WLnGjPSuIX8Wor2t94Q5T0b9cLVWyo7q97+zB9oFxeco3GqRyLxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=fA/oJyH8; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="fA/oJyH8"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so1382087b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Sep 2026 14:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789681926; x=1790286726; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Eiv1BsznVl9/gEHHiJSgDFAJFpQkdu9UMYV326DNnX4=;
        b=fA/oJyH8Nte0EchHmSzjwHTODvxfUABKuKrc5bW7jdERdkKTCOgca/BOtBfUb/aFau
         aohhXMu3t515KFhwfuLgYOPTAetdgcYKfLFJRpo4kI+tIAUTwgZkq+cXfIkoqt/l7kCB
         8oWXRyFRKyeKGn/q918Zz5ecba1rMNFQ5mwUFQ1VwjckaeOIIe8fuFgA7rdlknIm5eLv
         h46smj6ZJ121CMLmrKXx1jYG4c/siGcWUep50t7gbN9E2Vti/u9JbnVege+clZkuI9aR
         KMDBAya9KtSrnbVQxk6/uqfkdCo6XDF8y/mICpcMC2GbcUKwAuIEaERbQ+LX9Nk6OKph
         jIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789681926; x=1790286726;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Eiv1BsznVl9/gEHHiJSgDFAJFpQkdu9UMYV326DNnX4=;
        b=b/rowlp5zObNDH0zx+pKMUS/l4ObbZAjbafbBQwrDPLJFIk0uzZCjiJ8s1kxr9pK74
         fpzKVonh7zX7C8Ib6kJzGSRS17gCx9r4DILH3ameS4kdBNNc5eZWw0I4tOBn30qfmwOz
         4PQ1wpnv4kcGDceldxsd/FmuSfqWU/RLSKxoXVzo0u0wgyuWizxXbqUNij1Lc5Az3eJ6
         hqDAvQgTJSQs4dLQAiKwWtxWuwj1edNkNWWb7BtHkSYlundk1po2ZTkgMEkaQGjKgEZh
         LiyoUSP2ww02rW+h9BsYo4ROsL73Jjd8l2h72l9OIRNKXdK6jthoRRx4aac4p54Mawkr
         m4WQ==
X-Forwarded-Encrypted: i=1; AKwUvBw0rMELsERLZVxPGVjYl+9HslPxbKS/slveOUWNKov3TwF8PvcfCLHEmzOfawU6oq0odTGwHkISCjVu2bpx@vger.kernel.org
X-Gm-Message-State: AFuF++ld9YUmoEKNt8uzuJH+LdryhmC8CQh9De7WzToS7ZySrkC7A5s3
	dIJXZE4sP7mQmCEXdJtRB88QsmEgElXSN6GFomvd14OpNICZxA8vGqDpoQFpijoYb62m1p9iOvx
	KbP75euw=
X-Gm-Gg: AYBFou3f5fci4iFDORV5eA7OTItrX1TDB72jc2xhNxz6rLwfL1q3IgGl39zTKtuFTy9
	EbiWZlb3Bsk5azu2MkkM5dsMKcoWdcdAYSRiqtQN7EOxZT7RXmjykwOcw+9e64yHWTfbR/e2fgO
	9g3mCmk81/YzWm2nQbmXnG3QELfEWciOPB7xAtBfBld42Bwc5c8UiGuyEdBGpMoUoXjV1Nt20K5
	Gz0wBgJWQ4L8orTI/7d54ojlzoQ4FXenJwyrGQ2FwUV75jBjDAu01Q064BeXEgUBwiZMLheD+ja
	kZbzwE1j+vzjNcrkC7TGdhFUMywykFvsmQcRBIHd7cVys+DBPT3xHhDeNrrMeAG+CfIw6ypH32m
	UxIKLbslNbw6Cofi3PU+7YVP2/QWqhJuprYKsLS9P61Ys3OLUejkd2QygTjb76Uda3qZG/xSkZU
	c8So+jHHYdgy8HpDRnyg3YX+bVjk8fdMDkuQ5BEHgLhv9FMFd10Yq7vG3Hvf20SehEs2ffUx8fO
	VOEPIjv6rCagZf5x+i7OHEZiC/ZUfg5eMEIghaSzvoMTzy1viCKMo6rE8KnaH7MROHKGxj53SUN
	ria6/wV9EsirK39KXadjuIcDOZtrDU6nWil3Yc8MscUCFhe8sqNa1pARWWlcX+cg
X-Received: by 2002:a05:690c:d94:b0:873:5bd1:98b7 with SMTP id 00721157ae682-89736a419f4mr1576597b3.41.1789681926261;
        Thu, 17 Sep 2026 14:52:06 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:b801:b375:5db3:9ec3? ([2600:1700:6476:1430:b801:b375:5db3:9ec3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-896cbd841d2sm3701247b3.43.2026.09.17.14.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 14:52:04 -0700 (PDT)
Message-ID: <e7ee167c159c1d8ece4bc6e9cb0b382f6a0c4086.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfsplus: fix recursive tree_lock and validate b-tree
 fork extents at mount
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Thu, 17 Sep 2026 14:52:03 -0700
In-Reply-To: <20260917120637.18959-1-ngocthang2710.1999@gmail.com>
References: <20260917120637.18959-1-ngocthang2710.1999@gmail.com>
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

On Thu, 2026-09-17 at 19:06 +0700, Nguyen Ngoc Thang wrote:
> hfs_bmap_reserve() calls hfsplus_file_extend() on tree->inode with
> tree->tree_lock already held. For the extents overflow B-tree's own
> inode, growing it can call hfsplus_ext_read_extent() ->
> hfs_find_init()
> on that same tree, taking tree_lock a second time (lockdep: "possible
> recursive locking ... &tree->tree_lock/1"). This happens two ways:
>=20
> =C2=A0- the fork already claims more blocks than its eight extents
> =C2=A0=C2=A0 describe (a corrupted on-disk fork), so hfsplus_ext_read_ext=
ent()
> =C2=A0=C2=A0 is called immediately to look up the rest; or
> =C2=A0- the fork's eight extents get exhausted during this call, and
> =C2=A0=C2=A0 inserting a new overflow extent record for the file would ne=
ed
> =C2=A0=C2=A0 the same lookup.
>=20
> Per the HFS+ format the extents overflow file is fully described by
> its eight fork extents and can never legitimately have overflow
> extents of its own, so both cases mean it cannot grow any further.
>=20
> Add is_extents_btree() and use it at the one place that actually
> re-enters hfs_find_init(), hfsplus_ext_read_extent(), to report
> -ENOSPC instead of recursing.
>=20
> For the second case, don't allocate blocks on the chance the fork
> still has room and undo it if not: hfsplus_fork_full() tests the
> fork first (its last extent is occupied). If it does have a free
> slot, any free space works, same as before. If it's already full,
> the only way to grow is a contiguous extension of the last extent,
> so only search for free space starting exactly at the block right
> after it, and fail with -ENOSPC immediately if that block isn't
> free. A WARN_ON_ONCE() backstop stays at the insert_extent label:
> the fork-full check below should make it unreachable for this
> inode, so warn loudly if that invariant ever breaks instead of
> recursing on tree_lock again.
>=20
> To back that invariant, hfsplus_check_fork() now validates each
> b-tree's fork extents at mount time, from hfs_btree_open(). It
> catches:
>=20
> =C2=A0- block_count =3D=3D 0 but start_block !=3D 0: garbage left in a sl=
ot
> =C2=A0=C2=A0 that should be blank (this is what the syzbot-reported image=
 has
> =C2=A0=C2=A0 in the extents overflow file's fork, slots 3 and 6);
> =C2=A0- start_block + block_count > sbi->total_blocks: an extent pointing
> =C2=A0=C2=A0 past the end of the volume, or overflowing u32;
> =C2=A0- a non-zero extent following a zero one: a hole in the used range;
> =C2=A0- the sum of the used extents' block_count disagreeing with the
> =C2=A0=C2=A0 fork's own declared total_blocks.
>=20
> If the first extent itself fails these checks, the b-tree's location
> on disk is unknown and there is nothing to recover, so
> hfs_btree_open()
> fails as it already does for the other structural checks in that
> function, and the mount fails.
>=20
> If only a later extent is affected, the tree can still be opened (its
> first extent, and hence its root node, is fine); mark it corrupt and
> let the caller decide. hfsplus_fill_super() forces the volume
> read-only in that case, and hfsplus_reconfigure() checks the same
> per-tree flag on remount instead of re-deriving it, refusing to go
> back to read-write. attr_tree may be NULL (volumes without an
> attributes fork), so both checks guard for that. The corruption state
> is tracked as a HFSPLUS_I_CORRUPT_TREE bit on the b-tree's own inode,
> next to the existing per-tree HFSPLUS_I_*_DIRTY flags, since one
> inode
> already maps to one tree.
>=20
> This mount-time check is what makes the WARN_ON_ONCE() above
> unreachable in practice: a fuzzed or damaged fork like the one in the
> syzbot report is now caught here before any write ever reaches it.
>=20
> Reported-by: syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
> Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> ---
> =C2=A0fs/hfsplus/btree.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 83
> +++++++++++++++++++++++++++++++++++++++--
> =C2=A0fs/hfsplus/hfsplus_fs.h |=C2=A0 6 +++
> =C2=A0fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 13 +++++++
> =C2=A04 files changed, 111 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
> index 2ea8cd5658e1..7f922e424a36 100644
> --- a/fs/hfsplus/btree.c
> +++ b/fs/hfsplus/btree.c
> @@ -274,6 +274,7 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0	struct inode *inode;
> =C2=A0	struct page *page;
> =C2=A0	unsigned int size;
> +	int res;
> =C2=A0
> =C2=A0	tree =3D kzalloc_obj(*tree);
> =C2=A0	if (!tree)
> @@ -293,6 +294,18 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id)
> =C2=A0		goto free_inode;
> =C2=A0	}
> =C2=A0
> +	res =3D hfsplus_check_fork(sb, HFSPLUS_I(tree->inode)-
> >first_extents,
> +				 HFSPLUS_I(tree->inode)-
> >alloc_blocks);

I still insist on checking fork. Even here you can use HFSPLUS_SB(sb)
and then you can access s_vhdr [1]. The struct hfsplus_vh contains all
forks [2]. We have corrupted volume and it means that we need to check
the on-disk layout data structures.

I started to think that, maybe, we need to place the fork check into
hfsplus_inode_read_fork() or hfsplus_system_read_inode(). Because,
potentially, any fork can be corrupted and we can add the check for all
forks under processing. What do you think?

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

So, if we move the check, then hfsplus_iget() [3] can return error and
we can mark b-tree as corrupted.

> +	}
> +
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	page =3D read_mapping_page(mapping, 0, NULL);
> =C2=A0	if (IS_ERR(page))
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d18..5b6839918eef 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -84,6 +84,54 @@ static u32 hfsplus_ext_lastblock(struct
> hfsplus_extent *ext)
> =C2=A0	return be32_to_cpu(ext->start_block) + be32_to_cpu(ext-
> >block_count);
> =C2=A0}
> =C2=A0
> +static inline bool is_extents_btree(struct inode *inode)
> +{
> +	return inode->i_ino =3D=3D HFSPLUS_EXT_CNID;
> +}
> +
> +static bool hfsplus_extent_valid(struct hfsplus_extent *ext, u32
> total_blocks)

The total_blocks sounds slightly not obvious. Maybe, something like
volume_blocks?

> +{
> +	u32 start =3D be32_to_cpu(ext->start_block);
> +	u32 count =3D be32_to_cpu(ext->block_count);
> +
> +	if (!count)

It is better to use count =3D=3D 0. Because, this type of technique is for
pointers used usually.

> +		return start =3D=3D 0;
> +
> +	return start + count > start && start + count <=3D
> total_blocks;

I think that start + count > start doesn't make sense because it is
always true.

> +}
> +
> +/*
> + * Returns 0 if the fork's extents are consistent, -EUCLEAN if only
> + * extents past the first are corrupt (safe to mount read-only), or
> + * -EIO if the first extent is corrupt or the fork has no used
> extent.
> + */
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 total_blocks)

Let's check the fork because not only extents can be corrupted but the
first part of the fork too.

> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	bool seen_hole =3D false;

The seen_hole doesn't sounds good. Because, it could sound confusing
because it is possible to think about holes support in file system
logic. But it is no the case here.

> +	u32 used_blocks =3D 0;
> +	int i;
> +
> +	for (i =3D 0; i < 8; i++, ext++) {
> +		u32 count =3D be32_to_cpu(ext->block_count);
> +
> +		if (!hfsplus_extent_valid(ext, sbi->total_blocks) ||
> +		=C2=A0=C2=A0=C2=A0 (seen_hole && count))
> +			return i ? -EUCLEAN : -EIO;

The EFSCORRUPTED sounds better. But does it makes difference if we have
-EIO or -EUCLEAN? Why do we introduce two error codes?

> +
> +		if (count)
> +			used_blocks +=3D count;
> +		else
> +			seen_hole =3D true;
> +	}
> +
> +	if (!used_blocks)
> +		return -EIO;
> +
> +	return used_blocks =3D=3D total_blocks ? 0 : -EUCLEAN;
> +}
> +
> =C2=A0static int __hfsplus_ext_write_extent(struct inode *inode,
> =C2=A0		struct hfs_find_data *fd)
> =C2=A0{
> @@ -217,6 +265,9 @@ static int hfsplus_ext_read_extent(struct inode
> *inode, u32 block)
> =C2=A0	=C2=A0=C2=A0=C2=A0 block < hip->cached_start + hip->cached_blocks)
> =C2=A0		return 0;
> =C2=A0
> +	if (is_extents_btree(inode))
> +		return -ENOSPC;
> +
> =C2=A0	res =3D hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
> =C2=A0	if (!res) {
> =C2=A0		res =3D __hfsplus_ext_cache_extent(&fd, inode, block);
> @@ -392,6 +443,11 @@ static int hfsplus_free_extents(struct
> super_block *sb,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static bool hfsplus_fork_full(struct hfsplus_extent *ext)

Let's do this check for the fork. Because, ext argument looks really
confusing. How can you have 7th item in the extent? Do we have only one
extent or array of extents here? How can we distinguish these cases
here?

> +{
> +	return ext[7].block_count !=3D 0;

Ahhh, I really dislike this 7 hardcoded. :) You can introduce the named
constant for the index of last extent in the fork. I never introduced
this constant before.

> +}
> +
> =C2=A0int hfsplus_free_fork(struct super_block *sb, u32 cnid,
> =C2=A0		struct hfsplus_fork_raw *fork, int type)
> =C2=A0{
> @@ -465,13 +521,23 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	}
> =C2=A0
> =C2=A0	len =3D hip->clump_blocks;
> -	start =3D hfsplus_block_allocate(sb, sbi->total_blocks, goal,
> &len);
> -	if (start >=3D sbi->total_blocks) {
> -		start =3D hfsplus_block_allocate(sb, goal, 0, &len);
> -		if (start >=3D goal) {
> +	if (is_extents_btree(inode) && hip->alloc_blocks =3D=3D hip-
> >first_blocks &&
> +	=C2=A0=C2=A0=C2=A0 hfsplus_fork_full(hip->first_extents)) {
> +		/* Full fork, no overflow extent possible: goal or
> nothing */
> +		start =3D hfsplus_block_allocate(sb, goal + len, goal,
> &len);
> +		if (start !=3D goal) {
> =C2=A0			res =3D -ENOSPC;
> =C2=A0			goto out;
> =C2=A0		}
> +	} else {
> +		start =3D hfsplus_block_allocate(sb, sbi-
> >total_blocks, goal, &len);
> +		if (start >=3D sbi->total_blocks) {
> +			start =3D hfsplus_block_allocate(sb, goal, 0,
> &len);
> +			if (start >=3D goal) {
> +				res =3D -ENOSPC;
> +				goto out;
> +			}
> +		}

I think maybe we need to introduce the method for this piece of code.

> =C2=A0	}
> =C2=A0
> =C2=A0	if (zeroout) {
> @@ -526,6 +592,15 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	return res;
> =C2=A0
> =C2=A0insert_extent:
> +	/* Can't happen: the fork-full check above rules this out */

I don;t quite follow why it cannot happen. Let's imagine we had fork
with one extent during mkfs phase. Then, we start to grow the Extents
Overflow tree. It sounds to me that we need to insert the extent
because we still have free spots in the fork. Am I wrong?

> +	if (WARN_ON_ONCE(is_extents_btree(inode))) {
> +		if (hfsplus_block_free(sb, start, len))
> +			pr_err("can't free extent: start %u, count
> %u\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, len);
> +		res =3D -ENOSPC;
> +		goto out;
> +	}
> +
> =C2=A0	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	if (res)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1e5b58e6a13f..af36f2faf286 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -227,10 +227,14 @@ struct hfsplus_inode_info {
> =C2=A0#define HFSPLUS_I_EXT_DIRTY	2	/* has changes in the extent
> tree */
> =C2=A0#define HFSPLUS_I_ALLOC_DIRTY	3	/* has changes in the
> allocation file */
> =C2=A0#define HFSPLUS_I_ATTR_DIRTY	4	/* has changes in the
> attributes tree */
> +#define HFSPLUS_I_CORRUPT_TREE	5	/* tree's fork ha
> d corrupt extents at open time */

B-tree can be corrupted because of multiple reasons. This comment
doesn't looks good.

> =C2=A0
> =C2=A0#define HFSPLUS_IS_RSRC(inode) \
> =C2=A0	test_bit(HFSPLUS_I_RSRC, &HFSPLUS_I(inode)->flags)
> =C2=A0
> +#define HFSPLUS_TREE_IS_CORRUPT(tree) \
> +	test_bit(HFSPLUS_I_CORRUPT_TREE, &HFSPLUS_I((tree)->inode)-
> >flags)
> +
> =C2=A0static inline struct hfsplus_inode_info *HFSPLUS_I(struct inode
> *inode)
> =C2=A0{
> =C2=A0	return container_of(inode, struct hfsplus_inode_info,
> vfs_inode);
> @@ -440,6 +444,8 @@ int hfsplus_free_fork(struct super_block *sb, u32
> cnid,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hfsplus_fork_raw *fork, int=
 type);
> =C2=A0int hfsplus_file_extend(struct inode *inode, bool zeroout);
> =C2=A0void hfsplus_file_truncate(struct inode *inode);
> +int hfsplus_check_fork(struct super_block *sb, struct hfsplus_extent
> *ext,
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 total_blocks);
> =C2=A0
> =C2=A0/* inode.c */
> =C2=A0extern const struct address_space_operations hfsplus_aops;
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index ff7d6b3336a6..b6a85c153cf3 100644
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

We can expect only xatts b-tree is corrupted here because Catalog b-
tree and Extents Overflow b-tree have been checked during mount time.

> +			/* Corruption is only ever detected at
> mount, in hfs_btree_open() */
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
> =C2=A0
> +	if (HFSPLUS_TREE_IS_CORRUPT(sbi->ext_tree) ||
> +	=C2=A0=C2=A0=C2=A0 HFSPLUS_TREE_IS_CORRUPT(sbi->cat_tree) ||
> +	=C2=A0=C2=A0=C2=A0 (sbi->attr_tree && HFSPLUS_TREE_IS_CORRUPT(sbi-
> >attr_tree)))
> +		sb->s_flags |=3D SB_RDONLY;
> +


If hfs_btree_open() fails to create the b-tree, then we should jump to
the end because there is no valid b-tree object.


	sbi->ext_tree =3D hfs_btree_open(sb, HFSPLUS_EXT_CNID);
	if (!sbi->ext_tree) {
		pr_err("failed to load extents file\n");
		goto out_free_vhdr;
	}

I think we need to analyze the returned error here. And flags check
doesn't make a lot of sense, frankly speaking. What do you think?

Thanks,
Slava.=20

> =C2=A0	inode =3D hfsplus_iget(sb, HFSPLUS_ALLOC_CNID);
> =C2=A0	if (IS_ERR(inode)) {
> =C2=A0		pr_err("failed to load allocation file\n");

[1]
https://elixir.bootlin.com/linux/v7.3-rc3/source/fs/hfsplus/hfsplus_fs.h#L1=
13
[2]
https://elixir.bootlin.com/linux/v7.3-rc3/source/include/linux/hfs_common.h=
#L267
[3]
https://elixir.bootlin.com/linux/v7.3-rc3/source/fs/hfsplus/btree.c#L286
