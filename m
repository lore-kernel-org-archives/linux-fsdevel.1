Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887A3BBA0A;
	Mon, 31 Aug 2026 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788168161; cv=none; b=rYd0iDsFmgLQlM9XhzEENpRUX2hZ/SIDv7n4wzWakRSmow4DAsVurcQ2rK2NLuH8OpcAZ4UfuJeMX5UOYk1aMTcDqM6lN2JG3OPvsnfSXHn0Ax2i8CZJjsITYlwBGKgm5TYM6W26KcArjyAqtwlcnlyy1qdez2vwFHhM9uYsWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788168161; c=relaxed/simple;
	bh=RFopL6aEqJqmHYV17+nbP+f35R8RNRjGMiKXyfc5GqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RVVTUxfUa+FP8KxRbt745y/kKJKhNvFk5M6ZUOPKZIjE9lIhkBjEhd0Az6Pvi9sWxx8NTwjaIOPE7J6KPMTaqAMy/2IkwuMzGrK8Kt365Ny5HaD3POCrk78s0twmyXsGQGV7OZOz6o1xm4FqyrA4cYEJwzeZSWyXnwZ9fuue4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bd4q/XlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bd4q/XlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1F81F000E9;
	Mon, 31 Aug 2026 09:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788168160;
	bh=piH9YCS8JDXHEn2ivmhdvcSKa4s3/Lh8goB7fii0PYc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Bd4q/XlQcRnJO0SgNZqs6P1YqGZ8rzrVTmd+vDOtNATzAqDvcpiGVuNDidNMc7jIf
	 Z88HSxiRBWqGyu3lbcWnlpSGESbO4aRd8EbgKS0kerkIHIXRmSi7ix8VxiUPn5K/Ea
	 sPEqNy0/NhCGPjNfYGKnvKnYuhkw2aI/9eLTzc8UpTf34lK96C4j5e7d34fG8Pt055
	 XNZ314n/CU9+10RJ9u5j8U2GNZrJNmvrjDbiSBHD+WvyX/gyUv3cQ0cDTWImV0F0l4
	 WOwa8NIKyCSXHIoCdEz1EfmH5BlKhJG7djHRrR2S8/ifDFU7wPhwvUBhRtGsNbk3f2
	 821x6kFChAwPw==
Date: Mon, 31 Aug 2026 11:22:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Jeff Layton <jlayton@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Aleksa Sarai <aleksa@amutable.com>, NeilBrown <neil@brown.name>, Amir Goldstein <amir73il@gmail.com>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 05/10] vfs: lookup_open(): use vfs_create_no_perm()
Message-ID: <20260831-aktienhandel-anmeldung-zornig-1b9c8898d35f@brauner>
References: <20260823160706.358293-1-jkoolstra@xs4all.nl>
 <20260823160706.358293-6-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260823160706.358293-6-jkoolstra@xs4all.nl>

On Sun, Aug 23, 2026 at 06:07:01PM +0200, Jori Koolstra wrote:
> We can replace the code in the no create_error/negative dentry found
> from lookup case in lookup_open() with the vfs_create_no_perm() helper.
> 
> Reviewed-by: NeilBrown <neil@brown.name>
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
> ---
>  fs/namei.c | 20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 55ba23f95c5b..3afae6e87825 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4430,8 +4430,14 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>  		}
>  		dput(dentry);
>  		dentry = ERR_PTR(error);
> +	} else {
> +		if (file->f_mode & FMODE_CREATED)
> +			fsnotify_create(dir_inode, dentry);
> +		if (file->f_mode & FMODE_OPENED)
> +			fsnotify_open(file);

Note that this causes duplicate IN_CREATE/IN_OPEN as both atomic_open()
and dentry_create() now notify.

>  	}
>  
> +
>  	return dentry;
>  }
>  
> @@ -4581,22 +4587,10 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		goto out_dput;
>  	}
>  
> -	error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
> -	if (error)
> -		goto out_dput;
> -
> -	error = dir_inode->i_op->create(idmap, dir_inode, dentry, mode);
> -	if (error)
> -		goto out_dput;
> +	error = vfs_create_no_perm(idmap, dentry, mode, &delegated_inode);

Afaict, this has a latent bug until later in the series. Right now
failing ->create/try_break_deleg() sets FMODE_CREATED on a negative
dentry. That causes a splat in any sticky directory. And some nastiness
with failing to break a delegation as well.

>  
>  	file->f_mode |= FMODE_CREATED;
>  out:
> -	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir_inode, dentry);
> -		if (file->f_mode & FMODE_OPENED)
> -			fsnotify_open(file);
> -	}
>  	if ((open_flag & O_CREAT) || create_error)
>  		inode_unlock(dir_inode);
>  	else
> -- 
> 2.55.0
> 

-- 
