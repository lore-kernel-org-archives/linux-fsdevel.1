Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDD3D6CA0;
	Tue,  7 Jul 2026 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783421502; cv=none; b=mkOpfsry01ckkNN0SLWhoOvsbwCmqKyIAgCsC/DwFxMH7Xd6hWkBK/4FF4UqvK6RhXV7xD8ehuftnpkRMkel1z+1glVeoYRCw+1AKiyF3HUZiN/8eOhw/02HcvpbOFELmM9E0QOLHXxuHFZLQ2AI8WbHUh4FqH3t8aNKDXMIUT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783421502; c=relaxed/simple;
	bh=cnbkI9z+Mpe16gzROCLbBICaEE3clm+CS4vqJmu3ep8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=Rs9q6fIM/N5RXdPLY6MDloF9vvUNszql7hs+6lMdhadKsOjAFjHyhMbrxd4lqXGTEJJNDOHzRt1SasGptYHEEVpvUBLXVfZUeqdM9dIRofXibvuHZAhnpj55EqngAYtPri7/o8+Sv4yh6Uqhp52BAUudb3fIbczu5OTPU9JSotw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0kp2Wdd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0kp2Wdd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43ED1F00A3A;
	Tue,  7 Jul 2026 10:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783421498;
	bh=ubT305olmI4Wtz9hKXIPjwkSHBQMVE1JKh7CiJ0cEv0=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Y0kp2WddwH4m9u6+lgdoAYYaIHcs1McjmEfXXe8MPwStSExvMlRrrLAsGUi+enOLm
	 ctMv7Z3PJEODXt/W5Zh2ZXsVFz5L+vDYq7rCBRsgkGyScVwtaYzL9bifv7usfJAC06
	 YInztFX4yiWxicoY1cYTbLKKQsbX/AoJmsBYpI8euaAeeNVrxGN7+CYwEuKe0FfwrX
	 rnUmATYFEoPjgi9FKUEOHNz7OwT2yh4dhWDzwleXTz32ZMOihmvz12mwdvpIol6uWI
	 lJ3iyJLZIptYnBohnaexavlNXOqv2NigoVuj0ixa2reTFIo4fozAi3nAE71Vb10Q/C
	 EdvGS9SmlzJGQ==
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 04/14] vfs: call audit_inode_child() in
 lookup_open() on failure too
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
 Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260704164149.3480051-5-jkoolstra@xs4all.nl>
References: <20260704164149.3480051-1-jkoolstra@xs4all.nl>
 <20260704164149.3480051-5-jkoolstra@xs4all.nl>
Date: Tue, 07 Jul 2026 12:51:23 +0200
Message-Id: <20260707-benutzbar-geizen-triumphieren-246446f41997@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=4439; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cnbkI9z+Mpe16gzROCLbBICaEE3clm+CS4vqJmu3ep8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWT53DKwnMR7ICdO9syu906VBe4fT121+s8f6M2hPfGlQ
 MdDT+5lHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxeMbIcFY12usIcydz29Kj
 hoZ/35dIXj209A1D/LmkO/8O/1VW4mL4p7+U63L594xaKffqeaGX7IWeh4d9POl9OzD5T1/QHu4
 MLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> audit_inode_child() is called in may_create_dentry() so that failed
> filesystem operations still register an audit entry. On success, the
> entry is overwritten when, for instance, fsnotify_create() is called.
> This is the calling convention in vfs_create() and vfs_mkdir().
> In lookup_open(), however, when atomic_open() should have created a
> file but didn't, no call to audit_inode_child() is made. The same is
> true for the regular ->create() path.

So what does audit_inode_child() do now? Does it only audit on failure
or unconditionally? It seems that to be useful you want both? In any
case, it reads like this might not belong into this series and should be
split into a separate fix if it's broken.

> Fix the calling of audit_inode_child() in lookup_open() to match the
> vfs_create() path. For the ->atomic_open() filesystems this logic has
> been pushed into atomic_open(). This function is also reordered a bit
> to make the case distinction of the possible returns from
> ->atomic_open() more explicit (i.e. finish_open() or finish_no_open()).
> 
> When retrying delegation breaking, audit_inode_child() could be called
> more than once, but this is OK because those entries are reused.
> 
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
>
> diff --git a/fs/namei.c b/fs/namei.c
> index ee47d3f5159f..956adcd14c4a 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4369,10 +4369,11 @@ static int may_o_create(struct mnt_idmap *idmap,
>   */
>  static struct dentry *atomic_open(const struct path *path, struct dentry *dentry,
>  				  struct file *file,
> -				  int open_flag, umode_t mode)
> +				  int open_flag, umode_t mode, bool create_error)
>  {
>  	struct dentry *const DENTRY_NOT_SET = (void *) -1UL;
>  	struct inode *dir =  path->dentry->d_inode;
> +	bool failed_create = false;
>  	int error;
>  
>  	file->__f_path.dentry = DENTRY_NOT_SET;
> @@ -4382,23 +4383,33 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  	d_lookup_done(dentry);
>  	if (!error) {
>  		if (file->f_mode & FMODE_OPENED) {
> -			if (unlikely(dentry != file->f_path.dentry)) {
> +			// finish_open() called
> +			struct dentry *opened = file->f_path.dentry;
> +			if (unlikely(opened != dentry)) {
>  				dput(dentry);
> -				dentry = dget(file->f_path.dentry);
> +				dentry = dget(opened);
>  			}
> -		} else if (WARN_ON(file->f_path.dentry == DENTRY_NOT_SET)) {
> -			error = -EIO;
> -		} else {
> -			if (file->f_path.dentry) {
> +		} else if (likely(file->f_path.dentry != DENTRY_NOT_SET)) {
> +			// finish_no_open() called
> +			struct dentry *replaced = file->f_path.dentry;
> +			if (replaced) {
>  				dput(dentry);
> -				dentry = file->f_path.dentry;
> +				dentry = replaced;
>  			}
>  			if (unlikely(d_is_negative(dentry)))
>  				error = -ENOENT;


> +			if (error && create_error) // should have created, but errored before
> +				failed_create = true;


> +		} else {


> +			const char *fsname = dentry->d_sb->s_type->name;
> +			WARN(1, "%s: ->atomic_open() left file->f_path.dentry unset!\n", fsname);
> +			error = -EIO;
>  		}
>  	}
>  
>  	if (error) {
> +		if (failed_create)
> +			audit_inode_child(dir, dentry, AUDIT_TYPE_CHILD_CREATE);


>  		dput(dentry);
>  		dentry = ERR_PTR(error);
>  	} else {
> @@ -4462,7 +4473,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		dentry = NULL;
>  	}
>  	if (dentry->d_inode) {
> -		/* Cached positive dentry: will open in f_op->open */
> +		/* Cached positive dentry: will open in do_open(). */
>  		return dentry;
>  	}
>  
> @@ -4496,7 +4507,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (dir_inode->i_op->atomic_open) {
>  		if (nd->flags & LOOKUP_DIRECTORY)
>  			open_flag |= O_DIRECTORY;
> -		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
> +		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode, create_error);
>  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
>  			dentry = ERR_PTR(create_error);
>  		return dentry;
> @@ -4515,33 +4526,37 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  			dentry = res;
>  		}
>  	}
> +	if (dentry->d_inode || !(op->open_flag & O_CREAT)) {

d_really_is_positive()

-- 
Christian Brauner <brauner@kernel.org>
