Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC21D7995;
	Wed, 25 Mar 2026 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433249; cv=none; b=mVeLv7RETgB4Sqss8YlKw3Jkx6tqT+m+85Wr76Mi7bAwqq0yjg/8pXm5qfng18LEv9wYFEj7DVnL0Zi8w736acMfcCpQ+ZuHgKhXnJ9nLLFxq5/uv47scEQXJVizQvO4vy+0xfiEkELjjxg/M5dHGvHmqnEDiGuAQtrrO9X1Rq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433249; c=relaxed/simple;
	bh=crovAWUmdGA7ztwnLzocgSx2LS4mwp6npAhx3XW1BmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chzpag/CVMeP7uxwFMDU2CHcVnqBRq/yYoGXU1VsPYIv6SIM+PVEJnHAdInm6KP9FJi529ejEaF+SaR/hLgCFtieW8hguTYmPvhdzRdovuOwOJkyuPhA/OXZXROm/71KGKPhMrRzaV1OfRSkBSiAasLUImryeQrHkq9WcG5RbZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+6aP4/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+6aP4/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42360C4CEF7;
	Wed, 25 Mar 2026 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774433248;
	bh=crovAWUmdGA7ztwnLzocgSx2LS4mwp6npAhx3XW1BmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B+6aP4/j5lWx2/vJyMuYemEqVN/uERGUqsB2ImbEOBFI3LKJkr5Zn+qGkJl+7ix/M
	 oTEqcZLIcSk9+RNFsn4khCOi26W+AihYsH5Qg6ntXwKPPad37C6ITDD/jYc96Lz3Rr
	 pVAh9acehbQnw8P/TGy2GU3ekqLOu1qRicAKQSEczlRGWIUsDm5TI/5IM736K4lnxt
	 goF/yfdhAzNJCGQlKa5tLr3RmXNPc/i+FaIXlP19Jv/DNEVjCKKFNxwf1r2EW2Gziu
	 MLzJKweaYE7D4+cIGcMqKSVXcmH5NPGujsKvN446WR46LkLZ3WUWjiWNE+ZsUJSxvN
	 SgyzOTCxoIVqA==
Date: Wed, 25 Mar 2026 11:07:23 +0100
From: Joel Granados <joel.granados@kernel.org>
To: buermarc <buermarc@googlemail.com>
Cc: davem@davemloft.net, elias.rw2@gmail.com, kees@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, opurdila@ixiacom.com, 
	ps.report@gmx.net
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in
  proc_do_large_bitmap
Message-ID: <kqjjzsarsqgwtzrrih5hvmbeyrhsbkobvcjaznnxh7oegyin7w@p3u3jenw4h2r>
References: <msjawemtxqykmbis625wctfjry7ycn77nxjjbibbck3m3atvsm@rfwow2ytmgtg>
 <20260324223640.807029-1-buermarc@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47u7ipwezesorzuu"
Content-Disposition: inline
In-Reply-To: <20260324223640.807029-1-buermarc@googlemail.com>


--47u7ipwezesorzuu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 11:36:40PM +0100, buermarc wrote:
> From: Marc Buerg <buermarc@googlemail.com>
>=20
> Hi,
>=20
> On Tue, 24 Mar 2026 08:44:13 +0100 Joel Granados, wrote:
>=20
> > 1. len is calculated by doing len =3D p - tmp
> > 2. tmp is the beginning of the buffer
> > 3. p is the first character that is not a digit.
> >
> > There will always be at least one ('\0') character that is not a digit.
>=20
> Yes.
>=20
> > So len will be less than size at least by one (could be more if the
> > string contains non digit chars). When it is parsed to the end,
> > len will be less than size by one.
>=20
> I don't think this is the case. See below.
>=20
> > TL;DR
>=20
> I'll try to make it shorter. size is the length of the user buffer, even
> after the copy to the kernel buffer. The added '\0' does not increment
> size in proc_sys_call_handler(). Following the example for
> write(fd,"123",3). In the beginning of proc_get_long():
>=20
> size =3D 3
>=20
> @:012 3
> -------
>  "123\0"
>   |
>  tmp=3D@0
>   |
>   p=3D@0
>=20
> After strtoul_lenient():
>=20
> @:012 3
> -------
>  "123\0"
>   |   |
>  tmp=3D@0
>       |
>       p=3D@3
>=20
> @3 - @0 =3D 3
> len =3D 3
>=20
> (len < size) =3D> (3 < 3) =3D> false

I see it now! I needed to pass '-n' to echo. I was testing with
write(fd, "123\n" 4) instead of write(fd, "123", 3)

>=20
> And size must be 3, proc_sys_call_handler() does not increment it. If we
> provide something like write(fd,"123\0",4) size will be 4, but now we will
> return -EINVAL.
Agreed.

>=20
> If len < size is true, we call memchk(). memchk will not find a trailing
> character as p points to '\0'. This means in this case we would return
> -EINVAL for the first proc_get_long() call in the while loop. Reason is
> '\0' is not in tr_a and therefore not a valid delimiter for the first
> proc_get_long() call.
>=20
> I hope this get's my point across.
It does. Thx for insisting :)

>=20
> > All this holds unless the trailing '\0' is modified in some way in that
> > BPF call.
>=20
> To my knowledge there was no bpf tracing enabled on the affected host at
> the time that the behavior was observed.
Indeed. I can reproduce without BPF

>=20
> Finally: the fix which adds a check for left introduces a regression.
> "123-" is wrongly accepted. Not sure if you saw my other message. It
> should not be used.
I saw that, thx.

I think the correct fix is your original version. Init 'c' to zero only.
Please resend it without the '---' so I can pull your trailers properly.

We don't check 'left' in the c =3D=3D '-' condition because it will
incorrectly accept strings that end in '-' (e.g. "123-"). In other
words, we need to enter that branch to fail as expected.

>=20
> Best Regards,
> Marc

Thx

--=20

Joel Granados

--47u7ipwezesorzuu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnDs9QACgkQupfNUreW
QU8FXgv/abUX16gLnS+2Z/7msz1ttfNwXAorhqB6bgT4CceDavjw9unxtlReaIyo
7MFsV5+xiJXMhw2KJV1rv84TuQeXoHL+GdEXWZHqlXp9RDhzxs0GdKm2BWeYDOOQ
PUGrwhjiHxi2l+6Y5gorN2sGx/VjmeC28O4WSCAiIWwb6jAqNAit8zKSkL/vWp6U
oUDgnxOrRiOMeBpd0H7NJqslHTELSF9FQOAZTm5hnmEpSuIDIoqfT2TWD6b0AF0Y
7gGqJjkRoDhKktSoKaQne0/3ehD/KxCkcCZsnObczCG0qRaP9w+w0EIOSL2AEm0e
meXP4GVR/HbRIQjMYVDLGQJ7s0Hw9jr8/TKuXph7ryxD8HUDdPaspm3yWEzGecwI
6Nn3ujlaiPoqYdp8cSn6vS4DHiQRm5ObAeQIRflGco4CS6D26i0S7oQ+OefdJVsY
kSD+oKX70NWnMoxD9QRrzTtIoQwg2cxoK41bAED5LpGuc1CnhgRg/5b9V5NhJi9R
eXmujE5j
=oA5J
-----END PGP SIGNATURE-----

--47u7ipwezesorzuu--
