Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169553BE156
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 23:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783036785; cv=none; b=ZFPkeawUFDRwCMpoORCDHtkfDwbydngAWGKPn3yqKazQKtgChzDl/gxDY2ROi6wFXjzYKMmjaknBzdT1/j+VmbvKbrIIu+mfGtLDbNug3Azk0NesZEdboFr26m6e/lkwZHQjNHJhqi7nFTNnYnA2a8Tl/kMVyu4V2O3CL/izHRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783036785; c=relaxed/simple;
	bh=V5OX0TMdtJmDuWAkBJN5Wb/QQ1n5NIo6TDFqF/tIaVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gdu1aUcXgwXPClENUp5InNKbhIqReorZQMM2LaMAeOrDfFIvzLSbH/DOyKSA4z6JcIZ3ZHA3y4lpynT7eIWTFKrOAiLxN1jWe7MBQp5/LJlBN1dxQhJhab7PNl6ZtLu2Xy+LhPmPyvx2+X4x3VLf9jBPmn3IEQRpxjC1YuCz6Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=IiHvxUUY; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="IiHvxUUY"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38101f85591so672958a91.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Jul 2026 16:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783036783; x=1783641583; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OcFnChr9omzL4R68clXYzlZ8MxLUHIgHq1HKULbBZeg=;
        b=IiHvxUUYwooNjYvpecE2f+OIxqUKD8DHdSXoxJbh5H8hAmUghbVGDfHWz010TZULSQ
         Y9KU/zqNoXc7jJqgUVDfiUu5yppUdjYQtvLDp5YYnzTiKlAXRRXWOcbLPwzHOERpWqOP
         Rz1wSWTs+T/XdDJzmBVtHNEzEoEHkUzaKyUqK7Rqx8eUxx+jBUJRJRxMIq0qDqIzPlnA
         qYFQqJ9dvSL0FUqViVJyyhSDvgPDrrAnSYoNruipT42LJpf5DYtsq+DWCuwWRylX5N6A
         hfOkKRfd6nUmvrCkbrfVvDAXQM4/f1JZUvqDzWm5pHg+FK1fSXLOpHAECNvxqiNg9xQY
         bNrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783036783; x=1783641583;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OcFnChr9omzL4R68clXYzlZ8MxLUHIgHq1HKULbBZeg=;
        b=YUqoUbztJSDvD58gsTkDd/myvC3US1OB6XFqHXurh7ALOIktJVhxOiHI1WOmooAqF8
         YDVoPiHJp6k70CLbBhFlAFAFlkLVCD6aLdvPkbQOp2zR2B1Ym3JiSqYx84nRMc+/VuZP
         eHLCRQCTA1zG6/wM9/yKZ8qKy3G/eyGwjaZo/PtyLywz+qhUXYN+l2AAQJ6J4UBTZyLu
         9bnBr/ulOD9STHT2cZMg6yKbfl/n56v6Alb16gDDFQOYdax7BxKM0lgD9T7kGTt47MMO
         I2bZ454y3Ck+RNmw/VtBtBVJEoCNC47Zib6wDk9qR7U7wc4j/IcaiJVy3y8ZnlSgRm8f
         VhBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqxMJGUS0cp/BCwnmSJ7uSY4gp6J8152Hib17OKvhtHNaWqBteGz1reGJjwLN3HlkEdA7hTk2/DqBr5OkVT@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3xtw5FEacRRTKQmPkGvzcLr3X8qzuIqVBaFWhLRF5APg3c7sg
	d4QJxit9QhfrRmplTzBiJgt8QmTrb+HjMSII3uSotjr0XILncwyiQwALmdN8C3V1Hr59ewrWJgo
	HQ1B99ATEtg==
X-Gm-Gg: AfdE7ckdXjMP9TZHHgKcn4H7/+JCjFCGt6hZwmWHTJtFm35HHQRdO/N55/l502/rRD2
	tqxJPNlxylrXhlkoc8953rF+np66QkMb7yP13waXPN7L3j826mDBws/iclwwnr7K9RlQoIDB1RK
	CSsEwOyIqpMxImUCFNFvxLHXPwDMUHs5TuBHz/MWldIaE/740JkGUTajS3GKAY/SKgBPbo9M11Y
	1w1+WJ+wiRDAV0+JgOYEBH15TgVHuoLMhAfuGPXPgJqFG2EZRkjq2JNYPKz4u4nV8GWsYrtDVNu
	Fsmm3a9dFXgxb8YU6Hyo6UAKOoV2JljS8wwwV9IG+iLZi44i1wT/S6qCJJCzJxo7ll8ldKijofy
	mHaABmyZoJJqrs88SgfJSIOkuwC7zSQo5Ww3uXHusdDszMiqz/yBn8nnHQPgFbygk1ueomoH9WY
	KqMan3Og5ZYNyCt5BJGXcG6D9Jsr7py6fmDyFvICgXzY2FcwpF4hyTvH4kAb6YnWQiDUtkwM8kQ
	obU2Ms848ecn2RtLBxYRuVmrGCjRjq/Y8brvMJel05n7N8ROW+X3YxN/bMLii630XOP4/oU12zQ
	65BF6TA=
X-Received: by 2002:a17:90b:5251:b0:380:8bb9:aba9 with SMTP id 98e67ed59e1d1-38112063c22mr2272880a91.3.1783036783261;
        Thu, 02 Jul 2026 16:59:43 -0700 (PDT)
Received: from [10.0.0.3] (162-197-212-70.lightspeed.sntcca.sbcglobal.net. [162.197.212.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7bb8fasm13237482eec.1.2026.07.02.16.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 16:59:42 -0700 (PDT)
Message-ID: <b12eec5f2cafc5f1d2dbf60d172b930d4bee5b5d.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: validate catalog CNIDs before instantiating inodes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>, Tetsuo Handa
	 <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Thu, 02 Jul 2026 16:59:41 -0700
In-Reply-To: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
References: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
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

On Thu, 2026-07-02 at 18:38 +0000, David Maximiliano Hermitte wrote:
> hfs_cat_find_brec() first resolves a catalog thread record by CNID
> and
> then looks up the corresponding catalog record by parent/name. On a
> corrupted filesystem image, the second lookup may find a record whose
> CNID does not match the CNID that was requested.
>=20
> Validate the catalog record found by the second lookup before
> returning
> it to callers. Inspect the already-found record with
> hfs_bnode_read(),
> not hfs_brec_read(), and reject records whose CNID is invalid for
> their
> record type or does not match the requested CNID.
>=20
> Also validate CNIDs in hfs_read_inode() before the inode is
> populated,
> and propagate hfs_read_inode() errors from the resource-fork lookup
> path.
> For the root inode path, require the root catalog record to be a
> directory
> with DirID =3D=3D HFS_ROOT_CNID, and drop the root inode reference if it
> was
> instantiated as a bad inode.
>=20
> This keeps hfs_write_inode() unchanged and prevents corrupted catalog
> records from reaching the existing reserved-CNID BUG() path during
> writeback.
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b
> Cc: George Anthony Vernon <contact@gvernon.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> ---
> =C2=A0fs/hfs/catalog.c | 48
> +++++++++++++++++++++++++++++++++++++++++++++++-
> =C2=A0fs/hfs/hfs_fs.h=C2=A0 | 19 +++++++++++++++++++
> =C2=A0fs/hfs/inode.c=C2=A0=C2=A0 |=C2=A0 9 ++++++++-
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0 |=C2=A0 8 +++++++-
> =C2=A04 files changed, 81 insertions(+), 3 deletions(-)
>=20
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 1bfa36d71e24..fa2a0a5975e3 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -182,6 +182,47 @@ int hfs_cat_keycmp(const btree_key *key1, const
> btree_key *key2)
> =C2=A0			=C2=A0 key2->cat.CName.name, key2-
> >cat.CName.len);
> =C2=A0}
> =C2=A0
> +static int hfs_cat_validate_found_cnid(struct hfs_find_data *fd, u32
> cnid)
> +{
> +	hfs_cat_rec rec;
> +	u32 found_cnid;
> +	unsigned int rec_len;

I prefer to see the size_t here.

> +	size_t cnid_off;
> +
> +	if (fd->entrylength <=3D 0)
> +		return -EIO;
> +
> +	if ((unsigned int)fd->entrylength > sizeof(rec))

The hfs_cat_rec union is big enough to keep any type of record in
Catalog File. If fd->entrylength is bigger one, then it sounds like a
incorrect behavior or corruption. We cannot silently process such
situation.

> +		rec_len =3D sizeof(rec);
> +	else
> +		rec_len =3D fd->entrylength;
> +
> +	memset(&rec, 0, sizeof(rec));
> +	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
> +
> +	switch (rec.type) {
> +	case HFS_CDR_FIL:
> +		cnid_off =3D offsetof(struct hfs_cat_file, FlNum);
> +		if ((size_t)rec_len < cnid_off +
> sizeof(rec.file.FlNum))
> +			return -EIO;

If you would like to check that size of the record, then you don't need
to do this weird logic.

typedef union hfs_cat_rec {
	s8 type;			/* The type of entry */
	struct hfs_cat_file file;
	struct hfs_cat_dir dir;
	struct hfs_cat_thread thread;
} hfs_cat_rec;

You can simply compare with particular structure size.

> +		found_cnid =3D be32_to_cpu(rec.file.FlNum);
> +		break;
> +	case HFS_CDR_DIR:
> +		cnid_off =3D offsetof(struct hfs_cat_dir, DirID);
> +		if ((size_t)rec_len < cnid_off +
> sizeof(rec.dir.DirID))
> +			return -EIO;

Ditto.

> +		found_cnid =3D be32_to_cpu(rec.dir.DirID);
> +		break;
> +	default:
> +		return -EIO;

Are we sure that thread record cannot be checked by this logic?

> +	}
> +
> +	if (!hfs_is_valid_cnid(found_cnid, rec.type) || found_cnid
> !=3D cnid)

We don't need to call hfs_is_valid_cnid() because found_cnid !=3D cnid is
completely enough.

> +		return -EIO;
> +
> +	return 0;
> +}
> +
> =C2=A0/* Try to get a catalog entry for given catalog id */
> =C2=A0// move to read_super???
> =C2=A0int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
> @@ -208,7 +249,12 @@ int hfs_cat_find_brec(struct super_block *sb,
> u32 cnid,
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0	memcpy(fd->search_key->cat.CName.name,
> rec.thread.CName.name, len);
> -	return hfs_brec_find(fd);
> +
> +	res =3D hfs_brec_find(fd);
> +	if (res)
> +		return res;
> +
> +	return hfs_cat_validate_found_cnid(fd, cnid);
> =C2=A0}
> =C2=A0
> =C2=A0static inline
> diff --git a/fs/hfs/hfs_fs.h b/fs/hfs/hfs_fs.h
> index f3624514fcb0..670638f17438 100644
> --- a/fs/hfs/hfs_fs.h
> +++ b/fs/hfs/hfs_fs.h
> @@ -155,6 +155,25 @@ extern int hfs_cat_move(u32 cnid, struct inode
> *src_dir,
> =C2=A0extern void hfs_cat_build_key(struct super_block *sb, btree_key
> *key,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u32 parent, const struct qstr *na=
me);
> =C2=A0
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
> +	default:
> +		return false;
> +	}
> +}
> +
> =C2=A0/* dir.c */
> =C2=A0extern const struct file_operations hfs_dir_operations;
> =C2=A0extern const struct inode_operations hfs_dir_inode_operations;
> diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
> index ac4a9055c5c0..c685f1bb7009 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -367,6 +367,9 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0	rec =3D idata->rec;
> =C2=A0	switch (rec->type) {
> =C2=A0	case HFS_CDR_FIL:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec->file.FlNum),
> rec->type))
> +			return -EIO;
> +
> =C2=A0		if (!HFS_IS_RSRC(inode)) {
> =C2=A0			hfs_inode_read_fork(inode, rec->file.ExtRec,
> rec->file.LgLen,
> =C2=A0					=C2=A0=C2=A0=C2=A0 rec->file.PyLen,
> be16_to_cpu(rec->file.ClpSize));
> @@ -390,6 +393,9 @@ static int hfs_read_inode(struct inode *inode,
> void *data)
> =C2=A0		inode->i_mapping->a_ops =3D &hfs_aops;
> =C2=A0		break;
> =C2=A0	case HFS_CDR_DIR:
> +		if (!hfs_is_valid_cnid(be32_to_cpu(rec->dir.DirID),
> rec->type))
> +			return -EIO;
> +
> =C2=A0		inode->i_ino =3D be32_to_cpu(rec->dir.DirID);
> =C2=A0		inode->i_size =3D be16_to_cpu(rec->dir.Val) + 2;
> =C2=A0		HFS_I(inode)->fs_blocks =3D 0;
> @@ -571,7 +577,8 @@ static struct dentry *hfs_file_lookup(struct
> inode *dir, struct dentry *dentry,
> =C2=A0	res =3D hfs_brec_read(&fd, &rec, sizeof(rec));
> =C2=A0	if (!res) {
> =C2=A0		struct hfs_iget_data idata =3D { NULL, &rec };
> -		hfs_read_inode(inode, &idata);
> +

Do we really need empty line here?

> +		res =3D hfs_read_inode(inode, &idata);
> =C2=A0	}
> =C2=A0	hfs_find_exit(&fd);


I believe we need something like this here:

if (res || is_bad_inode(inode)) {
   iput(inode);
   return ERR_PTR(-EIO);
}

> =C2=A0	if (res) {
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a466c401f6bb..5275936304c7 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -361,7 +361,8 @@ static int hfs_fill_super(struct super_block *sb,
> struct fs_context *fc)
> =C2=A0			goto bail_hfs_find;
> =C2=A0		}
> =C2=A0		hfs_bnode_read(fd.bnode, &rec, fd.entryoffset,
> fd.entrylength);
> -		if (rec.type !=3D HFS_CDR_DIR)
> +		if (rec.type !=3D HFS_CDR_DIR ||
> +		=C2=A0=C2=A0=C2=A0 be32_to_cpu(rec.dir.DirID) !=3D HFS_ROOT_CNID)

This check is completely not necessary here because
hfs_cat_validate_found_cnid() will execute the CNID check.

Thanks,
Slava.

> =C2=A0			res =3D -EIO;
> =C2=A0	}
> =C2=A0	if (res)
> @@ -372,6 +373,11 @@ static int hfs_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	if (!root_inode)
> =C2=A0		goto bail_no_root;
> =C2=A0
> +	if (is_bad_inode(root_inode)) {
> +		iput(root_inode);
> +		goto bail_no_root;
> +	}
> +
> =C2=A0	set_default_d_op(sb, &hfs_dentry_operations);
> =C2=A0	res =3D -ENOMEM;
> =C2=A0	sb->s_root =3D d_make_root(root_inode);
