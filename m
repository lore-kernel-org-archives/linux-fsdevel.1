Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988F82A1BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 22:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069904; cv=none; b=E7ihyL7AOaFQRHrTLEQaYJgxM2yFPMcJrtz9D1f0H6CFP+MW+ymgs1Crw90RcIyvxjCgE1trVPj19Z0ZF+lCHKtoDJarO+3LMKM+IciYJKTvV4o1pJAN/fl5RaeXyEA+SQUztLRuVck0EuCDFVHUkhGJWfP4Fs+7AyP4qG062d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069904; c=relaxed/simple;
	bh=Fl8IK+q+dPGgG44UjwRzkyhgNtTtSl5DjR0dbjJ/TUA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=JicY6nYtG+l9BbP5tn0uPsLMhI1Dr3InvomniAQXYRhO1QyjhxYixYJxhRTcT++X4WUa0MYggPtjdJySPtniynjsxfj2wJmAH3Lvpiapryp2djLddfh/2bA/D9QhU3L8pkjTF5RiHc4wzpsBMv8uQWqWZm/W1B9DGM7iMN5Y/w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=IEmFy89f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZzaKwyJa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="IEmFy89f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZzaKwyJa"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BB7107A0184;
	Tue, 14 Jul 2026 18:58:17 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jul 2026 18:58:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784069897; x=1784156297; bh=yTYYhUZ+Ax5ZkybXu/bf9TAD8meY7I9iTvZ
	hWitNUWQ=; b=IEmFy89fzWJylMZbBLJvuWxyYMooxluzamVbVCEX4uTcRbzN9wQ
	ej6kl5dizbyUg4VresJtbdVvgtWdDty/OKysQl+8A5WH+OOZ60f2O5aXQVeSkvtW
	L+v+eN0W5TYByc0nlrNOtgR+RwMb74LPsIer23+bQGRAk2JE94hfIpMk+c7aXJHj
	FKMSQUGlUCQW6keIlcpTt46pV2bVlivpyhlBsOPU/kFv0474LsfTMcQD4bvxF13F
	n4sSNCRKEt/I5r/yVB/9SVgRAtx2kjck/MoCnbmBvNLwm/JRE5nD42PFgaHsh2uZ
	NkTxspEJh2tpSGxPnlAqsb/X0F+51v0uv5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784069897; x=
	1784156297; bh=yTYYhUZ+Ax5ZkybXu/bf9TAD8meY7I9iTvZhWitNUWQ=; b=Z
	zaKwyJa0y36xskYXvnXAlRUq1JDPGzI2rsL+5iqPCfq/UrVCOnZJbQ5roJROCqXa
	c6o09uOOt0EnXqbJAnvEqY9LkkPoM/8MohzeIxC3Y4apCRE9G9tLpq+b/xW2cMVS
	xMCfR036DjkBqBH7Ofl4UpKs3VKNiChjBdY27KwvADcgy88klyuwQziliie7sTSn
	wBUzlPN+SpFQ5rPxkXiTvyYKE/pNu3TfEPn3ZJ/4jd8jKOyiO9+3J3f+gPWv8fJt
	h0G33erRVbK6rJIHdQytTQCXZ55Za2v91PDqYQ5tjZHVOA+qOKw8PvpuhxjcjhH7
	RiG74PUCDjjCsWI6Q87kA==
X-ME-Sender: <xms:Cb9WalrkFCVsBSn2O2aO_Cec1Gqk229NAtylyI8we2rJYRiK6utDaw>
    <xme:Cb9WaglwAiK1ygowJJuJExQ7w1lvDunrz_suOrpmvjpozHZrOgUH5veRTlWvyoQRO
    C7MWZK1xv9bfsGiFu3YJ6lhckUCsqIiz894FyH7_ZeUFsps>
X-ME-Received: <xmr:Cb9WatwRNxinGzqdivcMDJ4sURBiTSWRAtpMYSOMzHjWXf8Fx44hxghIr748Dgs82hiD1YkFfy_MBxIldL2mpfyHPL2wid4>
X-ME-Proxy-Cause: dmFkZTG4RFxE9lpajMTfNk7rGx0S78vrzXAEGf+VyKwHwTEpTJ6rvGCZ5xatPfQs3KZDWN
    aj90q5aN4itD8u11KYnlFGxpGoTNiLlQk9ZWDK4FM8khDX5vWxttPGf7wh4EH5hReA2G7t
    DC4C0YLtlSKTk5xfy0fKMeV8zjzq/iTje0sfwYYxLnT5LuCSvGXTrPwqYkXLUiTnJY91KP
    p6ZXLYBm39RyIZ1DzOr5Y6e48cF0v4lGz/GY8nbRWotN8TOGkzEuVk9d+zb1N4IdJGvo9e
    40fca0SDLO6/4N+D9S4rnh5WH0Itc9c+udsTPWSPYT/5V5lAiVo6gk3FMuUx9FlgOZjXce
    LsYPDwpbMqg1Iveks1uznwQgvhj7hEkKXn5ElxZAoKv4YNbm1SUdDQ0tzQvqU07iGsGiRH
    uGrrBBtYQcjd74NKK2cov00LWQAsPcV1rtooYAhEUXaQhszz64CXZCdXdBahN7f2nG6D5n
    41FxEmSoL31uZoYAft5MNpiA1rdbS4wzv7HUN7kekfyL+/3YfO7426z2M+oKAaJebqkDaM
    tajrIEm4bO2yIXRBN1skCKyYM4i0d1VaqlxW0eE9Cp6fIr3YUM7jpXbxsziUFbksUEtn6c
    Kkx/VDeBNwSeBFDYN+ApL+WYGyNWlOA3MX043Fhkme1jbZcx0u/d+7t0PJiw
X-ME-Proxy: <xmx:Cb9Wag-Ev__6-u5jg2pNruM44vH8JBufVuGiu8Val12lxbIbmjaRXw>
    <xmx:Cb9WahIPyP0J_6OVrIkLUTAP8RDq9dcwnS0DUi5Y2SW1TS3pK5Tizw>
    <xmx:Cb9WamcGPjCiW-McMup-pLwyl4Ft08wRfcVImMt2AgPM46K-Q278wA>
    <xmx:Cb9Wag8Tk-Nqkpu3eam5f8gxpv_8I8cD86cVadyqvPWUDtRbPwkVGg>
    <xmx:Cb9WamGCQxsWBeuqo1XtU_jEpUsCU3BCHE67O-sFq-D32tzshrMtSm9p>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 18:58:15 -0400 (EDT)
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
Subject: Re: [PATCH v3 3/3] VFS: add vfs_lookup_open() for nfsd
In-reply-to: <2091253759.1001623.1784032128121@kpc.webmail.kpnmail.nl>
References: <20260713060814.2849-1-neilb@ownmail.net>
  <20260713060814.2849-4-neilb@ownmail.net>
  <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
  <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
  <2091253759.1001623.1784032128121@kpc.webmail.kpnmail.nl>
Date: Wed, 15 Jul 2026 08:58:11 +1000
Message-id: <178406989145.3371781.14103195631413999969@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 14 Jul 2026, Jori Koolstra wrote:
> > Op 13-07-2026 23:55 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Mon, 13 Jul 2026, Jori Koolstra wrote:
> > > > Op 13-07-2026 08:05 CEST schreef NeilBrown <neilb@ownmail.net>:
> > > >=20
> > > > =20
> > > > From: NeilBrown <neil@brown.name>
> > > >=20
> > > > vfs_lookup_open() is a limited version of lookup_open() which is
> > > > exported for nfsd to use - to replace dentry_create().
> > > >=20
> > > > It is limited in that no filename is given (thus no auditing) and no
> > > > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced fr=
om
> > > > the open flags.
> > > >=20
> > > > If a non-regular file is found, an O_PATH file is returned.  This all=
ows
> > > > the caller to see what was found and to return an appropriate error
> > > > code.  However if ->atomic_open was used, it may return an error rath=
er
> > > > then provide a dentry.
> > >=20
> > > Stale commit paragraph.
> >=20
> > Thanks :-(
> >=20
> > >=20
> > > >=20
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > > >  fs/namei.c            | 89 +++++++++++++++++++++++++++++++++++++++++=
++
> > > >  include/linux/namei.h |  3 ++
> > > >  2 files changed, 92 insertions(+)
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index cb33a01d16eb..2143f759443a 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -4562,6 +4562,95 @@ static struct dentry *lookup_open(struct namei=
data *nd, struct file *file,
> > > >  	goto out;
> > > >  }
> > > > =20
> > > > +/**
> > > > + * vfs_lookup_open - open and possibly create a regular file
> > > > + * @parent: directory to contain file
> > > > + * @last: final component of file name
> > > > + * @open_flag: O_flags
> > > > + * @mode: initial permissions for file
> > > > + *
> > > > + * Open a file after lookup and/or create.  This provides similar
> > > > + * functionality open_last_lookups() for non-VFS users, particularly
> > > > + * nfsd.
> > > > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropri=
ate.
> > > > + *
> > > > + * If the fs object found is not a regular file then an error is ret=
urned.
> > > > + * In some cases, related errors are repurposed to so that the calle=
r can
> > > > + * determine the file of file found from the error.
> > > > + * -EISDIR : a directory was found
> > > > + * -ELOOP  : a symlink was found
> > > > + * -ENODEV : a block or character device special file was found
> > > > + * -EFTYPE : any other non-regular file was found, such as FIFO or S=
OCK.
> > > > + *
> > > > + * Returns: the opened struct file, or an error.
> > > > + */
> > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > > +			     int open_flag, umode_t mode)
> > > > +{
> > > > +	struct file *file __free(fput) =3D NULL;
> > > > +	struct nameidata nd =3D {};
> > > > +	struct open_flags op =3D {};
> > > > +	struct dentry *dentry;
> > > > +	int error =3D 0;
> > > > +
> > > > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> > > > +	error =3D lookup_noperm_common(last, parent->dentry);
> > > > +	if (error)
> > > > +		return ERR_PTR(error);
> > > > +
> > > > +	file =3D alloc_empty_file(open_flag, current_cred());
> > > > +	if (IS_ERR(file))
> > > > +		return file;
> > > > +
> > > > +	nd.path =3D *parent;
> > > > +	nd.last =3D *last;
> > > > +	nd.flags =3D LOOKUP_OPEN;
> > > > +	if (open_flag & O_CREAT) {
> > > > +		nd.flags |=3D LOOKUP_CREATE;
> > > > +		if (open_flag & O_EXCL)
> > > > +			nd.flags |=3D LOOKUP_EXCL;
> > > > +	}
> > > > +	op.open_flag =3D open_flag;
> > > > +	op.mode =3D S_IFREG | mode;
> > > > +	dentry =3D lookup_open(&nd, file, &op);
> > > > +
> > > > +	if (IS_ERR(dentry))
> > > > +		return ERR_CAST(dentry);
> > > > +
> > > > +	if (d_really_is_negative(dentry)) {
> > > > +		error =3D -ENOENT;
> > > > +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL))=
 {
> > > > +		error =3D -EEXIST;
> > > > +	} else if ((dentry->d_inode->i_mode & S_IFMT) !=3D S_IFREG) {
> > > > +		switch (dentry->d_inode->i_mode & S_IFMT) {
> > > > +		case S_IFDIR:
> > > > +			error =3D -EISDIR;
> > > > +			break;
> > > > +		case S_IFLNK:
> > > > +			error =3D -ELOOP;
> > > > +			break;
> > > > +		case S_IFBLK:
> > > > +		case S_IFCHR:
> > > > +			error =3D -ENODEV;
> > > > +			break;
> > > > +		case S_IFIFO:
> > > > +		case S_IFSOCK:
> > > > +		default:
> > > > +			error =3D -EFTYPE;
> > > > +			break;
> > > > +		}
> > > > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > > > +		nd.path.dentry =3D dentry;
> > > > +		error =3D vfs_open(&nd.path, file);
> > > > +	}
> > > > +	dput(dentry);
> > > > +
> > > > +	if (error)
> > > > +		return ERR_PTR(error);
> > > > +	return no_free_ptr(file);
> > > > +}
> > > > +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> > > > +
> > > >  static inline bool trailing_slashes(struct nameidata *nd)
> > > >  {
> > > >  	return (bool)nd->last.name[nd->last.len];
> > > > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > > > index ebe6e29f7e93..86d657b24fc6 100644
> > > > --- a/include/linux/namei.h
> > > > +++ b/include/linux/namei.h
> > > > @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry =
*parent,
> > > >  struct dentry *start_removing_dentry(struct dentry *parent,
> > > >  				     struct dentry *child);
> > > > =20
> > > > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > > > +			     int open_flag, umode_t mode);
> > > > +
> > > >  /* end_creating - finish action started with start_creating
> > > >   * @child: dentry returned by start_creating() or vfs_mkdir()
> > > >   *
> > > > --=20
> > > > 2.50.0.107.gf914562f5916.dirty
> > >=20
> > > I think it would still be sensible to check the O_ flags being allowed =
to
> > > be passed in. I get that nsfd is not going to do weird things, but if t=
his
> > > is a helper that may be used by other code too at some point (unaware o=
f the
> > > intricacies of lookup_open()) the context could help as we didn't go th=
rough
> > > all the normal checks in build_open_flags().
> >=20
> > So we allow
> >=20
> >  O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC
> >=20
> > and should assert __O_REGULAR.
> >=20
> > Thanks,
> > NeilBrown
> >=20
>=20
> Yes, sounds good. Keep in mind that vfs_open() does not handle truncate, it=
 only
> happens in do_open() in the open(2) path, so you must handle the actual tru=
ncation
> back in the nfsd code. You are probably very aware of this, but just in cas=
e :)

O_TRUNC handling is a bit untidy (or convoluted to use your word).  Some
atomic_open functions implement it, some deliberately don't.  If
atomic_open wasn't used, it happens much later.  Maybe I could try and
tidy that up.

>=20
> __O_REGULAR is also only handled in do_open(), so it does nothing in namei.=
c right
> now, still seems good to include it. I don't understand why the __O_REGULAR
> implementation is so convoluted, but I haven't looked into it yet. I plan t=
o do
> that sometime soon.

Some atomic_open functions handle __O_REGULAR, and I think it best to
abort an unwanted open as early as possible.
"convoluted" happens when code grows over time and people work with what
is there rather than tidying it up first, then working with tidy code.
We cannot tidy everything all at once, but if everyone making changes
does a little bit of tidying, we might avoid too much convolution!

Thanks,
NeilBrown


>=20
> Thanks,
> Jori.
>=20

