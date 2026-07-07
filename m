Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624E63D5252
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783454573; cv=none; b=pe95AEY/0KNHSyQatZPmfcFNxjCt4opDjap5x1CTkpazNFKFxiy8cCldVhJJCxizK6G/ofDa8s4a2xuDW9EQIeyKrG+1FLIOUvyXT9bOHBM/8ZEsmY+B/K++YCXEEaQvhKsHubdjUJs4ATR5FaAf7iqaZHtOv2PzC4Qg3prwk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783454573; c=relaxed/simple;
	bh=wj3WodX6GQdGP1WGyeQ7jc3Sj3uf42d9UeIOrihnPZ4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tls1TOq4JaD8OKP92iafTxyHnKTBq8GW2fALsGaph3dC/nQbb3U7LSLE8h3R38idzUIJPHVAWj/U/aaJHAp4Ti9kyKoXZjGVKblwWs810FRnWmvx8VTIBJDF/e8V3FJJwiVSyPv2aTm+TXzFK2P7dsmjB+iD0S/ab0obkaLKvL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=r8hBjwWv; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="r8hBjwWv"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-664cdeab266so6935710d50.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 13:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783454569; x=1784059369; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VmXvPBXUWn7bf8/27y4wkrYXlio6oyuAlI5wIu+uQjM=;
        b=r8hBjwWvCN0RIiXnW/KNXR/tDxdXie2dJtx4nT1cTB+vcD/v7MqRzaZhjSchdTIofa
         BtJSzxidh0TK/mt252ZGbL4knPhNUmpTHlVz6OXUkFrMWXJwPPkut0h9jU6QI+8/ew2F
         YrFqpv+f8HpIiy0Qd3dNu0oARfq0tIUkg3fFbd72bXyNTlvRdl1mldmGG/v4VwIGcvWm
         mkOzpGHyXL5xUtFbJNBzJhT5Rm3ExHcshM4t94JEUpmFJPpIrLeXxOL8/rzind6jvWPs
         vrQ9ipmD0OHIb65x84VVnvkgShFlcMa062YJlLIweP0xolpA4HDEmJXFTfBxmSFjrvtN
         jMVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783454569; x=1784059369;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=VmXvPBXUWn7bf8/27y4wkrYXlio6oyuAlI5wIu+uQjM=;
        b=T65PfPSYAEAHArIa0LmYGMvW1fJ5uZ76rmXGKqpRK79UHr8qV0y6SODeaRwj2ttYrj
         ydSJ7NfEwKyrBEZoVi0cyncrVnY43C7O69X4n9UU5JlgICI0n/tnyf4Jrv//I8f5Oxhh
         ehX5pNTzNRnigsoP6Tyja+gnulaYL96Py1+8yM3wyu4OGdJFXgBxhJugIvLRmZPeg2sg
         7QhLX1g1k7SE4jzGxJYMUxGI57ZOWIQxkpyWVkTIAevH5ZMjk0yrLgtHI/xV9ccjgCzE
         /dBH3xt2XaYTt+z0v8p/vOH4vJxl4hyDfK4FJrvfQGueaqus3ncSv3SoJ0Lye4fXJ99u
         b9uQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWpKsxUodNaXLMIWto5rvz7gFT98+st2YOPT9MTkznF1C09FXZZHTXeZSuXc8Ts+F3E7XLEDen+uL0aHSH@vger.kernel.org
X-Gm-Message-State: AOJu0Yz84taIp2wDNJsUBufXRTsQyfQ00vxPEd4LWJsWN4nXOaV+kSov
	KJSV4R3O3kBs5KYdLNTzK/EenHY2EWsk3xLbfHrk3h8VSPgmBJBzYCrAHfesghR2oPU=
X-Gm-Gg: AfdE7clsKQoEkA57YcvwI0gl7y7D0+JLoX+G+aJ9Lk6/1acu6D0snJbZVZi1udXw1cV
	ftF5SySNNumU6NkTA6dGSQK+FSf+F7O9CXWi7QYofGVDJVn/XJghevqOu0WyLR2ZJE9aUTOxjrz
	Mi8ydl0bqdz3uPJGLkwV2J/wjqIw/FZFHUBMJcE//kilbR00GfAbur06ETugO4PkZMBRZzNxuz7
	URs0cNd2Dol71umfTpmEfy/GMaV90GioFn9AFE2yH4omigecy+9tnVJcFr9nVu5BSsSoC2ykx1V
	ON2RPtSImpvIL/SD237iKpQPftpI4bViKYn25WOkLfUItXgC7nlAzJVbgIs7U3n4vLWfq+QwYJR
	lSAR7xhUl7BAj2T0nUn+hxjXkd0/9P7/7p2P7X+9/gas+hPfyeqF/PnxBgS0mlXrw8ckKAeskQg
	0rs7b+HlgDDYUI9LVcIyKbLk8gcPtNvtjqthk7ACrt0k28gMb0DRq4wLLCKBNITZJLAXppcMk95
	ZWOmi23Q0XikZPvuhWvzh62VRqnRhkZpej386IUgGCJmZSWiCt/Qcx9V11sH7DfizLbG1LGBElU
	4tZaJRRfbQGitFpR
X-Received: by 2002:a05:690e:1a9f:b0:667:8b90:3572 with SMTP id 956f58d0204a3-6678b90517bmr1856512d50.100.1783454569060;
        Tue, 07 Jul 2026 13:02:49 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:daa5:7e29:8095:10b2? ([2600:1700:6476:1430:daa5:7e29:8095:10b2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6678775d505sm1291599d50.1.2026.07.07.13.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 13:02:48 -0700 (PDT)
Message-ID: <7f700f4bc68de5daf4d5d28e574a486a04806fb9.camel@dubeyko.com>
Subject: Re: [PATCH v3 RESEND] hfs: validate catalog CNIDs before
 instantiating inodes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>, Tetsuo Handa
	 <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Tue, 07 Jul 2026 13:02:46 -0700
In-Reply-To: <20260706095943.258065-1-davemadmaxxx@gmail.com>
References: <20260702183800.1119202-1-davemadmaxxx@gmail.com>
	 <20260706095943.258065-1-davemadmaxxx@gmail.com>
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

On Mon, 2026-07-06 at 09:59 +0000, David Maximiliano Hermitte wrote:
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
> Changes in v3:
> - Drop the stray blank line before assigning the hfs_read_inode()
> result
> =C2=A0 in hfs_file_lookup().
>=20
> Changes in v2:
> - Use size_t for the catalog record length.
> - Return -EIO when fd->entrylength is larger than hfs_cat_rec instead
> of
> =C2=A0 truncating the record length.
> - Compare catalog record lengths against sizeof(struct hfs_cat_file)
> and
> =C2=A0 sizeof(struct hfs_cat_dir).
> - Drop the hfs_is_valid_cnid() call from the found-record CNID
> =C2=A0 comparison; found_cnid !=3D cnid is enough there.
> - Treat non-file/non-directory records found by the second lookup as
> =C2=A0 invalid for this path.
> - Check is_bad_inode() in the resource-fork lookup error path.
> - Drop the redundant root DirID check from hfs_fill_super().
>=20
> =C2=A0fs/hfs/catalog.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
> =C2=A0fs/hfs/hfs_fs.h=C2=A0 | 19 +++++++++++++++++++
> =C2=A0fs/hfs/inode.c=C2=A0=C2=A0 | 12 +++++++++---
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A04 files changed, 76 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 1bfa36d71e24..50ee709d966f 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -182,6 +182,43 @@ int hfs_cat_keycmp(const btree_key *key1, const
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
> +	size_t rec_len;
> +
> +	if (fd->entrylength <=3D 0)
> +		return -EIO;
> +
> +	rec_len =3D fd->entrylength;
> +	if (rec_len > sizeof(rec))
> +		return -EIO;

Why do not have one check?

rec_len =3D fd->entrylength;
if (rec_len <=3D 0 || rec_len > sizeof(rec))
    return -EIO;

> +
> +	memset(&rec, 0, sizeof(rec));
> +	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
> +
> +	switch (rec.type) {
> +	case HFS_CDR_FIL:
> +		if (rec_len < sizeof(struct hfs_cat_file))

rec_len !=3D sizeof(struct hfs_cat_file)?

> +			return -EIO;
> +		found_cnid =3D be32_to_cpu(rec.file.FlNum);
> +		break;
> +	case HFS_CDR_DIR:
> +		if (rec_len < sizeof(struct hfs_cat_dir))

rec_len !=3D sizeof(struct hfs_cat_dir)?

> +			return -EIO;
> +		found_cnid =3D be32_to_cpu(rec.dir.DirID);
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	if (found_cnid !=3D cnid)
> +		return -EIO;
> +
> +	return 0;
> +}
> +
> =C2=A0/* Try to get a catalog entry for given catalog id */
> =C2=A0// move to read_super???
> =C2=A0int hfs_cat_find_brec(struct super_block *sb, u32 cnid,
> @@ -208,7 +245,12 @@ int hfs_cat_find_brec(struct super_block *sb,
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
> index ac4a9055c5c0..ee10a9257a13 100644
> --- a/fs/hfs/inode.c
> +++ b/fs/hfs/inode.c
> @@ -367,6 +367,9 @@ static int hfs_read_inode(struct inode *inode,
> void *data)

Have you decided not to have the hfs_is_valid_cnid() for the case of
hfs_write_inode()?

Thanks,
Slava.

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
> @@ -571,12 +577,12 @@ static struct dentry *hfs_file_lookup(struct
> inode *dir, struct dentry *dentry,
> =C2=A0	res =3D hfs_brec_read(&fd, &rec, sizeof(rec));
> =C2=A0	if (!res) {
> =C2=A0		struct hfs_iget_data idata =3D { NULL, &rec };
> -		hfs_read_inode(inode, &idata);
> +		res =3D hfs_read_inode(inode, &idata);
> =C2=A0	}
> =C2=A0	hfs_find_exit(&fd);
> -	if (res) {
> +	if (res || is_bad_inode(inode)) {
> =C2=A0		iput(inode);
> -		return ERR_PTR(res);
> +		return ERR_PTR(-EIO);
> =C2=A0	}
> =C2=A0	HFS_I(inode)->rsrc_inode =3D dir;
> =C2=A0	HFS_I(dir)->rsrc_inode =3D inode;
> diff --git a/fs/hfs/super.c b/fs/hfs/super.c
> index a466c401f6bb..98b80795bcde 100644
> --- a/fs/hfs/super.c
> +++ b/fs/hfs/super.c
> @@ -372,6 +372,11 @@ static int hfs_fill_super(struct super_block
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
