Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDF71A9B58
	for <linux-fsdevel@vger.kernel.org>; Sat, 18 Apr 2026 11:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776512198; cv=none; b=rDqT4yiN97JH8mWAVf3jAWYOj1cEIhLOvtkzP0Hl7+agAkVc9mmFReY+Y3fFRjsO1n8L4SehyZf9Z6+KyDIu11BxXSfPQ4DnUwjHoZHgHn+gRrHl/tqs9Kf057hNOGECezMSKh8Bbv/TtAaxfruj26Ng7QDZAUnF19mM25rTC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776512198; c=relaxed/simple;
	bh=DBSmOQ0lt+PIK2UzNdAkOk105u6Qp/8Zmj6+ET1Pba8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKwQwyGeedwufd7vLabH8ET4opDUEDoYo1waqmhWWg/ihrJbCLXl5hBXnRTGBd34HqisGvtOmhzbb8+KKOFNkhWqZxu+IEwYrJQGwvwthWOQ6UvnYsw2ZfJOUEm58TdFWuzcFWrreA8QvfkbhggMz3tDevaVf0gSjFDeLadzyac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gHqfgZE1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=u6z6+eIR; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=PNgRib58; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4ad5LqYS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gHqfgZE1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="u6z6+eIR";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="PNgRib58";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4ad5LqYS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E6BA76A89B;
	Sat, 18 Apr 2026 11:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776512194; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiJVdueEI1VGaM1noMxVkb1Z/uVNyItb5fyKasD6qss=;
	b=gHqfgZE1Pxje6eVDy1UDxGeieegd0ecpmGeI7/hFYTqHT5VJmGxhcvLmuRc75cLCovj0LV
	jsVe9++M3HdWfYxFRcuCqwz+fewvYKqnHF5wJApfWmmrGDZZIIbSMSfvm7hoA9V/pISDZ0
	ut9DOd0V/Nwi9k+I/Glk0KV6IjcZkG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776512194;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiJVdueEI1VGaM1noMxVkb1Z/uVNyItb5fyKasD6qss=;
	b=u6z6+eIRGQlJWGMQ3LRG7+HH7YLQZu+CJm9YSHVyRa8hPHOq6T21r6gakFqQDI6HX0izzS
	9QCwccIxhDvhKtDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776512192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiJVdueEI1VGaM1noMxVkb1Z/uVNyItb5fyKasD6qss=;
	b=PNgRib5858WxWPmBX41BcINcjmWJ8clnDdH90bOZFwRceHm9KGnJa28BwbWtnyKeKQAV2o
	XK93cKeMr61d3rAHkjQI6/1H+eeIU8qJJioaiNoCbVSBazsfZzEq4NpQw7yuFTmT/67Yap
	e8dcmGXw1aLXyZLG47QWnDHAdgrcGQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776512192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WiJVdueEI1VGaM1noMxVkb1Z/uVNyItb5fyKasD6qss=;
	b=4ad5LqYS2LfntwFdOf/UyzxhetDDNqQ83zR4JbkJgtCHWae25KtIq7PvQbnMMJ11dPYBl5
	RCBB2wXbRDjHilAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D6A49593A3;
	Sat, 18 Apr 2026 11:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EZBgNMBs42lXXAAAD6G6ig
	(envelope-from <jack@suse.cz>); Sat, 18 Apr 2026 11:36:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 90CC1A0B3C; Sat, 18 Apr 2026 13:36:28 +0200 (CEST)
Date: Sat, 18 Apr 2026 13:36:28 +0200
From: Jan Kara <jack@suse.cz>
To: Zizhi Wo <wozizhi@huaweicloud.com>
Cc: viro@zeniv.linux.org.uk, jack@suse.com, brauner@kernel.org, 
	bcrl@kvack.org, axboe@kernel.dk, linux-fsdevel@vger.kernel.org, 
	linux-aio@kvack.org, linux-kernel@vger.kernel.org, wozizhi@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com
Subject: Re: [PATCH] fs: aio: reject partial mremap to avoid
 Null-pointer-dereference error
Message-ID: <5cjnsfdi4ztbocdpmsb57tswekn6g72op2khwvdl24nq6uaovt@zfsvt5mouetq>
References: <20260418060634.3713620-1-wozizhi@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260418060634.3713620-1-wozizhi@huaweicloud.com>
X-Spamd-Result: default: False [-0.30 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -0.30
X-Spam-Level: 

On Sat 18-04-26 14:06:34, Zizhi Wo wrote:
> From: Zizhi Wo <wozizhi@huawei.com>
> 
> [BUG]
> Recently, our internal syzkaller testing uncovered a null pointer
> dereference issue:
> BUG: kernel NULL pointer dereference, address: 0000000000000000
> ...
> [   51.111664]  filemap_read_folio+0x25/0xe0
> [   51.112410]  filemap_fault+0xad7/0x1250
> [   51.113112]  __do_fault+0x4b/0x460
> [   51.113699]  do_pte_missing+0x5bc/0x1db0
> [   51.114250]  ? __pte_offset_map+0x23/0x170
> [   51.114822]  __handle_mm_fault+0x9f8/0x1680
> ...
> Crash analysis showed the file involved was an AIO ring file. The
> phenomenon triggered is the same as the issue described in [1].
> 
> [CAUSE]
> Consider the following scenario: userspace sets up an AIO context via
> io_setup(), which creates a VMA covering the entire ring buffer. Then
> userspace calls mremap() with the AIO ring address as the source, a smaller
> old_len (less than the full ring size), MREMAP_MAYMOVE set, and without
> MREMAP_DONTUNMAP. The kernel will relocate the requested portion to a new
> destination address.
> 
> During this move, __split_vma() splits the original AIO ring VMA. The
> requested portion is unmapped from the source and re-established at the
> destination, while the remainder stays at the original source address as
> an orphan VMA. The aio_ring_mremap() callback fires on the new destination
> VMA, updating ctx->mmap_base to the destination address. But the callback
> is unaware that only a partial region was moved and that an orphan VMA
> still exists at the source:
> 
>   source(AIO):
>   +-------------------+---------------------+
>   |  moved to dest    |  orphan VMA (AIO)   |
>   +-------------------+---------------------+
>   A                 A+partial_len        A+ctx->mmap_size
> 
>   dest:
>   +-------------------+
>   |  moved VMA (AIO)  |
>   +-------------------+
>   B                 B+partial_len
> 
> Later, io_destroy() calls vm_munmap(ctx->mmap_base, ctx->mmap_size), which
> unmaps the destination. This not only fails to unmap the orphan VMA at the
> source, but also overshoots the destination VMA and may unmap unrelated
> mappings adjacent to it! After put_aio_ring_file() calls truncate_setsize()
> to remove all pages from the pagecache, any subsequent access to the orphan
> VMA triggers filemap_fault(), which calls a_ops->read_folio(). Since aio
> does not implement read_folio, this results in a NULL pointer dereference.
> 
> [FIX]
> Note that expanding mremap (new_len > old_len) is already rejected because
> AIO ring VMAs are created with VM_DONTEXPAND. The only problematic case is
> a partial move where "old_len == new_len" but both are smaller than the
> full ring size.
> 
> Fix this by checking in aio_ring_mremap() that the new VMA covers the
> entire ring. This ensures the AIO ring is always moved as a whole,
> preventing orphan VMAs and the subsequent crash.
> 
> [1]: https://lore.kernel.org/all/20260413010814.548568-1-wozizhi@huawei.com/
> 
> Signed-off-by: Zizhi Wo <wozizhi@huaweicloud.com>

Looks good! Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/aio.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/aio.c b/fs/aio.c
> index a07bdd1aaaa6..48d049ff5267 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -369,7 +369,8 @@ static int aio_ring_mremap(struct vm_area_struct *vma)
>  
>  		ctx = rcu_dereference(table->table[i]);
>  		if (ctx && ctx->aio_ring_file == file) {
> -			if (!atomic_read(&ctx->dead)) {
> +			if (!atomic_read(&ctx->dead) &&
> +			    (ctx->mmap_size == (vma->vm_end - vma->vm_start))) {
>  				ctx->user_id = ctx->mmap_base = vma->vm_start;
>  				res = 0;
>  			}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
