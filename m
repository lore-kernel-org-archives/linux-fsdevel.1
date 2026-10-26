Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015536;
	b=Y890NIW0KzVV1XBWn5Sjp03FzJR4ZngBTR2w2Vu+2OsN0CmfjLRyGeGc1sihZxRqHF2i
	 CiLbbnPUPQQxR4+w5QOaVgk0QT9T1q7Ico1jZsHiRBoMN6q6CeTjsu6fiMQeU0uK6+Lw7
	 dBQKpFeyMWX0I7RYqHrEchrVPp8OD69rYrZ5pPhZdedG3nkJ+GSkS4RGPLcuKYIjFMnbp
	 5lfQKtCkkhNZShT/uerhKqNUUS7u//aUk/3Nn6OND4Z34rHDVk0KPvwKa5nIH7nWRqYpY
	 gIks49bJn0csXVcOTotpyzJokivuZGPLBScXT6vaWd5vWY+xTZHCGgOcM29leHorPCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015536;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=Ld6pQRS1XVAcbHfpVuJJdRWHOkG/cVMYEOp3pQQkRBg=;
	b=MGSq6TKpLJUzQRqDmBZeugfCwKv9kyrwsgOvI4WpqF3TjXLagXwEPqUz3jTvEqAyatTG
	 9pOa3ZaeqoA7GdyzLIcqg8NIO7hXhRyLqmIjJAGzssOqPIYKbes97JqChKZjWQiErxY2l
	 GbXhqrWtV3AwTeWyL+rLSIdj/QoIec0QBIfgYXe+QsdxbkFBi5aEJGVvjELwCRWopXCU4
	 r4wR9r0kaocLgbLCAcZrJJVFtwQlEcu84PljfiyMf2k3Cotbov99Ts1W+hnAY907EMmLq
	 E1qAhpFgBYWZMo2A2JvVmzS3gSKm7zE27ckliLKHH7vYrQ99wGtz7hcvzMyDVIZDTCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LbueHXB3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f7EhidXT;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n0ElWpS2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OCMuPuDK;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D50606A326;
	Mon, 26 Oct 2026 11:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3D50606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LbueHXB3;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f7EhidXT;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=n0ElWpS2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OCMuPuDK
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EE4801F461;
	Mon, 26 Oct 2026 11:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld6pQRS1XVAcbHfpVuJJdRWHOkG/cVMYEOp3pQQkRBg=;
	b=LbueHXB3piHV5fNixYysrQTBKb6vLL0w2O1UevkWY4G5x5ow4MSP9MmfLC8ezdqvAoVj0f
	7Yg7wGDvp9MvlGJaqyA/1sSTuCs+dJlOfHebRhB1M+ocrepqXnz4yficMgRdfUjyNOHMMS
	kwFwkSaYMPV+unh2Tpz1kKHGkq1mre8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015534;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld6pQRS1XVAcbHfpVuJJdRWHOkG/cVMYEOp3pQQkRBg=;
	b=f7EhidXTX9b6BOywFdC/Kz36tXQuTLT2VzUQGM9hm1924MhDBy0nRGPlMcfMsONRW6FXFE
	0iFwCQuCbq61lXBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=n0ElWpS2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OCMuPuDK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld6pQRS1XVAcbHfpVuJJdRWHOkG/cVMYEOp3pQQkRBg=;
	b=n0ElWpS21XJNl4N0nE0iUuMd2zmFSqs0V+2521oVVyOwC540CfjceAibDsYu8OHG3H4LZo
	jz/qLQg0eSFwIoM/PSqmJWpefPBnfR1Lz5S+0yh7EsbA1rLTGYpTTcdBS7kJ2hZXR4N7uM
	IOg5XmpCygtLHlGMjHsqdXgToPzi/mE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ld6pQRS1XVAcbHfpVuJJdRWHOkG/cVMYEOp3pQQkRBg=;
	b=OCMuPuDKAf8dPJUjysOC6yTK/zEIvpvo3Hll9SZ90hgL+Pp8zXIpbhgM+8rdEySEWMswhp
	IqrsKNUPO16cu/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C03AB13408;
	Mon, 26 Oct 2026 11:52:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DUgCJ+w+32q0EAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 11:52:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4E571A1419; Mon, 26 Oct 2026 12:51:57 +0100 (CET)
Date: Mon, 26 Oct 2026 12:51:57 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] super: let super_lock() take flags
Message-ID: <47bakruk4wgmxfcnepjksifr6eohwf3l5gmxjwjwur3wbekcqw@mqufkqbgpe4e>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-2-d0fcb3f2f275@kernel.org>
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
In-Reply-To: <20261023-work-super-lock_helpers-v1-2-d0fcb3f2f275@kernel.org>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: EE4801F461

On Fri 23-10-26 11:41:02, Christian Brauner wrote:
> We have super_lock() returning a bool, super_lock_killable() returning
> an int and both forwarding to super_lock_common() which takes two bools.
> On top of that super_lock_shared() and super_lock_excl() return true on
> success while super_lock_killable() returns 0 on success. So whether
> "if (super_lock*(sb))" means we got the lock depends on which one is
> called. And the next patch wants super_lock() to optionally wait for a
> superblock that's being shut down.
> 
> So instead of growing yet another variant, add SUPER_LOCK_EXCL and
> SUPER_LOCK_KILLABLE and pass them all the way down. __super_lock() and
> super_unlock() take the flags instead of a bool, which also gets rid of
> __super_lock_killable(). super_lock() takes the flags and returns 0,
> -ENOENT or the error from the wait. Then remove super_lock_killable(),
> super_lock_common(), super_lock_shared() and super_lock_excl() and
> convert everyone to super_lock().
> 
> No functional changes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Yeah, much better. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 163 +++++++++++++++++++++++++------------------------------------
>  1 file changed, 67 insertions(+), 96 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 16b9d7ac381c..0185c1f16ba3 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -55,24 +55,31 @@ static char *sb_writers_name[SB_FREEZE_LEVELS] = {
>  	"sb_internal",
>  };
>  
> -static inline void __super_lock(struct super_block *sb, bool excl)
> +enum super_lock_flags_t {
> +	SUPER_LOCK_EXCL		= (1U << 0),
> +	SUPER_LOCK_KILLABLE	= (1U << 1),
> +};
> +
> +static inline int __super_lock(struct super_block *sb,
> +			       enum super_lock_flags_t flags)
>  {
> -	if (excl)
> +	if (flags & SUPER_LOCK_KILLABLE) {
> +		if (flags & SUPER_LOCK_EXCL)
> +			return down_write_killable(&sb->s_umount);
> +		return down_read_killable(&sb->s_umount);
> +	}
> +
> +	if (flags & SUPER_LOCK_EXCL)
>  		down_write(&sb->s_umount);
>  	else
>  		down_read(&sb->s_umount);
> +	return 0;
>  }
>  
> -static inline int __super_lock_killable(struct super_block *sb, bool excl)
> -{
> -	if (excl)
> -		return down_write_killable(&sb->s_umount);
> -	return down_read_killable(&sb->s_umount);
> -}
> -
> -static inline void super_unlock(struct super_block *sb, bool excl)
> +static inline void super_unlock(struct super_block *sb,
> +				enum super_lock_flags_t flags)
>  {
> -	if (excl)
> +	if (flags & SUPER_LOCK_EXCL)
>  		up_write(&sb->s_umount);
>  	else
>  		up_read(&sb->s_umount);
> @@ -80,17 +87,17 @@ static inline void super_unlock(struct super_block *sb, bool excl)
>  
>  static inline void __super_lock_excl(struct super_block *sb)
>  {
> -	__super_lock(sb, true);
> +	__super_lock(sb, SUPER_LOCK_EXCL);
>  }
>  
>  static inline void super_unlock_excl(struct super_block *sb)
>  {
> -	super_unlock(sb, true);
> +	super_unlock(sb, SUPER_LOCK_EXCL);
>  }
>  
>  static inline void super_unlock_shared(struct super_block *sb)
>  {
> -	super_unlock(sb, false);
> +	super_unlock(sb, 0);
>  }
>  
>  static bool super_flags(const struct super_block *sb, unsigned int flags)
> @@ -113,13 +120,38 @@ static int super_wait(struct super_block *sb, unsigned int sb_flags,
>  				    state);
>  }
>  
> -/*
> - * Returns 0 with s_umount held, -ENOENT if the superblock is going away, or,
> - * if @killable, the error from a wait which was cut short.
> +/**
> + * super_lock - wait for superblock to become ready and lock it
> + * @sb: superblock to wait for
> + * @flags: SUPER_LOCK_* flags
> + *
> + * If the superblock has neither passed through vfs_get_tree() or
> + * generic_shutdown_super() yet wait for it to happen. Either superblock
> + * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> + * woken and we'll see SB_DYING.
> + *
> + * A superblock which is being shut down is not waited for, see
> + * super_wait_shutdown() and super_wait_shutdown_killable() for that.
> + *
> + * With SUPER_LOCK_EXCL s_umount is taken for writing, otherwise for reading.
> + * With SUPER_LOCK_KILLABLE both the wait and taking s_umount can be cut short
> + * by a fatal signal.  That is only for callers which give up altogether when
> + * they are killed.
> + *
> + * The caller must have acquired a temporary reference on @sb->s_passive.
> + *
> + * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
> + *         -ENOENT if the superblock is being shut down or SB_DYING was set,
> + *         -EINTR or -ERESTARTSYS if the task was killed.
>   */
> -static int super_lock_common(struct super_block *sb, bool excl, bool killable)
> +static __must_check int super_lock(struct super_block *sb,
> +				   enum super_lock_flags_t flags)
>  {
> -	int ret = 0;
> +	unsigned int state = TASK_UNINTERRUPTIBLE;
> +	int ret;
> +
> +	if (flags & SUPER_LOCK_KILLABLE)
> +		state = TASK_KILLABLE;
>  
>  	lockdep_assert_not_held(&sb->s_umount);
>  
> @@ -133,8 +165,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
>  		return -ENOENT;
>  
>  	/* wait until the superblock is ready or dying */
> -	ret = super_wait(sb, SB_BORN | SB_DYING,
> -			 killable ? TASK_KILLABLE : TASK_UNINTERRUPTIBLE);
> +	ret = super_wait(sb, SB_BORN | SB_DYING, state);
>  	if (ret)
>  		return ret;
>  
> @@ -142,10 +173,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
>  	if (super_flags(sb, SB_DYING))
>  		return -ENOENT;
>  
> -	if (killable)
> -		ret = __super_lock_killable(sb, excl);
> -	else
> -		__super_lock(sb, excl);
> +	ret = __super_lock(sb, flags);
>  	if (ret)
>  		return ret;
>  
> @@ -155,7 +183,7 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
>  	 * grab a reference to this. Tell them so.
>  	 */
>  	if (sb->s_flags & SB_DYING) {
> -		super_unlock(sb, excl);
> +		super_unlock(sb, flags);
>  		return -ENOENT;
>  	}
>  
> @@ -163,49 +191,6 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
>  	return 0;
>  }
>  
> -/**
> - * super_lock - wait for superblock to become ready and lock it
> - * @sb: superblock to wait for
> - * @excl: whether exclusive access is required
> - *
> - * If the superblock has neither passed through vfs_get_tree() or
> - * generic_shutdown_super() yet wait for it to happen. Either superblock
> - * creation will succeed and SB_BORN is set by vfs_get_tree() or we're
> - * woken and we'll see SB_DYING.
> - *
> - * A superblock which is being shut down is not waited for, see
> - * super_wait_shutdown() and super_wait_shutdown_killable() for that.
> - *
> - * The caller must have acquired a temporary reference on @sb->s_passive.
> - *
> - * Return: The function returns true if SB_BORN was set and with
> - *         s_umount held. The function returns false if the superblock
> - *         is being shut down or SB_DYING was set and without s_umount
> - *         held.
> - */
> -static __must_check bool super_lock(struct super_block *sb, bool excl)
> -{
> -	return !super_lock_common(sb, excl, false);
> -}
> -
> -/**
> - * super_lock_killable - killable super_lock()
> - * @sb: superblock to wait for
> - * @excl: whether exclusive access is required
> - *
> - * Only for callers which give up altogether when they are killed.
> - *
> - * The caller must have acquired a temporary reference on @sb->s_passive.
> - *
> - * Return: 0 if SB_BORN was set and with s_umount held. Without s_umount held,
> - *         -ENOENT if the superblock is being shut down or SB_DYING was set,
> - *         -EINTR or -ERESTARTSYS if the task was killed.
> - */
> -static __must_check int super_lock_killable(struct super_block *sb, bool excl)
> -{
> -	return super_lock_common(sb, excl, true);
> -}
> -
>  /**
>   * super_wait_shutdown_killable - wait for a superblock being shut down
>   * @sb: superblock super_lock() failed on
> @@ -240,18 +225,6 @@ static void super_wait_shutdown(struct super_block *sb)
>  	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
>  }
>  
> -/* wait and try to acquire read-side of @sb->s_umount */
> -static inline bool super_lock_shared(struct super_block *sb)
> -{
> -	return super_lock(sb, false);
> -}
> -
> -/* wait and try to acquire write-side of @sb->s_umount */
> -static inline bool super_lock_excl(struct super_block *sb)
> -{
> -	return super_lock(sb, true);
> -}
> -
>  /* wake waiters */
>  #define SUPER_WAKE_FLAGS (SB_BORN | SB_DYING | SB_DEAD)
>  static void super_wake(struct super_block *sb, unsigned int flag)
> @@ -726,7 +699,7 @@ static int grab_super(struct super_block *sb)
>  
>  	refcount_inc(&sb->s_passive);
>  	spin_unlock(&sb_lock);
> -	ret = super_lock_killable(sb, true);
> +	ret = super_lock(sb, SUPER_LOCK_EXCL | SUPER_LOCK_KILLABLE);
>  	if (!ret) {
>  		if (atomic_inc_not_zero(&sb->s_active)) {
>  			put_super(sb);
> @@ -1078,7 +1051,7 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  
>  		if (flags & SUPER_ITER_UNLOCKED) {
>  			f(sb, arg);
> -		} else if (super_lock_shared(sb)) {
> +		} else if (!super_lock(sb, 0)) {
>  			f(sb, arg);
>  			super_unlock_shared(sb);
>  		} else if (flags & SUPER_ITER_WAIT_SHUTDOWN) {
> @@ -1155,8 +1128,6 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  	spin_lock(&sb_lock);
>  	hlist_for_each_entry(sb, &type->fs_supers, s_instances) {
> -		bool locked;
> -
>  		if (super_flags(sb, SB_DYING))
>  			continue;
>  
> @@ -1165,8 +1136,7 @@ void iterate_supers_type(struct file_system_type *type,
>  
>  		spin_unlock(&sb_lock);
>  
> -		locked = super_lock_shared(sb);
> -		if (locked) {
> +		if (!super_lock(sb, 0)) {
>  			f(sb, arg);
>  			super_unlock_shared(sb);
>  		}
> @@ -1191,7 +1161,8 @@ struct super_block *user_get_super(dev_t dev, bool excl)
>  	for_each_dev_super_killable(sb, &cursor) {
>  		int ret;
>  
> -		ret = super_lock_killable(sb, excl);
> +		ret = super_lock(sb, (excl ? SUPER_LOCK_EXCL : 0) |
> +				     SUPER_LOCK_KILLABLE);
>  		if (ret == -ENOENT)
>  			continue;
>  		super_dev_walk_end(&cursor);
> @@ -1314,7 +1285,7 @@ static void do_emergency_remount_callback(struct super_block *sb, void *unused)
>  {
>  	struct fs_context *fc = NULL;
>  
> -	if (!super_lock_excl(sb)) {
> +	if (super_lock(sb, SUPER_LOCK_EXCL)) {
>  		/* the unmount writes the filesystem out, wait for that */
>  		super_wait_shutdown(sb);
>  		return;
> @@ -1362,7 +1333,7 @@ static inline bool get_active_super(struct super_block *sb)
>  {
>  	bool active = false;
>  
> -	if (super_lock_excl(sb)) {
> +	if (!super_lock(sb, SUPER_LOCK_EXCL)) {
>  		active = atomic_inc_not_zero(&sb->s_active);
>  		super_unlock_excl(sb);
>  	}
> @@ -1379,7 +1350,7 @@ static void do_thaw_all_callback(struct super_block *sb, void *unused)
>  		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
>  			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
>  
> -	if (super_lock_excl(sb))
> +	if (!super_lock(sb, SUPER_LOCK_EXCL))
>  		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
>  	deactivate_super(sb);
>  }
> @@ -1668,7 +1639,7 @@ static int fs_super_thaw(struct super_block *sb)
>  	}
>  
>  	/* The caller holds an active reference. */
> -	if (WARN_ON_ONCE(!super_lock_excl(sb)))
> +	if (WARN_ON_ONCE(super_lock(sb, SUPER_LOCK_EXCL)))
>  		return 0;
>  
>  	/* FITHAW or an emergency thaw may have dropped the freeze already. */
> @@ -1689,7 +1660,7 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
>  	mutex_unlock(&bdev->bd_holder_lock);
>  
>  	for_each_dev_super(sb, &cursor) {
> -		if (!super_lock_shared(sb)) {
> +		if (super_lock(sb, 0)) {
>  			/* don't take the device away from under an unmount */
>  			if (!surprise)
>  				super_wait_shutdown(sb);
> @@ -1720,7 +1691,7 @@ static void fs_bdev_sync(struct block_device *bdev)
>  	for_each_dev_super_killable(sb, &cursor) {
>  		int ret;
>  
> -		ret = super_lock_killable(sb, false);
> +		ret = super_lock(sb, SUPER_LOCK_KILLABLE);
>  		if (!ret) {
>  			if (sb->s_root && (sb->s_flags & SB_ACTIVE))
>  				sync_filesystem(sb);
> @@ -2517,7 +2488,7 @@ int freeze_super(struct super_block *sb, enum freeze_holder who, const void *fre
>  {
>  	int ret;
>  
> -	if (!super_lock_excl(sb)) {
> +	if (super_lock(sb, SUPER_LOCK_EXCL)) {
>  		WARN_ONCE(1, "Dying superblock while freezing!");
>  		return -EINVAL;
>  	}
> @@ -2684,7 +2655,7 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  int thaw_super(struct super_block *sb, enum freeze_holder who,
>  	       const void *freeze_owner)
>  {
> -	if (!super_lock_excl(sb)) {
> +	if (super_lock(sb, SUPER_LOCK_EXCL)) {
>  		WARN_ONCE(1, "Dying superblock while thawing!");
>  		return -EINVAL;
>  	}
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
