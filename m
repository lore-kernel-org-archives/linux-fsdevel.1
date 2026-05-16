Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40D33D6CB2
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 12:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778935344; cv=none; b=bZj4XHWKTZ9fGJ5SwS1jvQnqnA2t1GVoebsslb0K4QjBmeoQBVkIEKIbjv6xVxY81hGxcHvhrPiyNZwS36GyipkWRUW2svYPX3+99sQIQ5rQgZ7cSHAq90H9IfdvEvURN9s3VX9El7CIHszBlJ390TMciJZ7A55iHmPSqRM2y/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778935344; c=relaxed/simple;
	bh=dyTCV1iXv8a3jiKteV4rJPmHzjcbFZlSYh0yDLAXMx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ViUsemD35jEw4fsckyuY3DQ/TlCOYaMCTUJXSnIrmQK9ILPL5sQ8ltKV7lsGQpORe/Zuq0aiyvCC3gFvmEcAaRX3UJlwxrDOrHGglx+imhXs4CIw5G49VcbufrB1RnJ39lYCf3XcKG+2d7EXJP6UVokjuC+SbnJNLE4Mp9OSfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qnOPkoAD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qnOPkoAD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48e82c23840so4667525e9.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 May 2026 05:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778935341; x=1779540141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=18WmkI7S0iBiBQjk0+zjD5psJsNEfkb8RPNasAp7J/0=;
        b=qnOPkoADzr8TrubvJak2i4ShMr5iizDY48306bHbdQdlwgcZI67VGrk9BLYnVNyHTB
         3JloSaLXuCQuHD0K4EqvuZpPUjEWSjrXxdEfVZpLpePTu4JI/ba0W3zJMbz7qyA3jHz2
         U2ZRpfNd3ysar5cq6uvHo6kT9Ep0x9q5AbgmZ0ji834PdWw3ZlFMP06aFJP3Y35ySCSl
         Sz42MiFal8OW38HAbYVcRnQM/PKV4imuf0JG45HX64GVkKbhKdEIW3kJkUFK8ZMxatdk
         AXR4T5eUcA9bo76JVogOBboIx2QVNYyuGaJB7vfKnFkW51CBGlnIIjmPsh4P1A8M1eQU
         sMXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778935341; x=1779540141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=18WmkI7S0iBiBQjk0+zjD5psJsNEfkb8RPNasAp7J/0=;
        b=nsYF3ovJO5+c3XR9Q6qFIB9o9h63bLtY4Hl5a4Cps28HD3f9KxWDDSPwjWiPGsxc7l
         Id1K8X8IEgMMmse4tgjqFwIhie3FqXGxO2cBWKpSrw5Q3Kyf66mbv/V2pLVLHcGhBaCI
         ymsinivaNXEuhwChn43iQe4z+trNzflgije7pcE0c9hsyM7L8Nkq5EV9j7p5dURP6llO
         UVgGfLin9nkzmzlj0gNFxW/2df/6InKUSARRT50pD9vm/8YTRBIC7ttwNKL5OzoQ0AQb
         hw7nwGUIFlhHUG+lVjbVwq4YK7lhu1JYilZtp9C/YykOIzJdVd//QNKk5723R0WzRHS7
         hmdQ==
X-Forwarded-Encrypted: i=1; AFNElJ9qQ8SDLLtxVqvezdL5M1WVcwlGDCs6NQVMwXIo1RdS37YQmcC7pmkQ9jdXjhdoSViFBtiesqxXC/sCxxKE@vger.kernel.org
X-Gm-Message-State: AOJu0YxkSaK3M41+nead+gdESouZGG6P1cm9QAJ/tEzHZGu8T3e2z4GI
	IonuajCeBJuEEsYVu+LR8stu3KPVJ1QChQI6Kc2vxo/LB50PYcwKmrzspIlkUJWp
X-Gm-Gg: Acq92OFX3QyPZpeypZsJItGHcxH4Uoq92VUTL00AIPJgEEdT78Md4ADKHTLrp7O9vfL
	2GufPgR0IVd/G8O3hikHcAF62YxmjWnUTzwM3+/QB1ONw+OmHtpkTxasgJJy+yuvwiyp4k43QR3
	vok1mBNDBDLe733CPNMJPHFHjTQG3eiB5qHF5CuYmq8rf95ow4zjwHLXBukcbLnT23TY9z0GT7A
	J5fZb/uQlhAotcMaQIssm1G9ngP/mWeC0rMFuP6LbpMQV83vIFF+umZGJQJ973RLkPU4BbVlIOi
	W8RcaMZlrLxtMrQfXHxKFCqM9nIs+KWWQ+jOmYKPQExrHdSLuo+opHWJuB+isf6xdw2mEBYwzzD
	RochKzZ0W+YJX9sbPZzJU2/nPf4F7Fa+LVd9VvalxUR5YEnfOSY0R3pg2V0YW89ud5hBAyO13ZR
	3aX5X3oMIgA1GMStEwGkgo8iEk5qf2xc/atxkNKwX89iBNRhOTl8qwB1GABUWd
X-Received: by 2002:a05:600c:470e:b0:48e:8741:fd3d with SMTP id 5b1f17b1804b1-48fe60ea21dmr103750935e9.14.1778935341258;
        Sat, 16 May 2026 05:42:21 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe5cab882sm131037005e9.13.2026.05.16.05.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 05:42:20 -0700 (PDT)
Date: Sat, 16 May 2026 13:42:19 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner
 <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Al Viro
 <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>,
 Nirmoy Das <nirmoyd@nvidia.com>, linux-unionfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] err_ptr.h: introduce ERR_PTR_SAFE()
Message-ID: <20260516134219.30a30927@pumpkin>
In-Reply-To: <CAOQ4uxjX=C6WZvW1DdJ13tJj-XBWVxgE2Q9vVvHoYqiOhqW0wQ@mail.gmail.com>
References: <20260514200129.94862-1-amir73il@gmail.com>
	<20260515193010.056ef472@pumpkin>
	<CAOQ4uxjDeF3uDe=OTVZ3fK65dF148FRUvPx5fOqZpoFuGUsmJQ@mail.gmail.com>
	<20260516094242.77d20c92@pumpkin>
	<CAOQ4uxjX=C6WZvW1DdJ13tJj-XBWVxgE2Q9vVvHoYqiOhqW0wQ@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 16 May 2026 13:39:11 +0200
Amir Goldstein <amir73il@gmail.com> wrote:

> On Sat, May 16, 2026 at 10:42=E2=80=AFAM David Laight
> <david.laight.linux@gmail.com> wrote:
> >
> > On Fri, 15 May 2026 21:26:04 +0200
> > Amir Goldstein <amir73il@gmail.com> wrote:
> > =20
> > > On Fri, May 15, 2026 at 8:30=E2=80=AFPM David Laight
> > > <david.laight.linux@gmail.com> wrote: =20
> > > >
> > > > On Thu, 14 May 2026 22:01:29 +0200
> > > > Amir Goldstein <amir73il@gmail.com> wrote:
> > > > =20
> > ... =20
> > > >
> > > > The object code bloat would be noticeable if this were used everywh=
ere.
> > > > But you could make it a bit simpler:
> > > >         if (__builtin_constant_p(__e))
> > > >                 BUILD_BUG_ON(__e && !IS_ERR_VALUE(__e));
> > > >         else if WARN_ON(__e && !IS_ERR_VALUE(__e))
> > > >                 __e =3D -MAX_ERRNO; // Or maybe -EINVAL to stop and=
 other boundary errors
> > > >         (void *)__e; =20
> > >
> > > Yeh that's nicer thanks. =20
> >
> > Actually this might be better still (or just more succinct):
> >         void *__e =3D (void *)error;
> >         BUILD_BUG_ON(!statically_true(IS_ERR_OR_NULL(__e)); =20
>=20
> This condition is wrong but also my compiler does not evaluate
> __builtin_constant_p(IS_ERR_OR_NULL(__e)) as true.
>=20
> This works
> BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));

Yes, it is easy to get those wrong - especially when typing quickly.

>=20
> I think it is enough to statically assert on ERR_PTR(EINVAL)
> and no need to bother with ERR_PTR(0)

Then the tests don't match - which looks funny.
IS_ERR_VALUE(val) should be: val +=3D 4095; jump_carry ...
and IS_ERR_OR_NULL(val): val--; val +=3D 4096; jump_carry ...
but I can't remember whether gcc manages to do that.

>=20
> >         if (WARN_ON(!IS_ERR_OR_NULL(__e))
> >                 __e =3D (void *)-EINVAL; =20
>=20
> Oh, anything but EINVAL please - the most overloaded error value
> My choice of meaningful error value would be EFAULT
> because without the safe helper we would be returning an address
> which is in most likelihood bad, so better be explicit about it.

I'm not sure about EFAULT; it is only really used for user copy failures.
IIRC at least one Unix (I've forgotten which) generates SIGSEGV when a
system call return of EFAULT.

There is also the 'problem' of PANIC_ON_WARN which is set by a lot
of distributions.
That (sort of) means than you might as well use BUG_ON() and get the
associated slightly smaller code size.
On x86-64 (and maybe a few others) both BUG_ON() and WARN_ON() just
execute UD2 (an undefined instruction) and the trap handler finds the
associated info and does the printk().
That makes the code smaller than pr_warn().
Someone needs to add a 'I_REALLY_MEAN_WARN_ON()' that never panics.
(And maybe with an option to not dump all the stack.)

-- David

>=20
> >         __e;
> >
> > The WARN_ON() will be optimised away (valid) constants.
> > =20
>=20
> Yeh this looks nice I'll use this:
>=20
> #define ERR_PTR_SAFE(error) ({                                  \
>         void *__e =3D (void *)(long)(error);                      \
>         BUILD_BUG_ON(statically_true(!IS_ERR_VALUE(__e)));      \
>         if (WARN_ON(!IS_ERR_OR_NULL(__e)))                      \
>                 __e =3D (void *)(long)-EFAULT;                    \
>         __e;                                                    \
> })
>=20
>=20
> Thanks!
> Amir.

