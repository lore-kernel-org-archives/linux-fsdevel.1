Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793180983;
	b=wHJlk6S17MeVs55+vC9trnutjncy2XH8QUrvkyWPa5UIf9jAVb2D9bDsVCLZekhjUmPO
	 v9/HCTNv8z8G9EAGJx/aYjdzi9jSYSeqyOVXzxEzysb8mSqCq2lx46Naa70/Gb/6an6n2
	 ZIchB0SYfDp28rk1dXCN+P2rF2DkORoPONqda3N6yxvK4IMJ+Wlbowdr4bXSFGe6vDsbz
	 flmAPAab9OSkbLFqemhpjfqPQhETVe2XdKqlzrejXU3Kqz/fJJ7M6QYffoMNPD7UpZ5X5
	 9toHReOzpICJhxGKwL8wABtEbfhScKYSTwmDUnbV9fWCR7ldo902+FvIr86z5p4c8eA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180983;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
	b=JFyo2d1FSkzRv9aw1I+zSwL+YSygNcZ2/TnGQfkTN0jWAcMewLen4+xCRXcp1UvISWly
	 WTIGQTMPKtTuW3DDzHU37tLQvDh6Wg9QZK2FgpP08Ty9Y/wIz/29Qwnj00OzuTPwa0b4m
	 lhmw3GUo9fF5J8MMh9HTefV7/MTWNt+ptddzKCuPtgyBHMCk/gMp4gBM+sx4shSsFK27L
	 Q6qqais4uefBNiG9zDGVPUczyeSZos+Wl8z4CPvn4f0HDhJa5YxyS0H545YfuOq/XLhRZ
	 Occua0qBJZYkUi81+lfzK3MLd3ZrJ9CbUUmNjNQBnIq/y+jaHr107d6Nn0333dO1zJg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDWonstv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF01606A31F
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 09:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFF01606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HDWonstv
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso1132415a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Oct 2026 02:49:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793180981; cv=none;
        d=google.com; s=arc-20260327;
        b=Mv9cJpY2E90CBj+4wmWfs61F3l/JE+RYEY//GoxU4BDlg98MyFRQWaNruZmLip/rPE
         YGAzB5vlJ9Rm8aIodHh0P2KcaOYPC9ub9sL+WiThkHnLfBvtYefANfl57922IZqve9lm
         ZnYDXUGVLo/+m1qfs00hOs1PuuzGa9p1pzpWCl2PwPzjGLSS2zlnrUC6MzydDcSPsKY3
         I8527IrvACpepddXwdMw2ncXPaL8F0fZgT3SzeieGjwOi3jg3YDL3xGSHgM1loMWl4CQ
         ZkZNygJTjRB/Z453hQLfLonA6VOVj0P8GdVJZ8nzc9dg3LNiwyNtpEztZF2f73r8FS6I
         ajdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        fh=sx1vJVg9SW3AoX2/cIQElcG7GsRIVLYDRcaA9gjz4Cc=;
        b=BpD/GTebJmAdDH3sOSKevcSy8CiIR1afZQPPh7mmcDTDOkMZoxPwtFcz/sQIfVIaxM
         qro4lrycmOtPVUtLn5iPhrgtWEVkzD81KN+mlM83DZfom3is/Mozo0vwjqRFF4Y57Wud
         RAea8ttds23k2S+BQ2j/bsHGqtR6YfP2LaL1VQ//2nwjnCWpLgrsst7mrw0UroY6Wa5D
         Q8++ItylM2gIU47D72gJgNXNK22dAPc5DWg/EAmm26QjKxoXaUN0XD4A5A0/cyXTX+se
         ZbPwV0rAQrWagxPFcy0irX8ORug3FW0djGiG2Wls0OAsANQQqJOhM7//RfHrSAVJ2I7J
         28vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180981; x=1793785781; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=HDWonstvPcPLttzddfVvr3FgZgIj3VTyvAyBQZO+i5zbi2rECmhSDB1AdWtfuODuhy
         zbThFOJ/JjrdUK/lT1BtY5Mp+LgVPMkR4Qmb04x1Avh2AVbEsATe5lvudS7x0SEorpMy
         ReQIkPvkTLZqXSyJPrV9ZolsJmrPn6NOA+iUBn1Z0OyokcF0SAk+CxO33y5zGnKio9Tv
         cuJUT4+A+kWSsZ5MWECBo71XMwQC85PCyclaPunzfOsIAqOKjt00RM2xS3RmVMACwQll
         Lmk0EP+6mdeww5gNkgsAXctSQmF9/qTytHXp9TBcuVFEHzvtb+Mji/sDVnTmpnhvMOOJ
         3Jpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180981; x=1793785781;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OncitmhmKPxQRhu8FlY/GIP5U4Gt08ht3PeyL8T2LDg=;
        b=ADD2cwrk1tUomc5AcbWYhHL4PhpTQhL6OMcbCmZ49ZWmlN+3ARcVTg2So1FY+gZxtV
         P2JXa5m8sUWg142okBFnLIuCm4Crg32LZNrm/FBoGJ7rnvkSQ4W0Xs0+u9ATG+j8X2Dw
         OjP+eamAbUn6lQco/Gs3Rs/pLd0n0xQ/F2byjIIsZKxcm0Fq7US9JNKZKdHheliKdnyL
         BRMBRGfSru5yuh8RuXXEAbkEUxZrEzUTp8fM1SorkcXsOr9IXVZjgZLAh5pecJ9p33FX
         fHVfh7kS0YTobHnOqP/scmEhjGaBsCIO/ahFypWCHC4lOFUkay+Seo97hpw9yEnxeHht
         ibxQ==
X-Forwarded-Encrypted: i=1; AKwUvBwRmaMtYHptxK4V5i02DvI+8cuHkK3V9V/VCX4pYYrkKuUbNUBhxBY53RDZHrGGVeDyDYCewUgbwCpY7mjn@vger.kernel.org
X-Gm-Message-State: AFq9FYKR4duRBWR5OE4xx8/PIicIRWIr4jwqmTG7xNTQBsS/gw/7wf9t
	0n8sTaM5MbLjNjyZUoYA9uII1ojGqGpHpdS7gyJQJjepFn+jwRsFWllZkPuiadYf/NNxXisyheD
	uhNRD2GYG6i4zBJwYg+qczfH4C5naY9Q=
X-Gm-Gg: AYBFou2Ik23YmNwWgVZs7erVpXQRmuNIpR8srhIpFrD6w+I5Q8z358TekiVOULo5mze
	LBMioHIxI2ZamPFQvF5jqlzGbqZtZHCxFVr4thuaCUbvG1sz5pMgMwCt+OjqCvZ3c2vRAyRL39c
	xxRGNsPCqt5kZ5tj94vrm+XC82Tw+aHXpmS19RUykQGo7czjG/LsqZR9OX1ZWBta0vvWBUukwHo
	wAlhXWwYLmvI5FqABiWeTENarddvR0qNwNBFLjSGXJy6iT/x3wHqTpS1G51J0G/jleODKwY1UMU
	PDAE1ffIpNQ0JH7PgWOru5FHJPrHP/Ivrohal/ZTuUABElEepnyaXA0VhNjVisTk78tW4tWc3OB
	JzHuOTO/vdLg1oz8obabYWvs0i2qjlr8yjIXQ79KWQDbDG2Z+l70BFZvh0AXsmDYmTZEnrlK6lc
	ZT2B4JnfpUibs3rkn5Rh1IpAVqRft+nTtH9hbJbJwi7fsDBFcMBavvK+tt7ih3q7io10qyLyAm6
	KY3XkCzHTS4krlGU2uSs+yAURA=
X-Received: by 2002:a17:907:d48d:b0:c42:82ac:b6a9 with SMTP id
 a640c23a62f3a-c49bdf7de97mr167322666b.29.1793180980909; Wed, 28 Oct 2026
 02:49:40 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793027261.git.d@ilvokhin.com> <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
In-Reply-To: <ed2b0b67c306bb458ba389f16dc92904203a104b.1793027261.git.d@ilvokhin.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Oct 2026 11:49:04 +0200
X-Gm-Features: AclHuK-kwXGKz5n7QFXQ4iO49tQbUX582-rj9xJLuSYR3NDY9XFvg2hsu7UGHjc
Message-ID: <CAHp75Ve71BfcWr++PfQPiOc=OURNn1-cdJey=M1xBVCb0HhHQw@mail.gmail.com>
Subject: Re: [PATCH 08/10] leds: pwm: Switch to __nonnull_args() macro
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Kees Cook <kees@kernel.org>, Andy Shevchenko <andy@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 28, 2026 at 10:20=E2=80=AFAM Dmitry Ilvokhin <d@ilvokhin.com> w=
rote:
>
> Commit 22302af28d3f ("cleanup: Annotate guard constructors with
> nonnull") added the macro __nonnull_args() to wrap raw compiler
> attribute.
>
> Replace __attribute__((nonnull)) with __nonnull_args() to standardize
> nonnull attribute usage across the tree and keep the attribute's quirks
> in one place rather than open-coded at every call site.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko
