Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793278848;
	b=OvjA+dgCLquJNLgI8RDPKIfOwZbHL9L5Ku0DhpgL4Wo4qunHeHq8GH8kcaggB20CKJxn
	 U1q/QnaMM6jjc+0LNMKhONreuC3b4ZmxKeJyyFN9zTe245fjW5oH88IHUgVQMOz3m5u77
	 H0l4rTL/vS30KR5gux+Qz1VX1bmtdGSAAve6aaHNJ9kcLUeqf3WsNN57W640g4arrCpyD
	 5AoHS7DRxc1/EANmXvYls5HDdsx/8ZmgRtin4E3W1UB3ygiI80GWuKSSLBByOanPeJ8h7
	 B+UcpgtrNKnTKr+J/z7l4/2VqaoISAh2SJEJ/E6OJw3sInItGhYPUe+6DOL8J+sYP+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793278848;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
	b=OIxvbv38rptGAsb0ljgn+30L6SN0gb6C+IohdfFQrVBLIdy8zBvWQR13u3NKgygSIVdm
	 1EyYA5Nwq4xr1cpnZN40ybVssxu9pmxp4is340ZRtV90EN2SOrt/CbC+zX5/4fniMpqA7
	 lMToh1MFDD49Ipg70YUtmvVA173/3VrqeCgPY8NBvbTSf6G2gDSTE6of8VdV/n1kGh80s
	 fGdoU4i4CC0+/g6tie7U8aVaxQgCAElY382QT0BmP2Gg26QVf6gmUTX9dlP4414jti2ud
	 w9Su7ZzEU/oTvP8jmUwUivvPUdUs4p5/MECJ0hP2bM+Gjseh/suA7InH4oNiQ0QgaWA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofPvZk+o;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0731606A335
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:00:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0731606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ofPvZk+o
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-36a10095f3aso279597eec.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 06:00:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793278842; cv=none;
        d=google.com; s=arc-20260327;
        b=STjVsjGfpc/1zX43i0OfN4TPcx145/W1071rzJMB3sELmtB6c+j2kucD73+3MPYKjw
         KPDoGJyKYqEwHIyC59RmOAG0+bM504mAPg/T14gdW6h1S4jzUIQw6d4jvNOLAnhCublP
         FUr3uuXs8dKghD0c09/IQu9QgzcSqPPdZ+C2OMA/LJcb7hW/DMsvKHSUGLELbJ1l9/5l
         sb0owe/e86xDIxfsjVnCV58ZtlmYin4MDQ3pBl9i3FUxCdhCl2YrIKeqdRZd4tQ8hsiJ
         0zZ345DHdkvasAhdViPo12rWLVNkPX+wzaMwIlJIpfvTbeH2syQAry3i0pfCDtm9a7dD
         ODOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        fh=zHiQ+0txgrye35vYC1Wxy+Vksfa0fcC//97mijRuH/w=;
        b=RevAw/XPak0/Rhs4DGEHmeBHj5YPJujh+MiMC2mZ3EH/e2KvGlyEAmjlgOO9u7Kdi+
         rOgVQKVz4yUA/rtSJJvfBMQ+apFcCul9stsW8VBadymyzDLvAIhpHyJ/SP1qFO6P07Gp
         V/kWrRIBIyNaOpwlENNMkxZdDDkmnIYfITschTZm8YTAbmq6a5uHCgC9hEK+GUmSqMfP
         JeAjRHzjJ6AtfCbXHGUbav5bbxZ/Vh+9xLUNwV/9lk/RN4epYZPuRbI7tDDXjVdL4Y7e
         hFbsVrxsJ8wXjjPGPwIxXx5UK0j7eOojaDRUfVjg4HgzE2aBTzXi+IyTFJ+iu5Thvfbh
         vvQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793278842; x=1793883642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=ofPvZk+oAY1UtBN8lfS9Hjg636A5yXXxymVbjphADhkntlAvo7d+OJU8vVQ+Az1YKb
         dWukwXu2x313G1oppF7iAuhlMKCT3diyXTgTlAKXWjGM+Iwm50zBqxbGFoqtU4CjQPRi
         ToYeRwJPj5xeiznntBlX4VFyiQuMizC0YzA2Fycqh5ak/5xu31DBjOip8vO4Z2tuK/4f
         9PhR8pLQtraxqSwScA6jTPUn2IoU48Ael0NpD7F/lfQbSWkS9kG+njGnjZ8V4i1r6jjs
         NKUP7iwgO2CL1t6jHHe5bxmc7L4p3wIS4RcYs0ebru/xZh/T2s+t/RLRgJoRw7N6mzGF
         pkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793278842; x=1793883642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ganH4EWpICXirAxibAD+5YRIHmRwYY6kvCGrRyrhM1Y=;
        b=21XhCeTXIE1Y6VJ7L3Hjof/CxPhqWsKHMuIgdp3eB++zfiKGcdwuMND8a/EJupgO/h
         BLCy47ppKx7F8rOWxd+JmXoH1gycV95bG/XlFKLDZQQsUA54LXMG3kLobi/U36J3mg8G
         WPcnjRjUxmzTJWXPrT7VFtp1ItBOp7nBwaqNzLCfJ01gk3G+fR1K3fK2RiRlmIP4e/km
         NzooQ3BNsEFgxnNL2+ASv/eRLtXVkD3WmSdpfeTFY78WOhBZiv4TrAYqFW/x3vNLPqzJ
         JdjdpB/Xsmu5lhAA8InV4Se8wI9qkogVlPZtcj83YCIWGA3mmh5UDSM11nXrLHmWoVwV
         i2oA==
X-Forwarded-Encrypted: i=1; AKwUvByC2yIPiB7KQ9Haj6AkteEij4wfRMwvQ7XFuNwtl6nnpqSDDodiGYlMNklKlDJeFNdzANJnEI7HaUl7hDBA@vger.kernel.org
X-Gm-Message-State: AFq9FYJ0FbxlVV38LNAcdeken8vB1owIzpAJhSpL6zuhjO/NouFh1U+i
	iZb3Mz3vLpYw7KZ+EOqzq9joTVgXMD5Nmngdoo1WuBohqHb3XFSNjCau17d+XJ2r6A5gA2JAA8N
	RIL1SblfJBz43jHjyxlLFlUbt5lOqCS8=
X-Gm-Gg: AYBFou1M67tgcokq/mPxwQ5DE+Es8IpC+krKFQLrYyu00Q4NcUK6vJVnP36te0ruXFl
	GH21bGpoJ7MmC3g0aq1it61p8KA0W34VfqyAK/UWYBSiAb1L5oKhP1ZMygYmPBl0xgRtGcFyf7U
	4A1d8LZf34GlLQfr7Z83dlTNHDl64DhiE+mor/sf7N82U++MP/YV35zONn89DWWfZ6OiqHKO2Q/
	FF5HegYsCFDtN5amPzEqFV0Aul8shYl8Sp5XkubReEbizmzVaHSvwUyxN+kE2+X6r5OHojBa4b+
	Utu1BHZUwxT/3YzKxExlndNaX3b9jEsRZEbXoumuQAhjV1GiPXToKe+b60m+tTgX6gYK84RnVAN
	7H6EhCyrwIx13Iy7lNcVqE1wxg9V13kZMjOcSjcvlv+tcmb+MSm9U5pbPxW9ExzgLd9VlZJygHY
	wEJ7rQ+ycuGRPqNxr8W00RDaXlq9rDKiXcnXsdmFgkEheJrmDdba5g4DgYzYOZwJ4j96gFn8B5S
	VGvsEFBjspmowJleKvI8wSJ0djyRDDeCGYMlQ==
X-Received: by 2002:a05:693c:4196:20b0:36a:e7a:e89 with SMTP id
 5a478bee46e88-36a202cb0e4mr12034617eec.2.1793278841146; Thu, 29 Oct 2026
 06:00:41 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <5bfdc1491d297b5e98cf42322c790f06481c28c7.1793027261.git.d@ilvokhin.com>
 <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
In-Reply-To: <fb3b6a24-74ca-4da8-8593-352afd515313@suse.de>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 29 Oct 2026 14:00:28 +0100
X-Gm-Features: AclHuK_VOCF7u599iESvOsHhN0DoC1VeK-LagvEMwpUC6WNOUUTl411X-macJoc
Message-ID: <CANiq72mMm75svCqevd8fHtVoczDpvpo4NwL0SC8=bWy030vQuQ@mail.gmail.com>
Subject: Re: [PATCH 07/10] drm/gem: Switch to __nonnull_args() macro
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Dmitry Ilvokhin <d@ilvokhin.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@canonical.com>, 
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
	linux-hardening@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 8:32=E2=80=AFAM Thomas Zimmermann <tzimmermann@suse=
.de> wrote:
>
> Should gem.h now include <linux/compiler_attributes.h> ?

No, it should be included for you (unless you are doing something
custom with the compiler flags etc.).

I hope that helps!

Cheers,
Miguel
