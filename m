Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7905B2475CB;
	Sat, 19 Sep 2026 00:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789776107; cv=none; b=bhRb1QWgoPeDEObR/TOR/D06wfEgUldKDQuPUWoDqGCA+a5Nw9jAjoB2n3uB9DkmFINQosevPnZxQ8TXmFkF1H+MZXE3T0mam9cyeaHZ/ymFjTyqHqIrjUmk0R16Qoo3hVGJmke+rONzlS4k2ZCjoPOcXg7Cj6mPy/PcC2C0AiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789776107; c=relaxed/simple;
	bh=lTxGL3/JXdfy0uOHK0+A3nxrtjYHVklQ6IVRriNYyrE=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=EQX1ks2997QW7/36KbQ1iGD0tRhk+0DuujWPzVZwRhhyccBU8gqRqNBBSyGWeKc4lm6Bvt3B2R6R7o6ffjl24FMj4lB5GgZrKG4adeoAwsDBTRQYbg8O7sO77Bh0dt30TEOp1khbRz7MmmvCnMBPs8mQ93/ZZ6iTtcH7dfK57a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net; spf=pass smtp.mailfrom=ownmail.net; dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b=JmVShZhw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FBpbhE9K; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ownmail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ownmail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ownmail.net header.i=@ownmail.net header.b="JmVShZhw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FBpbhE9K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6591A7A001E;
	Fri, 18 Sep 2026 20:01:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 18 Sep 2026 20:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ownmail.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to; s=fm1; t=
	1789776102; x=1789862502; bh=M/jBHrvbAvaEgJh3nmu59hFK3G04VX2WuvA
	DZ3GLaPI=; b=JmVShZhwyJyn/5xgJq8IJlQ1a61A63/hAtFkex1JfO8lqsiVRAL
	EJFksBtvEiOtKXo8JiRK97VS/Sq7oSU+LMAFhx9jwA5xBcScDQsloRuekAQmZvDB
	HTV6gPNoKL8SFg010cFCfLuz6siODoQ/38viQEa4oOY+j2+LSOK1OiDEiWHILvNA
	ZUTSTfELOzwD4huTroMhXYUmZJJrj195kbglB8jC3ZnrK5anCOEYip97L3NU/EB/
	zkUpHKMS5eB1T3fKrTpWQzapYwf91345Bof/H86vot71bUyTdKGHEeXE93IOR8xO
	1yXWWZcb5Oojjw7j7LQFExEj9UcooLo83RQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789776102; x=
	1789862502; bh=M/jBHrvbAvaEgJh3nmu59hFK3G04VX2WuvADZ3GLaPI=; b=F
	BpbhE9K5Zej4262hvHTnImUNJgzcPaOEK6c20cLlK6403AW5tc6wwfDF/M5EAfy4
	hqyugj9Th7iIap36dsHUlOnEk1joq0oqhdQ2kDkLyy3YUasfuYV8GoWVi0thMeuB
	ORK5MiHrOKOIiFvj3QD6qc/6c87ym+2gvu4FCNzfWMd31TD4CRzKUFXZzu/Mi+oQ
	fe/nnkV/aMNMQO3lFIC0b1W7tkhAclmZGF0e9iV/biI2G1AfgkDSEXLKM0UFgvae
	2qwyXlhBO0zLi/uY9qTcTaY1sdzZdKVmcJrqdYXA3blFDHDTRLtTwcalm0PO0+Na
	Fp+8SObXqGLpXnrikunCQ==
X-ME-Sender: <xms:5dCtamxMxipAqQ3j9c74aKcDv2HYHVusXqch_4gmdkWA3RIdvu3J8Q>
    <xme:5dCtau14c_LrtqDzMzVhFs9ZKttGVjFuLEZHWpW8nuNoJ9fOt7TbHF4mtLi_5LThg
    YPziXi0J4GOfGQmSOGvqpmtfFYTNv0mRCoMOacKbUaVIAb7WTo>
X-ME-Received: <xmr:5dCtasyj8W190nvAwNa8c5zDp1ocIxbxGZ1Out2trHLPlibL40HAnszH58nqI06ts0CuMbPgA-XOr38Qhbs9qrDZIh9cE4U>
X-ME-Proxy-Cause: dmFkZTEdveqIY3eVFnEjAz5seAFEposwyWF7kdqLXAVxMTkrCvFMEoIhNQbs7gEyLjrQNe
    OST2626frlX6mh6H/Hyq05Xm8utce2qTbvNbsIL2LGtlre98UTM5GAxAa0rrxoeWAj/pUn
    cZRwswtOBq97VKM2hMFDkS48XpZwheVjUwIvdmjyc+cJGBp82mBd6ZkPIVqI8/bFTBb7fS
    R1mtKY8nKY3DxfURvzc9KHblPY6gwvYciw+HvEFlCU398J3yd2raOKR9kQ6cGY6lmLqkl5
    6GrCDRx19smdYZUQeX3VmIi3Lqm6/VcjcaN+7+micQwMMcQAquTF4P0GvVQbzxFEoyaXaL
    peOe3OR1I2CbezAjpxr2ePqVFIi2PYgat2g8m9Rzs4eMsfbjZIcqfr2JGlSWJjUV4iTlTe
    xk4tVAFN54O8RDrMZdrTaDupghTSyh2xgU0f/ul0IemY9FyqRt71dO1YQUX33uZXx7DQdd
    qPOC3XY3xEnXoeeaO2vTzRo5J99YHNHZnXMUgfJ+vSfbokqZVqTh/esDUrahE6VkVx6pT2
    MF4qzZemmutvwkD9J7ZiK6XLeG5qETfuEuuQDMWTnisSSD2YEcwSltiLhff16N80kk19DM
    H9piMWzaewD8WciOMaGNVhqwZeXsXie6xwWLXX3DXZuIbYioz8TQG2eox5jw
X-ME-Proxy: <xmx:5dCtajUHkQGrGw9LwzeLHOcJ-dw7pVy_kbc1NHFjPSieCYxJIdHGdw>
    <xmx:5dCtao-HM-5fAzwJvmcGWFi_P6AKBglfVCACvnvId81Gx1h8ukP4Vw>
    <xmx:5dCtamupkYr9IYexAfmL5W3GLCR3wWWO2rrDhEUTfrjNR95Q0n9SOA>
    <xmx:5dCtao2tn2rxhMF4jt7aGvGlVRnJZyMOAu0wVXnfkbkEpggl0Gy5lg>
    <xmx:5tCtahkw49GLXyPdRHK2o5GDkTozKn_sPJR4-6L-udForjfCaCsuT9mB>
Feedback-ID: i9d664b8f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Sep 2026 20:01:38 -0400 (EDT)
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
In-reply-to: <178972607557.207413.4312278359822083538@noble.neil.brown.name>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
  <20260913185016.523376-8-jkoolstra@xs4all.nl>
  <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
  <178972607557.207413.4312278359822083538@noble.neil.brown.name>
Date: Sat, 19 Sep 2026 10:01:34 +1000
Message-id: <178977609418.207413.15011378414000392029@noble.neil.brown.name>
Reply-To: NeilBrown <neil@brown.name>

On Fri, 18 Sep 2026, NeilBrown wrote:
> On Fri, 18 Sep 2026, Christian Brauner wrote:
> > On Sun, Sep 13, 2026 at 08:50:11PM +0200, Jori Koolstra wrote:
> > > Currently there is no way to race-freely create and open a directory.
> > > For regular files we have open(O_CREAT) for creating a new file inode,
> > > and returning a pinning fd to it. The lack of such functionality for
> > > directories means that when populating a directory tree there's always
> > > a race involved: the inodes first need to be created, and then opened
> > > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > > but in the time window between the creation and the opening they might
> > > be replaced by something else.
> > >=20
> > > Addressing this race without a proper API is only partially possible:
> > > the caller can immediately fstat() what was opened to verify that it
> > > has the expected inode type, owner and mode. But besides being easy to
> > > get wrong, this cannot establish who created the directory: a directory
> > > created by another process with identical credentials is
> > > indistinguishable from one the caller created itself, so the caller
> > > cannot tell whether the directory is its own to manage.
> > >=20
> > > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > > a regular file exists at the open path; EISDIR if a directory exists at
> > > the path; and to create a regular file if no file exists at the path.
> > > This behaviour changed accidentally with
> > > commit 973d4b73fbaf ("do_last(): rejoin the common path even earlier in
> > > FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last case
> > > while still creating the file. As this change was not detected for a
> > > long time, Brauner proposed to adopt the more consistent NetBSD
> > > behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combination.
> > > This change was applied in commit 43b450632676 ("open: return EINVAL for
> > > O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has been
> > > in the kernel for about 3 years now, no rollback is expected as a result
> > > of userspace reliance on old behaviour, leaving us free to reassign the
> > > O_CREAT|O_DIRECTORY semantics.
> > >=20
> > > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > > filesystems. These filesystems currently cannot handle
> > > O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
> > > into a fallback mode by stripping the O_CREAT bit. This causes existing
> > > directories to be successfully opened, while for targets that should
> > > have been created, -ENOENT is returned. This -ENOENT is then converted
> > > to -EOPNOTSUPP in later atomic_open(). The simple option of just
> > > returning -EOPNOTSUPP directly leads to inconsistent behaviour: before
> > > ->atomic_open() is called in lookup_open(), the dcache is queried. So
> > > returning -EOPNOTSUPP immediately would make O_CREAT|O_DIRECTORY
> > > dependent on the cache state of the dentry.
> > >=20
> > > There is no separate sysctl for directory creation implemented currentl=
y.
> > > Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
> > > not enough to allow creating a directory in a sticky folder, because th=
at
> > > may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
> > > newer kernels.
> > >=20
> > > This feature idea (and some of its description) is taken from the
> > > UAPI group:
> > > https://github.com/uapi-group/kernel-features?tab=3Dreadme-ov-file#race=
-free-creation-and-opening-of-non-file-inodes
> > >=20
> > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > ---
> > >  fs/namei.c            | 116 +++++++++++++++++++++++++++++++++++-------
> > >  fs/open.c             |  25 +++++----
> > >  include/linux/fcntl.h |   6 +++
> > >  3 files changed, 117 insertions(+), 30 deletions(-)
> > >=20
> > > diff --git a/fs/namei.c b/fs/namei.c
> > > index 0efd395a1a65..6ff0a3c04f02 100644
> > > --- a/fs/namei.c
> > > +++ b/fs/namei.c
> > > @@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, const s=
truct path *link)
> > > =20
> > >  /**
> > >   * may_create_in_sticky - Check whether an O_CREAT open in a sticky di=
rectory
> > > - *			  should be allowed, or not, on files that already
> > > - *			  exist.
> > > + *			  should be allowed, or not, on files/directories that
> > > + *			  already exist.
> > >   * @idmap: idmap of the mount the inode was found from
> > >   * @nd: nameidata pathwalk data
> > >   * @inode: the inode of the file to open
> > >   *
> > > - * Block an O_CREAT open of a FIFO (or a regular file) when:
> > > + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
> > >   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
> > >   *   - the file already exists
> > >   *   - we are in a sticky directory
> > > @@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_idmap=
 *idmap, struct nameidata *nd,
> > >  	if (likely(!(dir_mode & S_ISVTX)))
> > >  		return 0;
> > > =20
> > > +	/*
> > > +	 * There is no separate sysctl for directory creation in sticky
> > > +	 * folders. Therefore, for the S_ISDIR case, disabling
> > > +	 * sysctl_protected_regular is not enough to allow creating a
> > > +	 * directory in a sticky folder, because that may surprise users
> > > +	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
> > > +	 * kernels.
> > > +	 */
> > >  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> > >  		return 0;
> > > =20
> > > @@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_idmap=
 *idmap, struct nameidata *nd,
> > >  					      "sticky_create_regular");
> > >  			return -EACCES;
> > >  		}
> > > +
> > > +		if (S_ISDIR(inode->i_mode)) {
> > > +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> > > +					      "sticky_create_dir");
> > > +			return -EACCES;
> > > +		}
> > >  	}
> > > =20
> > >  	return 0;
> > > @@ -4334,21 +4348,43 @@ static inline int open_to_namei_flags(int flag)
> > > =20
> > >  static int may_o_create(struct mnt_idmap *idmap,
> > >  			const struct path *dir, struct dentry *dentry,
> > > -			umode_t mode)
> > > +			int open_flag, umode_t mode)
> > >  {
> > > -	int error =3D security_path_mknod(dir, dentry, mode, 0);
> > > +	struct inode *dir_inode =3D dir->dentry->d_inode;
> > > +	bool create_dir =3D O_IS_MKDIR(open_flag);
> > > +	int error;
> > > +
> > > +	WARN_ON_ONCE(create_dir && !(mode & S_IFDIR));
> > > +
> > > +	if (create_dir)
> > > +		error =3D security_path_mkdir(dir, dentry, mode);
> > > +	else
> > > +		error =3D security_path_mknod(dir, dentry, mode, 0);
> > >  	if (error)
> > >  		return error;
> > > =20
> > >  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
> > >  		return -EOVERFLOW;
> > > =20
> > > -	error =3D inode_permission(idmap, dir->dentry->d_inode,
> > > -				 MAY_WRITE | MAY_EXEC);
> > > +	error =3D inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
> > >  	if (error)
> > >  		return error;
> > > =20
> > > -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> > > +	if (create_dir)
> > > +		error =3D security_inode_mkdir(dir_inode, dentry, mode);
> > > +	else
> > > +		error =3D security_inode_create(dir_inode, dentry, mode);
> > > +
> > > +	return error;
> > > +}
> > > +
> > > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > > +		const struct inode *dir, int open_flag, umode_t mode)
> > > +{
> > > +	if (O_IS_MKDIR(open_flag))
> > > +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFD=
IR);
> > > +	else
> > > +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> > >  }
> > > =20
> > >  /**
> > > @@ -4384,8 +4420,9 @@ static struct dentry *atomic_open(const struct pa=
th *path, struct dentry *dentry
> > > =20
> > >  	file->__f_path.dentry =3D DENTRY_NOT_SET;
> > >  	file->__f_path.mnt =3D path->mnt;
> > > +
> > >  	error =3D dir_inode->i_op->atomic_open(dir_inode, dentry, file,
> > > -				       open_to_namei_flags(open_flag), mode);
> > > +					     open_to_namei_flags(open_flag), mode);
> > >  	d_lookup_done(dentry);
> > > =20
> > >  	if (!error) {
> > > @@ -4427,12 +4464,32 @@ static struct dentry *atomic_open(const struct =
path *path, struct dentry *dentry
> > >  			 */
> > >  			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > >  			error =3D create_error;
> > > +		} else if (O_IS_MKDIR(open_flag) && error =3D=3D -ENOENT) {
> > > +			/*
> > > +			 * If the underlying filesystem does not implement
> > > +			 * O_CREAT|O_DIRECTORY, it strips the O_CREAT bit and
> > > +			 * continues as a lookup. We can't simply return
> > > +			 * -EOPNOTSUPP from unsupported ->atomic_open()
> > > +			 * implementations because the dentry might be in the
> > > +			 * dcache. In that case, lookup_open() returns before
> > > +			 * reaching ->atomic_open(), and hence whether you get
> > > +			 * -EOPNOTSUPP on O_CREAT|O_DIRECTORY would not only
> > > +			 * depend on the underlying filesystem, but also on
> > > +			 * the state of the dcache. Still, we must make an
> > > +			 * effort to differentiate a regular -ENOENT from the
> > > +			 * unsupported O_CREAT|O_DIRECTORY case.
> > > +			 */
> > > +			error =3D -EOPNOTSUPP;
> > >  		}
> > >  		dput(dentry);
> > >  		dentry =3D ERR_PTR(error);
> > >  	} else {
> > > -		if (file->f_mode & FMODE_CREATED)
> > > -			fsnotify_create(dir_inode, dentry);
> > > +		if (file->f_mode & FMODE_CREATED) {
> > > +			if (d_is_dir(dentry))
> > > +				fsnotify_mkdir(dir_inode, dentry);
> > > +			else
> > > +				fsnotify_create(dir_inode, dentry);
> > > +		}
> > >  		if (file->f_mode & FMODE_OPENED)
> > >  			fsnotify_open(file);
> > >  	}
> > > @@ -4441,6 +4498,9 @@ static struct dentry *atomic_open(const struct pa=
th *path, struct dentry *dentry
> > >  	return dentry;
> > >  }
> > > =20
> > > +static inline
> > > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *, s=
truct dentry *,
> > > +				 umode_t, struct delegated_inode *);
> > >  /*
> > >   * Look up and maybe create and open the last component.
> > >   *
> > > @@ -4462,6 +4522,7 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> > >  	struct mnt_idmap *idmap;
> > >  	struct dentry *dir =3D nd->path.dentry;
> > >  	struct inode *dir_inode =3D dir->d_inode;
> > > +	bool create_dir =3D O_IS_MKDIR(op->open_flag);
> > >  	int open_flag;
> > >  	struct dentry *dentry;
> > >  	int error, create_error;
> > > @@ -4474,6 +4535,9 @@ static struct dentry *lookup_open(struct nameidat=
a *nd, struct file *file,
> > >  	mode =3D op->mode;
> > >  	create_error =3D 0;
> > > =20
> > > +	if (create_dir && dir_inode->i_op->atomic_open)
> > > +		open_flag &=3D ~O_CREAT;
> > > +
> > >  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> > >  		got_write =3D !mnt_want_write(nd->path.mnt);
> > >  		/*
> > > @@ -4534,10 +4598,10 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> > >  	if (open_flag & O_CREAT) {
> > >  		if (open_flag & O_EXCL)
> > >  			open_flag &=3D ~O_TRUNC;
> > > -		mode =3D vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> > > +		mode =3D o_create_mode(idmap, dir_inode, open_flag, mode);
> > >  		if (likely(got_write))
> > >  			create_error =3D may_o_create(idmap, &nd->path,
> > > -						    dentry, mode);
> > > +						    dentry, open_flag, mode);
> > >  		else
> > >  			create_error =3D -EROFS;
> > >  	}
> > > @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct nameid=
ata *nd, struct file *file,
> > >  		goto out_dput;
> > >  	}
> > > =20
> > > -	if (!dir_inode->i_op->create) {
> > > +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> > > +	if (create_dir && !dir_inode->i_op->mkdir) {
> > > +		error =3D -EPERM;
> > > +		goto out_dput;
> > > +	}
> > > +	if (!create_dir && !dir_inode->i_op->create) {
> > >  		error =3D -EACCES;
> > >  		goto out_dput;
> > >  	}
> > > =20
> > > -	error =3D vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> > > +	if (create_dir) {
> > > +		struct dentry *res =3D vfs_mkdir_no_perm(idmap, dir_inode, dentry, m=
ode,
> > > +						       &delegated_inode);
> >=20
> > So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
> > passed to do_open(). Kernfs makes that buggy.
> >=20
> > cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
> > kernfs ->mkdir:: iop never instantiates the dentry.
> >=20
> > So that means e.g.,
> >=20
> > openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
> > and then fails with ENOTDIR.
> >=20
> > So the negative dentry gets handed out and now userspace holds an fd
> > with that negative dentry. So say userspace does fchown() to 1000 and
> > then fchmod() with the sticky bit and then you get a NULL deref. I have
> > reproduced this.
> >=20
> > Neil can correct me but the fix might be to check whether the dentry is
> > negative in lookup_open() and re-lookup nd->last with the parent still lo=
cked.
> > I think that's what nfsd_create_locked() and cachefiles_get_directory() do
> > after vfs_mkdir().
>=20
> nfsd_create_locked() used to do that before vfs_mkdir() could return a
> dentry, but it doesn't any more.  The reason was because
> d_splice_alias() on might return a different dentry.=20
> In this case we want the same dentry, but we need to do a lookup on it.
>=20
> I'd rather fix this in kernfs, but maybe that is a longer-term goal.
>=20
> The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> I'm not certain that is needed if we keep the parent locked, but we
> would need to be certain.
> We at least need to d_drop() the dentry before ->lookup as ->lookup
> cannot handle hashed dentries and a hashed-negative dentry is passed
> to ->mkdir.
>=20
> I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> probably not.
>=20
> Summary: I think that if vfs_mkdir() returns NULL (success) but the
> dentry is negative, we need to d_drop() and call ->lookup with a big
> comment about kernfs.  But we need to double-check that this will do the
> right thing with ->d_time (I think it will).
> We also need to think carefully about races with
> kernfs_dop_revalidate(), which could happen concurrently with the
> ->lookup.

I've thought a bit more about this ...  I think that doing a lookup after
the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
about the fs that I would rather not assume.

I would rather have the current proposed code check for a negative
dentry, and fail with -EIO or similar.

We could then "fix" kernfs by providing an atomic_open which does the
mkdir and then the lookup, and provides the dentry to
finish_no_lookup().

That way we don't need to change kernfs mkdir.

Note that tracefs_syscall_mkdir() has the same behaviour as
kernfs_iop_mkdir, and could have the same fix.

NeilBrown
