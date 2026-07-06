Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EB83C10B3;
	Mon,  6 Jul 2026 23:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783378977; cv=none; b=mL5FqqiWbPDrnbwJXYA/ZHoUtadlMQWhGuQLpjcPu/K/ZaIsDsRpGQ/eTdchV/Kabql/64Y2SOHA7Ep9drtrfWtcaNuyVmxcF5rdaM2VLgaZzc81k0SOFJCiWtJBhvkwRGiMBTMVvH1DsPuL6uA6FSV5WmZnpm8d03XOdy/SQxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783378977; c=relaxed/simple;
	bh=4JNre7mKevnsAAlGyNAVhlTMHT0ZwkA+r4j3Ktsnpu0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EAWhlda5p8gGbif07rd6jSeE+DlwvDzk0XAM+5HU+IFum66k9Q0Lm+oFDSqyWI6GDl1lQYmm3T6JP/16Ev7CLfwhPfa4zMegwC8oZnXbO0cKyEEquamPl5/8EC8Yc889HasZvtgjg8sy/QqVGrbdVEjYQEMdHTuD1P4MnjypMdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Gnea10ri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B+3I5uED; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Gnea10ri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B+3I5uED"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C4121EC0079;
	Mon,  6 Jul 2026 19:02:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 19:02:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783378974; x=1783465374; bh=pgJZ7ysRQ9r1ny4uD1qhi/ZDvsRiJjE6sRx
	2V2bukUQ=; b=Gnea10riyxWlZ69XxTA0S8iJt45HdEHAoJqjQSLSEebk/cYOMOr
	3iU3vK3JyjFcJ7lkMGthfFOhvRvOj46GnlEMG88KRvOjHAyTsc/+FZ9uQ7sgB5lb
	TCU2ZYjXbDr6B2RGYsyN8R8MDWUjOYkLr77IAKDSNzL/evEtfZ5SM+P1STp8tMLs
	puKmPjwQe8ygItUrl/AM8J0vEmre38UlQUOnvOmfOIdz526SYJ6lPSmlCcw7WYVS
	n8Dk4uDTjsQ3Ad/XHrjg1jP12YuJuU5IeNezc5ZvDIHiodlP3/bXV8lGABNnRBoV
	kGl6kuivi4KouhwM2i0pNaog2hitKjI6Cjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783378974; x=
	1783465374; bh=pgJZ7ysRQ9r1ny4uD1qhi/ZDvsRiJjE6sRx2V2bukUQ=; b=B
	+3I5uEDdZSTU5HvlxqUzTjH1Lg7eDHQxWz7aOXPiUINKhY7R+kCwAy12aRvFM+OO
	z8jfia2n1OwByxNQE+INJQrSd/IdJ/hreqTtutNmLp+7KEfgLPNz+cTIiU2scpss
	3EjU5xA4KjmzRk0wzHm6mH+nEwHZblAkCWVX8/30w3Qr8gQEy8M9BBDpYbPOB9yO
	9EJcEJpO3gqXaBcnQ8VzaNKvrXM4vRcgiSGRGTaSdS4XwoOkqrm6hgw350KSaOUz
	OoitsPHtIz3JSTY4YJMlcsxJ2p9n/UgtcImtxwuwrd1f6XbBS5pqsdh5PXKvoFSR
	VEhOIWUFW4ef9KJ+sJx+A==
X-ME-Sender: <xms:HTRManZoCRzdx9aGBQ1DCrhzwrYsG_6CaaCrVGqUw8EvbejVwO33lA>
    <xme:HTRMai9lb3zD7v0WEO-h_XgxY-l8N1FI0hV4gemU9q_w1x9FFBjhcYSTXn2GyK4NT
    X0t0mWm--dIBAFNhnIsKvRvPrGjMJeozjiifmvD9Z5BSQXqSg>
X-ME-Received: <xmr:HTRMauaHUI2VtuKy9UOzFlPlvjP2AReM_B9226WKq5itFuXUXovb_gi05KeaLLIzmKkBOiP5CTbAZmmaHJ4itnUuer-dDKo>
X-ME-Proxy-Cause: dmFkZTFLJ1kpcKC2knDz1hiuF057O2M2gf7P0+MxqhAdp8xjXvJASg4o7YR7B5bHZyCYal
    UMBIKf63vu1CPHjcuWSWUBrcaUKVJKM5bzvQsf9FDuO7Ht6A3wbXdDG/zQIUFaOHH/IMHc
    ITmb8GoZkbtH5az9w8GYc26CwsmGTeoKft765495++v1PxF6OvU6eRdOoidA+3B/h4vB9C
    AWh6oKqngWgUZM7ShrOfSdIKXOEWUAEN3/+1s8sSLBQ8f/94zyP54mSQiaUMj+a8sGDaFo
    g+G8XLcQO7i1f4KVA3L0rXMOSmc1ZrLw5+Uf8090+SfdxB2kCgJrFwJNq7yw1DKDXz4Isw
    9P6VNP0GYjz45Da6OxSPaz9VNAC6KVLPO3Dl2eOmf7xaLHmKAFDzxWgU8+WWsxt5v/fVFB
    PY5HFylNNAGGqEhcKL1eonJ1hC8EaamPsd5/oGV3huRPfmpuPdprHpJPfI24tUpgkJEebd
    bOkUoA0Yq1/nFDMPHtKws1AZ/lz8rdaZNTjN2w8nyrmZCKaTFyaAqh8aMREZqA7nJA6xM+
    1FsJCNo8R8HnQwIjJYpxIprLHc7WMunNkGR7CWLj22bCE0bnCfZh5k9kMgF7bmiTRojI/H
    MRifCBt1OMS7A2SKjIUVIZPrnbTZl3Qpybr/lz/OK8YfiZlvlBftUP+4rvew
X-ME-Proxy: <xmx:HTRMakeC33HXJ9wIjDJcOLGPWgTLq4chqkaMPSBnYnEriZ9XV6fwMw>
    <xmx:HjRMajkayFI7_qIJkLS-ktAIpvhnIKZD9ZoVuJwADT_QwVSxohAk0A>
    <xmx:HjRMas3XUHrtuucQ3ktOxOev37xiNFC9qO7VGjjJIsWmmvYQE_4JyA>
    <xmx:HjRMakd5CgEYmDO2AZ0LF8-7VBIiagX3X-hyO6xguUZG51ABkbtUhg>
    <xmx:HjRMaksPeS-Toiq8lllBLNCN7vPiIqf6XRHIklndM72nkDfxI0BX4dVb>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 19:02:51 -0400 (EDT)
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
Cc: "Jeff Layton" <jlayton@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>, "Al Viro" <viro@zeniv.linux.org.uk>,
 "Aleksa Sarai" <aleksa@amutable.com>, "Amir Goldstein" <amir73il@gmail.com>,
 "Jan Kara" <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/14] vfs: call audit_inode_child() in lookup_open()
 on failure too
In-reply-to: <110549453.130215.1783372824255@kpc.webmail.kpnmail.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-5-jkoolstra@xs4all.nl>
  <178331600416.27465.18425637255026621428@noble.neil.brown.name>
  <110549453.130215.1783372824255@kpc.webmail.kpnmail.nl>
Date: Tue, 07 Jul 2026 09:02:49 +1000
Message-id: <178337896915.27465.4232973361763487091@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 07 Jul 2026, Jori Koolstra wrote:
> > Op 06-07-2026 07:33 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > On Sun, 05 Jul 2026, Jori Koolstra wrote:
> > > audit_inode_child() is called in may_create_dentry() so that failed
> > > filesystem operations still register an audit entry. On success, the
> > > entry is overwritten when, for instance, fsnotify_create() is called.
> > > This is the calling convention in vfs_create() and vfs_mkdir().
> > > In lookup_open(), however, when atomic_open() should have created a
> > > file but didn't, no call to audit_inode_child() is made. The same is
> > > true for the regular ->create() path.
> > >=20
> > > Fix the calling of audit_inode_child() in lookup_open() to match the
> > > vfs_create() path. For the ->atomic_open() filesystems this logic has
> > > been pushed into atomic_open(). This function is also reordered a bit
> > > to make the case distinction of the possible returns from
> > > ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
> > >=20
> > > When retrying delegation breaking, audit_inode_child() could be called
> > > more than once, but this is OK because those entries are reused.
> > >=20
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  fs/namei.c | 75 ++++++++++++++++++++++++++++++++----------------------
> > >  1 file changed, 45 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index ee47d3f5159f..956adcd14c4a 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -4369,10 +4369,11 @@ static int may_o_create(struct mnt_idmap *idmap,
> > >   */
> > >  static struct dentry *atomic_open(const struct path *path, struct dent=
ry *dentry,
> > >  				  struct file *file,
> > > -				  int open_flag, umode_t mode)
> > > +				  int open_flag, umode_t mode, bool create_error)
> > >  {
> > >  	struct dentry *const DENTRY_NOT_SET =3D (void *) -1UL;
> > >  	struct inode *dir =3D  path->dentry->d_inode;
> > > +	bool failed_create =3D false;
> > >  	int error;
> > > =20
> > >  	file->__f_path.dentry =3D DENTRY_NOT_SET;
> > > @@ -4382,23 +4383,33 @@ static struct dentry *atomic_open(const struct =
path *path, struct dentry *dentry
> > >  	d_lookup_done(dentry);
> > >  	if (!error) {
> > >  		if (file->f_mode & FMODE_OPENED) {
> > > -			if (unlikely(dentry !=3D file->f_path.dentry)) {
> > > +			// finish_open() called
> > > +			struct dentry *opened =3D file->f_path.dentry;
> > > +			if (unlikely(opened !=3D dentry)) {
> > >  				dput(dentry);
> > > -				dentry =3D dget(file->f_path.dentry);
> > > +				dentry =3D dget(opened);
> > >  			}
> > > -		} else if (WARN_ON(file->f_path.dentry =3D=3D DENTRY_NOT_SET)) {
> > > -			error =3D -EIO;
> > > -		} else {
> > > -			if (file->f_path.dentry) {
> > > +		} else if (likely(file->f_path.dentry !=3D DENTRY_NOT_SET)) {
> > > +			// finish_no_open() called
> > > +			struct dentry *replaced =3D file->f_path.dentry;
> > > +			if (replaced) {
> > >  				dput(dentry);
> > > -				dentry =3D file->f_path.dentry;
> > > +				dentry =3D replaced;
> > >  			}
> > >  			if (unlikely(d_is_negative(dentry)))
> > >  				error =3D -ENOENT;
> >=20
> > I think this can now be
> >    if (unlikely(d_is_negative(dentry))
> >          error =3D create_error ?: -ENOENT;
> > or something similar if people don't like "?:".
> >=20
>=20
> create_error is a bool, and the caller still expects -ENOENT because we have

Oh, is it?  So it is, I missed that.  I would much rather it was an int.

>=20
> 		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
> 		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
> 			dentry =3D ERR_PTR(create_error);

You wouldn't need this 'if" any more if you made the change I suggested.

>=20
> > > +			if (error && create_error) // should have created, but errored befo=
re
> > > +				failed_create =3D true;
> >=20
> > Why have 'failed_create' ? Why not just put the audit_inode_child() like
> > here?
> >=20
>=20
> Because I am a doofus and didn't notice during several rewrites.

Happens to everyone :-)

>=20
> If we reach the point where you propose we move audit_inode_child() to, the=
n error
> is true and so we reach audit_inode_child(). Conversely, if we reached
> audit_inode_child() then failed_create is true, and this is only set at the=
 proposed
> place to move the function to. So this is indeed equivalent.
>=20
> The failed_create name is terrible anyway and it tripped Sashiko over. It w=
as meant
> to convey rather "we know for sure that we should have created a file."
>=20
> Thanks a lot for taking the time to review and the helpful feedback!

A pleasure.

NeilBrown

>=20
> Best,
> Jori.
>=20
> > There rest of the patch look pretty good.
> >=20
> > Thanks,
> > NeilBrown
> >=20
> >=20
> > > +		} else {
> > > +			const char *fsname =3D dentry->d_sb->s_type->name;
> > > +			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n", fs=
name);
> > > +			error =3D -EIO;
> > >  		}
> > >  	}
> > > =20
> > >  	if (error) {
> > > +		if (failed_create)
> > > +			audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
> > >  		dput(dentry);
> > >  		dentry =3D ERR_PTR(error);
> > >  	} else {
> > > @@ -4462,7 +4473,7 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> > >  		dentry =3D NULL;
> > >  	}
> > >  	if (dentry->d_inode) {
> > > -		/* Cached positive dentry: will open in f_op->open */
> > > +		/* Cached positive dentry: will open in do_open(). */
> > >  		return dentry;
> > >  	}
> > > =20
> > > @@ -4496,7 +4507,7 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> > >  	if (dir_inode->i_op->atomic_open) {
> > >  		if (nd->flags & LOOKUP_DIRECTORY)
> > >  			open_flag |=3D O_DIRECTORY;
> > > -		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
> > > +		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode, cre=
ate_error);
> > >  		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
> > >  			dentry =3D ERR_PTR(create_error);
> > >  		return dentry;
> > > @@ -4515,33 +4526,37 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> > >  			dentry =3D res;
> > >  		}
> > >  	}
> > > +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
> > > +		/* No need to create a file. If lookup returned a positive
> > > +		 * dentry, the file will be opened in do_open(). */
> > > +		return dentry;
> > > +	}
> > > +
> > > +	/* Negative dentry with O_CREAT flag set */
> > > +	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > > =20
> > > -	if (unlikely(create_error) && !dentry->d_inode) {
> > > +	if (unlikely(create_error)) {
> > > +		/* Should have done a create, but we already errored */
> > >  		error =3D create_error;
> > >  		goto out_dput;
> > >  	}
> > > =20
> > > -	/* Negative dentry, just create the file */
> > > -	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> > > -		/* but break the directory lease first! */
> > > -		error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegat=
ed_inode);
> > > -		if (error)
> > > -			goto out_dput;
> > > +	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegate=
d_inode);
> > > +	if (error)
> > > +		goto out_dput;
> > > =20
> > > -		file->f_mode |=3D FMODE_CREATED;
> > > -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > > -		if (!dir_inode->i_op->create) {
> > > -			error =3D -EACCES;
> > > -			goto out_dput;
> > > -		}
> > > +	file->f_mode |=3D FMODE_CREATED;
> > > +	if (!dir_inode->i_op->create) {
> > > +		error =3D -EACCES;
> > > +		goto out_dput;
> > > +	}
> > > =20
> > > -		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> > > -						mode, open_flag & O_EXCL);
> > > -		if (error)
> > > -			goto out_dput;
> > > +	error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> > > +					mode, open_flag & O_EXCL);
> > > +	if (error)
> > > +		goto out_dput;
> > > =20
> > > -		fsnotify_create(dir_inode, dentry);
> > > -	}
> > > +	fsnotify_create(dir_inode, dentry);
> > > =20
> > >  	return dentry;
> > > =20
> > > @@ -5071,7 +5086,7 @@ struct file *dentry_create(struct path *path, int=
 flags, umode_t mode,
> > > =20
> > >  		/* atomic_open will dput(dentry) on error */
> > >  		dget(orig_dentry);
> > > -		dentry =3D atomic_open(path, dentry, file, flags, mode);
> > > +		dentry =3D atomic_open(path, dentry, file, flags, mode, create_error=
);
> > >  		error =3D PTR_ERR_OR_ZERO(dentry);
> > > =20
> > >  		if (IS_ERR(dentry))
> > > --=20
> > > 2.55.0
> > >=20
> > >
>=20

