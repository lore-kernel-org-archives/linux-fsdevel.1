Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015811;
	b=GG/Q2KGPLVbRkJwrUhxGxOfs1DpnVaY4qLHubd+0JC/DNPZLBoW5QeFHFU595TRAAdNW
	 ZS3fKOMynZN+bQRhRgXV3vnqCTw3cJJUFzXEFMh4RIsl/C1u5ifiOwWbi1+ZSIyasKMF4
	 8ADKXf62xVn7ojtFyOEqYvP5+A6VN0GyPzJisrNMVywaXzCTHg1Uh/B0MAl7kf8HYJfV5
	 6cGbZxd3QqH+Uq5dlFVfl4IFq2njv3F9UaihsukmYK9VTkpQhikQFnW43ffvH5Gj3hcMH
	 GZgvFrO8mRTbU2jlHvFVN144e2el3V3q1Sm+2ZaWNzNwBZS9E+DoGvhA2JfKVHvCHCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015811;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=JQXzM1FH0xmzJRPeJTusmrQrF6948PaVzwXqo35Iko4=;
	b=JNw1aju4ylrIPYbmWmO7d7z3nAy3lgm4CitnTnzNB4plzsI7PaCG36zU598ZaaaRXxvp
	 Em46B9lc46+nDxbK6N+i2p8ih7du5xsNMAKF1Yn28Mdil2Li64o9cBLqTL+ZO6BNur2hC
	 Fdf3Cvk9GvOfmWF5Nt7o8UbDqxYcN24OAghro5AxmDr9JQMW7ISmkNp52FDqJ3a4z4CGY
	 qq/WpcXhb6heCYKHOPYkw4KxFtEbct/6uaQjLWffNsL8F04yy6N3aFNxzcLbhCivju6DL
	 +1kvxmdbHvOvbkztdp6wdy7N6Nj12zadXdv9QDbMR3oukmMKz3VdI4v8R/HV9ftg2zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="qlGHE/mx";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NdZOjbbH;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="qlGHE/mx";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NdZOjbbH;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96A3606A31A;
	Mon, 26 Oct 2026 11:56:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E96A3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qlGHE/mx;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NdZOjbbH;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=qlGHE/mx;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NdZOjbbH
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3D37821C5D;
	Mon, 26 Oct 2026 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQXzM1FH0xmzJRPeJTusmrQrF6948PaVzwXqo35Iko4=;
	b=qlGHE/mxTbodAwYC+kJe3iKfIc8OSWPdAf1Ll897WzfW+5XGEy7SVnxifAX+uWtN9EID6N
	YinHSnvEUYeg6aKIRB3T91wgeFfDQ3S8h6vLoX8WJtTA9inDayZKwLhOUD0ie3qtt16tTW
	a6RtpjaSVwDVLT0ZrWaToPmo8kOOg5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQXzM1FH0xmzJRPeJTusmrQrF6948PaVzwXqo35Iko4=;
	b=NdZOjbbHhURfcNnGPPqsT3X6QftQiYGn+37gHqBC+A7oQPsRt9V3nkC1/ZMgIogCUiCTUH
	n+OqhK53jx7Ag1Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQXzM1FH0xmzJRPeJTusmrQrF6948PaVzwXqo35Iko4=;
	b=qlGHE/mxTbodAwYC+kJe3iKfIc8OSWPdAf1Ll897WzfW+5XGEy7SVnxifAX+uWtN9EID6N
	YinHSnvEUYeg6aKIRB3T91wgeFfDQ3S8h6vLoX8WJtTA9inDayZKwLhOUD0ie3qtt16tTW
	a6RtpjaSVwDVLT0ZrWaToPmo8kOOg5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQXzM1FH0xmzJRPeJTusmrQrF6948PaVzwXqo35Iko4=;
	b=NdZOjbbHhURfcNnGPPqsT3X6QftQiYGn+37gHqBC+A7oQPsRt9V3nkC1/ZMgIogCUiCTUH
	n+OqhK53jx7Ag1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17BAD13319;
	Mon, 26 Oct 2026 11:56:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KQsTOQBA32qDFQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 11:56:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D3E3A1419; Mon, 26 Oct 2026 12:56:48 +0100 (CET)
Date: Mon, 26 Oct 2026 12:56:48 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] super: let super_lock() wait for a superblock being
 shut down
Message-ID: <vfckqrwdeukqng37timlxhwnfyqtyt3nwgmg5q6v3kxlymlgw3@mlbu22qhvxy2>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-3-d0fcb3f2f275@kernel.org>
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
In-Reply-To: <20261023-work-super-lock_helpers-v1-3-d0fcb3f2f275@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 23-10-26 11:41:03, Christian Brauner wrote:
> Everyone who needs an unmount to be over before they can carry on
> currently calls super_lock() and, if that fails, calls
> super_wait_shutdown() or super_wait_shutdown_killable() after it. That's
> six callers open-coding the same two step dance, and they have to make
> sure to pick the shutdown wait that matches the lock they took.
> 
> Add SUPER_LOCK_WAIT_SHUTDOWN which makes super_lock() wait for SB_DYING
> when it finds the superblock going away. It still returns -ENOENT after
> the wait. It sleeps in the same state as the rest of super_lock(), so
> SUPER_LOCK_KILLABLE now covers all of the waiting. get_active_super()
> passes the flags through for the freezing callers. Then remove
> super_wait_shutdown() and super_wait_shutdown_killable().
> 
> __iterate_supers() is the odd one out. It takes s_umount uninterruptibly
> but waits for the shutdown killably. Keep it that way for now and let it
> call super_wait() directly.
> 
> Note that the freezing callers used to wait for the shutdown even if
> super_lock() succeeded and atomic_inc_not_zero() in get_active_super()
> failed. That can't happen. The last active reference is dropped with
> s_umount held and s_umount stays held until SB_DYING is set. So once
> super_lock() succeeded there's always an active reference to take.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 118 +++++++++++++++++++++++--------------------------------------
>  1 file changed, 45 insertions(+), 73 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 0185c1f16ba3..0f3308fb99aa 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -58,6 +58,7 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
>  enum super_lock_flags_t {
>  	SUPER_LOCK_EXCL		= (1U << 0),
>  	SUPER_LOCK_KILLABLE	= (1U << 1),
> +	SUPER_LOCK_WAIT_SHUTDOWN = (1U << 2),
>  };
>  
>  static inline int __super_lock(struct super_block *sb,
> @@ -130,13 +131,19 @@ static int super_wait(struct super_block *sb, unsigned int sb_flags,
>   * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
>   * woken and we'll see SB_DYING.
>   *
> - * A superblock which is being shut down is not waited for, see
> - * super_wait_shutdown() and super_wait_shutdown_killable() for that.
> - *
>   * With SUPER_LOCK_EXCL s_umount is taken for writing, otherwise for reading.
> - * With SUPER_LOCK_KILLABLE both the wait and taking s_umount can be cut short
> - * by a fatal signal.  That is only for callers which give up altogether when
> - * they are killed.
> + *
> + * A superblock which is being shut down is not waited for unless
> + * SUPER_LOCK_WAIT_SHUTDOWN is passed.  That is for those who have nothing to
> + * do on a superblock which is going away, but who promise their caller that
> + * what it had to write has been written, or who must not carry on while the
> + * filesystem is still being written out.  The wait is over once
> + * generic_shutdown_super() is done with @sb, and -ENOENT is still returned.
> + *
> + * With SUPER_LOCK_KILLABLE all the waiting can be cut short by a fatal
> + * signal.  That is only for callers which give up altogether when they are
> + * killed.  If what comes after the wait happens either way, the wait must
> + * not be cut short.
>   *
>   * The caller must have acquired a temporary reference on @sb->s_passive.
>   *
> @@ -162,7 +169,7 @@ static __must_check int super_lock(struct super_block *sb,
>  	 * and it can be a long one: the filesystem is written out first.
>  	 */
>  	if (!atomic_read(&sb->s_active))
> -		return -ENOENT;
> +		goto dying;
>  
>  	/* wait until the superblock is ready or dying */
>  	ret = super_wait(sb, SB_BORN | SB_DYING, state);
> @@ -171,7 +178,7 @@ static __must_check int super_lock(struct super_block *sb,
>  
>  	/* Don't pointlessly acquire s_umount. */
>  	if (super_flags(sb, SB_DYING))
> -		return -ENOENT;
> +		goto dying;
>  
>  	ret = __super_lock(sb, flags);
>  	if (ret)
> @@ -184,45 +191,19 @@ static __must_check int super_lock(struct super_block *sb,
>  	 */
>  	if (sb->s_flags & SB_DYING) {
>  		super_unlock(sb, flags);
> -		return -ENOENT;
> +		goto dying;
>  	}
>  
>  	WARN_ON_ONCE(!(sb->s_flags & SB_BORN));
>  	return 0;
> -}
>  
> -/**
> - * super_wait_shutdown_killable - wait for a superblock being shut down
> - * @sb: superblock super_lock() failed on
> - *
> - * For those who have nothing to do on a superblock which is going away, but
> - * who promise their caller that what it had to write has been written.
> - *
> - * Only for callers which give up altogether when they are killed.  If what
> - * comes after the wait happens either way, the wait must not be cut short.
> - *
> - * The caller must have acquired a temporary reference on @sb->s_passive.
> - *
> - * Return: 0 once generic_shutdown_super() is done with @sb, -ERESTARTSYS if
> - *         the task was killed first.
> - */
> -static int super_wait_shutdown_killable(struct super_block *sb)
> -{
> -	return super_wait(sb, SB_DYING, TASK_KILLABLE);
> -}
> -
> -/**
> - * super_wait_shutdown - wait for a superblock being shut down
> - * @sb: superblock super_lock() failed on
> - *
> - * For callers of which the rest happens whether they are killed or not, and
> - * must not happen while the filesystem is still being written out.
> - *
> - * The caller must have acquired a temporary reference on @sb->s_passive.
> - */
> -static void super_wait_shutdown(struct super_block *sb)
> -{
> -	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
> +dying:
> +	if (flags & SUPER_LOCK_WAIT_SHUTDOWN) {
> +		ret = super_wait(sb, SB_DYING, state);
> +		if (ret)
> +			return ret;
> +	}
> +	return -ENOENT;
>  }
>  
>  /* wake waiters */
> @@ -1055,7 +1036,8 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  			f(sb, arg);
>  			super_unlock_shared(sb);
>  		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
> -			ret = super_wait_shutdown_killable(sb);
> +			/* whoever shuts it down writes it out, wait for that */
> +			ret = super_wait(sb, SB_DYING, TASK_KILLABLE);
>  		}
>  
>  		if (p)
> @@ -1285,11 +1267,9 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  {
>  	struct fs_context *fc = NULL;
>  
> -	if (super_lock(sb, SUPER_LOCK_EXCL)) {
> -		/* the unmount writes the filesystem out, wait for that */
> -		super_wait_shutdown(sb);
> +	/* the unmount writes the filesystem out, wait for that */
> +	if (super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN))
>  		return;
> -	}
>  
>  	/* Make sure no reference put under s_umount is the last one. */
>  	atomic_inc(&sb->s_active);
> @@ -1329,11 +1309,12 @@ void emergency_remount(void)
>  	}
>  }
>  
> -static inline bool get_active_super(struct super_block *sb)
> +static inline bool get_active_super(struct super_block *sb,
> +				    enum super_lock_flags_t flags)
>  {
>  	bool active = false;
>  
> -	if (!super_lock(sb, SUPER_LOCK_EXCL)) {
> +	if (!super_lock(sb, SUPER_LOCK_EXCL | flags)) {
>  		active = atomic_inc_not_zero(&sb->s_active);
>  		super_unlock_excl(sb);
>  	}
> @@ -1342,7 +1323,7 @@ static inline bool get_active_super(struct super_block *sb)
>  
>  static void do_thaw_all_callback(struct super_block *sb, void *unused)
>  {
> -	if (!get_active_super(sb))
> +	if (!get_active_super(sb, 0))
>  		return;
>  
>  	/* fs_bdev_thaw() acquires s_umount so it must not be held here */
> @@ -1388,11 +1369,9 @@ static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all
>  	if (!freeze_all_ptr && !(sb->s_type->fs_flags & FS_POWER_FREEZE))
>  		return;
>  
> -	if (!get_active_super(sb)) {
> -		/* an unmount from a workqueue isn't stopped by the freezer */
> -		super_wait_shutdown(sb);
> +	/* an unmount from a workqueue isn't stopped by the freezer */
> +	if (!get_active_super(sb, SUPER_LOCK_WAIT_SHUTDOWN))
>  		return;
> -	}
>  
>  	if (sb->s_op->freeze_super)
>  		sb->s_op->freeze_super(sb, FREEZE_EXCL | FREEZE_HOLDER_KERNEL,
> @@ -1419,7 +1398,7 @@ static void filesystems_thaw_callback(struct super_block *sb, void *unused)
>  	if (!sb->s_op->freeze_fs && !sb->s_op->freeze_super)
>  		return;
>  
> -	if (!get_active_super(sb))
> +	if (!get_active_super(sb, 0))
>  		return;
>  
>  	if (sb->s_op->thaw_super)
> @@ -1660,12 +1639,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for_each_dev_super(sb, &cursor) {
> -		if (super_lock(sb, 0)) {
> -			/* don't take the device away from under an unmount */
> -			if (!surprise)
> -				super_wait_shutdown(sb);
> +		/* don't take the device away from under an unmount */
> +		if (super_lock(sb, surprise ? 0 : SUPER_LOCK_WAIT_SHUTDOWN))
>  			continue;
> -		}
>  		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
>  			if (!sb->s_op->remove_bdev ||
>  			    sb->s_op->remove_bdev(sb, bdev)) {
> @@ -1691,20 +1667,18 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	for_each_dev_super_killable(sb, &cursor) {
>  		int ret;
>  
> -		ret = super_lock(sb, SUPER_LOCK_KILLABLE);
> -		if (!ret) {
> -			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
> -				sync_filesystem(sb);
> -			super_unlock_shared(sb);
> -			continue;
> -		}
> +		ret = super_lock(sb, SUPER_LOCK_KILLABLE |
> +				     SUPER_LOCK_WAIT_SHUTDOWN);
>  		if (ret == -ENOENT)
> -			ret = super_wait_shutdown_killable(sb);
> +			continue;
>  		if (ret) {
>  			super_dev_walk_end(&cursor);
>  			put_super(sb);
>  			return;
>  		}
> +		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
> +			sync_filesystem(sb);
> +		super_unlock_shared(sb);
>  	}
>  }
>  
> @@ -1733,11 +1707,9 @@ static int fs_bdev_freeze(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for_each_dev_super(sb, &cursor) {
> -		if (!get_active_super(sb)) {
> -			/* an unmount writes to the device until it is done */
> -			super_wait_shutdown(sb);
> +		/* an unmount writes to the device until it is done */
> +		if (!get_active_super(sb, SUPER_LOCK_WAIT_SHUTDOWN))
>  			continue;
> -		}
>  		err = fs_super_freeze(sb);
>  		if (err && !error)
>  			error = err;
> @@ -1791,7 +1763,7 @@ static int fs_bdev_thaw(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for_each_dev_super(sb, &cursor) {
> -		if (!get_active_super(sb))
> +		if (!get_active_super(sb, 0))
>  			continue;
>  		err = fs_super_thaw(sb);
>  		if (err && !error)
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
