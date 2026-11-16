Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825230;
	b=rgar5GO9YZElrkNqJWphzp+c+CTMAj+y5RB7NLb8KeulIJjQRe/9dASpPNTqkv+wRd31
	 lTyg1XboSikKrXzycRuzF9YIXgtM9YF9IpQ+FJtOlylaBez4BZJoC3lmGbpdv05nbr2rV
	 4y1PIxjp5rhGU96P0PP44bpgoMQxg7H56RJJ6J/S+9pGnr3G7azjTlmpqIO+2aJ6DOUnb
	 xnrLJ7xEXWPxEAvIwcQC0wvehPPEDSJXyBTe9Hswt4PxtYBofJT4YvfjM2wojQKq6JW/D
	 Aivmj6vF8/zTtY1I+WJKUznDmvdIJLzThaU26b9AW3ruu6W2a3uzIQGNwKyvjf5WzOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
	b=dm9hcqwhFeL5v/pGAcnqp2etXVuOtTnfwsTse8aou//uviwSAePYJ0xW1XYGDRRWoavl
	 WayZTo17UKJMEoCQrBX24blTAqeKusPoM6OLDove6tKUQWwH1l0Jgqk/GXSkuBZy3uk06
	 N27r5Wmkixw4jcxV25XejitEt9PWFd3zlX5G0FLfKyVy06/dUnPTMBUihvzskMEi1FOhw
	 bfM3SJoCPhO7s5Lq+0xr8hGZoos/DX7sadkRuet1YEJ60BFMcV9FbI1/ggigzEU7iKToB
	 jwxM7fyHzgKsewO/s/88k6mutVbPfo3t/I+f87311yImW47+I/mdYkMxM/kv4ux70rw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMA7Ex2A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1FD606A32A
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 10:33:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1FD606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cMA7Ex2A
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b56bbf8330so4211495a12.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 02:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794825228; cv=none;
        d=google.com; s=arc-20260327;
        b=Ma1rzCkQtfh1uT747M8mb9kmTyWeN/h7Y4e7dOVsVQNHeBhlmIqfDcZVTTRRYDygRO
         PlTKwuXZXsl1jLjlk7wA1h/CNaw43payflruPetCbO4sBEQpjjbhV5kmfi7/iOykTabn
         vkuanpRgpxnyj+qFhP/vGYAw/r/HUyIJj5WlpBMCLQwrUWEZdKKC0HUemBNmkM0IVeco
         T8lI/QlG5OjlDM0KZaK2k/gpmXGEGpRBtRR2apyFjD/+wHRPzey/VC8DMcDm9rmzlxgl
         0YKPEUzX9qYUALPnLl1qd/IDuopjPClMGOHr6cuFhDZW1fbPitNdvFEofVBbSDpwbuYO
         DW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        fh=Oy8c1Y65/oIVsA268tG+fvSVq/3sbL2OX235xzS1xUM=;
        b=Gr2+Za7oBEXiacIScQLxKd2nHVY126cvrDOp2TtqGrAISZhRfBCqrGlxDnhh6VS58D
         2zUUBsr1O9S+a83XhKqoy8Q9zD04d5Bx6uDqrKkoFkDhoUFV/pKu9AYB6xHtq5ucRcE7
         PjhL1QJ6x+OvjqNqG8GdFWg3cVO9t33uKne1+EU+KPGVwg24rSWMbC61qNH+r99pkWt/
         kRbuh297p6xRWids+hvs54IF9bXOFaSvDvxMnPSJnpg1z67ieESp9uI9EvQSdwDxa1mc
         wN4+fxM+pEK1uHyWYXboXXyWHOqpI6Mox2biUGn8TNR3kGcuqEsFa+BVftH0LXC1UxMS
         TPtQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825228; x=1795430028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        b=cMA7Ex2A6a8giwsic57JQmQVBX4z19O1dwTosopkucFyXilbY7y4KQvBgOiVlUfQHV
         HhAjKnQP4IMUT/2RcGEYQBbPdsrbJdKU7BxmvDzSFaQwhUskc5hS0PDmx1g/X6+As05o
         vBd0pxF0KsB6gB8C+ujKBTAPYJQPLmSf+FNlku+Fk+liGCRRjB6FtAr8GiqsV8qilknA
         4otgmDh0sj2x+FLoPTxCPf09e+9/mAFOVzJuMeIZKZyVKGLFzy7WnmxFpwsKwACWKYjq
         u/mzVKhZpQMIjHbuhHuLVWetNaA9FSK4x0zkK1a2lA64X50eyJSpw2S+gM4Z3AshUNqu
         TiOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825228; x=1795430028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BcX26cyIolLDGV7RzmSSpE6fHAk7h/NEUs+iaS9LpDg=;
        b=dUs3Z3bX9i5z4J9ZU4ogzuHbJpRuPx37FZRgIYY3fHPoT0YbD17e5PXXaTKM8KmJuj
         7l/9IEnI4V8rZYCQTm1JoR+JAXSh6v+Um3NLsCfV8YS+m+jM1aRlCF9j5EpqfVZkGPz6
         bgkkL6FftVsq9xnKGptUzmwQXDWF7q1Bpvb20a9zMAwVwhKFcd2hZjQaBjSrugNec1wC
         O2Hw9cKgLfoc4Ov7IchI07+5TfPkEUtFvuMMORrudXacDgRjbMJQq1Bwlf+v2NhhzXcW
         1/LXhyoM/EquyNR6J4igamqP3tzEhryipS9cuLUZGXZJf7mTa0I8Y6ApslHBAkJ02jvG
         /SXg==
X-Forwarded-Encrypted: i=1; AL+hErFMhLO4cjVW2SWyDJ97XQ70BnYeakxTw0lZMWrUl1dswnu6rrsrxjViUGICcsrUe0og8ify8H8f9x/5JASe@vger.kernel.org
X-Gm-Message-State: APuU4Z8eHeQhzgY3i/kMm6gDDmDrM9eFUSejGBJ5KZPk3LEJ1Tji9BfG
	Qroac8KnJ4n1K1Pi+oDLAPF02/iFbDbkQ6BvGqc+a2LGYtlDROqT7qFur6rxCUiifRzI0/vrftj
	Wryf+T487M9Kji/++sL3mWTgmPPELBzidBOiI
X-Gm-Gg: AYBFou2QfXf5AhjGZNk7iego/eD/QYhn54DV/rGkxJrq2EKFssOgDGtMCKudYqfJYXm
	lKmYC0PkBUJkbNxLWhirszl5aoFvvp0sjp+o6lpowSBAOSbLL2e1xeXSCiMQ7OpWf3Xuo4Cx4C3
	jZ1XFUdAI/X7XMJRZ7y/ZgQ+i2NgHOnorpcSVgnqhcX7Z6tiwSU0YfhRTGG5fxIShdjeov+1/1l
	F77uDu0LAWIiXhkFlQlLOQZbIhRsNHOhsa4bWdqcvdnF7W7+DeUr1drT8mPGD8f5zbHavqbJefQ
	z/aN+pJZFd4AoPFzNqeT6v/LgNh12MTk3ZnWId82uHkqIx5IcIfQtTr4QtOwjY70LibBiYA4hRC
	ifCkz7m4WEIWtYbbHHcfKjvUX3BWk57vSV2M3FPe4HZ1J323FVeAkQrY7ksvXqvffB5x0ow==
X-Received: by 2002:a05:6402:44d2:b0:6b4:59d0:7294 with SMTP id
 4fb4d7f45d1cf-6b7c0c7fc57mr6737947a12.31.1794825227756; Mon, 16 Nov 2026
 02:33:47 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-4-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-4-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:33:36 +0100
X-Gm-Features: AclHuK-NMHGmo8BvWWPeGRhVs7Os08I_QBobJYDFHOlrsGgrh13rxr7aQnEhSTs
Message-ID: <CAOQ4uxibz=iM4Xg6qmRmqKB25w=Z9AaaqnMqc-L2d27G632hyw@mail.gmail.com>
Subject: Re: [PATCH 3/3] fanotify: zero-pad copied event names after an
 embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> fanotify_alloc_name_event() sizes the variable-length event buffer from
> the qstr lengths and allocates it via kvmalloc() without zeroing.
> fanotify_info_copy_name() and fanotify_info_copy_name2() record
> name->len in info->name_len and info->name2_len, but copy the strings
> with strscpy().
>
> If a qstr contains an embedded NUL byte, strscpy() stops at the first
> NUL and leaves the trailing bytes of the allocated name buffer
> uninitialized. copy_fid_info_to_user() then copies name_len + 1 bytes
> to userspace, leaking uninitialized kernel heap memory.
>
> This mismatch dates back to
> commit 929943b38daf ("fanotify: add support for FAN_REPORT_NAME") and
> remained after commit 0fdbe845534f
> ("fanotify: replace deprecated strcpy in fanotify_info_copy_{name,name2}"=
).
>
> Switch both helpers to strscpy_pad() so any trailing bytes up to the
> recorded length are zeroed.
>
> Fixes: 929943b38daf ("fanotify: add support for FAN_REPORT_NAME")
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
> Note: default FUSE mounts report a zero fsid (-ENODEV on fanotify_mark()
> with FAN_REPORT_DFID_NAME), so this patch was runtime-tested on tmpfs
> with FAN_REPORT_DFID_NAME create and FAN_RENAME events.
>
>  fs/notify/fanotify/fanotify.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.=
h
> index c25cf5c1fc70..4a1f14aa4974 100644
> --- a/fs/notify/fanotify/fanotify.h
> +++ b/fs/notify/fanotify/fanotify.h
> @@ -225,14 +225,14 @@ static inline void fanotify_info_copy_name(struct f=
anotify_info *info,
>                 return;
>
>         info->name_len =3D name->len;
> -       strscpy(fanotify_info_name(info), name->name, name->len + 1);
> +       strscpy_pad(fanotify_info_name(info), name->name, name->len + 1);
>  }
>
>  static inline void fanotify_info_copy_name2(struct fanotify_info *info,
>                                             const struct qstr *name)
>  {
>         info->name2_len =3D name->len;
> -       strscpy(fanotify_info_name2(info), name->name, name->len + 1);
> +       strscpy_pad(fanotify_info_name2(info), name->name, name->len + 1)=
;
>  }

Same as for inotify patch I prefer that we are consistent with d_path(), fo=
r
example by using memcpy().

Thanks,
Amir.
