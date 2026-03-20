Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611AD3C2792
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774016331; cv=none; b=X8HpM5pFpsJDgSzl80u+6YJ8w2hh4PiMVCtTyZWCCmzQO5a/bTL8jYS3FfV08yugPmteGvJnEe5QMdTQoYPjhEFelX2S9lqVshyOk5TmF6cUWg4nk2V41YbHsxQRvdXWwayF3qz8yLSGaXVf4ruSDrZDkIgg6awQYhzOVzJaSw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774016331; c=relaxed/simple;
	bh=bXih8vp/0PG9vkLDOAYLTHybQrQMMvKrPro4MZzpkZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H00bHE9Kyu0Wm10zCaoiyO4hHXyznNz1VaQugpcjnYVmru23tdEptDagB+98XRAMWJ6JRKV8PK5/SVqcBLLfJwlcUJY8ENGGKgLSZe5zxm1VOGwPY9wNjXoGJSnWRDm1zSTTTmky9X0y8bAa8kINnqbOV+4Lt+NG8Xm+4HAS/Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlm/XzM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJ2pv+05; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qlm/XzM8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sJ2pv+05; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlm/XzM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJ2pv+05";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qlm/XzM8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sJ2pv+05"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F04414D277;
	Fri, 20 Mar 2026 14:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774016326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgY6jfJC4I6lO/ZNgUgQPgQbvfgbEiK5mwVmPbXvrBQ=;
	b=qlm/XzM8k7qpds2rq9lDHrqs/Z/wFeov19N9OPFrQBDs2mREGY40jdCVHyR4gD01EXn4uV
	2I4PcIGDRnDJx0A98NMeV8DmjjBs/edU2vsVF9BpGT5v7O+4KFjtKXpR/+gsaLyBW7AhR3
	8oA5M+wtYz1Xf/Xr9CD/H86P1jEs7IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774016326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgY6jfJC4I6lO/ZNgUgQPgQbvfgbEiK5mwVmPbXvrBQ=;
	b=sJ2pv+05ecVbycZvzjP2XbL3oTqMmNo2hFgO7Iqq68GwzKxJKh2Oi4vMMozaeb557KPToW
	C0iXBJzrR9cyE/Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774016326; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgY6jfJC4I6lO/ZNgUgQPgQbvfgbEiK5mwVmPbXvrBQ=;
	b=qlm/XzM8k7qpds2rq9lDHrqs/Z/wFeov19N9OPFrQBDs2mREGY40jdCVHyR4gD01EXn4uV
	2I4PcIGDRnDJx0A98NMeV8DmjjBs/edU2vsVF9BpGT5v7O+4KFjtKXpR/+gsaLyBW7AhR3
	8oA5M+wtYz1Xf/Xr9CD/H86P1jEs7IM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774016326;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zgY6jfJC4I6lO/ZNgUgQPgQbvfgbEiK5mwVmPbXvrBQ=;
	b=sJ2pv+05ecVbycZvzjP2XbL3oTqMmNo2hFgO7Iqq68GwzKxJKh2Oi4vMMozaeb557KPToW
	C0iXBJzrR9cyE/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E116D4283D;
	Fri, 20 Mar 2026 14:18:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2O/uNkVXvWmRMAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 20 Mar 2026 14:18:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 99B39A0A81; Fri, 20 Mar 2026 15:18:45 +0100 (CET)
Date: Fri, 20 Mar 2026 15:18:45 +0100
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	ajd@linux.ibm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	mhocko@suse.com, npache@redhat.com, pasha.tatashin@soleen.com, 
	rmclure@linux.ibm.com, rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@quack3, ziy@nvidia.com, hannes@cmpxchg.org, 
	kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v2 1/4] mm: bypass mmap_miss heuristic for VM_EXEC
 readahead
Message-ID: <er6pfnbasao53shfs3vwznosqy4k74tjh4lxcegzwgdaweahdu@vgkhrdrhv5oe>
References: <20260320140315.979307-1-usama.arif@linux.dev>
 <20260320140315.979307-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320140315.979307-2-usama.arif@linux.dev>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[37];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	R_RATELIMIT(0.00)[to_ip_from(RLx3ed8f7q4e9s3nf3mrauhj48)];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo,linux.dev:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Fri 20-03-26 06:58:51, Usama Arif wrote:
> The mmap_miss counter in do_sync_mmap_readahead() tracks whether
> readahead is useful for mmap'd file access. It is incremented by 1 on
> every page cache miss in do_sync_mmap_readahead(), and decremented in
> two places:
> 
>   - filemap_map_pages(): decremented by N for each of N pages
>     successfully mapped via fault-around (pages found already in cache,
>     evidence readahead was useful). Only pages not in the workingset
>     count as hits.
> 
>   - do_async_mmap_readahead(): decremented by 1 when a page with
>     PG_readahead is found in cache.
> 
> When the counter exceeds MMAP_LOTSAMISS (100), all readahead is
> disabled, including the targeted VM_EXEC readahead [1] that requests
> large folio orders for contpte mapping.
> 
> On arm64 with 64K base pages, both decrement paths are inactive:
> 
>   1. filemap_map_pages() is never called because fault_around_pages
>      (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
>      requires fault_around_pages > 1. With only 1 page in the
>      fault-around window, there is nothing "around" to map.
> 
>   2. do_async_mmap_readahead() never fires for exec mappings because
>      exec readahead sets async_size = 0, so no PG_readahead markers
>      are placed.
> 
> With no decrements, mmap_miss monotonically increases past
> MMAP_LOTSAMISS after 100 page faults, disabling all subsequent
> exec readahead.
> 
> Fix this by excluding VM_EXEC VMAs from the mmap_miss logic, similar
> to how VM_SEQ_READ is already excluded. The exec readahead path is
> targeted (one folio at the fault location, async_size=0), not
> speculative prefetch, so the mmap_miss heuristic designed to throttle
> wasteful speculative readahead should not apply to it.
> 
> [1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 6cd7974d4adab..7d89c6b384cc4 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3331,7 +3331,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		}
>  	}
>  
> -	if (!(vm_flags & VM_SEQ_READ)) {
> +	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
>  		/* Avoid banging the cache line if not needed */
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss < MMAP_LOTSAMISS * 10)
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
