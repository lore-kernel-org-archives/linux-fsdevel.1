Received: from mail-yx2-f40.google.com (mail-yx2-f40.google.com [74.125.224.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98144D9F8F
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Oct 2026 19:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228778; cv=none; b=DXq7/LYoPhJvoczdrNLJ0cQm19gGA6jloKaYEbUuTHOZ8qakYOM+Lbntj8EMPTQ8xhZc59BN0H6EeRpxwWh8gsrxKYoed8dke35YG6qfO68zL7jBQdfRQE3scFI73gWOtF/LgyqJOHEX9llZe8tr9d/x6o+loY0Rt9w2SuucZ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228778; c=relaxed/simple;
	bh=OhTg4Y2vk0E5SNiIImYpc2ywh+/0Gl7CDRpjajw6YFE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nFRdtMrNTcg2eY+jvkqvhIt8sIPows0ERQ6L1aTfGhRtVtiYohbQG2rUrgdcXkDZiONHhxgvNK/nx6WXi72KM/IL+2oRlUIW2PM8v6XTNVnQhG8eFY3y8que1rGE91B94+1TKqhEa3I8fPZ9hYYvX/tKFaIdcSoYDkzaSkXDSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=eVr5Qme1; arc=none smtp.client-ip=74.125.224.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="eVr5Qme1"
Received: by mail-yx2-f40.google.com with SMTP id 956f58d0204a3-67568357b63so1807432d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 05 Oct 2026 12:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791228775; x=1791833575; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uHYPSvXxOi/i3tWTh3HSQ0/YkL8DNyZX6j4u6SZ8c+0=;
        b=eVr5Qme1Qzz9ymFVoDuX2iAApIFnIjFAl3cON/t0CReeNmj0m9JAzSamn8ojL8rIwz
         ZoSCmwqyDd97iFWexCRh1AXKGU3X/FS+OmXV+5fDrG7Zvpz6VrnFmv9S00rcmwj32RzN
         Co1uiNe1altrbkGF1poipnGzZGO7u8yh5255A+SY9hKz8AxGEbFuzCkuMU0xmIdDB+cC
         M/C4CyRbwznGotAdhyv1nC0MwDNthOtXrd9eiNGwumcYSRRB3urPUpaY9cSls2O2aywJ
         BlPGa2z7q1NjZFF2jzbbea1rUxvxHR2Dzt49BoSTqcsHoygNJ8XxyL9phUPv9L0Nd/4K
         3K5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791228775; x=1791833575;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uHYPSvXxOi/i3tWTh3HSQ0/YkL8DNyZX6j4u6SZ8c+0=;
        b=HN0SBgsr+U6o48sYYaUTGP7QRdDfjJOWkFthgdn8Y6vQ95aeh+D0BUU0Nel1nUKwMt
         +800G2sBC5ZcpVZf6SjU6WmP+A6QtWzCdHqsGxTqcn7B30aYwj0OvryD5hMlV5Q/4jbr
         wxZI+twOH32CKftRXnRQHOOPj/tTUwyzLfMNCG9ivkmVkvZdlEiPuTHRNeePp8cySGvp
         LkspK/nNoDRcspAXFBeTi8vzGNPDzp4NZmCOT4qrtZG+Eo++9G/U8uDjPBtCdvIVIfQE
         1P5VyNFipiKVTQ32Qkp1rAgCyKIyHu9F4Uqu8fkxh2EOGEI6hd1Suq0VwSXRm+BbEs26
         p2cA==
X-Gm-Message-State: AFq9FYLt9l5xX0zoa01l3/HIjJB3FhXHjESczqGrYiJKc/rRJb/bQLhy
	ICVwB7Zu3iaSN5Y+zN85LZVGlLcudv3Oi1ZoOE6fT1ut17od/3mYicL81JYLl87XN2c=
X-Gm-Gg: AYBFou1TNrtIxvVYohqrXsfKJGy4M/djnYSOWCeyamwPyWBG0nrh6CgQE352ef+VkkW
	VwxjdHkGcyrG7z3rhQXoEr0nhh90u/XVlgNaRoRo1asX4Jk7Az1KU1JhoVT2jeZ0S8SHk+f+OY0
	xE4I6ObMzEMX8qvuOneX82EWnrRdzd3MXDDb8UVTBpxFz7rem++SaY9ExPFbnQSemPzUKy9OHop
	mqMsTXQ/2+RoYXlPLScZ997+IynyMTuKhIpb7nOEWhE2yyfl8t56pF3jxpHSm414NYhAsJ67I/e
	pY0SpRDgmY/wSf2NgHdE+pufI0I54zqz2/Vbnz5LA+QVHOQLBqJzlYsbVWLsoMIsvtVuzRyOkJU
	fwhG9fckG2MFEeRryIuRmd8pKiHFK1U9nVr+ms3OJjPzQfMCzjfYbAJY78zxnUqtSmGBHBA0sRh
	YxKlf0ZYeGutNu6jajhy7vqBVYlCYqjTL2LRx3eO2gP+Hs+Kf6hFkiwXyMPTXgyytlcNxYf8qhm
	4GxVXO2sPlbHfQfnLmPWrCPDtGoBzevkI16RyYhzO4quL1WiP/0eZXAuY7mcuQWfu+FI/E6IMWQ
	ao29gZ1CHd2e2ZOigY5srMUXzZFwTp/AVir4uo4XlPI14uy9J/8xvcoBTJuMdCq7
X-Received: by 2002:a05:690e:1904:b0:677:be91:d866 with SMTP id 956f58d0204a3-677be91e02cmr3509867d50.47.1791228774756;
        Mon, 05 Oct 2026 12:32:54 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:3aa0:911f:4e09:b45d? ([2600:1700:6476:1430:3aa0:911f:4e09:b45d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-677c72dc315sm2895930d50.8.2026.10.05.12.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 12:32:54 -0700 (PDT)
Message-ID: <440b0a696204a1155c0b688518d9907af1d7c491.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfsplus: annotate extents_lock nesting to silence
 lockdep false positive
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Mahmut Emin Kurhan <guvenlik@noroxi.com>
Cc: linux-fsdevel@vger.kernel.org, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Frank Li <frank.li@vivo.com>, 
	linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 12:32:51 -0700
In-Reply-To: <20261002211626.1576625-1-guvenlik@noroxi.com>
References: <8078649d8c1405e0a207d06efe4ec0189d3eef76.camel@dubeyko.com>
	 <20261002211626.1576625-1-guvenlik@noroxi.com>
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

On Fri, 2026-10-02 at 23:16 +0200, Mahmut Emin Kurhan wrote:
> lockdep reports a possible recursive locking on
> HFSPLUS_I(inode)->extents_lock when truncating or extending a file on
> a
> crafted image: the regular file holds its own extents_lock and, while
> freeing or allocating blocks, reads the allocation file, whose
> ->get_block() takes the allocation file's extents_lock.=C2=A0 These are
> two
> different inodes locked in a fixed order, so it is not a real
> deadlock,
> only a missing nesting annotation.
>=20
> tree->cnid and inode->i_ino share the CNID namespace, so fold the
> B-tree tree_lock subclass helper and the extents_lock classification
> into a single hfsplus_lock_class(cnid): the allocation file gets its
> own
> subclass and every other inode uses the default, while the catalog,
> extents and attributes B-trees keep the subclasses they had.=C2=A0 Take
> extents_lock with mutex_lock_nested() at the sites that nest.=C2=A0 A
> genuine
> recursion on one inode's extents_lock -- including the allocation
> file on itself -- is still reported.
>=20
> Found via coverage-guided fuzzing (syzkaller + lockdep) by Noroxi.

Reported-by: tag?

>=20
> Signed-off-by: Mahmut Emin Kurhan <guvenlik@noroxi.com>
> ---
> Slava, this is the reworked version you suggested: one CNID-keyed
> hfsplus_lock_class() serving both the B-tree tree_lock and the inode
> extents_lock, instead of a second enum/function.
>=20
> The B-tree tree_lock keeps CATALOG/EXTENTS/ATTR (same values as
> before).
> For extents_lock the only real nesting is a regular file's
> extents_lock
> (held in truncate/extend) over the allocation file's extents_lock
> (taken
> from its ->get_block() during block alloc/free), so the allocation
> file
> gets its own subclass and everything else uses the default.=C2=A0 That
> also
> drops the FIRSTUSER file/folder ambiguity from v2.
>=20
> One behaviour change worth flagging: hfsplus_lock_class() returns
> HFSPLUS_DEFAULT_MUTEX for an unexpected CNID where the old
> hfsplus_btree_lock_class() called BUG().=C2=A0 The B-tree callers still
> only
> pass CAT/EXT/ATTR, so this affects only the now-shared default path.
> Happy to keep a WARN there if you prefer.
>=20
> v3:
> =C2=A0- rework hfsplus_btree_lock_class() into a single CNID-keyed
> =C2=A0=C2=A0 hfsplus_lock_class() shared by tree_lock and extents_lock (S=
lava
> =C2=A0=C2=A0 Dubeyko); drop the separate enum/function and the FIRSTUSER =
check
> v2:
> =C2=A0- shorten the comment, rename the subclass, use FIRSTUSER
> (superseded)
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/hfsplus/extents.c=C2=A0=C2=A0=C2=A0 | 18 +++++++++++-------
> =C2=A0fs/hfsplus/hfsplus_fs.h | 39 +++++++++++++++++++++-----------------=
-
> =C2=A0fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/hfsplus/xattr.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
> =C2=A05 files changed, 36 insertions(+), 28 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index ca9813f58a..ed72d61f64 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -27,7 +27,7 @@ int hfs_find_init(struct hfs_btree *tree, struct
> hfs_find_data *fd)
> =C2=A0	hfs_dbg("cnid %d, caller %ps\n",
> =C2=A0		tree->cnid, __builtin_return_address(0));
> =C2=A0	mutex_lock_nested(&tree->tree_lock,
> -			hfsplus_btree_lock_class(tree));
> +			hfsplus_lock_class(tree->cnid));
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
> index eb7c11524d..ae1369a4cb 100644
> --- a/fs/hfsplus/extents.c
> +++ b/fs/hfsplus/extents.c
> @@ -150,7 +150,8 @@ int hfsplus_ext_write_extent(struct inode *inode)
> =C2=A0{
> =C2=A0	int res;
> =C2=A0
> -	mutex_lock(&HFSPLUS_I(inode)->extents_lock);
> +	mutex_lock_nested(&HFSPLUS_I(inode)->extents_lock,
> +			=C2=A0 hfsplus_lock_class(inode->i_ino));
> =C2=A0	res =3D hfsplus_ext_write_extent_locked(inode);
> =C2=A0	mutex_unlock(&HFSPLUS_I(inode)->extents_lock);
> =C2=A0
> @@ -261,7 +262,8 @@ int hfsplus_get_block(struct inode *inode,
> sector_t iblock,
> =C2=A0	if (inode->i_ino =3D=3D HFSPLUS_EXT_CNID)
> =C2=A0		return -EIO;
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_lock_class(inode->i_ino));
> =C2=A0
> =C2=A0	/*
> =C2=A0	 * hfsplus_ext_read_extent will write out a cached extent
> into
> @@ -430,7 +432,7 @@ int hfsplus_free_fork(struct super_block *sb, u32
> cnid,
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 total_blocks);
> =C2=A0		total_blocks =3D start;
> =C2=A0		mutex_lock_nested(&fd.tree->tree_lock,
> -			hfsplus_btree_lock_class(fd.tree));
> +			hfsplus_lock_class(fd.tree->cnid));
> =C2=A0	} while (total_blocks > blocks);
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0
> @@ -454,7 +456,8 @@ int hfsplus_file_extend(struct inode *inode, bool
> zeroout)
> =C2=A0		return -ENOSPC;
> =C2=A0	}
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_lock_class(inode->i_ino));
> =C2=A0	if (hip->alloc_blocks =3D=3D hip->first_blocks)
> =C2=A0		goal =3D hfsplus_ext_lastblock(hip->first_extents);
> =C2=A0	else {
> @@ -576,7 +579,8 @@ void hfsplus_file_truncate(struct inode *inode)
> =C2=A0	blk_cnt =3D (inode->i_size + HFSPLUS_SB(sb)->alloc_blksz - 1)
> >>
> =C2=A0			HFSPLUS_SB(sb)->alloc_blksz_shift;
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_lock_class(inode->i_ino));
> =C2=A0
> =C2=A0	alloc_cnt =3D hip->alloc_blocks;
> =C2=A0	if (blk_cnt =3D=3D alloc_cnt)
> @@ -597,7 +601,7 @@ void hfsplus_file_truncate(struct inode *inode)
> =C2=A0			hfsplus_dump_extent(hip->first_extents);
> =C2=A0			hip->first_blocks =3D blk_cnt;
> =C2=A0			mutex_lock_nested(&fd.tree->tree_lock,
> -				hfsplus_btree_lock_class(fd.tree));
> +				hfsplus_lock_class(fd.tree->cnid));
> =C2=A0			break;
> =C2=A0		}
> =C2=A0		res =3D __hfsplus_ext_cache_extent(&fd, inode,
> alloc_cnt);
> @@ -612,7 +616,7 @@ void hfsplus_file_truncate(struct inode *inode)
> =C2=A0				=C2=A0=C2=A0=C2=A0=C2=A0 alloc_cnt - start, alloc_cnt -
> blk_cnt);
> =C2=A0		hfsplus_dump_extent(hip->cached_extents);
> =C2=A0		mutex_lock_nested(&fd.tree->tree_lock,
> -				hfsplus_btree_lock_class(fd.tree));
> +				hfsplus_lock_class(fd.tree->cnid));
> =C2=A0		if (blk_cnt > start) {
> =C2=A0			hip->extent_state |=3D HFSPLUS_EXT_DIRTY;
> =C2=A0			break;
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 916e6552e3..22b961b454 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -30,11 +30,19 @@ typedef int (*btree_keycmp)(const
> hfsplus_btree_key *,
> =C2=A0
> =C2=A0#define NODE_HASH_SIZE	256
> =C2=A0
> -/* B-tree mutex nested subclasses */
> -enum hfsplus_btree_mutex_classes {
> -	CATALOG_BTREE_MUTEX,
> -	EXTENTS_BTREE_MUTEX,
> -	ATTR_BTREE_MUTEX,
> +/*
> + * Nested-locking subclasses shared by the B-tree tree_lock and the
> inode
> + * extents_lock.=C2=A0 Both are keyed by CNID (tree->cnid or inode-
> >i_ino), so one
> + * mapping serves both.=C2=A0 The allocation file gets its own subclass
> because a
> + * regular file's extents_lock is held across block alloc/free,
> which takes the
> + * allocation file's extents_lock in turn; every other inode uses
> the default.
> + */
> +enum hfsplus_mutex_classes {
> +	HFSPLUS_CATALOG_MUTEX,
> +	HFSPLUS_EXTENTS_MUTEX,
> +	HFSPLUS_ATTR_MUTEX,
> +	HFSPLUS_ALLOC_MUTEX,
> +	HFSPLUS_DEFAULT_MUTEX,

I prefer to keep naming convention like it was before. Because,
CATALOG_BTREE_MUTEX can be used in HFS and HFS+ without any changes in
the future. I still would like to introduce something like library that
contain similar code in HFS/HFS+.=20

> =C2=A0};
> =C2=A0
> =C2=A0/* An HFS+ BTree held in memory */
> @@ -547,25 +555,20 @@ static inline __be32 __hfsp_ut2mt(time64_t ut)
> =C2=A0	return cpu_to_be32(lower_32_bits(ut) + HFSPLUS_UTC_OFFSET);
> =C2=A0}
> =C2=A0
> -static inline enum hfsplus_btree_mutex_classes
> -hfsplus_btree_lock_class(struct hfs_btree *tree)
> +static inline unsigned int hfsplus_lock_class(u32 cnid)
> =C2=A0{
> -	enum hfsplus_btree_mutex_classes class;
> -
> -	switch (tree->cnid) {
> +	switch (cnid) {
> =C2=A0	case HFSPLUS_CAT_CNID:
> -		class =3D CATALOG_BTREE_MUTEX;
> -		break;
> +		return HFSPLUS_CATALOG_MUTEX;
> =C2=A0	case HFSPLUS_EXT_CNID:
> -		class =3D EXTENTS_BTREE_MUTEX;
> -		break;
> +		return HFSPLUS_EXTENTS_MUTEX;
> =C2=A0	case HFSPLUS_ATTR_CNID:
> -		class =3D ATTR_BTREE_MUTEX;
> -		break;
> +		return HFSPLUS_ATTR_MUTEX;
> +	case HFSPLUS_ALLOC_CNID:
> +		return HFSPLUS_ALLOC_MUTEX;
> =C2=A0	default:
> -		BUG();
> +		return HFSPLUS_DEFAULT_MUTEX;
> =C2=A0	}
> -	return class;
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index ff7d6b3336..49059bf3e7 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -152,7 +152,7 @@ static int hfsplus_system_write_inode(struct
> inode *inode)
> =C2=A0	hfsplus_inode_write_fork(inode, fork);
> =C2=A0	if (tree) {
> =C2=A0		mutex_lock_nested(&tree->tree_lock,
> -				=C2=A0 hfsplus_btree_lock_class(tree));
> +				=C2=A0 hfsplus_lock_class(tree->cnid));
> =C2=A0		int err =3D hfs_btree_write(tree);
> =C2=A0		mutex_unlock(&tree->tree_lock);
> =C2=A0
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c7..f540d4c382 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -264,7 +264,8 @@ static int hfsplus_create_attributes_file(struct
> super_block *sb)
> =C2=A0						=C2=A0=C2=A0=C2=A0 sbi->sect_count,
> =C2=A0						=C2=A0=C2=A0=C2=A0
> HFSPLUS_ATTR_CNID);
> =C2=A0
> -	mutex_lock(&hip->extents_lock);
> +	mutex_lock_nested(&hip->extents_lock,
> +			=C2=A0 hfsplus_lock_class(attr_file->i_ino));
> =C2=A0	hip->clump_blocks =3D clump_size >> sbi->alloc_blksz_shift;
> =C2=A0	mutex_unlock(&hip->extents_lock);
> =C2=A0

The extents_lock is initialized in two places: fs/hfsplus/super.c:86
(hfsplus_iget() path) and fs/hfsplus/inode.c:494 (hfsplus_new_inode()).
Each mutex_init() site gets its own static lockdep key, so lockdep sees
two unrelated extents_lock classes:
- inodes read from disk, which includes all system files;
- inodes created during this mount.

So a nesting through a freshly created file never conflicts with one
through an existing file, and ordering checks between the two groups
are lost. That's an existing problem, not caused by this patch. Moving
the mutex_init() into hfsplus_alloc_inode(), or into a single helper,
would fix it. What do you think?

Thanks,
Slava.

