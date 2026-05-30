Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF712DECBA
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 13:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149103; cv=pass; b=qqKjQDw22nAUqulK49/o/xxEj2GsPe2pjc/DhMGmfHCSR4P8ytZ2CmfxIBQcTmhRoNkQWhINmeFayQ72t5Z6PferPzO0L+bjXJeOgqp977qcMNWGNUzj6z8x5eMwwbXJkTteh3se0ILS6rHX+wtQUWGCOQjujimEKh7eClIp6M4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149103; c=relaxed/simple;
	bh=w2BYGnUp2+snTH83YjltU8PsswOE+XFiqP4Mm4TKLcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I/2V6W89cv+slt+NXWB/ObaQZQH2MqWBSPYM1/yZYLgEnW0kg65DXvjYbjaMhE3MeESFUa9ORYHSdYQuuidH+QRqdFKF2IS+M1+KdE0qclJaq0zSfgm47D6fwFCpgrjQFLhgJMw6Lz35S4seJ5ORNwgWSGe4uS6BDdJqGAOWDIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwJ3Nbex; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwJ3Nbex"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67da63ae541so12528896a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 06:51:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780149100; cv=none;
        d=google.com; s=arc-20240605;
        b=MzW1fu32t6Iq+sHpZbb7LWsuN5G867C4IVsx7HQuhra4+dhV0nCzs5HqXCrAJBwFdM
         EWVqaXgzQVq0Jj7HgUnZBiZxZqqisO7QhHFX9bI4fC/e6Kx+zj9ArpY/fVQI2WaWwlB8
         pn0azci0TXfc6FN15cyDtEOvum+4sgz8n0R9c1rrufwqHdwpF45cRwRzdFKsPrDbsfdk
         YpxNQrF+5GGO6TyrWNxv2sAMEr5wro56FdaDkXdJamnMyTxTIeZNmWyxpAgAEK2GiOVL
         OwJcdYMftIRXH+AgEDIKzab4Y+HJZUSpi7kgh0GMClLPR472+YNajG3q/L/k4PfA1q5k
         tIvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=A3AMqB69NVQoA1AVhTwstPHrAZW6bpPxyw/S+F4Wu1k=;
        fh=nXQDmTpWFX7hBQJDaizoQXOCwKvNtRjPaJDY/5h/BjU=;
        b=lS+sEZwFFCOL5GvA+dLoZ8dA4rpuP3ap2L9aOvd/dUugNBRedYvi0mEYpTOLRAg2cU
         4oJTEIsTcI3jes3mFL+KKpxBzw87rd6bgaxtAX+WZT1AYyss392lBF5QdCahm5hJKcWr
         Kt86hhtFOV5AMTkunD9i2m11+j5FpcSEAuYzlZnhNh0NFU1E5Ii38Q5j4sXJxAxGl3q5
         3nwCxcwNsZ6MGZHUvZZpUNF9pFoFol69wdBXiX7ffl4lOgF5QTEjjdBN+CneTlQJ9fZs
         vh0mNIBQ19YpOOnCZ8Ai/MCurT+5V8DqzqqwQckmSN1QjK3C/MWTIpjjfLE49fh/AnI8
         BdKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780149100; x=1780753900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A3AMqB69NVQoA1AVhTwstPHrAZW6bpPxyw/S+F4Wu1k=;
        b=IwJ3NbexlYnz22NzeHvesEBgKf40XnRu9d2wpCVBCID68QmIyUZewqIDhqxK33HO5y
         vxiJ2SKcy5X17fv2av0sCVmZDO+vrpHu0p/NgLhcR8egFdcHvgsvIzkAOUOMaO+qi6yO
         xFXkdh5PFzef3eO4vGh6f9jXvr0B4wN/ydLrXZ6ZPau5zMuM34Yft5XHNrozis/6vsxy
         Wd28ucPialJqYFKlAJ+fJOjHpA4cNNv+dsKVZHuoMaW+UupB8kpNxkCnEB7UGUyrz3em
         lxHgrfClloEkna5cBjVUhXtRDrjSjO1BoT11kry/8By1Utk4BeTKeZFqB4aIns1riUNa
         sGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780149100; x=1780753900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A3AMqB69NVQoA1AVhTwstPHrAZW6bpPxyw/S+F4Wu1k=;
        b=MC80EJIo5tQYrZ6qijcgZGVYIpidyzfo7rsVOeOJKMvaNdEb9B3o2M1k9TaASsH8fX
         aQenBf3QZda0QSgKGNLXDJr5VfH0kGWHcYPalI8wTEuPpjDv3mCTq9VE37SDwj82BLbz
         ovStIV5Ld+gNzWp+YguxzgJRVv8ZbQM8VFkLZ3Q23Jy3hFkl/WGlsF64eLESx/MnCq3j
         5bd/Bx9RhBf1bFFKdbLxAYGK1iQCupeh2hzXtR16roiq5/Fpl+xYPsKTgVYhAorD9WxZ
         +OlNawUhQk+oaUJz7Z1GZz+Rzu7Xx+HA4uBeKN5RMxjHh6/3KzoOG+OT7KjuS1KVS8Gz
         PGbA==
X-Forwarded-Encrypted: i=1; AFNElJ8mm+tXa20/yNUYxIxZLMsnlCQAgP4PsTpmOXL3cdH6wCFMoR1+PX1ENVykKaIf/IBqhwNXBFTSk6w3EV9Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yw31FeyKcYkJLVt0xucX1tLNnS+4ritb+OVLyJYEzesFeV0KgsA
	ToLpzjWoWy5oU+4CRXjga1Q7s3yjAIZO/W36JDBtHPzzgUEYEgyfUvENjQ7Q/Zu5eF4RcovL0DV
	tcz4gHx1046yLi6OgLrcG+OAf4FJlbJw=
X-Gm-Gg: Acq92OGFWzR0/qRw8Xl1EA/5GDBoZSIQwKNNZmVMtJjfohDERFUPFTxVIJ3ewKjZ6WC
	C3iWwaFwNpzffWI5fujeBir4sHrxyoqaLFWwsBWl2/LIw7uxmccVSell3s/b+NfP1BqcAdKfOLz
	J9Qhy1vVYWq4uMWJ7g5G1OtqfDHHfpZ6Qstk8jRffQlaGFA17+E+eeA0pwxsFot2wB4CSVWSUEv
	vfBkGv/P32tU/tf8HoqQrFDGD3mTWDWB1LpM86lDwTUelzY+dvQ5tlymnR5aogY5vFdtGO9cKvi
	huxs43Vcs0VSZSI94A3ISEjUOW6hOlk1LV9/50ZvZKV5IkmTiwPS
X-Received: by 2002:a17:906:99c1:b0:bc3:7b0f:91ea with SMTP id
 a640c23a62f3a-beab13c1471mr217970166b.19.1780149100179; Sat, 30 May 2026
 06:51:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530013732.50811-1-anonymemeow@gmail.com> <20260530013732.50811-3-anonymemeow@gmail.com>
In-Reply-To: <20260530013732.50811-3-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 May 2026 15:51:28 +0200
X-Gm-Features: AVHnY4KfAP--lvjKe0NKzYKqZlzLUvqeZlYp1J4BC-AnYEbyUNyEe_QZUEIA-GM
Message-ID: <CAOQ4uxh2WU5owtUOv5JB57Dcm95qQy016kz2XRg9aeZ07VTByg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: allow reporting pidfds for reaped tasks
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:37=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.com>=
 wrote:
>
> Fanotify used to refuse to report pidfds for reaped tasks by applying a
> pid_has_task() check before calling pidfd_prepare(). This prevented
> userspace from obtaining information about the task.
>
> Fanotify events already hold a reference to the task's pid struct, so
> the check can be safely dropped and pidfds can be reported for reaped
> tasks as well.
>

I'd add:

Suggested-by: Christian Brauner <brauner@kernel.org>
Link: https://lore.kernel.org/linux-fsdevel/20260529-erdig-eckig-querulant-=
439a4ba4317d@brauner/

So when people come shouting we know who to blame ;)

> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

No need to post v4 just for adding those
Just add them if you happen to send v4 due some other review comments
and anyway we need to wait for Jan to wait in on this change

Thanks,
Amir.

> ---
>  fs/notify/fanotify/fanotify_user.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index ebdd48942029..b604e3da58ad 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -904,20 +904,12 @@ static ssize_t copy_event_to_user(struct fsnotify_g=
roup *group,
>                 metadata.fd =3D fd >=3D 0 ? fd : FAN_NOFD;
>
>         if (pidfd_mode) {
> -               unsigned int tid_mode =3D FAN_GROUP_FLAG(group, FAN_REPOR=
T_TID);
> -               enum pid_type pidtype =3D tid_mode ? PIDTYPE_PID : PIDTYP=
E_TGID;
> -               unsigned int pidfd_flags =3D tid_mode ? PIDFD_THREAD : 0;
> +               unsigned int pidfd_flags =3D PIDFD_STALE;
>
> -               /*
> -                * The pid_has_task() check for an event->pid is performe=
d
> -                * preemptively in an attempt to catch out cases where th=
e event
> -                * listener reads events after the event generating task =
has
> -                * already terminated.  Depending on flag FAN_REPORT_FD_E=
RROR,
> -                * report either -ESRCH or FAN_NOPIDFD to the event liste=
ner in
> -                * those cases with all other pidfd creation errors repor=
ted as
> -                * the error code itself or as FAN_EPIDFD.
> -                */
> -               if (metadata.pid && pid_has_task(event->pid, pidtype))
> +               if (FAN_GROUP_FLAG(group, FAN_REPORT_TID))
> +                       pidfd_flags |=3D PIDFD_THREAD;
> +
> +               if (metadata.pid)
>                         pidfd =3D pidfd_prepare(event->pid, pidfd_flags, =
&pidfd_file);
>
>                 if (!FAN_GROUP_FLAG(group, FAN_REPORT_FD_ERROR) && pidfd =
< 0)
> --
> 2.54.0
>
