Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458DA3191A5
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Jun 2026 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780398853; cv=none; b=ic8u19xGOnqWh/brELr17UH4x05FwL7W6kGCwSZcztKrkyqfPDA5zbwuwZkEQF+bhTu8DkdGmFHEKR/qvbmS5bWVpiHC2OVapyCxAON+22a72kG/a5TCZnZ/27hccawIAvNnp9IX4cJav45kLZYObALoEAvZSpxCS+un7Sa26I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780398853; c=relaxed/simple;
	bh=9LjEc3QdsXn2ZCahezoawKAeZ53JAUbu1hVLhjAcwiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifNYeHp4NykUlkhIAvcCYuxJ3GrnVLtNGTMtCMPrPScNooxL2wC5CWrnVvs8JeQ6uEz3egdjMwzkJ0GlMzpvfiRpnmKAbeonKazjAYK4979K0MeVFT7km7fPNAHv5cYBx1IfZ0OrzUh7Hv/Di39Y6W7+kYtY0a7Hd0MkojCzzxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBGWsGjf; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ejSlTx7R; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tsftKb+W; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=laW7hGPV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBGWsGjf";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ejSlTx7R";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tsftKb+W";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="laW7hGPV"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 622C26AAFE;
	Tue,  2 Jun 2026 11:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780398850; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mj2dTLHBTtJmxWAHjjC/JAoIXX1S+JjAURhUmTJMA5Y=;
	b=CBGWsGjfnDxJIyL6p7b7wnwzwF4lPO73dMch8UF/HBIV4nI1QDhY/3h1uf/DF2EIsJXBR+
	ytZiiL/9uB+AboDqxs6f6RTlu9G6/GOwzRVaMu9GAIUXQkn4JhN4ceSg9ni8oFUF9H6zfA
	XcZ+6IOhaSeZmmN92rojJ8PsBGo2HQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780398850;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mj2dTLHBTtJmxWAHjjC/JAoIXX1S+JjAURhUmTJMA5Y=;
	b=ejSlTx7R71Y/OQSYP6ds9AHIooLXhHxB/DxJs4KC/y/9CtuqIbOEd7dJ0xn/4AQc4wldhx
	RD+jQ+02+N0Da5Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tsftKb+W;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=laW7hGPV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1780398849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mj2dTLHBTtJmxWAHjjC/JAoIXX1S+JjAURhUmTJMA5Y=;
	b=tsftKb+W7mmTMWmVSkXFsfdsrkKZt6YmLILo8gYUI6/AZotLEy4LJlSHTl/MUgVcbbrp4F
	BIhRvr8WZqo/a+t/DM1DabB01jUX/VFhxYlBhVJ2CaXDlaKso27RaYtjSsvo1hNkuPx7r9
	zKYKCyKfDNy1AUprB8/V4u1FaYrCQ2c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1780398849;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Mj2dTLHBTtJmxWAHjjC/JAoIXX1S+JjAURhUmTJMA5Y=;
	b=laW7hGPVyumtc9e2Vxg5ohsWyBGkNz9p0RwIeUUUJmK119/NZpsydZIxRlmdo5nakYxi7T
	i9A+c0usCfSb0PDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 563C2779A7;
	Tue,  2 Jun 2026 11:14:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jMoGFQG7HmqmNQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 02 Jun 2026 11:14:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E0B6EA0EC1; Tue, 02 Jun 2026 13:14:00 +0200 (CEST)
Date: Tue, 2 Jun 2026 13:14:00 +0200
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, david@kernel.org, hannes@cmpxchg.org, kas@kernel.org, 
	shakeel.butt@linux.dev, kernel-team@meta.com
Subject: Re: [PATCH] mm: make mmap_miss accounting symmetric for VM_SEQ_READ
Message-ID: <3apovyh7kutv5qdo5yrcawqlviaeckuyqoirfk55pjwdkmyllg@ku4xvvpgub4n>
References: <20260525145751.2671248-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525145751.2671248-1-usama.arif@linux.dev>
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
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.cz:email,suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 622C26AAFE
X-Spam-Score: -4.01

On Mon 25-05-26 07:57:51, Usama Arif wrote:
> do_sync_mmap_readahead() skips both the mmap_miss increment and the
> MMAP_LOTSAMISS check for VM_SEQ_READ mappings, since sequential access
> is non-speculative and should always read ahead. The two decrement
> sites in do_async_mmap_readahead() and filemap_map_pages() do not
> mirror this skip, so concurrent faults on a VM_SEQ_READ mapping can
> still drive ra->mmap_miss down to zero through the decrement paths
> even though nothing in the sync path ever increments it. The counter
> itself is per-file (file->f_ra.mmap_miss), so it can be moved by any
> VMA mapping the file, not just the one currently faulting.
> 
> Skip the decrement for VM_SEQ_READ in both decrement sites so the
> counter only moves for mappings that also participate in the
> increment side. No functional change for VM_SEQ_READ users, since the
> increment-side gate already prevents the counter from being consulted
> on their behalf, but it stops a VM_SEQ_READ mapping from biasing the
> counter for other mappings of the same file.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 5aaba0d3e81d..cca20e350c95 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -3433,8 +3433,13 @@ static struct file *do_async_mmap_readahead(struct vm_fault *vmf,
>  	 * Don't touch the mmap_miss counter to avoid decreasing it multiple
>  	 * times for a single folio and break the balance with mmap_miss
>  	 * increase in do_sync_mmap_readahead().
> +	 *
> +	 * VM_SEQ_READ mappings skip the mmap_miss increment in
> +	 * do_sync_mmap_readahead(), so skip the decrement here as well to
> +	 * keep the counter symmetric.
>  	 */
> -	if (likely(!folio_test_locked(folio))) {
> +	if (likely(!folio_test_locked(folio)) &&
> +	    !(vmf->vma->vm_flags & VM_SEQ_READ)) {
>  		mmap_miss = READ_ONCE(ra->mmap_miss);
>  		if (mmap_miss)
>  			WRITE_ONCE(ra->mmap_miss, --mmap_miss);
> @@ -3935,10 +3940,15 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
>  		 * In such situation, read-ahead is only a waste of IO.
>  		 * Don't decrease mmap_miss in this scenario to make sure
>  		 * we can stop read-ahead.
> +		 *
> +		 * VM_SEQ_READ mappings skip the mmap_miss increment in
> +		 * do_sync_mmap_readahead(), so skip the decrement here as
> +		 * well to keep the counter symmetric.
>  		 */
>  		if ((map_ret & VM_FAULT_NOPAGE) &&
>  		    !(vmf->flags & FAULT_FLAG_TRIED) &&
> -		    !folio_test_workingset(folio)) {
> +		    !folio_test_workingset(folio) &&
> +		    !(vma->vm_flags & VM_SEQ_READ)) {
>  			unsigned short mmap_miss;
>  
>  			mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
