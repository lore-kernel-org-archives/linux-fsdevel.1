Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE79226CF6
	for <linux-fsdevel@vger.kernel.org>; Tue,  7 Jul 2026 06:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783406559; cv=none; b=X/jjVMr7+XlWk9ZAw8PVTg3V8bXLgzwhyl0PLYTO9TNyRkNIIfI2Q2X44ykLv+oawiF96sCcfWixOuBjqs09sCj4YWOcGkeob6ioJDPXiHCzRS2KPK/K0XQbu1ANjF0AYRVk0xj6Y2sRUfdaeifBMCUfQX8jnL1ufVAkSyUnBJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783406559; c=relaxed/simple;
	bh=B/v3yD3THr5KLSeciELWEn01erDJ+vQR61nouTY3vQs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=LaVwOBsp+/Al1v/sxSx3EawZOqhPHcZrVGHp1S5hwhLwxi6TLPWk03TXq5qDqBohB2MIYENmW3MFd5Hdy2MwRfAjDVFCa26pAUN/4B8a14RJbVdAMxn8VJ549YSy4MnxXDvl09j7WxKW/1gkSUlLtLd6GZOCGUrDPyor9BFKemc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MKfxB/qE; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--souravpanda.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MKfxB/qE"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2ccd1958e8fso1960565ad.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 06 Jul 2026 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783406557; x=1784011357; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xeJmdcEDb3hj4kjTojGe7izWAUg4e6NWPJspG9L+qV0=;
        b=MKfxB/qE5Uhvgr4iMlZw+NshbtkAaGXjtxwexssYpIbyaVTYUtZgGUrlUQ4Y+8XbVp
         Ik/BHEkvqiOlF67bRAm3T/iYk7WZNzPUptKl+wN+Dqonkc8WReQcgNlla/vF9IZFdlxO
         WoCGSAqjG0kdvqFcYMXBoWKy9h3fTv3gqX7T+7GmLvg74+cMpfvrCrIFRVlXK1rFrcOx
         6jRXaRfjMmz2nIfbY2vjmfvxnEUMJkf0jk6WEpjWWflv6C7+PKDx9TNHE/IAtdHQjkvJ
         PVyJlaismplp+yxcI1h3Bmp1Rk3tilzCHbjw08H4QsyswO581OJcj1pbUSZtZxo6KqeO
         R0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783406557; x=1784011357;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xeJmdcEDb3hj4kjTojGe7izWAUg4e6NWPJspG9L+qV0=;
        b=jh0iimQs6zbGEG2EF+irk1hrpnHvSAL5Bg8g1Uue3DSah3k4HM/5w7ePVuj7dVE0iq
         j2y3cayE31i2glnDSMoo0CiE4lwMcvxTcnndUwFBFGI/60X8RXJJw/RYK0oW9/VBnRHA
         z+NqdcN/EDRhMX+NTG1D7lkBuaS80n9o1cu8kQoE9ymWeamqzuILDdeKbeSmKX/8Ouph
         dM49YkvyadW88E5RacxYT+VdHCVgin39XMPAGC6tkGgXAkJeMFjqNHatVv4uwhzvh9Jp
         cl/+Toyh4IwXr5W/UJzR4q8qYqfTfxmjm3nSo8jdWvHCJmNjFIBgQX0VVSDsSbrA6oRn
         ZvKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq2ecGXcWD0kOFod2IYvLb6Q+JjjMe7loja+HiIZ3ucpATb7GNac9AqaZCDgVpfX2v54pUfFWdkyDjeP8za@vger.kernel.org
X-Gm-Message-State: AOJu0Yy76Kc2H9Tv5u9dvu8mgDTOjPPhoVYOP7wEzR/E2IFXXDfOGv3s
	L8yCAHsDYlUpuzpqmLN8qWW0gtNgWL5NcKhRRsaZ3F76Lzb3nyiL+y0svhEE7Cimb85Pm5bPPri
	fOlGVbH1yWdqdpSPY7ay3eZfieQ==
X-Received: from plblk15.prod.google.com ([2002:a17:903:8cf:b0:2c6:bce1:2477])
 (user=souravpanda job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:388b:b0:2ca:d463:27fc with SMTP id d9443c01a7336-2ccbf076ebdmr41254245ad.45.1783406556649;
 Mon, 06 Jul 2026 23:42:36 -0700 (PDT)
Date: Tue,  7 Jul 2026 06:42:29 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260707064235.1386552-1-souravpanda@google.com>
Subject: [RFC PATCH 0/6] mm/hugetlb: Dynamic, NUMA-aware HugePage Cache & Free
 Page Reporting
From: Sourav Panda <souravpanda@google.com>
To: muchun.song@linux.dev, osalvador@suse.de, akpm@linux-foundation.org
Cc: david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, mst@redhat.com, 
	mhklinux@outlook.com, souravpanda@google.com, fvdl@google.com, 
	gthelen@google.com, mike.kravetz@oracle.com, pasha.tatashin@soleen.com, 
	rientjes@google.com, riel@surriel.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Overview
This patch series introduces a dynamic, NUMA-aware HugePage Cache,
backed by a kernel shrinker to safely return memory under pressure, and
integrates it with Free Page Reporting (virtio-balloon) for HugeTLB,
specifically targeting gigantic (1GB) hugepages. The goal is to solve
the tradeoff between allocation latency and memory
fungibility in virtualized and heterogeneous cloud environments.

---

The Core Problem: Allocation Latency vs. Memory Fungibility

With highly heterogeneous workloads, latency-critical applications demand
gigantic hugepages. However, dynamic runtime allocation of 1GB pages
from the buddy allocator (via CMA) is slow.

To bypass this latency, operators often pre-allocate hugepages
statically. However, this locks up the memory: when the HugeTLB
workloads are idle, that memory is completely unavailable for other
buddy-allocator workloads (e.g., page cache, anonymous memory). If buddy
memory is exhausted, the system will OOM even if gigabytes of HugeTLB
pages are sitting idle.

This series resolves this challenge by delivering Dynamic Fungibility:

1.  Dynamic Caching: Intercepts freed surplus hugepages and recycles
    them into a NUMA-aware cache instead of dissolving them immediately.
2.  Fast Allocations: Satisfies subsequent dynamic allocations
    instantly from this warm, local hugepage cache.
3.  Kernel Shrinker Integration: Registers a NUMA-aware kernel shrinker
    to dynamically dissolve cached pages back to the buddy allocator
    under memory pressure, restoring host/guest memory fungibility.
4.  Free Page Reporting Integration: For virtualized environments (Guest
    VMs), cached pages trigger background Free Page Reporting via
    virtio-balloon. This allows the host to reclaim the physical memory
    while the guest retains its Vmemmap Optimization (HVO) metadata
    savings (~14GB saved per 1TB VM)!

  +---------------+   Slow Allocate  +---------------------+
  | Buddy         | ---------------> | Active HugeTLB Page |
  | Allocator     |                  +---------------------+
  +---------------+                    |                ^
    ^                                  | (1) Free to    | (2) Fast
    | (3) Under                        v     Cache      |     Allocate
    | Pressure                       +---------------------+
    | Shrink()  <------------------- | HugeTLB Cache       |
                                     +---------------------+
                                       |
                                       v (4) Free Page Reporting
                                         (Host Reclaim in the case
                                          of virtualization)

---

Patch Series Structure

Patch 1/6: mm/hugetlb: add Kconfig and basic cache infrastructure
  - Introduces the CONFIG_HUGETLB_CACHE option, hstate tracking fields,
    and the HPG_cached page flag.
  - Establishes the clean helper API (hugetlb_folio_is_cached(),
    hugetlb_cache_remove(), hugetlb_cache_add()) and updates
    remove_hugetlb_folio() to be cache-aware, eliminating inline #ifdef
    blocks.
Patch 2/6: mm/hugetlb: implement cache recycling and allocation
  - Hooks up recycling in free_huge_folio() (up to the cache limit) and
    allocation in alloc_surplus_hugetlb_folio().
  - Implements MRU allocation policy for maximum warmth, poison safety
    checks, and MTE/dcache cleaning.
Patch 3/6: mm/hugetlb: add sysfs interfaces for cache
  - Exposes global and per-node sysfs attributes (max_cached_huge_pages,
    nr_cached_hugepages) for dynamic userspace control, including NUMA
    memory policy scaling.
  - Supports dynamic delta adjustments (+1/-1) to safely scale cache
    sizes alongside concurrent background reclaim operations.
Patch 4/6: mm/hugetlb: add memory shrinker for cache
  - Registers a NUMA-aware kernel shrinker to evict and dissolve cached
    gigantic pages back to buddy under memory pressure.
Patch 5/6: Documentation/admin-guide/mm/hugetlbpage.rst: document cache
    interfaces
  - Documents the Kconfig option, sysfs attributes, and shrinker
    behavior in the admin guide.
Patch 6/6: mm/hugetlb: support free page reporting for cached hugepages
  - Integrates the cache with the Free Page Reporting framework (virtio-
    balloon), introducing the HPG_reported flag and the
    reporting/isolation/draining lifecycle.
Sourav Panda (6):
  mm/hugetlb: add Kconfig and basic cache infrastructure
  mm/hugetlb: implement cache recycling and allocation
  mm/hugetlb: add sysfs interfaces for cache
  mm/hugetlb: add memory shrinker for cache
  Documentation/admin-guide/mm/hugetlbpage.rst: document cache
    interfaces
  mm/hugetlb: support free page reporting for cached hugepages

 Documentation/admin-guide/mm/hugetlbpage.rst |  34 +-
 fs/Kconfig                                   |   9 +
 include/linux/hugetlb.h                      |  45 ++
 include/linux/page_reporting.h               |   1 +
 mm/hugetlb.c                                 | 590 ++++++++++++++++++-
 mm/hugetlb_internal.h                        |   9 +
 mm/hugetlb_sysfs.c                           | 158 +++++
 mm/page_reporting.c                          |  10 +-
 mm/page_reporting.h                          |   6 +
 9 files changed, 844 insertions(+), 18 deletions(-)

-- 
2.55.0.rc0.799.gd6f94ed593-goog

