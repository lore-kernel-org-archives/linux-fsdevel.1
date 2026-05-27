Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5AF3F1665
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 May 2026 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878076; cv=none; b=MHPN66f2RYoUZ3O0GrMDH9XgqZa8JwddIpbXZ0SwlgbhsSAt2Qfkdym9ufZckX3fkFNTtF9B8BM+rx7OXCodz7svCXGM6i9mMD9UbMnMxQ0/LJ+87U0zvdPoxGZsFom38cTYAhpvs8ESl6Yv6CncQEb2DD0DFGhq3tWQFKMDdmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878076; c=relaxed/simple;
	bh=7DcSZEtHPTrqjcyxzSyFlkaM/Sk2wF10EZRNTmHXOs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSPgsfpVPVfItIzn6LOm8wqRGia1OCQKElHloSFgvpBTrjYffChrppJRzXJX7okA5bYUE9C1+6P5M5CL21GLLNq05oELcqeRmvkpOzi78jGoP4zFYJOsPZ4iL+TY4YCC5Td++wqfJnvkCgc/4iIGzd3u/Za2k9iDP0z7Bek++UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cvBiccp1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HaOrq1/M; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=t1OvPNs6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uiD2N/vq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cvBiccp1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HaOrq1/M";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="t1OvPNs6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uiD2N/vq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 81D256A843;
	Wed, 27 May 2026 10:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779878072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdjeoOtuMvdZL0moZvjEAeNBYHF+20j9n/jEe8bMxf4=;
	b=cvBiccp1ZbAAi1hx0MjDwL7XgXLqnmdKhirAgXN3Cp35GzumqrIdcs/mCrMTkn5oHGgj6k
	Uz1W8ys81ImvS/Ug/o6CyHIFLYzhPi0s30cH/nbHuDeMG7mVoW+RdTfHsLJrTAdYOoCP+V
	DpfX/l3Gpqs/7Rzp4u5d+GXxvm9huOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779878072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdjeoOtuMvdZL0moZvjEAeNBYHF+20j9n/jEe8bMxf4=;
	b=HaOrq1/MOJyzH5IPhawpxBM5euIlFsNdgSdnPgxWwkQh06xSyDtpEGlc7ikX3r0AOA4ToR
	12/ymL2Y9Q782HAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779878071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdjeoOtuMvdZL0moZvjEAeNBYHF+20j9n/jEe8bMxf4=;
	b=t1OvPNs63CbYgDEHmdjhAc9CbkH6c7pRbXVX0DsYqrk9Q4dCKD77gY3gB3FEGA59k5SlpG
	uUtmlPuRdCSlM24POpXWN8ZW6tTkYnRIF2GlIvVWlMBFQnJTtaDGF2ylI6yaUR/x6rGEzG
	64oeNYySPN6hCxa2bPAZe/+MVJnYdiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779878071;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MdjeoOtuMvdZL0moZvjEAeNBYHF+20j9n/jEe8bMxf4=;
	b=uiD2N/vqtkIfpljrH7+WEqffKDc5WkOYkgocHhlMpRTGibVYwJ4Wvo18i66e+oTePjPVkg
	wwqcNmzHZQCFbZAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 789D55A7AE;
	Wed, 27 May 2026 10:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +FVzHbfIFmpMcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 27 May 2026 10:34:31 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1BC17A0EB5; Wed, 27 May 2026 12:34:31 +0200 (CEST)
Date: Wed, 27 May 2026 12:34:31 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 10/34] buffer: Convert block_read_full_folio to
 bh_submit()
Message-ID: <hbs3yhyjxomwvzxtm7ul4vtqczvhopne27izsofr2emqribuot@o5etet4a4syt>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-11-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525171931.4144395-11-willy@infradead.org>
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spam-Flag: NO
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email,infradead.org:email]

On Mon 25-05-26 18:19:03, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().  Since mark_buffer_async_read() would collapse to a single
> function call, inline it into block_read_full_folio() along with its
> extensive comment.  Convert end_buffer_async_read_io() to
> bh_end_async_read().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/buffer.c | 65 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 32 insertions(+), 33 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index 44b14f0642f4..92500060d834 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -392,11 +392,13 @@ static void decrypt_bh(struct work_struct *work)
>  }
>  
>  /*
> - * I/O completion handler for block_read_full_folio() - pages
> + * I/O completion handler for block_read_full_folio() - folios
>   * which come unlocked at the end of I/O.
>   */
> -static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
> +static void bh_end_async_read(struct bio *bio)
>  {
> +	bool uptodate = bio->bi_status == BLK_STS_OK;
> +	struct buffer_head *bh = bio_endio_bh(bio);
>  	struct inode *inode = bh->b_folio->mapping->host;
>  	bool decrypt = fscrypt_inode_uses_fs_layer_crypto(inode);
>  	struct fsverity_info *vi = NULL;
> @@ -421,7 +423,7 @@ static void end_buffer_async_read_io(struct buffer_head *bh, int uptodate)
>  			}
>  			return;
>  		}
> -		uptodate = 0;
> +		uptodate = false;
>  	}
>  	end_buffer_async_read(bh, uptodate);
>  }
> @@ -484,33 +486,6 @@ void bh_end_async_write(struct bio *bio)
>  }
>  EXPORT_SYMBOL(bh_end_async_write);
>  
> -/*
> - * If a page's buffers are under async readin (end_buffer_async_read
> - * completion) then there is a possibility that another thread of
> - * control could lock one of the buffers after it has completed
> - * but while some of the other buffers have not completed.  This
> - * locked buffer would confuse end_buffer_async_read() into not unlocking
> - * the page.  So the absence of BH_Async_Read tells end_buffer_async_read()
> - * that this buffer is not under async I/O.
> - *
> - * The page comes unlocked when it has no locked buffer_async buffers
> - * left.
> - *
> - * PageLocked prevents anyone starting new async I/O reads any of
> - * the buffers.
> - *
> - * PageWriteback is used to prevent simultaneous writeout of the same
> - * page.
> - *
> - * PageLocked prevents anyone from starting writeback of a page which is
> - * under read I/O (PageWriteback is only ever set against a locked page).
> - */
> -static void mark_buffer_async_read(struct buffer_head *bh)
> -{
> -	bh->b_end_io = end_buffer_async_read_io;
> -	set_buffer_async_read(bh);
> -}
> -
>  void mark_buffer_async_write(struct buffer_head *bh)
>  {
>  	bh->b_end_io = end_buffer_async_write;
> @@ -2488,9 +2463,33 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  			continue;
>  		}
>  
> -		mark_buffer_async_read(bh);
> +		/*
> +		 * If a folio's buffers are under async readin
> +		 * (end_buffer_async_read completion) then there is a
> +		 * possibility that another thread of control could lock
> +		 * one of the buffers after it has completed but while
> +		 * some of the other buffers have not completed.  This
> +		 * locked buffer would confuse end_buffer_async_read()
> +		 * into not unlocking the folio.  So the absence of
> +		 * BH_Async_Read tells end_buffer_async_read() that this
> +		 * buffer is not under async I/O.
> +		 *
> +		 * The folio comes unlocked when it has no locked
> +		 * buffer_async buffers left.
> +		 *
> +		 * The folio lock prevents anyone starting new async
> +		 * I/O reads any of the buffers.
> +		 *
> +		 * The writeback flag is used to prevent simultaneous
> +		 * writeout of the same folio.
> +		 *
> +		 * The folio lock prevents anyone from starting writeback
> +		 * of a folio which is under read I/O (the writeback
> +		 * flag is only ever set on a locked folio).
> +		 */
> +		set_buffer_async_read(bh);
>  		if (prev)
> -			submit_bh(REQ_OP_READ, prev);
> +			bh_submit(prev, REQ_OP_READ, bh_end_async_read);
>  		prev = bh;
>  	} while (iblock++, (bh = bh->b_this_page) != head);
>  
> @@ -2504,7 +2503,7 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  	 * in this folio.
>  	 */
>  	if (prev)
> -		submit_bh(REQ_OP_READ, prev);
> +		bh_submit(prev, REQ_OP_READ, bh_end_async_read);
>  	else
>  		folio_end_read(folio, !page_error);
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
