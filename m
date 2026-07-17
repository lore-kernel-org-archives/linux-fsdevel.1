Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBF92F7EE4;
	Fri, 17 Jul 2026 17:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784307863; cv=none; b=nYsejpgRj5U2FRussijZdROM3Q13LB0M6hhhdI490RFz0fHXUcuNk4Fo33nb/eQnJn5HH7bU+0oi2OtjmNmYio8rJpRApc5L0wX80Mdyq8YSatVhPQnHDnwDf20ygo2LTSXxNmqyKdva+12Zepu4Iv3yQjWj24S+rr0HpYBw7XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784307863; c=relaxed/simple;
	bh=VjXFCsqfplsE0j+Stv2XbArRzEV1sTKf7HM+DkwOvu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FSD2apVldDcGBb60B6f2OMWQiDDE4xKFq2PQoor542+lVM/njHtWYNoRmUIy45ISyjXQSZ96nmygQ3KUUYAPWiMSDBBXM/9fhx/cIhUwd0D7jX4G3nZHDveAJHXPHF12lLQZWCK3Wy6XOQ3QFPBp1U/XKUOWCT9LHqqsAeVrbNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dM9vVK8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dM9vVK8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B993C1F000E9;
	Fri, 17 Jul 2026 17:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784307862;
	bh=JflBIwr9F4IB2ttQoxuX21r2le3oA+itcyh0V4M6CU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dM9vVK8O45UfnaT+yz4BAyzhGK9k3nCpKi/8CNXdSCFGZ8pyD5GA0/lG7XL9k5tWB
	 USkDBKScNOSksxmsTcgp4h+gBsnhdJX2w1+pDoD0ltBEycJvoxa/1koYT+XECewztJ
	 UPvMT958xAvAZJeQO9ardXCk7d0TQ10PDCqmwBDziX75nFrZHUhAjr1oPPj/Z7zvIP
	 ahlFWzYNyCv4Zkk0kCVddwtheW1TwjUa7O+JpvZjHvDDWRZGZiwWzw1Yi6IDMqVXaB
	 +XOgJG1lsjTEU174+ZelFEnpVRI49r6qDl7AisHdy6/gIFiFaMlkQcZhFIbFimlYdW
	 L2ZS1LRebI9TA==
Date: Fri, 17 Jul 2026 17:04:20 +0000
From: Yosry Ahmed <yosry@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
Message-ID: <alpfQxaYs5hQ0BaU@google.com>
References: <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
 <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
 <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
 <4fsrafuhoqgoirlt2sy6vk2ljvb3tdps4hqbcrm5qc2pr6tlaf@tboejm2wdq2s>
 <CAJnrk1b65ypz4bdtd1rTQBYOpOEP+DcoZJUSL87jVDssW1A+pw@mail.gmail.com>
 <nv2h2dd2xoj4zjfvnhsxud2p5e2uw3og22ovqureik4pey72qb@i75tn5ttavfo>
 <ue5xd6f4nfggwodfhbqaispmr5aq2dyszezvy26bl4rtsk6xii@uceqazdioj3o>
 <CAJnrk1bwabyWY+rzzSKfKWp3rivcQm=zae3xzNSZc2hnLj6-Aw@mail.gmail.com>
 <aljxUvui60dm3yvj@linux.dev>
 <CAJnrk1aTx44=jy0ODHY2sHh16bKsYkwBKj_O-MsnZYjXGW2cCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1aTx44=jy0ODHY2sHh16bKsYkwBKj_O-MsnZYjXGW2cCA@mail.gmail.com>

On Thu, Jul 16, 2026 at 03:31:00PM -0700, Joanne Koong wrote:
> On Thu, Jul 16, 2026 at 8:12 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > Hi Jan & Joanne,
> >
> > On Wed, Jul 15, 2026 at 06:28:16PM -0700, Joanne Koong wrote:
> > > On Wed, Jul 15, 2026 at 3:32 AM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > [resending once more, this time with correct Shakeel's address]
> > > >
> > > > On Tue 14-07-26 18:21:57, Joanne Koong wrote:
> > > > > On Tue, Jul 14, 2026 at 10:10 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > On Mon 13-07-26 18:13:29, Joanne Koong wrote:
> > > > > > > On Sat, May 30, 2026 at 4:04 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> > > > > > > > > On Thu, May 28, 2026 at 5:34 AM Jan Kara <jack@suse.cz> wrote:
> > > > > > > > > > > I think this is also going to be a problem for cgroups with large
> > > > > > > > > > > folios since they also, as I understand it, are constrained with a
> > > > > > > > > > > limited / tight dirty budget. I ran some initial benchmarks with
> > > > > > > > > > > cgroup memory constraints on NVMe and saw similar instability (a
> > > > > > > > > > > single writer in a 8 GB cgroup had max write latencies of 6 seconds vs
> > > > > > > > > > > 15 ms without the cgroup, with the balance_dirty_pages() throttling
> > > > > > > > > > > oscillating rather than settling near the set point).
> > > > > > > > > >
> > > > > > > > > > Ok, so this is more folios (819) than my 512 gut feeling estimate :) What
> > > > > > > > > > was the write throughput of the NVMe drive? The high drive throughput also
> > > > > > > > > > requires more dirty data to keep the drive saturated so that writeback
> > > > > > > > > > throughput doesn't oscilate too much.
> > > > > > > > >
> > > > > > > > > The write throughput of the NVMe drive I was using was around ~1.1
> > > > > > > > > Gb/s (measured by running direct I/O). I think with the 1.6GB dirty
> > > > > > > > > budget, the math for that ends up being that the device drains it in
> > > > > > > > > ~1.5 secs. The performance I was seeing with the initial cgroup
> > > > > > > > > benchmarks was with 4k pages (no large folios enabled) on btrfs.
> > > > > > > >
> > > > > > > > OK, you might want to experiment with some other filesystem (I suggest xfs
> > > > > > > > or ext4) as well. Btrfs writeback behavior is a bit special with its data
> > > > > > > > checksum computations etc. and thus latency of starting writeback. It could
> > > > > > > > contribute to the erratic behavior with the relatively low dirty limits.
> > > > > > >
> > > > > > > I reran the benchmarks on xfs and ext4 and saw similiar results. The
> > > > > > > max write latency under the memcg were
> > > > > > > xfs        5.1s
> > > > > > > ext4      5.2 s
> > > > > > > btrfs      6.2 s
> > > > > > >
> > > > > > > compared to the non-memcg case (0.4 to 2.0 ms). This didn't affect
> > > > > > > throughput though, just the tail latency. When I ran xfs with large
> > > > > > > folios disabled, I still saw ~4.1s.
> > > > > >
> > > > > > OK, interesting. Thanks for running these tests! Also it is good to know
> > > > > > this is not really related to large folios, that somewhat simplifies
> > > > > > matters.
> > > > > >
> > > > > > > From the balance_dirty_pages() ftrace tracepoints, the dirty_ratelimit
> > > > > > > value is consistently stable / accurate but it looks like what's
> > > > > > > happening is that during freerun, the writer essentially dirties at
> > > > > > > memcpy speed until the freerun ceiling, and then the soft/proportional
> > > > > > > throttling kicks in but doesn't kick in fast or hard enough, which
> > > > > > > allows the number of dirty pages to exceed the hard limit by ~2x, and
> > > > > > > then at that point the writer is forced into the loop where it sleeps
> > > > > > > max_pause (200ms) each iteration until writeback has drained the
> > > > > > > number of dirty pages back under the limit.
> > > > > >
> > > > > > OK, above you mentioned that the dirty limit for the memcgs is set at
> > > > > > 1.6GB. Does that mean that dirty throttling allows memcg to dirty up to
> > > > > > ~3.2GB of pages? I wouldn't have expected that...
> > > > >
> > > > > On a couple of the runs, I saw it get as high as up to 5GB.
> > > > >
> > > > > I think this is because the balance_dirty_pages() code uses the memcg
> > > > > stats (NR_FILE_DIRTY) but these stats are only periodically
> > > > > flushed/refreshed when reading it, so the balance dirty code is
> > > > > seeing/using lagging/non-uptodate values.
> > > > >
> > > > > I'm seeing this in
> > > > >   balance_dirty_pages()
> > > > >       balance_domain_limits(mdtc,...)
> > > > >           domain_dirty_avail()
> > > > >                 mem_cgroup_wb_stats()
> > > > >                        mem_cgroup_flush_stats_ratelimited()
> > > > >
> > > > > where mem_cgroup_flush_stats_ratelimted() has this logic:
> > > > >
> > > > > void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> > > > > {
> > > > >         /* Only flush if the periodic flusher is one full cycle late */
> > > > >         if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLUSH_TIME))
> > > > >                 mem_cgroup_flush_stats(memcg);
> > > > > }
> > > > >
> > > > > where FLUSH_TIME is defined as 2UL * HZ, which afaict means the
> > > > > flushing can be around 2 seconds stale (accounting for the periodic
> > > > > flusher in flush_memcg_stats_dwork() that flushes every FLUSH_TIME
> > > > > interval).
> > > > >
> > > > > From what I see, the freerun and hard limit checks use this stale
> > > > > under-reported value (in domain_dirty_freerun() and
> > > > > wb_position_ratio()), which means the writer gets to keep dirtying and
> > > > > blow past the limit for up to 2 extra seconds before the throttling
> > > > > limits it.
> > > >
> > > > I see. That would indeed explain why we can overrun the dirty limit so
> > > > much.
> > > >
> > > > > Maybe one idea is to in the memcg throttle path do the flush based on
> > > > > how many pages are getting dirtied instead of on how much time has
> > > > > elapsed? It looks like flushing grabs the rstat lock though, so maybe
> > > > > only doing it in the throttled case where it's past freerun would be
> > > > > best. It looks like the logic in the regular non-ratelimited
> > > > > mem_cgroup_flush_stats() call does something similar. I can run some
> > > > > experiments this week with this if you think it could be promising.
> > > >
> > > > Checking some git history, this actually seems to be a relatively recent
> > > > change from Shakeel (added to CC) - d9b3ce8769e3 ("mm: writeback: ratelimit
> > > > stat flush from mem_cgroup_wb_stats"). So you can check whether reverting
> > > > that change makes dirty throttling not overshoot so much.
> > > >
> > >
> > > Reverting d9b3ce8769e3 fixes the issue. On xfs, I'm now seeing the
> > > number of dirty pages stays bounded by the limit instead of going 2x+
> > > over, and the max latency is now around ~0.33s instead of ~4s.
> > >
> > > > Shakeel, your change to use mem_cgroup_flush_stats_ratelimited() in
> > > > mem_cgroup_wb_stats() results in applications overshooting memcg dirty
> > > > limits by several gigabytes which for small memcgs (with 8GB memory in this
> > > > case, which means a dirty limit of ~1.5GB) is a considerable issue. I guess
> > > > the ratelimiting should take into account the size of memcg (or ideally the
> > > > dirty limit in the case of mem_cgroup_wb_stats()) as well. Using
> > > > somewhat outdated numbers for dirty throttling is fine but when we can
> > > > overshoot the dirty limit more than three times, it leads to rather long
> > > > stalls in dirty throttling and similar issues...
> >
> > Yeah I agree this is an issue.
> >
> > >
> > > It looks like commit d9b3ce8769e3 was landed in Feb 2024 when rstat
> > > was still using the single global lock. I see commit 748922dcfabd
> > > ("cgroup: use subsystem-specific rstat locks to avoid contention")
> > > later in the tree, which was landed around May 2025 and reduces that
> > > global lock contention. That might make the cost of the flush a lot
> > > lower than what it was when the ratelimit was needed in d9b3ce8769e3,
> > > so maybe reverting d9b3ce8769e3 wouldn't make much of a difference for
> > > write-heavy workloads and would be the simplest fix?
> >
> > Unfortunetely global lock was just part of the cost and even per-subsystem
> > lock reduces contention across subsystems but flushing is still expensive as the
> > kernel may have to traverse the cgroup update tree for each cpu on the system.
> 
> Ah I see, thanks for the context.
> 
> >
> > CCing Yosry who is looking into similar issue but for zswap stats. Maybe a
> > general solution for such specific stats is to move them from rstat to a
> > separate mechanism where update can be a bit more expensive but the read side
> > can be cheap.
> >
> > > If it does still
> > > regress, I'd be happy to look into making the flush based on how many
> > > pages have been dirtied and scaled to the dirty limit, if that sounds
> > > like the best way forward.
> >
> > First let's see if the general solution is doable and simple otherwise we can
> > explore use-case specific solutions. In extreme case revert is an options as
> > well but I would prefer a more sophisticated ratelimiting (that Jan suggested)
> > than a revert.
> >
> 
> Sounds good. I'll keep an eye out for the work Yosry's doing on this
> and look into hooking it up to writeback if/when his general solution
> becomes available.

I am not sure if I had in mind would generalize well. For zswap, I was
just going to replace rstat with per-memcg atomic counters, and simply
walk the cgroup parents in the update path, as the zswap load/store path
shouldn't be too hot.

However, looking at other in-kernel flushers (including
mem_cgroup_wb_stats()), I see they consume other stats like
NR_INACTIVE_FILE/NR_ACTIVE_FILE, which are updated in the page
allocation path. I am not sure if a cgroup parent walk with atomic
updates would fly there.

A more problematic one is count_shadow_nodes(), which consumes slab
object stats. I think we definitely cannot do atomic updates in the slab
allocation path. Although it seems like count_shadow_nodes() is a rough
estimate and perhaps we can forgoe using the stats there.

If we want a generic solution for in-kernel flushers to improve stats
accuracy without killing performance, I think we need a heavier lift to
rework rstat or move away from it completely.
