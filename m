Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337C8292B2E;
	Mon, 21 Sep 2026 09:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789982048; cv=none; b=eNaPZuQafci9Hub8MOz0+KiU0QwS+3KKaWtLkY8eJAzGYr2sXzAVrsnW4zWp8D9UR5TapSx/2ZPPg1oR10GsWaiS6ddI1rlFDxE0ZQ2hi5QJ9cPZDZg5Y9UR3K7dtbpIiwA8Fkzp3Kds1KgdzhqMQu5iNDYl3KFrqWeruRFGKkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789982048; c=relaxed/simple;
	bh=cuaLljRcyBeDoEi13kcoUI7J3r+uCL6iZagm/2olB64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=islLFMI6RwLkiNpUR0rh+ZtqDfDLLWhqia7Bqu/1GC9QO4tT/7O14/o/0oOQ8Qt7P9AL39hx4e4Uy2tYm+IAOdrV7cnJvvjP8fvVxqOHXcedNaG9Qv3HI0V1Z9k1eMSSw7He/z4DlRPrCsjRBQtviE+1XDcZesAIdZXfujGF/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=DNa3q/Q2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k/S1oWP1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=knIrBfKr; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tUVl2pxi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="DNa3q/Q2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k/S1oWP1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="knIrBfKr";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tUVl2pxi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 22D071F7A6;
	Mon, 21 Sep 2026 09:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789982041; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5Hx42b5N3HMo+IBhECiBj3UiF/OOn1jXG+HpXUr1U=;
	b=DNa3q/Q2mQrdJDulb7ILXu9DQAyp4WnXQOjkCKeVKYfxB8Dy8oj381xE863wWctCCuEmWY
	PaIRD/hmYGQ5FPDv0wa2o/B/qj6Tm37aIh9aaEHrn6YNnuNpoOimH/ooot4V8r9nEDGYtJ
	BSjpQQ4bkh1zKAIDraG5Jfq86AZ3+o4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789982041;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5Hx42b5N3HMo+IBhECiBj3UiF/OOn1jXG+HpXUr1U=;
	b=k/S1oWP1PxC9GXeq4HKLKMtStzinjSvABUTOHxH29kpIjE413Lme89yTCRz8woozTtS97B
	IuZiIp2XStrcOXBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1789982037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5Hx42b5N3HMo+IBhECiBj3UiF/OOn1jXG+HpXUr1U=;
	b=knIrBfKrHxOnwGZAq+XJFyc0VZ5gOFAI1fDk4pKI5OlRdzVbArHKtfudFX6UphG9+YiVNG
	pBGSHncjAMjlI9tXWq+yobVeE6bIbVf3i3tOVGg4/ddmQupMNmUiKO5qp8B1wZziS03nYF
	YhI2X0Pgd8o5LpsrTpkZokMk57de/F0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1789982037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i/5Hx42b5N3HMo+IBhECiBj3UiF/OOn1jXG+HpXUr1U=;
	b=tUVl2pxiQhApmw4qVxjXVL3Pgcp9okmZZZ02vOvWVNBV6cCNb1MKt4FxAtaIt+eBoABgTV
	0sfppbXjKKnqCOCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EE4DC13793;
	Mon, 21 Sep 2026 09:13:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZYtQMlT1sGo7aQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 21 Sep 2026 09:13:56 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7D1C1A13D5; Mon, 21 Sep 2026 11:13:56 +0200 (CEST)
Date: Mon, 21 Sep 2026 11:13:56 +0200
From: Jan Kara <jack@suse.cz>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	willy@infradead.org, david@kernel.org, hannes@cmpxchg.org, mhocko@kernel.org, 
	roman.gushchin@linux.dev, muchun.song@linux.dev, riel@surriel.com, shakeel.butt@linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH] mm: filemap: move lruvec accounting outside the xarray
 lock
Message-ID: <uomya4f3y667udbs2oht4p5jchbqmqah564infihegebl7jvq2@7h4g2f3gbdhh>
References: <20260916125122.2696271-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916125122.2696271-1-usama.arif@linux.dev>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email,linux.dev:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Wed 16-09-26 05:51:22, Usama Arif wrote:
> __filemap_add_folio() inserts a folio and updates mapping->nrpages
> while holding mapping->i_pages.xa_lock with interrupts disabled. The
> XArray insertion and nrpages update require the lock, but the lruvec
> statistic updates do not. With CONFIG_MEMCG, those calls also update
> per-CPU memcg and lruvec counters and notify cgroup rstat, extending the
> critical section.
> 
> Move the lruvec accounting after a successful XArray insertion and
> after xas_unlock_irq(). The page-cache references pin the folio, while
> the folio lock keeps folio->mapping stable and prevents removal until
> accounting is complete. This moves one lruvec update for ordinary folios
> and a second for PMD-mappable folios out of the serialized section.
> 
> In a 30-second system-wide perf lock contention -ab capture on a
> production host, the hottest caller-stack record attributed to
> __filemap_add_folio() had 20,867 contentions and 557.930 ms total wait.
> That was 14% of the 3.998 seconds of aggregate lock wait in the
> capture. Moving lruvec accuting outside of critical section should
> help optimize it.
> 
> Signed-off-by: Usama Arif <usama.arif@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/filemap.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 00fd89cf6f550..4720bbfc1a663 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -918,14 +918,6 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  
>  		mapping->nrpages += nr;
>  
> -		/* hugetlb pages do not participate in page cache accounting */
> -		if (!huge) {
> -			lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> -			if (folio_test_pmd_mappable(folio))
> -				lruvec_stat_mod_folio(folio,
> -						NR_FILE_THPS, nr);
> -		}
> -
>  unlock:
>  		xas_unlock_irq(&xas);
>  
> @@ -942,6 +934,13 @@ noinline int __filemap_add_folio(struct address_space *mapping,
>  	if (xas_error(&xas))
>  		goto error;
>  
> +	/* hugetlb pages do not participate in page cache accounting */
> +	if (!huge) {
> +		lruvec_stat_mod_folio(folio, NR_FILE_PAGES, nr);
> +		if (folio_test_pmd_mappable(folio))
> +			lruvec_stat_mod_folio(folio, NR_FILE_THPS, nr);
> +	}
> +
>  	trace_mm_filemap_add_to_page_cache(folio);
>  	return 0;
>  error:
> -- 
> 2.53.0-Meta
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
