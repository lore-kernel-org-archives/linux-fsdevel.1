Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015313;
	b=j45DMrmaq+ptNKTE62lVwlKn3qKD50jAizwnD3a0OZId8g2Teo3hqiLT51WXUmx6lgwz
	 tzRy2qrzm4NAiCOHbFphLd5/akNwLs9bn7DUwuoIwImwr7LWVmbFbLx6rDHk//jsuV3B6
	 4hiKnwhPScEd8I7NRgwni8cZGF/OuPrleB11an2VECsUIyKDR8VPEGaq3zt9UcRk6CMeY
	 j6JJGwEauF4yeHvw5+NYscguW/tWVu/CRYLLpMTuWJp6LRkePWlfD5VxUdJUft6dtE8A8
	 KPduyb171xb4iOm31sgSPJkmCqn17xYqmfDgwgrL9EnN2ztXpTfukUOufdosJESuSlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015313;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=fM/46f3Fbq+EIxzw9hwaJdKkJPiA0eFwBSlBaZv8UD4=;
	b=OTfARobKRD7CBP3si00POOqmhdOqKWxR50yK1FCpAF0OkM4yePAH/jZ0EcgAHYr8R0tV
	 LR2USQqwsEG1cISCgrT46wYxufO58n2sbFf3tXkoONlr0k4rAX/jrPR7rRkWwJJQPCY0P
	 fb0Sui5SY0RUNema3amk1M1eiukHTZDDFF+FI2HZ8TJ3PIyGZMSDmfvHwUGHcRQZR2iOY
	 L01ntL2U25W96p6FjDjVffrPWRDjQiQMzgYD0o54G5oMxGe1TfWJzY0vyduhdRym/me6M
	 8yz+0lSeZW2MGg8D+8UFb8PdLEkstppSn/89UQt3cdRdFSlGU/MlCTBe7R51bFQJeTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RC+jjzXj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8SqA6sFi;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RC+jjzXj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8SqA6sFi;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321B606A322;
	Mon, 26 Oct 2026 11:48:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4321B606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RC+jjzXj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8SqA6sFi;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=RC+jjzXj;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8SqA6sFi
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 54290222E9;
	Mon, 26 Oct 2026 11:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/46f3Fbq+EIxzw9hwaJdKkJPiA0eFwBSlBaZv8UD4=;
	b=RC+jjzXjBbCHL5jzDEay57Y7AYjYPFjnMO5Zq0DIxz1GBfqNznEDfN/FcBMJzWK79j1u66
	3hpM0gJ5xmokVpyeI5IfeA5NwpK2VnADHM9uBGhYonbQpoicthT1QbIvvF8LVSiXE7F2O3
	/r7I2thkEEno2yeZl3KXWd5tDXp2u/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/46f3Fbq+EIxzw9hwaJdKkJPiA0eFwBSlBaZv8UD4=;
	b=8SqA6sFiPB5Rgjt0wRttZqzNOCdZVf+DKpHW+eIFj8NW8oFHvmwektJSrs4Sw5Fxej+wCV
	VBYEpfMNrIa2VdBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=RC+jjzXj;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8SqA6sFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793015311; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/46f3Fbq+EIxzw9hwaJdKkJPiA0eFwBSlBaZv8UD4=;
	b=RC+jjzXjBbCHL5jzDEay57Y7AYjYPFjnMO5Zq0DIxz1GBfqNznEDfN/FcBMJzWK79j1u66
	3hpM0gJ5xmokVpyeI5IfeA5NwpK2VnADHM9uBGhYonbQpoicthT1QbIvvF8LVSiXE7F2O3
	/r7I2thkEEno2yeZl3KXWd5tDXp2u/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793015311;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fM/46f3Fbq+EIxzw9hwaJdKkJPiA0eFwBSlBaZv8UD4=;
	b=8SqA6sFiPB5Rgjt0wRttZqzNOCdZVf+DKpHW+eIFj8NW8oFHvmwektJSrs4Sw5Fxej+wCV
	VBYEpfMNrIa2VdBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 27B9913408;
	Mon, 26 Oct 2026 11:48:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id z940AQ8+32pIDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 11:48:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9551A1419; Mon, 26 Oct 2026 12:48:30 +0100 (CET)
Date: Mon, 26 Oct 2026 12:48:30 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] super: add super_wait()
Message-ID: <hcaql2pfvlhp3hin437vwo7cycgk4i7hwuprwniv5alz7fo3be@dljf4hop2vaj>
References: <20261023-work-super-lock_helpers-v1-0-d0fcb3f2f275@kernel.org>
 <20261023-work-super-lock_helpers-v1-1-d0fcb3f2f275@kernel.org>
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
In-Reply-To: <20261023-work-super-lock_helpers-v1-1-d0fcb3f2f275@kernel.org>
X-Rspamd-Queue-Id: 54290222E9
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Fri 23-10-26 11:41:01, Christian Brauner wrote:
> We wait for SB_BORN, SB_DYING and SB_DEAD in five places now, each with
> an open-coded wait_var_event(), wait_var_event_killable() or
> wait_var_event_state() on sb->s_flags and super_lock_common() picking
> between the first two depending on @killable. Add super_wait() which
> takes the flags to wait for and the task state to sleep in and use it
> everywhere.
> 
> No functional changes.
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 63e85794ea4d..16b9d7ac381c 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -102,6 +102,17 @@ static bool super_flags(const struct super_block *sb, unsigned int flags)
>  	return smp_load_acquire(&sb->s_flags) & flags;
>  }
>  
> +/*
> + * Wait for one of @sb_flags to be set on @sb, sleeping in @state.  Returns 0
> + * or -ERESTARTSYS if @state allowed the wait to be cut short.
> + */
> +static int super_wait(struct super_block *sb, unsigned int sb_flags,
> +		      unsigned int state)
> +{
> +	return wait_var_event_state(&sb->s_flags, super_flags(sb, sb_flags),
> +				    state);
> +}
> +
>  /*
>   * Returns 0 with s_umount held, -ENOENT if the superblock is going away, or,
>   * if @killable, the error from a wait which was cut short.
> @@ -122,12 +133,8 @@ static int super_lock_common(struct super_block *sb, bool excl, bool killable)
>  		return -ENOENT;
>  
>  	/* wait until the superblock is ready or dying */
> -	if (killable)
> -		ret = wait_var_event_killable(&sb->s_flags,
> -					      super_flags(sb, SB_BORN | SB_DYING));
> -	else
> -		wait_var_event(&sb->s_flags,
> -			       super_flags(sb, SB_BORN | SB_DYING));
> +	ret = super_wait(sb, SB_BORN | SB_DYING,
> +			 killable ? TASK_KILLABLE : TASK_UNINTERRUPTIBLE);
>  	if (ret)
>  		return ret;
>  
> @@ -216,7 +223,7 @@ static __must_check int super_lock_killable(struct super_block *sb, bool excl)
>   */
>  static int super_wait_shutdown_killable(struct super_block *sb)
>  {
> -	return wait_var_event_killable(&sb->s_flags, super_flags(sb, SB_DYING));
> +	return super_wait(sb, SB_DYING, TASK_KILLABLE);
>  }
>  
>  /**
> @@ -230,7 +237,7 @@ static int super_wait_shutdown_killable(struct super_block *sb)
>   */
>  static void super_wait_shutdown(struct super_block *sb)
>  {
> -	wait_var_event(&sb->s_flags, super_flags(sb, SB_DYING));
> +	super_wait(sb, SB_DYING, TASK_UNINTERRUPTIBLE);
>  }
>  
>  /* wait and try to acquire read-side of @sb->s_umount */
> @@ -606,9 +613,7 @@ static struct super_block *super_dev_next(struct super_dev *cursor,
>  				return sb;
>  			}
>  		}
> -		ret = wait_var_event_state(&sb->s_flags,
> -					   super_flags(sb, SB_BORN | SB_DYING),
> -					   state);
> +		ret = super_wait(sb, SB_BORN | SB_DYING, state);
>  		put_super(sb);
>  		if (ret) {
>  			super_dev_walk_end(cursor);
> @@ -731,8 +736,7 @@ static int grab_super(struct super_block *sb)
>  		ret = -ENOENT;
>  	}
>  	if (ret == -ENOENT)
> -		ret = wait_var_event_killable(&sb->s_flags,
> -					      super_flags(sb, SB_DEAD));
> +		ret = super_wait(sb, SB_DEAD, TASK_KILLABLE);
>  	put_super(sb);
>  	return ret ? ret : -EAGAIN;
>  }
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
