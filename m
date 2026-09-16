Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E6A4D09E0;
	Wed, 16 Sep 2026 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789559564; cv=none; b=IfdD5+bYuj8Gu+/hsjzKOrUPxC5cKF4f2SvPRndFPX7XihknOZpLUVySAiZR/LHOSfafmkdbS6c3j7xpRxwfoWMnre9UlgltRRi7IElr6D9vDD4YJehLOK8LSjdR6cEazWSqbeMSmRvbeJCLInlUClXql82Km2YPa5pKHZeLC4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789559564; c=relaxed/simple;
	bh=xAwNp8PjbXoLFaCa2Mn2IYQOxtVDUm0M9shdOQ6Hn9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YZEy4i05Fh+2j1wQNn5foFXUrvrNx3ljrSj31l8FwGdQ5Owp1o8tbN0CjnBcSj4nAoFV/AdeNnupkgLEshRr6cxQOK8NSahW/dkGkP6EONV83jI9Vkqf+jA2yw/G4MAt0Us7t3cmvQtnNqo9fkeVypAxIGrwIlOyChwCZt8LoAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtV4UnVa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtV4UnVa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955911F000FF;
	Wed, 16 Sep 2026 11:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789559550;
	bh=Vzrt3qIu8htngP8L6pa7ISBaAmwNdL2PIvmwNtw4WRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gtV4UnVaObhYP1DzPxoQ41GvxTAdyYfj108NOlJ/uVsrOH42758RCke3VRxaTgIA/
	 tTCRCKy4tnMhnhVJj1RaR9MMqhRzVCjEZge1YuxB3Swe4VAkbOXlkxmy5UAqcelPg5
	 QIRzrJUwpXtn3Kp0u21UTCfNOhed/aZH0zXx5bhDMfBVEcI6z7CjlLb4KjBrE51Rr0
	 Xitt15hlNP5QP4GSFvIF2AkRCsirqD0QtNLT2rBZ7xHtGpVQDshzfJElkckjrF1akv
	 4nl8ZYSVyx+iYP5SeRCdah38HYSjhLhj9Ty8/N++kdYQmFN6+AlFoI7GIlDuWYXSib
	 RMAbusE2lTsNg==
Date: Wed, 16 Sep 2026 13:52:25 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Bradley Morgan <include@grrlz.net>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: Use replace **void with **char in proc_put_*
Message-ID: <fxrwmefwe6fciz5szyn5hr2ucxq2vspahrgcdzuv3nt6v4ifxz@pmqrjxnvagow>
References: <20260916-lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="psh5yc6hlbgix2jo"
Content-Disposition: inline
In-Reply-To: <20260916-lklm-sysctl-void-vs-char-v1-1-c3f8b2eb8b1e@kernel.org>


--psh5yc6hlbgix2jo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 01:44:28PM +0200, Joel Granados wrote:
> Replace **void argument with **char in the proc_put_* functions. These
> are leftovers from before commit 32927393dc1c ("sysctl: pass kernel
> pointers to ->proc_handler") where a cast to char __user** from void
> _user** was needed before the put_user call.
>=20
> Suggested-by: Bradley Morgan <include@grrlz.net>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>
> ---
>  kernel/sysctl.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>=20
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 25577ffc2801267cc69df60a1064ada9efd4b97d..1fefe18bf84e790433a1abf71=
a4b158f3c1f729f 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -332,7 +332,7 @@ static int proc_get_long(char **buf, size_t *size,
>   * In case of success @buf and @size are updated with the amount of bytes
>   * written.
>   */
> -static void proc_put_long(void **buf, size_t *size, unsigned long val, b=
ool neg)
> +static void proc_put_long(char **buf, size_t *size, unsigned long val, b=
ool neg)
>  {
>  	int len;
>  	char tmp[TMPBUFLEN], *p =3D tmp;
> @@ -347,15 +347,12 @@ static void proc_put_long(void **buf, size_t *size,=
 unsigned long val, bool neg)
>  }
>  #undef TMPBUFLEN
> =20
> -static void proc_put_char(void **buf, size_t *size, char c)
> +static void proc_put_char(char **buf, size_t *size, char c)
>  {
>  	if (*size) {
> -		char **buffer =3D (char **)buf;
> -		**buffer =3D c;
> -
> +		**buf =3D c;
>  		(*size)--;
> -		(*buffer)++;
> -		*buf =3D *buffer;
> +		(*buf)++;
>  	}
>  }
> =20
> @@ -680,12 +677,12 @@ static int apply_conv_on_vec(const union proc_vec_c=
onv conv,
>  			     const struct ctl_table *table,
>  			     const enum proc_vec_type data_type,
>  			     const size_t data_size, const int conv_dir,
> -			     const size_t buf_nbyte, void *buf,
> +			     const size_t buf_nbyte, char *buf,
>  			     size_t *buf_left_final)
>  {
>  	int vec_left, err =3D 0;
>  	size_t buf_left, nr_conv =3D 0;
> -	char *data, *data_stage =3D NULL, *p;
> +	char *data, *data_stage =3D NULL;
>  	bool is_unsigned =3D data_type =3D=3D PROC_VEC_UINT || data_type =3D=3D=
 PROC_VEC_ULONG;
> =20
>  	buf_left =3D buf_nbyte;
> @@ -694,7 +691,6 @@ static int apply_conv_on_vec(const union proc_vec_con=
v conv,
>  	if (SYSCTL_USER_TO_KERN(conv_dir)) {
>  		if (buf_left > PAGE_SIZE - 1)
>  			buf_left =3D PAGE_SIZE - 1;
> -		p =3D buf;
> =20
>  		if (table->maxlen > data_size) {
>  			data_stage =3D kmemdup(table->data, table->maxlen, GFP_KERNEL);
> @@ -712,11 +708,11 @@ static int apply_conv_on_vec(const union proc_vec_c=
onv conv,
>  		bool neg =3D false;
> =20
>  		if (SYSCTL_USER_TO_KERN(conv_dir)) {
> -			proc_skip_spaces(&p, &buf_left);
> +			proc_skip_spaces(&buf, &buf_left);
> =20
>  			if (!buf_left)
>  				break;
> -			err =3D proc_get_long(&p, &buf_left, &lval, &neg,
> +			err =3D proc_get_long(&buf, &buf_left, &lval, &neg,
>  					    proc_wspace_sep,
>  					    sizeof(proc_wspace_sep), NULL);
>  			if (!err && neg && is_unsigned)
> @@ -740,7 +736,7 @@ static int apply_conv_on_vec(const union proc_vec_con=
v conv,
> =20
>  	if (SYSCTL_USER_TO_KERN(conv_dir)) {
>  		if (!err && buf_left)
> -			proc_skip_spaces(&p, &buf_left);
> +			proc_skip_spaces(&buf, &buf_left);
>  		if (!nr_conv) {
>  			err =3D err ? : -EINVAL;
>  			goto out;
> @@ -1221,6 +1217,7 @@ int proc_do_large_bitmap(const struct ctl_table *ta=
ble, int dir,
>  	unsigned long *bitmap =3D *(unsigned long **) table->data;
>  	unsigned long *tmp_bitmap =3D NULL;
>  	char tr_a[] =3D { '-', ',', '\n' }, tr_b[] =3D { ',', '\n', 0 }, c =3D =
0;
> +	char *p =3D buffer;
> =20
>  	if (!bitmap || !bitmap_len || !left || (*ppos && SYSCTL_KERN_TO_USER(di=
r))) {
>  		*lenp =3D 0;
> @@ -1228,7 +1225,6 @@ int proc_do_large_bitmap(const struct ctl_table *ta=
ble, int dir,
>  	}
> =20
>  	if (SYSCTL_USER_TO_KERN(dir)) {
> -		char *p =3D buffer;
>  		size_t skipped =3D 0;
> =20
>  		if (left > PAGE_SIZE - 1) {
> @@ -1315,16 +1311,16 @@ int proc_do_large_bitmap(const struct ctl_table *=
table, int dir,
>  						   bit_a + 1) - 1;
> =20
>  			if (!first)
> -				proc_put_char(&buffer, &left, ',');
> -			proc_put_long(&buffer, &left, bit_a, false);
> +				proc_put_char(&p, &left, ',');
> +			proc_put_long(&p, &left, bit_a, false);
>  			if (bit_a !=3D bit_b) {
> -				proc_put_char(&buffer, &left, '-');
> -				proc_put_long(&buffer, &left, bit_b, false);
> +				proc_put_char(&p, &left, '-');
> +				proc_put_long(&p, &left, bit_b, false);
>  			}
> =20
>  			first =3D 0; bit_b++;
>  		}
> -		proc_put_char(&buffer, &left, '\n');
> +		proc_put_char(&p, &left, '\n');
>  	}
> =20
>  	if (!err) {
>=20
> ---
> base-commit: 99156fbf3562bed74aa57d93b0b3eeec7c7f1ca6
Forgot to mention that this sits on top of the partial_ctlvec changes
which are included in next-20260915.

> change-id: 20260916-lklm-sysctl-void-vs-char-40a0aab31c3e
>=20
> Best regards,
> --=20
> Joel Granados <joel.granados@kernel.org>
>=20
>=20

--psh5yc6hlbgix2jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmqqgvAACgkQupfNUreW
QU+mVgv/T/ABIDC/HvfIYc1feG/R1nrevUewjIUzy58CcXK8vczJYx+5+H0Bv4Q1
F1mEq69x2IWLYt7gbB1fn+lyY2LMtAVcExlmK/W1JoFkWsfgKZJxDQci+Kt9ffv6
XyM+tQvu65fqQi0qLvhCvZsomGsXLILLHu9y2TD3gPgpFjeBfkfKqXhEoZU4I2pH
zgFlEF3S4f33ObAtitfizYN5aIx3Rmfxwi4uOyZiRw86m6ho07N0QfecFm/yTVMc
gFr8gHrDA1oH775iT4pJajmjZ8kMZivMFz4Vk0gGoab+3gl9KL3N0sHu6c3OGjNx
Iw8wSFZjbuJFk5cSRulwWKcKPIN8WqMK8RARl+TiD6SksZ25JlNpnPR2n3gSeYLj
xQaLFO5JZr+g6sw3xyOjmCfdJKtX06EkUDqtVAsm8nLzkmBJ/jrqb5wFal729zkq
zytAQrGOP6PGWGuKOiki/i45BbroatOxaDIYPkfHW92hm/FRa34Cf2pZE/3lNyRD
5HlTdLwX
=Ay2R
-----END PGP SIGNATURE-----

--psh5yc6hlbgix2jo--
