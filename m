Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011C1330D22
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Apr 2026 12:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776254775; cv=none; b=iLsZ69yQajryyzdqFtVZOSUL54wp9R/K4CLTu3vQfgNNZ2QBpKFxAq1hivVMcXd2qQoe539hn4bq5NPB3/Epf9JxQLPK815s3alpR2w4ahOvrqWCCXlTnCAy3cAMgyXxcB1pgqyWqsf7cp/pAsj62ZQXEWMOZ15rkaBUli5Ynbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776254775; c=relaxed/simple;
	bh=oivVK4g43Oy9lFrueU1FXPmt1pEJ70zmyNZaF+Orijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiSzAiAcNwNHEdiSD2yiJGHvPstUQFktdSVetur2BYdVXw18ig7GWyEZ9OoElGoA4dadVj8wSsCva3PSeYpz0dSYbynOTCr/pPwxC2vma+cnMsEgL9ABD4YN7pkIp9X5y6dtDiV34LQ7xAtrYKt+Ko9VPOJmAXHfjFwNUWM8Igc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JhjMDbpc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9TzG1hZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JhjMDbpc; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9TzG1hZ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JhjMDbpc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9TzG1hZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JhjMDbpc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9TzG1hZ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 607AF6A7E2;
	Wed, 15 Apr 2026 12:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776254772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC95RKCSCi9LVrg1A8un9ES6lp7MegYkrQ18OXExBbc=;
	b=JhjMDbpc2lU9/UB8R7Xr/Y4op4IjOAEy58l7zPCyS1zO3143XIN5+vldCGxg0k+nnKlUxU
	YWyuCW3jKPHNUjRWEub8nJrT9S/VF/pAGh/+X8oHBxauSZ4VeHNNc8JMXL7TF//2VycV8N
	f8xIIx/DlqAbNMuiQKmbHayWwHPQh2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776254772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC95RKCSCi9LVrg1A8un9ES6lp7MegYkrQ18OXExBbc=;
	b=D9TzG1hZmdWBcb4rhaXwoDbJIIF05o1vfaGJbFQaAnp3uwh5xGoHyBwRSgCUpQFFdomaGr
	SUBO0bIW7SHyvGCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776254772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC95RKCSCi9LVrg1A8un9ES6lp7MegYkrQ18OXExBbc=;
	b=JhjMDbpc2lU9/UB8R7Xr/Y4op4IjOAEy58l7zPCyS1zO3143XIN5+vldCGxg0k+nnKlUxU
	YWyuCW3jKPHNUjRWEub8nJrT9S/VF/pAGh/+X8oHBxauSZ4VeHNNc8JMXL7TF//2VycV8N
	f8xIIx/DlqAbNMuiQKmbHayWwHPQh2I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776254772;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dC95RKCSCi9LVrg1A8un9ES6lp7MegYkrQ18OXExBbc=;
	b=D9TzG1hZmdWBcb4rhaXwoDbJIIF05o1vfaGJbFQaAnp3uwh5xGoHyBwRSgCUpQFFdomaGr
	SUBO0bIW7SHyvGCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 31A534B9CF;
	Wed, 15 Apr 2026 12:06:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R52vCDN/32mlEgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Wed, 15 Apr 2026 12:06:11 +0000
Date: Wed, 15 Apr 2026 13:06:09 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Anatoly Stepanov <stepanov.anatoly@huawei.com>
Cc: willy@infradead.org, akpm@linux-foundation.org, david@kernel.org, 
	ljs@kernel.org, Liam.Howlett@oracle.com, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, wangkefeng.wang@huawei.com, 
	yanquanmin1@huawei.com, zuoze1@huawei.com, artem.kuzin@huawei.com, 
	gutierrez.asier@huawei-partners.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] filemap: use high-order folios in filemap sync RA
Message-ID: <3cr6ppe6bic47tan2iapuh67s67hiroangvdiap4jbn7ypru2o@rbvqv3sxifwp>
References: <20260415192853.3470423-1-stepanov.anatoly@huawei.com>
 <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415192853.3470423-3-stepanov.anatoly@huawei.com>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Thu, Apr 16, 2026 at 03:28:53AM +0800, Anatoly Stepanov wrote:
> [Idea]
> 
> If a mmap'ed file being accessed such that async RA never
> kicks in, we might end up with only 0-order folios in the page cache.
> 
> if fault_around_bytes is larger than 1 single page, then
> it's beneficial to use high-order folios, which brings significant
> filemap_map_pages() speedup.
> So, let's just use fault_around_bytes as a starting point here.

Well, this heuristic looks arbitrary. I don't like to mix different concepts.

With this, in practice most file folios will be 64K. Why? Why is it related
to faultaround when faultaround is a separate mechanism that isn't particularly
relevant here?

> 
> if an arch supports PTE-coalescing we can get more of those for free.
> (see arm64 example below)
> 
> We don't save the new order to "ra->order", so if async RA will happen
> it would normally start from order-0.
> 
> [Things to be discussed]
> 
> But at the same time, i can see drawback for 16K, 64K pages, in this case fault_around will still be 64K by default.
> In this case, it seems makes sense to make the fault_around_bytes be like order-N of PAGE_SIZE, not fixed bytes number.
> 
> Another issue is - when fault_around=0, but we'd like to use high-order folios for sync_RA, for cont-PTE for example,
> For this we can use kind of "max(fault_around_order, cont_pte_order)".
> 
> Or introduce some dedicated tunable like "sync_mmap_order".
> 
> [Benchmark]
> 
> Simple benchmark below reading 100M file in 4M (RA size) chunks
> such that async RA doesn't kick in and the page cache ends up being
> filled up with 0-order folios.

Well, the problem is that you are _never_ getting RA to kick in. Folio
size is the least of your concern, you are effectively not doing much
readahead since the kernel thinks you're doing random accesses.
> 
> The patched kernel gives ~3 times increase in throughput,
> considering the page cache is filled up at the moment.
> 
> The main speedup comes from filemap_map_pages() due to high-order
> folios usage.
> 
> As a bonus, we get better cont_pte bit coverage for Arm64.
> 
> Example:
> // Open 100M file and read every 4M chunk, given max_ra=4M
> // Perform 10 runs, measure the throughput.
> ...
>  char *map = mmap(NULL, filesize, PROT_READ, MAP_PRIVATE, fd, 0);
>     if (map == MAP_FAILED) {
>         perror("Error mapping file");
>         close(fd);
>         return 1;
>     }
> 
>     struct timespec start, end;
>     clock_gettime(CLOCK_MONOTONIC, &start);
> 
>     unsigned int size_4M = 4*1024*1024;
>     unsigned int num_reads = filesize / size_4M;
>     volatile char val;
>     for (int i = 0; i < num_reads; i++) {
>         off_t offset = (off_t)i * size_4M;
>         val = map[offset];
>     }

This doesn't seem like a real issue. And if it is, you can always issue
readahead manually. But the whole pattern of "every perfectly-sized RA
window, access 4 bytes and advance" is completely bizarre. And _if_ this
is your workload, then having order-0 folios at the read site is much better
than filling your page cache with data you are not accessing.

Do you have an actual use case for this? Where have you observed these
problems?

-- 
Pedro
