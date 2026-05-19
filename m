Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEF8233949
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779187344; cv=none; b=XWrj2+FzzaW6XVKNOillybKmXSwThPjkFPY9bUNs2E2eJ9fRirqEe7m9etSzUI4UwsgT/6MuukQJnhOhoUbhbu8qid0+tGpULU8tDv6T6f69lfSNq2ekuo0JPA+EwRUwpiCfgbv1cIyEvhvhxx1+psizp+g3NJlU16uHfeyEWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779187344; c=relaxed/simple;
	bh=4xVDGSL1SqEz7ols5WV1Sr1QItUuXL0kK59av/l866A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DJfqC0pePKY6jbFopnrc1pTbNEtSJzIMap+AkUZjw82WtLrrG6Ru1K+A64myEE4sRRD5pmo9qV/230gVbrAzrqHnVoVyG6M85hakDJmYy+ft0P7T6hP6oegy6qNUMusLvJtCoWqd1zEitk+ceCel+GMy0vn8rGU7C879KGBxtdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+jCItpd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tm8SQO+E; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+jCItpd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tm8SQO+E; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+jCItpd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tm8SQO+E";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+jCItpd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tm8SQO+E"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC48D67FDD;
	Tue, 19 May 2026 10:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779187340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kasJYge5Cpr2AOGK48Xaz95dYSLNLSWjfJ48f6kA05c=;
	b=b+jCItpdw3HrWE6mc7NP4Diw5aF8PjtGAthWnrRXsKuaVz2w5RGegqOS0+ImB14RfIpAyO
	hJ1dkUelvsXwwaV0qVSxXi1n9kj0dJdh+8eAvyvmg9hW5nqEN7XODhGOjJehC8mC8+9SOS
	gnwZDRhcaBse3G55i/SWxXZd74VoZ+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779187340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kasJYge5Cpr2AOGK48Xaz95dYSLNLSWjfJ48f6kA05c=;
	b=tm8SQO+EccI9LJH+8lxFIw6xhs6w7p/Kk4jCh6LaiDJ3Br6h6dQqyEkgLTp3O4n1E9hiDt
	gEmTjTmQJJRIT8Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779187340; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kasJYge5Cpr2AOGK48Xaz95dYSLNLSWjfJ48f6kA05c=;
	b=b+jCItpdw3HrWE6mc7NP4Diw5aF8PjtGAthWnrRXsKuaVz2w5RGegqOS0+ImB14RfIpAyO
	hJ1dkUelvsXwwaV0qVSxXi1n9kj0dJdh+8eAvyvmg9hW5nqEN7XODhGOjJehC8mC8+9SOS
	gnwZDRhcaBse3G55i/SWxXZd74VoZ+U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779187340;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kasJYge5Cpr2AOGK48Xaz95dYSLNLSWjfJ48f6kA05c=;
	b=tm8SQO+EccI9LJH+8lxFIw6xhs6w7p/Kk4jCh6LaiDJ3Br6h6dQqyEkgLTp3O4n1E9hiDt
	gEmTjTmQJJRIT8Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A32B7593A8;
	Tue, 19 May 2026 10:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D+rNJ4w+DGq4EQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:42:20 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7880CA0ADE; Tue, 19 May 2026 12:42:19 +0200 (CEST)
Date: Tue, 19 May 2026 12:42:19 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 09/14] configfs_remove_dir(), detach_attrs(): switch
 to passing dentry
Message-ID: <wvxfefy3ope7co3qh5q3x337vekky5qaehjsbtomyw5oljdpvw@46fq3zzcyyvm>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-10-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-10-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,linux.org.uk:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:28, Al Viro wrote:
> ... and deal with grabbing/dropping it in the sole caller.
> After that configfs_remove_dir() becomes an unconditional call of remove_dir(),
> so we can fold them together.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 57 ++++++++++++++++-------------------------------
>  1 file changed, 19 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 395270cc3710..deb18689aa0a 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -394,7 +394,18 @@ int configfs_create_link(struct configfs_dirent *target, struct dentry *parent,
>  	return PTR_ERR(inode);
>  }
>  
> -static void remove_dir(struct dentry * d)
> +/**
> + * configfs_remove_dir - remove an config_item's directory.
> + * @d:	dentry we're removing.
> + *
> + * The only thing special about this is that we remove any files in
> + * the directory before we remove the directory, and we've inlined
> + * what used to be configfs_rmdir() below, instead of calling separately.
> + *
> + * Caller holds the mutex of the item's inode
> + */
> +
> +static void configfs_remove_dir(struct dentry *d)
>  {
>  	struct dentry * parent = dget(d->d_parent);
>  
> @@ -414,31 +425,6 @@ static void remove_dir(struct dentry * d)
>  	dput(parent);
>  }
>  
> -/**
> - * configfs_remove_dir - remove an config_item's directory.
> - * @item:	config_item we're removing.
> - *
> - * The only thing special about this is that we remove any files in
> - * the directory before we remove the directory, and we've inlined
> - * what used to be configfs_rmdir() below, instead of calling separately.
> - *
> - * Caller holds the mutex of the item's inode
> - */
> -
> -static void configfs_remove_dir(struct config_item * item)
> -{
> -	struct dentry * dentry = dget(item->ci_dentry);
> -
> -	if (!dentry)
> -		return;
> -
> -	remove_dir(dentry);
> -	/**
> -	 * Drop reference from dget() on entrance.
> -	 */
> -	dput(dentry);
> -}
> -
>  static struct dentry * configfs_lookup(struct inode *dir,
>  				       struct dentry *dentry,
>  				       unsigned int flags)
> @@ -573,15 +559,11 @@ static void configfs_detach_rollback(struct configfs_dirent *parent_sd)
>  			configfs_detach_rollback(sd);
>  }
>  
> -static void detach_attrs(struct config_item * item)
> +static void detach_attrs(struct dentry *dentry)
>  {
> -	struct dentry * dentry = dget(item->ci_dentry);
>  	struct configfs_dirent * parent_sd;
>  	struct configfs_dirent * sd, * tmp;
>  
> -	if (!dentry)
> -		return;
> -
>  	pr_debug("configfs %s: dropping attrs for  dir\n",
>  		 dentry->d_name.name);
>  
> @@ -595,11 +577,6 @@ static void detach_attrs(struct config_item * item)
>  		configfs_drop_dentry(sd, dentry);
>  		configfs_put(sd);
>  	}
> -
> -	/**
> -	 * Drop reference from dget() on entrance.
> -	 */
> -	dput(dentry);
>  }
>  
>  static int populate_attrs(struct config_item *item)
> @@ -825,8 +802,12 @@ static void link_group(struct config_group *parent_group, struct config_group *g
>  /* Caller holds the mutex of the item's inode */
>  static void configfs_detach_item(struct config_item *item)
>  {
> -	detach_attrs(item);
> -	configfs_remove_dir(item);
> +	struct dentry *dentry = dget(item->ci_dentry);
> +	if (dentry) {
> +		detach_attrs(dentry);
> +		configfs_remove_dir(dentry);
> +		dput(dentry);
> +	}
>  }
>  
>  /*
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
