Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44673C7DE8
	for <linux-fsdevel@vger.kernel.org>; Tue, 17 Mar 2026 13:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752491; cv=none; b=pFQWhekIssu//nsCcmZwhe/sECRrkdWm+fcDcAVqOMQ43ViYV9kg7XJRt8Ue7C9ImOPuzpJPV3/kMf0kNwNEMVeSWySdqckC0e9Ot0ec5eREvT1sS/nIBlcYe2Na95zH1ZOAusWWANjuWZlJtitNWhMRPDnyjClExl4CMA7izbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752491; c=relaxed/simple;
	bh=Inq/O9U2OJiq+ry2+YklTjSg5QryBQ0p6FQMqI5VbUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ue2HvZm889JYZN54TGup/fy6pTl2JQ/qdephSwkydHYKy/lckZgW91fKDxSG4MNdcSrFCGei/HIGYJKIuXMg41PKvIFK+zCwjP2lJqIDasuays3hNLEmWfQL/PjEDWmPmEOVe4zb5vlp0n0P1bewPY0T9e7GYBbRbR/nl9UjpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1ZbSyLF8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L23DQJZY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=biy36yIe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Vr39AY1J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1ZbSyLF8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L23DQJZY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="biy36yIe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Vr39AY1J"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 130B84D333;
	Tue, 17 Mar 2026 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773752482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyQ72e+qdVPgxmISXU8q16dGSDLn/VGys/a7wJjNCgQ=;
	b=1ZbSyLF82WDLWGmDStBO6OMamSvRgPWKEk2gBREELnqW2rnu4Xi1cdA7b2T3qZOK1ANemv
	2UphAvEaoZBTjs4CWSF5Y6jky8pLU8n928kdPLr0Mnwt6DhxCzEr9ciqz9qykhUPS7kqJU
	gCvY0jsjRKi9A+Us8eqX6dbE1JtEZzk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773752482;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyQ72e+qdVPgxmISXU8q16dGSDLn/VGys/a7wJjNCgQ=;
	b=L23DQJZYNxjO5nK/4YoBVlZChcLX5oQaCEkKUNKL43eJVQhOgz/glpJKTVR+m5t1iDXiuy
	BBy0ddvDH0UXrZBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773752477; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyQ72e+qdVPgxmISXU8q16dGSDLn/VGys/a7wJjNCgQ=;
	b=biy36yIeN5uMz3mdWRWSagBw4/5u50AY/CXmN59mIUJbkSkxSZtVptklHJkuyZZAsMg1FF
	8ISNMAO68DxHXcgzWdZguPqu52hJ0T0h3w4sz8Plc4i0LgGDDxPKqL4VvqaRC1GHHnxoXM
	6B64sv9meQIgvGK4qu7/SgU5jidqHLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773752477;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hyQ72e+qdVPgxmISXU8q16dGSDLn/VGys/a7wJjNCgQ=;
	b=Vr39AY1JHHE9ZDdo53oddYX0LZ5ODB+PjBDas9AmCWFqShKrEcfzmhKoaORQytkI5mJGKm
	a43ge/mrnBov6TCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0787B4273B;
	Tue, 17 Mar 2026 13:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ax3PAZ1QuWlvJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 17 Mar 2026 13:01:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C1CE4A0A5B; Tue, 17 Mar 2026 14:01:12 +0100 (CET)
Date: Tue, 17 Mar 2026 14:01:12 +0100
From: Jan Kara <jack@suse.cz>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	"Lai, Yi" <yi1.lai@linux.intel.com>
Subject: Re: [PATCH] fs: revert insert_inode_locked() eviction wait change
 and explain why
Message-ID: <yojtdduvndkyez7mzyah2fznxtztf5boonyxwicp6zb6zw52ao@h6g6zcxhvz3w>
References: <20260316103306.1258289-1-mjguzik@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260316103306.1258289-1-mjguzik@gmail.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	RSPAMD_EMAILBL_FAIL(0.00)[mjguzik.gmail.com:server fail];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Mon 16-03-26 11:33:05, Mateusz Guzik wrote:
> It causes a deadlock, reproducer can be found here:
> https://lore.kernel.org/linux-fsdevel/abNvb2PcrKj1FBeC@ly-workstation/
> 
> The real bug is in ext4, but I'm not digging into it and a working order
> needs to be restored.

I can dig into that. I expect ext4 ends up calling find_inode() from its
ext4_evict_inode() handler or something like that? I was searching for such
occurrence for a while but I didn't find it so can you share where ext4
blocked? Because the stacktraces from the original report just show the
journalling machinery hangs but those are only side-effects of somebody
hanging in ext4 with the transaction handle started... Thanks!

								Honza

> 
> Commentary is added as a warning sign for another sucker^Wdeveloper.
> 
> Fixes: 88ec797c468097a8 ("fs: make insert_inode_locked() wait for inode destruction")
> Reported-by: "Lai, Yi" <yi1.lai@linux.intel.com>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> generated against master
> 
> FYI next has a change which has a trivial conflic (ino type change)
> 
>  fs/inode.c | 53 +++++++++++++++++++++++++++++------------------------
>  1 file changed, 29 insertions(+), 24 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index cc12b68e021b..5f7e76c9fb53 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1037,20 +1037,19 @@ long prune_icache_sb(struct super_block *sb, struct shrink_control *sc)
>  	return freed;
>  }
>  
> -static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked);
> -
> +static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked);
>  /*
>   * Called with the inode lock held.
>   */
>  static struct inode *find_inode(struct super_block *sb,
>  				struct hlist_head *head,
>  				int (*test)(struct inode *, void *),
> -				void *data, bool hash_locked,
> +				void *data, bool is_inode_hash_locked,
>  				bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> -	if (hash_locked)
> +	if (is_inode_hash_locked)
>  		lockdep_assert_held(&inode_hash_lock);
>  	else
>  		lockdep_assert_not_held(&inode_hash_lock);
> @@ -1064,7 +1063,7 @@ static struct inode *find_inode(struct super_block *sb,
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode, hash_locked, true);
> +			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
>  		if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1088,11 +1087,11 @@ static struct inode *find_inode(struct super_block *sb,
>   */
>  static struct inode *find_inode_fast(struct super_block *sb,
>  				struct hlist_head *head, unsigned long ino,
> -				bool hash_locked, bool *isnew)
> +				bool is_inode_hash_locked, bool *isnew)
>  {
>  	struct inode *inode = NULL;
>  
> -	if (hash_locked)
> +	if (is_inode_hash_locked)
>  		lockdep_assert_held(&inode_hash_lock);
>  	else
>  		lockdep_assert_not_held(&inode_hash_lock);
> @@ -1106,7 +1105,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
>  			continue;
>  		spin_lock(&inode->i_lock);
>  		if (inode_state_read(inode) & (I_FREEING | I_WILL_FREE)) {
> -			__wait_on_freeing_inode(inode, hash_locked, true);
> +			__wait_on_freeing_inode(inode, is_inode_hash_locked);
>  			goto repeat;
>  		}
>  		if (unlikely(inode_state_read(inode) & I_CREATING)) {
> @@ -1842,13 +1841,28 @@ int insert_inode_locked(struct inode *inode)
>  	while (1) {
>  		struct inode *old = NULL;
>  		spin_lock(&inode_hash_lock);
> -repeat:
>  		hlist_for_each_entry(old, head, i_hash) {
>  			if (old->i_ino != ino)
>  				continue;
>  			if (old->i_sb != sb)
>  				continue;
>  			spin_lock(&old->i_lock);
> +			/*
> +			 * FIXME: inodes awaiting eviction don't get waited for
> +			 *
> +			 * This is a bug because the hash can temporarily end up with duplicate inodes.
> +			 * It happens to work becuase new inodes are inserted at the beginning of the
> +			 * chain, meaning they will be found first should anyone do a lookup.
> +			 *
> +			 * Fixing the above results in deadlocks in ext4 due to journal handling during
> +			 * inode creation and eviction -- the eviction side waits for creation side to
> +			 * finish. Adding __wait_on_freeing_inode results in both sides waiting on each
> +			 * other.
> +			 */
> +			if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> +				spin_unlock(&old->i_lock);
> +				continue;
> +			}
>  			break;
>  		}
>  		if (likely(!old)) {
> @@ -1859,11 +1873,6 @@ int insert_inode_locked(struct inode *inode)
>  			spin_unlock(&inode_hash_lock);
>  			return 0;
>  		}
> -		if (inode_state_read(old) & (I_FREEING | I_WILL_FREE)) {
> -			__wait_on_freeing_inode(old, true, false);
> -			old = NULL;
> -			goto repeat;
> -		}
>  		if (unlikely(inode_state_read(old) & I_CREATING)) {
>  			spin_unlock(&old->i_lock);
>  			spin_unlock(&inode_hash_lock);
> @@ -2534,18 +2543,16 @@ EXPORT_SYMBOL(inode_needs_sync);
>   * wake_up_bit(&inode->i_state, __I_NEW) after removing from the hash list
>   * will DTRT.
>   */
> -static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool rcu_locked)
> +static void __wait_on_freeing_inode(struct inode *inode, bool is_inode_hash_locked)
>  {
>  	struct wait_bit_queue_entry wqe;
>  	struct wait_queue_head *wq_head;
>  
> -	VFS_BUG_ON(!hash_locked && !rcu_locked);
> -
>  	/*
>  	 * Handle racing against evict(), see that routine for more details.
>  	 */
>  	if (unlikely(inode_unhashed(inode))) {
> -		WARN_ON(hash_locked);
> +		WARN_ON(is_inode_hash_locked);
>  		spin_unlock(&inode->i_lock);
>  		return;
>  	}
> @@ -2553,16 +2560,14 @@ static void __wait_on_freeing_inode(struct inode *inode, bool hash_locked, bool
>  	wq_head = inode_bit_waitqueue(&wqe, inode, __I_NEW);
>  	prepare_to_wait_event(wq_head, &wqe.wq_entry, TASK_UNINTERRUPTIBLE);
>  	spin_unlock(&inode->i_lock);
> -	if (rcu_locked)
> -		rcu_read_unlock();
> -	if (hash_locked)
> +	rcu_read_unlock();
> +	if (is_inode_hash_locked)
>  		spin_unlock(&inode_hash_lock);
>  	schedule();
>  	finish_wait(wq_head, &wqe.wq_entry);
> -	if (hash_locked)
> +	if (is_inode_hash_locked)
>  		spin_lock(&inode_hash_lock);
> -	if (rcu_locked)
> -		rcu_read_lock();
> +	rcu_read_lock();
>  }
>  
>  static __initdata unsigned long ihash_entries;
> -- 
> 2.48.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
