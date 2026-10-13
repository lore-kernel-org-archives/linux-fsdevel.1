Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D22559C95
	for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791927509; cv=none; b=ExWxY7TkrJmUxStW+Mb4EB5fso2Y0yBBcqT/q86oXyhPmP5XDuWjA1Y5JhzURZPcoeOASIzc86sHuhqIAHdfQGGUlRNh7yBn/rBoMTOZGsA9rtNJMCeBCmJuBvGjNMY+IaTzFGIhYwEpV4Y39K/Z5YeRFG1jkGVD29aV0fu4rq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791927509; c=relaxed/simple;
	bh=GauCDosRfMAyI6XDTeWzknxxIvFg2fpqRU3ml+VK17g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m9bO7j5fgWJaiZSw/nk2lRzgvydgdz11pggxbcRiyu+aNOSr6kVn6T2NWGaid/r6gM/7R/+uqAPp3U3GrPPSDGyYxZzp7bKVDljHwx2Mi8vl5bqWVw3U47bbLdrAAZEJO+pxLII28aO28J/+pChbHuZiuGUe2zXZVKWyo+XisOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=FGBWLZZn; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="FGBWLZZn"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b0a36f1c95so4217397b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1791927506; x=1792532306; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P39BEHmXxYcjKeKQeIuHhJ0UPVpKaK0TOR42XQiDO7s=;
        b=FGBWLZZnKEwlUcdjzYXJR0CPxVANav6HV0+rO47U7mjZ5jelFpI55/KTktTOOYvyrK
         fO5OZNHJmCVnkkMpVXdI1AdmoSO8GQlgtIU72gb4W9eqimmJena0fODUcZRQ136ZKyyx
         eUZPseQpJAPq6Oz8wBR1jhMITAxp45mLaqIr8KEoWbhcQLgKnca2q0DzTgjI+Z4fQZ6f
         lgfxmwreQR4988JCFHvNpllSJGSQy9Sz6gKw4HWj2Oe7GL99kQQo+uxrLuQrF8B5NK83
         5HFiG2wPcTz+gILnGU67DjnJm3D9kVXDVQDO/aX9rU5sXpWQ4Ayi2CAqffSWf8nyygs1
         +dBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791927506; x=1792532306;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P39BEHmXxYcjKeKQeIuHhJ0UPVpKaK0TOR42XQiDO7s=;
        b=kXpaE8JpTTVgUiL4unBqA1FndiIilH3TThcX2JghcxZtAvZG0JrRyZMIzFh2OCH6+9
         heBP06E77/swd4OudxqLLrVuyYCJFNrMNjtWhA16OSadgliuorerjrJMK93GJ1BQqN3W
         ExJdywg+s2//OJm6F79NKCqsOWnRFkrcSP2S6cEdY/lRHH1ePG99AE/o4tngJ5ABo3z7
         QKU6cyeSOznO3ULwkNL81MXfjp0EeY1rcY6KYYNyWPgLnHCX0o3F6FuhuI/qzPzC9k80
         hc35GvjLh7MetbkeKI2kQ7kASPHkpNeJCVT/q6ZVWW3okUuALoTINQ7nWMi/sUgXOOiK
         bFOQ==
X-Gm-Message-State: AFq9FYIXjcGhTWfk679r9+fa/gl3OoPpwO3HVRA2KAx/KcKF9YVleCBH
	gKGy0h7ZFv0iofmIVDT8CAF2ODi8RzBtX4EQvIsEsjv8ZrnMwS2aGgepKqXmW9Ppkl8=
X-Gm-Gg: AYBFou0r5UWKcKnjfR3dfa+ECzjI4MCJA04AKtJrFTkpLfX1MAU9vRmahKr53FaAotu
	hVlIZdLkR9fsFoLmNiLTjV/n2Ymr7rBQmwQCV0uRdPEBaabE8szZPmByD9G5YvpbUJNeSA1ftFB
	oeynH9j6FsPF2e8OCD6QRKtqXjWOgTaM0xqFDrdEKI+PE9LU4IkuX4pH184vRfmHd0GRhyDOSXs
	ecRnD7MygiC1rasRDeU6NQX5j6hyalDo+JCrxLRhte25dTheNLZn8fqzNQ3p3v5+lDE0C/WQBwu
	M1TdM8TT906psVhz8rpIW2q06HSmGvFDCCQ4OjYXZBErvPsdRPPhoo2NYnFiNPGtsS08pFNDqyQ
	PCFy/bj86RdsIHpAo/jliSYuvGJ65+/bMLJmd6lM9Uv/NS1GNSxnMfG6Sj7zvuKWDVvf3jWYGJD
	8piOqP/YpU2k9+rc6TdDeJ6GiAuL8bj31Gd4y05NT4axiJmtvEoXtPrNt7Yo7D+Z3WMwRLDTLTN
	uiK6qbwxvbT1el8Y0tMpsJHsGvPW6RAivXbNsIYDJ9sIQpbwjP59LZpWTq+TvWao1BdRjCVNtCM
	zXS16cw=
X-Received: by 2002:a05:690c:6e85:b0:8b0:a352:f96d with SMTP id 00721157ae682-8b0a352fd2bmr31848197b3.11.1791927506420;
        Tue, 13 Oct 2026 14:38:26 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430::48])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b07f1ea845sm50241657b3.24.2026.10.13.14.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 14:38:24 -0700 (PDT)
Message-ID: <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfs: give the internal B-tree inodes a type and keep
 catalog records off them
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: yangguikun <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 13 Oct 2026 14:38:22 -0700
In-Reply-To: <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
	 <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
	 <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
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

On Tue, 2026-10-13 at 14:44 +0800, yangguikun wrote:
> hfs_btree_open() builds the extents and catalog B-tree inodes with a
> raw
> iget_locked() and never assigns them a file type, so both stay cached
> with
> i_mode =3D=3D 0 after every mount.=C2=A0 Two problems follow from that, a=
nd
> both are
> reachable from a crafted image.
>=20
> First, a catalog record that names CNID 3 or 4 makes hfs_lookup() ->
> hfs_iget()
> return the cached B-tree inode - hfs_test_inode() matches on i_ino
> alone - and
> the typeless inode then reaches the generic open path, where it trips
> VFS_BUG_ON_INODE() in may_open() with CONFIG_DEBUG_VFS=3Dy:
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
> Second, once the inode has a type, such a record still hands the
> internal
> B-tree file out as a regular dentry: it can be opened and read, which
> exposes
> the B-tree, and from then on the VFS treats an inode that has no
> catalog
> record behind it as an ordinary file.=C2=A0 hfs_is_valid_cnid() does not
> close this
> path: it runs from hfs_read_inode(), and a lookup that hits the
> already cached
> B-tree inode never reaches that function.
>=20
> Fix both.=C2=A0 Add hfs_system_read_inode(), which reads the fork from th=
e
> MDB and
> assigns S_IFREG - the counterpart of hfsplus_system_read_inode() -
> and
> hfs_system_iget(), which looks the inode up through the normal inode-
> cache path
> and can fail before the inode is published.=C2=A0 hfs_btree_open() now
> uses
> hfs_system_iget(), and the extent-record validation moves into the
> new read
> helper.=C2=A0 hfs_iget() refuses catalog records that name a reserved CNI=
D
> below
> HFS_FIRSTUSER_CNID; the root directory, the one reserved CNID that
> legitimately
> comes through there, is exempt.
>=20
> Found by syzkaller-style fuzzing of v7.2-rc7; still reproducible on
> current
> mainline.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA913=
2A7305307@qq.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangguikun <yangguikun19@qq.com>
> ---
> =C2=A0fs/hfs/btree.c=C2=A0 | 39 +++------------------------
> =C2=A0fs/hfs/hfs_fs.h |=C2=A0 1 +
> =C2=A0fs/hfs/inode.c=C2=A0 | 82
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 86 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8f..b5892de 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,44 +155,11 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->cnid =3D id;
> =C2=A0	tree->keycmp =3D keycmp;
> =C2=A0
> -	tree->inode =3D iget_locked(sb, id);
> -	if (!tree->inode)
> +	tree->inode =3D hfs_system_iget(sb, id);
> +	if (IS_ERR(tree->inode))
> =C2=A0		goto free_tree;

I worried that we jump to free_tree now. Before, we cannot get inode
but now method can or cannot get inode. We need somehow distinguish
these cases now and to jump to free_tree or to free_inode. Or we need
to manage it in more smart way.

> -	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));

I am not sure that it's good idea to drop this. If hfs_system_iget()
quietly returns an existing inode. In hfs_btree_open() that would mean
the same tree was opened twice.

> -	{
> -	struct hfs_mdb *mdb =3D HFS_SB(sb)->mdb;
> -	HFS_I(tree->inode)->flags =3D 0;
> -	mutex_init(&HFS_I(tree->inode)->extents_lock);
> -	switch (id) {
> -	case HFS_EXT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drXTExtRec,
> mdb->drXTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drXTFlSize,
> be32_to_cpu(mdb->drXTClpSiz));
> -		if (HFS_I(tree->inode)->alloc_blocks >
> -					HFS_I(tree->inode)-
> >first_blocks) {
> -			pr_err("invalid btree extent records\n");
> -			unlock_new_inode(tree->inode);
> -			goto free_inode;
> -		}
> =C2=A0
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> -		break;
> -	case HFS_CAT_CNID:
> -		hfs_inode_read_fork(tree->inode, mdb->drCTExtRec,
> mdb->drCTFlSize,
> -				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> -
> -		if (!HFS_I(tree->inode)->first_blocks) {
> -			pr_err("invalid btree extent records (0
> size)\n");
> -			unlock_new_inode(tree->inode);
> -			goto free_inode;
> -		}
> -
> -		tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;
> -		break;
> -	default:
> -		BUG();
> -	}
> -	}
> -	unlock_new_inode(tree->inode);
> +	tree->inode->i_mapping->a_ops =3D &hfs_btree_aops;

 Set a_ops inside hfs_system_read_inode(). Right now tree->inode-
>i_mapping->a_ops =3D &hfs_btree_aops; runs in hfs_btree_open() after
unlock_new_inode(), so the inode is visible in the hash briefly without
its aops.

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
> index 2aef3c3..5c00383 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -421,6 +421,87 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * hfs_system_read_inode - read an internal B-tree inode
> + * @inode: inode to initialize, hashed by its CNID
> + *
> + * The extent and catalog B-trees are described by the MDB instead
> of by
> + * catalog records, so they do not go through hfs_read_inode().
> + *
> + * Return: 0 on success, -EIO if the MDB does not describe this
> CNID.
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
> +		if (HFS_I(inode)->alloc_blocks > HFS_I(inode)-
> >first_blocks) {
> +			pr_err("invalid btree extent records\n");
> +			return -EIO;
> +		}
> +		break;
> +	case HFS_CAT_CNID:
> +		hfs_inode_read_fork(inode, mdb->drCTExtRec, mdb-
> >drCTFlSize,
> +				=C2=A0=C2=A0=C2=A0 mdb->drCTFlSize,
> be32_to_cpu(mdb->drCTClpSiz));
> +		if (!HFS_I(inode)->first_blocks) {
> +			pr_err("invalid btree extent records (0
> size)\n");
> +			return -EIO;
> +		}
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	/*
> +	 * may_open() requires a file type, and a crafted catalog
> record can
> +	 * reach this inode by its CNID.
> +	 */
> +	inode->i_mode =3D S_IFREG;
> +
> +	return 0;
> +}
> +
> +/**
> + * hfs_system_iget - look up an internal B-tree inode by CNID
> + * @sb: super block
> + * @cnid: HFS_EXT_CNID or HFS_CAT_CNID
> + *
> + * Return: the inode, or an ERR_PTR() if it cannot be initialized.
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
> @@ -446,6 +527,15 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0	default:
> =C2=A0		return NULL;
> =C2=A0	}
> +
> +	/*
> +	 * hfs_test_inode() matches on i_ino only, so a catalog
> record naming
> +	 * a reserved CNID would hand out a B-tree inode as a
> regular dentry.
> +	 * The root directory is the one reserved CNID that comes
> through here.
> +	 */
> +	if (cnid !=3D HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID)

I am guessing maybe we need to introduce a special method:

static inline bool hfs_is_system_reserved_cnid(u32 cnid)
{
	if (likely(cnid > HFS_ROOT_CNID	&& cnid <
HFS_FIRSTUSER_CNID))
		return true;
	else
        	return false;
}

What do you think?

Thanks,
Slava.

> +		return NULL;
> +
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> =C2=A0	if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0		unlock_new_inode(inode);
