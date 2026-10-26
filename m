Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016755;
	b=tDDjk5A0Oh1LLCGe+XPNcV0a+XVFmjsNo55/HxRvtwlFnJAETmJPfGfVrffQeGBEXRLF
	 6eTe4kakYphfQZ3jGaFy4YtYuV1sK+e/lP6ga+1GxNycz3V0fFaf+mGbKZoDktEmE9Kf1
	 WlI9pT4Y/qKUBKRySA+XFkUcmmunbYSDi7WcijY9Tbo0HIrfA2Jzb4HVnoMBo1hfCdvG3
	 yWXRUXbxd0ArydmPf5pgLYMk4Y/e5rLMQmFOxBFIFhlJxC1fdHG2xVeNLB5qNM/hw+E3B
	 tfXRrIipxXU3FrEZqeYZKEb4ZSj9PWZBWCwNgVgTOdxxOSo/mjEaCsgLg6ZjHoPGShw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016755;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=oLO6wJvlhFQRSfA1FFml5hXTIiBGjyJ1NcHfVuDpvf8=;
	b=fuNxdSCV9sIusw2d/66lOFaDzwjI4P5rc1ld0hZZ/KookDcx4yTVjmhop+gh3y9zSsIW
	 SbWKMTCHcZHw5kQ+eVSndFwAPQlA9zlLqa1nFZ84XJ+KW7S1F7zpSr5668xGNk8YQWpsD
	 3/abemQbRpUUIIAvwI1/jxeDgfY/xLfQ+yY2ve0SaqIzbfi220fF8BdE3QOLOSGOd9bNF
	 kByPwOEaufP09vC17/bItaUIWSGR0BtqQapC053vmlFHGjxivycRwnymcQWI5wNlqxb2k
	 XCxYTojkzgDaCCXynt6dxOr0fo2DrH74/JmOZx0TghkLoGcI3HJ452FWg5CwFvQ+xbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kMTLS57r;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="pSr/7ddw";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kMTLS57r;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="pSr/7ddw";
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85308606A32F;
	Mon, 26 Oct 2026 12:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85308606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kMTLS57r;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pSr/7ddw;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kMTLS57r;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pSr/7ddw
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A0935221F6;
	Mon, 26 Oct 2026 12:12:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793016752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLO6wJvlhFQRSfA1FFml5hXTIiBGjyJ1NcHfVuDpvf8=;
	b=kMTLS57rwPg0Q6zT0aGhZZGMMOKPWa5pfedZMabCbyrRCq4QXBTatWqor+RUuASwvISQrs
	jgLxtVDa2ThIka7v94Hn50i8YRgxSvTOGIH5Tp948wj9SoZWG0p62bu+S6jIEvUF6lh3SX
	nKaT1VwrYS1T9GMCVx1zINMpBuc8eiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793016752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLO6wJvlhFQRSfA1FFml5hXTIiBGjyJ1NcHfVuDpvf8=;
	b=pSr/7ddwsEu+1H5JWtLspRoOtDXev2smp3uQGECwPgGt9Q/3dQN93QAeBxIuelWWGESGlu
	PVdQPCn/nIPJpdDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793016752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLO6wJvlhFQRSfA1FFml5hXTIiBGjyJ1NcHfVuDpvf8=;
	b=kMTLS57rwPg0Q6zT0aGhZZGMMOKPWa5pfedZMabCbyrRCq4QXBTatWqor+RUuASwvISQrs
	jgLxtVDa2ThIka7v94Hn50i8YRgxSvTOGIH5Tp948wj9SoZWG0p62bu+S6jIEvUF6lh3SX
	nKaT1VwrYS1T9GMCVx1zINMpBuc8eiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793016752;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oLO6wJvlhFQRSfA1FFml5hXTIiBGjyJ1NcHfVuDpvf8=;
	b=pSr/7ddwsEu+1H5JWtLspRoOtDXev2smp3uQGECwPgGt9Q/3dQN93QAeBxIuelWWGESGlu
	PVdQPCn/nIPJpdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D99613319;
	Mon, 26 Oct 2026 12:12:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 652LGLBD32rjJQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 12:12:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19040A1419; Mon, 26 Oct 2026 13:12:28 +0100 (CET)
Date: Mon, 26 Oct 2026 13:12:28 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] super: add a guard for super_lock()
Message-ID: <5n2zjrxtkvjkj7eb3qtugk6s3hj7ki7mh6va5fmailrsonqkio@25bxng5aduhz>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-5-d0fcb3f2f275@kernel.org>
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
In-Reply-To: <20261023-work-super-lock_helpers-v1-5-d0fcb3f2f275@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Spam-Score: -12.80

On Fri 23-10-26 11:41:05, Christian Brauner wrote:
> Six callers take s_umount and drop it again in the same scope and have
> to pick the unlock that matches the lock they took. Add a guard for
> super_lock() that unlocks with the flags it locked with and convert
> them. Similar to irqdesc_lock let's build it from
> __DEFINE_UNLOCK_GUARD() as super_lock() takes its flags at runtime.
> 
> The device walks use ACQUIRE() instead of scoped_guard() so a continue
> still moves on to the next superblock. __iterate_supers() uses ACQUIRE()
> as well because, like fs_bdev_sync(), it needs ACQUIRE_ERR() to tell
> -ENOENT from a fatal signal. The callers that hand the lock off stay as
> they are.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Ok, I have mixed feelings about this. Some places definitely look better,
the ones in the loops IMHO uglier but overall there's nothing I would
consider really bad so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 83 ++++++++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 51 insertions(+), 32 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index a0f9eadf0da7..aff2169ca94d 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -206,6 +206,31 @@ static __must_check int super_lock(struct super_block *sb,
>  	return -ENOENT;
>  }
>  
> +static inline void super_unlock_guard(struct super_block *sb,
> +				      enum super_lock_flags_t flags)
> +{
> +	if (!IS_ERR_OR_NULL(sb))
> +		super_unlock(sb, flags);
> +}
> +
> +/* Unlocks with the flags it locked with. */
> +__DEFINE_CLASS_IS_CONDITIONAL(super_lock, true);
> +__DEFINE_UNLOCK_GUARD(super_lock, struct super_block,
> +		      super_unlock_guard(_T->lock, _T->flags),
> +		      enum super_lock_flags_t flags);
> +
> +static inline class_super_lock_t
> +class_super_lock_constructor(struct super_block *sb, enum super_lock_flags_t flags)
> +{
> +	class_super_lock_t _t = { .lock = sb, .flags = flags };
> +	int ret;
> +
> +	ret = super_lock(sb, flags);
> +	if (ret)
> +		_t.lock = ERR_PTR(ret);
> +	return _t;
> +}
> +
>  /* wake waiters */
>  #define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
>  static void super_wake(struct super_block *sb, unsigned int flag)
> @@ -1037,13 +1062,13 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  		if (flags & SUPER_ITER_UNLOCKED) {
>  			f(sb, arg);
>  		} else {
> -			ret = super_lock(sb, lock_flags);
> -			if (!ret) {
> +			ACQUIRE(super_lock, lock)(sb, lock_flags);
> +
> +			ret = ACQUIRE_ERR(super_lock, &lock);
> +			if (!ret)
>  				f(sb, arg);
> -				super_unlock_shared(sb);
> -			} else if (ret == -ENOENT) {
> +			else if (ret == -ENOENT)
>  				ret = 0;
> -			}
>  		}
>  
>  		if (p)
> @@ -1124,10 +1149,8 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  		spin_unlock(&sb_lock);
>  
> -		if (!super_lock(sb, 0)) {
> +		scoped_guard(super_lock, sb, 0)
>  			f(sb, arg);
> -			super_unlock_shared(sb);
> -		}
>  
>  		if (p)
>  			put_super(p);
> @@ -1274,18 +1297,18 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  	struct fs_context *fc = NULL;
>  
>  	/* the unmount writes the filesystem out, wait for that */
> -	if (super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN))
> -		return;
> -
> -	/* Make sure no reference put under s_umount is the last one. */
> -	atomic_inc(&sb->s_active);
> -	if (sb->s_bdev && !sb_rdonly(sb)) {
> -		fc = fs_context_for_reconfigure(sb->s_root,
> -					SB_RDONLY | SB_FORCE, SB_RDONLY);
> -		if (!IS_ERR(fc) && parse_monolithic_mount_data(fc, NULL) == 0)
> -			(void)reconfigure_super(fc);
> +	scoped_cond_guard(super_lock, return, sb,
> +			  SUPER_LOCK_EXCL | SUPER_LOCK_WAIT_SHUTDOWN) {
> +		/* Make sure no reference put under s_umount is the last one. */
> +		atomic_inc(&sb->s_active);
> +		if (sb->s_bdev && !sb_rdonly(sb)) {
> +			fc = fs_context_for_reconfigure(sb->s_root,
> +						SB_RDONLY | SB_FORCE, SB_RDONLY);
> +			if (!IS_ERR(fc) &&
> +			    parse_monolithic_mount_data(fc, NULL) == 0)
> +				(void)reconfigure_super(fc);
> +		}
>  	}
> -	super_unlock_excl(sb);
>  
>  	/*
>  	 * Our active reference may be the last one by now, so only drop it
> @@ -1318,13 +1341,9 @@ void emergency_remount(void)
>  static inline bool get_active_super(struct super_block *sb,
>  				    enum super_lock_flags_t flags)
>  {
> -	bool active = false;
> -
> -	if (!super_lock(sb, SUPER_LOCK_EXCL | flags)) {
> -		active = atomic_inc_not_zero(&sb->s_active);
> -		super_unlock_excl(sb);
> -	}
> -	return active;
> +	scoped_guard(super_lock, sb, SUPER_LOCK_EXCL | flags)
> +		return atomic_inc_not_zero(&sb->s_active);
> +	return false;
>  }
>  
>  static void do_thaw_all_callback(struct super_block *sb, void *unused)
> @@ -1646,7 +1665,9 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  
>  	for_each_dev_super(sb, &cursor) {
>  		/* don't take the device away from under an unmount */
> -		if (super_lock(sb, surprise ? 0 : SUPER_LOCK_WAIT_SHUTDOWN))
> +		ACQUIRE(super_lock, lock)(sb, surprise ? 0 :
> +					      SUPER_LOCK_WAIT_SHUTDOWN);
> +		if (ACQUIRE_ERR(super_lock, &lock))
>  			continue;
>  		if (sb->s_root && (sb->s_flags & SB_ACTIVE)) {
>  			if (!sb->s_op->remove_bdev ||
> @@ -1659,7 +1680,6 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  					sb->s_op->shutdown(sb);
>  			}
>  		}
> -		super_unlock_shared(sb);
>  	}
>  }
>  
> @@ -1671,10 +1691,10 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for_each_dev_super_killable(sb, &cursor) {
> -		int ret;
> +		ACQUIRE(super_lock, lock)(sb, SUPER_LOCK_KILLABLE |
> +					      SUPER_LOCK_WAIT_SHUTDOWN);
> +		int ret = ACQUIRE_ERR(super_lock, &lock);
>  
> -		ret = super_lock(sb, SUPER_LOCK_KILLABLE |
> -				     SUPER_LOCK_WAIT_SHUTDOWN);
>  		if (ret == -ENOENT)
>  			continue;
>  		if (ret) {
> @@ -1684,7 +1704,6 @@ static void fs_bdev_sync(struct block_device *bdev)
>  		}
>  		if (sb->s_root && (sb->s_flags & SB_ACTIVE))
>  			sync_filesystem(sb);
> -		super_unlock_shared(sb);
>  	}
>  }
>  
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
