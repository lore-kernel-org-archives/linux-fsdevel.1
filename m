Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70993351C32
	for <linux-fsdevel@vger.kernel.org>; Thu, 26 Mar 2026 08:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514937; cv=none; b=AnojMEaQpi+Ny59wtqkl2Ba4itXXuE9/si14EjH/2B+rvTVi9fAFDoGBfNtZi8SkN6sj8cZLG2TjROuFohiHqosiD5FMw1kN1rRqTUU2TIFAf7AMIgJTId/sdWOHgNN/cKfX5+mJdq760yA+iCT//2BiU4S5YXUXpvBzD2Yw0lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514937; c=relaxed/simple;
	bh=ZD9v4AMKjrTbDunRUhb2/eubi45MYC3CIg6JrT+ASbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AmzzOeHP0Mz5Oa5HO9oDc0li8SNR9iW/vdudYQfdiGSaAEsSH9QxK3xZphg9+I/08K27eJKuXOEIxUwzpdwO0Im+SBjL82p8j6lHFs3Jgynr4eaA8FfXSOtZFXQmtXNlOlecEvows+NHpISm2LFldmv9JvzT93ABSgrrtv/pjzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0Oxt7yR3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=azaDylUx; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rplQ+VPg; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wPBLDhR7; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0Oxt7yR3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="azaDylUx";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rplQ+VPg";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wPBLDhR7"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EDA785BCF4;
	Thu, 26 Mar 2026 08:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774514929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnbEqvKAd1umNPypewf+IOICrqQu9pmFoTVtZPEsqZM=;
	b=0Oxt7yR3pKsJxG794dJ1CnhiQ7jNgFvGyFD6fHTrYV6KktBbGonj3wy6LuvEbnXnA55M9a
	5znR54+aaHh+AM7fdYpO3ImrIW361b+TM3Vepol1KkXbMypgV82+2Q5pDs3Ym7swfoOydo
	B9f+7BVZ+oI20i+ythVEYt/wVDHqSgQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774514929;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnbEqvKAd1umNPypewf+IOICrqQu9pmFoTVtZPEsqZM=;
	b=azaDylUxg5+DP2OXZPmcOlCsTi6mhsTxYCseyrOgULoKGoh0QfYqLC8wl5W+mcGKiBzkdI
	QuMZ7CouagYJxoBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1774514928; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnbEqvKAd1umNPypewf+IOICrqQu9pmFoTVtZPEsqZM=;
	b=rplQ+VPgSqlRFihjDumPRJzdBuZKPDjdB5nCg5nTvAh00ALVXKmnkrQmnG1x6PyPziT2Jc
	9xt6Ce+auEtLM2g8K1OA+TScc2iSRvtAtqAQ5wxjlUcCo1pDIKJm3h/mb8WaQbFzrEIluO
	ss7/m8yrO1GOhYIKl8lstVa8xy8eWuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1774514928;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EnbEqvKAd1umNPypewf+IOICrqQu9pmFoTVtZPEsqZM=;
	b=wPBLDhR7JdXXaFP/VkUwk5EauLVXV+fHAiSls3auDBypYaFyiFM163QYkbIopQyGFumzpb
	voERPB6qNNYja1DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E40134A0A3;
	Thu, 26 Mar 2026 08:48:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kkCjN/DyxGlADwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 26 Mar 2026 08:48:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A9C7BA0976; Thu, 26 Mar 2026 09:48:44 +0100 (CET)
Date: Thu, 26 Mar 2026 09:48:44 +0100
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: akpm@linux-foundation.org, hannes@cmpxchg.org, jack@suse.cz, 
	willy@infradead.org, miklos@szeredi.hu, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v1] mm: fix writeback regression for strictlimit BDIs
Message-ID: <yet2ddivcs3v4g5wmr4zfjkwsbzfjmwjhq56zur7wjivd72abs@tq23xp4mle2o>
References: <20260326001337.828947-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326001337.828947-1-joannelkoong@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.989];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On Wed 25-03-26 17:13:37, Joanne Koong wrote:
> Commit 64dd89ae01f2 ("mm/block/fs: remove laptop_mode") removed this
> unconditional writeback kick from balance_dirty_pages():
> 
>        if (unlikely(!writeback_in_progress(wb)))
> 	       wb_start_background_writeback(wb);
> 
> Earlier in balance_dirty_pages(), background writeback is started if the
> global dirty count exceeds the global background threshold (nr_dirty >
> gdtc->bg_thresh). However for BDIs with BDI_CAP_STRICTLIMIT set (eg
> fuse), throttling is calculated using the per-wb threshold, not global
> thresholds. This means the per-wb threshold can be exceeded while the
> global nr_dirty is below gdtc->bg_thresh. This causes two problems:
> 
> a) background writeback is never proactively kicked off. The flusher
> should be kicked off while the writer is still free-running, so that
> dirty pages are drained before the writer hits the throttle threshold.
> For strictlimit BDIs with global nr_dirty < gdtc->bg_thresh, this never
> kicks off the flusher, so dirty pages pile up unchecked until the per-wb
> freerun ceiling gets hit and IO is throttled
> 
> b) while IO is throttled, the flusher is still not started, which means
> the writer basically sits in the throttle loop sleeping while waiting
> for dirty pages to be cleaned but no writeback is running
> 
> This leads to severe stalls and degraded throughput. On fuse, buffered
> write performance drops from 1400 MiB/s to 2000 KiB/s.
> 
> This fixes the issue by kicking off the flusher if wb_dirty exceeds
> wb_bg_thresh for strictlimit BDIs. This restores performance back to its
> original baseline.
> 
> Fixes: 64dd89ae01f2 ("mm/block/fs: remove laptop_mode")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Good spotting! I think your change makes sense but I don't think it is
enough. The problem is that writeback throttling depends also on memcg
setup so with your fix we still have a problem that when throttling due to
memcg limits the flush work won't be queued early enough / at all. So I
think the best fix is to perhaps do your change so that background
writeback is started earlier for strictlimit bdis but also return back the
unconditional starting of writeback (with properly updated comment) when we
find out we're going to throttle the task for whatever reason.

								Honza

> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index 601a5e048d12..3f89b08b11b4 100644
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
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
