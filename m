Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222D333970F
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 16:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784737777; cv=pass; b=qBfKQ/ffzHJXCBK3cE74GlTqg5Ldk1yrF/oPzbs++ipR2ysQ0NUTXbfEGr8gVNgNL0sqJikeSNNN9AUjCmtWRN3bB/WrOYq8i3eY7Ftq7TWaDcrKPV6vLh1xuQQ3hn0KccUGXG5yQlQa1/EvtG+utCm0VgpQi0Ep7JzE7IzUydY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784737777; c=relaxed/simple;
	bh=U+1oSlhoto9RzC80eRCQEK7mIW4plZHyLlmXaf+c5ZI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQcMGy4BUvYY3+I2Y7VzXSuJQcX0WaYPw5gLAE19NnxlDjCDhLCTH8BHd7o0doCffrp8NHQQ+wzz+zZNUuR77IZ+JvJSh/z8XmijiUH+H+VkE4VLTaL6Ck++Uq6xux014NNwbyAiBZGSgbe4FHa2BNn2AYE6CRBE214ETVs/764=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=CGqtQ8Ar; arc=pass smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b="CGqtQ8Ar"
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso11732637e87.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2026 09:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784737774; cv=none;
        d=google.com; s=arc-20260327;
        b=QZFc2/qP+flWgCPJSPlpZYgvlXv6SPf0C+bJPZ21xyq6arlusb+/fQTvrtTxakE+aG
         amFUGzg7LY5v9g2wXGPfnfg4FC/EJo5vydABAAHBLeu8faTrRUn15aTBtXFTwwSH5H9G
         6yRyJNvCE1X3GSlBb7zlpT4AGiYG7UMbe+0IeWmWGzdt/UYOG8op/gIn7KYvRAuH79V1
         hWfILoRkjtGUs35wUvgDqRWTYgXvn6iZgsYvHzgH7u5m09HkCZxRwgEmX36C59pNMobr
         tjGO5KbtVC5AvHJ25e7u45obQ/uPV2xp0pSrcyLOZUbbu3/mruWaUWBu0UD7mSQJG2b9
         hxEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=InkY2TqArSmQXaSwMOCoeFzsMAyO72A+PE6OTrxgjrQ=;
        fh=Go8ArXp+s5pEJFC57sejkgIgfwMnPPoBHFT01JCQ32M=;
        b=sFXWveC8G0UQc2VpNXjfmXCJ/1j9PO4PLiaxGAITWde4uOvtQ+kagKqgq9hD4+9pNE
         nINvkdbouclbdfSadeovc0TdrJL6J4GiHxQh6ODsOAz/p74c/1h+Vs7ZRcVeA5oTZ9Te
         5ENMCeNatD67TX6VrdLaC6WxtXPezIB29VKYwMAll7hyFlj9Yvbry1m0YJNF5KcXhwao
         VudmqPBI2+o3c/Z7QuEUDnHeFskzsYwsOcF7h8SceIku0TLtXKpwa36n9famKT6RjR41
         0pM3H0i4DA0kQ9TcDfcPVa+guPiQ852nvlabRB422vbmxP3iZIkPQRKA4SSIeZ5NEh1N
         O5cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1784737774; x=1785342574; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=InkY2TqArSmQXaSwMOCoeFzsMAyO72A+PE6OTrxgjrQ=;
        b=CGqtQ8Ar9zATM56qjLFdcqHMiqXEoB/rmSEZ7gVqOvBXFlL9pqCFP1YfXO4bJXVCKH
         h1t04PL3WCBYh11ZgmBZo7o98zYRUFiU5RsOhFysRGQ6iJIRjAdtEhrCb9pc7F0SVPwu
         iJAGNc9Cr1Avds7+BUX2dhUQkUGpWuR3auL+Bp4o2L0ReFhEO3BAEna2eJ4MM7pubBjK
         CNOGlOkWmm+Q+BTWYPNu8VwJnS/SkJCsWfXEcRB8q1tavuBqCDhFz34/W9ndHTe/kgql
         5MLp/y803L8iPsCXtq01aLZPPox/RU6/V0x0OtAXvvKCnYHnfc35oeKks/YVI5ebUqPP
         5Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784737774; x=1785342574;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=InkY2TqArSmQXaSwMOCoeFzsMAyO72A+PE6OTrxgjrQ=;
        b=WceDWiK5NGQbp32d1Cdifqu/7CFE84brjf8o0cK1Q3mhlFRMMPOVDc1Wnh9zbWJ4uN
         8T4DTRvIwxcqxMY5A+4+83WFEXt6cBkRlKFZnWw3dnuQUTZThGE+qFPH7yQSIdmSOZta
         VWhNHyTgTnDMql52hr8Fvf68Lk+ShQjMPHH/0W61ZzAEeOHsPzkETv0fktYwAQZDgD+A
         ra1lVyiedHAQWME8z5qwSP9655jkJ4H+aK+A1LtkEyljFw0LCpEM+xKmcthtjwqa2kJi
         uapCVHQlxPJ1hMIhv/5oj96EJzKVzLGBME/geqJ673QjalGyI1B04D/pnSkiRkH7V7pq
         RsVg==
X-Forwarded-Encrypted: i=1; AHgh+Ro0+qCdQ3aeExYD2z5mJthL06WfWamqGW9BLIXQlK3mBbx6kerceYmntChiwzuyzS0vkBJbZoZR/9N2+6RB@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0zlQIPNmGqtPLNPm8zTk+XU3MTuYsNcjZEJULsH0drurDkHxY
	Yg00vF1v3qTlxzssa8jyCx4QkooxYWJ2DmduE0Axl1iCNhyu3aER+3FD7EaHT2LIV5pGzEXIuSb
	IOry9RL4YfZBZIX7NBntA5LcPWFvYANT6+sOG0Cw1
X-Gm-Gg: AR+sD11ad9mUef18/XKUTZ8s9uze3lrJla+EyNekbH3LdPOMci++xrLM1ZTPJlmLkif
	WpiQLzCxAPlHSKvQeNh/kvxYlotMnrqZ2mwVDtgLVb4EkJBVq6Fs6us70fGEw6gYbtB1mD3AKXP
	HGRK+ctZj946kygevOiGXACmMQaaM9r41Tath/gsRHMwEoG8/3oqN1Imy/GwUORFzB0Rryg9Ppz
	jjLYNrPl5/Yhrt8Pf10Wipdwg6XUqN3Mra2qddSIjXnryZzHwn1mwYl10KbIA==
X-Received: by 2002:a05:6512:1328:b0:5b0:eda:de2a with SMTP id
 2adb3069b0e04-5b28f998d04mr4374814e87.35.1784737774129; Wed, 22 Jul 2026
 09:29:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715101107.973997-1-mszeredi@redhat.com> <20260722-fundort-zogen-kormoran-09fb867f1b59@brauner>
In-Reply-To: <20260722-fundort-zogen-kormoran-09fb867f1b59@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 22 Jul 2026 09:29:22 -0700
X-Gm-Features: AUfX_mwycQYWu9rMPFRhnxWdDLtR5J98EpUP47SKtC-4N4S0g7pVJ9n5XWZrccs
Message-ID: <CALCETrU9KdLsvZzUE-5sh7KkP5-cPh=hwErGmN=THsDatFJLfA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: allow opening overlayfs/erofs layers through O_ALT
To: Christian Brauner <brauner@kernel.org>
Cc: Miklos Szeredi <mszeredi@redhat.com>, Giuseppe Scrivano <gscrivan@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	Amir Goldstein <amir73il@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 9:06=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:

> Like I said before: I'm fine with an API where we can use open_tree() to
> see through into underlying layers, and given the right permission pull
> a mount out of it. That is a narrow, checkable primitive and it needs
> none of this. No new open flag, no second ->show_options, no metafs, no
> mnt_devname surgery. That part we can potentially do.

What, exactly, do you mean as the distinction between "[seeing]
through into underlying layers" and "[pulling] a mount out of it".  I
have a guess, but I'm not convinced that my guess is right.


Other than that question, I think I generally agree with you.  The
interesting operations here (getting an fd to something that was
previously inaccessible) are different enough from normal path lookups
that I think they deserve to be explicit syscalls or syscall modes,
not magic links.

--Andy
