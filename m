Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE09364058
	for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787939810; cv=pass; b=Ce9+xg0JdKR626Wp5XiutN8ijSeEcu/eyTNBou8qcFCh8AtPtxtLbelZEwP88EOFQQj2ExuApIWiOc6Z/pKanXmnrR2GuqjmJ1aIZz0MY6Mw8jfjKXhFMsAa1miAK67tQa7xO+oetXJYZXjZ7Ye8U3ueCGfj5ZcLpUHp3FoMFQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787939810; c=relaxed/simple;
	bh=ICqqDvyGEpfs6xaL7LEARpobE8FjqdmW+8cG+j4iELk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/+nT6evTlMWFivNTgtzhnBnw1KPloQ4M6lWmtCwQ4ee5nhyR3b80OqiiFyOmrTJ+NcNYh+JgDIRQsLTdODfPLXDWV1kddJiJa4CM6jTHl6gAEAcWGT+AQNHqC2Xg52cZ5ruOSV1XLbuQaml3s+qBbiHNSeW9xwU2FiQoMgmjG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHz3U2no; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHz3U2no"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a5e329c0f2so1612035a12.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Aug 2026 10:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787939807; cv=none;
        d=google.com; s=arc-20260327;
        b=bUG5ThOw8z5n+sRqXQ7DQdDQRoIMgqF6Gfouvq4FqIuCv7nduivq43hflGYmywKl4X
         fJT+GGog1aGLLSjpiLblTlS7kfGS8cM7TwCO+rFlWMbud4GkBsIBNfu4j4W0kkK9p1J/
         UdyHR18FwWghXXmMmtHRHpRsognn3C995VwasB06UXasAH2UkTnJWCpXQpPPAFIAPWMr
         h5sVvylAMrFaGjqBdghuyOvtYVvMwTzFjN4yZQU5JnvXWiqoUPUkGMndkRLXClsIJaIe
         MAJb+ttTM/mpuGah8f1abYqpSiwpAkrnXezpLDQN2BWIDCPwIi/qko0fSNAE8FOx9P2l
         osBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C4g2HsKIGS/dtUBl5Hgz5rVIhORADLJiU0SI1ip2ThE=;
        fh=L/WRj/HBE3+p6UiQ+uQEDiXXydFDUkZkZPM1njwsvLw=;
        b=Ba5SKS/9vkpGXNfcBm/LZ3rv2Rmcw3x2/a2gw2ouACFqvbShPITniVCaZabcb3oSyw
         xPuCCRCQVW6qD7tTVrxSzV/TVfwI+NtLQ7ecKsTP+9tEfazVjjlolIQFkplS/DsUcsCQ
         Eumf4bPqnxBG6ER//HBSpuNq18eO8rFaC4LcH9uVm3XYbP12F3SDp4JcpcWoInYS33UQ
         hga4vZi87p5mipOjy3aS/tag1htVYt9WI77HqvfM/saWYqq9SK23io5W5yW8s5BW5r1G
         qHvVRrwE7fjYayN3+2BX6inYAIdNCXGXwckXj6TzJaWKS0HVujcSfuealtqN2YRCM7zw
         xgiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787939807; x=1788544607; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C4g2HsKIGS/dtUBl5Hgz5rVIhORADLJiU0SI1ip2ThE=;
        b=bHz3U2nonr828MKfxEBox61A/jPclQKNTv39wM20EaHLZflzakCpbJH2U19aoz7X/2
         nQold+tF1Du9Zul1zxMftXKYdaiJPKfqXTb9EK9ek82yrQmWq5PbJ8ti4CEduz9vRK3A
         GGvDliW6N04evLo761uHXW/ETasbao+FS3hkNG/aATuywVEW7HANLgoOyV6GDAOKeaIq
         m+pm6DpGnsP0CMz/ktmedjWqCVDetLSy5wIVbN5lM/OxQAkwAtfrXPkhYX59erGkSb/u
         FAuPE/g0Zto+rSc+oFwM/QBiMmP6DCONQGfBHpJH/CBDNromTPo3m+vkV3YfSB7bsizC
         smqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787939807; x=1788544607;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C4g2HsKIGS/dtUBl5Hgz5rVIhORADLJiU0SI1ip2ThE=;
        b=D6EHn/hneZBg9jMKrhy5V4C2HtpLrM7Ck9ZCHVpiTAC+T1TSE6SqM3umHpV7LSTpqn
         BBaWh8iiOlcTetKytOpQPuEqeZRXIttvAz5DAYmXXv9JXeKdFy7280nFRrzDDcG2B9qr
         V/V4oFellUhOlLf2DlJ65ekPZxyKKkDQnXV6+EYEyLtChq6MOp8MOwrHHv/TphZvKb2R
         KFJmQi2uSYCp7B1PhVnnpQU3FAM7gwILpOS+wUiZibOHqC5SBl0dItxoPIgU5l0j6cwH
         1iL8RmFHD7c4LPjXPUrSWafwMAiq2PXrg++KKyObsWL4lREsKKZhsqsBx9lJgRHSckW/
         cXww==
X-Forwarded-Encrypted: i=1; AHgh+RrEbByQO7WuZadICK+/R4YRXJcOQ0iZcC9A7GdEHdImG8dqfJU0765A7eyA4K90CCOBRFZU7qCa5mJP0MQ4@vger.kernel.org
X-Gm-Message-State: AFuF++k1IAlEp+nOTJp9WznLnlPyyt06pYEfM1cS5zOKErThuzX77vr+
	OFQhb7u8MGu4hdthrwg+XP7eRra6xF6VypkuiIj1nakycZNmqhd7S56eKxJEBhm9e4oUMIx6WGz
	YOjeHUUe/pP4Nodk3gWYFgukZ2FTdDAw=
X-Gm-Gg: AR+sD10yhABOzS2y58pTPzcTt8sigUvA+AdWGt7ZmWQlQqUNZkgj8Ir5cqHsRObNCqX
	SuoadzXlmpf1kT3teqGfKbtQR33InOI5gHFWrYD2BfHUvCDXgQ3mImPdAVXdSXCykds46ksjKsh
	RdEtG+3ayv7JVHGHd8NTkcN1lMkt9UKGlcCuoaDbusoGDXCU+gAiY8/MHU0HykyNNtXBMBi3pGY
	+X1+OnF6u28PBwj13AhWzWt26pQV3+W/EYdK6OU9dWnX8QM21sWRuUgePk29G0pCggBvB68qymP
	P4OQa0TktU6jiv2srFgxlFBKJ/DRRceOktV62OIEPi32WKYsmpemBgYDgYT+iafyTgLzANp0hjP
	/
X-Received: by 2002:a05:6402:2088:b0:6a5:fbc6:cad1 with SMTP id
 4fb4d7f45d1cf-6a60d334d1cmr5875728a12.7.1787939806479; Fri, 28 Aug 2026
 10:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803125138.1937674-1-mjguzik@gmail.com>
In-Reply-To: <20260803125138.1937674-1-mjguzik@gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 28 Aug 2026 19:56:33 +0200
X-Gm-Features: AcwNN1Xc89jOY26XnM7VSbYzHf8zhXSzLDxdDgRseL6RwITE5J33Vd4MONdnAVw
Message-ID: <CAGudoHH7RrKW27Gmrvb-njqAKLB_v3NQB4Jgd9Siyf3JhkmQ_Q@mail.gmail.com>
Subject: Re: [PATCH v5] fs: avoid spurious dentry ref/unref cycle on open
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

any flames on this? it is ridiculous the problem remains imo

On Mon, Aug 3, 2026 at 2:51=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> Opening a file grabs a reference on the terminal dentry in
> __legitimize_path(), then another one in do_dentry_open() and finally
> drops the initial reference in terminate_walk().
>
> That's 2 modifications which don't need to be there -- do_dentry_open()
> can consume the already held reference instead.
>
> When benchmarking on a 20-core vm using will-it-scale to open the same
> file read-only, the results are (ops/s):
> before: 4043375
> after:  5629378 (+39%)
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>
> The spurious ref cycle remains an issue and it is trivially avoidable,
> for the most common case anyway.
>
> Al Viro had a more involved patchset which got stalled, see:
> https://lore.kernel.org/linux-fsdevel/20240822003359.GO504335@ZenIV/
>
> I already pointed this out over a year ago when sending v3.
>
> Given lack of traffic on the more involved variant, the nice win from my
> simple patch and its overall triviality, I think it should go in. Worst
> case, if the more involved work ever gets off the ground it can be
> trivially reverted later.
>
> bench is:
> $ cat tests/openro3.c
>
> #include <stdlib.h>
> #include <unistd.h>
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <assert.h>
>
> static char tmpfile[] =3D "/tmp/willitscale.XXXXXX";
>
> char *testcase_description =3D "Same file open/close read-only";
>
> void testcase_prepare(unsigned long nr_tasks)
> {
>         int fd =3D mkstemp(tmpfile);
>
>         assert(fd >=3D 0);
>         close(fd);
> }
>
> void testcase(unsigned long long *iterations, unsigned long nr)
> {
>         while (1) {
>                 int fd =3D open(tmpfile, O_RDONLY);
>                 assert(fd >=3D 0);
>                 close(fd);
>
>                 (*iterations)++;
>         }
> }
>
> void testcase_cleanup(void)
> {
>         unlink(tmpfile);
> }
>
> v5:
> - the extra ref is of course needed, i blame the heatwave for thinking
>   it is not this time around
>
> v4:
> - rebase
> - don't grab the extra ref on mnt for truncate
> - bench opening things r/o. note perf improved from last year thanks to
>   other changes
>
>
>  fs/internal.h |  1 +
>  fs/namei.c    | 15 ++++++++++++---
>  fs/open.c     | 27 ++++++++++++++++++++++++++-
>  3 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/fs/internal.h b/fs/internal.h
> index c658c8a5ebd5..9632239036ac 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -205,6 +205,7 @@ int do_fchownat(int dfd, const char __user *filename,=
 uid_t user, gid_t group,
>                 int flag);
>  int chown_common(const struct path *path, uid_t user, gid_t group);
>  extern int vfs_open(const struct path *, struct file *);
> +int vfs_open_consume(struct path *, struct file *);
>
>  /*
>   * inode.c
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f9bf103ba12..f71481b9bf8f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4789,6 +4789,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>  static int do_open(struct nameidata *nd,
>                    struct file *file, const struct open_flags *op)
>  {
> +       struct vfsmount *mnt;
>         struct mnt_idmap *idmap;
>         int open_flag =3D op->open_flag;
>         bool do_truncate;
> @@ -4830,11 +4831,17 @@ static int do_open(struct nameidata *nd,
>                 error =3D mnt_want_write(nd->path.mnt);
>                 if (error)
>                         return error;
> +               /*
> +                * A dedicated reference is needed because after the call=
 to
> +                * vfs_open_consume() we no longer own the reference in n=
d->path.mnt
> +                * while we need to undo write acess below.
> +                */
> +               mnt =3D mntget(nd->path.mnt);
>                 do_truncate =3D true;
>         }
>         error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
>         if (!error && !(file->f_mode & FMODE_OPENED))
> -               error =3D vfs_open(&nd->path, file);
> +               error =3D vfs_open_consume(&nd->path, file);
>         if (!error)
>                 error =3D security_file_post_open(file, op->acc_mode);
>         if (!error && do_truncate)
> @@ -4843,8 +4850,10 @@ static int do_open(struct nameidata *nd,
>                 WARN_ON(1);
>                 error =3D -EINVAL;
>         }
> -       if (do_truncate)
> -               mnt_drop_write(nd->path.mnt);
> +       if (do_truncate) {
> +               mnt_drop_write(mnt);
> +               mntput(mnt);
> +       }
>         return error;
>  }
>
> diff --git a/fs/open.c b/fs/open.c
> index 6b1c14e684a9..2a7697cee00b 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -931,6 +931,11 @@ static inline int file_get_write_access(struct file =
*f)
>         return error;
>  }
>
> +/*
> + * Populate struct file
> + *
> + * NOTE: it assumes f_path is populated and consumes the caller's refere=
nce.
> + */
>  static int do_dentry_open(struct file *f,
>                           int (*open)(struct inode *, struct file *))
>  {
> @@ -938,7 +943,6 @@ static int do_dentry_open(struct file *f,
>         struct inode *inode =3D f->f_path.dentry->d_inode;
>         int error;
>
> -       path_get(&f->f_path);
>         f->f_inode =3D inode;
>         f->f_mapping =3D inode->i_mapping;
>         f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> @@ -1055,6 +1059,7 @@ int finish_open(struct file *file, struct dentry *d=
entry,
>         BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's op=
ened */
>
>         file->__f_path.dentry =3D dentry;
> +       path_get(&file->f_path);
>         return do_dentry_open(file, open);
>  }
>  EXPORT_SYMBOL(finish_open);
> @@ -1098,6 +1103,7 @@ int vfs_open(const struct path *path, struct file *=
file)
>         int ret;
>
>         file->__f_path =3D *path;
> +       path_get(&file->f_path);
>         ret =3D do_dentry_open(file, NULL);
>         if (!ret) {
>                 /*
> @@ -1110,6 +1116,25 @@ int vfs_open(const struct path *path, struct file =
*file)
>         return ret;
>  }
>
> +/**
> + * vfs_open_consume - open the file at the given path and consume the re=
ference
> + * @path: path to open
> + * @file: newly allocated file with f_flag initialized
> + */
> +int vfs_open_consume(struct path *path, struct file *file)
> +{
> +       int ret;
> +
> +       file->__f_path =3D *path;
> +       path->mnt =3D NULL;
> +       path->dentry =3D NULL;
> +       ret =3D do_dentry_open(file, NULL);
> +       if (!ret) {
> +               fsnotify_open(file);
> +       }
> +       return ret;
> +}
> +
>  struct file *dentry_open(const struct path *path, int flags,
>                          const struct cred *cred)
>  {
> --
> 2.53.0
>
