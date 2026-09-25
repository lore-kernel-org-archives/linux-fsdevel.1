Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070AA45517B;
	Fri, 25 Sep 2026 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336487; cv=none; b=sdlw83bgqzPrD/BfhCAD6yck9mMCxAj9xU7ryzHUjm1uFU5s29JCw8fsljG84OsXha0L/wJR2MnEfp98KHC/BrOYGeTdo3JYQlDYKP937dcLMOOqQUxICYDbeTYOx1q0NDB2gmtvASsxRgKY8zfZp2IlyTpxa1/jpa6DUYd6dWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336487; c=relaxed/simple;
	bh=XiiPB+FbCJdM6oIqRAgsmD78MaPpFeEiT0pGn495v+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHsfEkNqc1Dnv6jKuQ5FQ0aIxBcpQAPK+VokLZKegqISlB/Gi1ltvrK7tSaNwn1XRa6D3XEWGxQMCL0IMqTjLqYVZbtpKTknnVNzFC0le0cinEtpS9LOK/Xb+moZRUqg6r9zS09kIExBlsh0MOpCK4SCQABnRBqm1KW1gPqg6hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ4qUNL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ4qUNL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146CA1F000FF;
	Fri, 25 Sep 2026 11:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336485;
	bh=MxxmDYqVmsOWYXTK0qlwwWMA86kcPpzqofwslHtxAzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EZ4qUNL6FavEGgiD2xq0fX5KvMrG4f8RhjOsGojcxvXB1e817DV9eNyejN9ziTiMo
	 AyAYUST23qRY6f8lU9YmTbpTCuG2gLO2kSc7Ukyc1YwuiyZjIJaeJztgazaHvLS9Fd
	 houTACD4ysn3WSPPZnT+hW7v+5MTWqIlYO+6tM1kzqyoSjGSojSD7jNB7RsW9kaSSS
	 XqUDQvfVqJrB0LEg2L1U0MFlDgrTl7lRslf1QIsWNVfYv14gXO38vU+j/sPQVIqzPU
	 AYgnCs1M/OTgC02/UERYAF9AfvpIVClqUHflRZtwd/qUjK4rr40FLUNpXHvrLiPfci
	 dx60ccYH8FENw==
Date: Fri, 25 Sep 2026 13:41:03 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Zhan Xusheng <zhanxusheng1024@gmail.com>
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, Kees Cook <kees@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Bradley Morgan <brads@mainlining.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 0/2] sysctl: Cover the jiffies converters in the selftests
Message-ID: <47yicm235r42m7dq2xms4mpbj3duvv45rfvgu7od3vc5juw7tr@gefmt77hty6u>
References: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rwkr3fnexotac6mi"
Content-Disposition: inline
In-Reply-To: <20260923144940.3712965-1-zhanxusheng@xiaomi.com>


--rwkr3fnexotac6mi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:49:35PM +0800, Zhan Xusheng wrote:
> Joel asked for a test for the negative read path fixed by
>=20
> 	https://lore.kernel.org/r/20260922031229.2300283-2-zhanxusheng@xiaomi.com
>=20
> These apply on sysctl-next and depend on that fix; without it 2/2 fails,
> which is the point.
>=20
> While writing the test I noticed that fix's changelog is incomplete: it
> names proc_dointvec_jiffies() and proc_dointvec_ms_jiffies(), but
> proc_dointvec_userhz_jiffies() goes through the same
> proc_int_k2u_conv_kop() and is affected too.  Measured on
> net/ipv4/neigh/default/retrans_time at CONFIG_HZ=3D250, unpatched:
>=20
>   # echo -1 > /proc/sys/net/ipv4/neigh/default/retrans_time
>   # cat /proc/sys/net/ipv4/neigh/default/retrans_time
>   -18446742229035144246
>=20
> I will correct that in the respin.
This means that you will send the V2 of the fix (not the test). Right?

>=20
> Tested in qemu at CONFIG_HZ=3D250 with CONFIG_TEST_SYSCTL=3Dy, and built =
as
> =3Dm.  2/2 reports "not ok" without the fix and "ok" with it, and the
> pass/fail counts of the other tests are unchanged either way.
>=20
> Zhan Xusheng (2):
>   sysctl: Add jiffies converter entries to the test module
>   selftests: sysctl: Check the sign of a negative jiffies read

I just tested this in my env. Works like a charm. I even rebased the fix
on top of these tests and saw that everything was fixed.

Thx!!!!

The testing code will get added to sysctl-next, but the fixes should go
into the current release. Will wait for your V2 to forward them down.

Best

--rwkr3fnexotac6mi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2XbkACgkQupfNUreW
QU8fHwv/aNtuGJPW2fKgXw1uyQa+ZDSeoAyMXK0L7cKqmSdboBdvaVD31bzmD2ix
l7p0CN2j1vFi9uSbaOU+NgNe5vTQmsBADhCtyO3FAM46SexyqznOHn7VN+Ixv0Lr
rT3KsSn2ug/W2UjsNIn4yaGBTgSmPSjvlV3HeMP39lMzuTasEFwH/ngDvFnqjFUj
5cwBBYyhBFeBRvA6xtmCNTamtuyBE/TBRQszGEY+sQAoKVNiCbX9g35HjmsFNMEh
64DvzXMiRr/smEKjanOELXsRdzdIX5MhWc6RPpE9LThOw107+74y3eDTKVYWjO2Y
cCZrrfK9RWly/WPpnXH6LtL+y8zXJMw1f5kWRxRcMw4feHxtHlrfbTkeSyvTVd4G
lNf32YaqWiA+EYny/n7+vUUThW8j2IJkSNWqqCkotBCWSAHULh9iOkCw7aCf9yiK
h+lENwH2DD2YiSAg2AsGmt3WybWDOjr8g8erZwYflnW+qDmYrjtUxsDbpeh+apa3
HNzo6Yg+
=VUV6
-----END PGP SIGNATURE-----

--rwkr3fnexotac6mi--
