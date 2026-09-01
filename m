Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241F545DF76
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Sep 2026 20:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788295923; cv=pass; b=aFOXm1919kAIEqcdtI+cgkqfzAfEGQj/UhROevTZnrlLhNxw3VkEa6irF08xErwl5y7TVgw4otPhhMJL86gVUQ9qFMDHaiAIQmnjkZ9ggsIls6tun3Y315L86MiLUq2I8Va91iqYVi/6Qxrzy2prQfW0hOX3yEJzxAZgphXn69E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788295923; c=relaxed/simple;
	bh=bATD+9vMV4i+DVgqapoexuJGpF5giIt/ENW58o2X+38=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jewqNdCSDMk7qL5XQY7POdhumu5yxKZngHwr5OMS59rrDDuLD/SkJTWnuV8RO5F2ky/rMZFqXAQv+O7nhiSBpsCtUzIMb5XRDzkUfIbQgx48W+ZoboR9S71zQ4PoTYDIG7pjx0V6wl9P7g5Onpkv2JeHElM3+o0SbRy7+VrKERw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RVEMNf/Y; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RVEMNf/Y"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c1c26d7e951so35027366b.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 01 Sep 2026 13:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788295920; cv=none;
        d=google.com; s=arc-20260327;
        b=pPUCftdNcbEf23VqIhRv0LcVxT4KS2v/4eVT+AmbEbMMDTbOWaXvRI8ZOercQ4rJ7G
         0OQFt2yaCeSDKA7rUXP5NxMPBTsjqpLMDtEYZqsiijVRIeY6YEimr2/2S3RZqOyO0qsy
         01dh2oCD2jY+YR3/DBbPci3IhoYOc34iz9pFBvUBgWj0ejtX1bPEMJsrvAOvBnKh5Era
         LA+OOKtFfWw3R0pLrg6mywHmC76TD1+pwJaUSQ9gikbB1Pl8y8vhv40sqrxq1uHsE598
         Oi5tOhd19svH0CduUCNzMK11wzhMuYcnrh66asYoMwEV8h7l6eQChJ51xErO65zUBxDh
         L1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=bATD+9vMV4i+DVgqapoexuJGpF5giIt/ENW58o2X+38=;
        fh=J9Cq3zCtZNpG2ejVYyPs2GinN1u1GtGOtKon4nkMlIE=;
        b=ZJZLm/FcYCQ+YGIjmRmk+qVkJzhB8Auy8eaXVEWJ3iH+qf7gW2JIPNf/wZVeYfqkjA
         CUkfAJUnRTnfTQsCOnI7m7ApFcGW+CViTg+pj57Sz1UWN0BcydhqZtyDsOs39VH97m0J
         aiUXoH4kkPUKNtcMcAVRLcWgwkzoHylL9GZq0HWCamEvbdJbOhqhPMwDVAOCOn/3jHAX
         /cfelECXSYvVELtsFFNGsUhvqIavz6+dY7TBN4SJa0SZu7d3whCcRi7pR/ZmSA5zHq9E
         yd0wAQ5SgVaGDATa+kMkt3YsoXOJ9aASAB1uU57z9efViIsnX4le5i0pcseIHOxMA+II
         pjDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788295920; x=1788900720; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=bATD+9vMV4i+DVgqapoexuJGpF5giIt/ENW58o2X+38=;
        b=RVEMNf/YUuy4lbNYju7Hirs/vvWWLHjupriPAbhvWSA6m7Lt4yO+Z96J6s6ajTbhFt
         uz3CCmbQjHTn4JZUvKALazd9935hUSpJ0z9fWTEMAL4piUGBQoa5tj5G0gOAVJueBKGo
         SpvvLjtaOCJzXbDuces+5Ewku01s2w5d2rwZLp2qU4HHSfsybRYMqoe3UA7bve9n5WCw
         bpliofH0sL3IuV3Vco+8ideVqfK+pGF36uy387riVAWf1qtQ8ogO9ocimAjF5mgBWTGL
         wYunikBtRnRZwvgU5JbS6+mKBz1wJABVHs9Ra+7iJ4Ot9HV+rRFeiMRl2xpQdkcB3p1M
         UxKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788295920; x=1788900720;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bATD+9vMV4i+DVgqapoexuJGpF5giIt/ENW58o2X+38=;
        b=a0YrC4ZjTzaBcFq2mN8mFNxZ3acI7v8wYc47g/892E2XMz1xpAfH6kWKS3dfE/6tDf
         51uenbB1rZioHZCE1ROuk4YfeunmWziVxqP6JaubaWoFHAb9i7DkK3tADUXJ+n7bzctA
         SpxDMAXtiqL8I9BRwfd4MLKozE3uSSghig6FQblOimfV58XCVlh5xvdgzFJ34iavO7qU
         ZQcM7EmtXjzl8nS6l2BJEles+rgiNDQv+nXpiTOhP919EeLawrJleDFNmaK3GKN9FQHd
         Qv+p8IKlRb/rh7OhkgZ0nUKBSWk1CWOpgU7e40Ca/y0ZCIgZXAnnPxDkQinjc2qfmcWv
         UJPA==
X-Forwarded-Encrypted: i=1; AHgh+RpcQuBcO2miiCtIiKfGCWXjiCVbe0dGnsvQVnLI7C5DndmeEMvrRimKEusCg4XsZ+RLa7/HXWD7iAQlo37P@vger.kernel.org
X-Gm-Message-State: AFuF++mAC3N2VOvnTfpF7u0KXd/nj7V3lC/IfS++OWXxMJXBjpnWrR1P
	9uwc9swrHbRyVzXHvsj3brCgC0JJBX4S8xPYkSe+KiC9ZxRT7pjbbGYd4vXYHfyEZ2nmYMRV2A5
	lQTwoUobEe5AESeSENdRzZCcudMe5bWs=
X-Gm-Gg: AR+sD12Q5954V3J0bmxqvt2phIaSae+0Hat18E4B78DUTKxG2pUgRW/Sdd479kn3+n0
	NCEmhW7DCsp8M+OABjUL9FinCuUlqsHA6D91iD+gxGq+wrCtlxroCIHwnL5icojV7dDJLekcDwT
	aHzZk1nUtP3nNcmyAKUeuMBm2ppkzVwHPZsTqtv3AZCoNIBsTNvHHoT0dlWUL14CJmH4mWu2zo0
	yuNTY8cXXS9dgERXQEklTOc9EVgNj6wtPtczObA4qi9VxQPKyuLYHv2NxyUk6y5ocRetjs08HDI
	NcMG5CeGrD+aM2Ikv1MKjgCT5/nfhDEfJDxTK32HyQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:907:d01:b0:c25:9195:6ece with SMTP id
 a640c23a62f3a-c25d5597b78mr2028666b.23.1788295920040; Tue, 01 Sep 2026
 13:52:00 -0700 (PDT)
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 13:51:59 -0700
Received: from 292895732794 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 1 Sep 2026 13:51:59 -0700
In-Reply-To: <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org> <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
From: =?UTF-8?B?YXloYW4gYXlkxLFu?= <nsd.project.dev@gmail.com>
Date: Tue, 1 Sep 2026 13:51:59 -0700
X-Gm-Features: AcwNN1W6fGPmdWB07o81OMVzEMGuQq_mleLKK15ow4KEIPxh6simphC5SxUnMtw
Message-ID: <CAFLp9PFH350y1OYpDOAuTETMqGf_akeWBMbgoBh-A0R7gYP0Sg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache prefetcher
To: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Honza, Hi Willy,

Just bumping this up, curious if you had a chance to look at the
window-size matrix from the 19th, and what you think about the three
questions at the end.

Happy to run more numbers if that helps.

Best,
Ayhan
