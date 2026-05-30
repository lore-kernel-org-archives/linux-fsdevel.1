Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FB564AA4
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 12:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142868; cv=none; b=sVi/9z+/GY/8/y+xQcoQTE18RZryyoltjin9K9bywa+OVgo9x/7iuzfKwTVS9LtPlDXjup5973LNVgqbMR6zx9xF4LSp2TSuZECyRYq85TvjazMSqTiaTtAYRgXoNLmcvT/als8n7fmwm4Ji77Se0vp+ZP1p//TmaQlWsgFYzJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142868; c=relaxed/simple;
	bh=ZSM5cUm9DNEQsPB1U0OXznpkhywGB+4F+bXwdfTceY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKPz5KC3yXMKBH5qmdWXbekmdkMm8AdFh3Nf+LNa5Rrrlonv1anyRbdc9uYCBzBEb8M70CL/8uYY5VtJsk266xEugwBpzRF5Sr5tqJqBG93YpupDT5j9Woi4gKQwan+hLWnGbQbbvvbRpnJY5s60YraArCOP9dBHMAmOejryTEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnV0Y/Te; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qleVRHG6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=RnV0Y/Te; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qleVRHG6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnV0Y/Te";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qleVRHG6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="RnV0Y/Te";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qleVRHG6"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 249E267BED;
	Sat, 30 May 2026 12:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdbFpIdh64sOy5jF1PcCF8mecuvPSkwBnQtdY03Aog=;
	b=RnV0Y/TeEBU/L2il2yg4mdPsPKSTr4UEdJdR3Y2Hw3x/JJ0MvZbbV8a4/w0ZAIsa8NPjrf
	Uw2rpHYR/vY/nP9K/taU1Ns/5mgWzTmFbaCNRPDwuGzA4NGBR8593pmLmSBjQxnMAW1xbH
	WhdMoGk6GtjsVXGl80PG2SxQwrcblxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdbFpIdh64sOy5jF1PcCF8mecuvPSkwBnQtdY03Aog=;
	b=qleVRHG6K2oMyVXdNng7yanO5x6upYoY66byxcMGperzqMWOiwJeRc0nDYrs8qeXUuwTOR
	AzSkcwPNlFTDlbAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdbFpIdh64sOy5jF1PcCF8mecuvPSkwBnQtdY03Aog=;
	b=RnV0Y/TeEBU/L2il2yg4mdPsPKSTr4UEdJdR3Y2Hw3x/JJ0MvZbbV8a4/w0ZAIsa8NPjrf
	Uw2rpHYR/vY/nP9K/taU1Ns/5mgWzTmFbaCNRPDwuGzA4NGBR8593pmLmSBjQxnMAW1xbH
	WhdMoGk6GtjsVXGl80PG2SxQwrcblxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WwdbFpIdh64sOy5jF1PcCF8mecuvPSkwBnQtdY03Aog=;
	b=qleVRHG6K2oMyVXdNng7yanO5x6upYoY66byxcMGperzqMWOiwJeRc0nDYrs8qeXUuwTOR
	AzSkcwPNlFTDlbAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B252779A7;
	Sat, 30 May 2026 12:07:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Aq+gBhHTGmrvVAAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 12:07:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A8FA5A0EBD; Sat, 30 May 2026 14:07:40 +0200 (CEST)
Date: Sat, 30 May 2026 14:07:40 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 33/34] buffer: Change calling convention for
 end_buffer_read_sync()
Message-ID: <2lbdmkqnz62wulcq576mvhjwiirgky6vpyvpjwxkpm275qf7a4@zlkck3bcyqby>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-34-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-34-willy@infradead.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,infradead.org:email]

On Thu 28-05-26 18:31:46, Matthew Wilcox (Oracle) wrote:
> Unify end_buffer_read_sync() and __end_buffer_read_notouch()
> by requiring the caller put the refcount on the buffer.  The only caller
> is in the gfs2_meta_read() path, and there we can put the refcount
> after locking the buffer.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

It seems a bit sad to keep end_buffer_read_sync() alive only for gfs2
metadata reading path but let's leave that for another time. Feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>


								Honza

> ---
>  fs/buffer.c       | 28 +++++++++-------------------
>  fs/gfs2/meta_io.c |  2 +-
>  2 files changed, 10 insertions(+), 20 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index ccda92920175..db604c0e54d4 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -157,15 +157,15 @@ bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
>  }
>  EXPORT_SYMBOL(bio_endio_bh);
>  
> -/*
> - * End-of-IO handler helper function which does not touch the bh after
> - * unlocking it.
> - * Note: unlock_buffer() sort-of does touch the bh after unlocking it, but
> - * a race there is benign: unlock_buffer() only use the bh's address for
> - * hashing after unlocking the buffer, so it doesn't actually touch the bh
> - * itself.
> +/**
> + * end_buffer_read_sync - Handle buffer reads finishing
> + * @bh: The buffer.
> + * @uptodate: True if the read was successful.
> + *
> + * If a buffer is read through a mechanism that isn't bh_submit(), you
> + * can call this function to finish the read.
>   */
> -static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
> +void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
>  {
>  	if (uptodate) {
>  		set_buffer_uptodate(bh);
> @@ -175,16 +175,6 @@ static void __end_buffer_read_notouch(struct buffer_head *bh, int uptodate)
>  	}
>  	unlock_buffer(bh);
>  }
> -
> -/*
> - * Default synchronous end-of-IO handler..  Just mark it up-to-date and
> - * unlock the buffer.
> - */
> -void end_buffer_read_sync(struct buffer_head *bh, int uptodate)
> -{
> -	put_bh(bh);
> -	__end_buffer_read_notouch(bh, uptodate);
> -}
>  EXPORT_SYMBOL(end_buffer_read_sync);
>  
>  /**
> @@ -198,7 +188,7 @@ void bh_end_read(struct bio *bio)
>  {
>  	struct buffer_head *bh;
>  	bool uptodate = bio_endio_bh(bio, &bh);
> -	__end_buffer_read_notouch(bh, uptodate);
> +	end_buffer_read_sync(bh, uptodate);
>  }
>  EXPORT_SYMBOL(bh_end_read);
>  
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index 4895bb010cfb..a87cfbf0df38 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -286,10 +286,10 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
>  		lock_buffer(bh);
>  		if (buffer_uptodate(bh)) {
>  			unlock_buffer(bh);
> -			brelse(bh);
>  		} else {
>  			bhs[num++] = bh;
>  		}
> +		brelse(bh);
>  	}
>  
>  	gfs2_submit_bhs(REQ_OP_READ | REQ_META | REQ_PRIO, bhs, num);
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
