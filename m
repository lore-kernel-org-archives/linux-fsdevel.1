Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5040E3CD8AA
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853369; cv=pass; b=DMeXugWm9SAW3bmPKY2x8/wdkx5muK0pgaRFFdYmAAXeNeFHIGJpKXbc0+gPug5ohECp+Y2UxyiYKjLBWi3eB83DriNobumNQUBq+aEveVbTnxzC/7OdLFrSR8FmLuZbIzD2iyE/y2EzmV2e+fLY2m9Edt9wIAOp+TqvwPr/lVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853369; c=relaxed/simple;
	bh=ZhyKPp7V0NlfM5yBNlhPPbjkma+AXOy1Z0NByAAyVsA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TT1BYw3WQ0eiGE8qd8tAkPms9GiDblhA7UNCTv8gR3GMOh/b0CSmrapFunQqVUK8E9vPWEQL13M5L/YBwhJyN35RTGcqL63h7gHTs9RRhSWNq/b1IYSyEp3YTrGe9VuO6WcUcPXi6mGVAePfBGxJSg6fa868TSQFtia3f4lePeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=GQG0IpxH; arc=pass smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="GQG0IpxH"
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63M8wj7R2119700
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 03:22:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=VPH2HSAnsWmq+Zj7jy0EyuFxGgAZJalNb+S/iKLwe1g=; b=GQG0IpxHdvlR
	0pGwxsAcwJlkC8N4GP67hcj1UKy1p7OpJH34woTC0+gSE4MHAsurNTe7T4bU/f3B
	QtHaV1urRdtQvjRXplwtagoZbMrJBrbyGBkauJxfiLkwCoDoF+t8amwWIUfCFoXp
	2JFSKNFj994ShO2uCnKXqWyX8ygzJEHuFaNA0LlxPofMAHByKGUs4Qq2l9j1Ii8T
	XPmyL8HgKAY1P33RHn57Zsve7SqHLtwl3k4rNdx/mQ0VZc8g964EI3w5MriBBFzc
	uotW38tzm59PwZAiAl0y4ju+aFQkNayKimhaeJvNv+R5gO2hw3/SbywW8XmtrKXV
	zH/1RMR3ww==
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dpepacg5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 03:22:46 -0700 (PDT)
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-6749e8562a7so3275302a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 03:22:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776853365; cv=none;
        d=google.com; s=arc-20240605;
        b=bLZ6770ivc7njDAWqefP/XJGIzqkEj4BhDoNWzt0vORvwN7IvfqDbRRxk85xdZK++v
         UlJ20xFDg9nRLG/ITng0fUKk6LPids6yIj+MBO8XFzuUntQTTukqzCLFkk3S4o1SyLiL
         Hjak7ySU78VWCEf5OwF8OXS6X/JSCEFvPoK3jPnSj86cI6d83VXBR7rfbxOWJSGFviV3
         nVdcj12h3e90/uGNfk+/N2GF2oD7lzec+oSJcXfONp2PWVQEOs0zHlsx8hU9YiL/Cjyg
         q1MudKn4aMtJJhUce5J7vfroScjs1oGnMn7Do1FcMcMz5kOoNN0tQ8xfwEO7dewFB3hB
         f/WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=VPH2HSAnsWmq+Zj7jy0EyuFxGgAZJalNb+S/iKLwe1g=;
        fh=A/4+lV4IN5Ad9K+IJl4hkd7+czNsA9+TD7g+/a+ays0=;
        b=atlS7en0zLl7E5D1+kSLG1HKoxXlsHXrRkyDSEvfKuyyNNMHr9erKIemnZ92yEYMfF
         DPD1olKAglqvLlUKwmQ9mccPphxeVqrFY9E+YPW5sZ9qsUzwf9K4/BZXBZc8+VOviq2/
         +QiuDkphH7JsxYYqqYI6kIhUJI6EtPvYTTtuHesvmC/OQa1qjw2m4jMPIef6FvMqn5TH
         fWcY3CJO3ALnmoeHFXoAHvAkcrlfE7UpFQnGunMEuqE/qr+DCP5n54d8MPqGGA5igWVI
         XU+RlG1nohRgtoHgHiZIbR+5k9f4hCxOpi2NCRGFJbbjWom0hMWR3i/qJWahTvnTGFxo
         Cpyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776853365; x=1777458165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VPH2HSAnsWmq+Zj7jy0EyuFxGgAZJalNb+S/iKLwe1g=;
        b=T0bh6Kner8te600N2r63dfvrma8q0j9kQi29RTS2E3h0iA/+VZSjhfQXkPwcPYBDrY
         /OBgHn8nmhDBe5z/BnxZn1NmTT+V+pp96TTihqd8a5WpplnEn+S8+DVIPKwkFHqFS0gD
         mEsrzgqcGkb/JvwXFhBP5Ip5OAkmWRMdmxk6Nc3HhZiS0+K6VDIlZkqBocq1ACup51PN
         7ON+fojds2edx9fIZNtD3W4GjdY+FsBTms2VPiJ4uRJDIvLdZWaNlWqyVtX5z3/sBS2M
         mEQPCrnHCwkz372fl8j/H3vaISE84/litBGRBsjrpyS4ndZXk5ZRq2+X9YwfLvjkSROy
         xoEw==
X-Forwarded-Encrypted: i=1; AFNElJ9vXHeSWDmUEatxF+Q2hYDbcwfL1Wir9+6Pb0H0AlXbdlv7phDkfGZBUuFjfDmXbeZuYMJL9gPcH/WalCox@vger.kernel.org
X-Gm-Message-State: AOJu0YyVc23mpWbJCZs9IXwshWr/BcQuAjYyzoJgZE+P5XON+klUy8QV
	2OhytWw5ug8yB5j4XAInGL1/HYgTlzF4iZnjOgvRTL8SsE56vpyR/cbq+tjeO9V2mlcMNtrq6/i
	0H62toX3zLNxtGifUuZtCGzsucUteCZhZ+ReueMBdliFWBjTnsYQyMFuLz/AQ5keiZu3EiKZJcX
	LGxUFBBNMUVfQMqKFKN6N2hEuYugu8f1WsCSXFjeJi
X-Gm-Gg: AeBDievsK/DqXKw5HJDjLJ6WXooU0CDNgCV552W07Q8hUiNSNB2OhS+8tcSYHzSI+nU
	kEV80cqGwJUC7hpX6A8OYpuNP+X1240Gey3dKR2uDI9nKCGtbBxWGgzQK9yJN/RjrrJlCjwwLI8
	batouEFkR+Kg/8sAZx6yZbuuDIR+e96zCGEgYgijUg1lp5A971IquIJ+eYBDOz/5hh2YZjaR4NF
	uHg1NBALNX2qAhl
X-Received: by 2002:a05:6402:159a:b0:66f:2ea5:c269 with SMTP id 4fb4d7f45d1cf-672bfdc97e3mr8934462a12.15.1776853364432;
        Wed, 22 Apr 2026 03:22:44 -0700 (PDT)
X-Received: by 2002:a05:6402:159a:b0:66f:2ea5:c269 with SMTP id
 4fb4d7f45d1cf-672bfdc97e3mr8934450a12.15.1776853363685; Wed, 22 Apr 2026
 03:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com>
 <20260416194844.3874004-3-ibrahimjirdeh@meta.com> <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
In-Reply-To: <bcodsu6plppnwotjuisi7kvwkftpennowemslxur33qhtmd4qp@wc536gzxu53m>
From: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Date: Wed, 22 Apr 2026 03:22:32 -0700
X-Gm-Features: AQROBzBj5iXlFVZjFrlf4m_QHxOxecMsKKyqCQvzVEtR6kTpM5XPmj-LY4_CTRQ
Message-ID: <CAAwtZY6Bas3jLQZ_GDhbjj4pekjhT6kxAQ+5_35mzwk5_HUKhg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
To: Jan Kara <jack@suse.cz>
Cc: amir73il@gmail.com, josef@toxicpanda.com, lesha@meta.com,
        linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: jGcDVcXYSYQ_as1JfGvOJKP8UhU25Cvl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIyMDA5OSBTYWx0ZWRfXzQ1kUUji2KyJ
 E0MQe1DXsFcAqByqC4EZ22KgsGt1H0KVTfHtL+KmGgYUHbIUSymfAV4oMng0gwxrtPOm9Eo3Q2o
 yD3VX1ULq74ZrwGlsF5f9FdAnwR22ltOwrwZu4UZFBtG0dsDZs7DKZxJeca/nkUeCGVuXLZlGOL
 qQHti9QzcXCny3rfpb3jfKWGeHzraJJJu+n/5s0/8eKkUvvqMj2vQf/w93ND+fFu+8iArWB5Xvv
 0H7tNjK7JjEm5+I3awTzfXuNDcThZ3IsFnJKrw0vXMnmdMefnX/Cuv+na53N/QIvKmVO1SlASsB
 wjfJc4gUwvKvRkZnGrGMkAs9kZJ352/iSemaxPkGTxC+oIZbAa36lFGQaMghf1Ynvdns5PiKkt0
 qAEDMzuYANgneRjMTMRc7hCMaqFCkFKR57TOjiuzzQSo+W31dbtIE31W1ZdkEtKeJNrC/+evW7q
 wmKqz2q7Qe7f6myF12A==
X-Proofpoint-ORIG-GUID: jGcDVcXYSYQ_as1JfGvOJKP8UhU25Cvl
X-Authority-Analysis: v=2.4 cv=GcknWwXL c=1 sm=1 tr=0 ts=69e8a176 cx=c_pps
 a=9KvDgq78n9V61H3VJbnhTw==:117 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=wpfVPzegXHpEFt3DAXn9:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=pGLkceISAAAA:8 a=5jV_xKF69sekQEOmyz0A:9
 a=QEXdDO2ut3YA:10 a=j5kO0B45gQVIxiUYEfTy:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-22_01,2026-04-21_02,2025-10-01_01

On Mon, Apr 20, 2026 at 7:37=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Thu 16-04-26 12:48:44, Ibrahim Jirdeh wrote:
> > This adds support for restarting permission events. The main goal of
> > the change is to provide better handling for pending events for lazy
> > file loading use cases which may back fanotify events by a long-lived
> > daemon. For prior discussion of approaches see [1][2].
> >
> > In terms of implementation, we add a new control-fd/queue-fd api.
> > Control fd returned by fanotify_init keeps fanotify group alive and
> > supports operations like fanotify_mark as well as a new ioctl
> > FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
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
> Thanks for the patch. Some comments below...
>

Thanks for reviewing the patch Jan and Amir.

> > diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotif=
y.h
> > index 39e60218df7c..dd64af8313a9 100644
> > --- a/fs/notify/fanotify/fanotify.h
> > +++ b/fs/notify/fanotify/fanotify.h
> > @@ -552,3 +552,7 @@ static inline u32 fanotify_get_response_errno(int r=
es)
> >  {
> >       return (res >> FAN_ERRNO_SHIFT) & FAN_ERRNO_MASK;
> >  }
> > +
> > +extern const struct file_operations fanotify_fops;
> > +extern const struct file_operations fanotify_control_fops;
> > +extern const struct file_operations fanotify_queue_fops;
>
> Why cannot the ops remain static? I didn't find anything in this patch th=
at
> would require them to be extern...
>

Will update, static with forward declaration should also work.

> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 787e57a00466..b4610c49daab 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1018,6 +1018,15 @@ static ssize_t fanotify_read(struct file *file, =
char __user *buf,
> >                       if (file->f_flags & O_NONBLOCK)
> >                               break;
> >
> > +                     /*
> > +                      * With FAN_RESTARTABLE_EVENTS, queue fd may
> > +                      * outlive control fd. Return EOF if group
> > +                      * is shut down.
> > +                      */
> > +                     ret =3D 0;
> > +                     if (group->shutdown)
> > +                             break;
> > +
> >                       ret =3D -ERESTARTSYS;
> >                       if (signal_pending(current))
> >                               break;
> > @@ -1101,6 +1110,7 @@ static ssize_t fanotify_write(struct file *file, =
const char __user *buf, size_t
> >   */
> >  static void fanotify_restart_pending_events(struct fsnotify_group *gro=
up)
> >  {
> > +     mutex_lock(&group->fanotify_data.queue_mutex);
> >       spin_lock(&group->notification_lock);
> >       while (!list_empty(&group->fanotify_data.access_list)) {
> >               struct fanotify_perm_event *event;
> > @@ -1121,10 +1131,21 @@ static void fanotify_restart_pending_events(str=
uct fsnotify_group *group)
> >               }
> >       }
> >       spin_unlock(&group->notification_lock);
> > +     group->fanotify_data.queue_opened =3D false;
> > +     mutex_unlock(&group->fanotify_data.queue_mutex);
> >
> >       wake_up(&group->notification_waitq);
> >  }
> >
> > +static int fanotify_queue_release(struct inode *ignored, struct file *=
file)
> > +{
> > +     struct fsnotify_group *group =3D file->private_data;
> > +
> > +     fanotify_restart_pending_events(group);
>
> I think fanotify_restart_pending_events() can run without the mutex, cann=
ot
> it? The queue fd is closing, new cannot be created until we clear
> queue_opened. Then we can just lock the mutex here, clear queue_opened, a=
nd
> drop it. It looks a bit cleaner if handling of queue_opened isn't hidden =
in
> fanotify_restart_pending_events(). Also given how trivial
> fanotify_restart_pending_events() ended up being, I'd just squash that
> commit with this one.

That makes sense. I can change to only holding the lock for modifying
queue_opened
in the next version.

>
> > +     fsnotify_put_group(group);
> > +     return 0;
> > +}
> > +
> >  static int fanotify_release(struct inode *ignored, struct file *file)
> >  {
> >       struct fsnotify_group *group =3D file->private_data;
> > @@ -1182,6 +1203,44 @@ static int fanotify_release(struct inode *ignore=
d, struct file *file)
> >       return 0;
> >  }
> >
> > +static int fanotify_open_queue_fd(struct file *file)
> > +{
> > +     struct fsnotify_group *group =3D file->private_data;
> > +     int f_flags, fd;
> > +     struct file *queue_file;
> > +
> > +     if (!FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS))
> > +             return -EINVAL;
> > +
> > +     guard(mutex)(&group->fanotify_data.queue_mutex);
>
> Do we really need a new mutex for this? AFAICS it is used only to seriali=
ze
> fanotify_open_queue_fd() calls and fanotify_queue_release() calls. I thin=
k
> we can happily use fsnotify_group_lock() / fsnotify_group_unlock() for
> this?
>

Its accurate that the new mutex is only used for serializing queue open and
release operations. I can update to reuse the existing fsnotify_group_lock,
was unsure if it was acceptable to contend with existing usages like
fanotify_mark.

> > +
> > +     if (group->fanotify_data.queue_opened)
> > +             return -EBUSY;
> > +
> > +     f_flags =3D O_RDWR;
> > +     if (group->fanotify_data.flags & FAN_CLOEXEC)
> > +             f_flags |=3D O_CLOEXEC;
> > +     if (group->fanotify_data.flags & FAN_NONBLOCK)
> > +             f_flags |=3D O_NONBLOCK;
> > +
> > +     fd =3D get_unused_fd_flags(f_flags);
> > +     if (fd < 0)
> > +             return fd;
> > +
> > +     queue_file =3D anon_inode_getfile_fmode("[fanotify-queue]",
> > +                                           &fanotify_queue_fops, group=
,
> > +                                           f_flags, FMODE_NONOTIFY);
>
> Please use new FD_ADD() infrastructure for this. fanotify_init() already
> uses it.
>
> > +     if (IS_ERR(queue_file)) {
> > +             put_unused_fd(fd);
> > +             return PTR_ERR(queue_file);
> > +     }
> > +     fsnotify_get_group(group);
> > +     fd_install(fd, queue_file);
> > +     group->fanotify_data.queue_opened =3D true;
> > +
> > +     return fd;
> > +}
> > +
> >  static long fanotify_ioctl(struct file *file, unsigned int cmd, unsign=
ed long arg)
> >  {
> >       struct fsnotify_group *group;
> > @@ -1207,7 +1266,21 @@ static long fanotify_ioctl(struct file *file, un=
signed int cmd, unsigned long ar
> >       return ret;
> >  }
> >
> > -static const struct file_operations fanotify_fops =3D {
> > +static long fanotify_control_ioctl(struct file *file, unsigned int cmd=
,
> > +                                unsigned long arg)
> > +{
> > +     int ret =3D -ENOTTY;
> > +
> > +     switch (cmd) {
> > +     case FAN_IOC_OPEN_QUEUE_FD:
> > +             ret =3D fanotify_open_queue_fd(file);
> > +             break;
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> > +const struct file_operations fanotify_fops =3D {
> >       .show_fdinfo    =3D fanotify_show_fdinfo,
> >       .poll           =3D fanotify_poll,
> >       .read           =3D fanotify_read,
> > @@ -1219,6 +1292,23 @@ static const struct file_operations fanotify_fop=
s =3D {
> >       .llseek         =3D noop_llseek,
> >  };
> >
> > +const struct file_operations fanotify_control_fops =3D {
> > +     .show_fdinfo    =3D fanotify_show_fdinfo,
> > +     .release        =3D fanotify_release,
> > +     .unlocked_ioctl =3D fanotify_control_ioctl,
> > +     .llseek         =3D noop_llseek,
> > +};
> > +
> > +const struct file_operations fanotify_queue_fops =3D {
> > +     .poll           =3D fanotify_poll,
> > +     .read           =3D fanotify_read,
> > +     .write          =3D fanotify_write,
> > +     .release        =3D fanotify_queue_release,
> > +     .unlocked_ioctl =3D fanotify_ioctl,
> > +     .compat_ioctl   =3D compat_ptr_ioctl,
> > +     .llseek         =3D noop_llseek,
> > +};
>
> The new scheme with queue fd & control fd opens up an interesting new set
> of races which needs a deeper thought I think. As it is currently
> implemented for example if there's a task waiting for event on queue fd, =
it
> will never wake up if control fd is closed. Similar problem is there for
> fanotify_poll(). So we need to carefully define how operations on queue f=
d
> synchronize with operations on control fd and closing of it in particular=
.
> Besides dealing with the hung waits (which can be dealt with by just waki=
ng
> the notification_waitq from fanotify_release()) we also need to deal with
> fanotify_read() moving events from notification list to access list. I'm =
a
> bit unhappy with how ad hoc and fragile this looks but so far don't have =
an
> idea for a cleaner solution.
>

I wanted to ask a few more questions here about the race conditions you are
outlining. Is it accurate that the main risk of races is primarily
related to early
control fd shutdown with this new two fd case, or are there other races to =
worry
about? I added a few protections in this patch so far and wanted to
check if there
are outsanding risks:
1) Have queue fd also maintain a group reference as well
2) Check for control fd close (group->shutdown) in fanotify_read. I will al=
so
incorporate the wake up in fanotify_release you have suggested here.

Regarding fanotify_read moving events from notification list to access list=
, do
we need to allow pending events in fanotify_restart_pending_events
after all to prevent potential hung waits stemming from race with shutdown?

> > +
> >  static int fanotify_find_path(int dfd, const char __user *filename,
> >                             struct path *path, unsigned int flags, __u6=
4 mask,
> >                             unsigned int obj_type)
> > @@ -1640,6 +1730,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >       int f_flags, fd;
> >       unsigned int fid_mode =3D flags & FANOTIFY_FID_BITS;
> >       unsigned int class =3D flags & FANOTIFY_CLASS_BITS;
> > +     unsigned int restartable_events =3D flags & FAN_RESTARTABLE_EVENT=
S;
>                                                   ^^^ Can we perhaps call
> this FAN_EVENT_FD or something like that? Because I can forsee we will fi=
nd
> other interesting ways how to use the scheme with two fds and not all of
> them tied to restarting of permission events. So FAN_RESTARTABLE_EVENTS
> will become confusing at that point.
>

Will rename this to FAN_CONTROL_FD per Amir's suggestion.

> >       unsigned int internal_flags =3D 0;
> >
> >       pr_debug("%s: flags=3D%x event_f_flags=3D%x\n",
> > @@ -1718,10 +1809,17 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, fl=
ags, unsigned int, event_f_flags)
> >           (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID=
)))
> >               return -EINVAL;
> >
> > -     f_flags =3D O_RDWR;
> > +     /*
> > +      * FAN_RESTARTABLE_EVENTS requires FAN_CLASS_CONTENT or
> > +      * FAN_CLASS_PRE_CONTENT
> > +      */
> > +     if (restartable_events && class =3D=3D FAN_CLASS_NOTIF)
> > +             return -EINVAL;
> > +
> > +     f_flags =3D restartable_events ? O_RDONLY : O_RDWR;
>
> I don't think we really need to differentiate control vs queue fd with
> O_RDONLY / O_RDWR. I'd just leave it with O_RDWR. Without implemented ops
> any attempt to read / write will fail with EINVAL anyway.
>
> >       if (flags & FAN_CLOEXEC)
> >               f_flags |=3D O_CLOEXEC;
> > -     if (flags & FAN_NONBLOCK)
> > +     if (!restartable_events && (flags & FAN_NONBLOCK))
> >               f_flags |=3D O_NONBLOCK;
> >
> >       CLASS(fsnotify_group, group)(&fanotify_fsnotify_ops,
> > @@ -1781,7 +1880,9 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flag=
s, unsigned int, event_f_flags)
> >       }
> >
> >       fd =3D FD_ADD(f_flags,
> > -                 anon_inode_getfile_fmode("[fanotify]", &fanotify_fops=
,
> > +                 anon_inode_getfile_fmode("[fanotify]",
> > +                                          (restartable_events ? &fanot=
ify_control_fops :
> > +                                          &fanotify_fops),
> >                                            group, f_flags, FMODE_NONOTI=
FY));
> >       if (fd >=3D 0)
> >               retain_and_null_ptr(group);
> > @@ -1999,7 +2100,8 @@ static int do_fanotify_mark(int fanotify_fd, unsi=
gned int flags, __u64 mask,
> >               return -EBADF;
> >
> >       /* verify that this is indeed an fanotify instance */
> > -     if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops))
> > +     if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
> > +             fd_file(f)->f_op !=3D &fanotify_control_fops))
>
> Please indent like:
>
>         if (unlikely(fd_file(f)->f_op !=3D &fanotify_fops &&
>                      fd_file(f)->f_op !=3D &fanotify_control_fops))
>
> >               return -EINVAL;
> >       group =3D fd_file(f)->private_data;
> >
> > @@ -2035,6 +2137,15 @@ static int do_fanotify_mark(int fanotify_fd, uns=
igned int flags, __u64 mask,
> >                group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
> >               return -EINVAL;
> >
> > +     /*
> > +      * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> > +      * permission events and modify event flags.
> > +      */
> > +     if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> > +         (mask & ~(FANOTIFY_FD_EVENTS | FANOTIFY_MOUNT_EVENTS |
> > +                   FANOTIFY_EVENT_FLAGS)))
> > +             return -EINVAL;
> > +
>
> Amir already commented this is wrong...
