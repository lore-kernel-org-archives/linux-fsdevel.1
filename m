Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6522237F01A
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 07:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792137581; cv=pass; b=SIt3hhVxAXV4gBT+be1od/7DdhwqySp9xSC+p7R+EC8zJr+UZhXSV9Jj+QfS7O5lf1UaHE97AwFNlGuLLfBWwoV+cXWpbONzKQH6j4e8aOrYsCyKevAGgk7fthC2aBgSTI6o/27l8bt9kCLjpV7Y6RzbLAf/xta8/ZidEFx729Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792137581; c=relaxed/simple;
	bh=9bth1vD7yHDRAYYXeuMH5rIgXb7rCuLzadFyMCAZY5Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NRky7Rn/cTzxrgkfo304W/YAPzSlNh7MGGC7hOd8xdTm3hXnHQBFdhx1NdvdOmcC9SWweK+B+gTp2faZR5DDWFwwu1CNdH/COyAkCFKCgXM80bc7A7sVyphwcu2X1pKy9yrrwuiDMj+oo24OuFqOXtXZEQXhSpPQbqPv3Vc80IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EssNCZU2; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EssNCZU2"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6af9a90e4bbso6643907a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 00:59:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792137577; cv=none;
        d=google.com; s=arc-20260327;
        b=SDEbT/HjOgxqfBZWUm2zm4LFuKA748CBNnoGchfG9CbaMRtDOqkXZytnFjFKlv+c/K
         q8aAYbztq9cBippTv4bI7JGosf6tX+g+Re2SC+44t3kmNX0icmMi6aUsXVjVJ81d4bNs
         AD/1nosB4kSBlx0Ls4UeEibXA4iyTPyU6ykr1SiJY/PGKtpQVX9hAuqT3Teh6ZDAP1Ey
         Fmoj+MlGuvbakAPUViliLL95iLfCov48jLHQeKpTCnESv9gt/XMesCB8g6gMvLysgcVq
         O9WDYrNNkU0iTKMDAfuOZtwww887+RLyBR2amghH9wEd1lLak0L70kT1gpqY/fPWljYH
         9grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CqeWUEBI6e0Y684j10gyEkaIDx00oGMgtXL5mTvqppw=;
        fh=FIZFloJ4h1MTUOeRziXWuVgCb8JmaTT+La5R+vLLvoc=;
        b=SbaNhMcIeeykkhyX1D8aZSS3XsWjr45srwYCRCKkExSJ3elAxVrHpSafTlWPV8dRyS
         4dSqc5UowD7XU4Uq8+8otcC74gDRWEJPRgIBVWxMyA2hyo5CDEI4Lp3QdiAhCcXkZURS
         y+klQdpM7z5piJ6PsLIQOrgN1VGAK7MD09Z3wixxPjv2f+t0Wa7STBy8c+7TzkA5+Wpq
         3F7uBqeVmMY+yLyoqI+iSlXcJarrfkZjWnAOhOUzLM3GUmdhyKieNIYoB0KnwFF88A8n
         7hvB5vcLAGE0sMbSuAOM1hzR76HyWpXxHRYLql8VpyuQlQ9ieXSRTEMhn3X12+DWpyxq
         ZX/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792137577; x=1792742377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CqeWUEBI6e0Y684j10gyEkaIDx00oGMgtXL5mTvqppw=;
        b=EssNCZU22L2PJ54SA3PCvPhbTm4N9Ue8uokPDwtgECJWuzCx0UsehkqK3nxVmZ3sF8
         cpwy/x9l1DH3J5uhVvjcCAwRsD3fA44e40rrZlbRjKMt2b1tpg0IpBqi53l5Wj89LtRI
         DsUp6DRcG0l/qKckcmSbqbI+pgfWp8wtHNXZDGlzaPO99au1FitEVyEv7EfdvGo1lP+G
         zaaP/WpLavMMhpvPCZ31K+g6b/7NtNnvBV9DKdm84DoUBW+qYcAcpQhRR5bc48hj/e8c
         uxCY0+wN659f18zIVixG03TXiWgeY+lrG0+s9JgfXtuYHXku8XoVQ4jjSjQhyKVg4vPn
         yMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792137577; x=1792742377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CqeWUEBI6e0Y684j10gyEkaIDx00oGMgtXL5mTvqppw=;
        b=yC6OVGqCGeJsAyG+ycFebs+OzSQscYeSb8VVxKU9U9tRmOJqdhhoZGGAUhIUQxNKZ5
         bIjDvEwi8WFiMYaJ6Ppo+CgBz7qV1w37cjcmtRsZ6PJzGGxdDeb3Wq2a7ghZ2nMnY2Z+
         lS9CnoJL5n9AByoh8JU5yvkgz5SxYkUzwRi+hxrZanUIXLozULxTIe1YVysIQ/lf/hvr
         OEEGOm9yfRHM6wMXj6S81FeFICIGS47Nqn8y3qHRKj8J60XEghjsJoOr+mEXkYR5Pj/s
         ZK4O+LDI3jXJB5LMxCJUWaJZN5lwxP4tc1ArYU66j4Z/TKzs31EQuc9PCY/Bu18siiK9
         ZcJA==
X-Forwarded-Encrypted: i=1; AKwUvBwoDlv5byFA0FVsVF57v3+HalDYwV+q/vO8LB4jYqYp+pBTfvQypEDUNzl66bBQN3HITMEas9pNQ5gybASj@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1ahymYMeIV28ki5W9nv4EbRSZAf+jczCWsUGHm3ue5qKXsvqf
	p7hW5wlttLZe7mhCsucoWUluAOvY9nCXrtBDRBzKGbPXl+VxCUeA4FCxQJrTncdclxzREMv6TJT
	KsDDi4rL6n54UpxaTK7XG5lhNRD6C2RE=
X-Gm-Gg: AYBFou1wGjcB44k2fJcWLcSAv+RSGcdV7x0Iddbqy+DWpLCvAsEb5XjNPTKpH8HQAP/
	aB65CSg+rAKN0CXTGB2mIyiHXw46r+MkGVs//d7dynxOhbv6K0N715yjNNEXE4/8CWhawDmAqOj
	J01dTXnpq+5UHusKvAa0krZ0pdUYpDzt+jpQsZJ3VHJKe7aRkn2l4nTtVvWJceSj/na1WWIyzDm
	8IIK0fCVSXD6FbPtgfplHENF8GXzvkISFbNxr6/h984GsvAAz0xdkSuuJY6NU+/g5etTWKZll7b
	t9WhLY3bLv/e8+/E7oCWjggxdQsVajaVZ+DeAchFlQwCG5oLaupMgv+JyarnMnBefEY=
X-Received: by 2002:a17:907:3e05:b0:c41:10ca:b4f9 with SMTP id
 a640c23a62f3a-c4110cabb6dmr32561566b.20.1792137577402; Fri, 16 Oct 2026
 00:59:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxhX_neohTAjZDOT0oSWC-JNiqNWqnfE5YSa7Ln05QPQ-A@mail.gmail.com>
 <20260824204534.1951414-1-fahad@codepure.com> <CAJfpegvbvmznSSdjZH_XqrGZHWgwb4fGux80h02ncopBC48RqA@mail.gmail.com>
In-Reply-To: <CAJfpegvbvmznSSdjZH_XqrGZHWgwb4fGux80h02ncopBC48RqA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 16 Oct 2026 09:59:26 +0200
X-Gm-Features: AclHuK808ARhKGpUcEpEJymoXXkrPYwYvO8--c-MHfLrBM82Xx-BFnxmgYwNSJM
Message-ID: <CAOQ4uxgZRdWYdBCqhbz1FyH06WM8cLub6ysbqzP05FcAyah6yw@mail.gmail.com>
Subject: Re: [PATCH] ovl: fortify ovl_copy_xattr() against underlying layer modifications
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Fahad Alharbi <fahad@codepure.com>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:21=E2=80=AFAM Miklos Szeredi <miklos@szeredi.hu>=
 wrote:
>
> On Mon, 24 Aug 2026 at 22:47, Fahad Alharbi <fahad@codepure.com> wrote:
> >
> > TL;DR: your patch fixes it.  On v7.2-rc6, FUSE probe LEAK -> NO LEAK, a=
nd the
> > unprivileged tmpfs racer goes from 78 of 5,000,000 copy-ups leaking (5 =
of 5
> > boots) to 0 of 5,000,000 (0 of 5 boots).  51 of 51 functional xattr che=
cks
> > unchanged.  One behaviour change worth a look: under a racing lower fs =
about
> > 6% of copy-ups now fail with EIO.  Tested-by below.
>
> > Tested-by: Fahad Alharbi <fahad@codepure.com>
>
> Thanks for the detailed test and analysis.
>

Sorry guys, I guess I dropped the ball on this.

However, on second thought, I prefer to break this up into two patches -
the smaller backportable EIO fix first and then the ovl_getxattr_value()
bigger change which is harder to backport.

I will prepare this for ovl-fixes PR.

Thanks,
Amir.
