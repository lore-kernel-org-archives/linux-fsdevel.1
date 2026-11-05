Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876094;
	b=T0ZxDaaNXpS5RD8l5Yppq/f7ZSTOLS1yG+td6jBqNPLaQLK2msk751m/6SwrdT4Xk+YA
	 DZLT5D/XF+lBcziolgY7Ul4BUZY1GXatDrTzvQ9+XEpmauxBNr4uayYGQBReZu+PUYOBW
	 C39Uolq/x3gkkalMeMoEVyFt5d59uh/iREjSkDOd7akjhpiaUFt5+2RKHHUUgYY6AcBEc
	 qEra2cWZle95wVeNytgmLk10TntSDN8pBfigCjd5rsx4wYd6ofaaKQLqy5ACEfGgVy84U
	 VySDXJP0DnScxn918LWmcSVvhlkbvh/fwUhylJ4jkxsTs2ZGOripBloR2zkgfB389Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876094;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=pmrvnZ/EMvEeuZnlTBD+xVIwz9BGrfQBmhgJ0E/6Uns=;
	b=nTpsssX5+pui9JLAETYzQae2ugHYVXktwcHJ3iVn7C5s3CwInXpPlTmOM2pOZSM5Hl6u
	 PwJItwGvoxzOHQl9uXjwiyYbPmIOkqEBW6fpCfc7NStbAPrN5wOq8DqFU6/wTS20WTQNU
	 0Ni/Ie+wcH8/cipqj9Ya/2zmCzcJELTMMlpFmt4JbfaQKghu/ImlH1TAsavLMecvL+dKn
	 6JpOGNrRDApJ4/dovUwhVU4WaiwahVCa/LdukSaupLqJUjlCDkwuGE+wVF/NRJ+vh7bP/
	 cpdjHYzLP8lFG+FKUuQpQr9PiVX9V9CxXl78Tjy5XpyZr402msK2KZACv4faugSkY5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="f/GH5j6W";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wEysVB6j;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KToIDbJJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AiZtdrn0;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C057C606A31B;
	Thu,  5 Nov 2026 10:54:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C057C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=f/GH5j6W;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wEysVB6j;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=KToIDbJJ;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=AiZtdrn0
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B5F4021F8A;
	Thu,  5 Nov 2026 10:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793876091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmrvnZ/EMvEeuZnlTBD+xVIwz9BGrfQBmhgJ0E/6Uns=;
	b=f/GH5j6WLHXTIosA4Q9IKyULurUFpMv9+/BYPMq6Rxw8ueFWXCFeDTrfUzIUrNFgf4Nikw
	zEznvo73bLV4awjLYpO5ViCgpog1U9OOxYxg/cgadjr80VvtftyGtFZxuXyPbpNx7wRnrF
	4lkRWlALdbhXbjO0Y+WIwrmBHDbsIlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793876091;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmrvnZ/EMvEeuZnlTBD+xVIwz9BGrfQBmhgJ0E/6Uns=;
	b=wEysVB6j2qa61Ws0d3fZhxFRmIXhbmGBCpLlV1PmVRLkJJMbfNnVDQiquBJS3mnGdehk7T
	emuToUGERLyxupDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793876090; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmrvnZ/EMvEeuZnlTBD+xVIwz9BGrfQBmhgJ0E/6Uns=;
	b=KToIDbJJpYXPRUTNGAM2BUdWs/VNL0vlpFaGyCPhhS9L76pGtBfIozD+Zt24m5s+0pmVy1
	htASFuWBej54OhiKCG5b/84k2DxzdPdND7l17pd/K+LA8HnZKioAJB0qOZg6QW5PfqbDCh
	KA4aGY8pIljZ+5C9+GS2ZjMuhEAFDNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793876090;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pmrvnZ/EMvEeuZnlTBD+xVIwz9BGrfQBmhgJ0E/6Uns=;
	b=AiZtdrn0oKOknRHwHN42UnOic78MCRHrzJCUS5U8LNVNY4/RdzEqzCcxDOD4GJd8UYJg5V
	syK3fQ1BNdBXYOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FD2B133F6;
	Thu,  5 Nov 2026 10:54:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lICiFHpg7GoWRQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 10:54:50 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E6C96B696; Thu, 05 Nov 2026 11:54:49 +0100 (CET)
Date: Thu, 5 Nov 2026 11:54:49 +0100
From: Jan Kara <jack@suse.cz>
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Joanne Koong <joannelkoong@gmail.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/page-writeback: avoid unnecessary strictlimit
 background wakeups
Message-ID: <fojzqutv5x2umdn44xly7pkgkvesz7lwriah36sq2t3cuuw4ui@ywgowfpmaz34>
References: <20261031070515.3042848-2-thnkslprpt@gmail.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261031070515.3042848-2-thnkslprpt@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,suse.cz,linux-foundation.org,gmail.com,kvack.org,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Sat 31-10-26 09:05:15, Avi Weiss wrote:
> balance_dirty_pages() includes pages under writeback in
> gdtc->wb_dirty when checking the per-wb background threshold for
> strictlimit BDIs. However, wb_over_bg_thresh() only considers
> reclaimable dirty pages when deciding whether to start more
> background writeback.
> 
> This can repeatedly wake the background worker even when there are
> too few dirty pages to write. In a 15-second FUSE writeback test,
> background wakeup requests dropped from 2657 to 682 (74% drop),
> while writeback_start events remained nearly unchanged at 99 and 98.
> 
> Check wb_over_bg_thresh() before starting background writeback through
> the strictlimit condition. Leave the global background threshold
> check and the wakeup required for dirty throttling unchanged.

I assume you've left the gdtc->wb_dirty > gdtc->wb_bg_thresh check in to
reduce times when wb_over_bg_thresh() is called (because it is relatively
costly and this condition is evaluated relatively often)? Maybe it would be
good to add there a comment with explanation like:

/*
 * gdtc->wb_dirty includes pages under writeback so it serves only as a
 * quick check and we use wb_over_bg_thresh() for exact evaluation whether
 * a wakeup is needed
 */

> Fixes: 0437906841d0 ("mm: start background writeback based on per-wb threshold for strictlimit BDIs")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>

Otherwise the patch looks good so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 499a35473e4f..cb0c58715b93 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1826,7 +1826,8 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  
>  		if (!writeback_in_progress(wb) &&
>  		    (nr_dirty > gdtc->bg_thresh ||
> -		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)))
> +		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh &&
> +		      wb_over_bg_thresh(wb))))
>  			wb_start_background_writeback(wb);
>  
>  		/*
> 
> base-commit: 36aad21d50d1af3f6954bb0c988257a908202477
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
