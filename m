Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225C017BED0
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 13:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776864723; cv=none; b=udXxBoibNd/omxS6PISX9awJ93SrgExuFW/silvZnTVwOoU53PdjY73FmkYi46e+cgFusdfftQ9Ixc+Tbp+UMcgEzVkcL1GmpNW1sO9cJvCwUJlDB3PyzHjaY1XQ2Rf5OeaacrouN6Up7OQ/QUCEnHFOCOtkj5Q/DWZB+EUJNCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776864723; c=relaxed/simple;
	bh=CYtlt20qU+p/Wt2Yat/l9gbHpxtZGnNScgjjSJfdMt4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LsUlgp+4NU4BM9Xzthk1bgyhhIj3kLp+VmNmNJv7pRAsJyEk/OyOVpKQZoAcUP4IqL688eeX3fjbJmcfz9RpksS4AdAbfwNmrWgQn4tuALiv8/h05VJiLXzXqa9tbCDA0/yMScQ/lWIbLuzMk29xbZ7epRlJWD/59rQHI01G0Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vTn6Qv0m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TOumUbK5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vTn6Qv0m; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TOumUbK5; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vTn6Qv0m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TOumUbK5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vTn6Qv0m";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TOumUbK5"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7A3C65BCFD;
	Wed, 22 Apr 2026 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776864720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HN5zu3O5NDCQecYBdAFeRk5Pdxg7tAGVVxbVQYx75NM=;
	b=vTn6Qv0mp8OdfUcL7uE6xFLGQys4S5UwHgmui+9lNHAouwySzT6ZaHhowYIYUxVEsu9lEi
	Wwv1vAqgx95ohqjmy+nFNI+a2nnYYBitN1pCe78gqLxq9wfGx1qfG3aDiOJTHNEkI4CoFH
	yk73wPKrjdBsMfE2ZCs32iSJ8zHTFu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776864720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HN5zu3O5NDCQecYBdAFeRk5Pdxg7tAGVVxbVQYx75NM=;
	b=TOumUbK5YxSOQ8c512vsxMH64GZYBIuHtAZX2RRR/m/AqaW2rqBvXoJ1fZLw/eQx+Ld5vJ
	2t5xh/O15ueZjnCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vTn6Qv0m;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=TOumUbK5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776864720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HN5zu3O5NDCQecYBdAFeRk5Pdxg7tAGVVxbVQYx75NM=;
	b=vTn6Qv0mp8OdfUcL7uE6xFLGQys4S5UwHgmui+9lNHAouwySzT6ZaHhowYIYUxVEsu9lEi
	Wwv1vAqgx95ohqjmy+nFNI+a2nnYYBitN1pCe78gqLxq9wfGx1qfG3aDiOJTHNEkI4CoFH
	yk73wPKrjdBsMfE2ZCs32iSJ8zHTFu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776864720;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HN5zu3O5NDCQecYBdAFeRk5Pdxg7tAGVVxbVQYx75NM=;
	b=TOumUbK5YxSOQ8c512vsxMH64GZYBIuHtAZX2RRR/m/AqaW2rqBvXoJ1fZLw/eQx+Ld5vJ
	2t5xh/O15ueZjnCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5E813593AF;
	Wed, 22 Apr 2026 13:31:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id C0e/E8/N6GlzKwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 22 Apr 2026 13:31:59 +0000
Date: Wed, 22 Apr 2026 14:31:57 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Frederick Mayle <fmayle@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
Message-ID: <cxthb6g7tqgluwicuh7xc75i2bp27hjlrx3oreionu4duknk32@x4tmnklhvkfz>
References: <20260422005608.342028-1-fmayle@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422005608.342028-1-fmayle@google.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 7A3C65BCFD
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

On Tue, Apr 21, 2026 at 05:56:07PM -0700, Frederick Mayle wrote:
> When a file mapping covers a strict subset of a file, an access to the
> mapping can trigger readahead of file pages outside the mapped region.
> Readahead is meant to prefetch pages likely to be accessed soon, but
> these pages aren't accessible via the same means, so it fair to say we
> don't have a good indicator they'll be accessed soon. Take an ELF file
> for example: An access to the end of a program's read-only segment isn't
> a sign that nearby file contents will be accessed next (they are likely
> to be mapped discontiguously, or not at all). The pressure from loading
> these pages into the cache can evict more useful pages.
> 
> To improve the behavior, make three changes:
> 
> * Introduce a new readahead_control option, max_index, as a hard limit
>   on the readahead. The existing file_ra_state->size can't be used as a
>   limit, it is more of a hint and can be increased by various
>   heuristics.
> * Set readahead_control->max_index to the end of the VMA in all of the
>   readahead paths that can be triggered from a fault on a file mapping
>   (both "sync" and "async" readahead).
> * Limit the read-around range start to the VMA's start.
> 
> Note that these changes only affect readahead triggered in the context
> of a fault, they do not affect readahead triggered by read syscalls. If
> a user mixes the two types of accesses, the behavior is expected to be
> the following: if a fault causes readahead and places a PG_readahead
> marker and then a read(2) syscall hits the PG_readahead marker, the
> resulting async readahead *will not* be limited to the VMA end.
> Conversely, if a read(2) syscall places a PG_readahead marker and then a
> fault hits the marker, the async readahead *will* be limited to the VMA
> end.
> 
> There is an edge case that the above motivation glosses over: A single
> file mapping might be backed by multiple VMAs. For example, a whole file
> could be mapped RW, then part of the mapping made RO using mprotect.
> This patch would hurt performance of a sequential read of such a
> mapping, the degree depending on how fragmented the VMAs are. A usage
> pattern like that is likely rare and already suffering from sub-optimal
> performance because, e.g., the fragmented VMAs limit the fault-around,
> so each VMA boundary in a sequential read would cause a minor fault.
> Still, this would make it worse. See a previous discussion of this topic
> at [1].
> 
> Tested by mapping and reading a small subset of a large file, then using
> the cachestat syscall to verify the number of cached pages didn't exceed
> the mapping size.
> 
> In practical scenarios, the effect depends on the specific file and
> usage. Sometimes there is no effect at all, but, for some ELF files in
> Android, we see ~20% fewer pages pull into the cache.

Didn't Android have a gigantically modified RA window? Could this be why
you're seeing such large effects? Or is this no longer the case?

-- 
Pedro
