Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2A3BED2B
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 21:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224822; cv=none; b=itN7w5mwWfWCxpk/NUbgpX/lrTTFDPkNQr+CKrfuxoCkm5pdnPS1AM2agGjJYqQR9gXShiS0sBLYAR1RC9N1CRaHwnAzNIdnleG3DRYMZ3+Ahy4FxEBABo+CjXjbWO1OlgrwbMyGWbnAjj3Iq+T0mrXsfKRtv+4O9q+M4/uVA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224822; c=relaxed/simple;
	bh=nqWLPyD3fnsnOeXQpZ98e89vN+i2R4UQNK8XghlSn8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dk+Xy7vBv9/kwXQDkRZKqpEX6foIJ1gGgVhzlIx96lTmLip9x2L7lRhR7WM4pNknExP18QL/4Zboj74ZyKmf74KqZKsGayQdgOSOG9E4vEcfjUhVJhWoVh0/KLoCriPKkVlD0N/lXuoXpq4hXIiBm1piSspfADMjWP8mgnQGAQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pPmKKFAz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=eq+HApcJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vsH1viHQ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Cak/j4TS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pPmKKFAz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="eq+HApcJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vsH1viHQ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Cak/j4TS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5AB6468562;
	Tue, 19 May 2026 21:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779224819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yKZJ95colKQdT6XGqbLeZFxibk64zI7WbaHMC2pa9g=;
	b=pPmKKFAzcQF+FHR5X5locwdS6g+I209irm3qmcd6rflEH/AZRrECT/vFF8r7gYRo/BT2JH
	Ryn8on2K6oxRrXYKtls2KS4D6gapaqXNF8BGFntIvjrjfqzD6yvgBd3fBzqGnnSQ7lOVM5
	TW66xHiKfKkZPQfwJ4cNp0kujxsbL6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779224819;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yKZJ95colKQdT6XGqbLeZFxibk64zI7WbaHMC2pa9g=;
	b=eq+HApcJ2d+Bi4KPklm/0IedXGUJKHAT0wy2iNAt9UrKYl6yJ/HIuWrrv8MiZckY0taY3y
	tV156ab7Zi6xKPDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779224815; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yKZJ95colKQdT6XGqbLeZFxibk64zI7WbaHMC2pa9g=;
	b=vsH1viHQU97ykr4DlGykVgHAPMTs7tYMlSVxu4xeweS3B+Xt7ZcESGub9MgMBiXm/prbGC
	zJs0mn82fjTSUdx+ajn9JaW2vOaBL1Wp472bq/N/RyTSnxfO3rLq0GPnHa9rgPiMM/88HI
	TmzSS4Q3Nj6xAwRcpWSwwQX2KMZC+Oo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779224815;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0yKZJ95colKQdT6XGqbLeZFxibk64zI7WbaHMC2pa9g=;
	b=Cak/j4TSicNhBPSirX1rYpEay1UgkE+MPrvOy9MFADCczHNeBRlBYCTkuklEm1MXVGAsrH
	Za5whwLXsQ4T3+Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A527593A8;
	Tue, 19 May 2026 21:06:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id E5s4Du/QDGqwbQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 21:06:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E9E8A08D7; Tue, 19 May 2026 23:06:54 +0200 (CEST)
Date: Tue, 19 May 2026 23:06:54 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 13/14] kill configfs_drop_dentry()
Message-ID: <fqlh4yb5hcfluewqx6ulycjrowhptfd3okcgrb7zab6zqvzaxk@bdj5yuynku6l>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260519070633.2025485-14-viro@zeniv.linux.org.uk>
 <ugllhpqcy62ludmg2wgc4dcsmm4z4m6pgpzdhcehkp7jvxnf4d@6mxgiskj5ct7>
 <20260519153724.GD2636677@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519153724.GD2636677@ZenIV>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email,linux.org.uk:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Tue 19-05-26 16:37:24, Al Viro wrote:
> On Tue, May 19, 2026 at 03:12:56PM +0200, Jan Kara wrote:
> 
> > Why is it safe to call dget_dlock() here? We hold only configfs_dirent_lock
> > so cannot we race with somebody doing dget() on the 'child' dentry? Even if
> > it is indeed safe for some reason I'm missing, it would deserve a comment I
> > guess?
> 
> Because of the braindamage on conflict resolution.  Thanks for spotting,
> fixed and force-pushed.  Updated version of commit:
> 
> commit 85863f5773c15f02ff6518ad034e3b380b78ca53
> Author: Al Viro <viro@zeniv.linux.org.uk>
> Date:   Tue May 12 12:53:35 2026 -0400
> 
>     kill configfs_drop_dentry()
>     
>     Fold into the only remaining user, don't bother with the timestamps
>     of parent - we are going to rmdir it shortly anyway, which will
>     override those.
>     
>     Fix the locking of inode, while we are at it - updating the link
>     count and timestamps ought to be done with the inode locked.
>     
>     Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> 
> diff --git a/fs/configfs/configfs_internal.h b/fs/configfs/configfs_internal.h
> index 0b969d0eb8ff..acdeea8e2d69 100644
> --- a/fs/configfs/configfs_internal.h
> +++ b/fs/configfs/configfs_internal.h
> @@ -76,7 +76,6 @@ extern int configfs_make_dirent(struct configfs_dirent *, struct dentry *,
>  extern int configfs_dirent_is_ready(struct configfs_dirent *);
>  
>  extern const unsigned char * configfs_get_name(struct configfs_dirent *sd);
> -extern void configfs_drop_dentry(struct configfs_dirent *sd, struct dentry *parent);
>  extern int configfs_setattr(struct mnt_idmap *idmap,
>  			    struct dentry *dentry, struct iattr *iattr);
>  
> diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
> index 740ea2c115bd..a68b4a9241c0 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -562,12 +562,33 @@ static void detach_attrs(struct dentry *dentry)
>  
>  	parent_sd = dentry->d_fsdata;
>  	list_for_each_entry_safe(sd, tmp, &parent_sd->s_children, s_sibling) {
> +		struct dentry *child;
>  		if (!sd->s_element || !(sd->s_type & CONFIGFS_NOT_PINNED))
>  			continue;
>  		spin_lock(&configfs_dirent_lock);
>  		list_del_init(&sd->s_sibling);
> +		child = sd->s_dentry;
> +		if (child) {
> +			spin_lock(&child->d_lock);
> +			if (simple_positive(child)) {
> +				dget_dlock(child);
> +				spin_unlock(&child->d_lock);
> +			} else {
> +				spin_unlock(&child->d_lock);
> +				child = NULL;
> +			}
> +		}
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
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
