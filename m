Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737B3955D3
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141765; cv=none; b=ULBaSTXZEdAyUBzkNznPuDevYqrJWF0XBLhf8uR3zPPU6vsbO0fAWxzuqpS0vnxpS0LW0mQs6q7FhYbd3MtfkRjEA5P/u4azo+Vo/iUw4e7zHoEtL/2YOJ5jInt7uB0nbWRx20urfmpuNeU0eJek+x79MM4wXHzDvwAHKmQNySY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141765; c=relaxed/simple;
	bh=osv7mgf1tC1UVnuYK9VGUKTWKxYBqiBb2pPaFLbe6iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9ytatnLByfX739NkwCC7G+L28rGvT6DHla2jmssvhN0/rTfxJ9R2WsD9uWIF9iwQNku8sTqa3+vUBCpH/CPh254pZT950Xn40Sxoo3bK0E/oKOXMC4BP9pKToYSgls0sbdySGbc09/Aa7fKEdkvQE3BcnWmy+2Tn0NEWmecaB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HPlyyV+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=emIlxTJD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=HPlyyV+L; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=emIlxTJD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HPlyyV+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="emIlxTJD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="HPlyyV+L";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="emIlxTJD"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0592E67B61;
	Sat, 30 May 2026 11:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2S/LmHdnnHUTVdhZAs+VOmnLjZ/aL/TzvgA8Zn2hs=;
	b=HPlyyV+LgzHR+eJZxXd82NCxnvmXL9LhJ7OlcOz3bwQ+jk8xaPAh6XtlXxNLAzVgZPhsOb
	WjeR/mCo+YzE2hoxd9Q0oL+wHey6AWeJ0VzrE+MZXfH7+ep7CRNtJ08lQiqjbXczhWn4KP
	j1SXmJFV62cQ5A9v7xH4MjIZmrAAJcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2S/LmHdnnHUTVdhZAs+VOmnLjZ/aL/TzvgA8Zn2hs=;
	b=emIlxTJD9uhiGFBuhNTdUZnKu5RVCxz+yUf/iFlBPAmsgyzBw2T2ngsWav26dFbDN8/Mmd
	VAstV8WLyXKAjHDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2S/LmHdnnHUTVdhZAs+VOmnLjZ/aL/TzvgA8Zn2hs=;
	b=HPlyyV+LgzHR+eJZxXd82NCxnvmXL9LhJ7OlcOz3bwQ+jk8xaPAh6XtlXxNLAzVgZPhsOb
	WjeR/mCo+YzE2hoxd9Q0oL+wHey6AWeJ0VzrE+MZXfH7+ep7CRNtJ08lQiqjbXczhWn4KP
	j1SXmJFV62cQ5A9v7xH4MjIZmrAAJcA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141763;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OT2S/LmHdnnHUTVdhZAs+VOmnLjZ/aL/TzvgA8Zn2hs=;
	b=emIlxTJD9uhiGFBuhNTdUZnKu5RVCxz+yUf/iFlBPAmsgyzBw2T2ngsWav26dFbDN8/Mmd
	VAstV8WLyXKAjHDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0A23779A7;
	Sat, 30 May 2026 11:49:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0vS+OsLOGmp2QwAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:49:22 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A2D89A0EBD; Sat, 30 May 2026 13:49:18 +0200 (CEST)
Date: Sat, 30 May 2026 13:49:18 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH v2 23/34] gfs2: Convert gfs2_dir_readahead to bh_submit()
Message-ID: <zv5vn2zt2ew2ysc4meuymeyudrxxebgjuxwdroqhcjduo3brck@6m43po355hpy>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-24-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-24-willy@infradead.org>
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
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,linux.dev:email]

On Thu 28-05-26 18:31:36, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead of
> submit_bh().  Also simplify the control flow now that the buffer
> refcount is not put by bh_end_read().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: gfs2@lists.linux.dev

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/dir.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/gfs2/dir.c b/fs/gfs2/dir.c
> index 022dbb31e0d9..0237b36b9eb1 100644
> --- a/fs/gfs2/dir.c
> +++ b/fs/gfs2/dir.c
> @@ -1505,15 +1505,13 @@ static void gfs2_dir_readahead(struct inode *inode, unsigned hsize, u32 index,
>  		if (trylock_buffer(bh)) {
>  			if (buffer_uptodate(bh)) {
>  				unlock_buffer(bh);
> -				brelse(bh);
> -				continue;
> +			} else {
> +				bh_submit(bh, REQ_OP_READ | REQ_RAHEAD |
> +						REQ_META | REQ_PRIO,
> +						bh_end_read);
>  			}
> -			bh->b_end_io = end_buffer_read_sync;
> -			submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -				  REQ_PRIO, bh);
> -			continue;
>  		}
> -		brelse(bh);
> +		put_bh(bh);
>  	}
>  }
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
