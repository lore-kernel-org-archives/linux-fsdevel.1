Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581898;
	b=Nkn3Tu75wD9O+zOVkf0gYpDr6bwHXnqlhEDvgAevqkZUz02hudoR8RsoZ+W1hyew4FJ8
	 XlgUpRVDOS1sCI+W9clebB0Wotlol13v4Itd+eV7ccxVmNV5BgxRz2VSW9twtTbh39ujf
	 WixYU79She27FE2zqmrMTxDfv/qsl0Q2oE0E0CE7tQhCpPamDNMFB/PxsDm0l9YWwhoGI
	 XvM2dQI/Rq2EX04BvpplBZ/T/65MFBQyZ60obkplqfABVELNOQvsqbat7dFcyRd/kyk2m
	 EHr2+iCdgfU4/7qnW4V82c9NSrybO9xCmPpnv7OET2LUWHFoQAjWJ2CoMvOymRMtA4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581898;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=bfZQmsdhJIpQZNYSTid621IeXFm9G9f02QDBgP6tqw4=;
	b=3AMVpdpQDByVH0DIMB12v6RvREVJKVF+16/uEkqoJyRRiBUW09YJHkNfV+w5vU2zM3x5
	 /5kisaCzAI7cjuNkrXHrk7+Jhy5llvr3UIqZcfR4/YS5RnpiZ+WTQlQJJ/leDHawxQaEc
	 dtdTrmvjG6K894eJxGjppCrrJjbApPSnHyjgardrxUUEWEWgfP75YqjqQa7nGlY+v24/5
	 icNBrKv4991KIERPg7L0QImXuuRsVfSX4mFE1j96/tgBVWk8dQpeMj2/LfJMqILnQvD9K
	 EoFO0xCysoUKXa0pT+r5I5CxmCY6n6LvdBUWiNNMuLnalgHssViSys/kRp0Pt/UeeCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xCGPpeGe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9eUna6G;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xCGPpeGe;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9eUna6G;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C2606A323;
	Fri, 13 Nov 2026 14:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A2C2606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xCGPpeGe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9eUna6G;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xCGPpeGe;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d9eUna6G
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 495F321FE8;
	Fri, 13 Nov 2026 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794581896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfZQmsdhJIpQZNYSTid621IeXFm9G9f02QDBgP6tqw4=;
	b=xCGPpeGeMePjZFz9QXfGl1axM4lN72C+KMsYup0NprQAkefK6U3wt2NJZz4hCbU6E0ClZE
	WOlehpD9BFu2DfehxQhCDK58euPrDS4pD1NPcPiK2jIwgpP2IEaw1aL+vjvQDL8ccC+J+6
	6Kuz1UzAm44Mfc6N7lN9rt5lvLA+ja4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794581896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfZQmsdhJIpQZNYSTid621IeXFm9G9f02QDBgP6tqw4=;
	b=d9eUna6G19i2gQTUd1eQemJ/vNb7x5BooT6IxFZTdI4q8rGMU+hGcQ73xy8H1JE0ejadLJ
	zYjV01ePlEYNstAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=xCGPpeGe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=d9eUna6G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794581896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfZQmsdhJIpQZNYSTid621IeXFm9G9f02QDBgP6tqw4=;
	b=xCGPpeGeMePjZFz9QXfGl1axM4lN72C+KMsYup0NprQAkefK6U3wt2NJZz4hCbU6E0ClZE
	WOlehpD9BFu2DfehxQhCDK58euPrDS4pD1NPcPiK2jIwgpP2IEaw1aL+vjvQDL8ccC+J+6
	6Kuz1UzAm44Mfc6N7lN9rt5lvLA+ja4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794581896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfZQmsdhJIpQZNYSTid621IeXFm9G9f02QDBgP6tqw4=;
	b=d9eUna6G19i2gQTUd1eQemJ/vNb7x5BooT6IxFZTdI4q8rGMU+hGcQ73xy8H1JE0ejadLJ
	zYjV01ePlEYNstAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B9F0134C3;
	Fri, 13 Nov 2026 14:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KNTQAIgl92pjGQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 13 Nov 2026 14:58:16 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id AC53223970; Fri, 13 Nov 2026 15:58:15 +0100 (CET)
Date: Fri, 13 Nov 2026 15:58:15 +0100
From: Jan Kara <jack@suse.cz>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: pack fields `i_state` and `i_fsnotify_mask`
Message-ID: <ug55ajsadz4cyusrzxw7ytci4upco36v5x32ohq7ilmor6e2ln@vcu4f3kcpmlr>
References: <20261113114427.1845888-1-max.kellermann@ionos.com>
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
In-Reply-To: <20261113114427.1845888-1-max.kellermann@ionos.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 495F321FE8

On Fri 13-11-26 12:44:26, Max Kellermann wrote:
> Both were 32 bit fields followed by a 32 bit hole.  This reduces size
> of `struct inode` by 8 bytes.
> 
> Moving `i_fsnotify_marks` there as well so they can be in the same
> cacheline.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v1->v2: move `i_fsnotify_marks` up as well because "should better be
>   in the same cacheline because these two are accessed on some
>   performance sensitive paths" (Jan Kara)
> ---
>  include/linux/fs.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 5b3a100aba77..fec047cc3327 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -813,7 +813,13 @@ struct inode {
>  
>  	/* Misc */
>  	struct inode_state_flags i_state;
> -	/* 32-bit hole */
> +
> +#ifdef CONFIG_FSNOTIFY
> +	__u32			i_fsnotify_mask; /* all events this inode cares about */
> +
> +	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
> +#endif
> +
>  	struct rw_semaphore	i_rwsem;
>  
>  	/* Timestamp for writeback list ordering and age checks (jiffies). */
> @@ -863,13 +869,6 @@ struct inode {
>  		unsigned		i_dir_seq;
>  	};
>  
> -
> -#ifdef CONFIG_FSNOTIFY
> -	__u32			i_fsnotify_mask; /* all events this inode cares about */
> -	/* 32-bit hole reserved for expanding i_fsnotify_mask */
> -	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
> -#endif
> -
>  	void			*i_private; /* fs or device private pointer */
>  } __randomize_layout;
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
