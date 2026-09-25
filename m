Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6CC4C7523;
	Fri, 25 Sep 2026 21:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790371596; cv=none; b=KSxPV7fe7y605QKuUWi7oq5zP49ukVs0Sm46H15BRwyMJ2dDEKwRk1c6aqK+x00zOaT19Oz8MF1Vf4ziZ5nhDSjybDe5AWTUgldV8a2KOulRrRmYgR+tSw/o2OPvMrfuqRR3VR1aSDXo4QmfxAAmPsjPI3fAcSvsy+tfTGSbznk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790371596; c=relaxed/simple;
	bh=UhyLTN+Clxqu6IlLPgbSSHHBF1VDuq7yJcYPLs86R+8=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=dgqz/uDGPyJcEZs+8sZWecER172EVoPP/PBeCwWdYGzCzoOY+pHhHzVYA2XF2kBUZK0/REH9iEM34aolMhwmIpBpoTsI9rfGaa/cV13RmpRfCNaGrqQMLqzuKHepWFr/53iwX9mXVECtWm6qdnFwBNHdLZjh+eeau5WO33GoiK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=F85y9XhB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U15Yrmbr; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="F85y9XhB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U15Yrmbr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C26751D000C8;
	Fri, 25 Sep 2026 17:26:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 25 Sep 2026 17:26:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1790371589; x=1790457989; bh=ARnbQbBvJ0nVuzaXxuXhXSzuUCaGDLxeZZ7
	FiwY+qoQ=; b=F85y9XhBDyEcOKkGSJ5nHZTUNIQK5xo441p2paGMu9hH0At6U0R
	B8/SxuH6/U9TyTfz9osS5MCi0DMSxC8rCf0iLy/9hHY+rWwz0UDXeqwIK8US9KQT
	H8ixr+hIcbvjcAdW8bdAnI8b+swwDIUechUmV9sVkEKhcSsqdzCcEzaaIVSqC6gc
	/llhRJKACDDKi1lk2bFWg12XMI9NX9UTNZmEvh8ZlkQRBnov2egxysqBcMJ2uKGZ
	Xgq+bVra/g458Rs8pQNnKG1CLOM8GUSijDq7xNR4o1fW6T7BEXSRyJaCsfVBelLs
	4Z8PPjDcZU1UXSHUJ44jZSJbd2GAeEep3RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790371589; x=
	1790457989; bh=ARnbQbBvJ0nVuzaXxuXhXSzuUCaGDLxeZZ7FiwY+qoQ=; b=U
	15YrmbrS5c4UvmP6SEbHLV2+nXEuIFdy4IPI4hTforr4D4Ofy+hACJFPzo+xMBTn
	jCRo+CHZVj3zFOC0I10Osis45j/Nk06EtkJqkG6p03w7WeDcPPk0C/TjJD8SuUoS
	aMAg7caMq9IRvJ4bMJp0MeYe+zkqhqdhrZdHA/QVeOMFxMy+4fCkfT4lNGIeKHC8
	ev+RHPp3pDbEto90n13AvEealAHv98RBK+DY9HtfoHEoYTBg2ZHjbOF3Wt06C2ST
	0onaMJink9qjVeUYfGPJlFQH6vj91e9AQXanLvldo3s5l9B17uPwXwY91nOqUIcX
	eJKwql1nuByHPTVJ/z7nQ==
X-ME-Sender: <xms:BOe2ao6wYwPENpVzefR4VAoBAdKg5M7uE_g17FM8yTqpJWcypQfjcg>
    <xme:BOe2amenxWAh6rBxm2Zs7j5ng0mqHTkFJqcVprnbEjs43m68BTshU6ABXu5ULxMRL
    iOQn0WPGYoG44WyuvsMFp6KVFvvI2j6RasGiPcs54y8Ydk1oA>
X-ME-Received: <xmr:BOe2ar4JKeGi02BzkerohcNPfwER0Dif07-zx7oS-XUFhwldeIA9luiRFTULLG7SKg>
X-ME-Proxy-Cause: dmFkZTErOAFCn3CrYbpoAu4/ayQ+UsGvyejevadivvBUVfrC+3oaYcJd//2TEe0MgsCwi7
    o6QGHq/lxAPZtOzihvTanmQ5mFLWKk8t2DZVO9zuH/B9lsCfBUDRoLuTxIdJnMowCihCe5
    Y7VbVsPQqQiLnXpKYvx1XdLcshhNYbZo3b0iR8gfFMsWoSTqwghgp9nxiP6OqfWOJ8HHx5
    vE6ceqH9WksfJ9dgaPzlKQgnO3MsNs7I7cNrJzULWfto3eornQaSGSU6uT1xmU7vtngSH3
    3DOTPhxhjCqwU5pasqawqBJzDk/eo7A9Fj56W9jKPq1aU7aHIZSxymfjvAc6owP5j/hQXa
    NYHmPYJvYAO+0gU79noXIWADAM5+uVQi4fS6sTNBMxVeFEw5GJiDyMhzGk7D2k8XXXVKVs
    okfh/FtsPEJXLdhM3qWQAMWoXhKBxD0nBAizRuhUjyMPbR8j3mLu9sMLjuiCvFmsYg6RyL
    mnn2t6GtdVO9OgKZMui9mu3LYrXTIckNsJnH5wHsHgagWMPpCCsxj4i0xhF1RGc2SyVz9y
    FPypm51FpwwHvgy7g6QqmhdRiz67Rct+ien2SO1Sb8/9DwdNpNNyeWet2jXqnaeaDX0s1r
    nkneQGnMmUa2fdyPWcGfyIoSau5EgGJRhTkwuqbbXgDmv/HpBnGVqkets/4w
X-ME-Proxy: <xmx:BOe2aj_b1qz7ZraTCWSluWi6DcNYZqwH8fazfzaE0dBsFAROqMts3g>
    <xmx:BOe2atHLp7yD7zNs8NaKjHOit6N4ebo4jOMIeuetaDj-0tP02BRKOw>
    <xmx:BOe2aoUFPhAxBzPokvqjM4YLrvI2x-CqeWzOxIojYeJCAPkodiS2_g>
    <xmx:BOe2ap9AuqPq1lI1T9cEFunJfyzHkbD4_B52zS-m0XWoq6hvFiBNlQ>
    <xmx:Bee2asMLNipbX5rDldnOAmG4K65Gaj5F-3yPYvSgbM-1NbhJ26U6btJ->
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 17:26:25 -0400 (EDT)
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
Cc: "Jori Koolstra" <jkoolstra@xs4all.nl>, "Jeff Layton" <jlayton@kernel.org>,
 "Al Viro" <viro@zeniv.linux.org.uk>, "Aleksa Sarai" <aleksa@amutable.com>,
 "Amir Goldstein" <amir73il@gmail.com>, "Jan Kara" <jack@suse.cz>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
In-reply-to: <20260925-zonen-dachwohnung-akkusativ-6a1d1a595810@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
  <178972607557.207413.4312278359822083538@noble.neil.brown.name>
  <178977609418.207413.15011378414000392029@noble.neil.brown.name>
  <20260925-zonen-dachwohnung-akkusativ-6a1d1a595810@brauner>
Date: Sat, 26 Sep 2026 07:26:21 +1000
Message-id: <179037158183.37859.9652046156677268952@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 25 Sep 2026, Christian Brauner wrote:
> On Sat, Sep 19, 2026 at 10:01:34AM +1000, NeilBrown wrote:
> > On Fri, 18 Sep 2026, NeilBrown wrote:
> > > On Fri, 18 Sep 2026, Christian Brauner wrote:
> > > > On Sun, Sep 13, 2026 at 08:50:11PM +0200, Jori Koolstra wrote:
> > > > > Currently there is no way to race-freely create and open a director=
y.
> > > > > For regular files we have open(O_CREAT) for creating a new file ino=
de,
> > > > > and returning a pinning fd to it. The lack of such functionality for
> > > > > directories means that when populating a directory tree there's alw=
ays
> > > > > a race involved: the inodes first need to be created, and then open=
ed
> > > > > to adjust their permissions/ownership/labels/timestamps/acls/xattrs=
/...,
> > > > > but in the time window between the creation and the opening they mi=
ght
> > > > > be replaced by something else.
> > > > >=20
> > > > > Addressing this race without a proper API is only partially possibl=
e:
> > > > > the caller can immediately fstat() what was opened to verify that it
> > > > > has the expected inode type, owner and mode. But besides being easy=
 to
> > > > > get wrong, this cannot establish who created the directory: a direc=
tory
> > > > > created by another process with identical credentials is
> > > > > indistinguishable from one the caller created itself, so the caller
> > > > > cannot tell whether the directory is its own to manage.
> > > > >=20
> > > > > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTD=
IR if
> > > > > a regular file exists at the open path; EISDIR if a directory exist=
s at
> > > > > the path; and to create a regular file if no file exists at the pat=
h.
> > > > > This behaviour changed accidentally with
> > > > > commit 973d4b73fbaf ("do_last(): rejoin the common path even earlie=
r in
> > > > > FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last=
 case
> > > > > while still creating the file. As this change was not detected for a
> > > > > long time, Brauner proposed to adopt the more consistent NetBSD
> > > > > behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combina=
tion.
> > > > > This change was applied in commit 43b450632676 ("open: return EINVA=
L for
> > > > > O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has=
 been
> > > > > in the kernel for about 3 years now, no rollback is expected as a r=
esult
> > > > > of userspace reliance on old behaviour, leaving us free to reassign=
 the
> > > > > O_CREAT|O_DIRECTORY semantics.
> > > > >=20
> > > > > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > > > > filesystems. These filesystems currently cannot handle
> > > > > O_CREAT|O_DIRECTORY without protocol extensions and therefore are f=
orced
> > > > > into a fallback mode by stripping the O_CREAT bit. This causes exis=
ting
> > > > > directories to be successfully opened, while for targets that should
> > > > > have been created, -ENOENT is returned. This -ENOENT is then conver=
ted
> > > > > to -EOPNOTSUPP in later atomic_open(). The simple option of just
> > > > > returning -EOPNOTSUPP directly leads to inconsistent behaviour: bef=
ore
> > > > > ->atomic_open() is called in lookup_open(), the dcache is queried. =
So
> > > > > returning -EOPNOTSUPP immediately would make O_CREAT|O_DIRECTORY
> > > > > dependent on the cache state of the dentry.
> > > > >=20
> > > > > There is no separate sysctl for directory creation implemented curr=
ently.
> > > > > Therefore, for the S_ISDIR case, disabling sysctl_protected_regular=
 is
> > > > > not enough to allow creating a directory in a sticky folder, becaus=
e that
> > > > > may surprise users not expecting that O_CREAT|O_DIRECTORY is possib=
le on
> > > > > newer kernels.
> > > > >=20
> > > > > This feature idea (and some of its description) is taken from the
> > > > > UAPI group:
> > > > > https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#=
race-free-creation-and-opening-of-non-file-inodes
> > > > >=20
> > > > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > > > ---
> > > > >  fs/namei.c            | 116 +++++++++++++++++++++++++++++++++++---=
----
> > > > >  fs/open.c             |  25 +++++----
> > > > >  include/linux/fcntl.h |   6 +++
> > > > >  3 files changed, 117 insertions(+), 30 deletions(-)
> > > > >=20
> > > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > > index 0efd395a1a65..6ff0a3c04f02 100644
> > > > > --- a/fs/namei.c
> > > > > +++ b/fs/namei.c
> > > > > @@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, con=
st struct path *link)
> > > > > =20
> > > > >  /**
> > > > >   * may_create_in_sticky - Check whether an O_CREAT open in a stick=
y directory
> > > > > - *			  should be allowed, or not, on files that already
> > > > > - *			  exist.
> > > > > + *			  should be allowed, or not, on files/directories that
> > > > > + *			  already exist.
> > > > >   * @idmap: idmap of the mount the inode was found from
> > > > >   * @nd: nameidata pathwalk data
> > > > >   * @inode: the inode of the file to open
> > > > >   *
> > > > > - * Block an O_CREAT open of a FIFO (or a regular file) when:
> > > > > + * Block an O_CREAT open of a FIFO (or a regular file/directory) w=
hen:
> > > > >   *   - sysctl_protected_fifos (or sysctl_protected_regular) is ena=
bled
> > > > >   *   - the file already exists
> > > > >   *   - we are in a sticky directory
> > > > > @@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_i=
dmap *idmap, struct nameidata *nd,
> > > > >  	if (likely(!(dir_mode & S_ISVTX)))
> > > > >  		return 0;
> > > > > =20
> > > > > +	/*
> > > > > +	 * There is no separate sysctl for directory creation in sticky
> > > > > +	 * folders. Therefore, for the S_ISDIR case, disabling
> > > > > +	 * sysctl_protected_regular is not enough to allow creating a
> > > > > +	 * directory in a sticky folder, because that may surprise users
> > > > > +	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
> > > > > +	 * kernels.
> > > > > +	 */
> > > > >  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> > > > >  		return 0;
> > > > > =20
> > > > > @@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_i=
dmap *idmap, struct nameidata *nd,
> > > > >  					      "sticky_create_regular");
> > > > >  			return -EACCES;
> > > > >  		}
> > > > > +
> > > > > +		if (S_ISDIR(inode->i_mode)) {
> > > > > +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> > > > > +					      "sticky_create_dir");
> > > > > +			return -EACCES;
> > > > > +		}
> > > > >  	}
> > > > > =20
> > > > >  	return 0;
> > > > > @@ -4334,21 +4348,43 @@ static inline int open_to_namei_flags(int f=
lag)
> > > > > =20
> > > > >  static int may_o_create(struct mnt_idmap *idmap,
> > > > >  			const struct path *dir, struct dentry *dentry,
> > > > > -			umode_t mode)
> > > > > +			int open_flag, umode_t mode)
> > > > >  {
> > > > > -	int error =3D security_path_mknod(dir, dentry, mode, 0);
> > > > > +	struct inode *dir_inode =3D dir->dentry->d_inode;
> > > > > +	bool create_dir =3D O_IS_MKDIR(open_flag);
> > > > > +	int error;
> > > > > +
> > > > > +	WARN_ON_ONCE(create_dir && !(mode & S_IFDIR));
> > > > > +
> > > > > +	if (create_dir)
> > > > > +		error =3D security_path_mkdir(dir, dentry, mode);
> > > > > +	else
> > > > > +		error =3D security_path_mknod(dir, dentry, mode, 0);
> > > > >  	if (error)
> > > > >  		return error;
> > > > > =20
> > > > >  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
> > > > >  		return -EOVERFLOW;
> > > > > =20
> > > > > -	error =3D inode_permission(idmap, dir->dentry->d_inode,
> > > > > -				 MAY_WRITE | MAY_EXEC);
> > > > > +	error =3D inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC=
);
> > > > >  	if (error)
> > > > >  		return error;
> > > > > =20
> > > > > -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> > > > > +	if (create_dir)
> > > > > +		error =3D security_inode_mkdir(dir_inode, dentry, mode);
> > > > > +	else
> > > > > +		error =3D security_inode_create(dir_inode, dentry, mode);
> > > > > +
> > > > > +	return error;
> > > > > +}
> > > > > +
> > > > > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > > > > +		const struct inode *dir, int open_flag, umode_t mode)
> > > > > +{
> > > > > +	if (O_IS_MKDIR(open_flag))
> > > > > +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S=
_IFDIR);
> > > > > +	else
> > > > > +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> > > > >  }
> > > > > =20
> > > > >  /**
> > > > > @@ -4384,8 +4420,9 @@ static struct dentry *atomic_open(const struc=
t path *path, struct dentry *dentry
> > > > > =20
> > > > >  	file->__f_path.dentry =3D DENTRY_NOT_SET;
> > > > >  	file->__f_path.mnt =3D path->mnt;
> > > > > +
> > > > >  	error =3D dir_inode->i_op->atomic_open(dir_inode, dentry, file,
> > > > > -				       open_to_namei_flags(open_flag), mode);
> > > > > +					     open_to_namei_flags(open_flag), mode);
> > > > >  	d_lookup_done(dentry);
> > > > > =20
> > > > >  	if (!error) {
> > > > > @@ -4427,12 +4464,32 @@ static struct dentry *atomic_open(const str=
uct path *path, struct dentry *dentry
> > > > >  			 */
> > > > >  			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > > > >  			error =3D create_error;
> > > > > +		} else if (O_IS_MKDIR(open_flag) && error =3D=3D -ENOENT) {
> > > > > +			/*
> > > > > +			 * If the underlying filesystem does not implement
> > > > > +			 * O_CREAT|O_DIRECTORY, it strips the O_CREAT bit and
> > > > > +			 * continues as a lookup. We can't simply return
> > > > > +			 * -EOPNOTSUPP from unsupported ->atomic_open()
> > > > > +			 * implementations because the dentry might be in the
> > > > > +			 * dcache. In that case, lookup_open() returns before
> > > > > +			 * reaching ->atomic_open(), and hence whether you get
> > > > > +			 * -EOPNOTSUPP on O_CREAT|O_DIRECTORY would not only
> > > > > +			 * depend on the underlying filesystem, but also on
> > > > > +			 * the state of the dcache. Still, we must make an
> > > > > +			 * effort to differentiate a regular -ENOENT from the
> > > > > +			 * unsupported O_CREAT|O_DIRECTORY case.
> > > > > +			 */
> > > > > +			error =3D -EOPNOTSUPP;
> > > > >  		}
> > > > >  		dput(dentry);
> > > > >  		dentry =3D ERR_PTR(error);
> > > > >  	} else {
> > > > > -		if (file->f_mode & FMODE_CREATED)
> > > > > -			fsnotify_create(dir_inode, dentry);
> > > > > +		if (file->f_mode & FMODE_CREATED) {
> > > > > +			if (d_is_dir(dentry))
> > > > > +				fsnotify_mkdir(dir_inode, dentry);
> > > > > +			else
> > > > > +				fsnotify_create(dir_inode, dentry);
> > > > > +		}
> > > > >  		if (file->f_mode & FMODE_OPENED)
> > > > >  			fsnotify_open(file);
> > > > >  	}
> > > > > @@ -4441,6 +4498,9 @@ static struct dentry *atomic_open(const struc=
t path *path, struct dentry *dentry
> > > > >  	return dentry;
> > > > >  }
> > > > > =20
> > > > > +static inline
> > > > > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode =
*, struct dentry *,
> > > > > +				 umode_t, struct delegated_inode *);
> > > > >  /*
> > > > >   * Look up and maybe create and open the last component.
> > > > >   *
> > > > > @@ -4462,6 +4522,7 @@ static struct dentry *lookup_open(struct name=
idata *nd, struct file *file,
> > > > >  	struct mnt_idmap *idmap;
> > > > >  	struct dentry *dir =3D nd->path.dentry;
> > > > >  	struct inode *dir_inode =3D dir->d_inode;
> > > > > +	bool create_dir =3D O_IS_MKDIR(op->open_flag);
> > > > >  	int open_flag;
> > > > >  	struct dentry *dentry;
> > > > >  	int error, create_error;
> > > > > @@ -4474,6 +4535,9 @@ static struct dentry *lookup_open(struct name=
idata *nd, struct file *file,
> > > > >  	mode =3D op->mode;
> > > > >  	create_error =3D 0;
> > > > > =20
> > > > > +	if (create_dir && dir_inode->i_op->atomic_open)
> > > > > +		open_flag &=3D ~O_CREAT;
> > > > > +
> > > > >  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> > > > >  		got_write =3D !mnt_want_write(nd->path.mnt);
> > > > >  		/*
> > > > > @@ -4534,10 +4598,10 @@ static struct dentry *lookup_open(struct na=
meidata *nd, struct file *file,
> > > > >  	if (open_flag & O_CREAT) {
> > > > >  		if (open_flag & O_EXCL)
> > > > >  			open_flag &=3D ~O_TRUNC;
> > > > > -		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> > > > > +		mode =3D o_create_mode(idmap, dir_inode, open_flag, mode);
> > > > >  		if (likely(got_write))
> > > > >  			create_error =3D may_o_create(idmap, &nd->path,
> > > > > -						    dentry, mode);
> > > > > +						    dentry, open_flag, mode);
> > > > >  		else
> > > > >  			create_error =3D -EROFS;
> > > > >  	}
> > > > > @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct na=
meidata *nd, struct file *file,
> > > > >  		goto out_dput;
> > > > >  	}
> > > > > =20
> > > > > -	if (!dir_inode->i_op->create) {
> > > > > +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> > > > > +	if (create_dir && !dir_inode->i_op->mkdir) {
> > > > > +		error =3D -EPERM;
> > > > > +		goto out_dput;
> > > > > +	}
> > > > > +	if (!create_dir && !dir_inode->i_op->create) {
> > > > >  		error =3D -EACCES;
> > > > >  		goto out_dput;
> > > > >  	}
> > > > > =20
> > > > > -	error =3D vfs_create_no_perm(idmap, dentry, mode, &delegated_inod=
e);
> > > > > +	if (create_dir) {
> > > > > +		struct dentry *res =3D vfs_mkdir_no_perm(idmap, dir_inode, dentr=
y, mode,
> > > > > +						       &delegated_inode);
> > > >=20
> > > > So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
> > > > passed to do_open(). Kernfs makes that buggy.
> > > >=20
> > > > cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
> > > > kernfs ->mkdir:: iop never instantiates the dentry.
> > > >=20
> > > > So that means e.g.,
> > > >=20
> > > > openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
> > > > and then fails with ENOTDIR.
> > > >=20
> > > > So the negative dentry gets handed out and now userspace holds an fd
> > > > with that negative dentry. So say userspace does fchown() to 1000 and
> > > > then fchmod() with the sticky bit and then you get a NULL deref. I ha=
ve
> > > > reproduced this.
> > > >=20
> > > > Neil can correct me but the fix might be to check whether the dentry =
is
> > > > negative in lookup_open() and re-lookup nd->last with the parent stil=
l locked.
> > > > I think that's what nfsd_create_locked() and cachefiles_get_directory=
() do
> > > > after vfs_mkdir().
> > >=20
> > > nfsd_create_locked() used to do that before vfs_mkdir() could return a
> > > dentry, but it doesn't any more.  The reason was because
> > > d_splice_alias() on might return a different dentry.=20
> > > In this case we want the same dentry, but we need to do a lookup on it.
> > >=20
> > > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > >=20
> > > The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> > > the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> > > I'm not certain that is needed if we keep the parent locked, but we
> > > would need to be certain.
> > > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > > cannot handle hashed dentries and a hashed-negative dentry is passed
> > > to ->mkdir.
> > >=20
> > > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> > > probably not.
> > >=20
> > > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > > dentry is negative, we need to d_drop() and call ->lookup with a big
> > > comment about kernfs.  But we need to double-check that this will do the
> > > right thing with ->d_time (I think it will).
> > > We also need to think carefully about races with
> > > kernfs_dop_revalidate(), which could happen concurrently with the
> > > ->lookup.
> >=20
> > I've thought a bit more about this ...  I think that doing a lookup after
> > the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
> > about the fs that I would rather not assume.
> >=20
> > I would rather have the current proposed code check for a negative
> > dentry, and fail with -EIO or similar.
> >=20
> > We could then "fix" kernfs by providing an atomic_open which does the
> > mkdir and then the lookup, and provides the dentry to
> > finish_no_lookup().
> >=20
> > That way we don't need to change kernfs mkdir.
> >=20
> > Note that tracefs_syscall_mkdir() has the same behaviour as
> > kernfs_iop_mkdir, and could have the same fix.
>=20
> Sounds good to me. But should we do this in one single release so
> userspace doesn't have a 90% working thing?
>=20

The current proposal leaves all ->atomic_open using filesystems as not
supporting O_CREAT|O_DIRECTORY and I think that is reasonable.  Getting
them all done in the one release is probably unrealistic.
But that is a slightly different issue to kernfs/tracefs.

I wonder *why* those two filesystems don't do the lookup to instantiate
the dentry after mkdir.  If it was just "unnecessary" then we can safely
change it.  If it was "there is a common use-case where mkdir isn't
followed by a lookup, and we can avoid cluttering the icache/dcache",
then we probably don't want to.

In the first case, adding a ->lookup() at the end of mkdir and returning
the result would suffice.  In the second case adding ->atomic_open=20
would be better.  I cannot find any evidence in git history of anything
beyond "unnecessary".

Part of the point of O_CREAT|O_DIRECTORY is that it is atomic - the
thing opened is the thing created.  tracefs drops the parent ->i_rwsem
while actually performing the creation.  It isn't immediately clear what
that means for atomicity but it does raise questions.

At this stage I think I would lean towards O_CREAT|O_DIRECTORY not
working on these two filesystems.  Neither support a .create
inode_operation, so providing a .atomic_open would be quite easy: just
do a ->lookup and pass the result to finish_no_open, but return an
appropriate error if O_CREAT was requested but no inode was found.  That
would then treat these like other atomic_open filesystems in that
O_CREAT|O_DIRECTORY wouldn't work until the fs maintainer accepted a
patch for it.

NeilBrown
