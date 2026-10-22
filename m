Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670009;
	b=gSs/H4eNeHxBjPCTzVkE/LjPRshdwLoyQjkOmijj9cS9lWPGaBXhHKson78fUKDNTD2X
	 O6Q2ZwTYgMKDC4VnLxKFQkl7bARZz1oUsX3oau8Zem7PCKJiKnm1Mxy6H2XR1LJ7Mj67X
	 3FBTu+v7BpwCZrm/wGxM+naYYZcKjTT1F5rFlSf0VzZzaslhN+GKkcImJuuAouuLbniIr
	 8jJ47ycJhu4AUyr9IYcX4AXz1o6dTFhJyRXmhrV1mX5TUCXiPRhfxzZtPzW8Glay7vbsU
	 jAg/EcQYTtqP6srbxCFltfulw0fpGEev4pobSY9LZ9gqhw+j/g7Zt/JT/vzfRuoqotw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670009;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=zV5QG4YkFp0gVJhnVxy6R7n/tOnhTNMpTs3brqT/FzQ=;
	b=xqSNBEIU7YwyOAyHOekcZp8uwMaPUQiLuZ/r+5EOS2Issu6U2MyNNZXw7I/CuuPpAo/M
	 Yj+QAd0PHCuEyWhQULOaq2JsZKNfX3BqPRm57w/rsANEj+7iEliXKeJV7DZOFweQjWjNm
	 OXvSbI/bteYqWBQMkK0Q7OjLuBVbYZoKV7jjJ1mop2omZPPUXQaQkeQAK7jNsrdnOC0vc
	 1IKKh5x2QWIDrArW2OAplitER4yH6x/dA69KCTnHv080kjFJSPLd0fu7rY8rZFDYpJRLl
	 PJyGvJluStPzbqAWeDd067HfX++Ndt1FrfHzZCGGmplgDBD8bSj7dTvO9VBKNuK35Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sTF34MsF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3lEc3Duh;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sTF34MsF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3lEc3Duh;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE6B606A319;
	Thu, 22 Oct 2026 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FE6B606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sTF34MsF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3lEc3Duh;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=sTF34MsF;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3lEc3Duh
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8ADCD22063;
	Thu, 22 Oct 2026 11:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792670006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zV5QG4YkFp0gVJhnVxy6R7n/tOnhTNMpTs3brqT/FzQ=;
	b=sTF34MsFN8C2u7tuEg9iRDlD4THKNNI+leLe/iBnmU3IqXApfEuEbuyxV3JFCSgFQYWWhj
	Hi55jhm5rZxihECmP4FtxpFcpMae/xjkfGkKHwAtM6B0y8ymBV9AFioqzMuVgGU0gGIppn
	5T9QP6dj1mOiQ1Y9DCQk65ZbyKr92Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792670006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zV5QG4YkFp0gVJhnVxy6R7n/tOnhTNMpTs3brqT/FzQ=;
	b=3lEc3Duh0ASAf2b9CjK8AMVYQ+WAoTauI5WfcD1ZW0adON56e45CmT41CBlkX3oHzHFfk/
	R0spkBGVeUxBycDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=sTF34MsF;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=3lEc3Duh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792670006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zV5QG4YkFp0gVJhnVxy6R7n/tOnhTNMpTs3brqT/FzQ=;
	b=sTF34MsFN8C2u7tuEg9iRDlD4THKNNI+leLe/iBnmU3IqXApfEuEbuyxV3JFCSgFQYWWhj
	Hi55jhm5rZxihECmP4FtxpFcpMae/xjkfGkKHwAtM6B0y8ymBV9AFioqzMuVgGU0gGIppn
	5T9QP6dj1mOiQ1Y9DCQk65ZbyKr92Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792670006;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zV5QG4YkFp0gVJhnVxy6R7n/tOnhTNMpTs3brqT/FzQ=;
	b=3lEc3Duh0ASAf2b9CjK8AMVYQ+WAoTauI5WfcD1ZW0adON56e45CmT41CBlkX3oHzHFfk/
	R0spkBGVeUxBycDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 637D0133F3;
	Thu, 22 Oct 2026 11:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zAwHEDb52Wq4BQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 11:53:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 057E3A1417; Thu, 22 Oct 2026 13:53:22 +0200 (CEST)
Date: Thu, 22 Oct 2026 13:53:21 +0200
From: Jan Kara <jack@suse.cz>
To: Josef Bacik <josef@toxicpanda.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] fs: don't make sync(2) wait for unborn superblocks
Message-ID: <qwvy5gtgtrhzoekv52dbyyv6klw2vdr4v4zhida4kx5xzbmpyx@ol5fouuzn7hb>
References: <20261021-b4-super-lock-unborn-v1-0-0265eddb6dee@toxicpanda.com>
 <20261021-b4-super-lock-unborn-v1-4-0265eddb6dee@toxicpanda.com>
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
In-Reply-To: <20261021-b4-super-lock-unborn-v1-4-0265eddb6dee@toxicpanda.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[toxicpanda.com:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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
X-Rspamd-Queue-Id: 8ADCD22063

On Wed 21-10-26 16:47:00, Josef Bacik wrote:
> A mount which is stuck reading from its device or waiting for its server
> hangs every sync(2) on the machine, and the emergency sync as well, and
> they can't be killed.
> 
> A superblock is on the list sync(2) walks from sget_fc() on, but isn't
> usable until vfs_get_tree() sets SB_BORN, and super_lock() waits for that
> uninterruptibly.
> 
> There is nothing in that wait for them.  sync(2) is about what was written
> before it was called, and nobody can have written to a filesystem which
> isn't mounted yet.  What the filesystem writes on its own while it is being
> mounted, replaying a journal say, is the mount's business: it has to get
> that to disk whether or not anybody calls sync(2).
> 
> Add a flag for __iterate_supers() to skip superblocks without SB_BORN and
> pass it from iterate_supers_sync().
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index ecba64ed0c2a..b8d6f1c969ce 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1041,6 +1041,7 @@ enum super_iter_flags_t {
>  	SUPER_ITER_UNLOCKED	= (1U << 1),
>  	SUPER_ITER_REVERSE	= (1U << 2),
>  	SUPER_ITER_WAIT_SHUTDOWN = (1U << 3),
> +	SUPER_ITER_SKIP_UNBORN	= (1U << 4),
>  };
>  
>  static inline struct super_block *first_super(enum super_iter_flags_t flags)
> @@ -1073,6 +1074,10 @@ static int __iterate_supers(void (*f)(struct super_block *, void *), void *arg,
>  		if (super_flags(sb, SB_DYING))
>  			continue;
>  
> +		if ((flags & SUPER_ITER_SKIP_UNBORN) &&
> +		    !super_flags(sb, SB_BORN))
> +			continue;
> +
>  		if (!refcount_inc_not_zero(&sb->s_passive))
>  			continue;
>  
> @@ -1114,12 +1119,16 @@ void iterate_supers(void (*f)(struct super_block *, void *), void *arg)
>   * down writes it out.  Wait for that, so that it is on disk as well by the time
>   * the walk is over.
>   *
> + * A superblock which is still being set up isn't passed to @f either, and
> + * isn't waited for.  Nobody can have written to it yet.
> + *
>   * Return: 0 if all the superblocks were seen, -ERESTARTSYS if the task was
>   *         killed while it waited for one.
>   */
>  int iterate_supers_sync(void (*f)(struct super_block *, void *), void *arg)
>  {
> -	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN);
> +	return __iterate_supers(f, arg, SUPER_ITER_WAIT_SHUTDOWN |
> +					SUPER_ITER_SKIP_UNBORN);
>  }
>  
>  /**
> 
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
