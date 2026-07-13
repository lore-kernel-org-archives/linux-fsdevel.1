Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7950529BDB1
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 21:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783979725; cv=none; b=EDRRO1s+jGzAEdLK3EFJE+vxmz4KY/UAtS66U8asDmrKteE78BgVYqtw3RiLvsLSlE9Ea7gBXmK0jm0khGn7HkJArFSz9OjQbNsC83LYQiXUB+3rUHHX7/5VD1aIJD1poddMKAM7vQPDJny6pGlgM9t+r7HEGZ/ZBdVsnsB3RGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783979725; c=relaxed/simple;
	bh=+bIpv6k9Q8jxPxBQQd5xX8wBHNUgzw5ENcwQsEW0rOg=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=sqhv7lsnkA3tHgzVxsRUpByCJu5qzAkfaOSZVDhJ7bvwXR/bff97jGwF54r5zzyqP7BsqJJANT+RQmDzQFM1dSkNTQIoktwx+zkKDU5pvKJH1rmc+tmOlIA64Cp1FYBvTIUFz7T5HSp8eWxtFrgUb6K1dCROttZpbf+klj7Hps0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Kv3bWxQN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gisY2Nf4; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Kv3bWxQN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gisY2Nf4"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B71E87A00EC;
	Mon, 13 Jul 2026 17:55:22 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 13 Jul 2026 17:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783979722; x=1784066122; bh=gYP2szqcfxjzvBYgERd2uqAN7eFGDxn2M6x
	g4V5MZ0k=; b=Kv3bWxQNj9SGih1GYFSZvLC2TUpnwp2JtT4nvCqU6072LcAtIjH
	z+hyPX0YSWb25s+UkqmG3V8hj09183GeelOKR7m3bibeyGVD65pBy+KVAb5hBvYH
	B650t6hLD9kTHRNO3HDjwk3gGopxwOc7tyuYO4u13G2AxaHWLSdtSJyNtPv+0Rql
	Ov5dZ7x+rNeYpLysyRItxk+SS0pe1W86HFd1q9pyNjMkxfnjRFa6JPcm22kvgWc8
	rbMiUkws5I+q6GXimDeSKtGiHBQp6eSCWlGe0xwEREqtB7Yx0a6wmiLLburGXKRg
	EezK3+hT34Sl2XliielCz6uHUCK+/wA6gHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783979722; x=
	1784066122; bh=gYP2szqcfxjzvBYgERd2uqAN7eFGDxn2M6xg4V5MZ0k=; b=g
	isY2Nf48NJpTMPTsDVfV+/Cn7KZEV46q7xiHAQvlwaJJPjuCC+ZuCbr65kSrt5R0
	7MjbBqjrm9Tbos7bQAZzeG2q/hFbzwy0bEYiGnkOEQigifYbbrpNJL3LXPFI2S52
	uphjatMetzciqzA1MwhTsBOlktqX5Hzgp2RZh7cXMDmETMmFXnHMlGeskcMB0P/M
	GvuXe808XOXwgiut3ukPxRQgjV/nU14cziXtXl+5tH/6ar287CLtNE+LgfszaVbn
	TTRwGrVEa4egUTRqxmkDs01pW9bdLCW1fslyCGakFPCzWzMWKLrRT2CWfS11rfpr
	qRX7wYMFoTeYmCJpU1pSQ==
X-ME-Sender: <xms:yV5VaiQBk2bhvVuHZloc8Iv6Vzwm7pJP_JjewqUJFaYxFpc6YL0aqw>
    <xme:yV5VagsuygiQaeVUbTNDrbkGUvPzqtzmrGEHCrcypbFnLUlNTpAho8hYF71Pr5e_j
    0elJu7_pFEtZADOEMtdcssVEkpzFQCQWDGkjwsFe2AIjtI3mA>
X-ME-Received: <xmr:yV5VarbE0LWBSRj-AZzTSlToafT6fA3WE7i6yM7ViJtmDi-zL7_-0rUHYzdrLwAANiOZGlJfSxCmdWqPTwTUKs6nnmMf8GQ>
X-ME-Proxy-Cause: dmFkZTE/Xb6jgnOYG/CxjGGtFKdJVvbLayntAGX/BCmMCtpnTJkiA6hBknhi939mGvVO47
    dn45ELHs2VdpU2K2PUUMOqODqJ7WoNuzT4RQ8zY0kiBpvMuloH/IzQf6ek1CdGljjrwF90
    S8Yl6dgBvZWcSrEFXnplBohh02JXjOEfXm55Tz4JDVScXnODYQlBLp38qUZsGwAYwEHxHd
    Y7rFtT1aKkTzCnsrbHvoDas9tku3kx6E24x5TOFmoVMDKLkJRNCwzx+6hynesfImNmbJGL
    YN2480TtSGsKg8MGiyXERdWI+xtCs7dc1Z2FOYBiaH7p/hFH9xuqFufQuJWG4JQBgl/0Yt
    sN5uGKYbzMoPX7r1sQGMeLbq6f+frXSRygnRkaQlFAi9MQg72T/cRUWryLgHJ7oplpTHBc
    Bgbc0cljbkRJwuRs4+QXJaByVjJvqrNwfaDFzp5kMF4ESQGWkkvLkVp/MZgzH32mFkIyS6
    iv6xd7Mr/FpLoIf3bPUDQo6JpMlkh5plONJTSQsM42fosMvRXiFUyJIRjD9rXl1Knp6nUa
    /6LsmgVVXd8V8iIXZod4ZiHz7+L0u7n6TopFvwJC1TKPfRjmtMkcEWSAgUYqhlKyeS2SkL
    gMKRsoWMbGscJxPaG3PGCdq30AmNFbB1oCCLNVZnlCB7YiA6UcmJjoU+3cwA
X-ME-Proxy: <xmx:yV5VauGG2B3CjsLRUnW5t5GZr0vT6bFLHwjemMWGS-QRSJpXiFf6lA>
    <xmx:yV5Vanzujvz9eh-fDKKorcXJ06lZ2kzvI2hwFqkYGOQ-tYfb2sOIvg>
    <xmx:yV5VaoliXDmlWun9pjWE8P1Zfzr3bwFcERuWvwhr8EqTXbHf5Mwwog>
    <xmx:yV5VaonZnncVqhnN19GB-kTme2WdBbjcOHmNyUmPAZXpAEiwmhImCw>
    <xmx:yl5VajOn4LbNnVssUt7PLtIYMLs0UReSmfp0fd61_LSRO8nK-1PNggcw>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 17:55:19 -0400 (EDT)
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
In-reply-to: <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
References: <20260713060814.2849-1-neilb@ownmail.net>
  <20260713060814.2849-4-neilb@ownmail.net>
  <1899194169.820712.1783939194879@kpc.webmail.kpnmail.nl>
Date: Tue, 14 Jul 2026 07:55:16 +1000
Message-id: <178397971669.3371781.14361088370957076736@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 13 Jul 2026, Jori Koolstra wrote:
> > Op 13-07-2026 08:05 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > From: NeilBrown <neil@brown.name>
> >=20
> > vfs_lookup_open() is a limited version of lookup_open() which is
> > exported for nfsd to use - to replace dentry_create().
> >=20
> > It is limited in that no filename is given (thus no auditing) and no
> > LOOKUP_ flags are passed.  A few "intent" LOOKUP flags are deduced from
> > the open flags.
> >=20
> > If a non-regular file is found, an O_PATH file is returned.  This allows
> > the caller to see what was found and to return an appropriate error
> > code.  However if ->atomic_open was used, it may return an error rather
> > then provide a dentry.
>=20
> Stale commit paragraph.

Thanks :-(

>=20
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 89 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h |  3 ++
> >  2 files changed, 92 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index cb33a01d16eb..2143f759443a 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4562,6 +4562,95 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
> >  	goto out;
> >  }
> > =20
> > +/**
> > + * vfs_lookup_open - open and possibly create a regular file
> > + * @parent: directory to contain file
> > + * @last: final component of file name
> > + * @open_flag: O_flags
> > + * @mode: initial permissions for file
> > + *
> > + * Open a file after lookup and/or create.  This provides similar
> > + * functionality open_last_lookups() for non-VFS users, particularly
> > + * nfsd.
> > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > + *
> > + * If the fs object found is not a regular file then an error is returne=
d.
> > + * In some cases, related errors are repurposed to so that the caller can
> > + * determine the file of file found from the error.
> > + * -EISDIR : a directory was found
> > + * -ELOOP  : a symlink was found
> > + * -ENODEV : a block or character device special file was found
> > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> > + *
> > + * Returns: the opened struct file, or an error.
> > + */
> > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > +			     int open_flag, umode_t mode)
> > +{
> > +	struct file *file __free(fput) =3D NULL;
> > +	struct nameidata nd =3D {};
> > +	struct open_flags op =3D {};
> > +	struct dentry *dentry;
> > +	int error =3D 0;
> > +
> > +	WARN_ONCE(mode & ~S_IALLUGO, "mode must only have permission bits");
> > +	error =3D lookup_noperm_common(last, parent->dentry);
> > +	if (error)
> > +		return ERR_PTR(error);
> > +
> > +	file =3D alloc_empty_file(open_flag, current_cred());
> > +	if (IS_ERR(file))
> > +		return file;
> > +
> > +	nd.path =3D *parent;
> > +	nd.last =3D *last;
> > +	nd.flags =3D LOOKUP_OPEN;
> > +	if (open_flag & O_CREAT) {
> > +		nd.flags |=3D LOOKUP_CREATE;
> > +		if (open_flag & O_EXCL)
> > +			nd.flags |=3D LOOKUP_EXCL;
> > +	}
> > +	op.open_flag =3D open_flag;
> > +	op.mode =3D S_IFREG | mode;
> > +	dentry =3D lookup_open(&nd, file, &op);
> > +
> > +	if (IS_ERR(dentry))
> > +		return ERR_CAST(dentry);
> > +
> > +	if (d_really_is_negative(dentry)) {
> > +		error =3D -ENOENT;
> > +	} else if (!(file->f_mode & FMODE_CREATED) && (open_flag & O_EXCL)) {
> > +		error =3D -EEXIST;
> > +	} else if ((dentry->d_inode->i_mode & S_IFMT) !=3D S_IFREG) {
> > +		switch (dentry->d_inode->i_mode & S_IFMT) {
> > +		case S_IFDIR:
> > +			error =3D -EISDIR;
> > +			break;
> > +		case S_IFLNK:
> > +			error =3D -ELOOP;
> > +			break;
> > +		case S_IFBLK:
> > +		case S_IFCHR:
> > +			error =3D -ENODEV;
> > +			break;
> > +		case S_IFIFO:
> > +		case S_IFSOCK:
> > +		default:
> > +			error =3D -EFTYPE;
> > +			break;
> > +		}
> > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > +		nd.path.dentry =3D dentry;
> > +		error =3D vfs_open(&nd.path, file);
> > +	}
> > +	dput(dentry);
> > +
> > +	if (error)
> > +		return ERR_PTR(error);
> > +	return no_free_ptr(file);
> > +}
> > +EXPORT_SYMBOL_FOR_MODULES(vfs_lookup_open, "nfsd");
> > +
> >  static inline bool trailing_slashes(struct nameidata *nd)
> >  {
> >  	return (bool)nd->last.name[nd->last.len];
> > diff --git a/include/linux/namei.h b/include/linux/namei.h
> > index ebe6e29f7e93..86d657b24fc6 100644
> > --- a/include/linux/namei.h
> > +++ b/include/linux/namei.h
> > @@ -97,6 +97,9 @@ struct dentry *start_creating_dentry(struct dentry *par=
ent,
> >  struct dentry *start_removing_dentry(struct dentry *parent,
> >  				     struct dentry *child);
> > =20
> > +struct file *vfs_lookup_open(struct path *parent, struct qstr *last,
> > +			     int open_flag, umode_t mode);
> > +
> >  /* end_creating - finish action started with start_creating
> >   * @child: dentry returned by start_creating() or vfs_mkdir()
> >   *
> > --=20
> > 2.50.0.107.gf914562f5916.dirty
>=20
> I think it would still be sensible to check the O_ flags being allowed to
> be passed in. I get that nsfd is not going to do weird things, but if this
> is a helper that may be used by other code too at some point (unaware of the
> intricacies of lookup_open()) the context could help as we didn't go through
> all the normal checks in build_open_flags().

So we allow

 O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC

and should assert __O_REGULAR.

Thanks,
NeilBrown


>=20
> Best,
> Jori.
>=20

