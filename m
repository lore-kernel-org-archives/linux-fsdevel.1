Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8283CFF44
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Mar 2026 11:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921540; cv=none; b=pnfjAJESHz5+oyy/xHXq+awphPQgqoS+hBsUZbaBKOiGC6QReA3yWglQdnMyixuqQ2XbEo9SOR3MpviApkadKqnpwJ8P+xUFbpdotEh3HZjVClEADYooArBESg237EU3OfmPyOlw/G9pdtRN5MLUOINojxbIRfUhw6iZAVfo7q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921540; c=relaxed/simple;
	bh=LxPlIZV0allZ2w2sTX7gfTM5N5LSdHBemqYEo36rTnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B82AQYM53jOHdJKQl9lYLpCXTNR/FDOrISEdMHxmbLs3MYqOtzNim5OUnPPslbfQGRjdhVA+CkG1Qm5EFh+hAizQkP4azHYVV7cKeCzCNVeb4xHoJocyFM6WeRDZ1CtfWbrXOpVyHWB1K/dVYhH+ljUNPISIU38Jsbv+XH399nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nSKhg5D9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwzdr+xX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nSKhg5D9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zwzdr+xX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nSKhg5D9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwzdr+xX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nSKhg5D9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zwzdr+xX"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B50F15BD45;
	Thu, 19 Mar 2026 11:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773921535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKoAmC5H5WL0MZfIguD4pR+XH+ZQMjAOOTptAPJl/Y8=;
	b=nSKhg5D9cRCTMSxWiaWiUbsfNSOulM/++tiDrKjaYiWcHL6m+7V9IBkKBm9F/jZz5GjsIE
	Y2YeBGqTzv7Z5Rp2lx+Tx54T5YqKOmjcMVoL8/tEDj2M1p+Ku/gw8tkQSfYwZIJDr34zIl
	LDVe8tjTg3LD3BA87H5Ew7BLE3/cj0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773921535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKoAmC5H5WL0MZfIguD4pR+XH+ZQMjAOOTptAPJl/Y8=;
	b=zwzdr+xXpSPMkxZs3hlI0VJumMhkiI92xqBgRmeS4UMVCMSFNlKy+bxxRQ2qvYDrfTfywu
	T0TsNZ3vwOLE1jBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=nSKhg5D9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zwzdr+xX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1773921535; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKoAmC5H5WL0MZfIguD4pR+XH+ZQMjAOOTptAPJl/Y8=;
	b=nSKhg5D9cRCTMSxWiaWiUbsfNSOulM/++tiDrKjaYiWcHL6m+7V9IBkKBm9F/jZz5GjsIE
	Y2YeBGqTzv7Z5Rp2lx+Tx54T5YqKOmjcMVoL8/tEDj2M1p+Ku/gw8tkQSfYwZIJDr34zIl
	LDVe8tjTg3LD3BA87H5Ew7BLE3/cj0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1773921535;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oKoAmC5H5WL0MZfIguD4pR+XH+ZQMjAOOTptAPJl/Y8=;
	b=zwzdr+xXpSPMkxZs3hlI0VJumMhkiI92xqBgRmeS4UMVCMSFNlKy+bxxRQ2qvYDrfTfywu
	T0TsNZ3vwOLE1jBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9DFFE4273B;
	Thu, 19 Mar 2026 11:58:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gyWLJv/ku2nLVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 11:58:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 54B4CA0B32; Thu, 19 Mar 2026 12:58:51 +0100 (CET)
Date: Thu, 19 Mar 2026 12:58:51 +0100
From: Jan Kara <jack@suse.cz>
To: Yunzhao Li <yunzhao@cloudflare.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	Jesper Brouer <jesper@cloudflare.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Suren Baghdasaryan <surenb@google.com>
Subject: Re: balance_dirty_pages() causes 40% IO PSI (full) with no drain
 benefit on 384 GB machine
Message-ID: <z3quejtbpkiizgmvu2pjhqv6ioyach2wszen5slkau2hossj7p@rk2ftlwbdfw5>
References: <CAAnvDSwOoEOkMEDgKUcHkx-SdmZ_ar5AbVy4Gp-XT7i04ON5fg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAnvDSwOoEOkMEDgKUcHkx-SdmZ_ar5AbVy4Gp-XT7i04ON5fg@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: B50F15BD45
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 

Hello,

[looks more like a question about IO PSI behavior so CCing relevant people]

On Tue 17-03-26 15:53:51, Yunzhao Li wrote:
> On a 384 GB machine with NVMe storage (2x NVMe RAID0, dm-crypt,
> XFS, kernel 6.12, AMD EPYC 9684X 96-Core), balance_dirty_pages()
> throttles writers via io_schedule_timeout(), causing 26-40% IO PSI(full).
> But the throttling doesn't actually drain dirty pages faster.
> The flusher only submits ~578 MB/s of writeback regardless of
> whether writers are throttled, and the NVMe device has ample
> spare capacity (1,044 MB/s benchmarked).
> 
> I'd like to understand whether this is expected and what the
> right approach is.
> 
> The setup
> ---------
> 
>   dirty_background_ratio=10, dirty_ratio=20 (defaults)
>   dirtyable memory: ~77 GB
>   -> bg_thresh:       10% * 77 GB         =  7.7 GB
>   -> freerun ceiling: (20%+10%)/2 * 77 GB = 11.7 GB
>   -> limit (hard):    20% * 77 GB         = 15.5 GB
> 
>   Write generation:   ~580 MB/s (HTTP cache miss writes)
>   Flusher drain rate: ~578 MB/s (device can do 1044 MB/s
>                        flusher can't feed it fast enough)
> 
> Below freerun, balance_dirty_pages() returns immediately.
> Between freerun and limit, pos_ratio ramps from 2.0 down to 0
> via cubic polynomial that tasks sleep proportionally in
> io_schedule_timeout(). At limit, pos_ratio=0 and all writers
> block (max 200ms sleep).
> 
> Generation ≈ drain, so dirty settles at 10-14 GB — crossing
> the freerun ceiling into the proportional throttle zone.
> 
> The observation
> ---------------
> 
>                  throughput  IO PSI full
>   dirty 5-10 GB:  494 MB/s       1.4%
>   dirty >10 GB:   578 MB/s      26.2%
>                   (dirty still accumulating at +2 MB/s)
> 
>   Peak IO PSI full: 39.5%.
> 
> The proportional throttle adds 26% IO PSI (full) but dirty
> still grows. The flusher is already at its submission ceiling
> and sleeping writers doesn't help it submit I/O faster.

The throttling of the writers works as it should - the point is to not
allow writers to dirty more memory than is the configured limit and as your
data shows that is indeed what the code successfully does. The point of
throttling is *not* to speed up writeback or anything like that what you
describe above. You are correct that page writeback using single flush
worker isn't able to saturate relatively fast storage - that is a
limitation of current writeback subsystem and is something that is being
worked on (by allowing more parallel writeback workers) but it isn't IMHO
substantial for this report.

I cannot really comment whether IO PSI of 40% is or is not appropriate for
this situation - I'm deferring that to PSI guys I've CCed.

> The device is actually starved: writeback-in-flight drops from 6-8 MB
> (baseline) to 1.8 MB (during throttle), and NVMe QD drops from 45 to 37.
> The device could drain more if fed more, but the flusher can't feed it
> faster.
> 
> Meanwhile, memory is not scarce:
> 
>   Dirty:          16 GB
>   Clean file LRU: 57 GB  (instantly reclaimable)
>   Memory PSI:     1-2%
> 
> The dirty pages aren't causing memory pressure. 57 GB of clean
> pages remain available for instant reclaim. The throttle is
> protecting a resource that isn't scarce, at a cost of 40% IO
> PSI (full).

The configuration is that no more than 20% of you page cache can be dirty.
The throttling code just makes sure this is the case. If you configure
higher limit, that's what throttling code will enforce. However note that
higher amount of dirty memory is unlikely to increase writeback speed -
that is likely bottlenecked on CPU overhead of submitting writeback IOs.
Also note that the limit is set to 20% because dirty memory is not possible
to reclaim fast (you need to write it back first) and so in case of memory
pressure the machine can easily trash for quite some time if the dirty
limits are too high.

> Our workaround plan: dirty_background_ratio=5, dirty_ratio=40.
> This raises freerun to ~17.5 GB, keeping dirty in freerun.
> The flusher drains identically. It runs to bg_thresh either
> way.
> 
> Questions
> ---------
> 
> 1. When should balance_dirty_pages() sleep writers? Currently
>    the criterion is "dirty > fraction of dirtyable memory."
>    This doesn't consider whether sleeping actually helps
>    drain dirty faster, or whether the remaining clean pages
>    are sufficient. Should the decision factor in flusher/
>    device saturation or available reclaimable memory?

I think I've answered this above.

> 2. Is tuning dirty_ratio to 30-40% the expected approach for
>    high-memory (>256 GB) systems? Documentation doesn't
>    cover this.

No, it is actually recommened to set it lower because more dirty memory
doesn't usually help IO throughput beyond certain amount. But it all
depends very much on your workload and it's dirtying pattern (how much of
the page cache gets frequently redirtied).

> 3. The freerun ceiling gates entry into the proportional
>    throttle path. Even moderate sleeping shows up as IO PSI
>    (io_schedule_timeout is accounted as IO stall). Dirty
>    never hits the hard limit in our case. It sits in the
>    proportional zone, but cumulative PSI from many tasks
>    sleeping short durations is already 26-40% (full). Should
>    the throttle path be skipped when sleeping cannot help
>    drain?

Perhaps bumping PSI when dirty throttling kicks in is not ideal measure
(because it doesn't necessarily mean the storage itself is maxed out,
besides flush worker not being able to saturate the storage there can be
also various block layer controllers arbitrarily throttling background
writeback) but again I'll let PSI guys to chime in here with their
opinions.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
