Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092A947DD73
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573890; cv=pass; b=tr1PDBz0YfMuXcaScyBGc92hfmb8leCwsiRKjOJ+yZ4+laHj65hgSNImZKGwW1sVOPeIuY6Fd/Sf0IHFHYOgWkS9LbnvV39K+39XfUYDAADIXHZ7GumwUVok/9X5lIQrBlF8NxNus1iOQG4T3skqjrzrA5IPv5xFZVU0DfkL4fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573890; c=relaxed/simple;
	bh=fR+t6t85yPJnynwdIiSSs5MN4Gx5BVIOQQ5VhnY/qCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZxbVjeK3VnZbGltIzEKMpuLR10oOmc79bCMZFxtZYuNPZyQOM41sIRBCGcSfoqzmDHIRYApiG3S1eSw3eyxbLWkci0SA5iPrs5g+HhbkY9zpUvXTrdAYMQ4PW8kGNaKqY2NCgSdNDJ/lUL+FoDi2F/KYXJ+E/J5AjFUHhLXxWCA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=p5qYOXvD; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p5qYOXvD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-514ae601e01so24544441cf.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2026 01:18:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778573888; cv=none;
        d=google.com; s=arc-20240605;
        b=e55mzp3sejIdhUXb7mPHYTpoWFy0u9kOt59Qg8KGFzD/PspDkjDYLsVCmU0uzho1Km
         k5ZyWHNWLma1wP82AQwwCBcmSqtYnPdCBZZNDQmu0rSYLR9geDSs+Cz5R8bc+luzDCTL
         WWGIHFyjZyMiP8ZsVycsImjCa857QbiK+81T3lb0n91EjsErcBzITBl/mD+HhqxaQkzE
         5hF8iufAgdvduaBcYO8wlCfIv2G7jwpGBUkXeV98bIOgEzK413g1zUsthdFkpZdFJpG0
         Dcl3bDV1h+YXLuAfA2u2viHkhhieLQl+OuJHftcQUHdjXvne7wOqyg/uialpsxHpvmSP
         RJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fWKdZDEIz0/5AIUpgkMgXgPG3fN4lkF6Tz2OI9TrOac=;
        fh=F1UMknWTRcQYQHsF3jxTJ34D/So1Tv0NdX7RMO9j8WE=;
        b=TXqqyHHsudgeBsvSASLYf54QVFuzeHmCUt7FBf1LgOdZEUq90wAD+FvbutyGrKrlIS
         JRBoGJZGQ1nR9F/F0fiLBC3Jn6H+shhhPF8OocWvHPnAfFNkRpVCD47o7aFCeIdtRoXs
         89KklE3/ysYdC4wFZIYTX7ULGnIeq0FZTQO+JFgS8kZFelQj8Gm7DV9M8lpfMqkR1sVs
         DYs2JBhwhiqgHwrngipgELyd6XqaGRVYlOWo5QDOnpAb18lptPQ2Qie0gZHVDoyk5PFg
         cu1bfmLPI4NBXTZYUvGwCSAkLXokTLDeR4qVn40gpwGwEBP1eHW56kWsmLKZP5HRyMSW
         XN7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1778573888; x=1779178688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fWKdZDEIz0/5AIUpgkMgXgPG3fN4lkF6Tz2OI9TrOac=;
        b=p5qYOXvDjm4+RnZrPd9mdIrygMEa37yohmrzYsH3sAU5u9YZnX92FWIN824G6+/htB
         pjJcKrHqVfGMA0qQxAmc2tABoWsJnZ1FRMuyfe8D5LTTFuOshUCj07y+HJgYXPZcd52O
         FHA9SRWIfpH/302El0HwUf0RbUyriu3onyx3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778573888; x=1779178688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fWKdZDEIz0/5AIUpgkMgXgPG3fN4lkF6Tz2OI9TrOac=;
        b=Cw7TrG8rS4VzXs6QZocdC4wjs5MZErZJaY5ajfWMrrfN1Q1sLXI9+mZ/QGbreLhMOY
         n8VDoIKFGFZS3UT8gcJUEV+zPwCfU2qxhXX/b3N/+2pd8yKp24JDO4ZH3xJpompU5l3j
         gVh8Ll/WM7Kvv5sDRXAyQz/TeshiimhKgNxVfpKLd5mTXA1DiQJrygHdIod4ZeOp7e6G
         PDViSovcv/N9mA9SrOd8yCi4jFlfdPgVvo59v9bIhSqw9GplyFF0D0xrzdX96uX5HjfD
         z6jjnomQ+/UlhzCc1kTdGErIi2ZsdmhfTCyuy0wD0kNXFqvE+KidS1LcS/uKnc3P+C65
         0Epg==
X-Forwarded-Encrypted: i=1; AFNElJ+uPXlPwdCsRoIcuW4ocSJOAo47L/LuoAt5YgHR1Fgto6hkKJBFs4m+7OW5zmkCpCOutSFJuYvDmyP6Cylw@vger.kernel.org
X-Gm-Message-State: AOJu0YwpKleZo50hImAU54RyolNN/cJZTgBcYdUM+EUk6BnsKlCze8/T
	6IwDUFqiKlKtOpBgIF4bMGdU1skfWKW+EAvF+uGsUcWPV9MmCnc0Yix/Svq3XAHMSmQUvybNNRq
	Mq6vOQIQKgvmS1zds8BE9xwnE9GWoW5BWFDHN7XfcsQ==
X-Gm-Gg: Acq92OFDC3nnI9rGDzVeM4KEGFR4eEh1uBn3imIde0eKRcbYqfnSRJ3VFWXMilPBWXz
	+EudHpj85oPK+SkuMyWNI+w26+y8CstGz2H5VU9uazitjo/v51jskPwRLqT6yqAFBTQ8jMOQnYc
	pqsUD0Y3HSJGEY1svQqPbNE+vIX/B1IRgrF++GMCuG7UKmuFs32ahRjPyWf3ZIMbaGApXmZUAW4
	PbnJkpAeuOzjinvZDPn/nkcbH9K0SGN4GlFSPnPHj9yUekuX/14kmNxEqWSm++5cl/YXxzh20x6
	ZXjqSzs/nIJUScsG3JM5pUDNGsoR8keSlpdSGic=
X-Received: by 2002:ac8:5ad5:0:b0:50e:89e6:669c with SMTP id
 d75a77b69052e-51461e7ee12mr387316851cf.37.1778573887932; Tue, 12 May 2026
 01:18:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429102058.1362965-1-mszeredi@redhat.com> <afxK2HSiwY32KaWw@fedora>
 <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg-tgCmJkjFAQ86_xB7dDQKGy=geKAcxT2vB8cUSEKdPQ@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 12 May 2026 10:17:56 +0200
X-Gm-Features: AVHnY4JfMfmMXvsRGKbeyZ84gKB5B6Ce7WEB8KUqMJ2guAlNbV7mShn9mWFkO4U
Message-ID: <CAJfpegt7hj=WDKKASjWLVG-R2tGYUKMJ1qR0iv_Y+GaYS0mW4w@mail.gmail.com>
Subject: Re: [PATCH] fuse: add fusex filesystem
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Horst Birthelmer <horst@birthelmer.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 at 15:01, Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Thu, May 7, 2026 at 10:49=E2=80=AFAM Horst Birthelmer <horst@birthelme=
r.de> wrote:
> >
> > On Wed, Apr 29, 2026 at 12:20:57PM +0200, Miklos Szeredi wrote:

> > > Major differences from regular fuse:
> > >
> > >  - local filesystem mode only
>
> What about things like?
> FUSE_HANDLE_KILLPRIV | FUSE_HANDLE_KILLPRIV_V2
> FUSE_ATOMIC_O_TRUNC
>
> Does local-only mean that all those (and default_permissions)
> are handled by the kernel?

Yes.

> I see no reason for fusex to not support lookup by ".", which is
> anyway needed for "reconnect", so a fresh FUSEX_NFS_EXPORT opt-in
> for "re-export to NFS" may make more sense.

Why add reconnect?  If server supports persistent file handles, and
all req's get the file handle, then no state (nodeid) needs to be
stored by the server.

Thanks,
Miklos
