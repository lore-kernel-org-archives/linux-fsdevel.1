Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C95317144;
	Mon, 17 Aug 2026 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975353; cv=none; b=dZH7ec55i3mCwYxV+HlxxdG2WDElsb3pDPMLhvVY5MkZfdZbKHsM6bNSE9JUBr7IXdTmD1UUvabbaKWYQQGMhkuoeR4HqgymF4affkJlSHp07WbTgF1W7GIDZ9QGJtf8n+TkiUDGKcr57bTVoa2YYll1O794AxoIWt+M9k4yKMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975353; c=relaxed/simple;
	bh=L2t0Ny/8Si5OSCXFsnjWNsDjqGfZ99jBv8yaF3ZFyDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oaikSGlzrVCRMP3bogj57He4aoCQGfFCHu5dQR1R1+CeI0Zdb6l3rctATUzWC+isiI/U1ANkCXMzz/qebaj3qEfqu7l4swGPiX+O7uuXzvuz8qOzoE8UE9pl3ZwbGDxs27pgumn3m0s4Nmx4HHabisqjZ/Alzd5uRCGoQ6JuIB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0fdQcbf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0fdQcbf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71321F00A3A;
	Mon, 17 Aug 2026 14:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975352;
	bh=Bk9cL2KwgbRIb7nFwPdx5v6FOYyA9DjpsbTLZv0L1eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y0fdQcbfy5dn/lI+yaPAltT3j6k7+vfjdPcicURAunKJ0n/z6Ts6qaRa2AQVqc6pU
	 jcNPzCElF02SHYK35UcHOuWU1fv7xQIi1GTR+XqF+UryArI+SRmggY3LfKOmEMsSvW
	 dnMYlqHMKtkowxUhDeUanWaXuckc6bP0hnSpkXUCtSC56i6G/pGLedy+v1AL6Oz/EY
	 /dJu2mBJCvKwVIAb6wBVApzGWiOtvkvTeI3m7MlYozvqmCvGOc3KRZHwvO8iz1C6Mx
	 cJxWae18iVMl0VXCkNHaf1dbUTUhQHcwPQ0AJ3rAnD84tCCJmPuhWFT4qS7zk6yZ94
	 xdp8YrNZ+q0LA==
Date: Mon, 17 Aug 2026 16:02:27 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Jianlin Shi <shijianlin11@foxmail.com>, akpm@linux-foundation.org, 
	vbabka@kernel.org, hannes@cmpxchg.org, surenb@google.com, mhocko@suse.com, 
	jackmanb@google.com, ziy@nvidia.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/4] sysctl: Disallow partial updates of
 miss-formatted sysctl vectors
Message-ID: <gxiyb2aye6vvu6t7veykvptj4t3hxll67mugievbumjc6krstw@nivusuyqhpbr>
References: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5sktdhveowv3yy7h"
Content-Disposition: inline
In-Reply-To: <20260814-lklm-partial_ctlvec-v2-0-9df50d26e477@kernel.org>


--5sktdhveowv3yy7h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 12:41:11PM +0200, Joel Granados wrote:
> What?
> =3D=3D=3D=3D=3D
>=20
> Stage table->data when writing INT & ULONG ctl_tables. Commit staged
> data to kernel variable only when all the conversions have succeeded.
> This is applicable only to variables that represent a vector; paths
> pertaining to scalers are left unchanged. Notice that partial updates
> can still happen if less than the size of the vector are passed and
> correctly formatted.
=2E.. snip ...
>       sysctl: Split data conversion and file position handling
>       sysctl: Reject uint arrays before calling the general proc_vec
>       sysctl: Disallow partial updates for erroneous sysctl vectors
>       sysctl: Add 0013 to test partially updated vectors
>=20
>  kernel/sysctl.c                          | 237 ++++++++++++++++++++-----=
------
>  tools/testing/selftests/sysctl/sysctl.sh |  60 ++++++++
>  2 files changed, 217 insertions(+), 80 deletions(-)
> ---
> base-commit: 4c12287001da60f3c022bb25932aa7a5590fc0b1
> change-id: 20260813-lklm-partial_ctlvec-bd8867b70d5c
>=20
> Best regards,
> --=20
> Joel Granados <joel.granados@kernel.org>
>=20
>=20

I feel the superficial changes mentioned in the review (up until now) do
not merit me sending a V3. The modified tree is here [1].=20

Best

[1] https://git.kernel.org/pub/scm/linux/kernel/git/joel.granados/linux.git=
/log/?h=3Djag/partial_ctlvec


--5sktdhveowv3yy7h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqDFHIACgkQupfNUreW
QU9Wtgv/W/Mxbk0Y5tHUqDrqO0jIgDma4VYCc49F8BOBiB9Y+y1EdV7R1UJ3rIwv
BttI+rtCWKIsKBhJEZBHsCiyX2k83LH93TfXi5Wihrq8n/YN6xMzKvOU1mxSH9uB
2MHNuUAmTFJtAnt+GCXroOizzsivvzcN6Xr3Xf7KseVsvTU0Jzn7YzX2v5gAbwK8
6VhW8uVlbD0oPpedkkZAWA/Il6jKb4SN431WgYOt0hLU5TniChtQs37E7JZQJmkJ
s5D7/H/E+IhhIOs8PZGUyAamcZe3I+DIQzIl2o6rPSFxZfwpqApJ+ZRGvKDdbSOk
6L0fqamT6DeTIhnYvpQ5zte+g69C2sWP9+PU+5bjbeAtcxrtGpo4tYie53GANrc+
o6N/qR4ag9GWVNk0KfEavJCcD7kBZuWEiF8UoZSS8EGMkczn+pnvjMSFoCUfkKSx
kggJHEsI027hD2yZXnTWeGk1YWmFnAlfVx2vbIMrdiH3OqeMA4kHt0otPqaxPy0Q
llqAqVbl
=78b3
-----END PGP SIGNATURE-----

--5sktdhveowv3yy7h--
