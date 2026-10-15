Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A4B3655D1
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 22:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103696; cv=none; b=B8chyI2jcP+YnPw2Zoakx7y1WBNCKgaEbE1CkrV1q4gqPr8dZqAgZPDai6kraOH1l5s3qVouU6UGz6mt6QeeuavI8UI56itOG2EzZzhA+TSKSoGOI4tX74Ew5q/w9VjD9tanKzvJXpzsrqpZrw54keP32EkTOof2ne2YDngm0fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103696; c=relaxed/simple;
	bh=A9buiGTiFEp2fjj56KMwyGwsDcebfKNWVyYFW//FJtg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rfHsN8YONhxMJ5NJ7z/9ts0bpPZPUwhUx3hnpXSt1gp51yMWfRiPT+Et4KopxQyyphHD8GiqbtELHbPukNERLKdwzXJ56YDskKCrgqXijJbXIe0S1ylkWztUnxo8/I0eINum2Yn0jPKeLG1xJY9NxPD8HqqD1A1DD+bRdsC93GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PnHj8OPj; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PnHj8OPj"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-677bc4704cbso5543747d50.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Oct 2026 15:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1792103692; x=1792708492; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g14n4P2sSSg+Oot0gruSMBjEIGyACAmMV+zXIr83ehU=;
        b=PnHj8OPja5LKFRDOn874Z+c3dVEu2D8mKVqLufniKZe/e+sz1iszL4+Jm2hMa2cMOt
         T5Lmvm4p5R2KeIy6/yPaCIDJIuFx/afmk3Me9fZW+x+3i219h6uSbH1IHGSj84/S/YKE
         OmlohJH79buq4DcYyYPRPd8zfDJHN1iCI42OzY/5IQu87UEI86m5CKYlMdcVB83dfIe7
         bwJ44RM4VdUwoPoS6IzSEDj2BFTktHtXkw9f7KMG6aoQEvkHySmKcJgD8Hli3ZMf7SSB
         q0VbaHTIdNLmlh2KhGGlXPF3lqQmtYH2XqEjLLyDWlabEdYnkccoAuwH2x2i+rX9JHzC
         O+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792103692; x=1792708492;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g14n4P2sSSg+Oot0gruSMBjEIGyACAmMV+zXIr83ehU=;
        b=qMlg93TWLqNkJoxroMwvIhFkz/s/qZ8anT18DT38bBAzyYbTi+09W5PYu5/R3kuspY
         Ib27u30gMtxEX/loD6eZ6q28QrjFD3mYn4LD7VqK4XRPvocB+pG/yZkUpeQk1lH6Jl3O
         FBL52Z/ScE8AYlsmxP2z00BtDNdgdwqVwIFIYfbYk4TBfwLw/1Y8YzQh9eQwcA+J9lb1
         Fa6dlLt0Us3xf6nxv/1ogf/P/5IUjHFr4f+hJKWvfjGErDl7znMeEpzIdPLfYwswxqlE
         e1YBItrxFtRwk5JoOlabEAiVS5B3q/te9Cz9Foy6xvFE4IywQdMCqjUz0MWwPfU3q6jk
         R4NA==
X-Gm-Message-State: AFq9FYLzFTXLoJZqfE74I/EBHsEKBe3ahYkBGk4NRkXQnu++CCOwctyH
	XpPPIXV53zy3QRVa69ZYB4WZaQPp7hmS7WJETHabvrRsTUhxmxqAcg/DxWIUJUStutI=
X-Gm-Gg: AYBFou1CBQkzG+XGfObxOS5A+yGUYCGfdIM76gTebhZGNfKyUxzsifo/0p3EGvrJhyw
	nrqYOy2/fQuc7/8SfuAe9JPe99kE2wrW9RCkJrpHcpOzwV4lOLfsotXAuoW6ddxcp5jxx0u+4tX
	HBZnjM0K4scyPWKZADBBKKlh6ezicLOKg3Cx7EjqPL+3CEvwdWhXqdG8dCPY9Nnej6zU6+h4lhT
	mF6Kj1KiHPcPE06ri43PR8L3x6E4VNmnHfzaO5MCcUu8zffEOb92WYdu82LXq07jjIvGADQeAVH
	M985YXuupgI5s4Jag2+WcrGbyCeVhQVa3DM4PEfN1sUpbIiRBDjzCf789eiEyUu1Jt5LorFulaZ
	ushGYOgRs4eWj6Am1oWhL3ONUi9oLy51BzKO0TG2jsCrW5UIfoG7fYW0NH2wPUsNpi12zhjphzj
	ZY5GzFNmjRXYMnjCLWYeGmnu9uSJ4MO4hMiw48L/uDsU1IhU30u6BmH5QrNpUF28KdT2ha+zWKT
	EyXeniWRtS5ABn7o4E2C0LBYzMkDbI1rbBozM0fe9Od9tCOgmyMf7LxHl4aj9uWLKHnTjYjx99v
	qUkOQUOPC58fmXE9fJY9mm6HoRad3UTuRb0fWltINQ9DgmGZGMU+lu1SR9nBIxUJrp5JTQ==
X-Received: by 2002:a05:690e:118d:b0:679:357b:52dc with SMTP id 956f58d0204a3-679363087damr5665709d50.124.1792103692251;
        Thu, 15 Oct 2026 15:34:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:f74:f3d:4fc4:4a6d? ([2600:1700:6476:1430:f74:f3d:4fc4:4a6d])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-679b1e406f6sm507582d50.11.2026.10.15.15.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 15:34:51 -0700 (PDT)
Message-ID: <0ed462f8eb132699e04dfe458a69f28941d2069b.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfs: initialize B-tree inodes and validate catalog
 CNIDs
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: yangguikun <yangguikun19@qq.com>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 15 Oct 2026 15:34:50 -0700
In-Reply-To: <tencent_35A04F645468AAD977F1C899D38EA945D406@qq.com>
References: <498724fe4ae0f0bc91137f573397363f962ac73d.camel@dubeyko.com>
	 <abe509bc80fe0f4e83f49af87aaa74fb95888aff.camel@dubeyko.com>
	 <tencent_A4C2280F9FC0A89C54BDEF96112DA7245307@qq.com>
	 <88f825b8d9942f8b9a94a39f53deee5e6f5d1f4c.camel@dubeyko.com>
	 <tencent_A6CC872D2A2155E7DB68E4D889C9D42E2A05@qq.com>
	 <b154a8939a2dc819bd011a502f835d9377351a46.camel@dubeyko.com>
	 <tencent_35A04F645468AAD977F1C899D38EA945D406@qq.com>
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

On Thu, 2026-10-15 at 15:06 +0800, yangguikun wrote:
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
> Changes in v5:
> =C2=A0- Remove unnecessary comments.
> =C2=A0- Simplify hfs_is_system_reserved_cnid().
> =C2=A0- Move i_mode and a_ops initialization after set_nlink().
> =C2=A0- Use -EIO instead of -EACCES.
>=20
> =C2=A0fs/hfs/btree.c=C2=A0 | 39 ++-----------------------------
> =C2=A0fs/hfs/dir.c=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0fs/hfs/hfs_fs.h |=C2=A0 6 +++++
> =C2=A0fs/hfs/inode.c=C2=A0 | 71
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A04 files changed, 80 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 41b4e8f..1891ad5 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -155,44 +155,9 @@ struct hfs_btree *hfs_btree_open(struct
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
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index e1f1fb3..0a31304 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -36,7 +36,7 @@ static struct dentry *hfs_lookup(struct inode *dir,
> struct dentry *dentry,
> =C2=A0	} else {
> =C2=A0		inode =3D hfs_iget(dir->i_sb, &fd.search_key->cat,
> &rec);
> =C2=A0		if (!inode)
> -			inode =3D ERR_PTR(-EACCES);
> +			inode =3D ERR_PTR(-EIO);

With the patch applied, hfs_iget() can return NULL in these cases:

1. Unknown record type. The default: branch of its own switch (rec-
>type) returns NULL. That's corruption.
2. The new CNID check (!hfs_is_valid_cnid() ||
hfs_is_system_reserved_cnid()). Also corruption.
3. iget5_locked() returns NULL. In fs/inode.c that happens when:
   - alloc_inode(sb) fails, meaning the inode slab allocation ran out
of memory. This is not corruption; it's -ENOMEM.
   - The set() callback fails. Here that's hfs_read_inode() returning -
EIO for a bad CNID, which is corruption again.

If we want it done properly, ten, maybe, we need to make hfs_iget()
return ERR_PTR() instead of NULL:
- ERR_PTR(-ENOMEM) when the allocation fails
- ERR_PTR(-EIO) for the corruption cases

What do you think?

And, maybe, we need to consider it as dedicated patch.

> =C2=A0	}
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0	return d_splice_alias(inode, dentry);
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index e250f87..8d52170 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -163,6 +163,11 @@ extern int hfs_cat_move(u32 cnid, struct inode
> *src_dir,
> =C2=A0extern void hfs_cat_build_key(struct super_block *sb, btree_key
> *key,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent, const struct qstr *na=
me);
> =C2=A0
> +static inline bool hfs_is_system_reserved_cnid(u32 cnid)
> +{
> +	return cnid > HFS_ROOT_CNID && cnid < HFS_FIRSTUSER_CNID;
> +}
> +
> =C2=A0/*
> =C2=A0 * Validate the CNID of a catalog record.
> =C2=A0 */
> @@ -219,6 +224,7 @@ extern void hfs_inode_read_fork(struct inode
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
> index 2aef3c3..5a03fca 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -421,6 +421,72 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int hfs_system_read_inode(struct inode *inode)
> +{
> +	struct hfs_sb_info *hsb =3D HFS_SB(inode->i_sb);
> +	struct hfs_mdb *mdb =3D hsb->mdb;
> +
> +	HFS_I(inode)->flags =3D 0;
> +	HFS_I(inode)->rsrc_inode =3D NULL;
> +	mutex_init(&HFS_I(inode)->extents_lock);
> +	HFS_I(inode)->tz_secondswest =3D sys_tz.tz_minuteswest * 60;

I am still not sure that we need it for b-trees' inodes. Do we need it?

> +
> +	inode->i_uid =3D hsb->s_uid;
> +	inode->i_gid =3D hsb->s_gid;
> +	set_nlink(inode, 1);

I assume you copied it from hfs_read_inode(). But this method is for b-
trees' inodes and I suspect that we have trouble here.

Before this patch, B-tree inodes had i_nlink =3D=3D 0, so
inode_generic_drop() returned true and the final iput() evicted them
without writeback. With nlink =3D 1, the final iput() in
hfs_btree_close() runs during put_super, when SB_ACTIVE is already
clear. iput_final() then takes the !drop branch and calls
write_inode_now(inode, 1) (fs/inode.c, iput_final). If a tree inode is
still dirty at that point:

- Extents tree (closed first): hfs_write_inode() =E2=86=92
hfs_btree_write(ext_tree) re-reads node 0 into a hash that
hfs_btree_close() has just emptied. Then kfree(tree) leaks that node.
- Catalog tree (closed second): hfs_write_inode() =E2=86=92
hfs_ext_write_extent() can touch HFS_SB(sb)->ext_tree, which has
already been freed. That's a use-after-free if the catalog's extent
record is dirty.

Are you sure that we safe here with set_nlink(inode, 1)?

> +
> +	/* may_open() requires a file type */
> +	inode->i_mode =3D S_IFREG;
> +	inode->i_mapping->a_ops =3D &hfs_btree_aops;
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
> +	return 0;
> +}
> +
> +struct inode *hfs_system_iget(struct super_block *sb, u32 cnid)
> +{
> +	struct inode *inode;
> +	int err;
> +
> +	inode =3D iget_locked(sb, cnid);
> +	if (!inode)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (!(inode_state_read_once(inode) & I_NEW)) {
> +		iput(inode);
> +		return ERR_PTR(-EEXIST);
> +	}

iget_locked() returns a fresh inode with I_NEW set if no inode with
that number exists yet in this superblock's inode cache. If one already
exists, it returns that cached inode without I_NEW. So the -EEXIST
branch fires only if an inode numbered 3 or 4 is already cached for
this superblock before hfs_btree_open() creates it. That can't happen
I suppose.

What's about this then?

        /* B-trees are opened before any catalog lookup can run */
        if (WARN_ON_ONCE(!(inode_state_read_once(inode) & I_NEW))) {
                iput(inode);
                return ERR_PTR(-EEXIST);
        }

Thanks,
Slava.

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
> @@ -446,6 +512,11 @@ struct inode *hfs_iget(struct super_block *sb,
> struct hfs_cat_key *key, hfs_cat_
> =C2=A0	default:
> =C2=A0		return NULL;
> =C2=A0	}
> +
> +	if (!hfs_is_valid_cnid(cnid, rec->type) ||
> +	=C2=A0=C2=A0=C2=A0 hfs_is_system_reserved_cnid(cnid))
> +		return NULL;
> +
> =C2=A0	inode =3D iget5_locked(sb, cnid, hfs_test_inode,
> hfs_read_inode, &data);
> =C2=A0	if (inode && (inode_state_read_once(inode) & I_NEW))
> =C2=A0		unlock_new_inode(inode);
