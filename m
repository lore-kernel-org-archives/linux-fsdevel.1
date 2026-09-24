Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46A73F9270
	for <linux-fsdevel@vger.kernel.org>; Thu, 24 Sep 2026 17:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790270050; cv=none; b=pbNbCLRORL/QMp6UcqcbKjZelAi4DL7br0UIp1gjXuYZI8PYmVPk0/Mae1bzpZPNW+Bc3y3wGNq+ygsAat4CAtBWTF0uMXqpwc1nX5mAnfswjQuzXKm0gF97qQrXzBDviPPHdR2UMgpoL2LcdPZxwGTYkxueKzl8x6/6EGJKtN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790270050; c=relaxed/simple;
	bh=GV0VNyJF2iRo34Aa+vNPYGE1uMGYVnASYqy3TWUCMB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h9OddQm2feH8NiQHCpLD24QIShMxdU6SV/a/K3o4Xb7w+6wduwvB1CLpDxrG6YNk6PTiFmNmP3PHug6XrLeDR34PqzHJ5gsteAFYIRPc07DNLhOsTCqZJWhihwn+k8PQNqNTLbxwKZTKJ+6maelUoGvL9MxeJqMqNzBGd1WvqZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YcwYBzzm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xt/ozwdj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=J9E1Mzd2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=2/tb7eyd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YcwYBzzm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xt/ozwdj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="J9E1Mzd2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="2/tb7eyd"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9EDA200B7;
	Thu, 24 Sep 2026 17:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790270042; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34QQgnL9tMrF4G/KJQ0uguI6HdkWU17L//R1PcmpFQM=;
	b=YcwYBzzmZfxI8Mj8KPD5qI+LRFPVIYk6J8XfUGcZsPoeZWH+kX8Kc27bEwTOzHqVXEHhWw
	0XK9rAjaQBmJzi8Yf/T+mM8Ir0hoU86YVXh8C9OGsK5Dg/ylrYpIQBlQN6zyX8FuuI9MSm
	p9O754uUooxWPmE8++U1+9pNxFr3kWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790270042;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34QQgnL9tMrF4G/KJQ0uguI6HdkWU17L//R1PcmpFQM=;
	b=xt/ozwdj1lmOrBTO0sDaW+P9HXIjoA/cFkK6tTKyUnz9yeVX8UPMKA1lCvGWsCgYDlsq1R
	/sRZ2oEXTuEW5kDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=J9E1Mzd2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="2/tb7eyd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790270038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34QQgnL9tMrF4G/KJQ0uguI6HdkWU17L//R1PcmpFQM=;
	b=J9E1Mzd2/1OXwQfm9fi7WrroIgHKnW7cGM8Q30ds98l74lLXvNNLMAW/SsIfPW9y94D3d6
	ceD0mP0vmk7R9RBC/DindpP6w1lPXnN69eWbL9xKNLSwD0mEjU1Pj3w/BrNJ8HbgUTrVmS
	IjRW9/Bvb5wNdW/IpxAQJpt2lVDHNVw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790270038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=34QQgnL9tMrF4G/KJQ0uguI6HdkWU17L//R1PcmpFQM=;
	b=2/tb7eyduZRuPIEktXTsi4L2DCfBb7A//qLEeztFP0I6AhvxeLPPLI+0orFufABmBJkClK
	BpkCwVvg6LdNfUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 814DB13354;
	Thu, 24 Sep 2026 17:13:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YtAUF1ZatWpKbgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 17:13:58 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FE15A132E; Thu, 24 Sep 2026 19:13:58 +0200 (CEST)
Date: Thu, 24 Sep 2026 19:13:58 +0200
From: Jan Kara <jack@suse.cz>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, Mikhail Rudenko <xyzzy@yandex-team.ru>
Subject: Re: [PATCH v2 3/5] fs: Basic infrastructure for offloading inode
 reclaim
Message-ID: <vqrehgmhhunigf65ldm7wttjsokbhfdyy2nmi7woteimd33mfr@q7kdegk5gwzb>
References: <20260923200927.1834507-1-agruenba@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923200927.1834507-1-agruenba@redhat.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9EDA200B7
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Wed 23-09-26 22:09:26, Andreas Gruenbacher wrote:
> Jan,
> 
> it seems that we don't really need struct inodes_to_prune; see below.

Thanks. Nice simplifications! I'll fold them in.

								Honza

> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 7c69ef44619a..f8303af66fcd 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -938,12 +938,6 @@ void evict_inodes(struct super_block *sb)
>  }
>  EXPORT_SYMBOL_GPL(evict_inodes);
>  
> -struct inodes_to_prune {
> -	struct list_head freeable;
> -	struct list_head deferred;
> -	unsigned int deferred_count;
> -};
> -
>  /*
>   * Isolate the inode from the LRU in preparation for freeing it.
>   *
> @@ -958,7 +952,7 @@ struct inodes_to_prune {
>  static enum lru_status inode_lru_isolate(struct list_head *item,
>  		struct list_lru_one *lru, void *arg)
>  {
> -	struct inodes_to_prune *lists = arg;
> +	struct list_head *freeable = arg;
>  	struct inode	*inode = container_of(item, struct inode, i_lru);
>  
>  	/*
> @@ -1013,13 +1007,7 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  
>  	WARN_ON(inode_state_read(inode) & I_NEW);
>  	inode_state_set(inode, I_FREEING);
> -	/* Inode will take long time to cleanup. Offload that to worker. */
> -	if (inode_state_read(inode) & I_DEFER_RECLAIM) {
> -		list_lru_isolate_move(lru, &inode->i_lru, &lists->deferred);
> -		lists->deferred_count++;
> -	} else {
> -		list_lru_isolate_move(lru, &inode->i_lru, &lists->freeable);
> -	}
> +	list_lru_isolate_move(lru, &inode->i_lru, freeable);
>  	spin_unlock(&inode->i_lock);
>  
>  	this_cpu_dec(nr_unused);
> @@ -1042,27 +1030,34 @@ static int get_deferred_sb_id(struct super_block *sb)
>   */
>  long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  {
> -	struct inodes_to_prune lists = {
> -		.freeable = LIST_HEAD_INIT(lists.freeable),
> -		.deferred = LIST_HEAD_INIT(lists.deferred),
> -	};
> -	long freed;
> +	struct inode *inode, *tmp;
> +	long freed, deferred = 0;
> +	LIST_HEAD(freeable);
>  
>  	freed = list_lru_shrink_walk(&sb->s_inode_lru, sc,
> -				     inode_lru_isolate, &lists);
> -	dispose_list(&lists.freeable);
> -	if (!list_empty(&lists.deferred)) {
> +				     inode_lru_isolate, &freeable);
> +
> +	list_for_each_entry_safe(inode, tmp, &freeable, i_lru) {
> +		if (inode_state_read(inode) & I_DEFER_RECLAIM) {
> +			deferred++;
> +			continue;
> +		}
> +		list_del_init(&inode->i_lru);
> +		evict(inode);
> +		cond_resched();
> +	}
> +
> +	if (!list_empty(&freeable)) {
>  		int id = get_deferred_sb_id(sb);
>  		int i, wake_count;
>  
>  		spin_lock(&deferred_reclaim.queues[id].lock);
> -		list_splice_tail(&lists.deferred,
> -				 &deferred_reclaim.queues[id].list);
> -		atomic_add(lists.deferred_count, &sb->s_deferred_reclaim_count);
> +		list_splice_tail(&freeable, &deferred_reclaim.queues[id].list);
> +		atomic_add(deferred, &sb->s_deferred_reclaim_count);
>  		spin_unlock(&deferred_reclaim.queues[id].lock);
>  
>  		/* Queue works to process inodes we've added to the list */
> -		wake_count = (lists.deferred_count + INODE_RECLAIM_BATCH_SIZE)
> +		wake_count = (deferred + INODE_RECLAIM_BATCH_SIZE)
>  						/ INODE_RECLAIM_BATCH_SIZE;
>  		if (wake_count > deferred_reclaim.workers)
>  			wake_count = deferred_reclaim.workers;
> -- 
> 2.55.0
> 
> Thanks,
> Andreas
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
