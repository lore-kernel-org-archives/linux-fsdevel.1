Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3113D3D1E
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878194; cv=none; b=A7RHK1CSJgOggxvb6mNkD8vcAOF/5nReSvIldBjtS2HmQX+RGjpiGDpt2KZ0Xw2xplxonRHSfLxFcY8MGfEdshM62OqUEquRbYBG1D5Pn0GdPJs0i1zLQ6TWlK8w0JIDdNI2sJkl8EtjCr51qH7Hk5liBqdIR1JN6tUyFr6WqWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878194; c=relaxed/simple;
	bh=DAJKUxrDSQ3Hoez8U6J9gGdi9RlXP69JvE6C2Tdmh3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U0JV4rpyBB0eLVt+lcoT3VS+TxazbsuHRZgnto4PQSC2jBhneN6DHnGeLljf7bL2p5UcunoRgyVKW2fGzpSC8QF2WLDicnKolZQjNzm1PyjWIAA6FlhIutT5Blq5oXYfRAgGefeOICVUf7F19pFWnU9hDAWK3kCjCdWemZCi278=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eIOfhomj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGlw26RS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eIOfhomj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LGlw26RS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eIOfhomj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGlw26RS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eIOfhomj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LGlw26RS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7867166E27;
	Wed, 27 May 2026 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779878191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hsJ6cHgPFOpUL5QBFjvONR8o/mHsobCDDUyLaORAw=;
	b=eIOfhomjENQ2iLZWoMiyXHtZEVDgtfKUHB/rh5VAHuJ/XLgIR1xOm3+GNrvfmsmDGxvRkW
	NKmFzhnhH82l+ZK3pRlr05soSP1BTHoMYD1oveU5TaRdqy7dU+haGYRZuqfopDZXvKxk8O
	8413xXWFNdxuvcYePQAmFFUGf2eEYhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779878191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hsJ6cHgPFOpUL5QBFjvONR8o/mHsobCDDUyLaORAw=;
	b=LGlw26RSWtagu+6agpEhn8gBv4c6qiBYbmcT9RBPW5y+1hIdOCp4+GyQU5S5ScpJKYIuFY
	d/ThrPRRtLtZQUCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779878191; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hsJ6cHgPFOpUL5QBFjvONR8o/mHsobCDDUyLaORAw=;
	b=eIOfhomjENQ2iLZWoMiyXHtZEVDgtfKUHB/rh5VAHuJ/XLgIR1xOm3+GNrvfmsmDGxvRkW
	NKmFzhnhH82l+ZK3pRlr05soSP1BTHoMYD1oveU5TaRdqy7dU+haGYRZuqfopDZXvKxk8O
	8413xXWFNdxuvcYePQAmFFUGf2eEYhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779878191;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a0hsJ6cHgPFOpUL5QBFjvONR8o/mHsobCDDUyLaORAw=;
	b=LGlw26RSWtagu+6agpEhn8gBv4c6qiBYbmcT9RBPW5y+1hIdOCp4+GyQU5S5ScpJKYIuFY
	d/ThrPRRtLtZQUCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FEDC5A7AF;
	Wed, 27 May 2026 10:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IxFVGy/JFmoSdAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:36:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1C6DEA0EB5; Wed, 27 May 2026 12:36:27 +0200 (CEST)
Date: Wed, 27 May 2026 12:36:27 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 11/34] buffer: Convert __block_write_full_folio to
 __bh_submit()
Message-ID: <lnmt7rgq5mljouvcsedxbpnrmw5s5p5rfd5qloxsqo4ys367zl@2wno5qtluchx>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-12-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-12-willy@infradead.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]

On Mon 25-05-26 18:19:04, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using __bh_submit() instead
> of submit_bh_wbc().  Since there is only one caller of submit_bh_wbc()
> left, inline it into submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 92500060d834..9199ac5d6154 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -1261,14 +1261,6 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
>  	blk_crypto_submit_bio(bio);
>  }
>  
> -static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
> -			  enum rw_hint write_hint,
> -			  struct writeback_control *wbc)
> -{
> -	BUG_ON(!bh->b_end_io);
> -	__bh_submit(bh, opf, write_hint, wbc, end_bio_bh_io_sync);
> -}
> -
>  /**
>   * bh_submit - Start I/O against a buffer head
>   * @bh: The buffer head to perform I/O on.
> @@ -1936,7 +1928,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  			continue;
>  		}
>  		if (test_clear_buffer_dirty(bh)) {
> -			mark_buffer_async_write(bh);
> +			set_buffer_async_write(bh);
>  		} else {
>  			unlock_buffer(bh);
>  		}
> @@ -1952,8 +1944,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  	do {
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
> -			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
> -				      inode->i_write_hint, wbc);
> +			__bh_submit(bh, REQ_OP_WRITE | write_flags,
> +					inode->i_write_hint, wbc,
> +					bh_end_async_write);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -1990,7 +1983,7 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  		if (buffer_mapped(bh) && buffer_dirty(bh) &&
>  		    !buffer_delay(bh)) {
>  			lock_buffer(bh);
> -			mark_buffer_async_write(bh);
> +			set_buffer_async_write(bh);
>  		} else {
>  			/*
>  			 * The buffer may have been set dirty during
> @@ -2006,8 +1999,9 @@ int __block_write_full_folio(struct inode *inode, struct folio *folio,
>  		struct buffer_head *next = bh->b_this_page;
>  		if (buffer_async_write(bh)) {
>  			clear_buffer_dirty(bh);
> -			submit_bh_wbc(REQ_OP_WRITE | write_flags, bh,
> -				      inode->i_write_hint, wbc);
> +			__bh_submit(bh, REQ_OP_WRITE | write_flags,
> +					inode->i_write_hint, wbc,
> +					bh_end_async_write);
>  			nr_underway++;
>  		}
>  		bh = next;
> @@ -2813,7 +2807,8 @@ EXPORT_SYMBOL(generic_block_bmap);
>  
>  void submit_bh(blk_opf_t opf, struct buffer_head *bh)
>  {
> -	submit_bh_wbc(opf, bh, WRITE_LIFE_NOT_SET, NULL);
> +	BUG_ON(!bh->b_end_io);
> +	__bh_submit(bh, opf, WRITE_LIFE_NOT_SET, NULL, end_bio_bh_io_sync);
>  }
>  EXPORT_SYMBOL(submit_bh);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
