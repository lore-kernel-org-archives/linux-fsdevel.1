Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810A14718DC;
	Wed, 16 Sep 2026 11:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559215; cv=none; b=VDpzwgBwyP36vTdkzTgmssfYK5SN/60l7heICHa91AI6wDoS7hEIhCKKBzjqpxb/UsscITSSTkf9gZz3zz2Cmaj/qVBsxyw9ZGonHoh3nSumtM5WgQdju5VPKn4vFOxTaU5xOoxwO3/BUlzzNwhl9hvpHudTvtB6hpfG025oB2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559215; c=relaxed/simple;
	bh=jQsHebjC7zgqdxrYd/b7onIPuqt1br5Y8nfLYOGsuCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTgErl9MPISUzMNQ0KUGeuxYeLAdZad6PkxobfWwIf8E6z2hHYwM36AoIY2ltOdcAKJrcI9b4xkKz1sriaCelpiebpDN/VfGMzI0+BqQwNlRwgx3nY54eNdTJ6JMmFM7H4lNDNW8J6ZzecdjCC1Z+BHxUjYP93Wxhiteb8vn344=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AO1RNiK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AO1RNiK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D86B71F000FF;
	Wed, 16 Sep 2026 11:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559206;
	bh=8QiS+JA/7lywagSp/9/r2ZkjEEnKpc8aBsO5Rl1aZZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AO1RNiK++RKszH9o80I7b20ErSzhjMjinYzgUl0ZQLoOwZtJVkXMoqcTl9jezaPWT
	 cNTQWq/FQCWz7Js6GrddUefs89Qjse61rRaCUSAEMNIupahERP48xbHNaMx9QRt/AH
	 WCUe1Bcz3Cv0VFYhPF4Rn19aLSU9t8DQv5hVXJmkEd7+f4b6onxJy1ntdb6RcQsXmV
	 10oWbk2KaabuiU5HhMjSXhtrNQ9ICxx97EVetrLRzoFkqyKfhuATzmxwHNB47e8I7W
	 mCajfc6+7KaK3LEzWUGNI2zvcy5+Yck3bKss+RxSDTTGl45ZMZyx5pUIGnPWNBfXB1
	 H1Ym4aqvtZBfA==
Date: Wed, 16 Sep 2026 13:46:40 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Bradley Morgan <include@grrlz.net>
Cc: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: drop the pointer dance in proc_put_char()
Message-ID: <adblkub2acrgjlgmjs2uu5644zm5fjghjzr5zkyga7uatrfeif@jsumbzlthyfb>
References: <20260822184244.13569-1-include@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rruovv5sjhk72mwb"
Content-Disposition: inline
In-Reply-To: <20260822184244.13569-1-include@grrlz.net>


--rruovv5sjhk72mwb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 06:42:44PM +0000, Bradley Morgan wrote:
> proc_put_char() still drags around a char **buffer alias, writing
> the char through it, advancing it, then copying it back into the
> slot it was loaded from. That only made sense when the buffer was
> __user and the char went through put_user() (which could fail).
>=20
> Since commit 32927393dc1c ("sysctl: pass kernel pointers to
> ->proc_handler") the buffer is just a kernel pointer, so the alias
> is dead weight. proc_put_long() and the skip helpers already advance
> *buf directly, so do the same here. No functional change.
>=20
> Signed-off-by: Bradley Morgan <include@grrlz.net>
> ---
>  kernel/sysctl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index f7b7598..2b92b30 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -350,12 +350,9 @@ static void proc_put_long(void **buf, size_t *size, =
unsigned long val, bool neg)
>  static void proc_put_char(void **buf, size_t *size, char c)
>  {
>  	if (*size) {
> -		char **buffer =3D (char **)buf;
> -		**buffer =3D c;
> -
> +		*(char *)*buf =3D c;
>  		(*size)--;
> -		(*buffer)++;
> -		*buf =3D *buffer;
> +		(*buf)++;
>  	}
>  }
> =20
> --=20
> 2.47.3
>=20

I was thinking more along these lines https://lore.kernel.org/all/20260916-=
lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org/

Best

--rruovv5sjhk72mwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqqgZ8ACgkQupfNUreW
QU+xcgv8Cu34wIM3uqW5EojDeD4kkWBor0VenUrwupQtwvoyQtK2bKy0RwQDqMHp
AGEOTCi6/qtNXSipO3L3ZJzBRaeGqVcrANSC8XIJ1fk+E6EYPvVlP0bqVQROYVuu
qW2xjXlZsLsvSUi1mFhVlkWmT5CynnTNvBYRzG+oStb6cwz8aAGAMVusPj23Gl0V
U0iT6NtzqFkamALEn1hR2K1+QpilsUoxct4fLSH5QFnWxSYcMN7IHJZkZe7ZRAQR
I9oFBpTsufEB96EgQGEcWM5eKx4Ul32FNkVE6EdD44B3R5QhSXekXW5pKxQ4o/P4
vcdEHm8kCE28ehpx5/vr0FLUWPYWShzHYZIw2gvor/pO0794gfIYZMBf/TT+7hNd
T+yZjoUvVOHBMgLNG5+3IaEU151OAAB+6i3PezGCY4IaQ4om/7208Gqr1LxkRuv1
4jPCGEK5SgvveS9csDh2aMpFAb+6X5q25QRiEeRN7NRiJ4RtTuFTwow82TlPHBdR
UAxnYYyW
=I4QU
-----END PGP SIGNATURE-----

--rruovv5sjhk72mwb--
