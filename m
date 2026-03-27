Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53DD33F8B1
	for <linux-fsdevel@vger.kernel.org>; Fri, 27 Mar 2026 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774627470; cv=none; b=A7cLixNB6niIKMM8ZT0QnVbxeFv0zMvB5CobmWkyrFveHIGZwvYbZIn/9jUKiR25xak5g5vJcGmv7eGXmXD3siyd/fAtaTjWU8xECidJpJd0cG3AHoBnIP+AFIwvnUYUT/iBcpJTZyQJqqckxaeNgT0ZZaureO1Mi7kWD0cVrUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774627470; c=relaxed/simple;
	bh=4KSMoJi6RpPzYEzC6FncE4c1EddY/qwpQC6UY3q/emQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cwlsta0QKhYms9hzntKN8AmG2+9n2bDpbqeU/tD+DjjOK954w/ZzdZXTnZw/H17MsW131w/cijstLvvw2HjEohzD6iPQyzPVhdgpshA4RvpJHwlJLLODdObn+Zo4qxhYKa2aMLIDlR/3rYN32lY72c9yfozC6+N0m0kNnG25AD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=zgoHOdj3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Hrn4w0u; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1IS8VkSh; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IeVik0pq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="zgoHOdj3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Hrn4w0u";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1IS8VkSh";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IeVik0pq"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3A354D427;
	Fri, 27 Mar 2026 16:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774627467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgJOCPmwW5dXy+RP40xSPJQ5SlHLNJcw6k/uuw8+KxI=;
	b=zgoHOdj3cW3CVBEs9Dw0IicaGtiYynSuIr0k1zyotrsxVLv8wk2kDFnyivqvohIZHvEfUk
	KGmgGnLdd5tFdgO9nCpPofxmh4RA08BxcuLvpkNft9XPOG4UbTO3Gi7IeXvB+wCc4+oLQn
	oZZjbHp7G7FsY01NSz9b76xl7Vg8DEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774627467;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgJOCPmwW5dXy+RP40xSPJQ5SlHLNJcw6k/uuw8+KxI=;
	b=5Hrn4w0uVbDAaHzX7KAnWkL+naJRL20WQPLHA5yQw8IE4aouflZKmPaB4cI7FeglMfZ64n
	afYPFxbvQk1Tu2AA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774627466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgJOCPmwW5dXy+RP40xSPJQ5SlHLNJcw6k/uuw8+KxI=;
	b=1IS8VkShkTk9IQsIXhXVGBaM6req2voyLNiKiL8xnekc3WYunGfOnI9+/PAJXaBg6zxXny
	JeQFlF154NCj3p1rWMk3ccYyzZyAZH+Lyv6tVb9O7OPAiv5uGHyOsc7syLwGWlWloeEgqX
	T3WHKTznTRZ7cWcxqzcXCEjtrW1QSzo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774627466;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RgJOCPmwW5dXy+RP40xSPJQ5SlHLNJcw6k/uuw8+KxI=;
	b=IeVik0pqAycfnnME+zYk5Io7kaqelik1SRCvS6NsbkSCVCGW5vMIbe1eFfGbaAvUPu9lBu
	U511CVw7XP3C5jBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D79474A0A2;
	Fri, 27 Mar 2026 16:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PAybNIqqxmkgNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 27 Mar 2026 16:04:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 79149A0976; Fri, 27 Mar 2026 17:04:11 +0100 (CET)
Date: Fri, 27 Mar 2026 17:04:11 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, jack@suse.cz, hch@infradead.org, 
	hannes@cmpxchg.org, willy@infradead.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] mm: reinstate unconditional writeback start in
 balance_dirty_pages()
Message-ID: <5x6fwfy73rufcvhb4n74ffenbof6iftnupsouvm4wnmzdx2c6c@qhdnonwgjve6>
References: <20260326215127.3857682-1-joannelkoong@gmail.com>
 <20260326215127.3857682-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326215127.3857682-2-joannelkoong@gmail.com>
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Thu 26-03-26 14:51:27, Joanne Koong wrote:
> Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> unconditional writeback start from balance_dirty_pages():
> 
>        if (unlikely(!writeback_in_progress(wb)))
> 	       wb_start_background_writeback(wb);
> 
> This logic needs to be reinstated to prevent performance regressions for
> strictlimited BDIs and memcg setups. The problem occurs because:
> 
> a) For strictlimited BDIs, throttling is calculated using per-wb
> thresholds. The per-wb threshold can be exceeded even when the global
> dirty threshold was not exceeded (nr_dirty < gdtc->bg_thresh)
> 
> b) For memcg-based throttling, memcg uses its own dirty count /
> thresholds and can trigger throttling even when the global threshold
> isn't exceeded
> 
> Without the unconditional writeback start, IO is throttled as it waits
> for dirty pages to be written back but there is no writeback running.
> This leads to severe stalls. On fuse, buffered write performance
> dropped from 1400 MiB/s to 2000 KiB/s.
> 
> Reinstate the unconditional writeback start so that writeback is
> guaranteed to be running whenever IO needs to be throttled.
> 
> Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  mm/page-writeback.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 601a5e048d12..c1a4b32af1a7 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1858,6 +1858,27 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  			break;
>  		}
>  
> +		/*
> +		 * Unconditionally start background writeback if it's not
> +		 * already in progress. We need to do this because the global
> +		 * dirty threshold check above (nr_dirty > gdtc->bg_thresh)
> +		 * doesn't account for these cases:
> +		 *
> +		 * a) strictlimit BDIs: throttling is calculated using per-wb
> +		 * thresholds. The per-wb threshold can be exceeded even when
> +		 * nr_dirty < gdtc->bg_thresh
> +		 *
> +		 * b) memcg-based throttling: memcg uses its own dirty count and
> +		 * thresholds and can trigger throttling even when global
> +		 * nr_dirty < gdtc->bg_thresh
> +		 *
> +		 * Writeback needs to be started else the writer stalls in the
> +		 * throttle loop waiting for dirty pages to be written back
> +		 * while no writeback is running.
> +		 */
> +		if (unlikely(!writeback_in_progress(wb)))
> +			wb_start_background_writeback(wb);
> +
>  		mem_cgroup_flush_foreign(wb);
>  
>  		/*
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
