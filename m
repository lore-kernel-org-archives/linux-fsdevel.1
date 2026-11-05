Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893080;
	b=AGkJSbpuSclewk5ulU6ZOr9IbWcPgL4zq5+qFWHM+L+vcVhTk4sI79zArRrF61Z8y0A/
	 8/UHYTSShkatU3avSY7IIC9TbpTnOyOJ/d1xAJoEixwmlLIpuAyuPAu7N2+RLxOv0JzNf
	 adCOXB7QCfVNIV9REKlsi250PAewZgHcxw8ODYxo4xrq8I3lNhbpBvwI1YExLG+iarsXG
	 /8ctxTDbEhWFAGsH14y0wNj5i1QIIJCPIdSSt5F97IXjyIt3gpTI/E5FaIveWCe70lGTh
	 8K/rTKPvvl8/cDp9Nd1zz3N868sXiQttHFvRsfSwzPQ74XI6gXd/S7zDe8MeyJOuggw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893080;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=rn+wFvbgmGD2mi6hZAgXI17+uY+nPNgmOpv7W0MTn8k=;
	b=OWokia+ocMTiRSwsLTbHx++9R8Agzt28PMVdE2t5bcBxjgdmlcTjnOdLWXi6k5JwMp/l
	 Er0eLgjDE/fqwtdJQGJlj6chdz6Ni1wqpdnh+xUq3i9XoaREU7+OsQV9V0Pznu0TWKJ1k
	 vQ3dtfpVuxLpmBptBaCeLSdvU+kvGjRnNc2UPRtXYb1MG4dk6HdqfqihSFCp/Dj70UYkp
	 NSJyvsWyD2/jhN7ij8eedS5qy6XAVdm9hHarNydtN+RoOXEk9qNG5ukvkuUI8jLcC/2t+
	 bTjLlSPSsBHH6z1LXShJ4u+hwWg3mgYsZTBJwEsznA2vsOQLvgbDppVURIX4UbOAh6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uGIYsDTD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A8EdLJV0;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Kn3yERPG;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ucOfUodT;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206B4606A332;
	Thu,  5 Nov 2026 15:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 206B4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=uGIYsDTD;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=A8EdLJV0;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Kn3yERPG;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ucOfUodT
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1A30721F99;
	Thu,  5 Nov 2026 15:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793893078; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rn+wFvbgmGD2mi6hZAgXI17+uY+nPNgmOpv7W0MTn8k=;
	b=uGIYsDTDJwSMXQ57mFgsz9hPxEJcLbCO4ZhjAoZW62cq79kzSLivDRrVKWs35c8RI9QeI8
	Vm+uRJg0Ut8bNXp6fTSWObSxWPQI1T3SwLdk8F7qtZu5Km2LbrPw62UOmcRYm9tlRKcBmI
	G4Nv0rQFicHkzdTbZ07OhdaDm5HPldM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793893078;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rn+wFvbgmGD2mi6hZAgXI17+uY+nPNgmOpv7W0MTn8k=;
	b=A8EdLJV0Yrafz/6PhZ4oua84nhZbqniplcyqOxD+ihbl7DN87/znLkq/VPyk62IApoehHV
	PVdkHfZG4xA8n/CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793893077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rn+wFvbgmGD2mi6hZAgXI17+uY+nPNgmOpv7W0MTn8k=;
	b=Kn3yERPG1TCwzY+U7d6EGCGuUK3/U7M9d+rmSg13ESY+3Nm/6uYeB1tDATs+2Di6O8fGk1
	0IxMEOvKicr6gMWT+o2Js0rMSSNrGA6YMZ6QTVSejPQJEODdN/K736SUgJILsJW0FbsQyL
	q2iG/TX+YpjkNr84nIMTp30QENYT85A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793893077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rn+wFvbgmGD2mi6hZAgXI17+uY+nPNgmOpv7W0MTn8k=;
	b=ucOfUodTRPKzkbGc/r7LJnjonnyq4BR9/Ll/K73j5RipUtd5vajMhqU+qu8j1gm2APnd/m
	JQXyIxTX1PLElWBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E2F1F134F4;
	Thu,  5 Nov 2026 15:37:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KMWCL9Si7GrTcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 05 Nov 2026 15:37:56 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 63758B747; Thu, 05 Nov 2026 16:37:48 +0100 (CET)
Date: Thu, 5 Nov 2026 16:37:48 +0100
From: Jan Kara <jack@suse.cz>
To: daejun7.park@samsung.com
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>, Ryan Roberts <ryan.roberts@arm.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/readahead: align the async window in
 page_cache_ra_order()
Message-ID: <cs7sng2kwgcdbuxfk56sbc3x4ku6jtxk6nzwhaaqbjvmi5fqd6@nac6orsarmta>
References: <20261103-mm-readahead-async-align-v2-1-c3c304cbca59@samsung.com>
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Post: <mailto:linux-fsdevel@vger.kernel.org>
List-Help: <mailto:linux-fsdevel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fsdevel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lgcir5uumdsu3tbv"
Content-Disposition: inline
In-Reply-To: <20261103-mm-readahead-async-align-v2-1-c3c304cbca59@samsung.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email,samsung.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO


--lgcir5uumdsu3tbv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue 03-11-26 13:19:26, Daejun Park via B4 Relay wrote:
> From: Daejun Park <daejun7.park@samsung.com>
> 
> page_cache_async_ra() rounds each window end down to a multiple of
> 1 << ra->order pages before page_cache_ra_order() clamps the folio
> order. A window starting just below a boundary shrinks to a few pages.
> With read_ahead_kb=128 and max_sectors_kb=512, 1 MiB reads after a
> 4 KiB read at offset 0 hit this on one window in three. On a 512 MiB
> XFS file over QEMU NVMe (cold cache), that takes 0.251 s, 3329 device
> reads, and 9721 folios (none of order 7).
> 
> Pass a flag in struct readahead_control and align the window end in
> page_cache_ra_order(), stepping the order down to keep at least half of
> the window. The read then takes 0.200 s, 1031 device reads, and 1039
> folios (1021 of order 7).
> 
> Fixes: 18ebe55a9236 ("mm/readahead: terminate async readahead on natural boundary")
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/747jhqta3plrrx3bfikceoltsewshdpejdei2qjpn3onnvtu3p@cptmb4phbn54
> Signed-off-by: Daejun Park <daejun7.park@samsung.com>
...

> diff --git a/mm/readahead.c b/mm/readahead.c
> index 6e55632902..959c9a7b48 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -498,6 +498,35 @@ void page_cache_ra_order(struct readahead_control *ractl,
>  		goto fallback;
>  	}
>  
> +	new_order = min(mapping_max_folio_order(mapping), new_order);
> +	new_order = min_t(unsigned int, new_order, ilog2(ra->size));
> +	new_order = max(new_order, min_order);
> +
> +	/*
> +	 * The caller allows the window to shrink so that it ends on a folio
> +	 * boundary, rather than ending in small folios. Keep at least half of
> +	 * the window: one that starts just below a boundary would otherwise
> +	 * shrink to a few pages. Use a smaller order instead.
> +	 */
> +	if (ractl->_align_end) {
> +		pgoff_t end = start + ra->size;
> +
> +		while (new_order > min_order) {
> +			pgoff_t aligned_end = round_down(end, 1UL << new_order);
> +
> +			if (aligned_end <= start)
> +				break;
> +			if (2 * (aligned_end - start) >= ra->size) {
> +				ra->size = aligned_end - start;
> +				ra->async_size = ra->size;
> +				new_order = min_t(unsigned int, new_order,
> +						  ilog2(ra->size));
> +				break;
> +			}
> +			new_order--;
> +		}
> +	}

Um, this isn't quite what I meant because this is still quite ad hoc.
Rather something like attached change (plus the _align_end bits from this
patch). It will also end up guaranteeing at least half of the original
window is read but it is also implicitly taking into account alignment of
the starting offset and other possible factors.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--lgcir5uumdsu3tbv
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-readahead-Align-window-end-in-pagecache_ra_order.patch"

From 51aaef0da6965d13cfa44a7ddf8e0e846af5585f Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 5 Nov 2026 16:31:59 +0100
Subject: [PATCH] readahead: Align window end in pagecache_ra_order()

---
 mm/readahead.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 6e5563290287..62e204eb3e7c 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -490,7 +490,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	unsigned int nofs;
 	int err = 0;
 	gfp_t gfp = readahead_gfp_mask(mapping);
-	unsigned int new_order = ra->order;
+	unsigned int new_order = ra->order, last_order = 0;
 
 	trace_page_cache_ra_order(mapping->host, start, ra);
 	if (!mapping_large_folio_support(mapping)) {
@@ -532,10 +532,22 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		/* Don't allocate pages past EOF */
 		while (order > min_order && index + (1UL << order) - 1 > limit)
 			order--;
+		/*
+		 * If we are allowed to align the end of readahead window, stop
+		 * the readahead as soon as we have to reduce folio order due
+		 * to it exceeding the RA window.
+		 */
+		if (ractl->_align_end && order < last_order) {
+			ra->size = index - start;
+			if (ra->async_size > ra->size)
+				ra->async_size = ra->size;
+			break;
+		}
 		err = ra_alloc_folio(ractl, index, mark, order, gfp);
 		if (err)
 			break;
 		index += 1UL << order;
+		last_order = order;
 	}
 
 	read_pages(ractl);
-- 
2.53.0


--lgcir5uumdsu3tbv--
