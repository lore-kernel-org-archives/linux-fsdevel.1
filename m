Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097D349EC64;
	Fri, 25 Sep 2026 13:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344674; cv=none; b=udob54ju0oCZ5iyV46eEoqGw1XjCayzVyMuNmg+0O/lxXJ1gldnRUGxW5aQn4lHahuosGkfAjXXsvtuej+/Q4j+EzCouweh3XkmeeCNp/IwhIN+TmfT+6WGujMymWdeWNqxV9pBDiTMcMh2KS4tAogoiQiu36x3By/ejjh5zTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344674; c=relaxed/simple;
	bh=mljYbAqaHv5KJiVoomf+d3IveES8RIPURK1TbRhjei8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjQVgTuld0mDWl6YdDrJGtZS48tk+iT5fuNUKtKZv1DK9fmtUAkH5/wgCLsKvnPyjF9UMDKvD2ETz2SOJKG5eCJgM8wW0NOVr0hPQRxUe3SL2C8RKRvvWUTWT9Crh63iIpFG7enGfT+UOQh9xWCJlWsWENqQX27QjrL+tdgjSWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vyd6l+IZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vyd6l+IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58BF1F000FF;
	Fri, 25 Sep 2026 13:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790344672;
	bh=qaWTv1eSuxBpR3kUQE5+u0i1PydYJ31WNyHHeMM+Q1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Vyd6l+IZM83/cRjyQ8FZmiy9PT024iEQXDELhiU7HAlr9PR4Jtn0NCw9PMUzQl2hA
	 6MFkaoZOmW1xiM2NUm1zmSIY8P30Bzn4o3LNhvIN34o3BF1BzYxqT4O/Sjo/dT2zT4
	 fVKUK+DGlSGwfSjVflWdM1bjC76QSFOzCbus7aRjO2esJFZHOsUy+DPl96RJ6cY/jH
	 aeD9GdXPJcyIEckq3J1Ih1MIlN9tQ4VomiWpIxnA5ighO0YJXs02/dypszWxBXeCgL
	 zeGUzeUe6JGZK3Y5lGdYmIMDmME4J0x5zWiSR7iGABqveTUMFVOXYXFsXkeoPLQW7L
	 TZ1Rig/dJBktw==
Date: Fri, 25 Sep 2026 15:57:47 +0200
From: Christian Brauner <brauner@kernel.org>
To: NeilBrown <neil@brown.name>
Cc: Jori Koolstra <jkoolstra@xs4all.nl>, Jeff Layton <jlayton@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Aleksa Sarai <aleksa@amutable.com>, 
	Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260925-zonen-dachwohnung-akkusativ-6a1d1a595810@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
 <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
 <178972607557.207413.4312278359822083538@noble.neil.brown.name>
 <178977609418.207413.15011378414000392029@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <178977609418.207413.15011378414000392029@noble.neil.brown.name>

On Sat, Sep 19, 2026 at 10:01:34AM +1000, NeilBrown wrote:
> On Fri, 18 Sep 2026, NeilBrown wrote:
> > On Fri, 18 Sep 2026, Christian Brauner wrote:
> > > On Sun, Sep 13, 2026 at 08:50:11PM +0200, Jori Koolstra wrote:
> > > > Currently there is no way to race-freely create and open a directory.
> > > > For regular files we have open(O_CREAT) for creating a new file inode,
> > > > and returning a pinning fd to it. The lack of such functionality for
> > > > directories means that when populating a directory tree there's always
> > > > a race involved: the inodes first need to be created, and then opened
> > > > to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> > > > but in the time window between the creation and the opening they might
> > > > be replaced by something else.
> > > > 
> > > > Addressing this race without a proper API is only partially possible:
> > > > the caller can immediately fstat() what was opened to verify that it
> > > > has the expected inode type, owner and mode. But besides being easy to
> > > > get wrong, this cannot establish who created the directory: a directory
> > > > created by another process with identical credentials is
> > > > indistinguishable from one the caller created itself, so the caller
> > > > cannot tell whether the directory is its own to manage.
> > > > 
> > > > Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> > > > a regular file exists at the open path; EISDIR if a directory exists at
> > > > the path; and to create a regular file if no file exists at the path.
> > > > This behaviour changed accidentally with
> > > > commit 973d4b73fbaf ("do_last(): rejoin the common path even earlier in
> > > > FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last case
> > > > while still creating the file. As this change was not detected for a
> > > > long time, Brauner proposed to adopt the more consistent NetBSD
> > > > behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combination.
> > > > This change was applied in commit 43b450632676 ("open: return EINVAL for
> > > > O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has been
> > > > in the kernel for about 3 years now, no rollback is expected as a result
> > > > of userspace reliance on old behaviour, leaving us free to reassign the
> > > > O_CREAT|O_DIRECTORY semantics.
> > > > 
> > > > O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> > > > filesystems. These filesystems currently cannot handle
> > > > O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
> > > > into a fallback mode by stripping the O_CREAT bit. This causes existing
> > > > directories to be successfully opened, while for targets that should
> > > > have been created, -ENOENT is returned. This -ENOENT is then converted
> > > > to -EOPNOTSUPP in later atomic_open(). The simple option of just
> > > > returning -EOPNOTSUPP directly leads to inconsistent behaviour: before
> > > > ->atomic_open() is called in lookup_open(), the dcache is queried. So
> > > > returning -EOPNOTSUPP immediately would make O_CREAT|O_DIRECTORY
> > > > dependent on the cache state of the dentry.
> > > > 
> > > > There is no separate sysctl for directory creation implemented currently.
> > > > Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
> > > > not enough to allow creating a directory in a sticky folder, because that
> > > > may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
> > > > newer kernels.
> > > > 
> > > > This feature idea (and some of its description) is taken from the
> > > > UAPI group:
> > > > https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> > > > 
> > > > Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> > > > ---
> > > >  fs/namei.c            | 116 +++++++++++++++++++++++++++++++++++-------
> > > >  fs/open.c             |  25 +++++----
> > > >  include/linux/fcntl.h |   6 +++
> > > >  3 files changed, 117 insertions(+), 30 deletions(-)
> > > > 
> > > > diff --git a/fs/namei.c b/fs/namei.c
> > > > index 0efd395a1a65..6ff0a3c04f02 100644
> > > > --- a/fs/namei.c
> > > > +++ b/fs/namei.c
> > > > @@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
> > > >  
> > > >  /**
> > > >   * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
> > > > - *			  should be allowed, or not, on files that already
> > > > - *			  exist.
> > > > + *			  should be allowed, or not, on files/directories that
> > > > + *			  already exist.
> > > >   * @idmap: idmap of the mount the inode was found from
> > > >   * @nd: nameidata pathwalk data
> > > >   * @inode: the inode of the file to open
> > > >   *
> > > > - * Block an O_CREAT open of a FIFO (or a regular file) when:
> > > > + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
> > > >   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
> > > >   *   - the file already exists
> > > >   *   - we are in a sticky directory
> > > > @@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
> > > >  	if (likely(!(dir_mode & S_ISVTX)))
> > > >  		return 0;
> > > >  
> > > > +	/*
> > > > +	 * There is no separate sysctl for directory creation in sticky
> > > > +	 * folders. Therefore, for the S_ISDIR case, disabling
> > > > +	 * sysctl_protected_regular is not enough to allow creating a
> > > > +	 * directory in a sticky folder, because that may surprise users
> > > > +	 * not expecting that O_CREAT|O_DIRECTORY is possible on newer
> > > > +	 * kernels.
> > > > +	 */
> > > >  	if (S_ISREG(inode->i_mode) && !sysctl_protected_regular)
> > > >  		return 0;
> > > >  
> > > > @@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
> > > >  					      "sticky_create_regular");
> > > >  			return -EACCES;
> > > >  		}
> > > > +
> > > > +		if (S_ISDIR(inode->i_mode)) {
> > > > +			audit_log_path_denied(AUDIT_ANOM_CREAT,
> > > > +					      "sticky_create_dir");
> > > > +			return -EACCES;
> > > > +		}
> > > >  	}
> > > >  
> > > >  	return 0;
> > > > @@ -4334,21 +4348,43 @@ static inline int open_to_namei_flags(int flag)
> > > >  
> > > >  static int may_o_create(struct mnt_idmap *idmap,
> > > >  			const struct path *dir, struct dentry *dentry,
> > > > -			umode_t mode)
> > > > +			int open_flag, umode_t mode)
> > > >  {
> > > > -	int error = security_path_mknod(dir, dentry, mode, 0);
> > > > +	struct inode *dir_inode = dir->dentry->d_inode;
> > > > +	bool create_dir = O_IS_MKDIR(open_flag);
> > > > +	int error;
> > > > +
> > > > +	WARN_ON_ONCE(create_dir && !(mode & S_IFDIR));
> > > > +
> > > > +	if (create_dir)
> > > > +		error = security_path_mkdir(dir, dentry, mode);
> > > > +	else
> > > > +		error = security_path_mknod(dir, dentry, mode, 0);
> > > >  	if (error)
> > > >  		return error;
> > > >  
> > > >  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
> > > >  		return -EOVERFLOW;
> > > >  
> > > > -	error = inode_permission(idmap, dir->dentry->d_inode,
> > > > -				 MAY_WRITE | MAY_EXEC);
> > > > +	error = inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
> > > >  	if (error)
> > > >  		return error;
> > > >  
> > > > -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> > > > +	if (create_dir)
> > > > +		error = security_inode_mkdir(dir_inode, dentry, mode);
> > > > +	else
> > > > +		error = security_inode_create(dir_inode, dentry, mode);
> > > > +
> > > > +	return error;
> > > > +}
> > > > +
> > > > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > > > +		const struct inode *dir, int open_flag, umode_t mode)
> > > > +{
> > > > +	if (O_IS_MKDIR(open_flag))
> > > > +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
> > > > +	else
> > > > +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> > > >  }
> > > >  
> > > >  /**
> > > > @@ -4384,8 +4420,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> > > >  
> > > >  	file->__f_path.dentry = DENTRY_NOT_SET;
> > > >  	file->__f_path.mnt = path->mnt;
> > > > +
> > > >  	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
> > > > -				       open_to_namei_flags(open_flag), mode);
> > > > +					     open_to_namei_flags(open_flag), mode);
> > > >  	d_lookup_done(dentry);
> > > >  
> > > >  	if (!error) {
> > > > @@ -4427,12 +4464,32 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> > > >  			 */
> > > >  			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > > >  			error = create_error;
> > > > +		} else if (O_IS_MKDIR(open_flag) && error == -ENOENT) {
> > > > +			/*
> > > > +			 * If the underlying filesystem does not implement
> > > > +			 * O_CREAT|O_DIRECTORY, it strips the O_CREAT bit and
> > > > +			 * continues as a lookup. We can't simply return
> > > > +			 * -EOPNOTSUPP from unsupported ->atomic_open()
> > > > +			 * implementations because the dentry might be in the
> > > > +			 * dcache. In that case, lookup_open() returns before
> > > > +			 * reaching ->atomic_open(), and hence whether you get
> > > > +			 * -EOPNOTSUPP on O_CREAT|O_DIRECTORY would not only
> > > > +			 * depend on the underlying filesystem, but also on
> > > > +			 * the state of the dcache. Still, we must make an
> > > > +			 * effort to differentiate a regular -ENOENT from the
> > > > +			 * unsupported O_CREAT|O_DIRECTORY case.
> > > > +			 */
> > > > +			error = -EOPNOTSUPP;
> > > >  		}
> > > >  		dput(dentry);
> > > >  		dentry = ERR_PTR(error);
> > > >  	} else {
> > > > -		if (file->f_mode & FMODE_CREATED)
> > > > -			fsnotify_create(dir_inode, dentry);
> > > > +		if (file->f_mode & FMODE_CREATED) {
> > > > +			if (d_is_dir(dentry))
> > > > +				fsnotify_mkdir(dir_inode, dentry);
> > > > +			else
> > > > +				fsnotify_create(dir_inode, dentry);
> > > > +		}
> > > >  		if (file->f_mode & FMODE_OPENED)
> > > >  			fsnotify_open(file);
> > > >  	}
> > > > @@ -4441,6 +4498,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> > > >  	return dentry;
> > > >  }
> > > >  
> > > > +static inline
> > > > +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *, struct dentry *,
> > > > +				 umode_t, struct delegated_inode *);
> > > >  /*
> > > >   * Look up and maybe create and open the last component.
> > > >   *
> > > > @@ -4462,6 +4522,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > >  	struct mnt_idmap *idmap;
> > > >  	struct dentry *dir = nd->path.dentry;
> > > >  	struct inode *dir_inode = dir->d_inode;
> > > > +	bool create_dir = O_IS_MKDIR(op->open_flag);
> > > >  	int open_flag;
> > > >  	struct dentry *dentry;
> > > >  	int error, create_error;
> > > > @@ -4474,6 +4535,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > >  	mode = op->mode;
> > > >  	create_error = 0;
> > > >  
> > > > +	if (create_dir && dir_inode->i_op->atomic_open)
> > > > +		open_flag &= ~O_CREAT;
> > > > +
> > > >  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> > > >  		got_write = !mnt_want_write(nd->path.mnt);
> > > >  		/*
> > > > @@ -4534,10 +4598,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > >  	if (open_flag & O_CREAT) {
> > > >  		if (open_flag & O_EXCL)
> > > >  			open_flag &= ~O_TRUNC;
> > > > -		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> > > > +		mode = o_create_mode(idmap, dir_inode, open_flag, mode);
> > > >  		if (likely(got_write))
> > > >  			create_error = may_o_create(idmap, &nd->path,
> > > > -						    dentry, mode);
> > > > +						    dentry, open_flag, mode);
> > > >  		else
> > > >  			create_error = -EROFS;
> > > >  	}
> > > > @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > > >  		goto out_dput;
> > > >  	}
> > > >  
> > > > -	if (!dir_inode->i_op->create) {
> > > > +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> > > > +	if (create_dir && !dir_inode->i_op->mkdir) {
> > > > +		error = -EPERM;
> > > > +		goto out_dput;
> > > > +	}
> > > > +	if (!create_dir && !dir_inode->i_op->create) {
> > > >  		error = -EACCES;
> > > >  		goto out_dput;
> > > >  	}
> > > >  
> > > > -	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> > > > +	if (create_dir) {
> > > > +		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry, mode,
> > > > +						       &delegated_inode);
> > > 
> > > So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
> > > passed to do_open(). Kernfs makes that buggy.
> > > 
> > > cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
> > > kernfs ->mkdir:: iop never instantiates the dentry.
> > > 
> > > So that means e.g.,
> > > 
> > > openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
> > > and then fails with ENOTDIR.
> > > 
> > > So the negative dentry gets handed out and now userspace holds an fd
> > > with that negative dentry. So say userspace does fchown() to 1000 and
> > > then fchmod() with the sticky bit and then you get a NULL deref. I have
> > > reproduced this.
> > > 
> > > Neil can correct me but the fix might be to check whether the dentry is
> > > negative in lookup_open() and re-lookup nd->last with the parent still locked.
> > > I think that's what nfsd_create_locked() and cachefiles_get_directory() do
> > > after vfs_mkdir().
> > 
> > nfsd_create_locked() used to do that before vfs_mkdir() could return a
> > dentry, but it doesn't any more.  The reason was because
> > d_splice_alias() on might return a different dentry. 
> > In this case we want the same dentry, but we need to do a lookup on it.
> > 
> > I'd rather fix this in kernfs, but maybe that is a longer-term goal.
> > 
> > The comment in kernfs_dop_revalidate() suggests the we should d_drop()
> > the negative dentry and d_alloc_parallel() a new one and ->lookup that.
> > I'm not certain that is needed if we keep the parent locked, but we
> > would need to be certain.
> > We at least need to d_drop() the dentry before ->lookup as ->lookup
> > cannot handle hashed dentries and a hashed-negative dentry is passed
> > to ->mkdir.
> > 
> > I wonder if we could just disable O_CREATE|O_DIRECTORY on kernfs ....
> > probably not.
> > 
> > Summary: I think that if vfs_mkdir() returns NULL (success) but the
> > dentry is negative, we need to d_drop() and call ->lookup with a big
> > comment about kernfs.  But we need to double-check that this will do the
> > right thing with ->d_time (I think it will).
> > We also need to think carefully about races with
> > kernfs_dop_revalidate(), which could happen concurrently with the
> > ->lookup.
> 
> I've thought a bit more about this ...  I think that doing a lookup after
> the vfs_mkdir() results in a negative is a bit ugly.  It assumes things
> about the fs that I would rather not assume.
> 
> I would rather have the current proposed code check for a negative
> dentry, and fail with -EIO or similar.
> 
> We could then "fix" kernfs by providing an atomic_open which does the
> mkdir and then the lookup, and provides the dentry to
> finish_no_lookup().
> 
> That way we don't need to change kernfs mkdir.
> 
> Note that tracefs_syscall_mkdir() has the same behaviour as
> kernfs_iop_mkdir, and could have the same fix.

Sounds good to me. But should we do this in one single release so
userspace doesn't have a 90% working thing?
