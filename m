Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290FD4137A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784904214; cv=pass; b=EL/lctbnxYk0O0Nf2lhtOHj2nIUCds8UHizkMV4J3m0LBAK0WFZTAyPUiKcO2tgOzhkbuFvDKnMAVCnvSbgCXHm/gBiaRyAfrDVuSJzXuVuCVxPYR3FLs/CyhWxIlG9CIGXHG/RPUq8vPM/6Lr3bHHs95gj38bBEPonGRCcEUDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784904214; c=relaxed/simple;
	bh=2oZVdl+YtlMluPxd6Dzak9mezaDc5cB7B6pdlky0Xc0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MbvVSlTcOoZZ2oTuv9PE2BpxbKeZnwXre0sh94cpDhZx1PORc77ojZu2vN4aqabWwmI7IBGVVSwlAxnYSTHBgMPgZ4PikQzNHK/JvjBWixYEFwvELTAD8+Q+7VLibqwzYbIXRKC5xWqKHVRnEXa4DAdfWA5t6BSMHikyVnBn8Zc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M5z8GqjG; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5z8GqjG"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c4db7ca93so70210766b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Jul 2026 07:43:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784904211; cv=none;
        d=google.com; s=arc-20260327;
        b=HisH+0vy7aIEIrD77tkw4vwnCK7GWpQNciWEpDApZjUBKIxVMn5xuuF1m23AbrixJb
         R4yAwqj9Va8A0zfWPJnJDSf7YLTMG30b5jdRZJJhMr6hPzlhd4IK+fr9EPhZ7tnkMYrR
         tTseIXmuM+UR51N0Smy0njpCAl8vtFJPrBbivAqJceUTyg1RGywuABhGfBnHmsfopoOO
         jrJ2+7mYflmoqIARC8F/QAMJWFVn0vxpHdgNE8w46Zc9+Y8rdGdN+YclhfBMWETQw8KE
         Bmris/q6WAnelzH/hnu0BQoiWdcZpR6OgkxD8fHsecZVdunSf9HpzxOyFbhGyzNNNrc8
         ftQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ShRRGKujzcXZ1TiOmitsEwM71LNmyg3rqboTjurun4Y=;
        fh=QAXbAIpp0mzVuW0oyobsBomWkPOMsNDRrDNEWoit14U=;
        b=qLmyy63QsMxn3rfgUs66n0o6za/xlAYd5BwUuUwZWQMwqVfaAGUeuXX2MaTOhBBvRQ
         6RAAahdLY55KyFzY29u0i5tOPeJ4KoV9ZgqT+kVyc+KxLOwdRseSGo6gN8eE1DGATGP7
         ynt40AdDD5MyaL67XDatwxxsavFkPWQ1sYjxAt5vmb28S1iQGrWCsX6Wgm2/ZqY/MXod
         6gFTNHY8DPz8nqcNi00yhX81X6SWn8pJvNO3jWfuFYYkR8RMfcZX3irv3p+85siwofQw
         pLVQCaQUTJmisO6RztTj0EshV2vsVRopGve4sL7j+Twdaneuwamqz05bJBKAn2msrlcV
         B1Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784904211; x=1785509011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ShRRGKujzcXZ1TiOmitsEwM71LNmyg3rqboTjurun4Y=;
        b=M5z8GqjGov2YXFCf8SKEZb852HwdQY0rhfWAnFdoWGxHyg7YuMPlwKJb+/XTpN/pOP
         O3YOdjdlcwu1U08oiD8DC97F5v8yoGWWf9nx5ZApTxDkKTv05IjNo3ICmkhqA/VBZtE8
         D+io8SfDdJ7sDPHu98SFpKD9se+6U974zWNCCQRqPo7IwAMzGYEGPlwGnqIQjRwLVfgn
         4ckC6MrxPRSN6KzE6swsavbqgNKNM0ma+rqt7tNjIpMPjCFJgWt1Qwg1zEnEPcTJqN7L
         1TLJuFX1/uz23itvc1lIvJvUyy2QAgX8vkM/qRAjNbyG9OYvHwPv9fW9gRGjF+lH4v6J
         VMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784904211; x=1785509011;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ShRRGKujzcXZ1TiOmitsEwM71LNmyg3rqboTjurun4Y=;
        b=Ag2Rp7cBWT+KF0hJSj3gDrah/Zk27o5wB+hQJmDxB0m6SDCaPW5rTZnGiB6WdAYQQh
         q5hWAkqKdxL49RqllYjpeW/G3PJZgQm2LUpzHE80QLaTroWuDyiu62oZb/I5wCfDdKDp
         dH1LLn4R0nPrzw3udoLg4RV6pNzCN7AXKepsbAmwZ079lAfriive5hxqZmguXFSX8avL
         XZq9odUqFFdDJ8LGkUnz/ny1OYrzzlz7oDEgXopaUebKOmRKO3LyYZGU68e0RpgooDkn
         enXLXXICqGr5iNQrHHKKLW67Vc5Ty08n9YP+OVxmJmUPpshsFYvvBEYghDKGCoKvxBsY
         XkKQ==
X-Forwarded-Encrypted: i=1; AHgh+RpeDZTZk8QNvQjhg9XR/JownPtvH0NZWJB/uHeAtopjvk+yUi2QG3A7+7BZtI9Kt4PuRHgwC+Z7TMR/NCIr@vger.kernel.org
X-Gm-Message-State: AOJu0YwVCcZrGmNdmVNv4zYibIucP/NjVwyP7+8PHrjYgpLQ16QHS5BK
	dcsCegJZuWsRpPGdxcHfKoDgqiV1k8ieENH3LqKX4smXa7wNhK+5k794xDPWM8s3GVBo3Bhq/KT
	P9yLWu6QStKZ6AjA5IHGnjLdrLkv8JjQ=
X-Gm-Gg: AR+sD10ydZyolXPj6eng0tcYu/zzZEYvk3oP6UOtfV4jKzwrGzYE6iNwuZ9GZ+yKnW4
	fM8czpM3tkKnBTY2287B9oc2dbEgw6huGXikikZE64ayFRO26Y/78Stt7gbP3CMPzquCiceGR44
	8yCm4PowihOaPed88u1QClkvrVL0cnualyrHqECTvF8GZXRexlbt/ha8lnpMZlqBUcGZDDre10t
	eLXugwggiHmaH4Bpc6ko+G2EhdvNuBzgaxTlyHuPAub/mnyUxxOhdErl2V0U4M2RKoMTYvNunbl
	UkC+i8fPWzvCAWT+2Q==
X-Received: by 2002:a17:907:7ba8:b0:c15:d422:3bde with SMTP id
 a640c23a62f3a-c1c50d1c4d9mr375136166b.32.1784904211164; Fri, 24 Jul 2026
 07:43:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <amIqfCo25rLtM2U0@redhat.com> <amIu5WWgTNkdvqIz@redhat.com> <amNvebqiG2fH0W_L@redhat.com>
In-Reply-To: <amNvebqiG2fH0W_L@redhat.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 24 Jul 2026 16:43:18 +0200
X-Gm-Features: AUfX_mzn6tikByLwhHYWsdsQESjwRlCjD9AOkTBfYp8Z2SIwO-rx0kjpSwhwJEM
Message-ID: <CAGudoHGiKYfF6L1yFy+QZgQaTt5ULnp6rgRaZE=6BANkpjrb7g@mail.gmail.com>
Subject: Re: [PATCH 0/1] pipe: only enable the extra wake_up(rd_wait) when
 epoll is actually used
To: Oleg Nesterov <oleg@redhat.com>
Cc: Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Alexey Gladkov <legion@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 3:58=E2=80=AFPM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 07/23, Oleg Nesterov wrote:
> >
> > OK, sashiko has some concerns
> >
> >       https://sashiko.dev/#/patchset/amIqmbbZx3NlzUsX%40redhat.com
>
> Let me quote:
>
>         Does skipping this wakeup for non-epoll consumers break io_uring?
>
>         Applications polling pipes via io_uring do not attach an eventpol=
l context,
>         so pipe->epoll_usage will be false. If a writer writes to an empt=
y pipe,
>         io_uring receives the wakeup.
>
>         If the writer then writes a second chunk before the first is drai=
ned,
>         anon_pipe_write() observes was_empty =3D=3D false and
>         pipe_get_epoll_usage() =3D=3D false, skipping the waitqueue wakeu=
p.
>
>         Could this cause io_uring to miss events and hang permanently, wa=
iting
>         for a CQE that will never be emitted for the new data?
>
> and I am starting to think sashiko is right (damn as always ;) and this
> patch does affect/break io_uring.
>
> Jens, could you confirm? If yes, we need to update the comments in pipe.c
> (I've attached 1/1 at the end, so that you can see what this patch does)
>
> I know nothing about io_uring and io_uring/poll.c is not trivial to say a=
t
> least ;) please check my understanding.
>
> It seems that IORING_OP_POLL_ADD / IORING_POLL_ADD_MULTI is edge-triggere=
d
> by default! Like EPOLL_CTL_ADD / EPOLLET.
>
> This means that io_uring depends on the "nasty semantics" too, io_poll_wa=
ke()
> path should add the task work which calls io_req_post_cqe() every time th=
e new
> data arrives, even if the pipe was not empty.
>

well io_uring could set the flag as well in that case? it does not
inherently mean random select and poll consumers definitely need this.
