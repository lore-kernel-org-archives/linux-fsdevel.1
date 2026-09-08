Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C28525A88
	for <linux-fsdevel@vger.kernel.org>; Tue,  8 Sep 2026 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869759; cv=none; b=WaBxNqhIxR7LQFfwf4MEr7fW1Br+dJiWpBHycN5js3Swoik5gtHtmev+nhmVmp61bSLnL+E7j96GG9gXBUAJiTWgDgEChosu9QDan1ozkpY6FKbFIg7c9boBa+K7XmnME/w5wDKI0uR5+5sXczxejkpi/VUSxQWLNvYP28LkAl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869759; c=relaxed/simple;
	bh=iaTIzq2y6NC7MJ2WHFnZGYCtVwesa0wSKXwAgN914rY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4sCGJ0fhS8rYlhE8dtsNEsY/IZ1LD14BF6OkPaQuLYO32jwjqJ1kdkW+gTQU/6ws+qyN1jzEpD+9P1MLbSvaRUc/hraxH2vjn/YfhYLj1d8Gxz+/uVc3L4MzE2obaB54J88HOwTRcjxJSCjDAe2F/XC7SCyZNeOblprNXC78us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF421F00A3A;
	Tue,  8 Sep 2026 12:15:48 +0000 (UTC)
Date: Tue, 8 Sep 2026 14:15:39 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Kees Cook <kees@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] sysctl: Make proc_doulongvec_ms_jiffies_minmax()
 enforce minmax again.
Message-ID: <hbatn4h5342kuvni5jcfjpdfjfof7dbsld5m26x6dla7ennpey@usgxbvlikr4i>
References: <20260905233819.1064529-1-kuniyu@google.com>
 <20260905233819.1064529-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kkhksf36vhfbiaq7"
Content-Disposition: inline
In-Reply-To: <20260905233819.1064529-3-kuniyu@google.com>


--kkhksf36vhfbiaq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 05, 2026 at 11:36:31PM +0000, Kuniyuki Iwashima wrote:
> Since the cited commit changed proc_doulongvec_ms_jiffies_minmax()
> to use proc_ulong_conv(), proc_doulongvec_ms_jiffies_minmax() no
> longer applies the range check.
>=20
> It happened probably because do_proc_ulong_conv_ms_jiffies() does
> not have the _minmax suffix.
>=20
> In addition, sysctl_msecs_to_jiffies() casts u64 user input to u32,
> and a truncated value could bypass the max check.
This is something that is orthogonal to changing to true in the
proc_ulong_conv call. Please put this in its own commit.

This also begs the question: why not just use an int converter if the
range of the values is going to be u32?

>=20
> Let's rename do_proc_ulong_conv_ms_jiffies(), pass true to
> k_ptr_range_check, and limit the max user input to INT_MAX in
> sysctl_u2k_ulong_conv_ms() to avoid truncation and clamping to
> MAX_JIFFY_OFFSET. (INT_MAX ms ~=3D 24 days is more than enough)
>=20
> Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with =
do_proc_vec")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  kernel/time/jiffies.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
> index 70926b73905a..4737431fdb16 100644
> --- a/kernel/time/jiffies.c
> +++ b/kernel/time/jiffies.c
> @@ -187,6 +187,9 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *n=
egp, ulong *u_ptr,
> =20
>  static int sysctl_u2k_ulong_conv_ms(const ulong *u_ptr, ulong *k_ptr)
>  {
> +	if (*u_ptr > INT_MAX)
> +		return -EINVAL;
> +

Create a commit for this on its own.

>  	return proc_ulong_u2k_conv_uop(u_ptr, k_ptr, sysctl_msecs_to_jiffies);
>  }
> =20
> @@ -195,10 +198,10 @@ static int sysctl_k2u_ulong_conv_ms(ulong *u_ptr, c=
onst ulong *k_ptr)
>  	return proc_ulong_k2u_conv_kop(u_ptr, k_ptr, sysctl_jiffies_to_msecs);
>  }
> =20
> -static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong=
 *k_ptr,
> -					 int dir, const struct ctl_table *tbl)
> +static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr=
, ulong *k_ptr,
> +						int dir, const struct ctl_table *tbl)
>  {
> -	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, false,
> +	return proc_ulong_conv(u_ptr, k_ptr, dir, tbl, true,
>  			       sysctl_u2k_ulong_conv_ms, sysctl_k2u_ulong_conv_ms);
>  }
> =20
> @@ -229,8 +232,8 @@ static int do_proc_int_conv_ms_jiffies_minmax(bool *n=
egp, ulong *u_ptr,
>  	return -ENOSYS;
>  }
> =20
> -static int do_proc_ulong_conv_ms_jiffies(bool *negp, ulong *u_ptr, ulong=
 *k_ptr,
> -					 int dir, const struct ctl_table *tbl)
> +static int do_proc_ulong_conv_ms_jiffies_minmax(bool *negp, ulong *u_ptr=
, ulong *k_ptr,
> +						int dir, const struct ctl_table *tbl)
>  {
>  	return -ENOSYS;
>  }
> @@ -333,7 +336,7 @@ int proc_doulongvec_ms_jiffies_minmax(const struct ct=
l_table *table, int dir,
>  				      void *buffer, size_t *lenp, loff_t *ppos)
>  {
>  	return proc_doulongvec_conv(table, dir, buffer, lenp, ppos,
> -				    do_proc_ulong_conv_ms_jiffies);
> +				    do_proc_ulong_conv_ms_jiffies_minmax);
>  }
>  EXPORT_SYMBOL(proc_doulongvec_ms_jiffies_minmax);

Good catch, but the commit wording is off. Please change to something
like

  Add the range check back to do_proc_ulong_conv_ms_jiffies that commit
  b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with
  do_proc_vec") incorrectlry removed. Append "_minmax" to the end of the
  do_proc_ulong_conv_ms_jiffies so it is clear that there should be a
  range check.

  Fixes: b96b5c6708ea ("sysctl: Replace do_proc_do{int,ulong,uint}vec with =
do_proc_vec")
  Signed...




> =20
> --=20
> 2.55.0.1003.g10538fe699-goog
>=20

--kkhksf36vhfbiaq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqf/GoACgkQupfNUreW
QU8nNAv/T6Hdqt1YA9zIKTB3jMiYix1ME/Y5ZYfFuSXrq45rfqWyR8x0zks9o8sb
+BhE3Q8yHKciTAjpSsJcfCXdJeL0q2kZTqi+F9XS0yiVXJshW3h88dyGMZOqxxwd
kV8xUL8vlFtiMQLHroDpUPkTh8bDuSWxsiX2RKPSjy+C10MOyg5Po6ka4w6E7XDs
hzEYoiLYibXTw+xBIVu50FPp7bxHcoohSUpT+ghavkZW31uil+IF7d8DC+wW/7dP
d/ln9amfbvZG8xtTjoid9cHr3EAPcgxQlDIpLuAB7cfkXfiETLGlj/8cSREUt+iI
BAMwKzVs1ih7nLCm5hVcYffM46ShT/zJy+JMlnCpZmEdHfK0MPKT5IjhcRudVY97
OpJhrEnG9YEoc83ifBeoWI8y3EuPDiCnsFz8TmmErjM44s9MOAsQ8D4/FR8cKDzj
ZiB7vcGgU9Hazq5TqsJTuec+1Q+vUGAMhFUIbW97Pl2XKkct5cj3P+rXQmRAkHWS
jtue0cvl
=C0ih
-----END PGP SIGNATURE-----

--kkhksf36vhfbiaq7--
