Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6977E3033C7
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773883970; cv=pass; b=eDRKG8qyZzeOVYjAQKbCef1IWNjn98UD+jGo60Aoa67pzKMmmcqH7ew/L0lHwh52vKG68NzrcDYscF8UCQ86BykvZxOwa+/KHvHmWt9xZHrP2/ORJUOH4Wz9LLNAIM6eH/rZDc3Tfel1pVuRaY/HSJIvnPlpfGs4LCKdqca8dEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773883970; c=relaxed/simple;
	bh=KUniE9XM6GhZGpha47bY28thHCuWtU1wXrIbpPp0gKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TAFmafCi1tYppl/Ha8jj6eieuQFPbE1HpsSuP8lz2B/agS21C9YLrLPmiR8ttw+AInq6ntWlIjLMg4IhUbQ7vPNfna8tXRFXcSKwLZiGnbu7sXbgbEnmsyQnDx9lY4vgw2enqOYxu7gcrY9LR859HKlVEpV49M+sImvC095n068=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hTwf7Z3m; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hTwf7Z3m"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48538c5956bso3329535e9.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 18:32:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773883957; cv=none;
        d=google.com; s=arc-20240605;
        b=VPwtaOUjcaPaZbDupn8jHELissoyklOcDK5fz16Age3DCX6MF8SaQ8GeLjX1SrdFyP
         vw+SU2pqhyX1NZhtHqPAq2H9Z9v1/KM2QchXxDtZ8akvz1yozyaLEfU8/psAtScz6Dqj
         JgDGFMXEM+WcwOFQZ4YDE/xJJx3fQVTkNCT5tZrMX2AByqRkgt6ti61h2U1Fr/FAqTxm
         aEdtfoOGWS6rqcNlDyDSD1EZLQ/WPCtbCKE97Lzan3e/UMqsXvv+aRCCgVc1wqcsJaaj
         dxLm7nack76MTk0C7kO45Yc80i8BQ+zUOIzGo90pHfvlT62sN/xnMo6mgBcNarB0D6Ev
         yh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8aU9ySOYF/BKWuMQgkZk/2tOtohLBvOuDM22BXL2nzg=;
        fh=B73f4QUUFiJPig4jI1wpxCVm9MztYdduHFfa9fUCAAo=;
        b=IZwSeCHWZXo52QWZabPdsfXaBVZvXHIBRNfyhUaZi83svYIvtuNFWprfk+zNPLTeH2
         cENBNxSJnA96QQA4tozyaq7xgwPGwbMfD0Gqi/kJaGaGpfyy/xA+xIk/+6tatEJxJxxf
         0ACDSq58sw0LAmsb1mfWvaIrAaBABmGx78fHwOoGM2uec37ucNZQKSWaxrpwI4e+Endw
         Wja+o7ASP8tAH0LqVf5GM4WWM0UeVVsHTK33F+uGIOgFqRBKjv+h9TPZ17ysyNE1HpWd
         0+Dca1f3FnCJxAz/x50kwmVfJ9y+FsE6Qz7f8+TmH+xA+yfcW8n3kfKXSWfxF0W7hg8l
         l2Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773883957; x=1774488757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aU9ySOYF/BKWuMQgkZk/2tOtohLBvOuDM22BXL2nzg=;
        b=hTwf7Z3mIxQ2R6V0hGLMUtxS9harzyHcOmVFGtCnuWPf3cvwyegx/BShHEFrRyVGQ/
         kuUfBWJzZZiDzkVoZA6LAlq3N6R8ZL8jlU5ckoNf/AWfPjbx5E926FIajRWC3J3t99Sd
         oeNydlA5vI7rybPw8ZDDnm+yHC+ZAnY73kaPVyQvH8euM2crw2JkFDuAchpFUAtJ8L07
         LL2P4154CJx6Kaa5JkA80Pigmwm5K9kIF37qjEorAEopDemS5ouvjDFTUJksCrGWVJ0z
         KdaSgM5hq98twwgr0S00bgTTuvmTrVjbpSkry+q87m932xIq5uUahfU4CAEwlCw+LEgk
         T7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773883957; x=1774488757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8aU9ySOYF/BKWuMQgkZk/2tOtohLBvOuDM22BXL2nzg=;
        b=RHSjkHmQgyuhJJo446gt7MWXKlsh6mIbvcwK6Pd2up6gHRoK+ScXwMPitiwDZHBlSc
         k7OoZMgmDhTOCGwWreE43jehtVgpLKpCzvkv4wdSUbILHfEybrsZuVMa2HFPfpgRp8kN
         6dZw4Ow8D+opNssdkEiAX7D90kzCJNckJAdstTSQ3dy2MaziSaEJg/RmLiBZGuXljewn
         eppecALp5SMkD96Hej0T+jQupySOuo4HJVaeShS1LQDepXwtGGPGwUtan1zraHBpFn88
         l31JGRe83WyHoSgRtgs48ufAmh7JUazc1r2GUNn30DVtZqzJ6Yiq2Su8HlnFgRgKu7na
         WR3g==
X-Forwarded-Encrypted: i=1; AJvYcCV7xOnnei+za6nz6EyoRho3fyDVj+qHBaM+2rdrYhHGj0vFRIUEwon50jKYHdOrE5dLnk0v+Y5srJl1zcud@vger.kernel.org
X-Gm-Message-State: AOJu0YyAjr277g+NvgDNlKf2CXW9eDq3UmSmQTcotS7HbKlnkddaGr8d
	DVQqAfzN+0muXyEW5WygcRLPB2+H9V4Aeihgt/mC1P0+fVlR0iQNw2Kdv5+lcUV/Lt6BWEkp2uF
	R8jtO1MGhrK2MFdFz/Ft349bUXIHsvME=
X-Gm-Gg: ATEYQzydWjv3imS0O6RdW5FbIrrxaJdlOoEPq+QkFE2bGozSogqTTKrkoTq77YOGckt
	j0TzH5t2mnAlOvPo7OkrW5XUdUA2cE8d0fgn4YdY4RYcshcaMsF/g+XiTXeujdlxlyRF4R14a6f
	rWZMFTdwsJmLVroeBUAcVQKP+g6aJv+kQBet40aL5VrtFfMslSN1aGzr2ldVuXPeyy1ox+PA9pa
	rHofHkMQlo7naSBCAjglsr7fDh7K0HUlW0sRh2k0MbIjgnLopKVLQPV8EWk5UkVlv5BniCl7a+m
	Qq93JyAXdICP7pRH
X-Received: by 2002:a05:600c:3544:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-486f8b35605mr26710635e9.9.1773883956829; Wed, 18 Mar 2026
 18:32:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316-mark-dirty-per-folio-v1-1-8dc39c94b7ce@ddn.com>
 <CAJnrk1Yyp+3YDYNTzyTUQLUDsiQ9WB181-mu1FOpGyaVTu=_1Q@mail.gmail.com>
 <abhg4tbxDhYO_iHV@fedora.fritz.box> <CAJnrk1bBu5VJYnoZcV3uaS7+uyxK6TK9SLDtF2WpcRNfhUvO6w@mail.gmail.com>
 <abqvmS4adTXVxFIW@fedora.fritz.box> <CAJnrk1bF0JFAWOF=4hjMhiciSLrvob268fcQgv3P28Po8J=qwQ@mail.gmail.com>
 <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com>
In-Reply-To: <60103445-0d45-427c-aa00-2fa79207b129@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 18 Mar 2026 18:32:25 -0700
X-Gm-Features: AaiRm53nqs_Hnkw-XpmqJF6b6TJuogBENKakN6W5QaNkVZ9VWTQXJh71dzuf3PM
Message-ID: <CAJnrk1aWgWxzh0ETFkZXvJcfHFAC8KESEBLXa2S=ZqDfSSssvA@mail.gmail.com>
Subject: Re: [PATCH] fuse: when copying a folio delay the mark dirty until the end
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.com>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 2:52=E2=80=AFPM Bernd Schubert <bernd@bsbernd.com> =
wrote:
>
> Hi Joanne,
>
> On 3/18/26 22:19, Joanne Koong wrote:
> > On Wed, Mar 18, 2026 at 7:03=E2=80=AFAM Horst Birthelmer <horst@birthel=
mer.de> wrote:
> >>
> >> Hi Joanne,
> >>
> >> I wonder, would something like this help for large folios?
> >
> > Hi Horst,
> >
> > I don't think it's likely that the pages backing the userspace buffer
> > are large folios, so I think this may actually add extra overhead with
> > the extra folio_test_dirty() check.
> >
> > From what I've seen, the main cost that dwarfs everything else for
> > writes/reads is the actual IO, the context switches, and the memcpys.
> > I think compared to these things, the set_page_dirty_lock() cost is
> > negligible and pretty much undetectable.
>
>
> a little bit background here. We see in cpu flame graphs that the spin
> lock taken in unlock_request() and unlock_request() takes about the same
> amount of CPU time as the memcpy. Interestingly, only on Intel, but not
> AMD CPUs. Note that we are running with out custom page pinning, which
> just takes the pages from an array, so iov_iter_get_pages2() is not used.
>
> The reason for that unlock/lock is documented at the end of
> Documentation/filesystems/fuse/fuse.rst as Kamikaze file system. Well we
> don't have that, so for now these checks are modified in our branches to
> avoid the lock. Although that is not upstreamable. Right solution is
> here to extract an array of pages and do that unlock/lock per pagevec.
>
> Next in the flame graph is setting that set_page_dirty_lock which also
> takes as much CPU time as the memcpy. Again, Intel CPUs only.
> In the combination with the above pagevec method, I think right solution
> is to iterate over the pages, stores the last folio and then set to
> dirty once per folio.

Thanks for the background context. The intel vs amd difference is
interesting. The approaches you mention sound reasonable. Are you able
to share the flame graph or is this easily repro-able using fio on the
passthrough_hp server?


> Also, I disagree about that the userspace buffers are not likely large
> folios, see commit
> 59ba47b6be9cd0146ef9a55c6e32e337e11e7625 "fuse: Check for large folio)
> with SPLICE_F_MOVE". Especially Horst persistently runs into it when
> doing xfstests with recent kernels. I think the issue came up first time

I think that's because xfstests uses /tmp for scratch space, so the

    "This is easily reproducible (on 6.19) with
    CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=3Dy
    CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=3Dy"

triggers it but on production workloads I don't think it's likely that
those source pages are backed by shmem/tmpfs or exist in the page
cache already as a large folio as the server has no control over that.
I also don't think most applications use splice, though maybe I'm
wrong here.

For non-splice, even if the user sets
"/sys/kernel/mm/transparent_hugepage/enabled" to 'always' or in
libfuse we do madvise on the buffer allocation for huge pages, that
has a 2 MB granularity requirement which depends on the user system
also having explicitly upped the max pages limit through the sysctl
since the kernel fuse max pages limit is 256 (1 MB) by default. I
don't think that is common on most servers.

Thanks,
Joanne

> with 3.18ish.
>
> One can further enforce that by setting
> "/sys/kernel/mm/transparent_hugepage/enabled" to 'always', what I did
> when I tested the above commit. And actually that points out that
> libfuse allocations should do the madvise. I'm going to do that during
> the next days, maybe tomorrow.
>
>
> Thanks,
> Bernd
