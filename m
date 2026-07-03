Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4283BCD33
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Jul 2026 15:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783091830; cv=none; b=L04y1kCngvaGshhe5aog7Yx4sqPqlILAWMuHtiwG4YLhJ6VJou3ClZtA4w60J3QmZbkCg61o61kF235jvPbFLTT4fToa1UjcFgogrJ//T2Wct5+VxaQ6VYwb9HHj1eKKLSZp5UpcMFlMGQqK0MjFEWKGrR2hd8KvFyE8WZSx89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783091830; c=relaxed/simple;
	bh=dLaePOdwiDrwl5tNNLkgfohBT9iDAfP69qtAPsKox5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skvckAmITHR3Gcb/naKkg1zrkFx9SH2AIkM68ekmSj16xSyJPYCqk4sCwE6WvkD8bMBtFPFAUdmRNf9Lldy7nniElF6921sQDJVzubdtHvj+AZoIybxXZrZI9j9ClkxYmkMCuFOG4q5iDEwz7lZ4NxhlGZytJtyt0zTFbnHYfI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hKL667Sl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jmQehgLf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L6QU4ACI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=pWgrwsqG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hKL667Sl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jmQehgLf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L6QU4ACI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="pWgrwsqG"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C04B749B5;
	Fri,  3 Jul 2026 15:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783091827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ZTzcF2Wk/f1hulDIdKAQEiBnKUGcoKK8hraQSPc6U=;
	b=hKL667SlVX9pu0ozpjgdU0KAmaQNv5cYkpmRFiA3JtN1WK4LpplfF5VDaTL6/9+9dV+4es
	k64qKiYKtZ//GkTf1d9JOBZNaX791xLRe8v/ryuSGLFXiisfIhJ/tCU1wwAm0uUeYoyazJ
	h7zTqQE2Knfb0wRRf1zjyE+xwKgy0qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783091827;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ZTzcF2Wk/f1hulDIdKAQEiBnKUGcoKK8hraQSPc6U=;
	b=jmQehgLfGRO3Ml6PiE88V40ibIQ1wFAy2K3cirRc3eaq8oIbdscGK2s8KaAet187Wd4969
	GgUYlLlL7KvB3kCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783091826; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ZTzcF2Wk/f1hulDIdKAQEiBnKUGcoKK8hraQSPc6U=;
	b=L6QU4ACIC4ENv3OMywFJ+zbu3JSTMI+wTtRrceZWxO5EZeQVVKLlPCHlQ5vq0bDqlCX0S4
	pF7FZL5Yx6XiXOMcYVIK8GZGL5RC1sCE8vzuhvGSqIRKeT+mQPnIlSJsrEaYiMZx25mER/
	Efjr+fsCdhNXL61cjRMlE9RzNbFJHVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783091826;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g6ZTzcF2Wk/f1hulDIdKAQEiBnKUGcoKK8hraQSPc6U=;
	b=pWgrwsqGVNcz7xU0zFH4GDnzEoAY8Pkbt9iZ7BzQ3R0SpdlWfQArAJt0MxbJw2vIOv3iTY
	seXZ513f/CpanVAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CE3B779AA;
	Fri,  3 Jul 2026 15:17:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cm56HnLSR2oRSQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 03 Jul 2026 15:17:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F800A12D4; Fri, 03 Jul 2026 17:17:02 +0200 (CEST)
Date: Fri, 3 Jul 2026 17:17:02 +0200
From: Jan Kara <jack@suse.cz>
To: xuanqiang.luo@linux.dev
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Joanne Koong <repnop@google.com>, 
	Miklos Szeredi <mszeredi@redhat.com>, linux-kernel@vger.kernel.org, 
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: Re: [PATCH] fanotify: initialize permission event watchdog state
Message-ID: <ysqodebormqzyedilys3fut64yrdn5lnxgyd64xu6ims5nd3ic@4fwuwhf7dekz>
References: <20260703031345.9354-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703031345.9354-1-xuanqiang.luo@linux.dev>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,suse.cz,gmail.com,google.com,redhat.com,kylinos.cn];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Fri 03-07-26 11:13:45, xuanqiang.luo@linux.dev wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> fanotify permission events are allocated with kmem_cache_alloc(), but
> fanotify_alloc_perm_event() does not initialize watchdog_cnt.
> 
> The watchdog reads watchdog_cnt after the event is moved to access_list.
> A stale value can make it warn too early or skip the warning.
> 
> Initialize watchdog_cnt when allocating a permission event.
> 
> Fixes: b8cf8fda522d ("fanotify: add watchdog for permission events")
> Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Thanks. I've added the patch to my tree.

								Honza

> ---
>  fs/notify/fanotify/fanotify.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index a3555bebad63e..b59f0aa43c4be 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -599,6 +599,7 @@ static struct fanotify_event *fanotify_alloc_perm_event(const void *data,
>  	pevent->hdr.pad = 0;
>  	pevent->hdr.len = 0;
>  	pevent->state = FAN_EVENT_INIT;
> +	pevent->watchdog_cnt = 0;
>  	pevent->path = *path;
>  	/* NULL ppos means no range info */
>  	pevent->ppos = range ? &range->pos : NULL;
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
