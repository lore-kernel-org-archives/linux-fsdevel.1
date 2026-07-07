Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD33932F1
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 19:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453687; cv=none; b=jV+oG8S73vXFTcq7MHAwfFFEdVwT5H00g3lTjjQUcbEpL8+wt3STd+5SCQzPoYYPKfdR7kM9QsTQFOBNHxXX4de+rK1SkR2M80eUENKfmpn0sgDuu3YxA9ik8MbiTkTt0f5MUjTUno+JjhjgfZVaxyMCLJYnKE9sRzn1QKfsXBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453687; c=relaxed/simple;
	bh=LxNcaK4vXIuE5cQviBJK/E1swzFTVIU8x+3GxWsK0dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+grpcDIDUEjd9FGRzKIEXLr69dJh1eOMTNf3OnrhgysNIj5DlNJ3Mo3WYSUUFDk7B/30t5TanmIuxmT7wD3OX3zSs1Opij3ShZal1M48uNLaoqbrx5aoXelkOOuT1gXMA9VzJ6kFey4o5Pj7UYWYZBV/eYpMfvZEsUS05JWlVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=zIZf5vQ+; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="zIZf5vQ+"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7dbcb505578so41816107b3.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Jul 2026 12:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1783453685; x=1784058485; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLFn4LffXjts2fvbUwfMoYEaq+LjCaJSArAHkHvbD4s=;
        b=zIZf5vQ+gYZlukR/koTjmUweoyew24upIZlAPSWektlHwKH0TXufwQ0CNQSbQJg4/d
         x3kx5dpk5DEg6mOOcls5H6sukP/jWsbBfi+YxN78yElXAFBtuockag6r/U7ckWfBJgSR
         okp+9PSFUIBotq3KQwXwIHmgD/qRGibELOY2i0Zcj0SbSwRqaZHbYKgDUOeVZRfIheaP
         fvcUSvX6SaRVaqt/Qh0luAkGtaLsJWlSpB3jXXSyO49+p6RdlWwveqm1oavTL/o/hDrt
         OdnjmbMjexbHK8pnqLmF0kZl4f4h0hueMZ7hqLPCooGJFdyFO/hvujqvjMwuWXPoL87k
         tjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453685; x=1784058485;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aLFn4LffXjts2fvbUwfMoYEaq+LjCaJSArAHkHvbD4s=;
        b=tX4GJahZ6qO/X4xaEtCD6EpoTOI7nnWI9qVjk5XwVTr+guibtkF1RenSQtgRmPZ56Y
         tqivJQO3SO2bNn6SArKQyaKCvxZ58LvlJ7oBNKyz3SSpALYq1tTsGZXmBE0HLrzvbUq3
         EqOwgsHCzPC7VtOIIzlMJtCblvWNkY7xuFLujKsAytCw3sIMqsJCAdRM5g+xE2k3WnOw
         uU7crVbi7zq4glwCLPz4l9O6XZLHeXyZiA+iK8D1KQJTDqkRot6YepJHYWVI/auz8KEt
         8VOVlDA7Opw1wFsyxhnB7Tim03kprGtsHRnftkhFC8I53rRMG7FZXP62qXjGXLeJ5yw1
         4MYA==
X-Forwarded-Encrypted: i=1; AHgh+Rpf5pF2SA3RA39ZnWHuovPhTCTE5N97DJcXeB77WJXaJ9xankh5SL12+A4HJjbaw7sMpgVM6FGrWyq35XuR@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtJ/3SbpWfonCg+6+eBpyU/li6YgpzcTJBrPCjVwj2wFStj7h
	c6CyG/2roO6HBd8qPhGhQuJj0PZtGXecDlkuEukI0e5TRehKUS3CU/vvtCrg7u+1LF4=
X-Gm-Gg: AfdE7cnwdrbeCve5pvYAYWIaM8HSpL7fXBnO6Zal5NeJT16Qy8Ns0afNXR1F+HZ3T+Y
	YFAF/WklmbgVYo8jcO2ofEMgevPC9VHbK2wT/tHT3qXy67OoKKiWQGtFiu/4R69a2mPuVSqd4OG
	QGOSbyIiSdOCOLgR10DvXxWv3/zCAlDpe8G3/Yw5oYf4va1fwpmIJ5dbFn/DEQVm2HWb6EY7KYC
	RvS1oVwOya1rwIBLR0I2+khcnCXKa2lfN0NC/7DRTTDMDBxEBDkFfRBlpnXhc1a3cNHVDPogdHG
	RopQFaFSfyVXjDqUthivDNMy/RKY13BocJJDUwI1okgNhyvwTo/gPC6Rr0mSSsYWpJInCwH+Czg
	ST9V4S6rnhKzhoaTBKKrEWJumTiN9Lr+Xi5bSESuYr1wDUmQx9ApnPB8m1ipaGkh7un1FO5utHN
	Wd1DQiiaf0Jfjjwyk+bSeax6Ak0nqNMGpoMVMNcV/n1WJxz9+7BRwZvhneIo6pY219StTz8QSEd
	mlnq+XHaux0jWZPJJqRyqY/eF4DuyoNrFBZMs2SB+B/R4Kjv9xcXRMq1wDl6Obt+sxWzPC8dDeE
	n9fKFA==
X-Received: by 2002:a05:690c:67ca:b0:80c:85b6:7651 with SMTP id 00721157ae682-81be42fad4bmr51618397b3.70.1783453684830;
        Tue, 07 Jul 2026 12:48:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:daa5:7e29:8095:10b2? ([2600:1700:6476:1430:daa5:7e29:8095:10b2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-817212bd978sm48636657b3.37.2026.07.07.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:48:04 -0700 (PDT)
Message-ID: <5221d48185069c1c21284d3fbe85a28a50f14567.camel@dubeyko.com>
Subject: Re: [PATCH v3] hfsplus: validate thread record before delete key
 rebuild
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Kyle Zeng <kylebot@openai.com>, linux-fsdevel@vger.kernel.org
Cc: outbounddisclosures@openai.com
Date: Tue, 07 Jul 2026 12:48:03 -0700
In-Reply-To: <20260707190238.44998-1-kylebot@openai.com>
References: <20260707190238.44998-1-kylebot@openai.com>
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

On Tue, 2026-07-07 at 12:02 -0700, Kyle Zeng wrote:
> hfsplus_delete_cat() is called with str =3D=3D NULL when the last open
> reference to an unlinked HFS+ hardlink backing inode is closed. In
> that
> case, the function finds the catalog thread by CNID and rebuilds the
> catalog key from thread.nodeName.
>=20
> That reconstruction path reads thread.nodeName.length directly from
> the
> catalog B-tree into fd.search_key and then copies length * 2 bytes
> into
> fd.search_key->cat.name.unicode. It does not first check that the
> found
> record is a thread record, that the record size matches the thread
> name
> length, or that nodeName.length fits in the fixed HFS+ catalog key
> buffer.
>=20
> A corrupted image can therefore provide an oversized thread name
> length
> and make hfs_bnode_read() write past the catalog search-key
> allocation.
>=20
> Read the CNID record through hfsplus_brec_read_cat(), which performs
> the
> hfs_brec_find() lookup via hfs_brec_read() before validating the
> catalog
> record. Reject non-thread records before building the delete key from
> the validated thread name.
>=20
> Move the HFS+ catalog thread name bound into hfsplus_brec_read_cat()
> so
> it is checked together with the record-size consistency validation,
> and
> factor the thread-record-type check into a shared HFS/HFS+ helper.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
> =C2=A0fs/hfsplus/bfind.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
|=C2=A0 5 +++++
> =C2=A0fs/hfsplus/catalog.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 30 +++++=
+++++++------------------
> =C2=A0include/linux/hfs_common.h |=C2=A0 5 +++++
> =C2=A03 files changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
> index 9a55fa6d5294..417c3014f4c7 100644
> --- a/fs/hfsplus/bfind.c
> +++ b/fs/hfsplus/bfind.c
> @@ -322,6 +322,11 @@ int hfsplus_brec_read_cat(struct hfs_find_data
> *fd, hfsplus_cat_entry *entry)
> =C2=A0			pr_err("thread record too short (got %u)\n",
> fd->entrylength);
> =C2=A0			return -EIO;
> =C2=A0		}
> +		if (be16_to_cpu(entry->thread.nodeName.length) >
> +		=C2=A0=C2=A0=C2=A0 HFSPLUS_MAX_STRLEN) {
> +			pr_err("catalog name length corrupted\n");
> +			return -EIO;
> +		}

I was not against the function that v2 has. :) We simply need to have
more smart checking logic. We are trying to check the thread record and
hfsplus_brec_read_cat() operates by fd->entrylength. So, the entry-
>thread.nodeName.length should be consistent with fd->entrylength. Does
it make sense to you?

> =C2=A0		expected_size =3D hfsplus_cat_thread_size(&entry-
> >thread);
> =C2=A0		break;
> =C2=A0	default:
> diff --git a/fs/hfsplus/catalog.c b/fs/hfsplus/catalog.c
> index 776ce36cf076..1a4b0beae135 100644
> --- a/fs/hfsplus/catalog.c
> +++ b/fs/hfsplus/catalog.c
> @@ -204,16 +204,11 @@ int hfsplus_find_cat(struct super_block *sb,
> u32 cnid,
> =C2=A0		return err;
> =C2=A0
> =C2=A0	type =3D be16_to_cpu(tmp.type);
> -	if (type !=3D HFSPLUS_FOLDER_THREAD && type !=3D
> HFSPLUS_FILE_THREAD) {
> +	if (!is_hfs_thread_record_type(type)) {
> =C2=A0		pr_err("found bad thread record in catalog\n");
> =C2=A0		return -EIO;
> =C2=A0	}
> =C2=A0
> -	if (be16_to_cpu(tmp.thread.nodeName.length) > 255) {
> -		pr_err("catalog name length corrupted\n");
> -		return -EIO;
> -	}
> -
> =C2=A0	hfsplus_cat_build_key_uni(fd->search_key,
> =C2=A0		be32_to_cpu(tmp.thread.parentID),
> =C2=A0		&tmp.thread.nodeName);
> @@ -350,23 +345,22 @@ int hfsplus_delete_cat(u32 cnid, struct inode
> *dir, const struct qstr *str)
> =C2=A0		goto out;
> =C2=A0
> =C2=A0	if (!str) {
> -		int len;
> +		hfsplus_cat_entry entry =3D {0};
> =C2=A0
> =C2=A0		hfsplus_cat_build_key_with_cnid(sb, fd.search_key,
> cnid);
> -		err =3D hfs_brec_find(&fd, hfs_find_rec_by_key);
> +		err =3D hfsplus_brec_read_cat(&fd, &entry);
> =C2=A0		if (err)
> =C2=A0			goto out;
> =C2=A0
> -		off =3D fd.entryoffset +
> -			offsetof(struct hfsplus_cat_thread,
> nodeName);
> -		fd.search_key->cat.parent =3D cpu_to_be32(dir->i_ino);
> -		hfs_bnode_read(fd.bnode,
> -			&fd.search_key->cat.name.length, off, 2);
> -		len =3D be16_to_cpu(fd.search_key->cat.name.length) *
> 2;
> -		hfs_bnode_read(fd.bnode,
> -			&fd.search_key->cat.name.unicode,
> -			off + 2, len);
> -		fd.search_key->key_len =3D cpu_to_be16(6 + len);
> +		type =3D be16_to_cpu(entry.type);
> +		if (!is_hfs_thread_record_type(type)) {
> +			pr_err("found bad thread record in
> catalog\n");
> +			err =3D -EIO;
> +			goto out;
> +		}
> +
> +		hfsplus_cat_build_key_uni(fd.search_key, dir->i_ino,
> +					=C2=A0 &entry.thread.nodeName);
> =C2=A0	} else {
> =C2=A0		err =3D hfsplus_cat_build_key(sb, fd.search_key, dir-
> >i_ino, str);
> =C2=A0		if (unlikely(err))
> diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
> index 45fb4c9ff9f5..c4862166efc9 100644
> --- a/include/linux/hfs_common.h
> +++ b/include/linux/hfs_common.h
> @@ -92,6 +92,11 @@
> =C2=A0#define HFS_CDR_THD		0x03	/* folder (directory) thread
> */
> =C2=A0#define HFS_CDR_FTH		0x04	/* file thread */
> =C2=A0
> +static inline bool is_hfs_thread_record_type(u16 type)
> +{
> +	return type =3D=3D HFS_CDR_THD || type =3D=3D HFS_CDR_FTH;
> +}

I don't want to place this function in linux/hfs_common.h. And I don't
mean to use HFS_CDR_THD/HFS_CDR_FTH (HFS based constants) instead of
HFS+ specific ones. It looks not correct to me. Currently, I suggest to
use is_hfs_thread_record_type() name, to employ HFS+ specific constants
and to place it into fs/hfsplus/hfsplus_fs.h.

Thanks,
Slava.

> +
> =C2=A0/* legal values for hfs_ext_key.FkType and hfs_file.fork */
> =C2=A0#define HFS_FK_DATA		0x00
> =C2=A0#define HFS_FK_RSRC		0xFF
