Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8998839BFEC;
	Fri, 13 Mar 2026 16:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773419632; cv=none; b=JiRTom8h4h02Zd2DDqd7aVtQNpJoTSjubD6UEP6apAwWRlU6HVCOSrEpK6Gn1j++5aMmaTKe7DTkGjPZQgFlm1sg5C0ZV600o6Lccb1xssX95ImjDLRHn+fsvR9+WjSKO6G1SQjMuR9B/EMCqYBotw/EZ1nJFaMjDnM4Cd/h5VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773419632; c=relaxed/simple;
	bh=fmViBTQbbi+D3TAA0Zw3Pqto/YNDpnz8iRtqZIVcpcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8NqkVB2QqyT2qFJ7kur6+sqyW0OzY4WFI2IcYY1mCK9IT3hrxyIfNxDNN+iCv6Irj7DS8Np3T/J8vZiMd2vD5snYQAz8hFwBNPRvFw4lmcIJbtKg/Es8MNiBmAfos3CD1t4M4AkS6E33gVA9uXbl4vff7PcDcuLP/axL5WIP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 964C8176A;
	Fri, 13 Mar 2026 09:33:43 -0700 (PDT)
Received: from [10.57.83.238] (unknown [10.57.83.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 223D43F7BD;
	Fri, 13 Mar 2026 09:33:43 -0700 (PDT)
Message-ID: <cfdfca9c-4752-4037-a289-03e6e7a00d47@arm.com>
Date: Fri, 13 Mar 2026 16:33:42 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm64/mm: contpte-sized exec folios for 16K and 64K
 pages
Content-Language: en-GB
To: Usama Arif <usama.arif@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, david@kernel.org
Cc: ajd@linux.ibm.com, anshuman.khandual@arm.com, apopple@nvidia.com,
 baohua@kernel.org, baolin.wang@linux.alibaba.com, brauner@kernel.org,
 catalin.marinas@arm.com, dev.jain@arm.com, jack@suse.cz, kees@kernel.org,
 kevin.brodsky@arm.com, lance.yang@linux.dev, Liam.Howlett@oracle.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 lorenzo.stoakes@oracle.com, npache@redhat.com, rmclure@linux.ibm.com,
 Al Viro <viro@zeniv.linux.org.uk>, will@kernel.org, willy@infradead.org,
 ziy@nvidia.com, hannes@cmpxchg.org, kas@kernel.org, shakeel.butt@linux.dev,
 kernel-team@meta.com
References: <20260310145406.3073394-1-usama.arif@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20260310145406.3073394-1-usama.arif@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/03/2026 14:51, Usama Arif wrote:
> On arm64, the contpte hardware feature coalesces multiple contiguous PTEs
> into a single iTLB entry, reducing iTLB pressure for large executable
> mappings.
> 
> exec_folio_order() was introduced [1] to request readahead at an
> arch-preferred folio order for executable memory, enabling contpte
> mapping on the fault path.
> 
> However, several things prevent this from working optimally on 16K and
> 64K page configurations:
> 
> 1. exec_folio_order() returns ilog2(SZ_64K >> PAGE_SHIFT), which only
>    produces the optimal contpte order for 4K pages. For 16K pages it
>    returns order 2 (64K) instead of order 7 (2M), and for 64K pages it
>    returns order 0 (64K) instead of order 5 (2M). 

This was deliberate, although perhaps a bit conservative. I was concerned about
the possibility of read amplification; pointlessly reading in a load of memory
that never actually gets used. And that is independent of page size.

2M seems quite big as a default IMHO, I could imagine Android might complain
about memory pressure in their 16K config, for example.

Additionally, ELF files are normally only aligned to 64K and you can only get
the TLB benefits if the memory is aligned in physical and virtual memory.

> Patch 1 fixes this by
>    using ilog2(CONT_PTES) which evaluates to the optimal order for all
>    page sizes.
> 
> 2. Even with the optimal order, the mmap_miss heuristic in
>    do_sync_mmap_readahead() silently disables exec readahead after 100
>    page faults. The mmap_miss counter tracks whether readahead is useful
>    for mmap'd file access:
> 
>    - Incremented by 1 in do_sync_mmap_readahead() on every page cache
>      miss (page needed IO).
> 
>    - Decremented by N in filemap_map_pages() for N pages successfully
>      mapped via fault-around (pages found in cache without faulting,
>      evidence that readahead was useful). Only non-workingset pages
>      count and recently evicted and re-read pages don't count as hits.
> 
>    - Decremented by 1 in do_async_mmap_readahead() when a PG_readahead
>      marker page is found (indicates sequential consumption of readahead
>      pages).
> 
>    When mmap_miss exceeds MMAP_LOTSAMISS (100), all readahead is
>    disabled. On 64K pages, both decrement paths are inactive:
> 
>    - filemap_map_pages() is never called because fault_around_pages
>      (65536 >> PAGE_SHIFT = 1) disables should_fault_around(), which
>      requires fault_around_pages > 1. With only 1 page in the
>      fault-around window, there is nothing "around" to map.
> 
>    - do_async_mmap_readahead() never fires for exec mappings because
>      exec readahead sets async_size = 0, so no PG_readahead markers
>      are placed.
> 
>    With no decrements, mmap_miss monotonically increases past
>    MMAP_LOTSAMISS after 100 faults, disabling exec readahead
>    for the remainder of the mapping.
>    Patch 2 fixes this by moving the VM_EXEC readahead block
>    above the mmap_miss check, since exec readahead is targeted (one
>    folio at the fault location, async_size=0) not speculative prefetch.

Interesting!

> 
> 3. Even with correct folio order and readahead, contpte mapping requires
>    the virtual address to be aligned to CONT_PTE_SIZE (2M on 64K pages).
>    The readahead path aligns file offsets and the buddy allocator aligns
>    physical memory, but the virtual address depends on the VMA start.
>    For PIE binaries, ASLR randomizes the load address at PAGE_SIZE (64K)
>    granularity, giving only a 1/32 chance of 2M alignment. When
>    misaligned, contpte_set_ptes() never sets the contiguous PTE bit for
>    any folio in the VMA, resulting in zero iTLB coalescing benefit.
> 
>    Patch 3 fixes this for the main binary by bumping the ELF loader's
>    alignment to PAGE_SIZE << exec_folio_order() for ET_DYN binaries.
> 
>    Patch 4 fixes this for shared libraries by adding a contpte-size
>    alignment fallback in thp_get_unmapped_area_vmflags(). The existing
>    PMD_SIZE alignment (512M on 64K pages) is too large for typical shared
>    libraries, so this smaller fallback (2M) succeeds where PMD fails.

I don't see how you can reliably influence this from the kernel? The ELF file
alignment is, by default, 64K (16K on Android) and there is no guarrantee that
the text section is the first section in the file. You need to align the start
of the text section to the 2M boundary and to do that, you'll need to align the
start of the file to some 64K boundary at a specific offset to the 2M boundary,
based on the size of any sections before the text section. That's a job for the
dynamic loader I think? Perhaps I've misunderstood what you're doing...

> 
> I created a benchmark that mmaps a large executable file and calls
> RET-stub functions at PAGE_SIZE offsets across it. "Cold" measures
> fault + readahead cost. "Random" first faults in all pages with a
> sequential sweep (not measured), then measures time for calling random
> offsets, isolating iTLB miss cost for scattered execution.
> 
> The benchmark results on Neoverse V2 (Grace), arm64 with 64K base pages,
> 512MB executable file on ext4, averaged over 3 runs:
> 
>   Phase      | Baseline     | Patched      | Improvement
>   -----------|--------------|--------------|------------------
>   Cold fault | 83.4 ms      | 41.3 ms      | 50% faster
>   Random     | 76.0 ms      | 58.3 ms      | 23% faster

I think the proper way to do this is to link the text section with 2M alignment
and have the dynamic linker mark the region with MADV_HUGEPAGE?

Thanks,
Ryan


> 
> [1] https://lore.kernel.org/all/20250430145920.3748738-6-ryan.roberts@arm.com/
> 
> Usama Arif (4):
>   arm64: request contpte-sized folios for exec memory
>   mm: bypass mmap_miss heuristic for VM_EXEC readahead
>   elf: align ET_DYN base to exec folio order for contpte mapping
>   mm: align file-backed mmap to exec folio order in
>     thp_get_unmapped_area
> 
>  arch/arm64/include/asm/pgtable.h |  9 ++--
>  fs/binfmt_elf.c                  | 15 +++++++
>  mm/filemap.c                     | 72 +++++++++++++++++---------------
>  mm/huge_memory.c                 | 17 ++++++++
>  4 files changed, 75 insertions(+), 38 deletions(-)
> 

