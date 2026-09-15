Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CD14315F;
	Tue, 15 Sep 2026 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789431034; cv=none; b=d0mMuSzlDzaXiFJdmtGg5aVFrJTOoVMgvh6E3T1T5xln9inanRFvA1YkztMoG0+8JEi/SkvfcTI7LIAWjvbA/VCgVl+urFyx+hJPpjxEw2oN0KLrNQ6qbtXWoVBkIrPBX1Mkd6Dfl6QrovTuvdmyS5nTLaOV65hP7bpUIBl82MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789431034; c=relaxed/simple;
	bh=oHwqrZxYs4hCbu+BUVQVXlmJwOUiV1yWBH+O+ePNbrM=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=Kylos7p4QdqzhXoiYe2qVIqtdxURIlhq33o2YSck5Dfm9InyO3h6P17g13qK0TuO3Kme7D0xjQbw2hcTPOI49pmNp0Xnl86+eDBKzypKFu72c38FbsRbjjXE4VUJbmDaAe4kRdHa9t6ddIg3poZ96iSfv7Os3cLYPmYxKCOiSbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LBgbp6P2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OnUklduP; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LBgbp6P2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OnUklduP"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id A75701D0011F;
	Mon, 14 Sep 2026 20:10:31 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 14 Sep 2026 20:10:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789431031; x=1789517431; bh=K9WPKmG5eDark38n1P4B4BF/gYyB1q5uByK
	+D5Y71nw=; b=LBgbp6P20FaiaUZmoyF/o/fqvD+smGwfxWgkOu5oq+QY1/bsuf4
	ZaUvGtQlyrrhmwP4md+T2FEWVeY+WpfEUMKdvzKevVk2XCIMQJEtuIJeunF6qCcA
	2XwiJrwsHkAr8v7OnOuY2UkZw2+GoRaoXqOoQGtxc0PQHwySRrQUwD/5T8UieOYP
	dbYCY1VHDqJMwWsxvl6NiyY6Bs5p8b29LgKX8smgObK89aQiTgiS7v1Mgy8NjXOM
	O6Tln/MJTyYQlZ7oJqQnRyTN6YEvAW5f83t95m9X01VA2dNfVcy6IKLjyUsNGJ+L
	ohQ6pezvAdCsst5GuoSFQwUICXAE8QzfMqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789431031; x=
	1789517431; bh=K9WPKmG5eDark38n1P4B4BF/gYyB1q5uByK+D5Y71nw=; b=O
	nUklduPNj2v8NnW5PEm44B5W+wsDwR4gxbYjj69vopzmY382oJJcq+gp9YAegzA0
	VVuy2GjSwOXIjKettuYOkZkLhbYlutxc1HVhiKPm6shWB69NlH+yK05iHc6Sod5V
	sWavWYs/MQTQ6NfcZjE7aQdKsL+TwnrW2ddKUd/cpg+4w+oEEUGbAKvEeFeurlwC
	UPVSR/eI2nESc88HyP2IVCPExpKbOiZhVHZhLtyBscn+mjVZZL9v5foECH1UeZtd
	Jy8dn7FLA/uAmWSZPY51M1WpiSHknm0zcGq7+UXcoSLi6MrU6paCquX7W+F2jUcE
	QNSTZgIwfTmeyns6tmHlw==
X-ME-Sender: <xms:94yoaoyKCyJ4vuMNiSJU3T9HSmrO5tT5Jta_WSaTgeYcAXruLffCaA>
    <xme:94yoaujJQf3gpggUQw5Pxv9w5D9-L1RlIkeevVXMdaR_k5yM2acFlN-gwt-0Y4axb
    ycxjS9Yhc4qW9XcWCOHFga5yGg6TyqaGt-4VLdChtlUapCTbA>
X-ME-Received: <xmr:94yoaslDjS3Dq6900RPSHjyoILVRojAN5dupwm9WyKNOagYHPhTRf7lu2lHZbGX0QloDUavqEDOsAXeNP26vYt9kxwX-LzU>
X-ME-Proxy-Cause: dmFkZTFHP3SBaVgCadVUdEMPrnvXcy3TZzFBfr4DO6e0aM1IZ4mL4jv2BW0bX6etXRPIrO
    hiUpTq6G7cA2PuKluMBY2CmiD9Pp3mksl7rOxrlGDXEVuxnjRLvEcm/H3Hbc7Wiw12wkrZ
    Rx5BzV2jYSpzhfe2TvqLuRzw9KBB+VmxZXns63i8X+Ig0pwF/60hOdZ++4mVgLKslJzMiQ
    CfT37gwZD8HhC85q/VSENSWs3U3O4rWC3a2dXrM3/ICJXGztdegpB3CbYwlr3XaxQP7AQd
    1mvp10qwfsRb+mkXHpyEbH5R6kWxEpnt95Jb8RzzuoGYDOvy7LCeExW2NlZvBGDzUOyKCr
    0L3DA7Dc42VTS/EARgGeGJAjmc9d7nM+iK/RdX0XtGiuymYWiULg6aL92JrAiiGlaYhCpJ
    OFx4tbJHL3HfEAwuREgDTN7zKDZleiYxMO4PqetmsmlpAkzmKDHGXAqsoKCuTyEWRNgfqG
    6MNskjYeR0AmUEhXuNI8l287nZiTYbVodfGOddYmAhHxBQmQHmEOxZoevugBmV2++2mcwb
    ijPlzl9etzVYL24eevqyRbyo0Kn8zXH3D6VH5D7eo4i5+DLKHdPgRiKGkQYpr0wpc2lhHv
    EhYZSo4kRS82eNRA+s0CJD0uK1snIrVti+AlxvCgth/S6VfGamMGGy08TKkw
X-ME-Proxy: <xmx:94yoasjgB6qc912KMPiw_wG2L_i_CmDagY6yn1J9zbINdHmrZPWe4Q>
    <xmx:94yoao05Y2kBj9yq51iMu_S-qN9ePU7h89PVrepYXNCyJpPAAMMYJg>
    <xmx:94yoatKOPaspLlHexdhk_3MPQCXw3ltPiqjGqFHOCex-c3-2Q24cYg>
    <xmx:94yoagzX-HDrHatgEfgTE-s_YqJ5Ab8u78h2IJpvG7L-e_E2jsS4Pg>
    <xmx:94yoaiJtUXoiThw0jQUOsGQUKVZK_1hq30kgCy2TVqGb9fUEOpQHRKWl>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Sep 2026 20:10:29 -0400 (EDT)
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
In-reply-to: <178943070662.207413.9700024518083440241@noble.neil.brown.name>
References: <20260913144918.1606123-1-mjguzik@gmail.com>
  <20260913144918.1606123-3-mjguzik@gmail.com>
  <178943070662.207413.9700024518083440241@noble.neil.brown.name>
Date: Tue, 15 Sep 2026 10:10:27 +1000
Message-id: <178943102713.207413.2253649379310238579@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 15 Sep 2026, NeilBrown wrote:
> On Mon, 14 Sep 2026, Mateusz Guzik wrote:
> > Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> > ---
> >  fs/namei.c           | 29 +++++++++++++++++++++++++++++
> >  include/linux/path.h | 14 ++++++++++++--
> >  2 files changed, 41 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index ca4f5e3be99a..c8754c7ba8be 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -698,6 +698,35 @@ static __always_inline int lookup_inode_permission_m=
ay_exec(struct mnt_idmap *id
> >  	return security_inode_permission(inode, mask);
> >  }
> > =20
> > +/**
> > + * path_create - WRITEME
> > + * @path: path to get the reference to
> > + * @mnt: WRITEME
> > + * @dentry: WRITEME
> > + *
> > + * Create a path object using the given vfsmount and dentry pair while i=
ncrementing
> > + * the reference count on both.
> > + */
> > +void path_create(struct path *path, struct vfsmount *mnt, struct dentry =
*dentry)
> > +{
> > +	path->mnt =3D mntget(mnt);
> > +	path->dentry =3D dget(dentry);
> > +}
> > +EXPORT_SYMBOL(path_create);
> > +
> > +/**
> > + * path_clone - WRITEME
> > + * @path: path to get the reference to
> > + *
> > + * Given a path increment the reference count to the dentry and the vfsm=
ount.
> > + */
> > +void path_clone(const struct path *src, struct path *dst)
> > +{
> > +	dst->mnt =3D mntget(src->mnt);
> > +	dst->dentry =3D dget(src->dentry);
> > +}
> > +EXPORT_SYMBOL(path_clone);
> > +
> >  /**
> >   * path_get - get a reference to a path
> >   * @path: path to get the reference to
> > diff --git a/include/linux/path.h b/include/linux/path.h
> > index 7ea389dc764b..8a621e0e1921 100644
> > --- a/include/linux/path.h
> > +++ b/include/linux/path.h
> > @@ -10,8 +10,18 @@ struct path {
> >  	struct dentry *dentry;
> >  } __randomize_layout;
> > =20
> > -extern void path_get(const struct path *);
> > -extern void path_put(const struct path *);
> > +void path_create(struct path *, struct vfsmount *, struct dentry *);
> > +void path_clone(const struct path *, struct path *);
> > +void path_get(const struct path *);
> > +void path_put(const struct path *);
> > +
> > +static inline void path_move(struct path *src, struct path *dst)
>=20
> Oh ...  this is backwards.  At least is it backwards compared to
> memmove().  I understand different people will read "move" differently
> and would prefer to avoid it.
> Can we do without it?  You only seem to use it in one place.
>=20
> How would you feel about:
>=20
>  struct path path_move_from(struct path *src)
>  {
> 	struct path ret =3D *src;
> 	src->mnt =3D NULL;
> 	src->dentry =3D NULL;
> 	return ret;
>  }
>=20
> and then use
>=20
>  file->__f_path =3D path_move_from(path);
>=20
> ??

And then of course there is path_clone() which looks backwards to me.
Can we just change path_get() to return the path, like a lot of
FOO_get() functions do, and use
   newpath =3D path_clone(old_path);
??

Thanks,
NeilBrown

