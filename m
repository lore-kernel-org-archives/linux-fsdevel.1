Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC2F4B2045;
	Tue,  8 Sep 2026 11:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788865300; cv=none; b=JRecCLZ2i8x8XLttCVp5ookOwYQHnuLharXnuCYktzN354K73kQVcvuj9X3AJ2ePcHu+sZ5VQ98sSsvvycKBql2oRSelEFFp/NwDqjJz9SK7IbyFeR9TImifTJX9HIMTGw1tWVR3euL6DvEjQF/mXLho9qTw113ErMUHOWaqReM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788865300; c=relaxed/simple;
	bh=06UIArTqQzVqivLJycw3xy8erq7CsfS+f95+kEcmXIU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj+qWO9BsXPN6KliZxikUpZQAcO2nFwkAnfHBgsb6b7YDP00C6HJS/72vGv+Xt/ejZJN9AC81942WE5d0v2baGXIhpLEqcx953lh+J19S08KeUbvlRg8vWZ1T/yhkQm4H7EzoixLmpzWkxIcIfb49Oq8DAydE3CcU6v4JeZzkUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pThjgWwz; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v5Y+v5V8; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gPORJ++h; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tvv92OAU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pThjgWwz";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v5Y+v5V8";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gPORJ++h";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tvv92OAU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2E2882120F;
	Tue,  8 Sep 2026 11:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788865292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmkm0Mn0ZPsCDRxVauvy2vcOyl8K0UpGlhINITeUl7E=;
	b=pThjgWwzlRJam6rd914ffuMbJ9whcWdlwlB/pUzS8sZgEjgKqOSrmnsiGUiLv6t/K6oztq
	74vPjr7nn1S1MIG5Sg8IehKUSasysOQ95MsClokhRVUYnpIPd8iUgvWHCx0WpJva7eHmh3
	lv7UGyzzKt2dAgiMI1kDYSnQF0PHOTU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788865292;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmkm0Mn0ZPsCDRxVauvy2vcOyl8K0UpGlhINITeUl7E=;
	b=v5Y+v5V8GELZ9VIVn5KBK6EAaK+t1FXpToTNjVRZL2YNXrWBq7y/ZovF0sA+WHHjn8/Rks
	bDIyd7FYcVvqfcCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788865288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmkm0Mn0ZPsCDRxVauvy2vcOyl8K0UpGlhINITeUl7E=;
	b=gPORJ++hpIyjhfM+WlC792O83GyzyEDAmC9QZt0mpl/bIwMtNqtkJ446XjQQfxKKcjWont
	04ZXmtc5nfa/a4kivR6blB38dTTuj9zSTAP33M1dEfv6gfY5Z8B35FJ9npG66h/E2V30I2
	ykoCbDhgsEy4VKsdlvGY/mNog3UJ2DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788865288;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vmkm0Mn0ZPsCDRxVauvy2vcOyl8K0UpGlhINITeUl7E=;
	b=Tvv92OAUEzun4hhJUZcP79PoDXrJPtIXHoU6rH5PyUfJDwGhNfjOCsxvnaEuej9zB84JEt
	cQ8augUuHOKar2AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C4301347F;
	Tue,  8 Sep 2026 11:01:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RKD5Agjrn2riOAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Sep 2026 11:01:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3AD25A12E2; Tue, 08 Sep 2026 13:01:23 +0200 (CEST)
Date: Tue, 8 Sep 2026 13:01:23 +0200
From: Jan Kara <jack@suse.cz>
To: Xin Yin <yinxin.x@bytedance.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] writeback: snapshot foreign flush pages
Message-ID: <matvd3klv4w7buhnjkdpllkautw3zu2e5hpjfdedvvoozpbfxj@z7joalz5an74>
References: <cover.1788836830.git.yinxin.x@bytedance.com>
 <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce170b76e9501d555b0af70cc8c45c248577400.1788836830.git.yinxin.x@bytedance.com>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Tue 08-09-26 11:23:52, Xin Yin wrote:
> WB_REASON_FOREIGN_FLUSH is best-effort writeback for foreign dirtying. It
> should write pages that are already visible to the target wb, but should
> not keep extending the same work with pages dirtied while the work is
> running.
> 
> Make foreign flushes use tagged writeback while preserving WB_SYNC_NONE
> semantics. Use the remaining work budget as the per-inode chunk, so a
> tagged pass is not truncated to the normal periodic chunk and a large
> inode still cannot exceed the finite work budget.
> 
> Queue b_dirty only once for each foreign-flush work. Later passes only
> retry b_more_io inodes skipped due to I_SYNC, and the work exits once
> b_io and b_more_io are drained. If the budget is consumed, redirty the
> inode instead of requeueing it to b_more_io so the same work cannot loop
> on a continuously dirtied inode.
> 
> Do not refresh dirtied_when for foreign flushes; later dirtying should be
> handled by later foreign, kupdate, or background writeback.
> 
> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
> Signed-off-by: Xin Yin <yinxin.x@bytedance.com>

I really dislike how your implementation ties the two writeback deadlock
avoidance schemes (nr_to_write for WB_SYNC_NONE writeback vs folio tagging
+ inode dirty timestamp for WB_SYNC_ALL writeback) together. But before we
get to the implementation details let's discuss the purpose a bit:

In principle I agree with you that the primary purpose of
cgroup_writeback_by_id() is that it wants to flush inodes that have folios
that are accounted to our memcg. It does this by a rather rough approach of
flushing the whole wb. If this races with other dirtying, it might happen
that we won't actually flush the foreign folios we want. Am I getting your
concern right? Are you able to actually observe such situation in practice?

								Honza

> ---
>  fs/fs-writeback.c         | 57 ++++++++++++++++++++++++++++++---------
>  include/linux/writeback.h |  1 +
>  2 files changed, 45 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
> index 7c2340a5dead..6c5d1c85b6f8 100644
> --- a/fs/fs-writeback.c
> +++ b/fs/fs-writeback.c
> @@ -40,6 +40,7 @@ struct wb_writeback_work {
>  	struct super_block *sb;
>  	enum writeback_sync_modes sync_mode;
>  	unsigned int tagged_writepages:1;
> +	unsigned int for_foreign_flush:1;
>  	unsigned int for_kupdate:1;
>  	unsigned int range_cyclic:1;
>  	unsigned int for_background:1;
> @@ -1174,6 +1175,12 @@ int cgroup_writeback_by_id(u64 bdi_id, int memcg_id,
>  	if (work) {
>  		work->nr_pages = dirty;
>  		work->sync_mode = WB_SYNC_NONE;
> +		/*
> +		 * Foreign flushes should write a snapshot of dirty pages without
> +		 * chasing concurrent dirtiers, but still honor the finite target
> +		 * wb budget calculated above.
> +		 */
> +		work->for_foreign_flush = 1;
>  		work->range_cyclic = 1;
>  		work->reason = reason;
>  		work->done = done;
> @@ -1553,18 +1560,21 @@ static int move_expired_inodes(struct list_head *delaying_queue,
>   *                                           +--> dequeue for IO
>   */
>  static void queue_io(struct bdi_writeback *wb, struct wb_writeback_work *work,
> -		     unsigned long dirtied_before)
> +		     unsigned long dirtied_before, bool queue_dirty)
>  {
> -	int moved;
> +	int moved = 0;
>  	unsigned long time_expire_jif = dirtied_before;
>  
>  	assert_spin_locked(&wb->list_lock);
>  	list_splice_init(&wb->b_more_io, &wb->b_io);
> -	moved = move_expired_inodes(&wb->b_dirty, &wb->b_io, dirtied_before);
> -	if (!work->for_sync)
> -		time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
> -	moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
> -				     time_expire_jif);
> +	if (queue_dirty) {
> +		moved = move_expired_inodes(&wb->b_dirty, &wb->b_io,
> +					    dirtied_before);
> +		if (!work->for_sync)
> +			time_expire_jif = jiffies - dirtytime_expire_interval * HZ;
> +		moved += move_expired_inodes(&wb->b_dirty_time, &wb->b_io,
> +					     time_expire_jif);
> +	}
>  	if (moved)
>  		wb_io_lists_populated(wb);
>  	trace_writeback_queue_io(wb, work, dirtied_before, moved);
> @@ -1651,11 +1661,13 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  
>  	/*
>  	 * Sync livelock prevention. Each inode is tagged and synced in one
> -	 * shot. If still dirty, it will be redirty_tail()'ed below.  Update
> -	 * the dirty time to prevent enqueue and sync it again.
> +	 * shot for WB_SYNC_ALL or unbudgeted tagged writeback. If still dirty,
> +	 * it will be redirty_tail()'ed below. Update the dirty time to prevent
> +	 * enqueue and sync it again.
>  	 */
>  	if ((inode_state_read(inode) & I_DIRTY) &&
> -	    (wbc->sync_mode == WB_SYNC_ALL || wbc->tagged_writepages))
> +	    (wbc->sync_mode == WB_SYNC_ALL ||
> +	     (wbc->tagged_writepages && !wbc->for_foreign_flush)))
>  		inode->dirtied_when = jiffies;
>  
>  	if (wbc->pages_skipped) {
> @@ -1678,6 +1690,7 @@ static void requeue_inode(struct inode *inode, struct bdi_writeback *wb,
>  		 * sometimes bales out without doing anything.
>  		 */
>  		if (wbc->nr_to_write <= 0 &&
> +		    !wbc->for_foreign_flush &&
>  		    !inode_dirtied_after(inode, dirtied_before)) {
>  			/* Slice used up. Queue for next turn. */
>  			requeue_io(inode, wb);
> @@ -1918,6 +1931,8 @@ static long writeback_chunk_size(struct super_block *sb,
>  	 *                   (quickly) tag currently dirty pages
>  	 *                   (maybe slowly) sync all tagged pages
>  	 */
> +	if (work->for_foreign_flush)
> +		return work->nr_pages;
>  	if (work->sync_mode == WB_SYNC_ALL || work->tagged_writepages)
>  		return LONG_MAX;
>  
> @@ -1943,7 +1958,9 @@ static long writeback_sb_inodes(struct super_block *sb,
>  {
>  	struct writeback_control wbc = {
>  		.sync_mode		= work->sync_mode,
> -		.tagged_writepages	= work->tagged_writepages,
> +		.tagged_writepages	= work->tagged_writepages ||
> +					  work->for_foreign_flush,
> +		.for_foreign_flush	= work->for_foreign_flush,
>  		.for_kupdate		= work->for_kupdate,
>  		.for_background		= work->for_background,
>  		.for_sync		= work->for_sync,
> @@ -2141,7 +2158,7 @@ static long writeback_inodes_wb(struct bdi_writeback *wb, long nr_pages,
>  	blk_start_plug(&plug);
>  	spin_lock(&wb->list_lock);
>  	if (list_empty(&wb->b_io))
> -		queue_io(wb, &work, jiffies);
> +		queue_io(wb, &work, jiffies, true);
>  	__writeback_inodes_wb(wb, &work);
>  	spin_unlock(&wb->list_lock);
>  	blk_finish_plug(&plug);
> @@ -2202,6 +2219,13 @@ static long wb_writeback(struct bdi_writeback *wb,
>  
>  		spin_lock(&wb->list_lock);
>  
> +		if (queued && work->for_foreign_flush &&
> +		    list_empty(&wb->b_io) &&
> +		    list_empty(&wb->b_more_io)) {
> +			spin_unlock(&wb->list_lock);
> +			break;
> +		}
> +
>  		trace_writeback_start(wb, work);
>  		if (list_empty(&wb->b_io)) {
>  			/*
> @@ -2217,7 +2241,14 @@ static long wb_writeback(struct bdi_writeback *wb,
>  			} else if (work->for_background)
>  				dirtied_before = jiffies;
>  
> -			queue_io(wb, work, dirtied_before);
> +			/*
> +			 * After the initial queue_io() pass, a foreign flush may
> +			 * still have I_SYNC-skipped inodes on b_more_io.  Move
> +			 * those back to b_io without selecting another batch from
> +			 * b_dirty.
> +			 */
> +			queue_io(wb, work, dirtied_before,
> +				 !work->for_foreign_flush || !queued);
>  			queued = true;
>  		}
>  		if (work->sb)
> diff --git a/include/linux/writeback.h b/include/linux/writeback.h
> index e530112c4b3a..096f0963d104 100644
> --- a/include/linux/writeback.h
> +++ b/include/linux/writeback.h
> @@ -59,6 +59,7 @@ struct writeback_control {
>  	unsigned for_kupdate:1;		/* A kupdate writeback */
>  	unsigned for_background:1;	/* A background writeback */
>  	unsigned tagged_writepages:1;	/* tag-and-write to avoid livelock */
> +	unsigned for_foreign_flush:1;	/* foreign dirty flushing */
>  	unsigned range_cyclic:1;	/* range_start is cyclic */
>  	unsigned for_sync:1;		/* sync(2) WB_SYNC_ALL writeback */
>  	unsigned unpinned_netfs_wb:1;	/* Cleared I_PINNING_NETFS_WB */
> -- 
> 2.20.1
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
