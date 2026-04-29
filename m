Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01252401A3A
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777479353; cv=pass; b=Pe3Vi0g5cJKLm8W47ogcg7Ch9ESsOO9O0nqvZIEgZkK1JHzZX8Yrf3UoasIbOlKj1r7jClKkBwgyfVAc60PNoDyZFbNxqx8S8N7rcl8sJRO50CLWdQsoxc+5AD/+YQvUHrbqvY+mLIjMrLLXBg0bLKqaWJx2LA5s48lJ7ZYTRHw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777479353; c=relaxed/simple;
	bh=UoIW4gQUWE013Kb19RWYjXw36nGDV8KHgdLDC5/NgGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ItT51Fz2pKe0idWdJI14xFJeGDL1+OzifiwDgdwlBhRzT4PJ6a1Kaa45l4CLkUcEd6gupSQoag4QP6msRrajNCGVFCTlaKY8FZUxXbNc+V5/MGvIDWrImBWFEJQrib1xZqMclJYoFCMKXkUKTLsSIR6Jy0+rCli2U6Klrf8CdQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KluKyReo; arc=pass smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KluKyReo"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-448528f4e69so448477f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Apr 2026 09:15:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777479348; cv=none;
        d=google.com; s=arc-20240605;
        b=IqNed6IMXpVDy1pt6aRlXEk6Ljcvc918gUDHdY5oafn1Obkc4L0lURmVa8aSnvBhPl
         xhdb8+cIF/tYQ8xUWjyBzM16YUFlRzUIL8EFb2krdlX2Z7hQ0vDLR7c0J+j4gBIwoGyx
         /DwIITxlmK9hUwqKkjWVbMQdpe7IcRF+TKfH1bSRqqdveiD1uD1v88KbG8e5zBvHGL9d
         hPto6vkitTDe0DcEGXUX5yYMEj0fM7WoEUNPvUqYmHmHzqy4jnM/c35vTVEP/+b4Yfnp
         EQMD8kZ/NoDvn3bUpi/CdqOjrYyzi4d68E+INC+oihZbIN6vto97wIiHs3BRxUvNoSpx
         YgRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JYC0xkPIS01yAJd4WeaRvX00ouVADvZUNX5MF07GPQI=;
        fh=PwBvCy9uqTe2vraXRqjP5++P0MVxTW8eZUZdZC2A9c0=;
        b=KwaOy7Ep4hJf5JhRA2yNuoe/l5oFAhsOWWSqThjtqznGlcO2ZDSExbjk/CXIsjrAit
         vWLqGofRwdP5W2XSaXaDEmfPpcGYgJoMVDFeYQsSRQO1ZoH91WXOT2Fc9uGC+i6HMS2b
         LNKYMXCz3kMwVWe01aWXyhzKSOxC3ZsUzfJezuYx9LUEo1hzmBLB9hY0bNGlMnWYACk3
         08POoOTaVGzW91ArG3X94SKgAgLY34ojmf1BDX9XIYyCoVRdlXcAt4rA4gpIAYaCJ87U
         P7hGj/3yMPIbqzxWgPNghJHyt/po4shpCg8hgdiRzXR8CVDVf1Iaw74ATtqtedBDiGTJ
         1IfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777479348; x=1778084148; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JYC0xkPIS01yAJd4WeaRvX00ouVADvZUNX5MF07GPQI=;
        b=KluKyReoe9yr4XrUFQ5LXKt8KJ68VHZ6lt4m/pVemv59dg0MVCQssWpMxpjAssdU5G
         eCFLS5paXELrcPgslLS/PG3XwJjEC5r1MGcyX/aLHpAGlu2Fi+Va7mfihj4A++Vy6SuH
         z986z3troCuxECXiNegKOVxO8UwVJrOm0bDZiffLg7Crgp7wsEPKt4GJeC5fVJE78kZ+
         1qPTk5ySltpcb7EZZfbVIX65nN6y9PFGpRPi5uFRJPFhCO59Q/BVqp1TlMAE9xpuTyC0
         EWWaV9g6Xwb+2950PUYNzZBehvU4wrOt7O/9ahRI3MMV3VfC6dIC4wzdPG/WKIqPb/l8
         NkGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777479348; x=1778084148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JYC0xkPIS01yAJd4WeaRvX00ouVADvZUNX5MF07GPQI=;
        b=XZ+uVRTthNj+3bTnPGOa+YEVfvq41zXqZsA9G1lQsark+ni2P+kYBTmGhxv/8BhrI3
         6c59fp+JPDRoWoJEz2sLr53Zpqcx/fxurpLoqtO7b4wLAXIwDMR5YoRCSaF9SWiDtA8b
         qnj/ynyxDp2+9DOxR2QztJDqUEAzGJHbYz4H5biYceD/N5HlQjc7lIJ+iUJIqTO0jlbf
         OirjU0Ei+tAjyPiwQ4nfOHcxByLD9MeS7Oi8HJaiqKTaNSGN225WbW6du6bANRNSbcpt
         1d3FLmiJg7taa9mTaFxN3QgBModUEapNw1yuqkVo7sZfPC3A7DtE8fxrMAEaArJtPJ3N
         pR3Q==
X-Forwarded-Encrypted: i=1; AFNElJ9zSGG3QRc6+r+t5ZcQi4rq4jpmuGrFlNlxS7YIdAQdOMRrhCLE/4SBVq44Q3vAcKnO35d7n1vTCavV9pW3@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/7V1edFQkwvisgkzu6+MyeWYeZfg70d9CFWUb8ka3qXRjURIV
	/zetLdEPbVv9vK9X+c96b4mA88xWu8A+LXHBLVm11UgeGr3NmkI54SSEgvXmvxCgbqmB5iVcnn5
	YxWD0j1TMaNtNzUmGeHq7XEPRCZ6okEA=
X-Gm-Gg: AeBDies3uNhwnuIfgde1fO8GP4hXa1aXXxBPKD0Q8DCYUKPWcxwjtGoEqbZFonLlrt4
	AA1x16PuUijp6Ai0VWMj21NMQRbt+VzAPVLmjs+6Fz8zRwg866S3LtmpxHCwzsEN0iTs8syuId4
	mZEZ9Xn6AsvBZh6C81yXYTfarO+e+xR3FYF2MDtixEJeuFSoMiUP3475L5q6OaSjcq1PlAr70KS
	W5DMk3Gvh5l1vn8dYfLT6i5IJW47mULq8/kafyIULODqxZbDOOlYr1OpiIL5+7dZYWJqisdvMp3
	g+dP3OldAYNUE8hOWyhinxvyPcDWA86n1Q==
X-Received: by 2002:a05:6000:24c3:b0:43d:7a97:78b5 with SMTP id
 ffacd0b85a97d-44649c9940dmr15364531f8f.33.1777479347715; Wed, 29 Apr 2026
 09:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
In-Reply-To: <20260413-reduced-nr-ring-queues_3-v4-0-982b6414b723@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 29 Apr 2026 17:15:33 +0100
X-Gm-Features: AVHnY4IV9C8LKGPjnzYfzqyFJf8Q0mICXLqsyw7IaS3ZVr0kWQO2yu0pNZ3Jkks
Message-ID: <CAJnrk1ZVdWtGAiXLM+ax49jh6JOq5j0nvs8gQoS6HCV78hVGiA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] fuse: {io-uring} Allow to reduce the number of
 queues and request distribution
To: bernd@bsbernd.com
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Luis Henriques <luis@igalia.com>, Gang He <dchg2000@gmail.com>, Bernd Schubert <bschubert@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 10:41=E2=80=AFAM Bernd Schubert via B4 Relay
<devnull+bernd.bsbernd.com@kernel.org> wrote:
>
> This adds bitmaps that track which queues are registered and which queues
> do not have queued requests.
> These bitmaps are then used to map from request core to queue
> and also allow load distribution. NUMA affinity is handled and
> fuse client/server protocol does not need changes, all is handled
> in fuse client internally.
>
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> ---
> Changes in v4:
> - Fix leak of ring->numa_q_map
> - Fix q-imbalance due to an issue in static cpu->qid mapping
> - Performance tunings, like preferring the current cpu
> - Removal of distribution among queues, Joanne had concerns about it.
>   As it is an optimization, it can be added later again. At least
>   most of it was removed, some light distribution is still left in.
> - Link to v3: https://lore.kernel.org/r/20251013-reduced-nr-ring-queues_3=
-v3-0-6d87c8aa31ae@ddn.com
>
> Changes in v3:
> - removed FUSE_URING_QUEUE_THRESHOLD (Luis)
> - Fixed accidentaly early return of queue1 in fuse_uring_best_queue()
> - Fixed similar early return 'best_global'
> - Added sanity checks for cpu_to_node()
> - Removed retry loops in fuse_uring_best_queue() for code simplicity
> - Reduced local numa retries in fuse_uring_get_queue
> - Added 'FUSE_URING_REDUCED_Q' FUSE_INIT flag to inform userspace
>   about the possibility to reduced queues
> - Link to v2: https://lore.kernel.org/r/20251003-reduced-nr-ring-queues_3=
-v2-0-742ff1a8fc58@ddn.com
> - Removed wake-on-same cpu patch from this series,
>   it will be send out independently
> - Used READ_ONCE(queue->nr_reqs) as the value is updated (with a lock bei=
ng
>   hold) by other threads and possibly cpus.
>
> ---
> Bernd Schubert (8):
>       fuse: {io-uring} Add queue length counters
>       fuse: {io-uring} Rename ring->nr_queues to max_nr_queues
>       fuse: {io-uring} Use bitmaps to track registered queues
>       fuse: Fetch a queued fuse request on command registration
>       fuse: {io-uring} Allow reduced number of ring queues
>       fuse: {io-uring} Queue background requests on a different core
>       fuse: Add retry attempts for numa local queues for load distributio=
n
>       fuse: {io-uring} Prefer the current core over mapping

Thank you for your work and time on this series, Bernd. Our internal
customers will definitely be using this feature.

I left a few comments on your patches but they could all be deferred
to the future as follow-ups. The only thing I think that needs to be
figured out now is whether userspace passes in queue count upfront at
registration time and requests are gated until the queues have
completed set up.

Thanks,
Joanne

>
>  fs/fuse/dev_uring.c       | 303 ++++++++++++++++++++++++++++++++++------=
------
>  fs/fuse/dev_uring_i.h     |  25 +++-
>  fs/fuse/inode.c           |   2 +-
>  include/uapi/linux/fuse.h |   3 +
>  4 files changed, 252 insertions(+), 81 deletions(-)
> ---
> base-commit: 028ef9c96e96197026887c0f092424679298aae8
> change-id: 20250722-reduced-nr-ring-queues_3-6acb79dad978
>
> Best regards,
> --
> Bernd Schubert <bernd@bsbernd.com>
>
>
