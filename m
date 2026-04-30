Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CB334DB6C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777578413; cv=none; b=PW6bTS3b/5G09EHct97WWFRTVR6K5YX17w5D+qwPXFRowwOfq43Zxn/oq8P0zfNQJsSbUa57AJp1UOUHtx8NCr83PhWWGe7kmYkN5NsgmX1bUjitozObDtC8Uc4/t2Fi/MFyCtMhmbkbvF6CSgnAwx6EWof+1nm3wvaakKEFUMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777578413; c=relaxed/simple;
	bh=p8xbgS6C1fOgo+36tywwUjCs6aIKbreuZE/pEOqFa6s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q0JvWtvHDZ3rLmKmthnB57peY5VIJtbs1T4/FgkwQ2g0IuzPNUJDAJxsj1otUxzGl3Ets92U5h74eD6B9AHPQrDeGt3vLGg1egiQ2k6//bjjDmcjVgNSSxLT7Bkyrz3f6otdljzbdp3T8XXCk4QGxNy4hatR15zYh8N67G/AUbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Kl9uLOtC; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OHXwpflq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kl9uLOtC";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OHXwpflq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777578411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RkuhnTZK3QeVLQ8p6kdpJnT5whHnDkMltm4Ec0FV3U=;
	b=Kl9uLOtCjcyLhciUd7iA0QpDL+LIyrFxpmurVEEkmUHUuhpJ+AKZ8vFTzzX3ZH6Cn+QLts
	HSHzjrLHxp88XMTLmv9SjSp30qEximCUUGAZOhs0jb/mBzJ/3ysBGcCxnLIve014+Ihb40
	NYjmgfAAUUclqEcuzLNjLIoTKKuAch4=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-dkzMcUbDMl2Bz9epSPjF6Q-1; Thu, 30 Apr 2026 15:46:47 -0400
X-MC-Unique: dkzMcUbDMl2Bz9epSPjF6Q-1
X-Mimecast-MFC-AGG-ID: dkzMcUbDMl2Bz9epSPjF6Q_1777578406
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-790afc07667so32284817b3.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 12:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777578406; x=1778183206; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RkuhnTZK3QeVLQ8p6kdpJnT5whHnDkMltm4Ec0FV3U=;
        b=OHXwpflqF+Crn94xUqwDS1yiEyEoLAJL2KjRkeA2PpLewZjJH3wpdcouy0TSYZKzkl
         90HihHD7ShL2VC+6dNw9Tmaw/c0fdPZuSnG6pUbPPpZOObi4j0Pj351gyEroNbA0LQok
         RiraF5lFNIfulLaCM4/TSHPq3ZPs1V9a1BC+e8LCrhkPLE0XhD3PfCr0aecMTOya8Bzj
         Q4G+dNc9ecmi4s7bA0iMUw0QuTT8xINgoHCRUQ5lUX55je7JLXU5D5LR6nXMgPGbFSze
         SfdZPnsCLSg0ITN1xnHAFUM1HReZgr7JMuFKPgOz3UkSPdDMTR7dhNCYymPWAXbkGeIf
         s4bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777578406; x=1778183206;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7RkuhnTZK3QeVLQ8p6kdpJnT5whHnDkMltm4Ec0FV3U=;
        b=h+1CqBhHyKcpm5b5ba/ByRcC9/kFozh1Nc9IuTvAZbF4r1iPzYvorVmwIVDHtjtJ9o
         qXu8icGolQ560d/+RvYcGq0ZhGYWnVGxuwBievXcQtDLfZ2GujzNo0E/M6BooVJSFgOZ
         0vxS1hXOMlDI5zCSC2V1N8bTv8B4qT6hhRirLZ/h5ivazJRKyG79QiJ8yVLc4wyLVWRn
         aRsCNkqirXANyW5r0/MlFsEusPoUoGYZnrbGamniakElrK0i4TwfMWbIAk1qsrGAnoWc
         08SY/ofQQSnCJVsRoQg3q+peuEBU02rV3X4lpD+eeCE5gP4J6vnhVCVFduAdTTtXf6aM
         jbQA==
X-Gm-Message-State: AOJu0YyR0/czAILH88k7uE7NTFBx+AjTs8xxe6x+2BA1Zxhhcmi7ogIk
	P2bfy332ZLXWQai2GRygAE7p25Ax+6foZ8nske5cKGcT70bQoyC5fwNej5jZAWwtRM3HAAU+Qxm
	Q2HYZjTqDtX7z3ElBxIwVv62cAYedunK/eohRw4bnylfOc3PdzwIgisWAmJ5f8+kS6bQ7XWNvNB
	A=
X-Gm-Gg: AeBDievsJPpB/ukhL/kkemiLW1Ho08c+JmMEMzZEUI38HmQnSVJoZrnSDkkLebxdqyk
	XxJfKDoVQwGqL9XUaA4fXWXf1+c3XHHs2QQEjGdA3ze6T2bEK+tYxR56bbAlYmRE9Kka4t0Agr7
	KTAffwe55bzju7dtGX0o6B/X3B2EyX7U5jGe/ExL/RzxpGGXCaTuvX9sNc2Rn0Ow1kGE1gFxTmi
	q02yXWkCpxOLGI3HXinmfX37Ly2pDgUqplFPTDPOBKYN+x+yGbPwc71WgEyIY+rcrBneN/2lmKh
	Z7M/BO9vlucqNYizLomiJ2Nm1jNgt8IBfqQFDw6ZoeioMNgYDyuDZAYD7CkC+9UeDrHG3xFjKQp
	KsMw55e6uvqOntS5wWBwGiZTthHLo1XRItqUrKSTarrCK9BpZ1xOPECGBjRCsN/s=
X-Received: by 2002:a05:690c:6b01:b0:7b3:5872:694d with SMTP id 00721157ae682-7bd54803d33mr43303257b3.22.1777578405677;
        Thu, 30 Apr 2026 12:46:45 -0700 (PDT)
X-Received: by 2002:a05:690c:6b01:b0:7b3:5872:694d with SMTP id 00721157ae682-7bd54803d33mr43302867b3.22.1777578405159;
        Thu, 30 Apr 2026 12:46:45 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6689ac83sm1461657b3.49.2026.04.30.12.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 12:46:44 -0700 (PDT)
Message-ID: <780d7cbfe8184eb2a90651393e0b3d28eee99ae0.camel@redhat.com>
Subject: Re: [PATCH v4] hfsplus: fix null-ptr-deref by creating hidden dir
 on remount rw
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Thu, 30 Apr 2026 12:46:41 -0700
In-Reply-To: <20260430020358.111052-1-kartikey406@gmail.com>
References: <20260430020358.111052-1-kartikey406@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-04-30 at 07:33 +0530, Deepanshu Kartikey wrote:
> hfsplus_reconfigure() does not create the hidden directory when
> remounting from read-only to read-write, leaving sbi->hidden_dir
> as NULL. This causes a null-ptr-deref when any subsequent
> link/unlink/rename operation dereferences it.
>=20
> Extract hidden directory creation into a helper and call it from
> hfsplus_reconfigure() when switching to read-write mode.
>=20
> Reported-by: syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc0ba772a362e70937dfb
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
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
>  fs/hfsplus/super.c | 88 ++++++++++++++++++++++++++++------------------
>  1 file changed, 53 insertions(+), 35 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 7229a8ae89f9..8b5c39ce4d48 100644
> --- a/fs/hfsplus/super.c
> +++ b/fs/hfsplus/super.c
> @@ -372,15 +372,59 @@ static int hfsplus_statfs(struct dentry *dentry, st=
ruct kstatfs *buf)
>  	return 0;
>  }
> =20
> +static int hfsplus_create_hidden_dir(struct super_block *sb)
> +{
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> +	struct inode *root =3D d_inode(sb->s_root);
> +	struct qstr str;
> +	int err;
> +
> +	str.len =3D sizeof(HFSP_HIDDENDIR_NAME) - 1;
> +	str.name =3D HFSP_HIDDENDIR_NAME;

The hfsplus_fill_super() has this initialization. It looks like duplication=
.
Maybe, we need to add this into hfsplus_reconfigure() and get str as input
argument?

> +
> +	mutex_lock(&sbi->vh_mutex);
> +	sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> +	if (!sbi->hidden_dir) {
> +		mutex_unlock(&sbi->vh_mutex);
> +		return -ENOMEM;
> +	}
> +
> +	err =3D hfsplus_create_cat(sbi->hidden_dir->i_ino, root,
> +				 &str, sbi->hidden_dir);
> +	if (err) {
> +		mutex_unlock(&sbi->vh_mutex);
> +		goto out_put_hidden_dir;
> +	}
> +
> +	err =3D hfsplus_init_security(sbi->hidden_dir, root, &str);
> +	if (err =3D=3D -EOPNOTSUPP)
> +		err =3D 0;
> +	else if (err) {
> +		hfsplus_delete_cat(sbi->hidden_dir->i_ino, root, &str);
> +		mutex_unlock(&sbi->vh_mutex);
> +		goto out_put_hidden_dir;
> +	}
> +
> +	mutex_unlock(&sbi->vh_mutex);
> +	hfsplus_mark_inode_dirty(sbi->hidden_dir,
> +				 HFSPLUS_I_CAT_DIRTY);
> +	return 0;
> +
> +out_put_hidden_dir:
> +	iput(sbi->hidden_dir);
> +	sbi->hidden_dir =3D NULL;
> +	return err;
> +}
> +
>  static int hfsplus_reconfigure(struct fs_context *fc)
>  {
>  	struct super_block *sb =3D fc->root->d_sb;
> +	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> =20
>  	sync_filesystem(sb);
>  	if ((bool)(fc->sb_flags & SB_RDONLY) =3D=3D sb_rdonly(sb))
>  		return 0;
>  	if (!(fc->sb_flags & SB_RDONLY)) {
> -		struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
>  		struct hfsplus_vh *vhdr =3D sbi->s_vhdr;
> =20
>  		if (!(vhdr->attributes & cpu_to_be32(HFSPLUS_VOL_UNMNT))) {
> @@ -401,6 +445,12 @@ static int hfsplus_reconfigure(struct fs_context *fc=
)
>  			fc->sb_flags |=3D SB_RDONLY;
>  		}
>  	}
> +	/*
> +	 * Create hidden dir if remounting read-write and it does
> +	 * not exist - required for link/unlink/rename operations.
> +	 */
> +	if (!sb_rdonly(sb) && !sbi->hidden_dir)
> +		return hfsplus_create_hidden_dir(sb);

It looks like hfsplus_reconfigure() is always false on a successful remount=
. The
sb->s_flags is updated by the VFS after reconfigure returns 0, not inside i=
t.
The correct guard is !(fc->sb_flags & SB_RDONLY), which reflects the negoti=
ated
new state.

>  	return 0;
>  }
> =20
> @@ -595,38 +645,9 @@ static int hfsplus_fill_super(struct super_block *sb=
, struct fs_context *fc)
>  		hfsplus_sync_fs(sb, 1);
> =20
>  		if (!sbi->hidden_dir) {
> -			mutex_lock(&sbi->vh_mutex);
> -			sbi->hidden_dir =3D hfsplus_new_inode(sb, root, S_IFDIR);
> -			if (!sbi->hidden_dir) {
> -				mutex_unlock(&sbi->vh_mutex);
> -				err =3D -ENOMEM;
> +			err =3D hfsplus_create_hidden_dir(sb);
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

What was wrong with the comment? Why have we lost it?

> -				hfsplus_delete_cat(sbi->hidden_dir->i_ino,
> -							root, &str);
> -				mutex_unlock(&sbi->vh_mutex);
> -				goto out_put_hidden_dir;
> -			}
> -
> -			mutex_unlock(&sbi->vh_mutex);
> -			hfsplus_mark_inode_dirty(sbi->hidden_dir,
> -						 HFSPLUS_I_CAT_DIRTY);

Are you sure that you work with the latest sources? Because, current state =
of
this code is:

  hfsplus_mark_inode_dirty(HFSPLUS_CAT_TREE_I(sb), HFSPLUS_I_CAT_DIRTY);   =
   =20
  hfsplus_mark_inode_dirty(sbi->hidden_dir,        HFSPLUS_I_CAT_DIRTY);

>  		}
>  	}
> =20
> @@ -634,9 +655,6 @@ static int hfsplus_fill_super(struct super_block *sb,=
 struct fs_context *fc)
>  	sbi->nls =3D nls;
>  	return 0;
> =20
> -out_put_hidden_dir:
> -	cancel_delayed_work_sync(&sbi->sync_work);

Why cancel_delayed_work_sync() has been removed? The hfsplus_new_inode() ca=
lls
hfsplus_mark_mdb_dirty() which queues sync_work. So, nothing cancels the qu=
eued
work in the case of any issue.

Thanks,
Slava.

> -	iput(sbi->hidden_dir);
>  out_put_root:
>  	dput(sb->s_root);
>  	sb->s_root =3D NULL;

