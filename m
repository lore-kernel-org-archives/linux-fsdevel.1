Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF70B175A60
	for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2026 22:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784329159; cv=none; b=QtxPyDzXFLqwnI/Knm9su0MEBlbb+0Fml3wIysfXyrUoT/Z9NcFMbGq320uphdM4bkMobxOdBHnNapjToAYcLycdeMBs4WU3BpEITL/EEzLQqB5/6oSvqJmtRrGJezs5Jm9jaENYojKRun3es+zpAf1MfXgG1pZ70H+zNunSu14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784329159; c=relaxed/simple;
	bh=yKsqcucZS41V9AZHgiDHtFybOZXusxuMmkEt1TnIB14=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=VYuMhUdefVWvdsKN1oj4Kuj1oQmT1T6Ct4+/19D/FhZtYZqytEC0hvfaqGiz5JETUckAjUHTwkAP2dZ6j5pRzugDswEk1PJf38+b/Aq1l34H+ieG4MAG6CQ9iXRugIB7XTPC8xUqTzF275mg6JQQZjsDH/2427siC5C0iJsTgaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=PbtKTfaa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VYjA9jEk; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="PbtKTfaa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VYjA9jEk"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C715F7A0115;
	Fri, 17 Jul 2026 18:59:16 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 17 Jul 2026 18:59:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784329156; x=1784415556; bh=OGFZbLSNY9pbWsl93hmAzdmKPkBFtOhRlNg
	iiZqU1fo=; b=PbtKTfaaTpcBrRdtxJDHbnnBfj/UI2aCgIOfnrQxpECUDBh71w5
	+Q/QNY5qwGrCPuVidnkI53N1/g/bcnIyhYqduxRUa+efpbh4THZUjGKqJ85uDzZl
	I9zsRYHpfWNnzp1TaDAwZes0HAvfdM1qNARUnmm3wGK5BaX7k4YuUHuOftsQSWSO
	rY4o68xSSCpbmiQG4LFIdIqRieMPR3yHCpCdmIz9jj/flZCyPnO8b7ehaAE704SA
	V3SpsVYPWQdK3GNmzDYeNfeLEYFuPQLwGnlLnYuJ+hD/TaeXB2SZSftwM+5vF+3C
	fDChS6+AQ2FCxk4iAdM198DuYrfMWkgRYGw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784329156; x=
	1784415556; bh=OGFZbLSNY9pbWsl93hmAzdmKPkBFtOhRlNgiiZqU1fo=; b=V
	YjA9jEkVhsVa6FEmgELOZv8GMdQZCGsF5RQMU7ydzkVixAv4Bgd+PMSqcV5M1+9E
	Y2UoJiL0NBWJDrCeptCu0eCX13gPN/FDwcr4OAZJbl+xZvLI1bwuah5U7WFeH8WA
	9pUiXqEo6O/yKt4+HgWpOlT0L6kGvNwbDjBNx8DsrNRPn2D6flsFfZnKOEba7oeZ
	29aO9NRMeUPjRAfh0dgonVfBxvNzKdKwB24prYTIzy5Nc+m8JWOlpk+2Xz4sr7/T
	w2yPWDj4qeTbChyx6LpF0s+ZXsatlVMYnsob9+leOtsmfw001xTjUySGctk7i/sf
	ZlFlyZ1/eTGl1swtJdOXQ==
X-ME-Sender: <xms:xLNaahXpmbpWGTA40qbmBXw22fOoixjQ8o_l40Cj-YNPqckhDDKt1w>
    <xme:xLNaaqh1SdTUc3BhH1wHeRI0egjamZqlzfhhfYiH8_O7sfVP182QTc2UvdWZvFVF-
    p2pyp1eyV--gOwKH32Lg2LHKzr4TPYqPszyIWVHg3jxSwq2Z6I>
X-ME-Received: <xmr:xLNaao9QFeBbdhrkkanxTVLhRulY27eMwrumNF-Hr5YSHRRbJpKeLx-5b8uAd9Rcx17sPlq6tyTpwVjMMnYWXvPoYCjCRio>
X-ME-Proxy-Cause: dmFkZTEuxD4kHEEla12c70rbsl3cfAetdCvmQWQIMZjnTVUOvWQqmu46vh+J0xwYyrSIkr
    KYdY7IIsGzT5NxKTSVye3ocIHt7I6xv8cWMmKmN7ZP/gJdsn9y2Dhs5CtAoCU/INkM9vxm
    TUWMMueW54M9WsMxpEqUXtOWjQGdOglWeqhga4Rb24UOIf3QT4YBahWkcaIQxIL1EFVkPc
    mZs0Kb3yW6FFkjvRnjQcCgT57GVo8Zpb0zygn1SsNANGt21nm7i3vtXYS8cSKtk86Nox5n
    aCdCV2Q3k52fjtXerdj9jCxm0LwRnr29df7sxcdbv6N2SdAzPegMFTEuWTMenw7fhzFyKW
    6iQCZYEdlw3kPr8HAE5D9g4RWtw0bauQPJ1eq5P3z23sPapkUZAM6oQFaQC29KIkgJHy6a
    jU1+nA7G34oQGNh/Av0e3odrFaEBMBzTdTcTWeyh0/tLIr2nltCD4LxSrj9S4s1rLzHx2c
    TRLcPKnV/neoYKirEVeChFvM+D+p0ygmLMyK4Hjip7THHPtKkl9CnPctYYvzx55vDM4HMO
    fTtZk6WO6sOK54V6RkStA+M0TCJPA7uFTjykunJbj0ddV+XvcrP8C7GcXIit6kjVfzlmOv
    mO2NDt2sLCgC+JZUvjWa+tttaMd0wSBek0uqgFPcBVZpn+FCfQKUPxg4F/cA
X-ME-Proxy: <xmx:xLNaakYIucw2C98DTe8Mk8BVohoslB8wVRuDMLwKyil2hRCSozXguA>
    <xmx:xLNaan3EggVgWAn9EHlCnRrrBX85P_TvMNQtrytC-R_JTg0tv4JKJQ>
    <xmx:xLNaavZmX0J4qDLAJuNApIfBc9X4-vKIs_lh4_FYA0lqIDVqZ9cCzw>
    <xmx:xLNaavKpXZ5CGJTKsqwlcLvrAZeCbbdujAOHATDxc5IcANYncvFzYw>
    <xmx:xLNaapiViWZSPAVb6q_hcxiDEr29W_M0OM78DOPwjbZ7cnLcDbleb5P2>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 18:59:14 -0400 (EDT)
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
In-reply-to: <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
References: <20260714230534.776886-1-neilb@ownmail.net>
  <20260714230534.776886-4-neilb@ownmail.net>
  <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
  <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
  <1697164687.1184851.1784159287934@kpc.webmail.kpnmail.nl>
Date: Sat, 18 Jul 2026 08:59:10 +1000
Message-id: <178432915017.3371781.13946671241977454321@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > Op 16-07-2026 00:34 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > > > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
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
> > > > If a non-regular file is found and appropriate error is returned and =
no
> > > > file is opened.
> > > >=20
> > > > Signed-off-by: NeilBrown <neil@brown.name>
> > > > ---
> > > >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++=
++
> > > >  include/linux/namei.h |  3 ++
> > > >  2 files changed, 99 insertions(+)
> > > >=20
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index cb33a01d16eb..630f93608224 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct name=
idata *nd, struct file *file,
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
> > > > + * In some cases, related errors are repurposed so that the caller c=
an
> > > > + * determine the type of file found from the error.
> > > > + * -EISDIR : a directory was found
> > > > + * -ELOOP  : a symlink was found
> > > > + * -ENODEV : a block or character device special file was found
> > > > + * -EFTYPE : any other non-regular file was found, such as FIFO or S=
OCK.
> > > > + *           or ->atomic_open responded to __O_REGULAR.
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
> > > > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULA=
R),
> > > > +		  "open_flag has unsupported flags");
> > > > +
> > > > +	mode |=3D S_IFREG;
> > > > +	open_flag |=3D __O_REGULAR;
> > > > +
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
> > > > +	op.mode =3D mode;
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
> > > So I am not really familiar with the nsfd backend where this function w=
ill be put
> > > to use, but I imagine you need the fileserver to mirror operations on t=
he client.
> > > And since from within the kernel we don't do syscalls, we need this fun=
ction to
> > > mimic the client syscall path and call into the actual underlying fs. I=
s that
> > > more-or-less correct?
> >=20
> > more or less.
> >=20
> > >=20
> > > So then the rights checking happens on the properly authenticated clien=
t-end? Or
> > > does nsfd have another mechanism for that?
> >=20
> > Both the client and server check rights.  The server because it cannot
> > trust the client, the client so it doesn't waste time trying things that
> > aren't permitted.
> >=20
> > >=20
> > > I just want to ensure that using this function cannot bypass the sticky=
 directory
> > > semantics, as that now is the task of do_open(), which this skips of co=
urse.
> > > If that is OK, this function LGTM :)
> >=20
> > It appears that may_create_in_sticky() is only ever called AFTER the
> > file has been created.  do_open() is called after open_last_lookups(),
> > which calls lookup_open(), which calls ->create or ->atomic_open().
> >=20
> > I wonder if anyone has tested that code. Maybe I should...
> >=20
>=20
> Yeah, that is the correct behavior, I think. may_create_in_sticky() is a bi=
t of
> a misnomer, really it should be something like may_o_creat_in_sticky() or e=
ven
> may_open_in_stick(). Afaik it's optional hardening that really should be the
> responsibility of user space: it's to prevent file squatting whereby in, fo=
r instance,
> /tmp an attacker predicts what file a privileged user will O_CREAT open. In=
 that case,
> if the user application didn't use O_EXCL, the attacker may symlink it in a=
dvance to
> say /etc/passwd, or do other nasty things.

Ahhh - I see.  As you say it is "O_CREAT" rather than "create" that is
relevant, and whether the calling process owns the file.
  may_o_create_alien_in_sticky()
is a bit long.

This functionality doesn't protect the filesystem, it protects the
application.
Now that I understand that I can say with some confidence that nfsd
doesn't have any interest in it.  The NFS client is in a positive to
protect the application, it gets this protection for free.

So nfsd doesn't need to be concerned with the stick-dir check.

>=20
> I presume there was once discussion about whether this should be kernel res=
ponsibility,
> and that's where this line is about in link_path_walk():
>=20
> 		nd->dir_mode =3D 0; // short-circuit the 'hardening' idiocy
>=20
> Or is that not what you meant?

I think that line it to handle O_EMPTY_PATH opens where the directory
might not have been seen.  And certainly we don't always have agreement
about what hardening is appropriate.

But I was only thinking about "is this something that nfsd needs to know
about" and I'm not confident that answer is "no".


>=20
> > Thanks for spotting that.  It doesn't change the validity if this
> > present patch series though, it is a separate pre-existing issue.
> >=20
>=20
> Right. I was just curious how that behavior is handled in the nfsd path, bu=
t you
> are right that any issue there is pre-existing as dentry_create() also does=
 not
> do anything special for sticky dirs there.
>=20
> I'll review the patch tomorrow, it's 2AM here :)

:-)

Thanks,
NeilBrown


>=20
> Best,
> Jori.
>=20

