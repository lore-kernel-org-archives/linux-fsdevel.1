Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69E3A4F5C
	for <linux-fsdevel@vger.kernel.org>; Thu, 30 Apr 2026 07:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777534103; cv=none; b=mwRPFX9mfRkceO/kqlOgRQdqeELhVZgHaGc13cs1XGrfuRXepGYe6WQ60C0I95fMYSoGHmW7Yv8yrxbjAXbl3Z+NaVf8UYX14xMbC25fpPluLzWnJoWFSohj3JIiicbBIgH44A0JH7+YbU/lROPUPDuTQIY9sFFmQZ9x3FVhbtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777534103; c=relaxed/simple;
	bh=J0dJSdVShA5CRFUV0tuVvfuxeQR2Fc6gLsUr03UigAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sezUCjV7blmyBRlcesyJn4im3EDo/QZ4/nG+fZ/mvwsHLfk9G/yxJZoidVFlCTnf+/R4JT1YW2uvG71l163bfq+Ni8CD7Gkup5HVa63WbBDI2ST2EEZhj/yrwT3CUNXuqh7yxnhdB1edLgt5lODfLZYz5MzYynGVdUMj3/g99qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fx9k+lPg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DIg0FLeY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fx9k+lPg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DIg0FLeY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fx9k+lPg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIg0FLeY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fx9k+lPg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DIg0FLeY"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C8CFE6A801;
	Thu, 30 Apr 2026 07:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777534097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g5z/5HnB77pIpEaD8VGv9Qpr78pLYH7k2mEFQvLTb4=;
	b=fx9k+lPgcbf603dVBkDstjUgkdczL1gHNkYtKV+kSCYGEmVaafw7vYuVIeVXuKQM1LkNpk
	Uy5rxSlCY3XCBJlDz5tiddv4Xnod4/c+JpKFWiQSsENyXr4d+ecsUM3Te3sZ093jybHceR
	CeEQ3OGofGCQYgPReXr36bcCiATcGf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777534097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g5z/5HnB77pIpEaD8VGv9Qpr78pLYH7k2mEFQvLTb4=;
	b=DIg0FLeYj9BFay/nl3iPbKs39uz3RwAqufYDDDYq7R0/Rr/wVG/jXwYiCdeJo+gFUWF3Ks
	lP2AtLGONb3BIpCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1777534097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g5z/5HnB77pIpEaD8VGv9Qpr78pLYH7k2mEFQvLTb4=;
	b=fx9k+lPgcbf603dVBkDstjUgkdczL1gHNkYtKV+kSCYGEmVaafw7vYuVIeVXuKQM1LkNpk
	Uy5rxSlCY3XCBJlDz5tiddv4Xnod4/c+JpKFWiQSsENyXr4d+ecsUM3Te3sZ093jybHceR
	CeEQ3OGofGCQYgPReXr36bcCiATcGf0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1777534097;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3g5z/5HnB77pIpEaD8VGv9Qpr78pLYH7k2mEFQvLTb4=;
	b=DIg0FLeYj9BFay/nl3iPbKs39uz3RwAqufYDDDYq7R0/Rr/wVG/jXwYiCdeJo+gFUWF3Ks
	lP2AtLGONb3BIpCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BC4FF593B0;
	Thu, 30 Apr 2026 07:28:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QWPvLZEE82m1SAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 30 Apr 2026 07:28:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 69B48A07AC; Thu, 30 Apr 2026 09:28:13 +0200 (CEST)
Date: Thu, 30 Apr 2026 09:28:13 +0200
From: Jan Kara <jack@suse.cz>
To: Chao Shi <coshi036@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, willy@infradead.org, linux-kernel@vger.kernel.org, 
	Sungwoo Kim <iam@sung-woo.kim>, Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH v2] fs/buffer: serialize set_buffer_uptodate against
 concurrent clears
Message-ID: <xaqwfkwjnp7h2lg7ir6wy2tnyay26t3im3ftkdl64rhys3rhmu@lc5vfh5tc2f5>
References: <20260430053645.1466196-1-coshi036@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430053645.1466196-1-coshi036@gmail.com>
X-Spam-Score: -0.30
X-Spam-Level: 
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[purdue.edu:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu 30-04-26 01:36:45, Chao Shi wrote:
> A WARN_ON_ONCE(!buffer_uptodate(bh)) in mark_buffer_dirty() is
> reachable from the buffered write path on a block device when the
> underlying device returns I/O errors at high density.  Reproduced
> by fuzzing an NVMe controller (FEMU) that returns crafted error
> completions for a sustained workload from /dev/nvme0n1.
> 
> The contract documented at set_buffer_uptodate() in
> include/linux/buffer_head.h reads:
> 
>   Any other serialization (with IO errors or whatever that might
>   clear the bit) has to come from other state (eg BH_Lock).
> 
> In fs/buffer.c, BH_Uptodate can be cleared from four I/O completion
> callbacks: __end_buffer_read_notouch, end_buffer_write_sync,
> end_buffer_async_read, end_buffer_async_write.
> 
> end_buffer_async_read() runs with BH_Lock held throughout, so its
> clear is already serialized against any caller that also holds
> BH_Lock around set_buffer_uptodate(); the call may in fact be
> redundant, but addressing that is independent of this fix.
> 
> end_buffer_write_sync() likewise holds BH_Lock while it clears
> BH_Uptodate on the write-error path.  Removing that clear would
> change long-standing buffer-cache I/O-error semantics and is out
> of scope here.
> 
> The race is therefore between block_commit_write() and
> end_buffer_write_sync():
> 
>   CPU A: block_commit_write              CPU B: end_buffer_write_sync
>          (folio lock held, BH_Lock NOT)         (BH_Lock held)
>     set_buffer_uptodate(bh);
>                                            clear_buffer_uptodate(bh);
>                                            unlock_buffer(bh);
>     mark_buffer_dirty(bh);  /* WARN */
> 
> CPU B observes the contract; CPU A does not.  With one side unlocked
> the serialization is one-sided and ineffective: CPU A's set can be
> immediately followed by CPU B's clear, tripping the WARN_ON_ONCE.
> In the fuzzing reproducer, write-error completions are frequent
> (visible as repeated "lost async page write" and per-LBA write
> failures); buffer I/O completion callbacks on the write-error path
> (e.g. end_buffer_write_sync, end_buffer_async_write) clear
> BH_Uptodate while holding BH_Lock.
> 
> The bug is not benign: a not-uptodate buffer can be marked dirty
> and subsequently written back; depending on whether the buffer was
> fully or partially covered by the user write, this can leave on-disk
> content that does not match the intended buffered write state.
> 
> Fix this by taking BH_Lock around set_buffer_uptodate() +
> mark_buffer_dirty() in block_commit_write(), so both sides of the
> contract use the documented serialization.
> 
> Found by FuzzNvme (Syzkaller with FEMU fuzzing framework).
> 
> Acked-by: Sungwoo Kim <iam@sung-woo.kim>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Signed-off-by: Chao Shi <coshi036@gmail.com>

Thanks for trying but this basically just silences the warning without
addressing the real problem. Sure enough it silences the warning in
mark_buffer_dirty() but effectively it just papers over the real problem -
the IO completion with error can come the moment you unlock the bh and it
will happily clear the uptodate bit, resulting in the same "dirty but not
uptodate" invalid buffer state. So I actually prefer keeping things as they
currently are so that we are reminded there is this unresolved issue.

But it would be actually very welcome if you took the work, went through
all the places using end_buffer_write_sync() and converted them in
filesystem-by-filesystem to check for IO error by checking
buffer_write_io_error() instead of buffer_uptodate() and then we can drop
clear_buffer_uptodate() call from end_buffer_write_sync(). Yes, it is much
more work but also much more useful.

								Honza

> ---
> Hi Matthew, Hi Jan,
> 
> Thanks for the review on v1.  v2 takes the feedback, quick notes below.
> 
> To Matthew:
> 
> You were right that the v1's timing diagram named the wrong racer.
> 
> The actual race is with end_buffer_write_sync() on the write-error
> path, as Jan pointed out -- it also clears BH_Uptodate under BH_Lock,
> but block_commit_write()'s else branch was reaching set_buffer_uptodate
> without BH_Lock, leaving the serialization one-sided.  v2's commit
> message and in-code comment now name end_buffer_write_sync() as the
> racer.
> 
> To Jan:
> 
> Thanks for confirming the racer and for the historical context on the
> dirty + !uptodate state question.  v2 keeps the fix scoped to taking
> BH_Lock in block_commit_write(); the broader semantic question and any
> change to end_buffer_write_sync()'s clear is left out of scope here.
> 
> The redundant lock_buffer/unlock_buffer that v1 added to the
> buffer_new branch of __block_write_begin_int() is also dropped in v2 --
> that bh has no in-flight async I/O so no race exists there.
> 
> v1 thread for context:
> https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail.com/
> 
> Thanks,
> Chao
> 
> Changes in v2:
>   - Drop the lock_buffer/unlock_buffer added in v1 to the buffer_new
>     branch of __block_write_begin_int(): that bh is freshly BH_New
>     and has no in-flight async I/O on it, so no race exists at that
>     site.
>   - Rewrite the commit message and the in-code comment to identify
>     end_buffer_write_sync() as the actual racer, not
>     end_buffer_async_read() as v1 claimed; end_buffer_async_read()
>     holds BH_Lock across its clear so a caller that also holds
>     BH_Lock would already be serialized.
>   - Reference the BH_Lock contract at set_buffer_uptodate() in
>     include/linux/buffer_head.h explicitly.
>   - Drop verbose line-number citations and the WARN stack dump from
>     the commit message; tighten wording around reproducer evidence
>     and on-disk impact.
> 
> v1: https://lore.kernel.org/all/20260426020137.1221985-1-coshi036@gmail.com/
> 
>  fs/buffer.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4d7f84e77d2..6fddb2f1e7c 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2104,8 +2104,22 @@ void block_commit_write(struct folio *folio, size_t from, size_t to)
>  			if (!buffer_uptodate(bh))
>  				partial = true;
>  		} else {
> +			/*
> +			 * Per the contract documented at set_buffer_uptodate()
> +			 * in include/linux/buffer_head.h, callers must hold
> +			 * BH_Lock to serialize against concurrent clears of
> +			 * BH_Uptodate.  Holding only the folio lock is not
> +			 * sufficient: a concurrent end_buffer_write_sync() on
> +			 * the write-error path clears BH_Uptodate while
> +			 * holding BH_Lock; without BH_Lock here the clear can
> +			 * land between set_buffer_uptodate() and
> +			 * mark_buffer_dirty(), tripping the WARN_ON_ONCE in
> +			 * mark_buffer_dirty().
> +			 */
> +			lock_buffer(bh);
>  			set_buffer_uptodate(bh);
>  			mark_buffer_dirty(bh);
> +			unlock_buffer(bh);
>  		}
>  		if (buffer_new(bh))
>  			clear_buffer_new(bh);
> 
> base-commit: ffe69af1f87fa77da975ad4b0b093d48c3cbe6c3
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
