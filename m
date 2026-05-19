Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E83EFFBC
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186409; cv=none; b=C3hQCJkTv7JHUgH8OFBDzgAgvORZkubLkmdylaPxI94ulAsuvuARQFJblEGtSZAABdhF0jMwts3vMV0O8Z4hS2E2f926Q23A5sDO4ZgtHg1JtggIgEROfkkUkydC2gNpAEXdygDIt7QBR69uCQ9dqAz/z1did1+JZk1KnUOA+Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186409; c=relaxed/simple;
	bh=NXGyNOkgeO0TkQXcwrmojWx5cNaqEfCMo40++6fyCIM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nAD8S/JpuUSMah24TGdkyJ8EBvmhQjKDl5T6CZaBK9j+lS1dZiXCFlMSQ90j+WurNN/JiMgf+dP4r4jgvbfWHdmd414VPo4at2+LEC4N/uq4rj38VWQnw3HhhDZU+2AwyYvTiW/EZoGRr3rV59naUQ/H5przc7iArB6ho+RaL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V+riU+3A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TAourr5E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=V+riU+3A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=TAourr5E; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V+riU+3A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TAourr5E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="V+riU+3A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="TAourr5E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26B436B07F;
	Tue, 19 May 2026 10:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiYj2emyGtm0umTlI1qxt/FeUC+rVjnBRye2l59MD0=;
	b=V+riU+3AcuKgg5CdxOZ3ZOh29ikqXZGFXZAI/vvqJRalXZhdnxXWDD9brC8UYvqtumcPYW
	nEoaI/r18zZ5r3C1PvFt99UKMM2+bHi8FY2a6/WEaMrIzkrbTpbQasdvM5qG7diGKELInp
	WLX+IyKNykCe+X/h86K3tjXUZLDS970=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiYj2emyGtm0umTlI1qxt/FeUC+rVjnBRye2l59MD0=;
	b=TAourr5EstP16YILxsF24oyuobKDA+07PRA9nqJam2ggLawrXnNkGaM2R5NJYUen0+nhLN
	2L4h4zoNPCDNw8Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiYj2emyGtm0umTlI1qxt/FeUC+rVjnBRye2l59MD0=;
	b=V+riU+3AcuKgg5CdxOZ3ZOh29ikqXZGFXZAI/vvqJRalXZhdnxXWDD9brC8UYvqtumcPYW
	nEoaI/r18zZ5r3C1PvFt99UKMM2+bHi8FY2a6/WEaMrIzkrbTpbQasdvM5qG7diGKELInp
	WLX+IyKNykCe+X/h86K3tjXUZLDS970=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186406;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vWiYj2emyGtm0umTlI1qxt/FeUC+rVjnBRye2l59MD0=;
	b=TAourr5EstP16YILxsF24oyuobKDA+07PRA9nqJam2ggLawrXnNkGaM2R5NJYUen0+nhLN
	2L4h4zoNPCDNw8Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F276593A8;
	Tue, 19 May 2026 10:26:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V4qTB+Y6DGqpAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:26:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69D4FA0ADE; Tue, 19 May 2026 12:26:41 +0200 (CEST)
Date: Tue, 19 May 2026 12:26:41 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 06/14] configfs_detach_rollback(): pass
 configfs_dirent instead of dentry
Message-ID: <ncejkfwzfs4h23hcxvnok6bidufgkkim4vwtnvbxf4fnkrp2sb@ghyhk5ejd2jv>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-7-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-7-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,linux.org.uk:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 19-05-26 08:06:25, Al Viro wrote:
> same story as with configfs_detach_prep() this function is undoing.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index e4b7eaa58d65..726c56d1772d 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -562,16 +562,15 @@ static int configfs_detach_prep(struct configfs_dirent *parent_sd, struct dentry
>   * Walk the tree, resetting CONFIGFS_USET_DROPPING wherever it was
>   * set.
>   */
> -static void configfs_detach_rollback(struct dentry *dentry)
> +static void configfs_detach_rollback(struct configfs_dirent *parent_sd)
>  {
> -	struct configfs_dirent *parent_sd = dentry->d_fsdata;
>  	struct configfs_dirent *sd;
>  
>  	parent_sd->s_type &= ~CONFIGFS_USET_DROPPING;
>  
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling)
>  		if (sd->s_type & CONFIGFS_USET_DEFAULT)
> -			configfs_detach_rollback(sd->s_dentry);
> +			configfs_detach_rollback(sd);
>  }
>  
>  static void detach_attrs(struct config_item * item)
> @@ -1509,7 +1508,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
>  		if (!ret) {
>  			ret = configfs_detach_prep(sd, &wait);
>  			if (ret)
> -				configfs_detach_rollback(dentry);
> +				configfs_detach_rollback(sd);
>  		}
>  		spin_unlock(&configfs_dirent_lock);
>  		mutex_unlock(&configfs_symlink_mutex);
> @@ -1530,7 +1529,7 @@ static int configfs_rmdir(struct inode *dir, struct dentry *dentry)
>  	frag = sd->s_frag;
>  	if (down_write_killable(&frag->frag_sem)) {
>  		spin_lock(&configfs_dirent_lock);
> -		configfs_detach_rollback(dentry);
> +		configfs_detach_rollback(sd);
>  		spin_unlock(&configfs_dirent_lock);
>  		config_item_put(parent_item);
>  		return -EINTR;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
