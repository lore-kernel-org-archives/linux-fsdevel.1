Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DA238B14B;
	Sat, 18 Jul 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784367461; cv=none; b=sVPnWC5PDb1UqlzTQQNsx1Ze8vQyP79d1Cmt8byS84LfTCrvfyuI9Z4LsKGPQBV716igbCTR9ojH2+5PT3ufLE0BSgdbbrTfoW3wDiYWifOdlPSoobmp7YT+Y+pfyGBtic7wRpr7TiyLL1KiBbOZSJ6vhMTN47S0CACaUunQW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784367461; c=relaxed/simple;
	bh=rBvLCADFZF4b5aFGCajdhGu7SIU7t1sV/i6F9I4qSWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tw/NtPzIYvSo3G3pCtNN7tVyWE2SBuj2hMNHjc58hnyHb0O7VF/i34/FM5FVPfVVblTM3evYu8SZ/OeaYiw0TxjLisrpiHMGIpav7JTWyGKg1Hi8KVwHuyye7XTTgBPL95kOSBuYnv23CWdo9x46HzW8aFB0rzVXczWD4K+kZUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 711273EBC8;
	Sat, 18 Jul 2026 09:37:26 +0000 (UTC)
From: Alexandre Ghiti <alex@ghiti.fr>
To: Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Li <chrisl@kernel.org>,
	Kairui Song <kasong@tencent.com>
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Baoquan He <baoquan.he@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Youngjun Park <youngjun.park@lge.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH 0/2] mm: zswap: free cold writeback folios promptly
Date: Sat, 18 Jul 2026 11:36:38 +0200
Message-ID: <20260718093723.153324-1-alex@ghiti.fr>
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
X-GND-Cause: dmFkZTFxZvr6XKnOKfRc1Y5n/c8ApM6/T31QCAr0/v+UL4mcP4oFJ63kVxE/eDJp0cRZxKS+V8CME7pUMvNthBL3n3tsGJHtOKbj5Q2GymwU+g+1B8LAIa0550zzXOy+ei8CgQ769VWG59bVPiwVl6po3B1xr2qitYDOHC9e/4FHoR1YSDCeUhwHnZunO4MAKXe/GIaI8fHfeMhlNDfM22nJeMwWtqUVzotlsN+FluS5+iSFLl6rPUt1JKYbPTa+cGnQp78Hd4xR90wjmNlThTrPSs8PZTX0wdLUQSBg5xGRZ0SAThnasMoulXFn5T1gia/xPAbs+OXELh9u/pJoOY4/k9AHemdb5/3dlp7bNnu8DlEY84qS2kwyJX070/NChOFC4aMr5sgTLCu/a91wGVLmYPUh91hvv4T3VT7Iw1oin8GDe2vsoQyy/jbjsaxtvlPQQ2YqDDBwfXPrKjQwUO8ALGChTZ6rHjGGFykb0cdwt3cav0Qy1jrhD8B+8Jc0Lh4GVEiq5HwjwB0CdHSHxDJl5GGawLqyXpiVTWsmNfn6F8ucG3RPkTuApICmYiN0P1ugqBkILAO88b0UYQbKfWOMrGXOcPp7vXH2vxyQM4MZcp/YRQLaJxfewoqJ4NBDslZyvQhTa7M4dceAe5pDJ0wAXWHmn1/brv9z5a8VEhjiNEd1bQ
X-GND-State: clean

When zswap writes an entry back, it allocates an order-0 swap cache folio,
decompresses into it, and issues the write. The folio is cold by
construction, yet today it is left on the LRU for page reclaim to find and
free later. That wastes a reclaim scan and keeps cold memory resident
longer than necessary.

Free the folio as soon as writeback completes instead:

  Patch 1 - synchronous-IO devices (zram, brd, pmem, ...) complete writeback
            in the calling context, so the folio is freed directly there.

  Patch 2 - asynchronous block devices and filesystem-backed swap complete
            writeback in IRQ/softirq context, where the folio cannot be
            freed (that needs the folio and swap cluster locks and may
            sleep). Allocate the folio off the LRU and defer the free to a
            workqueue, which folio_end_writeback() hands it off to.

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

Alexandre Ghiti (2):
  mm: zswap: free synchronous-IO writeback folios directly
  mm: zswap: deferred dropbehind free of writeback folios

 include/linux/zswap.h |  2 ++
 mm/filemap.c          | 20 +++++++++++++
 mm/swap.h             |  3 +-
 mm/swap_state.c       | 17 +++++++----
 mm/zswap.c            | 66 +++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 98 insertions(+), 10 deletions(-)


base-commit: 626acb37cd445144f321f1b64cac9a93760fa716
-- 
2.53.0-Meta

