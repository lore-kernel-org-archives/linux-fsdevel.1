Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F34832B104
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Aug 2026 00:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787790541; cv=pass; b=I3l4Dv1gvMAKojQfdkO9Zhkg3nb8wW3MtSkeUKXfjX9PskMvWikClS/91La+zd0+tEzJorh74weeHlJSA9e+xEKo9CoMcSTj+knWXVjI69Nl3NNRTjugbxLcEXXjyWjggHlSsYETiwfIXvlsWhCnF9wH5R3ixvIyZs56n0K2ioY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787790541; c=relaxed/simple;
	bh=3fQ9kx6tzAI4WTf9nNCFYujhq/OSiQc1G0MQhkXWBKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0SpPNGab9dXIifxLoyTteX26ugwPsQ132XQpRwWENjSJPq2Bk3hIM6ZuSOWhooEaCj0t9cccxZYaSb7K9W38967Uf8ARTIMLrOBZpfUhS3/Lx8P3R/Cr7YF98w+Wh9uCSBe0lpEHS6lpN+EqkZf4QJ7vFtgXQap/jKf0/3WIVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIPMH+WX; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIPMH+WX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso14675485e9.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Aug 2026 17:28:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787790538; cv=none;
        d=google.com; s=arc-20260327;
        b=hjr7w6SQdArjqX8PkmRvBAGIoAaXmKP3B5SePYm/2ZGrSkWLD7ThAKojSDCu1GSeSz
         5pW/JqWhL3uxjDYUIftqGpvbeAnkPRtbg/VMKRbyAQpi73nPP0vahWKzEwokSttj0t8q
         dnUufd1E2BSCHrQbrKbanCrJYn96mLWMeYhmv48w8cEyyOhDKAHAvkQS+pBkdj5MHwL7
         jTns2QdoJqVqJXItu9QM6bKgtlrOisS7/1r9bFT1FVNxQAEHvihXZrhmLjiVqf2/GtGE
         wtEFdYn5jW+ll4beJ7IMjPEm/mYC0/7sEmI+v0B6/VWMzx8EvziC80klmyjN5BORpezP
         hS6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4cZqKKK1TDfNXpWdtR/tDO5Ky/FCuSlms00pdh6fymw=;
        fh=GzztkdXmb5ySZvJSdlesa7/gyBYPTn+MW4GYLh3+kco=;
        b=A6xBAXM7qPdEMwGpLQ0kxJqg6T8OVV5kI2DvVn39zwuMeIazH80962TByv47B8Xgxp
         CjLJUom8OkvV0+FfSDN3TQQhDJhqRqv3xwLV4JWbTHnUA/OMJanCPdQMacMk4LbiGWam
         mRNQBz7vCWCGiv4sT9u65M26538WD8LVNs3glernY67mJvKtUNyTOTLqoMEUNW+Qgiem
         xuavqvvD1ZXmbOsH5zzJePuT8noybbFIeVIdcSBzYJpuGgOJo5nCl8YFLFIbgUUET0aO
         nQZBn7OZ8BNxGClYrRL1v4urBGtGXIkAZ+MRnK7qq41PZG6gqaMzzKTv9yvupH76QglQ
         pE8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787790538; x=1788395338; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4cZqKKK1TDfNXpWdtR/tDO5Ky/FCuSlms00pdh6fymw=;
        b=jIPMH+WXXATltSCWs3OBCFpaxGmSpYCxnzeJxa59mSNohujvMUrHQNSJN28nfoo+TE
         NGEBzGBL1AOeEkkaIpU1yylH8KQSc+EkNJBH2udDIA5UZ5IvFJGmoR/Vd5onhsChmEEk
         eeTGhZrJQOqsZktbxDuVf2mVhH6Ct/7UsGIFthT0nqe2smZrVoatGyg/Jop+IN0BRA0x
         CrK15+sbX3H2UMd6hKH5q/HKcO+RUJ5/rLBkMMfHGHYam0qaX0H8zDpTsVBEdMrb5EC0
         mChU0tELxrdz51GmziqA6bTnC6ahI75Nxx7RzI59eOA7gzzMGumgRTpAY4rnHmwJj2G9
         VCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787790538; x=1788395338;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4cZqKKK1TDfNXpWdtR/tDO5Ky/FCuSlms00pdh6fymw=;
        b=c1i/jDp7ShQf17YZEv33Lt+qnu6fBX4i0xqsFHmLsaVBxcb+75NeG7D7NnFjzlj0sU
         aYuty3XIcpIcTTPSZ6+KjRU+/rSz+zmmxx+0+UYglFj4x67/nmGh1EFPTAUKT4ZM5YNg
         Baw5Lwbx+/SFW8GuSL4pd0NDTbfNEA/EQxudhAf23hUzjw5TWw5wkCNHnvHw/t3Kca0w
         WY2r0XlY36Eko0LL8UX+T/8vlaREZ6OlkCcYTjynpRYx2q4TVtbJTACg8X7ESivBn8Nn
         pDE+nL9a3rcRLJ0frBaW7PNBHWeRr66GIjdg9sUY66yT4M89JMw7GjJZhSHfhrffXroj
         7Slw==
X-Forwarded-Encrypted: i=1; AHgh+Rrki9KUIaZmFPn/xr4d7zMma8PHmc4fWFAyzXiEoB30zIu4LAU3+FmYdlgITUk0B72Inw1XelS48RcDJNyM@vger.kernel.org
X-Gm-Message-State: AFuF++lB9m7zfHGNc5Fc9RfyL+9MX31iidJ3Gq7wYY/JO1gkdi5wITDC
	pQ/x9qadE2M60vwHQ/FwLmuNLEjRblDWP1BAjHY3z0P5An8DOX6z5Z3dPsuotpiHBbZUME7nX5g
	hqBtTllgo+T5DCpnX86xgcmv7CSRXKWw=
X-Gm-Gg: AR+sD13d80r7c/YTMwr/OsSzlajKyYiMT90p/Vc62paQ5VdG1S0i5p9nyuGkpD+kQnK
	5kxTvoCLyZu4fNSKvkRABtLi51rcHW4w9KXh/m1+iPztmCwOFFY6QBz5YjLbXdZlaWrYtAGsHF/
	HQTNf0/E8zulnE29gWOr/rBTOhS9CUcq0xxOrOCJ892WXCOTMxvWYdv14REoChJMJrIVF92WSeH
	rb4w+lRYvprne50D+HnD6BEyGqRG3jjapYRE41QLtvujU//RX3y3Cl+LHkWMZ8bAIAWSLvnIe/F
	6YRmDrcX0MckxmkdQPKyJkC3KiZnJ4RnlPhU3vEVYbVDLTvPwoiGy7LQvP0A7voyZJvoBG8x3hu
	fHUBO6OJc1IRx1u8za4NBDL5SklA=
X-Received: by 2002:a05:600c:3acf:b0:499:db5a:1049 with SMTP id
 5b1f17b1804b1-499dc70246bmr113665505e9.8.1787790537745; Wed, 26 Aug 2026
 17:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
 <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
 <CAJnrk1YifN22mA5PFRVrh3m_ygxax6x4_8nraG2hPqCzyzBj7A@mail.gmail.com> <anpsLy_pCanocgS1@google.com>
In-Reply-To: <anpsLy_pCanocgS1@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Wed, 26 Aug 2026 17:28:45 -0700
X-Gm-Features: AcwNN1XMTGinUnlY4ug2mkf_JuHPFNH6ilizd91iZP4Nfao1NkxbweldZ9jzh4E
Message-ID: <CAJnrk1b5asARJ_g176DsoNCvf+iFqzPbOtVveeuPxTPZDmnuKw@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Yosry Ahmed <yosry@kernel.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 10, 2026 at 5:48=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Mon, Aug 10, 2026 at 09:49:31AM -0700, Joanne Koong wrote:
> > On Thu, Aug 6, 2026 at 2:31=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > For updating the stat on each parent and having the flush path only
> > accumulate CPU counters, I think this means we would have to
> > unconditionally walk the ancestors + update its counters on every
> > update, as we wouldn't be able to early break if the flushable
> > threshold was already exceeded. I don't think we could replace the
> > stats_update update, as it seems like readers still need some way of
> > knowing when to flush. It seems like this could be a nontrivial
> > performance hit, but maybe it's a non-factor in reality. If you think
> > this would be useful to get benchmark numbers on, I can run some
> > experiments on this too.
>
> I think we need to experiment with how much work we can shift around
> between the update and reader sides.
>
> Right now, on the update side, we call __css_rstat_updated(), which
> iterates the parents and puts them on the per-CPU rstat tree, then we
> iterate the parents again in memcg_rstat_updated() and:
> - Check if flushing threshold is already met.
> - Update per-CPU counter for stats_updates.
> - If per-CPU update exceeds (another) threshold, we update an atomic for
>   stats_updates.
>
> The flush side checks the flushing threshold and does an rstat flush,
> which will walk the update trees on all CPUs and iterates all child
> cgroups on it. Pretty expensive when the threshold is met.
>
> I think we discussed two different options:
>
> (a) On stats updates, iterate the parents and update the per-CPU
> counters of the stat directly.
>
> In this case, we can't keep using rstat, as we would still need to add
> the cgroup and all its ancestors to the update tree anyway and the flush
> cost will remain similar. So on the flush path we'll need to iterate all
> CPUs and add the counters. We can explore if use a cpumask can help
> here, but perhaps not since we'll need to update it atomically on all
> stat updates.
>
> I imagine that if we do this we'll drop the stats_updates optimization
> to avoid adding more cost to the update side. We'll be replacing parent
> stats_updates modification with parent stat counter modification. But
> maybe it's feasible to keep both to limit the cost of flusing.
>
> This only works if the cost of iterate the CPUs on the flush side ends
> up being cheaper than the current flush. I imagine the average cost will
> be higher but the cost should be much more consistent vs the current
> flush, so the tail should be better.
>
> (b) On stats updates, iterate the parents and update the per-CPU
> counters of the stat directly AND update a global atomic if the per-CPU
> counter exceeds a threshold. I think updates may get too expensive as we
> may need to update multiple atomics, especially when updating the root
> counter as it will be contended by all cgroups.
>
> The flush side becomes an atomic read, so should be very cheap, and we
> can drop other heuristics and optimizations.
>
> ---
>
> I think ultimately we need to experiment with these approachs (and
> perhaps others) to check what actually works in practice. You'll
> probably want some benchmarks or synthetic tests with many cgroups to
> exercise the worst case scenarios.
>

These are the results I'm seeing from the benchmarks. I'm comparing
non-ratelimited rstat vs (a) vs (b). I'm comparing non-ratelimited
rstat instead of ratelimited rstat, because ratelimited rstat relies
on the 2s flusher and doesn't incur any additional flushing when
called.

~On the update side~
ns per update (measured by having a kthread pinned to each CPU and all
threads updating the same cgroup for a 200ms window, run on 80 CPUs,
computed as total CPU time / # updates)
depth      rstat      (a)         (b)
    1        22.34       32.49      60.10
    8        22.46       47.12      140.72
    16      22.49       70.96      206.39
    32      22.51       139.16    305.40

(a) and (b) perform worse on higher memcg depths, whereas rstat is
unaffected by depth level, which makes sense given that (a) and (b)
can't break early if the flushable threshold has already been
exceeded.

~On the flush side~
ns per flush call (measured at leaf of memcg chain, ie best scenario
for rstat, # CPUs on the system is 80)
  rstat                      10165.60 ns   (min 9924)
    (a)                       734.10 ns
    (b)                        4.79 ns

(a) is around 14x cheaper than an rstat flush, which I think is
because the rstat flush goes through every stat, even ones that are
not directly relevant.


Using some napkin math, I think the breakeven point for (a) is around:
                      updates per read
depth 1             ~900
depth 8             ~380
depth 32           ~80

eg for depth 1:  (10165.60 - 734.10) / (32.49 -  22.34)

This is assuming one read per flush, which is what (a) and (b) would
necessarily have to pay, whereas rstat only needs to flush when the #
of stats updates exceeds the MEMCG_CHARGE_BATCH * nr_cpus threshold,
so the updates per read numbers above are in reality lower.

Running a fio write job and using tracepoints to count # of stat
updates, # of reads of those stats, and how many of those reads flush,
I'm seeing:
                     updates/s              reads/s
flushes/s         updates per read
bs=3D1M            643                           119                 45
                       5
bs=3D4k            156,415                     123                 58
                     1267

For larger folio sizes, (a) is cheaper for writeback (since there are
4 update events *per folio* in the dirtying/writeback lifecycle) but
for smaller folio sizes (eg order 0 folios), (a) is worse, as a lot
more updates are incurred, and the performance is worse the deeper the
memcg is nested.


I also ran some experiments with Jan's suggestion of scaling the flush
threshold to the memcg's limit rather than to the number of cpus. It
helps the overshoot we saw and slightly outperforms doing a plain
non-ratelimited flush (100% of dirty limit vs 101% on a 1G memcg, 103%
vs 107% on a 256M memcg) but led to ~2.4x more flushes.

The initial reason we switched to the ratelimited version of the flush
was because flushing was expensive, but I'm not sure if flushing is as
expensive as it used to be. Testing the non-ratelimited version, the
flushes account for about 0.9% of the system CPU the write path
already spends, and I didn't see any throughput difference between the
two (249-252 MB/s either way), on a 32G memcg. With the
non-ratelimited version, it's also not a flush per read - it's still
"ratelimited" by number of updates that have elapsed since the last
flush (only flushing if stats_updates >=3D MEMCG_CHARGE_BATCH * nr_cpus)
which means concurrent writers writing back at the same time will
"share" flushes rather than triggering their own.

In light of the above, imo it seems to make the most sense to just do
the plain non-ratelimited flush for mem_cgroup_wb_stats() and make the
flushing magnitude bound again, wh ich also aligns with what the
global non-memcg domain does. The question is whether the extra flush
cost is acceptable, but the numbers above make me think it is.

Thanks,
Joanne
