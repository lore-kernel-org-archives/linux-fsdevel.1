Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2047F3F077C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jul 2026 09:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785405329; cv=none; b=NN43YaDlxSYNkiFamRLPf/7qkzcywTFpetI58htdyDf02F67VRyTTAXtlB9dtirRyK76t2GrmiqR9qS3y7uv7XrSH7RcCXWfHos73eK1NXnHg1Jr1EkMkblZqrk6zz3GVfZR/eNtMhTL2iEaxam8NCM/KKv83pdQ0yY5s2byRCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785405329; c=relaxed/simple;
	bh=NN5DglDqgdJsrbRR5xYJGMIaRv3PpIdfbUmgoXlCYRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBRQgDV00FZXbexfXbsVD9N7+jpQByAiU+ufjpdJFBKzhUhOeLb+13wmkgJT94iRTmporwptqbMkkpDTppnG5LWT7UjeNcZnSWNytIBylMQMh+JUFTDr7wvqMa3GjWJd+vzGf2hWQcXpv/peEMd7XEQl2dutSsTwX9bDZ/QLUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s0SmiD8j; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6FCjOi8d; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=clmzEMkf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hCUScesa; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s0SmiD8j";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6FCjOi8d";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="clmzEMkf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hCUScesa"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 123087D689;
	Thu, 30 Jul 2026 09:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785405322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JU1MuuKcNshChp0kpIqIePaWV32sCq7W2J+yC/5JCIQ=;
	b=s0SmiD8jDqp9VFY2fEpv7uqott+1XN5+c3cGwBs4royhcqZR3tkGUqQeZtQCDbixxivW9v
	aXlw3ywKxs5sAnoqTauriyNkLGAbz8maag6m/KK2apOcay626Vf+Z95Tw1UZWt5vS0oZvb
	bMe/j7eksPxSc6vQTVto+QQx4LkGbzU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785405322;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JU1MuuKcNshChp0kpIqIePaWV32sCq7W2J+yC/5JCIQ=;
	b=6FCjOi8dQWkTsGaqEvKh5TEVWy/gFZJOOtfFkVaN53pZSPGu+ZC/LxXe4wwEBpw+mF7Y00
	1fjJ3KtMqNl3JIBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=clmzEMkf;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hCUScesa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1785405318; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JU1MuuKcNshChp0kpIqIePaWV32sCq7W2J+yC/5JCIQ=;
	b=clmzEMkf1LV976t7gPSV1VGCuh4fI3WZZi/1uIfRlh7DCskkXm+way6F6NURvwxesVHB6C
	JCzUplaWxykUaUY27ymRT1kaYt4eiAOdJ5VGObBdqezlaTqOX3wGQasNtAYI+1S4XvseT2
	NWAr0zaEGg6KORBpPQVHh6cCjN4YWOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1785405318;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JU1MuuKcNshChp0kpIqIePaWV32sCq7W2J+yC/5JCIQ=;
	b=hCUScesasr4pIcaqUh4XtsdCEBw17KJrNfRJEIN7WlbGWXHibyCPPBjECuLjN/x7FSLiL3
	pQST+Iu+iI2rerBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09EE0779CC;
	Thu, 30 Jul 2026 09:55:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ld1pAoYfa2rODwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Jul 2026 09:55:18 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AA66DA0AAA; Thu, 30 Jul 2026 11:55:17 +0200 (CEST)
Date: Thu, 30 Jul 2026 11:55:17 +0200
From: Jan Kara <jack@suse.cz>
To: Yichong Chen <chenyichong@uniontech.com>
Cc: jack@suse.cz, amir73il@gmail.com, repnop@google.com, 
	mszeredi@redhat.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fanotify: stop permission watchdog when timeout is zero
Message-ID: <c36jpd2r5u7k32gpllk5kottty4c2isnye7lqekexfuacnbg6f@krvenlamt4qp>
References: <20260730070648.549458-1-chenyichong@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730070648.549458-1-chenyichong@uniontech.com>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 123087D689
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,google.com,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu 30-07-26 15:06:48, Yichong Chen wrote:
> The fanotify permission watchdog can be disabled by writing zero to
> fs/fanotify/watchdog_timeout.  fanotify_perm_watchdog_group_add() already
> checks for a zero timeout before scheduling the watchdog.
> 
> However, once the watchdog work has been scheduled, perm_group_watchdog()
> unconditionally schedules itself again with the current timeout.  If the
> sysctl is changed to zero while the work is active, secs_to_jiffies(0)
> causes the work to be rescheduled immediately, resulting in a kworker
> busy loop.
> 
> Read the timeout once in perm_group_watchdog_schedule() and do not
> schedule the work when it is zero.  This lets a running watchdog stop
> after the next execution when the sysctl is set to zero.
> 
> Fixes: b8cf8fda522d ("fanotify: add watchdog for permission events")
> Signed-off-by: Yichong Chen <chenyichong@uniontech.com>

Thanks! I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify_user.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
> index b604e3da58ad..9ee373ff5840 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -112,7 +112,12 @@ static DECLARE_DELAYED_WORK(perm_group_work, perm_group_watchdog);
>  
>  static void perm_group_watchdog_schedule(void)
>  {
> -	schedule_delayed_work(&perm_group_work, secs_to_jiffies(perm_group_timeout));
> +	int timeout = READ_ONCE(perm_group_timeout);
> +
> +	if (!timeout)
> +		return;
> +
> +	schedule_delayed_work(&perm_group_work, secs_to_jiffies(timeout));
>  }
>  
>  static void perm_group_watchdog(struct work_struct *work)
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
