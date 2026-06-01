Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3D819046E;
	Mon,  1 Jun 2026 03:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780284042; cv=none; b=nKMbq+luuxsPVfyqR396a0103xdSR6H8kBKeb2TEutJcbkXazvyf3fnMx9xNfiCAYE6VEUZd5uOy4l68m7lEDxTzZnagNTniCg6GoDhFHQjc/rID/akg++Tsq9tZMMQWr3MDE2xk04giRK9kNCG3nDRG9khkEZQcySjJEJ2mL68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780284042; c=relaxed/simple;
	bh=aPVQ28zcXrVFN2P9pBR44kC70gnUBeYbyBD9fq1W1ho=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=biQ//EBjFcxKoFssOjxPLxVzDhjaJDAhroi4vsN4Eyaf+Aho4y/ssjBFbUS88euUR+O4B6XveEUIedaPYpCFTC2Iw4r5zRdGzKTmzjPgiuoxEFmlmViKo1Ym0SHvyZQ1SM6wN353lpN0BOVDo2jQoTRv2FZ4/CSY8IJT4bA7SRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Yln9+39V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOQ70zgF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Yln9+39V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOQ70zgF"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 3E7451D001BD;
	Sun, 31 May 2026 23:20:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 31 May 2026 23:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780284040; x=1780370440; bh=RiSC290ymMC02xduuRbDU5mX1lWtRRMk+T3
	fN81se3w=; b=Yln9+39Vin1zK5RD1tR1vQbVAval/bs7HOprWKRkqyED7SWMhsu
	VQ+3RynosyGGViyT7v8YVWWy0AzIgzvi9usPleBBkiW8RrPKu7viZ1JhE+uO4ZnN
	wrLxPL6fKodyMhKdrehaAXaFdUXecFc2WptqY8D7TXegtybFH1mj43kwrWLRB+uW
	VIy6mnGKugQzdvtkejdDfLAxvOGmJUr8zyPvR2BXZ58vEBZD5QksLJtgc326aq/d
	IqqIzQTdk0vMDrWOKcPLkA4m/cbBZjqNdxhv60bzqpqnL9sqwFHCwnHSPCBQ4V1F
	B29yL+CLyjShvWeyfKFyfy38GCY9O5T/Gng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780284040; x=
	1780370440; bh=RiSC290ymMC02xduuRbDU5mX1lWtRRMk+T3fN81se3w=; b=n
	OQ70zgF6o5qS2ZH7UIrjTSxAbqCWHv4MPHqkA4V9Mp2zStaDuWKgN1gZBXru3hKP
	G/vMuhCRjnbt+PeeZpAJCy58m8BvvZM1R68fQA/0vBvvO0py9ZvwGsz24rA2g2OF
	itrarowyjlWDP/I4JZTBhB5qu9N4Qkkbiuh2RE76ox5fb1S5BPdvsqUVdb0GDFJd
	oyUhYIbQszOwOcB7Xdy7N/t+uvFLqnK3/igGaiKSKWzzTn1t0iUW0fBH74obfvab
	HAZN5gAAXlFubuiFDAkBHRyTLGluUKXMLVawTGByvLXBSKyoEOvEG0Lh3FhyJGsg
	R2uwCUGePTVBcNKMz0wqw==
X-ME-Sender: <xms:h_ocal9KpchovIdm-yDrmapmGdj1mpDFOrnJLy0lGToPh2RUhL5mPw>
    <xme:h_ocah4VOKNf0ZBwTFDVu9oEjUNcsNSI8Pj96fU60AnBYn7Mw_-JuYeG9FWAjn8v2
    9qDhjaODyz-6s1lTH8G69sVQlbn6_fsfqufhPj-XgeIpxtD>
X-ME-Received: <xmr:h_ocaumz_OZjzpN1_B_7HSsoKcaQP4t_6ONtWtpWkITkRAubx98d5qrifKgOXd0dZu7XC6eQId7AqAVq2UbBUSuGOsgSZkc>
X-ME-Proxy-Cause: dmFkZTF8xyPWOEUrN44GLZ0phuPp4WomwiecC4aFZoKv+7fKv7pVkcEArns29uuIqhpB7J
    SFMe82KBV6ukYr9W3IsqJYe2RK2e6kas/Ugk3kd/15O6rBy2ebRvOyMZNhV75kel53j0ML
    Bxi/mYop1cZdU/5tOMFeoiGuuVWCB06+13IJ8pNtRjKlFTyr5PQBH37KhiY1xNpYGq6hVf
    gm6BA5X+PYXdIAFWybLaxjr+kUZiy1qhvXOno7FbJhzf6M+61Np7atDyyNaW8Y84N94QcR
    z3WO5eSrFn4W1KEQ1wAUN96JFIf8THdNb3versgr2VaOD/ZfYBLvrVvxlzoyLJSVtdYdW8
    7EjYV1DbIeIdk4eAH6MYuyj/X5EVNN1P1r/DsGdSoZ6UOCcq9qdT7QU0IOs+v8n/DvAMau
    I/b0JWeyHKqf8AwoqSbDl1qPQWItYFpegm9CwfmNuIe05zKNETIg+v0jX1k9pwrFcVvmP9
    VXw0Uw9tlOyQNSXIHaZYRT7NKDY2kbvgEm3FlViyJdDP/7qTgOY/ZMKlO/iXs4km/TaWnk
    0zM6ypkAmOIsqVNuajnsx+y5V6/sEg/wQhmYl07mBjGsPPU77qRFTHMhpIiwlt8VEL5cKf
    zuTYHyke5F+es7S4+OFgBbY67WwQftW6IY/Wto8JXlp0CL8WLPXsq9HDDsFQ
X-ME-Proxy: <xmx:h_ocakF2gK7Rnjlp6gQ6ypRVrqxEOHdXU4hMImtX4HtTgCuFNTwMYw>
    <xmx:h_ocal8DKxCjQCY-Z1a2mhfz9vfYsU70W2l4smCSf_fZ1H4cbELaIg>
    <xmx:h_ocalmc0Ps9aoR0_NcONGut0Lg15HZgEE_-iI072v6A99myhFvQTg>
    <xmx:h_ocagCjIcTO2tcZBPuVTQgDEvVRFbQR8LeKbUGgpa0yhpyuMRT7BA>
    <xmx:iPocatHhPrAcxgyDtJzR25PUmMRGdF34o-crlXiZS8kO2eldGyR9jxeL>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 23:20:36 -0400 (EDT)
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
Cc: "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <cyphar@cyphar.com>,
 "Christian Brauner" <brauner@kernel.org>,
 "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jan Kara" <jack@suse.cz>,
 "Jeff Layton" <jlayton@kernel.org>, "Mateusz Guzik" <mjguzik@gmail.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Charles Mirabile" <cmirabil@redhat.com>
Subject: Re: [RFC PATCH v6 3/9] vfs: prepare vfs_creat|mkdir_no_perm for reuse
 in lookup_open()
In-reply-to: <20260531182045.171711-4-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-4-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 13:20:35 +1000
Message-id: <178028403512.2923901.8589335262496076951@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
> To implement O_CREAT|O_DIRECTORY we will have to repeat some of the
> logic that is now in vfs_mkdir() (e.g. do error checks in the same
> order). Separate this out in vfs_mkdir_no_perm(), which does all the
> non-permission related work of vfs_mkdir(). Permission checking for the
> lookup_open() path is timed differently because we may just be doing an
> open and no create. Similar considerations give rise to
> vfs_create_no_perm().
>=20
> Moving the fsnotify_* calls also allows us to deal with this in one
> place for each type of operation. This does mean that we also need
> to move the fsnotify_* calls into atomic_open() for the atomic open
> case, but this actually reduces duplicate code in open_last_lookups()
> and dentry_create().
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 105 ++++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 68 insertions(+), 37 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index 4cd132fe3981..2a35dd72ee96 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4171,6 +4171,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_id=
map *idmap,
>  	return mode;
>  }
> =20
> +static inline
> +int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       umode_t mode, struct delegated_inode *di, bool excl)
> +{
> +	struct inode *dir =3D d_inode(dentry->d_parent);
> +	int error;
> +
> +	error =3D try_break_deleg(dir, di);
> +	if (error)
> +		return error;
> +
> +	error =3D dir->i_op->create(idmap, dir, dentry, mode, excl);
> +	if (!error)
> +		fsnotify_create(dir, dentry);
> +
> +	return error;
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -4203,13 +4221,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentr=
y *dentry, umode_t mode,
>  	error =3D security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error =3D try_break_deleg(dir, di);
> -	if (error)
> -		return error;
> -	error =3D dir->i_op->create(idmap, dir, dentry, mode, true);
> -	if (!error)
> -		fsnotify_create(dir, dentry);
> -	return error;
> +
> +	return vfs_create_no_perm(idmap, dentry, mode, di, /*excl=3D*/ true);
>  }
>  EXPORT_SYMBOL(vfs_create);
> =20
> @@ -4386,10 +4399,17 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
>  				error =3D -ENOENT;
>  		}
>  	}
> +
>  	if (error) {
>  		dput(dentry);
>  		dentry =3D ERR_PTR(error);
> +	} else {
> +		if (file->f_mode & FMODE_CREATED)
> +			fsnotify_create(dir, dentry);
> +		if (file->f_mode & FMODE_OPENED)
> +			fsnotify_open(file);
>  	}
> +
>  	return dentry;
>  }
> =20
> @@ -4522,6 +4542,8 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  						mode, open_flag & O_EXCL);
>  		if (error)
>  			goto out_dput;
> +
> +		fsnotify_create(dir_inode, dentry);
>  	}
> =20
>  	return dentry;
> @@ -4610,13 +4632,9 @@ static const char *open_last_lookups(struct nameidat=
a *nd,
>  		inode_lock(dir->d_inode);
>  	else
>  		inode_lock_shared(dir->d_inode);
> +
>  	dentry =3D lookup_open(nd, file, op, got_write, &delegated_inode);
> -	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir->d_inode, dentry);
> -		if (file->f_mode & FMODE_OPENED)
> -			fsnotify_open(file);
> -	}
> +
>  	if (open_flag & O_CREAT)
>  		inode_unlock(dir->d_inode);
>  	else
> @@ -5051,13 +5069,6 @@ struct file *dentry_create(struct path *path, int fl=
ags, umode_t mode,
>  		if (unlikely(create_error) && error =3D=3D -ENOENT)
>  			error =3D create_error;
> =20
> -		if (!error) {
> -			if (file->f_mode & FMODE_CREATED)
> -				fsnotify_create(dir->d_inode, dentry);
> -			if (file->f_mode & FMODE_OPENED)
> -				fsnotify_open(file);
> -		}
> -
>  		path->dentry =3D dentry;
> =20
>  	} else {
> @@ -5209,6 +5220,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename=
, umode_t, mode, unsigned, d
>  	return filename_mknodat(AT_FDCWD, name, mode, dev);
>  }
> =20
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *idmap, struct inode *di=
r,
> +				 struct dentry *dentry, umode_t mode,
> +				 struct delegated_inode *di)
> +{
> +	int error;
> +	struct dentry *de;
> +	unsigned max_links =3D dir->i_sb->s_max_links;
> +
> +	error =3D -EMLINK;
> +	if (max_links && dir->i_nlink >=3D max_links)
> +		goto err;
> +
> +	error =3D try_break_deleg(dir, di);
> +	if (error)
> +		goto err;
> +
> +	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> +	if (IS_ERR(de)) {
> +		error =3D PTR_ERR(de);
> +		goto err;
> +	}
> +	if (de) {
> +		dput(dentry);
> +		dentry =3D de;
> +	}
> +	fsnotify_mkdir(dir, dentry);
> +	return dentry;
> +
> +err:
> +	return ERR_PTR(error);
> +}
> +
>  /**
>   * vfs_mkdir - create directory returning correct dentry if possible
>   * @idmap:		idmap of the mount the inode was found from
> @@ -5236,7 +5280,6 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, str=
uct inode *dir,
>  			 struct delegated_inode *delegated_inode)
>  {
>  	int error;
> -	unsigned max_links =3D dir->i_sb->s_max_links;
>  	struct dentry *de;
> =20
>  	error =3D may_create_dentry(idmap, dir, dentry);
> @@ -5252,24 +5295,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  	if (error)
>  		goto err;
> =20
> -	error =3D -EMLINK;
> -	if (max_links && dir->i_nlink >=3D max_links)
> +	de =3D vfs_mkdir_no_perm(idmap, dir, dentry, mode, delegated_inode);
> +	if (IS_ERR(de)) {
> +		error =3D PTR_ERR(de);
>  		goto err;
> -
> -	error =3D try_break_deleg(dir, delegated_inode);
> -	if (error)
> -		goto err;
> -
> -	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> -	error =3D PTR_ERR(de);
> -	if (IS_ERR(de))
> -		goto err;
> -	if (de) {
> -		dput(dentry);
> -		dentry =3D de;
>  	}
> -	fsnotify_mkdir(dir, dentry);
> -	return dentry;
> +	return de;
> =20
>  err:
>  	end_creating(dentry);
> --=20
> 2.54.0
>=20
>=20

This looks good.  I definitely like the idea of moving fsnotify_* calls
closer to where the action happens.

Reviewed-by: NeilBrown <neil@brown.name>

Thanks,
NeilBrown
