Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D249F49620
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246912; cv=pass; b=Z4pYhVEa+wbOU7WZO1ss0bRiMr3ixA7BaDpsvuVd7nj4hjXScKBYN6sMjnqT1kTIsM0fkLN6FGW4R8wZrXVx6bSk3h3hfskEjaiShY7ay/f9sI1UorJ5nF6f3yNSqX7nPVRj/XzC9+ARsaBgCeekRxu3CXi8MUQ7CL+mqbJlVSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246912; c=relaxed/simple;
	bh=ikP8TLvWpq9PS/EUA2FSzTrD6GbPCC/UQ4IGJvm2Q5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RFwUr2+9OqY+OIWpOsNbJ8BUjAVkdFvKqWevWp98niZVIWNhU0XSrqERo3KDWsJMJfF/tBvSgi4zw1PmkdTZHURP+wdCe9FUzMo3YeI7GCy43HzvqOqG0fargL6XKFfJT5RNicnkonso51mx5mug1BhnzX3MkgvIjP78Yr5jbaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgdeDUMT; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgdeDUMT"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c745e18a0so975951866b.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 02:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776246909; cv=none;
        d=google.com; s=arc-20240605;
        b=duBnuzQzERYjhso/udJFnxm+kX8e+pkQvA2yI1a1bGRBJTF4wZNxppEVowx7bfZmkX
         x89c5HB2PaTrsAjZ4y8ZnX4jgJupAUdv2IQju6qtfcS4elx4tuSC/aBTyZjjXm2+lnfC
         2Uw5etS9YctpvF0As0eS982Cm5ijy7feB7jhZuvzZj5R/6RNWwDBTe6mT+6CkEcCBX9Q
         Gg5ONonqzeD2lbTu7JYUHRn7jIE48Yi7jXaLrxWK7JLk0aVhPeKWd7AbkNac3ouJC2VR
         iTfQMdnraEL9UvfGwMfn5bNSygnwH5dlnoM5mSGCETF2FMoM1djEeY7szBybC9JBFrAg
         bbhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pHbPske2cI5Bod0aYFIDI5xNdzOGuytWMhtHugDH2Ek=;
        fh=SoGSaOkLm6HnsKJ4KyYQJ+YrRUtb3Q+tXclexMu154M=;
        b=h+fT8Sb1hasfXWSRlUP4LcoY1aZNf6jyK4qjvJ3uoCtzRtNe5VlkaOsO4C7Lr/+DNE
         Rvw4qb3VAWcEyv87AbTygculzSh+jCtsobmHGB97RbDEc57NKkB4j/ySAeFm+CcvvmeN
         YP1aUVscWs4p+mGvwbrcXmyv5l5y75X7SK4oZbAfFvWozBnMhAzqrumlvBztkbcyZwXA
         cmKbUjpPWjWr9/0tbUgV6niFbWD2Cjq93ySVPOtGSQ4pKw6ow33riC0md2vVsHxxu9/R
         Qu09mRG6hmoN+6bX3BV0A41G9U1i7Ti27RjS9lhaqA1/PsowEEdlnPgySZrdX112Pifc
         Bo0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776246909; x=1776851709; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pHbPske2cI5Bod0aYFIDI5xNdzOGuytWMhtHugDH2Ek=;
        b=ZgdeDUMTDo6pbsyvbsKlV2su8MpK8gcsqEjfNIAyp20A60xD7F5hjlFmC7i/dBPQVx
         FmKxadqccs6pQK+SEApWQpN8e4VNC5YYsp2JB/NXmDnH076vHXyK+Kijoeuyh6WbNfvO
         CeSbV+ZyW0po1cz9AZ3IcZ+C+0vqPp85/JkDEIvgRDB1N6JQSDS0vu7V5SxnkRLT7tLr
         44Bm2GUoTD8Tmcdmcm0/Y89opYmUHgqNtflKQYJusOs1Royew2M13vB4dl8sZW8oWd6/
         ae7sj6S3W3iNoHseQuF2ehFPXGcW3jwHT/8aD/IRldSZLXSGWXH3ZdrpXfVi5cP7nuof
         w4bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246909; x=1776851709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pHbPske2cI5Bod0aYFIDI5xNdzOGuytWMhtHugDH2Ek=;
        b=mMcjs2lpyVW0vt4fHpVmOZN6H71Hqs73q5ZTWllVjPAzWQleeQLmq8QzBWwKpFUvjM
         u6czx7/Zl32uMGUpdGePJExh41+xrmVLlvo4kWXuf0zJXxaHHe7AyUO8qg9JG+m1a3ez
         1Js/F8FVvt9+T21W+MWuGpNb48ZrqFHwdMJg+3a+El3Co4JC0x5dMZXVr1b94ZLNyQJl
         XA5uB4/ev9Num+HMJfOzN7MSWHjby29f4yvZCum+5EzXSQ1LxcQWkeALb0ZUopi+SE89
         GP2EtUVOw+X1uvB+eghocwhVmZRCGDwUaVX+nmS3/4KoZZE+X6Vl+Tqgnp3zb37M7fCz
         1gGw==
X-Forwarded-Encrypted: i=1; AFNElJ9dS/GdKAwJITjbWaBdHvfo2Ru9zHnmEUV0yja/DmL4J1lZDN43Co9UUg/NqY9BbWxsC7i/4e5tKS0GJtkn@vger.kernel.org
X-Gm-Message-State: AOJu0YwgqAN1ed5dNGklGOFbmbMl/HXL+PZ7GhEvYtzzQvw+MvodCAv1
	gZsTb6BbfVMUR95Ht8tqGonbutiJBHbtLRAMe9kF4RhPEHBtBV4XHrQKSPjxdmhLUumIBx52Jas
	YCjjM5tU4MY5Fj0oY2Es+p6ejwYJsT4Q=
X-Gm-Gg: AeBDietPaozr1r6Yyrk2bPc/dBTbZdRiFdOh51pW/0YaAuq8CoHhUlLeflGLu6GsjZD
	OmAOGlloEGAkBafm6NTm6gVEXJWgSwk+D222/XzBCoF2+vglUPxelbXR4TjjAXhnKArlTiT1gvX
	0ylJUEGVerIJ6LnQpKZFo+j0GSWocTWTbVIuaBS28Gs/1WRjotGvecJ5Ds7MifTCsLWl3GB6+E5
	j13HhESnvuS6fK+UXmPvp+ia8a0DUORrcVQUWTofixaY0sWJW7PxCZ1Yf9h4HZL+kZdgweBfyxS
	rEXnXuNPxHpzMG394+ut9A+zSzs50tMOtJgSMAjDaVI4MDuB+vw=
X-Received: by 2002:a17:907:d481:b0:b9c:cb1:a61b with SMTP id
 a640c23a62f3a-b9d76d2d0d6mr1065775566b.16.1776246908809; Wed, 15 Apr 2026
 02:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414185037.3541089-1-ibrahimjirdeh@meta.com> <20260414185037.3541089-3-ibrahimjirdeh@meta.com>
In-Reply-To: <20260414185037.3541089-3-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 15 Apr 2026 11:54:55 +0200
X-Gm-Features: AQROBzDmULfWMk8cQuD_GFtzpkkaFx0-ytzui4eggHRKfXDQwR4iFobVlg96CI8
Message-ID: <CAOQ4uxhXCs3+9csFHk7_FabD5KuDTwgPm0K1BEOjue3Jn6c0vQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: introduce restartable permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 8:51=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This adds support for restarting permission events. The main goal of
> the change is to provide better handling for pending events for lazy
> file loading use cases which may back fanotify events by a long-lived
> daemon. For prior discussion of approaches see [1][2].
>
> In terms of implementation, we add a new control-fd/queue-fd api.
> Control fd returned by fanotify_init keeps fanotify group alive and
> supports operations like fanotify_mark as well as a new ioctl
> FAN_IOC_OPEN_QUEUE_FD to issue user a queue fd.

Nit: s/issue user/open/
Unless I am missing something regarding the terminology

> Queue fd is used
> for reading events and writing back responses. Upon release of
> queue fd, pending permission events are reinserted back into
> notification queue for reprocessing.
>
> Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> events can be added to the mark mask if a group is initialized with
> FAN_RESTARTABLE_EVENTS.
>
> [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr
> [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahi=
mjirdeh@meta.com
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=
=3DqL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>

Looking good, just some minor comments...

> ---
>  fs/notify/fanotify/fanotify.c       |   1 +
>  fs/notify/fanotify/fanotify.h       |   4 +
>  fs/notify/fanotify/fanotify_user.c  | 119 ++++++++++++++++++++++++++--
>  include/linux/fanotify.h            |   1 +
>  include/linux/fsnotify_backend.h    |   3 +
>  include/uapi/linux/fanotify.h       |   6 ++
>  tools/include/uapi/linux/fanotify.h |   6 ++
>  7 files changed, 134 insertions(+), 6 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index bfe884d624e7..b22474e095cd 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -1015,6 +1015,7 @@ static int fanotify_handle_event(struct fsnotify_gr=
oup *group, u32 mask,
>
>  static void fanotify_free_group_priv(struct fsnotify_group *group)
>  {
> +       mutex_destroy(&group->fanotify_data.queue_mutex);
>         put_user_ns(group->user_ns);
>         kfree(group->fanotify_data.merge_hash);
>         if (group->fanotify_data.ucounts)
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index 39e60218df7c..dd64af8313a9 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -552,3 +552,7 @@ static inline u32 fanotify_get_response_errno(int res=
)
>  {
>         return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
>  }
> +
> +extern const struct file_operations fanotify_fops;
> +extern const struct file_operations fanotify_control_fops;
> +extern const struct file_operations fanotify_queue_fops;
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 8203ecf5ea39..26f4c362e018 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1018,6 +1018,10 @@ static ssize_t fanotify_read(struct file *file, ch=
ar __user *buf,
>                         if (file->f_flags & O_NONBLOCK)
>                                 break;
>
> +                       ret =3D 0;
> +                       if (group->shutdown)
> +                               break;
> +

Can you explain why this was needed?
Is it only needed in read() and none of the other queue fd ops?

>                         ret =3D -ERESTARTSYS;
>                         if (signal_pending(current))
>                                 break;
> @@ -1097,6 +1101,7 @@ static ssize_t fanotify_write(struct file *file, co=
nst char __user *buf, size_t
>
>  static void fanotify_restart_pending_events(struct fsnotify_group *group=
)
>  {
> +       mutex_lock(&group->fanotify_data.queue_mutex);
>         spin_lock(&group->notification_lock);
>         while (!list_empty(&group->fanotify_data.access_list)) {
>                 struct fanotify_perm_event *event;
> @@ -1120,6 +1125,16 @@ static void fanotify_restart_pending_events(struct=
 fsnotify_group *group)
>                 spin_lock(&group->notification_lock);
>         }
>         spin_unlock(&group->notification_lock);
> +       group->fanotify_data.queue_opened =3D false;
> +       mutex_unlock(&group->fanotify_data.queue_mutex);
> +}
> +
> +static int fanotify_queue_release(struct inode *ignored, struct file *fi=
le)
> +{
> +       struct fsnotify_group *group =3D file->private_data;
> +
> +       fanotify_restart_pending_events(group);
> +       return 0;
>  }
>
>  static int fanotify_release(struct inode *ignored, struct file *file)
> @@ -1179,6 +1194,47 @@ static int fanotify_release(struct inode *ignored,=
 struct file *file)
>         return 0;
>  }
>
> +static int fanotify_open_queue_fd(struct file *file)
> +{
> +       struct fsnotify_group *group =3D file->private_data;
> +       int f_flags, fd;
> +       struct file *queue_file;
> +
> +       if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
> +               return -EINVAL;
> +
> +       mutex_lock(&group->fanotify_data.queue_mutex);
> +       if (group->fanotify_data.queue_opened) {
> +               fd =3D -EBUSY;
> +               goto out_unlock;
> +       }


Time for us to grow up.
Please retire goto and use:
guard(mutex)(&group->fanotify_data.queue_mutex);

> +
> +       f_flags =3D O_RDWR;
> +       if (group->fanotify_data.flags & FAN_CLOEXEC)
> +               f_flags |=3D O_CLOEXEC;
> +       if (group->fanotify_data.flags & FAN_NONBLOCK)
> +               f_flags |=3D O_NONBLOCK;
> +
> +       fd =3D get_unused_fd_flags(f_flags);
> +       if (fd < 0)
> +               goto out_unlock;
> +
> +       queue_file =3D anon_inode_getfile_fmode("[fanotify-queue]",
> +                                             &fanotify_queue_fops, group=
,
> +                                             f_flags, FMODE_NONOTIFY);
> +       if (IS_ERR(queue_file)) {
> +               put_unused_fd(fd);
> +               fd =3D PTR_ERR(queue_file);
> +               goto out_unlock;
> +       }
> +       fd_install(fd, queue_file);
> +       group->fanotify_data.queue_opened =3D true;
> +
> +out_unlock:
> +       mutex_unlock(&group->fanotify_data.queue_mutex);
> +       return fd;
> +}
> +
>  static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned=
 long arg)
>  {
>         struct fsnotify_group *group;
> @@ -1204,7 +1260,21 @@ static long fanotify_ioctl(struct file *file, unsi=
gned int cmd, unsigned long ar
>         return ret;
>  }
>
> -static const struct file_operations fanotify_fops =3D {
> +static long fanotify_control_ioctl(struct file *file, unsigned int cmd,
> +                                  unsigned long arg)
> +{
> +       int ret =3D -ENOTTY;
> +
> +       switch (cmd) {
> +       case FAN_IOC_OPEN_QUEUE_FD:
> +               ret =3D fanotify_open_queue_fd(file);
> +               break;
> +       }
> +
> +       return ret;
> +}
> +
> +const struct file_operations fanotify_fops =3D {
>         .show_fdinfo    =3D fanotify_show_fdinfo,
>         .poll           =3D fanotify_poll,
>         .read           =3D fanotify_read,
> @@ -1216,6 +1286,23 @@ static const struct file_operations fanotify_fops =
=3D {
>         .llseek         =3D noop_llseek,
>  };
>
> +const struct file_operations fanotify_control_fops =3D {
> +       .show_fdinfo    =3D fanotify_show_fdinfo,
> +       .release        =3D fanotify_release,
> +       .unlocked_ioctl =3D fanotify_control_ioctl,
> +       .llseek         =3D noop_llseek,
> +};
> +
> +const struct file_operations fanotify_queue_fops =3D {
> +       .poll           =3D fanotify_poll,
> +       .read           =3D fanotify_read,
> +       .write          =3D fanotify_write,
> +       .release        =3D fanotify_queue_release,
> +       .unlocked_ioctl =3D fanotify_ioctl,
> +       .compat_ioctl   =3D compat_ptr_ioctl,
> +       .llseek         =3D noop_llseek,
> +};
> +
>  static int fanotify_find_path(int dfd, const char __user *filename,
>                               struct path *path, unsigned int flags, __u6=
4 mask,
>                               unsigned int obj_type)
> @@ -1637,6 +1724,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         int f_flags, fd;
>         unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
>         unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
> +       unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENT=
S;
>         unsigned int internal_flags =3D 0;
>
>         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
> @@ -1715,10 +1803,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
>             (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID=
)))
>                 return -EINVAL;
>
> -       f_flags =3D O_RDWR;
> +       /*
> +        * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
> +        * FAN_CLASS_PRE_CONTENT
> +        */
> +       if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
> +               return -EINVAL;
> +
> +       f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
>         if (flags & FAN_CLOEXEC)
>                 f_flags |=3D O_CLOEXEC;
> -       if (flags & FAN_NONBLOCK)
> +       if (!restartable_events && (flags & FAN_NONBLOCK))
>                 f_flags |=3D O_NONBLOCK;
>
>         CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
> @@ -1751,6 +1846,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         init_waitqueue_head(&group->fanotify_data.access_waitq);
>         INIT_LIST_HEAD(&group->fanotify_data.access_list);
>         INIT_LIST_HEAD(&group->fanotify_data.perm_grp_list);
> +       mutex_init(&group->fanotify_data.queue_mutex);
>         switch (class) {
>         case FAN_CLASS_NOTIF:
>                 group->priority =3D FSNOTIFY_PRIO_NORMAL;
> @@ -1778,7 +1874,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags,=
 unsigned int, event_f_flags)
>         }
>
>         fd =3D FD_ADD(f_flags,
> -                   anon_inode_getfile_fmode("[fanotify]", &fanotify_fops=
,
> +                   anon_inode_getfile_fmode("[fanotify]",
> +                                            (restartable_events ? &fanot=
ify_control_fops :
> +                                            &fanotify_fops),
>                                              group, f_flags, FMODE_NONOTI=
FY));
>         if (fd >=3D 0)
>                 retain_and_null_ptr(group);
> @@ -1996,7 +2094,8 @@ static int do_fanotify_mark(int fanotify_fd, unsign=
ed int flags, __u64 mask,
>                 return -EBADF;
>
>         /* verify that this is indeed an fanotify instance */
> -       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
> +       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
> +               fd_file(f)->f_op !=3D &fanotify_control_fops))
>                 return -EINVAL;
>         group =3D fd_file(f)->private_data;
>
> @@ -2032,6 +2131,14 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                  group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
>                 return -EINVAL;
>
> +       /*
> +        * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> +        * permission events
> +        */
> +       if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> +               !fanotify_is_perm_event(mask))

This check is problematic.
Users are allowed to add/remove FANOTIFY_EVENT_FLAGS bits on the mark
with an already existing permission events mask.

We can explicitly allow that like in the very ugly line:
        if (mask &
~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&

I don't like it, but I do not have a better suggestion.

> +               return -EINVAL;
> +
>         if (mask & FAN_FS_ERROR &&
>             mark_type !=3D FAN_MARK_FILESYSTEM)
>                 return -EINVAL;
> @@ -2221,7 +2328,7 @@ static int __init fanotify_user_setup(void)
>                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
>
>         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAGS)=
;
> -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
>         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
>
>         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> index 879cff5eccd4..38854a1d6485 100644
> --- a/include/linux/fanotify.h
> +++ b/include/linux/fanotify.h
> @@ -37,6 +37,7 @@
>                                          FAN_REPORT_TID | \
>                                          FAN_REPORT_PIDFD | \
>                                          FAN_REPORT_FD_ERROR | \
> +                                        FAN_RESTARTABLE_EVENTS | \
>                                          FAN_UNLIMITED_QUEUE | \
>                                          FAN_UNLIMITED_MARKS)
>
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_ba=
ckend.h
> index 573c796513bf..f7003013b840 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -275,6 +275,9 @@ struct fsnotify_group {
>                         mempool_t error_events_pool;
>                         /* chained on perm_group_list */
>                         struct list_head perm_grp_list;
> +                       /* protects queue fd open/release */
> +                       struct mutex queue_mutex;
> +                       bool queue_opened;
>                 } fanotify_data;
>  #endif /* CONFIG_FANOTIFY */
>         };
> diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.=
h
> index e710967c7c26..65fe62a4fcf8 100644
> --- a/include/uapi/linux/fanotify.h
> +++ b/include/uapi/linux/fanotify.h
> @@ -67,6 +67,7 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +#define FAN_RESTARTABLE_EVENTS 0x00008000      /* enable control-fd/queu=
e-fd api */

O.C.D. nit: this looks like it is part of the section
/* Flags to determine fanotify event format */

Please add a newline and also start from a new nibble (0x00010000)
to avoid colliding with WIP constant FAN_REPORT_NSID.

>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
>                                 (long)(meta)->event_len >=3D (long)FAN_EV=
ENT_METADATA_LEN && \
>                                 (long)(meta)->event_len <=3D (long)(len))
>
> +/* fanotify ioctls */
> +
> +/* Issue a queue fd used in control-fd api to read and respond to events=
 */
> +#define FAN_IOC_OPEN_QUEUE_FD  _IO('F', 0xF0)
> +
>  #endif /* _UAPI_LINUX_FANOTIFY_H */
> diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/lin=
ux/fanotify.h
> index e710967c7c26..65fe62a4fcf8 100644
> --- a/tools/include/uapi/linux/fanotify.h
> +++ b/tools/include/uapi/linux/fanotify.h
> @@ -67,6 +67,7 @@
>  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target i=
d  */
>  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report e=
rror */
>  #define FAN_REPORT_MNT         0x00004000      /* Report mount events */
> +#define FAN_RESTARTABLE_EVENTS 0x00008000      /* enable control-fd/queu=
e-fd api */
>
>  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
>  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> @@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
>                                 (long)(meta)->event_len >=3D (long)FAN_EV=
ENT_METADATA_LEN && \
>                                 (long)(meta)->event_len <=3D (long)(len))
>
> +/* fanotify ioctls */
> +
> +/* Issue a queue fd used in control-fd api to read and respond to events=
 */
> +#define FAN_IOC_OPEN_QUEUE_FD  _IO('F', 0xF0)
> +

Nit: "Issue"? Why not "open"?

Thanks,
Amir.
