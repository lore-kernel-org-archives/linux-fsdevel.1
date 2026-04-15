Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EA831619B
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 16:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776269065; cv=pass; b=O4M8OR0Y6YodxU7P3ClbmKoGRItpZBMT9oJYPRVE6CJi+odaD4dzA/MxeWKp1naEgKFxV4RhqjV6ur3xXq9RjOlgr2xzggozqkvwokCiTlrK1zZbMZR4YrLPh7v853HswbMPLQtCK00Van2pLNzwUN/HLvdbyGZ7WwkCKqCwRiw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776269065; c=relaxed/simple;
	bh=PI7OruznPU2kuAE9NBgJ59reK7/IsRapDQQ77kCsQiA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjwGb+t37CD5mHXz378H7m9aCiSU9hN3ABt1r36pywA7JmuOpI1n+2UCnHxRq46otl4A3zLUrleSand1vUFbEIIsY9I9JNUienLBOFxD1elOKKlQccoW6TqHUkLOwF8CsXOn6Gl/gwnvMju75h5KjZB6FGiqOXgPOiGGVvDN1Tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=knEuL7pf; arc=pass smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="knEuL7pf"
Received: from pps.filterd (m0528008.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F6Dg9Y3863046
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:04:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=pQ+BmTkA8H0gw1KdBNu4Lvz2WiYmwT21h+glDuWUe7M=; b=knEuL7pf+RbR
	YXXalobqaRKJ0RbRD8fQe2l+DNBYIp/KdQsMVtfZyi20aUFdLB17Q9I7BchZdq08
	tZMUNsNRUUJTnzT9eXLDR16H4nxXPSwLpZYVWX+xvGS0z6wMBcWPiNdeYGbKP4GJ
	d/QKjxToHLtmi321lntr4jrYCLy9cW3zhP6RyhaqM2/nSrosGDs8DY6qFk8S72Wz
	st1IpyZv72khFDJsHruokrDrJZWEFryg1khsvg7C/ct742VQ0q987bEAlWNHhu06
	YKFXqWc8KPtSe9YoZPXJJGEcUV51+MLl/tkzjyM/+qruvPkouywPW3deZRHRh5hH
	AA8qo5/50Q==
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dh84vv2eq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:04:22 -0700 (PDT)
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6710c87fa88so4894704a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 09:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776269061; cv=none;
        d=google.com; s=arc-20240605;
        b=OxbDLxfHHTEmXzrRbDotlTcx6JahHexaLYqR8y8p49Hkg5f+fg6qDwSJof5L/ubLdA
         KGi5hIw3HyCdsCy1/KoDdpNiYlafFcQRAulRv3NNup88d6botChYZYgtNohpNE9wTQox
         hdSoLFuzzODeGyIO9CIndRNBUHZhdYF6e7nojMvqfKvfNcHNDPKG+1+QTY9FjPLdB5Kj
         9Lu7/9nD2gHu296D9O8leMfEO3xReAN0EcWERutPG/NBPF3PYTqt968kkG4RIFKplxnl
         uIcFwiVRGFKpLM/xXJLFLZ9xb2T7FiEcZSORgfXgBD/Oes/eA6IMO8Cd6KCbGeBo2aA3
         Db/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=pQ+BmTkA8H0gw1KdBNu4Lvz2WiYmwT21h+glDuWUe7M=;
        fh=nB5Z6Hq5ok8bIIAdPRf53CLYSpIHi/t51LdorZ0DR3c=;
        b=EhIF3UVtSkvIVKlcLxoxU3pYp9SQJto13x8Aj4CkcYKnoErwuXMXG057SBDohRWTz4
         Y0LlGS1oEor7RgAw4ei5SOmJrke0b6/VzTBMkKLDTbb8kLgKdyfr3Xncne2y8voATDYT
         EEOFoHngYOSGnDfFftWc6Az/U7ixFNY7yAgdul3WHZ6/DgcRYr2KZj7FRK9WMVJ4hIUq
         wuYanxMYP8uSbibgIgX4gLpSCpPV0+MXImmAcNZ0ZF6zhln8uwuYaNzXPlHiVRlgUsV8
         nnSlVKkURMgkcMYAD/U48900ZZkkwXt7mx+s5D37HVp9yR4CPILA8AVGPF5AU+pSw50O
         8SBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776269061; x=1776873861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQ+BmTkA8H0gw1KdBNu4Lvz2WiYmwT21h+glDuWUe7M=;
        b=sR6UzydrSbJJW4jXbI2WgAymCdt2u/Csf1zm+6ALWcMKCtisfYxsONX5Sx2mnyeQkR
         cEmmeAJSyi7Zy+7U8Q9hh600Z8wOh5xJ0/esI4qQO8VGOaqnp/C4zwr3s4mSVzIoEjZv
         1ZqTYNCURQL2ZIn3o93WWjEG4IuBIZPx0QLYyCV8XcfhMpXYU1nxjw/RJwQwZAzP9F6n
         aRHDbnm/HMvoRzZ9ZLmoaFMnIcRXhtSC1NIi9dtRIJuLql/LwN7h62mRbwwbuuC8Ugoo
         kubO9L98u1oMsjPxmTOG6X4BfTZSqyN/MNFR14WrhAYYYK9VViVYI5p/1OF6AzGhmbuC
         +W8g==
X-Forwarded-Encrypted: i=1; AFNElJ/sBYZRmYNZO2wEGrhXb5xyf5a4X6oQb4Ukz3Go2dJfbHJ67I6diVvRhoOMK+KQYPfMF9tmR1N38bODsHEn@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn2F5ZHH27UP7c+hhBhJEQ3kIE44joR1zxZsba80HcU35vTe6e
	UUXZvxGpFhCqJgMzCN/K664RfcePFJD1g6TxYdRSRJ/EW/JqfrhHwl0Ll8vy2kiD8JMozHhbQeV
	P2zKoWgTw3vVhCSTWMViEM53eBHoUFLiR2UD3qMI22ytXMZSXXvxsVv+mFZnBjZS/29Pa99pKrf
	/jjTuxvTGE0WFyrr5jV5L8DxX0fg7sE0HerMAhtJJA
X-Gm-Gg: AeBDiet96FLBFZflor1dm2vn9SeR1D7LNc9HjWB6s3Mosi5Xnm9uZ5PUrZ4Qhn0JmqT
	e689P9jtjiGMOS3CJhTyvk6JAK2GXwNu/qV5uZ/2bEjPDOwWphO4U9I44Tnk5AYEaAdft3p2F2+
	ZUSqg+ry/pLUQN1OFCIt+vbRdi1PHVTtPwxqe0dzaoebnMISImPM6aLSEhCE3mpkJPPifXym49i
	DGFSz+8drlHEGiN
X-Received: by 2002:a05:6402:360d:b0:670:6c27:91d0 with SMTP id 4fb4d7f45d1cf-672711ca348mr62532a12.7.1776269060849;
        Wed, 15 Apr 2026 09:04:20 -0700 (PDT)
X-Received: by 2002:a05:6402:360d:b0:670:6c27:91d0 with SMTP id
 4fb4d7f45d1cf-672711ca348mr62495a12.7.1776269060102; Wed, 15 Apr 2026
 09:04:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414185037.3541089-1-ibrahimjirdeh@meta.com>
 <20260414185037.3541089-3-ibrahimjirdeh@meta.com> <CAOQ4uxhXCs3+9csFHk7_FabD5KuDTwgPm0K1BEOjue3Jn6c0vQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxhXCs3+9csFHk7_FabD5KuDTwgPm0K1BEOjue3Jn6c0vQ@mail.gmail.com>
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Date: Wed, 15 Apr 2026 09:04:08 -0700
X-Gm-Features: AQROBzByZeRzD1LCTdwamZdVFA9LPlVZt7SOqk45-frSqQSGzYIg4X86dQ1NGl8
Message-ID: <CAAwtZY4CLq05NUxej4-LL+B=fQWsHzv4ruVWAaKZ4y9n9YF6DA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] fanotify: introduce restartable permission events
To: Amir Goldstein <amir73il@gmail.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com,
        linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: GmtHCLQg-LwgYFJtO98g2l5exx3umZkk
X-Authority-Analysis: v=2.4 cv=OYioyBTY c=1 sm=1 tr=0 ts=69dfb707 cx=c_pps
 a=DTy5UCxgudPLKrSn28m7Kw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=_1IyUuN4QrATX339ibzo:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=3GVVnTLXv1JIgPfLRUAA:9
 a=QEXdDO2ut3YA:10 a=VzYV69SsQLkmnS9OQLw-:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE0OSBTYWx0ZWRfX5NToJlcp3Qvv
 aH/d4yRwWJzkzQXuC7Z4PSnLed7CdPw7y0846An8rmwsw47eEqXRtGMz/PvB6dKVm4PS4O7FtzA
 ulpyzd4Lexo7msenv4yHR9DwmxLB68xKayKVBeoW3NqBAloAQ01WrrXLxPpYogezG6ezuL9qVyD
 dOgNk7/7r0n0LOT7Oxsxi6PPXJh+QcehjrLClUf0eE2j3el3WUDKmIFdoGVyUSP7LFjkjTKv+J4
 csdZWiLTAThdbjrAl4JwYpbVtE81UaX45ODLSkAvVt79ckWkiYDj9e6p1FNivG0gmBUHyQrC6NP
 qSBiyaIB98eJ54/yQX9zN5vEhCxvVktuQvqP+MtHGksi6bcvuJ3bWqo/Nk5uH+6gXZxnlUPCil2
 KjB0LwFJ03hOgAJ6NNrs2vWKb5FZ1wRX4Ukc9d//UKew9X33cVkN3iGI6A9e5et0IVyb3KjH1TW
 9EGZWB4OySOA+Bzmhrg==
X-Proofpoint-GUID: GmtHCLQg-LwgYFJtO98g2l5exx3umZkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01

On Wed, Apr 15, 2026 at 2:55=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Tue, Apr 14, 2026 at 8:51=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@met=
a.com> wrote:
> >
> > This adds support for restarting permission events. The main goal of
> > the change is to provide better handling for pending events for lazy
> > file loading use cases which may back fanotify events by a long-lived
> > daemon. For prior discussion of approaches see [1][2].
> >
> > In terms of implementation, we add a new control-fd/queue-fd api.
> > Control fd returned by fanotify_init keeps fanotify group alive and
> > supports operations like fanotify_mark as well as a new ioctl
> > FAN_IOC_OPEN_QUEUE_FD to issue user a queue fd.
>
> Nit: s/issue user/open/
> Unless I am missing something regarding the terminology
>
> > Queue fd is used
> > for reading events and writing back responses. Upon release of
> > queue fd, pending permission events are reinserted back into
> > notification queue for reprocessing.
> >
> > Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> > In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> > with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> > events can be added to the mark mask if a group is initialized with
> > FAN_RESTARTABLE_EVENTS.
> >
> > [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi=
6bi44canfsg2aajgkialt@c3ujlrjzkppr
> > [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibra=
himjirdeh@meta.com
> >
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6=
g=3DqL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> > Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
>
> Looking good, just some minor comments...
>
> > ---
> >  fs/notify/fanotify/fanotify.c       |   1 +
> >  fs/notify/fanotify/fanotify.h       |   4 +
> >  fs/notify/fanotify/fanotify_user.c  | 119 ++++++++++++++++++++++++++--
> >  include/linux/fanotify.h            |   1 +
> >  include/linux/fsnotify_backend.h    |   3 +
> >  include/uapi/linux/fanotify.h       |   6 ++
> >  tools/include/uapi/linux/fanotify.h |   6 ++
> >  7 files changed, 134 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotif=
y.c
> > index bfe884d624e7..b22474e095cd 100644
> > --- a/fs/notify/fanotify/fanotify.c
> > +++ b/fs/notify/fanotify/fanotify.c
> > @@ -1015,6 +1015,7 @@ static int fanotify_handle_event(struct fsnotify_=
group *group, u32 mask,
> >
> >  static void fanotify_free_group_priv(struct fsnotify_group *group)
> >  {
> > +       mutex_destroy(&group->fanotify_data.queue_mutex);
> >         put_user_ns(group->user_ns);
> >         kfree(group->fanotify_data.merge_hash);
> >         if (group->fanotify_data.ucounts)
> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index 39e60218df7c..dd64af8313a9 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -552,3 +552,7 @@ static inline u32 fanotify_get_response_errno(int r=
es)
> >  {
> >         return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
> >  }
> > +
> > +extern const struct file_operations fanotify_fops;
> > +extern const struct file_operations fanotify_control_fops;
> > +extern const struct file_operations fanotify_queue_fops;
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 8203ecf5ea39..26f4c362e018 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1018,6 +1018,10 @@ static ssize_t fanotify_read(struct file *file, =
char __user *buf,
> >                         if (file->f_flags & O_NONBLOCK)
> >                                 break;
> >
> > +                       ret =3D 0;
> > +                       if (group->shutdown)
> > +                               break;
> > +
>
> Can you explain why this was needed?
> Is it only needed in read() and none of the other queue fd ops?

This is primarily added in case a read on queue fd occurs
after control fd is released. Without it we will block
indefinitely, returning EOF here seemed preferable.
Regarding other queue ops, I think they are fine as
they will return ENOENT (write) or 0 (poll / FIONREAD)
on empty access / notification lists. Although I realize
queue fd also needs to keep a group reference alive,
I can update that in the next version.

>
> >                         ret =3D -ERESTARTSYS;
> >                         if (signal_pending(current))
> >                                 break;
> > @@ -1097,6 +1101,7 @@ static ssize_t fanotify_write(struct file *file, =
const char __user *buf, size_t
> >
> >  static void fanotify_restart_pending_events(struct fsnotify_group *gro=
up)
> >  {
> > +       mutex_lock(&group->fanotify_data.queue_mutex);
> >         spin_lock(&group->notification_lock);
> >         while (!list_empty(&group->fanotify_data.access_list)) {
> >                 struct fanotify_perm_event *event;
> > @@ -1120,6 +1125,16 @@ static void fanotify_restart_pending_events(stru=
ct fsnotify_group *group)
> >                 spin_lock(&group->notification_lock);
> >         }
> >         spin_unlock(&group->notification_lock);
> > +       group->fanotify_data.queue_opened =3D false;
> > +       mutex_unlock(&group->fanotify_data.queue_mutex);
> > +}
> > +
> > +static int fanotify_queue_release(struct inode *ignored, struct file *=
file)
> > +{
> > +       struct fsnotify_group *group =3D file->private_data;
> > +
> > +       fanotify_restart_pending_events(group);
> > +       return 0;
> >  }
> >
> >  static int fanotify_release(struct inode *ignored, struct file *file)
> > @@ -1179,6 +1194,47 @@ static int fanotify_release(struct inode *ignore=
d, struct file *file)
> >         return 0;
> >  }
> >
> > +static int fanotify_open_queue_fd(struct file *file)
> > +{
> > +       struct fsnotify_group *group =3D file->private_data;
> > +       int f_flags, fd;
> > +       struct file *queue_file;
> > +
> > +       if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
> > +               return -EINVAL;
> > +
> > +       mutex_lock(&group->fanotify_data.queue_mutex);
> > +       if (group->fanotify_data.queue_opened) {
> > +               fd =3D -EBUSY;
> > +               goto out_unlock;
> > +       }
>
>
> Time for us to grow up.
> Please retire goto and use:
> guard(mutex)(&group->fanotify_data.queue_mutex);
>
> > +
> > +       f_flags =3D O_RDWR;
> > +       if (group->fanotify_data.flags & FAN_CLOEXEC)
> > +               f_flags |=3D O_CLOEXEC;
> > +       if (group->fanotify_data.flags & FAN_NONBLOCK)
> > +               f_flags |=3D O_NONBLOCK;
> > +
> > +       fd =3D get_unused_fd_flags(f_flags);
> > +       if (fd < 0)
> > +               goto out_unlock;
> > +
> > +       queue_file =3D anon_inode_getfile_fmode("[fanotify-queue]",
> > +                                             &fanotify_queue_fops, gro=
up,
> > +                                             f_flags, FMODE_NONOTIFY);
> > +       if (IS_ERR(queue_file)) {
> > +               put_unused_fd(fd);
> > +               fd =3D PTR_ERR(queue_file);
> > +               goto out_unlock;
> > +       }
> > +       fd_install(fd, queue_file);
> > +       group->fanotify_data.queue_opened =3D true;
> > +
> > +out_unlock:
> > +       mutex_unlock(&group->fanotify_data.queue_mutex);
> > +       return fd;
> > +}
> > +
> >  static long fanotify_ioctl(struct file *file, unsigned int cmd, unsign=
ed long arg)
> >  {
> >         struct fsnotify_group *group;
> > @@ -1204,7 +1260,21 @@ static long fanotify_ioctl(struct file *file, un=
signed int cmd, unsigned long ar
> >         return ret;
> >  }
> >
> > -static const struct file_operations fanotify_fops =3D {
> > +static long fanotify_control_ioctl(struct file *file, unsigned int cmd=
,
> > +                                  unsigned long arg)
> > +{
> > +       int ret =3D -ENOTTY;
> > +
> > +       switch (cmd) {
> > +       case FAN_IOC_OPEN_QUEUE_FD:
> > +               ret =3D fanotify_open_queue_fd(file);
> > +               break;
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +const struct file_operations fanotify_fops =3D {
> >         .show_fdinfo    =3D fanotify_show_fdinfo,
> >         .poll           =3D fanotify_poll,
> >         .read           =3D fanotify_read,
> > @@ -1216,6 +1286,23 @@ static const struct file_operations fanotify_fop=
s =3D {
> >         .llseek         =3D noop_llseek,
> >  };
> >
> > +const struct file_operations fanotify_control_fops =3D {
> > +       .show_fdinfo    =3D fanotify_show_fdinfo,
> > +       .release        =3D fanotify_release,
> > +       .unlocked_ioctl =3D fanotify_control_ioctl,
> > +       .llseek         =3D noop_llseek,
> > +};
> > +
> > +const struct file_operations fanotify_queue_fops =3D {
> > +       .poll           =3D fanotify_poll,
> > +       .read           =3D fanotify_read,
> > +       .write          =3D fanotify_write,
> > +       .release        =3D fanotify_queue_release,
> > +       .unlocked_ioctl =3D fanotify_ioctl,
> > +       .compat_ioctl   =3D compat_ptr_ioctl,
> > +       .llseek         =3D noop_llseek,
> > +};
> > +
> >  static int fanotify_find_path(int dfd, const char __user *filename,
> >                               struct path *path, unsigned int flags, __=
u64 mask,
> >                               unsigned int obj_type)
> > @@ -1637,6 +1724,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >         int f_flags, fd;
> >         unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
> >         unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
> > +       unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVE=
NTS;
> >         unsigned int internal_flags =3D 0;
> >
> >         pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
> > @@ -1715,10 +1803,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >             (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_F=
ID)))
> >                 return -EINVAL;
> >
> > -       f_flags =3D O_RDWR;
> > +       /*
> > +        * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
> > +        * FAN_CLASS_PRE_CONTENT
> > +        */
> > +       if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
> > +               return -EINVAL;
> > +
> > +       f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
> >         if (flags & FAN_CLOEXEC)
> >                 f_flags |=3D O_CLOEXEC;
> > -       if (flags & FAN_NONBLOCK)
> > +       if (!restartable_events && (flags & FAN_NONBLOCK))
> >                 f_flags |=3D O_NONBLOCK;
> >
> >         CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
> > @@ -1751,6 +1846,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >         init_waitqueue_head(&group->fanotify_data.access_waitq);
> >         INIT_LIST_HEAD(&group->fanotify_data.access_list);
> >         INIT_LIST_HEAD(&group->fanotify_data.perm_grp_list);
> > +       mutex_init(&group->fanotify_data.queue_mutex);
> >         switch (class) {
> >         case FAN_CLASS_NOTIF:
> >                 group->priority =3D FSNOTIFY_PRIO_NORMAL;
> > @@ -1778,7 +1874,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >         }
> >
> >         fd =3D FD_ADD(f_flags,
> > -                   anon_inode_getfile_fmode("[fanotify]", &fanotify_fo=
ps,
> > +                   anon_inode_getfile_fmode("[fanotify]",
> > +                                            (restartable_events ? &fan=
otify_control_fops :
> > +                                            &fanotify_fops),
> >                                              group, f_flags, FMODE_NONO=
TIFY));
> >         if (fd >=3D 0)
> >                 retain_and_null_ptr(group);
> > @@ -1996,7 +2094,8 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >                 return -EBADF;
> >
> >         /* verify that this is indeed an fanotify instance */
> > -       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
> > +       if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
> > +               fd_file(f)->f_op !=3D &fanotify_control_fops))
> >                 return -EINVAL;
> >         group =3D fd_file(f)->private_data;
> >
> > @@ -2032,6 +2131,14 @@ static int do_fanotify_mark(int fanotify_fd, uns=
igned int flags, __u64 mask,
> >                  group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
> >                 return -EINVAL;
> >
> > +       /*
> > +        * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> > +        * permission events
> > +        */
> > +       if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> > +               !fanotify_is_perm_event(mask))
>
> This check is problematic.
> Users are allowed to add/remove FANOTIFY_EVENT_FLAGS bits on the mark
> with an already existing permission events mask.
>
> We can explicitly allow that like in the very ugly line:
>         if (mask &
> ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>
> I don't like it, but I do not have a better suggestion.
>
> > +               return -EINVAL;
> > +
> >         if (mask & FAN_FS_ERROR &&
> >             mark_type !=3D FAN_MARK_FILESYSTEM)
> >                 return -EINVAL;
> > @@ -2221,7 +2328,7 @@ static int __init fanotify_user_setup(void)
> >                                      FANOTIFY_DEFAULT_MAX_USER_MARKS);
> >
> >         BUILD_BUG_ON(FANOTIFY_INIT_FLAGS & FANOTIFY_INTERNAL_GROUP_FLAG=
S);
> > -       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 14);
> > +       BUILD_BUG_ON(HWEIGHT32(FANOTIFY_INIT_FLAGS) !=3D 15);
> >         BUILD_BUG_ON(HWEIGHT32(FANOTIFY_MARK_FLAGS) !=3D 11);
> >
> >         fanotify_mark_cache =3D KMEM_CACHE(fanotify_mark,
> > diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
> > index 879cff5eccd4..38854a1d6485 100644
> > --- a/include/linux/fanotify.h
> > +++ b/include/linux/fanotify.h
> > @@ -37,6 +37,7 @@
> >                                          FAN_REPORT_TID | \
> >                                          FAN_REPORT_PIDFD | \
> >                                          FAN_REPORT_FD_ERROR | \
> > +                                        FAN_RESTARTABLE_EVENTS | \
> >                                          FAN_UNLIMITED_QUEUE | \
> >                                          FAN_UNLIMITED_MARKS)
> >
> > diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_=
backend.h
> > index 573c796513bf..f7003013b840 100644
> > --- a/include/linux/fsnotify_backend.h
> > +++ b/include/linux/fsnotify_backend.h
> > @@ -275,6 +275,9 @@ struct fsnotify_group {
> >                         mempool_t error_events_pool;
> >                         /* chained on perm_group_list */
> >                         struct list_head perm_grp_list;
> > +                       /* protects queue fd open/release */
> > +                       struct mutex queue_mutex;
> > +                       bool queue_opened;
> >                 } fanotify_data;
> >  #endif /* CONFIG_FANOTIFY */
> >         };
> > diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotif=
y.h
> > index e710967c7c26..65fe62a4fcf8 100644
> > --- a/include/uapi/linux/fanotify.h
> > +++ b/include/uapi/linux/fanotify.h
> > @@ -67,6 +67,7 @@
> >  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target=
 id  */
> >  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report=
 error */
> >  #define FAN_REPORT_MNT         0x00004000      /* Report mount events =
*/
> > +#define FAN_RESTARTABLE_EVENTS 0x00008000      /* enable control-fd/qu=
eue-fd api */
>
> O.C.D. nit: this looks like it is part of the section
> /* Flags to determine fanotify event format */
>
> Please add a newline and also start from a new nibble (0x00010000)
> to avoid colliding with WIP constant FAN_REPORT_NSID.

Will update the nibble in the next version along with other suggestions.

>
> >
> >  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
> >  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> > @@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
> >                                 (long)(meta)->event_len >=3D (long)FAN_=
EVENT_METADATA_LEN && \
> >                                 (long)(meta)->event_len <=3D (long)(len=
))
> >
> > +/* fanotify ioctls */
> > +
> > +/* Issue a queue fd used in control-fd api to read and respond to even=
ts */
> > +#define FAN_IOC_OPEN_QUEUE_FD  _IO('F', 0xF0)
> > +
> >  #endif /* _UAPI_LINUX_FANOTIFY_H */
> > diff --git a/tools/include/uapi/linux/fanotify.h b/tools/include/uapi/l=
inux/fanotify.h
> > index e710967c7c26..65fe62a4fcf8 100644
> > --- a/tools/include/uapi/linux/fanotify.h
> > +++ b/tools/include/uapi/linux/fanotify.h
> > @@ -67,6 +67,7 @@
> >  #define FAN_REPORT_TARGET_FID  0x00001000      /* Report dirent target=
 id  */
> >  #define FAN_REPORT_FD_ERROR    0x00002000      /* event->fd can report=
 error */
> >  #define FAN_REPORT_MNT         0x00004000      /* Report mount events =
*/
> > +#define FAN_RESTARTABLE_EVENTS 0x00008000      /* enable control-fd/qu=
eue-fd api */
> >
> >  /* Convenience macro - FAN_REPORT_NAME requires FAN_REPORT_DIR_FID */
> >  #define FAN_REPORT_DFID_NAME   (FAN_REPORT_DIR_FID | FAN_REPORT_NAME)
> > @@ -271,4 +272,9 @@ struct fanotify_response_info_audit_rule {
> >                                 (long)(meta)->event_len >=3D (long)FAN_=
EVENT_METADATA_LEN && \
> >                                 (long)(meta)->event_len <=3D (long)(len=
))
> >
> > +/* fanotify ioctls */
> > +
> > +/* Issue a queue fd used in control-fd api to read and respond to even=
ts */
> > +#define FAN_IOC_OPEN_QUEUE_FD  _IO('F', 0xF0)
> > +
>
> Nit: "Issue"? Why not "open"?
>
> Thanks,
> Amir.
