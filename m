Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C46B4DF4B4
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789515812; cv=none; b=oRLfmXX6hvhDc2GHwGec+MG9arL4NKUCLgn155jZV1T3wwH8DHP2xk3kzVBaS8bd8PyeCFX4eAcvyQhp5kbjPcEWEVQImUb4Rti9qCkweHQgyvzRB68VS/iCzJRpyWjJDj9MbCVDble+ecxdaxtlGWhDyg+GPOUC2G6/jmKIJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789515812; c=relaxed/simple;
	bh=AkZ/mquUAbTjLRHst2XaA5s+6LdoAMX58wgnGvmwolQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EZV5bX3LUo0Edr+2MBmaZazavODiROqIqNNUcIyOaT9hGTrK8ugO1wa30YbP9ba1eD3EjRWHpUZ+Dp1b9eo10ljpsFJkaFu27xrucGq38h44Ko/exWcAl/psiss+L5rSlJr8Jv834Gnvnqh6SfK9xxSMx6ftlsncExn3L5fcd2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=0myxA3R5; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="0myxA3R5"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d46e4cdcdso1882817b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 16:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1789515809; x=1790120609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=G/Zr8CKz0IioKAvYxwKHiO3Nbvfle1Hi47nbnYM+5uU=;
        b=0myxA3R5X//GK+1YV/HnTt9xAL8Cz+bRWL65WPmq24MmPx+whrfeL90IRgx9UG78qr
         63Qa/uP9dCh6vS/hb35vQStpgVTs10dR0TKIGgcehtanQqk07thzdsjwLc7y7JVIX2zK
         kSh9UA339TGpUjZjZjJhFsaF9LJyESVkhixT7FW5Npd2KSMgDEhVEBlxIzrTF0PQW197
         bNsNM+U9sC0GJDKL/fbsNj5TXtrInHdyQJA+LHO2s32wIY2ITCFt/ASnd6Jw8h9NrDpS
         AfTbq3qu2GvyJGkLdqlvSDvlPfzAVZtdge6Rl6mrkFUnRVkzBpF47MP3JZXsTX3kpxg1
         nXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789515809; x=1790120609;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=G/Zr8CKz0IioKAvYxwKHiO3Nbvfle1Hi47nbnYM+5uU=;
        b=aLbeqpiSblUi42wIxGHMNcc5Nsbp6GjapdI040dqdYOkhA0W+vGQjKCMqm5fkqE7xx
         C/2kCL+S7pmaDl1HI2kcBMYGjdSOJjPUEFNmYN6BCcUXi3ODS6CCHMQQTt+hQNP99sgD
         oU5C57P9+a7qc9TWh6F/dnbMsxhwWAosc1oj23tG9PIAoUw7Z4AaoIxau2VF2hg0p/7o
         LKULCm0x0DuWhmtXWB+EcyjdJpo+aH5ZDKVuetaurWUayk34VMWCRmUEwl9Z7sFwkxaN
         u7lmDUCkTkyO5TVloUJqJCmivkRHF5TAZtcrdxLYEr3Nv9M4eTZPXMLTNd4vIagOu1yJ
         dY5w==
X-Forwarded-Encrypted: i=1; AKwUvBwzyT1Clzpy1Va+eNQrb0cYFPNvmPjmRjEqmVCa0Cgh0V1u7CcsoWNnmo+pnu4Uri1JqP4ijdSar5gI66Mp@vger.kernel.org
X-Gm-Message-State: AFuF++kCX1QevIIZWtZy3FmRij1ZxXwF4urwqAulLo70HclxX2triqQe
	JDXadRNTqtIFktnspw5N8eg9MXGyoxwD0B2CoMYvjts4S6A4Tf3K96HnUpWDqxfLX4E=
X-Gm-Gg: AYBFou1KyAn8qzUYDQr4CSCdNon/3qtY4eF38jgluYCKE0wyc7/iZlGnRZ3KHZfhXU5
	0+o+TzgkiR6K2pUTow3euvglUCFPE95hNJnWRLZtTfXOfxbOegvDfm9wZdPKNnnORqAmKvxdILQ
	j6MQn5Su1WmPcgBzkqX6scmJ8L2m9gY5oaPgTk6lyFiXQWO8w8LoGHJoop9XtNJxNK1efDIajxf
	RUWG5+NhDlACr61QgKIB8Gk6amCi6eISpFD2c4HjHCqSI3UILO9T4IPbNQvN7Y+5JVVarXMxyK1
	O9huN5moWGkkwlUcXZNRqnHhtb+MnQtIeeE+CHRLLts7AW3JMT/OL5gmnI+hb6YB93wXFSyO49G
	62MxU97Ipc1nhntZBfDa928EqmqjB1FnPCldNMkJeDldtCLRK+4WZZaEJcmp99Dx7s9JAYXtTdI
	Fmzdq1wfCkqQbxFmbsXMgduXiAaJlr9s5pH8IIoll8pBV18u5CrZutVrKMuuJEiTL1FccRPZfxa
	kGxFfx6BZ8qWpqMa/QbVaY6yK5U0SVc74U6uX6/LV87PU9EKDG70tbnRWZBrvTk7CJF2AATk4vT
	wnSpocCwrY0ettOYKJrpeJ7iKzChHm2yyT0NToozaoBsGvHbuYdl/0iRqJbzMKbk
X-Received: by 2002:a05:690c:e287:20b0:85b:35f6:bc5d with SMTP id 00721157ae682-89221bcf592mr2626177b3.13.1789515809420;
        Tue, 15 Sep 2026 16:43:29 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:e9c6:4a77:70a9:9f1d? ([2600:1700:6476:1430:e9c6:4a77:70a9:9f1d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-891f135b8dcsm2491527b3.42.2026.09.15.16.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 16:43:28 -0700 (PDT)
Message-ID: <d2fe4964f232952f913c9896ef528ab90ea92e2b.camel@dubeyko.com>
Subject: Re: [PATCH v4 1/2] hfsplus: fix recursive tree_lock in
 hfsplus_file_extend()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+f8ce6c197125ab9d72ce@syzkaller.appspotmail.com
Date: Tue, 15 Sep 2026 16:43:27 -0700
In-Reply-To: <20260915140726.17414-1-ngocthang2710.1999@gmail.com>
References: <d66b55454add2f2a48a6dabdb4569051bebb5d42.camel@dubeyko.com>
	 <20260915140726.17414-1-ngocthang2710.1999@gmail.com>
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

On Tue, 2026-09-15 at 21:07 +0700, Nguyen Ngoc Thang wrote:
> Hi Slava,
>=20
> Thanks a lot for the detailed review, this caught a real bug. Replies
> inline, v5 diff at the bottom.
>=20
> > static inline?
> >=20
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 int i;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < 8; ext++, i++)
> >=20
> > I am introducing the special constant for the 8 extents of the fork
> > in
> > HFS+ iomap patchset. How can we handle this? Because I would like
> > to
> > see the named constant instead of hardcoded value.
>=20
> Added HFSPLUS_EXTENT_COUNT in hfsplus_fs.h and used it here. I don't
> know what name you're using in the iomap patchset -- happy to rename
> to match once you let me know, so we don't end up with two constants
> for the same thing when that series lands.

You cannot simply declare the same constant because our patchsets will
conflict. Probably, you need to keep 8 as hardcoded value now. And it
will be good to make the refactoring after my patchset will be in
HFS/HFS+ git tree.

>=20
> I kept hfsplus_ext_fork_full() itself as plain "static", not "static
> inline": it's not a single-line wrapper, and the compiler already
> inlines small static functions like this at -O2, so an explicit
> "inline" in a .c file (as opposed to a header) doesn't buy us
> anything here. I did make the new one-line is_extents_btree() helper
> below "static inline", since that one really is just a trivial
> predicate wrapper.
>=20
> > The comment is not fully correct. We should not be here for the
> > case of
> > Extents Overflow file because there is no forks other than in
> > superblock. It's not about the lock issue. We simply should not be
> > here
> > at all.
>=20
> You're right, fixed. The comment now says: "Per the HFS+ format, the
> extents overflow file is fully described by its own eight fork
> extents and can never have an overflow extent of its own recorded in
> the tree; this function should never legitimately be reached for it."
>=20
> > Maybe, we need to introduce something like is_extents_btree()
> > method?
> > What do you think?
>=20
> Done -- added is_extents_btree() and used it at all three call sites
> in this patch (hfsplus_ext_read_extent(), the fork-full check in
> hfsplus_file_extend(), and the insert_extent backstop).
>=20
> > It looks like complicated condition and it deserves a static inline
> > function, from my point of view.
>=20
> Extracted into hfsplus_ext_file_needs_contig_grow().
>=20
> > Maybe, instead of this long comment we need to introduce a
> > dedicated
> > method for processing Extents Overflow file allocation case?
>=20
> Extracted into hfsplus_ext_file_grow(), replacing the inline comment
> with a doc comment on the function itself.
>=20
> > Maybe, I am missing something here. But goal + 1 sounds like we
> > request
> > to allocate only one block. Is it correct? If yes, why only one
> > block?
> > Usually, we need to try to allocate a clumpSize.
>=20
> You're right, and this was an actual bug, not just a readability
> issue. I traced hfsplus_block_allocate(): the `size` argument bounds
> both where the scan stops *and* the returned run length via
> `len =3D min(size - start, len)`. With `size =3D goal + 1` and
> `start =3D goal`, that clamps `len` to 1 no matter what clump_blocks
> was, so this path only ever allocated a single block. Fixed to use
> `goal + *len` (the original clump_blocks) as the bound instead, in
> hfsplus_ext_file_grow(). That keeps the "must start exactly at goal"
> rejection (still checked via `start !=3D goal` by the caller) while
> allowing a full clump to be granted when the space is there.
>=20
> > Can we be here at all? If start !=3D goal, then we cannot allocate at
> > all. And we can be here only if we have empty slot it the fork. Am
> > I
> > right?
>=20
> The other way around: this branch is taken when
> hfsplus_ext_fork_full() returns true, i.e. there is *no* free slot
> left in the fork. If there is a free slot, we fall through to the
> regular allocate-anywhere path and hfsplus_add_extent() just records
> it in that slot -- no special-casing needed. I renamed the condition
> to hfsplus_ext_file_needs_contig_grow() to make that unambiguous.
>=20
> > checkpatch.pl --strict flags one alignment style issue [...]
> > continuation should align with the open paren =E2=80=94 cosmetic only
>=20
> Fixed.
>=20
> Thanks again for catching the goal+1 bug in particular -- v5 below.

I cannot treat as a v5 of the patch because it's not the patch but
simple discussion. And it makes the review process really complicated.
Please, don't mess the discussion with the formal patches.

>=20
> ---
> Changes since v4:
> =C2=A0- Fix hfsplus_file_extend() requesting only 1 block instead of a
> =C2=A0=C2=A0 full clump when growing the extents overflow file's fork
> =C2=A0=C2=A0 (goal + 1 -> goal + len in the block_allocate() call).
> =C2=A0- Add HFSPLUS_EXTENT_COUNT instead of hardcoding 8.
> =C2=A0- Add is_extents_btree() instead of repeating the i_ino comparison.
> =C2=A0- Extract hfsplus_ext_file_needs_contig_grow() and
> =C2=A0=C2=A0 hfsplus_ext_file_grow() out of hfsplus_file_extend().
> =C2=A0- Fix comment on the HFSPLUS_EXT_CNID guard in
> =C2=A0=C2=A0 hfsplus_ext_read_extent() to state the real reason.
> =C2=A0- Fix checkpatch --strict alignment nit on pr_err() continuation.
> (all per Slava's review)
>=20
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d18..f3a4b8fd567f 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -84,6 +84,23 @@ static u32 hfsplus_ext_lastblock(struct
> hfsplus_extent *ext)
> =C2=A0	return be32_to_cpu(ext->start_block) + be32_to_cpu(ext-
> >block_count);
> =C2=A0}
>=20
> +/* True if the inode is the extents overflow file's own inode */

This comment is useless because the name is informative enough.

> +static inline bool is_extents_btree(struct inode *inode)
> +{
> +	return inode->i_ino =3D=3D HFSPLUS_EXT_CNID;
> +}
> +
> +/* True if all extents of a fork are in use (no free slot left) */

I assume that you are practicing AI assistant a lot. Please, clean upo
useless comments after this stuff. The name of function is informative
enough.

> +static bool hfsplus_ext_fork_full(struct hfsplus_extent *ext)

hfsplus_fork_full()...

If you would like to be sure that fork is not corrupted and it is full,
then you need to analyze the fork structure. Otherwise, it is enough to
check the latest extent in the fork.

> +{
> +	int i;
> +
> +	for (i =3D 0; i < HFSPLUS_EXTENT_COUNT; ext++, i++)
> +		if (!ext->block_count)
> +			return false;
> +	return true;
> +}
> +
> =C2=A0static int __hfsplus_ext_write_extent(struct inode *inode,
> =C2=A0		struct hfs_find_data *fd)
> =C2=A0{
> @@ -217,6 +234,15 @@ static int hfsplus_ext_read_extent(struct inode
> *inode, u32 block)
> =C2=A0	=C2=A0=C2=A0=C2=A0 block < hip->cached_start + hip->cached_blocks)
> =C2=A0		return 0;
>=20
> +	/*
> +	 * Per the HFS+ format, the extents overflow file is fully
> +	 * described by its own eight fork extents and can never
> have an
> +	 * overflow extent of its own recorded in the tree; this
> function
> +	 * should never legitimately be reached for it.
> +	 */
> +	if (is_extents_btree(inode))
> +		return -ENOSPC;
> +
> =C2=A0	res =3D hfs_find_init(HFSPLUS_SB(inode->i_sb)->ext_tree, &fd);
> =C2=A0	if (!res) {
> =C2=A0		res =3D __hfsplus_ext_cache_extent(&fd, inode, block);
> @@ -392,6 +418,34 @@ static int hfsplus_free_extents(struct
> super_block *sb,
> =C2=A0	}
> =C2=A0}
>=20
> +/*
> + * True when growing the extents overflow file's own inode needs the
> + * contiguous-only special case below: its fork's eight extents are
> + * all in use, so there is no free slot left to record a new extent
> + * for it.
> + */

Comment is longer than the function itself. It is not necessary at all.

> +static bool hfsplus_ext_file_needs_contig_grow(struct inode *inode,
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct
> hfsplus_inode_info *hip)

is_ext_file_need_grow() ?

> +{
> +	return is_extents_btree(inode) &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hip->alloc_blocks =3D=3D hip->firs=
t_blocks &&
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfsplus_ext_fork_full(hip->first_e=
xtents);
> +}
> +
> +/*
> + * Allocate blocks to grow the extents overflow file itself once its
> + * fork is full (see hfsplus_ext_file_needs_contig_grow()). Per the
> + * HFS+ format this file can never record an overflow extent of its
> + * own, so the only way to grow it further is a contiguous extension
> + * of the last extent already in the fork: search for up to *len
> free
> + * blocks starting exactly at goal, and return a start block other
> + * than goal if the block at goal itself isn't free.
> + */

Ditto.

> +static u32 hfsplus_ext_file_grow(struct super_block *sb, u32 goal,
> u32 *len)
> +{
> +	return hfsplus_block_allocate(sb, goal + *len, goal, len);
> +}

This doesn't make sense at all.

> +
> =C2=A0int hfsplus_free_fork(struct super_block *sb, u32 cnid,
> =C2=A0		struct hfsplus_fork_raw *fork, int type)
> =C2=A0{
> @@ -465,13 +519,21 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	}
>=20
> =C2=A0	len =3D hip->clump_blocks;
> -	start =3D hfsplus_block_allocate(sb, sbi->total_blocks, goal,
> &len);
> -	if (start >=3D sbi->total_blocks) {
> -		start =3D hfsplus_block_allocate(sb, goal, 0, &len);
> -		if (start >=3D goal) {
> +	if (hfsplus_ext_file_needs_contig_grow(inode, hip)) {
> +		start =3D hfsplus_ext_file_grow(sb, goal, &len);
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

This didn't make the situation better. Probably, all this piece of code
should be one function.

>=20
> =C2=A0	}
>=20
> =C2=A0	if (zeroout) {
> @@ -526,6 +588,20 @@ int hfsplus_file_extend(struct inode *inode,
> bool zeroout)
> =C2=A0	return res;
>=20
> =C2=A0insert_extent:
> +	/*
> +	 * The fork-full precheck above keeps the extents overflow
> file's
> +	 * own inode from ever landing here with blocks already
> allocated;
> +	 * this is a backstop, so still free what was allocated
> rather
> +	 * than leak it.
> +	 */
> +	if (is_extents_btree(inode)) {
> +		if (hfsplus_block_free(sb, start, len))
> +			pr_err("can't free extent: start %u, count
> %u\n",
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 start, len);
> +		res =3D -ENOSPC;
> +		goto out;
> +	}

It's hard to discuss if you are moving discussion out of the code. My
question still the same here. Because I cannot connect your answer with
my question and code.

Thanks,
Slava.=20

> +
> =C2=A0	hfs_dbg("insert new extent\n");
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	if (res)
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 1e5b58e6a13f..7c53832f2784 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -24,6 +24,9 @@
> =C2=A0#define HFSPLUS_TYPE_DATA 0x00
> =C2=A0#define HFSPLUS_TYPE_RSRC 0xFF
>=20
> +/* Number of extent slots in a fork (hfsplus_extent_rec,
> hfs_common.h) */
> +#define HFSPLUS_EXTENT_COUNT 8
> +
> =C2=A0typedef int (*btree_keycmp)(const hfsplus_btree_key *,
> =C2=A0		const hfsplus_btree_key *);
>=20
> --
> Thanks,
> Nguyen Ngoc Thang
