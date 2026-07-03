Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8257343D80
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 11:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783079152; cv=pass; b=Ms0MQ9P1FHKFMYcguI2+7xo4byhPh8j35PsrBjzKAyTEaHpzKrbBRVd0rAxCMZxRkItGkyLrQ9BL9cvoBIHPRP/F6SW01u2kGiMXgHtAXrkKjVY+Er6ISulmlOBXdQIaI7VLzNzMsD6euOIZf6QMGlIK9EVvvtEFX3Gz8C22+lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783079152; c=relaxed/simple;
	bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jy2LdsmMKhe+RaGF4aARhiY8b0DI6QlJ+5bEpUVfSJiJAIYTbhFoEeuLLcWCBlAgMX1bDAM3+BfyQmXcMeG2x1WgSYX312LS3OhtJk5K9t89ILJ6r1WVVUbPJ3WdDj2ZoABfrFsQJOOzjGFaxmPFr2l8jlqXuXJweGAIQdGzKoA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fLyBr8UH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gpVlvvjN; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fLyBr8UH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpVlvvjN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783079150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
	b=fLyBr8UHrSEqg9mX1jWuNKlo7oMOf4wjm4nQy29h5hs9u9Q2mYus9sOv08VUwyflg3FS1m
	eLvdaR6OqWFv67rXVtlEvgWjTVCPX2CRI5vXnVRrfC2LzJalZNr69iFMeLwg90Oe7TmAh9
	WPB6CmlvLK7W5vcSlNnmyZhSUQvl3bk=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-l0_wSH49NE6C8u7DHCrP-g-1; Fri, 03 Jul 2026 07:45:49 -0400
X-MC-Unique: l0_wSH49NE6C8u7DHCrP-g-1
X-Mimecast-MFC-AGG-ID: l0_wSH49NE6C8u7DHCrP-g_1783079149
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-808a9e51918so12605057b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jul 2026 04:45:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783079149; cv=none;
        d=google.com; s=arc-20260327;
        b=e9yEQwqdcHY0PQEejpLueJwgmzIzUmftGPo9DT2GnD83wx0bXaWqBxiFM7YzJPfgMQ
         PpEKTsiL0fRccPq/XcAcimXY1H5DbSfiyVbD6taAVnaNHJtbDEkZfDbOKMwjEsq441GL
         jMAjd7upJ1ZEHs/O62aXOYIDBKYPf7ErXnt+fYdjXV/L+s0VL+n+iTzgr+UZOnESuvid
         hCJ5pmF7+jf7RvbUrrbmAhM+uYoO/rBjlzsKYbIgp4H1vlWNuLolbdoXSMFiewcozvGW
         TJyfFIjQ4wJSYZRuxRrky6/cpPx8BQEUKi7k3r+tqJX2lrV/ZLmfBe12xRo5r/bttmxU
         m0VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
        fh=7oHEz1QToukC0k8QBBf4nz6+N839i09v/fjQvT5puAM=;
        b=EzkEMEDhb6EOcPdcZ95uDhADOP6FQth0Gr9G+Ywv1FnWnLi739nb8Hi5dMl7y6N8qX
         hcd+Su6E39XpRG9HeRBcrKba1LqEOpV125SDejmrq6CqtIS3GBBsxVNyqab5RGMOANBZ
         O3jMKnm3mLg+uHHywlz3f9GRWm1BuTrB3vmr73pVEtXFiEPZXzIIogGZm2tsI3Wc9PMy
         6y9uRCOxni0XiH5WSctMVgEDi81bRJ2JEhdF/T10KbLSBZPljFcOqtFOsbUOmbBcVI60
         HuXNu1NeHOkFztk1THTeOjSsJmK2JKTxOdF7B4mn66KlXNdyXMzceY0Bh14ibthrZGb+
         CEuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783079149; x=1783683949; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
        b=gpVlvvjNWqv6inkXDAzUGekF7rJksIpyQSqAz1/JeiPQZAyAdKiRY1TRQr+ZsEQTDa
         dOvrnHlHNk2uaYstKxwjyDSXbUqclwp3hfmAJQnGydMtQz0FPre5xpoVEWVMgszZTdSB
         b9CteiS+gWE4/uqwr86+KkDj1kWqiVwzUJtwYfERaZZBjC7n0xMubtHQXSAYlWzanc3y
         rbOMUYpQ83tZ2fad4vMOnkztzjk0zE01NwQy+ys5zwdnaGtMQaTVFc2grTLEea62qkoC
         SfSr7tduEQPybp0pxJYUvGKgbHJpzqXgrgxD9BLroJ+MmEQovsPbKcOYcdF1ZZotr1UQ
         rpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783079149; x=1783683949;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GeUDSjrHAWkuRRsR++4INezbx04TBh6B1L1rO/GgWvo=;
        b=ewJHt/6W9tKszCLs4h9IIS6dnokeF/C/adVanbSLEfnRvTtCmcdsut9GZjLYM8E+Lv
         Q2CUbndyskGqCgZ4jEeJjczFdSoYkbb/cITh1KKNo3nzlYKrKTgTjiIzRg8PkXFGnfLW
         3KrDgq2hRxYEFji86NXG1xQaOrT4GVLTWrZnTiNlx9zIQZCXmSA/RX0pfN6uaPIHXWGs
         /Nu29fvolNHi9QS0HuHVJ6lJLz7PMX+o0MfeR1oY7h40mPvkpEmyq2Cl0oBcW5SBydo6
         bWNGp806Xqsp8SGOBa6TjpfNLlR2txZeqh22N42qdBheOm2XTFVsPL8IvKe/OEJefVh8
         0eCQ==
X-Forwarded-Encrypted: i=1; AHgh+RrM6HEJz210GzEz1cylHC5oQwZjEMUrhOrqODYNCmBNYrE/oYsHQ1LAiPWkuBw9hmnxQktDLY79xGIuxat5@vger.kernel.org
X-Gm-Message-State: AOJu0YzbZnpsy644zQ0NAf1cQH8weshJGB1xoEqzewEK33gYaIRhURWQ
	jWAiROD34Pfp9zfuRwTlqyTYvzIfeXEMVPlkxgNzOh8qgyVtNNsqoI2cE3hPTOzODb9nQQ75wz+
	CkYk2c+6wdTHGgCxbdGMifPGxfMA+AqutYMVL548xxS1wOp7dpJnCvrJjnWoUlslE5Hx4fsoUGA
	n6uztUc5F6x0oEcYLOL/4ob4X2GwgYfNmbYRKYw+u3Og==
X-Gm-Gg: AfdE7cn0Ng6fXfh649bHHDiYpm9PFdEhIN/umGfrH09hkCc/BKu24WUwRngAEvt5O7A
	0vzDl6tHTjiIoOwCKeG+euTUyHcZfnKDxgckPJZ+RHWZGQcF5gcCu7IJJ/KcERv05267Ic7sadd
	YOaTOXEXuMiAMZxBr6sBDTU4RjevhdLVpidPGeuuGJm1EkteO9ELC/Qas/VrGaO75y1ZPfGR6Cc
	LnwlJrxymJPxSCplw7Hexp/qRZ0Q55J2yE89PFK1V2M+pQ+P5CAy8c=
X-Received: by 2002:a05:690c:6e0f:b0:806:1ec8:9626 with SMTP id 00721157ae682-812eae80545mr104664827b3.39.1783079148650;
        Fri, 03 Jul 2026 04:45:48 -0700 (PDT)
X-Received: by 2002:a05:690c:6e0f:b0:806:1ec8:9626 with SMTP id
 00721157ae682-812eae80545mr104664337b3.39.1783079148147; Fri, 03 Jul 2026
 04:45:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701000949.1666714-1-joannelkoong@gmail.com> <20260701000949.1666714-13-joannelkoong@gmail.com>
In-Reply-To: <20260701000949.1666714-13-joannelkoong@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Fri, 3 Jul 2026 13:45:36 +0200
X-Gm-Features: AVVi8CdOnoIEUsSqGG1Lvbx5AQnAbjO-BXv_ely4Zi6OZQFZeWID1WZjNQSTcpA
Message-ID: <CAHc6FU76J-YYRd2B=ZPN2DMabQjkzgG9qSzbP_S1s9AsSJNh=w@mail.gmail.com>
Subject: Re: [PATCH v2 12/18] gfs2: convert iomap ops to ->iomap_next()
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, hch@lst.de, djwong@kernel.org, willy@infradead.org, 
	hsiangkao@linux.alibaba.com, linux-fsdevel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, 
	"open list:GFS2 FILE SYSTEM" <gfs2@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Joanne,

you say in the cover letter that

>This series is submitted against Christian's vfs iomap tree, and is based
> on top of the current head of his tree (commit f2727952b21d1).

which repository and branch is that? It's not vfs.iomap in
git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git; I don't
have a proper merge point.

Thanks,
Andreas

