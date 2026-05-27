Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6343EF646
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875087; cv=none; b=KAyJx1q+9oBR8hW7LbNhI5pHkAahGxa6f35nlo2ftH8M/k6Lte+yo/byDNgr2B0/dzv0bhIB0fNayCh2Svy0z538SenJvBowrOXKUQX0y1hcWnz3BDnjl9O6fURSC7LGhQfhavPJa3nsbXy48iKwkT06n5ogRqDOFKphQolqVQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875087; c=relaxed/simple;
	bh=s+zmfNN1mLcqCnes5oy3QrHOpCEfHN4Miu92hpwRP/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWfGFp8kAFvV/Wj2LLOkZ01wN08585kOBgnj/pQzdoy65aQWnPbkrS72qLqQvuGLXzwN7xtwds//DZyhc7/VEFGh99pmmjre1GlOlZ/eq9lc4Cml7sKE0vWYG+oJZXFAZ75Gtw8gR31gJZuKkFZktWT5WDGh/w8/lo5V5eJqRY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNPdb/07; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l8HurocX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bNPdb/07; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=l8HurocX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNPdb/07";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l8HurocX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bNPdb/07";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="l8HurocX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8773266DA9;
	Wed, 27 May 2026 09:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruMQysXg9OhDA5n+jfrhfOrGL6DmjO47XkgJRIuUdR8=;
	b=bNPdb/07Ki/jbqLtUxe7M7avVBha6NJyRZBO7OOj0/bMUjqiz/4i9tvAis0WZfSrKKtS4s
	3shRT+e7sNu15moZIOOpZZhLyvoD6a2URkBvII47wZ6g9FQkDGvWWX8m5K3eNUWIIWV+Za
	zDWassR9aKwgMPCxJ0V6Ix6gZ/sodCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruMQysXg9OhDA5n+jfrhfOrGL6DmjO47XkgJRIuUdR8=;
	b=l8HurocXX2hPmnHQ+FP2ZOEdY3eLHsNnnT/syLDwDvYo93qprx3VHkzeC2bZtgvME5kuxL
	JG7uWB70yVBSsBAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruMQysXg9OhDA5n+jfrhfOrGL6DmjO47XkgJRIuUdR8=;
	b=bNPdb/07Ki/jbqLtUxe7M7avVBha6NJyRZBO7OOj0/bMUjqiz/4i9tvAis0WZfSrKKtS4s
	3shRT+e7sNu15moZIOOpZZhLyvoD6a2URkBvII47wZ6g9FQkDGvWWX8m5K3eNUWIIWV+Za
	zDWassR9aKwgMPCxJ0V6Ix6gZ/sodCQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ruMQysXg9OhDA5n+jfrhfOrGL6DmjO47XkgJRIuUdR8=;
	b=l8HurocXX2hPmnHQ+FP2ZOEdY3eLHsNnnT/syLDwDvYo93qprx3VHkzeC2bZtgvME5kuxL
	JG7uWB70yVBSsBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA7A5A77B;
	Wed, 27 May 2026 09:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UFizGQi9FmqrPwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 09:44:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14EF7A0EB5; Wed, 27 May 2026 11:44:40 +0200 (CEST)
Date: Wed, 27 May 2026 11:44:40 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 01/34] buffer: Remove forward declaration of
 submit_bh_wbc()
Message-ID: <nuxvajatv734z3c2xqv4gmxq75uobzg7xfpg4pks2iwgqaja7f@ti6quoqwe3ze>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-2-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-2-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,infradead.org:email]

On Mon 25-05-26 18:18:54, Matthew Wilcox (Oracle) wrote:
> Rearrange functions to avoid this forward declaration.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 150 +++++++++++++++++++++++++---------------------------
>  1 file changed, 73 insertions(+), 77 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index b0b3792b1496..d4e9a10d2a26 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -54,9 +54,6 @@
>  
>  #include "internal.h"
>  
> -static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -			  enum rw_hint hint, struct writeback_control *wbc);
> -
>  #define BH_ENTRY(list) list_entry((list), struct buffer_head, b_assoc_buffers)
>  
>  inline void touch_buffer(struct buffer_head *bh)
> @@ -1157,6 +1154,79 @@ void __bforget(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(__bforget);
>  
> +static void end_bio_bh_io_sync(struct bio *bio)
> +{
> +	struct buffer_head *bh = bio->bi_private;
> +
> +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> +		set_bit(BH_Quiet, &bh->b_state);
> +
> +	bh->b_end_io(bh, !bio->bi_status);
> +	bio_put(bio);
> +}
> +
> +static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
> +				  gfp_t gfp_mask)
> +{
> +	const struct address_space *mapping = folio_mapping(bh->b_folio);
> +
> +	/*
> +	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
> +	 * for a non-pagecache page.  fscrypt doesn't care about these.
> +	 */
> +	if (!mapping)
> +		return;
> +	fscrypt_set_bio_crypt_ctx(bio, mapping->host,
> +			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
> +}
> +
> +static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> +		enum rw_hint write_hint, struct writeback_control *wbc)
> +{
> +	const enum req_op op = opf & REQ_OP_MASK;
> +	struct bio *bio;
> +
> +	BUG_ON(!buffer_locked(bh));
> +	BUG_ON(!buffer_mapped(bh));
> +	BUG_ON(!bh->b_end_io);
> +	BUG_ON(buffer_delay(bh));
> +	BUG_ON(buffer_unwritten(bh));
> +
> +	/*
> +	 * Only clear out a write error when rewriting
> +	 */
> +	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
> +		clear_buffer_write_io_error(bh);
> +
> +	if (buffer_meta(bh))
> +		opf |= REQ_META;
> +	if (buffer_prio(bh))
> +		opf |= REQ_PRIO;
> +
> +	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
> +
> +	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> +		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
> +
> +	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> +	bio->bi_write_hint = write_hint;
> +
> +	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
> +
> +	bio->bi_end_io = end_bio_bh_io_sync;
> +	bio->bi_private = bh;
> +
> +	/* Take care of bh's that straddle the end of the device */
> +	guard_bio_eod(bio);
> +
> +	if (wbc) {
> +		wbc_init_bio(wbc, bio);
> +		wbc_account_cgroup_owner(wbc, bh->b_folio, bh->b_size);
> +	}
> +
> +	blk_crypto_submit_bio(bio);
> +}
> +
>  static struct buffer_head *__bread_slow(struct buffer_head *bh)
>  {
>  	lock_buffer(bh);
> @@ -2663,80 +2733,6 @@ sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
>  }
>  EXPORT_SYMBOL(generic_block_bmap);
>  
> -static void end_bio_bh_io_sync(struct bio *bio)
> -{
> -	struct buffer_head *bh = bio->bi_private;
> -
> -	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> -		set_bit(BH_Quiet, &bh->b_state);
> -
> -	bh->b_end_io(bh, !bio->bi_status);
> -	bio_put(bio);
> -}
> -
> -static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
> -				  gfp_t gfp_mask)
> -{
> -	const struct address_space *mapping = folio_mapping(bh->b_folio);
> -
> -	/*
> -	 * The ext4 journal (jbd2) can submit a buffer_head it directly created
> -	 * for a non-pagecache page.  fscrypt doesn't care about these.
> -	 */
> -	if (!mapping)
> -		return;
> -	fscrypt_set_bio_crypt_ctx(bio, mapping->host,
> -			folio_pos(bh->b_folio) + bh_offset(bh), gfp_mask);
> -}
> -
> -static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -			  enum rw_hint write_hint,
> -			  struct writeback_control *wbc)
> -{
> -	const enum req_op op = opf & REQ_OP_MASK;
> -	struct bio *bio;
> -
> -	BUG_ON(!buffer_locked(bh));
> -	BUG_ON(!buffer_mapped(bh));
> -	BUG_ON(!bh->b_end_io);
> -	BUG_ON(buffer_delay(bh));
> -	BUG_ON(buffer_unwritten(bh));
> -
> -	/*
> -	 * Only clear out a write error when rewriting
> -	 */
> -	if (test_set_buffer_req(bh) && (op == REQ_OP_WRITE))
> -		clear_buffer_write_io_error(bh);
> -
> -	if (buffer_meta(bh))
> -		opf |= REQ_META;
> -	if (buffer_prio(bh))
> -		opf |= REQ_PRIO;
> -
> -	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
> -
> -	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
> -		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
> -
> -	bio->bi_iter.bi_sector = bh->b_blocknr * (bh->b_size >> 9);
> -	bio->bi_write_hint = write_hint;
> -
> -	bio_add_folio_nofail(bio, bh->b_folio, bh->b_size, bh_offset(bh));
> -
> -	bio->bi_end_io = end_bio_bh_io_sync;
> -	bio->bi_private = bh;
> -
> -	/* Take care of bh's that straddle the end of the device */
> -	guard_bio_eod(bio);
> -
> -	if (wbc) {
> -		wbc_init_bio(wbc, bio);
> -		wbc_account_cgroup_owner(wbc, bh->b_folio, bh->b_size);
> -	}
> -
> -	blk_crypto_submit_bio(bio);
> -}
> -
>  void submit_bh(blk_opf_t opf, struct buffer_head *bh)
>  {
>  	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
