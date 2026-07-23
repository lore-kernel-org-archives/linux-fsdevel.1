Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A14377ABA
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 16:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824879; cv=pass; b=bH6QRjdidsIZ5RVcIO1uAxfk0+Lvr2RtCo3gfXMMgyZ3urg/fVS1LFwiCILBGSdC99l1ZPsFerxZ2ZlGc9zaG6zWq3rfF/ZOoXxQE899LgtVubVN28reU4X41JnfyUmIVjFGd3AYvRGphxWxSX1nYDXbPBC2cjxSMAqKJuaWzP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824879; c=relaxed/simple;
	bh=Mr3RmOtAU/Hlr3VRR/B4mbHKvvGNxM28lunEo3Y93ak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I8/2LmCp3B7W9MtkWvzgAf64oMve1g3J2An6dkr4LyRH4G6+47cfrOew0l50wz30yVX7sf+UgBLJ168VEhg9MlCu9OI8nJrw/Vq2kkcTSeL4tnk99wjsthJY+ttJ8oJK8XXKo/JZprR4tHqrqBXSgbebtfDLn7+IpNW7cpXk7CA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CJ6oyOTT; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJ6oyOTT"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so153284066b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jul 2026 09:41:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784824876; cv=none;
        d=google.com; s=arc-20260327;
        b=KxWKa4ltMvHKKL9Vt033bL+cJDwOH3rWc+sIT88LyG8JlPZ3jvVXiWC48V8WmKKtS5
         1YzRcGr9E9OEvnDXIZXbUHzrEU4ugt7ozXe+BCl+iytCij902FipK5QWBNAGrWQY2HtT
         osQidftAu3ZuDHobr674qO3P7e3ZCanYPANsuPzbARxgby5ZLZoRSv1qHWXqQ8BKEpgT
         8wu5j50xoSRIl+P1hvMQ+Ao6mGY3/HwoWxo0PhPsniVQHcZFCpHiqt3Ha8ajjXVMRFrx
         Y+KZXVI+/ItyI0zVEI95duXD598cbY5YVZI8dAxDtVAT5NNfUZ74nN5Y5HscqDUd6gAo
         tr4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YLOqI+FumtuV/c4bfaTL8aUDwi0OZvcNf1c1ExOV7fI=;
        fh=FxcwZofQ+miUGgYSiMdH19RgSF4O9B9A4d154BZfJIk=;
        b=jP0OyoIKq1KTRZgf1+0utme09b9srrIdJxnjIezk5Oc+sHfKZQFiRT4zhWTUz435SF
         pXonLGE6JnVgrC5k8cEr6s56dGL7LzySMwGLu66A0HzLbUsvuWBelQdIyjMQ/kTEYrnv
         AgoudoIHepf72+uTlyYuG4Di8eNCZFFAOpv3WBRBwWwVE9mNaxwHhqkqV7JnwXpK6azF
         DEt0/5M3G6pIooJv+LrKoElVTz6gOEvPvLEcATE8AYRTRuZXqV3OgsDF/fMLq9J3DEM3
         VT9oLQKNleK+Epco+etsNCjXv64PS2QygIBYM9WQwRyLA76C0M/sYXV+OR6SVlJEo0ro
         dPsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784824876; x=1785429676; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YLOqI+FumtuV/c4bfaTL8aUDwi0OZvcNf1c1ExOV7fI=;
        b=CJ6oyOTTWh7CtwcjvhOuHN6BOZlqlSOOpWnR2BoQR3Hry7QdhcfCCJI0//+eFKUhrJ
         3MIf2+NLLdGu8O03gpgL/gFqVSEJAeYWp9PM0YphLmynjHuh7tdeWPIab6y62dv6/vzc
         38yPpvYZuhFP0zzzGkzuk4Bv/EFsfpO/5vpyicwXY2HAO/bwRVZP6RYlXJJqPlfoTCme
         ZpBQIaB+jMxiaSpCpgjVCYEPTALbiGt2e7pOcoHQTgXS0BpX9UMy3NyAW9WfozZIYNuO
         4lqao8VRptw/wuJMuJkSWmFm2UOqU61PQs6QPy2rkLOr/1RcfZ+YLbygyzX7CHnmgRGQ
         xC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784824876; x=1785429676;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YLOqI+FumtuV/c4bfaTL8aUDwi0OZvcNf1c1ExOV7fI=;
        b=b72t/0NKeXH0V4osbEeo9lPY5Pwxfo8V3oynl6CmeL3DQDYGsiIg5foyO3jMjxqX9o
         y47Nw3H4uHfloYZZvarQvj28nJZq7nRZ9crtSAafXePlOId7Y2As0IJIWkaEM09veQCY
         g9LpLWQ8C2ZC2tS2tGc1XLDe0y8l4wBRxe07OBPf972c4fH5pZ88yNvJSryKMNcG+ygY
         TyJTOdpbugDXkYJm5eeZuVgLpcVtXdSNWtN2e0Ob2xD7QGrxiaRNfTUA+9ps6XMow6X6
         yWznFHeFRZQeD9FgJoN7Iwj+aE9c+dUraSJgCE7QQat3OgP90ek8MrJmCQef4fC5twJS
         p/WA==
X-Forwarded-Encrypted: i=1; AHgh+RrgXLeeOW1zcABmihFv5SlGyaZCjuysvERfUC+17v5gYX/D62yjcIUp3OfFVAteKc6RFMWNeSPz1MpM9S+w@vger.kernel.org
X-Gm-Message-State: AOJu0YztXSidXLIEvMlo7MLHo85LV/JhXmD9/vTAZ0bYFT8gBEjyZlQq
	yibyi0VvWUBLsUYuGN4aGDk/NJy5ger644gYZaCUlkmpA6sqw9YTFf3/JU5Rs2mDXAgfpespouX
	XQo7X/UCYFaghqP6jDVzJ6mIwHpZlDe0=
X-Gm-Gg: AR+sD10zVUE726JRuu11D0NmDrUsCQOVw71Vq2IifJE6So0i4CM4gedz4Jo+SIiprD8
	7LvUGBNOrGtkdhYX2eI9L8pqBTJGZECc6z2NiVCMtYBZlJ2GVQPMjND8eMrW00njPabP0TDbsYz
	0LvIT6Y9wDZhdT7M96gi7IzTaKvnTLCH13cWoxU+w9slbh8+YsUKdQdDrSwyJ7CGcmy88z4Dst1
	zTPPyynEzWzdzUZ2av5tqq1Y42A6qO3xEgobqgjY3X/BzyFuO05ZrmfVpmqrYonXcxOTjR7DsPa
	fjDRtwbkJ2/FvSZSIA==
X-Received: by 2002:a17:907:74e:b0:c1c:4dae:db8f with SMTP id
 a640c23a62f3a-c1c50c2a22amr153339766b.32.1784824875570; Thu, 23 Jul 2026
 09:41:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amIqfCo25rLtM2U0@redhat.com> <amIqmbbZx3NlzUsX@redhat.com>
In-Reply-To: <amIqmbbZx3NlzUsX@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 23 Jul 2026 18:41:03 +0200
X-Gm-Features: AUfX_myk5ohbAeLCUW_8BHWG8PrCTwyvCqhJkmomoMpR89M_VdHXdqNLxnSYjm8
Message-ID: <CAGudoHFPUVmzC_34i3J03gnqufaDgh-FSCeZ4G23-vXU+7q8Fg@mail.gmail.com>
Subject: Re: [PATCH 1/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 4:52=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> pipe_poll() unconditionally sets poll_usage on the first call, forcing
> anon_pipe_write() to wake up readers on every write even if the pipe was
> not empty. But this is only needed for epoll's "nasty semantics"; poll()
> and select() users pay for it for no reason.
>
> Rename it to epoll_usage, and only set it when the caller is actually
> using epoll on the read side of the pipe.
>

I am worried in that the poll_usage thing showed up in 2021 in commit
3b844826b6c6affa ("pipe: avoid unnecessary EPOLLET wakeups under
normal loads"), fixing up "missing" wakeups after some rework. Even
then it went ahead and as you noted it also did it for poll/select
users. So by Hyrum's law there is plenty of potential for someone to
depend on it.

However, I think this makes sense to try out and there is history of
committing possibly breaking changes, so I think the idea is fine to
go in.

I does rub me the wrong way that epoll lands in the same handler
though, but that's not something I'm going to do anything about.

The routine pretends to operate in a lockless manner, possibly
returning only a partial result. But it guarantees not blocking when
it should not by queueing up the caller unconditionally, which later
has to be undone. Have you considered patching that up? (as in, do the
work. if there are no events, queue up and do the work again -- should
reduce work if there was stuff already there)

> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  fs/pipe.c                 | 23 +++++++++++++++++++----
>  include/linux/pipe_fs_i.h |  6 ++++--
>  2 files changed, 23 insertions(+), 6 deletions(-)
>
> diff --git a/fs/pipe.c b/fs/pipe.c
> index 32140cb00d7e..b45b4b8d0b0b 100644
> --- a/fs/pipe.c
> +++ b/fs/pipe.c
> @@ -357,6 +357,23 @@ static inline unsigned int pipe_update_tail(struct p=
ipe_inode_info *pipe,
>         return tail;
>  }
>
> +static void pipe_set_epoll_usage(struct file *filp, struct pipe_inode_in=
fo *pipe)
> +{
> +#ifdef CONFIG_EPOLL
> +       if ((filp->f_mode & FMODE_READ) && filp->f_ep &&
> +           unlikely(!READ_ONCE(pipe->epoll_usage)))
> +               WRITE_ONCE(pipe->epoll_usage, true);
> +#endif
> +}
> +
> +static bool pipe_get_epoll_usage(struct pipe_inode_info *pipe)
> +{
> +#ifdef CONFIG_EPOLL
> +       return pipe->epoll_usage;
> +#endif

If patching this up I think a comment explaining what's going on would be n=
ice.

I think you could steal parts of
3a34b13a88caeb2800ab44a4918f230041b37dd9 for that purpose.

> +       return false;
> +}
> +
>  static ssize_t
>  anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
>  {
> @@ -689,7 +706,7 @@ anon_pipe_write(struct kiocb *iocb, struct iov_iter *=
from)
>          * Epoll nonsensically wants a wakeup whether the pipe
>          * was already empty or not.
>          */
> -       if (was_empty || pipe->poll_usage)
> +       if (was_empty || pipe_get_epoll_usage(pipe))
>                 wake_up_interruptible_sync_poll(&pipe->rd_wait, EPOLLIN |=
 EPOLLRDNORM);
>         kill_fasync(&pipe->fasync_readers, SIGIO, POLL_IN);
>         if (wake_next_writer)
> @@ -761,9 +778,7 @@ pipe_poll(struct file *filp, poll_table *wait)
>         union pipe_index idx;
>
>         /* Epoll has some historical nasty semantics, this enables them *=
/
> -       if (unlikely(!READ_ONCE(pipe->poll_usage)))
> -               WRITE_ONCE(pipe->poll_usage, true);
> -
> +       pipe_set_epoll_usage(filp, pipe);
>         /*
>          * Reading pipe state only -- no need for acquiring the semaphore=
.
>          *

nit: I would add a new line between this and the following comment
