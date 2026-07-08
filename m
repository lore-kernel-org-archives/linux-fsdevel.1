Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65BE257435
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2026 22:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783549037; cv=none; b=OWrnfanFweMdYfwYG5ffsKbY5sPkPC1cgiG7qZtYI3DU4zehK7DDhBriK1EvzPOqdFjZRT098DhQRb4u0ocZDYPLjTUOj5YCCqk4nSzJhOWXeiTGxiGDj9ncKQIYMgjxd+xdaXWZtcDQSkNRl0r5TUKRqBrkI/gbVKaN4OnSf0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783549037; c=relaxed/simple;
	bh=WzllXPxrZ0uSlfvmWMqKaZ20b0bKfpOotcR2Hkuxnnw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nUxt6YiFbxIYyA0KQ/ozukt43s1pX5PIj6OtCblpjDIyqZJAv5eQJDpCoHvw5yP23upcZeXDuPtWrEOZLX01mT3RMDMLXtqOWZiMQVwZkoXRVQevzpZBDs/FyEpspdawbwq/OgcsKWoG9BuVFDYorHqhnP67wXNxEp+5lKrA8nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=Dbn2l+5l; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="Dbn2l+5l"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7fe36f1be74so5409927b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2026 15:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783549034; x=1784153834; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AbxxJUNcO3r1EENy6IeBWgceDWPhMkeSJ8BfFNG0V2E=;
        b=Dbn2l+5lJY+S4rZxML+jDq7WVwqtiLAj1o7wLugJSOX/rclOPT2wICeZIv59RFw9cu
         JVch7QrOSjMatuqsEGsGDnfyWPd//8QIuAes2Ve6KYDNTo5ULIBWXuq4WweXtEoEfKdO
         2871mJ4LFkgHyZ7x5UKEKH97LGQgSgWPqPWXUkleKfDM+HY7S/vfsOLuE57uSwQYcDKf
         sqVvP7Htbk17UHYL+zUuXiQDpWVrCMMN6EO1E1YvfC4JSWyb05C0uGHi6ssv7gt40B9L
         09gH0p9t67ArPy4Y7NPud3oRSNSNAPIYekzCdFPNGY4wP7Z60rRzjo/dwvM8eOx8m0So
         P4Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783549034; x=1784153834;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AbxxJUNcO3r1EENy6IeBWgceDWPhMkeSJ8BfFNG0V2E=;
        b=T1r4uY6cbsDTdK1TMfzcsVunwEpBQkkFs1xBp9KhNRCXYR36wtW8YHuY+zMxV7/Mt4
         FpxyS6aVL3iuShvF4/fWmmQ7vKLZ/KKq4rwoZLfTUQkRAW1WEoGqkbc7nl7R24T2a545
         AfiRcAcdCauhIkI1KIdWTC/PYVHTFIVwmb6X1oTrkLhv5HV43UleSj1iyyC3RSn9FGRN
         VR39mp9OH/hSZw5/jsl9yMkiSeCwj9+b7+4XbEVCg6TwqU7rNisAgImU1mqnztzY7Q3L
         +3iH+NJu55olOzKhQjZoBKgDCcphS1gSi4t3y0sWisvQaik5rdI172R9AK81yumK1+sC
         5/ag==
X-Forwarded-Encrypted: i=1; AHgh+RqK5QqxjPq+5AQs9gj9FQhFsAyC+4KUOZHoo3YmVyAeasqn+faMBZfc9j9Dn+vfkmT8Tin/QKCLmiucdn8b@vger.kernel.org
X-Gm-Message-State: AOJu0YySWyHYleKk1jB75VE5jOByFiB9RKA1iytMEVdhaZsuMpGbWeNH
	RIrN0ptJSnMYuuQ5X339K+DpSJjVviT4clneNRqqdSKfDPgb8F6RZ6SX1PnY8obR8OM=
X-Gm-Gg: AfdE7cmG9PS/h02oI3M7qjggUjWN3RLWEa84uL/6Kogb0eKXfWYU4flCIBDnd3+cJwg
	icrKotify9qCpvbDqaH1A6HbvfAlKO89G8MTE1OyiEHY7pHNVKLDPzeaLrUiIvFaGhNN+VvNybV
	TDNKsda3KNbDneHB07uyGLntVqLdVxNqUSjGP7gYvjI9pUeUOZYfhrEhMdPmEG7qS5fdzGVWiMj
	41qPfuZ8fVWxC1RDr0Q32D+4X61NQs+p/JC4cZFFFJv+HKwZI+6pahkeYTqLh3NUqxpJSn0XSZ7
	/2cdzGQVVtAGSUIGwNJwQvR0OBkIsKFv9jAX2bDWP5YCpRErKUEqBxsXik0/LUPKT3iAjMXqcg8
	p5LQr+6xlEjayElMn+emb1zqZzIq2i5/9FfxmN5VzwYoCLlstJiDebRL8kIDRNUw7Oi/hRtBfkB
	3YQLUExuk+AjjfW9Jjc4VkNr19Eu/+L57W1JlsTrEHU66iLzpu8ueukMMaODdcfK+oAuXFvixa7
	DhVm15GwhqTyWYShmyt2CKuGi8I1vKmrILftL2NRKEensHOm/yQCvwmXLX8VzOCJlBUn9PWEom2
	uzJ+8ngu/U+VmIZ/
X-Received: by 2002:a05:690c:6289:b0:81c:b865:2221 with SMTP id 00721157ae682-81dbe54fd83mr39240567b3.33.1783549033618;
        Wed, 08 Jul 2026 15:17:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:a313:50b6:1c3c:8459? ([2600:1700:6476:1430:a313:50b6:1c3c:8459])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1a44d6sm2784547b3.31.2026.07.08.15.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 15:17:13 -0700 (PDT)
Message-ID: <169699d11b667008b0b15f96f4ee5164fb31bb7f.camel@dubeyko.com>
Subject: Re: [PATCH v5] hfs: validate catalog CNIDs before instantiating
 inodes
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Maximiliano Hermitte <davemadmaxxx@gmail.com>, Jori Koolstra
	 <jkoolstra@xs4all.nl>
Cc: George Anthony Vernon <contact@gvernon.com>, Tetsuo Handa
	 <penguin-kernel@I-love.SAKURA.ne.jp>, John Paul Adrian Glaubitz
	 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
Date: Wed, 08 Jul 2026 15:17:11 -0700
In-Reply-To: <20260708215636.73815-1-davemadmaxxx@gmail.com>
References: <20260707232850.510374-1-davemadmaxxx@gmail.com>
	 <20260708215636.73815-1-davemadmaxxx@gmail.com>
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

On Wed, 2026-07-08 at 21:56 +0000, David Maximiliano Hermitte wrote:
> hfs_cat_find_brec() first resolves a catalog thread record by CNID
> and
> then looks up the corresponding catalog record by parent/name. On a
> corrupted filesystem image, the second lookup may find a record whose
> CNID does not match the CNID that was requested.
>=20
> Validate the record found by the second lookup before returning it.
> Read the already-found record with hfs_bnode_read(), require the
> exact
> fixed size for file and directory records, reject other record types,
> and verify that the stored CNID matches the requested CNID.
>=20
> Also validate reserved CNIDs in hfs_read_inode() before populating
> the
> inode, propagate hfs_read_inode() failures from the resource-fork
> lookup
> path, and reject bad resource-fork and root inodes.
>=20
> Keep hfs_write_inode() unchanged, so corrupted catalog records are
> rejected before reaching its existing reserved-CNID BUG() path.
>=20
> Reported-by: syzbot+97e301b4b82ae803d21b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D97e301b4b82ae803d21b
> Cc: George Anthony Vernon <contact@gvernon.com>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Signed-off-by: David Maximiliano Hermitte <davemadmaxxx@gmail.com>
> ---
> Changes in v5:
> - Keep rec_len signed by using int to match fd->entrylength, making
> =C2=A0 the non-positive length check meaningful before passing the
> validated
> =C2=A0 value to hfs_bnode_read().
> - Use (size_t) casts when comparing rec_len against record sizes to
> =C2=A0 avoid signed/unsigned comparisons.
> - Preserve the original error code in hfs_file_lookup(), returning
> =C2=A0 -EIO separately only when the inode is marked bad.
>=20
> Changes in v4:
> - Combine the catalog record length validation into one check.
> - Require exact sizes for file and directory catalog records.
> - Keep hfs_write_inode() unchanged following maintainer feedback.
> - Revalidate the exact final patch with the HFS build and QEMU repro.
>=20
> Changes in v3:
> - Drop the stray blank line in hfs_file_lookup().
>=20
> Changes in v2:
> - Use size_t for the catalog record length.
> - Reject catalog records larger than hfs_cat_rec.
> - Treat non-file/non-directory records as invalid.
> - Propagate hfs_read_inode() failures from resource-fork lookup.
> - Reject bad resource-fork and root inodes.
>=20
> =C2=A0fs/hfs/catalog.c | 41 ++++++++++++++++++++++++++++++++++++++++-
> =C2=A0fs/hfs/hfs_fs.h=C2=A0 | 19 +++++++++++++++++++
> =C2=A0fs/hfs/inode.c=C2=A0=C2=A0 | 13 ++++++++++++-
> =C2=A0fs/hfs/super.c=C2=A0=C2=A0 |=C2=A0 5 +++++
> =C2=A04 files changed, 76 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
> index 1bfa36d71e24..490c5e130da3 100644
> --- a/fs/hfs/catalog.c
> +++ b/fs/hfs/catalog.c
> @@ -182,6 +182,40 @@ int hfs_cat_keycmp(const btree_key *key1, const
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
> +	int rec_len;
> +
> +	rec_len =3D fd->entrylength;
> +	if (rec_len <=3D 0 || (size_t)rec_len > sizeof(rec))
> +		return -EIO;
> +
> +	memset(&rec, 0, sizeof(rec));
> +	hfs_bnode_read(fd->bnode, &rec, fd->entryoffset, rec_len);
> +
> +	switch (rec.type) {
> +	case HFS_CDR_FIL:
> +		if ((size_t)rec_len !=3D sizeof(struct hfs_cat_file))
> +			return -EIO;
> +		found_cnid =3D be32_to_cpu(rec.file.FlNum);
> +		break;
> +	case HFS_CDR_DIR:
> +		if ((size_t)rec_len !=3D sizeof(struct hfs_cat_dir))
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
> @@ -208,7 +242,12 @@ int hfs_cat_find_brec(struct super_block *sb,
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
> index ac4a9055c5c0..c9e75c2e576a 100644
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
> @@ -571,13 +577,18 @@ static struct dentry *hfs_file_lookup(struct
> inode *dir, struct dentry *dentry,
> =C2=A0	res =3D hfs_brec_read(&fd, &rec, sizeof(rec));
> =C2=A0	if (!res) {
> =C2=A0		struct hfs_iget_data idata =3D { NULL, &rec };
> -		hfs_read_inode(inode, &idata);
> +		res =3D hfs_read_inode(inode, &idata);
> =C2=A0	}
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0	if (res) {
> =C2=A0		iput(inode);
> =C2=A0		return ERR_PTR(res);
> =C2=A0	}
> +
> +	if (is_bad_inode(inode)) {
> +		iput(inode);
> +		return ERR_PTR(-EIO);
> +	}
> =C2=A0	HFS_I(inode)->rsrc_inode =3D dir;
> =C2=A0	HFS_I(dir)->rsrc_inode =3D inode;
> =C2=A0	igrab(dir);
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

Looks good. Thanks a lot for the fix.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>

I am happy to test the patch. But xfstests still has too many failures
for the case of HFS file system.

Thanks,
Slava.
