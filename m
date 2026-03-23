Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C74FE37C90E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 13:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271923; cv=pass; b=fHpznwY26xb0C6tUIjfBv/SdQeQcCuFfbG6qW6wQpNl69XO5rH8htsPdT8DC2tffbkB9aAGyIShzHElaRC6zt6tpUtw4GIJiDvTTwHuEFm/qzaMP6O+aj/aArKhVio+2LWCjG/b8gH8ARshdh65D9pbxZmd9r42oBx2c5I5jAL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271923; c=relaxed/simple;
	bh=7bdy91hL1ZYEEHcEGwZGrniGtxDQRHjnP93e5hnATNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McrknlUjztm+LoTP8zsezT0OkedcOZVeNvu0sDQbrLbE/82gq0UbTmS3fwjgZM6wAkSWJiEoBPkiGw9nInymvWreT7efH342Gjctt6SJghIR0gg31itWWXircSlPkyDOkqkdF84W8RNma0jnFhV6Mk+0qAtAZxQKV2fiw+unFkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=astOx9TF; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="astOx9TF"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-66971ccfcabso199148a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Mar 2026 06:18:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774271920; cv=none;
        d=google.com; s=arc-20240605;
        b=dMDTh8YmSeqoSTAFnq7tEoVEZfdvsXlFZEh2uFqDB9m+uUWvUGw7qRTCdFDFARrHUI
         wEWv1IWxiwsNXg6jdn2k2zOmV7nnB+qifOVnnaJjwYm4sKsnkfIHAx5OfyjjmwDq6519
         /ju3oEspPQYr8whraNiT39nN2Pkvpb+gT4Y6qOPaY3CSyG7tNVDF9zV7A4CJ4wvTGI98
         +kZS4WmaJRtXm3i1mZnh+l8DSHKPvz953G83HU2bAFcfOcmLJLC7Bkfk/zS7KNBemqZI
         3bWPP26hJIfb55Yo4BH7MCsJzyizquXnc/uKVPzNxqRKIny8rYpSDnjdlD9Eyf7EQvrm
         CYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9HAMwL3qwoKn2S7VcNBMq+3HfyX9a7ga1yd+4iK0YxU=;
        fh=VB63w0rQh9ELNCiuh95DllD5AbUzgpG3ZdaY7LVJB8M=;
        b=PquPN8EjQ9j+Nodzc/Hwk8KO/AQsz1/xQ/ONnO2lgozwewZOzkhQVtWTnT+/krH2Rc
         KFLDThrap+/Fb7pz5O+Yfo7q/CPWmU5oF5K+TGVzPIPUuMBhpi7cPq+EgROYjwyIwQ0R
         eeOn5+deujrhUwf3vWBgFNuKVT3dWJsYXUTdg3f3Ox7L2N48ezZFA+N6dde+LTDVlu1P
         a8oUQR31spBYpS4V14GAkCoNswsdb7dGyH4Q6+t7Tz30AhLGmaDW4cjZC60EcJV9Jwk+
         0MbhMtrV27CzYEL0/X68JVYqScBNwZFMnYcmsCbYkwyXpsM5AzO99tYJ2IHjt4wyuRq5
         velQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1774271920; x=1774876720; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9HAMwL3qwoKn2S7VcNBMq+3HfyX9a7ga1yd+4iK0YxU=;
        b=astOx9TFk32XX+SxVcNoeM68tXEJwgTPuMVTMetcNQlavl/zHAt5W6dZypBYJVPtAa
         vlNUtFgs/HzI03MAgb578iTNaYtXEfg3dcD2ktcwYPLWzZTdnCwPCuaxok8TZJHp/dgr
         KkYbgkaZWpZIgDi13qje1DoA16ApbjPguFiRCVFgyzbojHv6JCOxYRGDgdSXgWwj+8KG
         9x2484OTuH98NYh9xC9v3xH4ZIOk6E5JNBehdFOo96N2AFT7nOJi4TiOPVSxFKaFXEjr
         rn4SkB3rPhH8jvcLoPuQUR9xYYOVQcB5VslT7hpghUa7d+X/1uIqw59EWD2kyKJ+8PfC
         yXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774271920; x=1774876720;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9HAMwL3qwoKn2S7VcNBMq+3HfyX9a7ga1yd+4iK0YxU=;
        b=gswf6NBiuv+p24NYodyU8Cwv1XFs81RK5m62yuBlCPmBIU/CKBKrN3lOxlQLa46Jyr
         VMkqqgXegGSg4QNoO6NurmW8C5NuLt2eQRGdDeuQa4Y+hxXWJhBSSY+FXghYQVcQ5fOC
         cwl3AxGB1cqKtnZmFdULtWf+K5thS+KOKq/48hBJS8RtPyUMl4rjXyQb4B2EJWykvAKU
         qzE1lOUSNw5blG4Lb2m8RFUBJBUvUmA/MVsdfUzw6T5kias/QF8NIEJQ7shu2+YYJaoW
         xcQACJHeoMb40B4p8evvOXLYqI9jtNU/YK8uYZwvF25AvE004DMC42hHEZYhUouygeef
         d1ww==
X-Forwarded-Encrypted: i=1; AJvYcCXo0UbbuewFO8bfJZTmYTs43kTHBUletiMPhqQQEOOtc8hC6RkQj9h/qtatLPLClJMtrfPCAtl132jTBkYt@vger.kernel.org
X-Gm-Message-State: AOJu0YzAR9dD5TAveJIR2Bszk5Wd3fGALn20W9iJMWMxFxp0jGyc85Jn
	ZG7Tw+dvIrvN5aNR3ykUexUSmPd/04FDGvisipAHAMGkN+wWZv7xXtp3EkAwZ8RiLBxrO7MIfc5
	dzu2hsMiLSUGWd6B2vR590WMV55rxRiNQ/A6j8WZt8g==
X-Gm-Gg: ATEYQzy3szCU2YgXlNalnIl+hlIt3zhGWRahN2A1f6N7GFLrOOeXUHNKj2rxiIWyl7X
	QHbx0enT8X3sjQTObPC52iskuPHSSrSp35LSstO8oZaW9ahqg5YBrMjA6lLTN3elJhFGAuTXSDA
	+Nh/qOVs4GMMm0gzuzdFXrUAsqCITzHoiLF7y4/cWNo+bhHFgfISfOGMXkKYCCHjuLIIsRG8rdj
	TZSwwRvEkT/LnSlcR3Wtmi0ddxklWs1FRuUIQMJu6oprcNr47tYDFJ+XiejNbUvT0XAYtsXhYLC
	6iSX74NBipPLFecIlUsJmDp9o69gkRLUfDFjvw==
X-Received: by 2002:a05:6402:5287:b0:668:58b6:505c with SMTP id
 4fb4d7f45d1cf-668c9b3b2famr8334029a12.30.1774271919886; Mon, 23 Mar 2026
 06:18:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260321175808.57942-1-pasha.tatashin@soleen.com>
 <20260321175808.57942-2-pasha.tatashin@soleen.com> <CA+CK2bD2aNu-NByET4KkBP0n2j8WQE2zjxb4g-1cv2hYfjaRZQ@mail.gmail.com>
 <20260323-leibhaftig-blasinstrument-58ec408b3c40@brauner>
In-Reply-To: <20260323-leibhaftig-blasinstrument-58ec408b3c40@brauner>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Mon, 23 Mar 2026 09:18:03 -0400
X-Gm-Features: AQROBzAqhjlsVN_c2OBjl5062LhFhC93S4akUrZBBBRdg0y4aoik88cM1Nzn6lE
Message-ID: <CA+CK2bC6S7pFCYR0XS1ZPxw9HKjWgxy=0DkszYNjMUi735o_1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] liveupdate: prevent double management of files
To: Christian Brauner <brauner@kernel.org>
Cc: linux-kselftest@vger.kernel.org, rppt@kernel.org, jack@suse.cz, 
	shuah@kernel.org, linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org, 
	dmatlack@google.com, pratyush@kernel.org, skhawaja@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 7:55=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Sat, Mar 21, 2026 at 09:04:53PM -0400, Pasha Tatashin wrote:
> > On Sat, Mar 21, 2026 at 1:58=E2=80=AFPM Pasha Tatashin
> > <pasha.tatashin@soleen.com> wrote:
> > >
> > > Currently, LUO does not prevent the same file from being managed twic=
e
> > > across different active sessions.
> > >
> > > Add a new i_state flag I_LUO_MANAGED and update luo_preserve_file()
> > > to check and set this flag when a file is preserved, and clear it in
> > > luo_file_unpreserve_files() when it is released.
> > >
> > > Additionally, set this flag in luo_retrieve_file() after a file is
> > > successfully restored in the new kernel, and clear it in
> > > luo_file_finish() when the LUO session is finalized.
> > >
> > > This ensures that the same file (inode) cannot be managed by multiple
> > > sessions. If another session attempts to preserve an already managed
> > > file, it will now fail with -EBUSY.
> > >
> > > Acked-by: Pratyush Yadav (Google) <pratyush@kernel.org>
> > > Acked-by: Jan Kara <jack@suse.cz>
> > > Signed-off-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> > > ---
> > >  include/linux/fs.h           |  5 ++++-
> > >  kernel/liveupdate/luo_file.c | 27 ++++++++++++++++++++++++---
> > >  2 files changed, 28 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index 23f36a2613a3..692a8be56f3c 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -712,6 +712,8 @@ is_uncached_acl(struct posix_acl *acl)
> > >   * I_LRU_ISOLATING     Inode is pinned being isolated from LRU witho=
ut holding
> > >   *                     i_count.
> > >   *
> > > + * I_LUO_MANAGED       Inode is being managed by a live update sessi=
on.
> > > + *
> > >   * Q: What is the difference between I_WILL_FREE and I_FREEING?
> > >   *
> > >   * __I_{SYNC,NEW,LRU_ISOLATING} are used to derive unique addresses =
to wait
> > > @@ -744,7 +746,8 @@ enum inode_state_flags_enum {
> > >         I_CREATING              =3D (1U << 15),
> > >         I_DONTCACHE             =3D (1U << 16),
> > >         I_SYNC_QUEUED           =3D (1U << 17),
> > > -       I_PINNING_NETFS_WB      =3D (1U << 18)
> > > +       I_PINNING_NETFS_WB      =3D (1U << 18),
> > > +       I_LUO_MANAGED           =3D (1U << 19),
> > >  };
> > >
> > >  #define I_DIRTY_INODE (I_DIRTY_SYNC | I_DIRTY_DATASYNC)
> > > diff --git a/kernel/liveupdate/luo_file.c b/kernel/liveupdate/luo_fil=
e.c
> > > index 5acee4174bf0..86911beeff71 100644
> > > --- a/kernel/liveupdate/luo_file.c
> > > +++ b/kernel/liveupdate/luo_file.c
> > > @@ -248,6 +248,7 @@ static bool luo_token_is_used(struct luo_file_set=
 *file_set, u64 token)
> > >   * Context: Can be called from an ioctl handler during normal system=
 operation.
> > >   * Return: 0 on success. Returns a negative errno on failure:
> > >   *         -EEXIST if the token is already used.
> > > + *         -EBUSY if the file descriptor is already preserved by ano=
ther session.
> > >   *         -EBADF if the file descriptor is invalid.
> > >   *         -ENOSPC if the file_set is full.
> > >   *         -ENOENT if no compatible handler is found.
> > > @@ -276,6 +277,14 @@ int luo_preserve_file(struct luo_file_set *file_=
set, u64 token, int fd)
> > >         if (err)
> > >                 goto  err_fput;
> > >
> > > +       scoped_guard(spinlock, &file_inode(file)->i_lock) {
> > > +               if (inode_state_read(file_inode(file)) & I_LUO_MANAGE=
D) {
> > > +                       err =3D -EBUSY;
> > > +                       goto err_free_files_mem;
> > > +               }
> > > +               inode_state_set(file_inode(file), I_LUO_MANAGED);
> > > +       }
> > > +
> > >         err =3D -ENOENT;
> > >         list_private_for_each_entry(fh, &luo_file_handler_list, list)=
 {
> > >                 if (fh->ops->can_preserve(fh, file)) {
> > > @@ -286,11 +295,11 @@ int luo_preserve_file(struct luo_file_set *file=
_set, u64 token, int fd)
> > >
> > >         /* err is still -ENOENT if no handler was found */
> > >         if (err)
> > > -               goto err_free_files_mem;
> > > +               goto err_unpreserve_inode;
> > >
> > >         err =3D luo_flb_file_preserve(fh);
> > >         if (err)
> > > -               goto err_free_files_mem;
> > > +               goto err_unpreserve_inode;
> > >
> > >         luo_file =3D kzalloc_obj(*luo_file);
> > >         if (!luo_file) {
> > > @@ -320,6 +329,9 @@ int luo_preserve_file(struct luo_file_set *file_s=
et, u64 token, int fd)
> > >         kfree(luo_file);
> > >  err_flb_unpreserve:
> > >         luo_flb_file_unpreserve(fh);
> > > +err_unpreserve_inode:
> > > +       scoped_guard(spinlock, &file_inode(file)->i_lock)
> > > +               inode_state_clear(file_inode(file), I_LUO_MANAGED);
> > >  err_free_files_mem:
> > >         luo_free_files_mem(file_set);
> > >  err_fput:
> > > @@ -363,6 +375,9 @@ void luo_file_unpreserve_files(struct luo_file_se=
t *file_set)
> > >                 luo_file->fh->ops->unpreserve(&args);
> > >                 luo_flb_file_unpreserve(luo_file->fh);
> > >
> > > +               scoped_guard(spinlock, &file_inode(luo_file->file)->i=
_lock)
> > > +                       inode_state_clear(file_inode(luo_file->file),=
 I_LUO_MANAGED);
> > > +
> > >                 list_del(&luo_file->list);
> > >                 file_set->count--;
> > >
> > > @@ -609,6 +624,9 @@ int luo_retrieve_file(struct luo_file_set *file_s=
et, u64 token,
> > >         *filep =3D luo_file->file;
> > >         luo_file->retrieve_status =3D 1;
> > >
> > > +       scoped_guard(spinlock, &file_inode(luo_file->file)->i_lock)
> > > +               inode_state_set(file_inode(luo_file->file), I_LUO_MAN=
AGED);
> > > +
> > >         return 0;
> > >  }
> > >
> > > @@ -701,8 +719,11 @@ int luo_file_finish(struct luo_file_set *file_se=
t)
> > >
> > >                 luo_file_finish_one(file_set, luo_file);
> > >
> > > -               if (luo_file->file)
> > > +               if (luo_file->file) {
> > > +                       scoped_guard(spinlock, &file_inode(luo_file->=
file)->i_lock)
> > > +                               inode_state_clear(file_inode(luo_file=
->file), I_LUO_MANAGED);
> > >                         fput(luo_file->file);
> > > +               }
> > >                 list_del(&luo_file->list);
> > >                 file_set->count--;
> > >                 mutex_destroy(&luo_file->mutex);
> > > --
> > > 2.43.0
> > >
> >
> > > Sashiko: https://sashiko.dev/#/patchset/20260321175808.57942-1-pasha.=
tatashin@soleen.com
> >
> > Sashiko reported two problems:
> >
> > 1. Are there any issues with mixing goto-based error handling and scope=
-based
> > cleanups like scoped_guard() in the same function?
> >
> > Initially, I thought that there should not be any problems, however,
> > after looking this up  I found in include/linux/cleanup.h the
> > following comment:
> >
> >  * Lastly, given that the benefit of cleanup helpers is removal of
> >  * "goto", and that the "goto" statement can jump between scopes, the
> >  * expectation is that usage of "goto" and cleanup helpers is never
> >  * mixed in the same function.
>
> There's a compile-time switch you might want to turn on when
> test-compiling code like this. I forget exactly what it is. Something
> like jump-over-uninit or something.
>
> >
> > Well, good to know, will not use goto inside scoped_guards.
> >
> > 2. Additionally, does setting I_LUO_MANAGED on the inode break the pres=
ervation
> > of anonymous inodes? Many file types (like eventfd, epoll, timerfd,
> > signalfd)
> >
> > This is actually a very good point. It looks like everyone who uses
> > anon_inode_getfd() has one shared inode. This is not a problem for the
> > existing LUO user memfd, or for the upcoming vfiofd and memfd, but
> > kvm-vmfd and kvm-cpufd also use it, and that might be a problem in the
> > future once we add support for Orphaned VMs.
> >
> > Therefore, we have two choices: either use a hash table, which adds
> > performance and memory overhead, or delegate this double-check to the
> > LUO file handlers, as they can use a private context to know if the FD
> > is already preserved.
>
> So, I'm not happy about I_LUO_MANAGED. I don't think we need driver
> specific stuff in struct inode and not in i_state. Track this in the
> driver please. I don't want this precedent and I'd rather have you get

I am planning to use an xarray in the next version.

> used to implementing such things in the driver right away rather than
> offloading this on general infrastructure. If we let this slide struct
> inode will be 2MB 1 in year.

Claiming that a single flag bit precedent would cause the overall
struct to grow by 2MB in a year is a slight exaggeration. :-)

Pasha
