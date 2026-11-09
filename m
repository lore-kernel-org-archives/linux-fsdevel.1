Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233621;
	b=pmhMShsPDgXi/qzDBAJ6V/0WDsdLSKpMna+ug5GKj4eFQg7hlbC9sQ6AE+rduxbB9KZ3
	 h5vEZjZW86MWXyqJVBVh54yGNiBjkBkb6gjbllCDkO/57E3T+uxJVxnhF2Sz29BmRRYrT
	 SKx7FCc8BhPyX2seThfovZyWkixdU7PYOAeX/GgDehV8D8ioep7BeQoYKClJhOk7ZZv9O
	 XdSAyESGEyRBGenWw14IYI1aIkmI+61fhhK3nUKwjpv2BeJYlOVmX016YlpCS2vu5E9ck
	 jVCfOSrcMu0II6WRg5DiNSDRsYRmJ3mgFpbg9wSC46BZzWzRGha6faCm56kMq+A2/Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233621;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=9e78KPc8jahAevPotNvn6m1tw9CTzVGALrHqcnEIRm8=;
	b=fphAb72BRdCFMLzfXZeBKf/5LjcvY61yvclxpKgv1l8eLw0KIqIYjECQ7r+XwC3oEujg
	 2BfslWBZyfs48wav/RVR3+LM1ud4YBnieEa4Y7k6pZgpJwA/J5CDQRKvK1KvmXhCUWIDx
	 H6XJ9lJK8Ye73kFbliNoxd5Y8JMDsBJVhgjv3h/YEdkMJTGARdQ/bLvLHF2PEdZkIF2ni
	 +iyW7ZXZ4u1OSDm0yb1/OhiwXel+VVT397zCl+nNvHHK7303KgoXqyI1SlVdT5EwOjDrh
	 5GgmrTNl83yKkytYQ6fJ8TxxusmNhKidVw92J6jy74V6Xg+ZUT1NdpbDCJQXlTt/vlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ctW9LfKu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sgnxScPO;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ctW9LfKu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sgnxScPO;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203C4606A31C;
	Mon,  9 Nov 2026 14:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 203C4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ctW9LfKu;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sgnxScPO;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ctW9LfKu;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=sgnxScPO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 777461F7BE;
	Mon,  9 Nov 2026 14:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794233619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e78KPc8jahAevPotNvn6m1tw9CTzVGALrHqcnEIRm8=;
	b=ctW9LfKuSTMcAiN0bPE02eqSR2r4e+pePA2C1iCM/MZTACcal+F6SuXjhJNKthku7GM2Oa
	27y6SERccF5Nt4crrWi/yk+DEzmUAiRfp5EvetlPEZO/SYoNq+zTz8qXDgaH842ga9hAnV
	e+q8MWGq5RlVFsWki2yBf0FBGzpJO6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794233619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e78KPc8jahAevPotNvn6m1tw9CTzVGALrHqcnEIRm8=;
	b=sgnxScPOMPTqiKplWt1uH0MVtAlyjDY3axAhU5ZrcPD9hlDe/0FiPDIa5SCnJD0aAcFdhu
	aDNjHEvLskTxU4Bg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ctW9LfKu;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=sgnxScPO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794233619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e78KPc8jahAevPotNvn6m1tw9CTzVGALrHqcnEIRm8=;
	b=ctW9LfKuSTMcAiN0bPE02eqSR2r4e+pePA2C1iCM/MZTACcal+F6SuXjhJNKthku7GM2Oa
	27y6SERccF5Nt4crrWi/yk+DEzmUAiRfp5EvetlPEZO/SYoNq+zTz8qXDgaH842ga9hAnV
	e+q8MWGq5RlVFsWki2yBf0FBGzpJO6s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794233619;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9e78KPc8jahAevPotNvn6m1tw9CTzVGALrHqcnEIRm8=;
	b=sgnxScPOMPTqiKplWt1uH0MVtAlyjDY3axAhU5ZrcPD9hlDe/0FiPDIa5SCnJD0aAcFdhu
	aDNjHEvLskTxU4Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C43F13319;
	Mon,  9 Nov 2026 14:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +AxLOw3V8WqDWQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 09 Nov 2026 14:13:34 +0000
Date: Mon, 9 Nov 2026 14:13:32 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v2 2/2] mm/memory: refuse to map page cache folios that
 are not uptodate
Message-ID: <avHUz0yxoQ2Ny4oH@pedro-suse.tail5790ac.ts.net>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-3-kas@kernel.org>
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
In-Reply-To: <20261109120403.82361-3-kas@kernel.org>
X-Rspamd-Queue-Id: 777461F7BE
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
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
	RCPT_COUNT_TWELVE(0.00)[16];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Mon, Nov 09, 2026 at 12:04:02PM +0000, Kiryl Shutsemau (Meta) wrote:
> A page cache folio that is not uptodate holds data that was never read
> in or cleared. shmem fallocate(2), for one, adds such folios and clears
> them only on first use. Mapping one hands userspace whatever the memory
> held before.
> 
> Each path that maps page cache checks for this itself: fault-around in
> next_uptodate_folio(), a fault in filemap_fault() or shmem_get_folio().
> Nothing in the mapping code does, so a caller that misses the check
> leaks stale memory silently. MADV_COLLAPSE did exactly that with
> fallocated shmem THPs until recently.
> 
> Warn and refuse the mapping in __do_fault() and do_set_pmd().
> 
> __do_fault() checks the folio ->fault() returned while it is still
> locked. do_shared_fault() unlocks it for ->page_mkwrite(), and a
> writeback error can clear PG_uptodate after that; that case retries the
> fault instead. For CoW, __do_fault() sees the page cache folio that
> do_cow_fault() copies from. do_set_pmd() covers MADV_COLLAPSE, which
> maps without a fault.
> 
> The fault gets SIGBUS, as for a folio that fails to read in.
> MADV_COLLAPSE fails and leaves the range to be faulted in.
> 
> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Awesome!

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
