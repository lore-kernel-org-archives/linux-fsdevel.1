Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8163370D7D
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Jul 2026 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783290356; cv=none; b=BAhXZmPTDaQEiBVPnHpB+7h79f7hW6cypN4nPOi6R/ACwlLLzgABbh7UJlohV5QeB0HntnXz1n8GLgxeJShjCeWguF6kvJZ/qOC5T8curZ8qkTwJtcc8FOolf79ptlVGcO2CMYardU7GbS4O1bF+sJFl8xQ24r97++q2/1afXGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783290356; c=relaxed/simple;
	bh=lktXj7XJeOO8J5s78OzQfhbXS4T5Hw8cqvaj9r48ms0=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=LW+5KoIopRAM/2Kf4zQQcsVoNRVO/BRzF0pZ1rUY7yPiirN8Ja/r0gpRPMKMo3aHKM5DQ40WMgwXL69rJsuqLGO9nsZcrAy0h/QqW0hmeTwHC72IvVKKkWV9Njo3neZ+PuitBDwCO8Li0S1ffmJX2WGgUYEH28PaDVC60QMS6WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=eENn9ggs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cH2Sxknu; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="eENn9ggs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cH2Sxknu"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 495B4EC006C;
	Sun,  5 Jul 2026 18:25:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 05 Jul 2026 18:25:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783290354; x=1783376754; bh=w9p+3Qr3rIHcDG8Wp2/MDoXJj8khlkoOy3H
	WlMdMZyY=; b=eENn9ggs2IjIPi+1YfrJ46jOt8yaR8d0n2o5VULL0cpdyEvrrxK
	8/n1fOJS1p0bokHPZkJRUfDT/X64ylHAeN6q7vQc/JaqaioZMePyPDv/pIJ5NvL1
	RZzfbwqeL7VNezAla0/KnG+r7G/wYmEeacvoOWknU3a/r4SDsnsEEvGGOO8mozMw
	rt1VbyPFIU1+PP+MMMsz/KVbberWVBz6RUdc+I+FJ9nPwnPz1znYC97qS9cr3G6N
	0gTZM5X3igvCtl0p5BU1wP7GlaboO9iOxQOuteKfieIVbL8p6iOOwa0QrVALUVry
	WhNhx8INjU0W5zISRKIZyCVZ3PWQlQEpCnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783290354; x=
	1783376754; bh=w9p+3Qr3rIHcDG8Wp2/MDoXJj8khlkoOy3HWlMdMZyY=; b=c
	H2SxknuwFMcQjvXYlWbCKu97Eo0iqskT8rj5MUgIJb96Wth4iO9pDkFYyVNWN6GU
	fxYn6h5xi7Lh9tY8ILIb9lqIJ+8BOLu2Q9d1sLhkgdr50AgSMp5EqKG6UvK36hfr
	CjS8cFyVkOcMOVTQR1yMZzfG7n9yBFsSLh40+vFdlJ7Dpqptd3m6YeEfL4Zus0xc
	5g2MlTk9LhLv+mBE+CQA8ETDCBRmOmAytAXwzTkorAOQZNoatikF2kHBneomROkg
	xMVeB9hIoL+0t3GDIhBrYFiIPLAI4nQtGo6dZ45U7y4tT7Amn4I5EoKxxp+cTz4B
	FpsUAhmeROpZTUEw6WBSw==
X-ME-Sender: <xms:8dlKan0jJWaMS6F7w2HU40P6JpHE2WrJUCV6-n_9_SGK8WGg4gHLaQ>
    <xme:8dlKavDD6vzYrlEkpeUOp5iVLjDIp7UQybCGOWV2Cvfqgp8iKMJbGJYFMnJGRPQ0q
    faD1b8z1b7Gutd_mr9PdRi6dLlZcH8Y5R6j9_BaFk5PLXYBzzQ>
X-ME-Received: <xmr:8dlKajdVeLMhyfkGEyayqQ41DTGRIZZ22lxHskHeKaE3EDa6uir77bC7TXn8XBr7aG17CIWCGD23r8aocK1dSJ6A0pWN1NA>
X-ME-Proxy-Cause: dmFkZTGhK0NbnspDt5smCVUe8rdZ2CW25AucHEv9iu/qyGyTHzWGosVQElXkcr1rUH/YRI
    qu0r1MId5lRrfVX2d85ziXoe4BwDDCLavPuc9le81SDLGB0kOZWV/bUZcB+U29HfPIQCT3
    GQBP5q+/a7fbcc4n0gSmhjsIVFEeZOxaQVAjxmxPezIStkNG98HrHIrjtVkZeaJuQ2bRA2
    Huoc2RkbqsAesrdYZsjHyKJyNdy0EF9NzfxK5Z+ttlWjuUbns/yePlgScyTKxWvw67Au1i
    r+nACNoA9wSVxeNfeaY5C/vhB1tuQStv/AkN+tEN7ZbZm32AXOeqiWk8REkPHqO7fLU+m1
    kFvsN4fpDTuBiNjzxr+fp5HndiIvVJxzINb9kbtOB72BZXB8FtubP2VUGfSASKgLaR39FV
    5j3i2trCePFQdovJ6FepSWqgwLC6VYZpb2x34TFYgjznHzhXXudLw+WEXhh+IgsJHGkOUj
    No65YGeCfeZEQCCuyzyLrItvCX4ufH7otVP2lEEwayxr/VlhB7mVXcRVi+2KCfa30HDCKT
    zTZ9e6cLJn/b0lwkSnA+Tduw/NlofG00QQUFrD107aXCT8FIkCB2GZTIF7FVWXECI4YTVC
    uuUgljxQODp3TAr8o+v1/oPCHkAHSlo6Sv01TwFyGhYfs2VkGyJ/OMr56KeQ
X-ME-Proxy: <xmx:8dlKas7z8L7QbJOZVNsenDyXa07JPSUf9zH6A94oTA6LfrMeaQ7C0g>
    <xmx:8dlKamU9TnaJPwAGsWOfBuDLCxkLCWneRlYxwCsCfLskj6LV-dlJKQ>
    <xmx:8dlKar5Rgr3e8x42pWK3NXPxscJSqs5E1FQuuNSfz4MfxDiu7fzKag>
    <xmx:8dlKahpRi0viO_58wTdGcEF6amjJUIwTJ3Vl5a7NXrgzEkH6FSP9sA>
    <xmx:8tlKaiBJTJWILNxWBPKEJP2uKFW0baUfmbYtIR4W9ICRTVE8CQeYijVQ>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 5 Jul 2026 18:25:52 -0400 (EDT)
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
Subject:
 Re: [PATCH 1/3] VFS: move mnt_want_write() and locking into lookup_open()
In-reply-to: <1231841341.3912063.1783074804485@kpc.webmail.kpnmail.nl>
References: <>, <1231841341.3912063.1783074804485@kpc.webmail.kpnmail.nl>
Date: Mon, 06 Jul 2026 08:25:50 +1000
Message-id: <178329035000.27465.3386945492943939016@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 03 Jul 2026, Jori Koolstra wrote:
> > Op 02-07-2026 13:09 CEST schreef NeilBrown <neilb@ownmail.net>:
> >=20
> > =20
> > From: NeilBrown <neil@brown.name>
> >=20
> > The mnt_want_write() call and the parent inode locking in
> > open_last_lookups() are only needed for lookup_open().  So we can move
> > them and all the got_write handling into lookup_open().
> >=20
> > Note that we need to also check create_error when determining whether to
> > unlock shared or not, as O_CREAT can be cleared, but create_error is
> > only set of O_CREAT was set.
> >=20
> > The fsnotify calls come too as they must be in the locked region.
> >=20
> > Also use the existing dir_inode uniformly for dir->d_inode.
> >=20
> > This is a step towards exporting an better "open/create" interface to nfs=
d.
> >=20
> > Signed-off-by: NeilBrown <neil@brown.name>
> > ---
> >  fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
> >  1 file changed, 41 insertions(+), 36 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 7ead3db55be2..55404fe0e269 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4398,7 +4398,7 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
> >   */
> >  static struct dentry *lookup_open(struct nameidata *nd, struct file *fil=
e,
> >  				  const struct open_flags *op,
> > -				  bool got_write, struct delegated_inode *delegated_inode)
> > +				  struct delegated_inode *delegated_inode)
> >  {
> >  	struct mnt_idmap *idmap;
> >  	struct dentry *dir =3D nd->path.dentry;
> > @@ -4407,9 +4407,25 @@ static struct dentry *lookup_open(struct nameidata=
 *nd, struct file *file,
> >  	struct dentry *dentry;
> >  	int error, create_error =3D 0;
> >  	umode_t mode =3D op->mode;
> > +	bool got_write =3D false;
> > =20
> > -	if (unlikely(IS_DEADDIR(dir_inode)))
> > -		return ERR_PTR(-ENOENT);
> > +	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> > +		got_write =3D !mnt_want_write(nd->path.mnt);
> > +		/*
> > +		 * do _not_ fail yet - we might not need that or fail with
> > +		 * a different error; let lookup_open() decide; we'll be
> > +		 * dropping this one anyway.
> > +		 */
> > +	}
> > +	if (open_flag & O_CREAT)
> > +		inode_lock(dir_inode);
> > +	else
> > +		inode_lock_shared(dir_inode);
> > +
> > +	if (unlikely(IS_DEADDIR(dir_inode))) {
> > +		dentry =3D ERR_PTR(-ENOENT);
> > +		goto out;
> > +	}
> > =20
> >  	file->f_mode &=3D ~FMODE_CREATED;
> >  	dentry =3D d_lookup(dir, &nd->last);
> > @@ -4417,7 +4433,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  		if (!dentry) {
> >  			dentry =3D d_alloc_parallel(dir, &nd->last);
> >  			if (IS_ERR(dentry))
> > -				return dentry;
> > +				goto out;
> >  		}
> >  		if (d_in_lookup(dentry))
> >  			break;
> > @@ -4433,7 +4449,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  	}
> >  	if (dentry->d_inode) {
> >  		/* Cached positive dentry: will open in f_op->open */
> > -		return dentry;
> > +		goto out;
> >  	}
> > =20
> >  	if (open_flag & O_CREAT)
> > @@ -4454,7 +4470,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  	if (open_flag & O_CREAT) {
> >  		if (open_flag & O_EXCL)
> >  			open_flag &=3D ~O_TRUNC;
> > -		mode =3D vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
> > +		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> >  		if (likely(got_write))
> >  			create_error =3D may_o_create(idmap, &nd->path,
> >  						    dentry, mode);
> > @@ -4469,7 +4485,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
> >  		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
> >  			dentry =3D ERR_PTR(create_error);
> > -		return dentry;
> > +		goto out;
> >  	}
> > =20
> >  	if (d_in_lookup(dentry)) {
> > @@ -4508,11 +4524,27 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> >  		error =3D create_error;
> >  		goto out_dput;
> >  	}
> > +out:
> > +	if (!IS_ERR(dentry)) {
> > +		if (file->f_mode & FMODE_CREATED)
> > +			fsnotify_create(dir_inode, dentry);
> > +		if (file->f_mode & FMODE_OPENED)
> > +			fsnotify_open(file);
> > +	}
> > +	if ((open_flag & O_CREAT) || create_error)
> > +		inode_unlock(dir_inode);
> > +	else
> > +		inode_unlock_shared(dir_inode);
> > +
> > +	if (got_write)
> > +		mnt_drop_write(nd->path.mnt);
> > +
> >  	return dentry;
> > =20
> >  out_dput:
> >  	dput(dentry);
> > -	return ERR_PTR(error);
> > +	dentry =3D ERR_PTR(error);
> > +	goto out;
> >  }
>=20
> I know this is kernel code and an established pattern that is quite
> useful. But jumping back with gotos just reads confusingly to my brain,
> however, I don't have any better suggestion that is less confusing.

I agree.  I try to avoid it when doing so makes the code flow clearer,
but sometimes I can't.  And as you say there is an established pattern
of putting error-handling code out of the main code flow.

>=20
> Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

Thanks!

NeilBrown


>=20
> > =20
> >  static inline bool trailing_slashes(struct nameidata *nd)
> > @@ -4555,9 +4587,7 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
> >  		   struct file *file, const struct open_flags *op)
> >  {
> >  	struct delegated_inode delegated_inode =3D { };
> > -	struct dentry *dir =3D nd->path.dentry;
> >  	int open_flag =3D op->open_flag;
> > -	bool got_write =3D false;
> >  	struct dentry *dentry;
> >  	const char *res;
> > =20
> > @@ -4587,32 +4617,7 @@ static const char *open_last_lookups(struct nameid=
ata *nd,
> >  		}
> >  	}
> >  retry:
> > -	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> > -		got_write =3D !mnt_want_write(nd->path.mnt);
> > -		/*
> > -		 * do _not_ fail yet - we might not need that or fail with
> > -		 * a different error; let lookup_open() decide; we'll be
> > -		 * dropping this one anyway.
> > -		 */
> > -	}
> > -	if (open_flag & O_CREAT)
> > -		inode_lock(dir->d_inode);
> > -	else
> > -		inode_lock_shared(dir->d_inode);
> > -	dentry =3D lookup_open(nd, file, op, got_write, &delegated_inode);
> > -	if (!IS_ERR(dentry)) {
> > -		if (file->f_mode & FMODE_CREATED)
> > -			fsnotify_create(dir->d_inode, dentry);
> > -		if (file->f_mode & FMODE_OPENED)
> > -			fsnotify_open(file);
> > -	}
> > -	if (open_flag & O_CREAT)
> > -		inode_unlock(dir->d_inode);
> > -	else
> > -		inode_unlock_shared(dir->d_inode);
> > -
> > -	if (got_write)
> > -		mnt_drop_write(nd->path.mnt);
> > +	dentry =3D lookup_open(nd, file, op, &delegated_inode);
> > =20
> >  	if (IS_ERR(dentry)) {
> >  		if (is_delegated(&delegated_inode)) {
> > --=20
> > 2.50.0.107.gf914562f5916.dirty
>=20
>=20
>=20
> I'll review your comments on v2 of O_CREAT|O_DIRECTORY and send a v3 this
> weekend. I can work from your merge branch, but since this isn't in yet,
> maybe I should just work from Christian's branch instead? What can I do
> to make this the least amount of extra work for you?
>=20
> Thanks, for thinking of me and doing some of the merge work already :)
>=20

