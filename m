Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A303A0E99
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 20:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443685; cv=pass; b=aaSrzSiS+MhNTcSeOW4l1R6I0A3cMWAWBaIRQX39cqqgv5IzLrQAUayXcboV4vxlP2NsWbe+0omBF/Wdj9u7iakwatLqwPlLZdhgO7ehLOdR+JVLhqMWxw92As6suxUKEV9sIB0v7RNM0l8J+bI7UKyev+24rNTZc5P5IywoJsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443685; c=relaxed/simple;
	bh=Ger8JLSf83XYCngSD3c6v3XdqXp/SD8KdYf/sHDKot0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPK6Y4ctb0Xe+LRiFLPm/WUyXyBQQGH2JnoMGqaPZUOobS6WRTPfU5uA8GzuDkSE77IlWLmm0g6jfSFO5EnsiUbb7/dmoxk9w+EzIvCZiX+AaFb7OGDyKTCEH0tU3dBbjxH2v1KBFwxf3mPLflkCpe/2stl7KlvGDk3ZQO3fmQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PlxbheTi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fp4eo1bF; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PlxbheTi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fp4eo1bF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785443673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZYsKf2tFByEhS+XnCpBkSNxEAhvEQHSnH1Cu2WNtl4=;
	b=PlxbheTiUk/jc7fGI3mMPO1W/tIxmPepGC0PedHxvEeIWOMnaquzUArankR+nQnpIld4uc
	IiyMlBKoK+Dxg+15GSz2dUtPcYQdicONZ+sHWBcYLBQ+xzY5sPpZXU3zyqcSe7miufzTIg
	86HPNgOfzbKGcElAvHj4nEWt/9qabOo=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-CkV_uU6hMjO68aA21C3qeA-1; Thu, 30 Jul 2026 16:34:32 -0400
X-MC-Unique: CkV_uU6hMjO68aA21C3qeA-1
X-Mimecast-MFC-AGG-ID: CkV_uU6hMjO68aA21C3qeA_1785443671
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-81e6fce9ed7so5484357b3.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 13:34:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785443671; cv=none;
        d=google.com; s=arc-20260327;
        b=Iv6uajGGh4QshzZf3+InYd5HnBCwe9GXMwvFAfBC9n7NMabhm6z8f5oVOdrVldfvMi
         IEXGGOoG9tJODqjljSDiVAojlndlvAuUmdTbnvhvMvkUCqIvjPtK8Ai4sgC8t99VFfn8
         NDJYTXKQ3ukmNtpS/LkFehbQ9x558gDqArus5PwY65ZCfbCRA29KbzV4sfVMbGIVjHgk
         qK7TYQEbG8Qwy/v4cpvVL+ZmmedOOeEzrfhUWarI3NpIfxIMrQ6kAwwY8RcSk192Bpag
         A3tIL83GcF2RAeEHMwyCxHiJc6POYdwh3ukor69GONvA7CGXR193hh9HNlLZ/a3Tw1cX
         6BvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rZYsKf2tFByEhS+XnCpBkSNxEAhvEQHSnH1Cu2WNtl4=;
        fh=Voy+ekGsyANKk6bgycz7gwRToTIh6fgYejl/GB2vFPk=;
        b=WuXq2/D5QcJpMb4OKzs5t1GJn6aEH24pFdEepBbqNPLKsWrsY2pJT7+BfBXviOGJy0
         lPHJcHX3+RzFtcKDCcCmMoup/1IBOCTiSeGcsBrdSv9EBJtyP6sA+FTLMnEbsmebIW0/
         M1t/a7m5RRLyIAd+SKu5AtJZ2DtBXeCDbOb0P6rVckP18uA9dNlxcpXA1KVdxzF5PqeX
         BwCcdtZB226RISgGm76dUhaxJaw3aKZLbl2PlBEXIWDKkBoWzFBep6oGutPiND6qAAfH
         q+aho59lwcH7gSmJtY1OUld03ZLAAYzsEuukcJLeAArxLcJV+5VMdnxEvGeD/V0HYN7l
         ZlmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785443671; x=1786048471; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rZYsKf2tFByEhS+XnCpBkSNxEAhvEQHSnH1Cu2WNtl4=;
        b=fp4eo1bFUC1dDUr3bJuTSRdPcvAyOhYG3BNiMTgg7toqXhE4jZ1um5Its/ca2LAoOl
         YNoDpha8mf+lmNYxypu+QoIjWcYm+rXlXOyM3LmcVOwVWwIz56/K60ui3m/PVKUWdFrF
         JQwowrwasYAoMPRzmWZ4Y7zCDhSPezXTRnsZd5+MA0RRj0p0BrquYXgeypz6geOyIalV
         +ercsBKSpIALIpuCmaTlkaeM4NqWG3rdfzHQ1AhLYyjIGOfLeIt4i2ghlUDAEsaCH1kO
         /xdm9bbddZIuuN9upDvFJS/98jhaEr+ECVrnoxXGl7us93mBzcmtziB8sCoQqo+P1dZ4
         5n+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785443671; x=1786048471;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rZYsKf2tFByEhS+XnCpBkSNxEAhvEQHSnH1Cu2WNtl4=;
        b=l2gsJelb1klmEDLCkJTJexT8MrLTKVL3dpXHHYaYL8+qVgtYiQpfsKbkzw/2X2LLYi
         aEth9qAgAdXCttiv9o31gMHh/r60taFSFtMHcMww00ifKxyTVZ362JvUB2YSY7c77uub
         pDxSlHf9zCvsv4qNlOMjoZN9sLa5PVM2nYsScFiu0nF3hhfrfh1sc55TvmT55F0nWqGD
         BLoQPIQr28wdNGPWuLDnNHe8Ytndw2LF2b159uAfRfPwnQMPZa9HweSY8vW5OVYJr+GF
         IndMa99Ma8hx4Wl+h8xs+uwdPqiSLGBXB6nwc2iD3jAX/i6Z7SMAqnMrNpU9ZzTOSPTV
         Xazw==
X-Forwarded-Encrypted: i=1; AHgh+RoB5OZQtf7rP3ypWO7znBN6cxDV/FKx/4f8bwwqMUFoacpTTF+TgKRfNm4negTW1ltAVyGQMdsK/fsw2BVm@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqt/pFew3Xp+N/aZlSlrm3eQhbwLyL/kl9OaxVLFr1E24uPTqJ
	Uq/oU6XfGqhtFRnqKsf0L+K4fMol/eufY351KUjjfEinZsUl3o3c122UmWn5/g6YQswp0S/9ykd
	e7eSKHvLtFOpmNid/5dUtoJ6sFRQKeGgGLPetc1niHrEPquUvFbNq5JqCYA31u4kWSCv/yhq7n3
	vMly8vtS+sYSD3sLQzBJ7w7p8xnSTqPuqmLx7BzBsNHnGlzjiiJns1
X-Gm-Gg: AR+sD12lLmG5aq5jWXDbJc6oP2YNR1YUBmPFFxFfBNOl13Mb0+SfuDzSLuknB5us7aU
	iFkbJ2+5o2/LtozVFVpe1oejPuBRDYA9rLOV3k/LIfDu4fEDLWR4Vu2YBY63g96quRh75VCWfkI
	Fn+dLekB9gEUhoinEwYhJo+S/RedaKmBKdo/8pD05ljAJH/dNb57/g1J+qgxUMlWTCD5PjRIxyJ
	uXCUS13C7d9dR3HcDL8bH0P58BzK3lTyu2Vki5RvKTs
X-Received: by 2002:a05:690c:6286:b0:7f5:87d3:c38c with SMTP id 00721157ae682-81fc1e61782mr13055787b3.21.1785443671207;
        Thu, 30 Jul 2026 13:34:31 -0700 (PDT)
X-Received: by 2002:a05:690c:6286:b0:7f5:87d3:c38c with SMTP id
 00721157ae682-81fc1e61782mr13055567b3.21.1785443670634; Thu, 30 Jul 2026
 13:34:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722151023.1308069-1-agruenba@redhat.com> <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
In-Reply-To: <20260730-armband-reklamieren-heuchelei-6f67abb088de@brauner>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 30 Jul 2026 22:34:19 +0200
X-Gm-Features: AUfX_mw2pATzewMfAd0MOzCem6pVI6Mr50g-FvGkba0dPeF0zHHIdQ_n30P8IwU
Message-ID: <CAHc6FU4719z5crxP-ahSXs2qLachSL9GOiv4kXRZRifNxm-U_A@mail.gmail.com>
Subject: Re: [PATCH v2] xattrat: accept empty O_PATH file descriptors
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 8:49=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On 2026-07-22 17:10 +0200, Andreas Gruenbacher wrote:
> > Christian,
> >
> > here's an updated patch for making the *xattrat() system calls accept
> > O_PATH file descriptors.
> >
> > Compared to the previous version (see the discussion at [*]), this
> > version adds a fd_maybe_raw cleanup class that uses either fdget() or
> > fdget_raw() depending on which kinds of file descriptors are acceptable=
.
> > That's still a but ugly, but all the alternatives I could come up with
> > are much worse.
> >
> > [*] https://lore.kernel.org/linux-fsdevel/20260701191649.175871-1-agrue=
nba@redhat.com/
>
> Thank you. How do you feel about?

I don't think it's an improvement; see below.

> ---
>  fs/xattr.c | 100 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 64 insertions(+), 36 deletions(-)
>
> diff --git a/fs/xattr.c b/fs/xattr.c
> index d58979115200..133bca3371ee 100644
> --- a/fs/xattr.c
> +++ b/fs/xattr.c
> @@ -698,9 +698,10 @@ int filename_setxattr(int dfd, struct filename *file=
name,
>         return error;
>  }
>
> -static int path_setxattrat(int dfd, const char __user *pathname,
> -                          unsigned int at_flags, const char __user *name=
,
> -                          const void __user *value, size_t size, int fla=
gs)
> +static int path_setxattrat(int dfd, struct file *dfd_file,
> +                          const char __user *pathname, unsigned int at_f=
lags,
> +                          const char __user *name, const void __user *va=
lue,
> +                          size_t size, int flags)
>  {
>         struct xattr_name kname;
>         struct kernel_xattr_ctx ctx =3D {
> @@ -725,11 +726,10 @@ static int path_setxattrat(int dfd, const char __us=
er *pathname,
>
>         CLASS(filename_maybe_null, filename)(pathname, at_flags);
>         if (!filename && dfd >=3D 0) {
> -               CLASS(fd, f)(dfd);
> -               if (fd_empty(f))
> +               if (!dfd_file)
>                         error =3D -EBADF;

I don't particularly like that the initialization and the error
checking are being split up here. The result is the same, though.

>                 else
> -                       error =3D file_setxattr(fd_file(f), &ctx);
> +                       error =3D file_setxattr(dfd_file, &ctx);
>         } else {
>                 error =3D filename_setxattr(dfd, filename, lookup_flags, =
&ctx);
>         }
> @@ -756,7 +756,10 @@ SYSCALL_DEFINE6(setxattrat, int, dfd, const char __u=
ser *, pathname, unsigned in
>         if (error)
>                 return error;
>
> -       return path_setxattrat(dfd, pathname, at_flags, name,
> +       /* setxattrat() accepts O_PATH file descriptors. */
> +       CLASS(fd_raw, f)(dfd);

On this path, fdget_raw(dfd) will now be called unnecessarily when
pathname is not NULL.

> +
> +       return path_setxattrat(dfd, fd_file(f), pathname, at_flags, name,
>                                u64_to_user_ptr(args.value), args.size,
>                                args.flags);
>  }
> @@ -765,21 +768,25 @@ SYSCALL_DEFINE5(setxattr, const char __user *, path=
name,
>                 const char __user *, name, const void __user *, value,
>                 size_t, size, int, flags)
>  {
> -       return path_setxattrat(AT_FDCWD, pathname, 0, name, value, size, =
flags);
> +       return path_setxattrat(AT_FDCWD, NULL, pathname, 0, name, value, =
size,
> +                              flags);
>  }
>
>  SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
>                 const char __user *, name, const void __user *, value,
>                 size_t, size, int, flags)
>  {
> -       return path_setxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, n=
ame,
> -                              value, size, flags);
> +       return path_setxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOL=
LOW,
> +                              name, value, size, flags);
>  }
>
>  SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
>                 const void __user *,value, size_t, size, int, flags)
>  {
> -       return path_setxattrat(fd, NULL, AT_EMPTY_PATH, name,
> +       /* fsetxattr() rejects O_PATH file descriptors. */
> +       CLASS(fd, f)(fd);
> +
> +       return path_setxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, name,
>                                value, size, flags);
>  }
>
> @@ -843,7 +850,8 @@ ssize_t filename_getxattr(int dfd, struct filename *f=
ilename,
>         return error;
>  }
>
> -static ssize_t path_getxattrat(int dfd, const char __user *pathname,
> +static ssize_t path_getxattrat(int dfd, struct file *dfd_file,
> +                              const char __user *pathname,
>                                unsigned int at_flags, const char __user *=
name,
>                                void __user *value, size_t size)
>  {
> @@ -865,10 +873,9 @@ static ssize_t path_getxattrat(int dfd, const char _=
_user *pathname,
>
>         CLASS(filename_maybe_null, filename)(pathname, at_flags);
>         if (!filename && dfd >=3D 0) {
> -               CLASS(fd, f)(dfd);
> -               if (fd_empty(f))
> +               if (!dfd_file)
>                         return -EBADF;
> -               return file_getxattr(fd_file(f), &ctx);
> +               return file_getxattr(dfd_file, &ctx);
>         } else {
>                 int lookup_flags =3D 0;
>                 if (!(at_flags & AT_SYMLINK_NOFOLLOW))
> @@ -898,27 +905,34 @@ SYSCALL_DEFINE6(getxattrat, int, dfd, const char __=
user *, pathname, unsigned in
>         if (args.flags !=3D 0)
>                 return -EINVAL;
>
> -       return path_getxattrat(dfd, pathname, at_flags, name,
> +       /* getxattrat() accepts O_PATH file descriptors. */
> +       CLASS(fd_raw, f)(dfd);

Same here.

> +
> +       return path_getxattrat(dfd, fd_file(f), pathname, at_flags, name,
>                                u64_to_user_ptr(args.value), args.size);
>  }
>
>  SYSCALL_DEFINE4(getxattr, const char __user *, pathname,
>                 const char __user *, name, void __user *, value, size_t, =
size)
>  {
> -       return path_getxattrat(AT_FDCWD, pathname, 0, name, value, size);
> +       return path_getxattrat(AT_FDCWD, NULL, pathname, 0, name, value, =
size);
>  }
>
>  SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
>                 const char __user *, name, void __user *, value, size_t, =
size)
>  {
> -       return path_getxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, n=
ame,
> -                              value, size);
> +       return path_getxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFOL=
LOW,
> +                              name, value, size);
>  }
>
>  SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
>                 void __user *, value, size_t, size)
>  {
> -       return path_getxattrat(fd, NULL, AT_EMPTY_PATH, name, value, size=
);
> +       /* fgetxattr() rejects O_PATH file descriptors. */
> +       CLASS(fd, f)(fd);
> +
> +       return path_getxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, name,=
 value,
> +                              size);
>  }
>
>  /*
> @@ -980,7 +994,8 @@ ssize_t filename_listxattr(int dfd, struct filename *=
filename,
>         return error;
>  }
>
> -static ssize_t path_listxattrat(int dfd, const char __user *pathname,
> +static ssize_t path_listxattrat(int dfd, struct file *dfd_file,
> +                               const char __user *pathname,
>                                 unsigned int at_flags, char __user *list,
>                                 size_t size)
>  {
> @@ -991,10 +1006,9 @@ static ssize_t path_listxattrat(int dfd, const char=
 __user *pathname,
>
>         CLASS(filename_maybe_null, filename)(pathname, at_flags);
>         if (!filename) {
> -               CLASS(fd, f)(dfd);
> -               if (fd_empty(f))
> +               if (!dfd_file)
>                         return -EBADF;
> -               return file_listxattr(fd_file(f), list, size);
> +               return file_listxattr(dfd_file, list, size);
>         }
>
>         lookup_flags =3D (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FO=
LLOW;
> @@ -1005,24 +1019,31 @@ SYSCALL_DEFINE5(listxattrat, int, dfd, const char=
 __user *, pathname,
>                 unsigned int, at_flags,
>                 char __user *, list, size_t, size)
>  {
> -       return path_listxattrat(dfd, pathname, at_flags, list, size);
> +       /* listxattrat() accepts O_PATH file descriptors. */
> +       CLASS(fd_raw, f)(dfd);

And here.

> +
> +       return path_listxattrat(dfd, fd_file(f), pathname, at_flags, list=
, size);
>  }
>
>  SYSCALL_DEFINE3(listxattr, const char __user *, pathname, char __user *,=
 list,
>                 size_t, size)
>  {
> -       return path_listxattrat(AT_FDCWD, pathname, 0, list, size);
> +       return path_listxattrat(AT_FDCWD, NULL, pathname, 0, list, size);
>  }
>
>  SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *=
, list,
>                 size_t, size)
>  {
> -       return path_listxattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW, =
list, size);
> +       return path_listxattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NOFO=
LLOW,
> +                               list, size);
>  }
>
>  SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
>  {
> -       return path_listxattrat(fd, NULL, AT_EMPTY_PATH, list, size);
> +       /* flistxattr() rejects O_PATH file descriptors. */
> +       CLASS(fd, f)(fd);
> +
> +       return path_listxattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, list=
, size);
>  }
>
>  /*
> @@ -1072,7 +1093,8 @@ static int filename_removexattr(int dfd, struct fil=
ename *filename,
>         return error;
>  }
>
> -static int path_removexattrat(int dfd, const char __user *pathname,
> +static int path_removexattrat(int dfd, struct file *dfd_file,
> +                             const char __user *pathname,
>                               unsigned int at_flags, const char __user *n=
ame)
>  {
>         struct xattr_name kname;
> @@ -1088,10 +1110,9 @@ static int path_removexattrat(int dfd, const char =
__user *pathname,
>
>         CLASS(filename_maybe_null, filename)(pathname, at_flags);
>         if (!filename) {
> -               CLASS(fd, f)(dfd);
> -               if (fd_empty(f))
> +               if (!dfd_file)
>                         return -EBADF;
> -               return file_removexattr(fd_file(f), &kname);
> +               return file_removexattr(dfd_file, &kname);
>         }
>         lookup_flags =3D (at_flags & AT_SYMLINK_NOFOLLOW) ? 0 : LOOKUP_FO=
LLOW;
>         return filename_removexattr(dfd, filename, lookup_flags, &kname);
> @@ -1100,24 +1121,31 @@ static int path_removexattrat(int dfd, const char=
 __user *pathname,
>  SYSCALL_DEFINE4(removexattrat, int, dfd, const char __user *, pathname,
>                 unsigned int, at_flags, const char __user *, name)
>  {
> -       return path_removexattrat(dfd, pathname, at_flags, name);
> +       /* removexattrat() accepts O_PATH file descriptors. */
> +       CLASS(fd_raw, f)(dfd);

And here.

> +
> +       return path_removexattrat(dfd, fd_file(f), pathname, at_flags, na=
me);
>  }
>
>  SYSCALL_DEFINE2(removexattr, const char __user *, pathname,
>                 const char __user *, name)
>  {
> -       return path_removexattrat(AT_FDCWD, pathname, 0, name);
> +       return path_removexattrat(AT_FDCWD, NULL, pathname, 0, name);
>  }
>
>  SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
>                 const char __user *, name)
>  {
> -       return path_removexattrat(AT_FDCWD, pathname, AT_SYMLINK_NOFOLLOW=
, name);
> +       return path_removexattrat(AT_FDCWD, NULL, pathname, AT_SYMLINK_NO=
FOLLOW,
> +                                 name);
>  }
>
>  SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
>  {
> -       return path_removexattrat(fd, NULL, AT_EMPTY_PATH, name);
> +       /* fremovexattr() rejects O_PATH file descriptors. */
> +       CLASS(fd, f)(fd);
> +
> +       return path_removexattrat(fd, fd_file(f), NULL, AT_EMPTY_PATH, na=
me);
>  }
>
>  int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *n=
ame)
>

Thanks,
Andreas

