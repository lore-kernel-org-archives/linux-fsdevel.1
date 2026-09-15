Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E224F50276;
	Tue, 15 Sep 2026 00:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430716; cv=none; b=OtO2KY8hbu1IVxkw5vtsLeE2+i5uU24iNrdB+n7IKPiom+OrkfPnz3/baySch2bPnll9IfxNq/z9MRB6j586oHh/mzaYkJFcATgDcJfP2atA6IircM5bgZoRwsMWD+LvQaTyMnsq5dTO1VzhSI4Kp+vmGkOnOOYHhV6LmNsAfGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430716; c=relaxed/simple;
	bh=eo8iGQnIiGtNeITwK82ExEFMQ8hXSCdb7DGM8Nu3t6I=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=lRCHrgR9vy5iRkemm+yx312zBVUfg84NFfHFhufz9oxCBloQPMCryJ8U6JHmRqxIx9qEenP5Wi2EjdFYTfL/fss1+HWC2gRXSw0hA0RfkHNUo+TD860h0iPbOcm31euXV080qkukZn1fHYHlsiOunqvG4Ydn3z2MY/p6yUvLqHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=adD9g1WS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/aSV/BW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="adD9g1WS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/aSV/BW"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADE817A0115;
	Mon, 14 Sep 2026 20:05:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 14 Sep 2026 20:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789430712; x=1789517112; bh=JO8L61O4LISXgUylL3Sm7o8Y2pcwMaYBHsR
	eQj1fV94=; b=adD9g1WSGS28i8ovrSmlR22whIhKzj+tCRQ6Qy04ZFz50NH+Odi
	9zacaNsdejs1gMLqLgHsf6h6zuxTDelbt8sgvG1XdF1/HhHNm8N1Nq1ZJtrQcA8x
	BS0N1eh0VJAJW/dRSfixbUvLTj01msiZdcvav5exFzsFZ20uw9GpeXCncPxIgQ/P
	LQvV8VcZcRuZCv4Y8jwCGw1xhdf5lokK1A2AwhzgOBzVzZGEX384l2eeiqiNEcdc
	ArYj4oWZHj9wgfoiQNfyfbWj5rOifirjvW0BFSDMdYIdUmUYAu2Jn9fHkKHZfjYd
	D6ItTe/628lhWmfyAlF4j64Eh/Zb2/IsZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789430712; x=
	1789517112; bh=JO8L61O4LISXgUylL3Sm7o8Y2pcwMaYBHsReQj1fV94=; b=I
	/aSV/BWMRA7/J/hgAQyssWrkvquJBjQ/rataOAiXdXLjRl0PUP8oIpQlhTgbzaKC
	ojMToduOYeLCqJ9ARlmNQnuVblbbGE4HzTknPxiMQ8mAR9gA4dK/CQIY2uRGQX5W
	6m0ut8ZZiGaom5HcF7vNBTo9LMjqF5Xg6O8SiWHPVZ0Q7mmJPR1mStOax+wuFqmM
	rwBNZbgR4PdY2rvBkDmo10UH8kgfa7wu+yVxUg0BZOlT4P31jaF5q3CgjRMdFbtk
	PJapZegQmOyFPVWt9I4Se320rfIzZ0XECeWuQi/APngZE3Gs5ERAFU4HwocvL06b
	UDFfqXfeYamTKkRdtCFuQ==
X-ME-Sender: <xms:uIuoalYk6RdcsVOY21tdh8MHnZCYvblV768aQI6LYi65kHGjU8Ml5A>
    <xme:uIuoaurA_7bP9bN-3QaQKHEdkH_9rz_Ba0-gvYiKBOCgovhYBWGL5gDTaFOtGaiXx
    NudfeTsh3fMJfAyyZJf_tI50_qElsDd81yni3q47s6dkAMjZOg>
X-ME-Received: <xmr:uIuoaqM7M2E33i-govzVgCKPIfdaTWsoSJ-ptaLtEJoPFOp_KkeopBVjbhTmbRdKLWcfi1p_JTA5-DdJurJalvKZKST7uuk>
X-ME-Proxy-Cause: dmFkZTFaIAySdnFie2WHmIl5Sh42ONZVnKLm4P4oC5TxTf/NCnT2x5uL61cGv3YD+E7Rxq
    hF6GbpC5xAxzcTf4IlrgCNucwg2642EcrrPGhCGPlIEWK0z3eSbZ+8tnYRUhw8o4F1FIJd
    mPm/3LdFcH2bLkoHJcW/6FJsWHwJf1iRvvSobfhfel2DGZgqex04YBCnZTFqJ83MIX2eYL
    qzx/NpiEBOoWZAVj32Q2EspqiMRGn01LrjFuA+j5UTAFw/gDxnTOwz+0gBYjt2ZvBbvkkS
    U/6kR9OxnBbi6rzaadJYnSAUhY8tuP3ZnGZosJf1GsBJphJRSKV01j7Dq4FmHmo1RdKeUf
    XnnEtEj5c79grxIEVjlKvUk+r8ZOWcG0fIN9v6IBRajIWA6RJq7vEzYyMTiMUhyUL3FJTH
    J5xybrEWTR3shHvrNSSBb3jP4feH22qdYU9aEZd7jY9HhMndvhAaJpYmcLvYa8lfpgeyQL
    33EJ/19jRhv2M9Axy5lUo0h2A1i+Ov+HcXEWmdw7tauVncV2fOU+T4EMmDXOQhtR/uFOMo
    RDptYwkMgu3A9qGv9tkDGbPlh4/08KUINvBkYoEWXaSK7Hma7f82NlwSi6PmxtCXbaNYwI
    eU5E0b1gtRzOj65wpzn90Nbkq/PWXtMLMF5dNzuJtp1y5/VOw4YJVuyGaTJw
X-ME-Proxy: <xmx:uIuoappEWE2pvd8KLC4bblRci1utmj806PiZJ8i0E1SrUSzyNhFx1A>
    <xmx:uIuoavdl5E0JWjUr5l8AEBr9f0MGIBsUU0LawS8_nh0Q5SkAZJVfvQ>
    <xmx:uIuoavSz3OEcZMnpqbAFlLI26GmO6rd3L_f-5Ei2UuuZyuEGclrQGg>
    <xmx:uIuoaoYycGUw6BivKshrZsHkPGvkexcncDn45llLJdy1Z6GFYpttpQ>
    <xmx:uIuoatwsRaALn7cAAlzrW1LlVXRZPmMBF4WqvtWXVUZYwfU9sAF7vGh1>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 20:05:10 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Mateusz Guzik" <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Mateusz Guzik" <mjguzik@gmail.com>
Subject: Re: [PATCH 02/10] fs: add path_create(), path_move() and path_clone()
In-reply-to: <20260913144918.1606123-3-mjguzik@gmail.com>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-3-mjguzik@gmail.com>
Date: Tue, 15 Sep 2026 10:05:06 +1000
Message-id: <178943070662.207413.9700024518083440241@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/namei.c           | 29 +++++++++++++++++++++++++++++
>  include/linux/path.h | 14 ++++++++++++--
>  2 files changed, 41 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index ca4f5e3be99a..c8754c7ba8be 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permission_may=
_exec(struct mnt_idmap *id
>  	return security_inode_permission(inode, mask);
>  }
> =20
> +/**
> + * path_create - WRITEME
> + * @path: path to get the reference to
> + * @mnt: WRITEME
> + * @dentry: WRITEME
> + *
> + * Create a path object using the given vfsmount and dentry pair while inc=
rementing
> + * the reference count on both.
> + */
> +void path_create(struct path *path, struct vfsmount *mnt, struct dentry *d=
entry)
> +{
> +	path->mnt =3D mntget(mnt);
> +	path->dentry =3D dget(dentry);
> +}
> +EXPORT_SYMBOL(path_create);
> +
> +/**
> + * path_clone - WRITEME
> + * @path: path to get the reference to
> + *
> + * Given a path increment the reference count to the dentry and the vfsmou=
nt.
> + */
> +void path_clone(const struct path *src, struct path *dst)
> +{
> +	dst->mnt =3D mntget(src->mnt);
> +	dst->dentry =3D dget(src->dentry);
> +}
> +EXPORT_SYMBOL(path_clone);
> +
>  /**
>   * path_get - get a reference to a path
>   * @path: path to get the reference to
> diff --git a/include/linux/path.h b/include/linux/path.h
> index 7ea389dc764b..8a621e0e1921 100644
> --- a/include/linux/path.h
> +++ b/include/linux/path.h
> @@ -10,8 +10,18 @@ struct path {
>  	struct dentry *dentry;
>  } __randomize_layout;
> =20
> -extern void path_get(const struct path *);
> -extern void path_put(const struct path *);
> +void path_create(struct path *, struct vfsmount *, struct dentry *);
> +void path_clone(const struct path *, struct path *);
> +void path_get(const struct path *);
> +void path_put(const struct path *);
> +
> +static inline void path_move(struct path *src, struct path *dst)

Oh ...  this is backwards.  At least is it backwards compared to
memmove().  I understand different people will read "move" differently
and would prefer to avoid it.
Can we do without it?  You only seem to use it in one place.

How would you feel about:

 struct path path_move_from(struct path *src)
 {
	struct path ret =3D *src;
	src->mnt =3D NULL;
	src->dentry =3D NULL;
	return ret;
 }

and then use

 file->__f_path =3D path_move_from(path);

??

NeilBrown


> +{
> +	dst->mnt =3D src->mnt;
> +	dst->dentry =3D src->dentry;
> +	src->mnt =3D NULL;
> +	src->dentry =3D NULL;
> +}
> =20
>  static inline int path_equal(const struct path *path1, const struct path *=
path2)
>  {
> --=20
> 2.53.0
>=20
>=20
>=20

