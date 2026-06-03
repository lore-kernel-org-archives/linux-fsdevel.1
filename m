Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12120423A7A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Jun 2026 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780475749; cv=pass; b=dKXpatrHdH2OY0PeUdPCct268RU5hufkWX4VAFBQUlZvIoJHMSrlJKszcGBEYGutj9y/l5Mveb2qFEjUjWimTJqZv0CHguuw0TI/gjRR4nLI+WBsWUahQNeG/Y5am64O/+mHhm3wlmFHHEn80AD72Hj5oDWXJO3G5d1GO0tQLro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780475749; c=relaxed/simple;
	bh=F+m5EHKpzyoeMU59zGslD7GYnl1tjf1cNbhiiQSb2Vs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GVJjzoSXCA63+Npjd3laZmNK4bONC1wV+B6OkRoVwaWE2StNMT6ajw1imMSYBNFXbT2IPa6ZN5ikTkseKwXQJISPFja9HsQJIf+se4+QKGdqVVNUUuXc1M9pJZSHvTJzpsZ/I/sNnYlx2HMjVpxE49wBNwl69Y6+WBiedo+ajn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p+da73ck; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p+da73ck"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-91587626a3eso132406985a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Jun 2026 01:35:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780475746; cv=none;
        d=google.com; s=arc-20240605;
        b=Havwq52LnP+qup0hdZiv2UrhAZ/nJPays+CCAIB+c5Sx/znFrOs8s9dHsxz4fNiySA
         Vs0nbCh+2Vwh4Y1kTUGxopisdQ60KZHd1Fm/7fIPuCdg3ahqIrQlrBDzcUQj1+Y/Dh4e
         3GnMQHkEJnTiQw15icYuUXuU5wMYNdcSbdMQr0V3Hng7h4Xt4str2dhpL4vZmJIraSwY
         zJnrSPk9bDKNKWl5mFZFLcpWfPf15/RtAtPGO3riRrTw/DL4F4lmhFrVF2SPWBueggo8
         w4FfyGvOxu9spe1AkXLj4rxBBGCCAOx751PjhxTR9NxLNG6VTFdh7qxl8tDaTmOnqCNx
         2MjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kzfV6mTnz6ECoQk5vDbo+2QOxcAXNy7XpAQeuH7cpGs=;
        fh=crJt3vlPGpunMQdiNPh1oMdjqlvqHwn232XoyGGAhcs=;
        b=O3OJfWLUrtB3GTaotsQAII8K5kfWW8bkxhl3VlNKGzDf/xx/fyNSJv2SphZCI6lGxC
         pAwR14apr+q2aVgtoZubqiWYTC3lbg6YBf1zTdaLwM060r8s6LnkQTXrFmdDMdtsfKq8
         XY/C9fhbz3ib4HScis9z3AzlyVUM/QqqDVak557ZtsPeyrSwleqK90fHUiLEeew638Ep
         tgO4jIXwEsLqwkaGv6Oy5dnBRPrD5rn2YcGR8lQzDzkTNSt9LALwzcuYO1atI7kApysj
         Bc5uIKWjkOj4BY7fSfkJi3ohdQ0Zp0VvY3VXS7KGC4auy4o43ryKYWqJR23Y+Z8WxP80
         lM2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780475746; x=1781080546; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzfV6mTnz6ECoQk5vDbo+2QOxcAXNy7XpAQeuH7cpGs=;
        b=p+da73ckZ4gx2ukhCPFQMy1oUM4D+RYcL6x+0OyFqaaBVFQYHUEkbLhCoAeITyGZ8F
         QwIIlO9Me8TCcuZi0rsZGoN9NcjAWxjbJax3ShJmAH2rI5UfkPrhe2gkQy6U12cUqjAC
         F0dvYpWL4fUhmLFYEkSvD3juW1VlVDSl0ip1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780475746; x=1781080546;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kzfV6mTnz6ECoQk5vDbo+2QOxcAXNy7XpAQeuH7cpGs=;
        b=SKSHQe3K6YnRKXN8jmvLBf45Y4o5JBbcpJx1djXNhg5F+ZtGGlcKX+jdBSIWAqBUee
         ZiKklRrHbtp5G5acxEHhH3zQnF5j5Y31UlLewzVM57BSNKQhpgo/ZfTyQMLm576jqnB4
         syH/CbeP38QK16BTTdm2W367FhU8zEpQr4qkxCZ4agTCYKfXabNWaPTt7IoE2B/d2+8Q
         RAfiAbFJFzBwkb8bUHKFOl7SLFqy6JK1hFly95PR+B1kCozniWLO8Wm+vKvMiH5fLOBo
         BxwkmdTLY0Gr/911gj3bvh8PQx1eBsKmpbnj5ck27OwC6kwOSb7n+lgRpMtmhqYTiM9r
         7/Fg==
X-Forwarded-Encrypted: i=1; AFNElJ+giHFB96VUT36Zx5AkCHRUp7mjYw+myln++w+sJYb02JDt6cUoWTdpQoroI4JdDK7/jleco9k57cahTVGv@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ8Bcl88XkXT16bgJL5htw/vK033Kj62TXiZC8GwpUXn5dKDn7
	Nq/vaMr0Rs7DUs6Kk4dWFPmjRsYH14BcBjfLPm8T7Mw4AeSqRlqq5MTKiNF3Re8GJzwE4Tb0oWC
	HDEz3MeO56Qmrue1P58shNsJ6pttmHaL3hJ2hK7T9aw==
X-Gm-Gg: Acq92OGbGGXFEncLxOq0GWEIdRdM6LS0/T1SaLmXJFx7AEdzZXEI7AL/so1NPud2hER
	6gj/QoMcEYPFWpWORE1A8yzXQYGbkcsWO9xGMy6BT1gMuwKkHByXCQVM6pU4FWAtiCjPvUMQRhH
	8vlOXVnTkgGpvxsjaW492AAdrBB7i3iubmenGzYG6359QdLg3ycvaTJ9UZz6WlBXz6r6M7w/j0u
	hLz54rCVcvIPmmmV/GxpH3qN7aq1UbUvPd3eKRJDHaW08o8oBEMGg6ZljY6NAaoHhDKWLWDg+di
	/PkNnlNPqqveCTbY+24D9nuqrryaGJwmNTC9E9qSYCRsmz8=
X-Received: by 2002:a05:620a:2406:10b0:915:6c4d:d74b with SMTP id
 af79cd13be357-9158a7aa7d7mr296739985a.31.1780475745859; Wed, 03 Jun 2026
 01:35:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529134302.1989958-1-mszeredi@redhat.com> <ah5-40YypaswEG-1@groves.net>
In-Reply-To: <ah5-40YypaswEG-1@groves.net>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 3 Jun 2026 10:35:35 +0200
X-Gm-Features: AVHnY4LoJOuscRkWjd8EUUrhDi9rqZKzqt7J6BHlC-LkQxfSmJwdzae4FAaaqHI
Message-ID: <CAJfpegsJj8cZ=CXL-VGeVDOayAeTzstWJgvQye3N+sudHJ5L9g@mail.gmail.com>
Subject: Re: [PATCH] famfs: FUSE_GET_DAXDEV -> FUSE_DEV_IOC_BACKING_OPEN
To: John Groves <john@groves.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 09:04, John Groves <john@groves.net> wrote:

> Device indices - the part that has to be right
> ----------------------------------------------
>
> Everything below turns on what a famfs device index *is*, so let me make
> it explicit, because the patch's model of it (kernel-allocated) isn't
> workable for famfs.

The backing ID is a temporary reference for the lifetime of the fuse
filesystem.  If there's a persistent device index the server just
needs to map the persistent index to the temporary backing ID.

AFAICS the only case where this matters is debug messages, otherwise
the kernel couldn't care less about whether the device index is
persistent or not.

Am I missing something?

> Identity by reference, not by path - this part is right
> -------------------------------------------------------
>
> The genuinely better idea here is getting the kernel out of resolving a
> device pathname: the daemon hands over an already-resolved reference
> (you do it with an fd, from which the kernel takes inode->i_rdev)
> instead of a string the kernel has to kern_path(). I want to adopt that
> - credit where it's due.

Name, dev_t  or fd are are all just ways to reference the same thing:
the underlying DAX device.  They are completely interchangable, so if
we have an interface that accepts one, there's no point in making it
accept the others.

dev_t -> name:
   readlink -f /dev/char/$dev

name -> dev_t:
   stat -c %Hr:%Lr $name

name -> fd
  fd = open(name, O_PATH);

fd -> dev_t
  fstat(fd, &st);

Thanks,
Miklos
