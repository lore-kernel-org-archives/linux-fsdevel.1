Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793793461;
	b=O5sbSfhb578D2riWIHJGdSfcHkce7OMG1QqxzJ0uFj2AIAECOYFLNiNEpKMXze49NtZH
	 4MVZ+gLb3Ql58lB2kjsws74tHJptPkA2LcPzHzTL6b631JJJOVhGX6XanV3foyTpGzw6A
	 cKH5YOF8Ou5hga34nDF7uRw0EBCb/Z+feNheYEX+zqDhaide0jxXXhs47lVDcpEsx/+oq
	 RbIoFGetqH+7aHsHiHAQEsONHzYWJO8zU/fKdEXzvASuHm0prsTNrO1wa49p5MStgYblP
	 c9GttDTdhWAMYaCze3aqKzTkO6l9pajh1D6M2BXPLpSo09DAekL7QrFc/8QU8zaI5VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793793461;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=rHluHhAO0xC/KF78ZIKkidib22uHHwF0MmD/UX1TZas=;
	b=AnR9AAfpYeL3vAiEDBNqWmWjtBaEIveEwz8qMqJwgCwXBex9UrG66ZC/SN9gt+wDzofs
	 o/yH1su56m+YOQl/w1ifIQjLoUDJBrGc62qB3SsGEdKBezJQnlIvyMr/BZEs7N/t79Xi3
	 lwtIlmiu+yLzAVjrDVlxs9jy049pwWSrQt0sMHCnVk/Ih0xp8vJ9+ldsoJolBvXSKOjDU
	 v+KlPPRmrg+4Bcb6oKElXPpQx/DGqNSQMOimsvRADXWeNOvwm86aNl86dRBXAzZCN9CU9
	 AIvtVm72x2KHlOlBQMW8y87JiPOkm32zeHC5J0ZVYVOsh0jPBWk9loZy2GwAnFUAvrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="fy2ko+/0";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLN+Zm+G;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="fy2ko+/0";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLN+Zm+G;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB15606A31B;
	Wed,  4 Nov 2026 11:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB15606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fy2ko+/0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLN+Zm+G;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=fy2ko+/0;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=kLN+Zm+G
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6B1131F7B0;
	Wed,  4 Nov 2026 11:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793793459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHluHhAO0xC/KF78ZIKkidib22uHHwF0MmD/UX1TZas=;
	b=fy2ko+/0ozIyB3q5s1uUqEpVwnWUMej8/uCnv72PKBECMQziYobfMfkgZJnziOgYNg3dM8
	A5HDIT7ZR7CHYeiJWOdEq5LqDc0xqfsu3uokHefPpQ+Tl1Uf5NhrUM+cMvxTTSzcgs8y1L
	HXGQGTUYpkj3RmyBhEazvvf3rhDnhZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793793459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHluHhAO0xC/KF78ZIKkidib22uHHwF0MmD/UX1TZas=;
	b=kLN+Zm+Gxs3JqSjmXH3tgisagn/MTlDuir+JU00r6OsUmaTBNDsC6Xg0AFvQMX/ZKxrkQT
	qR27tUOPLZQTaQDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793793459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHluHhAO0xC/KF78ZIKkidib22uHHwF0MmD/UX1TZas=;
	b=fy2ko+/0ozIyB3q5s1uUqEpVwnWUMej8/uCnv72PKBECMQziYobfMfkgZJnziOgYNg3dM8
	A5HDIT7ZR7CHYeiJWOdEq5LqDc0xqfsu3uokHefPpQ+Tl1Uf5NhrUM+cMvxTTSzcgs8y1L
	HXGQGTUYpkj3RmyBhEazvvf3rhDnhZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793793459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rHluHhAO0xC/KF78ZIKkidib22uHHwF0MmD/UX1TZas=;
	b=kLN+Zm+Gxs3JqSjmXH3tgisagn/MTlDuir+JU00r6OsUmaTBNDsC6Xg0AFvQMX/ZKxrkQT
	qR27tUOPLZQTaQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F47E134F0;
	Wed,  4 Nov 2026 11:57:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S2RxB7Md62olTwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Nov 2026 11:57:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id C285BB336; Wed, 04 Nov 2026 12:57:38 +0100 (CET)
Date: Wed, 4 Nov 2026 12:57:38 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: willy@infradead.org, jack@suse.cz, akpm@linux-foundation.org, 
	lczerner@redhat.com, tytso@mit.edu, hughd@google.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: skip empty finite ranges in truncate_pagecache_range
Message-ID: <l53ckhx3h6jyt7bnosdycttcesuyt2jxvspnhs3gdftrxuj67y@djj4esw62ht7>
References: <20261027211505.22044-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261027211505.22044-1-dennylin0707@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80

On Tue 27-10-26 21:15:05, Hungyu Lin wrote:
> For a finite range ending before the first page boundary,
> truncate_pagecache_range() calculates unmap_end as -1. The unsigned
> comparison then treats the empty full-page interval as nonempty.
> 
> For example, lstart == 0 and lend == 0 cause unmap_mapping_range() to be
> called with a zero length, meaning unmap to EOF. Punching one byte at
> offset zero in a mapped FUSE file can therefore remove mappings outside
> the hole, causing unnecessary page-table work and subsequent faults.
> 
> Compare the exclusive rounded end against the rounded start, while
> explicitly preserving lend == -1 as the EOF sentinel. Perform the
> addition after converting to u64 so the largest inclusive end does not
> introduce a signed overflow in the comparison.
> 
> Fixes: 5a7203947a1d ("mm: teach truncate_inode_pages_range() to handle non page aligned ranges")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Hum, so I agree about the problem but the rounding logic in
truncate_pagecache_range() has more flaws AFAICS. For example if lend ==
LLONG_MAX, then unmap_end with overflow to huge negative value. So maybe
let's fix it all at once. Maybe something like:

	if (lend == -1 || lend == LLONG_MAX)
		unmap_end = LLONG_MAX;
	else if (lend < PAGE_SIZE - 1)
		unmap_end = 0;
	else
		unmap_end = round_down(1 + lend, PAGE_SIZE) - 1;

And then you can leave the condition checking whether to call
unmap_mapping_range() untouched.

								Honza

> ---
>  mm/truncate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/truncate.c b/mm/truncate.c
> index b58ba940be47..43c6cf99027f 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -919,7 +919,7 @@ void truncate_pagecache_range(struct inode *inode, loff_t lstart, loff_t lend)
>  	 * once (before truncating pagecache), and without "even_cows" flag:
>  	 * hole-punching should not remove private COWed pages from the hole.
>  	 */
> -	if ((u64)unmap_end > (u64)unmap_start)
> +	if (lend == -1 || (u64)unmap_end + 1 > (u64)unmap_start)
>  		unmap_mapping_range(mapping, unmap_start,
>  				    1 + unmap_end - unmap_start, 0);
>  	truncate_inode_pages_range(mapping, lstart, lend);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
