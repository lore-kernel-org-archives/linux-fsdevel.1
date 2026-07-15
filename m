Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA8143F0BB
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 22:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154904; cv=none; b=dT2cmS0/QBSs6prbGZl2TLN9e7FLNFV5u27rdzOd37376qCbpMq40q0MQzbk8ZWtGSxcSz8kayJq6xFlrDR7rjy3JBXYRdp8FGc/sWuEYgFzinEvczjsQhC9wsMIrAiiZXnK7ta0VSDSsgwyL5xmuT+LbW2YTTOEcVjcHrRdhFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154904; c=relaxed/simple;
	bh=pIaFaY5Iiz71qn4BKa8wtlpfYId8SSey21vO+O1q4xI=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=By5bc9EJz1C6yzC6rdWxGmppd1I1u6m+Sfpgsple5YZHZK2rcudRdiqZM0XM1BDfgdlcw1qA4lnpHuOQnGVoVplDp7m6Z+DMoZ6ofUFq0hz8BEUguYHkGdxhhoCvjUasdJJ+znfVWGGRQD4Mq5CBeBM/ORbdMBjbz2QoDwxrHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=LKnUrQw6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ey+3G9KA; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="LKnUrQw6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ey+3G9KA"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 683C51400042;
	Wed, 15 Jul 2026 18:35:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 15 Jul 2026 18:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1784154901; x=1784241301; bh=Rm423EHpIygrDimxovtTT3Hfegd/TT6ZZqy
	UMB9UYxk=; b=LKnUrQw633VVBnK9PzOwETzCmwaPESDTT23i1maRAmWaJGmIGlq
	1Httv/jCl0/wzMLHbnff6nvCNg86MQYWv5Rk4c5hMlgMEFbDDJDNPR3Nj4RHofTB
	ciuO8ItM2/RJC2XMxZ0j64m1RDUk8hdMG5K6cVtNiXr/2T+MqB7kfUzGtiEp8y1b
	PxW0igV6V7tGxlYPqBLBjkIGTPY3KbgCaaN/wdZGfKTJMFl9ctAbhRazPr+mcWyh
	/BwKQJh+/9ExMqTPD91yibvbEZJnyMEgOAa78HKyFJH1YY1QHnyw0A8+TGoHHlx3
	f0C9aJaAB1IIZhZal/4Zdjytn/QzmAU7mmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784154901; x=
	1784241301; bh=Rm423EHpIygrDimxovtTT3Hfegd/TT6ZZqyUMB9UYxk=; b=e
	y+3G9KASOkCrvUm/XOnAw6tAOX4m5WfvvpKtvxTpnL3on45ZAi+rVEHPHfErZDc5
	9mJw5hj8QoiYVkP1upnSXR+DUrDQY1ZVNElg8B5zjMNjNbX9F1Ci6zUD77Q2mqRe
	hQgW7ZnspqXW8ODdk3aRBU9+apeViqjRqxLY5Nu0W4DNbLFiqITYK9e0JDfmVg1E
	E3ropKSBfX5CRjmIir8xBBVdxb8YwCDmNyMjTkVb5yUXmhW9eHldIevkKtKyLcha
	7eHTj1KvNAjvC8jq3ZtlzC5vKbAep8tUb74wql+22LXeX/KtxoM/5/l1gCszaPcT
	vjgOCybySMg3gjrSA3oNg==
X-ME-Sender: <xms:FAtYasfuDJF_BJzYocqGWMd3HbaWbypE8QuV2slrAG6tqIpracytCQ>
    <xme:FAtYanLOeBbDkKfwj5Dk0Em1kV7KGlXmwxzJwlD2h9TV0Y8zj-3pQrY2sxWjDJN50
    UfkceRYw3Hgz5fx7PhuAF5jXdxd39vEcOHL4NGoq55m_nzOHg>
X-ME-Received: <xmr:FAtYapGaO55me7wyWPV-WUK-xhw1qLNKPMgtbF1HFrr-M1wPmEXNBgPHSk5d8n5yr0NVgiG8PAluzWKppC1J3aOe0U_Koe8>
X-ME-Proxy-Cause: dmFkZTFYrln61kPRoPgTROBfHCYfX4KQ8rZ/pU0k7TfIFCOH61JslOeFGFmCQkTd+JAdPz
    ueLu2qRvHDnXqLAPBCS8z6MRZen7IlZh31OwiKfXymClTexsM2ajUAgqDn0yTmYJr/CFMQ
    BXgGXiURiJqkwpiMImcpIpbPv5GnNmjkKbbHlWpxGJxMzZmn/uSX5w3vgRlv2rBTm6wYW0
    eJf8jlHBB6qhqDL+XuzGgXziALA/37kLIlj7eFCCAtbolBSwsW39VhTvr9Hjjos9ri3VwW
    Hcbr5tzfNYvizbVb0TZi7XSeNPpr5wC8EmrS96YlSD66KPA4BPF6zRbtdnRE5Z05KLi1DQ
    lxv5GCGTv7/QKuUwSNp5kzG060P+GSjQJw3g/aoH4EJBw7HYnLUSul7Qpe7t5d4E8U1z50
    F7+jGiZ43oPa/hbpW59jbsBSoFAcoggXTg2BrlCAm8HFIPQdH4lDjFDSWw5NhnzWX+5/zF
    zg4WXe/LiNji810sAmJyzQvgr2r+FYD1hWT5xVCdzbCfjNjp1Jy74oSjOk7orrmHT1kGP1
    P6NDU2Vfqr4CWD95Im/D987840ynCsrFC2YSfCKLHXzDbvQiynIJE0QlpyfySbBZnvN7Co
    SG+CL9EaShF2mSNWHxuIXgXmUjsg5az6B2ippc9kscFJEhg/RaRqnA4F0n9A
X-ME-Proxy: <xmx:FAtYaiBXXB8b7d-oK6ySC7SVWfhpBr_U2sOG4-GW3P_40pX4elKQtA>
    <xmx:FAtYak8z26oSSbzBlHitbKlk_umLA2qivuPfIbRjmY8YY8Xe5JLouA>
    <xmx:FAtYamBCL2J-ocWTMF8N87CWcHpXpDFhgRyFjZgXbVMr9h0BuRdu8Q>
    <xmx:FAtYahRStxr4FNeOPnmGHtkQzzbiqpdbc_AFDzp0VkyRWl8LF7Klkw>
    <xmx:FQtYanJO0LvDfC64FVitHMvOjdzWLrBwn2PnUIuhO_VVDfCbSqKVqDwt>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 18:34:58 -0400 (EDT)
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
In-reply-to: <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
References: <20260714230534.776886-1-neilb@ownmail.net>
  <20260714230534.776886-4-neilb@ownmail.net>
  <21817263.1168614.1784151799976@kpc.webmail.kpnmail.nl>
Date: Thu, 16 Jul 2026 08:34:56 +1000
Message-id: <178415489698.3371781.5121934606972521996@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Thu, 16 Jul 2026, Jori Koolstra wrote:
> > Op 15-07-2026 01:04 CEST schreef NeilBrown <neilb@ownmail.net>:
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
> > If a non-regular file is found and appropriate error is returned and no
> > file is opened.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c            | 96 +++++++++++++++++++++++++++++++++++++++++++
> >  include/linux/namei.h |  3 ++
> >  2 files changed, 99 insertions(+)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index cb33a01d16eb..630f93608224 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4562,6 +4562,102 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
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
> > + * In some cases, related errors are repurposed so that the caller can
> > + * determine the type of file found from the error.
> > + * -EISDIR : a directory was found
> > + * -ELOOP  : a symlink was found
> > + * -ENODEV : a block or character device special file was found
> > + * -EFTYPE : any other non-regular file was found, such as FIFO or SOCK.
> > + *           or ->atomic_open responded to __O_REGULAR.
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
> > +	WARN_ONCE(open_flag & ~(O_ACCMODE|O_CREAT|O_EXCL|O_TRUNC|__O_REGULAR),
> > +		  "open_flag has unsupported flags");
> > +
> > +	mode |=3D S_IFREG;
> > +	open_flag |=3D __O_REGULAR;
> > +
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
> > +	op.mode =3D mode;
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
> So I am not really familiar with the nsfd backend where this function will =
be put
> to use, but I imagine you need the fileserver to mirror operations on the c=
lient.
> And since from within the kernel we don't do syscalls, we need this functio=
n to
> mimic the client syscall path and call into the actual underlying fs. Is th=
at
> more-or-less correct?

more or less.

>=20
> So then the rights checking happens on the properly authenticated client-en=
d? Or
> does nsfd have another mechanism for that?

Both the client and server check rights.  The server because it cannot
trust the client, the client so it doesn't waste time trying things that
aren't permitted.

>=20
> I just want to ensure that using this function cannot bypass the sticky dir=
ectory
> semantics, as that now is the task of do_open(), which this skips of course.
> If that is OK, this function LGTM :)

It appears that may_create_in_sticky() is only ever called AFTER the
file has been created.  do_open() is called after open_last_lookups(),
which calls lookup_open(), which calls ->create or ->atomic_open().

I wonder if anyone has tested that code. Maybe I should...

Thanks for spotting that.  It doesn't change the validity if this
present patch series though, it is a separate pre-existing issue.

Thanks,
NeilBrown
