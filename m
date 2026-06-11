Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED6374C14
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2026 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139909; cv=none; b=btoEEF77y0gqijDklztAKHlKqTYGBKFO1nDsvmWU8VC7PbI2vC/4S6vLfwxSPSzxo60JBvspysQGcknFXqgqih4MzffkwdDa/A2vS2JZN27R85/rkZJuoDQj8FLDMpxTkfAIw0M/WleIiNNOUvOgN8DVT0/V1+RmmFvk75j+JEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139909; c=relaxed/simple;
	bh=WxCHRqAmkvRHQbuXecj9tSE4fKz8RSxawAjYTHiE+nY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HM/phHC/LjYNA3dzsMjs/NEMg8dvpJyr9HXWcpnIfpjTeRNl/8nrDTYu4JKlwqZ5aQDhDixS36ru+hF6Nj3WSijMDWbRCI+wJygoNxpi8nudYQBDeWqtwIB1iM+pxS2jtZCgXBuymf/v/GyZYRjgaygfGpFrzdjt/wGMuOuZ2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=PVfjvszP; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="PVfjvszP"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396753f343aso73694041fa.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jun 2026 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1781139906; x=1781744706; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dxpulzw2wDpdVQd4WWINrnglvmJJQ6my6ZjYhlADIrA=;
        b=PVfjvszPwrZGE9Cxmn3BuUfHVaMu0xuKrTgbfQmMnGHbqtx8oCIwawjxQ1GwUFRtxf
         tEoTJild2Gc+kw2mK3tdkjXVG6MqbtUNTU7k83W5kuoKZu/LqQKsZ1sYsmbF+nrQ7imE
         5VjNivkfXBHPS3xZxipNqlUvcLH4fZN/xgjvLobhjrxLlvlufG3mCAR37XdcNUu3SX6T
         D7IIyHrz37sfFRg2jMB+FMtQfeDdDKyalYtTfOpNld2T3ya1821OotD0zgcn4BYWA4fF
         zGqg3t08lzNc9Wim2mfRq+kOeMdiKe58nK/Rjx6wNVkJlj0Hm6Mm9S3mRYpd72mt/5DU
         DSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781139906; x=1781744706;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxpulzw2wDpdVQd4WWINrnglvmJJQ6my6ZjYhlADIrA=;
        b=CjA0zvs2BJSaQjSt26qU/RkkGcOpi9GUztRfq8CPJN+8loC9TUWUTVxD7cYbWzV2kb
         DXewMz/X4py7AwKjqLpkfkMO5BhPFsAb8N5EdMTFOXg4J9eVqhI8cx1Hi2ImAZLYh9Wd
         vHhPLrC6An07UUl14smhnx+W82YLvVeOQxYN08nVS4tHO21RxIkLB4D5O0rmrpC1KH42
         ae712GeVZnfZnTMfxEq27HiQOQxCgnjH3aJhMdTfLRksL17bV6xOTmQtY+75xZcknd6i
         8+ExYBLCIZYuMG/o9dhms/TtKMPsE/8hXj3kpSa2U9hgcmq/UVknPijnVfctzZuhWlF1
         Ic7g==
X-Forwarded-Encrypted: i=1; AFNElJ8W1vp6vMkNbMDmnYiJp5BhU5Wosl7LLGyll6zr64+Jx3hIfSHfX9qTRQBLsW0xzzBwXLKz9YpqYYght9iP@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VdHN/GcTXQvi4dXx6oGU8XuU6TE4u4o7c4APDkF4URxDybkX
	UqCyQgINh8C49dYNaRhA4TWgmcS0Ii3CCnoIATr8XmlNWOJrN437S6Q1tv7fTmZFJJk=
X-Gm-Gg: Acq92OFA3l0A1Yz4MrFxIEKAMvmlsdQl9iifAKo+din3VA9FNkn93cJQgq7VKRglpu3
	n7uLYQR7bfxVpoQDIbE7VM47Hu/tNq3fi+A9fvkgNTnjJ/qx6Agv2fv9fav/+4ft8yj+wao6CN5
	Q2yLBUmtKZcp7VOhRaIYLfuUMCPI2O0K3ccwqhgBu5XkHQ02nbeAb1YGN6wUmjAgsyId73ukk7u
	KnTTukAohSgB+OE4ZEgeciRzjaT5ppb1n8Hnz0vRiZ+7uwJ72xrrg2Uq258zvy6imdsAUxwkPAe
	INa+y455ZTSyvSPSpcofDeToyNJ1BdyjoXve3XS0cPysSe4GKP85kaWeAfCEBYMGaN/23hc4IZB
	FDamxrVJL3JWt+k5gwzvOKdXyltPbdUcOKJlTT7CX3h6g16eYPZdQF2PUz22juXhA/R++Drwab7
	evkiLnUBXcdRCASY9FztDG1LGfngCV/kimQqO23Z5X4z1v8rg0XIG9gZPMxcE6M8rQu3HwJn/Pz
	7jzNCvC63PWlPOTm+40C/CGoygwA42rBe9ZA0hSKjfQ08IidAGl/wvbQuqNtBQvsy0=
X-Received: by 2002:a05:6512:b89:b0:5aa:100a:8315 with SMTP id 2adb3069b0e04-5ad281b4dacmr152377e87.45.1781139905317;
        Wed, 10 Jun 2026 18:05:05 -0700 (PDT)
Received: from [192.168.1.246] (broadband-95-84-186-252.ip.moscow.rt.ru. [95.84.186.252])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fbcbcsm5907196e87.20.2026.06.10.18.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 18:05:04 -0700 (PDT)
Message-ID: <5572678c0db875297d80a1401ed2567326bf50ad.camel@dubeyko.com>
Subject: Re: [PATCH next] fs/hfsplus/xattr: Use memcpy() and strscpy() to
 build xattr_name
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann	
 <arnd@kernel.org>, John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>,  Yangtao Li <frank.li@vivo.com>
Date: Wed, 10 Jun 2026 18:05:02 -0700
In-Reply-To: <20260610100944.3c5a5771@pumpkin>
References: <20260608095523.2606-39-david.laight.linux@gmail.com>
		<45e421ab38cfdbddbc0d34970a2db94902ad634b.camel@dubeyko.com>
	 <20260610100944.3c5a5771@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-06-10 at 10:09 +0100, David Laight wrote:
> On Tue, 09 Jun 2026 18:04:46 -0700
> Viacheslav Dubeyko <slava@dubeyko.com> wrote:
>=20
> > On Mon, 2026-06-08 at 10:55 +0100,
> > david.laight.linux@gmail.com=C2=A0wrote:
> > > From: David Laight <david.laight.linux@gmail.com>
> > >=20
> > > xattr_name is kmalloc()ed at the (assumed) maximal size and then
> > > the
> > > prefix
> > > and name concatenated together.
> > > Use memcpy() for the prefix - its length is passed and strscpy()
> > > for
> > > the
> > > name to ensure it really doesnt overflow.
> > >=20
> > > Prior to bf29e886b242c the buffers were smaller and on-stack.
> > > (But I cant see the copy in the old code.)
> > > I am also not sure why the buffer isnt created "just long
> > > enough".=C2=A0=20
> >=20
> > What do you mean by "the buffer isn't created just long enough"?
> > And
> > what is your vision of correct implementation of the logic?
>=20
> The old code is:
> > =C2=A0	xattr_name =3D kmalloc(xattr_name_len, GFP_KERNEL);
> > =C2=A0	if (!xattr_name)
> > =C2=A0		return -ENOMEM;
> > 	strcpy(xattr_name, prefix);
> > 	strcpy(xattr_name + prefixlen, name);
>=20
> It would be more usual to do:
> 	size_t name_len =3D strlen(name) + 1;
> 	xattr_name =3D kmalloc(prefixlen + name_len);
> 	memcpy(xattr_name, prefix, prefixlen)
> 	memcpy(xattr_name + prefixlen, name, name_len);
> So that the buffer is allocated the correct size for the strings.
>=20
> (Not that it really makes much difference whether you do kmalloc(32)
> or
> kmalloc(1024) for a temporary buffer - both come of a per-cpu list.)

The xattr name cannot contain more than 127 symbols [1]. So, the buffer
of fixed size is allocated to keep any potential string inside of this
limit no matter of size of the prefix and name. This is because we must
have string that not longer that 127 symbols. If it is longer than
that, then something is going wrong. Following to your logic, there is
no big difference to allocate the buffer for 127 symbols or for precise
length of the name. So, your suggestion doesn't make sense to me.

>=20
> What I couldn't decide, but seems to be inferred from some of fixes,
> was whether a double-terminator was needed.
> (That might just be the attribute value.)
> One of the related functions got fixed to zero fill a buffer in a
> loop
> because (AFICT) something was reading beyond a '\0' terminator.

The rest is dedicated to Unicode peculiarities, as far as I can see.

>=20
> This code does seem strange though.
> It seems to add a text prefix here and then the called function does
> string compares to find out which prefix has added and than act
> differently based on the prefix.
> I didn't try to follow things any further.

There is no strange thing here. Different prefixes are processed by
different logic.

>=20
> I also don't know if 'name' itself can be 127 wide characters (before
> the
> prefix is added)?
> The fixed length buffer isn't long enough if all 127 characters
> require
> 6 bytes to encode.

The whole string cannot be bigger than 127 symbols.

Thanks,
Slava.

[1]=C2=A0https://elixir.bootlin.com/linux/v7.1-rc6/source/include/linux/hfs=
_common.h#L78
