Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E23403E4
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 13:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779195837; cv=none; b=VFhMsYvePMuN96qQX2dZuj4wgYet7PjzGi7KXg47I1xa986NvViJkRXi2+5mKbZ62KLtgfJc065L8Qd+GGK67T1DXZe8xqPRUlC2nOz1Lnadk+z/gpP+8Uw69HvIGaRYZN5aCw7Z+QulTWjUXsqMOCUh8sUt1YXoPygjq1HKz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779195837; c=relaxed/simple;
	bh=wTRyUU+EgmMLyCP3u8Vw+oNTQPhUi22Tpr908ONhxLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4NNWt/i+4UY8j7QxYIiRDYLVpNadBDjyq5nh2ZoCSNEptk86uoxDQmWH+/jm78Y1PNN8YeWZdT1SStBv46QsoIyw1gFsOn5RCsHJTDo7BO3PBjTNmy0MMKluPqbcs5JADVpfI1A9TfOY+RU1EEYnKjv3tWQmkCtrwzoyE99hJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=xb0G1EX0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VaOAW2RK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2Lf/059C; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l4PjltSQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="xb0G1EX0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VaOAW2RK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2Lf/059C";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l4PjltSQ"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20A776AF4D;
	Tue, 19 May 2026 13:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779195834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng9qpsTSsCnPepbiT8H/98Mfgsm9sgAL8BKOzdgcPaw=;
	b=xb0G1EX0Zc92PvGgU51FeI5BApiFQxcD6e0x/L40bZ4dCTNyM/Ght4ZvdkIEKRUbBETOX+
	fpYP3e0lNGpbAJWy8pVJv5zr+vdVBH5gfslciKgWS+sIR2oeKokqNqluWuJdDnZZ3vDGpm
	XDdOy6wdg76TaIho1oV7HpJVY2bVT2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779195834;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng9qpsTSsCnPepbiT8H/98Mfgsm9sgAL8BKOzdgcPaw=;
	b=VaOAW2RK3ip2R6ElyOemUp8n0iPlQ3VrDdnKebqhlc41Gp1IPFfC3/4AIvaquW+o5e0f7G
	GXXRJebd3Y5ECLCQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="2Lf/059C";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=l4PjltSQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779195830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng9qpsTSsCnPepbiT8H/98Mfgsm9sgAL8BKOzdgcPaw=;
	b=2Lf/059CqW1QTg6Wj8Ui/xTO3y0GwJ+HiJYQ+UyJF9tbAOmWD5excSrNBpRcM9T1ky9sep
	ok+KF6QVD+jo0MAd/HA0L7ZSlRTRlzoTvD485mr2VrttmOJPxuF1WGy1gfrBxziJuWE2q6
	0evbV/ZqasG9yBfZ7cFhJC+10Hjx48w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779195830;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ng9qpsTSsCnPepbiT8H/98Mfgsm9sgAL8BKOzdgcPaw=;
	b=l4PjltSQQGysBSmMXZOgypkodWCxC7WY6jkSco5pDcQu0xUnbukv7NJn5NRK7zIh2qwhLM
	x4Oa9pfbIddfuuBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1804A593A8;
	Tue, 19 May 2026 13:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IpfWBbZfDGoRIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 13:03:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B03D0A0ADE; Tue, 19 May 2026 15:03:44 +0200 (CEST)
Date: Tue, 19 May 2026 15:03:44 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 12/14] configfs: mark pinned dentries persistent
Message-ID: <wku2fwx54hebbgv6zd7prinupe5bi56qn63mwzuft3hzzcd7ez@oqydvz24pngl>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-13-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-13-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 20A776AF4D
X-Spam-Level: 

On Tue 19-05-26 08:06:31, Al Viro wrote:
> on the removal side we can (finally) get rid of __simple_unlink()
> and __simple_rmdir() kludges now that dentries in question are
> properly marked persistent - simple_unlink() and simple_rmdir()
> will do the right thing for those.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c     | 13 +++----------
>  fs/configfs/symlink.c |  3 +--
>  2 files changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 6d9c6a5b17ff..740ea2c115bd 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -314,9 +314,7 @@ static int configfs_create_dir(struct config_item *item, struct dentry *dentry,
>  	inode->i_fop = &configfs_dir_operations;
>  	/* directory inodes start off with i_nlink == 2 (for "." entry) */
>  	inc_nlink(inode);
> -	d_instantiate(dentry, inode);
> -	/* already hashed */
> -	dget(dentry);  /* pin directory dentries in core */
> +	d_make_persistent(dentry, inode);
>  	inc_nlink(d_inode(p));
>  	item->ci_dentry = dentry;
>  	return 0;
> @@ -384,8 +382,7 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
>  
>  	inode->i_link = body;
>  	inode->i_op = &configfs_symlink_inode_operations;
> -	d_instantiate(dentry, inode);
> -	dget(dentry);  /* pin link dentries in core */
> +	d_make_persistent(dentry, inode);
>  	return 0;
>  
>  out_remove:
> @@ -412,12 +409,8 @@ static void configfs_remove_dir(struct dentry *d)
>  	configfs_remove_dirent(d);
>  
>  	if (d_really_is_positive(d)) {
> -		if (likely(simple_empty(d))) {
> -			__simple_rmdir(d_inode(parent),d);
> -			dput(d);
> -		} else {
> +		if (unlikely(simple_rmdir(d_inode(parent), d)))
>  			pr_warn("remove_dir (%pd): attributes remain", d);
> -		}
>  	}
>  
>  	pr_debug(" o %pd removing done (%d)\n", d, d_count(d));
> diff --git a/fs/configfs/symlink.c b/fs/configfs/symlink.c
> index f3f79c67add5..31eb28b27309 100644
> --- a/fs/configfs/symlink.c
> +++ b/fs/configfs/symlink.c
> @@ -229,9 +229,8 @@ int configfs_unlink(struct inode *dir, struct dentry *dentry)
>  	spin_lock(&configfs_dirent_lock);
>  	list_del_init(&sd->s_sibling);
>  	spin_unlock(&configfs_dirent_lock);
> -	configfs_drop_dentry(sd, dentry->d_parent);
> -	dput(dentry);
>  	configfs_put(sd);
> +	simple_unlink(dir, dentry);
>  
>  	/*
>  	 * drop_link() must be called before
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
