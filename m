Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794226828;
	b=pgAR53E2fEVnBByS/qKmhgSgbBDdAHRbEqgAxpuPoLOMQrM6yKIgWZ0qAb3LKK+eotp9
	 o8fgQyv0LgKIyVrgrx9wbEDXVwAj01n1QHP+VGrR0hA2d24CJk4toNghZVkchI91Qu2ka
	 6L7R6xyXyZHD/nx6kdqo9svsnyb2+hGiI7O/Yi6BXfpkjHB7yBDYLhZESpvS8obvIXcpq
	 mcmjeziHizznSulfF23cBUFlUprwBhlIv11JjGXbZYobt5L26NLj7Ojr7GiFUg/LcNATO
	 1vZG0QbmipA69lv4/KA1VcFTKHqgJ8yKnp/bqkqU2G3THwHIgXAugAdo6QYDbKVrnhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794226828;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=YcGWRSLO8Yfbujxln+iu8vgkMzCPp+fOVFLW3VDJHEw=;
	b=tXWVS/G+9qpiE99N2aW59G47bfxBMld2PE98YQEadUHD2mDofKVVncEDvgjZMzS8c5uC
	 ZNlmgUHS7eNN3sh9k9GHP8m0lWTpVppqdciWIxE8u0lhCCIvEuMsx1/uC9RzqHPNgax2k
	 JmLLKt5CPMIuHclJtY4NRCWMuVReGXa7p0otPpOQ3U6rKev8DWJT2V7I8rLfTRgBptxNC
	 qYEpdnIeCZAotTNoJ+K3qcdFwYEyUxCOYCSJtMNZgw8glzwyYFL/43FEJ8TP3NQDEXCAu
	 RuvHZxSVY1fRNObndBeND0otld7ds5lGNpWxfx3UpAbKn0n4LgqJERTsYs0iDrWM0Pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ut7+3u6S;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SApFq5WF;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ut7+3u6S;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SApFq5WF;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D85C606A321;
	Mon,  9 Nov 2026 12:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D85C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ut7+3u6S;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SApFq5WF;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ut7+3u6S;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=SApFq5WF
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9B4F11F7B0;
	Mon,  9 Nov 2026 12:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794226825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcGWRSLO8Yfbujxln+iu8vgkMzCPp+fOVFLW3VDJHEw=;
	b=ut7+3u6SWUn9H8Jk66vEquo6iEFh7zATkMxP+B0KrFpqdOTRAYkB5eSvqIDm4Rftcg06HF
	f7tCAJLzEpBvUUmWwknN84Sa+PrtyJG9nxQ4uagQy4WqPiSGG6MhXP7Lp3Tpooe8AZqVzX
	1EqRV98wGShKrD9PbU/12/Bb4A/d288=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794226825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcGWRSLO8Yfbujxln+iu8vgkMzCPp+fOVFLW3VDJHEw=;
	b=SApFq5WFZKP1QJxdXVdmiFrXqZfJWpmJ9J498Q0lnZH6aJAC8jzrJFO5frmz50TRQOq2eL
	BC6YY8lV1FJQEoCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ut7+3u6S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SApFq5WF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794226825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcGWRSLO8Yfbujxln+iu8vgkMzCPp+fOVFLW3VDJHEw=;
	b=ut7+3u6SWUn9H8Jk66vEquo6iEFh7zATkMxP+B0KrFpqdOTRAYkB5eSvqIDm4Rftcg06HF
	f7tCAJLzEpBvUUmWwknN84Sa+PrtyJG9nxQ4uagQy4WqPiSGG6MhXP7Lp3Tpooe8AZqVzX
	1EqRV98wGShKrD9PbU/12/Bb4A/d288=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794226825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YcGWRSLO8Yfbujxln+iu8vgkMzCPp+fOVFLW3VDJHEw=;
	b=SApFq5WFZKP1QJxdXVdmiFrXqZfJWpmJ9J498Q0lnZH6aJAC8jzrJFO5frmz50TRQOq2eL
	BC6YY8lV1FJQEoCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA5E13302;
	Mon,  9 Nov 2026 12:20:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TyZzEYm68WqqXgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 09 Nov 2026 12:20:25 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E3A9B21FF2; Mon, 09 Nov 2026 13:20:20 +0100 (CET)
Date: Mon, 9 Nov 2026 13:20:20 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	lczerner@redhat.com, tytso@mit.edu, hughd@google.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: skip empty finite ranges in
 truncate_pagecache_range
Message-ID: <tbwekv4fqz3w74jgyy3pqvg3hvfi4erosgwnxwao5lwsrc7hp7@aaxxwdkkte4x>
References: <20261027211505.22044-1-dennylin0707@gmail.com>
 <20261104182700.88789-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261104182700.88789-1-dennylin0707@gmail.com>
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 9B4F11F7B0

On Wed 04-11-26 18:27:00, Hungyu Lin wrote:
> For a finite range ending before the first page boundary,
> truncate_pagecache_range() calculates unmap_end as -1. The unsigned
> comparison then treats the empty full-page interval as nonempty.
> 
> For example, lstart == 0 and lend == 0 cause unmap_mapping_range() to be
> called with a zero length, meaning unmap to EOF. Punching one byte at
> offset zero in a mapped FUSE file can therefore remove mappings outside
> the hole, causing unnecessary page-table work and subsequent faults.
> 
> Set unmap_end to zero for these small finite ranges so that the existing
> unsigned comparison skips the empty interval. Explicitly handle lend ==
> -1 and lend == LLONG_MAX with LLONG_MAX, preserving EOF handling and
> avoiding wrapping in the endpoint calculation at the largest inclusive
> end.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Fixes: 5a7203947a1d ("mm: teach truncate_inode_pages_range() to handle non page aligned ranges")
> Link: https://lore.kernel.org/r/20261027211505.22044-1-dennylin0707@gmail.com
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Compute unmap_end directly as suggested by Jan Kara, keeping the
>   original condition for calling unmap_mapping_range().
> - Handle the EOF sentinel and LLONG_MAX explicitly.
> 
>  mm/truncate.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index 733d2713a87..2c1f4a6c336 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -945,7 +945,15 @@ void truncate_pagecache_range(struct inode *inode, loff_t lstart, loff_t lend)
>  {
>  	struct address_space *mapping = inode->i_mapping;
>  	loff_t unmap_start = round_up(lstart, PAGE_SIZE);
> -	loff_t unmap_end = round_down(1 + lend, PAGE_SIZE) - 1;
> +	loff_t unmap_end;
> +
> +	if (lend == -1 || lend == LLONG_MAX)
> +		unmap_end = LLONG_MAX;
> +	else if (lend < PAGE_SIZE - 1)
> +		unmap_end = 0;
> +	else
> +		unmap_end = round_down(1 + lend, PAGE_SIZE) - 1;
> +
>  	/*
>  	 * This rounding is currently just for example: unmap_mapping_range
>  	 * expands its hole outwards, whereas we want it to contract the hole
> 
> base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
> -- 
> 2.50.1 (Apple Git-155)
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
