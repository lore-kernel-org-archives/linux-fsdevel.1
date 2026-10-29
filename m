Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793306933;
	b=QLNUEyr7i5bANPP23LxeeVV1z47XOALbLfRxP7lmMsv/mIOaiyCa0UeVCRZEzGermXd6
	 TPgiMnc4Kd5uM/K1NqC2g7WWrTgk/JACBYbRBcOwcw6qbgUQBBXAfuHq2H2uKsm0WV/zq
	 3q+ewQZtLHfVNVKASRfJ4FFIQig8rJpvhTCHAvo3QLuhX6XsMe5juM7IxqjHz9yGA8UxT
	 RA5V/9vS2xppG/5bG5vxrI7of7vMgIfbEfKux6/yZxKoXtrk607YFp3e46KU8IrSD1XG0
	 MwOvK7VFscuV+F0mT0pZDSFST5Eqs5rCX6gONkQwY7YbKz/irf6KtSZY6N6tIjzbnzw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793306933;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
	b=jsK93sGN6T6N4SDb5mFY2yX7YtR4rlUeNpntXRJ9la9YGeC+79zs7TA0MbDnragh51uJ
	 kHMqfCXWboNOLNP+mSx+jKSgntWMnEgYfbEv7MJfBI095ZmOVd+XKFKem0bPBJKQd/tu0
	 dxBC75Lvi68Kt7GPRYlDd4NWMBE2wLyRM1Dck9MRDCZNpQUDC27M2byvR//Awuzp4cCSQ
	 hjTL16GfQp3c4UiS3jFpB0nS4qSTAUhoTobseYmCH2Zo7iwhQ44lu+BqgWUXaU7dDuzBr
	 YQo7aEExiHXrTcb01p3Urx26vQGwHjKL9C2dX2s1/Og/BLi73VxpXR1Kv/Ohm1VDWLQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6qpsRbY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDA4606A322
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 20:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FDA4606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e6qpsRbY
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c49c32650adso12230366b.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Oct 2026 13:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793306931; cv=none;
        d=google.com; s=arc-20260327;
        b=oyvfr0CUNEal3PXUuRT2wKpg03caQNSEk3zkbUhjXVpoaLX1aOLoTrOfPckhxzan3s
         GRfCxy2mB7cZWDVeQI4hI4p4u1bKPl8xPNGYaihB0pU0KvtTpvOPZqINZvvq0Wc6yY8Z
         mXqZ/vYzJZ+RIYUb2hutbveNJphu6aFyhDhadxXrdeexc+93uLSy00LcP8y51xFeVlxf
         /jaPCIqwJkS0oqUIGadexL73QjioDLjz2eXhoP6zWwc4bEoQqpeUpObyvUoB/6wBMxX/
         PutxvSSdH5XQMNCVJfbj1XYIXeDCq857JW46KBQ4gkEiEswZzgp9TToc6ZD5IANysOd/
         GHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
        fh=3gWim/aFyYRQmTXXki/4vWI29ZfVjoiaaQZ7ar1fBuc=;
        b=j3H2vsJkGGfcp2pcYy6A+Dj05O8kMTubeVBoQA2RCDacrDRFWGAhMFQ0sgAWdmOHhF
         eZqR03K4gJ/iHRI4tZclGmXTDYLx2H9c/BsUkJAyIVQb5JGsyT4ML8n/WubTYxdV3wZS
         kuh+lSgNZvslsnODdd+bniREY0IAhvQoPla+etIj7k+Vwgq1z5zcC81p3L7IW57qAW8F
         /Ei1uUjR14tYWVvChfNwfYPfJSkKP3d/8m5hZ9vvP39/E98irKXOeO9A3RJpmNRPxzx5
         6bsADG6Wzo9mnRgjVYM/njma+EwN8TpBn8M7k2sY/WtsbOEjmG3/3xh0/5cSF4tL67Dd
         7NgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793306931; x=1793911731; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
        b=e6qpsRbYjFT0eIt/LKJKfufcTrvVesamgHTe/tH+aPIWH5KmPg1PVTVAgHs87VWxjb
         hfyh3D7pOXlzG9/U+ZkrI4CbYboqDvLcTyMrHFg/fGyMjcV/0RaMmQuyURxYOj25U6h6
         DHS25YpphlHLb5DB97Qkd1bG5c2FNb0Kn9KdXxz3WGf0Kr8Q+pzXtLru4UJ/iY+OacT+
         6LhxXXaSNvTVN+L/kdoYQoXDDcxDT8IaiT9HClxLzSgLG5OFSN+DTjb9n6HmCuhRMwtC
         Md7VJle2Ac1Tp2NOISJmYRj38oqujAMi2OdxGscavYh4HAll3I+q311CgoL5hiP078On
         GOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793306931; x=1793911731;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yyGVEok3SUnsRUPDNzW62kR2XDnd9rtJfHAqIMU3cc4=;
        b=IChYiPUWIptKB9aFDELfSijwdwUNWyGL+gG5oT9nRHjmEFTRp23hOhlAE4d0fhjafp
         umBMYyD35vDrqPlhKA70mubzVGnC3nNk3P19gktzccv3cuPilrufno6xOLEmEq1w/QTQ
         muDKUvxZx3Tdje/nuZVcA/tXBXz9gYCPCcGACMGcFBJHsSMF99dR7UdzblSWVufsEz6q
         Tm7B7zDRV++leFLXtAVAmHHhhzXXNIpcsmWRb6GwN1xbghkHAegUlVH3hiudVD0NoqF2
         GpD7CXeEfjvU1BnkuDZGvcPwOi6+rKGQ4bUi6DX4Hv94DecLg48h/t8W9nXOYmxJ9ej3
         X6Sw==
X-Forwarded-Encrypted: i=1; AKwUvBxTfz+T9uMHHoxFENF5fnbmfSNPzD1l1ABkMVk/1bhU/4nDVNvxHmGHPnw4NebZpuvyTN+s5qJXFzmeDJ3c@vger.kernel.org
X-Gm-Message-State: AFq9FYIzgJScQz+KC78eyIO7O8mixgAa22vEfrVPV2YrfTTNNGmZNrSz
	aOsDhBfkQkXf8bIScgtYujf6OlFg8LVWmGcWs5Q6AXehi8jD0tTW7+yjKsFJ1re92IJJgEg7ClZ
	tIxH8e2PSkR4sorA2p2jMFsqrOf6HEbY=
X-Gm-Gg: AYBFou3Y8J9sgkzEN7Wiz/9sm5LGPSWCaoeSNZEDK3xhhztPXKHAE2N8u2/5N1/N4Bn
	G4DwKdTPF84uYN1rf/lp1/zrEz8yoT0SL48v9lu2BF0fFroMfqG6wc1T3YBKq5S6gdDqzyfHCzW
	FfcMKy0S3Oz4eEIm2Ba6j+TyF0s3HzX/1HI1TLawIsP38mdbblx/8xL6xK86+wz+IAh57er6LGx
	KAFxaKe64Va/YVE+hvynR2YEvAESVt6cJWEx2dlSm56gUwL8QemDxpf/Q/yu4InQKnRecxIsAXv
	6J2sHQrxqENDJNr90si1rm5ubwFxOcYsm8TNyYOG8jl/DO48m9XlbOWuwmh6H35GV46jn/97lWq
	a+H3vvIvjCHlk4PGKWUNw4ynsss3RO+tlCzN8PYm1jIEVzay1cY+0rt0Uo1weVOvPoa1GQmg=
X-Received: by 2002:a17:907:9c06:b0:c38:ee33:2931 with SMTP id
 a640c23a62f3a-c4ca7b5f423mr21132966b.37.1793306931390; Thu, 29 Oct 2026
 13:48:51 -0700 (PDT)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029174907.98721-1-dennylin0707@gmail.com>
 <CAOQ4uxhc6a5jdwj+o_pCByYpwOC20=uHj0mi4D5n3UgrTqR7uQ@mail.gmail.com>
 <CAGEkeHdYqS_9wipk9oy=ofo=KbNpOwccuqVEYPg0LqzCykXUrw@mail.gmail.com> <CAGEkeHctUoNiE_zWUgyL7zoKdfb1JFaMnUuV80iqnrHff03pVQ@mail.gmail.com>
In-Reply-To: <CAGEkeHctUoNiE_zWUgyL7zoKdfb1JFaMnUuV80iqnrHff03pVQ@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 29 Oct 2026 21:48:40 +0100
X-Gm-Features: AclHuK-Givt611yWPPOpcfU_eK22SOr0dtVokP5D-0hsrLczRm81zw8Y8xkfvoY
Message-ID: <CAOQ4uxjwSctaXOXA4o+=F5HT0zT0cbtPbxMvAhBQXLT-4gOZ3A@mail.gmail.com>
Subject: Re: [PATCH v3] inotify13: check rename cookie pairing after adjacent moves
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: ltp@lists.linux.it, jack@suse.cz, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 9:23=E2=80=AFPM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> Following up on my earlier reply, I'd like to confirm that I've understoo=
d
> your feedback correctly before sending v4.
>
> Below are example outputs for the seven failure diagnostics.
>
> 1. Extra event
>
>     file: got unnecessary event 3: mask=3D0x40 wd=3D1 cookie=3D123 len=3D=
16 name=3D"entry"
>
> 2. Wrong event mask
>
>     file: got event 1: mask=3D0x80 (expected 0x40) wd=3D2 cookie=3D123 na=
me=3D"entry"
>
> 3. Wrong watch descriptor
>
>     file: got event 0: mask=3D0x40 wd=3D2 (expected 1) cookie=3D123 name=
=3D"entry"
>
> 4. Wrong filename
>
>     file: got event 0: mask=3D0x40 wd=3D1 cookie=3D123 len=3D16 name=3D"o=
ther"
> (expected "entry")
>
> 5. Missing event
>
>     file: didn't get event 2: mask=3D0x80 wd=3D2 name=3D"entry"
>
> 6. Identical cookies for the two FROM events
>
>     file: got second FROM cookie=3D123 (expected !=3D 123), wd=3D1 mask=
=3D0x40
> name=3D"entry"
>
> 7. Mismatched cookies for the second FROM/TO pair
>
>     file: got TO cookie=3D125 (expected 124 from second FROM), wd=3D2
> mask=3D0x80 name=3D"entry"
>
> Do these follow the pattern you meant?

Yes, perfect.

> In particular, would you omit any
> of the additional event context, such as wd or cookie in the mask-mismatc=
h
> message?

I would keep the event context in 1-4 because that is the common practice
and because in this case the INFO is not printed.

I would omit the event context in 6,7 because it is already present
in the INFO message and irrelevant to the error.

>
> I'd appreciate your feedback before I send v4.

Good idea. I should have led with examples.

Thanks,
Amir.
