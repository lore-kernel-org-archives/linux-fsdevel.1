Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71FBCA4E;
	Mon, 27 Jul 2026 14:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162993; cv=none; b=lVS7/UWSjyPA0GI2T13pJOJ3tGhntriw6IZalslCyP6YkU6f0z5ILREcEWR3WiM2GzfA5GuG2WuWSPRM95iSx0ArOxPioMtT+Vk1/YFV41W8riIzgAOl5C4w7KbyQjDoysOiXAn9EgnBAu4W/ZgW9W7QvN/aLFSADbfc5LUXwzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162993; c=relaxed/simple;
	bh=X8fMVn6ztwJ1wGILkPShhH9U1fqvABGe5JGucI5u8JU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ny2CKQ4x886+l6Ho6dVmaLTZNysGGRNnZFwM3aHZC30XlM4YJXDOwRWbCANm+//NejqGNae3sWzskw/+bhn5OwY5f1VSRgxjPVCq2vAThGWmaiPyPNigaxoG7n7g3NscXtINJ88YtFjc99/gQwk6Ca8aWaJJ9awmfrDhH4V3PTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07C7B3EC6A;
	Mon, 27 Jul 2026 14:36:21 +0000 (UTC)
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
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v2 0/3] mm: zswap: free cold writeback folios promptly
Date: Mon, 27 Jul 2026 16:36:07 +0200
Message-ID: <20260727143618.1582318-1-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTFrO0LV9SN0Fxmgf2Lm62dYOTtW8iLbRU/7IvgNTNAuyaCpaG75iLyUl49ieDOCRD4yAnzErhS+w6tdDrk9EkgQwwAx7yzMXE1cLnydHwWsF8aXbyQ30LnCZOarXGihR3Wfbs/zkIkQCfSb2Uc0l1df3XpjTMDIo3/HOnhQGIQdneB2eXQ6Z92pK3VPzVMgZMim5bD0D6XGxACGWGzmC44HMrIQk3A61rLakGi9RUjhNumhWsSaV7AgbcDpE+DzewZJh26TB1LReqOvXyDDrQBj2gDrTcnPCROmzWfCrrZ8ZDDhL7mjVGQwZ0n/7a5FylpkNilyhbZivi/NW5GMGeDMKs7n8AFVB6zBJHvzbWSbij0gukD5aFYAp7nC/Lejt9rm0X1KogUs/O9tnseksVuyzraSkseyWZyt3AZ+qiosuLnI84tZ7n3U7sqdr/huDb0bpqYHUuwa1G48MFpQ0FOCZ2V/e8gd8qrp9PSNlc96+I5/+r+Phlzka83tU8alg+giEPBwdfE8k1CuEWwS68gpmD+ICx5JQKwc9Y5bJEKiEovqqO+4XF5RKKSBXg6SdbjgOZuK+UA4QePY1gTt8JfMapFq/E5bRz9zaimLC+QN+OGLfrUjRHvDT6KN4EqfYEZ927nn7QxOm6I5QgRd8G7zbKH2lLNskD4dRn1ioVHoDA
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
            callers, so a folio that will be dropped on writeback completion
            (zswap writeback) can be allocated off the LRU without a flag.

  Patch 2 - drop dropbehind swap cache folios on writeback completion. The
            drop needs the folio and swap cluster locks and may sleep, so
            where writeback completes asynchronously (IRQ/softirq) it is
            deferred to a worker via a per-CPU llist, which frees them in
            batches; synchronous-IO swap completes in task context and drops
            the folio inline.

  Patch 3 - zswap allocates its writeback folio off the LRU and marks it
            dropbehind, opting into the mechanism above.

v1: https://lore.kernel.org/linux-mm/20260718093723.153324-1-alex@ghiti.fr/

Changes in v2:
- Make swap dropbehind a generic core-mm mechanism that zswap opts into,
  rather than a zswap-specific implementation (Yosry).
- Allocate off the LRU by moving folio_add_lru() out of the swap cache
  allocator into its callers, instead of a skip_lru flag; rename it to
  __swap_cache_alloc_folio() (Kairui).
- Batch the freed folios in the deferred worker (folios_put) instead of a
  put per folio (Nhat).
- Skip the folio in the free path if it is still under writeback
  (defensive) (Nhat).

Results
-------
Paired baseline vs series on async swap (NVMe, Patch 2 deferred path). Each
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
Barry suggested extending this to MADV_PAGEOUT and general reclaim, since on
asynchronous swap devices the memory is not freed until a later reclaim scan
even after the folio has been written out. I prototyped dropbehind for all
reclaimed swap folios (not included here) and it regressed sysbench OLTP
throughput by ~25% on NVMe swap. This matches Kairui's point that for common
reclaim the swap cache is worth keeping to catch fast refaults, unlike
synchronous-IO or zswap writeback where the reclaimer already waits.

So this series stays scoped to zswap cold writeback. I still need time to work
out whether general reclaim / MADV_PAGEOUT dropbehind is worth pursuing for
everything or only for known-cold cases, and how; I will follow up.

Alexandre Ghiti (3):
  mm: swap: move LRU insertion out of the swap cache allocator
  mm: swap: drop dropbehind swap cache folios on writeback completion
  mm: zswap: drop cold writeback folios via swap dropbehind

 fs/splice.c          |   2 +-
 include/linux/swap.h |   8 ++-
 mm/filemap.c         |  19 ++++++++
 mm/swap.h            |   6 +--
 mm/swap_state.c      | 114 ++++++++++++++++++++++++++++++++++++++++---
 mm/truncate.c        |   2 +-
 mm/vmscan.c          |  13 +++--
 mm/zswap.c           |  16 ++++--
 8 files changed, 159 insertions(+), 21 deletions(-)


base-commit: 626acb37cd445144f321f1b64cac9a93760fa716
-- 
2.53.0-Meta

