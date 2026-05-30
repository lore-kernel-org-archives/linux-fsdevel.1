Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550E639478F
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142400; cv=none; b=i6hh+wAkDE8w5DaKzSd55SF6BWruOQk4awfgj/JAR4hYgzCu5pvwigyKt+UxfIyk3hlG9iaBB1+wTG6Xm6d0KFmjFnpfhQrLXzWWfcUiSbBCAhhk6rS2rwz2q2CDPlWhpe/nsErnz/uyYfs7/D21AwHmUcoVUmC4pjm5j8jy42A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142400; c=relaxed/simple;
	bh=g0uIJjzgfDyezKSychyydjDXmD+EIL1hSJlrVXTvA3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR2brFC8KSyz+8elJD6CIE9komUXACAjGN6b3C07VrAFk7UC90SaVfo0iFKSIIucFlqXMmSWzLyDL9sGc2RZ+Kfs46kMuf1FvxGs1uX3Hs4nd1mi8EeTym25tFZTd+2b2Jdy6/oSLg3lGLGVMrFoGCqDAy1NTQlGZrXrv1pRvZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iw1QuBO5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tk73V8PU; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iw1QuBO5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tk73V8PU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iw1QuBO5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tk73V8PU";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iw1QuBO5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tk73V8PU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9418167BBB;
	Sat, 30 May 2026 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tn63NGWlTw9ntiR+XNdvQFJdntD6xdT5+ZEyjlWwprg=;
	b=iw1QuBO5PBoqxI/StcsggV1wQ7KW0jmGiHTq90pOyfM8I/Ae2RdfGbP3C92OaBFYfNzqFP
	Vg5BTmUtBpi+F32XHqNKQhBy8onFmkdRo0/Ajz3rUNOe5mVbJaH23yz1mUtJmvDQ8oMeAz
	pZj+PNfrtbR/X8ykFIQglJfagYD5u84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tn63NGWlTw9ntiR+XNdvQFJdntD6xdT5+ZEyjlWwprg=;
	b=tk73V8PU1eY2XFI3pbfS5udpLb++aEXoyQ8jPWTy6GDvMAEUh8kcLoygE7mNM4RcaTdct0
	VjnmQnB5WqxOLaBQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iw1QuBO5;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tk73V8PU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142397; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tn63NGWlTw9ntiR+XNdvQFJdntD6xdT5+ZEyjlWwprg=;
	b=iw1QuBO5PBoqxI/StcsggV1wQ7KW0jmGiHTq90pOyfM8I/Ae2RdfGbP3C92OaBFYfNzqFP
	Vg5BTmUtBpi+F32XHqNKQhBy8onFmkdRo0/Ajz3rUNOe5mVbJaH23yz1mUtJmvDQ8oMeAz
	pZj+PNfrtbR/X8ykFIQglJfagYD5u84=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142397;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tn63NGWlTw9ntiR+XNdvQFJdntD6xdT5+ZEyjlWwprg=;
	b=tk73V8PU1eY2XFI3pbfS5udpLb++aEXoyQ8jPWTy6GDvMAEUh8kcLoygE7mNM4RcaTdct0
	VjnmQnB5WqxOLaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B433779A7;
	Sat, 30 May 2026 11:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id QMT9IT3RGmpMTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:59:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 478ACA0EBD; Sat, 30 May 2026 13:59:57 +0200 (CEST)
Date: Sat, 30 May 2026 13:59:57 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 32/34] buffer: Remove b_end_io
Message-ID: <dozckfyiu5fihs57p6vokz4o6vl65kau35vbrw2c5ra3b3kgm4@msvpe2i5vbyg>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-33-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-33-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 9418167BBB
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,infradead.org:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 28-05-26 18:31:45, Matthew Wilcox (Oracle) wrote:
> This shrinks buffer_head by 8 bytes, letting us pack more buffer heads
> per slab.  With a Debian config, it shrinks from 104 bytes to 96 bytes
> which is 42 objects per 4KiB page rather than 39, a 7% reduction in the
> amount of memory used.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/locking.rst | 14 --------------
>  drivers/md/raid5.h                    |  6 +++---
>  fs/buffer.c                           |  1 -
>  include/linux/buffer_head.h           |  4 +---
>  4 files changed, 4 insertions(+), 21 deletions(-)
> 
> diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
> index 8421ea21bd35..a27aca42fd85 100644
> --- a/Documentation/filesystems/locking.rst
> +++ b/Documentation/filesystems/locking.rst
> @@ -416,20 +416,6 @@ lm_open_conflict	yes		no			no
>  lm_breaker_timedout     yes             no                      no
>  ======================	=============	=================	=========
>  
> -buffer_head
> -===========
> -
> -prototypes::
> -
> -	void (*b_end_io)(struct buffer_head *bh, int uptodate);
> -
> -locking rules:
> -
> -called from interrupts. In other words, extreme care is needed here.
> -bh is locked, but that's all warranties we have here. Currently only RAID1,
> -highmem, fs/buffer.c, and fs/ntfs/aops.c are providing these. Block devices
> -call this method upon the IO completion.
> -
>  block_device_operations
>  =======================
>  prototypes::
> diff --git a/drivers/md/raid5.h b/drivers/md/raid5.h
> index 1c7b710fc9c1..1dfa60a41d91 100644
> --- a/drivers/md/raid5.h
> +++ b/drivers/md/raid5.h
> @@ -38,7 +38,7 @@
>   *  Clean -> Dirty  - on compute_parity to satisfy write/sync (RECONSTRUCT or RMW)
>   *
>   * The Want->Empty, Want->Clean, Dirty->Clean, transitions
> - * all happen in b_end_io at interrupt time.
> + * all happen in end_io at interrupt time.
>   * Each sets the Uptodate bit before releasing the Lock bit.
>   * This leaves one multi-stage transition:
>   *    Want->Dirty->Clean
> @@ -64,7 +64,7 @@
>   * together, but we are not guaranteed of that so we allow for more.
>   *
>   * If a buffer is on the read list when the associated cache buffer is
> - * Uptodate, the data is copied into the read buffer and it's b_end_io
> + * Uptodate, the data is copied into the read buffer and it's end_io
>   * routine is called.  This may happen in the end_request routine only
>   * if the buffer has just successfully been read.  end_request should
>   * remove the buffers from the list and then set the Uptodate bit on
> @@ -76,7 +76,7 @@
>   * into the cache buffer, which is then marked dirty, and moved onto a
>   * third list, the written list (bh_written).  Once both the parity
>   * block and the cached buffer are successfully written, any buffer on
> - * a written list can be returned with b_end_io.
> + * a written list can be returned with end_io.
>   *
>   * The write list and read list both act as fifos.  The read list,
>   * write list and written list are protected by the device_lock.
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 3df0ea1a6342..ccda92920175 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -946,7 +946,6 @@ static sector_t folio_init_buffers(struct folio *folio,
>  
>  	do {
>  		if (!buffer_mapped(bh)) {
> -			bh->b_end_io = NULL;
>  			bh->b_private = NULL;
>  			bh->b_bdev = bdev;
>  			bh->b_blocknr = block;
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 7629130d42c4..1ee56c9f2327 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -46,7 +46,6 @@ enum bh_state_bits {
>  struct page;
>  struct buffer_head;
>  struct address_space;
> -typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
>  
>  /*
>   * Historically, a buffer_head was used to map a single block
> @@ -70,8 +69,7 @@ struct buffer_head {
>  	char *b_data;			/* pointer to data within the page */
>  
>  	struct block_device *b_bdev;
> -	bh_end_io_t *b_end_io;		/* I/O completion */
> - 	void *b_private;		/* reserved for b_end_io */
> +	void *b_private;		/* reserved for bio_end_io */
>  	struct list_head b_assoc_buffers; /* associated with another mapping */
>  	struct mapping_metadata_bhs *b_mmb; /* head of the list of metadata bhs
>  					     * this buffer is associated with */
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
