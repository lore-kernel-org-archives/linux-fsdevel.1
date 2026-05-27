Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813353939B2
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 11:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779879760; cv=none; b=uR7jG6TvfdlRYVhkuPmn0tu95wNIDggwUrYvzw6jnrId4wSFLj4ynNNN489ACmTUG/r94L8Bp7A8lpRT1K8g6b85TRbs9Mv+NpRlKNFXCzs1StjHDr55NWtHbs8rY5JdaVERAuSOLJi6cfAgBTEi/jz1hFlwuEjttcqSzLYvz8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779879760; c=relaxed/simple;
	bh=Ps9vhLbyzBi5huMqCaF9kZBGp+NmKMOJvL1QVKRRPvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFR1xw4Cb8bIW9gHbJDYzckz5s9pqRaaXXWY/MfGckR8tK/69P98UCLtH9RKFuSDj/3NV61xz3pnSH7IrH1D8y5KaIvDXz89kSFdiT7hT9bQmhD4yCrpzRidEWPEvBXBAzLb/lV3oPSF2D59xOnK6WKu4laMvqTOqpbdpQgCo3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzOPTsdY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qnYlv6Ry; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZzOPTsdY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qnYlv6Ry; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzOPTsdY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qnYlv6Ry";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZzOPTsdY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qnYlv6Ry"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9FD0E6701A;
	Wed, 27 May 2026 11:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779879756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1f0NT1S0LDNkC0OQ1I5DisWCaCuyyFdWkJewNBodFdc=;
	b=ZzOPTsdYdd5diKavPd6hdcMKGURX87j6O7kAgJ52DWcA7ppjJ/RuxKO6Vk0hUnB3gW343q
	MDTyk8IG6SXMLw2sSZccTEQ2b557pw2qAKRgrBKODb2M1dOmO+qqTUus/fC0+g4aCCsRkV
	M4OA/9uHVfJtP9YOsjvzjyAD3NTFgFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779879756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1f0NT1S0LDNkC0OQ1I5DisWCaCuyyFdWkJewNBodFdc=;
	b=qnYlv6RycTHc3rrv+Zw/FSbwPpGrNvXT3ZDL6RritYlOMIPDbhllA8WXRYlLj6UxtPctS9
	VdpE5BIQnE8e4FCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779879756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1f0NT1S0LDNkC0OQ1I5DisWCaCuyyFdWkJewNBodFdc=;
	b=ZzOPTsdYdd5diKavPd6hdcMKGURX87j6O7kAgJ52DWcA7ppjJ/RuxKO6Vk0hUnB3gW343q
	MDTyk8IG6SXMLw2sSZccTEQ2b557pw2qAKRgrBKODb2M1dOmO+qqTUus/fC0+g4aCCsRkV
	M4OA/9uHVfJtP9YOsjvzjyAD3NTFgFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779879756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1f0NT1S0LDNkC0OQ1I5DisWCaCuyyFdWkJewNBodFdc=;
	b=qnYlv6RycTHc3rrv+Zw/FSbwPpGrNvXT3ZDL6RritYlOMIPDbhllA8WXRYlLj6UxtPctS9
	VdpE5BIQnE8e4FCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81C405A7C9;
	Wed, 27 May 2026 11:02:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id l8k9H0zPFmoLEAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 11:02:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 23B70A0EB5; Wed, 27 May 2026 13:02:36 +0200 (CEST)
Date: Wed, 27 May 2026 13:02:36 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <zkgzhy6i5tfkxxijrusi36tu6uxibwfh5vcbmo4f3tzsnbo4qf@vsz5ep3lcxpr>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-5-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-5-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email]

On Mon 25-05-26 18:18:57, Matthew Wilcox (Oracle) wrote:
> These are the bio versions of end_buffer_read_sync(),
> end_buffer_write_sync() and end_buffer_async_write().
> Also add the helper function bio_endio_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

One more suggestion for further cleanup that actually would make sense as
part of this series: end_buffer_read_sync() and end_buffer_write_sync()
drop bh reference which is acquired before submit_bh(). Holding this bh
reference is a remnant from the old times where buffer lock bitlock was not
a safe primitive to use to protect a structure from freeing. These days
bitlocks are implemented in a way that they don't touch the lock after
unlocking and so they are safe to be used to protect against freeing. So
when touching all the places using end_buffer_read_sync() and
end_buffer_write_sync() anyway, it would be nice to clean this up and
remove these pointless refcount manipulations.

								Honza

> ---
>  fs/buffer.c                 | 77 ++++++++++++++++++++++++++++++++++---
>  include/linux/buffer_head.h |  6 +++
>  2 files changed, 77 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 4dcce64ef006..84ba0d892267 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -129,6 +129,29 @@ static void buffer_io_error(struct buffer_head *bh, char *msg)
>  			bh->b_bdev, (unsigned long long)bh->b_blocknr, msg);
>  }
>  
> +/**
> + * bio_endio_bh - Return the bh for a bio
> + * @bio: The bio
> + *
> + * Call this in your bio_end_io handler to retrieve the buffer_head
> + * submitted in bh_submit().  If you did not call bh_submit(), do not
> + * call this function; it will return garbage.
> + *
> + * This function consumes the bio refcount which will probably free the
> + * bio.  You should retrieve the bi_status before calling this.
> + */
> +struct buffer_head *bio_endio_bh(struct bio *bio)
> +{
> +	struct buffer_head *bh = bio->bi_private;
> +
> +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> +		set_bit(BH_Quiet, &bh->b_state);
> +	bio_put(bio);
> +
> +	return bh;
> +}
> +EXPORT_SYMBOL(bio_endio_bh);
> +
>  /*
>   * End-of-IO handler helper function which does not touch the bh after
>   * unlocking it.
> @@ -159,6 +182,21 @@ void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  }
>  EXPORT_SYMBOL(end_buffer_read_sync);
>  
> +/**
> + * bh_end_read - I/O end handler for reads
> + * @bio: The bio being completed.
> + *
> + * Pass this function to bh_submit() if you're reading to the buffer,
> + * unless you need your own special I/O end handler.
> + */
> +void bh_end_read(struct bio *bio)
> +{
> +	bool uptodate = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
> +	end_buffer_read_sync(bh, uptodate);
> +}
> +EXPORT_SYMBOL(bh_end_read);
> +
>  void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
>  {
>  	if (uptodate) {
> @@ -173,6 +211,21 @@ void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
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
> +	bool success = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
> +	end_buffer_write_sync(bh, success);
> +}
> +EXPORT_SYMBOL(bh_end_write);
> +
>  static struct buffer_head *
>  __find_get_block_slow(struct block_device *bdev, sector_t block, bool atomic)
>  {
> @@ -416,6 +469,21 @@ static void end_buffer_async_write(struct buffer_head *bh, int uptodate)
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
> +	bool success = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
> +	end_buffer_async_write(bh, success);
> +}
> +EXPORT_SYMBOL(bh_end_async_write);
> +
>  /*
>   * If a page's buffers are under async readin (end_buffer_async_read
>   * completion) then there is a possibility that another thread of
> @@ -1150,13 +1218,10 @@ EXPORT_SYMBOL(__bforget);
>  
>  static void end_bio_bh_io_sync(struct bio *bio)
>  {
> -	struct buffer_head *bh = bio->bi_private;
> +	bool uptodate = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
>  
> -	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> -		set_bit(BH_Quiet, &bh->b_state);
> -
> -	bh->b_end_io(bh, !bio->bi_status);
> -	bio_put(bio);
> +	bh->b_end_io(bh, uptodate);
>  }
>  
>  static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index d59980e4adda..e1594d30639b 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -204,6 +204,12 @@ struct buffer_head *create_empty_buffers(struct folio *folio,
>  		unsigned long blocksize, unsigned long b_state);
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
>  void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
> +struct buffer_head *bio_endio_bh(struct bio *bio);
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
