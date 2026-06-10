Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B4189B84
	for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 14:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102114; cv=pass; b=N/7nIGWQslqz8IJlaPXJRWsPUk4I7T1oFgrc9HdAzQNUipfSfVnB3XLlE7eraoN63ie6bqGGufainX9tYfxFQB1LZ8QMXq90NE3qBsaWQJj6rmpHmw7xYj9iPpVIfLxMX0yYM3oBS4PXq1g9ddmNlHmNF3mT14+vLaTYDPaMrFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102114; c=relaxed/simple;
	bh=qenqtEe/LDB4qda6heXtvrXRWOP8UTG6Crv50cPiHV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMv3dl9NX9DbfdyXpQZXcWdS50XCp0Ap4BXd2fdCa83QY91Wt8UYGl9StBZPV+ezYjhA/PcLHBA7m3Sp4X0S65Iv9yf+jM4f28DsVbFxn0Nt09Ml3VXRLxaSSxRE5NbVFPCQ/10c8+O9BGwOIiBnJEeoG3HFYqKpiygKfKsi8hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1JvdOx0; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1JvdOx0"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68c3421b009so11137530a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 07:35:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102110; cv=none;
        d=google.com; s=arc-20240605;
        b=dxMb98FQE2UCkv8RMEo7yPveN32nWIiz3JmD6bG+M26kDuAk+PjWO8p6FaDfPkOuSx
         LaZGgM7hwVm0PQBo15F6JKem4m/nYoKhgeidgDDqlnBKH+wvuWsaRAZf/lgmCpsXN6tL
         46XKaSJGZs5hj2smRrGYbhEOaSH/UXqBmWm8vPq4CZav+A0CNps4HoFoDyddLgTaSvNG
         6zqZp8k1xTjrIWjVNyL9On/1uIa9ICMuX7vXOEPi/QV0p2ZLVsz77Fd2KFz6LgHAEBj2
         OzgVPSPMV6BDM3ept18WEvp5Dja6jKxWcXSzbyB+pp08XnERa8iDjRMm6m3NGILgoGhX
         fqdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dBrK8RWGfN944LnbNOnvietp8yDk967NTi0tRu3taC0=;
        fh=fjnCMgPZSW91fafQw/Es2r+zfs002/LZehOH6wsQVrc=;
        b=OuErV5qPLwQYqOSTXvWxtpzm0Nl2EJbbD62sjJk5YGjVwoKxWfuwNyP/S1vcoEDwnB
         5WeP243L50OmnvlOnfMy2gIfvQhweLw1FyO4BqKIniBpWFOBaJK51fs2EMTJeqLAw4wz
         QsMbDxEHlvXJZ235PseaAU0NA7S3Dx7NptxxkibpIGob/TzviTkD5vqubyvRYp7/wr4a
         xp0CWqG9uavvKrscSbKcepDWyxrtwua5NTIefrqRrWA40pKGlBfL0YequcaX1hNLlRfD
         ykYtrDBlVTV6KO4v9FYzux23uFPEYjNu1iujdhcNrqVbYgn0nFtvT71+hj1jXGGI7m6I
         /J4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102110; x=1781706910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBrK8RWGfN944LnbNOnvietp8yDk967NTi0tRu3taC0=;
        b=Q1JvdOx0zJ/eB1ue/6/isL30Le97kYVFReJpE24xC2o/VTHpVKS3vUZRPKxsXVxR7u
         Pt9oYdCAB/nqOhGEMPr3WlMrRbfMptRuMbwXgk8yLxZInUBh9Sy4ZGH08zndB1/QXtYz
         yKFInBgUN7BCzZarbOrYdmSkAMfdWmm43YgqufMp1xUjFd4yBar/CSHGA1LqcSOI8vya
         Cf51n8+J0c5ihE7VH7plxIPX00aK8A2q+Wg9hT2I33CL7nVGRU8B0jKVeMS+Xl2xAZbH
         Db5Bb7Y+ah+9JzNHVw983zBVqXlXPf4DABRF1Zlq9Ovwt5rR/doCV43J2jvj62Z9OUKJ
         GQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102110; x=1781706910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dBrK8RWGfN944LnbNOnvietp8yDk967NTi0tRu3taC0=;
        b=Vp//8tsIaApS7som0WRN4rnritypkv8FTTLcilVuc3ujhn68E5dfBshMLpyXe59Hyi
         dveHYishh58f1nsJP6i1lRyC9pHwPuhXHNAO8m5XVEfx+nvfxy0Iyjn/N5YuenW6dYPD
         P8lSDr0jfcZ7RBXqSTuSZQKZTgvoiZLQ9/Ime/yUEQAkCksvV75Pb+IXYdbK7llId9tz
         BgGvL58tu+hw146iIVW4yXgpiLPJChgkXn9jzD+Cxp0+37THEpfblF0+N+neYc23wPeJ
         1SFBcFnsAEBW9an49+amaTx3ZTmY9QQVXCFO3bgJTpPdE4gS0XusrSbGCRfVXY5NXknQ
         g2Zg==
X-Forwarded-Encrypted: i=1; AFNElJ+dD/7Vq9XuVEtqtngYfvflVp2ImajzaqPAxVBOEhSMwDWOabQWzEBKkSJt+zvdPll1F1ekc1SvCkJQthf3@vger.kernel.org
X-Gm-Message-State: AOJu0Yza+CxmM8vzJd0WHFA2OvwEY6iYMf2jkCeh/o3V9hdaSGMNIoW6
	vfe9h4IzinSA9+dRgLlN3ZNlNjObziNcYeGgjadU8sRzx0mQ/Oh5rUWw2QDFEzkxM6dLq6SbmRG
	nxv+q11xxUWZka7iSgrRs8aQHTExgC6A=
X-Gm-Gg: Acq92OE8S28KN6GW9+trvxNmY9U1M8ryze0f59pFed8wpnSFIxUehBBv06qyjNoxdJg
	ld1idkL8Axd1a+jyDj3zn1KTBiOK3Ttu937CxkfbeRnB2RAussxtGmLdagdlx+nFkC0TRqrWum4
	sLYRDxZLpgPsrre7UbGYGJ4d4v6KY6kOHa1KUHNYzt5bK0EwE2Gjxl+rE3D7+kBm24AU5l6Bza1
	WtsdS3JK499vTMun4DHcal51BVSsMxlsJyhXLssP7mdAX2HbOYjOXruPnl0jsb+E1lcmYQq07bU
	vqTpkxA7Gs5orEVpMI5qcEvqR1gDa/b4BosD0VdJ1fLgP7I4Lw==
X-Received: by 2002:a17:907:60d1:b0:bd8:fc89:cda0 with SMTP id
 a640c23a62f3a-bf3a8a0cdbamr1046510766b.24.1781102109492; Wed, 10 Jun 2026
 07:35:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529171840.2576445-1-mjguzik@gmail.com> <20260529171840.2576445-4-mjguzik@gmail.com>
 <CAEEQ3wngKZeWqwrsUfmtfgbzv+DK9TLWNsztCQ1FYdF3RQBSyg@mail.gmail.com>
In-Reply-To: <CAEEQ3wngKZeWqwrsUfmtfgbzv+DK9TLWNsztCQ1FYdF3RQBSyg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 10 Jun 2026 16:34:57 +0200
X-Gm-Features: AVVi8CczBCNIxwrAq3KLMkcV-i0uEvLI4M1VSqoSMmbN1QU77LdRIBDqp718e3U
Message-ID: <CAGudoHGgiZ_DvdyCCMOs24ejn2wvAJokC6ZEsRy6h2tJqD=rGw@mail.gmail.com>
Subject: Re: [External] [PATCH v4 3/3] fs: cache the string generated by
 reading /proc/filesystems
To: yunhui cui <cuiyunhui@bytedance.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 1:31=E2=80=AFPM yunhui cui <cuiyunhui@bytedance.com>=
 wrote:
>
> Hi Mateusz,
>
> On Sat, May 30, 2026 at 1:27=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com>=
 wrote:
> >
> > It is being read surprisingly often (e.g., by mkdir, ls and even sed!).
> >
> > This is lock-protected pointer chasing over a linked list to pay for
> > sprintf for every fs (32 on my boxen).
> >
> > Instead cache the result.
> >
> > While here make the file as permanent to avoid spurious ref trips in
> > procfs.
> >
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/filesystems.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 151 insertions(+), 2 deletions(-)
> >
> > diff --git a/fs/filesystems.c b/fs/filesystems.c
> > index 7976366d4197..673a03b5f32b 100644
> > --- a/fs/filesystems.c
> > +++ b/fs/filesystems.c
> > @@ -31,6 +31,36 @@
> >  static HLIST_HEAD(file_systems);
> >  static DEFINE_SPINLOCK(file_systems_lock);
> >
> > +#ifdef CONFIG_PROC_FS
> > +/*
> > + * Cache a stringified version of the filesystem list.
> > + *
> > + * The fs list gets queried a lot by userspace because of libselinux, =
including
> > + * rather surprising programs (would you guess *sed* is on the list?).=
 In order
> > + * to reduce the overhead we cache the resulting string, which normall=
y hangs
> > + * around below 512 bytes in size.
> > + *
> > + * As the list almost never changes, its creation is not particularly =
optimized
> > + * to keep things simple.
> > + *
> > + * We sort it out on read in order to not introduce a failure point fo=
r fs
> > + * registration (in principle we may be unable to alloc memory for the=
 list).
> > + */
> > +struct file_systems_string {
> > +       struct rcu_head rcu;
> > +       unsigned long gen;
> > +       size_t len;
> > +       char string[];
> > +};
> > +
> > +static unsigned long file_systems_gen;
> > +static struct file_systems_string __read_mostly __rcu *file_systems_st=
ring;
> > +
> > +static void invalidate_filesystems_string(void);
> > +#else
> > +static inline void invalidate_filesystems_string(void) { }
> > +#endif
> > +
> >  /* WARNING: This can be used only if we _already_ own a reference */
> >  struct file_system_type *get_filesystem(struct file_system_type *fs)
> >  {
> > @@ -80,6 +110,7 @@ int register_filesystem(struct file_system_type *fs)
> >         if (find_filesystem(fs->name, strlen(fs->name)))
> >                 return -EBUSY;
> >         hlist_add_tail_rcu(&fs->list, &file_systems);
> > +       invalidate_filesystems_string();
> >         return 0;
> >  }
> >  EXPORT_SYMBOL(register_filesystem);
> > @@ -101,6 +132,7 @@ int unregister_filesystem(struct file_system_type *=
fs)
> >                 if (hlist_unhashed(&fs->list))
> >                         return -EINVAL;
> >                 hlist_del_init_rcu(&fs->list);
> > +               invalidate_filesystems_string();
> >         }
> >         synchronize_rcu();
> >         return 0;
> > @@ -209,7 +241,100 @@ int __init list_bdev_fs_names(char *buf, size_t s=
ize)
> >  }
> >
> >  #ifdef CONFIG_PROC_FS
> > -static int filesystems_proc_show(struct seq_file *m, void *v)
> > +static void invalidate_filesystems_string(void)
> > +{
> > +       struct file_systems_string *old;
> > +
> > +       lockdep_assert_held_write(&file_systems_lock);
> > +       file_systems_gen++;
> > +       old =3D rcu_replace_pointer(file_systems_string, NULL,
> > +                          lockdep_is_held(&file_systems_lock));
> > +       if (old)
> > +               kfree_rcu(old, rcu);
> > +}
> > +
> > +static __cold noinline int regen_filesystems_string(void)
> > +{
> > +       struct file_system_type *p;
> > +       struct file_systems_string *old, *new;
> > +       size_t newlen, usedlen;
> > +       unsigned long gen;
> > +
> > +retry:
> > +       newlen =3D 0;
> > +
> > +       /* pre-calc space for each fs */
> > +       spin_lock(&file_systems_lock);
> > +       gen =3D file_systems_gen;
> > +       hlist_for_each_entry_rcu(p, &file_systems, list) {
> > +               if (!(p->fs_flags & FS_REQUIRES_DEV))
> > +                       newlen +=3D strlen("nodev");
> > +               newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n=
");
> > +       }
> > +       spin_unlock(&file_systems_lock);
> > +
> > +       new =3D kmalloc(offsetof(struct file_systems_string, string) + =
newlen + 1,
> > +                     GFP_KERNEL);
> > +       if (!new)
> > +               return -ENOMEM;
> > +
> > +       new->gen =3D gen;
> > +       new->len =3D newlen;
> > +       new->string[newlen] =3D '\0';
> > +
> > +       spin_lock(&file_systems_lock);
> > +       old =3D file_systems_string;
> > +
> > +       /*
> > +        * Did someone beat us to it?
> > +        */
> > +       if (old && old->gen =3D=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
>
>
>     It looks like linux-next still carries the older version of this patc=
h and
>     misses the unlock here:
>
>       if (old && old->gen =3D=3D file_systems_gen) {
>               kfree(new);
>               return 0;
>       }
>
>     The May 29 version has:
>       spin_unlock(&file_systems_lock);
>
>     before kfree(new), but that seems to be lost in linux-next.
>     Could you please check?
>

That's my bad. I got a response by Christian I failed to address, I'm
going to do it shortly.

> > +               kfree(new);
> > +               return 0;
> > +       }
> > +
> > +       /*
> > +        * Did the list change in the meantime?
> > +        */
> > +       if (gen !=3D file_systems_gen) {
> > +               spin_unlock(&file_systems_lock);
> > +               kfree(new);
> > +               goto retry;
> > +       }
> > +
> > +       /*
> > +        * Populate the string.
> > +        *
> > +        * We know we have just enough space because we calculated the =
right
> > +        * size the previous time we had the lock and confirmed the lis=
t has
> > +        * not changed after reacquiring it.
> > +        */
> > +       usedlen =3D 0;
> > +       hlist_for_each_entry_rcu(p, &file_systems, list) {
> > +               usedlen +=3D sprintf(&new->string[usedlen], "%s\t%s\n",
> > +                                  (p->fs_flags & FS_REQUIRES_DEV) ? ""=
 : "nodev",
> > +                                  p->name);
> > +       }
> > +
> > +       if (WARN_ON_ONCE(new->len !=3D strlen(new->string))) {
> > +               /*
> > +                * Should never happen of course, keep this in case som=
eone changes string
> > +                * generation above and messes it up.
> > +                */
> > +               spin_unlock(&file_systems_lock);
> > +               kfree(new);
> > +               return -EINVAL;
> > +       }
> > +
> > +       rcu_assign_pointer(file_systems_string, new);
> > +       spin_unlock(&file_systems_lock);
> > +       if (old)
> > +               kfree_rcu(old, rcu);
> > +       return 0;
> > +}
> > +
> > +static __cold noinline int filesystems_proc_show_fallback(struct seq_f=
ile *m, void *v)
> >  {
> >         struct file_system_type *p;
> >
> > @@ -222,9 +347,33 @@ static int filesystems_proc_show(struct seq_file *=
m, void *v)
> >         return 0;
> >  }
> >
> > +static int filesystems_proc_show(struct seq_file *m, void *v)
> > +{
> > +       struct file_systems_string *fss;
> > +
> > +       for (;;) {
> > +               scoped_guard(rcu) {
> > +                       fss =3D rcu_dereference(file_systems_string);
> > +                       if (likely(fss)) {
> > +                               seq_write(m, fss->string, fss->len);
> > +                               return 0;
> > +                       }
> > +               }
> > +
> > +               int err =3D regen_filesystems_string();
> > +               if (unlikely(err))
> > +                       return filesystems_proc_show_fallback(m, v);
> > +       }
> > +}
> > +
> >  static int __init proc_filesystems_init(void)
> >  {
> > -       proc_create_single("filesystems", 0, NULL, filesystems_proc_sho=
w);
> > +       struct proc_dir_entry *pde;
> > +
> > +       pde =3D proc_create_single("filesystems", 0, NULL, filesystems_=
proc_show);
> > +       if (!pde)
> > +               return -ENOMEM;
> > +       proc_make_permanent(pde);
> >         return 0;
> >  }
> >  module_init(proc_filesystems_init);
> > --
> > 2.48.1
> >
> >
>
> Thanks,
> Yunhui
