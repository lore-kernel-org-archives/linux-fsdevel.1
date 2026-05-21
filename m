Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4303D8100
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779367143; cv=pass; b=nAwnZc5yaO57bzfaurO0wDoVa97328jMWrwaQHr2jIN/wEpaInGTOAUJkci42k1HEBo9aVCICHGusRXcONFIA503t3+CYHfgqx0k8HfZpu7que2dAppkGwpfMmvJ4ftgoGDCxbUNYGVqND9JSYAYoX294k6dvCBa0oMZ7yZ32WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779367143; c=relaxed/simple;
	bh=RiahDbEJAc+a6SEUc46bDIXeBBSM67xZIAhPJO19bM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIXxeBYjTaJs1QgJ+292nI25g0+swRuN00dZU3Eb0iBdM9EO5mLNqv5n32Uwf4AWZqCrLtZSs/yYGzXY/HE85rRxsR7zvREmGDLAtq00wmfW+wm2mxksd+Ag0aPb6JpInodQQnKqi0x0UABZMw/sbM9Qt78tu7L+eAMrA5GtFNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G6t7CYjH; arc=pass smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6t7CYjH"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6877c719cb0so2243643a12.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 05:39:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779367140; cv=none;
        d=google.com; s=arc-20240605;
        b=D+ETbwPlHnUWp5g58IDaemG/tly8pz5vq1xzbievdT3kGxLVFurpor/UsHANAFizmA
         Dv85pEQEjC7Gfx6qrjXxaJox3chELI60mI3J3fEZXLBh02A1vB7jKz8Q9WD42Ud7nBke
         TQc/qWMbeYmo+GPQc2mjCTGf3vbJz3FRnmaZQLdwbxZpg23SB/JkndojXU+E+bl1sS44
         IMxKSkWMWdjqPRVFQSWeEYqCFxmqZxkxIN8/2gSwxPUDAkRqTg5znRUgk0VOQjLuQPLk
         AJkOUgoMW1UgHJ7l1ViXQQic/T8Y79rbKFuZjcFcpilmgJW2s9k0n0xjzDLj8Vw72uYi
         7oYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        fh=DS0TROp2jKYzqPSJgZpz7zj0c73uf1je9yOJYjo8RPc=;
        b=Jq+IzXDO3pZHtJll4udsva+2u2ohug/7luwZIdyK7moQly4J4avjVbjFDAxhJKXchW
         o9ehlihxyiKDkPg7P/cFvs5Apw8u7QvwTh/WvPidaEuLBEpU1dID6aP+K66HGzteSgGs
         4aUFu+pdg9zfFXFt3lJJ0SBrsUDdYN4kuHRGlrb/DxRa7TXOBjeiaWJsDl2F41OcLkzM
         TLjsF7hPmVrXtPrrIFVmudcE3D/z4NIBRy4jER3Ue1Yn94TlBMW8shYRzxdFURvkWh2z
         rKgFjO8Dp+G+Iywov06dXA0asR3hh03xKkGm/Ncz4ieTY+4tXdHTtJYfoRbcx2ez7/7Q
         15BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779367140; x=1779971940; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        b=G6t7CYjHbyGZ7gGKlWqvPx9K0P/fFJ1Yqfdyz4G0HNiGlffzFndo64mp63NwSqJTBs
         5/EgLXZKHLt5OuPTzoEAPq/uRKMBsnEMzi10+Klv7VPdMV1p8B+iu6Zsi2Kf6LcjXMaO
         8Vn975La2iMumihnbYDIMZMktwezlaw3Wf1lIQHwBGv/KqG6He1OCCqm2DCbL+ggDEih
         U6rU9CJi2kMMRWX2nl4t1kz/1UuKerQ2BbVyvl4HOIoITmEqIPFWA3DO/sdDAefa70+E
         OSg/pK1DEnvCQ0hixSsoZC4H3OwbT+apMMiy70vnUEaHoINx4fHGb+XztwlbqhUmreKG
         dIDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779367140; x=1779971940;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dopi5lqgBCxQSuAudmyQPmhNkwArDVQ9G92RMimBsT4=;
        b=UX2aHHCJdF1/Ul/qZUe5fRY9NrnUbxlPrWL9JC9IHw3DIGo3PwxTkHGUjnzzC4Za03
         DnKFQyezXOcaZWgal2ow96FSlmbvuCduQlvAunXBUlIjAzoGGW8ZwIbbujeITrDVcPIT
         Kx35bAggetT0yzIy6zfJBfeQuXXFS7eRcjqv6IVAGQ5E5lXkf2fFEWChgymASFz8U9wY
         nymeofr6K3+kNdke88CSOWIPAtVGufGK6FnASL/M1j2htT9QgGXPC+OJ3JdEzUF6wyyS
         3v0n++whK7Bfdezh/UKUT1ZAeifJ8MpjzHRb3qzNFApuIu2o/qGyj1aQeqeREFN9PI6Y
         U3Bw==
X-Forwarded-Encrypted: i=1; AFNElJ/w/pB0t68LNsC33oykhfqmwXHz2A905IsvRB2vn81qp5fc8BFkqybeHER+SQBSkVs3k8qyfM3+BvWSmp+E@vger.kernel.org
X-Gm-Message-State: AOJu0YxDBBsu2FXUZF3wgxx4Cw9JdWbHRIwF4tkfRuMf4GF4B5xtzgvf
	ywiJ9yxKe29iT5OE2hWLW6a34DgZsc/nrAJ2cZRo8tQ1Whe4MrIZy+1CNK9sXfRMjM2I1iGj3jq
	Z328X04Q/UDO4tfX/m9akkNjTWjX2XsU=
X-Gm-Gg: Acq92OFplyq/NDN+5i0+oQmLxbGpLEMFWh4oDA4K6jCujCoL40mKyLoWCpnVQ0YDnO6
	IIgcJa4lTEcGKPTJAVCPYWYErrVKXFDHiTsDJSoRbPQA4rghUPlLbgOTfEwqoHK54r3P6CLGaQe
	JCjo1MPdU1zjJqpx4b+biUwG559EyFCoeyRxBBylTgQIljCFh9bZC+YJX9rPdQPcVf+2YM+IshX
	4PUFRcTiDLhcBMTmIkwDgA0A0DeZcwVq2A4NilNbtsKGIlBxS+6x798QpoHfep55U/VvgmC4fDq
	dw19T3sY4svg4wTlWzH3gAEIm7Qvh3VIr+gkUa0ZHRcp2OVZew==
X-Received: by 2002:a05:6402:34c4:b0:683:1cc8:84ae with SMTP id
 4fb4d7f45d1cf-688356291damr1244493a12.7.1779367140215; Thu, 21 May 2026
 05:39:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1752824628.git.namcao@linutronix.de> <43d64ad765e2c47e958f01246320359b11379466.1752824628.git.namcao@linutronix.de>
 <CACSApvZT5F4F36jLWEc5v_AbqZVQpmH1W7UK21tB9nPu=OtmBA@mail.gmail.com>
 <20250718085948.3xXGcxeQ@linutronix.de> <20260429-november-speisen-3084d769d316@brauner>
 <87340exm2o.fsf@yellow.woof> <xbotidrmois5ygxtqtwqzczkt76wcc7uw5cz5lptda53coaavj@pzvxcpe534cu>
 <87cxzc62yp.fsf@yellow.woof>
In-Reply-To: <87cxzc62yp.fsf@yellow.woof>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 21 May 2026 14:38:47 +0200
X-Gm-Features: AVHnY4L3kuzvNft9YsihiRD6AmCZerhnkTxoTD2mo1YBA8rn2fL0bTYmJkGq3-c
Message-ID: <CAGudoHFGHsuGUXmefSrGfOkdcoPJnC5a1qbjc9_G4guC4LvJgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] eventpoll: Fix epoll_wait() report false negative
To: Nam Cao <namcao@linutronix.de>
Cc: Christian Brauner <brauner@kernel.org>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	Davidlohr Bueso <dave@stgolabs.net>, Khazhismel Kumykov <khazhy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, Jens Axboe <axboe@kernel.dk>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 3, 2026 at 3:24=E2=80=AFPM Nam Cao <namcao@linutronix.de> wrote=
:
>
> Mateusz Guzik <mjguzik@gmail.com> writes:
> > Strictly speaking more error prone than the seq approach, but should be
> > faster on weaker-ordered archs thanks to avoided fences.
> >
> > I'm definitely not going to protest the seqc route.
>
> Linus probably wouldn't be thrilled if I break epoll again, so let's
> stay with the simpler seqcount route.
>
> Nam
>
> diff --git a/fs/eventpoll.c b/fs/eventpoll.c
> index a3090b446af1..22c3f0186476 100644
> --- a/fs/eventpoll.c
> +++ b/fs/eventpoll.c
> @@ -38,6 +38,7 @@
>  #include <linux/compat.h>
>  #include <linux/rculist.h>
>  #include <linux/capability.h>
> +#include <linux/seqlock.h>
>  #include <net/busy_poll.h>
>
>  /*
> @@ -190,6 +191,9 @@ struct eventpoll {
>         /* Lock which protects rdllist and ovflist */
>         spinlock_t lock;
>
> +       /* Protect switching between rdllist and ovflist */
> +       seqcount_spinlock_t seq;
> +
>         /* RB tree root used to store monitored fd structs */
>         struct rb_root_cached rbr;
>
> @@ -382,8 +386,17 @@ static inline struct epitem *ep_item_from_wait(wait_=
queue_entry_t *p)
>   */
>  static inline int ep_events_available(struct eventpoll *ep)
>  {
> -       return !list_empty_careful(&ep->rdllist) ||
> -               READ_ONCE(ep->ovflist) !=3D EP_UNACTIVE_PTR;
> +       bool events_available;
> +       unsigned int seq;
> +
> +       do {
> +               seq =3D read_seqcount_begin(&ep->seq);
> +
> +               events_available =3D !list_empty_careful(&ep->rdllist) ||
> +                                  READ_ONCE(ep->ovflist) !=3D EP_UNACTIV=
E_PTR;
> +       } while (read_seqcount_retry(&ep->seq, seq));
> +
> +       return events_available;
>  }
>
>  #ifdef CONFIG_NET_RX_BUSY_POLL
> @@ -735,8 +748,12 @@ static void ep_start_scan(struct eventpoll *ep, stru=
ct list_head *txlist)
>          */
>         lockdep_assert_irqs_enabled();
>         spin_lock_irq(&ep->lock);
> +       write_seqcount_begin(&ep->seq);
> +
>         list_splice_init(&ep->rdllist, txlist);
>         WRITE_ONCE(ep->ovflist, NULL);
> +
> +       write_seqcount_end(&ep->seq);
>         spin_unlock_irq(&ep->lock);
>  }
>
> @@ -768,6 +785,9 @@ static void ep_done_scan(struct eventpoll *ep,
>                         ep_pm_stay_awake(epi);
>                 }
>         }
> +
> +       write_seqcount_begin(&ep->seq);
> +
>         /*
>          * We need to set back ep->ovflist to EP_UNACTIVE_PTR, so that af=
ter
>          * releasing the lock, events will be queued in the normal way in=
side
> @@ -779,6 +799,9 @@ static void ep_done_scan(struct eventpoll *ep,
>          * Quickly re-inject items left on "txlist".
>          */
>         list_splice(txlist, &ep->rdllist);
> +
> +       write_seqcount_end(&ep->seq);
> +
>         __pm_relax(ep->ws);
>
>         if (!list_empty(&ep->rdllist)) {
> @@ -1155,6 +1178,7 @@ static int ep_alloc(struct eventpoll **pep)
>
>         mutex_init(&ep->mtx);
>         spin_lock_init(&ep->lock);
> +       seqcount_spinlock_init(&ep->seq, &ep->lock);
>         init_waitqueue_head(&ep->wq);
>         init_waitqueue_head(&ep->poll_wait);
>         INIT_LIST_HEAD(&ep->rdllist);

Apologies for late reply.

The diff reads ok to me, but I would consider not looping in case of
seq mismatch.

So does it solve the problem?

I think a somewhat of a blocker here would be to bench the thing -- I
would expect some slowdown compared to stock kernel, but should be
still be faster than the previously proposed patch.
