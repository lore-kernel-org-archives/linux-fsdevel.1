Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B5B3F4138;
	Tue,  7 Jul 2026 10:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421498; cv=none; b=lmG5jI4z/yACghLtVKF7CwsDNcfc2VoHbGSPjfNGQXZpvNNlG+YGH9mzuu6yd011m41uCmVmRdnvfrMMaxQsjbuaf8T/hS9mQjMuVKT/keI9/W1dSU4fT+jxDVnYcN/hloB2ZlUatYVDzcTKExvqc0VoaMCpJfTFdB+EkLRfGnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421498; c=relaxed/simple;
	bh=iwOYs/1kUTvzUtdIXBhaetzpw78KNl7osL03caZ4GvU=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=IWZ+NvdrWoAKu3eGUtQa1HwigFYI9+xVkBdAcQvOPNBlsbKjV9o2nzphJThe1Vve+nm9VZQ4v9wr+eQ2cpoMhTwIn8f3NVlT83Hfsqvxdy8feyCefsaxPfdyjSe/xtMzhl1MjAihqDTYHBcdv9AHUfE6Fh8TZtwYscKvPWOsw1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V4xG0hec; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V4xG0hec"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E78A1F000E9;
	Tue,  7 Jul 2026 10:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421496;
	bh=7XgMpB//gqAOJzhu7Zd6JL9NpEtKWAqJR8tsmpXPLyY=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=V4xG0hecey6mf4bIGP6dghiuN3VLw1i5eo/8T77/y0ZK0188HZKW+BcDCSrgPsIre
	 0dTgAvdar4CfG0BrSmRKZ8XXgDtH5BupsMhJ6X1CH7n9fZ9+cI8jNtOkbqPKmZDHqh
	 viv6y53Jf7aRSdDu/8CuhXSN9gdzp48cqWGXsT96Rb73HZeO4ZC+SRpAcyytDJwjNp
	 3/CUDGo0vwNR5mJyVVciv93ytb+edw4029MVS4xDNrh7/mKoB1ffGOZqHciy5V7jHH
	 YoYLX/Dx9NHWX1b+RD27u9l4KuLs2839cT0YZgDId4BX5Qpjm7p81rzEmTTBa6271O
	 M61oMbfqRzfqw==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 03/14] vfs: prepare vfs_creat|mkdir_no_perm for
 reuse in lookup_open()
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-4-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-4-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-dermatologisch-umfassen-bootshaus-86b645ff14cc@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4555; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iwOYs/1kUTvzUtdIXBhaetzpw78KNl7osL03caZ4GvU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DJ4+jviiZFdhdPh1z0/fL7HzROfrL92R65E98HzR
 48dEZVZ1lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNQaMDEvUH1Qu2HG65QKD
 S5dW8YFEm7zAmt3Nm+LSprt1/d+YcJuR4fsVH+3flqcWSb1me3uSQ/X8g7VvXdpv1r+IZFnm0/S
 0nx8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> To implement O_CREAT|O_DIRECTORY we will have to repeat some of the
> logic that is now in vfs_mkdir() (e.g. do error checks in the same
> order). Separate this out in vfs_mkdir_no_perm(), which does all the
> non-permission related work of vfs_mkdir(). Permission checking for the
> lookup_open() path is timed differently because we may just be doing an
> open and no create. Similar considerations give rise to
> vfs_create_no_perm().
> 
> Moving the fsnotify_* calls also allows us to deal with this in one
> place for each type of operation. This does mean that we also need
> to move the fsnotify_* calls into atomic_open() for the atomic open
> case, but this actually reduces duplicate code in open_last_lookups()
> and dentry_create().
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index 40f83a942e12..ee47d3f5159f 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4169,6 +4169,24 @@ static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
>  	return mode;
>  }
>  
> +static inline
> +int vfs_create_no_perm(struct mnt_idmap *idmap, struct dentry *dentry,
> +		       umode_t mode, struct delegated_inode *di)
> +{
> +	struct inode *dir = d_inode(dentry->d_parent);
> +	int error;
> +
> +	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
> +	if (error)
> +		return error;
> +
> +	error = dir->i_op->create(idmap, dir, dentry, mode, true);
> +	if (!error)
> +		fsnotify_create(dir, dentry);
> +
> +	return error;
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @idmap:	idmap of the mount the inode was found from
> @@ -4201,13 +4219,8 @@ int vfs_create(struct mnt_idmap *idmap, struct dentry *dentry, umode_t mode,
>  	error = security_inode_create(dir, dentry, mode);
>  	if (error)
>  		return error;
> -	error = try_break_deleg(dir, LEASE_BREAK_DIR_CREATE, di);
> -	if (error)
> -		return error;
> -	error = dir->i_op->create(idmap, dir, dentry, mode, true);
> -	if (!error)
> -		fsnotify_create(dir, dentry);
> -	return error;
> +
> +	return vfs_create_no_perm(idmap, dentry, mode, di);
>  }
>  EXPORT_SYMBOL(vfs_create);
>  
> @@ -4384,10 +4397,17 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  				error = -ENOENT;
>  		}
>  	}
> +
>  	if (error) {
>  		dput(dentry);
>  		dentry = ERR_PTR(error);
> +	} else {
> +		if (file->f_mode & FMODE_CREATED)
> +			fsnotify_create(dir, dentry);
> +		if (file->f_mode & FMODE_OPENED)
> +			fsnotify_open(file);
>  	}
> +
>  	return dentry;
>  }
>  
> @@ -4519,6 +4539,8 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  						mode, open_flag & O_EXCL);
>  		if (error)
>  			goto out_dput;
> +
> +		fsnotify_create(dir_inode, dentry);
>  	}
>  
>  	return dentry;
> @@ -4607,13 +4629,9 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		inode_lock(dir->d_inode);
>  	else
>  		inode_lock_shared(dir->d_inode);
> +
>  	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
> -	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir->d_inode, dentry);
> -		if (file->f_mode & FMODE_OPENED)
> -			fsnotify_open(file);
> -	}
> +
>  	if (open_flag & O_CREAT)
>  		inode_unlock(dir->d_inode);
>  	else
> @@ -5066,13 +5084,6 @@ struct file *dentry_create(struct path *path, int flags, umode_t mode,
>  		if (unlikely(create_error) && error == -ENOENT)
>  			error = create_error;
>  
> -		if (!error) {
> -			if (file->f_mode & FMODE_CREATED)
> -				fsnotify_create(dir->d_inode, dentry);
> -			if (file->f_mode & FMODE_OPENED)
> -				fsnotify_open(file);
> -		}
> -
>  		path->dentry = dentry;
>  
>  	} else {


> @@ -5224,6 +5235,39 @@ SYSCALL_DEFINE3(mknod, const char __user *, filename, umode_t, mode, unsigned, d
>  	return filename_mknodat(AT_FDCWD, name, mode, dev);
>  }
>  
> +static inline
> +struct dentry *vfs_mkdir_no_perm(struct mnt_idmap *idmap, struct inode *dir,
> +				 struct dentry *dentry, umode_t mode,
> +				 struct delegated_inode *di)
> +{
> +	int error;
> +	struct dentry *de;
> +	unsigned max_links = dir->i_sb->s_max_links;
> +
> +	error = -EMLINK;
> +	if (max_links && dir->i_nlink >= max_links)
> +		goto err;

All the gotos here seem unnecessary. You can just return directly as
there's no cleanup performed under the err: label.

-- 
Christian Brauner <brauner@kernel.org>
