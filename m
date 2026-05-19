Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA8148AE11
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185529; cv=none; b=TtDN0CbLLwi7uLywoCBfkMRS26HzpoPqCMtlmECrXHa6dwQCR+N/uljbuQrjBorZ60snJeekXJDSc0Ulnofxj96NPKHCNji7Tt1WwqtnW0fTriFs8V9eYWC+3lLhGYoYLEGtXT/Xy6sYWtxjCxdkzgZeAn+qxDBHx2B2zXWkkTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185529; c=relaxed/simple;
	bh=EUJpyzCJGAl6nmcdJQ+WZhnWfbd/6L7ySjtgoHNO/X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TumA6r1yRzz3zkV5UcS93ZL0Ip4Htpz2AZ67LIP12c37jeebavGthxv11x6bUE65R86FJW+ZRFTAm6N0/M7DcZhGcZyDaUx/ev1+PxJfo0RPHRse+siEhgqOTPOPO7pw9eHkg2tqW+w2NyKpvQ2wuRcLnuhAAGu869+McyaMI7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVP27bm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTpwRRX4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZVP27bm3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dTpwRRX4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVP27bm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTpwRRX4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZVP27bm3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dTpwRRX4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 293C96765E;
	Tue, 19 May 2026 10:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779185525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCvcFF7ZcdjVnKlZav5NT5Tcv98OueTt0n77yWHP/N4=;
	b=ZVP27bm3T1sMwlXvva2RrUVgLkmNJm4jcwEBruxF00Gy+SQdZoh1AqsxV1/bygpFkbWHXD
	YtpbAODQZczLdiBvhz5PgHV7YKWOfGwCBf1HPkUuqDyvT2f3p6HTqBHugyStQxbfIv8vph
	kuLw72mCfSfFALQmpfC3E4NEceHJZQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779185525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCvcFF7ZcdjVnKlZav5NT5Tcv98OueTt0n77yWHP/N4=;
	b=dTpwRRX4MS8LYrh2gu/4ipKvw7FWWy5g2SaMYUz5hUKOLln1k1JkfK4d3PlmaWh3VSxbG0
	2FEfES5Is9he1/Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779185525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCvcFF7ZcdjVnKlZav5NT5Tcv98OueTt0n77yWHP/N4=;
	b=ZVP27bm3T1sMwlXvva2RrUVgLkmNJm4jcwEBruxF00Gy+SQdZoh1AqsxV1/bygpFkbWHXD
	YtpbAODQZczLdiBvhz5PgHV7YKWOfGwCBf1HPkUuqDyvT2f3p6HTqBHugyStQxbfIv8vph
	kuLw72mCfSfFALQmpfC3E4NEceHJZQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779185525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hCvcFF7ZcdjVnKlZav5NT5Tcv98OueTt0n77yWHP/N4=;
	b=dTpwRRX4MS8LYrh2gu/4ipKvw7FWWy5g2SaMYUz5hUKOLln1k1JkfK4d3PlmaWh3VSxbG0
	2FEfES5Is9he1/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 219DA593A8;
	Tue, 19 May 2026 10:12:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eE4wCHU3DGrIcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:12:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2E9CCA0ADE; Tue, 19 May 2026 12:12:04 +0200 (CEST)
Date: Tue, 19 May 2026 12:12:04 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 03/14] configfs_detach_prep(): pass configfs_dirent
 instead of dentry
Message-ID: <sjzz65u7ur2n3xxj7xzvd6qpvah2hjsczbhkjqs6l75mdsqvsk@6su5f724f3d4>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-4-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-4-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.org.uk:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:22, Al Viro wrote:
> The only thing it uses the argument for is its ->d_fsdata and
> all callers have that already available.
> 
> Note that in the recursive call we are dealing with a (sub)directory
> configfs_dirent, and for those ->s_dentry->d_fsdata points back
> to configfs_dirent itself.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 662dcd7d1bf0..0c071252c9d4 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -516,9 +516,8 @@ static struct dentry * configfs_lookup(struct inode *dir,
>   * If there is an error, the caller will reset the flags via
>   * configfs_detach_rollback().
>   */
> -static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
> +static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry **wait)
>  {
> -	struct configfs_dirent *parent_sd = dentry->d_fsdata;
>  	struct configfs_dirent *sd;
>  	int ret;
>  
> @@ -546,7 +545,7 @@ static int configfs_detach_prep(struct dentry *dentry, struct dentry **wait)
>  			 * Yup, recursive.  If there's a problem, blame
>  			 * deep nesting of default_groups
>  			 */
> -			ret = configfs_detach_prep(sd->s_dentry, wait);
> +			ret = configfs_detach_prep(sd, wait);
>  			if (!ret)
>  				continue;
>  		} else
> @@ -1512,7 +1511,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
>  		 */
>  		ret = sd->s_dependent_count ? -EBUSY : 0;
>  		if (!ret) {
> -			ret = configfs_detach_prep(dentry, &wait);
> +			ret = configfs_detach_prep(sd, &wait);
>  			if (ret)
>  				configfs_detach_rollback(dentry);
>  		}
> @@ -1809,7 +1808,7 @@ void configfs_unregister_group(struct config_group *group)
>  
>  	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
>  	spin_lock(&configfs_dirent_lock);
> -	configfs_detach_prep(dentry, NULL);
> +	configfs_detach_prep(sd, NULL);
>  	spin_unlock(&configfs_dirent_lock);
>  
>  	configfs_detach_group(&group->cg_item);
> @@ -1956,7 +1955,7 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>  	inode_lock_nested(d_inode(dentry), I_MUTEX_CHILD);
>  	mutex_lock(&configfs_symlink_mutex);
>  	spin_lock(&configfs_dirent_lock);
> -	if (configfs_detach_prep(dentry, NULL)) {
> +	if (configfs_detach_prep(sd, NULL)) {
>  		pr_err("Tried to unregister non-empty subsystem!\n");
>  	}
>  	spin_unlock(&configfs_dirent_lock);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
