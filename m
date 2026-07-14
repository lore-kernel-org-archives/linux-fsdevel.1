Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1794248AE3D
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 14:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784041080; cv=none; b=RLNZzpm4qDe4qhlC5t1Aaax79v+HJpNhDVtIEadPnU/kBHpQ3Ar7lqmi0djbAa3JGm/CiBWSYfZjM5d4ob22F8lTrF3RXO+xG5hvYLDAuKnypHH1hpFmFR9ppLkf88C/XQHz0PzgJkK0jstjNuoKOfoYa3tomNBcyxGxRmD+VPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784041080; c=relaxed/simple;
	bh=bbVe9wD7UWq6NP6VCFDXEKyGC1e1v7dziadhfFXrKSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3IN4N6aY8NnZ8/bjot1VUxY2eK/G6EuCUpMUmdkTOdDeLH3ABy4ZE39Au91myIkwgbhi4LrrGnVtTQSbtDqGcyD28iF97dwPotOLRpKuqRWWfNdFxNgVfLUkuMj4Pz23H4qluVGDf1ngo/kl9U/2/2L3ZTuYL5uRjVvcY6TXsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/PVmJCC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojgF8NN4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q/PVmJCC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ojgF8NN4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/PVmJCC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojgF8NN4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q/PVmJCC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ojgF8NN4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0728B77465;
	Tue, 14 Jul 2026 14:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784041075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckvTJAIO5orNWSHDmCafm+BRY3ohuogBVJYxSTGOxzk=;
	b=Q/PVmJCC6YsBR+YDFgJyUkGt0Wt+75ENtlYahDKLHArnyNVHSfGLRSYgLOskrXmac6h2Vl
	LH/UtaIXG8P4RVwzlR2uIygL2SXSp7eXHJ5PxSPy6vmpKl6Aih/e7HRglDCaj7Y+dEBrjb
	sg8o23XqhU/RqfRzMU99OBz+N9DSsnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784041075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckvTJAIO5orNWSHDmCafm+BRY3ohuogBVJYxSTGOxzk=;
	b=ojgF8NN4i3OaVbo78BXxy5iRvemtn1cQMeW6pgXJqJVTvRVxAsEWk8Pw99bSCmGK+bUU0z
	TCpAw/bOOu+AQtBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784041075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckvTJAIO5orNWSHDmCafm+BRY3ohuogBVJYxSTGOxzk=;
	b=Q/PVmJCC6YsBR+YDFgJyUkGt0Wt+75ENtlYahDKLHArnyNVHSfGLRSYgLOskrXmac6h2Vl
	LH/UtaIXG8P4RVwzlR2uIygL2SXSp7eXHJ5PxSPy6vmpKl6Aih/e7HRglDCaj7Y+dEBrjb
	sg8o23XqhU/RqfRzMU99OBz+N9DSsnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784041075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ckvTJAIO5orNWSHDmCafm+BRY3ohuogBVJYxSTGOxzk=;
	b=ojgF8NN4i3OaVbo78BXxy5iRvemtn1cQMeW6pgXJqJVTvRVxAsEWk8Pw99bSCmGK+bUU0z
	TCpAw/bOOu+AQtBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2BBA779AE;
	Tue, 14 Jul 2026 14:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Zy9OO3JOVmo0OgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jul 2026 14:57:54 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A0ED9A1319; Tue, 14 Jul 2026 16:57:46 +0200 (CEST)
Date: Tue, 14 Jul 2026 16:57:46 +0200
From: Jan Kara <jack@suse.cz>
To: Jing Wu <realwujing@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Qiliang Yuan <yuanql9@chinatelecom.cn>
Subject: Re: [PATCH] fs/inode: replace goto-again rescan with cursor in
 evict_inodes()
Message-ID: <zsvxjqazva2kom7lfdgp7ebzyq46eqzvivwbqkz4llazfqt4dr@a6ecq3b6fuz3>
References: <20260714-feat-fs-evict-inodes-cursor-v1-1-64818f31020e@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714-feat-fs-evict-inodes-cursor-v1-1-64818f31020e@gmail.com>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,chinatelecom.cn:email,cursor.next:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Tue 14-07-26 09:14:54, Jing Wu wrote:
> evict_inodes() traverses sb->s_inodes to reclaim all zero-refcount
> inodes at unmount time.  When the traversal yields to the scheduler
> via cond_resched(), the current code jumps back to a "goto again"
> label and restarts the list_for_each_entry loop from the head.
> Inodes already marked I_FREEING are skipped cheaply, but the
> repeated scans make the total work O(n * r) where r is the number
> of reschedule events -- proportional to O(n^2) in the worst case on
> systems with many inodes and memory pressure.
> 
> Replace the goto-again pattern with a sentinel cursor node embedded
> in sb->s_inodes.  list_move() advances the cursor past each visited
> inode in O(1).  Dropping and reacquiring s_inode_list_lock around
> cond_resched() leaves the cursor in place, so the loop resumes from
> exactly the current position rather than the list head, giving O(n)
> total traversal.
> 
> Co-developed-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Qiliang Yuan <yuanql9@chinatelecom.cn>
> Signed-off-by: Jing Wu <realwujing@gmail.com>

Do you observe some real problems with the code in evict_inodes()? If yes,
they should be mentioned in the changelog. Because we should in fact skip
very little inodes on s_inodes list (most of them should be readily
evictable) and thus your worry about quadratic behavior shouldn't apply.

Also your solution with the cursor has the problem that now everybody
scanning s_inodes list has to be aware of the special cursor node. So your
patch breaks these other places scanning s_inodes list and if you were to
fix them, things would get ugly and complex quickly...

								Honza

> ---
> evict_inodes() is called at unmount time to reclaim all zero-refcount
> inodes on a superblock.  Its current implementation uses a "goto again"
> pattern: after dropping s_inode_list_lock for cond_resched() and
> dispose_list(), it restarts list_for_each_entry from the list head.
> 
> In the common case (clean unmount, all files closed) the goto loop
> terminates quickly because dispose_list() removes evicted inodes before
> the restart.  However, when many inodes have a positive refcount and
> cannot be evicted -- as happens with a force-unmount while file
> descriptors are still open -- the restarts scan O(n) skippable inodes
> each time, making total work O(n * r) proportional to O(n^2) in the
> worst case.
> 
> This series replaces the goto-again pattern with a sentinel cursor node
> embedded in sb->s_inodes, allowing the traversal to resume from its
> current position after each lock drop.
> ---
>  fs/inode.c | 24 +++++++++++++++++++++---
>  1 file changed, 21 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index acf206beb2e03..19197368c6a67 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -880,15 +880,31 @@ static void dispose_list(struct list_head *head)
>   * called by superblock shutdown after having SB_ACTIVE flag removed,
>   * so any inode reaching zero refcount during or after that call will
>   * be immediately evicted.
> + *
> + * Use a cursor node embedded in sb->s_inodes to resume traversal after
> + * dropping s_inode_list_lock for cond_resched() + dispose_list().  This
> + * avoids restarting the scan from the list head on each reschedule, giving
> + * O(n) total traversal instead of O(n * r) where r is the reschedule count.
>   */
>  void evict_inodes(struct super_block *sb)
>  {
>  	struct inode *inode;
>  	LIST_HEAD(dispose);
> +	/*
> +	 * Embed a cursor node directly in sb->s_inodes.  list_move() advances
> +	 * it past each visited inode in O(1), so the loop resumes from exactly
> +	 * the current position after lock drop rather than from the list head.
> +	 */
> +	struct list_head cursor;
>  
> -again:
>  	spin_lock(&sb->s_inode_list_lock);
> -	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
> +	list_add(&cursor, &sb->s_inodes);
> +
> +	while (cursor.next != &sb->s_inodes) {
> +		inode = list_entry(cursor.next, struct inode, i_sb_list);
> +		/* Leave the cursor immediately after the current inode. */
> +		list_move(&cursor, &inode->i_sb_list);
> +
>  		if (icount_read_once(inode))
>  			continue;
>  
> @@ -916,9 +932,11 @@ void evict_inodes(struct super_block *sb)
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
>  			dispose_list(&dispose);
> -			goto again;
> +			spin_lock(&sb->s_inode_list_lock);
>  		}
>  	}
> +
> +	list_del(&cursor);
>  	spin_unlock(&sb->s_inode_list_lock);
>  
>  	dispose_list(&dispose);
> 
> ---
> base-commit: 502d801f0ab03e4f32f9a33d203154ce84887921
> change-id: 20260713-feat-fs-evict-inodes-cursor-c23c9bd3c11f
> 
> Best regards,
> -- 
> Jing Wu <realwujing@gmail.com>
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
