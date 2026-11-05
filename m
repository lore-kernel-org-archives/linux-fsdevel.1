Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888718;
	b=3qTluvOrfcJ2DtDmlG27y5Fs/Q5MEcKSgFcd6M15IhkAiahc5iu3Qk0++9JN8UFIbwzB
	 hToW6S93TO6qQum+bLauzlyq29VRYG9tz9ojqs0lsZn2+E6G4o3KEoM6xI1GNkDQJNfNn
	 xAv9gQv2Pd4Eu91T+t/ZZ/NLq8+ufy8WC8ZOlvpdhuxB5BnaVxF3FWsxhhj8rw6TEi0mj
	 tHUB6/lF0lrCgbli+a1cZxQbJd1DWC5fllNdzJWlfT4FUayXtttxsyxEzExoAgXQdLfET
	 PHiYmfUFlTzkE/8vCfhQEG1ceeYy/EaAZtDl7w61MU1IdiDA8UYs4Pg6qXV67aKkttw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888718;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=QfaCl7Y+QODhCImusuMTLN4qOCxT8NMm+zTofafJQ6o=;
	b=Yz3vYkhR4z6+MRVI1Ix6IW+Wlrh6jAgqvR/IAzEOXRsl8ebTyYFEnP6IM6pZOuce5+2s
	 T5xG4a3NULfDWob67EWOSBFKtu2D3BZKe1EUVrxhm/TigFPY0YC5nKx68eC8NXzFf/w1Z
	 qhV8P2yuOYHNpTO+PDWcsxsQWzNK/MWMd+g+f2GNflYp5yfairFjfzmBlvQ5fmG2VIa7e
	 b+y+Wlf+frF9vnvji3QiBtc/XFqIjwpeb3Nji3HZ2C5HQ3Q+vr+nE3vmIBLWyFkQIMry0
	 b2GAys3A+pWCF6KReF0DwyMHOQB1kzkTnXf9s7KuBsbRbHNeTU4CPajZXjW9bQ1lAmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVICw7+A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC178606A31B;
	Thu,  5 Nov 2026 14:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVICw7+A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1751F00919;
	Thu,  5 Nov 2026 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888717;
	bh=QfaCl7Y+QODhCImusuMTLN4qOCxT8NMm+zTofafJQ6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PVICw7+A9sN5aBvKPBU2ZfIjtrY2irm5T0+4rLpKXltSIlKHW/fltBUhebyMNm0H9
	 k/zmwJ3DlkwLI59Bv0jVzs4J/hX587FFtuY66IF6osO/qiriYDjH6ccMBK+BzOQ0KQ
	 PmA76nm8pUs6H9O0j96ob36URye1I14XvKGYptLCq9i/r02QYW0RmkVEDYKxLot8nK
	 AsWAbRQ/+2ctg9nU2a+0ccBeB8TSmAjggP6o+ZrJkdwpXOnkYFVhFcgVBX9W7S7yIH
	 5jHsg+x+ygLj4oEmOILJLmeyYcugXb5wkfcAK8PSWSxzHcLDOc6c/r6vXAKbjX7Ui4
	 LAW1+VuwSZ38Q==
Date: Thu, 5 Nov 2026 15:24:57 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Fix large millisecond-to-jiffies conversions
Message-ID: <auxnwOgSPDtRz2iz@hobbes>
References: <20261102111516.1398262-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bxokoxthdttn5ggi"
Content-Disposition: inline
In-Reply-To: <20261102111516.1398262-2-thnkslprpt@gmail.com>


--bxokoxthdttn5ggi
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] sysctl: Fix large millisecond-to-jiffies conversions
MIME-Version: 1.0

On Mon, Nov 02, 2026 at 01:15:17PM +0200, Avi Weiss wrote:
> sysctl_msecs_to_jiffies() compares the input against
> jiffies_to_msecs(MAX_JIFFY_OFFSET), which returns an unsigned int.
> When the converted limit exceeds UINT_MAX, it is truncated, causing
> valid timeouts to be incorrectly saturated to MAX_JIFFY_OFFSET.
> For example, on 32-bit systems with HZ=3D100, writing 2147483647 ms
> stores 1073741822 jiffies instead of 214748365.
>=20
> For unsigned long sysctls, values between INT_MAX and UINT_MAX
> are passed to msecs_to_jiffies(), which interprets them as negative
> timeouts. On 64-bit systems with HZ=3D1000, writing 2147483648 ms
> stores MAX_JIFFY_OFFSET instead of 2147483648 jiffies.
>=20
> Keep the existing conversion for values up to INT_MAX, and use
> overflow-safe, full-width arithmetic for larger values. Clamp
> the result to MAX_JIFFY_OFFSET.
>=20
> Fixes: afdf35cfae0d ("sysctl: Fix type truncation in sysctl_msec_to_jiffi=
es")
> Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with =
do_proc_vec")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

This is a very good catch and it teaches me never to assume that the
function will take care of everything.

With b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with
do_proc_vec") I wanted (naively) to remove the additional conversion
logic and just use the one that already existed in msecs_to_jiffies and
jiffies_to_msecs. This has proven to be a bad idea as going from the
ulong space (of sysctl converter) to the uint space (of msecs_to_jiffies
& jiffies_to_msecs) creates lots of churn.

> ---
>  kernel/time/jiffies.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index af1c69bf0c23..7b02cc7de15e 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -139,9 +139,20 @@ static int sysctl_k2u_int_conv_userhz(bool *negp, ul=
ong *u_ptr, const int *k_ptr
> =20
>  static ulong sysctl_msecs_to_jiffies(const ulong val)
>  {
> -	if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
> -		return MAX_JIFFY_OFFSET;
> -	return msecs_to_jiffies(val);
> +	ulong secs, jif;
> +
> +	if (val <=3D INT_MAX) {
> +		jif =3D msecs_to_jiffies(val);
> +	} else {
> +		secs =3D val / MSEC_PER_SEC;
> +		if (secs > MAX_JIFFY_OFFSET / HZ)
> +			return MAX_JIFFY_OFFSET;
> +
> +		jif =3D secs * HZ +
> +		      DIV_ROUND_UP((val % MSEC_PER_SEC) * HZ, MSEC_PER_SEC);
> +	}
> +
> +	return min_t(ulong, jif, MAX_JIFFY_OFFSET);
>  }
> =20
>  static int sysctl_u2k_int_conv_ms(const bool *negp, const ulong *u_ptr, =
int *k_ptr)
>=20
> base-commit: d135ab453a7400a34930bdda1ef4bdc8acfac80e
> --=20
> 2.43.0
>=20

Lets go back to having an additional ulong conversion in sysctl. And
forget about using the msecs_to_jiffies and jiffies_to_msecs functions.
Also, lets document it so we don't forget.

How about we do it like this (compiled but untested)

diff --git i/kernel/time/jiffies.c w/kernel/time/jiffies.c
index af1c69bf0c23..409106d194cd 100644
--- i/kernel/time/jiffies.c
+++ w/kernel/time/jiffies.c
@@ -137,11 +137,19 @@ static int sysctl_k2u_int_conv_userhz(bool *negp, ulo=
ng *u_ptr, const int *k_ptr
        return proc_int_k2u_conv_kop(u_ptr, k_ptr, negp, sysctl_jiffies_to_=
clock_t);
 }

+/*
+ * We do not use jiffies_to_msecs and msecs_to_jiffies here to avoid having
+ * to deal with the unsined int space. Millisecond <-> jiffies conversions
+ * for sysctls, done in unsigned long arithmetic.
+ */
 static ulong sysctl_msecs_to_jiffies(const ulong val)
 {
-       if (val > jiffies_to_msecs(MAX_JIFFY_OFFSET))
-               return MAX_JIFFY_OFFSET;
-       return msecs_to_jiffies(val);
+       ulong secs =3D val / MSEC_PER_SEC;
+
+       if (secs >=3D ULONG_MAX / HZ)
+               return ULONG_MAX;
+
+       return secs * HZ + DIV_ROUND_UP((val % MSEC_PER_SEC) * HZ, MSEC_PER=
_SEC);
 }

 static int sysctl_u2k_int_conv_ms(const bool *negp, const ulong *u_ptr, in=
t *k_ptr)
@@ -151,7 +159,12 @@ static int sysctl_u2k_int_conv_ms(const bool *negp, co=
nst ulong *u_ptr, int *k_p

 static ulong sysctl_jiffies_to_msecs(const ulong val)
 {
-       return jiffies_to_msecs(val);
+       ulong secs =3D val / HZ;
+
+       if (secs >=3D ULONG_MAX / MSEC_PER_SEC)
+               return ULONG_MAX;
+
+       return secs * MSEC_PER_SEC + (val % HZ) * MSEC_PER_SEC / HZ;
 }

 static int sysctl_k2u_int_conv_ms(bool *negp, ulong *u_ptr, const int *k_p=
tr)



best

Joel


--bxokoxthdttn5ggi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmrskbIACgkQupfNUreW
QU9Mbwv/fa7ULI/XzvAvEzKSojMV/sl+fvAlSwJS00BJBL/zCgL/sSJ1Rytsnw5Y
GuL6Uz+QmraqgL+34LTHuNuk9p2OEnSX4pNEBJhKNtWqYa7yBxZh/2TeqUrdBZvL
I+xtw3Z6dSgiMPrz8PGjdPTiI08ad1/9BTdcbmdfMuABNbEsTBVtHX7INsRkZ89l
0ZhcjtnQrk5rZ2OaGsyJidB04Rcv8UTPTq+A8d/9ki/OyFtY8W+RyaRkRSSZI0wa
oyc52HvSQF4C0pRnYyMnWT30o5XCygxhb4V5w5LowsL13uBdPZsMj+4xZteeeNj5
yQ8ag+f0DJJNPuYbD1W+2xockQVkyanHxHylIns9hQVdNKtKRWE2MNI19kXBktpG
8L51dYE6QdsXGQyeB4nfNl3tzfpdRVI/AtTt4wL41PiJxmzX/g4nKQKhLnvydKPF
2kWec0+0f4h0YEafV2R0Hs6ujOKULYPzGAnURTSRgEgBvu2HrJ7OA38agOE33Pdt
7sDwIeWF
=dHml
-----END PGP SIGNATURE-----

--bxokoxthdttn5ggi--
