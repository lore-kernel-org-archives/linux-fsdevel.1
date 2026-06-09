Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8505029B77E
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Jun 2026 11:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781004668; cv=pass; b=YfV1y5adpvbJFVn9GG1tTCwoXH8bcKVYLXFGlEC7QR56kNtsdtNL61+5lrfNT5AujbRWVrkQ87Ha6xeUQKzHd5R5RPmiUubjTJl3wmIKPHavpJlagTS+zZf5hGjaNRWr31Xpl5rDZjHxI5ldmWWzrS0jFZJH4NA0UPhcPuho1Uk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781004668; c=relaxed/simple;
	bh=d385IPpTzIJe6D+xp2bdJE2iH3QyCAEGFpRZjYWMx28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N79Cv2eE1KThfRUoTFxtNcby/ISmfY/03f4wuV/Xe6PjbnMBc9FAsBtFs5Jg00ZNJv4NtyUekLg8C6ZOJF4vToiMAlh+360ggWVouvgS3Ptn8ljx4xUB2NY+hHnHwuM3jDAnIMxM/tpgs4woivEOOLCMtLOLRnNq5gWBBlKMHEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WhpJsext; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WhpJsext"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-486d0e175e9so1254188b6e.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 09 Jun 2026 04:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781004664; cv=none;
        d=google.com; s=arc-20240605;
        b=DYNKZIf1o1px/a5ALdjeGcs5u1iwdBELi7uDEZP8PP2k6fVTfbl29sscyU5lzKjAAW
         v850E5KbcJLDO0CeUOWloyFcbUCARCs1leBvGCT2u2j5Ts1Ed0U2GAq3O41c02ScZN47
         k+Rw7sjT6RFX4C9VqowYzb40E0c7mVKlin8oEkIzyNn+Wg8sIBH5tB4YuL1RQ9LNIvNR
         SmgD81We2k7BJQI9gHDlNGUsXQWJQ1iHH6F+EF9sHTfDAl80Q/R4hGQjT1ArTsui9RDb
         5YQ541SWNUqDZ+I44k8UW2pSVIcl1JiGw85v39yMPLhTr3fTuqxjNnHs38UPQuYtPoHl
         TeFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/H8eyhrFMSakgaeXHGtZPU1vWRDSYVCOhpmDrZD9vmU=;
        fh=lb+xnhEkUZLyJBtvsXBczimlBPPu+bZ2lXq/0hEALRk=;
        b=EV4AQl7cvZmqoS6baGZst9WYJS7F4XbbuMwUxpi8qUnCPL2xqqVyz6YqWA3piuht51
         SIPI1PHTa5Y5KKpqeNtRBw8mdWgcOMnI2tOrT9iIBK9ktC/fXFf56zmqAfbQc8cPgBof
         uvkPjPDio3fitxXQOZfioHSCfZRUCvR5zs9F/7sxiNUoaaFBcl/mKgov4s3UREIQSYah
         YIpO0lW5u9NdxBb9Ay8zk0wsVRgB8uA5ciGaqmBJBDyIW8waIFKNmOaXmOonkHi3cBHH
         vz/EHJrTjAqkQ7DNQZmBldoBvDMjc1gIQdAf0P1rN1qaA4Jb6mo+RhMNK44QZPul1Nc5
         JrwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1781004664; x=1781609464; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/H8eyhrFMSakgaeXHGtZPU1vWRDSYVCOhpmDrZD9vmU=;
        b=WhpJsextW/dynX897C040KVlHRvbwcVQCHU+mJb4TuV9FHaS/eIMKIyHPGcFfkth06
         Ua8UOPtI88X3619wmzLMWP3OpJuFVhR+7wprUGFO6HUjlMyQ3Md5Us9fOGZZvvdbM8YH
         ld1DKLDEYgmsKXmETKWDpx92+x6B/gW5XcTEhDxOUmCL5luiiQjD825Ta9xLa4ibwhjC
         mSqkvXxgNQlWbj15sE3aM3Kc/aAipTh9GLKm2/rTVf80GpN1O3xBwsEWNevZw8HUoXqC
         Xd/NSYsmRnPC24Y+WbhQGmMPiOCjVi6PLCAJ6GIlXykYf7InjSy+7m93MLMy+lORVCRL
         ZHOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781004664; x=1781609464;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/H8eyhrFMSakgaeXHGtZPU1vWRDSYVCOhpmDrZD9vmU=;
        b=mOnUrnuWvXCJEWApJVwUkt1oWsKahlNQKGOr9tQdZVjkjavVKB+EVKrxYTcDZ+0IKX
         jwsQyAXS/7iTi5mhiRZuxED90egGgVEu/Tn2ugLDm0gn6JbJaGNfZAL2h7JIayjAVASt
         pS0v4MjYM4JkCr7qDzmQKuGbd7TZZ3sXqyrLRdideI1GvhZIndi1k95+eIOfoWaVakiD
         Hf80h1CiqwChAMKMXeaPYCRfMNrCJJmppiy67LE54q5UxCrMKt407InQIfD049vlxOQ+
         cjzifGY1X29Ohp6trYcbJ+6MwKOR6Mx5D/bvGNqL9AY5jL456l5/9uY6gLs15bqVfB6n
         bQiQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6v2wlIzH3qsvD9bbzrtTwi5BktdsekzaTFuB78dIer0bdXOtTAd4IZdg0SiWMDwNrTkiUVA1adZHOtJhB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+vks3CLYqSHKweYuNYGC18rm09IQW90NsDgumwXwjVYNdmvR1
	Vk+qDWUwdczE0UfZvDBgHbrhh4wkbAJDc6K/4au/UykBmsusorfHY2YS6etPt+OzrwSGxHa5jk3
	CvqDhDmBnKUnAmqOFRdXGT4YgFP8cSqt1E2cLR0yB4Q==
X-Gm-Gg: Acq92OFuxuty4COHrZLIvcZrv9hzTupL26j6yes7DGUoUh4bxuF7Je3j9Ejv/7ywyoC
	+lQGlaaHfgaNvR3TBN/0VZ2AB70ryWVhb3MSYZUA89+qi2Hn8UCMvWa5w98nHCqzkVdnW1TzkDU
	LsDT59Z/P0a2G9qUp6ABqWyiO4Ym7XutLcbNZdLGQuUZ+GRfS+MavLLrP3BZSin5IgiWjUxHDWL
	d+fJhVkMk3MJ4kQbYO6dTg27tDY4938eEuakIRW/FCWRjsrMlfCJTe4E4vmnxWK8ca9SuKKDk4E
	C4SDf9LZPjCf5BDhD1YB
X-Received: by 2002:a05:6808:6901:b0:47b:ccf2:91e1 with SMTP id
 5614622812f47-4868dcb822cmr12213420b6e.21.1781004664265; Tue, 09 Jun 2026
 04:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529171840.2576445-1-mjguzik@gmail.com> <20260529171840.2576445-4-mjguzik@gmail.com>
In-Reply-To: <20260529171840.2576445-4-mjguzik@gmail.com>
From: yunhui cui <cuiyunhui@bytedance.com>
Date: Tue, 9 Jun 2026 19:30:51 +0800
X-Gm-Features: AVVi8CfTUoR19-B96nyn3nnKxIKJTprbNoUGYqec0oF6EXUwjA7O5-dZ5G9ZXTI
Message-ID: <CAEEQ3wngKZeWqwrsUfmtfgbzv+DK9TLWNsztCQ1FYdF3RQBSyg@mail.gmail.com>
Subject: Re: [External] [PATCH v4 3/3] fs: cache the string generated by
 reading /proc/filesystems
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	adobriyan@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mateusz,

On Sat, May 30, 2026 at 1:27=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> w=
rote:
>
> It is being read surprisingly often (e.g., by mkdir, ls and even sed!).
>
> This is lock-protected pointer chasing over a linked list to pay for
> sprintf for every fs (32 on my boxen).
>
> Instead cache the result.
>
> While here make the file as permanent to avoid spurious ref trips in
> procfs.
>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/filesystems.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 151 insertions(+), 2 deletions(-)
>
> diff --git a/fs/filesystems.c b/fs/filesystems.c
> index 7976366d4197..673a03b5f32b 100644
> --- a/fs/filesystems.c
> +++ b/fs/filesystems.c
> @@ -31,6 +31,36 @@
>  static HLIST_HEAD(file_systems);
>  static DEFINE_SPINLOCK(file_systems_lock);
>
> +#ifdef CONFIG_PROC_FS
> +/*
> + * Cache a stringified version of the filesystem list.
> + *
> + * The fs list gets queried a lot by userspace because of libselinux, in=
cluding
> + * rather surprising programs (would you guess *sed* is on the list?). I=
n order
> + * to reduce the overhead we cache the resulting string, which normally =
hangs
> + * around below 512 bytes in size.
> + *
> + * As the list almost never changes, its creation is not particularly op=
timized
> + * to keep things simple.
> + *
> + * We sort it out on read in order to not introduce a failure point for =
fs
> + * registration (in principle we may be unable to alloc memory for the l=
ist).
> + */
> +struct file_systems_string {
> +       struct rcu_head rcu;
> +       unsigned long gen;
> +       size_t len;
> +       char string[];
> +};
> +
> +static unsigned long file_systems_gen;
> +static struct file_systems_string __read_mostly __rcu *file_systems_stri=
ng;
> +
> +static void invalidate_filesystems_string(void);
> +#else
> +static inline void invalidate_filesystems_string(void) { }
> +#endif
> +
>  /* WARNING: This can be used only if we _already_ own a reference */
>  struct file_system_type *get_filesystem(struct file_system_type *fs)
>  {
> @@ -80,6 +110,7 @@ int register_filesystem(struct file_system_type *fs)
>         if (find_filesystem(fs->name, strlen(fs->name)))
>                 return -EBUSY;
>         hlist_add_tail_rcu(&fs->list, &file_systems);
> +       invalidate_filesystems_string();
>         return 0;
>  }
>  EXPORT_SYMBOL(register_filesystem);
> @@ -101,6 +132,7 @@ int unregister_filesystem(struct file_system_type *fs=
)
>                 if (hlist_unhashed(&fs->list))
>                         return -EINVAL;
>                 hlist_del_init_rcu(&fs->list);
> +               invalidate_filesystems_string();
>         }
>         synchronize_rcu();
>         return 0;
> @@ -209,7 +241,100 @@ int __init list_bdev_fs_names(char *buf, size_t siz=
e)
>  }
>
>  #ifdef CONFIG_PROC_FS
> -static int filesystems_proc_show(struct seq_file *m, void *v)
> +static void invalidate_filesystems_string(void)
> +{
> +       struct file_systems_string *old;
> +
> +       lockdep_assert_held_write(&file_systems_lock);
> +       file_systems_gen++;
> +       old =3D rcu_replace_pointer(file_systems_string, NULL,
> +                          lockdep_is_held(&file_systems_lock));
> +       if (old)
> +               kfree_rcu(old, rcu);
> +}
> +
> +static __cold noinline int regen_filesystems_string(void)
> +{
> +       struct file_system_type *p;
> +       struct file_systems_string *old, *new;
> +       size_t newlen, usedlen;
> +       unsigned long gen;
> +
> +retry:
> +       newlen =3D 0;
> +
> +       /* pre-calc space for each fs */
> +       spin_lock(&file_systems_lock);
> +       gen =3D file_systems_gen;
> +       hlist_for_each_entry_rcu(p, &file_systems, list) {
> +               if (!(p->fs_flags & FS_REQUIRES_DEV))
> +                       newlen +=3D strlen("nodev");
> +               newlen +=3D strlen("\t") + strlen(p->name) + strlen("\n")=
;
> +       }
> +       spin_unlock(&file_systems_lock);
> +
> +       new =3D kmalloc(offsetof(struct file_systems_string, string) + ne=
wlen + 1,
> +                     GFP_KERNEL);
> +       if (!new)
> +               return -ENOMEM;
> +
> +       new->gen =3D gen;
> +       new->len =3D newlen;
> +       new->string[newlen] =3D '\0';
> +
> +       spin_lock(&file_systems_lock);
> +       old =3D file_systems_string;
> +
> +       /*
> +        * Did someone beat us to it?
> +        */
> +       if (old && old->gen =3D=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);


    It looks like linux-next still carries the older version of this patch =
and
    misses the unlock here:

      if (old && old->gen =3D=3D file_systems_gen) {
              kfree(new);
              return 0;
      }

    The May 29 version has:
      spin_unlock(&file_systems_lock);

    before kfree(new), but that seems to be lost in linux-next.
    Could you please check?

> +               kfree(new);
> +               return 0;
> +       }
> +
> +       /*
> +        * Did the list change in the meantime?
> +        */
> +       if (gen !=3D file_systems_gen) {
> +               spin_unlock(&file_systems_lock);
> +               kfree(new);
> +               goto retry;
> +       }
> +
> +       /*
> +        * Populate the string.
> +        *
> +        * We know we have just enough space because we calculated the ri=
ght
> +        * size the previous time we had the lock and confirmed the list =
has
> +        * not changed after reacquiring it.
> +        */
> +       usedlen =3D 0;
> +       hlist_for_each_entry_rcu(p, &file_systems, list) {
> +               usedlen +=3D sprintf(&new->string[usedlen], "%s\t%s\n",
> +                                  (p->fs_flags & FS_REQUIRES_DEV) ? "" :=
 "nodev",
> +                                  p->name);
> +       }
> +
> +       if (WARN_ON_ONCE(new->len !=3D strlen(new->string))) {
> +               /*
> +                * Should never happen of course, keep this in case someo=
ne changes string
> +                * generation above and messes it up.
> +                */
> +               spin_unlock(&file_systems_lock);
> +               kfree(new);
> +               return -EINVAL;
> +       }
> +
> +       rcu_assign_pointer(file_systems_string, new);
> +       spin_unlock(&file_systems_lock);
> +       if (old)
> +               kfree_rcu(old, rcu);
> +       return 0;
> +}
> +
> +static __cold noinline int filesystems_proc_show_fallback(struct seq_fil=
e *m, void *v)
>  {
>         struct file_system_type *p;
>
> @@ -222,9 +347,33 @@ static int filesystems_proc_show(struct seq_file *m,=
 void *v)
>         return 0;
>  }
>
> +static int filesystems_proc_show(struct seq_file *m, void *v)
> +{
> +       struct file_systems_string *fss;
> +
> +       for (;;) {
> +               scoped_guard(rcu) {
> +                       fss =3D rcu_dereference(file_systems_string);
> +                       if (likely(fss)) {
> +                               seq_write(m, fss->string, fss->len);
> +                               return 0;
> +                       }
> +               }
> +
> +               int err =3D regen_filesystems_string();
> +               if (unlikely(err))
> +                       return filesystems_proc_show_fallback(m, v);
> +       }
> +}
> +
>  static int __init proc_filesystems_init(void)
>  {
> -       proc_create_single("filesystems", 0, NULL, filesystems_proc_show)=
;
> +       struct proc_dir_entry *pde;
> +
> +       pde =3D proc_create_single("filesystems", 0, NULL, filesystems_pr=
oc_show);
> +       if (!pde)
> +               return -ENOMEM;
> +       proc_make_permanent(pde);
>         return 0;
>  }
>  module_init(proc_filesystems_init);
> --
> 2.48.1
>
>

Thanks,
Yunhui
