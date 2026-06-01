Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0042765DF;
	Mon,  1 Jun 2026 03:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780283775; cv=none; b=mDA9OGLtcklABU51+drIwZ6WjCdLtxoZ7xAmf7TOKb9Zhxr856iXnZiX1vrA2aSmPRzd5ZPJoJCNqXq1rhU8yUnIW+ph7MSb9gjpJMyfV7rGbL7ls5HNTl2wD5MWvurJoHy8SwT+rw5x8X0tIpY0C02YwHn9aixH8p7GGqyx9zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780283775; c=relaxed/simple;
	bh=qFwcwP1Bjvm5ZjjnQklgNdakIsiCyyiNrG+b7w4oQAQ=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=qtxOVdC8KpyUfln2JEYhLsTEQynvSXfmawPKMfJ2i5VeAlyIeJPvnwjoHQOehpwGQeWMq9x6U/HLPoSY6FH7u6ifi24N5liIJvza/CSwhCEjOvBBIWAKo/j5SkMnoRvWId9YwFXvVYdhYJAezLrL6u7z8jpvmVmfqyuNEzVFGeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=h8z429Se; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NqnasFB7; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="h8z429Se";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NqnasFB7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 644037A011C;
	Sun, 31 May 2026 23:16:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Sun, 31 May 2026 23:16:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1780283768; x=1780370168; bh=54Q7DPNvy9yS46dwfZ72fUlvFXEcDuh7QDk
	Zx9mniIs=; b=h8z429SecdUhzEbGnOsNKRIq3VEsO5mDejLrGQ8/EYIifX+Z0Ry
	p+Lal/CKf8avY7JNhibpbIjmhRvu9wiYs5rRX4tYed+MkHIYr+3yipgNiW0+IkZp
	RaNxmR7jaro8I9HlCZGHPpCd86O3CQYW/I/nLUVuqVGgu2GawdDUPyW6fiYJOqxM
	EaLPe/FlcnHuGuqd7Cckuh4lSINbxzWLs+hLDcktGCXLkpiVvvGajagWHVSOVk8p
	krMlMlGcu2Xg4Bc6ppDbwCDhVv5dzAjkREu9cVey3njvpe7FHKeHe5bYMS80kph1
	JV6HbkWGDHgCrqVSJFLwpk7Ulo8fhYTWiIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1780283768; x=
	1780370168; bh=54Q7DPNvy9yS46dwfZ72fUlvFXEcDuh7QDkZx9mniIs=; b=N
	qnasFB7YOliV2WJD95Fd7249DOZWuKzPGix34IEjNYbqKek/NA6rxa82yy5nVKPR
	JnxglM3VBw08nHd4IdUY1J4GmGh2MWlFkHyYw+EFMJ+KYWn2tHtQwe6Ygp23fec0
	wJOK+bMx+6MVY/K0oAmfdGjrAR3ycv2xZB2VKRkRnourasrA9Qlb57AN+ApJxLU0
	JwFAoYZUfcqOVLydb/1zyR2kBPZohXpVGA6dw2gDwKByen9foPpNOV9dSHNGhPG8
	7DHu4jl7dE91YwcQYDdNgJEFP1ULW3q8M09xdaotJaCCaUj1PfdixEygwbNftMon
	xLFGDYJfxM1fXVXFhp4Kw==
X-ME-Sender: <xms:d_kcamx67yacFgXkC6NA93Z5--8ipynFIrQFj_2tCG_BJTZf0UiHCg>
    <xme:d_kcaqc49gH_6RDP2rF0ZiLu39alfbpCujAgHc-vhG91Mb9zV7Z3OyS9IIfHycPLU
    H-Xd8p2e1HV-7YwNTI1CYYeRT2qVBVuumw3B7fkAGfLoM4Lzw>
X-ME-Received: <xmr:d_kcaj7rKqJXLdM2rnq7aD0t2V4nBgAY30yrKNhtrICv8TLlMXtYOsl7FMOm9KHglS8-UVMhgNJl1WES0mg1KetSsx8qnf4>
X-ME-Proxy-Cause: dmFkZTFAO1Fjk5y+1M7ArVpnPz6/Wn2rT/VYtih0sPL+WBFHXry9QcieLONEZVmKcbaYCl
    +znvcHxMrR+RtreN4CsbtbXbsjNU2hRWLmjCTCRqtiA0iNKLjlWJfNqc2scFlsxpER0B+1
    Ye5MXo08MTvt/QFXTJfxJ6JjlayC0t/OER7VrpVo1T/gV2OyIQLWluNBWc3ndwlhFfy0O0
    7TtXKgZz3XcWmAwiWLaS6AXsEaif2lPSKmVSEQoXNugc43GouiviILalqo+tyviXWMBJRt
    NRjzhP5rh5LHDDMdA0LcC2p5HGcrt4YYgT3btMTEplBoP6lkw9G0J8qV6hXEIviM6wcfEp
    vAQvlRZfq99JA7pweNkCFvb3m4ZERj4mL8yUiPgLh222IZ7ysegMAmCPwrCP9buo8kdC/f
    HzJTt8BOIR8Gi6Zcy7QxnPQytlNUKQ+kQNOetTGZ6ZeUChP1BvPhmtX4FL52oLfdtUBIL/
    Dl4FJZdRIngdiBNYNTnwvHHPibdBs28DcuBrsLKEDt2f1k52LFE2KMFsXs5hSUzUNRpnCI
    5qpb38DSHr5Ay/zILoVAXSujnAdFU2l4o94REwBvx4CF2SS8n0HC+zKFN+D2vG8IvtPgPk
    BeKj5Veea7TA0y3frtNzbkWwkmZZwhryNMiyqpdipv/BnCKOkG7R+oVJgWUg
X-ME-Proxy: <xmx:d_kcanJjQJ-IxydGYjLeqliXDlXQ7SUChYP2J4ZOCbB6ftTJnF5Myg>
    <xmx:d_kcajwHKSicbosaPmEhJapinAYTYYpWWKSot6q536JaOIVZZjBGYA>
    <xmx:d_kcanLPLKCtisOIGfSqashTKn9QAntfrwSTT-UAfVXi-OoW650w1A>
    <xmx:d_kcaqXaV16or1xLq-yc9sjxJq1OaZfiIiXh0s1vmnWvn5N0F7lgtw>
    <xmx:ePkcarYmh95lc1278QvStVq2Sx6-zfHyoGJtqUi_5g8IbB6X7Qe4z7cu>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 31 May 2026 23:16:04 -0400 (EDT)
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
Subject: Re: [RFC PATCH v6 7/9] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260531182045.171711-8-jkoolstra@xs4all.nl>
References: <20260531182045.171711-1-jkoolstra@xs4all.nl>
  <20260531182045.171711-8-jkoolstra@xs4all.nl>
Date: Mon, 01 Jun 2026 13:16:01 +1000
Message-id: <178028376148.2923901.10614738518137561136@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Mon, 01 Jun 2026, Jori Koolstra wrote:
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
> O_CREAT|O_DIRECTORY is blocked in atomic_open() until individual
> filesytems that support i_op->atomic_open() are given tailored support.
>=20
> This feature idea (and some of its description) is taken from the
> UAPI group:
> https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#race-fre=
e-creation-and-opening-of-non-file-inodes
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c            | 94 +++++++++++++++++++++++++++++++++----------
>  fs/open.c             | 25 +++++++-----
>  include/linux/fcntl.h |  7 ++++
>  3 files changed, 94 insertions(+), 32 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index a8c247e0bb65..724b9de6831a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1377,13 +1377,12 @@ int may_linkat(struct mnt_idmap *idmap, const struc=
t path *link)
> =20
>  /**
>   * may_create_in_sticky - Check whether an O_CREAT open in a sticky direct=
ory
> - *			  should be allowed, or not, on files that already
> - *			  exist.
> + *			  should be allowed, or not
>   * @idmap: idmap of the mount the inode was found from
>   * @nd: nameidata pathwalk data
>   * @inode: the inode of the file to open
>   *
> - * Block an O_CREAT open of a FIFO (or a regular file) when:
> + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
>   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
>   *   - the file already exists
>   *   - we are in a sticky directory
> @@ -1411,6 +1410,12 @@ static int may_create_in_sticky(struct mnt_idmap *id=
map, struct nameidata *nd,
>  	if (likely(!(dir_mode & S_ISVTX)))
>  		return 0;
> =20
> +	// There is no separate sysctl for directory creation in sticky
> +	// folders. Therefore, for the S_ISDIR case, disabling
> +	// sysctl_protected_regular is not enough to allow creating a
> +	// directory in a sticky folder, because that may suprise users
> +	// not expecting that O_CREAT|O_DIRECTORY is possible on newer
> +	// kernels.
>  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
>  		return 0;
> =20
> @@ -1442,6 +1447,12 @@ static int may_create_in_sticky(struct mnt_idmap *id=
map, struct nameidata *nd,
>  					      "sticky_create_regular");
>  			return -EACCES;
>  		}
> +
> +		if (sysctl_protected_regular >=3D 2 && S_ISDIR(inode->i_mode)) {
> +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> +					      "sticky_create_dir");
> +			return -EACCES;
> +		}
>  	}
> =20
>  	return 0;
> @@ -4215,7 +4226,7 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry=
 *dentry, umode_t mode,
>  		return error;
> =20
>  	if (!dir->i_op->create)
> -		return -EACCES;	/* shouldn't it be ENOSYS? */
> +		return -EACCES; /* shouldn't it be ENOSYS? */

You've changed a TAB to a SPACE here.  You probably didn't mean to.

> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  	error =3D security_inode_create(dir, dentry, mode);
> @@ -4339,21 +4350,40 @@ static inline int open_to_namei_flags(int flag)
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

I still don't see a justification for different permission masks.
There should be a comment explaining why there is a difference, though
I'm not convinced a difference is needed.

>  }
> =20
>  /*
> @@ -4379,8 +4409,12 @@ static struct dentry *atomic_open(const struct path =
*path, struct dentry *dentry
> =20
>  	file->__f_path.dentry =3D DENTRY_NOT_SET;
>  	file->__f_path.mnt =3D path->mnt;
> -	error =3D dir->i_op->atomic_open(dir, dentry, file,
> -				       open_to_namei_flags(open_flag), mode);
> +
> +	if (O_IS_MKDIR(open_flag))
> +		error =3D EINVAL;
> +	else
> +		error =3D dir->i_op->atomic_open(dir, dentry, file,
> +					       open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> @@ -4413,6 +4447,10 @@ static struct dentry *atomic_open(const struct path =
*path, struct dentry *dentry
>  	return dentry;
>  }
> =20
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
> +				 struct dentry *, umode_t,
> +				 struct delegated_inode *);

forward declaration aren't ideal...  This is a new function that you
introduced.  Could you place it earlier when you introduce it?

>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -4439,6 +4477,7 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  	struct dentry *dentry;
>  	int error, create_error =3D 0;
>  	umode_t mode =3D op->mode;
> +	bool create_dir =3D O_IS_MKDIR(open_flag);
>  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> =20
>  	if (unlikely(IS_DEADDIR(dir_inode)))
> @@ -4487,10 +4526,10 @@ static struct dentry *lookup_open(struct nameidata =
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
> @@ -4527,14 +4566,26 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -
> -		if (!dir_inode->i_op->create) {
> +		if ((create_dir && !dir_inode->i_op->mkdir)
> +		    || (!create_dir && !dir_inode->i_op->create)) {
>  			error =3D -EACCES;
>  			goto out_dput;
>  		}
> =20
> -		error =3D vfs_create_no_perm(idmap, dentry, mode, delegated_inode,
> -					   open_flag & O_EXCL);
> +		if (create_dir) {
> +			struct dentry *res =3D vfs_mkdir_no_perm(idmap, dir_inode, dentry,
> +							       mode, delegated_inode);
> +			if (IS_ERR(res)) {
> +				error =3D PTR_ERR(res);
> +			} else {
> +				error =3D 0;
> +				dentry =3D res;
> +			}
> +		} else {
> +			error =3D vfs_create_no_perm(idmap, dentry, mode, delegated_inode,
> +						   open_flag & O_EXCL);
> +
> +		}
>  		if (error)
>  			goto out_dput;
> =20
> @@ -4553,7 +4604,7 @@ static struct dentry *lookup_fast_for_open(struct nam=
eidata *nd, int open_flag)
>  	struct dentry *dentry;
> =20
>  	if (open_flag & O_CREAT) {
> -		if (trailing_slashes(nd))
> +		if (trailing_slashes(nd) && !(open_flag & O_DIRECTORY))
>  			return ERR_PTR(-EISDIR);
> =20
>  		/* Don't bother on an O_EXCL create */
> @@ -4624,7 +4675,7 @@ static const char *open_last_lookups(struct nameidata=
 *nd,
>  		 */
>  	}
>  	if (open_flag & O_CREAT)
> -		inode_lock(dir->d_inode);
> +		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
>  	else
>  		inode_lock_shared(dir->d_inode);
> =20
> @@ -4687,8 +4738,9 @@ static int do_open(struct nameidata *nd,
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
> @@ -5054,7 +5106,7 @@ struct file *dentry_create(struct path *path, int fla=
gs, umode_t mode,
>  		path->dentry =3D dir;
>  		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> =20
> -		create_error =3D may_o_create(idmap, path, dentry, mode);
> +		create_error =3D may_o_create(idmap, path, dentry, mode, /*create_dir=3D=
*/ false);

I don't really like this construct for passing bools, but if no-one else
complains I guess I won't.

>  		if (create_error)
>  			flags &=3D ~O_CREAT;
> =20
> diff --git a/fs/open.c b/fs/open.c
> index 681d405bc61e..5cf8ada58483 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *=
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
> @@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how *ho=
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
> index a332e79b3207..79843e8add6e 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -12,6 +12,13 @@
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
>  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> =20
> +
> +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> +static inline bool O_IS_MKDIR(unsigned flags)
> +{
> +    return (flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK;
> +}
> +
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> --=20
> 2.54.0
>=20
>=20

Mostly looks good thanks - and is definitely easier to read with all the
other stuff factored out into other patches.

NeilBrown
