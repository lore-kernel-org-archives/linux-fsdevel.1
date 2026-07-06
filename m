Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EA6436BD1
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377701; cv=none; b=rNgLMA/S/yRC6tPL7O2OVq1sVR72Sk4RcSeF9N5nUpXJK+SRi6gozeuCYNhpRcqpiZo98XrcsbHH3fqc5U5U4UvNqDYhb5JlqJqQvhsLJ/TtxtxknmND8GGVlG9RTPjQPmUQeT/le6WEXIkWvckxVO+gGswFj/VfNgK6OM1dwyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377701; c=relaxed/simple;
	bh=GFKzdY0843AuSUbW7GZto0cgB/MKkg0xNGP/mK36/G8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=R4ZlwO8A8DBBj9mdtq49rYcDcppToSAVaLU7mzluznj1X1kYrAVD4E3/h5WP032Tnr7jMFu4E3LCUt/H/CBomj67kJ8+NrTW2k8o+DPzlSPJ8gkrl9tgVyXOtwwavuc96P54UlFNsQe5rwEABvBgG2NkGBa4yEAVVkyYV6WwwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JzK3fXBJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=W5glCzt+; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JzK3fXBJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W5glCzt+"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id E5DD8EC007A;
	Mon,  6 Jul 2026 18:41:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 06 Jul 2026 18:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783377698; x=1783464098; bh=SXlowPF1LlJcBOx7BmUBlMua0eL+AJqzICY
	igsOJbco=; b=JzK3fXBJT80tkV6GRTkIkrAghpVzJslDVp34dQFmUL+MvJpHKoy
	bcQII38Ld1/E9vYjlKv0f0AFruvI9J2AmtFN4eig2/ng5pUOaiVr78o8sqrHCtD/
	pWkuIvX4DSBIyxIxQBocOSI2aDk/7TJZ32qqWEEmHO1HOvvFaw83ctPJt/9wNJ+7
	HAuf6HpG+d3rvpV5E5k6rvMce7Y22dA25YNaY4P9YayFOBJWuVhzyF+2IV5r7km8
	0hW74Np6RaLqLAF6wKqb3Dv/qe105vr8skd8Lb2DGXNU3dXX/1JiAaGMQLI331iQ
	ZWzoiLo0qjQXSlJpVC7wVYF7goN7Zmks+5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783377698; x=
	1783464098; bh=SXlowPF1LlJcBOx7BmUBlMua0eL+AJqzICYigsOJbco=; b=W
	5glCzt+HCIdBag5NjvKbBUH4YqF9nYZLvEeyaQNtt3sfwjefCDbT4bNjir0ku5ov
	RA+FlOPqhXRq99bCqrVxURakuPGnYiN8MnBdwHOhmLFuzjam08siN6EdvmW6zjH0
	6PF1T8Nu7CrzyjExItF3UPEKaLP78bpjIPUMCE7V6qu413uKKL3/v/xlQxsYqscs
	jQsfUUIMHrPbJssxHWxzmK01kSiMmtUX6GVXuWC0FmyDbJlrWSQB0Xmdjf/nNbLy
	x4QrlGIXranfN+2jrxc6Cu6JVsPwyteyg9AvM9RWChV1LLuSZDOLlrl12+KFNc5S
	DwHqiUSd81kFfxVi3UmKQ==
X-ME-Sender: <xms:Ii9MarDSO-618gmhPpng2dzUEiq2bcqIXRnd-6CeHjrQMuvU-Y1kjg>
    <xme:Ii9Maqcu_wzalWKI8DR7TxhdDgOw2nsfL0BOTecS8H1ePeC6oB_n-Vk5b9H7-dfos
    8WkXGJIlsHGQu0QgHK2-RlfkzKu3wcWzJHrNl4Xr9_XoJrMuw>
X-ME-Received: <xmr:Ii9MaiIvvvZfUSitjD-INjq_pRwD8AcWAKThIHTzXpPPy122sE8CIsX-tBe3CRQIQ-3whBAQIhkkxdMbHBOdgax4624wwEo>
X-ME-Proxy-Cause: dmFkZTExtKNnqrm6HdLtpxRdzr3NGNGSLcIjSnE1WnIVVal/NQrfZop6HKzbCVFmacHV7L
    gGBJ51/81D5Kf1jdQrjhm6mBXU34k9r/9Vz7ID4Np3vwdVM2p5n6xe65Ek8xvlcRKVK9un
    UwElRJi/buqrNsSEXR0SQbpYw68ljHd2XKSRat3RoXCjZx2WStvhvJxkTrpBytuOVscsHC
    t7V+2n6y9m9ZgPyUkv5OkWLGmmyY72I+FIEUuLca3unt7cwvsoEsJLc6dNtZ1dh9ItGF4z
    loJwES2ug1i3MQ7dmDH7XxMMV9tPSUPj2RG/1S5YcYEXCWYhWNPTX4nUKTywy5qDdsMIG1
    qKvQqqyN5GE20zgTYx4rGUScQ2GarfIJ+ANRJ6RutRgI6SM99QErg9sg0EDLE63yYJlb7V
    ZWQVaIOG/6WezdrdQMJBmlGH6yHgBLLibE/MHn4GGdTDA8vNFsPlF5dzrl+28chuCGxmtS
    VTP3sVziEgSqGQ1C7fPqqmExtXHq5HI3yxZ1sHQ1vVtFTIrz6WMaCh/sa+b5mAkNmEEkUd
    JIBc15L7SEbLUXYojOHUt9P8fycFZIzunbK6j/ZwDmI6/GfosYSPqXMN65iQxRlix266Vr
    UI7P2gwSpE8kuPXfAN+Fh5c3KQ1ytjgqdDxYNeNn9i0BqsdFuvds1zb14ZBg
X-ME-Proxy: <xmx:Ii9Mat3eG9RPcAjWh59yi4NrvN1Ado0l2P6wSBvMtaGyRDBw26cj_w>
    <xmx:Ii9MasjMl7zQv9Jo-A06fto2n9onpnEMFMx1oxRDv6IZJHnc6h-nEg>
    <xmx:Ii9MauVQ68pOCcDtMkQvZVWyaLZrxbWvTjA7iAFaz_KTasCh1Gvq0w>
    <xmx:Ii9MarX-cGA_6_X_JzrdMzn5rbTaT8l9odRSPhM_r1FUuyITBoA1Og>
    <xmx:Ii9Mai9bQiqxTFAO17DYOb1-H0fNc1eM-jHtOa5o0mfwuN8zR4FFsmKt>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:41:36 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Jori Koolstra" <jkoolstra@xs4all.nl>
Cc: "Christian Brauner" <brauner@kernel.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
In-reply-to: <1991496397.134753.1783375817781@kpc.webmail.kpnmail.nl>
References: <20260705235447.1322365-1-neilb@ownmail.net>
  <20260705235447.1322365-4-neilb@ownmail.net>
  <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
  <1991496397.134753.1783375817781@kpc.webmail.kpnmail.nl>
Date: Tue, 07 Jul 2026 08:41:34 +1000
Message-id: <178337769441.27465.695048090001126516@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 07 Jul 2026, Jori Koolstra wrote:
> > Op 06-07-2026 15:33 CEST schreef Christian Brauner <brauner@kernel.org>:
> >=20
> > =20
> > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > exported for nfsd to use - to replace dentry_create().
> > >=20
> > > It is limited in that no filename is given (thus no auditing) and no
> > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > > the open flags.
> > >=20
> > > If a non-regular file is found, an O_PATH file is returned.  This allows
> > > the caller to see what was found and to return an appropriate error
> > > code.  However if ->atomic_open was used, it may return an error rather
> > > then provide a dentry.
> > >=20
> > > Signed-off-by: NeilBrown <neil@brown.name>
> > >
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 1ca738401afa..002ffae7083d 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4568,6 +4568,76 @@ static struct dentry *lookup_open(struct nameida=
ta *nd, struct file *file,
> > >  	goto out;
> > >  }
> > > =20
> > > +/**
> > > + * vfs_lookup_open - open and possibly create a regular file
> > > + * @parent: directory to contain file
> > > + * @last: final component of file name
> > > + * @open_flag: O_flags
> > > + * @mode: initial permissions for file
> > > + *
> > > + * Open a file after lookup and/or create.  This provides similar
> > > + * functionality open_last_lookups() for in-kernel users, particularly
> > > + * nfsd.
> > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriat=
e.
> > > + *
> > > + * Returns: the opened struct file, or an error.
> > > + *     Caller should check that the file opened is regular,
> > > + *     if something else was found, an O_PATH file is provided.
> > > + *     Caller should validate FMODE_CREATED if O_EXCL was requested.
> > > + */
> > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > +			     int open_flag, umode_t mode)
> > > +{
> > > +	struct file *file __free(fput) =3D NULL;
> > > +	struct nameidata nd =3D {};
> > > +	struct open_flags op =3D {};
> > > +	struct dentry *dentry;
> > > +	int error =3D 0;
> > > +
> > > +	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");
>=20
> Typo here.

Thanks.

>=20
> > > +	error =3D lookup_noperm_common(last, parent->dentry);
> > > +	if (error)
> > > +		return ERR_PTR(error);
> > > +
> > > +	file =3D alloc_empty_file(open_flag, current_cred());
> > > +	if (IS_ERR(file))
> > > +		return file;
> > > +
> > > +	nd.path =3D *parent;
> > > +	nd.last =3D *last;
> > > +	nd.flags =3D LOOKUP_OPEN;
> > > +	if (open_flag & O_CREAT) {
> > > +		nd.flags |=3D LOOKUP_CREATE;
> > > +		if (open_flag & O_EXCL)
> > > +			nd.flags |=3D LOOKUP_EXCL;
> > > +	}
> > > +	op.open_flag =3D open_flag;
> > > +	op.mode =3D S_IFREG | mode;
> > > +	dentry =3D lookup_open(&nd, file, &op);
> > > +
> > > +	if (IS_ERR(dentry))
> > > +		return ERR_CAST(dentry);
> > > +
> > > +	if (d_really_is_negative(dentry)) {
> > > +		error =3D -ENOENT;
> > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > +		nd.path.dentry =3D dentry;
> > > +		if (!d_is_reg(dentry))
> > > +			/*
> > > +			 * allow caller to see dentry and choose
> > > +			 * correct error code
> > > +			 */
> > > +			file->f_flags |=3D O_PATH;
> > > +		error =3D vfs_open(&nd.path, file);
> >=20
> > Imho, that really throws a wrench into this function. I'd rather just
> > fail with well-known error codes in that case:
> >=20
> > /* directory */ -> EISDIR
> > /* device */    -> ENODEV
> >=20
> > Also, why does the caller need to know details here? Because of the
> > O_DIRECTORY work? But even so, EFTYPE would be enough afaict, I think?
> >=20
>=20
> If that is the reason it would be easier to just ban O_DIRECTORY from the
> start here, if vfs_lookup_open() is meant to only ever open/create regular
> files.
>=20
> Is that the case, Neil?

nfsd would never pass O_DIRECTORY to vfs_lookup_open() (unless the
protocol were extended one day of course) so banning O_DIRECTORY would
be best as accepting it could never be tested.

>=20
> Now that I think about it, I think you also want to restrict the O_* flags.
> lookup_open() normally does not get passed __O_TMPFILE or O_PATH afaik, and
> it would probably a bad idea to start passing it these flags. Maybe also do=
n't
> want to allow O_TRUNC.

Well nfsd is never going to send an illegal flag, but making it explicit
in the code what is supported would be sensible.
O_TRUNC needs to be supported because ->atomic_open can handle that.  An
NFSv4 OPEN request can indicate that if the file wasn't created, it
should be truncated.

Thanks,
NeilBrown
