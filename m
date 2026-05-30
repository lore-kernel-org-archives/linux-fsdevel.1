Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9E42F747A
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780149133; cv=pass; b=TovQTDCjgwpEe45ektFZyaUA3/ylfee4/Le6g5ETvbOXup8UabMhTcvFgm8GkTi+39cBrOkvHUziCX5Il0pJ4x5DrQuL6e9cqvfUQYW+I97ge8z8G5QMAcSZ2xUS9Ok3Ph5S7sXrvb+rmvxZtbmbV7h8e0JnhDGJMlusS69zokQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780149133; c=relaxed/simple;
	bh=4x3GF/1WUOVbtHt5KYzp50NAkSFR6ObYdzDg9nGrOq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQpuIPhO/0vFLDX6nrkxJ6xw7nLE8ZI+6yKZkb7FXBjTzDj+aWse9lkEIlDLIc8PTlhRMVml80wcSNiSo6BHO/BFZDV+mYrIzSw0d4YJ8CgzvqZGz1rJzWTvCyV0odVVEWOWTPPns60U8Fewkm7hjRTC7O8LOEAY4P0HemHCf8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OO7EqNMC; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OO7EqNMC"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-68ced97b6eeso313175a12.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 06:52:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780149130; cv=none;
        d=google.com; s=arc-20240605;
        b=F/KKf3JyAh9Po12IjrtdUYh1NifASHzhlRUgN30HHHfNvL4yTiUAvm00u0ldeUM04h
         kURVJzVVxZ2Qg2iO7rJ3JM/5LX4lUkI/FoTUat+bQGgxvJf63Pz6nV2O/ThIkworiEUF
         lJdOGzTsBsT0AOENZA8fJG18MbgNv5AzYcVPlO2iEb8EbW56bbJw6Z8y8UvmXx4l1LIc
         WW1Lqduky9fovPtlyt+dUxwXawt6LmWbwVoRPfc/DbP7aH78j2BNtkUALt0SwW1UciC9
         jrXU8ReNGVCm5ECEr62WkRXspkdPuysGL83SoKn1A5aErmLqVuK7yymXRXJPDNdco8rk
         b97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NCN/n4d3VnrplZpxtAHWZHIJdkMepTtjI7eXY9Ww4wc=;
        fh=gJhxlu9UhzKbblY5tbsjMzRaUxuglr3IRAu4XM58YOw=;
        b=ebLVGRxYiZVvu/oBD3YhYR8p8VA797vSMyAJxoo0oBASFpHv8wzOdJjTCsRrLRJ5Q2
         B0155PdVUc7iqjzt05pHsf3yJLyFqe54dFmA8KZldb/J76yEZMyviIkDHaUajFG0R/jY
         TIzFefl+Q1IyOvTtFD2Ts55GpTVWMmC5IeonPeCBPlDzei/z2tTJSvQpYjR6gvTKGCPX
         zPp9YFH9JpBnzWngtdHubwwpf28ZjmilApFlnFwH+qZNS43wk4kN1CXRHCEwy1bcAFMh
         UGKUtLGvp4jdmq8mUUdLsU8WEoINcir6CJteoJ7nTEGA4AgrpEXAbYsLxSS9uyYg8Ch0
         e3Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780149130; x=1780753930; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCN/n4d3VnrplZpxtAHWZHIJdkMepTtjI7eXY9Ww4wc=;
        b=OO7EqNMC84Ss7chXi3jgIQySMFC0JQ4Q1iLkyBVM2PFTeApmaifkuemcR9DQS78SiM
         jHgm46Z5NnOtrnhHxN3PCZxD0DYecAp7KqreOUYtHy2jCs00q1r5HkTuhOUuKuVx1swB
         sUPxiRoPxq8JBCF0L0yxijnWTl/nQzdNF/GbdRcKH1ubYyS2mWtX04qEi39JHCcuWxKw
         p7tgcSkkzLVLlUBzNHssPVHoo0evpULupkT8huKgGXDxtx1U0Mc0i8fKCrajy/h6qyIE
         Zube2GuxqDiDfYKI4jE0hjRMRiiLiZIJPv7O9gGHykz3903BHmqNEcj5mBxew334RkYt
         P5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780149130; x=1780753930;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NCN/n4d3VnrplZpxtAHWZHIJdkMepTtjI7eXY9Ww4wc=;
        b=NL/R0XtKvURQKso+ha12jXKFYplfz7ENqjRMerALKJ4lzUvEMlt4xQaSsHESLZ9Eaj
         wC2wzoM3MEJudQ7Snv352OYS/psM3RkqPdBUZkYpHkEjwW5jDYMsK34fp+uMm5VMlFc6
         hHcC0iXyrwq3np6ghW1Wc/Gqsxnc2MBsrFTThEnXlMSnD4UJUFpH8IyM1XJyW2/M1okt
         XswWjWKFk1U6c+ZDzuXIX/fxr6sU/LzwngQtudE1y96tQkUinuuFd0JRrawFAq71QnND
         BWARBZkEtkLOhJbWCTxk5L3rQhfADPrkGHIy5uq2sEPFuUkNs1kZnqGkkMuoywKbWh1n
         Pisw==
X-Forwarded-Encrypted: i=1; AFNElJ/TTmLQkhGDfYihbzsG87sW4w/qurJjocb1cPRZ7IMtpAzKxx3jQo79iFEfNd2GSs/UcEiq8q7Q7RAw7DvG@vger.kernel.org
X-Gm-Message-State: AOJu0YzhAVwPgQ/zAaEzdFi5bZyGdAuy6G1qJs8XsEvB3BSA9cX5n9Ka
	9kAAtHlQb6Q1YcBWZ8oRvRJ93Xi0miLzbyHUAKDGRyjdBYhEpKNksVXyO0/Zvh/WzJBI1gK1thI
	MmTrn37hDAVmiFMAq7wbH3sjF1r5wluM=
X-Gm-Gg: Acq92OGJbKxB2UQ5+S48axClH3XURwXYuERlQFgDK2lmVqauCPYw/23sVTWD9/BWuTP
	zN0u2mZ8aIJa6OfYF5xDQxQZD/HztSB86cuY5Zf7O5F4lAJSSLFg73CRed2y+87HmHkM2S1SdtU
	DL+GwAlH7bXhC+pYdga81BhSCsDiUnkmBB9zgBxgBOzu8YBasw08v044Z4uMIGRin5XL3ueiVcp
	KNJRTC1IOUk+8NWGD4++HlYJOv2rKKNIYE1syt+R6MJjVPhB9tF1+M1aChKLZu/GJYg6AiBzu/Q
	N4g23xcsXXeFt1bS+d+c+nGG3Seq8YMs+lILggFinbTY5oC2y4du
X-Received: by 2002:a05:6402:5306:b0:671:a18b:32b8 with SMTP id
 4fb4d7f45d1cf-68c87b9a52emr2157218a12.0.1780149130080; Sat, 30 May 2026
 06:52:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530013732.50811-1-anonymemeow@gmail.com> <20260530013732.50811-2-anonymemeow@gmail.com>
In-Reply-To: <20260530013732.50811-2-anonymemeow@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 30 May 2026 15:51:58 +0200
X-Gm-Features: AVHnY4IxB6c9_NC2DH0-rb7ivZPZnhSn1eXMMgSYtoUEILQCKUJkFeQaBJuiKws
Message-ID: <CAOQ4uxhwH6zAmKX6p4YHi-037YEG0ejBGWWhCcN7JRiQhRieCw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fanotify: report thread pidfds for FAN_REPORT_TID
To: AnonymeMeow <anonymemeow@gmail.com>
Cc: brauner@kernel.org, jack@suse.cz, repnop@google.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 3:37=E2=80=AFAM AnonymeMeow <anonymemeow@gmail.com>=
 wrote:
>
> The FAN_REPORT_PIDFD and FAN_REPORT_TID flags used to be mutually
> exclusive because by the time the pidfd support was introduced to
> fanotify, pidfds could only be created for thread group leaders. Now
> that the pidfd API supports thread-specific pidfds via PIDFD_THREAD,
> this restriction can be lifted.
>
> Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

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
