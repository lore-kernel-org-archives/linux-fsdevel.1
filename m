Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9121D301468
	for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 23:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774135632; cv=pass; b=EmcSGQwbtIxzCKm/PQkw5Y8eiCiEcegAR5ob5F2oR/Pu/5xSBEsM5xFPAjKvGb5Kx2Jvrj7OsJYjipEhLjBj2z5bB5LaMA8SxyVNbNobLK4rzpvsZa2TmGvy7XI10nh9mYzWRWzjgzJq7S9H7NxC2MGJRrhlr7vQFXZsZ+/GKDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774135632; c=relaxed/simple;
	bh=G8BytNw02W6vsycYkdOnMmOBMqHAcRd1M/AlrJVLpnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ns4VBN1AjsQtd/PDgvB9nMLSnlk1//jCjgJwQIE/fMihsW6ctlcn+gyCFBzFpStwq0qnwoV0WLnnnZjtytbvCY9dnsbf3HWuf/wB4cNW7tpAWdvNk21A7JpiDoJl6tAfEk3b0AaHYfcuLZXbb+qohhDhLFA+cGUHgLyJ6rmb9W0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lhnl9yn7; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lhnl9yn7"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so2583526a12.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Mar 2026 16:27:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774135629; cv=none;
        d=google.com; s=arc-20240605;
        b=YtRUJ3bL/d9EBAFEZMxMs8mCfqGS3B7ohUNjsiaUoF1oUZVd8mWKG3NLxBbe832CuN
         dJ5i+qUezquiAycF5wYUiaXzSDYn5G2dPe15hNKiI5uWhOcpRP/c9hwyWd9NltFdUswc
         iL/MoUS7zABWqww67oyNveox0ea8SXOAsjDK8V2ZWwEug3ikyXmdlr9XBBFdWQdShfmr
         v9OZlkISzbj6KzHbu1VwZiHg1+kKkGuDU2wtNdCYWYhmlRHARfladHcMvraET3v4VxqI
         zH3sqUuk/nq69zZm8Ds8In0WVYohylDVjp+qtYgjyuR+GjIqCC1idKJpUUnZ4K6skgTU
         JMEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B3FrJdxRaBhBSTbUb3RLQ76YVu/ckuzSV9/oUaWJ78A=;
        fh=8tBOTHvypZS8wT1GelDpnkI+caOyzEZDq/6A+KrUTFs=;
        b=aHw55PtPDGdjT8SwtFrsrcOjShPozEp0jCl2dZVGFkFlmTG4ECwh14a03o3+K5Gc7V
         ikARaTacv5dARn/xBf6ym/CemuGZe2aG89qragrI7/8Pix/fK1JtllpC2Bjv/vPYqJYi
         /7/bKaiKjcZlo5LnCBqSvmu4mEsSCqEuqoEgU9Fccf+YwKHNOAuzPYWvM2ngKUM+EVir
         KJCrKzZG0FSjfb5vNOboAJIhkAO/foaReTp2/eZBjEKXFVC5/HBzoGqR7pcCJJcVj1Q0
         WP3ueB4JjbKpUdmReH9awr1nZf5Tbsd6zJx4hpffTkBC+Dq6YYeYwV5pg6mhoWZo7uZG
         W+rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774135629; x=1774740429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B3FrJdxRaBhBSTbUb3RLQ76YVu/ckuzSV9/oUaWJ78A=;
        b=Lhnl9yn7RFiBaB92oY/yQtnVpTNuBjT7dq73zhdZp+KcEVVs735zKFM5hRMI4fSZwP
         /iPIJyeAsVMp4tuD7CDIYr+jsSyxE/0z9wF9NjjYfd7QS7LgDZUAP5WEL2ZCH+vJzNG0
         kHWTwt9z7uPBDTy0QsuP+lp5cz2/d53x7TSkSn5B8IkUZsJSEA0aUg/gTzk1hIjdxQWI
         d7J7+juQ9lUurGx3OalVd9reH/luQa+A6T7PoO2ipIPL2IBNi691UHXMZdwioPNKaLTP
         wWAIDo4FHuEbp2xsCtrK5//xhviV1SXSMgHgsiOJuujDNbqkeELvWL5hNmyy/CTGXPcC
         W2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774135629; x=1774740429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B3FrJdxRaBhBSTbUb3RLQ76YVu/ckuzSV9/oUaWJ78A=;
        b=BmJbY/U0vN2V8NQ6SVbAXoXe8eHjhr4pAdhL3Az71kz1OQJaJzNG1nYnSM59TwKykU
         g6epren4E6D6zWX9b0Tb5knno9alpWSEPKg/q5MUjCd5SnSZ8QFKh/wWgpdYrVtGoUYm
         sQ2fEuTYGEQcYLNT9wgj1J9zChIzgCvmd/s9QeG3GOtTTsVdKx/puzy7oSczjLR0O3kn
         lhii+tHJLJ/tl0/xqidWjoIYldJSZu+1PefNqwJJY5jCPDRRMUsSZcu1gLC6qBC35M+N
         sEyLHehmJiiXltLOHR6+VUrHiMy9YiNBYAmmSUcSGNuyJSuV0oNgZL1Y1iBoTQwIhl/2
         mrig==
X-Forwarded-Encrypted: i=1; AJvYcCUwdJP92RID1usD5wmSFgWZDTWLgDIabdiEjHCb49CVPOmK+gmWzS5gUoSKOXM/n/vA/dOiRTrcszipz9xU@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx6YbzrbVf8GcgQLt/joqJFhs0oUHRRQpmX7uDdQ6ziwGHNPgb
	ZiZenuEfkuAJGIIYnwdUSQeJQe9KhJXeG7iOWGgZeDIpZmFOqMGCc92X123+pm/tPV++fxAkgVX
	MUpOSKpzLAoDkl2MKpxPLF7Doy7qwrwI=
X-Gm-Gg: ATEYQzzXOy2XU2eyHgfD/zReCHj/Zzh4UgFir12c52gprQZ7LLRwhaUsf8lmNt/GaYZ
	z67rNrYhugfqZikP/xcjdAV8gyhoJrMZfn+mJj7flTj5+1c8VOW0mjYi6rOoTgo/I3vqAX+2otB
	2I1p8Rg/ICWKnAsOw1A3O/XUvgWI052aFhaWqHOSh1UuFt++HxcmyWiMtCSX44BJN2ZMBJT6/+0
	FrCYmLyz9ErT7PPF/T+cv6cH+JvBuvPKQj+JXTJal1MrpkUpHNZpuyfWXKjE/wola/lNBazIr1b
	LPcBqVs=
X-Received: by 2002:a05:6402:2695:b0:668:2375:e359 with SMTP id
 4fb4d7f45d1cf-668c99307a7mr5325875a12.21.1774135628799; Sat, 21 Mar 2026
 16:27:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320182341.780295-1-daniele.di.proietto@gmail.com>
 <20260320182341.780295-3-daniele.di.proietto@gmail.com> <ff60b19b-ecd8-44cd-b7d3-f7755fe49934@kernel.dk>
In-Reply-To: <ff60b19b-ecd8-44cd-b7d3-f7755fe49934@kernel.dk>
From: Daniele Di Proietto <daniele.di.proietto@gmail.com>
Date: Sat, 21 Mar 2026 23:26:57 +0000
X-Gm-Features: AaiRm51KiLQ5T1eFtmof4LzJCpvNt5gAu0JZkvsFm88l3tgew6rQn8VgZ79c2-U
Message-ID: <CAExiqTJ5JKOeb-9rKy15i4hQw341EvpSc0aQNt1iMxxurHbZVQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] io_uring: Add IORING_OP_DUP
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Pavel Begunkov <asml.silence@gmail.com>, linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 7:34=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 3/20/26 12:23 PM, Daniele Di Proietto wrote:
> > diff --git a/fs/file.c b/fs/file.c
> > index 384c83ce768d..64d712ef89b5 100644
> > --- a/fs/file.c
> > +++ b/fs/file.c
> > @@ -285,9 +285,8 @@ static int expand_fdtable(struct files_struct *file=
s, unsigned int nr)
> >   * Return <0 error code on error; 0 on success.
> >   * The files->file_lock should be held on entry, and will be held on e=
xit.
> >   */
> > -static int expand_files(struct files_struct *files, unsigned int nr)
> > -     __releases(files->file_lock)
> > -     __acquires(files->file_lock)
> > +int expand_files(struct files_struct *files, unsigned int nr)
> > +     __releases(files->file_lock) __acquires(files->file_lock)
> >  {
> >       struct fdtable *fdt;
> >       int error;
> > @@ -1291,13 +1290,33 @@ bool get_close_on_exec(unsigned int fd)
> >       return res;
> >  }
> >
> > -static int do_dup2(struct files_struct *files,
> > -     struct file *file, unsigned fd, unsigned flags)
> > -__releases(&files->file_lock)
> > +/**
> > + * do_replace_fd_locked() - Installs a file on a specific fd number.
> > + * @files: struct files_struct to install the file on.
> > + * @file: struct file to be installed.
> > + * @fd: number in the files table to replace
> > + * @flags: the O_* flags to apply to the new fd entry
> > + *
> > + * Installs a @file on the specific @fd number on the @files table.
> > + *
> > + * The caller must makes sure that @fd fits inside the @files table, l=
ikely via
> > + * expand_files().
> > + *
> > + * Requires holding @files->file_lock.
> > + *
> > + * This helper handles its own reference counting of the incoming
> > + * struct file.
> > + *
> > + * Returns a preexisting file in @fd, if any, NULL, if none or an erro=
r.
> > + */
> > +struct file *do_replace_fd_locked(struct files_struct *files, struct f=
ile *file,
> > +                               unsigned int fd, unsigned int flags)
> >  {
> >       struct file *tofree;
> >       struct fdtable *fdt;
> >
> > +     lockdep_assert_held(&files->file_lock);
> > +
> >       /*
> >        * dup2() is expected to close the file installed in the target f=
d slot
> >        * (if any). However, userspace hand-picking a fd may be racing a=
gainst
> > @@ -1328,26 +1347,19 @@ __releases(&files->file_lock)
> >       fd =3D array_index_nospec(fd, fdt->max_fds);
> >       tofree =3D rcu_dereference_raw(fdt->fd[fd]);
> >       if (!tofree && fd_is_open(fd, fdt))
> > -             goto Ebusy;
> > +             return ERR_PTR(-EBUSY);
> >       get_file(file);
> >       rcu_assign_pointer(fdt->fd[fd], file);
> >       __set_open_fd(fd, fdt, flags & O_CLOEXEC);
> > -     spin_unlock(&files->file_lock);
> > -
> > -     if (tofree)
> > -             filp_close(tofree, files);
> > -
> > -     return fd;
> >
> > -Ebusy:
> > -     spin_unlock(&files->file_lock);
> > -     return -EBUSY;
> > +     return tofree;
> >  }
> >
> >  int replace_fd(unsigned fd, struct file *file, unsigned flags)
> >  {
> > -     int err;
> >       struct files_struct *files =3D current->files;
> > +     struct file *tofree;
> > +     int err;
> >
> >       if (!file)
> >               return close_fd(fd);
> > @@ -1359,9 +1371,14 @@ int replace_fd(unsigned fd, struct file *file, u=
nsigned flags)
> >       err =3D expand_files(files, fd);
> >       if (unlikely(err < 0))
> >               goto out_unlock;
> > -     err =3D do_dup2(files, file, fd, flags);
> > -     if (err < 0)
> > -             return err;
> > +     tofree =3D do_replace_fd_locked(files, file, fd, flags);
> > +     spin_unlock(&files->file_lock);
> > +
> > +     if (IS_ERR(tofree))
> > +             return PTR_ERR(tofree);
> > +
> > +     if (tofree)
> > +             filp_close(tofree, files);
> >       return 0;
> >
> >  out_unlock:
> > @@ -1422,11 +1439,29 @@ int receive_fd_replace(int new_fd, struct file =
*file, unsigned int o_flags)
> >       return new_fd;
> >  }
> >
> > -static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags=
)
> > +static struct file *do_dup3(struct files_struct *files, unsigned int o=
ldfd,
> > +                         unsigned int newfd, int flags)
> > +     __releases(files->file_lock) __acquires(files->file_lock)
> >  {
> > -     int err =3D -EBADF;
> >       struct file *file;
> > +     int err =3D 0;
> > +
> > +     err =3D expand_files(files, newfd);
> > +     file =3D files_lookup_fd_locked(files, oldfd);
> > +     if (unlikely(!file))
> > +             return ERR_PTR(-EBADF);
> > +     if (err < 0) {
> > +             if (err =3D=3D -EMFILE)
> > +                     err =3D -EBADF;
> > +             return ERR_PTR(err);
> > +     }
> > +     return do_replace_fd_locked(files, file, newfd, flags);
> > +}
> > +
> > +static int ksys_dup3(unsigned int oldfd, unsigned int newfd, int flags=
)
> > +{
> >       struct files_struct *files =3D current->files;
> > +     struct file *to_free;
> >
> >       if ((flags & ~O_CLOEXEC) !=3D 0)
> >               return -EINVAL;
> > @@ -1438,22 +1473,15 @@ static int ksys_dup3(unsigned int oldfd, unsign=
ed int newfd, int flags)
> >               return -EBADF;
> >
> >       spin_lock(&files->file_lock);
> > -     err =3D expand_files(files, newfd);
> > -     file =3D files_lookup_fd_locked(files, oldfd);
> > -     if (unlikely(!file))
> > -             goto Ebadf;
> > -     if (unlikely(err < 0)) {
> > -             if (err =3D=3D -EMFILE)
> > -                     goto Ebadf;
> > -             goto out_unlock;
> > -     }
> > -     return do_dup2(files, file, newfd, flags);
> > -
> > -Ebadf:
> > -     err =3D -EBADF;
> > -out_unlock:
> > +     to_free =3D do_dup3(files, oldfd, newfd, flags);
> >       spin_unlock(&files->file_lock);
> > -     return err;
> > +
> > +     if (IS_ERR(to_free))
> > +             return PTR_ERR(to_free);
> > +     if (to_free)
> > +             filp_close(to_free, files);
> > +
> > +     return newfd;
> >  }
> >
> >  SYSCALL_DEFINE3(dup3, unsigned int, oldfd, unsigned int, newfd, int, f=
lags)
> > diff --git a/fs/internal.h b/fs/internal.h
> > index cbc384a1aa09..c3d1eaf65328 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -197,6 +197,11 @@ extern struct file *do_file_open_root(const struct=
 path *,
> >  extern struct open_how build_open_how(int flags, umode_t mode);
> >  extern int build_open_flags(const struct open_how *how, struct open_fl=
ags *op);
> >  struct file *file_close_fd_locked(struct files_struct *files, unsigned=
 fd);
> > +struct file *do_replace_fd_locked(struct files_struct *files, struct f=
ile *file,
> > +                               unsigned int fd, unsigned int flags)
> > +     __must_hold(files->file_lock);
> > +int expand_files(struct files_struct *files, unsigned int nr)
> > +     __releases(files->file_lock) __acquires(files->file_lock);
> >
> >  int do_ftruncate(struct file *file, loff_t length, int small);
> >  int do_sys_ftruncate(unsigned int fd, loff_t length, int small);
>
> All of the above should be a separate prep patch, not part of the
> io_uring patch adding IORING_OP_DUP.

Done, thanks!

>
> > diff --git a/io_uring/openclose.c b/io_uring/openclose.c
> > index c71242915dad..2658adbfd17a 100644
> > --- a/io_uring/openclose.c
> > +++ b/io_uring/openclose.c
> > @@ -446,3 +454,175 @@ int io_pipe(struct io_kiocb *req, unsigned int is=
sue_flags)
> >               fput(files[1]);
> >       return ret;
> >  }
> > +
> > +void io_dup_cleanup(struct io_kiocb *req)
> > +{
> > +     struct io_dup *id =3D io_kiocb_to_cmd(req, struct io_dup);
> > +
> > +     if (id->rsrc_node)
> > +             io_put_rsrc_node(req->ctx, id->rsrc_node);
> > +}
>
> Probably doesn't hurt to be defensive and clear ->rsrc_node when put.

Done, thanks!

>
> > +int io_dup_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
> > +{
> > +     struct io_dup *id;
> > +
> > +     if (sqe->off || sqe->addr || sqe->len || sqe->buf_index || sqe->a=
ddr3)
> > +             return -EINVAL;
> > +
> > +     id =3D io_kiocb_to_cmd(req, struct io_dup);
> > +     id->flags =3D READ_ONCE(sqe->dup_flags);
> > +     if (id->flags & ~(IORING_DUP_NO_CLOEXEC | IORING_DUP_OLD_FIXED |
> > +                       IORING_DUP_NEW_FIXED))
> > +             return -EINVAL;
>
> Would be cleaner with an IORING_DUP_FLAGS mask above io_dup_prep().

Done, thanks!

>
> > +static struct file *io_dup_get_old_file_fixed(struct io_kiocb *req,
> > +                                           unsigned int issue_flags,
> > +                                           unsigned int file_slot)
> > +{
> > +     struct io_dup *id =3D io_kiocb_to_cmd(req, struct io_dup);
> > +     struct file *file =3D NULL;
> > +
> > +     if (!id->rsrc_node)
> > +             id->rsrc_node =3D
> > +                     io_file_get_fixed_node(req, file_slot, issue_flag=
s);
>
> Just use the full line length, io_uring isn't a stickler on 80 chars and
> it'd read better as:

Done, thanks!

>
>         if (!id->rsrc_node)
>                 id->rsrc_node =3D io_file_get_fixed_node(req, file_slot, =
issue_flags);
>
> Need to check further, but I'm assuming the difference here is for retry
> where the node could already be assigned?

That's right

>
>
> > +static int io_dup_to_fd(struct io_kiocb *req, unsigned int issue_flags=
,
> > +                     bool old_fixed, int old_fd, int new_fd, int o_fla=
gs)
> > +{
> > +     struct file *old_file, *to_replace, *to_close =3D NULL;
> > +     bool non_block =3D issue_flags & IO_URING_F_NONBLOCK;
> > +     struct files_struct *files =3D current->files;
> > +     int ret;
> > +
> > +     if (new_fd >=3D rlimit(RLIMIT_NOFILE))
> > +             return -EBADF;
> > +
> > +     if (old_fixed)
> > +             old_file =3D io_dup_get_old_file_fixed(req, issue_flags, =
old_fd);
> > +
> > +     spin_lock(&files->file_lock);
>
> If you use:
>
>         guard(spinlock)(&files->file_lock);
>
> and move:
>
> > +
> > +     /* Do we need to expand? If so, be safe and punt to async */
> > +     if (new_fd >=3D files_fdtable(files)->max_fds && non_block)
> > +             goto out_again;
> > +     ret =3D expand_files(files, new_fd);
> > +     if (ret < 0)
> > +             goto out_unlock;
> > +
> > +     if (!old_fixed)
> > +             old_file =3D files_lookup_fd_locked(files, old_fd);
> > +
> > +     ret =3D -EBADF;
> > +     if (!old_file)
> > +             goto out_unlock;
> > +
> > +     to_replace =3D files_lookup_fd_locked(files, new_fd);
> > +     if (to_replace) {
> > +             if (io_is_uring_fops(to_replace))
> > +                     goto out_unlock;
> > +
> > +             /* if the file has a flush method, be safe and punt to as=
ync */
> > +             if (to_replace->f_op->flush && non_block)
> > +                     goto out_again;
> > +     }
> > +     to_close =3D do_replace_fd_locked(files, old_file, new_fd, o_flag=
s);
> > +     ret =3D new_fd;
>
> into a helper, all of this somewhat messy goto error_handling stuff can
> go away.

Neat!

I didn't move it into a separate helper, because it has to return three thi=
ngs:
* The completeness of the operation (IOU_COMPLETE or -EAGAIN)
* An eventual error
* The file to close

Using a guard in a block and another small helper I managed to avoid
the gotos, as suggested.

Thanks!

>
> --
> Jens Axboe
