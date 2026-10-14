Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB0033998
	for <linux-fsdevel@vger.kernel.org>; Wed, 14 Oct 2026 00:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791936348; cv=pass; b=gRiOMjICZmfSYAmRNb5O0AoI0pDQqrC4ANKl0FeS8byTKfZIYKVh2TibOoxcGatP4WoKf3dcHSmSBSfnZToa7j8uaZtRkBhYPgNIm3Z4qWybuWzXShytHg2cD4f7oQ66JGOPgbuTMxDDxxyKqgbwqlnO+3KK/vmn6kU0x1sau6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791936348; c=relaxed/simple;
	bh=JiIkoDrG8B/K/e0G126rXH/WHg3dZTUEry5fG6BL75M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GbIcZ2Lw5n+zTG0jYOpySMn38xQmu7vZampYCt73qaEWK9uLFgFIT8RrCG3gh+MGm56YZPHKlNxQouKtOZJBiLj4h/JPz6+9boVZaaMMsUq6OB1FPW1u/vHRTvqczeYJZoUD0KIpRlK+aWSRC3utlMxpyt7Q838i3FK8zXUVGnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WCtnJbQB; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WCtnJbQB"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so3696785e9.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 13 Oct 2026 17:05:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791936344; cv=none;
        d=google.com; s=arc-20260327;
        b=b35t9l2wrwOS775JL6gs5uAUiuBrSlOMZZtm/ggmpBPsN+SRDarNnlyV+rRtAXFQnG
         +4KLzGLcPNFTgKxAcdtO85Q7heSsEPvCKnhldHDgJOO5UYYtVtXyf/LYoU+ecUrSxuB/
         Th1rR3Lu9JrLJQfxgbVWRWvw7OFHi4V0KUEwrjjMMPzu2G/wEKwKakGqCh9Hhz5Vhs1W
         bdxwcmMoIRmy9qh26CotQpPDPJ0GJ9reH4dJss/gnqsrW0Lg2W7V6gvrX9syrUQr0Mln
         mvRYkdCB3FKemoENwzXfQ2oZy5o8IevMGIgNoO9zJ88xMrX0TT788dQTkc+o3IiLg+K5
         +GAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Y1oo8EWenBlY3BpHQDLYrrC9DTOm+pseWLNNQG3q3Q=;
        fh=iETAYH+6/bDAV/TA1A1zMXZlsCexu/lPUWxpTvxI7Vc=;
        b=lVVQX4De/4Jh0eFmQBjGD5zZvUWJEbA+nzxQ5P/6igf8NTkjYauIHyNHWm25dmAlvo
         eNMRqUDsKjqAbO6plp0+8fYSLzI78Q3GSfKceA98t+ixjwNjDQjoo2e16IlW5UjwgmFu
         3f8MFd8IdDSXr17smu0Ich7kmOEzrg1j9rMoxuZc8g4z5QYco40fC1f4OP/CAFOl/iaI
         FFfw2Cg5fUra/UI92Dom04Khhx3mrte5bvKJB6imIb0AmryBANtWo5A5KcBwM6jokQqR
         0VeGGN/50Comc1OfGEwg8eaqcMu3CsoILCLz7lMVX8O5Nf0zydD4sDrNghG7PWEnBb0r
         gfhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791936344; x=1792541144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Y1oo8EWenBlY3BpHQDLYrrC9DTOm+pseWLNNQG3q3Q=;
        b=WCtnJbQBJDCUtVFEvJCn5UfOrSMWH3mCBLLkHdunYelA/uioc0YoxgeNxidOIER4js
         hpRSYKljuMk6QobzRmqv2cCN6YOCt+xfDj/My5IXPyQqDaSNY2rhHBzyHpEQ1eDhPO1z
         sMRJu8Lnh3FPX/8022gzbovsXOI6qAX5JRFmw4PF2da0Iwh7Oc8FkEzwJbWhd0ofR+fc
         PeI5KYxf9KCs1ff4ECV+XAAnattyAgjgQ/oaoV7LyEnsGRhWVd5XgKBjoOMxH5s23VJF
         w6BoCU13pWywfqrkXehGDlPcU+uSux4wxkHpxWcW+y4AaOqoz6j/emDANYRSOHTG4Kh0
         04Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791936344; x=1792541144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Y1oo8EWenBlY3BpHQDLYrrC9DTOm+pseWLNNQG3q3Q=;
        b=FvW8884LWJYDTUN9nl0z0vy2XmZpLMsOS3pJQNOvyqzmMkmdsI7Fz73iLM2nwEn3f8
         N6sIpBnkoREMagBjMc9p2NUvN91okasACiXxaDlgkzXC0dPm+MZpOp6NGkeEQN162oet
         qEfrA5B+uYQk5DiNTcfecSwFZENvR5kVIRpkFwwgVPKNxnVbo/vWwo9ryT+8BswwPiFn
         29nLadyHRHR0xepbZk/EbWDOUXuiTqCP1EqxLrjFVsZSaQAMhzMIpwHk3EXrXp5CCUdd
         fJPWKuERS0cL/Sf8w3PiVI8XeOcJFeu/sZKseSro4Ssm5TRgnnH8RGEnxCoD3xtku+lP
         rzPw==
X-Forwarded-Encrypted: i=1; AKwUvBybi95+ZWNx5JPKjL+aBs9/OWMN5X2NspXrA/t6cR6rcGAneyRobkWBbjNsAyFWmtdNraOI3Nx2SJQ8gVGE@vger.kernel.org
X-Gm-Message-State: AFq9FYKSmt/T6/HMsEeL+M5+pHWFuV7lgiPPCgklJdUsOBELc8faVKiE
	wPaARarSvDXVBsyWYUW5tVHHWnXPzb241RGM+MhW/D3jzl61KEhfUTDAbBw8KPVvQN+i/xa6YT7
	m8TEOBn6jLQYlEIQJDGh0dBE078PUnLQ=
X-Gm-Gg: AYBFou3AYTZsYAy3FWELm8HwRhLUM/WjIbvEbws0h60kBpJ7EMtllaYLbgTsb/gDIHZ
	JQSPa7YGV0fai9oPo9apjeTSyWkP7rPYL9fcJKNRYiLf5DsMhiWuUSdCD82nY+IoeiKwM231WuB
	88niFOBoJBNOXJY0rUB7I/1NfuTZyOS43fsJiRtTvAsiebhNUVmbBqNj0ikFxmPwF0EBNZ6XJRN
	edOUMuNceN6sOqhzXlJ5HU9qHzGXwMi26CgaiLxgpU1rjlp9xp6zzn2uVw8U3E9WfUr27uMfoyN
	DncXjyKyGea0rAGBp7b2k8Xz85LYijvaPpzP1bAHyouZrClP8iTpx/sjgjccJWX2OvPH3Dxn4qb
	mF9I4c384YgrQRldXoHA2NgAPzzzmnanzdwCFozHGvGd/Lbd7v0li
X-Received: by 2002:a05:6000:491c:b0:485:1bcc:67f8 with SMTP id
 ffacd0b85a97d-48dbaadb2d5mr26190862f8f.13.1791936344413; Tue, 13 Oct 2026
 17:05:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJnrk1bk66ZhRAS7mojSnD5RBfFS+0ChAPymE3ObRWr0C_udWg@mail.gmail.com>
 <CAO9r8zPpe6fWOSXtRUjFB8WNMroeBqvLT+2QtAU4E27AtLUXMQ@mail.gmail.com>
 <CAJnrk1YifN22mA5PFRVrh3m_ygxax6x4_8nraG2hPqCzyzBj7A@mail.gmail.com>
 <anpsLy_pCanocgS1@google.com> <CAJnrk1Yoj7fqbzurmHkbA-vegpQu3cf-_dfvKor_VxuNhPR-AA@mail.gmail.com>
 <CAO9r8zPLipVW6bvyDK1ypSawbo=LHKvmLqWH0xA6WMR9GYNJpg@mail.gmail.com>
 <CAJnrk1ai-TqcudPoK-qFRYAJnUjBmg1kVa6Vxg3eDm5w5ivqSA@mail.gmail.com>
 <CAO9r8zNJ=Fpc0pZExrttVTDCM3yzSmLPCAU=+RS0k5Pm+hY96w@mail.gmail.com>
 <CADrL8HV7_f68qfd6hG=xCTqzupPqr77ynbwdz8jm0hzjdgDVeg@mail.gmail.com>
 <CAJnrk1aHdBm4CofvKfx7B3H-uF2xRXZUQs47J_4xeRmRZ4hcZg@mail.gmail.com> <CAO9r8zOkBVgxdb3pCyHs-ZQTxhwBmA1_+aH0snV7dzbVaVsPsg@mail.gmail.com>
In-Reply-To: <CAO9r8zOkBVgxdb3pCyHs-ZQTxhwBmA1_+aH0snV7dzbVaVsPsg@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 13 Oct 2026 17:05:32 -0700
X-Gm-Features: AclHuK8WhcrCOTeK0kKrzzEhohmXHWs0Un0onHQb7Xyw4WEMp2HD0VK19I_-6P8
Message-ID: <CAJnrk1ayOhrFY8LOMYxqEMYZvhK10zjTTyOK93VzMgxpV5W5sA@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Yosry Ahmed <yosry@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>, James Houghton <jthoughton@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, Song Hu <husong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yosry,

On Mon, Oct 5, 2026 at 1:45=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrote=
:
>
> > I added some instrumentation to prepare_scan_control() and have been
> > seeing that the OOM gets triggered in this pathway:
> > a) the memcg is created with memory.max set to unlimited. 512 M gets
> > faulted in. The new anon folios get put on the inactive list. Nothing
> > reclaims them yet
> > b) userspace then sets memory.max to half of memory.current (~271M
> > from ~542 M currently used). This causes memory_max_write() to trigger
> > reclaim logic
> > c) the folios have already moved to the active list (my
> > instrumentation shows 122684 active vs. 179 inactive) when reclaim
> > does the scanning, which means the only way for pages to be reclaimed
> > is for pages to get deactivated from the active list back to the
> > inactive list.
> > d) prepare_scan_control() (which decides if the pages get deactivated)
> > reads the LRU sizes from rstat. This memcg hasn't been flushed yet
> > (the 2s flusher hasn't yet triggered since when the memcg was
> > created), so the NR_INACTIVE_ANON and NR_ACTIVE_ANON stats are all
> > still zero. The real values are all still sitting in per-cpu buffers
> > that haven't yet been flushed. My instrumentation shows:
> >         inactive_anon       rstat: 0    actual: 179
> >         active_anon          rstat: 0    actual: 122684  (~479 MB)
> > e) the deactivation logic in prepare_scan_control() is:
> >
> >                 refaults =3D lruvec_page_state(target_lruvec,
> >                                 WORKINGSET_ACTIVATE_ANON);
> >                 if (refaults !=3D target_lruvec->refaults[WORKINGSET_AN=
ON] ||
> >                         inactive_is_low(target_lruvec, LRU_INACTIVE_ANO=
N))
> >                         sc->may_deactivate |=3D DEACTIVATE_ANON;
> >                 else
> >                         sc->may_deactivate &=3D ~DEACTIVATE_ANON;
> >
> > The if check fails:
> >      refaults !=3D prev refaults: 0 !=3D 0      (false)
> >      inactive_is_low(): both LRU inactive and active values are 0: 0 *
> > inactive_ratio < 0     ( false)
> >
> > DEACTIVATE_ANON gets cleared
> >
> > f) pages don't get moved from the active list to the inactive list, so
> > reclaim ends up freeing nothing. memory_max_write() goes through all
> > MAX_RECLAIM_RETRIES and OOMs, even though there's 479 MB reclaimable
> > (but it's all on the active list).
> >
> > I saw that the skipped_deactivate retry did fire (on 858 of 4264
> > scans), but not enough to get the memory.current back under the halved
> > memory.max, so memory_max_write() still exhausted MAX_RECLAIM_RETRIES
> > and OOMed.
> >
> >
> > imo I think the best fix would be
> > a) for non-root memcgs, revert back to the non-ratelimited version
> > (mem_cgroup_flush_stats())
> > b) for root-memcgs (which if flushed will flush every cgroup on the
> > machine), don't use rstat at all and use the existing node counters
> > instead (which is what the non-memcg case already uses).
> > mod_lruvec_state() always updates the node vmstat and the memcg lruvec
> > stat in the same call. For the root lruvec, the node counter reflects
> > the same value and doesn't need any flushing. It has an error bound of
> > 125 pages/cpu at most, but this is tighter than what we currently have
> > with the ratelimited version.
>
> This seems like the right thing to do. If we have global stats, we
> should avoid a rstat flush. I actually wonder if we should start
> systematically eliminating root flushes, and if that ends up being
> good enough to keep everything else as-is for in-kernel flushers. The
> flush in zswap_shrinker_count() is also a good candidate, we already
> use global stats when memcg is disabled there as well.

I agree, I think we should replace all root flushes with reading the
node counter values. I'll submit some patches for that.

>
> >
> > commit 90a6f2a8f442 ("memcg: use ratelimited stats flush in the
> > reclaim") was what switched vmscan to using ratelimited flushing. The
> > reason for this was to fix the stalls from concurrent reclaimers
> > contending on the rstat lock. For the Cloudflare case, kswapd threads
> > were contending on the rstat lock on 8 numa-node machines. That's the
> > global path (eg sc->target_mem_cgroup is NULL,
> > mem_cgroup_flush_stats() turns it into root, so this flush essentially
> > ends up flushing every cgroup on the machine), which gets addressed by
> > adding the fix in b), which takes kswapd and global direct reclaim off
> > rstat entirely. For the non-root memcg case, the flushing is bounded
> > by the MEMCG_CHARGE_BATCH * num_online_cpus() threshold (a non-root
> > memcg's stats_updates only accumulates its own subtree's updates, so
> > it takes a lot longer for it to be exceeded than the root's does).
> >
> > I ran some benchmarks to get a rough idea of what a) costs. I set up a
> > workload that allocates 512M of anon memory in a memcg with memory.max
> > set to half of that to trigger reclaim continuously. I varied the
> > number of threads touching the memory, so that N of them hit
> > memory.max and enter direct reclaim on the same memcg at once. I used
> > bpftrace to measure the time spent inside css_rstat_flush() and
> > shrink_node() and used those two numbers to get a percentage for how
> > much of reclaim is spent in flushing. These are the numbers I saw:
> >
> > # threads      flush as % of shrink_node()
> > 1                ratelimited: 1.10%       non-ratelimited: 2.22%
> > 16              ratelimited: 0.36%       non-ratelimited: 2.87%
> > 64              ratelimited: 0.16%       non-ratelimited: 2.52%
> >
> > Between the ratelimited and the non-ratelimited runs, walltime and
> > pgsteal were pretty much indistinguishable (42.7s vs 43.6s at 16
> > threads and 41.7 s vs 42.4s at 64, with the ranges overlapping, and
> > pgsteal within 0.2%).
> >
> > I also measured the lock contention. At 16 and 64 threads, 15-20% of
> > __css_rstat_lock() acquisitions hit a contended trylock with the
> > non-ratelimited version. At 16 threads, the mean flush time rises
> > about 8% and at 64 it roughly triples from the single-thread case
> > (26us at 1 thread, 42 us at 16, 87us at 64)  but I didn't see any
> > effect of this on wall time or pgsteal between the non-ratelimited and
> > the ratelimited version, and the percentage of reclaim time spent
> > flushing stayed at 2-3%. I think that's because css_rstat_flush()
> > takes and drops the lock once per cpu rather than holding it across
> > the walk.
> >
> > I also ran it with 32 actively churning sub-cgroups under the reclaim
> > target, since css_rstat_flush() walks the descendants that have
> > pending updates. I saw that per-flush cost rises slightly (~24 us to
> > 27 us) but the share of reclaim time spent flushing went down rather
> > than up (4.1% to 3.2%), because reclaim gets more expensive faster
> > than flushing does. I don't have a ratelimited baseline at 32 children
> > though, because with the ratelimited version, all the runs I tried
> > OOMed. I think this is an alternative repro to the OOM issue but
> > doesn't need/have KVM dependencies, so if this would be useful to
> > clean up and send as a standalone C repro, please let me know.
>
> It might be useful if it can be added as a selftest or similar, so
> that such regressions can be caught more easily in the future?
>
> >
> > (Also btw (this is a bit tangential to this OOM issue, but somewhat
> > semi-related), I don't think the WORKINGSET_ACTIVATE_{ANON,FILE} stats
> > checking really does anything in practice. On my benchmark runs, the
> > "refaults !=3D prev_refaults" check evaluates to false in pretty much
> > every scan. Even with flushing working properly, it didn't trigger on
> > 1673718 of 1674912 samples, even though the cgroup was thrashing the
> > whole time (a separate run of the same workload counted 6371860 anon
> > refaults vs 6523 activations). I think it's because reclaim is
> > scanning faster than the refaults counter advances, so it'll almost
> > always see no change. I'm not sure how much this matters in practice,
> > but I think effectively in that check above in prepare_scan_control(),
> > deactivation relies entirely on the inactive_is_low() check.)
>
> I am also not sure about this one. I am not sure if reclaim moving
> faster than refaults is something universal, it seems like it would be
> workload-specific. Johannes is the person that comes to mind when I
> think about these heuristics, so maybe he has an opinion about this?
> :)
>
> >
> > What do you all think about adding a) and b) as the fix for this issue?
>
> I generally agree. Doesn't really matter much, but I think we should
> do (b) then (a) to avoid reintroducing the regression temporarily?

I'll send out the patch for (b) and then (a).

Thinking some more about how stats are used... I think there's two
categories the stats fall into: a) hot in-kernel ones (eg LRU sizes,
workingset counters, dirty/writeback, zswap) which are read very
frequently from the reclaim, refault, writeback and zswap paths and b)
userspace-only ones (everything else) that are read through
memory.stat / bpf / etc and much less often. The hot in-kernel ones
are a small subset (~20 of ~80). Most of the stats fall into category
b). However right now, a flush always aggregates *all* of these stats,
even when the caller only needs / cares about the hot in-kernel ones.
Flushing does all the work for the stats in category b), which the
in-kernel flushers don't need. With the per-node lruvec copies, a
flush goes through 100+ counters per cgroup per CPU vs ~30 for just
the hot in-kernel ones (on a single-node machine).

What do you think about splitting the stats into two rstat trees, one
for each category? In-kernel flushers would then only flush the hot
tree (~30 counters). memory.stat would still flush both (eg userspace
would see the same thing as it sees today). Each tree would have its
own lock and its own stats_updates threshold. I can run some
benchmarks but I think this would make flushes a lot cheaper, and
since flushes would hold the lock for less time, it should also reduce
the contention we see between concurrent flushers right now. Together
with using node counters for root readers, hopefully this will make
the non-ratelimited flush cheap enough for all non-root in-kernel
readers and ideally let us get rid of the ratelimiting variant
altogether.

Do you think something like this makes sense?

Separate from this but also kind of semi-related, I noticed
css_rstat_flush() takes the rstat lock for every possible cpu, even
cpus that have nothing to flush for the subtree. Maybe another
improvement is to just first check locklessly whether there's any
updates and then just skip the cpu if there aren't any. I can send a
patch out for this.

Thanks,
Joanne
