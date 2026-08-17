Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4504B049B;
	Mon, 17 Aug 2026 13:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973082; cv=none; b=j6QJr58MQnV4SUNgXzzICLLJr6ZMEk21+LG6o38TcxgtJeOwFc22PwHcZua88ICuhc1aV2UUQvFVSiM0yzIjNFgSeE5c92tMSmrlg0YzC2h0WH5KbIgwLtP4I9Vg8qf0okRTbUX9jG+GqyeFUO5BSsIh2mNqL4Vzs8B9Wq4cmQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973082; c=relaxed/simple;
	bh=f1qGOe876wPJ5xU2Dfdh4M+KKQYxeSz2vJqM0CC8ND4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTdxyKsgykFYg9rLCBEryE6NZ+MvHlp6z7iP+ryQbh2BmhZzTBCwfcLPYvJTNlI9LgOVpNb1I6EaUp38fHlfVlitjyKnfCja0WBMNSI39uI8rESxqDLgxt+g+TTtShkQ1KZuW2tDoBVO5mZ+6aEieh8kNzmuNpbIz0tHoNQic+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdAQ2Aks; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdAQ2Aks"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D451F000E9;
	Mon, 17 Aug 2026 13:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786973080;
	bh=9x/I2XWbWYVR3+1LarRSMKDhXqXNMBOiaGB6WU1r3DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NdAQ2Akssez/QFq7vDGuffjMTVgOKwOKMnLnT2VAKtPvmg3Hiota8QE475KcxAlHX
	 oJAB6/x1TZO537U7ykXiuoZRN+MAVmDSKqQ3eJZ/y6RH+PXcIinuRpP/WWJ1aK0fyb
	 whbWwz8rUJaFjsfULlCaP0sKjE/5jeUbtqQ9dkxLuiQdy+dHeE52WJGYvP9OCE8Qm1
	 f2443UmIYIdx+lGMBOV6z5YcBZk2jH8A46neza4dfJcumKHKTEI2MX44NjknJbKhkn
	 tL2Lmn+ZMdyrgtfF6Yog99KREMCa6kml+dIKpCEtlHcsoNonc0gAACc/3bLlIs1LqI
	 Ss6bciTfUOHig==
Date: Mon, 17 Aug 2026 15:24:35 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Jianlin Shi <shijianlin11@foxmail.com>, vbabka@kernel.org, hannes@cmpxchg.org, surenb@google.com, 
	mhocko@suse.com, jackmanb@google.com, ziy@nvidia.com, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org
Subject: Re: [PATCH v2 0/4] sysctl: Disallow partial updates of
 miss-formatted sysctl vectors
Message-ID: <bhe5eoysjusfrfyv4o43lrac2tvy4bvdfzthxyp63cwg3u37kl@sh6kdfukuheu>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
 <20260814123602.ec6889355580da96958b79d6@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6bqohl5pkbxvw5gn"
Content-Disposition: inline
In-Reply-To: <20260814123602.ec6889355580da96958b79d6@linux-foundation.org>


--6bqohl5pkbxvw5gn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:36:02PM -0700, Andrew Morton wrote:
> On Fri, 14 Aug 2026 12:41:11 +0200 Joel Granados <joel.granados@kernel.or=
g> wrote:
>=20
> > What?
> > =3D=3D=3D=3D=3D
> >=20
> > Stage table->data when writing INT & ULONG ctl_tables. Commit staged
> > data to kernel variable only when all the conversions have succeeded.
> > This is applicable only to variables that represent a vector; paths
> > pertaining to scalers are left unchanged. Notice that partial updates
>=20
> "scalars"

Will change in the cover letter (If/when I send the next version). It
wont actually show up in upstream as this is just in the cover letter.

>=20
> > can still happen if less than the size of the vector are passed and
> > correctly formatted.
> >=20
> > This is the behavior we are protecting against:
> >=20
> >   # echo "4 4 1 7" > /proc/sys/kernel/printk
> >   # echo "1 x" > /proc/sys/kernel/printk
> >   -bash: echo: write error: Invalid argument
> >   # cat /proc/sys/kernel/printk
> >   1 4 1 7    <- the write failed, the first element changed anyway
>=20
> I like the change.
>=20
> > Why?
> > =3D=3D=3D=3D
> > Allowing a partial change to a vector after returning from an erroneous
> > proc_handler is just plain wrong. This should be handled within sysctl
> > to avoid users having to do it for themselves [1].=20
> >=20
> > Behavioral Changes
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > 1. A failed write will not update the vector
> > 2. Vector writes can now fail with -ENOMEM
>=20
> Yeah, this improves Linux.
>=20
> > Testing
> > =3D=3D=3D=3D=3D=3D=3D
> > This went through regular sysctl kunit and self test. Also is posted to
> > 0-day.
> >=20
> > I always find it difficult to know who wants to receive this. Please let
> > me know if you want to be removed from the Cc/To.
>=20
> Sashiko said one thing:
> 	https://sashiko.dev/#/patchset/20260814-lklm-partial_ctlvec-v2-0-9df50d2=
6e477@kernel.org

The tests that keep on giving :).

I'm already working on a replacement for the sysctl selftests and prefer
to leave these as they are and address them in the new version if they
persist.


Thx for the feedback

Best

Joel

--6bqohl5pkbxvw5gn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqDC5IACgkQupfNUreW
QU/qfgwAg3uPWRE3j+KU7ZyoYAEq0nH8bVJrKBDHKYp6XnQI2PFycst64AzCaT1X
TDkuM/N0pKX0Ef+SwlzQkNCODa0bxzlj6SrFYNEoF/w1nvHzb9BqN3uN9Aaje9VY
ychArGGWx2OecBzJyuyYpNuxGqiXT7A2uVyDrknaTtFqgEdIRJg+ZmC4Hk/bKQqI
dHovH9ii3yNcnqjZaNQafdYIEIcNibLuBUyPHT3Vhv9J7aG+QaZufFlMhxGKDw4b
wjKaGTxOLwfr9YMB6eM3cYTmxRO6LDEhVWETAAWweL0zwOO+dnSVNFXiByX71VW/
gWY1gZpdm6Xaon5aNr2A1Ju/dAXQ6qjDIHhmuDjYjaH3iWnFmTXfIQHBxYac60m4
JtM/Qo2Ju7Ru/fvMsud+B3myqyXwg6nD32+nViDeUbdvXhtGKv4lr6q6tfCYVR9Y
hhAXg5c6S4HAu9H1GCivwjbd86chaFB8S9/naMKxJj+CIyfUjHSMs3WS5qITMZBj
+C2hpnp4
=zPyj
-----END PGP SIGNATURE-----

--6bqohl5pkbxvw5gn--
