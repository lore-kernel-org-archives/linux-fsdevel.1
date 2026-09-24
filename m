Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326F73F7877;
	Thu, 24 Sep 2026 08:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790238879; cv=none; b=RSnpj6fThFLsY5nJCXxBAL8dSrNgsqZH/uSjl9LwurSDO1eUvJtA9crJkqgD8dJp4dNRBc1CgFXcFKrQTZBRSyU/p5pR8+3cdp4fjBw6+QbUuzyejqdRbXUEDGQzdCTIMQAegH8Mt399nJaiN2MQWWl6Kf/0yEfyEJwgH1cNsRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790238879; c=relaxed/simple;
	bh=67gF+c/s9wiIFNPL2OiD6yiGnHKwFelbKfl5/TgkhvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jz6h3F7d1/iGgAmfHXZI+WOJI2t/t3kA8mYlZjGJ+nO5JH+jpy5gRjT8EV2/4eH+rDc9c2BgtmFihyYm1TznFpx8asAbngQFUqAhopRPH8iZT2no+MoUTTzVZWdGsQmImR+7cI+SeFc/ozvxwz52qWx2YrQp7MsETnSZbEVCbbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nlUMqdKT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=f/rXNRC7; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PYbSnZWu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=imv5WvY7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nlUMqdKT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="f/rXNRC7";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PYbSnZWu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="imv5WvY7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A185A20056;
	Thu, 24 Sep 2026 08:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790238870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/EHrVUOhbhknjDjl5OIhlbfKMkW9/0aMMdL/w2Spk=;
	b=nlUMqdKT2BVrImBSJG9kkvN6F9ToBKwX0sfXIQwmmNLxYLvDE2hXsDp+rPPd4TgG8Vq60U
	N3bUxwb50MxqYGAZTeyB0elGltSPhWlygShWWuitkSx8sFBBdbkGvaQjHw5dvTb/md7pe3
	oHLvvhhujc1XSvEReVEUs5wHuppuwB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790238870;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/EHrVUOhbhknjDjl5OIhlbfKMkW9/0aMMdL/w2Spk=;
	b=f/rXNRC7XB/nxrdZykyXO4C+JNrJVLCAchmcQqhEEqTBU7CYRRqzaqX5FMc0YF0o6REZVC
	Krf/icMy2Ut5WIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790238866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/EHrVUOhbhknjDjl5OIhlbfKMkW9/0aMMdL/w2Spk=;
	b=PYbSnZWuSCyOu/Iegg+qwYBaJgBw5ZuLQJRNH0K7b3yKLIhUKXeJHsZejvHSSIQ86R7uQX
	KBRjFvKmmcEfuArvgiYSE8lR3d859wQIdd5Oqbw62+sPT8iDsggrvDkShoKnIGxDWH7uRA
	3rHrOLwW0ag8KgYsfEaKve4Bg2/OpA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790238866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ls/EHrVUOhbhknjDjl5OIhlbfKMkW9/0aMMdL/w2Spk=;
	b=imv5WvY7xxCb/TH1dA7EQzvw4LeFBnEYJF5HbD+Co6p0RBCSkW2QV3FOHcxaT0T0YUA41H
	u2hvZv519u1HkzAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B52D313354;
	Thu, 24 Sep 2026 08:34:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OwQGIZHgtGqsYAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 24 Sep 2026 08:34:25 +0000
Date: Thu, 24 Sep 2026 09:34:24 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Ayush Ranjan <ayushr@modal.com>
Cc: Hugh Dickins <hughd@google.com>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, David Hildenbrand <david@kernel.org>, 
	Gregory Price <gourry@gourry.net>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [BUG] shmem: FALLOC_FL_PUNCH_HOLE vs fault-around race corrupts
 page cache / rss counters
Message-ID: <arTdLsBENhrpOyk-@pedro-suse.tail5790ac.ts.net>
References: <20260924061708.1645968-1-ayushr@modal.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924061708.1645968-1-ayushr@modal.com>
X-Spam-Level: 
X-Spam-Score: -4.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[patchew.org:url,imap1.dmz-prg2.suse.org:helo,pedro-suse.tail5790ac.ts.net:mid]

(please use the email I actually use for work, thanks; not sure how
you got to that one)

Hi,

On Thu, Sep 24, 2026 at 06:16:21AM +0000, Ayush Ranjan wrote:
> Hi,
> 
> We are seeing shmem/tmpfs page cache corruption on production hosts
> running a workload that punches holes in a memfd (hole-punch based
> memory reclaim) while other threads and forked children fault the
> same MAP_SHARED mapping. The kernel taints but does not oops:
> 
>   BUG: Bad page cache in process ...  pfn:...
>   page dumped because: still mapped when deleted
>   ...
>   dentry name(?): "memfd:..."
> 
> and, more frequently, a paired rss-counter imbalance when the mm is
> torn down, always exactly one PMD-order folio (512 pages):
> 
>   BUG: Bad rss-counter state mm:... type:MM_FILEPAGES  val:-512
>   BUG: Bad rss-counter state mm:... type:MM_SHMEMPAGES val:512
> 
> Seen on 6.12 and 6.18, x86_64, bare metal and VM, with
> /sys/kernel/mm/transparent_hugepage/shmem_enabled = always.
> 
> This looks like the same corruption Gregory reported in March, which
> as far as I can tell stalled without a fix; that report needed ~100
> ballooning VMs to reproduce:

Well, I thought (from the lack of replies) that it was probably a bug on
their side. Perhaps that's not true :/

> 
>   https://patchew.org/linux/20260326162611.693539-1-gourry@gourry.net/
> 
> The reproducer at the end of this mail trips it with a single memfd,
> no VMs or ballooning, within a few minutes on a large machine, so
> hopefully it makes the race easier to confirm (and to test a fix
> against).
> 
> Here is my best understanding of the race -- corrections welcome:
> 
> shmem guards faults against an in-progress hole punch with
> inode->i_private: shmem_fault() -> shmem_falloc_wait() waits while
> shmem_fallocate(PUNCH_HOLE) holds i_private. But shmem's .map_pages
> is the generic filemap_map_pages() (shmem_vm_ops /
> shmem_anon_vm_ops), which does not consult i_private and does not
> take invalidate_lock, and shmem does not use invalidate_lock to
> serialize faults against truncation the way regular filesystems do --
> the i_private + waitq scheme stands in for it, but only shmem_fault()
> participates in that scheme.
> 
> So while shmem_fallocate(PUNCH_HOLE) is between
> unmap_mapping_range() and shmem_truncate_range(), a concurrent
> fault-around can (re-)install PTEs for folios that are about to be
> truncated:
> 
>   - filemap_map_pages() samples mm_counter_file(folio) once per batch
>     and applies it with add_mm_counter() after mapping; if the
>     folio's swapbacked state changes while it is concurrently torn

But that cannot happen? We hold the folio lock in filemap_map_pages().
The folio (naturally) cannot be torn down while we have the folio lock.

>     down, the map-time counter (MM_FILEPAGES) and the zap-time
>     counter (MM_SHMEMPAGES) disagree by exactly one folio -- the
>     +/-512 imbalance above.
> 
>   - a folio re-mapped in this window (by fault-around directly, or
>     via a child VMA whose PTEs copy_page_range() installs after
>     unmap_mapping_range() has already walked the i_mmap tree -- the
>     dup_mmap() variant discussed in the earlier thread) can be
>     deleted from the page cache while still mapped -> "still mapped
>     when deleted".

No, I don't think this paragraph is true. Page cache truncation (via
truncate, or fallocate PUNCH_HOLE) takes the folio lock for each folio
that is about to be truncated out. Mapping folios takes the folio lock
as well, except in the fork() case where a myriad of weird interval tree
+ PTE lock interactions make it safe (AIUI).

> 
> Reproducer
> ----------
> 
> The race is on PMD-order folios, so khugepaged needs to scan
> aggressively (with the default 10s scan interval the punched ranges
> are not re-collapsed fast enough to reproduce quickly):
> 
>   echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled
>   cd /sys/kernel/mm/transparent_hugepage/khugepaged
>   echo 1    > scan_sleep_millisecs
>   echo 4096 > pages_to_scan
>   echo 511  > max_ptes_none
> 
>   cc -O2 -pthread -o repro repro_shmem_punch_race.c
>   for i in $(seq $(( $(nproc) / 3 ))); do ./repro 60 & done; wait
>   # watch: dmesg -w
> 
> On a 112-CPU host this trips within ~2-5 minutes; this capture is
> from 6.12.0-204.92.4.4.3.el9uek.x86_64:

Awesome that you have a reproducer! Have you reproduced this on a mainline
kernel? Enterprise kernels are not supported upstream.

In any case, I'll take a closer look ASAP.
 

-- 
Pedro
