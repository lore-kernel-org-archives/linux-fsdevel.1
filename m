Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A523D16F8
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 10:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783074810; cv=none; b=Smg+OX3/UFoJliI1BgB1Z+fkNbqXO3dZPSzq3v9IXnDeYpvDkYNnWPLPBApT9ekNuM400oNVm3JeJkh4KYjD/yiib2X6IrbMoHa32eF/0CruyeifVqi+HzZr4dAv9+DiVzpKALqxXxNn14d/OLQVdvyrqWKXZMXIrwd7RMxNY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783074810; c=relaxed/simple;
	bh=0jJl7FjeKdeO5Z8e/1HOSFQcDv/Gnzu7kM9Y7fZ7Lqg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=bNmCBmDSFQ+5jtYjEfB+nmv78gq17dBHDu9BRon4NKS4DYnWBI77UlbuC6ng+VbNBx8VevIvDifarizX2YUa2j9Y3l3quXVDTG8BG+2K6TyEa8cVpA+do+N3JZvqA8fY7RXUmrnqFtpECbAPsDH42HTrZjXfwClTn8KD5tZtDr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=caQbr238; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="caQbr238"
X-KPN-MessageId: 9edb3cfe-76ca-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 9edb3cfe-76ca-11f1-bfba-00505699b430;
	Fri, 03 Jul 2026 12:33:24 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 9ed9b62a-76ca-11f1-9b09-00505699693e;
	Fri, 03 Jul 2026 12:33:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=KnwI1nS5288aqn8fzJzizQFdyHQHdtHyqtj4JVI3128=;
	b=caQbr238uMwLj4z/GjpiT+bNjoluS9Myn8BE2TUQ2c3WgWQT2WSGEdYl0iRekataXVBLK/HP7JwIy
	 L++rG9sCwWvjh8vpOOG5QbVm31Ha0naupl8LRJC49pdgQ737nTkqVaWIOZZY7rnrHZS+uOb8IlCtLJ
	 O2iT0dtQ1SUT0vSxGjo/Bt5UNe2DE1VuZOEH+PxHjXiyXE4vIZZaFCDVYD84M1W6o+DxalDSFNqUjp
	 sukjw0jgLlZ6fa+YNZMFt5FEK1Z++b3efctJnucBJ+e9RWNbhS2WyxXXQBJLL8NZ7ks0lUKoMXK48H
	 mqCW+UHKd+ibHoBtRH3oY43yMp+x2vw==
X-KPN-MID: 33|Ztw3HoObkvfgn6+RbFPw9NQDhtHNg2peb+etfNybYl9tCIWOAvbsgh5/9d7QV0z
 ijuA/iThDm63Mpre9qfB2jbsgT9zqP5iJxabyBe7OQlA=
X-CMASSUN: 33|fvFwNQZQaUZo5NHyBM6Ixl2hG9UZci98t2faILK5L6tWVMQLVHirYpuFwHMRdc5
 aYr6nJSq7mnDYtN+Vs3IRew==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh04 (cpxoxapps-mh04.personalcloud.so.kpn.org [10.128.135.210])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 9ecdf985-76ca-11f1-916a-005056995d6c;
	Fri, 03 Jul 2026 12:33:24 +0200 (CEST)
Date: Fri, 3 Jul 2026 12:33:24 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <1231841341.3912063.1783074804485@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260702111529.3559835-2-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-2-neilb@ownmail.net>
Subject: Re: [PATCH 1/3] VFS: move mnt_want_write() and locking into
 lookup_open()
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


> Op 02-07-2026 13:09 CEST schreef NeilBrown <neilb@ownmail.net>:
> 
>  
> From: NeilBrown <neil@brown.name>
> 
> The mnt_want_write() call and the parent inode locking in
> open_last_lookups() are only needed for lookup_open().  So we can move
> them and all the got_write handling into lookup_open().
> 
> Note that we need to also check create_error when determining whether to
> unlock shared or not, as O_CREAT can be cleared, but create_error is
> only set of O_CREAT was set.
> 
> The fsnotify calls come too as they must be in the locked region.
> 
> Also use the existing dir_inode uniformly for dir->d_inode.
> 
> This is a step towards exporting an better "open/create" interface to nfsd.
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c | 77 +++++++++++++++++++++++++++++-------------------------
>  1 file changed, 41 insertions(+), 36 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 7ead3db55be2..55404fe0e269 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4398,7 +4398,7 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>   */
>  static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  				  const struct open_flags *op,
> -				  bool got_write, struct delegated_inode *delegated_inode)
> +				  struct delegated_inode *delegated_inode)
>  {
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
> @@ -4407,9 +4407,25 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	struct dentry *dentry;
>  	int error, create_error = 0;
>  	umode_t mode = op->mode;
> +	bool got_write = false;
>  
> -	if (unlikely(IS_DEADDIR(dir_inode)))
> -		return ERR_PTR(-ENOENT);
> +	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> +		got_write = !mnt_want_write(nd->path.mnt);
> +		/*
> +		 * do _not_ fail yet - we might not need that or fail with
> +		 * a different error; let lookup_open() decide; we'll be
> +		 * dropping this one anyway.
> +		 */
> +	}
> +	if (open_flag & O_CREAT)
> +		inode_lock(dir_inode);
> +	else
> +		inode_lock_shared(dir_inode);
> +
> +	if (unlikely(IS_DEADDIR(dir_inode))) {
> +		dentry = ERR_PTR(-ENOENT);
> +		goto out;
> +	}
>  
>  	file->f_mode &= ~FMODE_CREATED;
>  	dentry = d_lookup(dir, &nd->last);
> @@ -4417,7 +4433,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		if (!dentry) {
>  			dentry = d_alloc_parallel(dir, &nd->last);
>  			if (IS_ERR(dentry))
> -				return dentry;
> +				goto out;
>  		}
>  		if (d_in_lookup(dentry))
>  			break;
> @@ -4433,7 +4449,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	}
>  	if (dentry->d_inode) {
>  		/* Cached positive dentry: will open in f_op->open */
> -		return dentry;
> +		goto out;
>  	}
>  
>  	if (open_flag & O_CREAT)
> @@ -4454,7 +4470,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		mode = vfs_prepare_mode(idmap, dir->d_inode, mode, mode, mode);
> +		mode = vfs_prepare_mode(idmap, dir_inode, mode, mode, mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(idmap, &nd->path,
>  						    dentry, mode);
> @@ -4469,7 +4485,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		dentry = atomic_open(&nd->path, dentry, file, open_flag, mode);
>  		if (unlikely(create_error) && dentry == ERR_PTR(-ENOENT))
>  			dentry = ERR_PTR(create_error);
> -		return dentry;
> +		goto out;
>  	}
>  
>  	if (d_in_lookup(dentry)) {
> @@ -4508,11 +4524,27 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  		error = create_error;
>  		goto out_dput;
>  	}
> +out:
> +	if (!IS_ERR(dentry)) {
> +		if (file->f_mode & FMODE_CREATED)
> +			fsnotify_create(dir_inode, dentry);
> +		if (file->f_mode & FMODE_OPENED)
> +			fsnotify_open(file);
> +	}
> +	if ((open_flag & O_CREAT) || create_error)
> +		inode_unlock(dir_inode);
> +	else
> +		inode_unlock_shared(dir_inode);
> +
> +	if (got_write)
> +		mnt_drop_write(nd->path.mnt);
> +
>  	return dentry;
>  
>  out_dput:
>  	dput(dentry);
> -	return ERR_PTR(error);
> +	dentry = ERR_PTR(error);
> +	goto out;
>  }

I know this is kernel code and an established pattern that is quite
useful. But jumping back with gotos just reads confusingly to my brain,
however, I don't have any better suggestion that is less confusing.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

>  
>  static inline bool trailing_slashes(struct nameidata *nd)
> @@ -4555,9 +4587,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
>  	struct delegated_inode delegated_inode = { };
> -	struct dentry *dir = nd->path.dentry;
>  	int open_flag = op->open_flag;
> -	bool got_write = false;
>  	struct dentry *dentry;
>  	const char *res;
>  
> @@ -4587,32 +4617,7 @@ static const char *open_last_lookups(struct nameidata *nd,
>  		}
>  	}
>  retry:
> -	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
> -		got_write = !mnt_want_write(nd->path.mnt);
> -		/*
> -		 * do _not_ fail yet - we might not need that or fail with
> -		 * a different error; let lookup_open() decide; we'll be
> -		 * dropping this one anyway.
> -		 */
> -	}
> -	if (open_flag & O_CREAT)
> -		inode_lock(dir->d_inode);
> -	else
> -		inode_lock_shared(dir->d_inode);
> -	dentry = lookup_open(nd, file, op, got_write, &delegated_inode);
> -	if (!IS_ERR(dentry)) {
> -		if (file->f_mode & FMODE_CREATED)
> -			fsnotify_create(dir->d_inode, dentry);
> -		if (file->f_mode & FMODE_OPENED)
> -			fsnotify_open(file);
> -	}
> -	if (open_flag & O_CREAT)
> -		inode_unlock(dir->d_inode);
> -	else
> -		inode_unlock_shared(dir->d_inode);
> -
> -	if (got_write)
> -		mnt_drop_write(nd->path.mnt);
> +	dentry = lookup_open(nd, file, op, &delegated_inode);
>  
>  	if (IS_ERR(dentry)) {
>  		if (is_delegated(&delegated_inode)) {
> -- 
> 2.50.0.107.gf914562f5916.dirty



I'll review your comments on v2 of O_CREAT|O_DIRECTORY and send a v3 this
weekend. I can work from your merge branch, but since this isn't in yet,
maybe I should just work from Christian's branch instead? What can I do
to make this the least amount of extra work for you?

Thanks, for thinking of me and doing some of the merge work already :)
