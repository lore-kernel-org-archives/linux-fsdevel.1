Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA530282F05;
	Wed, 27 May 2026 07:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866885; cv=none; b=qjwYRXHhRC6FHvFp1m8loUMsEbYYBJ3VifDFt4+pGFFIlGvw2XpdX/VGciJ6xnWBd+++i1XjhnFt+WWtQK7Nj9YGMF1igyaa5M4EQLe5D8Bze14BtluBjC8fX984LwPwFL377Kx2HcKTnU1VrTybvBlDIA2+9siR9l6ZnpzDD60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866885; c=relaxed/simple;
	bh=vlkz0g3OI/Vp8/k2RELcUG0D4eeDWK+Yx7AqfUsxVuc=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=j2Nc+Yy9gHeCnd5pFdwolQYfqgyU6GxMLkVvnM5wnHr9TgTTgPjINEiKNZYvwSP536MOxFR1Ho9Z19TslUsmxjMlBWD2N7Ch2II/9p0kmL0fQriTR0yDIg/BL0R52HqLRXtA+bt6KOnW2sIgtoLj/b7bgnsZoxVI/Hq+DzG7XTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=Ys3BnB4b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XKzkHPtO; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="Ys3BnB4b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XKzkHPtO"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 880311D0007B;
	Wed, 27 May 2026 03:28:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 27 May 2026 03:28:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm3; t=
	1779866881; x=1779953281; bh=3XwO/+V37KVrRNpcEaN1SRMQKJO+ru5dnmD
	qhl3Butw=; b=Ys3BnB4bB51G9bAX2plf8tiNxXmxDtSmSX8Q/INFSdF3l7dBAcP
	T0AUriIXJRvyGV4dCImYro0rSjxEx17VLj55PCCWys6JFx0Pl0tc3/xQEsbusV/a
	LbiVQ7WVYFwGn16IJGYLahxgCylZYJm+F4STGVBh9NXrABxsgdDR2mFxA20aDef+
	WXrsLjle7bD3tLkikhtl0pq5u55C7ywsMa8GP5l61bhh66bnmkEAQiHt4Fi+NNI9
	SYGeJf6xszAyLMNQlMkHKe7+RR+Wdep/bBHpUQR6SVLIoYdHZNL00pkJ2J7Bl3IU
	P94QZTtGdymTC4dErzjq+j1R2OrDBBLef8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779866881; x=
	1779953281; bh=3XwO/+V37KVrRNpcEaN1SRMQKJO+ru5dnmDqhl3Butw=; b=X
	KzkHPtOadzD/Ys0uigqcaAxJbnC563xvLxjo55HpwM0ZelI5y0YQN8Kug04reCin
	Xpfojy8aR16t3tQYzxvPMpY3r1TvGTll9sjuKXUYUulEOM406PQKAnV2aVIVqaP/
	WGy4r7Oh+2cmPneCXyxIm6aOO2MznEYaY9tSI/O99S+KsZ24aUTUl3FppRIGRpLe
	SlbwUicBYJjvDccqRsCU85FQBo3VbxZKL9b8QJRYKdoOpXhRwSCKcKM1Sfog//ZJ
	nzibJdd26+arIdR/me9Y/1BSNwT4Gpt705pk4L9G9uiuEb6xCHGNrUCdsur3hS49
	cDtxszp+8lPQtvGcx6mlA==
X-ME-Sender: <xms:AJ0WarUVx6T86N3Bk1fhjVu4QzXBn3EjEFzQX_fgSk3RfhuQY6QxYg>
    <xme:AJ0WamK81DGPw5IbseLwKAgmQEGH4f2jM70vGskQzNZ6qDyAbVV9yoS_YC1mpcpRW
    8JVgYfDeaobMYfnsUzm-W46BTBEeuuUIg_ECNOaa6uPoPejRg>
X-ME-Received: <xmr:AJ0WarAWSoYKsOAgvd5PV2h-IhY89PFazP9eLSMjBmm8J60sjxcbfy9G5-GGFxt1wwMcWMLvyIEFEOv-NW-fiIcNOtI2WTE>
X-ME-Proxy-Cause: dmFkZTGzGGfIMu6kVafRuqU7pAz0xAQ+4OXj4xUTz7W9gcgHPLaOgVfs+eG5gUgVhyjUUs
    mKMGsFuonZgnMx8FGzxt2iHdD+DUAVxeKJr0JUult6V9CxG7mOenhrSU1yNNATxGOUmB8F
    QL59h12zRcNKoeA9VWv/Z7X5XNqZjMRieDDnaU7rFd+7zigSRByDRWvRej/SKIBwowA1X1
    50L3R+WoWbX/5rLNTnf+HBtU3KE3mhZGCmSWiW86BS2BeTq4KJdjyZ4RLJxBnCIqNpiGo9
    TAkFIDe3o0IKqsSfcpGFGj71n4BgaUrnPWVGocA61EHTzFebbVeDF6nltLH/9Zki9DXmtC
    0zsHl0fy23DwTzEeV2EbvY7LdI3HbfQqZegX8B6HrusLa7woOgqVLPViZYWhGrpSZPZVyX
    8oxnDm5N3EgT1WT/cl0ZOccd2vuxuUe6F8goFDrp47FCa3jfuS8jbbsoMPIdehoJkmHtVP
    +M6NLAgt3YCIa28MNr6PrbAuxFjmD3w8VqBjTo9G9t0n5aTJoMJQSovNEzuMmbmFirOtPb
    tQN9dmyCUCrdDC7RlwKlTkNZ87+31Xmamyww6UxncyHLQNFdyWg+mbzMxHmrVEZaKettpf
    yPtiQ4JyGfLejfiNiOUVC7mH/7U8ElejTrI0IxoE5xstR6i21U2toDCh8OVA
X-ME-Proxy: <xmx:AJ0Wamd-ulXlz8TfLVLtABD3t71PxDV_lGGzrv5qiB3b3gzwFzhJgw>
    <xmx:AJ0Waq2LbGhEAh_6R-JfW1tLPujFX95nJUxnfX6gZoHxP9DTnSq7Yg>
    <xmx:AJ0Watic0tYJIcaRiHOwajiZJIDa4IKi0ZxiSjyG-lK6yURSeuFMjg>
    <xmx:AJ0WajnUvWAf1rdnHFhSgUcdsQaGE_SPRx3USy3sz5oqFbQp9aJ3UA>
    <xmx:AZ0WamvyagndXaF0TmBvJ7Jmbez0lFcJWtoQ9_d25ubajsmE06UjST2i>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 03:27:58 -0400 (EDT)
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
 "Aleksa Sarai" <cyphar@cyphar.com>, "Jori Koolstra" <jkoolstra@xs4all.nl>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 cmirabil@redhat.com
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260525202937.466497-2-jkoolstra@xs4all.nl>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
  <20260525202937.466497-2-jkoolstra@xs4all.nl>
Date: Wed, 27 May 2026 17:27:54 +1000
Message-id: <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Tue, 26 May 2026, Jori Koolstra wrote:
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
> This commit also changes the error returned when a filesystem operation
> is unsupported (i_op->mkdir/creat) to EOPNOTSUPP. Current error values
> are inconsistent (both EPERM and EACCES are used) and confusing.

This commit description is good at justifying the change.  But it is not
so good at explaining the details of how the change happens so that a
reviewer can match the code with the explanation.  There is a lot
happening here and I think I would rather it were split into a few
separate patches so it is easier to comprehend.

I *think* the intention is that this new functionality would not be
available on filesystems which support ->atomic_open, until those
filesystems are given tailored support.  Is that correct?  Spelling that
out at the start would be useful.  I would implement that by checking
for O_DIRECTORY in atomic_open() and leaving the filesystems untouched.
Then a patch later in the series would move that test into the various
filesystems.

I'm not convinced the change to EOPNOTSUPP is a good idea.  It should
be a separate patch so that it can be reviewed separately.

EOPNOTSUPP is documented as
       EOPNOTSUPP      Operation not supported on socket (POSIX.1-2001).

and we have no sockets here!
ENOTSUP might be a reasonable choice - though it has the same numeric
value and it often confused with EOPNOTSUPP in the kernel.

I don't think EACCES is particularly good, but I don't think anything
else is enough better to justify a change.

Other comments interleaved...

>=20
> This feature idea (and some of its description) is taken from the
> UAPI group:
> https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#race-fre=
e-creation-and-opening-of-non-file-inodes
>=20
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/9p/vfs_inode.c      |   3 +
>  fs/9p/vfs_inode_dotl.c |   3 +
>  fs/ceph/file.c         |   3 +
>  fs/fuse/dir.c          |   3 +
>  fs/gfs2/inode.c        |   3 +
>  fs/namei.c             | 177 +++++++++++++++++++++++++++--------------
>  fs/nfs/dir.c           |   3 +
>  fs/nfs/file.c          |   3 +
>  fs/open.c              |  25 +++---
>  fs/smb/client/dir.c    |   3 +
>  fs/vboxsf/dir.c        |   3 +
>  include/linux/fcntl.h  |   2 +
>  12 files changed, 161 insertions(+), 70 deletions(-)
>=20
> diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
> index f468acb8ee7d..d1925333d327 100644
> --- a/fs/9p/vfs_inode.c
> +++ b/fs/9p/vfs_inode.c
> @@ -771,6 +771,9 @@ v9fs_vfs_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	struct inode *inode;
>  	int p9_omode;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +

O_MKDIR_MASK is only ever used in this construct.  I would prefer
something like

static inline bool O_IS_MKDIR(unsigned flags)
{
    return (flags & (O_CREAT|O_DIRECTORY)) =3D=3D O_CREAT|O_DIRECTORY);
}

so we would have

   if (O_IS_MKDIR(flags))
         return -EINVAL;


>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
> index 141fb54db65d..9f4b865d07d7 100644
> --- a/fs/9p/vfs_inode_dotl.c
> +++ b/fs/9p/vfs_inode_dotl.c
> @@ -239,6 +239,9 @@ v9fs_vfs_atomic_open_dotl(struct inode *dir, struct den=
try *dentry,
>  	struct v9fs_session_info *v9ses;
>  	struct posix_acl *pacl =3D NULL, *dacl =3D NULL;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D v9fs_vfs_lookup(dir, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index d54d71669176..9707d9ed17b6 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -813,6 +813,9 @@ int ceph_atomic_open(struct inode *dir, struct dentry *=
dentry,
>  	if (dentry->d_name.len > NAME_MAX)
>  		return -ENAMETOOLONG;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	err =3D ceph_wait_on_conflict_unlink(dentry);
>  	if (err)
>  		return err;
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index b658b6baf72f..4c59992b9867 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -940,6 +940,9 @@ static int fuse_atomic_open(struct inode *dir, struct d=
entry *entry,
>  	if (fuse_is_bad(dir))
>  		return -EIO;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	if (d_in_lookup(entry)) {
>  		struct dentry *res =3D fuse_lookup(dir, entry, 0);
>  		if (res || d_really_is_positive(entry))
> diff --git a/fs/gfs2/inode.c b/fs/gfs2/inode.c
> index e9bf4879c07f..21c6544fbee5 100644
> --- a/fs/gfs2/inode.c
> +++ b/fs/gfs2/inode.c
> @@ -1384,6 +1384,9 @@ static int gfs2_atomic_open(struct inode *dir, struct=
 dentry *dentry,
>  {
>  	bool excl =3D !!(flags & O_EXCL);
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *d =3D __gfs2_lookup(dir, dentry, file);
>  		if (file->f_mode & FMODE_OPENED) {
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..9d9529ef30c4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2777,9 +2777,14 @@ static const char *path_init(struct nameidata *nd, u=
nsigned flags)
>  	return s;
>  }
> =20
> +static inline bool trailing_slashes(struct nameidata *nd)
> +{
> +	return (bool)nd->last.name[nd->last.len];
> +}

Moving and reusing this function could be a patch on its own.  It is a
nice tidy-up which is unrelated to the rest of the change.

> +
>  static inline const char *lookup_last(struct nameidata *nd)
>  {
> -	if (nd->last_type =3D=3D LAST_NORM && nd->last.name[nd->last.len])
> +	if (nd->last_type =3D=3D LAST_NORM && trailing_slashes(nd))
>  		nd->flags |=3D LOOKUP_FOLLOW | LOOKUP_DIRECTORY;
> =20
>  	return walk_component(nd, WALK_TRAILING);
> @@ -4166,6 +4171,16 @@ static inline umode_t vfs_prepare_mode(struct mnt_id=
map *idmap,
>  	return mode;
>  }
> =20
> +static int __vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, um=
ode_t mode,
> +			struct delegated_inode *di, bool excl)
> +{
> +	struct inode *dir =3D d_inode(dentry->d_parent);
> +	int error =3D try_break_deleg(dir, di);
> +	if (error)
> +		return error;
> +	return dir->i_op->create(idmap, dir, dentry, mode, excl);
> +}

I don't understand why you have factored this out.  Why not leave the
try_break_deleg() where it was?
This is the sort of thing that really benefits from a few words in the
commit message.

> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -4192,16 +4207,14 @@ int vfs_create(struct mnt_idmap *idmap, struct dent=
ry *dentry, umode_t mode,
>  		return error;
> =20
>  	if (!dir->i_op->create)
> -		return -EACCES;	/* shouldn't it be ENOSYS? */
> +		return -EOPNOTSUPP;
> =20
>  	mode =3D vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  	error =3D security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error =3D try_break_deleg(dir, di);
> -	if (error)
> -		return error;
> -	error =3D dir->i_op->create(idmap, dir, dentry, mode, true);
> +
> +	error =3D __vfs_create(idmap, dentry, mode, di, true);
>  	if (!error)
>  		fsnotify_create(dir, dentry);
>  	return error;
> @@ -4321,21 +4334,32 @@ static inline int open_to_namei_flags(int flag)
> =20
>  static int may_o_create(struct mnt_idmap *idmap,
>  			const struct path *dir, struct dentry *dentry,
> -			umode_t mode)
> +			umode_t mode, bool create_dir)
                                      ^^^^^^

I don't like bool arguments much.  Particularly when code passes a
literal "true" or "false" as in

	create_error =3D may_o_create(idmap, path, dentry, mode, false);

as it isn't clear what the "false" is supposed to mean.
Could we arrange to pass S_IFDIR or S_IFREG as appropriate?
Or somehow make the intent of that 5th arg more obvious.

>  {
> -	int error =3D security_path_mknod(dir, dentry, mode, 0);
> +	struct inode *dir_inode =3D dir->dentry->d_inode;
> +	int error;
> +
> +	error =3D create_dir ? security_path_mkdir(dir, dentry, mode)
> +			   : security_path_mknod(dir, dentry, mode, 0);
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
> +	return create_dir ? security_inode_mkdir(dir_inode, dentry, mode)
> +			  : security_inode_create(dir_inode, dentry, mode);
> +}
> +
> +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> +		const struct inode *dir, umode_t mode, bool create_dir)
> +{
> +	return create_dir ? vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVT=
X, 0)
> +			  : vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);

It isn't clear the purpose of this.
In the create_dir case, shouldn't we pass S_IFDIR as the last arg: type?

The difference between "S_IRWXUGO | S_ISVTX" and "S_IALLUGO" is not
immediately obvious, but the former excludes S_ISUID and S_ISGID.
The setuid bit is meaningless on directories so there is little point in
stripping it, but I don't object as long as the intent is documented
here.
The setgid bit is meaningful but vfs_prepare_mode() seems to already
handle it correctly for directories if you pass the type as S_IFDIR.
If you have a good reason to impose different handling here, that might
be sensible, but it should be documented.

>  }
> =20
>  /*
> @@ -4388,6 +4412,9 @@ static struct dentry *atomic_open(const struct path *=
path, struct dentry *dentry
>  	return dentry;
>  }
> =20
> +static struct dentry *__vfs_mkdir(struct mnt_idmap *, struct inode *,
> +			 struct dentry *, umode_t,
> +			 struct delegated_inode *);
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -4412,8 +4439,9 @@ static struct dentry *lookup_open(struct nameidata *n=
d, struct file *file,
>  	struct inode *dir_inode =3D dir->d_inode;
>  	int open_flag =3D op->open_flag;
>  	struct dentry *dentry;
> -	int error, create_error =3D 0;
> +	int error =3D 0, create_error =3D 0;
>  	umode_t mode =3D op->mode;
> +	bool create_dir =3D (open_flag & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK;
>  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> =20
>  	if (unlikely(IS_DEADDIR(dir_inode)))
> @@ -4462,10 +4490,10 @@ static struct dentry *lookup_open(struct nameidata =
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
> @@ -4494,29 +4522,37 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  		}
>  	}
> =20
> +	if (unlikely(create_error) && !dentry->d_inode) {
> +		error =3D create_error;
> +		goto out_dput;
> +	}
> +
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> -		/* but break the directory lease first! */
> -		error =3D try_break_deleg(dir_inode, delegated_inode);
> -		if (error)
> -			goto out_dput;
> =20
>  		file->f_mode |=3D FMODE_CREATED;
>  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> -		if (!dir_inode->i_op->create) {
> -			error =3D -EACCES;
> +		if ((create_dir && !dir_inode->i_op->mkdir)
> +		    || (!create_dir && !dir_inode->i_op->create)) {
> +			error =3D -EOPNOTSUPP;
>  			goto out_dput;
>  		}
> =20
> -		error =3D dir_inode->i_op->create(idmap, dir_inode, dentry,
> -						mode, open_flag & O_EXCL);
> +		if (create_dir) {
> +			struct dentry *res =3D __vfs_mkdir(idmap, dir_inode, dentry, mode,
> +							 delegated_inode);
> +			if (IS_ERR(res))
> +				error =3D PTR_ERR(res);
> +			else
> +				dentry =3D res;
> +		} else {
> +			error =3D __vfs_create(idmap, dentry, mode, delegated_inode,
> +					     open_flag & O_EXCL);
> +		}
>  		if (error)
>  			goto out_dput;
>  	}
> -	if (unlikely(create_error) && !dentry->d_inode) {
> -		error =3D create_error;
> -		goto out_dput;
> -	}
> +
>  	return dentry;
> =20
>  out_dput:
> @@ -4524,17 +4560,12 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
>  	return ERR_PTR(error);
>  }
> =20
> -static inline bool trailing_slashes(struct nameidata *nd)
> -{
> -	return (bool)nd->last.name[nd->last.len];
> -}
> -
>  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_=
flag)
>  {
>  	struct dentry *dentry;
> =20
>  	if (open_flag & O_CREAT) {
> -		if (trailing_slashes(nd))
> +		if (trailing_slashes(nd) && !(open_flag & O_DIRECTORY))
>  			return ERR_PTR(-EISDIR);
> =20
>  		/* Don't bother on an O_EXCL create */
> @@ -4605,13 +4636,17 @@ static const char *open_last_lookups(struct nameida=
ta *nd,
>  		 */
>  	}
>  	if (open_flag & O_CREAT)
> -		inode_lock(dir->d_inode);
> +		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
>  	else
>  		inode_lock_shared(dir->d_inode);
>  	dentry =3D lookup_open(nd, file, op, got_write, &delegated_inode);
>  	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir->d_inode, dentry);
> +		if (file->f_mode & FMODE_CREATED) {
> +			if (open_flag & O_DIRECTORY)
> +				fsnotify_mkdir(dir->d_inode, dentry);
> +			else
> +				fsnotify_create(dir->d_inode, dentry);
> +		}
>  		if (file->f_mode & FMODE_OPENED)
>  			fsnotify_open(file);
>  	}
> @@ -4672,12 +4707,16 @@ static int do_open(struct nameidata *nd,
>  	if (open_flag & O_CREAT) {
>  		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
>  			return -EEXIST;
> -		if (d_is_dir(nd->path.dentry))
> -			return -EISDIR;
> -		error =3D may_create_in_sticky(idmap, nd,
> -					     d_backing_inode(nd->path.dentry));
> -		if (unlikely(error))
> -			return error;
> +		// there are no special rules for creating dirs in a sticky bit dir

Maybe there *should* be special rules for creating dirs.
I don't know the details of the exploits that these rules protect
against, but if we add O_CREAT|O_DIRECTORY and people start using
it, and they don't do appropriate validation in sticky
directories (and the whole point here is to avoid the need
for validation) then maybe similar sorts of bugs and exploits
could appear.

I would recommend that O_CREAT|O_DIRECTORY must never successfully open
a directory with different ownership in a sticky directory.  There is no
need for a sysctl, because there is no legacy behaviour to protect.

Q: is O_EXCL supported with O_CREAT|O_DIRECTORY? I didn't notice
and special handling, but I could easily have missed it.


> +		if (!(open_flag & O_DIRECTORY)) {
> +			if (d_is_dir(nd->path.dentry))
> +				return -EISDIR;
> +
> +			error =3D may_create_in_sticky(idmap, nd,
> +						     d_backing_inode(nd->path.dentry));
> +			if (unlikely(error))
> +				return error;
> +		}
>  	}
>  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
>  		return -ENOTDIR;
> @@ -5039,7 +5078,7 @@ struct file *dentry_create(struct path *path, int fla=
gs, umode_t mode,
>  		path->dentry =3D dir;
>  		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> =20
> -		create_error =3D may_o_create(idmap, path, dentry, mode);
> +		create_error =3D may_o_create(idmap, path, dentry, mode, false);
>  		if (create_error)
>  			flags &=3D ~O_CREAT;
> =20
> @@ -5207,6 +5246,37 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename=
, umode_t, mode, unsigned, d
>  	return filename_mknodat(AT_FDCWD, name, mode, dev);
>  }
> =20
> +static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *d=
ir,
> +			 struct dentry *dentry, umode_t mode,
> +			 struct delegated_inode *di)
> +{
> +	int error;
> +	unsigned max_links =3D dir->i_sb->s_max_links;
> +	struct dentry *de;
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
> +	return dentry;
> +
> +err:
> +	return ERR_PTR(error);
> +}
> +
>  /**
>   * vfs_mkdir - create directory returning correct dentry if possible
>   * @idmap:		idmap of the mount the inode was found from
> @@ -5231,17 +5301,16 @@ SYSCALL_DEFINE3(mknod, const char __user *, filenam=
e, umode_t, mode, unsigned, d
>   */
>  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  			 struct dentry *dentry, umode_t mode,
> -			 struct delegated_inode *delegated_inode)
> +			 struct delegated_inode *di)
>  {
>  	int error;
> -	unsigned max_links =3D dir->i_sb->s_max_links;
>  	struct dentry *de;
> =20
>  	error =3D may_create_dentry(idmap, dir, dentry);
>  	if (error)
>  		goto err;
> =20
> -	error =3D -EPERM;
> +	error =3D -EOPNOTSUPP;
>  	if (!dir->i_op->mkdir)
>  		goto err;
> =20
> @@ -5250,22 +5319,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, s=
truct inode *dir,
>  	if (error)
>  		goto err;
> =20
> -	error =3D -EMLINK;
> -	if (max_links && dir->i_nlink >=3D max_links)
> -		goto err;
> -
> -	error =3D try_break_deleg(dir, delegated_inode);
> -	if (error)
> -		goto err;
> -
> -	de =3D dir->i_op->mkdir(idmap, dir, dentry, mode);
> -	error =3D PTR_ERR(de);
> -	if (IS_ERR(de))
> +	de =3D __vfs_mkdir(idmap, dir, dentry, mode, di);
> +	if (IS_ERR(de)) {
> +		error =3D PTR_ERR(de);
>  		goto err;
> -	if (de) {
> -		dput(dentry);
> -		dentry =3D de;
>  	}
> +	dentry =3D de;
>  	fsnotify_mkdir(dir, dentry);
>  	return dentry;
> =20
> diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> index e9ce1883288c..e44c7598b68e 100644
> --- a/fs/nfs/dir.c
> +++ b/fs/nfs/dir.c
> @@ -2314,6 +2314,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct den=
try *dentry,
>  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
>  		return -ENAMETOOLONG;
> =20
> +	if ((open_flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	if (open_flags & O_CREAT) {
>  		error =3D nfs_do_create(dir, dentry, mode, open_flags);
>  		if (!error) {
> diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> index 25048a3c2364..467f6bc707da 100644
> --- a/fs/nfs/file.c
> +++ b/fs/nfs/file.c
> @@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
>  	if ((flags & (O_APPEND | O_DIRECT)) =3D=3D (O_APPEND | O_DIRECT))
>  		return -EINVAL;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nfs_check_flags);
> diff --git a/fs/open.c b/fs/open.c
> index 681d405bc61e..865ea6f70e8c 100644
> --- a/fs/open.c
> +++ b/fs/open.c
> @@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *=
how, struct open_flags *op)
>  	if (WILL_CREATE(flags)) {
>  		if (how->mode & ~S_IALLUGO)
>  			return -EINVAL;
> -		op->mode =3D how->mode | S_IFREG;
> +		if ((flags & (O_MKDIR_MASK)) =3D=3D O_MKDIR_MASK)
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

It seems odd that the MAY_WRITE test is only performed for O_CREAT.
Shouldn't any open of O_DIRECTORY|O_WRONLY fail, and shouldn't the one
test catch both create and non-create cases?


>  		op->intent |=3D LOOKUP_CREATE;
>  		if (flags & O_EXCL) {
>  			op->intent |=3D LOOKUP_EXCL;
> diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> index e4295a5b55b3..ec8c54c91261 100644
> --- a/fs/smb/client/dir.c
> +++ b/fs/smb/client/dir.c
> @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *=
direntry,
>  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
>  		return smb_EIO(smb_eio_trace_forced_shutdown);
> =20
> +	if ((oflags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	/*
>  	 * Posix open is only called (at lookup time) for file create now. For
>  	 * opens (rather than creates), because we do not know if it is a file
> diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> index 42bedc4ec7af..aef5ca6730be 100644
> --- a/fs/vboxsf/dir.c
> +++ b/fs/vboxsf/dir.c
> @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent,=
 struct dentry *dentry,
>  	u64 handle;
>  	int err;
> =20
> +	if ((flags & O_MKDIR_MASK) =3D=3D O_MKDIR_MASK)
> +		return -EINVAL;
> +
>  	if (d_in_lookup(dentry)) {
>  		struct dentry *res =3D vboxsf_dir_lookup(parent, dentry, 0);
>  		if (res || d_really_is_positive(dentry))
> diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> index a332e79b3207..e31f3a57f07c 100644
> --- a/include/linux/fcntl.h
> +++ b/include/linux/fcntl.h
> @@ -12,6 +12,8 @@
>  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
>  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> =20
> +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> +
>  /* List of all valid flags for the how->resolve argument: */
>  #define VALID_RESOLVE_FLAGS \
>  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> --=20
> 2.54.0
>=20
>=20
>=20

Thanks,
NeilBrown
