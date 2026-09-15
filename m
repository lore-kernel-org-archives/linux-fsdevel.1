Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D503B42C9
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2026 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789466892; cv=none; b=sCqGaxeImyRxEHB2QX1CRuCjf5/KrGnKzwt/KilIf4hOGfz+US/lyBBjyGDiGx0hfbYyb7h4APVPOHoWOD9VP6q0uOYwSCJMKxxKUra7FUH8YFFKvAuMNdTvdnpgFTD8nTDQwnJegJWi871F4ls0MdR3yiyQNsAEn8Z05gcTRoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789466892; c=relaxed/simple;
	bh=WTL1WVXVF5RlENfEuSrlj+h+/nQkcT4m2wKRkanIFCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t61xmOwZG1mwqBPfQbS9EIgZYfNcG8SnQ9lzVqjuFvmqMNEWR7qtrn5blbiFASXJ2vs00o46D03N4Z1ucJtxtn8kuEJAvt+5QRfc3cSbq1g3/OqcM6xZMBcSyQbOuLYgYFwZG4XXyFcQXpyhKL8Jb7Dcgi+i88pUi+frvlpKJEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K4ZNcJi3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lKG2/1ro; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zDcbKNZy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jWBXoOqk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K4ZNcJi3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lKG2/1ro";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zDcbKNZy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jWBXoOqk"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A4DA021DFD;
	Tue, 15 Sep 2026 10:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789466883; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T23HdyShUVJBbJEgVvO0QkIzW+n9/Ff0I/FvKNX8UPI=;
	b=K4ZNcJi3wfV8DXb8crs6smHRAtEzM4V4xbmhtPyF4nQvUL4dPy4yxQCnuBJ8bKRVZ88SpF
	A5CijlZsoQ8GahKwapT0oX/CDawY2nvETCfH71mmy9BV5Mx9yAU5kN5GWa0HUiEr49nEm9
	tZRsWcP7xHUhq2AGQrz7kgTrhmYSTm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789466883;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T23HdyShUVJBbJEgVvO0QkIzW+n9/Ff0I/FvKNX8UPI=;
	b=lKG2/1ro/zLOj/JUeG98wMXOYxf2Stzq9ppocXf7FKfoFBCGLB7vJ+sSCNR/RL4+oM2vGe
	IptkJ8PHGcWYMVDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789466879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T23HdyShUVJBbJEgVvO0QkIzW+n9/Ff0I/FvKNX8UPI=;
	b=zDcbKNZyaAVb9J+hnYj/MgwtwI3ro/7m30HHFu6uybCWxeqH5mI/SlH+8H8dd9KJ6O5Ds7
	vxp5lCVm59CV/vWKqRtrWUTLN/BXoEUReiYV5kOMkpxK9bYAO++mYG2+aTFKUQPKyUwsiv
	VjXVNi2cnj0yrZVnbSwoTDllOAMm9uM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789466879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T23HdyShUVJBbJEgVvO0QkIzW+n9/Ff0I/FvKNX8UPI=;
	b=jWBXoOqk4UBhkV9JSDovXMdHVr/ccgAWsxt9M1zuMqddQ1H5/N7Lq2Jd+C9t7nfEvUfOYa
	I51S19bxEnMNjmDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C93313693;
	Tue, 15 Sep 2026 10:07:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6ftJFv8YqWruFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 15 Sep 2026 10:07:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FD2EA13D6; Tue, 15 Sep 2026 12:07:55 +0200 (CEST)
Date: Tue, 15 Sep 2026 12:07:55 +0200
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao@bytedance.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, jbacik@fb.com
Subject: Re: [PATCH] fs: avoid repeated scans in evict_inodes()
Message-ID: <szgidy7mzd46jad4ppym2of65swhtw2k4s54qhczki6xg2fzmd@kkmigzu5l7wl>
References: <20260915044912.3183440-1-sunjunchao@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915044912.3183440-1-sunjunchao@bytedance.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,bytedance.com:email,suse.cz:email]
X-Spam-Flag: NO

On Tue 15-09-26 12:49:12, Julian Sun wrote:
> We observed hung tasks when users attempted to unmount a filesystem
> after its disk had been removed while still in use. During device
> removal, fs_bdev_mark_dead() calls evict_inodes() while holding s_umount.
> 
> Each time evict_inodes() drops s_inode_list_lock to reschedule, it
> restarts the walk from the head of s_inodes. With many referenced inodes
> at the head of the list, these restarts repeatedly scan the same inodes
> without reclaiming them. This can keep s_umount held for a long time,
> blocking concurrent umount attempts and triggering hung-task reports.
> 
> Keep the current inode, already marked I_FREEING, out of the disposal
> batch until s_inode_list_lock is reacquired. Resume the walk from this
> inode and dispose of it in a later batch or at the end of the walk.
> 
> The zero-refcount and state checks under i_lock allow this walker to
> claim the inode by setting I_FREEING and removing it from the LRU.
> Other reclaimers skip the inode, leaving this walker responsible for
> eviction. Only evict() removes it from s_inodes, so keeping it out of
> the disposal batch ensures that it remains on the list while the lock
> is dropped. After reacquiring the lock, reading its current next pointer
> accounts for concurrent removal of following inodes.
> 
> The existing inode lifetime rules prohibit acquiring a reference to an
> inode marked I_FREEING or I_WILL_FREE. __iget() requires its caller to
> hold i_lock and establish that taking a reference is valid. Inode lookup
> and igrab() check these flags under i_lock when acquiring a reference
> from zero. ihold() requires an existing reference, which would keep
> i_count nonzero and prevent this walker from claiming the inode. These
> rules already allow iput_final() and the inode shrinker to release
> i_lock after setting I_FREEING and before eviction completes.
>
> A temporary __iget() reference would also keep the inode on the list,
> but its release must preserve last-reference handling. Another user can
> acquire a reference, update lazy timestamps and drop its reference while
> the pin is held. If the pin becomes the last reference, dropping it with
> atomic_dec_and_test() and evicting directly bypasses iput()'s lazytime
> handling and can lose those timestamp updates.
> 
> Releasing the pin with iput() preserves that handling, but does not
> guarantee eviction. fs_bdev_mark_dead() runs with SB_ACTIVE set, so iput()
> may retain the inode in cache, whereas evict_inodes() must evict eligible
> zero-reference inodes. The inode may also have been freed when iput()
> returns, so the walker cannot then use it to force eviction. Using
> I_FREEING preserves the existing eviction behavior without introducing
> an additional last-reference transition.
> 
> The xfstests auto group passed on ext4 and XFS with known unrelated
> failures excluded. No new issues were observed, and the previously
> reproducible hung task no longer occurs with this patch.
> 
> Fixes: ac05fbb40062 ("inode: don't softlockup when evicting inodes")
> Assisted-by: LLM
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>

Thanks! The fix looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/inode.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ba7da39be4a3..a9d37be390a1 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -880,7 +880,6 @@ void evict_inodes(struct super_block *sb)
>  	struct inode *inode;
>  	LIST_HEAD(dispose);
>  
> -again:
>  	spin_lock(&sb->s_inode_list_lock);
>  	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
>  		if (icount_read_once(inode))
> @@ -899,19 +898,19 @@ void evict_inodes(struct super_block *sb)
>  		inode_state_set(inode, I_FREEING);
>  		inode_lru_list_del(inode);
>  		spin_unlock(&inode->i_lock);
> -		list_add(&inode->i_lru, &dispose);
>  
>  		/*
> -		 * We can have a ton of inodes to evict at unmount time given
> -		 * enough memory, check to see if we need to go to sleep for a
> -		 * bit so we don't livelock.
> +		 * Keep this inode out of dispose so it stays on s_inodes while
> +		 * the list lock is dropped. I_FREEING prevents new references
> +		 * and leaves eviction to us, so we can resume the walk from it.
>  		 */
>  		if (need_resched()) {
>  			spin_unlock(&sb->s_inode_list_lock);
>  			cond_resched();
>  			dispose_list(&dispose);
> -			goto again;
> +			spin_lock(&sb->s_inode_list_lock);
>  		}
> +		list_add(&inode->i_lru, &dispose);
>  	}
>  	spin_unlock(&sb->s_inode_list_lock);
>  
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
