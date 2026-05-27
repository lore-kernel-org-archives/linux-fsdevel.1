Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B73F39E3
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888176; cv=none; b=Y0NNsRnyEgjfGqnyZqpx+zIvkpTiffPnmUJ7TTjXxJFgUOxotUgD0xcpR38Ja9+yhx6vmoCwz4Irn29+cJgFxQc/wHbrNtyrI20XVQAWsQZx0mkRCNGuuEBoO4Zo/1/OmpkbSekHYngueA2NL+5ucBdX/SiXiLutFI292+t7n6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888176; c=relaxed/simple;
	bh=PHLsu2Z5sGPxx3BqJuISubLbNqzh1/NTrS4e826wtiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tj7BsDJkIQOOIzK25F3pl6wE4vbw6/+Pap7lIBkWny27lRsvDIgQmIzf23gb/LoIeYJjKwh6884oEnn6xK20ogrWZ8D+NnVvIDInL7zkp6+tYsc+vdbLswXbOsLQ5rkxutHDt+sJc3Qj9IyTO7NH1CNZ+qFpckv0f4XeqV/ZzJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=VZroMDM7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="VZroMDM7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so47361805e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 06:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779888172; x=1780492972; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q/RBHCR3qCaewkn0icuin5UM+dMKVdabs3wS26coKl8=;
        b=VZroMDM7ZDoHjjmVynMblB3INA+GUdz1zUcodG8uatQ6cbQzup5btLrlosc+Z0A4nC
         IyiC4EElcCZG69acIl3OWp1cs8iUBhHI/g6RLf/q/MFzjlUBRvK2lT/LVabdeXeZoMh5
         jyes7cwAL0s56rTL99VlDHfue315FZI4+S5Jh1ADBIBM65xg4qQKhXxgifARFYNoyp4l
         1pVWPoNIpUNaSCqHV7dOjTK7NngSDjwAe9KuDTIWG/xO+YGChU72IYm3JC5JCYX3pYzI
         hS4tE2f9aK8PSHNStJeYh/Kxr2hxAYyB5Qf8vJvA8oGp+kaZh4dFQpZ7UQ/4cmPZsgEv
         fxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779888172; x=1780492972;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q/RBHCR3qCaewkn0icuin5UM+dMKVdabs3wS26coKl8=;
        b=UQop6DP5C0REnU2qLL75mQyzLy7/F1IuOKtQzz2sI4/QGSCxorhY0kksFCYhVPiWgZ
         aoQmHQXW55SchXFVJrpRhSLmkmvfJ48tuz6IHX32OMFXBf8bDGIlQMgecjHPVP0MRBt7
         Sg6pFwI06EaGDz9k4vCMUPyLRd0ffNeI49/3hAT6i5WBr+/t0PUCgMv8c4Qd4ednNQ5t
         z8sDZQVN6Dle02OZI4ACW6MFBfeSjNsv4NgtbFYrL/NPyAAodp4im9dfVD3iUKQfhe7P
         1IJvhq1VQxR4TiYa2z9O+lCiINELT7CD1r4Pz783YuMtVbN6Si31aKnA3m9ew6d7et3K
         S+lw==
X-Forwarded-Encrypted: i=1; AFNElJ9HkCaCVozATCwdZohz/TUVSEkXWjbs26Nl+zRpkdDjKDJSQ48EFtbW6242Whp5NDZd03QvN1SsDXouvu3x@vger.kernel.org
X-Gm-Message-State: AOJu0YysA5brkEQJTxXYLJDHrZ5ShprXlp5innhNkXxkIULScrPgKLcT
	rf3vd6RH9zneFEzZMT+4U/eWewBcE8rQkEWV2v35NB0gfPdwGPEAzVVgBieMRuKnFyw=
X-Gm-Gg: Acq92OElISNvwSDJPD+MDUCVzfPnocTrVWaovD+SeyW0ILKdndvS9oi/J4rrvPPfhap
	TiSgr7Qf25nnjRpgC3Jtrjiinaqmp9IrClERwapGz5XCQt+lgZ3n0TJyEPyJQuEVy/TWBs76ppo
	ivrJVHoWc1Thci5tbK82WITR+8xaf+g4+oW0g4r26xc/T0XHVH9avpu++Hpha7gL0BO4GB61trS
	EcjNLnJeH7kqzPv+v+4vhUO3bGxz/4W+nXaTP3YQFUOcSCuAxlofhtVuCOKkPH98yv50RzXUbIO
	eXyHqTH5iAl5LQ0SPpkEHTZeJoZO4E1jRL7axI8sltlm1fHIVhqSqKklj/e+mcF/qAA5gNyDRsT
	mgfBPYtm2IwyL4ktbEBqcVL1PtukwkW/LEWlTqNtTNnaiOIkDn53d2+vmBzr/QIGsePdwZVFjcH
	VDjMYrSt50I0FrRtfMqVyUi7qCkpxhKIpNGNTl3k8tLj+4blOP2/MVZPeZ9IR9nVwh3PLLRvNLu
	xSwkPaec5TbZhM=
X-Received: by 2002:a05:600c:19cb:b0:490:507c:bdb1 with SMTP id 5b1f17b1804b1-490507cbed4mr331274845e9.15.1779888172116;
        Wed, 27 May 2026 06:22:52 -0700 (PDT)
Received: from localhost (p200300f65f47db04d0bbaa07c813b2f2.dip0.t-ipconnect.de. [2003:f6:5f47:db04:d0bb:aa07:c813:b2f2])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4907e6284e5sm28276165e9.0.2026.05.27.06.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 06:22:51 -0700 (PDT)
Date: Wed, 27 May 2026 15:22:50 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Scott Tringali <stringal@mathworks.com>, 1137107-quiet@bugs.debian.org
Cc: David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: Bug#1137107: netfs local_bh_enable in hard IRQ via cachefiles
 read completion
Message-ID: <ahbuh46O8ncqe6Ob@monoceros>
References: <177921663299.22800.4367803780230080606.reportbug@ah-stringal-l.dhcp.mathworks.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3c4o7jiux3kao3gh"
Content-Disposition: inline
In-Reply-To: <177921663299.22800.4367803780230080606.reportbug@ah-stringal-l.dhcp.mathworks.com>


--3c4o7jiux3kao3gh
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: Bug#1137107: netfs local_bh_enable in hard IRQ via cachefiles
 read completion
MIME-Version: 1.0

Control: tag -1 + upstream moreinfo

Hello,

On Tue, May 19, 2026 at 02:50:32PM -0400, Scott Tringali wrote:
> Package: linux
> Severity: important
> Tags: patch
> X-Debbugs-Cc: stringal@mathworks.com
>=20
> Package: linux
> Version: 6.12.86-1
> Severity: important
> Tags: upstream
>=20
> netfs_consume_read_data() calls local_bh_enable() in hard IRQ context
> when reached via the cachefiles async read completion path.
>=20
> The call chain is:
>=20
>   nvme_irq                              [hard IRQ]
>     blk_mq_end_request_batch
>       iomap_dio_bio_end_io
>         cachefiles_read_complete        [cachefiles]
>           netfs_read_subreq_terminated  [netfs]
>             netfs_consume_read_data     [netfs]
>               __local_bh_enable_ip      *** WARNING ***
>=20
> This fires a WARN_ON at kernel/softirq.c:386 because local_bh_enable()
> is called while in hard IRQ context (PID 0, swapper, inside <IRQ>).

There was a similar report filed upstream at
https://lore.kernel.org/all/CAKPOu+_4m80thNy5_fvROoxBm689YtA0dZ-=3DgcmkzwYS=
Y4syqw@mail.gmail.com/

The patches mentioned there went into 6.14-rc1[1], though they didn't
fix all issues for the reporter there.

So I think the right course of action is to test a newer kernel first,
and if that helps (and I assume it does), prod David (on Cc:) about
maybe backporting the fixes to v6.12.y.

So Scott, you you please check if the kernel from unstable/testing or
backports fixes things for you?

Best regards
Uwe

[1] https://lore.kernel.org/linus/ca56a74a31e26d81a481304ed2f631e65883372b

--3c4o7jiux3kao3gh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoW8CcACgkQj4D7WH0S
/k6rYggAuRcTKQTss2YOE6MZEF/VrHw5B6ZhO0XBgtaln+sLUYqeQnNs/2ZsTBwQ
0Lf2pXBGa9JOZJjDmxrTmhGculYNR+WGcxfn8BmTLlYRfv/WVAdMBcxuv7Dn1QQv
S0iHvNtSSpvcwDklel75a6vBYel00nGR/z723Oj5kHKfcD6XNDS9dlP66hSVfDax
7a1oosJu51hZlsDf59aim3i++L+IkSXf7MQAx5yh+jQapTBg8UQBLHm7ASRUUbIP
S5lO25Up0gT5wRM8O8ooPdbg/u3cBvgWDaau6py2oji074nHOm5D1VshwTnSpz6a
vwV6URaEn5fGxGbIcaiDu8YhEJEPQA==
=GIFV
-----END PGP SIGNATURE-----

--3c4o7jiux3kao3gh--
