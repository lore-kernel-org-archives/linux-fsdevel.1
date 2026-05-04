Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB8235F5E2
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 May 2026 22:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777935520; cv=none; b=MIo4nfM+Fl22dcLEEOVI5J9V0r1u02GdCz0iAIj6hbfTVCGQihnzYljQikBN203B46Sm3jZtjrjzjfRteSHU1ITrDBnxnSjPxLThoB/F1wLPx+K0qSl5CBdKQEMfPM672eqGiv5z1y8S165oRUAsYwTD7PyN/q5xOs7LCA4uuCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777935520; c=relaxed/simple;
	bh=hByIQHtYwWU2Dw8GVu1/drDFjgvcWWj4WsoQnGGM9/o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ipoei+safckKLTNGxzw8KGxpXCf725f6u5H48PgI6eD/NIy2QPMIcoUrAY3fldOELlJr8JZJLQSIX1EN0/jubJYndVhznlLxv6c0ph6Cuha0DkKKyoxb8KbLXQ2RB3LT1DEk9aVtgKxVjqCd1q4bEf0jH0uo9lntLDu8Hz9fhwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QJWuUhxY; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Si6Pd2NU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QJWuUhxY";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Si6Pd2NU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777935518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=otYP9qlPivhgGjjAyCmxaay9ECIM2UOHrr3dgkC5jX4=;
	b=QJWuUhxYbKCqcbmPF1HRwONOUMRkopF0u0Y1strAX3XiqnzV3hkXFAwMZOtRWl9OJl1vVZ
	zEQKZXKK/XTHpo38Wf1lbL4XcqLg+fKbkU2J0WjE8jwKXFOh0hD+tpiMkqxLm1DuBEa19t
	GDEGg9+k4g+Zt0XUE2p0zTkMjQJtKrY=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-ag-gDYdAOCSehEcx0vUupQ-1; Mon, 04 May 2026 18:58:37 -0400
X-MC-Unique: ag-gDYdAOCSehEcx0vUupQ-1
X-Mimecast-MFC-AGG-ID: ag-gDYdAOCSehEcx0vUupQ_1777935516
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7bcd5d5cd00so94124407b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 May 2026 15:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777935515; x=1778540315; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otYP9qlPivhgGjjAyCmxaay9ECIM2UOHrr3dgkC5jX4=;
        b=Si6Pd2NUcX/J+UlcbY0H4EVncO6QVTzh/Brz1crkozQMEzjZ0yMi7+oBjGn47GQ0e2
         4+P4/Uxcl9dwEu+rX1+sSuPKBxNnWifLAH857chwwwuzumtUt1djQhYj8jnaVi4gzMyq
         xczJXY92/u+UsjuT6MRgY+OaYr2DMF8MsUqZcxoq4oJJ04NQUEJxjOEOiOFzp6oSWP+f
         ghaLo6TRKwbyx8eryaT9+ZgVhW21wzsOoHYXDCNbF1vWp7VGxRfBOIIClklxS2KlHAzi
         RjwqxZ3sjYjzuU9ygR9fINvPMDPmP3aUZZ8ksncZxhtsIEzIZHTURAd3UKmZ45Ij/DFN
         cKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777935515; x=1778540315;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=otYP9qlPivhgGjjAyCmxaay9ECIM2UOHrr3dgkC5jX4=;
        b=oS6qU6p48hrYBhgXVBeGoeBMhtSC+vWHsL6B4KOyVLlTI0mRqQEJs4waZK+16of4iq
         +k/W6RQR7nXINcPP3gO6Bl6RVV0pf1XzFldxi30vDPDBO/KyBcNbaZyLPZBE8x52aWcW
         jpqbU3NMB2zPkfkligWaoAdWVhUn5bo70RgfDk+Zd9DlrbY+p13sB+5ABjrPYdwo+7Cw
         1GKoE9bRDRFQlsG+JVgjOgUaRWAAvevOqtg4ApBFOR/e9iMgy2noDrkoGXuevMzvaUYB
         8STGEjU2/kj0wMTu1tnzeZx0lpqbpJCFbgYQGhkxcp+iAA7cMtFLOEI/gIfsC5K6X06L
         jbfw==
X-Gm-Message-State: AOJu0Yykt4YxkQRp7OPUxIIj2WIgqlKiPCcQuq9O0LygANC5y2LjKKc3
	jGfCNbpO0KwA4ULVextZ4PyXmDRY5Cfi674h/BN678RLh6PriG15oh/Aexw/oBjRxUoM7Udh7c4
	vq9PLhbbWEklCAo+F7Fj/Q3gfVeXeUVLfpCKBSUQEj8prTVnPEn+X84O3vkuOhEzXk64jIT8jW4
	o=
X-Gm-Gg: AeBDies9ib/QV0n4QtooxU19Z63Cm5Jnh1E9MdDikw0wQnKgFMg03P4f+QCDI7O/qsR
	mtlPHuHP7X990cHUclHAeNdfkpE8hHKMJS16TTXlyhzgtqxndr8CFvOldCElk0EpIyiwsQMaNKW
	vjlKa9nj68/X0FcZoMO3rmF57HqX/9nxdMz42W33JGcxAn0TyY2qdHkH3abBocKU3y/yDKdhNgK
	6nWIltOGBP6qnets3iIko2tgpaTWFnO3+BSl77NQrzIVRgy0qazkrjXJUL3E1YdJJC09aLlAHrM
	UwcQhlvXF5TUEsTTwNJ961S1FEm5dCbwc90HM7KNreFHVTme1yoCim2PgYzvvCTDH+GNIJnyEz7
	SR/tPFei3XYRNa+Z96pzWgGW6xbrMnmlYxg54nOgBOvfRA7jQr4NN9k66obSRjsc=
X-Received: by 2002:a05:690c:6e85:b0:7bd:8752:cdbd with SMTP id 00721157ae682-7bd8752e640mr84014627b3.41.1777935515390;
        Mon, 04 May 2026 15:58:35 -0700 (PDT)
X-Received: by 2002:a05:690c:6e85:b0:7bd:8752:cdbd with SMTP id 00721157ae682-7bd8752e640mr84014357b3.41.1777935514811;
        Mon, 04 May 2026 15:58:34 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6688c99bsm56636347b3.45.2026.05.04.15.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 15:58:34 -0700 (PDT)
Message-ID: <d157fb276575cba9e9a787dba65b4a0467f34e38.camel@redhat.com>
Subject: Re: [PATCH v5] hfsplus: fix null-ptr-deref by creating hidden dir
 on remount rw
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 15:58:33 -0700
In-Reply-To: <20260503044436.130823-1-kartikey406@gmail.com>
References: <20260503044436.130823-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-05-03 at 10:14 +0530, Deepanshu Kartikey wrote:
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
> Changes in v5:
>   - Pass str as input argument to hfsplus_create_hidden_dir()
>     to avoid duplication, as suggested by Vyacheslav Dubeyko.
>   - Use !(fc->sb_flags & SB_RDONLY) as guard in reconfigure
>     instead of !sb_rdonly(sb).
>   - Restore cancel_delayed_work_sync() in cleanup path.
>   - Restore HFSPLUS_CAT_TREE_I dirty mark.
>=20
> Changes in v4:
>   - Correct fix: extract hidden dir creation into helper and call
>     from hfsplus_reconfigure() on remount rw, as suggested by
>     Vyacheslav Dubeyko.
>=20
> Changes in v3:
>   - Correct fix location: guard sbi->hidden_dir in hfsplus_link()
>     and hfsplus_unlink() in dir.c.
>=20
> Changes in v2:
>   - Fixed commit message: hfsplus_delete_cat() has multiple callers,
>     not just hfsplus_unlink() as incorrectly stated in v1.
> ---
>  fs/hfsplus/super.c | 97 +++++++++++++++++++++++++++++-----------------
>  1 file changed, 61 insertions(+), 36 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 40a0feda716b..f37d5abc84cf 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -375,6 +375,54 @@ static int hfsplus_statfs(struct dentry *dentry, str=
uct kstatfs *buf)
>  	return 0;
>  }
> =20
> +static int hfsplus_create_hidden_dir(struct super_block *sb,
> +				     const struct qstr *str)
> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	struct inode *root =3D d_inode(sb->s_root);
> +	int err;
> +
> +	mutex_lock(&sbi->vh_mutex);
> +	sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> +	if (!sbi->hidden_dir) {
> +		mutex_unlock(&sbi->vh_mutex);

Frankly speaking, we have too many places of calling mutex_unlock() in the =
case
of error. It will be much better to call mutex_unlock() in one place for th=
e
case of error. Could we rework this code pattern?

> +		return -ENOMEM;
> +	}
> +
> +	err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
> +				 str, sbi->hidden_dir);
> +	if (err) {
> +		mutex_unlock(&sbi->vh_mutex);

Ditto.

> +		goto out_put_hidden_dir;
> +	}
> +
> +	err =3D hfsplus_init_security(sbi->hidden_dir, root, str);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		err =3D 0; /* Operation is not supported. */
> +	else if (err) {
> +		/*
> +		 * Try to delete anyway without
> +		 * error analysis.
> +		 */
> +		hfsplus_delete_cat(sbi->hidden_dir->i_ino, root, str);
> +		mutex_unlock(&sbi->vh_mutex);

Ditto.

> +		goto out_put_hidden_dir;
> +	}
> +
> +	mutex_unlock(&sbi->vh_mutex);
> +	hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
> +				 HFSPLUS_I_CAT_DIRTY);
> +	hfsplus_mark_inode_dirty(sbi->hidden_dir,
> +				 HFSPLUS_I_CAT_DIRTY);
> +	return 0;
> +
> +out_put_hidden_dir:

Here it will be enough to have the out label name. Because, we are inside o=
f
hfsplus_create_hidden_dir() method.

> +	cancel_delayed_work_sync(&sbi->sync_work);
> +	iput(sbi->hidden_dir);
> +	sbi->hidden_dir =3D NULL;
> +	return err;
> +}
> +
>  static int hfsplus_reconfigure(struct fs_context *fc)
>  {
>  	struct super_block *sb =3D fc->root->d_sb;
> @@ -403,6 +451,18 @@ static int hfsplus_reconfigure(struct fs_context *fc=
)
>  			sb->s_flags |=3D SB_RDONLY;
>  			fc->sb_flags |=3D SB_RDONLY;
>  		}
> +
> +		/*
> +		 * Create hidden dir if remounting read-write and it
> +		 * does not exist - required for link/unlink/rename.
> +		 */

I started to think that, probably, we need this logic here:

  if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir) {                   =
   =20
      struct qstr str =3D QSTR_INIT(HFSP_HIDDENDIR_NAME,
                                  sizeof(HFSP_HIDDENDIR_NAME) - 1);        =
   =20
                                                                           =
                                                   =20
      hfsplus_prepare_volume_header_for_commit(vhdr);                      =
   =20
      hfsplus_sync_fs(sb, 1);                                              =
   =20
      return hfsplus_create_hidden_dir(sb, &str);                          =
   =20
  }

In hfsplus_fill_super() we have:

  hfsplus_prepare_volume_header_for_commit(vhdr);
  hfsplus_sync_fs(sb, 1);

If the machine crashes mid-creation, the next mount sees HFSPLUS_VOL_UNMNT =
clear
and runs fsck. However, we didn't anything like this for the case of
hfsplus_reconfigure(). If the system crashes after the B-tree entry for the
hidden directory is written but before the next asynchronous hfsplus_sync_f=
s()
runs the volume header still has HFSPLUS_VOL_UNMNT set while the B-tree con=
tains
the new entry. The next mount sees a "cleanly unmounted" header, accepts it=
, and
skips fsck =E2=80=94 leaving the filesystem in a subtly inconsistent state.=
 What do you
think? Am I right here?

> +		if (!(fc->sb_flags & SB_RDONLY) && !sbi->hidden_dir) {
> +			struct qstr str;
> +
> +			str.len =3D sizeof(HFSP_HIDDENDIR_NAME) - 1;
> +			str.name =3D HFSP_HIDDENDIR_NAME;

The str.hash (the other field of the union in struct qstr) is left
uninitialised. I think we need to do it in different way here and in
hfsplus_fill_super():

  struct qstr str =3D QSTR_INIT(HFSP_HIDDENDIR_NAME,
                              sizeof(HFSP_HIDDENDIR_NAME) - 1);

Thanks,
Slava.

> +			return hfsplus_create_hidden_dir(sb, &str);
> +		}
>  	}
>  	return 0;
>  }
> @@ -620,40 +680,9 @@ static int hfsplus_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  		hfsplus_sync_fs(sb, 1);
> =20
>  		if (!sbi->hidden_dir) {
> -			mutex_lock(&sbi->vh_mutex);
> -			sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> -			if (!sbi->hidden_dir) {
> -				mutex_unlock(&sbi->vh_mutex);
> -				err =3D -ENOMEM;
> +			err =3D hfsplus_create_hidden_dir(sb, &str);
> +			if (err)
>  				goto out_put_root;
> -			}
> -			err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
> -						 &str, sbi->hidden_dir);
> -			if (err) {
> -				mutex_unlock(&sbi->vh_mutex);
> -				goto out_put_hidden_dir;
> -			}
> -
> -			err =3D hfsplus_init_security(sbi->hidden_dir,
> -							root, &str);
> -			if (err =3D=3D -EOPNOTSUPP)
> -				err =3D 0; /* Operation is not supported. */
> -			else if (err) {
> -				/*
> -				 * Try to delete anyway without
> -				 * error analysis.
> -				 */
> -				hfsplus_delete_cat(sbi->hidden_dir->i_ino,
> -							root, &str);
> -				mutex_unlock(&sbi->vh_mutex);
> -				goto out_put_hidden_dir;
> -			}
> -
> -			mutex_unlock(&sbi->vh_mutex);
> -			hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb),
> -						 HFSPLUS_I_CAT_DIRTY);
> -			hfsplus_mark_inode_dirty(sbi->hidden_dir,
> -						 HFSPLUS_I_CAT_DIRTY);
>  		}
>  	}
> =20
> @@ -661,9 +690,6 @@ static int hfsplus_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>  	sbi->nls =3D nls;
>  	return 0;
> =20
> -out_put_hidden_dir:
> -	cancel_delayed_work_sync(&sbi->sync_work);
> -	iput(sbi->hidden_dir);
>  out_put_root:
>  	dput(sb->s_root);
>  	sb->s_root =3D NULL;

