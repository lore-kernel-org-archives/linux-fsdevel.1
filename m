Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8A431E52
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 21:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940331; cv=none; b=k6od/8JbV+n2H2o3fbDn0pPdRbjxPKXidyEmHsEfrlFVm4BCeUDXMtCubhz97hlfLsdEJMRykmHKnnEcpIe3zx266IEM6iPXIScS3Xqf8LIarMWZjlypajGrcNYeHErYHeZdLiPvyZe1Kou0jR8qoaSymg7BkKg8CvFjVG1J21E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940331; c=relaxed/simple;
	bh=N6vqnhMmwHYcuSOTYMm14CPbK8+U+0N5/NkqxVpmoB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipmihWYd4OPE/eyLBaYczOAy313nmuK3S65oCG5FKdKj8HOJ4qgKeYr89wrjPAEPqvi+60lpQundplQ/bzyo29jiRwfO4IQ3CizKYEbhL6o0jxKvbe7fZWlm0NSa2sNyymyGGi799RtmkXgF/k/4dSRRyQ1LLSYyL2qFWgleD04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=jylOcuVG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="jylOcuVG"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso933833b3a.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Jul 2026 14:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1782940329; x=1783545129; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q4wzyWw5g9nZjhRhmoTw/lz1KI73QbjbprzQCzJlIv8=;
        b=jylOcuVGtTcLi21TJyDrL/pNzNkeyNuPmKYOXHy4yf8KeQuezRhYL795eZGJkF9zPE
         VNdp4mfinfZM1ukrdwFC8rEfzsQ1gh5fR5/c6daEA5M0nimpznTBgAUJ0w8sR9Iwr670
         4LNVviB6iqs0djEBS3FzVZdazam6ICbrw25V2sYjiiy58YvAaWcA02mtLQDG/4L3PMpt
         +2mLt7kNk/bTzRDklaRRGLhYOGakypwWEknVtx68/fPpYbc1/4ZxDTC7zWaXLmX448GL
         B42wK3eSOM8bjzhxUdNq5im+jm0f7p65MBMauPyByKKvGCHB/z8hUNQ/OFNlLrRJywsI
         9yFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782940329; x=1783545129;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q4wzyWw5g9nZjhRhmoTw/lz1KI73QbjbprzQCzJlIv8=;
        b=YCRlwUPwe/Rvwd76joFu96cDAnNLEtR/5zfcVsyJKqK/tpJfhc1+sgkV+izc6VK4hV
         l1M8ZAMv+N1jHZ0efgwStbG/Q3UNMARoioJFsEaEsOQypY1ZdrISaGuQ1lX3iLQt4ll2
         xSNVyb1v09Vk/C3KcHBHuqaf7h/GllCo3Y3BlFILlIeB4z3em/G2Uef/MbeT7MXYz8On
         1GYsnV+sKwSBLM+/ltKi7n+B60e2ye4foMak1r84ZWOWafSloBdAHQCedhuzzUKyXxl4
         aNaSQtKawq9m7V5olUr73uv7j7dTH28V6kJQPttmOqZvwUyMHMgJaz/CnX0pQi87KBMy
         dMLQ==
X-Forwarded-Encrypted: i=1; AFNElJ+XGekJLwjNuPeDArtR8zCvUPZMyp3usLJGpd9HR6Y1OT3hys4QhVZ/X94Byy65wI1kkLRolD4jEibGcm15@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2Ii1UA+vlXuB5jvovdAvHq5fOCGe6db/ACjlQKPcoj2xjIeZw
	+Qdc6qhXSIHF8GnudM25jk/eV3A/dY1OOjP0O473wRzjLkzvGhS8j1gHoWZShW4OKho=
X-Gm-Gg: AfdE7clWG+hXh8h9JoD/s4uDuehIoyDqjsFodwUr5P1fSh34CDr8Ey+tgh5LP/WpcNX
	hIPuw5YjpYCT92AwPplqLT3Uwg+nWxiLWkno3G5eQxMdvQ7xebUsy7q/nF8klEh5DPIMGMyYTrE
	qoAeRLmpekRkbY+e17C93VBGvajiKqVe7LwbmkYNkKJX/fJb46pVdyqK7XXT9/JTObiuP3O1lqq
	oXoe0aqlcJjNFe4sWEpYlWjYD7AH9VXW1suk0HEFY3GNqrJNh4jesoKtwNZgfR/eJ43MPUjd/Lw
	1tYaS3HhrIYdlDBldU/kvlV+hItZrBQ9SdGwUSDPn+b02cz+AoXISTkh4sJqL78mRrvBvkZ4t1P
	4Lu24WDf+cjk45iuGkXK8iV+lC9msVtALnsdsg5ACwV+JJTPRF0EFnYSB4hFwYo4fFGXoss6Anz
	9qL2UvwMfrcmvVUu53zM2GPy6yciMaXDk8qourGm7+kg0W+AtJ9lnAx9PeJeukU9UlXzuezmB42
	fAkx3988kGwmqXKlBU+U6dttHaOoSayG+gMNK31JQEoCMKerD8HSAmUjslfMVc1aAvBCOgr0WNr
	Jcrm8W8=
X-Received: by 2002:a05:6300:6701:b0:3bf:d487:4b42 with SMTP id adf61e73a8af0-3bfed471dc5mr3877176637.35.1782940329357;
        Wed, 01 Jul 2026 14:12:09 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b3c80b3bbsm1627938c88.8.2026.07.01.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 14:12:08 -0700 (PDT)
Message-ID: <9baf5021b33fc49a96b5f451d6c9e140cbd22676.camel@dubeyko.com>
Subject: Re: [PATCH/RFC] hfs: validate catalog CNIDs before writeback
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org
Date: Wed, 01 Jul 2026 14:12:04 -0700
In-Reply-To: <20260630205924.896357-1-davemadmaxxx@gmail.com>
References: <20260630205924.896357-1-davemadmaxxx@gmail.com>
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

On Tue, 2026-06-30 at 20:59 +0000, David Maximiliano Hermitte wrote:
> Hi Slava,
>=20
> Thank you again for the previous review.
>=20
> I reworked the HFS patch following your feedback. This version
> uses a focused CNID validator for catalog records.
>=20
> The patch now:
>=20
> - adds hfs_is_valid_cnid();
> - validates file and directory CNIDs in hfs_read_inode();
> - marks invalid catalog records as bad inodes;
> - rejects a bad root inode in hfs_fill_super();
> - validates the found catalog record in hfs_cat_find_brec();
> - keeps BUG() in hfs_write_inode() for internal impossible state.
>=20
> Local validation:
>=20
> - git diff --check: pass
> - reverse apply check: pass
> - checkpatch strict: 0 errors
> - make fs/hfs/: pass
> - make bzImage: pass
> - QEMU HFS repro: started and completed
> - no kernel BUG, Oops, panic, KASAN, UBSAN, or GPF observed
>=20
> The goal is to treat corrupted on-disk catalog metadata as
> filesystem corruption, without crashing the kernel.
>=20
> Please let me know whether this matches the expected direction.
>=20
> Thanks,
> David
>=20
> ---
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 632c226a3..87aa45db4 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -184,6 +184,31 @@ int hfs_cat_keycmp(const btree_key *key1, const
> btree_key *key2)
> =C2=A0
> =C2=A0/* Try to get a catalog entry for given catalog id */
> =C2=A0// move to read_super???

It is comment for the hfs_cat_find_brec().

> +static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd)
> +{
> +	hfs_cat_rec rec;
> +	int err;
> +
> +	err =3D hfs_brec_read(fd, &rec, sizeof(rec));

I think that hfs_brec_read() is not correct method here. We need to use
hfs_bnode_read().

> +	if (err)
> +		return err;
> +
> +	switch (rec.type) {
> +	case HFS_CDR_FIL:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec.file.FlNum),
> HFS_CDR_FIL))

We need to check not only validity but if we have the CNID that we
tried to find.

> +			return -EFSCORRUPTED;
> +		break;
> +	case HFS_CDR_DIR:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec.dir.DirID),
> HFS_CDR_DIR))
> +			return -EFSCORRUPTED;
> +		break;
> +	default:
> +		return -EFSCORRUPTED;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hfs_find_data *fd)
> =C2=A0{
> @@ -208,7 +233,11 @@ int hfs_cat_find_brec(struct super_block *sb,
> u32 cnid,
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0	memcpy(fd->search_key->cat.CName.name,
> rec.thread.CName.name, len);
> -	return hfs_brec_find(fd);
> +	err =3D hfs_brec_find(fd);
> +	if (err)
> +		return err;
> +
> +	return hfs_cat_validate_found_cnid(fd);
> =C2=A0}
> =C2=A0
> =C2=A0
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index 49d02524e..d0eb10c4b 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -186,6 +186,30 @@ extern void hfs_cat_build_key(struct super_block
> *, btree_key *, u32, const stru
> =C2=A0
> =C2=A0/* dir.c */
> =C2=A0extern const struct file_operations hfs_dir_operations;
> +
> +/*
> + * Validate the CNID of a catalog record.
> + */
> +static inline bool hfs_is_valid_cnid(u32 cnid, u8 type)
> +{
> +	if (likely(cnid >=3D HFS_FIRSTUSER_CNID))
> +		return true;
> +
> +	switch (cnid) {
> +	case HFS_ROOT_CNID:
> +		return type =3D=3D HFS_CDR_DIR;
> +	case HFS_EXT_CNID:
> +	case HFS_CAT_CNID:
> +		return type =3D=3D HFS_CDR_FIL;
> +	case HFS_POR_CNID:
> +	case HFS_BAD_CNID:
> +	case HFS_EXCH_CNID:
> +		return false;
> +	default:
> +		return false;
> +	}
> +}
> +
> =C2=A0extern const struct inode_operations hfs_dir_inode_operations;
> =C2=A0
> =C2=A0/* extent.c */
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index 61ed76d10..90d676dc9 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -344,6 +344,11 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	rec =3D idata->rec;
> =C2=A0	switch (rec->type) {
> =C2=A0	case HFS_CDR_FIL:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec->file.FlNum),
> HFS_CDR_FIL)) {
> +			pr_warn_ratelimited("hfs: invalid file CNID
> %u; run fsck\n",
> +					=C2=A0=C2=A0=C2=A0 be32_to_cpu(rec-
> >file.FlNum));

What about "running fsck.hfsplus is recommended"?

> +			goto bad_inode;
> +		}
> =C2=A0		if (!HFS_IS_RSRC(inode)) {
> =C2=A0			hfs_inode_read_fork(inode, rec->file.ExtRec,
> rec->file.LgLen,
> =C2=A0					=C2=A0=C2=A0=C2=A0 rec->file.PyLen,
> be16_to_cpu(rec->file.ClpSize));
> @@ -365,6 +370,11 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0		inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0		break;
> =C2=A0	case HFS_CDR_DIR:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec->dir.DirID),
> HFS_CDR_DIR)) {
> +			pr_warn_ratelimited("hfs: invalid directory
> CNID %u; run fsck\n",
> +					=C2=A0=C2=A0=C2=A0 be32_to_cpu(rec-
> >dir.DirID));
> +			goto bad_inode;
> +		}
> =C2=A0		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> =C2=A0		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> =C2=A0		HFS_I(inode)->fs_blocks =3D 0;
> @@ -375,9 +385,15 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0		inode->i_fop =3D &hfs_dir_operations;
> =C2=A0		break;
> =C2=A0	default:
> -		make_bad_inode(inode);
> +		pr_warn_ratelimited("hfs: invalid catalog record
> type %u; run fsck\n",
> +				=C2=A0=C2=A0=C2=A0 rec->type);

I am not sure that if we make bad inode, then we always have
corruption. I don't think that we need this message here.

> +		goto bad_inode;
> =C2=A0	}
> =C2=A0	return 0;
> +
> +bad_inode:
> +	make_bad_inode(inode);
> +	return 0;

What is this?

Thanks,
Slava.

> =C2=A0}
> =C2=A0
> =C2=A0/*
> @@ -435,20 +451,20 @@ int hfs_write_inode(struct inode *inode, struct
> writeback_control *wbc)
> =C2=A0	if (res)
> =C2=A0		return res;
> =C2=A0
> -	if (inode->i_ino < HFS_FIRSTUSER_CNID) {
> -		switch (inode->i_ino) {
> -		case HFS_ROOT_CNID:
> -			break;
> -		case HFS_EXT_CNID:
> -			hfs_btree_write(HFS_SB(inode->i_sb)-
> >ext_tree);
> -			return 0;
> -		case HFS_CAT_CNID:
> -			hfs_btree_write(HFS_SB(inode->i_sb)-
> >cat_tree);
> -			return 0;
> -		default:
> -			BUG();
> -			return -EIO;
> -		}
> +	if (!hfs_is_valid_cnid(inode->i_ino,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 S_ISDIR(inode->i_mode) ? HFS_CDR=
_DIR
> :
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HFS_CDR_FIL))
> +		BUG();
> +
> +	switch (inode->i_ino) {
> +	case HFS_EXT_CNID:
> +		hfs_btree_write(HFS_SB(inode->i_sb)->ext_tree);
> +		return 0;
> +	case HFS_CAT_CNID:
> +		hfs_btree_write(HFS_SB(inode->i_sb)->cat_tree);
> +		return 0;
> +	default:
> +		break;
> =C2=A0	}
> =C2=A0
> =C2=A0	if (HFS_IS_RSRC(inode))
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index 53800105e..9428cd7fe 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -432,7 +432,7 @@ static int hfs_fill_super(struct super_block *sb,
> void *data, int silent)
> =C2=A0	res =3D -EINVAL;
> =C2=A0	root_inode =3D hfs_iget(sb, &fd.search_key->cat, &rec);
> =C2=A0	hfs_find_exit(&fd);
> -	if (!root_inode)
> +	if (!root_inode || is_bad_inode(root_inode))
> =C2=A0		goto bail_no_root;
> =C2=A0
> =C2=A0	sb->s_d_op =3D &hfs_dentry_operations;
