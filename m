Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5A3AE185;
	Mon, 20 Jul 2026 08:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784535028; cv=none; b=Xhdn/yZuBIWIadUGhIUSvju1uqJmpMBsz4ysozvZsm8RUQ2YbSH7O7tzA+c/+9G9fUHcyl5RLtOBmQ7oCGuNNkle4356uajwFNR7fMpboOJu+NIFZDVEklLsQ/hp/Y9xwoU3QjoYlBhyrxhX5O9HBGwTgHiZP8KQvvSCnMXIPIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784535028; c=relaxed/simple;
	bh=nohSGL3nNLxbgpJ63TZnkaSHeMR76iExJoJ+6foY/OY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pl9JjmJNjwYm0EgKLPJeJlKQT8WslkWAQvRIcKuGajx+IvVdY43WjAv8AW2WvupcKkRD88He6x53nE2/vwhRAMEZsdbOpU/WGlHuGk6N8eM4vyQdNowT/63qjarAP7fCsAiNT6uwUxS5KnF+0uTGmr06OYwqd95uOjwr5fjUv9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlHW1m24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlHW1m24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C8A1F000E9;
	Mon, 20 Jul 2026 08:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784535027;
	bh=pIe+e4SuAHeLj9NpXSa8YjvEEO9XCr7z+7SZQCKB4Fg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RlHW1m24S3Qmywd+gIdgXQUL95tt6lRhPumQwUHuon8nnqZrwyA+lCz7xiWna628K
	 eAogyWrBMpOEVLo0lNAl0t9oy5AnSjbvxB85xbVWREgzz40/87A12X25nUyC1YolKV
	 nwmOBDSUobs1Cat+3mz0nb/Lsyak0/Kw/MINlhTkorTyAAJZIKAb1XTyMKDg5JsNub
	 /2oZGHRLDrMQgvFCT4ZSRpFbgCNEF6Rsta0UNitIcDngKZvTMICflnj/kgrWACFByT
	 Iv2qQRojJZYZ5D2WwCIK8cn/mEzwYS02w+tiNlVaOBGEpjtciTrtgZDsly9YEluAMu
	 X0u30nMVikqzQ==
Date: Mon, 20 Jul 2026 10:10:21 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: repair some kernel-doc comments
Message-ID: <fa4h52w5i4wznnqxyveeg5k7kfqe6kfmkkwrxmdunxtjwn42ud@fckpmqbhg2ox>
References: <20260718190356.1892992-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwe2redvuvhqvhjn"
Content-Disposition: inline
In-Reply-To: <20260718190356.1892992-1-rdunlap@infradead.org>


--cwe2redvuvhqvhjn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

pushed it to sysctl-next

Thx

Best
On Sat, Jul 18, 2026 at 12:03:56PM -0700, Randy Dunlap wrote:
> Convert a non-kernel-comment to use "/*" instead.
> Don't use kernel-doc for the nested @type enum values since they
> aren't part of the struct.
>=20
> Warning: ./include/linux/sysctl.h:62 Cannot find identifier on line:
>  *
> Warning: ./include/linux/sysctl.h:63 Cannot find identifier on line:
>  * "dir" originates from read_iter (dir =3D 0) or write_iter (dir =3D 1)
> Warning: ./include/linux/sysctl.h:64 This comment starts with '/**', but =
isn't a kernel-doc comment.
>  * in the file_operations struct at proc/proc_sysctl.c. Its value means
> Warning: ./include/linux/sysctl.h:274 Excess struct member
>   'type.SYSCTL_TABLE_TYPE_DEFAULT' description in 'ctl_table_header'
> Warning: ./include/linux/sysctl.h:274 Excess struct member
>   'type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY' description in 'ctl_table_he=
ader'
>=20
> Note: This still leaves 7 struct members in ctl_table_header that
> are not described. E.g.:
> Warning: include/linux/sysctl.h:274 struct member 'unregistering' not des=
cribed in 'ctl_table_header'
> Warning: include/linux/sysctl.h:274 struct member 'ctl_table_arg' not des=
cribed in 'ctl_table_header'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Kees Cook <kees@kernel.org>
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
>=20
>  include/linux/sysctl.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> --- linux-next-20260717.orig/include/linux/sysctl.h
> +++ linux-next-20260717/include/linux/sysctl.h
> @@ -59,7 +59,7 @@ extern const int sysctl_vals[];
>  #define SYSCTL_LONG_ONE		((void *)&sysctl_long_vals[1])
>  #define SYSCTL_LONG_MAX		((void *)&sysctl_long_vals[2])
> =20
> -/**
> +/*
>   *
>   * "dir" originates from read_iter (dir =3D 0) or write_iter (dir =3D 1)
>   * in the file_operations struct at proc/proc_sysctl.c. Its value means
> @@ -245,9 +245,9 @@ struct ctl_node {
>   * @nreg: When nreg drops to 0 the ctl_table_header will be unregistered.
>   * @rcu: Delays the freeing of the inode. Introduced with "unfuck proc_s=
ysctl ->d_compare()"
>   *
> - * @type: Enumeration to differentiate between ctl target types
> - * @type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considera=
tions
> - * @type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently e=
mpty dir
> + * @type: Enumeration to differentiate between ctl target types:
> + * type.SYSCTL_TABLE_TYPE_DEFAULT: ctl target with no special considerat=
ions
> + * type.SYSCTL_TABLE_TYPE_PERMANENTLY_EMPTY: Identifies a permanently em=
pty dir
>   *                                            target to serve as a mount=
 point
>   */
>  struct ctl_table_header {

--=20

Joel Granados

--cwe2redvuvhqvhjn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmpd1+UACgkQupfNUreW
QU/swQv/SwzDZjJW9vghABWVZjCSnOH5KWRj3cOCn6DrcRyAHzOJF6erIp34yT6z
WGeH17VWmi1Yb6Opkpg9sOAWx+AV6o3ByBMYOiHJoLVolRIbPU4u5j54dpsSnNSI
yMpAsZFY2sey1Xcx/CBvaiXPE0JnIIuSPVTu4V7W6FQUCn4EgF3QI75zvBxiME1M
ZPWkSCD7TRo9Pl9z1Q5pC9n7gWnhhUJ1TWSGK33j+8fX7i5CEao64+HUev45I6EK
PYY8HM1Qx+ayZp/KvflbX2yt7q7NpsG0MPZ1FFjdhXLE3u2tn8wlUze/II3WGgxw
5bnjfF1kx//TRcwL0rPbit11FcSpfFEKzyeDbx5F0j6WjN/LhPzeOab1KmUsWZpj
7ooaDZQTUmADrTfOAkzN8QyFqyfzEEoInAwQCEsYBOx1FdbckGbDg3kWTCKe+MMQ
ch3MUCw1j1nRTgpOfo9hOW9Mt/4Ckaga8CdNDTvNLs8roP6Tlg2uZ6uq/GxHjG8h
Ku5kzbSZ
=GX2H
-----END PGP SIGNATURE-----

--cwe2redvuvhqvhjn--
