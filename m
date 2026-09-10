Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80433F5A5;
	Thu, 10 Sep 2026 08:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029265; cv=none; b=lCFiZyci/IgzJ5TGJK52eGbPWP3+nIUVCKvcI0m1hENPAABb0xD7zZdnXL4P3Fm3BQL6BSOv565Q5ZMgA4z1HfzCWtOLo8sJwU+XmLMIgZh9yA/5VzLiex+TVqUuo5ee7/i+elIiF45zsw7OWF+ihGFyToVdWXGk7Z+gzWqyP+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029265; c=relaxed/simple;
	bh=yN/g2JUqCAILCiTxkpNBVaHCrvzz/9KDwcBHkvCg2GE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZGdphtRbirdC283wf6tbh/RH5J6WMXDPMgECLVnZr3bNducFQIwi3Z9jA6fYvbzFa8J8T8+o82GfLpQR71f6OMZbMELwFKNraOaD9+DlcTn9aY6/sp0TDKYhAZofYNkOjHQVWSrmwJaLS1GDZa2q4kwE6p6PjFUuihEsdaOOE94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nHSSN/0Q; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ue6td+Li; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=N6uLuSCv; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jLUi0+BF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nHSSN/0Q";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ue6td+Li";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="N6uLuSCv";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jLUi0+BF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B19E321C55;
	Thu, 10 Sep 2026 08:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789029257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/xslGH7/S7wBfSOYVRcDNKymKpwasdTe6P0pCKQm3g=;
	b=nHSSN/0QkXHgvRFMRbMm37v4Pxh8p40Wlpoen9p5PqRgZh2XuWRokHGoz+aFaeDF0rH1AN
	5pUii7uEMwSny/5ECNdpMH7VNl6Z6C+OXQhfeHTxwc0AyNlkapmFHluNCYzy+F7Z3MGRCT
	KY2K5Vdl9zHvHmBhDyBh3c26ii0AfV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789029257;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/xslGH7/S7wBfSOYVRcDNKymKpwasdTe6P0pCKQm3g=;
	b=ue6td+LiV51soP5baVHkrVzbNe+Una1AaDwidUzh1Khx3z05IEqMMT62Aj5gbGey/UGoo+
	rI1x9fuz4wJlYNBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789029253; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/xslGH7/S7wBfSOYVRcDNKymKpwasdTe6P0pCKQm3g=;
	b=N6uLuSCvRDpidGyjLG0YvuUIhxYaJi5N5zxQm+AkWQjb90ixpdbICpVDG9G2V46NP4QM/1
	TS9w8AbL6XtW+LRZktx7CW2oACI3g0uQDqQJ717Q+AHAJYlPnYIHWkTBzU6xXJ3t9SYFJi
	6G+jyCj9GH9o5/Bt4ebyHUdrQ66b/nY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789029253;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/xslGH7/S7wBfSOYVRcDNKymKpwasdTe6P0pCKQm3g=;
	b=jLUi0+BFL0cvmAWobd7DEBy/z8TrIZYTYbBK3i3CTujsI2eboUpC+UUdueIXsLwUcmbGtn
	YZwKgCanNdmIeUAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8222F13A5C;
	Thu, 10 Sep 2026 08:34:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Id++H4VromrQWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 10 Sep 2026 08:34:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0D8CFA12EA; Thu, 10 Sep 2026 10:34:09 +0200 (CEST)
Date: Thu, 10 Sep 2026 10:34:09 +0200
From: Jan Kara <jack@suse.cz>
To: Jia Zhu <zhujia.zj@bytedance.com>
Cc: jack@suse.cz, amir73il@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsnotify: avoid unrelated mark reaper waits during group
 teardown
Message-ID: <4467cbj7eivubtdwcawvr7mhrb7armgoc4xfqjjnncrbkxxag6@3mmou6nhviao>
References: <20260909170833.5663-1-zhujia.zj@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909170833.5663-1-zhujia.zj@bytedance.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,bytedance.com:email,suse.com:email]
X-Spam-Flag: NO

On Thu 10-09-26 01:08:33, Jia Zhu wrote:
> fsnotify_destroy_group() unconditionally flushes the global mark reaper,
> so an empty inotify instance can hang on unrelated reclamation during
> close or task exit:
> 
>   do_exit
>     __fput
>       inotify_release
>         fsnotify_destroy_group
>           fsnotify_wait_marks_destroyed
>             __flush_work
> 
> Skip the flush when only the closing reference remains, allowing teardown
> to finish without waiting for unrelated SRCU readers.

Yes, but is it really practically relevant? The optimization you add really
only works in the case when you have no notification marks in a group when
entering inotify_release(). Usually though you actually want to get
notified about something and thus do have some notification marks :) and in
that case fsnotify_clear_marks_by_group() -> fsnotify_put_mark() will add
marks to the list for the reaper to process. So please explain why this
corner case practically matters to you.

								Honza

> Verified in QEMU: empty groups and groups whose marks have been reclaimed
> exit while an unrelated SRCU reader remains held; groups with pending
> reclamation still wait.
> 
> Signed-off-by: Jia Zhu <zhujia.zj@bytedance.com>
> ---
>  fs/notify/group.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/notify/group.c b/fs/notify/group.c
> index b56d1c1d9644a..052a419ee52a6 100644
> --- a/fs/notify/group.c
> +++ b/fs/notify/group.c
> @@ -46,6 +46,7 @@ void fsnotify_group_stop_queueing(struct fsnotify_group *group)
>   * the group reference.
>   * Note that another thread calling fsnotify_clear_marks_by_group() may still
>   * hold a ref to the group.
> + * The caller must hold a reference and exclude new marks.
>   */
>  void fsnotify_destroy_group(struct fsnotify_group *group)
>  {
> @@ -67,19 +68,22 @@ void fsnotify_destroy_group(struct fsnotify_group *group)
>  	 */
>  	wait_event(group->notification_waitq, !atomic_read(&group->user_waits));
>  
> -	/*
> -	 * Wait until all marks get really destroyed. We could actually destroy
> -	 * them ourselves instead of waiting for worker to do it, however that
> -	 * would be racy as worker can already be processing some marks before
> -	 * we even entered fsnotify_destroy_group().
> -	 */
> -	fsnotify_wait_marks_destroyed();
> +	/* Even detached marks hold a group reference until final destruction. */
> +	if (refcount_read(&group->refcnt) == 1) {
> +		/*
> +		 * Pair the refcount read and this barrier with the release
> +		 * decrement in fsnotify_put_group() (refcount_dec_and_test()),
> +		 * ordering mark destruction before subsequent group teardown.
> +		 */
> +		smp_mb();
> +	} else {
> +		fsnotify_wait_marks_destroyed();
> +	}
>  
>  	/*
> -	 * Since we have waited for fsnotify_mark_srcu in
> -	 * fsnotify_mark_destroy_list() there can be no outstanding event
> -	 * notification against this group. So clearing the notification queue
> -	 * of all events is reliable now.
> +	 * Mark destruction waits for fsnotify_mark_srcu, so there can be no
> +	 * outstanding event notification against this group. Clearing the
> +	 * notification queue of all events is reliable now.
>  	 */
>  	fsnotify_flush_notify(group);
>  
> -- 
> 2.20.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
