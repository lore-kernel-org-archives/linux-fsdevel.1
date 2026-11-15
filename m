Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794756779;
	b=0D7dulYo9VpwHrxW3U6ZlLGiEc155G5feTgaPc1V2aHr6dKu4Mkwvs/LD/TC8Yj/IUjG
	 F8zJy52XUWvhm3kEgUsnUm4L0bFNuUL7nccB+J8Vc49h07rdxm+zg4So7k56xHeiyYJYc
	 yhwGOi/EWQNK8cH5QAT2Juu+3cnCLcSwI/9g+IeYP+ksCSqxdG+jjPMfNOJeui5krMGuU
	 LYarXf1X/MH0LYduQT+fZ4uf8z+LS7s/MztwGenblqeQv53kdRtLbIPf7JurYekHn0Iy2
	 wWFRDFy9gHSnV7s89/g1Br9fxHC2kS62PFXfe5VrXMJ0OSrDrcLjr91SWPqEvkLmfhw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794756779;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RaYvNmK1+0rYqOErDvRbUjN02R4QFRekRPQqrCcXJO8=;
	b=r2gJeQVG1NS/hispb9p4XTVb4KrcDQ6yJ57Sk+Xh6sGxU09RTp2cVzFYIFlR+leMPh9B
	 vFmhVGcK7N7AKDbJNeHw5hvlgTh/YXY61kfceo9GSSMZi8x4AHMnSHl7ZI0VvIpjNMeke
	 C8jNrp517ku5D2fIKXW4YwJ30nKWxVHiGK475mMaVkp1UGoiBK9Dt95DxFeXrbqASTY5Y
	 Kd5qTn1Q7OhZqnOT0+gkBY9OKd4fmvfL/wLZTvEr68E3olMJ60I4M3ZtHPbQunmNSbR0F
	 qlFAOjqg6SStdGxdzLvo6Qp2HwEGopdTyoHTgHkJVhDcmbDxOcFJmrXSgkdtqz5V1Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHWbaDea;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9A4606A31D
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 15:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D9A4606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CHWbaDea
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so4493115a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 15 Nov 2026 07:32:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794756778; cv=none;
        d=google.com; s=arc-20260327;
        b=NvyLOdpKT77gZSMKxlTHcRYSml9Kj6w9M71YdgZIcxANWZV5RJlcMrPzV/knjqChQP
         UXPPmTBP4PvB0dctgMrlM4F3ZHK6EUekFwVk4rLBtYglzyhhhh+ff+P38md5Hu8suHKE
         MKtjpf6k4TmZywohvRQBo/LWiYysqhhNgM7RflLZAfGfByusxf+8G8NFHzl5bB7iImmk
         wWdqazjcRdrFRRAHR5+HzeJkNVvDmBlqyk3fD76p2vUXXiAV7imO4uB7jvO63BssQ6a1
         +5nLKxV/sWayWkXucEk8gti0RUe7V6adEQfs/8wQNZ/e28MofdXAqfnuLlNQXuWZMyeO
         GvlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RaYvNmK1+0rYqOErDvRbUjN02R4QFRekRPQqrCcXJO8=;
        fh=NQQS1JAv58dgpBjMWnklZd332RgVs8ojVm5vQiVCr+k=;
        b=BWkyI4cEEyADqlEneuD5VY4JPr8gi59pY3IaFV7pm1Cze55E/Kmlzhl/a8fKiPpDJT
         Pjn7IkEA/wtBkltNj2aTCMy6NvnAXeIc0G5XV9IqhXzEeyYuOdLEwxgY8Jwo/9HXHzSg
         tPPgc10dcD884encaHCHZ9UmQaWXGJqwimJ5HJNU8+pOPyITddVdQfDJBv2TDwHXRIgC
         C+DdIO6mkOwI0g+gptn/hAVH5bjtZmCIx+t1nsekl4ac6PguolPEfVQAM5OQD0qX3llX
         4TAz9z6Ww99lLGWsFTi74WJtxUl9o27VQwLay3OQ6Hj0xmv8vHnRqGKe+Dc1Np9SGWkZ
         EDfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794756778; x=1795361578; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RaYvNmK1+0rYqOErDvRbUjN02R4QFRekRPQqrCcXJO8=;
        b=CHWbaDeah/kAKqYpAvVTaIUNgbOqHQejfkl6zyzZ5AZZKhLGdRO6NXisdj/IPaisjP
         P86nXMQKKMVwARSAzHVYh62u8f05EDgn+nhmS/J8pMqECgIMqeKL3X+ywq9oKbZh/S8M
         kpDiYoQxnVYBnviNxyuRO6nh1GHqK+I0LUcqP+JCKdFAxLacK2TWR7TVCZmzMjHqkPeT
         EK5QUmwUUjrebOZwwiYkjj6Z0/9Jo/FId3hKfCzHiUHujcCyV0VXE6wSSK8NZXpY4V6H
         fxEimWDLjNVGokYoPJ3dhVPQ6uftdceOPcai3rwmZoILPU3gnlmZYsN7Nnlql7/uRAqW
         m22g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794756778; x=1795361578;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RaYvNmK1+0rYqOErDvRbUjN02R4QFRekRPQqrCcXJO8=;
        b=qcRx0Jzpi2EbC3v3o6p5yPVjpdx//ojo2rNeqmSTJsEh/1v6cU73iJa+CnmWtw+DZD
         l7DogSbega8AYlWHAu6NePCWGYXbi76DJEuacfkFZH6uycdl7CqQKSm/V0JUVUoyyceP
         SyozwH7TYLYiTJQpl0kDXmKDUzuQbvbuOs1IxgffLYenGTDmLtnQqs1fYD2mYvAJxVLu
         rJXTIDLzzOpjgDC7WSMrMYMkfRVw2H/WOuEgPETQtCqdvwtXnvSQWUKPBIqc3bzrQ63B
         fdbusPdhGcaio2SZgR4cq2AX027PXEWcGCwGLNXNjUMUqd0qbdsGquyhGfLFzSz8btZp
         W7MA==
X-Forwarded-Encrypted: i=1; AL+hErGNGcvtJBekPJslIx3YC1AFEjhW6ASMyPe9vAdsF0v+bLJZQI4ipc/rVPwzIpONopltrCBrUZIMRF5Ma7nM@vger.kernel.org
X-Gm-Message-State: APuU4Z9lTk1tjDcoE/zEfinaj6TQ4l/Aq5fe1ZB5Mv+OmkTxw0zoqbbp
	pVu49bpUPAAIgRLK3CaKb+McWuJL+HkkxBaCzoC+FmIOoRB/UgQohbWegDLE0eRWss7kGfNkPYr
	gO7n5yIdz60/MaF8A2MeBysEW0yAv8WWGO77bOKQ=
X-Gm-Gg: AYBFou2VDKoyTJcruvCFHHNDfi6MPSTpVduJGdECmWYGHQMAUQOkGgz8fU/6EsmQkNA
	QFcLTEIa3NoX7arE+oC8EABIywHs3ZH2OJGym0EUZK91qclOr/waTU/y6of3gxij4JPX2Q1iSKi
	5G54WMa9Pz026GBT5LiOQRl+++j0vhztaOAhHcDLdT/rI4Uk3MohqoT+TUl+b6iHdAAEjGnBG5p
	0EwHR6MRHs9TGuf/A+R6W7aOaedsxK+Q5FXrVLp5RXcR1hA/7vgByw1q5bxrnxmPSv4+gi8MLxs
	9JMFq6GCOAT4D1hlld8ZRSwdfMFOxppj+lYElS45vNafDjLSeTkacOtxRJkYQ2Av5sLAncy+EO6
	HM4yqCR0KO1AGUQ1fA89U+iss2xeCfafbqszF0dVPnNWHH3e8A4Yzwr5yaPet7zJ7797UUw==
X-Received: by 2002:a05:6402:a513:10b0:6b5:8c80:d12d with SMTP id
 4fb4d7f45d1cf-6b7c0c4d305mr4068364a12.37.1794756777334; Sun, 15 Nov 2026
 07:32:57 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261015143601.2095784-1-amir73il@gmail.com> <20261015143601.2095784-10-amir73il@gmail.com>
In-Reply-To: <20261015143601.2095784-10-amir73il@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 15 Nov 2026 16:32:46 +0100
X-Gm-Features: AclHuK8qyUBoJR_Qs1L-gfQfVq83QGuov8GIy8o9nxUWf3q9W2mgvP-i1gUBRII
Message-ID: <CAOQ4uxgojh38=iOpS8M1Q_ctfnQ4JLA8pe0C3bfEPEh73+SXfQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/14] fanotify: gate event mask in fanotify_mark() by
 group type
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 4:36=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> Bits 32..39 of the event mask encode the expected group watcher type.
> Let fanotify_mark() accept a mask only when that type matches the group
> watcher type.
>
> FAN_MNT_* events carry no type in the mask, so special case them to pass
> this gate.
>
> The type is dropped when the 32bit mask is stored in the mark, so for now
> the new FAN_NS_MNT_* events cannot be requested in fanotify_mark().
>
> to prepare for overload the lower event bits, change all the bitmask
> checks to use a helper fanotify_mask_match() which also compares the
> type bits.
>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 118 ++++++++++++++++++++---------
>  1 file changed, 81 insertions(+), 37 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index e8a8fc2ad52c8..76bb2574c8239 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1462,8 +1462,36 @@ static int fanotify_group_init_error_pool(struct f=
snotify_group *group)
>                                          sizeof(struct fanotify_error_eve=
nt));
>  }
>
> +/*
> + * The low 32 event bits of a fanotify mask and the watcher type encoded
> + * in its high byte.
> + */
> +struct fanotify_mask {
> +       u32 mask;
> +       u8 type;
> +};
> +
> +/* Match @fan_mask to any event in @event_set of the same watcher type *=
/
> +static bool fanotify_mask_match(struct fanotify_mask fan_mask,
> +                                __u64 event_set)
> +{
> +       return fan_mask.type =3D=3D FAN_EVENT_TYPE(event_set) &&
> +              (fan_mask.mask & event_set);
> +}
> +
> +static int fanotify_mask_from_user(__u64 mask, struct fanotify_mask *fan=
_mask)
> +{
> +       if (mask & ~(FAN_EVENT_TYPE_MASK | ALL_FANOTIFY_EVENT_BITS))
> +               return -EINVAL;
> +
> +       fan_mask->mask =3D mask;
> +       fan_mask->type =3D FAN_EVENT_TYPE(mask);
> +       return 0;
> +}
> +
>  static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_m=
ark,
> -                                            __u32 mask, unsigned int fan=
_flags)
> +                                            struct fanotify_mask fan_mas=
k,
> +                                            unsigned int fan_flags)
>  {
>         /*
>          * Non evictable mark cannot be downgraded to evictable mark.
> @@ -1491,8 +1519,9 @@ static int fanotify_may_update_existing_mark(struct=
 fsnotify_mark *fsn_mark,
>                 return -EEXIST;
>
>         /* For now pre-content events are not generated for directories *=
/
> -       mask |=3D fsn_mark->mask;
> -       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> +       fan_mask.mask |=3D fsn_mark->mask;
> +       if ((fan_mask.mask & FAN_ONDIR) &&
> +           fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS))
>                 return -EEXIST;
>
>         return 0;
> @@ -1500,7 +1529,8 @@ static int fanotify_may_update_existing_mark(struct=
 fsnotify_mark *fsn_mark,
>
>  static int fanotify_add_mark(struct fsnotify_group *group,
>                              void *obj, unsigned int obj_type,
> -                            __u32 mask, unsigned int fan_flags,
> +                            struct fanotify_mask fan_mask,
> +                            unsigned int fan_flags,
>                              struct fan_fsid *fsid)
>  {
>         struct fsnotify_mark *fsn_mark;
> @@ -1521,7 +1551,7 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>         /*
>          * Check if requested mark flags conflict with an existing mark f=
lags.
>          */
> -       ret =3D fanotify_may_update_existing_mark(fsn_mark, mask, fan_fla=
gs);
> +       ret =3D fanotify_may_update_existing_mark(fsn_mark, fan_mask, fan=
_flags);
>         if (ret)
>                 goto out;
>
> @@ -1530,13 +1560,13 @@ static int fanotify_add_mark(struct fsnotify_grou=
p *group,
>          * needed (i.e. FAN_FS_ERROR was requested).
>          */
>         if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS) &&
> -           (mask & FAN_FS_ERROR)) {
> +           fanotify_mask_match(fan_mask, FAN_FS_ERROR)) {
>                 ret =3D fanotify_group_init_error_pool(group);
>                 if (ret)
>                         goto out;
>         }
>
> -       recalc =3D fanotify_mark_add_to_mask(fsn_mark, mask, fan_flags);
> +       recalc =3D fanotify_mark_add_to_mask(fsn_mark, fan_mask.mask, fan=
_flags);
>         if (recalc)
>                 fsnotify_recalc_mask(fsn_mark->connector);
>
> @@ -1545,7 +1575,7 @@ static int fanotify_add_mark(struct fsnotify_group =
*group,
>
>         fsnotify_put_mark(fsn_mark);
>
> -       if (!ret && (mask & FANOTIFY_PERM_EVENTS))
> +       if (!ret && fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS))
>                 fanotify_perm_watchdog_group_add(group);
>
>         return ret;
> @@ -1811,21 +1841,22 @@ static int fanotify_test_fid(struct dentry *dentr=
y, unsigned int flags)
>  }
>
>  static int fanotify_events_supported(struct fsnotify_group *group,
> -                                    const struct path *path, __u64 mask,
> +                                    const struct path *path,
> +                                    struct fanotify_mask fan_mask,
>                                      unsigned int flags)
>  {
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
>         bool is_dir =3D d_is_dir(path->dentry);
>         /* Strict validation of events in non-dir inode mask with v5.17+ =
APIs */
>         bool strict_dir_events =3D FAN_GROUP_FLAG(group, FAN_REPORT_TARGE=
T_FID) ||
> -                                (mask & FAN_RENAME) ||
> +                                fanotify_mask_match(fan_mask, FAN_RENAME=
) ||
>                                  (flags & FAN_MARK_IGNORE);
>
>         /*
>          * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
>          * and they are only supported on regular files and directories.
>          */
> -       if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
> +       if (fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS)) {
>                 if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
>                         return -EOPNOTSUPP;
>                 if (!is_dir && !d_is_reg(path->dentry))
> @@ -1840,7 +1871,7 @@ static int fanotify_events_supported(struct fsnotif=
y_group *group,
>          * waits for fanotify permission event to be answered. Just disal=
low
>          * permission events for such filesystems.
>          */
> -       if (mask & FANOTIFY_PERM_EVENTS &&
> +       if (fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS) &&
>             path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM=
)
>                 return -EINVAL;
>
> @@ -1863,15 +1894,15 @@ static int fanotify_events_supported(struct fsnot=
ify_group *group,
>          * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inod=
e,
>          * but because we always allowed it, error only when using new AP=
Is.
>          */
> -       if (strict_dir_events && mark_type =3D=3D FAN_MARK_INODE &&
> -           !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
> +       if (strict_dir_events && mark_type =3D=3D FAN_MARK_INODE && !is_d=
ir &&
> +           fanotify_mask_match(fan_mask, FANOTIFY_DIRONLY_EVENT_BITS))
>                 return -ENOTDIR;
>
>         return 0;
>  }
>
>  static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mar=
k_type,
> -                                  u64 mask)
> +                                 struct fanotify_mask fan_mask)
>  {
>         u64 valid_mask =3D 0;
>
> @@ -1894,14 +1925,20 @@ static bool fanotify_is_valid_mask(struct fsnotif=
y_group *group, int mark_type,
>                 if (mark_type =3D=3D FAN_MARK_MNTNS &&
>                     FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
>                         valid_mask =3D FANOTIFY_MOUNT_EVENTS;
> +               /* Classify the legacy mount events as namespace events *=
/
> +               if (fan_mask.mask & (FAN_MNT_ATTACH | FAN_MNT_DETACH))
> +                       fan_mask.type =3D FSNOTIFY_GROUP_TYPE_NAMESPACE;
>                 break;
>         }
>
> -       return !(mask & ~valid_mask);
> +       if (fan_mask.type !=3D group->type)
> +               return false;
> +

This overlooks the case of zero mask for FAN_MARK_FLUSH and
non zero group type (FAN_MARK_MNTNS).

Fixed on branch fsnotify_group_type in my github and added this test case
to the sefltest.

Thanks,
Amir.


> +       return !(fan_mask.mask & ~valid_mask);
>  }
>
> -static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 m=
ask,
> -                           int dfd, const char  __user *pathname)
> +static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 _=
_mask,
> +                           int dfd, const char __user *pathname)
>  {
>         struct inode *inode =3D NULL;
>         struct fsnotify_group *group;
> @@ -1909,6 +1946,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         struct fan_fsid __fsid, *fsid =3D NULL;
>         struct user_namespace *user_ns =3D NULL;
>         struct mnt_namespace *mntns;
> +       struct fanotify_mask fan_mask;
>         unsigned int mark_type =3D flags & FANOTIFY_MARK_TYPE_BITS;
>         unsigned int mark_cmd =3D flags & FANOTIFY_MARK_CMD_BITS;
>         unsigned int ignore =3D flags & FANOTIFY_MARK_IGNORE_BITS;
> @@ -1919,10 +1957,14 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>         int ret;
>
>         pr_debug("%s: fanotify_fd=3D%d flags=3D%x dfd=3D%d pathname=3D%p =
mask=3D%llx\n",
> -                __func__, fanotify_fd, flags, dfd, pathname, mask);
> +                __func__, fanotify_fd, flags, dfd, pathname, __mask);
> +
> +       ret =3D fanotify_mask_from_user(__mask, &fan_mask);
> +       if (ret)
> +               return ret;
>
>         /* we only use the lower 32 bits as of right now. */
> -       if (upper_32_bits(mask))
> +       if (fan_mask.type)
>                 return -EINVAL;
>
>         if (flags & ~FANOTIFY_MARK_FLAGS)
> @@ -1952,7 +1994,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         switch (mark_cmd) {
>         case FAN_MARK_ADD:
>         case FAN_MARK_REMOVE:
> -               if (!mask)
> +               if (!fan_mask.mask)
>                         return -EINVAL;
>                 break;
>         case FAN_MARK_FLUSH:
> @@ -1972,7 +2014,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          * FAN_MARK_IGNORED_MASK.
>          */
>         if (ignore =3D=3D FAN_MARK_IGNORED_MASK) {
> -               mask &=3D ~FANOTIFY_EVENT_FLAGS;
> +               fan_mask.mask &=3D ~FANOTIFY_EVENT_FLAGS;
>                 umask =3D FANOTIFY_EVENT_FLAGS;
>         }
>
> @@ -1986,7 +2028,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         group =3D fd_file(f)->private_data;
>
>         if (group->type !=3D mark_group_type ||
> -           !fanotify_is_valid_mask(group, mark_type, mask))
> +           !fanotify_is_valid_mask(group, mark_type, fan_mask))
>                 return -EINVAL;
>
>         /*
> @@ -2001,14 +2043,14 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>          * Permission events are not allowed for FAN_CLASS_NOTIF.
>          * Pre-content permission events are not allowed for FAN_CLASS_CO=
NTENT.
>          */
> -       if (mask & FANOTIFY_PERM_EVENTS &&
> +       if (fanotify_mask_match(fan_mask, FANOTIFY_PERM_EVENTS) &&
>             group->priority =3D=3D FSNOTIFY_PRIO_NORMAL)
>                 return -EINVAL;
> -       else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
> +       else if (fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENT=
S) &&
>                  group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
>                 return -EINVAL;
>
> -       if (mask & FAN_FS_ERROR &&
> +       if (fanotify_mask_match(fan_mask, FAN_FS_ERROR) &&
>             mark_type !=3D FAN_MARK_FILESYSTEM)
>                 return -EINVAL;
>
> @@ -2029,7 +2071,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>          */
>         fid_mode =3D FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
>         if (fsnotify_is_filesystem_watcher(group) &&
> -           mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> +           fan_mask.mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>             (!fid_mode || mark_type =3D=3D FAN_MARK_MOUNT))
>                 return -EINVAL;
>
> @@ -2038,11 +2080,13 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>          * new parent+name.  Reporting only old and new parent id is less
>          * useful and was not implemented.
>          */
> -       if (mask & FAN_RENAME && !(fid_mode & FAN_REPORT_NAME))
> +       if (fanotify_mask_match(fan_mask, FAN_RENAME) &&
> +           !(fid_mode & FAN_REPORT_NAME))
>                 return -EINVAL;
>
>         /* Pre-content events are not currently generated for directories=
. */
> -       if (mask & FANOTIFY_PRE_CONTENT_EVENTS && mask & FAN_ONDIR)
> +       if ((fan_mask.mask & FAN_ONDIR) &&
> +           fanotify_mask_match(fan_mask, FANOTIFY_PRE_CONTENT_EVENTS))
>                 return -EINVAL;
>
>         if (mark_cmd =3D=3D FAN_MARK_FLUSH) {
> @@ -2051,12 +2095,12 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>         }
>
>         ret =3D fanotify_find_path(dfd, pathname, &path, flags,
> -                       (mask & ALL_FSNOTIFY_EVENTS), obj_type);
> +                       (fan_mask.mask & ALL_FSNOTIFY_EVENTS), obj_type);
>         if (ret)
>                 return ret;
>
>         if (mark_cmd =3D=3D FAN_MARK_ADD) {
> -               ret =3D fanotify_events_supported(group, &path, mask, fla=
gs);
> +               ret =3D fanotify_events_supported(group, &path, fan_mask,=
 flags);
>                 if (ret)
>                         goto path_put_and_out;
>         }
> @@ -2066,7 +2110,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>         if (ret)
>                 goto path_put_and_out;
>
> -       ret =3D security_path_notify(&path, mask, obj_type);
> +       ret =3D security_path_notify(&path, fan_mask.mask, obj_type);
>         if (ret)
>                 goto path_put_and_out;
>
> @@ -2134,7 +2178,7 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>
>         /* Mask out FAN_EVENT_ON_CHILD flag for sb/mount/non-dir marks */
>         if (!inode || !S_ISDIR(inode->i_mode)) {
> -               mask &=3D ~FAN_EVENT_ON_CHILD;
> +               fan_mask.mask &=3D ~FAN_EVENT_ON_CHILD;
>                 umask =3D FAN_EVENT_ON_CHILD;
>                 /*
>                  * If group needs to report parent fid, register for gett=
ing
> @@ -2142,18 +2186,18 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
>                  */
>                 if ((fid_mode & FAN_REPORT_DIR_FID) &&
>                     (flags & FAN_MARK_ADD) && !ignore)
> -                       mask |=3D FAN_EVENT_ON_CHILD;
> +                       fan_mask.mask |=3D FAN_EVENT_ON_CHILD;
>         }
>
>         /* create/update an inode mark */
>         switch (mark_cmd) {
>         case FAN_MARK_ADD:
> -               ret =3D fanotify_add_mark(group, obj, obj_type, mask, fla=
gs,
> +               ret =3D fanotify_add_mark(group, obj, obj_type, fan_mask,=
 flags,
>                                         fsid);
>                 break;
>         case FAN_MARK_REMOVE:
> -               ret =3D fanotify_remove_mark(group, obj, obj_type, mask, =
flags,
> -                                          umask);
> +               ret =3D fanotify_remove_mark(group, obj, obj_type, fan_ma=
sk.mask,
> +                                          flags, umask);
>                 break;
>         default:
>                 ret =3D -EINVAL;
> --
> 2.55.0
>
