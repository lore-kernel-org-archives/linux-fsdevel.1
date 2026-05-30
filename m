Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D791A3AC0C3
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141645; cv=none; b=YNoPheC9+qJPmLk/Yf+sUQGpjFg+LRsXLoQxA46gtmGN3zj/LqlscDx5CbXScvtQfcN5G4ZPUl+siKQnEpSCoK4XN+ORjQUnZj0GMzw6b4LpJME1wvV46neqx1Mbak3ohoVhBVB6NBXouooUTz9Mmrd4vmXbxldp7GtkA70zvpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141645; c=relaxed/simple;
	bh=Vb58QHTUwrx39xKglD1+2hB1FJ4AYVhijkOegI4rgHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PjdbE9lYaxStCM/aPGpTJaB4WwBKRDB49iEJgZ5MxNSSLwuG8MG9i17dIuk9vLdCDLgHwPKuqFik+oXV2glfEDEOCY594JqGJ/qApKYTMqT7xZtVvsiTtYtACq0qdHwnAj4c2AWxDBV6LQJCWMPnXS2vhUwZTlBpPOfLycIcviE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GRdw0qzt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5kQJ1zYR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oAT+3902; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=t2yvAOev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GRdw0qzt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5kQJ1zYR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oAT+3902";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="t2yvAOev"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C19206B86F;
	Sat, 30 May 2026 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141641; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENrzZLPirKYmqsu+q1jfhyyrWuRSaM3ywNs9sOldpPE=;
	b=GRdw0qztBYNn+OUuF1DKjHnFwhAFrCNgE0PEnsll3e4A4xhEOQgk7x2t4IUaDODRu/HzBn
	zvs40klkiMjys7qeSKyBmI7teRN/8DGhUEUIC0fayvQ5/3eF5kkv+uP3Pnindar1VLYV3/
	fZ1ZoDaVWH4q8jtc7KRBjenxFBF7d2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141641;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENrzZLPirKYmqsu+q1jfhyyrWuRSaM3ywNs9sOldpPE=;
	b=5kQJ1zYRzvxGvAE+O1eAFI+fQCyX2jgnaB709tPI4x8/LDBfUek4xn8lcQRO6sS1N4/yU4
	AbA7pjgTpHrOylDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oAT+3902;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=t2yvAOev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENrzZLPirKYmqsu+q1jfhyyrWuRSaM3ywNs9sOldpPE=;
	b=oAT+39022C3sG64bjohFFVx7gf2e7fjCp56zyivXeFArsir+MHR9dETSbylGM2K251iklk
	fedlJRCGmtziSJI7D+xk9jjVBFcQqfKeHXcDg8ZP/7o9UhMudpVpxWR94thXsj4H1h0nX2
	+dM5kPyqFRMMH/PAYaQwz36CTO01PaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141639;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ENrzZLPirKYmqsu+q1jfhyyrWuRSaM3ywNs9sOldpPE=;
	b=t2yvAOevKBuBEd6FBQLsxHpiYnZs8u9v0aeFn5wX0OW/j1L6/4aIZFs5sPLHhjak2i9jIH
	tLQjc95R6rUTS4Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B5F98779A7;
	Sat, 30 May 2026 11:47:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HZVrLEfOGmqBQQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:47:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6B578A0EBD; Sat, 30 May 2026 13:47:15 +0200 (CEST)
Date: Sat, 30 May 2026 13:47:15 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, ocfs2-devel@lists.linux.dev
Subject: Re: [PATCH v2 19/34] ocfs2: Convert ocfs2_read_block to bh_submit()
Message-ID: <bjsk2e3wkenfjhkfw6ukh65os436ffapfmekcxvglyxmncamdb@4lvxwgai5hrh>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-20-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-20-willy@infradead.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C19206B86F
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
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,alibaba.com:email,suse.com:email,infradead.org:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]

On Thu 28-05-26 18:31:32, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call and changing the buffer refcount
> by using bh_submit() instead of submit_bh().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Cc: ocfs2-devel@lists.linux.dev

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ocfs2/buffer_head_io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
> index 714daa4bbda2..9edaeef5c4b9 100644
> --- a/fs/ocfs2/buffer_head_io.c
> +++ b/fs/ocfs2/buffer_head_io.c
> @@ -143,9 +143,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
>  #endif
>  		}
>  
> -		get_bh(bh); /* for end_buffer_read_sync() */
> -		bh->b_end_io = end_buffer_read_sync;
> -		submit_bh(REQ_OP_READ, bh);
> +		bh_submit(bh, REQ_OP_READ, bh_end_read);
>  	}
>  
>  read_failure:
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
