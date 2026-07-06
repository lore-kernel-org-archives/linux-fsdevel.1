Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E701389110
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Jul 2026 22:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783377189; cv=none; b=ozTZF4ahAKKFYmteTzdfk4OcdsFC6tSTLD2RN3I+LbY6RRA1UU9/88x65oHT1CtWoXnFyNugr/JrXgYhbfK6n59MXbHSIbq/YyPB8cSBwZ1Jx65unC0LhY4PWzBG2YOqvG/6zvnakoASzSomreR5kboHtTtvduh6Pl+FKH2NqMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783377189; c=relaxed/simple;
	bh=d6x5aXsouUYJ2R6gZe/7V7EIijEyalChJZWZHRCr+wA=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=k6Di32eVOBIa3mWKiAK1lcQO/w/RiYAz5B+rPOuHMtYo/wPKUVRitSCihlEhF0DBHQnp0RaRH+myjLzdrBBPjLxo2Wu45gHN4887tJUrkmjLfs3Z7LVVns1s+FZ9btpZ9QxP1cadV4VWiAlzP353Ch5FM8+DTE7YDPrUoQy5Maw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ik4oI3Fe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KX8MttXS; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ik4oI3Fe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KX8MttXS"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 23D351400043;
	Mon,  6 Jul 2026 18:33:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 06 Jul 2026 18:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783377186; x=1783463586; bh=h93AkcpJm1mOpYXO4SLEktKUvXqhZ2+KlWw
	MA0doleU=; b=ik4oI3Fe8ATwdJGqx/hpW8KL/Rfr2mGK23pkZHIRdso8LuzO9yy
	1PN45Knyz99RLt8ETeAENAYaskdkF5UPmOwXFdQI//cP0FVOhRMHAWM5ih/IJk2s
	I0xep1ds4Z8AvhGnl0Kjh6ib0nJpWpgQQuIWzNAFjbc40dggN3zWg8yOzGq0EE6m
	sK+vkAFM/BIgEQwrqnpHTijwARVe/QRMps6kRtMrTuoe7gnUuQ8Fx9Lf0V/oMZEo
	LZWvjlj8vQyVJj/ynwdNau9d7Q/7pMYWZWarxvGfLMpwlDRhqv6QBxXBp1ktmt2V
	ZYGas91y+X5CqAN61rNyXCsua98k/XQnEWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783377186; x=
	1783463586; bh=h93AkcpJm1mOpYXO4SLEktKUvXqhZ2+KlWwMA0doleU=; b=K
	X8MttXSQqSKXmhCfGwIfvQSJ5u3nW8r9ncxWi+52mfAMIUj83du+Fkj6I8MbxPg4
	1ByY9CJa1HmUnVbDUTcXZRj10/ScNQTlM181EpB7bNCWl5RTRsH2mbjcLpeiv/qj
	rrTRsDOygoWD7w9pbsZCyc5czesg0OTD6HnI6fVPj7i5nRjkuglChdnyFkCCa5CR
	MpIfMxliDkoxiEKjJWX3NxEulRo/7jHK2JzfRzB0v9WEBHiwXj5WdWMkCETNlOgR
	KOPe6l3pUxt6U5zYrHvr9cq/emVLUBkcXzWwwRoSicd9IhzTjG0rITSN7MGExVgw
	u5fImdvA9HxqLaKy9MraA==
X-ME-Sender: <xms:IS1MagFoThSwyq5jPjvTJlfB1tg2SjJgPNQa51U9HG7kn10PQgti8g>
    <xme:IS1MaiSIu9nzLbwSHLyE_Ivv19yXmxsQHvss8i9tKZfxE_I7UicYoItjWjp9WQBkt
    eKbx5dislbFR6Lg7xyA19-02-hF8pGKJXCtZNXh9fr1whfaTA>
X-ME-Received: <xmr:IS1MaluXkkBhADTF6rg1FAW0IxxhofcQyNi-6wcaT7VGZv6pBrrKjdb70Pu8AQrFW5gUnAzeEnxb-lSIe-KjsocF1IbMuGQ>
X-ME-Proxy-Cause: dmFkZTGN55WnGXiNZoY68+aValxyEB/zHn5MrZ78WLxzeLzW/teiv0X6OSixUbniUEWQI6
    ulBamtOoSsPJB/YijL13SjOc+Fhu8oFTrDsWJTmG9i+etDrUHrN0t9jmZSBjEoM6LxISoZ
    yhPiaF81+TBxOanGObic/lMHO7WjSFvL6AfttLOjQPTalHz05noU27FSyNav5SOppH5N6G
    9palY+PdBpwmqG6CRQeaPss5XQvpJ9fY5Zbw9msy0mNmGRLRf89ndZyXcO6W6R/ymzbQRR
    nbPGXhJY2FLsCXwQtSa6S75pqvhe2IXj+XXLvALdEBccZNB60xrQCthM48LWDEJfrKfai8
    YqVgUyivuetSsUkAZgYAIjYw0ypA/72CLhuvc8UIuDJ3hQCNiISuALOjMsnQcRuKldKvYv
    n/NhduxY56yoA1R5l31JHEQKmz+OrgxoAerS5oqYoHInl7bbY6mWbS4drrdbI4LKrnzidC
    sGYrFa14XrFJMRxAAB8KIbLO90DKx6ZhsC9cmqhKsJPF3dwfRA7QxHXcd/VKX3SQxNuEpS
    HW/Q4l+MRjOjRfGce3JahlZUTejfqm7RsV6sm8LVjKosr1rbAXWq6yFQtc0l0Lrd/qY1Jl
    JuG5s/I3AOF6vV8bM8qkfyL67SIszC93dHXHSujmtSAzqIWLC2QCo6cW7axw
X-ME-Proxy: <xmx:IS1MaiJ1u5uIz-LazEnVwOPvqEAfx2If27tq-7xFTWGjgONtJruLug>
    <xmx:IS1MainGKHohAPz1v-em07cSbnaeKWTv5e04PUIva1FJH1kKSBqaew>
    <xmx:IS1MajKlHsXs7aqH_jTxphxket_-Yk0zAqtQHnCYNF2d2o1z1Q7OMQ>
    <xmx:IS1Man4RBYObJXEK3xi8kTzEO3K3QKVwXkWLC8p8cfZucOIzwfE2jg>
    <xmx:Ii1ManQ-ehhFWaKpok6yQJObVHgrE4AMIorZxrBD-_y20OPWyt9ILPSc>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 18:33:03 -0400 (EDT)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: NeilBrown <neilb@ownmail.net>
To: "Christian Brauner" <brauner@kernel.org>
Cc: "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v2 3/3] VFS: add vfs_lookup_open() for nfsd
In-reply-to: <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
References: <20260705235447.1322365-1-neilb@ownmail.net>
  <20260705235447.1322365-4-neilb@ownmail.net>
  <20260706-steril-fragil-worunter-f48995ef1b29@brauner>
Date: Tue, 07 Jul 2026 08:32:59 +1000
Message-id: <178337717986.27465.590457544263750759@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 06 Jul 2026, Christian Brauner wrote:
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
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> >
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 1ca738401afa..002ffae7083d 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4568,6 +4568,76 @@ static struct dentry *lookup_open(struct nameidata=
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
> > + * functionality open_last_lookups() for in-kernel users, particularly
> > + * nfsd.
> > + * It uses ->atomic_open or ->lookup / ->create / ->open as appropriate.
> > + *
> > + * Returns: the opened struct file, or an error.
> > + *     Caller should check that the file opened is regular,
> > + *     if something else was found, an O_PATH file is provided.
> > + *     Caller should validate FMODE_CREATED if O_EXCL was requested.
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
> > +	WARN_ONCE(mode & !S_IALLUGO, "mode must only have permission bits");
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
> > +	} else if (!(file->f_mode & FMODE_OPENED)) {
> > +		nd.path.dentry =3D dentry;
> > +		if (!d_is_reg(dentry))
> > +			/*
> > +			 * allow caller to see dentry and choose
> > +			 * correct error code
> > +			 */
> > +			file->f_flags |=3D O_PATH;
> > +		error =3D vfs_open(&nd.path, file);
>=20
> Imho, that really throws a wrench into this function. I'd rather just
> fail with well-known error codes in that case:
>=20
> /* directory */ -> EISDIR
> /* device */    -> ENODEV

What if the dentry is a symlink?  May ELOOP could be used?

>=20
> Also, why does the caller need to know details here? Because of the
> O_DIRECTORY work? But even so, EFTYPE would be enough afaict, I think?

fs/nfsd/nfs4proc.c:


	if (S_ISREG(mode))
		return nfs_ok;
	if (S_ISDIR(mode))
		return nfserr_isdir;
	if (S_ISLNK(mode))
		return nfserr_symlink;

	/* RFC 7530 - 16.16.6 */
	if (minor_version =3D=3D 0)
		return nfserr_symlink;
	else
		return nfserr_wrong_type;

The spec requires specific errors which are different between versions
and S_ISLNK seemed problematic.  I thought that keeping the VFS
completely out of that issue seemed best: simply return the dentry found
and let the caller handle it.  But if you are OK with ELOOP for symlinks
(and EFTYPE for sockets and named pipes), or can suggest an alternate
error code, I'm happy to work with that.

Thanks,
NeilBrown

