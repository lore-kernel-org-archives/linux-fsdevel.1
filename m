Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16123AB269
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142372; cv=none; b=WLOoKBJEPrcXLzB8vggIPNDQd5OO0mQYJHOgLLa00hHlY9H6fhW/e/y01EjBiPIjxLfddMIcd5BRuFSvuHEpbIBU/FDqI5E7RLZXAG5dU6Q2GFr87Bv2qjx3IzBF29D947263Yd96164FT26ahCFZKrU2jGq7jlVTcci/50Yqzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142372; c=relaxed/simple;
	bh=1jMqW6OWcfwkn63tccJ2LEsBb+AhGYT6lqaAY1QvPuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Augw+VrHEZ6Ae6qWF5tUfMzDWSKTW3mZQnkcetjCv1jbO/gABsAgHJshehNDdNkTLVfnyIlyQCDw9Bf09grC0vPoDBCPYEJ4X5SSJP7eoD+MOvp9cC4hTcrmOLl3VOzyMAAtxMftWirj6LbIUMPGfZcSO3S1mzUt4VXEtz+79NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cjOBXAGS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKY7aTCs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cjOBXAGS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zKY7aTCs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cjOBXAGS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKY7aTCs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cjOBXAGS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zKY7aTCs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5734067BBB;
	Sat, 30 May 2026 11:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc3LRpGQbepoMCoptJJrAeG3cBSnHvk5zXQNBD/0J7U=;
	b=cjOBXAGSVUp83idhc0LHNq1eHtAsROaobge7X8CmTpmb8kEI+PuQ3xBTjiyObE7Q7vgkXo
	hTU9pjVfkpP7eX1G1fOB8H9jo83JVbbpos9LXgQfq0fOduxkn17G2OgNKYl6uxp/URWuOK
	JngEX73412GLj5zinrTPpdqk3XmraZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc3LRpGQbepoMCoptJJrAeG3cBSnHvk5zXQNBD/0J7U=;
	b=zKY7aTCs9+EdXDgYhfz5HH8XzFICiJMB1pAU9ZS9EqPb0vRzP0zutpAZTT5naLJHCo/NAa
	PKBn/CyONhN37pCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc3LRpGQbepoMCoptJJrAeG3cBSnHvk5zXQNBD/0J7U=;
	b=cjOBXAGSVUp83idhc0LHNq1eHtAsROaobge7X8CmTpmb8kEI+PuQ3xBTjiyObE7Q7vgkXo
	hTU9pjVfkpP7eX1G1fOB8H9jo83JVbbpos9LXgQfq0fOduxkn17G2OgNKYl6uxp/URWuOK
	JngEX73412GLj5zinrTPpdqk3XmraZo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pc3LRpGQbepoMCoptJJrAeG3cBSnHvk5zXQNBD/0J7U=;
	b=zKY7aTCs9+EdXDgYhfz5HH8XzFICiJMB1pAU9ZS9EqPb0vRzP0zutpAZTT5naLJHCo/NAa
	PKBn/CyONhN37pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4117C779A7;
	Sat, 30 May 2026 11:59:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id erDhDyHRGmquTAAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:59:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF576A0EBD; Sat, 30 May 2026 13:59:20 +0200 (CEST)
Date: Sat, 30 May 2026 13:59:20 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 31/34] buffer: Remove submit_bh()
Message-ID: <nql2zn2tr5zbvsd7y23exxte6shx6ho33wz4uhrrkfhwiibvw5@rr3fgrfggigj>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-32-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-32-willy@infradead.org>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]

On Thu 28-05-26 18:31:44, Matthew Wilcox (Oracle) wrote:
> No users are left; remove this API.  Also remove/fix comments mentioning
> it, and end_bio_bh_io_sync() as it's now unused.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/trace/ftrace.rst |  4 ++--
>  fs/buffer.c                    | 27 ++++++---------------------
>  include/linux/buffer_head.h    |  3 +--
>  mm/vmscan.c                    |  2 +-
>  4 files changed, 10 insertions(+), 26 deletions(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index b9efb148a5c2..2ed1b96e440b 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -1624,7 +1624,7 @@ function-trace, we get a much larger output::
>     => blk_queue_bio
>     => submit_bio_noacct
>     => submit_bio
> -   => submit_bh
> +   => bh_submit
>     => __ext3_get_inode_loc
>     => ext3_iget
>     => ext3_lookup
> @@ -1909,7 +1909,7 @@ tracers.
>     => blk_queue_bio
>     => submit_bio_noacct
>     => submit_bio
> -   => submit_bh
> +   => bh_submit
>     => ext3_bread
>     => ext3_dir_bread
>     => htree_dirblock_to_tree
> diff --git a/fs/buffer.c b/fs/buffer.c
> index d35f584a06f9..3df0ea1a6342 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1187,14 +1187,6 @@ void __bforget(struct buffer_head *bh)
>  }
>  EXPORT_SYMBOL(__bforget);
>  
> -static void end_bio_bh_io_sync(struct bio *bio)
> -{
> -	struct buffer_head *bh;
> -	bool uptodate = bio_endio_bh(bio, &bh);
> -
> -	bh->b_end_io(bh, uptodate);
> -}
> -
>  static void buffer_set_crypto_ctx(struct bio *bio, const struct buffer_head *bh,
>  				  gfp_t gfp_mask)
>  {
> @@ -1829,15 +1821,15 @@ static struct buffer_head *folio_create_buffers(struct folio *folio,
>  
>  /*
>   * While block_write_full_folio is writing back the dirty buffers under
> - * the page lock, whoever dirtied the buffers may decide to clean them
> + * the folio lock, whoever dirtied the buffers may decide to clean them
>   * again at any time.  We handle that by only looking at the buffer
>   * state inside lock_buffer().
>   *
>   * If block_write_full_folio() is called for regular writeback
> - * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a page which has a
> - * locked buffer.   This only can happen if someone has written the buffer
> - * directly, with submit_bh().  At the address_space level PageWriteback
> - * prevents this contention from occurring.
> + * (wbc->sync_mode == WB_SYNC_NONE) then it will redirty a folio which
> + * has a locked buffer.   This only can happen if someone has written
> + * the buffer directly, with bh_submit().  At the address_space level
> + * the folio writeback flag prevents this contention from occurring.
>   *
>   * If block_write_full_folio() is called with wbc->sync_mode ==
>   * WB_SYNC_ALL, the writes are posted using REQ_SYNC; this
> @@ -1954,7 +1946,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  		/*
>  		 * The folio was marked dirty, but the buffers were
>  		 * clean.  Someone wrote them back by hand with
> -		 * write_dirty_buffer/submit_bh.  A rare case.
> +		 * write_dirty_buffer/bh_submit.  A rare case.
>  		 */
>  		folio_end_writeback(folio);
>  
> @@ -2800,13 +2792,6 @@ sector_t generic_block_bmap(struct address_space *mapping, sector_t block,
>  }
>  EXPORT_SYMBOL(generic_block_bmap);
>  
> -void submit_bh(blk_opf_t opf, struct buffer_head *bh)
> -{
> -	BUG_ON(!bh->b_end_io);
> -	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_bio_bh_io_sync);
> -}
> -EXPORT_SYMBOL(submit_bh);
> -
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags)
>  {
>  	lock_buffer(bh);
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index f0a9f3f05ac1..7629130d42c4 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -55,7 +55,7 @@ typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
>   * is the bio, and buffer_heads are used for extracting block
>   * mappings (via a get_block_t call), for tracking state within
>   * a folio (via a folio_mapping) and for wrapping bio submission
> - * for backward compatibility reasons (e.g. submit_bh).
> + * for backward compatibility reasons (e.g. bh_submit).
>   */
>  struct buffer_head {
>  	unsigned long b_state;		/* buffer state bitmap (see above) */
> @@ -244,7 +244,6 @@ void __lock_buffer(struct buffer_head *bh);
>  int sync_dirty_buffer(struct buffer_head *bh);
>  int __sync_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
>  void write_dirty_buffer(struct buffer_head *bh, blk_opf_t op_flags);
> -void submit_bh(blk_opf_t, struct buffer_head *);
>  void bh_submit(struct buffer_head *, blk_opf_t, bio_end_io_t);
>  void write_boundary_block(struct block_device *bdev,
>  			sector_t bblock, unsigned blocksize);
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index bd1b1aa12581..67231d3189ef 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1449,7 +1449,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  		 * is possible for a folio to have the dirty flag set,
>  		 * but it is actually clean (all its buffers are clean).
>  		 * This happens if the buffers were written out directly,
> -		 * with submit_bh(). ext3 will do this, as well as
> +		 * with bh_submit(). ext3 will do this, as well as
>  		 * the blockdev mapping.  filemap_release_folio() will
>  		 * discover that cleanness and will drop the buffers
>  		 * and mark the folio clean - it can be freed.
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
