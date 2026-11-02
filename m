Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656023;
	b=lWPGYe+NaTQY2Ll928dlF+MwXvvZY1qYVkkzARi8euNjER9kqvpEZFRirkDs+4MPdd7A
	 OojFKIKiG9Zh7K9jdTIIvMUAOqqmrFAYId6RyHB835zBTe7jt/yhsO7xQwZDCI5S/+uO8
	 jPZSZErLvv9KdzU4Bjx7VUKzeUJKOPL1JRqp1FUwcNu5IF/n0Wm/h0qlou+Z63rKfeDcV
	 +HBMXFRgv05W9dDvjCaEiPhpAXJnb1RPgV3XZ1cWDfKTyvf9iGqS7VkxrY/YSHdYBZAmc
	 r/6zCrFsYPGSG4xlsHjROaTwdmz4rJflJf7blz1Rt8EoFsuMnf9dvMfnmTgMSiCD5Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656023;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=umkgUxq2rfgJ8NLFTrV8RBmSaYpLglNk+AEj6kYyfO8=;
	b=mPhE65awh7Zarjh7pYM506ekiWT8OjLCSG/Yt1nQ9iS7jJecS9JscpfRrfP76pGbt8BI
	 gGNbTk7i5zNbPkyF2Vu4jE1NXM6Yeo3TmerqwjmLR/JPXHhS2uqsisG0fHSrEgf8zsJMq
	 oTQLSIX8KZ54aifcMYAXX1rfULSzRveF1j7iVfFSZvPuilnwWK/yJldneLTWAqS0vxibO
	 M3GQ0ZJbizPzzGhKnxahBiQcG7Gy0RGUp/RzcR+Vgdt6DOetCtA320LHVSqWmojxDnB1q
	 RNcQH/PdtAr1NUDGkFJzuzPggPTW+Kn2/Oyfnrq6gIcKLjDH9yY1DrZgMUfZcnR2tLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wlGuuBra;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YFal0Hsu;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wlGuuBra;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YFal0Hsu;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7069606D810;
	Mon,  2 Nov 2026 21:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7069606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wlGuuBra;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YFal0Hsu;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=wlGuuBra;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YFal0Hsu
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 34C491FB0B;
	Mon,  2 Nov 2026 21:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umkgUxq2rfgJ8NLFTrV8RBmSaYpLglNk+AEj6kYyfO8=;
	b=wlGuuBraz5HKRr2tw/43UB5Yuv+PiOe6oD78Gy2DExn6MmnICbnFIL0hnqgIYj55NjFn/h
	yyNAE+HMDOBWohS7eneAyQu3M3yJPh1DXvz6fU2T9cVx3MdCm0YO+JqxDaderAQlrU5YJ7
	Rm6CzGphWaw1sRyMOTjs0kKdzvKH8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umkgUxq2rfgJ8NLFTrV8RBmSaYpLglNk+AEj6kYyfO8=;
	b=YFal0HsuhA7TGhN4xzisVTmXdG7rgPHRTH67cFJF8HNhqCyqL7LPenFhPQ38Z6J/GDyOGc
	UXLd6y0VlguRo7Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umkgUxq2rfgJ8NLFTrV8RBmSaYpLglNk+AEj6kYyfO8=;
	b=wlGuuBraz5HKRr2tw/43UB5Yuv+PiOe6oD78Gy2DExn6MmnICbnFIL0hnqgIYj55NjFn/h
	yyNAE+HMDOBWohS7eneAyQu3M3yJPh1DXvz6fU2T9cVx3MdCm0YO+JqxDaderAQlrU5YJ7
	Rm6CzGphWaw1sRyMOTjs0kKdzvKH8lM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656021;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=umkgUxq2rfgJ8NLFTrV8RBmSaYpLglNk+AEj6kYyfO8=;
	b=YFal0HsuhA7TGhN4xzisVTmXdG7rgPHRTH67cFJF8HNhqCyqL7LPenFhPQ38Z6J/GDyOGc
	UXLd6y0VlguRo7Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08F12134B3;
	Mon,  2 Nov 2026 21:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DOPMN9QE6WqLAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:47:01 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id A9A36B16F; Mon, 02 Nov 2026 22:46:56 +0100 (CET)
Date: Mon, 2 Nov 2026 22:46:56 +0100
From: Jan Kara <jack@suse.cz>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm/shmem: remove truncated folios from the page cache in
 batches
Message-ID: <dru32b7k62tbur7kmk6vv52zd6jnglnzzz4pvhlsqez6smcjip@gjuh6fud4nir>
References: <20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com>
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
In-Reply-To: <20261029-bug-mm-shmem-undo-batch-v1-1-59b34212fe78@gmail.com>
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCPT_COUNT_TWELVE(0.00)[16];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO

On Thu 29-10-26 23:44:57, Qiliang Yuan wrote:
> truncate_inode_pages_range() takes the folios it finds out of the page
> cache with delete_from_page_cache_batch(), which takes the inode's
> i_lock and the i_pages lock once for each batch of up to
> FOLIO_BATCH_SIZE folios.
> 
> shmem_undo_range() calls truncate_inode_folio() on each folio instead,
> so filemap_remove_folio() takes and drops both locks once per folio.
> Truncating, punching or freeing a tmpfs file or memfd made of small
> folios, such as a large /dev/shm segment, pays for that on every page.
> 
> Clean each folio up as truncate_inode_folio() does, collect the ones to
> remove and take them out with delete_from_page_cache_batch(), which
> needs truncate_cleanup_folio() outside mm/truncate.c. Swap entries, and
> the folios kept when undoing a failed fallocate(), stay out of the
> batch. Dropping an 8 GiB file of 4K folios, median of five runs,
> averaged over two boots of each kernel, in a 32 vCPU VM:
> 
>                         before    after
>   ftruncate() to 0     1163 ms   913 ms
>   hole punch           1155 ms   914 ms
>   close() of a memfd   1161 ms   914 ms
>   unlink()             1162 ms   916 ms
> 
> Files of PMD-sized folios take 20-25 ms with or without this change.
> 
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
> To see it, fill and remove a large /dev/shm file:
> 
>   fallocate -l 8G /dev/shm/f && time rm /dev/shm/f

Looks sensible. Just one nit below. Otherwise feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

> @@ -1352,6 +1352,9 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  	index = start;
>  	while (index < end && find_lock_entries(mapping, &index, end - 1,
>  			&fbatch, indices)) {
> +		struct folio_batch remove;
> +
> +		folio_batch_init(&remove);
>  		for (i = 0; i < folio_batch_count(&fbatch); i++) {
>  			folio = fbatch.folios[i];
>  
> @@ -1363,9 +1366,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  				continue;
>  			}
>  
> -			if (!unfalloc || !folio_test_uptodate(folio))
> -				truncate_inode_folio(mapping, folio);
> -			folio_unlock(folio);
> +			if (!unfalloc || !folio_test_uptodate(folio)) {
> +				truncate_cleanup_folio(folio);
> +				folio_batch_add(&remove, folio);
> +			}
> +		}
> +		delete_from_page_cache_batch(mapping, &remove);
> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> +			folio = fbatch.folios[i];
> +			if (!xa_is_value(folio))

You can move this loop after folio_batch_remove_exceptionals() and drop
this condition.

> +				folio_unlock(folio);
>  		}
>  		folio_batch_remove_exceptionals(&fbatch);
>  		folio_batch_release(&fbatch);

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
