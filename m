Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A33838B7A5
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Apr 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175189; cv=none; b=jhLS9fzBEtPoBEiMd/EvDD6uDn6CH2kHBdReAdEfn0Xhr8NNcuzovGrmVDZJlJnNPKPnXiWPiB9yJplerxIvQ7ytT2zDnoVIWl/4RsYYBNuAsyrX/jDBxd9dXXcwx8K37KffFeNc7vVC7KeB7gmGlO9rHsiplX/TEYAZsiCk7+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175189; c=relaxed/simple;
	bh=kBt739tw5tLAvcH81mlChMOw7N7oABmyVzXAITnT60s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thQF2BGi8fa7agGSyY2h+90/7OfzY2TeglmswL0pfcST2GkYI8U84r1gli9tEGJoEj4sB377brAy6mCsIbTR+qpf+LKc+0fGhwRYbjMEJBghJC9yqGdmRAlTPTICkrhrkoulFPw/JU6DNAYh4QE0ro9xOAGpOVoOuxIrvQFeAa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oACHbNLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6Vpt4I5; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oACHbNLo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6Vpt4I5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oACHbNLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6Vpt4I5";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oACHbNLo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6Vpt4I5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FF835BDD0;
	Tue, 14 Apr 2026 13:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776175185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXOtfRsvuZnDFjbUV6OIa+UG2nJnaHEySR+qGNBwNTc=;
	b=oACHbNLoi5g8ynhA9wMPXaXHTAkd6t/DcwUfKiydOBbYkrsPkEwtEZ54IZi+mQk4axUzn0
	GTWNngXRE9g/pw7dPmwdFdEYF6ayC8j9C06HbrzB3Mo46czOsHEnyI7n2ljwXhRpcmmszR
	ASVp2u2eJBaRL7BK5smIUhhen5AGh6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776175185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXOtfRsvuZnDFjbUV6OIa+UG2nJnaHEySR+qGNBwNTc=;
	b=g6Vpt4I5aX/qJkGjDyPwc+BWNJZ1remMXpZR9oHTtohV+HKi4YBq5/Zy27IymO0bWRWbL2
	WHC8AV0oI0twdGDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oACHbNLo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=g6Vpt4I5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776175185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXOtfRsvuZnDFjbUV6OIa+UG2nJnaHEySR+qGNBwNTc=;
	b=oACHbNLoi5g8ynhA9wMPXaXHTAkd6t/DcwUfKiydOBbYkrsPkEwtEZ54IZi+mQk4axUzn0
	GTWNngXRE9g/pw7dPmwdFdEYF6ayC8j9C06HbrzB3Mo46czOsHEnyI7n2ljwXhRpcmmszR
	ASVp2u2eJBaRL7BK5smIUhhen5AGh6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776175185;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wXOtfRsvuZnDFjbUV6OIa+UG2nJnaHEySR+qGNBwNTc=;
	b=g6Vpt4I5aX/qJkGjDyPwc+BWNJZ1remMXpZR9oHTtohV+HKi4YBq5/Zy27IymO0bWRWbL2
	WHC8AV0oI0twdGDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 935DE4B4A0;
	Tue, 14 Apr 2026 13:59:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7vnzI1FI3mlXYAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Apr 2026 13:59:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 51769A0B53; Tue, 14 Apr 2026 15:59:45 +0200 (CEST)
Date: Tue, 14 Apr 2026 15:59:45 +0200
From: Jan Kara <jack@suse.cz>
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH] fanotify: fix false positive on permission events
Message-ID: <huuoax2nfz5ny6ql2km6su6uv5juf7muab2jdrfjnaggetshap@f2nl3wo5fjev>
References: <20260410144950.156160-1-mszeredi@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410144950.156160-1-mszeredi@redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 9FF835BDD0
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Fri 10-04-26 16:49:47, Miklos Szeredi wrote:
> fsnotify_get_mark_safe() may return false for a mark on an unrelated group,
> which results in bypassing the permission check.
> 
> Fix by skipping over detached marks that are not in the current group.
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

Sorry for a bit delayed reply. I was thinking about this for a while and
the fix looks good. I like it. I'll queue it once I push out pull requests
to Linus later this week. Thanks!

								Honza

> ---
>  fs/notify/fsnotify.c             |  2 +-
>  fs/notify/mark.c                 | 18 +++++++++++-------
>  include/linux/fsnotify_backend.h |  1 +
>  3 files changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
> index 9995de1710e5..b646a861a84c 100644
> --- a/fs/notify/fsnotify.c
> +++ b/fs/notify/fsnotify.c
> @@ -388,7 +388,7 @@ static struct fsnotify_mark *fsnotify_first_mark(struct fsnotify_mark_connector
>  	return hlist_entry_safe(node, struct fsnotify_mark, obj_list);
>  }
>  
> -static struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
> +struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark)
>  {
>  	struct hlist_node *node = NULL;
>  
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index c2ed5b11b0fe..622f05977f86 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -457,9 +457,6 @@ EXPORT_SYMBOL_GPL(fsnotify_put_mark);
>   */
>  static bool fsnotify_get_mark_safe(struct fsnotify_mark *mark)
>  {
> -	if (!mark)
> -		return true;
> -
>  	if (refcount_inc_not_zero(&mark->refcnt)) {
>  		spin_lock(&mark->lock);
>  		if (mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED) {
> @@ -500,15 +497,22 @@ bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info)
>  	int type;
>  
>  	fsnotify_foreach_iter_type(type) {
> +		struct fsnotify_mark *mark = iter_info->marks[type];
> +
>  		/* This can fail if mark is being removed */
> -		if (!fsnotify_get_mark_safe(iter_info->marks[type])) {
> -			__release(&fsnotify_mark_srcu);
> -			goto fail;
> +		while (mark && !fsnotify_get_mark_safe(mark)) {
> +			if (mark->group == iter_info->current_group) {
> +				__release(&fsnotify_mark_srcu);
> +				goto fail;
> +			}
> +			/* This is a mark in an unrelated group, skip */
> +			mark = fsnotify_next_mark(mark);
> +			iter_info->marks[type] = mark;
>  		}
>  	}
>  
>  	/*
> -	 * Now that both marks are pinned by refcount in the inode / vfsmount
> +	 * Now that all marks are pinned by refcount in the inode / vfsmount / etc
>  	 * lists, we can drop SRCU lock, and safely resume the list iteration
>  	 * once userspace returns.
>  	 */
> diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
> index 95985400d3d8..e5cde39d6e85 100644
> --- a/include/linux/fsnotify_backend.h
> +++ b/include/linux/fsnotify_backend.h
> @@ -915,6 +915,7 @@ extern void fsnotify_clear_marks_by_group(struct fsnotify_group *group,
>  					  unsigned int obj_type);
>  extern void fsnotify_get_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_put_mark(struct fsnotify_mark *mark);
> +struct fsnotify_mark *fsnotify_next_mark(struct fsnotify_mark *mark);
>  extern void fsnotify_finish_user_wait(struct fsnotify_iter_info *iter_info);
>  extern bool fsnotify_prepare_user_wait(struct fsnotify_iter_info *iter_info);
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
