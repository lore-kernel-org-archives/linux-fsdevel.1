Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508623;
	b=IgHwgymd1rBjY9mjIxOKVFuop5o0ILGErN1WVubTn15XmawA8FQGAvDQj/YAxj2Ibupc
	 hL+L1AGv0HJJk3qjVpR0UMv58zYWBN8CCJP9aTnOfDbIqoz1LdivGVl+21iWmqBUi+9Us
	 wRyM6f8c1kmS8kabRB7FvyosJh7XDwD9FM7D2HqlwCpbNL4TlkOyL3zivVj7tvbtz+Ujd
	 YHIhoBZVrH587podxDJgZ1ME0x9nIbAHKvLk3HO/kLi2Vp2kOvdGj53q/dKQ6GewGsuRB
	 xUmsxtZMHYyhDlo+8IWZi+fengqEQmd8GFLOxEEVWLFd3yuNzzIxTI0+/yWYhkNUPJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508623;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=YNyZvljjupoERpOMqhDrufKq/PdBwzb6lh97PSr1pUg=;
	b=05zryBsTOUEomWCq44/CsjVTwXjEImqqiwb6QQRuwAStT8N+VV3dw4ckvLKKm3okGLrg
	 h674MxPQUafJSsL4lECz6qDsXOP+ENxkMr7WLl0YpC/5KJrzc1x9G1iAmvfvPDNDYlo3s
	 2IDwQwPJUbE1ZUOrckuncSTIzPxyrcBIUhWzWrES/IuRsHdO3d88GysC6oBd1jOq0AL7K
	 jqpi31JMrrjVEPN7RDqdPukCE1syugKHmdVxibtsLcQkcD5A2fPtchGNX1ZLHUONEw86z
	 UF2VioMhYK/WNKKdS7/oydXd0CMCSiY0nLzYMLPRQZVFwJ5VlDwK9h6CsgvrG1VtjZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0tbt8aKX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3V5wbThp;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0tbt8aKX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3V5wbThp;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939E4606A327;
	Thu, 12 Nov 2026 18:37:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 939E4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0tbt8aKX;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3V5wbThp;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=0tbt8aKX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3V5wbThp
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA24A21F76;
	Thu, 12 Nov 2026 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794508620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNyZvljjupoERpOMqhDrufKq/PdBwzb6lh97PSr1pUg=;
	b=0tbt8aKX+yVg9SVzlohLHe2Q9zf01ji9a0d1HNfzoyQwj1sOsYCWzrcb1FKoo3yZjOYOhA
	mIPzdsm5fn3qI23eiEHKkAgVQgIcVzWSBJMKjD2A8Xxzpvtr8CSIJeEVFrhvv6oNYOzB/3
	IK6g4hVfamXzbeqquRATjLuKZUbGj6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794508620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNyZvljjupoERpOMqhDrufKq/PdBwzb6lh97PSr1pUg=;
	b=3V5wbThpM+F1UBJfXFPNglg8Hkn+4PuadrEHy46tuQdP0K9LpTsrUvRjjJ48v0RGuB+3Fg
	z5hKJUhd4WLcpEBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794508620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNyZvljjupoERpOMqhDrufKq/PdBwzb6lh97PSr1pUg=;
	b=0tbt8aKX+yVg9SVzlohLHe2Q9zf01ji9a0d1HNfzoyQwj1sOsYCWzrcb1FKoo3yZjOYOhA
	mIPzdsm5fn3qI23eiEHKkAgVQgIcVzWSBJMKjD2A8Xxzpvtr8CSIJeEVFrhvv6oNYOzB/3
	IK6g4hVfamXzbeqquRATjLuKZUbGj6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794508620;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YNyZvljjupoERpOMqhDrufKq/PdBwzb6lh97PSr1pUg=;
	b=3V5wbThpM+F1UBJfXFPNglg8Hkn+4PuadrEHy46tuQdP0K9LpTsrUvRjjJ48v0RGuB+3Fg
	z5hKJUhd4WLcpEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85F3713432;
	Thu, 12 Nov 2026 18:37:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5YPCGkwH9mrfQwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 12 Nov 2026 18:37:00 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id AD63022B86; Thu, 12 Nov 2026 19:36:59 +0100 (CET)
Date: Thu, 12 Nov 2026 19:36:59 +0100
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: pack fields `i_state` and `i_fsnotify_mask`
Message-ID: <mvh4ekf6iyfijuqggxhpl7kwxdyysx2zqdrp65bxitucxikwpm@6bkppgjyhsoj>
References: <20261111153631.1309838-1-max.kellermann@ionos.com>
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
In-Reply-To: <20261111153631.1309838-1-max.kellermann@ionos.com>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Wed 11-11-26 16:36:30, Max Kellermann wrote:
> Both were 32 bit fields followed by a 32 bit hole.  This reduces size
> of `struct inode` by 8 bytes.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

When moving i_fsnotify_mask please move it along with i_fsnotify_marks. It
should better be in the same cacheline because these two are accessed on
some performance sensitive paths.

								Honza

> ---
>  include/linux/fs.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77..9ab028dabc1b 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -813,7 +813,11 @@ struct inode {
>  
>  	/* Misc */
>  	struct inode_state_flags i_state;
> -	/* 32-bit hole */
> +
> +#ifdef CONFIG_FSNOTIFY
> +	__u32			i_fsnotify_mask; /* all events this inode cares about */
> +#endif
> +
>  	struct rw_semaphore	i_rwsem;
>  
>  	/* Timestamp for writeback list ordering and age checks (jiffies). */
> @@ -865,8 +869,6 @@ struct inode {
>  
>  
>  #ifdef CONFIG_FSNOTIFY
> -	__u32			i_fsnotify_mask; /* all events this inode cares about */
> -	/* 32-bit hole reserved for expanding i_fsnotify_mask */
>  	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
>  #endif
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
