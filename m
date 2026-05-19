Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE183E1220
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 09:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184763; cv=none; b=tM9lR9wU/1g/IWz9h2e6ErLHjg1Ntkdtsp+PrCggY9xYG8/nBoBfnFq4L4zPSrbnpK+/W4S6s0doWH10ZHGn+SJ6uYdQSrnWESQOesSuNN8U8e4wFJo0WAjDrGAiFLpgPUcDxjuWlhG8/1j6pMUmBzaykPAIL6sKfjn5BWZKom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184763; c=relaxed/simple;
	bh=1MO+rp5CuniS5PZXEYcldJVuqsHMyIbw16Zv8Vfdom0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBj8omHCH6vy2uQ3/AWM8P+mBwxJuUPZ6MhWaRJFX6JBb58YXgs4T0cwHWpuHohXgH2Wyz0DfATfIB3mwzZOXjOp3yb3axQEnDxbbFdwh763jrWWipDDWxa00c1e4JI9nTxfhcPY46yYul6pviFBncYE8XlVyE1pmjTbbhkYL40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=FLE7o/9Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gBwCgDrp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oUGjkDI3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fBJiMV7T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="FLE7o/9Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gBwCgDrp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oUGjkDI3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fBJiMV7T"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 913B86398A;
	Tue, 19 May 2026 09:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779184760; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6wvy2wUXWphJmL5J7Lq9FnTULvXrYUfFd9su2u2SNw=;
	b=FLE7o/9QO4BvskPKaBS+9KOsF+C6TwZCEBCXDlMUOvR3PPoByI/JguIt7RJ/jUq0qtFEhp
	45PFFX1vxYJ0EvpT7uEDLde/q+rG9JhbPTE1mJiGBv2+ujJCIjI+hbJnqPn4ZxMNl4Fo50
	M6tzyZoUa4xCzj48V6pzkhytDdrkcHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779184760;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6wvy2wUXWphJmL5J7Lq9FnTULvXrYUfFd9su2u2SNw=;
	b=gBwCgDrpqIE2ltbqvr+ZrkF4bdLQkHKqXvQg8/ymhWHl6Bi3i+QorkGO3u5RvAaOyBEsgp
	NimaQdgkz+XC2eBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oUGjkDI3;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fBJiMV7T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779184756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6wvy2wUXWphJmL5J7Lq9FnTULvXrYUfFd9su2u2SNw=;
	b=oUGjkDI3cMVrER627pBkkFU4+HPdVdVTrlladE0jTsjxC8yTeSsY04R0PgA1cwa6WeqytN
	ZorX4joiNZ0oExUn5Aj28J7pXuBOVgLufP/SxZ4W/ipkgaDlpEJ7f8aeyAqnJH8GBG8SvT
	4VuZ8KcGekDifrVhSYtSiiMSZoI5Ks4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779184756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=f6wvy2wUXWphJmL5J7Lq9FnTULvXrYUfFd9su2u2SNw=;
	b=fBJiMV7TSdFf0tbNZlYX2U/5QRB8GQrEid4yDx7XGbdVsMaabg5NZvnSyEv3i9P2OIhJnV
	wMqgXc4a7fw0MLBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 89B7E593B1;
	Tue, 19 May 2026 09:59:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bW+1IXQ0DGpTZgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 09:59:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4008FA0ADE; Tue, 19 May 2026 11:59:11 +0200 (CEST)
Date: Tue, 19 May 2026 11:59:11 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 02/14] configfs_mkdir(): use
 take_dentry_name_snapshot()
Message-ID: <z24x5fk4aqkqnqjpknakkblzrvinaasejexoredgkeedii5u6u@veugaagjjnq4>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-3-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-3-viro@zeniv.linux.org.uk>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.org.uk:email]
X-Rspamd-Queue-Id: 913B86398A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Tue 19-05-26 08:06:21, Al Viro wrote:
> Note that neither ->make_group() nor ->make_item() are allowed to modify
> the string passed to them - the argument is const char *.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index e84483a0836d..662dcd7d1bf0 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1301,7 +1301,11 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	const struct config_item_type *type;
>  	struct module *subsys_owner = NULL, *new_item_owner = NULL;
>  	struct configfs_fragment *frag;
> -	char *name;
> +	struct name_snapshot n;
> +	const char *name;
> +
> +	take_dentry_name_snapshot(&n, dentry);
> +	name = n.name.name;
>  
>  	sd = dentry->d_parent->d_fsdata;
>  
> @@ -1353,14 +1357,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  		goto out_put;
>  	}
>  
> -	name = kmalloc(dentry->d_name.len + 1, GFP_KERNEL);
> -	if (!name) {
> -		ret = -ENOMEM;
> -		goto out_subsys_put;
> -	}
> -
> -	snprintf(name, dentry->d_name.len + 1, "%s", dentry->d_name.name);
> -
>  	mutex_lock(&subsys->su_mutex);
>  	if (type->ct_group_ops->make_group) {
>  		group = type->ct_group_ops->make_group(to_config_group(parent_item), name);
> @@ -1382,7 +1378,6 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	}
>  	mutex_unlock(&subsys->su_mutex);
>  
> -	kfree(name);
>  	if (ret) {
>  		/*
>  		 * If ret != 0, then link_obj() was never called.
> @@ -1469,6 +1464,7 @@ static struct dentry *configfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
>  	put_fragment(frag);
>  
>  out:
> +	release_dentry_name_snapshot(&n);
>  	return ERR_PTR(ret);
>  }
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
