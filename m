Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4692F3C0E;
	Fri, 25 Sep 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790342223; cv=none; b=JhwXusmQ8XxIRc+cUiIntzoH8tLfHo2mCyV9WzlPLqeugSUCHHTEsXWzEchCsxshphF/AQJBLVp1VA9tHLe9XrhNb08eLK9limdQEMnLbodmIch3QgZfsI/pgzZHJ4C44lGKR4dDqAk0ujFJlwGFM2aMw1mAQM1gdE5BA7fYx20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790342223; c=relaxed/simple;
	bh=TYkMkmVIpU2J6lpj/XgmAtr/c8Mw8Mn0fdmAzNuAo1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlhfyDR3XzijXBq6p/7fe5ugtFtKTde/k5dEU/9x4a2SZq6IoXznlYpC62iBsy52UO/AcIotK9fVopr5Uy1iKvSkEhMbYcUkS4cfN9aiGrWKWkY9DZ2PYcgpYFyC1NglSG7H9fvkg69zUiYLElUaBAv4ECipCl6YGFupHwsbD5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jd6Rd12S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jd6Rd12S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD91F1F000FF;
	Fri, 25 Sep 2026 13:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790342211;
	bh=6hx8tIQBqEZCA6RMs3GEzhHsfOp+B8oZbYhgqwXwkDU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jd6Rd12SODX0oYmsCoaRKLziziTTpNy3IlG1EtScRfBvOOh4uiZx/tV8TPNkKx/PU
	 xjAPW4JQIPUpK52RBwytQfIfc/+ERRUlEQno4Yf+GKn3jQTjFtdkMqRYeq1c9iIzdp
	 62jNjNuqpq4cwtVijV2Kr3ARU+BY9ae0Rb3zYxk4IcgqZrxf1sssD36R5bzMv8TyNR
	 +LYVYdzXl49fxcE4JiVQupib8K742Gq3mQwVZkYyWAC3vg+GMiWXeyEiDhrd0z6KkR
	 i+zxMapSeo7WlNRMdubA0c1mPbPnHF3ktyDv3UHhEALo40au8F9yqOE2wDwcUH+kX6
	 o0XKE59ufoCrw==
Date: Fri, 25 Sep 2026 15:16:45 +0200
From: Joel Granados <joel.granados@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Bradley Morgan <include@grrlz.net>, Kees Cook <kees@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: drop the pointer dance in proc_put_char()
Message-ID: <id6ij3wpybrig6nqfydr522lhxoc7dsdvxnbn53pndnfq4vdjy@v3j37rvmluyo>
References: <20260822184244.13569-1-include@grrlz.net>
 <adblkub2acrgjlgmjs2uu5644zm5fjghjzr5zkyga7uatrfeif@jsumbzlthyfb>
 <20260916134700.3e0d17cd@pumpkin>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iwdvrmlk3hoahznz"
Content-Disposition: inline
In-Reply-To: <20260916134700.3e0d17cd@pumpkin>


--iwdvrmlk3hoahznz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 01:47:00PM +0100, David Laight wrote:
> On Wed, 16 Sep 2026 13:46:40 +0200
> Joel Granados <joel.granados@kernel.org> wrote:
>=20
> > On Sat, Aug 22, 2026 at 06:42:44PM +0000, Bradley Morgan wrote:
> > > proc_put_char() still drags around a char **buffer alias, writing
> > > the char through it, advancing it, then copying it back into the
> > > slot it was loaded from. That only made sense when the buffer was
> > > __user and the char went through put_user() (which could fail).
> > >=20
> > > Since commit 32927393dc1c ("sysctl: pass kernel pointers to =20
> > > ->proc_handler") the buffer is just a kernel pointer, so the alias =
=20
> > > is dead weight. proc_put_long() and the skip helpers already advance
> > > *buf directly, so do the same here. No functional change.
> > >=20
> > > Signed-off-by: Bradley Morgan <include@grrlz.net>
> > > ---
> > >  kernel/sysctl.c | 7 ++-----
> > >  1 file changed, 2 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> > > index f7b7598..2b92b30 100644
> > > --- a/kernel/sysctl.c
> > > +++ b/kernel/sysctl.c
> > > @@ -350,12 +350,9 @@ static void proc_put_long(void **buf, size_t *si=
ze, unsigned long val, bool neg)
> > >  static void proc_put_char(void **buf, size_t *size, char c)
> > >  {
> > >  	if (*size) {
> > > -		char **buffer =3D (char **)buf;
> > > -		**buffer =3D c;
> > > -
> > > +		*(char *)*buf =3D c;
> > >  		(*size)--;
> > > -		(*buffer)++;
> > > -		*buf =3D *buffer;
> > > +		(*buf)++;
> > >  	}
> > >  }
> > > =20
> > > --=20
> > > 2.47.3
> > >  =20
> >=20
> > I was thinking more along these lines https://lore.kernel.org/all/20260=
916-lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org/
>=20
> I think I'd decrement *size before writing to buf.
> Should ensure the compiler never reloads *size.
> Could also be worth an __always_inline - likely to make the code smaller.

This seems sensible. I'll update my the one in [1]

[1] https://lore.kernel.org/all/20260916-lklm-sysctl-void-vs-char-v1-1-c3f8=
b2eb8b1e@kernel.org/

--iwdvrmlk3hoahznz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2dDwACgkQupfNUreW
QU/Tkgv/ZlLbCS3lZcer7UKldjjY4KxG10Z+T5Q+QBndR6UiKbps/K6F196kvAud
LbjQoocc9goKr/jqlGygS6/F5+9Dk9tvyRuL8b03WKKJfi1A3M3PfN8U8PG+ykQ2
VjzlmaOSUx7RVqR5fGgM7qyUdCsKJcmtnTS4tBS9jBDT2w1ljlohrAeq5gBwZeRf
Dwu5MXmqmqdqoI4qLqvvQf1KbMFPxhFVYKe24vbRja+z1ZK3wEQDIZ0k25ADX8JH
G8Qu9zhzvIRQPFc+SI1Hn4Y7GPrHRNi2R7AnCWaK7z0Oc+xyUZNEWOLLtPQe8Fen
b58I7yiX8eEX2vYrifgBVQl5R8aspZSo7yYyGlxxxXDnASA5FOKNCecDSazTseQa
DErp1EDaoWDd6k8sOAzXsB5HQHvwzNOdXPC4/AjOHHVCwpgaqOvHg3dOCsTx09+7
Z4jn3yDHslgTxn7/+KKPdcqiUO0VZDUqtRssb1VMjAsy0krof9VylPEtHpUFzrK0
RsbvTR29
=qLEX
-----END PGP SIGNATURE-----

--iwdvrmlk3hoahznz--
