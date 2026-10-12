Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E2E4DA9AA
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 21:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791840375; cv=none; b=S7FDupBbTap5zbatGOtLmQfbYNLpKd3Ujnkx0tc8zC9FavgUOxJWboFHCQZmm6OyGddgkFmS+gQtWx77CthlKlyfiyVD+FjtOpncwWMiWRa7BKsUqRB1R32P6NDCeVdOLAqr/CJIF7/L0hCjsAaD6ClktzAo313yogm6L9JDy3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791840375; c=relaxed/simple;
	bh=vTb4NG35yMvyaewaoDcZoQ4TH184RHZFc7KvX4HFuy4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oSrP4FsuetOAexz6xpCP/AWnHzVW4RBoqdq8In2mMMAEVETEbqmdhmYvx5P+rNwCG579Xa6utTMVLOUWFI8fzi9CKV1GHHwHQUvOvR3Cq3n/fOJCr7T4nTQTw6Ra6TBP3tA9P3IRHJTsX3pH/W6aIkvlFCk3jcEIn3UJ07EqPeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=qtMHe8Nb; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="qtMHe8Nb"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6740e7ae219so1645413d50.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Oct 2026 14:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791840372; x=1792445172; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=idouw7XP4ydUVOeBH19QwG4PGP1Smv5nQHwiH92Tdd8=;
        b=qtMHe8Nb08UBklz1kx1IFypRlq9pIFOdQQ2zx4CF3vWkCKGS4LgsUiGtIi0ca6wSiX
         muTreyFoTTRre8ZaS6kvIh4eXZGrSnBu5vCT8Lrxda7J3CzAJ0IAPlhqwn5LIVMp7Jgn
         itra/UchshCTI3igyt4YafnlKEPCEFNN8csqo+XKboyOwdBivoPwjBDBmAhjpjYrr6wc
         frhj8LPo0mnXT1ZjHGoMqc9W1R1dbUxT7u4Kc0wHz4yGYKuDbjw/KvaRMFctUyAh34wk
         7bcIJQDA5JNeF3lGAfewG9eifozqxy7OMualIi1KkdnCoEqJD0BrPlsQvvYerIUWTK3b
         B3Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791840372; x=1792445172;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=idouw7XP4ydUVOeBH19QwG4PGP1Smv5nQHwiH92Tdd8=;
        b=NsG+X1mWzFQkPcKXNwyVDvQMv1jEjv4+Cja/WzPE6b3WOuPJHk3xu51x+Y9T8k4YuQ
         dnW05B1ZJAbKPXwPlAiZJC9EGxmQjoQvpNND2k2qRUHBX9p0sMMgBo/MzQaM5O/j/akc
         FKpbKshoUJ/yuO8Q2rSTVTaWSkY26tUQS+5VgXE70q9QsKfI5g+XqyuLcMS13V1YwvYn
         u2VkeO1g19Y066/FIiWyvg+EArgDRjGPFe7UGWDJXwZDgPI01F27sxlxCVtP3BqbL46Y
         Hsu94vXaLoVCSuFcuGmRx2w/dx7onQvjjZk8ZqbX/bdfCkj3v1YG/+XM5KHDykjPNVpB
         lmRw==
X-Gm-Message-State: AFq9FYIdzXauhtXvdRA60Jf08gPujvP4021dc+Hb6RSj3LsNfG9yv/rS
	qUykA/xBtOhh3HcLVJMTcpvAZkjaqYi6Wrky22xvkFJV5OigSK6Axni97McMpO9Zjb35XrZJdxD
	k9a2CKGg=
X-Gm-Gg: AYBFou0NxS/PBAgtavHYO/ClyiFMw4m/54iagi4EWKf5BBeHvCAmsitwt3KuWr2lung
	Q18+PyoULhqsWXR62MIlmlCA+2w8yz9ITjzgf6ay9ZbItpTce79iWuZyFqgLS8GLog359VtP74O
	iayU95wzujlPaPl/xwMIegpEIzTDHgFLT9a+pH7kN/hjcT/1Bols0PXDSkHMq4o+iRmxT/u71EX
	T5Y+aUlHNX/ZOpttzY+d9DyN0fNwTYcuO/l8BEE2T6VkLmbbGWyAPTDp6toVrK9axclz4+QRy4c
	HLf0qVTFq2zBnmR46N1Z9Q3Yt5hza/boUUgAeVsY+e9GK1QkTcFIAvjjIX425QbA46cNO9svTl7
	IRP4Yk46zKe/50CxqrORHqdmI8pHWJQTx8mhuHUz9RL4p13OwTZFSu0Q1+xGLcrz1SmgGefmk3L
	qGXW6KSABMSErOOTzq+dtWgxt+CNZJfnddmUUuWdspU47HHz8NJ0SVsK3ADUiTxGZGZt2TD6frx
	hhCERiLKJ3pSG8TQ9DJPK/YmU4VfgSnS3/aPtCBOvzuRwBkP/uIqVqQmuM6I/DYAP001a34VXJv
	HKYtuWKIIv7ROUIIZNeQKQ==
X-Received: by 2002:a05:690e:13c7:b0:679:a58:163b with SMTP id 956f58d0204a3-6793602f2d2mr3100909d50.35.1791840371983;
        Mon, 12 Oct 2026 14:26:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::48? ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679356ef60fsm4015093d50.21.2026.10.12.14.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 14:26:11 -0700 (PDT)
Message-ID: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
Subject: Re: [PATCH v2 1/2] hfs: create the internal B-tree inodes through
 the generic iget path
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: 1sh1ro <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 12 Oct 2026 14:26:08 -0700
In-Reply-To: <tencent_C6E63E6151EEA924DF6C23D74E35A6245108@qq.com>
References: <fb6a6e2ff419fc197c793d9a98fccd2d1332e49d.camel@dubeyko.com>
	 <20261012154438.6396-1-yangguikun19@qq.com>
	 <tencent_C6E63E6151EEA924DF6C23D74E35A6245108@qq.com>
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

On Mon, 2026-10-12 at 15:44 +0800, 1sh1ro wrote:
> hfs_btree_open() builds the extents and catalog B-tree inodes with a
> raw
> iget_locked() and never assigns them a file type, so both stay cached
> with
> i_mode =3D=3D 0 after every mount.=C2=A0 A crafted HFS image whose catalo=
g
> contains
> a record addressing one of the reserved B-tree CNIDs (3 or 4) makes
> hfs_lookup() -> hfs_iget() return that cached inode -
> hfs_test_inode()
> matches on i_ino alone - and the typeless inode then reaches the
> generic
> open path, where it trips VFS_BUG_ON_INODE() in may_open() with
> CONFIG_DEBUG_VFS=3Dy:
>=20
> =C2=A0 VFS_BUG_ON_INODE(!IS_ANON_FILE(inode)): inode:... fs:hfs mode:0
> opflags:0xc
> =C2=A0 ------------[ cut here ]------------
> =C2=A0 kernel BUG at fs/namei.c:4271!
> =C2=A0 RIP: 0010:may_open+0x2ba/0x480 fs/namei.c:4271
> =C2=A0 Call Trace:
> =C2=A0=C2=A0 do_open fs/namei.c:4698 [inline]
> =C2=A0=C2=A0 path_openat+0x1600/0x3de0 fs/namei.c:4863
> =C2=A0=C2=A0 __x64_sys_openat+0x13f/0x1f0 fs/open.c:1385
>=20
> Without CONFIG_DEBUG_VFS the assertion compiles away and the same
> image
> silently yields an openable typeless inode, so this is not merely a
> debug-config nuisance.
>=20
> Fix it the way HFS+ handles its system inodes: add
> hfs_system_read_inode(),
> which reads the fork from the MDB (the counterpart of
> hfsplus_system_read_inode()), and hfs_system_iget(), which looks the
> inode
> up through the normal inode-cache path and can fail before the inode
> is
> published.=C2=A0 hfs_btree_open() now uses hfs_system_iget(), so the B-
> tree
> inodes carry a valid S_IFREG type like every other inode.=C2=A0 The
> extent-record validation is unchanged; it just runs after the inode
> has
> been created.
>=20
> Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on
> current mainline.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA913=
2A7305307@qq.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: 1sh1ro <yangguikun19@qq.com>

Please, provide the real name.

> ---
> =C2=A0 fs/hfs/btree.c=C2=A0 |=C2=A0 25 +++++--------------------
> =C2=A0fs/hfs/hfs_fs.h |=C2=A0=C2=A0 1 +
> =C2=A0fs/hfs/inode.c=C2=A0 |=C2=A0 74 +++++++++++++++++++++++++++++++++++=
+++++
> =C2=A03 files changed, 80 insertions(+), 20 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8f..7486707 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,44 +155,29 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->cnid =3D id;
> =C2=A0	tree->keycmp =3D keycmp;
> =C2=A0
> -	tree->inode =3D iget_locked(sb, id);
> -	if (!tree->inode)
> +	tree->inode =3D hfs_system_iget(sb, id);
> +	if (IS_ERR(tree->inode))
> =C2=A0		goto free_tree;
> -	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
> -	{
> -	struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> -	HFS_I(tree->inode)->flags =3D 0;
> -	mutex_init(&HFS_I(tree->inode)->extents_lock);
> +
> =C2=A0	switch (id) {
> =C2=A0	case HFS_EXT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec,
> mdb->drXTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drXTFlSize,
> be32_to_cpu(mdb->drXTClpSiz));
> =C2=A0		if (HFS_I(tree->inode)->alloc_blocks >
> =C2=A0					HFS_I(tree->inode)-
> >first_blocks) {
> =C2=A0			pr_err("invalid btree extent records\n");

This check should be in hfs_system_read_inode() now.

> -			unlock_new_inode(tree->inode);
> =C2=A0			goto free_inode;
> =C2=A0		}
> -
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> =C2=A0		break;
> =C2=A0	case HFS_CAT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drCTExtRec,
> mdb->drCTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> -
> =C2=A0		if (!HFS_I(tree->inode)->first_blocks) {
> =C2=A0			pr_err("invalid btree extent records (0
> size)\n");

Ditto. This check should be in hfs_system_read_inode() now.

> -			unlock_new_inode(tree->inode);
> =C2=A0			goto free_inode;
> =C2=A0		}
> -
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> =C2=A0		break;
> =C2=A0	default:
> =C2=A0		BUG();
> =C2=A0	}
> -	}
> -	unlock_new_inode(tree->inode);
> +
> +	tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> =C2=A0
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	folio =3D filemap_grab_folio(mapping, 0);
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e250f87..26505f7 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -219,6 +219,7 @@ extern void hfs_inode_read_fork(struct inode
> *inode, struct hfs_extent *ext,
> =C2=A0				u32 clump_size);
> =C2=A0extern struct inode *hfs_iget(struct super_block *sb, struct
> hfs_cat_key *key,
> =C2=A0				hfs_cat_rec *rec);
> +extern struct inode *hfs_system_iget(struct super_block *sb, u32
> cnid);
> =C2=A0extern void hfs_evict_inode(struct inode *inode);
> =C2=A0extern void hfs_delete_inode(struct inode *inode);
> =C2=A0
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 2aef3c3..4316d75 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -421,6 +421,80 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * hfs_system_read_inode

You need to place short abstract of the function:
hfs_system_read_inode() - <short explanation> or simply remove it
because there is no useful info here.

> + *
> + * Initialize one of the internal B-tree inodes.=C2=A0 These are
> described by the
> + * MDB rather than by catalog records, so they need their own read
> helper -
> + * the HFS counterpart of hfsplus_system_read_inode().

Could you please rework comment? It is not useful now.

> + */
> +static int hfs_system_read_inode(struct inode *inode)
> +{
> +	struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
> +	struct hfs_mdb *mdb =3D hsb->mdb;
> +
> +	HFS_I(inode)->flags =3D 0;
> +	HFS_I(inode)->rsrc_inode =3D NULL;
> +	mutex_init(&HFS_I(inode)->extents_lock);
> +	HFS_I(inode)->tz_secondswest =3D sys_tz.tz_minuteswest * 60;
> +
> +	inode->i_uid =3D hsb->s_uid;
> +	inode->i_gid =3D hsb->s_gid;
> +	set_nlink(inode, 1);
> +
> +	switch (inode->i_ino) {
> +	case HFS_EXT_CNID:
> +		hfs_inode_read_fork(inode, mdb->drXTExtRec, mdb-
> >drXTFlSize,
> +				=C2=A0=C2=A0=C2=A0 mdb->drXTFlSize,
> be32_to_cpu(mdb->drXTClpSiz));
> +		break;
> +	case HFS_CAT_CNID:
> +		hfs_inode_read_fork(inode, mdb->drCTExtRec, mdb-
> >drCTFlSize,
> +				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * Assign a dummy file type, for may_open() requires that an
> inode has
> +	 * a valid file type.=C2=A0 These inodes are hashed by CNID like
> any other
> +	 * inode, so without a type a catalog record of a crafted
> image that
> +	 * aliases CNID 3 or 4 would reach the VFS with i_mode =3D=3D 0.
> +	 */

Could it be short and clear comment?

> +	inode->i_mode =3D S_IFREG;
> +
> +	return 0;
> +}
> +
> +/*
> + * hfs_system_iget

Ditto.

> + *
> + * Look up (or create) one of the internal B-tree inodes.=C2=A0
> hfs_btree_open()
> + * uses this instead of a raw iget_locked() so that the inode is
> completely
> + * initialized before it becomes visible in the inode cache, in the
> same way
> + * hfsplus_iget() handles the system CNIDs for HFS+.

Could you please rework the AI generated comment? Currently, it is not
useful.

Thanks,
Slava.

> + */
> +struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
> +{
> +	struct inode *inode;
> +	int err;
> +
> +	inode =3D iget_locked(sb, cnid);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +	if (!(inode_state_read_once(inode) & I_NEW))
> +		return inode;
> +
> +	err =3D hfs_system_read_inode(inode);
> +	if (err) {
> +		iget_failed(inode);
> +		return ERR_PTR(err);
> +	}
> +
> +	unlock_new_inode(inode);
> +	return inode;
> +}
> +
> =C2=A0/*
> =C2=A0 * __hfs_iget()
> =C2=A0 *
