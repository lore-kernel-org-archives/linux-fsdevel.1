Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5653AC0C8
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141229; cv=none; b=OmwDNdtsJ35COI7jFTcdL15wmVPw57+IMRxYZP4GVh0Z3XpNqZg2SrPM6FgX29bF6Eeijb7gQTOlEmSxml4NmTYYQW0jUtnwsi4DtVoVXi/07CEnNdTQ6T5HmAViW+Saua8uoocIPzNM5hAfjje1siyZ4mJxn1XLfqOLKZo9tEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141229; c=relaxed/simple;
	bh=vHsycQFj0tis+7SfZpBFiw43eXYWQVVS7iZ7bUYmOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBKhXitVkPc/YFM6s8uuPWqadjAsj3HNz+7dP1A7M1mfTlUp2LWrZPN++ksI+z7eip8wIEtjkNGNGJjWlufrlRPLC/TcgnPnBbwfDY2vK75oaALb60Ox8DwiNLePIQHHIaqLYbCOsuEDLSeUFWepJO0RIwYruLbuqM2wAuif9QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xUCZ2ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uURamRj3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2xUCZ2ap; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uURamRj3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xUCZ2ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uURamRj3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2xUCZ2ap";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uURamRj3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B0CD46B857;
	Sat, 30 May 2026 11:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PBW6VIxMvDjJ6qxZVWSdAZJS2lFwdzaBIt0Ewjilyo=;
	b=2xUCZ2ap0qmlnKEdcBlGZMMTtuclzZA+XSWkaIhsG81dYil7zTJBYKfwkBOsciGZjRtv+l
	9KJR+4hKFo0xmydhQL57FV5QP8bOow/h25AJRyX/c0UCPTNxM68XOLOwfUsyFDbUByd7vi
	sYmpRHGIBqTYJwflbCb2QYPIvgR0Yvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PBW6VIxMvDjJ6qxZVWSdAZJS2lFwdzaBIt0Ewjilyo=;
	b=uURamRj3lLVOJRL8LFlmv69Vnx4ca9ow/EbX5R1Ig79o1qkkOKjEC4VMGoR2D5UgKfLPOE
	stkxa7OrmcozvxCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2xUCZ2ap;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uURamRj3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141225; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PBW6VIxMvDjJ6qxZVWSdAZJS2lFwdzaBIt0Ewjilyo=;
	b=2xUCZ2ap0qmlnKEdcBlGZMMTtuclzZA+XSWkaIhsG81dYil7zTJBYKfwkBOsciGZjRtv+l
	9KJR+4hKFo0xmydhQL57FV5QP8bOow/h25AJRyX/c0UCPTNxM68XOLOwfUsyFDbUByd7vi
	sYmpRHGIBqTYJwflbCb2QYPIvgR0Yvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141225;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4PBW6VIxMvDjJ6qxZVWSdAZJS2lFwdzaBIt0Ewjilyo=;
	b=uURamRj3lLVOJRL8LFlmv69Vnx4ca9ow/EbX5R1Ig79o1qkkOKjEC4VMGoR2D5UgKfLPOE
	stkxa7OrmcozvxCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9AC59779A7;
	Sat, 30 May 2026 11:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LuTCJanMGmohOwAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:40:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 35DE9A0EBD; Sat, 30 May 2026 13:40:21 +0200 (CEST)
Date: Sat, 30 May 2026 13:40:21 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <j3l3p4svv2qf3en7ee3fy7gyw3fkix2bn5recoid4uqa3tdajc@ysiwm3tlbd3m>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-5-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B0CD46B857
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 28-05-26 18:31:17, Matthew Wilcox (Oracle) wrote:
> These are the bio_end_io_t versions of end_buffer_read_sync(),
> end_buffer_write_sync() and end_buffer_async_write().  They do not
> contain a put_bh() call as it is no longer necessary.
> 
> Also add the helper function bio_endio_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 89 ++++++++++++++++++++++++++++++++++---
>  include/linux/buffer_head.h |  6 +++
>  2 files changed, 88 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4dcce64ef006..e22a94afa385 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -129,6 +129,34 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
>  			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
>  }
>  
> +/**
> + * bio_endio_bh - Discard the bio used to submit a buffer.
> + * @bio: The bio.
> + * @bhp: Where to return the buffer_head.
> + *
> + * Call this in your bio_end_io handler to retrieve the buffer_head
> + * submitted in bh_submit().  If you did not call bh_submit(), do not
> + * call this function; it will return garbage.
> + *
> + * This function consumes the bio refcount which will probably free the
> + * bio.
> + *
> + * Return: True if the I/O succeeded.
> + */
> +bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
> +{
> +	bool success = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio->bi_private;
> +
> +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> +		set_bit(BH_Quiet, &bh->b_state);
> +	bio_put(bio);
> +
> +	*bhp = bh;
> +	return success;
> +}
> +EXPORT_SYMBOL(bio_endio_bh);
> +
>  /*
>   * End-of-IO handler helper function which does not touch the bh after
>   * unlocking it.
> @@ -159,7 +187,22 @@ void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  }
>  EXPORT_SYMBOL(end_buffer_read_sync);
>  
> -void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> +/**
> + * bh_end_read - I/O end handler for reads
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're reading into the buffer,
> + * unless you need your own special I/O end handler.
> + */
> +void bh_end_read(struct bio *bio)
> +{
> +	struct buffer_head *bh;
> +	bool uptodate = bio_endio_bh(bio, &bh);
> +	__end_buffer_read_notouch(bh, uptodate);
> +}
> +EXPORT_SYMBOL(bh_end_read);
> +
> +static void __end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  {
>  	if (uptodate) {
>  		set_buffer_uptodate(bh);
> @@ -169,10 +212,30 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  		clear_buffer_uptodate(bh);
>  	}
>  	unlock_buffer(bh);
> +}
> +
> +void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> +{
> +	__end_buffer_write_sync(bh, uptodate);
>  	put_bh(bh);
>  }
>  EXPORT_SYMBOL(end_buffer_write_sync);
>  
> +/**
> + * bh_end_write - I/O end handler for writes
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're writing from the buffer,
> + * unless you need your own special I/O end handler.
> + */
> +void bh_end_write(struct bio *bio)
> +{
> +	struct buffer_head *bh;
> +	bool success = bio_endio_bh(bio, &bh);
> +	__end_buffer_write_sync(bh, success);
> +}
> +EXPORT_SYMBOL(bh_end_write);
> +
>  static struct buffer_head *
>  __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
>  {
> @@ -416,6 +479,21 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
>  	spin_unlock_irqrestore(&first->b_uptodate_lock, flags);
>  }
>  
> +/**
> + * bh_end_async_write - I/O end handler for async folio writes
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're doing the equivalent of
> + * block_write_full_folio().
> + */
> +void bh_end_async_write(struct bio *bio)
> +{
> +	struct buffer_head *bh;
> +	bool success = bio_endio_bh(bio, &bh);
> +	end_buffer_async_write(bh, success);
> +}
> +EXPORT_SYMBOL(bh_end_async_write);
> +
>  /*
>   * If a page's buffers are under async readin (end_buffer_async_read
>   * completion) then there is a possibility that another thread of
> @@ -1150,13 +1228,10 @@ EXPORT_SYMBOL(__bforget);
>  
>  static void end_bio_bh_io_sync(struct bio *bio)
>  {
> -	struct buffer_head *bh = bio->bi_private;
> -
> -	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> -		set_bit(BH_Quiet, &bh->b_state);
> +	struct buffer_head *bh;
> +	bool uptodate = bio_endio_bh(bio, &bh);
>  
> -	bh->b_end_io(bh, !bio->bi_status);
> -	bio_put(bio);
> +	bh->b_end_io(bh, uptodate);
>  }
>  
>  static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index d59980e4adda..b0a31a90fa79 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -204,6 +204,12 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
>  		unsigned long blocksize, unsigned long b_state);
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
>  void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
> +bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp);
> +
> +/* Completion routines suitable for passing to bh_submit() */
> +void bh_end_read(struct bio *bio);
> +void bh_end_write(struct bio *bio);
> +void bh_end_async_write(struct bio *bio);
>  
>  /* Things to do with metadata buffers list */
>  void mmb_mark_buffer_dirty(struct buffer_head *bh, struct mapping_metadata_bhs *mmb);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
