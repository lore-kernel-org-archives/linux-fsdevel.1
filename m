Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397554;
	b=RFFOaFd5GUMy4ZJ5t7K9GoZ4q4/vIo4ySiHkvMyVXIQKjWUf8NOBH4UZO1/nYJ/JcKG7
	 MCn3jWQhHbv0IR9arszZ1WrjKivoYGVppV2rSMxX2SX15wwTkxXTw5EAKLWdVNFs71ofk
	 Is3t79WgZTz60bT1jVzGoYmy4CWgAs5ghnqPdwbmWEIVnIgFl83R28r5ZMIOdHUDphxw1
	 Q5WWLHNMegqj3Vwf+/B+ih9mrm867yE2mr0gZZPYVDTKJDAJsIdllAbw73tW064k5l5Nv
	 uoESg3rZRIp0W/wQtewkjmLJWBLb+x2gx2FA3gx7tBRobDVPg2+aPgFJsr6bYUSjfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397554;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=FOeckYZLzpTjDlCSMcNe3YCWoDCfaX4IlNVrhqCPTQo=;
	b=p1C7cqGU3EFHOYUKPryq7aeYSruuvX3UiIF8VBFZTSenqcFTfvQjtNhubjKLZekEog6m
	 1WhzbXlXKolEiyjURfT9VPCGIPRSleKzXaE+GTXAu96Nc6JOn9PDhAOr0OMnnnaCEFI9E
	 ksWKRjO1weJXtJ6SjIrdRQEk70u8ZWBHHxSoE5vDq3pk0CvSZyKXWCnR+hePICEkLouFE
	 aHczc6SdaqVx0A+q42vlQ7w6fmxS0tQdJDNGtFekN47Jn1chKlaVUV5bAp3pizGYfjjAR
	 kno6XH0kiANJ5Q8q42xg3ihrpLNvIsbVg9dNSmM/O8H46Wqy1JcUI2G9f/zW4/gtfHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s6BX8a9h;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uN4oYGZL;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b="p/LYOaxX";
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="qs0l/DFN";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72ED4606A31C;
	Wed, 11 Nov 2026 11:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72ED4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=s6BX8a9h;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=uN4oYGZL;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=p/LYOaxX;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qs0l/DFN
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75B821F458;
	Wed, 11 Nov 2026 11:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794397551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOeckYZLzpTjDlCSMcNe3YCWoDCfaX4IlNVrhqCPTQo=;
	b=s6BX8a9hyHYJk3Z5UpX3ucmxqVW5naQK2EWnRYF/JMtmoRkByYLUk5tDSYZvmVCSGWX6/P
	jrCFXRM0CEkSlDISMW2Q+yqOXRteM0VsFqKpkqSti7OkDj5MEr+lvxOlVZ9ipQwecRmh58
	YURDtKaDb8l65cCYOdmyBrhX7FmpYKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794397551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOeckYZLzpTjDlCSMcNe3YCWoDCfaX4IlNVrhqCPTQo=;
	b=uN4oYGZLgkd3IFxs1MztgB9Bh/RKewnj+HvoiAKdUlTPHCRYIXvxuIjTYguaSuY7vrrPmy
	42ILGHyNz+9AEtDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="p/LYOaxX";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="qs0l/DFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794397550; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOeckYZLzpTjDlCSMcNe3YCWoDCfaX4IlNVrhqCPTQo=;
	b=p/LYOaxX/ZvF0hJsvCX+detet60BIfid09glgP58k23wnP4rA/a3w5dhXaYGiv/kUOdqOq
	/h1DCLSOvf7eaVtSfbT1KlwOZAHiWjY2CP/t8wtmWOfp3p400bmiuB+ryaf4nvXb0QsvDs
	TK1pYPng2R77A39d777twj6U0sLbgGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794397550;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FOeckYZLzpTjDlCSMcNe3YCWoDCfaX4IlNVrhqCPTQo=;
	b=qs0l/DFN/ahzoaaymot81rtIOJjFLzB6z19dAQQ/lmkvX8JJZA6gHl2B6LD2ByU2/n/Qne
	4GdNozEoBxAmevAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4ADBB1339F;
	Wed, 11 Nov 2026 11:45:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tIsdCm5V9GrfZAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 11:45:50 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id CBCD5225EE; Wed, 11 Nov 2026 12:45:45 +0100 (CET)
Date: Wed, 11 Nov 2026 12:45:45 +0100
From: Jan Kara <jack@suse.cz>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jan Kara <jack@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, 
	William Kucharski <william.kucharski@oracle.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH RFC] mm/filemap: fix lseek() skipping a new large folio
Message-ID: <wkpls4kiwl3ktyu5ekahlchabnaqq45o4tgv26cmrs552ljse4@oczec23ankdt>
References: <20261110-lseek_hole-v1-1-c089c960b846@kernel.org>
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
In-Reply-To: <20261110-lseek_hole-v1-1-c089c960b846@kernel.org>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 75B821F458

On Tue 10-11-26 21:33:12, David Hildenbrand (Arm) wrote:
> mapping_seek_hole_data() walks the page cache under RCU and only calls
> xas_set() after entries larger than a page. Between base-page entries,
> it continues the walk with xas_find(), which skips sibling entries
> to return each multi-index entry only once. If a large folio replaces
> small folio entries between iterations, the slot holding the new folio
> can lie behind the cursor. Skipping its sibling entries then skips data
> that has not yet been examined.
> 
> On tmpfs, SEEK_HOLE can then return an offset inside existing data.
> SEEK_DATA can skip data after a fallocated page that is not uptodate.
> 
> For example, assume a 2 MiB tmpfs file backed by 4 KiB pages on x86-64,
> with page index 63 fallocated but not uptodate and all other pages
> uptodate. Index 63 occupies the last slot in the old xarray leaf. A
> SEEK_DATA starting there can skip that page, then race with collapse of
> pages 0-511 into one 2 MiB folio. The next xas_find() moves past the old
> leaf and skips the new folio's sibling entries in the parent, returning
> -ENXIO instead of finding data at page index 64, or 256 KiB.
> 
> The inode lock held by lseek() does not exclude collapse or swapin.
> 
> Restarting the xarray walk after every entry fixes this, but increases
> SEEK_HOLE time about 24%, when scanning a fully written 1 GiB memfd backed
> by base-page folios in an x86-64 microbenchmark.
> 
> Instead, use xas_next() for adjacent indices. Restart the lookup from the
> root at the requested index if it returns an empty slot or an internal
> entry, including a sibling entry. Also restart for nonadjacent indices,
> invalid iterator state, or failed folio validation. This avoids skipping
> unexamined data without restarting each lookup during base-page scans.
> 
> Fixes: 6b24ca4a1a8d ("mm: Use multi-index entries in the page cache")
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> I'll be more than happy if someone of the pagecache folks wants to take
> over ;)

This looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I just find it unfortunate that we have to play complicated games like
these for such a simple operation as sequentially iterating over all folios
in a mapping. And it is not a first bug of this nature trigered by
compaction. So longer term I believe we need to provide saner apis
shielding pagecache users from these nasty details.

								Honza

> ---
>  mm/filemap.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 648f783454c3..87c583509567 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3233,6 +3233,40 @@ static inline size_t seek_folio_size(struct xa_state *xas, struct folio *folio)
>  	return folio_size(folio);
>  }
>  
> +static inline struct folio *seek_get_entry(struct xa_state *xas, pgoff_t index,
> +					   pgoff_t max)
> +{
> +	struct folio *folio;
> +
> +	if (!xas_valid(xas) || xas->xa_index + 1 != index)
> +		goto restart;
> +
> +	/*
> +	 * A lookup within a multi-index entry can leave xa_offset at its
> +	 * first slot. Restore the slot corresponding to xa_index before
> +	 * advancing.
> +	 */
> +	xas_advance(xas, xas->xa_index);
> +	folio = xas_next(xas);
> +
> +	/*
> +	 * A concurrent collapse can replace the next slot with a sibling entry
> +	 * referring back to the slot holding the folio.
> +	 */
> +	if (!folio || xa_is_internal(folio))
> +		goto restart;
> +	if (xa_is_value(folio))
> +		return folio;
> +	if (!folio_try_get(folio))
> +		goto restart;
> +	if (folio == xas_reload(xas))
> +		return folio;
> +	folio_put(folio);
> +restart:
> +	xas_set(xas, index);
> +	return find_get_entry(xas, max, XA_PRESENT);
> +}
> +
>  /**
>   * mapping_seek_hole_data - Seek for SEEK_DATA / SEEK_HOLE in the page cache.
>   * @mapping: Address space to search.
> @@ -3263,7 +3297,7 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  		return -ENXIO;
>  
>  	rcu_read_lock();
> -	while ((folio = find_get_entry(&xas, max, XA_PRESENT))) {
> +	while ((folio = seek_get_entry(&xas, start >> PAGE_SHIFT, max))) {
>  		loff_t pos = (u64)xas.xa_index << PAGE_SHIFT;
>  		size_t seek_size;
>  		u64 next;
> @@ -3286,8 +3320,6 @@ loff_t mapping_seek_hole_data(struct address_space *mapping, loff_t start,
>  			goto unlock;
>  		if (start >= end)
>  			break;
> -		if (seek_size > PAGE_SIZE)
> -			xas_set(&xas, pos >> PAGE_SHIFT);
>  		if (!xa_is_value(folio))
>  			folio_put(folio);
>  	}
> 
> ---
> 
> base-commit: 93d7a816a2df3e907e2719bd12b0073f1285fc5c
> 
> change-id: 20261110-lseek_hole-4a9eb450d473
> 
> --
> 
> Cheers,
> 
> David
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
