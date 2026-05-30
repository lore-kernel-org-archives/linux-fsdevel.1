Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26553AB293
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 11:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141633; cv=none; b=GKLTSZwhH5YkcLG7Wl6ylXD/cLEzx/akBYvul1OhHakAl+GV3o5F6igolI6savsrgbM8S3HLfrQujYYcEH4m5BCC7O9zJqGg0LtTpgOlSHZAMDqOaJwSLvGw0wd69S1oM/jkhSh0syv1oBZt5hxygzinrcsvxvPDofWShRHKYbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141633; c=relaxed/simple;
	bh=V6C5RUeVFjtwty2vmgUj0afme604NqLopOHKzNTBVN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKsKVbN6xCPrlZRV69qAbaV4HcDUnQgV7KkwodnrlRAmZaZh0AXakaxpLj+6fFeooSzEAOXTgNw8n0P8xOhK5OlDAImC8a8dn56CX2GpxIwrYyMXs7ow91GjM3eG6EgQkxEm4HSMjxPPmLV1GZ6R+yjVxoHb4/8kvAlGrZuy8rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TBohJ5Dc; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=YZ7Qben3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlaekfih; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BdWTiAln; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TBohJ5Dc";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YZ7Qben3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlaekfih";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BdWTiAln"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BE3A367B47;
	Sat, 30 May 2026 11:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141630; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vACZbfk4xvqXgBsT4L7dXRn+jvGPWoWD7VlSaxBajoY=;
	b=TBohJ5Dcb3fGUK4ktHN5X2qj2v/4fO/gK1qeftu7Q2t3g3IYy+KIAQ7odwUUx+XVyTYOJP
	wYec8bWLnByI1QrsHFTqYhJOOYUGNbwWlrzXpNUO3LgivDjxltFlAxor/geZkMVAsqjJIC
	XkLRiwfWdsLobOy3zWHl0wrMCyB9FJg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141630;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vACZbfk4xvqXgBsT4L7dXRn+jvGPWoWD7VlSaxBajoY=;
	b=YZ7Qben3UyYaCZT6+ssPqbRXOhAOU0G8hW+4ZrGpIverz8RMhdXJFV5j2Z9CoMcyf3M+CO
	Ero8p6hJowvA3WDA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qlaekfih;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BdWTiAln
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780141628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vACZbfk4xvqXgBsT4L7dXRn+jvGPWoWD7VlSaxBajoY=;
	b=qlaekfihZjDF5aV++69HEQX/NBiaI6pftM5NKd5ZmUNlzpM/aUSjskLapWT9kXx9aJR3CJ
	ABps3cgsbvmKNjx7b1tHS4dC79Dx0INBrMTK0sRyZP8NpgftZXbSZzpMBjj4jbqMvWn+2b
	YW/qUj4RwPvMcNgf/mgANzp6xlTb8tU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780141628;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vACZbfk4xvqXgBsT4L7dXRn+jvGPWoWD7VlSaxBajoY=;
	b=BdWTiAlnwBWrZmufwSPEbMtas6CO54Wl6JkdFhuJyrG5wjBgF6fBCzc43TulW/g7kwStM/
	H/m5u6OIv2EVyHCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B670D779A7;
	Sat, 30 May 2026 11:47:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SFiJLDzOGmp1QQAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 11:47:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 577F6A0EBD; Sat, 30 May 2026 13:47:00 +0200 (CEST)
Date: Sat, 30 May 2026 13:47:00 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH v2 22/34] gfs2: Convert gfs2_metapath_ra to bh_submit()
Message-ID: <c2yofxqkmjlbjury266556qxqqhmloff43v65tyht6prfbqa56@z5swhbodxfy5>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-23-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-23-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BE3A367B47
X-Rspamd-Action: no action
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linux.dev:email,suse.com:email];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 28-05-26 18:31:35, Matthew Wilcox (Oracle) wrote:
> Avoid an extra indirect function call by using bh_submit() instead
> of submit_bh().  Also simplify the control flow now that the buffer
> refcount is not put by bh_end_read().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: gfs2@lists.linux.dev

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/bmap.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
> index b3d7fcd95f03..d158c4b7413d 100644
> --- a/fs/gfs2/bmap.c
> +++ b/fs/gfs2/bmap.c
> @@ -304,14 +304,15 @@ static void gfs2_metapath_ra(struct gfs2_glock *gl, __be64 *start, __be64 *end)
>  		rabh = gfs2_getbuf(gl, be64_to_cpu(*t), CREATE);
>  		if (trylock_buffer(rabh)) {
>  			if (!buffer_uptodate(rabh)) {
> -				rabh->b_end_io = end_buffer_read_sync;
> -				submit_bh(REQ_OP_READ | REQ_RAHEAD | REQ_META |
> -					  REQ_PRIO, rabh);
> -				continue;
> +				bh_submit(rabh,
> +					REQ_OP_READ | REQ_RAHEAD | REQ_META |
> +					REQ_PRIO,
> +					bh_end_read);
> +			} else {
> +				unlock_buffer(rabh);
>  			}
> -			unlock_buffer(rabh);
>  		}
> -		brelse(rabh);
> +		put_bh(rabh);
>  	}
>  }
>  
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
