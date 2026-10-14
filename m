Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E6148F82B
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 22:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792016856; cv=none; b=Z/TCxQSwXiq71rW3Zz5sebc+5A0UB+KzIwhAGQTobVn9/WW2qsl/JJw/dhI3BiijbwrSzbyRCrZJVK40fk6JbBYKWrbUyXSQlJboW9Eez4LJL9YhDnQk9yLWgQQB0WZSFBDuX+hRcavdVan1BUESZyLrEOmaysT4b1lachwQKak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792016856; c=relaxed/simple;
	bh=b7T0m26BWZiTDbr9Qil9u4RrJ1VM2BNA6QN4PLk8KAw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eRQdMTnCbeIDTF88cFZwerNtpnF+NkeJYT64pfLFK/ys1oPjGZa4q4UJ/5L0DUbbro+6pKffZAfsXg0oXFlwW5zw8+yCmsuqX8AwujWl68GhOiOntIbJZ7fJRciPvdh1DE/sIpll9XlcsfDbRnAyhqAT8iDWuH03K9SVqG9N5Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Cbgh3iZs; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Cbgh3iZs"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8726acc5eadso38564357b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 15:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792016854; x=1792621654; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bW1h1tXKod9kXvt5zoq6eQf31DLcHbJ3q2FfoPGhil8=;
        b=Cbgh3iZsD1czrwowUHaSR1Ry+gh+Afpl3dd2M+efrXE7IxhzotL9xw/VXwnR3b5w2Z
         sDJObB6ULRHZjhabbDKAl3vHX1EjFs6eTvN9lIgClpPKO3riSulTVC4czUzEO3VfqoNe
         SiTW2yis4g1nDbyi8mvaxXiYnGtZ1iCQBCL4H+ml0ZxxlVtnWk6apd8Eoxdo/0byuYKx
         ChQ1n/LEvOMiIcgw3Ed8MUBF9XlrRoFwe5g2OS8s2IERRsBAZVnZXcJ6ixQ8VoxhoR+q
         5hY+KPzt9ri3j+dJeqKcYsUbgH6P3roO+IGFADyOkAaA7TTkLUC4YXLIv5MEzNYLD6fY
         DNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792016854; x=1792621654;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bW1h1tXKod9kXvt5zoq6eQf31DLcHbJ3q2FfoPGhil8=;
        b=kWXfmzVuK/APRUxMgFquIi5isKXhvDUc47styez2/+HblAvZESi1A4jDvig+Hq1MaC
         ZGfBYNpjO/6zactmclBcQnB25IWKkZqkVDEucQWkKWIY3CZtr7IFTCtEaUoYFV2DoLDp
         OOLP+QmqgjeiHVu2kovPTfjF0z9JSTQqvRLFm0ssk/bMVSsjt7mgys/1OzZ9EwxuTukc
         tuLAepe0anImYoW0unD1xbf0ZeqbWJX/DhQKBYMN+iyll99UMacS2tFE0AwGboD4sXO4
         T4vUJGkVam9D5+U1MPIBvA6Tvp9ZxvsGJfMPLGXN8TkRlUmX+9VyvUOuS5DVn0JaOhuP
         LQMQ==
X-Gm-Message-State: AFq9FYK/08ZFl4HNL1el/HXY3Io22HtW0wJ1QMEHH+tzh+w0zspY+NGp
	oC2iaNIsNGv+75TY0GwpGZpn8M6b2ewz3YEL36KO8xptS2DBemKAG57Aj0Ggh0N96Y4=
X-Gm-Gg: AYBFou2liYHGD+zq5UZYdyXrJBWu/8u/0rN4PZYOuwg6Ngxfmb3VPbxlizozfFKq8TR
	kcud0csT6XoUs/9RpFTRYOzI8geGJtwamIZIK1FL6IZh5nsIS0s3zbvT1GbH9yvug1TnDjro4OL
	pD77EhRRecpV+gUT4nmV2S5cCXTUWUAZlof54fwy2XSJeDKYD7cEcGOX8ZekXG3h/0hhWxhywBs
	cfREqqkKEZ88ZbowOmqXbiJAoJmIenCqx4xv8+o+WXXHOC/fW+jI5r3fhQKTfY2MQB1l69bWGKK
	q8IdJ12YMvZO8K6VltAn1DJekNmLX4GIYCceIhxG6yzZ4v9i1bCvzBn+JoXVSwYuiGCVkVlKp4G
	pYMd/H3FGQcSo+cPaJqg37m6ExfKhZxK9QF/DcONcIhJ71B6ZCb105H7a+qul+LsaUfeiWFShXD
	N0HVoy3UlUYRMQRURnR2FgVuJgEU5pEgq/ffSrhLsgyS/jx4ZiUun+MvvuGAmHg0hKG7CDDFrNo
	w5GOBl4kKzuiel4BHg+0t2lvA55R/WrmRA+kDNR5SCOpNTE/LkHxIiaAgY9UoDh3FOMCsXokKWZ
	QwySnVlaTfVOhaRkAzEqEn7qhkeZ2K1QbrgYF1nbc7SofdBCh/QAspLDWfBoGSsF
X-Received: by 2002:a05:690c:ec8:b0:882:b4b2:c49 with SMTP id 00721157ae682-8b07edbd0afmr62545637b3.18.1792016853733;
        Wed, 14 Oct 2026 15:27:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:98d3:ec2f:c938:3bc1? ([2600:1700:6476:1430:98d3:ec2f:c938:3bc1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b0d8e8486esm198857b3.44.2026.10.14.15.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 15:27:32 -0700 (PDT)
Message-ID: <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com>
Subject: Re: [PATCH v4] hfs: initialize B-tree inodes and validate catalog
 CNIDs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: yangguikun <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 14 Oct 2026 15:27:31 -0700
In-Reply-To: <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
	 <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
	 <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
	 <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
	 <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com>
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

On Wed, 2026-10-14 at 16:03 +0800, yangguikun wrote:
> hfs_btree_open() leaves the internal B-tree inodes with i_mode =3D=3D 0.
> A crafted catalog record naming CNID 3 or 4 can return one of these
> cached inodes through hfs_iget(), triggering VFS_BUG_ON_INODE() in
> may_open() with CONFIG_DEBUG_VFS=3Dy.
>=20
> Initialize the B-tree inodes with S_IFREG and their address-space
> operations before publishing them. Reject attempts to reuse an
> already-cached B-tree inode.
>=20
> Validate catalog CNIDs and record types before the inode-cache
> lookup,
> since cached inodes bypass hfs_read_inode() validation. This also
> prevents a crafted file record from aliasing the root directory
> inode.
>=20
> Found by syzkaller-style fuzzing of v7.2-rc7.
>=20
> Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
> Link:
> https://lore.kernel.org/linux-fsdevel/tencent_24D928451FEFA8A35482EFFA913=
2A7305307@qq.com/
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: yangguikun <yangguikun19@qq.com>
> ---
> Changes in v4:
> =C2=A0- set a_ops in hfs_system_read_inode(), before the inode is
> published.
> =C2=A0- hfs_system_iget(): reject an already-cached inode (the original
> =C2=A0=C2=A0 BUG_ON()).
> =C2=A0- document why the free_tree error path is correct.
> =C2=A0- add hfs_is_system_reserved_cnid(), as suggested.
> =C2=A0- hfs_iget(): also reject records that hfs_read_inode() would rejec=
t
> =C2=A0=C2=A0 (CNID 2 typed as a file, for example); an already-cached ino=
de
> skips
> =C2=A0=C2=A0 that check.
>=20
> =C2=A0fs/hfs/btree.c=C2=A0 |=C2=A0 43 ++++-------------------
> =C2=A0fs/hfs/hfs_fs.h |=C2=A0 13 +++++++
> =C2=A0fs/hfs/inode.c=C2=A0 | 103
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A03 files changed, 122 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8f..454caa1 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,44 +155,13 @@ struct hfs_btree *hfs_btree_open(struct
> super_block *sb, u32 id, btree_keycmp ke
> =C2=A0	tree->cnid =3D id;
> =C2=A0	tree->keycmp =3D keycmp;
> =C2=A0
> -	tree->inode =3D iget_locked(sb, id);
> -	if (!tree->inode)
> +	/*
> +	 * hfs_system_iget() releases the inode itself when it
> cannot
> +	 * initialize it, so there is nothing to iput here.
> +	 */

Please, remove this comment.

> +	tree->inode =3D hfs_system_iget(sb, id);
> +	if (IS_ERR(tree->inode))
> =C2=A0		goto free_tree;
> -	BUG_ON(!(inode_state_read_once(tree->inode) & I_NEW));
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
> -
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
> =C2=A0
> =C2=A0	mapping =3D tree->inode->i_mapping;
> =C2=A0	folio =3D filemap_grab_folio(mapping, 0);
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e250f87..ecdcf81 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -163,6 +163,18 @@ extern int hfs_cat_move(u32 cnid, struct inode
> *src_dir,
> =C2=A0extern void hfs_cat_build_key(struct super_block *sb, btree_key
> *key,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent, const struct qstr *na=
me);
> =C2=A0
> +/*
> + * A CNID below HFS_FIRSTUSER_CNID is reserved for the system files;
> the
> + * root directory is the one reserved CNID that catalog records
> address.
> + */

The method name is informative enough. Please, remove the comment.

> +static inline bool hfs_is_system_reserved_cnid(u32 cnid)
> +{
> +	if (likely(cnid > HFS_ROOT_CNID && cnid <
> HFS_FIRSTUSER_CNID))
> +		return true;
> +	else
> +		return false;

       return cnid > HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID;

> +}

We don't need anything more here.
> +
> =C2=A0/*
> =C2=A0 * Validate the CNID of a catalog record.
> =C2=A0 */
> @@ -219,6 +231,7 @@ extern void hfs_inode_read_fork(struct inode
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
> index 2aef3c3..986a6f9 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -421,6 +421,97 @@ static int hfs_read_inode(struct inode *inode,
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

I am not sure that we need this comment at all. The function name is
good enough.

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

Maybe, we need to place it here?

+	inode->i_mode =3D S_IFREG;
+	inode->i_mapping->a_ops =3D &hfs_btree_aops;


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

/* may_open() requires a file type */

> +	inode->i_mode =3D S_IFREG;
> +
> +	/* Set before hfs_system_iget() publishes the inode. */

Please, remove the comment.

> +	inode->i_mapping->a_ops =3D &hfs_btree_aops;
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

Ditto.

> +struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
> +{
> +	struct inode *inode;
> +	int err;
> +
> +	inode =3D iget_locked(sb, cnid);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/*
> +	 * The B-tree inodes are created once per mount, so finding
> one
> +	 * already in the cache means the same tree was opened
> twice.
> +	 */

Please, delete the comment.

> +	if (!(inode_state_read_once(inode) & I_NEW)) {
> +		iput(inode);
> +		return ERR_PTR(-EEXIST);
> +	}
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
> @@ -446,6 +537,18 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0	default:
> =C2=A0		return NULL;
> =C2=A0	}
> +
> +	/*
> +	 * hfs_test_inode() matches on i_ino alone, so a crafted
> record can
> +	 * alias any cached inode.=C2=A0 hfs_read_inode() rejects an
> invalid CNID,
> +	 * but it does not run when the inode is already cached, and
> a record
> +	 * naming a reserved CNID would hand out a B-tree inode as a
> regular
> +	 * dentry.
> +	 */

Please, delete the comment. Code is informative enough.

> +	if (!hfs_is_valid_cnid(cnid, rec->type) ||
> +	=C2=A0=C2=A0=C2=A0 hfs_is_system_reserved_cnid(cnid))
> +		return NULL;

A NULL return becomes -EACCES in hfs_lookup() (fs/hfs/dir.c:38). For a
corrupted catalog, -EIO/-EUCLEAN fits better. What do you think? Am I
right here?

Thanks,
Slava.

> +
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> =C2=A0	if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0		unlock_new_inode(inode);
