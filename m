Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3DAE4734F3
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Sep 2026 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946779; cv=none; b=otX/7znKTIuQNJL9D3Ub0NPI5g6sukDLWRPZZbsA3NOsr0qReQ3T71SCkP+8g6+El/pKMn38wsY9HX8jtVxDv+wqns7BRH8WbA2jXQ36dzVmBUpPoQuDdgBdVdFIWdRSFOaPL0MW31xtkyy6b7546tspgvdPKij6AN5QjTzGNfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946779; c=relaxed/simple;
	bh=wVrMGR9QCOw+v/JyHVNBxfh2lOjKqIsVe9hfT4X8OU4=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=FxKfxeSCBgG1iPwkzsICUPDG+o46Ha0dpHIeRnsSVzFmUwUg08u8X/lIxjG6NAj8lHzOa33qWRt+0jWvXNrEAOkZktiaO0KqFZ+Fw0LUh/2QhiMtDBr6rnivxS+RHiX2q29wsDly+82166ZngO49LacRr289zzTTJi8ciXcvUI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nwx7QmG7; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nwx7QmG7"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8565d77c277so73122277b3.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Sep 2026 02:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788946772; x=1789551572; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0zuAVjWjM0/S4ZIDkng7bHRKao4SeQxFnkO87c7tfhg=;
        b=Nwx7QmG7Ba6jpaqtZvttHE4Fh2NlBBxV2S3nYaJuUs7oxI1kvsSukUzCjE8dNkjAUj
         WblOc+5KIrXxklFtK4syBUa4fMxqhnnoO6v5kO5ZeyTsoRjiZCVPoCH0KZmHcPEMQ9rY
         RXRL/DSutt7Gbcmr+37izLMyMYo2Y2xsonMc1QpZfG26v0UuByie0VMMMeqKNtHHBSOS
         fxs6zvoDW3IEqS588ylSbYTGuQF8tbuLhcpgoN36USRmw4rMPT7Tg4BGZobXBqJ8h6fM
         6VrSiajKRqvi+4YbfxlVAielOHP4yMsi09AEwH7uPk2WUhz+YsgwVIZehmOJZLqBt7Qa
         GzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788946772; x=1789551572;
        h=content-type:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0zuAVjWjM0/S4ZIDkng7bHRKao4SeQxFnkO87c7tfhg=;
        b=nbVbs13co3evg1si5bhiWug0rESzrL5wgRMbpC3/kklPD4gymZ19vEd/cR7ZZwIE57
         IYcAU5VLaX1umQtIDlgxsX03xdPy275x9wXMQjqf2lF1uBfaeseYfajGQDTNXLg1WX3m
         oO8XPbNO4/Nd5ZBj25Aw3c0tMVh7q+wzIiL2mcLYDws5xvaQuZEN4kYnf0fr3NQL37+e
         8N//E+rxDKP/0kdim0sxv24JCz8p5GHaltUMp+XcL0hmd3zVytLLQCt4yewDgtcYSjxp
         ioWTvzq0arx1+Vg/rOx2JmaL4JBn8YKAlks8RqQeBpYthy62jPSENuCGyM8gAT51ZrSX
         y8jw==
X-Forwarded-Encrypted: i=1; AKwUvBy97n3D0VHBcMrMUX9M+v1vChG84FP5NVoGmWnVe9UfYLa1GF2F/YB735VOC2LCSCYVVGPeOjvhngw7vRDr@vger.kernel.org
X-Gm-Message-State: AFuF++nLVXzGvPnsHaZp2n1TmfiIz0rg256moMXwLGf92BnhGFpAaqqS
	JXgF0EzcodyGSDyRYnNUMqXKDFju3+Bx5o4kkDwfFDvY3G+oTubf9XsvI1Fkh6QOig==
X-Gm-Gg: AYBFou2WnisD/Iw8BBS3i7s9C6viYE8UA4NBAjh7C7kv8SolP1VTJLN4ggi+75nJEtU
	jKuuv3e+HcLEaWbpV1p7pOn5/HHRXeyftYD5+twk/SMJVzwSoCjvKm7CtmghCLL4iXaIOEI+u/a
	hE+0Hxy8VoksXprhI4OWmFhNEQ/fo5AHbJMcC101eEYTDQRkhzj+4/3hacP7gboxUWsSufcsyKx
	R9j/hPOoWfsJgq0VfYkD0kaLln/4PLvV/ZMYUqrRJySrc8dG7kqelZwJKH1uTZUTtZS1Tu5Ia0L
	ihELvo28n6R2ms4kQJsgDF9KP/pjb+acDHSt1ZGkKMBRTqqsToc+YGI9TCctK5bexyyEpzQNOSe
	m7BpO7Ve4uMP21Ncg2nmxHuFpsto5qXZZii1Fa4ZWl66mdp1t16BBoDuoBpLteySjWx1Be5bAH2
	fE4aeWruhZm5AgT2u6SvanKaCkdIhnQAj1sP1gkEjIqnwCRwXAy7mz4SN5HHeQWiViumZslTcY6
	6nkYRks55YNYoPIJTjtnbvZhGqx1N9ZHKyES5TsP2pLVwhtpQFs2NJ2z4U=
X-Received: by 2002:a05:690c:d84:b0:870:96e4:6709 with SMTP id 00721157ae682-87122985ba4mr131380887b3.9.1788946766316;
        Wed, 09 Sep 2026 02:39:26 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-87149316347sm108893927b3.15.2026.09.09.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 02:39:25 -0700 (PDT)
Date: Wed, 9 Sep 2026 02:39:08 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
cc: Ackerley Tng <ackerleytng@google.com>, 
    Alexander Viro <viro@zeniv.linux.org.uk>, Alexandre Ghiti <alex@ghiti.fr>, 
    Baolin Wang <baolin.wang@linux.alibaba.com>, 
    Barry Song <baohua@kernel.org>, Binbin Wu <binbin.wu@linux.intel.com>, 
    Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Christoph Lameter <cl@gentwo.org>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    David Hildenbrand <david@kernel.org>, Hugh Dickins <hughd@google.com>, 
    JP Kobryn <jp.kobryn@linux.dev>, Jan Kara <jack@suse.cz>, 
    Jens Axboe <axboe@kernel.dk>, Johannes Weiner <hannes@cmpxchg.org>, 
    Kairui Song <ryncsn@gmail.com>, Kiryl Shutsemau <kas@kernel.org>, 
    Lance Yang <lance.yang@linux.dev>, Leonardo Bras <leobras.c@gmail.com>, 
    Lorenzo Stoakes <ljs@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, 
    Matthew Wilcox <willy@infradead.org>, 
    Mel Gorman <mgorman@techsingularity.net>, 
    Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>, 
    Minchan Kim <minchan@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
    Oscar Salvador <osalvador@suse.de>, Peter Zijlstra <peterz@infradead.org>, 
    Qi Zheng <qi.zheng@linux.dev>, Rik van Riel <riel@surriel.com>, 
    Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
    Shakeel Butt <shakeel.butt@linux.dev>, 
    Suren Baghdasaryan <surenb@google.com>, 
    Vlastimil Babka <vbabka@kernel.org>, 
    Yang Shi <yang@os.amperecomputing.com>, Yu Zhao <yuzhao@google.com>, 
    Zach O'Keefe <zokeefe@google.com>, Zi Yan <ziy@nvidia.com>, 
    linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()
Message-ID: <e28f9a94-4339-f8ac-8301-6be3c9b5b7ce@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

[PATCH v2 00/26] mm/fbatch: drain lru_add_drain() and _all()

This series was prompted by lru_add_drain_all() appearing in watchdog
backtraces: not to blame, but blocked on an unresponsive CPU to run
its workqueue. lru_add_drain_all() is a heavyweight operation, which
we often hope to avoid by a much lighter lru_add_drain(); but even
those local drains can aggravate the lruvec lock contention which
per-cpu fbatches are intended to ease.

Now let the folios on the lru_add and other per-cpu fbatches remain
there, isolatable, with PG_lru set and refcount unraised, just like
when on an actual LRU. Then many calls to lru_add_drain() and _all()
can be removed.

It's something I've wanted to do for years, tried several times, but
only hit on a good way to do it a few weeks ago: now it's uncomfortable
to watch others wrestling with the drainage, while I'm sitting on this.

The key idea came from the "if (!folio_test_clear_lru(folio)) continue;".
If we don't mind missing to take an action on rare occasions, then maybe
we won't mind taking an action on the wrong folio on rare occasions, so
long as it is a folio consenting to PG_lru rules.

No new locking, but relies on folio_try_get() and folio_test_clear_lru()
even on the lru_add fbatch; with use of bits not set in aligned pointers,
and some try_cmpxchg()ing.  Speculative references to folios are already
accepted: this adds another source of them.

Performance? You (and the bots) tell me. I'm considering this as a
cleanup, to make life easier for developers. I expect that some loads
will show improvement, but also expect some disappointments (perhaps
I go too far against lru_cache_disable()? or not far enough).

The timing is not good: I'm taking three weeks off today; but it's best
to get this out in the open early. If it's welcome in principle for 7.4,
but changes needed, maybe someone else can step up to shepherd it
through; otherwise, I can take it up again for 7.5.

Rebased and retested on Linus's v7.3-rc2 tree, after adding two mm.git
dependencies which did not get into rc2, but can be expected in rc3:
Shakeel's "mm/mlock: use the IRQ-safe accessor for NR_MLOCK in
__munlock_folio()" and Ackerley's "mm/folio: EXPORT_SYMBOL_FOR_KVM(
lru_cache_drain_for_folio)". Those two are now in mm-hotfixes-stable
(e14a34548064 and 7891fbb9512f respectively: thanks to Andrew) as of
mm-everything-2026-09-09-06-32, and the series applied and briefly
tested over 09-09's earlier mm-everything, so I'm giving a hopeful
but not entirely honest base-commit below.

v1 posted on 24 August had 25 patches, with 26/25 added later:
Link: https://lore.kernel.org/linux-mm/14a16945-529b-8bc0-ab38-3ea97e54e223@google.com/

01/26 mm/fbatch: remove !CONFIG_SMP special case of folio_activate()
  v2: added Ack from David, R-b Vlastimil
02/26 mm/fbatch: allow folios_put_refs() to skip xa_is_value() entries
  v2: added Ack from David, R-b Vlastimil
03/26 mm/fbatch: temporarily disable lazyfree and mlock+munlock batching
  v2: added R-b Vlastimil
04/26 mm/fbatch: lru bit set, no extra ref, while folio on per-cpu fbatch
  v2: added comment on Bit 1 of page->lru.next per Kiryl and Matthew
      READ/WRITE_ONCE smp_mb__before_atomic per 07/25 discussion with Kiryl
      fixed (commented out) BUG_ON in lru_add_del_folio()
05/26 mm/fbatch: lru_add_del_folio()+folio_add_lru() after clear_lru()
06/26 mm/fbatch: fbatch_drain_lazyfree(onstack fbatch) before ptl unlock
07/26 mm/fbatch: LRU_NEXT_ACTIVATE bit to optimize folio_activate()
  v2: hunk in lru_add_del_folio() updated according to mods in 04/26
08/26 mm/fbatch: replace mlock_new_folio() by __folio_add_lru(,mlockit)
  v2: updated 04/26 Bit 1 comment on folio_add_lru() to __folio_add_lru()
09/26 mm/fbatch: restore mlock+munlock batching, without extra ref
  v2: rediffed around Shakeel's NR_MLOCK fix, fixed unknowingly in v1
10/26 mm/fbatch: remove several uses of mlock_drain_local()
11/26 mm/fbatch: remove migration's PAGE_WAS_MLOCKED lru_add_drain()
  v2: conversely, use !folio_evictable() in isolate_migratepages_block()
12/26 mm/fbatch: remove percpu_pvec_drained and folios_put()
13/26 mm/fbatch: no lru_add drain to collect_longterm_unpinnable_folios()
  v2: revert David's rc1 lru_cache_drain_for_folio() from mm/folio.c,
      and Ackerley's EXPORT for KVM; but keep an inline stub in swap.h
14/26 mm/fbatch: no lru_add_drain() nor _all() for memfd_wait_for_pins()
15/26 mm/fbatch: remove shake_folio() shake_page() from memory-failure
  v2: added Ack from Miaohe
16/26 mm/fbatch: remove lru_cache_disable() from NUMA folio migration
17/26 mm/fbatch: no lru_cache_disable() in __alloc_contig_migrate_range()
18/26 mm/fbatch: remove lru_add_drain() and _all() calls from various
19/26 mm/fbatch: vm/stat_refresh include lru_add_drain() on each cpu
20/26 s390/fbatch: no lru_add_drain_all() in s390_wiggle_split_folio()
21/26 block/fbatch: no lru_add_drain_all() in invalidate_bdev()
22/26 fs/fbatch: drop_caches invalidate_bh_lrus() not lru_add_drain_all()
23/26 fs,mm/fbatch: use invalidate_bh_lrus() not invalidate_bh_lrus_cpu()
24/26 fs,mm/fbatch: lru_cache_disable() keep off buffer_head lrus only
25/26 mm/fbatch: move lru_add_drain_all() declaration to mm/internal.h
26/26 mm/fbatch: drop reference inside the loop when draining

 Documentation/mm/unevictable-lru.rst |   2 +-
 arch/s390/kernel/uv.c                |   1 -
 block/bdev.c                         |   1 -
 fs/buffer.c                          |  40 +--
 fs/drop_caches.c                     |   4 +-
 include/linux/buffer_head.h          |   8 +-
 include/linux/folio_batch.h          |   7 +-
 include/linux/huge_mm.h              |   6 +-
 include/linux/mm.h                   |  18 --
 include/linux/mm_inline.h            |  29 ++
 include/linux/mm_types.h             |  14 +-
 include/linux/swap.h                 |  23 +-
 mm/compaction.c                      |  27 +-
 mm/fadvise.c                         |  17 +-
 mm/folio.c                           | 436 +++++++++------------------
 mm/gup.c                             |   9 -
 mm/huge_memory.c                     |  16 +-
 mm/hwpoison-inject.c                 |   1 -
 mm/internal.h                        |  15 +-
 mm/khugepaged.c                      |  11 -
 mm/ksm.c                             |  12 -
 mm/madvise.c                         |   9 +-
 mm/memfd.c                           |   6 +-
 mm/memory-failure.c                  |  38 +--
 mm/memory.c                          |  14 +-
 mm/memory_hotplug.c                  |   4 +
 mm/mempolicy.c                       |   7 -
 mm/migrate.c                         |  13 +-
 mm/migrate_device.c                  |   9 -
 mm/mlock.c                           | 211 +++++++------
 mm/page_alloc.c                      |   3 -
 mm/rmap.c                            |   4 -
 mm/shmem.c                           |   2 -
 mm/truncate.c                        |  17 +-
 mm/vmscan.c                          |  16 +-
 mm/vmstat.c                          |   1 +
 36 files changed, 388 insertions(+), 663 deletions(-)

base-commit: 7891fbb9512f127826e1d5dbf380ee212bd15eb0

Hugh
