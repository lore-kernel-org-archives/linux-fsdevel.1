Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB0376A14
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 May 2026 16:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779380150; cv=none; b=UJ+U8KKv0K/PV0EQkmO2sRrbe2hvsQRe5NriSuvGP2mYrA2llKhck6c9+8a433Alm/RC/s70+ZKTe8E3HxHdhPOKAcXkSq2rUW/dc7ABjTdW4QvVfrLx9D7oY4mhlKcETuMVtwj2nIHu2J1IHUmiXPv6leZlz4r3B+Ti52Q1K74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779380150; c=relaxed/simple;
	bh=INuVMXyAgm+OAWVypcpNWU0M6h0gMSC3YO01wi/CPW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaXoszd5WtwuaIN4cERkzqMMYgMZC7Oa61RiuG6a2fSP56ZQc5yu6W+952J8FlxttBaDj3YGtAOX5+zWN2zG2dkv8qa2EAA0TrgNc9zAyg5aGZKtTGN7Yo57tmSp0kATpMYMVuvjS1ao4FgdNz6fd/gKu7SXZkK0dnYqHcDQW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gXD/mmAr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uA6HI9c2; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iJf373cz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=COUz9AX0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gXD/mmAr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uA6HI9c2";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iJf373cz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="COUz9AX0"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 68DA967148;
	Thu, 21 May 2026 16:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779380141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYpg4/1aTqCxke2j9SjtyDWm5ikndGzivpoQoJE/DoE=;
	b=gXD/mmAr4WbN9CnBwzYLwlXCHn8TWnMrRBLMaq36HDLyzhYatOvB2T+sJNnDuLIXo/va8L
	ruuh+en6XoXQm8qSRN0p+dSwTYQsGSqhAsUlkVQHFRM51W0G2TBJjCF2UR/9J11hq2oQV0
	E70GemJfZFFQgPnGjlc8dIRztyywETY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779380141;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYpg4/1aTqCxke2j9SjtyDWm5ikndGzivpoQoJE/DoE=;
	b=uA6HI9c2IWtL9qQKqZLuuT5+3loIivmhu3FC1YB+o7KUMCa38iKwZhGpc3Xfn9gyu9mgoG
	51Iaa4ZFO1M4muDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iJf373cz;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=COUz9AX0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779380139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYpg4/1aTqCxke2j9SjtyDWm5ikndGzivpoQoJE/DoE=;
	b=iJf373czDtXv/B676mw+JjiP78CaZlFudPFAk8dGwYy976uOGcAmuBmrYznALIaoM4UTzY
	LdWGs7+G47CcDgh5p/9jANrIo5NaOVLWyAmUtgJ/EaQz0lWg6j5HBj3PgSaBtC++5kuld/
	fjlqoFBKCvQJa23lbJOOr5/0pHo3dCI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779380139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fYpg4/1aTqCxke2j9SjtyDWm5ikndGzivpoQoJE/DoE=;
	b=COUz9AX0iDafxbbm6tjrSd76x6OWWVsc6wJH4zuYK35HJvr9/LNkHimTYpBMbWp52zJJ60
	EYACk1t7A/jYHWAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30E3F593AC;
	Thu, 21 May 2026 16:15:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q+vjC6svD2qkNgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 May 2026 16:15:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C52CA08F3; Thu, 21 May 2026 18:15:30 +0200 (CEST)
Date: Thu, 21 May 2026 18:15:30 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] fsnotify: separate the events bitmask macros by
 group type
Message-ID: <pnpqweynr6u4jtc67orwdqcelj4yo4c4ydeiw2td7777dzxl7j@xmo22qzv3yp4>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-4-amir73il@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 68DA967148
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 24-04-26 19:04:56, Amir Goldstein wrote:
> Fork the macros ALL_FSNOTIFY_EVENTS and FANOTIFY_EVENTS to
> *_EVENTS_ON_{FS,NS} and use them to determine the valid mask for
> fanotify_mark() and the outgoing mask by the group type.
> 
> Use the fanotify_is_valid_mask() helepr to simplifies the check for
> reporting mount events IFF group was initialized with FAN_REPORT_MNT
> and IFF watching an mntns object.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index e768c25262e27..494bba49634e1 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -303,7 +303,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  				     struct inode *dir)
>  {
>  	__u32 marks_mask = 0, marks_ignore_mask = 0;
> -	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
> +	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_FS_EVENTS |
>  				     FANOTIFY_EVENT_FLAGS;
>  	const struct path *path = fsnotify_data_path(data, data_type);
>  	unsigned int fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> @@ -315,6 +315,7 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
>  	if (fsnotify_is_ns_watcher(group)) {
> +		user_mask = FANOTIFY_OUTGOING_NS_EVENTS;

I'd use the helper function you define in fanotify_user.c for this so that
we have the logic in one place.

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 95e7c24c70249..7afb017d40f50 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -830,6 +830,19 @@ static int copy_info_records_to_user(struct fanotify_event *event,
>  	return total_bytes;
>  }
>  
> +static __u64 fanotify_event_mask(struct fsnotify_group *group,
> +				 struct fanotify_event *event)

I'd call this fanotify_group_outgoing_events(). Your name is too similar to
fanotify_group_event_mask() - it's unclear what's what from the name. Also
I'd let it just take the mask as an argument instead of event.

> +{
> +	switch (group->type) {
> +	case FSNOTIFY_GROUP_TYPE_FS:
> +		return event->mask & FANOTIFY_OUTGOING_FS_EVENTS;
> +	case FSNOTIFY_GROUP_TYPE_NS:
> +		return event->mask & FANOTIFY_OUTGOING_NS_EVENTS;

Here I'd also go for FILESYSTEM / NAMESPACE in constant names to increase
distinction.

> +	}
> +
> +	return 0;
> +}
> +
>  static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  				  struct fanotify_event *event,
>  				  char __user *buf, size_t count)
> @@ -848,7 +861,7 @@ static ssize_t copy_event_to_user(struct fsnotify_group *group,
>  	metadata.metadata_len = FAN_EVENT_METADATA_LEN;
>  	metadata.vers = FANOTIFY_METADATA_VERSION;
>  	metadata.reserved = 0;
> -	metadata.mask = event->mask & FANOTIFY_OUTGOING_EVENTS;
> +	metadata.mask = fanotify_event_mask(group, event);
>  	metadata.pid = pid_vnr(event->pid);
>  	/*
>  	 * For an unprivileged listener, event->pid can be used to identify the
> @@ -1881,6 +1894,35 @@ static int fanotify_events_supported(struct fsnotify_group *group,
>  	return 0;
>  }
>  
> +static bool fanotify_is_valid_mask(struct fsnotify_group *group, int mark_type,
> +				   __u64 mask)
> +{
> +	u32 valid_mask = 0;
> +
> +	/*
> +	 * Event bits for different group type may be overloaded but event
> +	 * flags are common to all group types.
> +	 */
> +	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_FS & FANOTIFY_EVENT_FLAGS);
> +	BUILD_BUG_ON(FANOTIFY_EVENTS_ON_NS & FANOTIFY_EVENT_FLAGS);

I'm a bit curious what's your rationale for this? It isn't like EVENT_FLAGS
can be sensibly used with namespace notifications, they are kind of fs
specific as well...

> +
> +	switch (group->type) {
> +	case FSNOTIFY_GROUP_TYPE_FS:
> +		valid_mask = FANOTIFY_EVENTS_ON_FS | FANOTIFY_EVENT_FLAGS;
> +		if (!IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> +			valid_mask &= ~FANOTIFY_PERM_EVENTS;
> +		break;
> +	case FSNOTIFY_GROUP_TYPE_NS:
> +		/* Only report mount events on mntns mark */
> +		if (mark_type == FAN_MARK_MNTNS &&
> +		    FAN_GROUP_FLAG(group, FAN_REPORT_MNT))
> +			valid_mask = FANOTIFY_MOUNT_EVENTS;
> +		break;
> +	}

Shouldn't this also check that the mark type matches the group type? The
condition you replace with this call did that...

> +
> +	return !(mask & ~valid_mask);
> +}
> +
>  static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  			    int dfd, const char  __user *pathname)
>  {
> @@ -1890,7 +1932,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  	struct fan_fsid __fsid, *fsid = NULL;
>  	struct user_namespace *user_ns = NULL;
>  	struct mnt_namespace *mntns;
> -	u32 valid_mask = FANOTIFY_EVENTS | FANOTIFY_EVENT_FLAGS;
>  	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
>  	unsigned int mark_cmd = flags & FANOTIFY_MARK_CMD_BITS;
>  	unsigned int ignore = flags & FANOTIFY_MARK_IGNORE_BITS;
> @@ -1945,13 +1986,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_FANOTIFY_ACCESS_PERMISSIONS))
> -		valid_mask |= FANOTIFY_PERM_EVENTS;
> -
> -	if (mask & ~valid_mask)
> -		return -EINVAL;
> -
> -
>  	/* We don't allow FAN_MARK_IGNORE & FAN_MARK_IGNORED_MASK together */
>  	if (ignore == (FAN_MARK_IGNORE | FAN_MARK_IGNORED_MASK))
>  		return -EINVAL;
> @@ -1974,22 +2008,10 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  	group = fd_file(f)->private_data;
>  
> -	if (group->type != group_type)
> +	if (group->type != group_type ||
> +	    !fanotify_is_valid_mask(group, mark_type, mask))
>  		return -EINVAL;
>  
> -	/* Only report mount events on mnt namespace */
> -	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> -		if (mask & ~FANOTIFY_MOUNT_EVENTS)
> -			return -EINVAL;
> -		if (mark_type != FAN_MARK_MNTNS)
> -			return -EINVAL;
> -	} else {
> -		if (mask & FANOTIFY_MOUNT_EVENTS)
> -			return -EINVAL;
> -		if (mark_type == FAN_MARK_MNTNS)
> -			return -EINVAL;
> -	}
> -
>  	/*
>  	 * A user is allowed to setup sb/mount/mntns marks only if it is
>  	 * capable in the user ns where the group was created.
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index b646a861a84c6..429ce614233ce 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -149,7 +149,7 @@ static inline __u32 fsnotify_object_watched(struct inode *inode, __u32 mnt_mask,
>  	__u32 marks_mask = READ_ONCE(inode->i_fsnotify_mask) | mnt_mask |
>  			   READ_ONCE(inode->i_sb->s_fsnotify_mask);
>  
> -	return mask & marks_mask & ALL_FSNOTIFY_EVENTS;
> +	return mask & marks_mask & FSNOTIFY_EVENTS_ON_FS;
>  }

With this change it becomes kind of obvious that fsnotify_object_watched()
is a misnomer after mntns events were added. And it is ok only because the
callers of this are really specific to fs events. Can you please fix the
name - perhaps to fsnotify_fs_object_watched()?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
