Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7867360EEE
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2026 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959140; cv=none; b=flNEbNAZOIE5xwNhKnuYIiK0rPfhiiwSRbn4mxG9k5/jh/Foc2yrb9kUj5J0sHwRoySce7H2WDkl0y/jmT/DFFGv7cmmrieIwNndAYF8R4PFpmIWtlGLUarVSljMRw2fxiA+hMQKaUTyyosawsfwUpUm1/ctDwXG6L+0eMqz/b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959140; c=relaxed/simple;
	bh=wwfD4h+tn92RIZqL8pnFeW5a13eMgLbl+InYNBC21rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqbJ4InrEOwfvp1aXTULgU1EsP5mYSZNxkMXpI1SeCow7KdzCNy0BaVcRRCuKPw/9zwOvMHLxmpwj6K8TvJhvOpTuKIiGzNL1DUjy9sE+D6IqLOlzh2aT+/6PWDGJuibg0uv0a6vDI88RppIr1+YeIDRaXH9uJ+jwcB26dIjPE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJfLl4/z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PMbX2xHs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zJfLl4/z; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PMbX2xHs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJfLl4/z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PMbX2xHs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zJfLl4/z";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PMbX2xHs"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1B00673C9;
	Thu, 28 May 2026 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779959136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b02VcHFGPeeRN7nUuoste2B3hd+aLCZvOotAv/aTk4=;
	b=zJfLl4/zPYOhCXFGa9HsnfedcoLMntP85hgXR0UP/ljiBz3oX1OMo4peQdZhnn5CfVu1er
	LidkJHA1eDp0yDp0FJVCQ/TVqTMk0ibCtFGMBGtvOxz6hvEBKNopxGpsaYkUG99h/7nvDN
	VmKpfZT7iU1iafW7zJpsiJaDYlxLRzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779959136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b02VcHFGPeeRN7nUuoste2B3hd+aLCZvOotAv/aTk4=;
	b=PMbX2xHsvJGFfPDF1zSHKKuvA8r50e0xnSBxBGj/mJ0Hk/xV9WAV7ZsFhkHFLi9YgSS+BX
	ZXS0oiH7Gk4nhvBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1779959136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b02VcHFGPeeRN7nUuoste2B3hd+aLCZvOotAv/aTk4=;
	b=zJfLl4/zPYOhCXFGa9HsnfedcoLMntP85hgXR0UP/ljiBz3oX1OMo4peQdZhnn5CfVu1er
	LidkJHA1eDp0yDp0FJVCQ/TVqTMk0ibCtFGMBGtvOxz6hvEBKNopxGpsaYkUG99h/7nvDN
	VmKpfZT7iU1iafW7zJpsiJaDYlxLRzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1779959136;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b02VcHFGPeeRN7nUuoste2B3hd+aLCZvOotAv/aTk4=;
	b=PMbX2xHsvJGFfPDF1zSHKKuvA8r50e0xnSBxBGj/mJ0Hk/xV9WAV7ZsFhkHFLi9YgSS+BX
	ZXS0oiH7Gk4nhvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BA33E5ACE0;
	Thu, 28 May 2026 09:05:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oedwLWAFGGr5MAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 28 May 2026 09:05:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 59D96A0905; Thu, 28 May 2026 11:05:32 +0200 (CEST)
Date: Thu, 28 May 2026 11:05:32 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 04/34] buffer: Add bh_end_read(), bh_end_write() and
 bh_end_async_write()
Message-ID: <7mj3e7hjcum7lyr4xxo4ctzfgq422fnec47vhygqygfpt536cp@olmqcd2elu3j>
References: <20260525171931.4144395-1-willy@infradead.org>
 <20260525171931.4144395-5-willy@infradead.org>
 <sfdgf57x2oa3f5hn5izgdiomkgzwoiyqunborxtyfvtty2tlfo@oa6lvhzjrqic>
 <ahb_0Dc0Zqr9pGVx@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahb_0Dc0Zqr9pGVx@casper.infradead.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Wed 27-05-26 15:29:36, Matthew Wilcox wrote:
> On Wed, May 27, 2026 at 12:22:27PM +0200, Jan Kara wrote:
> > > +/**
> > > + * bio_endio_bh - Return the bh for a bio
> > > + * @bio: The bio
> > > + *
> > > + * Call this in your bio_end_io handler to retrieve the buffer_head
> > > + * submitted in bh_submit().  If you did not call bh_submit(), do not
> > > + * call this function; it will return garbage.
> > > + *
> > > + * This function consumes the bio refcount which will probably free the
> > > + * bio.  You should retrieve the bi_status before calling this.
> > > + */
> > > +struct buffer_head *bio_endio_bh(struct bio *bio)
> > > +{
> > > +	struct buffer_head *bh = bio->bi_private;
> > > +
> > > +	if (unlikely(bio_flagged(bio, BIO_QUIET)))
> > > +		set_bit(BH_Quiet, &bh->b_state);
> > > +	bio_put(bio);
> > > +
> > > +	return bh;
> > > +}
> > > +EXPORT_SYMBOL(bio_endio_bh);
> > 
> > Frankly, this looks too fragile to me, in particular for an exported
> > function. I'd prefer this returned the status and have another argument
> > where to store bh to. 
> 
> Heh, fair enough.  An earlier iteration of the patchset did this:
> 
> +struct xbh bio_endio_bh(struct bio *bio)
> +{
> +       struct xbh xbh;
> +       struct buffer_head *bh = bio->bi_private;
> +
> +       if (unlikely(bio_flagged(bio, BIO_QUIET)))
> +               set_bit(BH_Quiet, &bh->b_state);
> +
> +       xbh.word = (unsigned long)bh;
> +       if (bio->bi_status == BLK_STS_OK)
> +               xbh.word |= 1;
> +       bio_put(bio);
> +
> +       return xbh;
> +}
> +EXPORT_SYMBOL(bio_endio_bh);
> 
> and then the callers did this:
> 
> +void bh_end_read(struct bio *bio)
> +{
> +       struct xbh xbh = bio_endio_bh(bio);
> +       end_buffer_read_sync(xbh_bh(xbh), xbh_uptodate(xbh));
> +}
> 
> somewhat patterned after struct fd.  But I decided it just wasn't worth
> it and revised the patchset to have the callers grab bi_status
> themselves.  I did consider both returning bi_status and returning
> a bool (ie the current uptodate).  Do you have a preference between
> those two options?  I'd probably go with returning a bool just to make
> the conversions easier:
> 
> bool bio_endio_bh(struct bio *bio, struct buffer_head **bhp)
> {
>         bool ret = bio->bi_status == BLK_STS_OK;
>         struct buffer_head *bh = bio->bi_private;
> 
>         if (unlikely(bio_flagged(bio, BIO_QUIET)))
>                 set_bit(BH_Quiet, &bh->b_state);
>         bio_put(bio);
> 
>         *bhp = bh;
>         return ret;
> }

OK, this looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
