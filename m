Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48B175A77
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Mar 2026 14:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015440; cv=none; b=Tsa61+g94yLW5EYxVFrUuY3ycf+fvRkQWlHmW3KHdAOTqzsV6dlwtcSPd6n8HjKAuU9ZoleauLFv6SCvoyEC+Wz94F8SchG1ZRIKDDOfQ8ow6YV8cD1MpJKTJJuGXtZ+HVhWNym2uA16FVulAyMl5fqEOCIcXtU1g8JoSxnCMzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015440; c=relaxed/simple;
	bh=WIsru2BiyzE7Dk092bjfIfjlXQwISEJbpd6Ivo/EHFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VymY5S795Qp8wFJWcpmO/Gnx4QdV1arv3XV8aSHeZjhyAUBrLcYoSUBPuEJkwxAEkYdRgr0ky6j8Cu0GlhOKAFucr/bbsdHznTXIzTw+e5w1oUvyobfQrUUcNs9pN/n4w/5dw0A2e5UXM6ubxdqnYzFmPlKZlB4mo5GHoosfkSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tc4H5TGa; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tc4H5TGa"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774015435;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BQlel+6dtoxswtHUU01IUBagcMsTT/u/Ie50MY6ZLbc=;
	b=Tc4H5TGa1InXyh4vPLhjJgYqKP6CKEGnb/v313Fr+gMkn4PrAhCfqSk/TZIoe+QcU9WTn2
	nrnO3Z9ZeOl/Dm/qu+yr2Z4iUAddehyYbEyD7oWGABzmY5Vx7nrCBh8oH3aEiIdBlYPp40
	IDhxBJfN4f4fFBp051wzopRpOn54ocA=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	willy@infradead.org,
	ryan.roberts@arm.com,
	linux-mm@kvack.org
Cc: r@hev.cc,
	jack@suse.cz,
	ajd@linux.ibm.com,
	apopple@nvidia.com,
	baohua@kernel.org,
	baolin.wang@linux.alibaba.com,
	brauner@kernel.org,
	catalin.marinas@arm.com,
	dev.jain@arm.com,
	kees@kernel.org,
	kevin.brodsky@arm.com,
	lance.yang@linux.dev,
	Liam.Howlett@oracle.com,
	linux-arm-kernel@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lorenzo.stoakes@oracle.com,
	mhocko@suse.com,
	npache@redhat.com,
	pasha.tatashin@soleen.com,
	rmclure@linux.ibm.com,
	rppt@kernel.org,
	surenb@google.com,
	vbabka@kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	wilts.infradead.org,
	linux-fsdevel@vger.kernel.l@kernel.org,
	ziy@nvidia.com,
	hannes@cmpxchg.org,
	kas@kernel.org,
	shakeel.butt@linux.dev,
	kernel-team@meta.com,
	Usama Arif <usama.arif@linux.dev>
Subject: [PATCH v2 0/4] mm: improve large folio readahead and alignment for exec memory
Date: Fri, 20 Mar 2026 06:58:50 -0700
Message-ID: <20260320140315.979307-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

v2 takes a different approach from v1 trying to move away from
exec_folio_order() and comeup with a generic arch independent solution
which is what I think David was suggesting in [1].
I thought I would send it as code rather than try and discuss it in v1
as its easier :)

v1 -> v2: https://lore.kernel.org/all/20260310145406.3073394-1-usama.arif@linux.dev/
- disable mmap_miss logic for VM_EXEC (Jan Kara)
- Align in elf only when segment VA and file offset are already aligned (Rui)
- preferred_exec_order() for VM_EXEC sync mmap_readahead which takes into
  account zone high watermarks (as an approximation of memory pressure)
  (David, or atleast my approach to what David suggested in [1] :))
- Extend max alignment to mapping_max_folio_size() instead of
  exec_folio_order()

Motiviation
===========
exec_folio_order() was introduced [2] to request readahead at an
arch-preferred folio order for executable memory, enabling hardware PTE
coalescing (e.g. arm64 contpte) and PMD mappings on the fault path.

However, several things prevent this from working optimally:

1. The mmap_miss heuristic in do_sync_mmap_readahead() silently disables
   exec readahead after 100 page faults. The mmap_miss counter tracks
   whether readahead is useful for mmap'd file access:

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
   disabled. On arm64 with 64K pages, both decrement paths are inactive:

   - filemap_map_pages() is never called because fault_around_pages
     (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
     requires fault_around_pages > 1. With only 1 page in the
     fault-around window, there is nothing "around" to map.

   - do_async_mmap_readahead() never fires for exec mappings because
     exec readahead sets async_size = 0, so no PG_readahead markers
     are placed.

   With no decrements, mmap_miss monotonically increases past
   MMAP_LOTSAMISS after 100 faults, disabling exec readahead
   for the remainder of the mapping. Patch 1 fixes this by excluding
   VM_EXEC VMAs from the mmap_miss logic, similar to how VM_SEQ_READ
   is already excluded.

2. exec_folio_order() is an arch-specific hook that returns a static
   order (ilog2(SZ_64K >> PAGE_SHIFT)), which is suboptimal for non-4K
   page sizes and doesn't adapt to runtime conditions. Patch 2 replaces
   it with a generic preferred_exec_order() that targets min(PMD_ORDER,
   2M), which naturally gives the right answer across architectures and
   different page sizes: contpte on arm64 (2M for all page sizes), PMD
   mapping on x86 (2M), and smaller PMDs like s390 (1M). The 2M cap also
   avoids requesting excessively large folios on configurations where
   PMD_ORDER is much larger (32M on arm64 16K pages, 512M on arm64 64K
   pages), which would cause unnecessary memory pressure. The function
   adapts at runtime based on VMA size and memory pressure (zone
   watermarks), stepping down the order when memory is tight.

3. Even with correct folio order and readahead, hardware PTE coalescing
   (e.g. contpte) and PMD mapping require the virtual address to be
   aligned to the folio size. The readahead path aligns file offsets and
   the buddy allocator aligns physical memory, but the virtual address
   depends on the VMA start. For PIE binaries, ASLR randomizes the load
   address at PAGE_SIZE granularity, so on arm64 with 64K pages only
   1/32 of load addresses are 2M-aligned. When misaligned, contpte
   cannot be used for any folio in the VMA.

   Patch 3 fixes this for the main binary by extending maximum_alignment()
   in the ELF loader to consider mapping_max_folio_size(), aligning
   load_bias to the largest folio the filesystem will allocate.

   Patch 4 fixes this for shared libraries by adding a folio-size
   alignment fallback in thp_get_unmapped_area_vmflags(). The existing
   PMD_SIZE alignment (512M on arm64 64K pages) is too large for typical
   shared libraries, so this smaller fallback succeeds where PMD fails.

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

[1] https://lore.kernel.org/all/d72d5ca3-4b92-470e-9f89-9f39a3975f1e@kernel.org/
[2] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/
 
Usama Arif (4):
  mm: bypass mmap_miss heuristic for VM_EXEC readahead
  mm: replace exec_folio_order() with generic preferred_exec_order()
  elf: align ET_DYN base to max folio size for PTE coalescing
  mm: align file-backed mmap to max folio order in thp_get_unmapped_area

 arch/arm64/include/asm/pgtable.h |  8 -----
 fs/binfmt_elf.c                  | 38 ++++++++++++++++++--
 include/linux/pgtable.h          | 11 ------
 mm/filemap.c                     | 59 ++++++++++++++++++++++++++++----
 mm/huge_memory.c                 | 14 ++++++++
 5 files changed, 102 insertions(+), 28 deletions(-)

-- 
2.52.0

