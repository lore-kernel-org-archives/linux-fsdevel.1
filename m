Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA79449B31
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 Jul 2026 23:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591890; cv=none; b=XysZtnulRIH4KpzM/fz6N2Q6lYlmbXc3vdlH1Bsbx8SVbhHDT/3iARAIN6DeTtHC6qvzHEUjmW0b0IyPvVSD5Iq9VEmCb0ygChMedOophYEqr7i7x1oiwd8UGWau2n+y29e4zCPPoDPIlAI4NX7Z3yr0t5BtujPmPFYkv56706c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591890; c=relaxed/simple;
	bh=Z4TjaDYMZDCuSvGC7H8rE5u5yGiltzXRgWc+8yRjcrA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=IDCatsoGlDj22AZedw0Ax5/KO6MRETcbbzUyqGDqDzGewg4NbhXvGnkv7FcAo170uv4MSmRUeqb/t0Q9A6eW4rcIGeySykP/rTN/uygXt3JVnV+VOUE4vLjVXsEOUDAAVsiZ/L0YJ59n0adhcd74e16nKookoi85S7zoRK0UIL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=AyspAZ05; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y6GU+moD; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="AyspAZ05";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y6GU+moD"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 6685E1D00075;
	Mon, 20 Jul 2026 19:58:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 20 Jul 2026 19:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784591887; x=1784678287; bh=pclXukZ2b/ZSz+0/n1hY8so6FtNijQkU1T8
	Ici1iKRI=; b=AyspAZ057hrY8NB8HLPK0nlnpeoTsX8qckdwOwDrS5GJR5OWppZ
	eO98Q0gxn4JDYi6OS6qNhYBsnpz7HzSpbdcidxuDRP+sSMU3sZNfqKdJtXMtTBTf
	jZutzqy91fz2qK4lEiE/rTVI1xs1dMjoRgSbs0r2YrUHmaHChI17T0Zk12A3UOFa
	D/lHtKNWonLLWedDA9NV0izJTKAwjAykEYL0744v6j2NACmDyKVXht474ZgNH/rG
	a72MZyx9Edv79iiKKW/IP7VEDI78qh/pqAqVM9WLEEzwgHnRhARSA6bhLnHKkVtR
	Xqrw6mSLwUOgUhGAI8499quSzZAGDZXk8fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784591887; x=
	1784678287; bh=pclXukZ2b/ZSz+0/n1hY8so6FtNijQkU1T8Ici1iKRI=; b=Y
	6GU+moDjPngSrepniLM1wGnq3BI918rFj+Teaj6WVmyFKGrJPOoluV9CsRHK45pe
	yZ3u9j35Av/HFkcIgSx0NbI31X4UzC5W7F/0lQQJHh7BrD9mUumwrQEteon12tef
	i5Gw72+jHJLd6WViTc2WYXsSQ+Ev+BAqB9IPsaRn9cwoLum0ukRQrleByd8TGalB
	Wu9IaVz4lnSfkj6bvcE7ClY5VrOqORcYi01jSwwfer8Eox/nNi6ZXMY/yJlN5Zxp
	LQS0zD/H8ZGDWEOpwHZuUmelPJ1dx+v1EbPoDxUL/alize5ZTSV/R6ha8z/sDaDr
	xYFI+eBDghVr+YYksflFg==
X-ME-Sender: <xms:DrZeakmtavJl5NiLylznOXoK960jVrInrmloR3bWvqmm1yQpNSc0Cw>
    <xme:DrZeahymoHLYqltC5yyFjuZfvXu6vYcCV6gmSQAZ4o_BEndk6pg45QiOq-YIhBBQ7
    NKYAfEuHvLdX74qUEafGC4TodLsAeBzrx3NRcA9h-4KLZUY0g>
X-ME-Received: <xmr:DrZeak8j5YRNu-kMHZZ4Z673Bfxte-TasmYpt5zMy_hVXZbq553BR0htnw2dDhVZILvc1L21Y8dGgxF7xNIhWHXHXyBy-tY>
X-ME-Proxy-Cause: dmFkZTEmy4uRohnL4RT2QxqN02yZGLLsYUxxZbL6HVW0NrTDE3jd7IpcA1j8iAV2JV/Rk6
    SThtzxeAaGkECWImuM94IgZWZSZ12RPPMRyR0a1eW+aHoQRwZGxo/s4gIwn7eJCgIK7ygv
    DtfPOgeeAwgWQyrET4ShkacKj6Q+4WQL17hLw3i6iDyovbcsIZKutG5L4aSDhH/cnVqnzO
    L6dkZpsq2FSo7JoDHJK9sMMlTWwLpWTYnHe5+5SyFeC+dUS+DzI1DGM+np+U4HU4eAwtCl
    8f5CRlkbDbxE69v/ykkJeJ/STlNhPMaBpNqbZ1OgMsgi16fxaleDSIHREOxcVlZOXRhdot
    zT9xXFvUYApevc5wYM25Iv5uiRBjTJ/tWwIMQsZDr4Mld4MgA8cXnNcc8rh//Kz3Wche4X
    RJKK8MFS63g0xrYWIwjfmpHSGY4rq5dXUsfKeM/+NsQbtDm6+Qo7td3sKw360QrIFSkfAU
    7A6Bd+8DOelKYxmfs9vZKA9yJHVKNAuio+A1hCbCQex2s+Dix4NQH6QGStwSq/zYsCIkIk
    SwrbNTrb/lVaui/rEaAPSrQq0hL4GbQ+Xpu03rUhOPW8kn75qmpmvmmqXnIsFhc42iuGJx
    aJl+QoXbXcNOv6ISKpoIdY3yWVY5B5QkpBM1PIC9/nXOxifNcvECr9ksOb2A
X-ME-Proxy: <xmx:DrZealJd4MoSLwOfH_n9-7cT5-8dAR2fLeZvAMBe0LXFOsiuzcgM6Q>
    <xmx:DrZeaqfX5PwJrOMylYqOJP7CC8C5oxeeOGqGiEuoMX30bGry-QycqA>
    <xmx:DrZeak-rmU0s7KP9BGgFdDFqVT_X9rTVSNbV1nBYoMn8p4pPlb5QHQ>
    <xmx:DrZeanoJWxjDbp9fKDqygKy0YL5pzX5r5QyYcKoMaCi7jw0BnlamyA>
    <xmx:D7ZeanK_T-94W2Kuczq4tBezlO-SMzgl9MSmBiPhL0vZGJFwawMq7WjI>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jul 2026 19:58:04 -0400 (EDT)
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
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] VFS: add vfs_lookup_open() for nfsd
In-reply-to: <381790643.1478590.1784412802571@kpc.webmail.kpnmail.nl>
References: <20260714230534.776886-1-neilb@ownmail.net>
  <20260714230534.776886-4-neilb@ownmail.net>
  <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
  <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
  <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
  <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
  <381790643.1478590.1784412802571@kpc.webmail.kpnmail.nl>
Date: Tue, 21 Jul 2026 09:58:00 +1000
Message-id: <178459188006.3371781.5620319924458142615@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 19 Jul 2026, Jori Koolstra wrote:
> Comments between the lines.
>=20
> > Op 18-07-2026 00:59 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > Op 16-07-2026 00:34 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > >=20
> > > > =20
> > > > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > > > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > > > >=20
> > > > > > =20
> > > > > > From: NeilBrown <neil@brown.name>
> > > > > >=20
> > > > > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > > > > exported for nfsd to use - to replace dentry_create().
> > > > > >=20
> > > > > > It is limited in that no filename is given (thus no auditing) and=
 no
> > > > > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduce=
d from
> > > > > > the open flags.
> > > > > >=20
> > > > > > If a non-regular file is found and appropriate error is returned =
and no
> > > > > > file is opened.
> > > > > >=20
> > > > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > > > ---
> > > > > >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++=
++++++
> > > > > >  include/linux/namei.h |  3 ++
> > > > > >  2 files changed, 99 insertions(+)
> > > > > >=20
> > > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > > index cb33a01d16eb..630f93608224 100644
> > > > > > --- a/fs/namei.c
> > > > > > +++ b/fs/namei.c
> > > > > > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct =
nameidata *nd, struct file *file,
> > > > > >  	goto out;
> > > > > >  }
> > > > > > =20
> > > > > > +/**
> > > > > > + * vfs_lookup_open - open and possibly create a regular file
> > > > > > + * @parent: directory to contain file
> > > > > > + * @last: final component of file name
> > > > > > + * @open_flag: O_flags
> > > > > > + * @mode: initial permissions for file
> > > > > > + *
> > > > > > + * Open a file after lookup and/or create.  This provides similar
> > > > > > + * functionality open_last_lookups() for non-VFS users, particul=
arly
> > > > > > + * nfsd.
> > > > > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appr=
opriate.
> > > > > > + *
> > > > > > + * If the fs object found is not a regular file then an error is=
 returned.
> > > > > > + * In some cases, related errors are repurposed so that the call=
er can
> > > > > > + * determine the type of file found from the error.
> > > > > > + * -EISDIR : a directory was found
> > > > > > + * -ELOOP  : a symlink was found
> > > > > > + * -ENODEV : a block or character device special file was found
> > > > > > + * -EFTYPE : any other non-regular file was found, such as FIFO =
or SOCK.
> > > > > > + *           or ->atomic_open responded to __O_REGULAR.
> > > > > > + *
> > > > > > + * Returns: the opened struct file, or an error.
> > > > > > + */
> > > > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *l=
ast,
> > > > > > +			     int open_flag, umode_t mode)
> > > > > > +{
> > > > > > +	struct file *file __free(fput) =3D NULL;
> > > > > > +	struct nameidata nd =3D {};
> > > > > > +	struct open_flags op =3D {};
> > > > > > +	struct dentry *dentry;
> > > > > > +	int error =3D 0;
> > > > > > +
> > > > > > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bi=
ts");
> > > > > > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_RE=
GULAR),
> > > > > > +		  "open_flag has unsupported flags");
> > > > > > +
> > > > > > +	mode |=3D S_IFREG;
> > > > > > +	open_flag |=3D __O_REGULAR;
> > > > > > +
> > > > > > +	error =3D lookup_noperm_common(last, parent->dentry);
> > > > > > +	if (error)
> > > > > > +		return ERR_PTR(error);
> > > > > > +
> > > > > > +	file =3D alloc_empty_file(open_flag, current_cred());
> > > > > > +	if (IS_ERR(file))
> > > > > > +		return file;
> > > > > > +
> > > > > > +	nd.path =3D *parent;
> > > > > > +	nd.last =3D *last;
> > > > > > +	nd.flags =3D LOOKUP_OPEN;
>=20
> I am not so familiar with the audit stuff, but you don't init nd->name here=
. Will
> this possibly lead to a new AUDIT_TYPE_UNKNOWN type struct audit_names for =
every
> invoke of vfs_lookup_open? See __audit_inode() function.

I'm not familiar with it either, but I reasoned that as audit_inode()
clear handles a name of NULL, then it is safe to pass that name.  And
that is the best we can do from nfsd.

>=20
> That is also a bit of a pain-point here in general. If ever lookup_open() w=
as changed
> to use more of nd, then you must remember to initialize the field here as w=
ell, which
> makes this function quite fragile.

All the fields that I don't explicitly initialise get initialised to
null where nd is declared "nd =3D {}".  So it should be fairly safe.

>=20
> One way to resolve that is to pass everything as argument to lookup_open() =
instead
> of through nd, but that is a bit ugly. What do you think?

An earlier version of my patch did exactly that but it seemed
unnecessarily clumsy.
I don't think it is too much to expect that when someone adds a field to
nd, they check to make sure it is properly initialised everywhere.

>=20
> > > > > > +	if (open_flag & O_CREAT) {
> > > > > > +		nd.flags |=3D LOOKUP_CREATE;
> > > > > > +		if (open_flag & O_EXCL)
> > > > > > +			nd.flags |=3D LOOKUP_EXCL;
> > > > > > +	}
> > > > > > +	op.open_flag =3D open_flag;
> > > > > > +	op.mode =3D mode;
> > > > > > +	dentry =3D lookup_open(&nd, file, &op);
> > > > > > +
> > > > > > +	if (IS_ERR(dentry))
> > > > > > +		return ERR_CAST(dentry);
> > > > > > +
> > > > > > +	if (d_really_is_negative(dentry)) {
> > > > > > +		error =3D -ENOENT;
> > > > > > +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EX=
CL)) {
> > > > > > +		error =3D -EEXIST;
> > > > > > +	} else if ((dentry->d_inode->i_mode & S_IFMT) !=3D S_IFREG) {
> > > > > > +		switch (dentry->d_inode->i_mode & S_IFMT) {
> > > > > > +		case S_IFDIR:
> > > > > > +			error =3D -EISDIR;
> > > > > > +			break;
> > > > > > +		case S_IFLNK:
> > > > > > +			error =3D -ELOOP;
> > > > > > +			break;
> > > > > > +		case S_IFBLK:
> > > > > > +		case S_IFCHR:
> > > > > > +			error =3D -ENODEV;
> > > > > > +			break;
> > > > > > +		case S_IFIFO:
> > > > > > +		case S_IFSOCK:
> > > > > > +		default:
> > > > > > +			error =3D -EFTYPE;
> > > > > > +			break;
> > > > > > +		}
> > > > > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > > > > +		nd.path.dentry =3D dentry;
> > > > > > +		error =3D vfs_open(&nd.path, file);
> > > > > > +	}
> > > > > > +	dput(dentry);
> > > > > > +
> > > > > > +	if (error)
> > > > > > +		return ERR_PTR(error);
> > > > > > +	return no_free_ptr(file);
> > > > > > +}
> > > > > > +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> > > > > > +
> > > > > >  static inline bool trailing_slashes(struct nameidata *nd)
> > > > > >  {
> > > > > >  	return (bool)nd->last.name[nd->last.len];
> > > > > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > > > > index ebe6e29f7e93..86d657b24fc6 100644
> > > > > > --- a/include/linux/namei.h
> > > > > > +++ b/include/linux/namei.h
> > > > > > @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct den=
try *parent,
> > > > > >  struct dentry *start_removing_dentry(struct dentry *parent,
> > > > > >  				     struct dentry *child);
> > > > > > =20
> > > > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *l=
ast,
> > > > > > +			     int open_flag, umode_t mode);
> > > > > > +
> > > > > >  /* end_creating - finish action started with start_creating
> > > > > >   * @child: dentry returned by start_creating() or vfs_mkdir()
> > > > > >   *
> > > > > > --=20
> > > > > > 2.50.0.107.gf914562f5916.dirty
> > > > >=20
> > > > > So I am not really familiar with the nsfd backend where this functi=
on will be put
> > > > > to use, but I imagine you need the fileserver to mirror operations =
on the client.
> > > > > And since from within the kernel we don't do syscalls, we need this=
 function to
> > > > > mimic the client syscall path and call into the actual underlying f=
s. Is that
> > > > > more-or-less correct?
> > > >=20
> > > > more or less.
> > > >=20
> > > > >=20
> > > > > So then the rights checking happens on the properly authenticated c=
lient-end? Or
> > > > > does nsfd have another mechanism for that?
> > > >=20
> > > > Both the client and server check rights.  The server because it cannot
> > > > trust the client, the client so it doesn't waste time trying things t=
hat
> > > > aren't permitted.
> > > >=20
> > > > >=20
> > > > > I just want to ensure that using this function cannot bypass the st=
icky directory
> > > > > semantics, as that now is the task of do_open(), which this skips o=
f course.
> > > > > If that is OK, this function LGTM :)
> > > >=20
> > > > It appears that may_create_in_sticky() is only ever called AFTER the
> > > > file has been created.  do_open() is called after open_last_lookups(),
> > > > which calls lookup_open(), which calls ->create or ->atomic_open().
> > > >=20
> > > > I wonder if anyone has tested that code. Maybe I should...
> > > >=20
> > >=20
> > > Yeah, that is the correct behavior, I think. may_create_in_sticky() is =
a bit of
> > > a misnomer, really it should be something like may_o_creat_in_sticky() =
or even
> > > may_open_in_stick(). Afaik it's optional hardening that really should b=
e the
> > > responsibility of user space: it's to prevent file squatting whereby in=
, for instance,
> > > /tmp an attacker predicts what file a privileged user will O_CREAT open=
. In that case,
> > > if the user application didn't use O_EXCL, the attacker may symlink it =
in advance to
> > > say /etc/passwd, or do other nasty things.
> >=20
> > Ahhh - I see.  As you say it is "O_CREAT" rather than "create" that is
> > relevant, and whether the calling process owns the file.
> >   may_o_create_alien_in_sticky()
> > is a bit long.
> >=20
> > This functionality doesn't protect the filesystem, it protects the
> > application.
> > Now that I understand that I can say with some confidence that nfsd
> > doesn't have any interest in it.  The NFS client is in a positive to
> > protect the application, it gets this protection for free.
> >=20
> > So nfsd doesn't need to be concerned with the stick-dir check.
> >=20
> > >=20
> > > I presume there was once discussion about whether this should be kernel=
 responsibility,
> > > and that's where this line is about in link_path_walk():
> > >=20
> > > 		nd->dir_mode =3D 0; // short-circuit the 'hardening' idiocy
> > >=20
> > > Or is that not what you meant?
> >=20
> > I think that line it to handle O_EMPTY_PATH opens where the directory
> > might not have been seen.  And certainly we don't always have agreement
> > about what hardening is appropriate.
> >=20
>=20
> This line predates O_EMPTYPATH, isn't it just because root has no parent to
> set the dir_mode of?

Yes, I misread the code.
This code fires if a path or symlink is "" or "/".
So I don't think it is about "root" specifically, but more about the
lack of any name.  If there is no name there can be no misuse of names
so no need for the hardening.

Thanks,
NeilBrown


