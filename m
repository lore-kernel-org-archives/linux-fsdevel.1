Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794858506;
	b=mJpuDCdaXMPgi8wVjZshL4z9wRMe6rIU+zkgrVC1r0t0vSD9wmeelTc+NOhfV2nwqxpa
	 P7K5ntVM7U4zL1G+Y4KnwqzcwOZufRUp+mjyC2tXRKteLYrpnWQvshdvdMrl3yJmGIMnb
	 kLa0WPsMqmLuibzKpDGn3MPjFiSvsMEeAkvL7ed7z/QaD3hf9mq5nDgJY5XWCeV+dhxSw
	 o7wEm6GPdlxs6EuPckCeMwVch4aTrUJ4fQoG6/TXQ6N+tqzsg3a9XgcOQU9ejx/BTL4EE
	 IIjA2Wce0xyKN5te4fg3p762sc1kVj4Lz+ecPlUMJZpyxT9IZJvPzgmf05FoULEJnpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794858506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=SoqAqmuXv97PmZGFBFFCczoznG+kfpt1kIToyl4KM94=;
	b=NeGNPSORihXGkGFSpJ5CyYhpFYnX0SLQ3yPmk7aoyI19sT5qwQ94ynZ8BEcLjDz+vPyr
	 tZG+1+JPNJ3wd4SrUbGa4Xaf6vWqRK7QlVvtBmAs8qY/B5eLOH6L4J628eGcXnNJ7+HSK
	 suI4DYb/4BraJ6EB+7y+1K1JKOPG0NqWkfSpdhxWk1CmlMmrZCfevcgMKRVrYBQJnCNSq
	 MgUAfMBUL5X9l6E6LZJK7OWdMEzp5hC2U7sJdvmxMDPuJLvarGlR2IeIzejHCF7u+g0xN
	 OLThm2wswl8LU+howTj7RAYgk8UJzqycdRwoEP07sucidx5HSf6bHEtzBFwwUOWAeKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b="ZShS/AX2";
	arc=none smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F043606A31C
	for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 19:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F043606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=ZShS/AX2
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b587591414so4785785a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:48:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1794858503; x=1795463303; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SoqAqmuXv97PmZGFBFFCczoznG+kfpt1kIToyl4KM94=;
        b=ZShS/AX24sV60YKocMCZ3s+1wGEMaUqvtaghxfux2Bgb/DYa2SRgvHLR82/mawvHLQ
         ztWkSjwjyVDLcSUDXCa6t8pGa0qGIyQjzm36Zb0+nuMpQuZZZN2AtIfAnN+7guqUxnMn
         rwD+Jvtar/4M2e8rJescaVBQKR3ZiRMmrZGNA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794858503; x=1795463303;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=SoqAqmuXv97PmZGFBFFCczoznG+kfpt1kIToyl4KM94=;
        b=vNt3p/RgvdabqwKZdVvIktR/yaAQ9DV/ORBsll/HbX/WRg2oLKdrMjhXi3hRTMVdvm
         oYatOTqSSqBN8FfEKna7PkOs23YY7b4ZzwR13b6izGyDhswOaOg9BXEBGcbNthqaBNO4
         G5qx1Jl87mUKn8aJeteI/AFFx3zy3e2ELpYfzQx6i+oxeLEt5Zos1WCcSkQD4A2YrEcY
         piOE8Y/jbLgtKdS0XAGp/72PKu8dPL4YbD7l2Tv93pY3UQzi/D5H7XIWIsmsKJ6YYylC
         wdt7unvD0hbz1XGUdO9inVBgpZL+nIdbt0YgRZ7wpVmyniw1zQXp95P+SoudS9H9WKmQ
         dc5w==
X-Forwarded-Encrypted: i=1; AL+hErEfgl35rwcOaStJMeH8Y5dzHeynJs4Q4Pu1nZsYsft8eJJkeSolK8topjAXeat78ji7rv0IXymoeU/ueTf6@vger.kernel.org
X-Gm-Message-State: APuU4Z/9qwOpJ9q7XdyiexDPfQluBZt32KnFyDAVDE2q2MCk5KlbDZyr
	x3BLhPOVuYz3cv005MavAzHTJQA5BYQP0GA6+TuZH+CPIR5xO3Bh2apPVI5n648dQi2dy00/B1o
	DBMb7/cmExA==
X-Gm-Gg: AYBFou12kKpxn8i5p7JDdi7d5tjISgkH8+urbOs5rKkHwp9OGa6D/RsrM/ITGUdmYKp
	Ystk59Lwcex8Q187foxfc9vbXyRm3zk+CVf36+lxMWDLDMuUBW+fHDjtOkrzCIDEEv4KLXFKUv8
	0/mBnT+iMD2wGevf1Ih9iZwmgExzbogC4+eFXybC1ceMimT0apd6pj1Ir+unGd/mXLntPuOQmyh
	FU+ChzWFhfsbI/3qUfOb4I9uVNxdqGT3oSuOg7VyIDjFXZq4sHwdWUG+kxeoyObywZxdDrqMAf+
	qFL8pTcOBWCzUAgQpZfGnriXcp6J6sXlNnDeklqV7trjo5FcIo/PmU/FSqp9blx7cHDf1Layv5h
	bWAu6xiTUvOrQrRU4SwscU/q1yzp+Vi9IfO52fJkvfDM2XfGTVM0k6gA4E4FMo+izim5qa/ICxZ
	zj4cK6AfFgliLZDZliQvSaj4D9upVW4JuHqu/hCD4g5sR+gHQpwI2WQBLgLo94UUYe4zbTqoPie
	qjkFpNUhA7a362wQQ2x2/Qr66hBP5xfr8In9AkDLByuoAIjR1C8Ha0sNnuO3EXIJGA/FlrlLg2j
	BxPLUsgYPC6rA1qgAOIpGFEu+hQCBr2GdVP52CDAAFe+UPdaZScw1xu8YTkFUO970k1LL5vIEn0
	nRVo=
X-Received: by 2002:a17:907:d12:b0:c4c:b4fe:c9e8 with SMTP id a640c23a62f3a-c50963dbee5mr964081666b.38.1794858503406;
        Mon, 16 Nov 2026 11:48:23 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b4289csm462549766b.37.2026.11.16.11.48.23
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Nov 2026 11:48:23 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so42662645e9.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2026 11:48:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGPc+a+vVLxx9fQ/0JfEtbmHLZZccg4+fX3sccJSDC3A1ZHW+0g0vGLbZ9MeRV1Jn0E4WcU+lr5PAz6vpw8@vger.kernel.org
X-Received: by 2002:a17:907:60cb:b0:c4c:d6a3:f4bb with SMTP id
 a640c23a62f3a-c509634503cmr1008394466b.10.1794858120895; Mon, 16 Nov 2026
 11:42:00 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261025164719.1831477-1-sashal@kernel.org> <CA+1xoqcxAsRij1j10TyhNX9JXNXNkdWO3sMaVRXCqYdEXi45fg@mail.gmail.com>
 <CAHk-=wgCX4=ZSPALxR7VHKKAKipU1nD_Am-Q-0z1SRKxr-VRRQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgCX4=ZSPALxR7VHKKAKipU1nD_Am-Q-0z1SRKxr-VRRQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 16 Nov 2026 11:41:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg-5cWvYgmnE2WH4yys8tB5AwwRQU6kW0r5VoRYBLT7TA@mail.gmail.com>
X-Gm-Features: AclHuK-GW-sq_aqp10QbcNSLO7AtIlmoHSb6NWDtJ770GEzenoCICUrGbvxqol4
Message-ID: <CAHk-=wg-5cWvYgmnE2WH4yys8tB5AwwRQU6kW0r5VoRYBLT7TA@mail.gmail.com>
Subject: Re: [GIT PULL] Kernel API specification framework for v7.4
To: Sasha Levin <levinsasha928@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Andrew Morton <akpm@linux-foundation.org>, Jonathan Corbet <corbet@lwn.net>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 at 11:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And I see *no* upside to any /sys/kernel/debug/kapi interface

And yes, the documentation calls this part "human-readable". Nobody
cares. No sane human ever reads and compares specs. We shouldn't
expect humans to do that, and we should not design *any* of this
around "humans will check it". Completely pointless.

I think the specs should be purely for automated checking, and I
suspect any initial spec should probably even be *generated* by tools.
Because the kernel API is not something that has ever been designed
"by spec".

The kernel API has grown over time, and pretending anything else would
make the whole project be just a fever dream. We are *NEVER* going to
change the API _to_ some spec. The spec needs to match reality, we're
not changing reality to match a spec.

Then, once such a "spec matches reality" has been generated, that spec
can then be used to check changes. But neither of those phases are
ever going to involve any humans, because competent humans have better
things to do.

           Linus
