Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CE83AE1A9;
	Thu, 18 Jun 2026 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781765857; cv=none; b=RtrRl+zMYZmuhkf96Qa0S+CzBk8oPw5nSN8GjWPhBMCSBKb2lA69ALqNOVK5ikg0HSDHkvcUEuWODuYJ8f4h0AxTssHzMnrnq+Sb2OVdE3aQIizaKi6uKJQUcwS9LObNJXjGVy85DhGaEKbKyqXFzLRJ2mivQ9J1Xsn8KAZ+F5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781765857; c=relaxed/simple;
	bh=T95rqFu+DT+TUdfBv/DWbmWSVHBMh/4YtoIs2609LJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiWGTkxMIe78Mg6hYUnuNL61nyL6RLqtmZdQ0XIyZsbVchHzCzSGjYj3GEmkB0iqrjycy6UVbAX9zwg264PkoZgxnSe29Hk4fh8w4teT/5ZOikAt4VZH1ekLdsZh7YyXrPlePXqeeBw1KYxkj4LbTIt12stXoSqipY6MTrv+ZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eGh6OfDd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eGh6OfDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15E121F000E9;
	Thu, 18 Jun 2026 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781765855;
	bh=4QISqTlwrmx57R2z3haZedBPlmiB7VEKsHOvy4BFwTE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eGh6OfDdeAXOLgF2Ac3D3Tq0vZRc+WPlfEIDqNHivYmPvMdBGAvlLqV/xZjwUnKpK
	 1nGggmBZGvz44BbIP/4ngFFJesmirFSbdbNCZqe17A8Eyv8c+Jzpt0RunGwzC7jg8a
	 pjjQhZ47uhwuGe7tWUymAM4zVtFU8ZFfZImT7gKRbFE3v0CcHFpAadSgbhSSchQYZd
	 +dgzLzwZPqk/szVdVFpVgdoz2QL6dv96YznoguTElL0ng+3Y2AT8Jg7nSj7HAiZpw4
	 dYIpyah1F1myZyZr/MtmIOEgvzvpmLZiAtJv9OBrRSwTU/a7lJPO2VbOB4ZVEba2I4
	 XJTGMXAp4xd7A==
Date: Thu, 18 Jun 2026 08:56:39 +0200
From: Joel Granados <joel.granados@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] sysctl: add Returns: kernel-doc for all functions
Message-ID: <nsc2ufwzf2jfw67jm2qwyqt3qnrfl52z32kvnmbetvzpmswxk6@wxgh3cmbfqqc>
References: <20260509055658.1089994-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mf3cidjwsxjd64hu"
Content-Disposition: inline
In-Reply-To: <20260509055658.1089994-1-rdunlap@infradead.org>


--mf3cidjwsxjd64hu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 10:56:58PM -0700, Randy Dunlap wrote:
> Fix kernel-doc warnings in kernel/sysctl.c by adding Returns:
> clauses for them.
The commit message reads funny. I just removed the "clauses for them".

Added this to sysctl-testing

thx.

>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Joel Granados <joel.granados@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: linux-fsdevel@vger.kernel.org
>=20
>  kernel/sysctl.c |   45 +++++++++++++++++++++++++--------------------
>  1 file changed, 25 insertions(+), 20 deletions(-)
>=20
> --- linux-next-20260508.orig/kernel/sysctl.c
> +++ linux-next-20260508/kernel/sysctl.c
> @@ -148,7 +148,7 @@ static void warn_sysctl_write(const stru
>   * @ppos: file position
>   * @table: the sysctl table
>   *
> - * Returns true if the first position is non-zero and the sysctl_writes_=
strict
> + * Returns: true if the first position is non-zero and the sysctl_writes=
_strict
>   * mode indicates this is not allowed for numeric input types. String pr=
oc
>   * handlers can ignore the return value.
>   */
> @@ -184,7 +184,7 @@ static bool proc_first_pos_non_zero_igno
>   * and a newline '\n' is added. It is truncated if the buffer is
>   * not large enough.
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_dostring(const struct ctl_table *table, int dir,
>  		  void *buffer, size_t *lenp, loff_t *ppos)
> @@ -225,11 +225,14 @@ static void proc_skip_char(char **buf, s
>   * @base: the base to use
>   * @res: where the parsed integer will be stored
>   *
> - * In case of success 0 is returned and @res will contain the parsed int=
eger,
> - * @endp will hold any trailing characters.
>   * This function will fail the parse on overflow. If there wasn't an ove=
rflow
>   * the function will defer the decision what characters count as invalid=
 to the
>   * caller.
> + *
> + * Returns:
> + * * %0 on success and @res will contain the parsed integer,
> + *   @endp will hold any trailing characters.
> + * * %-ERANGE on overflow.
>   */
>  static int strtoul_lenient(const char *cp, char **endp, unsigned int bas=
e,
>  			   unsigned long *res)
> @@ -263,10 +266,12 @@ static int strtoul_lenient(const char *c
>   * @perm_tr_len: size of the perm_tr vector
>   * @tr: pointer to store the trailer character
>   *
> - * In case of success %0 is returned and @buf and @size are updated with
> - * the amount of bytes read. If @tr is non-NULL and a trailing
> - * character exists (size is non-zero after returning from this
> - * function), @tr is updated with the trailing character.
> + * Returns:
> + * * %0 on success and @buf and @size are updated with
> + *   the amount of bytes read. If @tr is non-NULL and a trailing
> + *   character exists (size is non-zero after returning from this
> + *   function), @tr is updated with the trailing character.
> + * * %-EINVAL on failure.
>   */
>  static int proc_get_long(char **buf, size_t *size,
>  			  unsigned long *val, bool *neg,
> @@ -365,7 +370,7 @@ static void proc_put_char(void **buf, si
>   * not NULL. Check that the values are less than UINT_MAX to avoid
>   * having to support wrap around from userspace.
>   *
> - * returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_uint_u2k_conv_uop(const ulong *u_ptr, uint *k_ptr,
>  			   ulong (*u_ptr_op)(const ulong))
> @@ -386,7 +391,7 @@ int proc_uint_u2k_conv_uop(const ulong *
>   *
>   * Uses READ_ONCE to assign value to u_ptr.
>   *
> - * returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_uint_k2u_conv(ulong *u_ptr, const uint *k_ptr)
>  {
> @@ -409,7 +414,7 @@ int proc_uint_k2u_conv(ulong *u_ptr, con
>   * When direction is kernel to user, then the u_ptr is modified.
>   * When direction is user to kernel, then the k_ptr is modified.
>   *
> - * Returns 0 on success
> + * Returns: %0 on success
>   */
>  int proc_uint_conv(ulong *u_ptr, uint *k_ptr, int dir,
>  		   const struct ctl_table *tbl, bool k_ptr_range_check,
> @@ -774,7 +779,7 @@ static int do_proc_douintvec(const struc
>   * values from/to the user buffer, treated as an ASCII string. Negative
>   * strings are not allowed.
>   *
> - * Returns 0 on success
> + * Returns: %0 on success
>   */
>  int proc_douintvec_conv(const struct ctl_table *table, int dir, void *bu=
ffer,
>  			size_t *lenp, loff_t *ppos,
> @@ -798,7 +803,7 @@ int proc_douintvec_conv(const struct ctl
>   * table->data must point to a bool variable and table->maxlen must
>   * be sizeof(bool).
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_dobool(const struct ctl_table *table, int dir, void *buffer,
>  		size_t *lenp, loff_t *ppos)
> @@ -835,7 +840,7 @@ int proc_dobool(const struct ctl_table *
>   * Reads/writes up to table->maxlen/sizeof(unsigned int) integer
>   * values from/to the user buffer, treated as an ASCII string.
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_dointvec(const struct ctl_table *table, int dir, void *buffer,
>  		  size_t *lenp, loff_t *ppos)
> @@ -854,7 +859,7 @@ int proc_dointvec(const struct ctl_table
>   * Reads/writes up to table->maxlen/sizeof(unsigned int) unsigned integer
>   * values from/to the user buffer, treated as an ASCII string.
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_douintvec(const struct ctl_table *table, int dir, void *buffer,
>  		size_t *lenp, loff_t *ppos)
> @@ -877,7 +882,7 @@ int proc_douintvec(const struct ctl_tabl
>   * This routine will ensure the values are within the range specified by
>   * table->extra1 (min) and table->extra2 (max).
>   *
> - * Returns 0 on success or -EINVAL when the range check fails and
> + * Returns: %0 on success or -EINVAL when the range check fails and
>   * SYSCTL_USER_TO_KERN(dir) =3D=3D true
>   */
>  int proc_dointvec_minmax(const struct ctl_table *table, int dir,
> @@ -904,7 +909,7 @@ int proc_dointvec_minmax(const struct ct
>   * (max). And Check that the values are less than UINT_MAX to avoid havi=
ng to
>   * support wrap around uses from userspace.
>   *
> - * Returns 0 on success or -ERANGE when range check failes and
> + * Returns: %0 on success or -ERANGE when range check failes and
>   * SYSCTL_USER_TO_KERN(dir) =3D=3D true
>   */
>  int proc_douintvec_minmax(const struct ctl_table *table, int dir,
> @@ -929,7 +934,7 @@ int proc_douintvec_minmax(const struct c
>   * This routine will ensure the values are within the range specified by
>   * table->extra1 (min) and table->extra2 (max).
>   *
> - * Returns 0 on success or an error on SYSCTL_USER_TO_KERN(dir) =3D=3D t=
rue
> + * Returns: %0 on success or an error on SYSCTL_USER_TO_KERN(dir) =3D=3D=
 true
>   * and the range check fails.
>   */
>  int proc_dou8vec_minmax(const struct ctl_table *table, int dir,
> @@ -1061,7 +1066,7 @@ int proc_doulongvec_minmax_conv(const st
>   * This routine will ensure the values are within the range specified by
>   * table->extra1 (min) and table->extra2 (max).
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_doulongvec_minmax(const struct ctl_table *table, int dir,
>  			   void *buffer, size_t *lenp, loff_t *ppos)
> @@ -1108,7 +1113,7 @@ int proc_dointvec_conv(const struct ctl_
>   * large bitmaps may be represented in a compact manner. Writing into
>   * the file will clear the bitmap then update it with the given input.
>   *
> - * Returns 0 on success.
> + * Returns: %0 on success.
>   */
>  int proc_do_large_bitmap(const struct ctl_table *table, int dir,
>  			 void *buffer, size_t *lenp, loff_t *ppos)

--=20

Joel Granados

--mf3cidjwsxjd64hu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEErkcJVyXmMSXOyyeQupfNUreWQU8FAmozlp0ACgkQupfNUreW
QU/m/gv8DM0OSuxmMew1L5yewnnzjHJ6nzERKGFLTB/nncVkIkYdXHBPDJ2PHUVx
9NuaRLBESC95hhCtgSzE7uWraoPVZPgM1Ud01LmWM0Ghc2juVxen4joGRFUhPBN4
TdGLuUfimYdb9NUsAVQH/FDxi4veTsoMB8jFvahsYxfnufibBCHoS5nYF7KFMB56
3UCJpbyab8v5jnWdPIEa98fut3Lz4GH8MiEBGo1SxMb8JWv3har9ObbJzD8Hdv76
nIIFRVW+unm/NXrMRDJD8Kp3nMXzN6rnWVhq0u5lemjPQT9LfDMZo2qjU/NgtJRk
K7ChO+E3R8TbOmDg0OL5J8g/zG8h8xRXuVYlabLAPXoB+WSD8dJW1A8WYoUN6gg3
NbfmKkoHbnszDNghcIj42RQnOv74ebMtOcMSUpJwZjPGgcVTdG5cXktIC6s774Xt
ETUCpWZa7FNxiCKO6H2sRISnzjdSKn8jlWAJt/+VN4+yEsneUufpezeJZDx8Hd32
AJPaHI8o
=GQbT
-----END PGP SIGNATURE-----

--mf3cidjwsxjd64hu--
