Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258591EE01A
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Jun 2026 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780922773; cv=none; b=hItgur1PfhGvMXX/e+kUjz/G4hyDc5qoP35MdTkDx5GluBjH8whJwWnqF8ylCCSpQjWzPiSg3dMpN2LTeaNtn09RymDy0pMj0SO8PHVNgGE78hLmjxZ04DBH223Y/qdex+NyehMhjlX/2F7oK77L0duL3lXkEQAkP38t0cu1FU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780922773; c=relaxed/simple;
	bh=hk09Vs7o138n+cVWtcoYYoGd3uGMrSTdXRBmk7MNyrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdskYKTpr5w+KV+VMrKTyXBT2wXsPzDu4PLGYCE9SppDou0l5nc+FiiMip/fHKTYMMzGOfgRTt660A1ZO2nfpHDLRhhUaktSYqPQCYWbf7C4m7aneZIB4dFl2oos6Hye2toHVKXXEmW+M0jR/gWKvwRkX887LSNE/vbOqZQ4ixo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sxHV603i; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0POWYaje; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vg49oO6H; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=+v4qY/G0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sxHV603i";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0POWYaje";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vg49oO6H";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="+v4qY/G0"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 79C7567C1D;
	Mon,  8 Jun 2026 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hi9jc/EWeA1ZGhidtaSrLbqdF5PCARVWlIlbMdH1zbk=;
	b=sxHV603iXBqaRQc/+/DccNhrVdsfteGQB3mVFHYeOD3JvUEDJ39QAxnFL87MMkkSA5jhtn
	oRpHNtGr9aRgtllbZcfAfg2GeuxBJGKNZG19Mi8cpeEwffjGawhGO9AmxyV/SdNM/16SF+
	p8O55EjWMnqp2mzHYtsFSUyEt+UUwto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hi9jc/EWeA1ZGhidtaSrLbqdF5PCARVWlIlbMdH1zbk=;
	b=0POWYajeqns8VbZ6crddF4rM9ZNQ3VkIQTVz/fGUrNu2T/4IesQPSafa1X/FJKGgM3Fgb2
	Sswll5afxdwP0dBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780922769; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hi9jc/EWeA1ZGhidtaSrLbqdF5PCARVWlIlbMdH1zbk=;
	b=Vg49oO6HOkahE2ITEfVYMZjn/SxRQgx8ieuRSxD+WfRaK780oTsfuCLhYDOzd3lAwpqubi
	aA8h07YxAtVOybmEXkQUBQtD4psVfG33xXl+lgJUzkS3izeLJk9uf1guKd+3V886Y7A02p
	qSyu96vRJVeTKaG5HrVBsleC/s1+2P0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780922769;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hi9jc/EWeA1ZGhidtaSrLbqdF5PCARVWlIlbMdH1zbk=;
	b=+v4qY/G0wJq/EdarYrCWXyzr4hro3BnQF5VsCM2y8Hp5v876+lil/Qr2nh1/5v2EKehgCB
	xrV+evV0AddMgqBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 701D1779A7;
	Mon,  8 Jun 2026 12:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3qleG5G5JmpHUgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 08 Jun 2026 12:46:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 13F82A0923; Mon, 08 Jun 2026 14:46:09 +0200 (CEST)
Date: Mon, 8 Jun 2026 14:46:09 +0200
From: Jan Kara <jack@suse.cz>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, 
	Andreas Hindborg <a.hindborg@kernel.org>, Breno Leitao <leitao@debian.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2 14/18] kill configfs_drop_dentry()
Message-ID: <ew4rktt25s2hkvbnsp4tfvbf6r22p3nl53udtngvjnac5zaham@elixg6bjovic>
References: <20260519070633.2025485-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-1-viro@zeniv.linux.org.uk>
 <20260603074815.3033766-18-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603074815.3033766-18-viro@zeniv.linux.org.uk>
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.org.uk:email,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.80

On Wed 03-06-26 08:48:11, Al Viro wrote:
> Fold into the only remaining user, don't bother with the timestamps
> of parent - we are going to rmdir it shortly anyway, which will
> override those.
> 
> Fix the locking of inode, while we are at it - updating the link
> count and timestamps ought to be done with the inode locked.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/configfs/configfs_internal.h |  1 -
>  fs/configfs/dir.c               | 24 +++++++++++++++++++++++-
>  fs/configfs/inode.c             | 22 ----------------------
>  3 files changed, 23 insertions(+), 24 deletions(-)
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
> index 479d37b8d806..4a4bad1741cf 100644
> --- a/fs/configfs/dir.c
> +++ b/fs/configfs/dir.c
> @@ -581,12 +581,34 @@ static void detach_attrs(struct dentry *dentry)
>  
>  	spin_lock(&configfs_dirent_lock);
>  	for (sd = next_dirent(parent_sd, NULL); sd; sd = next) {
> +		struct dentry *child;
> +
>  		next = next_dirent(parent_sd, sd);
>  		if (!(sd->s_type & CONFIGFS_NOT_PINNED))
>  			continue;
>  		list_del_init(&sd->s_sibling);
> +		child = sd->s_dentry;
> +		if (child) {
> +			spin_lock(&child->d_lock);
> +			if (simple_positive(child)) {
> +				dget_dlock(child);
> +				__d_drop(child);
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
> +
> +			inode_lock_nested(inode, I_MUTEX_NONDIR2);
> +			inode_set_ctime_current(inode);
> +			drop_nlink(inode);
> +			inode_unlock(inode);
> +			dput(child);
> +		}
>  		configfs_put(sd);
>  		spin_lock(&configfs_dirent_lock);
>  	}
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
