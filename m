Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA812571DA
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782993004; cv=none; b=a/fBZwPyIXIc90dbmILGO00BS44bCW3yDRymZtOBPz5JZXJAJT8GEvGifwCm4iYWVMPO+ZlWKe8BJBEKvvwkQcyGwbnssRZvK9+54hLjgxyl+CKuNOSwoqcoyVUDKjqqrTrJBTtveBKBdpOhrWd5MCThcv3ZsGOA7UUk1MCqHWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782993004; c=relaxed/simple;
	bh=WC/Z8q6h+I7cQIQz6xnjH8S06oHo3n8AZhmHWQYmhaE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jlyJm7UzXNDohp3ZZeY0hVEnP8aug4SYyE6w7TFe6tUBX19n913Pjyxb4YImF6CEFx/7cKVdgZRLJVosqzuvo+tszOV0lCmFZroY3JI+11kUI08mYcoxpErfKv9kwAeYKZ8zRTorqql4EWIXUMMgidjtZ7SHya7yRMqrCCrqYAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MY7v7DXV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZygHexrr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=MY7v7DXV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZygHexrr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MY7v7DXV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZygHexrr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="MY7v7DXV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZygHexrr"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71A887419D;
	Thu,  2 Jul 2026 11:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782993001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv4ZUbNNYkyG3g7dLDUdlKuXAaJWmDGzMSK4pXrl+Ok=;
	b=MY7v7DXVFYxJJykvhQh+gSujc8Kk9gMjXO+OqXF9aL5+hxwTvoTctqvke0ekZ7TPTy9KIb
	BInAh54SnrFOlhMbMNPGhIkN3efwPy6kCqwiR5VsN83Ng747PE2kCZ8RFZxUNVuvehphs2
	qnVB+IlF5W1Qp5AGGTC8/ZRxVs5y2hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782993001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv4ZUbNNYkyG3g7dLDUdlKuXAaJWmDGzMSK4pXrl+Ok=;
	b=ZygHexrrjdF6GJio/Wq4HtRAQy4IMRKHdT1oTqSGF6T4hu+bOhfLf6iieDOs2Eq1RCtvTm
	Wewymb49CB1SyrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782993001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv4ZUbNNYkyG3g7dLDUdlKuXAaJWmDGzMSK4pXrl+Ok=;
	b=MY7v7DXVFYxJJykvhQh+gSujc8Kk9gMjXO+OqXF9aL5+hxwTvoTctqvke0ekZ7TPTy9KIb
	BInAh54SnrFOlhMbMNPGhIkN3efwPy6kCqwiR5VsN83Ng747PE2kCZ8RFZxUNVuvehphs2
	qnVB+IlF5W1Qp5AGGTC8/ZRxVs5y2hA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782993001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Cv4ZUbNNYkyG3g7dLDUdlKuXAaJWmDGzMSK4pXrl+Ok=;
	b=ZygHexrrjdF6GJio/Wq4HtRAQy4IMRKHdT1oTqSGF6T4hu+bOhfLf6iieDOs2Eq1RCtvTm
	Wewymb49CB1SyrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62EF3779AA;
	Thu,  2 Jul 2026 11:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k3cnGGlQRmrkDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jul 2026 11:50:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02BCFA12AD; Thu, 02 Jul 2026 13:49:56 +0200 (CEST)
Date: Thu, 2 Jul 2026 13:49:56 +0200
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 2/3] VFS: move delegated_inode retry loop into
 lookup_open()
Message-ID: <y35bq233pi54khi3hjnzv2lpfeklvbgcmybrmu6iw5ztvaayfc@xnfi4qssfcv6>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-3-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702111529.3559835-3-neilb@ownmail.net>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,xs4all.nl];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,brown.name:email,suse.com:email]
X-Spam-Level: 
X-Spam-Score: -3.80

On Thu 02-07-26 21:09:20, NeilBrown wrote:
> From: NeilBrown <neil@brown.name>
> 
> By moving this retry into lookup_open() we no longer need to pass around
> the delegated_inode pointer.
> 
> Various variable assignments need to be moved out of the declaration
> block so that they can be repeated after the "goto retry".
> 
> Signed-off-by: NeilBrown <neil@brown.name>

With the same reservation as for the first patch feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
