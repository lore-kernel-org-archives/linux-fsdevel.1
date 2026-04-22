Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0493C0626
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848700; cv=pass; b=e/7X7kahP3g0gC+h/XpbNSAvuaO2Vt3VoECnfGRssiyHYWi/yrbDJcTEThzDIPEI9/aEDCNg4k989bfT5Mt7uRjTpaMW/qdtC7rJmPWJeAlqApwaXW9uYqVogQra8nSK9AWsmiES/4q43Y9gfsKImhWehx4xW22rhS3ese10UQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848700; c=relaxed/simple;
	bh=yopdmqBE9rGg8lfe4NNn7CFqmGFhMk+gNA3NGrMi2iM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPkBzkKSGXxxLH0AFXXWLOyr6+4mHgrtYKSH3VPtbReDQ5G/d0ixGFG6TGlpJ02T2FyZgN1vtjJm7eHdVmSQ1o4TPrH9VFiuUL78iv/iORz2CTHNQjIkeu0323L/pyJKptkw/I9jWT6YAjcp8lq1/szmkhlFLusDXTflG59jxh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gW8fnxxh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ge0MTibS; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW8fnxxh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ge0MTibS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776848698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mb+dSk03jWD+Ger/ZHg5m1EM3AaS+gaxlt98VLk9/sE=;
	b=gW8fnxxhox5eGomK2rV+xZMcrhL/9GH81B6pPwz2LHi8pTxwYm5NEexGoCHp5U7zzLOXsj
	b3Fs0Gz2zusHd2mqAmUbLy1dVnIRRFL3/JrygQngA7VAbery7QNgPxONbLX8wIiIJOLmGn
	VHhYPeRX9v+YUFbCzTM8ASpQCjh8BVk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DmYcDTnYPYGQQjExVzTSbw-1; Wed, 22 Apr 2026 05:04:56 -0400
X-MC-Unique: DmYcDTnYPYGQQjExVzTSbw-1
X-Mimecast-MFC-AGG-ID: DmYcDTnYPYGQQjExVzTSbw_1776848696
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7982c466ee1so115409617b3.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 02:04:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776848696; cv=none;
        d=google.com; s=arc-20240605;
        b=JOI04zVb4rLvM6yCiW3i6JwmAdbaGC+Aix82Z9l+hk/2aDI+lTrgum57ICGV8NHno8
         /s23hIJD/uacv1TIS8Bcw2Z+ue6x3qTLleIvzAHCBO9koAN2GvjkN861gachBqVxel6N
         u/0nKpNAKVTa7quEuY00ufyovz1yv7n2yfNYRbnv4A+9fh0WF+X8F+DXpksqteUx9yFp
         NJMGz7QOHa7RC3JOyfLeBzdjb0paFisDIu67r3m69vkY9MKayfUpxJUa1L5p0NsL9QHT
         fJzbA+SJzlOpkD1z+r+5YB4vBqDlQ1xMROETQDauy5HglY7ugGJyKji0DHh/FcMMVLww
         8D/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mb+dSk03jWD+Ger/ZHg5m1EM3AaS+gaxlt98VLk9/sE=;
        fh=GhmYlox/NR6YwjGOhj380Jd+K36XxUy+zsAviJR1MNc=;
        b=BzNgWAGxB4t4LHLUwiMJgPyQlvEaNAO/KA9EpXyaQQQZYJDbILbxLiEESscQbdMkcn
         HexFNqcWssGyGUcLySZ5czkrty4NfYp7OPNXI9YMwsQ84mQjADB7je/U9wX2PwxamP0F
         pJbYM8py662EVNb6+tCwzJbhTgG7oldCXCSpZR/Qq9ljiBDSx0mOFKj5cHxyBd9t1XiD
         umBrV/cK1dVELzK1je1gqlI901B/VOP62v7lBm83Bj2ybW/39ItITHfaEWzeEs6hVM2b
         wUj/llCCwa2PkHnGYEUMe33Vo/9FnMVG4wm343aJNaKoycNtC37ms0144venWinja4Aq
         IC7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776848696; x=1777453496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mb+dSk03jWD+Ger/ZHg5m1EM3AaS+gaxlt98VLk9/sE=;
        b=Ge0MTibSOLmEOFo3o+gPT7UwZ5m+Q2rCJZRnaAEZNLXa3BcJoTKC7WM29PYDdISjjt
         SFow+8/K1KHBXklWteMn6jgHQvVQ4RutAdkUtbeEXuGC3St5A9++Im7WsSMwiTUmefTs
         a5Kmaoevwok1JeHY7rCwFs2wXjkbLsjl0E/a8SrozsSztPvMMka4pF3r/rVa7n/Fl01W
         xp3pv1cgjG/9uk5UVfB525ejursMtOZRbrT5/tTNxotbMPSQ34o5CZzG6RzuKviOMVFz
         45I+DfDDnyY3uRma9c2FL/pHzc5A0rfgWQDmm7s6cVkP0E45HORONGAbQ64xlksROlFY
         sX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776848696; x=1777453496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mb+dSk03jWD+Ger/ZHg5m1EM3AaS+gaxlt98VLk9/sE=;
        b=M5xI0j/GCwf3nOpzkpie7KU6vWKdZAH0dPabQI1gC7Vp5PXcS++fhwzCtDB3sV6bhR
         sfTQ4hL4i2UrGJFEhAIF0lYIYNn5rD1G1a/Whjl8h1aZ11EmdpTytVtuECSCoJMiDZLM
         uFn5OYyLSt+bXpjbLDS1HTRzLIi5mIdX8RYiS8u7MesbM3R54K5JmFWFoiFflEuGq4iV
         lnSl+ishd/fDjdTC1k6RIApl9Xh9q8b7AIr7qlcIqzPbJelr/OLkzefSXTpjOCe61sfc
         4Uty2e9RqLon6QKALEiV/NAcARDtcoTV1p2X5jf67ywke+QVmVgwTvPjeG8Sv66hWt3D
         np/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9Tbm00Qzn1ggLWAh7gQvSrFRu+hPXyNus8ge8iFFXpYhWonKRs6ZCT0zvyLcCfOf/NJvN/6SJ/zyRv7rK3@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVB48SEqUF+T8p51bMq+hY2lXp8fCkYx+OhtWjSf3rhprGv12
	hstsvwZ7k0OBELWmauICu5hwEv2F9f1seZSjT7Ir1AEbQTdeYmhhGdnal9z7rHstPO4elgtSKkf
	F+lay6bxMJPoRAT4pQ/uX2zPBkZ676Od4U4VHXISjNPxb2bTXoVYFdBa38Mempljvdo+D3U1beX
	PyMrdVwUxGxd2uNSQ9dG6en0AQbJgDKbKgLQ/xet4kuGJsb7lz5A==
X-Gm-Gg: AeBDiesCtZTX4ZmEqC3tvJZfW3/0/gC9UKNcr27yYJLMK5RQGVFt4Ljl3S4pUDte2UR
	2vssS+x8p5J9b+MwhLpy3wt8U5GUT13WSBQU3j+V351ggkzPVyJMy+BG94HVHF7pcjqOPscqC8P
	GSw4hDDnd4FGnRW96vP4dPEdL0zDMgwoZzcpTgYJwoIffQi2DeRzo/FMP9X3LYpyz3gm3+L69vo
	wvzMAE+3npcsUkpiA==
X-Received: by 2002:a05:690c:e572:b0:7b8:4f2c:a5f7 with SMTP id 00721157ae682-7b9ecefdfa8mr169042087b3.19.1776848695953;
        Wed, 22 Apr 2026 02:04:55 -0700 (PDT)
X-Received: by 2002:a05:690c:e572:b0:7b8:4f2c:a5f7 with SMTP id
 00721157ae682-7b9ecefdfa8mr169041797b3.19.1776848695509; Wed, 22 Apr 2026
 02:04:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312194019.3077902-1-mszeredi@redhat.com> <20260312194019.3077902-2-mszeredi@redhat.com>
 <3c9f8396-41f4-4c88-b883-34bede72b427@sirena.org.uk> <e3ad44f0-0a3e-4ef5-ab6e-c346814c0104@sirena.org.uk>
 <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com>
In-Reply-To: <CAJnrk1Y1JzKJ=RCLBt592EZ+0=hPzaLWuHve_umxtUMOSH76dQ@mail.gmail.com>
From: Miklos Szeredi <mszeredi@redhat.com>
Date: Wed, 22 Apr 2026 11:04:44 +0200
X-Gm-Features: AQROBzDQWvCF2XCZrXKaGoo9SXAP94vL7ArHBIjedzp25a7X6i5nZ9ZX1Ji6gaA
Message-ID: <CAOssrKfVKvJeriSm7zeRd8xd6mMgRqc3YkpY6rehBtGSy=JVbA@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] fuse: create fuse_dev on /dev/fuse open instead of mount
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, torvalds@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, Bernd Schubert <bernd@bsbernd.com>, Aishwarya.TCV@arm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 12:49=E2=80=AFAM Joanne Koong <joannelkoong@gmail.c=
om> wrote:

> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 5dda7080f4a9..d48c10db62e3 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1562,9 +1562,15 @@ struct fuse_dev *fuse_get_dev(struct file *file)
>         struct fuse_dev *fud =3D fuse_file_to_fud(file);
>         int err;
>
> -       err =3D wait_event_interruptible(fuse_dev_waitq,
> fuse_dev_fc_get(fud) !=3D NULL);
> -       if (err)
> -               return ERR_PTR(err);
> +       if (!fuse_dev_fc_get(fud)) {
> +               /* only block waiting for mount if sync init was requeste=
d */
> +               if (!fud->sync_init)
> +                       return ERR_PTR(-EPERM);
> +
> +               err =3D wait_event_interruptible(fuse_dev_waitq,
> fuse_dev_fc_get(fud) !=3D NULL);
> +               if (err)
> +                       return ERR_PTR(err);
> +       }
>
>         return fud;
>  }

Ack.   Do you want to send a proper patch?  Or I can just add a header
and your SoB.

Thanks,
Miklos

