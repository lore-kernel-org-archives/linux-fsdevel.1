Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000EC2E975E;
	Thu, 24 Sep 2026 09:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241321; cv=none; b=JUoGM/QKxzz0GrKzXImQg9t2VXCouyMoCvJdRqo9EldJMjX3fj9gvL1YeWImsKg67//NC6pbDskbAldEwJ8KwvUrinnZCfPywuYV6D9GOlX3q3hXWB5hVCDLEUAA8fSrhB9V0poENWqY8tuLcvPJ5uhsVEwJ3DW+zUsRsCJaykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241321; c=relaxed/simple;
	bh=+PUubzI0fINoPw/KkQuegrOikmDbuEY/nHkZdFX5NZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUEzF6XbQ1rm9BjQ1TrfWNKeDVY4N1JLJQL7G0COmo8ZLTuIntoIqf8+QeuVNey+WVAtIGUw/CVl3IU42gTZzzVQ6f42eFH9wMVfTd6/iod729gzEJ4qUiRrZ0KYUiCAWl/3OSIgUenb8FPWToji9ygleAPcy9XgqmUpYXe/NB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E01EC20052;
	Thu, 24 Sep 2026 09:15:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9FE313668;
	Thu, 24 Sep 2026 09:15:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ycF/ISXqtGqqDgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 24 Sep 2026 09:15:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3AAA4A132E; Thu, 24 Sep 2026 11:15:09 +0200 (CEST)
Date: Thu, 24 Sep 2026 11:15:09 +0200
From: Jan Kara <jack@suse.cz>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Ayush Ranjan <ayushr@modal.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-ID: <uf7lys6izqrxjsp3tstqxmdok5yy3w52d3bnpkfzyjm7uiyqzr@ickbg3ocvcji>
References: <20260924061708.1645968-1-ayushr@modal.com>
 <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Queue-Id: E01EC20052
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]

On Thu 24-09-26 09:34:24, Pedro Falcato wrote:
> On Thu, Sep 24, 2026 at 06:16:21AM +0000, Ayush Ranjan wrote:
> > Here is my best understanding of the race -- corrections welcome:
> > 
> > shmem guards faults against an in-progress hole punch with
> > inode->i_private: shmem_fault() -> shmem_falloc_wait() waits while
> > shmem_fallocate(PUNCH_HOLE) holds i_private. But shmem's .map_pages
> > is the generic filemap_map_pages() (shmem_vm_ops /
> > shmem_anon_vm_ops), which does not consult i_private and does not
> > take invalidate_lock, and shmem does not use invalidate_lock to
> > serialize faults against truncation the way regular filesystems do --
> > the i_private + waitq scheme stands in for it, but only shmem_fault()
> > participates in that scheme.
> > 
> > So while shmem_fallocate(PUNCH_HOLE) is between
> > unmap_mapping_range() and shmem_truncate_range(), a concurrent
> > fault-around can (re-)install PTEs for folios that are about to be
> > truncated:
> > 
> >   - filemap_map_pages() samples mm_counter_file(folio) once per batch
> >     and applies it with add_mm_counter() after mapping; if the
> >     folio's swapbacked state changes while it is concurrently torn
> 
> But that cannot happen? We hold the folio lock in filemap_map_pages().
> The folio (naturally) cannot be torn down while we have the folio lock.
> 
> >     down, the map-time counter (MM_FILEPAGES) and the zap-time
> >     counter (MM_SHMEMPAGES) disagree by exactly one folio -- the
> >     +/-512 imbalance above.
> > 
> >   - a folio re-mapped in this window (by fault-around directly, or
> >     via a child VMA whose PTEs copy_page_range() installs after
> >     unmap_mapping_range() has already walked the i_mmap tree -- the
> >     dup_mmap() variant discussed in the earlier thread) can be
> >     deleted from the page cache while still mapped -> "still mapped
> >     when deleted".
> 
> No, I don't think this paragraph is true. Page cache truncation (via
> truncate, or fallocate PUNCH_HOLE) takes the folio lock for each folio
> that is about to be truncated out. Mapping folios takes the folio lock
> as well, except in the fork() case where a myriad of weird interval tree
> + PTE lock interactions make it safe (AIUI).

Can this be perhaps somehow related to the fixes in partial large folio
truncation Zhang Yi is working on, possibly even the tmpfs bug in handling
of folio split I've found [1]? It seems large folios are used here so that
matches, I just don't immediately see how those bugs would lead to the
errors reported here...

								Honza

[1] https://lore.kernel.org/all/5pthbyxtn7q6xi4fmkofvksmcjzfnujcw2g4fxmxjzfin5pbgf@zui3vcimb4cv

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
