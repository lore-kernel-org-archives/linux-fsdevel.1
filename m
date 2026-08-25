Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF946EF87;
	Tue, 25 Aug 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665948; cv=none; b=suOeQYZYlgs1vTzEVE39OU2q5prlnlhvV+8ot+se2dtNbBThYKZntQ1xTTi2YDHwm71j+nqYega5pGNXzfgF4Gf/McQZVUkeG0j90x9eMltKKKc7YCbYp9/khNIOAANIe33bz4afNqgLt+NbSXNpEe1vpmJfG75nQq/Py9jcBjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665948; c=relaxed/simple;
	bh=4RZkaHTxqiwcG0k/89ljlDbZQnrovwC/Ip/zfdAbIXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NY66Eg/NwXBADp+VjLLPG9IXPkIeRstOxyGc3ETKoXNV7fOdufdCKPjpvAHg7u+6Fyt3G2FxvObxHvqYFQb3eWZIVmIkmopU7JXFBAWQORscRWwPBvlfih9wAi8wpLtioFmFbr6qUcAE90lYn4P0GGzQEA6yqUgLD1UNyN3Y2Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id AB2141F481;
	Tue, 25 Aug 2026 13:52:13 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Kairui Song <ryncsn@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Wei Xu <weixugc@google.com>,
	Yuanchu Xie <yuanchu@google.com>,
	Kunwu Chan <kunwu.chan@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v4 0/3] mm: zswap: free cold writeback folios promptly
Date: Tue, 25 Aug 2026 15:52:04 +0200
Message-ID: <20260825135209.3135169-1-alex@ghiti.fr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr
X-GND-Score: -100
X-GND-Cause: dmFkZTGYl0AXaOZFepysbfRmgIWCcm1WN1uPC/DkQSdR4SjwC2U8/OqmN+TBRK9t4RSHKgZNALiSWfA7yrLNtF+y8JjNZ63bDJgQidknUAlZIR/NdnUIpRCMyv5Rl5F5vNSphtmLaD1s7m2EIIHcUtsl5duZLG1PREq8mcJuNbD+pVn+Nj5UL9XohPNW1LzFU/9CUlt+cUrFUH9KyI0w2twjaUFT1IFXVyv2p/ZkWNcZtlea8Rk9+LRiR+dhMoCziSFeN9aBTvoSflgb554OagDyoz3qmeNVXi2yVpMFqvDr5pLGeFVb7RuOOYYMWOS2lvQgQ+0gh22/DQUSXmDTscqA7m8vZgcoenAiONwOQWL6luRfJ0llehgPOQQ1LXoH8Cz9gbBwtn7z/dLHDcQqBLFiEwyGGc/oYWwte6gTNkRPEAFnfMUHwKnw/E4csDPnVMSEnZlMXjdbmc9ufKBfn6AHwAAlC3vRj2tGKVvWFTJqokohcdTu9+6nZAg1CcWuWobmtnzeTm8D/TwG8EM7Y4bEJm/H5mG18dzvQ/JiXrImihf6X4OXc1+5cbmc/7KfOKc7HMTbub4GPlcOW5oyeFk1L6MKEgMdRVl+Z/7Dj2DsoWuICFDMgLq+T8dssPvQLO38xollR1h0sQesJ6RwgxejARzvLuo9RRbZ+zcsWgDxztHjbw
X-GND-State: clean

When zswap writes an entry back, it allocates an order-0 swap cache folio,
decompresses into it, and issues the write. The folio is cold by
construction, yet today it is left on the LRU for page reclaim to find and
free later. That wastes a reclaim scan and keeps cold memory resident
longer than necessary.

Rather than implement this in zswap, extend the existing dropbehind
mechanism to swap cache folios and have zswap opt into it (Yosry). A
PG_dropbehind folio is already dropped from its cache once writeback
completes instead of being left for reclaim; for a swap cache folio that
"drop" is removing it from the swap cache.

  Patch 1 - move LRU insertion out of the swap cache allocator into its
            callers, so zswap writeback can allocate off the LRU.

  Patch 2 - drop dropbehind swap cache folios on writeback completion.

  Patch 3 - zswap allocates its writeback folio off the LRU and marks it
            dropbehind, opting into the mechanism above.

Note: patch 1 also appears as patch 1 of the zswap writeback refault
series [1]. It is the same patch. Both series need it and both are meant
to apply on their own, so it is posted in each; whichever lands first, the
other should drop it.

This version is based on Linus' tree rather than mm-unstable, because it
builds on Tal Zussman's BIO_COMPLETE_IN_TASK work merged in the 7.3 block
pull, which has not reached the mm tree yet. Thanks to Matthew and Barry for
pointing out this series!

v1: https://lore.kernel.org/linux-mm/20260718093723.153324-1-alex@ghiti.fr/
v2: https://lore.kernel.org/linux-mm/20260727143618.1582318-1-alex@ghiti.fr/
v3: https://lore.kernel.org/linux-mm/20260818163221.589352-1-alex@ghiti.fr/

[1] https://lore.kernel.org/linux-mm/20260821093606.2231216-1-alex@ghiti.fr/

Changes in v4:
- Rebase on BIO_COMPLETE_IN_TASK: set it on dropbehind swap writeback like
  the file dropbehind paths do, and drop the folio directly from
  folio_end_writeback(). This removes the per-CPU llist, the workqueue and
  the reuse of folio->lru as the list node.
- zswap now drops its folio reference before starting writeback, so the
  swap cache holds the only one and remove_mapping() sees the refcount it
  expects. This fixes the drop on synchronous-IO devices and the race
  Sashiko reported, where the drop could run before zswap released its
  reference and fall back to the LRU. Verified on zram (the only
  SWP_SYNCHRONOUS_IO backend I have): over ~6.7M writebacks per run, 99.999%
  of the folios are dropped, and the refcount fallback fires 37-50 times.
- Use remove_mapping_reclaim() rather than adding a boolean argument to
  remove_mapping(), which keeps the calling code readable (David). This also
  leaves the existing remove_mapping() callers untouched.
- Patch 1: correct the changelog. The folio has to stay off the LRU because
  folio_add_lru() leaves a reference in the per-CPU LRU batch, not because
  of the free-time page-flag checks. Measured on zram, adding the folio to
  the LRU instead drops the freed rate from 99.999% to 2.7%.

Changes in v3:
- Drop the synchronous-IO special case in zswap writeback (Yosry, Nhat).
- Use mem_cgroup_tryget()/mem_cgroup_put(): struct mem_cgroup is only
  defined under CONFIG_MEMCG, so css_tryget()/css_put() failed to build
  with CONFIG_MEMCG=n.

Changes in v2:
- Make swap dropbehind a generic core-mm mechanism that zswap opts into,
  rather than a zswap-specific implementation (Yosry).
- Allocate off the LRU by moving folio_add_lru() out of the swap cache
  allocator into its callers; rename it to __swap_cache_alloc_folio()
  (Kairui).
- Skip the folio in the free path if it is still under writeback (Nhat).

Results
-------
Paired baseline vs series on async swap (NVMe). Each
workload runs confined to a memory cgroup (memory.max) small enough to force
zswap shrinker writeback.

Kernel build (defconfig, make -j4; memory.max = 600M):

  metric            baseline       series      delta
  pgrotated           441028         2521     -99.4%
  pgsteal_direct     3524343      2869004     -18.6%
  pgscan_direct      8393791      7765008      -7.5%
  zswpwb              705129       699019      -0.9%
  build time (s)        1155         1114      -3.6%

Of the 699019 folios written back, 698990 (99.996%) were freed promptly on
writeback completion; only 28 fell back to reclaim.

MySQL/OLTP (sysbench, 10 tables x 1M rows, 512M buffer pool, 8 threads, 300s;
memory.max = 256M):

  metric            baseline       series      delta
  transactions/s      153.87       163.30      +6.1%
  p95 latency (ms)    157.42       145.82      -7.4%
  avg latency (ms)     52.09        49.05      -5.9%
  pgrotated           743738        22460     -97.0%
  pgsteal_direct     6886490      5445278     -20.9%
  pgscan_direct     13462510     10820730     -19.6%

Future work
-----------
Barry suggested extending this to MADV_PAGEOUT and general reclaim. I
prototyped dropbehind for all reclaimed swap folios and it regressed
sysbench OLTP throughput by ~15% on NVMe swap: dropping the swap cache
immediately turns cheap in-cache refaults into disk reads and collapses
swap readahead clustering. Neither blk-wbt, mq-deadline nor a PG_workingset
gate recovered it. MADV_PAGEOUT alone may still be worth it, since there
userspace has explicitly declared the range cold, but I have not measured
that case in isolation yet.

Alexandre Ghiti (3):
  mm: swap: move LRU insertion out of the swap cache allocator
  mm: swap: drop dropbehind swap cache folios on writeback completion
  mm: zswap: drop cold writeback folios via swap dropbehind

 include/linux/swap.h |  5 ++++
 mm/filemap.c         | 19 ++++++++++++++
 mm/page_io.c         |  7 +++++
 mm/swap.h            |  6 ++---
 mm/swap_state.c      | 61 ++++++++++++++++++++++++++++++++++++++------
 mm/vmscan.c          | 48 ++++++++++++++++++++++++++--------
 mm/zswap.c           | 22 +++++++++++++---
 7 files changed, 143 insertions(+), 25 deletions(-)


base-commit: 55ab7e14222e5f0b0fd9f7711ca391d2924b35e3
-- 
2.53.0-Meta

