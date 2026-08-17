Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4350041F5CD
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Aug 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786980604; cv=none; b=c7N0teuuVsz3Uw2zpWoXifLg8IELPznHu3nw8wZf1hn4m7ggyXxEiVSuIPSszdJm9xPkdNtserruVqqhaYieA++/8IDf/GdxRzp0nkoR3LNBpvPuHgLVHTF2Zczkz2N5iIT8NBLVR+hT/q09UDGUsJKvTJ7W5Um9vHo1rbPJ1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786980604; c=relaxed/simple;
	bh=5hpEsQl6pPS10FVxoWOr2x3KQ6nj6ZszixeDVF1PzuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5cHdb+50Jq8wz5gcOuhCp6TcrcuG1DE7JbVnlOd4QjvhesTQsUspIXwX7+48wOYS7ZQLHwE8Vlnd3Iwp/TZIOrHrrRtSoGdgiSN2dgfuzjKAk+q06tlbkCJFEbyAoP+Ln7idugrlu6fKXL5lD72CN9N1zHKfqJgbT7fcTXt5BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sgxvc1E6; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=WYlgK5W1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qY7ZhzU8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3U+ceEZX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sgxvc1E6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="WYlgK5W1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qY7ZhzU8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3U+ceEZX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 17DD482272;
	Mon, 17 Aug 2026 15:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786980597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwocy5HOnc4xM9hp/tGparlx+7VGWV7D51yWV27DQ5M=;
	b=sgxvc1E66xVbgt4vyhq2S4LOHeyIw05arZapn7IOfAQil3Nw079pQnHe+KNKGoRMr5IMWn
	RfB+OsPAHtkMl70gi6WvJKZWUWlNHKo8Mjupa79J73oL9uV94T5f8IUTyIXcp/WldlmGch
	eAO0dXOswnaomaCIKlADpaMqmENP7Ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786980597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwocy5HOnc4xM9hp/tGparlx+7VGWV7D51yWV27DQ5M=;
	b=WYlgK5W1INQL3eJKuwgh7HpVp5WYC3yotN4+cxP4buKLvm8e+UBquk12kE7rDQczjRbkfk
	ZrrniCCaYalPyXBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1786980593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwocy5HOnc4xM9hp/tGparlx+7VGWV7D51yWV27DQ5M=;
	b=qY7ZhzU8cWYiuZUSn6Vddx85pZDAqRWlkLdsjl1v1XFOUSe27JtEt2QZv6NmLnc2hytTPy
	Iim4DhM7UKGgfNZoVnnB5Ry10Y+/GLF+sKSJVDgXozjr5rkF+ziFGAujLUOrLJ+Bva0Csc
	WppXgnJrpKNBNipQimA8rsEP/KZQzwQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1786980593;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jwocy5HOnc4xM9hp/tGparlx+7VGWV7D51yWV27DQ5M=;
	b=3U+ceEZXdFnhrB4m1rTFO4lz4J5esIAAVjjptJB4/6MlejgCuMyAO5UFb/LBh6tOPr+3km
	4UMLC8J16vuSoXBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0ACA979529;
	Mon, 17 Aug 2026 15:29:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rgE0AvEog2oMQAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Aug 2026 15:29:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9F8B0A13B5; Mon, 17 Aug 2026 17:29:52 +0200 (CEST)
Date: Mon, 17 Aug 2026 17:29:52 +0200
From: Jan Kara <jack@suse.cz>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jan Kara <jack@suse.cz>, vova tokarev <vladimirelitokarev@gmail.com>, 
	Christian Brauner <brauner@kernel.org>, Pedro Falcato <pfalcato@suse.de>, akpm@linux-foundation.org, 
	security@kernel.org, linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Kees Cook <kees@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Fwd: BadBunny: UFFDIO_COPY shmem killpriv bypass leading to
 local privilege escalation
Message-ID: <5y3qictex4lbtab552i2ybgne2xt6gpmpen7nfsk46t6u5qh3j@jfmrs4dwa7fy>
References: <CAGBKPgOm8q-8_rwyRPEmSj8JXdh_GaK1Q8vpJ=j-+yA0SgcNQw@mail.gmail.com>
 <CAGBKPgPPALX_5CQJAKUNjwi2fD28pBeS5pRuwQgePU93pOy8EA@mail.gmail.com>
 <anXnHMInq_JLYbWc@pedro-suse.lan>
 <CAGBKPgOfbMJruqcegJca6BBpEtpd91s5ASF_VU+gucWsjwp8WA@mail.gmail.com>
 <ancYCBUT8aB0qHwz@pedro-suse.lan>
 <anlOGOmO1HWVCMdF@casper.infradead.org>
 <20260811-knieprobleme-holten-palmen-4d42742b1962@brauner>
 <CAGBKPgPanzn8WuHK1hm44FLCXwJcnk7W=J6b17D9UzScWW7SJQ@mail.gmail.com>
 <trv2wwdwprrebu4s6i2ufepk5a5ir4edz3tnttv7ivlkzihx3e@zq6lt67oplc5>
 <aoMmOHjLMRyUXhys@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoMmOHjLMRyUXhys@casper.infradead.org>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,gmail.com,kernel.org,suse.de,linux-foundation.org,kvack.org,zeniv.linux.org.uk,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]

On Mon 17-08-26 16:18:16, Matthew Wilcox wrote:
> On Mon, Aug 17, 2026 at 04:53:08PM +0200, Jan Kara wrote:
> > On Tue 11-08-26 14:16:31, vova tokarev wrote:
> > > Matthew, Christian, Pedro,
> > > 
> > > Lol - fair point, I'll keep the reggaeton references out of future
> > > commit messages.
> > > 
> > > Agreed on severity - but this is a
> > > killpriv invariant violation, and the kernel has treated those as
> > > security fixes worth backporting before.
> > 
> > I tend to agree this would be good to fix for consistency as much as I also
> > don't think this is a particularly serious issue. Removing SUID bits on
> > write is more of a hardening measure than serious security guarantee and is
> > there mostly for historical reasons AFAIK from the old Unix days.  POSIX
> > for write(2) mentions this as: "Upon successful completion, where nbyte is
> > greater than 0, write() shall mark for update the st_ctime and st_mtime
> > fields of the file, and if the file is a regular file, the S_ISUID and
> > S_ISGID bits of the file mode may be cleared." truncate(), chmod(), chown()
> > have similar notes. No mention of this when handling mmap BTW :).
> > 
> > Anyway, the problem with calling __file_remove_privs() when writing through
> > mmap is with the implementation - in particular the locking. To be able to
> > call __file_remove_privs() we need to hold i_rwsem and that ranks above VMA
> > locks / mmap_lock we hold during the page fault. Now that I'm speaking
> > about it I even have a vague recollection this has already come up in the
> > past and we've just decided to leave it alone due to these technical
> > difficulties.
> 
> Perhaps we could just do it at mmap() time rather than waiting for the
> first fault?  Obviously only for MAP_SHARED / PROT_WRITE.  I could see
> an unenlightened interpreter doing unnecessary MAP_SHARED / PROT_WRITE
> mappings, so that might not fly.

Yes, I'd be afraid of userspace regressions here.

> We could also do it within filemap_fault() (and shmem_fault()).  If the
> fault is a write and the suid bit is set, drop the locks, clear the suid
> bit and return VM_FAULT_RETRY.  We already do that if we need to do
> readahead, so it's a well-tested path.

Yeah, right, dropping the locks + VM_FAULT_RETRY would do it given how
rare case that should be. Except we can have faults without
FAULT_FLAG_ALLOW_RETRY (generally from GUP callers) for which we cannot do
this... :-|

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
