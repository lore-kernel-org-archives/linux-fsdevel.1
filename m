Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BC03CBE76
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Apr 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776852910; cv=none; b=iSEDVxtcMoJ3oXUVlGLETT6L6kLQZSnDb968NcI6AaUWYbjGD3GtvRTvcYepwccKvkBoxdfLqKB1kdx/JJe/GUU8jICs8GQrHewoPI/9LXI9uETnHjnQh0gBvT2A9yHligIbYKEaoUeJ8B0tiXuG5GhmqAY1egyMV2YsLVHTinY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776852910; c=relaxed/simple;
	bh=8TgFKRqk5H4NyuVok6jLov5dZq0GkX6+A7iDU4oAexo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=edt0yAr+N9dIhfo4IgTK3bPyfJH4BjJkDnuKN9npZDIJOEnFd+j1ZJhZpbsJzkQBKFlhg/KRbRrPkTiMdkAIYSMfbNyx7UbnEBk7OCoVukmqKtogQLY/0NcHhd0IlPtOlg5BO6swTWtRb4l7iU8PkL3TcLun8dlSc8lKyPIo7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yIseIFj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaKJR6FB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=2yIseIFj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=qaKJR6FB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yIseIFj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaKJR6FB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2yIseIFj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="qaKJR6FB"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 50EEA5BCEE;
	Wed, 22 Apr 2026 10:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776852906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+BDt9d73puNgLCqsjSH8JR3Iy9Bzj4q0jrj4OOX3pA=;
	b=2yIseIFjaai70KqONL6i3f4wcI6m01kvIxg8Ut3Oq/Bpydh8zZsi5VtTdJ/I/0+G7g4qh6
	y15NapIvqKwGLQzQiSDQXyO5Akk7T2QRYO1s452uHCtGHUMlD5khybqTZTEpM/8dakI8d0
	PlldcCSbQOowhwTqZfiQ75Ly8xJh5TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776852906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+BDt9d73puNgLCqsjSH8JR3Iy9Bzj4q0jrj4OOX3pA=;
	b=qaKJR6FBaoqh8xlaNAWIzeQBE4CkFfEYMNR5APnwIwydAFVrXGKgpW1eqWkTbOUEfhryhE
	iZ33FQ2/JosHK8DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776852906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+BDt9d73puNgLCqsjSH8JR3Iy9Bzj4q0jrj4OOX3pA=;
	b=2yIseIFjaai70KqONL6i3f4wcI6m01kvIxg8Ut3Oq/Bpydh8zZsi5VtTdJ/I/0+G7g4qh6
	y15NapIvqKwGLQzQiSDQXyO5Akk7T2QRYO1s452uHCtGHUMlD5khybqTZTEpM/8dakI8d0
	PlldcCSbQOowhwTqZfiQ75Ly8xJh5TQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776852906;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0+BDt9d73puNgLCqsjSH8JR3Iy9Bzj4q0jrj4OOX3pA=;
	b=qaKJR6FBaoqh8xlaNAWIzeQBE4CkFfEYMNR5APnwIwydAFVrXGKgpW1eqWkTbOUEfhryhE
	iZ33FQ2/JosHK8DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41112593AF;
	Wed, 22 Apr 2026 10:15:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iujbD6qf6GmRZQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 22 Apr 2026 10:15:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 09F49A0B60; Wed, 22 Apr 2026 12:14:58 +0200 (CEST)
Date: Wed, 22 Apr 2026 12:14:58 +0200
From: Jan Kara <jack@suse.cz>
To: Frederick Mayle <fmayle@google.com>
Cc: David Hildenbrand <david@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lorenzo Stoakes <ljs@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Kalesh Singh <kaleshsingh@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, android-mm@google.com, kernel-team@android.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: limit filemap_fault readahead to VMA boundaries
Message-ID: <q3gze6hnx4mtkpht5gdjfgo3csyf4rpbh3nlmq7r22ajyczgii@to5n6cfhoeaz>
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
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue 21-04-26 17:56:07, Frederick Mayle wrote:
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
> 
> A comprehensive performance evaluation hasn't been done, but, in
> addition to the anecdontal memory savings mentioned above, a benchmark
> was run with fio 3.38, showing neutral looking results:
> 
>     /data/local/tmp/fio --version
> 
>     fio --name=mmap_test --ioengine=mmap --rw=read --bs=4k \
>         --offset=1G --size=1G --filesize=3G --numjobs=1 \
>         --filename=testfile.bin
> 
>         Before: 4366.6 MiB/s (avg of 3459, 4592, 4613, 4697, 4472)
>         After:  4444.0 MiB/s (avg of 4633, 4655, 4511, 4571, 3850)
>                 +1.7%
> 
>     Same, with --ioengine=mmap --rw=randread
> 
>         Before: 445.6 MiB/s  (avg of 446, 447, 442, 452, 441)
>         After:  447.0 MiB/s  (avg of 447, 446, 446, 451, 445)
>                 +0.3%
> 
>     Same, with --ioengine=psync --rw=read
> 
>         Before: 3086.6 MiB/s (avg of 3122, 3094, 3066, 3094, 3057)
>         After:  3084.6 MiB/s (avg of 3039, 3103, 3103, 3084, 3094)
>                 -0.06%
> 
>     Same, with --ioengine=psync --rw=randread
> 
>         Before: 2226.4 MiB/s (avg of 2256, 2183, 2207, 2265, 2221)
>         After:  2231.4 MiB/s (avg of 2236, 2241, 2236, 2193, 2251)
>                 +0.2%
> 
> [1] https://lore.kernel.org/all/ivnv2crd3et76p2nx7oszuqhzzah756oecn5yuykzqfkqzoygw@yvnlkhjjssoz/
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Kalesh Singh <kaleshsingh@google.com>
> Cc: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: android-mm@google.com
> Cc: kernel-team@android.com
> Signed-off-by: Frederick Mayle <fmayle@google.com>

Looks good to me. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  include/linux/pagemap.h | 2 ++
>  mm/filemap.c            | 4 ++++
>  mm/readahead.c          | 5 ++++-
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index ec442af3f886..cc628050bc5e 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1366,6 +1366,7 @@ struct readahead_control {
>  	bool dropbehind;
>  	bool _workingset;
>  	unsigned long _pflags;
> +	unsigned long max_index; /* limit readahead to i<=max_index */
>  };
>  
>  #define DEFINE_READAHEAD(ractl, f, r, m, i)				\
> @@ -1374,6 +1375,7 @@ struct readahead_control {
>  		.mapping = m,						\
>  		.ra = r,						\
>  		._index = i,						\
> +		.max_index = ULONG_MAX,					\
>  	}
>  
>  #define VM_READAHEAD_PAGES	(SZ_128K / PAGE_SIZE)
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e636647100c..d2f6bef12f58 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3314,6 +3314,8 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  	bool force_thp_readahead = false;
>  	unsigned short mmap_miss;
>  
> +	ractl.max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
> +
>  	/* Use the readahead code, even if readahead is disabled */
>  	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
>  	    (vm_flags & VM_HUGEPAGE) && HPAGE_PMD_ORDER <= MAX_PAGECACHE_ORDER)
> @@ -3396,6 +3398,7 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
>  		 * mmap read-around
>  		 */
>  		ra->start = max_t(long, 0, vmf->pgoff - ra->ra_pages / 2);
> +		ra->start = max(ra->start, vmf->vma->vm_pgoff);
>  		ra->size = ra->ra_pages;
>  		ra->async_size = ra->ra_pages / 4;
>  		ra->order = 0;
> @@ -3438,6 +3441,7 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	}
>  
>  	if (folio_test_readahead(folio)) {
> +		ractl.max_index = vmf->vma->vm_pgoff + vma_pages(vmf->vma) - 1;
>  		fpin = maybe_unlock_mmap_for_io(vmf, fpin);
>  		page_cache_async_ra(&ractl, folio, ra->ra_pages);
>  	}
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 7b05082c89ea..95a424b2f3a3 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -324,6 +324,8 @@ static void do_page_cache_ra(struct readahead_control *ractl,
>  		return;
>  
>  	end_index = (isize - 1) >> PAGE_SHIFT;
> +	if (end_index > ractl->max_index)
> +		end_index = ractl->max_index;
>  	if (index > end_index)
>  		return;
>  	/* Don't read past the page containing the last byte of the file */
> @@ -471,7 +473,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  	pgoff_t start = readahead_index(ractl);
>  	pgoff_t index = start;
>  	unsigned int min_order = mapping_min_folio_order(mapping);
> -	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
> +	pgoff_t limit = min_t(pgoff_t, (i_size_read(mapping->host) - 1) >> PAGE_SHIFT,
> +				       ractl->max_index);
>  	pgoff_t mark = index + ra->size - ra->async_size;
>  	unsigned int nofs;
>  	int err = 0;
> 
> base-commit: db2a1695b2b6feb071b47b72e61d0359bf1524bf
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
