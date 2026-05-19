Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979740960A
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196915; cv=none; b=GuDYo21fC/+Q4/HUTvARlhfw3r+9CApuQXCqhh6cwcN98+pqEslop1dEPHL+JqADl+x4oNGEZWQtZFpNAqMXPHyHZmPuWOqeJj73xL6csQxisvR10djmkchUJ2/pSzafukE8HO3t9bR5kouHuKERkYi5lU6P7lN7JoFBvT6K1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196915; c=relaxed/simple;
	bh=BKOwQlhk/XNOgNSARWw/BVPKB54BHxWS//RkeBp4S88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fiVIC2MDObFXseXJ793Aw3csdRp/vtc1lau8maIzCuOYiZsy0vaSlLdAhmPTrTH3sMkrg73qDOOTXJwLZiau8EK8SFYZuV8PwTgneQDOO3qoB11IIWEM9VRIkdgPpqkK1E6KeYjm8V8JXqDj/XUncEPE5sVFYrEVENf4XY4UtFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N16oYhUn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vY6DtcpW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gsXhAmg3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6eKg/Ap+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N16oYhUn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vY6DtcpW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gsXhAmg3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6eKg/Ap+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CB7C96814A;
	Tue, 19 May 2026 13:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779196911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AJtuKf0vK4bQut7vEuw9KdGIqfAV5UyH3eMVVOr6EU=;
	b=N16oYhUnIoefG3CsCHE7L+jI1q8znWRvv+2HCDJMs7YVOfy0E11gN6DSw5wd/rvTCoZRkC
	uNuberVoCCS3xHCIZmUQD/gccEYWqajUW0o34cDHgllQZt5kUO/qdIcJwA/tSl3FD+WuJc
	JhaH954lcYR25agBI5DoFoRzAHNCXw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779196911;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AJtuKf0vK4bQut7vEuw9KdGIqfAV5UyH3eMVVOr6EU=;
	b=vY6DtcpWj1BTEEVm5h4St5Hg8PLEpB8Deley+iOIEuWVpkmhCHyyH8vHaVPfX/LD9ocNc4
	Lsmrh7oPPWSTKrAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779196907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AJtuKf0vK4bQut7vEuw9KdGIqfAV5UyH3eMVVOr6EU=;
	b=gsXhAmg3k1rrvjwnLW9Remm7EvXSx0hkZDtdw17wl3uG/4lrjq8FVYpVSOYSsX2dMOvZM2
	8pdceKeMwbJR3KTnfqh9vg93dioTCLOMqzo3Eq7i6r1f/PZIhI06cO7qeAn+djGbrGpaAv
	ofcRd9nulk1tTio/uTqZF7O/xHd5sLg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779196907;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5AJtuKf0vK4bQut7vEuw9KdGIqfAV5UyH3eMVVOr6EU=;
	b=6eKg/Ap+aXDaR0iAGK+yqYbQjMsh3KTwvhKtlQOyUopZRcF6Ez+TA+ABmnXCBwdG8NF4CS
	kaA40yCYHUp232Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3258593A8;
	Tue, 19 May 2026 13:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1bKdL+tjDGqGMQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 13:21:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EDE3BA0ADE; Tue, 19 May 2026 15:21:38 +0200 (CEST)
Date: Tue, 19 May 2026 15:21:38 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 11/14] configfs: dentry refcount needs to be pinned
 only once
Message-ID: <roxbdqubwemwa6hk7ihyln6uk67wrjcyn5fynlfdbylh4mezim@secgpywhkfst>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-12-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-12-viro@zeniv.linux.org.uk>
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 19-05-26 08:06:30, Al Viro wrote:
> currently we have a weird situation where
> 	* symlinks and roots of subtrees created by mkdir are pinned once
> 	* subdirectories of subtrees created by mkdir are pinned twice
> 	* roots of subtrees created by register_{group,subsystem} are pinned
> twice.
> 
> It makes things harder to follow for no good reason.  The goal is to
> encapsulate the unbalanced dget/dput into d_{make,discard}_persisitent()
> and, preferably, allow a use of simple_recursive_removal() or analogue
> thereof.  So let's regularize that and pin things only once.
> 
> create_default_group() and configfs_register_subsystem() don't need to
> keep their reference around on success - configfs_create_dir() has pinned
> the sucker already.  So we can drop the reference passed to
> configfs_create_dir() (via configfs_attach_group(), etc.) both on success
> and on failure.  On the removal side we no longer have the double references,
> so we need an explicit dget() to compensate.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 39a496749dc2..6d9c6a5b17ff 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -635,7 +635,7 @@ static void detach_groups(struct dentry *dentry)
>  		    !(sd->s_type & CONFIGFS_USET_DEFAULT))
>  			continue;
>  
> -		child = sd->s_dentry;
> +		child = dget(sd->s_dentry);
>  
>  		inode_lock(d_inode(child));
>  
> @@ -683,8 +683,8 @@ static int create_default_group(struct config_group *parent_group,
>  		} else {
>  			BUG_ON(d_inode(child));
>  			d_drop(child);
> -			dput(child);
>  		}
> +		dput(child);
>  	}
>  
>  	return ret;
> @@ -1754,7 +1754,7 @@ EXPORT_SYMBOL(configfs_register_group);
>  void configfs_unregister_group(struct config_group *group)
>  {
>  	struct configfs_subsystem *subsys = group->cg_subsys;
> -	struct dentry *dentry = group->cg_item.ci_dentry;
> +	struct dentry *dentry = dget(group->cg_item.ci_dentry);
>  	struct dentry *parent = group->cg_item.ci_parent->ci_dentry;
>  	struct configfs_dirent *sd = dentry->d_fsdata;
>  	struct configfs_fragment *frag = sd->s_frag;
> @@ -1869,12 +1869,12 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
>  		if (err) {
>  			BUG_ON(d_inode(dentry));
>  			d_drop(dentry);
> -			dput(dentry);
>  		} else {
>  			spin_lock(&configfs_dirent_lock);
>  			configfs_dir_set_ready(dentry->d_fsdata);
>  			spin_unlock(&configfs_dirent_lock);
>  		}
> +		dput(dentry);
>  	}
>  
>  	inode_unlock(d_inode(root));
> @@ -1893,7 +1893,7 @@ int configfs_register_subsystem(struct configfs_subsystem *subsys)
>  void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
>  {
>  	struct config_group *group = &subsys->su_group;
> -	struct dentry *dentry = group->cg_item.ci_dentry;
> +	struct dentry *dentry = dget(group->cg_item.ci_dentry);
>  	struct dentry *root = dentry->d_sb->s_root;
>  	struct configfs_dirent *sd = dentry->d_fsdata;
>  	struct configfs_fragment *frag = sd->s_frag;
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
