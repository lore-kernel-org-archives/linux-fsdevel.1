Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A676340283
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627673; cv=none; b=vBErmxN9Z8/iffWBXKe9JYFy6sDVA7Ed9L1P5oiRXDJziNJYt3+JpZa2IcvdydmPXASTJn6SXGOJs8c4ZYcmsHQWK3xeicvVIVGuwvQMzeyEt9DwrewiqF/xdlt8MqtyWlJHkERon/janYmxis6M+QVWUSyRDuFevNx+dB7qqtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627673; c=relaxed/simple;
	bh=oq0rP3fLhCjTaA8CJfRoI8SU1KvEWg8qXm9llTIirBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxUW5Mf75aw3/rF03GKneWYF32KA6itgXffoiZOV4GaEbKqWTSBPSVZgFLZR4UHoPF3A4EqRXGhDHolSVPdGaz3ig8jmdIeoiyElkcaV8Z7DTMyZb+yjnDndy6pzmEbG7E3DE8Boen4UpwRNnh6jAuxgAOpv0Vn4j0+OjN1n0HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ja3Gn/8X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ey6zWAX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ja3Gn/8X; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=6ey6zWAX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ja3Gn/8X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ey6zWAX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ja3Gn/8X";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="6ey6zWAX"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 48AA05BEE5;
	Fri, 27 Mar 2026 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774627670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqt7sqz+Z/AOlrj075O/J83vs51Td6xl2fSsWyleBdc=;
	b=ja3Gn/8XuXTXwihUUdv/cNCmN7MtssZoejPOEB4PHAphVKwmoUC6Vq/PBFI2iqjZ6da52m
	CTuOg4cfctf1M6mSKiqiCutpFTQUglGOoUOblqKVKHdKzCSzYA07x/4N9kVH7EhlSTtMRR
	hDJrQZCA8Wb1B9w9DtTH8o8iDTISoOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774627670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqt7sqz+Z/AOlrj075O/J83vs51Td6xl2fSsWyleBdc=;
	b=6ey6zWAXJfAxJDq+xvcXMq4+Sin9q63+W6u2wa9o/QOVai0NqglMX55Q2aFD5u0NUylHGM
	E+2XIKCFwuWTIfDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774627670; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqt7sqz+Z/AOlrj075O/J83vs51Td6xl2fSsWyleBdc=;
	b=ja3Gn/8XuXTXwihUUdv/cNCmN7MtssZoejPOEB4PHAphVKwmoUC6Vq/PBFI2iqjZ6da52m
	CTuOg4cfctf1M6mSKiqiCutpFTQUglGOoUOblqKVKHdKzCSzYA07x/4N9kVH7EhlSTtMRR
	hDJrQZCA8Wb1B9w9DtTH8o8iDTISoOk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774627670;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Rqt7sqz+Z/AOlrj075O/J83vs51Td6xl2fSsWyleBdc=;
	b=6ey6zWAXJfAxJDq+xvcXMq4+Sin9q63+W6u2wa9o/QOVai0NqglMX55Q2aFD5u0NUylHGM
	E+2XIKCFwuWTIfDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F95B4A0A2;
	Fri, 27 Mar 2026 16:07:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NuaCD1arxmmuNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Mar 2026 16:07:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EE9B8A0976; Fri, 27 Mar 2026 17:07:34 +0100 (CET)
Date: Fri, 27 Mar 2026 17:07:34 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, willy@infradead.org, 
	miklos@szeredi.hu, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] mm: start background writeback based on per-wb
 threshold for strictlimit BDIs
Message-ID: <pkmsqdxopfvphud4qvionkl45qnz64xiuo4gnhd3m2mvy4m3xm@fcrenmksutyh>
References: <20260326234629.840938-1-joannelkoong@gmail.com>
 <20260326234629.840938-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326234629.840938-2-joannelkoong@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu 26-03-26 16:46:29, Joanne Koong wrote:
> The proactive nr_dirty > gdtc->bg_thresh check in balance_dirty_pages()
> only checks the global dirty threshold to start background writeback
> while the writer is still free-running, but for strictlimit BDIs (eg
> fuse), the per-wb dirty count can exceed the per-wb background threshold
> while the global threshold is not yet exceeded, so background writeback
> for this case never gets proactively started.
> 
> Add a per-wb threshold check for strictlimit BDIs so that background
> writeback is started when wb_dirty exceeds wb_bg_thresh, which drains
> dirty pages before the writer hits the throttle wall, matching the
> proactive behavior that the global check provides for non-strictlimit
> BDIs.
> 
> fio runs on fuse show about a 3-4% improvement in perf for buffered
> writes:
> fio --name=writeback_test --ioengine=psync --rw=write --bs=128k \
>     --size=2G --numjobs=4 --ramp_time=10 --runtime=20 \
>     --time_based --group_reporting=1 --direct=0
> 
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good. Thanks for improving these! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index c1a4b32af1a7..30f3d5a6270f 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1835,7 +1835,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  			balance_domain_limits(mdtc, strictlimit);
>  		}
>  
> -		if (nr_dirty > gdtc->bg_thresh && !writeback_in_progress(wb))
> +		if (!writeback_in_progress(wb) &&
> +		    (nr_dirty > gdtc->bg_thresh ||
> +		     (strictlimit && gdtc->wb_dirty > gdtc->wb_bg_thresh)))
>  			wb_start_background_writeback(wb);
>  
>  		/*
> @@ -1862,15 +1864,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 * Unconditionally start background writeback if it's not
>  		 * already in progress. We need to do this because the global
>  		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
> -		 * doesn't account for these cases:
> -		 *
> -		 * a) strictlimit BDIs: throttling is calculated using per-wb
> -		 * thresholds. The per-wb threshold can be exceeded even when
> -		 * nr_dirty < gdtc->bg_thresh
> -		 *
> -		 * b) memcg-based throttling: memcg uses its own dirty count and
> -		 * thresholds and can trigger throttling even when global
> -		 * nr_dirty < gdtc->bg_thresh
> +		 * doesn't account for the memcg-based throttling case. memcg
> +		 * uses its own dirty count and thresholds and can trigger
> +		 * throttling even when global nr_dirty < gdtc->bg_thresh
>  		 *
>  		 * Writeback needs to be started else the writer stalls in the
>  		 * throttle loop waiting for dirty pages to be written back
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
