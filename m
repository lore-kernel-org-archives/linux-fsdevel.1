Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C33A42A791
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Jul 2026 11:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992972; cv=none; b=jcazSZvUapGTliRTImcIDBEJRy0mJA4dW25rr9oljGeyXFZsRr5MZiX1RJZIcU8K0QMLtADyI3ViCtdM5h29pljq8yyCxxt8tcMCJXYaFmWzBm17GCEKZt4uJNorb3oeVbk0fiXUErquwccxMzohBbN2Fp/7WMIF9R7uvoWJPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992972; c=relaxed/simple;
	bh=FyV6JIaF3z/a2YLKkdXWi0gWGnV0t0qbtTdhwNscbho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LacH4EuM24s0S6eZxXTQMDrEVAEICDG1CQrKjWbnKNRApGrZXxhEFcPNa6LNTK6AHbIpWdPKV99nGtk6sfYJ+ZpfbDXReCE47Mp/yOmfXy6ELcNpRjYAKl8pIvF8NJ2pKDECAOA0Ks0Mft+bxFV/WyauzZVBY/GBskhNLqe1O0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjdlNhDL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xs23PBms; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=mjdlNhDL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Xs23PBms; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjdlNhDL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xs23PBms";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="mjdlNhDL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Xs23PBms"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0E530741A8;
	Thu,  2 Jul 2026 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782992968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rK7hQLDM/Cc7m2DFVtL7YVFJdsoiRP40EC2cTc3bMdM=;
	b=mjdlNhDLhlL+osNvEDpMapISNguXBEPYB38qqyCyf6SX9rCiy6fSdvdv4T8K7GqXQRoC/2
	FTi0GIzYpf1TcJSWNRsY3ROXiGVAbesI9a0/patfVAHnuzRRpdQNV8iOzETiBOZzdFCzcW
	zpjwN4hXR9IXDMuYNoCaribTSW3JisI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782992968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rK7hQLDM/Cc7m2DFVtL7YVFJdsoiRP40EC2cTc3bMdM=;
	b=Xs23PBmsWTdVOhMSJ4j7a0Gf8tlSQF8JxIPEAtJhi3mAHpPuvWXF0FOGv035taoZ5QDTMM
	csnio0vvjZzQamAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=mjdlNhDL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Xs23PBms
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782992968; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rK7hQLDM/Cc7m2DFVtL7YVFJdsoiRP40EC2cTc3bMdM=;
	b=mjdlNhDLhlL+osNvEDpMapISNguXBEPYB38qqyCyf6SX9rCiy6fSdvdv4T8K7GqXQRoC/2
	FTi0GIzYpf1TcJSWNRsY3ROXiGVAbesI9a0/patfVAHnuzRRpdQNV8iOzETiBOZzdFCzcW
	zpjwN4hXR9IXDMuYNoCaribTSW3JisI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782992968;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rK7hQLDM/Cc7m2DFVtL7YVFJdsoiRP40EC2cTc3bMdM=;
	b=Xs23PBmsWTdVOhMSJ4j7a0Gf8tlSQF8JxIPEAtJhi3mAHpPuvWXF0FOGv035taoZ5QDTMM
	csnio0vvjZzQamAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E38BC779AA;
	Thu,  2 Jul 2026 11:49:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CEsNN0dQRmo4DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 02 Jul 2026 11:49:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7B793A12AD; Thu, 02 Jul 2026 13:49:23 +0200 (CEST)
Date: Thu, 2 Jul 2026 13:49:23 +0200
From: Jan Kara <jack@suse.cz>
To: NeilBrown <neil@brown.name>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: Re: [PATCH 1/3] VFS: move mnt_want_write() and locking into
 lookup_open()
Message-ID: <xd56meklckurfba53w5vremoywvvrwvidmz6ohxiz5phuzgvfp@mpdu7auyq5il>
References: <[PATCH 0/3] VFS: replace dentry_create>
 <20260702111529.3559835-1-neilb@ownmail.net>
 <20260702111529.3559835-2-neilb@ownmail.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702111529.3559835-2-neilb@ownmail.net>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,kernel.org,suse.cz,vger.kernel.org,xs4all.nl];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,brown.name:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E530741A8
X-Spam-Score: -4.01

On Thu 02-07-26 21:09:19, NeilBrown wrote:
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

I'll defer to others to decide whether the overall patch set is the
desirable direction of NFS - VFS interactions but if yes, then this patch
looks correct to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


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
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
