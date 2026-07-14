Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E439CCEE
	for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jul 2026 17:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784049018; cv=none; b=aNJs0tQstgKbHXJPkA0t0XYbNAC+OlWfIrwV0MzzeFIp4xRnyp4mPuJwuZjNTW8QE+C1OHz6IdA8ftp3hcrjAaWNJ70mlxyLO25Psx8pmHk4Ou09FEZcgWJu+wgXMX8ZO/DXh0MGMv0WufDnNwJKXfj2/H42SmI9Gs6ukdaTARQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784049018; c=relaxed/simple;
	bh=ql+WtXiju1TmdGiHrGommNGgAvPHu8GW4ovYZl9Ugfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8tL17XEblixwjfEGnF5eXfjwEdNNkug3bDTTVRdAJFUmtfv3pQ42ouQvLJXIPJscoTw5FLI4+kGQ/bDpNHr3kww5sswAkyguZQH3Mxl/OsFq1eLFvXO3e21w1lIJwccu3wCfwLGvSGjtB5d99PZmYBL9JcKuZb8kEo5sWXbxqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Uwn8A/dU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=wWBmG7X6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=bJBDKPsP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZWinf9Mu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Uwn8A/dU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="wWBmG7X6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="bJBDKPsP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZWinf9Mu"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AE02875931;
	Tue, 14 Jul 2026 17:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784049015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq65HxjS96GzSQbJcIB1UdAlTsGtC31W9ZjmCJ/+8o0=;
	b=Uwn8A/dUj8hZWwan0DhTob67jN7T7CtNwhBlECagYwKgHx/D9IuXb/uxPu1dDqeisdCBI1
	KVa0+qwmoaDS6rAUEgih5Yz4B+5hOXqfo+OhaxS0Ub6ZU2B2NxdS+LEehrfe1ncXvNRp/x
	yzEf68zYE+Gr87FmZXSbljvry0tTqmQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784049015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq65HxjS96GzSQbJcIB1UdAlTsGtC31W9ZjmCJ/+8o0=;
	b=wWBmG7X697ZLXtO79XHFO4MWOXA26j9pv7VBH0R8NI0KHKA41I/FcAcyKSKKDfTK9dGZR/
	Ar9vvpIj+4l6GfCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=bJBDKPsP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ZWinf9Mu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1784049012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq65HxjS96GzSQbJcIB1UdAlTsGtC31W9ZjmCJ/+8o0=;
	b=bJBDKPsPbNBvMQrK15vdTQ9tjIK6KCMzxz72sCOmYlMzMRun72NuCYfMHjUv7PqVntMaJm
	jF2+HKm7QSdRdi0R9g5dRQtlpVhYAhjSK5VFkDSiCvHPEh2Iup4X90wa/SgOmQvUMMe/XW
	WIjlaiAl7yGAXy7DULCVvCLQTth4MGA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1784049012;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rq65HxjS96GzSQbJcIB1UdAlTsGtC31W9ZjmCJ/+8o0=;
	b=ZWinf9MuCFuIZQdjkUgsp3zQfyqjuzlvNcwWR2xoMHUUlEhTczZD0eyGrtViRHK9Fqoa2I
	pusN/3K87ilw5TAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9998A779AE;
	Tue, 14 Jul 2026 17:10:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EGp6JXRtVmr7PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 14 Jul 2026 17:10:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 363E0A1319; Tue, 14 Jul 2026 19:10:12 +0200 (CEST)
Date: Tue, 14 Jul 2026 19:10:12 +0200
From: Jan Kara <jack@suse.cz>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com, fuse-devel <fuse-devel@lists.linux.dev>, 
	Jingbo Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <4fsrafuhoqgoirlt2sy6vk2ljvb3tdps4hqbcrm5qc2pr6tlaf@tboejm2wdq2s>
References: <CAJfpegsyHmSAYP04ot8neu_QtsCkTA2-qc2vvvLrsNLQt1aJCg@mail.gmail.com>
 <CAJnrk1anOVeNyzEe37p5H-z5UoKeccVMGBCUL_4pqzc=e2J7Ug@mail.gmail.com>
 <CAJnrk1bx+32Tq5DOk6=C+_smV2HgP3+RT6gpYLSNMEirFs_EkQ@mail.gmail.com>
 <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
 <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
 <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
 <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE02875931
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email,suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Mon 13-07-26 18:13:29, Joanne Koong wrote:
> On Sat, May 30, 2026 at 4:04 AM Jan Kara <jack@suse.cz> wrote:
> >
> > On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> > > On Thu, May 28, 2026 at 5:34 AM Jan Kara <jack@suse.cz> wrote:
> > > > > I think this is also going to be a problem for cgroups with large
> > > > > folios since they also, as I understand it, are constrained with a
> > > > > limited / tight dirty budget. I ran some initial benchmarks with
> > > > > cgroup memory constraints on NVMe and saw similar instability (a
> > > > > single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> > > > > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > > > > oscillating rather than settling near the set point).
> > > >
> > > > Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
> > > > was the write throughput of the NVMe drive? The high drive throughput also
> > > > requires more dirty data to keep the drive saturated so that writeback
> > > > throughput doesn't oscilate too much.
> > >
> > > The write throughput of the NVMe drive I was using was around ~1.1
> > > Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
> > > budget, the math for that ends up being that the device drains it in
> > > ~1.5 secs. The performance I was seeing with the initial cgroup
> > > benchmarks was with 4k pages (no large folios enabled) on btrfs.
> >
> > OK, you might want to experiment with some other filesystem (I suggest xfs
> > or ext4) as well. Btrfs writeback behavior is a bit special with its data
> > checksum computations etc. and thus latency of starting writeback. It could
> > contribute to the erratic behavior with the relatively low dirty limits.
> 
> I reran the benchmarks on xfs and ext4 and saw similiar results. The
> max write latency under the memcg were
> xfs        5.1s
> ext4      5.2 s
> btrfs      6.2 s
> 
> compared to the non-memcg case (0.4 to 2.0 ms). This didn't affect
> throughput though, just the tail latency. When I ran xfs with large
> folios disabled, I still saw ~4.1s.

OK, interesting. Thanks for running these tests! Also it is good to know
this is not really related to large folios, that somewhat simplifies
matters.

> From the balance_dirty_pages() ftrace tracepoints, the dirty_ratelimit
> value is consistently stable / accurate but it looks like what's
> happening is that during freerun, the writer essentially dirties at
> memcpy speed until the freerun ceiling, and then the soft/proportional
> throttling kicks in but doesn't kick in fast or hard enough, which
> allows the number of dirty pages to exceed the hard limit by ~2x, and
> then at that point the writer is forced into the loop where it sleeps
> max_pause (200ms) each iteration until writeback has drained the
> number of dirty pages back under the limit.

OK, above you mentioned that the dirty limit for the memcgs is set at
1.6GB. Does that mean that dirty throttling allows memcg to dirty up to
~3.2GB of pages? I wouldn't have expected that...

Also you mentioned that the disk you are using has writeback throughput of
~1.1GB/s. Even with 3.2GB of pages we should get below the dirty limit in
2s and not 5. So there's something going on I don't understand yet :)

BTW how much memory does the machine have in total?

> If we wanted to fix this, it seems like we could for
> memory-constrained memcgs either start soft/proportional throttling
> earlier or make it throttle more aggressively as dirty approaches the
> limit, or start writeback sooner so it finishes draining the dirty
> pages faster. When I experimented with lowering
> dirty_background_ratio, the worst-case latency dropped around 2-3x
> (~6s to 2s) but there was still multi-second tail latencies. Maybe
> this indicates more that the throttling needs to happen earlier/harder
> than that writeback needs to happen earlier.

Hum, can you share the script you are using for the benchmark? I can try
running in on my machine and see what happens. If I'm able to reproduce
these long waits, I want to do a bit of tracing to understand what's
happening with various writeback statistics. Because these large tail
latencies aren't really expected. The original design goal was to keep
maximum write latency (for fast enough disks) around 0.2s.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
