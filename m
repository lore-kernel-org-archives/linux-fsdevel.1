Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31076391E72
	for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 19:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778788126; cv=pass; b=Rt5h3vrAD6Bp5V2npuR3h9Ld5gu8mqKG60u/gKl9lo8xs074dIb1GlOaYX3HovqO0ZaVl6AfghCYOtg6RXk4s83/UaVO2G5VO4jogVSPIHHsuZEDMCvI78s9AYr6oVNI+KfyMsbbsg5QB9l8LE6yeOQC8jb2bqvuNl/2AgpZs0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778788126; c=relaxed/simple;
	bh=7/XrGrvTOK0IcKhL+t+NUNfdSC3cBpyVO6HHKQn3A0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgHdHeKQik97sTifSMLnF3JwWYvQZlTKHOraUi/3bCA88ogZTOg1nWyyQKQND/RRIHNxysSi7ahLmKIOW6Vs8OZe1zKI792Bbc3KOsSy/51LjNmg5kHAlFTa6kpcdpvsw9y8j+ZsX1HuNvq7lNzPNGB+EbnYuElzL2Al/dWaewI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/1qRcHb; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/1qRcHb"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67c9616b4feso12313993a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 May 2026 12:48:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778788123; cv=none;
        d=google.com; s=arc-20240605;
        b=Ol0HrggOcOkW+WvpuCMdrIlRjPC/e0gYfY/KAhxuzC3o/EgRupsQeTb05W/TAIigTC
         c/tF1PSZx4iAUHdFPR3VKF2DWWO3besbZdg+WReKDiHneX2U+WAcf6jflBU0t3CCtsiN
         zDNxAoCOQYPDtAVCyy44H6CRH/yRcRTnrJLVP+vyslehkUybYWWmfmfjbOzm8eMaicXx
         po4sSdkLBZHZa7pxTI342nK0xATKFUlOj+TIC2INfTZM4qikANbhLy0kAlkvh0lnWWJe
         Z0SVCYwzL6xBmrBpsdVq4kQx2V1c1Xywmu3D+nfNEHkn9RVClB+j52DF6a9LpaFRisiz
         PIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K5rRRjXuxlm+1rnmGU2842sYnQPIyUIwQBlcv4IKidk=;
        fh=Tjn69CCaomfXGYF+iK2+cUGo1sB/H21wnM70sNi8vuo=;
        b=Py3Hzrs+B19jPafDy/o2gRi2XDPpy3OseMZ2VchR7u9DUCSwOjiehk8b/u0ecpPcw1
         z5paYArLrElXDubXHpihlPZLfbT1aHOPwoYeQ6wwBs86IQmCyh60j9+fDEV+EYano3ka
         06OrhN0ufaXptUXqup/h45O94hAupRcqHTGJ3w/FN/tahWjCgcan6NvfbCHn7w72FRSr
         q2JzTP5BOBWvDeuNSFfwbElpTQ6zy5n7bgiNQA9FthDCHNp3akfCbvTMdlaJADw0bE0H
         I9IIaJ5H0/ccpcJaSKRH9RiTlGp+xgU2VXguGheia2hoBpG4Wp3fX75eJLbaGN3Q85jJ
         UDDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778788123; x=1779392923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K5rRRjXuxlm+1rnmGU2842sYnQPIyUIwQBlcv4IKidk=;
        b=k/1qRcHbGtwCEco1LnsYgW5wEJ4DLj4PlRFRb2lKUlmHiPVNcjyfjl1MNTFlUmPlpU
         aOsc+AKPpgSJ4YMZLKp2Pd9PS39ZndHioub3GhX8uCscejnkmzm2ojzdNGusa4kpeGyI
         g0mmEq4bIu/VctaHQTrjaVzXK8I+GjaW72dVdNHj4sfXMx798DWwriWB5GlwJP9nKqmO
         chNad1mAXpAWNzKiWvyRiyPUHuhErCpfdtWC5CUe/fBNy51PdpSwxTLiCwXxcEWbS/mf
         xMyHOLPHSIV3VrrRwtzgh3BwUdAIYhIVPQiVekA7G3a2MENDPN/dz+ZFsx4bX3urU19j
         fbPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778788123; x=1779392923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K5rRRjXuxlm+1rnmGU2842sYnQPIyUIwQBlcv4IKidk=;
        b=hOXMf6BA5vqSXPu/mqqiosfCVsZ231mVBEax1Z/S+uTba6eam9jjc6gaL4GjpyKnKC
         v9hth9VubLwkGkvHgprWLYqGKleQ6WEEbSdWuMnekvZQijV/C03P9rkKRKm/Xb2Mpn/R
         gyFYfsJ3xZnKWMoiffY4bMfd3dzUWgVQJkgBDlb6TkH2ST/SmQOHDb5Zi8XXJETMXZZg
         5MDi0EoAMm+lc8AdYK/GJBFxh3haEnmcaj+cZhyrQ8t0xGxqe/tzsaeioqzRVeuvW+qN
         iPvets0pKLEDA51YumfL/PsMPXqkxGlr51QoRUqcODCh6GpfaWPY4wAlHK8AbeDJCjAU
         8sNw==
X-Forwarded-Encrypted: i=1; AFNElJ+DC8QJVD77jJhYjjL06T0/Mv6rOBits9N6uct9r1R85p5Yi99wZh7TU9KMPspuCDerMVZbJHb+oWveSH/E@vger.kernel.org
X-Gm-Message-State: AOJu0YxZgCuRuPqtO7MXHlupyPL4/G/2BqRNdBH6+RWcXNso1MiNyXRV
	BM14J7OvwAQ9gQNIutclZUoWs3SZjBYdmlqX42vXLhFwSIuPVE2By/sr7eHKqGh3fnIdHKFLMoZ
	vjWnWaIL1PHZ3XAEqJVWVj2H3QEidr6o=
X-Gm-Gg: Acq92OElGnfdH/LRCZMVT1a3ZH/sunfBeSUEeP9+m1i2FNHzbEAXyjcSj121gDc1cVw
	VnHRUgD2CtOxlCDiJ9cY4j2jCtSWTT7ihfdfRVxNXHifdvFN5uMDZe8gSoCQ3KVU/H4awDNjVoP
	sLc54h8fcz1LPqdWUGkPRt+2UftQJaN3vTQu35AzUomVRfTGXS6sgB/GGWIbHLCajYfR/R83DhF
	ap1Tp9SvP3MKyHu1cbeUWOZ/6rvCICIo/P8HxIzCOd0/ElXi62yqMPqkAgAoDkOzHnHABq6/eFG
	yqAUdEXVxPlNqYuNyRrQmezpKgDdaR+f39kALnsVrw==
X-Received: by 2002:a05:6402:405c:10b0:678:f81a:76a1 with SMTP id
 4fb4d7f45d1cf-683bc4b36f8mr282937a12.10.1778788122354; Thu, 14 May 2026
 12:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177747204594.4101743.18108570914300152558.stgit@frogsfrogsfrogs>
 <177747204624.4101743.10110436900437243535.stgit@frogsfrogsfrogs> <20260514183826.GB9544@frogsfrogsfrogs>
In-Reply-To: <20260514183826.GB9544@frogsfrogsfrogs>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 14 May 2026 21:48:31 +0200
X-Gm-Features: AVHnY4LHvD6vMXgeTiymVhIvEnq1mGsgYCWKCGa4jhhJrElp3fpX05ahCxs5uY8
Message-ID: <CAOQ4uxjc=6cdTCuPiH8trqyHzJ1dR+oZ1Aidfos8mqgB4Bv8EA@mail.gmail.com>
Subject: Re: [PATCH 1/2] fuse: move the passthrough-specific code back to passthrough.c
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev, 
	linux-fsdevel@vger.kernel.org, bernd@bsbernd.com, fuse-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 8:40=E2=80=AFPM Darrick J. Wong <djwong@kernel.org>=
 wrote:
>
> On Wed, Apr 29, 2026 at 07:23:26AM -0700, Darrick J. Wong wrote:
> > From: Darrick J. Wong <djwong@kernel.org>
> >
> > In preparation for iomap, move the passthrough-specific validation code
> > back to passthrough.c and create a new Kconfig item for conditional
> > compilation of backing.c.  In the next patch, iomap will share the
> > backing structures.
> >
> > Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

I think I RVB this on v6:
https://lore.kernel.org/linux-fsdevel/CAOQ4uxgW4=3D6KRuR6Qh3uMQyxtdRPLwAXZ8=
VY4yuduzTVqz7+dA@mail.gmail.com/
does not look like this was changed?
Hard to keep track...

> > ---
> >  fs/fuse/fuse_i.h          |   25 ++++++++++-
> >  include/uapi/linux/fuse.h |    8 +++-
> >  fs/fuse/Kconfig           |    4 ++
> >  fs/fuse/Makefile          |    3 +
> >  fs/fuse/backing.c         |   98 ++++++++++++++++++++++++++++++++++---=
--------
> >  fs/fuse/dev.c             |    4 +-
> >  fs/fuse/inode.c           |    4 +-
> >  fs/fuse/passthrough.c     |   38 +++++++++++++++++
> >  8 files changed, 149 insertions(+), 35 deletions(-)
> >
> >
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index 0b9c617ee3e5be..0666e03723071b 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -103,10 +103,23 @@ struct fuse_submount_lookup {
> >       struct fuse_forget_link *forget;
> >  };
> >
> > +struct fuse_conn;
> > +
> > +/** Operations for subsystems that want to use a backing file */
> > +struct fuse_backing_ops {
> > +     int (*may_admin)(struct fuse_conn *fc, uint32_t flags);
> > +     int (*may_open)(struct fuse_conn *fc, struct file *file);
> > +     int (*may_close)(struct fuse_conn *fc, struct file *file);
> > +     unsigned int type;
> > +     int id_start;
> > +     int id_end;
> > +};
> > +
> >  /** Container for data related to mapping to backing file */
> >  struct fuse_backing {
> >       struct file *file;
> >       struct cred *cred;
> > +     const struct fuse_backing_ops *ops;
> >
> >       /** refcount */
> >       refcount_t count;
> > @@ -980,7 +993,7 @@ struct fuse_conn {
> >       /* New writepages go into this bucket */
> >       struct fuse_sync_bucket __rcu *curr_bucket;
> >
> > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > +#ifdef CONFIG_FUSE_BACKING
> >       /** IDR for backing files ids */
> >       struct idr backing_files_map;
> >  #endif
> > @@ -1591,10 +1604,12 @@ void fuse_file_release(struct inode *inode, str=
uct fuse_file *ff,
> >                      unsigned int open_flags, fl_owner_t id, bool isdir=
);
> >
> >  /* backing.c */
> > -#ifdef CONFIG_FUSE_PASSTHROUGH
> > +#ifdef CONFIG_FUSE_BACKING
> >  struct fuse_backing *fuse_backing_get(struct fuse_backing *fb);
> >  void fuse_backing_put(struct fuse_backing *fb);
> > -struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc, int bac=
king_id);
> > +struct fuse_backing *fuse_backing_lookup(struct fuse_conn *fc,
> > +                                      const struct fuse_backing_ops *o=
ps,
> > +                                      int backing_id);
> >  #else
> >
> >  static inline struct fuse_backing *fuse_backing_get(struct fuse_backin=
g *fb)
> > @@ -1649,6 +1664,10 @@ static inline struct file *fuse_file_passthrough=
(struct fuse_file *ff)
> >  #endif
> >  }
> >
> > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > +extern const struct fuse_backing_ops fuse_passthrough_backing_ops;
> > +#endif
> > +
> >  ssize_t fuse_passthrough_read_iter(struct kiocb *iocb, struct iov_iter=
 *iter);
> >  ssize_t fuse_passthrough_write_iter(struct kiocb *iocb, struct iov_ite=
r *iter);
> >  ssize_t fuse_passthrough_splice_read(struct file *in, loff_t *ppos,
> > diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
> > index c13e1f9a2f12bd..18713cfaf09171 100644
> > --- a/include/uapi/linux/fuse.h
> > +++ b/include/uapi/linux/fuse.h
> > @@ -1126,9 +1126,15 @@ struct fuse_notify_prune_out {
> >       uint64_t        spare;
> >  };
> >
> > +#define FUSE_BACKING_TYPE_MASK               (0xFF)
> > +#define FUSE_BACKING_TYPE_PASSTHROUGH        (0)
> > +#define FUSE_BACKING_MAX_TYPE                (FUSE_BACKING_TYPE_PASSTH=
ROUGH)
> > +
> > +#define FUSE_BACKING_FLAGS_ALL               (FUSE_BACKING_TYPE_MASK)
> > +
> >  struct fuse_backing_map {
> >       int32_t         fd;
> > -     uint32_t        flags;
> > +     uint32_t        flags; /* FUSE_BACKING_* */
> >       uint64_t        padding;
> >  };
> >
> > diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
> > index 3a4ae632c94aa8..290d1c09e0b924 100644
> > --- a/fs/fuse/Kconfig
> > +++ b/fs/fuse/Kconfig
> > @@ -59,12 +59,16 @@ config FUSE_PASSTHROUGH
> >       default y
> >       depends on FUSE_FS
> >       select FS_STACK
> > +     select FUSE_BACKING
> >       help
> >         This allows bypassing FUSE server by mapping specific FUSE oper=
ations
> >         to be performed directly on a backing file.
> >
> >         If you want to allow passthrough operations, answer Y.
> >
> > +config FUSE_BACKING
> > +     bool
> > +
> >  config FUSE_IO_URING
> >       bool "FUSE communication over io-uring"
> >       default y
> > diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
> > index 22ad9538dfc4b8..46041228e5be2c 100644
> > --- a/fs/fuse/Makefile
> > +++ b/fs/fuse/Makefile
> > @@ -14,7 +14,8 @@ fuse-y :=3D trace.o   # put trace.o first so we see f=
trace errors sooner
> >  fuse-y +=3D dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir=
.o ioctl.o
> >  fuse-y +=3D iomode.o
> >  fuse-$(CONFIG_FUSE_DAX) +=3D dax.o
> > -fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o backing.o
> > +fuse-$(CONFIG_FUSE_PASSTHROUGH) +=3D passthrough.o
> > +fuse-$(CONFIG_FUSE_BACKING) +=3D backing.o
> >  fuse-$(CONFIG_SYSCTL) +=3D sysctl.o
> >  fuse-$(CONFIG_FUSE_IO_URING) +=3D dev_uring.o
> >
> > diff --git a/fs/fuse/backing.c b/fs/fuse/backing.c
> > index d95dfa48483f0a..adb4d2ebb21379 100644
> > --- a/fs/fuse/backing.c
> > +++ b/fs/fuse/backing.c
> > @@ -6,6 +6,7 @@
> >   */
> >
> >  #include "fuse_i.h"
> > +#include "fuse_trace.h"
> >
> >  #include <linux/file.h>
> >
> > @@ -44,7 +45,8 @@ static int fuse_backing_id_alloc(struct fuse_conn *fc=
, struct fuse_backing *fb)
> >       idr_preload(GFP_KERNEL);
> >       spin_lock(&fc->lock);
> >       /* FIXME: xarray might be space inefficient */
> > -     id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, 1, 0, GFP_ATO=
MIC);
> > +     id =3D idr_alloc_cyclic(&fc->backing_files_map, fb, fb->ops->id_s=
tart,
> > +                           fb->ops->id_end, GFP_ATOMIC);
> >       spin_unlock(&fc->lock);
> >       idr_preload_end();
> >
> > @@ -69,32 +71,53 @@ static int fuse_backing_id_free(int id, void *p, vo=
id *data)
> >       struct fuse_backing *fb =3D p;
> >
> >       WARN_ON_ONCE(refcount_read(&fb->count) !=3D 1);
> > +
> >       fuse_backing_free(fb);
> >       return 0;
> >  }
> >
> >  void fuse_backing_files_free(struct fuse_conn *fc)
> >  {
> > -     idr_for_each(&fc->backing_files_map, fuse_backing_id_free, NULL);
> > +     idr_for_each(&fc->backing_files_map, fuse_backing_id_free, fc);
> >       idr_destroy(&fc->backing_files_map);
> >  }
> >
> > +static inline const struct fuse_backing_ops *
> > +fuse_backing_ops_from_map(const struct fuse_backing_map *map)
> > +{
> > +     switch (map->flags & FUSE_BACKING_TYPE_MASK) {
> > +#ifdef CONFIG_FUSE_PASSTHROUGH
> > +     case FUSE_BACKING_TYPE_PASSTHROUGH:
> > +             return &fuse_passthrough_backing_ops;
> > +#endif
> > +     default:
> > +             break;
> > +     }
> > +
> > +     return NULL;
> > +}
> > +
> >  int fuse_backing_open(struct fuse_conn *fc, struct fuse_backing_map *m=
ap)
> >  {
> >       struct file *file;
> > -     struct super_block *backing_sb;
> >       struct fuse_backing *fb =3D NULL;
> > +     const struct fuse_backing_ops *ops =3D fuse_backing_ops_from_map(=
map);
> > +     uint32_t op_flags =3D map->flags & ~FUSE_BACKING_TYPE_MASK;
> >       int res;
> >
> >       pr_debug("%s: fd=3D%d flags=3D0x%x\n", __func__, map->fd, map->fl=
ags);
> >
> > -     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> > -     res =3D -EPERM;
> > -     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > +     res =3D -EOPNOTSUPP;
> > +     if (!ops)
> > +             goto out;
> > +     WARN_ON(ops->type !=3D (map->flags & FUSE_BACKING_TYPE_MASK));
> > +
> > +     res =3D ops->may_admin ? ops->may_admin(fc, op_flags) : 0;
> > +     if (res)
> >               goto out;
> >
> >       res =3D -EINVAL;
> > -     if (map->flags || map->padding)
> > +     if (map->padding)
> >               goto out;
> >
> >       file =3D fget_raw(map->fd);
> > @@ -102,14 +125,8 @@ int fuse_backing_open(struct fuse_conn *fc, struct=
 fuse_backing_map *map)
> >       if (!file)
> >               goto out;
> >
> > -     /* read/write/splice/mmap passthrough only relevant for regular f=
iles */
> > -     res =3D d_is_dir(file->f_path.dentry) ? -EISDIR : -EINVAL;
> > -     if (!d_is_reg(file->f_path.dentry))
> > -             goto out_fput;
> > -
> > -     backing_sb =3D file_inode(file)->i_sb;
> > -     res =3D -ELOOP;
> > -     if (backing_sb->s_stack_depth >=3D fc->max_stack_depth)
> > +     res =3D ops->may_open ? ops->may_open(fc, file) : 0;
> > +     if (res)
> >               goto out_fput;
> >
> >       fb =3D kmalloc_obj(struct fuse_backing);
> > @@ -119,14 +136,15 @@ int fuse_backing_open(struct fuse_conn *fc, struc=
t fuse_backing_map *map)
> >
> >       fb->file =3D file;
> >       fb->cred =3D prepare_creds();
> > +     fb->ops =3D ops;
> >       refcount_set(&fb->count, 1);
> >
> >       res =3D fuse_backing_id_alloc(fc, fb);
> >       if (res < 0) {
> >               fuse_backing_free(fb);
> >               fb =3D NULL;
> > +             goto out;
> >       }
> > -
> >  out:
> >       pr_debug("%s: fb=3D0x%p, ret=3D%i\n", __func__, fb, res);
> >
> > @@ -137,41 +155,71 @@ int fuse_backing_open(struct fuse_conn *fc, struc=
t fuse_backing_map *map)
> >       goto out;
> >  }
> >
> > +static struct fuse_backing *__fuse_backing_lookup(struct fuse_conn *fc=
,
> > +                                               int backing_id)
> > +{
> > +     struct fuse_backing *fb;
> > +
> > +     rcu_read_lock();
> > +     fb =3D idr_find(&fc->backing_files_map, backing_id);
> > +     fb =3D fuse_backing_get(fb);
> > +     rcu_read_unlock();
> > +
> > +     return fb;
> > +}
> > +
> >  int fuse_backing_close(struct fuse_conn *fc, int backing_id)
> >  {
> > -     struct fuse_backing *fb =3D NULL;
> > +     struct fuse_backing *fb =3D NULL, *test_fb;
> > +     const struct fuse_backing_ops *ops;
> >       int err;
> >
> >       pr_debug("%s: backing_id=3D%d\n", __func__, backing_id);
> >
> > -     /* TODO: relax CAP_SYS_ADMIN once backing files are visible to ls=
of */
> > -     err =3D -EPERM;
> > -     if (!fc->passthrough || !capable(CAP_SYS_ADMIN))
> > -             goto out;
> > -
> >       err =3D -EINVAL;
> >       if (backing_id <=3D 0)
> >               goto out;
> >
> >       err =3D -ENOENT;
> > -     fb =3D fuse_backing_id_remove(fc, backing_id);
> > +     fb =3D __fuse_backing_lookup(fc, backing_id);
> >       if (!fb)
> >               goto out;
> > +     ops =3D fb->ops;
> >
> > -     fuse_backing_put(fb);
> > +     err =3D ops->may_admin ? ops->may_admin(fc, 0) : 0;
> > +     if (err)
> > +             goto out_fb;
> > +
> > +     err =3D ops->may_close ? ops->may_close(fc, fb->file) : 0;
> > +     if (err)
> > +             goto out_fb;
> > +
> > +     err =3D -ENOENT;
> > +     test_fb =3D fuse_backing_id_remove(fc, backing_id);
> > +     if (!test_fb)
> > +             goto out_fb;
> > +
> > +     WARN_ON(fb !=3D test_fb);
>
> I think I should pass @fb into fuse_backing_id_remove so that it
> performs a second lookup under fc->lock and only calls idr_remove if the
> result of the second lookup matches the passed-in @fb.
>

I agree. That makes sense.

Thanks,
Amir.
