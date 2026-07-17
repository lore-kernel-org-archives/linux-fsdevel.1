Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC6937AA9C
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 18:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311862; cv=none; b=dsNN9DrHLTmI0qbCYKzCD/MNXPL9WxST/Ad2meb+YhgjpgX8vtVA8R9QlyJYRqCCMY4rFuwpaPqySkApRUEHE1m8AiGhFtacAGailm5qVkQqFoP+Hke1LbzOV9TQTCI7nxL36Lyso4t/+G6TDiG5hogIV36u5cLmX2BrNpVeaRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311862; c=relaxed/simple;
	bh=Ved/rXoC/3rxnYERbRtJcrbq8oJqOzhyGIksolLDG/0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cgezH9JRWxpZ7vPwEbl3sSOm9sz6P4HcjIQpxzKpY/l7o9K8D9qChU+YisDA84mGEe/zhsqT7mf11Uw77ShEz6HNvx+WcIuljfMXvk/5l1h3cTjU/HBr1ioR1OmuEyu3YvLEq26xDthet0hpjASpCOXR0/2/64MgDulB0eL/UGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=TjOodHbK; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="TjOodHbK"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-81e9f7491ffso102827547b3.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 11:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784311858; x=1784916658; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DKOzy9vP3cM8znyzW/pm/9ayZuwXmdJlhNTj0r96dFg=;
        b=TjOodHbK0ar3x21inpqZkIrBYmAOzp12X5yl806b1SGT3EP4HyDn9oBd5u4j0GJerL
         eOZ+XdJw4qwWYQ4vV07JnXf1ydG12TiEoJbVzknRagB7J57TYoIkBpu1RSNhsric+RDV
         cXCP4+pU3iofnTV7AGvVDuSbFQOPmp05kagpCDTnQY1ITb+0HJqqzLZDcedXo1t7Hu63
         S2pDDJbcEs/1jLOhUMtvPlLpYRrbE7ujdldSJ3PxMLegVUnjXB/7lj0eTMJWNnqgMQgV
         4GeBhZFsAAlhLO0k8V1cbkd3qNvJACsGayaaPUEW56DHAVU1ahvPPWt1N2WuBmpas9Pp
         +lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784311858; x=1784916658;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DKOzy9vP3cM8znyzW/pm/9ayZuwXmdJlhNTj0r96dFg=;
        b=CYtvjyfTsagER2QphYWTkmdIFos+qM4nSM8YDiK/KAu5CYelwjoFATCR7V+5rgmBd+
         SP8H3nSomsxVLjMPbHKr8bR0Vg+Sc6ggKKHlX/3CQri37Oi+JvIOGYA3/H1ZG/QrzRMa
         Wj1mq/4j/ZS2kobjlBpFPnDDBLKwGfrxf9blgLHPYjipFVPjIJjHqZr4sFz1RTQpFQtv
         JHHvEQ333W1LlYrX+AAd1At06BdnQVxrqZmV9ElIh6MZxipBP6VbAyvTopXksTC5qWYH
         s1+EbgtFJ3v4I3U9t2Ew4Yz8pYoi5TDp2uXCN/lv2KhlvaXp++dBHqd653Qwdy9m9m6S
         6Tqg==
X-Gm-Message-State: AOJu0YyrqK0KHB64+5Dju6ow6KNZzewDohrE3QyeL7VOM1vSYYqrjCOI
	LBLPaZpmpDSnq6TANgXQj4l5kAeBLeaQ34IHi2ruH+YLXOK4Gy5P/fVKiYpr39/1ECA=
X-Gm-Gg: AfdE7cmVMXhfG+YrMInLOJMQiS8uH7c3o2pAIO9bFcYLcsLcwxaPn+czl3CVp2+L5ns
	g9G72bkNkjOWppxactcqX9p9EOFmP2fOKlQESUw/uefrzcBIVpu9apBWeB0hBceTLB6PKocK2h+
	fQ2RQ4QJAgo+8MMC96guShEm9v8Cz8vkkxB9c0ppnG7a/bNzRtIz+FgPpglxVCIdx2Gw4PPHS2T
	JkME+KTh4vElIqfRClt8fcMogVp+WY8nK+9YepeUCsxCu7wHis4Q/9vWrumELn6yk21Y0p4HMkt
	+8gwrCBVWXyZbeZXr4GKzlHsZ7yfRoADBP13hyBXMaxtfJb5k2iohuP7sRkCO4HAFuYjTgtGV+o
	1IIIDPK0PhuAdcoZRLs9M7pyLeToYidZlpdsM8XQQpOMtoF+fChS/NikOmXehKfnWJ0pV6c/+A3
	P3ykVsHyYhqcd87jhnlGo1RESfQBVbnMVKisJSaw8q2IXUzsJW2/QKYIAri048+SoDwFNYxmG2q
	gVZUrPxBbu33p5ek82XQ7OnnMVgjmknDzku/UVst7+QX/TaMOYXoAU/Z42RydAxuLLdN2g=
X-Received: by 2002:a05:690c:4a09:b0:81d:fa1:97f3 with SMTP id 00721157ae682-81ef26de074mr12898737b3.10.1784311858118;
        Fri, 17 Jul 2026 11:10:58 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b0a:7ecd:9294:edb1? ([2600:1700:6476:1430:9b0a:7ecd:9294:edb1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef401625bsm16599707b3.8.2026.07.17.11.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:10:57 -0700 (PDT)
Message-ID: <ef8d4ce4e9043e91e1eb554da3959560b981262e.camel@dubeyko.com>
Subject: Re: [PATCH v7] hfsplus: fix null-ptr-deref by creating hidden dir
 on remount rw
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Deepanshu Kartikey <kartikey406@gmail.com>,
 glaubitz@physik.fu-berlin.de, 	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+c0ba772a362e70937dfb@syzkaller.appspotmail.com
Date: Fri, 17 Jul 2026 11:10:55 -0700
In-Reply-To: <20260717135706.42918-1-kartikey406@gmail.com>
References: <20260717135706.42918-1-kartikey406@gmail.com>
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

On Fri, 2026-07-17 at 19:27 +0530, Deepanshu Kartikey wrote:
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
> Changes in v7:
> =C2=A0 - Call hfsplus_prepare_volume_header_for_commit() and
> =C2=A0=C2=A0=C2=A0 hfsplus_sync_fs() for all rw remounts in reconfigure
> =C2=A0=C2=A0=C2=A0 not just when hidden_dir is NULL, as suggested by
> =C2=A0=C2=A0=C2=A0 Vyacheslav Dubeyko.
> =C2=A0 - Remove redundant inner hidden_dir NULL check.
>=20
> Changes in v6:
> =C2=A0 - Use single mutex_unlock() in error path of helper.
> =C2=A0 - Rename label out_put_hidden_dir to out inside helper.
> =C2=A0 - Use QSTR_INIT() in reconfigure and compound literal
> =C2=A0=C2=A0=C2=A0 cast in fill_super.
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
> =C2=A0fs/hfsplus/super.c | 102 ++++++++++++++++++++++++++++--------------=
-
> --
> =C2=A01 file changed, 64 insertions(+), 38 deletions(-)
>=20
> diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> index 40a0feda716b..3983e8160302 100644
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

Another issue we still have here. The hfsplus_create_hidden_dir()'s
failure path calls cancel_delayed_work_sync(&sbi->sync_work)
unconditionally. That's correct when called from hfsplus_fill_super()
(mount failing =E2=86=92 whole sbi is being torn down anyway), but wrong wh=
en
called from hfsplus_reconfigure(). The sbi->work_queued is only ever
reset to 0 inside delayed_sync_fs() itself when it actually runs. If we
cancel a pending instance before it fires, work_queued stays stuck at 1
forever. I assume that the helper needs to not call
cancel_delayed_work_sync(). Does it make sense?

> +	iput(sbi->hidden_dir);
> +	sbi->hidden_dir =3D NULL;
> +	return err;
> +}
> +
> =C2=A0static int hfsplus_reconfigure(struct fs_context *fc)
> =C2=A0{
> =C2=A0	struct super_block *sb =3D fc->root->d_sb;
> @@ -403,6 +449,20 @@ static int hfsplus_reconfigure(struct fs_context
> *fc)
> =C2=A0			sb->s_flags |=3D SB_RDONLY;
> =C2=A0			fc->sb_flags |=3D SB_RDONLY;
> =C2=A0		}
> +
> +		/*
> +		 * Create hidden dir if remounting read-write and it
> +		 * does not exist - required for link/unlink/rename.
> +		 */
> +		if (!(fc->sb_flags & SB_RDONLY)) {

I've spent more time on thinking about RW->RO remounting. And I think
we still have a serious issue here.

The "mark this volume cleanly unmounted" step (vhdr->attributes |=3D
HFSPLUS_VOL_UNMNT; ... &=3D ~HFSPLUS_VOL_INCNSTNT;) only happens in two
places: hfsplus_prepare_volume_header_for_commit() (called when
mounting or remounting rw) and directly inside hfsplus_put_super().

So take the sequence mount rw =E2=86=92 remount ro =E2=86=92 unmount: the v=
olume was
marked INCNSTNT at mount time, never gets cleared by the remount-to-ro
(no code path does it), and then put_super() sees sb_rdonly(sb) =3D=3D true
and skips clearing it too. The volume permanently retains
HFSPLUS_VOL_INCNSTNT / missing HFSPLUS_VOL_UNMNT after any such
session, so the next mount anywhere (Linux or macOS) will warn "not
cleanly unmounted, recommend fsck" and potentially force read-only - a
false positive, since nothing was actually left inconsistent.

So, sorry, but we need to rework the hfsplus_reconfigure() more
carefully. This patch revealed the pre-existing issue.

Thanks,
Slava.

> +			hfsplus_prepare_volume_header_for_commit(vhd
> r);
> +			hfsplus_sync_fs(sb, 1);
> +			if (!sbi->hidden_dir) {
> +				struct qstr str =3D
> QSTR_INIT(HFSP_HIDDENDIR_NAME,
> +						=C2=A0=C2=A0=C2=A0
> sizeof(HFSP_HIDDENDIR_NAME) - 1);
> +				return hfsplus_create_hidden_dir(sb,
> &str);
> +			}
> +		}
> =C2=A0	}
> =C2=A0	return 0;
> =C2=A0}
> @@ -589,8 +649,8 @@ static int hfsplus_fill_super(struct super_block
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
> @@ -620,40 +680,9 @@ static int hfsplus_fill_super(struct super_block
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
> @@ -661,9 +690,6 @@ static int hfsplus_fill_super(struct super_block
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
