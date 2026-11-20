Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185854;
	b=h/7j72KdurxfCoSGGMUmFil1WxEax3Xd9tPp3S+6kHa2jVkn2+nq4VvBRXhZr0r8v3DQ
	 sM/Jk2CqwKZ2DZDqBG4A1n7JIPSvHcJyCDasCUOT0nt1rLs6FXl1XxfyQwnhepWz/p+Ds
	 1kP3WZ9K4Lq8lO6/d5Hp5tnb3UTrXETGDWmyUH3SSzuFGvGSJRRg/LoZycL5rIMYhEEAH
	 SrtQAh23z5zfp35kwDXk+YrrCI15g2DbdZzMDn1tQdaXzPIWgvyOSQotBn2Up7KYB1eo2
	 XNiweTTT3gmVsXEzVHwql6qLYq4kRRkMejf76l1X/3uiaqiaYGQ68awinC/it8aVwkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185854;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=aeb62NrfYX2nWbFpQ3h7rH0au2pU37+u990yshAdsq8=;
	b=tH5vIuPo6Aqzr6cDM/mjb6demW26rIU7p6wRfcziAMzvZijLLdHfzYKuTuYUVh/ldG86
	 hGx3zMLlkMyZVL78TXHFAKRTFkY/XGPWcoD4CUdgIqKyKTzcytDVpVdTNEFrPCgmbHipi
	 MoZd5d0BNJS6B+xWfEI8sKnDcOHshzt8tXVxSJMnVtX7gwf0jltLCppDk84F9JHwwTBis
	 m/wJ7GOK7C7CcDVP8fJo6uErviK/hWhDD5NaGw8nhTCBqxoqCy5uSpe/ZT0D96hwQsoSy
	 iTKGMGks6yO8PipEiIONYCUIgFlAuVtG1jt8Tk/jDLL3nbFDImj/JTVgT4W7AJaSEUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UCx2E0Sw;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D27606A325
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 14:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6D27606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UCx2E0Sw
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e09aa5264so508507f8f.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Nov 2026 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795185852; x=1795790652; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aeb62NrfYX2nWbFpQ3h7rH0au2pU37+u990yshAdsq8=;
        b=UCx2E0SwKcK/oqyYNLOz686VusYmii+3mMDSe2hm1s34x/9j7y81gtRcvRwLvYBz3L
         8OWonxeJ7ONGBIAdCYN28kX+LRG6+zE1qzjaKqtJdHF3MJBPWqGI5u3OnZMZ4nUYhE9m
         PEaUWEoqsvQP3IAgHgg36VjHmqvLstmO20zMnptGeWfnBQnfV8Xwbcf2i+5+HPE/je1g
         UffyYR0okyEW/XxdVXBfUQ2+CTA3+deWuJyIBQP4+m3bQJNmt6Az6/sbA917Q6G5mzbK
         Rj5vUQAl8Up+44D/OFiKqlCYJFj+9wTD4uBgXkGE6VmgSc/N2pGJihXdIl+6jSPw+Tjd
         ggNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795185852; x=1795790652;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aeb62NrfYX2nWbFpQ3h7rH0au2pU37+u990yshAdsq8=;
        b=TcnXG/FwgxRXW32tnbFYvF2iyVwQEBJbJ/FZUGDSXWS3Ptss2eHCMAtYY9U2O5vzEw
         mdCQD5/PS1OHXOBn8T4Mg5FlJ9+oOk1hYLaJ7GwIyhfDF4zbtBQE0wFYLZeqKMWvC75P
         IGqXAY6HOGzXkpleOCUUzbQoSaijAerTmR+ppXr2ct6rdhy5I0mjJ2ozPwAmV8ePv10S
         uzR0auIWB4ESpJqCCQRW+IW9/H12KjzM+V631/IVwBXd8TtHuHYstJxrH+UYAj6OiMd9
         1sNhzVcwBGQPC2SYXiLORXzeHtvKQfgliuSDxJECcQ++ReOsK/mEyO9m3Sd06RDqu3Rs
         Uv9w==
X-Forwarded-Encrypted: i=1; AL+hErGV9USOKAC/n5XqOSuHmZwJU/yq5KkqkrPnOX3ifaLsYga293GslA5sVoCgo2JLKkFIAkrS77Xku55XFeFy@vger.kernel.org
X-Gm-Message-State: APuU4Z9Jh4kKJxh5PC/8XlB3RMGEQ3Ow0Vb0qe+w2q5LMz42BOvyLG+T
	D8erFvkPLwryFUc2ZRCEp4+C1nO2nH6bFTLcUUtWCkir99ohsROgJjfa
X-Gm-Gg: AZFdTZexyevrqVuZV8i27FGwdX67kbrIP9IFpk5jqIdZz6wq/bzQBbNiGgFKJEto1PK
	4h7KfkzTNQsRcxOXmYPw6nyyEkzJyy6lWOddRYFhc/OwCirIBhiY+wZv0KZoJlFQKTOeNd7ONIK
	gjzbbDqT7Dw4Eixiqox1yZmMqUB8XpCN7kcFKJwTDsVDx+tzRJa1szlPDBKPG3it1kqJ3Rf4mb5
	2mgAMzzAOO+rlUOLj8PEX9GIBT5/RR3+5R31QuBTOJFAwifqe9jJgCK5h2eHaz/baqYzjtS/SZP
	vwh98X326xPyeh5BGO5i+UGqRtxTTCELW3gkP1ky4b/vkTyfXiIT5t4Gb2sUH3/MBdiS0/FEAoW
	rJmixdUkmqhkC7v9u2oUOA6aDteqnafxBDjib6z3UIbOwiTO1uy/Zz/JKjW5uRIkrxFaYnuQ4gH
	fptWfuks35Jr1184JHVkCes2kJvJQwa/cu0XGMwxzwd66ep9z5hIQr//n9tNbXOqJ7ILP9rROT2
	zPzHBeRIQsVbxypT+1YFFV7qT2NnVqhM+cM0QI0ziYBWoMNgHXII0cocObhlCAqDWq/XA7Qp3BK
	Nnc6qVq3g0roaieMK5HfeEEzeAaM9FqJ5mUO3FIkIMu2PQ8a
X-Received: by 2002:adf:e014:0:20b0:491:8462:20cc with SMTP id ffacd0b85a97d-4abb400c0cbmr5198457f8f.37.1795185852061;
        Fri, 20 Nov 2026 06:44:12 -0800 (PST)
Received: from localhost ([130.192.98.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf62f7sm6426849f8f.13.2026.11.20.06.44.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 06:44:11 -0800 (PST)
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=8a2bc4e8bd35bb6d32db85e9ae6f5058abdd79d3019902d3de598560ffbd;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Fri, 20 Nov 2026 15:44:07 +0100
Message-Id: <DN049T7Y67NZ.10CIWW8DE6PP5@gmail.com>
Cc: "Lauri Gates" <lauri.gates@gmail.com>, "Dave Chinner" <dgc@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Christoph Hellwig"
 <hch@infradead.org>, <linux-xfs@vger.kernel.org>, "Carlos Maiolino"
 <cem@kernel.org>, "Christian Brauner" <christian@brauner.io>, "Darrick J.
 Wong" <djwong@kernel.org>, <linux-api@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <linux-btrfs@vger.kernel.org>,
 <ocfs2-devel@lists.linux.dev>, <linux-nfs@vger.kernel.org>,
 <linux-cifs@vger.kernel.org>, "Theodore Tso" <tytso@mit.edu>
Subject: Re: Concurrent FIEMAP on reflinked files serialises on the AGF
 buffer lock
From: "koraynilay" <koray.fra@gmail.com>
To: "Amir Goldstein" <amir73il@gmail.com>, "koraynilay"
 <koray.fra@gmail.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <av4Hn9u80fs8iHZ6@dread>
 <20261119095943.85048-1-lauri.gates@gmail.com>
 <DMZ4VQ7SZ07T.29WMPQ0BQZGSS@gmail.com>
 <CAOQ4uximow25oc=3XEN1ATgQvonQaTXtDPmQufxo75tJ=e355A@mail.gmail.com>
 <DMZJDGMJ1RVF.32ES391JKNFGP@gmail.com>
 <CAOQ4uxjVQ9cjV=_jBjQtNg9zCuWUEJT9KNYMKV+1jwBkHen5OA@mail.gmail.com>
 <DN03LWNSDYP5.11FTQ5KCWU2X7@gmail.com>
 <CAOQ4uxg0oq7VjhSQ0h8dBucdPfON2Q6tJQQqUy05sCaE10QRoQ@mail.gmail.com>
In-Reply-To: <CAOQ4uxg0oq7VjhSQ0h8dBucdPfON2Q6tJQQqUy05sCaE10QRoQ@mail.gmail.com>

--8a2bc4e8bd35bb6d32db85e9ae6f5058abdd79d3019902d3de598560ffbd
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Nov 20, 2026 at 3:35 PM CET, Amir Goldstein wrote:
> On Fri, Nov 20, 2026 at 3:12=E2=80=AFPM koraynilay <koray.fra@gmail.com> =
wrote:
>> > With non-zero xflags_mask, internal contact masks
>> > can be used for -EINVAL not for silent ignoring.
>>
>> What do you mean by "internal contact masks"?
>>
>
> I mean that users do file_setattr() with a bunch of flags
> some of them are just ignored randomly without any any way
> for user to know about it, because this logic is some internal kernel con=
stant,
> which cannot and should not be documented in the API.

Ah ok.

Thanks,
koraynilay

> Thanks,
> Amir.



--8a2bc4e8bd35bb6d32db85e9ae6f5058abdd79d3019902d3de598560ffbd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRJ2XvJtXGwULYEerQ0bnTtJTDoOAUCawBctwAKCRA0bnTtJTDo
OG67AP99DCLnFsLMHCsRAeUitR3pAiNRglGbALKnTbw7U718dAD/Rbb718IIJvnz
/T8g9StMlY2VrgWntvlMz+RabJ8OUgY=
=dJIP
-----END PGP SIGNATURE-----

--8a2bc4e8bd35bb6d32db85e9ae6f5058abdd79d3019902d3de598560ffbd--
