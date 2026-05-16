Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9332B1A3157
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778920967; cv=none; b=NGW1u0sndxyXixKwsIz8mZHYWugPBmjSm/5HVVkm664tSCRlTLv7NiqI+GjbFC4nBwFlZqvhG6T4z5IWcTRc4OIO2LjXNqTPHpCR0x8oXLKdawjin27rR4U/fxi6sJCG6P5f4j592Em4rkA7VLqyk36kx9y5ISl4UMsmuAEx1rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778920967; c=relaxed/simple;
	bh=RnkaXF+insktooUT2CslgYeWpdkUta1D3SaeHR6Tok0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pNvejbIADpa1hwGqR678J88+P27NmPlXnHfLYS71BcGST1ShIIhdJMD9GYCUm9Nmd4ukkSiYsJ087nVE/m15vV02lsC68q9b2F/jg10o1seJPNZe57mNCCYAOzTVzS+P7DW7tRDdreNbFIYDfPlSfyvpla5TvTMv0OAbKpuIqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxbpRZTC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxbpRZTC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48ff4f8ef0dso5877145e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778920965; x=1779525765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjaZvzmqJsfgwXiIBwGP+VbrW7tGLwzGVyPjpadwRZ4=;
        b=kxbpRZTCw8OfZCVwJ8ZSZ0aP0PzpgRZl5RNGr9GKPjaBWx7jd8fns0oLSn/eBogsqN
         I+Ifg9tAgC2zedQX5ifJbMyk2PDf8EPvt6Vmg9g0iWtsCnyHZ3/0nvo2adIxftyCnZGl
         /xlPWDIqowJgL2gpDzMN0Cro11Qs/V051uFP9Ocp8k4Ngy0LCI6JMQbRQ9F+IfLYc+TK
         Da8Nw+YwpoDqyzTr+9jQ7vowUPKbPhuL3FMAQGROsmOuo10Y7fF0AzFK5w+wEMBJAFXv
         4pB70/eW/v5giggt5hygWiEjOFZBOPUmybMmQ8hi2t35ueghUXgvGU5SjH6e4rHI9lLb
         KkGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778920965; x=1779525765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjaZvzmqJsfgwXiIBwGP+VbrW7tGLwzGVyPjpadwRZ4=;
        b=lxZxHlxzEB6NW4DVyLzj0D2xcBsDT4OLW7heN3PWeqq7hkK7kl1v2/+UkM7EY4wofL
         z3IzPqapngOMdufxZqBMnWg1XVSHDYrvpAI6hod/YBe3uC5rQGoIuTE2kjqTc5WoFEhF
         DH5OIQQhsK12SJ323cqc+UgxguB5TenfeWj2VVxdjq+rkThO/K7SfRWxzbNpAIJ7B59z
         hPhvRpbM9fJ2NIlBb613joYbMa2aCwEhe17gih7Ou+8GRYOtH7fc5yc4HW5IxmHVfikS
         JS9IudVPjlIH0J9+NlPzjCQlh9OGgt4gZtjOFB5iot++qaod6OeCkTfBRrclHQIJ7Wfa
         7OrQ==
X-Forwarded-Encrypted: i=1; AFNElJ9gwMKvp56jeu+n/TjZyynAVxqnIYoschDyUY1Y2QE54W3QYUA5v9nz6ixhm3EH84HPCTAkoytD1NMP69Uc@vger.kernel.org
X-Gm-Message-State: AOJu0YzRKIA3TunPPODpvs0lcAp023c3Rz5k0YavgqnGS3yrhXFpYaRR
	HomA9/t2QkqgDh7ttncHQFCP0ndUrKguXzYh+JOkGIQ28LQnC1klf+gG
X-Gm-Gg: Acq92OF+hx0td03pC3Fant/JnNLm0C30mjr+o9ClZu/CDU66Kc6vBW9sxFaPjEkOD0g
	hE/dXBRgrQhJnz4G48VNDHytul8Mi/2YeX0xAOD6gl0yXLW/m+FhpaB6MKpBfaaui4G5xYgYoeh
	Y2fdZXCNh0c2NOvGJa5KtO5EL5gf6tTQ46xHYaXbj6uuquFAA8AnUQeuAZZMddCOYlYioY39xmH
	T/BxFsvLpWAIPe3XAg+qEsF5owVoHTg6mIUOVMnw35QY0XvtZz1NLFCILqFKUTciYsUch9rf0ZF
	PTRe74VaFJeiQWYY49pBdT7eD9h0n3TGZvXjYqjn8H8RPab+nri5xTJGC28BG9LP1EeZIP3VDdD
	rb/ADfG622diIeObrVISjhM3yNwkJpk7ujfdHBqkGEY0uJPerntxr9wVWKXlTZSY3k2KwLvLN8e
	8P9w3wEJGbmDumWcDBtxfND2TLxzdNrSeM/X0sJQFRfxkC3DDyGzcim0Z1DqhV
X-Received: by 2002:a05:600c:8b4b:b0:48f:d2fc:d025 with SMTP id 5b1f17b1804b1-48fe60e14d0mr91173965e9.6.1778920964812;
        Sat, 16 May 2026 01:42:44 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm108760745e9.12.2026.05.16.01.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 01:42:44 -0700 (PDT)
Date: Sat, 16 May 2026 09:42:42 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>,
 Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
Message-ID: <20260516094242.77d20c92@pumpkin>
In-Reply-To: <CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
References: <20260514200129.94862-1-amir73il@gmail.com>
	<20260515193010.056ef472@pumpkin>
	<CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 21:26:04 +0200
Amir Goldstein <amir73il@gmail.com> wrote:

> On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Thu, 14 May 2026 22:01:29 +0200
> > Amir Goldstein <amir73il@gmail.com> wrote:
> > =20
...
> >
> > The object code bloat would be noticeable if this were used everywhere.
> > But you could make it a bit simpler:
> >         if (__builtin_constant_p(__e))
> >                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
> >         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
> >                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop and oth=
er boundary errors
> >         (void *)__e; =20
>=20
> Yeh that's nicer thanks.

Actually this might be better still (or just more succinct):
	void *__e =3D (void *)error;
	BUILD_BUG_ON(!statically_true(IS_ERR_OR_NULL(__e));
	if (WARN_ON(!IS_ERR_OR_NULL(__e))
		__e =3D (void *)-EINVAL;
	__e;

The WARN_ON() will be optimised away (valid) constants.

> > The check for constants may be fairly pointless.
> > One of the static checkers may already detect the obvious fubar ERR_PTR=
(EINVAL). =20
>=20
> True, but I figured it didn't add much overhead if we are placing
> the runtime assertions anyway?

The 'size' check in READ_ONCE() measurably slows down the kernel compilatio=
n.
But there are a lot of those.
I think I know the main reason - the extern for the 'error message function=
'.

-- David

>=20
> Thanks,
> Amir.

