Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212444AB68
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 08:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141171; cv=pass; b=B41+8Co7o8Q2K6jL4fmc2110pucDcLErCkHEErDdboPOJRJUnLxaaCTPsgwJFqfVyCcTlAWG8KW13pT4lAVjg4U4i+AgI7yZpp0tldIpv9Oj3BNnFSg1boT6MTGzFAFVe27S5e0iFGNPOGAxamWFHx1zbJx8yCS8SBGPMiZEI0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141171; c=relaxed/simple;
	bh=yT4fNRH28Sk1sBZ6mVlpHgBhbu2LgeUp5plOLVqVqCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Am+5Mdh7jKRNdAwvrA3ra/vALEMCgLwjAC8MVr8HdgYsxEVjbOPdwUcbdsqEDQF9uWyGejuiq6Q/sz0d6nJ3sJa9a2jA9oK1wFmkTzB5v3Ew5ZncDFXS3KDWYjua82BndDScxreRzJB1SsfEOnrrZoPceEDUXQfdgTAvEvdc4ZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=AP9mRmfB; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="AP9mRmfB"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-533778ab0bdso70863121cf.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2026 01:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792141169; cv=none;
        d=google.com; s=arc-20260327;
        b=HJ+6XMYSwylC5sox9dz2MMxf7DDaUNztOpsNrkjg1UW1iAJ+BvMvVdycxghqpo0UPU
         mfUa8K0fRrcu6RI13bK9zrNf/5xFVQd9j3aqkzhlRI6gKptx5M6fXc6G4a0b1Wqs8vki
         GcLdnRbHIvbENLXXtb06auzG+rRN9bLGnIqSZKFb6HRLdotl0MOzgeZbnw+0D5t60spT
         G1ii/+pBh0mkBmI0aOMOvuy+mmDRwEWJe/eVDwqXwr/HUfgGFb0ol97/IOZGyer9+R4s
         PDwOyZm9WrXiEMwWn69CZ1rwWwCmZbItxyHkNHxAhERlzFTmtctaGD/zlsSEVL7tXhCD
         Z+og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yT4fNRH28Sk1sBZ6mVlpHgBhbu2LgeUp5plOLVqVqCU=;
        fh=dvma0H7wEzUVxpn/cdItuPqdBWV4r+ZtP6WHX5LqMYE=;
        b=YFuSMnSgAbHiIVBhfbqkvuBUvQeu5kfjpDpGkwCx6Y4uSmZ87iiU/Dk+McMZHfOVwF
         p+mV+hbuD1UtlPHyfvrSVsL0oFCK/lFP5RvekkYD7SUJJV1IbSlEy4MD8gcG8zDnoche
         Q7hwvjjbxboThNxHdoARgkcB118mmihX5YSL0mueNfZe+UyJAWmnvymwj5SVkSf71sSP
         0pL4VfQaPYFNLC73NRJzO8pFNrMMl54/+JBFkaELtW10lGd0NYQjZ1QtN3G/rfDjAYQw
         6tYZwCaXIF/gE4NPIiAj2t8cCNUYdEccd7w94HgyNQkwuJLV+7xcmwtP/ma3nbWNpCRw
         sC9Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1792141169; x=1792745969; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yT4fNRH28Sk1sBZ6mVlpHgBhbu2LgeUp5plOLVqVqCU=;
        b=AP9mRmfB0tN2vqd3ND9tkHgdtm17ibVX9xAsFmSGAqbyLxAd6cNsav3AkeIr7xsC4y
         Wl/dO3qALT9/4qaw2XDi6C7jayAbGJR4vqEF61AGPcoYgEhe1u+ED6/GtdHZ9xwM+g5H
         6em9wWPVeDj/3Nrqs3POqLd5GnuUlC+y9F/6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792141169; x=1792745969;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yT4fNRH28Sk1sBZ6mVlpHgBhbu2LgeUp5plOLVqVqCU=;
        b=DuAfFHWchYF0BqnAaGlQ9lLoQx8+wOvI0DVRdyPb7Rw09Rqc8upKv6THC+gl+PMaar
         m1oXTefXucTTBecelHtMqp3+AkTmUUXUg7wzxPumCZJYqM0DPML4Mw1dM6+hFd5j0ll6
         8JvaThRPQu49VInk2OjH6/WlH4lRgS2dPrMJnbvosdgXdnG7cKHpOeJqJB8UhRPhDNev
         oHGpxKP82/hTi/A6QqH3V8YJA5z4qFlTl/cFeNEfij6HjSSk0mV68TCQvQaTcDS+MGn3
         /umdEWATBWU8ng3+S2LYMeEoDSSg1lo+kT4ns2dgjv0meQ90QaNibl4zL2q04AJr/F4r
         5SCQ==
X-Forwarded-Encrypted: i=1; AKwUvBxe/yjJ7P51b/sKIQpmjUcvehNa+9bfq4331RRRF8/TYfkPodfiVwpy9PuORDLtqTwh8Fu3eKykkOJYUSui@vger.kernel.org
X-Gm-Message-State: AFq9FYLbYOPBr8t/6bXOPHThjnZ2qCHpxcemFEgSB1LaffV/sgXWozlq
	o6tUUBZ3DyRdW5JH2go3RgLEj4UPaY3Kl1qTQabnpymQhi83gvXZxLfl+NAjFzVknn0HmIJGYpg
	C2Douid8qGI/twvz71qxfFr49uStZTccAQW66Y46dBA==
X-Gm-Gg: AYBFou3TIC8TLEjF40u/XuXAmoPUAuXcaYQzg9VNahJTLGZEK5muE6uszZsZEOs/XZU
	XUSxy/74KXFKzDckAMJMo4mTnXZbAcLZgykJoSfWMUf8CdyMAhK++6BaEiPsNJs/FBS+U9wslLR
	972dvZQ2BPrr1M3nIBKBZ+7geqh3sglUj0sdboXI+83dRDKn4KvX16QcOwJEs3SG93z2L1vFFXa
	AltPu0w+TeYYBorzMY7mtN51UiAy0+mvOdqREy3D0z1MjMz8BF/OHrYQodD5/TCFsgEvVQEaMZc
	rcP6251juo41qT7cDBF/nBBJZ8HKEAjfS6WJzDluxdkPjwfkn0bPvZVtSj8YSl0fBBSjyQLXNkU
	zATN5Zbo=
X-Received: by 2002:a05:622a:1804:b0:535:a5f8:a5c4 with SMTP id
 d75a77b69052e-535a5f8b53amr352445591cf.68.1792141169297; Fri, 16 Oct 2026
 01:59:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820130158.254808-3-jamz@amazon.com> <20261014200112.1363344-1-sashal@kernel.org>
In-Reply-To: <20261014200112.1363344-1-sashal@kernel.org>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 16 Oct 2026 10:59:17 +0200
X-Gm-Features: AclHuK8plkUWG0caIufFg1j5DIBTkx_nzXhY5cYIKKqxQ1cPSAaRX-yvQIYuAck
Message-ID: <CAJfpegvGBZaEw_tS-EpOKMyzb-AG3CYBG7DwbQQa3280fRNQRg@mail.gmail.com>
Subject: Re: [PATCH] selftests/fuse: add the missing FUSE_HAS_SYNCFS privilege test
To: Sasha Levin <sashal@kernel.org>
Cc: Jimmy Zuber <jamz@amazon.com>, Shuah Khan <shuah@kernel.org>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Oct 2026 at 22:01, Sasha Levin <sashal@kernel.org> wrote:

> Add test_syncfs.c as posted in Jimmy Zuber's v3 submission. The test
> talks the raw FUSE protocol over /dev/fuse, so it can choose whether to
> advertise FUSE_HAS_SYNCFS and directly observe whether the kernel
> forwards a FUSE_SYNCFS request.

Applied, thanks.

Miklos
