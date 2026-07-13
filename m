Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E06A3B4EBD
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 08:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783931651; cv=none; b=scOJyjVZlEnQ0FiDuAL6gd2kpBLjZEtJp2uubYS+S2PW29w9ASb6Z7BMaNBOYJiKUZXWrTsUCqhzwka3R3Y7QaO9UkmZx9i2ZfzLqu/ljKHOi/JoNUmgtDkJvahgP5bLUv6uB8+TAb0T8NhtpP/E7bYpnlaUP7XoHMclfh2BFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783931651; c=relaxed/simple;
	bh=d28CZ1cVkrsXI7imQzUBV8AEfjnOtwP+Q2RNsv9YthY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NzR52g+rl6XsJTKt3HWTz0Htd2rfCmVX5jJue/vRjUVXG/ftp8E0HP9bL/a6c2rgiFYrGgYdxKbBLgEOKK5m+vP/Yb66UScnuasZWfhBHa9iA/3KP/TFhaFuB4ovRqo4+9eQ9tAsZGOywcR52q39e/7roD9+a2Y8rDUmG2562bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=I5+PyxN8; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="I5+PyxN8"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gzG1j24yKz8v1b;
	Mon, 13 Jul 2026 10:34:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1783931641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dQrejtZL2XpWthMXrLnlYMslhFK2mQqBx561esiUod8=;
	b=I5+PyxN82JKgfclxtg+PPrrj2ER91pazH2ZU9kS9r+WEgvik+Ave6jv/pXQYE5Ah8ERFvr
	1pJZCGAYc+jh/3NtWzZk3Vq6NWTDc1Nt7e86bXaBg4GgYN35HYQTgPfKEGIzDpYKWHeOb7
	3APQ1MqxrB4IA/j6A2S6mxyegvBO/J7q/vZSgi9aGG3AX/HA5icZqYx+UbnljeChhjP68J
	XB4Roo7iGoXc6i0txuBdTXMajeriKpAtJTpWySw6io6rjbiFEufNXk4iLOFQ+SufIZRItl
	eamh5OWddIbwoCuevomiiJ8twimwLTsN/F9oPPosbHmIrnUIEiHML+CCgn0ocA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Mon, 13 Jul 2026 18:33:51 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
Message-ID: <2026-07-13-chief-single-carnival-graders-7dI4ue@cyphar.com>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
 <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
 <871pd748kh.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7kt63rygclyrr7ul"
Content-Disposition: inline
In-Reply-To: <871pd748kh.fsf@redhat.com>
X-Rspamd-Queue-Id: 4gzG1j24yKz8v1b


--7kt63rygclyrr7ul
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
MIME-Version: 1.0

On 2026-07-13, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 3040d4cf9b85..7818872ab1e5 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,7 +386,6 @@ static void erofs_default_options(struct erofs_sb_inf=
o *sbi)
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> -	Opt_source_fd,
>  };
> =20
>  static const struct constant_table erofs_param_cache_strategy[] =3D {
> @@ -414,7 +413,6 @@ static const struct fs_parameter_spec erofs_fs_parame=
ters[] =3D {
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>  	fsparam_flag("inode_share",	Opt_inode_share),
> -	fsparam_fd("source",		Opt_source_fd),
>  	{}
>  };
> =20
> @@ -447,6 +445,14 @@ static int erofs_fc_parse_param(struct fs_context *f=
c,
>  	struct erofs_device_info *dif;
>  	int opt, ret;
> =20
> +	if (strcmp(param->key, "source") =3D=3D 0 &&
> +	    param->type =3D=3D fs_value_is_file) {
> +		if (sbi->dif0.file || fc->source)
> +			return -EINVAL;
> +		sbi->dif0.file =3D get_file(param->file);
> +		return 0;
> +	}
> +
>  	opt =3D fs_parse(fc, erofs_fs_parameters, param, &result);
>  	if (opt < 0)
>  		return opt;

Shortcutting parsing this way is not really idiomatic, the better way is
to create a helper -- in this case you can almost certainly just use
very similar logic to proc_parse_pidns_param() to get something minimal
working.

Defining your own version of "source" in fs_parameter_spec is fine, you
just need to make sure you handle FSCONFIG_SET_STRING properly -- there
are some other examples in the tree you can look at for inspiration
(mostly remote filesystems AFAICS). You could even return -ENOPARAM to
fallback to the basic implementation if that makes it easier for you,
but it would probably be better to handle it all in one place.

> @@ -526,11 +532,6 @@ static int erofs_fc_parse_param(struct fs_context *f=
c,
>  		else
>  			set_opt(&sbi->opt, INODE_SHARE);
>  		break;
> -	case Opt_source_fd:
> -		if (sbi->dif0.file)
> -			return -EINVAL;
> -		sbi->dif0.file =3D get_file(param->file);
> -		break;
>  	}
>  	return 0;
>  }
> @@ -779,6 +780,18 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>  			return PTR_ERR(file);
>  		sbi->dif0.file =3D file;
>  	}
> +	if (!fc->source) {
> +		char *buf, *p;
> +
> +		buf =3D kmalloc(PATH_MAX, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +		p =3D file_path(file, buf, PATH_MAX);
> +		fc->source =3D kstrdup(IS_ERR(p) ? "(fd)" : p, GFP_KERNEL);
> +		kfree(buf);
> +		if (!fc->source)
> +			return -ENOMEM;
> +	}

And this would also live in the parser helper.

--=20
Aleksa Sarai
Founding Engineer at Amutable
https://www.cyphar.com/

--7kt63rygclyrr7ul
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCalSi7xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG+vhwEAiFSYqF08CeLLtVUDLjNb
ncp6rg3QO5mNJp22FzyGYZ8BAL6raaBMvcPxESgSSj//uSKMGbjXxYxTzGzFXiwe
56UG
=Qlfm
-----END PGP SIGNATURE-----

--7kt63rygclyrr7ul--
