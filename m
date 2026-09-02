Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14CD344D88
	for <linux-fsdevel@vger.kernel.org>; Wed,  2 Sep 2026 14:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788357706; cv=pass; b=VIDKQ7/r9/gtPvh1z3sO+aYvtEwm82xJcLTW9TySZkDu7W/8qzxSKJmkyXCekvcazza+fqz59VAXfB2H/dsRtpTHxZWDk6AFlrThiXbzVlYiQKZB7sDi6SoOmmvXMYO82nsN7heCnIIzirhVz08dYeA4jhACfiW0xydDDnpEjD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788357706; c=relaxed/simple;
	bh=i4YFRSjr1uq5B1VG9ijzvPlb+5HtsPFiXflnG2nayIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NIjJhbxJtZteihEpYXUD76Wl6yqr0GWO2TbfmITZnNU8YPGAM83DkRB3QqUQ1UWHKJaNf6lM7sF7aIsqoqHjn8FesHw+uT2gn/aAE25NYBQYB9wUKFE5ifLTBR4iPYCqn4diybxqswj3NcfGlky1GkT5VaVlChKPTltzYawINRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WT7dU5Zk; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WT7dU5Zk"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so1596358a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Sep 2026 07:01:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788357702; cv=none;
        d=google.com; s=arc-20260327;
        b=pMcX/HthBJMPVOb2bBpZY+yDjPkShLWP3uJ2Eo45f1+cf+e22WDmm2EzGdSKi7Tykz
         vA1QP8FMQQm0Q+VuCjzG5m0GDsmGGd4qQPtSTkN7GK4wZr3Rus6PQqpyNYUtCqSbZHyn
         wIt8ceu31ji7Bx2AbFw886PY+Y336GWxkh6QeUwaFWN+wwG6giixL1aQfyy1w/6DDN9y
         MSs6cT0V0sjJCvBBgBACbq9TIuiFwTjPsdppKNhkcRaKwrU6X65WuAgJRANZuNYEsb+n
         7GeHEoWaN3UTTcz/Vcf7mOFY5YoT4ml5Kdqb334B+IfoFX5vlZg92F1S1bvwuaAB10GK
         wUbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=12GYgwyQ7Bsh7S9Ja4UI8pLqfCj3kMfeIBkHdXA17Vg=;
        fh=/i70+EnKTO5/K2Q1B722k7zvyxH2HuJTedZrJj1InUo=;
        b=ZS/xR/OyHlwTOFTgMkvte5fyybNIZ2398HtpA/6m1hmpdY02bXr4HLbumoGWX7sQxZ
         CG1RGayu7KQy0AYrRnIiD9OC73DBIBymJCJ5hllGHjo4qfKEc1juq5wgmTvRNJFJTLfX
         WMF2JNeJpzOrbs6EZUFp7m7zkJlE7FvlOEwJODTL/HqCkpWRRCjZkL6RSf+/qZNk+CYD
         UAecc4GDUJ0YykZA3iQVXfJjXPvOoS1GfcPPGFI/lRunI624j85Vqs2aL4/lAR6OERT2
         hbDZAtbVBNwNBOnZSguo/168of7Km4MJU20hEiYjnupZaWHcdLWdFTMpEQHHGFsMYQNA
         eG1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788357702; x=1788962502; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=12GYgwyQ7Bsh7S9Ja4UI8pLqfCj3kMfeIBkHdXA17Vg=;
        b=WT7dU5ZkGf1hVRPXAzkSZH+idFuNubaRBmS31MFPv23yJI/gDXFnRS+EN4TAYTmKmP
         VZ2dgVyNn/7rLkDQp4pT/Xcn9fUJrV8+CXEsP4ZTWta9WCajVU74L6eGmqfUMpwrrd80
         AuNCDEnFa+Zbs9gET/sJuGMGHauhGgRBbo/2/rgFIXUKl9uQuARUA6iEhEWnfkqLMHcV
         EWBrGxzkCqnv/xriG4ouWN6ImGN3vr1sjXI6ORPz0oHLb5/EIBB7KUcVB/C2IRzeVAFp
         Wn4uWtOx4AbKv7cH7bv9qWOGh67S4S/YXLXpjIzuNSL1hNwl1r5kttvvnGFiwSUAq7gM
         R/5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788357702; x=1788962502;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=12GYgwyQ7Bsh7S9Ja4UI8pLqfCj3kMfeIBkHdXA17Vg=;
        b=MB8Ntk99pf/+Odj99tsa3/5mXP+TScO4NHmIdk2nW2D8FmayAMKgczzkiWAT7PetGH
         4ZnaXSVHLcMrbQaLUMq3wYp0P3AREiKA4pT3fNYhHJ8OXWuBrnKdePb04BiXFsZgar0d
         JrH/gI560w5Jb1j21FRWj+nJWJT6yP3dSEX+HR8/le/b1iXqZAYYdTAVe9qib3/dyFTo
         RmnYRlJ7aE0k8A4UgozGKVg3eSGUkxwDgXD7C1jRgORkM7+I40WwOjHBr9CIsynfyzLc
         4txslrqIdDRkThE0Rq1NocYbOotyd01SXCdq1mm7rvVS1RgqvijntShQMvjWpjI4Mo7c
         9INA==
X-Forwarded-Encrypted: i=1; AKwUvBwqyTu6G/HaJ0t3namgMsyqiwco9S7THPQaxfp0YFO5FQ/qkSJMkuMixI15IOM0oFJd9Xr4i1TmyHgFabvY@vger.kernel.org
X-Gm-Message-State: AFuF++lLf7XTPqNYb9b5Xoegg1j5iUp/1dwmAG6QIgXQmNGtHVqnoz5j
	/WRKiEHTw+vNkaIt3gsaKBrYzjiO+XQ6UnwHYm+b1BVDun7lxpj1tV2SRlv3e7BaDpM2By6ANu/
	aNiKPGxgU6r+mZgpyfPzk08E6ePiRUUw=
X-Gm-Gg: AYBFou3ZrPm76O8ZUHLapKumDFfeDV77B+0r3ZoOt6SrVAwiPw5dbkBB75WE8RLNzJW
	KCWnMTdZh4VqNeGni+maDVVY7iXYYaPCwHNzWGGHfXw9ORJetOTavyupQWEbjGry1V/Wh6ndoDj
	J16PTH2BQrN0U4clKFrTjLRvXCWCmvH8nNvuB0i8gXmVm8ApANpQ4aMptzsXrltoaJHTRs+dckI
	/RA9UUw6sr3osV1jb5XNnBCsntOl/yab0/SpWfUQIn24/yvoDvhxYEwA1QORjfa4S8XLRKbrJN6
	PYjds8STV8rMjZJWdH5Zf27lfrX+OuvM0k/Jw6OQhx74KHT82lsOI30Mxd50Am/wHAQPwjJDAPy
	R
X-Received: by 2002:a05:6402:2b96:b0:6a6:32f5:ff41 with SMTP id
 4fb4d7f45d1cf-6a682af6339mr3326940a12.21.1788357700968; Wed, 02 Sep 2026
 07:01:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803125138.1937674-1-mjguzik@gmail.com> <apSkPymcTBsKOjCV@lt-jori.localdomain>
In-Reply-To: <apSkPymcTBsKOjCV@lt-jori.localdomain>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 2 Sep 2026 16:01:28 +0200
X-Gm-Features: AcwNN1VSsYU-vsvWa7shzQJbqk_ZroS3jGAjSHb54Knwby4SOB8Vpa8jQJn0APE
Message-ID: <CAGudoHHw3ptuOOfUd5ohTGO+Mm2zS6vW5y7KF5_BjZMuMT3YHQ@mail.gmail.com>
Subject: Re: [PATCH v5] fs: avoid spurious dentry ref/unref cycle on open
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 31, 2026 at 12:05=E2=80=AFAM Jori Koolstra <jkoolstra@xs4all.nl=
> wrote:
>
> On Mon, Aug 03, 2026 at 02:51:38PM +0200, Mateusz Guzik wrote:
> > Opening a file grabs a reference on the terminal dentry in
> > __legitimize_path(), then another one in do_dentry_open() and finally
> > drops the initial reference in terminate_walk().
> >
> > That's 2 modifications which don't need to be there -- do_dentry_open()
> > can consume the already held reference instead.
> >
> > When benchmarking on a 20-core vm using will-it-scale to open the same
> > file read-only, the results are (ops/s):
> > before:       4043375
> > after:        5629378 (+39%)
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
>
> So, the legitimize path stuff grabs a ref to the nd path which is
> balanced at terminate_walk(), and you're saying that in the regular open
> path (not O_TMPFILE or O_PATH), since vfs_open() also grabs a ref, why
> not reuse that one. Is that what you are saying?
>
> It seems then that this issue also plagues do_o_path():
>
> static int do_o_path(struct nameidata *nd, unsigned flags, struct file *f=
ile)
> {
>         struct path path;
>         int error =3D path_lookupat(nd, flags, &path);
>         if (!error) {
>                 audit_inode(nd->name, path.dentry, 0);
>                 error =3D vfs_open(&path, file);
>                 path_put(&path);                        // Not needed?
>         }
>         return error;
>

Indeed. I did not bother looking for other uses. This can be sorted
out separately if/when my patch lands or I can add it.

>
> > ---
> >
> > The spurious ref cycle remains an issue and it is trivially avoidable,
> > for the most common case anyway.
> >
> > Al Viro had a more involved patchset which got stalled, see:
> > https://lore.kernel.org/linux-fsdevel/20240822003359.GO504335@ZenIV/
> >
> > I already pointed this out over a year ago when sending v3.
> >
> > Given lack of traffic on the more involved variant, the nice win from m=
y
> > simple patch and its overall triviality, I think it should go in. Worst
> > case, if the more involved work ever gets off the ground it can be
> > trivially reverted later.
> >
> > bench is:
> > $ cat tests/openro3.c
> >
> > #include <stdlib.h>
> > #include <unistd.h>
> > #include <sys/types.h>
> > #include <sys/stat.h>
> > #include <fcntl.h>
> > #include <assert.h>
> >
> > static char tmpfile[] =3D "/tmp/willitscale.XXXXXX";
> >
> > char *testcase_description =3D "Same file open/close read-only";
> >
> > void testcase_prepare(unsigned long nr_tasks)
> > {
> >       int fd =3D mkstemp(tmpfile);
> >
> >       assert(fd >=3D 0);
> >       close(fd);
> > }
> >
> > void testcase(unsigned long long *iterations, unsigned long nr)
> > {
> >       while (1) {
> >               int fd =3D open(tmpfile, O_RDONLY);
> >               assert(fd >=3D 0);
> >               close(fd);
> >
> >               (*iterations)++;
> >       }
> > }
> >
> > void testcase_cleanup(void)
> > {
> >       unlink(tmpfile);
> > }
> >
> > v5:
> > - the extra ref is of course needed, i blame the heatwave for thinking
> >   it is not this time around
> >
> > v4:
> > - rebase
> > - don't grab the extra ref on mnt for truncate
> > - bench opening things r/o. note perf improved from last year thanks to
> >   other changes
> >
> >
> >  fs/internal.h |  1 +
> >  fs/namei.c    | 15 ++++++++++++---
> >  fs/open.c     | 27 ++++++++++++++++++++++++++-
> >  3 files changed, 39 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/internal.h b/fs/internal.h
> > index c658c8a5ebd5..9632239036ac 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -205,6 +205,7 @@ int do_fchownat(int dfd, const char __user *filenam=
e, uid_t user, gid_t group,
> >               int flag);
> >  int chown_common(const struct path *path, uid_t user, gid_t group);
> >  extern int vfs_open(const struct path *, struct file *);
> > +int vfs_open_consume(struct path *, struct file *);
> >
> >  /*
> >   * inode.c
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 3f9bf103ba12..f71481b9bf8f 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4789,6 +4789,7 @@ static const char *open_last_lookups(struct namei=
data *nd,
> >  static int do_open(struct nameidata *nd,
> >                  struct file *file, const struct open_flags *op)
> >  {
> > +     struct vfsmount *mnt;
> >       struct mnt_idmap *idmap;
> >       int open_flag =3D op->open_flag;
> >       bool do_truncate;
> > @@ -4830,11 +4831,17 @@ static int do_open(struct nameidata *nd,
> >               error =3D mnt_want_write(nd->path.mnt);
> >               if (error)
> >                       return error;
> > +             /*
> > +              * A dedicated reference is needed because after the call=
 to
> > +              * vfs_open_consume() we no longer own the reference in n=
d->path.mnt
> > +              * while we need to undo write acess below.
> > +              */
> > +             mnt =3D mntget(nd->path.mnt);
>
> Is this needed? The file cannot be closed until after open(2) is done,
> so how can that ref be lost before reaching mnt_drop_write below?
>

do_dentry_open() whacks the ref on failure and I intentionally did not
change that to keep the patch small

> >               do_truncate =3D true;
> >       }
> >       error =3D may_open(idmap, &nd->path, acc_mode, open_flag);
> >       if (!error && !(file->f_mode & FMODE_OPENED))
> > -             error =3D vfs_open(&nd->path, file);
> > +             error =3D vfs_open_consume(&nd->path, file);
> >       if (!error)
> >               error =3D security_file_post_open(file, op->acc_mode);
> >       if (!error && do_truncate)
> > @@ -4843,8 +4850,10 @@ static int do_open(struct nameidata *nd,
> >               WARN_ON(1);
> >               error =3D -EINVAL;
> >       }
> > -     if (do_truncate)
> > -             mnt_drop_write(nd->path.mnt);
> > +     if (do_truncate) {
> > +             mnt_drop_write(mnt);
> > +             mntput(mnt);
> > +     }
> >       return error;
> >  }
> >
> > diff --git a/fs/open.c b/fs/open.c
> > index 6b1c14e684a9..2a7697cee00b 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -931,6 +931,11 @@ static inline int file_get_write_access(struct fil=
e *f)
> >       return error;
> >  }
> >
> > +/*
> > + * Populate struct file
> > + *
> > + * NOTE: it assumes f_path is populated and consumes the caller's refe=
rence.
> > + */
> >  static int do_dentry_open(struct file *f,
> >                         int (*open)(struct inode *, struct file *))
> >  {
> > @@ -938,7 +943,6 @@ static int do_dentry_open(struct file *f,
> >       struct inode *inode =3D f->f_path.dentry->d_inode;
> >       int error;
> >
> > -     path_get(&f->f_path);
> >       f->f_inode =3D inode;
> >       f->f_mapping =3D inode->i_mapping;
> >       f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > @@ -1055,6 +1059,7 @@ int finish_open(struct file *file, struct dentry =
*dentry,
> >       BUG_ON(file->f_mode & FMODE_OPENED); /* once it's opened, it's op=
ened */
> >
> >       file->__f_path.dentry =3D dentry;
> > +     path_get(&file->f_path);
> >       return do_dentry_open(file, open);
> >  }
> >  EXPORT_SYMBOL(finish_open);
> > @@ -1098,6 +1103,7 @@ int vfs_open(const struct path *path, struct file=
 *file)
> >       int ret;
> >
> >       file->__f_path =3D *path;
> > +     path_get(&file->f_path);
> >       ret =3D do_dentry_open(file, NULL);
> >       if (!ret) {
> >               /*
> > @@ -1110,6 +1116,25 @@ int vfs_open(const struct path *path, struct fil=
e *file)
> >       return ret;
> >  }
> >
> > +/**
> > + * vfs_open_consume - open the file at the given path and consume the =
reference
> > + * @path: path to open
> > + * @file: newly allocated file with f_flag initialized
> > + */
> > +int vfs_open_consume(struct path *path, struct file *file)
> > +{
> > +     int ret;
> > +
> > +     file->__f_path =3D *path;
> > +     path->mnt =3D NULL;
> > +     path->dentry =3D NULL;
> > +     ret =3D do_dentry_open(file, NULL);
> > +     if (!ret) {
> > +             fsnotify_open(file);
> > +     }
> > +     return ret;
> > +}
> > +
> >  struct file *dentry_open(const struct path *path, int flags,
> >                        const struct cred *cred)
> >  {
> > --
> > 2.53.0
> >
>
> Thanks,
> Jori.
