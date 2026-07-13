Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C613C25F994
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 04:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783918366; cv=none; b=CnBg4/f1viMayX4wJdK1hr45UaxV0rOv0xE4301Xe2px+6pio62fIF/C+IeWRwvN/6UzQ5uQWmloi2SP2GuOP9Tzuj4PvAY0KzvJpKYBjIBreNFtOFddRWwx55bsD7UyO65LSXY83baK+wV+VQSBscxNWncIFX3ekiZs6yIWkt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783918366; c=relaxed/simple;
	bh=IOgfjZegQOovX+MEqtFt6qN3I+rBtCjnuGoA1K2aUGY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcorvkJ7u1bEd9a/xs941pXismst1rV45TD1/b+ItioXCXNXs1F67phm6u8ztHKA9evfQMdn7KK67rZc0o1sxTwxLt70DxwAF293vnoBvxF5394mLzvvk3wC4F7V64HpiURy+k0tSe0HKUdY52qFrJLg1h3JIF35xgeTN5Usr2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=TrJbaXEA; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="TrJbaXEA"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gz96B3CjVzKv3V;
	Mon, 13 Jul 2026 06:52:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1783918354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YCQJ8K3hqH0LIhTBV9jc6pRjrXoDZJgmWS96ChvNcrs=;
	b=TrJbaXEApjznMLFa/3Q4wCMc8SRRK4tuqittd45MZhd4gKkiMhyQsbbcGGSyOlGuUVAEd0
	1FZM3tdbKwbSc39jb4uDHACoHVPJlzrEBL8mvr/7CLzzl5RAyHEuAH82pcDD/iz5LlZ/P5
	NaVJ3/X7n+alcXeWlI3SP8uKf2Z72uxd5ZOSwpd4l/5LfzO9SMXjVWLv8ElV/zyHhk53jS
	Zo5jdeVY/4AGTBofrCPMSKrHfgCDNVfyJ4zZKzzXpo+g143TJ/b2CPUR29x/We090YW4pw
	J7MRBO9MBLSjiNP38INhnUB1hPAc3SP60wCsgQXD5zCy7AEf6grpdx2rGaKYkg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of cyphar@cyphar.com designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=cyphar@cyphar.com
Date: Mon, 13 Jul 2026 14:52:25 +1000
From: Aleksa Sarai <cyphar@cyphar.com>
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
Message-ID: <2026-07-13-dandy-better-exposure-wager-9hBmfv@cyphar.com>
References: <20260711071137.4130824-1-gscrivan@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="i5hxj75u4eskqb5k"
Content-Disposition: inline
In-Reply-To: <20260711071137.4130824-1-gscrivan@redhat.com>
X-Rspamd-Queue-Id: 4gz96B3CjVzKv3V


--i5hxj75u4eskqb5k
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] erofs: accept source file descriptor via fsconfig
MIME-Version: 1.0

On 2026-07-11, Giuseppe Scrivano <gscrivan@redhat.com> wrote:
> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
> index 86fa5c6a0c70..3040d4cf9b85 100644
> --- a/fs/erofs/super.c
> +++ b/fs/erofs/super.c
> @@ -386,6 +386,7 @@ static void erofs_default_options(struct erofs_sb_inf=
o *sbi)
>  enum {
>  	Opt_user_xattr, Opt_acl, Opt_cache_strategy, Opt_dax, Opt_dax_enum,
>  	Opt_device, Opt_domain_id, Opt_directio, Opt_fsoffset, Opt_inode_share,
> +	Opt_source_fd,
>  };
> =20
>  static const struct constant_table erofs_param_cache_strategy[] =3D {
> @@ -413,6 +414,7 @@ static const struct fs_parameter_spec erofs_fs_parame=
ters[] =3D {
>  	fsparam_flag_no("directio",	Opt_directio),
>  	fsparam_u64("fsoffset",		Opt_fsoffset),
>  	fsparam_flag("inode_share",	Opt_inode_share),
> +	fsparam_fd("source",		Opt_source_fd),
>  	{}
>  };
> =20
> @@ -524,6 +526,11 @@ static int erofs_fc_parse_param(struct fs_context *f=
c,
>  		else
>  			set_opt(&sbi->opt, INODE_SHARE);
>  		break;
> +	case Opt_source_fd:
> +		if (sbi->dif0.file)
> +			return -EINVAL;
> +		sbi->dif0.file =3D get_file(param->file);
> +		break;

I don't think this handling is right for a few reasons:

 1. AFAICS this shadows the default "source" handling logic (because
    -ENOPARAM is not returned for the non-fd case), which means that
    this regresses existing erofs users -- everyone already uses
    "source" today. I must really be missing something if this worked
    when you tested it.

    Additionally, fsparam_fd unfortunately permits strings (where the
    string is the numerical value of the fd number), meaning that this
    will call get_file(<garbage>) if someone uses FSCONFIG_SET_STRING.
    You will need to check param->type at least to avoid that.

    I meant to send a patch for this earlier this year, but a nicer
    solution would be to have a custom helper similar to fs_lookup_param
    except that it permits FSCONFIG_SET_FD, FSCONFIG_SET_PATH,
    FSCONFIG_SET_PATH_EMPTY, and FSCONFIG_SET_STRING. This is sorely
    missing and people keep accidentally creating unusable interfaces as
    a result. I mentioned this in an LPC talk last year[1].

    proc_parse_pidns_param was my minimal version that only accepts
    FSCONFIG_SET_FD and FSCONFIG_SET_STRING, and if you don't want to
    add dirfd support yet then you should use something more like that.

 2. On a slightly less critical note, fc->source has special handling in
    the VFS in a few places and AFAICS this is the first example of
    someone adding an implementation of "source" that does not set
    fc->source to a proper value, which deserves some additional review.

    (At at quick glance it seems this just means that some stuff in
    procfs will show as "none" rather than fc->source debugging, but
    again it probably needs a closer look.)

[1]: https://youtu.be/NX5IzF6JXp0?t=3D72

--=20
Aleksa Sarai
Founding Engineer at Amutable
https://www.cyphar.com/

--i5hxj75u4eskqb5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQS2TklVsp+j1GPyqQYol/rSt+lEbwUCalRvAxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQKJf60rfpRG/kcQD+JC77qxpl/QwTgLzwoybn
nUi8Dq8fugnJpjdZLISEE+kBAN5kXLqQnmfO5oLeayumLCq0aLCpRkIXfGRSTgDP
76wF
=njuw
-----END PGP SIGNATURE-----

--i5hxj75u4eskqb5k--
