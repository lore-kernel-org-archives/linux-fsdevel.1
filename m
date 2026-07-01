Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BE63BB9F4
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Jul 2026 10:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900541; cv=none; b=IzZHCdHUNCC2xpWS8Xt6toBJh2n6OfrgKBKwSf5gm3TADyzSmyDJW+1xMV7vPp+0PrS5aJm/jg0L2Zta/kphLJtlWnFpL/pRanYc6iGeRSoFFK9hyG2RcmnNudZ+GvC5oikptHNNpgh0D//WNeh3eDekHcJj5MWXM9ln+KwMGgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900541; c=relaxed/simple;
	bh=rGaoX+ISM27JXbBbt3ZOaEJSQk69BfmqkEzaNpJ1J0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMsPfh68j1Mv85bjZRwjs0najqjHISwk1u4ZTC/5C62FYFiXPAT8e2/e9tW9DqdQV/xVkTUXtG3CLa5qwajjHTK+o0A95GVg19x0wO+zfqussYOhtRkbeN5EthE6XdLg7C63Uw6m9Oa00ukPyzeJDI9Kx5npGYSXUnr1RnCulUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YWF1RclD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJFegnev; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YWF1RclD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tJFegnev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YWF1RclD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJFegnev";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YWF1RclD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tJFegnev"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1B1C72019;
	Wed,  1 Jul 2026 10:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jttOs9JrhfsP+tPiPOOCi04IU2npJ4lYt/oka99TKCI=;
	b=YWF1RclDERKZLpnEeL/bfkRx5ukUNSoLp16pQEc2bqjIEmDf7JsahWoL5lY/gqzUjJCFDk
	EzuhBXycj0ile4mib0pXKI9ZIIZ7fCxxub9QMF3BY5e2Rgkr6s2E6j2EWDClONF0N7c+C4
	SAFK3tAxIY/DiAPNiAM0+e0HmTEk9Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jttOs9JrhfsP+tPiPOOCi04IU2npJ4lYt/oka99TKCI=;
	b=tJFegnevaR5E0KMfLm+x1noFPn8fUc3XGug7rziO9sHqQgRReVeZCL5CUSz7G8mBleBXjj
	v8GMQd4ntOjCceBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1782900537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jttOs9JrhfsP+tPiPOOCi04IU2npJ4lYt/oka99TKCI=;
	b=YWF1RclDERKZLpnEeL/bfkRx5ukUNSoLp16pQEc2bqjIEmDf7JsahWoL5lY/gqzUjJCFDk
	EzuhBXycj0ile4mib0pXKI9ZIIZ7fCxxub9QMF3BY5e2Rgkr6s2E6j2EWDClONF0N7c+C4
	SAFK3tAxIY/DiAPNiAM0+e0HmTEk9Ko=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1782900537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jttOs9JrhfsP+tPiPOOCi04IU2npJ4lYt/oka99TKCI=;
	b=tJFegnevaR5E0KMfLm+x1noFPn8fUc3XGug7rziO9sHqQgRReVeZCL5CUSz7G8mBleBXjj
	v8GMQd4ntOjCceBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A41F779AA;
	Wed,  1 Jul 2026 10:08:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PSyjJTnnRGqHPAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 01 Jul 2026 10:08:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1BA19A10B7; Wed, 01 Jul 2026 12:08:53 +0200 (CEST)
Date: Wed, 1 Jul 2026 12:08:53 +0200
From: Jan Kara <jack@suse.cz>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, NeilBrown <neil@brown.name>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/31] vfs: pass S_IFDIR mode to vfs_prepare_mode()
Message-ID: <mr3sedjwzhc2khnx43qlhq7nddzg4yfee66ckgd2mjtn4jfemw@w3gqbr76pnby>
References: <20260630105400.68459-1-jkoolstra@xs4all.nl>
 <20260630105400.68459-2-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630105400.68459-2-jkoolstra@xs4all.nl>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[xs4all.nl];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,xs4all.nl:email,suse.cz:email];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[xs4all.nl];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Level: 

On Tue 30-06-26 12:53:30, Jori Koolstra wrote:
> There is a comment in vfs_prepare_mode() that says:
> 
>   Note that it's currently valid for @type to be 0 if a directory is
>   created. Filesystems raise that flag individually and we need to check
>   whether each filesystem can deal with receiving S_IFDIR from the vfs
>   before we enforce a non-zero type.
> 
> It is safe to do this clean-up except that three filesystems (fuse,
> cifs, and coda) forward the mkdir @mode unchanged to something outside
> the kernel. Mask S_IFDIR back out in coda_mkdir(), fuse_mkdir() and
> cifs_mkdir() so that what is sent outside the kernel is unchanged.
> Their maintainers can drop the mask once they have confirmed it is safe.
> 
> Assisted-by: Claude Opus 4.8 (1M context)
> Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/coda/dir.c         | 7 ++++++-
>  fs/fuse/dir.c         | 8 ++++++++
>  fs/namei.c            | 7 +------
>  fs/smb/client/inode.c | 7 +++++++
>  4 files changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/coda/dir.c b/fs/coda/dir.c
> index 835eb7fdfdad..9ad4d217c8b6 100644
> --- a/fs/coda/dir.c
> +++ b/fs/coda/dir.c
> @@ -179,7 +179,12 @@ static struct dentry *coda_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (is_root_inode(dir) && coda_iscontrol(name, len))
>  		return ERR_PTR(-EPERM);
>  
> -	attrs.va_mode = mode;
> +	/*
> +	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
> +	 * verbatim to userspace, which has only ever been given the permission
> +	 * bits. Strip the type bit until venus is known to cope with it.
> +	 */
> +	attrs.va_mode = mode & ~S_IFDIR;
>  	error = venus_mkdir(dir->i_sb, coda_i2f(dir),
>  			       name, len, &newfid, &attrs);
>  	if (error)
> diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
> index 0e2a1039fa43..7decbe4ea48a 100644
> --- a/fs/fuse/dir.c
> +++ b/fs/fuse/dir.c
> @@ -1117,6 +1117,14 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (!fm->fc->dont_mask)
>  		mode &= ~current_umask();
>  
> +	/*
> +	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
> +	 * verbatim to the userspace server which has only ever been given the
> +	 * permission bits. Strip the type bit until the protocol is known to
> +	 * cope with it.
> +	 */
> +	mode &= ~S_IFDIR;
> +
>  	memset(&inarg, 0, sizeof(inarg));
>  	inarg.mode = mode;
>  	inarg.umask = current_umask();
> diff --git a/fs/namei.c b/fs/namei.c
> index 5cc9f0f466b8..6554803d6903 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -4140,11 +4140,6 @@ EXPORT_SYMBOL(end_renaming);
>   * after setgid stripping allows the same ordering for both non-POSIX ACL and
>   * POSIX ACL supporting filesystems.
>   *
> - * Note that it's currently valid for @type to be 0 if a directory is created.
> - * Filesystems raise that flag individually and we need to check whether each
> - * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
> - * non-zero type.
> - *
>   * Returns: mode to be passed to the filesystem
>   */
>  static inline umode_t vfs_prepare_mode(struct mnt_idmap *idmap,
> @@ -5256,7 +5251,7 @@ struct dentry *vfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	if (!dir->i_op->mkdir)
>  		goto err;
>  
> -	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, 0);
> +	mode = vfs_prepare_mode(idmap, dir, mode, S_IRWXUGO | S_ISVTX, S_IFDIR);
>  	error = security_inode_mkdir(dir, dentry, mode);
>  	if (error)
>  		goto err;
> diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
> index 1dbcfd163ff0..369dfd56c1e6 100644
> --- a/fs/smb/client/inode.c
> +++ b/fs/smb/client/inode.c
> @@ -2282,6 +2282,13 @@ struct dentry *cifs_mkdir(struct mnt_idmap *idmap, struct inode *inode,
>  	const char *full_path;
>  	void *page;
>  
> +	/*
> +	 * vfs_mkdir() now passes S_IFDIR in @mode, but @mode is forwarded
> +	 * verbatim to the server and in the past only contained permission
> +	 * bits. Strip the type bit until SMB is verified to deal with it.
> +	 */
> +	mode &= ~S_IFDIR;
> +
>  	cifs_dbg(FYI, "In cifs_mkdir, mode = %04ho inode = 0x%p\n",
>  		 mode, inode);
>  
> -- 
> 2.54.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
