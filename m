Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A83409634
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779197013; cv=none; b=Ju/MTK0M1bxMGWraKazev8oXCB7HSqCXKvHbly+Mqv+/aB6lPnnAtGDo5cxzszR2w0ZeFbI6vBnTXxFczITVMbzPvkU284r5zLDY/cNMdiNa+A4ZbEYalSMEuEhFruNr6pbU8EINdhDe9IhsWjAIuFwbFC/BsHz+9v7wPfSv6Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779197013; c=relaxed/simple;
	bh=zbfdjSkmc7XMKJavFKM21evtMo0kp/jmYpPcO6d+lYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oT1h2nDOfrDtDZq9TsCqDvYvAdqm5WyZuzRDw+q6Pz2eddDGmXMp/37eVH6Wt/f0pdbPweVkKMmwBWF2OI/1wK6BPCxZCz/MHML/CI7LdzfCU27mfW/N1P++YGrM/c7+8+at0366AQsb5mW55b++KGkoOyZnQl/ytgMhX8tGAcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wggOSo/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQJT9X1U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wggOSo/5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=yQJT9X1U; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wggOSo/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQJT9X1U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wggOSo/5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="yQJT9X1U"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 43A7A6B3FF;
	Tue, 19 May 2026 13:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779197008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkBEUe9sv542r6Qdsw39EDCByRHCxmzcOJOnp61i8XI=;
	b=wggOSo/5ZjrNWNkfKNsrQOMtilTsiQxKiPyDKeezEKfpG7o4/lu7tfDqZkkJLYWDSBcm77
	5fWqYcKyvj+h3q6Ax/wQczTzS4pI/PCHnVFfgRd2k4pmBeDewTTJQMsy9ZamZKaGVdzVVx
	B3Z44VXc/cmwKanZkNI+xs2uitmj1vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779197008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkBEUe9sv542r6Qdsw39EDCByRHCxmzcOJOnp61i8XI=;
	b=yQJT9X1UmeC61ND5KoQ8WLw0koUxLjFl5etWtXViwVXYYUe5yN7Q8v9WChzdsVKW/SDkij
	+UA9hzTX5DpUQuCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wggOSo/5";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yQJT9X1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779197008; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkBEUe9sv542r6Qdsw39EDCByRHCxmzcOJOnp61i8XI=;
	b=wggOSo/5ZjrNWNkfKNsrQOMtilTsiQxKiPyDKeezEKfpG7o4/lu7tfDqZkkJLYWDSBcm77
	5fWqYcKyvj+h3q6Ax/wQczTzS4pI/PCHnVFfgRd2k4pmBeDewTTJQMsy9ZamZKaGVdzVVx
	B3Z44VXc/cmwKanZkNI+xs2uitmj1vs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779197008;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OkBEUe9sv542r6Qdsw39EDCByRHCxmzcOJOnp61i8XI=;
	b=yQJT9X1UmeC61ND5KoQ8WLw0koUxLjFl5etWtXViwVXYYUe5yN7Q8v9WChzdsVKW/SDkij
	+UA9hzTX5DpUQuCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F5F6593A8;
	Tue, 19 May 2026 13:23:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NsIRC1BkDGqJMgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 13:23:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 39C13A0ADE; Tue, 19 May 2026 15:23:19 +0200 (CEST)
Date: Tue, 19 May 2026 15:23:19 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 14/14] configfs_create(): lift parent timestamp
 updates into callers
Message-ID: <zzj3vyapwpxbda3ol5pyysw2ydcxbislqfyozbtrtl4kvgb7wo@ctlnvgs7i5qd>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-15-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-15-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.org.uk:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 43A7A6B3FF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 19-05-26 08:06:33, Al Viro wrote:
> ... and do *not* do it in ->lookup() case.  stat foo/bar
> should not update mtime of foo, TYVM...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c   | 6 +++++-
>  fs/configfs/inode.c | 3 ---
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index a2bb602fb38c..4da2fec2b64e 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -295,6 +295,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
>  	int error;
>  	umode_t mode = S_IFDIR| S_IRWXU | S_IRUGO | S_IXUGO;
>  	struct dentry *p = dentry->d_parent;
> +	struct inode *p_inode = d_inode(p);
>  	struct inode *inode;
>  
>  	BUG_ON(!item);
> @@ -315,7 +316,8 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
>  	d_make_persistent(dentry, inode);
> -	inc_nlink(d_inode(p));
> +	inc_nlink(p_inode);
> +	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
>  	item->ci_dentry = dentry;
>  	return 0;
>  
> @@ -369,6 +371,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
>  	int err = 0;
>  	umode_t mode = S_IFLNK | S_IRWXUGO;
>  	struct configfs_dirent *p = parent->d_fsdata;
> +	struct inode *p_inode = d_inode(parent);
>  	struct inode *inode;
>  
>  	err = configfs_make_dirent(p, dentry, target, mode, CONFIGFS_ITEM_LINK,
> @@ -383,6 +386,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
>  	inode->i_link = body;
>  	inode->i_op = &configfs_symlink_inode_operations;
>  	d_make_persistent(dentry, inode);
> +	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
>  	return 0;
>  
>  out_remove:
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index 3c26b6c443be..68290fe0e374 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -157,7 +157,6 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
>  {
>  	struct inode *inode = NULL;
>  	struct configfs_dirent *sd;
> -	struct inode *p_inode;
>  
>  	if (!dentry)
>  		return ERR_PTR(-ENOENT);
> @@ -170,8 +169,6 @@ struct inode *configfs_create(struct dentry *dentry, umode_t mode)
>  	if (!inode)
>  		return ERR_PTR(-ENOMEM);
>  
> -	p_inode = d_inode(dentry->d_parent);
> -	inode_set_mtime_to_ts(p_inode, inode_set_ctime_current(p_inode));
>  	configfs_set_inode_lock_class(sd, inode);
>  	return inode;
>  }
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
