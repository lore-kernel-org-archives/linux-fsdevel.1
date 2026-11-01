Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793553395;
	b=a8y/Ep7L0g7fazY5SkQEDTO1/fRZUCMvnSbkhSi+P8a6AuLRfm+xEqKOjSq03Lm76zEt
	 7FpNm8vgSVxnAZGRjrlsFECqvAsJXiDWMSDVO2rqLLvY88JoXLvW3IR1YeZz6aIexTMS9
	 C6B9WlVWQGE6Ek48As4NBYONLtFM7z6/D+Ne/wrDEcq51yeyOQMxuMegXnM3piEf7Me4C
	 qUQX0MZ0tjvFcQhoTwhQq37NxzMMEF4ahRHQXim5OCx7DtxtgvLZJst/+vmnQo7ZwFN1i
	 gJ5YHLyJ/SZS6UMipublge6NQ1IbDDfVYlL2O1INTak0J7EDhcmWQIMApAMYGNrmRRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793553395;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=stfMBCCx0iYEkgEJ5sWasY787cUVg+XUdXtndqYjb9o=;
	b=qPPxO37PF754gue+9FgFwSUoq8E9fBoEL0KIuCM85e61wTnRfkSdq7xhfTvZQf6PIWF0
	 VKXljoBHTnQwyCUK1k9iSabnz6RuMrlk2+yeuyG7HhIkECbRME3BpVBb7GSdAZnJe/yTc
	 RZoE31zWJnH+zccFtSw7047MeAqSfABKbmFay+3LYlHGDBKJ15GyVS8I/uDMvSiCsec4+
	 FHCgv3E/Fbkw5K3hwY9bP5/Ixb9wNpPE/+FmPlXGhIxk3Dtzf4/IIyal1k4JB4jfEc8Rl
	 bwLq/PZgu23apdZ2TvYjolqKQjI2BPtXbFlbRvhoX3msqabBHn+2S+6zJp5bId0/lUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RChZxMPX;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5476E606A326
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Nov 2026 17:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5476E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=RChZxMPX
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b45f9ec1ceso2502903a12.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 09:16:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793553393; x=1794158193; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=stfMBCCx0iYEkgEJ5sWasY787cUVg+XUdXtndqYjb9o=;
        b=RChZxMPXKDLzYYACq3chREkiKIb0aetrLPk8ZfDlowgOHFn3O9blU8jAseP9Y1WruI
         ynnLVRYWp/d+FYGTR8x/H6JXwHGjt93UXp3sWClya1GJO2J1d1dALQwUT8qBO4Yy4wov
         Qxa9M+Kfi5RSNYeie8oIEkYuYnYR0VEJ1My9I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793553393; x=1794158193;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=stfMBCCx0iYEkgEJ5sWasY787cUVg+XUdXtndqYjb9o=;
        b=0yXXyNaVuOq645i3F4BsHxEelPurwPJFI1W/UQ9WxVI2O135MAYN8Wle7lf1WMvgQR
         ew4fC53mQFq37hZ1/GjzKFzDmd1xXJlJIWX9cy8HtqS8AbZgqYklgkZd2lkPiJDcifWm
         S0Xi8YIuzGBsAiPPjeLN8aSsSCvk+/QrxLkFPlq0XMfDqMTvalbQRHm3mBxs6+XYiURR
         7E0fxQdRDxnSzTnY4Oj9h+63ZIRmgEkl0SI8fkBkE5sSJCDcNYcsmgi+OR7JGxmfrmg/
         xMBzRA73uClCpMhd3HAXX3c2CQEJW2UW+SUHE68fDGEuQdK7cTJteVwy5PIVa9Yri/5Z
         fHdQ==
X-Forwarded-Encrypted: i=1; AKwUvBylvok1vNchrEYsGI2u7HQ25kcE3NfmniK90jw0d8gqQgVQyGzCHLitHOnGC7SWnDlaPVaghzXZCShkD1vI@vger.kernel.org
X-Gm-Message-State: AFq9FYLpddrhZw1/A3RHo0QmEbcYA/MerRxgN1KGCgbJWWOVTG3eRxjC
	986na+Q8zV1m7j4IzNktv67JxgbjKCC8xwr1szrhbnS0BMzHyuIGCDWQ0w6VCxzCUlBUAnvhCf4
	Lram5CBs=
X-Gm-Gg: AYBFou14qGZmQvJqFKUPOfGDc+MAXQjWqoBPu3lS0RepeovUgljbm0QelVfDtZLzZaY
	KKq1dL3O7wQ4ID8g2OWTVJzslmL1rQSEc5ik/StSrKedhaD23zMjz1siPulG/kh+0OIHxi71VAs
	c8QQ+g3X3/XfzEbPamg9Hm2z2CmhPyDFnPf44YMFREh+5boKFW6zr+UcbI7fCFQN7kqiK6NAP58
	N+DsTpcnRB/DI/B9CFOKjh3tfT8H1ilPjcKeTOGOgdOWl4vOXj7EyCC3508TWrlJCxg0BAasIIm
	VrtjK9umMBp2ssvsYTJWACrUmmI+hdAsal05lCUSSAEeyYn9V12wJsLOW1q6Ery4pYDNwR9WYzF
	t2g1+Qz/JevKfSuduIREjXz3YrPul6FxgIThQX7gYWeygrVjEzlF8JrMoccYtqIWx08Mcau6Cum
	1Qkv87jILUJYv9E6ktfLRLTTctuANVevxow/BUZhi914rrtd9SK3I5cYUeLErp/gCPeRx4cVxxX
	H8pGBk3GH/YG/6EoHyHkG5AB6rev9qbGddwwKes4KRXfgLDb7qucTxYfl/1wUFHy3Zv1b7ASMCg
	D9iJjkpbjyiQJ4qP25PJyY8SO2lTLTagpA8sWjkKjVAcM3gjE+kGN76//ZINvyBSgdaGEIlG1cZ
	jOw==
X-Received: by 2002:a17:906:9fd0:b0:c46:74f6:e149 with SMTP id a640c23a62f3a-c4ca7a54f72mr605893566b.16.1793553392621;
        Sun, 01 Nov 2026 09:16:32 -0800 (PST)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe96185sm293913366b.68.2026.11.01.09.16.30
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 09:16:31 -0800 (PST)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c418e215671so283691966b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Nov 2026 09:16:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBz/VnAILERpooAGVNW1V/puC71YjtFuN8L3r/4W2rI/jsgxOHqFhy0Y7afIu9VB6vQfP0ysZgrNotOP/mQW@vger.kernel.org
X-Received: by 2002:a17:907:9615:b0:c41:e75e:5889 with SMTP id
 a640c23a62f3a-c4ca7ab6062mr670144466b.33.1793553390629; Sun, 01 Nov 2026
 09:16:30 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031095716.3030288-1-amir73il@gmail.com> <CAHk-=wiPhTLn1p0ZHx-7SMdk4_zazqDK1k7MMEn9scRfqeDgtw@mail.gmail.com>
 <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com>
In-Reply-To: <CAOQ4uxjNrdxZdZZipsqnUNq+TswCKqp+30iKRKCqh2WOQ-zKGA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 1 Nov 2026 09:16:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiimdwWu0EVQdxGVjbVWdzNKGg0f6vZ1aR-GXxDvQa-Eg@mail.gmail.com>
X-Gm-Features: AclHuK_uccpP1X2e8Vqp60tdiLbtX2zzsC2PsbIq8_vF14_xkvBHQNU7aw3Vaz8
Message-ID: <CAHk-=wiimdwWu0EVQdxGVjbVWdzNKGg0f6vZ1aR-GXxDvQa-Eg@mail.gmail.com>
Subject: Re: Return failure from take_dentry_name_snapshot() (Was: [GIT PULL]
 overlayfs fixes for 7.3)
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, overlayfs <linux-unionfs@vger.kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"

On Sun, 1 Nov 2026 at 03:50, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Feel free to apply and/or wait for ACK from Al/Christian,

I'd like to see an ack from Al / Christian, but

> or I can include it in my next ovl-fixes PR.

I think I'll also rewrite that function to use guards. I didn't do it
originally because I just wanted to do minimal surgery, but when I
look at that patch I go "it could be done more prettily with our
modern infrastructure".

Let me look at it in my copious spare time.

             Linus
