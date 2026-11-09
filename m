Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794233489;
	b=jDIUel9enB3+i52AJtW4/sfxyAXCZCtQLRF7i9NjP3ZbDT5/ccF1q3lFcL4/RomZ/WQD
	 QRcftGoalI1y0j7qsh1kum+UaVG5G95sg85IUEEmfzLDOkyhwcasfW4HxJyVXHfVLhRzy
	 EK2PC4XneIqFw1UTo0J8qmzeYgnq3yRX35RgvXSWViBNnDRtSjN692EaQoQYNhdX2HM5q
	 sqhEdMXTesFUVOk5JPGg4C1wGMuNzAEbEgLcBaUxyXUaMH4QoSbdKjHqlyUhm/e/Es45f
	 +uFWeZ/W/4YsJLFDODF46xbrj9COIsyQXCUF9tWVH3fCtyhqOtjUaETjicnKCUo6AhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794233489;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=UixA2iMxrYGuaa7Tk4DCMrXBPONdRbn3XUlAnW90aew=;
	b=rizmu1Y4gOWG4BcABTe6Q/hSZc0/LEwM3vrABwjcLyCkPcJ+TMqNMIP4G+CV1btLWNTx
	 Jf/SD3hjnygpG1mgTEO4c21zQ49fNwc/Xyci7t63gHdsu4k7lWlvA6IQp2TCdh7129qA6
	 7oXZEqe1+28S150mfblmMVl8pS/7a1FA2/i65KhQHGgMtD9luhMWwkMxFHyGOdqBIXwLV
	 9IJD5iT86QYvAHnx+pGQEIFo5eFEYF0Q3UWpcKorNk58rnxYx8LFMWNq3iYtZFAy8vv4+
	 V2bSBm/E7FGX0DKb4f/dYWyNboOVut6ojY1fHIIGTD5ZPVuljIMIWV4MlkC9j3jq3yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rOKNBjA0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gzy3PFy5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rOKNBjA0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gzy3PFy5;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2523B606D81B;
	Mon,  9 Nov 2026 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2523B606D81B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rOKNBjA0;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gzy3PFy5;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rOKNBjA0;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Gzy3PFy5
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ECF22220BC;
	Mon,  9 Nov 2026 14:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794233487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UixA2iMxrYGuaa7Tk4DCMrXBPONdRbn3XUlAnW90aew=;
	b=rOKNBjA0FSBris6AaCuG53CFa1lbSnDchdh4z5Qm9m+APT1ttY5nGS1/QFBpbbKbOF4fit
	Qx5pilstG5yOIutRfIJpS19NHu2MBhVFFJtm7JYfwf1lqI1iDEkXmvpvi5Myfuq7i6WMrv
	Gqx3KjRJ96W+IfjLqQ1q+wbsYuVilh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794233487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UixA2iMxrYGuaa7Tk4DCMrXBPONdRbn3XUlAnW90aew=;
	b=Gzy3PFy52hA5KNQwVmyvZfo9FuqdMa803s8oS+B0tWdDGTH4N3v6HeWVDlo1Wm9ycM9lho
	bx2oBjSOMngmjhBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=rOKNBjA0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Gzy3PFy5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794233487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UixA2iMxrYGuaa7Tk4DCMrXBPONdRbn3XUlAnW90aew=;
	b=rOKNBjA0FSBris6AaCuG53CFa1lbSnDchdh4z5Qm9m+APT1ttY5nGS1/QFBpbbKbOF4fit
	Qx5pilstG5yOIutRfIJpS19NHu2MBhVFFJtm7JYfwf1lqI1iDEkXmvpvi5Myfuq7i6WMrv
	Gqx3KjRJ96W+IfjLqQ1q+wbsYuVilh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794233487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UixA2iMxrYGuaa7Tk4DCMrXBPONdRbn3XUlAnW90aew=;
	b=Gzy3PFy52hA5KNQwVmyvZfo9FuqdMa803s8oS+B0tWdDGTH4N3v6HeWVDlo1Wm9ycM9lho
	bx2oBjSOMngmjhBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B0E2313319;
	Mon,  9 Nov 2026 14:11:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FTbKH43U8Wo8VwAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Mon, 09 Nov 2026 14:11:25 +0000
Date: Mon, 9 Nov 2026 14:11:23 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Hugh Dickins <hughd@google.com>, Chris Mason <mason@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 1/2] mm/memory: recheck PG_uptodate after
 ->page_mkwrite()
Message-ID: <avHULH5Irb3byJkG@pedro-suse.tail5790ac.ts.net>
References: <20261109120403.82361-1-kas@kernel.org>
 <20261109120403.82361-2-kas@kernel.org>
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
In-Reply-To: <20261109120403.82361-2-kas@kernel.org>
X-Rspamd-Queue-Id: ECF22220BC
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[17];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -13.51

On Mon, Nov 09, 2026 at 12:04:01PM +0000, Kiryl Shutsemau (Meta) wrote:
> do_shared_fault() unlocks the folio around ->page_mkwrite(). Writeback
> can lock it in that window, fail, and clear PG_uptodate with the folio
> left in the page cache. ecryptfs_writepages() does this when encryption
> fails. filemap_page_mkwrite() relocks the folio and checks only
> ->mapping, so the fault maps a folio that is not uptodate:
> 
>     CPU0                            CPU1
>     do_shared_fault()
>       folio_unlock()
>                                     ecryptfs_writepages()
>                                       folio_clear_uptodate()
>       filemap_page_mkwrite()
>         folio_lock()
>       finish_fault()
> 
> The next read(2) or fault on the folio reads it in again from the file,
> over anything stored through the mapping in the meantime. Those stores
> are lost.
> 
> Recheck PG_uptodate once ->page_mkwrite() returns with the folio locked,
> and retry the fault if it is clear, the same way filemap_fault() retries
> on a cached folio that lost PG_uptodate. Skip folios outside the page
> cache: driver pages from ->fault() never get PG_uptodate and would
> retry forever.
> 
> The check stays out of do_page_mkwrite(): wp_page_shared() calls it on
> a folio that is still mapped, and a retry there would fault on the same
> PTE forever.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/sashiko-outbox-202966@kernel.org/
> Signed-off-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> ---
>  mm/memory.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index fe72e66c9c2e..cc1d0b7d15c7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5613,6 +5613,18 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
>  	return VM_FAULT_OOM;
>  }
>  
> +/*
> + * A page cache folio that is not uptodate holds data that was never read in
> + * or cleared, and mapping it leaks stale memory to userspace.
> + */
> +static bool file_folio_not_uptodate(struct folio *folio)
> +{
> +	if (likely(folio_test_uptodate(folio)))
> +		return false;
> +	/* Driver pages from ->fault() never get PG_uptodate */
> +	return !folio_test_anon(folio) && folio->mapping;

FYI you can wrap this line in an unlikely() and it has the same effect as
wrapping every call:
	return unlikely(!folio_test_anon(folio) && folio->mapping);

> +}
> +
>  /*
>   * Either the VMA lock or the mmap_lock must have been held on entry
>   * (see FAULT_FLAG_VMA_LOCK) and may have been released depending on
> @@ -6163,6 +6175,16 @@ static vm_fault_t do_shared_fault(struct vm_fault *vmf)
>  			folio_put(folio);
>  			return tmp;
>  		}
> +
> +		/*
> +		 * The folio was unlocked for ->page_mkwrite(). If it lost
> +		 * PG_uptodate meanwhile, retry the fault to read it in again.
> +		 */

The "read it in again" sounds a bit too prescriptive but, apart from that:

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

-- 
Pedro
