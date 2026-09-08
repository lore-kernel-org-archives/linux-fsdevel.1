Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB22526A81
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 11:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865615; cv=none; b=gu2LeMe/KgGPpKQwrDX7FPsvDlUBQDdXu6VbXBaBmR5rR+aWqT1TO2DlHYsijmR3UccUKrOG1SSLRNDcid+ZkoA6VgiJdhdI/mEbITjf6hwLfcxpsEI6ijJahPl3sXjla6hmwIZ0UZCjwDJsVgwguhnDlD7RhHYbW35E/VCyADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865615; c=relaxed/simple;
	bh=TS507TmLodCzO9RJeiDNW8sLtBEJmpa/UQKcKhYEP78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olQILB+I9qdTX774G7d3sS8YPQULU0+Y2lUcX26RoqgEi2QYesp6ZGTcSaeOuB9dfq4nXkYeWk0EXy/DtzQjbdnAX+2e+zS35p9NrYjQx0PQWRrtJhgGmu7aro2xGVRix9AX/+dDCbH96pukFM5BdXFGDTGoySNXxBvF6OQ4HqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STH12voX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STH12voX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81711F00A3A;
	Tue,  8 Sep 2026 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788865614;
	bh=rOI7E44KzfXkIAc6NKdq2v0xMr+J1XlMSmuuWaMil7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=STH12voX/4+tNc8KMsz6u36jNeRSTWuV9OjPlh4CH/SiPl0FpxUSO8mpN7lHA3fwV
	 VeeoEUM0z2xfBCHmlLzgAYYFGbKEkSjIHJguzLnpiZcQBlWCR5gBxroFWbn1Izssz6
	 ASjmdVFbtL5KjuksZ8JfOfvFK1bj+xuQFUMXuPgHa1Bz3LxPi4dpOr86fRA8z0MxMd
	 Stg0iUHbwUMlbU9ziSfoxBGVg8IiQc9zPcYDC9HOJLOrRf8uF8Gx1pHbzI4IvwvHxZ
	 wDUFlIu5QHBH9uGDDndG0dgcwCjTx6rCOH2P6ibW/KZjlEtB0cdcmORK3ZCxQXT07Q
	 5zt/madzOO6xw==
Date: Tue, 8 Sep 2026 13:06:21 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sysctl: Make proc_dointvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <7yotzsvlkroxfl3zkestrul7f5rh7vmlhuacm33reod7uw2mun@jrs7c2hud6oo>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="75lwjtmsj6kznau5"
Content-Disposition: inline
In-Reply-To: <20260905233819.1064529-2-kuniyu@google.com>


--75lwjtmsj6kznau5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2026 at 11:36:30PM +0000, Kuniyuki Iwashima wrote:
> When the cited commit converted the SYSCTL_INT_CONV_CUSTOM macro to
> functions, it accidentally changed do_proc_int_conv_ms_jiffies_minmax()
> to pass false for k_ptr_range_check.
>=20
> Since then, net.ipv[46].neigh.${dev}.interval_probe_time_ms no
> longer enforces the lower bound.
>=20
>   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
>   net.ipv4.neigh.bond0.interval_probe_time_ms =3D 0
>=20
> Let's restore the minmax check.
>=20
> With this:
>=20
>   # sysctl net.ipv4.neigh.bond0.interval_probe_time_ms=3D0
>   sysctl: setting key "net.ipv4.neigh.bond0.interval_probe_time_ms": Inva=
lid argument
>=20
> Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with f=
unctions")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  kernel/time/jiffies.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index 213ae1d6a014..70926b73905a 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -181,7 +181,7 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *n=
egp, ulong *u_ptr,
>  					      int *k_ptr, int dir,
>  					      const struct ctl_table *tbl)
>  {
> -	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, false,
> +	return proc_int_conv(negp, u_ptr, k_ptr, dir, tbl, true,
>  			     sysctl_u2k_int_conv_ms, sysctl_k2u_int_conv_ms);

oops!!!! Very good catch.=20

I can see that this needs to be fixed, but your commit message needs
work. Please re-write like this:


 Add the range check to do_proc_int_conv_ms_jiffies_minmax that commit
 d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with
 functions") incorrectly removed.

 Fixes: d174174c6776 ("sysctl: replace SYSCTL_INT_CONV_CUSTOM macro with fu=
nctions")
 Signed....

Why is that info about net is relevant here? I would remove it.

>  }
> =20
> --=20
> 2.55.0.1003.g10538fe699-goog
>=20

--75lwjtmsj6kznau5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqf7CYACgkQupfNUreW
QU9R5gv/XFGUDyAG5pe4+aK7OorpdjKT78QnW8R0eE1BiL+/lAS/UugLbckaeIZE
pryaqzjMcQJ4i+3vhgjHPC62kHZ196w20S9613l/K5ko5PCoWwG2lUQs2Nt6fvPZ
49Whh+/Z5rYQDAruCzR6cddl+fyxl2idD4l2930TjIneGwh5rRUF6MB5U/xM1CpH
a5p6QxVhA20zW6hcWqNmy2TVlqnEm/PDP3Ms17vqg+YIyXA1cIAIWWOa+/rSanwx
7PblJPdgUeZ3yasCOReeb/mOgYnbg9WPErWN2tAco76VoveBa/f+6z17xDjCyKQ8
TsBUZb+qwWNE4y2RB2ZRGvBijaKXvDDJYwFH/IbNF6ScwWueWBTedJazkm5S0XPr
i5eqSW1srYRJSVR/xte7XpqAkr3s35ZC+B3W7ImXHh10M3D1MCq3+aGv3cQg7YH3
HGKQc+lbqkckLLCbt/t50CqAzDGV06CprKbVUs/7kdM6JLbS+w2iPWQt6boywxYv
3M4CwAYS
=JhDr
-----END PGP SIGNATURE-----

--75lwjtmsj6kznau5--
