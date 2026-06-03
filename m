Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2095B44A71E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 09:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780480529; cv=pass; b=l7UFB1zGmqFyOtz5qqxrb3CAiL62zYfqNJaH5JokpKJR8SUgc9FnWVy3bHKLHeMm1vShreXEcKpcQEQKOz59QxLvc7XOLs/NZ/iV5G5jtOs2ejuKrQqLli0n+/Geiv23GkuqAE2BzkmA8KdWuN47TjClklWu30OhnyTJt12qkBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780480529; c=relaxed/simple;
	bh=r2Y+Nar/7dgHmqVliFEtB7l6MvWeVc1GWvkFGdnsZnM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oF52MVIkMI7ygGgPyeORXiugJt3sTMmMeodwCBIJpwWA5DtqL+7iG/1HgwQOTPOllKd38mQ7yW7LvMb5HMtOMjNlZwDF7ZVO6RaWu8ktMqGgwsaliy0idJ9FslJLPRXnE2km8XiUqgZMyzeKFP8DV7/sX4Eh/w7eIBKW3dRc1Yw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITsLeWHK; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITsLeWHK"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68acf0a15b3so10325609a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 02:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780480524; cv=none;
        d=google.com; s=arc-20240605;
        b=hPSRVCWlsN3SKj8jzznfMZW/wTmHZ4KqWNwPBMj4GdAanRkq7JPY37xuqkCqe10zSd
         mATB04Nex/5i88U0kxnIQz8cN0bt8u+Yj+IAzcQRH8snmSPN6nf8gV+cGOb7wea7ohYp
         TebDzFDK3BRuTpFjsc7/FjwJWOdjIcCHnLLZbXcWvrAnoaXjns1GnX2xgLef7ZlJFqRn
         DjiphR7E0OX9P7yeD7ri9/vFiY9D5hxBuEWlxOiQ1/5f/tORh+711a5LBuoQ3I2Geund
         beUH+vObBr0PnpHGkMvTQD2FZISS6v3FxJy+39EsyPndclqRMCGV4H1cNw7Y/ZBIAU86
         xCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wZEDpmMkusQJf1ZAgUm+9NBHEm/lFoTCTWpLaCvu64s=;
        fh=NEpVgMuqiQrt5aW+v2zc6YEJRoWplPAwy/H+FQGg06Y=;
        b=Hp3yT/tCffHHVadGdHsiQLFXSEvKaH8Df895CYKOOLr8izt8vINSDkT9vkHJoK0iPs
         MGCqNPPk7Y3Jsh6pEngYp5w9s6z8pjjqh1gOaMAYHwYquVQjr2PhZW+VTEJRMHQI039w
         gnKmRt6nV4toHbfrfpZhF4Pvz5dhsc3B0wDNmeUeN1IT1IvKbGR7hZJcWVxOtMLZMiJr
         EIcQBizCk93uFfCaklugAAptBzunM7tMt3+KQiI34bsbnVPf6qECcFm/vUH1Qut9RlMm
         gH3Nw44scR71rOzKPdyHY5cM8nDZ2C1rL3I+r7rv3qaCLRNySbIwVp0xWfrJVukF7hw4
         Tdow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780480524; x=1781085324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZEDpmMkusQJf1ZAgUm+9NBHEm/lFoTCTWpLaCvu64s=;
        b=ITsLeWHKhHghXifTGUFpwNkvJVXnQIaB5uvQuw3SzQr0dZ/8qVIrHQfjgRqd5nta70
         tjCO3+tUvKZJ9zM8vX9qWArBTF6eh0A4Dx6ev+XHH8bX6NCwpAU0Hn5znV4VE4acRXQq
         9sfPkOVPhwgZdPv3yZJ7yjUcs8zKxXrkmQGLXVfPBTIMnUZ346TIEcU6ogPmCzN2rvpT
         aMoTJm/UbnBQ7tGaSsELrfPipaDiSMi4j4llrBAZIRErKrDx8UYsouk5Q1MqfXWRwCK9
         HjPANURzyDrlA1ss6fUEW76hbrY9tezZ888waY/MVL+5LrBcW3782jktulqWsFjQiXy4
         aDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780480524; x=1781085324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wZEDpmMkusQJf1ZAgUm+9NBHEm/lFoTCTWpLaCvu64s=;
        b=ErWV9pd+wOKCeyzrpYw4BbpzCCtYMzVSy9qjNrHbFM/yciH8dFtDn+xBklnEt6vppS
         GQIaH0TtZf8HV4xS9pc8p4VFB0slmnZcd6BDe/yN0ZgkvYUcO9cfBbV4pAt+dT8nomn6
         gpDjCbVTB6AucKYoOMHEytPNxOeP6PuMBVkauqR2+5hIlWLpqjjHRCXcZGhvUHaVyqkd
         lN4MfZHxLyZrcAfuGvUjExNDeGuw5yQ0uM18JA/iLVy7UoQ1ocdOpAo6PbO+vaDT3Y1S
         /ZBanWMEB/CKivLW0ZHwX4bAL3XPIcFACLDUw991oUrGYqQLiwJB1Ob8gveSJR5CJJhT
         B5sg==
X-Forwarded-Encrypted: i=1; AFNElJ9g4gzF8BYrA8pZqW2o23/+HaGaYwpiaToWn1gUD/OmOrtHNzXaYMchbJySBIarGav7E5DNkDQ07z8xXoBd@vger.kernel.org
X-Gm-Message-State: AOJu0YxsYMdjRrNHqAcqKt7XH62i+DzYUOANB0Z0J17vEycUlnXnOPT8
	zTyK4/fKZTyg8o48naVAu6BVLQ33a7oMBxYxrbAiWcZ1GJHJSjs3oa6QY1hraV9n13D15fS7Oeu
	uj/jsNHE+Vamb8zYA9lsXUe85F1gIIYw=
X-Gm-Gg: Acq92OEmbg6X7tp6hGITeOteo7alU++cFfyTSEIsGQQ0B6/VY/nLeviS7qx7JcR8/4s
	f/EbHhU1DEdLxdcTh0N6UVoaBSTha/ieWfbXcd/FxwSlIgsD6lD4A+8IFkxNSwLp1CGkf61wmBc
	/VWSPu/pGjui1+Dy8MVtSYrQDiLmAwC0n8DRtL9UATG+3Yny7e4HmrYxQXeQ9fC11yjwPYctYKV
	WgdbZK+XZJCQQ1TSdQ2YpUX8/lRX6CQV0aw5bEV/VF6SjjXD5DOqGy26JIZ8oPE0rUfm4cOR8OV
	A5CjmFJIxvRn8stL9COFFZ1D2iMXUzQUhttetFjVzj26gSATwx7h
X-Received: by 2002:a05:6402:4487:b0:66f:9f63:e537 with SMTP id
 4fb4d7f45d1cf-68e7254b0d7mr1139562a12.19.1780480524093; Wed, 03 Jun 2026
 02:55:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603001516.26234-1-anonymemeow@gmail.com> <20260603001516.26234-2-anonymemeow@gmail.com>
In-Reply-To: <20260603001516.26234-2-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 3 Jun 2026 11:55:11 +0200
X-Gm-Features: AVHnY4IjN44ED0XFLr6D_FVk74_zTECcT3g2rD9HWzWyvKbprBOAq5DKMmYaoDU
Message-ID: <CAOQ4uxhEYwHLmXETAgxiDimah5zvCL65_gmCNYEYgHOVXKR_3g@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] fanotify: report thread pidfds for FAN_REPORT_TID
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: jack@suse.cz, brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 2:15=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.com> =
wrote:
>
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
>
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Since I reviewed v3 and provided
Reviewed-by: Amir Goldstein <amir73il@gmail.com>

and nothing has changed (right?)
it is a good practice to add my RVB so I know I don't need to review it aga=
in...

To clarify, you do not need to post a new revision just for adding RVBs
but if you do send a new version, please collect them
and remove them only if patch has non minor changes which
would require a re-review.

Thanks,
Amir.

> ---
>  fs/notify/fanotify/fanotify_user.c | 27 ++++++++-------------------
>  1 file changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index ae904451dfc0..ebdd48942029 100644
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
> @@ -903,25 +904,21 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
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
> +               unsigned int tid_mode =3D FAN_GROUP_FLAG(group, FAN_REPOR=
T_TID);
> +               enum pid_type pidtype =3D tid_mode ? PIDTYPE_PID : PIDTYP=
E_TGID;
> +               unsigned int pidfd_flags =3D tid_mode ? PIDFD_THREAD : 0;
>
>                 /*
> -                * The PIDTYPE_TGID check for an event->pid is performed
> +                * The pid_has_task() check for an event->pid is performe=
d
>                  * preemptively in an attempt to catch out cases where th=
e event
> -                * listener reads events after the event generating proce=
ss has
> +                * listener reads events after the event generating task =
has
>                  * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
>                  * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
>                  * those cases with all other pidfd creation errors repor=
ted as
>                  * the error code itself or as FAN_EPIDFD.
>                  */
> -               if (metadata.pid && pid_has_task(event->pid, PIDTYPE_TGID=
))
> -                       pidfd =3D pidfd_prepare(event->pid, 0, &pidfd_fil=
e);
> +               if (metadata.pid && pid_has_task(event->pid, pidtype))
> +                       pidfd =3D pidfd_prepare(event->pid, pidfd_flags, =
&pidfd_file);
>
>                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd =
< 0)
>                         pidfd =3D pidfd =3D=3D -ESRCH ? FAN_NOPIDFD : FAN=
_EPIDFD;
> @@ -1628,14 +1625,6 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags=
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
> --
> 2.54.0
>
