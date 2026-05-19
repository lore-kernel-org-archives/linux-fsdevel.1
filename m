Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BFB43FE648
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186342; cv=none; b=hocBMP2gg/wS5EJ8zUgUaNmzwdGDoXLmhZ0DzqV2D1V0DIhDMTv4E2d0ek9Zmo2g3Z/sKQh479My6rqchAC/LTLD7C2NgcIe5cLzBfT68Aq+jOH6k/9CLW2QMcqvE8kgSVtmrKOs4PrLZRX4q3O8Svatw6ethEkV8EpFUa8Vvns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186342; c=relaxed/simple;
	bh=0aJc69pbKBaUJpkmZO7I+O1dD1rBHV0Z2aavW3VkdlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8Rea07OqXH0bEbSj65m+xXiokupVy+Nq7SrrfW4o5Cgr172cHY9ggB9tY+fRo6Kdlld0uXiinvPhBNmd2exP1ch6lc0X6AESemJy8geSaRWuDhDcOirTUHQG5v7O7tjwJv/vEL2l0U/sOMVLXMSpu2s6hmljvX9F4SE0tl2Pw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWX09AbD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgLrb+3q; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dWX09AbD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HgLrb+3q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWX09AbD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgLrb+3q";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dWX09AbD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HgLrb+3q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6107867FBE;
	Tue, 19 May 2026 10:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRe0wrY81wkfRgD6n4GXgQOQIdKh7VsFq26f+lxDKLo=;
	b=dWX09AbDss5DEuEMJMiB1qvO6WpM4iLmbRurIHhp3nHLE6LZHFj4oo0f2UB2zqM0Yu2fd4
	+JFfBYD6RQs496LoKc2IPvvTK2T2MmRqjIur82cMcnAKiI3aqoQeYyiSbWRhFIOlsYAvwr
	fRkULKFm+9/yU4BsJAVPF3Y5fH+4xYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRe0wrY81wkfRgD6n4GXgQOQIdKh7VsFq26f+lxDKLo=;
	b=HgLrb+3q+Aeq+zeTAYWUsBunqwbT9HOwwl+O9o7MedMrn94bh/DsKGg0Mf8yc5q8TES4tT
	5f9MCqAJMRmE8HDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRe0wrY81wkfRgD6n4GXgQOQIdKh7VsFq26f+lxDKLo=;
	b=dWX09AbDss5DEuEMJMiB1qvO6WpM4iLmbRurIHhp3nHLE6LZHFj4oo0f2UB2zqM0Yu2fd4
	+JFfBYD6RQs496LoKc2IPvvTK2T2MmRqjIur82cMcnAKiI3aqoQeYyiSbWRhFIOlsYAvwr
	fRkULKFm+9/yU4BsJAVPF3Y5fH+4xYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186339;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iRe0wrY81wkfRgD6n4GXgQOQIdKh7VsFq26f+lxDKLo=;
	b=HgLrb+3q+Aeq+zeTAYWUsBunqwbT9HOwwl+O9o7MedMrn94bh/DsKGg0Mf8yc5q8TES4tT
	5f9MCqAJMRmE8HDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57F8A593A8;
	Tue, 19 May 2026 10:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vV53FaM6DGpKAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:25:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B968A0ADE; Tue, 19 May 2026 12:25:34 +0200 (CEST)
Date: Tue, 19 May 2026 12:25:34 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 05/14] configfs_do_depend_item(): pass
 configfs_dirent instead of dentry
Message-ID: <uowa2wobxwhpjfdawg7llfjo7qs4aloipqfpekvfoke5m55p7n@uqwz3bsnftpf>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-6-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-6-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.org.uk:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:24, Al Viro wrote:
> Again, the only thing it uses the argument for is its ->d_fsdata
> and callers already have that - as the matter of fact, they are
> passing ->s_dentry of that configfs_dirent, so that the function
> could get it back as ->d_fsdata of that.  With nothing else in
> dentry even looked at...
> 
> configfs_dirent in question is a directory one - in this case those
> are subdirectories of root (aka roots of "subsystem" trees).
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 5219c4fd527e..e4b7eaa58d65 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -1093,7 +1093,7 @@ static int configfs_depend_prep(struct configfs_dirent *sd,
>  	return ret;
>  }
>  
> -static int configfs_do_depend_item(struct dentry *subsys_dentry,
> +static int configfs_do_depend_item(struct configfs_dirent *subsys_sd,
>  				   struct config_item *target)
>  {
>  	struct configfs_dirent *p;
> @@ -1101,7 +1101,7 @@ static int configfs_do_depend_item(struct dentry *subsys_dentry,
>  
>  	spin_lock(&configfs_dirent_lock);
>  	/* Scan the tree, return 0 if found */
> -	ret = configfs_depend_prep(subsys_dentry->d_fsdata, target);
> +	ret = configfs_depend_prep(subsys_sd, target);
>  	if (ret)
>  		goto out_unlock_dirent_lock;
>  
> @@ -1167,7 +1167,7 @@ int configfs_depend_item(struct configfs_subsystem *subsys,
>  	}
>  
>  	/* Ok, now we can trust subsys/s_item */
> -	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
> +	ret = configfs_do_depend_item(subsys_sd, target);
>  
>  out_unlock_fs:
>  	inode_unlock(d_inode(root));
> @@ -1269,7 +1269,7 @@ int configfs_depend_item_unlocked(struct configfs_subsystem *caller_subsys,
>  	}
>  
>  	/* Now we can execute core of depend item */
> -	ret = configfs_do_depend_item(subsys_sd->s_dentry, target);
> +	ret = configfs_do_depend_item(subsys_sd, target);
>  
>  	if (target_subsys != caller_subsys)
>  out_root_unlock:
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
