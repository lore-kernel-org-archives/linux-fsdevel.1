Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955683AB5DA
	for <linux-fsdevel@vger.kernel.org>; Fri, 29 May 2026 09:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780048033; cv=none; b=QCJd68Fn9FfknMspyhv3vjm2SvgJ2TvE73afE3/8Bcqnkrm0DaJ/+vnMPFDMc84b7iSIP/B8mk4MKBwgkwIfK6J4H/XuVQ/I4f2fTzRPTLNWRRf03WKfGv1eOGR78/I3VDTg9C1QBrafHNz57e/t4Vcj9GAwaWKps1V+9Jn2s7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780048033; c=relaxed/simple;
	bh=Vh6QCSxKxYLYQ8WYqE+tO/dRk+70nWQLhhVqpOg3O8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kroA5+1NCcpYvZvoHrp3qS2n682ioWboev7yLJ8HT4IP+3JM8/srduAPafUHx3v/8S7kkfvYpEh6ht/aoKNLWa+aw0nLp5Yk5XKffI1ygLxYzvkVoaGOE/KUQy9XTNgycYNFDPbM0i0ef4YFG3bJ8siqoyHMpv7w9d5qiaiQVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HGWjvJ7k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBIn0Exj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HGWjvJ7k; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PBIn0Exj; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HGWjvJ7k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBIn0Exj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HGWjvJ7k";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PBIn0Exj"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B51776AD6B;
	Fri, 29 May 2026 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780048029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3Mx7+vtImpwG4SUbS85lLpmAFW5jV+p+rxF61HIx7M=;
	b=HGWjvJ7krjEkXrJgISz6Jki3tMYkNKr1W/Q5L2cQQeTufVF5blzAJVsGARnZ6PKnTiWf35
	J7Za4HjC8X9DiNfW7hJ/g+/Tk/q/B1cUrdG6HgQRNcw1DwniwgbH+9zc5ZApM2um/iR+ku
	d3HjYsQNbEnFe+VcmGVObpsbg7hQ9ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780048029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3Mx7+vtImpwG4SUbS85lLpmAFW5jV+p+rxF61HIx7M=;
	b=PBIn0ExjslQJyXzZPLnj2gbseuq37EaYuCGteX+fFnPce2Symkakm1vO7vO3STEvux+wcN
	koujOSmIG+w8MxBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HGWjvJ7k;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=PBIn0Exj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780048029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3Mx7+vtImpwG4SUbS85lLpmAFW5jV+p+rxF61HIx7M=;
	b=HGWjvJ7krjEkXrJgISz6Jki3tMYkNKr1W/Q5L2cQQeTufVF5blzAJVsGARnZ6PKnTiWf35
	J7Za4HjC8X9DiNfW7hJ/g+/Tk/q/B1cUrdG6HgQRNcw1DwniwgbH+9zc5ZApM2um/iR+ku
	d3HjYsQNbEnFe+VcmGVObpsbg7hQ9ZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780048029;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3Mx7+vtImpwG4SUbS85lLpmAFW5jV+p+rxF61HIx7M=;
	b=PBIn0ExjslQJyXzZPLnj2gbseuq37EaYuCGteX+fFnPce2Symkakm1vO7vO3STEvux+wcN
	koujOSmIG+w8MxBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56767779A7;
	Fri, 29 May 2026 09:47:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HtzNEJtgGWqFZQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 29 May 2026 09:47:07 +0000
Date: Fri, 29 May 2026 10:47:05 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	willy@infradead.org, ryan.roberts@arm.com, linux-mm@kvack.org, r@hev.cc, jack@suse.cz, 
	Andrew Donnellan <andrew+kernel@donnellan.id.au>, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, brauner@kernel.org, catalin.marinas@arm.com, dev.jain@arm.com, 
	kees@kernel.org, kevin.brodsky@arm.com, lance.yang@linux.dev, 
	"Liam R. Howlett" <liam@infradead.org>, linux-arm-kernel@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, ljs@kernel.org, mhocko@suse.com, 
	npache@redhat.com, pasha.tatashin@soleen.com, rmclure@linux.ibm.com, 
	rppt@kernel.org, surenb@google.com, vbabka@kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, wilts.infradead.org@pedro-suse.lan, ziy@nvidia.com, 
	hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH v6 1/2] mm: bypass mmap_miss heuristic for VM_EXEC
 readahead
Message-ID: <ahlgda3xJ587eSCg@pedro-suse.lan>
References: <20260528165635.2068012-1-usama.arif@linux.dev>
 <20260528165635.2068012-2-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528165635.2068012-2-usama.arif@linux.dev>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: B51776AD6B
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	URIBL_BLOCKED(0.00)[suse.de:email,suse.de:dkim];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[37];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[kernel];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL764437jfm1qe6abtk9nwyx8m)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pedro-suse.lan:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim,linux.dev:email]

On Thu, May 28, 2026 at 09:55:19AM -0700, Usama Arif wrote:
> The mmap_miss heuristic is intended to stop speculative mmap readahead
> when a file looks like a random-access workload. That does not fit the
> VM_EXEC path very well.
> 
> VM_EXEC readahead is already constrained differently from ordinary mmap
> read-around: it is bounded by the VMA, uses exec_folio_order() to choose
> an order useful for executable mappings, and sets async_size to 0 so it
> does not create follow-on readahead. When VM_HUGEPAGE is also present,
> the larger readahead is an explicit userspace opt-in.
> 
> The mmap_miss counter is decremented from cache-hit paths in
> do_async_mmap_readahead() and filemap_map_pages(). Those paths are not
> always enough to balance the synchronous miss increments for executable
> mappings. In particular, when fault-around is effectively disabled, such
> as configurations where fault_around_pages is 1, filemap_map_pages() is
> not reached from the fault path. The counter can then become a stale
> throttle for VM_EXEC mappings and suppress the readahead behavior that
> the executable-specific path is trying to provide.
> 
> Skip both mmap_miss increments and decrements for VM_EXEC mappings,
> matching the existing VM_SEQ_READ treatment and keeping the counter
> accounting symmetric.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

This is reasonable, thanks.

> ---
>  mm/filemap.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index cca20e350c95..a16b33e0fc71 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3339,7 +3339,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		}
>  	}
>  
> -	if (!(vm_flags & VM_SEQ_READ)) {
> +	if (!(vm_flags & (VM_SEQ_READ | VM_EXEC))) {
>  		/* Avoid banging the cache line if not needed */
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss < MMAP_LOTSAMISS * 10)
> @@ -3434,12 +3434,12 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	 * times for a single folio and break the balance with mmap_miss
>  	 * increase in do_sync_mmap_readahead().
>  	 *
> -	 * VM_SEQ_READ mappings skip the mmap_miss increment in
> +	 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss increment in
>  	 * do_sync_mmap_readahead(), so skip the decrement here as well to
>  	 * keep the counter symmetric.
>  	 */
>  	if (likely(!folio_test_locked(folio)) &&
> -	    !(vmf->vma->vm_flags & VM_SEQ_READ)) {
> +	    !(vmf->vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss)
>  			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> @@ -3941,14 +3941,14 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		 * Don't decrease mmap_miss in this scenario to make sure
>  		 * we can stop read-ahead.
>  		 *
> -		 * VM_SEQ_READ mappings skip the mmap_miss increment in
> -		 * do_sync_mmap_readahead(), so skip the decrement here as
> -		 * well to keep the counter symmetric.
> +		 * VM_SEQ_READ and VM_EXEC mappings skip the mmap_miss
> +		 * increment in do_sync_mmap_readahead(), so skip the
> +		 * decrement here as well to keep the counter symmetric.
>  		 */
>  		if ((map_ret & VM_FAULT_NOPAGE) &&
>  		    !(vmf->flags & FAULT_FLAG_TRIED) &&
>  		    !folio_test_workingset(folio) &&
> -		    !(vma->vm_flags & VM_SEQ_READ)) {
> +		    !(vma->vm_flags & (VM_SEQ_READ | VM_EXEC))) {
>  			unsigned short mmap_miss;
>  
>  			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
> -- 
> 2.52.0
> 
> 

-- 
Pedro
