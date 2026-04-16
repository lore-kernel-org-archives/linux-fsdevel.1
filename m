Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0900F39D6EC
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 12:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776341800; cv=pass; b=tHQVLCoYP0jVodUAD3gznraTzgoWdSYnCp6gJD/+nZRDIAKxVgrpIPlxgqCnzJ9QxXQEwH3bsPOInLp1PMl3qIE8zWUMVuWrsyAPe7i99JCmWPzs23y1rXLQ9F0ZBeT5ox0oPcX0VA8XD+vi/UqJAAYjvtZWM97lh6E82gdGucM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776341800; c=relaxed/simple;
	bh=YlQa3j1nRclliHVT43g7uYZff2wmfwHgeEAd8DL+JaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ch9ltgw+YUlp5SYQ8jMMjOHDsFvcmTnFnQCnabSjfQSTW4rlquVxLExrzP2Qrt0NYZYEVcG1EssJK3DSDITu0DDK6Lw/9WE2bxT/TZ60yULAESRZ/3ewSdmzclg0t/dNbhkH2rYGAfSED5RJ1FR/Nb2c43NSeg3UcH4+ewYhqPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=TFWUlXei; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="TFWUlXei"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-95673f7b5baso1475415241.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Apr 2026 05:16:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776341798; cv=none;
        d=google.com; s=arc-20240605;
        b=VL+QbCMwk6eQyAElk8BtRseYTNsbgFJzN8B0b8j+Gz+0Emb+Uq0M4hkBNdPFjBigDe
         EdfARGXBecMOFbzf+kuRXNvNUoxybs2NNW6x8SpnK9/5VPqHXXSs5x4wrx6dGlQhHFSn
         NRXLQFHaAcUB8SRSdhj9zW+6vnaXCfO4Tw2bWFJgAVtZxtFR9gFxl1QAgdYik4zGAX5u
         V2nR1lhvgbzqYd7MnzAM4FOROomvjNNGS3q3iq8VNQznR1Wmd21NrLMZv5m9LwJGPClc
         4L/9duBBMm220jzv3jIebkSfy75MVWqAUgbi2hZ5/UAG5ZXIDTKq9MDsmWKClKFKLZJZ
         YUpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jJFUuHCkiuowxKGXg+Febj6rEK64+GzygHvKm31JAxo=;
        fh=t1yaCuzuauBaIo+SEKaT6gDF7PKK0fG2dlX0q2mf+Fc=;
        b=FTWUCHbrPM3N9zylwGHTDTwM3YVG88gW8XVMRrB/kNhXnpF19011LDNM22DPkS8Qja
         aYC831uihVhS3T9TPmJExeyKIkotQkQfyJ6/5SJX2iUts1Qi3FPX93UxDezZ447k2FcX
         TlBwiY8gJURE+FeLU81uuKP1syom30lAjU7xDZJ+FophdSp73uuWulFrZ0rrHIf4acZ5
         MiLVcR0fFEiKlMsLqtovarRTCosZx8lBt+NAf60h7/xwgFhKaODgOR6Jh7ToMKUyCpEk
         ftJ+8EHerVxOfPjoEqya7Qml4gNyLmDipX3K39q/JB9TQo58gvN0wLeNbJcRhU7k7gbL
         giQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776341798; x=1776946598; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJFUuHCkiuowxKGXg+Febj6rEK64+GzygHvKm31JAxo=;
        b=TFWUlXeiyEhTEh1cpi0RdSJHcl+KhmN+9WJQIbsw9RYPfW8ghI0s+rFavHa+6+4Un0
         vSaYmoarHqbNevUiDTU7wxiDGpLhUx6kl0vsUJbQ8fUKii/c6Qc4GIX3wG+92SDz14j9
         o2/jVcP1VkFOhATJU4LVG6zJ9JkS3wFcmS1ZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776341798; x=1776946598;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJFUuHCkiuowxKGXg+Febj6rEK64+GzygHvKm31JAxo=;
        b=U1/oSqXrAxXv8dwJekX+ka/MqftMTU2QaHBzwo6w18hW8WZDhFlk1TvFf3h1MVeq7K
         hYuw+KOb4Q3F2AQwOa1/fCkiLLNIdPPpkHR4uFllHRL93O0DVw5yLhQ7RuaVGHQqUCz8
         5TBZPJw3stF1O0kqoTfmLkav7pxJXbCTFgUtuWorQzTwx9b7f6xMKa/hYusd93MLubBM
         Y1ToBTitho8+ECCfEzVuMomH8rmxqyVkM1EXpbORd9+n0jSYCJZSgwgXwwwwm4I01j5S
         xH42R2aTf2KFnesxsIplf6OiLOsHfvb/RSNqWIgSGSxlw7Ie8dH5bowsN2C+8YLBVRP8
         2LdQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ih6WvVt+9zudkD4VsWGmfu3c94xOlohzVeJR0lLaKha3W3YPW3EN9L79sU2OTRO12QGcPzBO0qQ27LfAh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5v+SqPmygaVTX7SW1rvWfRqXsvJscCTSuIrpc1WkzoZ/r3D/r
	ErQJPrgSsO5XeaFPRYB6KcNcVSy0uJWUqYRVo6Yb27HZbRYqDBllzfbDIOMygrPIKOZ4qxJXwy5
	y+vBZWZW4ArREH/xYvjoXzA7BKs2JuNdsUikDVk7toA==
X-Gm-Gg: AeBDieuShDQes5RQUjKimPxqeH/4P0wsG8mhW4qYlRjt2eltQhJ3cIEg5j2OXudTT4h
	Ta3dbbND1EBm5tEJaqnYOX2ngHpK4rQAu5GUItl/FoP9KPUEZFevC75ID0/jA1TqRQFICUjw15s
	ih34KeRmQt9wEZk32YM53DPVKAbyprhtwQnmyzjazQGb4F8VhR+qknUqipWzkKc94KfxGyBvAYI
	HmGQWC0tYVRSjjXz+U4BkuMq/nbDm2zDncLy42zrpUrnuj51s/JNbHIjR/6CtQ7gbvEPnCpzy2T
	SjzFO0Cp6UW/62nHWs0oIVYeBWxMylZMloLi
X-Received: by 2002:a05:6102:800b:b0:602:aac7:b8bc with SMTP id
 ada2fe7eead31-60a0168810bmr11857886137.30.1776341797905; Thu, 16 Apr 2026
 05:16:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ee4992b1-06ce-40f9-b554-bfcadd45cf97@I-love.SAKURA.ne.jp>
 <CAJfpegs+8pcuQFBNB_0TfDh2Fo3_13pcpVNNzRdR=eZ-tvx35A@mail.gmail.com> <b7edb87d-8734-43ed-93e4-5be72294c3bc@I-love.SAKURA.ne.jp>
In-Reply-To: <b7edb87d-8734-43ed-93e4-5be72294c3bc@I-love.SAKURA.ne.jp>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 16 Apr 2026 14:16:26 +0200
X-Gm-Features: AQROBzDL7ODMvLpBOmhgnqz3i6NKn5sq_bHAZTp72b00m4quFf7MMD94LNS03zM
Message-ID: <CAJfpegvAwKR8Z8B+kp6kW1CDgN2TZYpbdp=kFSUuv6Ga=xY+jA@mail.gmail.com>
Subject: Re: [linux-next] fuse: wrong usage of no_free_ptr() in cuse_channel_open()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 Apr 2026 at 13:50, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2026/04/13 18:49, Miklos Szeredi wrote:
> > On Sun, 12 Apr 2026 at 09:05, Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> syzbot is failing to test linux-next kernels since next-20260403, for
> >> commit 288de43f7c73 ("fuse: change fud->fc to fud->chan") is causing
> >> "cat /dev/cuse" to trigger NULL pointer dereference problem.
> >>
> >> The problem is that fch is NULL as of calling fuse_dev_alloc_install(), for
> >> fuse_conn_init() uses no_free_ptr(fch) instead of plain fch; in other words,
> >> you are calling no_free_ptr() too early.
> >
> > Thanks, fixed.
>
> "cat /dev/cuse" hits WARN_ON(fud->pq.processing) as of
> commit fbe92cef04a4 (HEAD -> for-next, origin/for-next)
> of mszeredi/fuse.git tree. Please check.
>
>   WARNING: fs/fuse/dev.c:482 at fuse_dev_install_with_pq+0x10e/0x120 [fuse], CPU#5: cat/1194

Thanks again, fixed now (hopefully for real).

Miklos
