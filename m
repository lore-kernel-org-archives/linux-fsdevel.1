Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63634A49A5
	for <linux-fsdevel@vger.kernel.org>; Fri, 18 Sep 2026 11:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729521; cv=none; b=mo10JQQp9fADWubo6hjj+o+htfJbbFnxq91YtLfEqH0C45iVoNGboMFhG/G+dUYNNKclNbBoZzZiIr3Y9h+elRTaCeJjt5qQvfyo0n6RB7Py53Hwfrnzqcy0LACoJviB0JF8zWs67Is5LORaGurOdLDHubtJ+aSSkSLoa5i53+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729521; c=relaxed/simple;
	bh=tZTs5KMOPvEPMY//V7vtjqIKa4V8kqkzhNURvkug5yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uD8G33ZD8Gq7qTqT/D2DQdy3Zran8qFRrLU5kGLTz2WtW+D8+9J8daG6MdA47rFnpR+Y7DFguX1GC2FEC5xABV+gJ5NgvuIh0V3bt5LO/s3LpUBvQvnfbmhj125TyfAhO6dLVlkcwl5LMcv+jZggZej6IhXR5vxjGffQRU36/xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVP3fU50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVP3fU50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E0D1F000FF;
	Fri, 18 Sep 2026 11:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789729515;
	bh=TDedyFD9KCLabAKFSmgjCjyf8GCIS9LSBAXGFKo0FrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PVP3fU50esYdPE1CQthQhGFZpofqr6CHo+k2FaJ40V4Q3onhgvSqdAlxc80zo+nfr
	 XUOQQGaLracDfAHeg6Nw75SLQ2pGT2zl2lDbzW5KcaT/Gi1nzNjqvLJy8R34CMY5Jz
	 /0H9F55skAGGHTcWS9hWqWsaMjPKxKJ7Nknx4vJ4gi4IE34s7wNdjh4xR9sdK0Mdef
	 dF/fc1//ioqIf9QtyD3/9TemdbP6xNlh5cETPxjRX+T26BIjaSv7qzQ8CBlJQXtmQI
	 JIixfZKbYCjLV8xOtheXKGtk5eSi8qig5lejcyxUbxBR9KhbTkCnuNCgR/D+TOGKPR
	 KW98hltCSHGDw==
Date: Fri, 18 Sep 2026 13:05:00 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] sysctl: quiet unused variable warning in
 fs/proc/proc_sysctl.c:init_header()
Message-ID: <iguoigeao5itgylh6kmzwiiuwk4pqra32vpqvyv2ingitchs4w@pctwdteu52mh>
References: <20260918062338.1039303-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6ray4taxck3vvgdk"
Content-Disposition: inline
In-Reply-To: <20260918062338.1039303-1-enelsonmoore@gmail.com>


--6ray4taxck3vvgdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 11:23:38PM -0700, Ethan Nelson-Moore wrote:
> The init_header() function uses list_for_each_table_entry() without
> using the entry argument. This causes a warning when building with W=3D1.
> Since the code is correct, mark the associated variable as
> __maybe_unused.

I'm probably compiling in a different way but I don't see that warning.
Can you please tell me how you compile, what are you are in. What
version of compiler are you running?

Thx
>=20
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  fs/proc/proc_sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
> index 04a382178c65..d0d76c31d330 100644
> --- a/fs/proc/proc_sysctl.c
> +++ b/fs/proc/proc_sysctl.c
> @@ -206,7 +206,7 @@ static void init_header(struct ctl_table_header *head,
>  	head->node =3D node;
>  	INIT_HLIST_HEAD(&head->inodes);
>  	if (node) {
> -		const struct ctl_table *entry;
> +		const struct ctl_table *entry __maybe_unused;
> =20
>  		list_for_each_table_entry(entry, head) {
>  			node->header =3D head;
> --=20
> 2.43.0
>=20

--6ray4taxck3vvgdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqtGtUACgkQupfNUreW
QU8aPAv/STzTb7hj2WgkJ9nQBUBhNvCgYH9IEp7vw/7is/UOpf/Cr8zPJ3sU1DnM
UovVLAAYMhZ0MVwVqONB4v9lGdigGumKSKUI/9irXEkUuYmB1BEvnZW670CBWjld
/1iRqiYiZry0r6mT5+2GiNGjDaopF45qH1wHOV+qDHdCNT7/IT+RYyrN8FZ2wHb+
BrT1fQm0Vo0b5H84uFpx538LHEMVx+r7Cj7RkhvkYXViUYymNGgeAUYqgTkeuuGo
5WBXFqXRtvoL9ULdq8gXGkAQ4E8Cm/bqw8hZHpDnwKRhqFUuW1NTNFX03CGAhrRR
8ETG5nhsD7/9PoXo5PVlPyz03YyHHasPiTR8YxeKSY8V3mYWfvTtLLdx9aXc5Paz
TJXttvaR5TyXD5qba5zGAzh70Z+Wlt8iNWyxCsMgreAW/aBzVo1J9PlMgekQX5gk
+5VL03w2zVn66ZIFqRwibYweQsaTkuv+cC5c60LQcBOYn2Yv12/vJJfnDw808JhN
tjmePb8h
=dlh9
-----END PGP SIGNATURE-----

--6ray4taxck3vvgdk--
