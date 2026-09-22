Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833648EBC0
	for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 18:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101718; cv=pass; b=JSvYeR5Vc6uJ+vmAPv7m600wAphHafehMjJhEO52F59h+6xJbV/xqjLFgEwQTIe4ZYRXDsnS5Z67mIpHxMwhYQIa1nMFcBlgilq6eCMmnV6qRkehTjuhvcWiEtKndmmqtrmUb3JnTZRUkvL068Uta2xT3pkBo8oDQYp1I5JRWSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101718; c=relaxed/simple;
	bh=MUg8gty+VrFr0rzb1LNyMqk8tj5TQz6InEGX4571bWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+mqpvZgSWO7/k90KdCmGQwI7UerOv6PptbpvI2AsziySMOEbEW/nT3qAD0CTAQy2GViQephfHxTkarSTWHZ//IiPcb7ZqsqqAUDcSc0vGT96EF1Wqc+30SPqpp52gPstBHKEIzWJYZkoMYiDv3FjkWu1+POJWFALkRR6b/65EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WwnvO1dt; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WwnvO1dt"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a996c8adf3so238665a12.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Sep 2026 11:28:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790101715; cv=none;
        d=google.com; s=arc-20260327;
        b=TJmPNYzr5dqOXHImrgPawwJbFf2moPRAyVQNazMP1PS0YVsuthvJr0XjFO3I0u5Sis
         WM6Z8xcD2f3SbrWlwgQPpSULtOUrGSc4dtkTbhgXyWhDc9IkgEyPHAPoprwqy+Z1ui4m
         HXzxBOdPaMeZjAss7hbnD4PW+VR0ioWPg2wWYgj2DnCGKI+k/mrfDznk+5cXrobsEcTR
         XjMgaGdvoRMQOLBB0Ku4eSgv9xn0jDhq4cQ4Ci+zo4f+1TusBlk10MK3gx5MYeKhsEtH
         cESzKyGV83u0TX+uz90rTn0yxm92ga9O2SO1Nb5yZ4xxduJT0m5g4SLtbkOopsJN7hdP
         1Qpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZRC2VTeDk6B+04vgm9l4c1DOdHjdjNak1zZlGW8XWG0=;
        fh=Lpm7YEGZXLaPPGgJdj/NCymzpuZYWSAITX48yw+wiRE=;
        b=sjZRtWwJbgrczdZleLozZ+FrK4G5hJa1uUu1AoOTanzAqybG7hdAqWUzcrLE+uBu14
         xBTzh6F1wPPkCR4oOQEFmIyspQzsaj4FBZV0tseOt8KoOF54lY6bNTBoX+USKishziUY
         yni5GbEZnYDKZMCe9FX1sj02AYZ7g3iPQwbpjaXQB8PdAUXddK5pQQ8c7CSFzEsiPGCN
         XLmG8LsmhaPVzzo5ScgK6ubHdsNCJF+P+kYcaXVyCBaZKcIG5B5elOKhImR3BYJSYmnW
         EMVNvO6r72jXOXsb4pcReQq8pD/FQPApBeudxEQheSY+0ia5shqFDK5a3XPX+IoRJOm9
         x9XA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790101715; x=1790706515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZRC2VTeDk6B+04vgm9l4c1DOdHjdjNak1zZlGW8XWG0=;
        b=WwnvO1dtbVodVh5S/pvgl/NzwRiORvKxpAA79XP/YpMqFBXUSec+QiI3IvU3KZq3Mv
         FojhjBhvL228UAT3uU3dQjykB7DtExt4UqEOVN1wK5BltOWm+tkLSsYj3ZAACszRYOuD
         ojeVuaa+s1evvtDvbc3ijrI4CFB4gaRXNvfuNRrN+xyNfJRnGsr+fXyGzDDx9RzFKi82
         ncMLq3DKqAmCCBUraMY4jD+/Nugpg7ufi60nObZK5W4JScjngl4E8e5zgavvr0HDHbKp
         rdrh+UbllYBtF+X5i/DmlMOqP9eBI7bGjMO7aqvV91hWQES9Q4tLDm5gTV9b+e63j7Kd
         Mpcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101715; x=1790706515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRC2VTeDk6B+04vgm9l4c1DOdHjdjNak1zZlGW8XWG0=;
        b=Mz6Q5qm+M63k3YUdXBywphQQuOqTyyp5q3yucBWjIBPqEcpBWHvIQeOTAtSnIR7uX9
         ph5ey/5jclwPRc3Lp0TehMhdzkgpj+rDJ/084G99M0ceSmz2V7IKzhHT1aBF3AsHREY4
         Cjzemazg+Fv92KAsObPxc0gz8/IBXdjeD/kZFqJ8zPOqtejl/ha6VbsVqHuv5UryrA9t
         BOf+2D0Qu/sF9ccMVHf7K6kxlp/h+e7588+ylTTXoFNzv+9VWq065ZnSNnmbgbOhKnbZ
         YwAmlceQxUyU39TybiHP74zk0qdAAb9mDM3Ove9xT3kQEzfRNEfhvnJN/FUa7P/9QWSs
         mhHw==
X-Forwarded-Encrypted: i=1; AKwUvBzKcQwBK/kgjX5HYsEc2rFJ0+2fxUpf3UYa69x524Ygq9e39JD+I5nmtqjd8F6iEyOrBFPGBF0AnFcYEsQs@vger.kernel.org
X-Gm-Message-State: AFuF++my1qM2Z7dD1nktYDn8Dyz9h2C/ZhjKMA3TUlGkEFrXAuoZHgEn
	T1BScuCVnzqjfuxz/kZOlr7OlBv18HXjR2j3WRdhKI5GE22VwgP+2hZlhhe6UbG05zvXEgMB8Si
	3fdgvtrlQ6ILFrM8pgl3kz+KafuXJUSQAcIz4+v6C
X-Gm-Gg: AYBFou2UIci4pX6fXuNnS7BztpZpPDWIJ/nTPfL91secBevl/JzYpKbSmP/U15M/6w5
	q8Li8vTj/k+buZcM6VGWGk9agSnY0hSUC2TloQXZOJNSo1aEpPeXkkHhNT+6887+xmCRoFNZepG
	oLAW2w1YbxaWZaF/rW7A5sdDDT1y+WE348VnPqQC7iXv2EakU3n+e3BheyfFfwWgjE/ylei20lJ
	uFnlvV7ywIPpspRKfHslnDFR5eGSVRvPGhLvSddIVs3qxLkD1TmL/m3p51B47kig8h1ISvXjyb1
	5VDCBAzUM5cT/hC5uMU3JsiIo/jfQdTT9jp5L0cX2kPAs/z403M7NqbKDLbKGpc2F4WX3Xegwdd
	kg0Z34y7tMkGzlIgQjIX76JhrG94DlbFO3qvHakv+SE170/4F22FXhML+FjbmvRSL2lHupA422Y
	VjZT8NyhnSE+1pejciDxhXGb3SQhImD2nq0EJrWQHufH1E
X-Received: by 2002:a17:907:972a:b0:c29:f5d8:9c7b with SMTP id
 a640c23a62f3a-c2aadcc89c2mr10085266b.42.1790101714707; Tue, 22 Sep 2026
 11:28:34 -0700 (PDT)
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
 <CADrL8HV7_f68qfd6hG=xCTqzupPqr77ynbwdz8jm0hzjdgDVeg@mail.gmail.com> <CAJnrk1aHdBm4CofvKfx7B3H-uF2xRXZUQs47J_4xeRmRZ4hcZg@mail.gmail.com>
In-Reply-To: <CAJnrk1aHdBm4CofvKfx7B3H-uF2xRXZUQs47J_4xeRmRZ4hcZg@mail.gmail.com>
From: James Houghton <jthoughton@google.com>
Date: Tue, 22 Sep 2026 11:27:57 -0700
X-Gm-Features: AcwNN1WpiJdEAyZo6q7FQIWGi9kaSoG7fR0e7eS1eUfch-3DP7u_DkgKHF6LhzE
Message-ID: <CADrL8HUdzE_ve49msaHksAYGoKmdr+kcTK0otG9wvsFY9WsywQ@mail.gmail.com>
Subject: Re: memcg stats flushing (WAS "Re: [PATCH] fuse: disable default bdi strictlimiting")
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Yosry Ahmed <yosry@kernel.org>, Shakeel Butt <shakeel.butt@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Jan Kara <jack@suse.cz>, Miklos Szeredi <miklos@szeredi.hu>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, kernel-team@meta.com, 
	fuse-devel <fuse-devel@lists.linux.dev>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	linux-mm <linux-mm@kvack.org>, 
	"open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" <cgroups@vger.kernel.org>, Nhat Pham <nphamcs@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Yunzhao Li <yunzhao@cloudflare.com>, Song Hu <husong@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 12:01=E2=80=AFPM Joanne Koong <joannelkoong@gmail.c=
om> wrote:
>
> On Fri, Aug 21, 2026 at 6:39=E2=80=AFPM James Houghton <jthoughton@google=
.com> wrote:
> >
> > On Fri, Aug 21, 2026 at 12:41=E2=80=AFPM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > On Thu, Aug 20, 2026 at 4:39=E2=80=AFPM Joanne Koong <joannelkoong@gm=
ail.com> wrote:
> > > > Would you be able to share the test you're using? I've been trying =
to
> > > > repro it locally without much luck.
> > >
> > > The exact test uses some internal testing libraries, we're looking
> > > into whether we can translate it to a standalone C repro.
> > >
> > > From a high-level, the test:
> > > - Creates a VM with 260 MB (256 MB for testing + 4 MB margin) in a
> > > cgroup, backed by shmem THPs. The VM is not a fully fledged VM, just =
a
> > > KVM VM running bare metal code (so 4 MB is enough margin).
> > > - Enables zswap in the cgroup.
> > > - Tells the VM to write to 256 MB of its memory.
> > > - Checks the cgroup shmem usage and that no swap occurred (no limit).
> > > - Sets the cgroup limit to half the VM memory.
> > > - Checks the cgroup shmem usage and swap again, usage should be ~half
> > > and so is swap.
> > > - Tells the VM to read the 256 MB of memory again. This should cause =
a
> > > lot of thrashing and reclaim, but no OOM kills as all guest memory is
> > > reclaimable.
> > >
> > > With the ratelimited flushing, the test started flaking 5-10% of the
> > > time due to OOM kills.
> >
> > Hi Joanne, Yosry,
> >
> > I've attached a reproducer for you (as a patch that should apply to
> > Linus's tree).
> >
> > In tools/testing/selftests/kvm, `make` should build it. Instructions
> > for running it (like setting up swap/etc.) are in the comment at the
> > top of the file.
> >
> > As part of the patch, I've also included a sysctl to dynamically tune
> > whether or not the memcg stats flush is rate-limited. You should find
> > that when it is rate-limited, OOMs occur, and when it is not, OOMs do
> > not occur.
> >
> > This reproducer behaves slightly differently than our internal
> > version. This version, when run with `-b 512M` anyway, seems to OOM
> > simply by setting memory.max, whereas our internal version would OOM
> > upon re-accessing the memory. Not really a meaningful difference, but
> > just wanted to point it out.
>
> Thanks again for the repro, James.
>
> I added some instrumentation to prepare_scan_control() and have been
> seeing that the OOM gets triggered in this pathway:
> a) the memcg is created with memory.max set to unlimited. 512 M gets
> faulted in. The new anon folios get put on the inactive list. Nothing
> reclaims them yet
> b) userspace then sets memory.max to half of memory.current (~271M
> from ~542 M currently used). This causes memory_max_write() to trigger
> reclaim logic
> c) the folios have already moved to the active list (my
> instrumentation shows 122684 active vs. 179 inactive) when reclaim
> does the scanning, which means the only way for pages to be reclaimed
> is for pages to get deactivated from the active list back to the
> inactive list.
> d) prepare_scan_control() (which decides if the pages get deactivated)
> reads the LRU sizes from rstat. This memcg hasn't been flushed yet
> (the 2s flusher hasn't yet triggered since when the memcg was
> created), so the NR_INACTIVE_ANON and NR_ACTIVE_ANON stats are all
> still zero. The real values are all still sitting in per-cpu buffers
> that haven't yet been flushed. My instrumentation shows:
>         inactive_anon       rstat: 0    actual: 179
>         active_anon          rstat: 0    actual: 122684  (~479 MB)
> e) the deactivation logic in prepare_scan_control() is:
>
>                 refaults =3D lruvec_page_state(target_lruvec,
>                                 WORKINGSET_ACTIVATE_ANON);
>                 if (refaults !=3D target_lruvec->refaults[WORKINGSET_ANON=
] ||
>                         inactive_is_low(target_lruvec, LRU_INACTIVE_ANON)=
)
>                         sc->may_deactivate |=3D DEACTIVATE_ANON;
>                 else
>                         sc->may_deactivate &=3D ~DEACTIVATE_ANON;
>
> The if check fails:
>      refaults !=3D prev refaults: 0 !=3D 0      (false)
>      inactive_is_low(): both LRU inactive and active values are 0: 0 *
> inactive_ratio < 0     ( false)
>
> DEACTIVATE_ANON gets cleared
>
> f) pages don't get moved from the active list to the inactive list, so
> reclaim ends up freeing nothing. memory_max_write() goes through all
> MAX_RECLAIM_RETRIES and OOMs, even though there's 479 MB reclaimable
> (but it's all on the active list).
>
> I saw that the skipped_deactivate retry did fire (on 858 of 4264
> scans), but not enough to get the memory.current back under the halved
> memory.max, so memory_max_write() still exhausted MAX_RECLAIM_RETRIES
> and OOMed.

Great! Thanks for figuring that out.

>
> imo I think the best fix would be
> a) for non-root memcgs, revert back to the non-ratelimited version
> (mem_cgroup_flush_stats())
> b) for root-memcgs (which if flushed will flush every cgroup on the
> machine), don't use rstat at all and use the existing node counters
> instead (which is what the non-memcg case already uses).
> mod_lruvec_state() always updates the node vmstat and the memcg lruvec
> stat in the same call. For the root lruvec, the node counter reflects
> the same value and doesn't need any flushing. It has an error bound of
> 125 pages/cpu at most, but this is tighter than what we currently have
> with the ratelimited version.
>
> commit 90a6f2a8f442 ("memcg: use ratelimited stats flush in the
> reclaim") was what switched vmscan to using ratelimited flushing. The
> reason for this was to fix the stalls from concurrent reclaimers
> contending on the rstat lock. For the Cloudflare case, kswapd threads
> were contending on the rstat lock on 8 numa-node machines. That's the
> global path (eg sc->target_mem_cgroup is NULL,
> mem_cgroup_flush_stats() turns it into root, so this flush essentially
> ends up flushing every cgroup on the machine), which gets addressed by
> adding the fix in b), which takes kswapd and global direct reclaim off
> rstat entirely. For the non-root memcg case, the flushing is bounded
> by the MEMCG_CHARGE_BATCH * num_online_cpus() threshold (a non-root
> memcg's stats_updates only accumulates its own subtree's updates, so
> it takes a lot longer for it to be exceeded than the root's does).
>
> I ran some benchmarks to get a rough idea of what a) costs. I set up a
> workload that allocates 512M of anon memory in a memcg with memory.max
> set to half of that to trigger reclaim continuously. I varied the
> number of threads touching the memory, so that N of them hit
> memory.max and enter direct reclaim on the same memcg at once. I used
> bpftrace to measure the time spent inside css_rstat_flush() and
> shrink_node() and used those two numbers to get a percentage for how
> much of reclaim is spent in flushing. These are the numbers I saw:
>
> # threads      flush as % of shrink_node()
> 1                ratelimited: 1.10%       non-ratelimited: 2.22%
> 16              ratelimited: 0.36%       non-ratelimited: 2.87%
> 64              ratelimited: 0.16%       non-ratelimited: 2.52%
>
> Between the ratelimited and the non-ratelimited runs, walltime and
> pgsteal were pretty much indistinguishable (42.7s vs 43.6s at 16
> threads and 41.7 s vs 42.4s at 64, with the ranges overlapping, and
> pgsteal within 0.2%).
>
> I also measured the lock contention. At 16 and 64 threads, 15-20% of
> __css_rstat_lock() acquisitions hit a contended trylock with the
> non-ratelimited version. At 16 threads, the mean flush time rises
> about 8% and at 64 it roughly triples from the single-thread case
> (26us at 1 thread, 42 us at 16, 87us at 64)  but I didn't see any
> effect of this on wall time or pgsteal between the non-ratelimited and
> the ratelimited version, and the percentage of reclaim time spent
> flushing stayed at 2-3%. I think that's because css_rstat_flush()
> takes and drops the lock once per cpu rather than holding it across
> the walk.
>
> I also ran it with 32 actively churning sub-cgroups under the reclaim
> target, since css_rstat_flush() walks the descendants that have
> pending updates. I saw that per-flush cost rises slightly (~24 us to
> 27 us) but the share of reclaim time spent flushing went down rather
> than up (4.1% to 3.2%), because reclaim gets more expensive faster
> than flushing does. I don't have a ratelimited baseline at 32 children
> though, because with the ratelimited version, all the runs I tried
> OOMed. I think this is an alternative repro to the OOM issue but
> doesn't need/have KVM dependencies, so if this would be useful to
> clean up and send as a standalone C repro, please let me know.

It will probably be useful to send with the (a) and (b) patches. If
it's not very clean, just including it for demonstration is probably
fine (doesn't have to be merged).

> (Also btw (this is a bit tangential to this OOM issue, but somewhat
> semi-related), I don't think the WORKINGSET_ACTIVATE_{ANON,FILE} stats
> checking really does anything in practice. On my benchmark runs, the
> "refaults !=3D prev_refaults" check evaluates to false in pretty much
> every scan. Even with flushing working properly, it didn't trigger on
> 1673718 of 1674912 samples, even though the cgroup was thrashing the
> whole time (a separate run of the same workload counted 6371860 anon
> refaults vs 6523 activations). I think it's because reclaim is
> scanning faster than the refaults counter advances, so it'll almost
> always see no change. I'm not sure how much this matters in practice,
> but I think effectively in that check above in prepare_scan_control(),
> deactivation relies entirely on the inactive_is_low() check.)

Interesting finding. Maybe Yosry will have something intelligent to
say about it; I don't. Yosry will be back on Oct 6.

>
> What do you all think about adding a) and b) as the fix for this issue?

It seems like the right thing to do to me, but I'm not really an
expert on reclaim. I'm guessing Shakeel is happy with this too? I'll
remind Yosry about this thread when he gets back on the 6th so he can
give his opinion.

>
> Thanks,
> Joanne

Thank you very much Joanne, sorry for the delay getting back to you.
