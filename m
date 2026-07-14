Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429E819E7F7
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 00:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783990198; cv=none; b=gIAZkfi+Avasp+iAIQQ1mt29ruYfCsvfs4WP45FnknNlEMCxMOSkyTS0S9oOnFHmplpJhxrHqZYn3kRbuAlMbfgOTb3xFb/nTbFD29+ZrIxlHVKJzq73CgYjUwEQHP6TzotMbiZefp2MrN0objOY3+wfG+5o7gkmekg/v0E3Ea8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783990198; c=relaxed/simple;
	bh=ChCuycwlWoUe3w1qa2aJ967YI2mQYfU/+Fu5klgdP9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtZwivmS3yzfNDSENxBMo6/D3RSSFi3s2PMEsleiFV7iucFouUYZ7YSYulH4egNoTju0MyhCxhcI9ehdfZen6Z/Jc0YKqhrRuq9Rx7g93qIcr6xEGT9A5yaznB1m4sCi8hkuxVT3cD8oKJH00wCREWyra4BBcm0JFK8BX1W6YPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=IGKrcvi8; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="IGKrcvi8"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gzggf1WJhzMlBb;
	Tue, 14 Jul 2026 02:49:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1783990190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pi+aB6YMCYhiJWt1pTb8a7/h/MvI2o3bfTPFrZ8+JGo=;
	b=IGKrcvi8eH0ST6ZUbo9P6C/vNbv8IDtvnryd9IJarNgZWvLIhwYT9opCPqND/YPvIvynlN
	HPg7GyryTaIgN1E/00FvtOywg5lzHW6C0hSjivQNLrxmnvQqhvYvlltYqkV41IgLYcDoZE
	89nOSpUTlTpzMbmXJBOPd7TYcvprJnYDDIrRTCTNI7iopz7qbjahdDgpxBsYrYsx0RTvvZ
	MXqLxi/rvA3kDXi6wnzPAYW0KML0jdtcK2TOrHmFoZ4xKiDBXG4NKGWNHcnUEUSe550vxi
	P6iNARi7dQmN1PgyDXNViT0a86PvGvIKPB9vHJn728k44+CAPa2VCrXYd1I1nA==
Date: Tue, 14 Jul 2026 10:49:40 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
Message-ID: <2026-07-14-drafty-folded-woes-volumes-Z93P4V@cyphar.com>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
 <871pd748kh.fsf@redhat.com>
 <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
 <87wluz2nnc.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aaxxywpo7g3ddiom"
Content-Disposition: inline
In-Reply-To: <87wluz2nnc.fsf@redhat.com>


--aaxxywpo7g3ddiom
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
MIME-Version: 1.0

On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> thanks for the hints.
>=20
> I'll prepare a v3 if you are fine with the version below:

No worries, and this seems more reasonable at a first glance.

> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..72c85cc53085 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
=2E..
> @@ -437,6 +439,38 @@ static bool erofs_fc_set_dax_mode(struct fs_context =
*fc, unsigned int mode)
>  	return false;
>  }
> =20
> +static int erofs_fc_parse_source(struct fs_context *fc,
> +				 struct fs_parameter *param)
> +{
> +	struct erofs_sb_info *sbi =3D fc->s_fs_info;
> +
> +	if (fc->source || sbi->dif0.file)
> +		return invalf(fc, "Multiple sources");
> +
> +	switch (param->type) {
> +	case fs_value_is_string:
> +		fc->source =3D param->string;
> +		param->string =3D NULL;
> +		return 0;
> +	case fs_value_is_file: {
> +		char *buf, *p;
> +
> +		sbi->dif0.file =3D get_file(param->file);

A very minor nit, but you can actually steal the file reference here
with

		sbi->dif0.file =3D no_free_ptr(param->file);

A few other places do this. (You'll also need to change the param->file
reference below.)

> +		buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +		p =3D file_path(param->file, buf, PATH_MAX);
> +		fc->source =3D kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);

I think that /proc/self/fd/%d would be a more useful name for debugging
if file_path() fails (not that it is really possible here AFAICS). But
I'm not really too fussed.

--=20
Aleksa Sarai
Founding Engineer at Amutable
https://www.cyphar.com/

--aaxxywpo7g3ddiom
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCalWHpBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG9cyAEA0mkCZe8zd2ugT6dnuZH7
QOJsOhGBEvEDsJWFGj/8K7oA/3pYpGWn5E8exPFb5/7UnaBOBC7QE6oul3Fi+q4W
044N
=6wik
-----END PGP SIGNATURE-----

--aaxxywpo7g3ddiom--
