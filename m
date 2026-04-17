Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462A032AADE
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 11:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423954; cv=pass; b=gv/rN7RfB0rF/FaJIMA2jzvEz/VSV6TAR634kL3+OcR0L3Tw6l4SxgTRyAeTcXC2pqRUExhvALuoNNePqVHiTyqiGRdO5WvRieh4/ODKaEgii20lQLGwK/fmiHe9eyCJ20rFxUZaSYxf5lOhOb0d1PaYkQZpS0qYJNS3BFo/ddk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423954; c=relaxed/simple;
	bh=5Q2sltGnpVHfSyWPOc9qLaO8MSRgtJnou158UMIFFpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8RUA43GpZ8hyloQN/t/15c3L6CEQFc83Sa/spACUKYIwaWyqEi9R442I5z4sWhzSRdRW0WVJuKIYksN8SXHAji3R7vm7pmc7V/3Pmk7OxDHBDOLHL9FhNZ8acAW1jh4fnPXSJCEUYL86r/B1rNCBwOxkiVJruofiNsLRm2egOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1EuWJf9; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1EuWJf9"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so100391566b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Apr 2026 04:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776423951; cv=none;
        d=google.com; s=arc-20240605;
        b=csnp0/iCHTyb25FhgIe9rVYFNmhTMnVemRHYIlWa6zG8sya46cKYV9R/31BgJ3jSZD
         yuna9+KIUoNfZ7PCpa73L2n6qEYEU9nsDvgNOoGvn1k9KiZ7F+9gYGFb2QMLBDn1JilB
         5Ca268NFhqBfpa7f5Ky1AC1Mj9oe7ITBht45ezAFwOOgnlAIfP6mtLvGG/7c/cAjsHXo
         T3xocTAKFOQ4jrqY4ZJU05AzbJTu2lIiEY8yIHm77cVy4KPhuv3uE6aCKmhyYwqqsNxe
         e+utjRmcUzVMu46zKIFyx7o8t8U2EPTg7zVEjoZBpqye9m2QiCahOiE19vCwgTaqv+yc
         0Fvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VQE++04c+2x2PXmMviBWoffYDeXZnaLkX3v1ZpFuIAY=;
        fh=kdR/uCuOPG8L6IcUgp0cP7DY4T6BPvniUzZrFKMPeEI=;
        b=S0aU5F3XNEht3bn45VFiTyiKjz1olI3eyY+Uxz9MtjsGUTwcwuJVhkiSw16p0y5hRl
         Iy8oSgE1YEPQyp/Wz0Zc7kdR+sihKQ4hWoQyNhXiuMcwQeOoZBJ29d9TvJbPohqpZ+VG
         uK8Luv7Z5JeWp9sIxEfipn+XEu3OIClbMbDlzoUwdNQQmaJNG7ulReFw5DtR3lnHs/nv
         ZQYow84valyiWJFtKbaxPghJrKjBVfXPqo0WezGIGaWNLa89JkOI4fyKvFtws+DmImyI
         8HnGWw9NjOLau99blq3Ft/zCSuEek8sNUbS5Yz9qJkSqaSYtQmCiDqbvQkripJv+UDVw
         hGGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776423951; x=1777028751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQE++04c+2x2PXmMviBWoffYDeXZnaLkX3v1ZpFuIAY=;
        b=V1EuWJf9UIFJXo2U/wtdoB6l14ZbYrK5Rq8NIzT4lzVymX5fe3AAjgUfJZzTAdYBe/
         q0j00eBeIMtSNNAMKor6ssqhz8Q1rn47idPxQVX7NTZhSp3iVQDbmwjwoaJA2N60iFvl
         9JcbFAkKDlRDVoslwa/LfyIAaoDIvi85X1mdM7jkvD6c1ovBp3VVBGTpT2hVcI0uhUdx
         fV00MJ6zIoa5Uv7W1PCE16pJNG6+9JiBrnyxl8yEYn96XCdLlXjdh2n2FUzzfks4lQVb
         sui5394UDaYJI7MN8WA2DP24yZ1025M5xL02sKx8b3U12jNCcRsHJQ295bmEW4mFk1t0
         Okgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776423951; x=1777028751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQE++04c+2x2PXmMviBWoffYDeXZnaLkX3v1ZpFuIAY=;
        b=U8wNAxUqzx66dg6W5VvYvh6yV58D5giG2jIRzRaCpk+Vd1jN+rOw278ni36TYTGRTt
         3KOk2pfy25oCv5Tbi2n3ZQspDRkhGSxTTf4tl6WCiiKuCr57gDh1WYOx0zrUkgqa++u+
         gdW5tNONBfmr7phHr9CQsqx44RKLZ+t4r7S1riiuUM7QW5TmF9VFwzdPFfHns0X1ubfK
         3O5306r1UQftt/3iCEc8F6xJc+OAUzGfuqPt/hh4dsrGNJYeShogHLf3PcEndAvrxV83
         boo4ef3LNIJc/AmzTxffXR9Dvor/3omInT63PpDJNkD3qJBLZCnJt70EkjR45L/PWBA4
         xAnQ==
X-Forwarded-Encrypted: i=1; AFNElJ9RpfA+0n7bD94gaYVEnTlZ7z2SSQ2ecaNiOMnoLcQaDdR2cbok2CrZSxjdMYBDx16az6KnN1hlutB7tfvM@vger.kernel.org
X-Gm-Message-State: AOJu0Yzkarc/QByjLPKPyzfosnK07GSaMO4Q0IG1wXW0aDOD7ObsnEEb
	Mcqy0hHzscJHIQSDM3OwMOgQBpH5URhzU7t3G6HVx1ejWv5tjZKi7fD5eldUJgvc6+N/2wfLqGC
	DvTd+kz12oxKra/9ZWWn8jOnKXVBY68k=
X-Gm-Gg: AeBDievm7trmmU4x7HtDCPCul2hgyJgv5umFSjEFYqo88BZ+pvHt1ldXiTDbNffRmOO
	sC01r8LhSI++WEXfAbCPfhIz/bqssCCaKT9nay+gRCtwd9wE9ep+DBqZfoJqtV5WjZOB1BAX3GC
	FVc+3LY4Cdc36aJTnUwJfKAaTpFPmVdSQv6CwPAPfBPgP6EXIm1QMMKQTqAN+ukqy9QCVyzYRA4
	Q8mr5WpWvrrpd4gGgfalWcmIc6Qzisg3YkpaAbBwfeCm1aUo0eX/PupcPApGjOUFtprpE8BviaK
	pliWw4+8ladu11mB+FPH5+Y3DQaSf/WXqB6sZD6oI/9nFtps99WB
X-Received: by 2002:a17:907:c9a2:b0:b9c:b475:90f4 with SMTP id
 a640c23a62f3a-ba41aa1373fmr94264066b.29.1776423951115; Fri, 17 Apr 2026
 04:05:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416194844.3874004-1-ibrahimjirdeh@meta.com> <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
In-Reply-To: <20260416194844.3874004-3-ibrahimjirdeh@meta.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 17 Apr 2026 13:05:40 +0200
X-Gm-Features: AQROBzCZvAA4CTdiP4qSabqDTp_c8QOYD4UgcSapSz9emiVFC1hy86dYvHUftOI
Message-ID: <CAOQ4uxgsuypXfpSE=P-RtoajVzgHzG7=chWy6kiu5JB2gzuA=A@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] fanotify: introduce restartable permission events
To: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
Cc: jack@suse.cz, josef@toxicpanda.com, lesha@meta.com, 
	linux-fsdevel@vger.kernel.org, sargun@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 9:49=E2=80=AFPM Ibrahim Jirdeh <ibrahimjirdeh@meta.=
com> wrote:
>
> This adds support for restarting permission events. The main goal of
> the change is to provide better handling for pending events for lazy
> file loading use cases which may back fanotify events by a long-lived
> daemon. For prior discussion of approaches see [1][2].
>
> In terms of implementation, we add a new control-fd/queue-fd api.
> Control fd returned by fanotify_init keeps fanotify group alive and
> supports operations like fanotify_mark as well as a new ioctl
> FAN_IOC_OPEN_QUEUE_FD to open a queue fd. Queue fd is used
> for reading events and writing back responses. Upon release of
> queue fd, pending permission events are reinserted back into
> notification queue for reprocessing.
>
> Control-fd/queue-fd api is guarded by FAN_RESTARTABLE_EVENTS flag.
> In addition FAN_RESTARTABLE_EVENTS can only be used in conjunction
> with FAN_CLASS_CONTENT or FAN_CLASS_PRE_CONTENT, and only permission
> events can be added to the mark mask if a group is initialized with
> FAN_RESTARTABLE_EVENTS.
>
> [1] https://lore.kernel.org/linux-fsdevel/6za2mngeqslmqjg3icoubz37hbbxi6b=
i44canfsg2aajgkialt@c3ujlrjzkppr
> [2] https://lore.kernel.org/linux-fsdevel/20250623192503.2673076-1-ibrahi=
mjirdeh@meta.com
>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Link: https://lore.kernel.org/linux-fsdevel/CAOQ4uxhN6ok6BCBGbxeUt9ULq6g=
=3DqL6=3D_2_QGi8MqTHv5ZN7Vg@mail.gmail.com
> Signed-off-by: Ibrahim Jirdeh <ibrahimjirdeh@meta.com>
> ---
...
> @@ -2035,6 +2137,15 @@ static int do_fanotify_mark(int fanotify_fd, unsig=
ned int flags, __u64 mask,
>                  group->priority =3D=3D FSNOTIFY_PRIO_CONTENT)
>                 return -EINVAL;
>
> +       /*
> +        * With FAN_RESTARTABLE_EVENTS, a user is only allowed to setup
> +        * permission events and modify event flags.
> +        */
> +       if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
> +           (mask & ~(FANOTIFY_FD_EVENTS | FANOTIFY_MOUNT_EVENTS |
> +                     FANOTIFY_EVENT_FLAGS)))
> +               return -EINVAL;
> +

Sorry, my review comment was misunderstood.
I obviously meant "like" this line, not exactly the same.
This code does not do what the comment says at all.
LLM flop or human flop? ;)

       if (FAN_GROUP_FLAG(group, FAN_RESTARTABLE_EVENTS) &&
           (mask & ~(FANOTIFY_PERM_EVENTS | FANOTIFY_EVENT_FLAGS)))
               return -EINVAL;

Thanks,
Amir.
