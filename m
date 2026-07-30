Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EF1448BBE
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 16:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785429009; cv=none; b=QIWwHtvLhqvnodVoRmgC0uzi4b7JYA0i4P0O6BfeJQkZ1Y70rT0LRVRJJiKx+no20PQpw6aQMGSm6K++cFOOVr0f+p/b0MTSuf7DVOFjreYaC5EiNJOOQL4b67C36R0jJxNK7OgpYjA2tmUBms0ac7RsDLMCkm84tvUtmTY70zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785429009; c=relaxed/simple;
	bh=j929Td4hajJuv+QUhdI1SNg8U3FSolKErsuvAFPYvts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hD3WXLbEtMeGhyTaF6AVe5WPoQlAOLAOv2a2ixKFNLh8Z+cT6Bfq2UxfDYuo1WQn/JVYpqB2+LC6lYWgqUPfu0cxqm4MyjG7cZ8vke6ge1EbAZdEZF25kby4iZTcOzJrxO8XLThowtFPgjM7/VKLkcZPVTdkwntpnDTEFkDI2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HHUB/r0Q; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HHUB/r0Q"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso33916a12.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1785429006; x=1786033806; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JKKXILLclmc3qNlg3jUy1gcZGJ6n7s8aAYhXOiYG/9o=;
        b=HHUB/r0Qg0rvE2sI8efigm3fsr04X+I3/C+vOanLNJM8QH4maEzX3hn68SW6jE7d/F
         XVumhQTpWy5dwQ7TupP1Zz0+X+uZZz4fzPi4AFOr5rOIn7D9TxznYhxU4SSxaa+nVUeZ
         Q7HMyK5Z21Hj3IoUXAC65DKbu1dkz8nxNxsL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785429006; x=1786033806;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JKKXILLclmc3qNlg3jUy1gcZGJ6n7s8aAYhXOiYG/9o=;
        b=itRI1peoKf09AbG6vyZU57/WUEaXO7QVG0GFsNIFdxr4u67lhdULklcnZeWF+mAy3I
         RSslUKxZE4d7vSrd7GicRGP4Emm2kExKO3rhWkpLUv7+PRD8VE5nX7GqzgU1Co9bBhuU
         sZ2Lychgl/0vWuO1OyJ3m1tqAsSr3y70dJjNrwhZytUDOb8OnL/b+qcvZiPlw28XRov6
         Vs3caNVd1djBt2gQM5Wxp96KZ3zIeS/jRw103wgBdbfpC5AkLO6ZQRuAftOjZD+y9VhU
         0cYO5DomGOSZABfvDgJtapuZkMkN/bFV/BgTOcVO/AURt9CJVpgNQeKcvHOklzJqCq1R
         rmMg==
X-Forwarded-Encrypted: i=1; AHgh+Rqa5UgwbTrsAkH3AinopgXMBiXyej4BxLaIdr3Uj8LYXbblQ1WnYkak498Ponr6cFC3+pahHItbMC7ZvP97@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt6iuFSdFXHkg3d3icZig+EL+6OpH9v9mMOcIezlufRZ/l8Jat
	VFmfNcmaJKm7Uq5h1eNu696NZgdyI6a4f2r5jFLl0t3cSTaW9+sR2iD2eCyTAxrUItr7gcxnLoW
	m3X+1N/4=
X-Gm-Gg: AR+sD11ZPzadIsZkJjkhv8S968IIlUlWIMVVkrUk+J/m61VagKeIscMHEf7QhafkpMD
	XEAkP0VVKtdTmS6Xv1iD+wepeBUXit35oMQiiPByoiukLxVqxQT2Ga1+1mECDdyD/DfFULXFerV
	Avzl+UJwJUhNkeTxZaBaVKW2BP3tqjGm1fGxkvgyn7h4r0LHSKskX+DpSeAyKLO4zGCatzvavfE
	AK+9zl5gPu2kVmhmvcQCLYrgZWyOaU4ktW4KlLAM35k/7Xn21oZENHwCpbx0FRxKk/xOMm+tpVh
	6beJfxXD/LlUTdOBgaN7Ei49kUupK71ACX/c/IpV33Jdf3HeOvvkRrkJHq8JUpeb5uG0sJsVg8K
	ehUUiOqit3Q6q06J50h785GtbE9Tex6ULiYZVn9mnXxnOz19a14CJf75jm+Etd3Wm6ZBG2Pzf9+
	lcZo9nzK3EMjtauFVLqTKmibmJ46JmA7ffeN/vzQMD6KnZ0Q5DwBqY7wK8So3/qis8E02AcX6Qe
	CoconGlUI3wzbN1gva+A4JYItKYXSR7ZT9k6w==
X-Received: by 2002:a17:907:1ca1:b0:c15:ce72:9350 with SMTP id a640c23a62f3a-c1fa56d4997mr186739966b.41.1785429005579;
        Thu, 30 Jul 2026 09:30:05 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8b76100sm87808766b.30.2026.07.30.09.30.04
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 09:30:04 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c1f758014b8so207303666b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:30:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpduUc2p2LsBwmQXGwWAnJOFiwyyNQugVX592x4Qqd6riFdshBRt/FfpAc0v6O5fJv6/mI1Gmiy21PPOGQb@vger.kernel.org
X-Received: by 2002:a17:907:e1c1:20b0:c1f:6f31:37c7 with SMTP id
 a640c23a62f3a-c1fa57683f8mr118873866b.54.1785429004279; Thu, 30 Jul 2026
 09:30:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514140817.623026-1-axboe@kernel.dk> <20260514140817.623026-7-axboe@kernel.dk>
 <605939add4dfb674bd7ab39ef8dbd3fd22e754e4.camel@xry111.site>
 <427b15c8-c168-4e2a-ac38-b00dc00400d3@kernel.dk> <CAHk-=wjeSgFEr3WSO1C1sPP+fy+Mt5_EL9WXW-s11BOhD_S5Ag@mail.gmail.com>
 <a50c6a4d-5c25-4cbb-baac-f622728f2693@kernel.dk>
In-Reply-To: <a50c6a4d-5c25-4cbb-baac-f622728f2693@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 30 Jul 2026 09:29:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjr6LoL+k1J076cSvRHVOdR5Wvh2J1HbwZUQ-BY5vxLKQ@mail.gmail.com>
X-Gm-Features: AUfX_mwr5GDmQnErKjwQ0Dunyz5Uw2GHS2KisR_RTCds9nNDzKaWdeGII3C9Lq8
Message-ID: <CAHk-=wjr6LoL+k1J076cSvRHVOdR5Wvh2J1HbwZUQ-BY5vxLKQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] io_uring/epoll: disallow adding an epoll file to an
 epoll context
To: Jens Axboe <axboe@kernel.dk>
Cc: Xi Ruoyao <xry111@xry111.site>, io-uring@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, brauner@kernel.org, 
	=?UTF-8?Q?Juan_Jos=C3=A9?= <soyjuanarbol@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 30 Jul 2026 at 09:25, Jens Axboe <axboe@kernel.dk> wrote:
>
> Exactly, no other recourse here than to just revert it. Unfortunately
> my io_uring-7.2 branch is from pre merging of the epoll changes, as those
> went in separately. Hence I can either prep a revert for you separately,
> or you can just revert cfa1539b24af yourself since you have the context
> as well. Let me know what you prefer!

If you have other things pending for the next rc, let's do it in your
tree and I'll get it through the normal channels.

And if the answer is "no pending pulls for rc6", I'll do the revert here.

             Linus
