Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656020;
	b=C5Cm6zZ01gjRq1nSVYPpQzptQPzJb7n4ve6oiovwEUxq32UC3wr0Oad4WCDmd0mrkGsc
	 juL2WkQ5VNaozccp2SOZnonFSh+Z6iTnyuNzFcSsejujog7zbSP0AI1WhPgYu70F82e2Q
	 SSz3F2gmZrt2IwPiES1w+RTQv845Ulu/ZF3AJ/D5xMe3BkbkPL+wYftMceQ5jmLiCPO+x
	 k3kMiTDHb6+l6kCFQtY3Nn/X9NNkZBYukr4dcydZtnecY7Q+V/f9dM67dq16n32egqbma
	 +FIDfjOlC/6zIzVmP1t3BPGx5iWQHqgwIFD+k5iJ2k8epMI5sRWKMUq1VFjqtnOVX8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656020;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=xqTp4LSWoKogSLXQV1jsC4CAleeL27EeFUzHSOi+Tkg=;
	b=Qjrh/+68SbR2D+AmJCa+Q/+u8yBPGiBVLiAAYpQTKNR5Bh1j6zFNAuUGMvBz0Ok6Q9l5
	 1tRzk7AWwHu4IbcyXJbbNxYwpctFtTTbMHqRRobQRbejlY6CxZNXbiatBrYrbbKvq6G78
	 MCxhYIS+XBcWeF3KDfWtBlaa9VQ1YpZeC/FO7VG2zRUlHMmKjnfghzaYMO8eNqhpFEIai
	 whV5BYSJj++6d7kCyOo6QVap35AyfoEYfU6wHt0DvZGfj889EWXJptVD80haLc8grN0kY
	 N8zAsD7vTOemV34DeWO/wHC7ffGgIxrjluIxxtq4ASt8EdBCxGKa6Lq9qcB9y/1d/eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lAoHfyq2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9N+2PTBS;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lAoHfyq2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9N+2PTBS;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F01606A330;
	Mon,  2 Nov 2026 21:46:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75F01606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lAoHfyq2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9N+2PTBS;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=lAoHfyq2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9N+2PTBS
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 99A0721F8E;
	Mon,  2 Nov 2026 21:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqTp4LSWoKogSLXQV1jsC4CAleeL27EeFUzHSOi+Tkg=;
	b=lAoHfyq2YEWUia7YxQQobuDYwLg2VBOPGnIkdJZWeK6RLGQBYdE9i9p1mY89wd30XI88hL
	Iu6DjvsLIQps/2WZ9hsFEp8hXDVdMHfiUeZj+NjqmSY+C00PYTvcayX8OgcFPMHuwGhkYU
	ULMHtgBAaa47J6c0eTzYAmV+UdFwzwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqTp4LSWoKogSLXQV1jsC4CAleeL27EeFUzHSOi+Tkg=;
	b=9N+2PTBSCsTMROOcsHH7pk6wxwSC+Lge5ZM6Z9MOo14iVbHCPxrR3BTfDi/D3VqfUMzxv9
	rLnddyXEVM+DKrDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lAoHfyq2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9N+2PTBS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793656017; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqTp4LSWoKogSLXQV1jsC4CAleeL27EeFUzHSOi+Tkg=;
	b=lAoHfyq2YEWUia7YxQQobuDYwLg2VBOPGnIkdJZWeK6RLGQBYdE9i9p1mY89wd30XI88hL
	Iu6DjvsLIQps/2WZ9hsFEp8hXDVdMHfiUeZj+NjqmSY+C00PYTvcayX8OgcFPMHuwGhkYU
	ULMHtgBAaa47J6c0eTzYAmV+UdFwzwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793656017;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xqTp4LSWoKogSLXQV1jsC4CAleeL27EeFUzHSOi+Tkg=;
	b=9N+2PTBSCsTMROOcsHH7pk6wxwSC+Lge5ZM6Z9MOo14iVbHCPxrR3BTfDi/D3VqfUMzxv9
	rLnddyXEVM+DKrDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7134C134B3;
	Mon,  2 Nov 2026 21:46:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ns86E9EE6WqEAQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 02 Nov 2026 21:46:57 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 17FACB16D; Mon, 02 Nov 2026 22:46:53 +0100 (CET)
Date: Mon, 2 Nov 2026 22:46:53 +0100
From: Jan Kara <jack@suse.cz>
To: daejun7.park@samsung.com
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/readahead: keep at least half of the async window
 when aligning it
Message-ID: <747jhqta3plrrx3bfikceoltsewshdpejdei2qjpn3onnvtu3p@cptmb4phbn54>
References: <20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
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
In-Reply-To: <20261030-mm-readahead-async-align-v1-1-109dea6851fc@samsung.com>
X-Rspamd-Queue-Id: 99A0721F8E
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Fri 30-10-26 12:52:57, Daejun Park via B4 Relay wrote:
> From: Daejun Park <daejun7.park@samsung.com>
> 
> page_cache_async_ra() trims the end of each new window to a multiple of
> 1 << ra->order pages. A window that starts just below such a boundary
> keeps only a few pages. With read_ahead_kb=128 and max_sectors_kb=512,
> 1 MiB reads after a 4 KiB read at offset 0 hit this on about one window
> in three. They issue three times as many device reads.
> 
> Halve the alignment until the trim keeps at least half of the window.
> 
> Fixes: 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
> ---
> Tested on mm-new in a QEMU guest with XFS on an emulated NVMe,
> read_ahead_kb 128 and a cold cache.
> 
> - max_sectors_kb 512, median of 5 runs: reading a 512 MiB file this
>   way takes 0.247 s before and 0.180 s after. The device sees 3329 and
>   1032 reads.
> 
> - Other reads with max_sectors_kb 512: without the 4 KiB read, and with
>   64 KiB reads, the times do not change. Random 4 KiB and 64 KiB reads,
>   two interleaved streams on one file, and 2 MiB reads at random
>   offsets also take the same time. They read the same amount from the
>   device, within 0.3%.
> 
> With the device's transfer limit at 2 MiB:
> 
> - max_sectors_kb 256: 512 KiB reads after the 4 KiB read take 0.626 s
>   before and 0.322 s after. The device sees 6147 and 2056 reads.
> 
> - max_sectors_kb 1024 or 2048: 1 MiB reads are not trimmed.
> 
> - max_sectors_kb 2048, 3 MiB reads: the device sees 343 instead of 271
>   reads. The time is 0.120 s instead of 0.118 s, the median of 40 runs.
>   The interquartile range is about 0.10 to 0.13 s for both. The window
>   stays at 3/4 of the maximum, off the 2 MiB boundary. mm-new reaches
>   that boundary by trimming deeply.

OK, I can see how it easily happens once that we trim the readahead
significantly due to alignment. I'm not fully clear how it happens
periodically. Is it that you do 1 MiB misaligned reads and so we
periodically end up triggering async readahead from positions that are not
aligned to the current value of ra->order?

Anyway, what we want is to align the readahead so that we avoid creating
folios of unnecessarily small order at the end of the readahead window (and
I actually miss evaluation how order of folios changed after your change
because that's also an important metric for this logic). I think the
problem might be that the attempt to align in page_cache_async_ra() is
actually not reflecting what page_cache_ra_order() will end up doing 
(it may reduce ra->order based on readahead size, starting index, etc.) so
the alignment we do in page_cache_async_ra() may be unnecessarily large.
Instead of trying to second-guess the logic of page_cache_ra_order() in
page_cache_async_ra() I think we could pass a flag to it in ractl telling
it it's allowed to shrink the window instead of allocating small folios
and then handle the alignment in page_cache_ra_order(). Hum?

								Honza

> ---
>  mm/readahead.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6e55632902..f4da9b4606 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -713,6 +713,17 @@ void page_cache_async_ra(struct readahead_control *ractl,
>  	align = 1UL << min(ra->order, ffs(max_pages) - 1);
>  	end = ra->start + ra->size;
>  	aligned_end = round_down(end, align);
> +	/*
> +	 * Keep at least half of the window when aligning its end. A
> +	 * window that starts just below a large boundary would otherwise
> +	 * shrink to a few pages and cap the folio order. Use a smaller
> +	 * alignment instead.
> +	 */
> +	while (aligned_end > ra->start &&
> +	       2 * (aligned_end - ra->start) < ra->size) {
> +		align >>= 1;
> +		aligned_end = round_down(end, align);
> +	}
>  	if (aligned_end > ra->start)
>  		ra->size -= end - aligned_end;
>  	ra->async_size = ra->size;
> 
> ---
> base-commit: 9c449f885765cf8d80b2c60b1971e774bba51a3f
> change-id: 20261029-mm-readahead-async-align-e491b3dc16a6
> 
> Best regards,
> -- 
> Daejun Park <daejun7.park@samsung.com>
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
