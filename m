Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375A23D2A1;
	Sat, 22 Aug 2026 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787403152; cv=none; b=fvT+bidbkYbILUU6Ourec3H6OcIlcIBykuBRVwTfTnMlg5lV0BoLMgr+ZcolktfTvSSkZroT5tKH/pcNIBITdUxKp6MSXqhGdabc1gNzucszGnD3DDHXK4nNco2Tq2DtaH9le5shG77cjtp9Ggti0onS2fSWp9JTXIqcWO2sspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787403152; c=relaxed/simple;
	bh=MGjzS0erfet7SQLrmRWxsUuzQw35oAieJD+U5Ns+pMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0YrBJBMuXWJWH7aM4pyBPb7dLCQRZYl2kR7SKuA40s4wfep8jFyrGNsvz6CHj01yA92EGyQbq9IpMtgNp8wbP4x42ULusepafuGNEIqcNHdUWkVA+XGBfeQX3XVIfi1LoLFkCf5HqvdMCCQSY5RnlPVnvybxFyxEIzn8eFCWsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC6i5Ve0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC6i5Ve0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BCC1F000E9;
	Sat, 22 Aug 2026 12:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787403151;
	bh=K7iyXyNsM2ASzN8KF+DRnHdRovf+1Dd9AnIzkSVPzgc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZC6i5Ve0MD6ItOLg4MZgv8tzt077hosCvO1IkVlgt2s5DjuIOSKQZ38GHgfNLmZal
	 381LtcQEhJcsNo8bqhJS8QstBhVhyAzKbnOQklO8bURGJDSQgW5rwrulqWAGt876u3
	 3ffbLMJ8oHCQ8buUT4HHHr5XUR3ulvZuO+XPIKi4p7Yt5A4JJkZM8oevF4QxMX4XAr
	 OLSasU4SVGxwLoX65Vi9HqqN7/9h38Hxk9ihDDKhjhex8RmLSVaSuDV1jpIHfl9GN7
	 /M4AUcziGHOj9uH7jpouBDR4cBcfly0ddHSxAlf5tgxEhZH7OMa7uCjbP4u/LZ2spM
	 QLBiIZuhloLIA==
Date: Sat, 22 Aug 2026 14:52:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] man/man2/statmount.2: Fix incorrect function signature
Message-ID: <aomZfSXwrctrBbqX@devuan>
References: <20260815074526.1094308-1-b.sachdev1904@gmail.com>
 <aoLOb0tixHee3AkZ@debian>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tja6hontmgrqbpwb"
Content-Disposition: inline
In-Reply-To: <aoLOb0tixHee3AkZ@debian>


--tja6hontmgrqbpwb
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Bhavik Sachdev <b.sachdev1904@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>
Cc: linux-man@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] man/man2/statmount.2: Fix incorrect function signature
Message-ID: <aomZfSXwrctrBbqX@devuan>
References: <20260815074526.1094308-1-b.sachdev1904@gmail.com>
 <aoLOb0tixHee3AkZ@debian>
MIME-Version: 1.0
In-Reply-To: <aoLOb0tixHee3AkZ@debian>

Hi Bhavik,

> Date: 2026-08-17 11:07:45+0200
> From: Alejandro Colomar <alx@kernel.org>
>
> Hi Bhavik, Josef,
>=20
> > Date: 2026-08-15 13:15:26+0530
> > From: Bhavik Sachdev <b.sachdev1904@gmail.com>
> >
> > flags argument is an unsigned int not an unsigned long [1].
> >=20
> > [1]:
> > <https://github.com/torvalds/linux/blob/master/fs/namespace.c#L5961>
>=20
> Thanks!
>=20
> > Fixes: c011cc992510 (2024-07-09; "statmount.2: Add page")
>=20
> Please CC the people involved in that commit.  (I've done it now.)
>=20
> > Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>

Thanks!  I've applied the patch.


Have a lovely day!
Alex

> > ---
> >  man/man2/statmount.2 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/man/man2/statmount.2 b/man/man2/statmount.2
> > index b6d9dc2a1..a365002dd 100644
> > --- a/man/man2/statmount.2
> > +++ b/man/man2/statmount.2
> > @@ -16,7 +16,7 @@ Standard C library
> >  .P
> >  .BI "int syscall(SYS_statmount, struct mnt_id_req *" req ,
> >  .BI "            struct statmount *" smbuf ", size_t " bufsize ,
> > -.BI "            unsigned long " flags );
> > +.BI "            unsigned int " flags );
>=20
> LGTM.
>=20
> $ grepc -tfld statmount . | head -n4
> ./fs/namespace.c:SYSCALL_DEFINE4(statmount, const struct mnt_id_req __use=
r *, req,
> 		struct statmount __user *, buf, size_t, bufsize,
> 		unsigned int, flags)
> {
>=20
>=20
> Josef, was it just a typo, or is there anything that needs checking?
>=20
>=20
> Have a lovely day!
> Alex
>=20
> >  .P
> >  .B #include <linux/mount.h>
> >  .fi
> > --=20
> > 2.53.0
> >=20
> >=20
>=20
> --=20
> <https://www.alejandro-colomar.es>



--=20
<https://www.alejandro-colomar.es>

--tja6hontmgrqbpwb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmqJm4kACgkQ64mZXMKQ
wqnTShAAmSr/Mh/QNl+pG4/EHFNYWErWbv8zXGTDOxmXLVfguzI8T8806GoirDl3
/d3zvR6LS/G8fftOOGzEkLDGGQRmmm+2GE7LaElfHUs4jUClzCHpUAkJX2UUyMzo
hk3kywZiC0BNnRYQAUxrWXsarR5r4xK+fMqJroK0otmb50BDdDTZ9Zhi3FAGjNnD
7m99qNhGOIxuomgPb3CDGZwPnpY2Xv7YjiBMPdBh6SPiwmgA4nbAWuZeP1vI9vhL
g7GrOQtApgtZJ6/rH29ZZVx+vRXoQsHEnSYYzM8VV34bAZ4iERrzbnWGCiJPOGPa
OjfNc50ZOKJZc9/ubcTwUZwE5wn2unmVSYkEf3yflcpjzxZ3DkCh9hWIU3rAfIPx
mTwgwJ/kwvQv4rimBIxp7bmn3VZMFOfC4hySIbEIyhafqX4UeYY4zwXM8kwkBXNB
jvTdtGGQLTesC61BAJeBCZQbvij2EjCADvv4ONaiaOlSeHne90vfX25zhKh7c0Mh
uZErOTjHGiS4v17tKWvhNcx/gXCy6g05TSZ4asvte9M5+v+tDptSQhQafu592jmL
8YilRgCnIHRdAA8KosYYbpbhzck4n+M+xAnhf7/JBPCd/08KcUn8xt3IZ0Smij7X
hZbUNGX5eIK3j6kWxbl1x04FiXi1rE3FGysmI2BqWPKhbh8Ui9A=
=in4K
-----END PGP SIGNATURE-----

--tja6hontmgrqbpwb--
