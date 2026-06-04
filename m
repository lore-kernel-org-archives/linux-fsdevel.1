Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6507A2253A1
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Jun 2026 07:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780557499; cv=pass; b=J/GEE/wxGIg/cE3aHt/G5S16sMMDmVeg/TnNsKH05/OzL1jIbBTbUmjgYHHPNlrdq2dbPktnbw+ep/2fQRQr/JINoaRnmvHDjsk5Tku9VfWIjU6LVEbDf5LvQ/0xiLP1cpYl1D4Dp+zQ15NaVP3XEuc5l8zNsfvQ8cl1eUCCXYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780557499; c=relaxed/simple;
	bh=tPnMC/0vlcveygoI0ctCY0usOzZIfjE5HemkDY+WbYc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7jMSOlAD9b+1aAeIrUrIJFVYrmupx2F3XnOdeFAj6LvA2t/T3RLHjHH5CgmmsxB2p2JGIdJ2q+L/BmrPr+Jjh26cyMJ5XhFn8/aOH9CREiHwLiihZjwBLIbUdmXh6GMmy8m4i4c01XKWO6VSP/LiJpbPhGEZOMfWsJyckHwgoY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=Iy98Bo4N; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="Iy98Bo4N"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-5175eab3a93so3153011cf.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 04 Jun 2026 00:18:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780557497; cv=none;
        d=google.com; s=arc-20240605;
        b=DfXM02v+5gYjgoBzcwHI0vt1Gxg5IAWg2jumgI9nscztRMLI7JE3LDwGy7gsMUmi2m
         HrzjfSt+Wp5NEPZPI71iGnRXC1G0NZuhlO1Ir/VSJYCY3/otbuJhrXWivuXtZhmAKVs7
         3J3p6H4NTp4zZhn2we999+0oQeOCtTaIre7X6hPa9/CfM4Mw82VDyP5YcTV8EihozQ28
         XEe0Eu/4whAcERo1UTFCeVXbrkyiMZh6vignLQBjwRroieMD9Qq15TLQRwPD5tU2BfuZ
         HZZc0pfEV85sYFzHjcue2aTB3nCsOJ8qzdfyBPTPxhN3DMOwyy4rOo2Ah0pbG35E29w7
         XUfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=AH/4FtqZ/8PDfc4b1rIfyYEACsJ0YQwcfNPJKh4jHhA=;
        fh=C6du2SODeIK1G4jHKI+BaYfToAFaZYgJlV3+vopx7aE=;
        b=jRD3A+U9aWfUp7Av87j3Uyo/crVnJj4w7QZiOJrQ6nzJbEoXV6AvpWsmT9YEcRQnV0
         q2ZCQIu4UOkMJA+wMqLmbFSkYD33k+U49ncJQtD70W3DUPN8qbWItSvhbT8yU1r24ChT
         NT8KjDbJZpYbIIfqzQPg0UeJIeZ6JInECrlBPGSwx49HYQ7pnZGc4nEqxxIUEa7aJYrl
         e09R4yToVD/LjpEpIJYTadeYyb0ggAXDGaQt9WYxzDLaCOZ+YGrCUM7YT+Iy/n9ej2qd
         PP3a2Pq5Q9Om/1owd2TkYJDTGwpvUM61fxjHTlqQmwe9QCSclyANtZNZjM68fTqDCz7n
         p/Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1780557497; x=1781162297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AH/4FtqZ/8PDfc4b1rIfyYEACsJ0YQwcfNPJKh4jHhA=;
        b=Iy98Bo4NcA9Yx15io5fcoA2e6QM1gGbg3VIDSj8e65Z8v0g0g+GNsm+3aSYW2HF90h
         TdUTr84tq976yOG1vdxc9kpV2PvbPB4gUd1IYHBaAnPgygiomubcmZE2qbNUuEhvdnoJ
         yEg5kl+VucMCdFvGhoEq1LnaFETnYDBHVB4mI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780557497; x=1781162297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AH/4FtqZ/8PDfc4b1rIfyYEACsJ0YQwcfNPJKh4jHhA=;
        b=Zax+DuESpCZQO1UcKFfUJBBDe5iPbb74mKAShsvdjqOaz1DZw4djBMcJwZewXZ2HzU
         RUeB+gbP2b/mC8LKPrEIMlc7nVFfwhYv+icKtgfniV4CmJhT/a7aqqucsG4P6Qd3NOwJ
         OK7hoeQH9uqH/sOoU6ndhX6iuHM1+lt502zODiQoSBGTt1ABDV2HPUyvSQDoXVcTAvGI
         n8XXnINVEhx97K7h7DOfWUyj54Cm4IiWK9QXtTz2WvcB1C5nxSPEEugjEUrNUUdzof8B
         czMLeSS9ykAZyMQ21KfWiVcIWXiVnLe6qSsflyvJKuyx3WnZoItW/surjuJIe9cvtg5g
         elyg==
X-Forwarded-Encrypted: i=1; AFNElJ9FJ1J8szFAu3fJYcg+e4K57m6NUEyy+IIkPAjGGQjFev5680covxh7X59lVRCRV0cNoT+Ef2gwU0OD6kyU@vger.kernel.org
X-Gm-Message-State: AOJu0YzDJmcK2D8ETdo9/YkpwvRu2KgPE1xPz9x7X9xLyMU6HlhFC4J4
	xqM/wi3dEWo82+D1pEfAeBNUeZCEo4ZsaVf4YNL79A5I3lmTWIozO+YEQIIfVW34vJAtv4L9MzC
	nR1WvIfyYjRSHiD70LjNTlSxrRGrtprLhPzywJXBgdA3212jAujWEwJRtUA==
X-Gm-Gg: Acq92OGRr1q/2uBo9GNNNwfLv1+Gi9qcMGEQzg3XValvU6xhyTgV/EogDdhXWfN7BJ3
	M0oa65nLDS6pXC26HVoCGplJQwseZexp7h0K2QlG6Ijib2axIbmjUIYoziBvkRqC5NLgH5bdHif
	xEezhlCbfwgUAVwc7rlg28+Gq4zmOHCiBMimYBApgu97UjOVt5pwscVP+X8FLtFFc7x9TZIxJWk
	XlJ1RvQzrXN4gckeEN5Njt+Kjs6LyNPJpmjIbe7SdUvWNGbYavdqlYyBkB8p4KwEseAPwm+5HyS
	1l+WVDuCrAirYcJmnfbGJLgaDQJ4kJK6S6DdmE1BLhig9B4=
X-Received: by 2002:ac8:580e:0:b0:516:de59:4c85 with SMTP id
 d75a77b69052e-517786948a3mr92857481cf.37.1780557497439; Thu, 04 Jun 2026
 00:18:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAFbF8N7++zopZuEcsKRxBV_sgOGCbzCY0hOyMw1SiGAtuzGhyQ@mail.gmail.com>
 <CAJfpegsCJnMfn_BzzTK7m9ndCGVsnPit8ZsT0fzAhYoY+yOsKQ@mail.gmail.com> <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
In-Reply-To: <178035740095.2923901.5908691318688917347@noble.neil.brown.name>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 4 Jun 2026 09:18:06 +0200
X-Gm-Features: AVHnY4KDFLlajvFCH3wTVGx_5fPbucIySve1QOGHJ35RS0MmXWDSF8kzFInRFYM
Message-ID: <CAJfpegswAZv8OmDAcK-5u8kssAF1vZKe4gdDB2XPErAnoGFSYg@mail.gmail.com>
Subject: Re: PROBLEM: FUSE_NOTIFY_INVAL_ENTRY leaves stale negative dentry
 after c9ba789dad15
To: NeilBrown <neil@brown.name>
Cc: =?UTF-8?B?0JDRgNGC0LXQvCDQm9Cw0LHQsNC30L7Qsg==?= <123321artyom@gmail.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jun 2026 at 01:43, NeilBrown <neilb@ownmail.net> wrote:

> +               if (d_really_is_negative(child)) {
> +                       spin_lock(&child->d_lock);
> +                       if (d_really_is_negative(child)) {
> +                               fuse_dir_changed(parent);
> +                               if (!(flags & FUSE_EXPIRE_ONLY))
> +                                       __d_drop(entry);
> +                               fuse_invalidate_entry_cache(entry);
> +                               spin_unlock(&child->d_lock);
> +                               dput(child);
> +                               err = 0;
> +                               goto put_parent;
> +                       }
> +                       spin_unlock(&child->d_lock);
> +                       dput(child);
> +               } else {
> +                       entry = start_removing_dentry(dir, child);
> +                       dput(child);
> +                       if (IS_ERR(entry))
> +                               goto put_parent;

There are still races (move out from dir, unlink) that result in
EINVAL and ENOENT respectively, but AFAICS these cases need to be
retried instead of faling.  Rather convoluted.

Can you explain why exactly is this needed?

Thanks,
Miklos
