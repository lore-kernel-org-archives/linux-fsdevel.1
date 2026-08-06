Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C48391832
	for <linux-fsdevel@vger.kernel.org>; Thu,  6 Aug 2026 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786035531; cv=none; b=kZ3SyPoh4WX1MeY3ho30BUitYDeQi2qJzXI5SMuGppew83vj/BjsEHGlD4csKif1dF0DWEN2MQG9A0vsbUezCWfSSHuGPhJUQX5DIiVKDZfnaz3cVgrB7j6wdmCbmEkiA/M0rAxesMbX9u6LjUwg+kIeycYuigeCLN0Eg9dO8Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786035531; c=relaxed/simple;
	bh=zDjR74WGb5cEe4crVD8tms/rTlSv7BcEL4nYLlKDgqk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a6SPjYxUrF2OQdny92bQrLRVtkbj7nYSJcgg2x8AWSekqrbnrOVxpJbUTZz5vnSCdzIwhAFQEZuQcjUHWvC2fvVvr3EzI8IUd/kLg1aiZ61JFOLvbhw/FoXNnPJw6a2UcIKlJTZme+NuWSlYjnLJYH/F40P8x+S8R1/KJvFegyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lukasldc.fr; spf=pass smtp.mailfrom=lukasldc.fr; dkim=pass (2048-bit key) header.d=lukasldc.fr header.i=@lukasldc.fr header.b=D+rW87GF; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lukasldc.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lukasldc.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lukasldc.fr header.i=@lukasldc.fr header.b="D+rW87GF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lukasldc.fr;
	s=protonmail3; t=1786035517; x=1786294717;
	bh=zDjR74WGb5cEe4crVD8tms/rTlSv7BcEL4nYLlKDgqk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=D+rW87GFXmg73GfEEq7Arf+n5JMN+3KbIgD6lKmgv7hyYmoRVoFQ4pooWkEOSY9hC
	 cbBx0vx3an3mcae0ewTU728tDCnwGFgi7Fq/Ehi+js/UBwIHb82liNqWx3KbuLMPGJ
	 1UUWat1lfuA7xJHATOxH2W1D3UnmFOvVydbUXfxELYBHsRvV2tcaypOpLRaGJ8r+LB
	 j3p4DSCCrhSgaZSpjpstdqYzM9kDvq9u3FZo7Q9hnJIB6lR7SYYWmykqih7QYEv1SD
	 K5gpGGNgs7B+2IJER+1dPSUhdPxVhYjSNm8dK39te3FLJePcVDgUpoawOD3gTDhNCh
	 e2P0gxOa8YuYw==
Date: Thu, 06 Aug 2026 16:58:32 +0000
To: Mihai Brodschi <m.brodschi@gmail.com>
From: Lukas LOPES DA CONCEICAO <contact@lukasldc.fr>
Cc: linux-fsdevel@vger.kernel.org, ntfs3@lists.linux.dev
Subject: Re : Re: [BUG] ntfs3: IOMAP_INLINE mapping exceeds its page - BUG_ON in iomap
Message-ID: <KVTyVEuJVJ64fthW0XFP0keHPuRYrmTizNV-YBxUEf0UTRjuC9YiY5KUMfNC5Oo8q4AcM90C8ZqQQ33EbO2W8inK6oaBN5ZJCKgnbpYuekw=@lukasldc.fr>
In-Reply-To: <6659036b-2f4d-44c0-bd1b-3d76b87a8476@gmail.com>
References: <4_qSHDGTzev3i2hKqtp_9TpB7p5JWTBKwOucZ49wWdoLB9TphDDLl-QsnEjjPLerlfuk-xS9J_qL7TQefUZxd3qW9MttPZT-UgBWJW9B_eE=@lukasldc.fr> <6659036b-2f4d-44c0-bd1b-3d76b87a8476@gmail.com>
Feedback-ID: 100544131:user:proton
X-Pm-Message-ID: c3a450ba51ac5215466c2c09f912f777d96166ea
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------a8e902d9eaec74bed9784c221c39b56b40578f40b1f3dd86653d25bb7f64b244"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------a8e902d9eaec74bed9784c221c39b56b40578f40b1f3dd86653d25bb7f64b244
Content-Type: multipart/mixed;boundary=---------------------640155ef14d6b4ed0056e13a43d7bdd8

-----------------------640155ef14d6b4ed0056e13a43d7bdd8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

> Hi Lukas,
> =


> This bug has been reported multiple times.
> It was fixed in v7.2-rc1 and recently in stable v7.1.5 as well.
> However, there are still other issues which cause fs corruption
> with Steam.
> =


> Regards,
> Mihai Brodschi

Hi Mihai,

Good news, thanks for the info !

Regards,
Lukas
-----------------------640155ef14d6b4ed0056e13a43d7bdd8--

--------a8e902d9eaec74bed9784c221c39b56b40578f40b1f3dd86653d25bb7f64b244
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsG5BAEBCgBtBYJqdL0rCRDuBpvbNc2xoEUUAAAAAAAcACBzYWx0QG5vdGF0
aW9ucy5vcGVucGdwanMub3Jn3InUOO1IshihUOR3uFTyJJm3q7gE2G8JnEtb
By5hheUWIQTaXN155Azon7TFONPuBpvbNc2xoAAAGMQQAIBWrfCKqJoHn0c3
6CEFH/p9wO+WXLpPHrpNPiC8QtyVnwfEQglJCUv+W6BzJJ2amgqGqCReVQ0n
a62iAtf9NqAkzwxxVU9/Rq1HSEpLQZdNoWIFfLBY3XVt+oXrB2PkUBEs0I3j
RU5QQeXjQJAlffdxHorLIfyJq+j1aydahToJVrY0o764WjIXioV8RlTv439l
M4/zA/iyME+x1LGMWPabN5Tm8iT70OBzlTxNjlSIzScmNwpNIM/Ymn38Wbg1
/5ih7jB1zKzp2YuuIVoNHN5k78g9tqsMPcSyv8bYGISJRx2Ic1lqN4LeC+6O
v/zoS57P8pFG3QJxFA5pcH76MwpTX0v4LHcI7z39eevI+a6qR/CIXs4CS8Sn
MXI8iv8/1HQEBYsJd5VcT+gkYF+7MZAxcQ8L3vQQJ49Mp7N6MEHd7wRfLhHP
gVYydOEKXVgfvJnx0t5KgMaFznS3NdIvdmsUEmhNm+ZAexZ3rsT1MFGeLz0C
A3CpM9Tll7/AdDRc9uLyVI6D88M8hVmombNpG6CC2spfbyflhzaX5CzxvKPW
MU2H6ROZRYnciSLPlcyxORL8ak+97k6KtbRrac3rLldEISd5FCnoAKeE6YQ2
IA9ylTKB7Y3FJT2duyXIXJXRyO2p5WEhnPD5C5GUtzzrHljksarUHWMKPPfK
8WUvKJWf
=bwPq
-----END PGP SIGNATURE-----


--------a8e902d9eaec74bed9784c221c39b56b40578f40b1f3dd86653d25bb7f64b244--

