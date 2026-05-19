Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F468340401
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779196384; cv=none; b=SoOQeaU/0BbxZFCpIoHV8SRylx6WmgpvAFIJ0MRMTpsTsKlXH2HiUrnBOXr/jSokYLjBZHZjyxKZgABSuttX6rKQnengdXAmNLGkmnc0cW3X7yDP+/WXWNsyPZ2/fymbDsD8cM8VVXS1EntgkP4WHkX4V0Yml5ENIAi3jSYFG1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779196384; c=relaxed/simple;
	bh=uttRz8yhrN8uSRl3QOL+AoaUYikNwPQU2Uj+TvCaDGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atiEEqKBNXqXg9ZoqWrbZM9CT5pF3wAidq99IWo3eqdR+wxv2nPye+jVgoPEzdPsz70xKeyzpoDPgsOteh1fd78etJJYQOytT6b0cdij0l6kqPnuE+tJYDG2IRFAq+9FGADuCTVZS2A3KGfMYRYmhxObW9dIzJW9lDVVTCRU08Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Ga+wyc4h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DQD2tS7u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rDq6ktjJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nOLX3hdE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Ga+wyc4h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DQD2tS7u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rDq6ktjJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nOLX3hdE"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5A7015E1A1;
	Tue, 19 May 2026 13:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779196381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttv9jC3aE4YTQwFj5JRk+lsHEFMSD8ObMwd5n3jrlGc=;
	b=Ga+wyc4hMgNvHGtk4LCme2x8FC9nOsnhPWRWhMlHnfIkS7vzD6FZXglYHCMXtspyycOsoq
	7lUegUp7FBLRea15j80Mf/n2opM4V5Kj/Ys53BeByn5UTe4ijuqWGzBnDXdkiP89YJ4IHv
	14v0Pe5ZIPCBjTL61DPMJdcM8qW+liY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779196381;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttv9jC3aE4YTQwFj5JRk+lsHEFMSD8ObMwd5n3jrlGc=;
	b=DQD2tS7uCGgkq2S8jKfPm3Z6ZyZAl13Dap95qFdNuPcQk5caiuXhYMwM5wq8BEz4ykUVyD
	LQYo4DUFknHG7LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779196377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttv9jC3aE4YTQwFj5JRk+lsHEFMSD8ObMwd5n3jrlGc=;
	b=rDq6ktjJMWwL/nt+2hDGFyERQhezWk7eSl20r2hUQgMzO3IyEpnrOSfEkOzrB0xU35rJim
	+x09NVRxi1+K2H2K6+iNgOKRFv0vNwl8R87enPSMyL7QWxNWsi8BnJfJRY7wYpk14RRChE
	1QdiX+W7kY7LHZiIvM65krwRJvOcIEU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779196377;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ttv9jC3aE4YTQwFj5JRk+lsHEFMSD8ObMwd5n3jrlGc=;
	b=nOLX3hdE4y1vJu+1+Rl9WByRDoGfxGpcx3aIdLStoUSLBsTVpvuFmjrozqFejIZP086vWf
	9A/5BDCfQJxBTGBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 529E5593A8;
	Tue, 19 May 2026 13:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id akopFNlhDGrSKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 13:12:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5BC9BA0ADE; Tue, 19 May 2026 15:12:56 +0200 (CEST)
Date: Tue, 19 May 2026 15:12:56 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [RFC PATCH 13/14] kill configfs_drop_dentry()
Message-ID: <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-14-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519070633.2025485-14-viro@zeniv.linux.org.uk>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,linux.org.uk:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 19-05-26 08:06:32, Al Viro wrote:
> Fold into the only remaining user, don't bother with the timestamps
> of parent - we are going to rmdir it shortly anyway, which will
> override those.
> 
> Fix the locking of inode, while we are at it - updating the link
> count and timestamps ought to be done with the inode locked.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
...
>  	parent_sd = dentry->d_fsdata;
>  	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
> +		struct dentry *child;
>  		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
>  			continue;
>  		spin_lock(&configfs_dirent_lock);
>  		list_del_init(&sd->s_sibling);
> +		child = sd->s_dentry;
> +		if (child && simple_positive(child))
> +			dget_dlock(child);

Why is it safe to call dget_dlock() here? We hold only configfs_dirent_lock
so cannot we race with somebody doing dget() on the 'child' dentry? Even if
it is indeed safe for some reason I'm missing, it would deserve a comment I
guess?

								Honza

> +		else
> +			child = NULL;
>  		spin_unlock(&configfs_dirent_lock);
> -		configfs_drop_dentry(sd, dentry);
> +		if (child) {
> +			struct inode *inode = child->d_inode;
> +			d_drop(child);
> +
> +			inode_lock_nested(inode, I_MUTEX_NONDIR2);
> +			inode_set_ctime_current(inode);
> +			drop_nlink(inode);
> +			inode_unlock(inode);
> +			dput(child);
> +		}
>  		configfs_put(sd);
>  	}
>  }
> diff --git a/fs/configfs/inode.c b/fs/configfs/inode.c
> index bc507b720a01..3c26b6c443be 100644
> --- a/fs/configfs/inode.c
> +++ b/fs/configfs/inode.c
> @@ -195,25 +195,3 @@ const unsigned char * configfs_get_name(struct configfs_dirent *sd)
>  	}
>  	return NULL;
>  }
> -
> -
> -/*
> - * Unhashes the dentry corresponding to given configfs_dirent
> - * Called with parent inode's i_mutex held.
> - */
> -void configfs_drop_dentry(struct configfs_dirent * sd, struct dentry * parent)
> -{
> -	struct dentry * dentry = sd->s_dentry;
> -
> -	if (dentry) {
> -		spin_lock(&dentry->d_lock);
> -		if (simple_positive(dentry)) {
> -			dget_dlock(dentry);
> -			__d_drop(dentry);
> -			spin_unlock(&dentry->d_lock);
> -			__simple_unlink(d_inode(parent), dentry);
> -			dput(dentry);
> -		} else
> -			spin_unlock(&dentry->d_lock);
> -	}
> -}
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
