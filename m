Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05A53CA4AB
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Jun 2026 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780647832; cv=pass; b=ptcXahQZ0JA5s5zMXHmeQzhjxMLeAkQoSKdGIGhTrtqFHkeXM1mOCRVQR1z3Vn+DFog1zpX47jNs+6GkQZEPAK35Vo//4kEAUnXQ62aFQt/K3WsevkAdYTaMuyRpqOxlG+L9TaR6oXAqPWHPmCY1Stb+ICdvSGiJbPnbSzDgL5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780647832; c=relaxed/simple;
	bh=7+BVYv8K29a1KElgi05gpfyC2LS0bPhefd/EfXzKsXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHSGfRWY1ct0V/HOx5H7m18onUj1z4SUpDGHIrHp4ZXHLysVHTbPz/SNdDIztypzxD0DPo0eGnvyMW/+8BrG6m3PSl/H9u26RaBP93Rry9JP3HTEcCslP+TliMNPogV8uW4oSrE8/3xKsW4F0bVFGl4qFIBeBWKLum+8v+nmKGI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsVkGDVN; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsVkGDVN"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1710997f8f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Jun 2026 01:23:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780647828; cv=none;
        d=google.com; s=arc-20240605;
        b=N53aE5qXdFe6uW+xIApDlIHdD/FlHU0zV5o7xN4CcCiTG45Pb0DCdM4C5SZhOT2no5
         EtnGFlcTQzfuCzSotONjXKpGLzoYVFG4VeU62KZHh7FGOM1FwByLkgw1u7vwklhUk6lK
         tYD9lqhdvgoOvnwnFhE0ITD9HITZ1wFxyAt5cjf2EcxQpn7XnLc1WOqOjK8Rv93wV9bC
         PxKSB//+4Li7cgtQpq3WlA+QMRBbRvDPFZasKI5ieoQ/2e6fs5yvw+jgvngt70EZZw23
         SXWVkU3E1DdBhZhTV/rqal3RXsq4LXPXwcm15vTiNZ8IihNfIol8mn7HBVJ6aCqd9gZM
         FugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pNOclOTbpqpjUzknGV84IsU6i/8kWl+ynJfuSnPZbyY=;
        fh=vAMVT829IdYlCc2n+iVidRvvRhAHpWLXYWgmMAs8sCk=;
        b=CuyF8alxmY/zG7A4/wXN3aLIHxnVOBTQHSJIKJsKtI4zISvlrHPXzPP+VdBqze4sb8
         d/TOJFTqZeRchjp7tipUKAPr7BcyFGXWD6qz38P9mlK+RBlF1YzZZavZahSGxpyuXJoT
         s3Xhhvr3xLseuxIHn0taKYLoIjAHcVfjmlAiuRJtM7MxfAKfJWC/2TccQ+lehPZuQiR/
         txRuW1XNJVUzwfq+bhCwaKEKECCujHnH26HOSsgttRJt8i1JIUJ5k3h6cFWW7Cu0LZeE
         K1jW9jQ2uzR4Gey8LrKFnI7TIbXHwvpciczDNVgwzEBhfnzw85bXGiqYjSvYVGCR5C8e
         RtKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780647828; x=1781252628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pNOclOTbpqpjUzknGV84IsU6i/8kWl+ynJfuSnPZbyY=;
        b=MsVkGDVN2EV+WzV/dmRoEP5nWhb9lvenPPARPV7RPdarVkhfQNlshsRX3giGjoq51F
         02IvVUrhR1F2hyNGss+iwlzfPO7pC9YA6na76oxc/zmbjzLF8TAnZfjWhYDPq2us3vcs
         7Bzj3D0fn0PIB0X8npmRIpuFemEVEaioLRUaVgv2gm8yzmgiXKISl6oP+09eb9X0z1ja
         ZnR+i9EPG8ctu/LBHpa2fCxsdcrNF8322QFYvq0RVuy7jmB9l1SmunkKFVFhEPCFEpPO
         y8eTmpKnJ1j+lUu1MXSTmArQSw/K3d+AbOgkCsOAQt4RgjesYAMsOX0jBL0a0yO506cs
         5VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780647828; x=1781252628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pNOclOTbpqpjUzknGV84IsU6i/8kWl+ynJfuSnPZbyY=;
        b=TowhWfG+KG2CrlUWZWbr8qFjLOk/n8KAxiWuFpo6h1DUSBMNfCvlbLA46sfCN2Ar7H
         jZYhaHkROkCmCRS4IpNRpbxjQLoxWwixhLy61O2PaTpRkcqmoK/pB8zx5nshWrTr22Vw
         fnhjzYRqq+VI9oS7WK821ZYKG/3rG4ZTqb+C0nVRpLoYwdaCEwHGzHs8QFDF99cfzX+2
         7x+d14YDfgF1PlZ2cnrNsHudQXEEchxB2QkUfQSQkzUDx3SlIxKTpFxwXq8LCwWdKSEo
         41aweDgNU7EAS7qzzfvZp5FG/ppRE0Xr6a9rlBdLG7GI6OlI3pvDK1SOnD3P8v4CvJ4K
         G6Ug==
X-Forwarded-Encrypted: i=1; AFNElJ9GDy9+8u6k92WSn8uWByCPFETojBKlu9MzjD+u3FvXHCyDhzVuYUxlf8IA/1n71lmC7XGBDyDYrayPTJ27@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs3o8Bj3UvsbgNlTwHUZYXtZx9FtSZMx3y4NKskqQMJgR/Mlgl
	qhRyHemEPNkNflU8yU+noTiKg7vO3fzkO4456lfWCkXFk2KaainHtOJPpZBA+Xyve479Mo3wKGT
	KiLAQkuApjjbl+6tUdeNCHZxjYcFM3ow=
X-Gm-Gg: Acq92OFtfWAEV32q0n6hdO3ksjDERpXxj7B3hvMkxqDrK9YO6Yrf6PxX2xFmBsC8Y9R
	Ee2o6sqwl6rW2XUsv/1HfJBDstiRnnq2dPlYb5fafrM9wRLP6K2cOupUlyNSHLbnjllgmVXOYTB
	lFtQHi/px4wy+b98jbYgbvR3E7h4YawxYLKyvnZ2/8mh7eU0MkTUV2uZtj3wSumCaXKS4VSNta9
	jW5/noIfXlhC4tX4iH/B/fqvLw8Y+FsaiK2D2jMaY2FuYQvh/f/dSpMzr3lZDip1Q1hi9kdpbBd
	ZwyN+FSz0mfb4Oikh18EtPa6HbYZbGdOltTwWNZwf1ZyGit8RjsJ2W6tlWv0rRY=
X-Received: by 2002:a05:6000:2083:b0:460:11bd:3fde with SMTP id
 ffacd0b85a97d-46032da2286mr2119996f8f.13.1780647827915; Fri, 05 Jun 2026
 01:23:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxgudh_W2Gcs5qqGce8yO6503yjrGzEwbjTKkT+DLAqufA@mail.gmail.com>
 <20260604194650.2826-1-anonymemeow@gmail.com>
In-Reply-To: <20260604194650.2826-1-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jun 2026 10:23:36 +0200
X-Gm-Features: AVVi8Cd1tyQgoyzAg1jlwf97uQd_2n8KlQ6tnYVlTPeEBZIVa4yhsdVzxV3yw-8
Message-ID: <CAOQ4uxgH3Fi3HOCsJJYSEj94qmkS64hskBXJwGj22dEAtG0o6A@mail.gmail.com>
Subject: Re: [DRAFT][PATCH] fanotify: lift pidfd reporting restrictions
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 9:47=E2=80=AFPM AnonymeMeow <anonymemeow@gmail.com> =
wrote:
>
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
>
> Fanotify used to refuse to report pidfds for reaped tasks by applying a
> pid_has_task() check before calling pidfd_prepare(). This prevented
> userspace from obtaining information about the task.
>
> Register the event pid with pidfs when creating the fanotify event if
> pidfd reporting was requested, so pidfd_prepare() can later create a
> pidfd for the reaped task.
>
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
> ---
>
> On 2026-06-03 12:00 +0200, Amir Goldstein wrote:
> >
> > Thanks for noticing the oddity and explaining the options.
> >
> > We could fail the event in case on ENOMEM because the system
> > is likely is a bad shape anyway and other events are likely to fail
> > allocation themselves, so I am not objecting to your patch as is,
>
> The existing behavior of fanotify is that, for groups with unlimited
> event queues, event allocation is performed with __GFP_NOFAIL and
> therefore must not fail. For groups with limited queues, event allocation
> uses __GFP_RETRY_MAYFAIL, which avoids entering the OOM path.
>
> Currently, pidfs_register_pid() uses hardcoded GFP_KERNEL. For non-costly
> allocations(pid attr falls into this category, am I right?), this is
> almost no-fail, but it will not avoid the OOM path. That means it can
> bypass fanotify's OOM-killer avoidance mitigation for limited queues
> and potentially trigger the OOM killer in the monitoring memcg under
> memory pressure, breaking the intended security isolation, as sashiko
> mentioned. In the meanwhile, GFP_KERNEL does not guarantee no-fail in
> all corner cases, so for unlimited queues, it can still cause events
> to be dropped under memory pressure, this is also reported by sashiko.
>
> Since this patch set is meant to be a functional enhancement, I think
> dropping events from an unlimited queue is not acceptable and can be
> a regression.
>
> The cleanest solution I can come up with is something like this patch.
> (I squashed the commits so that sashiko can apply the patch correctly)
> It adds a pidfs registration helper that takes a gfp_t argument, and
> fanotify registers the pid before allocating the event. With an unlimited
> queue, both pid registration and event allocation are no-fail, the
> existing behavior is preserved. With a limited queue, if pid registration
> fails with ENOMEM, fanotify simply returns NULL and drops the event,
> just like it would do if event allocation itself failed with
> __GFP_RETRY_MAYFAIL.
>
> This also avoids having to destroy an already allocated event on pid
> registration failure. Since the pid reference is only taken when
> assigning the event->pid field, there is no extra put_pid() path needed
> either. And this guarantees that whenever event allocation succeeds,
> the pid has already been registered with pidfs, so userspace can
> reliably get a pidfd later. The API semantics are no longer ambiguous.
>
> I also originally thought pidfs_register_pid() did not need to run in
> the target memcg because it does not explicitly use __GFP_ACCOUNT.
> However, pidfs_attr_cachep is created with SLAB_ACCOUNT, so the
> registration should also happen inside the set_active_memcg() scope.
> This version does that.
>
> But I don't know whether this amount of churn is justified for a
> relatively small feature enhancement. For the next revision, I am
> still inclined to send the simpler best-effort registration approach,
> unless reviewers think this stricter version is preferable.

For the record, this is not "churn":
>  fs/pidfs.c                         | 23 +++++++++++++++++----
"churn" is a patch that touches many files/lines, clutters git blame histor=
y
and impares backport of fixes.

It's a new interface which the fanotify caller needs to operate correctly.
The only question is whether it is worth the energy of discussing it ;)
but since we did that already, if Christian is on board with some form
of pidfs_register_pid_gfp() (maybe just change the few callers), then
I think this patch represents the most clean and correct way of dealing
with FAN_REPORT_PIDFD.

Thanks,
Amir


>
> In the best-effort version, fanotify would allocate the event first
> and then try to register the pid with pidfs using the existing
> GFP_KERNEL flag. If registration fails, the event is still queued.
> This does mean that pidfd creation at read time is not guarenteed to
> succeed if the task has already been reaped, and it also means the
> registration allocation may enter the OOM path even though the event
> allocation used __GFP_RETRY_MAYFAIL. But I think accepting that very
> small corner cases may be preferable if it avoids most of the
> additional code churn.
>
> With Best Regards,
> Anonymemeow
>
> >
> > but I am slightly leaning towards the semantically ambiguous API.
> >
> > I don't think that we are going to change the man page to say that
> > FAN_REPORT_PIDFD is guaranteed to return a pidfd, maybe we just
> > add a NOTE about increased likelihood of getting a pidfd since kernel X=
XX
> > and mention the known cases of pid namespace and ENOMEM.
> >
> > Thanks,
> > Amir.
> >
>
> ---
>  fs/notify/fanotify/fanotify.c      | 17 +++++++++------
>  fs/notify/fanotify/fanotify_user.c | 33 +++++++-----------------------
>  fs/pidfs.c                         | 23 +++++++++++++++++----
>  include/linux/pidfs.h              |  3 +++
>  4 files changed, 40 insertions(+), 36 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.=
c
> index 38290b9c07f7..ece9523e775b 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -14,6 +14,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/statfs.h>
>  #include <linux/stringhash.h>
> +#include <linux/pidfs.h>
>
>  #include "fanotify.h"
>
> @@ -842,6 +843,15 @@ static struct fanotify_event *fanotify_alloc_event(
>         /* Whoever is interested in the event, pays for the allocation. *=
/
>         old_memcg =3D set_active_memcg(group->memcg);
>
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> +               pid =3D task_pid(current);
> +       else
> +               pid =3D task_tgid(current);
> +
> +       if (FAN_GROUP_FLAG(group, FAN_REPORT_PIDFD) &&
> +           pidfs_register_pid_gfp(pid, gfp))
> +               goto out;
> +
>         if (fanotify_is_perm_event(mask)) {
>                 event =3D fanotify_alloc_perm_event(data, data_type, gfp)=
;
>         } else if (fanotify_is_error_event(mask)) {
> @@ -863,15 +873,10 @@ static struct fanotify_event *fanotify_alloc_event(
>         if (!event)
>                 goto out;
>
> -       if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> -               pid =3D get_pid(task_pid(current));
> -       else
> -               pid =3D get_pid(task_tgid(current));
> -
>         /* Mix event info, FAN_ONDIR flag and pid into event merge key */
>         hash ^=3D hash_long((unsigned long)pid | ondir, FANOTIFY_EVENT_HA=
SH_BITS);
>         fanotify_init_event(event, hash, mask);
> -       event->pid =3D pid;
> +       event->pid =3D get_pid(pid);
>
>  out:
>         set_active_memcg(old_memcg);
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index ae904451dfc0..b604e3da58ad 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -19,6 +19,7 @@
>  #include <linux/memcontrol.h>
>  #include <linux/statfs.h>
>  #include <linux/exportfs.h>
> +#include <linux/pidfd.h>
>
>  #include <asm/ioctls.h>
>
> @@ -903,25 +904,13 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>
>         if (pidfd_mode) {
> -               /*
> -                * Complain if the FAN_REPORT_PIDFD and FAN_REPORT_TID mu=
tual
> -                * exclusion is ever lifted. At the time of incoporating =
pidfd
> -                * support within fanotify, the pidfd API only supported =
the
> -                * creation of pidfds for thread-group leaders.
> -                */
> -               WARN_ON_ONCE(FAN_GROUP_FLAG(group, FAN_REPORT_TID));
> +               unsigned int pidfd_flags =3D PIDFD_STALE;
>
> -               /*
> -                * The PIDTYPE_TGID check for an event->pid is performed
> -                * preemptively in an attempt to catch out cases where th=
e event
> -                * listener reads events after the event generating proce=
ss has
> -                * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
> -                * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
> -                * those cases with all other pidfd creation errors repor=
ted as
> -                * the error code itself or as FAN_EPIDFD.
> -                */
> -               if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID=
))
> -                       pidfd =3D pidfd_prepare(event->pid, 0, &pidfd_fil=
e);
> +               if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> +                       pidfd_flags |=3D PIDFD_THREAD;
> +
> +               if (metadata.pid)
> +                       pidfd =3D pidfd_prepare(event->pid, pidfd_flags, =
&pidfd_file);
>
>                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd =
< 0)
>                         pidfd =3D pidfd =3D=3D -ESRCH ? FAN_NOPIDFD : FAN=
_EPIDFD;
> @@ -1628,14 +1617,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
, unsigned int, event_f_flags)
>  #endif
>                 return -EINVAL;
>
> -       /*
> -        * A pidfd can only be returned for a thread-group leader; thus
> -        * FAN_REPORT_PIDFD and FAN_REPORT_TID need to remain mutually
> -        * exclusive.
> -        */
> -       if ((flags & FAN_REPORT_PIDFD) && (flags & FAN_REPORT_TID))
> -               return -EINVAL;
> -
>         /* Don't allow mixing mnt events with inode events for now */
>         if (flags & FAN_REPORT_MNT) {
>                 if (class !=3D FAN_CLASS_NOTIF)
> diff --git a/fs/pidfs.c b/fs/pidfs.c
> index 1cce4f34a051..e9f6113efc5b 100644
> --- a/fs/pidfs.c
> +++ b/fs/pidfs.c
> @@ -991,14 +991,16 @@ static void pidfs_put_data(void *data)
>  }
>
>  /**
> - * pidfs_register_pid - register a struct pid in pidfs
> + * pidfs_register_pid_gfp - register a struct pid in pidfs with custom G=
FP
> + * flags
>   * @pid: pid to pin
> + * @gfp: GFP flags for memory allocation
>   *
> - * Register a struct pid in pidfs.
> + * Register a struct pid in pidfs with custom GFP flags.
>   *
>   * Return: On success zero, on error a negative error code is returned.
>   */
> -int pidfs_register_pid(struct pid *pid)
> +int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp)
>  {
>         struct pidfs_attr *new_attr __free(kfree) =3D NULL;
>         struct pidfs_attr *attr;
> @@ -1014,7 +1016,7 @@ int pidfs_register_pid(struct pid *pid)
>         if (attr)
>                 return 0;
>
> -       new_attr =3D kmem_cache_zalloc(pidfs_attr_cachep, GFP_KERNEL);
> +       new_attr =3D kmem_cache_zalloc(pidfs_attr_cachep, gfp);
>         if (!new_attr)
>                 return -ENOMEM;
>
> @@ -1031,6 +1033,19 @@ int pidfs_register_pid(struct pid *pid)
>         return 0;
>  }
>
> +/**
> + * pidfs_register_pid - register a struct pid in pidfs
> + * @pid: pid to pin
> + *
> + * Register a struct pid in pidfs.
> + *
> + * Return: On success zero, on error a negative error code is returned.
> + */
> +int pidfs_register_pid(struct pid *pid)
> +{
> +       return pidfs_register_pid_gfp(pid, GFP_KERNEL);
> +}
> +
>  static struct dentry *pidfs_stash_dentry(struct dentry **stashed,
>                                          struct dentry *dentry)
>  {
> diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
> index 416bdff4d6ce..8054f49bc139 100644
> --- a/include/linux/pidfs.h
> +++ b/include/linux/pidfs.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_PID_FS_H
>  #define _LINUX_PID_FS_H
>
> +#include <linux/types.h>
> +
>  struct coredump_params;
>
>  struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
> @@ -14,6 +16,7 @@ void pidfs_exit(struct task_struct *tsk);
>  void pidfs_coredump(const struct coredump_params *cprm);
>  #endif
>  extern const struct dentry_operations pidfs_dentry_operations;
> +int pidfs_register_pid_gfp(struct pid *pid, gfp_t gfp);
>  int pidfs_register_pid(struct pid *pid);
>  void pidfs_free_pid(struct pid *pid);
>
> --
> 2.54.0
>
