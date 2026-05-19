Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6194F340419
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199945; cv=pass; b=LB6L+I5+ZpYNFovwRF1bnzrWfaMFLqa8aYJpNBbdqkDTzeldyFWjcIniiWPjHfZgLYnQRueBsJ7NYCrz8Q1YM6Eb/kl60gYgxEjZO756toOt3cxx/Wvv22b8JkQJm0UX/4VJ50WRyg2sgy3fegYHfxRHkdIS9Nalax8+mpbaCdc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199945; c=relaxed/simple;
	bh=whO7YAb0sWqd5LNBElkzPg3UvW0e8KJGAEQaNkj809A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQLWs2aKO/fEiB4G3QdgP1sgXWZzPz6Mk9jPbmxnJmSZQ3Hprv7kUpabAFE6fbzobWuT4dvII6fz8flzvjZkXp+YwbKYLnzkbb0VHjZiqFqANPqW/kHruwjxqCURqidRF3fkZRtRX9dLOlvzhaKByJD1jHeFP2MNzVRx5sLoUZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+7INmm2; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+7INmm2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso270a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 07:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779199943; cv=none;
        d=google.com; s=arc-20240605;
        b=LDNNKSKAqhb5rlDeb9Pe3V6dxnYAiIQFwaacI2epN5AU4Ro6WErlklbyjVXsa8S6jd
         wI0PCoZb0dSTm2zxWcR8Uj7MY7giejkbGt0VucNsXhroIA8+IVXqsxE52jXlD0dsgw/f
         HcNEHN4Yuvlt23rhSwTNZQNBd3QoOj1Rms4Sk1J5Gp+DjGXzIW5LtEE1fqdNOkhzIX5X
         iw2SGIztXlBu6BTlwrs94cWAT++Y6GOL9JPnU4RBhGJwLPbBOiTFKO2PxLs3SwKgODcO
         Kb5MumBOeQ5bAmIimDaLz7nDTukc7Z10BOWF+fTrSzRxzMX/y3LFQZz+cn/KnEjHqCUE
         ltFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        fh=HDLyzhThvjTXhURtx7t1y3MQoSp8dzGEzJ3Kd77AEkw=;
        b=b18j3qaEYXmvuecos98V0PAOREA3IZR4mFVIuipXsOtEXzGhuiDbPwgIkCJ2ORwgD+
         Kn+TXg+/6miCHIZBle89X9uM27PWkqPk2xpq/M8pPc1T+uuFTdF47y4Vfgx66yEneRb2
         1tiKTwlF6RLkx3ThrqhieQS1VZLK4zYlIwE1SqReD9ytZLZ5IFlYFMY+YzrCzrvqw7Bk
         WDRFPHRnnpf93ByQNJr4sVnm8cTJVmTK2KvFg7leLoBubQrG10Hw79P7z1PRu1xb41qw
         k/PtrEofcpF1qbL3lSjdF7siSCwozS2+4ZsQA+lKb03Qw43sv7n5A919VXG9gDd3UsQP
         wIBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199943; x=1779804743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        b=V+7INmm2JEClJfN2MwEtNRWWNbaJ4FlHRyBoUwL322w11KUeAcOwePUHT/98Qh6olF
         uFMYrdDvOe6EEkgTi01nA5O+vdlbjBhiuQFw9y1u7OHMr+atlr7bIdWukIhM0ZePv+D8
         +JmrlzDZhwcZcxlySO7724hdGvBr73vFNa2WEqO/RbyB+cGfiHGE498yn/3F2lxfHJjx
         VxFV93cMgG9vW+dHaF7LTFcDv/pzdEVOxk52nmgAtqyYJKlsIMOZLBuR90mNCJVSdojt
         yM9svAcTj1Q21SNy1q+v0QR1iHM+yOE4He+UY0RnejLcRuF9P+1dVn7ntMpIFWW/sfpx
         DVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199943; x=1779804743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        b=WuFEkHlMAQJ0cWPQhwQ3+e00k/jeB1kOiRWURHiiJyglK2gB7aZlMpxKulHks6EGzM
         jsOFun9IerlJTAuqAU0VpgSnp8VaG2pD6st1AykPnH1V3C4hBnAPaTOU0gvFS7R4Xnc7
         SZ9tmGMSy29VHhSTAZdRx1NEoy4zvIJJ8fzbdl17L+ebkI2Dl4gOnCA5YI7wbHQA2IXV
         WGuiwM7SklHXjtWBNz8Bs2HUeHdAs7tkbTQd3qco1/py9TAp5vav9Qk95oLk9Nxvsydq
         rAaYrre0E/cqrr9OzBJmAgSGWtJH30xMsQXURrxqOD65E1JANnsEphpgxN1pRQdZJRf8
         oqzw==
X-Forwarded-Encrypted: i=1; AFNElJ8lmqWCPvLRPxG/2OFnibA6fh0ewzqV4eTA5Sji8Y1HZd0f0oLndJrNdLVlRM084MfPvtIn/LKRKgy3Jr0f@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4uucWql16/qn4BJFmrN3sxJt3cC/Ve3g+Ki8uQRLbw7BsO27
	NZrqDoclYdKxXf9hlgB6C5h6TWXjRWOm1MJ/RQgY55i0G05Va/lsqcCrZKE90sCwQLEMwMumQeH
	ThwrtWFh2EN8fx4s0cbgj+a42SnoxsOvXWJh2lS1B
X-Gm-Gg: Acq92OFNE0b9czV02qBoXFhrPg058Xr+jbnKlOjn9B2x4x5Dau+kaSZkxi80KJlHKg0
	oz4B0I7cdMNavT9o2P+sj2adZJvGnyntXc7KlwS5gG3n2xzgAqMiRiY2azmvWI6FWkFVmoAt2cI
	OdlyUF5Ym6wLhmsa6Ig7ir0YrATYJroIws9rdAVGh8gjdYMK1B1QONx06s6r8lf2FdhHwPM4Xux
	DUqFLjFewXAu75rwoHTOE3oB2d8pg1VN4sH464gRUQNuQCAuO6eTwk7z/7L8yUleFQuEbf6DnNF
	JsVQBL8yd05W5X1nnnk/CcrilmxbXUAgJkP+jzrNLAbY3lgo
X-Received: by 2002:aa7:db55:0:b0:67b:6dc6:3a5 with SMTP id
 4fb4d7f45d1cf-684986effeemr78445a12.9.1779199942226; Tue, 19 May 2026
 07:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com> <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
In-Reply-To: <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:11:46 +0200
X-Gm-Features: AVHnY4IC0Nb8ZGebLrWGuDuCoZnifzO_29zTNKSpR2gX_4smRdDNEvnUWhpnr1M
Message-ID: <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 4:07=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> On Tue, 19 May 2026 at 16:00, Jann Horn <jannh@google.com> wrote:
> > The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> > FUSE daemon to actively write/read pagecache contents.
> >
> > For directories with FOPEN_CACHE_DIR, the pagecache is used as
> > kernel-internal cache storage, and userspace is not supposed to have
> > direct access to this cache - in particular, fuse_parse_cache() will hi=
t
> > WARN_ON() if the cache contains bogus data.
> >
> > Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
> > -EINVAL.
>
> Good catch.
>
> Shouldn't this reject !S_ISREG()?  Symlinks also use the page cache
> and could break if overwritten by arbitrary data.

Should it be `!(S_ISREG() || S_ISBLK())` ?
I think block devices are supposed to act roughly like regular files
in terms of pagecache, but IDK how that works in the context of FUSE.
Let me know which way you prefer and I'll send a v2.
