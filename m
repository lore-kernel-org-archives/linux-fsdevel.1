Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A092F8EAE
	for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789314426; cv=pass; b=hs2qM13b3CcC/mXCZoa0dovJUTzPevFGdMtdhYzzidzxNcguoJua/R8u5VZhQlOEjIUiBGIVxS+q8oH1qqTfO4xLyLYATWkPBFmanJCWcJMSex+AGyCWCUoT9kuQmmui9YdSF7FDHSRjM7A3PmUG67V9eGUGWpOBU6CsF3+c9t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789314426; c=relaxed/simple;
	bh=KFkEvrKDNmPhRyOa4UUB93A5JAqNiBMds7vZAclPLSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C7KU+n3wS4x++ofxBUhl1z2UmwBdwq94kRBtlQ55RQ6kqlzLOVxPTPDudp4Kv42mPqLGE06ZdGuIMevmKA2RGOiTNI/Tl7Ux8seAE2zwWOGClH0y2+Gw4qjfaphUg1Chh16J+p0BNzVcYbhYLac9mruhYk1mjBBpraUjKSG5SnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4C+vwZ6; arc=pass smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4C+vwZ6"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49bc59559so6762871fa.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Sep 2026 08:47:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789314423; cv=none;
        d=google.com; s=arc-20260327;
        b=mfacv/BJYPa1Fa2B/g4BuBalGdJu6bnQ5hidHmjBUv00daQOWaecwIkRQawzkvyFEg
         Y/VzSh6tRtVImdg4y13jm6ZnFLcXkS2Yfbq6b+BDUurzNFbkbM1tuJrDCFsbIWIzyUhM
         FIRlDUxyy1Y45Oko2zZG+uQvZl0nNI2v0xdQ/GfsridsOh7ERCGMlG85ztW5DP7Jgu+o
         UMRoKX9W3xKDzm40w+ArgZObanAvXQmgUnqnoNdDnAF8TaZOpRZ/qAE2cgs0fkX+TiOG
         V2JYrUVY1MrYnm4wOI91WYUaEPdA2SRejRdKzE1eGXAPkz7oEhardYyxNnfEvxOMPoD9
         flHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KFkEvrKDNmPhRyOa4UUB93A5JAqNiBMds7vZAclPLSg=;
        fh=tCl0OEwpZO+rQ6a91ElCt+DMfAOU4KkxKA5kz7wv7pc=;
        b=PPp4YSwlhL0hThNXszX1hGXCQUDzJh4dVKxnCziT0XBU1YlRZkwUGyXvfxh6qyFvk8
         E7cQeQw/n1L2+/LNmS01yWD0QqvDiLwEJErBL9MpvxfLiGGSuGB1+wgxD5wc++chJrgI
         13vZpFZucBCezqZfBG1u2+7PwAPBKgHmA/E2m/E5B52Vl044+wjJoS4gA9/pGi3GG8wf
         4d1JXbhW3gzMBhtIBepACWHDta0Iwg9Q7LJ1Mr7dmAgO+XiG//t7FzK9ufb+Qedlp3Gk
         vM0SwmVmA/o3ouU7V9yeUD5lJV7yGC+mfzfyiluTuIJDHrSbKh2moMV07lEVeRUUEWki
         h3Gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789314423; x=1789919223; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KFkEvrKDNmPhRyOa4UUB93A5JAqNiBMds7vZAclPLSg=;
        b=B4C+vwZ6TOxVZ7ImvZoKk5Hd10wiJz36mN6RVG3XgnpDSLdPs/zcyQLzzWbiZI6TQl
         yaFVl6djzq5UKT5MpXKBWM1xayrmauqFr0T4ZF4TmzjiXkkNtaWUoW4ERevaUrenW/VZ
         ue1ZE57SM5/+SAmsaxUMtpSd5XR322tLxrjiBDAWs/b3+ieq18QpzkRVvxT+QprI3LKf
         LrBerA2o/yfklNeFmLc5C71B9Np8gEvdCCvzbis7F8xU/KQwtzchU7BSA9sgzSPRHWzz
         2aKNtA0ufxfgz6Rt/gajkkCaNpMyVxasPPkcPmDtAV56Xq30iqcrsSzAsF7mA5itvH/9
         0Z4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789314423; x=1789919223;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KFkEvrKDNmPhRyOa4UUB93A5JAqNiBMds7vZAclPLSg=;
        b=IDOWnr/V4FVvtUBXWsH0+VpvmKbE5lO8bXoxLG+0yR2Gc7KMps/eV/u9GktwqWahEV
         kIU7o2A2N9BzAEeixmX2tgH89BqXmf7JPArvLDgCPwm0hDnQasS3Wk+cwoAcF14KaDhS
         /FZhJpzmBUmTGUpfI7pY4OIdz6c/FFi6DUFaitAls39Yoq/xroGIpJ/ea21LiABGrNzQ
         AVZ61ZPzIvmFqXHwQJPiMTtHOPsTNJr3mBuXUgpwmIeobdODJLFn+of8JWTMTq4xiTcb
         8+rpae8ov7wn4okUmwFW0d4QyEQOEZwmenJhHp0HJVgr72P1R198AwI1ziTlNFw0SyHn
         scQg==
X-Forwarded-Encrypted: i=1; AKwUvBwFBdCxB8F5LJjqyzjXCKVe2T6eAH1au93bZBNAed2YKXlWb96JxSIlcsi2JZFZqF74WQj7Zc3496J4borH@vger.kernel.org
X-Gm-Message-State: AFuF++lJhdcnVRuUeJTa9cHB+I4Xx6XUa46O2WDH6amxU0JzSThiJHSC
	DEksPZApctt61lA++iX9gypcaoWLWyWI/sIxcGmWRQFHPZhs6PPmeYu0orn22EF5Sb8iV6Eggtb
	ygnLmyua8yvwbC7BUXyo3xHbuYmS1NoY=
X-Gm-Gg: AYBFou3/lm5VwLW0+9wGek5XvSC7zNlkZSEy4COJdOWfnfDsigY/8CQC6dN/x289ui1
	2ogWNfDhHNv1x38WcZfS6DRRdAnbqPZ3dgqCHTAD7AkKISCt1lota28f2keVzbVx3K0G0VewqDM
	/LeAJlMdGedW0w2xSk6nAAdgF0yUK66eG2zLll/RdJSE1DJ6qU8j/SDueMzOWaV7VMzrXMkyrsl
	fgoiUnh2MT4vO4x1iEfCH1wRW28MGy0JhtVgesONte8CwjxuVHxbgg2IJXQzFjhE+hCT1affGkE
	PQbETW5qeknh+epndeG7RrwZCbYSH7S83UMAJRDKpyhINAErx7yk1CXK2peU3Rpwe8ex1Wl4guV
	WXZ8CcaS8OZ5pOg==
X-Received: by 2002:a05:651c:154b:b0:3a3:7681:6d6b with SMTP id
 38308e7fff4ca-3a5b38161b0mr10553231fa.20.1789314422665; Sun, 13 Sep 2026
 08:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANGjgdn=H50AaA-+O_GA-hkE9UwLANmkjx1zRsKUzxF5za8VfQ@mail.gmail.com>
 <aqa7KgIJYGgf7INk@slm.duckdns.org>
In-Reply-To: <aqa7KgIJYGgf7INk@slm.duckdns.org>
From: Chengfeng Lin <lin2530632123@gmail.com>
Date: Sun, 13 Sep 2026 23:46:50 +0800
X-Gm-Features: AcwNN1U3jyA-1tSNpP-D9guvtV6T3al2eJNkQEtzf0t-dPsWgp_KnaGhqsq7NoI
Message-ID: <CANGjgd=f9n7zEZS=xi71y_dY6Uk75_qgP9qVDkYBusNz9sp2sg@mail.gmail.com>
Subject: Re: [REGRESSION] kernfs: empty cgroup rmdir latency after
 delete-notification changes
To: Tejun Heo <tj@kernel.org>
Cc: "T.J. Mercier" <tjmercier@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jan Kara <jack@suse.cz>, driver-core@lists.linux.dev, cgroups@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Tejun,

Thanks. I found this during research into kernel performance regressions,
using a microbenchmark of cgroup creation and removal. This was not
prompted by a production issue.

I reported it to document the added removal cost and ask whether some
of it could be reduced while preserving the fixes. I agree that the
roughly 3 us increase per removal does not, by itself, demonstrate a
significant impact on real workloads.

Thanks,
Chengfeng

Tejun Heo <tj@kernel.org> =E4=BA=8E2026=E5=B9=B49=E6=9C=8813=E6=97=A5=E5=91=
=A8=E6=97=A5 23:03=E5=86=99=E9=81=93=EF=BC=9A
>
> Hello,
>
> On Sun, Sep 13, 2026 at 10:43:04PM +0800, Chengfeng Lin wrote:
> > I found an increase in empty cgroup removal latency across 507d8ce13f5b
> > ("kernfs: Don't set_nlink for directories being removed") and eea5d2bb3=
4ba
> > ("kernfs: Send IN_DELETE_SELF and IN_IGNORED"). With sched_ext disabled=
,
> > rmdir() went from about 6.5 us to 9.6 us, an increase of 46-47%.
> > The result held in two independent runs.
>
> I don't want to make cgroup removal unnecessarily expensive but at the sa=
me
> time it's not an operation that I consider to be a hot path, so as long a=
s
> the operaiton can finish in a reasonable amount of time and single digit =
us
> definitely is, performance of rmdir usually isn't something which is high=
 in
> priority. Can you please detail why this matters for you?
>
> Thanks.
>
> --
> tejun
