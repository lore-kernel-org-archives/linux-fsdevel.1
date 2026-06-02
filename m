Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BB3126DA
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780406383; cv=pass; b=D+ClOynkuuiiSd1taa952y7fGg602c1b5kJDkz9q8V5ysHQdGDmBQAYdNoPkowcdDouhsdRcCLaUGwaqewuO06ouvlP7tRqt8gBFrBuY7VdnkdF4acbptsHOP/D1Q9hM4BOj5BYmk6snEx9Se5YxiwlX5IdtgRhZNfwaVGgc4u8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780406383; c=relaxed/simple;
	bh=wCxl3Tv5UjAXMqr4HJPAJZZ1uOkzj847bzegkTtgaHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uj1lA61VnmQ8WYW95wb5U7cVOysbbB8AFwHCNAYQj2O00h6TVnWq8UYeZdDMU73aAq2KqSl8PvSRTaRbX0olWFCbz/2SSBT4aHWCB+9suUDwRy+b4LBW3HHvkrfA3SvLM26AiOR8dEeWy965ssd4DgjweEb+9W61cWOAbfZPzdE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWuGeBG9; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWuGeBG9"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68d232ed3f9so3715488a12.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 Jun 2026 06:19:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780406380; cv=none;
        d=google.com; s=arc-20240605;
        b=YYbT6W96OQy4WIXf1LhhO1MaBUAvgOHlds5Oyqg0hlTsSfs3JOv0h/ijNGOnTp9CAw
         vlQi9eJ4rVApO5V2/w5jmTQpJH6TnSH4WzeYgJFo+xzLaBBzcpefEj6i5w7tyvvnSPQA
         SFM/Q+EfDtXpXl7i220/QO/Z8tCH6Gpfya6IaQhXUI6gICuV2nRT4yFTCMQvQut82oPU
         h+zoZmcIuayPYQRtFzkgalXRI6l0EAuZ0lpjr9wSFtKDuagCaGdDrTDXVPWPpeYt13MH
         FyzKji7pC3UhvIlwYIsueBJxJjSgwbtybL1FUzrMFShl6aMYbDbAp4HsY2t5PQ+qtOb/
         l/lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8rjbJa8Kn9TlrFytgVrTzNTVTXWd8OqV67XJq4KirFg=;
        fh=589AcXvySXOkqIf9fPx/apIi47hs1S14ubQa+FDom4k=;
        b=cmUVWafx7I2u/kmbsTAEO+52VDL7iYlp1soaQhRDC3Ezt92btCQh+PsNH9PdQkWfb8
         DV+MZPaMgC3MTk9xTgPYb+KxG8Ckd9HUTKTg1/wJlb3ZXbQx4761UKnhH0VojkY5ZEAj
         RdYRD9Ex3EiCBU2DEOMPH5Zx5pIUtT2eaPsTlWUFj7CdwGnl1SvOxM5z5KBBDjfFRHbP
         skpCAXoYPCKYlsWhqBEuH1cr+ic+w94YfCymq4pEnBvjG96plJ/pbPZ9vd0Wpm6tqvkn
         Y3VGU5R501+p/g4NowOSho1E/3SHWGyMu7lnJon99oOt6ma6hIl24dSGiEOIw66X+EJT
         X9/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780406380; x=1781011180; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rjbJa8Kn9TlrFytgVrTzNTVTXWd8OqV67XJq4KirFg=;
        b=HWuGeBG9fuu9ZS+l81Z0c4zq9tZl5RuCiedVPRANyvapAcF5N4lfvV/wfvUbIacHkg
         3JigZxbREEYBm5NW0ZHDxHi8bwLEH2EUNEPsNSxYzDxDU//3O/nXJMgD0SjHW6+1hKa1
         l1fVcnDSqK1NBX+L/cuUczkVHghyaXu71yxi+oY55i4mMbVJIwEnZtdyw63YIfFUzCzV
         LumnBuNlENXqBctxeVxpJRWk1DQR17mv/gra7blK2qmqbq+8P2h7FYt+xNkmo/TM4IAy
         lua7FmodcZVX8Tq7cSHpElUUpYy9i6fd+5KH0mgX9astK9Ia7zvCXEeFpAVcSN4MuTuE
         rj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780406380; x=1781011180;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rjbJa8Kn9TlrFytgVrTzNTVTXWd8OqV67XJq4KirFg=;
        b=D4w0nwROpee19y2Cz3zQ49G9SyEkAFgRyOYtQRdAlFciWD33ZM8ODURxqa7ukP/z36
         /YF/YmsshIXnEeByctGvU/7yQM8J1Rnyy9M16Mqx5ug9YIa0p9k9fp1ii7mfcwynFJNP
         zRdpYQjzsyPKz0I53RQ893xdrIi7b81xZsUZl4zhK3wJqAS5HTyNLx/0ZZI7huAqrVan
         LpFKs/mwpqDB4knwG7H79MMV5nhhORKqDUuCYZ4Wq9ipGfdRqRF033ft8s+TwJKfVNrl
         z1XSdtOlKIflkXHtMP+NYODJaKWQNljYU5M41DibXUEvbDCDX0encMabho3subDXxwX4
         CDuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/XtwBEgXPetVj6ftsJsvY1GIrKg01Fc8U4rcHPhpvMTak0G5COUB7Kaziyih+QszhnrzPs3/MYFoeLs9F4@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9koEPcgKIcgOHXBxkBxQA1npiztD+ogjXGh/qgCtgba8hPez3
	ZCpN7Dh00ZmM0rfz3F+a3n1NMBzn+d6/T9klahamjlJYVqYZc/wF3ZOInqsDYDrAajan9WzyU0Z
	mijIhrZRjQD18NfPRcBjt32EaiXcnzak=
X-Gm-Gg: Acq92OEEnuWjwtjRhvyeAt64/+sMgoYqFlm3D5Dzgbw53y4eW2a8/vbXKFrpYGv7/ZJ
	RGCbnQQocHop0ni9Knjtco6Tahd4FI1BjMNjv4Jc4TwBO78tFL4i79+ACDLoeXZwdxoua7YKcV8
	RFfUMvbsTqUmXTIC4OIVH/FTLQ/LW6tO/wfP5CYdFGNSFF5C0/NGemMqDzd3upMIGpDlrtxSvsi
	lPEH0ZnDSJhnupapRCFOhDihHk/Y1p5ZDjamIcE9g+1Mgklhe67XSIETgQwiTi5k02ykwkJS0vS
	kPzaf+6hDEEv6tNK2oCPdzC/5ubVIyiftFUq0P3YkEV4o8s8cPVn
X-Received: by 2002:a05:6402:2229:b0:68d:d511:4a9f with SMTP id
 4fb4d7f45d1cf-68dd5114b33mr1788366a12.18.1780406379615; Tue, 02 Jun 2026
 06:19:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601152327.2069787-1-mszeredi@redhat.com>
In-Reply-To: <20260601152327.2069787-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 2 Jun 2026 15:19:25 +0200
X-Gm-Features: AVHnY4KPVnp-WT8Jv_R53L_1c_C15mvkn6Hl2hOzr3Ve-0D31NGovzZ2qY99zM8
Message-ID: <CAOQ4uxjFg4rjwGjU2LvZT6AhC+gBk_6Ej5S4p4DKuk8=a71cRw@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_FAMFS_EXT_INTERLEAVE -> FUSE_DEV_IOC_STRIPE_OPEN
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: John Groves <jgroves@micron.com>, "Darrick J . Wong" <djwong@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 5:40=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com>=
 wrote:
>
> Add striped "virtual" backing devices (idea from Darrick).
>
> This decouples interleaving from extents, since the interleaving is
> configured on the striped backing device, while simple extents select whi=
ch
> striped device is to be used and the length/offset within that virtual
> device.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>
> This is the second part of what we were talking about: using the backing
> API for striping.
>
> It's on top of the famfs-v10 patchset + the FUSE_BACKING_DAXDEV patch
>
> Totally Untested (TM).
>
> The third part will be to use the fuse-iomap uAPI (and just the API, not
> any of the code) from Darrick to describe the simple extents themselves.
>
> And that should be it.  Just some review and testing and I'll be happy to
> move this into fuse-next.

Yey :)

This looks very nice!

I hope it meets John's technical requirements.

>
> Thanks,
> Miklos
>
>  fs/fuse/backing.c         | 108 +++++++++-----
>  fs/fuse/dev.c             |  38 +++++
>  fs/fuse/famfs.c           | 296 +++++++++-----------------------------
>  fs/fuse/famfs_kfmap.h     |  25 +---
>  fs/fuse/fuse_i.h          |  23 ++-
>  include/uapi/linux/fuse.h |  29 ++--
>  6 files changed, 219 insertions(+), 300 deletions(-)
>
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index e56b7f8d5d2b..d680a01c9f38 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -37,14 +37,14 @@ void fuse_backing_files_init(struct fuse_conn *fc)
>         idr_init(&fc->backing_files_map);
>  }
>
> -int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj)
> +int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backing_comm=
on *backing)
>  {
>         int id;
>
>         idr_preload(GFP_KERNEL);
>         spin_lock(&fc->lock);
>         /* FIXME: xarray might be space inefficient */
> -       id =3D idr_alloc_cyclic(&fc->backing_files_map, obj, 1, 0, GFP_AT=
OMIC);
> +       id =3D idr_alloc_cyclic(&fc->backing_files_map, backing, 1, 0, GF=
P_ATOMIC);

Darrick's iomap patches have the range determined by the backing ops.

Considering that John wants the daxdev ids to be allocated by userspace
I suppose the number of daxdev ids is limited, same as with iomap
backing devs, so we could probably start allocating backing stripes
from max_daxdevs (1000?), to be negotiated at init time.


>         spin_unlock(&fc->lock);
>         idr_preload_end();
>
> @@ -52,33 +52,43 @@ int fuse_backing_id_alloc(struct fuse_conn *fc, void =
*obj)
>         return id;
>  }
>
> -static struct fuse_backing *fuse_backing_id_remove(struct fuse_conn *fc,
> -                                                  int id)
> +static void fuse_backing_file_free(struct fuse_backing_common *backing)
>  {
> -       struct fuse_backing *fb;
> +       struct fuse_backing *fb =3D container_of(backing, typeof(*fb), ba=
cking);
>
> -       spin_lock(&fc->lock);
> -       fb =3D idr_remove(&fc->backing_files_map, id);
> -       spin_unlock(&fc->lock);
> +       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> +       fuse_backing_free(fb);
> +}
>
> -       return fb;
> +static void fuse_stripe_free(struct fuse_backing_common *backing)
> +{
> +       struct fuse_backing_stripe *bstripe =3D container_of(backing, typ=
eof(*bstripe), backing);
> +
> +       kfree(bstripe->stripe);
> +       kfree(bstripe);
>  }
>
>  static int fuse_backing_id_free(int id, void *p, void *data)
>  {
> -       struct fuse_backing *fb =3D p;
> -
> -       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> -       fuse_backing_free(fb);
> +       struct fuse_backing_common *backing =3D p;
> +
> +        switch (backing->type) {
> +       case FUSE_BCK_FILE:
> +               fuse_backing_file_free(backing);
> +               break;
> +       case FUSE_BCK_DAXDEV:
> +               famfs_devidx_free(backing);
> +               break;
> +       case FUSE_BCK_STRIPE:
> +               fuse_stripe_free(backing);
> +               break;
> +       }
>         return 0;
>  }
>
>  void fuse_backing_files_free(struct fuse_conn *fc)
>  {
> -       if (fc->famfs_iomap)
> -               famfs_teardown(fc);
> -       else
> -               idr_for_each(&fc->backing_files_map, fuse_backing_id_free=
, NULL);
> +       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
>         idr_destroy(&fc->backing_files_map);
>  }
>
> @@ -130,11 +140,12 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>         if (!fb)
>                 goto out_fput;
>
> +       fb->backing.type =3D FUSE_BCK_FILE;
>         fb->file =3D file;
>         fb->cred =3D prepare_creds();
>         refcount_set(&fb->count, 1);
>
> -       res =3D fuse_backing_id_alloc(fc, fb);
> +       res =3D fuse_backing_id_alloc(fc, &fb->backing);
>         if (res < 0) {
>                 fuse_backing_free(fb);
>                 fb =3D NULL;
> @@ -150,30 +161,54 @@ int fuse_backing_open(struct fuse_conn *fc, struct =
fuse_backing_map *map)
>         goto out;
>  }
>
> +int fuse_stripe_open(struct fuse_conn *fc, struct fuse_stripe *stripe)
> +{
> +       int res;
> +       struct fuse_backing_stripe *bstripe __free(kfree) =3D kmalloc_obj=
(*bstripe);
> +
> +       if (!bstripe)
> +               return -ENOMEM;
> +
> +       bstripe->backing.type =3D FUSE_BCK_STRIPE;
> +       bstripe->stripe =3D stripe;
> +
> +       res =3D fuse_backing_id_alloc(fc, &bstripe->backing);
> +       if (res >=3D 0)

0 is reserved, it cannot be allocated

(for daxdev userspace should be able to assign id 0 if needed)

> +               retain_and_null_ptr(bstripe);
> +
> +       return res;
> +}
> +
>  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
>  {
> +       struct fuse_backing_common *backing;
>         struct fuse_backing *fb =3D NULL;
>         int err;
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
> -       /* No close for dax device (yet) */
> -       if (fc->famfs_iomap)
> -               return -EINVAL;
> -
> -       /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> -       err =3D -EPERM;
> -       if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> -               goto out;
> -
>         err =3D -EINVAL;
>         if (backing_id <=3D 0)
>                 goto out;
>
> -       err =3D -ENOENT;
> -       fb =3D fuse_backing_id_remove(fc, backing_id);
> -       if (!fb)
> -               goto out;
> +       scoped_guard(spinlock, &fc->lock) {
> +               err =3D -ENOENT;
> +               backing =3D idr_find(&fc->backing_files_map, backing_id);
> +               if (!backing)
> +                       goto out;
> +               err =3D -EINVAL;
> +               if (backing->type !=3D FUSE_BCK_FILE)
> +                       goto out;
> +
> +               fb =3D container_of(backing, typeof(*fb), backing);
> +
> +               /* TODO: relax CAP_SYS_ADMIN once backing files are visib=
le to lsof */
> +               err =3D -EPERM;
> +               if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> +                       goto out;
> +
> +               WARN_ON(idr_remove(&fc->backing_files_map, backing_id) !=
=3D backing);
> +       }
>
>         fuse_backing_put(fb);
>         err =3D 0;
> @@ -185,14 +220,13 @@ int fuse_backing_close(struct fuse_conn *fc, int ba=
cking_id)
>
>  struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id)
>  {
> -       struct fuse_backing *fb;
> -
> -       if (fc->famfs_iomap)
> -               return NULL;
> +       struct fuse_backing_common *backing;
> +       struct fuse_backing *fb =3D NULL;
>
>         rcu_read_lock();
> -       fb =3D idr_find(&fc->backing_files_map, backing_id);
> -       fb =3D fuse_backing_get(fb);
> +       backing =3D idr_find(&fc->backing_files_map, backing_id);
> +       if (backing && backing->type =3D=3D FUSE_BCK_FILE)
> +               fb =3D fuse_backing_get(container_of(backing, typeof(*fb)=
, backing));
>         rcu_read_unlock();
>
>         return fb;
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 0b0241f47170..dd80a174124d 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -2636,6 +2636,41 @@ static long fuse_dev_ioctl_backing_open(struct fil=
e *file,
>         return fuse_backing_open(fud->fc, &map);
>  }
>
> +
> +static long fuse_dev_ioctl_stripe_open(struct file *file, struct fuse_st=
ripe __user *argp)
> +{
> +       struct fuse_dev *fud =3D fuse_get_dev(file);
> +       struct fuse_stripe hdr;
> +       size_t size;
> +       int backing_id;
> +
> +       if (IS_ERR(fud))
> +               return PTR_ERR(fud);
> +
> +       if (!IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> +               return -EOPNOTSUPP;
> +
> +       if (copy_from_user(&hdr, argp, sizeof(hdr)))
> +               return -EFAULT;
> +
> +       if (hdr.nr_strips > FUSE_STRIPS_MAX)
> +               return -EINVAL;
> +
> +       size =3D offsetof(struct fuse_stripe, strips[hdr.nr_strips]);
> +       struct fuse_stripe *stripe __free(kfree) =3D kmalloc(size, GFP_KE=
RNEL_ACCOUNT);
> +       if (!stripe)
> +               return -ENOMEM;
> +
> +       if (copy_from_user(stripe, argp, size))
> +               return -EFAULT;
> +
> +       backing_id =3D fuse_stripe_open(fud->fc, stripe);
> +       if (backing_id >=3D 0)

Again not sure about 0

> +               retain_and_null_ptr(stripe);
> +
> +       return backing_id;
> +}
> +
>  static long fuse_dev_ioctl_backing_close(struct file *file, __u32 __user=
 *argp)
>  {
>         struct fuse_dev *fud =3D fuse_get_dev(file);
> @@ -2678,6 +2713,9 @@ static long fuse_dev_ioctl(struct file *file, unsig=
ned int cmd,
>         case FUSE_DEV_IOC_BACKING_OPEN:
>                 return fuse_dev_ioctl_backing_open(file, argp);
>
> +       case FUSE_DEV_IOC_STRIPE_OPEN:
> +               return fuse_dev_ioctl_stripe_open(file, argp);
> +
>         case FUSE_DEV_IOC_BACKING_CLOSE:
>                 return fuse_dev_ioctl_backing_close(file, argp);
>
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index c49362d19b36..043b451c3584 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c

I will leave it to John to review the famfs side of things.

Thanks,
Amir.
