Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D29A3C4B63
	for <linux-fsdevel@vger.kernel.org>; Mon, 31 Aug 2026 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788165959; cv=none; b=iTcBZxRfI8NdoTdA8qhad8+dcUL5GgP3NzUTfVpggKRs7Mt/KFhwKSeo6x0QzaUY+wm8VhDC4lALTRYCjOlibKM12OxpgS46HRHeJ0xzAzSbqRXzS0+3Mk0X4jTGUzpb5RGgQmNhM75R+0RwoFtn2YKMOouGUimbI7O09pfUYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788165959; c=relaxed/simple;
	bh=ZKx1xAk4m976zhcm0LyM/JEEzLLFOnGhDLKtVNFZ62I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRaqyn5Sfpo1NI9wgAD4a7I7o5a7ztROeNbvUq1P2zIzkHx/n//3X/+pXOetO6JtqDV6hZ1tX5UKizzQqmbwYJDsqIA+bObLL0UgTRxwrwxuq+Dqjq6umT1Iw5FYzeHZJmRPnMsScnhqekn6FAGIMirU6Bj+o6y6kljkuCzyrqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zLzXAshJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VehjXasu; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i6uLZ9l4; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=A4e5MteI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zLzXAshJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VehjXasu";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i6uLZ9l4";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="A4e5MteI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A9E521FB50;
	Mon, 31 Aug 2026 08:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVL0jKar0wFcPGh28iGxpqNGOuuFwpDnmGmtJ+sefXc=;
	b=zLzXAshJIIdR69BS/xD+TPuB8uQM1lG7dhE1SPQZq7V2SnHDDToMru1ngHsUHzTyyXS9OM
	gA65GOK8H922+PhF9ZyGZTxfKN1voRYs7Csa21ScEyA8/IKAHvv+wmHx1QwTMr0Vq1h9LL
	HYQ3H0wLqoLE1BV7VjVi2V7XNT6GxvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165951;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVL0jKar0wFcPGh28iGxpqNGOuuFwpDnmGmtJ+sefXc=;
	b=VehjXasutInCjMD6J542bkjq4OkQME/Gd8KfteuFdV2fb3ueftQAvax9yVbbpBEJJGjomX
	8MbGM6KeXrO8bSBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=i6uLZ9l4;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=A4e5MteI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788165947; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVL0jKar0wFcPGh28iGxpqNGOuuFwpDnmGmtJ+sefXc=;
	b=i6uLZ9l492ma+x5KKooFsIOAB4uPFfSW3PP9Km9P5huDMpHFeFGCssW10evPQDbjB3wtlc
	JOSt6zlDjB33ozhrgegr5iMNn+bz8hoRb9T9aZUiq/QhVE1aV/7waj6U6dbT8o9acHmyc0
	CNXaTrkaxN7E4lssJBnxO4VwZHn8B/g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788165947;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NVL0jKar0wFcPGh28iGxpqNGOuuFwpDnmGmtJ+sefXc=;
	b=A4e5MteI4hGefwdWMhHgfB0X/St9WAqaUrtTGKEfGzQZ3LrFdKSs/wxhDFvTQFe/ixe/53
	hafcEjNZGqoVVRCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AD89136D1;
	Mon, 31 Aug 2026 08:45:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AqTkITs/lWp7JwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 31 Aug 2026 08:45:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 24074A13B5; Mon, 31 Aug 2026 10:45:47 +0200 (CEST)
Date: Mon, 31 Aug 2026 10:45:47 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/6] buffer: Document sb_bread(), sb_bread_unmovable()
 and sb_breadahead()
Message-ID: <rgyvuw2vgdisaps72e2q43dprhbwa6alwdrpjjmku2cur3rqp2@s5g7grxji44w>
References: <20260828205429.3678204-1-willy@infradead.org>
 <20260828205429.3678204-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828205429.3678204-4-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9E521FB50
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Fri 28-08-26 21:54:23, Matthew Wilcox (Oracle) wrote:
> Add kernel-doc for these three functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Just one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>


> -static inline struct buffer_head *
> -sb_bread(struct super_block *sb, sector_t block)
> +/**
> + * sb_bread - Read a block.
> + * @sb: The superblock to read from.
> + * @block: Block number in units of block size.
> + *
> + * Read a specified block, and return the buffer head that refers
> + * to it.  The memory is allocated from the movable area so that it can
> + * be migrated.  The returned buffer head has its refcount increased.
> + * The caller should call brelse() when it has finished with the buffer.
> + *
> + * Context: May sleep waiting for I/O.
> + * Return: NULL if the block was unreadable.
> + */
> +static inline
> +struct buffer_head *sb_bread(struct super_block *sb, sector_t block)
>  {
>  	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, __GFP_MOVABLE);
>  }
>  
> -static inline struct buffer_head *
> -sb_bread_unmovable(struct super_block *sb, sector_t block)
> +/**
> + * sb_bread_unmovable - Read a block.
> + * @sb: The superblock to read from.
> + * @block: Block number in units of block size.
> + *
> + * Read a specified block, and return the buffer head that refers to it.
> + * The memory is allocated from the unmovable area so that pointers into
> + * it remain valid after compaction runs.  The returned buffer head has
> + * its refcount increased.  The caller should call brelse() when it has
> + * finished with the buffer.
> + *
> + * Context: May sleep waiting for I/O.
> + * Return: NULL if the block was unreadable.
> + */
> +static inline
> +struct buffer_head *sb_bread_unmovable(struct super_block *sb, sector_t block)
>  {
>  	return __bread_gfp(sb->s_bdev, block, sb->s_blocksize, 0);
>  }

The reason for distinguishing movable / unmovable allocation isn't as much
about the address staying stable for the filesystem (although that's also
one of the effects). It is more about the filesystem using _unmovable
allocations for bhs which are expected to be pinned (by references - cf
buffer_migrate_folio_norefs() used for bdev mappings) most/all of the time
and so allocating them from movable zone causes issues to compaction and
CMA in particular. I think the documentation of these functions should
mention this distinction.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
