Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5171A6818;
	Mon, 23 Mar 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274044; cv=none; b=Y1RoKgJ69cQIqhV3r9Gij14FzzkIDYex8WxIvSE4sxdp/sTWOTrIZ55yaGeFc2vT04BgpItJT0xfLs1zIZ3JCexaRJt4w6kOhuM/h0FC7NWYz+bF1D2u3Yb5ovjUzE25VpCgzrb9RB7LyoCH8I/7lkCENEdHTrnOOT5UmTMpnlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274044; c=relaxed/simple;
	bh=ghylrK+TjKR023bNRPmVTzlEWuw5fPTe7aFuTsI2hSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z+s0H2XgktWsvkq0rmROxIUD1SeCR8KjsUq2KcUi8AZNsSsYV+gCccwf8D3YensJDn+f9ebWv56fig9oZwYFnUS9JxMiL0JTGYhmt8oKm+rEJtFgTE+A8nsjdvd5xLwOcVOOmesdogicfmrA1nclyMhByOl338obk1j+wb1uVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUvlZb/R; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUvlZb/R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F8C9C2BC9E;
	Mon, 23 Mar 2026 13:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774274044;
	bh=ghylrK+TjKR023bNRPmVTzlEWuw5fPTe7aFuTsI2hSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hUvlZb/RqNO7pGyOKe8TuyY4u/qsrtPaBZyHl2VF9VMP0G/jO6vsJG4yuZWd+x0S5
	 ku+jDdNP8dtDEffyFKakPdw41xErRYZh58n9AEfj20Zh+spZzJcxZ3/hg0x699Bsc1
	 TlivRr+XRvpDU6nU3BmCoNN1vEyCIybH1qDmrWtp/rfKTQVFZ7QLzUQ/Gzb2+sKp7i
	 EYaWlc87UDEGYX9+qI/bvtUlzjTiWpagD+xOIX2z8vuUqdbTVqc2CfVTTInLYLheOn
	 0Bf/F8VXUg2ZFGmn68lh2gbfwNdH6evnoEOYD/GdFijj885x2IBereUzoSuU5wfq/C
	 EwuU9ERLCgdjQ==
Date: Mon, 23 Mar 2026 14:53:51 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Marc Buerg <buermarc@googlemail.com>
Cc: Kees Cook <kees@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Octavian Purdila <opurdila@ixiacom.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Elias Oezcan <elias.rw2@gmail.com>, Peter Seiderer <ps.report@gmx.net>
Subject: Re: [PATCH v3] sysctl: fix check against uninitialized variable in
 proc_do_large_bitmap
Message-ID: <wcqe7kk2jdca7otlp6iwbp27ud6d3ynzopr7gs66gqn4xeskbr@cdyrjkouqmem>
References: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xpsyocviqchcjfax"
Content-Disposition: inline
In-Reply-To: <20260319-fix-uninitialized-variable-in-proc_do_large_bitmap-v3-1-9cfc3ff60c09@googlemail.com>


--xpsyocviqchcjfax
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 19, 2026 at 11:50:50PM +0100, Marc Buerg wrote:
> proc_do_large_bitmap() does not initialize variable c, which is expected
> to be set to a trailing character by proc_get_long().
Ack.

>=20
> However, proc_get_long() only sets c when the input buffer contains a
> trailing character after the parsed value.
Ack.

>=20
> If c is not initialized it may happen to contain a '-'. If this is the
Here I have a question:

How is it possible that the buffer in proc_do_large_bitmap is not
terminated with a '\0' when writing?

The proc_do_large_bitmap gets called from proc_sys_call_handler and
before running the table->proc_handler call, the end of the buffer gets
set with '\0'. This means that when the last value is parsed, the
trailing char is '\0'. Which, in turn, means that 'c' will always get a
value.

*Unless*, the buffer is changed in BPF_CGROUP_RUN_PROG_SYSCTL by an
external (to the kernel) program.

Are you running a BPF program on this hook? Do you see the same behavior
if you turn off BPF?

> case proc_do_large_bitmap() expects to be able to parse a second part of
> the input buffer. If there is no second part an unjustified -EINVAL will
> be returned.
>=20
> Add check that left is non-zero before checking c, as proc_get_long()
> ensures that the passed left is non-zero, if a trailing character
> exists.
>=20
> ---
I'll repeat the comments from the other reviewers. Careful with these
separators. When I used b4 to bring all this into my testing env, All
your trailers were ignored.

best

> When writing to /proc/sys/net/ipv4/ip_local_reserved_ports it is
> possible to receive an -EINVAL for a valid value.
>=20
> This happens due to a check of a potentially uninitialized variable in
> the proc_do_large_bitmap() function, namely char c. To trigger this
> behavior the variable has to contain the later explicitly checked '-'
> char by chance.
>=20
> In proc_do_large_bitmap() it is expected that the variable might be
> filled by the proc_get_long() function with the trailing character of
> the given input. But only if a trailing character exists within the
> passed size of the buffer.
>=20
> If no trailing character is present we still do a c =3D=3D '-' check. If =
the
> uninitialized variable contains this char the function continues
> parsing. It will now set err to -EINVAL in the next proc_get_long()
> call, as there is nothing more to parse.
>=20
> proc_do_large_bitmap() passes left to the proc_get_long() call. left
> will only be non-zero, if a trailing character has been written.
> Therefore, checking that left is non-zero before accessing c fixes this
> problem.
>=20
> The problem will only arise sporadically, as the variable must contain
> '-' by chance. On the affected system CONFIG_INIT_STACK_NONE=3Dy was
> enabled. Further, when enabling eBPF tracing to dump contents of the
> stack the issue disappeared.
>=20
> Fixes: 9f977fb7ae9d ("sysctl: add proc_do_large_bitmap")
> Signed-off-by: Marc Buerg <buermarc@googlemail.com>
> Reviewed-by: Peter Seiderer <ps.report@gmx.net>
> ---
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
> index 9d3a666ffde1..dd337a63da41 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -1171,7 +1171,7 @@ int proc_do_large_bitmap(const struct ctl_table *ta=
ble, int dir,
>  				left--;
>  			}
> =20
> -			if (c =3D=3D '-') {
> +			if (left && c =3D=3D '-') {
>  				err =3D proc_get_long(&p, &left, &val_b,
>  						     &neg, tr_b, sizeof(tr_b),
>  						     &c);
>=20
> ---
> base-commit: 80234b5ab240f52fa45d201e899e207b9265ef91
> change-id: 20260312-fix-uninitialized-variable-in-proc_do_large_bitmap-30=
c6ef4ac1c5
>=20
> Best regards,
> --=20
> buermarc <buermarc@googlemail.com>
>=20

--=20

Joel Granados

--xpsyocviqchcjfax
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmnBRecACgkQupfNUreW
QU8WMAwAl2fViUFHcYBKbo4T1NgHLKJy5zDHdCBJeef0P7xhZxGwFQKo0y9LEnGu
HpKeZ/lABmFj+pFiqM/6zT7J/GDjtP3kLSbZMVKWtslj7QipOiNENH4w7QTpjNAu
3uT2BD/YgIzxQROVQXW9CTMvjGlPRUHpXtG6CL38+e+HANU4r+liCFZyUpl79c9a
8cNmIygaYldQUVq7VaHA7Iyy7obmSQtzQG5Xv1Ap+wDW1gCvDcS/Nksg7gpEXkpw
mDvqKIZpzCDow3KWB/J0D2cbEQI+W0eL4ZfZZGtJRAWNzWIqis7/Fno5u7bR+EBV
iLaO41oX63RWiRyw4JQwCOR4zgRB9IVmB+7t+zJUTIJXhsR0LSK+Riylkr7VBE5o
HSW7q1uBSkwS7ZSFFGoHNLD0/D8r2jFmMVLT/rj3ZpJG+eCE+z40Qdts3XTMBC/g
i5sA3KHORUYXQq2j98anjjqnmyyWPdhwNMGg30SqJhVBfoOwBbtcmM95TxstC83c
b+WlzV/3
=x31q
-----END PGP SIGNATURE-----

--xpsyocviqchcjfax--
