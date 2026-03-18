Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F611321457
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2026 18:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773858233; cv=none; b=dlrRwbzK4SiPZA6Gux6RhzAvZR+626Pp3TM8j89X92dU2WAEkdwuGLwU5U4W/+mOKd5S5uLZj4qWlFv4UpCgrjrs9kfq/kL7KffW/RAfhqGmgIlT/jG9Ym3xFGk1W6kCZSm9BbYEKm/69Nknpia/m849L7kKWZhmo0r1LgeY4bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773858233; c=relaxed/simple;
	bh=zQhyCk0tmM4NS7qYY14d+IZ5F2iSBHisOmwUXCP4x7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiSpNG8m8Pqv/AJdYi3kF0ex2fekHmtXIIeI0BUAzeCGErQCfjwY5c17tCkC/ABE6hELWq1ugr+D0CsGypdvecnlGdHas68s3sbDzM4ljBriZ4PHLJEU3NTKnF9EW+RUeiOySm3fgSzlXndFumJEqjCjpQJ90RA6FUTLIHNGiXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LqUgwG0d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jwZK8yFW; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LqUgwG0d; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jwZK8yFW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LqUgwG0d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jwZK8yFW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LqUgwG0d";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jwZK8yFW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8D2B05BED7;
	Wed, 18 Mar 2026 18:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773858230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xajanato9h7sXXE8mz9xc4dhWHvfL/TSeCdbBO+AFic=;
	b=LqUgwG0dNVsvo4Qntr/1nDLoG+J6TikeegH4+hMxxxuQp6G8Lz9bO8lMIHlF6SWVIQWx8T
	XSRScRh9Dr+Xp9Wkd2hYTcnIRHR6YLQoSnfvtwZ8DAsD5XgvEd+GPhjMXPJzKkRHNY2BtS
	tQ404bCgFFR62puxOcSjbolpOkGIucs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773858230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xajanato9h7sXXE8mz9xc4dhWHvfL/TSeCdbBO+AFic=;
	b=jwZK8yFWDLYLwPRRby1/b5KEv9ut4JFIybtGpExTt0LjfQvM5evvTO6SzJIR43xUiSyDoM
	bMI2ZJLK9e2asiAg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LqUgwG0d;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jwZK8yFW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773858230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xajanato9h7sXXE8mz9xc4dhWHvfL/TSeCdbBO+AFic=;
	b=LqUgwG0dNVsvo4Qntr/1nDLoG+J6TikeegH4+hMxxxuQp6G8Lz9bO8lMIHlF6SWVIQWx8T
	XSRScRh9Dr+Xp9Wkd2hYTcnIRHR6YLQoSnfvtwZ8DAsD5XgvEd+GPhjMXPJzKkRHNY2BtS
	tQ404bCgFFR62puxOcSjbolpOkGIucs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773858230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xajanato9h7sXXE8mz9xc4dhWHvfL/TSeCdbBO+AFic=;
	b=jwZK8yFWDLYLwPRRby1/b5KEv9ut4JFIybtGpExTt0LjfQvM5evvTO6SzJIR43xUiSyDoM
	bMI2ZJLK9e2asiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 851554273B;
	Wed, 18 Mar 2026 18:23:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xcF4ILbtumnLWwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Mar 2026 18:23:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3EF92A0AFF; Wed, 18 Mar 2026 19:23:46 +0100 (CET)
Date: Wed, 18 Mar 2026 19:23:46 +0100
From: Jan Kara <jack@suse.cz>
To: Hyungjung Joo <jhj140711@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, jack@suse.cz, greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/mbcache: cancel shrink work before destroying the
 cache
Message-ID: <2gfhz2lactpa4y335h555m63sl7notep4fcroycurcvsbhc7f6@bgmqdanllwfl>
References: <20260317054556.1821600-1-jhj140711@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317054556.1821600-1-jhj140711@gmail.com>
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 8D2B05BED7
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue 17-03-26 14:45:56, Hyungjung Joo wrote:
> From: HyungJung Joo <jhj140711@gmail.com>
> 
> mb_cache_destroy() calls shrinker_free() and then frees all cache
> entries and the cache itself, but it does not cancel the pending
> c_shrink_work work item first.
> 
> If mb_cache_entry_create() schedules c_shrink_work via schedule_work()
> and the work item is still pending or running when mb_cache_destroy()
> runs, mb_cache_shrink_worker() will access the cache after its memory
> has been freed, causing a use-after-free.
> 
> This is only reachable by a privileged user (root or CAP_SYS_ADMIN)
> who can trigger the last put of a mounted ext2/ext4/ocfs2 filesystem.
> 
> Cancel the work item with cancel_work_sync() before calling
> shrinker_free(), ensuring the worker has finished and will not be
> rescheduled before the cache is torn down.
> 
> Signed-off-by: Hyungjung Joo <jhj140711@gmail.com>

Thanks! The patch looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> ---
>  fs/mbcache.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/mbcache.c b/fs/mbcache.c
> index 480d02d6ebf0..2a6319b4072c 100644
> --- a/fs/mbcache.c
> +++ b/fs/mbcache.c
> @@ -406,6 +406,7 @@ void mb_cache_destroy(struct mb_cache *cache)
>  {
>  	struct mb_cache_entry *entry, *next;
>  
> +	cancel_work_sync(&cache->c_shrink_work);
>  	shrinker_free(cache->c_shrink);
>  
>  	/*
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
