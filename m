Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9908D21ABC9
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142166; cv=none; b=hui0i3m7bU57O8yhraTBiwmN3DpQsaSvrGiqJYzfQm7MSb1BJ27YMgfNcwMgnPIZQr4VHc/pQztIYS2d0DtwNIgzpc3CgeG7tTGuoSI4T4aSEaWJnbBLWS6isLMYbrXOOj85mFQjraQZ1FWESslaZEj4+TMyvPaztZmGz/iu55c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142166; c=relaxed/simple;
	bh=OqEMJ+VDBj+b2XOv5bmzitSY4277ba406zTIS8aUVo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti+ygVPHcNmbroZR+9g65ITRlNJECD95YIV2HNsg07wR1ZwqNAzrM3lACJoAhA9Q2H4VHLuRQzVIwKLJVn5gX+hk3WgEKW29jAEY+OnYoFJ/z12pDYPIFKe3OgmTRHpu67d7FjG8zSA0/ughNgUTzd6v76nMy4v/NOsOt+KRQ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LWiZNhpU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ImIDKUAR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b/7XJzdB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8A2sxr9C; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LWiZNhpU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ImIDKUAR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b/7XJzdB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8A2sxr9C"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9CCB86B8CC;
	Sat, 30 May 2026 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142163; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdB5PPIXKE0G0lXqDa95Ju+PQEVeEnl2ZxNzucle0w=;
	b=LWiZNhpUaEK/6oWD3WkgD3C9dhEYEVEJzpnSV+vGyt1tq5FyaqLI4m1LwHgCUaZDbGMxFC
	E3E49tIj+cJhNpq7Nj2uyK/2806M/8MpB9tzNFUrOnNj/C1+N8foTjThB+IFZ8wF+vCN+w
	Ne/e2XpHACw2fDgxQoeqNzc/MWwX7Bo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142163;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdB5PPIXKE0G0lXqDa95Ju+PQEVeEnl2ZxNzucle0w=;
	b=ImIDKUARBG4GO0UxcHQueZgxEl2r7x9CiR+8XiWyaYkff8okVyiyNVcb/9+JMc+sxlSA9N
	ttza+gp16lJcTUAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="b/7XJzdB";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8A2sxr9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdB5PPIXKE0G0lXqDa95Ju+PQEVeEnl2ZxNzucle0w=;
	b=b/7XJzdBd3o82mLzs3drXR4h0B8VVv0Ebx5FNFEsiS2odiDNX0kzuMtHfIHADzC5BrYSkK
	yUSScLJNecrLMJZ+3zMcheNY+bc2YhfoW+EIOHLTbnR3kaejo2h8Nl4cuF5zd9xoKt0V2/
	bF/tZZ8cFneEH6mj3MS614HhaQoTptU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142162;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=btdB5PPIXKE0G0lXqDa95Ju+PQEVeEnl2ZxNzucle0w=;
	b=8A2sxr9CBDj4IAgStEOzKHdfTszcCX+eTjlr+EBR3AniCSU3hP8NGjLjp0S4UXPkRFsPso
	UuxnePby9oAl4MDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 931B8779A7;
	Sat, 30 May 2026 11:56:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kWPnI1LQGmrLSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:56:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 32EE6A0EBD; Sat, 30 May 2026 13:55:58 +0200 (CEST)
Date: Sat, 30 May 2026 13:55:58 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 26/34] buffer: Remove mark_buffer_async_write()
Message-ID: <yovpi2h57o4yg4r7es7h4i7fpr2746wvaynsmppleqmn3taikh@pwnmbvjt74tk>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-27-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-27-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9CCB86B8CC
X-Rspamd-Action: no action
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
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 28-05-26 18:31:39, Matthew Wilcox (Oracle) wrote:
> There are no more callers of this function, so delete it.
> end_buffer_async_write() then has only one caller left, so
> inline it into bh_end_async_write().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 38 ++++++++++++-------------------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 50bcef50a4a4..d35f584a06f9 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -438,12 +438,19 @@ static void bh_end_async_read(struct bio *bio)
>  	end_buffer_async_read(bh, uptodate);
>  }
>  
> -/*
> - * Completion handler for block_write_full_folio() - folios which are unlocked
> - * during I/O, and which have the writeback flag cleared upon I/O completion.
> +/**
> + * bh_end_async_write - I/O end handler for async folio writes
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're doing the equivalent of
> + * block_write_full_folio().  That is, the folio is unlocked, and will
> + * have its writeback flag cleared once all async write buffers have
> + * completed.
>   */
> -static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
> +void bh_end_async_write(struct bio *bio)
>  {
> +	struct buffer_head *bh;
> +	bool success = bio_endio_bh(bio, &bh);
>  	unsigned long flags;
>  	struct buffer_head *first;
>  	struct buffer_head *tmp;
> @@ -452,7 +459,7 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  	BUG_ON(!buffer_async_write(bh));
>  
>  	folio = bh->b_folio;
> -	if (uptodate) {
> +	if (success) {
>  		set_buffer_uptodate(bh);
>  	} else {
>  		buffer_io_error(bh, ", lost async page write");
> @@ -480,29 +487,8 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  still_busy:
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  }
> -
> -/**
> - * bh_end_async_write - I/O end handler for async folio writes
> - * @bio: The bio being completed.
> - *
> - * Pass this function to bh_submit() if you're doing the equivalent of
> - * block_write_full_folio().
> - */
> -void bh_end_async_write(struct bio *bio)
> -{
> -	struct buffer_head *bh;
> -	bool success = bio_endio_bh(bio, &bh);
> -	end_buffer_async_write(bh, success);
> -}
>  EXPORT_SYMBOL(bh_end_async_write);
>  
> -void mark_buffer_async_write(struct buffer_head *bh)
> -{
> -	bh->b_end_io = end_buffer_async_write;
> -	set_buffer_async_write(bh);
> -}
> -EXPORT_SYMBOL(mark_buffer_async_write);
> -
>  
>  /*
>   * fs/buffer.c contains helper functions for buffer-backed address space's
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index b0a31a90fa79..f0a9f3f05ac1 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -224,7 +224,6 @@ static inline void clean_bdev_bh_alias(struct buffer_head *bh)
>  	clean_bdev_aliases(bh->b_bdev, bh->b_blocknr, 1);
>  }
>  
> -void mark_buffer_async_write(struct buffer_head *bh);
>  void __wait_on_buffer(struct buffer_head *);
>  wait_queue_head_t *bh_waitq_head(struct buffer_head *bh);
>  struct buffer_head *__find_get_block(struct block_device *bdev, sector_t block,
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
