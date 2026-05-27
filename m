Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B135F19B
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875287; cv=none; b=m2NaqVx6kMobeXG4HKz/j2cxorNyjG3nGB2y880vxHu3ystbWzLiCV8EjO3EZeY/ZD8bEZmUg7Mx3j8dtbDJj0rhWg54itxl+TTRV33xf7UaxqRDvkNphQjKp3JIIfmgsyZXaKjNjYxFMp6uxzO72q7vAzCIGHO+OFzpL2LuTmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875287; c=relaxed/simple;
	bh=Lqlv2Edmru4GhBoo31Ln5bt3BlOTJHjrJ7TMHkrdSOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkx1Cwe8L/3Pds0VYYEUllQoGZPfN4bm5n+vucrK4zXFo2hcuTOrzOEDJmvWkpXzMuIgMOcuKrMcqJDYgAAImwLnRmXz3c33Yx2L9MuOLKDEWenfoB7nbLV0L+UDXBs4snS6Gl5QQlBh8ap9SMuzIw9h4iN2Ap4Fhw84vUnHXDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=pzr5rgcD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=J+PLNE7N; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PIIMQK6Y; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kojvnz0/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="pzr5rgcD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="J+PLNE7N";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PIIMQK6Y";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kojvnz0/"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E56D567064;
	Wed, 27 May 2026 09:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875284; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwe6O6RXMS+9WJqRNE+5MWkuZDWiEgNs94SyoHMGGU=;
	b=pzr5rgcDfTU1My/lSIbR5zID6bhXD4p4nTqmIAdlVYibKpc/P9d2/9E7GqilukyyWi9h0I
	NAJEyIghivGx6lSjn9FQB1SX049vwiYXjElFYXTEioAj+8VT/1Qo9liswfmP2a1Cbx3wGo
	Nw33pP5D3b3DQ2QE8jzOEzISJcNGPKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875284;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwe6O6RXMS+9WJqRNE+5MWkuZDWiEgNs94SyoHMGGU=;
	b=J+PLNE7N4kkjsuSLq8ehyLgbXoki61KKU4MjBO7uX4/zIlpPYy6fFVLKWqRTSs+C/4Lq6I
	q0g42olcyeEcp6BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779875283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwe6O6RXMS+9WJqRNE+5MWkuZDWiEgNs94SyoHMGGU=;
	b=PIIMQK6YtDmVPBd6FtEMTmRtO/EpFtpHRkRSS4orQmvKphu5XClX9saMyE2EUmRm8ADxik
	Zu+uZHMuSHLkeeUDonVyXipcO9CypFNRG7fA4DIGJlTD0w+957T4ucz5JfbdXosxGPLTXU
	//EJAS9ndNHUT6pNhYCyPWzxu4J3VTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779875283;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFwe6O6RXMS+9WJqRNE+5MWkuZDWiEgNs94SyoHMGGU=;
	b=Kojvnz0/W3soAyeBIaNAIe66IYTA326WRHcRrr7Uh5C8fhP/s1OeUPYt1IiGsaJtuLa3LR
	xzLcUyIOMiPPguAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DCE2C5A77F;
	Wed, 27 May 2026 09:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Em7rNdO9Fmp3QwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 09:48:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8D784A0EB5; Wed, 27 May 2026 11:48:03 +0200 (CEST)
Date: Wed, 27 May 2026 11:48:03 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 03/34] buffer: Remove mark_buffer_async_write_endio()
Message-ID: <isskqvbqtgegjarkfbtcrho4mkdeavx5gmdltxj4ggaieycybi@qmiqzgctwmnp>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-4-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 25-05-26 18:18:56, Matthew Wilcox (Oracle) wrote:
> All callers of mark_buffer_async_write_endio() pass
> end_buffer_async_write, so we can inline mark_buffer_async_write_endio()
> into mark_buffer_async_write() and just call that instead.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ea926963529e..4dcce64ef006 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -443,16 +443,10 @@ static void mark_buffer_async_read(struct buffer_head *bh)
>  	set_buffer_async_read(bh);
>  }
>  
> -static void mark_buffer_async_write_endio(struct buffer_head *bh,
> -					  bh_end_io_t *handler)
> -{
> -	bh->b_end_io = handler;
> -	set_buffer_async_write(bh);
> -}
> -
>  void mark_buffer_async_write(struct buffer_head *bh)
>  {
> -	mark_buffer_async_write_endio(bh, end_buffer_async_write);
> +	bh->b_end_io = end_buffer_async_write;
> +	set_buffer_async_write(bh);
>  }
>  EXPORT_SYMBOL(mark_buffer_async_write);
>  
> @@ -1903,8 +1897,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  			continue;
>  		}
>  		if (test_clear_buffer_dirty(bh)) {
> -			mark_buffer_async_write_endio(bh,
> -				end_buffer_async_write);
> +			mark_buffer_async_write(bh);
>  		} else {
>  			unlock_buffer(bh);
>  		}
> @@ -1958,8 +1951,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  		if (buffer_mapped(bh) && buffer_dirty(bh) &&
>  		    !buffer_delay(bh)) {
>  			lock_buffer(bh);
> -			mark_buffer_async_write_endio(bh,
> -				end_buffer_async_write);
> +			mark_buffer_async_write(bh);
>  		} else {
>  			/*
>  			 * The buffer may have been set dirty during
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
