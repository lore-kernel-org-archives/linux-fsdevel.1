Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F472E62D9
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922599; cv=none; b=Ko5aaGiQyHMjEhE+PMt87Y2A8lpfcITH+qRm1wq5yImcGWbpvu56CAcZHst0OxLJ7ZQKeH0Kvl3xQhQFfPtQmyBXyd5BsQByZ0R7m7X9OevCnW4V05uQ4Nak7Oym6O++xEvJhe18FINNykX7A9EJ5rnUA34tA4lCZuwA8YE5EoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922599; c=relaxed/simple;
	bh=CQMTbHyeILhz1LoSkjJ0pC8HHcLybYIRG/QXuxlZ33A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPqis5ocV6ffhO7GJdnFqBlmEoTznAMr7o53XHAHS6vpS0Wz5iwPTiE7KGtDJZGtH5R43/Y5dsqT6PRTv09BE+QW4q82PrxygxfF9g7NDFTOM2w1Y7KWMuT2ty8yrYUctE6HV4dIuotCRvkeB/R4aMBX3Yyi7TJrPopWsanEkqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q50AIXij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJ30o3sK; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q50AIXij; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nJ30o3sK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q50AIXij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJ30o3sK";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q50AIXij";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nJ30o3sK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8553367CEA;
	Mon,  8 Jun 2026 12:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbHk6CfyDV9lhe+tm0LablUGAlrTCrF1RwiLfhY700Q=;
	b=Q50AIXijILCtXEOYoqksN7V1OvQCxZHems91aqheaLkOKVkm6u1g8z5Bwp2HG0bPaE/VoZ
	HMX3n6pBILypq+8/Ze++XYanMK3ZhVBP0yT1s4d8y29+B0PxBPoP8GlL9l2lBREChfPA/X
	j+1FaVz30L0Cjknu6m6P/v7FpJun90k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbHk6CfyDV9lhe+tm0LablUGAlrTCrF1RwiLfhY700Q=;
	b=nJ30o3sKcn5K71HS/TxhUawry4fHZ5NWO6KR+wupOVXXEx9iktfzPlZsvhQEERAQUuqFGn
	trIcng4CnfhXPLAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q50AIXij;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nJ30o3sK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbHk6CfyDV9lhe+tm0LablUGAlrTCrF1RwiLfhY700Q=;
	b=Q50AIXijILCtXEOYoqksN7V1OvQCxZHems91aqheaLkOKVkm6u1g8z5Bwp2HG0bPaE/VoZ
	HMX3n6pBILypq+8/Ze++XYanMK3ZhVBP0yT1s4d8y29+B0PxBPoP8GlL9l2lBREChfPA/X
	j+1FaVz30L0Cjknu6m6P/v7FpJun90k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922596;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wbHk6CfyDV9lhe+tm0LablUGAlrTCrF1RwiLfhY700Q=;
	b=nJ30o3sKcn5K71HS/TxhUawry4fHZ5NWO6KR+wupOVXXEx9iktfzPlZsvhQEERAQUuqFGn
	trIcng4CnfhXPLAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B8E5779A7;
	Mon,  8 Jun 2026 12:43:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ggoqHuS4JmoYTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:43:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3DD4DA0923; Mon, 08 Jun 2026 14:43:12 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:43:12 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 17/18] configfs_attach_group(): drop the unused
 parent_item argument
Message-ID: <nu4bkft3d4yfft2dxxxmn5cbsjw4quqchmvyjr2qsqs2tu77y6@75hdw4jlrgwa>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-21-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-21-viro@zeniv.linux.org.uk>
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,linux.org.uk:email];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8553367CEA
X-Spam-Score: -4.01

On Wed 03-06-26 08:48:14, Al Viro wrote:
> This one *was* used - for passing it to configfs_attach_item(), which
> didn't use the value passed to it.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 2f3f3f504e2c..8fc05fe69992 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -657,8 +657,7 @@ static int populate_attrs(struct config_item *item)
>  	return 0;
>  }
>  
> -static int configfs_attach_group(struct config_item *parent_item,
> -				 struct config_item *item,
> +static int configfs_attach_group(struct config_item *item,
>  				 struct dentry *dentry,
>  				 struct configfs_fragment *frag);
>  static void configfs_detach_group(struct dentry *dentry);
> @@ -719,8 +718,7 @@ static int create_default_group(struct config_group *parent_group,
>  	if (child) {
>  		d_add(child, NULL);
>  
> -		ret = configfs_attach_group(&parent_group->cg_item,
> -					    &group->cg_item, child, frag);
> +		ret = configfs_attach_group(&group->cg_item, child, frag);
>  		if (!ret) {
>  			sd = child->d_fsdata;
>  			sd->s_type |= CONFIGFS_USET_DEFAULT;
> @@ -890,8 +888,7 @@ static void configfs_detach_group(struct dentry *dentry)
>  	configfs_detach_item(dentry);
>  }
>  
> -static int configfs_attach_group(struct config_item *parent_item,
> -				 struct config_item *item,
> +static int configfs_attach_group(struct config_item *item,
>  				 struct dentry *dentry,
>  				 struct configfs_fragment *frag)
>  {
> @@ -1423,7 +1420,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	spin_unlock(&configfs_dirent_lock);
>  
>  	if (group)
> -		ret = configfs_attach_group(parent_item, item, dentry, frag);
> +		ret = configfs_attach_group(item, dentry, frag);
>  	else
>  		ret = configfs_attach_item(item, dentry, frag);
>  
> @@ -1908,8 +1905,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
>  
>  		err = configfs_dirent_exists(dentry);
>  		if (!err)
> -			err = configfs_attach_group(sd->s_element,
> -						    &group->cg_item,
> +			err = configfs_attach_group(&group->cg_item,
>  						    dentry, frag);
>  		if (err) {
>  			BUG_ON(d_inode(dentry));
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
