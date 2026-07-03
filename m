Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657DE3161A4
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783078824; cv=none; b=FjxVaEMsp7TraBZ0gnv6ka67Ar69SVzirI0KRbnDCk3zR/tk9/OEuXHnNbLGInm1i2o7swRuD7z7WIspHks7RtsK5kR7qkAh2+CcELaCY4n62nrGndM/Mm7B2XE2tq0dh/gVQw0wrG/vVVMsDf7q1HOpHhcrVSdf4FRBCMPByUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783078824; c=relaxed/simple;
	bh=PWVXZ6vRIuiPBCjEdvuwJpNbH868vDV7h1vogt5xDNg=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=qk4Bl0sAZHgtk7gsjH4bIadk0X2K5dJx5YRRKu2KXmS3xljkfttMDAkAFSR3Q9xpzBxFhpLMfFX7kUOfccmaAAHom++dAW2/lBuv/gmzhqKFSkODRRwhbStkQNZZM3F28EDsQfUKohDLoHVazIBQyIeqY3v7kud/NxqlzMc5Nes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=oSiKVDWF; arc=none smtp.client-ip=195.121.94.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="oSiKVDWF"
X-KPN-MessageId: f7f0a909-76d3-11f1-bfba-00505699b430
Received: from mta.kpnmail.nl (unknown [10.31.161.188])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id f7f0a909-76d3-11f1-bfba-00505699b430;
	Fri, 03 Jul 2026 13:40:19 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.189])
	by mta.kpnmail.nl (Halon) with ESMTP
	id f7ef255b-76d3-11f1-9b09-00505699693e;
	Fri, 03 Jul 2026 13:40:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=LEbhiHOIq5GQf5Dz/o2/eRQOjCev8JSiJmGGEf38iS0=;
	b=oSiKVDWFVxpunfmIXoySVZ4LYq1k8nuJb2TPQSFQIeXrOq6+Sx+zopDpbQz9tdF1CzorBLeM49SZ0
	 a3qtOnLxh5vQkOq4DBYxtOHv+4ET/v/KxXFoMJKYMncPt2Gr9c3VveNmBpzzlvVS++tpdcBkYw2anQ
	 nG+PNGBTrA+uhS1O9n/kNKBGYsTG6RP01igopyAkFi6vY+hM5OuMySzrMVUQtYGWo55yJrAN93dNgU
	 bdGnG5ja8mTcazpVscID9Xr8YzWsXBh32ys2DZFStTHazkF5YyxlSYgslVRd9kw+t5aVvm2swjW2aI
	 mTZ1oyB77yGtVe8T651YT13V/Mz6GkA==
X-KPN-MID: 33|M6eEr/1mI2uY57tE6xKTix/zQY6pN70BGBEoKSSwmA83qh7B7lyZohc0+r0AaC1
 VBYHIjqgNzkEC3sIKJ7cBm68YsAel4rocp03nUHOx4uc=
X-CMASSUN: 33|ggPl595WF1NhYSLcS8mj/yiQOERJT6Od/7myLB7PdW65Vq0VkRbWeShWsqswRAc
 qZzQ0Y7ab9ArCQFWiwkKMUw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh05 (cpxoxapps-mh05.personalcloud.so.kpn.org [10.128.135.211])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id f7e1cd84-76d3-11f1-8edb-00505699eff2;
	Fri, 03 Jul 2026 13:40:19 +0200 (CEST)
Date: Fri, 3 Jul 2026 13:40:19 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: NeilBrown <neil@brown.name>, NeilBrown <neilb@ownmail.net>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Message-ID: <672624598.3933896.1783078819403@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260702111529.3559835-3-neilb@ownmail.net>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-3-neilb@ownmail.net>
Subject: Re: [PATCH 2/3] VFS: move delegated_inode retry loop into
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
> By moving this retry into lookup_open() we no longer need to pass around
> the delegated_inode pointer.
> 
> Various variable assignments need to be moved out of the declaration
> block so that they can be repeated after the "goto retry".
> 
> Signed-off-by: NeilBrown <neil@brown.name>
> ---
>  fs/namei.c | 43 ++++++++++++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/namei.c b/fs/namei.c
> index 55404fe0e269..cb33a01d16eb 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4397,17 +4397,23 @@ static struct dentry *atomic_open(const struct path *path, struct dentry *dentry
>   * An error code is returned on failure.
>   */
>  static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> -				  const struct open_flags *op,
> -				  struct delegated_inode *delegated_inode)
> +				  const struct open_flags *op)
>  {
> +	struct delegated_inode delegated_inode = { };
>  	struct mnt_idmap *idmap;
>  	struct dentry *dir = nd->path.dentry;
>  	struct inode *dir_inode = dir->d_inode;
> -	int open_flag = op->open_flag;
> +	int open_flag;
>  	struct dentry *dentry;
> -	int error, create_error = 0;
> -	umode_t mode = op->mode;
> -	bool got_write = false;
> +	int error, create_error;
> +	umode_t mode;
> +	bool got_write;
> +
> +retry:
> +	open_flag = op->open_flag;
> +	got_write = false;
> +	mode = op->mode;
> +	create_error = 0;
>  
>  	if (open_flag & (O_CREAT | O_TRUNC | O_WRONLY | O_RDWR)) {
>  		got_write = !mnt_want_write(nd->path.mnt);
> @@ -4505,7 +4511,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	/* Negative dentry, just create the file */
>  	if (!dentry->d_inode && (open_flag & O_CREAT)) {
>  		/* but break the directory lease first! */
> -		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, delegated_inode);
> +		error = try_break_deleg(dir_inode, LEASE_BREAK_DIR_CREATE, &delegated_inode);
>  		if (error)
>  			goto out_dput;
>  
> @@ -4539,6 +4545,15 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (got_write)
>  		mnt_drop_write(nd->path.mnt);
>  
> +	if (is_delegated(&delegated_inode)) {
> +		/* Must have come through out_dput: dentry is an ERR_PTR() */
> +		error = break_deleg_wait(&delegated_inode);
> +
> +		if (!error)
> +			goto retry;
> +		dentry = ERR_PTR(error);
> +	}
> +
>  	return dentry;
>  
>  out_dput:
> @@ -4586,7 +4601,6 @@ static struct dentry *lookup_fast_for_open(struct nameidata *nd, int open_flag)
>  static const char *open_last_lookups(struct nameidata *nd,
>  		   struct file *file, const struct open_flags *op)
>  {
> -	struct delegated_inode delegated_inode = { };
>  	int open_flag = op->open_flag;
>  	struct dentry *dentry;
>  	const char *res;
> @@ -4616,19 +4630,10 @@ static const char *open_last_lookups(struct nameidata *nd,
>  				return ERR_PTR(-ECHILD);
>  		}
>  	}
> -retry:
> -	dentry = lookup_open(nd, file, op, &delegated_inode);
> -
> -	if (IS_ERR(dentry)) {
> -		if (is_delegated(&delegated_inode)) {
> -			int error = break_deleg_wait(&delegated_inode);
>  
> -			if (!error)
> -				goto retry;
> -			return ERR_PTR(error);
> -		}
> +	dentry = lookup_open(nd, file, op);
> +	if (IS_ERR(dentry))
>  		return ERR_CAST(dentry);
> -	}
>  
>  	if (file->f_mode & (FMODE_OPENED | FMODE_CREATED)) {
>  		dput(nd->path.dentry);
> -- 
> 2.50.0.107.gf914562f5916.dirty

Looks good.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
