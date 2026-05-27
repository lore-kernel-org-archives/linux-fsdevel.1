Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2531731E850
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 23:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779924774; cv=pass; b=Da8LkDvg75NdPWBXId/ClloJEKxNmO3P27yFnYi1LhNjaW0XIp5T/+lqCLasm5d/eiyO34/I9J3ZT7DWNY4JnQ+roKF0bqT390hLdtQW4wPWc19xc4EGMBhVXHDa1jv08S5Q3bn3EI2dwwkXVbv9D0dXg5UQMaycS2XuMqIY1rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779924774; c=relaxed/simple;
	bh=56FsBBxj2wHEtfC8vJ9Jj2zhlxt2kWSIwg5xmvU8nJU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ux7o0KL0z8MoGuXpPzi2M8QGlXxaSbQrqEDYzbkLxbJoXFXrnf7zR+zRR82kYm0WgRv+W3muxaaz7+nTPolXMh742L8vJk+xexsqJBAsYA5fy/bd995NvdcJ+oDDbcn8lXDC3H0caawLI58wafL3D/O4bx0y7DGFDY1mgqXwDkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+pmOTt8; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+pmOTt8"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-45ea19f412aso4041368f8f.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 16:32:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779924771; cv=none;
        d=google.com; s=arc-20240605;
        b=AhJxuSLRZzYQefwF8nmCsrpIcpyfAdFjzSBA3zfkUJ/RxTWguFDrDQwE/1niHTtdKV
         YBHDkbkBswCzHfe7h2zz20PjuENfGZlnfblg06IPb5cgYrqWFIU2UMeJVsm52l5VM/8w
         q4iKysLUjrvyEPHAKz98Ukel/SxwTZG9nFu0iUYQYct5UW5+O4KJTMD8wULNJXM0SGXw
         sjfqJaeF2YWA7q3XZdodFRoZkfHCVqxdUv4wSe21pVf7WIsNJofJOkrYz6Lx0ncDGM0X
         RvAT99dfiUl6WEDjS9tyrn2WISjArOJyNElifiZ6JO1+VeFJR1LQ48Vwubwik/mqFTpa
         KADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DAbDwK2EPqXTD8KIUGi5JLsN5K4f21oPBpM/bqaPFNI=;
        fh=DjSRsVzZGroN6nYbZuyaspgU3HQo6RiA0Z27aOL1BKw=;
        b=jWoBpiB58aJEjiMVLdCq6J0nNm0569SNX+9LL2QghZc2ZJFdydmP3oCHiCJ7XAMPse
         hVLjriW+J2B9ujs8nTWy23X65oxat2d/smGS6Baq9/nCp1lf/L/b/QMsJXFGKBVlWAId
         RV2xgY/lPINfM1KfB4QGLYOcbzaM02MNy/lWvr+E6mDKOdf+GNZCQu5GjNqRXgPag3tr
         qSZNo1R76LaAzfIbAwW66Cw2/ShBuMu0BijyOqfXwm+JoDDvt1RVS0tCPrn3eCSvf4rf
         Hmst42pn8knLPXuacwmL8BHkeuJ/laiSVYh2/fywUink8lyz1eTtrY14aG47UAe6pF4n
         PTbg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779924771; x=1780529571; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAbDwK2EPqXTD8KIUGi5JLsN5K4f21oPBpM/bqaPFNI=;
        b=C+pmOTt8UyANNXK2nZYZB8FAGrEGhhdE1Cq6qdVBnIgPKI4f/E2ZbvL9tqy5NKAKEJ
         ZyAWHfrnbH8x4lRwmgRsktWUaoa3/LLs0Z3GupdspCRyrW29V9jGQV2zb/nl2ZHmt2Xf
         7tYJlM9HIdkLc8GQih2RrrcQK5VC7FCUIs+lTZkw/7yO2o0lvggZexh/0/6I9hcbvN/d
         VtabBYY6qy+ITZzv78rkHXABh1Cg9hUR7zXQzxVXg4D/aT19nsDAV8v2JyxB4Ar/0UOz
         S4xqHShlUGN0DzGA7O8NlZbukrmRx7MPbmvGaca2veFo5KULe3bFPSThvxJNneEjEuS+
         idFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779924771; x=1780529571;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAbDwK2EPqXTD8KIUGi5JLsN5K4f21oPBpM/bqaPFNI=;
        b=bU7bgrk8fCdaLf+4oXSiHUgif7KmOAA2godSaM1A0VWE9uNn66fqSmQOFJBmZX9aWH
         9qz4j379XH5DbPIEM8p/clUveR8QdDtCFizvxembAg1Drlrr6Bnj/xR92i9EgWOP/xUS
         IUbidWtN38DIgPP37zGm9Ix/W1pziyPd1QTFzNQVjrr4rKWkIFkJSAlTejlad8vLSKGQ
         5vsUl1WdN+h4eG2Nji+ryctdivg2DgKbecOQv5XbaNEerWwsOGNvz2mR/rpCCwlenKLZ
         kiXGd5ibzn31+NFHnqPpTPoRfnEiBNebZ5LvqslJ521nZRLHhRCLClBUvrecTwsScrZJ
         6RwA==
X-Gm-Message-State: AOJu0YzYh7m7tFGrBf0MBriJvd6gC07LOm2MyUDvssSghp2/mPVB7YjL
	Ac35+zZ/ytFtOcL7GEFvsn1KZpMtmXx6tmhwLbT1s9JFYt/fNkUJWg/QYletbkcedXJWEixxzho
	3EMU3zCPAYl0Ff+a1CH78Cysav9b+PDY=
X-Gm-Gg: Acq92OERKGhMEOGV3NpDbPuwQd/xnxyt1wRvSU9HLtIKdrFjOfP+JfMPRA5Dr3v77cJ
	4Ymkv9fcfKLxkhkBoKdOuAVI3T+7jbB+8QpY4P3L65bae+Ga4YTUbaBbcxUYscwpOi3+eniaES6
	Nc2zOGWdhjSZr2dRsCEy1/6S+5NKOBdL3xqHim4CyqY8YXMlajnRI7fZdMyw6Ej+mKswyK5HRfo
	BaeYxcxuIjtst2tFX9LGiBPtY0+czFS0VX13tUcILsSRjKnTQ3z2W5utaRG2sass80/P/ucfi0V
	emUWiEyRMkiIP1D10BLwzFe+xv43YXH5Xg==
X-Received: by 2002:a05:6000:430b:b0:44b:ad5a:cd33 with SMTP id
 ffacd0b85a97d-45eb38e4b24mr40128497f8f.40.1779924771483; Wed, 27 May 2026
 16:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251008204133.2781356-1-joannelkoong@gmail.com>
 <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com> <CAJfpeguAvw=GTkWhMsjSAyDx5oXXfMLNOPGDUg8HuPRxjppxkA@mail.gmail.com>
In-Reply-To: <CAJfpeguAvw=GTkWhMsjSAyDx5oXXfMLNOPGDUg8HuPRxjppxkA@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 27 May 2026 16:32:38 -0700
X-Gm-Features: AVHnY4JQDr20gCLRHfYTawrZU6FF5EriZ3mf-jFlylo811faLWmZlWe_-2xZUD4
Message-ID: <CAJnrk1YJcJJOvZYwzR99DsJyh3dgMffEMQ-A9Rfkg2CGOUTziw@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jan Kara <jack@suse.cz>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 27, 2026 at 5:25=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
>
> On Wed, 27 May 2026 at 03:42, Joanne Koong <joannelkoong@gmail.com> wrote=
:
>
> > On a 8GB machine (with assuming vm.dirty_ratio=3D20% and
> > vm.dirty_background_ratio=3D10%), we get 12 MB of freerun, 4 MB of
> > proportional throttling, and then full throtttling starts at 16 MB.
> > With 2MB folios, the 4MB zone between freerun and f ull throttling
> > doesn't leave that much room for the balance_dirty_pages() logic to
> > adjust the dirtier's speed, which I think causes the writes to
> > oscillate between freerunning and then being fully (overly) throttled.
>
> Some handwaving: would it be possible for the folio alloc logic to
> modulate the folio size based on how close are we to the dirty
> threshold?
>
> E.g. if the number of folios to reach the dirty limit is less than 10,
> then start allocating smaller folios.

I don't think this would help for the case where the writes are to
existing large folios already resident in the page cache, but I can do
some experimentation with this.

>
> > I think this problem gets untenable for random writes with large
> > folios, since dirtying just a few bytes will charge the whole folio
> > size to the dirty budget. I have a patchset from last year for adding
> > more granular dirty/writeback tracking [3], I'm going to pick this
> > series back up. I think it will be useful generically, not just for
> > fuse.
>
> Tracking partial dirty is not going to help free up those large
> folios, unless the dirty part is migrated to a smaller folio.  Not
> sure if it's worth the added complexity, maybe...

That's a good point... the whole point of throttling is to cap the
number of pages pinned in RAM...

>
> > For getting this to work on fuse servers with strictlimiting, I think
> > the next steps are to
> > a) as Jan had suggested in [1], come up with some heuristic to
> > constrain the max order supported for large folios for these fuse
> > servers if they're running with the writeback cache enabled
> > b) benchmark ^ and if there are still regressions, then we should
> > probably just turn large folios off for these servers
>
> Definitely worth exploring the characteristics of the current system.
>
> > c) add the granular writeback/dirty accounting for large folios
> > d) look into improving the balance_dirty_pages() throttling logic to
> > handle narrow gaps between the freerun and full throttling zones
> > better and reduce over-throttling
> >
> > Does this sound like a reasonable way forward?
>
> Yeah, makes sense.
>
> > For privileged servers, I still think it makes sense to remove the
> > strictlimiting requirement or at the least, let admins opt out of that
> > if they are confident their server is well-behaved.
>
> This is already possible via the /sys/class/bdi interface.

Nice, I think in that case we can just have libfuse disable this on
behalf of the privileged server.

Thanks,
Joanne

>
> I'm fine with introducing a config option / module option to turn it
> off by default.
>
> Thanks,
> Miklos
