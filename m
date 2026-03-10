Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727628504D
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Mar 2026 14:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154475; cv=none; b=LFBamgZUmR+touSwNnnegv7GKjbZyNrRErB6UOC8+iF0MiGBH1qVOaMuhLiIuZxgAKCExkGhDHA6lI/Z1+4K/hF03/mwxPa9Oz+2OHpk+A4oT6Lm9hRUeW45//w8awvZrPVW57GpAavMHYXLhjX5+S+9jgYtD47wzSidMJrMNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154475; c=relaxed/simple;
	bh=QAndjWjxJxwaAwY7sL2V0430MMjlhW8ZFkRPt0OapTc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ckLd19TOSq+rDnnR4T3hUTfA8qOvekdOy3+DEubfUx1wIFDj3Rh5+MyrLCIcUELGV5xk2voYDOvbpxFOCqSG5YWx9FSpz5g6yy449RGTDjp7rMX4eFj0XebnZAUzCJiopY4GEAmi7mHJkP/fQ+Gjr92poCanKa+OMpIcoSH9V6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NqRwT0Fm; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NqRwT0Fm"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773154471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=uuUPog/sat/7+aZpFjgpyR9bUfWW9xmLj9hpLXqUPz0=;
	b=NqRwT0FmjKurBS8uijqZStk0R4uXypa5ydCIh60zoT51JmyCam2xRx7RNnUj7Tn7disMZo
	z4+VQpi4Mp7pjrF7uEPmv4kl/BI1ZAjZWNWs+m9wRMcAopWE6LbczsrDmPbOEbqD+/2AHD
	xsGdWVOhi6nRUAa376ydbe0mcaoZJtk=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	ryan.roberts@arm.com,
	david@kernel.org
Cc: ajd@linux.ibm.com,
	anshuman.khandual@arm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	jack@suse.cz,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	lorenzo.stoakes@oracle.com,
	npache@redhat.com,
	rmclure@linux.ibm.com,
	Al Viro <viro@zeniv.linux.org.uk>,
	will@kernel.org,
	willy@infradead.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K pages
Date: Tue, 10 Mar 2026 07:51:13 -0700
Message-ID: <20260310145406.3073394-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On arm64, the contpte hardware feature coalesces multiple contiguous PTEs
into a single iTLB entry, reducing iTLB pressure for large executable
mappings.

exec_folio_order() was introduced [1] to request readahead at an
arch-preferred folio order for executable memory, enabling contpte
mapping on the fault path.

However, several things prevent this from working optimally on 16K and
64K page configurations:

1. exec_folio_order() returns ilog2(SZ_64K >> PAGE_SHIFT), which only
   produces the optimal contpte order for 4K pages. For 16K pages it
   returns order 2 (64K) instead of order 7 (2M), and for 64K pages it
   returns order 0 (64K) instead of order 5 (2M). Patch 1 fixes this by
   using ilog2(CONT_PTES) which evaluates to the optimal order for all
   page sizes.

2. Even with the optimal order, the mmap_miss heuristic in
   do_sync_mmap_readahead() silently disables exec readahead after 100
   page faults. The mmap_miss counter tracks whether readahead is useful
   for mmap'd file access:

   - Incremented by 1 in do_sync_mmap_readahead() on every page cache
     miss (page needed IO).

   - Decremented by N in filemap_map_pages() for N pages successfully
     mapped via fault-around (pages found in cache without faulting,
     evidence that readahead was useful). Only non-workingset pages
     count and recently evicted and re-read pages don't count as hits.

   - Decremented by 1 in do_async_mmap_readahead() when a PG_readahead
     marker page is found (indicates sequential consumption of readahead
     pages).

   When mmap_miss exceeds MMAP_LOTSAMISS (100), all readahead is
   disabled. On 64K pages, both decrement paths are inactive:

   - filemap_map_pages() is never called because fault_around_pages
     (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
     requires fault_around_pages > 1. With only 1 page in the
     fault-around window, there is nothing "around" to map.

   - do_async_mmap_readahead() never fires for exec mappings because
     exec readahead sets async_size = 0, so no PG_readahead markers
     are placed.

   With no decrements, mmap_miss monotonically increases past
   MMAP_LOTSAMISS after 100 faults, disabling exec readahead
   for the remainder of the mapping.
   Patch 2 fixes this by moving the VM_EXEC readahead block
   above the mmap_miss check, since exec readahead is targeted (one
   folio at the fault location, async_size=0) not speculative prefetch.

3. Even with correct folio order and readahead, contpte mapping requires
   the virtual address to be aligned to CONT_PTE_SIZE (2M on 64K pages).
   The readahead path aligns file offsets and the buddy allocator aligns
   physical memory, but the virtual address depends on the VMA start.
   For PIE binaries, ASLR randomizes the load address at PAGE_SIZE (64K)
   granularity, giving only a 1/32 chance of 2M alignment. When
   misaligned, contpte_set_ptes() never sets the contiguous PTE bit for
   any folio in the VMA, resulting in zero iTLB coalescing benefit.

   Patch 3 fixes this for the main binary by bumping the ELF loader's
   alignment to PAGE_SIZE << exec_folio_order() for ET_DYN binaries.

   Patch 4 fixes this for shared libraries by adding a contpte-size
   alignment fallback in thp_get_unmapped_area_vmflags(). The existing
   PMD_SIZE alignment (512M on 64K pages) is too large for typical shared
   libraries, so this smaller fallback (2M) succeeds where PMD fails.

I created a benchmark that mmaps a large executable file and calls
RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
fault + readahead cost. "Random" first faults in all pages with a
sequential sweep (not measured), then measures time for calling random
offsets, isolating iTLB miss cost for scattered execution.

The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
512MB executable file on ext4, averaged over 3 runs:

  Phase      | Baseline     | Patched      | Improvement
  -----------|--------------|--------------|------------------
  Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
  Random     | 76.0 ms      | 58.3 ms      | 23% faster

[1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/

Usama Arif (4):
  arm64: request contpte-sized folios for exec memory
  mm: bypass mmap_miss heuristic for VM_EXEC readahead
  elf: align ET_DYN base to exec folio order for contpte mapping
  mm: align file-backed mmap to exec folio order in
    thp_get_unmapped_area

 arch/arm64/include/asm/pgtable.h |  9 ++--
 fs/binfmt_elf.c                  | 15 +++++++
 mm/filemap.c                     | 72 +++++++++++++++++---------------
 mm/huge_memory.c                 | 17 ++++++++
 4 files changed, 75 insertions(+), 38 deletions(-)

-- 
2.47.3

