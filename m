Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BD0438FEF
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 22:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780524579; cv=pass; b=Y24mU1o4BUmGVcCoK91ZLVGIvtHIDDYdNKv2KpNmuT9pmue5pQCGpQaaVzxk7FRRwr6I8MzqQjRCvXnH7U6+bxOxk56Yi9Z1xQ/rEC6/k1Fy3HVDfvxMCpr0rbQJMgxf+EZvihyc5eD9h/TvCRDVpsy4mmodCq9pYPsI1Jt/hTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780524579; c=relaxed/simple;
	bh=U53nngNCa9JUp6aqAp+2D12uHe7gtEMTLPqy5fBjRv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qwFmleOlH8HKoitUqjwEHOf6tIMM4DsvER7eunl4USM+W9cGmuJV0bRgFLO/j6dok7cjAB4xrP25/9o9lXiYVOVwxbs0vB00EAdldm/lKMGnG/4iDsR/xJIT5pwxKsvjE9IErlSsFIyE17qfwleNnkQyqum3Ls6Nmf2HPOU6ipQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gilm2rNH; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gilm2rNH"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490abf12f0fso178805e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 15:09:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780524576; cv=none;
        d=google.com; s=arc-20240605;
        b=PM0EXd+XUyhIEcbOEOPdRIk0EtM9kbCLeHuSJvD5lHv11bmsRKLcFP+cC+/1yJDwJR
         2z2LpUf5TGBtv5kjX8x6KVzh7y+zwgLoeorIqzluX9OyjfnT2MvNjPomzQd23pFGNeMe
         D3Rwlq+qi7ThA72xYs5aVj4pDVfmAjvrE52rlVzHN/iN/mW7dEdJe9hDFiSdllJ4NYz3
         p5QFISXqp7hzgz8QAhqSd1zhTDXDWkQhxTSrrI/x/HoRoAbqz1ignsxG75IniuC0lFlV
         C2QMJMSIGl64Kl525Wb72TMdvACpdo4kMQ4bJUYo69wtxEIXVkRAJ5BesdQ85i/7KE51
         Gg2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CiWIjZ+HVQ8AkeC/fjtfNamWgBJi6+BYJVGWmqwQjIg=;
        fh=Ccz8w4wghrYvIBczc8ExPCOsTM9ec27iOJR1uxGSEJc=;
        b=aogVzSGC/pQ6y2nbnvZ9/su6L5Be0D2BAJAdxP6tp5E2LOQaob0RnJlvsKDvlRSTuO
         ke/GznJ7GmDyjHGOy7ytP+VFzX4ehpPvjj9sKVCK9Oh6829OvD5FrQ2bo8oJxOGSjEu+
         vOFTlnSO7xwWPdaUlwy7HOgLNEuMRx2vBkofjez/9cfVriRWFH9jF6EaYz33In1T/Qny
         OJTgXrR0vZUXmjSOo4X7zHWXExiXZM6vIWyVZHvu2TPgAqwkuGdF209HqtCDaA1hGEhv
         /xAz5QNHeQfoZ3X6RqYy6k4IhiWa9jMXmCi7wRfWgwhrLOE1Lpc9TkLTUbza1h5SIluI
         TNbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780524576; x=1781129376; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiWIjZ+HVQ8AkeC/fjtfNamWgBJi6+BYJVGWmqwQjIg=;
        b=Gilm2rNHAHJsouRuO5YtSZlTqPvl4K4O7y4KqdzZXI3fJOemjNo95/JSW8T72cpMT2
         BE/O6vxfqBfW7I2rMUkrJWcHEnn5UCAWub6jDKYAoZ7b+nyG/S+7i9XZBa2TH60kL0II
         gZi+NFyVzs6Nh7zckgoj45mnv0bE1wvz6j4M55ymJCuykX7mpZ9mxhkB/zSp2QN+kDa2
         slJwSx2WmpOEqsaickJQpEzK81aGbLWZsU5sRQDze7QKEQ5yYTJY1OXfHmS3/NHE6hVA
         LYiGYIJtguajUhuN/2w+Twi6Bu30xKccCYbP21l3dFBZUIivC2R4xkDiUCXjEJKSOPvU
         3pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780524576; x=1781129376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CiWIjZ+HVQ8AkeC/fjtfNamWgBJi6+BYJVGWmqwQjIg=;
        b=QErnbArj+rqSvUJjgG++mWy+DDcU+3+I+C42v1HoNImyP/75P++zcCv9gG6DgbkeZV
         vD4jsmPoeOGQDaCNlRW06G0dxE+GNM/4ABNAV95ylLy7gOzm1X9VB3UH1UhXgfP7/dlH
         3rly+qleD5iFeUpa4iOv9U9CywF/4KWSj1KYqMcg01bd3GeyQj2yv+b/RsZ7WSSSxiou
         VNwDug6dFMV3F5RHA03v3hqJj0MHkkTthwhjQGpc76jprqQ1hqCMPzsqRqTf3BKi1pzq
         Uu2Iu+spZPxYW3pgq4eBayWqC3BNTUBwNIkzg81PZzVKBagB8s8CEraSWwbzueWm4+98
         yoNw==
X-Forwarded-Encrypted: i=1; AFNElJ8qtELsu4jri4NfC1tyrBL0b7PpeLXDZzxFs6uhUCNuHyrlcMfEKgR0eAp6rt3dkVpHdlUp/sDar6TeeKfU@vger.kernel.org
X-Gm-Message-State: AOJu0YxzFGZICBHVsTPF7NzVPBrToqfu9xF5CQZXunAM0Wc/uG1fOlg5
	rmpcZa9bElPtogClUOb6QMh0qLbglWMILRgfQwgE7Ul91Y/bOMVL73kvjUaziWPkeP5rhOHicTo
	PnMVKkPL0xn8Jc6B2gJte2TKXoO3/WqU=
X-Gm-Gg: Acq92OGFU77Udh5xL3rNvIkGbtNDBFGKdnkjm9LhpHxZJpTM4WUSKsPcFxPD7aw/gzW
	msHETjEjHofwEhnzRZDU5MJRh8zl3fbmBeFXaVJ5h1CiTNnbF7kfIkBFGv2vMg8cosNVC4Lmp09
	BQBEJzcUbP+mTmTa47tm05sslqfenIQY1HJ4kCeSKeeIqFCrzBIWI/GK3BMrLOTOSkQNK51/8SJ
	9yzsVWfMECixglWN7ChFlQWWwWTgSzbZOWT3C6oZmMpxK3DtH7UcF7j688HpR0G+71/NZO5SUkJ
	JzoLIXbxbC+u7FPG
X-Received: by 2002:a05:600c:810b:b0:48a:5f32:62c6 with SMTP id
 5b1f17b1804b1-490bc4feb84mr15421225e9.11.1780524575528; Wed, 03 Jun 2026
 15:09:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com>
In-Reply-To: <20260529134302.1989958-1-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 3 Jun 2026 15:09:23 -0700
X-Gm-Features: AVHnY4KAN-mWiARiHr-ONfptK5nXwUulxJMJB-W0uIqyVbSnmFKMRaUXOHdbcZ0
Message-ID: <CAJnrk1YQO99GUfTF4n9SOrAVncLYraA+mc79Fvg4g6Fum1m7VA@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: John Groves <john@groves.net>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 6:45=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
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

Nice, this looks cleaner to me.

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
>
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

Would it be better to just have daxdev as a type of fuse_backing
instead of having daxdev be an entirely different type in
backing_files_map? From the struct definiton of famfs_daxdev, I see:

struct famfs_daxdev {
   bool error;
   bool dax_err;
   dev_t devno;
   struct dax_device *devp;
   char *name;
};

afaict, dax_err can be removed now (see comment below), name is only
used for diagnostic logging or could be found through
fb->file->f_path.dentry, and devno can be calculated/found from
fb->file (eg file_inode(fb->file)->i_rdev).

It seems like things would be a lot simpler if struct fuse_backing was
something like

struct fuse_backing {
        enum fuse_backing_type backing_type;
        struct file *file;
        bool error;

       union {
           const struct cred *cred;      /* FUSE_BACKING_FILE */
           struct dax_device *devp;   /*FUSE_BACKING_DAXDEV */
       };

        /* refcount */
        refcount_t count;
        struct rcu_head rcu;
};

where that would let the idr just be one type and would let us drop
the fc->famfs_iomap branches in
fuse_backing_{open/lookup/close/files_free} and the corresponding
famfs_{daxdev_lookup/daxdev_free/devidx_free/teardown} functions and
let daxdev piggyback off the refcount/rcu in fuse_backing. Otherwise I
think we will need to also add the recount and rcu to famfs_daxdev
separately once unregistering a daxdev backing is supported.

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

Seems like we could remove dax_err entirely now given that there's no
more retry loop anymore.

> +               pr_err("%s: fs_dax_get(%lld) failed\n", __func__, (u64)dd=
->devno);
>         }
>
>         return 0;

return rc;?
>  }
>
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

I think we need to check dd for null after allocation first before using.

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

Looks like enum FUSE_GET_DAXDEV, #define DAX_DEV_NAME_MAX, and struct
fuse_daxdev_out could get removed as well

Thanks,
Joanne


> --
> 2.54.0
>
>
