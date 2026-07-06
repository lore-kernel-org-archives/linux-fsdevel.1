Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449BA246782;
	Mon,  6 Jul 2026 05:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316014; cv=none; b=fz7MGa0MMMnw23q4woPEZin2uBMocgrH72P+1gj9wjkncmelW7Igr+hFi9uMy6BJuoPkOYOKwCaZJXcMTs76gMprqX/1zXksS1yOyOlKgGZrqqSa6aJKEmxbuaK2Z3EjlBWpI7OaYodS+1exj4uKR2ZcmCNjcNLOf7LoncE9Sm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316014; c=relaxed/simple;
	bh=b+8p9Jxs5LFSYAsN6AmBt+FT9WXErPGvyYC7zp9YBUo=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=r+6vxM0xtjpffl45XXDZaGmzEIy+mg9U+H4t6N8aMwABWd/yNlOIcw7hoqfVVc1Mf8VFkuqm8zab5dLxyiw6z8E6kjWA/JnYAhHX/1Hn7PlFd3ICoekj2g3N1KvXYrr9H6bog4LF++Rf62168fnwvgZStfLkeCSFYNZQVv9pXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=UvZ58UAo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nWK+eycT; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="UvZ58UAo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nWK+eycT"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6669F7A00E7;
	Mon,  6 Jul 2026 01:33:31 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 01:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783316011; x=1783402411; bh=o1ZYTmRKpxa8r//tJsJBlyFbcCMJ64ygGtm
	Z00w7mM4=; b=UvZ58UAoMzKK6tnzHXcjxKH85ZeHCiVvI3sE1YgUopLsyv8Ja2Z
	TlL1k6Pf6DZZzYuH5sVuqK0ldGKqP7GQKpoPIE83kl3f4teV0/2vmAs2SCez9Byj
	AHdHzLLfN5hW2V2q7VA4jEMS31OY+dLButidOpBkyicVX+tUmUuDeDRo0TPi66ud
	ueDqdsIx7w7wI/KYSXooXyKVoTg8nKCIzf5D2zT3UCZIka4xPw5xJklvQUjwJiKG
	SR/QQiT7PK/9/QrzcQPRATaJiDRJhC+VNIMQiQ6jCtR1WKlzG2o2WuA0sQzeVGgs
	TNHAu2eEGdRU0fO5GGWOS9U5GMISbsSEctg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783316011; x=
	1783402411; bh=o1ZYTmRKpxa8r//tJsJBlyFbcCMJ64ygGtmZ00w7mM4=; b=n
	WK+eycTPf1TzuDl6CiQ+iJLNBBrlPm1u6dz8GfrL54PWIo7QvHGwtnViR7knJRfi
	ZqGLh6oTk1JC3FtiNDa6M33LyWCjAoVZq0x96nTfu8J/5sbgf7K+6udvsAAwl3/R
	KNsZom8zMq9T5Q+EDjgx1qV11I8wrub7FzIw/r0bVvSZFTMrn1PwYIYc6HI026u+
	Tj+Y1HJtpovXfW9AsUZ6JB7CffWsQdXPJWk0TBZ/KrlqfEhArkB16hTR+FV2djCL
	GRmy/9xbYw1CerLzqtA1KjGDwrD5CPvfmHURWzpmwOIpKKUZQVl8T3ccd9USWjZN
	tSMby2BFuZkmXiG5dQysw==
X-ME-Sender: <xms:Kj5LakQXfmOeQXRr3ndiCqNuPTHSupvMOx8VEGMEgDe9SrCQSG2EjQ>
    <xme:Kj5LauXmEojWDEJ2XZYKEQ9vY-aBKC1nNbq_tSkiueV1u-MamOdllzaSy5cW4YlLi
    Ntv_31OdC9CZSHrT-0UqBxnI86zTMtw68jAZnuKtTfsozKTFw>
X-ME-Received: <xmr:Kj5LamRGQNBGA6CHgLWJVpGSwbPNNZo_RxknmcPG96VCFsrx_KTNf3bxPYI7m6JmgdfPTzNvKoErY1ftHYHPKSpievqQFfM>
X-ME-Proxy-Cause: dmFkZTGxLkexdVFSYJuHepiCB1/U+fTbh73SKh4HGluxF87YrD4mX4Eds6e/mToXOZ8oKT
    xGyGkRiokwXShKKpu7rqIV2PNpgDNZONqA8noYzDcP9+lfvwhQrtDzzuAIh1EAljl3tgrP
    v89JoVOoaFmM7aBkp0fiwYHoY/Kzl3cua0NKzXyjkbPC80hUuj7TEBZzfwT42hBUXbUV7T
    8YWQugd+/IA5wIGY314atOJhYV1YRAoH1KpRkpABJjT6pww5Xup9EA2A59GsJTN6FQRYt5
    hEmS0eUgcdhzEZ8DaN6TBmefOCYpO0VZM8DKnSSv40gC9biV3oWOFvvRgst+7Tbvd4Wqda
    i3ig+IYHaFEvRHNiP8xMg+0BPUNIqLgSNvqaLNceAN9JqP/FeqFdLrEmzd1T8iZkO7vvYA
    I+imVwiYZBhDlQGmG83JWQy2ZGTqtqaGj3S7pUqaNw5yiuw35rAh2566JqJ8GhiWO462gA
    6smrm3PrD9tMK8GlgYS501HjtDqlyuaUJBLOkyGO8J4XbMQkRoF55XbYd8JRI/fIFD/URX
    5GGR2cEbAjLN0zHS1xXLmHLvnxnlPgleB0/x6Z+aBvDQt0g/6+ut2PRdvRfUQOAo0kO91A
    hVT7oVs8nFLxUdvC2/Ar9P4m+4Q1EPTBzdYJBZHORryiy7qDd953q3lmgshQ
X-ME-Proxy: <xmx:Kj5Lau3RQDdSdxPL4d65Qs2FVvLTMcbN_9lUbHItF53--jCJuooomQ>
    <xmx:Kj5LaucnzivH8UzOhcV9zlTpbwm5GssbvBr0QNl3WktLm7jhQXiuEg>
    <xmx:Kj5LauP-ltJ766Z-LS1-dIjmUX1gM6oiFuHOwOdPkal57uy9iMUwAw>
    <xmx:Kj5LaqXhTrp_crEnA4JxZdIU5EstAOAOaM6ChtH518R3ze0HRJQk6g>
    <xmx:Kz5LalFaF4snk2dpXqPWQGuiKT191jRfC0giw0wtlgdQ1pCZAKVqbsYe>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:33:27 -0400 (EDT)
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
 linux-kernel@vger.kernel.org, "Jori Koolstra" <jkoolstra@xs4all.nl>
Subject: Re: [PATCH v3 04/14] vfs: call audit_inode_child() in lookup_open()
 on failure too
In-reply-to: <20260704164149.3480051-5-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-5-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:33:24 +1000
Message-id: <178331600416.27465.18425637255026621428@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> audit_inode_child() is called in may_create_dentry() so that failed
> filesystem operations still register an audit entry. On success, the
> entry is overwritten when, for instance, fsnotify_create() is called.
> This is the calling convention in vfs_create() and vfs_mkdir().
> In lookup_open(), however, when atomic_open() should have created a
> file but didn't, no call to audit_inode_child() is made. The same is
> true for the regular ->create() path.
>=20
> Fix the calling of audit_inode_child() in lookup_open() to match the
> vfs_create() path. For the ->atomic_open() filesystems this logic has
> been pushed into atomic_open(). This function is also reordered a bit
> to make the case distinction of the possible returns from
> ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
>=20
> When retrying delegation breaking, audit_inode_child() could be called
> more than once, but this is OK because those entries are reused.
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 75 ++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 45 insertions(+), 30 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index ee47d3f5159f..956adcd14c4a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4369,10 +4369,11 @@ static int may_o_create(struct mnt_idmap *idmap,
>   */
>  static struct dentry *atomic_open(const struct path *path, struct dentry *=
dentry,
>  				  struct file *file,
> -				  int open_flag, umode_t mode)
> +				  int open_flag, umode_t mode, bool create_error)
>  {
>  	struct dentry *const DENTRY_NOT_SET =3D (void *) -1UL;
>  	struct inode *dir =3D  path->dentry->d_inode;
> +	bool failed_create =3D false;
>  	int error;
> =20
>  	file->__f_path.dentry =3D DENTRY_NOT_SET;
> @@ -4382,23 +4383,33 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
>  	d_lookup_done(dentry);
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> -			if (unlikely(dentry !=3D file->f_path.dentry)) {
> +			// finish_open() called
> +			struct dentry *opened =3D file->f_path.dentry;
> +			if (unlikely(opened !=3D dentry)) {
>  				dput(dentry);
> -				dentry =3D dget(file->f_path.dentry);
> +				dentry =3D dget(opened);
>  			}
> -		} else if (WARN_ON(file->f_path.dentry =3D=3D DENTRY_NOT_SET)) {
> -			error =3D -EIO;
> -		} else {
> -			if (file->f_path.dentry) {
> +		} else if (likely(file->f_path.dentry !=3D DENTRY_NOT_SET)) {
> +			// finish_no_open() called
> +			struct dentry *replaced =3D file->f_path.dentry;
> +			if (replaced) {
>  				dput(dentry);
> -				dentry =3D file->f_path.dentry;
> +				dentry =3D replaced;
>  			}
>  			if (unlikely(d_is_negative(dentry)))
>  				error =3D -ENOENT;

I think this can now be
   if (unlikely(d_is_negative(dentry))
         error =3D create_error ?: -ENOENT;
or something similar if people don't like "?:".

> +			if (error && create_error) // should have created, but errored before
> +				failed_create =3D true;

Why have 'failed_create' ? Why not just put the audit_inode_child() like
here?

There rest of the patch look pretty good.

Thanks,
NeilBrown


> +		} else {
> +			const char *fsname =3D dentry->d_sb->s_type->name;
> +			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n", fsname=
);
> +			error =3D -EIO;
>  		}
>  	}
> =20
>  	if (error) {
> +		if (failed_create)
> +			audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);
>  		dput(dentry);
>  		dentry =3D ERR_PTR(error);
>  	} else {
> @@ -4462,7 +4473,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  		dentry =3D NULL;
>  	}
>  	if (dentry->d_inode) {
> -		/* Cached positive dentry: will open in f_op->open */
> +		/* Cached positive dentry: will open in do_open(). */
>  		return dentry;
>  	}
> =20
> @@ -4496,7 +4507,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  	if (dir_inode->i_op->atomic_open) {
>  		if (nd->flags & LOOKUP_DIRECTORY)
>  			open_flag |=3D O_DIRECTORY;
> -		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode);
> +		dentry =3D atomic_open(&nd->path, dentry, file, open_flag, mode, create_=
error);
>  		if (unlikely(create_error) && dentry =3D=3D ERR_PTR(-ENOENT))
>  			dentry =3D ERR_PTR(create_error);
>  		return dentry;
> @@ -4515,33 +4526,37 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  			dentry =3D res;
>  		}
>  	}
> +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {
> +		/* No need to create a file. If lookup returned a positive
> +		 * dentry, the file will be opened in do_open(). */
> +		return dentry;
> +	}
> +
> +	/* Negative dentry with O_CREAT flag set */
> +	audit_inode_child(dir->d_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> =20
> -	if (unlikely(create_error) && !dentry->d_inode) {
> +	if (unlikely(create_error)) {
> +		/* Should have done a create, but we already errored */
>  		error =3D create_error;
>  		goto out_dput;
>  	}
> =20
> -	/* Negative dentry, just create the file */
> -	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> -		/* but break the directory lease first! */
> -		error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_i=
node);
> -		if (error)
> -			goto out_dput;
> +	error =3D try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_in=
ode);
> +	if (error)
> +		goto out_dput;
> =20
> -		file->f_mode |=3D FMODE_CREATED;
> -		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -		if (!dir_inode->i_op->create) {
> -			error =3D -EACCES;
> -			goto out_dput;
> -		}
> +	file->f_mode |=3D FMODE_CREATED;
> +	if (!dir_inode->i_op->create) {
> +		error =3D -EACCES;
> +		goto out_dput;
> +	}
> =20
> -		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> -		if (error)
> -			goto out_dput;
> +	error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> +					mode, open_flag & O_EXCL);
> +	if (error)
> +		goto out_dput;
> =20
> -		fsnotify_create(dir_inode, dentry);
> -	}
> +	fsnotify_create(dir_inode, dentry);
> =20
>  	return dentry;
> =20
> @@ -5071,7 +5086,7 @@ struct file *dentry_create(struct path *path, int fla=
gs, umode_t mode,
> =20
>  		/* atomic_open will dput(dentry) on error */
>  		dget(orig_dentry);
> -		dentry =3D atomic_open(path, dentry, file, flags, mode);
> +		dentry =3D atomic_open(path, dentry, file, flags, mode, create_error);
>  		error =3D PTR_ERR_OR_ZERO(dentry);
> =20
>  		if (IS_ERR(dentry))
> --=20
> 2.55.0
>=20
>=20

