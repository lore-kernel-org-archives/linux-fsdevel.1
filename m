Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A5E3ACA60;
	Thu, 26 Mar 2026 07:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774511337; cv=none; b=s86so/vh33eSTWtON9HO4ZMRX8fFeUp6E+XmZ/xCfAHrryzA/K3HI02ALRZDZXaOP0X9lumR83+yydugAkurCNlt1kPvSTZHAE6KSZaOMAi7vUv613AQbaYj3kNsn3P3eusifegSvJLLWRebuGEjzjxwHvBdnDrdAXAaCnHuYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774511337; c=relaxed/simple;
	bh=wQ5U8zDlbY0yVZlopH5HE4VDsA5l3x3JPcJlN3VoO5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=romHCyu7gIz6RryCOGuwdNxbB0LEAJFjrtc7g3hF6kmYTjjH5n/t7MyDAyrAkv/2GVOZlenRB3ElmjTW1cr1KA/i3ywsceT1Et98VR9qCsY3DIxg4OSx4DQnpbbxByYMgNnJ3ZdLObtGv/WCQoa002AHkfngEqEYZvZmTV/EyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F6VNMB8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F6VNMB8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8BFC116C6;
	Thu, 26 Mar 2026 07:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774511336;
	bh=wQ5U8zDlbY0yVZlopH5HE4VDsA5l3x3JPcJlN3VoO5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F6VNMB8ZUlPSG16KcjEQCuMHGLW7GaaOhje5Rqr0oM4JJ68EscdrV0OqxUl9pzhKo
	 HuwUYHrRnAAyN9UlMiTBEcnyCE6lNK088rGnpzm4WOghUTtAWQ4J9QMl/OaBPdrMx0
	 BkHzqS1LhXim775iyOAv5WhP6lBXKwecV54yb7d0YDB/k6nYKgQd9qcWCzExPQPFaD
	 jZxWsfmJriMU5aEfyeM50tbL1CV452l00Qrree6d09kmTFWC0biBTqnXIqce7pg6jG
	 eyXtjVUm3JE2/hCuvcyH3mApi4Q3jB1kVQHESIqCl8Yw/PEF4jk9Q1Sa89hAg9McGB
	 5iOQoO9uls5TQ==
Date: Thu, 26 Mar 2026 08:48:51 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Marc Buerg <buermarc@googlemail.com>
Cc: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Octavian Purdila <opurdila@ixiacom.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Elias Oezcan <elias.rw2@gmail.com>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v4] sysctl: fix uninitialized variable in
 proc_do_large_bitmap
Message-ID: <zhl7hgan2uqcv3jdkviojmdk7tqxad3oanftg2oueihicfacyo@rdrjmt3rww5z>
References: <20260325-fix-uninitialized-variable-in-proc_do_large_bitmap-v4-1-6fbdc832d9ba@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4rbyj6av6hzkniuz"
Content-Disposition: inline
In-Reply-To: <20260325-fix-uninitialized-variable-in-proc_do_large_bitmap-v4-1-6fbdc832d9ba@googlemail.com>


--4rbyj6av6hzkniuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2026 at 11:29:50PM +0100, Marc Buerg wrote:
> proc_do_large_bitmap() does not initialize variable c, which is expected
> to be set to a trailing character by proc_get_long().
>=20
> However, proc_get_long() only sets c when the input buffer contains a
> trailing character after the parsed value.
>=20
> If c is not initialized it may happen to contain a '-'. If this is the
> case proc_do_large_bitmap() expects to be able to parse a second part of
> the input buffer. If there is no second part an unjustified -EINVAL will
> be returned.
>=20
> Initialize c to 0 to prevent returning -EINVAL on valid input.
>=20
> Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> ---
> When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
> possible to receive an -EINVAL for a valid value.
>=20
> This happens due to an uninitialized variable in the
> proc_do_large_bitmap() function, namely char c. To trigger this behavior
> the variable has to contain the later explicitly checked '-' char by
> chance.
>=20
> In proc_do_large_bitmap() it is expected that the variable might be
> filled by the proc_get_long() function with the trailing character of
> the given input. But only if a trailing character exists within the
> passed size of the buffer.
>=20
> The proc_get_long() function can set c if the length of the parsed long
> is smaller than the given size of the buffer containing the user input.
> This is not the case if the buffer only contains the port value (e.g.
> "123") and sets the size exactly to that (3). Meaning if there is no
> trailing character, c will not be set.
>=20
> If no trailing character is present we still do a c =3D=3D '-' check. If =
the
> uninitialized variable contains this char the function continues
> parsing. It will now set err to -EINVAL in the next proc_get_long()
> call, as there is nothing more to parse.
>=20
> Initializing c to 0 will solve the problem.
>=20
> The problem will only arise sporadically, as the variable must contain
> '-' by chance. On the affected system CONFIG_INIT_STACK_NONE=3Dy was
> enabled. Further, when enabling eBPF tracing to dump contents of the
> stack the issue disappears, which would fit the current explanation as a
> root cause for the observed behavior.
> ---
> Changes in v4:
> - Re-include set c to 0
> - Drop check against left
> - Move trailers
> - Removed Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> - Link to v3: https://lore.kernel.org/r/20260319-fix-uninitialized-variab=
le-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com
>=20
> Changes in v3:
> - Add Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> - Re-include bug context into cover letter
> - Link to v2: https://lore.kernel.org/r/20260317-fix-uninitialized-variab=
le-in-proc_do_large_bitmap-v2-1-6dfb1aefa287@googlemail.com
>=20
> Changes in v2:
> - Drop initialization of c to 0
> - Include checking that left is non-zero before checking against c
> - Link to v1: https://lore.kernel.org/r/20260312-fix-uninitialized-variab=
le-in-proc_do_large_bitmap-v1-1-35ad2dddaf21@googlemail.com
> ---
>  kernel/sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 9d3a666ffde1..c9efb17cc255 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1118,7 +1118,7 @@ int proc_do_large_bitmap(const struct ctl_table *ta=
ble, int dir,
>  	unsigned long bitmap_len =3D table->maxlen;
>  	unsigned long *bitmap =3D *(unsigned long **) table->data;
>  	unsigned long *tmp_bitmap =3D NULL;
> -	char tr_a[] =3D { '-', ',', '\n' }, tr_b[] =3D { ',', '\n', 0 }, c;
> +	char tr_a[] =3D { '-', ',', '\n' }, tr_b[] =3D { ',', '\n', 0 }, c =3D =
0;
> =20
>  	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(di=
r))) {
>  		*lenp =3D 0;
>=20
> ---
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30=
c6ef4ac1c5
>=20
> Best regards,
> --=20
> Marc Buerg <buermarc@googlemail.com>
>=20

Thx for the fix

Reviewed-by: Joel Granados <joel.granados@kernel.org>

--=20

Joel Granados

--4rbyj6av6hzkniuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnE5NcACgkQupfNUreW
QU+w0wv/dsIZfNE9iVW9v10fZyDT8mrWBsCsROhYIqrKUzb1BTGWS9QzRvUD3BEx
YrFneZKC9Tjnh/bDbzfBTJgdwAga3JXkvpEDpTrCRZSd+FQmK8QSVopqk1Q0yNJP
ZPtBC6xffpBu56mpjqBwTnOLaBkPyKfhlT/20H4IzuUe5tH/qsqoBLdf5EzI8ztd
H5WaKKtHbo55UT0W9p/czuinvW/Kn4chPOobmi07XrerwS7mkeJeqt08HS+IHTA5
LdJKDDlU8CMWMRIPNPdiS0g0YwO4VYqIz8fjDR3mqdIa5WOsiGgMF0uOVKdp/pC/
5ku1XMpvxJIPm1+VpY4W4WFGl6YyLDk1xCK+HGrYZAFUxqXzwdQixDwSPR4iuK8j
7IUYpggT6OY62JrfbUXkwqbmYzUiNaksLMKBHZ4Y96QmcbP1u+CAPgd4uEwnajNC
IwmnmxIH36ubtQ5rk7bMIbwMRGQet3aIsIm0BNxHy9br/rScV0t8J7M5ayxRU7kT
xbzklRmg
=usXR
-----END PGP SIGNATURE-----

--4rbyj6av6hzkniuz--
