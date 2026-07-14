Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54092EB5B8
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 21:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784064782; cv=none; b=By6lhU7aZFdMKRIqNRCs+vlXgHs4VYl7GT5LGhsW+H6B5trqByNnbZ8rGoDYgCEjeDgpnUBiq6T+Wu/Dvq+0gUuerdDEiPmKn+YcITy/w4J7TvXSd+VDwRrN7K3zew5n+1kYj+0UCg8GVV8kwGG1ycLMIJwGuYHx6OftCQ7pnh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784064782; c=relaxed/simple;
	bh=EQ/KWMsErF5QoUZ9RAB8tI1wxkuqvNt/lCwzRjhsiDA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NtjcqMDH99fCnORvwKwbRuxRf2qO5Bsez5GBcFbvbqqzQ7BuR6iDpUqNvkkMQi+Ib3mqHyXFISAR6ElqyUBHbaP8XDdSj9TOkrhcQ6bQ2hhrLt12DhuL2534/X8Say2ByFmMSUg3l0T0074maZpJI/y9EQMeeY9uC54KROG60G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=RI3MqbVg; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="RI3MqbVg"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81dfdbd86d1so15391687b3.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784064780; x=1784669580; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzZujgpCy1fJj1V58o/c+NeD5fXV9fJcJCuXb1Qy+pc=;
        b=RI3MqbVg2GanvPL11DzDDiM7b8+Hlq9Kotxt3FruCll/ijpqGVKwhQ0Uc2fJFgvCb2
         WbTUgFsbdCBId5GAqCDGpoPOtldm8gi8MPI8hfvSB7ji6t+eAHi6TQJdxuLmyTJtcIw2
         lthdgmjhlG9SZ38W4wyLyn2++OrSuTr4Okf2LCRnFoaVObn1c2grzlRYIYY4eHbQU5HY
         D9KYQDjwsNDg70cV0oa3hStIxA7bXXdTH501XeCxJo6myflBtN+jfxSpGMxjiX/vYRrr
         g5Xipmkz6k9ee4y5qE+J6kjmN0jpeTwpTnUlOWS8wMbDNv66R73AjwfOO0CITYZrww3Q
         Zyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784064780; x=1784669580;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PzZujgpCy1fJj1V58o/c+NeD5fXV9fJcJCuXb1Qy+pc=;
        b=LX0NS5GK1U0bVzI2b3dnF/Srg7OHzWzOqp05dF8dsix1WPbuEAczi2IU7+P232zzuu
         S2UaKpJJIxbn/IWS0AvJzZOuPZnKxGd6noq/NRDxzpGz8+nHMbA4z1FfS3ygoHLJMFWC
         hWxhzSHQkxJJUTIW0lMbIDJSWBDibpdajZpVw0gfjO062SpJ9hLOhtSsOn9pcqQHWRrF
         NNU6tE98J6fTNaXG71IX50XseTIXO9MZIJjG5JWUGWhqvhOpcYRJIWYGJiyJ1+nJPypz
         z2BKyLtm7VLQodhiFEL847RfT/ACEW1Uj8xb3ruFJ6npLIG6xp/26U+qOzQqJ+bjwRBO
         4z1w==
X-Gm-Message-State: AOJu0YzUNvIrlkj/sTLZj0y8gC1W8luigPJnYLO1aOJ8ByGZmaBdhxLg
	rw0SZurSaRLCZKxog0BAhBpERuGVWtQ/RslVWjfe26xSLar6usRhHa7BdnnUlPhjsEE=
X-Gm-Gg: AfdE7cm/tmjwDp2oJTjmYS1l/GS0ItQpozIi+bPgFNYcR8lC6TYFyKeLZeNrfR6/yR6
	5m7oUvXcT9jDIi5g2JlNrFbi08dDbd5Ri0i0cki+ZZhyzp4bgrLazsXK76Tge42hkl58qUPe6SR
	lv/sWt27nFVjCbv8/1Ir6JAxo1/XO8YzQnwnvwvPxcRLrXtgGEdKYWSVZ35Lm6vjNJGYFrhGAQu
	juEegf2T8t8Itn0seMaytDXnOidsuEoHeJSF/kDuoOnQsCXVX60TSfjtK7veH4THR2DVlgzwHoz
	ulzMmhYWSNK6xE/40AnJDKtZQHx8J4y/ziUAxK919yfDzo3DzyXzkLp1cfjr4ixSXU+OIJ9+f7n
	3WhhpLCv8OL/nbkwVdOuAba38stEkyHLWYVt1qrP0UAw1S0n7LZSrhfisG5RbiNfUyNAL0BuFH2
	8062ccWI+vw//m3zeC01ycbQaOoRZtKjOd0E56fL2UGlnt8fxk2FaYJ7UjxAq8k3HlDF7qiVzCv
	KcEO8rgCNjjV0WJ4lEjElhOuBQeakgwpIxAiU55YoG5LZ2w7uT9Pu+h
X-Received: by 2002:a05:690c:9681:b0:81e:d081:d72 with SMTP id 00721157ae682-81ed0813fb8mr697367b3.67.1784064779632;
        Tue, 14 Jul 2026 14:32:59 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:9b87:2209:14fb:1802])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1feb43sm152940167b3.40.2026.07.14.14.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 14:32:59 -0700 (PDT)
Message-ID: <358eea840684313fe1d7d8f5dac239cf76121784.camel@dubeyko.com>
Subject: Re: [PATCH v6] hfsplus: fix null-ptr-deref by creating hidden dir
 on remount rw
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 glaubitz@physik.fu-berlin.de, 	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Tue, 14 Jul 2026 14:32:57 -0700
In-Reply-To: <20260714125620.11119-1-kartikey406@gmail.com>
References: <20260714125620.11119-1-kartikey406@gmail.com>
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

On Tue, 2026-07-14 at 18:26 +0530, Deepanshu Kartikey wrote:
> hfsplus_reconfigure() does not create the hidden directory when
> remounting from read-only to read-write, leaving sbi->hidden_dir
> as NULL. This causes a null-ptr-deref when any subsequent
> link/unlink/rename operation dereferences it.
>=20
> Extract hidden directory creation logic from hfsplus_fill_super()
> into a new helper hfsplus_create_hidden_dir() and call it from
> hfsplus_reconfigure() when switching to read-write mode and
> hidden_dir is NULL, ensuring hidden_dir is always valid on any
> read-write mount.
>=20
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> Changes in v6:
> =C2=A0 - Use single mutex_unlock() in error path of helper.
> =C2=A0 - Rename label out_put_hidden_dir to out inside helper.
> =C2=A0 - Use QSTR_INIT() in both fill_super and reconfigure.
> =C2=A0 - Add hfsplus_prepare_volume_header_for_commit() and
> =C2=A0=C2=A0=C2=A0 hfsplus_sync_fs() before creating hidden dir in reconf=
igure
> =C2=A0=C2=A0=C2=A0 to avoid inconsistent state on crash, as suggested by
> =C2=A0=C2=A0=C2=A0 Vyacheslav Dubeyko.
>=20
> Changes in v5:
> =C2=A0 - Pass str as input argument to hfsplus_create_hidden_dir()
> =C2=A0=C2=A0=C2=A0 to avoid duplication, as suggested by Vyacheslav Dubey=
ko.
> =C2=A0 - Use !(fc->sb_flags & SB_RDONLY) as guard in reconfigure
> =C2=A0=C2=A0=C2=A0 instead of !sb_rdonly(sb).
> =C2=A0 - Restore cancel_delayed_work_sync() in cleanup path.
> =C2=A0 - Restore HFSPLUS_CAT_TREE_I dirty mark.
>=20
> Changes in v4:
> =C2=A0 - Correct fix: extract hidden dir creation into helper and call
> =C2=A0=C2=A0=C2=A0 from hfsplus_reconfigure() on remount rw, as suggested=
 by
> =C2=A0=C2=A0=C2=A0 Vyacheslav Dubeyko.
>=20
> Changes in v3:
> =C2=A0 - Correct fix location: guard sbi->hidden_dir in hfsplus_link()
> =C2=A0=C2=A0=C2=A0 and hfsplus_unlink() in dir.c.
>=20
> Changes in v2:
> =C2=A0 - Fixed commit message: hfsplus_delete_cat() has multiple callers,
> =C2=A0=C2=A0=C2=A0 not just hfsplus_unlink() as incorrectly stated in v1.
> ---
> =C2=A0fs/hfsplus/super.c | 100 ++++++++++++++++++++++++++++--------------=
-
> --
> =C2=A01 file changed, 62 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 40a0feda716b..56138881c35f 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -375,6 +375,52 @@ static int hfsplus_statfs(struct dentry *dentry,
> struct kstatfs *buf)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int hfsplus_create_hidden_dir(struct super_block *sb,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct qstr *str)
> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	struct inode *root =3D d_inode(sb->s_root);
> +	int err;
> +
> +	mutex_lock(&sbi->vh_mutex);
> +	sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> +	if (!sbi->hidden_dir) {
> +		err =3D -ENOMEM;
> +		goto out;
> +	}
> +
> +	err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
> +				 str, sbi->hidden_dir);
> +	if (err)
> +		goto out;
> +
> +	err =3D hfsplus_init_security(sbi->hidden_dir, root, str);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		err =3D 0; /* Operation is not supported. */
> +	else if (err) {
> +		/*
> +		 * Try to delete anyway without
> +		 * error analysis.
> +		 */
> +		hfsplus_delete_cat(sbi->hidden_dir->i_ino, root,
> str);
> +		goto out;
> +	}
> +
> +	mutex_unlock(&sbi->vh_mutex);
> +	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
> +				 HFSPLUS_I_CAT_DIRTY);
> +	hfsplus_mark_inode_dirty(sbi->hidden_dir,
> +				 HFSPLUS_I_CAT_DIRTY);
> +	return 0;
> +
> +out:
> +	mutex_unlock(&sbi->vh_mutex);
> +	cancel_delayed_work_sync(&sbi->sync_work);
> +	iput(sbi->hidden_dir);
> +	sbi->hidden_dir =3D NULL;
> +	return err;
> +}
> +
> =C2=A0static int hfsplus_reconfigure(struct fs_context *fc)
> =C2=A0{
> =C2=A0	struct super_block *sb =3D fc->root->d_sb;
> @@ -403,6 +449,18 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> +
> +		/*
> +		 * Create hidden dir if remounting read-write and it
> +		 * does not exist - required for link/unlink/rename.
> +		 */
> +		if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir)
> {
> +			struct qstr str =3D
> QSTR_INIT(HFSP_HIDDENDIR_NAME,
> +						=C2=A0=C2=A0=C2=A0
> sizeof(HFSP_HIDDENDIR_NAME) - 1);
> +			hfsplus_prepare_volume_header_for_commit(vhd
> r);
> +			hfsplus_sync_fs(sb, 1);

I think that true is better than 1 for hfsplus_sync_fs() call.

So, we didn't call hfsplus_prepare_volume_header_for_commit() and
hfsplus_sync_fs() in hfsplus_reconfigure() before. But, probably, it's
right thing to do. But currently, we call it only for the case of !sbi-
>hidden_dir. Should we do it for every RW mount?

Thanks,
Slava.

> +			return hfsplus_create_hidden_dir(sb, &str);
> +		}
> =C2=A0	}
> =C2=A0	return 0;
> =C2=A0}
> @@ -589,8 +647,8 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0		goto out_put_alloc_file;
> =C2=A0	}
> =C2=A0
> -	str.len =3D sizeof(HFSP_HIDDENDIR_NAME) - 1;
> -	str.name =3D HFSP_HIDDENDIR_NAME;
> +	str =3D (struct qstr)QSTR_INIT(HFSP_HIDDENDIR_NAME,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(HFSP_HIDDENDIR_NAME) -
> 1);
> =C2=A0	err =3D hfsplus_get_hidden_dir_entry(sb, &str, &entry);
> =C2=A0	if (err =3D=3D -ENOENT) {
> =C2=A0		/*
> @@ -620,40 +678,9 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0		hfsplus_sync_fs(sb, 1);
> =C2=A0
> =C2=A0		if (!sbi->hidden_dir) {
> -			mutex_lock(&sbi->vh_mutex);
> -			sbi->hidden_dir =3D hfsplus_new_inode(sb,
> root, S_IFDIR);
> -			if (!sbi->hidden_dir) {
> -				mutex_unlock(&sbi->vh_mutex);
> -				err =3D -ENOMEM;
> +			err =3D hfsplus_create_hidden_dir(sb, &str);
> +			if (err)
> =C2=A0				goto out_put_root;
> -			}
> -			err =3D hfsplus_create_cat(sbi->hidden_dir-
> >i_ino, root,
> -						 &str, sbi-
> >hidden_dir);
> -			if (err) {
> -				mutex_unlock(&sbi->vh_mutex);
> -				goto out_put_hidden_dir;
> -			}
> -
> -			err =3D hfsplus_init_security(sbi->hidden_dir,
> -							root, &str);
> -			if (err =3D=3D -EOPNOTSUPP)
> -				err =3D 0; /* Operation is not
> supported. */
> -			else if (err) {
> -				/*
> -				 * Try to delete anyway without
> -				 * error analysis.
> -				 */
> -				hfsplus_delete_cat(sbi->hidden_dir-
> >i_ino,
> -							root, &str);
> -				mutex_unlock(&sbi->vh_mutex);
> -				goto out_put_hidden_dir;
> -			}
> -
> -			mutex_unlock(&sbi->vh_mutex);
> -
> 			hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
> -					=09
> HFSPLUS_I_CAT_DIRTY);
> -			hfsplus_mark_inode_dirty(sbi->hidden_dir,
> -					=09
> HFSPLUS_I_CAT_DIRTY);
> =C2=A0		}
> =C2=A0	}
> =C2=A0
> @@ -661,9 +688,6 @@ static int hfsplus_fill_super(struct super_block
> *sb, struct fs_context *fc)
> =C2=A0	sbi->nls =3D nls;
> =C2=A0	return 0;
> =C2=A0
> -out_put_hidden_dir:
> -	cancel_delayed_work_sync(&sbi->sync_work);
> -	iput(sbi->hidden_dir);
> =C2=A0out_put_root:
> =C2=A0	dput(sb->s_root);
> =C2=A0	sb->s_root =3D NULL;
