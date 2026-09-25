Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8C6490BF8
	for <linux-fsdevel@vger.kernel.org>; Fri, 25 Sep 2026 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790331992; cv=none; b=bnEKrW/R3y2s86D0270TkNk7C9iHE40Wn+VpWGCUmJWLJfryV+73yZ4hSl0wnxCPLNL9qXhh/okLOdEawEJ5ulhHXHLntnH+8oLg8G/CRMBTTHN+Yq8hzGsjMJt61nqGrC3WRaFDzlpbzcu986O6hh2ZUOwZpmkzcQ/Kiy+64ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790331992; c=relaxed/simple;
	bh=RHu0TsHI8c3CcxCtKzOzi4bVIkKNUk5PwG3ZcDcVhZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=calI1+FN5hNTKNrDsihUEx9rt+nfxElctGESRxyZNZYszg1pXKmynGa4YofIAAr4JnKhsUwOC92qnxh5tH6kvBkQw7sckYymOjT6GIdnyqVjmDxiDbMQnqrTAlKqKmkTRyc9R+g+UeTG9kVtBfrrHmFWPcblLcSvkbgLi8KqeXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Abd7cL7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Abd7cL7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6851F00893;
	Fri, 25 Sep 2026 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790331990;
	bh=RHu0TsHI8c3CcxCtKzOzi4bVIkKNUk5PwG3ZcDcVhZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Abd7cL7pKc3PRiUoA1jU0PPZs9Fh5c1TLxr/MpOmXpNI7A+9M12Ct0p+/8W2FjGF8
	 3HuxXUZILBUbcmpmsfJ5DvGa/D+9ZR4OttZkecrebYxpbTfpagfv6pBjdEn5HJzc4A
	 AIy8cszRuDLRXy+MiFG+RvCbfjVIh6Xgo5QRBqcVc//Yo/4M/nY2x7hZGFD6a52xWj
	 Wefh0K2WkcaegFaF7sIcXWjgG2UgsGK3z/KbyTh0DZxoiqs4Ty1tVY7g/Z2EIpE2tz
	 59W7e1lxmOjVaJgrah2vd9p99+HBwHdJ2NOmXsMtfLFOao0zp2t6tKXCsaU7GHg/et
	 tXCPDBptZtpGw==
Date: Fri, 25 Sep 2026 12:26:24 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] sysctl: quiet unused variable warning in
 fs/proc/proc_sysctl.c:init_header()
Message-ID: <lxanrovazjrvpykivwtqmq2cgj657zfafp5msnk32qa5adxbt4@gotthttxuza4>
References: <20260918062338.1039303-1-enelsonmoore@gmail.com>
 <iguoigeao5itgylh6kmzwiiuwk4pqra32vpqvyv2ingitchs4w@pctwdteu52mh>
 <CADkSEUhL1bH7BRS-cTxA7UHfqdGB=y4RQnoH6aV+d1L2iDQ+qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a3bttmdf2bt6zo3u"
Content-Disposition: inline
In-Reply-To: <CADkSEUhL1bH7BRS-cTxA7UHfqdGB=y4RQnoH6aV+d1L2iDQ+qQ@mail.gmail.com>


--a3bttmdf2bt6zo3u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 03:58:43PM -0700, Ethan Nelson-Moore wrote:
> Hi, Joel,
>=20
> On Fri, Sep 18, 2026 at 4:05=E2=80=AFAM Joel Granados <joel.granados@kern=
el.org> wrote:
> > I'm probably compiling in a different way but I don't see that warning.
> > Can you please tell me how you compile, what are you are in. What
> > version of compiler are you running?
>=20
> I'm using GCC 16.2, which probably explains it, since newer GCC
> versions have gotten more clever at detecting unused variables.

I'll add it to sysctl-next

best

--a3bttmdf2bt6zo3u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2TFAACgkQupfNUreW
QU91fQwAlyo1simDoNgk2DrYeRTy+vSnBOHM0e1KBDKDxuhOXwSN0EQGxqTvUH9n
PIbEnRRqdwoVmcXQDKcBbHVZzlOnqZiQwXR9aLyIQKL7pohY7B40VAV/fIFTMzmG
0GuNaMU0WQ9ArdrBsEkUzehwLI/DlSL6t/XdupprdNuvnxb+MggYwm6Q3zdxZG5X
oxuXxPXElHx92E2Ol6qkz7cVJuCBGQggHt+RUKVUcjZp8g9vHFwvadkqrzg8/EUT
VuQGj3O4qUOC7qvHpPy6Djwge6uAG0edMwggQV2QiZL4Q+q4sRGdsa6AnIszGDbf
OXl08vNcdiPDJ6ZCWQ9UPkbV/wjBNhmqHbupZarY+7SKBWjZ2jASgfy8H6GcL7Ru
zEKAthpMQAmZzk/duOagVIwXniPPwjycOKOEuG1f+gNt6YbbpLQ0KnWy9wiYMQ0V
bt/EgpBtnDLKmbljcdxgZ9sF0JiU1ZqXd5L2hcWUOo2xIYuB+nWIUv4iDnsOalbh
M1mJ9WKr
=J7sg
-----END PGP SIGNATURE-----

--a3bttmdf2bt6zo3u--
