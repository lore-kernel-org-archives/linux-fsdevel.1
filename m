Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C326426ECF
	for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778516773; cv=none; b=aoSEJy/IrXsOVlxNtTxL+ZpHDrpTd61znyPU1m/umPaWR4ArpM+GEWJVyn6nlmN0l7GGxHvqZ44BeFOKL36BUb8J+Ecrg+O3jrNW+NQrTMXzlV4Ud9qQ0cO1YyZUEn/9+yW8HtprC5n1aZ0OOAhs3o2uWwDcMzKHM7C+67JsSbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778516773; c=relaxed/simple;
	bh=1F1obJgnCpz56soGq6v1k7623NaPg6fpEzhOfNw//QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qgcluCKfwo9AGVaUi3yl8sKZuZfQgG8BbeZA9PV4RaNrDkjiDDg5LT0pXP3Xbsrzp+xdQtOhfmy+2cWjUnZ/swKgKA8uA9cX7JMYYSTfb4SSIIDFrqbCDpV9hu4gD0pmGinO41hmaUrDiPBnc/hcpgWzlN/GYtTyTWwjvok4Xho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cG1enXI1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HBCzjFk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cG1enXI1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=7HBCzjFk; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cG1enXI1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HBCzjFk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cG1enXI1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7HBCzjFk"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E9076BA83;
	Mon, 11 May 2026 16:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4cEJJojjKJfVGKGY9ofdQshTBxx0aX2LtNULn18dP8=;
	b=cG1enXI1P9zXeCfgkXjUx4u5hpncq+Y613nKTv0IRnAtEHFZ/V8xcL9EtVAabjgj6Zo19A
	wq1KmMskBV+N/uT//dOkrglyJEqpyBFFRlilBlZDnvTgd5iixrO63Ao4kF0eGAe4IwtOIP
	FvTXO4dRn58RgMAIZLAt9ACD6FCC25I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4cEJJojjKJfVGKGY9ofdQshTBxx0aX2LtNULn18dP8=;
	b=7HBCzjFk19z3ATbwxp7QTHebnhnWYz+EGezfmSNN/SgEnC85vJjO7Tbe3sgA3El+odKGA6
	R4zShiR/kMf+b+Dw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cG1enXI1;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=7HBCzjFk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778516770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4cEJJojjKJfVGKGY9ofdQshTBxx0aX2LtNULn18dP8=;
	b=cG1enXI1P9zXeCfgkXjUx4u5hpncq+Y613nKTv0IRnAtEHFZ/V8xcL9EtVAabjgj6Zo19A
	wq1KmMskBV+N/uT//dOkrglyJEqpyBFFRlilBlZDnvTgd5iixrO63Ao4kF0eGAe4IwtOIP
	FvTXO4dRn58RgMAIZLAt9ACD6FCC25I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778516770;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U4cEJJojjKJfVGKGY9ofdQshTBxx0aX2LtNULn18dP8=;
	b=7HBCzjFk19z3ATbwxp7QTHebnhnWYz+EGezfmSNN/SgEnC85vJjO7Tbe3sgA3El+odKGA6
	R4zShiR/kMf+b+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 350FC593A3;
	Mon, 11 May 2026 16:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u/XsDCIDAmrxWgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 11 May 2026 16:26:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3739CA079E; Mon, 11 May 2026 18:26:04 +0200 (CEST)
Date: Mon, 11 May 2026 18:26:04 +0200
From: Jan Kara <jack@suse.cz>
To: Vishal Moola <vishal.moola@gmail.com>
Cc: Tal Zussman <tz2294@columbia.edu>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: fix page_cache_prev_miss() when no hole is
 found
Message-ID: <s6hnqm4bbi5j2ergudihydboj3uw7gsu7te4dfmjgv2qeosfbd@yvhp5oy3r3b6>
References: <20260510-prev_miss_fix-v1-1-755bb123145a@columbia.edu>
 <agHPIcZHHyzBjcGN@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agHPIcZHHyzBjcGN@fedora>
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E9076BA83
X-Spam-Level: 

On Mon 11-05-26 13:44:17, Vishal Moola wrote:
> On Sun, May 10, 2026 at 05:54:17PM -0400, Tal Zussman wrote:
> > page_cache_prev_miss() is documented to return a value outside the
> > searched range when no gap is found. However, the no-gap-found path
> > returns xas.xa_index, which after a successful loop is the first index
> > in the range. As such, that index is misreported as a gap.
> > 
> > The sole caller, page_cache_sync_ra(), uses the return value to estimate
> > the cached run preceding a sequential read. In some cases, the buggy
> > return value can undercount the contiguous range by one, shrinking the
> > readahead window or pushing borderline requests into the
> > small-random-read branch.
> > 
> > Mirror the fix in commit bbcaee20e03e ("readahead: fix return value of
> > page_cache_next_miss() when no hole is found"): preserve max_scan in a
> > separate variable across the loop and return `index - max_scan` from the
> > no-gap-found path.
> 
> IMO, this way of fixing it hurts the readability. I'd prefer something
> similar to the fix in the original commit. Or...
> 
> > -	while (max_scan--) {
> > +	while (nr--) {
> >  		void *entry = xas_prev(&xas);
> >  		if (!entry || xa_is_value(entry))
> > -			break;
> > +			return xas.xa_index;
> >  		if (xas.xa_index == ULONG_MAX)
> > -			break;
> > +			return ULONG_MAX;
> >  	}
> 
> If I understand this correctly, couldn't we just do something like:
> if (!max_scan)
> 	return xas.xa_index - 1;

I think the easiest to understand would be to do the above two explicit
returns instead of 'break' and change below to:

	/* Return start of the range - 1 when no hole is found */
	return xas.xa_index - 1;

> > -	return xas.xa_index;
> > +	return index - max_scan;
> >  }

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
