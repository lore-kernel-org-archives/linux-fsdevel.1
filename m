Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792593809;
	b=sUdobNT40rWm7RtqDyTbzkeXQrCl0Fg4iOy9YkYdHV1DYFnLrMTing8YAspw5JaERBN3
	 T9MRaMk9Wk+H5ce63rQGcdqEF7N6gBchuuReyGyLm02d5NHIc6bieFvI/QmxRsAeJsT4s
	 lPfxA5yXM6hb3gkkW/JfUSLmOkYQp+D0xwlF2CMuuiFsoekFLVdCRddfLZ+4jIy2nDu+J
	 7n1H74qxX7UWfmHNGuso4y/N0l6C8BGO82gR60+lnccsfvCPQeezvrTk16e/fpHH44DY4
	 QsN/iVwZ2fPl2GLNyzyNB6d92pzJLl6g3k4F/ykJo/rDj21z/S6WjZkZsq4uRMCvu0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792593809;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=hUJNczgblYN6VobmOI7WLM+jfIuXl0vkwjK+W99ykX8=;
	b=ob/Y0713ba9khUYs3fPuviwmBpjXT5kOTBpksrbSc40AGJ6gTy+Xr4gGmF7fOb/AXyv1
	 WsIWebf95l8jN3KyJuI/g+1pyX944SBLZqbS0zmmrcOppVa++d+XIi9NW0YBPq12gfon7
	 vYd0+KKHVwfVXP7RTjSYZiE7WV+kLzCMSWH9qxyg9ANfFK0KqjkSTn+7yFcklzjS28rtu
	 jOmF0x1EKS3CwZxQ5My77bpTTDav9cH9WGjBBT2LiXVDlPaE+aulepeUEPsDo86AKNzEJ
	 SKYgDIVo8kx/9p9x+76pi3pAhyqMAclf72FT5b9zzix/1qh0fdRiJvpr7IJ12Zr/67g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1Gtx4C9f;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wJe3hhAF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1Gtx4C9f;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wJe3hhAF;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE8606A319;
	Wed, 21 Oct 2026 14:43:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCE8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1Gtx4C9f;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wJe3hhAF;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=1Gtx4C9f;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wJe3hhAF
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 890E821F3A;
	Wed, 21 Oct 2026 14:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJNczgblYN6VobmOI7WLM+jfIuXl0vkwjK+W99ykX8=;
	b=1Gtx4C9fKyps7T28JxwP9+OaeCJSHhOFKKYPd3DVkWZTofAZXL3F2xW4vdQj522cu0+FRk
	HGTgWWJipUBl4I7eceu+godF1Rpg6HAh6EICLTdnSxBjcAVD1Yp86NsKYqPKnFT90S051Q
	kBxKq2RdpG8ThM+xwWWXiXxykMnkVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJNczgblYN6VobmOI7WLM+jfIuXl0vkwjK+W99ykX8=;
	b=wJe3hhAFXkpEuh7sxfZMApFPf6RgDTpKWqqYLAzV9LLPPPgs/T49qzHYp+Sj6CQpH/RE+0
	Ph6MzVoJT1bT4dBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792593807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJNczgblYN6VobmOI7WLM+jfIuXl0vkwjK+W99ykX8=;
	b=1Gtx4C9fKyps7T28JxwP9+OaeCJSHhOFKKYPd3DVkWZTofAZXL3F2xW4vdQj522cu0+FRk
	HGTgWWJipUBl4I7eceu+godF1Rpg6HAh6EICLTdnSxBjcAVD1Yp86NsKYqPKnFT90S051Q
	kBxKq2RdpG8ThM+xwWWXiXxykMnkVYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792593807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hUJNczgblYN6VobmOI7WLM+jfIuXl0vkwjK+W99ykX8=;
	b=wJe3hhAFXkpEuh7sxfZMApFPf6RgDTpKWqqYLAzV9LLPPPgs/T49qzHYp+Sj6CQpH/RE+0
	Ph6MzVoJT1bT4dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5CAE1134FD;
	Wed, 21 Oct 2026 14:43:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BCTxDY/P2GqNYgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 14:43:27 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D91D2A13C6; Wed, 21 Oct 2026 16:43:26 +0200 (CEST)
Date: Wed, 21 Oct 2026 16:43:26 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] fs: make sync(2) wait for superblocks being shut
 down explicitly
Message-ID: <taog42dri3duco4vv3i6pro73bttc6qhzp25f7dnzljoy3xr2f@vppgv55bry5f>
References: <20261021-b4-super-lock-dying-v1-0-2b35e86706ff@toxicpanda.com>
 <20261021-b4-super-lock-dying-v1-1-2b35e86706ff@toxicpanda.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261021-b4-super-lock-dying-v1-1-2b35e86706ff@toxicpanda.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80

On Wed 21-10-26 00:56:35, Josef Bacik wrote:
> sync(2) walks the superblocks with iterate_supers().  For one which is
> being unmounted, super_lock() sleeps on s_umount until
> generic_shutdown_super() is done with it, finds SB_DYING set and fails, so
> the superblock isn't passed to the callback.
> 
> sync(2) does get something out of that sleep.  The unmount has written the
> filesystem out by the time s_umount is dropped, so that filesystem is on
> disk like all the others when sync(2) returns.  The same goes for the
> emergency sync and the emergency remount, after which one is supposed to
> be able to reset the machine.
> 
> Nothing says so in the code, and super_lock() is about to stop sleeping on
> a superblock which is being shut down.  Add
> super_wait_shutdown_killable(), which waits for SB_DYING, and
> a flag for __iterate_supers() to call it for each superblock super_lock()
> fails on.  iterate_supers_sync() passes that flag, for the two syncs, and
> so does the emergency remount.
> 
> If the task is killed the walk stops and ksys_sync() returns.  There is
> nobody left to make a promise to.  The emergency sync and remount and the
> sync before suspend and hibernation run from a workqueue, where that can't
> happen.
> 
> For now SB_DYING is always set by the time super_lock() fails, so nothing
> changes yet.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/internal.h |  1 +
>  fs/super.c    | 51 ++++++++++++++++++++++++++++++++++++++++++++++++---
>  fs/sync.c     | 15 ++++++++-------
>  3 files changed, 57 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/internal.h b/fs/internal.h
> index e833c7e6e14f..71ab0ae11941 100644
> --- a/fs/internal.h
> +++ b/fs/internal.h
> @@ -137,6 +137,7 @@ extern int reconfigure_super(struct fs_context *);
>  extern bool super_trylock_shared(struct super_block *sb);
>  struct super_block *user_get_super(dev_t, bool excl);
>  void put_super(struct super_block *sb);
> +int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg);
>  void __init super_dev_init(void);
>  extern bool mount_capable(struct fs_context *);
>  
> diff --git a/fs/super.c b/fs/super.c
> index a1dc4de1b657..c33981d3f7c0 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -137,6 +137,26 @@ static __must_check bool super_lock(struct super_block *sb, bool excl)
>  	return true;
>  }
>  
> +/**
> + * super_wait_shutdown_killable - wait for a superblock being shut down
> + * @sb: superblock super_lock() failed on
> + *
> + * For those who have nothing to do on a superblock which is going away, but
> + * who promise their caller that what it had to write has been written.
> + *
> + * Only for callers which give up altogether when they are killed.  If what
> + * comes after the wait happens either way, the wait must not be cut short.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_passive.
> + *
> + * Return: 0 once generic_shutdown_super() is done with @sb, -ERESTARTSYS if
> + *         the task was killed first.
> + */
> +static int super_wait_shutdown_killable(struct super_block *sb)
> +{
> +	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
> +}
> +
>  /* wait and try to acquire read-side of @sb->s_umount */
>  static inline bool super_lock_shared(struct super_block *sb)
>  {
> @@ -938,6 +958,7 @@ enum super_iter_flags_t {
>  	SUPER_ITER_EXCL		= (1U << 0),
>  	SUPER_ITER_UNLOCKED	= (1U << 1),
>  	SUPER_ITER_REVERSE	= (1U << 2),
> +	SUPER_ITER_WAIT_SHUTDOWN = (1U << 3),
>  };
>  
>  static inline struct super_block *first_super(enum super_iter_flags_t flags)
> @@ -955,11 +976,12 @@ static inline struct super_block *next_super(struct super_block *sb,
>  	return list_next_entry(sb, s_list);
>  }
>  
> -static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
> -			     enum super_iter_flags_t flags)
> +static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
> +			    enum super_iter_flags_t flags)
>  {
>  	struct super_block *sb, *p = NULL;
>  	bool excl = flags & SUPER_ITER_EXCL;
> +	int ret = 0;
>  
>  	spin_lock(&sb_lock);
>  
> @@ -979,16 +1001,21 @@ static void __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  		} else if (super_lock(sb, excl)) {
>  			f(sb, arg);
>  			super_unlock(sb, excl);
> +		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
> +			ret = super_wait_shutdown_killable(sb);
>  		}
>  
>  		if (p)
>  			put_super(p);
>  		p = sb;
>  		spin_lock(&sb_lock);
> +		if (ret)
> +			break;
>  	}
>  	spin_unlock(&sb_lock);
>  	if (p)
>  		put_super(p);
> +	return ret;
>  }
>  
>  void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
> @@ -996,6 +1023,23 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>  	__iterate_supers(f, arg, 0);
>  }
>  
> +/**
> + * iterate_supers_sync - iterate_supers() for syncing all filesystems
> + * @f: function to call
> + * @arg: argument to pass to it
> + *
> + * A superblock which is being shut down isn't passed to @f, whoever shuts it
> + * down writes it out.  Wait for that, so that it is on disk as well by the time
> + * the walk is over.
> + *
> + * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
> + *         killed while it waited for one.
> + */
> +int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
> +{
> +	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN);
> +}
> +
>  /**
>   *	iterate_supers_type - call function for superblocks of given type
>   *	@type: fs type
> @@ -1174,7 +1218,8 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  static void do_emergency_remount(struct work_struct *work)
>  {
>  	__iterate_supers(do_emergency_remount_callback, NULL,
> -			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
> +			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE |
> +			 SUPER_ITER_WAIT_SHUTDOWN);
>  	kfree(work);
>  	printk("Emergency Remount complete\n");
>  }
> diff --git a/fs/sync.c b/fs/sync.c
> index 4a84dd837b86..0681bfcb2da6 100644
> --- a/fs/sync.c
> +++ b/fs/sync.c
> @@ -99,9 +99,10 @@ void ksys_sync(void)
>  	int nowait = 0, wait = 1;
>  
>  	wakeup_flusher_threads(WB_REASON_SYNC);
> -	iterate_supers(sync_inodes_one_sb, NULL);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> -	iterate_supers(sync_fs_one_sb, &wait);
> +	if (iterate_supers_sync(sync_inodes_one_sb, NULL) ||
> +	    iterate_supers_sync(sync_fs_one_sb, &nowait) ||
> +	    iterate_supers_sync(sync_fs_one_sb, &wait))
> +		return;
>  	sync_bdevs(false);
>  	sync_bdevs(true);
>  }
> @@ -121,11 +122,11 @@ static void do_sync_work(struct work_struct *work)
>  	 * Sync twice to reduce the possibility we skipped some inodes / pages
>  	 * because they were temporarily locked
>  	 */
> -	iterate_supers(sync_inodes_one_sb, NULL);
> -	iterate_supers(sync_fs_one_sb, &nowait);
> +	iterate_supers_sync(sync_inodes_one_sb, NULL);
> +	iterate_supers_sync(sync_fs_one_sb, &nowait);
>  	sync_bdevs(false);
> -	iterate_supers(sync_inodes_one_sb, NULL);
> -	iterate_supers(sync_fs_one_sb, &wait);
> +	iterate_supers_sync(sync_inodes_one_sb, NULL);
> +	iterate_supers_sync(sync_fs_one_sb, &wait);
>  	sync_bdevs(false);
>  	printk("Emergency Sync complete\n");
>  	kfree(work);
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
