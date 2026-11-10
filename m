Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309918;
	b=zFNLuEUQIW2e8s8LJDzUuyartJcLzme0HN8SqfrXC9ozl8CJ7OJwKuJtBiXIYlc5TRTW
	 Yz/nsYqnWUAuWri8MpKLnBI0SM31D181W6jKmGio5Y3N/ccFaQgs39YSa9JOdciUQbRc8
	 RVk2DobomuYLxs7WVEmw+U/9kQzY5X2WWImG0mVvskjhERspUPuepCItRVBXl/pNJn1e0
	 hePwb2XA9qpbQJhnXDx/+b9n3k0OhszDDMLh4enYeZQhqO4Z+699SQPTxtt7Ba3Qx07BY
	 +CRbDNfdlrt+SOn+xlb/21jsBKsfQfsjF2efVRf7h3pU9qEIjDCrsfnbA9s1YF7wYgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309918;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=AuudWVgrS3U0W2Ftt+AqT6mImlT0GC7ZxcnFi16YT/M=;
	b=p78cBFYC3OBopGVsm/UQ00mCyBGL7o8vWar7EE4QFSuoiSRltRixrOipyxOGRrxGt266
	 aRDzhnWCkMk3vAntQvWN7ZjsUj7r/DrbMCNQOcrL45ubIjk5yaX9de1o1zpfr2Q2VBTLX
	 erL8kMGP+xhqPuzKWS9/LFufDmIIhMfVnaAozyftPE8RAiJMNC35P2aKTOXfd/ivw5t6G
	 ojRh0W2j33rv9vG9nzuXc9t21f4PVzlwMvRWmdKthaX07WwJXnitxCOfLHLygRJuY6FYs
	 L8Ir5Fo+RXnCpr5T7VI65c7c8tHGGryg7NQTyVIHXJupNoEGkrq+XyLicTn/dDPfK0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j6U0B5x4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SerslcNO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ye6SrqMU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nupH0Gw0;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86E060A3818;
	Tue, 10 Nov 2026 11:25:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E86E060A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j6U0B5x4;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SerslcNO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ye6SrqMU;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=nupH0Gw0
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E399C1F7D9;
	Tue, 10 Nov 2026 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794309916; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuudWVgrS3U0W2Ftt+AqT6mImlT0GC7ZxcnFi16YT/M=;
	b=j6U0B5x4LMEF2SqldUZ6WxGzciuHvpc4XKOQfSwA0jlM+Ngq3gqlLwdx0U7k99r6K1YgTx
	jDmT0ToxeqhQ5MhnFOTxqMLupcalIlGwySTIkUwm9S557ue/oomLSn8W6Z0VO0caP5lR57
	kcQBQfIAs3Lv+LELjQKVWOABCxQ6BS0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794309916;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuudWVgrS3U0W2Ftt+AqT6mImlT0GC7ZxcnFi16YT/M=;
	b=SerslcNOHfjDDAH8G69EmoWXx/SdtWHShxQ5iGsseiz2FpcDxcMWA3d0+oDrgcHlVxole5
	MYYCbgJQAtW9HyBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Ye6SrqMU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nupH0Gw0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794309915; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuudWVgrS3U0W2Ftt+AqT6mImlT0GC7ZxcnFi16YT/M=;
	b=Ye6SrqMULx+MGMKXtvnn8CDcR/nANw6pzsd6c2htNEZ03gV1WLqnJFR8TysAS0B5A6nmSr
	GBiUvW2s8no48CwxY6mZXOIFpq8+67DMSjRlgp5LpPPkiOkmPUFdXP2ZFudpX2MuM2hy8c
	m/I6EwHvb46J/dWFL2nrg7NgSdmPmaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794309915;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AuudWVgrS3U0W2Ftt+AqT6mImlT0GC7ZxcnFi16YT/M=;
	b=nupH0Gw0To6sosww78CwUKyfabAeLUUaTu42aBQqe2aQBRcBHwT/toT4a67En2U2WzLtVZ
	K9u+O/q/RHoKfYDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0A6B13479;
	Tue, 10 Nov 2026 11:25:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fZNmIhr/8mpCZQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 10 Nov 2026 11:25:14 +0000
Date: Tue, 10 Nov 2026 11:25:13 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Seunghyun An <san55@wisc.edu>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, "Liam R . Howlett" <liam@infradead.org>, 
	Jann Horn <jannh@google.com>, Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Suren Baghdasaryan <surenb@google.com>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/rmap: use vm_pgoff for anonymous VMAs in
 linear_anon_page_index()
Message-ID: <avL5C_w-wo6bJJTj@pedro-suse.tail5790ac.ts.net>
References: <20261110000002.1834454-1-san55@wisc.edu>
 <20261110000002.1834454-2-san55@wisc.edu>
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
In-Reply-To: <20261110000002.1834454-2-san55@wisc.edu>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: E399C1F7D9

On Mon, Nov 09, 2026 at 06:00:01PM -0600, Seunghyun An wrote:
> __vm_anon_pgoff_hi sits right after vm_refcnt in the vm_refcnt
> cacheline. Since commit 93c0c8dc87f6 ("mm/rmap: use anon pgoff to track
> MAP_PRIVATE file-backed anon folios"), which made anon rmap use it,
> __folio_set_anon() reads it on every new anonymous folio, i.e. once per
> fault that maps a new anonymous page, between vma_start_read() and
> vma_end_read().
> 
> When several threads fault on the same VMA, the other CPUs keep writing
> vm_refcnt from vma_start_read()/vma_end_read(), so this read often
> misses and pulls the line over. The extra load can force a coherence
> transfer and makes the following vm_refcnt updates more expensive.
> 
> For anonymous VMAs the anonymous page offset is always equal to vm_pgoff
> (linear_anon_page_index() already asserts this under CONFIG_DEBUG_VM;
> it holds for MAP_PRIVATE /dev/zero too since commit e59c9a971a9f
> ("mm/vma: make MAP_PRIVATE-mapped /dev/zero mappings truly anonymous")),
> so compute the index from vm_pgoff as before. That brings back the
> pre-series behaviour for the hot path; MAP_PRIVATE file-backed VMAs still
> read the split field. Keep the assertion, the other way round.
> 
> Moving __vm_anon_pgoff_hi out of the line does not work without growing
> vm_area_struct. With e.g. CONFIG_ANON_VMA_NAME=y the struct is exactly
> 192 bytes, cachelines 0 and 1 have no hole, and the only 4-byte fields
> that could fill the slot next to vm_refcnt are vm_lock_seq and the lo/hi
> halves. vm_lock_seq is read before vm_refcnt is taken in vma_start_read(),
> so it would just move the miss.
> 

I trust Lorenzo knows more about his plans to use anon_pgoff than I do,
so I'll let him reply. A comment though:

> Measured on an AMD EPYC 9634 (84 cores, 12 CCDs, CONFIG_DEBUG_VM=n), on
> mainline after v7.4-rc1 (the base of this series). Threads share one
> anonymous VMA, each faults its own slice and zaps it with MADV_DONTNEED;
> faults/s, median of 3:
> 
>   CPUs                      base      patched
>   1 CCD,   7 threads        2.360M    2.369M   +0.4%
>   7 CCDs,  1 thread each    1.738M    1.982M  +14.0%

This is not particularly surprising. CCDs have their own L3 cache. I'm not
surprised the coherency penalty is much higher cross-CCD.

-- 
Pedro
