Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C883446C0
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875216; cv=none; b=V4Ehi8jlSeZ3I8sy6RL5OxopGViNx1YbO3RktYe8FxN0VS/ymfkMgMWgF70H1BYlyWPtWSvXrJpMZoqTOQubC9Enr1osqpAkLDnIOD3dwHocQSZukHJ/P8OxMSk/+8n0SCezTTCkbm/QvVDUDSk8hlZudloD8BtmQJHbcJD2/QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875216; c=relaxed/simple;
	bh=xYsfcRBtGwUMqY0RwirVm3v6uzIJadRC/R4i9RETCOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qJ0PSD0INteg8xGvsHqPfj0HYybYmMwGll6iajyRAeKrWlgaOckORySIrn53MUe1VwkA4aVL/aN/b0ERSLDEWxpMRG+RlGRNlQXthpv3BFLzu1JR+c6PHM1RkQCB67PS7vU8iGhvu1kFwTVsAmKB8gbRbsMChzXG+/D9Wbtlszg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mr1ksssL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4bm4i2Ig; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mr1ksssL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4bm4i2Ig; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mr1ksssL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4bm4i2Ig";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mr1ksssL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4bm4i2Ig"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BF09466DA9;
	Wed, 27 May 2026 09:46:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMd7/gdXhffeZqbj7DnSodcaa0MCfMtAhljHBkKqXM=;
	b=Mr1ksssLc8mlD6pAFIjDGmRU/H2phuV8Pdz0J9q65jm+qO1LCE/OKGADVIjV1WyNmYL1IR
	tzWY4RqDjwLuMmjyQWb7va+Fa4vmWl8GzAGAnLQci03xumjftKwI3PIlxWZS7ITQA6Drv7
	8ixaIBpqdOS+z3kHPBTRfvsUVKijHD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMd7/gdXhffeZqbj7DnSodcaa0MCfMtAhljHBkKqXM=;
	b=4bm4i2IgOOf6WMk8nt9dKd+YWhjj/tmYzWLczwMOZhl+FPgfGD3J55tbP42is/W0XDzUnI
	tdnvedaAbm37KyDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Mr1ksssL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4bm4i2Ig
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875212; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMd7/gdXhffeZqbj7DnSodcaa0MCfMtAhljHBkKqXM=;
	b=Mr1ksssLc8mlD6pAFIjDGmRU/H2phuV8Pdz0J9q65jm+qO1LCE/OKGADVIjV1WyNmYL1IR
	tzWY4RqDjwLuMmjyQWb7va+Fa4vmWl8GzAGAnLQci03xumjftKwI3PIlxWZS7ITQA6Drv7
	8ixaIBpqdOS+z3kHPBTRfvsUVKijHD4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875212;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRMd7/gdXhffeZqbj7DnSodcaa0MCfMtAhljHBkKqXM=;
	b=4bm4i2IgOOf6WMk8nt9dKd+YWhjj/tmYzWLczwMOZhl+FPgfGD3J55tbP42is/W0XDzUnI
	tdnvedaAbm37KyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B600D5A77E;
	Wed, 27 May 2026 09:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id G/htLIy9FmqHQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 09:46:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6190DA0EB5; Wed, 27 May 2026 11:46:52 +0200 (CEST)
Date: Wed, 27 May 2026 11:46:52 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/34] buffer: Add bh_submit()
Message-ID: <hbtte53iavzjxvaquuiedv4pxw6kr4eh36wsh6pr5fbhrmvshc@untju6b3msyd>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-3-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BF09466DA9
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Mon 25-05-26 18:18:55, Matthew Wilcox (Oracle) wrote:
> bh_submit() takes a bio_end_io allowing users to avoid the indirect
> function call through bh->b_end_io, and eventually allowing us to remove
> bh->b_end_io.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 31 +++++++++++++++++++++++++++----
>  include/linux/buffer_head.h |  1 +
>  2 files changed, 28 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d4e9a10d2a26..ea926963529e 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1180,15 +1180,15 @@ static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
>  			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
>  }
>  
> -static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -		enum rw_hint write_hint, struct writeback_control *wbc)
> +static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
> +		enum rw_hint write_hint, struct writeback_control *wbc,
> +		bio_end_io_t end_bio)
>  {
>  	const enum req_op op = opf & REQ_OP_MASK;
>  	struct bio *bio;
>  
>  	BUG_ON(!buffer_locked(bh));
>  	BUG_ON(!buffer_mapped(bh));
> -	BUG_ON(!bh->b_end_io);
>  	BUG_ON(buffer_delay(bh));
>  	BUG_ON(buffer_unwritten(bh));
>  
> @@ -1213,7 +1213,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  
>  	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
>  
> -	bio->bi_end_io = end_bio_bh_io_sync;
> +	bio->bi_end_io = end_bio;
>  	bio->bi_private = bh;
>  
>  	/* Take care of bh's that straddle the end of the device */
> @@ -1227,6 +1227,29 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  	blk_crypto_submit_bio(bio);
>  }
>  
> +static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> +			  enum rw_hint write_hint,
> +			  struct writeback_control *wbc)
> +{
> +	BUG_ON(!bh->b_end_io);
> +	__bh_submit(bh, opf, write_hint, wbc, end_bio_bh_io_sync);
> +}
> +
> +/**
> + * bh_submit - Start I/O against a buffer head
> + * @bh: The buffer head to perform I/O on.
> + * @opf: Operation and flags for bio.
> + * @end_io: The routine to call when I/O has completed.
> + *
> + * If you need to do I/O on an individual bh (instead of allowing the
> + * page cache to do I/O on the folio that it is in), call this function.
> + */
> +void bh_submit(struct buffer_head *bh, blk_opf_t opf, bio_end_io_t end_io)
> +{
> +	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_io);
> +}
> +EXPORT_SYMBOL(bh_submit);
> +
>  static struct buffer_head *__bread_slow(struct buffer_head *bh)
>  {
>  	lock_buffer(bh);
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index e4939e33b4b5..d59980e4adda 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -240,6 +240,7 @@ int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void submit_bh(blk_opf_t, struct buffer_head *);
> +void bh_submit(struct buffer_head *, blk_opf_t, bio_end_io_t);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
>  int bh_uptodate_or_lock(struct buffer_head *bh);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
