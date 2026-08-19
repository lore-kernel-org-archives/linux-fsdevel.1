Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A1F4052CD;
	Wed, 19 Aug 2026 10:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787135932; cv=none; b=gxu9WS8C1/6M8s2AkIupYvYS8nKoUdasF3vm8YnKbw/bps/eec6wgL/53sh1aamxVzvEf/b/GDzdEuHnrIKcc8iRVmcvdNXl3nMLptaRrKb3eCR0LmlxYDZDkr4uGgNxwpoE4L/yl3J/CELvnrICA1je2fpQBLde2It6ySDKa5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787135932; c=relaxed/simple;
	bh=ZdBXKv0tmCnHcqrNg6Cyo0zxThNDZuTVNf/R9goL0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2Oh6uhXEw6+/OmTNFvqfl5XDn60Jsx71+cFGXe1XwTUsq6zXjGSMIyKfkR5DwF12vwWLEiLjvVsD/8NxEYksu7vGQ7RBpqzIlTyTbeJbCY1g7gGT/oeNPvj3gfrkDL5ML08dBlUc4S4II048qgtGGS42pSQ9hsIpku1sUQVTdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=iVD/4Cp5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=aTzsLFv3; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mgovgj49; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=NFjcIplH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="iVD/4Cp5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="aTzsLFv3";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mgovgj49";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="NFjcIplH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 44FB084A92;
	Wed, 19 Aug 2026 10:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787135924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v++ePnllGB7jQcdK/4IlYL0dLfyVmV3SrOMPLDqxA/Q=;
	b=iVD/4Cp5MgtI2q2JRuXglb5i4OnjDtOiZVe6SZ1x+dzgwnTF+WWSW9hVinnLTt/PMIOLTN
	gdSm89HoGec20DHHV8H5eRlguDFN9mSbRIhM/2t1N7Tsotdb5hrCdTJcbr25zfBcj5Kj2U
	x0AlBzMwc6zN5AH7vSJxRa4t4rWtBQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787135924;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v++ePnllGB7jQcdK/4IlYL0dLfyVmV3SrOMPLDqxA/Q=;
	b=aTzsLFv3IOizPYI3W2zd7k2xaqckTMkDZRGW95KjcDYXdeSYjwTvS4YC8r6IJuup8l8Xmv
	eDSqdYjh8EF9KMCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787135920; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v++ePnllGB7jQcdK/4IlYL0dLfyVmV3SrOMPLDqxA/Q=;
	b=Mgovgj49FAimkPaIFmHfqixuZgisNSBeepX6UN6oao0XCucPh7ffnbdT7JVvOHE/QrDNY7
	GWewaWJBl+oHa3iO2v/j9njRRMykIVYTULd+qsHlcrhhTrc8h1M13DdoBkMNiu68c507OU
	alY8PKhtlpTtLhgfTKvNEtplzVOs33Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787135920;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=v++ePnllGB7jQcdK/4IlYL0dLfyVmV3SrOMPLDqxA/Q=;
	b=NFjcIplHV8Lp3d9H4cKbPfbeV4oejIsUoDs49NZduCozj+A0rzjS5N/nT6bwWBxJoHvfvd
	vX56Hcbe1Vrw2wDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C0B62F81;
	Wed, 19 Aug 2026 10:38:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GoWjDrCHhWrqIAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 19 Aug 2026 10:38:40 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CF662A13B2; Wed, 19 Aug 2026 12:38:35 +0200 (CEST)
Date: Wed, 19 Aug 2026 12:38:35 +0200
From: Jan Kara <jack@suse.cz>
To: Ayhan Aydin <nsd.project.dev@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache
 prefetcher
Message-ID: <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org>
 <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nsd.1787001235.35928@mail.gmail.com>
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spam-Level: 

On Mon 17-08-26 21:13:55, Ayhan Aydin wrote:
> On Mon, Aug 17, 2026 at 06:22:46PM +0200, Jan Kara wrote:
> > I can see how SQLite table scans could be improved but I'm really surprised
> > by the 64k sequential buffered read. That's basically what the current
> > readahead logic is built for. So how is the sync readahead you trigger
> > better than what generic async readahead does?
> 
> Hi Honza,
> 
> Thanks for the careful question. This is exactly the workload the
> generic readahead was built for, so I was equally surprised at first.
> Let me share what we measured and how we explain it.
> 
> We reran the benchmarks with a strict A/B methodology: interleaved
> ON/OFF passes on the same machine, drop_caches before every pass, and
> the OFF state verified through the module's own counters (no prefetch
> activity during OFF passes).
> 
> Seq 64K buffered read (2 GB file, 3 interleaved passes):
> 
>   OFF: 396, 400, 396 MB/s   (avg 397 MB/s)
>   ON:  483, 507, 508 MB/s   (avg 499 MB/s)  -> +25.7%
> 
> To answer how the sync readahead we trigger can beat generic async
> readahead, we traced the IO requests actually submitted to the device
> (block_rq_issue, filtered to the reader task) in both modes:
> 
>   OFF: 16,385 requests, median size 128 KiB  (100% in the 64 to 128 KiB band)
>   ON:   8,195 requests, median size 256 KiB  (100% above 128 KiB)
> 
> In the OFF case, the generic readahead keeps issuing fixed 128 KiB
> windows (the default read_ahead_kb) for the entire 2 GB run. It never
> grows beyond that. When NSD is enabled, it detects the sequential
> pattern and expands the readahead window to 256 KiB, then delegates
> the actual page insertion to page_cache_sync_readahead(). The kernel
> then issues half the requests, each twice as large, which is what this
> SSD prefers (about +27% throughput here).

Ah, OK, thanks for the details. So the default 128k read_ahead_kb is the
culprit. We know it for a long time this default is too low for modern HW
so most distro's actually tune this to 1m or similar in their default
configurations. If you tune read_ahead_kb to 1m, does the difference for
sequential read go away? And what about SQLite?

> In other words, NSD does not bypass or reimplement the kernel
> machinery. It tunes the ra_state window that the existing readahead
> code then acts upon.

Yes, understood.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
