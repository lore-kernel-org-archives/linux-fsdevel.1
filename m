Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793021146;
	b=3mQB6ox3by10nhk+xNL8+vEmXGhIu3f0DY4/V2rftiIUd6ijDUbMz0PR+7Htj/ot1xQj
	 rGw0d21e3+IZLmUfLzRjp1d/AfMpzCb1VuD0pzCqDSYnk0hddIrL4CFeYaVvSN0S9gS0t
	 t13H92FRp7Bpm3Ct5w/VaSxNsSDz8VM2FeJeQYT0G2aHJIGPVkMV2D3RCw/NYLBT0ZKU8
	 iALa2bO+vy29sXiOff/VSJT6RGGEDcfCvO5BlDbK9bQz3dr4OBi6t61yFE38eXxGlZ164
	 UH4qhFj1yScQKX2rM5vEzQuOMprc4mO+vpLvIYEPZuKj9D1uxMYtaJlh8DceQIKZSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021146;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=yRPCNA7q22mNYbPLjS+vxZpi/8u+Qm+QOc21SCkQ9tk=;
	b=Fm0caMYA13+wFY+9S6jO+634ubEdiOWxRCGA7wTKBmC9pqnhAGAymTEgO1hHqobr99sx
	 1iIa/R6L3rjDxj8Sqgli4UdTql3sSaoKOEE/anV0w5u2XdkuUuArUUIeBLYzF0ZJOV35Q
	 r8Gn+S2gIU6ByJf9hSxCm1ugo+k0RTeqPGaRe1d3tfh0xdVkWLazNyY2iB0w3CPRPmkpl
	 it3Awsr2i0ZObQXmfEhx/pC4sV519xTD5ltON7d/VwXNDkCLJwJj1UcJrnFG3I/lEckzw
	 GXGdcVkylBI1khrU7VBDiE4Q4QHtICpSyVwv4YUV/s8LkgkLl95cfqxk0LvOwPoTwlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OXuoreeF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6D0vMvDa;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OXuoreeF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6D0vMvDa;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61268606A31E;
	Mon, 26 Oct 2026 13:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61268606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OXuoreeF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6D0vMvDa;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OXuoreeF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6D0vMvDa
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A55F222EF;
	Mon, 26 Oct 2026 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRPCNA7q22mNYbPLjS+vxZpi/8u+Qm+QOc21SCkQ9tk=;
	b=OXuoreeFlFTH8oQICNZHe/5aaneDHnDEEK62Mx+VR8WyQ3vTEh1ib+DJ9NkqYg345EnLnG
	UBC1UdQJylhv4vRFlU5XvLs89oVTm1lkiDBAeMvqBTfGSj4xg/ACk8R/3yPoR4g1EFjU8n
	PrIbHovoWD3PPhl84HO5AgxpXlNMgjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRPCNA7q22mNYbPLjS+vxZpi/8u+Qm+QOc21SCkQ9tk=;
	b=6D0vMvDaE9d67fTH0ibs7NBChKNZ8ES2v7d+Io0T/NWF3lz+m+SsBLNYRKMCtkcS1uS7+4
	cn7LE22YETP6yBAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793021144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRPCNA7q22mNYbPLjS+vxZpi/8u+Qm+QOc21SCkQ9tk=;
	b=OXuoreeFlFTH8oQICNZHe/5aaneDHnDEEK62Mx+VR8WyQ3vTEh1ib+DJ9NkqYg345EnLnG
	UBC1UdQJylhv4vRFlU5XvLs89oVTm1lkiDBAeMvqBTfGSj4xg/ACk8R/3yPoR4g1EFjU8n
	PrIbHovoWD3PPhl84HO5AgxpXlNMgjA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793021144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yRPCNA7q22mNYbPLjS+vxZpi/8u+Qm+QOc21SCkQ9tk=;
	b=6D0vMvDaE9d67fTH0ibs7NBChKNZ8ES2v7d+Io0T/NWF3lz+m+SsBLNYRKMCtkcS1uS7+4
	cn7LE22YETP6yBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B3CD13408;
	Mon, 26 Oct 2026 13:25:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +MmFDNdU32pPcwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 26 Oct 2026 13:25:43 +0000
Date: Mon, 26 Oct 2026 13:25:41 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Ngoc Quy <ngocquy0700@gmail.com>
Cc: akpm@linux-foundation.org, liam@infradead.org, ljs@kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Muhammad Usama Anjum <usama.anjum@collabora.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs/proc/task_mmu: pin mm_users in do_pagemap_scan()
Message-ID: <at9Uv59VV4_R1lgH@pedro-suse.tail5790ac.ts.net>
References: <20261014095540.3261469-1-ngocquy0700@gmail.com>
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
In-Reply-To: <20261014095540.3261469-1-ngocquy0700@gmail.com>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, Oct 14, 2026 at 04:55:40PM +0700, Ngoc Quy wrote:
> The PAGEMAP_SCAN ioctl takes mmap_read_lock() on an mm obtained from
> /proc/<pid>/pagemap without holding a reference to mm_users.
> 
> proc_mem_open() deliberately grabs only mm_count, so a consumer that
> touches the address space has to call mmget_not_zero() first. Every
> other consumer in this file does -- m_start(), do_procmap_query(),
> show_smaps_rollup() and pagemap_read() -- but do_pagemap_scan() does
> not.
> 
> Without that reference the target can reach exit_mmap() concurrently,
> and exit_mmap() calls unmap_vmas() while holding mmap_lock only for
> reading, which does not exclude the scanner. For ordinary VMAs this is
> harmless, as free_pgtables() and remove_vma() run afterwards under
> mmap_write_lock. A shared hugetlb VMA is different: __hugetlb_zap_end()
> frees the VMA's hugetlb_vma_lock inside the read-locked phase.
> 
> walk_hugetlb_range() can therefore load vma->vm_private_data, have the
> lock freed underneath it, and then down_read() a freed rw_semaphore.
> The load happens before the freeing side clears the pointer, so this is
> a use-after-free and not a NULL dereference. Any unprivileged user can
> reach it with no huge pages configured, as hugetlb_reserve_pages()
> allocates the lock before the VM_NORESERVE early return.
> 
> Pin mm_users across the scan, the way the other consumers do. mmput()
> from the exiting task can then no longer reach exit_mmap() while a walk
> is in progress.
> 
> Fixes: 52526ca7fdb9 ("fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Ngoc Quy <ngocquy0700@gmail.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

-- 
Pedro
