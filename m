Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793897643;
	b=XvtQA3wNo+tMncSDWDu5GSmI1EIgjpOU81UsVoo2SeEvKJbpgE8fyc0Q7tGPFX7ChMR+
	 lSn4a74ajDXcnLF5ixo/YAn+TBAm/TIMDA4FojJDGFO8OB1QNgDKjJPWrV2RYWej/jTni
	 uPqsxbT7Z2MS8WdcIvgq4ng24rD2NIO1c7Vtlc/P7ARwDaYBM8Wpq56M5QhhuoLefWqwM
	 /Ph70Ys0vN6MeQNZyVkvqvNqGCAO8HPKlldBPiaVwOaBwWc3pNiTGMGM7k0jNQxB2YOgF
	 EH+G2VuigyCNtjEYfsmcNWN1vNlXpfFH5Z2IpOauvTZlNu6uZoGKs+lzoXTGuirXEvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793897643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dwfOaeQbEriUr7n1LwUP935/2zWyl9SRrKy8JH5RF/A=;
	b=jgHMvp0NV5GLrEYL3pZIkUVxG2iFpkbHdpsdPuKQK4TQMnMTUAHAmSQ9dFnKdS6hhZEq
	 o7dz3L+aT/rYVkRaDXt3ko0qrPlLZ5PCli+EmA9QBR3zM6ZyM971f0LNGFRWXoHK/lvCO
	 gRjKAPa+KFrAoQ/GAAWborTs39zI27Dg5df2pGcZKeUR7GphBmCZmkJor3D4ag2ojTUxW
	 Qcpe22lY1zfolfQ54thfG3yOPT9AsssC4ALCpWE6yChzNCzEDWlASxQJkqsLPImfpTqJE
	 9Wlz+HTasATWaBpk0ojyETmh7YjwT32T9JTsoDdKI5b2FyAfkWUpSFnYDCg/H8QI5Eg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="LcnwD/qS";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE0D606A326
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Nov 2026 16:54:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ACE0D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LcnwD/qS
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4cb6834eaaso374361666b.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 05 Nov 2026 08:54:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793897641; cv=none;
        d=google.com; s=arc-20260327;
        b=XavinkxCQYTMrCsHbfHF0YBJ230VFUk/XwzRYOmVvwZupiuw9iVblao17gx3Rt7FoE
         YPdj9XSq275woQ2ygutqtP8ihBOg1NsjfWtcSX2EB6SbOOHpLCpChZuAt9qfvDVf7p89
         l4jk9hShCR3U/izMqBUVFZKJwud0HhpBtqMgr7kkCsNu/6P8Wb9HZU58s9BEjt+tbFtm
         X6YIQNPKK1TfSRU/HxjhYjczive53zcT5J8qZYak555U1tdb5Qu0zponx6aXa1spMtnI
         nGZYaKPHHNdIR4JMpfuWgskC9jtjNco4zEhV2deGtsO+e/uECbNt9EhvxwBB/zlouxZT
         RCIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dwfOaeQbEriUr7n1LwUP935/2zWyl9SRrKy8JH5RF/A=;
        fh=iwN3x6tiZtnIKow6XgFu/uWNe3xrh+lBupEg11BQ+s8=;
        b=au0swunc6G/ZN30srEQiw+VKgT6BN2vnbXFmYUWnkWygU0MEFAliyXq+Esh/4NhYjv
         zdw5YRqrBZvIajB8e4R2NPtvTUyCd8k9v4M/vUDlk8CQsx0bbViE7zqQMFr+KoggKCIe
         tQooM/LQ6TqclhbizE0bDnWXHk0KkS1ITC2+D7beR/5a/uK+obf3uMd2tzsASArss8Ua
         vCadaUAUJ670Z7yxKECxTbm06gGnk+kDzxJ35zLj+AZnycBpDwlQhtmjP30oKqrPLWa8
         I8W79yj0PQZhl7ODLPCxYmRJA+rmKMiVkww5qOl+gbrhmOctr2H0IHF5Dle/KHSiSxTS
         WvYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793897641; x=1794502441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dwfOaeQbEriUr7n1LwUP935/2zWyl9SRrKy8JH5RF/A=;
        b=LcnwD/qSXYpn0hbSwzccdGoMYJIUTbNISXXCIDuTcvY8C294XfJsEQqmr4JoxRK/hB
         lVAV5w0wVtAG62tTNNnDIjP2hrh6hntPgl8iwlWBhMLFLyJcYjG0IETs8LRymy5gB8dR
         6U54dP9i1LlZipIawWbJhDM1CxH/HPF9fzLeULt3DyfLwYNj/1wZ2OdXIiqusGYbWz3y
         TutQ83u4N/FmnQqRpSeqc4Wcd32X9jY5r8eLekfeSF6VcGricDOq3EbIU4H4pdpWTL9Z
         gJlPJQpUq8SdS1xbA7YOQVrB0Wj7MeCAWb/MOAig+mXrKNyyj79EVsMh5BxnIyoo4PdF
         B4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793897641; x=1794502441;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dwfOaeQbEriUr7n1LwUP935/2zWyl9SRrKy8JH5RF/A=;
        b=ACQPx0fy7cnUjwe82SUIJ6LTCpn+akuUnp8gTow++RPiugIDBUd35+wqivWyHMJFxf
         kvDkwQYrT0hwJGI1JvAifngAQkcm980ysxQSlI1mTSWgRi9PRg4pH510ZQlMPCvcZH5l
         LB/O7mwoE8jbXnkDOrqSVsRwMaKeD1ejWKYwIjJVYKJBibIKhw45yJPFPmdUAVWL8W+m
         HZLEVDf7Jfx70bziFtDY49+bnu1ga/zLDSoYcWGEgMz+Y2IEXHGNvJXpCQl8+p4iYmks
         sfHQonVLOqoF2zZpa00e/flxEGW95wHdedLGOoYCe8WXGDd8Cbyt0m6SijcAlWIGl/ck
         skPA==
X-Forwarded-Encrypted: i=1; AKwUvBxFgbYr4+qZaDv70x6eFqnnIuH+2rWy2MbHje+FQf0qhLf4h65BL26SUPQ2ziOIMlGDItIe79oIYfvtnccL@vger.kernel.org
X-Gm-Message-State: APuU4Z/LbmRtmFDRlFtRDREpPNL87Unq1b2hM0LkchYQk2pJAQN+SFRZ
	ohdk2pzUQXONokbFV7389pf4U+02rPhMwMSjRCtWYxCiRWjLEHmuuELU1EvM+HLg+eGserpuNLD
	EJ+00r8KtdkpvsrxZQFIEENJ3Ue+5HGU=
X-Gm-Gg: AYBFou2cIcdwA4fgBJmGZ8hd37guQRs0v2rsFiCS691la6b/3SM9v8qNQDs7wjo3OSP
	lLv17sxaF2QCZRj/9JRhi6SilCMqIPg5NCYjFlVKc103PTrcsWZRgzefQOCX4e5hZfFrkgdV0Wk
	1plo7Wc71jZpZUhZhDZgb5uUJPnkRjYWhEEAyzfxKNTxmWu9xshphyAPt/7ppOCO5Q8L0H+AXoU
	6LIUL/U2NlOK3WDlOrejwYSkYHCn1Gjz40gERlNiFSIoAo23yOX7w7L3GNZ3VWir8r+t6YPzkj0
	lYUNMPlUxqHnhmxgZNl4NwbMDKExrmCu/4ayFtBagZZ+MED71s/6TH4pCftkdj9/imIdyn8vxH8
	dftX1/196WLOMOtxryFLx/ECW+Yx8NnsAUtplp4LQ+r75LujiDjV1W+3PeI4q++1w+vKl8DGqTC
	/puxw0iMNvfo4ZJnw=
X-Received: by 2002:a17:907:97cb:b0:c46:87f9:f5f7 with SMTP id
 a640c23a62f3a-c4d35485cb6mr2630366b.17.1793897640926; Thu, 05 Nov 2026
 08:54:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023162906.2938-1-drifabdelmalekmohamedsaid@gmail.com> <auxn5snXPQJLR2z1@gmail.com>
In-Reply-To: <auxn5snXPQJLR2z1@gmail.com>
From: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Date: Thu, 5 Nov 2026 17:53:50 +0100
X-Gm-Features: AclHuK-GQn91OSLi4xUUXopS5ifvpI7dp4tGIfCpqEWHuzoNZVyw3qBo47g0l0Y
Message-ID: <CA+xk8n9D==iy6pPVr+t=uCYfYzGv=cEfvsiLMvmErbQ3gjST-w@mail.gmail.com>
Subject: Re: [PATCH v2] configfs: fix slab-UAF Write in config_item_put
To: Breno Leitao <leitao@debian.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot+63336d70e1af377d7388@syzkaller.appspotmail.com, 
	Ran Hongyun <ranhongyun1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Breno,
Thank you for your feedback, i sent v3 for the patch,
> +     config_item_put(parent_item);
> +     parent_item =3D NULL;

>Why do you need to set it to NULL here?
Your were right here, configfs_get_config_item returns null upon
failure so that was redundant.

Here is link for the patch:
https://lore.kernel.org/all/20261105165055.362-1-drifabdelmalekmohamedsaid@=
gmail.com/

Cordially,

On Thu, Nov 5, 2026 at 12:29=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Fri, Oct 23, 2026 at 05:29:06PM +0100, Drif Abdelmalek Mohamed Said wr=
ote:
> > syzbot reported:
>
> Please drop this full log, given we have a link to the syzbot report.
>
> > This is a race between a thread creating a symlink and another one
> > doing rmdir on a parent (or ancestor) directory of symlink creation dir=
.
> >
> > configfs_symlink() takes a reference on parent_item, the directory the
> > link is created in, and then drops the directory inode lock around
> > get_target(). While the lock is dropped, a concurrent rmdir can remove
> > the group that parent_item belongs to.
> >
> > If parent_item is a default group embedded in a larger object, such as
> > nvmet_port.subsys_group, the reference on the embedded item does not
> > keep the containing object alive. rmdir frees the object, and the final
> > config_item_put(parent_item) in configfs_symlink() then decrements a
> > kref inside freed memory.
> >
> > Fix this by not holding parent_item across the unlocked window. Drop
> > the reference before inode_unlock() and look it up again from
> > dentry->d_parent after inode_lock(). configfs_get_config_item() returns
> > NULL if the parent dentry was unhashed in the meantime, in which case
> > release the target references and return -ENOENT.
> >
> > Re-looking up parent_item is not sufficient on its own.
> > configfs_get_config_item() only fails if the parent dentry has been
> > unhashed, and the rmdir path in another thread may skip that: if
> > simple_rmdir() failed, the earlier d_drop() was skipped, so the dentry
> > can stay hashed even though the directory has already been detached.
> >
> > Such a directory was created as a default group (CONFIGFS_USET_DIR), so
> > configfs_rmdir() takes the CONFIGFS_USET_DIR branch and calls
> > configfs_detach_group(). detach_groups() then marks each child inode
> > S_DEAD (d_inode(child)->i_flags |=3D S_DEAD). Check IS_DEADDIR(dir)
> > after retaking the inode lock and before taking a reference on the
> > parent, and return -ENOENT. This also rejects a detached directory
> > whose dentry is still hashed.
>
> This is LLM-heavy and hard to follow, would you be able to make it a bit
> more human?
>
> > ---
> > v2: Added check for dead dir, this would be helpful when configfs_remov=
e_dir skips
> > unhashing the dentry.
> > v1: https://lore.kernel.org/all/20261017123748.4430-1-drifabdelmalekmoh=
amedsaid@gmail.com/T/
> >  fs/configfs/symlink.c | 18 +++++++++++++++++-
> >  1 file changed, 17 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> > index 89178f5d371a..7d746a10c369 100644
> > --- a/fs/configfs/symlink.c
> > +++ b/fs/configfs/symlink.c
> > @@ -196,11 +196,26 @@ int configfs_symlink(const struct mnt_idmap *idma=
p, struct inode *dir,
> >        *
> >        *  AV, a thoroughly annoyed bastard.
> >        */
> > +
> > +     /* Put the reference back, retake and check after relocking*/
>
> Nit space before */
>
> > +     config_item_put(parent_item);
> > +     parent_item =3D NULL;
>
> Why do you need to set it to NULL here?
>
> >       inode_unlock(dir);
> >       ret =3D get_target(symname, &target_item, &target_sd, dentry->d_s=
b);
> >       inode_lock(dir);
> >       if (ret)
> > -             goto out_put;
> > +             goto out_put; /* config_item_put on NULL, no problem */
>
> This comment is not necessary.
>
> Thanks for the patch,
> --breno
