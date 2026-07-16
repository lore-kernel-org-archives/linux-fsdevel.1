Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3C11DD877
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2026 01:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784165311; cv=pass; b=MgdaMwePS9gC2CPpWtKrOf/mtv4kmcQ//P2+DzwVg+/gbZh7mmegF0hhJmtR843am12OSFETVECvg7SWgmJaeoAleRRpWi08Yjh7gMndW93O8k7jZyh5BRzJs7/bjhEHA5yWUbDkzwzGz3ZWwUm/gv9rdXkHH6hhXQo+6+vZR8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784165311; c=relaxed/simple;
	bh=Bl6oveVT0QtYGCCQdvAri7/6mNs0UcVQl8/bZCxvyEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6FVXmVXjbAfOz7gpzuBb198YqV0AMGrj3y6D/psrlOnWZfxljTtZWAT+nLmhK3DaW9OO40mHIqsiKtAqjUzw/UVxyYTsN3HxCxKptXu08PUPHLqS7FbHnXrPqx24WX0T4y1hrljLaNtMP0z5ESkNeEDK6ESSfkrDL/EhlJCc5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X4+RgaUg; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X4+RgaUg"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so8494375e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jul 2026 18:28:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784165308; cv=none;
        d=google.com; s=arc-20260327;
        b=ARwovjE0IKR6aUzEKvJ2ltPnhsD6pUAsC8ur378JdWtWNNVKH+wAteiLK/LjMz3aHB
         8E6Gfcqr1i8AtmqdK8peiPmkFxcYXEerj/CWQ7RSX6De/ItLfvUeywdv5f/Ze/mCnQ78
         5DEZ58fTYWeaZjbWm1ddrHoa0CSer1HJgujKJoU+INYnwM9KugMBduQnxk0uY6RbmPRK
         ZoN5v2Hd4vj01BiPf3nvlats0glY7YgkP3XGx/6ud0pCVw1THhPAPP8lR3qJQ+qFBB5j
         MuWEdp7EdjUcqGWzdiueGIMVrfHJvPXUZ60fKDKbGAQ1DPb4Uskrnizkv5YoefJVVgY3
         pYmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bUBpmH2rKstmNCAt1IVYxPJOJssz+FY4n3xBgHJ0uKA=;
        fh=g8CaFxWCNLCzyCO7jknQvPwQuJ4DiYw1IUf0Lp4X6a8=;
        b=VvYStJe4wYee/DLf2UVXGMSIkcgq9vzHlj6bBYt3QkHD2Un8Xtx0M9IIOVBHhte08a
         oS8Ny3sLJu97xH2zQg6Q9mJVb7h97iQNjyQ91ke7dJc6cYOnDJZT6bK6v3dug8tYCBKg
         ADhantN6R225o9JYwsIXP3WQolb91OHXB2kCHV+0Vo8kKcE5aUrwMCDbjI+CWUQJKtX/
         WGHH+lOS5sj8dM322DRvdPgJH0TQBIJgXFez9Vfk1QUt4/FjYVFQSLavCZmP7gmQsmSM
         jaPm5R1fam9sfeALrTNSuQqsXL8/RFMfBdJz7UHjVocR3LrW35WZbCfjKafg5+zNNjqP
         0f2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784165308; x=1784770108; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bUBpmH2rKstmNCAt1IVYxPJOJssz+FY4n3xBgHJ0uKA=;
        b=X4+RgaUgkjn4FyrNGLCA++e5TEcEl3h+WXUg8SbvPk98+P+LINnzyXna7h6O2vTnOO
         1uiYfJnRNb+7IggrNPlkWapEP85mWGoMElQ1KJbIXKwpiH6pHd87TwvbdF8B9RdqbO+p
         oR+73Q6OgbRBtH16Aw2ebPVD9bbQjKyxdMrdyERyIa212DB1ajT68x4837ANrMG9mgHl
         jMZnCklaQnC2VvwPRXaAs/hUPRsx9W555dvuawAfjMhwj1Rn7fJGSBliOZQVJPqixLEc
         mhfdUAdvFgDcb2dC5SwbFY952OVqEeeyNAWL7ghZO3Tu+l7rd/bI0H8X77qwQLeaEiIR
         M1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784165308; x=1784770108;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bUBpmH2rKstmNCAt1IVYxPJOJssz+FY4n3xBgHJ0uKA=;
        b=MBoEy0oxaI3UoDAN5/RMaDyPotRmd7+lMKNkxLySNUEFjyMHfZDIyvbFxEj0sYf/du
         lSgquRks0wPaK6orER4cGFtjGjGicNebWMiqWfJ3DPX09AVEG7y2fQ/nJDY7gvrVng6q
         WF25ibXieRbEUdgY1LnPFLG+wHr8L1jqyxoUpYhOuoKjQxhY6fQsma1vv0agflWpwXEY
         I9igRkNqzQEPOJglnjvqyc5fvR9dpreYS6Mmxz+KNhugJkqht9+ySo2U0rMBzy5UONl4
         0Y/+pGBBZoe9FEIfD5z8PcR6kN1ckq51Q/xY5TeNx/UmdayCahd28bObEXQDkkii2uWb
         6knQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr008U3iltlgfOn2S5aHdyIsw/dITzkvo7iCj3nMO9KWspvvaTN/Pbt30uBhLdEBK/ETqYNU1YIP4dEZ3Ha@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl+QsqWRC+aVB4yESp38SbaYRMRJ5i0/LaiKfohhouOOBraRi8
	oha/41Li0PVELGdsCSfCtnu9cBtRJ9yQXztgNNkdxemUClDfQ9S9WlOq0e1tQ5gVRCt/H+E4GE5
	5sz2ikWCGFR549L76KICGJ4OqLwRrK5Y=
X-Gm-Gg: AfdE7cmw4IPDcsXkkjM4PQcSl/7I7TkFT9f3ParQ60DLt5Xn7gyqjvAUVaafNFqWFEH
	0VbISOoK7x1apmqY6YF9zsFfTzqPEPjAkk/yDjhb77k/2BZuVo/7RftpYZ2XHbZU4JUIDJqP4D/
	sP5v+l+JpAOPKehMxvj+EcdT5WiLI5LXenE7nHs9aBPlWI0tsaGGuZB9mPznodIyERBlXQM93dI
	NlMYHx1XHzyk1vvMKe8R+7ZXzpHnLRcxyFTSuhGVRDtO8pCHa/346ftRX/zbwkYee8hQr4jVmhY
	8y+P6qHBV2DYYgH6Bj2KiFHqPkun6WRLgmy7UBJFDQ==
X-Received: by 2002:a05:600c:674a:b0:490:c6c2:52 with SMTP id
 5b1f17b1804b1-493f87d8bf5mr203372655e9.3.1784165308098; Wed, 15 Jul 2026
 18:28:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJfpegsy2XRR6g1J4Mg0MXPckx3NVprW56XvYhEko0=7PcHiQQ@mail.gmail.com>
 <CAJnrk1bZX44HaXmNMxEeEwhuFHgEjxXLnjKy8a-6T6LFuf+K2A@mail.gmail.com>
 <CAJnrk1aJwdY+fphnhHjAXFwjGqWQgVB+sn2Ce0gReein3H8EWQ@mail.gmail.com>
 <s4kv7qep3jlncs67q72xfhserpd66hpbwzkoppiddc5raufyjd@ksuvlfqcrbk2>
 <CAJnrk1bG6ddP6-dgXpGBRGnCH49oTMPwkJmF--+gefmy+zBo-w@mail.gmail.com>
 <oocwnxqgd4klrem6hkya3sddqoxkosml4ysz23if4j7wj2qdwi@5skgc4ftu7io>
 <CAJnrk1ZU40tRDq0z3yM0+yv=KhiZ-fNjUTO=ccv1tuc0xDx2Vg@mail.gmail.com>
 <4fsrafuhoqgoirlt2sy6vk2ljvb3tdps4hqbcrm5qc2pr6tlaf@tboejm2wdq2s>
 <CAJnrk1b65ypz4bdtd1rTQBYOpOEP+DcoZJUSL87jVDssW1A+pw@mail.gmail.com>
 <nv2h2dd2xoj4zjfvnhsxud2p5e2uw3og22ovqureik4pey72qb@i75tn5ttavfo> <ue5xd6f4nfggwodfhbqaispmr5aq2dyszezvy26bl4rtsk6xii@uceqazdioj3o>
In-Reply-To: <ue5xd6f4nfggwodfhbqaispmr5aq2dyszezvy26bl4rtsk6xii@uceqazdioj3o>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 15 Jul 2026 18:28:16 -0700
X-Gm-Features: AUfX_mzzQ27GE88mWZ-hEJWRRr0HsdljimQVbt00i1OttacTJxJWfpOjF03It98
Message-ID: <CAJnrk1bwabyWY+rzzSKfKWp3rivcQm=zae3xzNSZc2hnLj6-Aw@mail.gmail.com>
Subject: Re: [PATCH] fuse: disable default bdi strictlimiting
To: Jan Kara <jack@suse.cz>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 3:32=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> [resending once more, this time with correct Shakeel's address]
>
> On Tue 14-07-26 18:21:57, Joanne Koong wrote:
> > On Tue, Jul 14, 2026 at 10:10=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
> > > On Mon 13-07-26 18:13:29, Joanne Koong wrote:
> > > > On Sat, May 30, 2026 at 4:04=E2=80=AFAM Jan Kara <jack@suse.cz> wro=
te:
> > > > > On Thu 28-05-26 15:11:18, Joanne Koong wrote:
> > > > > > On Thu, May 28, 2026 at 5:34=E2=80=AFAM Jan Kara <jack@suse.cz>=
 wrote:
> > > > > > > > I think this is also going to be a problem for cgroups with=
 large
> > > > > > > > folios since they also, as I understand it, are constrained=
 with a
> > > > > > > > limited / tight dirty budget. I ran some initial benchmarks=
 with
> > > > > > > > cgroup memory constraints on NVMe and saw similar instabili=
ty (a
> > > > > > > > single writer in a 8 GB cgroup had max write latencies of 6=
 seconds vs
> > > > > > > > 15 ms without the cgroup, with the balance_dirty_pages() th=
rottling
> > > > > > > > oscillating rather than settling near the set point).
> > > > > > >
> > > > > > > Ok, so this is more folios (819) than my 512 gut feeling esti=
mate :) What
> > > > > > > was the write throughput of the NVMe drive? The high drive th=
roughput also
> > > > > > > requires more dirty data to keep the drive saturated so that =
writeback
> > > > > > > throughput doesn't oscilate too much.
> > > > > >
> > > > > > The write throughput of the NVMe drive I was using was around ~=
1.1
> > > > > > Gb/s (measured by running direct I/O). I think with the 1.6GB d=
irty
> > > > > > budget, the math for that ends up being that the device drains =
it in
> > > > > > ~1.5 secs. The performance I was seeing with the initial cgroup
> > > > > > benchmarks was with 4k pages (no large folios enabled) on btrfs=
.
> > > > >
> > > > > OK, you might want to experiment with some other filesystem (I su=
ggest xfs
> > > > > or ext4) as well. Btrfs writeback behavior is a bit special with =
its data
> > > > > checksum computations etc. and thus latency of starting writeback=
. It could
> > > > > contribute to the erratic behavior with the relatively low dirty =
limits.
> > > >
> > > > I reran the benchmarks on xfs and ext4 and saw similiar results. Th=
e
> > > > max write latency under the memcg were
> > > > xfs        5.1s
> > > > ext4      5.2 s
> > > > btrfs      6.2 s
> > > >
> > > > compared to the non-memcg case (0.4 to 2.0 ms). This didn't affect
> > > > throughput though, just the tail latency. When I ran xfs with large
> > > > folios disabled, I still saw ~4.1s.
> > >
> > > OK, interesting. Thanks for running these tests! Also it is good to k=
now
> > > this is not really related to large folios, that somewhat simplifies
> > > matters.
> > >
> > > > From the balance_dirty_pages() ftrace tracepoints, the dirty_rateli=
mit
> > > > value is consistently stable / accurate but it looks like what's
> > > > happening is that during freerun, the writer essentially dirties at
> > > > memcpy speed until the freerun ceiling, and then the soft/proportio=
nal
> > > > throttling kicks in but doesn't kick in fast or hard enough, which
> > > > allows the number of dirty pages to exceed the hard limit by ~2x, a=
nd
> > > > then at that point the writer is forced into the loop where it slee=
ps
> > > > max_pause (200ms) each iteration until writeback has drained the
> > > > number of dirty pages back under the limit.
> > >
> > > OK, above you mentioned that the dirty limit for the memcgs is set at
> > > 1.6GB. Does that mean that dirty throttling allows memcg to dirty up =
to
> > > ~3.2GB of pages? I wouldn't have expected that...
> >
> > On a couple of the runs, I saw it get as high as up to 5GB.
> >
> > I think this is because the balance_dirty_pages() code uses the memcg
> > stats (NR_FILE_DIRTY) but these stats are only periodically
> > flushed/refreshed when reading it, so the balance dirty code is
> > seeing/using lagging/non-uptodate values.
> >
> > I'm seeing this in
> >   balance_dirty_pages()
> >       balance_domain_limits(mdtc,...)
> >           domain_dirty_avail()
> >                 mem_cgroup_wb_stats()
> >                        mem_cgroup_flush_stats_ratelimited()
> >
> > where mem_cgroup_flush_stats_ratelimted() has this logic:
> >
> > void mem_cgroup_flush_stats_ratelimited(struct mem_cgroup *memcg)
> > {
> >         /* Only flush if the periodic flusher is one full cycle late */
> >         if (time_after64(jiffies_64, READ_ONCE(flush_last_time) + 2*FLU=
SH_TIME))
> >                 mem_cgroup_flush_stats(memcg);
> > }
> >
> > where FLUSH_TIME is defined as 2UL * HZ, which afaict means the
> > flushing can be around 2 seconds stale (accounting for the periodic
> > flusher in flush_memcg_stats_dwork() that flushes every FLUSH_TIME
> > interval).
> >
> > From what I see, the freerun and hard limit checks use this stale
> > under-reported value (in domain_dirty_freerun() and
> > wb_position_ratio()), which means the writer gets to keep dirtying and
> > blow past the limit for up to 2 extra seconds before the throttling
> > limits it.
>
> I see. That would indeed explain why we can overrun the dirty limit so
> much.
>
> > Maybe one idea is to in the memcg throttle path do the flush based on
> > how many pages are getting dirtied instead of on how much time has
> > elapsed? It looks like flushing grabs the rstat lock though, so maybe
> > only doing it in the throttled case where it's past freerun would be
> > best. It looks like the logic in the regular non-ratelimited
> > mem_cgroup_flush_stats() call does something similar. I can run some
> > experiments this week with this if you think it could be promising.
>
> Checking some git history, this actually seems to be a relatively recent
> change from Shakeel (added to CC) - d9b3ce8769e3 ("mm: writeback: ratelim=
it
> stat flush from mem_cgroup_wb_stats"). So you can check whether reverting
> that change makes dirty throttling not overshoot so much.
>

Reverting d9b3ce8769e3 fixes the issue. On xfs, I'm now seeing the
number of dirty pages stays bounded by the limit instead of going 2x+
over, and the max latency is now around ~0.33s instead of ~4s.

> Shakeel, your change to use mem_cgroup_flush_stats_ratelimited() in
> mem_cgroup_wb_stats() results in applications overshooting memcg dirty
> limits by several gigabytes which for small memcgs (with 8GB memory in th=
is
> case, which means a dirty limit of ~1.5GB) is a considerable issue. I gue=
ss
> the ratelimiting should take into account the size of memcg (or ideally t=
he
> dirty limit in the case of mem_cgroup_wb_stats()) as well. Using
> somewhat outdated numbers for dirty throttling is fine but when we can
> overshoot the dirty limit more than three times, it leads to rather long
> stalls in dirty throttling and similar issues...

It looks like commit d9b3ce8769e3 was landed in Feb 2024 when rstat
was still using the single global lock. I see commit 748922dcfabd
("cgroup: use subsystem-specific rstat locks to avoid contention")
later in the tree, which was landed around May 2025 and reduces that
global lock contention. That might make the cost of the flush a lot
lower than what it was when the ratelimit was needed in d9b3ce8769e3,
so maybe reverting d9b3ce8769e3 wouldn't make much of a difference for
write-heavy workloads and would be the simplest fix? If it does still
regress, I'd be happy to look into making the flush based on how many
pages have been dirtied and scaled to the dirty limit, if that sounds
like the best way forward. I tried running the sysbench
oltp_write_only benchmark mentioned in d9b3ce8769e3 on my setup but
couldn't get the database to dirty pages fast enough to trigger the
balance dirty pages logic to see how it performs without the
ratelimiting. If you still have the script for how you ran the test
back in 2024, I'm happy to give it a go on my local machine.

Thanks,
Joanne
