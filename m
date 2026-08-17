Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6DE44CF59;
	Mon, 17 Aug 2026 16:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786983780; cv=none; b=i8roA7160fcLLBiifSCCxQ7RUS4QWP7wRqtGKn8vc/rgo8f+3Bnk1vvLuzwew5fu7e2aQQV/ITeCQkrTVXQWIludNubeWqnHdu031m681LIL8hdQYi67F9HIbVdMyIboQCCMywzkPX1Wf1cn+4jHY6ehPcRBjaXYfNsIrO+Bu6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786983780; c=relaxed/simple;
	bh=yB50sGtNEPaJJyZ+6RWhkJi24/OJD+QHuHwOuLtXl50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epepajp5OgEH5X1H+9XbCSBBcKpYNDj/C6T5O6h4QIQ038hDQAE2Oo/CNBcuRCygYy711C69oPpD92sw7zphSQYB9ecQi3X/JavRWo1yLvKenihfECOS08IY+G/gZg6Sr0pcU6hcuYBsQPPwpBN8hOFZhodulP0sSn/uaSIJ+sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=M9lEqKNY; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=nc8Hgt6v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1KN4OFxU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lvZ+d9ee; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="M9lEqKNY";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="nc8Hgt6v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1KN4OFxU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lvZ+d9ee"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECFCD840A1;
	Mon, 17 Aug 2026 16:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786983771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hij7YwfoE5wWVmiYP4GWFvxTOzb2//kKqvv5I9rQBiA=;
	b=M9lEqKNYcNJeMlimzADwxfUN4Iuo8u1M5qZ1lTJs3quXNwBeUKx2NTgUTgS8gU//7f5KQe
	fOY9tOjPW0xPTdA9Ji7vIhNgInEWFVTziRjFAjTddLfdyVYXf0yOjFJbVILUYFR3SNGUAy
	ZUuOgKX9Zcec18Pbf66YNXV7DFrLQ/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786983771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hij7YwfoE5wWVmiYP4GWFvxTOzb2//kKqvv5I9rQBiA=;
	b=nc8Hgt6vxy+kjbV35GgFuIzIg1ehEZBvexsuSDvHdnYPCBTMM0v4L26sjFuZ87li6F9oe4
	qG4/HxkDWdPF8+AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1KN4OFxU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=lvZ+d9ee
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786983767; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hij7YwfoE5wWVmiYP4GWFvxTOzb2//kKqvv5I9rQBiA=;
	b=1KN4OFxU2Rl6wuR6tZ+d5x7TcGnuYjUAcsDSxKkQypGZPQOKTPqnI4H07BGKHtuGkIIt+K
	pHsL+CnR1CkAv/nsRiRo1Mralp+pjKdAiwKuHU1WcgzP3MFeqTM4/s6OLqwQxS4hEONSLU
	iUa5063guwOJLY4U+nfpn0WgMc4qs8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786983767;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hij7YwfoE5wWVmiYP4GWFvxTOzb2//kKqvv5I9rQBiA=;
	b=lvZ+d9eehGsD2WHxLtIdIgKyKG8tyrLQzC17UozcWpwcq4D0KPVpVxo8FzdfzNZj9FSa3N
	1b6EKMjbip6JbPDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5D8E7955E;
	Mon, 17 Aug 2026 16:22:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rpcTOFY1g2rndAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Aug 2026 16:22:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90FACA13B5; Mon, 17 Aug 2026 18:22:46 +0200 (CEST)
Date: Mon, 17 Aug 2026 18:22:46 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Ayhan Aydin <nsd.project.dev@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache
 prefetcher
Message-ID: <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anlByPDZmvEhWeXI@casper.infradead.org>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kvack.org,suse.cz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Queue-Id: ECFCD840A1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Mon 10-08-26 04:13:12, Matthew Wilcox wrote:
> On Sat, Aug 08, 2026 at 05:10:42PM -0400, Ayhan Aydin wrote:
> > For reference, the series adds an optional observation hook
> > (CONFIG_NSD, default off, see PATCH 1/3) that does not bypass
> > the existing ra_state / file_ra_struct machinery. All actual
> > page insertion is still delegated to page_cache_sync_readahead().
> > Benchmarks (interleaved ON/OFF methodology, i.e. same-machine A/B
> > with repeated runs, SQLite full-table scans and buffered
> > sequential I/O) showed an 18-19% wall-time reduction and
> > +22.6% throughput improvement respectively.

I can see how SQLite table scans could be improved but I'm really surprised
by the 64k sequential buffered read. That's basically what the current
readahead logic is built for. So how is the sync readahead you trigger
better than what generic async readahead does?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
