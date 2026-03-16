Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821451E7660
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 17:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681765; cv=pass; b=W6mR9AH+3h6JJLEJpbQzjEkFkVj9+/BDlWzeHgBNmNQRIJX7jksTNXh9hqHCmn9GOKJ1NQgkx2ugEnwwJQwjf/DerT2D7w90wdlsuDu+2KTyd8gSljB1YNV2ALR1c4gq4jNN/zzLa/KWS//ZpcFcdUzJgMtHYpo5eYQm/T+vu7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681765; c=relaxed/simple;
	bh=38YIF2h9LQRciTDudLh6dbVHlCWQ+CVfx4lmwVgz+TQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nXPUyzEvI391B+PQDFnNX5h0xHcH9gG/xr8OB6NBwn5Y5n8TfJwCqRK+iZ/JPk/uZKlYx2kkdhyPqyCbyZLm9WOojawlmdmiPB8Sy+5c5RlKA3vxh9+fH+XuSdY1PhtBhOi5V/Y2U4w79o2aNib3rRAlG7Oy8uAYNlwqsEODWhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HcYmuPi0; arc=pass smtp.client-ip=209.85.217.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HcYmuPi0"
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-5ffa277c115so2635088137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Mar 2026 10:22:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773681761; cv=none;
        d=google.com; s=arc-20240605;
        b=Gw/76m1bxPdspffGqy7ANLS/phfuRGUXLKs7fdaDaKfMkBiXLuGmcVRm9jIeT46MF0
         LvouPZDVbxg2MThPDMLbwmS1o9XQEb2PIvSv7z5qJnYPr9q/Ec7wwAyKeIXcPJx6ck4a
         RBLwg/OvS/1zMmIOKuybpAd+oiIIA6J0qPTwBRM/kdPcExvCGEAHXZ1DRESQvKBaoT/6
         xESBb7eKwSHoIEoznDIHt+eCXVLwZJfy0pfy/XwJiLzZKIlBbb+6E6bU2rd1J5+MvOtu
         voKEouq0ebY+QNdKqU+G/TJBqEyaRo9UPOmqxCT0FYRjGKF3LRNtBtdmQiu4oq1ky0/r
         mdaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        fh=0YrBa/XAmvc2EfVzmLXoVo8r893lVAipfi4/g4vV8eo=;
        b=RmkM1V9IY8eY7A4hCqCqX4dEKpuTh6wNuoZUy49FsCQL6onKspUdri/Pr0uOKlxCvt
         AtkXgusClM3ShxD96A3kKS2B81SG6ieVmeJvGGWIdvFUxxsRbzd4RKJI4XxaIqPlnc8B
         8J3vLtRG4y4fos1BWQF9VCXEHOjXUJL32aZYOdpQewAcRiDuTtam+9b1pyYGfPdOz0uC
         y/O80zR/cRxTYftSHyrlJoCRf/t4ILKg94atIf2Dm1x0BfAgploptcJcLx3xJnWqJ8EU
         D8i/mnqWkbUxGdS770riIUgtw4QrfhvV9idThEIAfbylujdH6VvW6BB3Tfm1EXtfRFko
         eLkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773681761; x=1774286561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=HcYmuPi0X/TZNmyRIOXExfvEHRzD0UyzV54M82kVNgBzzjKlBf7yjuyMETcJ7LusHX
         pr4wvj5PTOWmQLvZr0/nXx+Tqv/O77n+pWvH7woRd/u8jnCj3F1WihYuOO50zXEfUlpo
         P7srtkllUt2jcefTNJ+39OAhm63tB8Y/e4qItfYY80voDNkTai5h05geghQmFWiqCtW0
         lVyCyVhRPKH0p+C+PHpz9DqJJzT9jJr1wPNN1sOcV1X3tMTRY7A+UE4Hvqm+O1+2s7m+
         dinmKniZOJu9i7oMW+aLBtXr11vx6l/tDr23e4AjmBuEk2vF8T8I0ICnInpqLgKzBWYR
         m2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773681761; x=1774286561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3DZPi773JGtMdvcTYXrz3SkUkUANIodCa33A4wwy7k=;
        b=NXD4+mzUezmljtMuyYC+wSOg1YLtzES64cey40Atfrix5T4EgPufarIvUedCkaK860
         pIlcgLD4Cxv57a1kppQh4dKaxNhX0A7hqn/4Q+M8LCIzzl0JlP1hhK9oBEfSgfJFU5DA
         wf74RurjHd5pFG3+pLDKyu5Sgnatt/YUPoOkwO6ueOJTmHgflllcagY8olHQ5Ucn7YEV
         kQmowNNsAob0kJW6A89LZyD9kg30Dwj0gbV1ndQqe8RL8/5BkXvmN9bweCipxhGwJjCf
         OfZviFdBvL6lqhsCqk1uMQCrHqauivZfcydS5RLYu0thLi2yG26FQ99y2/aPeG/SUtMG
         hWMA==
X-Gm-Message-State: AOJu0YxpLFI61RaNBVnsgwz8kUcSYmEvvMyGJktSh+hZHhR4lmP5B7XA
	XUCval3fyR51HHkqAfKZABvv1rAKilFVP7qnZZXPsX/I1A/WzzgB4ClWPC7INbzqhuC/YZ109vU
	fyZZxxPv9b4Okihgy4LecUlWuAubad9k=
X-Gm-Gg: ATEYQzyqFmtxvzyW+BhI3NuQP5UFh7iPxuaEZE5GbQH+02pKwo8lcTODoD2SoYIWVhD
	xrjT+eiy6ztimAdPzhX6vJDmIS63Lv+JgSqT8oqcDBkZCFKNYqw2jcUlv+9Y+unysh7Lxh9rtKP
	MTxus7Kx2z+I7738+KjHT/4vtxhHcaZjhvRIPaHSewNmhyuyMoBmqyCQ9lyTOv+eFjqd+9mHSdv
	cI/lrh/cUrug+PUNqjVX4eDqlqLYJHea+Ubw8ZFh/rinhVzT4WHPHYKnpwgKZjSMY8XJrU/Gvwq
	Nam2DM7pCS9kdGLp3Gp9YIJG4l4pId7BP+O7lNSEP2YgpY4r0l6/oFk=
X-Received: by 2002:a05:6102:32c4:b0:5e1:866c:4f8a with SMTP id
 ada2fe7eead31-6020e52dbbamr5788771137.20.1773681761421; Mon, 16 Mar 2026
 10:22:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
 <20260307140726.70219-2-dorjoychy111@gmail.com> <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
In-Reply-To: <5fcc2a6e6d92dae0601c6b3b8faa8b2f83981afb.camel@kernel.org>
From: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Date: Mon, 16 Mar 2026 23:22:29 +0600
X-Gm-Features: AaiRm519sCKeQSwcsAIj83-gCCcOtyLCMrhp4On2ZfkD8pFyjWgcliN3tJw964Y
Message-ID: <CAFfO_h5pyrTTwJ3swHNLT=ZyeTJG=eHw626bTqQqAh+GeN3PhA@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, ceph-devel@vger.kernel.org, gfs2@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-kselftest@vger.kernel.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, chuck.lever@oracle.com, alex.aring@gmail.com, arnd@arndb.de, 
	adilger@dilger.ca, mjguzik@gmail.com, smfrench@gmail.com, 
	richard.henderson@linaro.org, mattst88@gmail.com, linmag7@gmail.com, 
	tsbogend@alpha.franken.de, James.Bottomley@hansenpartnership.com, 
	deller@gmx.de, davem@davemloft.net, andreas@gaisler.com, idryomov@gmail.com, 
	amarkuze@redhat.com, slava@dubeyko.com, agruenba@redhat.com, 
	trondmy@kernel.org, anna@kernel.org, sfrench@samba.org, pc@manguebit.org, 
	ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com, 
	bharathsm@microsoft.com, shuah@kernel.org, miklos@szeredi.hu, 
	hansg@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 10:53=E2=80=AFPM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Sat, 2026-03-07 at 20:06 +0600, Dorjoy Chowdhury wrote:
> > This flag indicates the path should be opened if it's a regular file.
> > This is useful to write secure programs that want to avoid being
> > tricked into opening device nodes with special semantics while thinking
> > they operate on regular files. This is a requested feature from the
> > uapi-group[1].
> >
> > A corresponding error code EFTYPE has been introduced. For example, if
> > openat2 is called on path /dev/null with OPENAT2_REGULAR in the flag
> > param, it will return -EFTYPE. EFTYPE is already used in BSD systems
> > like FreeBSD, macOS.
> >
> > When used in combination with O_CREAT, either the regular file is
> > created, or if the path already exists, it is opened if it's a regular
> > file. Otherwise, -EFTYPE is returned.
> >
> > When OPENAT2_REGULAR is combined with O_DIRECTORY, -EINVAL is returned
> > as it doesn't make sense to open a path that is both a directory and a
> > regular file.
> >
> > [1]: https://uapi-group.org/kernel-features/#ability-to-only-open-regul=
ar-files
> >
> > Signed-off-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
> > ---
> >  arch/alpha/include/uapi/asm/errno.h        |  2 ++
> >  arch/alpha/include/uapi/asm/fcntl.h        |  1 +
> >  arch/mips/include/uapi/asm/errno.h         |  2 ++
> >  arch/parisc/include/uapi/asm/errno.h       |  2 ++
> >  arch/parisc/include/uapi/asm/fcntl.h       |  1 +
> >  arch/sparc/include/uapi/asm/errno.h        |  2 ++
> >  arch/sparc/include/uapi/asm/fcntl.h        |  1 +
> >  fs/ceph/file.c                             |  4 ++++
> >  fs/gfs2/inode.c                            |  6 ++++++
> >  fs/namei.c                                 |  4 ++++
> >  fs/nfs/dir.c                               |  4 ++++
> >  fs/open.c                                  |  4 +++-
> >  fs/smb/client/dir.c                        | 14 +++++++++++++-
> >  include/linux/fcntl.h                      |  2 ++
> >  include/uapi/asm-generic/errno.h           |  2 ++
> >  include/uapi/asm-generic/fcntl.h           |  4 ++++
> >  tools/arch/alpha/include/uapi/asm/errno.h  |  2 ++
> >  tools/arch/mips/include/uapi/asm/errno.h   |  2 ++
> >  tools/arch/parisc/include/uapi/asm/errno.h |  2 ++
> >  tools/arch/sparc/include/uapi/asm/errno.h  |  2 ++
> >  tools/include/uapi/asm-generic/errno.h     |  2 ++
> >  21 files changed, 63 insertions(+), 2 deletions(-)
> >
> >
>
> I pointed Claude at this patch and got this back. Both issues that it
> found will need to be fixed:
>
>   Analysis Summary
>
>   Commit: 7e7fa2653ca57 - openat2: new OPENAT2_REGULAR flag support
>
>   This patch adds a new OPENAT2_REGULAR flag for openat2() that restricts=
 opens to regular files only, returning a new
>   EFTYPE errno for non-regular files. It adds filesystem-specific checks =
in ceph, gfs2, nfs, and cifs atomic_open paths,
>   plus a VFS-level fallback in do_open().
>
>   Issues found:
>
>   1. OPENAT2_REGULAR leaks into f_flags - do_dentry_open() strips open-ti=
me-only flags (O_CREAT|O_EXCL|O_NOCTTY|O_TRUNC)
>   but does not strip OPENAT2_REGULAR. When a regular file is successfully=
 opened via openat2() with this flag, the bit
>   persists in file->f_flags and will be returned by fcntl(fd, F_GETFL).
>   2. BUILD_BUG_ON not updated - The compile-time guard checks upper_32_bi=
ts(VALID_OPEN_FLAGS) but the code now accepts
>   VALID_OPENAT2_FLAGS. The guard should cover the expanded flag set.
>

Good catches! I guess for issue 1 I need to modify the line in
do_dentry_open implementation to
f->f_flags &=3D ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | OPENAT2_REGULAR);
right?
And for issue 2, I should change the VALID_OPEN_FLAGS to
VALID_OPENAT2_FLAGS in both build_open_flags in fs/open.c and in
fcntl_init in fs/fcntl.c, correct?

Regards,
Dorjoy
