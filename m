Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7E1376463
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165375; cv=none; b=N7s5IGST7yrfcwPFVkVgPLrPPbVUB57TK6N07ZHO3K5ILuP/PODvbRPm8YiwV47uGLBAtXeNnPRxcDNLU25VSiyS2T/RFux6YjPfvdiL/EegZbvdw5Z1RXLaCvO7/M2dvvmVhGj2+eOxzlkOcAjFq/smTc/t+zG2eCozGxl5tes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165375; c=relaxed/simple;
	bh=1kW/xWEptVfATiB2XmKzFMAy8WM64oMqHIU0xJ0s0oE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E3DcqVffZLohZUVbbDF6hoptaJ5eMuAmRWmI+SOHEuatxDiOf2rivExGf2nZoC4h4drdCX79TACIgZNLfZpIkTwRAi5ZolM5+2AQV+03heGhLGjH9UZGMhMh39G0D1MWXYAR6sPfMVGuaPq2zG/OqnW1juIIPSBYz74jwHGCim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InrpmwD/; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InrpmwD/"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490b8a97b11so85440195e9.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 01:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165372; x=1781770172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XgMWdBgyNc0sJULa5C8yyGeEC63/vUI2ECNgTDQKOWM=;
        b=InrpmwD/yfuB7C3pgiwJWKCsUPpJkhGGe6hrPQmClaEX5RXP2dJ74mH9MWCKbuMraP
         Re2+rPg0/QfqtF8wBNqGTAOF7tYQIWzCUtMSlGCCLL3eZDgLLxjgFUkbYodqNPbtgyqV
         Eqz/DmR5d+1dE+mGczvvumy5FZzLmVHuv7Vg0pez73Vyf8C1sREXPsq9tUxkd4JVTHgZ
         WSEOI5tBg5qTZfdvtSYxzfsYDM13B4RYF7T7DOyEpucEtzTXZN4LVbDay8Fhist9Xcvl
         FM4A0hCxKhk3AYK1Geyqyo0YaIh69X/v178YzzYXDR8bIz/g+wMsIZKA9LWRZ+NiVjqo
         K3sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165372; x=1781770172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgMWdBgyNc0sJULa5C8yyGeEC63/vUI2ECNgTDQKOWM=;
        b=b9P19l5/pGhCdm+w58ri3A6n8cjwKb4oM5gqGvHVJ/X2ewkzmEQ1DeevbGghS0kgiR
         2nyiLOG1lifS5LXhZTM8FeGYup0CbFH+esjVKu2afJ4IlpDg/QP0WICycp3FoySCUdpn
         rxv1FnBfdSeKdLaEvwd8Zg+crRqG8GAGp34ltPMHxqoS5odNza2UezXmV7JizhaewwgX
         QwIs9QZNwr3EdnMjqhQfkLUHdh4Cd7ri17LsdwD21chBhXB8ZFKeRFb4aWUTxRQonm2C
         Mk/ahYKVRJm/AwZUloFpM0DWVpJ03HfYRj4hdaHrDiZhvWO8vyQ7ei0dsY5rbILANAek
         Bihw==
X-Forwarded-Encrypted: i=1; AFNElJ9KjIBGC8/GfLDeGq3NMPc4HrCn1DQYx5LGn4zEPs/sNDZt3YgsCW1meb5TZyhVh52jKHaUre2U1qfbUq8h@vger.kernel.org
X-Gm-Message-State: AOJu0YzPVhttnP3FEFjXXVXrWjxNU0jGsazO7FgtaYPuE4zyziuk7SbC
	HO9htFhb+mXd3jtiOTqrFpY6j4GTUSwNNqzBPiNwTaIYmxBwqQSQLvOQ
X-Gm-Gg: Acq92OHxKbRE9mSmYSa8dM4s20DDouPy86IWTscO2ewFUw7tCtwCvFDIZwk1VPZAhEb
	oJfohrvNCch+64093CRCRAEfyxuzoSxsQF7oxYjmrR92/wwIA9CAG1CT7ZFimaJaUAt6KmuPOR/
	t7AfF54fWDmXbGNTEAdc9+waoCx3Aukiyz+5XVsIfvLys3AI7iSBhhZLX+zKWqmRF/bmgeQ0jvr
	BC3rLngRmeCj0LTVUE5Nw275XX6Mbe6Ky/46sS4LwhQyJ7iLT7K/NyYKgPLIlFyyE+HHoZuGxGQ
	cm1nJYkq/cRDvAgRVGSJeZQIuo+PRYDS/oHTgjOW3LZSmf9VOv5rNjgZdRfdRKykpJCDb+nM80m
	/8r0Hs37kmBpIJTgj4ja5gCrgdpyVLfObRaUca0xED0UYDPsxeaX5Sw6s3kxCBgrFJ/iQAxgHN9
	H4c0MyyDrVZNznDBUkf5oaMzxNNagu9f8Ic78LbYstq+6mdtyFOS8LLTMTWCFnxUBsIjjtsis=
X-Received: by 2002:a05:600c:a013:b0:490:bd66:e526 with SMTP id 5b1f17b1804b1-490e5645531mr18974935e9.32.1781165372456;
        Thu, 11 Jun 2026 01:09:32 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f2e4b18sm62424552f8f.10.2026.06.11.01.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:09:31 -0700 (PDT)
Date: Thu, 11 Jun 2026 09:09:29 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann
  <arnd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
Message-ID: <20260611090929.54e388c5@pumpkin>
In-Reply-To: <5572678c0db875297d80a1401ed2567326bf50ad.camel@dubeyko.com>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
	<45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
	<20260610100944.3c5a5771@pumpkin>
	<5572678c0db875297d80a1401ed2567326bf50ad.camel@dubeyko.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Jun 2026 18:05:02 -0700
Viacheslav Dubeyko <slava@dubeyko.com> wrote:

> On Wed, 2026-06-10 at 10:09 +0100, David Laight wrote:
> > On Tue, 09 Jun 2026 18:04:46 -0700
> > Viacheslav Dubeyko <slava@dubeyko.com> wrote:
> >  =20
> > > On Mon, 2026-06-08 at 10:55 +0100,
> > > david.laight.linux@gmail.com=C2=A0wrote: =20
> > > > From: David Laight <david.laight.linux@gmail.com>
> > > >=20
> > > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > > the
> > > > prefix
> > > > and name concatenated together.
> > > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > > for
> > > > the
> > > > name to ensure it really doesnt overflow.
> > > >=20
> > > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > > (But I cant see the copy in the old code.)
> > > > I am also not sure why the buffer isnt created "just long
> > > > enough".=C2=A0  =20
> > >=20
> > > What do you mean by "the buffer isn't created just long enough"?
> > > And
> > > what is your vision of correct implementation of the logic? =20
> >=20
> > The old code is: =20
> > > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > > =C2=A0	if (!xattr_name)
> > > =C2=A0		return -ENOMEM;
> > > 	strcpy(xattr_name, prefix);
> > > 	strcpy(xattr_name + prefixlen, name); =20
> >=20
> > It would be more usual to do:
> > 	size_t name_len =3D strlen(name) + 1;
> > 	xattr_name =3D kmalloc(prefixlen + name_len);
> > 	memcpy(xattr_name, prefix, prefixlen)
> > 	memcpy(xattr_name + prefixlen, name, name_len);
> > So that the buffer is allocated the correct size for the strings.
> >=20
> > (Not that it really makes much difference whether you do kmalloc(32)
> > or
> > kmalloc(1024) for a temporary buffer - both come of a per-cpu list.) =20
>=20
> The xattr name cannot contain more than 127 symbols [1]. So, the buffer
> of fixed size is allocated to keep any potential string inside of this
> limit no matter of size of the prefix and name. This is because we must
> have string that not longer that 127 symbols. If it is longer than
> that, then something is going wrong. Following to your logic, there is
> no big difference to allocate the buffer for 127 symbols or for precise
> length of the name. So, your suggestion doesn't make sense to me.

This code has no idea of the number of symbols.
Assuming that the callers haven't passed something that is overlong
is just asking for trouble - especially since it doesn't matter to
this code.
The caller is unlikely to know the length of the prefix - so may be
passing in a 'name' that is nearly 127 symbols long.
So adding the prefix can generate something longer than 127 symbols.
The called code has to handle/detect that.

>=20
> >=20
> > What I couldn't decide, but seems to be inferred from some of fixes,
> > was whether a double-terminator was needed.
> > (That might just be the attribute value.)
> > One of the related functions got fixed to zero fill a buffer in a
> > loop
> > because (AFICT) something was reading beyond a '\0' terminator. =20
>=20
> The rest is dedicated to Unicode peculiarities, as far as I can see.

Eh? a UTF-8 encoded buffer is terminated by a single '\0'.
The changes that stopped 'old values' being used on a later loop
iteration seems to be fixed by zeroing after the '\0', but neither
the code change nor commit message makes it clear what was fixed.

>=20
> >=20
> > This code does seem strange though.
> > It seems to add a text prefix here and then the called function does
> > string compares to find out which prefix has added and than act
> > differently based on the prefix.
> > I didn't try to follow things any further. =20
>=20
> There is no strange thing here. Different prefixes are processed by
> different logic.

So why do string compares for the prefixes?

>=20
> >=20
> > I also don't know if 'name' itself can be 127 wide characters (before
> > the
> > prefix is added)?
> > The fixed length buffer isn't long enough if all 127 characters
> > require
> > 6 bytes to encode. =20
>=20
> The whole string cannot be bigger than 127 symbols.

'cannot' or 'must not'?
As I said above where is the actual guarantee that the limit isn't exceeded.

	David

>=20
> Thanks,
> Slava.
>=20
> [1]=C2=A0https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/h=
fs_common.h#L78

