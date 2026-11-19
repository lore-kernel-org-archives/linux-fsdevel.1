Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795113144;
	b=QgYoKoaIVm8xbEFvQCgRrT/fIGpQKSle69w3GQl9x+mIOvBWPcMjwxSMpdlG39TxkvPk
	 08wThu+MaJyHmRbBQgS4G52W00QBL4hxS2friLW1zjN/JoMg4Jc0j0DxBNCPyDXsMNYl+
	 v6kcnuz8xOIW242W9Vlw2Tw54/MgQW4cQbWaB3o3DbsJczUFPAkvpawR+LKD4kLuAW67Q
	 snP/N4OYF4EmZ7Sqe9WQmMtoit3JGvZjwis27tj3kqWR1YUoLSwfhciuXiVlWUKRDPvMz
	 lkHCV3RtQkDHu/WldPzfTqCCnfgtDFKNTKC3jRYv9JGsTTbWys3CesT5E+deFTMc1ig==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795113144;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=do8AhcFcymjyMXuuyLMWkfZBB+M/goVAPJ9PX2rsTSo=;
	b=ZCjtGtTK9+U7Bjl7QAd5Qu3a0iAe6jNQab1izrPmeirMUWikyVl6IIbt33WmWDS2fIib
	 AdCR0R8k89JfMVzUr5glcVo+5Z57+R8yyNcB1MnSY1nnHM4zG2a84WwwDZ+X4VYqsw0oO
	 QDVQIneYLQP8Gbjxin3VNp02zXstZ2eF851mDZLmqdiDPLsGaslORqznEEKnff/P2Z8Qx
	 pzP+xT0cIHEILDgBbtFyJgk8TinMUuszmp5CykDvdZmlACRY6Ut52ZkHPJ+Cyk82Dpo+B
	 0evgzZAMBvtYKfl6btssYZJbDrlk6ZV8+JTBo5WsMGCj45o0xxDcHOI3qD5Mttepqlg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCxV8h+i;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45AF660A260B
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 18:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45AF660A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sCxV8h+i
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b894a5ce3dso53455a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Nov 2026 10:32:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795113140; cv=none;
        d=google.com; s=arc-20260327;
        b=G94LHblNFwkhex30X9pa2fcQJ9gpWmkuVmz4voF1YLxzfqaVdCRJ5RJxiwmt/+SYtA
         HuD8Mgq/ECW/vu1a26e9kiONXM00PVEeqMow5chvbK3ETIaN0fNtxtad2VGhnRUHaQi6
         88Hv12472ziM2WS4cbrFw+rBOP3WxrfCOHvv0SirtVNf9SZAkBgIH/1gnOHmWKqDBNVG
         QUYvDCSWBWtua1vBcMqjV2U/YdG7XDd0Rb2/InfE8xOQDCixteojxTsUQVuros8RxT/d
         2aTtoqvcYTci01UP7yBfczKGLyYzsd8gC+iq8amAusWwc8iR3SrNpDzuFU7IdmLxxBGO
         dEHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=do8AhcFcymjyMXuuyLMWkfZBB+M/goVAPJ9PX2rsTSo=;
        fh=hOaBBAxOlKJ6PTl/KrZd/xY9b/rDwNeinyrgQEfJdzw=;
        b=AZoqMW6W+YQ0wpmm10dZ+J64v2qEKC/0YPjVnakdNpmCHy+PTxcYYxnWPTbWJ3ui1d
         BM8IJ/DJLjxP8XM3/JYtTj8k74ZgS6J2HXCKV8uReF1Urv6wcut4h23guhRC2lvsuODp
         eTZodFmcjeLPK1/YkQ3P3MPZZou16opJKNf+v6DALtStfNZ7ec7jImxMHcd7pgrPQp3G
         cQTBoI5Cw8i+jayEU+E0JSdqfWEa4EH7MBLSXyiMBZJzEK2QaRQ/gsidcdG3ZnULcxRw
         h3z0ALYuMhwEJB2sI9OZ4IlPpDDmC9jd9zF25zix2fSDgTegMBIf8aoHOMpf2fpfGwq5
         COEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795113140; x=1795717940; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=do8AhcFcymjyMXuuyLMWkfZBB+M/goVAPJ9PX2rsTSo=;
        b=sCxV8h+iiQ7lmYe/IieVIpTSEpxzn/NNB5DcDdyRi6meZiwSTxjzcGONImdywY8fIW
         k4QNFycfeIpinPwB/9E3kYllKP1snyHCthyylaQGBUjOUBzdwFU8D3jZH9OoXTmTI+DD
         OVVJ4LYp5poQoCcnX71WaQgN7gPMvU7HIWTS8Vko4mDFoBV6vwNaedECADbdHm/tM7c0
         Xclcgz/HLOPgA8somrbNHhp32UNMLsZD/ggx7F9UliKBLcAveGG6OWq5scsYUVhkkSU8
         qG3Xej2GEVHk2OStkMmJdQYBrzA1aEw5477u4wQDug1J/3QbfQa/e7A0ULn0Ol5IkohZ
         jdFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795113140; x=1795717940;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=do8AhcFcymjyMXuuyLMWkfZBB+M/goVAPJ9PX2rsTSo=;
        b=nq4QLt5hEIZ9J0I8dv1jkKTv5xYnkSwxJvZqk81xY11Wf0nn7YGtb8Qoimwumxnqud
         l9a3YjnYfSVoRrBEZzL3R77JPQ/YDVEppczJO0KDowrsIWl3Si4mMy0QqYZPpiuTdDF1
         +MUdgN+pQk5DEqzKs02AdtLgSeiGByeVl9uBZmBBt2iZLpEf9Z7aOZeC10KjiXOi9iil
         ko4PReT6+PPPl+lrBVbYGpP5xTiCcFe27ZK000MH+9jxDgoHqd4r8/RAzR66lB6zlrBe
         hM+JJyYhphMCSUwhdGkCufbWpZOcKW7F6CZr8VbOoZjTqq8GyE8Sff+gyjsFrnMW9zkj
         56Tw==
X-Forwarded-Encrypted: i=1; AL+hErG+HFScq8IIev8fbrde9mMn4qDAJk+7ptdmlgTjG/2yvRxEJOu4lKEXVxSMi2vURZShlIRnaFH0bW/In0/R@vger.kernel.org
X-Gm-Message-State: APuU4Z+wPB7X9M8sgfYLdylx7HdWPgd3MqdySi9cWEmdBJ51qc+yhl65
	pYiPnTwIXf7km8g0x7+1kAytiM2qTfG0y+YZqEGVfhtZoYWWwtUdBfSFaMNY2C6ehZR4x4pUsGY
	PM6a8QZ1sYZ7z4ttWV726oP+DW3GFx6g=
X-Gm-Gg: AYBFou0AoMYyTbWMx6iC0hl7TjBVuoy7aV2+NZ7yv7oklZOmJAq6NEKPlgBz3xdO2si
	jISxxDBZ5IFRb79Nk8IMMGtvk3a/1nLcSwZ519frV9QFUlRRpNBbUbjIgRRGIwPakH2QllK007e
	Aiqc7pnHYICQhSq2RSN23ViuKYEuf5EwViCYXDyed5Gl7LR9YcZD9y7tLcXCmpHYoiEXHm69VPv
	hl8U13oZSdYKa/nr/sDDF+RtUaLYi7TiXrgiW6ji6tvgHMGTEI5o9M2ZJ7glG2cAS2Uh2xjPrwA
	qQQmTuTKwlqElpEa4+gZBZWEEREWqUKzX5JJb/iEqsbMjf37N1ODyUzZMU7qE0Wpfb5c2yjlkL+
	hslNvEO6Ms6S1pEli/eRJ8WbljqrnKQut9V4g3xQ7K0+P3Hp4ZgCHpED1VFEgCH30/Lh9Yg==
X-Received: by 2002:a05:6402:104f:b0:6b4:641:baed with SMTP id
 4fb4d7f45d1cf-6ba37e9568fmr148084a12.30.1795113139463; Thu, 19 Nov 2026
 10:32:19 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115180343.576773-1-koray.fra@gmail.com> <20261115180343.576773-11-koray.fra@gmail.com>
In-Reply-To: <20261115180343.576773-11-koray.fra@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Nov 2026 19:32:08 +0100
X-Gm-Features: Aa3M54o3FyARyR35RQ4tLjj8adRb1WJj3a2qKLwAAXLtUiEUmkOWywN3Z5RLnkA
Message-ID: <CAOQ4uxg2gpC99ohuvKm-SgPzuffJy1fSvXorbuBnYZ=OFSxT3w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 10/10] cifs: add provenance time (ptime) and map it
 to SMB's CreationTime
To: koraynilay <koray.fra@gmail.com>
Cc: David Sterba <dsterba@suse.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
	Paulo Alcantara <pc@manguebit.org>, Chris Mason <mason@kernel.org>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Jan Kara <jack@suse.cz>, NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Bharath SM <bharathsm@microsoft.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, "Darrick J . Wong" <djwong@kernel.org>, 
	Sean Smith <defendthedisabled@gmail.com>, Andrey Albershteyn <aalbersh@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, exfat@lists.linux.dev, ntfs3@lists.linux.dev, 
	linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-api@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 7:04=E2=80=AFPM koraynilay <koray.fra@gmail.com> wr=
ote:
>
> Implement provenance time (ptime) in cifs, as introduced in a
> previous commit ("vfs: add provenance time (ptime)").
>
> Map it to SMB's CreationTime, making it settable from userspace and
> propagating it to the SMB server via FILE_BASIC_INFO.
>
> Support reading ptime via statx(2) and fileattr_get() from the cached
> CreationTime.
>
> Update cifs_fileattr_set() to check xflags instead of only legacy flags
> and add the cifs_set_file_crtime() helper to wrap the RPC call to the
> SMB server.
>
> Assisted-by: Gemini:3.8-flash-high antigravity-cli-1.5.7
> Signed-off-by: koraynilay <koray.fra@gmail.com>
> ---
>  fs/smb/client/cifsfs.c |   8 +++
>  fs/smb/client/inode.c  |   7 ++-
>  fs/smb/client/ioctl.c  | 109 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 94 insertions(+), 30 deletions(-)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index 8cff7857b450..c2f557e406d3 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -1307,6 +1307,14 @@ int cifs_fileattr_get(struct dentry *dentry, struc=
t file_kattr *fa)
>         if (READ_ONCE(CIFS_I(inode)->cifsAttrs) & ATTR_COMPRESSED)
>                 fa->flags |=3D FS_COMPR_FL;
>
> +       /* Report provenance time (ptime) to userspace */
> +       if (CIFS_I(inode)->createtime) {
> +               fa->fsx_xflags |=3D FS_XFLAG_PTIME;
> +               fa->fsx_xflags_mask |=3D FS_XFLAG_PTIME;
> +               fa->fsx_ptime =3D
> +                     cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->create=
time));
> +       }
> +
>         /*
>          * FS_CASEFOLD_FL is defined by UAPI as a folder attribute,
>          * and userspace tools (e.g., lsattr) display it only on
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 2647785ec1e4..f0b20a72b9c2 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -222,6 +222,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_=
fattr *fattr,
>
>         cifs_i->cifsAttrs =3D fattr->cf_cifsattrs;
>         cifs_i->reparse_tag =3D fattr->cf_cifstag;
> +       cifs_i->createtime =3D fattr->cf_createtime;
>
>         if (fattr->cf_flags & CIFS_FATTR_NEED_REVAL)
>                 cifs_i->time =3D 0;
> @@ -2958,7 +2959,8 @@ int cifs_getattr(const struct mnt_idmap *idmap, con=
st struct path *path,
>          * We need to be sure that all dirty pages are written and the se=
rver
>          * has actual ctime, mtime and file length.
>          */
> -       if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_SIZE | STA=
TX_BLOCKS)) &&
> +       if ((request_mask & (STATX_CTIME | STATX_MTIME | STATX_PTIME
> +                            | STATX_SIZE | STATX_BLOCKS)) &&
>             !CIFS_CACHE_READ(CIFS_I(inode)) &&
>             inode->i_mapping && inode->i_mapping->nrpages !=3D 0) {
>                 rc =3D filemap_fdatawait(inode->i_mapping);
> @@ -2992,6 +2994,9 @@ int cifs_getattr(const struct mnt_idmap *idmap, con=
st struct path *path,
>                 stat->result_mask |=3D STATX_BTIME;
>                 stat->btime =3D
>                       cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->create=
time));
> +               stat->result_mask |=3D STATX_PTIME;
> +               stat->ptime =3D
> +                     cifs_NTtimeToUnix(cpu_to_le64(CIFS_I(inode)->create=
time));
>         }
>
>         stat->attributes_mask |=3D (STATX_ATTR_COMPRESSED | STATX_ATTR_EN=
CRYPTED);
> diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
> index bb8808289a46..19a9556d39b4 100644
> --- a/fs/smb/client/ioctl.c
> +++ b/fs/smb/client/ioctl.c
> @@ -181,6 +181,41 @@ static int cifs_set_compression(unsigned int xid, st=
ruct dentry *dentry,
>                                             compression_state);
>  }
>
> +static int cifs_set_file_crtime(unsigned int xid, struct dentry *dentry,
> +                               struct cifs_tcon *tcon, u64 crtime)
> +{
> +       struct inode *inode =3D d_inode(dentry);
> +       struct TCP_Server_Info *server =3D tcon->ses->server;
> +       FILE_BASIC_INFO info_buf =3D {};
> +       const char *full_path;
> +       void *page;
> +       int rc;
> +
> +       if (!server->ops->set_file_info)
> +               return -EOPNOTSUPP;
> +
> +       info_buf.CreationTime =3D cpu_to_le64(crtime);
> +
> +       page =3D alloc_dentry_path();
> +       full_path =3D build_path_from_dentry(dentry, page);
> +       if (IS_ERR(full_path)) {
> +               rc =3D PTR_ERR(full_path);
> +               goto out;
> +       }
> +
> +       rc =3D server->ops->set_file_info(inode, full_path, &info_buf, xi=
d);
> +       if (rc =3D=3D 0) {
> +               CIFS_I(inode)->createtime =3D crtime;
> +               CIFS_I(inode)->time =3D 0;
> +               inode_set_ctime_current(inode);
> +       }
> +
> +out:
> +       free_dentry_path(page);
> +       return rc;
> +}
> +
> +#define CIFS_SUPPORTED_XFLAGS (FS_XFLAG_PTIME)
>  int cifs_fileattr_set(const struct mnt_idmap *idmap, struct dentry *dent=
ry,
>                       struct file_kattr *fa)
>  {
> @@ -193,49 +228,65 @@ int cifs_fileattr_set(const struct mnt_idmap *idmap=
, struct dentry *dentry,
>         bool enable_compression;
>         struct cifs_tcon *tcon;
>         unsigned int xid;
> -       int rc;
> +       int rc =3D 0;
>
> -       if (!fa->flags_valid)
> +       if (fileattr_has_fsx_mask(fa, CIFS_SUPPORTED_XFLAGS))
>                 return -EOPNOTSUPP;

What is this supposed to check that is not already checked
explicitly with fsx_xflags_mask below?

>
> -       /*
> -        * chattr writes back all flags returned by fileattr_get(). Accep=
t
> -        * FS_CASEFOLD_FL only when it reflects the share's casefold stat=
e.
> -        */
> -       if (fa->flags & FS_CASEFOLD_FL) {
> -               rc =3D cifs_fileattr_get(dentry, &current_fa);
> -               if (rc)
> -                       return rc;
> -               if (current_fa.flags & FS_CASEFOLD_FL)
> -                       allowed |=3D FS_CASEFOLD_FL;
> -       }
> -       if (fa->flags & ~allowed)
> +       if (fa->fsx_xflags_mask & ~CIFS_SUPPORTED_XFLAGS)
>                 return -EOPNOTSUPP;
>
> -       enable_compression =3D fa->flags & FS_COMPR_FL;
> -       compression_state =3D enable_compression ? COMPRESSION_FORMAT_DEF=
AULT :
> -                                                COMPRESSION_FORMAT_NONE;
> +       if (fa->flags_valid) {
> +               /*
> +                * chattr writes back all flags returned by fileattr_get(=
). Accept
> +                * FS_CASEFOLD_FL only when it reflects the share's casef=
old state.
> +                */
> +               if (fa->flags & FS_CASEFOLD_FL) {
> +                       rc =3D cifs_fileattr_get(dentry, &current_fa);
> +                       if (rc)
> +                               return rc;
> +                       if (current_fa.flags & FS_CASEFOLD_FL)
> +                               allowed |=3D FS_CASEFOLD_FL;
> +               }
> +               if (fa->flags & ~allowed)
> +                       return -EOPNOTSUPP;

This whole mess could be sorted out by switching the cifs
implementation to the new API and implementing a generic vfs
helper which does something like the above code to handle the
old ioctls.

FS_XFLAG_CASEFOLD would then be removed from
FS_XFLAG_RDONLY_MASK and set explicitly in xflags_ro_mask
by fs which don't allow to set if (e.g. nfs) and added to
FS_COMMON_FL/FS_XFLAG_COMMON

cifs would advertise FS_XFLAG_CASEFOLD in its ro_mask
and then the generic helper would mask it and the new syscall
will not allow it.

> +       }
>
>         tlink =3D cifs_sb_tlink(cifs_sb);
>         if (IS_ERR(tlink))
>                 return PTR_ERR(tlink);
>         tcon =3D tlink_tcon(tlink);
> -
>         xid =3D get_xid();
> -       rc =3D cifs_set_compression(xid, dentry, tcon, NULL, compression_=
state);
> -       free_xid(xid);
> -       cifs_put_tlink(tlink);
>
> -       if (!rc) {
> -               spin_lock(&inode->i_lock);
> -               if (enable_compression)
> -                       CIFS_I(inode)->cifsAttrs |=3D FILE_ATTRIBUTE_COMP=
RESSED;
> -               else
> -                       CIFS_I(inode)->cifsAttrs &=3D ~FILE_ATTRIBUTE_COM=
PRESSED;
> -               spin_unlock(&inode->i_lock);
> +       /* modern xflags */
> +       if (fa->fsx_valid) {
> +               if (fa->fsx_xflags_mask & FS_XFLAG_PTIME) {
> +                       rc =3D cifs_set_file_crtime(xid, dentry, tcon,
> +                                                 cifs_UnixTimeToNT(fa->f=
sx_ptime));
> +                       if (rc)
> +                               goto out;
> +               }
> +       } else if (fa->flags_valid) { /* legacy flags */
> +               enable_compression =3D fa->flags & FS_COMPR_FL;
> +               compression_state =3D enable_compression ? COMPRESSION_FO=
RMAT_DEFAULT :
> +                                                        COMPRESSION_FORM=
AT_NONE;
> +
> +               rc =3D cifs_set_compression(xid, dentry, tcon, NULL, comp=
ression_state);
> +
> +               if (!rc) {
> +                       spin_lock(&inode->i_lock);
> +                       if (enable_compression)
> +                               CIFS_I(inode)->cifsAttrs |=3D FILE_ATTRIB=
UTE_COMPRESSED;
> +                       else
> +                               CIFS_I(inode)->cifsAttrs &=3D ~FILE_ATTRI=
BUTE_COMPRESSED;
> +                       spin_unlock(&inode->i_lock);
> +               }
> +               cifs_dbg(FYI, "set compress flag rc %d\n", rc);

I think that the roadmap should be to slowly define all the old FS_*_FL
flags as FS_XFLAGS_* and let the generic helpers deal with the conversion.

No need to do that now, as part of this patch set which is complicated
enough, just need to see the road ahead of us that we have a way
forward out of this messy flags_valid/fsx_valid inside filesystem
implementations.

My understanding is that Miklos introduced those hints to reduce the
work needed per filesystem for the initial implementation of the
vfs methods.

But it is not so hard to convert one filesystem at a time in a way that
fa->fsx_valid will have to be true, because, for example, here
all the relevant flags would be supported by the new xflags API.

Thanks,
Amir.
