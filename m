Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997242D2381
	for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jul 2026 12:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946104; cv=none; b=EP5sRWXEngtzSaAy9g7zyw99QAO/HyLn3yfWDNvr0HN3qf5j5Wh+8IVqzCUSl7oLCo2dR+8mpVFRnmzXbMTQwlHZvXuK9cKOilB8OaGyK+AjsThQzuhjSKB6XBo+vAf8cSEGqZ3JjoxDJKpKX7MOAA+oKbyzKERrDyYoAgo2sfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946104; c=relaxed/simple;
	bh=LLDrxR5x3S5bjm3mn5B5xPzF9NguxfjQJclKkwOZdTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pf9mrRufsE6ovESo2ZbQLRR6OIa4N2+OH822GJKwQ5Q9UJArwtdXOxlVkZImxD1gEvYLi8hxQ/LyPBLjvGc4rCgYOFZWw3IMRe9eKGM46k9KU2FlsA8Nyi39M5Eu2lZdn5VkbuOXV3GcI7SjlR8vtXcl4SmcMIpRk3FiADKXKbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BgA5OoMN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ppcDWt9; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=BgA5OoMN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9ppcDWt9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BgA5OoMN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ppcDWt9";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="BgA5OoMN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9ppcDWt9"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7A780778E1;
	Mon, 13 Jul 2026 12:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783946100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLEMuqZPcJGrZO3zJMV+Qsrl55CeLMy3qyykPfbPs8=;
	b=BgA5OoMNiAYaqYoFDxAx4aseM1UNvk/ye3E5qhz4lGizPWv77ZU+kTmaadze+Ibr9hMW3/
	XhuMBhMOw7R/cR2aY5TSiPNKFhtIh2GBiembgS36mQNR85xLfIOpjU5d481TayU9Zraldq
	4jrEcOeo1jgzKUPZy7UgKtyi9tmrCXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783946100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLEMuqZPcJGrZO3zJMV+Qsrl55CeLMy3qyykPfbPs8=;
	b=9ppcDWt9xrvBRt4VK2PO9nI6ewReEelqf5hajuG/V3BEg0Tz/nOasFlzaaG9aDAFSnCetS
	6vScAeOKWl2BgUAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=BgA5OoMN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9ppcDWt9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1783946100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLEMuqZPcJGrZO3zJMV+Qsrl55CeLMy3qyykPfbPs8=;
	b=BgA5OoMNiAYaqYoFDxAx4aseM1UNvk/ye3E5qhz4lGizPWv77ZU+kTmaadze+Ibr9hMW3/
	XhuMBhMOw7R/cR2aY5TSiPNKFhtIh2GBiembgS36mQNR85xLfIOpjU5d481TayU9Zraldq
	4jrEcOeo1jgzKUPZy7UgKtyi9tmrCXw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1783946100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oHLEMuqZPcJGrZO3zJMV+Qsrl55CeLMy3qyykPfbPs8=;
	b=9ppcDWt9xrvBRt4VK2PO9nI6ewReEelqf5hajuG/V3BEg0Tz/nOasFlzaaG9aDAFSnCetS
	6vScAeOKWl2BgUAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72F03779AE;
	Mon, 13 Jul 2026 12:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TUgKHHTbVGpmNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 13 Jul 2026 12:35:00 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0727EA131A; Mon, 13 Jul 2026 14:35:00 +0200 (CEST)
Date: Mon, 13 Jul 2026 14:34:59 +0200
From: Jan Kara <jack@suse.cz>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Subject: Re: [PATCH] isofs: fix out-of-bounds page array access on empty
 zisofs block
Message-ID: <ashtj5ttoea4ktrb3jrqvtseleyoqjhhz3qkug5ihjdzqun6hq@q53fyrhupjal>
References: <20260712234150.3213467-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712234150.3213467-1-xmei5@asu.edu>
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,asu.edu:email,suse.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7A780778E1
X-Spam-Score: -4.01

On Sun 12-07-26 16:41:50, Xiang Mei wrote:
> zisofs_uncompress_block()'s empty-block fast path returns
> pcount << PAGE_SHIFT, ignoring the incoming poffset, unlike the
> decompression path which returns bytes produced relative to poffset.
> zisofs_fill_pages() uses that return to advance its page cursor, so when
> the zisofs block size is below PAGE_SIZE and a sub-page block leaves
> poffset partway into a page, a following empty block over-counts and
> advances pages[] one element past its end, after which
> "if (poffset && *pages)" reads pages[1] out of bounds.  rock.c only
> rejects a block-size shift > 17, so a crafted "ZF" Rock Ridge record can
> set it below PAGE_SHIFT; the bug is reached by an ordinary read() of a
> compressed file on such a mounted ISO9660 image.
> 
> Return the byte count relative to poffset and zero only
> [poffset, PAGE_SIZE) of the first page, matching the decompression path.
> The page-aligned case (poffset == 0) is unaffected.
> 
>   BUG: KASAN: slab-out-of-bounds in zisofs_read_folio (fs/isofs/compress.c:290)
>   Read of size 8 at addr ffff88800f5eac48 by task exploit/142
>    zisofs_read_folio (fs/isofs/compress.c:290)
>    read_pages (mm/readahead.c:184)
>    ...
>    filemap_read (mm/filemap.c:2814)
>    vfs_read (fs/read_write.c:574)
>    __x64_sys_pread64 (fs/read_write.c:769)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:94)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>   The buggy address is located 0 bytes to the right of the
>   allocated 8-byte region in the kmalloc-8 cache
> 
> Fixes: 59bc055211b8 ("zisofs: Implement reading of compressed files when PAGE_CACHE_SIZE > compress block size")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Thanks! I've added the patch to my tree.

									Honza

> ---
>  fs/isofs/compress.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/isofs/compress.c b/fs/isofs/compress.c
> index 397568b9c7e7..3fda92358e22 100644
> --- a/fs/isofs/compress.c
> +++ b/fs/isofs/compress.c
> @@ -65,12 +65,14 @@ static loff_t zisofs_uncompress_block(struct inode *inode, loff_t block_start,
>  	/* Empty block? */
>  	if (block_size == 0) {
>  		for ( i = 0 ; i < pcount ; i++ ) {
> +			unsigned int off = i ? 0 : poffset;
> +
>  			if (!pages[i])
>  				continue;
> -			memzero_page(pages[i], 0, PAGE_SIZE);
> +			memzero_page(pages[i], off, PAGE_SIZE - off);
>  			SetPageUptodate(pages[i]);
>  		}
> -		return ((loff_t)pcount) << PAGE_SHIFT;
> +		return (((loff_t)pcount) << PAGE_SHIFT) - poffset;
>  	}
>  
>  	/* Because zlib is not thread-safe, do all the I/O at the top. */
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
