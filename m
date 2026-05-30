Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B53AEF2F
	for <linux-fsdevel@vger.kernel.org>; Sat, 30 May 2026 12:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780142994; cv=none; b=p3opetqFR6Gh81gczbRmLEwkichJAtER75RBuQvXa49X3FAAIv8eq9sxoyVzUl9iA7nZKLl/OK+nYtsW9HA5Q5HK1uymv3dUDsKvyySns86i30Jrn17wnMiZfF+n75YX3MgR6v4UkstEZtZQYRoxezPh9B7UH3It7YWcRa57Nng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780142994; c=relaxed/simple;
	bh=eIif9K4k1g+wQ3Og2LQrtLla4l8gzfEr6uE9TdZHQ9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAl+w8nIn9MCs+Ogfed+qUMfPW7+PkdnZxWEtGvKLgoIdc8O46svqovGBYLShF7RfvoX/JUwl26oRfDFRrGTfdT/JoXVDohQ+UYM/XYNGOXKf63cDgvza9nbELyhQmA0S3GydHTGJenSBqb5B87W9HfFvB28liD0uDrrgf+Jo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G+uWDakR; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fhE47yb4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=jKJBh7e7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C5ZcxEDp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G+uWDakR";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fhE47yb4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="jKJBh7e7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C5ZcxEDp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B64B76B91B;
	Sat, 30 May 2026 12:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7qPyPnY68h4XGTAPDdeJSBgBU4zBavbMWJ/aD2NKD3Q=;
	b=G+uWDakR3psEWVR+JGX5DRbHdGz1bqhV1zn4nLJuN2fewgdPNQDpf8AgzaFVJGIoEFxgZQ
	HIBAv4oVEuZzBu5cGKJvCYmwpqZ2myyMip+6rMg0J0rRoDyf2trjVIPgfR9vu/baDHGubG
	fv87vgc3PuVFFpDuyfDgVWmmk8fEMxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142991;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7qPyPnY68h4XGTAPDdeJSBgBU4zBavbMWJ/aD2NKD3Q=;
	b=fhE47yb4ZO29poQugGfQ4DOpDrvIZ4g7/fNSdxJHlVvoD6VXQmf+ULzba5jKuRRNthS17O
	IyQiQC1iawrpkiCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jKJBh7e7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C5ZcxEDp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780142989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7qPyPnY68h4XGTAPDdeJSBgBU4zBavbMWJ/aD2NKD3Q=;
	b=jKJBh7e7KTgCH4vBP7XHvwCCeKI0ufuVhxDBr3y4WDnJL7ym+x10SKeNI3jDVbcq0/NJEh
	7m2Byi9PgYIo6uN+UV/kFyKru12EArlWmz18CfT0FMI8zwonelYhABcpkx37QkL2fGJJxH
	aYvylVTAK204m3L8mpPJqzcfVJUti14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780142989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7qPyPnY68h4XGTAPDdeJSBgBU4zBavbMWJ/aD2NKD3Q=;
	b=C5ZcxEDpRtnV+9wSSB+AlrxSNsTRc+BeZezN7KEDubsa2RvMTG2aTmrbwUUrNaoz7bNHLs
	9IFZcJJCy8cL5RDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD111779A7;
	Sat, 30 May 2026 12:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id am0+Ko3TGmrvVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 30 May 2026 12:09:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 6F26DA0EBD; Sat, 30 May 2026 14:09:41 +0200 (CEST)
Date: Sat, 30 May 2026 14:09:41 +0200
From: Jan Kara <jack@suse.cz>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH v2 24/34] gfs2: Remove use of b_end_io in
 gfs2_meta_read_endio()
Message-ID: <bowj5ekdjodcabs54zgceka5u5eyvgxermwyerttxyj4whutxg@iea6aqy5hfwj>
References: <20260528173150.1093780-1-willy@infradead.org>
 <20260528173150.1093780-25-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528173150.1093780-25-willy@infradead.org>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B64B76B91B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,linux.dev:email,infradead.org:email]
X-Spam-Flag: NO
X-Spam-Score: -4.01

On Thu 28-05-26 18:31:37, Matthew Wilcox (Oracle) wrote:
> All buffer heads submitted by gfs2_submit_bhs() use
> end_buffer_read_sync() so we can call it directly.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: gfs2@lists.linux.dev

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/gfs2/meta_io.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/gfs2/meta_io.c b/fs/gfs2/meta_io.c
> index d407dd476e72..df5f05054f6e 100644
> --- a/fs/gfs2/meta_io.c
> +++ b/fs/gfs2/meta_io.c
> @@ -212,7 +212,7 @@ static void gfs2_meta_read_endio(struct bio *bio)
>  		do {
>  			struct buffer_head *next = bh->b_this_page;
>  			len -= bh->b_size;
> -			bh->b_end_io(bh, !bio->bi_status);
> +			end_buffer_read_sync(bh, bio->bi_status == BLK_STS_OK);
>  			bh = next;
>  		} while (bh && len);
>  	}
> @@ -275,7 +275,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
>  		unlock_buffer(bh);
>  		flags &= ~DIO_WAIT;
>  	} else {
> -		bh->b_end_io = end_buffer_read_sync;
>  		get_bh(bh);
>  		bhs[num++] = bh;
>  	}
> @@ -288,7 +287,6 @@ int gfs2_meta_read(struct gfs2_glock *gl, u64 blkno, int flags,
>  			unlock_buffer(bh);
>  			brelse(bh);
>  		} else {
> -			bh->b_end_io = end_buffer_read_sync;
>  			bhs[num++] = bh;
>  		}
>  	}
> -- 
> 2.47.3
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
