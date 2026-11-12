Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794516325;
	b=kJF9rhZ3SdT536v3Gf9/bHXErb7SG1n939lgV1TrhKlNf5fDT4gztIHPRwIyZOTBeECl
	 MnsAEYl25A/RmoO+NZU8UoVIDvdbDlhVtqvTUytgicOOjBrYtQS8EQ6i0pBwRnLffY7+v
	 2VfT+T6PJfNA4oM4wix7tLw7uOLkE7LtBNaVY9p9nf8Ndt9gm4XqVvxhBV7Jlhm19YpMY
	 J2RkcDreA3prG91bBqj0e9suY+7nZ1t7YlzvVwfYk5D6l+VPaeLwI2s2eY/L4JirbfsIS
	 u+osOm2cGZjM6NCiF1jY6xG9XPQS2aVhMb3fHRCjw4plfB7g30XdxZjl8BI8e2uQ2bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794516325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:Autocrypt:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
	b=cN1/nEnIVgqsPj/9IxZttzHuHos4rpZwfBYamwU0YUBNsm0/dN11ZHSy16rw/8XHa4Zl
	 Aus39B3yVz/+Z0aA06HYb6XA5ZmuGIaH+At7w0KIHK/7LBfVLmoRq/9DCC7WQa/zBOTyK
	 gcSyrLPkfg62QG6y2AgVC9BGhEF28jlSq2TKlvs2LMguKr5TxOP+eQHiEadHnQxlTmbLe
	 Hb1TEAQLv3awLkiXafNtwUluTfDLGHI6wz3KAQDb476e8znKkL3n8Kbji6/onOS2JOpbQ
	 30tzpajCsyrQlLYYjAchh6mTslIcNtrG6re5EKwyq29YmMNRAPKMJ9oSICOST2iCZKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Oc7eStj1;
	arc=none smtp.remote-ip=209.85.128.178
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB06606A330
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 20:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB06606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=Oc7eStj1
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-8b31448caccso3228657b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Nov 2026 12:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1794516324; x=1795121124; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
        b=Oc7eStj1TstmNeupx6yzNDRP13iRRMeE/9vdU4XtbLp466Xx0zvrPfr4sCdY80OA4t
         3PMSsrITYf39yhgq473pVTnF5X2j4khSR4ukGysWobfSKYTGmRNmRYpayHccg4SfCyWE
         9P8WgNmkz6x5RxSHPepPFVr2P8hG9Ysnng2KQsccZaUz5qPZnIfX68EWk4CCIXhGJeSO
         ES43IyZGYVLNfRGGTV3SIhMkm32XvR7aqMyzyrsavH4YBV2m68KnYj+QJytsQuqBiLNP
         mzLWPZigDsQ0nWtxPoRhtwnh3xSXVu+cMyq9n47rhv3sEz8+4Fbj9mBfhXgU3/b6vGOM
         bNCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794516324; x=1795121124;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=iXGHywZFNojrHd2KwpmIrJ8ca2HrRHqgEFVKWK/ZGM4=;
        b=j5JsasxsJiYodwsTJ/6j9rWntHFmX0Y7Nx32Y165KNRPZJCHc0Waos44gDvbzEk+kg
         WrkMv8zShsp+y7u+7XxfGlyA4yoqMfDFcm7Hn7wujen6x2/JfwgKUwVyD4zaGZ63WmnP
         BoDH5csT+/lY2n6nsZYx5XwECNnMlXjkoVxhww7dXS3NyQK7eSXfhuaJnnkA1ZQRzQWq
         +Sf3qUeAoeBmGXYgeEVcRvSJCctjWTS205i8tbsUfgqPDcre/1NDyxP6fskUO/X7gFgS
         umv31wda/J+87IuSyYHbnvCTpHIWqV23qXmbOKhfInxn9Ji34g7p3wZR+/Q/4KT4TAyw
         jMrQ==
X-Forwarded-Encrypted: i=1; AL+hErHWh2PmT20J+wR3XkXTX9C7/HhXe96Lh81NDquUu+bR7HqgsLwSZKpWhTxJdY+lzdMdS8k9l0IRUsuGe2g3@vger.kernel.org
X-Gm-Message-State: APuU4Z+JY9jAHoLq84Lkxd7niZj/iHrRkcvtJEYbiFed6Lpu9fP4jeJd
	6++M5pNUwcxkf6dHTwt6OA0nBLr/QqOmTStIJY2KSdq9R/lNk7equXgb7a1jEz8jWaI=
X-Gm-Gg: AYBFou2R9hquHTcVd0f3VLyhB33+e2I54MUlODC7esTYQKNSh8cq582B4qcxVCvI4La
	Se0CBX40M/TApMEPk4ZOR5/hQ8wzvGdU5Nur82ICkJIoO7dlzqtD42goYZxxe2+qZ4IY3FYVwbx
	R4j38fZVmXpd0mwkLsJd5AlV4wkfwuRLKsNBxgPL7h3x9JYhRX8WO22K0DoT6dtoootaGSwEvIg
	jHaQQx/qqYG+Qzcvmye9XS1bMVlqH7fMSo6IETQV2JGl5vjBrtRhXxvOVVVZ895SqTGiI3bHb2P
	hzv+sxGuICAu2adye4fTXea8DFHo401pIMeqxAXWWPt5E1bflfpm2nMbO5i89jQ8hJBFPuGM24D
	Q+0rHVurNabUGJRkgG112M8F3Yp+dkSfQSuOWyNpriwZCKkgc+G3L0rW1XImAWWYYPxBsgKHGRF
	+YbBxz/5dW3yIupk3J36udJ15lPwxN8u8A2zfKzUJWs6b0e+GrJLu1Z7aKEbUPlfkFB3FYLACOG
	CKpgvDkG1nqHEutB7Y3psAbLy0tZyDC2DDHT88lMQcxc0SrBnIYXG5E6eXE2z/qrYOLOKi7XvrS
	FA/Jw6o5sGur+zE8m/trY7nNUDgLuKmd0nkp7v2/anG/ZbjaDrQ7bCQvJjHehiip6L5agBzE6eQ
	m8C8nWj3OAxtrJ8wzbDwb+01NTiLIHxrChc62BsNLxrvECVPVPyvf+vTN5ATFlSZrM+85gP8=
X-Received: by 2002:a05:690c:f8a:b0:8b0:e680:616a with SMTP id 00721157ae682-8b4aa32151bmr5071387b3.24.1794516324008;
        Thu, 12 Nov 2026 12:45:24 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:3a31:6c95:5610:70f6])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4aa99f7a1sm4740207b3.29.2026.11.12.12.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:45:22 -0800 (PST)
Message-ID: <bf79e0f0ba166bef46dc5d196b0877dabe252248.camel@dubeyko.com>
Subject: Re: [PATCH 1/2] hfs: do not end readdir at i_size after an unlink
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Yangtao Li
	 <frank.li@vivo.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 12 Nov 2026 12:45:21 -0800
In-Reply-To: <20261112111745.4094283-2-hengyul@cs.unc.edu>
References: <20261112111745.4094283-1-hengyul@cs.unc.edu>
	 <20261112111745.4094283-2-hengyul@cs.unc.edu>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
 NFdvziOa4FgUBC4X71upsZIoZJeii2V/Jtc3B4g==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, 2026-11-12 at 06:17 -0500, Hengyu Liang wrote:
> Commit 7fde7e806657 ("hfs: rework hfsplus_readdir() logic") stopped
> moving the position of open directories back when an entry is
> deleted.
>=20
> However, hfs_readdir() still ends when ctx->pos reaches i_size, and
> i_size drops on every delete. As of now, a program that reads a
> directory and deletes what it read sees the directory end early and
> leaves files behind.
>=20
> The issue can be reproduced with BusyBox rm on a new hfs volume:
>=20
> =C2=A0=C2=A0=C2=A0 mkdir /mnt/d
> =C2=A0=C2=A0=C2=A0 (cd /mnt/d && for i in $(seq 1500); do : > f$i; done)
> =C2=A0=C2=A0=C2=A0 rm -r /mnt/d
>=20
> Before commit 7fde7e806657 ("hfs: rework hfsplus_readdir() logic"),
> the directory is removed. After that commit, the result is:
>=20
> =C2=A0=C2=A0=C2=A0 rm: can't remove '/mnt/d': Directory not empty
>=20
> and 304 files are left.
>=20

Currently, I don't understand how the issue happens. Could you please
explain the issue at first?

Thanks,
Slava.

> This patch will end a walk that continues from the saved key where
> the
> records of the directory end, and keep the i_size check for a walk
> that
> starts from a position.
>=20
> Fixes: 7fde7e806657 ("hfs: rework hfsplus_readdir() logic")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> Application impact (Ubuntu 26.04 user space): a folder with 1500
> files
> on an HFS volume is moved to the trash, then the trash is emptied
> with
> "gio trash --empty" (the call behind "Empty Trash" in GNOME Files,
> done
> by gvfsd-trash 1.60). On v7.1, all files are removed. On v7.2, the
> trash
> looks empty, but 478 files stay in .Trash-0/expunged and their space
> is
> not freed.
>=20
> =C2=A0fs/hfs/dir.c | 27 +++++++++++++++++++--------
> =C2=A01 file changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/fs/hfs/dir.c b/fs/hfs/dir.c
> index b6b8945712a9..b0858512f4d2 100644
> --- a/fs/hfs/dir.c
> +++ b/fs/hfs/dir.c
> @@ -51,10 +51,16 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0	char strbuf[HFS_MAX_NAMELEN];
> =C2=A0	union hfs_cat_rec entry;
> =C2=A0	struct hfs_find_data fd;
> -	struct hfs_readdir_data *rd;
> +	struct hfs_readdir_data *rd =3D file->private_data;
> +	/*
> +	 * i_size follows the valence and drops on unlink, so it
> says nothing
> +	 * about a walk that continues from a saved key. That walk
> ends where
> +	 * the records of this directory end.
> +	 */
> +	bool resume =3D rd && rd->pos =3D=3D ctx->pos;
> =C2=A0	u16 type;
> =C2=A0
> -	if (ctx->pos >=3D inode->i_size)
> +	if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0		return 0;
> =C2=A0
> =C2=A0	err =3D hfs_find_init(HFS_SB(sb)->cat_tree, &fd);
> @@ -93,10 +99,9 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0			goto out;
> =C2=A0		ctx->pos =3D 2;
> =C2=A0	}
> -	if (ctx->pos >=3D inode->i_size)
> +	if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0		goto out;
> -	rd =3D file->private_data;
> -	if (rd && rd->pos =3D=3D ctx->pos) {
> +	if (resume) {
> =C2=A0		memcpy(fd.search_key, &rd->key, sizeof(struct
> hfs_cat_key));
> =C2=A0		err =3D hfs_brec_find(&fd);
> =C2=A0		if (err =3D=3D -ENOENT)
> @@ -105,10 +110,12 @@ static int hfs_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0		err =3D hfs_brec_goto(&fd, ctx->pos - 1);
> =C2=A0	}
> =C2=A0	if (err)
> -		goto out;
> +		goto end_walk;
> =C2=A0
> =C2=A0	for (;;) {
> =C2=A0		if (be32_to_cpu(fd.key->cat.ParID) !=3D inode->i_ino)
> {
> +			if (resume)
> +				goto out;
> =C2=A0			pr_err("walked past end of dir\n");
> =C2=A0			err =3D -EIO;
> =C2=A0			goto out;
> @@ -146,11 +153,11 @@ static int hfs_readdir(struct file *file,
> struct dir_context *ctx)
> =C2=A0			goto out;
> =C2=A0		}
> =C2=A0		ctx->pos++;
> -		if (ctx->pos >=3D inode->i_size)
> +		if (!resume && ctx->pos >=3D inode->i_size)
> =C2=A0			goto out;
> =C2=A0		err =3D hfs_brec_goto(&fd, 1);
> =C2=A0		if (err)
> -			goto out;
> +			goto end_walk;
> =C2=A0	}
> =C2=A0	if (!rd) {
> =C2=A0		rd =3D kmalloc_obj(struct hfs_readdir_data);
> @@ -162,6 +169,10 @@ static int hfs_readdir(struct file *file, struct
> dir_context *ctx)
> =C2=A0	}
> =C2=A0	rd->pos =3D ctx->pos;
> =C2=A0	memcpy(&rd->key, &fd.key->cat, sizeof(struct hfs_cat_key));
> +end_walk:
> +	/* This directory can hold the last records of the catalog.
> */
> +	if (resume && err =3D=3D -ENOENT)
> +		err =3D 0;
> =C2=A0out:
> =C2=A0	hfs_find_exit(&fd);
> =C2=A0	return err;
