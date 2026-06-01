Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5105367B9D
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Jun 2026 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780347156; cv=none; b=qeqED62wSecgGyw24UxwkUQoC5GNkPE+NaaUY9hnD0VuIx4DrSCg+M+zh9vL6qnCRRjSE9gS7IYxACOeZ/OB5HT6J6EmC4Qqx3FljgRHO6Ppd3y+TP+vwLxhKNDcaSl9Amq1Q1/nR0zLpmen1r9CEXH8DlBgCWTlf6HOhSSolPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780347156; c=relaxed/simple;
	bh=mQR9RPJRLh2hShOY1VNHGLwh/qXRc8x+svoCS27o5Wg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Iu/2fQQiWPizkWtyvL7T7JjC+2qntm/yxWK1mVhofgbq2jYajQnefvE0aB9gm0R3THQ6aqrjGqodayjB4LFK7IXO2tvs64VdML4/vkLPK96QuyOjGwgUfXOn8HuN4PgDwNSASGHq7EcfJmsEjvt8pcYQ0c0yLHMCOwyxm1y+h+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=dfS9rAOG; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="dfS9rAOG"
X-KPN-MessageId: cae02e29-5dfb-11f1-89f2-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.189])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id cae02e29-5dfb-11f1-89f2-00505699b430;
	Mon, 01 Jun 2026 22:52:24 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id cae42ac1-5dfb-11f1-b5d4-0050569981f5;
	Mon, 01 Jun 2026 22:52:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=wuNWoPfTWGPA52t1nQBdbdtxc2MsetytObsc7fo3ZhM=;
	b=dfS9rAOGExmL7ic8ScxjTYRNT3U0+BKfDlctJheMtq1Fr62q+60GwEDvUeRZoWqnqDjKYLR9O/VJr
	 j11vmgq3e16KnMgTHDAiTXMmxXZfrIy/pBmKtKz2oWyslK12RndiQnUW4WLmfVCrrbMRFCrBST2e86
	 azc4nI0rSHanBzz2qSG0Xv0ewiUGn3IRKWEqtbf5BlxKROem/Wlp9u1ZQTcPANfNuuM+zxRcykZXEr
	 TTpLALCRlrFxBcV+fuqEO8v6xB4f0CGLa0RJBKCgd+W2ZDBpHo0AH5xqyz1uzRhYr8HAZbTZotykEA
	 RTlERkCFxul3LUNpa1wQeuUdm3ZDkmQ==
X-KPN-MID: 33|Rw2/Ur9brbfLZqaQtNRIzKoq1lfBIQ4c09s6AaXO+nMMMTpfiRslTcv301gx8O+
 BIoN4tf6AWSDbe5UwTV614zKkNsS2sByUw4afJLnItAo=
X-CMASSUN: 33|gufkI7E9yQiHpIFUNEfZES1McKcEviZiDhFjJVSuFs0Lr4EBguj0/LVEWqgmdsZ
 9hpnf0d9u8YlIsX0d6wMq0g==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh02 (cpxoxapps-mh02.personalcloud.so.kpn.org [10.128.135.208])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id cad33888-5dfb-11f1-94b1-00505699eff2;
	Mon, 01 Jun 2026 22:52:24 +0200 (CEST)
Date: Mon, 1 Jun 2026 22:52:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Aleksa Sarai <cyphar@cyphar.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, cmirabil@redhat.com
Message-ID: <653344520.138270.1780347144618@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
References: <20260525202937.466497-1-jkoolstra@xs4all.nl>
 <20260525202937.466497-2-jkoolstra@xs4all.nl>
 <177986687451.3379282.8177801680240137022@noble.neil.brown.name>
 <20260527-fotowettbewerb-abwinken-einfach-83db3411945b@brauner>
Subject: Re: [RFC PATCH v5 1/2] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 27-05-2026 13:43 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
> I agree, let's not do booleans if we can avoid them. But fwiw, some
> userspace projects require naked booleans to come with a comment like:
> 
> may_o_create(..., /* create_dir */ true)
> 
> Which makes this easier to handle. But conventions like this are
> difficult to enforce - especially in the kernel.
> 
> Years ago I added vfs_prepare_mode() which should handle all that
> uniformly. Back then I didn't pass S_IFDIR and wrote:
> 
>  * Note that it's currently valid for @type to be 0 if a directory is created.
>  * Filesystems raise that flag individually and we need to check whether each
>  * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
>  * non-zero type.

Yeah, I think this confused me. Now that I look at it again we can just get
rid of that bool flag in may_o_create() since we just prepared the mode with
vfs_prepare_mode(). It would be nice to also remove it from o_create_mode(),
but off the top of my head, nothing is stopping you from passing a mode type
to open(2) that has more than one bit set (e.g. both S_IFDIR and S_IFREG), and
this is precisely what vfs_prepare_mode() is for to fix.

I was planning to get rid off this comment and enforce S_IFDIR, but I think
that should be separate from this patchset. Agree?

> 
> I kinda sense that I might've been overly cautious here. Some AI tooling
> should be able to quickly figure out whether passing S_IFDIR is fine. In
> which case this just becomes:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..b4d136f43ee4 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -5245,7 +5245,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>         if (!dir->i_op->mkdir)
>                 goto err;
> 
> -       mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> +       mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
>         error = security_inode_mkdir(dir, dentry, mode);
>         if (error)
>                 goto err;
> 
> and then match on S_IFMT in may_o_create() etc.
> 
> > 
> > >  {
> > > -	int error = security_path_mknod(dir, dentry, mode, 0);
> > > +	struct inode *dir_inode = dir->dentry->d_inode;
> > > +	int error;
> > > +
> > > +	error = create_dir ? security_path_mkdir(dir, dentry, mode)
> > > +			   e: security_path_mknod(dir, dentry, mode, 0);
> > >  	if (error)
> > >  		return error;
> > >  
> > >  	if (!fsuidgid_has_mapping(dir->dentry->d_sb, idmap))
> > >  		return -EOVERFLOW;
> > >  
> > > -	error = inode_permission(idmap, dir->dentry->d_inode,
> > > -				 MAY_WRITE | MAY_EXEC);
> > > +	error = inode_permission(idmap, dir_inode, MAY_WRITE | MAY_EXEC);
> > >  	if (error)
> > >  		return error;
> > >  
> > > -	return security_inode_create(dir->dentry->d_inode, dentry, mode);
> > > +	return create_dir ? security_inode_mkdir(dir_inode, dentry, mode)
> > > +			  : security_inode_create(dir_inode, dentry, mode);
> 
> Please, no ?: for stuff like this.
> 
> > > +}
> > > +
> > > +static inline umode_t o_create_mode(struct mnt_idmap *idmap,
> > > +		const struct inode *dir, umode_t mode, bool create_dir)
> > > +{
> > > +	return create_dir ? vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0)
> > > +			  : vfs_prepare_mode(idmap, dir, mode, S_IALLUGO, S_IFREG);
> > 
> > It isn't clear the purpose of this.
> 
> Also, let's please refrain from using ?: I really dislike it. LLMs love
> to use it.
> 
> > In the create_dir case, shouldn't we pass S_IFDIR as the last arg: type?
> > 
> > The difference between "S_IRWXUGO | S_ISVTX" and "S_IALLUGO" is not
> > immediately obvious, but the former excludes S_ISUID and S_ISGID.
> > The setuid bit is meaningless on directories so there is little point in
> > stripping it, but I don't object as long as the intent is documented
> > here.
> > The setgid bit is meaningful but vfs_prepare_mode() seems to already
> > handle it correctly for directories if you pass the type as S_IFDIR.
> > If you have a good reason to impose different handling here, that might
> > be sensible, but it should be documented.
> > 
> > >  }
> > >  
> > >  /*
> > > @@ -4388,6 +4412,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
> > >  	return dentry;
> > >  }
> > >  
> > > +static struct dentry *__vfs_mkdir(struct mnt_idmap *, struct inode *,
> > > +			 struct dentry *, umode_t,
> > > +			 struct delegated_inode *);
> > >  /*
> > >   * Look up and maybe create and open the last component.
> > >   *
> > > @@ -4412,8 +4439,9 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >  	struct inode *dir_inode = dir->d_inode;
> > >  	int open_flag = op->open_flag;
> > >  	struct dentry *dentry;
> > > -	int error, create_error = 0;
> > > +	int error = 0, create_error = 0;
> > >  	umode_t mode = op->mode;
> > > +	bool create_dir = (open_flag & O_MKDIR_MASK) == O_MKDIR_MASK;
> > >  	DECLARE_WAIT_QUEUE_HEAD_ONSTACK(wq);
> > >  
> > >  	if (unlikely(IS_DEADDIR(dir_inode)))
> > > @@ -4462,10 +4490,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >  	if (open_flag & O_CREAT) {
> > >  		if (open_flag & O_EXCL)
> > >  			open_flag &= ~O_TRUNC;
> > > -		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
> > > +		mode = o_create_mode(idmap, dir_inode, mode, create_dir);
> > >  		if (likely(got_write))
> > >  			create_error = may_o_create(idmap, &nd->path,
> > > -						    dentry, mode);
> > > +						    dentry, mode, create_dir);
> > >  		else
> > >  			create_error = -EROFS;
> > >  	}
> > > @@ -4494,29 +4522,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >  		}
> > >  	}
> > >  
> > > +	if (unlikely(create_error) && !dentry->d_inode) {
> > > +		error = create_error;
> > > +		goto out_dput;
> > > +	}
> > > +
> > >  	/* Negative dentry, just create the file */
> > >  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
> > > -		/* but break the directory lease first! */
> > > -		error = try_break_deleg(dir_inode, delegated_inode);
> > > -		if (error)
> > > -			goto out_dput;
> > >  
> > >  		file->f_mode |= FMODE_CREATED;
> > >  		audit_inode_child(dir_inode, dentry, AUDIT_TYPE_CHILD_CREATE);
> > > -		if (!dir_inode->i_op->create) {
> > > -			error = -EACCES;
> > > +		if ((create_dir && !dir_inode->i_op->mkdir)
> > > +		    || (!create_dir && !dir_inode->i_op->create)) {
> > > +			error = -EOPNOTSUPP;
> > >  			goto out_dput;
> > >  		}
> > >  
> > > -		error = dir_inode->i_op->create(idmap, dir_inode, dentry,
> > > -						mode, open_flag & O_EXCL);
> > > +		if (create_dir) {
> > > +			struct dentry *res = __vfs_mkdir(idmap, dir_inode, dentry, mode,
> > > +							 delegated_inode);
> > > +			if (IS_ERR(res))
> > > +				error = PTR_ERR(res);
> > > +			else
> > > +				dentry = res;
> > > +		} else {
> > > +			error = __vfs_create(idmap, dentry, mode, delegated_inode,
> > > +					     open_flag & O_EXCL);
> > > +		}
> > >  		if (error)
> > >  			goto out_dput;
> > >  	}
> > > -	if (unlikely(create_error) && !dentry->d_inode) {
> > > -		error = create_error;
> > > -		goto out_dput;
> > > -	}
> > > +
> > >  	return dentry;
> > >  
> > >  out_dput:
> > > @@ -4524,17 +4560,12 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> > >  	return ERR_PTR(error);
> > >  }
> > >  
> > > -static inline bool trailing_slashes(struct nameidata *nd)
> > > -{
> > > -	return (bool)nd->last.name[nd->last.len];
> > > -}
> > > -
> > >  static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
> > >  {
> > >  	struct dentry *dentry;
> > >  
> > >  	if (open_flag & O_CREAT) {
> > > -		if (trailing_slashes(nd))
> > > +		if (trailing_slashes(nd) && !(open_flag & O_DIRECTORY))
> > >  			return ERR_PTR(-EISDIR);
> > >  
> > >  		/* Don't bother on an O_EXCL create */
> > > @@ -4605,13 +4636,17 @@ static const char *open_last_lookups(struct nameidata *nd,
> > >  		 */
> > >  	}
> > >  	if (open_flag & O_CREAT)
> > > -		inode_lock(dir->d_inode);
> > > +		inode_lock_nested(dir->d_inode, I_MUTEX_PARENT);
> > >  	else
> > >  		inode_lock_shared(dir->d_inode);
> > >  	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
> > >  	if (!IS_ERR(dentry)) {
> > > -		if (file->f_mode & FMODE_CREATED)
> > > -			fsnotify_create(dir->d_inode, dentry);
> > > +		if (file->f_mode & FMODE_CREATED) {
> > > +			if (open_flag & O_DIRECTORY)
> > > +				fsnotify_mkdir(dir->d_inode, dentry);
> > > +			else
> > > +				fsnotify_create(dir->d_inode, dentry);
> > > +		}
> > >  		if (file->f_mode & FMODE_OPENED)
> > >  			fsnotify_open(file);
> > >  	}
> > > @@ -4672,12 +4707,16 @@ static int do_open(struct nameidata *nd,
> > >  	if (open_flag & O_CREAT) {
> > >  		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
> > >  			return -EEXIST;
> > > -		if (d_is_dir(nd->path.dentry))
> > > -			return -EISDIR;
> > > -		error = may_create_in_sticky(idmap, nd,
> > > -					     d_backing_inode(nd->path.dentry));
> > > -		if (unlikely(error))
> > > -			return error;
> > > +		// there are no special rules for creating dirs in a sticky bit dir
> > 
> > Maybe there *should* be special rules for creating dirs.
> > I don't know the details of the exploits that these rules protect
> > against, but if we add O_CREAT|O_DIRECTORY and people start using
> > it, and they don't do appropriate validation in sticky
> > directories (and the whole point here is to avoid the need
> > for validation) then maybe similar sorts of bugs and exploits
> > could appear.
> > 
> > I would recommend that O_CREAT|O_DIRECTORY must never successfully open
> > a directory with different ownership in a sticky directory.  There is no
> > need for a sysctl, because there is no legacy behaviour to protect.
> 
> I think it should still be scoped under the sysctl for consistency. It's
> equally annoying if the behavior subtly differs for userspace. So just
> something like:
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index c7fac83c9a85..1f3bca9c7246 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -1442,6 +1442,12 @@ static int may_create_in_sticky(struct mnt_idmap *idmap, struct nameidata *nd,
>                                               "sticky_create_regular");
>                         return -EACCES;
>                 }
> +
> +               if (sysctl_protected_regular >= 2 && S_IFDIR(inode->i_mode)) {
> +                       audit_log_path_denied(AUDIT_ANOM_CREAT,
> +                                             "sticky_create_dir");
> +                       return -EACCES;
> +               }
>         }
> 
>         return 0;
> 
> > Q: is O_EXCL supported with O_CREAT|O_DIRECTORY? I didn't notice
> > and special handling, but I could easily have missed it.
> 
> If possible, it should.
> 

This works out of the box, the enforcement is implemented in do_open() as

	if (open_flag & O_CREAT) {
		if ((open_flag & O_EXCL) && !(file->f_mode & FMODE_CREATED))
			return -EEXIST;
        ...
        }

and nothing special has to be done to make this work for directories.

> > 
> > 
> > > +		if (!(open_flag & O_DIRECTORY)) {
> > > +			if (d_is_dir(nd->path.dentry))
> > > +				return -EISDIR;
> > > +
> > > +			error = may_create_in_sticky(idmap, nd,
> > > +						     d_backing_inode(nd->path.dentry));
> > > +			if (unlikely(error))
> > > +				return error;
> > > +		}
> > >  	}
> > >  	if ((nd->flags & LOOKUP_DIRECTORY) && !d_can_lookup(nd->path.dentry))
> > >  		return -ENOTDIR;
> > > @@ -5039,7 +5078,7 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
> > >  		path->dentry = dir;
> > >  		mode = vfs_prepare_mode(idmap, dir_inode, mode, S_IALLUGO, S_IFREG);
> > >  
> > > -		create_error = may_o_create(idmap, path, dentry, mode);
> > > +		create_error = may_o_create(idmap, path, dentry, mode, false);
> > >  		if (create_error)
> > >  			flags &= ~O_CREAT;
> > >  
> > > @@ -5207,6 +5246,37 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
> > >  	return filename_mknodat(AT_FDCWD, name, mode, dev);
> > >  }
> > >  
> > > +static struct dentry *__vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > > +			 struct dentry *dentry, umode_t mode,
> > > +			 struct delegated_inode *di)
> > > +{
> > > +	int error;
> > > +	unsigned max_links = dir->i_sb->s_max_links;
> > > +	struct dentry *de;
> > > +
> > > +	error = -EMLINK;
> > > +	if (max_links && dir->i_nlink >= max_links)
> > > +		goto err;
> > > +
> > > +	error = try_break_deleg(dir, di);
> > > +	if (error)
> > > +		goto err;
> > > +
> > > +	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
> > > +	if (IS_ERR(de)) {
> > > +		error = PTR_ERR(de);
> > > +		goto err;
> > > +	}
> > > +	if (de) {
> > > +		dput(dentry);
> > > +		dentry = de;
> > > +	}
> > > +	return dentry;
> > > +
> > > +err:
> > > +	return ERR_PTR(error);
> > > +}
> > > +
> > >  /**
> > >   * vfs_mkdir - create directory returning correct dentry if possible
> > >   * @idmap:		idmap of the mount the inode was found from
> > > @@ -5231,17 +5301,16 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
> > >   */
> > >  struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > >  			 struct dentry *dentry, umode_t mode,
> > > -			 struct delegated_inode *delegated_inode)
> > > +			 struct delegated_inode *di)
> > >  {
> > >  	int error;
> > > -	unsigned max_links = dir->i_sb->s_max_links;
> > >  	struct dentry *de;
> > >  
> > >  	error = may_create_dentry(idmap, dir, dentry);
> > >  	if (error)
> > >  		goto err;
> > >  
> > > -	error = -EPERM;
> > > +	error = -EOPNOTSUPP;
> > >  	if (!dir->i_op->mkdir)
> > >  		goto err;
> > >  
> > > @@ -5250,22 +5319,12 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
> > >  	if (error)
> > >  		goto err;
> > >  
> > > -	error = -EMLINK;
> > > -	if (max_links && dir->i_nlink >= max_links)
> > > -		goto err;
> > > -
> > > -	error = try_break_deleg(dir, delegated_inode);
> > > -	if (error)
> > > -		goto err;
> > > -
> > > -	de = dir->i_op->mkdir(idmap, dir, dentry, mode);
> > > -	error = PTR_ERR(de);
> > > -	if (IS_ERR(de))
> > > +	de = __vfs_mkdir(idmap, dir, dentry, mode, di);
> > > +	if (IS_ERR(de)) {
> > > +		error = PTR_ERR(de);
> > >  		goto err;
> > > -	if (de) {
> > > -		dput(dentry);
> > > -		dentry = de;
> > >  	}
> > > +	dentry = de;
> > >  	fsnotify_mkdir(dir, dentry);
> > >  	return dentry;
> > >  
> > > diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
> > > index e9ce1883288c..e44c7598b68e 100644
> > > --- a/fs/nfs/dir.c
> > > +++ b/fs/nfs/dir.c
> > > @@ -2314,6 +2314,9 @@ int nfs_atomic_open_v23(struct inode *dir, struct dentry *dentry,
> > >  	if (dentry->d_name.len > NFS_SERVER(dir)->namelen)
> > >  		return -ENAMETOOLONG;
> > >  
> > > +	if ((open_flags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	if (open_flags & O_CREAT) {
> > >  		error = nfs_do_create(dir, dentry, mode, open_flags);
> > >  		if (!error) {
> > > diff --git a/fs/nfs/file.c b/fs/nfs/file.c
> > > index 25048a3c2364..467f6bc707da 100644
> > > --- a/fs/nfs/file.c
> > > +++ b/fs/nfs/file.c
> > > @@ -52,6 +52,9 @@ int nfs_check_flags(int flags)
> > >  	if ((flags & (O_APPEND | O_DIRECT)) == (O_APPEND | O_DIRECT))
> > >  		return -EINVAL;
> > >  
> > > +	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL_GPL(nfs_check_flags);
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 681d405bc61e..865ea6f70e8c 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -1209,29 +1209,30 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > >  	if (WILL_CREATE(flags)) {
> > >  		if (how->mode & ~S_IALLUGO)
> > >  			return -EINVAL;
> > > -		op->mode = how->mode | S_IFREG;
> > > +		if ((flags & (O_MKDIR_MASK)) == O_MKDIR_MASK)
> > > +			op->mode = how->mode | S_IFDIR;
> > > +		else
> > > +			op->mode = how->mode | S_IFREG;
> > >  	} else {
> > >  		if (how->mode != 0)
> > >  			return -EINVAL;
> > >  		op->mode = 0;
> > >  	}
> > >  
> > > -	/*
> > > -	 * Block bugs where O_DIRECTORY | O_CREAT created regular files.
> > > -	 * Note, that blocking O_DIRECTORY | O_CREAT here also protects
> > > -	 * O_TMPFILE below which requires O_DIRECTORY being raised.
> > > -	 */
> > > -	if ((flags & (O_DIRECTORY | O_CREAT)) == (O_DIRECTORY | O_CREAT))
> > > -		return -EINVAL;
> > > -
> > >  	/* Now handle the creative implementation of O_TMPFILE. */
> > >  	if (flags & __O_TMPFILE) {
> > >  		/*
> > >  		 * In order to ensure programs get explicit errors when trying
> > >  		 * to use O_TMPFILE on old kernels we enforce that O_DIRECTORY
> > > -		 * is raised alongside __O_TMPFILE.
> > > +		 * is raised alongside __O_TMPFILE, but without O_CREAT. The
> > > +		 * reason for disallowing O_CREAT|O_TMPFILE is that
> > > +		 * O_DIRECTORY|O_CREAT used to work and created a regular file
> > > +		 * if nothing existed at the open path. Hence, allowing the
> > > +		 * combination would have caused O_CREAT|O_TMPFILE to create a
> > > +		 * regular (non-temporary) file on old kernels, while the caller
> > > +		 * would believe they created an actual O_TMPFILE.
> > >  		 */
> > > -		if (!(flags & O_DIRECTORY))
> > > +		if (!(flags & O_DIRECTORY) || (flags & O_CREAT))
> > >  			return -EINVAL;
> > >  		if (!(acc_mode & MAY_WRITE))
> > >  			return -EINVAL;
> > > @@ -1268,6 +1269,8 @@ inline int build_open_flags(const struct open_how *how, struct open_flags *op)
> > >  	op->intent = flags & O_PATH ? 0 : LOOKUP_OPEN;
> > >  
> > >  	if (flags & O_CREAT) {
> > > +		if ((flags & O_DIRECTORY) && (acc_mode & MAY_WRITE))
> > > +			return -EISDIR;
> > 
> > It seems odd that the MAY_WRITE test is only performed for O_CREAT.
> > Shouldn't any open of O_DIRECTORY|O_WRONLY fail, and shouldn't the one
> > test catch both create and non-create cases?
> > 
> > 
> > >  		op->intent |= LOOKUP_CREATE;
> > >  		if (flags & O_EXCL) {
> > >  			op->intent |= LOOKUP_EXCL;
> > > diff --git a/fs/smb/client/dir.c b/fs/smb/client/dir.c
> > > index e4295a5b55b3..ec8c54c91261 100644
> > > --- a/fs/smb/client/dir.c
> > > +++ b/fs/smb/client/dir.c
> > > @@ -526,6 +526,9 @@ int cifs_atomic_open(struct inode *dir, struct dentry *direntry,
> > >  	if (unlikely(cifs_forced_shutdown(cifs_sb)))
> > >  		return smb_EIO(smb_eio_trace_forced_shutdown);
> > >  
> > > +	if ((oflags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	/*
> > >  	 * Posix open is only called (at lookup time) for file create now. For
> > >  	 * opens (rather than creates), because we do not know if it is a file
> > > diff --git a/fs/vboxsf/dir.c b/fs/vboxsf/dir.c
> > > index 42bedc4ec7af..aef5ca6730be 100644
> > > --- a/fs/vboxsf/dir.c
> > > +++ b/fs/vboxsf/dir.c
> > > @@ -318,6 +318,9 @@ static int vboxsf_dir_atomic_open(struct inode *parent, struct dentry *dentry,
> > >  	u64 handle;
> > >  	int err;
> > >  
> > > +	if ((flags & O_MKDIR_MASK) == O_MKDIR_MASK)
> > > +		return -EINVAL;
> > > +
> > >  	if (d_in_lookup(dentry)) {
> > >  		struct dentry *res = vboxsf_dir_lookup(parent, dentry, 0);
> > >  		if (res || d_really_is_positive(dentry))
> > > diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
> > > index a332e79b3207..e31f3a57f07c 100644
> > > --- a/include/linux/fcntl.h
> > > +++ b/include/linux/fcntl.h
> > > @@ -12,6 +12,8 @@
> > >  	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
> > >  	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
> > >  
> > > +#define O_MKDIR_MASK	(O_CREAT | O_DIRECTORY)
> > > +
> > >  /* List of all valid flags for the how->resolve argument: */
> > >  #define VALID_RESOLVE_FLAGS \
> > >  	(RESOLVE_NO_XDEV | RESOLVE_NO_MAGICLINKS | RESOLVE_NO_SYMLINKS | \
> > > -- 
> > > 2.54.0
> > > 
> > > 
> > > 
> > 
> > Thanks,
> > NeilBrown


Best,
Jori.
