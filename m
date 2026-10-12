Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDF840F746;
	Mon, 12 Oct 2026 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804463; cv=none; b=rXDw18t68tGb8KtWxCbvZrD81ONYCm/HLqBu5ksPX2IifZCx6uMrTWo8+jVm8YtjLT3IOpbTNodq7Q2gKFMbdIIt+E0jf/kCgPZd9iKJIwe6oBETwb1gyBdPgjWa0Nmz3EAqGpB6Ld0eZS+U47DCBAX9GVnSBnKan5WD8b7gqyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804463; c=relaxed/simple;
	bh=56QHLj/h7s0SVyVfNA++t+7gmv2QPEdOlJfVhyl+W0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkFbwhY+al3EYR/KMsxpIMrUeq558LnMTmYyupKtT26IFP0MWuwLIN087ycKMuB0GrYIDZo2o9p9Zn5ZK1Y6ufZx6O7nrUINI0w9o9JJ5Q6I9ZBB0lhRIe7hV+r8ZbK/2mdA1lQRtNao8wMYdldK6IE4Z4Oypk1HFJ5rnt9ZX9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FIiOfmm3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=19ePpgeE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pUZxb2+K; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=V2f7c6br; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FIiOfmm3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="19ePpgeE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pUZxb2+K";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V2f7c6br"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 32CFF21E6D;
	Mon, 12 Oct 2026 11:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791804460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7URtRlrLncshXlKL+R1mPLfjQj1qLjdYf9TgSXwUEA=;
	b=FIiOfmm3WiGwlbwlvmU/o7lh73JKxJk6jRrh4YnqzL1iKhn6kVrMkf0Cz4jTOLrn0pl9GL
	4cqss1QZ0s8gUAfTrYr4vDb+pCIaffQ3XTig69/cv0t4WHIbFq2dfylrgnkEbYzeUV9vvV
	+3ZXCwKp/03upxfIaCCcgsMDZiCV2Qw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791804460;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7URtRlrLncshXlKL+R1mPLfjQj1qLjdYf9TgSXwUEA=;
	b=19ePpgeE3U/db48kzgafY/O5xUlLkepuslhjp2tkcqxQjr9TnnkE+obaST50H+s2GBurQ2
	Nmmf3qWo/KpOsgCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pUZxb2+K;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=V2f7c6br
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791804459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7URtRlrLncshXlKL+R1mPLfjQj1qLjdYf9TgSXwUEA=;
	b=pUZxb2+K5f70i1geYgipjXtfMskAT4DzIOnaqfHKuIxpxjn8+u+3KVTHDG1raolhnxTgUV
	uXqEw4Ydqt9u1FF6BGY75AKg8useNVZ3hiMC+T+oBEEwtqFE3dtxusLwGuB3I5Mflc7G0P
	vToGH9G3tB8eRksZfETAMwixqoHwLFw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791804459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e7URtRlrLncshXlKL+R1mPLfjQj1qLjdYf9TgSXwUEA=;
	b=V2f7c6brHU9jkAKrdRDTFZagMzhHqj8YSaddNi+5kYphK7dV08VR+z07xnGfrgXNAKpmEW
	QbXOCghu39nNBFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5AF2613314;
	Mon, 12 Oct 2026 11:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DwC/CirEzGpnagAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 12 Oct 2026 11:27:38 +0000
Date: Mon, 12 Oct 2026 12:27:36 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Yifan Li <liyifan21@xiaomi.com>, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, mhocko@suse.com, 
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] mm: page_frag: account page_frag pages in vmstat
 and meminfo
Message-ID: <asy9PzW41-Wi0JXC@pedro-suse.tail5790ac.ts.net>
References: <20261010025941.1253-1-liyifan21@xiaomi.com>
 <40fc5d04-2a20-42c4-9557-7277bc981172@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40fc5d04-2a20-42c4-9557-7277bc981172@kernel.org>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 32CFF21E6D
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On Mon, Oct 12, 2026 at 12:36:35PM +0200, David Hildenbrand (Arm) wrote:
> On 10/10/26 04:59, Yifan Li wrote:
> > This is an RFC.
> > 
> > Pages held by the page_frag cache are not accounted by any memory
> > statistics counter, so on systems that derive "LostRAM" as MemTotal
> > minus the sum of accounted memory they inflate LostRAM and lead to
> 
> Sorry, what exactly is subtracted from MemTotal?
> 
> How would any other kernel allocations be treated?

I suppose those would mostly show up as Slab:. But yes, I agree the metric
is a little dubious.

> 
> > misleading "leak" conclusions, even though the memory is legitimately
> > used by the network path.
> 
> Assuming "leak" in such scenarios is questionable, sorry.
> 
> Aren't most page_frag allocations short-lived? Or is this more about the
> page_frag cache?

page_frag allocations are kinda arbitrarily lived. If you queue (send) some
data to a socket to send over the wire, they are more likely than not
short-lived, unless the protocol/qdisc says no (for example, you're hitting
the TCP congestion window and as such can't send more data over the wire).
If you send it over loopback/veth you get arbitrarily livetimes as sockets
can keep the page frag alive if the application never reads them.

On the regular RX side you can also (AIUI) keep page frags randomly pinned
as long as you don't read them.

(note that all of these allocations are bounded by each protocol's memory
limits)


In any case, I remember an off-list discussion with mhocko regarding a
downstream bug, where I suggested adding a counter for this, and he said
networking is somewhat sensitive to extra accounting on the fast paths.
Added netdev in case they have comments.

> 
> > 
> > The page_frag allocator (page_frag_alloc / napi_alloc_frag /
> > netdev_alloc_frag) backs sk_buff->head and the frags portion of
> > skb_shared_info.  Unlike slab (NR_SLAB_*) or page_pool, page_frag
> > pages have no counter.  A preliminary measurement on a 4K-page
> > arm64 Android device shows 14432 kB (3608 pages) of page_frag
> > pages already in use at boot, and the memory footprint grows
> > larger under heavy load (e.g. sustained traffic through the
> > virtio_net / tun receive paths).
> > 
> > Patch 1/1 adds an NR_PAGE_FRAG node counter and exposes it as
> > nr_page_frag in /proc/vmstat and PageFrag in /proc/meminfo.  Pages
> > enter the cache through a single entry point
> > __page_frag_cache_refill(), so the increment side is complete; the
> > decrements sit on the paths that free the cache page.
> > 
> > The remaining gap is on the release side, which is open: a cache page
> > handed to an skb frags array (skb_add_rx_frag() /
> > skb_fill_page_desc(), without an extra get_page) is freed via
> > put_page() (kfree_skb -> __skb_frag_unref -> put_netmem -> put_page),
> > bypassing page_frag_free(), so the counter can over-count under
> > network load.
> > 
> > Closing that needs the page to carry a marker checked at the common
> > free path, e.g. either
> > 
> >   1. a page flag: PAGEFLAG(PageFrag, page_frag, PF_HEAD), accounted
> >      and cleared in __free_pages_prepare(); or
> > 
> >   2. a page type: PGTY_page_frag reusing _mapcount, accounted in
> >      free_frozen_pages() (requires that page_frag pages are never
> >      mapped into userspace; true for the current RX paths).
> > 
> 
> Certainly no page flag.
> 
> A page type might be the right choice. I don't think Willy planned for that [1],
> IIUC, the bump allocator was something different, but another page type
> shouldn't hurt at this point.

A page type might not work, these pages _may_ need to be mappable. I know
that was an issue for page_pool (Yet Another Networking Page Allocator) + TCP
zero-copy RX using mmap.

Of course, if you have a page frag under PAGE_SIZE or misaligned then you can't map that.

-- 
Pedro
