Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76C6233957
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186572; cv=none; b=I8iRlravkIhO9fY/ghsvVWKDTOjrKeAcHRr764j1xUrBKAtuUCTjIkPHh6PDcpz+e8fC7Wgr4i1RO1K+rKlhY7nG2X7Gp05Fye3RlJUgXVZ0KJ/qbzX+2AREFt5tY3SzGH5XGXY4jJXmegPUFBGR8D+EPt6gUPQyhXSHzI3EoN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186572; c=relaxed/simple;
	bh=puDnhikVnCnb9ygC5xaWp5bszxvQQMezH5RT6HNRaek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSKIgkkFt6KQRkMdqQ5s7YHnanboPWuf1fqFAI6uGmNB+OtZyVVC5YyAr2Ye0j7NzntLtlsRU8qWa1Rmm/B3q+uoHbjGzeZTTO1VOPorBz7MkVUUfnFsmA3XG3i/wW28Y4KOnf9PuVNAjTs6ZXxoYQOQkMbRZaHuL5hlhaYs/Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KC1+SaVN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gLP8szck; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zaYpRzfH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FFOMCQvt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KC1+SaVN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gLP8szck";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zaYpRzfH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FFOMCQvt"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1871366E79;
	Tue, 19 May 2026 10:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw75la/7eOHIHDidLM5X6GGNhCRmZeRQv/vRjBCs8fc=;
	b=KC1+SaVNjJuqTpcwoAS2kC/BfUPey7rqLyZPBjqxlZBFtGmB/UvbMcoS/t/ktJoZaewKqr
	UctVx5LKJ4yWCS/v/WfpYFhG4S8ek2jUtH67t5mwjbIeKUXiLsoW6Lx+2IbN+nIQqUi0rs
	KIc2tT0YPuN4CZ9g3Z3MstvT8NLwT6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw75la/7eOHIHDidLM5X6GGNhCRmZeRQv/vRjBCs8fc=;
	b=gLP8szckTfEYsVvBTOUlbRQB6ltlP5pFWAt1IY9Qfngjw3zfxrTlvDoZEkHO5+/RxFSL4a
	Kgl52Tx50gB97eBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw75la/7eOHIHDidLM5X6GGNhCRmZeRQv/vRjBCs8fc=;
	b=zaYpRzfHJqtWvwX6F1v9+1Xi56SQTkBd6Yh9h9yyQsBwLcCO9Sd6GzWuiJSjfW7gLXcdoh
	RAjtPUxPmap1juFx2AwWhGt1Paz3sH0LXDmcRvVl0XFMcmAEAS+uPK80LZy28+GkCR0Fmy
	yRTDpXPOGtJ82jA4YilYRmEMnXReik0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zw75la/7eOHIHDidLM5X6GGNhCRmZeRQv/vRjBCs8fc=;
	b=FFOMCQvtbLWZcwJEW+0AuaINzwQA2aTK3+zYOHQimtFx9FHg2tYYvty9+umrzxVNJYNphv
	nbD3L238SflZ77DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11092593A8;
	Tue, 19 May 2026 10:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K1UlBIU7DGrpBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:29:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DDB37A0ADE; Tue, 19 May 2026 12:29:19 +0200 (CEST)
Date: Tue, 19 May 2026 12:29:19 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 07/14] populate_group(): move cleanup on failure to
 the sole caller
Message-ID: <fos2wksmzfwteubsncjltcmond7qjdwenxgcdqclh2jwvpex2y@vrgzdvkk3xb4>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-8-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-8-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,linux.org.uk:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue 19-05-26 08:06:26, Al Viro wrote:
> ... where it folds with configfs_detach_item() into a call of
> configfs_detach_group().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 726c56d1772d..d2a60429a545 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -728,17 +728,13 @@ static int populate_groups(struct config_group *group,
>  			   struct configfs_fragment *frag)
>  {
>  	struct config_group *new_group;
> -	int ret = 0;
>  
>  	list_for_each_entry(new_group, &group->default_groups, group_entry) {
> -		ret = create_default_group(group, new_group, frag);
> -		if (ret) {
> -			detach_groups(group);
> -			break;
> -		}
> +		int ret = create_default_group(group, new_group, frag);
> +		if (ret)
> +			return ret;
>  	}
> -
> -	return ret;
> +	return 0;
>  }
>  
>  void configfs_remove_default_groups(struct config_group *group)
> @@ -878,6 +874,13 @@ static void configfs_detach_item(struct config_item *item)
>  	configfs_remove_dir(item);
>  }
>  
> +/* Caller holds the mutex of the group's inode */
> +static void configfs_detach_group(struct config_item *item)
> +{
> +	detach_groups(to_config_group(item));
> +	configfs_detach_item(item);
> +}
> +
>  static int configfs_attach_group(struct config_item *parent_item,
>  				 struct config_item *item,
>  				 struct dentry *dentry,
> @@ -904,7 +907,7 @@ static int configfs_attach_group(struct config_item *parent_item,
>  		configfs_adjust_dir_dirent_depth_before_populate(sd);
>  		ret = populate_groups(to_config_group(item), frag);
>  		if (ret) {
> -			configfs_detach_item(item);
> +			configfs_detach_group(item);
>  			d_inode(dentry)->i_flags |= S_DEAD;
>  			dont_mount(dentry);
>  		}
> @@ -917,13 +920,6 @@ static int configfs_attach_group(struct config_item *parent_item,
>  	return ret;
>  }
>  
> -/* Caller holds the mutex of the group's inode */
> -static void configfs_detach_group(struct config_item *item)
> -{
> -	detach_groups(to_config_group(item));
> -	configfs_detach_item(item);
> -}
> -
>  /*
>   * After the item has been detached from the filesystem view, we are
>   * ready to tear it out of the hierarchy.  Notify the client before
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
