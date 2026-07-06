Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1A70808;
	Mon,  6 Jul 2026 05:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783316822; cv=none; b=mE+VkzhFHQZoTvJmyV+6PgVSOfiepkses4E3dakdAWZEQFwDAEZOKexsYBIVtQupU8hOfiz1w7EVaYg1LIO93vFgEZYHVj6MC65sgcM4t0fV6TYmUNoih3g39TWdut8m9N6q4oGl2hBhAKf/+jQoMZd5lGmPvgYO11aeDX9Ezuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783316822; c=relaxed/simple;
	bh=thRRcNL2hyPg4UadVmcQSSs4R7CiEh3nY8o3uC0Ue7s=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QzT0aoOE2SiORfpScxZ/3PT/1Fw/lOTQNhXF+mu+RjnJzrsky6PE/Qm2PnlcrlJRVbnUPWQAQ5UPJpxwV2V3nIBmYuW4BV3jV5lS4D7D9KwFIVy2oN8AWwHrFtjBGR05uxDYizLfCJLP9Ixo/Po00CXXV2luo2vBDRZb37KtcT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=fPuC5VMu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q77unpaa; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="fPuC5VMu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q77unpaa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A8BE7A00A5;
	Mon,  6 Jul 2026 01:47:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 06 Jul 2026 01:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm2; t=
	1783316820; x=1783403220; bh=PuR7qxLVGj6AHswsYVCZBKI5gBDmiH7IxZc
	GZAEdjgU=; b=fPuC5VMuRBWeellTa+/wVsuzGPjCGxKK3rBAYU/NuDpCcdaILqX
	8bMucz70KnUnrxh+IalKZD1GR9Mh1JdP6rD4mDKpNOMn6s9ILNXDr9yiGvpm9Hwk
	AtPzgVweerNCyZBmVOmR88FfU/rXDr0esB1vrlMlk5AY7Nny01EeqGkqVUckLFLa
	xgP66mca1FDbFlGD5K2yi9+3TOBYIlFQkG/Cd6kk8f/NTcSzKf5vPSO5iJFxUBGF
	kn5cnhvDsEdJZny+jfm6+9b+53y58eQ/jl1nmtE2g2YpjgE4ChunS+Hw3vY8nvdJ
	Ke0PKAwK2S+p2t4iyG+h6LLGpgKFSPylDJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783316820; x=
	1783403220; bh=PuR7qxLVGj6AHswsYVCZBKI5gBDmiH7IxZcGZAEdjgU=; b=q
	77unpaadDhFie5clmlF5rLLp052lJw8Yo1KhTC752gZFYYkaGIZwfvq6QLIUWv0G
	Z1X9i0Qz/oqDbPZnbYEQlA2F6Q6I8nm7y8rana/42fh995Lr/7N2gzwAskVFQifW
	Ks66wlQm+YRB1drIhUEdwpV7jKAPTVHnnAZ/kZHWrTv9BaENPHJINgO3Jj5QPLy/
	CfozX8SIY7E25iQsq+7fq5UfEN9aeeWpQZcLf9YoZ/k81VD3oFHmY5AENTLojamU
	nKet6Owe/qK3p5d7nNdHrx8uE7S3SyInSGOQLmGXkqqW8BWknzstWCEhDi5ENZVX
	vtSYR6lRxV3KduAdsFXeQ==
X-ME-Sender: <xms:U0FLajTPGt59Bq30QsVw40dFHAA6NJfSwY3i8w0tJbRE32PKor7zfA>
    <xme:U0FLahXYTjsyofdMqyI-taHU0Q0TIKMtAcHFTgYNsUNNzrFkb2c2rUer6hKaWtEKo
    AtLKlcgDnafg0t9FlS_IiBjSk0Tcim_Uw2EUy7ELt443lufIw>
X-ME-Received: <xmr:U0FLatQXt_PbDY7skGIVQqD-qpEeRlLZOSvndlGs3Qa7KF5-GIg0A9m_SO0EGvbirePsouUsgMe6EYjHNap4qTVoqmujgaE>
X-ME-Proxy-Cause: dmFkZTElE3BMTyQGQNj7bME+pjjg8d92UuSI3zuo0+t+ZsMg0lh70oBgwti7XsIe3zIBVE
    4qvx02xbm5paFPnFthHp+c0Zl6ipJ47Cee9anLNla6QB3XLMUjmvvbpew9VLpITF2lIsi0
    PlsXgwCRiKuAIMCl5RwrWvQVl2vk0fF+TIEBeMTridETsREE1BZqFSQkTOWRs5BVvl6tEU
    AuJInaev2ivOGAjtPiD+pUf0jTR35DwP9pbGuA09YvjSywM3ti3GxRh0nuJaGQo6Wz+AUx
    t0214iteNO1tr9N/+FSfNT6d+YnWgo7rDSzjXwbUzUVC1wV7TsmPOyK7xqQ4WX5fxxbpGv
    nHGmTruMnLhF0KA4eK90NvZJDKlXDhRFMz9T5SgcxxppnnDQxkcycsTzW+tLkEvxhCgYtV
    mwrmR6PWNa26ztT2ZrteBLnSmuI3jW+NdAqE9kl0obw0q6kqmxx5X4b1hlGiLbBcSuyveB
    tQzdLA2Pek5go7GnavNZslG4UC/W856Grd3fse7YTAokXmGz+AjvH8+6REqBjNda7FXcNi
    b7dgg+nTrE6+6SyVKIZJszF5rJmRaB8BgaIOmX27DKrctOHsL7ngBAsjw7M7xAR54d9hM3
    MKON2c9a3uv5wYB4xSA+1De6pKSFgM0iZqh9Uc0C+XkoKpdYO7RVUc/nGNXA
X-ME-Proxy: <xmx:U0FLap2eQkR8TXXA8c_WhvcoOXTws7no26jPi-vjzfN8CFy0aUO1wQ>
    <xmx:U0FLatduuKU2OFgK-oS34lPaMyFcrA4PdDGq_lLBw4wUfcMed2QQtA>
    <xmx:U0FLahPTUryaHs49xFRr0aTow9Ak5JXxwk7_I0Ae2L12BEpVAnprXA>
    <xmx:U0FLahVaKzwHTfxivSyvRNJwXzVNsjbM2YQ3bRmYdTsWOsaM5Cm7sg>
    <xmx:VEFLagE6F37q_9nLE5hZx5hIXk-svYXQEesIlP0Y-bi-C5ZpmIiFfDH9>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 01:46:56 -0400 (EDT)
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
Subject: Re: [PATCH v3 09/14] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260704164149.3480051-10-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
  <20260704164149.3480051-10-jkoolstra@xs4all.nl>
Date: Mon, 06 Jul 2026 15:46:54 +1000
Message-id: <178331681458.27465.13440249168234735654@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Sun, 05 Jul 2026, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
>=20
> Addressing this race without proper APIs is possible (by immediately
> fstat()ing what was opened, to verify that it has the right inode type),
> but difficult to get right. Hence, adding support for a new flag combo
> O_CREAT|O_DIRECTORY to open*(2) that creates a directory (if it does not
> exist already) and returns an O_DIRECTORY fd is very useful.
>=20
> Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> a regular file exists at the open path; EISDIR if a directory exists at
> the path; and to create a regular file if no file exists at the path.
> This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> ENOTDIR to return in the last case while still creating the file. As
> this change was not detected for a long time, Brauner proposed to adopt
> the more consistent NetBSD behaviour, i.e. to return EINVAL on the the
> O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> the EINVAL behaviour has been in the kernel for about 3 year now, no
> rollback is expected as a result of userspace reliance on old
> behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
>=20
> O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> filesystems. This is implemented by stripping the O_CREAT bit. The other
> option of simply returning -EINVAL leads to inconsistent behaviour:
> before ->atomic_open() is called in lookup_open(), the dcache is
> queried. So returning -EINVAL there would make open(O_CREAT|O_DIRECTORY)
> dependent on the cache state of the dentry. By stripping the O_CREAT
> bit, lookup is consistently performed on ->atomic_open() filesystems.
>=20
> There is no separate sysctl for directory creation implemented currently.
> Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
> not enough to allow creating a directory in a sticky folder, because that
> may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
> newer kernels.
>=20
> This feature idea (and some of its description) is taken from the
> UAPI group:
> https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#race-fre=
e-creation-and-opening-of-non-file-inodes
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c            | 86 +++++++++++++++++++++++++++++++++++--------
>  fs/open.c             | 25 +++++++------
>  include/linux/fcntl.h |  6 +++
>  3 files changed, 90 insertions(+), 27 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index eaa0ade4a1b0..5113ac986f50 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1382,13 +1382,12 @@ int may_linkat(struct mnt_idmap *idmap, const struc=
t path *link)
> =20
>  /**
>   * may_create_in_sticky - Check whether an O_CREAT open in a sticky direct=
ory
> - *			  should be allowed, or not, on files that already
> - *			  exist.
> + *			  should be allowed, or not

Why did you remove that clause?  I think it is important.
Maybe change "files" to "objects" or "files/directories"

>   * @idmap: idmap of the mount the inode was found from
>   * @nd: nameidata pathwalk data
>   * @inode: the inode of the file to open
>   *
> - * Block an O_CREAT open of a FIFO (or a regular file) when:
> + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
>   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
>   *   - the file already exists
>   *   - we are in a sticky directory
> @@ -1416,6 +1415,14 @@ static int may_create_in_sticky(struct mnt_idmap *id=
map, struct nameidata *nd,
>  	if (likely(!(dir_mode & S_ISVTX)))
>  		return 0;
> =20
> +	/*
> +	 * There is no separate sysctl for directory creation in sticky
> +	 * folders. Therefore, for the S_ISDIR case, disabling
> +	 * sysctl_protected_regular is not enough to allow creating a
> +	 * directory in a sticky folder, because that may surprise users
> +	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
> +	 * kernels.
> +	 */
>  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
>  		return 0;
> =20
> @@ -1447,6 +1454,12 @@ static int may_create_in_sticky(struct mnt_idmap *id=
map, struct nameidata *nd,
>  					      "sticky_create_regular");
>  			return -EACCES;
>  		}
> +
> +		if (S_ISDIR(inode->i_mode)) {
> +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> +					      "sticky_create_dir");
> +			return -EACCES;
> +		}
>  	}
> =20
>  	return 0;
> @@ -4337,21 +4350,40 @@ static inline int open_to_namei_flags(int flag)
> =20
>  static int may_o_create(struct mnt_idmap *idmap,
>  			const struct path *dir, struct dentry *dentry,
> -			umode_t mode)
> +			umode_t mode, bool create_dir)
>  {
> -	int error =3D security_path_mknod(dir, dentry, mode, 0);
> +	struct inode *dir_inode =3D dir->dentry->d_inode;
> +	int error;
> +
> +	if (create_dir)
> +		error =3D security_path_mkdir(dir, dentry, mode);
> +	else
> +		error =3D security_path_mknod(dir, dentry, mode, 0);
>  	if (error)
>  		return error;
> =20
>  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
>  		return -EOVERFLOW;
> =20
> -	error =3D inode_permission(idmap, dir->dentry->d_inode,
> -				 MAY_WRITE | MAY_EXEC);
> +	error =3D inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
>  	if (error)
>  		return error;
> =20
> -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> +	if (create_dir)
> +		error =3D security_inode_mkdir(dir_inode, dentry, mode);
> +	else
> +		error =3D security_inode_create(dir_inode, dentry, mode);
> +
> +	return error;
> +}
> +
> +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> +		const struct inode *dir, umode_t mode, bool create_dir)
> +{
> +	if (create_dir)
> +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> +	else
> +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  }

I"m still not keen on passing 'bool' args.  Maybe you could pass
open_flags and use O_IS_MKDIR()?  But I won't fight it.

> =20
>  /*
> @@ -4385,6 +4417,7 @@ static struct dentry *atomic_open(const struct path *=
path, struct dentry *dentry
> =20
>  	file->__f_path.dentry =3D DENTRY_NOT_SET;
>  	file->__f_path.mnt =3D path->mnt;
> +
>  	error =3D dir->i_op->atomic_open(dir, dentry, file,
>  				       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
> @@ -4429,6 +4462,10 @@ static struct dentry *atomic_open(const struct path =
*path, struct dentry *dentry
>  	return dentry;
>  }
> =20
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
> +				 struct dentry *, umode_t,
> +				 struct delegated_inode *);
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -4455,10 +4492,14 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	struct dentry *dentry;
>  	int error, create_error =3D 0;
>  	umode_t mode =3D op->mode;
> +	bool create_dir =3D O_IS_MKDIR(open_flag);
> =20
>  	if (unlikely(IS_DEADDIR(dir_inode)))
>  		return ERR_PTR(-ENOENT);
> =20
> +	if (O_IS_MKDIR(open_flag) && dir_inode->i_op->atomic_open)

If you keep "create_dir", you should use it here.

> +		open_flag &=3D ~O_CREAT;
> +
>  	file->f_mode &=3D ~FMODE_CREATED;
>  	dentry =3D d_lookup(dir, &nd->last);
>  	for (;;) {
> @@ -4502,10 +4543,10 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &=3D ~O_TRUNC;
> -		mode =3D vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
> +		mode =3D o_create_mode(idmap, dir_inode, mode, create_dir);
>  		if (likely(got_write))
>  			create_error =3D may_o_create(idmap, &nd->path,
> -						    dentry, mode);
> +						    dentry, mode, create_dir);
>  		else
>  			create_error =3D -EROFS;
>  	}
> @@ -4548,12 +4589,24 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		goto out_dput;
>  	}
> =20
> -	if (!dir_inode->i_op->create) {
> +	if ((create_dir && !dir_inode->i_op->mkdir)
> +	    || (!create_dir && !dir_inode->i_op->create)) {
>  		error =3D -EACCES;
>  		goto out_dput;
>  	}
> =20
> -	error =3D vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
> +	if (create_dir) {
> +		struct dentry *res =3D vfs_mkdir_no_perm(idmap, dir_inode, dentry,
> +						       mode, delegated_inode);
> +		if (IS_ERR(res)) {
> +			error =3D PTR_ERR(res);
> +		} else {
> +			error =3D 0;
> +			dentry =3D res;
> +		}
> +	} else {
> +		error =3D vfs_create_no_perm(idmap, dentry, mode, delegated_inode);
> +	}
>  	if (error)
>  		goto out_dput;
> =20
> @@ -4571,7 +4624,7 @@ static struct dentry *lookup_fast_for_open(struct nam=
eidata *nd, int open_flag)
>  	struct dentry *dentry;
> =20
>  	if (open_flag & O_CREAT) {
> -		if (trailing_slashes(nd->last))
> +		if (trailing_slashes(nd->last) && !(open_flag & O_DIRECTORY))
>  			return ERR_PTR(-EISDIR);
> =20
>  		/* Don't bother on an O_EXCL create */
> @@ -4642,7 +4695,7 @@ static const char *open_last_lookups(struct nameidata=
 *nd,
>  		 */
>  	}
>  	if (open_flag & O_CREAT)
> -		inode_lock(dir->d_inode);
> +		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
>  	else
>  		inode_lock_shared(dir->d_inode);
> =20
> @@ -4705,8 +4758,9 @@ static int do_open(struct nameidata *nd,
>  	if (open_flag & O_CREAT) {
>  		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
>  			return -EEXIST;
> -		if (d_is_dir(nd->path.dentry))
> +		if (!(open_flag & O_DIRECTORY) && d_is_dir(nd->path.dentry))
>  			return -EISDIR;
> +
>  		error =3D may_create_in_sticky(idmap, nd,
>  					     d_backing_inode(nd->path.dentry));
>  		if (unlikely(error))
> @@ -5081,7 +5135,7 @@ struct file *dentry_create(struct path *path, int fla=
gs, umode_t mode,
>  		path->dentry =3D dir;
>  		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> =20
> -		create_error =3D may_o_create(idmap, path, dentry, mode);
> +		create_error =3D may_o_create(idmap, path, dentry, mode, /*create_dir=3D=
*/ false);
>  		if (create_error)
>  			flags &=3D ~O_CREAT;
> =20
> diff --git a/fs/open.c b/fs/open.c
> index 408925d7bd0b..9121aece78bc 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1190,29 +1190,30 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	if (WILL_CREATE(flags)) {
>  		if (how->mode & ~S_IALLUGO)
>  			return -EINVAL;
> -		op->mode =3D how->mode | S_IFREG;
> +		if (O_IS_MKDIR(flags))
> +			op->mode =3D how->mode | S_IFDIR;
> +		else
> +			op->mode =3D how->mode | S_IFREG;
>  	} else {
>  		if (how->mode !=3D 0)
>  			return -EINVAL;
>  		op->mode =3D 0;
>  	}
> =20
> -	/*
> -	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
> -	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
> -	 * O_TMPFILE below which requires O_DIRECTORY being raised.
> -	 */
> -	if ((flags & (O_DIRECTORY | O_CREAT)) =3D=3D (O_DIRECTORY | O_CREAT))
> -		return -EINVAL;
> -
>  	/* Now handle the creative implementation of O_TMPFILE. */
>  	if (flags & __O_TMPFILE) {
>  		/*
>  		 * In order to ensure programs get explicit errors when trying
>  		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
> -		 * is raised alongside __O_TMPFILE.
> +		 * is raised alongside __O_TMPFILE, but without O_CREAT. The
> +		 * reason for disallowing O_CREAT|O_TMPFILE is that
> +		 * O_DIRECTORY|O_CREAT used to work and created a regular file
> +		 * if nothing existed at the open path. Hence, allowing the
> +		 * combination would have caused O_CREAT|O_TMPFILE to create a
> +		 * regular (non-temporary) file on old kernels, while the caller
> +		 * would believe they created an actual O_TMPFILE.
>  		 */
> -		if (!(flags & O_DIRECTORY))
> +		if (!(flags & O_DIRECTORY) || (flags & O_CREAT))
>  			return -EINVAL;
>  		if (!(acc_mode & MAY_WRITE))
>  			return -EINVAL;
> @@ -1270,6 +1271,8 @@ inline int build_open_flags(const struct open_how *ho=
w, struct open_flags *op)
>  	op->intent =3D flags & O_PATH ? 0 : LOOKUP_OPEN;
> =20
>  	if (flags & O_CREAT) {
> +		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> +			return -EISDIR;
>  		op->intent |=3D LOOKUP_CREATE;
>  		if (flags & O_EXCL) {
>  			op->intent |=3D LOOKUP_EXCL;
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index 6ad6b9e7a226..6b75277be559 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -30,6 +30,12 @@
>   */
>  #define __O_REGULAR		(1 << 30)
> =20
> +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> +static inline bool O_IS_MKDIR(unsigned flags)
> +{
> +	return (flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK;
> +}
> +
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> --=20
> 2.55.0
>=20
>=20

The rest looks good.

Thanks,
NeilBrown
