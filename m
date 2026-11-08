Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794155527;
	b=bnAJ4fxMXHKa1s9nqPv/SrA6YYzZ73CzrD1+txwuMnlHqGek+ecHPLwaxY8f8X4/4veG
	 q1zjVzkBDlOpHdmYnLxDNrNLe/emUAqZJ2GjX8Gm6CmrBi7zAM8rUIFP82Xecxiv/MoIp
	 qBiAY9UlLCI6bdZNHDFACWi7zBizw5Gvga7OuJ0rZ/nIABbIrzUOgeP3INU0SJFcXNjMc
	 H2swWXgSM2zILjoOCqx/va64luMTisFn083QxUqNnb00CRvHS20sy4PE9kdydrIsJXe3g
	 epczmHd6zstMJgoaiLpdO5kfxP7DsLBYcX++ePVL51Msl9GuUyEp2kQ0UVqfrImGsEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794155527;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nRA3uBFq/unnmFefY9OZatsKPIJhx+OZZvSDJnxcK8I=;
	b=Zb5PJcM5kV9kCI6Sowhx1oZCNeImx0lv6OmrwKvLyiMCyyRC2B5NhGzG7b5vV/CgGkj7
	 b5Ca7P4ON6RhAT4GUpPGzNWpebjsKZ7HjRwWnTO4hJ2KeuHK97c5s2Tcco/I2Fy4Rz32+
	 TIYq/iy6hrypqBC6neYbg63WoQuZ02dNAYqQcgx9B3g4LEEysluLJMaba9Zhvud4GfrK+
	 yppAdwLk48/3PtwBXaXBDdin2pqHSVUbmfhqL2EsKOVUl0DjIgN/sacAcFb6U9btijXHK
	 9SAO0Zwhi0jukIddWyXbQmR5rYvknXSySRMuZl8d39NLYz6yoSCNEc3qT/44R4Vzd7w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=omnibond.com;
	spf=pass smtp.mailfrom=omnibond.com;
	dkim=pass header.d=omnibond.com header.i=@omnibond.com header.a=rsa-sha256 header.s=google header.b="CaBSZ8J/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAAC606A320
	for <linux-fsdevel@vger.kernel.org>; Sun,  8 Nov 2026 16:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEAAC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=omnibond.com header.i=@omnibond.com header.a=rsa-sha256 header.s=google header.b=CaBSZ8J/
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc1bc88a20eso82777a12.3
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Nov 2026 08:32:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794155526; cv=none;
        d=google.com; s=arc-20260327;
        b=JXoeZ0Sxg6IaDl8fYO1+5ZpzVlYsQqruPdCPWTqEjoNnIDc07JQ6vanwQZ25YrJovZ
         vIsCX9HquHX/5fmnRqkEv5iS48pjf5rHeAeQWMPSonwHy90GUm7chREuzhuYHc8yYTla
         f2/JGdc/RNp3MA1tCgYZ8WKaxre7AVLjDDxRXfEgi/W+eaQPCd5HDiDVJyugLONIHsM/
         NLFON6oWsI2xdeEkpxwHtY4tc5ALZ1H2purQZ+htx78Bzo/+HY5R1HXhLLW9XO8uWHl8
         OynhU7/tizGfvXTZxhcVi0Jj4xwhmG//oxw0yuQ5hGN2KSjsTxUGVM5QyNPP4qzzLzuR
         Tlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nRA3uBFq/unnmFefY9OZatsKPIJhx+OZZvSDJnxcK8I=;
        fh=SHaY3b81uN7EsjF5pDVrj2xAqfBEYz5kFtX19S4T4ew=;
        b=naTL7Lu5whLqw8fZkujf/pgP/ZjYy3WYQqU7dqlycBTGdSzAI7+m/mqWUVvOTzXeAk
         7LB5N+5/Tx0yIr5V0FdcFKbYIg3pLTjf6obzgPicSIo7Pn454REXN9Sm3C7Ur9nzQJ5r
         Y0hwu2XPolbwrMj60ltuW1Bnel7Bj7IdvjPGJ4cEQAyVYjhQrpotPP3XmLc9AGdXbT4y
         T1UUyrTG8vZti32TCu8Ip9VmLQv6cWNScUuaBxHN6s8Y2SlhyqrjDf4WgmLOofytSkhQ
         MU+P6zhLT8cAyZzqvtNP28riV3uHEWgw6tVpQtcEtkqw9+BviEbJ6nrj+07XadTEjbzA
         GlRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond.com; s=google; t=1794155526; x=1794760326; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nRA3uBFq/unnmFefY9OZatsKPIJhx+OZZvSDJnxcK8I=;
        b=CaBSZ8J/go7wNJ3SZ2z3CPOXIlMd3pXwhYegM4lzKGJ1K75rarqHhQliFeTcAdjcuj
         o8NdwsygVqa0pjIuPLeQOlsCuCz1fp5+wuVT54Fr7H1vrB1aTAcEnE7ds5XC4qdbsW2t
         WieaCOLluJlfD2zUBiKlqPYIvrtEgy+/hTcxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794155526; x=1794760326;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nRA3uBFq/unnmFefY9OZatsKPIJhx+OZZvSDJnxcK8I=;
        b=13ubQsQV1T+qu0CqKzpLwmQDCIlNVjnS0tv7hl6qFmCFYNvI9SC7H5Bt+jYiVOQG1R
         zhbQ9DEE3skSLNDmqTmAX7gbv1WmXQCJX2grBEU1yL3W0XDS/HRPLjHvZDFOnV3dWN3E
         f9+/0kpeb17bD+eM6pQoQKJCyQa09kggtnz6vEKQjH4jNiOJQH+i6k109x7znUjcyXD4
         rcC/sIxExgNXUa2suFSd/MaR/HimS2eabuQ5tsHIuXVoTmOKz5xDvkF2SRZikyyUg3l0
         n5sgQfwMtvmcA4DKM0JBnpyPg31yU4q5keKvbrr5hmFxn8H4NuEznxs3+r1XtTxmz+ya
         mKLQ==
X-Forwarded-Encrypted: i=1; AL+hErFn5W2qIluBzxM9+Ez0Aa1dz7LD5eo7eDmKt7ePM4jSIk77Fs1N9audMg2Hq5QV83paY1+O6JU0yt9NbZbX@vger.kernel.org
X-Gm-Message-State: APuU4Z+jumB99q6xlxbDfqInOsgJrEetoFz8PaBUrBwiPLNjszFU6ABS
	lp4mw7MJms8X8aLP2A6Bu7reSs18boEo+6tXekKD+51IhjzClqtV4yLKnz7NKdrkOUKrHPHVhFv
	E7Xlb/pGn9cw6YteFM6RHlw0hJS7aZwQae8yJ6H1w
X-Gm-Gg: AYBFou37CMIM6E3U4Y+zuwY3vsdh4lvC8UrRz+AQWi5O+AQQXBGnVFWAgVT7UtHs43U
	KiIrB3LCpjNykUmYCh0fRinYyqxYNaqpAqotTDtUWi0Iuuz2sIIlGK3Pl0+0FXuEdMyFA/LUwq6
	v4WBdd7jo8eeDmoiJlGcFkOxXEP6MIi4548eegrpnwK8daeHhxcRPq81Ptt0K9ZSzLTVa1X9XT9
	d5aUCmwKr+V10Xk3o8t+5GCO7Zb4sGVh8yMIAtJeOj/0/WLeWgO4/DQ70q5hPzDGXMO+JXRmO9H
	h8ZpUo20+U2UY1ihg+kd9J1KLrMBTrIkVrfjbcSeTApmyj3hWxFBbzNNKi2wF/NBM4XXa0mgGvD
	Kj6uBddsNjZW8wGkzrtFM89yuCzKzCFRMLG90n7uEwurvum+2
X-Received: by 2002:a17:90b:54c4:b0:3ab:36c4:b500 with SMTP id
 98e67ed59e1d1-3b12d108881mr1704045a91.5.1794155526074; Sun, 08 Nov 2026
 08:32:06 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <tencent_5D9DCBD693C37FAA4FBCA042AB2FCF222207@qq.com>
In-Reply-To: <tencent_5D9DCBD693C37FAA4FBCA042AB2FCF222207@qq.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Sun, 8 Nov 2026 11:31:55 -0500
X-Gm-Features: AclHuK_X-4AOoWa9U2JXIk1B5q8F8ohCWp8rOY8hKOQGXDZ07iazbVSsef87fOo
Message-ID: <CAOg9mSTSnkVmt92ehkDDD5SNO4O8==gnxnmte421N6AQEALt7Q@mail.gmail.com>
Subject: Re: [PATCH] orangefs: bound op_timeout_secs and slot_timeout_secs
To: Yingjie Wang <1075151112@qq.com>
Cc: linux-kernel@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Your patch looks good and runs through xfstests fine.
I've added it to the stuff I intend to put on my linux
next... Thanks...

-Mike

On Tue, Nov 3, 2026 at 9:40=E2=80=AFAM Yingjie Wang <1075151112@qq.com> wro=
te:
>
> service_operation() and wait_for_free() multiply op_timeout_secs and
> slot_timeout_secs by HZ as int and pass the result to
> schedule_timeout(). orangefs_init() only replaces negative module
> parameters with 0, and the /sys/fs/orangefs attributes store any int.
> Negative values are not valid timeouts, and values above INT_MAX / HZ
> overflow the signed multiplication. The result can be negative, zero,
> or much shorter than configured. Negative results make
> schedule_timeout() print "wrong timeout value" with a stack dump and
> return at once; all of these cases can make the operation fail with
> -ETIMEDOUT before the configured interval.
>
> Reject values outside 0..INT_MAX / HZ when the attributes are written,
> and clamp the module parameters to that range at load time, as negative
> values already were.
>
> Fixes: 274dcf55bd4a ("Orangefs: kernel client part 3")
> Signed-off-by: Yingjie Wang <1075151112@qq.com>
> ---
>
> Notes:
>     Tested on x86-64 (HZ=3D1000) in QEMU with the orangefs module and no
>     client daemon, so a pvfs2 mount waits in service_operation(). On the
>     base kernel, op_timeout_secs values of 2147484, 2147483647 and -1 wer=
e
>     accepted, and the mount failed with ETIMEDOUT after 14-29 ms with the
>     schedule_timeout() warning; loading the module with 2147484 did the
>     same. With the patch those writes fail with EINVAL and keep the old
>     value, the module parameter is clamped to 2147483, and the mount wait=
s
>     (stopped by a 3 s userspace timeout). 1 and 2147483 behaved the same =
on
>     both kernels. slot_timeout_secs was checked through store and readbac=
k
>     only; its wait needs a running client. Also built for i386 with W=3D1=
.
>
>  fs/orangefs/orangefs-mod.c   |  8 +++-----
>  fs/orangefs/orangefs-sysfs.c | 19 +++++++++++++++++--
>  2 files changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/fs/orangefs/orangefs-mod.c b/fs/orangefs/orangefs-mod.c
> index f591f09531da..7a62d4987175 100644
> --- a/fs/orangefs/orangefs-mod.c
> +++ b/fs/orangefs/orangefs-mod.c
> @@ -83,11 +83,9 @@ static int __init orangefs_init(void)
>         int ret;
>         __u32 i =3D 0;
>
> -       if (op_timeout_secs < 0)
> -               op_timeout_secs =3D 0;
> -
> -       if (slot_timeout_secs < 0)
> -               slot_timeout_secs =3D 0;
> +       /* The timeouts are multiplied by HZ as int. */
> +       op_timeout_secs =3D clamp(op_timeout_secs, 0, INT_MAX / HZ);
> +       slot_timeout_secs =3D clamp(slot_timeout_secs, 0, INT_MAX / HZ);
>
>         /* initialize global book keeping data structures */
>         ret =3D op_cache_initialize();
> diff --git a/fs/orangefs/orangefs-sysfs.c b/fs/orangefs/orangefs-sysfs.c
> index a02bfc7b3542..1873a4f5cd16 100644
> --- a/fs/orangefs/orangefs-sysfs.c
> +++ b/fs/orangefs/orangefs-sysfs.c
> @@ -270,6 +270,21 @@ static ssize_t sysfs_int_show(struct kobject *kobj,
>         return rc;
>  }
>
> +/* The timeouts are multiplied by HZ as int. */
> +static int sysfs_timeout_secs_store(const char *buf, int *timeout_secs)
> +{
> +       int val;
> +       int rc;
> +
> +       rc =3D kstrtoint(buf, 0, &val);
> +       if (rc)
> +               return rc;
> +       if (val < 0 || val > INT_MAX / HZ)
> +               return -EINVAL;
> +       *timeout_secs =3D val;
> +       return 0;
> +}
> +
>  static ssize_t sysfs_int_store(struct kobject *kobj,
>      struct orangefs_attribute *attr, const char *buf, size_t count)
>  {
> @@ -280,10 +295,10 @@ static ssize_t sysfs_int_store(struct kobject *kobj=
,
>                      attr->attr.name, buf);
>
>         if (!strcmp(attr->attr.name, "op_timeout_secs")) {
> -               rc =3D kstrtoint(buf, 0, &op_timeout_secs);
> +               rc =3D sysfs_timeout_secs_store(buf, &op_timeout_secs);
>                 goto out;
>         } else if (!strcmp(attr->attr.name, "slot_timeout_secs")) {
> -               rc =3D kstrtoint(buf, 0, &slot_timeout_secs);
> +               rc =3D sysfs_timeout_secs_store(buf, &slot_timeout_secs);
>                 goto out;
>         } else if (!strcmp(attr->attr.name, "cache_timeout_msecs")) {
>                 rc =3D kstrtoint(buf, 0, &orangefs_cache_timeout_msecs);
>
> base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
> --
> 2.43.0
>
