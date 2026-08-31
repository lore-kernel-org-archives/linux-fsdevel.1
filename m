Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2543C09EA;
	Mon, 31 Aug 2026 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168902; cv=none; b=WSwDhHz9bgLAG63s4dMcDessNiWsRexjiS8iUE3xDCAMND2GD1Jb7dJgQlU+ENALC8MGeVay1tHzC6NIyDPp8JOO7jT1QSCyt7ctpd3RsMuuDwwoysx6EDgFGGoMbV48W4sSftyLQOADxZxziD6a3M8nuTJyvLV0Ro2/mCIuMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168902; c=relaxed/simple;
	bh=v15i4BJVeuokx2xBRVvJPa7idXbNVThu7dQ864ZRNio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZkwF5eJzIUNm22iPqfWXrbpATN/4YTpGwoRscjNSqII+8FN85+vT/PRMUmwAdeKyHVCRqzPffMBErnNE4jQD1otfIrOBzQCjIpxm/I0sWkZs7gJs45vtSwmbLtBq44StHBryI2+N0eF8qGPm3i5APj4K5I8IAaQb1bW6n5aeUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fqiAvpGa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fqiAvpGa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2941F00A3E;
	Mon, 31 Aug 2026 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168896;
	bh=gmkjvOiWcnG0ZcpiTHaacwKrEu+TlTIMfW1i5S0FVK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fqiAvpGaEc/UQj1A4Z7V5wo2SHY3Md9QTIpAKGcL7kyn9j/tD4XOoLDgdlSXLbVZ8
	 JVUL13UYTBfkmlEVCBUuF7/LFJiIXyz3mqvkSxIvJRLePHTjw2kW203gjXq/va6Jzh
	 GS1S2s1/A23CZeFiU1UKZyaoK9xQx2kQTyVX7qTgbU8fu6RHQdlok9dpfe7IwLblEM
	 rtaB8dTo7DNqjI4o5336pBzR10Fj0JM7fu4KmNCS6j+zi6t0BDUon17s3HYxsbPCoL
	 Wg/iomY645SVZeTgULLywr64iEycUZplX5zgD8Wmk4pfpXw0GHcIqwdAIS3nUGRNZv
	 g/b0FQzGkw19w==
Date: Mon, 31 Aug 2026 11:34:52 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 06/10] vfs: add O_CREAT|O_DIRECTORY to open*(2)
Message-ID: <20260831-zutreffen-umgeladen-wahrt-abfce6317a86@brauner>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
 <20260823160706.358293-7-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823160706.358293-7-jkoolstra@xs4all.nl>

On Sun, Aug 23, 2026 at 06:07:02PM +0200, Jori Koolstra wrote:
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
> This behaviour changed accidentally with 973d4b73fbaf ("do_last(): rejoin
> the common path even earlier in FMODE_{OPENED,CREATED} case") causing
> ENOTDIR to return in the last case while still creating the file. As
> this change was not detected for a long time, Brauner proposed to adopt
> the more consistent NetBSD behaviour, i.e. to return EINVAL on the
> O_CREAT|O_DIRECTORY combination. This change was applied in 43b450632676
> ("open: return EINVAL for O_DIRECTORY | O_CREAT") in March, 2023. As
> the EINVAL behaviour has been in the kernel for about 3 years now, no
> rollback is expected as a result of userspace reliance on old
> behaviour, leaving us free to reassign the O_CREAT|O_DIRECTORY semantics.
> 
> O_CREAT|O_DIRECTORY is made to reduce to a lookup on ->atomic_open()
> filesystems. These filesystems currenly cannot handle
> O_CREAT|O_DIRECTORY without protocol extensions and therefore are forced
> into a fallback mode by stripping the O_CREAT bit. This causes existing
> directories to be succesfully opened, while for targets that should have
> been created, -ENOENT is returned. The other option of simply returning
> -EINVAL leads to inconsistent behaviour: before ->atomic_open() is
> called in lookup_open(), the dcache is queried. So returning -EINVAL
> there would make O_CREAT|O_DIRECTORY dependent on the cache state of the
> dentry.
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
>  fs/namei.c            | 89 ++++++++++++++++++++++++++++++++++---------
>  fs/open.c             | 25 ++++++------
>  include/linux/fcntl.h |  6 +++
>  3 files changed, 92 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 3afae6e87825..6f18a480665b 100644
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
> @@ -4334,21 +4348,41 @@ static inline int open_to_namei_flags(int flag)
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
> @@ -4384,8 +4418,9 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
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
> @@ -4441,6 +4476,10 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  	return dentry;
>  }
>  
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *, struct inode *,
> +				 struct dentry *, umode_t,
> +				 struct delegated_inode *);
>  /*
>   * Look up and maybe create and open the last component.
>   *
> @@ -4462,6 +4501,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
>  	struct inode *dir_inode = dir->d_inode;
> +	bool create_dir = O_IS_MKDIR(op->mode);

So this is called on op->mode which is 16-bit an O_DIRECTORY is bit 16.
Hence, "create_dir" is always false. I think you wanted to test
op->open_flag...
