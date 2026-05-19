Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B08C334C27
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779192646; cv=none; b=QLyXTq5+2Mq/p8uWW8PGCJdFjn1o9ceR1XZ1kUJ2DsGUEDPt8maf3XPQojCDSgeVEWxhijlOkFnz/E4BTj6bf3jXtU3oLCi/PMK0djqANazcFePP6wWWe77s3gPfht02DppnwUo7ytHLeS4zSDX+FsbZH2LaH4fbn38J40Ny9as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779192646; c=relaxed/simple;
	bh=bbgzFEjHD/56csTecZD0+XXtqkJtckI4oN4Y3AmqTD8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7LTTwIH6KuQNDDgTNo0P4rKSqe5D+jGQEK7OCzxm57KrggVFtOV7JVcXhYNbZaWtPZeLWhReGZ0a1i2zoHsaGMr8ujX6rrEdGBxRV27bDySSQIelVs74APGkgrmto/hi2CDBtAzrw5ymW8/d2GNXCF7ARjnmFAw6TgPXv004Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EBEDmc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBmAfb98; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1EBEDmc4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pBmAfb98; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EBEDmc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBmAfb98";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1EBEDmc4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pBmAfb98"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8789A680C0;
	Tue, 19 May 2026 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779192642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVoXkjeHc7Jt1SGLmEW/u1LECZFm2hE41InVEBtXjE4=;
	b=1EBEDmc4dxN+j+nnjURX2rU3LE89E89kJnWNfC/z5nRpYLVVn+BXZhpEhtRG4CuzRnV01u
	/Wzv6HTKc0kysmfYIvhAz4NZj3o+Tu1c5slHbQ1R9w0JgEhveNIjv/4s0HwznQVBPdpLT9
	o/F0x02vWYqfKao01aIZQq6DBeaE5lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779192642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVoXkjeHc7Jt1SGLmEW/u1LECZFm2hE41InVEBtXjE4=;
	b=pBmAfb98PcTPd6aRk7EBuU6XLeY/r3Yf5BACVq4W+XynYIOCkqtXVE9dGVfC6vyLVXVeal
	8AUGdik5Rty3nOAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1EBEDmc4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=pBmAfb98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779192642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVoXkjeHc7Jt1SGLmEW/u1LECZFm2hE41InVEBtXjE4=;
	b=1EBEDmc4dxN+j+nnjURX2rU3LE89E89kJnWNfC/z5nRpYLVVn+BXZhpEhtRG4CuzRnV01u
	/Wzv6HTKc0kysmfYIvhAz4NZj3o+Tu1c5slHbQ1R9w0JgEhveNIjv/4s0HwznQVBPdpLT9
	o/F0x02vWYqfKao01aIZQq6DBeaE5lI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779192642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVoXkjeHc7Jt1SGLmEW/u1LECZFm2hE41InVEBtXjE4=;
	b=pBmAfb98PcTPd6aRk7EBuU6XLeY/r3Yf5BACVq4W+XynYIOCkqtXVE9dGVfC6vyLVXVeal
	8AUGdik5Rty3nOAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EA5B593A8;
	Tue, 19 May 2026 12:10:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AbHkHkJTDGojaQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 12:10:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6D6B5A0ADE; Tue, 19 May 2026 14:10:37 +0200 (CEST)
Date: Tue, 19 May 2026 14:10:37 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 10/14] switch configfs_detach_{group,item}() to
 passing dentry
Message-ID: <th3glogz3ob6dchlrfhctb4x22y3sps3uvqmmyunptc6gqe3jo@ttywxljkgrq3>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-11-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-11-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8789A680C0
X-Spam-Level: 

On Tue 19-05-26 08:06:29, Al Viro wrote:
> ... and there's no need to grab/drop it, or check for NULL - none
> of the callers would even get there with NULL dentry and all of
> them have the sucker pinned
> 
> Note that if sd is a directory configfs_dirent, we have sd->s_element
> pointing to config_item with item->ci_dentry equal to sd->s_dentry.
> Which is the only reason why detach_groups() gets away with using
> the latter for locking the inode and the former for removal.
> 
> Aren't redundant data structures wonderful, for obfuscation if nothing
> else?
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 43 +++++++++++++++----------------------------
>  1 file changed, 15 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index deb18689aa0a..39a496749dc2 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -621,18 +621,14 @@ static int configfs_attach_group(struct config_item *parent_item,
>  				 struct config_item *item,
>  				 struct dentry *dentry,
>  				 struct configfs_fragment *frag);
> -static void configfs_detach_group(struct config_item *item);
> +static void configfs_detach_group(struct dentry *dentry);
>  
> -static void detach_groups(struct config_group *group)
> +static void detach_groups(struct dentry *dentry)
>  {
> -	struct dentry * dentry = dget(group->cg_item.ci_dentry);
>  	struct dentry *child;
>  	struct configfs_dirent *parent_sd;
>  	struct configfs_dirent *sd, *tmp;
>  
> -	if (!dentry)
> -		return;
> -
>  	parent_sd = dentry->d_fsdata;
>  	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
>  		if (!sd->s_element ||
> @@ -643,7 +639,7 @@ static void detach_groups(struct config_group *group)
>  
>  		inode_lock(d_inode(child));
>  
> -		configfs_detach_group(sd->s_element);
> +		configfs_detach_group(child);
>  		d_inode(child)->i_flags |= S_DEAD;
>  		dont_mount(child);
>  
> @@ -652,11 +648,6 @@ static void detach_groups(struct config_group *group)
>  		d_delete(child);
>  		dput(child);
>  	}
> -
> -	/**
> -	 * Drop reference from dget() on entrance.
> -	 */
> -	dput(dentry);
>  }
>  
>  /*
> @@ -800,14 +791,10 @@ static void link_group(struct config_group *parent_group, struct config_group *g
>  }
>  
>  /* Caller holds the mutex of the item's inode */
> -static void configfs_detach_item(struct config_item *item)
> +static void configfs_detach_item(struct dentry *dentry)
>  {
> -	struct dentry *dentry = dget(item->ci_dentry);
> -	if (dentry) {
> -		detach_attrs(dentry);
> -		configfs_remove_dir(dentry);
> -		dput(dentry);
> -	}
> +	detach_attrs(dentry);
> +	configfs_remove_dir(dentry);
>  }
>  
>  /*
> @@ -842,7 +829,7 @@ static int configfs_attach_item(struct config_item *parent_item,
>  			 * we must lock them as rmdir() would.
>  			 */
>  			inode_lock(d_inode(dentry));
> -			configfs_detach_item(item);
> +			configfs_detach_item(dentry);
>  			d_inode(dentry)->i_flags |= S_DEAD;
>  			dont_mount(dentry);
>  			inode_unlock(d_inode(dentry));
> @@ -854,10 +841,10 @@ static int configfs_attach_item(struct config_item *parent_item,
>  }
>  
>  /* Caller holds the mutex of the group's inode */
> -static void configfs_detach_group(struct config_item *item)
> +static void configfs_detach_group(struct dentry *dentry)
>  {
> -	detach_groups(to_config_group(item));
> -	configfs_detach_item(item);
> +	detach_groups(dentry);
> +	configfs_detach_item(dentry);
>  }
>  
>  static int configfs_attach_group(struct config_item *parent_item,
> @@ -886,7 +873,7 @@ static int configfs_attach_group(struct config_item *parent_item,
>  		configfs_adjust_dir_dirent_depth_before_populate(sd);
>  		ret = populate_groups(to_config_group(item), frag);
>  		if (ret) {
> -			configfs_detach_group(item);
> +			configfs_detach_group(dentry);
>  			d_inode(dentry)->i_flags |= S_DEAD;
>  			dont_mount(dentry);
>  		}
> @@ -1522,13 +1509,13 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
>  		dead_item_owner = item->ci_type->ct_owner;
>  
>  	if (sd->s_type & CONFIGFS_USET_DIR) {
> -		configfs_detach_group(item);
> +		configfs_detach_group(dentry);
>  
>  		mutex_lock(&subsys->su_mutex);
>  		client_disconnect_notify(parent_item, item);
>  		unlink_group(to_config_group(item));
>  	} else {
> -		configfs_detach_item(item);
> +		configfs_detach_item(dentry);
>  
>  		mutex_lock(&subsys->su_mutex);
>  		client_disconnect_notify(parent_item, item);
> @@ -1781,7 +1768,7 @@ void configfs_unregister_group(struct config_group *group)
>  	configfs_detach_prep(sd, NULL);
>  	spin_unlock(&configfs_dirent_lock);
>  
> -	configfs_detach_group(&group->cg_item);
> +	configfs_detach_group(dentry);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	d_drop(dentry);
> @@ -1930,7 +1917,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>  	}
>  	spin_unlock(&configfs_dirent_lock);
>  	mutex_unlock(&configfs_symlink_mutex);
> -	configfs_detach_group(&group->cg_item);
> +	configfs_detach_group(dentry);
>  	d_inode(dentry)->i_flags |= S_DEAD;
>  	dont_mount(dentry);
>  	inode_unlock(d_inode(dentry));
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
