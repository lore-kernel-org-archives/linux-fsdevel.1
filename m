Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264341FE451
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776879734; cv=pass; b=BpykZ0Bs6Rikry4C1Fu1gd6nHlUU2Ps9HNZrOcM16AmRx+ktMyFOmqqNYR+dRmpEpebWCQoFF+y44qcEkG/d+E0YrNbSlog8bWPOYkNDTOE2JdLDv9XBvEfq3Gq2aDMCtv7fVmfkbRscI3MOhhiNB92vEbReaVa6fE2XKs/EHQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776879734; c=relaxed/simple;
	bh=E/5OVf6CYd7C0diddK4eaTcPn/2dxJJ8s0tev7xwPN4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2/sbTEhSc9R063i5dDQEV5IA6WLjtZLKC+21OOqZxtesWBelKZhzRjHGG8tjxAc3PY29DQ1PfMkOHl4o8HxA4fRW6LiJBIMr1UtIvnWOm6ipcmFUrVuxXKOwdNmTK5CYk0LIMWdzXPEsHFbmWmk9dNFlrRtTg5ULY82gZSHDCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NkUqBp3Q; arc=pass smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NkUqBp3Q"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43cfbd17589so4609638f8f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776879731; cv=none;
        d=google.com; s=arc-20240605;
        b=VdqH+Ze9/YzCgu2LEMK2XYYYS5GWruPlRW679bcosZbLzKL3cFNg+BHhNOyKs+vMAz
         BX4HkyK8csRSuP3RIIQ56JPUdjN3GkhDfbkX+oZO4Xeq/ulA63uz3mjGv7NCJy7MQFAg
         sFhLjYcS0OE8JmTcs9an0hjvxSdU9YEigo8YKrXWPhRLUm/V8/o1a2O3ZmvGIX/xh6yC
         inBorHAWMwSB3pgDCxIGkMzYB10QIlP2JQxfrrZRkxq+jfpCjVbu0W0Oo70QPAUV/Zll
         btLDPnO/oq7C4leo8Zte8Qf0R+Xx3EMX+fbwvqGZmUG+9bKVG/zoq5Yk4Xhait6jLYCn
         rd7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YnAElFZSvFS0lpWJk+Qp0bYs8sReeczhgp1hEEKcl2A=;
        fh=Vu0MHgEsmvhNk5q7IKOXWa08xC6lFca68mKktDcyD/s=;
        b=ayIM5XwodrdPanJxVhs2SR3MX8MWNmkIURdnyQ3FZQApodknU+L4HN6tBgKFLSVMxj
         yHbyhMzSuJzfJQJO7o/vqBqEsxpv+1B/N8XCtm4EKprtw+6CH3PNUKj40Xmr/CgEoTrL
         8K4ztHEDSv1u5IjRSfStmS1XBoiBQ9YMq8wlqypoXJkwiPoW7Q7x9gyd9XsXI3FfItyQ
         GZ1uzhaVpzWdXoh9dtfO4jKaV5ubueBOBT/Q0jFffz0wSUq6MrTx6QOEu7lpONqXLd/u
         i1EkYE1ZelmbCwcy57pHdAkNC0UDA5I2VJl3et3H3MR3RZGXtppF4mynAl6wwb/+Xbf7
         P+0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776879731; x=1777484531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YnAElFZSvFS0lpWJk+Qp0bYs8sReeczhgp1hEEKcl2A=;
        b=NkUqBp3QvcRt559Ma1fw18VKE+MmRBM6PpR4o1jr56a2mQCzEANQWKdqYiY2YRALJL
         6FwCUHdMV4pSr1l+I8WC1lFWr/8ASTqjz62KBDL6AV9BfPrIYauVKQaw15RqrZzBpIvm
         gWTyN8Z4EtCjZyIUUbLD5RB0WOW+H1Jtbfi3YcyhH9k+iJ186zITB61Xqz+K6jKsgdd7
         24bbpA32pk0EeAZ7nENZdZAFk5P1Us9lVSKu1p3KhZW7Hl4YqlPnDNhcnPJLBcpAFvKK
         9hPbsRFYc63N+xhzWpO4wuCaX7jxhYhm95VtL462nQGaZlt90a57N4biE/3vvz2i9BDh
         nA2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776879731; x=1777484531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YnAElFZSvFS0lpWJk+Qp0bYs8sReeczhgp1hEEKcl2A=;
        b=KfYQO4nPUTFAUWCfug/Ii7DIc8LAv0RQdMKLdkyky1kNe/8L0qmmS+mylLSahjs39D
         wgXEZ13fR1K6l9SlefBPgTrDaaUtCax1ItPDbCMlwy6JSCG2HGTG10VDYkNlKjiZ+00a
         9OpIzOj3yyLarxVeVmgSenBWeMDv6KcyGxHlJmLgQbArv6Q6PCPsNQaOf05glz/GYbTk
         jgK/4zyoSfqtAO9G+YygIxIMQyswPvbzlQe4XvWee9RAB09D9hN8NCZW2xddCtZOK4GU
         aEfOAlykN7IW5xpNhVl08MIcCYDx6rLSm76m6qmH6CSVWCY34Cu589x0Z9XhRYkz7u2k
         r+gQ==
X-Forwarded-Encrypted: i=1; AFNElJ8TkPX6p0eKSQL1iqA+5etC99zpeb+pj7MJuJX9uhN81G7e/0E8LDNdLxZHXP4QXHGRtqV+/4GPCk7ydA+L@vger.kernel.org
X-Gm-Message-State: AOJu0YwLAlWBwakF7CGy0FfFzvF926LQe65imA3LuVLxCkSGnIOgHbSR
	AQzb/tLPfA5Vh/ECRaxGb+5pwGOm48Hdh/N6alHl34zVJ5zltBiwE1AgPlhzJwMGDjm16VsGVHq
	Y7DU+MMjy+xxmMRjts4+/00H8zMDaw4sLzpLj
X-Gm-Gg: AeBDietuEJkY0ZXPi79lCzV2wnstZtKewl9LeDVUYOGEEhUXs+40QsDcFBL2DFsDGru
	5ES5ZLFrnbj7orTAGF7S/5aEdBAjMR21EfH7HZVeiUvQSLvuRCbfh+1hIohyQCIYlMuXrnaWo3Z
	Fo1IqZQQNeSeBX+BTrPlc/clvA06t2Xj5HSFxP6BCTcKaeirULXsFRusYaRl81HnpzpsjSsOyrJ
	59cyjnnTdTTaFpnToCIn0manoP8wsTp7P5vEu4sUnSh7OOPJiUJPcpPD5UsTIrnFXq1LEbC+ddX
	z0Np+CtLT6qjjS7e
X-Received: by 2002:a05:6000:1788:b0:43d:75ec:26e7 with SMTP id
 ffacd0b85a97d-43fe3dfd2dcmr35633344f8f.33.1776879731456; Wed, 22 Apr 2026
 10:42:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416091658.462783-1-mszeredi@redhat.com> <20260416091658.462783-28-mszeredi@redhat.com>
In-Reply-To: <20260416091658.462783-28-mszeredi@redhat.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 22 Apr 2026 10:41:59 -0700
X-Gm-Features: AQROBzCmfe7FnTa_i3v-12VkmGupx1sZeI43tD3bTH5E5hGElw0S9Q0-Gm7fOe4
Message-ID: <CAJnrk1YGJY3EwQi3DoRwYxpGA3y7EUh8KczV0XsDA8KcU7S4tg@mail.gmail.com>
Subject: Re: [PATCH 27/32] fuse: set params in fuse_chan_set_initialized()
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fuse-devel@lists.linux.dev, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 2:20=E2=80=AFAM Miklos Szeredi <mszeredi@redhat.com=
> wrote:
>
> Set minor, max_write and max_pages in the fuse_chan.  These match the sam=
e
> fields in fuse_conn but are needed in both layers.
>
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  fs/fuse/dev.c        | 30 ++++++++++++++++++------------
>  fs/fuse/dev.h        |  8 +++++++-
>  fs/fuse/dev_uring.c  |  4 ++--
>  fs/fuse/fuse_dev_i.h |  9 +++++++++
>  fs/fuse/inode.c      | 10 ++++++++--
>  5 files changed, 44 insertions(+), 17 deletions(-)
>
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index fe415454de0f..c59cbfd3ffee 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -71,11 +71,17 @@ static void __fuse_put_request(struct fuse_req *req)
>         refcount_dec(&req->count);
>  }
>
> -void fuse_chan_set_initialized(struct fuse_chan *fch)
> +void fuse_chan_set_initialized(struct fuse_chan *fch, struct fuse_chan_p=
aram *param)
>  {
>         /* Make sure stores before this are seen on another CPU */
>         smp_wmb();
>         fch->initialized =3D 1;
> +       if (param) {
> +               fch->minor =3D param->minor;
> +               fch->max_write =3D param->max_write;
> +               fch->max_pages =3D param->max_pages;
> +       }

I don't think this actually matters in practice, but should this be
moved to before the fch->initialized =3D 1, ideally before the smp_wmb()
write barrier?

Thanks,
Joanne

> +
>         wake_up_all(&fch->blocked_waitq);
>  }
>
