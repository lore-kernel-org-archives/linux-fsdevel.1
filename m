Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E79498921;
	Mon, 21 Sep 2026 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789994212; cv=none; b=GbUkOexaBWd93Iwlx7YH11DvBUjuUClvUvp1acg8xhotD2hN9ASGTCNVSLpxFBljS8EZooGE0EpGOCv678enljgrf/alWFehwim2yvZ90e3dABJpUN395LceZ16ozIxA+FHfFdGl2cnHaqLAzV5Hj2B4SpETrzrrNfrnGXC43xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789994212; c=relaxed/simple;
	bh=B2lUr6zFuI1tOzoihbpvAp+HxvFfKN4QaVW3YerzlYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JZXeJf0zd5GuaYnbnblEzwpHNoijxVuu3EuDjJMp7IeiNIgEAdxILi4cHNOAB4xw7IxbGwIOz+ImjF3lQ9KR/BDf66mg4vOJ/cpeJKmBxj5lfysd9qP9p/6Vc/6YKjJSydAXmzmyIfRAgPSWnHB9ykq6mEYSRi4GmHw5o9fg0As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HKVQrNyW; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=OD9EmZus; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cHHrtVLq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CSecNRpc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HKVQrNyW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="OD9EmZus";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cHHrtVLq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CSecNRpc"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31FFA1F79C;
	Mon, 21 Sep 2026 12:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789994190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmKS7vgZjryTeBZ+ib7L48JK7MuFB51dHdQeosw3LQk=;
	b=HKVQrNyW0PujYUrfNIOmuleTTSxxTpFxmY8ftBGt3h7T4CNzL0bnb2b9+bNQ2BQCGshM/g
	DWrJX2ipGhw+f0ez89lE3mzVUpaB7hyCm9ZuOxWPTECUleJ7QhsjjgifO3FkqTMqbGt4ag
	EWZ2nWgYa3up3Ks4A+F/WJgtbQ6W254=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789994190;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmKS7vgZjryTeBZ+ib7L48JK7MuFB51dHdQeosw3LQk=;
	b=OD9EmZusZV0ghtKl3GVXtAhKF796oMJvfJl2KALuwhm9BBdfkyeBngkI5Vv4FLOsZ7rdUo
	PCkm5OmJ11RWxNCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cHHrtVLq;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CSecNRpc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789994186; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmKS7vgZjryTeBZ+ib7L48JK7MuFB51dHdQeosw3LQk=;
	b=cHHrtVLqY1veO2gvOxhdj29S6Ykkt5fi4s8Ju8EMh850xgEPdd2gWjLJK16JdNLD+456AA
	jh/dSaO0BuimasECzYrd13F6zGPTbecPLvjlRQYrPBiOk9ABMPL3uBXhIyLCHK9Qt0kEpP
	SVXZ/laSHvpa/msD/LWwv5ckuduntW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789994186;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KmKS7vgZjryTeBZ+ib7L48JK7MuFB51dHdQeosw3LQk=;
	b=CSecNRpc0BOLGYO4qK3Xc2+1nIvCVfFI6XHUaAXzALOxJvdC0/MND1spvgcxpwX6afDUfw
	YCjrJqitCopj0vAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91FAD13793;
	Mon, 21 Sep 2026 12:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id swsyGMkksWrpRwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 21 Sep 2026 12:36:25 +0000
Date: Mon, 21 Sep 2026 13:36:23 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: ayhan =?utf-8?B?YXlkxLFu?= <nsd.project.dev@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] Neural Storage Driver - learning page cache
 prefetcher
Message-ID: <arEkgM15qewERAOJ@pedro-suse.tail5790ac.ts.net>
References: <20260725182628.221603-1-nsd.project.dev@gmail.com>
 <CAFLp9PEQQVuDpJPwrNvLN1-u3w3TMwZPUUrf0+rOBrvDjBBf1A@mail.gmail.com>
 <anlByPDZmvEhWeXI@casper.infradead.org>
 <ffcij36vnozf3rginqd2opd2dwqyki7xhtdo4veuty734hhgba@utjav2k263o6>
 <nsd.1787001235.35928@mail.gmail.com>
 <w7vte4itudtkw2yf4vbmuofiumfffmp2y52dpu2bqvqtdgjvpd@5femyiozss3e>
 <CAFLp9PGkVYZcQT5qAx-RKFOF-urZ92m417zpAeF7ZQempbS1HQ@mail.gmail.com>
 <o5ihhfa252cjfspqlag65xhnmehz3a5feyclmlyy4xlrcmceck@njmhyu7oom3d>
 <CAFLp9PF+6KUY7ZAGQZ_X9AN4VYbkdW_aDk1QSth3ZAVVqLTqsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLp9PF+6KUY7ZAGQZ_X9AN4VYbkdW_aDk1QSth3ZAVVqLTqsQ@mail.gmail.com>
X-Spam-Score: -3.01
X-Rspamd-Queue-Id: 31FFA1F79C
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pedro-suse.tail5790ac.ts.net:mid,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Can you please reply with something that isn't copied straight out of an LLM?
And, ideally, add the Assisted-by: LLM's where necessary.

On Sun, Sep 20, 2026 at 03:39:20PM -0700, ayhan aydın wrote:
> Hi Honza, hi Willy,
> 
> First, my Aug 20 follow-up bounced on the HTML part. My mistake, resending
> as plain text. Below is that content updated with six more weeks of
> measurement. Two self corrections first, before any numbers.
> 
> What changed since the RFC (same out of tree module):
> Automated prefetch never exceeds ra_pages now. Overhangs get trimmed
> or dropped, all counted. The only exception is our own measured
> willneed ranges up to io_pages. That follows Ming Lei's RFC direction
> and the MADV_POPULATE precedent. It is toggleable, Mod A means strict cap.
> 
> Fault path first, as you asked in Q3. filemap_fault hook observes, then
> prefetches with depth capped at 2 and bounded by the cap. One more
> thing on this: the fault path stands down explicitly at 1M windows and
> up. There is a straight s_bdi->ra_pages check in nsd_process(). The
>   parity we see at 256K and 512K is a different thing. Our code still
>   fires there. The kernel just catches up on its own at those sizes.
> 
> A sleeping in atomic bug in our fast path got found through a stack
> trace and fixed. vfs_fadvise was called from fprobe context. It now
> goes through a workqueue.
> 
> A len==0 fadvise footgun got found through our own counters. Len 0
> means to end of file, so those sends preloaded whole files. All our
> earlier big mmap and SQLite speedups traced back to it. Retracted.
> Sends with len 0 are now dropped and counted.
> 
> Narrowed claims after all that. Interleaved A/B, drop_caches before
> every run, checksums verified, 500+ runs in total:
> 
>   sparse mmap scan, about 64KB stride, 512MB to 20GB files, 128K window,
>   SSD: ON ~47s vs OFF ~88s median over 30+30 reps, no overlap.
>     The threshold lines up exactly with FAULT_AROUND_ORDER=4 (65536B).
>     Below it the kernel fault around covers the fault by itself.
>     Above it, it does not.
>   same setup at 256K, 512K, 1024K windows: parity, kernel catches up.
>   dense mmap, rand 4K, seq read, SQLite, THP, and HDD sparse mmap:
>   parity everywhere. The early small HDD lean got remeasured with
>   current code and traced to the same len 0 accident, retracted too.
>   No workload regresses. dmesg tracked throughout, no new warnings.
> 
> So the scope is sparse mmap scans at default size windows on
> SSD. That is where the fault path underprovisions while the read path
> is already saturated. Dense, random, 1M tuned and HDD cases are parity
> by measurement.
> Separately, one thing that might be useful here too: p99 tail latency
> is about 4x worse at 1M than at 128K regardless of NSD state. Another
> practical reason to keep windows small.
> 
> Open questions, updated:
>   Q1, fadvise beyond ra_pages: we stopped doing it silently. Only
>       measured willneed ranges up to io_pages, and that can be turned
>       off. Acceptable shape?
>   Q2, ra_state integration: we prototyped window steering from the
>       module. The kernel keeps our window but wall clock does not move
>       because there is just not enough volume from outside. Real
>       integration needs in kernel changes, so we drafted a minimal one:
>       2 stream slots plus stride state in file_ra_state, every window
>       bounded by ra_pages, read path only. Want me to post it separately
>       for direction feedback before any boot testing?
>   Q3: fault path first as described above, with timely versus correct
>       accounting running underneath.
> 
> For Willy: backward patterns get detected near perfectly (strides with
> negative deltas, counted separately) but they do not move the wall on
> SATA SSD, so throttled now. Fault path is covered as you asked.
> PG_readahead replacement stays an in kernel question as above.
> 
> Full data and the retraction notes are in the tree. Happy to run any
> counter matrix you ask for.
> 
> Thanks,
> Ayhan
> 

-- 
Pedro
