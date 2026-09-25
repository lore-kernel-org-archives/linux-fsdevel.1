Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17D93E7BD5;
	Fri, 25 Sep 2026 09:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790327028; cv=none; b=WVvY+n1M9hCbiPJt2w6DIuWpCM6heisk0mt06L8S29/AWmceLljUNWN3U2tciX6nU/+CDYSkn02RZ2HNS+s8ooI5+94/6uuNiiD2DJtx1ruud/q8wkXBVMxQWkpI1mWCrQkBtrR0OqE5Lpl7o4JkbYpYW+3DowSJYY7HqlxHm+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790327028; c=relaxed/simple;
	bh=Sm6FqFncUDz95hOd50JBEkdhUffm/WSki014Zf+IacY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHHQN1v8b7wBZcS9v4+Pj7zH/Xq+DaRDzYGgUVrDVghDoKhkreYTiiO8WiLl3+Dd2n5kiSNIRoSc8BqgJhl8BpNxXSjXGztpz2O51lrqNwYFT9X7SUbEdMA8s0MCoHP1wo2lyl0xpmhXdDx9bxQbKr5KrNYWGyqAaMK5z4tw9fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESKGCPaP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESKGCPaP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 123791F000FF;
	Fri, 25 Sep 2026 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790327026;
	bh=p7nQkGAeAHXx64BF+olhlvPb5+TD8S7nvGhg+ZY8C6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ESKGCPaPSXDljbMLRbupThYpmLNIhWLjFhNjpePeM7MuHr/9qYqLgSCQiU3bMPtYl
	 3Qn3JVJ9Zo/IW4tedOyDKqecT+CTOClxVkyBLKRZX6b/38ZVhLVn1f4IbyaDcz6GO1
	 0LvYN2qSxt41gZMgPOMR6h1CV+6MfR3IhO4Dmia9S0koIU2mVNBdUavkCJCibXg/Dg
	 oIophFNbbV4eWyrIVzxli9UeodM/IhQvGvnURMx2Vjt347mtXV7o3X7sffx8Sip8o6
	 qSCUNd/557rFK7u8ZdnPaixulua+kU6CfM9ENdtCYYKGXD5Fz7xNhyVy3jvnddyTe7
	 HL9ROdb38tzhA==
Date: Fri, 25 Sep 2026 11:03:31 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Yibo Tan <lhfff@tju.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Eric Sandeen <sandeen@sandeen.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] test_sysctl: unregister tables before freeing bitmap
Message-ID: <azzmtohujpmkhyjdvehtq2oxtxfhyn2rwitrxtheglrh5lpata@maoxao2seo4m>
References: <20260919185110.2243068-1-lhfff@tju.edu.cn>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7k23m5y4f7w7a5r"
Content-Disposition: inline
In-Reply-To: <20260919185110.2243068-1-lhfff@tju.edu.cn>


--b7k23m5y4f7w7a5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 02:51:10AM +0800, Yibo Tan wrote:
> The table registered for bitmap_0001 retains a pointer to
> test_data.bitmap_0001. unregister_sysctl_table() prevents new handlers
> from starting and waits for active handlers to finish.
>=20
> test_sysctl_exit() currently frees the bitmap before unregistering the
> table. A concurrent read during module removal can therefore enter
> proc_do_large_bitmap() while the bitmap is freed. KASAN reports a
> slab-use-after-free in _find_next_bit().
>=20
> Unregister all tables before freeing the bitmap so the unregister rundown
> provides the required lifetime boundary.
>=20
> The unmodified module reproduced the use-after-free in three KASAN runs.
> With this change, three runs each completed 100 load, read and unload race
> rounds without a kernel diagnostic.
>=20
> Fixes: 2ea622b887e7 ("tools/testing/selftests/sysctl/sysctl.sh: add proc_=
do_large_bitmap() test case")
> Assisted-by: Codex:GPT-5

I'll change this to Assisted-by: LLM like it says in Documentation/process/=
coding-assistants.rst

> Signed-off-by: Yibo Tan <lhfff@tju.edu.cn>
> ---
>  lib/test_sysctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
> index 909cfcf76dbfc..dd795979558a2 100644
> --- a/lib/test_sysctl.c
> +++ b/lib/test_sysctl.c
> @@ -321,11 +321,11 @@ module_init(test_sysctl_init);
> =20
>  static void __exit test_sysctl_exit(void)
>  {
> -	kfree(test_data.bitmap_0001);
>  	for (int i =3D 0; i < TEST_H_SIZE; i++) {
>  		if (ctl_headers[i])
>  			unregister_sysctl_table(ctl_headers[i]);
>  	}
> +	kfree(test_data.bitmap_0001);
>  }
> =20
>  module_exit(test_sysctl_exit);
>=20
> base-commit: 40288c9206c17eb66a603262e06a58d300d0f279

I'll leave the Fixes tag but will add this to sysctl-next as opposed to
pushing it through as a fix for 7.3. Lets avoid making noise just for
the testing module.

Thx for the fix

Best


--b7k23m5y4f7w7a5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmq2ONsACgkQupfNUreW
QU/EHAv/cVW2QqHpeM19JThDEhrhbov44nVl1L0mxZITeCg+kxaChujxImv5eAg5
1bEGVWJHa/d6YyG6Ovtqs1biUDZt2JTlCnN0AhsG5clcWd/P9RMxK4pp5L99UyNt
M8W/YANaz/A/kjlKxU12YegIvD1f+ZDgE8v3JkdmTj8WeR97we9mN8y4Z+p5WO9v
UtiMS0qZcLDa7aYuZsK/1jNvCbWaSmRaLrzmyUNLi9LuN1vnrOGB72o+wrUMxZqF
mBbGzWwp3qOJvfvzsMjNRBn1m2PXh+KtOMnmZNuj/zg1uhN+yHQajHjjmZ/ZKN6y
CaBi3AHr31Wz4PS6OFmNk/xbj8OVD/qF7cAvl3Ktm6TZIRwoQhkIFMBPkUZi0LUU
rBmrqRLDsKN0l5DAudcEuPDleGIxhzEaZJVqbDIzSWwxPhvFIzBlxm9E9Exhs/48
lsPbjoejX5rJlf2J7G8Jw6KPg6HLxUAEfmTitu14jdYo1vBeDZ//0uQIeBRZHQW9
6HC93ZI/
=MWAC
-----END PGP SIGNATURE-----

--b7k23m5y4f7w7a5r--
