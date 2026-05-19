Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC341233944
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779186704; cv=none; b=S0WLjHQvKSYP/J2oQ+odDK1jdKEXLFRxl/F5pfK61WCoiYNBVY6BrYywalTeFyjfkC245mosQ51jObOVljEs4iKeGLzfvH7/D3KT3yNr3RuRlPhe5F9JmtWC+/kbtqcDO876PpCp63lQHHonPP+0xizU1/v0CyatiX7iEIaBbck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779186704; c=relaxed/simple;
	bh=48ACC0daDVim2A2ywl21SnA6tsnpDzjJSJbZq3iuyEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=evSMMIWswN3evCPVEviEDTXRF6BjNjhtSZc8BCQCdm/sdQYIQOHxWWUF5SYoT3BtWdW4lZcMNPktbx9fXqSOti64L31l0eQ/e48dbYPxKpx48GRB+qDDwjrvHqAvCVqIKIi8rKeYI+Kd4L3SldnMr0dXxa08AlAFRy5plnx4ZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=D3pcwXSA; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7tzIsfsN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uRN8uUZb; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=swJbW6T5; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="D3pcwXSA";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7tzIsfsN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uRN8uUZb";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="swJbW6T5"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ED1316A9F6;
	Tue, 19 May 2026 10:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHp274tb3pp3eK2gouiowxZBwhBzDz7Ps3L7TNLUly8=;
	b=D3pcwXSAp0+5DEWKDcsRIz4uufhcfwwv2Kvsm3n11oEL++G9b9XUgtC3096cXaEarw//8d
	rls9B4WpT8Q7NiXZ7MTcu6CvPo9BRElb2H/R+aJk3iE5KlGn9RFUMlQxdSv2C606NM8jXW
	okvYoDYVfGL6z7x8hk2IhrY/G0vVehw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHp274tb3pp3eK2gouiowxZBwhBzDz7Ps3L7TNLUly8=;
	b=7tzIsfsNp2sdkHSaj0j88SbyaqwOzPocx5SpQ92acP0w78ONeCGVCPBtGgcBb3Brh+eqTA
	WcI7QK0TDu5Gz5BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779186700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHp274tb3pp3eK2gouiowxZBwhBzDz7Ps3L7TNLUly8=;
	b=uRN8uUZbGMcN224GkeKTG6OhTuHVbQz3CUDySaDsM1dI+d6JRIFYtTqlA7HGAGmiOEo0Iw
	IuYG2rKbjLp0G1XJrXjqSdZMhA1JRSKDVzRNXGypXEXDLpAvcyW2zHlw5RMZ0sq8DylmVl
	8i5gzLJioRZ9pt3Qgfyun3oBuetkAj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779186700;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cHp274tb3pp3eK2gouiowxZBwhBzDz7Ps3L7TNLUly8=;
	b=swJbW6T5bMSNDnbnY2hOUiB85oJRG++n35HXpdqROWZF1nypk5/k40IGpLQuXoU0cZrQfG
	21xStHymobR76GBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E61DB593A8;
	Tue, 19 May 2026 10:31:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6hotOAw8DGpTBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 10:31:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59B01A0ADE; Tue, 19 May 2026 12:31:40 +0200 (CEST)
Date: Tue, 19 May 2026 12:31:40 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 08/14] populate_attrs(): move cleanup to the sole
 caller
Message-ID: <ofimaxnbrusjrsrh7kkqfcretwh6w2uba422hvyqk63cprqdqj@rrbqmgxfskgj>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-9-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-9-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Level: 

On Tue 19-05-26 08:06:27, Al Viro wrote:
> ... where it folds with configfs_remove_dir() into a call of
> configfs_detach_item().  Note that at the early failure exit
> (before we'd added any children) we were not calling detach_attrs()
> only because there it would've been a no-op - nothing added,
> nothing there to be removed.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/dir.c | 30 ++++++++++++++----------------
>  1 file changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index d2a60429a545..395270cc3710 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -621,25 +621,23 @@ static int populate_attrs(struct config_item *item)
>  			if (ops && ops->is_visible && !ops->is_visible(item, attr, i))
>  				continue;
>  
> -			if ((error = configfs_create_file(item, attr)))
> -				break;
> +			error = configfs_create_file(item, attr);
> +			if (error)
> +				return error;
>  		}
>  	}
> -	if (!error && t->ct_bin_attrs) {
> +	if (t->ct_bin_attrs) {
>  		for (i = 0; (bin_attr = t->ct_bin_attrs[i]) != NULL; i++) {
>  			if (ops && ops->is_bin_visible && !ops->is_bin_visible(item, bin_attr, i))
>  				continue;
>  
>  			error = configfs_create_bin_file(item, bin_attr);
>  			if (error)
> -				break;
> +				return error;
>  		}
>  	}
>  
> -	if (error)
> -		detach_attrs(item);
> -
> -	return error;
> +	return 0;
>  }
>  
>  static int configfs_attach_group(struct config_item *parent_item,
> @@ -824,6 +822,13 @@ static void link_group(struct config_group *parent_group, struct config_group *g
>  		link_group(group, new_group);
>  }
>  
> +/* Caller holds the mutex of the item's inode */
> +static void configfs_detach_item(struct config_item *item)
> +{
> +	detach_attrs(item);
> +	configfs_remove_dir(item);
> +}
> +
>  /*
>   * The goal is that configfs_attach_item() (and
>   * configfs_attach_group()) can be called from either the VFS or this
> @@ -856,7 +861,7 @@ static int configfs_attach_item(struct config_item *parent_item,
>  			 * we must lock them as rmdir() would.
>  			 */
>  			inode_lock(d_inode(dentry));
> -			configfs_remove_dir(item);
> +			configfs_detach_item(item);
>  			d_inode(dentry)->i_flags |= S_DEAD;
>  			dont_mount(dentry);
>  			inode_unlock(d_inode(dentry));
> @@ -867,13 +872,6 @@ static int configfs_attach_item(struct config_item *parent_item,
>  	return ret;
>  }
>  
> -/* Caller holds the mutex of the item's inode */
> -static void configfs_detach_item(struct config_item *item)
> -{
> -	detach_attrs(item);
> -	configfs_remove_dir(item);
> -}
> -
>  /* Caller holds the mutex of the group's inode */
>  static void configfs_detach_group(struct config_item *item)
>  {
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
