Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760B64C225C;
	Fri, 18 Sep 2026 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789726087; cv=none; b=HJRIK+T7iNpBMjAdsN+Pdc1c0DkHfRifWLlLEoMsjZMKWtRF/c3K4gH2/3H+kq2yBwtOHwf7MOI9cHerPc9AgCUIPAXo1duBPQMOC64OtiENXiAoFkVHVgQZQVqkT9GzRrh9AVvVB8xGC88xZ/9gxZRCQZM5kZXyGGMz7Lat6us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789726087; c=relaxed/simple;
	bh=XkWZ8MrfHQ3vQPH2axWpS1o0ytxrL4sAVAI8h8rEb+k=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=QS04HM1pKSIfJ0j2/FWpIIfunF/fs9ELNrZLj8GeM3yE4gO5ApmDpnkSy1bRVgc8K9aiRyp7w2TtnKtHCeEIR2NBNaPzMQux0a4ew8G6PVj2RoR+qpX/1bYa7qm1p/fpxzUgEOrtwOjup5PhPECuhP7RdOMPRUwyL54VcQBXb6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=ThRQn4tW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YHTpdpgp; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="ThRQn4tW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YHTpdpgp"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 4119E1D0008A;
	Fri, 18 Sep 2026 06:08:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Sep 2026 06:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789726083; x=1789812483; bh=Ce89SDiXP4M1oqAPg5zoRmbzKWQrTa+Bm+x
	E04FJA18=; b=ThRQn4tWST1Axm9epeJOdSctt04Q0yfIHjnoGGVeFhoQj610+gG
	jyN/U4NkGmtYhtetx4P6giAkUokaT6QQgSztdpMB4AdeeckwMpuukoD5Pc9YMVAc
	NqHQ4lcpjDHlYECzdmhNYWSWwXMCaPJaaHH6MIv4DId1HSYPYk3ENA60XKZSiBfP
	IvoTrlUOfh9Lt3Nuoqx0249lyCXCqiwzCzdeDiBQfM06WwE8doO+6yNi7P50fb5f
	fiTJsONYkn5lMruhsNUbizpZRdRS49wUVL1QD6nFIpCJst1/CN9ijgYB8M/YoXAH
	OWCLfUp1maLvLDGgj5yAEgW6IdODk8Tn7UQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789726083; x=
	1789812483; bh=Ce89SDiXP4M1oqAPg5zoRmbzKWQrTa+Bm+xE04FJA18=; b=Y
	HTpdpgp7RV3QllgJ7nPhi7SZVmvmlFRN8WwpmyhB0Ka6PzgfKRGoFds9c7UZMsjG
	K4buWcvhdMu0iBFuGuT6FVgbNrPp7EGADj5iM8Urx316SplZJ5JiK0pjvhBrT0qy
	WO1FSlKpzdsTFtCswyh3M/3EGIwFEjTN5S/8bE+6VL53D44TaqOdnywhcLSjG8zy
	2J/Z7KZP/cPWdWV4jj7HHtEXmppsLtxSBy/J2lWaUInqUMK+RQVuInOzmsvovTy+
	FTpHsAkjY5Nbu1OAXz3bDIfwf5Cb7wUWy5aTnYPSqAl05wE2DwWCTY4vSqexXc6F
	NGUO0SpN0U4lvfSZn8mPQ==
X-ME-Sender: <xms:gg2tauGMy9C67w9hyXtOSMN0CGffVX4fVpZrzpgR4aYFIYng2OChEg>
    <xme:gg2tar4IdTwjEBGQjhR2JIoLt01VMI0g-u0B-VBkJoUVDjjAMREjfKRAteD4ywTsz
    CWDtQycP1wjD7ufMbR9yIpxVOaTL_RpA0vmKDU56fONV0UegzY>
X-ME-Received: <xmr:gg2tasmlfSrtIUjAeNmY89_2V6ocmPRTzeugKvPeyjRfN7JhiDOmTvuM_e-VTtSFvQIoBTslsQ4zuxZee_Z9NA6C6gxsopM>
X-ME-Proxy-Cause: dmFkZTFjmhTZ3tKXOZ/Mhye0vj5euqve/M+Rn7GAuwdqNkoUjZ5xwWELbvFAaTWUU6+GEl
    T1xoExXr5epVBJVpsv7f1yRISsvd4S5SadktFBILTVJ2Q96f3mjFzHQDqctqhYoYvxbnNx
    FV6dDA+thHKmpnQ/h9ZiD7wwurEKq37qSwdD22BZNiWiDG0p1VjeTedfdj2WpeFddDrr0D
    L+LIz+6yfsrtpBb00S+ee59jXmjFe8jiPVYzNq9XLylPnX9q+X+CArPb2n4ZY0jdW7BAJE
    6WxlIrRLRaLKxKIoOhMcVLi2VGPgxPKmjj8unxGYli1Xm9oJL3e0KjC6QnCMU9PmjZ33Fr
    301LJ75qAMGu3xtOsQ8Dd/lgCvhYat63o/b6EEh8cIv8FewfNlaBgl88JPVc7aMjAZd3AY
    9k4HBn5xbA4EChtuC3B8MkknyyFzCIC0f6l4MTOZaJZpvn7CvA3BE9emtZvSv7OGM88HPN
    fxddxW9ACRbbpToR6AEAD5i7+FVWWTl6P44SJX0AmKyQR6Uxk0fYet7YqtFJsS13pbJ5J3
    T2FaU7o4/yEzvt/GbAOUHRBemyE70ZTAUfjOz8ClRDbuRWbXMrWRhQ12KBDAEMaLrN/cEP
    Xg2InQjUndxNcDbvjsH3HJi9mwpNO6YJMgy0WpEScvwxCwMy1yn8Klisu7Og
X-ME-Proxy: <xmx:gg2tau4tM05j2HIImO-iMmHnmvhxKLbTETM6VCisZ-9nirE6pNt0tg>
    <xmx:gg2talQ6lF71fOCUYjrTDdKMKEzsPg5T6NKJj6KoLT4ibAQuy-poBw>
    <xmx:gg2takzF9ufJQbOskUiYAe4OboZX22bgx67Up-FAx3bkxtaPtp5GUg>
    <xmx:gg2talqyJNfZGIFhY-U2vqhI7WKfsA8IT9inmdK7GMk8IotB76s_rg>
    <xmx:gw2tauKjSdmTCoyhT4Gtm2bAPjnkZnGFcJ5YMw0U6fsG-Gq8kpABJ0dL>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 06:07:59 -0400 (EDT)
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
In-reply-to: <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
Date: Fri, 18 Sep 2026 20:07:55 +1000
Message-id: <178972607557.207413.4312278359822083538@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 18 Sep 2026, Christian Brauner wrote:
> On Sun, Sep 13, 2026 at 08:50:11PM +0200, Jori Koolstra wrote:
> > Currently there is no way to race-freely create and open a directory.
> > For regular files we have open(O_CREAT) for creating a new file inode,
> > and returning a pinning fd to it. The lack of such functionality for
> > directories means that when populating a directory tree there's always
> > a race involved: the inodes first need to be created, and then opened
> > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > but in the time window between the creation and the opening they might
> > be replaced by something else.
> >=20
> > Addressing this race without a proper API is only partially possible:
> > the caller can immediately fstat() what was opened to verify that it
> > has the expected inode type, owner and mode. But besides being easy to
> > get wrong, this cannot establish who created the directory: a directory
> > created by another process with identical credentials is
> > indistinguishable from one the caller created itself, so the caller
> > cannot tell whether the directory is its own to manage.
> >=20
> > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > a regular file exists at the open path; EISDIR if a directory exists at
> > the path; and to create a regular file if no file exists at the path.
> > This behaviour changed accidentally with
> > commit 973d4b73fbaf ("do_last(): rejoin the common path even earlier in
> > FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last case
> > while still creating the file. As this change was not detected for a
> > long time, Brauner proposed to adopt the more consistent NetBSD
> > behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combination.
> > This change was applied in commit 43b450632676 ("open: return EINVAL for
> > O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has been
> > in the kernel for about 3 years now, no rollback is expected as a result
> > of userspace reliance on old behaviour, leaving us free to reassign the
> > O_CREAT|O_DIRECTORY semantics.
> >=20
> > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > filesystems. These filesystems currently cannot handle
> > O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
> > into a fallback mode by stripping the O_CREAT bit. This causes existing
> > directories to be successfully opened, while for targets that should
> > have been created, -ENOENT is returned. This -ENOENT is then converted
> > to -EOPNOTSUPP in later atomic_open(). The simple option of just
> > returning -EOPNOTSUPP directly leads to inconsistent behaviour: before
> > ->atomic_open() is called in lookup_open(), the dcache is queried. So
> > returning -EOPNOTSUPP immediately would make O_CREAT|O_DIRECTORY
> > dependent on the cache state of the dentry.
> >=20
> > There is no separate sysctl for directory creation implemented currently.
> > Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
> > not enough to allow creating a directory in a sticky folder, because that
> > may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
> > newer kernels.
> >=20
> > This feature idea (and some of its description) is taken from the
> > UAPI group:
> > https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#race-f=
ree-creation-and-opening-of-non-file-inodes
> >=20
> > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > ---
> >  fs/namei.c            | 116 +++++++++++++++++++++++++++++++++++-------
> >  fs/open.c             |  25 +++++----
> >  include/linux/fcntl.h |   6 +++
> >  3 files changed, 117 insertions(+), 30 deletions(-)
> >=20
> > diff --git a/fs/namei.c b/fs/namei.c
> > index 0efd395a1a65..6ff0a3c04f02 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, const str=
uct path *link)
> > =20
> >  /**
> >   * may_create_in_sticky - Check whether an O_CREAT open in a sticky dire=
ctory
> > - *			  should be allowed, or not, on files that already
> > - *			  exist.
> > + *			  should be allowed, or not, on files/directories that
> > + *			  already exist.
> >   * @idmap: idmap of the mount the inode was found from
> >   * @nd: nameidata pathwalk data
> >   * @inode: the inode of the file to open
> >   *
> > - * Block an O_CREAT open of a FIFO (or a regular file) when:
> > + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
> >   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
> >   *   - the file already exists
> >   *   - we are in a sticky directory
> > @@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_idmap *=
idmap, struct nameidata *nd,
> >  	if (likely(!(dir_mode & S_ISVTX)))
> >  		return 0;
> > =20
> > +	/*
> > +	 * There is no separate sysctl for directory creation in sticky
> > +	 * folders. Therefore, for the S_ISDIR case, disabling
> > +	 * sysctl_protected_regular is not enough to allow creating a
> > +	 * directory in a sticky folder, because that may surprise users
> > +	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
> > +	 * kernels.
> > +	 */
> >  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> >  		return 0;
> > =20
> > @@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_idmap *=
idmap, struct nameidata *nd,
> >  					      "sticky_create_regular");
> >  			return -EACCES;
> >  		}
> > +
> > +		if (S_ISDIR(inode->i_mode)) {
> > +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> > +					      "sticky_create_dir");
> > +			return -EACCES;
> > +		}
> >  	}
> > =20
> >  	return 0;
> > @@ -4334,21 +4348,43 @@ static inline int open_to_namei_flags(int flag)
> > =20
> >  static int may_o_create(struct mnt_idmap *idmap,
> >  			const struct path *dir, struct dentry *dentry,
> > -			umode_t mode)
> > +			int open_flag, umode_t mode)
> >  {
> > -	int error =3D security_path_mknod(dir, dentry, mode, 0);
> > +	struct inode *dir_inode =3D dir->dentry->d_inode;
> > +	bool create_dir =3D O_IS_MKDIR(open_flag);
> > +	int error;
> > +
> > +	WARN_ON_ONCE(create_dir && !(mode & S_IFDIR));
> > +
> > +	if (create_dir)
> > +		error =3D security_path_mkdir(dir, dentry, mode);
> > +	else
> > +		error =3D security_path_mknod(dir, dentry, mode, 0);
> >  	if (error)
> >  		return error;
> > =20
> >  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
> >  		return -EOVERFLOW;
> > =20
> > -	error =3D inode_permission(idmap, dir->dentry->d_inode,
> > -				 MAY_WRITE | MAY_EXEC);
> > +	error =3D inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
> >  	if (error)
> >  		return error;
> > =20
> > -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> > +	if (create_dir)
> > +		error =3D security_inode_mkdir(dir_inode, dentry, mode);
> > +	else
> > +		error =3D security_inode_create(dir_inode, dentry, mode);
> > +
> > +	return error;
> > +}
> > +
> > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > +		const struct inode *dir, int open_flag, umode_t mode)
> > +{
> > +	if (O_IS_MKDIR(open_flag))
> > +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR=
);
> > +	else
> > +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> >  }
> > =20
> >  /**
> > @@ -4384,8 +4420,9 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
> > =20
> >  	file->__f_path.dentry =3D DENTRY_NOT_SET;
> >  	file->__f_path.mnt =3D path->mnt;
> > +
> >  	error =3D dir_inode->i_op->atomic_open(dir_inode, dentry, file,
> > -				       open_to_namei_flags(open_flag), mode);
> > +					     open_to_namei_flags(open_flag), mode);
> >  	d_lookup_done(dentry);
> > =20
> >  	if (!error) {
> > @@ -4427,12 +4464,32 @@ static struct dentry *atomic_open(const struct pa=
th *path, struct dentry *dentry
> >  			 */
> >  			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> >  			error =3D create_error;
> > +		} else if (O_IS_MKDIR(open_flag) && error =3D=3D -ENOENT) {
> > +			/*
> > +			 * If the underlying filesystem does not implement
> > +			 * O_CREAT|O_DIRECTORY, it strips the O_CREAT bit and
> > +			 * continues as a lookup. We can't simply return
> > +			 * -EOPNOTSUPP from unsupported ->atomic_open()
> > +			 * implementations because the dentry might be in the
> > +			 * dcache. In that case, lookup_open() returns before
> > +			 * reaching ->atomic_open(), and hence whether you get
> > +			 * -EOPNOTSUPP on O_CREAT|O_DIRECTORY would not only
> > +			 * depend on the underlying filesystem, but also on
> > +			 * the state of the dcache. Still, we must make an
> > +			 * effort to differentiate a regular -ENOENT from the
> > +			 * unsupported O_CREAT|O_DIRECTORY case.
> > +			 */
> > +			error =3D -EOPNOTSUPP;
> >  		}
> >  		dput(dentry);
> >  		dentry =3D ERR_PTR(error);
> >  	} else {
> > -		if (file->f_mode & FMODE_CREATED)
> > -			fsnotify_create(dir_inode, dentry);
> > +		if (file->f_mode & FMODE_CREATED) {
> > +			if (d_is_dir(dentry))
> > +				fsnotify_mkdir(dir_inode, dentry);
> > +			else
> > +				fsnotify_create(dir_inode, dentry);
> > +		}
> >  		if (file->f_mode & FMODE_OPENED)
> >  			fsnotify_open(file);
> >  	}
> > @@ -4441,6 +4498,9 @@ static struct dentry *atomic_open(const struct path=
 *path, struct dentry *dentry
> >  	return dentry;
> >  }
> > =20
> > +static inline
> > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *, str=
uct dentry *,
> > +				 umode_t, struct delegated_inode *);
> >  /*
> >   * Look up and maybe create and open the last component.
> >   *
> > @@ -4462,6 +4522,7 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  	struct mnt_idmap *idmap;
> >  	struct dentry *dir =3D nd->path.dentry;
> >  	struct inode *dir_inode =3D dir->d_inode;
> > +	bool create_dir =3D O_IS_MKDIR(op->open_flag);
> >  	int open_flag;
> >  	struct dentry *dentry;
> >  	int error, create_error;
> > @@ -4474,6 +4535,9 @@ static struct dentry *lookup_open(struct nameidata =
*nd, struct file *file,
> >  	mode =3D op->mode;
> >  	create_error =3D 0;
> > =20
> > +	if (create_dir && dir_inode->i_op->atomic_open)
> > +		open_flag &=3D ~O_CREAT;
> > +
> >  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> >  		got_write =3D !mnt_want_write(nd->path.mnt);
> >  		/*
> > @@ -4534,10 +4598,10 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> >  	if (open_flag & O_CREAT) {
> >  		if (open_flag & O_EXCL)
> >  			open_flag &=3D ~O_TRUNC;
> > -		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> > +		mode =3D o_create_mode(idmap, dir_inode, open_flag, mode);
> >  		if (likely(got_write))
> >  			create_error =3D may_o_create(idmap, &nd->path,
> > -						    dentry, mode);
> > +						    dentry, open_flag, mode);
> >  		else
> >  			create_error =3D -EROFS;
> >  	}
> > @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> >  		goto out_dput;
> >  	}
> > =20
> > -	if (!dir_inode->i_op->create) {
> > +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> > +	if (create_dir && !dir_inode->i_op->mkdir) {
> > +		error =3D -EPERM;
> > +		goto out_dput;
> > +	}
> > +	if (!create_dir && !dir_inode->i_op->create) {
> >  		error =3D -EACCES;
> >  		goto out_dput;
> >  	}
> > =20
> > -	error =3D vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> > +	if (create_dir) {
> > +		struct dentry *res =3D vfs_mkdir_no_perm(idmap, dir_inode, dentry, mod=
e,
> > +						       &delegated_inode);
>=20
> So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
> passed to do_open(). Kernfs makes that buggy.
>=20
> cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
> kernfs ->mkdir:: iop never instantiates the dentry.
>=20
> So that means e.g.,
>=20
> openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
> and then fails with ENOTDIR.
>=20
> So the negative dentry gets handed out and now userspace holds an fd
> with that negative dentry. So say userspace does fchown() to 1000 and
> then fchmod() with the sticky bit and then you get a NULL deref. I have
> reproduced this.
>=20
> Neil can correct me but the fix might be to check whether the dentry is
> negative in lookup_open() and re-lookup nd->last with the parent still lock=
ed.
> I think that's what nfsd_create_locked() and cachefiles_get_directory() do
> after vfs_mkdir().

nfsd_create_locked() used to do that before vfs_mkdir() could return a
dentry, but it doesn't any more.  The reason was because
d_splice_alias() on might return a different dentry.=20
In this case we want the same dentry, but we need to do a lookup on it.

I'd rather fix this in kernfs, but maybe that is a longer-term goal.

The comment in kernfs_dop_revalidate() suggests the we should d_drop()
the negative dentry and d_alloc_parallel() a new one and ->lookup that.
I'm not certain that is needed if we keep the parent locked, but we
would need to be certain.
We at least need to d_drop() the dentry before ->lookup as ->lookup
cannot handle hashed dentries and a hashed-negative dentry is passed
to ->mkdir.

I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
probably not.

Summary: I think that if vfs_mkdir() returns NULL (success) but the
dentry is negative, we need to d_drop() and call ->lookup with a big
comment about kernfs.  But we need to double-check that this will do the
right thing with ->d_time (I think it will).
We also need to think carefully about races with
kernfs_dop_revalidate(), which could happen concurrently with the
->lookup.

NeilBrown



>=20
> Here's the callchain:
>=20
>   Common path: create the cgroup, come back with a negative dentry
>=20
>   __x64_sys_openat
>    do_sys_openat2                          fs/open.c
>     build_open_flags                       O_IS_MKDIR(flags) -> op->mode =
=3D mode | S_IFDIR
>                                            O_DIRECTORY -> lookup_flags |=3D=
 LOOKUP_DIRECTORY
>     do_file_open                           fs/namei.c
>        lookup_fast_for_open                dcache miss -> NULL
>        lookup_open
>         mnt_want_write
>         inode_lock_nested(dir, I_MUTEX_PARENT)
>         d_lookup -> NULL
>         d_alloc_parallel                   in-lookup dentry
>         o_create_mode                      S_IFDIR | 0755 & ~umask
>         may_o_create
>          security_path_mkdir
>          inode_permission(MAY_WRITE|MAY_EXEC)
>           kernfs_iop_permission
>            generic_permission              owner of a 0755 dir: allowed
>          security_inode_mkdir
>         dir_inode->i_op->lookup
>          kernfs_iop_lookup
>           kernfs_find_ns -> NULL           node does not exist yet
>           d_splice_alias(NULL, dentry)     -> __d_add(): hashed, NEGATIVE
>          try_break_deleg
>          dir->i_op->mkdir
>           kernfs_iop_mkdir
>            scops->mkdir
>             cgroup_mkdir                   no capable() check
>              cgroup_create                 owner =3D current_fsuid()
>              css_populate_dir
>              kernfs_activate               cgroup now exists
>            return ERR_PTR(0)               =3D=3D NULL, dentry untouched
>          de =3D=3D NULL -> keep original dentry
>          fsnotify_mkdir(dir, dentry)       fine with a negative dentry
>         dentry =3D res                       still negative
>         file->f_mode |=3D FMODE_CREATED
>         inode_unlock(dir); mnt_drop_write
>        FMODE_CREATED set ->
>         dput(nd->path.dentry)
>         nd->path.dentry =3D dentry           negative dentry becomes the "o=
pened" path
>         return NULL
>       do_open
>        open_flag & O_CREAT ->
>         may_create_in_sticky(idmap, nd, d_backing_inode(nd->path.dentry))
>                                            inode =3D=3D NULL
>=20
>   Scenario 1, parent not sticky: cgroup created, ENOTDIR returned
>=20
>        may_create_in_sticky
>         if (!(dir_mode & S_ISVTX)) return 0;     inode never touched
>        (nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry)
>                                            DCACHE_MISS_TYPE -> false
>         return -ENOTDIR
>       terminate_walk
>       fput_close(file)
>      return ERR_PTR(-ENOTDIR)              "child" cgroup stays behind
>=20
>   A second openat of the same name works because kernfs_dop_revalidate() se=
es the parent's revision changed, d_invalidate()s the stale negative dentry, =
and the fresh kernfs_iop_lookup() now
>   finds the node.
>=20
>   Scenario 2, sticky parent: NULL dereference
>=20
>   Setup, one-time, as root (what systemd's Delegate=3Dyes does for user.sli=
ce/user-1000.slice/user@1000.service):
>=20
>   fchown(pfd, 1000, 1000)
>    chown_common -> notify_change -> kernfs_iop_setattr -> __kernfs_setattr
>=20
>   Then as uid 1000:
>=20
>   fchmod(pfd, 01755)
>    chmod_common
>     newattrs.ia_mode =3D (mode & S_IALLUGO) | ...   S_ISVTX is inside S_IAL=
LUGO
>     notify_change
>      setattr_prepare
>       inode_owner_or_capable                    owner -> ok
>      kernfs_iop_setattr
>       __kernfs_setattr                          kn->mode =3D ia_mode, no ma=
sking
>       setattr_copy                              inode->i_mode =3D 01755
>=20
>   and the open, same chain as above until may_create_in_sticky(), now with =
nd->dir_mode =3D 01755:
>=20
>        may_create_in_sticky
>         if (!(dir_mode & S_ISVTX)) return 0;     not taken
>         if (S_ISREG(inode->i_mode) && ...)       inode =3D=3D NULL
>                                                  -> KASAN null-ptr-deref
>=20

