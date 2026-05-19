Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E814F5E0
	for <linux-fsdevel@vger.kernel.org>; Tue, 19 May 2026 15:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206104; cv=none; b=c2k1b3MXbUXb1FPsh3o2lrr5OjSy2Ku8QoNlysqMgMkF9GzSsuzX2OQxwzf/QcQjYVqNMrrY5f1UCUmK01cCha5nOe8cX7rfsvsh36A+2ghEB3qrJlJMJyVr+vNm0WqzxYS8gsFbuVZ5AGPl9VqjzzQ2gyAKkLyGPeqe5PLeSBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206104; c=relaxed/simple;
	bh=II6nGZnqD5Wz9Pr9pcfjglW7AianpPNji6dJy8YAI54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nOMZZvTbKYR9nl6hx94K/Avis/GH4vmPj/0xnjuBzeXuNJjdr29ftMjOk0WXVmuYkNCc87Ta9h5mqSxzlLobf6eEcYfOVBXnFH5xCSpRYd649a2p6C2xvwFbdU1eaCyxU4E7KTWo/NFQAnR2dyk+KQjjRSlrIRarXu2fE60fkpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A7JdiWiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9nAi5bFA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A7JdiWiJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9nAi5bFA; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7JdiWiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9nAi5bFA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A7JdiWiJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9nAi5bFA"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E2136C26C;
	Tue, 19 May 2026 15:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779206100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHAtODtFkPYHRR4uSbkvHUnF9tCWKnzqhWzH2RpAmyE=;
	b=A7JdiWiJxFMMwcNG/7HttzJA+hq2rbilUEqbXT0hn6eyRlyqnqKoGXCfc0eB5Dj48vaH1a
	rsAfHUycJB2/RkvwToMSfTTQQsy8eqAnpIDC9DQuK2aETZlVhmcef/jOrqjGQhBPWZfM8i
	5ep8t+1iU03JjeTUfVX7SaSMqdTmWa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779206100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHAtODtFkPYHRR4uSbkvHUnF9tCWKnzqhWzH2RpAmyE=;
	b=9nAi5bFA+pR2/FVGUHhht4EgiWAMmSdbYNLXtz0AgM6Am7MhMuV9/eLUF/xGEf8G2WHeFn
	hoT/2hc4hyFduHAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779206100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHAtODtFkPYHRR4uSbkvHUnF9tCWKnzqhWzH2RpAmyE=;
	b=A7JdiWiJxFMMwcNG/7HttzJA+hq2rbilUEqbXT0hn6eyRlyqnqKoGXCfc0eB5Dj48vaH1a
	rsAfHUycJB2/RkvwToMSfTTQQsy8eqAnpIDC9DQuK2aETZlVhmcef/jOrqjGQhBPWZfM8i
	5ep8t+1iU03JjeTUfVX7SaSMqdTmWa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779206100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VHAtODtFkPYHRR4uSbkvHUnF9tCWKnzqhWzH2RpAmyE=;
	b=9nAi5bFA+pR2/FVGUHhht4EgiWAMmSdbYNLXtz0AgM6Am7MhMuV9/eLUF/xGEf8G2WHeFn
	hoT/2hc4hyFduHAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26AE9593A8;
	Tue, 19 May 2026 15:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fqBbCdSHDGqyRgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 19 May 2026 15:55:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B0658A088B; Tue, 19 May 2026 17:54:59 +0200 (CEST)
Date: Tue, 19 May 2026 17:54:59 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 02/10] fsnotify: introduce fsnotify group types
Message-ID: <b5xolvjlm3xnx3dzdbvyc7nqgaejjatnrrwint6gleirdy6czi@vtj2m2qpayj6>
References: <20260424170503.2096847-1-amir73il@gmail.com>
 <20260424170503.2096847-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424170503.2096847-3-amir73il@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Spam-Level: 

On Fri 24-04-26 19:04:55, Amir Goldstein wrote:
> Currently an fanotify group can subscribe to events FAN_MNT_ATTACH/DETACH
> only on mark type FAN_MARK_MNTNS and IFF the group was initialized with
> FAN_REPORT_MNT.
> 
> Hence, mount events can not be mixed on the same group with filesystem
> events and mntns marks cannot be mixed with filesystem type marks.
> 
> Define a new property for an fsnotify group called fsnotify_group_type
> which describes the category of events and mark types and use a distinct
> category FSNOTIFY_GROUP_TYPE_NS for the mount event groups.
> 
> Create helpers fsnotify_is_{fs,ns}_watcher() and the macro
> FANOTIFY_NS_INIT_FLAGS and use them to generalize some code that was
> checking the FAN_REPORT_MNT flag.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

...

> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 38290b9c07f7b..e768c25262e27 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -314,9 +314,11 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  	pr_debug("%s: report_mask=%x mask=%x data=%p data_type=%d\n",
>  		 __func__, iter_info->report_mask, event_mask, data, data_type);
>  
> -	if (FAN_GROUP_FLAG(group, FAN_REPORT_MNT)) {
> +	if (fsnotify_is_ns_watcher(group)) {
>  		if (data_type != FSNOTIFY_EVENT_MNT)
>  			return 0;
> +	} else if (WARN_ON_ONCE(!fsnotify_is_fs_watcher(group))) {
> +		return 0;

ns_watcher and fs_watcher names are really very similar. I was staring at
that for a while trying to understand what you're doing here before I
noticed that single letter difference. I'm struggling to find better names.
Maybe fsnotify_namespace_watcher() and fsnotify_filesystem_watcher() and
correspondingly FSNOTIFY_GROUP_TYPE_FILESYSTEM / NAMESPACE?

> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index 49531a4fe71de..95e7c24c70249 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1586,8 +1586,11 @@ static struct hlist_head *fanotify_alloc_merge_hash(void)
>  DEFINE_CLASS(fsnotify_group,
>  	     struct fsnotify_group *,
>  	     if (!IS_ERR_OR_NULL(_T)) fsnotify_destroy_group(_T),
> -	     fsnotify_alloc_group(ops, flags),
> -	     const struct fsnotify_ops *ops, int flags)
> +	     __fsnotify_alloc_group(ops, type,
> +				    FSNOTIFY_GROUP_FLAG_USER,
> +				    GFP_KERNEL_ACCOUNT),
> +	     const struct fsnotify_ops *ops,
> +	     enum fsnotify_group_type type)

I don't like this much. It's a bit of a catch that
FSNOTIFY_GROUP_FLAG_USER is now always set (although I see that that's what
the only user is doing). I'd keep this as is.

> @@ -2005,14 +2022,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
>  		return -EINVAL;
>  
>  	/*
> -	 * Events that do not carry enough information to report
> +	 * Filesystem events that do not carry enough information to report
>  	 * event->fd require a group that supports reporting fid.  Those
>  	 * events are not supported on a mount mark, because they do not
>  	 * carry enough information (i.e. path) to be filtered by mount
>  	 * point.
>  	 */
>  	fid_mode = FAN_GROUP_FLAG(group, FANOTIFY_FID_BITS);
> -	if (mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_MOUNT_EVENTS|FANOTIFY_EVENT_FLAGS) &&
> +	if (fsnotify_is_fs_watcher(group) &&
> +	    mask & ~(FANOTIFY_FD_EVENTS|FANOTIFY_EVENT_FLAGS) &&
>  	    (!fid_mode || mark_type == FAN_MARK_MOUNT))
>  		return -EINVAL;

I guess it would look more obvious here to switch on mark_type and validate
that the set event bits match the mark_type (and fid_mode).

> -static struct fsnotify_group *__fsnotify_alloc_group(
> -				const struct fsnotify_ops *ops,
> -				int flags, gfp_t gfp)
> +struct fsnotify_group *__fsnotify_alloc_group(const struct fsnotify_ops *ops,
> +					      enum fsnotify_group_type type,
> +					      int flags, gfp_t gfp)
>  {

Can't we just derive the group type from flags in this function? I don't
see a huge reason to duplicate that info in flags argument.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
