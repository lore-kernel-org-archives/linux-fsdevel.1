Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DE5301460
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 May 2026 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779724543; cv=none; b=LJQ56xQUnPlCI0sJ/I6lyIjVdNK6ZFb0t5/7WTmQ3irO8LXpwOdpcJ5MmtpLpLpSsQogB/fRMHh5A1fUcQn8FYBMKFe0oLe0oXMiGWqaZqCD4IAQE+BVnX/0Yy97cw9k2CQSdSaTUaIpeTt5V9icxp4A+V1DbmBI1C7sI3gPrCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779724543; c=relaxed/simple;
	bh=sUPVPnbUbHuM3k1XVaGfEwZJ/PGCME1FfvzlS9CJUnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUb6VVXUqHMsydPYTd2JNWpqLB8phwxoWVKcKRnyjsJoqGOLxQxtRePFa0FY/7KelFX2h8MhQy+uMCzewqLdy5LMlgEcmdFGi0tT2hTW/VkQRAFRRCuGmASoikxFWtWHvmQJGGoWU972z4KZZDoKBuvrs8wmIcssBKN7zFXgytI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ebva/QSd; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HP439sGO; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Nq8Ozc5k; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1U7ZP3P+; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ebva/QSd";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HP439sGO";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Nq8Ozc5k";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1U7ZP3P+"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1B71F6AE38;
	Mon, 25 May 2026 15:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779724540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFTB416zaYImJpae+knx/1O64hBY/Ve2Ked3azpdBo=;
	b=ebva/QSdJcwWiC5jSa4kPe8BDWLb0iZVzPUC6LjUarwh7+vUkWO+jTqRq3P/RKOzilejsM
	aiA2mrL7i75YYSrm9vQhQ1skYqlk+hXW6gnr+gSoVoppleSYI5VfN7QX57b8mvfNTK/h3d
	P4B1VIB20FFyN7b7iXqaBJ6DeARWAZ4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779724540;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFTB416zaYImJpae+knx/1O64hBY/Ve2Ked3azpdBo=;
	b=HP439sGOxORg48OYtIi6Df4O+nsm7c0GECiqcr9ryd8P9+SjuXlqiJkcLQApJMse3w5lFu
	dV3IAGNG+AKahIBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nq8Ozc5k;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1U7ZP3P+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779724539; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFTB416zaYImJpae+knx/1O64hBY/Ve2Ked3azpdBo=;
	b=Nq8Ozc5kCMFQaw2/0iHhAxhhNbxvblEWBtTuDlGcV6HybgcdaopLvQdOBoU6ozC145ClC4
	g4IvoBdJCM0tToZqUjX5Mf1O6lWJlFMG8UYKInkvhpKAGc3ddmAdd4ivyS3qq5Wm7FJqwD
	aKwjCnpIGZmW8sKQ7mBj4leUpk4SeNc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779724539;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ffFTB416zaYImJpae+knx/1O64hBY/Ve2Ked3azpdBo=;
	b=1U7ZP3P+Olk9L6zBcLbeoBo2sEOmGdO2S41uB7cPbei1pgeQ2X0mF/hLBcjfGopm7SQyk0
	P9VVN4lP5f3HUHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 120F059D0E;
	Mon, 25 May 2026 15:55:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8aBhBPtwFGotCQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 25 May 2026 15:55:39 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9A95FA08D7; Mon, 25 May 2026 17:55:34 +0200 (CEST)
Date: Mon, 25 May 2026 17:55:34 +0200
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: retire stale comment in fget_task_next()
Message-ID: <735qme4elgwdugsqdigtbgnmwzgadrql2nwj35k6p7v5a4tsox@jtikyqqzupbr>
References: <20260522142152.1515572-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522142152.1515572-1-mjguzik@gmail.com>
X-Spam-Score: -4.01
X-Rspamd-Queue-Id: 1B71F6AE38
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
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO

On Fri 22-05-26 16:21:52, Mateusz Guzik wrote:
> The routine originally showed up in e9a53aeb5e0a838f ("file: Implement
> task_lookup_next_fd_rcu"), afterwards it got renamed and started
> entering RCU on its own in 8fd3395ec9051a52 ("get rid of
> ...lookup...fdget_rcu() family").
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>

Right. Thanks for the fixup. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/file.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index e5c75b22e0c7..628ca07dc4b1 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1133,7 +1133,6 @@ struct file *fget_task(struct task_struct *task, unsigned int fd)
>  
>  struct file *fget_task_next(struct task_struct *task, unsigned int *ret_fd)
>  {
> -	/* Must be called with rcu_read_lock held */
>  	struct files_struct *files;
>  	unsigned int fd = *ret_fd;
>  	struct file *file = NULL;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
