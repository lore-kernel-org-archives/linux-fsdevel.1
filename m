Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAAF3A59B1;
	Fri, 18 Sep 2026 08:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789719461; cv=none; b=bsw0n/3UK+eVNM1OX4NzB2gpBTr2U/lUvPU80fpPQXzLtKHQdiNUUmr3kVbnLbZKjEcgKrmgBsY2n4W1Y4gioGdf7ywEJwG5wpMhF95CrCzj3YUS4EPfqSxyMu4rjqKgPplAw/RfkPhxtGxMfA3UcyAbcthR5brwlGU5CaPGSp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789719461; c=relaxed/simple;
	bh=fmpWhwxzBVmKzlq7wTyB4lv2TLcgyS68P61Hj1fRTrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwnYGjgV1piGxbICUoLK9kWMaQkxI4Mm1d+/kCX8yt0IS47qwxDznmMHYTZfYmG0XqVLWMQR5spboFE/dBUPOKK4wlOL8bP1Ub45OD/7gbrClbfF+ro9qBO51FTektl8+SjOHl6SDB+TAAfgWzeuzDKutiSjfZ56ZI4kxum8O18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV+q2sIf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV+q2sIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77A21F000FF;
	Fri, 18 Sep 2026 08:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789719459;
	bh=xCNkBseCRXzV3BiWW2QRIAG4KmP4sCCO1fkNnIcdt6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kV+q2sIf85NgXyyMMIVa+7XqfPiHz2nBH1HtPqZrbhLNHqhU1VFlfi49dXNoCfGHB
	 FRpwgNt3B40abXEWOMIdLGDsef+9a7upIp5qY15/I0wzCvg1Z0YSKzjGP5R6rmjaxg
	 V4iobJvG3L1Ffowl6/1kwJ2Stf5ZuF2jLYVSS9ncQnvU8x/o0YtJp1lU4mmxpdrtoQ
	 J2Y6TaFJG4iLJxB6LFHphCrj3G2X/F7DB3K1ZJFBnyHUtT1nEcgtG//JCdm6jEXEZY
	 RCQpUZquPsP9ZApqeJw2AuDiiRtBD0TZrxVTowweaoWDQp+nJ28MDly2Lcm1sgCA0H
	 biPoKZLmOnoxw==
Date: Fri, 18 Sep 2026 10:17:34 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>, NeilBrown <neil@brown.name>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 07/12] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260918-reklamieren-syndikat-gemildert-763b72008b46@brauner>
References: <20260913185016.523376-1-jkoolstra@xs4all.nl>
 <20260913185016.523376-8-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260913185016.523376-8-jkoolstra@xs4all.nl>

On Sun, Sep 13, 2026 at 08:50:11PM +0200, Jori Koolstra wrote:
> Currently there is no way to race-freely create and open a directory.
> For regular files we have open(O_CREAT) for creating a new file inode,
> and returning a pinning fd to it. The lack of such functionality for
> directories means that when populating a directory tree there's always
> a race involved: the inodes first need to be created, and then opened
> to adjust their permissions/ownership/labels/timestamps/acls/xattrs/...,
> but in the time window between the creation and the opening they might
> be replaced by something else.
> 
> Addressing this race without a proper API is only partially possible:
> the caller can immediately fstat() what was opened to verify that it
> has the expected inode type, owner and mode. But besides being easy to
> get wrong, this cannot establish who created the directory: a directory
> created by another process with identical credentials is
> indistinguishable from one the caller created itself, so the caller
> cannot tell whether the directory is its own to manage.
> 
> Historically, the O_CREAT|O_DIRECTORY behaviour was to return ENOTDIR if
> a regular file exists at the open path; EISDIR if a directory exists at
> the path; and to create a regular file if no file exists at the path.
> This behaviour changed accidentally with
> commit 973d4b73fbaf ("do_last(): rejoin the common path even earlier in
> FMODE_{OPENED,CREATED} case") causing ENOTDIR to return in the last case
> while still creating the file. As this change was not detected for a
> long time, Brauner proposed to adopt the more consistent NetBSD
> behaviour, i.e. to return EINVAL on the O_CREAT|O_DIRECTORY combination.
> This change was applied in commit 43b450632676 ("open: return EINVAL for
> O_DIRECTORY | O_CREAT") in March, 2023. As the EINVAL behaviour has been
> in the kernel for about 3 years now, no rollback is expected as a result
> of userspace reliance on old behaviour, leaving us free to reassign the
> O_CREAT|O_DIRECTORY semantics.
> 
> O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> filesystems. These filesystems currently cannot handle
> O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
> into a fallback mode by stripping the O_CREAT bit. This causes existing
> directories to be successfully opened, while for targets that should
> have been created, -ENOENT is returned. This -ENOENT is then converted
> to -EOPNOTSUPP in later atomic_open(). The simple option of just
> returning -EOPNOTSUPP directly leads to inconsistent behaviour: before
> ->atomic_open() is called in lookup_open(), the dcache is queried. So
> returning -EOPNOTSUPP immediately would make O_CREAT|O_DIRECTORY
> dependent on the cache state of the dentry.
> 
> There is no separate sysctl for directory creation implemented currently.
> Therefore, for the S_ISDIR case, disabling sysctl_protected_regular is
> not enough to allow creating a directory in a sticky folder, because that
> may surprise users not expecting that O_CREAT|O_DIRECTORY is possible on
> newer kernels.
> 
> This feature idea (and some of its description) is taken from the
> UAPI group:
> https://github.com/uapi-group/kernel-features?tab=readme-ov-file#race-free-creation-and-opening-of-non-file-inodes
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c            | 116 +++++++++++++++++++++++++++++++++++-------
>  fs/open.c             |  25 +++++----
>  include/linux/fcntl.h |   6 +++
>  3 files changed, 117 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 0efd395a1a65..6ff0a3c04f02 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1382,13 +1382,13 @@ int may_linkat(struct mnt_idmap *idmap, const struct path *link)
>  
>  /**
>   * may_create_in_sticky - Check whether an O_CREAT open in a sticky directory
> - *			  should be allowed, or not, on files that already
> - *			  exist.
> + *			  should be allowed, or not, on files/directories that
> + *			  already exist.
>   * @idmap: idmap of the mount the inode was found from
>   * @nd: nameidata pathwalk data
>   * @inode: the inode of the file to open
>   *
> - * Block an O_CREAT open of a FIFO (or a regular file) when:
> + * Block an O_CREAT open of a FIFO (or a regular file/directory) when:
>   *   - sysctl_protected_fifos (or sysctl_protected_regular) is enabled
>   *   - the file already exists
>   *   - we are in a sticky directory
> @@ -1416,6 +1416,14 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
>  	if (likely(!(dir_mode & S_ISVTX)))
>  		return 0;
>  
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
>  
> @@ -1447,6 +1455,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
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
>  
>  	return 0;
> @@ -4334,21 +4348,43 @@ static inline int open_to_namei_flags(int flag)
>  
>  static int may_o_create(struct mnt_idmap *idmap,
>  			const struct path *dir, struct dentry *dentry,
> -			umode_t mode)
> +			int open_flag, umode_t mode)
>  {
> -	int error = security_path_mknod(dir, dentry, mode, 0);
> +	struct inode *dir_inode = dir->dentry->d_inode;
> +	bool create_dir = O_IS_MKDIR(open_flag);
> +	int error;
> +
> +	WARN_ON_ONCE(create_dir && !(mode & S_IFDIR));
> +
> +	if (create_dir)
> +		error = security_path_mkdir(dir, dentry, mode);
> +	else
> +		error = security_path_mknod(dir, dentry, mode, 0);
>  	if (error)
>  		return error;
>  
>  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
>  		return -EOVERFLOW;
>  
> -	error = inode_permission(idmap, dir->dentry->d_inode,
> -				 MAY_WRITE | MAY_EXEC);
> +	error = inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
>  	if (error)
>  		return error;
>  
> -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> +	if (create_dir)
> +		error = security_inode_mkdir(dir_inode, dentry, mode);
> +	else
> +		error = security_inode_create(dir_inode, dentry, mode);
> +
> +	return error;
> +}
> +
> +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> +		const struct inode *dir, int open_flag, umode_t mode)
> +{
> +	if (O_IS_MKDIR(open_flag))
> +		return vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
> +	else
> +		return vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
>  }
>  
>  /**
> @@ -4384,8 +4420,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  
>  	file->__f_path.dentry = DENTRY_NOT_SET;
>  	file->__f_path.mnt = path->mnt;
> +
>  	error = dir_inode->i_op->atomic_open(dir_inode, dentry, file,
> -				       open_to_namei_flags(open_flag), mode);
> +					     open_to_namei_flags(open_flag), mode);
>  	d_lookup_done(dentry);
>  
>  	if (!error) {
> @@ -4427,12 +4464,32 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  			 */
>  			audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
>  			error = create_error;
> +		} else if (O_IS_MKDIR(open_flag) && error == -ENOENT) {
> +			/*
> +			 * If the underlying filesystem does not implement
> +			 * O_CREAT|O_DIRECTORY, it strips the O_CREAT bit and
> +			 * continues as a lookup. We can't simply return
> +			 * -EOPNOTSUPP from unsupported ->atomic_open()
> +			 * implementations because the dentry might be in the
> +			 * dcache. In that case, lookup_open() returns before
> +			 * reaching ->atomic_open(), and hence whether you get
> +			 * -EOPNOTSUPP on O_CREAT|O_DIRECTORY would not only
> +			 * depend on the underlying filesystem, but also on
> +			 * the state of the dcache. Still, we must make an
> +			 * effort to differentiate a regular -ENOENT from the
> +			 * unsupported O_CREAT|O_DIRECTORY case.
> +			 */
> +			error = -EOPNOTSUPP;
>  		}
>  		dput(dentry);
>  		dentry = ERR_PTR(error);
>  	} else {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir_inode, dentry);
> +		if (file->f_mode & FMODE_CREATED) {
> +			if (d_is_dir(dentry))
> +				fsnotify_mkdir(dir_inode, dentry);
> +			else
> +				fsnotify_create(dir_inode, dentry);
> +		}
>  		if (file->f_mode & FMODE_OPENED)
>  			fsnotify_open(file);
>  	}
> @@ -4441,6 +4498,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  	return dentry;
>  }
>  
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *, struct dentry *,
> +				 umode_t, struct delegated_inode *);
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -4462,6 +4522,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
>  	struct inode *dir_inode = dir->d_inode;
> +	bool create_dir = O_IS_MKDIR(op->open_flag);
>  	int open_flag;
>  	struct dentry *dentry;
>  	int error, create_error;
> @@ -4474,6 +4535,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	mode = op->mode;
>  	create_error = 0;
>  
> +	if (create_dir && dir_inode->i_op->atomic_open)
> +		open_flag &= ~O_CREAT;
> +
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>  		got_write = !mnt_want_write(nd->path.mnt);
>  		/*
> @@ -4534,10 +4598,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
> +		mode = o_create_mode(idmap, dir_inode, open_flag, mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(idmap, &nd->path,
> -						    dentry, mode);
> +						    dentry, open_flag, mode);
>  		else
>  			create_error = -EROFS;
>  	}
> @@ -4582,12 +4646,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		goto out_dput;
>  	}
>  
> -	if (!dir_inode->i_op->create) {
> +	/* mimic operation missing errnos of vfs_mkdir/vfs_create */
> +	if (create_dir && !dir_inode->i_op->mkdir) {
> +		error = -EPERM;
> +		goto out_dput;
> +	}
> +	if (!create_dir && !dir_inode->i_op->create) {
>  		error = -EACCES;
>  		goto out_dput;
>  	}
>  
> -	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);
> +	if (create_dir) {
> +		struct dentry *res = vfs_mkdir_no_perm(idmap, dir_inode, dentry, mode,
> +						       &delegated_inode);

So, I think this is broken. Whatever vfs_mkdir_no_perm() returns is
passed to do_open(). Kernfs makes that buggy.

cgroup, cgroup2, and resctrl are all implemented on top of kernfs. And
kernfs ->mkdir:: iop never instantiates the dentry.

So that means e.g.,

openat(cgroup_dir, "subdir", O_CREAT|O_DIRECTORY) creates a cgroup
and then fails with ENOTDIR.

So the negative dentry gets handed out and now userspace holds an fd
with that negative dentry. So say userspace does fchown() to 1000 and
then fchmod() with the sticky bit and then you get a NULL deref. I have
reproduced this.

Neil can correct me but the fix might be to check whether the dentry is
negative in lookup_open() and re-lookup nd->last with the parent still locked.
I think that's what nfsd_create_locked() and cachefiles_get_directory() do
after vfs_mkdir().

Here's the callchain:

  Common path: create the cgroup, come back with a negative dentry

  __x64_sys_openat
   do_sys_openat2                          fs/open.c
    build_open_flags                       O_IS_MKDIR(flags) -> op->mode = mode | S_IFDIR
                                           O_DIRECTORY -> lookup_flags |= LOOKUP_DIRECTORY
    do_file_open                           fs/namei.c
       lookup_fast_for_open                dcache miss -> NULL
       lookup_open
        mnt_want_write
        inode_lock_nested(dir, I_MUTEX_PARENT)
        d_lookup -> NULL
        d_alloc_parallel                   in-lookup dentry
        o_create_mode                      S_IFDIR | 0755 & ~umask
        may_o_create
         security_path_mkdir
         inode_permission(MAY_WRITE|MAY_EXEC)
          kernfs_iop_permission
           generic_permission              owner of a 0755 dir: allowed
         security_inode_mkdir
        dir_inode->i_op->lookup
         kernfs_iop_lookup
          kernfs_find_ns -> NULL           node does not exist yet
          d_splice_alias(NULL, dentry)     -> __d_add(): hashed, NEGATIVE
         try_break_deleg
         dir->i_op->mkdir
          kernfs_iop_mkdir
           scops->mkdir
            cgroup_mkdir                   no capable() check
             cgroup_create                 owner = current_fsuid()
             css_populate_dir
             kernfs_activate               cgroup now exists
           return ERR_PTR(0)               == NULL, dentry untouched
         de == NULL -> keep original dentry
         fsnotify_mkdir(dir, dentry)       fine with a negative dentry
        dentry = res                       still negative
        file->f_mode |= FMODE_CREATED
        inode_unlock(dir); mnt_drop_write
       FMODE_CREATED set ->
        dput(nd->path.dentry)
        nd->path.dentry = dentry           negative dentry becomes the "opened" path
        return NULL
      do_open
       open_flag & O_CREAT ->
        may_create_in_sticky(idmap, nd, d_backing_inode(nd->path.dentry))
                                           inode == NULL

  Scenario 1, parent not sticky: cgroup created, ENOTDIR returned

       may_create_in_sticky
        if (!(dir_mode & S_ISVTX)) return 0;     inode never touched
       (nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry)
                                           DCACHE_MISS_TYPE -> false
        return -ENOTDIR
      terminate_walk
      fput_close(file)
     return ERR_PTR(-ENOTDIR)              "child" cgroup stays behind

  A second openat of the same name works because kernfs_dop_revalidate() sees the parent's revision changed, d_invalidate()s the stale negative dentry, and the fresh kernfs_iop_lookup() now
  finds the node.

  Scenario 2, sticky parent: NULL dereference

  Setup, one-time, as root (what systemd's Delegate=yes does for user.slice/user-1000.slice/user@1000.service):

  fchown(pfd, 1000, 1000)
   chown_common -> notify_change -> kernfs_iop_setattr -> __kernfs_setattr

  Then as uid 1000:

  fchmod(pfd, 01755)
   chmod_common
    newattrs.ia_mode = (mode & S_IALLUGO) | ...   S_ISVTX is inside S_IALLUGO
    notify_change
     setattr_prepare
      inode_owner_or_capable                    owner -> ok
     kernfs_iop_setattr
      __kernfs_setattr                          kn->mode = ia_mode, no masking
      setattr_copy                              inode->i_mode = 01755

  and the open, same chain as above until may_create_in_sticky(), now with nd->dir_mode = 01755:

       may_create_in_sticky
        if (!(dir_mode & S_ISVTX)) return 0;     not taken
        if (S_ISREG(inode->i_mode) && ...)       inode == NULL
                                                 -> KASAN null-ptr-deref
