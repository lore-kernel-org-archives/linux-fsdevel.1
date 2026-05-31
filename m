Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4102638E5FE
	for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780248978; cv=pass; b=pKoeGhe0N4wmpKXT4t9QL7its2atThAkG0q9VUDmFurNms9w9n7cavft62Toq56SvpgQvlnjrq60csYfoVDXJX6CkEgBK2MlY+pwWTxjcqDfiwdqr6iUO55QNGRmo8DV+TZXknb6AxHcd9w/l8tUo4J62pAuQmk3NInP9fTFwoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780248978; c=relaxed/simple;
	bh=L+RpcWU8SqSM4MzyDOoivyuuwjczw2O7Y2yCW7MKX+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG2VWyBoD2Do/b8Xwjso82FdW6wbAbPGIysaDajKmrVlHjqjv42E+jMdy+OhRq2T7j5+rYrm39UtVDCk12DTTZHHb/OpHl3VxE6nUqiDahKZ5MdAaHTUoqAmzYfXE8D8NnBUWh07iqV9McUbDIEkkHqb9SV1o8t3X5ys35ajo4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJrM5qWT; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJrM5qWT"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so4119993a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 31 May 2026 10:36:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780248975; cv=none;
        d=google.com; s=arc-20240605;
        b=T34xpHI424kruoObsQX2E6R8JI9k7KK9Atfu/I+yRvSABYcDaL3pFGse4JyTFl9X8F
         0UfpzyRotzE7dY1G/uePyd2W3FIbb3Zdaby9BwdkskDD+17mdk4L5Ap+xJ88iNEeWKjA
         3XYw66zd7ctG+1ru+DQzwhhqfkB09Xdo4hLBjjRCYFrFdCot/WVRrCSkmmRbOH2l4DNT
         C0Iq+n6x4YZnW/UUg1BJeQXhNvgyfm75iokBLiLiZYvt7wFesR+KbV9W87fF9/ihxx+z
         r0kCnIM7vV15S9FWpHYTwV//HTXfuCVflWFA7sbw7pVeANBLSfIASmfJGpaljc6usx0q
         S7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CCuX+JyCcas6C2sIklDs3Y6lQ4InyYy6BkSo/VLcEG4=;
        fh=HWV2GXSY5EztsOk7X4LfqqprJKQzYDS8WEcViOofwGs=;
        b=BwEGNQf7v7hLF46NdQANAa9QaijMbzGLJ4bcO9uLxEmHmwftYj8RXoWvnaTeJ3DdOa
         2VSgjBiErqpnVISoMY3l6xLGQc9ts3kXDu4OW40yG3B3lLvvMemjQZq1ZBj7uCgf2nkS
         5WhVD9b71Lrlp/pqw8s9SodL3+wWrhH4yRrl7tdWrd0XZNK2IQENuZ+BbJt1NISYW3Md
         Y9kDnzKjVLISWPIv8CdL5m5Z38MDvVkGY9a7mWUYzzYqCBlXUufxr2wLHAFovGkR/B+q
         wLWA/Fic/gk68XpQd/fopBbMPdJ5rVv+4tkAn7LuowUV7PxmIRMY9zy81jjZtLbE7FzU
         S2xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780248975; x=1780853775; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CCuX+JyCcas6C2sIklDs3Y6lQ4InyYy6BkSo/VLcEG4=;
        b=cJrM5qWTXDry4z7AA6kuYH2diFbGHn7lUKgNHJ6ChuIPWe/z0d9PQd7T4mUdGU/yUg
         c5dy9GewAGJUtJwRGbA6qbZnbVmd1bpHwwNJlKRN8b68bup5OYWwY0p/8pCW5anTsUpV
         N7ekwtWCnl2EHm4gtbvIhqAMBXOrIazkWNs48dStn01RswIfeUsKZnbi5ZIuhmCBXOXa
         F4twGzvfxjx0+/1k7g53aZsGtlaUMeoyaDZ+Dr3Tuz4Sb1UDfyiuqdulJ//JOJU4QGp1
         TmtissEGTmYJ4lEqx2dYdszJruG8q9BwEfqZqmlJMxEvAAUur2fjFcVp77+ZcRNKzjzH
         4D1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780248975; x=1780853775;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CCuX+JyCcas6C2sIklDs3Y6lQ4InyYy6BkSo/VLcEG4=;
        b=o2KBymrfeo5vXJvLfNSXnnhrPSxptbzEbl5ReOUWvlnMRMlRnk74CkG81aJniR5yjr
         OSJ5K1oQdvGZZ8pcu8vfNZoa057aBE1jX5f6P43W4tP9eFW9kCCLIOvtJNNFpShZWNGh
         XBFvxAKocNx8dQsY1LZZvZuzT3vLId/clQVj0UnGJjAEVIbfrg0JUgJhTyOPRB2He0BO
         TwqV3Wea771MSEZ/ZVg/PJJBYG8nc82rPLDrzAimV5Y2asyjSTUcMkid8tRcNuBQYGZo
         7pMT8/7jI4p1ZZfgA5+OhG0MclmL8xjsmFlsQxun3r7FHbCORbArveThAQF0z0qu1jw0
         tlJw==
X-Forwarded-Encrypted: i=1; AFNElJ8d1uKX0QSC4fXwDZ4erZZ4Px6Y75/qHLKzIORJ8p6uwUIlB8J5WDUR63zmB0ZXPInrfGpKhJkfE9bSe7bB@vger.kernel.org
X-Gm-Message-State: AOJu0YwW6aVyE1LLoXOvB803xfRKG/m8J/nng7Q7NzrIhrjuUC38mwul
	xtJZSbE2kmtnP6sIv1YLJDCmoojKzM+0rQAiyUb7ZvQrW08G6c0U9nN8h2po4exK8Lq1xs0iY8r
	E5X0pG4L4iD3akgNPuN3ZVQZji2q4uW8=
X-Gm-Gg: Acq92OEj10f27xrbsPT7eOrkpjv6g+ZX0G+OSf9Bqrg590O+HkMNBdpxsEao/eJWus9
	BhzM1ADuhwi9SexjWb2BprmKqL9FaYrVAq0Z16xtSEvtk0SdVXpVlJXRzp3jMEdfQ0S+vgEdM9W
	V5KMwrkkKQ9P3Cj7Ri949Gv7uZOKOXBFND1ZNVTpiINMdN7Z/VA+ZSD6d654qS4qaQHzcdFD4Cp
	hvXcJl+lN2PsJykpvZunRbuzGYbi/M4IWr5hFEiqXeZ5OP6zPdirYUfosybhZFmaSHvLDxiYrAH
	AhTntM5eiyCsjqDyZ4wvjBuB7jbhkBae/BN+tjWekARkCWjO+B0X
X-Received: by 2002:a05:6402:f26:b0:689:6c2e:6cdf with SMTP id
 4fb4d7f45d1cf-68c8d1f809fmr2779978a12.22.1780248974205; Sun, 31 May 2026
 10:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com>
In-Reply-To: <20260529134302.1989958-1-mszeredi@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 31 May 2026 19:36:01 +0200
X-Gm-Features: AVHnY4Jw79TY3NYWf8r265O8nNiqww5iwxnXSv9dgMZOC5AjQOCSalLxszAMoR0
Message-ID: <CAOQ4uxjZ66rSmbsDMRbrohC4LE4RgLzKotH6N_TYz92bZ-nR8Q@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: John Groves <john@groves.net>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 3:43=E2=80=AFPM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> The difference is that now the server needs to look at the fmap and check
> if any new device needs registering, the device index is now allocated by
> the kernel and returned by the ioctl().
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
> This is the first part of what we were talking about: using the backing
> file API for dax devices.
>
> It's on top of the famfs-v10 patchset.
>
> Totally untested, haven't even tried booting it.  Obviously needs
> nontrivial conversion in the server code as well.
>
> Thanks,
> Miklos
>
> fs/fuse/Kconfig           |   1 +
>  fs/fuse/backing.c         |  28 ++-
>  fs/fuse/famfs.c           | 346 ++++++++++----------------------------
>  fs/fuse/famfs_kfmap.h     |   2 -
>  fs/fuse/fuse_i.h          |  25 +--
>  fs/fuse/inode.c           |   7 +-
>  include/uapi/linux/fuse.h |   8 +-
>  7 files changed, 123 insertions(+), 294 deletions(-)

I like this diffstat :)
Code looks much simpler.
Could possibly use fuse_backing_ops that Darrick used for iomap
backing devices to generalize the backing id ioctls:

https://lore.kernel.org/fuse-devel/177922945327.2436837.2738315299316875094=
.stgit@frogsfrogsfrogs/

Although at this point, I would not do any dynamic resolve of backing_ops
and use a single ops struct per filesystem mode.

Thanks,
Amir.

>
> diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> index 17fe1f490cbd..8dbd6663808e 100644
> --- a/fs/fuse/Kconfig
> +++ b/fs/fuse/Kconfig
> @@ -79,6 +79,7 @@ config FUSE_IO_URING
>
>  config FUSE_FAMFS_DAX
>         bool "FUSE support for fs-dax filesystems backed by devdax"
> +       select FUSE_PASSTHROUGH
>         depends on FUSE_FS
>         depends on DEV_DAX_FSDEV
>         default FUSE_FS
> diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> index d95dfa48483f..e56b7f8d5d2b 100644
> --- a/fs/fuse/backing.c
> +++ b/fs/fuse/backing.c
> @@ -37,14 +37,14 @@ void fuse_backing_files_init(struct fuse_conn *fc)
>         idr_init(&fc->backing_files_map);
>  }
>
> -static int fuse_backing_id_alloc(struct fuse_conn *fc, struct fuse_backi=
ng *fb)
> +int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj)
>  {
>         int id;
>
>         idr_preload(GFP_KERNEL);
>         spin_lock(&fc->lock);
>         /* FIXME: xarray might be space inefficient */
> -       id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
> +       id =3D idr_alloc_cyclic(&fc->backing_files_map, obj, 1, 0, GFP_AT=
OMIC);
>         spin_unlock(&fc->lock);
>         idr_preload_end();
>
> @@ -75,7 +75,10 @@ static int fuse_backing_id_free(int id, void *p, void =
*data)
>
>  void fuse_backing_files_free(struct fuse_conn *fc)
>  {
> -       idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> +       if (fc->famfs_iomap)
> +               famfs_teardown(fc);
> +       else
> +               idr_for_each(&fc->backing_files_map, fuse_backing_id_free=
, NULL);
>         idr_destroy(&fc->backing_files_map);
>  }
>
> @@ -88,13 +91,23 @@ int fuse_backing_open(struct fuse_conn *fc, struct fu=
se_backing_map *map)
>
>         pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
>
> +       if (map->padding)
> +               return -EINVAL;
> +
> +       if (fc->famfs_iomap) {
> +               if (map->flags !=3D FUSE_BACKING_DAXDEV)
> +                       return -EINVAL;
> +
> +               return famfs_daxdev_open(fc, map);
> +       }
> +
>         /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
>         res =3D -EPERM;
>         if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
>                 goto out;
>
>         res =3D -EINVAL;
> -       if (map->flags || map->padding)
> +       if (map->flags)
>                 goto out;
>
>         file =3D fget_raw(map->fd);
> @@ -144,6 +157,10 @@ int fuse_backing_close(struct fuse_conn *fc, int bac=
king_id)
>
>         pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
>
> +       /* No close for dax device (yet) */
> +       if (fc->famfs_iomap)
> +               return -EINVAL;
> +
>         /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
>         err =3D -EPERM;
>         if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> @@ -170,6 +187,9 @@ struct fuse_backing *fuse_backing_lookup(struct fuse_=
conn *fc, int backing_id)
>  {
>         struct fuse_backing *fb;
>
> +       if (fc->famfs_iomap)
> +               return NULL;
> +
>         rcu_read_lock();
>         fb =3D idr_find(&fc->backing_files_map, backing_id);
>         fb =3D fuse_backing_get(fb);
> diff --git a/fs/fuse/famfs.c b/fs/fuse/famfs.c
> index 121ed74e9727..c49362d19b36 100644
> --- a/fs/fuse/famfs.c
> +++ b/fs/fuse/famfs.c
> @@ -23,15 +23,15 @@
>  #include "fuse_i.h"
>
>  static void famfs_set_daxdev_err(
> -       struct fuse_conn *fc, struct dax_device *dax_devp);
> +       struct famfs_daxdev *dd, struct dax_device *dax_devp);
>
>  static int
>  famfs_dax_notify_failure(struct dax_device *dax_devp, u64 offset,
>                         u64 len, int mf_flags)
>  {
> -       struct fuse_conn *fc =3D dax_holder(dax_devp);
> +       struct famfs_daxdev *dd =3D dax_holder(dax_devp);
>
> -       famfs_set_daxdev_err(fc, dax_devp);
> +       famfs_set_daxdev_err(dd, dax_devp);
>
>         return 0;
>  }
> @@ -51,6 +51,26 @@ static const struct address_space_operations famfs_dax=
_aops =3D {
>
>  /***********************************************************************=
******/
>
> +static void famfs_daxdev_free(struct famfs_daxdev *dd)
> +{
> +       /* Only call fs_put_dax if fs_dax_get succeeded */
> +       if (dd->devp) {
> +               if (!dd->dax_err)
> +                       fs_put_dax(dd->devp, dd);
> +               put_dax(dd->devp);
> +       }
> +       kfree(dd->name);
> +       kfree(dd);
> +}
> +
> +DEFINE_FREE(famfs_daxdev_free, struct famfs_daxdev *, if (_T) famfs_daxd=
ev_free(_T));
> +
> +static int famfs_devidx_free(int id, void *p, void *data)
> +{
> +       famfs_daxdev_free(p);
> +       return 0;
> +}
> +
>  /*
>   * famfs_teardown()
>   *
> @@ -59,263 +79,90 @@ static const struct address_space_operations famfs_d=
ax_aops =3D {
>  void
>  famfs_teardown(struct fuse_conn *fc)
>  {
> -       struct famfs_dax_devlist *devlist __free(kfree) =3D fc->dax_devli=
st;
> -       int i;
> -
> -       fc->dax_devlist =3D NULL;
> -
> -       if (!devlist)
> -               return;
> -
> -       if (!devlist->devlist)
> -               return;
> -
> -       /* Close & release all the daxdevs in our table */
> -       for (i =3D 0; i < devlist->nslots; i++) {
> -               struct famfs_daxdev *dd =3D &devlist->devlist[i];
> -
> -               if (!dd->valid)
> -                       continue;
> -
> -               /* Only call fs_put_dax if fs_dax_get succeeded */
> -               if (dd->devp) {
> -                       if (!dd->dax_err)
> -                               fs_put_dax(dd->devp, fc);
> -                       put_dax(dd->devp);
> -               }
> -
> -               kfree(dd->name);
> -       }
> -       kfree(devlist->devlist);
> +       idr_for_each(&fc->backing_files_map, famfs_devidx_free,  NULL);
>  }
>
>  static int
> -famfs_verify_daxdev(const char *pathname, dev_t *devno)
> +famfs_verify_daxdev(const struct path *path, dev_t *devno)
>  {
> -       struct inode *inode;
> -       struct path path;
> -       int err;
> +       struct inode *inode =3D d_inode(path->dentry);
>
> -       if (!pathname || !*pathname)
> +       if (!S_ISCHR(inode->i_mode))
>                 return -EINVAL;
>
> -       err =3D kern_path(pathname, LOOKUP_FOLLOW, &path);
> -       if (err)
> -               return err;
> -
> -       inode =3D d_backing_inode(path.dentry);
> -       if (!S_ISCHR(inode->i_mode)) {
> -               err =3D -EINVAL;
> -               goto out_path_put;
> -       }
> -
> -       if (!may_open_dev(&path)) { /* had to export this */
> -               err =3D -EACCES;
> -               goto out_path_put;
> -       }
> +       if (!may_open_dev(path)) /* had to export this */
> +               return -EACCES;
>
>         *devno =3D inode->i_rdev;
>
> -out_path_put:
> -       path_put(&path);
> -       return err;
> +       return 0;
>  }
>
> -/**
> - * famfs_fuse_get_daxdev() - Retrieve info for a DAX device from fuse se=
rver
> - *
> - * Send a GET_DAXDEV message to the fuse server to retrieve info on a
> - * dax device.
> - *
> - * @fm:     fuse_mount
> - * @index:  the index of the dax device; daxdevs are referred to by inde=
x
> - *          in fmaps, and the server resolves the index to a particular =
daxdev
> - *
> - * Returns: 0=3Dsuccess
> - *          -errno=3Dfailure
> - */
> -static int
> -famfs_fuse_get_daxdev(struct fuse_mount *fm, const u64 index)
> +static int famfs_fuse_get_daxdev(const struct path *path, struct famfs_d=
axdev *dd)
>  {
> -       struct fuse_daxdev_out daxdev_out =3D { 0 };
> -       struct fuse_conn *fc =3D fm->fc;
> -       struct famfs_daxdev *daxdev;
>         int rc;
>
> -       FUSE_ARGS(args);
> -
> -       /* Store the daxdev in our table */
> -       if (index >=3D fc->dax_devlist->nslots) {
> -               pr_err("%s: index(%lld) > nslots(%d)\n",
> -                      __func__, index, fc->dax_devlist->nslots);
> -               return -EINVAL;
> -       }
> -
> -       args.opcode =3D FUSE_GET_DAXDEV;
> -       args.nodeid =3D index;
> -
> -       args.in_numargs =3D 0;
> -
> -       args.out_numargs =3D 1;
> -       args.out_args[0].size =3D sizeof(daxdev_out);
> -       args.out_args[0].value =3D &daxdev_out;
> -
> -       /* Send GET_DAXDEV command */
> -       rc =3D fuse_simple_request(fm, &args);
> +       /* Verify dev is valid and can be opened and gets the devno */
> +       rc =3D famfs_verify_daxdev(path, &dd->devno);
>         if (rc) {
> -               pr_err("%s: rc=3D%d from fuse_simple_request()\n",
> -                      __func__, rc);
> -               /* Error will be that the payload is smaller than FMAP_BU=
FSIZE,
> -                * which is the max we can handle. Empty payload handled =
below.
> -                */
> +               pr_err("%s: rc=3D%d from famfs_verify_daxdev()\n", __func=
__, rc);
>                 return rc;
>         }
>
> -       scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {
> -               daxdev =3D &fc->dax_devlist->devlist[index];
> -
> -               /* Abort if daxdev is now valid (races are possible here)=
 */
> -               if (daxdev->valid) {
> -                       pr_debug("%s: daxdev already known\n", __func__);
> -                       return 0;
> -               }
> -
> -               /* Verify dev is valid and can be opened and gets the dev=
no */
> -               rc =3D famfs_verify_daxdev(daxdev_out.name, &daxdev->devn=
o);
> -               if (rc) {
> -                       pr_err("%s: rc=3D%d from famfs_verify_daxdev()\n"=
,
> -                              __func__, rc);
> -                       return rc;
> -               }
> -
> -               daxdev->name =3D kstrdup(daxdev_out.name, GFP_KERNEL);
> -               if (!daxdev->name)
> -                       return -ENOMEM;
> +       dd->name =3D kasprintf(GFP_KERNEL, "%pd4", path->dentry);
> +       if (!dd->name)
> +               return -ENOMEM;
>
> -               /* This will fail if it's not a dax device */
> -               daxdev->devp =3D dax_dev_get(daxdev->devno);
> -               if (!daxdev->devp) {
> -                       pr_warn("%s: device %s not found or not dax\n",
> -                               __func__, daxdev_out.name);
> -                       kfree(daxdev->name);
> -                       daxdev->name =3D NULL;
> +       /* This will fail if it's not a dax device */
> +       dd->devp =3D dax_dev_get(dd->devno);
> +       if (!dd->devp) {
> +               pr_warn("%s: device %s not found or not dax\n",__func__, =
dd->name);
> +                       kfree(dd->name);
> +                       dd->name =3D NULL;
>                         return -ENODEV;
>                 }
>
> -               rc =3D fs_dax_get(daxdev->devp, fc, &famfs_fuse_dax_holde=
r_ops);
> -               if (rc) {
> -                       /* Mark as valid with dax_err to prevent retry lo=
op.
> -                        * famfs_dax_err() will return -EIO on access att=
empts.
> -                        * Teardown handles this case: skips fs_put_dax, =
calls put_dax.
> -                        */
> -                       daxdev->dax_err =3D 1;
> -                       pr_err("%s: fs_dax_get(%lld) failed\n",
> -                              __func__, (u64)daxdev->devno);
> -               }
> -
> -               wmb(); /* All other fields must be visible before valid *=
/
> -               daxdev->valid =3D 1;
> +       rc =3D fs_dax_get(dd->devp, dd, &famfs_fuse_dax_holder_ops);
> +       if (rc) {
> +               /* Mark as valid with dax_err to prevent retry loop.
> +                * famfs_dax_err() will return -EIO on access attempts.
> +                * Teardown handles this case: skips fs_put_dax, calls pu=
t_dax.
> +                */
> +               dd->dax_err =3D 1;
> +               pr_err("%s: fs_dax_get(%lld) failed\n", __func__, (u64)dd=
->devno);
>         }
>
>         return 0;
>  }
>
> -/**
> - * famfs_update_daxdev_table() - Update the daxdev table
> - * @fm:   fuse_mount
> - * @meta: famfs_file_meta, in-memory format, built from a GET_FMAP respo=
nse
> - *
> - * This function is called for each new file fmap, to verify whether all
> - * referenced daxdevs are already known (i.e. in the table). Any daxdev
> - * indices referenced in @meta but not in the table will be retrieved vi=
a
> - * famfs_fuse_get_daxdev() and added to the table
> - *
> - * Return: 0=3Dsuccess
> - *         -errno=3Dfailure
> - */
> -static int
> -famfs_update_daxdev_table(
> -       struct fuse_mount *fm,
> -       const struct famfs_file_meta *meta)
> +int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map=
)
>  {
> -       struct famfs_dax_devlist *local_devlist;
> -       struct fuse_conn *fc =3D fm->fc;
> -       int indices_to_fetch[MAX_DAXDEVS];
> -       int n_to_fetch =3D 0;
> -       int err;
> -
> -       /* First time through we will need to allocate the dax_devlist */
> -       if (!fc->dax_devlist) {
> -               local_devlist =3D kcalloc(1, sizeof(*fc->dax_devlist), GF=
P_KERNEL);
> -               if (!local_devlist)
> -                       return -ENOMEM;
> -
> -               local_devlist->nslots =3D MAX_DAXDEVS;
> -
> -               local_devlist->devlist =3D kcalloc(MAX_DAXDEVS,
> -                                                sizeof(struct famfs_daxd=
ev),
> -                                                GFP_KERNEL);
> -               if (!local_devlist->devlist) {
> -                       kfree(local_devlist);
> -                       return -ENOMEM;
> -               }
> -
> -               /* We don't need famfs_devlist_sem here because we use cm=
pxchg */
> -               if (cmpxchg(&fc->dax_devlist, NULL, local_devlist) !=3D N=
ULL) {
> -                       kfree(local_devlist->devlist);
> -                       kfree(local_devlist); /* another thread beat us t=
o it */
> -               }
> -       }
> +       struct famfs_daxdev *dd __free(famfs_daxdev_free) =3D kzalloc_obj=
(*dd);
> +       int rc;
>
> -       /* Collect indices that need fetching while holding read lock */
> -       scoped_guard(rwsem_read, &fc->famfs_devlist_sem) {
> -               unsigned long i;
> +       CLASS(fd_raw, f)(map->fd);
> +       if (fd_empty(f))
> +               return -EBADF;
>
> -               for_each_set_bit(i, (unsigned long *)&meta->dev_bitmap, M=
AX_DAXDEVS) {
> -                       if (!(fc->dax_devlist->devlist[i].valid))
> -                               indices_to_fetch[n_to_fetch++] =3D i;
> -               }
> -       }
> +       rc =3D famfs_fuse_get_daxdev(&fd_file(f)->f_path, dd);
> +       if (rc)
> +               return rc;
>
> -       /* Fetch needed daxdevs outside the read lock */
> -       for (int j =3D 0; j < n_to_fetch; j++) {
> -               err =3D famfs_fuse_get_daxdev(fm, indices_to_fetch[j]);
> -               if (err)
> -                       pr_err("%s: failed to get daxdev=3D%d\n",
> -                              __func__, indices_to_fetch[j]);
> -       }
> +       rc =3D fuse_backing_id_alloc(fc, dd);
> +       if (rc >=3D 0)
> +               retain_and_null_ptr(dd);
>
> -       return 0;
> +       return rc;
>  }
>
>  static void
>  famfs_set_daxdev_err(
> -       struct fuse_conn *fc,
> -       struct dax_device *dax_devp)
> +       struct famfs_daxdev *dd, struct dax_device *dax_devp)
>  {
> -       int i;
> -
> -       /* Gotta search the list by dax_devp;
> -        * read lock because we're not adding or removing daxdev entries
> -        */
> -       scoped_guard(rwsem_write, &fc->famfs_devlist_sem) {
> -               for (i =3D 0; i < fc->dax_devlist->nslots; i++) {
> -                       if (fc->dax_devlist->devlist[i].valid) {
> -                               struct famfs_daxdev *dd;
> -
> -                               dd =3D &fc->dax_devlist->devlist[i];
> -                               if (dd->devp !=3D dax_devp)
> -                                       continue;
>
> -                               dd->error =3D true;
> +       dd->error =3D true;
>
> -                               pr_err("%s: memory error on daxdev %s (%d=
)\n",
> -                                      __func__, dd->name, i);
> -                               return;
> -                       }
> -               }
> -       }
> -       pr_err("%s: memory err on unrecognized daxdev\n", __func__);
> +       pr_err("%s: memory error on daxdev %s\n", __func__, dd->name);
>  }
>
>  /***********************************************************************=
****/
> @@ -447,9 +294,6 @@ famfs_fuse_meta_alloc(
>                         meta->se[i].ext_offset =3D se_in[i].se_offset;
>                         meta->se[i].ext_len    =3D se_in[i].se_len;
>
> -                       /* Record bitmap of referenced daxdev indices */
> -                       meta->dev_bitmap |=3D (1 << meta->se[i].dev_index=
);
> -
>                         errs +=3D famfs_check_ext_alignment(&meta->se[i])=
;
>
>                         extent_total +=3D meta->se[i].ext_len;
> @@ -545,9 +389,6 @@ famfs_fuse_meta_alloc(
>                                 strips_out[j].ext_offset =3D offset;
>                                 strips_out[j].ext_len    =3D len;
>
> -                               /* Record bitmap of referenced daxdev ind=
ices */
> -                               meta->dev_bitmap |=3D (1 << devindex);
> -
>                                 extent_total +=3D len;
>                                 errs +=3D famfs_check_ext_alignment(&stri=
ps_out[j]);
>                                 size_remainder -=3D len;
> @@ -603,7 +444,7 @@ famfs_fuse_meta_alloc(
>   * Return: 0=3Dsuccess
>   *          -errno=3Dfailure
>   */
> -int
> +static int
>  famfs_file_init_dax(
>         struct fuse_mount *fm,
>         struct inode *inode,
> @@ -625,9 +466,6 @@ famfs_file_init_dax(
>         if (rc)
>                 goto errout;
>
> -       /* Make sure this fmap doesn't reference any unknown daxdevs */
> -       famfs_update_daxdev_table(fm, meta);
> -
>         /* Publish the famfs metadata on fi->famfs_meta */
>         inode_lock(inode);
>
> @@ -662,11 +500,6 @@ static int famfs_file_bad(struct inode *inode);
>
>  static int famfs_dax_err(struct famfs_daxdev *dd)
>  {
> -       if (!dd->valid) {
> -               pr_err("%s: daxdev=3D%s invalid\n",
> -                      __func__, dd->name);
> -               return -EIO;
> -       }
>         if (dd->dax_err) {
>                 pr_err("%s: daxdev=3D%s dax_err\n",
>                        __func__, dd->name);
> @@ -680,6 +513,18 @@ static int famfs_dax_err(struct famfs_daxdev *dd)
>         return 0;
>  }
>
> +static struct famfs_daxdev *
> +famfs_daxdev_lookup(struct fuse_conn *fc, int devidx)
> +{
> +       struct famfs_daxdev *dd;
> +
> +       rcu_read_lock();
> +       dd =3D idr_find(&fc->backing_files_map, devidx);
> +       rcu_read_unlock();
> +
> +       return dd;
> +}
> +
>  static int
>  famfs_interleave_fileofs_to_daxofs(struct inode *inode, struct iomap *io=
map,
>                          loff_t file_offset, off_t len, unsigned int flag=
s)
> @@ -730,21 +575,13 @@ famfs_interleave_fileofs_to_daxofs(struct inode *in=
ode, struct iomap *iomap,
>                         u64 strip_devidx =3D fei->ie_strips[strip_num].de=
v_index;
>                         int rc;
>
> -                       if (strip_devidx >=3D fc->dax_devlist->nslots) {
> -                               pr_err("%s: strip_devidx %llu >=3D nslots=
 %d\n",
> -                                      __func__, strip_devidx,
> -                                      fc->dax_devlist->nslots);
> -                               goto err_out;
> -                       }
> -
> -                       if (!fc->dax_devlist->devlist[strip_devidx].valid=
) {
> +                       dd =3D famfs_daxdev_lookup(fc, strip_devidx);
> +                       if (!dd) {
>                                 pr_err("%s: daxdev=3D%lld invalid\n", __f=
unc__,
>                                         strip_devidx);
>                                 goto err_out;
>                         }
>
> -                       dd =3D &fc->dax_devlist->devlist[strip_devidx];
> -
>                         rc =3D famfs_dax_err(dd);
>                         if (rc) {
>                                 /* Shut down access to this file */
> @@ -756,7 +593,7 @@ famfs_interleave_fileofs_to_daxofs(struct inode *inod=
e, struct iomap *iomap,
>                         iomap->offset  =3D file_offset;
>                         iomap->length  =3D min_t(loff_t, len, chunk_remai=
nder);
>
> -                       iomap->dax_dev =3D fc->dax_devlist->devlist[strip=
_devidx].devp;
> +                       iomap->dax_dev =3D dd->devp;
>
>                         iomap->type    =3D IOMAP_MAPPED;
>                         iomap->flags   =3D flags;
> @@ -815,11 +652,6 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct =
iomap *iomap,
>         struct fuse_conn *fc =3D get_fuse_conn(inode);
>         loff_t local_offset =3D file_offset;
>
> -       if (!fc->dax_devlist) {
> -               pr_err("%s: null dax_devlist\n", __func__);
> -               goto err_out;
> -       }
> -
>         if (famfs_file_bad(inode))
>                 goto err_out;
>
> @@ -851,15 +683,13 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct=
 iomap *iomap,
>                         struct famfs_daxdev *dd;
>                         int rc;
>
> -                       if (daxdev_idx >=3D fc->dax_devlist->nslots) {
> -                               pr_err("%s: daxdev_idx %llu >=3D nslots %=
d\n",
> -                                      __func__, daxdev_idx,
> -                                      fc->dax_devlist->nslots);
> +                       dd =3D famfs_daxdev_lookup(fc, daxdev_idx);
> +                       if (!dd) {
> +                               pr_err("%s: daxdev=3D%lld invalid\n", __f=
unc__,
> +                                       daxdev_idx);
>                                 goto err_out;
>                         }
>
> -                       dd =3D &fc->dax_devlist->devlist[daxdev_idx];
> -
>                         rc =3D famfs_dax_err(dd);
>                         if (rc) {
>                                 /* Shut down access to this file */
> @@ -884,7 +714,7 @@ famfs_fileofs_to_daxofs(struct inode *inode, struct i=
omap *iomap,
>                         iomap->offset  =3D file_offset;
>                         iomap->length  =3D min_t(loff_t, len, ext_len_rem=
ainder);
>
> -                       iomap->dax_dev =3D fc->dax_devlist->devlist[daxde=
v_idx].devp;
> +                       iomap->dax_dev =3D dd->devp;
>
>                         iomap->type    =3D IOMAP_MAPPED;
>                         iomap->flags   =3D flags;
> diff --git a/fs/fuse/famfs_kfmap.h b/fs/fuse/famfs_kfmap.h
> index 970ad802b492..3f72ae8e4696 100644
> --- a/fs/fuse/famfs_kfmap.h
> +++ b/fs/fuse/famfs_kfmap.h
> @@ -124,7 +124,6 @@ struct famfs_file_meta {
>         enum famfs_file_type   file_type;
>         size_t                 file_size;
>         enum famfs_extent_type fm_extent_type;
> -       u64 dev_bitmap; /* bitmap of referenced daxdevs by index */
>         union {
>                 struct {
>                         size_t         fm_nextents;
> @@ -145,7 +144,6 @@ struct famfs_file_meta {
>   */
>  struct famfs_daxdev {
>         /* Include dev uuid? */
> -       bool valid;
>         bool error; /* Dax has reported a memory error (probably poison) =
*/
>         bool dax_err; /* fs_dax_get() failed */
>         dev_t devno;
> diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> index dcbeaceda918..adc88a8681e2 100644
> --- a/fs/fuse/fuse_i.h
> +++ b/fs/fuse/fuse_i.h
> @@ -1006,11 +1006,6 @@ struct fuse_conn {
>                 /* Request timeout (in jiffies). 0 =3D no timeout */
>                 unsigned int req_timeout;
>         } timeout;
> -
> -#if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> -       struct rw_semaphore famfs_devlist_sem;
> -       struct famfs_dax_devlist *dax_devlist;
> -#endif
>  };
>
>  /*
> @@ -1572,6 +1567,7 @@ void fuse_file_release(struct inode *inode, struct =
fuse_file *ff,
>  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
>  void fuse_backing_put(struct fuse_backing *fb);
>  struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int backi=
ng_id);
> +int fuse_backing_id_alloc(struct fuse_conn *fc, void *obj);
>  #else
>
>  static inline struct fuse_backing *fuse_backing_get(struct fuse_backing =
*fb)
> @@ -1647,22 +1643,14 @@ extern void fuse_sysctl_unregister(void);
>  /* famfs.c */
>
>  #if IS_ENABLED(CONFIG_FUSE_FAMFS_DAX)
> -int famfs_file_init_dax(struct fuse_mount *fm,
> -                       struct inode *inode, void *fmap_buf,
> -                       size_t fmap_size);
>  ssize_t famfs_fuse_write_iter(struct kiocb *iocb, struct iov_iter *from)=
;
>  ssize_t famfs_fuse_read_iter(struct kiocb *iocb, struct iov_iter       *=
to);
>  int famfs_fuse_mmap(struct file *file, struct vm_area_struct *vma);
>  void __famfs_meta_free(void *map);
>
> +int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_backing_map *map=
);
>  void famfs_teardown(struct fuse_conn *fc);
>
> -/* Set fi->famfs_meta =3D NULL regardless of prior value */
> -static inline void famfs_meta_init(struct fuse_inode *fi)
> -{
> -       fi->famfs_meta =3D NULL;
> -}
> -
>  /* Set fi->famfs_meta iff the current value is NULL */
>  static inline struct fuse_backing *famfs_meta_set(struct fuse_inode *fi,
>                                                   void *meta)
> @@ -1678,11 +1666,6 @@ static inline void famfs_meta_free(struct fuse_ino=
de *fi)
>         }
>  }
>
> -static inline void famfs_init_devlist_sem(struct fuse_conn *fc)
> -{
> -       init_rwsem(&fc->famfs_devlist_sem);
> -}
> -
>  static inline int fuse_file_famfs(struct fuse_inode *fi)
>  {
>         return (READ_ONCE(fi->famfs_meta) !=3D NULL);
> @@ -1736,6 +1719,10 @@ fuse_get_fmap(struct fuse_mount *fm, struct inode =
*inode)
>         return 0;
>  }
>
> +static inline int famfs_daxdev_open(struct fuse_conn *fc, struct fuse_ba=
cking_map *map)
> +{
> +       return -EINVAL;
> +}
>  #endif /* CONFIG_FUSE_FAMFS_DAX */
>
>  #endif /* _FS_FUSE_I_H */
> diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
> index 40e7ea5b6437..5e692fc84297 100644
> --- a/fs/fuse/inode.c
> +++ b/fs/fuse/inode.c
> @@ -1048,9 +1048,6 @@ void fuse_conn_put(struct fuse_conn *fc)
>                 WARN_ON(atomic_read(&bucket->count) !=3D 1);
>                 kfree(bucket);
>         }
> -       if (IS_ENABLED(CONFIG_FUSE_FAMFS_DAX))
> -               famfs_teardown(fc);
> -
>         if (IS_ENABLED(CONFIG_FUSE_PASSTHROUGH))
>                 fuse_backing_files_free(fc);
>         call_rcu(&fc->rcu, delayed_release);
> @@ -1480,10 +1477,8 @@ static void process_init_reply(struct fuse_mount *=
fm, struct fuse_args *args,
>                                 u64 in_flags =3D FIELD_PREP(GENMASK_ULL(6=
3, 32), ia->in.flags2)
>                                                 | ia->in.flags;
>
> -                               if (in_flags & FUSE_DAX_FMAP) {
> -                                       famfs_init_devlist_sem(fc);
> +                               if (in_flags & FUSE_DAX_FMAP)
>                                         fc->famfs_iomap =3D 1;
> -                               }
>                         }
>                 } else {
>                         ra_pages =3D fc->max_read / PAGE_SIZE;
> diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> index 1b82895108be..d6e8dc75c8a1 100644
> --- a/include/uapi/linux/fuse.h
> +++ b/include/uapi/linux/fuse.h
> @@ -248,7 +248,6 @@
>   *    - struct fuse_famfs_iext
>   *    - struct fuse_famfs_fmap_header
>   *  - Add the following structs for the GET_DAXDEV message and reply
> - *    - struct fuse_get_daxdev_in
>   *    - struct fuse_get_daxdev_out
>   *  - Add the following enumerated types
>   *    - enum fuse_famfs_file_type
> @@ -1145,6 +1144,9 @@ struct fuse_notify_prune_out {
>         uint64_t        spare;
>  };
>
> +/* Backing is a dax device */
> +#define FUSE_BACKING_DAXDEV    (1 << 0)
> +
>  struct fuse_backing_map {
>         int32_t         fd;
>         uint32_t        flags;
> @@ -1373,10 +1375,6 @@ struct fuse_famfs_fmap_header {
>         uint64_t reserved1;
>  };
>
> -struct fuse_get_daxdev_in {
> -       uint32_t        daxdev_num;
> -};
> -
>  #define DAXDEV_NAME_MAX 256
>
>  /* fuse_daxdev_out has enough space for a uuid if we need it */
> --
> 2.54.0
>
>
