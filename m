Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3590370D6E
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784111527; cv=none; b=MWmx8bjPAU1777+f1BJ7kPjvSDfrnTboMVJyQ82scJD5rxH458Uvj0wjW8mOwuSMcRodmWroO4iV6R9rIg4/hr3lrvZlrBhQRai5zUW2+e9n0EyzKnuHWZEjMLJKPQQ/qGerIGIssydib2Osw+P2EivVoML71tZ2IQEe0iWmryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784111527; c=relaxed/simple;
	bh=fMhvh+sDkJXZAH2+uvDQf4kpujZF50DvLIyACmmGXXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhJhNHXr5lv6iKT7nDZtcCtzI4TKAGbqG60OlVs/MnX+0JB3PPvluhzla7lDIl5z7/na1zrMINhs98L1E4h7Czz7rWN+gMNT3QZy0l+Jpekf5jAwFqSHX5ZgjtSEFSlhB3WwnDltedJi52CiorNu0Pzf1+CdxZ6XwA4LZQpF4rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tWZy10/2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsSqAJTH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tWZy10/2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IsSqAJTH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWZy10/2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsSqAJTH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tWZy10/2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IsSqAJTH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A412478349;
	Wed, 15 Jul 2026 10:32:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784111523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu006ZHK9+9+5I7DV7PhNj40UE38tqtHLTPGsQ5G4UM=;
	b=tWZy10/2or0rb61GJPIdi7qTD4TYuswptY5xX3Cb3Gpq7uJ9azhk4RfkaomKGjzJlWh+Ql
	rNLplxuEf88mEQzV+hzOUMQ/z4Rm6Kw2y890x58faqqymi4BoMu4zIcVrzESCIQcjcIcjO
	DE8//TAUD0emAUd4OHk9UnShif6toe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784111523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu006ZHK9+9+5I7DV7PhNj40UE38tqtHLTPGsQ5G4UM=;
	b=IsSqAJTHDYay0cs6zmM+kbCdj3BDRed9nbuiBiRlHil+qA/Fqef+oi7ZRcGXPpBY8sAiV0
	oPDRMYn9Yul7IoDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784111523; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu006ZHK9+9+5I7DV7PhNj40UE38tqtHLTPGsQ5G4UM=;
	b=tWZy10/2or0rb61GJPIdi7qTD4TYuswptY5xX3Cb3Gpq7uJ9azhk4RfkaomKGjzJlWh+Ql
	rNLplxuEf88mEQzV+hzOUMQ/z4Rm6Kw2y890x58faqqymi4BoMu4zIcVrzESCIQcjcIcjO
	DE8//TAUD0emAUd4OHk9UnShif6toe8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784111523;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qu006ZHK9+9+5I7DV7PhNj40UE38tqtHLTPGsQ5G4UM=;
	b=IsSqAJTHDYay0cs6zmM+kbCdj3BDRed9nbuiBiRlHil+qA/Fqef+oi7ZRcGXPpBY8sAiV0
	oPDRMYn9Yul7IoDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 993E6779AD;
	Wed, 15 Jul 2026 10:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id os9mJaNhV2q+XQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 15 Jul 2026 10:32:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 467D7A1323; Wed, 15 Jul 2026 12:31:59 +0200 (CEST)
Date: Wed, 15 Jul 2026 12:31:59 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, fuse-devel <fuse-devel@lists.linux.dev>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <ue5xd6f4nfggwodfhbqaispmr5aq2dyszezvy26bl4rtsk6xii@uceqazdioj3o>
References: <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
 <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
 <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
 <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
 <4fsrafuhoqgoirlt2sy6vk2ljvb3tdps4hqbcrm5qc2pr6tlaf@tboejm2wdq2s>
 <CAJnrk1b65ypz4bdtd1rTQBYOpOEP+DcoZJUSL87jVDssW1A+pw@mail.gmail.com>
 <nv2h2dd2xoj4zjfvnhsxud2p5e2uw3og22ovqureik4pey72qb@i75tn5ttavfo>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nv2h2dd2xoj4zjfvnhsxud2p5e2uw3og22ovqureik4pey72qb@i75tn5ttavfo>
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

[resending once more, this time with correct Shakeel's address]

On Tue 14-07-26 18:21:57, Joanne Koong wrote:
> On Tue, Jul 14, 2026 at 10:10 AM Jan Kara <jack@suse.cz> wrote:
> > On Mon 13-07-26 18:13:29, Joanne Koong wrote:
> > > On Sat, May 30, 2026 at 4:04 AM Jan Kara <jack@suse.cz> wrote:
> > > > On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> > > > > On Thu, May 28, 2026 at 5:34 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > > I think this is also going to be a problem for cgroups with large
> > > > > > > folios since they also, as I understand it, are constrained with a
> > > > > > > limited / tight dirty budget. I ran some initial benchmarks with
> > > > > > > cgroup memory constraints on NVMe and saw similar instability (a
> > > > > > > single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> > > > > > > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > > > > > > oscillating rather than settling near the set point).
> > > > > >
> > > > > > Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
> > > > > > was the write throughput of the NVMe drive? The high drive throughput also
> > > > > > requires more dirty data to keep the drive saturated so that writeback
> > > > > > throughput doesn't oscilate too much.
> > > > >
> > > > > The write throughput of the NVMe drive I was using was around ~1.1
> > > > > Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
> > > > > budget, the math for that ends up being that the device drains it in
> > > > > ~1.5 secs. The performance I was seeing with the initial cgroup
> > > > > benchmarks was with 4k pages (no large folios enabled) on btrfs.
> > > >
> > > > OK, you might want to experiment with some other filesystem (I suggest xfs
> > > > or ext4) as well. Btrfs writeback behavior is a bit special with its data
> > > > checksum computations etc. and thus latency of starting writeback. It could
> > > > contribute to the erratic behavior with the relatively low dirty limits.
> > >
> > > I reran the benchmarks on xfs and ext4 and saw similiar results. The
> > > max write latency under the memcg were
> > > xfs        5.1s
> > > ext4      5.2 s
> > > btrfs      6.2 s
> > >
> > > compared to the non-memcg case (0.4 to 2.0 ms). This didn't affect
> > > throughput though, just the tail latency. When I ran xfs with large
> > > folios disabled, I still saw ~4.1s.
> >
> > OK, interesting. Thanks for running these tests! Also it is good to know
> > this is not really related to large folios, that somewhat simplifies
> > matters.
> >
> > > From the balance_dirty_pages() ftrace tracepoints, the dirty_ratelimit
> > > value is consistently stable / accurate but it looks like what's
> > > happening is that during freerun, the writer essentially dirties at
> > > memcpy speed until the freerun ceiling, and then the soft/proportional
> > > throttling kicks in but doesn't kick in fast or hard enough, which
> > > allows the number of dirty pages to exceed the hard limit by ~2x, and
> > > then at that point the writer is forced into the loop where it sleeps
> > > max_pause (200ms) each iteration until writeback has drained the
> > > number of dirty pages back under the limit.
> >
> > OK, above you mentioned that the dirty limit for the memcgs is set at
> > 1.6GB. Does that mean that dirty throttling allows memcg to dirty up to
> > ~3.2GB of pages? I wouldn't have expected that...
> 
> On a couple of the runs, I saw it get as high as up to 5GB.
> 
> I think this is because the balance_dirty_pages() code uses the memcg
> stats (NR_FILE_DIRTY) but these stats are only periodically
> flushed/refreshed when reading it, so the balance dirty code is
> seeing/using lagging/non-uptodate values.
> 
> I'm seeing this in
>   balance_dirty_pages()
>       balance_domain_limits(mdtc,...)
>           domain_dirty_avail()
>                 mem_cgroup_wb_stats()
>                        mem_cgroup_flush_stats_ratelimited()
> 
> where mem_cgroup_flush_stats_ratelimted() has this logic:
> 
> void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> {
>         /* Only flush if the periodic flusher is one full cycle late */
>         if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
>                 mem_cgroup_flush_stats(memcg);
> }
> 
> where FLUSH_TIME is defined as 2UL * HZ, which afaict means the
> flushing can be around 2 seconds stale (accounting for the periodic
> flusher in flush_memcg_stats_dwork() that flushes every FLUSH_TIME
> interval).
> 
> From what I see, the freerun and hard limit checks use this stale
> under-reported value (in domain_dirty_freerun() and
> wb_position_ratio()), which means the writer gets to keep dirtying and
> blow past the limit for up to 2 extra seconds before the throttling
> limits it.

I see. That would indeed explain why we can overrun the dirty limit so
much.

> Maybe one idea is to in the memcg throttle path do the flush based on
> how many pages are getting dirtied instead of on how much time has
> elapsed? It looks like flushing grabs the rstat lock though, so maybe
> only doing it in the throttled case where it's past freerun would be
> best. It looks like the logic in the regular non-ratelimited
> mem_cgroup_flush_stats() call does something similar. I can run some
> experiments this week with this if you think it could be promising.

Checking some git history, this actually seems to be a relatively recent
change from Shakeel (added to CC) - d9b3ce8769e3 ("mm: writeback: ratelimit
stat flush from mem_cgroup_wb_stats"). So you can check whether reverting
that change makes dirty throttling not overshoot so much.

Shakeel, your change to use mem_cgroup_flush_stats_ratelimited() in
mem_cgroup_wb_stats() results in applications overshooting memcg dirty
limits by several gigabytes which for small memcgs (with 8GB memory in this
case, which means a dirty limit of ~1.5GB) is a considerable issue. I guess
the ratelimiting should take into account the size of memcg (or ideally the
dirty limit in the case of mem_cgroup_wb_stats()) as well. Using
somewhat outdated numbers for dirty throttling is fine but when we can
overshoot the dirty limit more than three times, it leads to rather long
stalls in dirty throttling and similar issues...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
