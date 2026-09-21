Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396964FDA4A
	for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 21:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790026811; cv=none; b=C+CTalsu21hE/4wm/nCT/zSMxhbBJUukVApO7tarNDN1Wn7+4b5eLRtqlPG1QIRaTJ+xicytM7GdptpiGZhcwZjDFn9/vT5PPEN6x2GbqxTgJXcgLMToUwgnD0KJkzeORKSOSJCZRPZ7cZeje6uu0vsMRjyUfCkrbTkXxPabhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790026811; c=relaxed/simple;
	bh=V+kt2d8U/x65DFgOkgisM1oMehGAd1wlyUmDVd74TPU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q2wcm3r+/MyNn8f0qBuuclxbn3cH5JFtkrPaQ9wC7Et8eQ+Fs12J+Rg/mHfU8T7Zfc+lYR/Trdcv96253sJUXewnHoGuPvjzvCyCmwvF6x5brFlmSAJOPzFqZg97n4lAIqnxcILOedVHda2GsuBHVzDHkO1kOCf6fkkeiBfU8BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=eLASdjWi; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="eLASdjWi"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d43f9b11bso27187077b3.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Sep 2026 14:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1790026809; x=1790631609; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BCmBBmjaqTB26TFv+AtYS+4yAVk+NMOU3PHM053ZFwA=;
        b=eLASdjWiKU8Q9Sz26V9C1iF2GtzzrC8scDtW286hWPua3LYQlAv4VmK+U4EXjelkp5
         eMgDCWwdgRayk4UrxLLnBIUcuZJ2wn9QxVvIEZUruKV7n/XI3gkUAEblwc05l8G/IDIP
         tsw3WTaDJBGDXhwVgaYwSetvDafI7J7PYoQsCNcsWMoWju4bwX4/ueZ6ZPXFy6hetI0s
         NrNyqhBk14GoMiMDJ2LaFq9P6m0bq56sZ6VBr+pkW5rFJj6bQnP+8cuI6tcMiDbncxM8
         uMKIIuUyY1177uoZXqWEa2iyIZ85+E0AU01O6Iy1wm7YVd4RShScTkyyD5DsmrtmzkeV
         GAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790026809; x=1790631609;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BCmBBmjaqTB26TFv+AtYS+4yAVk+NMOU3PHM053ZFwA=;
        b=pBd7+0IC/j73mSvNPxV7G/nTTJFQsw4rIS67+5H7+ChEqxwNjnL4IZkQhgqE5mHim1
         eipyVrqkBu5BZw+RrPkQEiKsy/HItA5pzFMDTN748NLN9UnJCO6W3x3TcJRl4EuR9ho2
         O+GimL04HvLq41M7j25RAaHqFalUSJAZ2Nx9JqEGPB7zj1jdTEozZxadEYouFgVVzho5
         1+0oc0FLBxsFGDsXy0psK8k7YK5sUAbpqmLw2iuTU/BEYFGo+m5qMY/NkLweJYtSJlvr
         jy5mA59CuMECitdeUhb4/HR3R7Vl4BdndcPlLOa/RGLAVQGjw/zOtSVPoZ4Rtrz8nR51
         kYLg==
X-Gm-Message-State: AFuF++lz12JEwx68kVTc4QV630is6JdI3w3ROrM8QndD1Gi3vWfsRnBg
	GLrujw7DwYm+h1b1LsS1x8y9/QzooyN18Xx4MG+7m+qFDHjjN2GNPcCTileUirbwyvc=
X-Gm-Gg: AYBFou1jK/p5uh6A2JLtqC/1fR7M/qt5hrXkbaTKf3Q+TZxRl3j3l3GE5zSLyLey7MQ
	Uurq/mMgBL1pipP1moZApxXOJfmnbUKBMBQ1RcDhvOMk7pfCsKx02MidTe42RrRE0Obmc3O2y/U
	wbERDGQax3snbqNnm7w8NiROZSHwl4f5DbSR/0UEsT3Ol8B3DHHHOtbIDHs1Gt9pkUMpLxjnoRB
	Jdt8sz7ybtgRyFPQrXxRKR3tFBQSsbpYuMRjM5bc3JbzIbofEn993lr5lmyq9oDXHSC3DKFmnax
	sA8+LDzoZUMFqa7YKFwIOPGq7wHwfH+LURNXqGClLttGiTl5JEdxGBMFKEb0JPX4uvm41g6hlXQ
	uWcfwTT5xaXsJZ5Y6gsyE+accwYoRBXnyvks0cYa2n205/G/65qIp8IYMFxAdmT+BoLqht7mSEm
	S+6eIzTpJfRpFsp5ZLZFq6fAAOOJ2yGetzu6BEBkSluzawc3AyXAZO7ld3rpyCbIgK1gO5sTcCc
	u3hPsSZLBL1q2GrIOB4aQudGPzVsJ4KjCZI9Rj3qghvCaA/69kfI5HKKTXF+8Jxs3SdTt9CXcZc
	WQQ1idNKdltnfHhaYj8J9p6H1EaMV161H0e6cRoGS1iQOCTDGaqFdggWhwhr6yVy
X-Received: by 2002:a05:690c:d91:b0:81e:5d2e:89c8 with SMTP id 00721157ae682-8973070ba7amr36395567b3.14.1790026809156;
        Mon, 21 Sep 2026 14:40:09 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:8475:e6ce:2d2c:ddc2? ([2600:1700:6476:1430:8475:e6ce:2d2c:ddc2])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a237ca8bdbsm1829747b3.3.2026.09.21.14.40.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 14:40:08 -0700 (PDT)
Message-ID: <354fecd37eb8f647abc86e6f620b980197e3043d.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix xattr entrylength OOB read and NULL
 hidden_dir on R/W remount
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Hui Peng <benquike@gmail.com>, glaubitz@physik.fu-berlin.de, 
	frank.li@vivo.com, brauner@kernel.org, Deepanshu Kartikey
 <kartikey406@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 21 Sep 2026 14:40:06 -0700
In-Reply-To: <20260919222603.3794265-1-benquike@gmail.com>
References: <20260919222603.3794265-1-benquike@gmail.com>
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

On Sat, 2026-09-19 at 22:26 +0000, Hui Peng wrote:
> Fix three issues in fs/hfsplus/:
>=20
> 1. In __hfsplus_getxattr() (fs/hfsplus/xattr.c), verify that
> =C2=A0=C2=A0 record_length and attr_size fit within fd.entrylength before
> copying
> =C2=A0=C2=A0 from the catalog or attributes btree entry so a malformed
> attribute
> =C2=A0=C2=A0 length cannot trigger a slab-out-of-bounds read or leak
> uninitialized
> =C2=A0=C2=A0 slab memory.
> 2. In hfsplus_delete_all_attrs() (fs/hfsplus/attributes.c), return
> early
> =C2=A0=C2=A0 if HFSPLUS_SB(sb)->attr_tree is NULL.
> 3. In hfsplus_reconfigure() and hfsplus_unlink() (fs/hfsplus/super.c,
> =C2=A0=C2=A0 fs/hfsplus/dir.c), allocate hidden_dir when remounting from =
read-
> only
> =C2=A0=C2=A0 to read-write and guard against NULL hidden_dir when unlinki=
ng
> open
> =C2=A0=C2=A0 files.
>=20
> Fixes: 127e5f5ae51e ("hfsplus: rework functionality of getting,
> setting and deleting of extended attributes")
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> diff --git a/fs/hfsplus/attributes.c b/fs/hfsplus/attributes.c
> index 7c2e589d4553..a08a9d83ccda 100644
> --- a/fs/hfsplus/attributes.c
> +++ b/fs/hfsplus/attributes.c
> @@ -83,7 +83,7 @@ int hfsplus_attr_build_key(struct super_block *sb,
> hfsplus_btree_key *key,
> =C2=A0
> =C2=A0hfsplus_attr_entry *hfsplus_alloc_attr_entry(void)
> =C2=A0{
> -	return kmem_cache_alloc(hfsplus_attr_tree_cachep,
> GFP_KERNEL);
> +	return kmem_cache_zalloc(hfsplus_attr_tree_cachep,
> GFP_KERNEL);
> =C2=A0}
> =C2=A0
> =C2=A0void hfsplus_destroy_attr_entry(hfsplus_attr_entry *entry)
> diff --git a/fs/hfsplus/dir.c b/fs/hfsplus/dir.c
> index 51fcba2e6d40..2967a93433b9 100644
> --- a/fs/hfsplus/dir.c
> +++ b/fs/hfsplus/dir.c
> @@ -386,6 +386,10 @@ static int hfsplus_unlink(struct inode *dir,
> struct dentry *dentry)
> =C2=A0	cnid =3D (u32)(unsigned long)dentry->d_fsdata;
> =C2=A0	if (inode->i_ino =3D=3D cnid &&
> =C2=A0	=C2=A0=C2=A0=C2=A0 atomic_read(&HFSPLUS_I(inode)->opencnt)) {
> +		if (!sbi->hidden_dir) {
> +			res =3D -EIO;
> +			goto out;
> +		}
> =C2=A0		str.name =3D name;
> =C2=A0		str.len =3D sprintf(name, "temp%llu", inode->i_ino);
> =C2=A0		res =3D hfsplus_rename_cat(inode->i_ino,
> @@ -409,6 +413,10 @@ static int hfsplus_unlink(struct inode *dir,
> struct dentry *dentry)
> =C2=A0		if (inode->i_ino !=3D cnid) {
> =C2=A0			sbi->file_count--;
> =C2=A0			if (!atomic_read(&HFSPLUS_I(inode)-
> >opencnt)) {
> +				if (!sbi->hidden_dir) {
> +					res =3D -EIO;
> +					goto out;
> +				}
> =C2=A0				res =3D hfsplus_delete_cat(inode-
> >i_ino,
> =C2=A0							 sbi-
> >hidden_dir,
> =C2=A0							 NULL);
> @@ -425,11 +433,10 @@ static int hfsplus_unlink(struct inode *dir,
> struct dentry *dentry)
> =C2=A0out:
> =C2=A0	if (!res) {
> =C2=A0		res =3D hfsplus_cat_write_inode(dir);
> -		if (!res) {
> +		if (!res && sbi->hidden_dir)
> =C2=A0			res =3D hfsplus_cat_write_inode(sbi-
> >hidden_dir);
> -			if (!res)
> -				res =3D
> hfsplus_cat_write_inode(inode);
> -		}
> +		if (!res)
> +			res =3D hfsplus_cat_write_inode(inode);
> =C2=A0	}
> =C2=A0
> =C2=A0	mutex_unlock(&sbi->vh_mutex);
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index ff7d6b3336a6..3e5adfe1b4cf 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -401,6 +401,31 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> +
> +		if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir)
> {
> +			struct inode *root =3D d_inode(sb->s_root);
> +			struct qstr str =3D
> QSTR_INIT(HFSP_HIDDENDIR_NAME,
> +						=C2=A0=C2=A0=C2=A0
> sizeof(HFSP_HIDDENDIR_NAME) - 1);
> +			int err;
> +
> +			mutex_lock(&sbi->vh_mutex);
> +			sbi->hidden_dir =3D hfsplus_new_inode(sb,
> root, S_IFDIR);
> +			if (!sbi->hidden_dir) {
> +				mutex_unlock(&sbi->vh_mutex);
> +				return -ENOMEM;
> +			}
> +			err =3D hfsplus_create_cat(sbi->hidden_dir-
> >i_ino, root,
> +						 &str, sbi-
> >hidden_dir);
> +			if (err) {
> +				iput(sbi->hidden_dir);
> +				sbi->hidden_dir =3D NULL;
> +				mutex_unlock(&sbi->vh_mutex);
> +				return err;
> +			}
> +			hfsplus_cat_write_inode(sbi->hidden_dir);
> +			hfsplus_cat_write_inode(root);
> +			mutex_unlock(&sbi->vh_mutex);
> +		}

This is still ongoing fix [1]. You need to collaborate with the patch's
author to make it finally accepted. I am ready to accept you as the
second author of the fix. Could you guys to collaborate with the fix?

Thanks,
Slava.

> =C2=A0	}
> =C2=A0	return 0;
> =C2=A0}
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 21a1c196c71f..7f9215387cbd 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -657,7 +657,9 @@ ssize_t __hfsplus_getxattr(struct inode *inode,
> const char *name,
> =C2=A0				fd.entryoffset +
> =C2=A0				offsetof(struct
> hfsplus_attr_inline_data,
> =C2=A0				length));
> -		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE) {
> +		if (record_length > HFSPLUS_MAX_INLINE_DATA_SIZE ||
> +		=C2=A0=C2=A0=C2=A0 offsetof(struct hfsplus_attr_inline_data,
> raw_bytes) +
> +			=C2=A0=C2=A0=C2=A0 record_length > fd.entrylength) {
> =C2=A0			pr_err("invalid xattr record size\n");
> =C2=A0			res =3D -EIO;
> =C2=A0			goto out;

[1]
https://lore.kernel.org/linux-fsdevel/20260717135706.42918-1-kartikey406@gm=
ail.com/

