Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3A37AA79
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922461; cv=none; b=KpxA29UlmZI5lGxx5FlSg9XEdwhcQ2AYdPwHmNIZr30DCwjXkYUvRVhE7Ik2zg9ZvsH1DdY1KNQaXPWKULuc4i65jpZp03QNukMYH2cYvIeLnrvmqXZlJQIEls05daGSSSIn+6pUusOEYsMpUFTFUpv4eYYKfIzl8A8xQfEF7ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922461; c=relaxed/simple;
	bh=1g3lP6pDwst18zyiflR47q/6XO0aVgNaOnO8clA952g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYB22R2uEAAKDnm+qb8XzZ0sfPkIbovPDNAtOjbJpSsER1izfP9kGDA2PrGXXoR2dCQ0Z29wqEOaJNoPhFRj8KSqgoSZzW3HJYyihzYdYjMg7yeBx9jgl2KHBni/ezVFYjQvM01FCwK7AlPGbOd/agyXbKaLj6azTqtd5qDMBb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dF+RZC4D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QNuQnoDN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ax30bfQS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=i9i+zzEq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dF+RZC4D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QNuQnoDN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ax30bfQS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="i9i+zzEq"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 367996AAFA;
	Mon,  8 Jun 2026 12:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922455; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JSEP4ElryDMFRhr9WwxebizbxrmfrNXfAft0DSJ/lk=;
	b=dF+RZC4D0iyufEJpWpnIPfmCY9sJhzD3vMzusQ4+JjOLKw9m4J3zG1/apu5gCEvGYjp+dG
	OYwSRethx77JAn4q7BEIzDuHj3f7Ej0fT/hHHwh6zv9fMbXgeYdl0rbxx7o6Af7lCMzLLP
	0WzgYcSnmTVZudHuxNrIjrJbXaFWAjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922455;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JSEP4ElryDMFRhr9WwxebizbxrmfrNXfAft0DSJ/lk=;
	b=QNuQnoDNS4O+rJU0R4BPZH/rWfoJPeECkQGw1Yg/ZCCRp6sTh4PYT5hGQAgvpxgr3E0neF
	ngs4MJJY4qDKdhAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ax30bfQS;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=i9i+zzEq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922454; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JSEP4ElryDMFRhr9WwxebizbxrmfrNXfAft0DSJ/lk=;
	b=ax30bfQSsJk8ssANZczy8rKU/v74Xk7oUp7yBY/TkGMVPbeTdVW3Lwpmg8sLSYRfxF9ZBE
	yDvZcEM3luMceb1b1vbt27mre1fhVb/hQQGXSPf8lmIutxhRm1tbGaxtDSxFqNwARnwPKY
	nW9AG/cuem0A6XfG5e1CEq9HyOiw5Jk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922454;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+JSEP4ElryDMFRhr9WwxebizbxrmfrNXfAft0DSJ/lk=;
	b=i9i+zzEqlHJJBmfaMVCd2aErCJNVSN6Itu8LmZgB/672Y8e9y1hGjyYbAbCzV62ro/rsyF
	Nml+76z2m1ahEqAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B0E779A7;
	Mon,  8 Jun 2026 12:40:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X9f5B1a4JmrbTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:40:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B9AE1A0923; Mon, 08 Jun 2026 14:40:53 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:40:53 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 02/18] configfs: fix lockless traversals of
 ->s_children
Message-ID: <p6ald26ubqsm7fy2kdnyleuuuto6763foan5nvrimeyedn36ej@myqqctog3uyc>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-5-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-5-viro@zeniv.linux.org.uk>
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
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,linux.org.uk:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 367996AAFA
X-Spam-Score: -4.01

On Wed 03-06-26 08:47:58, Al Viro wrote:
> Having the parent directory locked protects entries from removal
> by another thread, but it does *not* protect cursors from being
> moved around by lseek() - or freed, for that matter.
> 
> Fixes: 6f6107640625 ("configfs: Introduce configfs_dirent_lock")
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 54 +++++++++++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index e84483a0836d..eb991b2a9c34 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -235,15 +235,16 @@ static int configfs_dirent_exists(struct dentry *dentry)
>  	const unsigned char *new = dentry->d_name.name;
>  	struct configfs_dirent *sd;
>  
> +	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
>  		if (sd->s_element) {
> -			const unsigned char *existing = configfs_get_name(sd);
> -			if (strcmp(existing, new))
> -				continue;
> -			else
> +			if (strcmp(configfs_get_name(sd), new) == 0) {
> +				spin_unlock(&configfs_dirent_lock);
>  				return -EEXIST;
> +			}
>  		}
>  	}
> +	spin_unlock(&configfs_dirent_lock);
>  
>  	return 0;
>  }
> @@ -575,11 +576,28 @@ static void configfs_detach_rollback(struct dentry *dentry)
>  			configfs_detach_rollback(sd->s_dentry);
>  }
>  
> +/*
> + * Find the next non-cursor.  configfs_dirent_lock held by caller.
> + */
> +static struct configfs_dirent *next_dirent(struct configfs_dirent *parent,
> +					   struct configfs_dirent *last)
> +{
> +	struct configfs_dirent *s;
> +
> +	s = list_prepare_entry(last, &parent->s_children, s_sibling);
> +
> +	list_for_each_entry_continue(s, &parent->s_children, s_sibling) {
> +		if (s->s_element)
> +			return s;
> +	}
> +	return NULL;
> +}
> +
>  static void detach_attrs(struct config_item * item)
>  {
>  	struct dentry * dentry = dget(item->ci_dentry);
> -	struct configfs_dirent * parent_sd;
> -	struct configfs_dirent * sd, * tmp;
> +	struct configfs_dirent *parent_sd;
> +	struct configfs_dirent *sd, *next;
>  
>  	if (!dentry)
>  		return;
> @@ -588,15 +606,19 @@ static void detach_attrs(struct config_item * item)
>  		 dentry->d_name.name);
>  
>  	parent_sd = dentry->d_fsdata;
> -	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
> -		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
> +
> +	spin_lock(&configfs_dirent_lock);
> +	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
> +		next = next_dirent(parent_sd, sd);
> +		if (!(sd->s_type & CONFIGFS_NOT_PINNED))
>  			continue;
> -		spin_lock(&configfs_dirent_lock);
>  		list_del_init(&sd->s_sibling);
>  		spin_unlock(&configfs_dirent_lock);
>  		configfs_drop_dentry(sd, dentry);
>  		configfs_put(sd);
> +		spin_lock(&configfs_dirent_lock);
>  	}
> +	spin_unlock(&configfs_dirent_lock);
>  
>  	/**
>  	 * Drop reference from dget() on entrance.
> @@ -655,18 +677,20 @@ static void detach_groups(struct config_group *group)
>  	struct dentry * dentry = dget(group->cg_item.ci_dentry);
>  	struct dentry *child;
>  	struct configfs_dirent *parent_sd;
> -	struct configfs_dirent *sd, *tmp;
> +	struct configfs_dirent *sd, *next;
>  
>  	if (!dentry)
>  		return;
>  
>  	parent_sd = dentry->d_fsdata;
> -	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
> -		if (!sd->s_element ||
> -		    !(sd->s_type & CONFIGFS_USET_DEFAULT))
> +	spin_lock(&configfs_dirent_lock);
> +	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
> +		next = next_dirent(parent_sd, sd);
> +		if (!(sd->s_type & CONFIGFS_USET_DEFAULT))
>  			continue;
>  
>  		child = sd->s_dentry;
> +		spin_unlock(&configfs_dirent_lock);
>  
>  		inode_lock(d_inode(child));
>  
> @@ -678,7 +702,9 @@ static void detach_groups(struct config_group *group)
>  
>  		d_delete(child);
>  		dput(child);
> +		spin_lock(&configfs_dirent_lock);
>  	}
> +	spin_unlock(&configfs_dirent_lock);
>  
>  	/**
>  	 * Drop reference from dget() on entrance.
> @@ -1130,6 +1156,7 @@ configfs_find_subsys_dentry(struct configfs_dirent *root_sd,
>  	struct configfs_dirent *p;
>  	struct configfs_dirent *ret = NULL;
>  
> +	spin_lock(&configfs_dirent_lock);
>  	list_for_each_entry(p, &root_sd->s_children, s_sibling) {
>  		if (p->s_type & CONFIGFS_DIR &&
>  		    p->s_element == subsys_item) {
> @@ -1137,6 +1164,7 @@ configfs_find_subsys_dentry(struct configfs_dirent *root_sd,
>  			break;
>  		}
>  	}
> +	spin_unlock(&configfs_dirent_lock);
>  
>  	return ret;
>  }
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
