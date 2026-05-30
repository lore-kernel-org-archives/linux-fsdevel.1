Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03F139E16C
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142896; cv=none; b=gN5HbtyGpZgoq7vihhlkdvsMQt3rgyEpRrmiplRBzX6xfxEkwSwei7EoWNGqrgdaxWNu31ATuInBVWHBlc/x1U6KLZyZfYe6+BavB3BUOI5fbA5WLF19THWKuDcb24avU3hz3nW12HXzMjKEc7KE1m5Pv0+ZBDgu2/a54LVwJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142896; c=relaxed/simple;
	bh=R81zvfZ2PzY8u1pcsnOLLHZrzoIYh5ZnE8webUpgbmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pE+LmZHzvFT0PN1VhUXUOFMzLtEBMYuOTvB5JXNbpl3todnrfzGnjXh0j6c6UowPpS5Co0AzFYaSkp57Mru5ypBH3j1Ljdb08I5ccjOJwSorvWUfLo2KKiyXIlXhx25QI34lmYz4vrVIm6dIU5sbKubKGn5v0lQKWHSC0aJvPsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WXMn0woM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3IyU9GbH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BTdbKEXa; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=s1osNX58; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WXMn0woM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3IyU9GbH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BTdbKEXa";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="s1osNX58"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 984ED6B913;
	Sat, 30 May 2026 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142894; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGKx/ei+DdmfduRFWoeI/YXX55aYhomu29XHgyPiIfA=;
	b=WXMn0woMkqq5T9pCab49kd3+lgbJZFNfBpyYctEUPHbBUzZvTdBbk5CcNGxaUWFdbuCii2
	jNuS2bAfONoKQczu1RpdgqjNd/11nz14y+WA4zCSNc8+zlGQMvkuLbW/9DzfXOaQoQPT8d
	qtY1GwpH/lrXqvC1gTdsY4+tFaNiyoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142894;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGKx/ei+DdmfduRFWoeI/YXX55aYhomu29XHgyPiIfA=;
	b=3IyU9GbHxFgWEYiMaHRnduv6dfdSbDzPTQpQ5Qh9RD6wn3R2ab0rznLidihb0Hnk5QsOki
	D4jGYOFpqejuv3CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142892; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGKx/ei+DdmfduRFWoeI/YXX55aYhomu29XHgyPiIfA=;
	b=BTdbKEXaDrD3T4zWZa+lD6gCmddC5ABMEYf9K5m1HY7PeAEjopyy5yCxrxKXW/2POHMaCH
	Kajvv4j1kl6u6YS3PnaUnRAht7VgJJTqJa6YuqCMuaP6M8wI9aj6daYLzYDvhkVguUHDy6
	cNW1EnqDQihdweLRSQp0joDgxUCOXCg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142892;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aGKx/ei+DdmfduRFWoeI/YXX55aYhomu29XHgyPiIfA=;
	b=s1osNX58QebWBEc+ZTq3IolJdM9hTl83KuVlx66sjtcpL91QkS+pqfecRpR8VbvFCc+8mL
	n5QUCTeSJLNhwGAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E722779A7;
	Sat, 30 May 2026 12:08:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id en3EIizTGmoIVQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 12:08:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 481F1A0EBD; Sat, 30 May 2026 14:08:12 +0200 (CEST)
Date: Sat, 30 May 2026 14:08:12 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 34/34] buffer: Remove end_buffer_write_sync()
Message-ID: <5izoojrw5jcy2bz5sbbfmszjfv47ln7byz4n2fhysayuwmrv3o@zpglgviuo52o>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-35-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-35-willy@infradead.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]

On Thu 28-05-26 18:31:47, Matthew Wilcox (Oracle) wrote:
> It has no callers left, so delete it.  Inline __end_buffer_write_sync()
> into bh_end_write().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Yay. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c                 | 29 +++++++++--------------------
>  include/linux/buffer_head.h |  1 -
>  2 files changed, 9 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index db604c0e54d4..7ed8dd77d221 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -192,25 +192,6 @@ void bh_end_read(struct bio *bio)
>  }
>  EXPORT_SYMBOL(bh_end_read);
>  
> -static void __end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> -{
> -	if (uptodate) {
> -		set_buffer_uptodate(bh);
> -	} else {
> -		buffer_io_error(bh, ", lost sync page write");
> -		mark_buffer_write_io_error(bh);
> -		clear_buffer_uptodate(bh);
> -	}
> -	unlock_buffer(bh);
> -}
> -
> -void end_buffer_write_sync(struct buffer_head *bh, int uptodate)
> -{
> -	__end_buffer_write_sync(bh, uptodate);
> -	put_bh(bh);
> -}
> -EXPORT_SYMBOL(end_buffer_write_sync);
> -
>  /**
>   * bh_end_write - I/O end handler for writes
>   * @bio: The bio being completed.
> @@ -222,7 +203,15 @@ void bh_end_write(struct bio *bio)
>  {
>  	struct buffer_head *bh;
>  	bool success = bio_endio_bh(bio, &bh);
> -	__end_buffer_write_sync(bh, success);
> +
> +	if (success) {
> +		set_buffer_uptodate(bh);
> +	} else {
> +		buffer_io_error(bh, ", lost sync page write");
> +		mark_buffer_write_io_error(bh);
> +		clear_buffer_uptodate(bh);
> +	}
> +	unlock_buffer(bh);
>  }
>  EXPORT_SYMBOL(bh_end_write);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 1ee56c9f2327..8b23bc9a244c 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -201,7 +201,6 @@ struct buffer_head *alloc_page_buffers(struct page *page, unsigned long size);
>  struct buffer_head *create_empty_buffers(struct folio *folio,
>  		unsigned long blocksize, unsigned long b_state);
>  void end_buffer_read_sync(struct buffer_head *bh, int uptodate);
> -void end_buffer_write_sync(struct buffer_head *bh, int uptodate);
>  bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp);
>  
>  /* Completion routines suitable for passing to bh_submit() */
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
